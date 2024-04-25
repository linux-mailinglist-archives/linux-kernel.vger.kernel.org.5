Return-Path: <linux-kernel+bounces-158179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 091908B1C9C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4F771F24A93
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4358120A;
	Thu, 25 Apr 2024 08:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="Ulb28jPk"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA47A6EB4D;
	Thu, 25 Apr 2024 08:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714032600; cv=none; b=Vx7eWUrbtPSTtB/Kn0Lgsmx9eb4Y3WEs0f3dTllww3vZH6tobouGRAdxfUwcDxnM9zpgDKfDLNhLZD5AjLIrm9I1r3qS9DYjnyvPNjsftrC1HKjH64zS0BUp/cPg8GxcZki0GNrc4mRwg2syENyxNqI3piMOuP0/Xn/l43G/zkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714032600; c=relaxed/simple;
	bh=3pH9BI+mmlAYKS5yzMrgsCLtEZ/uEG/QYW/gdUS91Bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fU943mhL5Uof78WgYoHCsJ8tMO7YwRaQSgjbalYpuEcr1inWqW3O7TXOxp+jmoYVViR1oq8gngcuIsac7DhzFBlPinx+g1IWXLQzdGnpJ9SCTktZrrr8MRiRzq5YGfQRMVQtePZUZN65f8DdptqIj2dxUenV5dRGP1bPY1ajKm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=Ulb28jPk; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=hhIHs+++PP0WLQlgo22/+Sat6DJyqVSqCbFqSFZstCo=;
	b=Ulb28jPkDiZlNFVgGvgt8/JLdOQ7HLSIlJZpgD3bLO3AtPPju5WtO+8scuG/1f
	beBMrkNELiqbSTGMdebscziZHPwBiT/OjZIKxqW13u3sSaVq+fc8ipJTHH+QRuLd
	byXwcu2NrghChiECnpUscS7oGcFQBX3GhrsTBk+YepkgQ=
Received: from dragon (unknown [223.68.79.243])
	by smtp1 (Coremail) with SMTP id ClUQrAC3f_muDypmRaZtAw--.40896S3;
	Thu, 25 Apr 2024 16:09:20 +0800 (CST)
Date: Thu, 25 Apr 2024 16:09:18 +0800
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
Subject: Re: [PATCH v3 10/10] arm64: dts: imx8qm-mek: add fec2 support
Message-ID: <ZioPrhKPWBrTdLUS@dragon>
References: <20240422-dts_8qm_audio-v3-0-680cee731ced@nxp.com>
 <20240422-dts_8qm_audio-v3-10-680cee731ced@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422-dts_8qm_audio-v3-10-680cee731ced@nxp.com>
X-CM-TRANSID:ClUQrAC3f_muDypmRaZtAw--.40896S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxCFW7Aw1rtw1DCFWrGFWruFg_yoW5Xr1Dpr
	W5JrWFgrs7AF1rGw13ur17JFy5Jr409aykW3srJry8uFsxuFnrGa4Fvr4qkrykGrW5Xw4a
	qFWjgF1293WSg3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jzc_fUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiFRDLZV6NnF4SGwAAsz

On Mon, Apr 22, 2024 at 03:50:12PM -0400, Frank Li wrote:
> Add fec2 support.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 40 ++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
> index cef395e919395..570a9bf583132 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
> @@ -40,6 +40,15 @@ reg_usdhc2_vmmc: usdhc2-vmmc {
>  		enable-active-high;
>  	};
>  
> +	reg_fec2_supply: fec2_nvcc {

regulator-fec2-nvcc for node name?

Shawn

> +		compatible = "regulator-fixed";
> +		regulator-name = "fec2_nvcc";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		gpio = <&max7322 0 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
>  	reg_can01_en: regulator-can01-gen {
>  		compatible = "regulator-fixed";
>  		regulator-name = "can01-en";
> @@ -381,6 +390,19 @@ ethphy1: ethernet-phy@1 {
>  	};
>  };
>  
> +&fec2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_fec2>;
> +	phy-mode = "rgmii-txid";
> +	phy-handle = <&ethphy1>;
> +	phy-supply = <&reg_fec2_supply>;
> +	nvmem-cells = <&fec_mac1>;
> +	nvmem-cell-names = "mac-address";
> +	rx-internal-delay-ps = <2000>;
> +	fsl,magic-packet;
> +	status = "okay";
> +};
> +
>  &usdhc1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_usdhc1>;
> @@ -500,6 +522,24 @@ IMX8QM_QSPI0B_SS1_B_LSIO_QSPI0B_SS1_B     0x06000021
>  		>;
>  	};
>  
> +	pinctrl_fec2: fec2grp {
> +		fsl,pins = <
> +			IMX8QM_COMP_CTL_GPIO_1V8_3V3_ENET_ENETA_PAD		0x000014a0
> +			IMX8QM_ENET1_RGMII_TX_CTL_CONN_ENET1_RGMII_TX_CTL	0x00000060
> +			IMX8QM_ENET1_RGMII_TXC_CONN_ENET1_RGMII_TXC		0x00000060
> +			IMX8QM_ENET1_RGMII_TXD0_CONN_ENET1_RGMII_TXD0		0x00000060
> +			IMX8QM_ENET1_RGMII_TXD1_CONN_ENET1_RGMII_TXD1		0x00000060
> +			IMX8QM_ENET1_RGMII_TXD2_CONN_ENET1_RGMII_TXD2		0x00000060
> +			IMX8QM_ENET1_RGMII_TXD3_CONN_ENET1_RGMII_TXD3		0x00000060
> +			IMX8QM_ENET1_RGMII_RXC_CONN_ENET1_RGMII_RXC		0x00000060
> +			IMX8QM_ENET1_RGMII_RX_CTL_CONN_ENET1_RGMII_RX_CTL	0x00000060
> +			IMX8QM_ENET1_RGMII_RXD0_CONN_ENET1_RGMII_RXD0		0x00000060
> +			IMX8QM_ENET1_RGMII_RXD1_CONN_ENET1_RGMII_RXD1		0x00000060
> +			IMX8QM_ENET1_RGMII_RXD2_CONN_ENET1_RGMII_RXD2		0x00000060
> +			IMX8QM_ENET1_RGMII_RXD3_CONN_ENET1_RGMII_RXD3		0x00000060
> +		>;
> +	};
> +
>  	pinctrl_flexcan1: flexcan0grp {
>  		fsl,pins = <
>  			IMX8QM_FLEXCAN0_TX_DMA_FLEXCAN0_TX			0x21
> 
> -- 
> 2.34.1
> 


