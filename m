Return-Path: <linux-kernel+bounces-31007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76827832779
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E22141F2344D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6D63C47A;
	Fri, 19 Jan 2024 10:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="S5mpO+Pn"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC52633CE9;
	Fri, 19 Jan 2024 10:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705659134; cv=none; b=X0QyMt2g115W1egxqa54b5ArUPniKW6cXW+ESQG37x4flJJ9F3D/CMzxJ72vf8KVsC8k0Apv1yqxwqMHH+fk8uuigRvlXQ7WxoJq4Z01j0oJ43tLMB8VwFMM620FpqcBS/hmTlnlbym5uxE3rpi7IZTlNff62OqjGR8ZezEJkXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705659134; c=relaxed/simple;
	bh=pPgdHvSriwxHc/qVKbO7UzGkeDKyDZRe4cbhpzTYujQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b/xwuTg2Vv5mt/TbB+rol2P/1vwNL8ega3EGvivBvf8W2Qti8F0SUmYSGatwCrVZVQLio+GGZpusFYj4bYtGCjZQHkWJFrE5KVTFxO54P41I3/Bhym0oheVx4FKOpnWM28vX6gvoemgPZt2OaU49aeQZXBQUixUd4IJ39AdN4xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=S5mpO+Pn; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1705659100; x=1706263900; i=wahrenst@gmx.net;
	bh=pPgdHvSriwxHc/qVKbO7UzGkeDKyDZRe4cbhpzTYujQ=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=S5mpO+PnwG2hFcGzc90ZiRlYzYU4zCusfEU5m7C2Z17IHlU6QQUZvfWeIOUoq1ge
	 YqCU2dmsrDBJUIdbYSY597dqcOFEvL0Lg6e0r0hIbd54jnwpnvul13F2KeJRz02Cq
	 wmR/K1f/mWuDGOw85T26gDv9KwlayImmPXl2KrxGzzepatLER9Tz7E+Qa+J98I9Vm
	 bbNiwCqrqWu32o2Q0P9/6un1Rrg6hC25q8K19f5h6Z9pk1cjb71i53zl3B31odssq
	 OU//86i40/APPMVRmJhHptQZ+UqQjRfaZXutyx3zZZYIQJjDN45RwqD1HNrQS6bfL
	 egqJAANzndpeZRx2hA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6UZv-1rTFsj0SZl-006sRa; Fri, 19
 Jan 2024 11:11:40 +0100
Message-ID: <282689a1-a189-4320-9d70-c6d38dc56d9d@gmx.net>
Date: Fri, 19 Jan 2024 11:11:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] arm64: dts: imx93: Add phyBOARD-Segin-i.MX93
 support
Content-Language: en-US
To: Mathieu Othacehe <othacehe@gnu.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Li Yang <leoyang.li@nxp.com>, Primoz Fiser <primoz.fiser@norik.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, Wadim Egorov <w.egorov@phytec.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240119092835.21462-1-othacehe@gnu.org>
 <20240119092835.21462-3-othacehe@gnu.org>
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240119092835.21462-3-othacehe@gnu.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XOZBdDM+fVsaVwg8mdmPffxeAkal+bFknzlkGv95cPyWXEqgHPJ
 V2Vdkd+cYo7if3xGXmrqaDgyefzSWUB7/5SyZFGsaJSXxQMeHVKXmEqObHXfZx+BD8g6Lsz
 3rfrep1o+Nn/mQ/hOi7aO3sK/Ef3npvIll98YPWnub1Z4sPuUjUwFT11L8cDmVTdlDHwkGP
 6mbuJ2P5utz53OLrKy7uw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Dl2WFl0MeEI=;p9I/P7lWP6yIw/ADFPDR+TyYgHO
 /jvBROKifOTUzs0/8+bFoD29xshg3ypyJVtRHMe6D6nmPClI0GjFBd4KDwL055IhN3oCfE2Jh
 yNvIUdW6dI2LelRE6BpsJwLe+JtjpLPYYSik2i1rREB6j2/9Fq/dKVxrKJZB00ANshiuBDylu
 qqm5jciz6F5OTFs5Vavmgmy09q0MvF/4C9qmGg5UwW2Frg9llUTUP9LWda1f4bRc7v432si8S
 ClmGwgV/2MqFAYnwl8zmpBWrYUWaFSSoCyVJBH5PFsVtc6UvyCojbTJQobHvsM+cQZh0gjnfX
 v3FkUIXQXWRvc4fZkWYUH0uvAl8SllJ7DcYRrfudicdi+jkFVjaxZpsCLP07bj1J1NooQMIyS
 PtT9oa31Cin4+szWd49ompWq4ajayA5eLz0llsTMUll370Yez1kbp2pTxjmIkBnaRyNnVakh3
 /pzvY2rI6foBFJ6gy/xq05BBRCK5ao6KVIgINknZ6tXGohbw6LCBtfacuhzUxqqID6dawjFOR
 /+1YfyWXHRDVfh6OF363sKlZPInRIRkY/FocN7JBd7sw3VU4UDvXhAUpJcquEgkmkWqqvgRRw
 /Tkimu4kWdPNmaKFQmwTPUSf4PLUnFMzMsffCRrYWrzWpc4m/rCkKEAzEkbC48wHqtGBvV4Yt
 KZGxMGG3476qJA/l8VFvEMx1lFnJTFjrUdLIWluR+ZTFERQWkNWxAZMk81KQA60q/sUPT5QbS
 HpptbctXgtutRiJQXAeUTHR8JH9vYNvAk3AHQko+b0+9svBRqqLmBwrxiO4+ul8Kc8l0ce+ra
 gV1RaYn7JY53mu847J1pDQ5fevxBfVNdEiHZG/RegEya/8q/Rwm7Se/Bdwcub0wPJsbAXlUgw
 AXnCJwl/o7hGSVrkVfd20/pAtyrA1s1klHby0Dxyy2/RA9F80bqw273znVZPiXXkgUMfahl7u
 FKtHow==

Hi Mathieu,

[dropped upstream@list.phytec.de because of unavailability]

Am 19.01.24 um 10:28 schrieb Mathieu Othacehe:
> Add basic support for phyBOARD-Segin-i.MX93.
> Main features are:
> * SD-Card
> * UART
> * I2C
> * eMMC
>
> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
> ---
>   arch/arm64/boot/dts/freescale/Makefile        |   1 +
>   .../dts/freescale/imx93-phyboard-segin.dts    | 119 ++++++++++++++++++
>   .../boot/dts/freescale/imx93-phycore-som.dtsi |  56 +++++++++
>   3 files changed, 176 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/freescale/imx93-phyboard-segin.=
dts
>   create mode 100644 arch/arm64/boot/dts/freescale/imx93-phycore-som.dts=
i
>
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dt=
s/freescale/Makefile
> index 2e027675d7bb..65db918c821c 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -201,6 +201,7 @@ dtb-$(CONFIG_ARCH_MXC) +=3D imx8qxp-colibri-iris-v2.=
dtb
>   dtb-$(CONFIG_ARCH_MXC) +=3D imx8qxp-mek.dtb
>   dtb-$(CONFIG_ARCH_MXC) +=3D imx8ulp-evk.dtb
>   dtb-$(CONFIG_ARCH_MXC) +=3D imx93-11x11-evk.dtb
> +dtb-$(CONFIG_ARCH_MXC) +=3D imx93-phyboard-segin.dtb
>   dtb-$(CONFIG_ARCH_MXC) +=3D imx93-tqma9352-mba93xxca.dtb
>   dtb-$(CONFIG_ARCH_MXC) +=3D imx93-tqma9352-mba93xxla.dtb
>
> diff --git a/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts b/ar=
ch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
> new file mode 100644
> index 000000000000..b256c5e42550
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
> @@ -0,0 +1,119 @@
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
> +	model =3D "PHYTEC phyBOARD-Segin-i.MX93";
> +	compatible =3D "phytec,imx93-phyboard-segin", "phytec,imx93-phycore-so=
m",
> +		     "fsl,imx93";
> +
> +	chosen {
> +		stdout-path =3D &lpuart1;
> +	};
> +
> +	reg_usdhc2_vmmc: regulator-usdhc2 {
> +		compatible =3D "regulator-fixed";
> +		enable-active-high;
> +		gpio =3D <&gpio3 7 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&pinctrl_reg_usdhc2_vmmc>;
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		regulator-name =3D "VSD_3V3";
> +	};
> +};
> +
> +/* Console */
> +&lpuart1 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_uart1>;
> +	status =3D "okay";
> +};
> +
> +/* eMMC */
> +&usdhc1 {
> +	no-1-8-v;
> +};
> +
> +/* SD-Card */
> +&usdhc2 {
> +	pinctrl-names =3D "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 =3D <&pinctrl_usdhc2_default>, <&pinctrl_usdhc2_cd>;
> +	pinctrl-1 =3D <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_cd>;
> +	pinctrl-2 =3D <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_cd>;
> +	bus-width =3D <4>;
> +	cd-gpios =3D <&gpio3 00 GPIO_ACTIVE_LOW>;
just a nit:

s/00/0/
> +	no-mmc;
> +	no-sdio;
> +	vmmc-supply =3D <&reg_usdhc2_vmmc>;
> +	status =3D "okay";
> +};
> +
>

According to the documentation there are GPIOs accessible. Those on the
expansion header X16 could be named via gpio-line-name this makes it
easier to access via libgpiod. Also there seems to be LEDs and switches
on the phyBOARD.

Best regards

