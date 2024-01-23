Return-Path: <linux-kernel+bounces-35060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CCA838B4B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2394E28EACF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAA75A783;
	Tue, 23 Jan 2024 10:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GS5ysBOp"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E705A0F4;
	Tue, 23 Jan 2024 10:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706004028; cv=none; b=fcBUMcSy2q03y3iqTd2AazL9mBW/UMALEFTKfFiUk9lgS1JFb4XCHz7qJSi/on0hCpvdMVTaqRTpTUv+VJsGH95ev8XFTD20Zm4pYBlO2wDM0bvC+/uqKDxuefh0EFD5+QILdlCEsfq96tA0wW1W2av3FPK1aHbUtNQNurNmx0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706004028; c=relaxed/simple;
	bh=tWtM0aRE7gi8J0xM0NngvsObtVXPw8EzFJdj7ZUJtEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CfsCZFEOPBITo0nU1WHLK3Hr9IZggK2MJ8t5wZ5pJoMyQDWxzWQxDkk3hG3z8EAVD1F+CPiRDA6SBC7a/l+2AjBPBCYw8dTZKP/2OFo5Esw8Ac+iW618To/WV4tKEdKiuPVRgg6TFsjpU9FWADhnf7Ikbql/35Iq4+r9PPuH8gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GS5ysBOp; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5cf1f4f6c3dso1964893a12.2;
        Tue, 23 Jan 2024 02:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706004025; x=1706608825; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=F+ctDPNeFBq/VjlK1sIBZskqA0s3m7Q2NTDa1byxa0M=;
        b=GS5ysBOp4OboGgT1pk+B91RmHTPE8YaCUZeVdlsPzZBluEznHcXvWH02MFqLIXZ6bO
         BCoa6qKiSqbAhueMS2kUKpCY6A4EtFwvEP7pBxCarTMJp/g+OpmX7+foIxQbgyDqyJaM
         TBVkHdApNGcH1N53Nns2nP7zZxRGPN9QLYmSa7eKa/snmx0ht/FQ6CafZyfVJHtU7DZz
         9c0HGF3Dig5vgdN6q61Cz2TEcE4RS/MTmsuzjRN0v11FKQXRaD9YXAVbindNaem34vrx
         U69FjhUWN95DJaHa/m+dIKf+07AZAEyIokAw/4MHzIkO6/bwojQdNtiIaew3q6VagtN8
         H5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706004025; x=1706608825;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F+ctDPNeFBq/VjlK1sIBZskqA0s3m7Q2NTDa1byxa0M=;
        b=DD2hqWPLATy1KRQ2RB8IJOSdfgKG7cJ+zm+hKYxi6G01m5xKsScYAZoTO4FIBGwGvi
         qJMpGc1tHgC+r4RXGtXvOq88ZzrbCsh/cKdmdxaVn4Yw5it5IwINqqvyKhywi9GHQUT0
         rHZlirvfwU3PB1bv8rKrGQvZsaxHeYymw/6Of0WMnfJufJZcv45V50C5YMg+SkTxyQCi
         xZhYJYweZYCKZrVmyVbUTkgSmhWEtewftdFn0h4oWK23WSYyfksWFQBCSmEfE4NS3rWl
         qq4yAH360VPjSXuU07ZAKmPsITyl6pI5U+/DA9vRHnQDZ4tH/lELhBslxgPD0/WAb6N2
         5iAw==
X-Gm-Message-State: AOJu0Yz4gPP0gwCzHscnVShtz08palbAISibOhUw2RC7CSq/x9Gfo2Ci
	gZ470aaU9yo6/2RbYwFc7P68tr/unf0dn/N4zHCwKSKEgoIma60O
X-Google-Smtp-Source: AGHT+IFhl6oGMpu/Q2RixaDZx/DlJFHiVeGGPWYCGCf11/ly5Pxkq/dWyQ7cXN7oG4ew+lJWTJrwKw==
X-Received: by 2002:a17:90b:88e:b0:290:8a26:248 with SMTP id bj14-20020a17090b088e00b002908a260248mr1772945pjb.17.1706004025346;
        Tue, 23 Jan 2024 02:00:25 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q6-20020a17090ac10600b00290b567b27csm2781206pjt.46.2024.01.23.02.00.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 02:00:24 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1fbd3b4d-620f-4d2f-852a-e3a275bb425d@roeck-us.net>
Date: Tue, 23 Jan 2024 02:00:22 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] watchdog: rzg2l_wdt: Check return status of
 pm_runtime_put()
Content-Language: en-US
To: claudiu beznea <claudiu.beznea@tuxon.dev>, wim@linux-watchdog.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, mturquette@baylibre.com,
 sboyd@kernel.org, p.zabel@pengutronix.de, biju.das.jz@bp.renesas.com
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240122111115.2861835-1-claudiu.beznea.uj@bp.renesas.com>
 <20240122111115.2861835-4-claudiu.beznea.uj@bp.renesas.com>
 <c857cdd4-459b-41ae-b4bb-0da45e461335@roeck-us.net>
 <92db308f-075c-4799-9777-5bc14438ce68@tuxon.dev>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <92db308f-075c-4799-9777-5bc14438ce68@tuxon.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/22/24 23:02, claudiu beznea wrote:
> 
> 
> On 22.01.2024 19:31, Guenter Roeck wrote:
>> On 1/22/24 03:11, Claudiu wrote:
>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>
>>> pm_runtime_put() may return an error code. Check its return status.
>>>
>>> Fixes: 2cbc5cd0b55f ("watchdog: Add Watchdog Timer driver for RZ/G2L")
>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>> ---
>>>    drivers/watchdog/rzg2l_wdt.c | 6 +++++-
>>>    1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
>>> index 4ab9e7c5e771..0554965027cd 100644
>>> --- a/drivers/watchdog/rzg2l_wdt.c
>>> +++ b/drivers/watchdog/rzg2l_wdt.c
>>> @@ -144,9 +144,13 @@ static int rzg2l_wdt_start(struct watchdog_device
>>> *wdev)
>>>    static int rzg2l_wdt_stop(struct watchdog_device *wdev)
>>>    {
>>>        struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
>>> +    int ret;
>>>          rzg2l_wdt_reset(priv);
>>> -    pm_runtime_put(wdev->parent);
>>> +
>>> +    ret = pm_runtime_put(wdev->parent);
>>> +    if (ret < 0)
>>> +        return ret;
>>>          return 0;
>>>    }
>>
>> A simple
>>      return pm_runtime_put();
>> might do.
> 
> pm_runtime_put() may return 1 if the device is already suspended though
> this call trace:
> 
> pm_runtime_put() ->
>     __pm_runtime_idle() ->
>         rpm_idle() ->
>             rpm_suspend() ->
>                 rpm_check_suspend_allowed() [1]
> 
> That return value is not considered error thus I wanted to consider it
> here, too.
> 
Good point.

> [1]
> https://elixir.bootlin.com/linux/latest/source/drivers/base/power/runtime.c#L278
> 
>>
>> However, one question: Given that pm_runtime_put() returns -ENOSYS if
>> CONFIG_PM is disabled, that means the driver will depend on CONFIG_PM=y.
> 
> Indeed, the driver depends on CONFIG_PM=y for proper working. It is for
> devices selecting ARCH_RZG2L and RZ/V2M (ARM64 based uarch) which select
> CONFIG_PM=y:
> https://elixir.bootlin.com/linux/latest/source/drivers/soc/renesas/Kconfig#L45
> 
> The driver is written with CONFIG_PM=y dependency in mind (e.g. the clocks
> are enabled though runtime PM APIs).
> 
>> Assuming this is intentional, would it make sense to explicitly declare
>> that dependency in Kconfig ? It doesn't seem to make any sense to build
>> the driver if it won't work anyway.
> 
> The dependency exists there for ARCH_RZG2L and RZ/V2M devices but not
> directly and it is not strict (in the sense that we allow to build the
> driver w/o CONFIG_PM (I think this is good to check build on different
> configurations, the COMPILE_TEST is there anyway in [1]) ). E.g.:
> 
> RENESAS_RZG2LWDT depends on ARCH_RENESAS [1]
> ARCH_RENESAS is the ARMv8 uarch flag [2]
> SOC_RENESAS is set if ARCH_RENESAS [3]
> ARCH_RZG2L is visible only if SOC_RENESAS [4]
> ARCH_RZG2L selects PM [5]
> RZ/V2M selects PM [6]
> 
> Please let me know what do you think about it?
> 
If the driver indeed depends on CONFIG_PM, that should be made explicit.

Guenter

> Thank you,
> Claudiu Beznea
> 
> 
> [1]
> https://elixir.bootlin.com/linux/latest/source/drivers/watchdog/Kconfig#L913
> [2]
> https://elixir.bootlin.com/linux/latest/source/arch/arm64/Kconfig.platforms#L273
> [3]
> https://elixir.bootlin.com/linux/latest/source/drivers/soc/renesas/Kconfig#L2
> [4]
> https://elixir.bootlin.com/linux/latest/source/drivers/soc/renesas/Kconfig#L9
> [5]
> https://elixir.bootlin.com/linux/latest/source/drivers/soc/renesas/Kconfig#L45
> [6]
> https://elixir.bootlin.com/linux/latest/source/drivers/soc/renesas/Kconfig#L328
> 
> 
>>
>> Thanks,
>> Guenter
>>
> 


