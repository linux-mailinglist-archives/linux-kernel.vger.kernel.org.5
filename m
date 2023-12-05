Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5718F805425
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345046AbjLEM2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 07:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235254AbjLEM2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 07:28:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9F119AF
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 04:28:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C680C433C7;
        Tue,  5 Dec 2023 12:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701779283;
        bh=Lq9+YFD8ee/CPgqqk36XThTfc/xuSyQLSaprYPsaFug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KY1q7+rrLQGzsVbZXhBT/FMtamYxQwS52Jj105jVLMK8a0rGXVY12A74sCDCryKRb
         948XlUxkZRbh2OFwOjBMOdcU5yXgMmnAXA7n3dAryn7TZWaXXVPLyAqoZPXT3PqHXk
         bIqR5xuCvlUbY4d50YL0goJJ6RhPVxHxU/12Xxc6xPOUjRWEiqNd5iY2rPfFizahl8
         PhF8AQPvtdxD56yvldxAFfU4Ap392lTUp8xlpimanhz2oTG86gla5FSV2nAfY0h/Gg
         RJwPoWshqsKMKWL+g+jVFOPcRGwFabCE0v58uk5uEeMyERdScEZVKSA9p4bc54lQFZ
         9caorURlOetzA==
Date:   Tue, 5 Dec 2023 20:27:56 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, leoyang.li@nxp.com,
        robh@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v4 3/3] arm64: dts: freescale: introduce rve-gateway board
Message-ID: <20231205122756.GE236001@dragon>
References: <20231103142831.2116163-1-hugo@hugovil.com>
 <20231103142831.2116163-4-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103142831.2116163-4-hugo@hugovil.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 10:28:31AM -0400, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> The RVE gateway board is based on a Variscite VAR-SOM-NANO,
> with a NXP MX8MN nano CPU.
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../boot/dts/freescale/imx8mn-rve-gateway.dts | 282 ++++++++++++++++++
>  2 files changed, 283 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mn-rve-gateway.dts
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 300049037eb0..c99da779ef7b 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -98,6 +98,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mn-bsh-smm-s2pro.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mn-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mn-ddr3l-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mn-ddr4-evk.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mn-rve-gateway.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mn-tqma8mqnl-mba8mx.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mn-var-som-symphony.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mn-venice-gw7902.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-rve-gateway.dts b/arch/arm64/boot/dts/freescale/imx8mn-rve-gateway.dts
> new file mode 100644
> index 000000000000..186f54fd06c6
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mn-rve-gateway.dts
> @@ -0,0 +1,282 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2023 DimOnOff
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/usb/pd.h>
> +#include "imx8mn-var-som.dtsi"
> +
> +/ {
> +	model = "RVE gateway";
> +	compatible = "rve,rve-gateway", "variscite,var-som-mx8mn", "fsl,imx8mn";
> +
> +	crystal_duart_24m: crystal-duart-24m {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <24000000>;
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio_keys>;
> +
> +		key-enter {
> +			label = "enter";
> +			gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_ENTER>;
> +		};
> +
> +		key-exit {
> +			label = "exit";
> +			gpios = <&gpio3 23 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_ESC>;
> +		};
> +	};
> +
> +	lcd {
> +		compatible = "hit,hd44780";
> +		display-height-chars = <2>;
> +		display-width-chars = <20>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_lcd>;
> +		data-gpios = <&gpio5  1 GPIO_ACTIVE_HIGH>,
> +			     <&gpio1  6 GPIO_ACTIVE_HIGH>,
> +			     <&gpio1 14 GPIO_ACTIVE_HIGH>,
> +			     <&gpio4 28 GPIO_ACTIVE_HIGH>,
> +			     <&gpio5 24 GPIO_ACTIVE_HIGH>,
> +			     <&gpio5  2 GPIO_ACTIVE_HIGH>,
> +			     <&gpio1 12 GPIO_ACTIVE_HIGH>,
> +			     <&gpio5 25 GPIO_ACTIVE_HIGH>;
> +		enable-gpios = <&gpio5 23 GPIO_ACTIVE_HIGH>;
> +		rs-gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
> +		rw-gpios = <&gpio4 27 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	reg_3p3v: regulator-3p3v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "3P3V";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +	};
> +
> +	/* Bourns PEC12R rotary encoder, 24 steps. */
> +	rotary: rotary-encoder {
> +		compatible = "rotary-encoder";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_rotary>;
> +		gpios = <&gpio1  5 GPIO_ACTIVE_LOW>, /* A */
> +			<&gpio3 21 GPIO_ACTIVE_LOW>; /* B */
> +		linux,axis = <0>; /* REL_X */
> +		rotary-encoder,encoding = "gray";
> +		rotary-encoder,relative-axis;
> +	};
> +};
> +
> +&ecspi1 {
> +	cs-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
> +
> +	duart1: serial@0 {
> +		compatible = "nxp,sc16is752";
> +		reg = <0>;
> +		spi-rx-bus-width = <1>;
> +		spi-tx-bus-width = <1>;
> +		spi-max-frequency = <4000000>;
> +		clocks = <&crystal_duart_24m>;
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <22 IRQ_TYPE_EDGE_FALLING>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		gpio-line-names = "RADIO0", "RADIO1", "RADIO2", "RADIO3",
> +		"RADIO4", "RADIO_RESET", "TP12", "TP11";

Can we add some indent to get the line aligned with the first " above?
There are a few such lines that could be improved.

Shawn

> +		linux,rs485-enabled-at-boot-time;
> +		rs485-rts-active-low;
> +	};
> +
> +	/delete-node/ touchscreen@0;
> +};
> +
> +&ecspi2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_ecspi2>;
> +	cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
> +	/delete-property/ dmas;
> +	/delete-property/ dma-names;
> +	status = "okay";
> +
> +	duart2: serial@0 {
> +		compatible = "nxp,sc16is752";
> +		reg = <0>;
> +		spi-rx-bus-width = <1>;
> +		spi-tx-bus-width = <1>;
> +		spi-max-frequency = <4000000>;
> +		clocks = <&crystal_duart_24m>;
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <20 IRQ_TYPE_EDGE_FALLING>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		gpio-line-names = "LED_B_USER", "LED_R_USER", "LED_G_USER",
> +		"GPIO_EXT3", "GPIO_EXT2", "GPIO_EXT1", "GPIO_EXT0", "TP13";
> +		linux,rs485-enabled-at-boot-time;
> +		rs485-rts-active-low;
> +	};
> +};
> +
> +/* Configure PWM pins in GPIO mode: */
> +&gpio5 {
> +	gpio-line-names = "", "", "", "PWM3", "PWM2", "PWM1";
> +};
> +
> +&gpu {
> +	status = "disabled";
> +};
> +
> +&i2c2 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	status = "okay";
> +
> +	/* Carrier board EEPROM */
> +	eeprom_cb: eeprom@56 {
> +		compatible = "atmel,24c04";
> +		reg = <0x56>;
> +		pagesize = <16>;
> +		vcc-supply = <&reg_3p3v>;
> +	};
> +
> +	lm75: sensor@48 {
> +		compatible = "st,stlm75";
> +		reg = <0x48>;
> +		vs-supply = <&reg_3p3v>;
> +	};
> +
> +	mcp7940: rtc@6f {
> +		compatible = "microchip,mcp7940x";
> +		reg = <0x6f>;
> +	};
> +};
> +
> +&i2c3 {
> +	codec@1a {
> +		status = "disabled";
> +	};
> +};
> +
> +&i2c4 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c4>;
> +	status = "okay";
> +
> +	pcf8574_1: gpio@38 {
> +		compatible = "nxp,pcf8574";
> +		reg = <0x38>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		gpio-line-names = "LED_B_COMM3", "LED_R_COMM3", "LED_G_COMM3",
> +		"TP14", "TP15", "LED_G_COMM4", "LED_R_COMM4", "LED_B_COMM4";
> +	};
> +
> +	pcf8574_2: gpio@39 {
> +		compatible = "nxp,pcf8574";
> +		reg = <0x39>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		gpio-line-names = "LED_B_COMM2", "LED_G_COMM2", "LED_B_COMM1",
> +		"LED_R_COMM2", "LED_R_COMM1", "LED_G_COMM1", "TP16", "TP17";
> +	};
> +};
> +
> +/* Bluetooth */
> +&uart2 {
> +	status = "disabled";
> +};
> +
> +&usbotg1 {
> +	dr_mode = "host";
> +	disable-over-current;
> +	status = "okay";
> +};
> +
> +/* SD interface on expansion connector. */
> +&usdhc2 {
> +	vmmc-supply = <&reg_3p3v>;
> +	cd-gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
> +};
> +
> +&iomuxc {
> +	pinctrl_ecspi1: ecspi1grp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_ECSPI1_SCLK_ECSPI1_SCLK	0x13
> +			MX8MN_IOMUXC_ECSPI1_MOSI_ECSPI1_MOSI	0x13
> +			MX8MN_IOMUXC_ECSPI1_MISO_ECSPI1_MISO	0x13
> +			MX8MN_IOMUXC_ECSPI1_SS0_GPIO5_IO9	0x13 /* SS0 */
> +			MX8MN_IOMUXC_SAI5_RXD1_GPIO3_IO22	0x13 /* SC16 IRQ */
> +		>;
> +	};
> +
> +	pinctrl_ecspi2: ecspi2grp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK	0x13
> +			MX8MN_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI	0x13
> +			MX8MN_IOMUXC_ECSPI2_MISO_ECSPI2_MISO	0x13
> +			MX8MN_IOMUXC_ECSPI2_SS0_GPIO5_IO13	0x13 /* SS0 */
> +			MX8MN_IOMUXC_SAI5_RXC_GPIO3_IO20	0x13 /* SC16 IRQ */
> +		>;
> +	};
> +
> +	pinctrl_gpio_keys: gpiokeysgrp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_GPIO1_IO01_GPIO1_IO1	0xc6 /* Enter */
> +			MX8MN_IOMUXC_SAI5_RXD2_GPIO3_IO23	0xc6 /* Exit */
> +		>;
> +	};
> +
> +	pinctrl_i2c2: i2c2grp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_I2C2_SCL_I2C2_SCL		0x400001c3
> +			MX8MN_IOMUXC_I2C2_SDA_I2C2_SDA		0x400001c3
> +		>;
> +	};
> +
> +	pinctrl_i2c4: i2c4grp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_I2C4_SCL_I2C4_SCL		0x400001c3
> +			MX8MN_IOMUXC_I2C4_SDA_I2C4_SDA		0x400001c3
> +		>;
> +	};
> +
> +	pinctrl_lcd: lcdgrp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_SAI3_TXD_GPIO5_IO1		0x00000156 /* D0 */
> +			MX8MN_IOMUXC_GPIO1_IO06_GPIO1_IO6	0x00000156 /* D1 */
> +			MX8MN_IOMUXC_GPIO1_IO14_GPIO1_IO14	0x00000156 /* D2 */
> +			MX8MN_IOMUXC_SAI3_RXFS_GPIO4_IO28	0x00000156 /* D3 */
> +			MX8MN_IOMUXC_UART2_RXD_GPIO5_IO24	0x00000156 /* D4 */
> +			MX8MN_IOMUXC_SAI3_MCLK_GPIO5_IO2	0x00000156 /* D5 */
> +			MX8MN_IOMUXC_GPIO1_IO12_GPIO1_IO12	0x00000156 /* D6 */
> +			MX8MN_IOMUXC_UART2_TXD_GPIO5_IO25	0x00000156 /* D7 */
> +			MX8MN_IOMUXC_UART1_TXD_GPIO5_IO23	0x00000156 /* E */
> +			MX8MN_IOMUXC_GPIO1_IO07_GPIO1_IO7	0x00000156 /* RS */
> +			MX8MN_IOMUXC_SAI2_MCLK_GPIO4_IO27	0x00000156 /* R/W */
> +		>;
> +	};
> +
> +	pinctrl_rotary: rotarygrp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_GPIO1_IO05_GPIO1_IO5	0x00000156 /* A */
> +			MX8MN_IOMUXC_SAI5_RXD0_GPIO3_IO21	0x00000156 /* B */
> +		>;
> +	};
> +
> +	/* Override Card Detect function GPIO value (GPIO1_IO10) from SOM: */
> +	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_GPIO1_IO13_GPIO1_IO13	0x41
> +		>;
> +	};
> +};
> -- 
> 2.39.2
> 
