Return-Path: <linux-kernel+bounces-47602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B977845011
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DD4D1C22A08
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 04:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218573B798;
	Thu,  1 Feb 2024 04:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="VnYHnXB7"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F161EF15;
	Thu,  1 Feb 2024 04:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706760797; cv=none; b=rpdPFobUkA6FUbgk6XZkndy4ooEGSGxJHmrNoUmeevhD5h5dFw9u5XjXrKpUx4OEFu0P6knxBxJQLGb5Moo+RW7Jacl+n1Bk/sOXpvaagKhxpWykkOIaZvab8iAieYluE0Ikev+vXEV9qV/unmL2B39kDNwVBKQ9t8BIqoJmAhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706760797; c=relaxed/simple;
	bh=F2kcp4Jq/U1EECyAYwhr2QCumeZdHsqowqgrveLVsag=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hQlW2GrFocT3Tq9h7AKx7lYSPTswbuLOrhJ4wJsSFTLHN5BzT5rRwkHdIzWumg+IbCMBITEasc+0H2WcoizcmKYwqqRD9FvaPUppUinTTjfE0neGCGS4nxT/TTGMxWu027ldo9zAAVi79Gcs+gU6CRGnfxJE7q+HGcV8aCkPslY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=VnYHnXB7; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp14-2-76-194.adl-apt-pir-bras31.tpg.internode.on.net [14.2.76.194])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id C628C200EF;
	Thu,  1 Feb 2024 12:13:12 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1706760793;
	bh=JrTUckIWEWBP1tWhndI3yPaxzsWNgqHzto5OnfAby40=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VnYHnXB7uAj3wQA79fcO77DWSSdw0fTW3EkFGRIm4Z3HNHQDRPK7S266+R7Ncx874
	 7dE3N4BLoaqBXwwx6/TzBcSHvSUmMBewIibuKlUnw3Tzc2r/EDHPSUnnWBdq81YEZ5
	 zLfvD08uHjXnHcoSbNnOxZHV8bAYg/nkl6lAXb+pOBzbX0XkczXggm3JQGCyXG6eD+
	 /fI2H8eUfZZh4FARE7qXYWc4+tEb+quObdrn5P38F5k7DiNdAcQFvt/o+dPj7aUxA4
	 WaAC23GE840kyrJv84NefL34u3D6pxVWbtngnVEx6D/J4LoPq0aFxUiGs1BH8pfHuW
	 G+tJIRD9s3sgw==
Message-ID: <3050b9cb85cc2d308ada602794fd2ba09014334f.camel@codeconstruct.com.au>
Subject: Re: [PATCH v5 02/21] ARM: dts: aspeed: yosemite4: Enable adc15
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Joel Stanley <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Thu, 01 Feb 2024 14:43:12 +1030
In-Reply-To: <20240131084134.328307-3-Delphine_CC_Chiu@wiwynn.com>
References: <20240131084134.328307-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240131084134.328307-3-Delphine_CC_Chiu@wiwynn.com>
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
> Enable Yosemite 4 adc15 config

This should have a description. What's motivating the change? Why make
it? What are we monitoring with ADC15? Why wasn't it necessary
previously?

The expectations on commit messages are outlined here:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Doc=
umentation/process/submitting-patches.rst?h=3Dv6.7#n45

Andrew

>=20
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b=
/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index dac58d3ea63c..6846aab893ad 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -51,7 +51,7 @@ iio-hwmon {
>  		compatible =3D "iio-hwmon";
>  		io-channels =3D <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
>  				<&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
> -				<&adc1 0>, <&adc1 1>;
> +				<&adc1 0>, <&adc1 1>, <&adc1 7>;
>  	};
>  };
> =20
> @@ -920,10 +920,10 @@ &pinctrl_adc4_default &pinctrl_adc5_default
>  &adc1 {
>  	ref_voltage =3D <2500>;
>  	status =3D "okay";
> -	pinctrl-0 =3D <&pinctrl_adc8_default &pinctrl_adc9_default>;
> +	pinctrl-0 =3D <&pinctrl_adc8_default &pinctrl_adc9_default
> +	    &pinctrl_adc15_default>;
>  };
> =20
> -
>  &ehci0 {
>  	status =3D "okay";
>  };


