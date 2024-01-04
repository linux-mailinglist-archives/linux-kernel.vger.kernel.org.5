Return-Path: <linux-kernel+bounces-16404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E41E1823DF7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60CA22865C3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC751E51F;
	Thu,  4 Jan 2024 08:55:58 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFC01EA84
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 08:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1rLJVh-0005hm-Jk; Thu, 04 Jan 2024 09:55:29 +0100
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1rLJVg-000Iwm-DA; Thu, 04 Jan 2024 09:55:28 +0100
Received: from mfe by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1rLJVg-00ABeg-AQ; Thu, 04 Jan 2024 09:55:28 +0100
Date: Thu, 4 Jan 2024 09:55:28 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Mathieu Othacehe <othacehe@gnu.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, Li Yang <leoyang.li@nxp.com>,
	Stefan Wahren <wahrenst@gmx.net>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 2/2] arm64: dts: imx93-var-som: Add Variscite
 VAR-SOM-MX93
Message-ID: <20240104085528.dv4a4f24meqkezjc@pengutronix.de>
References: <20240103202243.26994-1-othacehe@gnu.org>
 <20240103202243.26994-3-othacehe@gnu.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103202243.26994-3-othacehe@gnu.org>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Mathieu,

thanks for your patch, please see below.

On 24-01-03, Mathieu Othacehe wrote:
> Add DTSI for Variscite VAR-SOM-MX93 System on Module and DTS for Variscite
> VAR-SOM-MX93 on Symphony evaluation board.
> 
> This version comes with:
> - NXP i.MX 93 Dual, 1.7GHz, Cortex-A55 + Cortex-M33
> - 2 GB of RAM
> - 16GB eMMC
> - 802.11ax/ac/a/b/g/n WiFi with 5.3 Bluetooth
> - CAN bus
> - Audio codec
> 
> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../dts/freescale/imx93-var-som-symphony.dts  | 351 ++++++++++++++++++
>  .../boot/dts/freescale/imx93-var-som.dtsi     | 111 ++++++
>  3 files changed, 463 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx93-var-som-symphony.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx93-var-som.dtsi
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 2e027675d7bb..a6f1700961e3 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -203,6 +203,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx93-11x11-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxca.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx93-var-som-symphony.dtb
>  
>  imx8mm-venice-gw72xx-0x-imx219-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-imx219.dtbo
>  imx8mm-venice-gw72xx-0x-rpidsi-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-rpidsi.dtbo
> diff --git a/arch/arm64/boot/dts/freescale/imx93-var-som-symphony.dts b/arch/arm64/boot/dts/freescale/imx93-var-som-symphony.dts
> new file mode 100644
> index 000000000000..3ee2f4402b6d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx93-var-som-symphony.dts
> @@ -0,0 +1,351 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2021 NXP
> + * Copyright 2023 Variscite Ltd.
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/leds/common.h>
> +#include "imx93-var-som.dtsi"
> +
> +/{
> +	model = "Variscite VAR-SOM-MX93 on Symphony evaluation board";
> +	compatible = "variscite,var-som-mx93-symphony",
> +		     "variscite,var-som-mx93", "fsl,imx93";
> +
> +	aliases {
> +		ethernet0 = &eqos;
> +		ethernet1 = &fec;
> +	};
> +
> +	chosen {
> +		stdout-path = &lpuart1;
> +	};
> +
> +	/*
> +	 * Needed only for Symphony <= v1.5
> +	 */
> +	reg_fec_phy: regulator-fec-phy {
> +		compatible = "regulator-fixed";
> +		regulator-name = "fec-phy";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-enable-ramp-delay = <20000>;
> +		gpio = <&pca9534 7 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		regulator-always-on;
> +	};
> +
> +	reg_usdhc2_vmmc: regulator-usdhc2 {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
> +		regulator-name = "VSD_3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio2 18 GPIO_ACTIVE_HIGH>;
> +		off-on-delay-us = <20000>;
> +		enable-active-high;
> +	};
> +
> +	reg_vref_1v8: regulator-adc-vref {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vref_1v8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		ethosu_mem: ethosu-region@88000000 {
> +			compatible = "shared-dma-pool";
> +			reusable;
> +			reg = <0x0 0x88000000 0x0 0x8000000>;
> +		};
> +
> +		vdev0vring0: vdev0vring0@87ee0000 {
> +			reg = <0 0x87ee0000 0 0x8000>;
> +			no-map;
> +		};
> +
> +		vdev0vring1: vdev0vring1@87ee8000 {
> +			reg = <0 0x87ee8000 0 0x8000>;
> +			no-map;
> +		};
> +
> +		vdev1vring0: vdev1vring0@87ef0000 {
> +			reg = <0 0x87ef0000 0 0x8000>;
> +			no-map;
> +		};
> +
> +		vdev1vring1: vdev1vring1@87ef8000 {
> +			reg = <0 0x87ef8000 0 0x8000>;
> +			no-map;
> +		};
> +
> +		rsc_table: rsc-table@2021f000 {
> +			reg = <0 0x2021f000 0 0x1000>;
> +			no-map;
> +		};
> +
> +		vdevbuffer: vdevbuffer@87f00000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0 0x87f00000 0 0x100000>;
> +			no-map;
> +		};
> +
> +		ele_reserved: ele-reserved@87de0000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0 0x87de0000 0 0x100000>;
> +			no-map;
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		key-back {
> +			label = "Back";
> +			gpios = <&pca9534 1 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_BACK>;
> +		};
> +
> +		key-home {
> +			label = "Home";
> +			gpios = <&pca9534 2 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_HOME>;
> +		};
> +
> +		key-menu {
> +			label = "Menu";
> +			gpios = <&pca9534 3 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_MENU>;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led-0 {
> +			function = LED_FUNCTION_STATUS;
> +			color = <LED_COLOR_ID_GREEN>;
> +			gpios = <&pca9534 0 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +};
> +
> +/* Use external instead of internal RTC*/
> +&bbnsm_rtc {
> +	status = "disabled";
> +};
> +
> +&eqos {
> +	mdio {
> +		ethphy1: ethernet-phy@5 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			reg = <5>;
> +			qca,disable-smarteee;
> +			eee-broken-1000t;
> +			reset-gpios = <&pca9534 5 GPIO_ACTIVE_LOW>;
> +			reset-assert-us = <10000>;
> +			reset-deassert-us = <20000>;
> +			vddio-supply = <&vddio1>;
> +
> +			vddio1: vddio-regulator {
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +			};
> +		};
> +	};
> +};
> +
> +&fec {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_fec>;
> +	phy-mode = "rgmii";
> +	phy-handle = <&ethphy1>;
> +	phy-supply = <&reg_fec_phy>;
> +	status = "okay";
> +};
> +
> +&flexcan1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_flexcan1>;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl_fec: fecgrp {
> +		fsl,pins = <
> +			MX93_PAD_ENET2_RD0__ENET1_RGMII_RD0		0x57e
> +			MX93_PAD_ENET2_RD1__ENET1_RGMII_RD1		0x57e
> +			MX93_PAD_ENET2_RD2__ENET1_RGMII_RD2		0x57e
> +			MX93_PAD_ENET2_RD3__ENET1_RGMII_RD3		0x57e
> +			MX93_PAD_ENET2_RXC__ENET1_RGMII_RXC		0x5fe
> +			MX93_PAD_ENET2_RX_CTL__ENET1_RGMII_RX_CTL	0x57e
> +			MX93_PAD_ENET2_TD0__ENET1_RGMII_TD0		0x57e
> +			MX93_PAD_ENET2_TD1__ENET1_RGMII_TD1		0x57e
> +			MX93_PAD_ENET2_TD2__ENET1_RGMII_TD2		0x57e
> +			MX93_PAD_ENET2_TD3__ENET1_RGMII_TD3		0x57e
> +			MX93_PAD_ENET2_TXC__ENET1_RGMII_TXC		0x5fe
> +			MX93_PAD_ENET2_TX_CTL__ENET1_RGMII_TX_CTL	0x57e
> +		>;
> +	};
> +
> +	pinctrl_flexcan1: flexcan1grp {
> +		fsl,pins = <
> +			MX93_PAD_PDM_CLK__CAN1_TX                       0x139e
> +			MX93_PAD_PDM_BIT_STREAM0__CAN1_RX               0x139e
> +		>;
> +	};
> +
> +	pinctrl_lpi2c1: lpi2c1grp {
> +		fsl,pins = <
> +			MX93_PAD_I2C1_SCL__LPI2C1_SCL			0x40000b9e
> +			MX93_PAD_I2C1_SDA__LPI2C1_SDA			0x40000b9e
> +		>;
> +	};
> +
> +	pinctrl_lpi2c1_gpio: lpi2c1gpiogrp {
> +		fsl,pins = <
> +			MX93_PAD_I2C1_SCL__GPIO1_IO00			0x31e
> +			MX93_PAD_I2C1_SDA__GPIO1_IO01			0x31e
> +		>;
> +	};
> +
> +	pinctrl_lpi2c5: lpi2c5grp {
> +		fsl,pins = <
> +			MX93_PAD_GPIO_IO23__LPI2C5_SCL			0x40000b9e
> +			MX93_PAD_GPIO_IO22__LPI2C5_SDA			0x40000b9e
> +		>;
> +	};
> +
> +	pinctrl_lpi2c5_gpio: lpi2c5gpiogrp {
> +		fsl,pins = <
> +			MX93_PAD_GPIO_IO23__GPIO2_IO23			0x31e
> +			MX93_PAD_GPIO_IO22__GPIO2_IO22			0x31e
> +		>;
> +	};
> +
> +	pinctrl_pca9534: pca9534grp {
> +		fsl,pins = <
> +			MX93_PAD_CCM_CLKO1__GPIO3_IO26		0x31e
> +		>;
> +	};
> +
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins = <
> +			MX93_PAD_UART1_RXD__LPUART1_RX			0x31e
> +			MX93_PAD_UART1_TXD__LPUART1_TX			0x31e
> +		>;
> +	};
> +
> +	pinctrl_uart6: uart6grp {
> +		fsl,pins = <
> +			MX93_PAD_GPIO_IO05__LPUART6_RX			0x31e
> +			MX93_PAD_GPIO_IO04__LPUART6_TX			0x31e
> +		>;
> +	};
> +
> +	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
> +		fsl,pins = <
> +			MX93_PAD_GPIO_IO18__GPIO2_IO18		0x31e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2: usdhc2grp {
> +		fsl,pins = <
> +			MX93_PAD_SD2_CLK__USDHC2_CLK		0x15fe
> +			MX93_PAD_SD2_CMD__USDHC2_CMD		0x13fe
> +			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x13fe
> +			MX93_PAD_SD2_DATA1__USDHC2_DATA1	0x13fe
> +			MX93_PAD_SD2_DATA2__USDHC2_DATA2	0x13fe
> +			MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x13fe
> +			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
> +		fsl,pins = <
> +			MX93_PAD_SD2_CD_B__GPIO3_IO00		0x31e
> +		>;
> +	};
> +};

Can you move the iomuxc node at the end of the file please? Same for the
som.dtsi file. DTS(I) files are sort alphabetical except for this node
(at least for i.MX dts(i) files).

Thanks,
  Marco

> +
> +&lpi2c1 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default", "sleep", "gpio";
> +	pinctrl-0 = <&pinctrl_lpi2c1>;
> +	pinctrl-1 = <&pinctrl_lpi2c1_gpio>;
> +	pinctrl-2 = <&pinctrl_lpi2c1_gpio>;
> +	scl-gpios = <&gpio1 0 GPIO_ACTIVE_HIGH>;
> +	sda-gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
> +	status = "okay";
> +
> +	/* DS1337 RTC module */
> +	rtc@68 {
> +		compatible = "dallas,ds1337";
> +		reg = <0x68>;
> +	};
> +};
> +
> +&lpi2c5 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default", "sleep", "gpio";
> +	pinctrl-0 = <&pinctrl_lpi2c5>;
> +	pinctrl-1 = <&pinctrl_lpi2c5_gpio>;
> +	pinctrl-2 = <&pinctrl_lpi2c5_gpio>;
> +	scl-gpios = <&gpio2 23 GPIO_ACTIVE_HIGH>;
> +	sda-gpios = <&gpio2 22 GPIO_ACTIVE_HIGH>;
> +	status = "okay";
> +
> +	pca9534: gpio@20 {
> +		compatible = "nxp,pca9534";
> +		reg = <0x20>;
> +		gpio-controller;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_pca9534>;
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
> +		#gpio-cells = <2>;
> +		wakeup-source;
> +	};
> +};
> +
> +/* Console */
> +&lpuart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	status = "okay";
> +};
> +
> +/* J18.7, J18.9 */
> +&lpuart6 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart6>;
> +	status = "okay";
> +};
> +
> +/* SD */
> +&usdhc2 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-1 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-2 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
> +	cd-gpios = <&gpio3 00 GPIO_ACTIVE_LOW>;
> +	vmmc-supply = <&reg_usdhc2_vmmc>;
> +	bus-width = <4>;
> +	status = "okay";
> +	no-sdio;
> +	no-mmc;
> +};
> +
> +/* Watchdog */
> +&wdog3 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx93-var-som.dtsi b/arch/arm64/boot/dts/freescale/imx93-var-som.dtsi
> new file mode 100644
> index 000000000000..6c77b886666b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx93-var-som.dtsi
> @@ -0,0 +1,111 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2022 NXP
> + * Copyright 2023 Variscite Ltd.
> + */
> +
> +/dts-v1/;
> +
> +#include "imx93.dtsi"
> +
> +/{
> +	model = "Variscite VAR-SOM-MX93 module";
> +	compatible = "variscite,var-som-mx93", "fsl,imx93";
> +
> +	mmc_pwrseq: mmc-pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		post-power-on-delay-ms = <100>;
> +		power-off-delay-us = <10000>;
> +		reset-gpios = <&gpio4 14 GPIO_ACTIVE_LOW>,	/* WIFI_RESET */
> +			      <&gpio3 7 GPIO_ACTIVE_LOW>;	/* WIFI_PWR_EN */
> +	};
> +
> +	reg_eqos_phy: regulator-eqos-phy {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_reg_eqos_phy>;
> +		regulator-name = "eth_phy_pwr";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio1 7 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		startup-delay-us = <100000>;
> +		regulator-always-on;
> +	};
> +};
> +
> +&eqos {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_eqos>;
> +	phy-mode = "rgmii";
> +	phy-handle = <&ethphy0>;
> +	phy-supply = <&reg_eqos_phy>;
> +	status = "okay";
> +
> +	mdio {
> +		compatible = "snps,dwmac-mdio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clock-frequency = <1000000>;
> +
> +		ethphy0: ethernet-phy@0 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			reg = <0>;
> +			eee-broken-1000t;
> +		};
> +	};
> +};
> +
> +&iomuxc {
> +	pinctrl_eqos: eqosgrp {
> +		fsl,pins = <
> +			MX93_PAD_ENET1_MDC__ENET_QOS_MDC			0x57e
> +			MX93_PAD_ENET1_MDIO__ENET_QOS_MDIO			0x57e
> +			MX93_PAD_ENET1_RD0__ENET_QOS_RGMII_RD0			0x57e
> +			MX93_PAD_ENET1_RD1__ENET_QOS_RGMII_RD1			0x57e
> +			MX93_PAD_ENET1_RD2__ENET_QOS_RGMII_RD2			0x57e
> +			MX93_PAD_ENET1_RD3__ENET_QOS_RGMII_RD3			0x57e
> +			MX93_PAD_ENET1_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK	0x5fe
> +			MX93_PAD_ENET1_RX_CTL__ENET_QOS_RGMII_RX_CTL		0x57e
> +			MX93_PAD_ENET1_TD0__ENET_QOS_RGMII_TD0			0x57e
> +			MX93_PAD_ENET1_TD1__ENET_QOS_RGMII_TD1			0x57e
> +			MX93_PAD_ENET1_TD2__ENET_QOS_RGMII_TD2			0x57e
> +			MX93_PAD_ENET1_TD3__ENET_QOS_RGMII_TD3			0x57e
> +			MX93_PAD_ENET1_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x5fe
> +			MX93_PAD_ENET1_TX_CTL__ENET_QOS_RGMII_TX_CTL		0x57e
> +		>;
> +	};
> +
> +	pinctrl_reg_eqos_phy: regeqosgrp {
> +		fsl,pins = <
> +			MX93_PAD_UART2_TXD__GPIO1_IO07			0x51e
> +		>;
> +	};
> +
> +	pinctrl_usdhc1: usdhc1grp {
> +		fsl,pins = <
> +			MX93_PAD_SD1_CLK__USDHC1_CLK		0x15fe
> +			MX93_PAD_SD1_CMD__USDHC1_CMD		0x13fe
> +			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x13fe
> +			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x13fe
> +			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x13fe
> +			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x13fe
> +			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x13fe
> +			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x13fe
> +			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x13fe
> +			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x13fe
> +			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x15fe
> +		>;
> +	};
> +};
> +
> +/* eMMC */
> +&usdhc1 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc1>;
> +	pinctrl-1 = <&pinctrl_usdhc1>;
> +	pinctrl-2 = <&pinctrl_usdhc1>;
> +	bus-width = <8>;
> +	non-removable;
> +	status = "okay";
> +};
> -- 
> 2.41.0
> 
> 
> 

