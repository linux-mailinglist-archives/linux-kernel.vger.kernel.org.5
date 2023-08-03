Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAAF76E4CC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbjHCJnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbjHCJnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:43:25 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E5F8B3595;
        Thu,  3 Aug 2023 02:42:41 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.201])
        by gateway (Coremail) with SMTP id _____8CxruuAdstkxJ4PAA--.33645S3;
        Thu, 03 Aug 2023 17:42:24 +0800 (CST)
Received: from [10.20.42.201] (unknown [10.20.42.201])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxPCOAdstknQFHAA--.33675S3;
        Thu, 03 Aug 2023 17:42:24 +0800 (CST)
Subject: Re: [PATCH v2 1/2] gpio: dt-bindings: add parsing of loongson gpio
 offset
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     Conor Dooley <conor@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230801-whenever-imitation-b2759b212f6b@spud>
 <a5c27913-2a88-d376-0130-22ca8a3d4516@loongson.cn>
 <20230801-varsity-chemo-09cc5e250ded@spud>
 <26adb487-f8c5-9cf4-5b31-070e9161e761@loongson.cn>
 <20230802-jailer-pavilion-84fb17bb3710@wendy>
 <3534f7b9-0e02-28c1-238a-5a6fdbb95e94@loongson.cn>
 <20230802-bunkbed-siamese-57ee53bdf273@wendy>
 <db7012b2-9156-34ed-ad1f-10a3e5dfe390@loongson.cn>
 <20230802-empathy-wound-70df4990a976@spud>
 <ae74e7b0-26ae-5707-7b85-5dcf733d2bed@loongson.cn>
 <20230803-tartar-tainted-968687047460@wendy>
 <ca969933-c7f8-a727-3c7e-5ec3548862a0@linaro.org>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <7db5af37-47d5-9bcd-2798-7124438316c1@loongson.cn>
Date:   Thu, 3 Aug 2023 17:42:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ca969933-c7f8-a727-3c7e-5ec3548862a0@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxPCOAdstknQFHAA--.33675S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/8/3 下午2:41, Krzysztof Kozlowski 写道:
> On 03/08/2023 08:30, Conor Dooley wrote:
>>>>>                   gpio0:gpio@0x1fe10430 {
>>>>>                           compatible = "loongson,ls2k-gpio";
>>>>>                           reg = <0 0x1fe10430 0 0x20>;
>>>>>                           gpio-controller;
>>>>>                           #gpio-cells = <2>;
>>>>> 			interrupt-parent = <&liointc1>;
>>>>>                           ngpios = <64>;
>>>>>                           loongson,gpio-conf-offset = <0>;
>>>>>                           loongson,gpio-out-offset = <0x10>;
>>>>>                           loongson,gpio-in-offset = <0x8>;
>>>>>                           loongson,gpio-inten-offset = <0xb0>;
>>>>> 			loongson,gpio-ctrl-mode = <0x0>;
>>>>>                           ...
>>>>> 		  }
>>>>>
>>>>>                   gpio1:gpio@0x1fe10450 {
>>>>>                           compatible = "loongson,ls2k-gpio";
>>>>>                           reg = <0 0x1fe10450 0 0x20>;
>>>>>                           gpio-controller;
>>>>>                           #gpio-cells = <2>;
>>>>> 			interrupt-parent = <&liointc1>;
>>>>>                           ngpios = <64>;
>>>>>                           loongson,gpio-conf-offset = <0>;
>>>>>                           loongson,gpio-out-offset = <0x10>;
>>>>>                           loongson,gpio-in-offset = <0x8>;
>>>>
>>>> These 3 are the same for both controllers, no?
>>>> Is only the inten-offset a variable?
>>>>
>>>>>                           loongson,gpio-inten-offset = <0x98>;
>>>>
>>>> These offsets exceed the region that you've got in the reg property for
>>>> this controller, do they not?
>>>>
>>>> Is there some sort of "miscellaneous register area" at 0x1FE104E0, or
>>>> just those two interrupt registers and nothing else?
>>>
>>>
>>> 2k500 gpio dts is just an example, like 3a5000, or more other platform,
>>> above offset was different but the gpio controller was compatible.
>>>
>>>                  gpio: gpio@1fe00500 {
>>>                          compatible = "loongson,ls2k-gpio";
>>>                          reg = <0 0x1fe00500 0xc00>;
>>>                          gpio-controller;
>>>                          #gpio-cells = <2>;
>>>                          ngpios = <16>;
>>>                          loongson,gpio-conf-offset = <0x0>;
>>>                          loongson,gpio-out-offset = <0x8>;
>>>                          loongson,gpio-in-offset = <0xc>;
>>> 			...
>>> 			}
>>
>> That is a different SoC and needs to have a different compatible string.
>> "loongson,ls2k-foo" compatible strings were a mistake that only got past
>> us because we were not aware it was a family, rather than a specific
>> SoC. They certainly should not be used in isolation on a 3a5000!
>>
>> Are there more than one GPIO controllers on the 3a5000? If so, what do
>> those nodes look like.
> 
> Eh, even for the same SoC having different offsets suggest that
> programming model is a bit different. Anyway, who designed such
> hardware? Really?


Hi Krzysztof & Conor,

I'm sorry for the confusion caused to you, such as 2k2000, which has two
gpio controllers with different register offsets.  The gpio node is
following:

         pioA: gpio0@0x1fe00500 {
             compatible = "loongson,ls2k-gpio";
             reg = <0 0x1fe00500 0 0x20>;
             gpio-controller;
             #gpio-cells = <2>;
             ngpios = <32>;
             loongson,gpio-ctrl-mode = <0>;
             loongson,gpio-conf-offset = <0>;
             loongson,gpio-in-offset = <0xc>;
             loongson,gpio-out-offset = <0x8>;
         };

         pioB: gpio1@0x100e0000 {
             compatible = "loongson,ls2k-gpio";
             reg = <0 0x100e0000 0 0x20>;
             gpio-controller;
             #gpio-cells = <2>;
             ngpios = <64>;
             loongson,gpio-ctrl-mode = <0>;
             loongson,gpio-conf-offset = <0>;
             loongson,gpio-in-offset = <0x20>;
             loongson,gpio-out-offset = <0x10>;
         };


In addition, the GPIO controllers between different SoCs are compatible
except for offset, previously, the examples of 3a5000 and 2k0500 gpio
were listed, Of course, it also includes 2k1000, which gpio chip was
compatible but offset was different.

About the "loongson,ls2k-foo" compatible strings were a mistake that I
got it and I will add a specific SoC  "loongson,ls2k1000-foo" compatible
, but from previous community communication, it seems that if different
SoC peripherals are compatible, they can use the same compatible string.

Thanks,
Yinbo

