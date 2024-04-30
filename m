Return-Path: <linux-kernel+bounces-164207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E17588B7AAC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BDDB1C22E8C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79517710D;
	Tue, 30 Apr 2024 14:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0SMqvqg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33678152798;
	Tue, 30 Apr 2024 14:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714489009; cv=none; b=eMGG93a+TZtvDK6NrNKgL//mBrkNFew+sALcZHxhXY4nAaW1EBsoF3zRHjb0e+WV4Wxtj3i0T0UloReR/kgnxfTvcuSY+Sdq/9xYkNYQk7jAkQLGfYW/Cz9+IRLrm+Ur73iZyouGPpEi13KYe3LM0dWA35vssAl5S2+uKfoucpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714489009; c=relaxed/simple;
	bh=TjXlwvXIGxgY7FadCv6wm6DhT0gofgknxCj4A+6vdXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vl83rVpK9c/KKakHLOJYydOYv7GmJyTvRZ0DiPkqQy8uDRDAxcP04snD4758K2I6PNcktFFODI/c+mZy5J6s3YxiIkwQ7FFIGYWqGGu6LHXV7VvS7crGKsOIk9MA4hTw6s2J0PJ2pSlGAPcV6ELT7bAP7hNPaRg02OtNFPzTzLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0SMqvqg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3761C4AF1B;
	Tue, 30 Apr 2024 14:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714489009;
	bh=TjXlwvXIGxgY7FadCv6wm6DhT0gofgknxCj4A+6vdXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g0SMqvqgU1WU5wiygjLar9m1vuDPUR9BYpi0KNcaC0nloEmd6qc+jM+Jp9uCZIIey
	 djKjd5rpFCmi+ocyvIueE33j3i7+NL0AKdoPZaBPh3HpO4IJ5yYXPcNk4ImglHbljh
	 LPwFP2qY9fOuK3ZOAv/polEQANeDAlE03Hqatt9XSEKPH4W9PaUxyXng8pyQcAXp5v
	 orKHqV89qe0IkrwoRobewPGwhA50Ehfrcl7Y1VHNtJNJP8fA2O0EEauN8m+HEBbTXW
	 ximwoePlNsfEnA6T3SYw13VsltN7blQ88UeTRAgUycJGEc5R3sis61XkJmnwTcpxkg
	 XSSVgZ1up0zqQ==
Date: Tue, 30 Apr 2024 23:56:46 +0900
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: use inline function for type safety in
 snd_soc_substream_to_rtd()
Message-ID: <ZjEGrnlQfFeDyLUc@finisterre.sirena.org.uk>
References: <20240430140938.328088-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8pV+PWcSobNbNF3R"
Content-Disposition: inline
In-Reply-To: <20240430140938.328088-1-krzysztof.kozlowski@linaro.org>
X-Cookie: lisp, v.:


--8pV+PWcSobNbNF3R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 30, 2024 at 04:09:38PM +0200, Krzysztof Kozlowski wrote:

> -#define snd_soc_substream_to_rtd(substream) \
> -	(struct snd_soc_pcm_runtime *)snd_pcm_substream_chip(substream)
> +
> +static inline struct snd_soc_pcm_runtime *
> +snd_soc_substream_to_rtd(const struct snd_pcm_substream *substream)
> +{
> +	return substream->private_data;
> +}

This is not an obvious direct substitution, we've skipped the
snd_pcm_subsystem_chip() (which is also a macro, but that just suggests
it could do with it's own cleanup) and the commit log didn't mention it.

--8pV+PWcSobNbNF3R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYxBq4ACgkQJNaLcl1U
h9Ca7gf/T8ZFoUJmdU+447+36hbeeKvmRjKe/W64VoRyOxKcdgIc4vr9a3P+jkFO
XDOo4DRaC4ODF3piEsAJpT1SiNUxBIOzTD3+t7uv4O0QRQ90SxTPVQLb4dxIRqiP
3QCsgePEYGspRHxlUJkMwPuq/i6bdjX6KiT2jX9MVmLAEfYLzfrc4cjlZtrtmjPS
Nzikju+66l21nQXBFToT4npXQxS9balCz9ruOM+iwSwcKC2trEyYJVnjK1tS6Uhd
6j8JdCPmItOu4ERgVSmBQCuKzjKtJyj1ie7k8alpPzBjbXM5my6/W9uWr81GOhaz
Vq6V0tNBMk2Nose52DHSpiVUIjAPqg==
=pItM
-----END PGP SIGNATURE-----

--8pV+PWcSobNbNF3R--

