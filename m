Return-Path: <linux-kernel+bounces-35068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CC0838B69
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E12B1C20C8E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13A05BAFC;
	Tue, 23 Jan 2024 10:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCwqVxRq"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2570E57311;
	Tue, 23 Jan 2024 10:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706004573; cv=none; b=dLzRgHyjTqfQerL6l7OHJESviE/texYLA60atC7gcNbAVslVr8z+PHa9SN9JFD9TUG32N82HchSJ4a0nO1Sd4xy9GPx8RzVENCW7NpEK66KOLrlaQcH/e5SrlGPF8mbOyh0GOJ2Mrw0Idj57SA4h1toV5fbSlu6qibjtDBuFV74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706004573; c=relaxed/simple;
	bh=bkc6dtM8tWOn6AoyPD8ER51XkxCtb7qLJw9BAEpIsDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V0Au1YvHgwT6EfG25H5Nrwf+rFXN4HpFH+HlaX4KZVM5La3k20aWUHJBBgBAAnHq7kStq4B1bQw85JzClFMFtR+RhCy9/+6uE7n8xQ23LHtpLmtd1XKFLiyxESVbhzw56bdfWHqrGt5WIYDEYxphzGvYwLv7CYq4dMIY+/st4fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FCwqVxRq; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6d9b37f4804so3058666b3a.1;
        Tue, 23 Jan 2024 02:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706004570; x=1706609370; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=vF3YAHXTJJCMn28KdzwGiFf2RissWmiYZiWxD+NZ6vM=;
        b=FCwqVxRqp8BR3oGRU32hmgkbS5LWeC+XnhztlkLtp8r8Rn+T2/51tVIKZ5TCbumW6y
         7bBNOxDDHnjq9ADxQg8NLTKojzWZMtFtfhSaNM22ScAnHEu/berGofyZJY0m732409Hv
         GmgjME/z6UsZxAX2JtoOpFEw7CkGZNxedZs11+lVO36xBwLxOKcTopR/0g98KGqzNyQY
         NFtvC3mN/H5pUBaYxENkPiQsewv1pw2bwkvg4hCvVOnjwkJBGeOTwTgcUzmQJvBuIRBe
         d9LBi+ATcGYSd8oXZ4L2MsAqkqZ7zVxrFQ2zdxMG1vT72PW9zmsMXrqhYutNhRuMLP6W
         m7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706004570; x=1706609370;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vF3YAHXTJJCMn28KdzwGiFf2RissWmiYZiWxD+NZ6vM=;
        b=aRtj2/SM6cEc60l0s75P02kwKZWgK9RrPwKxMg0meGL3T1afiLSBxxgYGb8RPsvYdp
         HHMvuBYVnXEUOCAwj9YXpz8bARVlC6mjj1PYB3rFKAzqs1cy8wOJqZnmjwZV1cqoJegu
         b5B78An3tizTaNK3+aE9k8zOrNZ3wRgYH/7L2SvReRIuDDtfxoUBCWOH677Z3VnupjPM
         tWV2QOVRFmRLsQSVro6AkTBLGuV8UZQo9CGOk/xfTpuucKNhbVcvL9mW2QicZuhcNAMK
         Dlr/JlOr8XXpi+gu6SjdNhQrea+66fXHxionUoLl5bq+TVe7F4xe1+G/mS8c73kMVAHA
         ZjWw==
X-Gm-Message-State: AOJu0YwH0oVsuAsiQhXn4lMntw9bRoq6UGNdk2jv3gNApxQrEMxnyJWe
	g0LSFOqH296AzoQfMfGTG+nmQzdd7IgtdaSLi9lFQUwLFL0O1k9S
X-Google-Smtp-Source: AGHT+IHIAWmYLuWi422JcyW3PtuAK24g0dKpE66t9z7rcaaTrk3zHZtgNgaldXuzgg7lQzJgv++RUg==
X-Received: by 2002:a05:6a21:3399:b0:19a:fe9c:e870 with SMTP id yy25-20020a056a21339900b0019afe9ce870mr7692900pzb.12.1706004570347;
        Tue, 23 Jan 2024 02:09:30 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y2-20020a63e242000000b005cd78f13608sm9752654pgj.13.2024.01.23.02.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 02:09:29 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d879634e-c329-4eef-928f-f296535f8838@roeck-us.net>
Date: Tue, 23 Jan 2024 02:09:27 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] watchdog: rzg2l_wdt: Add suspend/resume support
Content-Language: en-US
To: claudiu beznea <claudiu.beznea@tuxon.dev>, wim@linux-watchdog.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, mturquette@baylibre.com,
 sboyd@kernel.org, p.zabel@pengutronix.de, biju.das.jz@bp.renesas.com
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240122111115.2861835-1-claudiu.beznea.uj@bp.renesas.com>
 <20240122111115.2861835-8-claudiu.beznea.uj@bp.renesas.com>
 <a5a807c1-76ef-4cf7-a2cf-bc432c420ded@roeck-us.net>
 <2af40ace-2779-45a0-a244-e7e9e5cc510c@tuxon.dev>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <2af40ace-2779-45a0-a244-e7e9e5cc510c@tuxon.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/22/24 23:13, claudiu beznea wrote:
> 
> 
> On 22.01.2024 19:39, Guenter Roeck wrote:
>> On 1/22/24 03:11, Claudiu wrote:
>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>
>>> The RZ/G3S supports deep sleep states where power to most of the IP blocks
>>> is cut off. To ensure proper working of the watchdog when resuming from
>>> such states, the suspend function is stopping the watchdog and the resume
>>> function is starting it. There is no need to configure the watchdog
>>> in case the watchdog was stopped prior to starting suspend.
>>>
>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>> ---
>>>    drivers/watchdog/rzg2l_wdt.c | 26 ++++++++++++++++++++++++++
>>>    1 file changed, 26 insertions(+)
>>>
>>> diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
>>> index 9333dc1a75ab..186796b739f7 100644
>>> --- a/drivers/watchdog/rzg2l_wdt.c
>>> +++ b/drivers/watchdog/rzg2l_wdt.c
>>> @@ -279,6 +279,7 @@ static int rzg2l_wdt_probe(struct platform_device *pdev)
>>>        priv->wdev.timeout = WDT_DEFAULT_TIMEOUT;
>>>          watchdog_set_drvdata(&priv->wdev, priv);
>>> +    dev_set_drvdata(dev, priv);
>>>        ret = devm_add_action_or_reset(&pdev->dev, rzg2l_wdt_pm_disable,
>>> &priv->wdev);
>>>        if (ret)
>>>            return ret;
>>> @@ -300,10 +301,35 @@ static const struct of_device_id rzg2l_wdt_ids[] = {
>>>    };
>>>    MODULE_DEVICE_TABLE(of, rzg2l_wdt_ids);
>>>    +static int rzg2l_wdt_suspend_late(struct device *dev)
>>> +{
>>> +    struct rzg2l_wdt_priv *priv = dev_get_drvdata(dev);
>>> +
>>> +    if (!watchdog_active(&priv->wdev))
>>> +        return 0;
>>> +
>>> +    return rzg2l_wdt_stop(&priv->wdev);
>>> +}
>>> +
>>> +static int rzg2l_wdt_resume_early(struct device *dev)
>>> +{
>>> +    struct rzg2l_wdt_priv *priv = dev_get_drvdata(dev);
>>> +
>>> +    if (!watchdog_active(&priv->wdev))
>>> +        return 0;
>>> +
>>> +    return rzg2l_wdt_start(&priv->wdev);
>>> +}
>>> +
>>> +static const struct dev_pm_ops rzg2l_wdt_pm_ops = {
>>> +    LATE_SYSTEM_SLEEP_PM_OPS(rzg2l_wdt_suspend_late,
>>> rzg2l_wdt_resume_early)
>>> +};
>>> +
>>>    static struct platform_driver rzg2l_wdt_driver = {
>>>        .driver = {
>>>            .name = "rzg2l_wdt",
>>>            .of_match_table = rzg2l_wdt_ids,
>>> +        .pm = pm_ptr(&rzg2l_wdt_pm_ops),
>>
>> I think this will create a build error if CONFIG_PM=n because rzg2l_wdt_pm_ops
>> will be unused but is not marked with __maybe_unused.
> 
> The necessity of __maybe_unused has been removed along with the
> introduction of LATE_SYSTEM_SLEEP_PM_OPS() and friends (and
> *SET_*LATE_SYSTEM_SLEEP_PM_OPS along with the other helpers were marked
> deprecated for that) and we can use pm_ptr() along with
> LATE_SYSTEM_SLEEP_PM_OPS() to avoid build errors you mentioned.
> 
> FYI, I just build the driver with CONFIG_PM=n and all good.
> 

Ok, but are you sure you did ? You just mentioned earlier that CONFIG_PM
is set automatically through ARCH_RZG2L.

>> But then the driver
>> won't be
>> operational with CONFIG_PM=n, so I really wonder if it makes sense to
>> include any
>> such conditional code instead of making the driver depend on CONFIG_PM.
> 
> That's true. The driver wouldn't work if the CONFIG_PM=n but then it
> depends on COMPILE_TEST which is exactly for this (just to compile test it
> for platforms that don't support it). I see many watchdog drivers depends
> on COMPILE_TEST.
> 
> Give this, please let me know would you like me to proceed with it.
> 

FWIW, COMPILE_TEST dependencies on watchdog drivers fails for most of them.
Regarding pm_ptr(), it is there for practical reasons and not associated with
COMPILE_TEST. Again, if the driver depends on CONFIG_PM to work, using constructs
such as pm_ptr() just hides that and creates the impression that it would work
without it. I do not think that is a good idea. You can use something like

	depends on (ARCH_RENESAS && PM) || COMPILE_TEST

to make that explicit. Even if not, I _really_ don't see the point in using
pm_ptr() even without above dependency. What do you see as its benefit ?

Thanks,
Guenter

> Thank you,
> Claudiu Beznea
> 
>>
>> I really don't think it is desirable to suggest that the driver would work
>> with
>> CONFIG_PM=n if that isn't really true.
>>
>> Guenter
>>
>>>        },
>>>        .probe = rzg2l_wdt_probe,
>>>    };
>>


