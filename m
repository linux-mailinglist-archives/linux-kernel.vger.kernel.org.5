Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69A977B034
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 05:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbjHNDju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 23:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbjHNDjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 23:39:16 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 75795E75;
        Sun, 13 Aug 2023 20:39:14 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.201])
        by gateway (Coremail) with SMTP id _____8AxlPDhodlk8OMXAA--.49462S3;
        Mon, 14 Aug 2023 11:39:13 +0800 (CST)
Received: from [10.20.42.201] (unknown [10.20.42.201])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx7yPgodlkB01ZAA--.48709S3;
        Mon, 14 Aug 2023 11:39:12 +0800 (CST)
Subject: Re: [PATCH v3 1/2] gpio: dt-bindings: add parsing of loongson gpio
 offset
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Conor Dooley <conor@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230807074043.31288-1-zhuyinbo@loongson.cn>
 <20230807074043.31288-2-zhuyinbo@loongson.cn>
 <20230808-amount-urban-9a6eb09852ca@spud>
 <536a9062-65b2-5518-5c50-1a61e23870ee@loongson.cn>
 <20230809-circus-photo-6911d2e18f96@spud>
 <d4e16768-bed0-beda-42c3-f0a01b7e96cc@loongson.cn>
 <CAMRc=Mc00yy6DxdEos_w7HAkAwH7j0HBvkbQbaQiA_wTXiwFUg@mail.gmail.com>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <80325b72-e7b3-08cc-f726-513de75de94c@loongson.cn>
Date:   Mon, 14 Aug 2023 11:39:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAMRc=Mc00yy6DxdEos_w7HAkAwH7j0HBvkbQbaQiA_wTXiwFUg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx7yPgodlkB01ZAA--.48709S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/8/11 下午10:25, Bartosz Golaszewski 写道:
> On Thu, Aug 10, 2023 at 8:19 AM Yinbo Zhu <zhuyinbo@loongson.cn> wrote:
>>
>>
>>
>> 在 2023/8/9 下午11:39, Conor Dooley 写道:
>>> On Wed, Aug 09, 2023 at 03:47:55PM +0800, Yinbo Zhu wrote:
>>>> 在 2023/8/8 下午8:05, Conor Dooley 写道:
>>>>> On Mon, Aug 07, 2023 at 03:40:42PM +0800, Yinbo Zhu wrote:
>>>
>>>>>> +  loongson,gpio-ctrl-mode:
>>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>>> +    description:
>>>>>> +      This option indicate this GPIO control mode, where '0' represents
>>>>>> +      bit control mode and '1' represents byte control mode.
>>>>>
>>>>> How is one supposed to know which of these modes to use?
>>>>
>>>>
>>>> Byte mode is to access by byte, such as gpio3, the base address of the
>>>> gpio controller is offset by 3 bytes as the access address of gpio3.
>>>>
>>>> The bit mode is the normal mode that like other platform gpio and it is
>>>> to access by bit.
>>>>
>>>> If both modes are supported, it is recommended to prioritize using byte
>>>> mode that according to spec.
>>>
>>> So, sounds like this property should instead be a boolean that notes
>>> whether the hardware supports the mode or not, rather than the current
>>> enum used to determine software policy.
>>
>>
>> okay, I got it, I will use boolean,
>>
> 
> Why do you want to put it into device-tree so badly? This is not the
> first driver that would have of_match_data for different variants
> where you can have a structure that would keep offsets for different
> models. It's not like you will have hundreds of "compatible" chips
> anyway, most likely just a few?


Using this ways that put offset property into device-tree that can be
compatible with future GPIO chips without the need to modify drivers,
such as more 2K chips in the future, but use of_match_data and data
field of_device_id, which every time a new SoC is released, the GPIO
driver needs to be modified once, which is not friendly to us.

Thanks,
Yinbo

