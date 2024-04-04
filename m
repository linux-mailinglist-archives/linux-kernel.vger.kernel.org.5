Return-Path: <linux-kernel+bounces-131547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02774898973
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B167928446B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF181292E5;
	Thu,  4 Apr 2024 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6FG659e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A741272BB;
	Thu,  4 Apr 2024 14:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712239310; cv=none; b=TKgFa3ygp3lSQyQW3IT5h2JCc0/GkXFj9qyBsezpiQ9MFf6ozQ/D/nXo7ANRWc6C1YQ0tmNnJ9AzJNjmtiZcPYxQLa95Eahs005ZxhpaTEUv6GpfjW6XZVwZdUCOKxdpogAJxYH6t2SN6qn2w+0zJjK9FHd4Cmct7qCTSeAjz4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712239310; c=relaxed/simple;
	bh=EDLFFNlDIwfirM9Ysf0HpN0b6M3HqKIXDP1hJ7mbtIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qm7m3jnNsfaYicIMYMwywvpDIAMXhVqFOHX4rvBdlO5n6Th4cNtRQO/r+G9HhUDpUXn9MJhf6GBLh4wEUFMSPxTYqDeFvWiPsJzR8gztURj+EnSdF05ZAJPBzRcSlBg/tQ/znoNyJqyNUcZcCAH5C3fzIiQDe3gK+wxCFsS/MNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6FG659e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C4EC43390;
	Thu,  4 Apr 2024 14:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712239309;
	bh=EDLFFNlDIwfirM9Ysf0HpN0b6M3HqKIXDP1hJ7mbtIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H6FG659eiwMvgb9rE74Q2t2+mb0R87kC+Wkt4eYFKoJF6QFseyX2nBlvxuyKNiL8L
	 WwlK22ez++JGaNqgKFsLCgPK95RaPxQdrjaBXWhcG9OL3BsOuJvMh8/kvKj/AfHAhl
	 X9qq8/66PtJ0uWKqrJfbBeCe07prAGa47FNrYsELtmzhVa1Y8b8sBwWCfWuEtwTQOy
	 xDqk98Xn7jFaztO8C/MvUcMHU/g4SaKo2JtZ0vx3GyGgbqBBDK66M1OmpbYh8/QTFs
	 YJVFpHZxr61wqnYR2hk21arnzKOmqHvGgWq+dS4yMXWKjahjwbvSpjHKtyntIYciYX
	 XSGUuvkGrwsLA==
Date: Thu, 4 Apr 2024 15:01:43 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 00/11] 6.6.25-rc1 review
Message-ID: <f6122d69-ffe8-42cd-8881-8b6ff0d672da@sirena.org.uk>
References: <20240403175126.839589571@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sBD/GiIq04YLFs8U"
Content-Disposition: inline
In-Reply-To: <20240403175126.839589571@linuxfoundation.org>
X-Cookie: Buckle up!


--sBD/GiIq04YLFs8U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 03, 2024 at 07:55:49PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.25 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--sBD/GiIq04YLFs8U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYOssYACgkQJNaLcl1U
h9DJ1wgAgG/dtvIuol28XtdE7UShOmDjvKHM+UZUhDyVdv9zwl61nWf0yNR9vSzH
+eMCpLvTnQpwzi4prjvQqKphxP7Nyre3A1h6Rt5NAxEtHAaeoHMfV09ewANZJYOF
Vx5z9p3lcpVTd8lvM6ebcaDvQiwIecIjvkA4rdrf/0AnUW1oOdNzx2SB3Um6g7sK
d7vDUhqfsUL7Vb+CrB/y0iY3EzzZrcIlCvrxkQw0PJWdW2F4wuKLxoy2JdfSySOU
V/0uA1BRj8bgtTbI0KahxwtRbbDRU8mM5fRC/zG4PMP1AIPYVuL3j0/MWnGvv+sd
o5UkkJii0Un9atowWsCp/E0/qrZibA==
=u3Ko
-----END PGP SIGNATURE-----

--sBD/GiIq04YLFs8U--

