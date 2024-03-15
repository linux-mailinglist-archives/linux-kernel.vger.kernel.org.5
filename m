Return-Path: <linux-kernel+bounces-104582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F022D87D06A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C4D81C22BBA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D935405F7;
	Fri, 15 Mar 2024 15:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGxd6Yh9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20263F9F4;
	Fri, 15 Mar 2024 15:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710516903; cv=none; b=mk1lcQ+qi6uBRXIDkYWsNbpM9DJuBuFkFGrknbAQNg7FOn+gOCMcvtqE5J8gVO0g/v6TKf/hUntO7/g0Cqck3RNIPkZHDen16Eu05JGOorhym3wMkYkSq+hVYyy2RptUN0Zd/ZyFgG2VB/+mDYH2EfXhlyGTR79H/aMUY43FkBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710516903; c=relaxed/simple;
	bh=kMvE945U6tZvf5khr6Zgk0+4AmsFWiLJKJFA3XanMDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hiXaRY94wbn1AxpBZnGF+sgK9+iGL/1IDkWyJMtAWt3liJlSkrUKt3GdZ3rXZ9LYS8gPXfpMil5KZzKJGvQx3BTbCbrHIRghk5dG9JuKFZHWjofVed1roVy+Rd6noILn96m48eRFNcYcdL4XZAXIIwRzB3Zs1wQkDn8HyV9ceNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGxd6Yh9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A00C43390;
	Fri, 15 Mar 2024 15:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710516903;
	bh=kMvE945U6tZvf5khr6Zgk0+4AmsFWiLJKJFA3XanMDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oGxd6Yh93OoOgar07GpQnyRiGlV5FsLGb53T7JYs5zqkg1kaksZWhP+O2Sgwi5jSo
	 viqqkeL74blcV69t45uvIXnZiSBpvLwF9CLvAZws7OWmalWkaKTuHedBe7ewBFd4S2
	 qPSSy/lgwbV81B+8WMbUalgzaidP7BinvrrckJN/kUMj8dDsEULwEzeOrINg7xdvP+
	 mmma5ll5yib10JW9sLJXT9IT+tXSSU/48pY3CS8ig5ZlxASs5kE4XDiFg6IBvHqe8l
	 DYLQYWNx4UcAHS086S6bmTzXrT69i86zaF/JT++NfTma/HkZMqQb57Igz3jD2MnFYX
	 qdU/oDVF4ZmCg==
Date: Fri, 15 Mar 2024 15:34:58 +0000
From: Mark Brown <broonie@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de
Subject: Re: [PATCH 6.1 00/71] 6.1.82-rc1 review
Message-ID: <fdcb4083-d18b-41ef-a29b-ab1f9fb8bae2@sirena.org.uk>
References: <20240313163957.615276-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gY9Vlt8Iv6TUAL0x"
Content-Disposition: inline
In-Reply-To: <20240313163957.615276-1-sashal@kernel.org>
X-Cookie: Best if used before date on carton.


--gY9Vlt8Iv6TUAL0x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 12:38:46PM -0400, Sasha Levin wrote:
>=20
> This is the start of the stable review cycle for the 6.1.82 release.
> There are 71 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--gY9Vlt8Iv6TUAL0x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmX0aqEACgkQJNaLcl1U
h9AwnQf9Hc6tXCghN0tarwwvf7pVi9DpywhHHyde9n2pzebQ+JHnOyG+d0JUJeOD
/Az0uk7WwQQxzVCCBnTAOCC0CN7uNvHHTs+Ox0N6USUsyTK1GudedYI6Qxs6e5ds
VDc46bXBcAptk9EX+fUEeWA3HHEe+orileF1nRT44ve+d68J/oGO9tdDCa0yGVoL
AXH0l60MweRSoYnjAJidhIJ0jaWzKs4TSkMld6ZkUl9a6rzssIHaOBShr694tpxM
kOwWrKJQ5NB4IhPg03DV1OT34kQ0Pn7VWpUuDN6iRvevIgIS5tRMPUac5Dsa4xKn
BQTwIlyHLd0SAb+22dXkokCa5J+HzQ==
=LXLx
-----END PGP SIGNATURE-----

--gY9Vlt8Iv6TUAL0x--

