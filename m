Return-Path: <linux-kernel+bounces-94291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E76873C8F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 236FDB235C1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA708139569;
	Wed,  6 Mar 2024 16:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XqX0qM0A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36184137936;
	Wed,  6 Mar 2024 16:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709743679; cv=none; b=eTw/Sth9Ca6jmRGTQ6hACxpJpAK9ydbKJbxOi/89QzsVFFXPkwwAT9e0LCaP2CMk9qcjbbag/46vG3zjGq4OWgA9mEIAibDdKdjDj40WBNZSxl0G06oHL4Vf3zv1pom1E5retWpLXBiU2uEO+PRpGg+p7qBSYBvbUtqjSNPw7ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709743679; c=relaxed/simple;
	bh=gyK3Oa2EgaOEcRwH1bFm2IMU4x6SIH8TB4MiAN3Tmtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6noxD/gn4SL8fY6FcSjb29oHFHaHsW9Afx7fRZhaHRwGaF54fgLgJSqw+BEAV5b/ElOALg1MEhetxVapfs9QSUmcHLAJ8zupmdOqbyeWkiHTtt+yoFLgTRV2XMF0gLltS6rS42gJrjuGXvqepuo+f7odL1hYCQNxUpkOLGcyk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XqX0qM0A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41257C433F1;
	Wed,  6 Mar 2024 16:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709743678;
	bh=gyK3Oa2EgaOEcRwH1bFm2IMU4x6SIH8TB4MiAN3Tmtg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XqX0qM0A8xM6CjT/E02/ozWGPWddzvlAD1SKPZeeIYniqf3O/apGGdbEKSK+SBlgd
	 Us3mWwgAleZtLRQgKt7ZyXBYeVoOsmu0cLQKejzFSFwo5rKx2H08Am3sSXzmSnsNhK
	 tSVhj6VDf1pP7fFSvFBHpYolt/DqYy+QHA2cUKv2teTcn4g6V16BEdO6EXLuUpNyvz
	 FCSCeD3h3MIS9JZ0JkxO6KXBgJkMJ8y7alGEUHCOEbsH3K5Cv7VxDyCdWn3ITiI11K
	 BevR8F6K47bChOgGsHQ+p20R+PAo/LVQBcQiHJ94mFPV8OEIbDZJs2mwc1FJ4tTgLs
	 oLQY2Z2JhDWWQ==
Date: Wed, 6 Mar 2024 16:47:54 +0000
From: Mark Brown <broonie@kernel.org>
To: Stuart Henderson <stuarth@opensource.cirrus.com>
Cc: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com,
	patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 2/5] ASoC: wm8962: Enable both SPKOUTR_ENA and
 SPKOUTL_ENA in mono mode
Message-ID: <1db18205-64ec-4235-964d-89cfd198a5b9@sirena.org.uk>
References: <20240306161439.1385643-1-stuarth@opensource.cirrus.com>
 <20240306161439.1385643-2-stuarth@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EoYH/R4wBBEJKnZL"
Content-Disposition: inline
In-Reply-To: <20240306161439.1385643-2-stuarth@opensource.cirrus.com>
X-Cookie: Have at you!


--EoYH/R4wBBEJKnZL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 06, 2024 at 04:14:36PM +0000, Stuart Henderson wrote:
> Signed-off-by: Stuart Henderson <stuarth@opensource.cirrus.com>

Because...?

--EoYH/R4wBBEJKnZL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXonjkACgkQJNaLcl1U
h9CKDAf9GubyuS+G38uH6EeHSpRuTVyLfwf8KGTJQNFNlfLpma07D2/LU3K1KqvT
dsSPV1QE2jlr7kwLXdQIZj8qOpFRRAS6Md3L3Lrlzct5wNf2w0KPE3fiCKTHHka2
eqYvKcTTYpboaN+rkG3N65z7La4aaNv/8cTcfe8yd5LNbqfceuun3El1EdxXfn2B
dnaIVSyXBCzAURjbnwONWlVGcqhRUboLAQ1ePukh2/zWNv5oY2XKvwmtIFpdf4iF
6aUbFPdU+F7oeq/xdGCuDgVUepJVc/Y1coSw6FdaFoojAlWErr/VCxh5IFTvVKlH
uzN9wCsXix9cKZrZxKrdYaRiXyEvmQ==
=/g8g
-----END PGP SIGNATURE-----

--EoYH/R4wBBEJKnZL--

