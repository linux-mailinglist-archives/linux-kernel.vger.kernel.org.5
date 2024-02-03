Return-Path: <linux-kernel+bounces-51010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D3E848501
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 10:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55B4EB25B88
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 09:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BB25D48A;
	Sat,  3 Feb 2024 09:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKwlrqHA"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D00A5C8F8;
	Sat,  3 Feb 2024 09:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706952615; cv=none; b=LXU97W16EE2six08SVwGP3trjWfzxiALG8Y+3msPt4zvwHvCn+82oVgBywlOhQ7mYzp8sl27eXqrjlIrrkYUcyEyp4GXw+z9CFcws2a+AIzxg2cbzSfkuXl8Y7idCoyiD4RvOcZCMUyTtWyDts/67qsi5F662CEmHRUNxc0Ao7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706952615; c=relaxed/simple;
	bh=lwmNZwfR57Tnsaytbu0NIRUNVyvznW1i3G7f0IE/lAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BF5VqTY6zIn5aY8i1NyrR5NLaack9My+U405Bds+dD5OQs6G2djKwoynh0X53wn8ARwb/DruBSzavkHfwo0E7QarA0VShngseOyPeDA7tgFBN3b8fZLyc5+JlBBgffXqJBODLeQbD0tO3IIa8/v+Q5I7qAHPVI2hcG3QZM+pgcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKwlrqHA; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51124e08565so4472585e87.3;
        Sat, 03 Feb 2024 01:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706952612; x=1707557412; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fGkFAJoK8xGWEW0AsAlal/QM6gTn3oWaFYjX5q7lfkE=;
        b=VKwlrqHApZ/LFTiQWhCt2MG0S/2IU44VNwTF9pEVsYPUIN+3silUGKeUr4D1QMQUPd
         AtVTAkJaLU6kd/ChWUJBvTYocCzpeW96vFsU45UArowdSqTBaojlbtUPXxMV1PASjFPS
         FDqsRmAq8zRhNv87yo1FsQNCCL/bPNS1TAFD2miKQZyJ2qc74Hlc2ZV8i0ymMTjuhDNe
         bZowC77BefnYr5P7bcEe13HNz3rTCrnB5EPNrANf4kjAerLMhnnoM/IycYnRcRRea/HM
         GpRf1kF9WZ44SAJyngXm2NzwSZnAI+Vy5fWb6kTIFxzCpT3Gz6hiG3reTK3W5B55O177
         t4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706952612; x=1707557412;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fGkFAJoK8xGWEW0AsAlal/QM6gTn3oWaFYjX5q7lfkE=;
        b=RKAuwB/o+XOGuOuQ+O/IYwzJpGBFdiLPdPy3IfHZ40y0CM/uWhx/OH5Zd32nNO6I3Z
         kE4SXbd9+WeLm4H2V2cjRbTmpQbe5icikrd/bZ5rIS6zuNWXpocw1xRkZNHrIsFrvVmC
         THawkCrJtc6c5J96YlMWYvtmtmoShSya7j5R+Z2kCxNzeUUFntdlttRPql1BAovnz3uB
         FfEK2+UvBpZR+IK/8LPBZMToYxnqk1iTPeUE8rHraqV4/LMX65PPPiQp8rYRd7enEBKY
         qozGKGx3D24QeqZRZ9dMHxEmI+YDMp0JhswWFvZcRJfQRfBBEcV+RNp8jptAkP2E9n/9
         7UWQ==
X-Gm-Message-State: AOJu0YzHsqw8pkWjWchnjaIaIwQNW8dUSJFsIsxIMS64qZYcR20ZaLd7
	GV+FVQj8vriVTpaw0QGbvjRTBFmp6IEY/qWSeAFPUVssZEwocGuS
X-Google-Smtp-Source: AGHT+IGPkqmXW9327P9DfWvEfm/oZCofctTefm0GLGRTvU86EBvdis+10KIIOIA2MyGTsBUs0pIe5w==
X-Received: by 2002:a05:6512:b8c:b0:511:3865:2dda with SMTP id b12-20020a0565120b8c00b0051138652ddamr2923695lfv.2.1706952611623;
        Sat, 03 Feb 2024 01:30:11 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWji+LnEGtVJIELPuZw620lV8OFjKBmekg8NhHQfefCsLNraCXK9vgRirY++K2u2Q574yE5BtWqexHiG8zvjSwGHSLtrsnVOBT2ZxepOhmVZ9nkcz/we5zOOnJWAN/PabqkvCia8Gv2lXfTX3SMyW789krYyyg8CBQ0qhmob8nv2agc16q64iTI1BI=
Received: from ?IPV6:2a02:8389:41cf:e200:62e5:c423:15b3:7608? (2a02-8389-41cf-e200-62e5-c423-15b3-7608.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:62e5:c423:15b3:7608])
        by smtp.gmail.com with ESMTPSA id u2-20020aa7d882000000b0055ffe74e39dsm1120019edq.85.2024.02.03.01.30.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Feb 2024 01:30:11 -0800 (PST)
Message-ID: <1eb2034f-b1ef-474d-91f6-c562a5768bfd@gmail.com>
Date: Sat, 3 Feb 2024 10:30:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: humidity: hdc3020: add threshold events support
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Li peiyu <579lpy@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240203090530.53374-1-dima.fedrau@gmail.com>
Content-Language: en-US
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20240203090530.53374-1-dima.fedrau@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Dimitri,

On 03.02.24 10:05, Dimitri Fedrau wrote:
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
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> ---
>  drivers/iio/humidity/hdc3020.c | 339 +++++++++++++++++++++++++++++++++
>  1 file changed, 339 insertions(+)
> 

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
Should that not be val < -40?
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
> +		 
> +		val = (((val + 45) * 65535 / 175) >> HDC3020_THRESH_TEMP_SHIFT);
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
> +
> 

Best regards,
Javier Carrasco

