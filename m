Return-Path: <linux-kernel+bounces-52284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBE5849644
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CFFC287DC7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35593125C3;
	Mon,  5 Feb 2024 09:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrI1El+p"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03A912B6C;
	Mon,  5 Feb 2024 09:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707124805; cv=none; b=FXMu7LsTEG5xkhwhUBPA4T9OuIeD829k3HF8uQ5HDFkt6u48U90QMuisJTljUpREwTwF+aTdb3y/6aMkEfQ2WyGen3ERkDlDGYeOd3a0RFlHJIIs8c7IjVzcUCeSLob7Nwhm0vaDZb4mqdkvnrPAzrjTsc4IvQRDZ+PDDuCFafI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707124805; c=relaxed/simple;
	bh=7G/LwQHB+H/dtDcXo5J1dNkKRi1QoZ4/FA+8K+lRS1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fYAGrZTCtp2hBu1/iHm973Q8ef+gvSYSzG6df6rDtGiHdpGbzmvPjxKSCxc3lxq+kHEf9tDGse3FonNv2SaWi4H43HM+mp4KI18lki+x9kp5nqpuTCyPXkNLEe4QlIBjQMEpAL5j+ednz4CeRIZVmCxXjRtrX7fio6GR9rEjbsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UrI1El+p; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51124d86022so6472000e87.0;
        Mon, 05 Feb 2024 01:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707124801; x=1707729601; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ovCKa14mXXnXBptabaXZWHdPntUw31KtAWi3cyavIqs=;
        b=UrI1El+pg9AlMs2XVBrVnvZ2iZO8r+llGHU061+goJL4KOxaaD5itvLK+kpDHzc0Na
         5CcY7zKEsLRz/M1lGXn5utbV6PgmmyQTEzxq6arXN2k5NnGk24mx7DtZoNzOMYB9kEwT
         GgrpjY1HPaW0s5EMG9eGViN/7pw8jsZvJ/qMVlKf0cjlCsW3dy/6/ykdso5nHd/xM3fQ
         /Tw4jnJlQ6fHR1oWoD49fsCaqcTYrP6RAl3jQdDoxa9xwsoKIu3p/TzLvhQPSmVeczmS
         H5Do3KGFfE8SM2lX6LjPybsNJ/pJYABWERHrUGWVCv48bq43MBcsR2wjEpctYVh9IrCh
         IFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707124801; x=1707729601;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ovCKa14mXXnXBptabaXZWHdPntUw31KtAWi3cyavIqs=;
        b=XyEn5xuBx9lcOvu6hr/kBwQjdQHKlboyWTD5pJ+X2PpKkyRV8VF9abzMv8p3x3h+vy
         6lE1nHU6lbrlEWx0F4duucKXZ0UDr2/+WpVQZkzVR4HMAKdaH3wIEIZxymBohxX+1Ms0
         MPu7/GNrekKRRvZNbQTIYnOx7tLL+x4uGD6S22Qshf9SLKIfhJOsSF495KS0SX46gfoW
         BlWOTAsqvJbUCpE7TgAEyiR86TPoY879tLTfAFBrKloSulePI21b53Sps+LX6u9Y6X7f
         w4ySjheHU/mUp29cMy19XzrxIgD6VUnNYCmHfSE+1IqkqOXiLYGT3ARE8ow23l5c6lHm
         ++7A==
X-Gm-Message-State: AOJu0Yz/Ob4iEb4rX6xax4leWgOb4wQTOprksMJzVsrX+Kl8G5cZDKhZ
	9rik64WJMulurwBnnNhoWZU9J75twgLh9Gu7VVMs/RUhQA/MPx+J
X-Google-Smtp-Source: AGHT+IH7AnZ0prCJ4Wc4GdFScYM97POT/NCpkJ+WL/GDdXDMcUwsMHIeOk9Pt+FJgiQWEd4ZFJuy3A==
X-Received: by 2002:a05:6512:ad3:b0:511:4e29:f807 with SMTP id n19-20020a0565120ad300b005114e29f807mr2187231lfu.1.1707124801295;
        Mon, 05 Feb 2024 01:20:01 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVfViq9Z9CMEsy7ICNMO2FNDsBScPdRsOVp7+HMxwyAnd/1dorwrJiG/59vA3ECEzFTfOp61GkDRhOwAapjJSyL7wrgGxBMeCZpCOqAnt5clTE28MSv67gqfQ3uj8FfvYy6opmguG0KUHwkKWrzElI6O6s2f19RXTltC6EFL7W/o9VTsiPoZsgpXMM=
Received: from ?IPV6:2001:14ba:7426:df00::1? (drtxq0yyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:7426:df00::1])
        by smtp.gmail.com with ESMTPSA id n9-20020a05651203e900b005113c74fff9sm880547lfq.62.2024.02.05.01.20.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 01:20:00 -0800 (PST)
Message-ID: <ec54fd85-f326-4162-aa28-1dcf54be0e4f@gmail.com>
Date: Mon, 5 Feb 2024 11:19:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: gts-helper: Fix division loop
To: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <ZZZ7pJBGkTdFFqiY@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
 <20240107162253.66c1f0f1@jic23-huawei>
 <a41ef2c9-bd74-4b0e-afb7-12e198847609@tweaklogic.com>
 <717b7e70-5cf8-4671-8a6b-005eefd0535e@gmail.com>
 <3742308c-d063-4179-a4cb-80db021ede46@tweaklogic.com>
 <9f94a3de-7f04-4ad8-9b98-9e6312cce589@tweaklogic.com>
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <9f94a3de-7f04-4ad8-9b98-9e6312cce589@tweaklogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/4/24 15:49, Subhajit Ghosh wrote:
> Hi Matti,
>>>>>>   drivers/iio/industrialio-gts-helper.c | 5 ++---
>>>>>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/iio/industrialio-gts-helper.c 
>>>>>> b/drivers/iio/industrialio-gts-helper.c
>>>>>> index 7653261d2dc2..abcab2d38589 100644
>>>>>> --- a/drivers/iio/industrialio-gts-helper.c
>>>>>> +++ b/drivers/iio/industrialio-gts-helper.c
>>>>>> @@ -34,7 +34,7 @@
>>>>>>   static int iio_gts_get_gain(const u64 max, const u64 scale)
>>>>>>   {
>>>>>>       u64 full = max;
>>>>>> -    int tmp = 1;
>>>>>> +    int tmp = 0;
>>>>>>       if (scale > full || !scale)
>>>>>>           return -EINVAL;
>>>>>> @@ -48,8 +48,7 @@ static int iio_gts_get_gain(const u64 max, const 
>>>>>> u64 scale)
>>>>>>           tmp++;
>>>>>>       }
>>>>>> -    while (full > scale * (u64)tmp)
>>>>>> -        tmp++;
>>>>>> +    tmp += div64_u64(full, scale);
>>>>>>       return tmp;
>>>>>>   }
>>>>>>
>>>>>> base-commit: 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab
>>>>>
>>>>>
>>>> Hi Matti,
>>>>
>>>> Your fix works beautifully with the latest version of apds9306 
>>>> driver which I am working on.
>>>> All available scale values can be set without any errors. Thank you.
>>>
>>> Thanks for testing Subhajit! Just to ensure we have no 
>>> miscommunication - did you test just this division fix, or the 
>>> rounding fix here:
>>> https://lore.kernel.org/lkml/37d3aa193e69577353d314e94463a08d488ddd8d.1701780964.git.mazziesaccount@gmail.com/
>> You are most welcome. I did not check the above rounding fix pointed 
>> out by the link. I will be happy to check it and let you know by the 
>> end of this month.
>> I checked this division fix.
> I tested the patch in the above link with adps9306 driver which I am 
> working on and it seems to work well without any issues.

Great! Thanks a lot Subhajit! Your testing is very much appreciated :)

I think you sent another version of your APDS9306 driver. AFAIR, this 
driver could have benefited from the above rounding fix. I will see if I 
find the time and energy to see if I can dive into this again and 
re-spin this rounding fix. No promises but I'll try :)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


