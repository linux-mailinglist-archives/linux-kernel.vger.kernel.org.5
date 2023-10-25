Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75307D6F76
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344855AbjJYOHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343648AbjJYOHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:07:11 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8415F138
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:07:04 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8AxqOgFITllw400AA--.801S3;
        Wed, 25 Oct 2023 22:07:01 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx_y_zIDllYjMyAA--.40980S3;
        Wed, 25 Oct 2023 22:06:57 +0800 (CST)
Message-ID: <34d1858c-5b31-474a-80bd-129f3123a71f@loongson.cn>
Date:   Wed, 25 Oct 2023 22:06:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/logicvc: Kconfig: select REGMAP and REGMAP_MMIO
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230608024207.581401-1-suijingfeng@loongson.cn>
 <ZIGAEZTJvq1GqFVD@aptenodytes>
 <50fbc003-fd3c-c7c4-9c6b-76d14a0babfc@loongson.cn>
 <ZTjp65yjul76zKWm@aptenodytes>
Content-Language: en-US
From:   Sui Jingfeng <suijingfeng@loongson.cn>
In-Reply-To: <ZTjp65yjul76zKWm@aptenodytes>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Dx_y_zIDllYjMyAA--.40980S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Aw4fWw1DZFWxJr4xGF48GrX_yoW8CFyxpF
        48t3W2kF4IvrWYyr12yF1aqFyYqwn7KrWfWF12kwn8W3s0kF1DZFZ3ZrW5ur98XrZrAF40
        qrn3KFy3JF47A3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
        8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
        0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07URa0PUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 2023/10/25 18:11, Paul Kocialkowski wrote:
> Hi,
>
> On Tue 20 Jun 23, 11:56, Sui Jingfeng wrote:
>> Hi,
>>
>> On 2023/6/8 15:15, Paul Kocialkowski wrote:
>>> Hi,
>>>
>>> On Thu 08 Jun 23, 10:42, Sui Jingfeng wrote:
>>>> drm/logicvc driver is depend on REGMAP and REGMAP_MMIO, should select this
>>>> two kconfig option, otherwise the driver failed to compile on platform
>>>> without REGMAP_MMIO selected:
>>>>
>>>> ERROR: modpost: "__devm_regmap_init_mmio_clk" [drivers/gpu/drm/logicvc/logicvc-drm.ko] undefined!
>>>> make[1]: *** [scripts/Makefile.modpost:136: Module.symvers] Error 1
>>>> make: *** [Makefile:1978: modpost] Error 2
>>>>
>>>> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
>>> Thanks for the fix, looks good to me!
>>>
>>> Acked-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
>> Thanks a lot,
>>
>> Please don't forget to push this to drm-misc or drm-tip if you has the time,
>> as (even though trivial) it's precious for me.
> So I totally forgot about this and only pushed it to drm-misc-fixes now.
> Sincere apologies for this.
>
> Thanks again for spotting this issue and submitting the fix.
>
> Paul


Nice, thanks your reply.


>>
>>> Cheers,
>>>
>>> Paul
>>>
>>>> ---
>>>>    drivers/gpu/drm/logicvc/Kconfig | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/logicvc/Kconfig b/drivers/gpu/drm/logicvc/Kconfig
>>>> index fa7a88368809..1df22a852a23 100644
>>>> --- a/drivers/gpu/drm/logicvc/Kconfig
>>>> +++ b/drivers/gpu/drm/logicvc/Kconfig
>>>> @@ -5,5 +5,7 @@ config DRM_LOGICVC
>>>>    	select DRM_KMS_HELPER
>>>>    	select DRM_KMS_DMA_HELPER
>>>>    	select DRM_GEM_DMA_HELPER
>>>> +	select REGMAP
>>>> +	select REGMAP_MMIO
>>>>    	help
>>>>    	  DRM display driver for the logiCVC programmable logic block from Xylon
>>>> -- 
>>>> 2.25.1
>>>>
>> -- 
>> Jingfeng
>>

