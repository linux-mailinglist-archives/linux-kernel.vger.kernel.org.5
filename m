Return-Path: <linux-kernel+bounces-130134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF34289747C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 653751F23E76
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D3814B063;
	Wed,  3 Apr 2024 15:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8i07t1U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A474914A613;
	Wed,  3 Apr 2024 15:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712159405; cv=none; b=EJpdjY/tIOpBlCdx+I+YiaMtgPBwOdgMs/CzZ9V+y+B/tFMXp7UChrmDI/e/kPiTZ1iVBqzU1TZ+oEAPlOKJEt+GmwE5QZ1564FyLlsExbZuxwxWoGQARHnMtvySoeTLo78pZMdQ4eH6c3VCNULFJsjFXSWD2349qnFKPb225io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712159405; c=relaxed/simple;
	bh=BWxRrDahcyakEgkrjYxx+bwOVBn1U5//7v9wcd/ridE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEXOLibRGIV50IFC1Wjdr908kJvff4X+ziCzWLYJ7kt23/kfEVPoB88M1OrAS0PUa1DDJssXgS8TPNa6T1eJ6nlLAFCpqoPjOigQaKCxsBV/S/IvY3SygDSmX82HB7NW1umi+d+iHTzdPFFcKo6GqFYFPDj9fOQoJ3jVVs94JX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8i07t1U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A27C433C7;
	Wed,  3 Apr 2024 15:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712159405;
	bh=BWxRrDahcyakEgkrjYxx+bwOVBn1U5//7v9wcd/ridE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F8i07t1UHZui+a3olIR/mqrmGLOhSlRpBtUA0cMe5NvJLOWACdgP3hXtT7JHDG07E
	 4qCpc72mDSOLXJoLPPW3Q9/4gFQHfWokCA7o9PVGH4Y/2t8f8oBGkaPKLCiGAif/C+
	 yloVJ6TOBBA1yqRVYQXLgRhf239NusTMJdnTDlfA6bPk2MRcMopyTllUDjLDFNRCuW
	 tJkOy6xKb4evwBWSyCoeZP53oosFyplLVs5TEsjXpdqjITVOBNxSU7LZ3VZtRHgXx4
	 eM/3npWeopey58J0lhVOaSW5Gykz0n3uMGPHDHrbG//0e/T03B6NYEOoUKrIKMuNjh
	 /z2kysBinh2DA==
Date: Wed, 3 Apr 2024 16:50:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: (subset) [PATCH v2 0/9] spi: pxa2xx: Drop linux/spi/pxa2xx_spi.h
Message-ID: <48793ea5-92ca-4529-bad0-35d8c4e3f0c8@sirena.org.uk>
References: <20240327193138.2385910-1-andriy.shevchenko@linux.intel.com>
 <171167575036.187521.17547262230962160149.b4-ty@kernel.org>
 <Zg04cWhT_Dl6AUik@smile.fi.intel.com>
 <b7ac20d0-ca45-4e65-92ff-ddf84da6645a@sirena.org.uk>
 <Zg1cAHEkhIf2vpwJ@smile.fi.intel.com>
 <Zg1clCuOwkCNzSgy@smile.fi.intel.com>
 <0af775e1-f5f7-4ad4-b336-78834a9e0342@sirena.org.uk>
 <Zg1qmlX78lQGLC3B@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cPjXK7O9KNOc9UcN"
Content-Disposition: inline
In-Reply-To: <Zg1qmlX78lQGLC3B@smile.fi.intel.com>
X-Cookie: Knowledge is power.


--cPjXK7O9KNOc9UcN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 03, 2024 at 05:41:30PM +0300, Andy Shevchenko wrote:

> Linus was long time ago against board files. Yet, we have a few old
> (kinda supported) boards left in the tree. The conversion makes the
> driver be prepared for the DT conversion when it happens. From maintenance
> perspective my patch reduced the code under the maintenance, which reduces
> time spent by both contributors and maintainers on this.

> AFAIU all what you are moaning about is type checking. Okay, I got

The type checking is part of it, but it's more a general taste thing
with using swnodes like this.  You've not actually removed the board
file and it's hard to get enthusiastic about the change to the board
file that results, or to see this as a substantial step towards DT
conversion for the platform given the trivialness of the single
property here.  As a general thing I don't want to encourage people to
start randomly converting things to swnode rather than to DT.

> it, but we have a lot of other places with similar approach done,
> e.g. GPIO_LOOKUP*() tables that basically gives something unconnected to the
> driver without any platform data being involved and you seems to be fine with
> that:

> $ git log --oneline --no-merges --grep 'Mark Brown' -- arch/ | grep 'GPIO desc'

> I randomly took this 366f36e2a ("ASoC: wm1250-ev1: Convert to GPIO descriptors").

> Can you tell how it is different to my proposal?

The main difference with the GPIO lookup tables is that they are
structured data specifically for GPIOs rather than the general purpose
free for all we have with swnode.

--cPjXK7O9KNOc9UcN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYNeqgACgkQJNaLcl1U
h9DNbgf+MWwNssTaQ2FgNgITAk94TuannBgmO/VZFj7P4CgXxWu8/jM4Zns26MZ6
H+Z8pBbw/kQYWX7sPqZP1Ao1bFJx1KQdUMIv3wjkNWfF2jVNIoFUx1KjfxVlyYa8
KhY+d1Ru4cK0f5yYiuNDDycMS16nizbB2/5OMwwIgthKjs3mf7N3gU/j0juy6hLA
+dcXGxxbJ6HyqROJuXEh2ogeYrybR6tAPmrQe9QFhG67Xdr6JpNxaqb5L8VJCivh
CTPo1B8HZCeUBDytbUsfbafs2Ry6JEMAfTg7iCM8VeJkOCEjYuZ3JfJlwulO1Gh2
vfV7nxaal/5Z4bxL2czV7o0s8FZ10g==
=h/S+
-----END PGP SIGNATURE-----

--cPjXK7O9KNOc9UcN--

