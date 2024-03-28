Return-Path: <linux-kernel+bounces-123040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D4F89015D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11A871F26874
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33F68002E;
	Thu, 28 Mar 2024 14:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="gQVcQj6c"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C5C14294;
	Thu, 28 Mar 2024 14:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711635088; cv=none; b=NehHFAnpIHS0BzyuX3n36DLKUMwz3946w/0C5q4cYjblcNyliPPD8kuuxeA3OQUdTZCpPJHmOX4r7WC7cZRZUL6LtBIl04N0HKg6VuxPjt8I/VEtdPpcQnVladaQaFJj+a+RsL4I4mzBx2Ztk7HuMfRFHrIsgaz131OmSr4fwqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711635088; c=relaxed/simple;
	bh=/ST9c7ah1zJQ/+6Zv31rMPGfOa55LO5wYb9NpYAsWEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jfv8TuPgsTLfhqupaKKpn4HFPziYY/p2pUknw3cWbdzPzHRAj8jGfSQ/j2jKoeR2h8pCJBBATLqqEwBt5TuDkZYWS/8Ld7CvXO2rWX/qD7TfJ1L9tPD0EKxBCXjBOKdDrz0FiR4GYoN3np98G73dmGdwbHZQpLr8uaMQmrtO/UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=gQVcQj6c; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=9wIZc962l46yPuHvVREzBXZG1fmGa5fztlhnsqKpiUU=;
	b=gQVcQj6cd0ODZmK/ARzB82ixPy+CUwbipuGuMN5nm3C9AxyFwoJWyyLjAA457V
	U8Eam1ZnkDMnbhQuETeCEt3vNVovl1bP29xSwVXHMd9R2nPpLM71ssgBUW+uBSbM
	SLbRaMquYRYWC778LkDzKVVxIi5erkXBhi3ZcunHkvfR8=
Received: from dragon (unknown [183.213.196.225])
	by smtp2 (Coremail) with SMTP id C1UQrAC3HhhregVmdY9aAg--.12946S3;
	Thu, 28 Mar 2024 22:10:52 +0800 (CST)
Date: Thu, 28 Mar 2024 22:10:51 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] arm64: dts: imx8qxp: add asrc[0,1], esai0,
 spdif[0,1] and sai[4,5]
Message-ID: <ZgV6a7ZMwM4aR7f+@dragon>
References: <20240226192130.259288-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226192130.259288-1-Frank.Li@nxp.com>
X-CM-TRANSID:C1UQrAC3HhhregVmdY9aAg--.12946S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3ZrWftF4UWFykCF4xArWUArb_yoWDuryUpF
	97KFW5Ga4xtF129w1YgF4kGF1kW3s8CFyj93ZxWay8CF9Fgr9rtr4xGr4kWFyYyr12vw1U
	XF15Xr1akwnxK3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jO8nOUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBQ6vZVsVCaj6-gAAsq

On Mon, Feb 26, 2024 at 02:21:29PM -0500, Frank Li wrote:
> Add asrc[0,1], esai0, spdif[0,1], sai[4,5] and related lpcg node for
> imx8 audio subsystem.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../boot/dts/freescale/imx8-ss-audio.dtsi     | 306 ++++++++++++++++++
>  1 file changed, 306 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
> index 07afeb78ed564..6d78d6c0d9002 100644
> --- a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
> @@ -6,6 +6,7 @@
>  
>  #include <dt-bindings/clock/imx8-clock.h>
>  #include <dt-bindings/clock/imx8-lpcg.h>
> +#include <dt-bindings/dma/fsl-edma.h>
>  #include <dt-bindings/firmware/imx/rsrc.h>
>  
>  audio_ipg_clk: clock-audio-ipg {
> @@ -481,4 +482,309 @@ acm: acm@59e00000 {
>  			      "sai3_rx_bclk",
>  			      "sai4_rx_bclk";
>  	};
> +
> +	asrc0: asrc@59000000 {

We want to sort nodes in unit-address, right?

> +		compatible = "fsl,imx8qm-asrc";
> +		reg = <0x59000000 0x10000>;
> +		interrupts = <GIC_SPI 372 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&asrc0_lpcg 0>,
> +			 <&asrc0_lpcg 0>,
> +			 <&aud_pll_div0_lpcg 0>,
> +			 <&aud_pll_div1_lpcg 0>,
> +			 <&acm IMX_ADMA_ACM_AUD_CLK0_SEL>,
> +			 <&acm IMX_ADMA_ACM_AUD_CLK1_SEL>,
> +			 <&clk_dummy>,
> +			 <&clk_dummy>,
> +			 <&clk_dummy>,
> +			 <&clk_dummy>,
> +			 <&clk_dummy>,
> +			 <&clk_dummy>,
> +			 <&clk_dummy>,
> +			 <&clk_dummy>,
> +			 <&clk_dummy>,
> +			 <&clk_dummy>,
> +			 <&clk_dummy>,
> +			 <&clk_dummy>,
> +			 <&clk_dummy>;
> +		clock-names = "ipg", "mem",
> +			      "asrck_0", "asrck_1", "asrck_2", "asrck_3",
> +			      "asrck_4", "asrck_5", "asrck_6", "asrck_7",
> +			      "asrck_8", "asrck_9", "asrck_a", "asrck_b",
> +			      "asrck_c", "asrck_d", "asrck_e", "asrck_f",
> +			      "spba";
> +		dmas = <&edma0 0 0 0>,
> +		       <&edma0 1 0 0>,
> +		       <&edma0 2 0 0>,
> +		       <&edma0 3 0 FSL_EDMA_RX>,
> +		       <&edma0 4 0 FSL_EDMA_RX>,
> +		       <&edma0 5 0 FSL_EDMA_RX>;
> +		/* tx* is output channel of asrc, it is rx channel for eDMA */
> +		dma-names = "rxa", "rxb", "rxc", "txa", "txb", "txc";
> +		fsl,asrc-rate  = <8000>;

One space around =

> +		fsl,asrc-width = <16>;
> +		fsl,asrc-clk-map = <0>;
> +		power-domains = <&pd IMX_SC_R_ASRC_0>;
> +		status = "disabled";
> +	};
> +
> +	esai0: esai@59010000 {
> +		compatible = "fsl,imx8qm-esai", "fsl,imx6ull-esai";
> +		reg = <0x59010000 0x10000>;
> +		interrupts = <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&esai0_lpcg 1>, <&esai0_lpcg 0>, <&esai0_lpcg 1>, <&clk_dummy>;
> +		clock-names = "core", "extal", "fsys", "spba";
> +		dmas = <&edma0 6 0 FSL_EDMA_RX>, <&edma0 7 0 0>;
> +		dma-names = "rx", "tx";
> +		power-domains = <&pd IMX_SC_R_ESAI_0>;
> +		status = "disabled";
> +	};
> +
> +	spdif0: spdif@59020000 {
> +		compatible = "fsl,imx8qm-spdif";
> +		reg = <0x59020000 0x10000>;
> +		interrupts =  <GIC_SPI 456 IRQ_TYPE_LEVEL_HIGH>, /* rx */

Ditto

> +			      <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>; /* tx */
> +		clocks = <&spdif0_lpcg 1>,	/* core */
> +			 <&clk_dummy>,		/* rxtx0 */
> +			 <&spdif0_lpcg 0>,	/* rxtx1 */
> +			 <&clk_dummy>,		/* rxtx2 */
> +			 <&clk_dummy>,		/* rxtx3 */
> +			 <&clk_dummy>,		/* rxtx4 */
> +			 <&audio_ipg_clk>,	/* rxtx5 */
> +			 <&clk_dummy>,		/* rxtx6 */
> +			 <&clk_dummy>,		/* rxtx7 */
> +			 <&clk_dummy>;		/* spba */
> +		clock-names = "core", "rxtx0", "rxtx1", "rxtx2", "rxtx3", "rxtx4",
> +			      "rxtx5", "rxtx6", "rxtx7", "spba";
> +		dmas = <&edma0 8 0 (FSL_EDMA_MULTI_FIFO | FSL_EDMA_RX)>,
> +		       <&edma0 9 0 FSL_EDMA_MULTI_FIFO>;
> +		dma-names = "rx", "tx";
> +		power-domains = <&pd IMX_SC_R_SPDIF_0>;
> +		status = "disabled";
> +	};
> +
> +	spdif1: spdif@59030000 {
> +		compatible = "fsl,imx8qm-spdif";
> +		reg = <0x59030000 0x10000>;
> +		interrupts =  <GIC_SPI 460 IRQ_TYPE_LEVEL_HIGH>, /* rx */

Ditto

Shawn

> +			      <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH>; /* tx */
> +		clocks = <&spdif1_lpcg 1>,	/* core */
> +			 <&clk_dummy>,		/* rxtx0 */
> +			 <&spdif1_lpcg 0>,	/* rxtx1 */
> +			 <&clk_dummy>,		/* rxtx2 */
> +			 <&clk_dummy>,		/* rxtx3 */
> +			 <&clk_dummy>,		/* rxtx4 */
> +			 <&audio_ipg_clk>,	/* rxtx5 */
> +			 <&clk_dummy>,		/* rxtx6 */
> +			 <&clk_dummy>,		/* rxtx7 */
> +			 <&clk_dummy>;		/* spba */
> +		clock-names = "core", "rxtx0", "rxtx1", "rxtx2", "rxtx3", "rxtx4",
> +			      "rxtx5", "rxtx6", "rxtx7", "spba";
> +		dmas = <&edma0 10 0 (FSL_EDMA_MULTI_FIFO | FSL_EDMA_RX)>,
> +		       <&edma0 11 0 FSL_EDMA_MULTI_FIFO>;
> +		dma-names = "rx", "tx";
> +		power-domains = <&pd IMX_SC_R_SPDIF_1>;
> +		status = "disabled";
> +	};
> +
> +	asrc1: asrc@59800000 {
> +		compatible = "fsl,imx8qm-asrc";
> +		reg = <0x59800000 0x10000>;
> +		interrupts = <GIC_SPI 380 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 381 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&asrc1_lpcg 0>,
> +			 <&asrc1_lpcg 0>,
> +			 <&aud_pll_div0_lpcg 0>,
> +			 <&aud_pll_div1_lpcg 0>,
> +			 <&acm IMX_ADMA_ACM_AUD_CLK0_SEL>,
> +			 <&acm IMX_ADMA_ACM_AUD_CLK1_SEL>,
> +			 <&clk_dummy>,
> +			 <&clk_dummy>,
> +			 <&clk_dummy>,
> +			 <&clk_dummy>,
> +			 <&clk_dummy>,
> +			 <&clk_dummy>,
> +			 <&clk_dummy>,
> +			 <&clk_dummy>,
> +			 <&clk_dummy>,
> +			 <&clk_dummy>,
> +			 <&clk_dummy>,
> +			 <&clk_dummy>,
> +			 <&clk_dummy>;
> +		clock-names = "ipg", "mem",
> +			      "asrck_0", "asrck_1", "asrck_2", "asrck_3",
> +			      "asrck_4", "asrck_5", "asrck_6", "asrck_7",
> +			      "asrck_8", "asrck_9", "asrck_a", "asrck_b",
> +			      "asrck_c", "asrck_d", "asrck_e", "asrck_f",
> +			      "spba";
> +		dmas = <&edma1 0 0 0>,
> +		       <&edma1 1 0 0>,
> +		       <&edma1 2 0 0>,
> +		       <&edma1 3 0 FSL_EDMA_RX>,
> +		       <&edma1 4 0 FSL_EDMA_RX>,
> +		       <&edma1 5 0 FSL_EDMA_RX>;
> +		/* tx* is output channel of asrc, it is rx channel for eDMA */
> +		dma-names = "txa", "txb", "txc", "rxa", "rxb", "rxc";
> +		fsl,asrc-rate  = <8000>;
> +		fsl,asrc-width = <16>;
> +		fsl,asrc-clk-map = <1>;
> +		power-domains = <&pd IMX_SC_R_ASRC_1>;
> +		status = "disabled";
> +	};
> +
> +	sai4: sai@59820000 {
> +		compatible = "fsl,imx8qm-sai";
> +		reg = <0x59820000 0x10000>;
> +		interrupts = <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&sai4_lpcg 1>,
> +			 <&clk_dummy>,
> +			 <&sai4_lpcg 0>,
> +			 <&clk_dummy>,
> +			 <&clk_dummy>;
> +		clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
> +		dmas = <&edma1 8 0 FSL_EDMA_RX>, <&edma1 9 0 0>;
> +		dma-names = "rx", "tx";
> +		power-domains = <&pd IMX_SC_R_SAI_4>;
> +		status = "disabled";
> +	};
> +
> +	sai5: sai@59830000 {
> +		compatible = "fsl,imx8qm-sai";
> +		reg = <0x59830000 0x10000>;
> +		interrupts = <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&sai5_lpcg 1>,
> +			 <&clk_dummy>,
> +			 <&sai5_lpcg 0>,
> +			 <&clk_dummy>,
> +			 <&clk_dummy>;
> +		clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
> +		dmas = <&edma1 10 0 0>;
> +		dma-names = "tx";
> +		power-domains = <&pd IMX_SC_R_SAI_5>;
> +		status = "disabled";
> +	};
> +
> +	amix: amix@59840000 {
> +		compatible = "fsl,imx8qm-audmix";
> +		reg = <0x59840000 0x10000>;
> +		clocks = <&amix_lpcg 0>;
> +		clock-names = "ipg";
> +		power-domains = <&pd IMX_SC_R_AMIX>;
> +		dais = <&sai4>, <&sai5>;
> +		status = "disabled";
> +	};
> +
> +	mqs: mqs@59850000 {
> +		compatible = "fsl,imx8qm-mqs";
> +		reg = <0x59850000 0x10000>;
> +		clocks = <&mqs0_lpcg 1>,
> +			<&mqs0_lpcg 0>;
> +		clock-names = "core", "mclk";
> +		power-domains = <&pd IMX_SC_R_MQS_0>;
> +		status = "disabled";
> +	};
> +
> +	asrc0_lpcg: clock-controller@59400000 {
> +		compatible = "fsl,imx8qxp-lpcg";
> +		reg = <0x59400000 0x10000>;
> +		#clock-cells = <1>;
> +		clocks = <&audio_ipg_clk>;
> +		clock-indices = <IMX_LPCG_CLK_4>;
> +		clock-output-names = "asrc0_lpcg_ipg_clk";
> +		power-domains = <&pd IMX_SC_R_ASRC_0>;
> +	};
> +
> +	esai0_lpcg: clock-controller@59410000 {
> +		compatible = "fsl,imx8qxp-lpcg";
> +		reg = <0x59410000 0x10000>;
> +		#clock-cells = <1>;
> +		clocks = <&acm IMX_ADMA_ACM_ESAI0_MCLK_SEL>,
> +			 <&audio_ipg_clk>;
> +		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
> +		clock-output-names = "esai0_lpcg_extal_clk",
> +				     "esai0_lpcg_ipg_clk";
> +		power-domains = <&pd IMX_SC_R_ESAI_0>;
> +	};
> +
> +	spdif0_lpcg: clock-controller@59420000 {
> +		compatible = "fsl,imx8qxp-lpcg";
> +		reg = <0x59420000 0x10000>;
> +		#clock-cells = <1>;
> +		clocks = <&acm IMX_ADMA_ACM_SPDIF0_TX_CLK_SEL>,
> +			 <&audio_ipg_clk>;
> +		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
> +		clock-output-names = "spdif0_lpcg_tx_clk",
> +				     "spdif0_lpcg_gclkw";
> +		power-domains = <&pd IMX_SC_R_SPDIF_0>;
> +	};
> +
> +	spdif1_lpcg: clock-controller@59430000 {
> +		compatible = "fsl,imx8qxp-lpcg";
> +		reg = <0x59430000 0x10000>;
> +		#clock-cells = <1>;
> +		clocks = <&acm IMX_ADMA_ACM_SPDIF1_TX_CLK_SEL>,
> +			 <&audio_ipg_clk>;
> +		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
> +		clock-output-names = "spdif1_lpcg_tx_clk",
> +				     "spdif1_lpcg_gclkw";
> +		power-domains = <&pd IMX_SC_R_SPDIF_1>;
> +		status = "disabled";
> +	};
> +
> +	asrc1_lpcg: clock-controller@59c00000 {
> +		compatible = "fsl,imx8qxp-lpcg";
> +		reg = <0x59c00000 0x10000>;
> +		#clock-cells = <1>;
> +		clocks = <&audio_ipg_clk>;
> +		clock-indices = <IMX_LPCG_CLK_4>;
> +		clock-output-names = "asrc1_lpcg_ipg_clk";
> +		power-domains = <&pd IMX_SC_R_ASRC_1>;
> +	};
> +
> +	sai4_lpcg: clock-controller@59c20000 {
> +		compatible = "fsl,imx8qxp-lpcg";
> +		reg = <0x59c20000 0x10000>;
> +		#clock-cells = <1>;
> +		clocks = <&acm IMX_ADMA_ACM_SAI4_MCLK_SEL>,
> +			 <&audio_ipg_clk>;
> +		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
> +		clock-output-names = "sai4_lpcg_mclk",
> +				     "sai4_lpcg_ipg_clk";
> +		power-domains = <&pd IMX_SC_R_SAI_4>;
> +	};
> +
> +	sai5_lpcg: clock-controller@59c30000 {
> +		compatible = "fsl,imx8qxp-lpcg";
> +		reg = <0x59c30000 0x10000>;
> +		#clock-cells = <1>;
> +		clocks = <&acm IMX_ADMA_ACM_SAI5_MCLK_SEL>,
> +			 <&audio_ipg_clk>;
> +		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
> +		clock-output-names = "sai5_lpcg_mclk",
> +				     "sai5_lpcg_ipg_clk";
> +		power-domains = <&pd IMX_SC_R_SAI_5>;
> +	};
> +
> +	amix_lpcg: clock-controller@59c40000 {
> +		compatible = "fsl,imx8qxp-lpcg";
> +		reg = <0x59c40000 0x10000>;
> +		#clock-cells = <1>;
> +		clocks = <&audio_ipg_clk>;
> +		clock-indices = <IMX_LPCG_CLK_0>;
> +		clock-output-names = "amix_lpcg_ipg_clk";
> +		power-domains = <&pd IMX_SC_R_AMIX>;
> +	};
> +
> +	mqs0_lpcg: clock-controller@59c50000 {
> +		compatible = "fsl,imx8qxp-lpcg";
> +		reg = <0x59c50000 0x10000>;
> +		#clock-cells = <1>;
> +		clocks = <&acm IMX_ADMA_ACM_MQS_TX_CLK_SEL>,
> +			 <&audio_ipg_clk>;
> +		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
> +		clock-output-names = "mqs0_lpcg_mclk",
> +				     "mqs0_lpcg_ipg_clk";
> +		power-domains = <&pd IMX_SC_R_MQS_0>;
> +	};
>  };
> -- 
> 2.34.1
> 


