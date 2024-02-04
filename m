Return-Path: <linux-kernel+bounces-51604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0380848D26
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 12:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E23F51C21055
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 11:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CDB2233A;
	Sun,  4 Feb 2024 11:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUkxvh0t"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8053522098;
	Sun,  4 Feb 2024 11:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707046020; cv=none; b=HJUe2sSSi9OwJa6OIsv560smrFA7cRnPf4OGo4wp7RapwSzMWoy0E3IggCjkP8dMxIvGIZZJc9BsBp5tiMEEzexCa1JGEPQhf/HD0rq/4Zf4MdljWjPwHqzXzShedwEGy34u/NCW5qaGQ/YuYsLg13VyDpXF/r6M0OjGlTl6yzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707046020; c=relaxed/simple;
	bh=s/rRFhoHbxWmWjQ38N/sBZ3CQGHizWDvoGT9DkrcZ+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b1lrHcFZKmDObyMz+yaQb6jfxN61ZUsTUGJq5v67Qco59//op2TdV57fsAMCHKznVwvPMNBhrRktjPZTDVkENlrPFmxA98+uvPnQGv/C+0RJrJOunKGsWMFvZTvdjzEiwmIX2M1cBQZEBwOcqhr/YYoD+ArDc1hl709lkAyXYCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUkxvh0t; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3122b70439so467509166b.3;
        Sun, 04 Feb 2024 03:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707046017; x=1707650817; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NHKAaoFRco1xyHqsX5oYKAyy8rLTvdJKQZ5uWsLPDP0=;
        b=OUkxvh0trg3FCsxQPeOHwfOYfcw2lma3lVqAxpt+GG6LjTE++XAQsotPJ23oBZcbmV
         cwQSw5pAcU2flJb2TdCOR7qhqBhd9rlw5oTRPUE+N12ozSEz7JBt18UY/aEXx4TIaK33
         5EM/ETU7wvULr1UQ3uCuO1d9uc70Y7ctFBTgwmPH1GqoAjkfEA76onl3pN+4liDjrK7F
         BSlKLMK339gCdF2fqlBWksChrNlYKhU2KWZ31m54aSU4lffAIMNz1Zfp9vMUS235wrJE
         sYiVHTPCGCdNObFe8ce+/MRioEZU7wzuq0SPP9raHe33U2Ws+jeGx32fELba/X1/kRmw
         YhLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707046017; x=1707650817;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NHKAaoFRco1xyHqsX5oYKAyy8rLTvdJKQZ5uWsLPDP0=;
        b=qyeKveXaclPQOc+i/w/c0rzXUCu+huKmt5dRb/Dmg5YfLe+e3Gl3LDB8oE7R93rqrq
         8CYoqryQzIFygxZWyQRetKy0SZPU/3lb/WF8Nb2MsPd5XtfpYdyfEY6W+fU9RaorzRd3
         NBXBdHDIvnYaTjdGYE0cpmdZTIV2T8mcNzY+nPRl6rMB7aAwYstQukccyLOVgd1SoSLW
         Zo1XKiYz3zzxzbJaCeWlkJN2Wcn3LHH+vm+U4GrfDFOmwkr4pQwDInXeFaGLX62CPGN+
         mfSC5f7LvOx04z2CGNtWRoC5W2hDQN1P1mPye1abvcKufsmwY7HfW0zWj0kY5FOOXV9Q
         h3nQ==
X-Gm-Message-State: AOJu0Yyf5RW6xbTWmXXbdUgELO1U2MRRIDWzngSAL70ZA25aGlnuNQmc
	1uFTjbmsNMEMjy5h/CmjjpEQgrAtZKDHqBRBHruyCU/kV77vUdYW
X-Google-Smtp-Source: AGHT+IGO518xLSlLSiSmhJo6GuGfs1XjYuvgOUF8avrOe6PONxbewJ6ItPKTtYTEbg0mzvgv30eoXQ==
X-Received: by 2002:a17:906:f811:b0:a35:50c7:8b41 with SMTP id kh17-20020a170906f81100b00a3550c78b41mr7602397ejb.72.1707046016452;
        Sun, 04 Feb 2024 03:26:56 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU4XkjkiZEqJdLlqFUXkVrka1INE/MCIsoQewjEO9AZ7C6g+Cm3YPf4VIuZ/ut7ryL9tG8KBpnO/LUz0idlN8JmY6046Y6/AqfZC+iY9c+7GXctP1/8YqUGJLp8wGO2dweycbS4RuS6u18HgrmvXHRIVqA9O7iVS8Ko16WdZd0i7t+V7KSPTgbK6Nk=
Received: from ?IPV6:2a02:8389:41cf:e200:87b6:6450:71c5:6e1d? (2a02-8389-41cf-e200-87b6-6450-71c5-6e1d.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:87b6:6450:71c5:6e1d])
        by smtp.gmail.com with ESMTPSA id oz35-20020a1709077da300b00a361c1375absm2998038ejc.133.2024.02.04.03.26.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Feb 2024 03:26:56 -0800 (PST)
Message-ID: <194ed4ce-bb2e-404e-a716-ec2e9876c740@gmail.com>
Date: Sun, 4 Feb 2024 12:26:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: humidity: hdc3020: add threshold events support
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Li peiyu <579lpy@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240204103710.19212-1-dima.fedrau@gmail.com>
Content-Language: en-US
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20240204103710.19212-1-dima.fedrau@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Dimitri,

On 04.02.24 11:37, Dimitri Fedrau wrote:
>  
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
I tested your patch right now and I noticed that you are only writing
integer values, which means that for example 19.9999 turns into 18.9169.
It seems that you are not using val2 (the decimal part).

Is there any reason for that? The displayed thresholds are decimal, though.
> +	/* Supported temperature range is from –40 to 125 degree celsius */
> +	if (val < HDC3020_MIN_TEMP || val > HDC3020_MAX_TEMP)
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

Best regards,
Javier Carrasco

