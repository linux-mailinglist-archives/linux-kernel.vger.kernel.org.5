Return-Path: <linux-kernel+bounces-32401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F225835B3E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0753F1F22500
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 06:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589C3DDB8;
	Mon, 22 Jan 2024 06:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1gy25Je"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CFFC8FD;
	Mon, 22 Jan 2024 06:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705906255; cv=none; b=RRrIGH5yPSjhEGeybR+BbqX8Vj0EH/WcBctwFAYP3AbdHj9m3lmq/Rb+82K6KBYx1PPMGFVshjW8N34NudU7XXlG4q4EeewJCmKT1xnhwbqiHL4fKzt6ObEwiRdKhuMR8t4vMwDoRVNKYclXkdfOoOmTvZiQcWYsJqUCL980JH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705906255; c=relaxed/simple;
	bh=Ht+ghLd9qWXBMuExQZSOUYSlEhQGLmOqr3q1wB2EdGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T0Hg0MsjraGso226Dbk9oI0CzJIMg1EcNvFSBCCUqU+caC1Uvp2XHjnpGJg+7wMojb7CgWKyRhlsj1smk4FDF/S/ydKZvcdymvJkjUJBSkkvsdRtkaLNCUMQ5rMvDeGXtA2Q6u0z+3rfYsUvP4rsSxydSYM2rA2Ii10OUHlXW/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1gy25Je; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cca5d81826so32378061fa.2;
        Sun, 21 Jan 2024 22:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705906252; x=1706511052; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M5fz13Ad4HCdkTb+naupdkUwXzh9ES8pqhqbkx5imjA=;
        b=G1gy25JeM3TkNkwk29oLXU0/bTZPQAOFVF4VkELIU3ZFQteCcLrCn15INr/Bi1oU6N
         gNkEOr7gr9gL/ZFcMEKBBwo2U4AYfWDdzhnLRfMgHU3VzmdDQon9OzC36q6j1F/ap0Qd
         /+ufdmS8ddNIMOWIgHJVB+GJP3A/+h+2Dm3KjjyNwzfqjuC6iwDpjSbdDBY9b7I74zrM
         jIgy/A2DZycnoGVEXaYA7vX2u7UD1CokxzQWK7AWS5GI/4LoSI750CLikj/QnQHf3sRp
         6ZqNQEvE9jy29Lx+0lN4Yshgqo9x8rRBrxNIF83nPzKJZZksmMRcwRDIRW0zxzjgIOpw
         OIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705906252; x=1706511052;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M5fz13Ad4HCdkTb+naupdkUwXzh9ES8pqhqbkx5imjA=;
        b=a+DXAoGaQb/+0hLVW2UPSZB2u7NDDhX3aPllkrI7nt1p114+tBu24x/j0urAnzok3t
         mT2q0hfcVYx4TWcZkSsdYWYkinIpQFqm1EkVeS7a10GmzD25QG42xb6XPVveuxoD9tVj
         +4qCKa1+2UYDA5LF6nyYYcixbB+rKa2busyyW7jxwzu7XPNCVoxdpZDvA62RREHKiHy1
         hrCJa9SOxUD1yrIxu7Wh7okUytGIm+WV7pkuBjmQOSoNutq2uNMNicLiybvT/p2nFMzI
         JYJQo2WcHqlnBzdF9N//CIaR/OegM1wbGx4dykl6VZ+prV19MObiMcTy+dJGEEiVl/pB
         egJQ==
X-Gm-Message-State: AOJu0YwZfqsMXacAj5TR35kHp+nKiM8gksAZc5KNz5VXmHDLqNvf876O
	2CXLQEHejTMA9Vt0lPGTvfIIvns3/Y5vz1j8ucRttK0/Z6efpRpj
X-Google-Smtp-Source: AGHT+IGxWWyo12l8q5kHSWTxtI4fT+UM26hwXK+UFhdyd02E53rTlHz7C1mhx3eAV2YOhkZBeULBbg==
X-Received: by 2002:a2e:3004:0:b0:2cd:7830:5796 with SMTP id w4-20020a2e3004000000b002cd78305796mr1533664ljw.5.1705906251500;
        Sun, 21 Jan 2024 22:50:51 -0800 (PST)
Received: from ?IPV6:2001:14ba:7426:df00::3? (drtxq0yyyyyyyyyyyyybt-3.rev.dnainternet.fi. [2001:14ba:7426:df00::3])
        by smtp.gmail.com with ESMTPSA id m21-20020a2e9115000000b002cd32d4722asm3265769ljg.61.2024.01.21.22.50.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jan 2024 22:50:50 -0800 (PST)
Message-ID: <717b7e70-5cf8-4671-8a6b-005eefd0535e@gmail.com>
Date: Mon, 22 Jan 2024 08:50:44 +0200
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
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <a41ef2c9-bd74-4b0e-afb7-12e198847609@tweaklogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/19/24 13:56, Subhajit Ghosh wrote:
> On 8/1/24 02:52, Jonathan Cameron wrote:
>> On Thu, 4 Jan 2024 11:34:28 +0200
>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>
>>> The loop based 64bit division may run for a long time when dividend is a
>>> lot bigger than the divider. Replace the division loop by the
>>> div64_u64() which implementation may be significantly faster.
>>>
>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>> Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")
>>
>> Hmm. Fix or not perf improvement?  I'm going to take the middle ground
>> and leave the fixes tag, but not rush this in.
>>
>> So applied to the togreg branch of iio.git and for now just pushed out
>> as testing for 0-day etc to take a look before I rebase that tree after
>> rc1.
>>
>>
>>
>>> ---
>>>
>>> I've implemented also a fixup series for supporting rounding of
>>> gains/scales:
>>> https://lore.kernel.org/lkml/37d3aa193e69577353d314e94463a08d488ddd8d.1701780964.git.mazziesaccount@gmail.com/
>>>
>>> That series does also remove the offending loop.
>>>
>>> We don't currently have any in-tree users of GTS helpers which would
>>> need the rounding support so pushing the rounding is not urgent (and I
>>> haven't heard of Subjahit whose driver required the rounding). Hence, we
>>> may want to only take this loop fix in for now (?) and reconsider
>>> rounding when someone need that.
>>>
>>> Jonathan, what's your take on this?
>> Agreed - let us wait for the rounding to have a user, but makes sense
>> to tidy this corner up in the meantime.
>>
>> Thanks,
>>
>> Jonathan
>>
>>>
>>>   drivers/iio/industrialio-gts-helper.c | 5 ++---
>>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/iio/industrialio-gts-helper.c 
>>> b/drivers/iio/industrialio-gts-helper.c
>>> index 7653261d2dc2..abcab2d38589 100644
>>> --- a/drivers/iio/industrialio-gts-helper.c
>>> +++ b/drivers/iio/industrialio-gts-helper.c
>>> @@ -34,7 +34,7 @@
>>>   static int iio_gts_get_gain(const u64 max, const u64 scale)
>>>   {
>>>       u64 full = max;
>>> -    int tmp = 1;
>>> +    int tmp = 0;
>>>       if (scale > full || !scale)
>>>           return -EINVAL;
>>> @@ -48,8 +48,7 @@ static int iio_gts_get_gain(const u64 max, const 
>>> u64 scale)
>>>           tmp++;
>>>       }
>>> -    while (full > scale * (u64)tmp)
>>> -        tmp++;
>>> +    tmp += div64_u64(full, scale);
>>>       return tmp;
>>>   }
>>>
>>> base-commit: 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab
>>
>>
> Hi Matti,
> 
> Your fix works beautifully with the latest version of apds9306 driver 
> which I am working on.
> All available scale values can be set without any errors. Thank you.

Thanks for testing Subhajit! Just to ensure we have no miscommunication 
- did you test just this division fix, or the rounding fix here:
https://lore.kernel.org/lkml/37d3aa193e69577353d314e94463a08d488ddd8d.1701780964.git.mazziesaccount@gmail.com/

> Moving to a new city with a new full time job with the assumption of 
> getting more time
> for my list of opensource projects and contributions proved to be 
> utterly wrong!

Well, I can't blame you :) Being in a new work at new city sounds like 
you have a lot on your plate right now. Give it half a year and things 
will stabilize though :) Oh, and falsely assuming that "when XXX, I will 
have the time to do YYY" - been there done that :)

Good luck on the new work and city!

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


