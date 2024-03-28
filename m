Return-Path: <linux-kernel+bounces-122769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E3088FCFB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24CD2B25CEA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5489B7C6CA;
	Thu, 28 Mar 2024 10:28:00 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001F743AC4;
	Thu, 28 Mar 2024 10:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711621679; cv=none; b=inhvfMmaPR0NCra6fvqhIO6j3xUikllKRimK4w1HQ+M7ZyW+G7IRBIJIqVcKpnq8g6Iaw6tEDYvOXEkogihbE4NKOU3Je7SSzS0hel7znjN7q0M2ifym2J5GBwkXSJuTD+a2rJRyfyIf1zr84ny/j9/EYCmm6kiUHolJ26dBrHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711621679; c=relaxed/simple;
	bh=YdFMD05ICo4B3HtKvN5Kni+11Fpe39uVvX7nJWykwYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWaoWzIuK8vF/84zOFKEKCg5C2Is+SvHKaf7xsGF4xScbBM1Ubj5sYuXvnZDmKVtUVlIipcGtJLgeaGPR5Q/NVg8NCrN1KC1RcfPhq7GSjwE3zc926i2fBqb/ihprciqsCrzvFCgGP+8DQ+a69acTyDJlBLPpIsP0w6uAJnMpKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id B9F1C1C007E; Thu, 28 Mar 2024 11:27:55 +0100 (CET)
Date: Thu, 28 Mar 2024 11:27:55 +0100
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Michael Klein <michael@fossekall.de>,
	Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH 5.4 177/183] ARM: dts: sun8i-h2-plus-bananapi-m2-zero:
 add regulator nodes vcc-dram and vcc1v2
Message-ID: <ZgVGK6fxuLb6PREs@duo.ucw.cz>
References: <20240324234638.1355609-1-sashal@kernel.org>
 <20240324234638.1355609-178-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KIjWPteef1tgOPZm"
Content-Disposition: inline
In-Reply-To: <20240324234638.1355609-178-sashal@kernel.org>


--KIjWPteef1tgOPZm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Michael Klein <michael@fossekall.de>
>=20
> [ Upstream commit 23e85be1ec81647374055f731488cc9a7c013a5c ]
>=20
> Add regulator nodes vcc-dram and vcc1v2 to the devicetree. These
> regulators correspond to U4 and U5 in the schematics:
>=20
> http://forum.banana-pi.org/t/bpi-m2-zero-schematic-diagram-public/4111
>=20
> Signed-off-by: Michael Klein <michael@fossekall.de>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> Link: https://lore.kernel.org/r/20201130183841.136708-1-michael@fossekall=
=2Ede
> Stable-dep-of: 4a0e7f2decbf ("netfilter: nf_tables: do not compare
> internal table flags on updates")

Iti s hard to believe dts update is dependency of netfilter core
change. Please investigate and drop.

Best regards,
								Pavel

> ---
>  .../dts/sun8i-h2-plus-bananapi-m2-zero.dts    | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts b/arch/=
arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> index 4c6704e4c57ec..74d5732c412ba 100644
> --- a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> +++ b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> @@ -62,6 +62,30 @@ reg_vdd_cpux: vdd-cpux-regulator {
>  		states =3D <1100000 0>, <1300000 1>;
>  	};
> =20
> +	reg_vcc_dram: vcc-dram {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "vcc-dram";
> +		regulator-min-microvolt =3D <1500000>;
> +		regulator-max-microvolt =3D <1500000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		enable-active-high;
> +		gpio =3D <&r_pio 0 9 GPIO_ACTIVE_HIGH>; /* PL9 */
> +		vin-supply =3D <&reg_vcc5v0>;
> +	};
> +
> +	reg_vcc1v2: vcc1v2 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "vcc1v2";
> +		regulator-min-microvolt =3D <1200000>;
> +		regulator-max-microvolt =3D <1200000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		enable-active-high;
> +		gpio =3D <&r_pio 0 8 GPIO_ACTIVE_HIGH>; /* PL8 */
> +		vin-supply =3D <&reg_vcc5v0>;
> +	};
> +
>  	wifi_pwrseq: wifi_pwrseq {
>  		compatible =3D "mmc-pwrseq-simple";
>  		reset-gpios =3D <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--KIjWPteef1tgOPZm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZgVGKwAKCRAw5/Bqldv6
8jtDAJ0bCDM9bjLfGfmyeacQZp9rBEvLjwCfT3T65JCBteZupfYyxllvSSMqxE4=
=LPLr
-----END PGP SIGNATURE-----

--KIjWPteef1tgOPZm--

