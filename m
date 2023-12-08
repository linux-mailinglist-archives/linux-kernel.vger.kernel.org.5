Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5BF80A9D4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574160AbjLHQwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbjLHQwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:52:45 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0032C1989;
        Fri,  8 Dec 2023 08:52:50 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9e1021dbd28so303528766b.3;
        Fri, 08 Dec 2023 08:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702054369; x=1702659169; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pM2CjZf7UrGYa8UE0QDmZ86QP59hzyqT7w0nEzPHVe0=;
        b=mNSR0n2+/Jj3hgnskWJERLbUUPfuO26eTjTv3xDcp5GIsRNvqGw9g4JJ2PaqYAGGsX
         yOUjLDaxucz7TbnE1HFmf+PNpsCbpbppP/+xh6gfcTd5myPZObvSYj8rhBwICPCGaQR1
         651N+Y6WV4a4zgBAfdg217cfbHGp1tpkojaxCLNQq3RFKR25eA384uobNRyNBQQRa2T+
         yTBaL1Ah6F895bHB1A37q/fstpUBb6t1KNSRFsRLS6Z1ifJJ5ERRZVdIYJkrVUNsgGDw
         Q5gY2nXb0Q972IgqKiaLkbRbuygXskSxgWVC9Q/UeJpc8BIDC+b12+6D7PZezxrZEA7d
         Wurw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702054369; x=1702659169;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pM2CjZf7UrGYa8UE0QDmZ86QP59hzyqT7w0nEzPHVe0=;
        b=iodnFM70XLQQZTWU1GqKuZF3UxnJFSggRTMoKJQGVmyVJ6x8X+2D9aDpqU2t1T20uy
         hj6PnVi5Q4tvTLuY/C4orvwaxLioAiE6O0wm17hGzYpkiFhj7nJAffRcxLGgVLmAiNev
         Dd5go5UnuxS1LJSZPv+PPsD7+H45a3buIMBUL61md9TcrnXVMoDM4nZ3IGrTiPNGmUIJ
         aBpvWo9EioPnhLQAXSgodgYkgT3Kuk9oWOMY7ey6KGa/FOxlwFoNM3TtbP6qA5DV9Xun
         63XXMAZiSx7yCYUrKQVQRmd6gOPAscuevifYWpY2/eHpYGhplceQ1Od3RN/6oMkDfdDw
         g6/g==
X-Gm-Message-State: AOJu0YxcyTivWn+RYVfx9qpgtkb+cnjQEcjUfS1+cmo/Gql9/ZGXXfNm
        woBnh8I4nMjwd8P2dBWMWGk=
X-Google-Smtp-Source: AGHT+IER6TE8y87k38ly2BUvKu6HdJTda3ueRxAJuKYFxylZpEH18RMfe8AYx/l4uaK4ZqkGj1WIWQ==
X-Received: by 2002:a17:906:b793:b0:a1c:be13:f0bc with SMTP id dt19-20020a170906b79300b00a1cbe13f0bcmr149736ejb.109.1702054369084;
        Fri, 08 Dec 2023 08:52:49 -0800 (PST)
Received: from [192.168.0.28] (cable-178-148-234-71.dynamic.sbb.rs. [178.148.234.71])
        by smtp.gmail.com with ESMTPSA id bi2-20020a170906a24200b00a1e04f24df1sm1198842ejb.223.2023.12.08.08.52.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 08:52:48 -0800 (PST)
Message-ID: <fe16b501-759a-492b-9835-83ebf8761ae8@gmail.com>
Date:   Fri, 8 Dec 2023 17:52:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     savicaleksa83@gmail.com, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] hwmon: (corsair-psu) Fix failure to load when built-in to
 kernel
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Wilken Gottwalt <wilken.gottwalt@posteo.net>
References: <20231208130710.191420-1-savicaleksa83@gmail.com>
 <d91d4bf1-3e8d-4b63-baa9-479a91d04eb7@gmail.com>
 <20231208145742.6def047a@posteo.net>
 <b2b3f17d-0f86-4d40-a471-f44153efd6fe@roeck-us.net>
From:   Aleksa Savic <savicaleksa83@gmail.com>
In-Reply-To: <b2b3f17d-0f86-4d40-a471-f44153efd6fe@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-08 16:43:07 GMT+01:00, Guenter Roeck wrote:
> On 12/8/23 05:57, Wilken Gottwalt wrote:
>> On Fri, 8 Dec 2023 14:11:44 +0100
>> Aleksa Savic <savicaleksa83@gmail.com> wrote:
>>
>>> On 2023-12-08 14:07:10 GMT+01:00, Aleksa Savic wrote:
>>>> When built-in to the kernel, the corsair-psu driver fails to register with
>>>> the following message:
>>>>
>>>> "Driver 'corsair-psu' was unable to register with bus_type 'hid'
>>>> because the bus was not initialized."
>>>>
>>>> Fix this by initializing the driver after the HID bus using
>>>> late_initcall(), as hwmon is built before HID.
>>>>
>>>> Fixes: d115b51e0e56 ("hwmon: add Corsair PSU HID controller driver")
>>>> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
>>>> ---
>>>>   drivers/hwmon/corsair-psu.c | 15 ++++++++++++++-
>>>>   1 file changed, 14 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
>>>> index 904890598c11..48831a528965 100644
>>>> --- a/drivers/hwmon/corsair-psu.c
>>>> +++ b/drivers/hwmon/corsair-psu.c
>>>> @@ -899,7 +899,20 @@ static struct hid_driver corsairpsu_driver = {
>>>>       .reset_resume    = corsairpsu_resume,
>>>>   #endif
>>>>   };
>>>> -module_hid_driver(corsairpsu_driver);
>>>> +
>>>> +static int __init corsairpsu_hid_init(void)
>>>> +{
>>>> +    return hid_register_driver(&corsairpsu_driver);
>>>> +}
>>>> +
>>>> +static void __exit corsairpsu_hid_exit(void)
>>>> +{
>>>> +    hid_unregister_driver(&corsairpsu_driver);
>>>> +}
>>>> +
>>>> +/* When compiled into the kernel, initialize after the hid bus */
>>>> +late_initcall(corsairpsu_hid_init);
>>>> +module_exit(corsairpsu_hid_exit);
>>>>     MODULE_LICENSE("GPL");
>>>>   MODULE_AUTHOR("Wilken Gottwalt <wilken.gottwalt@posteo.net>");
>>>
>>>
>>> Woops! Just saw that the same fix was sent yesterday. Please disregard, sorry!
>>>
>>> Aleksa
>>
>> It is fine. I just start to wonder if there was a change in the subsystem. I
>> used the driver as built-in in the past for several months and never had that
>> issue. And now it is a real flood of reports.
>>
> 
> Maybe there was a change in the build order, or some subtle change
> in driver registration code. Question though is _when_ this changed.
> It would be great if someone could bisect it. For example, bus registration
> code has been changed significantly in v6.3. I am copying linux-input
> and the hid maintainers for feedback.

The late_initcall() was also needed in 2020. when corsair-cpro was added in
40c3a4454225 ("hwmon: add Corsair Commander Pro driver").

There was also discussion on the list about it:

https://lore.kernel.org/all/3864498.z6qT3ff8q6@marius/

nzxt-smart2 (from the tail of 2021.) also has a comment about the message.

(Just providing references.)

Aleksa

> 
> Either case, I now have two patches and at least the first one was actually
> tested, but no Reviewed-by: or Tested-by: for either of them. While that is
> of course a formality, it would still be useful to show that it is not just
> a random change.
> 
> Thanks,
> Guenter
> 

