Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4833790597
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 08:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351662AbjIBGdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 02:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjIBGdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 02:33:23 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F125D10FB;
        Fri,  1 Sep 2023 23:33:17 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.66])
        by gateway (Coremail) with SMTP id _____8CxRugq1_JktvgdAA--.7874S3;
        Sat, 02 Sep 2023 14:33:14 +0800 (CST)
Received: from [10.20.42.66] (unknown [10.20.42.66])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxXSMp1_Jkrn9pAA--.39724S3;
        Sat, 02 Sep 2023 14:33:13 +0800 (CST)
Subject: Re: [PATCH v2] dt-bindings: interrupt-controller: loongson,liointc:
 Fix warnings about liointc-2.0
To:     Binbin Zhou <zhoubb.aaron@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        loongson-kernel@lists.loongnix.cn, devicetree@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, diasyzhang@tencent.com,
        linux-kernel@vger.kernel.org
References: <20230821061315.3416836-1-zhoubinbin@loongson.cn>
 <e62185ca-cdf6-bde9-ad46-f4150db9ed6d@linaro.org>
 <CAMpQs4JhfuB4=s9VFc+xmw_+8h5u2EwPdM_0x2vO_=SYabAAxw@mail.gmail.com>
 <6ba31912-6738-6156-d5f4-3c8d3a3ca7bc@linaro.org>
 <CAMpQs4+GiExt9uMmV1pf8gg8rFwWxbLkx9mdW7hY9xxXDOza3Q@mail.gmail.com>
 <d11873a1-b552-71f5-1100-7464687f8bb4@linaro.org>
 <a084e6e9-46b0-42ef-b500-69c114ae11b2@flygoat.com>
 <3412e871-ae2b-bed0-88fb-2272f9db3af0@linaro.org>
 <a3e934eb-7517-f313-46d9-fd5335ce305e@flygoat.com>
 <CAMpQs4L0DYxoqQbpi7WeNMBf9g+58L2=D6BXrKbSUqJQEEKZLQ@mail.gmail.com>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <3ed7bddd-2c86-90e0-a8bf-0b322bb92bd9@loongson.cn>
Date:   Sat, 2 Sep 2023 14:32:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAMpQs4L0DYxoqQbpi7WeNMBf9g+58L2=D6BXrKbSUqJQEEKZLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8BxXSMp1_Jkrn9pAA--.39724S3
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Aw1rXFykuw13JFWkWFyrZrc_yoW8Xw1rpr
        WrGas0kr4DZF4vv3WxX3yFkas0qr93ArZrKrn8G34DZan8CFyjqFs8Kr1rZrn8uw4xuw42
        qFWvk3W8G3yrCFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
        8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67
        AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIY
        rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
        v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2-VyUU
        UUU
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each IRQ source of liointc may be routed to different IRQ source of 
cpuintc, for implementing this, bit mapping between liointc and cpuintc 
is required, and the mapping information is used for liointc IRQ routing 
register setting. It seems that interrupt-map can not pass the mapping 
to driver in current driver/of code,  so the mapping is used in a 
non-standard way(of cause, underscore style may be changed in dts and 
driver).

IMO, hardcode routing completely in driver is not flexible and not 
recommended, and if possible, keep current map unchanged please.

Jianmin

Thanks.

On 2023/8/31 上午9:47, Binbin Zhou wrote:
> cc Jianmin Lv.
>
> Hi all:
>
> Jianmin knows Loongson interrupt controllers well, he may have other
> suggestions.
>
> Thanks.
> Binbin
>
> On Wed, Aug 30, 2023 at 11:31 PM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>>
>>
>> 在 2023/8/30 22:35, Krzysztof Kozlowski 写道:
>>>> What's the best way, in your opinion, to overhaul this property? As we don't
>>>> really care backward compatibility of DTBs on those systems we can just
>>>> redesign it.
>>> Deprecate the property in the bindings, allow driver to work with or
>>> without it and finally drop it entirely from DTS.
>> I'd love to have such configuration flexibility so I'd be sad to see it go.
>> + Huacai and Binbin, what's your opinion?
>>
>> If dropping such functionality in kernel is a must go, we can hardcode
>> to route all downstream interrupt to the first pin that passed to DT.
>>
>> Thanks
>> - Jiaxun
>>> Best regards,
>>> Krzysztof
>>>

