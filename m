Return-Path: <linux-kernel+bounces-44042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D63B1841C8C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15F471C251B3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9F651C28;
	Tue, 30 Jan 2024 07:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="af+MlsF6"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1188B4EB41
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 07:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706599594; cv=none; b=kj4qoOT8h9DZcEM6edHbjJ/HBriS7AUiAGU2RHhfyCWW/b5q3gjJ34UHiXFEN/ZV9HBdli5kGXIg3WMRIF76sdCknkQ0sTUhCArwLd9Ci3smW+u118U5lKmoGeH35XCbzdW9sJ3bX4lz4RCu6cxTZYUP0UGfn6Itm8d5CgkFYxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706599594; c=relaxed/simple;
	bh=AL6FV34dPjvcZHz+24duybYebVbbuqDvXOfaZf+qhN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cbKcRPkfzyxvFExH8LyR5+pLDwUpmgJWEYrBvRxszHAH1Ay6R3ONlPVOfzz8sHVrvtorcGdjis6FpaOxf97pjTPMainPDKHJMcc2jqwQz36p87FffvyLJDBgmZishWHlJT4VgUO5ic4xxz2LUjemvLr38t74EMWLXglQBrXthR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=af+MlsF6; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=FLIP
	VULEESde9zT/4+RC82cZNQsbAcF3o7v7R0/JN6M=; b=af+MlsF6VBWqx8TV8gkA
	94WqBw19xMlDn2vacuQsQKSeoo+XKrgHpiMMJu9nSZgaRDdIW91GPqO7Yu3d4d3r
	sy9EjQMbH2bLIvbIIlgG9ljC15qSAIi2cqZeFLESsJCVFQNPuUBwpTzZeRwenyoZ
	F64shMoBVrVg1hQ1Ld0tX2t0RL4yp27xi/5S0DfYZRXF101wDcxdXnmi3oQ3l4ev
	WHeQpvyJZFHX9guti2bd2ptjPqgHTGiZSG2RKlyfBJ9Qn37mIkLnWZxQf0UIPjL0
	1Ox3cyDbOM66fBHlZkXA9sO9NM6paGuAwsH4jwdNnnKHks2yejZX0NCGVydDdSYs
	BA==
Received: (qmail 2743201 invoked from network); 30 Jan 2024 08:26:26 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 Jan 2024 08:26:26 +0100
X-UD-Smtp-Session: l3s3148p1@lP4iriQQ9KRehhtJ
Date: Tue, 30 Jan 2024 08:26:26 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: ulf.hansson@linaro.org, takeshi.saito.xv@renesas.com,
	masaharu.hayakawa.ry@renesas.com, yoshihiro.shimoda.uh@renesas.com,
	linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v2] mmc: renesas_sdhi: Fix change point of data handling
Message-ID: <ZbikovLbujyGS1ub@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	claudiu beznea <claudiu.beznea@tuxon.dev>, ulf.hansson@linaro.org,
	takeshi.saito.xv@renesas.com, masaharu.hayakawa.ry@renesas.com,
	yoshihiro.shimoda.uh@renesas.com, linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240117110646.1317843-1-claudiu.beznea.uj@bp.renesas.com>
 <ZbeEPg1jc5qWJa5m@ninjato>
 <345bc392-cf28-479a-9453-5bc89f635759@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fLttbbrhq7mozpEJ"
Content-Disposition: inline
In-Reply-To: <345bc392-cf28-479a-9453-5bc89f635759@tuxon.dev>


--fLttbbrhq7mozpEJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

> My understanding was the other way around from this statement found in
> RZ/G3S hw manual:
>=20
> "If all of the TAP [i] is OK, the sampling clock position is selected by
> identifying the change point of data.

Yes, it is easy to misunderstand. It should add "and avoid it" or
something. I got an internal diagram which makes it more clear. I just
asked if I can share it with you.

> > I also have a chapter named like this. If you check the diagram, change
> > point is between TAP2 and 3, so the suggested TAP to use is 6 or 7. As
> > far away as possible from the change point.
>=20
> My understanding was different here as of the following hw manual stateme=
nt:
>=20
> "As the width of the input data is 1 (UI), select TAP6 or TAP7 which is
>=20
> *the median* of next TAP3 from TAP3"
>=20
> I understand from this that the median value should be considered here.

Sorry, can't follow you here. "Select TAP6 or TAP7" is clear to me. But
it doesn't really matter why it was misleading...

> > However, with some SD cards, I also see the EIO error you see. So, there
> > might be room to improve TAP selection when all TAPs are good. I need to
> > check if this is really is the same case for the SD cards in question.
>=20
> Maybe better would be to change this condition:
>=20
> 			if (cmpngu_data !=3D cmpngd_data)
> 				set_bit(i, priv->smpcmp);
>=20
> like this:
> 			if (cmpngu_data =3D=3D cmpngd_data)
> 				set_bit(i, priv->smpcmp);
>=20
> ?
>=20
> I need to check it, though.

But isn't it equal to the current code then? (Except for one thing: the
smpcmp bit is only set when there is no cmd error. I need to double
check but I think I like that.)

Happy hacking,

   Wolfram


--fLttbbrhq7mozpEJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmW4pJ4ACgkQFA3kzBSg
KbZsGg//bmCSH53sxXlojvm8+gV0rmEYP0jjngDmllk3zIc0ws5A+PBPYrfMlJw+
bkan6yt7JLqynP2l86u/9RYV9Xextt+DqV8VJYTneanh+HbK20Fxy8RjszLtYdfW
YM3z4ymLt2DBuDVZMj2DVGbYhDUIbPz4K0a/XtKf6HO/s/E5BuYSu/tpCFKgewBi
cwos3N6laSnrNzwxsllYtmHOagSC534yM6vM38gMsJV9MO0lppwUeqFsFGcQKPxi
mJ7RCD0H/05epAmGriAlWlQ0UtRmTSOOOPxt1HyWSj1r2wvlOc+MavpLbwMGAjhH
PcUC/y3Ne4yTGO3ntNWRXT24PCuV4xweEK70iS5GPKaB17OyPrWMVeVZgTUoaLa5
NNpNVceQVdcj0EfrSFIouhs8BuOVI/GDZw0TdVyuGttfU/Jh/qA8m85TyoSO77ey
F9+fmvU5s/9cCmR4kWGLH3dHG48rK4EdAI7JaTgTOXGnY1RglLcJJANwE3mbGhvA
kchzdxS+EQc3nzhAGQNau81zL2QXzXbkAIaw/A/YIi8v8I3CL7ON3J9WV9MGJtXq
p3B1SLDsVZZvJBvi8K10ApzsgpAzT3UIoxU7jOPfcxleGo1Qazo9ZXaVGeNT3ocU
vU0zMT3zo/nuSbK57KN0tkYgy8o8SgP8BBLvTwfmGUNdUPNnBSw=
=29wo
-----END PGP SIGNATURE-----

--fLttbbrhq7mozpEJ--

