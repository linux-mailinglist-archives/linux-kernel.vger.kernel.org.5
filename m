Return-Path: <linux-kernel+bounces-32286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 312C6835973
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 03:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CBBE1F2148F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 02:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4BF15BA;
	Mon, 22 Jan 2024 02:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="i8htcTyQ"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83295EDD
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 02:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705891367; cv=none; b=daYQ0Z8KtqP9pXYm3DaTVreKVArUeyZ3lHq4mjc1Ncx334lY+paD/VYwg0kjWd9sAnDpJDBcdX6kumr5xdOfoJyndoz6Hw3hgyjOm9lnSBJ7F/JQy6UJOAJKfpHVNz8bo+dVLRmcetk2LtlaRztLE57rd91XhMnoC+oZtWNrEUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705891367; c=relaxed/simple;
	bh=CvYfQOkKWx+C9AjwRqK3EZBwCIHL93+bMqOxaoyet6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Uyi8J1L8uNZmMbLIVRfPxySIBkZteMMGxNd9NB13GdHDfczrB/VXBiOvXI3zHVFjFiDhFP3P/YIXYGsUX5HtqvGYqV+B4izMB5yhr728ZaeBFA05lj/NinVHDc5Nxuv/Twa7xeoiKcUkFlaSkzO488GDqOv7wbXilk67ZyjIFns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=i8htcTyQ; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1705891351; x=1708483351;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CvYfQOkKWx+C9AjwRqK3EZBwCIHL93+bMqOxaoyet6w=;
	b=i8htcTyQpLjC1qaF0Rdowv9s9mHYh1rl6HMyG0jYiLKA0ef4D/9V41nzqgZS/XD1
	zneI0Nb2ZE9cW4BqboMLkTxmF701kOFvsYnbiGd41gsieot++tGA2QYQ1qiQg/Mx
	niRfL/ugFcw4evHjCsvhYJH0wWRHOOuq7xjAT3Ni9CA=;
X-AuditID: ac14000a-fbefe7000000290d-06-65add617c3d7
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 19.EF.10509.716DDA56; Mon, 22 Jan 2024 03:42:31 +0100 (CET)
Received: from [10.10.3.173] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 22 Jan
 2024 03:42:25 +0100
Message-ID: <0348afb6-24df-4088-a3f5-6b5df8081c04@phytec.de>
Date: Mon, 22 Jan 2024 03:42:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] arm64: dts: imx93: Add phyBOARD-Segin-i.MX93
 support
To: Mathieu Othacehe <othacehe@gnu.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Li
 Yang <leoyang.li@nxp.com>, Primoz Fiser <primoz.fiser@norik.com>, Stefan
 Wahren <wahrenst@gmx.net>, Christoph Stoidner <c.stoidner@phytec.de>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <upstream@list.phytec.de>
References: <20240119092835.21462-1-othacehe@gnu.org>
 <20240119092835.21462-3-othacehe@gnu.org>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20240119092835.21462-3-othacehe@gnu.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsWyRpKBR1f82tpUg31tyhZr9p5jsph/5Byr
	xcOr/harpu5kseh78ZDZ4lDzASaLTY+vsVp0/VrJbHF51xw2i/N3tzBbnOh6yGrRuvcIu8Xf
	7ZtYLF5sEbdYtecQq8XxE53MDgIeO2fdZfdYvGk/m0fbNDOPTas62TzuXNvD5nFg52smj81L
	6j2+f93A6rHx3Q4mj/6/Bh6fN8kFcEdx2aSk5mSWpRbp2yVwZTQsKCpotazoe3qLpYFxu24X
	IyeHhICJxO+rz5i6GLk4hAQWM0m86bjIBuHcYZRY8HMaO0gVr4CNxPSOs4wgNouAqsThhfPY
	IOKCEidnPmEBsUUF5CXu35oBVi8sECRxcPkrsEEiAq0sEh93bmAHcZgFWhklNrbNBusWEkiU
	ePvqPyuIzSwgLnHryXwmEJtNQF3izoZvYHFOATOJs9e/MULUWEgsfnOQHcKWl9j+dg4zxBx5
	iReXlrNA/CMvMe3ca2YIO1TiyKbVTBMYhWchOXYWknWzkIydhWTsAkaWVYxCuZnJ2alFmdl6
	BRmVJanJeimpmxhB8SzCwLWDsW+OxyFGJg7GQ4wSHMxKIrz8qqtShXhTEiurUovy44tKc1KL
	DzFKc7AoifOu7ghOFRJITyxJzU5NLUgtgskycXBKNTAmT+phsriiFiJ7SHn77YB0s8xvK/9l
	a723bmARE+rg6gi5UHZC9G1oc8ybtepu6pE6LfJPWbnuibAKLWfM69cp7OkQaiv7+6ORw15U
	YsOczXbfpG+Zhm45r2tv/pnHfVcKx4Pt/0IjlI8ZM3//ZXt74j3NhgOuQgee/O+fKnk3X7jO
	/sLxJCWW4oxEQy3mouJEANrx5QbVAgAA

Hi,

Am 19.01.24 um 10:28 schrieb Mathieu Othacehe:
> Add basic support for phyBOARD-Segin-i.MX93.
> Main features are:
> * SD-Card
> * UART
> * I2C

It seems you did not configured any I2C bus/device. So maybe drop it 
from the currently supported feature list?


> * eMMC
>
> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
> ---
>   arch/arm64/boot/dts/freescale/Makefile        |   1 +
>   .../dts/freescale/imx93-phyboard-segin.dts    | 119 ++++++++++++++++++
>   .../boot/dts/freescale/imx93-phycore-som.dtsi |  56 +++++++++
>   3 files changed, 176 insertions(+)
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
> index 000000000000..b256c5e42550
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
> @@ -0,0 +1,119 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2023 PHYTEC Messtechnik GmbH
> + * Christoph Stoidner <c.stoidner@phytec.de>

you dropped me from the Authors list :(


> + * Copyright (C) 2024 Mathieu Othacehe <m.othacehe@gmail.com>
> + *

It would be nice if you could link the product page,
https://www.phytec.de/produkte/system-on-modules/phycore-imx-91-93/


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
> +		regulator-name = "VSD_3V3";

Regulator name is VCC_SD


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
> +	cd-gpios = <&gpio3 00 GPIO_ACTIVE_LOW>;
> +	no-mmc;
> +	no-sdio;
> +	vmmc-supply = <&reg_usdhc2_vmmc>;
> +	status = "okay";
> +};
> +
> +/* Watchdog */
> +&wdog3 {
> +	status = "okay";
> +};

Move the watchdog part to the SoM device tree as it not related to the 
carrier board design.


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
> index 000000000000..0cc156b3c24e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx93-phycore-som.dtsi
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2023 PHYTEC Messtechnik GmbH
> + * Christoph Stoidner <c.stoidner@phytec.de>

Same here, you dropped me from the Authors list :(


> + * Copyright (C) 2024 Mathieu Othacehe <m.othacehe@gmail.com>
> + *
> + */
> +/dts-v1/;

I don't think you need the dts-v1 here as this file gets included by 
carrier boards that already defining it.

Regards,
Wadim

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
> +&iomuxc {
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

