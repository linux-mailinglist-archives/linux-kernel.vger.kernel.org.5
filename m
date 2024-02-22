Return-Path: <linux-kernel+bounces-76811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9638A85FCF1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4D1B1C22396
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2F314E2D7;
	Thu, 22 Feb 2024 15:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omK6Fsoe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9B814AD14;
	Thu, 22 Feb 2024 15:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708616861; cv=none; b=a9rhL8LSm5j8mAm7k4ZYreSbv47m2F4R5l0DCZxdQBjFWlpRUQzVoZMuF/tWPfY+Wn5HMEnmcR+vOtz/DtdU/CU6S52iJ129/VVzPcZcUC+AOjJHLe9mMGY/R38Sj0rf+VphknIzWpYwdr3+Np81pVDDrovmgFLjACQAycZkIKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708616861; c=relaxed/simple;
	bh=ZEQ3TuXtQ1HZkjiFkZjRQexbw/7ACSFzMu3l/emJLw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sr8RvvqbcLCSYDRFAYDA0ePsHh6rTYrGFLFKqIocNrr3twlITyjk8c+VFiHhNbw9B7nf8acz7bBUjNhlpB0KLf3tMZuKzWp+rHOIEx4BEeVp3q4sIlZ8dsY+3cVfrZ+F5JdrR0n8nK/vb9c1pz6ZebK15u3wQ/gZmIEFEv0w938=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omK6Fsoe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6015C433F1;
	Thu, 22 Feb 2024 15:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708616860;
	bh=ZEQ3TuXtQ1HZkjiFkZjRQexbw/7ACSFzMu3l/emJLw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=omK6FsoeI1CmcgHU2vWay4w7nXK5X5mgurfwE4sCPsXzV9xD+Lp4QAQ0l3QK+/pxQ
	 yAQ6eLf2uMyhLXrzIYkQ9L0gpvbDeHB1T9K5uUTygvHOx7y4/iTUAsCGXts4mTq2bS
	 3ZRZVBE9nRGheoUYiNLPMFIfZJCpZH/hEOmoUz5CjMlU72RmUqGyNyO/vKa3OD0zJ/
	 3BQpJ4XsBfBdidPZ3DS/NnVQrOaoyEbCbwFOZViSd6Zi4M1SzKhRM/x/z89vqW+9Tj
	 s3A2tT4ChwWY7yU6ewZipVDWRytyaGLQK1lTBP/BBKJaN0lugY6I+0j0gDzBJ1RuzG
	 L/hq2ck9YkSBw==
Date: Thu, 22 Feb 2024 15:47:34 +0000
From: Mark Brown <broonie@kernel.org>
To: Seven Lee <wtli@nuvoton.com>
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	robh+dt@kernel.org, conor+dt@kernel.org, YHCHuang@nuvoton.com,
	KCHSU0@nuvoton.com, CTLIN0@nuvoton.com, SJLIN0@nuvoton.com,
	scott6986@gmail.com, supercraig0719@gmail.com, dardar923@gmail.com
Subject: Re: [PATCH v2 2/2] ASoC: nau8325: new driver
Message-ID: <6ffb4165-95e0-4ccd-868f-8ecda56b4079@sirena.org.uk>
References: <20240222083825.190854-1-wtli@nuvoton.com>
 <20240222083825.190854-3-wtli@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e7yScaGYIov+nAEz"
Content-Disposition: inline
In-Reply-To: <20240222083825.190854-3-wtli@nuvoton.com>
X-Cookie: I have accepted Provolone into my life!


--e7yScaGYIov+nAEz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 22, 2024 at 04:38:25PM +0800, Seven Lee wrote:

A few very minor things below but basically this looks good.

> +static int nau8325_clksrc_choose(struct nau8325 *nau8325,
> +				 const struct nau8325_srate_attr **srate_table,
> +				 int *n1_sel, int *mult_sel, int *n2_sel)
> +{

> +proc_done:
> +	dev_err(nau8325->dev, "nau8325->fs=%d,range=0x%x, %s, (n1,mu,n2,dmu):(%d,%d,%d), MCLK_SRC=%uHz (%d)",
> +		nau8325->fs, (*srate_table)->range,
> +		(*srate_table)->max ? "MAX" : "MIN",
> +		*n1_sel == CLK_PROC_BYPASS ?
> +		CLK_PROC_BYPASS : mclk_n1_div[*n1_sel].param,
> +		*mult_sel == CLK_PROC_BYPASS ?
> +		CLK_PROC_BYPASS : 1 << mclk_n3_mult[*mult_sel].param,
> +		1 << mclk_n2_div[*n2_sel].param,
> +		(*srate_table)->mclk_src[ratio],
> +		(*srate_table)->mclk_src[ratio] / nau8325->fs);

This should be a dev_dbg(), dev_err() will be very noisy in normal
operation.

> +static int nau8325_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
> +{
> +	struct snd_soc_component *component = dai->component;
> +	struct nau8325 *nau8325 = snd_soc_component_get_drvdata(component);
> +	unsigned int ctrl1_val = 0;
> +
> +	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +	case SND_SOC_DAIFMT_CBS_CFS:
> +		break;

Please use the modern _CBC_CFC defines.

> +	ret = regmap_read(nau8325->regmap, NAU8325_R02_DEVICE_ID, &value);
> +	if (ret) {
> +		dev_err(dev, "Failed to read device id (%d)", ret);
> +		goto err;
> +	}

Probably a good idea to check that the device ID is what we expected
too.

--e7yScaGYIov+nAEz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXXbJYACgkQJNaLcl1U
h9B1UQf/bbkyPq72hB16DeF5r7ZEpD8pxmWbH7Z+fKteU+6U295SCSHqnxBE+KX2
taIj/NfQ5964S9buK72KAeaiwI4o7d6duiqXCiy2vlLIBe4X+RBG4Ch+5E7SUdAu
ovjwmHLvfyJPCqcflNpxDQ35sVOrph6kFTi7UywOiY0X3oWAnIMuQK/wnGq2rfgB
tSKpUJU9AhGUog03Fg8D4kK+5SuQ5Wb6kfUfrYbDLrrxSxQeAWlgLuTJ84RDZ5gq
QAoLemPwWspvf8wLK71i22ETnllb87XHFzCuRv9ZXlqckJOjHSFHBHNcBGIAjXqb
2cMhEzQZj137Wwu6n+Dc8NE5g9hO4Q==
=9vMY
-----END PGP SIGNATURE-----

--e7yScaGYIov+nAEz--

