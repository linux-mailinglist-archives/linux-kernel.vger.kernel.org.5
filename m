Return-Path: <linux-kernel+bounces-14284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 415DC821AD7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 446211C21D9D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2D1E55F;
	Tue,  2 Jan 2024 11:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0JA/F8q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE7DDDBA;
	Tue,  2 Jan 2024 11:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50e741123acso7153552e87.0;
        Tue, 02 Jan 2024 03:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704194484; x=1704799284; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SY7LUg56tvTFSaFBHTNp1V6mBZmx4SnZ2FbjggsvgvY=;
        b=N0JA/F8qO6gxnTGrRsV4JSh4ejWwjAgq0/zwFWSNHZ5MTOeESfTLqyLLQlhlCcJGqS
         bjX2dLs3XrY4w5cWH3TdQE/lN/WJLItclDy0hOmoE8lG4Pp7Wq4knA4XQPi1LYWvOJzI
         hPy3QimmhStz2FhwaoX/k+nnwlNFTZfFvbAGLE8gmFqv72krkVH0MlcJCJrRjnQXj31h
         QJYIVkSMYSInuhPV8J4qhY1KZMxuZvksbzWBMyrN6zFNQl9HN5OrGCk1wQ+JqeSBOwnn
         nHpebRKlHr87sMajgSg+0SDcb9svmLdLzNSSwb6wmjsHSLA4gJnHmvRkgNoYFDUkm4aC
         Y8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704194484; x=1704799284;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SY7LUg56tvTFSaFBHTNp1V6mBZmx4SnZ2FbjggsvgvY=;
        b=NSJ3EMWQo1aYxHHyLr2sv3iLcxg7PR0pkJOZSVNG5AWEmp7PxPKPTONiHK1hkRU90n
         eJiVYESBvkGikQngDBNb7NFeVwSj5BrW3utdkOpNrgDjz3j245FPYMSUSKnAxm8bMZHw
         ckuvssWhdSIjnRwBm/CsdbKMcuahrKBPPBsgU0L3YIT1F7JhPbOFaQ8+dSAGPrsBWL0n
         4J3jwdgcAWi8xt1IsJjf8XqrKERXB3xcg9wpnxfRy4tX9WWquEvGdrlTVDNQE6oyN2QU
         jSKdODQFnJfZ5y08kv41SEOUS37qMGUEDBxrgpKQi11NHvW18iso39S6BtODx7Ep2BtK
         xz4w==
X-Gm-Message-State: AOJu0YzSpGmIieI6oy7Z1sg+QoFZtcl6XBKYPokXzPeB5vJEdQ8SICMN
	0lsD+SENg95qrY9C43QpL0o=
X-Google-Smtp-Source: AGHT+IGEK8RCGYQjtIfn/mm010mDWz7wcv6lTyuy80R7BsXUN4a9fsIrzKvFz6UmS3dybTgBW3PieQ==
X-Received: by 2002:ac2:5ec1:0:b0:50e:7bbb:55c with SMTP id d1-20020ac25ec1000000b0050e7bbb055cmr4491926lfq.139.1704194484066;
        Tue, 02 Jan 2024 03:21:24 -0800 (PST)
Received: from ?IPV6:2a02:8389:41cf:e200:f280:eb5b:2b83:dc35? (2a02-8389-41cf-e200-f280-eb5b-2b83-dc35.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:f280:eb5b:2b83:dc35])
        by smtp.gmail.com with ESMTPSA id su14-20020a17090703ce00b00a235b1e81b4sm11533461ejb.114.2024.01.02.03.21.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 03:21:23 -0800 (PST)
Message-ID: <03f469ca-c5f4-4255-90f4-6715a1455e0d@gmail.com>
Date: Tue, 2 Jan 2024 12:21:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] io: light: as73211: add support for as7331
To: Jonathan Cameron <jic23@kernel.org>
Cc: Christian Eggers <ceggers@arri.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231220-as7331-v1-0-745b73c27703@gmail.com>
 <20231220-as7331-v1-2-745b73c27703@gmail.com>
 <20231226161414.47d5171e@jic23-huawei>
Content-Language: en-US
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20231226161414.47d5171e@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26.12.23 17:14, Jonathan Cameron wrote:
>> Add a new device-specific data structure to account for the device
>> differences: channel types and scale of LSB per channel.
> A may not be worth doing it in this case, but usual approach to refactoring
> a driver to allow support of additional devices is to do it in two steps.
> 1) Refactor with no new support - so should be no operational changes.
> 2) Add the new device support.
> 
I considered that in the first place, but the "refactoring" was so
simple that the modification was just adding a pointer to an empty
struct (you don't know what is chip-specific until you have another
chip) and the patch alone had no real value (otherwise it could be
applied to all drivers that only support one device, just in case).

As you said, it may not be worth it in this case, but thank you for the
clarification.

>> +static int as73211_intensity_scale(struct as73211_data *data, int chan, int *val, int *val2)
>> +{
>> +	unsigned int scale;
>> +
>> +	switch (chan) {
>> +	case IIO_MOD_X:
>> +		scale = AS73211_SCALE_X;
>> +		break;
>> +	case IIO_MOD_Y:
>> +		scale = AS73211_SCALE_Y;
>> +		break;
>> +	case IIO_MOD_Z:
>> +		scale = AS73211_SCALE_Z;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +	scale /= as73211_gain(data);
>> +	scale /= as73211_integration_time_1024cyc(data);
>> +	*val = scale;
>> +
>> +	return IIO_VAL_INT;
> 
> Obviously it's really a question about the original code but why not
> use IIO_VAL_FRACTIONAL here as well as below? Superficially looks
> like it should work in a similar fashion.
> 
> If not, perhaps a comment here somewhere?
> 
You are right, the use of IIO_VAL_INT comes from the original
implementation. I did not modify that because the expected precision
(according to the datasheet is 3 decimal places) is guaranteed with the
use of nW/m^2 instead of nW/cm^2 (the units used in the datasheet).

I think the best approach would have been using IIO_VAL_FRACTIONAL and
the units provided in the datasheet, but changing units now could cause
problems to current users. We could still use IIO_VAL_FRACTIONAL unless
that might affect current users in any way. Otherwise I will add a
comment as suggested.

>> @@ -355,30 +444,12 @@ static int as73211_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec cons
>>  			*val2 = AS73211_SCALE_TEMP_MICRO;
>>  			return IIO_VAL_INT_PLUS_MICRO;
>>  
>> -		case IIO_INTENSITY: {
>> -			unsigned int scale;
>> -
>> -			switch (chan->channel2) {
>> -			case IIO_MOD_X:
>> -				scale = AS73211_SCALE_X;
>> -				break;
>> -			case IIO_MOD_Y:
>> -				scale = AS73211_SCALE_Y;
>> -				break;
>> -			case IIO_MOD_Z:
>> -				scale = AS73211_SCALE_Z;
>> -				break;
>> -			default:
>> -				return -EINVAL;
>> -			}
>> -			scale /= as73211_gain(data);
>> -			scale /= as73211_integration_time_1024cyc(data);
>> -			*val = scale;
>> -			return IIO_VAL_INT;
>> +		case IIO_INTENSITY:
>> +			return data->spec_dev->intensity_scale(data, chan->channel2, val, val2);
> Where it doesn't hurt readability, I'd prefer we stayed as close to 80 chars or below
> as reasonably possible.  So here wrap so val, val2); is on the next line.
> 
In order to meet the 80-char rule, three lines will be required
(wrapping val, val2 is not enough; chan->channel2 must have its own
line). It looks a bit weird, but I have nothing against it.

On the other hand, the original code did not always follow the 80-char
rule (up to 99 chars per line are used), so using two lines with a first
one of 84 chars could be an option.

>> +	if (dev_fwnode(dev))
>> +		data->spec_dev = device_get_match_data(dev);
>> +	else
>> +		data->spec_dev = i2c_get_match_data(client);
> 
> Take a look at how i2c_get_match_data() is defined...
> https://elixir.bootlin.com/linux/latest/source/drivers/i2c/i2c-core-base.c#L117
> and in particular what it calls first..
> 
Oops! I missed that one. I will simplify the code to a simple call to
i2c_get_match_data() and error check:

        data->spec_dev = i2c_get_match_data(client);

        if (!data->spec_dev)

                return -EINVAL;

> 
Thanks for your review and best regards,
Javier Carrasco

