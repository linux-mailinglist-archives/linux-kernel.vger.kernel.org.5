Return-Path: <linux-kernel+bounces-28935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E098304DC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B43361C23A85
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A6C1DFDC;
	Wed, 17 Jan 2024 12:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="liCjFMvr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E79BC8DE;
	Wed, 17 Jan 2024 12:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705492938; cv=none; b=lN3FqYwYIV+6Qj4TpBbGmmfqT7Q1WhO7IepWvFx0wDwbchoNYO6PDXzp1ZO1FPCwZjqeXBmMJ0z/nN3VTHN9ZjdBs2dT/3EzuvKYgNoPhlytczqk6LTtK8wb+hLK+ZcD31ge50QFYNTTAb/7ncuHITA367Hz7/gNEgCN9nLxAMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705492938; c=relaxed/simple;
	bh=z3K+aPsqDlPIXzmxaifhGH8Bam7+3IJLclsYzycqlUQ=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=FuGi3sa8ddemQS4LPGI8PyMU1eKuIFVBhxZ/utwjABHhuCzb3/W0bXjim83lRJFHprbbujYMrDTsNuOwfzX1a5otP6VQpCJcZW2c3D4vhLc2MMvGskdDWCbLG/HUiUxhu34uxnd5N/aMJzw1PIC9kyeHnKaM4zyawT3F/ClCCs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=liCjFMvr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76289C433F1;
	Wed, 17 Jan 2024 12:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705492938;
	bh=z3K+aPsqDlPIXzmxaifhGH8Bam7+3IJLclsYzycqlUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=liCjFMvrBg6LhTHHiMFBu/+VOw2WgrfjSN6iGbdwc/Y2VKCcmqLUmOsui2kwibl3I
	 v5DHNMigfBLrHQuJOFxK3rnUtIRJm7cux8lkf1PNgBklv8YkmBoU2BIVWWeMGtDyqi
	 P99kdvcuiK0juDLDc9eL+x3BZgoAwpM10zzUX8rPoWgiPjM+dzNVWu7E5wwGAByhQ9
	 FUAEW3ZF+daN2ibDEwuprafiIkBp7IWpvO3PU0m2V0AK2uyTacKGkY7xnztyg2nSkg
	 sNLqPSMeclMB7YAZJg+gSLXMV6KjeYzUHs4Eig4I8fjPiUvlUYfmyyvBpUXivO8PMR
	 wWN+7FHltptig==
Date: Wed, 17 Jan 2024 13:02:13 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Petr Vorel <pvorel@suse.cz>
Cc: linux-man@vger.kernel.org,
	Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	Matthias Gerstner <matthias.gerstner@suse.com>,
	Avinesh Kumar <akumar@suse.de>
Subject: Re: [PATCH 1/1] socket.7: Mention CAP_NET_RAW on SO_MARK
Message-ID: <ZafBxnhOSWxBRWko@debian>
References: <20240116110418.2577798-1-pvorel@suse.cz>
 <ZaadPmLFCI4rsGy_@debian>
 <20240117091452.GB2665992@pevik>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+iv5ECICgVpVqnS+"
Content-Disposition: inline
In-Reply-To: <20240117091452.GB2665992@pevik>


--+iv5ECICgVpVqnS+
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jan 2024 13:02:13 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Petr Vorel <pvorel@suse.cz>
Cc: linux-man@vger.kernel.org,
	Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	Matthias Gerstner <matthias.gerstner@suse.com>,
	Avinesh Kumar <akumar@suse.de>
Subject: Re: [PATCH 1/1] socket.7: Mention CAP_NET_RAW on SO_MARK

Hi Petr,

On Wed, Jan 17, 2024 at 10:14:52AM +0100, Petr Vorel wrote:
> Hi Alex,
>=20
> > Hi Petr,
>=20
> > On Tue, Jan 16, 2024 at 12:04:18PM +0100, Petr Vorel wrote:
> > > Added in 079925cce1d0 ("net: allow SO_MARK with CAP_NET_RAW") in v5.1=
7.
>=20
> > > Signed-off-by: Petr Vorel <pvorel@suse.cz>
>=20
> > Patch applied.  Thanks!
>=20
> Thank you! BTW I don't see this patch in git tree [1], maybe you just hav=
en't
> push yet.

That's it.  I'm first pushing them to a 'contrib' branch (similar to
Linux 'next') in my own server[1], and after one day or so I push to
master.  That buffering allows me to catch some mistakes.

[1]:  <https://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.g=
it/log/?h=3Dcontrib>

	$ git log --all --graph --oneline -10
	* 0c118822f (alx/contrib, contrib) open.2: srcfix
	* 24347d22a syscalls.2: ffix
	* 9e04cb40f mremap.2: wfix
	* 3a271d5b8 fts.3, div_t.3type: ffix
	* 527f31b9f socket.7: Mention CAP_NET_RAW on SO_MARK
	| * 71c25f15d (alx/MR, MR) man*/: ffix (MR.sed)
	|/ =20
	* d82ce270c (HEAD -> master, korg/master, alx/main, main) locale.5: tfix
	* f65154cba cpuid.4: Note which CPUs don't support CPUID and what happens
	* f98168310 sched_getcpu.3: tfix
	* 26cdb3ebb faccessat(2), utimensat(2): Document AT_EMPTY_PATH flag

I'll push in a moment to master.

Have a lovely day,
Alex

--=20
<https://www.alejandro-colomar.es/>
Looking for a remote C programming job at the moment.

--+iv5ECICgVpVqnS+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmWnwcUACgkQnowa+77/
2zIEzA/+JDGOhlEOZ0M407lzWr8dMPLdNVcbA6QdYVbMJMdstVVwNK6W3zPvs+cp
OIOa/KTcx/mp3QvSSM6eXxzTND6CU5m6p+PxGeC3A7ZStjWeBHRW53GHXHngbEir
hTi1Rl7BtzFqDyPJXIYGvOfAU3Hd13drmt/0TDXdwD+E6S5yrTA1hdmozuWDvQjY
PkISXsptUEjubpsUD6r2ZA8g2NTnO+tusMgHk5QVHM0nD1MKOrJQAmxLhsMt3xMP
gu3r00kW+/hPgltiM/HpdCVmkZWZpPvUe5DbjswJrVVHdlK0+Q1rhARU3ACTRAg+
IjJt6goupoUQVZqmhMEKwcU/SxCvLrrYvw/wqMVEQJD5Qi+F5bDGgcrFj3Z2JzgF
WFjumNyDH3Yr0P8slwckvSZkWWknS0cLQRIbvNvLQzOQodmBfOJtmDzWyVsvLZL0
J6lkL+wWWL0Hg3eFManIA1r5uzeSozYHPHU0i/LTHNlTJ6XYsQCtpJ6dmLUjQjD7
8qb2dzrMrovS/bg4Mj/yO6EmYZbERok5sFyY78wnDKZ5TQaUq0JXXcWKRKotLDct
Xzuu4hQ72xqkoaFdxrSIcCv0DepdaHiOt1WTDShzphUIGC36koE73HO64sOPBRZB
th21Pod8pGaKvyvJoTK+6SldoCSNg/nuwhRFigNkRfg1R+BE4SI=
=7ftI
-----END PGP SIGNATURE-----

--+iv5ECICgVpVqnS+--

