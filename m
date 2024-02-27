Return-Path: <linux-kernel+bounces-83294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60189869174
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D42461F21F51
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C7613B299;
	Tue, 27 Feb 2024 13:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="ImQ4DNw3"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E68B13AA35
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 13:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709039580; cv=none; b=kH0apTTsgmaKHspN8jA1qlgYaDmHdSggBLoOlX2agcdcergt8aHvN+0CoPz8Ex8zMolVp34IUCbTmXvkPxkUGbKNxZ2PeEASMIo4O+YEMJ9tHv/DDLDaZJL0lQHUHOzw2ejnhCFkcl/tS9nP5OV62nC+ept3khKRkB9oR9AP/lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709039580; c=relaxed/simple;
	bh=r/94iCN20Fk2NhI03wn/nZawp0Hom6G4UHrshYpmT20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hTqyFoDgnMgFq8aoJvoPAYjlWsqev8a8pwhTrAsGu6EcX/jjIanrcyjC7U7owILwsg0a7Kr3QzVTEAxDUmecBq71wTF1KLablqiXOWMp9r95Qg58UcCm4lSSjNpsFwU4xBsPy+6bbw/frD5Evy9FLnUkyJZcnvyIVTj2f18G/b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=ImQ4DNw3; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e554f4e0bfso109896b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 05:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1709039578; x=1709644378; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jCk7kBUbkEDCNNZZvLnoeTcO/DOClexbrTDxgBd3Qvk=;
        b=ImQ4DNw3IgF7FYTNz8ieFU4J3racq6Wg3KLhmFvh1qWLyOSAEf2G3hBKGr7gvzPW6m
         ApXSF5r7CgtdUzmICdIFAjbtVXs0ZR2tKhhXUvJgUkxEvgFm0XN/9ljJoaB1lwwnGCgu
         16b2LVFPyo5wTGi/Y1qk1OUSrGo4kM5lM5o+lnt74U7Wv8Q2e3vT3lFT7Pl+DgyuRlDd
         wP9+x6fuuK3BFV8vhZp905mD1UkNbLNH0cVp0i4SMvHxNVweqQridBhrtbBU1kM/vxje
         RsG2kAWv3FbVbQdaAaxGfTCh6kmL6908QfXbxrWbMz75kNpIVXNx0bCDo2SehpxVAKrr
         Bh9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709039578; x=1709644378;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jCk7kBUbkEDCNNZZvLnoeTcO/DOClexbrTDxgBd3Qvk=;
        b=lqou+UeDmFFouzeK6JbYJxyuQ5cBvl0JohBOhup8sdIZuArbGXyb9cILOurBOMSiUL
         96aC77sxgSLgORiZV1oSJgLV4C02aG7crZShK+Nh6YrjcZR6GZs/mR80YJ1s4j+MBIRy
         RX/BSw0YOOG8QeBqylXu7nfTq7gjMewfBk5XoJQ3TJsh7erYu6rRS58qiay+WlyMDzCc
         5Kju5/sWi3WWR9bHBWkKAtF9PPPvE6byStpAxWsvykZ+Z8bwSArrc8An/eDd1ynVLp3f
         Ndpuo4mKk0Oq1XbAP7dMEPCxnTYxLOkJBL13hksRHFrdiKHm6ql626RbnebdkCdtqBZE
         6F4A==
X-Forwarded-Encrypted: i=1; AJvYcCXFBbW54IyPyS59pTDmxAnmAu9gDT5Sxu0JCXPu10lobc82xzmJbffDlbl5UlxbUadDyJQNkN4tom1pHOSG9zsV0vS7SvaC7OwyfY4/
X-Gm-Message-State: AOJu0YwGfqoEX0DxW/6ZUhgcE9H/bunkijHBf54yxzx/ZUS0AqwN+pdn
	agnDvzNhVIiv/Z6vNHjZFfb+ENi76TFNjBYjxfdpWYt/zPYyx9YYR5HS+MGj6y4=
X-Google-Smtp-Source: AGHT+IElVotDjmybxm6A/bANYneip6rEcVYA8BZjYqYHCjXxGr1LIAXaukd9DC+7GRyLF3yr1NzIBA==
X-Received: by 2002:a05:6a21:350f:b0:1a0:f096:5022 with SMTP id zc15-20020a056a21350f00b001a0f0965022mr2427341pzb.46.1709039577571;
        Tue, 27 Feb 2024 05:12:57 -0800 (PST)
Received: from [192.168.20.11] ([180.150.112.31])
        by smtp.gmail.com with ESMTPSA id i4-20020a632204000000b005dc26144d96sm5723883pgi.75.2024.02.27.05.12.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 05:12:57 -0800 (PST)
Message-ID: <a94b86fe-0896-47ba-a597-0cd59a0665a2@tweaklogic.com>
Date: Tue, 27 Feb 2024 23:42:48 +1030
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/5] iio: light: Add support for APDS9306 Light Sensor
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
References: <20240218054826.2881-1-subhajit.ghosh@tweaklogic.com>
 <20240218054826.2881-6-subhajit.ghosh@tweaklogic.com>
 <20240224151340.3f2f51e8@jic23-huawei>
Content-Language: en-US
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <20240224151340.3f2f51e8@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/2/24 01:43, Jonathan Cameron wrote:
> On Sun, 18 Feb 2024 16:18:26 +1030
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
> I applied this but then got some build warnings that made me look
> more closely at the int_src handling.
> 
> This is confusing because of the less than helpful datasheet defintion
> of a 2 bit register that takes values 0 and 1 only.
> 
> I thought about trying to fix this up whilst applying but the event code
> issue is too significant to do without a means to test it.
> 
> Jonathan
> 

>> +static int apds9306_read_data(struct apds9306_data *data, int *val, int reg)
>> +{
>> +	struct device *dev = data->dev;
>> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>> +	struct apds9306_regfields *rf = &data->rf;
>> +	int ret, delay, intg_time, intg_time_idx, repeat_rate_idx, int_src;
>> +	int status = 0;
>> +	u8 buff[3];
>> +
>> +	ret = pm_runtime_resume_and_get(data->dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = regmap_field_read(rf->intg_time, &intg_time_idx);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = regmap_field_read(rf->repeat_rate, &repeat_rate_idx);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = regmap_field_read(rf->int_src, &int_src);
>> +	if (ret)
>> +		return ret;
>> +
>> +	intg_time = iio_gts_find_int_time_by_sel(&data->gts, intg_time_idx);
>> +	if (intg_time < 0)
>> +		return intg_time;
>> +
>> +	/* Whichever is greater - integration time period or sampling period. */
>> +	delay = max(intg_time, apds9306_repeat_rate_period[repeat_rate_idx]);
>> +
>> +	/*
>> +	 * Clear stale data flag that might have been set by the interrupt
>> +	 * handler if it got data available flag set in the status reg.
>> +	 */
>> +	data->read_data_available = 0;
>> +
>> +	/*
>> +	 * If this function runs parallel with the interrupt handler, either
>> +	 * this reads and clears the status registers or the interrupt handler
>> +	 * does. The interrupt handler sets a flag for read data available
>> +	 * in our private structure which we read here.
>> +	 */
>> +	ret = regmap_read_poll_timeout(data->regmap, APDS9306_MAIN_STATUS_REG,
>> +				       status, data->read_data_available ||
>> +				       (status & (APDS9306_ALS_DATA_STAT_MASK |
>> +						  APDS9306_ALS_INT_STAT_MASK)),
>> +				       APDS9306_ALS_READ_DATA_DELAY_US, delay * 2);
>> +
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* If we reach here before the interrupt handler we push an event */
>> +	if ((status & APDS9306_ALS_INT_STAT_MASK))
>> +		iio_push_event(indio_dev, IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
>> +			       int_src, IIO_EV_TYPE_THRESH, IIO_EV_DIR_EITHER),
> 
> You are pushing an event on channel 0 or 1 (which is non obvious as that
> int_src is a 2 bit value again).  However you don't use indexed channels
> so this is wrong.
> It's also pushing IIO_LIGHT for both channels which makes no sense as you
> only have one IIO_LIGHT channel.
Hi Jonathan,

For the above fix I am supplying the second parameter to IIO_UNMOD_EVENT_CODE()
as "0" which gives me the below output from userspace:
/iio_event_monitor /dev/iio:device0
Event: time: xx, type: illuminance, channel: 0, evtype: thresh, direction: either
Event: time: yy, type: intensity, channel: 0, evtype: thresh, direction: either

As I do not have indexed channels, I have used zero for both Light and Intensity
channel numbers. Should I make the intensity type as channel one for the output
to look like this?
Event: time: xx, type: illuminance, channel: 0, evtype: thresh, direction: either
Event: time: yy, type: intensity, channel: 1, evtype: thresh, direction: either

What do you think?

Regards,
Subhajit Ghosh
> 
> 
>> +			       iio_get_time_ns(indio_dev));
>> +
>> +	ret = regmap_bulk_read(data->regmap, reg, buff, sizeof(buff));
>> +	if (ret) {
>> +		dev_err_ratelimited(dev, "read data failed\n");
>> +		return ret;
>> +	}
>> +
>> +	*val = get_unaligned_le24(&buff);
>> +
>> +	pm_runtime_mark_last_busy(data->dev);
>> +	pm_runtime_put_autosuspend(data->dev);
>> +
>> +	return 0;
>> +}
>> +
> 
> ...



