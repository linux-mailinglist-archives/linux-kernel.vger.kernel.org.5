Return-Path: <linux-kernel+bounces-121412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2899C88E7A9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2FAF3038E5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359AF1353F4;
	Wed, 27 Mar 2024 14:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+CLJsCi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74272131BCE
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 14:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711549007; cv=none; b=tlAX87/Jiwo/OGsINEzypq+xHcBcq6CD7tY+E/vtUWYjGbbINyeRmGjMQRNp0RIFTLiW+sCzzWCnd/hqmNAUTDqWofutEmPD/75uPKbxJHUj4xwMeRdRC+y6Yu4DGe6l9OV6kb3IXL2xUw4aF2FhsUCpOqlTGkdwXKBEpaKpVPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711549007; c=relaxed/simple;
	bh=X6TtCkvzyeuWuxRzUNv0L/JbTqVo4AOiX9lKKmB8w84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUtb0hOlkBJOmRrNpRhz61GTumiq+drbC8bd9avSOArgdjYAwMWV8qWVIOXRyBr3px3aMM8W2l+AgVh3aFoIc3B5kvX3HWhFQzOxJgwNSeXf8pEuWVbQ0C2JtQj+DgJLFrAjCCmIPemg5TvSV15iTUOgIHyJcMWFXCcZZ9io9dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+CLJsCi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DF83C433C7;
	Wed, 27 Mar 2024 14:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711549006;
	bh=X6TtCkvzyeuWuxRzUNv0L/JbTqVo4AOiX9lKKmB8w84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q+CLJsCigoaPaRe5h77tjr5A76GA7BlgelpCWZlKoAxpoT3HFVH8BXBeJQ8KW6jSi
	 NJKLJnZANyQLxTlG/XTkFiuYbBLg3X9rSMF2ZuyAJ2gkySRKpq4Mfxg+2JWz0uZY5m
	 px2QcfjV819ljICqsqYYYEVlmYfMs25XpV9ue+3Xui5dCzxcDJ8WIdL7DSRaIWVjjH
	 FZYRcYD+tlCjS1yu2ymQXJA9Mo5kiwSarGLF079ECZJpuz2fa/dDNbm+0KEz1swvIn
	 UpLaTeL2cuG2gTZQ+vVJXDXuNbyR2FJ7FV/yrg8CD4lHpmwrpYYWWRpvNPpF3IU5+i
	 RcLppqRG/Ab+g==
Date: Wed, 27 Mar 2024 14:16:43 +0000
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH] regmap: maple: Fix cache corruption in
 regcache_maple_drop()
Message-ID: <c83f359d-ae9b-4b09-b00e-ae99fe9eb74b@sirena.org.uk>
References: <20240327114406.976986-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KgJIHwQyvOmZL0+e"
Content-Disposition: inline
In-Reply-To: <20240327114406.976986-1-rf@opensource.cirrus.com>
X-Cookie: A rolling disk gathers no MOS.


--KgJIHwQyvOmZL0+e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 27, 2024 at 11:44:06AM +0000, Richard Fitzgerald wrote:

> This bug was not detected by the regmap KUnit test because it only
> tests with a block of registers starting at 0, so mas.index == 0.

Can you please add a test for this?

--KgJIHwQyvOmZL0+e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYEKkoACgkQJNaLcl1U
h9AaIwf/e6Ov56wVdH/4eKm0KrNdJqaywSQECI/yJSVVjpajvsRFg8/ddIuFa2ux
TbQCGAtya4O94GvM1ZD5oPqRgj4GRnCHazuju3bzjjh6h39SbsMNW4AnMmvkhbBl
KhdcDZiSR1sp/t0udfwMFqCrb7pI4vhGC3OP4MGyZY4y8cI9+DoiCMt9172byxgM
cvoIXaO0QNYuhCLa/A74+KkOMrUU67kjBKP919rtzxcg9ntSLSIKYLMr+0nluy9B
I0XLTm0D8Gj17hDCOW+6hKS4giqyqJ+tDnvPzjWmb492rc29+BnfRj8xd2DOYi24
/C7l8pudy3cVtN3e8GBqMMl1oMnK9w==
=ujKC
-----END PGP SIGNATURE-----

--KgJIHwQyvOmZL0+e--

