Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E2C7FBB2B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 14:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345120AbjK1NQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 08:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345084AbjK1NQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 08:16:23 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1895E1739;
        Tue, 28 Nov 2023 05:16:27 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50baa2a278bso4282346e87.0;
        Tue, 28 Nov 2023 05:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701177385; x=1701782185; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3WsLCDEyC18KZR6i8uibTKhqQD0u+XbO+WP+uHOq1+o=;
        b=buo4niLjMTZIhnNsBd1m13U6K2R5ORRrEo6LJyj9Xw+JB3snTIzcTHosDlMXuaZRMB
         mpaPUDsL/405QdentRIs393XFj/edXYbzkf4xkOKIpo71ENC+Lo7p/m+wpC+MTrC3YY+
         IVkfGBuKNPHvK7Fj8ezjDrvsfyGJ2/k86kCxkl1vACYONZLt1ttEKyyzlZ+sLotEpeCx
         KAoTep4kk1LyBn3SvdmOryrU9t8ebq/pO1KBw9hNspm/03za29yrCwJYIhsnADD73Qj+
         mjLeGkDto1Gkp53+4Ap0xkOrkXoj5+q8MNxPQPK7uTSNzWNHncGrkl3gNCMGNorum6QE
         1yRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701177385; x=1701782185;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3WsLCDEyC18KZR6i8uibTKhqQD0u+XbO+WP+uHOq1+o=;
        b=gQWubDCy8x1hkqgtckFyy96OvbxG7Eg0MOSHuFVRZREQwQUYyfqTplPOHe9zY1aAiN
         YYw3vKtjC3oB2ZaYPjLOKgRfgJf2DnUq9NOxt6IhmpveVN3jksNkwqigiInL2uMi3To0
         kE1XQXqGpydKAAxN4Fjt0HfCnUraa7BpsP/bGkQAPdzwjmb+o1bniG703z7BNy6Rd5vk
         SKk7DMC4A/+kM3NMygbRwKaQaGw5hrSjERDCB7NS/r+Z9+jFlowIZJqNEjh66J7z513u
         4ki+VmuxGJkcowqVxB9eF0JizINQZwasl3dBIQZTvDixzd5dQt0CV4bEbXGiXVD3GlWN
         jxig==
X-Gm-Message-State: AOJu0YyaJMcmerQChaono/fL8CJbLGrxejFDxQXAE5VdadwpTfr4KpU7
        pGzEgfZ2GjyWFaL9MoDuF4Y=
X-Google-Smtp-Source: AGHT+IGOb6aknLuNLSjtnN2PPRiE8h1x0pOPEE61cEr8/EOwB61Cl4xSx3poefLtsRPypE87M1+2iQ==
X-Received: by 2002:a05:6512:11eb:b0:509:4bb5:ff96 with SMTP id p11-20020a05651211eb00b005094bb5ff96mr8014024lfs.59.1701177384822;
        Tue, 28 Nov 2023 05:16:24 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f8:1500::2? (dc78bmyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::2])
        by smtp.gmail.com with ESMTPSA id be36-20020a056512252400b0050b9bcd437esm1832444lfb.183.2023.11.28.05.16.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 05:16:24 -0800 (PST)
Message-ID: <fabd0693-34c3-49c1-8680-17f6f8b9453a@gmail.com>
Date:   Tue, 28 Nov 2023 15:16:23 +0200
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
 <1fe658cd-bdd5-4afd-8564-d0dcf9eab4ab@gmail.com>
In-Reply-To: <1fe658cd-bdd5-4afd-8564-d0dcf9eab4ab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/23 13:56, Matti Vaittinen wrote:
> On 11/27/23 09:48, Matti Vaittinen wrote:
>> On 11/26/23 19:26, Jonathan Cameron wrote:
>>> On Tue, 31 Oct 2023 11:50:46 +0200
>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>>
>>>> The GTS helpers do flooring of scale when calculating available scales.
>>>> This results available-scales to be reported smaller than they should
>>>> when the division in scale computation resulted remainder greater than
>>>> half of the divider. (decimal part of result > 0.5)
>>>>
>>>> Furthermore, when gains are computed based on scale, the gain resulting
>>>> from the scale computation is also floored. As a consequence the
>>>> floored scales reported by available scales may not match the gains 
>>>> that
>>>> can be set.
>>>>
>>>> The related discussion can be found from:
>>>> https://lore.kernel.org/all/84d7c283-e8e5-4c98-835c-fe3f6ff94f4b@gmail.com/
>>>>
>>>> Do rounding when computing scales and gains.
>>>>
>>>> Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")
>>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>>

...

>>>> +    if ((u64)scale32 == scale)
>>>> +        return iio_gts_get_gain_32(full, scale32);
>>>> +
>>>>       if (U64_MAX - full < scale) {
>>>>           /* Risk of overflow */
>>>> -        if (full - scale < scale)
>>>> +        if (full - scale / 2 < scale)
>>>>               return 1;
>>>>           full -= scale;
>>>>           tmp++;
>>>>       }
>>>> -    while (full > scale * (u64)tmp)
>>>> +    half_div = scale >> 2;
>>>
>>> Why divide by 4?  Looks like classic issue with using shifts for 
>>> division
>>> causing confusion.
>>
>> Yes. Looks like a brainfart to me. I need to fire-up my tests and 
>> revise this (and the check you asked about above). It seems to take a 
>> while from me to wrap my head around this again...
>>
>> Thanks for pointing this out!
>>
>>>
>>>> +
>>>> +    while (full + half_div >= scale * (u64)tmp)
>>>>           tmp++;
> 
> Oh. This is a problem. Adding half_div to full here can cause the scale 
> * (u64)tmp to overflow. The overflow-prevention above only ensures full 
> is smaller than the U64_MAX - scale. Here we should ensure full + 
> half_div is less than U64_MAX - scale to ensure the loop always stops.
> 
> All in all, this is horrible. Just ran a quick and dirty test on my 
> laptop, and using 0xFFFF FFFF FFFF FFFF as full and 0x1 0000 0000 as 
> scale (without the half_div addition) ran this loop for several seconds.
> 
> Sigh. My brains jammed. I know this can not be an unique problem. I am 
> sure there exists a better solution somewhere - any pointers would be 
> appreciated :)
> 

And as a reply to myself - is there something wrong with using the 
div64_u64()? Sorry for the noise...

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

