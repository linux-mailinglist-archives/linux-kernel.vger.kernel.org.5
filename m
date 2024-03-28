Return-Path: <linux-kernel+bounces-122989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 352D98900BD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4FF41F26638
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E068174E;
	Thu, 28 Mar 2024 13:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBe+Yn3L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131BA11CA9;
	Thu, 28 Mar 2024 13:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711633534; cv=none; b=r37jiDkhSGh/vpSJA0fr7iwuA4YOaU1swujhaTaznMFLpcPUXWiudi5e2hCIR9Kce7ZqF+nZhfT8bmeQDgvsYYHUMlWdA4RjEm0p2/CnGtBGCJzM56kz/WBIpE1JuIcsZJqTTL4lpXd1qefbPeskh5qQaxXrJtk4HNNOTFMMzP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711633534; c=relaxed/simple;
	bh=MFAXdOaG8IIYPpPqn+fadq88X4T0bNFsHUij/Byl2l8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRKn3+CRVgecsgrSThEihB1InWQ5mi5d+MKgB7iFhX4DE3Tv4KPuzAlTduWbvEPTLFZJMk56e3enjLhQKGFXSyQblpMROlVdqsA/XFPtb3XkYmPnK9KTPeNIYVDgDhZi/dCJDyafRbE9Z2o08o5rtL8FN3VZY1BICCdDdLlNSUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBe+Yn3L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149B2C433C7;
	Thu, 28 Mar 2024 13:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711633533;
	bh=MFAXdOaG8IIYPpPqn+fadq88X4T0bNFsHUij/Byl2l8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dBe+Yn3LhADOFryjYxU0YHm2Ov3d36otcpmHlaE6/JXWkUaNe51GLtPOobxKTcWPX
	 dcxIvvhctvJ54NbEOiDazdjSRY+/Te9yOKpWLcbd0Haaao7WGkSv7dTme0HzzAZGit
	 pi6kp97eOCNY+tr1b8k8i6WTIjliXvDy+ULv8stjOaq7eKkixq+vaZB0BAnUiawUVN
	 a1l5w+OV3v4Pw9YaW9clwc15VG7Lx8WD1vjb9GGkK+RAIvGr17g7kNi4oW7UKVQMUB
	 SEUwnXUpMp81sIqF+qH2aCZW8MFOlgWFEJ7vOMSCgUGzZgKcBCPM28VpEiCnGk84zQ
	 gHDeRactzp+ig==
Date: Thu, 28 Mar 2024 13:45:28 +0000
From: Mark Brown <broonie@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Mihai Sain <mihai.sain@microchip.com>, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, lgirdwood@gmail.com,
	andrei.simion@microchip.com, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] regulator: mcp16502: Update the names from buck
 regulators
Message-ID: <aed9c6f0-a33f-4d2d-ad5c-2a5589483afa@sirena.org.uk>
References: <20240327101724.2982-1-mihai.sain@microchip.com>
 <20240327101724.2982-8-mihai.sain@microchip.com>
 <20240327-agreed-routine-0cc60186876b@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3xvy50Unb7ZcoSWS"
Content-Disposition: inline
In-Reply-To: <20240327-agreed-routine-0cc60186876b@spud>
X-Cookie: Yes, but which self do you want to be?


--3xvy50Unb7ZcoSWS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 27, 2024 at 04:28:49PM +0000, Conor Dooley wrote:
> On Wed, Mar 27, 2024 at 12:17:24PM +0200, Mihai Sain wrote:

> > Use generic names for buck regulators to avoid any confusion.
> > Update the names from buck regulators in order to match
> > the datasheet block diagram for the buck regulators.

> I know the regulator core will create dummy regulators when they are not
> provided in the devicetree, so I am not 100% on how backwards
> compatibility works here.
> You'll end up with a bunch of dummies and therefore the regulator-names
> and constraints on the regulator will be lost, no?
> Can you explain how is this backwards compatible with the old
> devicetrees?

It quite simply isn't backwards compatible.  The original driver looks
to be pretty broken but this breaks compatibility, we'd need a
transition plan of some kind which probably needs some core work to cope
with fallback names.

--3xvy50Unb7ZcoSWS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYFdHcACgkQJNaLcl1U
h9BZ6Qf7BKNHdl8v6RMF5pRZyZ7vMKhs3CzyTeHe56lT/zejkrG4sHEsOQmV0dEG
gVWKyDlpXzD+z5yrfTxadrPb3u72NEnFS0PEMBh0WgyuJ6YSVy8QaQe6jvKeJlMY
+jsh7bXzm9YKiBVya1gudts97wrILFiI54yEpsHt+hAyVHiQkaoceEAwMRoprUJR
3nxMQIn/fUIAsXCtEjPHHFGDCu6EjsHVS7pU0D/6gasATd++yCdnWgSk3GBR6HOV
ahuAjSBE09Nws1mo275I83sFix1FyemBdxvual2iRBekMpTyl4hsz3EhuhU6o6bW
My2Qzamr67YowDrsd2oEqYGVTJuBoQ==
=t1ua
-----END PGP SIGNATURE-----

--3xvy50Unb7ZcoSWS--

