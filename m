Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D564F76CB82
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 13:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbjHBLMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 07:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjHBLMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:12:39 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9B9123;
        Wed,  2 Aug 2023 04:12:38 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RG8TD0yGcz4f4y0p;
        Wed,  2 Aug 2023 19:12:32 +0800 (CST)
Received: from [10.174.178.55] (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgCnD7PIOcpkYBWPPQ--.20712S3;
        Wed, 02 Aug 2023 19:11:06 +0800 (CST)
Subject: Re: [PATCH v3 1/2] mm: Provide empty function for kmem_dump_obj()
 when CONFIG_PRINTK=n
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, openeuler <kernel@openeuler.org>
References: <20230802034518.1115-1-thunder.leizhen@huaweicloud.com>
 <20230802034518.1115-2-thunder.leizhen@huaweicloud.com>
 <ZMnUR61eFmO014EL@casper.infradead.org>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Message-ID: <91233a90-94bb-0318-3bcb-10a4403cd526@huaweicloud.com>
Date:   Wed, 2 Aug 2023 19:11:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ZMnUR61eFmO014EL@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgCnD7PIOcpkYBWPPQ--.20712S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar4DZw1xXr17tr43WF4rXwb_yoW8Xryxp3
        saqa9xWrWUAr9rJrn7A3ZakFy5Gr48XrnxC3Z0qw45Zr18X397Z3s7K34YqFn8JFy7Xr10
        yaykuFs7A3yqyrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
        WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU13rcDUUUUU==
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/2 11:57, Matthew Wilcox wrote:
> On Wed, Aug 02, 2023 at 11:45:16AM +0800, thunder.leizhen@huaweicloud.com wrote:
>> +++ b/include/linux/slab.h
>> @@ -246,6 +246,9 @@ size_t ksize(const void *objp);
>>  #ifdef CONFIG_PRINTK
>>  bool kmem_valid_obj(void *object);
>>  void kmem_dump_obj(void *object);
>> +#else
>> +static inline bool kmem_valid_obj(void *object) { return false; }
> 
> That is very confusing.  kmem_valid_obj() looks like a function which
> should exist regardless of CONFIG_PRINTK and to have it always return
> false if CONFIG_PRINTK isn't set seems weird.

Yes, I noticed it, but I didn't come up with a good idea.

> 
> I see we have one caller of kmem_valid_obj() right now.  Which means it
> shouldn't be an EXPORT_SYMBOL since that caller is not a module.
> 
> I think the right solution is to convert kmem_dump_obj() to
> work the same way as vmalloc_dump_obj().  ie:

Okay, it's a good suggestion.

In fact, kmem_dump_obj() also does what kmem_valid_obj() does, except
that it will print warning if the check fails. So, do as you suggest,
the duplicated code can be eliminated.

> 
> +++ b/mm/util.c
> @@ -1057,11 +1057,8 @@ void mem_dump_obj(void *object)
>  {
>         const char *type;
> 
> -       if (kmem_valid_obj(object)) {
> -               kmem_dump_obj(object);
> +       if (kmem_dump_obj(object))
>                 return;
> -       }
> -
>         if (vmalloc_dump_obj(object))
>                 return;
> 
> ... with corresponding changes to eliminate kmem_valid_obj() as a
> symbol.
> 
> .
> 

-- 
Regards,
  Zhen Lei

