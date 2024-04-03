Return-Path: <linux-kernel+bounces-129315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3D9896919
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A886BB2A222
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F047F7C1;
	Wed,  3 Apr 2024 08:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnuixuCh"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6FC6D1A0;
	Wed,  3 Apr 2024 08:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712132110; cv=none; b=Y1KNL6f+h7Pai9XM5scZYQMl/pLpp6yUdEwUT6M8QWDXmP15d7hVmCO42zPDWSWAPg4FkeqMesnZfmNG0ncVAW/b0xW31zpW4RQStd7zMB64Kr2Gwuvr6KI0RupixMV1HerkKcPhFTGOuIAOTta5eXdt45ENl5BV0t7LLPCMClY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712132110; c=relaxed/simple;
	bh=79GzaC/wpL41mVe8DAzcTk67Vg58jXpGHfv9U5F10FM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qp7vhHxeMTLypETXk+78+SFZqN/8cpIaXaydIlfTmPWuRhNoAhKyMNRT6YVp46gbesV/6yO9BWM4tY4LdqVughha5Bv13O0GKuvK289eTBcT5UiAKFlTEkbpAlWq50/FmvoUXtWAl8dVRUR/x3GxITnVKE6byZ3KhxgqcnHOap8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VnuixuCh; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-789fb1f80f5so396349285a.3;
        Wed, 03 Apr 2024 01:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712132108; x=1712736908; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s/y2MMICNyue6gWd8hqMT90GtZtiQiQJemVpU+jOY2c=;
        b=VnuixuChz3al4xn9YzKvuYPA19zOh7KhePgBd6cVKTpduzmByr3hs5U8+qbsG/+GDd
         6HVgKwg/V30tNuG+TUShMd9tAElCzoADvULPGPUlpajSDcv7k9L2SwuXLJpKFhrKsBlW
         5IYOtXMnGdrnl3mCQUxiQmwz2QbywHTEYjNIwHGR+2CYROM3z7YI6pj6eaJL/wmUSM6B
         VHJHZ0AVpWz3hgPpB3BoRD6hAIas8N68giXcM7lvYue8Gve1jXZiWsC8tINMg80QVVSL
         dDctUfc7sPqZsCT7AuLjdFHjUZ4tV22Az6zKNJbWobMu5uO2aREw3e7Ilm2whMI3jZIy
         TR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712132108; x=1712736908;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s/y2MMICNyue6gWd8hqMT90GtZtiQiQJemVpU+jOY2c=;
        b=M3ZEgknhuv4XFsAv2EAW45FNtD6f8ivHDfEClugG41DvYTWStqcZYuAOn+BMHe6atV
         dYUzjG+jFlNFD4GLn1m9LkKvmFy2S4G8arvnKmozjV9wKPTo3Md+5z2n+EH8lg9vCvRl
         heQoSsJTtpgFUYZhF+40sdX+FTP31M1EpD3dPFbDjcB/gZDyCzEy2urlptNYgV/FDsfp
         08KNEgACflElmik9T4gpldrw3plqt0lcacajE/r6dFcrByrosuY1Nokp0fldHrRah3hh
         DNkLUrz1+x3LQXBFb3lbNLH6lEzJA+5BLFVj/HzIxEf04jxDNcXya7AFClrdocp6fvUp
         jQfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZU2WmVV6BuLoyfA1QqIhgdiIRuzy57XmyS3/mijgXYVh2T3kWvRxjc76RDcB5WrMPP2bzlAxtlM1CPEvVYFt6KRBVMpXBZGnvVZTwXcdTYgWcMQTNL7fxbijVMBM4DxPrHf/FFN+BJiftMfM66nM6CWeiyhUv736dSf3vVOQ2uS5VuA==
X-Gm-Message-State: AOJu0YzYY22D6x9ntyHjc4FNcAnG9vE9rQLAr8LXa+k5v5uXQhgv+58z
	GCzkNviZntJBWmHMNZMDCbTd76wpB0BKp42XC7TipAtCYFDf5S9w
X-Google-Smtp-Source: AGHT+IHhStCUqTQ4sURggWKUyR75zMC8OhVbI0+OQ+WlbDB0d6z2beYwUbOhPoPpY6zUZ1oesxm8qg==
X-Received: by 2002:a05:620a:55ac:b0:78b:eac4:a023 with SMTP id vr12-20020a05620a55ac00b0078beac4a023mr5447001qkn.39.1712132107971;
        Wed, 03 Apr 2024 01:15:07 -0700 (PDT)
Received: from [10.76.84.174] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id p11-20020a05620a056b00b0078a210372fasm4909954qkp.86.2024.04.03.01.15.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 01:15:07 -0700 (PDT)
Message-ID: <77064a96-c195-4f34-a323-ac01137e448d@gmail.com>
Date: Wed, 3 Apr 2024 11:15:04 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] iio: adc: ad7173: Add support for AD411x devices
To: David Lechner <dlechner@baylibre.com>, dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240401-ad4111-v1-0-34618a9cc502@analog.com>
 <20240401-ad4111-v1-6-34618a9cc502@analog.com>
 <CAMknhBH-YmFrqNTQCB_KafCTxEqSL+36pkE0O44NqiL89hm64Q@mail.gmail.com>
Content-Language: en-US
From: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
In-Reply-To: <CAMknhBH-YmFrqNTQCB_KafCTxEqSL+36pkE0O44NqiL89hm64Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 02/04/2024 00:53, David Lechner wrote:
> On Mon, Apr 1, 2024 at 10:10 AM Dumitru Ceclan via B4 Relay
> <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:
>>
>> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>>
>> Add support for AD4111/AD4112/AD4114/AD4115/AD4116.
>>
>> The AD411X family encompasses a series of low power, low noise, 24-bit,
>> sigma-delta analog-to-digital converters that offer a versatile range of
>> specifications.
>>
>> This family of ADCs integrates an analog front end suitable for processing
>> both fully differential and single-ended, bipolar voltage inputs
>> addressing a wide array of industrial and instrumentation requirements.
>>
>> - All ADCs have inputs with a precision voltage divider with a division
>>   ratio of 10.
>> - AD4116 has 5 low level inputs without a voltage divider.
>> - AD4111 and AD4112 support current inputs (0 mA to 20 mA) using a 50ohm
>>   shunt resistor.
>>
>> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
>> ---
> 
> ...
> 
>> @@ -951,7 +1117,7 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
>>         struct device *dev = indio_dev->dev.parent;
>>         struct iio_chan_spec *chan_arr, *chan;
>>         unsigned int ain[2], chan_index = 0;
>> -       int ref_sel, ret, num_channels;
>> +       int ref_sel, ret, reg, num_channels;
>>
>>         num_channels = device_get_child_node_count(dev);
>>
> 
> Another thing that is missing in this function both for the chips
> being added here and the existing chips are channels for _all_
> possible inputs. The driver is adding a fixed input channel for the
> temperature sensor, as it should. But all of the chips also have a
> similar input channel configuration that measures the reference
> voltage. Currently, there doesn't seem to be a way to make use of this
> feature. I would expect a hard-coded voltage input channel that is
> always added for this reference voltage similar to the temperature
> channel.
> 

AD7173-8:
 Channel input configs:
AINPOS0: REF+ 10101: 21
AINNEG0: REF- 10110: 22

For the user to define the REF measurement channel:
 diff-channels = <21 22>;
So it is possible from the binding side. It would just need support from
the driver as currently any value above the stated number of inputs is
rejected. Maybe document this in a comment like you suggested below.

I really do not agree with using up channels without letting the user
decide. I can accept to dedicate one for the temp where applicable but
more than that and it feels like we are restricting the usage too much.


> The ad717x chips (except AD7173-8 and AD7176-2) also have a common
> mode voltage input ("((AVDD1 − AVSS)/5)") that could work the same.
> 

Again, would be resolved if I added support from the driver.

> In the case of the ad717x chips though, it looks like these channels
> are not "fixed" like they are in ad411x. It looks like these inputs
> can be mixed and matched with AINx inputs and/or each other as
> differential pairs. So if that is actually the case, I would expect
> the DT bindings for ad717x to look like adi,ad4130.yaml where these
> additional input sources are listed in the diff-channels property
> instead of having hard-coded channels in the driver like I have
> suggested above.
> 

Yep, agree.

> But, as always, fixes for ad717x should be in a separate patch series.
> Still, I think adding a hard-coded channel for the reference voltage
> input for ad411x chips in this patch makes sense.

As stated above, not comfortable with using up channels with hard-coded
values.


