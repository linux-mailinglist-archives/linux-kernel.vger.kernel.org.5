Return-Path: <linux-kernel+bounces-129925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF924897217
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0FA51C27D45
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CAD1494D0;
	Wed,  3 Apr 2024 14:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNRfkTta"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36EB1494AE;
	Wed,  3 Apr 2024 14:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712153633; cv=none; b=oAH4AgxeY3Gcb/QvK+lpDq4duU36q6JJHBoPRydv5QVJExnzOa3r5P2Ig5Xtq+mKojt9kx0tKxacAANum/ENaFGoT6dOoL1SuZU8E03Al+4fYEJB1QDsFnd2HkraTlgIhB0nlaODWKL+/uu7P3+OzkYJwEkOj0aRFjsfdBmb4TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712153633; c=relaxed/simple;
	bh=tR+X7v8fot2nLBblbKMojOdNz6gzNW5K6H6mYWruWOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=moz78PgVX767UQ1Yzmu4YpIvz+foMas1nIIzcRmR4Toj4InzVWwnDmrVV+UOccikjB0BUz967h+wBi6CpLYAPNF4xZgWYL3g/Aqom2p5UhVFPv7vAJnE7HzqEx7FF0IPmiuN0C179YAt2BgJ53QrUGN8kqVLnyBWcLVExsc2QKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNRfkTta; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67ED7C433F1;
	Wed,  3 Apr 2024 14:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712153633;
	bh=tR+X7v8fot2nLBblbKMojOdNz6gzNW5K6H6mYWruWOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JNRfkTtaWyKFhIqjnNC9icrsyjULqagS3JSLZjSpQdh2pcmb85BQK0C1s7KAdIAH6
	 TkLMdhPqhHE0krKTwzw0GWVfp0HBpk3F4u87cUJ3+a9x5d53gIuwYG9nbdRMb2nHH5
	 UXRGQNiGYaEi1hQ2iDvXmr1OrqhTlE1uu2+cbPFWFwFGrrZm9Q+mTt6YfQvwhYW3Bw
	 tYG/NKrEvykRp117Lh1I7zfSVguhg06sLc3dAIFSGjHr1F/TBsXUCiprLAYhJjsuPV
	 C4gJxD4UOCmnvGtgWdvIUPuoS6xewkANPd6AHiDrOnzyDFdbLSoprP2PwiE7EvTl7p
	 6ldTFKiZsqrhQ==
Date: Wed, 3 Apr 2024 15:13:48 +0100
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: (subset) [PATCH v2 0/9] spi: pxa2xx: Drop linux/spi/pxa2xx_spi.h
Message-ID: <0af775e1-f5f7-4ad4-b336-78834a9e0342@sirena.org.uk>
References: <20240327193138.2385910-1-andriy.shevchenko@linux.intel.com>
 <171167575036.187521.17547262230962160149.b4-ty@kernel.org>
 <Zg04cWhT_Dl6AUik@smile.fi.intel.com>
 <b7ac20d0-ca45-4e65-92ff-ddf84da6645a@sirena.org.uk>
 <Zg1cAHEkhIf2vpwJ@smile.fi.intel.com>
 <Zg1clCuOwkCNzSgy@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ixvz+Gexv+kCda8n"
Content-Disposition: inline
In-Reply-To: <Zg1clCuOwkCNzSgy@smile.fi.intel.com>
X-Cookie: Knowledge is power.


--ixvz+Gexv+kCda8n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 03, 2024 at 04:41:40PM +0300, Andy Shevchenko wrote:
> On Wed, Apr 03, 2024 at 04:39:13PM +0300, Andy Shevchenko wrote:
> > On Wed, Apr 03, 2024 at 02:29:38PM +0100, Mark Brown wrote:

> > > All the concerns I have with swnodes just being a more complex and less
> > > maintainable way of doing things still stand, I'm not clear that this is
> > > making anything better.

> > As I explained before it's not less maintainable than device tree sources.
> > The only difference is that we don't have validation tool for in-kernel
> > tables. And I don't see why we need that. The data describes the platforms
> > and in the very same way may come to the driver from elsewhere.
> > How would you validate that? It the same as we trust firmware (boot loader)
> > or not. If we don't than how should we do at all?

I don't think we should do this at all, all I see from these changes is
effort in reviewing them - as far as I can tell they are a solution in
search of a problem.  DT has some support for validation of the
formatting of the data supplied by the board and offers the potential
for distributing the board description separately to the kernel.

> > Can you point out what the exact aspect is most significant from C language
> > perspective that we miss after conversion? Type checking? Something else?

You're changing the code from supplying data from the board description
via a simple C structure where the compiler offers at least some
validation and where we can just supply directly usable values to an
abstract data structure that's still encoded in C but has less
validation and requires a bunch of code to parse at runtime.  Platform
data is unsurprisingly a good solution to the problem of supplying
platform data.

> Also note, after hiding the data structures from that file we open
> the door for the much bigger cleanup, and I have patches already precooked
> (need a bit of time to test, though).

Perhaps those will motivate a change, as things stand I've not seen what
you're proposing to do here.

--ixvz+Gexv+kCda8n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYNZBwACgkQJNaLcl1U
h9A1wgf+LxurOvs9sheuqJ+hJix5cnVJKZp9jwrJKoikmYGAOneGoknFhg9IKMJW
Olm9K2MQni4UCNgeZNijrzQCnq3YcBtxgblO47r7uVKGurUA5MibG2oEvjeyzfHH
fUfYZtvjrQsPhx0j73S1gM+jvCC1jgxYDWls8CmnVvUbpA4j69+QTaD8R3rfz2IS
9Fd9gDa1ak/DQk56CaXCMCb64Qy2LqVYKrrMgGqpDe8ZuTAEwfnY4r9wGqX2UIxv
5pW+90wfAeK5yPTGzeMe8yRq6nTcygaQwDr1eKqi+nt6jWp3wzD5ZGnOG0TMDfJp
zzWkP3GCeUdRff7nEK7QyuMftJTMVQ==
=Wbjd
-----END PGP SIGNATURE-----

--ixvz+Gexv+kCda8n--

