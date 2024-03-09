Return-Path: <linux-kernel+bounces-98007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8F387733E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 19:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B1D41F21B6B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 18:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0DA2E410;
	Sat,  9 Mar 2024 18:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3fYRFtY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F403E22F1E;
	Sat,  9 Mar 2024 18:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710008935; cv=none; b=FwmaMfWi+oifl0gieK+uyRpoQx2r15Ls7Qfy++6FX4zV8yIWLiayBfDn/59CCsIFuLV1N14Mmj8TARdfjrRF918avoPh9BybnJGgOLA9gaD3D8aMng5I6maQi4CBjYXkErboTbEfROXG0yGCyVZo3sYy1oIw79E22s6XEeypvp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710008935; c=relaxed/simple;
	bh=L2wcmhVQaFqLWuk8FiLWZYZW1meGlQie24CMyuszByI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=phDDZpgVRSET+Qdjmqx3q1BzqJS1x8PfjJq6iZdWhdHNjNfWUh1ukRyo89JdLT1hSzvIBcB0h0dCa3ELI6kOYW+RaSGSaNRA9qRUMqJC8eHb69P/0lZl+hLtElfKF+/9HEsu5KMV3x7rp5VJ5b49UjODk+zGbE4qMqfEeSuH0mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3fYRFtY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4050DC433C7;
	Sat,  9 Mar 2024 18:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710008934;
	bh=L2wcmhVQaFqLWuk8FiLWZYZW1meGlQie24CMyuszByI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n3fYRFtY6B2ykMQMKc9V0O7oABQikIpa+P9sEEvHOGogTe3xbIXXpT/uKMWrQmZgQ
	 1/CpoQ51vCvShNX8nNhR1xdJmogVPWALnL+eJK75/jPXNlitKE+mPzR9RpHk+9CQPF
	 AbnT7bYe3G8tJquv3MCZ/+wSoLzJkXJ1SUOXKKOW/EndG8vFEpNamIK7pkj6nEkwIp
	 QZPBid9T0Pg2TFXhUW6aQR/iePxZqWAKR+WSXcPAN677PI/tmo/3BVpPXDlRo2OwmU
	 dPiP59qQFUr5rAkOKbQV65fkZLBApwMO0IOV+/3xSjJYTmXzwl6ge122pP4Xsuy/8F
	 GhJQR+jbFx1gQ==
Date: Sat, 9 Mar 2024 18:28:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, mazziesaccount@gmail.com, ak@it-klinger.de,
 petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: pressure: Add scale value for channels
Message-ID: <20240309182842.1fc7b676@jic23-huawei>
In-Reply-To: <20240303165300.468011-3-vassilisamir@gmail.com>
References: <20240303165300.468011-1-vassilisamir@gmail.com>
	<20240303165300.468011-3-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  3 Mar 2024 17:52:58 +0100
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Add extra IIO_CHAN_INFO_SCALE in order to be able to have the scales
> for the values in userspace. Can be used for triggered buffers.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>

So providing scale and processed is a mess. With hindsight this should have
always provided raw + scale, but too late :(

This retrofitting buffered code onto a drive that does processed channels
is one of the few reasons I'll let through channels that do both processed and raw.
So add raw as well. Hopefully raw * scale always equals processed.

The reason is that for a channel doing processed only - assumption is
normally that the buffer is processed as well. We can't remove processed
as that would be ABI breakage, but we can add raw.

Jonathan

> ---
>  drivers/iio/pressure/bmp280-core.c | 70 ++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 29a8b7195076..acdf6138d317 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -138,16 +138,19 @@ static const struct iio_chan_spec bmp280_channels[] = {
>  	{
>  		.type = IIO_PRESSURE,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +				      BIT(IIO_CHAN_INFO_SCALE) |
>  				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
>  	},
>  	{
>  		.type = IIO_TEMP,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +				      BIT(IIO_CHAN_INFO_SCALE) |
>  				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
>  	},
>  	{
>  		.type = IIO_HUMIDITYRELATIVE,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +				      BIT(IIO_CHAN_INFO_SCALE) |
>  				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
>  	},
>  };
> @@ -156,6 +159,7 @@ static const struct iio_chan_spec bmp380_channels[] = {
>  	{
>  		.type = IIO_PRESSURE,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +				      BIT(IIO_CHAN_INFO_SCALE) |
>  				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
>  		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>  					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
> @@ -163,6 +167,7 @@ static const struct iio_chan_spec bmp380_channels[] = {
>  	{
>  		.type = IIO_TEMP,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +				      BIT(IIO_CHAN_INFO_SCALE) |
>  				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
>  		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>  					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
> @@ -170,6 +175,7 @@ static const struct iio_chan_spec bmp380_channels[] = {
>  	{
>  		.type = IIO_HUMIDITYRELATIVE,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +				      BIT(IIO_CHAN_INFO_SCALE) |
>  				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
>  		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>  					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
> @@ -487,6 +493,70 @@ static int bmp280_read_raw(struct iio_dev *indio_dev,
>  			break;
>  		}
>  		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_HUMIDITYRELATIVE:
> +			if (!strcmp(indio_dev->name, "bme280")) {
> +				*val = 1000;
> +				*val2 = 1024;
> +				ret = IIO_VAL_FRACTIONAL;
> +			} else {
> +				ret = -EINVAL;
> +			}
> +			break;
> +		case IIO_PRESSURE:
> +			if ((!strcmp(indio_dev->name, "bmp085")) ||
> +			    (!strcmp(indio_dev->name, "bmp180")) ||
> +			    (!strcmp(indio_dev->name, "bmp181"))) {
> +				*val = 1;
> +				*val2 = 1000;
> +				ret = IIO_VAL_FRACTIONAL;
> +			} else if ((!strcmp(indio_dev->name, "bmp280")) ||
> +				   (!strcmp(indio_dev->name, "bme280"))) {
> +				*val = 1;
> +				*val2 = 256000;
> +				ret = IIO_VAL_FRACTIONAL;
> +			} else if (!strcmp(indio_dev->name, "bmp380")) {
> +				*val = 1;
> +				*val2 = 100000;
> +				ret = IIO_VAL_FRACTIONAL;
> +			} else if (!strcmp(indio_dev->name, "bmp580")) {
> +				*val = 1;
> +				*val2 = 64000;
> +				ret = IIO_VAL_FRACTIONAL;
> +			} else {
> +				ret = -EINVAL;
> +			}
> +			break;
> +		case IIO_TEMP:
> +			if ((!strcmp(indio_dev->name, "bmp085")) ||
> +			    (!strcmp(indio_dev->name, "bmp180")) ||
> +			    (!strcmp(indio_dev->name, "bmp181"))) {
> +				*val = 100;
> +				*val2 = 1;
> +				ret = IIO_VAL_FRACTIONAL;
> +			} else if ((!strcmp(indio_dev->name, "bmp280")) ||
> +				   (!strcmp(indio_dev->name, "bme280"))) {
> +				*val = 10;
> +				*val2 = 1;
> +				ret = IIO_VAL_FRACTIONAL;
> +			} else if (!strcmp(indio_dev->name, "bmp380")) {
> +				*val = 10;
> +				*val2 = 1;
> +				ret = IIO_VAL_FRACTIONAL;
> +			} else if (!strcmp(indio_dev->name, "bmp580")) {
> +				*val = 1000;
> +				*val2 = 16;
> +				ret = IIO_VAL_FRACTIONAL_LOG2;
> +			} else {
> +				ret = -EINVAL;
> +			}
> +			break;
> +		default:
> +			ret = -EINVAL;
> +			break;
> +		}
> +		break;
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>  		switch (chan->type) {
>  		case IIO_HUMIDITYRELATIVE:


