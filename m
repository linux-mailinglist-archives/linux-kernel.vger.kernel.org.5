Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869FF8130AD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573170AbjLNM6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573145AbjLNM6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:58:54 -0500
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0696C115;
        Thu, 14 Dec 2023 04:58:59 -0800 (PST)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 800CC100003;
        Thu, 14 Dec 2023 15:58:57 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 800CC100003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1702558737;
        bh=qT3NzId9fi7gmTS3Fcf9+Cs1PZA1K9YzCqSJ9uxx38Q=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
        b=Ek9YRb2aOBKfbyNT8dPviIM17sArXdb//XeAW4uWF/jbQerBn0Hrn015WcZkbPLk4
         Z64taz/9B/4eLYvqH+gX7EoAOJbiASIjrbfZstXDcZCMkAHRBi5G5g3eWuCyfr5SUi
         EqO0XvfBeOnOVrE9PvxyeSol2ZZEsBRYZTWPlQ63r1sFXTcLe6TWytHZY2boAc7DNu
         Uf3KaaEyhp05NzMFcbev0aQnYC4HWk5KRTSt13YZ8ctfa42ZvXMRK4+WnygGmSKA6Y
         76mZixR8TmA3SGQ6q19FnjY7Ot2SBlDbry5jwAQgHnBwRaWx1qW5IfZ2Ao/iXTiR0U
         uDNX/8cgwNUrA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Thu, 14 Dec 2023 15:58:57 +0300 (MSK)
Received: from [192.168.1.143] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Dec 2023 15:58:57 +0300
Message-ID: <fa048fec-86f2-42b5-ad36-7776c569a349@salutedevices.com>
Date:   Thu, 14 Dec 2023 15:58:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/11] leds: aw2013: use devm API to cleanup module's
 resources
Content-Language: en-US
To:     Nikita Travkin <nikita@trvn.ru>
CC:     <andy.shevchenko@gmail.com>, <pavel@ucw.cz>, <lee@kernel.org>,
        <vadimp@nvidia.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
        <christophe.leroy@csgroup.eu>, <hdegoede@redhat.com>,
        <mazziesaccount@gmail.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <will@kernel.org>, <longman@redhat.com>,
        <boqun.feng@gmail.com>, <nikitos.tr@gmail.com>,
        <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <kernel@salutedevices.com>
References: <20231213223020.2713164-1-gnstark@salutedevices.com>
 <20231213223020.2713164-5-gnstark@salutedevices.com>
 <c709e0f33da06db40127f3a0adcbebbd@trvn.ru>
From:   George Stark <gnstark@salutedevices.com>
In-Reply-To: <c709e0f33da06db40127f3a0adcbebbd@trvn.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 182110 [Dec 14 2023]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;100.64.160.123:7.1.2;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/12/14 10:50:00 #22693095
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

Hello Nikita

Thanks for the review and testing.

On 12/14/23 08:42, Nikita Travkin wrote:
> George Stark писал(а) 14.12.2023 03:30:
>> In this driver LEDs are registered using devm_led_classdev_register()
>> so they are automatically unregistered after module's remove() is done.
>> led_classdev_unregister() calls module's led_set_brightness() to turn off
>> the LEDs and that callback uses resources which were destroyed already
>> in module's remove() so use devm API instead of remove().
>>
>> Signed-off-by: George Stark <gnstark@salutedevices.com>
> 
> Thanks for noticing and fixing this!
> Perhaps this patch needs a Fixes tag too, like 1/11?

This patch and the rest of the series depend on new feature 
devm_mutex_init and if I add Fixes tag this feature will need to be 
backported too along with fixes. I'm not sure it's desirable.

> 
> Tested-by: Nikita Travkin <nikita@trvn.ru>
> 
> Btw, seems like (5..11)/11 never arrived to the lists...

Yeah there was a delay, but now all patches from series #3 are online.
> 
> Nikita
> 
>> ---
...

-- 
Best regards
George
