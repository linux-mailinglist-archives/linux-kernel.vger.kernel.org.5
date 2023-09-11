Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2B279ACEB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238096AbjIKVaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242854AbjIKQZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 12:25:55 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E94CC3;
        Mon, 11 Sep 2023 09:25:50 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38BGPfRZ080864;
        Mon, 11 Sep 2023 11:25:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694449541;
        bh=4EVgKzgPc050aVJVwL7z50ZmTH52CC1RhdLxWJRyLfY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=GxOF+fhT6mfq4/GvpuLanlkUEF8P7HTW+TtwraGGc38nY+sATQ+iGgTx+gPdCsO7Y
         ViptLOLtomCwVCDUQGKRmTQJkGgsQ0hZ6RSVPSnzFU156ywH1kMKp5Z1WLtebUyz8S
         VnWih8g0s/T5KKB3PVBTd0L90gqY58GKyPYVFfGA=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38BGPe2O022100
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Sep 2023 11:25:40 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Sep 2023 11:25:40 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Sep 2023 11:25:40 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38BGPedi057134;
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
Subject: [PATCH 3/3] arm64: dts: ti: k3-am625-sk: Add boot phase tags marking
Date:   Mon, 11 Sep 2023 11:25:35 -0500
Message-ID: <20230911162535.1044560-4-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230911162535.1044560-1-nm@ti.com>
References: <20230911162535.1044560-1-nm@ti.com>
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

Describe the same for am625-sk boot devices.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am625-sk.dts        | 27 +++++++++++++++++++
 .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 16 +++++++++++
 2 files changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
index 7c98c1b855d1..b18092497c9a 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
@@ -31,6 +31,7 @@ memory@80000000 {
 
 	vmain_pd: regulator-0 {
 		/* TPS65988 PD CONTROLLER OUTPUT */
+		bootph-all;
 		compatible = "regulator-fixed";
 		regulator-name = "vmain_pd";
 		regulator-min-microvolt = <5000000>;
@@ -41,6 +42,7 @@ vmain_pd: regulator-0 {
 
 	vcc_5v0: regulator-1 {
 		/* Output of LM34936 */
+		bootph-all;
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_5v0";
 		regulator-min-microvolt = <5000000>;
@@ -52,6 +54,7 @@ vcc_5v0: regulator-1 {
 
 	vcc_3v3_sys: regulator-2 {
 		/* output of LM61460-Q1 */
+		bootph-all;
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_3v3_sys";
 		regulator-min-microvolt = <3300000>;
@@ -63,6 +66,7 @@ vcc_3v3_sys: regulator-2 {
 
 	vdd_mmc1: regulator-3 {
 		/* TPS22918DBVR */
+		bootph-all;
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_mmc1";
 		regulator-min-microvolt = <3300000>;
@@ -75,6 +79,7 @@ vdd_mmc1: regulator-3 {
 
 	vdd_sd_dv: regulator-4 {
 		/* Output of TLV71033 */
+		bootph-all;
 		compatible = "regulator-gpio";
 		regulator-name = "tlv71033";
 		pinctrl-names = "default";
@@ -102,6 +107,7 @@ vcc_1v8: regulator-5 {
 
 &main_pmx0 {
 	main_rgmii2_pins_default: main-rgmii2-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x184, PIN_INPUT, 0) /* (AE23) RGMII2_RD0 */
 			AM62X_IOPAD(0x188, PIN_INPUT, 0) /* (AB20) RGMII2_RD1 */
@@ -119,6 +125,7 @@ AM62X_IOPAD(0x164, PIN_OUTPUT, 0) /* (AA19) RGMII2_TX_CTL */
 	};
 
 	ospi0_pins_default: ospi0-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x000, PIN_OUTPUT, 0) /* (H24) OSPI0_CLK */
 			AM62X_IOPAD(0x02c, PIN_OUTPUT, 0) /* (F23) OSPI0_CSn0 */
@@ -135,20 +142,32 @@ AM62X_IOPAD(0x008, PIN_INPUT, 0) /* (J24) OSPI0_DQS */
 	};
 
 	vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x07c, PIN_OUTPUT, 7) /* (P25) GPMC0_CLK.GPIO0_31 */
 		>;
 	};
 
 	main_gpio1_ioexp_intr_pins_default: main-gpio1-ioexp-intr-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x01d4, PIN_INPUT, 7) /* (B15) UART0_RTSn.GPIO1_23 */
 		>;
 	};
 };
 
+&main_gpio0 {
+	bootph-all;
+};
+
+&main_gpio1 {
+	bootph-all;
+};
+
 &main_i2c1 {
+	bootph-all;
 	exp1: gpio@22 {
+		bootph-all;
 		compatible = "ti,tca6424";
 		reg = <0x22>;
 		gpio-controller;
@@ -207,12 +226,18 @@ mbox_m4_0: mbox-m4-0 {
 	};
 };
 
+&fss {
+	bootph-all;
+};
+
 &ospi0 {
+	bootph-all;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&ospi0_pins_default>;
 
 	flash@0 {
+		bootph-all;
 		compatible = "jedec,spi-nor";
 		reg = <0x0>;
 		spi-tx-bus-width = <8>;
@@ -225,6 +250,7 @@ flash@0 {
 		cdns,read-delay = <4>;
 
 		partitions {
+			bootph-all;
 			compatible = "fixed-partitions";
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -260,6 +286,7 @@ partition@800000 {
 			};
 
 			partition@3fc0000 {
+				bootph-pre-ram;
 				label = "ospi.phypattern";
 				reg = <0x3fc0000 0x40000>;
 			};
diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
index 677ff8de4b6e..19f57ead4ebd 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
@@ -28,6 +28,7 @@ chosen {
 	};
 
 	memory@80000000 {
+		bootph-pre-ram;
 		device_type = "memory";
 		/* 2G RAM */
 		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
@@ -130,6 +131,7 @@ hdmi_connector_in: endpoint {
 &main_pmx0 {
 	/* First pad number is ALW package and second is AMC package */
 	main_uart0_pins_default: main-uart0-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x1c8, PIN_INPUT, 0) /* (D14/A13) UART0_RXD */
 			AM62X_IOPAD(0x1cc, PIN_OUTPUT, 0) /* (E14/E11) UART0_TXD */
@@ -137,6 +139,7 @@ AM62X_IOPAD(0x1cc, PIN_OUTPUT, 0) /* (E14/E11) UART0_TXD */
 	};
 
 	main_uart1_pins_default: main-uart1-default-pins {
+		bootph-pre-ram;
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x194, PIN_INPUT, 2) /* (B19/B18) MCASP0_AXR3.UART1_CTSn */
 			AM62X_IOPAD(0x198, PIN_OUTPUT, 2) /* (A19/B17) MCASP0_AXR2.UART1_RTSn */
@@ -167,6 +170,7 @@ AM62X_IOPAD(0x0b4, PIN_INPUT_PULLUP, 1) /* (K24/H19) GPMC0_CSn3.I2C2_SDA */
 	};
 
 	main_mmc0_pins_default: main-mmc0-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x220, PIN_INPUT, 0) /* (Y3/V3) MMC0_CMD */
 			AM62X_IOPAD(0x218, PIN_INPUT, 0) /* (AB1/Y1) MMC0_CLK */
@@ -182,6 +186,7 @@ AM62X_IOPAD(0x1f8, PIN_INPUT, 0) /* (AC2/V4) MMC0_DAT7 */
 	};
 
 	main_mmc1_pins_default: main-mmc1-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x23c, PIN_INPUT, 0) /* (A21/C18) MMC1_CMD */
 			AM62X_IOPAD(0x234, PIN_INPUT, 0) /* (B22/A20) MMC1_CLK */
@@ -207,6 +212,7 @@ AM62X_IOPAD(0x15c, PIN_INPUT, 0) /* (AB22/U16) MDIO0_MDIO */
 	};
 
 	main_rgmii1_pins_default: main-rgmii1-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x14c, PIN_INPUT, 0) /* (AB17/W15) RGMII1_RD0 */
 			AM62X_IOPAD(0x150, PIN_INPUT, 0) /* (AC17/Y16) RGMII1_RD1 */
@@ -274,6 +280,7 @@ AM62X_IOPAD(0x078, PIN_OUTPUT, 1) /* (U24) GPMC0_AD15.VOUT0_DATA23 */
 
 &mcu_pmx0 {
 	wkup_uart0_pins_default: wkup-uart0-default-pins {
+		bootph-pre-ram;
 		pinctrl-single,pins = <
 			AM62X_MCU_IOPAD(0x02c, PIN_INPUT, 0) /* (C6/A7) WKUP_UART0_CTSn */
 			AM62X_MCU_IOPAD(0x030, PIN_OUTPUT, 0) /* (A4/B4) WKUP_UART0_RTSn */
@@ -285,12 +292,14 @@ AM62X_MCU_IOPAD(0x028, PIN_OUTPUT, 0) /* (C5/C6) WKUP_UART0_TXD */
 
 &wkup_uart0 {
 	/* WKUP UART0 is used by DM firmware */
+	bootph-pre-ram;
 	status = "reserved";
 	pinctrl-names = "default";
 	pinctrl-0 = <&wkup_uart0_pins_default>;
 };
 
 &main_uart0 {
+	bootph-all;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart0_pins_default>;
@@ -298,6 +307,7 @@ &main_uart0 {
 
 &main_uart1 {
 	/* Main UART1 is used by TIFS firmware */
+	bootph-pre-ram;
 	status = "reserved";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart1_pins_default>;
@@ -390,6 +400,7 @@ sii9022_out: endpoint {
 };
 
 &sdhci0 {
+	bootph-all;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mmc0_pins_default>;
@@ -399,6 +410,7 @@ &sdhci0 {
 
 &sdhci1 {
 	/* SD/MMC */
+	bootph-all;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mmc1_pins_default>;
@@ -407,21 +419,25 @@ &sdhci1 {
 };
 
 &cpsw3g {
+	bootph-all;
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_rgmii1_pins_default>;
 };
 
 &cpsw_port1 {
+	bootph-all;
 	phy-mode = "rgmii-rxid";
 	phy-handle = <&cpsw3g_phy0>;
 };
 
 &cpsw3g_mdio {
+	bootph-all;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mdio1_pins_default>;
 
 	cpsw3g_phy0: ethernet-phy@0 {
+		bootph-all;
 		reg = <0>;
 		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
 		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
-- 
2.40.0

