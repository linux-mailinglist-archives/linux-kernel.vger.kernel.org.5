Return-Path: <linux-kernel+bounces-118031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8515888B2A9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 124461FA4125
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D8B6EB49;
	Mon, 25 Mar 2024 21:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxXVbvjI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8F26CDA7;
	Mon, 25 Mar 2024 21:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711401848; cv=none; b=rJSxRUiv7sfRV+hg8FYwtuVskDQ2Bjm3wlQNt188avqSzhuL/xTyDE2F/frGvijFg5Cp3ntIIEBma/nRyWShGsAnSUlTSbLKHFw45SLIcS1YE/0jzDkaECzKHg/PquY5rw/T9tbLjaLEPRipsGfIcxfcQ1TFLmbP3Zzq3uDijPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711401848; c=relaxed/simple;
	bh=QfONu+lDLAlaJJaUwB/PgmqQGstEuTvsJtVfSvXznRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQEyyVUKTKDc6joU6uoTLd8B6PDCNon1iWl5uioE6KrS3b1Jkr5d779H40l3nb1vvwBMaf1719YQcg3HK6xy4AZudjaM9ag+AJo4+igOs2XmWNEFnbC66vV16wd6qFttdJIl1t9xnNYN5yUUiarsiVyedQ16gBCheXnq4N7tCAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxXVbvjI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79EE0C433F1;
	Mon, 25 Mar 2024 21:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711401847;
	bh=QfONu+lDLAlaJJaUwB/PgmqQGstEuTvsJtVfSvXznRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JxXVbvjIolqsXthrsbj316ryFxzTiPP8et7uytxtpEXq952z+S1xhjNHrpO3+0NF8
	 rojxUQdnzH+A+cw5rp+4NrE4DQ0+yCKPFjYRRYxt0auzaHsbCA9Q1aIdOgNET32EgJ
	 KiXCF8QwuW8IhlJzYmSDHvbmCRhhC/Ai7YGKGTKK6JlL0FzreX/JcHUrXlDdY8zXyZ
	 9NdUh7Xz2LXl/rNC1zR7dsHuHcap/kwXUEruNuD7+/f7hxXRiHrRGREPjrDx3MACn9
	 FpzvZvg70QJ8s2qcLJVxF/IsoUVMm3HlwuBO2OpPUlOytk0z4r0jkRwPlILZqqtMyV
	 oUs3q9R8FsGIQ==
Received: by mercury (Postfix, from userid 1000)
	id C246110608C7; Mon, 25 Mar 2024 22:24:04 +0100 (CET)
From: Sebastian Reichel <sre@kernel.org>
To: Sebastian Reichel <sre@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH v6 1/1] ARM: dts: imx: Add UNI-T UTi260B thermal camera board
Date: Mon, 25 Mar 2024 22:19:54 +0100
Message-ID: <20240325212402.150906-2-sre@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325212402.150906-1-sre@kernel.org>
References: <20240325212402.150906-1-sre@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add DT for the UNI-T UTi260B handheld thermal camera.

Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 arch/arm/boot/dts/nxp/imx/Makefile            |   1 +
 arch/arm/boot/dts/nxp/imx/imx6ull-uti260b.dts | 566 ++++++++++++++++++
 2 files changed, 567 insertions(+)
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-uti260b.dts

diff --git a/arch/arm/boot/dts/nxp/imx/Makefile b/arch/arm/boot/dts/nxp/imx/Makefile
index 4052cad859fa..598361d0632e 100644
--- a/arch/arm/boot/dts/nxp/imx/Makefile
+++ b/arch/arm/boot/dts/nxp/imx/Makefile
@@ -355,6 +355,7 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ull-tarragon-slavext.dtb \
 	imx6ull-tqma6ull2-mba6ulx.dtb \
 	imx6ull-tqma6ull2l-mba6ulx.dtb \
+	imx6ull-uti260b.dtb \
 	imx6ulz-14x14-evk.dtb \
 	imx6ulz-bsh-smm-m2.dtb
 dtb-$(CONFIG_SOC_IMX7D) += \
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-uti260b.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-uti260b.dts
new file mode 100644
index 000000000000..e4576d509a5b
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-uti260b.dts
@@ -0,0 +1,566 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+// Copyright (C) 2022-2024 Sebastian Reichel <sre@kernel.org>
+
+/dts-v1/;
+#include "imx6ull.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/clock/imx6ul-clock.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	model = "UNI-T UTi260B Thermal Camera";
+	compatible = "uni-t,uti260b", "fsl,imx6ull";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x20000000>;
+	};
+
+	panel_backlight: backlight {
+		compatible = "pwm-backlight";
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <6>;
+		enable-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&mux_backlight_enable>;
+		power-supply = <&reg_vsd>;
+		pwms = <&pwm1 0 50000 0>;
+	};
+
+	battery: battery {
+		compatible = "simple-battery";
+		/* generic 26650 battery */
+		device-chemistry = "lithium-ion";
+		charge-full-design-microamp-hours = <5000000>;
+		voltage-max-design-microvolt = <4200000>;
+		voltage-min-design-microvolt = <3300000>;
+	};
+
+	tp5000: charger {
+		compatible = "gpio-charger";
+		charger-type = "usb-sdp";
+		gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&mux_charger_stat1>;
+	};
+
+	fuel-gauge {
+		compatible = "adc-battery";
+		charged-gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;
+		io-channel-names = "voltage";
+		io-channels = <&adc1 7>;
+		monitored-battery = <&battery>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&mux_charger_stat2>;
+		power-supplies = <&tp5000>;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&mux_gpio_keys>;
+		autorepeat;
+
+		up-key {
+			label = "Up";
+			gpios = <&gpio2 11 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_UP>;
+		};
+
+		down-key {
+			label = "Down";
+			gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_DOWN>;
+		};
+
+		left-key {
+			label = "Left";
+			gpios = <&gpio2 13 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_LEFT>;
+		};
+
+		right-key {
+			label = "Right";
+			gpios = <&gpio2 10 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_RIGHT>;
+		};
+
+		ok-key {
+			label = "Ok";
+			gpios = <&gpio2 9 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_ENTER>;
+		};
+
+		return-key {
+			label = "Return";
+			gpios = <&gpio2 15 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_ESC>;
+		};
+
+		play-key {
+			label = "Media";
+			gpios = <&gpio2 8 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_MEDIA>;
+		};
+
+		trigger-key {
+			label = "Trigger";
+			gpios = <&gpio2 14 GPIO_ACTIVE_LOW>;
+			linux,code = <BTN_TRIGGER>;
+		};
+
+		power-key {
+			label = "Power";
+			gpios = <&gpio2 3 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_POWER>;
+		};
+
+		light-key {
+			label = "Light";
+			gpios = <&gpio2 1 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_LIGHTS_TOGGLE>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&mux_led_ctrl>;
+
+		led {
+			color = <LED_COLOR_ID_WHITE>;
+			function = LED_FUNCTION_FLASH;
+			gpios = <&gpio2 2 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+	};
+
+	poweroff {
+		compatible = "gpio-poweroff";
+		gpios = <&gpio2 4 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&mux_poweroff>;
+	};
+
+	reg_vref: regulator-vref-4v2 {
+		compatible = "regulator-fixed";
+		regulator-name = "VREF_4V2";
+		regulator-min-microvolt = <4200000>;
+		regulator-max-microvolt = <4200000>;
+	};
+
+	reg_vsd: regulator-vsd {
+		compatible = "regulator-fixed";
+		regulator-name = "VSD_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+};
+
+&adc1 {
+	#io-channel-cells = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mux_adc>;
+	vref-supply = <&reg_vref>;
+	status = "okay";
+};
+
+&csi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mux_csi>;
+	status = "okay";
+
+	port {
+		parallel_from_gc0308: endpoint {
+			remote-endpoint = <&gc0308_to_parallel>;
+		};
+	};
+};
+
+&ecspi3 {
+	cs-gpios = <&gpio1 20 GPIO_ACTIVE_LOW>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mux_spi3>;
+	status = "okay";
+
+	panel@0 {
+		compatible = "inanbo,t28cp45tn89-v17";
+		reg = <0>;
+		backlight = <&panel_backlight>;
+		power-supply = <&reg_vsd>;
+		spi-cpha;
+		spi-cpol;
+		spi-max-frequency = <1000000>;
+		spi-rx-bus-width = <0>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&display_out>;
+			};
+		};
+	};
+};
+
+&gpio1 {
+	ir-reset-hog {
+		gpio-hog;
+		gpios = <3 GPIO_ACTIVE_LOW>;
+		line-name = "ir-reset-gpio";
+		output-low;
+		pinctrl-names = "default";
+		pinctrl-0 = <&mux_ir_reset>;
+	};
+};
+
+&gpio2 {
+	/* configuring this to output-high results in poweroff */
+	power-en-hog {
+		gpio-hog;
+		gpios = <6 GPIO_ACTIVE_HIGH>;
+		line-name = "power-en-gpio";
+		output-low;
+		pinctrl-names = "default";
+		pinctrl-0 = <&mux_poweroff2>;
+	};
+};
+
+&i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mux_i2c1>;
+	status = "okay";
+
+	camera@21 {
+		compatible = "galaxycore,gc0308";
+		reg = <0x21>;
+		clocks = <&clks IMX6UL_CLK_CSI>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&mux_gc0308>;
+		powerdown-gpios = <&gpio1 5 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
+		vdd28-supply = <&reg_vsd>;
+
+		port {
+			gc0308_to_parallel: endpoint {
+				remote-endpoint = <&parallel_from_gc0308>;
+				bus-width = <8>;
+				data-shift = <2>; /* lines 9:2 are used */
+				hsync-active = <1>; /* active high */
+				vsync-active = <1>; /* active high */
+				data-active = <1>; /* active high */
+				pclk-sample = <1>; /* sample on rising edge */
+			};
+		};
+	};
+};
+
+&i2c2 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mux_i2c2>;
+	status = "okay";
+
+	rtc@51 {
+		compatible = "nxp,pcf8563";
+		reg = <0x51>;
+	};
+};
+
+&lcdif {
+	assigned-clocks = <&clks IMX6UL_CLK_LCDIF_PRE_SEL>;
+	assigned-clock-parents = <&clks IMX6UL_CLK_PLL5_VIDEO_DIV>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mux_lcd_data>, <&mux_lcd_ctrl>;
+	status = "okay";
+
+	port {
+		display_out: endpoint {
+			remote-endpoint = <&panel_in>;
+		};
+	};
+};
+
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mux_pwm>;
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mux_uart>;
+	status = "okay";
+};
+
+&usbotg1 {
+	/* USB-C connector */
+	disable-over-current;
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usbotg2 {
+	/* thermal sensor */
+	disable-over-current;
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usbphy1 {
+	fsl,tx-d-cal = <106>;
+};
+
+&usbphy2 {
+	fsl,tx-d-cal = <106>;
+};
+
+&usdhc1 {
+	/* MicroSD */
+	cd-gpios = <&gpio1 19 GPIO_ACTIVE_LOW>;
+	keep-power-in-suspend;
+	no-1-8-v;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&mux_sdhc1>, <&mux_sdhc1_cd>;
+	pinctrl-1 = <&mux_sdhc1_100mhz>, <&mux_sdhc1_cd>;
+	pinctrl-2 = <&mux_sdhc1_200mhz>, <&mux_sdhc1_cd>;
+	wakeup-source;
+	vmmc-supply = <&reg_vsd>;
+	status = "okay";
+};
+
+&usdhc2 {
+	/* eMMC */
+	keep-power-in-suspend;
+	no-1-8-v;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mux_sdhc2>;
+	wakeup-source;
+	status = "okay";
+};
+
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mux_wdog>;
+};
+
+&iomuxc {
+	mux_adc: adcgrp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO07__GPIO1_IO07		0xb0
+		>;
+	};
+
+	mux_backlight_enable: blenablegrp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO09__GPIO1_IO09		0x3008
+		>;
+	};
+
+	mux_charger_stat1: charger1grp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO01__GPIO1_IO01		0x3008
+		>;
+	};
+
+	mux_charger_stat2: charger2grp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO02__GPIO1_IO02		0x3008
+		>;
+	};
+
+	mux_csi: csi1grp {
+		fsl,pins = <
+			MX6UL_PAD_CSI_PIXCLK__CSI_PIXCLK		0x1b088
+			MX6UL_PAD_CSI_VSYNC__CSI_VSYNC			0x1b088
+			MX6UL_PAD_CSI_HSYNC__CSI_HSYNC			0x1b088
+			MX6UL_PAD_CSI_DATA00__CSI_DATA02		0x1b088
+			MX6UL_PAD_CSI_DATA01__CSI_DATA03		0x1b088
+			MX6UL_PAD_CSI_DATA02__CSI_DATA04		0x1b088
+			MX6UL_PAD_CSI_DATA03__CSI_DATA05		0x1b088
+			MX6UL_PAD_CSI_DATA04__CSI_DATA06		0x1b088
+			MX6UL_PAD_CSI_DATA05__CSI_DATA07		0x1b088
+			MX6UL_PAD_CSI_DATA06__CSI_DATA08		0x1b088
+			MX6UL_PAD_CSI_DATA07__CSI_DATA09		0x1b088
+		>;
+	};
+
+	mux_gc0308: gc0308grp {
+		fsl,pins = <
+			MX6UL_PAD_CSI_MCLK__CSI_MCLK			0x1e038
+			MX6UL_PAD_GPIO1_IO05__GPIO1_IO05		0x1b088
+			MX6UL_PAD_GPIO1_IO06__GPIO1_IO06		0x1b088
+		>;
+	};
+
+	mux_gpio_keys: gpiokeygrp {
+		fsl,pins = <
+			MX6UL_PAD_ENET2_TX_DATA0__GPIO2_IO11		0x3008
+			MX6UL_PAD_ENET2_TX_DATA1__GPIO2_IO12		0x3008
+			MX6UL_PAD_ENET2_TX_EN__GPIO2_IO13		0x3008
+			MX6UL_PAD_ENET2_RX_EN__GPIO2_IO10		0x3008
+			MX6UL_PAD_ENET2_RX_DATA1__GPIO2_IO09		0x3008
+			MX6UL_PAD_ENET2_RX_ER__GPIO2_IO15		0x3008
+			MX6UL_PAD_ENET2_RX_DATA0__GPIO2_IO08		0x3008
+			MX6UL_PAD_ENET2_TX_CLK__GPIO2_IO14		0x3008
+			MX6UL_PAD_ENET1_TX_DATA0__GPIO2_IO03		0x3008
+			MX6UL_PAD_ENET1_RX_DATA1__GPIO2_IO01		0x3008
+		>;
+	};
+
+	mux_i2c1: i2c1grp {
+		fsl,pins = <
+			MX6UL_PAD_UART4_TX_DATA__I2C1_SCL		0x4001b8b0
+			MX6UL_PAD_UART4_RX_DATA__I2C1_SDA		0x4001b8b0
+		>;
+	};
+
+	mux_i2c2: i2c2grp {
+		fsl,pins = <
+			MX6UL_PAD_UART5_TX_DATA__I2C2_SCL		0x4001f8a8
+			MX6UL_PAD_UART5_RX_DATA__I2C2_SDA		0x4001f8a8
+		>;
+	};
+
+	mux_ir_reset: irresetgrp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO03__GPIO1_IO03		0x3008
+		>;
+	};
+
+	mux_lcd_ctrl: lcdifctrlgrp {
+		fsl,pins = <
+			MX6UL_PAD_LCD_CLK__LCDIF_CLK			0x79
+			MX6UL_PAD_LCD_ENABLE__LCDIF_ENABLE		0x79
+			MX6UL_PAD_LCD_HSYNC__LCDIF_HSYNC		0x79
+			MX6UL_PAD_LCD_VSYNC__LCDIF_VSYNC		0x79
+		>;
+	};
+
+	mux_lcd_data: lcdifdatgrp {
+		fsl,pins = <
+			MX6UL_PAD_LCD_DATA00__LCDIF_DATA00		0x79
+			MX6UL_PAD_LCD_DATA01__LCDIF_DATA01		0x79
+			MX6UL_PAD_LCD_DATA02__LCDIF_DATA02		0x79
+			MX6UL_PAD_LCD_DATA03__LCDIF_DATA03		0x79
+			MX6UL_PAD_LCD_DATA04__LCDIF_DATA04		0x79
+			MX6UL_PAD_LCD_DATA05__LCDIF_DATA05		0x79
+			MX6UL_PAD_LCD_DATA06__LCDIF_DATA06		0x79
+			MX6UL_PAD_LCD_DATA07__LCDIF_DATA07		0x79
+			MX6UL_PAD_LCD_DATA08__LCDIF_DATA08		0x79
+			MX6UL_PAD_LCD_DATA09__LCDIF_DATA09		0x79
+			MX6UL_PAD_LCD_DATA10__LCDIF_DATA10		0x79
+			MX6UL_PAD_LCD_DATA11__LCDIF_DATA11		0x79
+			MX6UL_PAD_LCD_DATA12__LCDIF_DATA12		0x79
+			MX6UL_PAD_LCD_DATA13__LCDIF_DATA13		0x79
+			MX6UL_PAD_LCD_DATA14__LCDIF_DATA14		0x79
+			MX6UL_PAD_LCD_DATA15__LCDIF_DATA15		0x79
+			MX6UL_PAD_LCD_DATA16__LCDIF_DATA16		0x79
+			MX6UL_PAD_LCD_DATA17__LCDIF_DATA17		0x79
+		>;
+	};
+
+	mux_led_ctrl: ledctrlgrp {
+		fsl,pins = <
+			MX6UL_PAD_ENET1_RX_EN__GPIO2_IO02		0x3008
+		>;
+	};
+
+	mux_poweroff: poweroffgrp {
+		fsl,pins = <
+			MX6UL_PAD_ENET1_TX_DATA1__GPIO2_IO04		0x3008
+		>;
+	};
+
+	mux_poweroff2: poweroff2grp {
+		fsl,pins = <
+			MX6UL_PAD_ENET1_TX_CLK__GPIO2_IO06		0x3008
+		>;
+	};
+
+	mux_pwm: pwm1grp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO08__PWM1_OUT			0x110b0
+		>;
+	};
+
+	mux_sdhc1: sdhc1grp {
+		fsl,pins = <
+			MX6UL_PAD_SD1_CMD__USDHC1_CMD			0x17059
+			MX6UL_PAD_SD1_CLK__USDHC1_CLK			0x10071
+			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0		0x17059
+			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1		0x17059
+			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2		0x17059
+			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3		0x17059
+		>;
+	};
+
+	mux_sdhc1_100mhz: sdhc1-100mhz-grp {
+		fsl,pins = <
+			MX6UL_PAD_SD1_CMD__USDHC1_CMD			0x170b9
+			MX6UL_PAD_SD1_CLK__USDHC1_CLK			0x170b9
+			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0		0x170b9
+			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1		0x170b9
+			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2		0x170b9
+			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3		0x170b9
+		>;
+	};
+
+	mux_sdhc1_200mhz: sdhc1-200mhz-grp {
+		fsl,pins = <
+			MX6UL_PAD_SD1_CMD__USDHC1_CMD			0x170f9
+			MX6UL_PAD_SD1_CLK__USDHC1_CLK			0x170f9
+			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0		0x170f9
+			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1		0x170f9
+			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2		0x170f9
+			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3		0x170f9
+		>;
+	};
+
+	mux_sdhc1_cd: sdhc1-cd-grp {
+		fsl,pins = <
+			MX6UL_PAD_UART1_RTS_B__GPIO1_IO19		0x17059
+		>;
+	};
+
+	mux_sdhc2: sdhc2grp {
+		fsl,pins = <
+			MX6UL_PAD_NAND_RE_B__USDHC2_CLK			0x10069
+			MX6UL_PAD_NAND_WE_B__USDHC2_CMD			0x17059
+			MX6UL_PAD_NAND_DATA00__USDHC2_DATA0		0x17059
+			MX6UL_PAD_NAND_DATA01__USDHC2_DATA1		0x17059
+			MX6UL_PAD_NAND_DATA02__USDHC2_DATA2		0x17059
+			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3		0x17059
+			MX6UL_PAD_NAND_DATA04__USDHC2_DATA4		0x17059
+			MX6UL_PAD_NAND_DATA05__USDHC2_DATA5		0x17059
+			MX6UL_PAD_NAND_DATA06__USDHC2_DATA6		0x17059
+			MX6UL_PAD_NAND_DATA07__USDHC2_DATA7		0x17059
+		>;
+	};
+
+	mux_spi3: ecspi3grp {
+		fsl,pins = <
+			MX6UL_PAD_UART2_CTS_B__ECSPI3_MOSI		0x100b1
+			MX6UL_PAD_UART2_RX_DATA__ECSPI3_SCLK		0x100b1
+			MX6UL_PAD_UART2_TX_DATA__GPIO1_IO20		0x3008
+		>;
+	};
+
+	mux_uart: uartgrp {
+		fsl,pins = <
+			MX6UL_PAD_UART1_TX_DATA__UART1_DCE_TX		0x1b0b1
+			MX6UL_PAD_UART1_RX_DATA__UART1_DCE_RX		0x1b0b1
+		>;
+	};
+
+	mux_wdog: wdoggrp {
+		fsl,pins = <
+			MX6UL_PAD_LCD_RESET__WDOG1_WDOG_ANY		0x30b0
+		>;
+	};
+};
-- 
2.43.0


