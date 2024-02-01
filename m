Return-Path: <linux-kernel+bounces-47592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 351C3844FE6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 04:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 592C41C22E37
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 03:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94A13B194;
	Thu,  1 Feb 2024 03:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="GPVoJeUL"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0123A8FE;
	Thu,  1 Feb 2024 03:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706759200; cv=none; b=VlXRSeZGn17jaHpTM9MxX7C4r6uMNwduMISAEiBYCcDb0ZM3W4iT1mB5XjNR7KKCTXmXHcwZnAy4vpcCixihuwAAZ9slQTaymhAi64Kqea73XvKQ5IQxBnJV01RUeb5D/lUqgnHn7RaOFT52gUzQlFPpY/wRxoVC+3lM0XdXTMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706759200; c=relaxed/simple;
	bh=Z5KGSsJTG8Me3n3I9GJaS2SJpQ0zSGDT/19vVzh0uyY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rKCZ2h8zz0qMIknxqT5zeNsWdUgSYiP+ZqzXUiEokavnpvF4C/DbgPJlQN9Y8KF0g6rp3A3y5P5M7XWVlPhWWePEMEWJ9xOLNG3YfHihtsVOiXdIJ5ZwHqLkE3j2QFW2E7OW7ndVbXObQJ/WUsIuPi8ehVIylDrlNK/fMdZ73sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=GPVoJeUL; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp14-2-76-194.adl-apt-pir-bras31.tpg.internode.on.net [14.2.76.194])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 5952A2017A;
	Thu,  1 Feb 2024 11:46:26 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1706759189;
	bh=oRKHvzM8KbCi8vf71Z3F6Qqi7mjIhPHJpavjxrfKHeA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GPVoJeULG4YDFqW01YBscBR06UWwJZxUYnELBL3ZrWmoDI4oPmFM7QZEy/5AMpeu6
	 ZU4x/8ukcRJsj6uQd0xJYw7REuHUEkoqyggvwWx6PAO6oE/S9KWd8+gmdqtRtdnd0W
	 fszXI7V3Yaz4A70HA2gqHoe3HAeP6eU+RHdA/iOKMT8mSQg3rYDsUmBf6YKIpTFldi
	 kP7P89Jlbt2I3qDXi3xNv4jeRz78XJBvfE8Zn78OKlFpHDIW1HolO/qxVcz8Ye5WPG
	 80CdtUgKW2rKzDeZU7JCJHg5mrx9y1Hs1jDI4e84T8X/+qw3bKcEHnVdqfjZOrShbd
	 BOdwQNFb7zV3w==
Message-ID: <ff1df8af596c907e969d9011ce2f42ef96974d37.camel@codeconstruct.com.au>
Subject: Re: [PATCH v5 01/21] ARM: dts: aspeed: yosemite4: Revise i2c-mux
 devices
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Joel Stanley <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Thu, 01 Feb 2024 14:16:24 +1030
In-Reply-To: <20240131084134.328307-2-Delphine_CC_Chiu@wiwynn.com>
References: <20240131084134.328307-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240131084134.328307-2-Delphine_CC_Chiu@wiwynn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Delphine,

On Wed, 2024-01-31 at 16:41 +0800, Delphine CC Chiu wrote:
> Revise Yosemite 4 devicetree for devices behind i2c-mux
> - Add gpio and eeprom behind i2c-mux
> - Remove redundant idle-state setting for i2c-mux

Generally if you find yourself listing things the patch does in the
commit message it's an indicator you should split the patch up.

It looks like there's a lot of stuff to be fixed, but it doesn't need
to all be fixed in the one commit (as 01/21 suggests I guess). The
devicetree is already inaccurate, it's okay if a subset of the
inaccuracies survive for another patch or so.

Otherwise, if they must be changed together, it would be good to have a
description of *why*. Broadly, the commit message should explain *why*
the change is need regardless, not discuss *what* the patch changes
(that's evident from the patch itself).

>=20
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 381 ++++++++++++++++--
>  1 file changed, 347 insertions(+), 34 deletions(-)
>=20
> =20
> -	i2c-mux@71 {
> -		compatible =3D "nxp,pca9846";
> +	i2c-mux@74 {
> +		compatible =3D "nxp,pca9546";

Aside from splitting the patch on adding more devices and removing the
redundant idle-state settings, things like this should probably be
separate too.

Why was the address changed? Was it always wrong? Or has there been a
new revision of the board? A separate commit with some explanation here
would be useful.

>  		#address-cells =3D <1>;
>  		#size-cells =3D <0>;
> -
> -		idle-state =3D <0>;
>  		i2c-mux-idle-disconnect;
> -		reg =3D <0x71>;
> +		reg =3D <0x74>;
> =20
> -		i2c@0 {
> +		imux30: i2c@0 {
>  			#address-cells =3D <1>;
>  			#size-cells =3D <0>;
>  			reg =3D <0>;
> @@ -450,26 +726,26 @@ i2c@0 {
>  			adc@1f {
>  				compatible =3D "ti,adc128d818";
>  				reg =3D <0x1f>;
> -				ti,mode =3D /bits/ 8 <2>;
> +				ti,mode =3D /bits/ 8 <1>;

This isn't discussed anywhere. There should probably be a separate
change for anything adc128d818-related that explains what's going on
here.

>  			};
> =20
>  			pwm@20{
> -				compatible =3D "max31790";
> +				compatible =3D "maxim,max31790";
> +				pwm-as-tach =3D <4 5>;
>  				reg =3D <0x20>;
> -				#address-cells =3D <1>;
> -				#size-cells =3D <0>;

This also isn't discussed anywhere. There should probably be a separate
change for anything max31790-related that explains what's going on
here.

>  			};
> =20
>  			gpio@22{
>  				compatible =3D "ti,tca6424";
>  				reg =3D <0x22>;
> +				gpio-controller;
> +				#gpio-cells =3D <2>;

Also not discussed. Separate change for anything tca6424-related that
explains what's going on here.

>  			};
> =20
> -			pwm@23{
> -				compatible =3D "max31790";
> -				reg =3D <0x23>;
> -				#address-cells =3D <1>;
> -				#size-cells =3D <0>;
> +			pwm@2f{
> +				compatible =3D "maxim,max31790";
> +				pwm-as-tach =3D <4 5>;
> +				reg =3D <0x2f>;
>  			};

Should go in the max31790-related patch.

> =20
>  			adc@33 {
> @@ -492,34 +768,34 @@ gpio@61 {
>  			};
>  		};
> =20
> -		i2c@1 {
> +		imux31: i2c@1 {
>  			#address-cells =3D <1>;
>  			#size-cells =3D <0>;
> -			reg =3D <0>;
> +			reg =3D <1>;
> =20
>  			adc@1f {
>  				compatible =3D "ti,adc128d818";
>  				reg =3D <0x1f>;
> -				ti,mode =3D /bits/ 8 <2>;
> +				ti,mode =3D /bits/ 8 <1>;

Should go in the adc128d818 patch

>  			};
> =20
>  			pwm@20{
> -				compatible =3D "max31790";
> +				compatible =3D "maxim,max31790";
> +				pwm-as-tach =3D <4 5>;
>  				reg =3D <0x20>;
> -				#address-cells =3D <1>;
> -				#size-cells =3D <0>;
>  			};

Should go in the max31790 patch

> =20
>  			gpio@22{
>  				compatible =3D "ti,tca6424";
>  				reg =3D <0x22>;
> +				gpio-controller;
> +				#gpio-cells =3D <2>;

Should go in the tca6424 patch

>  			};
> =20
> -			pwm@23{
> -				compatible =3D "max31790";
> -				reg =3D <0x23>;
> -				#address-cells =3D <1>;
> -				#size-cells =3D <0>;
> +			pwm@2f{
> +				compatible =3D "maxim,max31790";
> +				pwm-as-tach =3D <4 5>;
> +				reg =3D <0x2f>;

Should go in the max31790 patch

Andrew

