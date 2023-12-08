Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8A580AC1B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 19:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574584AbjLHSeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 13:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbjLHSem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 13:34:42 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F4112E;
        Fri,  8 Dec 2023 10:34:48 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6d84ddd642fso1473169a34.0;
        Fri, 08 Dec 2023 10:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702060488; x=1702665288; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=W/80bz9Uv86Lw/jPf2dcBPDXTUKYtcqEXNMQKWUmzLY=;
        b=E3oiQdo36WCtXuHnbx7gUGTSRnTr8I1jPea/QhGkUtp0t/us0/5hj2YF4ikLNPyzC+
         v9dKJsDNvl2J5kDwzZnfpDu1mO3EGaYM5lvJaB2G0wvJJUX6CMVdQR7Cj3DDDF9uWSVa
         HPDNL//qTCriXXH81VWs0dqMyqFhFoeDBEOO9EVeXXpOOiH0eidPQabzf3JPQS5eYMoH
         DtWK7WQqLTQ3yWLHc3nYiHRlzsZcPRFJjTAYo6nuNmy2+mKGZNULWHVV82zwoFBdJ9Rz
         PkuXM3aXB6TIAmeg+E6MX1UjYslS06zXkUjqRCecKbzPAFHrPZzkZ2WzWeZ4BVqgC1fh
         qA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702060488; x=1702665288;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W/80bz9Uv86Lw/jPf2dcBPDXTUKYtcqEXNMQKWUmzLY=;
        b=fcWZqYaJZ14o+Zi4+TmsL9dZxRAGW2eMo6EgTZIBepsP/2j97Y7vqV/a3YvGEcIZR3
         BYNs+FKQg5JM3z4RnRKByYNcqaqYbxFJiB2oq/QZQNjMIKnEOmOidNhz/7Qzdb1WFXzj
         JNLk+M6un7QVmz6T24TZ4HazMOJva2X3gYPb5UiCgd3BsYGjeaVBJSgI9g6LKu7S3Eiz
         G8Kun1vsvDwQ75dcJTMFqGLKopz2YsQr0swUhwN7U79jsY+LewtxiW4Mh55JntEN6cLC
         V7ViKV0M8fYAK/siKr9Mvtc8b+CMJSdfwo1nGwKgTscR2yF31T7f296QlrQcEiDmPycY
         0q/g==
X-Gm-Message-State: AOJu0Yx4QcnOZ9YucKuBSwk2g5/pxr1vX+OtWbNZoQStx4dwZsd2Xhoy
        0AfYb3qx+ORgkocjK7LTdVw=
X-Google-Smtp-Source: AGHT+IEXynjgWplklUBM1lD+jCE4/0VqbMYGUjXjam2ZAwGSWq3LYOJQHJ+e+0Jk3ag3voA6zgYxrw==
X-Received: by 2002:a9d:4d83:0:b0:6d9:e48c:f08a with SMTP id u3-20020a9d4d83000000b006d9e48cf08amr493929otk.11.1702060487852;
        Fri, 08 Dec 2023 10:34:47 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c9-20020a056830000900b006d87b167c41sm385040otp.8.2023.12.08.10.34.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 10:34:47 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4282d240-bf0c-4e4c-ac18-503067715ebf@roeck-us.net>
Date:   Fri, 8 Dec 2023 10:34:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: (corsair-psu) Fix failure to load when built-in to
 kernel
Content-Language: en-US
To:     Aleksa Savic <savicaleksa83@gmail.com>,
        Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
References: <20231208130710.191420-1-savicaleksa83@gmail.com>
 <d91d4bf1-3e8d-4b63-baa9-479a91d04eb7@gmail.com>
 <20231208145742.6def047a@posteo.net>
 <b2b3f17d-0f86-4d40-a471-f44153efd6fe@roeck-us.net>
 <fe16b501-759a-492b-9835-83ebf8761ae8@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <fe16b501-759a-492b-9835-83ebf8761ae8@gmail.com>
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

On 12/8/23 08:52, Aleksa Savic wrote:
> On 2023-12-08 16:43:07 GMT+01:00, Guenter Roeck wrote:
>> On 12/8/23 05:57, Wilken Gottwalt wrote:
>>> On Fri, 8 Dec 2023 14:11:44 +0100
>>> Aleksa Savic <savicaleksa83@gmail.com> wrote:
>>>
>>>> On 2023-12-08 14:07:10 GMT+01:00, Aleksa Savic wrote:
>>>>> When built-in to the kernel, the corsair-psu driver fails to register with
>>>>> the following message:
>>>>>
>>>>> "Driver 'corsair-psu' was unable to register with bus_type 'hid'
>>>>> because the bus was not initialized."
>>>>>
>>>>> Fix this by initializing the driver after the HID bus using
>>>>> late_initcall(), as hwmon is built before HID.
>>>>>
>>>>> Fixes: d115b51e0e56 ("hwmon: add Corsair PSU HID controller driver")
>>>>> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
>>>>> ---
>>>>>    drivers/hwmon/corsair-psu.c | 15 ++++++++++++++-
>>>>>    1 file changed, 14 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
>>>>> index 904890598c11..48831a528965 100644
>>>>> --- a/drivers/hwmon/corsair-psu.c
>>>>> +++ b/drivers/hwmon/corsair-psu.c
>>>>> @@ -899,7 +899,20 @@ static struct hid_driver corsairpsu_driver = {
>>>>>        .reset_resume    = corsairpsu_resume,
>>>>>    #endif
>>>>>    };
>>>>> -module_hid_driver(corsairpsu_driver);
>>>>> +
>>>>> +static int __init corsairpsu_hid_init(void)
>>>>> +{
>>>>> +    return hid_register_driver(&corsairpsu_driver);
>>>>> +}
>>>>> +
>>>>> +static void __exit corsairpsu_hid_exit(void)
>>>>> +{
>>>>> +    hid_unregister_driver(&corsairpsu_driver);
>>>>> +}
>>>>> +
>>>>> +/* When compiled into the kernel, initialize after the hid bus */
>>>>> +late_initcall(corsairpsu_hid_init);
>>>>> +module_exit(corsairpsu_hid_exit);
>>>>>      MODULE_LICENSE("GPL");
>>>>>    MODULE_AUTHOR("Wilken Gottwalt <wilken.gottwalt@posteo.net>");
>>>>
>>>>
>>>> Woops! Just saw that the same fix was sent yesterday. Please disregard, sorry!
>>>>
>>>> Aleksa
>>>
>>> It is fine. I just start to wonder if there was a change in the subsystem. I
>>> used the driver as built-in in the past for several months and never had that
>>> issue. And now it is a real flood of reports.
>>>
>>
>> Maybe there was a change in the build order, or some subtle change
>> in driver registration code. Question though is _when_ this changed.
>> It would be great if someone could bisect it. For example, bus registration
>> code has been changed significantly in v6.3. I am copying linux-input
>> and the hid maintainers for feedback.
> 
> The late_initcall() was also needed in 2020. when corsair-cpro was added in
> 40c3a4454225 ("hwmon: add Corsair Commander Pro driver").
> 
> There was also discussion on the list about it:
> 
> https://lore.kernel.org/all/3864498.z6qT3ff8q6@marius/
> 
> nzxt-smart2 (from the tail of 2021.) also has a comment about the message.
> 
> (Just providing references.)
> 

Ah yes, thanks for the reminder. We actually had a similar problem with
watchdog drivers and worked around it by deferring watchdog driver registration
until the watchdog core is initialized. That is of course just a kludge.
No idea if a clean(er) solution is even possible.

Guenter

