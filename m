Return-Path: <linux-kernel+bounces-90590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8849D8701D1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC4601C2242F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3833D3A1;
	Mon,  4 Mar 2024 12:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="YiCUiQbS"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85BD3D38C
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 12:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709556525; cv=none; b=WYfZr+MGhatM2uUJ+kRvnd/2GvEUd4oOKMEGz0GjkSclVgeMrbrnwpF/hcs2+SPCVOdYtDTDGUaMD4G72aoiedM3DHAPifrs6iS5stEGArRwFFpm2+dmVliVu2wJ8a0znPLZ8v3NwWJ2sEdVckZWBxfQr2TqJcJOTeRmEol3xvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709556525; c=relaxed/simple;
	bh=qeMNh6+hQ10FErwN27/1B80XyAwFDxlKIVyARvTdGT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e815rdMr8hspGoL6HVngxbPP/nKCpGbtirqHA7YvmY8yuNXap8T0nffZX3uUdO42VxkEuq0xci830c6TMgObEuaRzJAswdcvmOUx+R7lQFMx/3oplqlc2Z3XSic4iulswKmz/+5LyH2GRBzbWKOeUI7mP1G0Ph1hOR30u3FIb5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=YiCUiQbS; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-29b31254820so1103500a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 04:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1709556523; x=1710161323; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MwL13hTu++GpFTu+3ER2Sxrj84hZsqHSKZBvqhwLmtc=;
        b=YiCUiQbS/NvVbNYUT7g6sj4TUq7BWTUhFsJgwtbWK6HoZMFLhikB+i3SgVlByJAdPj
         /HR3aewb3eGY65Qn069+h9eJJdwh8zMqjiCqEHr8+llCJSHQXGzlCkQQrx4E3BRtlyNQ
         icheP8vw7h4q/gmHtsJeEvZ/KOpeVzPkIW1+xvPybbJBXh2LiWqDqgRss8Bf6LTn/1p8
         mhZK318++5ECukGbfr8j0pa72Ms740RpcLOm3GIKXRclRu46nO0Xm76WOPT9ZaOm5hZV
         GWmIr8k5AZUXE1Z2Md7NNTvV4v7T5iH5Q63D2iDGum/g5vogAtJnLa6FDxJdF/9NMa1X
         /fQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709556523; x=1710161323;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MwL13hTu++GpFTu+3ER2Sxrj84hZsqHSKZBvqhwLmtc=;
        b=GuA6g+ZLQNA3O2sJbQAZ3M5aUJZp2MTUGB9fnBMTuKUxx+ERiCYAfxZLO9CWzGRoZs
         jNGJTmcBBwS6+6US/Bhry73UAEyM8HfIrSag0Y5vuX0ma5lX0kG0e+lUSVGzgPIh6uyt
         +KaqdPzsy3c7ojKlEJ468bGYtDz9IKpsl67RAk1XmIIkd8ShFyC+1QrqLjTfXgmYZ98M
         YFkBvBmTxpJWLCCuc3kgLNmCjtb6pJYCAXd3H8m99bjWvXnt/QVPYwbAq1j3xlXJkiNt
         GCf80WNYTsFHFM8vKNHHo0NQC7GF5F4YGIQByYbVl0IYD8RlXcb7hkhvNTzVU7Ngvi7q
         Q3oQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvMsLfb5dlAsboMm5j4irRfW5pOxFnt/Ewuq2UIOeX6JKzmlXeFTQQdAg/SUoQxMk47rOUopwL9e6CIk/O6dj24W9ik68trg02Nveh
X-Gm-Message-State: AOJu0YxR7kvfYsDaNeCk6uvyrTls/ja21S6sqeZkzpsULoaVUS/7Qvlu
	Gx1qjmUpLz4KG/EKQl02Uqs1DfWkGSuWgA0z+AeJ4NtY1kTvO218e6zBnD6UMGs=
X-Google-Smtp-Source: AGHT+IGf2v7mix4IqahGn8jGygdD9TiXeeZWDQNMvnX8ZorfSugMvA8SvRMIH4REH3sa5W/iYxmbCA==
X-Received: by 2002:a17:90a:4203:b0:29a:dc6e:c12e with SMTP id o3-20020a17090a420300b0029adc6ec12emr5601720pjg.24.1709556522992;
        Mon, 04 Mar 2024 04:48:42 -0800 (PST)
Received: from [192.168.20.11] ([180.150.112.31])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902ed8c00b001dc05537e10sm8422107plj.236.2024.03.04.04.48.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 04:48:42 -0800 (PST)
Message-ID: <113e077c-b8ab-4d81-acbd-0f7aa7538c04@tweaklogic.com>
Date: Mon, 4 Mar 2024 23:18:34 +1030
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/5] iio: light: Add support for APDS9306 Light Sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Marek Vasut <marex@denx.de>, Anshul Dalal <anshulusr@gmail.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Matt Ranostay <matt@ranostay.sg>,
 Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240228122408.18619-1-subhajit.ghosh@tweaklogic.com>
 <20240228122408.18619-6-subhajit.ghosh@tweaklogic.com>
 <20240303151422.5fc3c2f2@jic23-huawei>
Content-Language: en-US
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <20240303151422.5fc3c2f2@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/3/24 01:44, Jonathan Cameron wrote:
> On Wed, 28 Feb 2024 22:54:08 +1030
> Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:
> 
>> Driver support for Avago (Broadcom) APDS9306 Ambient Light Sensor.
>> It has two channels - ALS and CLEAR. The ALS (Ambient Light Sensor)
>> channel approximates the response of the human-eye providing direct
>> read out where the output count is proportional to ambient light levels.
>> It is internally temperature compensated and rejects 50Hz and 60Hz flicker
>> caused by artificial light sources. Hardware interrupt configuration is
>> optional. It is a low power device with 20 bit resolution and has
>> configurable adaptive interrupt mode and interrupt persistence mode.
>> The device also features inbuilt hardware gain, multiple integration time
>> selection options and sampling frequency selection options.
>>
>> This driver also uses the IIO GTS (Gain Time Scale) Helpers Namespace for
>> Scales, Gains and Integration time implementation.
>>
>> Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
>> ---
>> v7 -> v8:
>>   - Renamed APDS9306_INT_CH_CLEAR to APDS9306_INT_SRC_CLEAR macro for higher
>>     readability
>>   - Removed APDS9306_CHANNEL macro for higher readability
>>   - Updated iio_push_event() functions with correct type of events (Light or Intensity)
> 
> Partly right.  Need to push the modified part for the intensity channel.
> The event should match the channel description.
> 
> I also noted some missing elements in the event specs (sorry missed those
> before!).  Whilst what you have will work, that's just because the error checking
> is relaxed in the IIO core and we don't complain if they aren't fully specified.
> What you have creates the correct attributes, but that's a side effect of how
> we use the data, not what data should be provided.
> 
> Thanks,
> 
> Jonathan
> 
>>   - Updated variable name "event_ch_is_light" to "int_src" and change as per
>>     review to fix compiler warning
>>   - Used scope for guard() functions
>>   - Other fixes as per reviews
>>     https://lore.kernel.org/all/20240224151340.3f2f51e8@jic23-huawei/
>>     https://lore.kernel.org/all/ZdycR6nr3rtrnuth@smile.fi.intel.com/
>>
> 
>> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
>> index 2e5fdb33e0e9..a30f906e91ba 100644
>> --- a/drivers/iio/light/Makefile
>> +++ b/drivers/iio/light/Makefile
>> @@ -10,6 +10,7 @@ obj-$(CONFIG_ADUX1020)		+= adux1020.o
> ...
> 
>> +	GAIN_SCALE_ITIME_US(3125, APDS9306_MEAS_MODE_3125US, BIT(0)),
>> +};
>> +
>> +static struct iio_event_spec apds9306_event_spec_als[] = {
>> +	{
>> +		.type = IIO_EV_TYPE_THRESH,
>> +		.dir = IIO_EV_DIR_RISING,
>> +		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE),
>> +	}, {
>> +		.type = IIO_EV_TYPE_THRESH,
>> +		.dir = IIO_EV_DIR_FALLING,
>> +		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE),
>> +	}, {
>> +		.type = IIO_EV_TYPE_THRESH,
>> +		.dir = IIO_EV_DIR_EITHER,
>> +		.mask_shared_by_all = BIT(IIO_EV_INFO_PERIOD),
>> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
>> +	}, {
>> +		.type = IIO_EV_TYPE_THRESH_ADAPTIVE,
>> +		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE) |
>> +			BIT(IIO_EV_INFO_ENABLE),
>> +	},
>> +};
>> +
>> +static struct iio_event_spec apds9306_event_spec_clear[] = {
>> +	{
>> +		.type = IIO_EV_TYPE_THRESH,
>> +		.dir = IIO_EV_DIR_EITHER,
>> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> 
> Can't configure the threshold for this channel?
Same threshold regs for both als and clear channels.
> 
> Whilst the IIO core doesn't check these for missing entries in
> shared attributes, you driver should replicate the parts that
> are in mask_shared_by_all above.  The code that builds the attributes
> expects duplication of entries so they are here to provide an easy
> place for us to visually check what is supported.
I understand this approach now.
> 
> I think that means this event spec will be identical to that for the
> als channel. So reuse that.
Yes, correct.
I tried using struct iio_event_spec apds9306_event_spec_als[] for both light
and clear channels and the ABI is identical to the previous version.
> 
> Let us know if you copied this pattern from another driver as we
> should fix any that have gotten through review doing this.
Initially I referenced many drivers but after so many iterations it
does not resemble anything that I have looked at previously.

Thank you for reviewing.

Regards,
Subhajit Ghosh

> 
>> +	},
>> +};
>> +
>> +static struct iio_chan_spec apds9306_channels_with_events[] = {
>> +	{
>> +		.type = IIO_LIGHT,
>> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) |
>> +					   BIT(IIO_CHAN_INFO_SAMP_FREQ),
>> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
>> +						     BIT(IIO_CHAN_INFO_SAMP_FREQ),
>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> +				      BIT(IIO_CHAN_INFO_SCALE),
>> +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
>> +		.event_spec = apds9306_event_spec_als,
>> +		.num_event_specs = ARRAY_SIZE(apds9306_event_spec_als),
>> +	}, {
>> +		.type = IIO_INTENSITY,
>> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) |
>> +					   BIT(IIO_CHAN_INFO_SAMP_FREQ),
>> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
>> +						     BIT(IIO_CHAN_INFO_SAMP_FREQ),
>> +		.channel2 = IIO_MOD_LIGHT_CLEAR,
>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>> +		.modified = 1,
>> +		.event_spec = apds9306_event_spec_clear,
>> +		.num_event_specs = ARRAY_SIZE(apds9306_event_spec_clear),
>> +	},
>> +};
>> +
>> +static struct iio_chan_spec apds9306_channels_without_events[] = {
>> +	{
>> +		.type = IIO_LIGHT,
>> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) |
>> +					   BIT(IIO_CHAN_INFO_SAMP_FREQ),
>> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
>> +						     BIT(IIO_CHAN_INFO_SAMP_FREQ),
>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> +				      BIT(IIO_CHAN_INFO_SCALE),
>> +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
>> +	}, {
>> +		.type = IIO_INTENSITY,
>> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) |
>> +					   BIT(IIO_CHAN_INFO_SAMP_FREQ),
>> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
>> +						     BIT(IIO_CHAN_INFO_SAMP_FREQ),
>> +		.channel2 = IIO_MOD_LIGHT_CLEAR,
>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>> +		.modified = 1,
>> +	},
>> +};
> 
> 



