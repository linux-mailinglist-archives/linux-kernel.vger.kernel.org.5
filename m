Return-Path: <linux-kernel+bounces-133116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABE7899F12
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A607B2123D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFF816E89B;
	Fri,  5 Apr 2024 14:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nh0miAyy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0E016D9D1;
	Fri,  5 Apr 2024 14:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712326193; cv=none; b=oDwmrRuw+scAn5SEinXbibRSvkkMeLrP4PN3forCw6W/Y8GolIUrTnCWtgrV8hqN6ghY0c3AzPlUXzEMF+h4Q9jo33LKBQp9FChEWZdkkCCPycd9BRqK7OvGr9jS7ztzEPqmeDFyGYLNHNx7bPq5yrT/BUdIAXNCxzntryYsNQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712326193; c=relaxed/simple;
	bh=cnrxDzXd1/Zz7OjSfw40jDJ0E7JSzUp/GezENfo8XHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mP+u3ZPahpUkd9JG7l/rqzqr3EYjMhYYbuwyO/YpznvQ8SHI7ZNVXjCsp2aWoRSjjEzwrZ5Sr3QumvN8Y9LlUhC1v1W7HMp4ckA5oSJiLKsDwcK93AIkILhyIOueV8bViDiK9mzePhq4ynr3G1rimkUVm0F3rcNJnrWyBsGM1u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nh0miAyy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B27AC433F1;
	Fri,  5 Apr 2024 14:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712326193;
	bh=cnrxDzXd1/Zz7OjSfw40jDJ0E7JSzUp/GezENfo8XHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nh0miAyy9/qk0l633k/apXAeuCAu0WCqUlCM5Dl+p/Lu3KpcT2Ozmm0u0DngGulRt
	 fHWQhPOSUTNxHvH7L/ssLzPYMqbsnSZKOc673X1EMymNb8bM715PCfZH5K4FNrOqin
	 uPefYhwuuZrs8Ps1Xx7IjK3bIRbucl53oIlgs47BSkWo94RWUSrKb0qU5iHq+ga40+
	 Jq8va0mUr5Ead9a/N3lXvDmryg8hUKAlMnPQlHRAa6Y5FnkyPLneXUOIaN+COlZYQG
	 gvX3cfMxtKfIBfTNhAqNdbo7PKYrCUZGG6+j6dSTbnWJ9UcqP/ISksVJ86Mlrh0DpQ
	 403WyqEA359yQ==
Date: Fri, 5 Apr 2024 15:09:46 +0100
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: linux-kernel@vger.kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	perex@perex.cz, tiwai@suse.com, 13916275206@139.com,
	mohit.chawla@ti.com, soyer@irl.hu, jkhuang3@ti.com, tiwai@suse.de,
	pdjuandi@ti.com, manisha.agrawal@ti.com, aviel@ti.com,
	hnagalla@ti.com, praneeth@ti.com, Baojun.Xu@fpt.com
Subject: Re: [PATCH v8 1/4] ASoc: PCM6240: Create PCM6240 Family driver code
Message-ID: <dc5dad72-09cc-4001-afdc-1cd92cac312e@sirena.org.uk>
References: <20240403003159.389-1-shenghao-ding@ti.com>
 <20240403003159.389-2-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zE+8122Hjp+Flwjb"
Content-Disposition: inline
In-Reply-To: <20240403003159.389-2-shenghao-ding@ti.com>
X-Cookie: Honk if you love peace and quiet.


--zE+8122Hjp+Flwjb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 03, 2024 at 08:31:55AM +0800, Shenghao Ding wrote:

> +static const char *const pcmdev_ctrl_name[] = {
> +	"%s-i2c-%d-dev%d-ch%d-ana-gain",
> +	"%s-i2c-%d-dev%d-ch%d-digi-gain",
> +	"%s-i2c-%d-dev%d-ch%d-fine-gain",
> +};
> +
> +static const char *const pcmdev_ctrl_name_with_prefix[] = {
> +	"%s-dev%d-ch%d-ana-gain",
> +	"%s-dev%d-ch%d-digi-gain",
> +	"%s-dev%d-ch%d-fine-gain",
> +};

These still don't look like idiomatic ALSA control names, if nothing
else volume controls should end with Volume but the whole all lower case
with -s thing really isn't idiomatic.

> +static int pcmdev_put_volsw(struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_value *ucontrol, int vol_ctrl_type)
> +{

> +	err = pcmdev_dev_update_bits(pcm_dev, dev_no, reg, val_mask, val);
> +	if (err) {
> +		dev_err(pcm_dev->dev, "%s: update_bits err = %d\n",
> +			__func__, err);
> +		err = 0;
> +	}

Why don't we report errors to users?

> +		case PCMDEVICE_CMD_DELAY: {
> +			unsigned int delay_time = 0;
> +
> +			if (subblk_offset + 2 > sublocksize) {
> +				dev_err(pcm_dev->dev,
> +					"%s: deley out of boundary\n",
> +					__func__);
> +				break;
> +			}
> +			delay_time = get_unaligned_be16(&data[2]) * 1000;
> +			usleep_range(delay_time, delay_time + 50);
> +			subblk_offset += 2;
> +		}
> +			break;
> +		case PCMDEVICE_CMD_FIELD_W:
> +		if (subblk_offset + 6 > sublocksize) {
> +			dev_err(pcm_dev->dev,
> +				"%s: bit write out of memory\n", __func__);
> +			break;
> +		}
> +		ret = pcmdev_dev_update_bits(pcm_dev, chn,
> +			PCMDEVICE_REG(data[subblk_offset + 3],
> +			data[subblk_offset + 4]), data[subblk_offset + 1],
> +			data[subblk_offset + 5]);

The indentation here is all messed up, things not indented for the case
blocks and so on.

--zE+8122Hjp+Flwjb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYQBikACgkQJNaLcl1U
h9Bstgf/fZgVu4w8dXZljCEZ/q4J2JEc9LqY60UgCz5OG6rDlq7Vngmm398tJIiX
L+9sNepPJRkNh1QGaujU/yK/aB9WBkiQqEKAPmspBYbqDf1ypAPjOtP8pJeKiHc3
MyLJ/NiblAMt3+rdt23gLWhy2LV6tLAj+b/sM09vwSCVy0eqnkt+R7awszCsxb7k
ZmZ2I4JCC41iqzZlWg+8qgJTiVD8JfOHhINxj0wuYwqwtdQOqGj/sVsv3e0spq6L
aZJs4WRnnFKJy8jkrCs4TIGe2qyqnBHECYd+68hdjwuoWIjoVPqpceAIjD/HhIPG
XXfAKY4FRSJONbDd4A5685V5ctPODg==
=prZg
-----END PGP SIGNATURE-----

--zE+8122Hjp+Flwjb--

