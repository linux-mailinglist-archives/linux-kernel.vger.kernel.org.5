Return-Path: <linux-kernel+bounces-112679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A16887CE4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 14:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C9B8B20EB5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 13:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A47C17C71;
	Sun, 24 Mar 2024 13:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nvwfy8ON"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E82217BD8;
	Sun, 24 Mar 2024 13:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711287486; cv=none; b=Ce/xurh2nhVYhbkN+aF++HUzo22gGfsVdrwcdQwN6Qz+yJsuSAHMAdoQuxkOaFnrAr7pwu3kccTHUVJdLAsQKd4MQqr7ThuLocAjvBWdgOjVKF1Jqhr/lY402BhHdn4zTifHIxu7NSxxgFgGMS51al27Eod1Sd/1sSjY0AYd5/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711287486; c=relaxed/simple;
	bh=CfPLowhVJWOgHSpIDdiRA2W3/MXOWwK0oT2i32knapo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NxjeeQ3Fnch0l/qUpitWu5LrK7Wr5hZCAt5CgE9oX/9pIQkucZd58Bel/QeXAngGlKCc4TFJ2v6zZ7i0bybvll3qNnNSo4pqs+UDIN21E+DQPgTWPgYE8/O5qDw98rKNmQVF0nP24MVvcpmkBLWuVaxab16o50576wnh8m93rFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nvwfy8ON; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7CBC433C7;
	Sun, 24 Mar 2024 13:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711287485;
	bh=CfPLowhVJWOgHSpIDdiRA2W3/MXOWwK0oT2i32knapo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Nvwfy8ONivkIFPmVWdx15JfEoa6wfD/HQtoReundd1lzpXBvRCKc6JLBarvEy5ezg
	 JUd61M9giQ+6TQIswk6W37druB5ziRi6JpCd8C8aM3bDxRf2XUba5VtQPFAG0VPXoS
	 3AP1m6NRFv+E9PPc5trbrN1cJgAwTqsqHrleUDljkg9g+BVjuDC8mc953uFerj+r80
	 6KJx1/ky2qBZj3XAq3631o2Fs7cTfbIzWy6FmMagZz3X9Y+qwUdWNWtaA2VDFZk/6w
	 AT5446lVsdcmZ2k//A1wp5fuxfwaOo6llw5oA52iNXRyoXR1IXmJV3z9P55IUCmSRX
	 89a1C8kQi1a9g==
Date: Sun, 24 Mar 2024 13:37:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, eraretuya@gmail.com
Subject: Re: [PATCH v3 5/6] iio: accel: adxl345: Group bus configuration
Message-ID: <20240324133749.636e1df4@jic23-huawei>
In-Reply-To: <20240323122030.21800-6-l.rubusch@gmail.com>
References: <20240323122030.21800-1-l.rubusch@gmail.com>
	<20240323122030.21800-6-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 23 Mar 2024 12:20:29 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> In the probe function group bus configuration and the
> indio_dev initialization to improve readability. Add a
> comment to the probe function to explain function arguments.
Doing 2 unrelated things. 2 Patches.

> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl345_core.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index e3718d0dd..662628cdf 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -209,6 +209,16 @@ static void adxl345_powerdown(void *regmap)
>  	regmap_write(regmap, ADXL345_REG_POWER_CTL, ADXL345_POWER_CTL_STANDBY);
>  }
>  
> +/**
> + * adxl345_core_probe() - probe and setup for the adxl345 accelerometer,
> + *                        also covers the adlx375 accelerometer
> + * @dev:	Driver model representation of the device
> + * @regmap:	Regmap instance for the device
> + * @setup:	Setup routine to be executed right before the standard device
> + *		setup, can also be set to NULL if not required
 * @setup:	Optional setup routine to be executed right before standard
 *		device setup.

For a function pointer, optional implies NULL if you don't want it.

> + *
> + * Return: 0 on success, negative errno on error
> + */
>  int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  	int (*setup)(struct device*, struct regmap*))
>  {
> @@ -238,22 +248,23 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  
>  	data = iio_priv(indio_dev);
>  	data->regmap = regmap;
> -	/* Enable full-resolution mode */
> +
>  	data->info = device_get_match_data(dev);
>  	if (!data->info)
>  		return -ENODEV;
>  
> -	ret = regmap_update_bits(regmap, ADXL345_REG_DATA_FORMAT,
> -				 ADXL345_DATA_FORMAT_MSK, ADXL345_DATA_FORMAT_FULL_RES);
> -	if (ret)
> -		return dev_err_probe(dev, ret, "Failed to set data range\n");
> -
>  	indio_dev->name = data->info->name;
>  	indio_dev->info = &adxl345_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = adxl345_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(adxl345_channels);
>  
> +	/* Enable full-resolution mode */
> +	ret = regmap_update_bits(regmap, ADXL345_REG_DATA_FORMAT,
> +				 ADXL345_DATA_FORMAT_MSK, ADXL345_DATA_FORMAT_FULL_RES);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to set data range\n");
> +
>  	/* Enable measurement mode */
>  	ret = adxl345_powerup(data->regmap);
>  	if (ret < 0)


