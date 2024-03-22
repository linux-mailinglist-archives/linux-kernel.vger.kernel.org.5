Return-Path: <linux-kernel+bounces-111246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3A38869A5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 860E6284A00
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288CE22301;
	Fri, 22 Mar 2024 09:48:11 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9BA20DD2;
	Fri, 22 Mar 2024 09:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711100890; cv=none; b=dZtBu/UrnDVV0nIorNTNGhcJ1cjxvMZjyvND0xnrI8cwicMXNIwph0TpsOi9AUkRYIaWdbwqUQ+91IjxavVWdGEll6iO2JoOEr+t0hvlcYAkLwC1o0BcMhyxkujPFVozRwV5lBUxZ9K3XZ+9MhY5Q/rLFUUJzixPOKsFvmWahLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711100890; c=relaxed/simple;
	bh=2kVDVxxJdqbZMo6eDgfjCj//KQGmWtrlqjbPrUGw0N4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4IgAX9agxSS4mzX+/pwHcFwUsVK5/FsdaSaui8Svcy6UhfJHUCFwznEqWrw3PIeS7rPkTiQ2kodjg2PgHsXmEYkDKTngAMui8sXhVnuKq2raaO9SJgG2csEcgmcIcmkP3itX3JvDIUce1tIH658qlKkd2rTahl8kkejN+76Xbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 0DBB31C0071; Fri, 22 Mar 2024 10:48:06 +0100 (CET)
Date: Fri, 22 Mar 2024 10:48:05 +0100
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
Message-ID: <Zf1T1Q9q+0TA9ppm@duo.ucw.cz>
References: <20240313164640.616049-1-sashal@kernel.org>
 <ZfrngHBf1hbHohFa@duo.ucw.cz>
 <21fce6d1-fadb-4175-9539-73d4cbdad452@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYtsip7F0Rs5kQGH"
Content-Disposition: inline
In-Reply-To: <21fce6d1-fadb-4175-9539-73d4cbdad452@denx.de>


--zYtsip7F0Rs5kQGH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Marek Vasut (1):
> > >    regmap: Add bulk read/write callbacks into regmap_config
> >=20
> > This one quite intrusive for the stable. Plus, at least "regmap: Add
> > missing map->bus check" is marked as fixing this one.
>=20
> If there is no very good reason to include that regmap patch in stable
> backports, I would skip it, it is a feature patch. Does any backport depe=
nd
> on it ?

Well, yes and no.

Series of max310x patches depends on it:

!!a just a preparation; buggy, whole series for fixing this |ef8537927 285e=
76 o: 5.10| serial: max
310x: use regmap methods for SPI batch operations

=2E..

!! whole series to fix corruption, which did not exist in 5.10 in the first=
 place |57871c388 3f42b1 o: 5.10| serial: max310x: fix IO data corruption i=
n batched
operations

But according to the 3f42b1, the bug did not exist in 5.10 in the
first place, so we got buggy 285e76 backported, and then fixes up-to
3f42b1 applied to fix it up.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--zYtsip7F0Rs5kQGH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZf1T1QAKCRAw5/Bqldv6
8md1AJ0Z080h7OVqg22ALLSQhiuuMCreegCaA1IFX7NikRxv+jNKbSagAeib5Lo=
=o6Eb
-----END PGP SIGNATURE-----

--zYtsip7F0Rs5kQGH--

