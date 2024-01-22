Return-Path: <linux-kernel+bounces-34111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE378373B5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D95C28AD67
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6644D46442;
	Mon, 22 Jan 2024 20:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpWIrWI8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA45C41779;
	Mon, 22 Jan 2024 20:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705955292; cv=none; b=fVtOp2ByIbIty71QaMUtbsk34ZMOMXCdNNwIZkLG4FOv5cjtWQnL2LChrWJuKwnZb0EWgN8RwPtA7JDulI5cG2KQlEfAdesDOyVbTwCD42PlS0PdjgNV3FtRuRJORs/S4QcDMdX2VOTD8wwyS4n+6UvXknlbDloAZrRHuRNIuss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705955292; c=relaxed/simple;
	bh=uN71bCXA30X74Or5WgrlOA05l7pdmTn+Pla2tjReuL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+ffVVeNSyLu/KxTdq6/jKj2AFeWodS8PUgP+hnUh+lTL1vog/aYGsurBi7O2bg6wChuPezVjW28u3GkC9Eo2lk6w8ZKca9tA85nc0QA/tH30VuppHxjrX8us7hMcVpA7C0e5xKH6c4EgtXjExW8dFzgMG0O5Y782eq03xtlDjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpWIrWI8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F62BC43390;
	Mon, 22 Jan 2024 20:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705955292;
	bh=uN71bCXA30X74Or5WgrlOA05l7pdmTn+Pla2tjReuL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OpWIrWI8IvL33sZXeUcci+95ckE29z3Ua0TF4vFRsXSi0rKw5kl/vVirmZDQZMXWO
	 BQsBhzKnIaj4ketTFRUktRInU6T0CA5xBRL9XhQcBCwuPn0McCk7lSW2SauJ1+MbKb
	 FiOS98LPdjjKD8iz7uY5BZvs3wVNBh/Qs8xBESa/SPKJsn6uo8hpFBQ+xFRpOgc2E+
	 tfJuxLVBUJPYdKMke4TbEgYPU67dvPykeLNOf1vjgTYDYmdeQOEU0ivEhG5YJOQX16
	 GYElEYrWLuJ3BgzM+naOhNOznl/B9Rd9tb5acbOR32KrJD9qAKeWHbTN2Yonb6JziD
	 qkwZanZdN4lQQ==
Date: Mon, 22 Jan 2024 20:28:06 +0000
From: Mark Brown <broonie@kernel.org>
To: Seven Lee <wtli@nuvoton.com>
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	robh+dt@kernel.org, conor+dt@kernel.org, YHCHuang@nuvoton.com,
	KCHSU0@nuvoton.com, CTLIN0@nuvoton.com, SJLIN0@nuvoton.com,
	scott6986@gmail.com, supercraig0719@gmail.com, dardar923@gmail.com
Subject: Re: [PATCH 2/2] ASoC: nau8325: new driver
Message-ID: <820c5ff7-4329-46b0-9981-607b1593deb5@sirena.org.uk>
References: <20240122095650.60523-1-wtli@nuvoton.com>
 <20240122095650.60523-2-wtli@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QAZjW4H1wKCsCURa"
Content-Disposition: inline
In-Reply-To: <20240122095650.60523-2-wtli@nuvoton.com>
X-Cookie: Nice guys don't finish nice.


--QAZjW4H1wKCsCURa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 22, 2024 at 05:56:50PM +0800, Seven Lee wrote:

> +++ b/sound/soc/codecs/nau8325.c
> @@ -0,0 +1,896 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * nau8325.c -- Nuvoton NAU8325 audio codec driver
> + *

Please use a C++ comment for the whole block to make things look more
consistent.

> +static int nau8325_clkdet_put(struct snd_kcontrol *kcontrol,
> +			      struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct soc_mixer_control *mc =
> +		(struct soc_mixer_control *)kcontrol->private_value;
> +	struct snd_soc_component *component =
> +		snd_soc_kcontrol_component(kcontrol);
> +	struct nau8325 *nau8325 = snd_soc_component_get_drvdata(component);
> +	unsigned int max = mc->max, min = mc->min, val;
> +	unsigned int mask = (1 << fls(max)) - 1;

AFAICT this will only work well if max is 1, just hard code that.

> +
> +	val = (ucontrol->value.integer.value[0] + min) & mask;
> +	nau8325->clock_detection = val;
> +
> +	if (nau8325->clock_detection)
> +		regmap_update_bits(nau8325->regmap, NAU8325_R40_CLK_DET_CTRL,
> +				   NAU8325_CLKPWRUP_DIS, 0);
> +	else
> +		regmap_update_bits(nau8325->regmap, NAU8325_R40_CLK_DET_CTRL,
> +				   NAU8325_CLKPWRUP_DIS, NAU8325_CLKPWRUP_DIS);
> +
> +	return nau8325->clock_detection;
> +}

Please use mixer-test to verify that your controls conform to the
expected API, the return value here is not what's expected - it should
be a negative value for an error, 0 for no change and 1 for change.

> +	SOC_SINGLE_EXT("Clock Detection", SND_SOC_NOPM, 0, 1, 0,
> +		       nau8325_clkdet_get, nau8325_clkdet_put),

Shouldn't this be a Switch?

> +	SOC_SINGLE("ALC Enable", NAU8325_R2E_ALC_CTRL3,
> +		   NAU8325_ALC_EN_SFT, 1, 0),

ALC Switch.

> +static int nau8325_powerup_event(struct snd_soc_dapm_widget *w,
> +				 struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_component *component =
> +		snd_soc_dapm_to_component(w->dapm);
> +	struct nau8325 *nau8325 = snd_soc_component_get_drvdata(component);
> +
> +	if (nau8325->clock_detection)
> +		return 0;
> +

What happens if someone enables clock detection while things are powered
up?

--QAZjW4H1wKCsCURa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWuz9UACgkQJNaLcl1U
h9BQjgf/QLIx/6Vn2gRBlBNbQfnoOasSe3itaUJwtDJ6sVFgb6jjZT0ZlOww4+rf
TX08tOTbrDHhWqh2RCuxxAFCHG9Uu0TYl46QikJIRfZSP/1dWtdY4dptsv+n5Kgh
UQDmnDiewqFaR4mlDBzgzmeDL+Gfr8L+ucedfTpRpwl7YNv1/Mwubh5U/oDGLGVB
+2O7QQ8OKWpdUW4XRvH3Rdh7GYrtx0YUPn+Yicp7wOnyKg7qs1OEvpTBpAQVPPvT
LpE2I+3swtCjetn2maB+cPUgDcOKL6hu9rIj/alple3YU5ux+il+PiJDlfTD5H1C
XNimTSNbAm/gNjZbrUQbShQj05Upcg==
=+I7g
-----END PGP SIGNATURE-----

--QAZjW4H1wKCsCURa--

