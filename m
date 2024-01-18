Return-Path: <linux-kernel+bounces-29989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 182D4831654
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AA931C24E39
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712EE20333;
	Thu, 18 Jan 2024 09:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="ISYZW+ZE"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B11220B0B;
	Thu, 18 Jan 2024 09:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705571925; cv=none; b=GXwLr9gOhOG9ZlkEVr3yP41kQuEAbbSouxWyaIKqXJHo4z7Jy8UKBxt2p4bXRgWOCyow92467bxeC7VN02SwVU87/+LegEEHQhT+FD7rNpfLGLHYUJWfA7ouQgYW0+k2VtHpoobxnaLauSBNayeJYTEiVDPyaGv1cWbJfw2Pgos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705571925; c=relaxed/simple;
	bh=4lelM5Mu8dIeQYfmmTEIKQSVvC5biNoMtuRcvphtl/U=;
	h=DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-Get-Message-Sender-Via:X-Authenticated-Sender:X-Source:
	 X-Source-Args:X-Source-Dir; b=PE0KV42pAWhdyI+iiyDwlnIhJPJZcoKo2p3UIZQ3+I4oAyozfHtfA15Ifa7mCEK1Y+ge+dAamEYTeTV51VsO4RhL52c0IC4pFsdKoa/krGz4vEGvUSuOGA7K2Bhbn0oha9LzlUWiWQhGbh6VzLrjnaDBml3B6Qnlsr8qIOdKWi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=none smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=ISYZW+ZE; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xsaHQFs/dJguDvAuW/jcuqfX0soPSo8tx8PPeafV9Bc=; b=ISYZW+ZENUQ1jryV33gZCrcbRx
	9QNFVRF21YdXLvMAxf+uduBooLirnJq7bZPOTjUqvG29BL5f3yJy4Z1F0XwYsm22gOOMourGVeFeA
	cvOrbXNAUqb51aoj2msmbG0/swBq/+Tvdiy8YxJ9HEQT1/z0ijOlm1JmuGXtORHLnY3e+KK8YsC5K
	ZkpTYpMkkQxIpMNPeVRWzWItbQ6Nhvtf3U4tkQMta+50ALIEtcBqkLe6ZZ87xjSlh1HuK7NKALAvn
	fB2gcCprPj65851y4iU+OG/YYy+UE5xfu3RZ8bqz7cS5dO9CtT/Vsv4pxAxdyUM49jFvLKPSJCo5H
	1GambFdg==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:50934 helo=[192.168.69.116])
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <primoz.fiser@norik.com>)
	id 1rQPAT-006uBR-39;
	Thu, 18 Jan 2024 10:58:37 +0100
Message-ID: <c1ef5c08-1ae9-4a22-8ca9-47673c023e1e@norik.com>
Date: Thu, 18 Jan 2024 10:58:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: imx93-phycore-segin: Add Phytec i.MX93
 Segin
Content-Language: en-US
To: Mathieu Othacehe <othacehe@gnu.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Li Yang <leoyang.li@nxp.com>, Stefan Wahren <wahrenst@gmx.net>,
 Christoph Stoidner <c.stoidner@phytec.de>, Wadim Egorov <w.egorov@phytec.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, upstream@lists.phytec.de
References: <20240117074911.7425-1-othacehe@gnu.org>
 <20240117074911.7425-3-othacehe@gnu.org>
From: Primoz Fiser <primoz.fiser@norik.com>
Organization: Norik systems d.o.o.
In-Reply-To: <20240117074911.7425-3-othacehe@gnu.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cpanel.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi Mathieu,

first of all, nice to see an attempt to upstream the board. A bit fast
though as upstreaming was planned after the official PHYTEC release.

However, there is quite a lot of differences in respect to the
downstream PHYTEC kernel tree.

I am sure PHYTEC wants to sync here to avoid general confusion.

CC-ing: upstream@list.phytec.de

So lets start:

- the board should be named "imx93-phyboard-segin" instead of
"imx93-phycore-segin".

PHYTEC naming convention:
phyCORE -> the SoM
phyBOARD -> the base board (with the SoM)


On 17. 01. 24 08:49, Mathieu Othacehe wrote:
> Add DTSI for Phytec i.MX93 System on Module and DTS for Phytec
> i.MX93 on Segin evaluation board.
> 
> This version comes with:
>  - 1GB LPDDR4 RAM
>  - external SD
>  - debug UART
>  - 1x 100Mbit Ethernet

Maybe you sync this commit msg + title with downstream commit like so:

>     arm64: dts: imx93: Add phyBOARD-Segin-i.MX93 support
>     
>     Add basic support for phyBOARD-Segin-i.MX93.
>     Main features are:
>     * Ethernet
>     * SD-Card
>     * UART
>     

plus add eMMC to the list if you decided to enable it?


> 
> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |  1 +
>  .../dts/freescale/imx93-phycore-segin.dts     | 93 +++++++++++++++++++
>  .../boot/dts/freescale/imx93-phycore-som.dtsi | 64 +++++++++++++
>  3 files changed, 158 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx93-phycore-segin.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx93-phycore-som.dtsi
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 2e027675d7bb..f078d6ef75f7 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -201,6 +201,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8qxp-colibri-iris-v2.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8qxp-mek.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx93-11x11-evk.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx93-phycore-segin.dtb

Like I said, this has to be renamed to imx93-phyboard-segin.dts as the
official kit name is "phyBOARD-Segin-i.MX93".

>  dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxca.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla.dtb
>  
> diff --git a/arch/arm64/boot/dts/freescale/imx93-phycore-segin.dts b/arch/arm64/boot/dts/freescale/imx93-phycore-segin.dts
> new file mode 100644
> index 000000000000..748b779a9dc1
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx93-phycore-segin.dts> @@ -0,0 +1,93 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2023 PHYTEC Messtechnik GmbH
> + * Christoph Stoidner <c.stoidner@phytec.de>
> + * Copyright (C) 2024 Mathieu Othacehe <m.othacehe@gmail.com>
> + *
> + */
> +/dts-v1/;
> +
> +#include "imx93-phycore-som.dtsi"
> +
> +/{
> +	model = "PHYTEC phyBOARD-Segin-i.MX93";
> +	compatible = "phytec,imx93-phycore-segin", "phytec,imx93-phycore-som",
> +		     "fsl,imx93";
> +
> +	chosen {
> +		stdout-path = &lpuart1;
> +	};
> +
> +	reg_usdhc2_vmmc: regulator-usdhc2 {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
> +		regulator-name = "VSD_3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;

Order properties here alphabetically like in the downstream kernel.

Comment applies for the entire patch.

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
> +/* SD-Card */
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

Please consider adding pinctrl_100mhz and pinctrl_200mhz from the
downstream kernel which were determined by HW measurements at those
operating frequencies.


> +/* Watchdog */
> +&wdog3 {
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl-names = "default";
> +	status = "okay";

Remove this pinctrl + status left-over?

> +
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins = <
> +			MX93_PAD_UART1_RXD__LPUART1_RX			0x31e
> +			MX93_PAD_UART1_TXD__LPUART1_TX			0x31e

Please consider pinctrl settings from the down-stream kernel. They differ.

> +		>;
> +	};
> +
> +	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
> +		fsl,pins = <
> +			MX93_PAD_SD2_RESET_B__GPIO3_IO07		0x31e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
> +		fsl,pins = <
> +			MX93_PAD_SD2_CD_B__GPIO3_IO00			0x31e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2: usdhc2grp {
> +		fsl,pins = <
> +			MX93_PAD_SD2_CLK__USDHC2_CLK			0x178e
> +			MX93_PAD_SD2_CMD__USDHC2_CMD			0x139e
> +			MX93_PAD_SD2_DATA0__USDHC2_DATA0		0x138e
> +			MX93_PAD_SD2_DATA1__USDHC2_DATA1		0x138e
> +			MX93_PAD_SD2_DATA2__USDHC2_DATA2		0x138e
> +			MX93_PAD_SD2_DATA3__USDHC2_DATA3		0x139e
> +			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT		0x51e
> +		>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx93-phycore-som.dtsi b/arch/arm64/boot/dts/freescale/imx93-phycore-som.dtsi
> new file mode 100644
> index 000000000000..4edff4a50b2b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx93-phycore-som.dtsi
> @@ -0,0 +1,64 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2023 PHYTEC Messtechnik GmbH
> + * Christoph Stoidner <c.stoidner@phytec.de>
> + * Copyright (C) 2024 Mathieu Othacehe <m.othacehe@gmail.com>
> + *
> + */
> +/dts-v1/;
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
> +
> +		ele_reserved: ele-reserved@a4120000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0 0xa4120000 0 0x100000>;
> +			no-map;
> +		};

Remove ele_reserved if you are not using it anywhere. This only applies
to vendor kernel at the moment.

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

Currently only default DDR50 is supported.

So no need for 100mhz + 200mhz pinctrls.

> +};
> +
> +&iomuxc {
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

BR,
Primoz

