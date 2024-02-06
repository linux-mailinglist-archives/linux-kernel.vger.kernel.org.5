Return-Path: <linux-kernel+bounces-54698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 801BA84B290
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31947287AC1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174941EA71;
	Tue,  6 Feb 2024 10:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmID3Hp2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A701AB810;
	Tue,  6 Feb 2024 10:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707215715; cv=none; b=ikzkYur0bE/L+hOycmxmtmh1PhQ2KDCKJrPRkrvBLmzK+4zijrLIZhiCtuFeNVkGwuIbfzEp27vcZ1BM0kYLzKR2IvRAoVNtio5LypS0Dze8kbQTJm/x4qkDJEjBaXkkRGM7wP3A97IxHZPB6Vhi/HBUlV8P4Y0BYWI0J7oh/9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707215715; c=relaxed/simple;
	bh=3c5PNyqEGTv1ShH7PDfncWm8E3oj2yIaY/8aKD+F4Hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AoUFshmuY1tqJlB3rT8hLsFvSvR+tnvmobiDNdClZRF3ohuJM1PS+q4LAl73/WTkuCmng1f1QKbw587+ueXywbv3lExP/V53DZqxZVQgCjVSe8q948d89qojaH6RMstrNkBXlTq6iXXXExJwl4dDA86AoQziCpSi12YHLhtYgVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmID3Hp2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C97C433C7;
	Tue,  6 Feb 2024 10:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707215714;
	bh=3c5PNyqEGTv1ShH7PDfncWm8E3oj2yIaY/8aKD+F4Hc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JmID3Hp2rCViqbulMK+0TZTIic7I+aL8OH7r4vok0IY74BMh4kkpLyw6qUzouGRkw
	 GrfY5+NqmV6SdLrQI+1XyxinOUwkxrRBQ0qn+YiS5NUyNPLqyqNj1nG0wSs8YwcgVL
	 DTN/IGYwwLO68yAL+0PBTjXcjF/94nYr4CeGgunpAtia3EUCBe59ACmxsc/s5iK784
	 TczoddAZCVLMp3JNN8MbfjsGi/KHWe3vBC+y+bNB8NSwEU480sHq008K6ppIhYuwtY
	 0HkQroYlE0y5nv5y220QIxdtFuTVesUiS5KHVYvBlefWtkgx+mLYF8yy1ccHouE4Sh
	 WON6q44+gU3kA==
Date: Tue, 6 Feb 2024 10:35:11 +0000
From: Mark Brown <broonie@kernel.org>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Miquel Raynal <miquel.raynal@bootlin.com>, yen-mei.goh@keysight.com,
	koon-kee.lie@keysight.com
Subject: Re: [PATCH 1/2] Revert "spi: spi-omap2-mcspi.c: Toggle CS after each
 word"
Message-ID: <ZcILX84KZpGKgpgl@finisterre.sirena.org.uk>
References: <20240126-spi-omap2-mcspi-multi-mode-v1-0-d143d33f0fe0@bootlin.com>
 <20240126-spi-omap2-mcspi-multi-mode-v1-1-d143d33f0fe0@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="azcLN1ODoDsB9Bpu"
Content-Disposition: inline
In-Reply-To: <20240126-spi-omap2-mcspi-multi-mode-v1-1-d143d33f0fe0@bootlin.com>
X-Cookie: You might have mail.


--azcLN1ODoDsB9Bpu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 06, 2024 at 11:00:49AM +0100, Louis Chauvet wrote:

> Revert commit 5cbc7ca987fb ("spi: spi-omap2-mcspi.c: Toggle CS after each word")
> This commit introduced the toggling of CS after each word for the
> omap2-mcspi controller.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--azcLN1ODoDsB9Bpu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXCC18ACgkQJNaLcl1U
h9CFPgf+Nzd4M6GNRWfxi5aN6tQuav9R23DvP/f+fald06ePtIKSmAE/E+ibjvZ8
aNKSzYLZtP5jMvadm0s+ySmYZ3Q66OvL5UarJRJo8oiLTt9ULtYvu10xXmLLpvn2
9sjtYniFp700x53wz/7E+ixz23dBmMoO7nXmP5eHk5LMpW8yr2Ct7qe7CvvbhLGd
PdZNp3Zeko7BR4xPF2DcSoOEVIBVu16RV3QiMMlVVxdP9gYKx1wv3Uqy4hVR6z3L
DYqiCbl9wwIQZQIb0mpWh7zCReHxLszElRle48qYgFOwG0zAGGkPzJAA65KicvUZ
uTGQABpF7+AGuD1Wdq01Z76liRLtkQ==
=h/jM
-----END PGP SIGNATURE-----

--azcLN1ODoDsB9Bpu--

