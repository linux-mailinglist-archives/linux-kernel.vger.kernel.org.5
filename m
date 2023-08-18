Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8283C7806AC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 09:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358326AbjHRHwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 03:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358307AbjHRHve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 03:51:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B843C0C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 00:51:19 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qWuGD-0000pU-Hf; Fri, 18 Aug 2023 09:51:09 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1qWuGB-001SCC-Uw; Fri, 18 Aug 2023 09:51:07 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
        (envelope-from <ore@pengutronix.de>)
        id 1qWuGB-00BpUd-1P;
        Fri, 18 Aug 2023 09:51:07 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v1 2/2] arm64: dts: freescale: Add SKOV IMX8MP CPU revA board
Date:   Fri, 18 Aug 2023 09:51:06 +0200
Message-Id: <20230818075106.2819520-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230818075106.2819520-1-o.rempel@pengutronix.de>
References: <20230818075106.2819520-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Skov i.MX8MP based climate controller.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../boot/dts/freescale/imx8mp-skov-reva.dts   | 711 ++++++++++++++++++
 2 files changed, 712 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-skov-reva.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index c6872b7e9471d..3a20565112673 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -101,6 +101,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-icore-mx8mp-edimm2.2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-msc-sm2s-ep1.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-reva.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-tqma8mpql-mba8mpxl.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-venice-gw71xx-2x.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-venice-gw72xx-2x.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-skov-reva.dts b/arch/arm64/boot/dts/freescale/imx8mp-skov-reva.dts
new file mode 100644
index 0000000000000..a5b8731557ddb
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-skov-reva.dts
@@ -0,0 +1,711 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+
+/dts-v1/;
+
+#include "imx8mp.dtsi"
+
+#include <dt-bindings/leds/common.h>
+
+/ {
+	model = "SKOV IMX8MP CPU revA - MI1010AIT-1CP1";
+	compatible = "skov,imx8mp-skov-reva-mi1010ait-1cp1", "fsl,imx8mp";
+
+	aliases {
+		ethernet0 = &eqos;
+		ethernet1 = &lan1;
+		ethernet2 = &lan2;
+		rtc0 = &i2c_rtc;
+		rtc1 = &snvs_rtc;
+	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pinctrl-0 = <&pinctrl_backlight>;
+		pwms = <&pwm1 0 20000 0>;
+		power-supply = <&reg_24v0>;
+		enable-gpios = <&gpio4 24 GPIO_ACTIVE_LOW>;
+		brightness-levels = <0 255>;
+		num-interpolated-steps = <17>;
+		default-brightness-level = <8>;
+	};
+
+	display {
+		compatible = "multi-inno,mi1010ait-1cp";
+		backlight = <&backlight>;
+		power-supply = <&buck4>;
+
+		port {
+			panel_in_lvds0: endpoint {
+				remote-endpoint = <&ldb_lvds_ch0>;
+			};
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_led>;
+
+		led-0 {
+			label = "D1";
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpio1 5 GPIO_ACTIVE_HIGH>;
+			function = LED_FUNCTION_STATUS;
+			default-state = "on";
+			linux,default-trigger = "heartbeat";
+		};
+
+		led-1 {
+			label = "D2";
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		led-2 {
+			label = "D3";
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+	};
+
+	reg_2v5: regulator-2v5 {
+		compatible = "regulator-fixed";
+		vin-supply = <&reg_5v0>;
+		regulator-name = "2v5";
+		regulator-min-microvolt = <2500000>;
+		regulator-max-microvolt = <2500000>;
+	};
+
+	reg_5v0: regulator-5v0 {
+		compatible = "regulator-fixed";
+		regulator-name = "5v0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	reg_24v0: regulator-24v0 {
+		compatible = "regulator-fixed";
+		regulator-name = "24v0";
+		regulator-min-microvolt = <24000000>;
+		regulator-max-microvolt = <24000000>;
+	};
+
+	reg_can1_stby: regulator-can1-stby {
+		compatible = "regulator-fixed";
+		regulator-name = "can1-3v3";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_flexcan1_reg>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio4 21 GPIO_ACTIVE_LOW>;
+	};
+
+	reg_can2_stby: regulator-can2-stby {
+		compatible = "regulator-fixed";
+		regulator-name = "can2-3v3";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_flexcan2_reg>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio4 22 GPIO_ACTIVE_LOW>;
+	};
+
+	reg_sd2_vsel: regulator-sd2-vsel {
+		compatible = "regulator-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_sd2_vsel>;
+		regulator-name = "SD2_VSEL";
+		regulator-type = "voltage";
+		vin-supply = <&buck4>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
+		states = <3300000 0x1 1800000 0x0>;
+	};
+};
+
+&A53_0 {
+	cpu-supply = <&buck2>;
+};
+
+&A53_1 {
+	cpu-supply = <&buck2>;
+};
+
+&A53_2 {
+	cpu-supply = <&buck2>;
+};
+
+&A53_3 {
+	cpu-supply = <&buck2>;
+};
+
+&ecspi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi2>;
+	cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
+	status = "okay";
+
+	adc: adc@0 {
+		compatible = "microchip,mcp3002";
+		reg = <0>;
+		vref-supply = <&buck4>;
+		spi-max-frequency = <1000000>;
+		#io-channel-cells = <1>;
+	};
+};
+
+&eqos {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_eqos>;
+	phy-mode = "rgmii";
+	status = "okay";
+
+	fixed-link {
+		speed = <1000>;
+		full-duplex;
+	};
+};
+
+&flexcan1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	xceiver-supply = <&reg_can1_stby>;
+	status = "okay";
+};
+
+&flexcan2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan2>;
+	xceiver-supply = <&reg_can2_stby>;
+	status = "okay";
+};
+
+&i2c1 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+
+	pmic@25 {
+		compatible = "nxp,pca9450c";
+		reg = <0x25>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pmic>;
+		interrupts-extended = <&gpio1 3 IRQ_TYPE_EDGE_RISING>;
+
+		regulators {
+			buck1: BUCK1 {
+				regulator-name = "BUCK1";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <2187500>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck2: BUCK2 {
+				regulator-name = "BUCK2";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <2187500>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+				nxp,dvs-run-voltage = <950000>;
+				nxp,dvs-standby-voltage = <850000>;
+			};
+
+			buck4: BUCK4 {	/* VDD_3V3 */
+				regulator-name = "BUCK4";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck5: BUCK5 {	/* VDD_1V8 */
+				regulator-name = "BUCK5";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck6: BUCK6 {	/* NVCC_DRAM_1V1 */
+				regulator-name = "BUCK6";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo1: LDO1 {	/* NVCC_SNVS_1V8 */
+				regulator-name = "LDO1";
+				regulator-min-microvolt = <1600000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo3: LDO3 {	/* VDDA_1V8 */
+				regulator-name = "LDO3";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo5: LDO5 {	/* NVCC_SD2 */
+				regulator-name = "LDO5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+};
+
+&i2c2 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+
+	touchscreen@38 {
+		compatible = "edt,edt-ft5406";
+		reg = <0x38>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_touchscreen>;
+		interrupts-extended = <&gpio4 28 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&gpio4 29 GPIO_ACTIVE_LOW>;
+		touchscreen-size-x = <1280>;
+		touchscreen-size-y = <800>;
+		vcc-supply = <&buck4>;
+		iovcc-supply = <&buck4>;
+		wakeup-source;
+	};
+};
+
+&i2c3 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+
+	i2c_rtc: rtc@51 {
+		compatible = "nxp,pcf85063tp";
+		reg = <0x51>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_rtc>;
+		interrupts-extended = <&gpio4 31 IRQ_TYPE_EDGE_FALLING>;
+		quartz-load-femtofarads = <12500>;
+
+		clock {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+		};
+	};
+};
+
+&i2c4 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c4>;
+	status = "okay";
+
+	switch@5f {
+		compatible = "microchip,ksz9893";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_switch>;
+		reset-gpios = <&gpio5 1 GPIO_ACTIVE_LOW>;
+		reg = <0x5f>;
+
+		ethernet-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			lan1: port@0 {
+				reg = <0>;
+				phy-mode = "internal";
+				label = "lan1";
+			};
+
+			lan2: port@1 {
+				reg = <1>;
+				phy-mode = "internal";
+				label = "lan2";
+			};
+
+			port@2 {
+				reg = <2>;
+				label = "cpu";
+				ethernet = <&eqos>;
+				/* 2ns rgmii-rxid is implemented on PCB.
+				 * Switch should add only rgmii-txid.
+				 */
+				phy-mode = "rgmii-txid";
+				tx-internal-delay-ps = <2000>;
+				rx-internal-delay-ps = <0>;
+
+				fixed-link {
+					speed = <1000>;
+					full-duplex;
+				};
+			};
+		};
+	};
+};
+
+&lcdif2 {
+ 	status = "okay";
+};
+
+&lvds_bridge {
+	/* IMX8MP_CLK_MEDIA_LDB = IMX8MP_CLK_MEDIA_DISP2_PIX * 7 */
+	assigned-clock-rates = <482300000>;
+	status = "okay";
+
+	ports {
+		port@1 {
+			ldb_lvds_ch0: endpoint {
+				remote-endpoint = <&panel_in_lvds0>;
+			};
+		};
+	};
+};
+
+&media_blk_ctrl {
+	/* currently it is not possible to let display clocks confugure
+	 * automatically, so we need to set them manually
+	 */
+	assigned-clock-rates = <500000000>, <200000000>, <0>,
+		/* IMX8MP_CLK_MEDIA_DISP2_PIX = pixelclk of lvds panel */
+		<68900000>,
+		/* IMX8MP_VIDEO_PLL1 = IMX8MP_CLK_MEDIA_LDB * 2 */
+		<964600000>;
+};
+
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm1>;
+	status = "okay";
+};
+
+&snvs_pwrkey {
+	status = "okay";
+};
+
+&uart2 {
+	/* console */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	status = "okay";
+};
+
+&usb3_0 {
+	status = "okay";
+};
+
+&usb3_1 {
+	status = "okay";
+};
+
+&usb3_phy0 {
+	vbus-supply = <&buck4>;
+	status = "okay";
+};
+
+&usb3_phy1 {
+	vbus-supply = <&buck4>;
+	status = "okay";
+};
+
+&usb_dwc3_0 {
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usb_dwc3_1 {
+	dr_mode = "host";
+	status = "okay";
+};
+
+/* SD Card */
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
+	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&gpio2 20 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&reg_sd2_vsel>;
+	bus-width = <4>;
+	status = "okay";
+};
+
+/* eMMC */
+&usdhc3 {
+	assigned-clocks = <&clk IMX8MP_CLK_USDHC3>;
+	assigned-clock-rates = <400000000>;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
+	vmmc-supply = <&buck4>;
+	vqmmc-supply = <&buck5>;
+	bus-width = <8>;
+	no-sd;
+	no-sdio;
+	non-removable;
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
+	pinctrl_backlight: backlightgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI2_TXFS__GPIO4_IO24			0x0100
+		>;
+	};
+
+	pinctrl_ecspi2: ecspi2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ECSPI2_SCLK__ECSPI2_SCLK			0x44
+			MX8MP_IOMUXC_ECSPI2_MOSI__ECSPI2_MOSI			0x44
+			MX8MP_IOMUXC_ECSPI2_MISO__ECSPI2_MISO			0x44
+			MX8MP_IOMUXC_ECSPI2_SS0__GPIO5_IO13			0x40
+		>;
+	};
+
+	pinctrl_eqos: eqosgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ENET_RD0__ENET_QOS_RGMII_RD0			0x91
+			MX8MP_IOMUXC_ENET_RD1__ENET_QOS_RGMII_RD1			0x91
+			MX8MP_IOMUXC_ENET_RD2__ENET_QOS_RGMII_RD2			0x91
+			MX8MP_IOMUXC_ENET_RD3__ENET_QOS_RGMII_RD3			0x91
+			MX8MP_IOMUXC_ENET_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK	0x91
+			MX8MP_IOMUXC_ENET_RX_CTL__ENET_QOS_RGMII_RX_CTL			0x91
+			MX8MP_IOMUXC_ENET_TD0__ENET_QOS_RGMII_TD0			0x1f
+			MX8MP_IOMUXC_ENET_TD1__ENET_QOS_RGMII_TD1			0x1f
+			MX8MP_IOMUXC_ENET_TD2__ENET_QOS_RGMII_TD2			0x1f
+			MX8MP_IOMUXC_ENET_TD3__ENET_QOS_RGMII_TD3			0x1f
+			MX8MP_IOMUXC_ENET_TX_CTL__ENET_QOS_RGMII_TX_CTL			0x1f
+			MX8MP_IOMUXC_ENET_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x1f
+		>;
+	};
+
+	pinctrl_flexcan1: flexcan1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SPDIF_RX__CAN1_RX				0x154
+			MX8MP_IOMUXC_SPDIF_TX__CAN1_TX				0x154
+		>;
+	};
+
+	pinctrl_flexcan1_reg: flexcan1reggrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI2_RXFS__GPIO4_IO21			0x154
+		>;
+	};
+
+	pinctrl_flexcan2: flexcan2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI5_MCLK__CAN2_RX				0x154
+			MX8MP_IOMUXC_SAI2_TXD0__CAN2_TX				0x154
+		>;
+	};
+
+	pinctrl_flexcan2_reg: flexcan2reggrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI2_RXC__GPIO4_IO22			0x154
+		>;
+	};
+
+	pinctrl_gpio_led: gpioledgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO05__GPIO1_IO05			0x19
+			MX8MP_IOMUXC_GPIO1_IO06__GPIO1_IO06			0x19
+			MX8MP_IOMUXC_GPIO1_IO07__GPIO1_IO07			0x19
+		>;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL				0x400001c2
+			MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA				0x400001c2
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C2_SCL__I2C2_SCL				0x400001c2
+			MX8MP_IOMUXC_I2C2_SDA__I2C2_SDA				0x400001c2
+		>;
+	};
+
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C3_SCL__I2C3_SCL				0x400001c2
+			MX8MP_IOMUXC_I2C3_SDA__I2C3_SDA				0x400001c2
+		>;
+	};
+
+	pinctrl_i2c4: i2c4grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C4_SCL__I2C4_SCL				0x400001c3
+			MX8MP_IOMUXC_I2C4_SDA__I2C4_SDA				0x400001c3
+		>;
+	};
+
+	pinctrl_pmic: pmicirqgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO03__GPIO1_IO03			0x41
+		>;
+	};
+
+	pinctrl_pwm1: pwm1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SPDIF_EXT_CLK__PWM1_OUT			0x116
+		>;
+	};
+
+	pinctrl_reg_sd2_vsel: regsd2vselgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO04__GPIO1_IO04			0x41
+		>;
+	};
+
+	pinctrl_rtc: rtcgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI3_TXFS__GPIO4_IO31			0x41
+		>;
+	};
+
+	pinctrl_switch: switchgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI3_TXC__GPIO5_IO00			0x41
+			MX8MP_IOMUXC_SAI3_TXD__GPIO5_IO01			0x41
+		>;
+	};
+
+	pinctrl_touchscreen: touchscreengrp {
+		fsl,pins = <
+			/* external 10 k pull up */
+			/* CTP_INT */
+			MX8MP_IOMUXC_SAI3_RXFS__GPIO4_IO28			0x41
+			/* CTP_RST */
+			MX8MP_IOMUXC_SAI3_RXC__GPIO4_IO29			0x41
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX			0x14f
+			MX8MP_IOMUXC_UART2_TXD__UART2_DCE_TX			0x14f
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK			0x190
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD			0x1d0
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0			0x1d0
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1			0x1d0
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2			0x1d0
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3			0x1d0
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK			0x194
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD			0x1d4
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0			0x1d4
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1			0x1d4
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2			0x1d4
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3			0x1d4
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK			0x196
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD			0x1d6
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0			0x1d6
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1			0x1d6
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2			0x1d6
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3			0x1d6
+		>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CD_B__GPIO2_IO12			0x1c4
+			MX8MP_IOMUXC_SD2_WP__GPIO2_IO20				0x1c4
+			MX8MP_IOMUXC_SD2_RESET_B__USDHC2_RESET_B		0x1c4
+		>;
+	};
+
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK			0x190
+			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD			0x1d0
+			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0			0x1d0
+			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1			0x1d0
+			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2			0x1d0
+			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3			0x1d0
+			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4			0x1d0
+			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5			0x1d0
+			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6			0x1d0
+			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7			0x1d0
+			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE			0x190
+		>;
+	};
+
+	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK			0x194
+			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD			0x1d4
+			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0			0x1d4
+			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1			0x1d4
+			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2			0x1d4
+			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3			0x1d4
+			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4			0x1d4
+			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5			0x1d4
+			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6			0x1d4
+			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7			0x1d4
+			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE			0x194
+		>;
+	};
+
+	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK			0x196
+			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD			0x1d6
+			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0			0x1d6
+			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1			0x1d6
+			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2			0x1d6
+			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3			0x1d6
+			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4			0x1d6
+			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5			0x1d6
+			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6			0x1d6
+			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7			0x1d6
+			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE			0x196
+		>;
+	};
+
+	pinctrl_wdog: wdoggrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO02__WDOG1_WDOG_B			0xc6
+		>;
+	};
+};
-- 
2.39.2

