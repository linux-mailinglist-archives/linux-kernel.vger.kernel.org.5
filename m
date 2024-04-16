Return-Path: <linux-kernel+bounces-146030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B45C8A5F14
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 02:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A14C11F21B3F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 00:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A4680C;
	Tue, 16 Apr 2024 00:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="feCmQhBq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667AAA29;
	Tue, 16 Apr 2024 00:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713225934; cv=none; b=NuS1SWhdfRl7FN6kIK/PtdrUQr5Gebz4u8gapw5CVuh48XIOLsfTU4fflWeSp/PJMe9JdBFpyLVvcG5KW/ji2lGwFR9iKw5FoQOrkLvw6J5P1s8OzGkyyyjiJDmqG9RidsBBGf6m7TtWyc5qfQhK7PY8v4+SMP71jmk+q3Yo0UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713225934; c=relaxed/simple;
	bh=4/+E8MWH0scIfkTLokMepBoQUDVRnV+6k7hVAL/LWNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqJoqAB6MZQ5oZfYs21F/cx0jwP5KLQX+Tf+sYXFY1XRSQNanNyiRHqwf14vp1/rj0cQGqbnQlNcUk5BNenUf9TNj3H0yyaKNi+oM6nU4db/lfIFK/NxQQyT5Jv2LjxRB8erSGVls3xYTcBSUw3xCASX2tzhbXndfUnYo0Z7q78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=feCmQhBq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C54D9C113CC;
	Tue, 16 Apr 2024 00:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713225934;
	bh=4/+E8MWH0scIfkTLokMepBoQUDVRnV+6k7hVAL/LWNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=feCmQhBqh3uuCrpC4iwEcl8A6PgoiLvWXgv/C0h4qjfEWK+XZbQHRtVngwNmBmhlv
	 ED1gDWJpZHFDVDR0J6FTID+i1iSsG+z2dV0CO/HXiPv41zRwsQ3mpqkDdcTHnJXnZ9
	 EV+H2x/10OxqBq6JNKIhkWrjSJ6/gl10aDv74gaiLvcUc/bdWLbwP6jeK/O6Orkfvg
	 M/fUSGd1P4jnfHp0xQSD704eNo48BE0uu/LNgxuk5GtxHfnUXqk5AABlbqUjRlM4ab
	 BqR0NjShVqZdDTTeF/dpYd1uhnXDkKrTRMoNYDCQMcFH1jp+8dwGcH3dHnhh6vS4m1
	 WQI/VqcMpUvjw==
Date: Tue, 16 Apr 2024 09:05:31 +0900
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/122] 6.6.28-rc1 review
Message-ID: <Zh3AywUqfBB5wQgp@finisterre.sirena.org.uk>
References: <20240415141953.365222063@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7TaWovNwnimEJ617"
Content-Disposition: inline
In-Reply-To: <20240415141953.365222063@linuxfoundation.org>
X-Cookie: You might have mail.


--7TaWovNwnimEJ617
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 15, 2024 at 04:19:25PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.28 release.
> There are 122 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

I'm seeing boot breakage with this one on the Arm fast models, a bisect
is running now, for slow values of run but should be done by the time I
get back tonight.  It only seems to be affecting 6.6, the boot grinds to
a halt shortly after getting to userspace apparently with some
PCI/virtio issues:

[    1.606075] VFS: Mounted root (ext4 filesystem) on device 254:1.
[    1.608751] devtmpfs: mounted
[    1.627412] Freeing unused kernel memory: 9152K
[    1.627894] Run /sbin/init as init process
[    1.627957]   with arguments:
[    1.628009]     /sbin/init
[    1.628064]     Image
[    1.628117]   with environment:
[    1.628169]     HOME=/
[    1.628222]     TERM=linux
[    1.628275]     user_debug=31
[   11.764055] pci 0000:00:01.0: deferred probe pending
[   11.764141] pci 0000:00:02.0: deferred probe pending
[   11.764227] pci 0000:00:03.0: deferred probe pending
[   11.764313] pci 0000:00:04.0: deferred probe pending
[   11.764399] pci 0000:03:00.0: deferred probe pending
[   11.764485] pci 0000:04:00.0: deferred probe pending
[   11.764571] pci 0000:04:01.0: deferred probe pending
[   11.764657] pci 0000:04:02.0: deferred probe pending
[   11.764743] pci 0000:00:1f.0: deferred probe pending
[   11.764829] pci 0000:01:00.0: deferred probe pending
[   11.764915] pci 0000:05:00.0: deferred probe pending

(no probe deferral happens for working boots.)

--7TaWovNwnimEJ617
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYdwMoACgkQJNaLcl1U
h9Ce9Qf/X4Op0IbWBYzpvWM226i1ZK9X2E6Pv4RSY37YAGObkWEVLprZvcYOhnxw
oKMz+C2+ncGjDTcr/gWf+ngOnj9HR+qH6edtlvi/UU6EPpLTR4suRAjCmwHSdIr1
24U9UM3XFAPfsTnbTwuJVjFaOyUBfmBFmayrNifmxBy85doCWbGDKnVJ/ltUAwvQ
X3dCXKN7RBIT2oq3uNoFgAxTAboxymXlL3Au/XKrY9ge1eFz3s0RrhovnC7yZPhi
BZ9kgdTMTynujM/Zz03bhUADN6FaZMGjxLe1R/4Bm+H0XJIeK1ValZYSbHNPCD0l
H6OKgU/NKmKluNxkvgdxZtmZJqkgTw==
=KgX6
-----END PGP SIGNATURE-----

--7TaWovNwnimEJ617--

