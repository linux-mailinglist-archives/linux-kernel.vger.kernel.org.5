Return-Path: <linux-kernel+bounces-79800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9298626EF
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 20:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05C6E1F21608
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 19:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D487F48CCC;
	Sat, 24 Feb 2024 19:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESsg6LDM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCB23F8FF;
	Sat, 24 Feb 2024 19:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708802208; cv=none; b=FS4cvmqZPD74T+wxTMvSAtTCOCXzjjRpf4ACs35BaZpo2SPNPvneV+d37tjgynnw00pqKEWBkrH9baoFfRysbeb7o8+cSqT/bE/5wC7FAK9Cgg/kqw+Ixb+rL35lJDmeoybMMUSmIeLYz4AADeEknUIa1Tzk6JIHnkEABq+vEms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708802208; c=relaxed/simple;
	bh=FHvMajZrXNMcFDw0hz/Scz0oxDv/UTNTfoJGwHFWbwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1OYjD00d2n/+GcQ8M1RQEcSYu6Oth/UboWiwrzosQgpVa6TWzZEQFkPIqpHqXcSMYcLehCjmy1+Pv9aSyWHvgcI2AEtq5QjpFw3fHXJpvsog9Vn0Z36xjM0cVtai7aMfnT1STJ/Se/dVTD+ci4hdVSJBQbhX4Pmdj2atr0ExKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESsg6LDM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D8BC433F1;
	Sat, 24 Feb 2024 19:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708802207;
	bh=FHvMajZrXNMcFDw0hz/Scz0oxDv/UTNTfoJGwHFWbwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ESsg6LDMVKC2tA8a0clcvREfQRdmbPV6OZb5iIa8QvaBXM9CEBlF9u1CrqfvaNjjc
	 iOfllxughaoxfVeUtCirmtMZVMPQ4pbsiEBXfa4bsFdS5GNRsllLBkGgNypIbx1Hmt
	 fqxsMNlgquV9RDwdax9mPiVEkW8Ctxa4vMGdBbqivC14el/kvdIO7oMNQRh5X5Nt8l
	 Uk9yYFRkSW52TpeSl2sU2NzqhIgoQKKKsphP0bnFe0IJ2/0Oq2Bfiz55yYkx7r7vjB
	 i6kqn5DO7ZNiDzpMNchhlIGdUdcm1yHdCKi58t/CK7lYCiJ3n+S54F6EfYjjMDvsXL
	 14HWjnYy1Fa9A==
Date: Sat, 24 Feb 2024 19:16:43 +0000
From: Conor Dooley <conor@kernel.org>
To: Zev Weiss <zev@bewilderbeest.net>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: aspeed: Add vendor prefixes to lm25066 compat
 strings
Message-ID: <20240224-coyness-civic-d583b863c614@spud>
References: <20240224103712.20864-2-zev@bewilderbeest.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uJA6p5mfN/szSZK4"
Content-Disposition: inline
In-Reply-To: <20240224103712.20864-2-zev@bewilderbeest.net>


--uJA6p5mfN/szSZK4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2024 at 02:37:07AM -0800, Zev Weiss wrote:
> Due to the way i2c driver matching works (falling back to the driver's
> id_table if of_match_table fails) this didn't actually cause any
> misbehavior, but let's add the vendor prefixes so things actually work
> the way they were intended to.
>=20
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>

Oh sweet, I was just about to go off and write this patch - thanks!

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-romed8hm3.dts | 4 ++--
>  arch/arm/boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dts    | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-romed8hm3.dts b/a=
rch/arm/boot/dts/aspeed/aspeed-bmc-asrock-romed8hm3.dts
> index 4554abf0c7cd..9aa2de3723b5 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-romed8hm3.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-romed8hm3.dts
> @@ -98,14 +98,14 @@ w83773g@4c {
> =20
>  	/* IPB PMIC */
>  	lm25066@40 {
> -		compatible =3D "lm25066";
> +		compatible =3D "ti,lm25066";
>  		reg =3D <0x40>;
>  		shunt-resistor-micro-ohms =3D <1000>;
>  	};
> =20
>  	/* 12VSB PMIC */
>  	lm25066@41 {
> -		compatible =3D "lm25066";
> +		compatible =3D "ti,lm25066";
>  		reg =3D <0x41>;
>  		shunt-resistor-micro-ohms =3D <10000>;
>  	};
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dts b/arch=
/arm/boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dts
> index 6600f7e9bf5e..e830fec0570f 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dts
> @@ -14,7 +14,7 @@ efuse##n {					\
> =20
>  #define EFUSE(hexaddr, num)							\
>  	efuse@##hexaddr {							\
> -		compatible =3D "lm25066";						\
> +		compatible =3D "ti,lm25066";					\
>  		reg =3D <0x##hexaddr>;						\
>  		shunt-resistor-micro-ohms =3D <675>;				\
>  		regulators {							\
> --=20
> 2.43.2
>=20

--uJA6p5mfN/szSZK4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdpAmwAKCRB4tDGHoIJi
0jbhAQC7tzouPoNHtO1cCyXVSSpZ/vASOJWjOSJwRAbbKh4SBwEAnrxhOohokD5+
Pe/1QIdCSRpY6Zoi8eqpqGy4XCcI5gw=
=yxIC
-----END PGP SIGNATURE-----

--uJA6p5mfN/szSZK4--

