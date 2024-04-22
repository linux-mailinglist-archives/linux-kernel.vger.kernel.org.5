Return-Path: <linux-kernel+bounces-152704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 499DC8AC325
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 05:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5ACC1F2114D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 03:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EB8FBE8;
	Mon, 22 Apr 2024 03:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="D2XIfPDH"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F873234;
	Mon, 22 Apr 2024 03:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713757371; cv=none; b=i6SMsQopLKlu7FoEvkEWHjBPPiAjp2EOPRmyCfXPHaeYTs1I+Pa/aHVEIcHn/QqZ8A5V5lLhaZZZhfcCG3lru43hGbJ0Cil79HK4eEP7bkWeHSny0W6TZoe7iFuJLjEMOV6al+/g/pF4cs5FGmqEQhpd4IZBglVLtTlZ/vDAzHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713757371; c=relaxed/simple;
	bh=qhLCnwMZ88gA2hTnXSuFQMUmXB+Nrz0Fpo+79M1h3K8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOcZRCrJzY4tuA1j+LvKY8G+kIQ33nfQSrYUaePK89qZhxMKrmcb/q/84yL3+a0g7RF0eHzJ3UWK01f2z1HksTzR8gamNg5ikK3bs8JH2eiFPoCkjAnPjH/pS+0S5wwKKxx9iD7FOLBjFP+WCN1gTASDVgZ9qyXd9sGBCXBqWhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=D2XIfPDH; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=fdtfV44v236cnntRxp4mWjiFvJnQMsU2XRd04B3OZtU=;
	b=D2XIfPDHcemjQdSHqEIZ+OhSCgcL+pxj06woy6S/42b6GchvQIcsraC7H4vDtX
	hOfphOEb5cVSpJiLC98tm9iBLB+jCT9QBQfdxpAFpnFd0m7rsYH8ekclAoESVd0x
	23OlQTKNP8VxzfXGeOfzOrZM+XF4CbiSL1BWs49WuJXE4=
Received: from dragon (unknown [223.68.79.243])
	by smtp1 (Coremail) with SMTP id ClUQrADXXw+c3CVmanorAw--.29283S3;
	Mon, 22 Apr 2024 11:42:22 +0800 (CST)
Date: Mon, 22 Apr 2024 11:42:20 +0800
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
Subject: Re: [PATCH 3/3] arm64: dts: imx8dxl-evk: add audio nodes
Message-ID: <ZiXcnMtk5f0RSrHc@dragon>
References: <20240402-b4-dts_dxl_audio-v1-0-d26d25b84a08@nxp.com>
 <20240402-b4-dts_dxl_audio-v1-3-d26d25b84a08@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402-b4-dts_dxl_audio-v1-3-d26d25b84a08@nxp.com>
X-CM-TRANSID:ClUQrADXXw+c3CVmanorAw--.29283S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3Gw4kWr4xWFW8XF4DWF45ZFb_yoW3tw17p3
	s2ka1fKr4IyasFy34rt34DGrnY9wn5KF4j9a43Kry0yF9IqrZrXr1jkwnxCFWDtrs8Xw1q
	qF98ZrW8KrsIqaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j55rcUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDR-IZVszXbcLNAAAsC

On Tue, Apr 02, 2024 at 05:02:30PM -0400, Frank Li wrote:
> Add audio nodes for imx8dxl-evk boards.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 234 ++++++++++++++++++++++++++
>  1 file changed, 234 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
> index 2123d431e0613..ba4cdc3534362 100644
> --- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
> @@ -125,6 +125,81 @@ mii_select: regulator-4 {
>  		enable-active-high;
>  		regulator-always-on;
>  	};
> +
> +	bt_sco_codec: bt_sco_codec {

Hyphen is recommended for node name.

> +		#sound-dai-cells = <1>;
> +		compatible = "linux,bt-sco";

We usually have 'compatible' go first.

> +	};
> +
> +	sound-bt-sco {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,name = "bt-sco-audio";
> +		simple-audio-card,format = "dsp_a";
> +		simple-audio-card,bitclock-inversion;
> +		simple-audio-card,frame-master = <&btcpu>;
> +		simple-audio-card,bitclock-master = <&btcpu>;
> +
> +		btcpu: simple-audio-card,cpu {
> +			sound-dai = <&sai0>;
> +			dai-tdm-slot-num = <2>;
> +			dai-tdm-slot-width = <16>;
> +		};
> +
> +		simple-audio-card,codec {
> +			sound-dai = <&bt_sco_codec 1>;
> +		};
> +	};
> +
> +	sound-wm8960-1 {
> +		compatible = "fsl,imx7d-evk-wm8960", "fsl,imx-audio-wm8960";
> +		model = "wm8960-audio";
> +		audio-cpu = <&sai1>;
> +		audio-codec = <&wm8960_1>;
> +		audio-asrc = <&asrc0>;
> +		audio-routing =
> +			"Headphone Jack", "HP_L",
> +			"Headphone Jack", "HP_R",
> +			"Ext Spk", "SPK_LP",
> +			"Ext Spk", "SPK_LN",
> +			"Ext Spk", "SPK_RP",
> +			"Ext Spk", "SPK_RN",
> +			"LINPUT1", "Mic Jack",
> +			"Mic Jack", "MICB";

Nit: can we do this?

		audio-routing = "Headphone Jack", "HP_L",
				"Headphone Jack", "HP_R",
			        ...

> +	};
> +
> +	sound-wm8960-2 {
> +		compatible = "fsl,imx7d-evk-wm8960", "fsl,imx-audio-wm8960";
> +		model = "wm8960-audio-2";
> +		audio-cpu = <&sai2>;
> +		audio-codec = <&wm8960_2>;
> +		capture-only;
> +		audio-routing =
> +			"Headphone Jack", "HP_L",
> +			"Headphone Jack", "HP_R",
> +			"Ext Spk", "SPK_LP",
> +			"Ext Spk", "SPK_LN",
> +			"Ext Spk", "SPK_RP",
> +			"Ext Spk", "SPK_RN",
> +			"LINPUT1", "Mic Jack",
> +			"Mic Jack", "MICB";
> +	};
> +
> +	sound-wm8960-3 {
> +		compatible = "fsl,imx7d-evk-wm8960", "fsl,imx-audio-wm8960";
> +		model = "wm8960-audio-3";
> +		audio-cpu = <&sai3>;
> +		audio-codec = <&wm8960_3>;
> +		capture-only;
> +		audio-routing =
> +			"Headphone Jack", "HP_L",
> +			"Headphone Jack", "HP_R",
> +			"Ext Spk", "SPK_LP",
> +			"Ext Spk", "SPK_LN",
> +			"Ext Spk", "SPK_RP",
> +			"Ext Spk", "SPK_RN",
> +			"LINPUT1", "Mic Jack",
> +			"Mic Jack", "MICB";
> +	};
>  };
>  
>  &adc0 {
> @@ -132,6 +207,11 @@ &adc0 {
>  	status = "okay";
>  };
>  
> +&asrc0 {
> +	fsl,asrc-rate  = <48000>;

One space around =

> +	status = "okay";
> +};
> +
>  &eqos {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_eqos>;
> @@ -259,6 +339,78 @@ max7322: gpio@68 {
>  			};
>  		};
>  
> +		i2c@1 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x1>;
> +
> +			wm8960_1: wm8960@1a {
> +				compatible = "wlf,wm8960";
> +				reg = <0x1a>;
> +				clocks = <&mclkout1_lpcg IMX_LPCG_CLK_0>;
> +				clock-names = "mclk";
> +				wlf,shared-lrclk;
> +				wlf,hp-cfg = <2 2 3>;
> +				wlf,gpio-cfg = <1 3>;
> +				assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
> +						  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
> +						  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
> +						  <&mclkout1_lpcg IMX_LPCG_CLK_0>;
> +				assigned-clock-rates = <786432000>,
> +						       <49152000>,
> +						       <12288000>,
> +						       <12288000>;
> +			};
> +		};
> +
> +		i2c@2 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x2>;
> +
> +			wm8960_2: wm8960@1a {
> +				compatible = "wlf,wm8960";
> +				reg = <0x1a>;
> +				clocks = <&mclkout1_lpcg IMX_LPCG_CLK_0>;
> +				clock-names = "mclk";
> +				wlf,shared-lrclk;
> +				wlf,hp-cfg = <2 2 3>;
> +				wlf,gpio-cfg = <1 3>;
> +				assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
> +						  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
> +						  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
> +						  <&mclkout1_lpcg IMX_LPCG_CLK_0>;
> +				assigned-clock-rates = <786432000>,
> +						       <49152000>,
> +						       <12288000>,
> +						       <12288000>;
> +			};
> +		};
> +
> +		i2c@3 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x3>;
> +
> +			wm8960_3: wm8960@1a {

audio-codec for node name.

> +				compatible = "wlf,wm8960";
> +				reg = <0x1a>;
> +				clocks = <&mclkout1_lpcg IMX_LPCG_CLK_0>;
> +				clock-names = "mclk";
> +				wlf,shared-lrclk;
> +				wlf,hp-cfg = <2 2 3>;
> +				wlf,gpio-cfg = <1 3>;
> +				assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
> +						  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
> +						  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
> +						  <&mclkout1_lpcg IMX_LPCG_CLK_0>;
> +				assigned-clock-rates = <786432000>,
> +						       <49152000>,
> +						       <12288000>,
> +						       <12288000>;
> +			};
> +		};
> +
>  		i2c@4 {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> @@ -362,6 +514,53 @@ &lsio_gpio5 {
>  	status = "okay";
>  };
>  
> +&sai0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sai0>;
> +	#sound-dai-cells = <0>;
> +	assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
> +			<&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
> +			<&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
> +			<&sai0_lpcg IMX_LPCG_CLK_0>;

	assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
			  ...

> +	assigned-clock-rates = <786432000>, <49152000>, <12288000>, <49152000>;
> +	status = "okay";
> +};
> +
> +&sai1 {
> +	assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
> +			<&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
> +			<&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
> +			<&sai1_lpcg IMX_LPCG_CLK_0>;
> +	assigned-clock-rates = <786432000>, <49152000>, <12288000>, <49152000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sai1>;
> +	status = "okay";
> +};
> +
> +&sai2 {
> +	assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
> +			<&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
> +			<&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
> +			<&sai2_lpcg IMX_LPCG_CLK_0>;
> +	assigned-clock-rates = <786432000>, <49152000>, <12288000>, <49152000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sai2>;
> +	fsl,sai-asynchronous;
> +	status = "okay";
> +};
> +
> +&sai3 {
> +	assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
> +			<&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
> +			<&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
> +			<&sai3_lpcg IMX_LPCG_CLK_0>;
> +	assigned-clock-rates = <786432000>, <49152000>, <12288000>, <49152000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sai3>;
> +	fsl,sai-asynchronous;
> +	status = "okay";
> +};
> +
>  &thermal_zones {
>  	pmic-thermal {
>  		polling-delay-passive = <250>;
> @@ -595,6 +794,41 @@ IMX8DXL_UART0_TX_ADMA_UART0_TX		0x06000020
>  		>;
>  	};
>  
> +	pinctrl_sai0: sai0grp {
> +		fsl,pins = <
> +			IMX8DXL_SPI0_CS0_ADMA_SAI0_RXD		0x06000060
> +			IMX8DXL_SPI0_CS1_ADMA_SAI0_RXC		0x06000040
> +			IMX8DXL_SPI0_SCK_ADMA_SAI0_TXC		0x06000060
> +			IMX8DXL_SPI0_SDI_ADMA_SAI0_TXD		0x06000060
> +			IMX8DXL_SPI0_SDO_ADMA_SAI0_TXFS		0x06000040
> +		>;
> +	};
> +
> +	pinctrl_sai1: sai1grp {
> +		fsl,pins = <
> +			IMX8DXL_FLEXCAN0_RX_ADMA_SAI1_TXC     0x06000040

Can the indent between pin constant and value be tabs instead of spaces?

Shawn

> +			IMX8DXL_FLEXCAN0_TX_ADMA_SAI1_TXFS    0x06000040
> +			IMX8DXL_FLEXCAN1_RX_ADMA_SAI1_TXD     0x06000060
> +			IMX8DXL_FLEXCAN1_TX_ADMA_SAI1_RXD     0x06000060
> +		>;
> +	};
> +
> +	pinctrl_sai2: sai2grp {
> +		fsl,pins = <
> +			IMX8DXL_SNVS_TAMPER_OUT3_ADMA_SAI2_RXC   0x06000040
> +			IMX8DXL_SNVS_TAMPER_IN0_ADMA_SAI2_RXFS   0x06000040
> +			IMX8DXL_SNVS_TAMPER_OUT4_ADMA_SAI2_RXD   0x06000060
> +		>;
> +	};
> +
> +	pinctrl_sai3: sai3grp {
> +		fsl,pins = <
> +			IMX8DXL_SNVS_TAMPER_IN1_ADMA_SAI3_RXC    0x06000040
> +			IMX8DXL_SNVS_TAMPER_IN3_ADMA_SAI3_RXFS   0x06000040
> +			IMX8DXL_SNVS_TAMPER_IN2_ADMA_SAI3_RXD    0x06000060
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


