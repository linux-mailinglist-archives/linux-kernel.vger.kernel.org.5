Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182947F8760
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 01:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjKYArW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 19:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjKYArT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 19:47:19 -0500
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031E91985;
        Fri, 24 Nov 2023 16:47:22 -0800 (PST)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id D87C112000E;
        Sat, 25 Nov 2023 03:47:19 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru D87C112000E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1700873239;
        bh=6bJkF32oXGL6h3vT0VPcxbn5F6XkTkolj869Hwu9IAo=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
        b=jOBTP6vm7jq/vrbXFxR3SRfgRRD1LEOadhXqTcaXjIcFSfeT3xYmXzbTjbaIU9RJP
         +pf//YUApXyKgZfCXSyH5YPUvukjcCqvGR+7jusQgXM/gaJooMadj9SMZX3K4Uwsx0
         j6L4lJMBjaDjh5T3I3G58nfC5nVKBDyAfA2pP1AaNVRwabq/Dt/wXbDN7RrDyxY7Yt
         750g9ll/Lr0yRA3Yciv7W+AQYKhRS1OaAwrS+fhsfOOiqZLMrtF0BATi0IV/LZ3gAM
         wEIttU13X4X0IxeLXHcIjWjwpW1LXxU2wbNScuqewB+NNdxK8/a+bMXAo/TXisH1ME
         +3awVh4GErP3w==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Sat, 25 Nov 2023 03:47:18 +0300 (MSK)
Received: from [192.168.1.127] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 25 Nov 2023 03:47:18 +0300
Message-ID: <13cd5524-0d40-4f07-b542-002b79b37533@salutedevices.com>
Date:   Sat, 25 Nov 2023 03:47:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] devm_led_classdev_register() usage problem
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
CC:     <pavel@ucw.cz>, <lee@kernel.org>, <vadimp@nvidia.com>,
        <mpe@ellerman.id.au>, <npiggin@gmail.com>,
        <christophe.leroy@csgroup.eu>, <linux-leds@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        "jic23@kernel.org" <jic23@kernel.org>, <kernel@salutedevices.com>
References: <20231025130737.2015468-1-gnstark@salutedevices.com>
 <ZWDBOfpsC5AVT8bX@smile.fi.intel.com>
From:   George Stark <gnstark@salutedevices.com>
In-Reply-To: <ZWDBOfpsC5AVT8bX@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181590 [Nov 24 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 4 0.3.4 720d3c21819df9b72e78f051e300e232316d302a, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;www.spinics.net:7.1.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/11/24 23:41:00
X-KSMG-LinksScanning: Clean, bases: 2023/11/24 23:41:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/24 22:14:00 #22527410
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andy

Thanks for the review.

On 11/24/23 18:28, Andy Shevchenko wrote:
> On Wed, Oct 25, 2023 at 04:07:29PM +0300, George Stark wrote:
>> Lots of drivers use devm_led_classdev_register() to register their led objects
>> and let the kernel free those leds at the driver's remove stage.
>> It can lead to a problem due to led_classdev_unregister()
>> implementation calls led_set_brightness() to turn off the led.
>> led_set_brightness() may call one of the module's brightness_set callbacks.
>> If that callback uses module's resources allocated without using devm funcs()
>> then those resources will be already freed at module's remove() callback and
>> we may have use-after-free situation.
>>
>> Here is an example:
>>
>> module_probe()
>> {
>>      devm_led_classdev_register(module_brightness_set_cb);
>>      mutex_init(&mutex);
>> }
>>
>> module_brightness_set_cb()
>> {
>>      mutex_lock(&mutex);
>>      do_set_brightness();
>>      mutex_unlock(&mutex);
>> }
>>
>> module_remove()
>> {
>>      mutex_destroy(&mutex);
>> }
>>
>> at rmmod:
>> module_remove()
>>      ->mutex_destroy(&mutex);
>> devres_release_all()
>>      ->led_classdev_unregister();
>>          ->led_set_brightness();
>>              ->module_brightness_set_cb();
>>                   ->mutex_lock(&mutex);  /* use-after-free */
>>
>> I think it's an architectural issue and should be discussed thoroughly.
>> Some thoughts about fixing it as a start:
>> 1) drivers can use devm_led_classdev_unregister() to explicitly free leds before
>> dependend resources are freed. devm_led_classdev_register() remains being useful
>> to simplify probe implementation.
>> As a proof of concept I examined all drivers from drivers/leds and prepared
>> patches where it's needed. Sometimes it was not as clean as just calling
>> devm_led_classdev_unregister() because several drivers do not track
>> their leds object at all - they can call devm_led_classdev_register() and drop the
>> returned pointer. In that case I used devres group API.
>>
>> Drivers outside drivers/leds should be checked too after discussion.
>>
>> 2) remove led_set_brightness from led_classdev_unregister() and force the drivers
>> to turn leds off at shutdown. May be add check that led's brightness is 0
>> at led_classdev_unregister() and put a warning to dmesg if it's not.
>> Actually in many cases it doesn't really need to turn off the leds manually one-by-one
>> if driver shutdowns whole led controller. For the last case to disable the warning
>> new flag can be brought in e.g LED_AUTO_OFF_AT_SHUTDOWN (similar to LED_RETAIN_AT_SHUTDOWN).
> 
> NAK.
> 
> Just fix the drivers by wrapping mutex_destroy() into devm, There are many
> doing so. You may be brave enough to introduce devm_mutex_init() somewhere
> in include/linux/device*
> 

Just one thing about mutex_destroy(). It seems like there's no single 
opinion on should it be called in 100% cases e.g. in remove() paths.
For example in iio subsystem Jonathan suggests it can be dropped in 
simple cases: https://www.spinics.net/lists/linux-iio/msg73423.html

So the question is can we just drop mutex_destroy() in module's remove() 
callback here if that mutex is needed for devm subsequent callbacks?

-- 
Best regards
George
