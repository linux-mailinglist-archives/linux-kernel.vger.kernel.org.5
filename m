Return-Path: <linux-kernel+bounces-77189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FAE8601E5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5004828D6B6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14DC140E57;
	Thu, 22 Feb 2024 18:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpLMDOqe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2125A38FB2;
	Thu, 22 Feb 2024 18:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627279; cv=none; b=NYdCxObBH8stsClgFE4HybdxEguSUFBQrMkeEJXIxeTHX2xsPG/8P/uqOEPXwgkHceoa1jht/FyBHvfsjxpdQUk/xxoqiwmcIiLMlduCPyL1SQ8+dqICmsbDFBc7i5t+UD1bO36gJXknsSN7KFeT+70LvGgd00rZWFivytOfE7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627279; c=relaxed/simple;
	bh=6XJwHfKFPsJnbMTE3OuN1fl0JMH2yKdGnKVLUGPt9vE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0tYy2xm1bix7f3ZWQhfJgnpsj3UsPav4f2/Y7UX59QycVHaYDkbHCY6Um2zp3qtSfi2uJfckmWcp+Hga4MzsFvoNtx9eZzDwFw+F1LCM2aNLLjZmMRGWXSifr1T+jPjkYCuZvIyWu0dGLK1V1D0Qg0rA2fHKQT/OpIyXzKQu3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tpLMDOqe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51715C433F1;
	Thu, 22 Feb 2024 18:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708627278;
	bh=6XJwHfKFPsJnbMTE3OuN1fl0JMH2yKdGnKVLUGPt9vE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tpLMDOqeEdmNC58Uv1I0ZhWdqg93g0Biw/4KKz68M0nSQgul88Y4P6czVnngiS5FF
	 j9jZA7G/RqafCsvXvlBIScTzdIVWq5n+Lt04dv+Wsh003JHHr8KxaKVQOLlE7RkMdU
	 sd4MUtnv0dwcYo92qgcUL5W762Yv3kr5sQAWMycB92ouqq4R6R7BvBiucG0kmSPhXW
	 k1/bwLXSvgnDZptz9XdDH0OcBdZwaxsMyHSXDxJ8LzJXwwZajs2uopS0FJbXyEabgy
	 4OmPDv0lhyrRv+GeQO+3D7JWvcmxYVra554kvo9pD38WIEZsSO5C1mJxBrdRL3K3rr
	 cI+RUxYTJBTXg==
Date: Thu, 22 Feb 2024 18:41:13 +0000
From: Mark Brown <broonie@kernel.org>
To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Arnaud Ferraris <arnaud.ferraris@collabora.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 4/4] ASoC: sun8i-codec: Implement jack and accessory
 detection
Message-ID: <0c351386-f1df-443f-a997-261f5c60c852@sirena.org.uk>
References: <20240222181851.3398254-1-megi@xff.cz>
 <20240222181851.3398254-5-megi@xff.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nDVapEvA1lBavuoE"
Content-Disposition: inline
In-Reply-To: <20240222181851.3398254-5-megi@xff.cz>
X-Cookie: I have accepted Provolone into my life!


--nDVapEvA1lBavuoE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 07:18:47PM +0100, Ond=C5=99ej Jirman wrote:

> +static struct snd_soc_jack_pin sun8i_codec_jack_pins[] =3D {
> +	{
> +		.pin	=3D "Headphone Jack",
> +		.mask	=3D SND_JACK_HEADPHONE,
> +	},
> +	{
> +		.pin	=3D "Headset Microphone",
> +		.mask	=3D SND_JACK_MICROPHONE,
> +	},
> +};
> +

The jack being a headset jack is going to be system specific isn't it?
Some systems might have separate headphone and microphone jacks.  I'd
not expect to see any pin handling code at all in a CODEC driver, that
belongs in the machine driver.

>  static int sun8i_codec_component_probe(struct snd_soc_component *compone=
nt)
>  {
>  	struct snd_soc_dapm_context *dapm =3D snd_soc_component_get_dapm(compon=
ent);
>  	struct sun8i_codec *scodec =3D snd_soc_component_get_drvdata(component);
>  	int ret;
> =20
> +	scodec->card =3D component->card;
> +

The fact that you're needing to look at the card here should be a bit of
a warning sign there.

--nDVapEvA1lBavuoE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXXlUgACgkQJNaLcl1U
h9CKKgf/aoS85uaApPM+Hu5AKwDdPhzqPWfBz5tHxcaPCNpEosJgwvW7FkDEJJIs
7ODH56RBKAhTrzbyUAgg6PIgeOilZSXWzgUi5BkIqsSUJxW7jZJKa1Xk4XusRnOw
3bMp1wVMh1QlUVIV+0podvqlsDjEvC08l6Rq5hIRf7ZRxztdnsE9a774ZwTFyk2g
UZeFv6KT7PegfqSNtyIrt9s/ghKpPAoCffRPkNTIc8+ZbGeBReomWijInFrK82gb
rVHPuJdb5oXz/lH8Zj0LrFjEH511k6OxPwxGwwylruXbDyND/ur+YAhphUxrkTwO
YIdwQVpj84jPawxlailo/ViT+V7i+A==
=fWYW
-----END PGP SIGNATURE-----

--nDVapEvA1lBavuoE--

