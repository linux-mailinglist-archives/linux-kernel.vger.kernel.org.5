Return-Path: <linux-kernel+bounces-51017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 900B7848514
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 10:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4622288E7C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 09:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B4B5D735;
	Sat,  3 Feb 2024 09:59:21 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112EC59B6A;
	Sat,  3 Feb 2024 09:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706954361; cv=none; b=AMVTq6A06d2yHX0IP1emmqW+EZkjCYdhx1nO7FbPfFB7052j4SCd+NQ9YfD3kW43k07cO/RzKgHKPe2NAxsP61tYKZp3LA5fDTN2xGKpVF6rjnoCywQLH82W5P/LYYw4pW3x6BgWxdlljvmDfd09lu5j4ITaG+VML2oMX8hVSh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706954361; c=relaxed/simple;
	bh=BKWxSZF+A8z9CofVmYuOHESOuQOtgXbFK2MyqfwghH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mude841nBjvuNyHKSOcs6jNo6tN2zrwyeE67BMiH75QhZb+qGyjBP5h6goUslTH8jZSbEatPFvru8KfTx0byUig2B8SMxZXJsASIsbA5O3zCHUsNZd6IqE75N8zjqwCuNxgEQKJB7oVykAf+UgLDmFrYzu6xnb8pN4WZW+zqwvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id AE84D1C0077; Sat,  3 Feb 2024 10:59:16 +0100 (CET)
Date: Sat, 3 Feb 2024 10:59:16 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/322] 6.6.16-rc1 review
Message-ID: <Zb4OdNGmklolM9R3@duo.ucw.cz>
References: <20240203035359.041730947@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wZUaUqhFTlgZqP4l"
Content-Disposition: inline
In-Reply-To: <20240203035359.041730947@linuxfoundation.org>


--wZUaUqhFTlgZqP4l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.6.16 release.
> There are 322 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

6.6/6.7 seem to have build problems, likely same ones others are
reporting.

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/1=
163145567

BR,
								Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--wZUaUqhFTlgZqP4l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZb4OdAAKCRAw5/Bqldv6
8s0aAKCnp5B56++AL07HcDdc5CjWv4YcEACeNoGC04ANDNE7SW7Xy0pYmbL/G68=
=uNVW
-----END PGP SIGNATURE-----

--wZUaUqhFTlgZqP4l--

