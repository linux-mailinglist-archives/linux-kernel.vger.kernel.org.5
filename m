Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A353778379B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 03:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjHVBwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 21:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbjHVBwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 21:52:17 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4CB186
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 18:52:01 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RVC573G2sz4f3jXL
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 09:51:55 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP3 (Coremail) with SMTP id _Ch0CgAnQ7u9FORkwSbVBA--.33851S2;
        Tue, 22 Aug 2023 09:51:58 +0800 (CST)
Subject: Re: [PATCH 6/9] mm/compaction: rename is_via_compact_memory to
 compaction_with_allocation_order
To:     Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, david@redhat.com
References: <20230805110711.2975149-1-shikemeng@huaweicloud.com>
 <20230805110711.2975149-7-shikemeng@huaweicloud.com>
 <111c3142-e20b-3e3c-f107-cbb64a16c2b0@linux.alibaba.com>
 <d28fc70d-ea1e-4c27-a206-6c276e6e020e@huaweicloud.com>
 <bf23350e-45cc-17ef-ac2c-9efff4a70172@linux.alibaba.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <1b4fd28b-96e6-ce58-3752-759a8539c6cc@huaweicloud.com>
Date:   Tue, 22 Aug 2023 09:51:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <bf23350e-45cc-17ef-ac2c-9efff4a70172@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgAnQ7u9FORkwSbVBA--.33851S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw13Kw4UXFW7Jr1xtr43Wrg_yoWrWrWkpF
        10yFy7Za45XF1fGr1Ig3W8Xa4Utw4xK3WUJr1vvF18XwnIk3WF9F1qqFyY9ryUX39ayw4j
        qFWUKF17ZasrA3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrNtxDUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



on 8/19/2023 8:14 PM, Baolin Wang wrote:
> 
> 
> On 8/15/2023 8:04 PM, Kemeng Shi wrote:
>>
>>
>> on 8/15/2023 4:58 PM, Baolin Wang wrote:
>>>
>>>
>>> On 8/5/2023 7:07 PM, Kemeng Shi wrote:
>>>> We have order = -1 via proactive compaction, the is_via_compact_memory is
>>>> not proper name anymore.
>>>> As cc->order informs the compaction to satisfy a allocation with that
>>>> order, so rename it to compaction_with_allocation_order.
>>>>
>>>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>>>> ---
>>>>    mm/compaction.c | 11 +++++------
>>>>    1 file changed, 5 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/mm/compaction.c b/mm/compaction.c
>>>> index d8416d3dd445..b5a699ed526b 100644
>>>> --- a/mm/compaction.c
>>>> +++ b/mm/compaction.c
>>>> @@ -2055,12 +2055,11 @@ static isolate_migrate_t isolate_migratepages(struct compact_control *cc)
>>>>    }
>>>>      /*
>>>> - * order == -1 is expected when compacting via
>>>> - * /proc/sys/vm/compact_memory
>>>> + * compact to satisfy allocation with target order
>>>>     */
>>>> -static inline bool is_via_compact_memory(int order)
>>>> +static inline bool compaction_with_allocation_order(int order)
>>>
>>> I know naming is hard, but this name is not good enough that can show the compaction mode. But the original one could.
>>>
>> Yes, I agree with this, but name and comment of is_via_compact_memory may
>> mislead reader that order == -1 is equivalent to compaction from
>> /proc/sys/vm/compact_memory.
>> Actually, we have several approaches to trigger compaction with order == -1:
>> 1. via /proc/sys/vm/compact_memory
>> 2. via /sys/devices/system/node/nodex/compact
>> 3. via proactive compact
> 
> They can all be called proactive compaction.
I have considered rename to is_proactive_compaction. But "proactive compaction"
in comments of compaction.c mostly implies to compaction triggerred from
/proc/sys/vm/compaction_proactiveness. So "proactive compaction" itself looks
ambiguous...
> 
>>
>> Instead of indicate compaction is tirggerred by compact_memocy or anything,
>> order == -1 implies if compaction is triggerrred to meet allocation with high
>> order and we will stop compaction if allocation with target order will success.
> 
> IMO, the is_via_compact_memory() function helps people better distinguish the compaction logic we have under direct compaction or kcompactd compaction, while proactive compaction does not concern itself with these details. But compaction_with_allocation_order() will make me just wonder why we should compare with -1. So I don't think this patch is worth it, but as you said above, we can add more comments to make it more clear.
> 
Sure, no insistant on this.
Is it looks good to you just change comment of is_via_compact_memory to:
We need do compaction proactively with order == -1
order == -1 is expected for proactive compaction via:
1. via /proc/sys/vm/compact_memory
2. via /sys/devices/system/node/nodex/compact
3. /proc/sys/vm/compaction_proactiveness

>>>>    {
>>>> -    return order == -1;
>>>> +    return order != -1;
>>>>    }
>>>>      /*
>>>> @@ -2200,7 +2199,7 @@ static enum compact_result __compact_finished(struct compact_control *cc)
>>>>            goto out;
>>>>        }
>>>>    -    if (is_via_compact_memory(cc->order))
>>>> +    if (!compaction_with_allocation_order(cc->order))
>>>>            return COMPACT_CONTINUE;
>>>>          /*
>>>> @@ -2390,7 +2389,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
>>>>          cc->migratetype = gfp_migratetype(cc->gfp_mask);
>>>>    -    if (!is_via_compact_memory(cc->order)) {
>>>> +    if (compaction_with_allocation_order(cc->order)) {
>>>>            unsigned long watermark;
>>>>              /* Allocation can already succeed, nothing to do */
>>>
> 
> 

