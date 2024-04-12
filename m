Return-Path: <linux-kernel+bounces-143261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 903018A3668
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C220E1C230A9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD7C1509AE;
	Fri, 12 Apr 2024 19:31:31 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40D814F9F8;
	Fri, 12 Apr 2024 19:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712950291; cv=none; b=SBmYxq2tFthnL9jUJr4hevVoMJocyGCHzspmAR8ze5mo3FOvoUImjwVZjHHM0H1PCZtPA5Bid74GTk4deq6t71E2BSK+mwpXjA4cjxeEFMsSuKiVmpa3SDV8v2k1eW1qzAeNvy+qXF+xL1oeaCx6gFcMSnCASDpue6zESd4FB5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712950291; c=relaxed/simple;
	bh=/7JOGKPDijPf6hlQZMNt3Hssd3C3Xl7bYy7LG3aUxtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHr+iXQJFh1/D9CDn7yxQsef5mKWnIQrL/xtZihxNhR6ntsf7flAkSiKtOxRKNfpkvuq5OrXA/plTEWeZZPBWRAhsvdYabiNS/QudnxEf+eWfGE1xxyRqH6mVo5d+SHd803DJHczTHvc4nw85FCWrbNk7uyFF3uEFuH66U09kaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 490E61C007B; Fri, 12 Apr 2024 21:31:21 +0200 (CEST)
Date: Fri, 12 Apr 2024 21:31:20 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: elfring@users.sourceforge.net, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 00/83] 6.1.86-rc1 review
Message-ID: <ZhmMCDt1YAQ70LJN@duo.ucw.cz>
References: <20240411095412.671665933@linuxfoundation.org>
 <ZhfQjMUvOI1QXtDN@duo.ucw.cz>
 <2024041136-demystify-destitute-cfd5@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u5Yd1Mv3Z/bHx9NP"
Content-Disposition: inline
In-Reply-To: <2024041136-demystify-destitute-cfd5@gregkh>


--u5Yd1Mv3Z/bHx9NP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > This is the start of the stable review cycle for the 6.1.86 release.
> > > There are 83 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, plea=
se
> > > let me know.
> >=20
> > > Markus Elfring <elfring@users.sourceforge.net>
> > >     batman-adv: Improve exception handling in batadv_throw_uevent()
> > >=20
> > > Markus Elfring <elfring@users.sourceforge.net>
> > >     batman-adv: Return directly after a failed batadv_dat_select_cand=
idates() in batadv_dat_forward_data()
> > >
> >=20
> > Questionable cleanups, untested, do not fix any bug, please drop.
>=20
> good point, now dropped.

Thank you!

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--u5Yd1Mv3Z/bHx9NP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZhmMCAAKCRAw5/Bqldv6
8uE2AJ90+MD8Mm3WbfoYNMAA2k9OM9S+swCeI78xA1ZnwcpnV3Vo5+K8AtUR6v0=
=Cjlr
-----END PGP SIGNATURE-----

--u5Yd1Mv3Z/bHx9NP--

