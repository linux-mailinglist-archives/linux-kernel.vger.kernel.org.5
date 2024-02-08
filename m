Return-Path: <linux-kernel+bounces-58763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D4F84EB57
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E40851F25B1C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283BA5025E;
	Thu,  8 Feb 2024 22:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbWOSK3r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E84150241
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 22:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707430260; cv=none; b=lSo7TQaDnZHcDy5esmn1rgRChvrS8E7sGxxDDqN0OmftkDPYBT7PuKf2rn1ejWMh1yYfPMc+BMt2T+bNvLjq+pl1I7ubGeNYOIBUaLOBSZYF3Fb3BKLOlATicjuy68JApyUdogd1x3eO7/lFbgNOAYv3eEeHiZwxkC6BLM/uGZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707430260; c=relaxed/simple;
	bh=yzJpezCeJ3nBzYW4fUdRjXRlsN7fkNrzK5p1wECyDYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvxDp8LQ8RBU3N42rk0evgC6AHtGllLh+EiXg3itqBtZilr5x6oC1MxYq4FonTrkzj8y94+QaQKRX8CQ0FoBwweBoj6cf1ISSifATjlP1AOaXIYZa3vl6Vtqp1Ln8Qj7rYF60vI/phXn4T91oQLzwncHCSgZUEKdxljrvdBCAGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbWOSK3r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88BBBC433F1;
	Thu,  8 Feb 2024 22:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707430259;
	bh=yzJpezCeJ3nBzYW4fUdRjXRlsN7fkNrzK5p1wECyDYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hbWOSK3r09Bf/j9L9PmglwRIQKPtWMVJ9tNWvLtV3yiBmTcEHyfJV6dEF4vTxPdHU
	 C3EMXP+zP9s8ZXuRTV6tgVT+LzMdbXL4Q2uAXUiTaJVaU3F2AUqtvuYApv64BfqJHF
	 po4DQEERPMd/79AV2em8XdMYhi2QUwmlEycJwdo+1hErf1EuNwqsmh7GJtRdtlITKC
	 Dg/Y2QHaOc+0nBJ4wvb9LQDcIqLbtFTyZDaY5p2FAcEGRZK+Ew549FY0tIeatoih1K
	 Wgi0F8Wq0RWgZ/g8cWv2MVFk4u6Pk6HDxTHXQ2ANcCz7FDC/jqoDQobH38jw08herX
	 X8CHwelHUdWnA==
Date: Thu, 8 Feb 2024 22:10:56 +0000
From: Mark Brown <broonie@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sporadic regmap unit test failure in raw_sync
Message-ID: <ZcVRcH/D945GKWjG@finisterre.sirena.org.uk>
References: <dc5e573d-0979-4d7e-ab4a-de18a4711385@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HQTO+mQ3teLCiJty"
Content-Disposition: inline
In-Reply-To: <dc5e573d-0979-4d7e-ab4a-de18a4711385@roeck-us.net>
X-Cookie: You might have mail.


--HQTO+mQ3teLCiJty
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 08, 2024 at 01:45:13PM -0800, Guenter Roeck wrote:

>     # raw_sync: EXPECTATION FAILED at drivers/base/regmap/regmap-kunit.c:=
1305
>     Expected &hw_buf[6] !=3D val, but
>         &hw_buf[6] =3D=3D
>          57  30=20
>         val =3D=3D
>          57  30=20
>         not ok 4 rbtree-big
>         ok 5 maple-little
>         ok 6 maple-big
>     # raw_sync: pass:5 fail:1 skip:0 total:6
>     not ok 25 raw_sync

> This is with regmap: 'kunit: fix raw noinc write test wrapping'
> applied on top of the upstream kernel (v6.8-rc3-47-g047371968ffc).
> So far I have seen it only once, with the x86_64:q35 emulation in qemu.

I guess it's possible that we randomly generated the same value for the
initial and modified values here?

--HQTO+mQ3teLCiJty
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXFUXAACgkQJNaLcl1U
h9CZFgf/cwA8c8e6uLjTjSb+89vO7pBOcs46jue8BAic0o2eqVfIJelx9JanpNMI
d+nrawOOopDN8nNRK5dQ85RimY/zPADDWOtdEkydlhqbi8do9FditnjebQY9s3ma
wQTERNsIYQwGajwcQ/CzVnqz6PJ10hEiaUQBGVUfen5G3nIai8BNUHks9RugL8Fz
vdA//D+DaKvGkSmcoRw5FvZ3DbT9tWMUiD/7bGnJv8XlrbpSHadPsr9AsUDFgZ70
IS9ZEVu19H75wWF+J21XRdJybJ+PqMQrDuyBAaNm4ouStWghPYUL2MKjxb/ZHbfO
E/uOxdaEYr7cN8tGUlVMrApC7GkLvA==
=k2rr
-----END PGP SIGNATURE-----

--HQTO+mQ3teLCiJty--

