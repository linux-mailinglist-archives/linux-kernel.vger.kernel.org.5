Return-Path: <linux-kernel+bounces-46478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 764DA84404B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C8652904B2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591827BAFF;
	Wed, 31 Jan 2024 13:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHyyDLsa"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2A47AE47;
	Wed, 31 Jan 2024 13:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706707015; cv=none; b=pfsGkQPUGcMXiuV9ARUpuHuDMExpuRPZgW34fKbgMRE9vLymuvPvhHbnmZT9Wda6EL+qphNZijQywJiuUBRVc/0k+PSrPfgmpcdXWsmCMj2cEx+/YC9qvitZmUkSXnHsiafYcTCNDCqHYOhbxBeSTyF67LjLhOUz0vFOucLDjqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706707015; c=relaxed/simple;
	bh=AW4f6dw+zidICyXZgjwIu41kdHjOtjxCRAic489hQXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lj6VOXbMNSGluWoTvD/2jvYgJV4ZSPvW8xhyishzP60Lc8kyr9n4F4XNIn7m/tidkUlaNxC8wCE1GS0TwnNjCnp4PJRoN3q24UEzZcjJ10wKlVHrwDzvz/axhvyr8ta9FYipsRq6T2LNFgQTXA/q6V078WePVKUL6Jr7/6kE7C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHyyDLsa; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d928a8dee8so5110715ad.1;
        Wed, 31 Jan 2024 05:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706707013; x=1707311813; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=MD6YCJseT7Z8Ach4Jqdsb6hrlt+6cO4c5ma7tx+4HwE=;
        b=WHyyDLsaGGUPPeaarqTlHUq9ElfRO5j8V4cRsSlpioR6AR2WPByIJEXQ/LGFFqf84a
         dCe+/EQuSPHQIQw20MQwRRWwSidnl7+9rQAzi0DnbtrFL3mPVCnq1hy8TxaknaCl1kvH
         qjyDcNHzrDIV3WeLyH5JBuN7o8eMLzJTi5exkUPAH59w39bgwxkNp8+ZbKVTnscieFNo
         wU/aMRT8sC9glh0elo3+N5Xxm37bwEGzN8PhMgVRmeQn8Z15JzIee763HBRewiwYtbqY
         6GS0QamqWKokRKcb2Ar9FrIkr1bDPp0+h5RKi3RVkpI4U9g4MyOFByxu9kY6bPOXLaKq
         sDPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706707013; x=1707311813;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MD6YCJseT7Z8Ach4Jqdsb6hrlt+6cO4c5ma7tx+4HwE=;
        b=ZR+43PUGVdNpj8J0y/QNIZ/Ul2rp8x38MQY/TxQF/z/lUQvk4TxsXPuXf0CXYSlsrK
         iZSQSvmcXu8uvOSgnWY1i8M/cB+l74Qd8jQOgqJ65wEcdokEmO5XbGE1VHldB6PvsH6i
         lAs2sA6zOyOQrYRnYiFI82FFrQKcEib4QAarBIpkLHIfoKzmpYTyZvxWMHfS36idjRRV
         nlNH9y2UHpNck7NE3wNvgtlLbYdg1dUG8BJApUX2+clOkpRfyNYKw24YWJT8L8vpoQVW
         AFOmsGyqGBJ8NirehWOMmVGLzkmQeKnpGFmFslTn0e81k0Lk4GRTZAayS19UKEWNxbDB
         2yDA==
X-Gm-Message-State: AOJu0Yzd9rzat2zHAVky+fMRAxxx4j4wUArdE5JGAWN7sN72tZCGfq7/
	X4oddZiKiA9DCC3Aw/mNnyhIzUVNw07TxTTTyyjl0gk8YB6skQMy
X-Google-Smtp-Source: AGHT+IH94B9t+SXxYqXc1gbnAmIbR/323RWPyZTqnDV6fuxYFFCORSLA6qKwxUnFVZ8L6JAiGwE15A==
X-Received: by 2002:a17:90b:188d:b0:28f:fa9d:ebdf with SMTP id mn13-20020a17090b188d00b0028ffa9debdfmr4518600pjb.3.1706707012810;
        Wed, 31 Jan 2024 05:16:52 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r8-20020a170902be0800b001d7405022ecsm9009768pls.159.2024.01.31.05.16.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 05:16:52 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4ea02224-e9fa-4ee9-9210-bc7a7ae9e86b@roeck-us.net>
Date: Wed, 31 Jan 2024 05:16:50 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/11] watchdog: rzg2l_wdt: Check return status of
 pm_runtime_put()
Content-Language: en-US
To: claudiu beznea <claudiu.beznea@tuxon.dev>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "geert+renesas@glider.be" <geert+renesas@glider.be>,
 "magnus.damm@gmail.com" <magnus.damm@gmail.com>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "sboyd@kernel.org" <sboyd@kernel.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
Cc: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240131102017.1841495-1-claudiu.beznea.uj@bp.renesas.com>
 <20240131102017.1841495-5-claudiu.beznea.uj@bp.renesas.com>
 <TYCPR01MB11269AD7463C9C7C0A09A43A9867C2@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <ddc0b42c-bf88-4c0d-b938-8bd7ff7b329a@tuxon.dev>
 <TYCPR01MB11269BFC2DB457049A2B8C0C8867C2@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <12f458b1-f963-43f4-afcf-715abf635e54@tuxon.dev>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <12f458b1-f963-43f4-afcf-715abf635e54@tuxon.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/31/24 03:00, claudiu beznea wrote:
> 
> 
> On 31.01.2024 12:41, Biju Das wrote:
>> Hi Claudiu,
>>
>>> -----Original Message-----
>>> From: claudiu beznea <claudiu.beznea@tuxon.dev>
>>> Sent: Wednesday, January 31, 2024 10:36 AM
>>> Subject: Re: [PATCH v2 04/11] watchdog: rzg2l_wdt: Check return status of
>>> pm_runtime_put()
>>>
>>> Hi, Biju,
>>>
>>> On 31.01.2024 12:32, Biju Das wrote:
>>>> Hi Claudiu,
>>>>
>>>> Thanks for the feedback.
>>>>
>>>>> -----Original Message-----
>>>>> From: Claudiu <claudiu.beznea@tuxon.dev>
>>>>> Sent: Wednesday, January 31, 2024 10:20 AM
>>>>> Subject: [PATCH v2 04/11] watchdog: rzg2l_wdt: Check return status of
>>>>> pm_runtime_put()
>>>>>
>>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>>
>>>>> pm_runtime_put() may return an error code. Check its return status.
>>>>>
>>>>> Along with it the rzg2l_wdt_set_timeout() function was updated to
>>>>> propagate the result of rzg2l_wdt_stop() to its caller.
>>>>>
>>>>> Fixes: 2cbc5cd0b55f ("watchdog: Add Watchdog Timer driver for
>>>>> RZ/G2L")
>>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>> ---
>>>>>
>>>>> Changes in v2:
>>>>> - propagate the return code of rzg2l_wdt_stop() to it's callers
>>>>>
>>>>>   drivers/watchdog/rzg2l_wdt.c | 11 +++++++++--
>>>>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/watchdog/rzg2l_wdt.c
>>>>> b/drivers/watchdog/rzg2l_wdt.c index d87d4f50180c..7bce093316c4
>>>>> 100644
>>>>> --- a/drivers/watchdog/rzg2l_wdt.c
>>>>> +++ b/drivers/watchdog/rzg2l_wdt.c
>>>>> @@ -144,9 +144,13 @@ static int rzg2l_wdt_start(struct
>>>>> watchdog_device
>>>>> *wdev)  static int rzg2l_wdt_stop(struct watchdog_device *wdev)  {
>>>>>   	struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
>>>>> +	int ret;
>>>>>
>>>>>   	rzg2l_wdt_reset(priv);
>>>>> -	pm_runtime_put(wdev->parent);
>>>>> +
>>>>> +	ret = pm_runtime_put(wdev->parent);
>>>>> +	if (ret < 0)
>>>>> +		return ret;
>>>>
>>>> Do we need to check the return code? So far we didn't hit this
>>> condition.
>>>> If you are planning to do it, then just
>>>>
>>>> return pm_runtime_put(wdev->parent);
>>>
>>> pm_runtime_put() may return 1 if the device is suspended (which is not
>>> considered error) as explained here:
>>
>> Oops, I missed that discussion. Out of curiosity,
>> What watchdog framework/consumer is going to do with a
>> Non-error return value of 1?
> 
> Looking at this:
> https://elixir.bootlin.com/linux/latest/source/drivers/watchdog/watchdog_dev.c#L809
> 
> it seems that the positive values are not considered errors thus, indeed,
> we may return directly:
> 
> return pm_runtime_put();
> 
> Guenter,
> 
> With this (and previous discussion from [1]), are you OK to change it like:
> 
> return pm_runtime_put();
> 

Instead of looking at the source, I would kindly ask you to look at the API.

Guenter


