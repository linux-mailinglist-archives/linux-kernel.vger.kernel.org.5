Return-Path: <linux-kernel+bounces-119539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A8388CA27
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A65A61F8135C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0C41C6AE;
	Tue, 26 Mar 2024 17:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqX8/S0C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A9886AC6;
	Tue, 26 Mar 2024 17:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472564; cv=none; b=MeHPMZkxjgFTWPEO0O2lf3znrS/ihn2jLlPS/xwPO9Nh2/qTOqc70RYFcth9Lf5edjRb9xiWAX+BDP2cUhLeS/xiSI1vtxCxGtxPZCscEEwNAHa7buiuuFf5jTfFH2kAo7cPFg55UK1eq04b+DrCqbKzs2xgY3R585EsK0wgDGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472564; c=relaxed/simple;
	bh=iW9y3Y/TknvOpcoz7uW/XS97+t+7Z94tavErQQRnGks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8emi4DztKe6R6s6/GzV+Hzt/fCsGRkPITul4gPMuBE2hsxP0WU0540VVVZD/ke800LVkzCSd8PFnTT+JhtVuEna2J0IePb5rLwXpyqoed/0XQGb3SEsUiVQP1dXzAMM3+GZOilbZGqcLwbIV7iJA27bPUFA5zB/HM4J2l1iU70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqX8/S0C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E34A5C433C7;
	Tue, 26 Mar 2024 17:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711472563;
	bh=iW9y3Y/TknvOpcoz7uW/XS97+t+7Z94tavErQQRnGks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NqX8/S0Cr025m2UVJ6ZF5OELiuVC8YSh/myEKVhF+y+Ms2r9gHFfcU1a7nUyFbYea
	 +QEOXjuL59BJ7POFnyZCeOFlWYwXpXYkrjzVSvO6b3NkG4z24E0PfeYqwovWUTrYP+
	 yS/SXdej8M+4Ncn6l5q+U+FQ8Xoy6T4//+CaIsicXEInGkv5OXeswww++8kQtYW6NP
	 9uIEYNimRexQvoZkYmrrB5dR/qmlcLrUxz7HwciAiEO+GKTm2DHtcjvVRT/byQ9FJz
	 J719ZDsQNo15GRCPvSrIAKIsINOP4Bk1Y0ClxlH3LcIBb9TsVK9sJQRkFRRlzUEoXs
	 3Ymn380FSORuw==
Date: Tue, 26 Mar 2024 17:02:39 +0000
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v2 1/1] ASoC: soc-jack: Get rid of legacy GPIO support
Message-ID: <986726af-ce6b-45a5-b173-f5fb041e9849@sirena.org.uk>
References: <20240325143654.3305498-1-andriy.shevchenko@linux.intel.com>
 <ZgGvev-Wh7SkYnI7@smile.fi.intel.com>
 <ZgL_N1aMQiju3yaI@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="M9Ukfix0yvhMC4bZ"
Content-Disposition: inline
In-Reply-To: <ZgL_N1aMQiju3yaI@smile.fi.intel.com>
X-Cookie: Equal bytes for women.


--M9Ukfix0yvhMC4bZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 26, 2024 at 07:00:39PM +0200, Andy Shevchenko wrote:

> Okay, since the fix-patch had been applied, this one now is clean to go.
> Do I need to resend or any other work needs to be done?

Please resend.  If I've told you a patch failed to build it's gone from
my queue, I don't keep track of anything like that.

--M9Ukfix0yvhMC4bZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYC/64ACgkQJNaLcl1U
h9BqfAf/YIgLoih+8I41bCwWifnh+1+tuCTGCG/TKdKID6+zknajNq68wDglFRNF
wfctSb7xvtfgiUKjxBfKvkAimyYakfIPC9T9uHbyaHGXG7AkO97wnURHYv5kv+yS
9WmjSeofuAHfGv6K8Tflzl+cVpzQP4x3ocVWXdYJfPb8nv5WRKpZBv5Kh7hvAlmb
EMVnl0PT3jtWJFif9kdyopXQiUpVKkkZs8T2pPx5KzVBRfhdF8mMeyHZPRUJvw2n
UOOs1K5g051Q+FIRlUVHNJYuL28uTMFXRzhaxp2HfU3FjOHQjRyeFbhhydc3c71d
X0k6rK6Z+cI43VWsAJQD9a/Oql3foQ==
=Egvd
-----END PGP SIGNATURE-----

--M9Ukfix0yvhMC4bZ--

