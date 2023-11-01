Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598DD7DE3A7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbjKAOn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 10:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbjKAOn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 10:43:26 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452DB10F;
        Wed,  1 Nov 2023 07:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:subject:date:message-id:reply-to;
        bh=8RNS0hqFN+iCI6IdSzb7+XJceHBMkqsvElBAnf7jB7E=; b=CQ2BmGqQ0EiEgikPKMZnk2GF+F
        3A4lpIAKOyElofJM2YkqJPUaXXx6Am34hgsG3UyFT+Mv2MMa9pRnEUk9SzqQwzSCcdAZRHW/eYnWO
        Hujy+JgO0gwz4y2QG7j81JWHUufAusR7wHkun740ZseSIPmDOZeFzOy2y9Togs59Xy8k=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:54820 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qyCQy-0006Jp-Ks; Wed, 01 Nov 2023 10:43:09 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>
Cc:     hugo@hugovil.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Wed,  1 Nov 2023 10:43:02 -0400
Message-Id: <20231101144303.2653464-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH] arm64: dts: imx8mn-rve-gateway: add support for RVE gateway board
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

The RVE gateway board is based on a Variscite VAR-SOM-NANO,
with a NXP MX8MN nano CPU.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 .../devicetree/bindings/arm/fsl.yaml          |   1 +
 MAINTAINERS                                   |   7 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../boot/dts/freescale/imx8mn-rve-gateway.dts | 296 ++++++++++++++++++
 4 files changed, 305 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mn-rve-gateway.dts

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 9450b2c8a678..a1028fe8ed02 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1007,6 +1007,7 @@ properties:
               - fsl,imx8mn-ddr4-evk       # i.MX8MN DDR4 EVK Board
               - fsl,imx8mn-evk            # i.MX8MN LPDDR4 EVK Board
               - gw,imx8mn-gw7902          # i.MX8MM Gateworks Board
+              - rve,rve-gateway           # i.MX8MN RVE Gateway Board
           - const: fsl,imx8mn
 
       - description: Variscite VAR-SOM-MX8MN based boards
diff --git a/MAINTAINERS b/MAINTAINERS
index 43c5ed3c4508..9423b1bf35fc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18778,6 +18778,13 @@ F:	samples/rust/
 F:	scripts/*rust*
 K:	\b(?i:rust)\b
 
+RVE BOARD SUPPORT
+M:	Hugo Villeneuve <hvilleneuve@dimonoff.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Supported
+W:	https://rve.ca
+F:	arch/arm64/boot/dts/freescale/imx*rve-*.dts*
+
 RXRPC SOCKETS (AF_RXRPC)
 M:	David Howells <dhowells@redhat.com>
 M:	Marc Dionne <marc.dionne@auristor.com>
diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 89aee6c92576..760a0ca7adc3 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -89,6 +89,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mn-bsh-smm-s2pro.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-ddr3l-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-ddr4-evk.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mn-rve-gateway.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-tqma8mqnl-mba8mx.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-var-som-symphony.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-venice-gw7902.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-rve-gateway.dts b/arch/arm64/boot/dts/freescale/imx8mn-rve-gateway.dts
new file mode 100644
index 000000000000..c3c2ff80d650
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mn-rve-gateway.dts
@@ -0,0 +1,296 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2023 DimOnOff
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/usb/pd.h>
+#include "imx8mn-var-som.dtsi"
+
+/ {
+	model = "RVE gateway";
+	compatible = "rve,rve-gateway", "fsl,imx8mn";
+
+	crystal_duart_24m: crystal-duart-24m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_keys>;
+		status = "okay";
+
+		key-enter {
+			label = "enter";
+			gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_ENTER>;
+		};
+
+		key-exit {
+			label = "exit";
+			gpios = <&gpio3 23 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_ESC>;
+		};
+	};
+
+	lcd {
+		compatible = "hit,hd44780";
+		display-height-chars = <2>;
+		display-width-chars = <20>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_lcd>;
+		data-gpios =
+			<&gpio5  1 GPIO_ACTIVE_HIGH>,
+			<&gpio1  6 GPIO_ACTIVE_HIGH>,
+			<&gpio1 14 GPIO_ACTIVE_HIGH>,
+			<&gpio4 28 GPIO_ACTIVE_HIGH>,
+			<&gpio5 24 GPIO_ACTIVE_HIGH>,
+			<&gpio5  2 GPIO_ACTIVE_HIGH>,
+			<&gpio1 12 GPIO_ACTIVE_HIGH>,
+			<&gpio5 25 GPIO_ACTIVE_HIGH>;
+		enable-gpios = <&gpio5 23 GPIO_ACTIVE_HIGH>;
+		rs-gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
+		rw-gpios = <&gpio4 27 GPIO_ACTIVE_HIGH>;
+	};
+
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "3P3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		};
+
+	reg_5v: regulator-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
+	rotary: rotary-encoder { /* Bourns PEC12R rotary encoder, 24 steps. */
+		compatible = "rotary-encoder";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_rotary>;
+		gpios =
+			<&gpio1  5 GPIO_ACTIVE_LOW>, /* A */
+			<&gpio3 21 GPIO_ACTIVE_LOW>; /* B */
+		linux,axis = <0>; /* REL_X */
+		rotary-encoder,encoding = "gray";
+		rotary-encoder,relative-axis;
+	};
+};
+
+&ecspi1 {
+	cs-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
+
+	duart1: serial@0 {
+		compatible = "nxp,sc16is752";
+		reg = <0>;
+		spi-rx-bus-width = <1>;
+		spi-tx-bus-width = <1>;
+		spi-max-frequency = <4000000>;
+		clocks = <&crystal_duart_24m>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <22 IRQ_TYPE_EDGE_FALLING>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "RADIO0", "RADIO1", "RADIO2", "RADIO3",
+		"RADIO4", "RADIO_RESET", "TP12", "TP11";
+		linux,rs485-enabled-at-boot-time;
+		rs485-rts-active-low;
+	};
+
+	/delete-node/ touchscreen@0;
+};
+
+&ecspi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi2>;
+	cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
+	/delete-property/ dmas;
+	/delete-property/ dma-names;
+	status = "okay";
+
+	duart2: serial@0 {
+		compatible = "nxp,sc16is752";
+		reg = <0>;
+		spi-rx-bus-width = <1>;
+		spi-tx-bus-width = <1>;
+		spi-max-frequency = <4000000>;
+		clocks = <&crystal_duart_24m>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <20 IRQ_TYPE_EDGE_FALLING>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "LED_B_USER", "LED_R_USER", "LED_G_USER",
+		"GPIO_EXT3", "GPIO_EXT2", "GPIO_EXT1", "GPIO_EXT0", "TP13";
+		linux,rs485-enabled-at-boot-time;
+		rs485-rts-active-low;
+	};
+};
+
+/* Configure PWM pins in GPIO mode: */
+&gpio5 {
+	gpio-line-names = "", "", "", "PWM3", "PWM2", "PWM1";
+};
+
+&gpu {
+	status = "disabled";
+};
+
+&i2c2 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+
+	eeprom_cb: eeprom@56 { /* Carrier board EEPROM */
+		compatible = "atmel,24c04";
+		reg = <0x56>;
+		pagesize = <16>;
+		vcc-supply = <&reg_3p3v>;
+	};
+
+	lm75: sensor@48 {
+		compatible = "st,stlm75";
+		reg = <0x48>;
+		vs-supply = <&reg_3p3v>;
+	};
+
+	mcp7940: rtc@6f {
+		compatible = "microchip,mcp7940x";
+		reg = <0x6f>;
+	};
+};
+
+&i2c3 {
+	codec@1a {
+		status = "disabled";
+	};
+};
+
+&i2c4 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c4>;
+	status = "okay";
+
+	pcf8574_1: gpio@38 {
+		status = "okay";
+		compatible = "nxp,pcf8574";
+		reg = <0x38>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "LED_B_COMM3", "LED_R_COMM3", "LED_G_COMM3",
+		"TP14", "TP15", "LED_G_COMM4", "LED_R_COMM4", "LED_B_COMM4";
+	};
+
+	pcf8574_2: gpio@39 {
+		status = "okay";
+		compatible = "nxp,pcf8574";
+		reg = <0x39>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "LED_B_COMM2", "LED_G_COMM2", "LED_B_COMM1",
+		"LED_R_COMM2", "LED_R_COMM1", "LED_G_COMM1", "TP16", "TP17";
+	};
+};
+
+&uart2 {
+	/delete-node/ bluetooth;
+};
+
+&usbotg1 {
+	dr_mode = "host";
+	disable-over-current;
+	status = "okay";
+};
+
+&usbphynop1 {
+	vbus-supply = <&reg_5v>;
+};
+
+/* SD interface on expansion connector. */
+&usdhc2 {
+	/delete-property/vmmc-supply;
+	cd-gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
+};
+
+&iomuxc {
+	pinctrl_ecspi1: ecspi1grp {
+		fsl,pins = <
+			MX8MN_IOMUXC_ECSPI1_SCLK_ECSPI1_SCLK	0x13
+			MX8MN_IOMUXC_ECSPI1_MOSI_ECSPI1_MOSI	0x13
+			MX8MN_IOMUXC_ECSPI1_MISO_ECSPI1_MISO	0x13
+			MX8MN_IOMUXC_ECSPI1_SS0_GPIO5_IO9	0x13 /* SS0 */
+			MX8MN_IOMUXC_SAI5_RXD1_GPIO3_IO22	0x13 /* SC16 IRQ */
+		>;
+	};
+
+	pinctrl_ecspi2: ecspi2grp {
+		fsl,pins = <
+			MX8MN_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK	0x13
+			MX8MN_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI	0x13
+			MX8MN_IOMUXC_ECSPI2_MISO_ECSPI2_MISO	0x13
+			MX8MN_IOMUXC_ECSPI2_SS0_GPIO5_IO13	0x13 /* SS0 */
+			MX8MN_IOMUXC_SAI5_RXC_GPIO3_IO20	0x13 /* SC16 IRQ */
+		>;
+	};
+
+	pinctrl_gpio_keys: gpiokeysgrp {
+		fsl,pins = <
+			MX8MN_IOMUXC_GPIO1_IO01_GPIO1_IO1	0xc6 /* Enter */
+			MX8MN_IOMUXC_SAI5_RXD2_GPIO3_IO23	0xc6 /* Exit */
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX8MN_IOMUXC_I2C2_SCL_I2C2_SCL		0x400001c3
+			MX8MN_IOMUXC_I2C2_SDA_I2C2_SDA		0x400001c3
+		>;
+	};
+
+	pinctrl_i2c4: i2c4grp {
+		fsl,pins = <
+			MX8MN_IOMUXC_I2C4_SCL_I2C4_SCL		0x400001c3
+			MX8MN_IOMUXC_I2C4_SDA_I2C4_SDA		0x400001c3
+		>;
+	};
+
+	pinctrl_lcd: lcdgrp {
+		fsl,pins = <
+			MX8MN_IOMUXC_SAI3_TXD_GPIO5_IO1		0x00000156 /* D0 */
+			MX8MN_IOMUXC_GPIO1_IO06_GPIO1_IO6	0x00000156 /* D1 */
+			MX8MN_IOMUXC_GPIO1_IO14_GPIO1_IO14	0x00000156 /* D2 */
+			MX8MN_IOMUXC_SAI3_RXFS_GPIO4_IO28	0x00000156 /* D3 */
+			MX8MN_IOMUXC_UART2_RXD_GPIO5_IO24	0x00000156 /* D4 */
+			MX8MN_IOMUXC_SAI3_MCLK_GPIO5_IO2	0x00000156 /* D5 */
+			MX8MN_IOMUXC_GPIO1_IO12_GPIO1_IO12	0x00000156 /* D6 */
+			MX8MN_IOMUXC_UART2_TXD_GPIO5_IO25	0x00000156 /* D7 */
+			MX8MN_IOMUXC_UART1_TXD_GPIO5_IO23	0x00000156 /* E */
+			MX8MN_IOMUXC_GPIO1_IO07_GPIO1_IO7	0x00000156 /* RS */
+			MX8MN_IOMUXC_SAI2_MCLK_GPIO4_IO27	0x00000156 /* R/W */
+		>;
+	};
+
+	pinctrl_rotary: rotarygrp {
+		fsl,pins = <
+			MX8MN_IOMUXC_GPIO1_IO05_GPIO1_IO5	0x00000156 /* A */
+			MX8MN_IOMUXC_SAI5_RXD0_GPIO3_IO21	0x00000156 /* B */
+		>;
+	};
+
+	/* Override Card Detect function GPIO value (GPIO1_IO10) from SOM: */
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
+		fsl,pins = <
+			MX8MN_IOMUXC_GPIO1_IO13_GPIO1_IO13	0x41
+		>;
+	};
+};

base-commit: 8bc9e6515183935fa0cccaf67455c439afe4982b
prerequisite-patch-id: dda91c667eaa02f7138968786ba9f55b8f45d952
-- 
2.39.2

