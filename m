Return-Path: <linux-kernel+bounces-111550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E8F886D94
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F4D11F25457
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF8447A7A;
	Fri, 22 Mar 2024 13:35:42 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0E146421;
	Fri, 22 Mar 2024 13:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711114542; cv=none; b=EgNSSHONJn6bGQqmiU4TKOVM7vviq69ck1UA87pGh+4Aeyxwhe6GU4NgN4N0Z/V/WH+3I5p7hylyBc5pb6EzAIN0pGMWK/3DmNNXxjHoH2JmZn4CUoYFGmBkPTU/r6YwndhBDIvJlt+qiDe+mkOq9peH3OONnbm8AB9tueuVHiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711114542; c=relaxed/simple;
	bh=c1KEaCEKyhV3ITySajut5RjWMni3WEOGyLWfLOrxj7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N42DN9Lvj04hd03rTn1xknW4p2KHA9h5muMv1w10WCEMXjeWbQ7w5A+XCadU4KK586ZQgb0Ev12MWRI+sQEkXbykB6DPbTz4OQCf5tECLZcOL1iCzGBqP3vLvgAOEqrJdkv7rP1SreUix6AFAQp5y8BG1VzojrRrDf7x55+OeaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 1753C1C0083; Fri, 22 Mar 2024 14:35:37 +0100 (CET)
Date: Fri, 22 Mar 2024 14:35:36 +0100
From: Pavel Machek <pavel@denx.de>
To: Marek Vasut <marex@denx.de>
Cc: Pavel Machek <pavel@denx.de>, Sasha Levin <sashal@kernel.org>,
	broonie@kernel.org, tzimmermann@suse.de, omosnace@redhat.com,
	paul@paul-moore.com, yi.zhang@huawei.com, jack@suse.cz,
	tytso@mit.edu, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org
Subject: Re: [PATCH 5.10 00/73] 5.10.213-rc1 review
Message-ID: <Zf2JKL075FnIxXGI@duo.ucw.cz>
References: <20240313164640.616049-1-sashal@kernel.org>
 <ZfrngHBf1hbHohFa@duo.ucw.cz>
 <21fce6d1-fadb-4175-9539-73d4cbdad452@denx.de>
 <Zf1T1Q9q+0TA9ppm@duo.ucw.cz>
 <21741b02-2454-40d8-87e3-9243e44f9738@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T/jr9WbnttkFAmVu"
Content-Disposition: inline
In-Reply-To: <21741b02-2454-40d8-87e3-9243e44f9738@denx.de>


--T/jr9WbnttkFAmVu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > > Marek Vasut (1):
> > > > >     regmap: Add bulk read/write callbacks into regmap_config
> > > >=20
> > > > This one quite intrusive for the stable. Plus, at least "regmap: Add
> > > > missing map->bus check" is marked as fixing this one.
> > >=20
> > > If there is no very good reason to include that regmap patch in stable
> > > backports, I would skip it, it is a feature patch. Does any backport =
depend
> > > on it ?
> >=20
> > Well, yes and no.
> >=20
> > Series of max310x patches depends on it:
> >=20
> > !!a just a preparation; buggy, whole series for fixing this |ef8537927 =
285e76 o: 5.10| serial: max
> > 310x: use regmap methods for SPI batch operations
> >=20
> > ...
> >=20
> > !! whole series to fix corruption, which did not exist in 5.10 in the f=
irst place |57871c388 3f42b1 o: 5.10| serial: max310x: fix IO data corrupti=
on in batched
> > operations
> >=20
> > But according to the 3f42b1, the bug did not exist in 5.10 in the
> > first place, so we got buggy 285e76 backported, and then fixes up-to
> > 3f42b1 applied to fix it up.
>=20
> Then probably both max30x patches should be dropped/reverted and the regm=
ap
> bulk callbacks also dropped ?

Agreed.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--T/jr9WbnttkFAmVu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZf2JKAAKCRAw5/Bqldv6
8jp8AJ0TyVvk4h5xNqX27UutWNX2Pl+ruQCgm3cE5Cym48bxg3OQwqxQhe7VJ80=
=+ooR
-----END PGP SIGNATURE-----

--T/jr9WbnttkFAmVu--

