Return-Path: <linux-kernel+bounces-67362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAB3856A6E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A03111C227E8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA5213699F;
	Thu, 15 Feb 2024 17:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bou2quAK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A2B136660;
	Thu, 15 Feb 2024 17:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708016589; cv=none; b=EekP/gC7NXHjwGhGFhLtqp6m7DHiM7rooG4RbvcEB3QmwLTZsLcK1YHjzwDBuBdWtvcl6q8fuq5AVQyxxZP2q7q2du6zMmaKGAMhe4/Sj0s9bCr+LUHhCbS5QgekmYHTrYCZOdngYUIuk1QJRb292yawawlRNoXnUI35IkW5OvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708016589; c=relaxed/simple;
	bh=VjV8BcdelqThJ3MbQmqnK86uf/IxokI/jkq4gMntqq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTTEVInqJitYGOB4Pu41khhWoCudwDIGADqeGf2iC6UFOOz3PT9L4T3NHPKSmha7B9FhlcjIySIb+uewQZHo7OEffbnpgCAzHpmPURiPsPur/xJaWGvPZVpT2QHxv+W4mJSOtMeRVcy6Jq42f4Gb3Na7+pW6R5wNCfpoDXnLokA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bou2quAK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D91C433C7;
	Thu, 15 Feb 2024 17:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708016588;
	bh=VjV8BcdelqThJ3MbQmqnK86uf/IxokI/jkq4gMntqq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bou2quAKZgYkJwONG/1O7OaZ2gzBTNRXUgEgrqNg19OgXv1QWeq4K8wb7T4tjiONZ
	 wf8g4XtT6G0fbmWM8ieic3rfmXs0fjVaFRq6qjA65f7oCJ7VAsuVrHAJFpQwRP/TPd
	 smxs4kTbm9ehT1yAS7VCT5goKXpXzdS1SJnPRMdJ5DL9ca/pUO2hhEGSxVXI7QY+S5
	 vyJz6v+qtb4HWWr++vC2m6eYRpzwyuJyKm6yMjV1xT5bm31hKDRBhj50FGUdtKAy73
	 FvImMWTegnm1GcWXtSOtWW9xGQl/U8oWhwmQIE6c6dbVw8pf8pSWYD8ispkB2pNYey
	 UO5tcDqIQ5lGg==
Date: Thu, 15 Feb 2024 17:03:04 +0000
From: Conor Dooley <conor@kernel.org>
To: Mihai Sain <mihai.sain@microchip.com>
Cc: claudiu.beznea@tuxon.dev, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	andre.przywara@arm.com, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	cristian.birsan@microchip.com
Subject: Re: [PATCH v3 2/3] ARM: dts: microchip: sama7g5: Add flexcom 10 node
Message-ID: <20240215-lustily-flick-69cb48b123c3@spud>
References: <20240215091524.14732-1-mihai.sain@microchip.com>
 <20240215091524.14732-3-mihai.sain@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zfv+/8Ldmdc7cdaf"
Content-Disposition: inline
In-Reply-To: <20240215091524.14732-3-mihai.sain@microchip.com>


--zfv+/8Ldmdc7cdaf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 11:15:23AM +0200, Mihai Sain wrote:
> Add flexcom 10 node for usage on the SAMA7G54 Curiosity board.
>=20
> Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
> ---
>  arch/arm/boot/dts/microchip/sama7g5.dtsi | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/microchip/sama7g5.dtsi b/arch/arm/boot/dts=
/microchip/sama7g5.dtsi
> index 269e0a3ca269..c030b318985a 100644
> --- a/arch/arm/boot/dts/microchip/sama7g5.dtsi
> +++ b/arch/arm/boot/dts/microchip/sama7g5.dtsi
> @@ -958,6 +958,30 @@ i2c9: i2c@600 {
>  			};
>  		};
> =20
> +		flx10: flexcom@e2820000 {
> +			compatible =3D "atmel,sama5d2-flexcom";

My comment here was ignored:
https://lore.kernel.org/all/20240214-robe-pregnancy-a1b056c9fe14@spud/

> +			reg =3D <0xe2820000 0x200>;
> +			clocks =3D <&pmc PMC_TYPE_PERIPHERAL 48>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +			ranges =3D <0x0 0xe2820000 0x800>;
> +			status =3D "disabled";
> +
> +			i2c10: i2c@600 {
> +				compatible =3D "microchip,sama7g5-i2c", "microchip,sam9x60-i2c";
> +				reg =3D <0x600 0x200>;
> +				interrupts =3D <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells =3D <1>;
> +				#size-cells =3D <0>;
> +				clocks =3D <&pmc PMC_TYPE_PERIPHERAL 48>;
> +				atmel,fifo-size =3D <32>;
> +				dmas =3D <&dma0 AT91_XDMAC_DT_PERID(26)>,
> +					<&dma0 AT91_XDMAC_DT_PERID(25)>;
> +				dma-names =3D "tx", "rx";
> +				status =3D "disabled";
> +			};
> +		};
> +
>  		flx11: flexcom@e2824000 {
>  			compatible =3D "atmel,sama5d2-flexcom";
>  			reg =3D <0xe2824000 0x200>;
> --=20
> 2.43.0
>=20

--zfv+/8Ldmdc7cdaf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZc5DxwAKCRB4tDGHoIJi
0vJsAQDeQhIb3G2vqcVcBI18bJC0ZUioeFGxbNSWOAUjN7G2mwD/XaLf8/ElSyxG
SZ8uAxcymPu/A6opdb1qEBlCIoZjkQg=
=gg+J
-----END PGP SIGNATURE-----

--zfv+/8Ldmdc7cdaf--

