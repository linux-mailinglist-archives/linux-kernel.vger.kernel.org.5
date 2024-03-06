Return-Path: <linux-kernel+bounces-93416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A82872F76
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 508E81C2249D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8947A5C90D;
	Wed,  6 Mar 2024 07:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="cUhEyju6"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB04E1B812;
	Wed,  6 Mar 2024 07:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709709611; cv=none; b=LEmUigWUJm5lPjzKPwoy+OAOfHC4LNl0O0yoA8fUsBgqBQq8OFMkApSoZrDc7J56PYqL+39OjKnIQW7aLq0fAZTpzKNwG9lVRxe9Yj+SDr6UGjItTPjmcsFsnrbhNNgYSkBvV65UjmR8D2LbsB2lXOYv/3XvbivAkB9sC0gjrkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709709611; c=relaxed/simple;
	bh=3hSTie2Z4h1aOmI/fKXJ9/KRM8g2DZju6vdN3L8tNX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gE1urkSpA5EM3Lz1guH3nhPGzYxBUcREDyIuL7vXj+eWbgpns2MiVDjRpJzddbUCfHvZl3quRGCitRHuD/j76inUE+n6vgxDpJMP37vjCXU1Uq/CqSd+T9M33frVUXroh/wK8AFKGw1/piLFaqNIDEvPi6ObnZCRRimvzvbLExM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=cUhEyju6; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1709709607; x=1741245607;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jW3nFBn6TcQTAHKIo2UTCLyc402JWm2+7QktnDYTndE=;
  b=cUhEyju6gK0mHaRwx1HLL5JwHP9DbuIkRNKPuuq+E0jFwJKlz3BbI4H3
   XeFiO75ivxmMc7SOh/ZJgNNnsuUZpQf8AK3rhwvPrKPaliLRgbQ3waE2M
   XjQLIFOwRfihswhykx6mYA1bPAUuou43R6n20nWBgvkrkPU7xBeGdpW/v
   M8eLc3mHJ3+s3I12g5sxOdbBiWI4hFd1B/wQ5kXuPsQUNFJyL0F/BCSmH
   LQQ7E2dWZ4ghzpYQoge4/kn5327X+sgF/oZHpE4LxfsL8RN0GKjt/sKAE
   WnvJ2bfZ39jrLzKLIXRUxZHthd+9gW5y3mUdfKIPxj4fkg3xzqWU2pFuE
   w==;
X-IronPort-AV: E=Sophos;i="6.06,207,1705359600"; 
   d="scan'208";a="35754710"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 06 Mar 2024 08:19:58 +0100
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 9EF8D280071;
	Wed,  6 Mar 2024 08:19:58 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Shengjiu Wang <shengjiu.wang@nxp.com>, linux-arm-kernel@lists.infradead.org, Frank Li <Frank.Li@nxp.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v4 4/4] arm64: dts: imx8qxp: add asrc[0, 1], esai0, spdif[0, 1] and sai[4, 5]
Date: Wed, 06 Mar 2024 08:20:00 +0100
Message-ID: <2177674.irdbgypaU6@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240305-asrc_8qxp-v4-4-c61b98046591@nxp.com>
References: <20240305-asrc_8qxp-v4-0-c61b98046591@nxp.com> <20240305-asrc_8qxp-v4-4-c61b98046591@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi Frank,

thanks for the patch.

Am Dienstag, 5. M=E4rz 2024, 18:33:05 CET schrieb Frank Li:
> Add asrc[0,1], esai0, spdif[0,1], sai[4,5] and related lpcg node for
> imx8 audio subsystem.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi | 304 +++++++++++++++++=
++++++
>  1 file changed, 304 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi b/arch/arm6=
4/boot/dts/freescale/imx8-ss-audio.dtsi
> index 07afeb78ed564..78305559f15c9 100644
> --- a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
> @@ -6,6 +6,7 @@
> =20
>  #include <dt-bindings/clock/imx8-clock.h>
>  #include <dt-bindings/clock/imx8-lpcg.h>
> +#include <dt-bindings/dma/fsl-edma.h>
>  #include <dt-bindings/firmware/imx/rsrc.h>
> =20
>  audio_ipg_clk: clock-audio-ipg {
> @@ -481,4 +482,307 @@ acm: acm@59e00000 {
>  			      "sai3_rx_bclk",
>  			      "sai4_rx_bclk";
>  	};
> +
> +	asrc0: asrc@59000000 {

Please insert nodes sorted by address. ASRC0 is the very first node.

> +		compatible =3D "fsl,imx8qm-asrc";
> +		reg =3D <0x59000000 0x10000>;
> +		interrupts =3D <GIC_SPI 372 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks =3D <&asrc0_lpcg 0>,
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
> +		clock-names =3D "mem", "ipg",
> +			      "asrck_0", "asrck_1", "asrck_2", "asrck_3",
> +			      "asrck_4", "asrck_5", "asrck_6", "asrck_7",
> +			      "asrck_8", "asrck_9", "asrck_a", "asrck_b",
> +			      "asrck_c", "asrck_d", "asrck_e", "asrck_f",
> +			      "spba";
> +		dmas =3D <&edma0 0 0 0>,
> +		       <&edma0 1 0 0>,
> +		       <&edma0 2 0 0>,
> +		       <&edma0 3 0 FSL_EDMA_RX>,
> +		       <&edma0 4 0 FSL_EDMA_RX>,
> +		       <&edma0 5 0 FSL_EDMA_RX>;
> +		/* tx* is output channel of asrc, it is rx channel for eDMA */
> +		dma-names =3D "rxa", "rxb", "rxc", "txa", "txb", "txc";
> +		fsl,asrc-rate  =3D <8000>;
> +		fsl,asrc-width =3D <16>;
> +		fsl,asrc-clk-map =3D <0>;
> +		power-domains =3D <&pd IMX_SC_R_ASRC_0>;
> +		status =3D "disabled";
> +	};
> +
> +	esai0: esai@59010000 {
> +		compatible =3D "fsl,imx8qm-esai", "fsl,imx6ull-esai";
> +		reg =3D <0x59010000 0x10000>;
> +		interrupts =3D <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks =3D <&esai0_lpcg 1>, <&esai0_lpcg 0>, <&esai0_lpcg 1>, <&clk_du=
mmy>;
> +		clock-names =3D "core", "extal", "fsys", "spba";
> +		dmas =3D <&edma0 6 0 FSL_EDMA_RX>, <&edma0 7 0 0>;
> +		dma-names =3D "rx", "tx";
> +		power-domains =3D <&pd IMX_SC_R_ESAI_0>;
> +		status =3D "disabled";
> +	};
> +
> +	spdif0: spdif@59020000 {
> +		compatible =3D "fsl,imx8qm-spdif";
> +		reg =3D <0x59020000 0x10000>;
> +		interrupts =3D  <GIC_SPI 456 IRQ_TYPE_LEVEL_HIGH>, /* rx */
> +			      <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>; /* tx */
> +		clocks =3D <&spdif0_lpcg 1>,	/* core */
> +			 <&clk_dummy>,		/* rxtx0 */
> +			 <&spdif0_lpcg 0>,	/* rxtx1 */
> +			 <&clk_dummy>,		/* rxtx2 */
> +			 <&clk_dummy>,		/* rxtx3 */
> +			 <&clk_dummy>,		/* rxtx4 */
> +			 <&audio_ipg_clk>,	/* rxtx5 */
> +			 <&clk_dummy>,		/* rxtx6 */
> +			 <&clk_dummy>,		/* rxtx7 */
> +			 <&clk_dummy>;		/* spba */
> +		clock-names =3D "core", "rxtx0", "rxtx1", "rxtx2", "rxtx3", "rxtx4",
> +			      "rxtx5", "rxtx6", "rxtx7", "spba";
> +		dmas =3D <&edma0 8 0 (FSL_EDMA_MULTI_FIFO | FSL_EDMA_RX)>,
> +		       <&edma0 9 0 FSL_EDMA_MULTI_FIFO>;
> +		dma-names =3D "rx", "tx";
> +		power-domains =3D <&pd IMX_SC_R_SPDIF_0>;
> +		status =3D "disabled";
> +	};
> +
> +	spdif1: spdif@59030000 {

That's imx8qm only, no?

> +		compatible =3D "fsl,imx8qm-spdif";
> +		reg =3D <0x59030000 0x10000>;
> +		interrupts =3D  <GIC_SPI 460 IRQ_TYPE_LEVEL_HIGH>, /* rx */
> +			      <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH>; /* tx */
> +		clocks =3D <&spdif1_lpcg 1>,	/* core */
> +			 <&clk_dummy>,		/* rxtx0 */
> +			 <&spdif1_lpcg 0>,	/* rxtx1 */
> +			 <&clk_dummy>,		/* rxtx2 */
> +			 <&clk_dummy>,		/* rxtx3 */
> +			 <&clk_dummy>,		/* rxtx4 */
> +			 <&audio_ipg_clk>,	/* rxtx5 */
> +			 <&clk_dummy>,		/* rxtx6 */
> +			 <&clk_dummy>,		/* rxtx7 */
> +			 <&clk_dummy>;		/* spba */
> +		clock-names =3D "core", "rxtx0", "rxtx1", "rxtx2", "rxtx3", "rxtx4",
> +			      "rxtx5", "rxtx6", "rxtx7", "spba";
> +		dmas =3D <&edma0 10 0 (FSL_EDMA_MULTI_FIFO | FSL_EDMA_RX)>,
> +		       <&edma0 11 0 FSL_EDMA_MULTI_FIFO>;
> +		dma-names =3D "rx", "tx";
> +		power-domains =3D <&pd IMX_SC_R_SPDIF_1>;
> +		status =3D "disabled";
> +	};
> +
> +	asrc1: asrc@59800000 {

Insert this between dsp and edma1, sorted by address.

> +		compatible =3D "fsl,imx8qm-asrc";
> +		reg =3D <0x59800000 0x10000>;
> +		interrupts =3D <GIC_SPI 380 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks =3D <&asrc1_lpcg 0>,
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
> +		clock-names =3D "mem", "ipg",
> +			      "asrck_0", "asrck_1", "asrck_2", "asrck_3",
> +			      "asrck_4", "asrck_5", "asrck_6", "asrck_7",
> +			      "asrck_8", "asrck_9", "asrck_a", "asrck_b",
> +			      "asrck_c", "asrck_d", "asrck_e", "asrck_f",
> +			      "spba";
> +		dmas =3D <&edma1 0 0 0>,
> +		       <&edma1 1 0 0>,
> +		       <&edma1 2 0 0>,
> +		       <&edma1 3 0 FSL_EDMA_RX>,
> +		       <&edma1 4 0 FSL_EDMA_RX>,
> +		       <&edma1 5 0 FSL_EDMA_RX>;
> +		/* tx* is output channel of asrc, it is rx channel for eDMA */
> +		dma-names =3D "rxa", "rxb", "rxc", "txa", "txb", "txc";
> +		fsl,asrc-rate  =3D <8000>;
> +		fsl,asrc-width =3D <16>;
> +		fsl,asrc-clk-map =3D <1>;
> +		power-domains =3D <&pd IMX_SC_R_ASRC_1>;
> +		status =3D "disabled";
> +	};
> +
> +	sai4: sai@59820000 {
> +		compatible =3D "fsl,imx8qm-sai";
> +		reg =3D <0x59820000 0x10000>;
> +		interrupts =3D <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks =3D <&sai4_lpcg 1>,
> +			 <&clk_dummy>,
> +			 <&sai4_lpcg 0>,
> +			 <&clk_dummy>,
> +			 <&clk_dummy>;
> +		clock-names =3D "bus", "mclk0", "mclk1", "mclk2", "mclk3";
> +		dmas =3D <&edma1 8 0 FSL_EDMA_RX>, <&edma1 9 0 0>;
> +		dma-names =3D "rx", "tx";
> +		power-domains =3D <&pd IMX_SC_R_SAI_4>;
> +		status =3D "disabled";
> +	};
> +
> +	sai5: sai@59830000 {
> +		compatible =3D "fsl,imx8qm-sai";
> +		reg =3D <0x59830000 0x10000>;
> +		interrupts =3D <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks =3D <&sai5_lpcg 1>,
> +			 <&clk_dummy>,
> +			 <&sai5_lpcg 0>,
> +			 <&clk_dummy>,
> +			 <&clk_dummy>;
> +		clock-names =3D "bus", "mclk0", "mclk1", "mclk2", "mclk3";
> +		dmas =3D <&edma1 10 0 0>;
> +		dma-names =3D "tx";
> +		power-domains =3D <&pd IMX_SC_R_SAI_5>;
> +		status =3D "disabled";
> +	};
> +
> +	amix: amix@59840000 {
> +		compatible =3D "fsl,imx8qm-audmix";
> +		reg =3D <0x59840000 0x10000>;
> +		clocks =3D <&amix_lpcg 0>;
> +		clock-names =3D "ipg";
> +		power-domains =3D <&pd IMX_SC_R_AMIX>;
> +		dais =3D <&sai4>, <&sai5>;
> +		status =3D "disabled";
> +	};
> +
> +	mqs: mqs@59850000 {
> +		compatible =3D "fsl,imx8qm-mqs";
> +		reg =3D <0x59850000 0x10000>;
> +		clocks =3D <&mqs0_lpcg 0>,
> +			<&mqs0_lpcg 1>;
> +		clock-names =3D "mclk", "core";
> +		power-domains =3D <&pd IMX_SC_R_MQS_0>;
> +		status =3D "disabled";
> +	};
> +
> +	asrc0_lpcg: clock-controller@59400000 {

Please insert he lpcg nodes according to their address.

> +		compatible =3D "fsl,imx8qxp-lpcg";
> +		reg =3D <0x59400000 0x10000>;
> +		#clock-cells =3D <1>;
> +		clocks =3D <&audio_ipg_clk>;
> +		clock-indices =3D <IMX_LPCG_CLK_4>;
> +		clock-output-names =3D "asrc0_lpcg_ipg_clk";
> +		power-domains =3D <&pd IMX_SC_R_ASRC_0>;
> +	};
> +
> +	esai0_lpcg: clock-controller@59410000 {
> +		compatible =3D "fsl,imx8qxp-lpcg";
> +		reg =3D <0x59410000 0x10000>;
> +		#clock-cells =3D <1>;
> +		clocks =3D <&acm IMX_ADMA_ACM_ESAI0_MCLK_SEL>,
> +			 <&audio_ipg_clk>;
> +		clock-indices =3D <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
> +		clock-output-names =3D "esai0_lpcg_extal_clk",
> +				     "esai0_lpcg_ipg_clk";
> +		power-domains =3D <&pd IMX_SC_R_ESAI_0>;
> +	};
> +
> +	spdif0_lpcg: clock-controller@59420000 {
> +		compatible =3D "fsl,imx8qxp-lpcg";
> +		reg =3D <0x59420000 0x10000>;
> +		#clock-cells =3D <1>;
> +		clocks =3D <&acm IMX_ADMA_ACM_SPDIF0_TX_CLK_SEL>,
> +			 <&audio_ipg_clk>;
> +		clock-indices =3D <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
> +		clock-output-names =3D "spdif0_lpcg_tx_clk",
> +				     "spdif0_lpcg_gclkw";
> +		power-domains =3D <&pd IMX_SC_R_SPDIF_0>;
> +	};
> +
> +	spdif1_lpcg: clock-controller@59430000 {

That's imx8qm only as well, no?

Thanks and best regards,
Alexander

> +		compatible =3D "fsl,imx8qxp-lpcg";
> +		reg =3D <0x59430000 0x10000>;
> +		#clock-cells =3D <1>;
> +		clocks =3D <&acm IMX_ADMA_ACM_SPDIF1_TX_CLK_SEL>,
> +			 <&audio_ipg_clk>;
> +		clock-indices =3D <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
> +		clock-output-names =3D "spdif1_lpcg_tx_clk",
> +				     "spdif1_lpcg_gclkw";
> +		power-domains =3D <&pd IMX_SC_R_SPDIF_1>;
> +		status =3D "disabled";
> +	};
> +
> +	asrc1_lpcg: clock-controller@59c00000 {
> +		compatible =3D "fsl,imx8qxp-lpcg";
> +		reg =3D <0x59c00000 0x10000>;
> +		#clock-cells =3D <1>;
> +		clocks =3D <&audio_ipg_clk>;
> +		clock-indices =3D <IMX_LPCG_CLK_4>;
> +		clock-output-names =3D "asrc1_lpcg_ipg_clk";
> +		power-domains =3D <&pd IMX_SC_R_ASRC_1>;
> +	};
> +
> +	sai4_lpcg: clock-controller@59c20000 {
> +		compatible =3D "fsl,imx8qxp-lpcg";
> +		reg =3D <0x59c20000 0x10000>;
> +		#clock-cells =3D <1>;
> +		clocks =3D <&acm IMX_ADMA_ACM_SAI4_MCLK_SEL>,
> +			 <&audio_ipg_clk>;
> +		clock-indices =3D <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
> +		clock-output-names =3D "sai4_lpcg_mclk",
> +				     "sai4_lpcg_ipg_clk";
> +		power-domains =3D <&pd IMX_SC_R_SAI_4>;
> +	};
> +
> +	sai5_lpcg: clock-controller@59c30000 {
> +		compatible =3D "fsl,imx8qxp-lpcg";
> +		reg =3D <0x59c30000 0x10000>;
> +		#clock-cells =3D <1>;
> +		clocks =3D <&acm IMX_ADMA_ACM_SAI5_MCLK_SEL>,
> +			 <&audio_ipg_clk>;
> +		clock-indices =3D <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
> +		clock-output-names =3D "sai5_lpcg_mclk",
> +				     "sai5_lpcg_ipg_clk";
> +		power-domains =3D <&pd IMX_SC_R_SAI_5>;
> +	};
> +
> +	amix_lpcg: clock-controller@59c40000 {
> +		compatible =3D "fsl,imx8qxp-lpcg";
> +		reg =3D <0x59c40000 0x10000>;
> +		#clock-cells =3D <1>;
> +		clocks =3D <&audio_ipg_clk>;
> +		clock-indices =3D <IMX_LPCG_CLK_0>;
> +		clock-output-names =3D "amix_lpcg_ipg_clk";
> +		power-domains =3D <&pd IMX_SC_R_AMIX>;
> +	};
> +
> +	mqs0_lpcg: clock-controller@59c50000 {
> +		compatible =3D "fsl,imx8qxp-lpcg";
> +		reg =3D <0x59c50000 0x10000>;
> +		#clock-cells =3D <1>;
> +		clocks =3D <&acm IMX_ADMA_ACM_MQS_TX_CLK_SEL>,
> +			 <&audio_ipg_clk>;
> +		clock-indices =3D <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
> +		clock-output-names =3D "mqs0_lpcg_mclk",
> +				     "mqs0_lpcg_ipg_clk";
> +		power-domains =3D <&pd IMX_SC_R_MQS_0>;
> +	};
>  };
>=20
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



