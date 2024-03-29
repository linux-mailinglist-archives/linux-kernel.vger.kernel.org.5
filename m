Return-Path: <linux-kernel+bounces-124671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B06891B39
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 368411C263CB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D69116FF2E;
	Fri, 29 Mar 2024 12:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="GMnsHEV8"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033BC16F8E0;
	Fri, 29 Mar 2024 12:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715667; cv=none; b=OwB7uyn2mbG5+NNJ26qKd3kJnC1m9wF42YebV1lvihp3sbrN5Hn3UR1PDdH/mILj+soGFHnBrkYKSJ3DKazpOYm6o3DlsSXz6w651Kqz5vDTDRx1c6E4PDQjAnRU+HA8Fp6hrJ4Sgx84nWNIM8PvAXA6P+FuigWBYMmDF+JJUOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715667; c=relaxed/simple;
	bh=6O6Y3EAVNfVUZZVE7YNho1XRSttKnwFyPtlgwub02tU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWSjjdH9f1ofm0qWJIV28OR4m7P2GwRUzM17yp8Odc8c/pqomPufkKGT0HZRIe53l6ynUsYhjbNsam6xIE7nYzbDV91zznq6mJFD6k/xVPQZJjshiHQCG+xKyXvNtFyYvxomIq7p2XKO0Dr0H2vHapzIE4YMXFJqCWQ6tGbT/0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=GMnsHEV8; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=wI/Amv+RPJQvoX1/bZKyPoE67fMI/bfxn2JETr9yooI=;
	b=GMnsHEV85i18nXqtnctK+aBOGvJSHHdh/Q6wqIWzMUjwo+PhL4Rzq3GeEWCVNk
	ULA1eifGYHc2ZvbvDDMUp36z67QOGv7OHDfb5fGBfjh2i3ZbIt4pPdbgP9LYzgGc
	h3eUp5/GqAzaCx7qYvkehX/e6tt1IqAR8RRFoUDyuQpkU=
Received: from dragon (unknown [183.213.196.225])
	by smtp1 (Coremail) with SMTP id ClUQrADHz0MRtQZmCxhkAQ--.16042S3;
	Fri, 29 Mar 2024 20:33:22 +0800 (CST)
Date: Fri, 29 Mar 2024 20:33:21 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] dts: arm64: imx8dxl-evk: add lpuart1 and cm40 uart
Message-ID: <Zga1Eb+46Uua/jJi@dragon>
References: <20240305-m4_lpuart-v3-0-592463ef1d22@nxp.com>
 <20240305-m4_lpuart-v3-4-592463ef1d22@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305-m4_lpuart-v3-4-592463ef1d22@nxp.com>
X-CM-TRANSID:ClUQrADHz0MRtQZmCxhkAQ--.16042S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF1rCrW8tr4xZrykXFyDAwb_yoW8Kry5p3
	Z3ZFZ5Wr1fJF17AasxGr1xKF45Wan5KayDurnrWrWrCrW5uasFqrsxKr1rGr1vqr13Xw4Y
	yF1DCr1293ZFg3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j7txhUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDxOwZVnxclwFagAAsg

On Tue, Mar 05, 2024 at 10:54:58AM -0500, Frank Li wrote:
> Add lpuart1 and cm40 uart.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 37 +++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
> index 2123d431e0613..737bacacc2da1 100644
> --- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
> @@ -16,6 +16,8 @@ aliases {
>  		mmc0 = &usdhc1;
>  		mmc1 = &usdhc2;
>  		serial0 = &lpuart0;
> +		serial1 = &lpuart1;
> +		serial6 = &cm40_lpuart;
>  	};
>  
>  	chosen {
> @@ -51,6 +53,16 @@ linux,cma {
>  		};
>  	};
>  
> +	m2_uart1_sel: fixedregulator-101 {

Why do we not name the node regulator-xxx just like other fixed
regulators?  Also not sure what suffix -101 means.  Can we name it like
regulator-m2uart1sel or something?

Shawn

> +		compatible = "regulator-fixed";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-name = "m2_uart1_sel";
> +		gpio = <&pca6416_1 6 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		regulator-always-on;
> +	};
> +
>  	mux3_en: regulator-0 {
>  		compatible = "regulator-fixed";
>  		regulator-min-microvolt = <3300000>;
> @@ -340,6 +352,12 @@ &lpuart0 {
>  	status = "okay";
>  };
>  
> +&lpuart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_lpuart1>;
> +	status = "okay";
> +};
> +
>  &flexcan2 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_flexcan2>;
> @@ -354,6 +372,16 @@ &flexcan3 {
>  	status = "okay";
>  };
>  
> +&cm40_intmux {
> +	status = "disabled";
> +};
> +
> +&cm40_lpuart {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_cm40_lpuart>;
> +	status = "disabled";
> +};
> +
>  &lsio_gpio4 {
>  	status = "okay";
>  };
> @@ -595,6 +623,15 @@ IMX8DXL_UART0_TX_ADMA_UART0_TX		0x06000020
>  		>;
>  	};
>  
> +	pinctrl_lpuart1: lpuart1grp {
> +		fsl,pins = <
> +			IMX8DXL_UART1_TX_ADMA_UART1_TX          0x06000020
> +			IMX8DXL_UART1_RX_ADMA_UART1_RX          0x06000020
> +			IMX8DXL_UART1_RTS_B_ADMA_UART1_RTS_B    0x06000020
> +			IMX8DXL_UART1_CTS_B_ADMA_UART1_CTS_B    0x06000020
> +		>;
> +	};
> +
>  	pinctrl_usdhc1: usdhc1grp {
>  		fsl,pins = <
>  			IMX8DXL_EMMC0_CLK_CONN_EMMC0_CLK	0x06000041
> 
> -- 
> 2.34.1
> 


