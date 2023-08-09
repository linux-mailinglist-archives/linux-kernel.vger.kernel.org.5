Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A96775039
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 03:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjHIBP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 21:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjHIBPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 21:15:54 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24F4E5E;
        Tue,  8 Aug 2023 18:15:53 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bbd03cb7c1so41476115ad.3;
        Tue, 08 Aug 2023 18:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691543753; x=1692148553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDGT67Q+ic1nejZuLGS46+I/MVwpubEr1pR0ugjy0IU=;
        b=awr0YsovglR+Jd2wnMTzJ9wZrwIlhm5o09UjyNtJVH7JbzocQYlT465++coRkPHpCD
         ztOmH6QEptaiuxNr4nuA+ja4EWblQPW2h6oGs6fqJF66aN/SNHAOQ0pvrApD+RjHbOn/
         KnhB4CfI/487eM5HM4wsD7fZWpt1EUgvl/75KaAXPtHDIpr6e8o2MANh73mQyjJXK5lA
         moxFLenfURIwFhPTYn7/EPk/NPjU5OrYE3qMdNZ9c4Dt6SCOfPcgQXNH4GijyCQOKJMx
         cpc7bji2nBlBQ8oJ6UB2jgvsCqnMYB1Gb0vBRm9wA5W86ek3H+ioCBcIqvtEsk8XmNma
         iT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691543753; x=1692148553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WDGT67Q+ic1nejZuLGS46+I/MVwpubEr1pR0ugjy0IU=;
        b=S4ha4hVuoFsTccltO/u+QntWYkcXyRMgJKwG2N5uexAFg1MVYqqm1HIRsuSCMwX1OF
         BwiUmOtUVm0DsLtuSroYm6j9Z73sasCDZ5Ko4OJE0Pb1BvAH9C0DMNI3i3/xAJjRoNKe
         48nbZ2uqNn4ZrR5jxrfPvdpusPJVsPr2bTCxp1lt0LH10VjU4fUGcHdwzVLgb6czQrfb
         eNSckqUV13ujnzLftnlYBNhy8JuNWkgHf/p+LXPul8tSgxGum/QlgXjusyAUmtlZ395I
         WqY3mDOA1po9JXohu6g09SDcstXvl2QqfmW3pdInFt1iQunlCUMtvC3d0HrVWwr8wQDA
         Ipow==
X-Gm-Message-State: AOJu0YzGzy93re8ETu+7vWfEuR1aYvN09+BAy5iVbz2PkcOBMYrD0S8Q
        YBmR/rmsRRftGhs0bI24+pE=
X-Google-Smtp-Source: AGHT+IGQH7HNY7Iq78cnQi9mP7ucP6QArzO99O5R9IRiNGKy1sSK/tfRzmIS4THliDgyzxklrRxmVg==
X-Received: by 2002:a17:902:d717:b0:1bc:50f9:8f20 with SMTP id w23-20020a170902d71700b001bc50f98f20mr1221753ply.23.1691543753224;
        Tue, 08 Aug 2023 18:15:53 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id t22-20020a1709028c9600b001bc68602e54sm5730449plo.142.2023.08.08.18.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 18:15:52 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        soc@kernel.org, mjchen@nuvoton.com, schung@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: [RESEND PATCH v2 2/3] arm64: dts: nuvoton: Add rtc for ma35d1
Date:   Wed,  9 Aug 2023 01:15:41 +0000
Message-Id: <20230809011542.429945-3-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230809011542.429945-1-ychuang570808@gmail.com>
References: <20230809011542.429945-1-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Huang <ychuang3@nuvoton.com>

Add rtc controller support to the dtsi of ma35d1 SoC and
enable rtc on SOM and IoT boards.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts | 4 ++++
 arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts | 4 ++++
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi         | 8 ++++++++
 3 files changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts b/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
index b89e2be6abae..b3be4331abcf 100644
--- a/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
@@ -54,3 +54,7 @@ &clk {
 			   "integer",
 			   "integer";
 };
+
+&rtc {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts b/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
index a1ebddecb7f8..9858788a589c 100644
--- a/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
@@ -54,3 +54,7 @@ &clk {
 			   "integer",
 			   "integer";
 };
+
+&rtc {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
index 781cdae566a0..394395bfd3ae 100644
--- a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
@@ -95,6 +95,14 @@ clk: clock-controller@40460200 {
 			clocks = <&clk_hxt>;
 		};
 
+		rtc: rtc@40410000 {
+			compatible = "nuvoton,ma35d1-rtc";
+			reg = <0x0 0x40410000 0x0 0x200>;
+			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk RTC_GATE>;
+			status = "disabled";
+		};
+
 		uart0: serial@40700000 {
 			compatible = "nuvoton,ma35d1-uart";
 			reg = <0x0 0x40700000 0x0 0x100>;
-- 
2.34.1

