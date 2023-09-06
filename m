Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE6579338A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 04:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239763AbjIFCFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 22:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjIFCFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 22:05:45 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B7CA1A4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 19:05:41 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.201])
        by gateway (Coremail) with SMTP id _____8Bx5fBz3vdkcQUgAA--.64791S3;
        Wed, 06 Sep 2023 10:05:39 +0800 (CST)
Received: from [10.20.42.201] (unknown [10.20.42.201])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxbSNx3vdkdN5tAA--.18789S3;
        Wed, 06 Sep 2023 10:05:37 +0800 (CST)
Subject: Re: [PATCH] soc: loongson2_pm: add dependency on INPUT
To:     Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        loongson-kernel@lists.loongnix.cn, Liu Yun <liuyun@loongson.cn>,
        kernel test robot <lkp@intel.com>, zhuyinbo@loongson.cn
References: <20230905123629.4510-1-zhuyinbo@loongson.cn>
 <927e9f62-f273-fb90-2374-e6de2de795a4@infradead.org>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <bccd2de6-e15e-83c4-0b88-5cb4c50dc353@loongson.cn>
Date:   Wed, 6 Sep 2023 10:05:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <927e9f62-f273-fb90-2374-e6de2de795a4@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxbSNx3vdkdN5tAA--.18789S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/9/6 上午8:37, Randy Dunlap 写道:
> Hi--
> 
> On 9/5/23 05:36, Yinbo Zhu wrote:
>> This fixes some undefined references to `input_set_capability' and
>> `input_register_device` issue when INPUT is not enabled.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/all/202309030751.pDnTZX4E-lkp@intel.com/
>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>> ---
>>   drivers/soc/loongson/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/soc/loongson/Kconfig b/drivers/soc/loongson/Kconfig
>> index 314e13bb3e01c..1b57af1e55298 100644
>> --- a/drivers/soc/loongson/Kconfig
>> +++ b/drivers/soc/loongson/Kconfig
>> @@ -20,6 +20,7 @@ config LOONGSON2_GUTS
>>   config LOONGSON2_PM
>>   	bool "Loongson-2 SoC Power Management Controller Driver"
>>   	depends on LOONGARCH && OF
>> +	depends on INPUT
>>   	help
>>   	  The Loongson-2's power management controller was ACPI, supports ACPI
>>   	  S2Idle (Suspend To Idle), ACPI S3 (Suspend To RAM), ACPI S4 (Suspend To
> 
> The preferred patch has already been posted:
> 


Sorry, I didn't notice it, and please ignore my patch, use zhoubinbin's
patch.

Thanks,
Yinbo

> https://lore.kernel.org/all/16a37f6ad3cc9417b6638c2cd532d88c79468eb1.1693623752.git.zhoubinbin@loongson.cn/
> 

