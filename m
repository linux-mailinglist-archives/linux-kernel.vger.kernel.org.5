Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF1A7D7B20
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 04:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbjJZC5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 22:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjJZC5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 22:57:24 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0E3194;
        Wed, 25 Oct 2023 19:57:18 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Vuw6fix_1698289034;
Received: from 30.97.48.63(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vuw6fix_1698289034)
          by smtp.aliyun-inc.com;
          Thu, 26 Oct 2023 10:57:15 +0800
Message-ID: <e8833e78-8678-e2fc-9de1-0b2531e179e1@linux.alibaba.com>
Date:   Thu, 26 Oct 2023 10:57:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V2 5/6] pinctrl: sprd: Increase the range of register
 values
To:     xu lh <xulh0829@gmail.com>
Cc:     Linhua Xu <Linhua.xu@unisoc.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhirong Qiu <zhirong.qiu@unisoc.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
References: <20230908055146.18347-1-Linhua.xu@unisoc.com>
 <20230908055146.18347-6-Linhua.xu@unisoc.com>
 <c714149e-9a54-40c1-fd55-bf2297eebe17@linux.alibaba.com>
 <CAPjKKSrs9X2msnDg=9rC8H57Dq8FPd7SWyBsr2MCwL0FMNkHPA@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAPjKKSrs9X2msnDg=9rC8H57Dq8FPd7SWyBsr2MCwL0FMNkHPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/2023 7:29 PM, xu lh wrote:
> On Tue, Sep 12, 2023 at 4:37 PM Baolin Wang <baolin.wang@linux.alibaba.com>
> wrote:
> 
>>
>>
>> On 9/8/2023 1:51 PM, Linhua Xu wrote:
>>> From: Linhua Xu <Linhua.Xu@unisoc.com>
>>>
>>> As the UNISOC pin controller version iterates, more registers are
>> required
>>> to meet new functional requirements. Thus modify them.
>>>
>>> Signed-off-by: Linhua Xu <Linhua.Xu@unisoc.com>
>>> ---
>>>    drivers/pinctrl/sprd/pinctrl-sprd.h | 30 +++++++++++++++--------------
>>>    1 file changed, 16 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/pinctrl/sprd/pinctrl-sprd.h
>> b/drivers/pinctrl/sprd/pinctrl-sprd.h
>>> index a696f81ce663..5357874186fd 100644
>>> --- a/drivers/pinctrl/sprd/pinctrl-sprd.h
>>> +++ b/drivers/pinctrl/sprd/pinctrl-sprd.h
>>> @@ -7,30 +7,32 @@
>>>    #ifndef __PINCTRL_SPRD_H__
>>>    #define __PINCTRL_SPRD_H__
>>>
>>> +#include <linux/bits.h>
>>> +
>>>    struct platform_device;
>>>
>>> -#define NUM_OFFSET   (20)
>>> -#define TYPE_OFFSET  (16)
>>> -#define BIT_OFFSET   (8)
>>> -#define WIDTH_OFFSET (4)
>>> +#define NUM_OFFSET   22
>>> +#define TYPE_OFFSET  18
>>> +#define BIT_OFFSET   10
>>> +#define WIDTH_OFFSET 6
>>>
>>>    #define SPRD_PIN_INFO(num, type, offset, width, reg)        \
>>> -             (((num) & 0xFFF) << NUM_OFFSET |        \
>>> -              ((type) & 0xF) << TYPE_OFFSET |        \
>>> -              ((offset) & 0xFF) << BIT_OFFSET |      \
>>> -              ((width) & 0xF) << WIDTH_OFFSET |      \
>>> -              ((reg) & 0xF))
>>> +             (((num) & GENMASK(10, 0)) << NUM_OFFSET |       \
>>> +              ((type) & GENMASK(3, 0)) << TYPE_OFFSET |      \
>>> +              ((offset) & GENMASK(7, 0)) << BIT_OFFSET |     \
>>> +              ((width) & GENMASK(3, 0)) << WIDTH_OFFSET |    \
>>> +              ((reg) & GENMASK(5, 0)))
>>
>> Can you define some readable macro for the mask bits?
> 
> 
>>> okay. Do you think the following modification is okay?
> +#define PIN_ID         GENMASK(10, 0)
> +#define PIN_TYPE       GENMASK(3, 0)
> +#define FIELD_OFFSET   GENMASK(7, 0)
> +#define FIELD_WIDTH    GENMASK(3, 0)
> +#define PIN_REG                GENMASK(5, 0)

Looks better. To keep consistent, I perfer to something as below:
#define NUM_MASK xxx
#define TYPE_MASK xxx
#define BIT_MASK xxx
#define WIDTH_MASK xxx
#define REG_MASK xxx
