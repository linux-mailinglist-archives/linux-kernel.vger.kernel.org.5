Return-Path: <linux-kernel+bounces-59919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B0584FD53
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6EDEB25A97
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A295F85C58;
	Fri,  9 Feb 2024 20:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vPT/xaDL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E591283CA6
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 20:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707509149; cv=none; b=OBNrIC4m6b9dFT+mmsOtDIfrAYrjYrSyk8VrGNXKsChkpmUcZqI5IbxbsUE2iJTBeMH4Be0IeMaWI2fh9X8wojjjJ3p2hYlpG+Xx84hRqUq1YHF8OZeGSfBXYLIIsRzLt80hcTPhdPuKH/KTwnbeH61r55whfqKeCfcTKdcBw+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707509149; c=relaxed/simple;
	bh=h8vMaK0XmFrUac9t64uAU7bBk89wrRc7eBHqG+ClLZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IlGpCrBzqPEiiEr4unw6jXS8GBRx/xiZ/Um6ILxPYvMHf8wc+6mr57ByWBfWWrOz+k7bsYBiU8J3VuixylP4kwES73fLpg7FSnRKFMpdL4YZtFGbFbh6wZChmu+eWW8hWrVSdXdmRimsr6Gq98UchoxrmV0bCtYHbu9gDWX5JRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vPT/xaDL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E191EC433C7;
	Fri,  9 Feb 2024 20:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707509148;
	bh=h8vMaK0XmFrUac9t64uAU7bBk89wrRc7eBHqG+ClLZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vPT/xaDLXKvrzNbLoIhXl1A88RQABWXztDolIEj66i6t3WOOelzjqhZCsEhiWURSa
	 Z8bDm2cnrCyT6CLAcS1aGNTBS0QDUqX0Q3RTy9aYkNXaA7KMaRz/DNSJn06NzoImfX
	 fRmaRG7Tr+7f4yGoIbPkqzhWyU99rpBUIc5l28XQh2UZzzBpsgkE3qzi57oa6IVMfg
	 5xVP2VWctqh/Va3evEpcVlenNysKcxe3w7SHYYap+hGcetZtozkXz80WeXmvMcP8gC
	 yXDRlgWPW0Wer6aWowRX3UdcDIQgtyOAtYvBlKFCQhY9iIo0MUbAyaaAeO4G1ernMi
	 iPK/htcgFz8yQ==
Date: Fri, 9 Feb 2024 20:05:45 +0000
From: Mark Brown <broonie@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regmap: kunit: Ensure that changed bytes are actually
 different
Message-ID: <ZcaFmYGClhpj82Xo@finisterre.sirena.org.uk>
References: <20240209-regmap-kunit-random-change-v1-1-ad2d76757583@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MPLZbVRzcCcKrRpc"
Content-Disposition: inline
In-Reply-To: <20240209-regmap-kunit-random-change-v1-1-ad2d76757583@kernel.org>
X-Cookie: You might have mail.


--MPLZbVRzcCcKrRpc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 09, 2024 at 08:02:27PM +0000, Mark Brown wrote:
> During the cache sync test we verify that values we expect to have been
> written only to the cache do not appear in the hardware. This works most
> of the time but since we randomly generate both the original and new values
> there is a low probability that these values may actually be the same.
> Wrap get_random_bytes() to ensure that the values are different, it is
> likely we will want a similar pattern for other tests in the future.

Sorry, works better if you actally check stuff in.  v2 coming.

--MPLZbVRzcCcKrRpc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXGhZgACgkQJNaLcl1U
h9DqRgf9H0t80XKzFa/Ni4fG45mZdju+7l5m0P+V55E4q1pk4S2c0+dZ747WTYqC
vwVvWktGMgrvWwOR9bjtFkblPNZthl1PggMKegFtEeYC1YRVjqwREGoS0qwscRst
pPwYgND5caSEeZOHg7hHicMGI3rdUL3aUbrzCdzFQ80/WbTuTNRYqC6chPgT9f/o
UJ/jBoInKjnC7qH8VEaQqC7+vViIga9SLV9tVcnrGGgxTaecrhShd9D5mob+UlvT
fzg7f4zV4n2ECg4SD9gnax4yDN841bkISmlhj/mag1pX2zG0uDWcz03h27/f43EO
PtMA0znmMOsNPHsblYUkZfN5cFsScA==
=1VR1
-----END PGP SIGNATURE-----

--MPLZbVRzcCcKrRpc--

