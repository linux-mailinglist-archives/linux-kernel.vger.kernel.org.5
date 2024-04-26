Return-Path: <linux-kernel+bounces-159400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3E78B2E26
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 02:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF5621C20C6D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF6DED8;
	Fri, 26 Apr 2024 00:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="b6a2416l"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93BB812;
	Fri, 26 Apr 2024 00:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714092710; cv=none; b=HgIfmA8pH3bTuyn6lGMWtFLyEtVVjJU5mQUhllIJKHSRv02STTtj3Y9XQVus9KY3+TWgi8wxzxLNGi69k1Eji+MSWNQbDCYcLRh6ZcnZ6yr+XSWFL+Ixaf7sM3FBeIr3wTHJdTwpxuk8xKgdJTPajihV3kemth1jtgVmuvCwE4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714092710; c=relaxed/simple;
	bh=QieyTwN068YvvfCTCYbSnLm9E5U8HCWgeL9luSKfy7w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qXrI0uOiNbx+LJPlI4Quon+cj9rqKQlCvM9zXNqDX+PZHjZZ+s3bRaoBNauZw0d3P4Y7LuFlS8T/FZjS7/2Y8h5eTRtFaqz3IqpesDqJTv1T+hugTiYaZVNgFr7PBnYFiNUFJmt3ThOY3WllEpC7oH+zUR7egMUNYuwptfsH64A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=b6a2416l; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp14-2-127-66.adl-apt-pir-bras32.tpg.internode.on.net [14.2.127.66])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 24E3520075;
	Fri, 26 Apr 2024 08:51:45 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1714092706;
	bh=NjN94PFfnv6THIE12/NBk/TDDVzgTTDfDSVQBicYRvE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=b6a2416lbz7mwL8wx+7sgO3FUkis1MId3UUgDxuD6EpdYUYxhzohbdYxqPn5+2xQR
	 WjVOC05Ss/4rHEkaDG3gpIOED+vJpUI/0EL83bN8wCWRXK9TJnI/Ybs+sSewfMlL9B
	 boHOJauKugnsic95tjgZfArNMpp/nzVIjVSKSuyxq7I3RvqrOw3B3r3T5NXmxwCsFg
	 YyzdayD7A87o3QwP2A4oDjC0nWHoEovlOdR3+cftfHxjNOk51SZseM7sdVQVSx/zB0
	 s91YIj4gKRCsYrM5SszT4SA5SAnAIs9CfTy2+UZqU2fVmnGBmM27d9GluFrRzER9Lv
	 mb5CwqvpsPtNw==
Message-ID: <f355ad1adb96cd8398c4ac81d1c72df289a2aaf0.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1 1/2] Revise mux and hardware in yosemite4 dts
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Fri, 26 Apr 2024 10:21:45 +0930
In-Reply-To: <20240425060626.2558515-2-Delphine_CC_Chiu@wiwynn.com>
References: <20240425060626.2558515-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240425060626.2558515-2-Delphine_CC_Chiu@wiwynn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-04-25 at 14:06 +0800, Delphine CC Chiu wrote:
> ARM: dts: aspeed: yosemite4:

This should be in the patch subject, not the body of the commit
message.

> Change hardware configuration, consequently modifying the mux in the dts.

Perhaps "We have a new iteration of the hardware design, so update the
devicetree to match."?

>=20
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>

Overall it feels a bit untidy updating the description of distinct
devices in the one patch.

> ---
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 78 ++++++++++++++-----
>  1 file changed, 58 insertions(+), 20 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b=
/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index 64075cc41d92..e45293762316 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -433,16 +433,14 @@ eeprom@51 {
>  		reg =3D <0x51>;
>  	};
> =20
> -	i2c-mux@71 {
> -		compatible =3D "nxp,pca9846";
> +	i2c-mux@74 {
> +		compatible =3D "nxp,pca9546";
>  		#address-cells =3D <1>;
>  		#size-cells =3D <0>;
> -
> -		idle-state =3D <0>;
>  		i2c-mux-idle-disconnect;
> -		reg =3D <0x71>;
> +		reg =3D <0x74>;
> =20
> -		i2c@0 {
> +		inux30: i2c@0{

'inux'? 'imux'?

>  			#address-cells =3D <1>;
>  			#size-cells =3D <0>;
>  			reg =3D <0>;
> @@ -450,26 +448,46 @@ i2c@0 {
>  			adc@1f {
>  				compatible =3D "ti,adc128d818";
>  				reg =3D <0x1f>;
> -				ti,mode =3D /bits/ 8 <2>;
> +				ti,mode =3D /bits/ 8 <1>;
>  			};
> =20
>  			pwm@20{
> -				compatible =3D "max31790";
> -				reg =3D <0x20>;
> +				compatible =3D "maxim,max31790";

This looks like a change motivated by binding validation or a driver
change rather than hardware design :)

>  				#address-cells =3D <1>;
>  				#size-cells =3D <0>;
> +				reg =3D <0x20>;
> +				channel@4 {
> +					reg =3D <4>;
> +					sensor-type =3D "TACH";
> +				};
> +
> +				channel@5 {
> +					reg =3D <5>;
> +					sensor-type =3D "TACH";
> +				};
>  			};
> =20
>  			gpio@22{
>  				compatible =3D "ti,tca6424";
>  				reg =3D <0x22>;
> +				gpio-controller;
> +				#gpio-cells =3D <2>;
>  			};
> =20
> -			pwm@23{
> -				compatible =3D "max31790";
> -				reg =3D <0x23>;
> +			pwm@2f{
> +				compatible =3D "maxim,max31790";

Again here

Andrew

