Return-Path: <linux-kernel+bounces-102040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA7187ADD3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D89B1C22AB0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2162151CCF;
	Wed, 13 Mar 2024 16:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwUoKOhd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAF1151CE9;
	Wed, 13 Mar 2024 16:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348421; cv=none; b=s64O75QPd68f21ZvAbgDEgdVJ7Pk0PK7iNJ5I0BYqAH/iwWPVEh20jlRkVe7m2PtwxV3RJV2d0tCQ3p1K+fxpdVy41bXaAUagRe/YRD3b2uRZRitYwPHb0yEuA+PyKEpxWDL4mNqQjeETrEdQhnnFGBMIty/9DWgDySwjLvRrMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348421; c=relaxed/simple;
	bh=+jwr+E1e7wjKU4lCYHP4hUUWX5Os8W7OxhqpQQ3L72Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aslq9DYmAjHHDgeuooNKvxcsHqgEX90luWZgJBDkxeMGLNR3TP7MTmBH+55L3Rw0k8q8GI4blFANCoAakcm3qtNo1HqsmxScPWg1y7+3dvTgDJ0H1rKHGAVjVVauDnEK7BLvpwqTGeJRNnzQP/Ax8cfypggY5HF3CKc3LyF/q2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwUoKOhd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29FEC433B1;
	Wed, 13 Mar 2024 16:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348420;
	bh=+jwr+E1e7wjKU4lCYHP4hUUWX5Os8W7OxhqpQQ3L72Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dwUoKOhdXe4FseNs+S7XWJGKhWSMSKg7T/KSJliml6a0KSPPDHP7JLVnGGY+t18xG
	 1Fdb+vsEd5iGgmcVZrnwas/Zjjq/d3rvy0Nl1YhGDegsGFZC1lFOW9jfwyq+1gF/XO
	 /S25fZwxkyHDfn8qKuz2y8bimUIJ5OGD5fv09tscft7nbTLnqVV7v2RQyQ/NMeZ0QF
	 yiT4RT4B5mAnJIYEoB+BRiRNMgek46pO6JsFnFvB00nJDwpbsT1l39f4qLW/Lu+dLR
	 tYEyGDz3oh0mwmd4EAoTyLAlw46AEJ4v7I+hlZaqF5ssJ+TDuz4aFkvoYjWtAjk8Ig
	 EcqXaww2UUF7w==
Date: Wed, 13 Mar 2024 16:46:56 +0000
From: Mark Brown <broonie@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Marek Vasut <marex@denx.de>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Maxime Ripard <maxime@cerno.tech>,
	Robert Foss <robert.foss@linaro.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 5.15 73/76] regmap: Add bulk read/write callbacks into
 regmap_config
Message-ID: <8bcd85fb-401f-4a3b-b10e-633a0478c0da@sirena.org.uk>
References: <20240313164223.615640-1-sashal@kernel.org>
 <20240313164223.615640-74-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3+1Eqv4y7vYH/W56"
Content-Disposition: inline
In-Reply-To: <20240313164223.615640-74-sashal@kernel.org>
X-Cookie: It's later than you think.


--3+1Eqv4y7vYH/W56
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 12:42:20PM -0400, Sasha Levin wrote:
> From: Marek Vasut <marex@denx.de>
>=20
> [ Upstream commit d77e745613680c54708470402e2b623dcd769681 ]
>=20
> Currently the regmap_config structure only allows the user to implement
> single element register read/write using .reg_read/.reg_write callbacks.
> The regmap_bus already implements bulk counterparts of both, and is being
> misused as a workaround for the missing bulk read/write callbacks in
> regmap_config by a couple of drivers. To stop this misuse, add the bulk
> read/write callbacks to regmap_config and call them from the regmap core
> code.

This fairly clearly new functionality.

--3+1Eqv4y7vYH/W56
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXx2H8ACgkQJNaLcl1U
h9AqFQf/WwV/cfcvn0xEPiR1Iu4kGZrxV+FEqIJx2I/a9DFvGuJ4MZVtStbeJSE2
wbbtPFkwrF0CStlUJ6YduFszBdZKVWhYa9WX47VgNnZTuJYRV05P1aus5tdxpBWz
yWr0wux8hXOcMppDU4j8IrqTAmC5viR8bE45PhoHPjBMgpDMmag5kDV8Vjz13wlj
vQDuDIwunF38LGlWzkZHTZqBSNLmOcVmh/Odf2hEz2gOWlyK0vSS2U+HI+Xc95yP
dpC386MsF1DYwGpJdwKKUK6OBFHvs7S9Ij/5/M4M4zpdPgCsrbEYkHaSTMzqYOq4
zKbh6AXrmFb4x52I16OI9saNlxCxqg==
=EWp9
-----END PGP SIGNATURE-----

--3+1Eqv4y7vYH/W56--

