Return-Path: <linux-kernel+bounces-136866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DA989D92C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A63A61C218C4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D51A12D210;
	Tue,  9 Apr 2024 12:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZGUMMnV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F5258119;
	Tue,  9 Apr 2024 12:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712665602; cv=none; b=CItz4xod8XMRNfWlaYMNOIisvft8A9dtB1iSXosI/iApJtz20+pi+RO6BoWVx8dPWFrI19F6nAUjEzpSFBIUFzODcOYwQyd1y4h4W8NICST82IYd5lVC5ORMy4AA232CfpK+t8msGHleoTn0kxzZoKToTzjw7Kno9D0QFizCK5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712665602; c=relaxed/simple;
	bh=wqKD1B52YH/JhDRGOE9j56coaM/D+7JEAsq+fMNNxIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/Tk1aoZ5naOk0Y4yiT8BRronAHfdqOKsKwUPmePJ8G2YKcZttHf812zmrZr12tK30WZpwAvWSwZYebrSYHxbMpJTZMU89T90BU4ETn+Die0ZzK+jlba/lnugyHYETKnCl+/RIDdscUoHeKYx2xV7AxzGJS/Lapyuxm6A7Bu5MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZGUMMnV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6004DC433F1;
	Tue,  9 Apr 2024 12:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712665602;
	bh=wqKD1B52YH/JhDRGOE9j56coaM/D+7JEAsq+fMNNxIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YZGUMMnV+rUz/Q5qMykXPzBpND1OrRT/gZYyJlvcqNYbCNBg8ScRgkAtBb4JEeWaS
	 sTxTKkwGutDlNNTAfaK+GZG844dTpcvZo3K/gLqpVyf4gDHzj1vfsocIE1Mj7SF/dU
	 4s+nw9QI4I2pNpQNRdx1FMF4NSqeFf8gqtlWb4HmxolXnVgMwZdz5qJ2ExLo6OfWgG
	 Q1ukz3H43+5Wbr25XetJLtO0VOJqz9e2A1c3U11KHmfSQ69PWhnbmGHlcNeoS3rsEi
	 WF/B+OsgoVG2wiARkWbwi5ywRqL9NRU2o5pf+2figuSnI3Mig+aL8y8wharHVn0wPC
	 CNoQ5gjvTeSEA==
Date: Tue, 9 Apr 2024 13:26:30 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.8 000/273] 6.8.5-rc1 review
Message-ID: <3f68721b-ac34-4160-8c66-1c67483ff46c@sirena.org.uk>
References: <20240408125309.280181634@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6q1JIj3x0B4eshAY"
Content-Disposition: inline
In-Reply-To: <20240408125309.280181634@linuxfoundation.org>
X-Cookie: Everything you know is wrong!


--6q1JIj3x0B4eshAY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 08, 2024 at 02:54:35PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.5 release.
> There are 273 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--6q1JIj3x0B4eshAY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYVM/UACgkQJNaLcl1U
h9Bq3Af+Mge2/NHsz6NFBhqZhm80Kclx8Gg8qwW3tIbDpFCV3Q+8rt51KKztNTN1
G5jevvxgy3FQfRk5VpicPeBkDbSfpeTsZbPgzF82aBJz0PMVIuwLt+z+UheDyl79
5uMA7dSF77wzME5+CiDOO/QV2wa8j99mn6vL3ZtxkG3Xla1nAcwRHCzdZK1qfaEk
Rkze4lTKcniWHOXE4i1Xn7jNnMMBA07IRuZmv2/VvD5eK9ltzgQRLI61KZ3ZrWy/
KTuzRX74ffq63GEe0VRWWIwDd5ViVGWtqDbqNXG0HmDsb8VBTxAJY6EusyNfyoq3
9/itSMzIuq15Tn32mj2Ho8IY0a4Cmg==
=qzz7
-----END PGP SIGNATURE-----

--6q1JIj3x0B4eshAY--

