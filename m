Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649E97FB9BF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 12:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344612AbjK1L44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 06:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344569AbjK1L4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 06:56:55 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D0C94;
        Tue, 28 Nov 2023 03:57:00 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50bbd9cf923so483745e87.1;
        Tue, 28 Nov 2023 03:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701172619; x=1701777419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zpP02LYqj14oZTHZilHtJSOBxsPPRRjqKrdzV+LYYCc=;
        b=dBl+v7ASlJlSgV+aGlOWVGkKWKDEi+yr96s+/EO95c9uB7h/d9nPH648f5chBUj+LW
         Ee4knOALxpmPigtrMql4jVMTtbmJ83Z3BS0QLqJS9xKJCKVlHyqs8cehmtqYfFzlUEnK
         Kykxl3UD7IDBw2mzgu76dwCKJ9F1I+vf5xtcORPPOawqqM5LV0fdzOe/GO/t0Tzh2iMc
         8yFwIEL6XArhdlOEyfggX2rZHEv572Mte6JlcHM2M/MeizLjbrNxVr+yD/GIxipsvQs3
         c8FhGyWhrKF5zzYPUuzq2rH+b3RJGt5gGlL9yTc4iCoey8N8h/RfNbVWn7b2t/44IzNh
         tU1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701172619; x=1701777419;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zpP02LYqj14oZTHZilHtJSOBxsPPRRjqKrdzV+LYYCc=;
        b=KokQILhVPbsc1LACGg51Zb8l0LnOsT3R+UwmliNiCWtu5HEcSWmJbL55abtp72hOEN
         13+dNX5A0ofRM9GrjzCnpxPwExcubF3y+oTiE1gsXnIE1oHTMJ8kssnDmPg9YicxVn3T
         iT8+6JrFfsBtp2rPOQ+mAilxDSIEVZLo0bdslEzUW5Vyet0bK48blDXy0sJc3t13Udwk
         XMqa5fIUjykv3RhKAbdLg8LF2WXuJNig3PBT5Jjqs39Mjt6YGXnTMnZm+eJHQBozjHaY
         owdNdG5o0go4k8PF+7aa33F5OGC0Akp4vdGGfcCRoLOHA9HqOXRygPossCEGTtBfKzTP
         mVVA==
X-Gm-Message-State: AOJu0Yx62ZV1NBqEiN80oPoOuONC/fBQ/hW88U/kIwXqINw/EkdKupCt
        aEkgIR4HOX+6o7A/brDH58g=
X-Google-Smtp-Source: AGHT+IHiwkfhyY0N4x0mkv2b7U5SzU/Yw7nwfrygid5pSd+ZBCMI1JYgpfv9A0NkPbooGUBuRiGwnA==
X-Received: by 2002:a05:6512:280c:b0:503:3808:389a with SMTP id cf12-20020a056512280c00b005033808389amr13592502lfb.11.1701172618964;
        Tue, 28 Nov 2023 03:56:58 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f8:1500::2? (dc78bmyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::2])
        by smtp.gmail.com with ESMTPSA id p17-20020a056512329100b005032ebff21asm28709lfe.279.2023.11.28.03.56.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 03:56:57 -0800 (PST)
Message-ID: <1fe658cd-bdd5-4afd-8564-d0dcf9eab4ab@gmail.com>
Date:   Tue, 28 Nov 2023 13:56:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: gts-helpers: Round gains and scales
Content-Language: en-US, en-GB
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ZUDN9n8iXoNwzifQ@dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi>
 <20231126172607.379c9d79@jic23-huawei>
 <8934d9ec-e969-4662-b220-9fb1cbeca7b2@gmail.com>
In-Reply-To: <8934d9ec-e969-4662-b220-9fb1cbeca7b2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/23 09:48, Matti Vaittinen wrote:
> On 11/26/23 19:26, Jonathan Cameron wrote:
>> On Tue, 31 Oct 2023 11:50:46 +0200
>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>
>>> The GTS helpers do flooring of scale when calculating available scales.
>>> This results available-scales to be reported smaller than they should
>>> when the division in scale computation resulted remainder greater than
>>> half of the divider. (decimal part of result > 0.5)
>>>
>>> Furthermore, when gains are computed based on scale, the gain resulting
>>> from the scale computation is also floored. As a consequence the
>>> floored scales reported by available scales may not match the gains that
>>> can be set.
>>>
>>> The related discussion can be found from:
>>> https://lore.kernel.org/all/84d7c283-e8e5-4c98-835c-fe3f6ff94f4b@gmail.com/
>>>
>>> Do rounding when computing scales and gains.
>>>
>>> Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")
>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> Hi Matti,
>>
>> A few questions inline about the maths.
> 
> I appreciate the questions :) Thanks!
>>
>>>
>>> ---
>>> Subjahit, is there any chance you test this patch with your driver? Can
>>> you drop the:
>>>     if (val2 % 10)
>>>         val2 += 1;
>>> from scale setting and do you see written and read scales matching?
>>>
>>> I did run a few Kunit tests on this change - but I'm still a bit jumpy
>>> on it... Reviewing/testing is highly appreciated!
>>>
>>> Just in case someone is interested in seeing the Kunit tests, they're
>>> somewhat unpolished & crude and can emit noisy debug prints - but can
>>> anyways be found from:
>>> https://github.com/M-Vaittinen/linux/commits/iio-gts-helpers-test-v6.6
>>>
>>> ---
>>>   drivers/iio/industrialio-gts-helper.c | 58 +++++++++++++++++++++++----
>>>   1 file changed, 50 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/iio/industrialio-gts-helper.c 
>>> b/drivers/iio/industrialio-gts-helper.c
>>> index 7653261d2dc2..7dc144ac10c8 100644
>>> --- a/drivers/iio/industrialio-gts-helper.c
>>> +++ b/drivers/iio/industrialio-gts-helper.c
>>> @@ -18,6 +18,32 @@
>>>   #include <linux/iio/iio-gts-helper.h>
>>>   #include <linux/iio/types.h>
>>> +static int iio_gts_get_gain_32(u64 full, unsigned int scale)
>>> +{
>>> +    unsigned int full32 = (unsigned int) full;
>>> +    unsigned int rem;
>>> +    int result;
>>> +
>>> +    if (full == (u64)full32) {
>>> +        unsigned int rem;
>>> +
>>> +        result = full32 / scale;
>>> +        rem = full32 - scale * result;
>>> +        if (rem >= scale / 2)
>>> +            result++;
>>> +
>>> +        return result;
>>> +    }
>>> +
>>> +    rem = do_div(full, scale);
>>
>> As below, can we just add scale/2 to full in the do_div?
> 
> The rationale for doing is it in this way is to prevent (theoretical?) 
> overflow when adding scale/2 to full. Maybe this warrants adding a comment?
> 
>>
>>> +    if ((u64)rem >= scale / 2)
>>> +        result = full + 1;
>>> +    else
>>> +        result = full;
>>> +
>>> +    return result;
>>> +}
>>> +
>>>   /**
>>>    * iio_gts_get_gain - Convert scale to total gain
>>>    *
>>> @@ -28,30 +54,42 @@
>>>    *        scale is 64 100 000 000.
>>>    * @scale:    Linearized scale to compute the gain for.
>>>    *
>>> - * Return:    (floored) gain corresponding to the scale. -EINVAL if 
>>> scale
>>> + * Return:    (rounded) gain corresponding to the scale. -EINVAL if 
>>> scale
>>>    *        is invalid.
>>>    */
>>>   static int iio_gts_get_gain(const u64 max, const u64 scale)
>>>   {
>>> -    u64 full = max;
>>> +    u64 full = max, half_div;
>>> +    unsigned int scale32 = (unsigned int) scale;
>>>       int tmp = 1;
>>> -    if (scale > full || !scale)
>>> +    if (scale / 2 > full || !scale)
>>
>> Seems odd. Why are we checking scale / 2 here?
> 
> I am pretty sure I have been thinking of rounding 0.5 to 1.
> 
>>
>>>           return -EINVAL;
>>> +    /*
>>> +     * The loop-based implementation below will potentially run _long_
>>> +     * if we have a small scale and large 'max' - which may be 
>>> needed when
>>> +     * GTS is used for channels returning specific units. Luckily we 
>>> can
>>> +     * avoid the loop when scale is small and fits in 32 bits.
>>> +     */
>>> +    if ((u64)scale32 == scale)
>>> +        return iio_gts_get_gain_32(full, scale32);
>>> +
>>>       if (U64_MAX - full < scale) {
>>>           /* Risk of overflow */
>>> -        if (full - scale < scale)
>>> +        if (full - scale / 2 < scale)
>>>               return 1;
>>>           full -= scale;
>>>           tmp++;
>>>       }
>>> -    while (full > scale * (u64)tmp)
>>> +    half_div = scale >> 2;
>>
>> Why divide by 4?  Looks like classic issue with using shifts for division
>> causing confusion.
> 
> Yes. Looks like a brainfart to me. I need to fire-up my tests and revise 
> this (and the check you asked about above). It seems to take a while 
> from me to wrap my head around this again...
> 
> Thanks for pointing this out!
> 
>>
>>> +
>>> +    while (full + half_div >= scale * (u64)tmp)
>>>           tmp++;

Oh. This is a problem. Adding half_div to full here can cause the scale 
* (u64)tmp to overflow. The overflow-prevention above only ensures full 
is smaller than the U64_MAX - scale. Here we should ensure full + 
half_div is less than U64_MAX - scale to ensure the loop always stops.

All in all, this is horrible. Just ran a quick and dirty test on my 
laptop, and using 0xFFFF FFFF FFFF FFFF as full and 0x1 0000 0000 as 
scale (without the half_div addition) ran this loop for several seconds.

Sigh. My brains jammed. I know this can not be an unique problem. I am 
sure there exists a better solution somewhere - any pointers would be 
appreciated :)

>>> -    return tmp;
>>> +    return tmp - 1;
>>>   }
>>>   /**

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

