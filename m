Return-Path: <linux-kernel+bounces-32681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4DC835ED2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C8D61F23596
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0909939FD8;
	Mon, 22 Jan 2024 09:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="M9Ez7rlP"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4A639FC6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 09:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705917510; cv=none; b=cbparoj1nT1zn2wZ2R6JsBpSl7KMBTj9PMgNKvG/LBwsvtfdeUqTptTI9ph76iIqvAvtNNAROGNDr9lWwxoMRvEsf7votr8fGox8IvmpP6eI9hwGN5K/s3V+TIS3w/cKwDlvQcl/gzB2y5YpFYuaenTmV0PQY24yw/OhIPVrv94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705917510; c=relaxed/simple;
	bh=gELjH+KX0/rA4qx7//5Nome4OCqmT9IxOo93luUA218=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i0X3ec+xIwlEhK9e3wlbFMMbLDYifBQOZPSKYpDIudmX98UP/IDvXDxQYexPuFmIWXhVQ02DHirl+9RHr42REUsI8UE1E0SYO/750PmjJNM3PiCaOTA79P0N2R5ebZJboeSPen6hRokGCgLltNMvvI+7K2dgmAOqLBYTOEpzRKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=M9Ez7rlP; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d71e1d7c78so12908935ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 01:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1705917508; x=1706522308; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ar0+/R5zg7/etbhMp1vh5sjI6Zb7oH6GKFRH8tUiMSQ=;
        b=M9Ez7rlPtoHYoxGO3MBzkbopA2rifgQrNPYd2MLnXEUjni/9O9okAdOgeEEXnB1HFC
         teEq/PGnPX7E0CyFM5yZmO4WuxKxNjyhCM5yvu84KXPzIOjJp5yU4R8fdF8smK095V29
         oVQQs/v4VvH1dKcFrB8HzCvtxFTJSLxDjc2kNIMY2SwCqEtMp3QUlrFQPeWcLFcpI3t4
         jvrN/A8dNXsmwQ3M6AoZ5NrOIi3Pg+e8/UY8kpRGSRj+RlEEFSBazRA1j2Zj9hRvVynD
         AsmrgMjrnZQSckVY8hmyAbDxQKO0R6J4mijjs8rPsh1s8VC478U8o4o71ijOAbNJJn19
         ACXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705917508; x=1706522308;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ar0+/R5zg7/etbhMp1vh5sjI6Zb7oH6GKFRH8tUiMSQ=;
        b=t6pjaXvHRy/Yf3BaWuw1g+t9XGn9jrfiy+qYp0/JizpQ2MmF9SF21oXr2NqNd3IVDe
         tFm3aKJOKiEfQvPoYRlk24mSpqKk1jX2S0wF8lw+Z5uEsWsL7U7KoI1RWDJ5sEnxVdeR
         2Hc1QwKZxbUeQtMeDVOl9CqJeU0s77mWz5LtbIZeTHjw7py/b0CuBtyYR3A2YL9TNnSj
         ck98e3vqaOpVKDJBYB2KfTHYv6B0Wt2gd3RRt1TRqmXwPRAJ999lWfKn3PA7kXgj6I7H
         vwA+JWvqrKqCYQZj7WTGavWV5h5Dlqql+UrS4/bu3bD8+eoQMGSd10BunzeBzK6JJmGQ
         5lJQ==
X-Gm-Message-State: AOJu0YyIbpBV7TQPaJ7M+OQqPsiLTn3LftUk3kfbQNw3pP1p5zTXgyjv
	l7nyjR5fo6BGEjBSDf0/zUE4YaMm78M+oQ+rbxY1pegi3SVYiT2aytDMcuehLes=
X-Google-Smtp-Source: AGHT+IHKENnHYqVAboNe6UKYbPrLe/qUracm76Q0elN96Cw/1VSOUCEjcWH3HSRF/EA0sR1/aZNq7g==
X-Received: by 2002:a17:903:2287:b0:1d7:584c:d1e9 with SMTP id b7-20020a170903228700b001d7584cd1e9mr553307plh.73.1705917507748;
        Mon, 22 Jan 2024 01:58:27 -0800 (PST)
Received: from [192.168.20.11] ([180.150.112.156])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902f7c400b001d70953f166sm6591501plw.155.2024.01.22.01.58.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 01:58:27 -0800 (PST)
Message-ID: <3742308c-d063-4179-a4cb-80db021ede46@tweaklogic.com>
Date: Mon, 22 Jan 2024 20:28:22 +1030
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: gts-helper: Fix division loop
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <ZZZ7pJBGkTdFFqiY@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
 <20240107162253.66c1f0f1@jic23-huawei>
 <a41ef2c9-bd74-4b0e-afb7-12e198847609@tweaklogic.com>
 <717b7e70-5cf8-4671-8a6b-005eefd0535e@gmail.com>
Content-Language: en-US
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <717b7e70-5cf8-4671-8a6b-005eefd0535e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/1/24 17:20, Matti Vaittinen wrote:
> On 1/19/24 13:56, Subhajit Ghosh wrote:
>> On 8/1/24 02:52, Jonathan Cameron wrote:
>>> On Thu, 4 Jan 2024 11:34:28 +0200
>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>>
>>>> The loop based 64bit division may run for a long time when dividend is a
>>>> lot bigger than the divider. Replace the division loop by the
>>>> div64_u64() which implementation may be significantly faster.
>>>>
>>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>>> Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")
>>>
>>> Hmm. Fix or not perf improvement?  I'm going to take the middle ground
>>> and leave the fixes tag, but not rush this in.
>>>
>>> So applied to the togreg branch of iio.git and for now just pushed out
>>> as testing for 0-day etc to take a look before I rebase that tree after
>>> rc1.
>>>
>>>
>>>
>>>> ---
>>>>
>>>> I've implemented also a fixup series for supporting rounding of
>>>> gains/scales:
>>>> https://lore.kernel.org/lkml/37d3aa193e69577353d314e94463a08d488ddd8d.1701780964.git.mazziesaccount@gmail.com/
>>>>
>>>> That series does also remove the offending loop.
>>>>
>>>> We don't currently have any in-tree users of GTS helpers which would
>>>> need the rounding support so pushing the rounding is not urgent (and I
>>>> haven't heard of Subjahit whose driver required the rounding). Hence, we
>>>> may want to only take this loop fix in for now (?) and reconsider
>>>> rounding when someone need that.
>>>>
>>>> Jonathan, what's your take on this?
>>> Agreed - let us wait for the rounding to have a user, but makes sense
>>> to tidy this corner up in the meantime.
>>>
>>> Thanks,
>>>
>>> Jonathan
>>>
>>>>
>>>>   drivers/iio/industrialio-gts-helper.c | 5 ++---
>>>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
>>>> index 7653261d2dc2..abcab2d38589 100644
>>>> --- a/drivers/iio/industrialio-gts-helper.c
>>>> +++ b/drivers/iio/industrialio-gts-helper.c
>>>> @@ -34,7 +34,7 @@
>>>>   static int iio_gts_get_gain(const u64 max, const u64 scale)
>>>>   {
>>>>       u64 full = max;
>>>> -    int tmp = 1;
>>>> +    int tmp = 0;
>>>>       if (scale > full || !scale)
>>>>           return -EINVAL;
>>>> @@ -48,8 +48,7 @@ static int iio_gts_get_gain(const u64 max, const u64 scale)
>>>>           tmp++;
>>>>       }
>>>> -    while (full > scale * (u64)tmp)
>>>> -        tmp++;
>>>> +    tmp += div64_u64(full, scale);
>>>>       return tmp;
>>>>   }
>>>>
>>>> base-commit: 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab
>>>
>>>
>> Hi Matti,
>>
>> Your fix works beautifully with the latest version of apds9306 driver which I am working on.
>> All available scale values can be set without any errors. Thank you.
> 
> Thanks for testing Subhajit! Just to ensure we have no miscommunication - did you test just this division fix, or the rounding fix here:
> https://lore.kernel.org/lkml/37d3aa193e69577353d314e94463a08d488ddd8d.1701780964.git.mazziesaccount@gmail.com/
You are most welcome. I did not check the above rounding fix pointed out by the link. I will be happy to check it and let you know by the end of this month.
I checked this division fix.

> 
>> Moving to a new city with a new full time job with the assumption of getting more time
>> for my list of opensource projects and contributions proved to be utterly wrong!
> 
> Well, I can't blame you :) Being in a new work at new city sounds like you have a lot on your plate right now. Give it half a year and things will stabilize though :) Oh, and falsely assuming that "when XXX, I will have the time to do YYY" - been there done that :)
> 
> Good luck on the new work and city!
Thank you Matti.
> 
> Yours,
>      -- Matti
> 
Regards,
Subhajit Ghosh

