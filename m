Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A836D7DEAE6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 03:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235523AbjKBCtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 22:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235466AbjKBCtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 22:49:24 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013B813A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 19:49:19 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-694ed847889so502151b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 19:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1698893359; x=1699498159; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=frioRiPhaekRnCE/0ENvI5wkvdspg2jE1Z81EEiVDoc=;
        b=mBRLAmU3c0YOvpdCTCvL7DpCik4cc3bhmdFg+Bt7i2jlLlY6kBIJHQHjyPW3C20Sec
         z/LeT2hl9LfBMxbJgrdW6bnf2gJcpeQHUvfdATYk1mUQNzRUfN8gRStpBQoUkP1wxFyg
         QBNJM7JHn1XADQ6Ueuo+b31TctK4Ub48IbZEhAv7KUFNdV51tMctJGlIFbhFhBjJhqUH
         6+AOW4tQS1Ca0ELHC6RccHso7MapZHYDNbpL10lW44CQuhurpAN59PIO6wDL8CuGCIGI
         /BMfIWhSP4UrQ4ypTAAGWSlCsgvaF6QIgBk6D3mI+ro9MyS13POkL5UwqpO0/R0glEWt
         uTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698893359; x=1699498159;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=frioRiPhaekRnCE/0ENvI5wkvdspg2jE1Z81EEiVDoc=;
        b=L3mxJGyImu9uGgtaEfDKQTZXBGTEYdGAk+hxvi4dKpFW9MXXANn2rvzHf/rmONuvk9
         ft55eB8MuBtKkAEuR5d3IOuf4BmHd64KRHZmNggOIYkwJBSs7v91YU6SymrQVq+DV6Mr
         Cv/21ORh5gnoEbyeABcBIJ2NeGuBzNHdHHxI+s5L280anwIVHcuE2tpZKqAE8UVJlOYN
         OAR1BXk8IiSD7rH7Amvl0BiGRPmPpuZddEG5b0VmQFB0E2Rz39fKz529Uq3ce8k5Ys9s
         L//FDPZAyNL527dTJFLMwwVNZAxs9HT4Mw0QFpLBc/KsrILtBl9wAGsdMYxOEL/37016
         D/Gg==
X-Gm-Message-State: AOJu0YyriRbepyzLH6ddP3b4v3++nhIxfiMAUVBbTLvCHHDRS00wX9zE
        FhdZ9JidGStgU5uohNdxGLvk3g==
X-Google-Smtp-Source: AGHT+IGmGuJJ1mkzEGk8YjnKaLw6xeRQezkEH7j3sN61xb+Q4mvh0F4TOsQumwdOzPdJ/wKXNGt5mQ==
X-Received: by 2002:a05:6a21:3290:b0:17b:129b:1817 with SMTP id yt16-20020a056a21329000b0017b129b1817mr17347005pzb.45.1698893359369;
        Wed, 01 Nov 2023 19:49:19 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:7e4c:4d4e:6943:bc0f])
        by smtp.gmail.com with ESMTPSA id n4-20020a170902e54400b001b850c9d7b3sm1925787plf.249.2023.11.01.19.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 19:49:18 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
Date:   Wed, 01 Nov 2023 19:48:56 -0700
Subject: [PATCH v4 5/7] riscv: dts: thead: Add TH1520 mmc controllers and
 sdhci clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231101-th1520-mmc-v4-5-86e0216b5994@baylibre.com>
References: <20231101-th1520-mmc-v4-0-86e0216b5994@baylibre.com>
In-Reply-To: <20231101-th1520-mmc-v4-0-86e0216b5994@baylibre.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>
Cc:     Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Xi Ruoyao <xry111@xry111.site>, Han Gao <gaohan@iscas.ac.cn>,
        Icenowy Zheng <uwu@icenowy.me>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Drew Fustini <dfustini@baylibre.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698893345; l=1608;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=118IOeI3EDHQnRGvuv5ewuNsGEAnYvxtIZdzQTMEyXk=;
 b=eyKHDo5yqtNJ502x7Fih43LJiwPFfx23Zy+xbTqFt5fKit9A49CnrPno3Mm3ut0CzYLTtYrbA
 /vn+hYssfSJB6Sw6E+5blOk1/IPFdDAfudZiDruEEXAfuKyEA9hPRw1
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add node for the SDHCI fixed clock. Add mmc0 node for the first mmc
controller instance which is typically connected to the eMMC device.
Add mmc1 node for the second mmc controller instance which is typically
connected to microSD slot.

Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index ff364709a6df..f5ec9326c4b8 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -134,6 +134,13 @@ uart_sclk: uart-sclk-clock {
 		#clock-cells = <0>;
 	};
 
+	sdhci_clk: sdhci-clock {
+		compatible = "fixed-clock";
+		clock-frequency = <198000000>;
+		clock-output-names = "sdhci_clk";
+		#clock-cells = <0>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&plic>;
@@ -292,6 +299,22 @@ dmac0: dma-controller@ffefc00000 {
 			status = "disabled";
 		};
 
+		mmc0: mmc@ffe7080000 {
+			compatible = "thead,th1520-dwcmshc";
+			reg = <0xff 0xe7080000 0x0 0x10000>;
+			interrupts = <62 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sdhci_clk>;
+			clock-names = "core";
+		};
+
+		mmc1: mmc@ffe7090000 {
+			compatible = "thead,th1520-dwcmshc";
+			reg = <0xff 0xe7090000 0x0 0x10000>;
+			interrupts = <64 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sdhci_clk>;
+			clock-names = "core";
+		};
+
 		timer0: timer@ffefc32000 {
 			compatible = "snps,dw-apb-timer";
 			reg = <0xff 0xefc32000 0x0 0x14>;

-- 
2.34.1

