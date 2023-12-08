Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCBA80A7BE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574386AbjLHPnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbjLHPnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:43:03 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DB810EB;
        Fri,  8 Dec 2023 07:43:09 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2851a2b30a2so1840592a91.3;
        Fri, 08 Dec 2023 07:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702050189; x=1702654989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=WdZ6XGEPzhT5jj/IPHXYwoO9J2EgJOhsZV1HjQOLiWk=;
        b=WLt7FeaCRmjoXsyorS5u05JlruCGkrn4NaWJ5a1wUihAXZixxWrq2dkzo8gcdxUsgb
         kIDQ8j6zN3snZkumYCym3j8Un86bpCiPqLT+vsPorhPSeI1tjJPfSiIRLCcMFsGFcRO9
         2E4oiyeo7jpMfOGXrfw3WOH7kc+loF2YEpHwC8FrpS0P2RAa6lVENgjObXWjY3c9fJf5
         l4BkitoLorCRHrn2GqVDVAo23bv9EkA2cAdpijFvRN7DvYS887p/BC9z8MVxAkBpozbO
         NBx1cwtq13fWSGy8nU3/LT1ueEd0GNZ0rhqPO+63fyv66p1RLjqKmuB5X8IlMSHZJNLc
         AaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702050189; x=1702654989;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WdZ6XGEPzhT5jj/IPHXYwoO9J2EgJOhsZV1HjQOLiWk=;
        b=LhduWvQfvtQic8q1mGbqKK/Ih6wlBian4fEUtbCChyg4Gc0EpkrEAgbb2lbO2UEh/p
         RM1kawAgzN+yEmEYk9C0rknUWAuD0ohSd/gOcd10M0vwStuJQAhXDT1cSwnplL4rq7cG
         tqhSEgbTLJnur7S+zMsQMlaTXPOg1iRE8f0+v4tZrKonrjRN6J3ds30GHnpDMzsbd1rL
         JF1OAse82vUJPO0/dC7ArQqstNoyDbN3U8GQeEhHvAreo6cmb6ZTWVpKPjvL0P8aV0mL
         RjxJfq14BWWJBoyZIDCxlY7tIP3Dt9k35h6S6Co15/37Fh7QXaQ0Orm65odawNdcNvXV
         h5wQ==
X-Gm-Message-State: AOJu0Yw9gg0o3m6b6gwwVSGbPg81HDLJD0Wsh7ZOYqdeBfb318piJMeI
        4YlRQ1+adrBTdO6edYc4GXg=
X-Google-Smtp-Source: AGHT+IEaWnrXi2VV5U/tdIVeucRXBn67c4mmL/hC75+j2aQXn32dkoik18nHKehgUuf3+s1NWHZ8WQ==
X-Received: by 2002:a17:90a:df86:b0:28a:464d:5ecb with SMTP id p6-20020a17090adf8600b0028a464d5ecbmr268789pjv.36.1702050189043;
        Fri, 08 Dec 2023 07:43:09 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 26-20020a17090a191a00b00286e69c8fb1sm2122269pjg.52.2023.12.08.07.43.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 07:43:08 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b2b3f17d-0f86-4d40-a471-f44153efd6fe@roeck-us.net>
Date:   Fri, 8 Dec 2023 07:43:07 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: (corsair-psu) Fix failure to load when built-in to
 kernel
Content-Language: en-US
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        Aleksa Savic <savicaleksa83@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
References: <20231208130710.191420-1-savicaleksa83@gmail.com>
 <d91d4bf1-3e8d-4b63-baa9-479a91d04eb7@gmail.com>
 <20231208145742.6def047a@posteo.net>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20231208145742.6def047a@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/23 05:57, Wilken Gottwalt wrote:
> On Fri, 8 Dec 2023 14:11:44 +0100
> Aleksa Savic <savicaleksa83@gmail.com> wrote:
> 
>> On 2023-12-08 14:07:10 GMT+01:00, Aleksa Savic wrote:
>>> When built-in to the kernel, the corsair-psu driver fails to register with
>>> the following message:
>>>
>>> "Driver 'corsair-psu' was unable to register with bus_type 'hid'
>>> because the bus was not initialized."
>>>
>>> Fix this by initializing the driver after the HID bus using
>>> late_initcall(), as hwmon is built before HID.
>>>
>>> Fixes: d115b51e0e56 ("hwmon: add Corsair PSU HID controller driver")
>>> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
>>> ---
>>>   drivers/hwmon/corsair-psu.c | 15 ++++++++++++++-
>>>   1 file changed, 14 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
>>> index 904890598c11..48831a528965 100644
>>> --- a/drivers/hwmon/corsair-psu.c
>>> +++ b/drivers/hwmon/corsair-psu.c
>>> @@ -899,7 +899,20 @@ static struct hid_driver corsairpsu_driver = {
>>>   	.reset_resume	= corsairpsu_resume,
>>>   #endif
>>>   };
>>> -module_hid_driver(corsairpsu_driver);
>>> +
>>> +static int __init corsairpsu_hid_init(void)
>>> +{
>>> +	return hid_register_driver(&corsairpsu_driver);
>>> +}
>>> +
>>> +static void __exit corsairpsu_hid_exit(void)
>>> +{
>>> +	hid_unregister_driver(&corsairpsu_driver);
>>> +}
>>> +
>>> +/* When compiled into the kernel, initialize after the hid bus */
>>> +late_initcall(corsairpsu_hid_init);
>>> +module_exit(corsairpsu_hid_exit);
>>>   
>>>   MODULE_LICENSE("GPL");
>>>   MODULE_AUTHOR("Wilken Gottwalt <wilken.gottwalt@posteo.net>");
>>
>>
>> Woops! Just saw that the same fix was sent yesterday. Please disregard, sorry!
>>
>> Aleksa
> 
> It is fine. I just start to wonder if there was a change in the subsystem. I
> used the driver as built-in in the past for several months and never had that
> issue. And now it is a real flood of reports.
> 

Maybe there was a change in the build order, or some subtle change
in driver registration code. Question though is _when_ this changed.
It would be great if someone could bisect it. For example, bus registration
code has been changed significantly in v6.3. I am copying linux-input
and the hid maintainers for feedback.

Either case, I now have two patches and at least the first one was actually
tested, but no Reviewed-by: or Tested-by: for either of them. While that is
of course a formality, it would still be useful to show that it is not just
a random change.

Thanks,
Guenter

