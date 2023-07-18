Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806B5757734
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjGRI5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbjGRI5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:57:38 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DD5103;
        Tue, 18 Jul 2023 01:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1689670654; x=1721206654;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EcVzbt6r3n8aMGwfm4MM1HPdwvTVmJa8G8wCmTkd/xg=;
  b=jTaXsZtu6ANn7uGiqA5Uwmwp59CjKJ2fVo5ASDjjYLpCO7UcE/qjLu6h
   y3xuT/t/kKF3NfgUchxG0cxAtLIkvMneLxF7YnI/BmLQUGvK1TwgXPy03
   o0TxQ2ODvaJyYFWXM1d2kyL/tsK33FognEzuP2U4mk0rQuYu9EUMtY/2+
   355ttfG4yUwys/kHp6n7i2qpcUY07wkNUZZKy1vMTGFbxKfTfkYZsM/7r
   24nI3QOqLPO1g5RBCXaDj6j4h0bVNPgIssyAq14RxQ1B8JRdz4Xsu61N9
   N8lVTO3eM+1qo0jPNZxXqXFu8QZHbJ/6/36xbsOabOW8ctX7Z79Py+ryF
   A==;
X-IronPort-AV: E=Sophos;i="6.01,213,1684792800"; 
   d="scan'208";a="31981427"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 18 Jul 2023 10:57:30 +0200
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 9FF38280085;
        Tue, 18 Jul 2023 10:57:29 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Subject: [PATCH v3 2/3] arm64: dts: freescale: add initial device tree for MBa93xxLA SBC board
Date:   Tue, 18 Jul 2023 10:57:21 +0200
Message-Id: <20230718085722.1198862-3-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230718085722.1198862-1-alexander.stein@ew.tq-group.com>
References: <20230718085722.1198862-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for TQMa93xx module and MBa93xxLA SBC board.
TQMa93xx is a SOM using i.MX93 SOC. The SOM features PMIC, RAM, e-MMC and
some optional peripherals like SPI-NOR, RTC, EEPROM, gyroscope and
secure element.
TQMa93xxLA is a solder on type SOM and can be used directly on MBa93XXLA.
TQMa93xxCA is a feature compatible, socketable type SOM.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../freescale/imx93-tqma9352-mba93xxla.dts    | 641 ++++++++++++++++++
 .../boot/dts/freescale/imx93-tqma9352.dtsi    | 213 ++++++
 3 files changed, 855 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index a750be13ace8..2d5e9f495a64 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -141,6 +141,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8qxp-colibri-iris-v2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-mek.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-11x11-evk.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla.dtb
 
 imx8mm-venice-gw72xx-0x-imx219-dtbs	:= imx8mm-venice-gw73xx-0x.dtb imx8mm-venice-gw73xx-0x-imx219.dtbo
 imx8mm-venice-gw72xx-0x-rs232-rts-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-rs232-rts.dtbo
diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
new file mode 100644
index 000000000000..f06139bdff97
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
@@ -0,0 +1,641 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright (c) 2022-2023 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
+ * Author: Alexander Stein
+ */
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/net/ti-dp83867.h>
+#include <dt-bindings/pwm/pwm.h>
+#include <dt-bindings/usb/pd.h>
+#include "imx93-tqma9352.dtsi"
+
+/{
+	model = "TQ-Systems i.MX93 TQMa93xxLA on MBa93xxLA SBC";
+	compatible = "tq,imx93-tqma9352-mba93xxla",
+		     "tq,imx93-tqma9352", "fsl,imx93";
+
+	chosen {
+		stdout-path = &lpuart1;
+	};
+
+	aliases {
+		eeprom0 = &eeprom0;
+		rtc0 = &pcf85063;
+		rtc1 = &bbnsm_rtc;
+	};
+
+	backlight_lvds: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&tpm5 0 5000000 0>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <7>;
+		power-supply = <&reg_12v0>;
+		enable-gpios = <&expander2 2 GPIO_ACTIVE_HIGH>;
+		status = "disabled";
+	};
+
+	clk_dp: clk-dp {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <26000000>;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		autorepeat;
+
+		switch-a {
+			label = "switcha";
+			linux,code = <BTN_0>;
+			gpios = <&expander0 6 GPIO_ACTIVE_LOW>;
+			wakeup-source;
+		};
+
+		switch-b {
+			label = "switchb";
+			linux,code = <BTN_1>;
+			gpios = <&expander0 7 GPIO_ACTIVE_LOW>;
+			wakeup-source;
+		};
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+
+		led-1 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_STATUS;
+			gpios = <&expander2 6 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "default-on";
+		};
+
+		led-2 {
+			color = <LED_COLOR_ID_AMBER>;
+			function = LED_FUNCTION_HEARTBEAT;
+			gpios = <&expander2 7 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc1 0>, <&adc1 1>, <&adc1 2>, <&adc1 3>;
+	};
+
+	reg_3v3: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "V_3V3_MB";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	reg_3v8: regulator-3v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "V_3V8";
+		regulator-min-microvolt = <3800000>;
+		regulator-max-microvolt = <3800000>;
+		gpio = <&expander0 0 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		/* TODO: this is supply for IOT module */
+		regulator-always-on;
+	};
+
+	reg_5v0: regulator-5v0 {
+		compatible = "regulator-fixed";
+		regulator-name = "V_5V0_MB";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	reg_12v0: regulator-12v0 {
+		compatible = "regulator-fixed";
+		regulator-name = "V_12V";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		gpio = <&expander1 7 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
+
+&adc1 {
+	status = "okay";
+};
+
+&eqos {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_eqos>;
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy_eqos>;
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy_eqos: ethernet-phy@0 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_eqos_phy>;
+			interrupt-parent = <&gpio3>;
+			interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
+			reset-gpios = <&expander1 0 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <500000>;
+			reset-deassert-us = <50000>;
+			enet-phy-lane-no-swap;
+			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
+			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
+			ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+			ti,dp83867-rxctrl-strap-quirk;
+			ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
+		};
+	};
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec>;
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy_fec>;
+	fsl,magic-packet;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-frequency = <5000000>;
+
+		ethphy_fec: ethernet-phy@0 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_fec_phy>;
+			interrupt-parent = <&gpio3>;
+			interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
+			reset-gpios = <&expander1 1 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <500000>;
+			reset-deassert-us = <50000>;
+			enet-phy-lane-no-swap;
+			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
+			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
+			ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+			ti,dp83867-rxctrl-strap-quirk;
+			ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
+		};
+	};
+};
+
+&flexcan1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	xceiver-supply = <&reg_3v3>;
+	status = "okay";
+};
+
+&flexcan2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan2>;
+	xceiver-supply = <&reg_3v3>;
+	status = "okay";
+};
+
+&gpio1 {
+	expander-irq-hog {
+		gpio-hog;
+		gpios = <12 GPIO_ACTIVE_LOW>;
+		input;
+		line-name = "PEX_INT#";
+	};
+
+	rtc-irq-hog {
+		gpio-hog;
+		gpios = <14 GPIO_ACTIVE_LOW>;
+		input;
+		line-name = "RTC_EVENT#";
+	};
+};
+
+&gpio3 {
+	ethphy-eqos-irq-hog {
+		gpio-hog;
+		gpios = <26 GPIO_ACTIVE_LOW>;
+		input;
+		line-name = "ENET0_IRQ#";
+	};
+
+	ethphy-fec-irq-hog {
+		gpio-hog;
+		gpios = <27 GPIO_ACTIVE_LOW>;
+		input;
+		line-name = "ENET1_IRQ#";
+	};
+};
+
+&lpi2c3 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_lpi2c3>;
+	pinctrl-1 = <&pinctrl_lpi2c3>;
+	status = "okay";
+
+	temperature-sensor@1c {
+		compatible = "nxp,se97b", "jedec,jc-42.4-temp";
+		reg = <0x1c>;
+	};
+
+	eeprom2: eeprom@54 {
+		compatible = "nxp,se97b", "atmel,24c02";
+		reg = <0x54>;
+		pagesize = <16>;
+		vcc-supply = <&reg_3v3>;
+	};
+
+	expander0: gpio@70 {
+		compatible = "nxp,pca9538";
+		reg = <0x70>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pexp_irq>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
+		vcc-supply = <&reg_3v3>;
+		gpio-line-names = "3V8_EN", "",
+				  "", "IOT_PWRKEY",
+				  "IOT_RESET", "IOT_W_DISABLE",
+				  "BUTTON_A#", "BUTTON_B#";
+
+		/*
+		 * Controls the IOT W_DISABLE pin which is low active
+		 * as disable signal but inverted as seen from the CPU.
+		 * The output-low states, the signal is
+		 * inactive, e.g. not disabled
+		 */
+		iot_wdisable_hog: iot-wdisable-hog {
+			gpio-hog;
+			gpios = <5 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "IOT_W_DISABLE";
+		};
+	};
+
+	expander1: gpio@71 {
+		compatible = "nxp,pca9538";
+		reg = <0x71>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		vcc-supply = <&reg_3v3>;
+		gpio-line-names = "ENET1_RESET#", "ENET2_RESET#",
+				  "USB_RESET#", "",
+				  "WLAN_PD#", "WLAN_W_DISABLE#",
+				  "WLAN_PERST#", "12V_EN";
+
+		/*
+		 * Controls the WiFi card PD pin which is low active
+		 * as power down signal. The output-low states, the signal
+		 * is inactive, e.g. not power down
+		 */
+		wlan-pd-hog {
+			gpio-hog;
+			gpios = <4 GPIO_ACTIVE_LOW>;
+			output-low;
+			line-name = "WLAN_PD#";
+		};
+
+		/*
+		 * Controls the WiFi card disable pin which is low active
+		 * as disable signal. The output-low states, the signal
+		 * is inactive, e.g. not disabled
+		 */
+		wlan-wdisable-hog {
+			gpio-hog;
+			gpios = <5 GPIO_ACTIVE_LOW>;
+			output-low;
+			line-name = "WLAN_W_DISABLE#";
+		};
+
+		/*
+		 * Controls the WiFi card reset pin which is low active
+		 * as reset signal. The output-low states, the signal
+		 * is inactive, e.g. not in reset
+		 */
+		wlan-perst-hog {
+			gpio-hog;
+			gpios = <6 GPIO_ACTIVE_LOW>;
+			output-low;
+			line-name = "WLAN_PERST#";
+		};
+	};
+
+	expander2: gpio@72 {
+		compatible = "nxp,pca9538";
+		reg = <0x72>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		vcc-supply = <&reg_3v3>;
+		gpio-line-names = "LCD_RESET#", "LCD_PWR_EN",
+				  "LCD_BL_EN", "DP_EN",
+				  "MIPI_CSI_EN", "MIPI_CSI_RST#",
+				  "USER_LED1", "USER_LED2";
+	};
+};
+
+&lpi2c5 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_lpi2c5>;
+	pinctrl-1 = <&pinctrl_lpi2c5>;
+	status = "okay";
+
+	dp_bridge: dp-bridge@f {
+		compatible = "toshiba,tc9595", "toshiba,tc358767";
+		reg = <0x0f>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_tc9595>;
+		clock-names = "ref";
+		clocks = <&clk_dp>;
+		reset-gpios = <&expander2 3 GPIO_ACTIVE_HIGH>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <29 IRQ_TYPE_EDGE_RISING>;
+		toshiba,hpd-pin = <0>;
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				dp_dsi_in: endpoint {
+					data-lanes = <1 2 3 4>;
+				};
+			};
+		};
+	};
+};
+
+&lpuart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&lpuart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	linux,rs485-enabled-at-boot-time;
+	status = "okay";
+};
+
+/* disabled per default, console for M33 */
+&lpuart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	status = "disabled";
+};
+
+&lpuart6 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart6>;
+	status = "okay";
+};
+
+&lpuart8 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart8>;
+	status = "okay";
+};
+
+&pcf85063 {
+	/* RTC_EVENT# is connected on MBa93xxLA */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcf85063>;
+	interrupt-parent = <&gpio1>;
+	interrupts = <14 IRQ_TYPE_EDGE_FALLING>;
+};
+
+&tpm5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_tpm5>;
+};
+
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc2_hs>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2_uhs>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc2_uhs>, <&pinctrl_usdhc2_gpio>;
+	cd-gpios = <&gpio3 00 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	bus-width = <4>;
+	no-sdio;
+	no-mmc;
+	disable-wp;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_eqos: eqosgrp {
+		fsl,pins = <
+			/* PD | FSEL_2 | DSE X4 */
+			MX93_PAD_ENET1_MDC__ENET_QOS_MDC		0x51e
+			MX93_PAD_ENET1_MDIO__ENET_QOS_MDIO		0x4000051e
+			/* PD | FSEL_2 | DSE X6 */
+			MX93_PAD_ENET1_RD0__ENET_QOS_RGMII_RD0		0x57e
+			MX93_PAD_ENET1_RD1__ENET_QOS_RGMII_RD1		0x57e
+			MX93_PAD_ENET1_RD2__ENET_QOS_RGMII_RD2		0x57e
+			MX93_PAD_ENET1_RD3__ENET_QOS_RGMII_RD3		0x57e
+			/* PD | FSEL_3 | DSE X6 */
+			MX93_PAD_ENET1_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK	0x5fe
+			MX93_PAD_ENET1_RX_CTL__ENET_QOS_RGMII_RX_CTL	0x57e
+			/* PD | FSEL_2 | DSE X4 */
+			MX93_PAD_ENET1_TD0__ENET_QOS_RGMII_TD0		0x51e
+			MX93_PAD_ENET1_TD1__ENET_QOS_RGMII_TD1		0x51e
+			MX93_PAD_ENET1_TD2__ENET_QOS_RGMII_TD2		0x51e
+			MX93_PAD_ENET1_TD3__ENET_QOS_RGMII_TD3		0x51e
+			MX93_PAD_ENET1_TX_CTL__ENET_QOS_RGMII_TX_CTL	0x51e
+			/* PD | FSEL_3 | DSE X3 */
+			MX93_PAD_ENET1_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x58e
+		>;
+	};
+
+	pinctrl_eqos_phy: eqosphygrp {
+		fsl,pins = <
+			MX93_PAD_CCM_CLKO1__GPIO3_IO26		0x1306
+		>;
+	};
+
+	pinctrl_fec: fecgrp {
+		fsl,pins = <
+			/* PD | FSEL_2 | DSE X4 */
+			MX93_PAD_ENET2_MDC__ENET1_MDC			0x51e
+			MX93_PAD_ENET2_MDIO__ENET1_MDIO			0x4000051e
+			/* PD | FSEL_2 | DSE X6 */
+			MX93_PAD_ENET2_RD0__ENET1_RGMII_RD0		0x57e
+			MX93_PAD_ENET2_RD1__ENET1_RGMII_RD1		0x57e
+			MX93_PAD_ENET2_RD2__ENET1_RGMII_RD2		0x57e
+			MX93_PAD_ENET2_RD3__ENET1_RGMII_RD3		0x57e
+			/* PD | FSEL_3 | DSE X6 */
+			MX93_PAD_ENET2_RXC__ENET1_RGMII_RXC		0x5fe
+			MX93_PAD_ENET2_RX_CTL__ENET1_RGMII_RX_CTL	0x57e
+			/* PD | FSEL_2 | DSE X4 */
+			MX93_PAD_ENET2_TD0__ENET1_RGMII_TD0		0x51e
+			MX93_PAD_ENET2_TD1__ENET1_RGMII_TD1		0x51e
+			MX93_PAD_ENET2_TD2__ENET1_RGMII_TD2		0x51e
+			MX93_PAD_ENET2_TD3__ENET1_RGMII_TD3		0x51e
+			MX93_PAD_ENET2_TX_CTL__ENET1_RGMII_TX_CTL	0x51e
+			/* PD | FSEL_3 | DSE X3 */
+			MX93_PAD_ENET2_TXC__ENET1_RGMII_TXC		0x58e
+		>;
+	};
+
+	pinctrl_fec_phy: fecphygrp {
+		fsl,pins = <
+			MX93_PAD_CCM_CLKO2__GPIO3_IO27		0x1306
+		>;
+	};
+
+	pinctrl_flexcan1: flexcan1grp {
+		fsl,pins = <
+			MX93_PAD_PDM_BIT_STREAM0__CAN1_RX	0x139e
+			MX93_PAD_PDM_CLK__CAN1_TX		0x139e
+		>;
+	};
+
+	pinctrl_flexcan2: flexcan2grp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO25__CAN2_TX		0x139e
+			MX93_PAD_GPIO_IO27__CAN2_RX		0x139e
+		>;
+	};
+
+	pinctrl_lpi2c3: lpi2c3grp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO28__LPI2C3_SDA		0x40000b9e
+			MX93_PAD_GPIO_IO29__LPI2C3_SCL		0x40000b9e
+		>;
+	};
+
+	pinctrl_lpi2c5: lpi2c5grp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO22__LPI2C5_SDA		0x40000b9e
+			MX93_PAD_GPIO_IO23__LPI2C5_SCL		0x40000b9e
+		>;
+	};
+
+	pinctrl_pcf85063: pcf85063grp {
+		fsl,pins = <
+			MX93_PAD_SAI1_RXD0__GPIO1_IO14		0x1306
+		>;
+	};
+
+	pinctrl_pexp_irq: pexpirqgrp {
+		fsl,pins = <
+			MX93_PAD_SAI1_TXC__GPIO1_IO12		0x1306
+		>;
+	};
+
+	pinctrl_tc9595: tc9595-grp {
+		fsl,pins = <
+			/* DP_IRQ */
+			MX93_PAD_CCM_CLKO4__GPIO4_IO29		0x1306
+		>;
+	};
+
+	pinctrl_tpm5: tpm5grp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO06__TPM5_CH0		0x57e
+		>;
+	};
+
+	pinctrl_typec: typecgrp {
+		fsl,pins = <
+			MX93_PAD_I2C2_SCL__GPIO1_IO02		0x1306
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX93_PAD_UART1_RXD__LPUART1_RX		0x31e
+			MX93_PAD_UART1_TXD__LPUART1_TX		0x31e
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX93_PAD_UART2_TXD__LPUART2_TX		0x31e
+			MX93_PAD_UART2_RXD__LPUART2_RX		0x31e
+			MX93_PAD_SAI1_TXD0__LPUART2_RTS_B	0x31e
+		>;
+	};
+
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO14__LPUART3_TX		0x31e
+			MX93_PAD_GPIO_IO15__LPUART3_RX		0x31e
+		>;
+	};
+
+	pinctrl_uart6: uart6grp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO04__LPUART6_TX		0x31e
+			MX93_PAD_GPIO_IO05__LPUART6_RX		0x31e
+		>;
+	};
+
+	pinctrl_uart8: uart8grp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO12__LPUART8_TX		0x31e
+			MX93_PAD_GPIO_IO13__LPUART8_RX		0x31e
+		>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
+		fsl,pins = <
+			MX93_PAD_SD2_CD_B__GPIO3_IO00		0x31e
+		>;
+	};
+
+	pinctrl_usdhc2_hs: usdhc2hsgrp {
+		fsl,pins = <
+			/* HYS | PD | PU | FSEL_3 | DSE X5 */
+			MX93_PAD_SD2_CLK__USDHC2_CLK		0x17be
+			/* HYS | PD | PU | FSEL_3 | DSE X4 */
+			MX93_PAD_SD2_CMD__USDHC2_CMD		0x139e
+			/* HYS | PD | PU | FSEL_3 | DSE X3 */
+			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x138e
+			MX93_PAD_SD2_DATA1__USDHC2_DATA1	0x138e
+			MX93_PAD_SD2_DATA2__USDHC2_DATA2	0x138e
+			MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x138e
+			/* PD | PU | FSEL_2 | DSE X3 */
+			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x50e
+		>;
+	};
+
+	pinctrl_usdhc2_uhs: usdhc2uhsgrp {
+		fsl,pins = <
+			/* HYS | PD | PU | FSEL_3 | DSE X6 */
+			MX93_PAD_SD2_CLK__USDHC2_CLK		0x17fe
+			/* HYS | PD | PU | FSEL_3 | DSE X4 */
+			MX93_PAD_SD2_CMD__USDHC2_CMD		0x139e
+			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x139e
+			MX93_PAD_SD2_DATA1__USDHC2_DATA1	0x139e
+			MX93_PAD_SD2_DATA2__USDHC2_DATA2	0x139e
+			MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x139e
+			/* PD | PU | FSEL_2 | DSE X3 */
+			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x50e
+		>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi b/arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi
new file mode 100644
index 000000000000..1c71c08becde
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright (c) 2022 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
+ */
+
+#include "imx93.dtsi"
+
+/{
+	model = "TQ-Systems i.MX93 TQMa93xxLA/TQMa93xxCA SOM";
+	compatible = "tq,imx93-tqma9352", "fsl,imx93";
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			alloc-ranges = <0 0x60000000 0 0x40000000>;
+			size = <0 0x10000000>;
+			linux,cma-default;
+		};
+	};
+
+	reg_v1v8: regulator-v1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "V_1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	reg_v3v3: regulator-v3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "V_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	/* SD2 RST# via PMIC SW_EN */
+	reg_usdhc2_vmmc: regulator-usdhc2 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
+		regulator-name = "VSD_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&reg_v3v3>;
+		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
+
+&adc1 {
+	vref-supply = <&reg_v1v8>;
+};
+
+&flexspi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexspi1>;
+	status = "okay";
+
+	flash0: flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		/*
+		 * no DQS, RXCLKSRC internal loop back, max 66 MHz
+		 * clk framework uses CLK_DIVIDER_ROUND_CLOSEST
+		 * selected value together with root from
+		 * IMX93_CLK_SYS_PLL_PFD1 @ 800.000.000 Hz helps to
+		 * respect the maximum value.
+		 */
+		spi-max-frequency = <62000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+	};
+};
+
+&gpio1 {
+	pmic-irq-hog {
+		gpio-hog;
+		gpios = <2 GPIO_ACTIVE_LOW>;
+		input;
+		line-name = "PMIC_IRQ#";
+	};
+};
+
+&lpi2c1 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_lpi2c1>;
+	pinctrl-1 = <&pinctrl_lpi2c1>;
+	status = "okay";
+
+	se97_som: temperature-sensor@1b {
+		compatible = "nxp,se97b", "jedec,jc-42.4-temp";
+		reg = <0x1b>;
+	};
+
+	pcf85063: rtc@51 {
+		compatible = "nxp,pcf85063a";
+		reg = <0x51>;
+		quartz-load-femtofarads = <7000>;
+	};
+
+	eeprom0: eeprom@53 {
+		compatible = "nxp,se97b", "atmel,24c02";
+		reg = <0x53>;
+		pagesize = <16>;
+		read-only;
+		vcc-supply = <&reg_v3v3>;
+	};
+
+	eeprom1: eeprom@57 {
+		compatible = "atmel,24c64";
+		reg = <0x57>;
+		pagesize = <32>;
+		vcc-supply = <&reg_v3v3>;
+	};
+
+	/* protectable identification memory (part of M24C64-D @57) */
+	eeprom@5f {
+		compatible = "st,24c64", "atmel,24c64";
+		reg = <0x5f>;
+		size = <32>;
+		pagesize = <32>;
+		vcc-supply = <&reg_v3v3>;
+	};
+
+	imu@6a {
+		compatible = "st,ism330dhcx";
+		reg = <0x6a>;
+		vdd-supply = <&reg_v3v3>;
+		vddio-supply = <&reg_v3v3>;
+	};
+};
+
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1>;
+	pinctrl-2 = <&pinctrl_usdhc1>;
+	bus-width = <8>;
+	non-removable;
+	no-sdio;
+	no-sd;
+	status = "okay";
+};
+
+&wdog3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_flexspi1: flexspi1grp {
+		fsl,pins = <
+			MX93_PAD_SD3_CMD__FLEXSPI1_A_SS0_B	0x3fe
+			MX93_PAD_SD3_CLK__FLEXSPI1_A_SCLK	0x3fe
+			MX93_PAD_SD3_DATA0__FLEXSPI1_A_DATA00	0x3fe
+			MX93_PAD_SD3_DATA1__FLEXSPI1_A_DATA01	0x3fe
+			MX93_PAD_SD3_DATA2__FLEXSPI1_A_DATA02	0x3fe
+			MX93_PAD_SD3_DATA3__FLEXSPI1_A_DATA03	0x3fe
+		>;
+	};
+
+	pinctrl_lpi2c1: lpi2c1grp {
+		fsl,pins = <
+			MX93_PAD_I2C1_SCL__LPI2C1_SCL		0x40000b9e
+			MX93_PAD_I2C1_SDA__LPI2C1_SDA		0x40000b9e
+		>;
+	};
+
+	pinctrl_pca9451: pca9451grp {
+		fsl,pins = <
+			MX93_PAD_I2C2_SDA__GPIO1_IO03		0x1306
+		>;
+	};
+
+	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
+		fsl,pins = <
+			MX93_PAD_SD2_RESET_B__GPIO3_IO07	0x1306
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			/* HYS | PU | PD | FSEL_3 | X5 */
+			MX93_PAD_SD1_CLK__USDHC1_CLK		0x17be
+			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x17be
+			/* HYS | PU | FSEL_3 | X5 */
+			MX93_PAD_SD1_CMD__USDHC1_CMD		0x13be
+			/* HYS | PU | FSEL_3 | X4 */
+			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x139e
+			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x139e
+			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x139e
+			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x139e
+			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x139e
+			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x139e
+			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x139e
+			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x139e
+		>;
+	};
+
+	pinctrl_wdog: wdoggrp {
+		fsl,pins = <
+			MX93_PAD_WDOG_ANY__WDOG1_WDOG_ANY	0x31e
+		>;
+	};
+};
-- 
2.34.1

