Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4AD75A9A6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjGTI4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjGTIpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:45:45 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150A0268E
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 01:45:43 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4R65qb3fR8z4f3p04
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 16:45:31 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP1 (Coremail) with SMTP id cCh0CgDnUCss9LhkZEKENg--.7468S2;
        Thu, 20 Jul 2023 16:45:32 +0800 (CST)
Subject: Re: [PATCH 0/2] Two minor cleanups for compaction
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230720115351.2039431-1-shikemeng@huaweicloud.com>
 <2909fe72-5873-7186-88d6-0667cd71f705@linux.alibaba.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <361d3516-4654-5a42-9e49-ab1b5dfead35@huaweicloud.com>
Date:   Thu, 20 Jul 2023 16:45:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <2909fe72-5873-7186-88d6-0667cd71f705@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDnUCss9LhkZEKENg--.7468S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Wry8uF43XF17uFWfCw15Jwb_yoWkZFX_C3
        yYyF95Gr1xAa1xG3ZrKa15GrnrKrWjvw1rG340qrW2k3srZan5tFs3GwnxZF13GFWxGFn8
        Gas5ZayYv3W2gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb7xYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
        k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWHqcUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



on 7/20/2023 2:08 PM, Baolin Wang wrote:
> 
> 
> On 7/20/2023 7:53 PM, Kemeng Shi wrote:
>> Hi all, this series contains two random cleanups for compaction.
>> Patch 1 correct wrong comment in fast_isolate_freepages.
>> Patch 2 avoid to call unneeded pageblock_end_pfn when no_set_skip_hint
>> is set.
>> Thanks!
> 
> I only received the patch 2 in this patch set, and I checked the lore
> archives[1], still did not find patch 1. You missed patch 1?
> 
> [1] https://lore.kernel.org/linux-mm/20230720115351.2039431-1-shikemeng@huaweicloud.com/
> 
>>
>> Kemeng Shi (2):
>>    mm/compaction: correct comment of candidate pfn in
>>      fast_isolate_freepages
>>    mm/compaction: avoid unneeded pageblock_end_pfn when no_set_skip_hint
>>      is set
>>
>>   mm/compaction.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
> 
> 
Hi Baolin, thanks for the review and for reminding me of this. I can recive the patch 1
in my mail client. There maybe some problem in my mail server. I also found there is
a whole patchset I have sent is missing in lcore archives. I will try to resend these
patches. Thanks a lot.

-- 
Best wishes
Kemeng Shi

