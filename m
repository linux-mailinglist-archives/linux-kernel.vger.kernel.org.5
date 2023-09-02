Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2689E790A38
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 00:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbjIBW4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 18:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjIBW4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 18:56:17 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18BECFE;
        Sat,  2 Sep 2023 15:56:10 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-794d98181f0so13438839f.2;
        Sat, 02 Sep 2023 15:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693695370; x=1694300170; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=35GJbAnShkOAJqo1CTP2N6enDIoPtaIn3oN1m7gdCFc=;
        b=ov4lBf/ynhw9UYVZ/78Tw6PXsFaOdA5hpFjsIM1u7BoT3w2FHFcUyg5NgvLjAHoJJg
         I7AWDYKzt+i6SzndAu7BsVN59oLc1CKPHkjj8/IPLVfgYwDbGKF82DQBdD/XeROBQoH6
         Kwg9hUJct7INC9uUDs7tMICvH1W6/DOQu0gvV6Dd9XHKT8gnT+pEpyFjXtu/ikcdZD/S
         HY5OnG2BA2vtRkWjgsu5wHGTBQgTkTRC9ZMzaXOpuNwaY3lS24bB1NuK/OG/ws9Xu3W2
         W8SfQElm/09ZFhpJGp94kLOKqg/dXIgFBBifr7T1PHis2gxq9EkykHXW+9vLTqoUO1Xu
         Ibcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693695370; x=1694300170;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=35GJbAnShkOAJqo1CTP2N6enDIoPtaIn3oN1m7gdCFc=;
        b=WAYKvHZ81AZjyxxuZSflmDcuJtc9nIyLBQ2XM2NsjTR9MESGRSELQkv+O7q0otRbnQ
         Z8JUn6iDSY4X75FchOHUyc1K8irH85Z0rhmWSpQJufjCHyVoB1eAmBFQ9EukKpI/5nRu
         lMleqRb5+uduxnPN9fkjCE3qyHC3PJC182TVcPKqN9aGp0pTgcf7FRWGNRSA63lPZD3q
         gvx86Dc7PhDKYyCx1NCOiZxEQsJ1Mnr2LtP3YanHFYMC8OPZtaqnkIToiOikqUXP+nYx
         0DdEzBbmgIT4pXMLM4dli7cQCslW/X20DLI3BvCi9oRaeG6TOu+I/1t74C20RbS+qvTf
         IMgQ==
X-Gm-Message-State: AOJu0Yzw0KiYNKFcFZFpn3npUZaa2aNhukBNpSCIb5jvYhXQEQZCV8EA
        dtzc88bnKlO4y2Vdfk8HBCI=
X-Google-Smtp-Source: AGHT+IE1ezHY+cQEQmSx38PyIS0eu3c37AOCfDLzCSGvcciB1+b2iTUhkjLZ/iwxMCLZA/9zs55Lww==
X-Received: by 2002:a6b:6f15:0:b0:792:7f26:dc95 with SMTP id k21-20020a6b6f15000000b007927f26dc95mr6930506ioc.14.1693695369899;
        Sat, 02 Sep 2023 15:56:09 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k26-20020a6b401a000000b0077e3566a801sm2090433ioa.29.2023.09.02.15.56.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Sep 2023 15:56:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2776f856-94e4-1481-508a-db80db573be0@roeck-us.net>
Date:   Sat, 2 Sep 2023 15:56:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     dgilbert@interlog.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20230902-powerz-v4-1-7ec2c1440687@weissschuh.net>
 <36a3daf7-d519-7669-13bf-4c59c11c2b97@wanadoo.fr>
 <46d3194a-af79-4076-b0a2-561d713a406e@t-8ch.de>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v4] hwmon: add POWER-Z driver
In-Reply-To: <46d3194a-af79-4076-b0a2-561d713a406e@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/23 15:29, Thomas Weißschuh wrote:
> Hi,
> 
> On 2023-09-02 18:36:17+0200, Christophe JAILLET wrote:
>> Le 02/09/2023 à 09:47, Thomas Weißschuh a écrit :
>>> POWER-Z is a series of devices to monitor power characteristics of
>>> USB-C connections and display those on a on-device display.
>>> Some of the devices, notably KM002C and KM003C, contain an additional
>>> port which exposes the measurements via USB.
>>>
>>> This is a driver for this monitor port.
>>>
>>> It was developed and tested with the KM003C.
>>>
>>> Signed-off-by: Thomas Weißschuh <linux-9XfqOkM5JgxKQ7RDE2T8Pw@public.gmane.org>
>>> ---
>>
>> ...
>>
>>> +static int powerz_probe(struct usb_interface *intf,
>>> +			const struct usb_device_id *id)
>>> +{
>>> +	struct powerz_priv *priv;
>>> +	struct device *hwmon_dev;
>>> +	struct device *parent;
>>> +
>>> +	parent = &intf->dev;
>>> +
>>> +	priv = devm_kzalloc(parent, sizeof(*priv), GFP_KERNEL);
>>> +	if (!priv)
>>> +		return -ENOMEM;
>>> +
>>> +	priv->urb = usb_alloc_urb(0, GFP_KERNEL);
>>> +	if (!priv->urb)
>>> +		return -ENOMEM;
>>> +	mutex_init(&priv->mutex);
>>> +	priv->status = -ETIMEDOUT;
>>> +	init_completion(&priv->completion);
>>> +
>>> +	hwmon_dev =
>>> +	    devm_hwmon_device_register_with_info(parent, DRIVER_NAME, priv,
>>> +						 &powerz_chip_info, NULL);
>>> +	usb_set_intfdata(intf, priv);
>>> +
>>> +	return PTR_ERR_OR_ZERO(hwmon_dev);
>>
>> Hi,
>>
>> If 'hwmon_dev' is an PTR_ERR, priv->urb leaks.
> 
> Good catch, thanks!
> 
> 
> Guenter,
> 
> it seems the new hwmon-next with this driver has not yet been pushed to
> git.kernel.org, so I can't generate the Fixes tag.
> 

Rule is that I must not push anything into linux-next until
after v6.6-rc1 has been released.

> Can you modify the commit to also contain the changes below?
> Or let me know if you prefer something else.
> 

I'll update the patch and make the change.

Thanks,
Guenter

