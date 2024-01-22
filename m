Return-Path: <linux-kernel+bounces-33994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2382B83719C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56C271C2A722
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F132B55771;
	Mon, 22 Jan 2024 18:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5CZzoWJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7E054BF8;
	Mon, 22 Jan 2024 18:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705948713; cv=none; b=TvyKOBwuOmhU+FYy7SLWstg8bGaxv4+opnnFW+rXY2Sb5RvoDMjPqhEFgOxnR/3/6l3m8e8SNbbOhr6bNMc1udwHiLfGM1ylwPuK9Mj6YhwSAi2GC9Uv9CSi2iwQHG+LttSUJDyFZUC5dSLq27qLBhfYRffxEn7pbxkHmCd9ADo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705948713; c=relaxed/simple;
	bh=KVE7Ws4n8dlfxAnlggmPADEvbayua5rMmkRlflKaJvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5/F3C0OHvG3Po5XZk9R87uoZuNMcJYHhNJ6Y/hsX3KT1pRy0j02A33n4Q+tj6Sr1G0abK74tNx9ePtuJlS1a7nRnJjvkxgqy0k/ZsWuo+4hqUpmD+X89OGXUo42TTP3lo6m+PmDVhAzItdKhmhSRgJSPrOn7BJz5sUSuq58mis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5CZzoWJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4BCC433C7;
	Mon, 22 Jan 2024 18:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705948712;
	bh=KVE7Ws4n8dlfxAnlggmPADEvbayua5rMmkRlflKaJvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m5CZzoWJ1qckyfLAJTHg8LY+orIVXY8bBoZ3JZgMj+suMPUb0RrF/3OrY4RnpBBJq
	 5NqxAQj6ZvDwcQ72gCa/3JHDyozbmb5hosHEEIKmVFBdeowRPhucyxlKDax4ZSQKdw
	 IVk9LbokUgCaTldulfOfeU5vg5kB+RZE2CvFZmI8iSA4e2HrHI8RCJOYKyg3D5LcMn
	 eXmtB/XRyG8EXSOZgv2qv+dCFfsyLAmfhyxSQsOUD7/pSKZN4XVwBoDlRg7Ohp4yBJ
	 jEOQgqRnM4Mua02QwMe5NdAvbmg7L70PIURZEhcpw3hFYhGN04Dg0LVkr1xBuXXMte
	 B/UMOe6vVGtXg==
Date: Mon, 22 Jan 2024 18:38:27 +0000
From: Mark Brown <broonie@kernel.org>
To: Klaus Kudielka <klaus.kudielka@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] SPI updates for v6.8
Message-ID: <a3b7790b-ce5b-407f-8089-a18c52aa7a1e@sirena.org.uk>
References: <20240107223817.EDB59C433C7@smtp.kernel.org>
 <d8724cd416494bb5cd5b0350266fce0cb7b3b210.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DTvDgoXj5eUMt50c"
Content-Disposition: inline
In-Reply-To: <d8724cd416494bb5cd5b0350266fce0cb7b3b210.camel@gmail.com>
X-Cookie: Nice guys don't finish nice.


--DTvDgoXj5eUMt50c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 07:30:09PM +0100, Klaus Kudielka wrote:
> On Sun, 2024-01-07 at 22:38 +0000, Mark Brown wrote:

> I just booted 6.8.0-rc1 on Turris Omnia (CONFIG_SPI_ORION=3Dy,
> device tree: arch/arm/boot/dts/marvell/armada-385-turris-omnia.dts)

> and got the following error:
>=20
> [    0.090231] spi_master spi0: No. of CS is more than max. no. of suppor=
ted CS
> [    0.097358] spi_master spi0: Failed to create SPI device for /soc/spi@=
10600/flash@0
>=20
> End result: the three MTD partitions I used to have on the SPI-NOR are go=
ne.

Actualy looking at the DT it's not immediately obvious why this is
triggering - there's only one chip select in use, numbered 0 AFAICT.
Anyway, if you could test the patch I linked hopefully it does fix the
issue.

--DTvDgoXj5eUMt50c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWutiIACgkQJNaLcl1U
h9CK0Qf/RkQt+iaRnvCFL1dWSb7Tfy5yMtCUTsGisJqdcuS4rNDLCXH34HJQTKfa
yT1fiYYMAxCo1z88S3sfG9TLoAbtq2ScJC6/PwpMpSiZy2uimcWBOx1Gnad1sLto
9lK0PZe9r+kjFn2cBLcFslkXllYSI11nDoj6/Nwe92JUH4rom4/xtmJ09aFhKtxZ
xPxiEkgX1dfRmg95nXCViae8cEc/3PgZuucyCvww2aJs1tEsSKOflE5szn66kiiR
/3gj+c1DcNZBYE6wSS0uNaqvdb14ZWV5kcFvNRJOzEx17s6/pTixKCCYu+Stxn+A
LlvqFT3d9L0bkicmDueOe5c30NkXNQ==
=QmhZ
-----END PGP SIGNATURE-----

--DTvDgoXj5eUMt50c--

