Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80407797F3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 21:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236633AbjHKTwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 15:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235310AbjHKTwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 15:52:11 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3566330F8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 12:52:11 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fe1b6192e8so5793865e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 12:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691783530; x=1692388330;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ON/u0bhlC72ppMqjVy8/h0+Dm4Dg9ro/m8Iwk+XtJkM=;
        b=KX1yRCwyxCeqJGxB8jZV97Ofcp7sA2pyDo22YzDjzLKEt4I+Os/Wuz5BUyJW9DAW4V
         fwVZSkoSY6VRG4U6PXOrUXhLLmVWUO6wKzwaN0g4ZpdbAWgZVm26wUMnAtBZ8lSAUwNf
         KI5VOVaf5GkpV/X2cfHRAHO78PecWF5O8XQD9COInYq19QBtngGW4/IVrwgLksn266yU
         4qJbhWbjXseitrrsW1MwkhM5IV4LYma+OzC/Ep6tH80Xi6GOJZ5XrqX0TNHap2oCW0Ep
         G9qNxtGs/TtUvuvOJZZuNEsfAAZ7EXZd7utqVS++UNP6VNLCM4fD+JSMI7ZaZyFKjd8b
         yzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691783530; x=1692388330;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ON/u0bhlC72ppMqjVy8/h0+Dm4Dg9ro/m8Iwk+XtJkM=;
        b=SSWldVgQ9zMAf8qI4I6ynJWZgBoWFrx/wLWzwfPNXuGiIdF0rMCR6x+Nu46uc6JdQi
         +BCXTX1k6Gy14QtlJEGjgVqNd/+EWLNCbD4QCPLpb6r43udkfo/qBM9iqU1JEUlae1nJ
         558TigtTogTlZR+n2wLRwkVIyUWSGTclwZlojBTuGFhIOnM1t5x53rPHSMoPLk9qFNog
         yVsheIcBMM8LxQIYDeui7nLhfvB5Ptac9sXQR4FXK/kyQmGIZOjbqq3QH8oDdC9eKJDF
         uzVwCcINjzVkn3F2PJbPtXxVl7yJf5BKxtLqZdvbIMJDwQSbrwrOaRN/6mnjjX2PDxcc
         nrwQ==
X-Gm-Message-State: AOJu0YzgHaXpdWv1UNYBDoHpEWSXGKG0tlRYoRexTelXRBdco1A19Pff
        bxqtlpWKvrrfA1fV1/Lr10leX/qTg1nMnQ==
X-Google-Smtp-Source: AGHT+IFoYS+IYTt+1sMDHt30IilI1G1Ft9KL2NXN0rRts3a9OoE5ym8+w/GlkkIc1yVuuBIOHGBLtg==
X-Received: by 2002:a05:600c:4216:b0:3fb:3dd9:89c with SMTP id x22-20020a05600c421600b003fb3dd9089cmr2447450wmh.0.1691783529398;
        Fri, 11 Aug 2023 12:52:09 -0700 (PDT)
Received: from [192.168.10.215] ([141.136.93.153])
        by smtp.gmail.com with ESMTPSA id t25-20020a1c7719000000b003fe4ca8decdsm9006648wmi.31.2023.08.11.12.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 12:52:09 -0700 (PDT)
Message-ID: <d3080712-d7ca-c227-df42-7b8da877d015@gmail.com>
Date:   Fri, 11 Aug 2023 23:52:07 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] mei: make mei_class a static const structure
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     tomas.winkler@intel.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
References: <20230810194652.27004-1-ivan.orlov0322@gmail.com>
 <2023081112-wistful-coping-f775@gregkh>
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <2023081112-wistful-coping-f775@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/23 23:40, Greg KH wrote:
> On Thu, Aug 10, 2023 at 11:46:52PM +0400, Ivan Orlov wrote:
>> Now that the driver core allows for struct class to be in read-only
>> memory, move the mei_class structure to be declared at build time
>> placing it into read-only memory, instead of having to be dynamically
>> allocated at boot time.
>>
>> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
>> ---
>>   drivers/misc/mei/main.c | 19 ++++++++++---------
>>   1 file changed, 10 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
>> index 51876da3fd65..902789d3106b 100644
>> --- a/drivers/misc/mei/main.c
>> +++ b/drivers/misc/mei/main.c
>> @@ -27,7 +27,9 @@
>>   #include "mei_dev.h"
>>   #include "client.h"
>>   
>> -static struct class *mei_class;
>> +static const struct class mei_class = {
>> +	.name = "mei",
>> +};
>>   static dev_t mei_devt;
> 
> Extra line after the new structure?
> 
>>   #define MEI_MAX_DEVS  MINORMASK
>>   static DEFINE_MUTEX(mei_minor_lock);
>> @@ -1115,7 +1117,7 @@ void mei_set_devstate(struct mei_device *dev, enum mei_dev_state state)
>>   
>>   	dev->dev_state = state;
>>   
>> -	clsdev = class_find_device_by_devt(mei_class, dev->cdev.dev);
>> +	clsdev = class_find_device_by_devt(&mei_class, dev->cdev.dev);
>>   	if (clsdev) {
>>   		sysfs_notify(&clsdev->kobj, NULL, "dev_state");
>>   		put_device(clsdev);
>> @@ -1232,7 +1234,7 @@ int mei_register(struct mei_device *dev, struct device *parent)
>>   		goto err_dev_add;
>>   	}
>>   
>> -	clsdev = device_create_with_groups(mei_class, parent, devno,
>> +	clsdev = device_create_with_groups(&mei_class, parent, devno,
>>   					   dev, mei_groups,
>>   					   "mei%d", dev->minor);
>>   
>> @@ -1264,7 +1266,7 @@ void mei_deregister(struct mei_device *dev)
>>   
>>   	mei_dbgfs_deregister(dev);
>>   
>> -	device_destroy(mei_class, devno);
>> +	device_destroy(&mei_class, devno);
>>   
>>   	mei_minor_free(dev);
>>   }
>> @@ -1274,10 +1276,9 @@ static int __init mei_init(void)
>>   {
>>   	int ret;
>>   
>> -	mei_class = class_create("mei");
>> -	if (IS_ERR(mei_class)) {
>> +	ret = class_register(&mei_class);
>> +	if (ret) {
>>   		pr_err("couldn't create class\n");
> 
> This message doesn't make sense anymore.  No need for it either, just
> remove it and do a simple:
> 		return err;
> here instead.
> 
> thanks,
> 
> greg k-h


Hi Greg,

Thank you for the review, I'll make the suggested changes and send you 
the V2.

--
Kind regards,
Ivan Orlov
