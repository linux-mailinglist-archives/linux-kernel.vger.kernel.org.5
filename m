Return-Path: <linux-kernel+bounces-143269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5708A3677
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04607B23742
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492F8150990;
	Fri, 12 Apr 2024 19:46:51 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1997C446BD;
	Fri, 12 Apr 2024 19:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712951210; cv=none; b=Ua8+UgbNnzIO23C0SbIeTN2jPUdkp3NPkFEbccleGOMJqbS06HWy13h1aKTBr1dw4kTWk5IGEzyUUTkutf3MN9JKhpf52qCQ+XfG17aAZQGAb7HdpbhpzwFNdO8mN2MP4r5lsptjKCzQR6erO0g/nD8wP7Zk0DqnLWv4Msw7eDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712951210; c=relaxed/simple;
	bh=XnUrEkoHFPhR4diIWtplmjQl0KVV2B+fVMTBj+eA3Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TS1nlcJRMifforFzuRlxzHqv2xOWaMgriYW4aOwAwJ1FjxPHpgLPP+qevVcrNGlBsdEbQt3EIbyQ8GmIX2yuWpZcZ5onz4eYMx+9HSr+UFGN3lD3J3qSJhGrSSIpls7ykYyRNTlSaf4lTlJ4g6NFKr8rLqhps2vVNpESwDApofw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 172A01C007B; Fri, 12 Apr 2024 21:46:47 +0200 (CEST)
Date: Fri, 12 Apr 2024 21:46:46 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
	maco@android.com, tglx@linutronix.de, christophe.jaillet@wanadoo.fr,
	sean.anderson@linux.dev
Subject: Re: [PATCH 4.19 000/175] 4.19.312-rc1 review
Message-ID: <ZhmPpo+EI9Ce3bI1@duo.ucw.cz>
References: <20240411095419.532012976@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IWHESQAOlY1kgx+/"
Content-Disposition: inline
In-Reply-To: <20240411095419.532012976@linuxfoundation.org>


--IWHESQAOlY1kgx+/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 4.19.312 release.
> There are 175 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

> Martijn Coenen <maco@android.com>
>     loop: Remove sector_t truncation checks

AFAICT, in 4.19, sector_t is not guaranteed to be u64, see
include/linux/types.h. So we can't take this.

> Thomas Gleixner <tglx@linutronix.de>
>     timers: Move clearing of base::timer_running under base:: Lock

AFAICT, we don't have those NULL assignments in expire_timers in
4.19. Can someone doublecheck this? We also don't support PREEMPT_RT
there.

> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>     slimbus: core: Remove usage of the deprecated ida_simple_xx() API

AFAICT this is just a cleanup. We should not need this.

> Sean Anderson <sean.anderson@linux.dev>
>     soc: fsl: qbman: Use raw spinlock for cgr_lock

As we don't have commit ef2a8d5478b9 ("net: dpaa: Adjust queue depth
on rate change") in 4.19, we should not really need this. Plus, 10msec
under raw spinlock is quite evil, such kernel is not realtime any
more. We should not be doing that.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--IWHESQAOlY1kgx+/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZhmPpgAKCRAw5/Bqldv6
8p7jAKC1wg9cT7GCMWzsEHEwhuwzFSfYkwCfdjnujTG6NWr2akCF44/qcO/dweI=
=pWcx
-----END PGP SIGNATURE-----

--IWHESQAOlY1kgx+/--

