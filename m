Return-Path: <linux-kernel+bounces-95559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51865874F76
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BC4C28209A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4472512BEB1;
	Thu,  7 Mar 2024 12:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8l6/5Ae"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8086E5F86B;
	Thu,  7 Mar 2024 12:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709815936; cv=none; b=oG2PTmGin7OpEsZx/7EK7ylhv0QehUhojIIfGHcYWwxOHkMnRoU9MXRhyzRH8z0bkSAY1NdeKK8w/rdlx/shxLDe6TWpekRthR6VLS5zJS/44YsL/ujfpR2eJ0vyU+Q6fN7WBrpNI2iTPn+tFqq3iIZ75+hGWZleiZ5wUQbe5xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709815936; c=relaxed/simple;
	bh=MblaJ/xBbyAlKSi+e0NY+oob1/RL+llTsv1GcmbHug4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KsT1a+L66yP6Ypq2aKND9d4sWQRnBYAlwUkC7N12to2nZTWMqC8mhwSmx0MXjBnLykvBGBY5rtnmmS3JVBCeKb4EmvOyntUAKQ2xFs5HLFqJTczMOFQ9RYA0KdaLbR6hNP0TcYSOP0B7iDQ6Ob09vpGiFCitbhaOVJahWSmjqXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8l6/5Ae; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB771C433F1;
	Thu,  7 Mar 2024 12:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709815936;
	bh=MblaJ/xBbyAlKSi+e0NY+oob1/RL+llTsv1GcmbHug4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d8l6/5Ae9Jc8Q5gtpYdqmVO7Bn5xYa/nI0y/WNBC7lZ9A+7MTGoERrSyeZLKuj2JQ
	 MQ4hySceKJxRI2PnSYBmJI+xBMeN6Z7LeijVfT6/2KKfAE6LPJoN8Jvqott/Ropt1l
	 N/lu9QrVbR2yUVmeivDKG1K2LzanzlGxPC1tvzK2MzGwKTwbjpQNOYpd2vuv3FWP6+
	 a6reH1zjT7H1D7+CqpY85CGl07Vbq4nAyVopneT7QIakgnNou0w58+YUuV3IXFAKMz
	 QP4g9QfkUKAqgpI4zlGj8VYJLTA4Unq8fPewhuYw8pcZMoCHDsisUguS31qfQ9a/7+
	 XkMn4AbGjMIcw==
Date: Thu, 7 Mar 2024 12:52:10 +0000
From: Mark Brown <broonie@kernel.org>
To: Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Walker Chen <walker.chen@starfivetech.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v1 2/2] ASoC: starfive: Add PDM controller support
Message-ID: <fddca901-273c-4b06-ad59-d156941920d6@sirena.org.uk>
References: <20240307033708.139535-1-xingyu.wu@starfivetech.com>
 <20240307033708.139535-3-xingyu.wu@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OMuJ0wTIjHrUHwqT"
Content-Disposition: inline
In-Reply-To: <20240307033708.139535-3-xingyu.wu@starfivetech.com>
X-Cookie: Been Transferred Lately?


--OMuJ0wTIjHrUHwqT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 07, 2024 at 11:37:08AM +0800, Xingyu Wu wrote:

> +static const struct snd_kcontrol_new jh8100_pdm_snd_controls[] = {
> +	SOC_SINGLE("DC compensation Control", JH8100_PDM_DMIC_CTRL0, 30, 1, 0),
> +	SOC_SINGLE("High Pass Filter Control", JH8100_PDM_DMIC_CTRL0, 28, 1, 0),
> +	SOC_SINGLE("Left Channel Volume Control", JH8100_PDM_DMIC_CTRL0, 23, 1, 0),
> +	SOC_SINGLE("Right Channel Volume Control", JH8100_PDM_DMIC_CTRL0, 22, 1, 0),
> +	SOC_SINGLE_TLV("Volume", JH8100_PDM_DMIC_CTRL0, 16, 0x3F, 1, volume_tlv),
> +	SOC_SINGLE("Data MSB Shift", JH8100_PDM_DMIC_CTRL0, 1, 7, 0),
> +	SOC_SINGLE("SCALE", JH8100_PDM_DC_SCALE0, 0, 0x3F, 0),
> +	SOC_SINGLE("DC offset", JH8100_PDM_DC_SCALE0, 8, 0xFFFFF, 0),
> +};

Simple on/off switches should have names ending in Switch, volumes
should end in Volume as per control-names.rst.  Please for the next
version you post show the output of running mixer-test on a system with
this device, it will identify these and other issues.

> +static int jh8100_pdm_component_probe(struct snd_soc_component *component)
> +{
> +	struct jh8100_pdm_priv *priv = snd_soc_component_get_drvdata(component);
> +
> +	snd_soc_component_init_regmap(component, priv->regmap);
> +	snd_soc_add_component_controls(component, jh8100_pdm_snd_controls,
> +				       ARRAY_SIZE(jh8100_pdm_snd_controls));

You can just specify the controls in the snd_soc_compoenent_driver.

> +#ifdef CONFIG_PM
> +static int jh8100_pdm_runtime_suspend(struct device *dev)
> +{
> +	struct jh8100_pdm_priv *priv = dev_get_drvdata(dev);
> +
> +	clk_disable_unprepare(priv->icg_clk);
> +	return 0;
> +}
> +
> +static int jh8100_pdm_runtime_resume(struct device *dev)
> +{
> +	struct jh8100_pdm_priv *priv = dev_get_drvdata(dev);
> +
> +	return jh8100_pdm_crg_enable(priv);
> +}
> +#endif

It's weird that the runtime suspend and resume are not symmetric - why
do we need to bring the device out of reset but not put it into reset?

> +	if (!device_property_read_u8(&pdev->dev, "starfive,pdm-modulex", &using_modulex))
> +		if (using_modulex == 1)
> +			base += JH8100_PDM_MODULEX_SHIFT; /* Use module 1 */

This really looks like you've got one hardware block with two devices in
it, either the address ranges registered for the devices in DT should be
separate and you shouldn't need this property or you should have one
component registering both PDM interfaces.

--OMuJ0wTIjHrUHwqT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXpuHoACgkQJNaLcl1U
h9Bj5Af/R9ushCNRKrPb78ikXIhM0zTjHfChPI6K6mCQsquHeplDYjw97T1NMXpF
t3mQJVASZqIIv4ve6aaaObvoNYMNfQHF1qxI7fw8TL2RR1nqo2MI6b7+hZEMcFLo
iW9+/SHL1mFHQ+gSdRIgDBj/ym9Plcryy1ajxFom8gqitvA/o0kZJHez6EpW2t0I
avPYFO3iHOTB77FSG6YcwY+RKqrluLRgVAuNXIay1P9+VKW0Zx4gFo7ZRcd2s1xz
5bGuh2cqhWCOwJXiKYjNUZPs8usGcGDEc6TtluNXKACrtzRPCymY1YYpVWEPkK6C
5X21iVfOR/nJ0+kRIKeGzk57bmvIBA==
=W35A
-----END PGP SIGNATURE-----

--OMuJ0wTIjHrUHwqT--

