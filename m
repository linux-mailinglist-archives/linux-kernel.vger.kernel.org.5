Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1592180730E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442355AbjLFOo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442167AbjLFOos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:44:48 -0500
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3581A10FF;
        Wed,  6 Dec 2023 06:44:44 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BEADCC0131;
        Wed,  6 Dec 2023 15:44:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1701873882; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=3Yd/dhTIQX+6qNHj+D/jIQXXO34y08h1WfgywDqS/fc=;
        b=wGVrRJRLThsCcqPt0XUEPRc96dXb7M2T6Pjo1t9o1oocl3HtsKs+IWh4nfM/hhltawot3A
        pEIOxMKokx6A08kTukQD326u2qqyw5P6sVSCr4YO+G4ug9uzGG19VsWe50T7xyUuHtXqZQ
        WPedxVvMZUlNe+UNTUk3HuRGX4C+WH7U3G/uj3yvx+mM1hhis9pJuFttf1sOUAh/emjc/Q
        v40fKm5ZZS90ki0ydY8cSpwQtAyPcn4pYyS4At2ZDbWZ3FE8qd6TUuUB7C7iaYFf26DnLq
        cx/ySjpPSp3G2aJLstLFLhQHO2tTydrhFXWIXZcL3yy2lLTn5w7Azzi6qgDv2Q==
From:   Frieder Schrempf <frieder@fris.de>
To:     Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v3 10/14] arm64: dts: imx8mm-kontron: Fix OSM-S devicetrees to match latest hardware
Date:   Wed,  6 Dec 2023 15:41:13 +0100
Message-ID: <20231206144201.46911-11-frieder@fris.de>
In-Reply-To: <20231206144201.46911-1-frieder@fris.de>
References: <20231206144201.46911-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The current state of the devicetree for the i.MX8MM OSM-S and the BL
baseboard reflects deprecated prototype hardware. Update the board
description to match the latest hardware revision.

As the old hardware is not available anymore, was only produced in
very small quantities and was broken in some ways, we can safely
fixup the original devicetree.

Fixes: de9618e84f76 ("arm64: dts: Add support for Kontron SL/BL i.MX8MM OSM-S")
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes for v3:
* none

Changes for v2:
* none
---
 .../dts/freescale/imx8mm-kontron-bl-osm-s.dts | 64 ++++++++++++-------
 1 file changed, 41 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts
index d9fa0deea7002..7c5586efccc59 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts
@@ -30,18 +30,18 @@ leds {
 
 		led1 {
 			label = "led1";
-			gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "heartbeat";
 		};
 
 		led2 {
 			label = "led2";
-			gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio3 8 GPIO_ACTIVE_LOW>;
 		};
 
 		led3 {
 			label = "led3";
-			gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio3 7 GPIO_ACTIVE_LOW>;
 		};
 	};
 
@@ -54,7 +54,7 @@ reg_rst_eth2: regulator-rst-eth2 {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_usb_eth2>;
-		gpio = <&gpio3 2 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio1 1 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 		regulator-always-on;
 		regulator-name = "rst-usb-eth2";
@@ -91,7 +91,7 @@ can@0 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_can>;
 		clocks = <&osc_can>;
-		interrupts-extended = <&gpio4 28 IRQ_TYPE_LEVEL_LOW>;
+		interrupts-extended = <&gpio5 1 IRQ_TYPE_LEVEL_LOW>;
 		/*
 		 * Limit the SPI clock to 15 MHz to prevent issues
 		 * with corrupted data due to chip errata.
@@ -118,7 +118,7 @@ eeram@0 {
 &fec1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
-	phy-connection-type = "rgmii-rxid";
+	phy-connection-type = "rgmii-id";
 	phy-handle = <&ethphy>;
 	status = "okay";
 
@@ -127,10 +127,11 @@ mdio {
 		#size-cells = <0>;
 
 		ethphy: ethernet-phy@0 {
+			compatible = "ethernet-phy-id4f51.e91b",
+				     "ethernet-phy-ieee802.3-c22";
 			reg = <0>;
-			reset-assert-us = <1>;
-			reset-deassert-us = <15000>;
-			reset-gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <10000>;
+			reset-gpios = <&gpio1 3 GPIO_ACTIVE_LOW>;
 		};
 	};
 };
@@ -153,11 +154,24 @@ &gpio5 {
 			  "", "", "", "", "", "", "", "";
 };
 
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+
+	usb-hub@2c {
+		compatible = "microchip,usb2514b";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usb_hub>;
+		reg = <0x2c>;
+		non-removable-ports = <0>, <3>;
+		reset-gpios = <&gpio5 2 GPIO_ACTIVE_LOW>;
+	};
+};
+
 &i2c4 {
-	clock-frequency = <100000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c4>;
-	status = "okay";
 };
 
 &pwm2 {
@@ -196,13 +210,13 @@ &usbotg2 {
 	status = "okay";
 
 	usb1@1 {
-		compatible = "usb424,9514";
+		compatible = "usb424,2514";
 		reg = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 
 		usbnet: ethernet@1 {
-			compatible = "usb424,ec00";
+			compatible = "usbb95,772b";
 			reg = <1>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 		};
@@ -223,7 +237,7 @@ &usdhc2 {
 &iomuxc {
 	pinctrl_can: cangrp {
 		fsl,pins = <
-			MX8MM_IOMUXC_SAI3_RXFS_GPIO4_IO28		0x19
+			MX8MM_IOMUXC_SAI3_TXD_GPIO5_IO1			0x19
 		>;
 	};
 
@@ -261,27 +275,24 @@ MX8MM_IOMUXC_ENET_TXC_ENET1_RGMII_TXC		0x1f
 			MX8MM_IOMUXC_ENET_RXC_ENET1_RGMII_RXC		0x91
 			MX8MM_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91
 			MX8MM_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f
-			MX8MM_IOMUXC_GPIO1_IO01_GPIO1_IO1		0x19 /* PHY RST */
-			MX8MM_IOMUXC_GPIO1_IO05_GPIO1_IO5		0x19 /* ETH IRQ */
+			MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3		0x19 /* PHY RST */
 		>;
 	};
 
 	pinctrl_gpio_led: gpioledgrp {
 		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO12_GPIO1_IO12		0x19
-			MX8MM_IOMUXC_GPIO1_IO13_GPIO1_IO13		0x19
-			MX8MM_IOMUXC_GPIO1_IO14_GPIO1_IO14		0x19
+			MX8MM_IOMUXC_GPIO1_IO05_GPIO1_IO5		0x19
+			MX8MM_IOMUXC_GPIO1_IO07_GPIO1_IO7		0x19
+			MX8MM_IOMUXC_GPIO1_IO08_GPIO1_IO8		0x19
 		>;
 	};
 
 	pinctrl_gpio1: gpio1grp {
 		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3		0x19
-			MX8MM_IOMUXC_GPIO1_IO07_GPIO1_IO7		0x19
+			MX8MM_IOMUXC_GPIO1_IO01_GPIO1_IO1		0x19
 			MX8MM_IOMUXC_GPIO1_IO09_GPIO1_IO9		0x19
 			MX8MM_IOMUXC_GPIO1_IO11_GPIO1_IO11		0x19
 			MX8MM_IOMUXC_GPIO1_IO06_GPIO1_IO6		0x19
-			MX8MM_IOMUXC_GPIO1_IO08_GPIO1_IO8		0x19
 			MX8MM_IOMUXC_GPIO1_IO10_GPIO1_IO10		0x19
 		>;
 	};
@@ -292,6 +303,13 @@ MX8MM_IOMUXC_SAI3_MCLK_GPIO5_IO2		0x19
 		>;
 	};
 
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C3_SCL_I2C3_SCL			0x40000083
+			MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA			0x40000083
+		>;
+	};
+
 	pinctrl_i2c4: i2c4grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL			0x40000083
@@ -331,7 +349,7 @@ MX8MM_IOMUXC_SAI3_RXC_UART2_DCE_CTS_B		0x0
 
 	pinctrl_usb_eth2: usbeth2grp {
 		fsl,pins = <
-			MX8MM_IOMUXC_NAND_CE1_B_GPIO3_IO2		0x19
+			MX8MM_IOMUXC_GPIO1_IO01_GPIO1_IO1		0x19
 		>;
 	};
 
-- 
2.43.0

