Return-Path: <linux-kernel+bounces-40186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE7D83DBEF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32B7B1C21B5A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8791B81B;
	Fri, 26 Jan 2024 14:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhFaRahL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159511CA8D;
	Fri, 26 Jan 2024 14:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706279603; cv=none; b=gvYZLITpUfGo6EAt3UzyMZLmZoAMnWmnSnCKj+lEesVzqVzjZ7VklEG0kSDPrG9j6tpn9BkBTFNyY7VOBDglLBV6av3pzO5ZaFoGQ/lVlvfG9IqL3RE3Fbc6R/UI93wpV9m7Jd3+XlI3GmJYt2fAFg7lsAzq06tFHfHl50/8Cyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706279603; c=relaxed/simple;
	bh=toHPWrukG5ZJdg4r3h3ugd+zNwZSP1onspiF6e+jS4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Il8cvhOkfHF2CNbVSzurF/vzdZj9ECRUJOlOVSLh2nk/Q9kLv0kkt59EtmzIU7B9HEjN8Yt0tMtRTGoWBQfAHOxEzdNF0v6raZ7Y+agQ77NZxIZVGMug3l9Vxf9EWJaH2uL7I9ZNB2RnaNoJt5Q4QWhuZEDMdKILFvpEe7j18/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhFaRahL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194BBC433F1;
	Fri, 26 Jan 2024 14:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706279602;
	bh=toHPWrukG5ZJdg4r3h3ugd+zNwZSP1onspiF6e+jS4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YhFaRahL9Dr/6ZCzpQy0FfOc9+vbwzEbVoH9SDzoA+gHW8uI0BQ0bYXQuDH6G+0N1
	 fPc+9HJv+rXimvjgGTzaIZsW91g3xYA9pHihjIi6FcKQZ0iMDxxDgvzxZLLosriFE4
	 S6KCaEhR5Pje3ZlyEBsA/xoboa2KYY19h7bIztvSnux+0E+aM9vJ1oxE5GoBbWt8ch
	 hq+056fZsfZKzBzm2X8vhf/1HdYacxIwBivjPKB5FaM5ApOO5GmBEXRPtkdE/3gfBi
	 H80FH4MxmUF9sdDcRJztINay9si+hPerUcnWdb5PEl7q0QXi4WJIH4pckVc0WVubJt
	 zxy7ZkODckUAw==
Date: Fri, 26 Jan 2024 14:33:14 +0000
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: conor+dt@kernel.org, krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
	andriy.shevchenko@linux.intel.com, kevin-lu@ti.com,
	baojun.xu@ti.com, devicetree@vger.kernel.org, v-po@ti.com,
	lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, 13916275206@139.com,
	mohit.chawla@ti.com, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com,
	soyer@irl.hu, jkhuang3@ti.com, tiwai@suse.de, pdjuandi@ti.com,
	j-mcpherson@ti.com, navada@ti.com
Subject: Re: [PATCH v2 1/4] ASoc: PCM6240: Create PCM6240 Family driver code
Message-ID: <6c1d04be-c558-4aa4-96a3-ac21ae36bfae@sirena.org.uk>
References: <20240126035855.1785-1-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zICUD1iSPynTqKb5"
Content-Disposition: inline
In-Reply-To: <20240126035855.1785-1-shenghao-ding@ti.com>
X-Cookie: Excellent day to have a rotten day.


--zICUD1iSPynTqKb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 26, 2024 at 11:58:51AM +0800, Shenghao Ding wrote:

This looks mostly good - I've got a few comments that are mainly
stylistic or otherwise very minor, there's one issue with validation of
profile IDs that does look like it's important to fix though.

> +static int pcmdev_dev_read(struct pcmdevice_priv *pcm_dev,
> +	unsigned int dev_no, unsigned int reg, unsigned int *val)
> +{
> +	int ret = -EINVAL;
> +
> +	if (dev_no < pcm_dev->ndev) {

You could write all these functions a bit more simply if you rewrote
these error checks to return immediately on error, that way there's less
indentation and fewer paths later on.

	if (dev_no >= pcm_dev->ndev)
		return -EINVAL;

and so on.  For the ones dealing with locking it can help to have a
single exit path but functions like this don't deal directly with the
locks.

> +
> +		ret = regmap_read(map, reg, val);
> +		if (ret < 0)
> +			dev_err(pcm_dev->dev, "%s, E=%d\n", __func__, ret);
> +	} else
> +		dev_err(pcm_dev->dev, "%s, no such channel(%d)\n", __func__,
> +			dev_no);
> +

The kernel coding style is that if one side of an if/else has { } both
should.

> +static int pcmdevice_set_profile_id(
> +	struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *codec
> +		= snd_soc_kcontrol_component(kcontrol);
> +	struct pcmdevice_priv *pcm_dev =
> +		snd_soc_component_get_drvdata(codec);
> +	int ret = 0;
> +
> +	if (pcm_dev->cur_conf != ucontrol->value.integer.value[0]) {
> +		pcm_dev->cur_conf = ucontrol->value.integer.value[0];
> +		ret = 1;
> +	}
> +
> +	return ret;
> +}

This will accept any configuration number, shouldn't there be some
validation here?  The put functions doing regmap_update_bits() have
some limiting of values in the regmap_update_bits() but this just stores
the value directly.

> +static int pcmdevice_get_volsw(struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_value *ucontrol)
> +{

> +	mutex_lock(&pcm_dev->codec_lock);
> +	rc = pcmdev_dev_read(pcm_dev, dev_no, reg, &val);
> +	if (rc) {
> +		dev_err(pcm_dev->dev, "%s:read, ERROR, E=%d\n",
> +			__func__, rc);
> +		goto out;
> +	}

It would be kind of nice if the device switching could be hidden inside
a custom regmap and we didn't have all this code duplication but I'm not
thinking of a way of doing that which doesn't just create complications
so probably this is fine.

> +	val = (val >> shift) & mask;
> +	val = (val > max) ? max : val;
> +	val = mc->invert ? max - val : val;
> +	ucontrol->value.integer.value[0] = val;

There's the FIELD_GET() macro (and FIELD_SET() for writing values) - the
core predates them and hence doesn't use them, we might want to update
some time.

> +static int pcmdevice_codec_probe(struct snd_soc_component *codec)
> +{

> +	ret = request_firmware_nowait(THIS_MODULE, FW_ACTION_UEVENT,
> +		pcm_dev->regbin_name, pcm_dev->dev, GFP_KERNEL, pcm_dev,
> +		pcmdev_regbin_ready);
> +	if (ret) {
> +		dev_err(pcm_dev->dev, "load %s error = %d\n",
> +			pcm_dev->regbin_name, ret);
> +		goto out;
> +	}

It might be better to request the firmware in the I2C probe rather than
in the ASoC level probe, that way there's more time for the firmware to
be loaded before we actually need it.  That does mean you can't register
the controls immediately though so it may be more trouble than it's
worth.

Similarly for the reset, if we reset as early as possible that seems
better.

> +static int pcmdevice_startup(struct snd_pcm_substream *substream,
> +	struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_component *codec = dai->component;
> +	struct pcmdevice_priv *pcm_priv = snd_soc_component_get_drvdata(codec);
> +	int ret = 0;
> +
> +	if (pcm_priv->fw_state != PCMDEVICE_FW_LOAD_OK) {
> +		dev_err(pcm_priv->dev, "DSP bin file not loaded\n");
> +		ret = -EINVAL;
> +	}

Perhaps -EBUSY instead?  What the user is doing is valid.

> +static const struct regmap_config pcmdevice_i2c_regmap = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.cache_type = REGCACHE_RBTREE,

Use _MAPLE for new devices, it's a more modern design with tradeoffs
that work better for most current systems.

--zICUD1iSPynTqKb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWzwqoACgkQJNaLcl1U
h9BCzwf+L41HbR0BgZxeKdyUNHfjw//dNQQiokt5X33hzy2MfX0cEw4MOf8k9xyv
x7kjEUSTwhyF6hxi1Ov9iApcnot6U5L1aoxrAS19xBs3zCqO5dEDtDQz8B6jHXF3
hR6dT0dwXyKQxOx57BhEPbF16MY0ZpJuE3Od6i4s54zt/rqJw2hUH9xoZNA7BgRH
8w2OMYMbbY+FL9QyLrDBxMJCgxDDnblMbeBp4yIS35A20M7d2MnxgedAmCmDWZth
Zkhut1zLOwqZydXjkXrJQAB3izplMzHYS1lxmBOqdAjC+cwTrVIxr0O8GwmYc8bI
P4rWI9yDw6TygfQlYVCQd3jyHNiuSA==
=OLs3
-----END PGP SIGNATURE-----

--zICUD1iSPynTqKb5--

