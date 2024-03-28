Return-Path: <linux-kernel+bounces-123145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 875558902EE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 283311F2829A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497EF4CB38;
	Thu, 28 Mar 2024 15:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qK2XdBMn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D38F8626D;
	Thu, 28 Mar 2024 15:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711639334; cv=none; b=sC2sqq/BgY04pYIx9bDwgD6fkv5g+nHmftMXaJqhH01uXYbCL7gfj2Ccz8+X2nuxC938Bd6dLeY/FVCZEoPUL9E1nuA7NZfvXYxhAiKXzS/vZgtDJkYgwa9bVhKyKibby75lr9ewZiaDhWEcK6NDbnHVqYsL+OiI1PR47GRZkGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711639334; c=relaxed/simple;
	bh=vozNlw6gpO1XJWv36UdylIBiUWYDdoPfKk5/j4lfe/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSG4Skujjf5hh2wiGbbtH00lZIwua+tbm+39UIukALFk4WqvYVdnRhYMTAOT6q4YJjptnFv8A8BMmDCimkqiZQaxVFXaoaA6Fg0lxmpvEmiqIyIOZ6msZV/D2v8hMJElhkaUv4R6XqtoVa1Seg8oxV5Bdsch0TnNAT6aTevtrL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qK2XdBMn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88098C433F1;
	Thu, 28 Mar 2024 15:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711639334;
	bh=vozNlw6gpO1XJWv36UdylIBiUWYDdoPfKk5/j4lfe/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qK2XdBMn83E6sWLnuqy7ufTtf7QtdwBq7TOHEVsVXuj5DlwqaNourPcQKQ7KkNUH7
	 iKb7WcFSeJ5lVoMNpSKFH3eoZQ6N7u2BJdtKEp+iPj+/yfhvzsXcIP18BSzIqoGFRv
	 sDchmBwBpXjAoI9EppNdn1uydU45Nbz+dXqDIfJ75JpuyPoyu5HXpY+oTjaidjUmqV
	 EiInY6rBB+IvT3NSTC1ZDVBRlkukMHY2LocTlJFQS6W0ExtrSFaBry3/otf3xk9apo
	 twLJNjuceeRGH8zrHTbAI0gPC3+sj8IhGE9iIhJOXO8orE6vpe60jIeLLAWjP6/Pu7
	 qxnm0sHCBnKsw==
Date: Thu, 28 Mar 2024 15:22:07 +0000
From: Mark Brown <broonie@kernel.org>
To: Seven Lee <wtli@nuvoton.com>
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org, linux-sound@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
	robh+dt@kernel.org, conor+dt@kernel.org, perex@perex.cz,
	tiwai@suse.com, YHCHuang@nuvoton.com, KCHSU0@nuvoton.com,
	CTLIN0@nuvoton.com, SJLIN0@nuvoton.com, scott6986@gmail.com,
	supercraig0719@gmail.com, dardar923@gmail.com
Subject: Re: [PATCH v5 2/2] ASoC: nau8325: new driver
Message-ID: <8278611a-a46f-4d5e-9861-67ff1084db50@sirena.org.uk>
References: <20240327075755.3410381-1-wtli@nuvoton.com>
 <20240327075755.3410381-3-wtli@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EYfydwHOIW727Hww"
Content-Disposition: inline
In-Reply-To: <20240327075755.3410381-3-wtli@nuvoton.com>
X-Cookie: Yes, but which self do you want to be?


--EYfydwHOIW727Hww
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 27, 2024 at 03:57:55PM +0800, Seven Lee wrote:

> +static const char * const nau8325_dac_oversampl[] = {
> +	"64", "256", "128", "", "32" };
> +
> +static const struct soc_enum nau8325_dac_oversampl_enum =
> +	SOC_ENUM_SINGLE(NAU8325_R29_DAC_CTRL1, NAU8325_DAC_OVERSAMPLE_SFT,
> +			ARRAY_SIZE(nau8325_dac_oversampl),
> +			nau8325_dac_oversampl);

This should really be a SOC_VALUE_ENUM so you can just hide the fourth
value rather than having the empty (presumably invalid) option.  Please
send an incremental patch doing this.

--EYfydwHOIW727Hww
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYFix8ACgkQJNaLcl1U
h9BlSQf9EyTsgJpalcSaLea4nqxS0rWOxqW45DemoZI42X3n4+1V/McyJUdeRp4g
uhtCOzVmY+IpsWRTjh7JkmXeCINHodUMWV9pJ5DNtnkssW0APQ3NTnNCcLfxyZMF
jDAj/Bp6Q+uZSI5lmoEhZ21bzefN0ysYMtrzEym5lT3EA4RCKDuuJEBY248mT/y0
21d/BmZpJfmbwqr5EkLBnYYSItkVtXu4+XRh8bPlL0RVGAv3EYLKLTq45wgsznbQ
UUqTz1+NWfeETQDMV3m2RcEafHiE2DBkb9ZptqtObVuXsx5DUyrnjGpSocfv850C
iPdllwLhZ2RkwVo1Rlaq17ockWjx2g==
=j0PB
-----END PGP SIGNATURE-----

--EYfydwHOIW727Hww--

