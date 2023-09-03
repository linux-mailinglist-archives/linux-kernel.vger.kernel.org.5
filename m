Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8DF790BAA
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 13:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236663AbjICLq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 07:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjICLq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 07:46:57 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B2F11A;
        Sun,  3 Sep 2023 04:46:53 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso433805a12.1;
        Sun, 03 Sep 2023 04:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693741613; x=1694346413; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=2LypU5GSb/5xrBeSN38szQSr44gNgGcSYviD7xvx9mo=;
        b=cNPpCJjRHq3qcceuA4je81mgM9DReB1cLlhFqtYYb0i/wHWhdG6RIjO1MfXrspCD+i
         q1ncaO2W4Z483NLBvLBNKLkXm4PFz0jEHfSb01KaP/0qNd+/Mg6fMXeefmdIUzZzlN3w
         6966cGDFHyNXZ7qZBnAikDeng6G6BehaEAnaUoi8U6eSJt//826yi33qTgPtNWPlJMhs
         0a9iydaZR4cs/VEZ/WX2BBaw48di6A+Sluasxm35dvEmIC2baMW8G4rm9h7+GnpotWRm
         xh3jJODNOLRfM9f8mYwEchc+60C/GMMTqpXfRWylKHvYPO9SHjTZHP+xrnEY+udG+YMJ
         ijmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693741613; x=1694346413;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2LypU5GSb/5xrBeSN38szQSr44gNgGcSYviD7xvx9mo=;
        b=YSRNaAfM52KYFmc6ldEEs5J8KZ5Hfk+ziHXJlByx5s7b5xzjePZSueR4ak/rETAfCf
         xoOYPZ+bUxSuuzg6hhwWqwInqjuf5jdhRW/6uEYE419M+zIfVTXkDzFi3YYiCX3/ILpG
         h940NgL2Mco+VSwWhky5VJm686WEelAMUvnCWpRRJUy/F1NInVnKZhloJBoJ/3Eg0Xzi
         VVTn7fFvaGKN04b4IWiT5wdnYrWJzKsGMQ6dFLhTkbN7/weW7Gbcm8jIjFC0wAS4zGZT
         PjYdX3QUF8+pBNFdZUlZsMZiokQxWPLtKQkAWMC4BLWisPFb6TK4WRr4wM8z/6t6Iiey
         5rSw==
X-Gm-Message-State: AOJu0YzoGG3/purvf7bRZJa1rtuD866/Y0AW1wCQ13Ikg06PTLQEfmeF
        XymdULAHlmMjjHdmSq+ILFc=
X-Google-Smtp-Source: AGHT+IGekt8ho0aAPwahya8w6Nh7WewIKbiP7Q0IEe6ccqXTtgd85PJFKCrErfLuUYO8fwTIlz78lw==
X-Received: by 2002:a17:902:8b8b:b0:1bb:d048:3173 with SMTP id ay11-20020a1709028b8b00b001bbd0483173mr7739267plb.61.1693741612789;
        Sun, 03 Sep 2023 04:46:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id jg7-20020a17090326c700b001bc87e6e26bsm5784198plb.222.2023.09.03.04.46.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Sep 2023 04:46:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9151ab86-305e-9bb3-ee46-bfa8fd998c12@roeck-us.net>
Date:   Sun, 3 Sep 2023 04:46:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4] hwmon: add POWER-Z driver
Content-Language: en-US
To:     dgilbert@interlog.com,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20230902-powerz-v4-1-7ec2c1440687@weissschuh.net>
 <36a3daf7-d519-7669-13bf-4c59c11c2b97@wanadoo.fr>
 <46d3194a-af79-4076-b0a2-561d713a406e@t-8ch.de>
 <2776f856-94e4-1481-508a-db80db573be0@roeck-us.net>
 <290ebce4-54f0-8ac1-2a13-cbc806d80d64@interlog.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <290ebce4-54f0-8ac1-2a13-cbc806d80d64@interlog.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/23 22:54, Douglas Gilbert wrote:
> On 2023-09-02 18:56, Guenter Roeck wrote:
>> On 9/2/23 15:29, Thomas Weißschuh wrote:
>>> Hi,
>>>
>>> On 2023-09-02 18:36:17+0200, Christophe JAILLET wrote:
>>>> Le 02/09/2023 à 09:47, Thomas Weißschuh a écrit :
>>>>> POWER-Z is a series of devices to monitor power characteristics of
>>>>> USB-C connections and display those on a on-device display.
>>>>> Some of the devices, notably KM002C and KM003C, contain an additional
>>>>> port which exposes the measurements via USB.
>>>>>
>>>>> This is a driver for this monitor port.
>>>>>
>>>>> It was developed and tested with the KM003C.
>>>>>
>>>>> Signed-off-by: Thomas Weißschuh <linux-9XfqOkM5JgxKQ7RDE2T8Pw@public.gmane.org>
>>>>> ---
>>>>
>>>> ...
>>>>
>>>>> +static int powerz_probe(struct usb_interface *intf,
>>>>> +            const struct usb_device_id *id)
>>>>> +{
>>>>> +    struct powerz_priv *priv;
>>>>> +    struct device *hwmon_dev;
>>>>> +    struct device *parent;
>>>>> +
>>>>> +    parent = &intf->dev;
>>>>> +
>>>>> +    priv = devm_kzalloc(parent, sizeof(*priv), GFP_KERNEL);
>>>>> +    if (!priv)
>>>>> +        return -ENOMEM;
>>>>> +
>>>>> +    priv->urb = usb_alloc_urb(0, GFP_KERNEL);
>>>>> +    if (!priv->urb)
>>>>> +        return -ENOMEM;
>>>>> +    mutex_init(&priv->mutex);
>>>>> +    priv->status = -ETIMEDOUT;
>>>>> +    init_completion(&priv->completion);
>>>>> +
>>>>> +    hwmon_dev =
>>>>> +        devm_hwmon_device_register_with_info(parent, DRIVER_NAME, priv,
>>>>> +                         &powerz_chip_info, NULL);
>>>>> +    usb_set_intfdata(intf, priv);
>>>>> +
>>>>> +    return PTR_ERR_OR_ZERO(hwmon_dev);
>>>>
>>>> Hi,
>>>>
>>>> If 'hwmon_dev' is an PTR_ERR, priv->urb leaks.
>>>
>>> Good catch, thanks!
>>>
>>>
>>> Guenter,
>>>
>>> it seems the new hwmon-next with this driver has not yet been pushed to
>>> git.kernel.org, so I can't generate the Fixes tag.
>>>
>>
>> Rule is that I must not push anything into linux-next until
>> after v6.6-rc1 has been released.
>>
>>> Can you modify the commit to also contain the changes below?
>>> Or let me know if you prefer something else.
>>>
>>
>> I'll update the patch and make the change.
> 
> Hi,
> While you are at it, you can make the driver detect the earlier model KM002C:
> 

Please send a separate patch to do that.

Thanks,
Guenter

> --- powerz.c_orig    2023-09-02 13:47:14.754705791 -0400
> +++ powerz.c    2023-09-02 23:22:54.783856587 -0400
> @@ -250,6 +250,7 @@
> 
>   static const struct usb_device_id powerz_id_table[] = {
>       { USB_DEVICE_INTERFACE_NUMBER(0x5FC9, 0x0063, 0x00) },    /* ChargerLAB POWER-Z KM003C */
> +    { USB_DEVICE_INTERFACE_NUMBER(0x5FC9, 0x0061, 0x00) },    /* ChargerLAB POWER-Z KM002C */
>       { }
>   };
> 
> Do you want a "Tested-by" on the patch as well?
> 
> Doug Gilbert
> 
> 

