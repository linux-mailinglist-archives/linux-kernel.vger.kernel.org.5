Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141027D0269
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 21:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346491AbjJSTYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 15:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345878AbjJSTYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 15:24:48 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB86DFA;
        Thu, 19 Oct 2023 12:24:43 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id BE787120010;
        Thu, 19 Oct 2023 22:24:40 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru BE787120010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1697743480;
        bh=Be562JGzGP+YllgBYA33JVdRpjxpxaXZ55LIwLAl360=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
        b=irFZvzH6HXUa4cY+msgQFg/kkD1srYMLIg5ybWJT94PFOf7i7evlioUluKkGEurty
         VGoVYyUXfYmG887hV9ijni6+PFHiSTOuMOuwJx31h0VWIuGlylS/YZiihvYQOGU8Sz
         FCqY6cxKLNLjgkSgGCRwnMv/M1fm6vuD41Odf31tqVeh+bqI+u5TNdtMnS0R/Us4xe
         OIhlrbGPS3E2ez26MpLozRmSENxB/nzWkPZ9hxqrpz34LB7XwehXcs17/mc1ZhI7il
         +bkaJf/5BC+sef+J+J4TbI8upnoGxcXvL5T4qh6JKuRt13qXL/2c/XoO17E21A3X0H
         tkPZ18Q4gTBTA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Thu, 19 Oct 2023 22:24:40 +0300 (MSK)
Received: from [192.168.1.127] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 19 Oct 2023 22:24:40 +0300
Message-ID: <24ab7656-4358-9cca-0c3e-8f47a3468ef5@salutedevices.com>
Date:   Thu, 19 Oct 2023 22:25:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 04/11] leds: aw200xx: calculate dts property
 display_rows in driver
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Dmitry Rokosov <ddrokosov@salutedevices.com>
CC:     <lee@kernel.org>, <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>
References: <20231018182943.18700-1-ddrokosov@salutedevices.com>
 <20231018182943.18700-5-ddrokosov@salutedevices.com>
 <CAHp75VeTVU-1mSzAX4j7s9bbDGxDR_FwgFL7dnC4_6OhsN8kpw@mail.gmail.com>
From:   George Stark <gnstark@salutedevices.com>
In-Reply-To: <CAHp75VeTVU-1mSzAX4j7s9bbDGxDR_FwgFL7dnC4_6OhsN8kpw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180745 [Oct 19 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 542 542 3d23828e213bab96daa5e52f9cef518f74e40214, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/10/19 17:46:00 #22233982
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andy

On 10/19/23 12:01, Andy Shevchenko wrote:
> On Wed, Oct 18, 2023 at 9:30 PM Dmitry Rokosov
> <ddrokosov@salutedevices.com> wrote:
>>
>> From: George Stark <gnstark@salutedevices.com>
>>
>> Get rid of device tree property "awinic,display-rows" and calculate it
>> in driver using led definition nodes. display-row actually means number
>> of current switches and depends on how leds are connected to the device.
> 
> Still the commit message does not answer the question why it's safe
> for the users that have this property enabled in their DTBs (note B
> letter).
> 


> ...
> 
>> +       device_for_each_child_node(dev, child) {
>> +               u32 source;
>> +               int ret;
>> +
>> +               ret = fwnode_property_read_u32(child, "reg", &source);
>> +               if (ret || source >= chip->cdef->channels)
> 
> Perhaps a warning?
> 
>      dev_warn(dev, "Unable to read from %pfw or apply a source channel
> number\n", child);

I skipped the warning intentionally because we have just the same loop 
several steps below and with the same check. There we have all proper 
warnings and aw200xx_probe_get_display_rows was intended to be short and 
lightweight. I'll redesign it to be even more simple.

> 
>> +                       continue;
>> +
>> +               max_source = max(max_source, source);
>> +       }
> 
> ...
> 
>> +       chip->display_rows = max_source / chip->cdef->display_size_columns + 1;
>> +       if (!chip->display_rows) {
>> +               dev_err(dev, "No valid led definitions found\n");
>> +               return -EINVAL;
> 
> So, this part is in ->probe() flow only, correct? If so,
>    return dev_err_probe(...);
> 
>> +       }
> 
> ...
> 
>> +       if (aw200xx_probe_get_display_rows(dev, chip))
>> +               return -EINVAL;
> 
> Why is the error code shadowed?
> 

-- 
Best regards
George
