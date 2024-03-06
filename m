Return-Path: <linux-kernel+bounces-94378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEED9873E22
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA24D1C20E78
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED2F13DBAC;
	Wed,  6 Mar 2024 18:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VThLhnUw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE6E13BAD4;
	Wed,  6 Mar 2024 18:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709748528; cv=none; b=OkDDc+VponiP6FrEZbrjAO9pQdPWUFfTVrofd7HIZlea4nEw+5UKJXP/yz2H/hvC0v0rVaz6uP872WbhFa7Hu9VCJowalH33encbOcLfqSf5slrpqj2awKLLKQgiOPuzc2leSCtNKN1GZ6qDdwketdoZonrXhls8kDQ4BI0achk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709748528; c=relaxed/simple;
	bh=gjbkPCLU0GSthLX9UU7TNoesLW/ctQbEvRJUeFZ5Ydc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ea08TPws8ZR5Gbs3I/8/7XLiAutlHAFnHekejM2DR8JzWOoGIcrL4bVoi0wCekhZxigjv5kyZ1hjpavNKUkncyHubrCnTlAK0RE37zygZjMMJRklVkTI5nF56NWoDYE5Za3cR/LjbtOnGV3vrMftkvjnmZSz4zbH0J2eqts3bYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VThLhnUw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09F2C433C7;
	Wed,  6 Mar 2024 18:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709748527;
	bh=gjbkPCLU0GSthLX9UU7TNoesLW/ctQbEvRJUeFZ5Ydc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VThLhnUwI8AyPlu32GtJon4DdVTBLqKx99BkFik41v+rhqcz9rCxKWEvPYKaEQvMJ
	 lPTAyw2BHyIrLNZoKmV3fFtUgeTRpEabcL1OtQ53ixli8rR/fN2FzAuSsVB5CXCsq3
	 yjHNCY/rdhywA8ZZvoObdIT/BQMLKonItrQ62ksWRcxLfc5Zo/3KWxb2twFVG3ztUv
	 q2DZ7ZwYBnTXNKHnyogveHiVo0kdClurVbEZ0jsFp5lc56c6tHAvz4t7qP3VzcIFIX
	 XcCJhPsbnefTdbQCtUpQqSFr1GP1d0Rwp+BS3XiiCNMImoSlQ2iM4qHniBB/NVDd4k
	 NZ83WazsgvCSg==
Date: Wed, 6 Mar 2024 18:08:43 +0000
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] spi: Fix multiple issues with Chip Select
 variables and comments
Message-ID: <32c04b04-17c1-40f6-ad57-6c18e47f4842@sirena.org.uk>
References: <20240306160114.3471398-1-andriy.shevchenko@linux.intel.com>
 <20240306160114.3471398-4-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9z7W18CWCMxAgqpj"
Content-Disposition: inline
In-Reply-To: <20240306160114.3471398-4-andriy.shevchenko@linux.intel.com>
X-Cookie: Have at you!


--9z7W18CWCMxAgqpj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2024 at 05:59:42PM +0200, Andy Shevchenko wrote:
> There are the following issues with the current code:
> - inconsistent use of 0xFF and -1 for invalid chip select pin
> - inconsistent plain or BIT() use
> - wrong types used for last_cs_* fields
> - wrong multi-line comment style
> - misleading or hard-to-understand comments
>=20
> Fix all of these here.

Please don't do this, as covered in submitting-patches.rst submit one
change per patch.  This makes it much easier to review things.

--9z7W18CWCMxAgqpj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXosSsACgkQJNaLcl1U
h9BfYgf/cKcpJPUcMdXFEFkUesXcP04394R5QGqmrk+VzjU9CxiFYVZgaDm733T7
M6foeT6WP5AUewCOHlLmNR6WUSWRpsDNeGKer74JSP6FaslZMLB9GeO7xO4/vntH
8zhJhjqTXrsXkAzMntajRtQ3fi7bBojvLdKVWAO6353Ufv9xma0lLrCC1oO64vW9
LE1BywxR6ApHzxdFWvI8ej2jqHz3QRQ7CPbKsYePwnyU08YhA0Nw8TMtQ9vasFME
HGca9IecsnKOKqyCcoDhwQxj3a3WPCCCruq5kv1HfTsG93pvP8bDeiBftljSa7q4
42L4rPWD8sCrfPEFfbdRuPkQbXPTxw==
=ZP9K
-----END PGP SIGNATURE-----

--9z7W18CWCMxAgqpj--

