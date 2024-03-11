Return-Path: <linux-kernel+bounces-98883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 352E78780A2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66BF21C215E2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A591E3FB35;
	Mon, 11 Mar 2024 13:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPxDyqod"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7033EA9B;
	Mon, 11 Mar 2024 13:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710163712; cv=none; b=sgrDMKnFVzFQDW/VeOxTGPLGfNpTMJZbrmHmTYdymOQXYjLWrCbdoLceNQCZN8yCSGkVIDHqOsmYHyUmbZRrLNGPE8Hed0eKlUzCaQ9Ei/BSUXGUCPSdAuvWHytaaSWvfQNIBGEiS/TpwuO1RPf9dyAQRpSWWAce7PNhtS8Y270=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710163712; c=relaxed/simple;
	bh=AFWzF1Lhea4tuERf2x297B9VZ9r3NjTyKmU+LYLRnBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLTSajHm+vEuBzNhBIZk1M1El4cCwCrD38SaGv3ZtXsAtCSxVI+oLZwRoq8g5T6W4K227AAenWuY4rnuVtrddc8gtwX/FJMGGJA+J6bYTAvxwHkJ+lshRxUElHX+UHhX5RiOWMB7hbuICPDs4dE/wd62o9YDbdLVBewUWKZ7WHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPxDyqod; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8E8C433F1;
	Mon, 11 Mar 2024 13:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710163711;
	bh=AFWzF1Lhea4tuERf2x297B9VZ9r3NjTyKmU+LYLRnBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XPxDyqodU2lXWD13IHKafN7AXPh4BTw/sVzUEAAjIkecY8zxRB4ScWj5IVQhfAvHc
	 mKXiFm3PIDRHeb/Gv+X/5pe3Blmc6u3aV4engBMB4UoJdCtw28cTam+hruvh0VUvF8
	 prrUi71HmFtkayEoj/5VEEW27EfVoJP+s7B0JI/AJYXnM9310774lLfoi5PVJ8Nzl5
	 Y4564TATSxUX90KxbGew9dKxokZDiX/OJ0IDC8qQAECKoXuaAYNpVocM5ylEGt/yKi
	 dxgxjJanXwkp4kndACOOedB8F5PWFp5U1DAuMgyGtCG0kAIDXNRAkOdTn7fD8ALqzq
	 Ji6uHaYNh5Lhg==
Date: Mon, 11 Mar 2024 13:28:24 +0000
From: Mark Brown <broonie@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: ping.bai@nxp.com, lgirdwood@gmail.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
	festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	Joy Zou <joy.zou@nxp.com>
Subject: Re: [PATCH v2 2/3] regulator: pca9450: add pca9451a support
Message-ID: <5b257caf-5a14-4c82-9999-061a0093a831@sirena.org.uk>
References: <20240311084758.377889-1-joy.zou@nxp.com>
 <20240311084758.377889-3-joy.zou@nxp.com>
 <6027895.lOV4Wx5bFT@steina-w>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5xEXLheoiK7FmBC0"
Content-Disposition: inline
In-Reply-To: <6027895.lOV4Wx5bFT@steina-w>
X-Cookie: Sorry.  Nice try.


--5xEXLheoiK7FmBC0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 11, 2024 at 10:09:12AM +0100, Alexander Stein wrote:
> > +			.of_match = of_match_ptr("BUCK1"),
> > +			.regulators_node = of_match_ptr("regulators"),
> > +			.id = PCA9450_BUCK1,
> > +			.ops = &pca9450_dvs_buck_regulator_ops,
> > +			.type = REGULATOR_VOLTAGE,

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--5xEXLheoiK7FmBC0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXvBvgACgkQJNaLcl1U
h9A8/Af4ghJj9p33LNIkf0uGCYW+6YewUairPq/8Q81WYvjKcTtA8dUW1sES/9EA
GNFWhs2jmCm+HUJZ1xH30dD7jZ1RB1OmpAWkPD4FtCiircG7npzn3MoAH2lF46Mo
g5zcCDGlTi2qMHKIhqvmj8K+g9u03IFm6cncyTypMkYbmKrbaV7zwfKrSQ6wyt4r
5vbljMy49ZQ5fue4jKn+4jk6cZvjSsVrskUxdL29EqIyVJ/v4mH4sW9+wKQ6VGnY
LfHeLgYa65MzSJJx+h43Zr6yhYLX+Ez2C2FnaleA+43CskTwVDK8/mTLjHavwq8Y
7yUuWWU1SoC6iSwb9GJ/Y0NQpSde
=lHaH
-----END PGP SIGNATURE-----

--5xEXLheoiK7FmBC0--

