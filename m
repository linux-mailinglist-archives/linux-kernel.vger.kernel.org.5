Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7163F76E468
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbjHCJcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234060AbjHCJbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:31:53 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B7910EA;
        Thu,  3 Aug 2023 02:31:51 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RGkBT4wDNz4f40LV;
        Thu,  3 Aug 2023 17:31:45 +0800 (CST)
Received: from [10.174.178.55] (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgAHvbAAdMtkkUzYPQ--.33385S3;
        Thu, 03 Aug 2023 17:31:46 +0800 (CST)
Subject: Re: [PATCH v4 2/2] rcu: Dump memory object info if callback function
 is invalid
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
To:     paulmck@kernel.org
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhen Lei <thunder.leizhen@huawei.com>
References: <20230802130918.1132-1-thunder.leizhen@huaweicloud.com>
 <20230802130918.1132-3-thunder.leizhen@huaweicloud.com>
 <06731ba9-0746-453e-bd1f-b857bd253543@paulmck-laptop>
 <2d6ec086-8457-b9e3-f282-cd302e5573c5@huaweicloud.com>
Message-ID: <2c8a847e-70bb-42ba-f7d8-f33ac6cab03f@huaweicloud.com>
Date:   Thu, 3 Aug 2023 17:31:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <2d6ec086-8457-b9e3-f282-cd302e5573c5@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgAHvbAAdMtkkUzYPQ--.33385S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Xry3XF4DGry7uw48tFWfGrg_yoW3Kr18p3
        4DWFyjkw4kXryUAw4Ivw1FkFWjv395ta1a9an5Crn3Awn0qrn2gFyDtFy5urZ0vryrWr1Y
        qF1YqFsIk3y8J37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
        6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UZ18PUUUUU=
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/3 11:23, Leizhen (ThunderTown) wrote:
> 
> 
> On 2023/8/3 6:40, Paul E. McKenney wrote:
>> On Wed, Aug 02, 2023 at 09:09:18PM +0800, thunder.leizhen@huaweicloud.com wrote:
>>> From: Zhen Lei <thunder.leizhen@huawei.com>
>>>
>>> When a structure containing an RCU callback rhp is (incorrectly) freed
>>> and reallocated after rhp is passed to call_rcu(), it is not unusual for
>>> rhp->func to be set to NULL. This defeats the debugging prints used by
>>> __call_rcu_common() in kernels built with CONFIG_DEBUG_OBJECTS_RCU_HEAD=y,
>>> which expect to identify the offending code using the identity of this
>>> function.
>>>
>>> And in kernels build without CONFIG_DEBUG_OBJECTS_RCU_HEAD=y, things
>>> are even worse, as can be seen from this splat:
>>>
>>> Unable to handle kernel NULL pointer dereference at virtual address 0
>>> ... ...
>>> PC is at 0x0
>>> LR is at rcu_do_batch+0x1c0/0x3b8
>>> ... ...
>>>  (rcu_do_batch) from (rcu_core+0x1d4/0x284)
>>>  (rcu_core) from (__do_softirq+0x24c/0x344)
>>>  (__do_softirq) from (__irq_exit_rcu+0x64/0x108)
>>>  (__irq_exit_rcu) from (irq_exit+0x8/0x10)
>>>  (irq_exit) from (__handle_domain_irq+0x74/0x9c)
>>>  (__handle_domain_irq) from (gic_handle_irq+0x8c/0x98)
>>>  (gic_handle_irq) from (__irq_svc+0x5c/0x94)
>>>  (__irq_svc) from (arch_cpu_idle+0x20/0x3c)
>>>  (arch_cpu_idle) from (default_idle_call+0x4c/0x78)
>>>  (default_idle_call) from (do_idle+0xf8/0x150)
>>>  (do_idle) from (cpu_startup_entry+0x18/0x20)
>>>  (cpu_startup_entry) from (0xc01530)
>>>
>>> This commit therefore adds calls to mem_dump_obj(rhp) to output some
>>> information, for example:
>>>
>>>   slab kmalloc-256 start ffff410c45019900 pointer offset 0 size 256
>>>
>>> This provides the rough size of the memory block and the offset of the
>>> rcu_head structure, which as least provides at least a few clues to help
>>> locate the problem. If the problem is reproducible, additional slab
>>> debugging can be enabled, for example, CONFIG_DEBUG_SLAB=y, which can
>>> provide significantly more information.
>>>
>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>
>> Looks plausible, thank you!
>>
>> What did you do to test this? 
> 
> This test is easier. I wrote a simple one myself.
> 
> static struct my_rcu_node *my_node;
> 
> static bool test_kmem_dump_obj(void)
> {
>         void *p;
> 
>         if (kmem_dump_obj(NULL))
>                 return false;
> 
>         if (kmem_dump_obj((void *)(PAGE_SIZE / 2)))
>                 return false;
> 
>         if (kmem_dump_obj((void *)(PAGE_SIZE - 1)))
>                 return false;
> 
>         if (kmem_dump_obj((void *)PAGE_SIZE))
>                 return false;
> 
>         if (kmem_dump_obj(&my_node))
>                 return false;
> 
>         p = vmalloc(0x100000);
>         WARN_ON(!p);
>         if (kmem_dump_obj(p)) {
>                 vfree(p);
>                 return false;
>         }
>         vfree(p);
> 
>         p = kmalloc(0x100, GFP_KERNEL);
>         WARN_ON(!p);
>         if (!kmem_dump_obj(p)) {
>                 kfree(p);
>                 return false;
>         }
>         if (kmem_dump_obj((void *)(((unsigned long)p << 4) >> 4))) {
>                 kfree(p);
>                 return false;
>         }
>         kfree(p);
> 
>         return true;
> }
> 
> static int tst_proc_show(struct seq_file *m, void *v)
> {
>         if (!test_kmem_dump_obj()) {
>                 seq_printf(m, "test_kmem_dump_obj failed\n");
>                 return 0;
>         }
> 
>         my_node = kmalloc(sizeof(*my_node), GFP_KERNEL);
>         if (!my_node) {
>                 seq_printf(m, "kmalloc failed\n");
>                 return 0;
>         }
> 
>         call_rcu(&my_node->node, my_rcu_cb);
>         my_node->node.func = NULL;
> 
>         return 0;
> }
> 
> 
>>
>> One option is the object_debug module parameter to rcutorture, which is
>> described here: https://paulmck.livejournal.com/61432.html
> 
> OK, thanks for your info. I'll study the RCU self-test program rcutorture later.
> 
>>
>>> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>>
>> Not a big problem, but not a good habit to get into...  I add my own
>> Signed-off-by when I pull patches into my tree.  Or if you are thinking
>> in terms of sending this to mainline using some other path, when I am
>> good with it, I would give you a tag to use.
> 
> Oh, Sorry. It seems that I forgot to delete your Signed-off-by in v2.
> Oops! you reminded me once before. After v1, you helped modify the
> description and pull it into your tree. I got it from 'dev' branch.
> 
>>
>> So were you looking for me to take these two patches?
> 
> Yes, it could be quicker. Of course, I can wait for patch 1/2 upstream,
> then repost patch 2/2. In fact, I also want to dump part of the slab
> object, I've already written the code. In order not to affect the current
> user of mem_dump_obj(), a new parameter need to be added to kmem_dump_obj().
> I will post v5 with this patch later.

I measured it carefully, and the code would look ugly when I added a parameter.
In fact, the three places where mem_dump_obj() is currently called are for
debugging purposes, and dump the memory of slab object is not bad for them.

> 
>>
>> 							Thanx, Paul
>>
>>> ---
>>>  kernel/rcu/rcu.h      | 7 +++++++
>>>  kernel/rcu/srcutiny.c | 1 +
>>>  kernel/rcu/srcutree.c | 1 +
>>>  kernel/rcu/tasks.h    | 1 +
>>>  kernel/rcu/tiny.c     | 1 +
>>>  kernel/rcu/tree.c     | 1 +
>>>  6 files changed, 12 insertions(+)
>>>
>>> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
>>> index d1dcb09750efbd6..bc81582238b9846 100644
>>> --- a/kernel/rcu/rcu.h
>>> +++ b/kernel/rcu/rcu.h
>>> @@ -10,6 +10,7 @@
>>>  #ifndef __LINUX_RCU_H
>>>  #define __LINUX_RCU_H
>>>  
>>> +#include <linux/slab.h>
>>>  #include <trace/events/rcu.h>
>>>  
>>>  /*
>>> @@ -248,6 +249,12 @@ static inline void debug_rcu_head_unqueue(struct rcu_head *head)
>>>  }
>>>  #endif	/* #else !CONFIG_DEBUG_OBJECTS_RCU_HEAD */
>>>  
>>> +static inline void debug_rcu_head_callback(struct rcu_head *rhp)
>>> +{
>>> +	if (unlikely(!rhp->func))
>>> +		kmem_dump_obj(rhp);
>>> +}
>>> +
>>>  extern int rcu_cpu_stall_suppress_at_boot;
>>>  
>>>  static inline bool rcu_stall_is_suppressed_at_boot(void)
>>> diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
>>> index 336af24e0fe358a..c38e5933a5d6937 100644
>>> --- a/kernel/rcu/srcutiny.c
>>> +++ b/kernel/rcu/srcutiny.c
>>> @@ -138,6 +138,7 @@ void srcu_drive_gp(struct work_struct *wp)
>>>  	while (lh) {
>>>  		rhp = lh;
>>>  		lh = lh->next;
>>> +		debug_rcu_head_callback(rhp);
>>>  		local_bh_disable();
>>>  		rhp->func(rhp);
>>>  		local_bh_enable();
>>> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
>>> index f1a905200fc2f79..833a8f848a90ae6 100644
>>> --- a/kernel/rcu/srcutree.c
>>> +++ b/kernel/rcu/srcutree.c
>>> @@ -1710,6 +1710,7 @@ static void srcu_invoke_callbacks(struct work_struct *work)
>>>  	rhp = rcu_cblist_dequeue(&ready_cbs);
>>>  	for (; rhp != NULL; rhp = rcu_cblist_dequeue(&ready_cbs)) {
>>>  		debug_rcu_head_unqueue(rhp);
>>> +		debug_rcu_head_callback(rhp);
>>>  		local_bh_disable();
>>>  		rhp->func(rhp);
>>>  		local_bh_enable();
>>> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
>>> index 7294be62727b12c..148ac6a464bfb12 100644
>>> --- a/kernel/rcu/tasks.h
>>> +++ b/kernel/rcu/tasks.h
>>> @@ -538,6 +538,7 @@ static void rcu_tasks_invoke_cbs(struct rcu_tasks *rtp, struct rcu_tasks_percpu
>>>  	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
>>>  	len = rcl.len;
>>>  	for (rhp = rcu_cblist_dequeue(&rcl); rhp; rhp = rcu_cblist_dequeue(&rcl)) {
>>> +		debug_rcu_head_callback(rhp);
>>>  		local_bh_disable();
>>>  		rhp->func(rhp);
>>>  		local_bh_enable();
>>> diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
>>> index 42f7589e51e09e7..fec804b7908032d 100644
>>> --- a/kernel/rcu/tiny.c
>>> +++ b/kernel/rcu/tiny.c
>>> @@ -97,6 +97,7 @@ static inline bool rcu_reclaim_tiny(struct rcu_head *head)
>>>  
>>>  	trace_rcu_invoke_callback("", head);
>>>  	f = head->func;
>>> +	debug_rcu_head_callback(head);
>>>  	WRITE_ONCE(head->func, (rcu_callback_t)0L);
>>>  	f(head);
>>>  	rcu_lock_release(&rcu_callback_map);
>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>>> index 7c79480bfaa04e4..927c5ba0ae42269 100644
>>> --- a/kernel/rcu/tree.c
>>> +++ b/kernel/rcu/tree.c
>>> @@ -2135,6 +2135,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
>>>  		trace_rcu_invoke_callback(rcu_state.name, rhp);
>>>  
>>>  		f = rhp->func;
>>> +		debug_rcu_head_callback(rhp);
>>>  		WRITE_ONCE(rhp->func, (rcu_callback_t)0L);
>>>  		f(rhp);
>>>  
>>> -- 
>>> 2.34.1
>>>
>> .
>>
> 

-- 
Regards,
  Zhen Lei

