Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060C6756041
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 12:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjGQKUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 06:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjGQKUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:20:20 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BACAFB1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 03:20:18 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8Cx5_HhFbVkUOUFAA--.15878S3;
        Mon, 17 Jul 2023 18:20:17 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxB83hFbVkdFsxAA--.63881S3;
        Mon, 17 Jul 2023 18:20:17 +0800 (CST)
Message-ID: <abc98932-121b-c410-0f51-aab71f2c8a2f@loongson.cn>
Date:   Mon, 17 Jul 2023 18:20:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 8/8] drm/etnaviv: Add a helper to get a pointer to the
 first available node
Content-Language: en-US
To:     Lucas Stach <l.stach@pengutronix.de>,
        Sui Jingfeng <sui.jingfeng@linux.dev>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     loongson-kernel@lists.loongnix.cn, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230623100822.274706-1-sui.jingfeng@linux.dev>
 <20230623100822.274706-9-sui.jingfeng@linux.dev>
 <66749b1b4523d2859b9fbc6e9120e5f1e887d531.camel@pengutronix.de>
From:   suijingfeng <suijingfeng@loongson.cn>
In-Reply-To: <66749b1b4523d2859b9fbc6e9120e5f1e887d531.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8BxB83hFbVkdFsxAA--.63881S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxur1UKw1fAFyUtr43trWUAwc_yoW5tr47pF
        W8GFWYkrWkWFyYg34IqFZ8ZFyY9w1Iq3yFk3srtw1vk3s0yryfGryFgr4UCF93AFZ5GF40
        vr10gr17uF48JrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
        8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67
        AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
        rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
        v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4SoGDU
        UUU
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/7/17 18:07, Lucas Stach wrote:
> Am Freitag, dem 23.06.2023 um 18:08 +0800 schrieb Sui Jingfeng:
>> From: Sui Jingfeng <suijingfeng@loongson.cn>
>>
>> This make the code in etnaviv_pdev_probe() less twisted, drop the reference
>> to device node after finished. Also kill a double blank line.
>>
> I can't spot the double blank line you claim to remove.
>
>> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
>> ---
>>   drivers/gpu/drm/etnaviv/etnaviv_drv.c | 32 ++++++++++++++++++---------
>>   1 file changed, 22 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
>> index 7d0eeab3e8b7..3446f8eabf59 100644
>> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
>> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
>> @@ -27,6 +27,19 @@
>>    * DRM operations:
>>    */
>>   
>> +/* If the DT contains at least one available GPU, return a pointer to it */
>> +

Here is the double blank line my patch remove, it (a blank line) is occupied by
the comment of "/* If the DT contains at least one available GPU, return a pointer to it */"


> I think the code in the function is simple enough that we don't need a
> comment explaining what it does.

Ok, then I'll remove the comment at the next version. Thanks


> Regards,
> Lucas
>
>> +static struct device_node *etnaviv_of_first_node(void)
>> +{
>> +	struct device_node *np;
>> +
>> +	for_each_compatible_node(np, NULL, "vivante,gc") {
>> +		if (of_device_is_available(np))
>> +			return np;
>> +	}
>> +
>> +	return NULL;
>> +}
>>   
>>   static void load_gpu(struct drm_device *dev)
>>   {
>> @@ -587,7 +600,7 @@ static const struct component_master_ops etnaviv_master_ops = {
>>   static int etnaviv_pdev_probe(struct platform_device *pdev)
>>   {
>>   	struct device *dev = &pdev->dev;
>> -	struct device_node *first_node = NULL;
>> +	struct device_node *first_node;
>>   	struct component_match *match = NULL;
>>   
>>   	if (!dev->platform_data) {
>> @@ -597,11 +610,10 @@ static int etnaviv_pdev_probe(struct platform_device *pdev)
>>   			if (!of_device_is_available(core_node))
>>   				continue;
>>   
>> -			if (!first_node)
>> -				first_node = core_node;
>> -
>>   			drm_of_component_match_add(&pdev->dev, &match,
>>   						   component_compare_of, core_node);
>> +
>> +			of_node_put(core_node);
>>   		}
>>   	} else {
>>   		char **names = dev->platform_data;
>> @@ -634,8 +646,11 @@ static int etnaviv_pdev_probe(struct platform_device *pdev)
>>   	 * device as the GPU we found. This assumes that all Vivante
>>   	 * GPUs in the system share the same DMA constraints.
>>   	 */
>> -	if (first_node)
>> +	first_node = etnaviv_of_first_node();
>> +	if (first_node) {
>>   		of_dma_configure(&pdev->dev, first_node, true);
>> +		of_node_put(first_node);
>> +	}
>>   
>>   	return component_master_add_with_match(dev, &etnaviv_master_ops, match);
>>   }
>> @@ -709,17 +724,14 @@ static int __init etnaviv_init(void)
>>   	 * If the DT contains at least one available GPU device, instantiate
>>   	 * the DRM platform device.
>>   	 */
>> -	for_each_compatible_node(np, NULL, "vivante,gc") {
>> -		if (!of_device_is_available(np))
>> -			continue;
>> +	np = etnaviv_of_first_node();
>> +	if (np) {
>>   		of_node_put(np);
>>   
>>   		ret = etnaviv_create_platform_device("etnaviv",
>>   						     &etnaviv_platform_device);
>>   		if (ret)
>>   			goto unregister_platform_driver;
>> -
>> -		break;
>>   	}
>>   
>>   	return 0;

