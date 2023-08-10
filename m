Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F29777031
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 08:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjHJGUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 02:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbjHJGT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 02:19:59 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A88A9E52;
        Wed,  9 Aug 2023 23:19:56 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.201])
        by gateway (Coremail) with SMTP id _____8DxxPCLgdRkC3AUAA--.44963S3;
        Thu, 10 Aug 2023 14:19:55 +0800 (CST)
Received: from [10.20.42.201] (unknown [10.20.42.201])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxWM2JgdRkdZlSAA--.11579S3;
        Thu, 10 Aug 2023 14:19:54 +0800 (CST)
Subject: Re: [PATCH v3 1/2] gpio: dt-bindings: add parsing of loongson gpio
 offset
To:     Conor Dooley <conor@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
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
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <d4e16768-bed0-beda-42c3-f0a01b7e96cc@loongson.cn>
Date:   Thu, 10 Aug 2023 14:19:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230809-circus-photo-6911d2e18f96@spud>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxWM2JgdRkdZlSAA--.11579S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/8/9 下午11:39, Conor Dooley 写道:
> On Wed, Aug 09, 2023 at 03:47:55PM +0800, Yinbo Zhu wrote:
>> 在 2023/8/8 下午8:05, Conor Dooley 写道:
>>> On Mon, Aug 07, 2023 at 03:40:42PM +0800, Yinbo Zhu wrote:
> 
>>>> +  loongson,gpio-ctrl-mode:
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>> +    description:
>>>> +      This option indicate this GPIO control mode, where '0' represents
>>>> +      bit control mode and '1' represents byte control mode.
>>>
>>> How is one supposed to know which of these modes to use?
>>
>>
>> Byte mode is to access by byte, such as gpio3, the base address of the
>> gpio controller is offset by 3 bytes as the access address of gpio3.
>>
>> The bit mode is the normal mode that like other platform gpio and it is
>> to access by bit.
>>
>> If both modes are supported, it is recommended to prioritize using byte
>> mode that according to spec.
> 
> So, sounds like this property should instead be a boolean that notes
> whether the hardware supports the mode or not, rather than the current
> enum used to determine software policy.


okay, I got it, I will use boolean,

Thanks,
Yinbo.



