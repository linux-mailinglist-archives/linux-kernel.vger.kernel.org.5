Return-Path: <linux-kernel+bounces-138712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 571B589F94E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75E321F27CCC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4593A16D309;
	Wed, 10 Apr 2024 14:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="VpaKm0LO"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60B715F405
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757712; cv=none; b=Vu0ZAmDuAWmXrpS8ZyKD6HPQAi/aINPFp6K/d7fvXltEjPDSpwjs1D1Mv6j6iRO/Zg206MkmA84Goykfp96VO4EuZSfEc4z1Kh9WxJppW0gwtCy8dJQZkR4te5y5qmJjpwF4qgbkd8Ya/kmDl8VvxBP0P4/HL+YqU6DVN+b1gyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757712; c=relaxed/simple;
	bh=e88gyjeUImIcsIbCAmREhMKck+xNyVFvJ6Y/vXAlET0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=agPZrdDbZuxFvGt4M5ZGxL2u1AKCW6232Pg6zcETyCbN5RzLBJ9kweHLw6SH5LhShgYhooGsSIludQe1AlCaqimtSmrLXvGvWWITcR4LyaEfWPXvWl/z+DX6Bv69tiTsyeNr9eca8l+NK5IbL9WwBOeRozsR1eRynUbFaHTXNBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=VpaKm0LO; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56c404da0ebso10058232a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 07:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1712757709; x=1713362509; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C7lFcOC7l3g9TVCaL+oCyT/3qdUrXzLc4rgBkKi4hh0=;
        b=VpaKm0LO2slDiGcOQK/eS9Gx4RBNa5Xpq7bwK/oa/MWvUXvDO5IP8AObfWBNY0X0Ja
         3VpZqjXKP468oYscSPoc+PGUYRvngyoLKoU6hXssGVwZHzAGqcXsGv+kE1OH3wOaguP3
         ODUoEIbZIjIhoF5cQtbe4AXUZKasrR4lu0JoYBnwyNv4+UL1MqEZjfj+xFdiOdyR73jK
         rb8TbQc8kPCLwxX8KMJ7UbC4rBF0BP8Md3kLVSs8unMUEfmu/EpKRXRU3S3ndQcPEYA8
         H+fUvQOHcUve6aXdvWKj4O/Nwx0YCR1c7whK6bLjp+DjXOAPrfn3M65JTsTS95Lj352L
         Dquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712757709; x=1713362509;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C7lFcOC7l3g9TVCaL+oCyT/3qdUrXzLc4rgBkKi4hh0=;
        b=GIe9FDUcAHYzT5yRA/FWD16u0Y90eJYVHcyzqfBuwFcDFRfJikIxAB1+oqkb2BQY4b
         3nSBNBXhMpU4w11yIDZtiEiS067MIiomTjFqNKevdPV9SYIXo3yn6PqTdKgpCPNtHD6d
         gHGGSfoohrhpR5PXMTuII9xyxvd/rY8hNczu8oy8PPLn+ym3JdAFIHlL0wCYanQwX5uO
         e+XUo5VQSR+X00mqoX6Ir8B+/Q7WSPhCqFGHa6Eg6BLaM55JbdODF2yHkOGufFixTT/X
         803cnFOiaQxs8GqYtLNe3fZ+drYnuJk6BgGNaMWR+VYc+P5aj0MTYXO+BQu7gjvPDpso
         AVjg==
X-Forwarded-Encrypted: i=1; AJvYcCUJRqMP1uT0BReo2ieZHzlxpVXe83AQRNzSe3GV2NZiVTT+r+JKeHynhYP7l5faNA/OIPeE88vPbJEFlZVjspQwwtSw6mCoswYfMJEt
X-Gm-Message-State: AOJu0YzUiIaGuyhH98j2N7A+pe/7XwhPtTNn6QlR43K+wYb7Ehw4Nwe1
	l00r145h7CLnEWmLTgN2iEavV4eu9RvCBJRbggDPE96SS/q9knozyB9qT0QbvBY=
X-Google-Smtp-Source: AGHT+IEWCICihxTK465pYa3JGEG4kSjfnaoh1QVBzAZnHSiEGwF/hNWWILbv56rVqPOCFLNkPNUg0A==
X-Received: by 2002:a50:8d16:0:b0:56e:743:d4d9 with SMTP id s22-20020a508d16000000b0056e0743d4d9mr1748489eds.42.1712757707092;
        Wed, 10 Apr 2024 07:01:47 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.8])
        by smtp.gmail.com with ESMTPSA id de26-20020a056402309a00b0056c1cca33bfsm6405937edb.6.2024.04.10.07.01.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 07:01:46 -0700 (PDT)
Message-ID: <11a371b5-f649-4dfb-94d1-9a01b15d5993@tuxon.dev>
Date: Wed, 10 Apr 2024 17:01:44 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v8 03/10] watchdog: rzg2l_wdt: Use
 pm_runtime_resume_and_get()
Content-Language: en-US
To: Biju Das <biju.das.jz@bp.renesas.com>,
 "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
 "linux@roeck-us.net" <linux@roeck-us.net>, "robh@kernel.org"
 <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "geert+renesas@glider.be" <geert+renesas@glider.be>,
 "magnus.damm@gmail.com" <magnus.damm@gmail.com>
Cc: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240410134044.2138310-1-claudiu.beznea.uj@bp.renesas.com>
 <20240410134044.2138310-4-claudiu.beznea.uj@bp.renesas.com>
 <OSAPR01MB15874891F67AAFAA955A186886062@OSAPR01MB1587.jpnprd01.prod.outlook.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <OSAPR01MB15874891F67AAFAA955A186886062@OSAPR01MB1587.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10.04.2024 16:51, Biju Das wrote:
> Hi Claudiu,
> 
>> -----Original Message-----
>> From: Claudiu <claudiu.beznea@tuxon.dev>
>> Sent: Wednesday, April 10, 2024 2:41 PM
>> Subject: [PATCH RESEND v8 03/10] watchdog: rzg2l_wdt: Use pm_runtime_resume_and_get()
>>
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> pm_runtime_get_sync() may return with error. In case it returns with error
>> dev->power.usage_count needs to be decremented.
>> dev->pm_runtime_resume_and_get()
>> takes care of this. Thus use it.
>>
>> Along with it the rzg2l_wdt_set_timeout() function was updated to propagate the result of
>> rzg2l_wdt_start() to its caller.
>>
>> Fixes: 2cbc5cd0b55f ("watchdog: Add Watchdog Timer driver for RZ/G2L")
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>
>> Changes in v8:
>> - none
>>
>> Changes in v7:
>> - none
>>
>> Changes in v6:
>> - none
>>
>> Changes in v5:
>> - none
>>
>> Changes in v4:
>> - none
>>
>> Changes in v3:
>> - none
>>
>> Changes in v2:
>> - propagate the return code of rzg2l_wdt_start() to it's callers
>>
>>
>>  drivers/watchdog/rzg2l_wdt.c | 11 ++++++++---
>>  1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c index
>> 1741f98ca67c..d87d4f50180c 100644
>> --- a/drivers/watchdog/rzg2l_wdt.c
>> +++ b/drivers/watchdog/rzg2l_wdt.c
>> @@ -123,8 +123,11 @@ static void rzg2l_wdt_init_timeout(struct watchdog_device *wdev)  static int
>> rzg2l_wdt_start(struct watchdog_device *wdev)  {
>>  	struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
>> +	int ret;
>>
>> -	pm_runtime_get_sync(wdev->parent);
>> +	ret = pm_runtime_resume_and_get(wdev->parent);
>> +	if (ret)
>> +		return ret;
>>
>>  	/* Initialize time out */
>>  	rzg2l_wdt_init_timeout(wdev);
>> @@ -150,6 +153,8 @@ static int rzg2l_wdt_stop(struct watchdog_device *wdev)
>>
>>  static int rzg2l_wdt_set_timeout(struct watchdog_device *wdev, unsigned int timeout)  {
>> +	int ret = 0;
>> +
>>  	wdev->timeout = timeout;
>>
>>  	/*
>> @@ -159,10 +164,10 @@ static int rzg2l_wdt_set_timeout(struct watchdog_device *wdev, unsigned int
>> time
>>  	 */
>>  	if (watchdog_active(wdev)) {
>>  		rzg2l_wdt_stop(wdev);
>> -		rzg2l_wdt_start(wdev);
>> +		ret = rzg2l_wdt_start(wdev);
> 
> This IP won't be able to update WDT settings once you have set it.
> 
> But we can update it, if we do a reset assert followed by deassert.
> So the previous code looks correct to me.
> 
> Current case is if the WDT is active, then start it. Maybe I ma missing something here.
> 

I'm not sure I got you correctly.

This patch keeps the previous functionality, thus, if the watchdog is
active rzg2l_wdt_stop() is called which does a reset assert. Then
rzg2l_wdt_start() is called which does the reset deassert.

Thank you,
Claudiu Beznea

> Cheers,
> Biju
> 
>>  	}
>>
>> -	return 0;
>> +	return ret;
>>  }
>>
>>  static int rzg2l_wdt_restart(struct watchdog_device *wdev,
>> --
>> 2.39.2
> 

