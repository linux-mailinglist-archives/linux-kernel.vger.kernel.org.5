Return-Path: <linux-kernel+bounces-52872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 952F7849DAB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EDDFB25347
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9823A2C6A6;
	Mon,  5 Feb 2024 15:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmqBH4uM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D284C2C848;
	Mon,  5 Feb 2024 15:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707145505; cv=none; b=s/X0UKP6h24xxyULZt5GeotqNCwG3+rU2DX3zovsTIPVRJWXyiBvGD/4sFRqXPiUEKBHjxkBvu1U0JONVyXOLdQRaFAiEUCN/YEK+WWULfov+Zf2oYkU9yK7f3ougbnp+Zmfo0BktMi+BavCKFcp4B272CzzJIcDhAPd7J42qYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707145505; c=relaxed/simple;
	bh=Yfk/4+9czy4PCreT5ugg9ESrBcCZP7CYrSDkqcGFwJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2x4AhYQ0j3KGL+RrSJF3nylu+4VmseY48EUkSXUc52Csl1r6UOectgSZMAQ2C2/Xer8VNSKoJMjcitE+c4OnbJcIZzzVxf5+LXRm9HZYk7XDS85RZn7Edzq0/Q+ZRItYaGGqDK6cU26v5kKWgKdhG0Sout97d8hG20lD4Dqvdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmqBH4uM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178D5C433C7;
	Mon,  5 Feb 2024 15:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707145505;
	bh=Yfk/4+9czy4PCreT5ugg9ESrBcCZP7CYrSDkqcGFwJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EmqBH4uM3l0y4S8L/czVQGJzlHiBpNTnZ6i8odDonDEDNBBLlWz8vxea17SptzhIX
	 BZkqhHIvNIIX89nGFysge/VSytT4gmEjTOsk8U9OxSj9vdMOmt637BsV85TfjxzCjD
	 zQS3OcXGg+Ps1pkpjZdyitTGjyeGNvJJdmLADxB2sLcUqypoEHAyFv9wTIAWovrvXn
	 nhs7Bku0G+ZYk9W4x8hNhrKfumASXnwLGEUVc0IqxCPEF8B3wuBHE5DI5Ws3HjgPu1
	 2tCqFS8MXiBWX1u25XletqA9Q51p3HKziPE7kc/e4qF8hL68HYnmeWzqJl8OD3IGQN
	 tQUsZAzVbLgcw==
Date: Mon, 5 Feb 2024 15:05:02 +0000
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: conor+dt@kernel.org, krzysztof.kozlowski@linaro.org,
	devicetree@vger.kernel.org, robh+dt@kernel.org,
	andriy.shevchenko@linux.intel.com, linux-sound@vger.kernel.org,
	liam.r.girdwood@intel.com, lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org, kevin-lu@ti.com, baojun.xu@ti.com,
	v-po@ti.com, navada@ti.com, perex@perex.cz, j-mcpherson@ti.com,
	pierre-louis.bossart@linux.intel.com, 13916275206@139.com,
	mohit.chawla@ti.com, soyer@irl.hu, jkhuang3@ti.com, tiwai@suse.de,
	pdjuandi@ti.com, manisha.agrawal@ti.com, s-hari@ti.com,
	aviel@ti.com, hnagalla@ti.com, praneeth@ti.com
Subject: Re: [PATCH v3 1/4] ASoc: PCM6240: Create PCM6240 Family driver code
Message-ID: <ZcD5HjnxSJkQ6QYT@finisterre.sirena.org.uk>
References: <20240203030504.1724-1-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GVpQNZhUL4tDuEAO"
Content-Disposition: inline
In-Reply-To: <20240203030504.1724-1-shenghao-ding@ti.com>
X-Cookie: You might have mail.


--GVpQNZhUL4tDuEAO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 03, 2024 at 11:04:59AM +0800, Shenghao Ding wrote:

> +static int pcmdev_dev_update_bits(struct pcmdevice_priv *pcm_dev,
> +	unsigned int dev_no, unsigned int reg, unsigned int mask,
> +	unsigned int value)
> +{
> +	struct regmap *map = pcm_dev->regmap;
> +	int ret;
> +
> +	if (dev_no >= pcm_dev->ndev) {
> +		dev_err(pcm_dev->dev, "%s, no such channel(%d)\n", __func__,
> +			dev_no);
> +		return -EINVAL;
> +	}
> +
> +	ret = pcmdev_change_dev(pcm_dev, dev_no);
> +	if (ret < 0) {
> +		dev_err(pcm_dev->dev, "%s, E=%d\n", __func__, ret);
> +		return ret;
> +	}
> +
> +	ret = regmap_update_bits(map, reg, mask, value);
> +	if (ret < 0)
> +		dev_err(pcm_dev->dev, "update_bits ERROR, E=%d\n",
> +			ret);
> +
> +	return ret;
> +}

retmap_update_bits() will return 0 on a successful write...

> +static int pcmdev_put_volsw(struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_value *ucontrol, int vol_ctrl_type)
> +{

> +	err = pcmdev_dev_update_bits(pcm_dev, dev_no, reg, val_mask, val);
> +	if (err)
> +		dev_err(pcm_dev->dev, "%s:update_bits, ERROR, E=%d\n",
> +			__func__, err);
> +
> +	mutex_unlock(&pcm_dev->codec_lock);
> +	return err;

..so this and other controls will return 0 when the value changes,
brekaing event generation.  Please use the mixer-test kselftest to check
for this and other issues.

> +static int pcmdevice_codec_probe(struct snd_soc_component *codec)
> +{

> +	/* device-name[defined in pcmdevice_i2c_id]-i2c-bus_id[0,1,...,N]-
> +	 * sum[1,2,...,4]dev-reg.bin stores the firmware including register
> +	 * setting and params for different filters inside chips, it must be
> +	 * copied into firmware folder. The same types of pcmdevices sitting
> +	 * on the same i2c bus will be aggregated as one single codec,
> +	 * all of them share the same bin file.
> +	 */
> +	scnprintf(pcm_dev->regbin_name, PCMDEVICE_REGBIN_FILENAME_LEN,
> +		"%s-i2c-%d-%udev-reg.bin", pcm_dev->dev_name, adap->nr,
> +		pcm_dev->ndev);
> +
> +	ret = request_firmware_nowait(THIS_MODULE, FW_ACTION_UEVENT,
> +		pcm_dev->regbin_name, pcm_dev->dev, GFP_KERNEL, pcm_dev,
> +		pcmdev_regbin_ready);
> +	if (ret) {
> +		dev_err(pcm_dev->dev, "load %s error = %d\n",
> +			pcm_dev->regbin_name, ret);
> +		goto out;
> +	}

This does still seem like it'd be better placed in the main probe()
function with the component registration happening once firmware is
ready so...

> +static int pcmdevice_startup(struct snd_pcm_substream *substream,
> +	struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_component *codec = dai->component;
> +	struct pcmdevice_priv *pcm_priv = snd_soc_component_get_drvdata(codec);
> +
> +	if (pcm_priv->fw_state != PCMDEVICE_FW_LOAD_OK) {
> +		dev_err(pcm_priv->dev, "DSP bin file not loaded\n");
> +		return -EBUSY;
> +	}
> +
> +	return 0;
> +}

..issues like this can be avoided.  The device is fundamentally reliant
on the firmware being there AFAICT.

> +
> +		} else
> +			dev_err(pcm_dev->dev, "%s: GPIO %d request error\n",
> +				__func__, pcm_dev->irq_info.gpio);
> +	} else
> +		dev_err(pcm_dev->dev, "Looking up irq-gpio failed %d\n",
> +			pcm_dev->irq_info.gpio);

If one side of the if/else has a braces both should.

--GVpQNZhUL4tDuEAO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXA+QYACgkQJNaLcl1U
h9Baxwf/UwNBAiiC4ati9dw7ukq1Tllnshu6jV0qXya/RRLvUIki4AsbMjqg/W3V
Qc3e6dtcKLCBYGDxcNqpJRQDCwTjbusYvWvF5ZcXrPoLDVSVeInIctkUALopLlFs
1T2UY86bZ/ikv/4NJI/qc6r04ibK+cEa1TTjfA1j/GWEtzKBE4AU6qMhwN2BnRm2
ADElVSM3dbrkM5hC9N+/kef+gc+wc3kfVPuYu/w1UyHLIDb7vIsQ47DKp+VJabvJ
t6eLFIEu1B+9US29BUEmcrVkK2zA7czWxiD8YpOjX6mMA9X0aPkFfBiV3TNpmECB
qMPlBr4F3cDcGCioXrh0JkW/badInA==
=BXQw
-----END PGP SIGNATURE-----

--GVpQNZhUL4tDuEAO--

