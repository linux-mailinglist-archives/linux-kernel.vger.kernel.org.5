Return-Path: <linux-kernel+bounces-30355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5225831DA3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06DE71C225A5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CA92C1AF;
	Thu, 18 Jan 2024 16:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ej/9Pa+5"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B947E25770;
	Thu, 18 Jan 2024 16:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705595866; cv=none; b=Z51lSxNLtyQCfKkggQAdhXSAk0OQHDGcolEB0mAzvGp7SJmaxFxLySCFFh3piL5q+oeF0fenKNX+gBsWbKLbPIRO8SzGRWnexXyx7z9h3T7NuBodn7m6j67bxecZf/ZWVDJgCeQQt34rBXZQD1TlcFMLuaeHzQ3XrV2i2tt2j6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705595866; c=relaxed/simple;
	bh=CqRZXXHBP5AumSjroWZ4SDntcmMBc1STE9z4wE3SeYg=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=qk2dzEWg0c/8q8fVTmZW1MA7xld5RA19fVRM2Bh3bmFVNIHM/527sMxNGAVOOq6JXL7x+3K3z+/guEfPtxEQ7VjS6uFKoZ7UvkCbdw4ar/Ffe9Ax9yAdpDhD2Xh2lqDC/25icQuJoWVaUM8EbyeJx4/NLtnNB756kaXB0Vzb7gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ej/9Pa+5; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55a45a453eeso415643a12.0;
        Thu, 18 Jan 2024 08:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705595863; x=1706200663; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KVFO3/auyr2zJ09RykGkElEusljuvXTip3QuV7SQMtI=;
        b=ej/9Pa+55AwBGTrla1o342fmjOBrAsqQMzdfhqHB1Q1J7NYhInVqBt0k6p3vxszsLt
         Nan+5sYfzxphHCAiey407PAKfuZTD6h62Bk/J3ntHi2+bWjAUQBaq6ujrh0zgoYqTKlV
         bgaYSqo6cPoWShNrxhKn1XxpuzAnjEA2mqotnolLFckvzr+ux+tMWFk8k8hsN3wiAoam
         hCXJHo9MgP9rJpksJBDizeqmkQTw3zxoanUHkTTxFXI74kmFvIsEwRJOyafkrpiRWi74
         ilWqR61qDUO8Kwjp+ovfcbJ26jsqM5u1wQ9wVqwPzZzXN3Kwrl9mJFOh1vS84hV9z4yg
         0H5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705595863; x=1706200663;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KVFO3/auyr2zJ09RykGkElEusljuvXTip3QuV7SQMtI=;
        b=hnFp8foAgpGDhWxDyXxb0Xjl0RqaoNtb3qls0UlmP6V3zMRT+kCTNVaZBJRkvvIF2o
         cx5KL09IAR0WyfT5ZoFb4lBq65VXunMa8/fXIn7Yv5BWV7CDqiLbF/4CpYbO25PN7yK5
         /Aar0j0ic1WTGC9H4994S4upht6Z8Efr+FeXpAmaL+KhTYFVshmzh8a+Usr96EvkA1fj
         Nvd+WzTlYEMpnTmMPXUhUhSqYWM1WJ1XvUjrKzNU+yzQNoB6anaU/G+8dnZKG73mfzlg
         xIwyK6NGf0mUTRpqjkGa068nJWA63AEd0fRaNqZypXD0O39YQVHKGPWvpDEERpcEngNx
         sIOQ==
X-Gm-Message-State: AOJu0YxuoKFGXsiW/t+tbV+ijeI4wFmV8mmKzniQs3xVjIZyEWfYdyPJ
	Cj0GW5HtUKIX7cr6RG+dthji1jU/CaSIA3zv+EOJXR8aKv+9+XiL
X-Google-Smtp-Source: AGHT+IGmmSj1HFKso+s8SBpt8kTu2SA0tT9uau1LDNDju0OkIf9aqhbm9nL1AdrqqMjc66bTVsmo3w==
X-Received: by 2002:aa7:cd64:0:b0:55a:380a:fbca with SMTP id ca4-20020aa7cd64000000b0055a380afbcamr464232edb.20.1705595862786;
        Thu, 18 Jan 2024 08:37:42 -0800 (PST)
Received: from [192.168.100.74] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id a14-20020a05640213ce00b00559ba291d82sm3322508edx.82.2024.01.18.08.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 08:37:42 -0800 (PST)
Message-ID: <6a823a1d-262a-4c59-8144-7283dcb5172b@gmail.com>
Date: Thu, 18 Jan 2024 17:37:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] hwmon: Add support for Amphenol ChipCap 2
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org
References: <20240115-topic-chipcap2-v5-0-0cc7a15aeece@gmail.com>
 <20240115-topic-chipcap2-v5-5-0cc7a15aeece@gmail.com>
 <226d3abd-e372-4c66-b2b0-cc86e6a4bb27@sirena.org.uk>
 <30b9ab0c-f3cb-4b5a-a726-de9f7c61769b@gmail.com>
 <f5827df7-34fa-4c11-aca9-ecc6c83c512d@sirena.org.uk>
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <f5827df7-34fa-4c11-aca9-ecc6c83c512d@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 18.01.24 17:04, Mark Brown wrote:
> On Thu, Jan 18, 2024 at 04:30:37PM +0100, Javier Carrasco wrote:
>> On 18.01.24 14:49, Mark Brown wrote:
>>> On Mon, Jan 15, 2024 at 09:02:25PM +0100, Javier Carrasco wrote:
> 
>>>> +static int cc2_enable(struct cc2_data *data)
>>>> +{
>>>> +	int ret;
> 
>>>> +	if (regulator_is_enabled(data->regulator))
>>>> +		return 0;
> 
>>> This is generally a sign that the regulator API usage is not good, the
>>> driver should not rely on references to the regulator held by anything
>>> else since whatever else is holding the regulator on could turn it off
>>> at any time.  If the driver did the enable itself then it should know
>>> that it did so and not need to query.
> 
>> The driver handles a dedicated regulator, but I wanted to account for
>> the cases where the attempts to enable and disable the regulator fail
>> and keep parity. If the disabling attempt fails, will the regulator not
>> stay enabled? In that case, an additional call to regulator_enable would
>> not be required, right?
>> That is the only reason I am using regulator_is_enabled(), but maybe
>> things don't work like that.
> 
> With exclusive use you can get away with this, you should have a comment
> for that case though.
> 
I will add a comment to clarify it.
>>>> +	ret = regulator_enable(data->regulator);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>> +	/*
>>>> +	 * TODO: the startup-delay-us property of the regulator might be
>>>> +	 * added to the delay (if provided).
>>>> +	 * Currently there is no interface to read its value apart from
>>>> +	 * a direct access to regulator->rdev->constraints->enable_time,
>>>> +	 * which is discouraged like any direct access to the regulator_dev
>>>> +	 * structure. This would be relevant in cases where the startup delay
>>>> +	 * is in the range of milliseconds.
>>>> +	 */
>>>> +	usleep_range(CC2_STARTUP_TIME_US, CC2_STARTUP_TIME_US + 125);
> 
>>> Note that the regulator startup delay is the time taken for the
>>> regulator to power up so if the device needs additional delay then that
>>> will always need to be in addition to whatever the regulator is doing.
> 
>> What I mean by that is that the device cannot be ready until the
>> regulator powers it up (obvious) plus the start up time of the device
>> itself once it gets powered up. So if a regulator takes for example 1 ms
>> to power up, the sleep function could (and should) wait for 1 ms longer.
> 
> No, the sleep function should do nothing of the sort - if any delay is
> neeeded for the regulator it will be handled as part of enabling the
> regulator.  This is not exposed to client drivers because it is
> transparent to them.
That sounds great. Then there is no need for the comment altogether and
the TODO will go away.

Thank you again and best regards,
Javier Carrrasco

