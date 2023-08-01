Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963AF76BDDC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 21:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbjHATe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 15:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjHATe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 15:34:57 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E5619A8;
        Tue,  1 Aug 2023 12:34:56 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-790cadee81bso22922439f.0;
        Tue, 01 Aug 2023 12:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690918495; x=1691523295;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=gbTrRnettBCQtHrQvsgC1K7HZK/F7LZkY/5CL8/OCu0=;
        b=Jvhpa6P+d0f+ymBbKu3apFr1wZTqn8XVcmv+X6l/MymyQ4zVILG1VNXMmc/Luytt3I
         vm8vzGiaR2XhKhHSr6GjNmdMNPpNtiPGQ9USG4EoHrkSfZsiZQWuctj/EbXAHK4U9GLg
         Q9QvDF4rgNCYNSPtOkMKnYYvDuKNZyxxJX//6uLZmVOwYyDo1RWKMF6lJ47RXJc7pJxo
         NB4jrdpY+lpnnIUOzuzse7qMQzxu8wfd07Xm4RJUg4i/NsNELzNbHM1DBq3ildN/mQ8w
         sLU1BXPc1OYtBtMa7y6AfA87T799oqGOGOmV6+8RMBNDCnYe29F4zDRpCIVD7h/RfY8L
         6n5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690918495; x=1691523295;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gbTrRnettBCQtHrQvsgC1K7HZK/F7LZkY/5CL8/OCu0=;
        b=Z9i024CVZyLFOLLsqNhdnq2Yyd0Qd460qRwF/6V/brhgNDlY3ouZgTPh4336B54L1q
         pubBm3U/uaX4hkYFn1d7ZoLKHFh8AAerp/oJW2VbHAMK85KBKLHcH7KkbMa4wg5BB0qk
         ut3PIIhux9I9ozXMo1e1gvkOufgX5dKRzPklGPebnApg8wmaMDfLcyQJuA4hFV8wo1rY
         MSOT2+CYzsOcQV2qXR3mj/15H5RN0b+DNKdPDZtPy7h6DnbKAckSbgFCGdrMKOXOK5+1
         APuflXXrgJVun55qcnucDyNgitt5j/xS1naIfjrHe1eGfpK00uQ2YdOkAq3/5SOv5hGF
         e1VA==
X-Gm-Message-State: ABy/qLaoDOSsfMokcrKF/Rj63uZe0I4kML044mf7gg32MEnYfMilSGDP
        FaD3QMLGndos8NDMwWvAcx8=
X-Google-Smtp-Source: APBJJlEJcUS6KxLBGPDfxPO+hyiFmnhBmvBlsJh2KOaQsAps0P8SrP8eT3+bqyKFLC/DSVX3v3Fegw==
X-Received: by 2002:a6b:dc09:0:b0:790:adce:d553 with SMTP id s9-20020a6bdc09000000b00790adced553mr5718545ioc.21.1690918495347;
        Tue, 01 Aug 2023 12:34:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y8-20020a02a388000000b0042b46224650sm3780561jak.91.2023.08.01.12.34.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 12:34:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f5af0c50-7567-4647-079c-3ee89082f4e8@roeck-us.net>
Date:   Tue, 1 Aug 2023 12:34:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/2] hwmon: (pmbus/tda38640) Add workaround for bug in
 SVID mode
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        krzysztof.kozlowski+dt@linaro.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
References: <20230727091358.3274620-1-Naresh.Solanki@9elements.com>
 <20230727091358.3274620-2-Naresh.Solanki@9elements.com>
 <41a8ae4b-0f96-9f26-f25b-b1554b2695d6@roeck-us.net>
 <CABqG17jKoJ8FJdA-vpX8uda9yi_ir3f2FxFAiE7GTaVM7Mb2aA@mail.gmail.com>
 <b4097ed6-95d6-b11b-9c9e-edd6e8c51d00@roeck-us.net>
 <CABqG17iAsx2nysBSX10PTCK=fTpvaz2456a-s6CBwQjuJduWQw@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CABqG17iAsx2nysBSX10PTCK=fTpvaz2456a-s6CBwQjuJduWQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/23 11:46, Naresh Solanki wrote:
> Hi Guenter,
> 
>>
>> On 8/1/23 05:34, Naresh Solanki wrote:
>>
>> [ ... ]
>>
>>>>> +     if (IS_ENABLED(CONFIG_SENSORS_TDA38640_REGULATOR) || svid) {
>>>>
>>>> If you hide this behind IS_ENABLED(CONFIG_SENSORS_TDA38640_REGULATOR), reading
>>>> svid outside the if() statement has no value.
>>> svid mode check is needed only when regulator is enabled for on/off
>>> control later.
>>> Will align the code such that if svid_mode check is done only when
>>> REGULATOR config is enabled
>>> & if it is in svid mode then apply the WA.
>>>
>>>>
>>>>> +             /*
>>>>> +              * Apply ON_OFF_CONFIG workaround as enabling the regulator using the
>>>>> +              * OPERATION register doesn't work in SVID mode.
>>>>> +              *
>>>>> +              * One should configure PMBUS_ON_OFF_CONFIG here, but
>>>>> +              * PB_ON_OFF_CONFIG_POWERUP_CONTROL and PB_ON_OFF_CONFIG_EN_PIN_REQ
>>>>> +              * are ignored by the device.
>>>>> +              * Only PB_ON_OFF_CONFIG_POLARITY_HIGH has an effect.
>>>>
>>>> Hmm, maybe I start to understand. This is really weird, since it changes
>>>> the polarity of the EN input pin, effectively reverting its value.
>>>> In other words, what really happens is that it is not possible to disable
>>>> the chip with PMBUS_ON_OFF_CONFIG in SVID mode, and that reverting
>>>> the EN pin polarity effectively simulates turning the chip on or off by
>>>> software. Maybe software enable is disabled on purpose in VID mode.
>>>> Is that really a bug or is it a feature, and is it really a good idea to
>>>> override it ?
>>> By design, SVID mode only has HW control enabled.
>>> This was with the assumption that PGOOD will be used for controlling
>>> Enable of another rail in Hardware.
>>>
>>> Since my use case needs the complete PMBUS based control,
>>> EN pin polarity flipping can be used for controlling output.
>>>
>>
>> So, effectively, this is not really a bug. It is working around chip functionality.
>>
>> That means we can not just enable this unconditionally in SVID mode after all.
>> Sorry, but it has to be configurable after all, with appropriate explanation.
> By 'configurable' you mean add a dt-property like 'en-svid-control' to have this
> enabled ?
> 

Yes. After all, not everyone may want this, and it is quite obvious to me that
it is not a bug but normal operation for the chip in SVID mode. Besides, it is
difficult to determine how the chip performs when manipulating the EN input
in SVID mode; I don't understand SVID well enough to be able to determine if doing
that is even valid in that mode. So we definitely don't want to enable this
for other users of the chip.

Sorry, my initial understanding was that this is a bug. I am now convinced
that it isn't.

Guenter

> Regards,
> Naresh
>>
>> Guenter
>>
>>>>
>>>> AN_2203_PL12_2204_184108 might really help here.
>>>>
>>>> Guenter
>>>>
>>>>> +              */
>>>>> +             data->info.read_byte_data = tda38640_read_byte_data;
>>>>> +             data->info.write_byte_data = tda38640_write_byte_data;
>>>>> +     }
>>>>> +     return pmbus_do_probe(client, &data->info);
>>>>>     }
>>>>>
>>>>>     static const struct i2c_device_id tda38640_id[] = {
>>>>
>>

