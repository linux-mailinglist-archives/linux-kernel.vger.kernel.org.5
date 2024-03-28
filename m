Return-Path: <linux-kernel+bounces-123005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 633EE8900EC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94B251C24091
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CA881ABE;
	Thu, 28 Mar 2024 13:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urzfM6hH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8128B8175E;
	Thu, 28 Mar 2024 13:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711634207; cv=none; b=Axc43XRQcA1i6B+7+oAN1dCWcvi9C+FDpija4U5BPGisn4ir/zPRgmbZmXaLwk2bgOwi+U8OlEA/8bI2xin+U8MPfPVcic0Y+uzkIGoDzuhjaXBczsWSwsxnFUcAamzgSB2dzs+OTGRFFZA3mkQXCyaZW+5gp4b+oAw/ueCyfVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711634207; c=relaxed/simple;
	bh=45W0j0SQwEbF1WEVuZJq+yF57n0rEsuSxnYCwbsjyaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LO8J3ulSd21x43OpfVp7005+T9kHqJwAdPS03JeMLjcqaM/egsCVgmILvlTXYEv2q4F12eVwIaU9gEezK2jwEs/M3ueCG11DL782uK8z/nrzxDlmcUFTQafsz3Itsl5vfFhHLyCus3nTzTdppQ3F9U2EgUBrFDtjGg0cLiQni/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urzfM6hH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC42C433C7;
	Thu, 28 Mar 2024 13:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711634207;
	bh=45W0j0SQwEbF1WEVuZJq+yF57n0rEsuSxnYCwbsjyaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=urzfM6hHSgtdOcXXX0qWKjzxnEn3cHDPfy8zymXAcdjTYxLfqY5EVLs2g9kLBrenh
	 bO1mKJWrcFoSkDNSsJzqJFH2o9JhOI4dY8RPeTJQSUCKZMGc7F31+bFAS0yBzj3QIh
	 cDtI7yrxHsaArBjZ/3YvR2RdvLhWObk2wuo+H0xTn+JxnKTH6b8jf4enVzudHN4mP3
	 mqkKt9nLuChV3ZGzzt/c6CNGjrkuW6+fqpQa8gH93XK/JepaWZeA41OC5Xh5L5w/gI
	 y1fKI0ajXiepiGfDur/A2zbxANS0QfV0oLoNCOhXahhoD8aLSNkTrEFaNR3vtIXN1F
	 CWNI3jdLTxf8Q==
Date: Thu, 28 Mar 2024 13:56:42 +0000
From: Mark Brown <broonie@kernel.org>
To: John Watts <contact@jookia.org>
Cc: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
	linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: sunxi: sun4i-i2s: Enable 32-bit audio formats
Message-ID: <9055efa5-8da6-47b2-b2db-d1f8e02d2267@sirena.org.uk>
References: <20240326-sunxi_s32-v1-1-899f71dcb1e6@jookia.org>
 <23447395.6Emhk5qWAg@jernej-laptop>
 <ZgTUIWh8qXH_7oxQ@titan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mhMUzKVvsxFenEfD"
Content-Disposition: inline
In-Reply-To: <ZgTUIWh8qXH_7oxQ@titan>
X-Cookie: Yes, but which self do you want to be?


--mhMUzKVvsxFenEfD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 01:21:21PM +1100, John Watts wrote:
> On Wed, Mar 27, 2024 at 08:53:32PM +0100, Jernej =C5=A0krabec wrote:

> > I wish it would be that simple. SUN4I_FORMATS is cross section of all I=
2S
> > variants that are supported by this driver. If you check A10, you'll se=
e that
> > it doesn't support S32.

> > If you want to add support for S32, you'll have to add new quirk for ea=
ch
> > variant.

> Yes, A10 doesn't support it. But it should error out in hw_params due to
> get_sr not supporting 32-bit, no?

The constraints shouldn't be advertising things that hw_params() will
error out on, sometimes there are contingent constraints that prevent
this but something that just doesn't work isn't one of those times.

--mhMUzKVvsxFenEfD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYFdxkACgkQJNaLcl1U
h9CE1Af+O5zsMVBYtNcP/Zpm6ZYtaVlBfArlIiMyRHh/rU2sZcHctfvD/5FpomNB
DX+B2CXJ54QN/AzVgK7q6QcMzryuK1xOLmjs6+THEHS8Tx6w4We32P2zGuGX655C
mqkPWGWOltacPI/1Upb0PogW3a1qfXuhvBWPtNfkaBvgBICtbrJiJyEyNHJozq2v
n94djp24WVSRt5Jjh0u6U/1Q7Eqt0FFiBtm10J8fdHjSt81CVIYz/jw5aZgCPY7l
NVHn77XPjEccjdx5hNGpNAEZT8ZZbIF0sC/HOKDP/OvypWpV1GRyA0Y5XwaJWnnD
NQcO169FnkN2RGXB1nbjkBEXAUbpQQ==
=cayw
-----END PGP SIGNATURE-----

--mhMUzKVvsxFenEfD--

