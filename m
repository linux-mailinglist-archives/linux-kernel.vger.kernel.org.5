Return-Path: <linux-kernel+bounces-74834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E59985DCE4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE2A0B283E1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622D17BAF8;
	Wed, 21 Feb 2024 13:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQo+0PHz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19A276C99;
	Wed, 21 Feb 2024 13:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708523949; cv=none; b=OfabxuCJVTp71BfDDJYZHMEy817pAIwig07mO4CMu6XJCB9WIN4NN832GpMOm0KjNmlCLvHcDq6qjHoh83tc7rwdqDKRyG6ymgITs2rVW0eS/+rSdTE7As5Hgzhw1fXitCDCjW90zgqcbBMIwR7LP9Je8u+2pmxrJRt5qqydKG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708523949; c=relaxed/simple;
	bh=X/G7lKtnp9PD7v9VqXbldG9EJsfOEHpvZ4lq87RVptc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pK38klwMH/qAi0tMFoQl2gPnyfFz8B2X0wge2C341TrRMKNhGYrvHvTZ/l7+lg/HlwzGCGHDucXwAAWvyecM+VZiqYjQVyZ+a0eqN/eJzIrkdmGfVB566FTrxBVyASbpQ4I3UOpnZTXZQ3OCGoWzTN1IO3H1W/2IRajKvVJmbw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQo+0PHz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC393C43390;
	Wed, 21 Feb 2024 13:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708523949;
	bh=X/G7lKtnp9PD7v9VqXbldG9EJsfOEHpvZ4lq87RVptc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vQo+0PHzIVUGX4MJbPpseVA4HTnIMN3kYSnwO323TM8Ns3nE09lkeSElfM72qN1JC
	 ZC0FHjO7srJInM9fR6+4Mzz5jl2we7DnzEvTNWIi5M65uCPLttOp2yawVdGiJ9Xr3T
	 s8+viqdEv9XprI7pS176nuw9N7Vgeojx80a2QkqG3lZapBjbyLU4qCdgVRmtJ2da9R
	 lwfcZhp9sKc9uCxg7aOwMjxmZbkjnGBaJBE48YRBGPUrRZaPaiHMC5xw8VCUUF6xuI
	 IRUQ4/V7y82rMjqj0dH1fdF9IRDbj0go9ocEylpteOW07/qZVMd5DatLnbDLUvLJG8
	 XnIqR1nAHiHLQ==
Date: Wed, 21 Feb 2024 13:59:03 +0000
From: Mark Brown <broonie@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	will@kernel.org, catalin.marinas@arm.com,
	James Clark <james.clark@arm.com>, Rob Herring <robh@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Suzuki Poulose <suzuki.poulose@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V16 1/8] arm64/sysreg: Add BRBE registers and fields
Message-ID: <e89ecbde-0967-4b8e-af77-3a72f207f3d7@sirena.org.uk>
References: <20240125094119.2542332-1-anshuman.khandual@arm.com>
 <20240125094119.2542332-2-anshuman.khandual@arm.com>
 <ZdYAJvZf4Ut5f5Rf@FVFF77S0Q05N>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5V3AUrAcGC7odcJW"
Content-Disposition: inline
In-Reply-To: <ZdYAJvZf4Ut5f5Rf@FVFF77S0Q05N>
X-Cookie: The second best policy is dishonesty.


--5V3AUrAcGC7odcJW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 21, 2024 at 01:52:38PM +0000, Mark Rutland wrote:
> On Thu, Jan 25, 2024 at 03:11:12PM +0530, Anshuman Khandual wrote:

> Minor nit, but could we please list thse in order:

> 	BRBCR_EL1
> 	BRBCR_EL12
> 	BRBCR_EL2

> ... since that way the names are ordered alphnumerically, which is what we've
> done for other groups (e.g. PIR_EL{1,12,2}), and it's the way the ARM ARM
> happens to be ordered.

It's a good point about the sorting, though the file is currently mostly
sorted by encoding rather than alphanumerically (similarly to how
sysreg.h was done).

--5V3AUrAcGC7odcJW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXWAacACgkQJNaLcl1U
h9Aj6gf+MY003+j5BlcBWYSSTU9lWHFgNHn3nCpt9euiBzB49AnYwHfq6VknFcct
zRpiP2wukKqZHOshF4g4ZoO8QVbbZpz0PcnppizClyXIQcw4Kpqlb8QXhXv1B5+9
E0pB0AD9tf5Fq1fsf94/b+vP4zSGpiMD2B66QN8F/j9pdhnhdfn9vhxKmQNLi9ou
TGEbHgBQd4v6cM+0LoxfiROwZs9CS3f3olxRAf0HpCaxhjlA3zZxOTemgrfMeT1r
Gk7XghMlU569Wv6CNUiZ17WgceP/sE4NaUNfSamqHaItPkVL2lx2BJ6lN6YFQPfV
7BDXhudgmoB6vnZl4eeUef2cF1oBag==
=GrKU
-----END PGP SIGNATURE-----

--5V3AUrAcGC7odcJW--

