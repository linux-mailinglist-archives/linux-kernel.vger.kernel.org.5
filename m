Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57267B98EC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 01:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243427AbjJDXwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 19:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240836AbjJDXwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 19:52:03 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723D8C0;
        Wed,  4 Oct 2023 16:51:57 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-3515aad4a87so1845575ab.3;
        Wed, 04 Oct 2023 16:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696463517; x=1697068317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MhZXr21KLCmIO4npUIdtZ1N38RyZs2D7b1DH4qFOEtI=;
        b=gFn+9jJcqiAYIFIQ1UqW97yFSQC/uv1GYqbJTgRiihI+G2hW7EiV7uVw/u5LkpKYxW
         zoUGGIMTtKTIuksnDKe4fOmAA200RvGMewb5UrBWOMu0XVKkJM2MFzfRh6tCCYcPWZoi
         8SS8ZSL3Q4Xe9Roctg9yQIQ/WgZ/DckvFj9TRC3y88tVC+OqMrZw7iuMwII0ztF6vd5I
         2Py9tAKffxd5qVZTz3li33+xGnymwziDYiVZgXBzAlgbC5X3X/DbwxPvxModjGmvHU32
         +dIxgu1K5AlpcpCVZRxN+Z0vw5lmLIrbSopLqUNxbU/7a9uhYY88G6Z4LsSFNbgbEGgK
         GIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696463517; x=1697068317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MhZXr21KLCmIO4npUIdtZ1N38RyZs2D7b1DH4qFOEtI=;
        b=XiJFYqOGk/GtmjDa/u7uuwhJ7yxbMkISm51FytNDNvFdUy3kaE/6hVpD2sxlJHpbv0
         nmtT2KLDzEhxzTRhWPBPGhJSfMk88RO1pI1jI1HAVN8Odd0vIwBf3VqWkWYnIcIeti2r
         53MJn0L2C8MXTahPaa+tkDjpq9ZGGCbz615IXR5Sbby1fhKp/ZIf1rYxR1SmuBL371bx
         oDvuloIpcmDNozVnRw22EIN594PP53cnZgj6C1zI1AxXQtXevuyY/7SD2bLBU3ml3JFc
         htH4lKYjX47/3Sbko+1WXev2aCtx+inxpRwWVaif5uSwuIrIJTdIWrS9g1wgl6PdIcb8
         WKVg==
X-Gm-Message-State: AOJu0YxVgoKBsitCVSGtSu/njPWP1QjSrpAtA+A7kncAhUpNHChIQjNs
        01HTjrtqVA1L8gKmFjccu68=
X-Google-Smtp-Source: AGHT+IGq9dGUOQYfzbnsenfy5l9qOqRZu05SHjp8aFayHcJ6ihDL1ycfWedBKeUsSmNBD2xg+ioF/A==
X-Received: by 2002:a05:6e02:118c:b0:351:47fd:e9d4 with SMTP id y12-20020a056e02118c00b0035147fde9d4mr3568332ili.20.1696463516659;
        Wed, 04 Oct 2023 16:51:56 -0700 (PDT)
Received: from aford-System-Version.lan (c-75-72-166-104.hsd1.mn.comcast.net. [75.72.166.104])
        by smtp.gmail.com with ESMTPSA id d12-20020a92680c000000b00350b7a9f0c1sm71032ilc.62.2023.10.04.16.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 16:51:56 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH V3] arm64: dts: imx8mp-beacon: Configure 100MHz PCIe Ref Clk
Date:   Wed,  4 Oct 2023 18:51:47 -0500
Message-Id: <20231004235148.45562-1-aford173@gmail.com>
X-Mailer: git-send-email 2.40.1
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

There is a I2C controlled 100MHz Reference clock used by the PCIe
controller. Configure this clock's DIF1 output to be used by
the PCIe.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
V3:  Update node names, clock-xtal25 and clock-generator per Shawn Guo
V2:  Remove the pcie0_refclk clock that the new one replaces.


diff --git a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
index ee64c6ffb551..0bea0798d2db 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
@@ -23,6 +23,12 @@ chosen {
 		stdout-path = &uart2;
 	};
 
+	clk_xtal25: clock-xtal25 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+	};
+
 	connector {
 		compatible = "usb-c-connector";
 		label = "USB-C";
@@ -118,12 +124,6 @@ led-3 {
 		};
 	};
 
-	pcie0_refclk: clock-pcie {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <100000000>;
-	};
-
 	reg_audio: regulator-wm8962 {
 		compatible = "regulator-fixed";
 		regulator-name = "3v3_aud";
@@ -273,6 +273,13 @@ pca6416_3: gpio@20 {
 		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
+
+	pcieclk: clock-generator@68 {
+		compatible = "renesas,9fgv0241";
+		reg = <0x68>;
+		clocks = <&clk_xtal25>;
+		#clock-cells = <1>;
+	};
 };
 
 &i2c3 {
@@ -408,8 +415,9 @@ &pcie {
 };
 
 &pcie_phy {
+	fsl,clkreq-unsupported;
 	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_INPUT>;
-	clocks = <&pcie0_refclk>;
+	clocks = <&pcieclk 1>;
 	clock-names = "ref";
 	status = "okay";
 };
-- 
2.40.1

