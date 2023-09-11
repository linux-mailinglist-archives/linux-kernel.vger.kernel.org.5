Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85E279AB5B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 22:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjIKUr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243674AbjIKR3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 13:29:19 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9688A1B8;
        Mon, 11 Sep 2023 10:29:13 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38BHT3S2082647;
        Mon, 11 Sep 2023 12:29:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694453343;
        bh=zYbvlwlqpdkH7AHypaKO+ITyBI7h08zk6qLS0nV8mF8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=GBDUilr+7bI2+WmgkiGpy5vQ2iLwUH7f3BWP+BLls6aD6qHgwtoekmMrLYs/80g6E
         fJe7xQT52l3hFIFgmu4nPgrC6yQtSMaqy2NGjXVDxxOI8cBx7SKKIQk4cu8UhXtSpa
         ucqu4GBGNrxXqntWN3BKEbRH7w0M4PswIR9QBaVg=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38BHT3GP062004
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Sep 2023 12:29:03 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Sep 2023 12:29:03 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Sep 2023 12:29:03 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38BHT3uf007969;
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
Subject: [PATCH 3/3] arm64: dts: ti: k3-am642-sk: Add boot phase tags marking
Date:   Mon, 11 Sep 2023 12:29:02 -0500
Message-ID: <20230911172902.1057417-4-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230911172902.1057417-1-nm@ti.com>
References: <20230911172902.1057417-1-nm@ti.com>
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

Describe the same for AM642-sk boot devices.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am642-sk.dts | 29 ++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 722fd285a34e..f29c8a9b59ba 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -34,6 +34,7 @@ aliases {
 	};
 
 	memory@80000000 {
+		bootph-pre-ram;
 		device_type = "memory";
 		/* 2G RAM */
 		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
@@ -107,6 +108,7 @@ rtos_ipc_memory_region: ipc-memories@a5000000 {
 
 	vusb_main: regulator-0 {
 		/* USB MAIN INPUT 5V DC */
+		bootph-all;
 		compatible = "regulator-fixed";
 		regulator-name = "vusb_main5v0";
 		regulator-min-microvolt = <5000000>;
@@ -117,6 +119,7 @@ vusb_main: regulator-0 {
 
 	vcc_3v3_sys: regulator-1 {
 		/* output of LP8733xx */
+		bootph-all;
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_3v3_sys";
 		regulator-min-microvolt = <3300000>;
@@ -128,6 +131,7 @@ vcc_3v3_sys: regulator-1 {
 
 	vdd_mmc1: regulator-2 {
 		/* TPS2051BD */
+		bootph-all;
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_mmc1";
 		regulator-min-microvolt = <3300000>;
@@ -234,6 +238,7 @@ led-7 {
 
 &main_pmx0 {
 	main_mmc1_pins_default: main-mmc1-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x029c, PIN_INPUT_PULLUP, 0) /* (C20) MMC1_SDWP */
 			AM64X_IOPAD(0x0298, PIN_INPUT_PULLUP, 0) /* (D19) MMC1_SDCD */
@@ -248,6 +253,7 @@ AM64X_IOPAD(0x027c, PIN_INPUT_PULLUP, 0) /* (K18) MMC1_DAT3 */
 	};
 
 	main_uart0_pins_default: main-uart0-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0238, PIN_INPUT, 0) /* (B16) UART0_CTSn */
 			AM64X_IOPAD(0x023c, PIN_OUTPUT, 0) /* (A16) UART0_RTSn */
@@ -257,6 +263,7 @@ AM64X_IOPAD(0x0234, PIN_OUTPUT, 0) /* (C16) UART0_TXD */
 	};
 
 	main_uart1_pins_default: main-uart1-default-pins {
+		bootph-pre-ram;
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0248, PIN_INPUT, 0) /* (D16) UART1_CTSn */
 			AM64X_IOPAD(0x024c, PIN_OUTPUT, 0) /* (E16) UART1_RTSn */
@@ -266,12 +273,14 @@ AM64X_IOPAD(0x0244, PIN_OUTPUT, 0) /* (E14) UART1_TXD */
 	};
 
 	main_usb0_pins_default: main-usb0-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x02a8, PIN_OUTPUT, 0) /* (E19) USB0_DRVVBUS */
 		>;
 	};
 
 	main_i2c0_pins_default: main-i2c0-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0260, PIN_INPUT_PULLUP, 0) /* (A18) I2C0_SCL */
 			AM64X_IOPAD(0x0264, PIN_INPUT_PULLUP, 0) /* (B18) I2C0_SDA */
@@ -279,6 +288,7 @@ AM64X_IOPAD(0x0264, PIN_INPUT_PULLUP, 0) /* (B18) I2C0_SDA */
 	};
 
 	main_i2c1_pins_default: main-i2c1-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0268, PIN_INPUT_PULLUP, 0) /* (C18) I2C1_SCL */
 			AM64X_IOPAD(0x026c, PIN_INPUT_PULLUP, 0) /* (B19) I2C1_SDA */
@@ -367,6 +377,7 @@ AM64X_IOPAD(0x00bc, PIN_INPUT, 7) /* (U8) GPIO0_46 */
 };
 
 &main_uart0 {
+	bootph-all;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart0_pins_default>;
@@ -375,12 +386,14 @@ &main_uart0 {
 
 &main_uart1 {
 	/* main_uart1 is reserved for firmware usage */
+	bootph-pre-ram;
 	status = "reserved";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart1_pins_default>;
 };
 
 &main_i2c0 {
+	bootph-all;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c0_pins_default>;
@@ -393,12 +406,14 @@ eeprom@51 {
 };
 
 &main_i2c1 {
+	bootph-all;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c1_pins_default>;
 	clock-frequency = <400000>;
 
 	exp1: gpio@70 {
+		bootph-all;
 		compatible = "nxp,pca9538";
 		reg = <0x70>;
 		gpio-controller;
@@ -445,6 +460,7 @@ wlcore: wlcore@2 {
 
 &sdhci1 {
 	/* SD/MMC */
+	bootph-all;
 	vmmc-supply = <&vdd_mmc1>;
 	pinctrl-names = "default";
 	bus-width = <4>;
@@ -454,11 +470,22 @@ &sdhci1 {
 };
 
 &serdes_ln_ctrl {
+	bootph-all;
 	idle-states = <AM64_SERDES0_LANE0_USB>;
 };
 
+&serdes_refclk {
+	bootph-all;
+};
+
+&serdes_wiz0 {
+	bootph-all;
+};
+
 &serdes0 {
+	bootph-all;
 	serdes0_usb_link: phy@0 {
+		bootph-all;
 		reg = <0>;
 		cdns,num-lanes = <1>;
 		#phy-cells = <0>;
@@ -468,10 +495,12 @@ serdes0_usb_link: phy@0 {
 };
 
 &usbss0 {
+	bootph-all;
 	ti,vbus-divider;
 };
 
 &usb0 {
+	bootph-all;
 	dr_mode = "host";
 	maximum-speed = "super-speed";
 	pinctrl-names = "default";
-- 
2.40.0

