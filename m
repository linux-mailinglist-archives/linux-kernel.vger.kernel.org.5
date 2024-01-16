Return-Path: <linux-kernel+bounces-27660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BFA82F3D0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39377287DF3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CB81CF90;
	Tue, 16 Jan 2024 18:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="s7gnRscm"
Received: from mail.fris.de (unknown [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBE16ABA;
	Tue, 16 Jan 2024 18:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fris.de
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705428706; cv=none; b=UXJLh/7C9gzwtHObGl8mLSg0nsvkU/M/HAg0oNy88K2AxdfY0y4pi/AyUVdFpFXmm/IaYAGyjrLyBpONJTJWwtjOVLEdlFSF0s7t5AJlYw+XLNXh6JjBhhiF9V5oq83Q/7MdKbvHVnruNZ+9bP9kLkX7Ok1kPKbVb1rOJ6rotVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705428706; c=relaxed/simple;
	bh=VG+5J65uM2x4ZN6opSHjUFKakDLs1meFCchQBsRiHsM=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version; b=hohJOSB3ulLB9NwmztNpmKthn2H/6YWyComWzqY/X5rQzX2LKPh2F5yn3S49nBD0+uMm/jT3zJfO9y0t/H10LaCtBHJnwHlrD3x6CesQHEES7WqQrkGGiSczLKikWYdNUE84Uk+YtTpqeqjYT+S6sZv5gb4v7hnCN+YZNlV+ADg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=s7gnRscm; arc=none smtp.client-ip=116.203.77.234
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D558CC0185;
	Tue, 16 Jan 2024 19:11:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1705428702; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=TXOfhMjxippBCK8Y1f2CKJBA65fvckCSHCwVRv5OWiQ=;
	b=s7gnRscm/u3VRQY+Z1j4iDye9jVkxQ2EgU3GTm2XKdfYkYT2/CRdUWJYDeqcpdNqItpdXG
	qI+SEqlgMe2edkOdeSSXRASTWxiEKVuZIvcX4/AjucuD2zIPCLEFKAJQzGDYFD1NkgnnbO
	l1fjKMYeX/uWVv7QUD4Z3Xdek5k13g1wTbE6chLuJs96uKmyVNX04+VdWT+vD/H3V5jTtm
	rRlVIK6rZXSk+95WkN8TrQDb5OiKG2jaYLv0BdN0GuyA5vwMxfUqUi3IsGFhJiEpAQkxyS
	F4vbePM/d9O4+HZVlHZcNDFxjJKEDHff8d+5vw8NkVW1IdJ4a8+f7dR80QxBLw==
From: Frieder Schrempf <frieder@fris.de>
To: Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Andre Przywara <andre.przywara@arm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Fabio Estevam <festevam@gmail.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Heiko Stuebner <heiko@sntech.de>,
	James Hilliard <james.hilliard1@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v2 3/3] ARM: dts: imx6dl: Add support for Sielaff i.MX6 Solo board
Date: Tue, 16 Jan 2024 19:10:28 +0100
Message-ID: <20240116181100.382388-4-frieder@fris.de>
In-Reply-To: <20240116181100.382388-1-frieder@fris.de>
References: <20240116181100.382388-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The Sielaff i.MX6 Solo board is used as controller and user interface
in vending machines. It is based on the i.MX6 Solo SoC and features
the following peripherals and interfaces:

* 512 MB DDR3 RAM
* 512 MB NAND Flash
* 1 MB NOR Flash
* SD card
* Debug LED
* Debug UART
* Key Inputs
* RTC
* RS232
* 100 MBit Ethernet
* USB Hub
* USB OTG
* HDMI
* 7" LVDS IPS panel
* PWM Backlight
* Optional Extension Board with USB Ethernet NIC

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes in v2:
* Fix touchscreen node names (Thanks Fabio!)
---
 arch/arm/boot/dts/nxp/imx/Makefile           |   1 +
 arch/arm/boot/dts/nxp/imx/imx6dl-sielaff.dts | 533 +++++++++++++++++++
 2 files changed, 534 insertions(+)
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6dl-sielaff.dts

diff --git a/arch/arm/boot/dts/nxp/imx/Makefile b/arch/arm/boot/dts/nxp/imx/Makefile
index a724d1a7a9a07..c32e004e7610c 100644
--- a/arch/arm/boot/dts/nxp/imx/Makefile
+++ b/arch/arm/boot/dts/nxp/imx/Makefile
@@ -118,6 +118,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6dl-sabrelite.dtb \
 	imx6dl-sabresd.dtb \
 	imx6dl-savageboard.dtb \
+	imx6dl-sielaff.dtb \
 	imx6dl-skov-revc-lt2.dtb \
 	imx6dl-skov-revc-lt6.dtb \
 	imx6dl-solidsense.dtb \
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-sielaff.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-sielaff.dts
new file mode 100644
index 0000000000000..7de8d5f265187
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-sielaff.dts
@@ -0,0 +1,533 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2022 Kontron Electronics GmbH
+ */
+
+/dts-v1/;
+
+#include "imx6dl.dtsi"
+#include <dt-bindings/clock/imx6qdl-clock.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "Sielaff i.MX6 Solo";
+	compatible = "sielaff,imx6dl-board", "fsl,imx6dl";
+
+	chosen {
+		stdout-path = &uart2;
+	};
+
+	backlight: pwm-backlight {
+		compatible = "pwm-backlight";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_backlight>;
+		pwms = <&pwm3 0 50000 0>;
+		brightness-levels = <0 0 64 88 112 136 184 232 255>;
+		default-brightness-level = <4>;
+		enable-gpios = <&gpio6 16 GPIO_ACTIVE_HIGH>;
+		power-supply = <&reg_backlight>;
+	};
+
+	cec {
+		compatible = "cec-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_hdmi_cec>;
+		cec-gpios = <&gpio2 7 GPIO_ACTIVE_HIGH>;
+		hdmi-phandle = <&hdmi>;
+	};
+
+	enet_ref: clock-enet-ref {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <50000000>;
+		clock-output-names = "enet-ref";
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_keys>;
+
+		key-0 {
+			gpios = <&gpio2 16 0>;
+			debounce-interval = <10>;
+			linux,code = <1>;
+		};
+
+		key-1 {
+			gpios = <&gpio3 27 0>;
+			debounce-interval = <10>;
+			linux,code = <2>;
+		};
+
+		key-2 {
+			gpios = <&gpio5 4 0>;
+			debounce-interval = <10>;
+			linux,code = <3>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_leds>;
+
+		led-debug {
+			label = "debug-led";
+			gpios = <&gpio5 21 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	memory@80000000 {
+		reg = <0x80000000 0x20000000>;
+		device_type = "memory";
+	};
+
+	osc_eth_phy: clock-osc-eth-phy {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+		clock-output-names = "osc-eth-phy";
+	};
+
+	panel {
+		compatible = "lg,lb070wv8";
+		backlight = <&backlight>;
+		power-supply = <&reg_3v3>;
+
+		port {
+			panel_in_lvds: endpoint {
+				remote-endpoint = <&lvds_out>;
+			};
+		};
+	};
+
+	reg_3v3: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	reg_backlight: regulator-backlight {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_backlight>;
+		enable-active-high;
+		gpio = <&gpio1 23 GPIO_ACTIVE_HIGH>;
+		regulator-name = "backlight";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+	};
+
+	reg_usb_otg_vbus: regulator-usb-otg-vbus {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usbotg_vbus>;
+		enable-active-high;
+		gpio = <&gpio4 15 GPIO_ACTIVE_HIGH>;
+		regulator-name = "usb_otg_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+};
+
+&ecspi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi2>;
+	cs-gpios = <&gpio5 29 GPIO_ACTIVE_LOW>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <20000000>;
+	};
+};
+
+&fec {
+	/*
+	 * Set PTP clock to external instead of internal reference, as the
+	 * REF_CLK from the PHY is fed back into the i.MX6 and the GPR
+	 * register needs to be set accordingly (see mach-imx6q.c).
+	 */
+	clocks = <&clks IMX6QDL_CLK_ENET>,
+		 <&clks IMX6QDL_CLK_ENET>,
+		 <&enet_ref>,
+		 <&clks IMX6QDL_CLK_ENET_REF>;
+	clock-names = "ipg", "ahb", "ptp", "enet_out";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet>;
+	phy-connection-type = "rmii";
+	phy-handle = <&ethphy>;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy: ethernet-phy@1 {
+			reg = <1>;
+			clocks = <&osc_eth_phy>;
+			clock-names = "rmii-ref";
+			micrel,led-mode = <1>;
+			reset-assert-us = <500>;
+			reset-deassert-us = <100>;
+			reset-gpios = <&gpio5 2 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&gpio1 {
+	gpio-line-names =
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "key-out", "key-in",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "";
+};
+
+&gpio2 {
+	gpio-line-names =
+		"", "", "", "", "", "", "", "",
+		"lan9500a-rst", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "";
+};
+
+&gpmi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpmi_nand>;
+	status = "okay";
+};
+
+&hdmi {
+	ddc-i2c-bus = <&i2c4>;
+	status = "okay";
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	clock-frequency = <100000>;
+	status = "okay";
+
+	rtc@51 {
+		compatible = "nxp,pcf8563";
+		reg = <0x51>;
+	};
+};
+
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	clock-frequency = <100000>;
+	status = "okay";
+
+	touchscreen@55 {
+		compatible = "sitronix,st1633";
+		reg = <0x55>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_touch>;
+		interrupts = <18 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-parent = <&gpio5>;
+		gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;
+		status = "disabled";
+	};
+
+	touchscreen@5d {
+		compatible = "goodix,gt928";
+		reg = <0x5d>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_touch>;
+		interrupts = <18 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio5>;
+		irq-gpios = <&gpio5 18 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
+		status = "disabled";
+	};
+};
+
+&i2c4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c4>;
+	clock-frequency = <100000>;
+	status = "okay";
+};
+
+&ldb {
+	status = "okay";
+
+	lvds: lvds-channel@0 {
+		fsl,data-mapping = "spwg";
+		fsl,data-width = <24>;
+		status = "okay";
+
+		port@4 {
+			reg = <4>;
+
+			lvds_out: endpoint {
+				remote-endpoint = <&panel_in_lvds>;
+			};
+		};
+	};
+};
+
+&pwm3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm3>;
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	status = "okay";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	status = "okay";
+};
+
+&usbh1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbh1>;
+	disable-over-current;
+	status = "okay";
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	usb1@1 {
+		compatible = "usb4b4,6570";
+		reg = <1>;
+		clocks = <&clks IMX6QDL_CLK_CKO>;
+
+		assigned-clocks = <&clks IMX6QDL_CLK_CKO>,
+				  <&clks IMX6QDL_CLK_CKO2_SEL>;
+		assigned-clock-parents = <&clks IMX6QDL_CLK_CKO2>,
+					 <&clks IMX6QDL_CLK_OSC>;
+		assigned-clock-rates = <12000000 0>;
+	};
+};
+
+&usbotg {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg>;
+	dr_mode = "host";
+	over-current-active-low;
+	vbus-supply = <&reg_usb_otg_vbus>;
+	status = "okay";
+};
+
+&usdhc3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	cd-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&reg_3v3>;
+	voltage-ranges = <3300 3300>;
+	no-1-8-v;
+	status = "okay";
+};
+
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	pinctrl_hog: hoggrp {
+		fsl,pins = <
+			MX6QDL_PAD_RGMII_RD0__GPIO6_IO25	0x1b0b0	/* PMIC_IRQ */
+			MX6QDL_PAD_SD2_DAT3__GPIO1_IO12		0x1b0b0
+			MX6QDL_PAD_SD2_DAT1__GPIO1_IO14		0x1b0b0
+			MX6QDL_PAD_SD2_DAT0__GPIO1_IO15		0x1b0b0
+			MX6QDL_PAD_SD4_DAT0__GPIO2_IO08		0x1b0b0
+			MX6QDL_PAD_EIM_D29__GPIO3_IO29		0x1b0b0
+		>;
+	};
+
+	pinctrl_backlight: backlightgrp {
+		fsl,pins = <
+			MX6QDL_PAD_NANDF_CS3__GPIO6_IO16	0x100b1
+		>;
+	};
+
+	pinctrl_ecspi2: ecspi2grp {
+		fsl,pins = <
+			MX6QDL_PAD_CSI0_DAT10__ECSPI2_MISO	0x100b1
+			MX6QDL_PAD_CSI0_DAT9__ECSPI2_MOSI	0x100b1
+			MX6QDL_PAD_CSI0_DAT8__ECSPI2_SCLK	0x100b1
+			MX6QDL_PAD_CSI0_DAT11__GPIO5_IO29	0x100b1
+		>;
+	};
+
+	pinctrl_enet: enetgrp {
+		fsl,pins = <
+			MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b0b0
+			MX6QDL_PAD_ENET_MDC__ENET_MDC		0x1b0b0
+			MX6QDL_PAD_ENET_RXD0__ENET_RX_DATA0	0x1b0b0
+			MX6QDL_PAD_ENET_RXD1__ENET_RX_DATA1	0x1b0b0
+			MX6QDL_PAD_ENET_CRS_DV__ENET_RX_EN	0x1b0b0
+			MX6QDL_PAD_ENET_RX_ER__ENET_RX_ER	0x1b0b0
+			MX6QDL_PAD_ENET_TXD0__ENET_TX_DATA0	0x1b0b0
+			MX6QDL_PAD_ENET_TXD1__ENET_TX_DATA1	0x1b0b0
+			MX6QDL_PAD_ENET_TX_EN__ENET_TX_EN	0x1b0b0
+			MX6QDL_PAD_GPIO_16__ENET_REF_CLK	0x4001b0a8
+			MX6QDL_PAD_EIM_A25__GPIO5_IO02		0x100b1
+		>;
+	};
+
+	pinctrl_gpio_keys: gpiokeysgrp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_A22__GPIO2_IO16		0x1b080
+			MX6QDL_PAD_EIM_D27__GPIO3_IO27		0x1b080
+			MX6QDL_PAD_EIM_A24__GPIO5_IO04		0x1b080
+		>;
+	};
+
+	pinctrl_gpio_leds: gpioledsgrp {
+		fsl,pins = <
+			MX6QDL_PAD_CSI0_VSYNC__GPIO5_IO21	0x1b0b0
+		>;
+	};
+
+	pinctrl_gpmi_nand: gpminandgrp {
+		fsl,pins = <
+			MX6QDL_PAD_NANDF_CLE__NAND_CLE		0xb0b1
+			MX6QDL_PAD_NANDF_ALE__NAND_ALE		0xb0b1
+			MX6QDL_PAD_NANDF_WP_B__NAND_WP_B	0xb0b1
+			MX6QDL_PAD_NANDF_RB0__NAND_READY_B	0xb000
+			MX6QDL_PAD_NANDF_CS0__NAND_CE0_B	0xb0b1
+			MX6QDL_PAD_SD4_CMD__NAND_RE_B		0xb0b1
+			MX6QDL_PAD_SD4_CLK__NAND_WE_B		0xb0b1
+			MX6QDL_PAD_NANDF_D0__NAND_DATA00	0xb0b1
+			MX6QDL_PAD_NANDF_D1__NAND_DATA01	0xb0b1
+			MX6QDL_PAD_NANDF_D2__NAND_DATA02	0xb0b1
+			MX6QDL_PAD_NANDF_D3__NAND_DATA03	0xb0b1
+			MX6QDL_PAD_NANDF_D4__NAND_DATA04	0xb0b1
+			MX6QDL_PAD_NANDF_D5__NAND_DATA05	0xb0b1
+			MX6QDL_PAD_NANDF_D6__NAND_DATA06	0xb0b1
+			MX6QDL_PAD_NANDF_D7__NAND_DATA07	0xb0b1
+		>;
+	};
+
+	pinctrl_hdmi_cec: hdmicecgrp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_A21__GPIO2_IO17		0x1b8b1
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX6QDL_PAD_KEY_COL3__I2C2_SCL		0x4001b8b1
+			MX6QDL_PAD_KEY_ROW3__I2C2_SDA		0x4001b8b1
+		>;
+	};
+
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_5__I2C3_SCL		0x4001f8b1
+			MX6QDL_PAD_GPIO_6__I2C3_SDA		0x4001f8b1
+		>;
+	};
+
+	pinctrl_i2c4: i2c4grp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_7__I2C4_SCL		0x4001b8b1
+			MX6QDL_PAD_GPIO_8__I2C4_SDA		0x4001b8b1
+		>;
+	};
+
+	pinctrl_pwm3: pwm3grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD4_DAT1__PWM3_OUT		0x1b0b1
+		>;
+	};
+
+	pinctrl_reg_backlight: regbacklightgrp {
+		fsl,pins = <
+			MX6QDL_PAD_ENET_REF_CLK__GPIO1_IO23	0x1b0b1
+		>;
+	};
+
+	pinctrl_reg_usbotg_vbus: regusbotgvbusgrp {
+		fsl,pins = <
+			MX6QDL_PAD_KEY_ROW4__GPIO4_IO15		0x1b0b1
+		>;
+	};
+
+	pinctrl_touch: touchgrp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_2__GPIO1_IO02		0x1b0b0
+			MX6QDL_PAD_CSI0_PIXCLK__GPIO5_IO18	0x1b0b0
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD3_DAT7__UART1_TX_DATA 	0x1b0b1
+			MX6QDL_PAD_SD3_DAT6__UART1_RX_DATA 	0x1b0b1
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD4_DAT7__UART2_TX_DATA	0x1b0b1
+			MX6QDL_PAD_SD4_DAT4__UART2_RX_DATA	0x1b0b1
+		>;
+	};
+
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_D24__UART3_TX_DATA	0x1b0b0
+			MX6QDL_PAD_EIM_D25__UART3_RX_DATA	0x1b0b0
+		>;
+	};
+
+	pinctrl_usbh1: usbh1grp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_3__USB_H1_OC		0x1b0b1
+			MX6QDL_PAD_CSI0_MCLK__CCM_CLKO1		0x1b0b0
+		>;
+	};
+
+	pinctrl_usbotg: usbotggrp {
+		fsl,pins = <
+			MX6QDL_PAD_KEY_COL4__USB_OTG_OC		0x1b0b1
+		>;
+	};
+
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD3_CMD__SD3_CMD		0x17059
+			MX6QDL_PAD_SD3_CLK__SD3_CLK		0x10059
+			MX6QDL_PAD_SD3_DAT0__SD3_DATA0		0x17059
+			MX6QDL_PAD_SD3_DAT1__SD3_DATA1		0x17059
+			MX6QDL_PAD_SD3_DAT2__SD3_DATA2		0x17059
+			MX6QDL_PAD_SD3_DAT3__SD3_DATA3		0x17059
+			MX6QDL_PAD_GPIO_4__GPIO1_IO04		0x100b1
+		>;
+	};
+
+	pinctrl_wdog: wdoggrp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_9__WDOG1_B		0x1b0b0
+		>;
+	};
+};
-- 
2.43.0


