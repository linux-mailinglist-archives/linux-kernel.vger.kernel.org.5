Return-Path: <linux-kernel+bounces-157002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 032858B0B72
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91C7A1F28038
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D741615D5A3;
	Wed, 24 Apr 2024 13:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flSOWuRt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201C015AACF;
	Wed, 24 Apr 2024 13:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713966535; cv=none; b=uoPVoRPQ/T8VOSeL7KMlX4n36ioCA0IRksC6n5C90/Lc0PZc6QNNbd2kVhKhYvpOGUX6aMKxFGmkjRH1ulFp4hssR6yMsawj0QBB6mbnBuyJdnUYP87B3wR4m4neUmkwSrDyC5sVHuwD2YD4VN42BVBvqPv/WcK1e8NHMhVaEmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713966535; c=relaxed/simple;
	bh=6w8i6w4TBVCrz2y3Mcdnf2EsQscEUP34hICfm1CiJ5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3elHDeXCJgrvzijwswrHGiqoAZmtMIwCsCDY5ozS4qV2WeXhMD8JBzPOq68lzSA53KxDvMescBUPo3TJponf29EIOROoGf/T+WhkZONvVSQEusL1DgBSip+h9NxDxvFo9Y2WE7svY1gaoyTzl2qXocjQqu9e+SDzMRTXmZ4p8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flSOWuRt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209C6C113CD;
	Wed, 24 Apr 2024 13:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713966534;
	bh=6w8i6w4TBVCrz2y3Mcdnf2EsQscEUP34hICfm1CiJ5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=flSOWuRtLrR8ryXfiMy7WStAO8aWwBdjWogqY/xdy+oOUftEWcmGmXU5MQJEz1rCf
	 wyoZII6uJ+ciM9RgNpgP9zRYf7Z0MLlfaEaalFCa4HX8Lkl1jDg1jL+DTdQDhhnq11
	 18h+tmpVU+hHPhddJXW7xseSqd4Y0dkieW9CJW8m0Hl1MwX9AdC66fYRU16pkgRKm5
	 peJP/OOIGJAfvN2fxD79piQ0p9CkJCrR9xfQXawcaw4letw43BOsBLhjI1WC84CFmE
	 PLvd2JWGbhZH/XDumczgWEeP97zOYWY4WPCCqS+kmAWff5+U2MIPJf8CrmvB2fQfu4
	 a3RtiUDeKabWQ==
Date: Wed, 24 Apr 2024 22:48:50 +0900
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/158] 6.6.29-rc1 review
Message-ID: <ZikNwksfty_Y_dhi@finisterre.sirena.org.uk>
References: <20240423213855.696477232@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XPl8BteCIIBXgijS"
Content-Disposition: inline
In-Reply-To: <20240423213855.696477232@linuxfoundation.org>
X-Cookie: TANSTAAFL


--XPl8BteCIIBXgijS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 23, 2024 at 02:37:17PM -0700, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.29 release.
> There are 158 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

This and all the other -rcs break the build of the arm64 selftests due
to this:

> Oleg Nesterov <oleg@redhat.com>
>     selftests/timers/posix_timers: Reimplement check_timer_distribution()

which was identified as breaking in -next and fixed with 16767502aa990c
("selftests: kselftest: Fix build failure with NOLIBC").

--XPl8BteCIIBXgijS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYpDbIACgkQJNaLcl1U
h9APagf8DL4IpEx7MRazS4EhrWR79J+ZKIsxNThOseq9OdCB9bDlm1mL02MXcMVe
bF7lmOuErHEzkF0n90EocpUY8Zow0biBhbUd0PnbbTIViyo2GYUm+HRYLh6F/aEQ
05iqnCrNGRD4gaYozG6Ufvqc2oaqouWZsTMa+WAR82bQcv9xhHhaa8Orpz6X0LLz
fS1fcZHbb5Ga+4Cu+Xo81SNgKpoT/fbAy/vTAhsHjf1IG9J8DAkV5ACHrMnEBVpS
eOwA8ziojHSeAtPHeho6lyDUUa69+oANX9sglfVrTo1D2tmOHgBpWrZJU7pKT8M0
HvZOBONrKH5e018Y21sT/mc5SgdaJw==
=hAIb
-----END PGP SIGNATURE-----

--XPl8BteCIIBXgijS--

