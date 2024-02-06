Return-Path: <linux-kernel+bounces-54722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1E784B2E0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 849E31C22781
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F1412B16C;
	Tue,  6 Feb 2024 10:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cU3+y6Om"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D6F537FA;
	Tue,  6 Feb 2024 10:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707216983; cv=none; b=abgZ7vPYRozm5aFsT6O4jAnXdmEgzNPB5AaETp4Jclw7I71y/AOCcqj2OiLdTvKodRQ9yHUlSyCP9Q3kCOAs1PjYtJfs86oiz3uLt4gkRHMViLWrnbEktjHfXjh+WGQdXbuect1BWgAURCuoWfViufjiGiA9r3A1szP40XBbq9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707216983; c=relaxed/simple;
	bh=OrVgVwy+hsicCxLOVEd9BgaOAQJZYA4HacT+HKV6LLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h++wsUR+yHZ9t4jUCmOFrTMDZB5QPfvx4S8wGYT53gPlVyfMw8d0NscB6wh1ehtpwa5pKx1EbwFRXO/A7rOE1+E6cUTGVrwWGp94AOn8OV4UXps8zq7azrM1O3op3byhzMM5hAPLa0gxRfA/3DaBxggehdfNxqEmKYYtuTgDCuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cU3+y6Om; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA721C433F1;
	Tue,  6 Feb 2024 10:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707216983;
	bh=OrVgVwy+hsicCxLOVEd9BgaOAQJZYA4HacT+HKV6LLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cU3+y6OmF2hpV4Vn2Q/SOGqu9IRUgTO7hPkYUMc/sZ6HbBFdDsQR0TG4lRZUux+LK
	 lztDU8Km8UM21u1zJ+rFPjelvDMz1C++WSsCx2UfEwZHYGrUvLOrIuAgxPrLGcserq
	 xs8z6O3aTDDvwsZzvBf9AU+QkpdabIhTVBSMq6nde9FRH+dpbbu5uccYEo/vrAGMEJ
	 Qk4zTQCvf0MkPJdCZBpsE+lZkqSLulhBnQmNAfax39OTiu+tqquJSnaONxeuQRDPaW
	 i7S4dEJ3ebUcl+b5A4ad1q4l4JHh8J/44KU1hc0NbfgZHqUyTcXJPRG5vnD+nv5/qx
	 b6ZhzkytNVClA==
Date: Tue, 6 Feb 2024 10:56:20 +0000
From: Mark Brown <broonie@kernel.org>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Miquel Raynal <miquel.raynal@bootlin.com>, yen-mei.goh@keysight.com,
	koon-kee.lie@keysight.com
Subject: Re: [PATCH 2/2] spi: omap2-mcspi: Add support for MULTI-mode
Message-ID: <ZcIQVKibMmGegw+j@finisterre.sirena.org.uk>
References: <20240126-spi-omap2-mcspi-multi-mode-v1-0-d143d33f0fe0@bootlin.com>
 <20240126-spi-omap2-mcspi-multi-mode-v1-2-d143d33f0fe0@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1uXBsuND+NmkCmGl"
Content-Disposition: inline
In-Reply-To: <20240126-spi-omap2-mcspi-multi-mode-v1-2-d143d33f0fe0@bootlin.com>
X-Cookie: You might have mail.


--1uXBsuND+NmkCmGl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 06, 2024 at 11:00:50AM +0100, Louis Chauvet wrote:

> Introduce support for MULTI-mode in the OMAP2 MCSPI driver. Currently, the
> driver always uses SINGLE mode to handle the chip select (CS). With this
> enhancement, MULTI-mode is enabled for specific messages, allowing for a
> shorter delay between CS enable and the message (some FPGA devices are
> sensitive to this delay).

I have no idea based on this commit message what either of these modes
is or how this shorter delay would be achieved, these terms are specific
to the OMAP hardware AFAICT.  Please clarify this, it's hard to follow
what the change does.  It looks like this is just a CS per word thing?

Note that you may not have to tell the hardware the same word length as
the transfer specifies, so long as the wire result is the same it
doesn't matter.

--1uXBsuND+NmkCmGl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXCEFMACgkQJNaLcl1U
h9DKjAf/W41ubd9F4AL5xNDGXx0GXCzvwTgjG8n+1FoDhInLiggXU97xVnUGp63/
grVBFZCoJmEV6kXCzob8sRiOQyYTiIWq7g98voFlAbvprraMOniul0eZqmvKpNSy
HktuQR9QIbDuiNHCRD4a/qat06cgi/ij6oF/r5F9VdvOUu3UyAhMzVm46yEsFIqV
1PqA8y0/6DVGM+NUEwXevlAKx7pP2IYb2LBi51SHKBvwvxIhXIw99H4kQ9XdRJu1
zzp08wL8eWiZQNM1QOuhuLoa1sfvKQBRZmErHf0o0i99rfCblO5q0JqrvuT2qCsX
WrQ21twP7gkv1mwIVJIIut9LJGNZQg==
=rKBz
-----END PGP SIGNATURE-----

--1uXBsuND+NmkCmGl--

