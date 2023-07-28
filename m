Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D781576729A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjG1Q7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjG1Q7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:59:50 -0400
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E270AE47
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:59:45 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id PQcJquo3y6LOdPQcJq6tXb; Fri, 28 Jul 2023 18:47:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1690562831;
        bh=j/7aKHnWITVgoZ/UNzvyxCcfFQnF58gRdXlJW5zlNSM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=bVNuVfMew/ZG1k8SfRJox25DBH4WnyOEvUZd2GUrGCIM/q1tWtGFcPyAUeuCig43c
         ZHD5QYOC/CoQhTRY5IumE/ZuCmQcdDZ4E+brZ5Z1KF/KEu3Hxnyxu44j3tznKOIHTZ
         5al5JCfNJk7qdx789ylDq+nsLNcx2PYSpao1lR5wqDp6SY/pU+woIokU+5PwUNyIpC
         k8T/76BzBfUpxt2r6/ncPW4ag9ERqENXIOjAi74vP3RNbODbO4bbyOsDmYRmYYMC48
         ggjAVZNPWTwxbKutxzej6Z7sh/Org/G1I0T4KaEQXQQkXgtMf+ZT6nXT0vh+455+Ns
         fgPMJiWjLhH2Q==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 28 Jul 2023 18:47:11 +0200
X-ME-IP: 86.243.2.178
Message-ID: <08469a96-24f2-2099-0a0a-019cb81f976b@wanadoo.fr>
Date:   Fri, 28 Jul 2023 18:47:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: RE: [PATCH] Add Silicom Platform Driver
To:     Huibin Shi <henrys@silicom-usa.com>,
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
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Cc:     "hb_shi2003@yahoo.com" <hb_shi2003@yahoo.com>,
        Wen Wang <wenw@silicom-usa.com>
References: <20230718160104.2716-1-henryshi2018@gmail.com>
 <fb62b2e7-7c7c-dc2e-768d-3393f151eb32@wanadoo.fr>
 <PA4PR04MB92225B65A45868A9CBE25B999A06A@PA4PR04MB9222.eurprd04.prod.outlook.com>
Content-Language: fr, en-US
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <PA4PR04MB92225B65A45868A9CBE25B999A06A@PA4PR04MB9222.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 28/07/2023 à 14:59, Huibin Shi a écrit :
> Christophe,
> 
> Thanks for the comments. See my comments below.
> 
> Updated patch will be sent out later after review comments from other reviewers are addressed.
> 
> Henry
> -----Original Message-----
> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Sent: Tuesday, July 25, 2023 5:03 PM
> To: Henry Shi <henryshi2018@gmail.com>; hbshi69@hotmail.com; tglx@linutronix.de; mingo@redhat.com; bp@alien8.de; dave.hansen@linux.intel.com; x86@kernel.org; hpa@zytor.com; hdegoede@redhat.com; markgross@kernel.org; jdelvare@suse.com; linux@roeck-us.net; linux-kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org; linux-hwmon@vger.kernel.org
> Cc: hb_shi2003@yahoo.com; Huibin Shi <henrys@silicom-usa.com>; Wen Wang <wenw@silicom-usa.com>
> Subject: Re: [PATCH] Add Silicom Platform Driver
> 
> Caution: This is an external email. Please take care when clicking links or opening attachments.
> 
> 
> Le 18/07/2023 à 18:01, Henry Shi a écrit :
>> The Silicom platform (silicom-platform) Linux driver for Swisscom
>> Business Box (Swisscom BB) as well as Cordoba family products is a
>> software solution designed to facilitate the efficient management and
>> control of devices through the integration of various Linux
>> frameworks. This platform driver provides seamless support for device
>> management via the Linux LED framework, GPIO framework, Hardware
>> Monitoring (HWMON), and device attributes. The Silicom platform
>> driver's compatibility with these Linux frameworks allows applications
>> to access and control Cordoba family devices using existing software
>> that is compatible with these frameworks. This compatibility
>> simplifies the development process, reduces dependencies on
>> proprietary solutions, and promotes interoperability with other
>> Linux-based systems and software.
>>
>> Signed-off-by: Henry Shi <henryshi2018@gmail.com>
>> ---
> 
> [...]
> 
>> +static int __init silicom_mc_leds_register(struct device *dev,
>> +                                        const struct led_classdev_mc
>> +*mc_leds) {
>> +     struct led_classdev_mc *led;
>> +     int i, err;
>> +
>> +     for (i = 0; mc_leds[i].led_cdev.name; i++) {
>> +             /* allocate and copy data from the init constansts */
>> +             led = devm_kzalloc(dev, sizeof(struct led_classdev_mc),
>> + GFP_KERNEL);
> 
> sizeof(*led) is shorter.
> Mostly a matter of taste.
> 
> Maybe even devm_kmemdup()?
> 
> Henry: thanks. Devm_kmemdup() API requires additional argument that is not necessary of this driver. I prefer devm_kzalloc for now.

CJ: The only additionnal parameter I can think of are the one of 
memcpy() ...

> 
>> +             if (IS_ERR_OR_NULL(led)) {
> 
> if (!led)
> is enough.
> 
> Henry: OK, changed
> 
>> +                     dev_err(dev, "Failed to alloc
>> + led_classdev_mc[%d]: %ld\n", i, PTR_ERR(led));
> 
> This kind of message is useless and should be removed (checkpatch should warn about it)
> 
> Henry: OK, removed.
> 
>> +                     return -ENOMEM;
>> +             }
>> +             memcpy(led, &mc_leds[i], sizeof(*led));

... here.

devm_kzalloc() + this memcpy() could be done with only devm_kmemdup().

This is mostly a matter of taste.

>> +
>> +             led->subled_info = devm_kzalloc(dev, led->num_colors * sizeof(struct mc_subled),
>> +                                             GFP_KERNEL);
> 
> Maybe even devm_kmemdup()?

Same...

> 
>> +             if (IS_ERR_OR_NULL(led->subled_info)) {
> 
> if (!led->subled_info)
> is enough.
> 
> Henry: OK, changed.
> 
>> +                     dev_err(dev, "Failed to alloc subled_info[%d]: %ld\n",
>> +                             i, PTR_ERR(led->subled_info));
> 
> This kind of message is useless and should be removed (checkpatch should warn about it)
> 
> Henry: OK, removed.
> 
>> +                     return -ENOMEM;
>> +             }
>> +             memcpy(led->subled_info, mc_leds[i].subled_info,
>> +                     led->num_colors * sizeof(struct mc_subled));

... here.

CJ


