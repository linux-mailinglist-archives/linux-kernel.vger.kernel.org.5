Return-Path: <linux-kernel+bounces-89774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9387386F58A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 15:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 341A2B215D0
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 14:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDF167A11;
	Sun,  3 Mar 2024 14:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQdNt5/5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934DE3EA68;
	Sun,  3 Mar 2024 14:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709476483; cv=none; b=G1RbSQIYMGeJ1ltfBjbibmAKZtSLq54gsgvetHWBuRDsLAoltJwHuGqOcSevfvgbzUQLuazP8XjMbTm4yOni+sa0CxfxMO4UjY7AzRST88K0W4qwW4seXa5s6F/gNbR241fDUaQqYgAbwX65bvWR56FCBOneDBubfBS6WPPGlvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709476483; c=relaxed/simple;
	bh=7pIB5wDzFt9Tko9FAC1MbXUYpB6Pon2A5GdhinIvdXc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZvCDaMeCY0E85ZT2zc2tsMLZstnRm+6uiC1SCUYB35P6MSo+gGmhbRWbQ7h8oZRFtqZT/2GtfwBh1QA8/QMW7lmsYHQnrYgisItgF7QGFhd8JOxuvplGBiVG5OoSzeHTWSAdd8S2MBYgZXmnX9G+wZMVlNozNS6i7N4SaNXozJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQdNt5/5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCE4C433F1;
	Sun,  3 Mar 2024 14:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709476483;
	bh=7pIB5wDzFt9Tko9FAC1MbXUYpB6Pon2A5GdhinIvdXc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aQdNt5/5Gd/t21et4QpZZ7GLN0pXVKLQ9LrQzknFIW6e+My6HzsHZW3oZMauviVKG
	 2QsgL+7/Qpc8/gBm2tNjbTR7ZGHxkbsUSHL4edTD2z4q8n0cziJVRzp1WdihUKbnSw
	 FtE5VSO/DfOKvQ79zm/sHe8knsNpefKjE+0lJgJ9tUPB61kLnDw4FYBP+96po62EEK
	 XxfucQVW+Ea7K7S/S///TiGE1KuRXcn8rF9tzPeofkhg1NGnA8RCB6ua9yg8l9asQF
	 k23f7eE1afP1WSws3EXvrVZhX/IvweX9Izqhg+inHzBmmwlYfYxAItuJAOPwnlDpvl
	 yzbLpQ65Mgytg==
Date: Sun, 3 Mar 2024 14:34:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Ceclan Dumitru
 <dumitru.ceclan@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: ad7173: add support for additional
 models
Message-ID: <20240303143429.68fd5cd4@jic23-huawei>
In-Reply-To: <20240228135532.30761-3-mitrutzceclan@gmail.com>
References: <20240228135532.30761-1-mitrutzceclan@gmail.com>
	<20240228135532.30761-3-mitrutzceclan@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Feb 2024 15:54:57 +0200
Dumitru Ceclan <mitrutzceclan@gmail.com> wrote:

> Add support for Analog Devices AD7172-2, AD7175-8, AD7177-2.
> 
> Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
Hi Dumitru

Some of the changes in here make it clear more inter chip variability
should be specified directly in your device_info structures, and less
(preferably none) use made of the id field + if statements inline.

Those ID fields should just be for matching, not for direct use to adjust
code flow.

Jonathan


> ---
>  drivers/iio/adc/ad7173.c | 82 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 74 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> index b42fbe28a325..e60ecce20e08 100644
> --- a/drivers/iio/adc/ad7173.c
> +++ b/drivers/iio/adc/ad7173.c
> @@ -1,6 +1,11 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * AD7172-2/AD7173-8/AD7175-2/AD7176-2 SPI ADC driver
> + * AD717x family SPI ADC driver
> + *
> + * Supported devices:
> + *  AD7172-2/AD7172-4/AD7173-8/AD7175-2
> + *  AD7175-8/AD7176-2/AD7177-2
> + *
>   * Copyright (C) 2015, 2024 Analog Devices, Inc.
>   */
>  
> @@ -61,10 +66,13 @@
>  #define AD7173_AIN_TEMP_POS	17
>  #define AD7173_AIN_TEMP_NEG	18
>  
> -#define AD7172_ID			0x00d0
> -#define AD7173_ID			0x30d0
> -#define AD7175_ID			0x0cd0
> +#define AD7172_2_ID			0x00d0
>  #define AD7176_ID			0x0c90
> +#define AD7175_2_ID			0x0cd0
> +#define AD7172_4_ID			0x2050
> +#define AD7173_ID			0x30d0
> +#define AD7175_8_ID			0x3cd0
> +#define AD7177_ID			0x4fd0
>  #define AD7173_ID_MASK			GENMASK(15, 4)
>  
>  #define AD7173_ADC_MODE_REF_EN		BIT(15)
> @@ -110,15 +118,19 @@
>  #define AD7173_SETUP_REF_SEL_EXT_REF	0x0
>  #define AD7173_VOLTAGE_INT_REF_uV	2500000
>  #define AD7173_TEMP_SENSIIVITY_uV_per_C	477
> +#define AD7177_ODR_START_VALUE		0x07
>  
>  #define AD7173_FILTER_ODR0_MASK		GENMASK(5, 0)
>  #define AD7173_MAX_CONFIGS		8
>  
..

>  
>  static const char *const ad7173_ref_sel_str[] = {
> @@ -656,7 +701,12 @@ static int ad7173_write_raw(struct iio_dev *indio_dev,
>  	switch (info) {
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		freq = val * MILLI + val2 / MILLI;
> -		for (i = 0; i < st->info->num_sinc5_data_rates - 1; i++)
> +		/*
> +		 * AD7177-2 has the filter values [0-6] marked as reserved
> +		 * datasheet page 58
> +		 */
> +		i = (st->info->id == AD7177_ID) ? AD7177_ODR_START_VALUE : 0;

Add an st->info->odr_start_value field. Can set it only for this part, but
if in future others turn up that needs similar it becomes very easy to support.

> +		for (; i < st->info->num_sinc5_data_rates - 1; i++)
>  			if (freq >= st->info->sinc5_data_rates[i])
>  				break;
>  
> @@ -908,8 +958,15 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
>  		else
>  			ref_sel = ret;
>  
> +		if (ref_sel == AD7173_SETUP_REF_SEL_INT_REF &&
> +		    st->info->id == AD7172_2_ID) {

As below.  You may well end up adding more devices here. Make it data instead by
adding  has_ref1 boolean to your st->info structure.

> +			fwnode_handle_put(child);
> +			return dev_err_probe(dev, -EINVAL,
> +				"Internal reference is not available on ad7172-2\n");
> +		}
> +
>  		if (ref_sel == AD7173_SETUP_REF_SEL_EXT_REF2 &&
> -		    st->info->id != AD7173_ID) {
> +		    st->info->id != AD7173_ID && st->info->id != AD7172_2_ID) {
This is one of those cases that clearly shows why ID matching doesn't generalize well.
Better to have a flag in info that directly says if there is an external reference 2 
possible for each chip variant.  Otherwise this list just keeps on growing!

		   !st->info->has_ref2

>  			fwnode_handle_put(child);
>  			return dev_err_probe(dev, -EINVAL,
>  				"External reference 2 is only available on ad7173-8\n");


