Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B62767FAA
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 15:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjG2Np3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 09:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjG2NpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 09:45:10 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8597A3C25;
        Sat, 29 Jul 2023 06:44:39 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6862842a028so2196692b3a.0;
        Sat, 29 Jul 2023 06:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690638257; x=1691243057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aVxdahUDTVUV9cnCong5ALNb8MGVSHjMtdO+s1Vu6ec=;
        b=F0oGyLjjQDV2mzhsnVakknVvo2dF+BJbln//msV6dmlYIGbjY7Qw3nx/1esZ5WxLjR
         5WtEYem/W6W1pNXV2Vl4bVui0HTc0QxxxuSjheAQEeCo50wIGnaH1+vT6R7S2axI4MJw
         awKo+ODPhNqDTad2c0baZyinm2fn0JS0lRJDKpOZ8BkEJuLV4Vi9w9WFeR34h2WVEymW
         r71MvLeo2/410nLzh0pTy2aQ7HhYw2FmmsJA6ucyqXXyBFnUmY9AorzZboOhANBghYYH
         qVPeQ9bv1aYMRH3K7okLBS/wHlqZwgmzIaay6Y6TPcZFII2ECSKwtjiteoe+dC3XAEXG
         9bXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690638257; x=1691243057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aVxdahUDTVUV9cnCong5ALNb8MGVSHjMtdO+s1Vu6ec=;
        b=QvKld9GW0Fdgsq/SjDxLGA0n+/q/z4CQbLXWIOsvck5nIiXE+0uUU7D1PLPlGmfKlQ
         QUtvpgVaLnMgSfDvxpKBxCCrgDGcE3sZ55Vdqyqo+Z93S0zdVBl/NLRaLlgl8COwcP/M
         GI7a7yHqajn52h1tbfoJ3lFB3HPPGTUPM5DEATB/QXk4ZmoK0MoIXdFLrXM66I0a9Khx
         tHOW0g9xOx5h4EqX1nB0MeZgQUN9A+PA96Q3BNFUOry437uFL780sYdZOYPqK69rglBw
         syrYvEAFhMQhlz/REbRgcDgSABJ5UyAIFqKechoLjQTLbMrFQoSPILfXIMbif6ZiDtO4
         KqQA==
X-Gm-Message-State: ABy/qLbd/SKhz65jspCwD+LCuuYjrBSTZnKikFg+B9o/1So+uPFf+FX1
        1xgysN6rgBAouQBVKwGO6tG+GDsxC6Y5zg==
X-Google-Smtp-Source: APBJJlHqgcVVS3ZcP2ZTC6tZNwaAHiwKp1t2rtReiOqe5meC6skDTu6eWyMBY8D2wM3NxhswmhaMCg==
X-Received: by 2002:a05:6a20:8e2a:b0:137:4bff:7c92 with SMTP id y42-20020a056a208e2a00b001374bff7c92mr5149206pzj.0.1690638256829;
        Sat, 29 Jul 2023 06:44:16 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. ([38.114.108.131])
        by smtp.gmail.com with ESMTPSA id x13-20020aa793ad000000b006871bea2eeesm1257166pff.34.2023.07.29.06.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 06:44:16 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH 13/17] MIPS: loongson32: Convert watchdog platform device to DT
Date:   Sat, 29 Jul 2023 21:43:14 +0800
Message-Id: <20230729134318.1694467-14-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230729134318.1694467-1-keguang.zhang@gmail.com>
References: <20230729134318.1694467-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add watchdog device node for Loongson-1 boards,
and drop the legacy platform device and data accordingly.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 arch/mips/boot/dts/loongson/loongson1b.dtsi   |  9 +++++++++
 arch/mips/boot/dts/loongson/loongson1c.dtsi   |  9 +++++++++
 arch/mips/boot/dts/loongson/lsgz_1b_dev.dts   |  4 ++++
 arch/mips/boot/dts/loongson/smartloong_1c.dts |  4 ++++
 arch/mips/loongson32/common/platform.c        | 16 ----------------
 arch/mips/loongson32/ls1b/board.c             |  1 -
 arch/mips/loongson32/ls1c/board.c             |  1 -
 7 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/arch/mips/boot/dts/loongson/loongson1b.dtsi b/arch/mips/boot/dts/loongson/loongson1b.dtsi
index 935e559016d6..d7f5cebae0a9 100644
--- a/arch/mips/boot/dts/loongson/loongson1b.dtsi
+++ b/arch/mips/boot/dts/loongson/loongson1b.dtsi
@@ -133,6 +133,15 @@ phy1: ethernet-phy@0 {
 };
 
 &apb {
+	watchdog: watchdog@1fe5c060 {
+		compatible = "loongson,ls1b-wdt";
+		reg = <0x1fe5c060 0xc>;
+
+		clocks = <&clkc LS1X_CLKID_APB>;
+
+		status = "disabled";
+	};
+
 	rtc: rtc@1fe64000 {
 		compatible = "loongson,ls1b-rtc";
 		reg = <0x1fe64000 0x78>;
diff --git a/arch/mips/boot/dts/loongson/loongson1c.dtsi b/arch/mips/boot/dts/loongson/loongson1c.dtsi
index f68bef1f65d3..ac1b311b0622 100644
--- a/arch/mips/boot/dts/loongson/loongson1c.dtsi
+++ b/arch/mips/boot/dts/loongson/loongson1c.dtsi
@@ -89,6 +89,15 @@ ohci0: usb@1fe28000 {
 };
 
 &apb {
+	watchdog: watchdog@1fe5c060 {
+		compatible = "loongson,ls1c-wdt";
+		reg = <0x1fe5c060 0xc>;
+
+		clocks = <&clkc LS1X_CLKID_APB>;
+
+		status = "disabled";
+	};
+
 	rtc: rtc@1fe64000 {
 		compatible = "loongson,ls1c-rtc";
 		reg = <0x1fe64000 0x78>;
diff --git a/arch/mips/boot/dts/loongson/lsgz_1b_dev.dts b/arch/mips/boot/dts/loongson/lsgz_1b_dev.dts
index d3988d789c0f..01152807a13f 100644
--- a/arch/mips/boot/dts/loongson/lsgz_1b_dev.dts
+++ b/arch/mips/boot/dts/loongson/lsgz_1b_dev.dts
@@ -82,3 +82,7 @@ &uart2 {
 &uart3 {
 	status = "okay";
 };
+
+&watchdog {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/loongson/smartloong_1c.dts b/arch/mips/boot/dts/loongson/smartloong_1c.dts
index 1b7741dcb87f..2360be8942d6 100644
--- a/arch/mips/boot/dts/loongson/smartloong_1c.dts
+++ b/arch/mips/boot/dts/loongson/smartloong_1c.dts
@@ -78,3 +78,7 @@ &uart2 {
 &uart3 {
 	status = "okay";
 };
+
+&watchdog {
+	status = "okay";
+};
diff --git a/arch/mips/loongson32/common/platform.c b/arch/mips/loongson32/common/platform.c
index 7d0120fe9a5b..9783c34f39b4 100644
--- a/arch/mips/loongson32/common/platform.c
+++ b/arch/mips/loongson32/common/platform.c
@@ -15,19 +15,3 @@
 #include <dma.h>
 #include <nand.h>
 #include <irq.h>
-
-/* Watchdog */
-static struct resource ls1x_wdt_resources[] = {
-	{
-		.start	= LS1X_WDT_BASE,
-		.end	= LS1X_WDT_BASE + SZ_16 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-struct platform_device ls1x_wdt_pdev = {
-	.name		= "ls1x-wdt",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(ls1x_wdt_resources),
-	.resource	= ls1x_wdt_resources,
-};
diff --git a/arch/mips/loongson32/ls1b/board.c b/arch/mips/loongson32/ls1b/board.c
index 59c70c7ffe1a..ff28f44fa687 100644
--- a/arch/mips/loongson32/ls1b/board.c
+++ b/arch/mips/loongson32/ls1b/board.c
@@ -13,7 +13,6 @@
 #include <platform.h>
 
 static struct platform_device *ls1b_platform_devices[] __initdata = {
-	&ls1x_wdt_pdev,
 };
 
 static int __init ls1b_platform_init(void)
diff --git a/arch/mips/loongson32/ls1c/board.c b/arch/mips/loongson32/ls1c/board.c
index 4c2d44f9f6f2..e0b0eb94077e 100644
--- a/arch/mips/loongson32/ls1c/board.c
+++ b/arch/mips/loongson32/ls1c/board.c
@@ -6,7 +6,6 @@
 #include <platform.h>
 
 static struct platform_device *ls1c_platform_devices[] __initdata = {
-	&ls1x_wdt_pdev,
 };
 
 static int __init ls1c_platform_init(void)
-- 
2.39.2

