Return-Path: <linux-kernel+bounces-36105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 573CC839BB0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CFFA1F25D0D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E504EB44;
	Tue, 23 Jan 2024 22:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="zPC3wvSj"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6964EB34;
	Tue, 23 Jan 2024 22:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706047303; cv=none; b=d9xu5YBXap02fsrOJ7iOIxT/ZuzbGkGTXT4B0IqmTl4KskoKMTJDKwnUlBnr6doqAUMOH1809hMKaphIQD6EWoK8Fy66jEj3DC7AMYLomcRbDNhH8Pi9FmuydG3c29rN/ZvzS17mB+IFFdGYnhPGJGnkSB5G2lM5fSFyB8wRKT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706047303; c=relaxed/simple;
	bh=5lpUIhK3eSpspj99MI2TxolMrSCilk2rgng+Fd5SQcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOcnqHUovho/JVarieEU9v4ryz7NYh5fQ4UhH2yQiaSMDboYRqe1w1pi1uRAegaZhcG4VNR+0vWtuBBCK4pc4cCo62URRh+E1Y4FITcmDPZAatzkFu1Ntv7JUbB8JrckGPbcgVmsRqEgvDK7inRah0apgbPBrcgdyiVAQ3IcFB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=zPC3wvSj; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1706047291; bh=5lpUIhK3eSpspj99MI2TxolMrSCilk2rgng+Fd5SQcE=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=zPC3wvSj0b1CRtVEOCTGIwOEl2tJYgdsRJDn4vErMv+XOEtsf5Acja3CB+wmTI/xk
	 X2vUgAjI4PPoIPGanxMF0Uk49hTkTX1jS/PLY2wWwpKYV8/BF2cWgHpuyM62zPIiCE
	 3jaV38aNNCgrzWJGWuwfDUHNBUQA7QxxwWVabsr0=
Date: Tue, 23 Jan 2024 23:01:30 +0100
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Alain Volmat <alain.volmat@foss.st.com>, Pavel Machek <pavel@ucw.cz>, 
	Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: Re: [PATCH] arm64: dts: sun50i-a64-pinephone: Add front/back cameras
Message-ID: <rkx4iuuudkk7iaaudmr3ccwpatps7kz2qyjalcfzp4ongmbaby@rcosajd6c746>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Andrey Skvortsov <andrej.skvortzov@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Alain Volmat <alain.volmat@foss.st.com>, Pavel Machek <pavel@ucw.cz>, 
	Arnaud Ferraris <arnaud.ferraris@collabora.com>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20240123214729.2852346-1-andrej.skvortzov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240123214729.2852346-1-andrej.skvortzov@gmail.com>

Hi Andrey,

On Wed, Jan 24, 2024 at 12:47:29AM +0300, Andrey Skvortsov wrote:
> From: Ondřej Jirman <megi@xff.cz>
> 
> Pinephone has OV5640 back camera and GC2145 front camera. Add support
> for both.

The upstream driver doesn't support multiple endpoints per port. See:

https://elixir.bootlin.com/linux/v6.8-rc1/source/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml#L43

Only one endpoint is allowed/supported. Looking throught LKML, I don't
see the support for multiple parallel interface endpoints being added
recently...

So this patch will not work, and will cause DTS validation errors.

Kind regards,
	o.

> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> ---
>  .../dts/allwinner/sun50i-a64-pinephone.dtsi   | 91 +++++++++++++++++++
>  1 file changed, 91 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> index 87847116ab6d..4104a136ff75 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> @@ -36,6 +36,15 @@ chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> +	i2c_csi: i2c-csi {
> +		compatible = "i2c-gpio";
> +		sda-gpios = <&pio 4 13 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>; /* PE13 */
> +		scl-gpios = <&pio 4 12 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>; /* PE12 */
> +		i2c-gpio,delay-us = <3>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};
> +
>  	leds {
>  		compatible = "gpio-leds";
>  
> @@ -124,6 +133,36 @@ &cpu3 {
>  	cpu-supply = <&reg_dcdc2>;
>  };
>  
> +&csi {
> +	pinctrl-0 = <&csi_pins>, <&csi_mclk_pin>;
> +	status = "okay";
> +
> +	port {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		csi_ov5640_ep: endpoint@0 {
> +			reg = <0>;
> +			remote-endpoint = <&ov5640_ep>;
> +			bus-width = <8>;
> +			hsync-active = <1>; /* Active high */
> +			vsync-active = <0>; /* Active low */
> +			data-active = <1>;  /* Active high */
> +			pclk-sample = <1>;  /* Rising */
> +		};
> +
> +		csi_gc2145_ep: endpoint@1 {
> +			reg = <1>;
> +			remote-endpoint = <&gc2145_ep>;
> +			bus-width = <8>;
> +			hsync-active = <1>;
> +			vsync-active = <1>;
> +			data-active = <1>;
> +			pclk-sample = <1>;
> +		};
> +	};
> +};
> +
>  &dai {
>  	status = "okay";
>  };
> @@ -158,6 +197,58 @@ &ehci1 {
>  	status = "okay";
>  };
>  
> +&i2c_csi {
> +	gc2145: front-camera@3c {
> +		compatible = "galaxycore,gc2145";
> +		reg = <0x3c>;
> +		clocks = <&ccu CLK_CSI_MCLK>;
> +		clock-names = "xclk";
> +		avdd-supply = <&reg_dldo3>;
> +		dvdd-supply = <&reg_aldo1>;
> +		iovdd-supply = <&reg_eldo3>;
> +		reset-gpios = <&pio 4 16 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>; /* PE16 */
> +		powerdown-gpios = <&pio 4 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>; /* PE17 */
> +		rotation = <270>;
> +		orientation = <0>;
> +
> +		port {
> +			gc2145_ep: endpoint {
> +				remote-endpoint = <&csi_gc2145_ep>;
> +				bus-width = <8>;
> +				hsync-active = <1>;
> +				vsync-active = <1>;
> +				data-active = <1>;
> +				pclk-sample = <1>;
> +			};
> +		};
> +	};
> +
> +	ov5640: rear-camera@4c {
> +		compatible = "ovti,ov5640";
> +		reg = <0x4c>;
> +		clocks = <&ccu CLK_CSI_MCLK>;
> +		clock-names = "xclk";
> +		AVDD-supply = <&reg_dldo3>;
> +		DOVDD-supply = <&reg_aldo1>; /* shared with AFVCC */
> +		DVDD-supply = <&reg_eldo3>;
> +		reset-gpios = <&pio 3 3 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>; /* PD3 */
> +		powerdown-gpios = <&pio 2 0 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>; /* PC0 */
> +		rotation = <90>;
> +		orientation = <1>;
> +
> +		port {
> +			ov5640_ep: endpoint {
> +				remote-endpoint = <&csi_ov5640_ep>;
> +				bus-width = <8>;
> +				hsync-active = <1>; /* Active high */
> +				vsync-active = <0>; /* Active low */
> +				data-active = <1>;  /* Active high */
> +				pclk-sample = <1>;  /* Rising */
> +			};
> +		};
> +	};
> +};
> +
>  &i2c0 {
>  	status = "okay";
>  
> -- 
> 2.43.0
> 

