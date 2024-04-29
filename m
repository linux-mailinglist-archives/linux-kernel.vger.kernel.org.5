Return-Path: <linux-kernel+bounces-162609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C80E08B5E02
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04BE91C211E1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2291B82D66;
	Mon, 29 Apr 2024 15:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcUmaELw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6706B81745;
	Mon, 29 Apr 2024 15:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714405674; cv=none; b=jSTjRSzsQWREzlwcR/ieaWlK6VxW+/5PWXyQPGTtbIwB1IvRm8Aafprxt3CHvbiFvLY8RT/rk0mujOCQsSx2c2S5lcOJ1i7p3AjonQy6dFqE2LBHrN89R48S0OwVJ2VDHOjo/5FINaYabTtzw56ubSlqjbGTiDTdO8KDSir0A9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714405674; c=relaxed/simple;
	bh=MXEUogA99lTzY+rAVdsNJFMUbYG/L9I1Xzm+BQCRy3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OE8EkhjdqbuJEnNATkmwK/z7L58iLZ95+4Z3yyKIesTmhn/UtpK9daMDttmwpwGUDa7v3hm3nqJgELwRDQabRDGkWJ0tseas59Aa7W5dwVLKhMmqOL0yu3dKJGcYOufcH4H3d88IISLiVweQ3vX8eqKx6HstvjaVdaQrGedD+K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcUmaELw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5135C113CD;
	Mon, 29 Apr 2024 15:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714405674;
	bh=MXEUogA99lTzY+rAVdsNJFMUbYG/L9I1Xzm+BQCRy3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kcUmaELwtBnIWmSY3ozAgMoCaxxzNDMTn2KC5r/IuRVD3B7+azkCqWzbAe2+FQPho
	 IGs6gKfAQvcMXN6EnTb4IMoYNqk69GGluSe+D/jG31e2bVQFymhIO5YBOoN6H2qyGa
	 ZhP2cuTEV6BMNzBs77lEzCYUHKPEWqJ3cE30VnW46VGiH7KMEMef9Q630NNAAcqq8m
	 +Q6rA6B5MqVLXE9tU0Ka7tuognfY6XOp1LcnwtcX0R/cgzks20lrsF9avU1wjowW+D
	 8cMjQtUJwIzHjsXze61szxUxUJCuyb5bBcTum469sduiQ1rFO2c8KEaPTvAVkPR9NV
	 unTYglmB72GdA==
Date: Tue, 30 Apr 2024 00:47:52 +0900
From: Mark Brown <broonie@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Kyle Swenson <kyle.swenson@est.tech>,
	Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: PoE complex usage of regulator API
Message-ID: <Zi_BKFa4Sk3IAFFU@finisterre.sirena.org.uk>
References: <20240426124253.56fd0933@kmaincent-XPS-13-7390>
 <57a79abd-722c-4907-b0e7-2396392ae675@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z0k5BVdQYkZbQzID"
Content-Disposition: inline
In-Reply-To: <57a79abd-722c-4907-b0e7-2396392ae675@lunn.ch>
X-Cookie: lisp, v.:


--z0k5BVdQYkZbQzID
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 27, 2024 at 12:41:19AM +0200, Andrew Lunn wrote:

> I'm assuming this is mostly about book keeping? When a regulator is
> created, we want to say is can deliver up to X Kilowatts. We then want
> to allocate power to ports. So there needs to be a call asking it to
> allocate part of X to a consumer, which could fail if there is not
> sufficient power budget left. And there needs to be a call to release
> such an allocation.

The current limits for regulators are generally imposed in hardware as a
safety measure, this also happens for example with USB where there's
regulators in the PHYs.  Whatever is providing the power is very likely
to have reasonable headroom for robustness.

> We are probably not so much interested in what the actual current
> power draw is, assuming there is no wish to over provision?

One of the goals is to protect the system in the case that something
malfunctions and tries to draw more current than can be sustained.  A
system that is overprovisioned might choose to allow excessive draw,
especially transiently to cover bootsrapping issues, though there's
tradeoffs with system protection vs interoperability with poor quality
implementations there.

--z0k5BVdQYkZbQzID
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYvwScACgkQJNaLcl1U
h9BE5wf/eGMbGuMBrgTE/BBGw7ZPtzshbhPpItvoGiNej1Aa8AeY6iPc6OJy3g27
Ara8ZgQ0qWxv1hkOrgzlgNEq/BxkG5pGcNIRp68dJWM31xI2YkGAH4FiI0Yo74eD
3fnt5adFdZzVVA/jHguYIzzdXp5AK32YEfZ4mbdaPO+gLM4VakFWiRVOU/P3jQoa
asM2b9FLIFjMKtzlHYefDMUIC28WMbkVcpq9YJUy2Sr4goqJFObKFzIZhe2B7rmA
kGEBGEh3c/vjcYGepZ2ivGD5yInwRK5njcTGgGI8kZ3YnyQOIX63Y0Ep+RaawToJ
D3uv6/3i/nbUBM1TetHgPEjcafc+WQ==
=I9We
-----END PGP SIGNATURE-----

--z0k5BVdQYkZbQzID--

