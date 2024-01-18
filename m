Return-Path: <linux-kernel+bounces-30283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E67A831C94
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4385F1C25007
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB66F28DB9;
	Thu, 18 Jan 2024 15:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WF7BofNa"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D88E2575C;
	Thu, 18 Jan 2024 15:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705591842; cv=none; b=TcbYWxv4LnviAI5zXYAzaf/H8Vn/6oaFi34b1WLyinU/0CcTBMyyCl1j7qAvhCNSumuf8IWIhyn+HCDwqNq+mrx1+x/XPJBpXugSRyuh+G9U0MnDHR6gCKkXZn9FYSB2v0fnU6jxO6qD02RafE8UW+Q3tjLNzSLOnIpbUtsvW/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705591842; c=relaxed/simple;
	bh=i97GKmF7/horliTQA8nhUjf5fXwkyeIk9RiV/fzEVYg=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=L1IFrpIXOLvCumCyPZ+0h1YQY4bViwQHtgjxGRZ3gaFLAUV2S6CRjoVHFF0hT5mVPXdmzuLANFyMo9XgMJZOlIurt3BkCgjKvMIDk0avjCZItlosvmm9Wv2g14iFRk3gXheR1r9q56rBccaKI1SuGbmULza0GecjjKBAI5sWv/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WF7BofNa; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a2d04888d3dso705840566b.2;
        Thu, 18 Jan 2024 07:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705591839; x=1706196639; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mU10kHzO5fudgGdcQQxn+WV1T9c5UCunJG3bnqaN414=;
        b=WF7BofNaEY+/mCVmE3ZH7DBo9fTWZCZnv+plCCYVDI0EWp2cAgvjSoL9xA3UJaMwN3
         Myxf51dw8renBouPfaVAUo63k0FnyTW+Z51vMPLJEq07LQtBKRY8pzNa30MLtH7gbKJl
         MYxBKhkv2m5y+V2M5ncaZfYVNmqVYkCeXnMw7h0q3FPBHXcdxs/QHcGjxEBcmliyIP0f
         CgHxVKEIqbUVlQvL/5uxHEgjDX6MavcKMH4BT5OcGOg+bYTmGNrkFBX7PdlVLvYnhnny
         b8zX4q57bIdeJtoE49zO4xXSk2l8UepPxvSzfFBoZS7b5FAaYQ6GMVjbvfjQD9Mca1V2
         Np6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705591839; x=1706196639;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mU10kHzO5fudgGdcQQxn+WV1T9c5UCunJG3bnqaN414=;
        b=XQhOskBdXilsq+P4C3pvjhsMNqaw6ciRRDBYpxBchhK1Eqf6wWkxnb9ZQ/8Hjygga6
         DSrjhmCrUb1kpcHybXlrNsZmEvPKfq+hrbbEj42kXmzN1+kJSJwplxR9HcTpyEypSv9b
         vpChSKoHhVbDpLi73BJCxP12KFkNws4YUZWbXA0bs4NodWd6C8CVtMKQzquHNZDG+yxJ
         3XghqppFB4qC9mDQeYkp11CcHxE9EoxvZQGpJeKXZhwNb1yCu3ukTPhwf1zwezg3mhBX
         wxIJhrifGSAjB6Llu8oP8a+SaDQx+gUUQiI0gDjxPYADzA5PKn04F5FC/K0M58N1Licz
         obRg==
X-Gm-Message-State: AOJu0Yxf/avJx1ayzXG12EDRVFn4278B/nZRJWmGm3DRhH6R4oK3xrJC
	kuwvOcOU1huX6JtRXqsWjkSncF4wfOLsayLXg9ETZifFBv8htWpt
X-Google-Smtp-Source: AGHT+IEsRPFWhJZnfqCAmHFQB7Hyek8BcDEJ+ctwHCncmPszdoXFn6upJJR0k14cLPpVD85r89H8jg==
X-Received: by 2002:a17:906:e1a:b0:a2c:f3a:b196 with SMTP id l26-20020a1709060e1a00b00a2c0f3ab196mr608382eji.118.1705591839314;
        Thu, 18 Jan 2024 07:30:39 -0800 (PST)
Received: from [192.168.100.74] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id tl15-20020a170907c30f00b00a2e7b7fab35sm3401485ejc.14.2024.01.18.07.30.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 07:30:38 -0800 (PST)
Message-ID: <30b9ab0c-f3cb-4b5a-a726-de9f7c61769b@gmail.com>
Date: Thu, 18 Jan 2024 16:30:37 +0100
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
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <226d3abd-e372-4c66-b2b0-cc86e6a4bb27@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello Mark,

On 18.01.24 14:49, Mark Brown wrote:
> On Mon, Jan 15, 2024 at 09:02:25PM +0100, Javier Carrasco wrote:
> 
>> +static int cc2_enable(struct cc2_data *data)
>> +{
>> +	int ret;
>> +
>> +	if (regulator_is_enabled(data->regulator))
>> +		return 0;
> 
> This is generally a sign that the regulator API usage is not good, the
> driver should not rely on references to the regulator held by anything
> else since whatever else is holding the regulator on could turn it off
> at any time.  If the driver did the enable itself then it should know
> that it did so and not need to query.
> 

The driver handles a dedicated regulator, but I wanted to account for
the cases where the attempts to enable and disable the regulator fail
and keep parity. If the disabling attempt fails, will the regulator not
stay enabled? In that case, an additional call to regulator_enable would
not be required, right?
That is the only reason I am using regulator_is_enabled(), but maybe
things don't work like that.

>> +	ret = regulator_enable(data->regulator);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/*
>> +	 * TODO: the startup-delay-us property of the regulator might be
>> +	 * added to the delay (if provided).
>> +	 * Currently there is no interface to read its value apart from
>> +	 * a direct access to regulator->rdev->constraints->enable_time,
>> +	 * which is discouraged like any direct access to the regulator_dev
>> +	 * structure. This would be relevant in cases where the startup delay
>> +	 * is in the range of milliseconds.
>> +	 */
>> +	usleep_range(CC2_STARTUP_TIME_US, CC2_STARTUP_TIME_US + 125);
> 
> Note that the regulator startup delay is the time taken for the
> regulator to power up so if the device needs additional delay then that
> will always need to be in addition to whatever the regulator is doing.

What I mean by that is that the device cannot be ready until the
regulator powers it up (obvious) plus the start up time of the device
itself once it gets powered up. So if a regulator takes for example 1 ms
to power up, the sleep function could (and should) wait for 1 ms longer.

I could define a longer start up time to account for "slow" regulators
while still staying in the command window range. Retries have already
been taken into account for longer sleeps.

Thank you for your feedback.

Best regards,
Javier Carrasco

