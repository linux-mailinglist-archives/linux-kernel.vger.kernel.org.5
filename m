Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F1477C6AB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 06:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjHOEOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 00:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234599AbjHOELl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 00:11:41 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12FE11BCA;
        Mon, 14 Aug 2023 21:08:43 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.201])
        by gateway (Coremail) with SMTP id _____8CxyOhK+tpkuZ4YAA--.14979S3;
        Tue, 15 Aug 2023 12:08:42 +0800 (CST)
Received: from [10.20.42.201] (unknown [10.20.42.201])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxHCNH+tpkc+BaAA--.7836S3;
        Tue, 15 Aug 2023 12:08:39 +0800 (CST)
Subject: Re: [PATCH v6 1/2] soc: dt-bindings: add loongson-2 pm
To:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        zhuyinbo@loongson.cn, Conor Dooley <conor+dt@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, soc@kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, loongarch@lists.linux.dev,
        Liu Yun <liuyun@loongson.cn>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20230803063703.5659-1-zhuyinbo@loongson.cn>
 <20230803063703.5659-2-zhuyinbo@loongson.cn>
 <193f9138-57e0-4d4b-8225-54d38be9bfbc@app.fastmail.com>
 <8efeac46-ebb7-fa05-3d88-7c21acd59c8b@loongson.cn>
 <6d7335b4-63e2-4a7e-9620-8a0012558dfd@app.fastmail.com>
 <0616585d-1459-b6ef-375b-890426004e01@loongson.cn>
 <19feb595-e22a-4304-9b88-b5cb55949cd8@app.fastmail.com>
 <71c53c37-a0a6-6b11-31d5-4455d2309927@loongson.cn>
 <e04cf26e-2e38-4e87-b7b4-23dafadee00d@app.fastmail.com>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <753d10b9-3b33-e7ef-a3d3-78090d67d648@loongson.cn>
Date:   Tue, 15 Aug 2023 12:08:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <e04cf26e-2e38-4e87-b7b4-23dafadee00d@app.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxHCNH+tpkc+BaAA--.7836S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/8/14 下午9:41, Arnd Bergmann 写道:
> On Mon, Aug 14, 2023, at 13:57, Yinbo Zhu wrote:
>> 在 2023/8/14 下午4:19, Arnd Bergmann 写道:
>>> On Mon, Aug 14, 2023, at 09:57, Yinbo Zhu wrote:
>>>> 在 2023/8/12 下午8:25, Arnd Bergmann 写道:
>>>>> I found https://github.com/loongson-community/pmon source
>>>>> code, and a reference to its origin at LSI Logic at
>>>>> https://www.linux-mips.org/wiki/PMON but otherwise have
>>>>> no idea about what this actually is, or how it relates
>>>>> to your UEFI firmware. Did you add UEFI support to PMON,
>>>>> or do you use it as a first stage loader that loads
>>>>> the actual UEFI implementation (EDK2 or u-boot, I guess)?
>>>>
>>>>
>>>> Pmon and uefi are two different firmware, and there is no connection
>>>> between them.
>>>
>>> It sounds like we still have problems with terminology. >
>>> I don't think categorizing UEFI as a firmware is correct,
>>
>>
>> Sorry to have confused you, uefi firmware is our internal name, which is
>> actually what you referred to as EDK2, the EDK2 need use UEFI.
> 
> Ok
> 
>>> it's the interface used by various firmware implementations
>>> to load the operating system. As far as I understand,
>>> loongarch currently mandates the use of UEFI in whichever
>>> firmware is used, so if you have Pmon installed in ROM > and Pmon does not itself implement UEFI, it would have
>>> to load some other firmware such as u-boot in order to
>>> load a kernel through the UEFI protocol, right?
>>
>>
>> PMON is an independent firmware and loader that can directly load the
>> operating system and it does not require the use of UEFI.
>>>
>>> Has the assumption that loongarch requires UEFI changed?
>>
>>
>> LoongArch embedded board was use Pmon firmware, The other one uses UEFI
>> firmware (EDK2) on LoongArch platform.
> 
> I'm pretty sure we discussed this when the loongarch port
> was originally merged, with the decisionto just use UEFI for
> booting any kernel, as the legacy entry point for the ACPI
> based environment was not really well-defined and the UEFI
> stub was an easy alternative to have more commonality
> with other architectures.
> 
> I see this was already extended for embedded CPUs to use
> the uefi stub with DT in commit 88d4d957edc70 ("LoongArch: Add
> FDT booting support from efi system table"), which seems like
> the right direction. >
> Can you explain why this board would want yet another method
> for entering the kernel? Is there any documentation for the
> boot protocol?

Yes, you're right, the latest PMON does indeed support UEFI, the PMON
used in the product code is still outdated and does not support UEFI.

Actually, whether using EDK2, Pmon firmware, or other firmware, the
LoongArch platform's s3 (suspend-to-ram) requires a suspend-address to
be defined, if dts is supported, it is defined in dts, and if acpi table
is supported, it is defined in acpi table.

> 
>>>>> Is this executing directly from ROM then?
>>>>
>>>> Yes.
>>>
>>> Is this the only runtime call into the firmware,
>>
>>
>> Only when suspend-to-ram occurs, the kernel will call into the firmware.
>> No other case.
> 
> Ok
> 
>>> or are there
>>> others that are either already called from mainline kernels
>>> or in your downsteam implementation?
>>>
>>> How do you ensure that the DTB matches the actual ROM code
>>> after rebuilding Pmon? Does Pmon itself fill that field with
>>> the correct address, or do you rely on it being a hardcoded
>>> constant?
>>
>>
>> Use Pmon, firmware team will always ensure that DTB matches the actual
>> ROM code.  The "suspend-address" of dtb and pmon entry address will
>> synchronized modification by firmware team.
> 
> Ok.  So it's linked against libfdt to fill the dtb information,
> or do you have to provide a dtb blob that matches the firmware?


For pmon firmware, the dtb was as part of firmware, the firmware has
defined the address of the DTB's suspend and the address of the firmware
entry, and is consistent.

Thanks,
Yinbo

