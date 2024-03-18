Return-Path: <linux-kernel+bounces-106177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F7C87EA56
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FA13283222
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C821A4AECD;
	Mon, 18 Mar 2024 13:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKkpVxKx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024A44AED2;
	Mon, 18 Mar 2024 13:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710769719; cv=none; b=Tx5OBXUNTIb8V+g+df3PQtgNqCFMafmxBAEbKsa+vmwBiAJVoUNFTQb3C1lyCJWnbPW65hsQuZ4pAvLeXGSlDuGSg0s9oFjEPj75umRPJio5caRWL23tkr2D9f2PNcXKzi+YbKNS3PPTNUqtPhDxSzx0H5dEGgEN9X3RwC4RCWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710769719; c=relaxed/simple;
	bh=MHoHwr0eDPD5cgVd1+iwqRgWIVLOzhoSjzj/dQkgH/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLQn7ULMrmlVxLRMf4+dM3xQYaq9SPn4ceHuOIldoirkdqnh/VlXfu+KOiJb4aKnsKxLDIELJerXAnzbtgapHvaDQeMNzoO0j71bpaJQTJKBVyc7VbysIMKJ4/JC3KlSppOh4KC2wi+bIhW0qlRxGRnShIOPuRRt3WC4Nnc7NRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKkpVxKx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1095BC433F1;
	Mon, 18 Mar 2024 13:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710769718;
	bh=MHoHwr0eDPD5cgVd1+iwqRgWIVLOzhoSjzj/dQkgH/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DKkpVxKxY7h9v+lH5UT2+3Yhzkji9Pqcx33yJYLYim45vOo92XuYMu+YsHi1ZhZwG
	 fc9Kinal7Gz43JO9X6EBtVPVJCa1KqGDeTMjMwSQb2cw9+nUNz28XZMOze6O1MLI0h
	 5KMZotzvi/hfqpFn29SDRG0ZiAYMYaMJMcyWl527F8xnrvyortoF9cxBPADf3dH1ek
	 XXUJlYYrGd9CKFAxhjwbp1ORhxlvSc9ZgcC8dEj2fdtNa6b3cfkExJIlFD+vZcTijm
	 M0lnpXAg63TlsHu/H9VvpHn83Ki149ZsnCePdDElv4ZWROEyOXFnYSWSNT6WCSeekd
	 QLkjCGvBD0jXA==
Date: Mon, 18 Mar 2024 13:48:31 +0000
From: Mark Brown <broonie@kernel.org>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, linux-gpio@vger.kernel.org,
	kernel@salutedevices.com
Subject: Re: [PATCH 12/25] ASoC: meson: t9015: add support for A1 SoC family
Message-ID: <30dadd4c-de10-43a7-baf8-8ddd49f5c80e@sirena.org.uk>
References: <20240314232201.2102178-1-jan.dakinevich@salutedevices.com>
 <20240314232201.2102178-13-jan.dakinevich@salutedevices.com>
 <5f8e8cd2-f9c4-4961-a85d-a0f3217294e6@sirena.org.uk>
 <c4c0e3a3-eaa8-42c6-bbd3-e5c6993dc63b@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cWXPDKTXShavPzNA"
Content-Disposition: inline
In-Reply-To: <c4c0e3a3-eaa8-42c6-bbd3-e5c6993dc63b@salutedevices.com>
X-Cookie: Alaska:


--cWXPDKTXShavPzNA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 17, 2024 at 07:27:14PM +0300, Jan Dakinevich wrote:

> Both mic bias and ADC's input mode depends on schematics and should be
> configurable. What is the better way to give access to these parameters?
> Device tree?

Yes.

> >> +	SOC_SINGLE("ADC Mic Bias Switch", LINEIN_CFG, MICBIAS_EN, 1, 0),
> >> +	SOC_ENUM("ADC Mic Bias Level", a1_adc_mic_bias_level),

> > Why would micbias be user controlled rather than a DAPM widget as
> > normal?

> Yes, I could use SND_SOC_DAPM_SUPPLY, but it supports only raw values,
> and doesn't supports enums. Here, I want to use enum to restrict
> possible values, because only these values mentioned in the
> documentation that I have.

A supply is an on/off switch not an enum.  Users should not be selecting
values at all.

--cWXPDKTXShavPzNA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmX4Ri4ACgkQJNaLcl1U
h9DTQAf+Ppr066CVfsvlN/xyNgCUEg1jqhI9r20Nh5lxtnjU+wC1Kcr+iobrATQM
TDOweMGu65tzuQZfO6T+CaB8UHXIAHKQStRrDMt60u8hvNbQ1WBBGcNpHZ4aEnH7
dha2+WYeSatRy9dWtHHuumkiG0oMZO93Q9agqdWm0p3dcF/kfp0UsgdfjFXbC0CZ
bF5SO0qaSh4sYzmkOWdsGn175ELpN2HMYaAL5R1kaS4QntznG3QCuLXxdOSy6/+7
SByMPu2j+jkFJTHfOQlYZZCDrgZ+czQ4gWszPQuk9LWDTYFrxajuRVwRKXew/GA8
Z0fuEs8wuIMGmSTEXpNJXc/IeEv+nw==
=YCeA
-----END PGP SIGNATURE-----

--cWXPDKTXShavPzNA--

