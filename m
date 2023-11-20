Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82B37F15EB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbjKTOlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbjKTOlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:41:17 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01819110;
        Mon, 20 Nov 2023 06:41:12 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5c6705515d8so36098747b3.2;
        Mon, 20 Nov 2023 06:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700491271; x=1701096071; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=KGHGuTDWNEl2LQwX/5JcgH6sbugZnAEf2kHBj6xk/f8=;
        b=AMaOUkTv8MW1kPC9ID2KvbAq6fNHhChS5YqpnAfAl3Eu1qeTRYjbpOfARplMQSjLM7
         lQWwwBBXA0Dl0g6d9m4RTj0V53amHNMiElJBB25bcwLjO1sXshWzqjMLN7Wvi9IUa3dg
         PKxH8J/hfdJVwl2Qxdpx36nRSU/bqqGKdbY+KooOzPLEOAKw2BngNdKRHwgJF1PreHHB
         6jorHFHQxl7ovq8fK5wYwZRdzuogonsGmxkKPKwb/uwfQs78I0JVA9ApPdc250pfkdl6
         ZUGrLitLz/VHbHK73ktEPuzaov3lFnG7xRskr21wekUBsWhlhQi7FmX37jnkJ19PVMu9
         +lrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700491271; x=1701096071;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGHGuTDWNEl2LQwX/5JcgH6sbugZnAEf2kHBj6xk/f8=;
        b=gcJ5ANBrWENHz/JYSyhM3vkFnOgmcP48WMncyI/Du4PMrVAroE2Hg+QqDJyu45M0+j
         FsqZUz7V7kbfn2efx/CkYv0/3wbcmB13/evkc4BKwxGaqW/GIlSKwz27R4MwBOLkinnI
         GpfuflPg+wVNcnE+BCYJRmTaQFq2KrvbIp2xjMlm7nfNYc2LzyHm+qG5yo3Zz6DiGEsN
         qta1yOqe8sbWZsGZAFMWVFuxYMSsF3c+DAMLrcqHFlUsh1sr1izadcvQthfXZ9vx5cE7
         IkVu+iqSkthBeB79RoIeGJeQH4zK20hAPWtut60uHKTGvd7sv3h9VEhHOcq+VlGcddZ+
         nEFA==
X-Gm-Message-State: AOJu0YyEavh7WUoKC2YTWBvcO+uAfzGhXn1oC3AIOOW84I4a2ZPuBvE9
        cVP7G00ioojgZMhJ5tUwCro=
X-Google-Smtp-Source: AGHT+IGqlEr88xE1RuxnwC2vNT+NiS1RlS4va3EZZJNMEU+Z0lDA9vH4d9boZOCSR44S6klNVPQSqQ==
X-Received: by 2002:a81:4f13:0:b0:5a5:65e:b847 with SMTP id d19-20020a814f13000000b005a5065eb847mr7925386ywb.34.1700491271057;
        Mon, 20 Nov 2023 06:41:11 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x77-20020a81a050000000b005a7ba08b2acsm2397894ywg.0.2023.11.20.06.41.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 06:41:10 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4ed34030-d5c1-4caa-919a-69c7c5aa77ef@roeck-us.net>
Date:   Mon, 20 Nov 2023 06:41:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hwmon: (nct6775) Fix incomplete register array
To:     "xingtong.wu" <xingtong_wu@163.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     xingtong.wu@siemens.com, tobias.schaffner@siemens.com,
        gerd.haeussler.ext@siemens.com
References: <20231116022330.2696-1-xingtong_wu@163.com>
 <20231116022330.2696-2-xingtong_wu@163.com>
 <a18df29d-2e2e-431b-a486-4fd7898e0771@roeck-us.net>
 <b6d0dd45-f159-4518-84fa-8a02cc4e9442@163.com>
Content-Language: en-US
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <b6d0dd45-f159-4518-84fa-8a02cc4e9442@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/23 19:30, xingtong.wu wrote:
> On 2023/11/17 09:35, Guenter Roeck wrote:
>> On 11/15/23 18:23, Xing Tong Wu wrote:
>>> From: Xing Tong Wu <xingtong.wu@siemens.com>
>>>
>>> The nct6116 specification actually includes 5 PWMs, but only 3
>>> PWMs are present in the array. To address this, the missing 2
>>> PWMs have been added to the array.
>>>
>>> Signed-off-by: Xing Tong Wu <xingtong.wu@siemens.com>
>>> ---
>>>    drivers/hwmon/nct6775-core.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/hwmon/nct6775-core.c b/drivers/hwmon/nct6775-core.c
>>> index d928eb8ae5a3..2111f0cd9787 100644
>>> --- a/drivers/hwmon/nct6775-core.c
>>> +++ b/drivers/hwmon/nct6775-core.c
>>> @@ -769,7 +769,7 @@ static const u16 NCT6106_FAN_PULSE_SHIFT[] = { 0, 2, 4 };
>>>      static const u8 NCT6106_REG_PWM_MODE[] = { 0xf3, 0xf3, 0xf3 };
>>>    static const u8 NCT6106_PWM_MODE_MASK[] = { 0x01, 0x02, 0x04 };
>>> -static const u16 NCT6106_REG_PWM_READ[] = { 0x4a, 0x4b, 0x4c };
>>> +static const u16 NCT6106_REG_PWM_READ[] = { 0x4a, 0x4b, 0x4c, 0xd8, 0xd9 };
>>
>> I have no idea where you got the above register addresses from. Looking at
>> the datasheet, NCT6116 doesn't use those registers at all, and neither does
>> NCT6106. The PWM registers for NCT6116 are
>>
> 
> I obtain these registers from the Nuvoton official specification
> "NCT6116D_Datasheet_V1_0.pdf". There is a table that describes the access for the
> PWM registers and corresponding fans:
> 
> Fans: SYSFANOUT, CPUFANOUT, AUXFANOUT0, AUXFANOUT1, AUXFANOUT2
> PWM output duty (write): Bank1 Index19 bit[7:0], Bank1 Index29 bit[7:0], Bank1 Index39 bit[7:0], Bank1 Index99 bit[7:0], Bank1 IndexA9 bit[7:0]
> Current output value (read): Bank0 Index4A, Bank0 Index4B, Bank0 Index4C, Bank0 IndexD8, Bank0 IndexD9
> 
> I have checked the NCT6106-NCT6126 series specification(These documents are not
> publicly available, so I cannot share them with you), there are only 3 fans in
> NCT6106: SYSFANOUT, CPUFANOUT, AUXFANOU0. However, for NCT6116D-NCT6126D, there
> are 2 additional fans: AUXFANOUT1, AUXFANOUT2. The registers for these fans are
> the same. I'll add a new array for NCT6116D's PWM read in my new patch.
> 

I wasn't aware of NCT6126D, but I do have datasheets for NCT6102/4/6 and for NCT6112/4/6.

There is no need to add a separate array. This is good as-is since the added registers
are not used for NCT6102/4/6.

>> static const u16 NCT6116_REG_PWM[] = { 0x119, 0x129, 0x139, 0x199, 0x1a9 };
> 
> Therefore, this array is only for writing, we need to add an array of registers for reading.
> 

Ah, good point. I forgot that the read and write registers are different.

Still, you'll need to extend NCT6106_REG_PWM_MODE[] and NCT6106_PWM_MODE_MASK[] as well.
As far as I can see, aux1 and aux2 are always in pwm mode, so the register arrays
need to be extended with ", 0, 0".

Thanks,
Guenter

