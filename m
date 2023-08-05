Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A73F770D9E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 06:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjHEEHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 00:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHEEH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 00:07:28 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD2FE6F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 21:07:25 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RHpvD3m3yz4f3mHk
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 12:07:20 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP2 (Coremail) with SMTP id Syh0CgBXPNr3ys1kzMQePg--.64663S2;
        Sat, 05 Aug 2023 12:07:20 +0800 (CST)
Subject: Re: [PATCH 0/9] Fixes and cleanups to compaction
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        mgorman@techsingularity.net, david@redhat.com
References: <20230805110711.2975149-1-shikemeng@huaweicloud.com>
 <ZM2+sztr1CPCwIBN@casper.infradead.org>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <b0f12bbe-d362-6398-137d-83838a599cea@huaweicloud.com>
Date:   Sat, 5 Aug 2023 12:07:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <ZM2+sztr1CPCwIBN@casper.infradead.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: Syh0CgBXPNr3ys1kzMQePg--.64663S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFWxWFWkZF1UWF1UWr48JFb_yoW8GrW3pF
        s8Ga15Gr13WF18Grs2yw4xC3WIqw4UJr13Kr1rG34rZayYvry293Z29r12vr1UCry7CrWF
        qwsIgF1vk34kC3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY
        1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew, thanks to inform me of this. You can find full series on lore.kernel.org
all at [1] and [2].
I contacted owner-linux-mm@kvack.org and was told all patches are recived and forawrd
successfully. Then I contacted meta@public-inbox.org which is the only email I found
from help page of lore.kernel.org/linux-mm/, but no response yet.
Please let me know if there is any other ways I can get help. Thanks!

[1] https://lore.kernel.org/all/20230804110454.2935878-1-shikemeng@huaweicloud.com/
[2] https://lore.kernel.org/all/20230805110711.2975149-1-shikemeng@huaweicloud.com/

on 8/5/2023 11:14 AM, Matthew Wilcox wrote:
> On Sat, Aug 05, 2023 at 07:07:02PM +0800, Kemeng Shi wrote:
>> Hi all, this is another series to do fix and clean up to compaction.
>> Patch 1-2 fix and clean up freepage list operation.
>> Patch 3-4 fix and clean up isolation of freepages
>> Patch 7-9 factor code to check if compaction is needed for allocation
>> order.
>> More details can be found in respective patches. Thanks!
> 
> As with your last patch series, half of the patches are missing.
> Looks like they didn't make it to lore.kernel.org either:
> 
> https://lore.kernel.org/linux-mm/20230804110454.2935878-1-shikemeng@huaweicloud.com/
> https://lore.kernel.org/linux-mm/20230805110711.2975149-1-shikemeng@huaweicloud.com/
> 
> 

