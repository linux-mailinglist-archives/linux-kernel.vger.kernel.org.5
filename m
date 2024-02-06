Return-Path: <linux-kernel+bounces-54704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B45E984B29C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8592A1C2417B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86631EA7A;
	Tue,  6 Feb 2024 10:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="TVbV6ANW"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E67533D1;
	Tue,  6 Feb 2024 10:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707215939; cv=none; b=HwJrJD5Q4KdEgHKNXaGMV8zx/qb45JH10EYIuJrf9Gmfr4fOJaDkGUUxMSjxNF5zM0R5V8qqTFlwz0VEExjpkA2Y2fQ2Fyy0HKilI3nIX/N8Oxfcb8R8DOyfhsvB77d32gGwr0mm8REY82VIaw4CH/nrxL8/ANcFH2aU96fF+Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707215939; c=relaxed/simple;
	bh=jIDetKdqCHcAy2PHqpROZugyHayLlJ1AtCGMh46V4os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sd2+QX86FzRNZYiSPDywjYa3XZiMmrOVH1SUMNzTSF6j+4y4YxYJI5kgEYzpWx4fwiUh1lrXj68SCwtrpbRnh4+XJuommCtCp5MyaSZ5ka9KmMrrwZTA5NzaYmDsyMpS2i+WuhXF49hrzMefilsnHXpwoCkC0o3TP11DnNsnB6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=TVbV6ANW; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=rMy70T7bGq+86zodkiE5SnCSlDJcdq4HaQVB8APMukQ=;
	b=TVbV6ANWNZ3RER6wPjOEzpUZ/iX8Lucs4azd6YiPVzSuGCjCyatDNwMXh9WZsz
	6zqtFyzqR02KMp36N+dRLg1KkHq5jnRw4rBBWzlrywi8i+YNhOxw01eDtpayztth
	vr16iVDFiF+XElF5KitojBEGEX3K1VpSF/A4XD66vfXQY=
Received: from dragon (unknown [183.213.196.254])
	by smtp2 (Coremail) with SMTP id C1UQrADn7wgmDMJlAEACAw--.34613S3;
	Tue, 06 Feb 2024 18:38:31 +0800 (CST)
Date: Tue, 6 Feb 2024 18:38:29 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 2/2] arm64: dts: imx8dxl update edma0 information
Message-ID: <ZcIMJWKBrPW4Y5R8@dragon>
References: <20240129201633.234255-1-Frank.Li@nxp.com>
 <20240129201633.234255-2-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129201633.234255-2-Frank.Li@nxp.com>
X-CM-TRANSID:C1UQrADn7wgmDMJlAEACAw--.34613S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFyrXr48CF4UZr4UJw43ZFb_yoWrXr43p3
	4UCF4DX3sag3W2v3Waga1xAryfGrn2kr4Ygr90k3y8JF92gFyIvF47Kr1vkF13Gr48XFy5
	XFsrCry8A3W3XrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jz4E_UUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDwd8ZVnxccILPgACs9

On Mon, Jan 29, 2024 at 03:16:32PM -0500, Frank Li wrote:
> edma0 of iMX8DXL is difference with other imx8 chips. Update register's
> size, channel number and power-domain.
> Update i2c[0-3] channel number information.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../boot/dts/freescale/imx8dxl-ss-adma.dtsi   | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
> index 0a477f6318f15..f8fca86babda7 100644
> --- a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
> @@ -15,6 +15,63 @@ &adc0 {
>  	interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
>  };
>  
> +&edma0 {
> +	reg = <0x591f0000 0x1a0000>;
> +	#dma-cells = <3>;
> +	dma-channels = <25>;
> +	dma-channel-mask = <0x1c0cc0>;
> +	interrupts = <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>, /* asrc 0 */
> +		<GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>,
> +		<GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH>,
> +		<GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>,
> +		<GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>,
> +		<GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>,
> +		<GIC_SPI 0   IRQ_TYPE_LEVEL_HIGH>,
> +		<GIC_SPI 0   IRQ_TYPE_LEVEL_HIGH>,
> +		<GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>, /* spdif0 */
> +		<GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>,
> +		<GIC_SPI 0   IRQ_TYPE_LEVEL_HIGH>,
> +		<GIC_SPI 0   IRQ_TYPE_LEVEL_HIGH>,
> +		<GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>, /* sai0 */
> +		<GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
> +		<GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>, /* sai1 */
> +		<GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
> +		<GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>, /* sai2 */
> +		<GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>, /* sai3 */
> +		<GIC_SPI 0   IRQ_TYPE_LEVEL_HIGH>,
> +		<GIC_SPI 0   IRQ_TYPE_LEVEL_HIGH>,
> +		<GIC_SPI 0   IRQ_TYPE_LEVEL_HIGH>,
> +		<GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>, /* gpt0 */
> +		<GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH>, /* gpt1 */
> +		<GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH>, /* gpt2 */
> +		<GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>; /* gpt3 */
> +	power-domains = <&pd IMX_SC_R_DMA_0_CH0>,
> +			<&pd IMX_SC_R_DMA_0_CH1>,
> +			<&pd IMX_SC_R_DMA_0_CH2>,
> +			<&pd IMX_SC_R_DMA_0_CH3>,
> +			<&pd IMX_SC_R_DMA_0_CH4>,
> +			<&pd IMX_SC_R_DMA_0_CH5>,
> +			<&pd IMX_SC_R_DMA_0_CH6>,
> +			<&pd IMX_SC_R_DMA_0_CH7>,
> +			<&pd IMX_SC_R_DMA_0_CH8>,
> +			<&pd IMX_SC_R_DMA_0_CH9>,
> +			<&pd IMX_SC_R_DMA_0_CH10>,
> +			<&pd IMX_SC_R_DMA_0_CH11>,
> +			<&pd IMX_SC_R_DMA_0_CH12>,
> +			<&pd IMX_SC_R_DMA_0_CH13>,
> +			<&pd IMX_SC_R_DMA_0_CH14>,
> +			<&pd IMX_SC_R_DMA_0_CH15>,
> +			<&pd IMX_SC_R_DMA_0_CH16>,
> +			<&pd IMX_SC_R_DMA_0_CH17>,
> +			<&pd IMX_SC_R_DMA_0_CH18>,
> +			<&pd IMX_SC_R_DMA_0_CH19>,
> +			<&pd IMX_SC_R_DMA_0_CH20>,
> +			<&pd IMX_SC_R_DMA_0_CH21>,
> +			<&pd IMX_SC_R_DMA_0_CH22>,
> +			<&pd IMX_SC_R_DMA_0_CH23>,
> +			<&pd IMX_SC_R_DMA_0_CH24>;
> +};
> +
>  &edma2 {
>  	interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>,
>  		     <GIC_SPI 289 IRQ_TYPE_LEVEL_HIGH>,
> @@ -48,21 +105,29 @@ &edma3 {
>  &i2c0 {
>  	compatible = "fsl,imx8dxl-lpi2c", "fsl,imx7ulp-lpi2c";
>  	interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
> +	dma-names = "tx","rx";
> +	dmas = <&edma3 1 0 0>, <&edma3 0 0 FSL_EDMA_RX>;
>  };
>  
>  &i2c1 {
>  	compatible = "fsl,imx8dxl-lpi2c", "fsl,imx7ulp-lpi2c";
>  	interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
> +	dma-names = "tx","rx";
> +	dmas = <&edma3 3 0 0>, <&edma3 2 0 FSL_EDMA_RX>;

No FSL_EDMA_TX for "tx"?

Shawn

>  };
>  
>  &i2c2 {
>  	compatible = "fsl,imx8dxl-lpi2c", "fsl,imx7ulp-lpi2c";
>  	interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
> +	dma-names = "tx","rx";
> +	dmas = <&edma3 5 0 0>, <&edma3 4 0 FSL_EDMA_RX>;
>  };
>  
>  &i2c3 {
>  	compatible = "fsl,imx8dxl-lpi2c", "fsl,imx7ulp-lpi2c";
>  	interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
> +	dma-names = "tx","rx";
> +	dmas = <&edma3 7 0 0>, <&edma3 6 0 FSL_EDMA_RX>;
>  };
>  
>  &lpuart0 {
> -- 
> 2.34.1
> 


