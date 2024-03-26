Return-Path: <linux-kernel+bounces-119062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0365688C389
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9780B1F3B056
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A8A75814;
	Tue, 26 Mar 2024 13:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="tgB4ALv+"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6098E7175F;
	Tue, 26 Mar 2024 13:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711460075; cv=none; b=IZ5pnSwBRPoA5seBDm1zO3z3WyeHvie5vEBFJ7jwFncvEmyFqalh+MaJ8UMCnFfQjzLNT0dthZRQFrk6VLr1hv9NZt9/K5c+GNJpodT/rs8BJLd+6bWr9OLwL7xcifN+iMoRspC1i21iC+1VMOU5lhf1VRzdNTdOOwy4bKaGBGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711460075; c=relaxed/simple;
	bh=C09MDaDhCo5/cwICaB1cD+3IlLSyH394RN6EST48y2k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rpIiXq7DFuffe8VFkYI78kwXPqDaDqdCOBkOW+sfX/iaR/7+i8Ud/2igI7ZMuXUjyPXsMEEuxp49Wby8PzBILY8hKel40Rzp1GBe3gfZEYyAwpeJwrDfm06Ys5xhEiFBc5vtSUyGTSAGvWCGA8l28wi6eG9XJCuZTMderet7Hx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=tgB4ALv+; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id A4C3D87F64;
	Tue, 26 Mar 2024 14:34:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711460071;
	bh=TdmERBCHi/8gKslCCrNCorIXxZyxmrn/AoD5wJSNB4U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tgB4ALv+ajiXCzJ3BUsA6Wf8RWG62Tx13jTecW9THXPUA7URfTAKXUf4ldL+SJH+e
	 TarYKYMfqG2WxeQkomKmX06SzeQumNQGN+PAKdPjtfjbLqbhhuf8UZEWxpR/L2GbOD
	 c3Ko8Rgv21fburbwXQybeW4Yuh7uB+Ou3jPJ5/FWjPsCIhqsnzsRvusQIED+m2Xs/V
	 Yk1xprl5Oh7OCuH0VFN5mdw6cODZ0KVSPLPsr/Vc6skuVrn7NaUkIRNHVBeU2NinHL
	 te6DdKoWvJjr1XDYg2hbFNAZRluhvedskdDuMz2Ajag75UVZQdCVSIE0AU1UacCsBj
	 um8u5KLpNMVIA==
Date: Tue, 26 Mar 2024 14:34:24 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@ew.tq-group.com, Michael Krummsdorf
 <michael.krummsdorf@tq-group.com>
Subject: Re: [PATCH] net: dsa: mv88e6xxx: fix usable ports on 88e6020
Message-ID: <20240326143424.3368d9b1@wsk>
In-Reply-To: <20240326123655.40666-1-matthias.schiffer@ew.tq-group.com>
References: <20240326123655.40666-1-matthias.schiffer@ew.tq-group.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NP2qDeJCkPvX5.p498HS=_l";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/NP2qDeJCkPvX5.p498HS=_l
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Matthias,

> From: Michael Krummsdorf <michael.krummsdorf@tq-group.com>
>=20
> The switch has 4 ports with 2 internal PHYs, but ports are numbered up
> to 6, with ports 0, 1, 5 and 6 being usable.
>=20
> Fixes: 71d94a432a15 ("net: dsa: mv88e6xxx: add support for MV88E6020
> switch") Signed-off-by: Michael Krummsdorf
> <michael.krummsdorf@tq-group.com> Signed-off-by: Matthias Schiffer
> <matthias.schiffer@ew.tq-group.com> ---
>=20
> I was unfortunately too busy to notice the issue when the patch this
> Fixes was resubmitted in my name. It would have been better to change
> my From into a Based-on-patch-by or similar when modifying it

The "discussion" about this work was lasting at least a few months with
several iterations and changing the design decisions ...

> - and
> the final version obviously wasn't even tested on an 88E6020...


Can you share on which kernel version have you tested the patch that
you claim that testing was omitted?


>=20
> Best regards,
> Matthias
>=20
>=20
>  drivers/net/dsa/mv88e6xxx/chip.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/dsa/mv88e6xxx/chip.c
> b/drivers/net/dsa/mv88e6xxx/chip.c index 9ed1821184ece..c95787cb90867
> 100644 --- a/drivers/net/dsa/mv88e6xxx/chip.c
> +++ b/drivers/net/dsa/mv88e6xxx/chip.c
> @@ -5503,8 +5503,12 @@ static const struct mv88e6xxx_info
> mv88e6xxx_table[] =3D { .family =3D MV88E6XXX_FAMILY_6250,
>  		.name =3D "Marvell 88E6020",
>  		.num_databases =3D 64,
> -		.num_ports =3D 4,
> +		/* Ports 2-4 are not routed to pins
> +		 * =3D> usable ports 0, 1, 5, 6
> +		 */
> +		.num_ports =3D 7,
>  		.num_internal_phys =3D 2,
> +		.invalid_port_mask =3D BIT(2) | BIT(3) | BIT(4),
>  		.max_vid =3D 4095,
>  		.port_base_addr =3D 0x8,
>  		.phy_base_addr =3D 0x0,




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/NP2qDeJCkPvX5.p498HS=_l
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmYCzuAACgkQAR8vZIA0
zr0WZQf/TS8tiLOb/uxni7yXlc91NzpTBzJttjl0eCjVQXLAAM91ACAh31rDNN9V
SpzRqygxu7tCrijEtp4mdNk1M2Q0Yv6dJ+nzDXQwcBfCoXZ8aoW15gO0Dl82Ndso
Xe1zfzC42AUucu4MIP/gJSYt6zCcUxX2qhoQ/QD8HMHPabR52XviVmIRu+8DswaK
gu7DLLKGOUZdY3bczYlo+yp+M1Lr+6lAJLuBoERP/xOXZ1pjhluYtvsFFJcvzxzk
EGU27rFF/vo8qfjaOHQ2gXQT3/IvTEMebT7lVLP71bs71Gnm1/R2uwKhDr2SWpbh
v8biXDw0AFh1iAm0ecFoOCmu1mSOCQ==
=mBsF
-----END PGP SIGNATURE-----

--Sig_/NP2qDeJCkPvX5.p498HS=_l--

