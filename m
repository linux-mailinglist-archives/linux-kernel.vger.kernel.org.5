Return-Path: <linux-kernel+bounces-51020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC5484851D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 11:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C47591C21C39
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 10:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB68C5D737;
	Sat,  3 Feb 2024 10:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="iM7eB28r"
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433CC5C91E;
	Sat,  3 Feb 2024 10:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706954834; cv=none; b=WSRM/gR6yLJUEHcHvsOA33SvpPJF05yUTqyhc1V9ITnO7OI+E50Psc4uAZxQ2brfOmW6Duqh0ds6yxMuccdM/MwsztkQrOHm8y/5/wok+0PiMQTofQWbVpnkzYrAZ9yImiBBXLXhef7mOmz4TXfK/X5VF3M6wgL8DOlnwaGHBq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706954834; c=relaxed/simple;
	bh=YQvE7y0NHy8x4IJxViUtYas8Dp3o2T+eCwn5UkgB5Sg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wn9bEVNTumU1OsgXBsIbn2wS51avZH7+XFF3MwJDKiLLCdvljcDoJPYYTeUnBfNgOmj5UD4D7ivLvvZMSrlnY7QAqsc4fCA/TRaFPAYeAzq8sJ1lKVG9zk2brnjkFRiBRrGRSTSqZI9nj7cpdX508/TuJXl7VvmPpBFR14TkWcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=iM7eB28r; arc=none smtp.client-ip=80.12.242.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id WCn3r4y1Qn8K2WCn3rKyrj; Sat, 03 Feb 2024 10:58:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1706954305;
	bh=53zy55g4yqyQ0+8fdEt1Lnm92Clz5kD41n0D2EGwMlY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=iM7eB28rFWHTU7/83TflV0d3jSZwcEUI9pMm8BlF4EXuqXPWFOc5ga/yyaCxACEVH
	 ASeL4T1eSFbEuoj6gupci1lDuX0635O9k28orVXMYkvkPMv01DKQl1mGO/mUfLE2pL
	 W9Au43oZoVPPz9eyppVP/iheOVax6ZSl9TkVdLDoXZu2ZmTTgIXh3WTfRiMCIntGHw
	 vFEm24RsN0FMZJnrpM2Q36aN05tIws3oRxF2gNZsTxDPmJWBB0PjnWa8HOXRglaDI6
	 wunQ9LEVJlBMIuakndaj6XVTWNc8JNCVPOQxJoWxUTuBoqzEuc+eXoG64J/dHviWxS
	 I15/bBxgbOLig==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 03 Feb 2024 10:58:25 +0100
X-ME-IP: 92.140.202.140
Message-ID: <236dc9db-8525-413e-a77b-54df198c86f5@wanadoo.fr>
Date: Sat, 3 Feb 2024 10:58:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: humidity: hdc3020: add threshold events support
To: dima.fedrau@gmail.com
Cc: 579lpy@gmail.com, javier.carrasco.cruz@gmail.com, jic23@kernel.org,
 lars@metafoo.de, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240203090530.53374-1-dima.fedrau@gmail.com>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240203090530.53374-1-dima.fedrau@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 03/02/2024 à 10:05, Dimitri Fedrau a écrit :
> Add threshold events support for temperature and relative humidity. To
> enable them the higher and lower threshold registers must be programmed
> and the higher threshold must be greater then or equal to the lower
> threshold. Otherwise the event is disabled. Invalid hysteresis values
> are ignored by the device. There is no further configuration possible.
> 
> Tested by setting thresholds/hysteresis and turning the heater on/off.
> Used iio_event_monitor in tools/iio to catch events while constantly
> displaying temperature and humidity values.
> Threshold and hysteresis values are cached in the driver, used i2c-tools
> to read the threshold and hysteresis values from the device and make
> sure cached values are consistent to values written to the device.
> 
> Based on Fix:
> a69eeaad093d "iio: humidity: hdc3020: fix temperature offset" in branch
> fixes-togreg
> 
> Signed-off-by: Dimitri Fedrau <dima.fedrau-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>   drivers/iio/humidity/hdc3020.c | 339 +++++++++++++++++++++++++++++++++
>   1 file changed, 339 insertions(+)
> 
> diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hdc3020.c
> index ed70415512f6..1cdff7af4ca8 100644
> --- a/drivers/iio/humidity/hdc3020.c
> +++ b/drivers/iio/humidity/hdc3020.c
> @@ -16,16 +16,27 @@
>   #include <linux/init.h>
>   #include <linux/module.h>
>   #include <linux/mutex.h>
> +#include <linux/interrupt.h>

Nit: alphabetical order could be kept

>   
>   #include <asm/unaligned.h>
>   
>   #include <linux/iio/iio.h>
> +#include <linux/iio/events.h>

Nit: same

..

>   
> +static const u8 HDC3020_R_T_RH_THRESH_LOW[2] = { 0xE1, 0x02 };
> +static const u8 HDC3020_R_R_RH_THRESH_LOW_CLR[2] = { 0xE1, 0x09 };

I don't know what the R and T are for, but shoukld this be 
HDC3020_R_T_RH_THRESH_LOW_CLR to match other adjacent line?

> +static const u8 HDC3020_R_T_RH_THRESH_HIGH_CLR[2] = { 0xE1, 0x14 };
> +static const u8 HDC3020_R_T_RH_THRESH_HIGH[2] = { 0xE1, 0x1F };

..

> +static int hdc3020_write_thresh(struct iio_dev *indio_dev,
> +				const struct iio_chan_spec *chan,
> +				enum iio_event_type type,
> +				enum iio_event_direction dir,
> +				enum iio_event_info info,
> +				int val, int val2)
> +{
> +	struct hdc3020_data *data = iio_priv(indio_dev);
> +	u16 *thresh;
> +	u8 buf[5];
> +	int ret;
> +
> +	/* Supported temperature range is from –40 to 125 degree celsius */
> +	if (val < -45 || val > 125)
> +		return -EINVAL;
> +
> +	/* Select threshold and associated register */
> +	if (info == IIO_EV_INFO_VALUE) {
> +		if (dir == IIO_EV_DIR_RISING) {
> +			thresh = &data->t_rh_thresh_high;
> +			memcpy(buf, HDC3020_S_T_RH_THRESH_HIGH, 2);
> +		} else {
> +			thresh = &data->t_rh_thresh_low;
> +			memcpy(buf, HDC3020_S_T_RH_THRESH_LOW, 2);
> +		}
> +	} else {
> +		if (dir == IIO_EV_DIR_RISING) {
> +			thresh = &data->t_rh_thresh_high_clr;
> +			memcpy(buf, HDC3020_S_T_RH_THRESH_HIGH_CLR, 2);
> +		} else {
> +			thresh = &data->t_rh_thresh_low_clr;
> +			memcpy(buf, HDC3020_S_T_RH_THRESH_LOW_CLR, 2);
> +		}
> +	}
> +
> +	guard(mutex)(&data->lock);
> +	switch (chan->type) {
> +	case IIO_TEMP:
> +		/*
> +		 * Store truncated temperature threshold into 9 LSBs while
> +		 * keeping the old humidity threshold in the 7 MSBs.
> +		 */
> +		val = (((val + 45) * 65535 / 175) >> HDC3020_THRESH_TEMP_SHIFT);

Why 175?
If the span is -40/+120, I guess it should be 160 and if it is -45/+120, 
165. No?

Maybe something like:
   #define MIN_TEMP -45 (or -40)
   #define MAX_TEMP 120
in order to avoid hard coded constant?

> +		val &= HDC3020_THRESH_TEMP_MASK;
> +		val |= (*thresh & HDC3020_THRESH_HUM_MASK);
> +		break;
> +	case IIO_HUMIDITYRELATIVE:
> +		/*
> +		 * Store truncated humidity threshold into 7 MSBs while
> +		 * keeping the old temperature threshold in the 9 LSBs.
> +		 */
> +		val = ((val * 65535 / 100) & HDC3020_THRESH_HUM_MASK);
> +		val |= (*thresh & HDC3020_THRESH_TEMP_MASK);
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	put_unaligned_be16(val, &buf[2]);
> +	buf[4] = crc8(hdc3020_crc8_table, buf + 2, 2, CRC8_INIT_VALUE);
> +	ret = hdc3020_write_bytes(data, buf, 5);
> +	if (ret)
> +		return ret;
> +
> +	/* Update threshold */
> +	*thresh = val;
> +
> +	return 0;
> +}

CJ


