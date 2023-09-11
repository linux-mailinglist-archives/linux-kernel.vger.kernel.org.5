Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E358079B814
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359488AbjIKWRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243678AbjIKR3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 13:29:20 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A031B9;
        Mon, 11 Sep 2023 10:29:13 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38BHT3jr117420;
        Mon, 11 Sep 2023 12:29:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694453343;
        bh=SPycI+Uz/iJAyU3N4/P4D2p8LNzzmiX2j6aMQOFsstY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=BMjSIjXlD0wrdyduMan0CN7nMNQFqSzBNYsf84b1PowCOKJDNmXDSEEfx/SlJ2Tm3
         Zty8yAHMN446jFsjhK5EKZHWhljKG4rX1PzD7mtG2uV+7RKgsBj0vgpkVJPcvJeIAr
         l/V2Ye/PWU5mR8x4g1nfI0VJF6/MtX6KPyejH930=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38BHT3UK010080
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Sep 2023 12:29:03 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Sep 2023 12:29:03 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Sep 2023 12:29:03 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38BHT3hI003693;
        Mon, 11 Sep 2023 12:29:03 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Vignesh <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>,
        Tom Rini <trini@konsulko.com>, Bryan <bb@ti.com>,
        Praneeth <praneeth@ti.com>, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 2/3] arm64: dts: ti: k3-am642-evm: Add boot phase tags marking
Date:   Mon, 11 Sep 2023 12:29:01 -0500
Message-ID: <20230911172902.1057417-3-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230911172902.1057417-1-nm@ti.com>
References: <20230911172902.1057417-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bootph-all as phase tag was added to dt-schema
(dtschema/schemas/bootph.yaml) to describe various node usage during
boot phases with DT.

Describe the same for AM642-evm boot devices.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am642-evm.dts | 28 +++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index b4a1f73d4fb1..d0e1191baecd 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -35,6 +35,7 @@ aliases {
 	};
 
 	memory@80000000 {
+		bootph-all;
 		device_type = "memory";
 		/* 2G RAM */
 		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
@@ -108,6 +109,7 @@ rtos_ipc_memory_region: ipc-memories@a5000000 {
 
 	evm_12v0: regulator-0 {
 		/* main DC jack */
+		bootph-all;
 		compatible = "regulator-fixed";
 		regulator-name = "evm_12v0";
 		regulator-min-microvolt = <12000000>;
@@ -129,6 +131,7 @@ vsys_5v0: regulator-1 {
 
 	vsys_3v3: regulator-2 {
 		/* output of LM5140 */
+		bootph-all;
 		compatible = "regulator-fixed";
 		regulator-name = "vsys_3v3";
 		regulator-min-microvolt = <3300000>;
@@ -140,6 +143,7 @@ vsys_3v3: regulator-2 {
 
 	vdd_mmc1: regulator-3 {
 		/* TPS2051BD */
+		bootph-all;
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_mmc1";
 		regulator-min-microvolt = <3300000>;
@@ -161,6 +165,7 @@ vddb: regulator-4 {
 	};
 
 	vtt_supply: regulator-5 {
+		bootph-all;
 		compatible = "regulator-fixed";
 		regulator-name = "vtt";
 		pinctrl-names = "default";
@@ -251,6 +256,7 @@ AM64X_IOPAD(0x0244, PIN_OUTPUT, 0)		/* (E14) UART1_TXD */
 	};
 
 	main_uart0_pins_default: main-uart0-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0238, PIN_INPUT, 0) /* (B16) UART0_CTSn */
 			AM64X_IOPAD(0x023c, PIN_OUTPUT, 0) /* (A16) UART0_RTSn */
@@ -269,6 +275,7 @@ AM64X_IOPAD(0x0218, PIN_INPUT, 0) /* (A14) SPI0_D1 */
 	};
 
 	main_i2c0_pins_default: main-i2c0-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0260, PIN_INPUT_PULLUP, 0) /* (A18) I2C0_SCL */
 			AM64X_IOPAD(0x0264, PIN_INPUT_PULLUP, 0) /* (B18) I2C0_SDA */
@@ -276,6 +283,7 @@ AM64X_IOPAD(0x0264, PIN_INPUT_PULLUP, 0) /* (B18) I2C0_SDA */
 	};
 
 	main_i2c1_pins_default: main-i2c1-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0268, PIN_INPUT_PULLUP, 0) /* (C18) I2C1_SCL */
 			AM64X_IOPAD(0x026c, PIN_INPUT_PULLUP, 0) /* (B19) I2C1_SDA */
@@ -283,6 +291,7 @@ AM64X_IOPAD(0x026c, PIN_INPUT_PULLUP, 0) /* (B19) I2C1_SDA */
 	};
 
 	mdio1_pins_default: mdio1-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x01fc, PIN_OUTPUT, 4) /* (R2) PRG0_PRU1_GPO19.MDIO0_MDC */
 			AM64X_IOPAD(0x01f8, PIN_INPUT, 4) /* (P5) PRG0_PRU1_GPO18.MDIO0_MDIO */
@@ -290,6 +299,7 @@ AM64X_IOPAD(0x01f8, PIN_INPUT, 4) /* (P5) PRG0_PRU1_GPO18.MDIO0_MDIO */
 	};
 
 	rgmii1_pins_default: rgmii1-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x01cc, PIN_INPUT, 4) /* (W5) PRG0_PRU1_GPO7.RGMII1_RD0 */
 			AM64X_IOPAD(0x01d4, PIN_INPUT, 4) /* (Y5) PRG0_PRU1_GPO9.RGMII1_RD1 */
@@ -307,6 +317,7 @@ AM64X_IOPAD(0x00dc, PIN_OUTPUT, 4) /* (U15) PRG1_PRU0_GPO9.RGMII1_TX_CTL */
 	};
 
        rgmii2_pins_default: rgmii2-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0108, PIN_INPUT, 4) /* (W11) PRG1_PRU1_GPO0.RGMII2_RD0 */
 			AM64X_IOPAD(0x010c, PIN_INPUT, 4) /* (V11) PRG1_PRU1_GPO1.RGMII2_RD1 */
@@ -324,6 +335,7 @@ AM64X_IOPAD(0x0144, PIN_OUTPUT, 4) /* (Y11) PRG1_PRU1_GPO15.RGMII2_TX_CTL */
 	};
 
 	main_usb0_pins_default: main-usb0-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x02a8, PIN_OUTPUT, 0) /* (E19) USB0_DRVVBUS */
 		>;
@@ -366,6 +378,7 @@ AM64X_IOPAD(0x0258, PIN_OUTPUT, 0) /* (C17) MCAN1_TX */
 	};
 
 	ddr_vtt_pins_default: ddr-vtt-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0030, PIN_OUTPUT_PULLUP, 7) /* (L18) OSPI0_CSN1.GPIO0_12 */
 		>;
@@ -373,6 +386,7 @@ AM64X_IOPAD(0x0030, PIN_OUTPUT_PULLUP, 7) /* (L18) OSPI0_CSN1.GPIO0_12 */
 };
 
 &main_uart0 {
+	bootph-all;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart0_pins_default>;
@@ -387,6 +401,7 @@ &main_uart1 {
 };
 
 &main_i2c0 {
+	bootph-all;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c0_pins_default>;
@@ -400,12 +415,14 @@ eeprom@50 {
 };
 
 &main_i2c1 {
+	bootph-all;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c1_pins_default>;
 	clock-frequency = <400000>;
 
 	exp1: gpio@22 {
+		bootph-all;
 		compatible = "ti,tca6424";
 		reg = <0x22>;
 		gpio-controller;
@@ -438,6 +455,10 @@ display@3c {
 	};
 };
 
+&main_gpio0 {
+	bootph-all;
+};
+
 /* mcu_gpio0 is reserved for mcu firmware usage */
 &mcu_gpio0 {
 	status = "reserved";
@@ -467,6 +488,7 @@ &sdhci0 {
 
 &sdhci1 {
 	/* SD/MMC */
+	bootph-all;
 	vmmc-supply = <&vdd_mmc1>;
 	pinctrl-names = "default";
 	bus-width = <4>;
@@ -476,11 +498,13 @@ &sdhci1 {
 };
 
 &usbss0 {
+	bootph-all;
 	ti,vbus-divider;
 	ti,usb2-only;
 };
 
 &usb0 {
+	bootph-all;
 	dr_mode = "otg";
 	maximum-speed = "high-speed";
 	pinctrl-names = "default";
@@ -488,11 +512,13 @@ &usb0 {
 };
 
 &cpsw3g {
+	bootph-all;
 	pinctrl-names = "default";
 	pinctrl-0 = <&rgmii1_pins_default>, <&rgmii2_pins_default>;
 };
 
 &cpsw_port1 {
+	bootph-all;
 	phy-mode = "rgmii-rxid";
 	phy-handle = <&cpsw3g_phy0>;
 };
@@ -503,11 +529,13 @@ &cpsw_port2 {
 };
 
 &cpsw3g_mdio {
+	bootph-all;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mdio1_pins_default>;
 
 	cpsw3g_phy0: ethernet-phy@0 {
+		bootph-all;
 		reg = <0>;
 		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
 		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
-- 
2.40.0

