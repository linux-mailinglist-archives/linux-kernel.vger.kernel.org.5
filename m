Return-Path: <linux-kernel+bounces-143817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 978418A3DCC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 18:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 037C01F21807
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 16:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6237945034;
	Sat, 13 Apr 2024 16:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qu2XvNrE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874C652F61;
	Sat, 13 Apr 2024 16:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713027521; cv=none; b=kt6AO19etE0l3C9TiNt9MwGH2j2EtwwJwJMosepKicS0ToCigRf8l4emsLGWM//6gVjUehwNjvNcDgQqDx3dhbxMEGsGSGze3Uc2Cbiz/e5fKBL/43jP0fn8MSge/kJtIUSWk+c5c6Sv1TUyr8ZAhJmFbZ4Vk+ssNIHZwYfGPvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713027521; c=relaxed/simple;
	bh=YvxTBCT3L9qSCB4QszH6PYF5IkYVlpxMrd4uOhksnpo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=awuxqv/mfsa5S2IV6rUuFYA2IkZ/fxen7KaLhHF/6GZysN7dPVc2xUTzrk5fk1JnU3Ux3En45EipVaZYCBhU9oEuh2074+5loslqcpWxA0QjP4bJot2BQCFD9ZvurW//OrQ91uSSix6khzrTnEBVE5MQysjsoi9hNvgxBsrRkYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qu2XvNrE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD17C113CD;
	Sat, 13 Apr 2024 16:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713027521;
	bh=YvxTBCT3L9qSCB4QszH6PYF5IkYVlpxMrd4uOhksnpo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qu2XvNrEMP5Ae4MsnB9BVDjv/8YgbYr24/eAcGhiV6G3tuuMOMrFiYFKkC1o5PBJQ
	 ONlG7ZCBgankGRrG35sX6zAkJtZi/hnV6wEyoQMi0so6G5cqlt6tRQTfEkEHabUxxm
	 hfEufLrxF9wVDO6f5/5Ts+35v9wWDqde2hvEnbS1h8/CP5WzFRtocP4cqWR0LianSj
	 0fff22Z3Ri2J7yeoK4QGipXawk7J8GbZeeJKN93rSJw4YzqRMwpzzqipqYkkBlZvYQ
	 8H3UjlbSI+cOOXcNLw9XhIDH7SCBxDUlKr91htsbvmbpP1aJgcKdywtznqDCdhbws7
	 xw2lJZkSI67IQ==
Date: Sat, 13 Apr 2024 17:58:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, mazziesaccount@gmail.com, ak@it-klinger.de,
 petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
 u.kleine-koenig@pengutronix.de, biju.das.jz@bp.renesas.com,
 linus.walleij@linaro.org, semen.protsenko@linaro.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v4 3/6] iio: pressure: bmp280: Introduce new cleanup
 routines
Message-ID: <20240413175824.561e361d@jic23-huawei>
In-Reply-To: <20240407172920.264282-4-vassilisamir@gmail.com>
References: <20240407172920.264282-1-vassilisamir@gmail.com>
	<20240407172920.264282-4-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  7 Apr 2024 19:29:17 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Introduce new linux/cleanup.h with the guard(mutex) functionality
> in the {read,write}_raw() functions.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
A could of corners of dead code that you can remove.

In general looks good.

Jonathan

> ---
>  drivers/iio/pressure/bmp280-core.c | 129 +++++++++++++----------------
>  1 file changed, 58 insertions(+), 71 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 50bdf79011bc..51bcdf8cede6 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -27,6 +27,7 @@
>  
>  #include <linux/bitops.h>
>  #include <linux/bitfield.h>
> +#include <linux/cleanup.h>
>  #include <linux/completion.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
> @@ -499,77 +500,69 @@ static int bme280_read_humid(struct bmp280_data *data, int *val, int *val2)
>  	return IIO_VAL_INT;
>  }
>  
> -static int bmp_read_raw(struct iio_dev *indio_dev,
> -			struct iio_chan_spec const *chan,
> -			int *val, int *val2, long mask)
> +static int bmp_read_raw_impl(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
>  {
>  	struct bmp280_data *data = iio_priv(indio_dev);
> -	int ret;
>  
> -	pm_runtime_get_sync(data->dev);
> -	mutex_lock(&data->lock);
> +	guard(mutex)(&data->lock);
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_PROCESSED:
>  		switch (chan->type) {
>  		case IIO_HUMIDITYRELATIVE:
> -			ret = data->chip_info->read_humid(data, val, val2);
> -			break;
> +			return data->chip_info->read_humid(data, val, val2);
>  		case IIO_PRESSURE:
> -			ret = data->chip_info->read_press(data, val, val2);
> -			break;
> +			return data->chip_info->read_press(data, val, val2);
>  		case IIO_TEMP:
> -			ret = data->chip_info->read_temp(data, val, val2);
> -			break;
> +			return data->chip_info->read_temp(data, val, val2);
>  		default:
> -			ret = -EINVAL;
> -			break;
> +			return -EINVAL;
>  		}
> -		break;
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>  		switch (chan->type) {
>  		case IIO_HUMIDITYRELATIVE:
>  			*val = 1 << data->oversampling_humid;
> -			ret = IIO_VAL_INT;
> -			break;
> +			return IIO_VAL_INT;
>  		case IIO_PRESSURE:
>  			*val = 1 << data->oversampling_press;
> -			ret = IIO_VAL_INT;
> -			break;
> +			return IIO_VAL_INT;
>  		case IIO_TEMP:
>  			*val = 1 << data->oversampling_temp;
> -			ret = IIO_VAL_INT;
> -			break;
> +			return IIO_VAL_INT;
>  		default:
> -			ret = -EINVAL;
> -			break;
> +			return -EINVAL;
>  		}
> -		break;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		if (!data->chip_info->sampling_freq_avail) {
> -			ret = -EINVAL;
> -			break;
> -		}
> +		if (!data->chip_info->sampling_freq_avail)
> +			return -EINVAL;
>  
>  		*val = data->chip_info->sampling_freq_avail[data->sampling_freq][0];
>  		*val2 = data->chip_info->sampling_freq_avail[data->sampling_freq][1];
> -		ret = IIO_VAL_INT_PLUS_MICRO;
> -		break;
> +		return IIO_VAL_INT_PLUS_MICRO;
>  	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> -		if (!data->chip_info->iir_filter_coeffs_avail) {
> -			ret = -EINVAL;
> -			break;
> -		}
> +		if (!data->chip_info->iir_filter_coeffs_avail)
> +			return -EINVAL;
>  
>  		*val = (1 << data->iir_filter_coeff) - 1;
> -		ret = IIO_VAL_INT;
> -		break;
> +		return IIO_VAL_INT;
>  	default:
> -		ret = -EINVAL;
> -		break;
> +		return -EINVAL;
>  	}
>  
> -	mutex_unlock(&data->lock);
> +	return 0;
As below. I don't think you can get here.  I hope all paths have already returned.

> +}
> +
> +static int bmp_read_raw(struct iio_dev *indio_dev,
> +			struct iio_chan_spec const *chan,
> +			int *val, int *val2, long mask)
> +{
> +	struct bmp280_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	pm_runtime_get_sync(data->dev);
> +	ret = bmp_read_raw_impl(indio_dev, chan, val, val2, mask);
>  	pm_runtime_mark_last_busy(data->dev);
>  	pm_runtime_put_autosuspend(data->dev);
>  
> @@ -697,12 +690,13 @@ static int bmp_write_iir_filter_coeffs(struct bmp280_data *data, int val)
>  	return -EINVAL;
>  }
>  
> -static int bmp_write_raw(struct iio_dev *indio_dev,
> -			 struct iio_chan_spec const *chan,
> -			 int val, int val2, long mask)
> +static int bmp_write_raw_impl(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int val, int val2, long mask)
>  {
>  	struct bmp280_data *data = iio_priv(indio_dev);
> -	int ret = 0;
> +
> +	guard(mutex)(&data->lock);
>  
>  	/*
>  	 * Helper functions to update sensor running configuration.
> @@ -712,46 +706,39 @@ static int bmp_write_raw(struct iio_dev *indio_dev,
>  	 */
>  	switch (mask) {
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> -		pm_runtime_get_sync(data->dev);
> -		mutex_lock(&data->lock);
>  		switch (chan->type) {
>  		case IIO_HUMIDITYRELATIVE:
> -			ret = bmp_write_oversampling_ratio_humid(data, val);
> -			break;
> +			return bmp_write_oversampling_ratio_humid(data, val);
>  		case IIO_PRESSURE:
> -			ret = bmp_write_oversampling_ratio_press(data, val);
> -			break;
> +			return bmp_write_oversampling_ratio_press(data, val);
>  		case IIO_TEMP:
> -			ret = bmp_write_oversampling_ratio_temp(data, val);
> -			break;
> +			return bmp_write_oversampling_ratio_temp(data, val);
>  		default:
> -			ret = -EINVAL;
> -			break;
> +			return -EINVAL;
>  		}
> -		mutex_unlock(&data->lock);
> -		pm_runtime_mark_last_busy(data->dev);
> -		pm_runtime_put_autosuspend(data->dev);
> -		break;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		pm_runtime_get_sync(data->dev);
> -		mutex_lock(&data->lock);
> -		ret = bmp_write_sampling_frequency(data, val, val2);
> -		mutex_unlock(&data->lock);
> -		pm_runtime_mark_last_busy(data->dev);
> -		pm_runtime_put_autosuspend(data->dev);
> -		break;
> +		return bmp_write_sampling_frequency(data, val, val2);
>  	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> -		pm_runtime_get_sync(data->dev);
> -		mutex_lock(&data->lock);
> -		ret = bmp_write_iir_filter_coeffs(data, val);
> -		mutex_unlock(&data->lock);
> -		pm_runtime_mark_last_busy(data->dev);
> -		pm_runtime_put_autosuspend(data->dev);
> -		break;
> +		return bmp_write_iir_filter_coeffs(data, val);
>  	default:
>  		return -EINVAL;
>  	}
>  
> +	return 0;
I'm fairly sure you can't get here so this is dead code. Hene
drop this final return.

> +}

>  


