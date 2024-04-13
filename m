Return-Path: <linux-kernel+bounces-143832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAA48A3DFB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 19:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BD541F2191D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 17:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DFA53365;
	Sat, 13 Apr 2024 17:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ztj7BZLV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E3250A72;
	Sat, 13 Apr 2024 17:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713029221; cv=none; b=dav5oJ3GOYErSij5xUFjqOSMq/wRvR7D5QRTCd+ClQ4BQt+gzm6nnbJ+/PIlr16dJpyg88ruYVharuEPI0ZZy3KlPO8KdM0HGBz8pocsTGSBxA/XN8Vk7vv74fQ8yvTGd48l6NGBR0x2joaUm27NZdwx1lkyXuD+ex9ptw9vudo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713029221; c=relaxed/simple;
	bh=u/SAMBTjn/1RIl+MFDxpRcPT+1MsF38Z4unlvZ8guCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T6lUT261Jzti2fZVqqUS2ZUDnoUa6N9oF4dv1ZfZZ3dCBHTXRmREodlikv0OFeItHLhSveTej5PqW4wLQwfPoDkug85O3nrvp2fi//Iv7klvj8/RWOSR7WECsqxt1asY5JgdWG+O9SbGoqcJiCayetMnQbOGH6W9v0y/vbeMRXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ztj7BZLV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B465C113CD;
	Sat, 13 Apr 2024 17:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713029221;
	bh=u/SAMBTjn/1RIl+MFDxpRcPT+1MsF38Z4unlvZ8guCQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ztj7BZLV5/pioIeo9pPtQR9nmTXHqstOTjOHqW+I10j7vHKEg1KEoX7htDnclBAWr
	 AclX1XflMDzYtM447T8F8q4AXMn10RZP+R8sq1GWp0DMRnRd1kO/cRqyrs4FK/phGd
	 1P23mh6CL9h/PCOTSLGzGJQuK+aIT5Mu42fks2AY7AyrNHhXyrck8f0fHAxOpNhplz
	 8ylTx0mC01BcZeW2Acud5ATb5q0OiVzO27QV26Vq6dw3+bWiS4WEHm3QBvOW9JxZdK
	 PCT5OSkh7DnUFO1M26Qx3F9g9PXyaBmudD3g60oo/+Poaujjv1dCjSOJ7cUZQwYgqy
	 kISob1IUQxPHg==
Date: Sat, 13 Apr 2024 18:26:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: michael.hennerich@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 alexandru.tachici@analog.com, lars@metafoo.de, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 lgirdwood@gmail.com, broonie@kernel.org, andy@kernel.org,
 nuno.sa@analog.com, marcelo.schmitt@analog.com, bigunclemax@gmail.com,
 dlechner@baylibre.com, okan.sahin@analog.com, fr0st61te@gmail.com,
 alisa.roman@analog.com, marcus.folkesson@gmail.com, schnelle@linux.ibm.com,
 liambeguin@gmail.com
Subject: Re: [PATCH v5 3/5] iio: adc: ad7192: Add aincom supply
Message-ID: <20240413182642.29f7214d@jic23-huawei>
In-Reply-To: <20240413151152.165682-4-alisa.roman@analog.com>
References: <20240413151152.165682-1-alisa.roman@analog.com>
	<20240413151152.165682-4-alisa.roman@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 13 Apr 2024 18:11:50 +0300
Alisa-Dariana Roman <alisadariana@gmail.com> wrote:

> AINCOM should actually be a supply. If present and it has a non-zero
> voltage, the pseudo-differential channels are configured as single-ended
> with an offset. Otherwise, they are configured as differential channels
> between AINx and AINCOM pins.
> 
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
Hi Alisa,

Main comment here is that you can't modify the channel arrays in place
because there may be more that one instance of the hardware.
My preference would be to pick between static const iio_chan_spec
arrays depending on whether the aincom is provided or not.

Jonathan

> ---
>  drivers/iio/adc/ad7192.c | 53 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 49 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index ac737221beae..a9eb4fab39ca 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -175,7 +175,7 @@ enum {
>  struct ad7192_chip_info {
>  	unsigned int			chip_id;
>  	const char			*name;
> -	const struct iio_chan_spec	*channels;
> +	struct iio_chan_spec		*channels;
>  	u8				num_channels;
>  	const struct iio_info		*info;
>  };
> @@ -186,6 +186,7 @@ struct ad7192_state {
>  	struct regulator		*vref;
>  	struct clk			*mclk;
>  	u16				int_vref_mv;
> +	u16				aincom_mv;
>  	u32				fclk;
>  	u32				mode;
>  	u32				conf;
> @@ -745,6 +746,9 @@ static int ad7192_read_raw(struct iio_dev *indio_dev,
>  		/* Kelvin to Celsius */
>  		if (chan->type == IIO_TEMP)
>  			*val -= 273 * ad7192_get_temp_scale(unipolar);
> +		else if (st->aincom_mv && chan->channel2 == -1)
> +			*val += DIV_ROUND_CLOSEST_ULL((u64)st->aincom_mv * 1000000000,
> +						      st->scale_avail[gain][1]);
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		*val = DIV_ROUND_CLOSEST(ad7192_get_f_adc(st), 1024);
> @@ -982,7 +986,7 @@ static const struct iio_info ad7195_info = {
>  #define AD7193_CHANNEL(_si, _channel1, _address) \
>  	AD7193_DIFF_CHANNEL(_si, _channel1, -1, _address)
>  
> -static const struct iio_chan_spec ad7192_channels[] = {
> +static struct iio_chan_spec ad7192_channels[] = {
>  	AD719x_DIFF_CHANNEL(0, 1, 2, AD7192_CH_AIN1P_AIN2M),
>  	AD719x_DIFF_CHANNEL(1, 3, 4, AD7192_CH_AIN3P_AIN4M),
>  	AD719x_TEMP_CHANNEL(2, AD7192_CH_TEMP),
> @@ -994,7 +998,7 @@ static const struct iio_chan_spec ad7192_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(8),
>  };
>  
> -static const struct iio_chan_spec ad7193_channels[] = {
> +static struct iio_chan_spec ad7193_channels[] = {
No to this.

Imagine you have 2 devices wired in parallel to the same host
but only one of them is using vincomm.  Which setting you
get will depend on which order the probe happens in.

You need to take a copy of the channels array or have enough
variants that you can pick between static const arrays depending
on the setting.  If that works here that is the preferred path to
take.  Have ad7193_channels + ad7193_channels_with_vincomm or
something like that.


>  	AD7193_DIFF_CHANNEL(0, 1, 2, AD7193_CH_AIN1P_AIN2M),
>  	AD7193_DIFF_CHANNEL(1, 3, 4, AD7193_CH_AIN3P_AIN4M),
>  	AD7193_DIFF_CHANNEL(2, 5, 6, AD7193_CH_AIN5P_AIN6M),
> @@ -1048,11 +1052,27 @@ static void ad7192_reg_disable(void *reg)
>  	regulator_disable(reg);
>  }
>  
> +static int ad7192_config_channels(struct ad7192_state *st)
> +{
> +	struct iio_chan_spec *channels = st->chip_info->channels;
> +	int i;
> +
> +	if (!st->aincom_mv)
> +		for (i = 0; i < st->chip_info->num_channels; i++)
> +			if (channels[i].channel2 == -1) {
> +				channels[i].differential = 1;
> +				channels[i].channel2 = 0;
> +			}
> +
> +	return 0;
> +}
> +
>  static int ad7192_probe(struct spi_device *spi)
>  {
>  	struct ad7192_state *st;
>  	struct iio_dev *indio_dev;
> -	int ret;
> +	struct regulator *aincom;
> +	int ret = 0;
>  
>  	if (!spi->irq) {
>  		dev_err(&spi->dev, "no IRQ?\n");
> @@ -1067,6 +1087,26 @@ static int ad7192_probe(struct spi_device *spi)
>  
>  	mutex_init(&st->lock);
>  
> +	aincom = devm_regulator_get_optional(&spi->dev, "aincom");
> +	if (!IS_ERR(aincom)) {
> +		ret = regulator_enable(aincom);
> +		if (ret) {
> +			dev_err(&spi->dev, "Failed to enable specified AINCOM supply\n");
> +			return ret;
> +		}
> +
> +		ret = devm_add_action_or_reset(&spi->dev, ad7192_reg_disable, aincom);
> +		if (ret)
> +			return ret;
> +
> +		ret = regulator_get_voltage(aincom);
> +		if (ret < 0)
> +			return dev_err_probe(&spi->dev, ret,
> +					     "Device tree error, AINCOM voltage undefined\n");
> +	}
> +
> +	st->aincom_mv = ret / 1000;
I think I'd make the two paths more explicit

		ret = regulator_get_voltage(aincom);
		if (ret < 0)
			return dev_err_probe(&spi->dev, ret,
					     "Device tree error, AINCOM voltage undefined\n");
		st->aincom_mv = ret / 1000;
	} else {
		st->aincom_mv = 0;	
	}
or rely on default for st->aincom_mv already being zero and don't bother adding
the else, just move aincom_mv setting into the path with the voltage being read
and not the other path.

Setting it unconditionally by dividing 0 / 1000 is correct of course, but
not particularly obvious!	

		
> +
>  	st->avdd = devm_regulator_get(&spi->dev, "avdd");
>  	if (IS_ERR(st->avdd))
>  		return PTR_ERR(st->avdd);
> @@ -1113,6 +1153,11 @@ static int ad7192_probe(struct spi_device *spi)
>  	st->int_vref_mv = ret / 1000;
>  
>  	st->chip_info = spi_get_device_match_data(spi);
> +
> +	ret = ad7192_config_channels(st);
> +	if (ret)
> +		return ret;
> +
>  	indio_dev->name = st->chip_info->name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = st->chip_info->channels;


