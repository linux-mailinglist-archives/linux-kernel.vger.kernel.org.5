Return-Path: <linux-kernel+bounces-51681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78888848E33
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06C171F21A20
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934D5225A9;
	Sun,  4 Feb 2024 13:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="KOG0LEdg"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3F922606
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 13:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707054571; cv=none; b=LIybdSz7GkfjVmayWtOQi5xUMMKnXlnLUY9qERMKytS03hQrx8G5BraOlOHG/aLd9n71/0z72B8U2q5ZZBEcxxEsv5RihXUAzJipcqIxhq7uefyhAmjFGE7R7RoBO9F61vKxaCN3PLjwr2sEI5vX4mT5BvtRYBj48IgcHDorxRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707054571; c=relaxed/simple;
	bh=DRjmmIS9cSTb7KVKTddvq0AK3KmXbEry8tF9wDr9F8g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=aB9PvvortA9s543Kqg/3XRE0NVZfrrbi5ZLVpn99X+OoZJ7VbHRxtaJu8JLLd5ME88bIUXvl3UZFEJE5DrNeMJQGS0fN3Z0sv76QKnF9+FmMXjHPO3+bE5SLXRE8JgS96knFnQKaFZwi3YhbRSARbllOeJbN83em8S+uNDUGLlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=KOG0LEdg; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d9b2400910so560235ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 05:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1707054568; x=1707659368; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DRjmmIS9cSTb7KVKTddvq0AK3KmXbEry8tF9wDr9F8g=;
        b=KOG0LEdguqiIwe5o9AikfZBAqiewBBhTYL7pTZAoSVsGO3vca4jjYYccbNeALl8lqL
         v77pHZabfNug5DedW3xubi6YHgF6bHuG0KHFNgleGtp0Lvt/lxEW9brCvp487ABC8rds
         I7/jemwkFJQHAIDuQZpFl08q9nikV5HLIb+WyyeQHppEd4C/Bow90tt4PBUA27DsEhPU
         ukzvQtKZlQtjd7WuC+PgPMM6vLeh5vBSJ2fZMqvpLvA5Egcz6hOGyeCi/KfTqD6sv1rS
         MACqKZHiouaYTX79bfdE79q7ndlY4mzZG5vbrfFi6Mgo+uVzzu5VASWdn62tHJNOwtCp
         YEDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707054568; x=1707659368;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DRjmmIS9cSTb7KVKTddvq0AK3KmXbEry8tF9wDr9F8g=;
        b=RyXnh16UJ0I20EO5R2pcra0Xn8NJwSGpUedNYHBl9hUcTUmveX3ayK2GhKEvKaYoKh
         oTlo2bLPS7cKiTinBnLu7BsrnV7oxxZEAaKNMGffDQi/MF97NheEjQl1uWEyXIq4LBvT
         1KAZn4Qw0xFqdNJKJodLe3kVLifA9cRT2faoJHL3Zdu86FwYZ6JVTHdKY8MnU5liIgtc
         C3VbDr4+uUMpd00qSZhsMS/WU50LGeg2DnX/A9vvkNihmBOzcIsxn4GY27cQkt5+KlEh
         BC1iz06S7fm1nd0DC6NuloDU3NjK5wDog3t+Ozb1tXkzYwdlDJ/8maCJlsgZRUeJovb4
         7omQ==
X-Gm-Message-State: AOJu0YyGVt8hy61+PN67mWMXEkAHlhzmin6UzMLMEfJGF3TzJGqrZNUO
	cx1PgRNCZBb7gq4b7Nj30zzJBAOxzb5S8vrPxXbJBRf/pmGQUHYRgYdUmoLV6NA=
X-Google-Smtp-Source: AGHT+IHLEptOVFKMIX5GtWVWnVG92zR6eNJWaRfVs/d+UuI7of6DvQ/4iRmvqxtFxcb9EbJWDFjExw==
X-Received: by 2002:a17:902:ceca:b0:1d9:ae31:83f1 with SMTP id d10-20020a170902ceca00b001d9ae3183f1mr851473plg.18.1707054567656;
        Sun, 04 Feb 2024 05:49:27 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVO0Q3c+4wj8MFfmDAAwgW8pWg9wooi7XUxOniryudNEMlFE3jXm4XhySIp8NJphGz8wwBE64I+SJDp/TDYDmQ7N6kyu1q4nMdCgbdaLJTQBVpzVfxjMUbTSZzn/Y42GRdqXY/B7sHbfqQFs89P+j8E8U4WoHmxFWxz+hvU0vktKoHkSYR8kr830Is=
Received: from [192.168.20.11] ([180.150.112.156])
        by smtp.gmail.com with ESMTPSA id q23-20020a170902edd700b001d71ef6afe0sm4610503plk.103.2024.02.04.05.49.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Feb 2024 05:49:27 -0800 (PST)
Message-ID: <9f94a3de-7f04-4ad8-9b98-9e6312cce589@tweaklogic.com>
Date: Mon, 5 Feb 2024 00:19:14 +1030
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: gts-helper: Fix division loop
Content-Language: en-US
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <ZZZ7pJBGkTdFFqiY@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
 <20240107162253.66c1f0f1@jic23-huawei>
 <a41ef2c9-bd74-4b0e-afb7-12e198847609@tweaklogic.com>
 <717b7e70-5cf8-4671-8a6b-005eefd0535e@gmail.com>
 <3742308c-d063-4179-a4cb-80db021ede46@tweaklogic.com>
In-Reply-To: <3742308c-d063-4179-a4cb-80db021ede46@tweaklogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Matti,
>>>>>   drivers/iio/industrialio-gts-helper.c | 5 ++---
>>>>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
>>>>> index 7653261d2dc2..abcab2d38589 100644
>>>>> --- a/drivers/iio/industrialio-gts-helper.c
>>>>> +++ b/drivers/iio/industrialio-gts-helper.c
>>>>> @@ -34,7 +34,7 @@
>>>>>   static int iio_gts_get_gain(const u64 max, const u64 scale)
>>>>>   {
>>>>>       u64 full = max;
>>>>> -    int tmp = 1;
>>>>> +    int tmp = 0;
>>>>>       if (scale > full || !scale)
>>>>>           return -EINVAL;
>>>>> @@ -48,8 +48,7 @@ static int iio_gts_get_gain(const u64 max, const u64 scale)
>>>>>           tmp++;
>>>>>       }
>>>>> -    while (full > scale * (u64)tmp)
>>>>> -        tmp++;
>>>>> +    tmp += div64_u64(full, scale);
>>>>>       return tmp;
>>>>>   }
>>>>>
>>>>> base-commit: 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab
>>>>
>>>>
>>> Hi Matti,
>>>
>>> Your fix works beautifully with the latest version of apds9306 driver which I am working on.
>>> All available scale values can be set without any errors. Thank you.
>>
>> Thanks for testing Subhajit! Just to ensure we have no miscommunication - did you test just this division fix, or the rounding fix here:
>> https://lore.kernel.org/lkml/37d3aa193e69577353d314e94463a08d488ddd8d.1701780964.git.mazziesaccount@gmail.com/
> You are most welcome. I did not check the above rounding fix pointed out by the link. I will be happy to check it and let you know by the end of this month.
> I checked this division fix.
I tested the patch in the above link with adps9306 driver which I am working on and it seems to work well without any issues.

Regards,
Subhajit Ghosh


