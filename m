Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6746D7A89F0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 19:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbjITRCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 13:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234905AbjITRCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 13:02:07 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CF7D7;
        Wed, 20 Sep 2023 10:01:59 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c1e3a4a06fso56286865ad.3;
        Wed, 20 Sep 2023 10:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695229319; x=1695834119; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GHujuC4La1zbiPeEIuvGOEBBG8VELcRCDyL8zMCWV50=;
        b=kEp3kJRy8kdrbEWRHHFsyilpJr6E1e+uOB07lWsebunx2AofCcBPKzeQXiMb6wtQ4S
         fyONW8L9UlPusGLzpxc4Eec6vVphazyVL0Xh841gvVHu5cMX5KZyDMaoFsE51VruID5/
         l+TGPO/g/SEw7YpBxN3k4R2eFIxwjoH5i2lFyTTcshmwRqPzR9rumoyh5eWfZaFccAuY
         uFjh1hMTg487gV9FnNmd/LdQjlZGw707eFdjPhhxpbf76d4JhC0BBya4zpv5SGCvGwn9
         62pCo9Ab0g0foctUJJFqOtvaEBv9ZsrSWvack5tqQvvCUeNpdYghYIf0dZXbYlTwWzpd
         x9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695229319; x=1695834119;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GHujuC4La1zbiPeEIuvGOEBBG8VELcRCDyL8zMCWV50=;
        b=EBBX2T2aNdv0es8oSfutIOq9mDpsG/Ymrbazepb6N4a67omGPeB3S02R1QiXS0aNS0
         ZB/rT+ktaI36VURTNK7uefFz9qnNwsp9ODpwjI+ARyOWIZkUXh1LzSpSbm8T7/1oPzrV
         037M/aCOlc0NdmL+85DE59sQHzr/NEBXJm2r+is7TuzSowo35kJoLWlZ7KbeT2sYKcTU
         +M5B3PI80jkj43arrdjRSRh5I+cXsY5gkexC2Zvx7Wxog0kKvERQkDaV4bq0AftPrD85
         Z/NSoaX0x+JsRGbFgKGelyH3SYzOO7V7GxdBkP2LNyk6sWli2CiC6oDcJoEKobaU0tqM
         631A==
X-Gm-Message-State: AOJu0Yyg5gTQo/5oLKqrhXQWM1P/rcdleV20O7IcKqtljeAWOIbG3Elr
        +zA7e49ZVWsWc8PIPzL0nCQ=
X-Google-Smtp-Source: AGHT+IFQpH3spCEqxNoVJkXAHO0SCtX1qRc23XIa9dvA9l7bMarEU+YJBc7iSR3PfvjV9sunr1kZoQ==
X-Received: by 2002:a17:903:2601:b0:1c5:76b6:d4f8 with SMTP id jd1-20020a170903260100b001c576b6d4f8mr2632880plb.44.1695229318793;
        Wed, 20 Sep 2023 10:01:58 -0700 (PDT)
Received: from [10.67.49.139] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id u7-20020a170903124700b001bb0eebd90asm12058224plh.245.2023.09.20.10.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 10:01:58 -0700 (PDT)
Message-ID: <8457ff12-c28b-898b-3f12-97aa12ce6716@gmail.com>
Date:   Wed, 20 Sep 2023 10:01:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 5.10 000/406] 5.10.195-rc1 review
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kyle Zeng <zengyhkyle@gmail.com>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230917191101.035638219@linuxfoundation.org>
 <07a04540-554c-4394-1e79-46ea665f8c03@roeck-us.net>
 <2023092009-angriness-sank-ae4f@gregkh>
 <27f978f3-11ca-6054-5160-ab66d4c918bc@roeck-us.net>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <27f978f3-11ca-6054-5160-ab66d4c918bc@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/23 08:18, Guenter Roeck wrote:
> On 9/20/23 01:11, Greg Kroah-Hartman wrote:
>> On Tue, Sep 19, 2023 at 09:57:25PM -0700, Guenter Roeck wrote:
>>> On 9/17/23 12:07, Greg Kroah-Hartman wrote:
>>>> This is the start of the stable review cycle for the 5.10.195 release.
>>>> There are 406 patches in this series, all will be posted as a response
>>>> to this one.  If anyone has any issues with these being applied, please
>>>> let me know.
>>>>
>>>> Responses should be made by Tue, 19 Sep 2023 19:10:04 +0000.
>>>> Anything received after that time might be too late.
>>>>
>>>
>>> chromeos-5.10 locks up in configfs_lookup() after the merge of 
>>> v5.10.195.
>>>
>>> I am a bit puzzled because I see
>>>
>>> c709c7ca020a configfs: fix a race in configfs_lookup()
>>>
>>> in v5.10.195 but not in the list of commits below. I guess I must be
>>> missing something.
>>
>> It was part of the big patchset, it was posted here:
>>     https://lore.kernel.org/r/20230917191101.511939651@linuxfoundation.org
>>
>> Not hidden at all :)
>>
>> and was submitted here:
>>     https://lore.kernel.org/r/ZPOZFHHA0abVmGx+@westworld
>>
>>> Either case, the code now looks as follows.
>>>
>>> configfs_lookup()
>>> {
>>>      ...
>>>      spin_lock(&configfs_dirent_lock);
>>>      ...
>>>          err = configfs_attach_attr(sd, dentry);
>>>      ...
>>>      spin_unlock(&configfs_dirent_lock);
>>>      ...
>>> }
>>>
>>> and
>>>
>>> configfs_attach_attr(...)
>>> {
>>>      ...
>>>      spin_lock(&configfs_dirent_lock);
>>>      ...
>>> }
>>>
>>> which unless it is way too late here and I really need to go to sleep
>>> just won't work.
>>
>> Kyle, you did the backport, any comments?
>>
> 
> After a good night sleep, the code still looks wrong to me. Reverting
> the offending patch in chromeos-5.10 solved the problem there.
> That makes me suspect that no one actually tests configfs.

Humm indeed, looking at our testing we don't have our USB devices being 
tested which would exercise configfs since we switch the USB device 
between different configurations (mass storage, serial, networking 
etc.). Let me see about adding that so we get some coverage.
-- 
Florian

