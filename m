Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAF376DD94
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 03:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjHCBxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 21:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbjHCBwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 21:52:47 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A3149DE
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 18:50:21 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RGWy13K9Lz4f3mJ3
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 09:50:17 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP1 (Coremail) with SMTP id cCh0CgBn+DLZB8tk8j2KOg--.4701S2;
        Thu, 03 Aug 2023 09:50:18 +0800 (CST)
Subject: Re: [PATCH v2 4/8] mm/compaction: correct comment of
 fast_find_migrateblock in isolate_migratepages
To:     Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, david@redhat.com
References: <20230802093741.2333325-1-shikemeng@huaweicloud.com>
 <20230802093741.2333325-5-shikemeng@huaweicloud.com>
 <318912b8-b8dd-2e64-ca2a-cdb80551b2aa@linux.alibaba.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <bc1f816f-83aa-7175-4d03-5801aa4d1238@huaweicloud.com>
Date:   Thu, 3 Aug 2023 09:50:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <318912b8-b8dd-2e64-ca2a-cdb80551b2aa@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgBn+DLZB8tk8j2KOg--.4701S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CrWDJw4kur4fGw4xGryrXrb_yoW8ZF1fpw
        1xJ3W8WFWUC3WrG3ZrJF1DZFy5tw4xJ3WUJrsrX3W8JrZ8X3ZFq3sFgryFgryjqr4fAa4q
        vF4DtFyfZayDJrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



on 8/2/2023 7:31 PM, Baolin Wang wrote:
> 
> 
> On 8/2/2023 5:37 PM, Kemeng Shi wrote:
>> After 90ed667c03fe5 ("Revert "Revert "mm/compaction: fix set skip in
>> fast_find_migrateblock"""), we remove skip set in fast_find_migrateblock.
>> Correct comment that fast_find_block is used to avoid isolation_suitable
>> check for pageblock returned from fast_find_migrateblock because
>> fast_find_migrateblock will mark found pageblock skipped.
>> Instead, comment that fast_find_block is used to avoid a redundant check
>> of fast found pageblock which is already checked skip flag inside
>> fast_find_migrateblock.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> ---
>>   mm/compaction.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index 984c17a5c8fd..5c9dc4049e8e 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -1966,8 +1966,8 @@ static isolate_migrate_t isolate_migratepages(struct compact_control *cc)
>>           block_start_pfn = cc->zone->zone_start_pfn;
>>         /*
>> -     * fast_find_migrateblock marks a pageblock skipped so to avoid
>> -     * the isolation_suitable check below, check whether the fast
>> +     * fast_find_migrateblock will ignore pageblock skipped, so to avoid
> 
> These seem confusing to me, since the fast_find_migrateblock() did not ignore the skip flag checking. So how about below words?
> 
> "fast_find_migrateblock() has already ensured the pageblock is not set with a skipped flag, so to avoid the isolation_suitable check below again ..."
> 
Thanks for the advise. This looks good to me. I will do this in next version.
>> +     * the isolation_suitable check below again, check whether the fast
>>        * search was successful.
>>        */
>>       fast_find_block = low_pfn != cc->migrate_pfn && !cc->fast_search_fail;
> 

