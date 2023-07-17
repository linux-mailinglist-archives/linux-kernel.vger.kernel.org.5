Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAE5756713
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjGQPDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjGQPDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:03:03 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B1AB9;
        Mon, 17 Jul 2023 08:03:02 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b89d47ffb6so24997405ad.2;
        Mon, 17 Jul 2023 08:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689606181; x=1692198181;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZHqJrkmtDswIsjlMcdZq22dzszSmSwDk8/wNYIYi+70=;
        b=afJTzRLO9V6t0Lirw7J7nwtH2DID5MFA9N4H/cD+cDOQFzVtNr3dakW1mfdWRC9MSz
         f8pf/GL7wBomoYtzzEFsqScTiyLPSv4JM+kqmTFhG1D94blG9yjSAj68Mi074qaLlbST
         PIFFkKbNjz+u3x0nkPirO9RdHHYyfdnP3t5wyIRosh0JcM02CNL7MWLWJf9dnSYgRxHc
         2TwRtWKtOZLbWGxaB2L+anpcAAz8yvdUE2vKmNoAJdJ5XDY7V+eE49FZ3UbzwrLCJovg
         jT+/RWl+XOARyxK3BrtiikTibmTwvLmdZsGVI7pstuIj7meXFkHTX/mpalC0ekND6iKr
         BSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689606181; x=1692198181;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHqJrkmtDswIsjlMcdZq22dzszSmSwDk8/wNYIYi+70=;
        b=Q6VS7IcSbkt7cN2yneyY2QheGj9TshnTQZGp0nW+izeI+Uw3TXk4bKC29fytFbsiNx
         o7X69pL7WMsQdwR7O8ra4yYjDpgrEE/oD7kzdJjii25nQifDYAJvrJ2gb8Z3hG3h1W7J
         Y/jKLxFYB6bmV4f5K2GqUTnIKyjMbR+p/5g05Eb2MiYN+xnq6Dnj6Nn0NdPPfNeHDn/t
         cs46VVtlPdeDftLqOlrztu7Jo9qM6XTM9uABR1bHTxp7WsFIXEUsvSUDjRRHzhIkSc4w
         eAUZbWYhwccna6ZlDoXU1nwUJrzkAm9LRRtn3ORvL8QWbSsiKSzGpnfCfBRJCRQm09F6
         SLRg==
X-Gm-Message-State: ABy/qLabsO2au2PmaXr29EhC5wUlqdlqC8zE1ot3tGXnG4waZWR26ctK
        Fe3JPt7gVCIdxUxvzKRSA+lhhLDvcmY=
X-Google-Smtp-Source: APBJJlEur6epoP3Py26emMND6bS/Fs7JkbcSrttix5WAbUIxPTizBVeSGz4w34c8AKhvvYR9rt2Ogg==
X-Received: by 2002:a17:903:482:b0:1b8:a2af:fe23 with SMTP id jj2-20020a170903048200b001b8a2affe23mr8731004plb.2.1689606181061;
        Mon, 17 Jul 2023 08:03:01 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u7-20020a170902b28700b001b9e59d6ddesm7132plr.124.2023.07.17.08.02.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 08:03:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <89c6c7e8-0407-b6bb-7085-be11efce2524@roeck-us.net>
Date:   Mon, 17 Jul 2023 08:02:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Joaqu=c3=adn_Ignacio_Aramend=c3=ada?= 
        <samsagax@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230717124013.38796-2-samsagax@gmail.com>
 <20230717124013.38796-5-samsagax@gmail.com>
 <2023071739-remedy-sloping-64f6@gregkh>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 3/3] hwmon: (oxp-sensors) Refactor init() and remove
 probe()
In-Reply-To: <2023071739-remedy-sloping-64f6@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/23 06:45, Greg KH wrote:
> On Mon, Jul 17, 2023 at 09:40:06AM -0300, Joaquín Ignacio Aramendía wrote:
>> Since the driver is not hotpluggable the probe() funtion is not used
>> more than once.
>>
>> Move all attribute registration logic to the init() function.
> 
> Again, as in patch 2/3, you forgot a signed-off-by line.
> 
> But this change isn't correct, just because a device is not
> hotpluggable, does not mean it should not be using probe/release, in
> fact just the opposite, it should be using that and NOT init.
> 
> But I understand why you changed the init call in patch 2/3, that is ok,
> this isn't because:
> 
>> ---
>>   drivers/hwmon/oxp-sensors.c | 33 ++++++++++++++++-----------------
>>   1 file changed, 16 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
>> index c70d9355eeba..39de49c8a392 100644
>> --- a/drivers/hwmon/oxp-sensors.c
>> +++ b/drivers/hwmon/oxp-sensors.c
>> @@ -431,32 +431,20 @@ static const struct hwmon_chip_info oxp_ec_chip_info = {
>>   	.info = oxp_platform_sensors,
>>   };
>>   
>> -/* Initialization logic */
>> -static int oxp_platform_probe(struct platform_device *pdev)
>> -{
>> -	const struct dmi_system_id *dmi_entry;
>> -	struct device *dev = &pdev->dev;
>> -	struct device *hwdev;
>> -
>> -	hwdev = devm_hwmon_device_register_with_info(dev, "oxpec", NULL,
>> -						     &oxp_ec_chip_info, NULL);
>> -
>> -	return PTR_ERR_OR_ZERO(hwdev);
>> -}
>> -
>>   static struct platform_driver oxp_platform_driver = {
>>   	.driver = {
>>   		.name = "oxp-platform",
>>   		.dev_groups = oxp_ec_groups,
>>   	},
>> -	.probe = oxp_platform_probe,
>>   };
>>   
>>   static struct platform_device *oxp_platform_device;
>>   
>> +/* Initialization logic */
>>   static int __init oxp_platform_init(void)
>>   {
>>   	const struct dmi_system_id *dmi_entry;
>> +	struct device *hwdev;
>>   
>>   	/*
>>   	 * Have to check for AMD processor here because DMI strings are the
>> @@ -472,10 +460,21 @@ static int __init oxp_platform_init(void)
>>   	board = (enum oxp_board)(unsigned long)dmi_entry->driver_data;
>>   
>>   	oxp_platform_device =
>> -		platform_create_bundle(&oxp_platform_driver,
>> -				       oxp_platform_probe, NULL, 0, NULL, 0);
>> +		platform_create_bundle(&oxp_platform_driver, NULL, NULL, 0,
>> +				       NULL, 0);
>> +	if (IS_ERR(oxp_platform_device))
>> +		return PTR_ERR(oxp_platform_device);
>>   
>> -	return PTR_ERR_OR_ZERO(oxp_platform_device);
>> +	hwdev = devm_hwmon_device_register_with_info(&oxp_platform_device->dev,
>> +						     "oxpec", NULL,
>> +						     &oxp_ec_chip_info, NULL);
> 
> You are creating a fake platform device out of no where here, which is
> tied to nothing, which isn't ok.  Keep it in the proper device tree and
> have it be passed to you by the driver core in the probe() function.
> 

This is a system with dmi data, so it won't support devicetree. Other
than that, you are correct, this patch is definitely not a good idea
and needs to be dropped.

Thanks,
Guenter

> I think you will see that this changed where in /sys/devices/ your
> device is now, right?
> 
> 
>> +	if (IS_ERR(hwdev)) {
>> +		platform_device_unregister(oxp_platform_device);
> 
> Making fake platform devices is generally never a good idea, please
> don't do that.
> 
> thanks,
> 
> greg k-h

