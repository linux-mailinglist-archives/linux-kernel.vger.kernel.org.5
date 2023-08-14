Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6546177B810
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 13:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjHNL67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 07:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234873AbjHNL6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 07:58:38 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 163CA18B;
        Mon, 14 Aug 2023 04:58:02 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.201])
        by gateway (Coremail) with SMTP id _____8BxnuvDFtpkdSoYAA--.47621S3;
        Mon, 14 Aug 2023 19:57:55 +0800 (CST)
Received: from [10.20.42.201] (unknown [10.20.42.201])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxrM6_FtpkXuZZAA--.24469S3;
        Mon, 14 Aug 2023 19:57:51 +0800 (CST)
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
 <0616585d-1459-b6ef-375b-890426004e01@loongson.cn>
 <19feb595-e22a-4304-9b88-b5cb55949cd8@app.fastmail.com>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <71c53c37-a0a6-6b11-31d5-4455d2309927@loongson.cn>
Date:   Mon, 14 Aug 2023 19:57:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <19feb595-e22a-4304-9b88-b5cb55949cd8@app.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxrM6_FtpkXuZZAA--.24469S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/8/14 下午4:19, Arnd Bergmann 写道:
> On Mon, Aug 14, 2023, at 09:57, Yinbo Zhu wrote:
>> 在 2023/8/12 下午8:25, Arnd Bergmann 写道:
>>> On Fri, Aug 4, 2023, at 04:54, Yinbo Zhu wrote:
>>>> 在 2023/8/3 下午3:44, Arnd Bergmann 写道:
>>>>> On Thu, Aug 3, 2023, at 08:37, Yinbo Zhu wrote:
>>>>
>>>>> Is this some SRAM that needs to execute the suspend logic
>>>>> in order to shut down memory and cache controllers?
>>>>
>>>>
>>>> Yes, The suspend-to-ram after into pmon firmware code and set
>>>> self-refresh mode in memory controller and ensure that memory data is
>>>> not lost then shut down memory controller.
>>>
>>> I'm sorry I missed your reply earlier, getting back to the
>>> thread now. So it's clear that this code needs to run in a
>>> special memory from your description, but I'm still trying
>>> to understand the details better.
>>>
>>> I found https://github.com/loongson-community/pmon source
>>> code, and a reference to its origin at LSI Logic at
>>> https://www.linux-mips.org/wiki/PMON but otherwise have
>>> no idea about what this actually is, or how it relates
>>> to your UEFI firmware. Did you add UEFI support to PMON,
>>> or do you use it as a first stage loader that loads
>>> the actual UEFI implementation (EDK2 or u-boot, I guess)?
>>
>>
>> Pmon and uefi are two different firmware, and there is no connection
>> between them.
> 
> It sounds like we still have problems with terminology. >
> I don't think categorizing UEFI as a firmware is correct,


Sorry to have confused you, uefi firmware is our internal name, which is
actually what you referred to as EDK2, the EDK2 need use UEFI.

> it's the interface used by various firmware implementations
> to load the operating system. As far as I understand,
> loongarch currently mandates the use of UEFI in whichever
> firmware is used, so if you have Pmon installed in ROM > and Pmon does not itself implement UEFI, it would have
> to load some other firmware such as u-boot in order to
> load a kernel through the UEFI protocol, right?


PMON is an independent firmware and loader that can directly load the
operating system and it does not require the use of UEFI.

> 
> Has the assumption that loongarch requires UEFI changed?


LoongArch embedded board was use Pmon firmware, The other one uses UEFI
firmware (EDK2) on LoongArch platform.

> 
>>>>> Or is
>>>>> this a runtime firmware interface similar to how UEFI handles
>>>>> its runtime services to keep the implementation out of
>>>>> the kernel?
>>>>
>>>>
>>>> No, The main cpu and other cpu will offline that after into firmware and
>>>> finished Corresponding operations, the pmon firmware will not run.
>>>
>>> I'm still trying to understand your explanations here.
>>> You say that pmon no longer runs, but that seems to contradict
>>> what you said earlier about branching into pmon firmware code
>>> for suspend.
>>
>>
>> It's not contradictory.  The suspend-to-ram is that from kernel goto to
>> pmon firmware code, then pmon finished corresponding operations, which
>> was to set self-refresh mode in memory controller, then memory HW will
>> maintain its own data and no longer requires software processing, pmon
>> firmware will not run.
> 
> That is what I mean with a "runtime firmware interface", i.e. you
> jump into firmware in order to request services from it. Clearly the
> firmware itself does not run while the OS is executing code, but it is
> still there and waiting to be called here, which is similar to
> things like UEFI runtime services, PowerPC RTAS, Arm EL3/trustzone
> based firmware or x86 SMM firmware, except that this is much less
> formalized and only consists of an entry point with undocument
> calling conventions.
> 
>>> Is this executing directly from ROM then?
>>
>> Yes.
> 
> Is this the only runtime call into the firmware, 


Only when suspend-to-ram occurs, the kernel will call into the firmware.
No other case.

> or are there
> others that are either already called from mainline kernels
> or in your downsteam implementation?
> 
> How do you ensure that the DTB matches the actual ROM code
> after rebuilding Pmon? Does Pmon itself fill that field with
> the correct address, or do you rely on it being a hardcoded
> constant?


Use Pmon, firmware team will always ensure that DTB matches the actual
ROM code.  The "suspend-address" of dtb and pmon entry address will
synchronized modification by firmware team.

Thanks,
Yinbo

