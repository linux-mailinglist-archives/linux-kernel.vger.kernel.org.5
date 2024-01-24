Return-Path: <linux-kernel+bounces-36722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0B783A58A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10F4B1C21D3A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC0117C6D;
	Wed, 24 Jan 2024 09:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="BJPT//Pl"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAC917C61
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 09:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706088892; cv=none; b=g3ogGBbd8FdH8qMlufbLCGnD83Wv3iocyx6LHiVlWMe86uU6ZfLQmIHVlP/7/exbR5Tbim6mDVyhN/hOG0q7nNMUGa/GuGeh++SQuH5x/cv8LNHbIXTm8F7FHxKY8dqpiYMbJ11nB1YPKL1u8zIK0hhqNPaILc8pq35Ft5ecdF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706088892; c=relaxed/simple;
	bh=P5Bm0Qp0U3WB/YMe26CcSwcyLhwMn7jP//HILTmIRQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CG7BtNe2x/qEfLRmCNuzMwhARvZNlQNQjh38jEdViHa10iTRnMmwZNcKg8ZvB7XItZNeDfRQsHn1Qy/p9OHQho/cSpnVj1y4g0tqb9eWA/njPQDicHIDhozyK4nTp6ipBaqnvsuUnzRo3oA6eRdsbA4RnCTXQOniQeIu+QmxOoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=BJPT//Pl; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1706088884; x=1708680884;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=P5Bm0Qp0U3WB/YMe26CcSwcyLhwMn7jP//HILTmIRQg=;
	b=BJPT//Pl/K8w67tdd9pCwgXMEUHqMcu+SLq7ecmIy50WJ6g2kKwLFfXBoaS2jlp/
	OQ5SmOtzYrHaFl+DtO2SFHTAkA1yQTk7EfAwS8BnBrrZSvhXRxeHqCALeS+yt9vS
	lxp2I2qlYCClS3HRQDyvs6gRZLFo4IDuiHWm8z1N6MY=;
X-AuditID: ac14000a-fadff7000000290d-68-65b0d9b47f4f
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id B2.3F.10509.4B9D0B56; Wed, 24 Jan 2024 10:34:44 +0100 (CET)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 24 Jan
 2024 10:34:39 +0100
Message-ID: <f1c47dbc-c789-4084-9903-ebdd40d14819@phytec.de>
Date: Wed, 24 Jan 2024 10:34:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] arm64: dts: imx93: Add phyBOARD-Segin-i.MX93
 support
Content-Language: en-US
To: Mathieu Othacehe <othacehe@gnu.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Li
 Yang <leoyang.li@nxp.com>, Primoz Fiser <primoz.fiser@norik.com>, Stefan
 Wahren <wahrenst@gmx.net>, Christoph Stoidner <c.stoidner@phytec.de>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
References: <20240124074930.26101-1-othacehe@gnu.org>
 <20240124074930.26101-4-othacehe@gnu.org>
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20240124074930.26101-4-othacehe@gnu.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsWyRpKBR3fLzQ2pBrfXG1ms2XuOyWL+kXOs
	Fg+v+lusmrqTxaLvxUNmi0PNB5gsNj2+xmrR9Wsls8XlXXPYLM7f3cJscaLrIatF694j7BZ/
	t29isXixRdzi+IlOZgd+j52z7rJ7LN60n82jbZqZx6ZVnWwed67tYfPYvKTe4/vXDaweG9/t
	YPLo/2vg8XmTXABXFJdNSmpOZllqkb5dAlfG/DWP2Qsmu1UsWrGVsYFxpkUXIyeHhICJRPP6
	L0xdjFwcQgKLmSR+LvjIDJIQErjLKNHYVAti8wrYSDw7dp4dxGYRUJWYuWExI0RcUOLkzCcs
	ILaogLzE/VszwGqEBYIk9q87AmYzC4hL3HoyH2yBiEAri8THnRugElkS299NhlqWKPFv0zSw
	oWwC6hJ3NnxjBbE5BcwkXm3+wwJRbyGx+M1BqF55ie1v50D1yku8uLScBeIbeYlp514zQ9ih
	Elu/bGeawCg8C8mts5DcNAvJ2FlIxi5gZFnFKJSbmZydWpSZrVeQUVmSmqyXkrqJERS5Igxc
	Oxj75ngcYmTiYDzEKMHBrCTCe0NyXaoQb0piZVVqUX58UWlOavEhRmkOFiVx3tUdwalCAumJ
	JanZqakFqUUwWSYOTqkGRsZlU4xaovy4fr+pYHNbHdJ9/fhbp2vnXDbpmoRuU9Fa2HnauELt
	/YzCmYfEJHfxnr1psa59u+iOpzEzZ7xYPd0zIjC30dph098Uzie2lTr/M5S6127IzPq3+qXd
	t9jJSfVMMj9WurX/2Py099N2py63O9qmYu/SFt+oNDpXeL24X18jqP2nqxJLcUaioRZzUXEi
	ANaT+RbKAgAA


Am 24.01.24 um 08:49 schrieb Mathieu Othacehe:
> Add basic support for phyBOARD-Segin-i.MX93.
> Main features are:
> * eMMC
> * Ethernet
> * SD-Card
> * UART
>
> Tested-by: Primoz Fiser <primoz.fiser@norik.com>
> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>

Reviewed-by: Wadim Egorov <w.egorov@phytec.de>


> ---
>   arch/arm64/boot/dts/freescale/Makefile        |   1 +
>   .../dts/freescale/imx93-phyboard-segin.dts    | 117 ++++++++++++++++
>   .../boot/dts/freescale/imx93-phycore-som.dtsi | 126 ++++++++++++++++++
>   3 files changed, 244 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
>   create mode 100644 arch/arm64/boot/dts/freescale/imx93-phycore-som.dtsi
>
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 2e027675d7bb..65db918c821c 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -201,6 +201,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8qxp-colibri-iris-v2.dtb
>   dtb-$(CONFIG_ARCH_MXC) += imx8qxp-mek.dtb
>   dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
>   dtb-$(CONFIG_ARCH_MXC) += imx93-11x11-evk.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin.dtb
>   dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxca.dtb
>   dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla.dtb
>   
> diff --git a/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts b/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
> new file mode 100644
> index 000000000000..85fb188b057f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2023 PHYTEC Messtechnik GmbH
> + * Author: Wadim Egorov <w.egorov@phytec.de>, Christoph Stoidner <c.stoidner@phytec.de>
> + * Copyright (C) 2024 Mathieu Othacehe <m.othacehe@gmail.com>
> + *
> + * Product homepage:
> + * phyBOARD-Segin carrier board is reused for the i.MX93 design.
> + * https://www.phytec.eu/en/produkte/single-board-computer/phyboard-segin-imx6ul/
> + */
> +/dts-v1/;
> +
> +#include "imx93-phycore-som.dtsi"
> +
> +/{
> +	model = "PHYTEC phyBOARD-Segin-i.MX93";
> +	compatible = "phytec,imx93-phyboard-segin", "phytec,imx93-phycore-som",
> +		     "fsl,imx93";
> +
> +	chosen {
> +		stdout-path = &lpuart1;
> +	};
> +
> +	reg_usdhc2_vmmc: regulator-usdhc2 {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-name = "VCC_SD";
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
> +/* eMMC */
> +&usdhc1 {
> +	no-1-8-v;
> +};
> +
> +/* SD-Card */
> +&usdhc2 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc2_default>, <&pinctrl_usdhc2_cd>;
> +	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_cd>;
> +	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_cd>;
> +	bus-width = <4>;
> +	cd-gpios = <&gpio3 0 GPIO_ACTIVE_LOW>;
> +	no-mmc;
> +	no-sdio;
> +	vmmc-supply = <&reg_usdhc2_vmmc>;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins = <
> +			MX93_PAD_UART1_RXD__LPUART1_RX		0x31e
> +			MX93_PAD_UART1_TXD__LPUART1_TX		0x30e
> +		>;
> +	};
> +
> +	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
> +		fsl,pins = <
> +			MX93_PAD_SD2_RESET_B__GPIO3_IO07	0x31e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_cd: usdhc2cdgrp {
> +		fsl,pins = <
> +			MX93_PAD_SD2_CD_B__GPIO3_IO00		0x31e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_default: usdhc2grp {
> +		fsl,pins = <
> +			MX93_PAD_SD2_CLK__USDHC2_CLK		0x179e
> +			MX93_PAD_SD2_CMD__USDHC2_CMD		0x139e
> +			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x138e
> +			MX93_PAD_SD2_DATA1__USDHC2_DATA1	0x138e
> +			MX93_PAD_SD2_DATA2__USDHC2_DATA2	0x138e
> +			MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x139e
> +			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_100mhz: usdhc2grp {
> +		fsl,pins = <
> +			MX93_PAD_SD2_CLK__USDHC2_CLK            0x179e
> +			MX93_PAD_SD2_CMD__USDHC2_CMD            0x139e
> +			MX93_PAD_SD2_DATA0__USDHC2_DATA0        0x138e
> +			MX93_PAD_SD2_DATA1__USDHC2_DATA1        0x138e
> +			MX93_PAD_SD2_DATA2__USDHC2_DATA2        0x139e
> +			MX93_PAD_SD2_DATA3__USDHC2_DATA3        0x139e
> +			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT    0x51e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_200mhz: usdhc2grp {
> +		fsl,pins = <
> +			MX93_PAD_SD2_CLK__USDHC2_CLK            0x178e
> +			MX93_PAD_SD2_CMD__USDHC2_CMD            0x139e
> +			MX93_PAD_SD2_DATA0__USDHC2_DATA0        0x139e
> +			MX93_PAD_SD2_DATA1__USDHC2_DATA1        0x139e
> +			MX93_PAD_SD2_DATA2__USDHC2_DATA2        0x139e
> +			MX93_PAD_SD2_DATA3__USDHC2_DATA3        0x139e
> +			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT    0x51e
> +		>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx93-phycore-som.dtsi b/arch/arm64/boot/dts/freescale/imx93-phycore-som.dtsi
> new file mode 100644
> index 000000000000..88c2657b50e6
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx93-phycore-som.dtsi
> @@ -0,0 +1,126 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2023 PHYTEC Messtechnik GmbH
> + * Author: Wadim Egorov <w.egorov@phytec.de>, Christoph Stoidner <c.stoidner@phytec.de>
> + * Copyright (C) 2024 Mathieu Othacehe <m.othacehe@gmail.com>
> + *
> + * Product homepage:
> + * https://www.phytec.eu/en/produkte/system-on-modules/phycore-imx-91-93/
> + */
> +
> +#include <dt-bindings/leds/common.h>
> +
> +#include "imx93.dtsi"
> +
> +/{
> +	model = "PHYTEC phyCORE-i.MX93";
> +	compatible = "phytec,imx93-phycore-som", "fsl,imx93";
> +
> +	reserved-memory {
> +		ranges;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +
> +		linux,cma {
> +			compatible = "shared-dma-pool";
> +			reusable;
> +			alloc-ranges = <0 0x80000000 0 0x40000000>;
> +			size = <0 0x10000000>;
> +			linux,cma-default;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_leds>;
> +
> +		led-0 {
> +			color = <LED_COLOR_ID_GREEN>;
> +			function = LED_FUNCTION_HEARTBEAT;
> +			gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +};
> +
> +/* Ethernet */
> +&fec {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_fec>;
> +	phy-mode = "rmii";
> +	phy-handle = <&ethphy1>;
> +	fsl,magic-packet;
> +	assigned-clocks = <&clk IMX93_CLK_ENET_TIMER1>,
> +			  <&clk IMX93_CLK_ENET_REF>,
> +			  <&clk IMX93_CLK_ENET_REF_PHY>;
> +	assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>,
> +				 <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>,
> +				 <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
> +	assigned-clock-rates = <100000000>, <50000000>, <50000000>;
> +	status = "okay";
> +
> +	mdio: mdio {
> +		clock-frequency = <5000000>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ethphy1: ethernet-phy@1 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			reg = <1>;
> +		};
> +	};
> +};
> +
> +/* eMMC */
> +&usdhc1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc1>;
> +	bus-width = <8>;
> +	non-removable;
> +	status = "okay";
> +};
> +
> +/* Watchdog */
> +&wdog3 {
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl_fec: fecgrp {
> +		fsl,pins = <
> +			MX93_PAD_ENET2_MDC__ENET1_MDC			0x50e
> +			MX93_PAD_ENET2_MDIO__ENET1_MDIO			0x502
> +			MX93_PAD_ENET2_RD0__ENET1_RGMII_RD0		0x57e
> +			MX93_PAD_ENET2_RD1__ENET1_RGMII_RD1		0x57e
> +			MX93_PAD_ENET2_RXC__ENET1_RX_ER			0x5fe
> +			MX93_PAD_ENET2_RX_CTL__ENET1_RGMII_RX_CTL	0x57e
> +			MX93_PAD_ENET2_TD0__ENET1_RGMII_TD0		0x50e
> +			MX93_PAD_ENET2_TD1__ENET1_RGMII_TD1		0x50e
> +			MX93_PAD_ENET2_TX_CTL__ENET1_RGMII_TX_CTL	0x50e
> +			MX93_PAD_ENET2_TD2__ENET1_TX_CLK		0x4000050e
> +		>;
> +	};
> +
> +	pinctrl_leds: ledsgrp {
> +		fsl,pins = <
> +			MX93_PAD_I2C1_SDA__GPIO1_IO01		0x31e
> +		>;
> +	};
> +
> +	pinctrl_usdhc1: usdhc1grp {
> +		fsl,pins = <
> +			MX93_PAD_SD1_CLK__USDHC1_CLK		0x179e
> +			MX93_PAD_SD1_CMD__USDHC1_CMD		0x1386
> +			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x138e
> +			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x1386
> +			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x138e
> +			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x1386
> +			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x1386
> +			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x1386
> +			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x1386
> +			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x1386
> +			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x179e
> +		>;
> +	};
> +};

