Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514CC7C62AD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 04:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbjJLCVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 22:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbjJLCU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 22:20:59 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0528898
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 19:20:56 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8AxXOoHWCdlFDwxAA--.2135S3;
        Thu, 12 Oct 2023 10:20:55 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxfNz+Vydlwj4hAA--.4675S3;
        Thu, 12 Oct 2023 10:20:55 +0800 (CST)
Message-ID: <8532764a-ac25-ff66-07cb-60a0eb011a01@loongson.cn>
Date:   Thu, 12 Oct 2023 10:20:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 0/5] drm/etnaviv: Various cleanup
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20231002111207.513297-1-suijingfeng@loongson.cn>
 <8201caf4102cbb81ea15e87713a165590b11a684.camel@pengutronix.de>
Content-Language: en-US
From:   Sui Jingfeng <suijingfeng@loongson.cn>
In-Reply-To: <8201caf4102cbb81ea15e87713a165590b11a684.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8CxfNz+Vydlwj4hAA--.4675S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrtw18GrW7CFykZrWkAF1DJwc_yoW3Cwc_uF
        W8Zr97Xr4fJF1vqFy7A3s5AFW0kF4rXrsFq3Wjq39FgrZIqFnxZr1kG3yUW34UXFW7KFnr
        XF93JryfAFy7WosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
        s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
        cSsGvfJTRUUUbxAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
        vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
        02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAF
        wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
        CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
        67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
        IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
        14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
        W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jUsqXU
        UUUU=
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Lucas


Thanks a lot!


On 2023/10/12 01:04, Lucas Stach wrote:
> Am Montag, dem 02.10.2023 um 19:12 +0800 schrieb Sui Jingfeng:
>> v2:
>> 	* refine on v1 and update
>>
> Thanks, series applied to my etnaviv/next branch.
>
> Regards,
> Lucas
>
>> Sui Jingfeng (5):
>>    drm/etnaviv: Drop the second argument of the etnaviv_gem_new_impl()
>>    drm/etnaviv: Fix coding style
>>    drm/etnaviv: Add helper functions to create and destroy platform
>>      device
>>    drm/etnaviv: Add a helper to get the first available GPU device node
>>    drm/etnaviv: Using 'dev' instead of 'etnaviv_obj->base.dev'
>>
>>   drivers/gpu/drm/etnaviv/etnaviv_drv.c | 93 ++++++++++++++++++---------
>>   drivers/gpu/drm/etnaviv/etnaviv_gem.c | 12 ++--
>>   2 files changed, 67 insertions(+), 38 deletions(-)
>>

