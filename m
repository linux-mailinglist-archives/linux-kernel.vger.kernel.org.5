Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF7A768A3E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 05:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjGaDMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 23:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGaDMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 23:12:52 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 762ABE8;
        Sun, 30 Jul 2023 20:12:49 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.201])
        by gateway (Coremail) with SMTP id _____8BxIvCwJsdkEuwMAA--.30217S3;
        Mon, 31 Jul 2023 11:12:48 +0800 (CST)
Received: from [10.20.42.201] (unknown [10.20.42.201])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxHCOvJsdk+71BAA--.22447S3;
        Mon, 31 Jul 2023 11:12:47 +0800 (CST)
Subject: Re: [PATCH v5 2/2] soc: loongson2_pm: add power management support
To:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, Liu Yun <liuyun@loongson.cn>,
        zhuyinbo@loongson.cn
References: <20230728074944.26746-1-zhuyinbo@loongson.cn>
 <20230728074944.26746-3-zhuyinbo@loongson.cn>
 <569a1c8e-234a-442f-9b9e-956f5bac26dc@app.fastmail.com>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <97ae94ff-3b0c-b89d-3436-18839739de17@loongson.cn>
Date:   Mon, 31 Jul 2023 11:12:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <569a1c8e-234a-442f-9b9e-956f5bac26dc@app.fastmail.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxHCOvJsdk+71BAA--.22447S3
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



ÔÚ 2023/7/28 ÏÂÎç6:46, Arnd Bergmann Ð´µÀ:
> On Fri, Jul 28, 2023, at 09:49, Yinbo Zhu wrote:
>> The Loongson-2's power management controller was ACPI, supports ACPI
>> S2Idle (Suspend To Idle), ACPI S3 (Suspend To RAM), ACPI S4 (Suspend To
>> Disk), ACPI S5 (Soft Shutdown) and supports multiple wake-up methods
>> (USB, GMAC, PWRBTN, etc.). This driver was to add power management
>> controller support that base on dts for Loongson-2 series SoCs.
>>
>> Co-developed-by: Liu Yun <liuyun@loongson.cn>
>> Signed-off-by: Liu Yun <liuyun@loongson.cn>
>> Co-developed-by: Liu Peibao <liupeibao@loongson.cn>
>> Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> 
> Adding Ulf Hansson to Cc


okay, I will add ulf hansson to Cc.

> 
> Ulf has recently split out the "genpd" framework and split out
> drivers/genpd from drivers/soc since I'm generally not that involved
> in the pwoer management side.

okay, I got it.

> 
> Can you have a look at whether this driver should also be part
> of drivers/genpd rather than drivers/soc, and/or converted
> to use the genpd infrastructure?


I have a look drivers/soc and drivers/genpd, there seems to be power
manager code in both paths, but drivers/genpd seems more suitable. I
will move the code to drivers/genpd

Thanks,
Yinbo

