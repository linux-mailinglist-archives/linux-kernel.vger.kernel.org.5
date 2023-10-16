Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402627CB6FE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 01:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbjJPXaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 19:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbjJPXaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 19:30:12 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929D392;
        Mon, 16 Oct 2023 16:30:09 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id A66EB120005;
        Tue, 17 Oct 2023 02:30:05 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru A66EB120005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1697499005;
        bh=zD1Tf1IUoIfxanKeL4xArFVYvOpIBhWtdn1cF1qPX+U=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
        b=Rlpu6FiQV6G/ituo61toc105IfKD7lddxrIYrRDu6HmjClMW/VR6Wp4ZUufTE+pRy
         ENAVcYHtmE1uQOICYi5OU+jfDK856f6Jm09Ciz3AQbN1E1RZxKFhJC74LCyn560L/Y
         wr8XA/XtXWCNf2Gb118b/Irm9YWZugHkAuKXsEhDYsVaB9+fnChkocpPUyZvYTmTFO
         PpMkQoqiM/xva+bHyRq5jYgxdb8PA+h8QL3oDhFt+h0rjZwVKLCEqUsWHOzzXWdVe4
         ifi20BzDRwjZCS22DJBtWHjk3C9p1Fs/wQEQ4JfxwemTp/QoWT6O0kQjiTKgNodWg5
         +Obu3fitPT7sA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Tue, 17 Oct 2023 02:30:04 +0300 (MSK)
Received: from [192.168.1.127] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 17 Oct 2023 02:30:04 +0300
Message-ID: <00715fd2-a866-9589-cfe1-d93fd6f9ed49@salutedevices.com>
Date:   Tue, 17 Oct 2023 02:30:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 05/11] leds: aw200xx: calculate dts property
 display_rows in driver
Content-Language: en-US
To:     Dmitry Rokosov <ddrokosov@salutedevices.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     <lee@kernel.org>, <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>
References: <20231006160437.15627-1-ddrokosov@salutedevices.com>
 <20231006160437.15627-6-ddrokosov@salutedevices.com>
 <CAHp75VeWwzg1spSvQ1tNmC7zVN1FLOjcpRGZsoL-49Di02pn0g@mail.gmail.com>
 <20231009132055.kg2gbbznr63plvm4@CAB-WSD-L081021>
From:   George Stark <gnstark@salutedevices.com>
In-Reply-To: <20231009132055.kg2gbbznr63plvm4@CAB-WSD-L081021>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180654 [Oct 16 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 540 540 2509a3fe0f7fdc802e7154a32be7c2dd394ab987, p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;100.64.160.123:7.1.2;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/10/16 22:35:00 #22205315
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andy

On 10/9/23 16:20, Dmitry Rokosov wrote:
> On Fri, Oct 06, 2023 at 08:59:46PM +0300, Andy Shevchenko wrote:
>> On Fri, Oct 6, 2023 at 7:05 PM Dmitry Rokosov
>> <ddrokosov@salutedevices.com> wrote:
>>>
>>> From: George Stark <gnstark@salutedevices.com>
>>>
>>> Get rid of device tree property "awinic,display-rows" and calculate it
>>> in driver using led definition nodes. display-row actually means number
>>> of current switches and depends on how leds are connected to the device.
>>
>> So, how do we know that there will be no regressions on the systems
>> where this property is used in production?

There're two possible cases here if "awinic,display-rows" value is not 
equal to autocalculated value which is incorrect way of using the driver:

1) "awinic,display-rows" value was less then autocalculated value - it 
means that some leds never couldn't be turned on even if they are 
defined in dts. Now all defined leds can be controlled.

2)"awinic,display-rows" value was higher then autocalculated value -
it means that leds refresh cycle time was greater then it really needed 
due to controller spent time powering unconnected pins. It will affect 
leds' current but I consider it a kind of hack - the driver provides 
means to control current.

> 
> In the production boards, developers should set up the display-rows
> correctly; otherwise, the AW200XX LED controller will not function
> properly. In the new implementation, we calculate display-rows
> automatically, and I assume that the value will remain unchanged.
> 
>>> +               if (max_source < source)
>>> +                       max_source = source;
>>
>> max()  (will need minmax.h)?
> 
> Correct, I will fix it in the v2.
> 

-- 
Best regards
George
