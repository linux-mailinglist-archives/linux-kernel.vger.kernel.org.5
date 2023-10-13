Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5B07C87A5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 16:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbjJMORI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 10:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbjJMORG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 10:17:06 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3521295
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 07:17:04 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-7a24c86aae3so29631139f.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 07:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697206623; x=1697811423; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TAkJl/NimI1IXG4Vjt+jprIyWorUGASB1mFX1Wsw9IA=;
        b=cOu2R24eSkB+U9U/MNg2fAtEOk90iDFD+WYcnthSIESb6KQ23mxZxEGrygytlMNNbK
         sHzRoC5L5mL/JlQ3E/ZaNo9EEaBgAugVpJW/T+0CfgAkbtHt3nglu0ulXXwAyIhS2ndB
         9HhlOf2KUOqXRLIsjwbIacEZF/yXcc3GBACy46Rt8DccR9W+J2AvkxQzGfA+I0E65j+E
         nmZ4S+iZsBo8ki6aRrFZv+YBpF/OlRXvRq0ij2InhtDiv6VEkWo8GynoFBvT/JJY1j5J
         ifF/ZEifwVHU9JSo/tCfVGAXad0NUt3rUDVtEyAd3OdEgIF1IOHFoFle6VTua64s68pr
         PBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697206623; x=1697811423;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TAkJl/NimI1IXG4Vjt+jprIyWorUGASB1mFX1Wsw9IA=;
        b=MTOVqJD5quN4dhmHY20z/vPP9+i14bq4Za7NAZIkcNGFpy1f9dJdZI+UFBOPOC/LO4
         HDDIlT4L6S4y8m9i4Mhlm9Xkh+EmbHspwVT0+UPoUM2ves+Nekbx+5pLBloeu8UZMG5K
         CqC1yK9S1J/bf3Ii8ZNSydghHRlisePFj7EWHKRP4FQOCXbEkJ4xitAckWuc2ZSymhdb
         pJL6EufI7kuxCZTcX2n4iO7a2DViPcNKF4Pgu6C33XHglV+9IMYbYdsR1CbZBvO82NTc
         uacl9RvpjGkgU0Zp0zDkMqdCe8U0JVk3aZSy25LmnljiY4WjnBSHEYmv19cYzwdj1Fa/
         wpag==
X-Gm-Message-State: AOJu0YxJdwn64Vrhr0/i3FrX9GP4C3YMgcQlubfrbvDCasHLewjcW8hU
        3UxnjzUrLxCS0WzDJgAeWm4+SVN7aLsWWkqgvZQA2g==
X-Google-Smtp-Source: AGHT+IExduVJXS5oXPHa5V2p1APicswlROuu98vGbtIWQofhNpEVl17Rxj/MuXP1QE1gD4chsCrL/w==
X-Received: by 2002:a05:6602:3a11:b0:79f:922b:3809 with SMTP id by17-20020a0566023a1100b0079f922b3809mr28827419iob.1.1697206623481;
        Fri, 13 Oct 2023 07:17:03 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id q25-20020a6bf219000000b007836a9ca101sm4754686ioh.22.2023.10.13.07.17.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 07:17:02 -0700 (PDT)
Message-ID: <10b46003-2a75-49a7-8c74-cd8e3d4915c3@kernel.dk>
Date:   Fri, 13 Oct 2023 08:17:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix regression in sed-opal for a saved key.
Content-Language: en-US
To:     Milan Broz <gmazyland@gmail.com>
Cc:     jonathan.derrick@linux.dev, linux-kernel@vger.kernel.org,
        Ondrej Kozina <okozina@redhat.com>,
        regressions@lists.linux.dev, gjoyce@linux.vnet.ibm.com,
        linux-block@vger.kernel.org
References: <20231003100209.380037-1-gmazyland@gmail.com>
 <5c4fbafb1daa45f2faf60c7d587cd23c53d9393c.camel@linux.vnet.ibm.com>
 <59535b4b-9f07-44c5-a7da-e6b2fc1c67bb@gmail.com>
 <53755a0fbd6318d4783078259f2d2f8ab5f2f0b7.camel@linux.vnet.ibm.com>
 <acf5d5b5-b3d9-403d-ad57-a865774b260f@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <acf5d5b5-b3d9-403d-ad57-a865774b260f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/23 2:30 AM, Milan Broz wrote:
> On 10/5/23 19:58, Greg Joyce wrote:
>> On Thu, 2023-10-05 at 08:58 +0200, Milan Broz wrote:
>>> On 10/4/23 22:54, Greg Joyce wrote:
>>>> On Tue, 2023-10-03 at 12:02 +0200, Milan Broz wrote:
>>>>> The commit 3bfeb61256643281ac4be5b8a57e9d9da3db4335
>>>>> introduced the use of keyring for sed-opal.
>>>>>
>>>>> Unfortunately, there is also a possibility to save
>>>>> the Opal key used in opal_lock_unlock().
>>>>>
>>>>> This patch switches the order of operation, so the cached
>>>>> key is used instead of failure for opal_get_key.
>>>>>
>>>>> The problem was found by the cryptsetup Opal test recently
>>>>> added to the cryptsetup tree.
>>>>>
>>>>> Fixes: 3bfeb6125664 ("block: sed-opal: keyring support for SED
>>>>> keys")
>>>>> Tested-by: Ondrej Kozina <okozina@redhat.com>
>>>>> Signed-off-by: Milan Broz <gmazyland@gmail.com>
>>>>> ---
>>>>>    block/sed-opal.c | 7 +++----
>>>>>    1 file changed, 3 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/block/sed-opal.c b/block/sed-opal.c
>>>>> index 6d7f25d1711b..04f38a3f5d95 100644
>>>>> --- a/block/sed-opal.c
>>>>> +++ b/block/sed-opal.c
>>>>> @@ -2888,12 +2888,11 @@ static int opal_lock_unlock(struct
>>>>> opal_dev
>>>>> *dev,
>>>>>        if (lk_unlk->session.who > OPAL_USER9)
>>>>>            return -EINVAL;
>>>>>
>>>>> -    ret = opal_get_key(dev, &lk_unlk->session.opal_key);
>>>>> -    if (ret)
>>>>> -        return ret;
>>>>>        mutex_lock(&dev->dev_lock);
>>>>>        opal_lock_check_for_saved_key(dev, lk_unlk);
>>>>> -    ret = __opal_lock_unlock(dev, lk_unlk);
>>>>> +    ret = opal_get_key(dev, &lk_unlk->session.opal_key);
>>>>> +    if (!ret)
>>>>> +        ret = __opal_lock_unlock(dev, lk_unlk);
>>>>
>>>> This is relying on opal_get_key() returning 0 to decide if
>>>> __opal_lock_unlock() is called. Is this really what you want? It
>>>> seems
>>>> that you would want to unlock if the key is a LUKS key, even if
>>>> opal_get_key() returns non-zero.
>>>
>>> I think it is ok. That was logic introduced in your keyring patch
>>> anyway.
>>>
>>> I just fixed that if key is cached (stored in OPAL struct), that key
>>> is used
>>> and subsequent opal_get_key() does nothing, returning 0.
>>>
>>> The story is here that both OPAL lock and unlock need key, while LUKS
>>> logic never required key for lock (deactivation), so we rely on the
>>> cached
>>> OPAL key here. We do not need any key stored for unlocking (that is
>>> always
>>> decrypted from a keyslot)
>>> (I think requiring key for locking range is a design mistake in OPAL
>>> but
>>> that's not relevant for now :-)
>>
>> Okay, if the key is such that opal_get_key() always returns 0, then I
>> agree there isn't an issue.
> 
> 
> Jens, what's the status of this patch?
> 
> It is clear regression in 6.6 (I forgot to add regression list, fixed now.)
> 
> For reference, the original report and patch is here
> #regzbot link: https://lore.kernel.org/linux-block/20231003100209.380037-1-gmazyland@gmail.com/
> #regzbot ^introduced 3bfeb6125664

Was waiting on Greg to ack/review it, which it looks like he kind of
has. But would've been nice with a formal ack on it. I've queued it up
now.

-- 
Jens Axboe

