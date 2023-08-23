Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99AD9784F63
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 05:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbjHWDhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 23:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbjHWDhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 23:37:50 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E777CF2;
        Tue, 22 Aug 2023 20:37:47 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.201])
        by gateway (Coremail) with SMTP id _____8Cx5_EJf+VkghYbAA--.55289S3;
        Wed, 23 Aug 2023 11:37:45 +0800 (CST)
Received: from [10.20.42.201] (unknown [10.20.42.201])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxLCMJf+VkcfJgAA--.20593S3;
        Wed, 23 Aug 2023 11:37:45 +0800 (CST)
Subject: Re: [PATCH v3 1/2] gpio: dt-bindings: add parsing of loongson gpio
 offset
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@longson.cn
References: <20230807074043.31288-1-zhuyinbo@loongson.cn>
 <20230807074043.31288-2-zhuyinbo@loongson.cn>
 <20230808-amount-urban-9a6eb09852ca@spud>
 <536a9062-65b2-5518-5c50-1a61e23870ee@loongson.cn>
 <20230809-circus-photo-6911d2e18f96@spud>
 <d4e16768-bed0-beda-42c3-f0a01b7e96cc@loongson.cn>
 <CAMRc=Mc00yy6DxdEos_w7HAkAwH7j0HBvkbQbaQiA_wTXiwFUg@mail.gmail.com>
 <80325b72-e7b3-08cc-f726-513de75de94c@loongson.cn>
 <CACRpkdam7zxSSj3Lirha8tWdeM_WhZpD4xO7MbTK4hVumU0a8w@mail.gmail.com>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <26da9608-98f9-a679-2888-ce82093db2b1@loongson.cn>
Date:   Wed, 23 Aug 2023 11:37:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdam7zxSSj3Lirha8tWdeM_WhZpD4xO7MbTK4hVumU0a8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxLCMJf+VkcfJgAA--.20593S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/8/15 下午4:59, Linus Walleij 写道:
> On Mon, Aug 14, 2023 at 5:39 AM Yinbo Zhu <zhuyinbo@loongson.cn> wrote:
> 
>>> Why do you want to put it into device-tree so badly? This is not the
>>> first driver that would have of_match_data for different variants
>>> where you can have a structure that would keep offsets for different
>>> models. It's not like you will have hundreds of "compatible" chips
>>> anyway, most likely just a few?
>>
>> Using this ways that put offset property into device-tree that can be
>> compatible with future GPIO chips without the need to modify drivers,
>> such as more 2K chips in the future, but use of_match_data and data
>> field of_device_id, which every time a new SoC is released, the GPIO
>> driver needs to be modified once, which is not friendly to us.
> 
> The purpose of device tree is to describe the hardware and
> to configure it for a target system.
> 
> The purpose of device tree is not to make driver writing easy
> or convenient. It often does, but that is not the purpose.
> 
> These offsets are not relevant to the people that need to
> author and maintain device trees to support and tailor their
> system. They are only relevant to driver authors and SoC
> manufacturers.
> 
> What about just writing these offsets into the driver and use
> the compatible match to look them up.
> 


okay, I got it, I had following your advice and send v4 to upstream,
please you help review it.

Thanks,
Yinbo

