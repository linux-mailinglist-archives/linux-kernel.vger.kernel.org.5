Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F777558D6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 02:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjGQA1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 20:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjGQA1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 20:27:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037D5E47;
        Sun, 16 Jul 2023 17:27:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9158860EEB;
        Mon, 17 Jul 2023 00:27:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9EAEC433C7;
        Mon, 17 Jul 2023 00:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689553649;
        bh=MnwJbrJBSLLwi3zAnrLfxHaMnXRDPm/p+wQrg7rQD9Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DW2rlI7JE0CFcM8fr/RjgwTm7K+HMsjdECJxX08FTWk3oFxmjWArqbVa1pqsEyGYQ
         kADauS7O9L6klN+HA26YIFsdY0RnB3MKStCJEpQfb/M6uor+5kFD6wFPlE6b4AaNyr
         CUQmrhvERlpMEDg7xrtmBPANzR1EYGhy4eKapX6xnsTmOwPSzf5Y9dsTZq6tF6XpG1
         d2w8Vs3LzQyNianbVc4JRJ2Xb+I0Z6Bg971yFEkz0Py5254beo+xdTCYBufvw9nn1r
         O649qArpg2Zp9FzPqX1fYnxVa0BXwk6L7fqhuArYTQixY2E0mZyKfh30Bwfq6OXAfu
         8TbLcTMVxetvA==
Date:   Mon, 17 Jul 2023 08:27:17 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: freescale: Add imx8mp-venice-gw71xx-2x
Message-ID: <20230717002717.GI9559@dragon>
References: <20230607170724.2016988-1-tharvey@gateworks.com>
 <20230607170724.2016988-2-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607170724.2016988-2-tharvey@gateworks.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 10:07:24AM -0700, Tim Harvey wrote:
> The Gateworks imx8mp-venice-gw71xx-2x consists of a SOM + baseboard.
> 
> The GW702x SOM contains the following:
>  - i.MX8M Plus SoC
>  - LPDDR4 memory
>  - eMMC Boot device
>  - Gateworks System Controller (GSC) with integrated EEPROM, button
>    controller, and ADC's
>  - PMIC
>  - SOM connector providing:
>   - eQoS GbE MII
>   - 1x SPI
>   - 2x I2C
>   - 4x UART
>   - 2x USB 3.0
>   - 1x PCI
>   - 1x SDIO (4-bit 3.3V)
>   - 1x SDIO (4-bit 3.3V/1.8V)
>   - GPIO
> 
> The GW71xx Baseboard contains the following:
>  - GPS
>  - RJ45 GbE (eQoS)
>  - off-board I/O connector with UART, I2C, SPI, GPIO
>  - EERPOM
>  - PCIe clock generator
>  - full-length miniPCIe socket with PCI/USB3 (via mux) and USB2.0
>  - USB Type-C with USB 2.0 host and peripheral support
>  - Wide range DC input supply
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../dts/freescale/imx8mp-venice-gw71xx-2x.dts |  19 ++
>  .../dts/freescale/imx8mp-venice-gw71xx.dtsi   | 236 ++++++++++++++++++
>  3 files changed, 256 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-venice-gw71xx-2x.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-venice-gw71xx.dtsi
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 62f22b77b38b..b3bb823d0168 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -101,6 +101,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-icore-mx8mp-edimm2.2.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-msc-sm2s-ep1.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-tqma8mpql-mba8mpxl.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mp-venice-gw71xx-2x.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-venice-gw74xx.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-venice-gw7905-2x.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-verdin-nonwifi-dahlia.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw71xx-2x.dts b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw71xx-2x.dts
> new file mode 100644
> index 000000000000..53120fc9cd7f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw71xx-2x.dts
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2023 Gateworks Corporation
> + */
> +
> +/dts-v1/;
> +
> +#include "imx8mp.dtsi"
> +#include "imx8mp-venice-gw702x.dtsi"
> +#include "imx8mp-venice-gw71xx.dtsi"
> +
> +/ {
> +	model = "Gateworks Venice GW71xx-2x i.MX8MP Development Kit";
> +	compatible = "gateworks,imx8mp-gw71xx-2x", "fsl,imx8mp";
> +
> +	chosen {
> +		stdout-path = &uart2;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw71xx.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw71xx.dtsi
> new file mode 100644
> index 000000000000..86999f52d4b2
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw71xx.dtsi
> @@ -0,0 +1,236 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2023 Gateworks Corporation
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/phy/phy-imx8-pcie.h>
> +
> +/ {
> +	led-controller {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio_leds>;
> +
> +		led-0 {
> +			function = LED_FUNCTION_STATUS;
> +			color = <LED_COLOR_ID_GREEN>;
> +			gpios = <&gpio4 1 GPIO_ACTIVE_HIGH>;
> +			default-state = "on";
> +			linux,default-trigger = "heartbeat";
> +		};
> +
> +		led-1 {
> +			function = LED_FUNCTION_STATUS;
> +			color = <LED_COLOR_ID_RED>;
> +			gpios = <&gpio4 5 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +	};
> +
> +	pcie0_refclk: pcie0-refclk {

Can we name the node clock-xxx?

> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <100000000>;
> +	};
> +
> +	pps {
> +		compatible = "pps-gpio";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_pps>;
> +		gpios = <&gpio4 3 GPIO_ACTIVE_HIGH>;
> +		status = "okay";
> +	};
> +};
> +
> +/* off-board header */
> +&ecspi2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_spi2>;
> +	cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +};
> +
> +&gpio4 {
> +	gpio-line-names =
> +		"", "", "", "",
> +		"", "", "", "",
> +		"dio1", "", "", "dio0",
> +		"", "", "pci_usb_sel", "",
> +		"", "", "", "",
> +		"", "", "", "",
> +		"dio3", "", "dio2", "",
> +		"pci_wdis#", "", "", "";
> +};
> +
> +&i2c2 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	status = "okay";
> +
> +	accelerometer@19 {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_accel>;
> +		compatible = "st,lis2de12";
> +		reg = <0x19>;

Can we start the property list from these two?

> +		st,drdy-int-pin = <1>;
> +		interrupt-parent = <&gpio4>;
> +		interrupts = <21 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-names = "INT1";
> +	};
> +};
> +
> +&pcie_phy {
> +	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_INPUT>;
> +	fsl,clkreq-unsupported;
> +	clocks = <&pcie0_refclk>;
> +	clock-names = "ref";
> +	status = "okay";
> +};
> +
> +&pcie {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pcie0>;
> +	reset-gpio = <&gpio4 29 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +};
> +
> +/* GPS */
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	status = "okay";
> +};
> +
> +/* off-board header */
> +&uart3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart3>;
> +	status = "okay";
> +};
> +
> +/* USB1 Type-C front panel */
> +&usb3_0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usb1>;
> +	fsl,over-current-active-low;
> +	status = "okay";
> +};
> +
> +&usb3_phy0 {
> +	status = "okay";
> +};
> +
> +&usb_dwc3_0 {
> +	/* dual role is implemented but not a full featured OTG */
> +	adp-disable;
> +	hnp-disable;
> +	srp-disable;
> +	dr_mode = "otg";
> +	usb-role-switch;
> +	role-switch-default-mode = "peripheral";
> +	status = "okay";
> +
> +	connector {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_usbcon1>;
> +		compatible = "gpio-usb-b-connector", "usb-b-connector";

Start the properties from 'compatible'?

Shawn

> +		type = "micro";
> +		label = "Type-C";
> +		id-gpios = <&gpio3 21 GPIO_ACTIVE_HIGH>;
> +	};
> +};
> +
> +/* USB2 - MiniPCIe socket */
> +&usb3_1 {
> +	fsl,permanently-attached;
> +	fsl,disable-port-power-control;
> +	status = "okay";
> +};
> +
> +&usb3_phy1 {
> +	status = "okay";
> +};
> +
> +&usb_dwc3_1 {
> +	dr_mode = "host";
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_hog>;
> +
> +	pinctrl_hog: hoggrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SAI1_RXD6__GPIO4_IO08	0x40000146 /* DIO1 */
> +			MX8MP_IOMUXC_SAI1_TXC__GPIO4_IO11	0x40000146 /* DIO0 */
> +			MX8MP_IOMUXC_SAI1_TXD2__GPIO4_IO14	0x40000106 /* PCIE_USBSEL */
> +			MX8MP_IOMUXC_SAI2_TXD0__GPIO4_IO26	0x40000146 /* DIO2 */
> +			MX8MP_IOMUXC_SAI2_TXFS__GPIO4_IO24	0x40000146 /* DIO3 */
> +			MX8MP_IOMUXC_SAI3_RXFS__GPIO4_IO28	0x40000106 /* PCIE_WDIS# */
> +		>;
> +	};
> +
> +	pinctrl_accel: accelgrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SAI2_RXFS__GPIO4_IO21	0x150	/* IRQ */
> +		>;
> +	};
> +
> +	pinctrl_gpio_leds: gpioledgrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SAI1_RXC__GPIO4_IO01	0x6	/* LEDG */
> +			MX8MP_IOMUXC_SAI1_RXD3__GPIO4_IO05	0x6	/* LEDR */
> +		>;
> +	};
> +
> +	pinctrl_pcie0: pcie0grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SAI3_RXC__GPIO4_IO29	0x106
> +		>;
> +	};
> +
> +	pinctrl_pps: ppsgrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SAI1_RXD1__GPIO4_IO03	0x146
> +		>;
> +	};
> +
> +	pinctrl_usb1: usb1grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_GPIO1_IO13__USB1_OTG_OC	0x140 /* USB1_FLT# */
> +		>;
> +	};
> +
> +	pinctrl_usbcon1: usbcon1grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SAI5_RXD0__GPIO3_IO21	0x140 /* USB1_ID */
> +		>;
> +	};
> +
> +	pinctrl_spi2: spi2grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_ECSPI2_SCLK__ECSPI2_SCLK	0x140
> +			MX8MP_IOMUXC_ECSPI2_MOSI__ECSPI2_MOSI	0x140
> +			MX8MP_IOMUXC_ECSPI2_MISO__ECSPI2_MISO	0x140
> +			MX8MP_IOMUXC_ECSPI2_SS0__GPIO5_IO13	0x140
> +		>;
> +	};
> +
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_UART1_RXD__UART1_DCE_RX	0x140
> +			MX8MP_IOMUXC_UART1_TXD__UART1_DCE_TX	0x140
> +		>;
> +	};
> +
> +	pinctrl_uart3: uart3grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_UART3_RXD__UART3_DCE_RX	0x140
> +			MX8MP_IOMUXC_UART3_TXD__UART3_DCE_TX	0x140
> +		>;
> +	};
> +};
> -- 
> 2.25.1
> 
