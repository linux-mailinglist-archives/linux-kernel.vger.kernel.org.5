Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96D677B31D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 09:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbjHNH5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 03:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234391AbjHNH5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 03:57:24 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A5D4B5;
        Mon, 14 Aug 2023 00:57:21 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.201])
        by gateway (Coremail) with SMTP id _____8Bx5fBg3tlkIwkYAA--.49714S3;
        Mon, 14 Aug 2023 15:57:20 +0800 (CST)
Received: from [10.20.42.201] (unknown [10.20.42.201])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx3yNd3tlkmZxZAA--.49687S3;
        Mon, 14 Aug 2023 15:57:18 +0800 (CST)
Subject: Re: [PATCH v6 1/2] soc: dt-bindings: add loongson-2 pm
To:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        soc@kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, loongarch@lists.linux.dev,
        Liu Yun <liuyun@loongson.cn>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        zhuyinbo@loongson.cn
References: <20230803063703.5659-1-zhuyinbo@loongson.cn>
 <20230803063703.5659-2-zhuyinbo@loongson.cn>
 <193f9138-57e0-4d4b-8225-54d38be9bfbc@app.fastmail.com>
 <8efeac46-ebb7-fa05-3d88-7c21acd59c8b@loongson.cn>
 <6d7335b4-63e2-4a7e-9620-8a0012558dfd@app.fastmail.com>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <0616585d-1459-b6ef-375b-890426004e01@loongson.cn>
Date:   Mon, 14 Aug 2023 15:57:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <6d7335b4-63e2-4a7e-9620-8a0012558dfd@app.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bx3yNd3tlkmZxZAA--.49687S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/8/12 下午8:25, Arnd Bergmann 写道:
> On Fri, Aug 4, 2023, at 04:54, Yinbo Zhu wrote:
>> 在 2023/8/3 下午3:44, Arnd Bergmann 写道:
>>> On Thu, Aug 3, 2023, at 08:37, Yinbo Zhu wrote:
>>>
>>>> +  loongson,suspend-address:
>>>> +    $ref: /schemas/types.yaml#/definitions/uint64
>>>> +    description:
>>>> +      The "loongson,suspend-address" is a deep sleep state (Suspend To
>>>> +      RAM) firmware entry address which was jumped from kernel and it's
>>>> +      value was dependent on specific platform firmware code. In
>>>> +      addition, the PM need according to it to indicate that current
>>>> +      SoC whether support Suspend To RAM.
>>>> +
>>>
>>> I just commented on this in the driver patch, assuming this
>>> was an MMIO address, but I'm even more confused now, since
>>> we try hard to not rely on being able to just interface with
>>> firmware like this.
>>>
>>> If this is executable code, where does this actually reside?
>>
>>
>> Pmon firmware code.
>>
>>> Is this some SRAM that needs to execute the suspend logic
>>> in order to shut down memory and cache controllers?
>>
>>
>> Yes, The suspend-to-ram after into pmon firmware code and set
>> self-refresh mode in memory controller and ensure that memory data is
>> not lost then shut down memory controller.
> 
> I'm sorry I missed your reply earlier, getting back to the
> thread now. So it's clear that this code needs to run in a
> special memory from your description, but I'm still trying
> to understand the details better.
> 
> I found https://github.com/loongson-community/pmon source
> code, and a reference to its origin at LSI Logic at
> https://www.linux-mips.org/wiki/PMON but otherwise have
> no idea about what this actually is, or how it relates
> to your UEFI firmware. Did you add UEFI support to PMON,
> or do you use it as a first stage loader that loads
> the actual UEFI implementation (EDK2 or u-boot, I guess)?


Pmon and uefi are two different firmware, and there is no connection
between them.

> 
>>> Or is
>>> this a runtime firmware interface similar to how UEFI handles
>>> its runtime services to keep the implementation out of
>>> the kernel?
>>
>>
>> No, The main cpu and other cpu will offline that after into firmware and
>> finished Corresponding operations, the pmon firmware will not run.
> 
> I'm still trying to understand your explanations here.
> You say that pmon no longer runs, but that seems to contradict
> what you said earlier about branching into pmon firmware code
> for suspend.


It's not contradictory.  The suspend-to-ram is that from kernel goto to
pmon firmware code, then pmon finished corresponding operations, which
was to set self-refresh mode in memory controller, then memory HW will
maintain its own data and no longer requires software processing, pmon
firmware will not run.

> 
> Is this executing directly from ROM then?


Yes.

Thanks,
Yinbo

