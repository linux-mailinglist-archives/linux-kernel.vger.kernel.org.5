Return-Path: <linux-kernel+bounces-83533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FDA869AF4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7D911C20E40
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CC6146908;
	Tue, 27 Feb 2024 15:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0NP/5Lv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA128145B09;
	Tue, 27 Feb 2024 15:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709048788; cv=none; b=CX8DW8WjeHtFHyGLg/kiek5yLbXf+76laCl24cg1omjXEgjwKs7/WnvndujICUz6d04TTgDN9zJhowrJk0tc9UCxXLEsQdP9uREnDTnt4H9d898+Unn13vIpDGdPdHQVeTgQik14DTGVa8IJy+Elyac0YPtgR2wOFA3IKmAkTOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709048788; c=relaxed/simple;
	bh=NBx9tvmKwEqoQnhtitPC+pDa9PzOIcQYFJVbd2LxzdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUZblNeCPmk6EDrLGItdSdJtoLLCdk9EHTxDcaIAQLOYjfF3+N4WO8sTrfhwskI4iy2HdEL97Xv7Rwy8rzVio7PkWGaZ1QPVFSeK2ikQERxx94ZS/GMoDQzrpI5oKUf8LxbjbINQ6OquJGVeM5pYxlgGm8GrdT66620o2xxf58M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0NP/5Lv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B4CFC433F1;
	Tue, 27 Feb 2024 15:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709048788;
	bh=NBx9tvmKwEqoQnhtitPC+pDa9PzOIcQYFJVbd2LxzdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a0NP/5LvisMSpubv7WhZLqjoPbQzydNaAKz27SrNhnhKQC5xhsGBXugMa0Fp6fht3
	 y6a8eA4xwqUPQR36iF9x3/CdXiSsTUw/m9jWvnImhfMHUj5/+CI6bK6Hqf4i9xil3Z
	 v0UOqNH9gK9aKeujipZGRz6rK98sEsf8cfjMv5heyWgKT4sYaJpYaUe0bWM6qBDT1A
	 4PaPMaFLE+M5bp9UQaHACG3m5PruDxyQSmxs0kXftMtONsnttZVRR3V+TUXPRWMiz9
	 fBbFq9TAfzgueW2xj2ujZ5dJ8B4J/7XlklL1KebQ27m2z42EjzkbkgRz3mEypkvUIx
	 ZW0AGqLBN8WuQ==
Date: Tue, 27 Feb 2024 15:46:21 +0000
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: linux-kernel@vger.kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	perex@perex.cz, tiwai@suse.com, 13916275206@139.com,
	mohit.chawla@ti.com, soyer@irl.hu, jkhuang3@ti.com, tiwai@suse.de,
	pdjuandi@ti.com, manisha.agrawal@ti.com, s-hari@ti.com,
	aviel@ti.com, hnagalla@ti.com, praneeth@ti.com
Subject: Re: [PATCH v6 1/4] ASoc: PCM6240: Create PCM6240 Family driver code
Message-ID: <0cba2632-5d79-488a-9eec-dbed4208971b@sirena.org.uk>
References: <20240223123809.503-1-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q/NIaDdKYiyeWvDU"
Content-Disposition: inline
In-Reply-To: <20240223123809.503-1-shenghao-ding@ti.com>
X-Cookie: Please go away.


--q/NIaDdKYiyeWvDU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 23, 2024 at 08:38:04PM +0800, Shenghao Ding wrote:

> +static const char *const pcmdev_ctrl_name[] = {
> +	"%s-i2c-%d-dev%d-ch%d-ana-gain",
> +	"%s-i2c-%d-dev%d-ch%d-digi-gain",
> +	"%s-i2c-%d-dev%d-ch%d-fine-gain",
> +};

So, I see why you're doing this naming thing for the per-device controls
- the device can (and is designed to) allow controlling multiple amps
with a single I2C write.  However this is resulting in something that's
really awkward from an ALSA point of view, the names that are being
generated are very much not idiomatic for control names and probably
aren't going to be terribly meaningful for end users since they're not
associated with where the relevant outputs physically are.  We could
require machines to provide names for everything but that's probably
going to be a miserable experience on x86 and is unhelpful even with DT
so having a default seems to make sense.

I think these should look more like ALSA names, so "I2C %d Device %d..."
though that does make things a bit longer.

> +static const char *const pcmdev_ctrl_name_with_prefix[] = {
> +	"%s-dev%d-ch%d-ana-gain",
> +	"%s-dev%d-ch%d-digi-gain",
> +	"%s-dev%d-ch%d-fine-gain",
> +};

For these I'm not clear why we don't just use the name, what's the goal
in having the device number in there?

I think it would make sense to do a version the driver with no user
visible controls (or at least none that need this name generation stuff)
and then make the controls an incremental patch, the driver would
obviously need both bits to be properly useful but it'd mean that the
simple bit could get reviewed and possibly merged separately to the
complicated bit which would probably be easier.

Please also send the output of mixer-test from a machine with this
driver in it as part of the cover letter, it'll make it easier to tell
what's going on.

> +	if (comp->name_prefix) {
> +	/* There's name_prefix defined in DTS. Bin file name will be
> +	 * name_prefix.bin stores the firmware including register setting and
> +	 * params for different filters inside chips, it must be copied into

The comment should be indented like it's inside the if ().

> +	} else {
> +	/* There's NO name_prefix defined in DTS. Bin file name will be
> +	 * device-name[defined in pcmdevice_i2c_id]-i2c-bus_id[0,1,...,N]-
> +	 * sum[1,...,4]dev.bin stores the firmware including register setting
> +	 * and params for different filters inside chips, it must be copied
> +	 * into firmware folder. The same types of pcmdevices sitting on the
> +	 * same i2c bus will be aggregated as one single codec, all of them
> +	 * share the same bin file.
> +	 */
> +		scnprintf(pcm_dev->bin_name, PCMDEVICE_BIN_FILENAME_LEN,
> +			"%s-i2c-%d-%udev.bin", pcm_dev->dev_name, adap->nr,
> +			pcm_dev->ndev);
> +	}

You could also do this as a fallback (ie, try the specified name first
then fall bakc to the bus based numbering), that way if a name is added
later it won't break people's installs on upgrade.

> +static const struct regmap_config pcmdevice_i2c_regmap = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.cache_type = REGCACHE_MAPLE,
> +	.ranges = pcmdevice_ranges,
> +	.num_ranges = ARRAY_SIZE(pcmdevice_ranges),
> +	.max_register = 256 * 128,
> +};

Shouldn't there be some volatile registers if we have interrupts?

--q/NIaDdKYiyeWvDU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXeA8wACgkQJNaLcl1U
h9C3Hwf9Gmdxf4Cz4ZF49QuHRx9unEzbCoT6YJxHKoeWCY8Dv+nxvafUfp8NqeXG
eGHw314ytCKdPKj65J0ef3jupWrB3Z4euByOjCBvtRRriVqmCPMdhaCVFA8kKr9U
SyiqAm1z9t9LCeKVcFcKsh6Bc8H+oqx4E1z7IJ91TUhfD+1kK/c2iFyIDb1hjZis
1TXj1840PpqIH62vmfWeYv08SpEKNryODarBU/DZXyDtNewADHC2MLYOJF29PMhb
GeGwOckFtxAwHkkrtwAkaM6V9bRSQ843E4UmDMH60Cm6XlweK32rP1TGsrUR7llO
4vWck8vZ4ivdI5DSDA9rN/KXP62dWA==
=J6Xo
-----END PGP SIGNATURE-----

--q/NIaDdKYiyeWvDU--

