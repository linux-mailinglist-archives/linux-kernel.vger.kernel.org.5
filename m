Return-Path: <linux-kernel+bounces-59199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3530184F309
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95C3AB2421B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2415D67E9F;
	Fri,  9 Feb 2024 10:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOoe6izY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC1767E61
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 10:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707473696; cv=none; b=Q3Qh4FydbO6FX5cZkQqbWCcyNLBSF3a1KvOkrKYCkEAVO6i12gNDiMtRK4pmNZroPaZ3AZcHuYrr7tRuNCgXUFuWKcFE+77pEBSr9J55+FOaEUp/mJuouxg+8TogVeq0T4Mb8CAR5q2grPInz+lFBaGOCYUpvmlYkdEKmuLgi84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707473696; c=relaxed/simple;
	bh=dmF0N68UeUbdJ8B3dC2nee02h1Iy2lbYuGMx6bY7DHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OxAsbpcPjiZDMhu1DqTJkvMRp0TrueMoSZq18tphHosz4GljQ2kXnOEMQBpY8vHh0d1oZkAUD8lcZmKkUZJ9taKgSNXuixi634ZKWupIokjfyLnG5D4ANz/9NTS0zoTG/ijSWqieU9cwmf+clu01PMAVNSq5ZuKPB/u2FLB5V4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOoe6izY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FAB8C433F1;
	Fri,  9 Feb 2024 10:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707473696;
	bh=dmF0N68UeUbdJ8B3dC2nee02h1Iy2lbYuGMx6bY7DHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OOoe6izYsxNWuGHERjXdGrte/miBwjdArnAtVzsdlC+S3kQ+vx6g6VHq4gb+siOBd
	 OaDYfWbfEp6EvaEY46qvS9BnO8+OR6wJ1Szagb/1HnSciD9GaU4SbByPKyVzD+/2UA
	 HU+MESVtlL417w9Q0ERel7hyIRF45OICb6zxc32p9e2pmQs11GDD67ikROIVwYzSwt
	 90J6KRWNN3Ly7TXs8GXbwrP8oi4JqZ/wOBCfzq2nrQIZnWDJarY2NPb3Sndx77YvF+
	 jVENSZRd3rUk6PUmeMo0TPf5oA11piSdyrzwYKQ7KfnjOS2EZOUS5ESFDiTeIGD556
	 +OEj6yYSyztfA==
Date: Fri, 9 Feb 2024 10:14:52 +0000
From: Mark Brown <broonie@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sporadic regmap unit test failure in raw_sync
Message-ID: <ZcX7HMQBIG75In/A@finisterre.sirena.org.uk>
References: <dc5e573d-0979-4d7e-ab4a-de18a4711385@roeck-us.net>
 <ZcVRcH/D945GKWjG@finisterre.sirena.org.uk>
 <91218892-d8df-47f1-99a0-6c4564c7bebe@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JSxSamkldszwCk7f"
Content-Disposition: inline
In-Reply-To: <91218892-d8df-47f1-99a0-6c4564c7bebe@roeck-us.net>
X-Cookie: You might have mail.


--JSxSamkldszwCk7f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 08, 2024 at 10:17:02PM -0800, Guenter Roeck wrote:
> On 2/8/24 14:10, Mark Brown wrote:

> > I guess it's possible that we randomly generated the same value for the
> > initial and modified values here?

> I think the diffs below should fix the problem. Would that do, or do you
> have a better idea ?

Something like that, perhaps not that specific diff.  There's a bunch of
tests that might be impacted as well so probably a helper would make
sense here if nothing else, I should be able to take a look today or
tomorrow.

--JSxSamkldszwCk7f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXF+xsACgkQJNaLcl1U
h9CSewf+OHKlWs6LZfGLk+DKlyuoY0Tn353DRYZgTy4DCab7WD21QTaxHuPs7oQF
hY9Q7Mv7TBJ4OwDeqHaabajueS5pqR6fai7Wfm76w4FjhJpOEQ0eeSZjUg3vgm3P
fKZHptQqsSNs1dWPXujXdhHXQHuC8Vcc/g+C077rOw5NVhJJeoPnwCeTpKxUvj/X
/JmAugspubBxx1FWUUAsS23cQFszwHDeiLh+Fevn4emPHx1JKiFzE4hqht/Hqfnr
siHxjvqDlr/AewefIeV0tQL+ORO+3e1TGVIbpvvArOnapXYjEsD507Vwdt36tfGF
/8p3Ftzo2Yk+T4G0CXlOO0dunQZQOQ==
=7abA
-----END PGP SIGNATURE-----

--JSxSamkldszwCk7f--

