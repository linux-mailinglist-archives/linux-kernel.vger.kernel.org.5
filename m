Return-Path: <linux-kernel+bounces-47603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E87F6845014
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DA6128FC15
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 04:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761593B79F;
	Thu,  1 Feb 2024 04:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="ZbosZG1w"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79551EF15;
	Thu,  1 Feb 2024 04:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706760934; cv=none; b=HI8X0VeTHl2x1AIOL0V8ppkxvDaxpaLK0SZT3jszJrb63Otye/kN5QaiTQW2WG1/WJPlOY2KPvGEkCOmIFhh8Z9+2DtcwUKLld0gToWbpqm7tfzEZLY3qHHXIkmPRYyHQNoTa4NN6jGRl6p2kxYv4QQ/9JALrlAW6C7qllLGxec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706760934; c=relaxed/simple;
	bh=BduLXF3Tw/4+qmuhxAZqtPGOi2SgjomkGk3FgJWoAto=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L3Syxb9r5Ek+KH6ihBZly/u72vfyG6yQCtEk39gnlTM41MZOz7ThgRwir7Go6xZPSrXEkwPFIy27zBsacmOjZYXzbZNfeCZrLNgMVRONlX24l8b8lp9GRYcRaFnZZ1MbFdoQSqW6jEcqm2Nm3d7rvSfrsot4ZZ1bZb7lvG7oB1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=ZbosZG1w; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp14-2-76-194.adl-apt-pir-bras31.tpg.internode.on.net [14.2.76.194])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 38B62200EF;
	Thu,  1 Feb 2024 12:15:30 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1706760930;
	bh=OTirJc9l2KMu8EA5iqUQzEQ2+1Vua4syLCQpQMEkeGE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZbosZG1w01MmsetEdaMpaVdrkdc/ENwjMLOk1B9D1mm5xGHdlfbiKkZhjgRdYtfD7
	 OPUxb4F6L8/j1PIIvxauc+h2CyTUAXkQwe62cSzhYLDyvDxmbbBPmlEXcc7kt7e/Pk
	 7W2N3KKlafx4X+uvXy9RMud6YA8zbwxRy8g6mzB+RllV7YEgysLIlQp/IKWWCnRwSv
	 tvb35dWOn1xa30IxaZubMZcNWEJvCAb+R4zAAM5hjYOBceNhmKTEXlMesypSpjptBE
	 9l5W4O69MePg8PVNyFWA78qqJ8f11cZDBu9nRS3wDVlKJd4ZCUjWY6Tomdhm0jzwWB
	 2c5szvSF7kKWg==
Message-ID: <c14428e5b6fc863cf29606842f49895a82fa3539.camel@codeconstruct.com.au>
Subject: Re: [PATCH v5 03/21] ARM: dts: aspeed: yosemite4: Enable spi-gpio
 setting
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Joel Stanley <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Thu, 01 Feb 2024 14:45:29 +1030
In-Reply-To: <20240131084134.328307-4-Delphine_CC_Chiu@wiwynn.com>
References: <20240131084134.328307-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240131084134.328307-4-Delphine_CC_Chiu@wiwynn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-01-31 at 16:41 +0800, Delphine CC Chiu wrote:
> enable spi-gpio setting for spi flash

I suspect I know what's motivating this as a design, but can you add an
explanation to the commit message?

Again, expectations on commit messages are outlined here:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Doc=
umentation/process/submitting-patches.rst?h=3Dv6.7#n45

Andrew

>=20
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts   | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b=
/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index 6846aab893ad..ea8fd3ec0982 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -53,6 +53,24 @@ iio-hwmon {
>  				<&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
>  				<&adc1 0>, <&adc1 1>, <&adc1 7>;
>  	};
> +
> +	spi_gpio: spi-gpio {
> +		compatible =3D "spi-gpio";
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		gpio-sck =3D <&gpio0 ASPEED_GPIO(X, 3) GPIO_ACTIVE_HIGH>;
> +		gpio-mosi =3D <&gpio0 ASPEED_GPIO(X, 4) GPIO_ACTIVE_HIGH>;
> +		gpio-miso =3D <&gpio0 ASPEED_GPIO(X, 5) GPIO_ACTIVE_HIGH>;
> +		num-chipselects =3D <1>;
> +		cs-gpios =3D <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>;
> +
> +		tpmdev@0 {
> +			compatible =3D "tcg,tpm_tis-spi";
> +			spi-max-frequency =3D <33000000>;
> +			reg =3D <0>;
> +		};
> +	};
>  };
> =20
>  &uart1 {


