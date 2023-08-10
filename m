Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C77776E9C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 05:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbjHJDf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 23:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjHJDf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 23:35:27 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 863F71FF7;
        Wed,  9 Aug 2023 20:35:24 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.201])
        by gateway (Coremail) with SMTP id _____8BxpPD6WtRkbVgUAA--.43993S3;
        Thu, 10 Aug 2023 11:35:22 +0800 (CST)
Received: from [10.20.42.201] (unknown [10.20.42.201])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxPCP5WtRkr2NSAA--.56418S3;
        Thu, 10 Aug 2023 11:35:21 +0800 (CST)
Subject: Re: [PATCH v3 1/2] gpio: dt-bindings: add parsing of loongson gpio
 offset
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230807074043.31288-1-zhuyinbo@loongson.cn>
 <20230807074043.31288-2-zhuyinbo@loongson.cn>
 <91f57b0d-a6e9-c039-40b6-0a1a9af5f7a0@linaro.org>
 <78c5a043-3e2a-48d6-88bd-2f91cc6d1347@loongson.cn>
 <f9a8897e-301e-9d69-be59-a5aa9290f01b@linaro.org>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <36dd6038-933d-1513-1426-9c1283f3cbf8@loongson.cn>
Date:   Thu, 10 Aug 2023 11:35:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <f9a8897e-301e-9d69-be59-a5aa9290f01b@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxPCP5WtRkr2NSAA--.56418S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/8/9 下午9:00, Krzysztof Kozlowski 写道:
> On 09/08/2023 09:28, Yinbo Zhu wrote:
>>>
>>>>      - gpio-ranges
>>>>      - interrupts
>>>>    
>>>> @@ -49,11 +82,16 @@ examples:
>>>>        #include <dt-bindings/interrupt-controller/irq.h>
>>>>    
>>>>        gpio0: gpio@1fe00500 {
>>>> -      compatible = "loongson,ls2k-gpio";
>>>> +      compatible = "loongson,ls2k1000-gpio";
>>>>          reg = <0x1fe00500 0x38>;
>>>>          ngpios = <64>;
>>>>          #gpio-cells = <2>;
>>>>          gpio-controller;
>>>> +      loongson,gpio-conf-offset = <0>;
>>>> +      loongson,gpio-in-offset = <0x20>;
>>>> +      loongson,gpio-out-offset = <0x10>;
>>>> +      loongson,gpio-ctrl-mode = <0>;
>>>> +      loongson,gpio-inten-offset = <0x30>;
>>>
>>> I still think that you just embed the programming model into properties,
>>> instead of using dedicated compatible for different blocks. It could be
>>> fine, although I would prefer to check it with your DTS
>>
>> Okay, I got it,  and if I understand correctly, you seem to agree with
>> me adding attributes like this.
>>
>> And, if using this method that programming model into dts properites,
>> then when adding a new platform's GPIO,  there is no longer a need to
>> modify the driver because gpio controller is compatible and different
>> platform can use a same compatible.
> 
> Uhu, so there we are. You use this method now to avoid new compatibles.
> No, therefore I do not agree.


I don't seem to got it, if the GPIO controllers of two platforms are
compatible, shouldn't they use the same compatible?

> 
>>
>>>
>>> Where is your DTS?
>>
>>
>> Sorry, the dts containing gpio nodes are only available in the product
>> code and have not been sent to the community yet.
> 
> Does not help to convince us, but it is your right. With this and above
> explanation, my answer is no - NAK.


The community work for DTS on the 2K platform is still ongoing. Do I
need to add a GPIO DTS node based on the following DTS to request your
review?  so that you can more conveniently review whether my patch is
suitable.

2k1000
https://lore.kernel.org/all/99bdbfc66604b4700e3e22e28c3d27ef7c9c9af7.1686882123.git.zhoubinbin@loongson.cn/

2k500
https://lore.kernel.org/all/c7087046a725e7a2cfde788185112c150e216f1b.1686882123.git.zhoubinbin@loongson.cn/

2k2000
https://lore.kernel.org/all/977009099c38177c384fca5a0ee77ebbe50e3ea2.1686882123.git.zhoubinbin@loongson.cn/


Thanks,
Yinbo

