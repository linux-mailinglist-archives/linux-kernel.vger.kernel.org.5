Return-Path: <linux-kernel+bounces-35972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA841839954
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29C851C255CF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDFB81215;
	Tue, 23 Jan 2024 19:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TR5/obcd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A7F481DC;
	Tue, 23 Jan 2024 19:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706037241; cv=none; b=tuT4wB9EoW/ATeKuvFdnIWvC6OmH/KjYH4xHT0y5gc90DDrURWxbOXzBx/GiH3PzVovMYGwymutEXJFpWjiC1DMcn+3LMfxNCYDGf6txdBJcUozqQJdxs9UeMVFMeeYRi9IAdC4X6gZLxDakLRh0VZMnt8YTp5CS+4EFI/ec6os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706037241; c=relaxed/simple;
	bh=Oijw2mPnsGQxqdOnmwSluoedvOV45guwWoQ6OhYQUoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSfgAYqg+YsSAoJOfhtr3pbSWJ5jYn4JMEao0jxB3/Av3R+sTULHWnjlKYUNiDvRQqkelsrMPkfcmPd+6AjpGo9YRWT58T26xbr+PkFNLDlUQ/os2vCaCl7RlU3Plx5laizpUmSbKeVuG5+WFQrBtcLUiOD06I6VvfKGVn6RZK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TR5/obcd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D908C433C7;
	Tue, 23 Jan 2024 19:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706037240;
	bh=Oijw2mPnsGQxqdOnmwSluoedvOV45guwWoQ6OhYQUoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TR5/obcds3kYwRGzVZli1bcFhOcKx5nnLWF5IHRRURUkWHCmvY/+z/PbKXJuDZD66
	 DANzIi4ztzbJyfXsSpU7wlyF0QwX/ycIFAgUED8dMF1PfbwdZcgBd328lGNakEkjPG
	 UcSZOuE2M7wjazt3Iaclw4kI6sp67IKbYIyaGxNCYYQHkMWo1BI1HBFrDqU48AwX84
	 96cOFvgHHUVCXeh3YE8J3+AFxTNd+rR5rN55Dcr5IIrMHkpuUxGlFhKNQJ6SYqhw0j
	 mhQApamcUbuOe1wi3AwlZi2T6X2C43PJQ0P6slE1+6XvNghOiNpLR3B2mDAEc9GAkP
	 GN39x7iRY/6Ww==
Date: Tue, 23 Jan 2024 19:13:53 +0000
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Shenghao Ding <shenghao-ding@ti.com>, conor+dt@kernel.org,
	robh+dt@kernel.org, andriy.shevchenko@linux.intel.com,
	kevin-lu@ti.com, baojun.xu@ti.com, devicetree@vger.kernel.org,
	lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, 13916275206@139.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	liam.r.girdwood@intel.com, soyer@irl.hu, jkhuang3@ti.com,
	tiwai@suse.de, pdjuandi@ti.com, j-mcpherson@ti.com, navada@ti.com
Subject: Re: [PATCH v1 3/4] ASoc: pcm6240: Add compile item for pcm6240 codec
 driver
Message-ID: <8989fc5a-032e-49a2-b55f-9e7a526d8649@sirena.org.uk>
References: <20240123111411.850-1-shenghao-ding@ti.com>
 <20240123111411.850-3-shenghao-ding@ti.com>
 <08809d8b-a474-42e8-8a25-edc94e7d9723@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6AcwafjYfkmuuvQ+"
Content-Disposition: inline
In-Reply-To: <08809d8b-a474-42e8-8a25-edc94e7d9723@linaro.org>
X-Cookie: Stay together, drag each other down.


--6AcwafjYfkmuuvQ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 23, 2024 at 12:25:33PM +0100, Krzysztof Kozlowski wrote:
> On 23/01/2024 12:14, Shenghao Ding wrote:
> > PCM6240 driver implements a flexible and configurable setting for register
> > and filter coefficients, to one, two or even multiple PCM6240 Family Audio
> > chips.

> So before you added dead code? No, please add a working code, so squash
> the patches.

This is a fairly normal way of adding completely new files that are
split into multiple commits for whatever reason, and given that the
main C file is 2600 lines and the header another couple of hundred I'm
not going to object to something that makes them a bit easier to digest.
This is especially true for a driver like this which is handling some
hardware that's a bit interesting and therefore has more complicated
code, it's not all big data tables like many ASoC drivers.

It'd be even nicer to have things done a bit more incrementally in
logical blocks but every little helps.

--6AcwafjYfkmuuvQ+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWwD/AACgkQJNaLcl1U
h9CD4Af/fu+SJnY++tUuDbtG4I57I0AjyiLnU2S/XRrj/F6oiPE3qWRORdxIt9ep
5pzcfS3KX2w7a+NLsHlF/3VcDng+TLtqjRTKOq810il5MvviQ/UQ8uVrK0TE/ZN6
tL+x9gfCYM/sE2Cz9HjClYjKSglg2xXDZ6IuBakesvRj+bJ9yaRSzZOulknv9YCk
ztFl4NHf+Hfr69IsK5vsTj89DE65Lexmjv9GjRnAUdIFuAKVlvLU5GW32i+AO+db
rCaG0AgD0WGLhZmxiUdJZyBAp6dXH6+FBHZkcJ2C2nAo1fEErPITLJhJ427/+ED4
GBNiJ5jTohK29ac3f00qcK6CWEqO3Q==
=u/Cs
-----END PGP SIGNATURE-----

--6AcwafjYfkmuuvQ+--

