Return-Path: <linux-kernel+bounces-32139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B24A1835706
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 18:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E24D1F21CDE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 17:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5FA381BA;
	Sun, 21 Jan 2024 17:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6e7RWjF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57DA2AF08;
	Sun, 21 Jan 2024 17:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705857274; cv=none; b=BzfJF1Q/KxYWdiP+gppbFpd4hvFrEgNA+ji1BYxP+N8TBHybV+qN/0AVfx+SM1L3ZxVUPYeXLsQwNyDdrpSAw2soQEdan/2qlo3Fp58q2MsusWo8uRM76S4viVr1VXtjl6qbHR5je36VtGjAe7cqiePLusiD5p7aL5RfHsuSEpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705857274; c=relaxed/simple;
	bh=tuKyIyws+oHNDCilJrJQDNO18au3rfXlyXVKu88fVcc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hW4+SJThZC+ROUEKhL6I1J8uRm1CSHXgBxKayppRnMTonHP86gCxwrdc/80dHP3/SU9cxaZgvB2YTgqk1l0zWQhxs3w/Px0vJMY4lhQNg9YgsMyZw7JcSAPKg79ped+5Q/sKSOgHPqvdG6YtiYbvCih9T6Ig79K9eSxZXSPE4Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6e7RWjF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D32C433F1;
	Sun, 21 Jan 2024 17:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705857274;
	bh=tuKyIyws+oHNDCilJrJQDNO18au3rfXlyXVKu88fVcc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K6e7RWjFe6VcqpaizVM551BZ85SDAYwvKZmdonsaggZczHBZUFAygXOPUHiHhbk4+
	 hi4z6NQVWTzKLP5M0lUE1xP0nG0uMqQf4Sj0BgFxO8ZV2OhaBYHLsT8wEhON81omC5
	 ehJcQs1gdyRwMWGxIaDvxNb6DEwemhIT321Ne8wFhT9Hz8qATUU/2WXuUmKUDxM6Ya
	 g6BS2hEc8IxGHAMnkM+btz49LIpp1ON2GYWRmlYHqVuPscyT23umbQYvvEcdLL/XMs
	 M33lG9Lep0XfYsfh1pvHimPyOIH1CyLtRlreNubip1CblyLZJbUEohh8tm7WbqfCl+
	 bP4XY/hokUTwA==
Date: Sun, 21 Jan 2024 17:14:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Ceclan Dumitru
 <dumitru.ceclan@analog.com>
Subject: Re: [PATCH v4 5/5] iio: amplifiers: hmc425a: add support for
 LTC6373 Instrumentation Amplifier
Message-ID: <20240121171418.635ac5fa@jic23-huawei>
In-Reply-To: <20240117125124.8326-6-mitrutzceclan@gmail.com>
References: <20240117125124.8326-1-mitrutzceclan@gmail.com>
	<20240117125124.8326-6-mitrutzceclan@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jan 2024 14:51:14 +0200
Dumitru Ceclan <mitrutzceclan@gmail.com> wrote:

> This adds support for LTC6373 36 V Fully-Differential Programmable-Gain
> Instrumentation Amplifier with 25 pA Input Bias Current.
> The user can program the gain to one of seven available settings through
> a 3-bit parallel interface (A2 to A0).
> 
> Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
Hi Dumitru,

Some comments inline.  I'd forgotten we have a rich set of DIV_xxx macros
in math.h, DIV_ROUND_CLOSEST is I think the same as what you have
coded up in here.

> ---
>  drivers/iio/amplifiers/hmc425a.c | 118 +++++++++++++++++++++++++++++--
>  1 file changed, 114 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/amplifiers/hmc425a.c b/drivers/iio/amplifiers/hmc425a.c
> index b116b54e4206..e7f425677fd3 100644
> --- a/drivers/iio/amplifiers/hmc425a.c
> +++ b/drivers/iio/amplifiers/hmc425a.c
> @@ -2,9 +2,10 @@
>  /*
>   * HMC425A and similar Gain Amplifiers
>   *
> - * Copyright 2020 Analog Devices Inc.
> + * Copyright 2020, 2023 Analog Devices Inc.
>   */
>  
> +#include <linux/bits.h>
>  #include <linux/bitops.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
> @@ -20,10 +21,24 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/sysfs.h>
>  
> +/*
> + * The LTC6373 amplifier supports configuring gain using GPIO's with the following
> + *  values (OUTPUT_V / INPUT_V): 0(shutdown), 0.25, 0.5, 1, 2, 4, 8, 16
> + *
> + * Except for the shutdown value, all can be converted to dB using 20 * log10(x)
> + * From here, it is observed that all values are multiples of the '2' gain setting,
> + *  with the correspondent of 6.020dB.
> + */
> +#define LTC6373_CONVERSION_CONSTANT	6020
> +#define LTC6373_MIN_GAIN_CODE		0x6
> +#define LTC6373_CONVERSION_MASK		GENMASK(2, 0)
> +#define LTC6373_SHUTDOWN		GENMASK(2, 0)
> +
>  enum hmc425a_type {
>  	ID_HMC425A,
>  	ID_HMC540S,
> -	ID_ADRF5740
> +	ID_ADRF5740,
> +	ID_LTC6373,
>  };
>  
>  struct hmc425a_chip_info {
> @@ -34,6 +49,8 @@ struct hmc425a_chip_info {
>  	int				gain_min;
>  	int				gain_max;
>  	int				default_gain;
> +	int				powerdown_val;
> +	bool				has_powerdown;
>  };
>  
>  struct hmc425a_state {
> @@ -42,6 +59,7 @@ struct hmc425a_state {
>  	struct				gpio_descs *gpios;
>  	enum				hmc425a_type type;
>  	u32				gain;
> +	bool				powerdown;
>  };
>  
>  static int hmc425a_write(struct iio_dev *indio_dev, u32 value)
> @@ -80,6 +98,17 @@ static int hmc425a_gain_dB_to_code(struct hmc425a_state *st, int val, int val2,
>  		temp = (abs(gain) / 2000) & 0xF;
>  		*code = temp & BIT(3) ? temp | BIT(2) : temp;
>  		return 0;
> +	case ID_LTC6373:
> +		if (st->powerdown)
> +			return -EPERM;
> +
> +		/* add half of the value for rounding */
> +		temp = LTC6373_CONVERSION_CONSTANT / 2;

As mentioned in review of earlier patch, I'd like this to be in a callback not
based on st->type (which should be removed from the driver).

> +		if (val < 0)
> +			temp *= -1;
> +		*code = ~((gain + temp) / LTC6373_CONVERSION_CONSTANT + 3)

I'd forgotten in previous reviews that we have DIV_ROUND_CLOSEST() that does
pretty similar maths to your handling here. Better to use that than
spin your own version.

> +			& LTC6373_CONVERSION_MASK;
> +		return 0;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -101,6 +130,12 @@ static int hmc425a_code_to_gain_dB(struct hmc425a_state *st, int *val, int *val2
>  		code = code & BIT(3) ? code & ~BIT(2) : code;
>  		gain = code * -2000;
>  		break;
> +	case ID_LTC6373:
> +		if (st->powerdown)
> +			return -EPERM;
> +		gain = ((~code & LTC6373_CONVERSION_MASK) - 3) *
> +		       LTC6373_CONVERSION_CONSTANT;
> +		break;
>  	}
>  
>  	*val = gain / 1000;
> @@ -174,6 +209,48 @@ static const struct iio_info hmc425a_info = {
>  	.write_raw_get_fmt = &hmc425a_write_raw_get_fmt,
>  };
>  

> +
> +static const struct iio_chan_spec_ext_info ltc6373_ext_info[] = {
> +	{
> +		.name = "powerdown",
> +		.read = ltc6373_read_powerdown,
> +		.write = ltc6373_write_powerdown,
> +		.shared = IIO_SEPARATE,
> +	},
> +	{},

No comma preferred after a terminator entry like this as nothing should
ever come after it.  Any new additions must be before this last entry.


> +};



