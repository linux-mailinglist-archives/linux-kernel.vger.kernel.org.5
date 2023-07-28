Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5E07673F3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 19:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbjG1RxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 13:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234744AbjG1RxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 13:53:06 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CAF10CB;
        Fri, 28 Jul 2023 10:53:04 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1bbaa549bcbso1905775fac.3;
        Fri, 28 Jul 2023 10:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690566784; x=1691171584;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=KPNS8nAOP/RrJU4iRZ8nyG6vRXAppFpu9cvYXhZaAxc=;
        b=nQ6vN8NS6m7Tan+my3bjZ8J88psSiUXdIDGTCFbkm3XGBoyu9KtsoU7ip+ICqFCkEe
         Yo3JuqUTUU6hhqZ+hykzQjoQJ2AANRvUdC1Z3un3XG/Iprm6mW6vrszW052D0i9U1D5T
         fmU9YHgNUw5ztoJ5/671ZUR6W4255E6/LCq64/j/+F0MoBBHJLONQCeeXT6MumA3SZuO
         EQw8xem00AlGM0GwCvCk7FINT9GyLtgm1/DnlrA27m22j4ulSlUzJnTuqKPA/SneY6nR
         UwrbGXmGj7LeT4Orh/Hv9nrPwNYEWccCxo+ne2u0ATeOs3SbbAzvOIzPeq35i/TAq7xj
         B+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690566784; x=1691171584;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KPNS8nAOP/RrJU4iRZ8nyG6vRXAppFpu9cvYXhZaAxc=;
        b=V0+xOCoxJDDBhU8coXYxNf2ZjP4CEDPBaKZppifMetjd4QYqJPZjWywPsGR0X1HaV/
         vUZAS/cqyXjJ0Ec92VkdA1P6uCyXI1aGv5UJyMw7p4ahwnprHgNjhYgPcp49GlgMz+pe
         838jrDyt5iAiaaJBKmiuYvoW31njBe+IlnduopsKqbBZVDC3N4pYXFVJN6Vcu7x5rBYt
         F16BTKw+bzN8OmJy0TyufW5um+HqUJk1l8ZpQekgQv+xCrhbC3z22bQPvBzuYH1HCeWk
         iygFop4VIJ41NYDIjKlvMJR7p1UWzt6hQdYAtuxbswuBXj8xBAGqCUbmQWqIn8s8ws2T
         iPrQ==
X-Gm-Message-State: ABy/qLaB2HQEvmCPUppO00S27cs9h8ulCWb1yQXBY8nEpX2X+eM7TG6Q
        jA9qdP7vzz5tZYYpunrq26A=
X-Google-Smtp-Source: APBJJlFWUlb2Ly6uOXXtBjf7T2juDs1nvjcT+1uhjAxlFk76hRAEcAa1Pn2egCbqR+btETo0eD44KA==
X-Received: by 2002:a05:6870:f70b:b0:1b7:609f:e0d4 with SMTP id ej11-20020a056870f70b00b001b7609fe0d4mr3676457oab.15.1690566781962;
        Fri, 28 Jul 2023 10:53:01 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k9-20020a02c649000000b0042b265bf3besm1207040jan.115.2023.07.28.10.52.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 10:53:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f400750d-e53c-65f8-210f-aa127d8f6beb@roeck-us.net>
Date:   Fri, 28 Jul 2023 10:52:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] Add Silicom Platform Driver
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Huibin Shi <henrys@silicom-usa.com>,
        Henry Shi <henryshi2018@gmail.com>,
        "hbshi69@hotmail.com" <hbshi69@hotmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Cc:     "hb_shi2003@yahoo.com" <hb_shi2003@yahoo.com>,
        Wen Wang <wenw@silicom-usa.com>
References: <20230718160104.2716-1-henryshi2018@gmail.com>
 <fb62b2e7-7c7c-dc2e-768d-3393f151eb32@wanadoo.fr>
 <PA4PR04MB92225B65A45868A9CBE25B999A06A@PA4PR04MB9222.eurprd04.prod.outlook.com>
 <08469a96-24f2-2099-0a0a-019cb81f976b@wanadoo.fr>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <08469a96-24f2-2099-0a0a-019cb81f976b@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 7/28/23 09:47, Christophe JAILLET wrote:
> Le 28/07/2023 à 14:59, Huibin Shi a écrit :
>> Christophe,
>>
>> Thanks for the comments. See my comments below.
>>
>> Updated patch will be sent out later after review comments from other reviewers are addressed.
>>
>> Henry
>> -----Original Message-----
>> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> Sent: Tuesday, July 25, 2023 5:03 PM
>> To: Henry Shi <henryshi2018@gmail.com>; hbshi69@hotmail.com; tglx@linutronix.de; mingo@redhat.com; bp@alien8.de; dave.hansen@linux.intel.com; x86@kernel.org; hpa@zytor.com; hdegoede@redhat.com; markgross@kernel.org; jdelvare@suse.com; linux@roeck-us.net; linux-kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org; linux-hwmon@vger.kernel.org
>> Cc: hb_shi2003@yahoo.com; Huibin Shi <henrys@silicom-usa.com>; Wen Wang <wenw@silicom-usa.com>
>> Subject: Re: [PATCH] Add Silicom Platform Driver
>>
>> Caution: This is an external email. Please take care when clicking links or opening attachments.
>>
>>
>> Le 18/07/2023 à 18:01, Henry Shi a écrit :
>>> The Silicom platform (silicom-platform) Linux driver for Swisscom
>>> Business Box (Swisscom BB) as well as Cordoba family products is a
>>> software solution designed to facilitate the efficient management and
>>> control of devices through the integration of various Linux
>>> frameworks. This platform driver provides seamless support for device
>>> management via the Linux LED framework, GPIO framework, Hardware
>>> Monitoring (HWMON), and device attributes. The Silicom platform
>>> driver's compatibility with these Linux frameworks allows applications
>>> to access and control Cordoba family devices using existing software
>>> that is compatible with these frameworks. This compatibility
>>> simplifies the development process, reduces dependencies on
>>> proprietary solutions, and promotes interoperability with other
>>> Linux-based systems and software.
>>>
>>> Signed-off-by: Henry Shi <henryshi2018@gmail.com>
>>> ---
>>
>> [...]
>>
>>> +static int __init silicom_mc_leds_register(struct device *dev,
>>> +                                        const struct led_classdev_mc
>>> +*mc_leds) {
>>> +     struct led_classdev_mc *led;
>>> +     int i, err;
>>> +
>>> +     for (i = 0; mc_leds[i].led_cdev.name; i++) {
>>> +             /* allocate and copy data from the init constansts */
>>> +             led = devm_kzalloc(dev, sizeof(struct led_classdev_mc),
>>> + GFP_KERNEL);
>>
>> sizeof(*led) is shorter.
>> Mostly a matter of taste.
>>
>> Maybe even devm_kmemdup()?
>>
>> Henry: thanks. Devm_kmemdup() API requires additional argument that is not necessary of this driver. I prefer devm_kzalloc for now.
> 
> CJ: The only additionnal parameter I can think of are the one of memcpy() ...
> 
>>
>>> +             if (IS_ERR_OR_NULL(led)) {
>>
>> if (!led)
>> is enough.
>>
>> Henry: OK, changed
>>
>>> +                     dev_err(dev, "Failed to alloc
>>> + led_classdev_mc[%d]: %ld\n", i, PTR_ERR(led));
>>
>> This kind of message is useless and should be removed (checkpatch should warn about it)
>>
>> Henry: OK, removed.
>>
>>> +                     return -ENOMEM;
>>> +             }
>>> +             memcpy(led, &mc_leds[i], sizeof(*led));
> 
> ... here.
> 
> devm_kzalloc() + this memcpy() could be done with only devm_kmemdup().
> 
> This is mostly a matter of taste.
> 

I don't think that using (or not using) available API functions should
be a matter of taste, or the next step might be to re-implement memcpy().

Guenter

