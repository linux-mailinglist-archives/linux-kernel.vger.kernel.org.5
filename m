Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24ECF7C4823
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 05:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344944AbjJKDGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 23:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344895AbjJKDGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 23:06:31 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE28992;
        Tue, 10 Oct 2023 20:06:27 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8DxRvEyESZlE+EwAA--.28559S3;
        Wed, 11 Oct 2023 11:06:26 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx7y8jESZlHqUfAA--.395S3;
        Wed, 11 Oct 2023 11:06:25 +0800 (CST)
Message-ID: <03a7a1be-a78a-3380-4b65-091bef0914b6@loongson.cn>
Date:   Wed, 11 Oct 2023 11:06:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] drm/tegra: Return an error code if fails
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230626143331.640454-1-suijingfeng@loongson.cn>
 <ZSVQMPuRnXzC0lgf@orome.fritz.box> <ZSVuVcqdGfGtQIQj@orome.fritz.box>
Content-Language: en-US
From:   Sui Jingfeng <suijingfeng@loongson.cn>
In-Reply-To: <ZSVuVcqdGfGtQIQj@orome.fritz.box>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Cx7y8jESZlHqUfAA--.395S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cw15Gw43tw17WryxCw47ZFc_yoW8XrWxpr
        y3Gas8KF1kW39xtFn7X34fAF1rtw4ftFykGF9Y9ryqkr1qqF12yr129wsI9F17Zr4Fkaya
        yF45Cw13C3WqvFcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
        AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
        F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
        ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
        1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zw
        Z7UUUUU==
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 2023/10/10 23:31, Thierry Reding wrote:
> On Tue, Oct 10, 2023 at 03:22:56PM +0200, Thierry Reding wrote:
>> On Mon, Jun 26, 2023 at 10:33:30PM +0800, Sui Jingfeng wrote:
>>> Return -ENOMEM if tegra_bo_mmap() fails.
>>>
>>> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
>>> ---
>>>   drivers/gpu/drm/tegra/gem.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>> Sorry, this fell through the cracks. I think it'd be better if
>> tegra_bo_mmap() were to be improved to always return either an ERR_PTR()
>> encoded error code or a valid pointer. Throwing NULL into the mix isn't
>> useful because it typically means something like -ENOMEM anyway. Error
>> codes are more explicit, so since we're already using them for some
>> cases, might as well return them for all.
>>
>> Actually, looks like tegra_bo_mmap() never actually returns an ERR_PTR()
>> encoded error code. It's either obj->vaddr, the return value of vmap()
>> (which is either NULL or the address of the mapping), or the address
>> obtained from dma_buf_vmap_unlocked() (i.e. map.vaddr) or NULL on
>> failure. So I think it would equally make sense to keep your patch and
>> to remove the IS_ERR() check below it.
>>
>> I would slightly prefer the first option, but either is fine.
> How about the attached patch?


I also prefer the prefer the first option.
The attached patch is more better, because it solve the problem at lower level.

Reviewed-by: Sui Jingfeng <suijingfeng@loongson.cn>

> Thierry

