Return-Path: <linux-kernel+bounces-117584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E2188ACED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72C97341DF1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D8F5CDE4;
	Mon, 25 Mar 2024 17:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INWK+d1Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBFA2E40B;
	Mon, 25 Mar 2024 17:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387379; cv=none; b=Bw+ja6WJy8ZG/5MVYziOgMkvUbhavbl4RKLX/EISluV1P77CHxPA6eAFqVVfi93smMYtdWoPq0HP5w7UmzzODufmC41EalMU3nNlGknlA5iAVDVRpjTwAOdaIMVr6mcx+XXrf5J0OALSBVT6ssUt+h+E6DEHoap/CXdVwcXl0eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387379; c=relaxed/simple;
	bh=xfJbMCzsrXZxRm25PZGOd822X0FpoeAfxKN45zbkmC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWo0pmaqVulHn2Hk7VKDONVbSfLbkS31t+Q+eMSzAsJfeMK8DrWXEL9UvyYnTH+OvVmZ7cYjhVQxgmpO182fSShsbVwiVAP4y37GW29H4pw1s6JQEjV9V/fuDslcPkKLEQFIK/twbzNyPZkKb4j2JEt3CaADM2gp6WZfqmMDqTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INWK+d1Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8C3C433F1;
	Mon, 25 Mar 2024 17:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711387379;
	bh=xfJbMCzsrXZxRm25PZGOd822X0FpoeAfxKN45zbkmC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=INWK+d1Qv+IU/FZVe8ERMYzaSnFcqiu0MiNfbfRBhiNZOcNqyFEMCYaOsBhKMKiTA
	 uUBfFPKmaOLse+7VpMMd3oKt9RcKs2vnzhu10PQp14NADD7a7EVLyN0k3jdZ2kDGrO
	 xTVpE2/vi3pknUlTcB1ywfBzj3jCUfKc2sdcYfqKh5VRdbBWgPs1U60ONH7GK6V/fO
	 9PFLEP4d9+9ngYNwAO4cmax5NsJgTeF6AjqiaECCy3JFVxL3tkzprvCEPkN0gmNKVH
	 fQXUKMILIrYqF/mwUalUtpclu8WAte+ALvk2WkQmV10s5TL4f6efQ4eh3y+aUVzNUa
	 urwZdn5rExjwQ==
Date: Mon, 25 Mar 2024 17:22:55 +0000
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 1/1] ASoC: soc-jack: Get rid of legacy GPIO support
Message-ID: <92f1cf44-3228-4eca-b8d3-39057c1150bb@sirena.org.uk>
References: <20240318202602.182619-1-andriy.shevchenko@linux.intel.com>
 <e6900b97-c1b7-45a5-bc3c-4a4a2745fdf3@sirena.org.uk>
 <ZgGJE0JNAESe5xUf@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LaK5P6dTv6keEyL5"
Content-Disposition: inline
In-Reply-To: <ZgGJE0JNAESe5xUf@smile.fi.intel.com>
X-Cookie: Evil isn't all bad.


--LaK5P6dTv6keEyL5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 25, 2024 at 04:24:19PM +0200, Andy Shevchenko wrote:
> On Mon, Mar 25, 2024 at 02:16:15PM +0000, Mark Brown wrote:
> > On Mon, Mar 18, 2024 at 10:25:16PM +0200, Andy Shevchenko wrote:

> > > If I am not mistaken, after
> > > https://lore.kernel.org/r/20240318200804.181516-1-andriy.shevchenko@linux.intel.com
> > > there is no more users. Hence the above is the only dependency.

> > You are mistaken, please try compile tests:

..

> > (this is among other things in x86 allmodconfig).

> I usually enable the particular drivers and I have compile tested this,
> but indeed, I haven't enabled _all_ modules.

> Thank you for the pointing out.

Especially if you're doing this sort of "I think I got everything" type
change it's sensible to do at least one allmodconfig build, it won't get
everything but it'll catch a lot.

--LaK5P6dTv6keEyL5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYBsu4ACgkQJNaLcl1U
h9BIMQf/aFj62j+vlTEFjnOpnzrhJuPYsepi2exphNqFVcfnMN9ktirXQXnxUVbl
wdDLnGpTE3NN3sQcALzox2VnvEPYrH5MLseFFG4GUOSSv6TJmb42/gf0LqAmzu6H
6dgqhFOUeMEyZyBgcs2EFSdL0jlTy6YV57gtCrNNh48b0wU6FdGMg3Cick9ZRDsi
GYquSuSXMrFb1RmXiMAm5WuS7NKnoWXh8ycB+yEU2dLWcqhR3m0DvpWACwPaDQsq
Z0hiqgi8mrXK256qiQg8p4YVJvXoxIuSOERjw/xG4yS661pex7UTIhd5FvtQXxTg
aLfT22n4snWG6I44fcJ5qMujrmV/9A==
=CNyB
-----END PGP SIGNATURE-----

--LaK5P6dTv6keEyL5--

