Return-Path: <linux-kernel+bounces-157731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAE68B1522
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C05562889D7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481D5156C41;
	Wed, 24 Apr 2024 21:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fd8kvaDO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E29713C9DE
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 21:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713993604; cv=none; b=Xfa654/1wIb8T2V0A4mlaT4X1SI3e1L77+33XaaT7c5jKSduoCb04H4XHjL4TEYkfO65ms69WsqXR8zPp+eneBTb05vgFtdF2gQgJ7MhXvA+xON2FCQyG9RCsVP+xfv8CMvByrZolojA+skBKTns2/po75RRKZuE0K/MwdAtTQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713993604; c=relaxed/simple;
	bh=X6Q9ghuC9MoxCqz0X5W6CSwrUiieo8LutjHaTxzEVbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3GEk7C8RIkCRP3QKVjwMN9neeFJvgAY7UDGS7I5UohBGd1w2TfZtk4yf9/b3fG9WXNWPltnpFgWLOSMBkur13TWSl4s8NekrotcJHUyflTTYJcve6ktRKJWqFIffazTM/YqHCkPPVBBMAmh2y5MRUOsk1e9EndV6P8mMzDoGgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fd8kvaDO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85A1C113CD;
	Wed, 24 Apr 2024 21:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713993604;
	bh=X6Q9ghuC9MoxCqz0X5W6CSwrUiieo8LutjHaTxzEVbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fd8kvaDOeXZL5y64ttw8eQA9sONEoZWFri5CsY1hXnVWe+ukzQ8bOO55HLiBYCk2p
	 C71r+T1woIoKpvMx2Psv1DCKbo2KtIY0qayeQ957IRTCGlAuX85mVXdOcNhNodAwa5
	 nhDeAyHukDKqwe9RUMZNiarbpUnLym7XhK4c3AEYtMcS0ep+PwJzn0A+b4caZxJS4h
	 UJ2ZEKhAPsvl0fVW/RvstOJd0RaJoCRpVjzPqYr+GIy3IB56EV/b7GHi0cUvqf6YvI
	 8/0noULFpvVD7ejenEJIZQj4RmdDZyDP6q3/eLJn2aTUqIER3DB8NFpyWO9zCI3YL3
	 7FOjRmQuH+0lA==
Date: Wed, 24 Apr 2024 22:20:00 +0100
From: Conor Dooley <conor@kernel.org>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Samuel Holland <samuel.holland@sifive.com>,
	linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] cache: sifive_ccache: Auxiliary device support
Message-ID: <20240424-recolor-deviation-29a5dd4e9499@spud>
References: <20240410232211.438277-1-samuel.holland@sifive.com>
 <d738dfc0-66af-4dad-bd60-a68c900bf807@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xuJOMISUXHsgfGn1"
Content-Disposition: inline
In-Reply-To: <d738dfc0-66af-4dad-bd60-a68c900bf807@ghiti.fr>


--xuJOMISUXHsgfGn1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 10:19:18PM +0200, Alexandre Ghiti wrote:
> Hi Samuel,
>=20
> On 11/04/2024 01:22, Samuel Holland wrote:
> > As of commit c90847bcbfb6 ("cache: sifive_ccache: Partially convert to a
> > platform driver"), the cache subsystem binds a platform driver to the
> > Composable Cache's DT node. This prevents the perf subsystem from doing
> > the same for the new PMU driver[1]. To allow using both drivers at the
> > same time without conflicts or module linkage dependencies, attach the
> > PMU driver to the auxiliary device bus. While at it, prepare to use the
> > auxiliary device bus for the EDAC driver as well, which significantly
> > simplifies that driver. The actual EDAC driver conversion has to wait
> > another development cycle to avoid dependencies between git trees.
> >=20
> > [1]: https://lore.kernel.org/linux-riscv/20240216000837.1868917-3-samue=
l.holland@sifive.com/
> >=20
> >=20
> > Samuel Holland (4):
> >    cache: sifive_ccache: Silence unused variable warning
> >    cache: sifive_ccache: Use of_iomap() helper
> >    cache: sifive_ccache: Export base address for child drivers
> >    cache: sifive_ccache: Add EDAC and PMU as auxiliary devices
> >=20
> >   drivers/cache/Kconfig              |  1 +
> >   drivers/cache/sifive_ccache.c      | 94 +++++++++++++++++++++---------
> >   include/soc/sifive/sifive_ccache.h |  8 +++
> >   3 files changed, 74 insertions(+), 29 deletions(-)
> >=20
>=20
> I took a quick look and I'm not sure if the whole patchset is a fix for 6=
=2E9
> or if only patch 1 is?

Only the first patch is IMO, but it is a fix for a patch I applied so
it'll go this week via the soc tree with those auto-update fixes.

--xuJOMISUXHsgfGn1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZil3gAAKCRB4tDGHoIJi
0tEpAQDcI7yoAdCPL60ujB1LzolN4SJJmStybk3ftfXpKvZmLwD/WvBnGvK5ezjN
smI6d1HvJ3B7DEPaIjmTZJUFrQB1TA4=
=7AyF
-----END PGP SIGNATURE-----

--xuJOMISUXHsgfGn1--

