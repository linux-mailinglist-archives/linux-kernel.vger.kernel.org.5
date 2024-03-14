Return-Path: <linux-kernel+bounces-103434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 419E487BF4A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D69FEB221FF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85971D53F;
	Thu, 14 Mar 2024 14:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPlBmEXX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BD56FE11;
	Thu, 14 Mar 2024 14:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710427734; cv=none; b=nx+2KnB8e3bxbeYinxjzIr9aGyn4r5VFOEAYOeRuIkwbgX0PUd1Be4o3SLY5LyQwaPrO6Lqf0I/ILe6TJtUn690of4pwV5HXdcDTEmsjr35nD7bLpyrXDgbV3I1wXJWxeNXV4IIGswUoIBxTPuLkCb/1xpArLeosNrvSCFQnvOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710427734; c=relaxed/simple;
	bh=rofZKpUBcRam3OvfUbeuxLCuZr4AEd3TlpTaoB/abvE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WFThUm9YbvU/gcDf47UmX06waDIBAZPl2np1reKG23EulTCLs+OpzDU4HXGhqRqHkONiHLlOrBx+fGMPotntcJHa6TyuU/Vi0QBXTltxreFPpSKeDyc5c6Pijr2jt8RhIgEtIm2AlsiN9cmiN44GOBzKwaykh7FmHvH+UE7e2gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPlBmEXX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F5CC433C7;
	Thu, 14 Mar 2024 14:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710427733;
	bh=rofZKpUBcRam3OvfUbeuxLCuZr4AEd3TlpTaoB/abvE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IPlBmEXXyfnENQWhqQBTBTmMMPtorDKGEfbTwS+9N/oaEeaqHn++kLrhpjbwnrUvC
	 SfYRpB+XeLXpk6r8sD/pDcHn1758drWWnPgYrtxrhF8ji17n7JFIpW5jotRtJMau22
	 aU5JuLYuM8J8l3ExlxbUvA6gozoasCuXcKlMz1xd0dNqhgBbdYEYl+6d/BsrtOob2r
	 U6UW2VOKPRueq/CA1TaSYPaWDjs/O5vBiJV8qvGm/RlJ/ptY/gmZu2Ylbon0/L6mfR
	 vQw5Bnd5o8KiYiQUx+C/op2PL5tLv7M4lWrxkLizoFoyJbOnK6z9gFRkifaGJoS9y/
	 AMVblH5TcCY6Q==
Date: Thu, 14 Mar 2024 14:48:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, mazziesaccount@gmail.com, ak@it-klinger.de,
 petre.rodan@subdimension.ro, linus.walleij@linaro.org,
 phil@raspberrypi.com, 579lpy@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] iio: pressure: add SCALE and RAW values for
 channels
Message-ID: <20240314144838.49b62a72@jic23-huawei>
In-Reply-To: <20240313174007.1934983-4-vassilisamir@gmail.com>
References: <20240313174007.1934983-1-vassilisamir@gmail.com>
	<20240313174007.1934983-4-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Mar 2024 18:40:04 +0100
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Add extra IIO_CHAN_INFO_SCALE and IIO_CHAN_INFO_RAW in order to be
> able to calculate the processed value with standard userspace IIO
> tools. Can be used for triggered buffers as well.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  drivers/iio/pressure/bmp280-core.c | 58 ++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index dfd845acfa22..6d7734f867bc 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -138,16 +138,22 @@ static const struct iio_chan_spec bmp280_channels[] = {
>  	{
>  		.type = IIO_PRESSURE,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |

Next to each (or at least the first) existing entry for PROCESSED add a
comment that says it is maintained for ABI backwards compatibility reasons.
I really don't want people copying the result of this patch into new drivers
- we've ended up here because of a less than ideal decision in the past, that
history doesn't apply to other drivers.

> +				      BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE) |
>  				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
>  	},
>  	{
>  		.type = IIO_TEMP,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +				      BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE) |
>  				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
>  	},
>  	{
>  		.type = IIO_HUMIDITYRELATIVE,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +				      BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE) |
>  				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
>  	},
>  };
> @@ -156,6 +162,8 @@ static const struct iio_chan_spec bmp380_channels[] = {
>  	{
>  		.type = IIO_PRESSURE,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +				      BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE) |
>  				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
>  		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>  					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
> @@ -163,6 +171,8 @@ static const struct iio_chan_spec bmp380_channels[] = {
>  	{
>  		.type = IIO_TEMP,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +				      BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE) |
>  				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
>  		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>  					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
> @@ -170,6 +180,8 @@ static const struct iio_chan_spec bmp380_channels[] = {
>  	{
>  		.type = IIO_HUMIDITYRELATIVE,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +				      BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE) |
>  				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
>  		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>  					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
> @@ -485,6 +497,52 @@ static int bmp280_read_raw(struct iio_dev *indio_dev,
>  			break;
>  		}
>  		break;
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->type) {
> +		case IIO_HUMIDITYRELATIVE:
> +			*val = data->chip_info->read_humid(data);
> +			ret = IIO_VAL_INT;
> +			break;
> +		case IIO_PRESSURE:
> +			*val = data->chip_info->read_press(data);
> +			ret = IIO_VAL_INT;
> +			break;
> +		case IIO_TEMP:
> +			*val = data->chip_info->read_temp(data);
> +			ret = IIO_VAL_INT;
> +			break;
> +		default:
> +			ret = -EINVAL;
> +			break;
> +		}
> +		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_HUMIDITYRELATIVE:
> +			*val = data->chip_info->humid_coeffs[0];
> +			*val2 = data->chip_info->humid_coeffs[1];
> +			ret = IIO_VAL_FRACTIONAL;
> +			break;
> +		case IIO_PRESSURE:
> +			*val = data->chip_info->press_coeffs[0];
> +			*val2 = data->chip_info->press_coeffs[1];
> +			ret = IIO_VAL_FRACTIONAL;
> +			break;
> +		case IIO_TEMP:
> +			*val = data->chip_info->temp_coeffs[0];
> +			*val2 = data->chip_info->temp_coeffs[1];
> +
> +			if (!strcmp(indio_dev->name, "bmp580"))
> +				ret = IIO_VAL_FRACTIONAL_LOG2;
> +			else
> +				ret = IIO_VAL_FRACTIONAL;
> +
> +			break;
> +		default:
> +			ret = -EINVAL;
> +			break;
> +		}
> +		break;
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>  		switch (chan->type) {
>  		case IIO_HUMIDITYRELATIVE:


