Return-Path: <linux-kernel+bounces-34756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C18838726
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7938C1F245CB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72324F606;
	Tue, 23 Jan 2024 06:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="KTRgWu+p"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63C24F8BB
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 06:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705990311; cv=none; b=ZRCzhXLenkU7sBFMqpzBPmLKhqs3ryE/87+1Ycs8oYS8qkkB47OdhE3EK0SFaxZ0FKOR+e3lSFs+IpEybDsWp3aLLHGGm5/s8R2HyXkGuvaiGnfmctbSR81MVWo+4xAdoi4Z8f5DVE58jiR8VFL/jD6gCZ6uw9LPSRb3al80T4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705990311; c=relaxed/simple;
	bh=RHLiIGU9/fZVbtAlbM5NxE9HcZdCcWcIkjlDxCuUHbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RYtzdGm9qf5/BQUUe4HlapkHcFricTcSWS/eYnxr2OPdH/9+eZTNXedtoq1z4bNSsxGu2r98CJ0Iz9lOi2f9VHYP/YSx/de8RlOA1INROOpFteyRfV6I6BjkQwMubRpS4hsGxqAGjmr2HfncOKARadcO20Xxa+6H6Ofnz9OITRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=KTRgWu+p; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1705990299; x=1708582299;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RHLiIGU9/fZVbtAlbM5NxE9HcZdCcWcIkjlDxCuUHbY=;
	b=KTRgWu+pgF1kertTj0nGDdNmdS2P1TMjqd+rMjrfJcnUu+xmIqBV3QkR1gg6Llqh
	jsgdr/sbULDW5iJ3yT9AxJGuEh1MRqGmBtPusTGoRNhBts4AVdLwloOUaiqgBka3
	xIcYHvUCpMc9vg/+x5dm3rdqhEExKka6vc3iLMVnqxI=;
X-AuditID: ac14000a-fbefe7000000290d-b5-65af589b3d81
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 79.98.10509.B985FA56; Tue, 23 Jan 2024 07:11:39 +0100 (CET)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 23 Jan
 2024 07:11:34 +0100
Message-ID: <537266fe-0bf7-4208-a9f3-ae27f462c6ed@phytec.de>
Date: Tue, 23 Jan 2024 07:11:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] arm64: dts: imx93: Add phyBOARD-Segin-i.MX93
 support
To: Mathieu Othacehe <othacehe@gnu.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Li
 Yang <leoyang.li@nxp.com>, Primoz Fiser <primoz.fiser@norik.com>, Stefan
 Wahren <wahrenst@gmx.net>, Christoph Stoidner <c.stoidner@phytec.de>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
References: <20240122095306.14084-1-othacehe@gnu.org>
 <20240122095306.14084-4-othacehe@gnu.org>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20240122095306.14084-4-othacehe@gnu.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsWyRpKBR3d2xPpUg2lfNC3W7D3HZDH/yDlW
	i4dX/S1WTd3JYtH34iGzxaHmA0wWmx5fY7Xo+rWS2eLyrjlsFufvbmG2ONH1kNWide8Rdou/
	2zexWLzYIm5x/EQnswO/x85Zd9k9Fm/az+bRNs3MY9OqTjaPO9f2sHlsXlLv8f3rBlaPje92
	MHn0/zXw+LxJLoArissmJTUnsyy1SN8ugSvjVXMvY8ED34oV636yNDC+t+1i5OCQEDCRWPay
	sIuRi0NIYDGTxImd65khnLuMEkf2zWHvYuTk4BWwkZgyfSczSAOLgKrEnO9xEGFBiZMzn7CA
	2KIC8hL3b80AKxcWCJLYcPwvG8gcEYFWFomPOzeAJZgFsiS2v5vMDGILCSRKtL5dxAwRF5e4
	9WQ+E4jNJqAucWfDN1YQm1PATGL1hOlsEDUWEovfHISaIy+x/e0cqDnyEi8uLQc7QgLInnbu
	NTOEHSpxZNNqpgmMwrOQ3DoLybpZSMbOQjJ2ASPLKkah3Mzk7NSizGy9gozKktRkvZTUTYyg
	uBVh4NrB2DfH4xAjEwfjIUYJDmYlEd4bkutShXhTEiurUovy44tKc1KLDzFKc7AoifOu7ghO
	FRJITyxJzU5NLUgtgskycXBKNTD6rJE7+/bVV5YXp8xPRj1UNLftD1jkU9rZGhZbaxPSF3nw
	bWm1TfKUfu34Zb83Oz75ezW55pXeUpv9vMa9hscb9iZMfix19wfDXf+nRyInq8+8vXdpmPAd
	3cvHu53kOz1/l+ewTVxoz5p1LHvlp4wA5XVXVDOc+10n7MqZcerV5/ldQhdeR3EosRRnJBpq
	MRcVJwIAFzURl8kCAAA=

Hey Mathieu,

Am 22.01.24 um 10:53 schrieb Mathieu Othacehe:
> Add basic support for phyBOARD-Segin-i.MX93.
> Main features are:
> * eMMC
> * Ethernet
> * SD-Card
> * UART
>
> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
> ---
>   arch/arm64/boot/dts/freescale/Makefile        |   1 +
>   .../dts/freescale/imx93-phyboard-segin.dts    | 141 ++++++++++++++++++
>   .../boot/dts/freescale/imx93-phycore-som.dtsi | 127 ++++++++++++++++
>   3 files changed, 269 insertions(+)
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
> index 000000000000..5433c33d1322
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
> @@ -0,0 +1,141 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2023 PHYTEC Messtechnik GmbH
> + * Author: Wadim Egorov <w.egorov@phytec.de>, Christoph Stoidner <c.stoidner@phytec.de>
> + * Copyright (C) 2024 Mathieu Othacehe <m.othacehe@gmail.com>
> + *
> + * Product homepage:
> + * phyBOARD-Segin carrier board is reused for the i.MX93 design.
> + * https://www.phytec.de/produkte/single-board-computer/phyboard-segin-imx6ul/
> + */
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
> +/* GPIOs */
> +&gpio1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_gpio1>;

You are doing more than you describing in your changes log.
Here you are forcing a gpio-only functionality for the X16 header. But 
the pins we route down to the X16 expansion connector can be also used 
differently.
Typically we provide device tree overlays for different use cases on 
this expansion connectors.

Please drop the muxing.

Same applies for the gpio names.

> +	gpio-line-names = "X_GPIO1_3";
> +};
> +
> +&gpio4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_gpio4>;
> +	gpio-line-names = "", "", "", "", "", "", "", "X_GPIO5_9";

Same for gpio4.


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
> +	pinctrl_gpio1: gpio1grp {
> +		fsl,pins = <
> +			MX93_PAD_I2C1_SCL__GPIO1_IO00		0x10
> +		>;
> +	};
> +
> +	pinctrl_gpio4: gpio4grp {
> +		fsl,pins = <
> +			MX93_PAD_ENET1_TXC__GPIO4_IO07		0x10
> +		>;
> +	};
> +
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
> index 000000000000..439ea4176f8c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx93-phycore-som.dtsi
> @@ -0,0 +1,127 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2023 PHYTEC Messtechnik GmbH
> + * Author: Wadim Egorov <w.egorov@phytec.de>, Christoph Stoidner <c.stoidner@phytec.de>
> + * Copyright (C) 2024 Mathieu Othacehe <m.othacehe@gmail.com>
> + *
> + * Product homepage:
> + * https://www.phytec.de/produkte/system-on-modules/phycore-imx-91-93/
> + */
> +/dts-v1/;

Maybe this comment was lost, but I asked to move the dts-v1 tag into the 
carrier board device tree.

Regards,
Wadim


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

