Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D8D77EEC3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 03:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244549AbjHQBfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 21:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347557AbjHQBfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 21:35:16 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 18556271E;
        Wed, 16 Aug 2023 18:35:12 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.201])
        by gateway (Coremail) with SMTP id _____8AxTetPed1kfFQZAA--.46769S3;
        Thu, 17 Aug 2023 09:35:11 +0800 (CST)
Received: from [10.20.42.201] (unknown [10.20.42.201])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxTSNOed1kgmVcAA--.11513S3;
        Thu, 17 Aug 2023 09:35:10 +0800 (CST)
Subject: Re: [PATCH v15 1/2] thermal: loongson-2: add thermal management
 support
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn,
        zhanghongchen <zhanghongchen@loongson.cn>, zhuyinbo@loongson.cn
References: <20230620012944.28877-1-zhuyinbo@loongson.cn>
 <da3e6348-33e0-aaa9-8f86-4b1ba1504551@linaro.org>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <4486a43d-131c-0dcb-d2e5-1f4659a873c0@loongson.cn>
Date:   Thu, 17 Aug 2023 09:35:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <da3e6348-33e0-aaa9-8f86-4b1ba1504551@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxTSNOed1kgmVcAA--.11513S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/8/16 下午8:46, Daniel Lezcano 写道:
> On 20/06/2023 03:29, Yinbo Zhu wrote:
>> This patch adds the support for Loongson-2 thermal sensor controller,
>> which can support maximum four sensor selectors that corresponding to 
>> four
>> sets of thermal control registers and one set of sampling register. The
>> sensor selector can selector a speific thermal sensor as temperature 
>> input.
>> The sampling register is used to obtain the temperature in real time, the
>> control register GATE field is used to set the threshold of high or low
>> temperature, when the input temperature is higher than the high 
>> temperature
>> threshold or lower than the low temperature threshold, an interrupt will
>> occur.
>>
>> Signed-off-by: zhanghongchen <zhanghongchen@loongson.cn>
>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>> ---
> 
> [ ... ]
> 
>> +    if (devm_thermal_add_hwmon_sysfs(dev, tzd))
>> +        dev_warn(dev, "Failed to add hwmon sysfs attributes\n");
> 
> [ ... ]
> 
> This has been factored out by adding a message directly in 
> devm_thermal_add_hwmon_sysfs(), so the test is not needed here neither 
> the message.


okay, I got it, I will remove the message.

> 
> However, these changes have been long enough on the mailing list and the 
> result looks nice.
> 
> I can pick this patch and you provide a small patch on top. Or you send 
> a V16 with this change. It is your call.


okay, I will send v16.

Thanks,
Yinbo.

