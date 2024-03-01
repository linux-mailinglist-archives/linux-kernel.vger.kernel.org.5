Return-Path: <linux-kernel+bounces-88129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF24986DDB2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A424FB27795
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9AA6A034;
	Fri,  1 Mar 2024 08:58:29 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DF36A026
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 08:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709283509; cv=none; b=J3koSZYdSe0CNtNd3j8nSW623OttTx3FgH+T85rI5nti6FJJ/sz8NG3cz+BEmBuGUMmTXJcm/ZjhgWoqkiRAteRZjmnvYShaa4FtUxuO1BpI54pLlUe83mxEnGmJfTKsfxpLS1cTXs7sNCLeqt6GhIHOfT6k/fnnaCpoKk0pows=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709283509; c=relaxed/simple;
	bh=Y2ooKxwu0DvEAlAO3yUTV8/LjvCmLJjEEzzi6omP6EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbuzXiGAESp0MLhqcFt7RpVJq3GplcRaQ0V5ZDtvVgW9nIbCEzgKVoFpAH7VhYmeSPWNjzvXzL1CyO4dnB7LMCV7UVVcAgvjlfUfoer9th1lxie8Cz/ibLrnpbHgq+Zwl+dy6VbDvz7UcHyJkFDTvxQja8H29J2RiuISxiMFbro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1rfyif-0003jY-UI; Fri, 01 Mar 2024 09:58:17 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1rfyie-003kKQ-Tg; Fri, 01 Mar 2024 09:58:16 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1rfyie-00F28a-2f;
	Fri, 01 Mar 2024 09:58:16 +0100
Date: Fri, 1 Mar 2024 09:58:16 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Adam Ford <aford173@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
	aford@beaconembedded.com, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 2/2] arm64: dts: imx8mp-beacon: Enable LVDS-1
Message-ID: <20240301085816.bam4ph43w7tikhea@pengutronix.de>
References: <20240229233556.116944-1-aford173@gmail.com>
 <20240229233556.116944-2-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229233556.116944-2-aford173@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Adam,

On 24-02-29, Adam Ford wrote:
> Beacon has an LVDS display that can connect to one of the
> LVDS ports on the baseboard.  The display requires a 30MHz
> clock to display properly, and the LDB needs to run at 7x that.
> With the audio CODEC now moved to the AUDIO_PLL1, the AUDIO_PLL2
> is now available to source the LDB at 210MHz and the DISP_PIX2.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
> index 1f827ef38e36..731ee2667060 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
> @@ -19,6 +19,26 @@ aliases {
>  		ethernet1 = &fec;
>  	};
>  
> +	backlight: backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm2 0 100000 0>;
> +		power-supply = <&reg_lcd1_reset>;
> +		status = "okay";

status is not required here.

> +
> +		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
> +				     10 11 12 13 14 15 16 17 18 19
> +				     20 21 22 23 24 25 26 27 28 29
> +				     30 31 32 33 34 35 36 37 38 39
> +				     40 41 42 43 44 45 46 47 48 49
> +				     50 51 52 53 54 55 56 57 58 59
> +				     60 61 62 63 64 65 66 67 68 69
> +				     70 71 72 73 74 75 76 77 78 79
> +				     80 81 82 83 84 85 86 87 88 89
> +				     90 91 92 93 94 95 96 97 98 99
> +				    100>;

Are you aware of: 'num-interpolated-steps' to avoid such arrays?

> +		default-brightness-level = <80>;
> +	};
> +
>  	chosen {
>  		stdout-path = &uart2;
>  	};
> @@ -135,6 +155,38 @@ led-3 {
>  		};
>  	};
>  
> +	lvds-1 {
> +		compatible = "panel-lvds";
> +		power-supply = <&reg_lcd1>;
> +		width-mm = <223>;
> +		height-mm = <125>;
> +		backlight = <&backlight>;
> +		data-mapping = "vesa-24";
> +
> +		panel-timing {
> +			/* 800x480@60Hz */
> +			clock-frequency = <30000000>;
> +			hactive = <800>;
> +			vactive = <480>;
> +			hsync-len = <48>;
> +			hfront-porch = <40>;
> +			hback-porch = <40>;
> +			vfront-porch = <13>;
> +			vback-porch = <29>;
> +			vsync-len = <1>;
> +			hsync-active = <1>;
> +			vsync-active = <3>;
> +			de-active = <1>;
> +			pixelclk-active = <0>;
> +		};

I would like to have a proper panel-simple.c entry but that's just my
POV of adding panels.

> +
> +		port {
> +			panel1_in: endpoint {
> +				remote-endpoint = <&ldb_lvds_ch1>;
> +			};
> +		};
> +	};
> +
>  	reg_audio: regulator-wm8962 {
>  		compatible = "regulator-fixed";
>  		regulator-name = "3v3_aud";
> @@ -144,6 +196,25 @@ reg_audio: regulator-wm8962 {
>  		enable-active-high;
>  	};
>  
> +	reg_lcd1_reset: regulator-lcd1-reset {
> +		compatible = "regulator-fixed";
> +		regulator-name = "LVDS-1 reset";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&pca6416_3 13 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		vin-supply = <&reg_lcd1>;
> +	};

This reset "regulator" seems more like a workaround, why don't you use
the reset-gpios property from "panel-lvds"?

Regards,
  Marco

> +
> +	reg_lcd1: regulator-lcd1 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "lvds-1 power";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&pca6416_3 14 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
>  	reg_usdhc2_vmmc: regulator-usdhc2 {
>  		compatible = "regulator-fixed";
>  		regulator-name = "VSD_3V3";
> @@ -457,6 +528,38 @@ &lcdif1 {
>  	status = "okay";
>  };
>  
> +&lcdif2 {
> +	status = "okay";
> +};
> +
> +&lvds_bridge {
> +	assigned-clocks = <&clk IMX8MP_CLK_MEDIA_LDB>, <&clk IMX8MP_AUDIO_PLL2_OUT>;
> +	assigned-clock-parents = <&clk IMX8MP_AUDIO_PLL2_OUT>;
> +	assigned-clock-rates = <210000000>, <210000000>;
> +	status = "okay";
> +
> +	ports {
> +		port@2 {
> +			ldb_lvds_ch1: endpoint {
> +				remote-endpoint = <&panel1_in>;
> +			};
> +		};
> +	};
> +};
> +
> +&media_blk_ctrl {
> +	assigned-clocks = <&clk IMX8MP_CLK_MEDIA_AXI>,
> +			  <&clk IMX8MP_CLK_MEDIA_APB>,
> +			  <&clk IMX8MP_CLK_MEDIA_DISP1_PIX>,
> +			  <&clk IMX8MP_CLK_MEDIA_DISP2_PIX>,
> +			  <&clk IMX8MP_VIDEO_PLL1>;
> +	assigned-clock-parents = <&clk IMX8MP_SYS_PLL2_1000M>,
> +				 <&clk IMX8MP_SYS_PLL1_800M>,
> +				 <&clk IMX8MP_VIDEO_PLL1_OUT>,
> +				 <&clk IMX8MP_AUDIO_PLL2_OUT>;
> +	assigned-clock-rates = <500000000>, <200000000>, <0>, <0>, <1039500000>;
> +};
> +
>  &micfil {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_pdm>;
> @@ -496,6 +599,12 @@ &pcie_phy {
>  	status = "okay";
>  };
>  
> +&pwm2 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pwm2>;
> +};
> +
>  &sai3 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_sai3>;
> @@ -596,6 +705,13 @@ &usdhc2 {
>  };
>  
>  &iomuxc {
> +
> +	pinctrl_pwm2: pwm2grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_GPIO1_IO09__PWM2_OUT	0x116
> +		>;
> +	};
> +
>  	pinctrl_ecspi2: ecspi2grp {
>  		fsl,pins = <
>  			MX8MP_IOMUXC_ECSPI2_SCLK__ECSPI2_SCLK	0x82
> -- 
> 2.43.0
> 
> 
> 

