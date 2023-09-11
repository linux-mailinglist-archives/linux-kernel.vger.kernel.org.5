Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292B579ADCB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbjIKVDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242855AbjIKQZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 12:25:56 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B91CCD;
        Mon, 11 Sep 2023 09:25:51 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38BGPf1i083445;
        Mon, 11 Sep 2023 11:25:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694449541;
        bh=Gtm+mXYPgVZpSSr81aO2pE+EKYHz4E/w2OpQOzWOZcM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=A5W/b+gvN9KQcwL1orGCS1aewxzHCvneQfgW/OBylG6YpOwZerCNq88ntYJiKd71R
         ah5pnNEJz81t1+DwAvZglKNulozugTs2dSKdtlziqTB/JjibGd8VxX+xbzaDdspTC+
         auGFp+mCtJ9r4diITGtP444Xa+NIGwj6gt15LN6Q=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38BGPewQ022099
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Sep 2023 11:25:40 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Sep 2023 11:25:40 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Sep 2023 11:25:40 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38BGPe8F012544;
        Mon, 11 Sep 2023 11:25:40 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Vignesh <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>,
        Tom Rini <trini@konsulko.com>, Bryan <bb@ti.com>,
        Praneeth <praneeth@ti.com>,
        Robert Nelson <robertcnelson@gmail.com>
Subject: [PATCH 2/3] arm64: dts: ti: k3-am625-beagleplay: Add boot phase tags marking
Date:   Mon, 11 Sep 2023 11:25:34 -0500
Message-ID: <20230911162535.1044560-3-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230911162535.1044560-1-nm@ti.com>
References: <20230911162535.1044560-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bootph-all as phase tag was added to dt-schema
(dtschema/schemas/bootph.yaml) to describe various node usage during
boot phases with DT.

Describe the same for beagleplay boot devices.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 .../arm64/boot/dts/ti/k3-am625-beagleplay.dts | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
index 7cfdf562b53b..f646d1ec4c05 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
@@ -46,6 +46,7 @@ chosen {
 	};
 
 	memory@80000000 {
+		bootph-pre-ram;
 		device_type = "memory";
 		/* 2G RAM */
 		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
@@ -83,6 +84,7 @@ wkup_r5fss0_core0_dma_memory_region: r5f-dma-memory@9db00000 {
 	};
 
 	vsys_5v0: regulator-1 {
+		bootph-all;
 		compatible = "regulator-fixed";
 		regulator-name = "vsys_5v0";
 		regulator-min-microvolt = <5000000>;
@@ -93,6 +95,7 @@ vsys_5v0: regulator-1 {
 
 	vdd_3v3: regulator-2 {
 		/* output of TLV62595DMQR-U12 */
+		bootph-all;
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_3v3";
 		regulator-min-microvolt = <3300000>;
@@ -118,6 +121,7 @@ wlan_en: regulator-3 {
 
 	vdd_3v3_sd: regulator-4 {
 		/* output of TPS22918DBVR-U21 */
+		bootph-all;
 		pinctrl-names = "default";
 		pinctrl-0 = <&vdd_3v3_sd_pins_default>;
 
@@ -132,6 +136,7 @@ vdd_3v3_sd: regulator-4 {
 	};
 
 	vdd_sd_dv: regulator-5 {
+		bootph-all;
 		compatible = "regulator-gpio";
 		regulator-name = "sd_hs200_switch";
 		pinctrl-names = "default";
@@ -146,9 +151,11 @@ vdd_sd_dv: regulator-5 {
 	};
 
 	leds {
+		bootph-all;
 		compatible = "gpio-leds";
 
 		led-0 {
+			bootph-all;
 			gpios = <&main_gpio0 3 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 			function = LED_FUNCTION_HEARTBEAT;
@@ -156,6 +163,7 @@ led-0 {
 		};
 
 		led-1 {
+			bootph-all;
 			gpios = <&main_gpio0 4 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "disk-activity";
 			function = LED_FUNCTION_DISK_ACTIVITY;
@@ -163,16 +171,19 @@ led-1 {
 		};
 
 		led-2 {
+			bootph-all;
 			gpios = <&main_gpio0 5 GPIO_ACTIVE_HIGH>;
 			function = LED_FUNCTION_CPU;
 		};
 
 		led-3 {
+			bootph-all;
 			gpios = <&main_gpio0 6 GPIO_ACTIVE_HIGH>;
 			function = LED_FUNCTION_LAN;
 		};
 
 		led-4 {
+			bootph-all;
 			gpios = <&main_gpio0 9 GPIO_ACTIVE_HIGH>;
 			function = LED_FUNCTION_WLAN;
 		};
@@ -245,6 +256,7 @@ cpsw3g_phy1: ethernet-phy@1 {
 
 &main_pmx0 {
 	gpio0_pins_default: gpio0-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x0004, PIN_INPUT, 7) /* (G25) OSPI0_LBCLKO.GPIO0_1 */
 			AM62X_IOPAD(0x0008, PIN_INPUT, 7) /* (J24) OSPI0_DQS.GPIO0_2 */
@@ -264,6 +276,7 @@ AM62X_IOPAD(0x00ac, PIN_INPUT, 7) /* (L21) GPMC0_CSn1.GPIO0_42 */
 	};
 
 	vdd_sd_dv_pins_default: vdd-sd-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x0244, PIN_OUTPUT, 7) /* (C17) MMC1_SDWP.GPIO1_49 */
 		>;
@@ -283,6 +296,7 @@ AM62X_IOPAD(0x01ec, PIN_INPUT_PULLUP, 0) /* (A17) I2C1_SDA */
 	};
 
 	local_i2c_pins_default: local-i2c-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x01e0, PIN_INPUT_PULLUP, 0) /* (B16) I2C0_SCL */
 			AM62X_IOPAD(0x01e4, PIN_INPUT_PULLUP, 0) /* (A16) I2C0_SDA */
@@ -321,6 +335,7 @@ AM62X_IOPAD(0x012c, PIN_OUTPUT, 0) /* (AD19) RGMII1_TX_CTL */
 	};
 
 	emmc_pins_default: emmc-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x0220, PIN_INPUT, 0) /* (Y3) MMC0_CMD */
 			AM62X_IOPAD(0x0218, PIN_INPUT, 0) /* (AB1) MMC0_CLK */
@@ -336,12 +351,14 @@ AM62X_IOPAD(0x01f8, PIN_INPUT, 0) /* (AC2) MMC0_DAT7 */
 	};
 
 	vdd_3v3_sd_pins_default: vdd-3v3-sd-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x01c4, PIN_INPUT, 7) /* (B14) SPI0_D1_GPIO1_19 */
 		>;
 	};
 
 	sd_pins_default: sd-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x023c, PIN_INPUT, 0) /* (A21) MMC1_CMD */
 			AM62X_IOPAD(0x0234, PIN_INPUT, 0) /* (B22) MMC1_CLK */
@@ -418,6 +435,7 @@ AM62X_IOPAD(0x0198, PIN_INPUT, 1) /* (A19) MCASP0_AXR2.SPI2_D1 */
 	};
 
 	mikrobus_gpio_pins_default: mikrobus-gpio-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x019c, PIN_INPUT, 7) /* (B18) MCASP0_AXR1.GPIO1_9 */
 			AM62X_IOPAD(0x01a0, PIN_INPUT, 7) /* (E18) MCASP0_AXR0.GPIO1_10 */
@@ -426,6 +444,7 @@ AM62X_IOPAD(0x01a8, PIN_INPUT, 7) /* (D20) MCASP0_AFSX.GPIO1_12 */
 	};
 
 	console_pins_default: console-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x01c8, PIN_INPUT, 0) /* (D14) UART0_RXD */
 			AM62X_IOPAD(0x01cc, PIN_OUTPUT, 0) /* (E14) UART0_TXD */
@@ -597,6 +616,7 @@ &cpsw3g_mdio {
 };
 
 &main_gpio0 {
+	bootph-all;
 	pinctrl-names = "default";
 	pinctrl-0 = <&gpio0_pins_default>;
 	gpio-line-names = "BL_EN_3V3", "SPE_PO_EN", "RTC_INT",	/* 0-2 */
@@ -616,6 +636,7 @@ &main_gpio0 {
 };
 
 &main_gpio1 {
+	bootph-all;
 	pinctrl-names = "default";
 	pinctrl-0 = <&mikrobus_gpio_pins_default>;
 	gpio-line-names = "", "", "", "", "",			/* 0-4 */
@@ -633,6 +654,7 @@ &main_gpio1 {
 };
 
 &main_i2c0 {
+	bootph-all;
 	pinctrl-names = "default";
 	pinctrl-0 = <&local_i2c_pins_default>;
 	clock-frequency = <400000>;
@@ -651,6 +673,7 @@ rtc: rtc@68 {
 	};
 
 	tps65219: pmic@30 {
+		bootph-all;
 		compatible = "ti,tps65219";
 		reg = <0x30>;
 		buck1-supply = <&vsys_5v0>;
@@ -801,6 +824,7 @@ &main_spi2 {
 };
 
 &sdhci0 {
+	bootph-all;
 	pinctrl-names = "default";
 	pinctrl-0 = <&emmc_pins_default>;
 	ti,driver-strength-ohm = <50>;
@@ -810,6 +834,7 @@ &sdhci0 {
 
 &sdhci1 {
 	/* SD/MMC */
+	bootph-all;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd_pins_default>;
 
@@ -850,6 +875,7 @@ wlcore: wlcore@2 {
 };
 
 &main_uart0 {
+	bootph-all;
 	pinctrl-names = "default";
 	pinctrl-0 = <&console_pins_default>;
 	status = "okay";
-- 
2.40.0

