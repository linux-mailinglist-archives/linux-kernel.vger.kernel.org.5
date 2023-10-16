Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3017CACDD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbjJPPFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbjJPPFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:05:02 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A65B9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:04:38 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-57bc2c2f13dso2668449eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697468678; x=1698073478; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QffYa8f47+Hk7lnd37D6vR0fhcrZUpT4hXtPg8meDQQ=;
        b=hILyt+BQ8JqmohI/AA30fdxUp+xU5gbVWZdRFcnuVuCzMAlpa1fVjVPyoqQxDsJjDw
         gZnnmeRYLSJa1COgAC4BzMFmCcJJ8cyqPFfCOIoLNEdmxyNB9bPQWXxTIhHEikCfCCz2
         kPUeCeM3PAEH+20yXfuZaGFOAMeM5+oNeKbhKuMtzKHZlutnBT+C5HvMdBB4WzxnfBZk
         US8k2HTHUyWhiDKqPPAUGWMueFGB+vYG12l9bf6/yWmYL7DOGao1imuEVvmqvpMYgulP
         cVoL5a/FJh22GEl8SFVZRecvWebMdWbdzvoNkoFyT9z/Bd2AAq49PAC4LqoalHRRgF8B
         nw+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697468678; x=1698073478;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QffYa8f47+Hk7lnd37D6vR0fhcrZUpT4hXtPg8meDQQ=;
        b=mTteeiPtLTCespgsZKs+Ynuf4yxIlSQ4ulqfrrf17dZedNKUYyWY2a36W8CONhVZ+W
         dk12e2OdOcqfeFxAsVugLnUCdvHfP2F6Bs7OVDQDHs7pRp8iAhk6XbkbiXVmYp6IY4zg
         ZyxjyZbPD1YgbEu8oUF8Vmpz3mCi73mnpvB7g0P7ehcfe17v+QEmrQLdtKUHlKoRFirc
         lGzcty4pVmfnPAsmAx7RKX0mGr2yj62Rt5yN5AeazJjHNtBOpwzYrDrQkq2TGwXhTnY6
         wAuKYMWIQ7FzK/I037rIqNPVW6SNIVAGk7gsEWPHQ5lbTY6r3JwH46oeANL6Vyxt2HhL
         O4Kw==
X-Gm-Message-State: AOJu0YzKtaGgNdgomzpZk41Um+kSm2iGqv6YrrbDewxS3KBatN2Ca7VV
        0uWBny0hR7EtkzWnJzAMIBl2Kg==
X-Google-Smtp-Source: AGHT+IGEb/Q1yDgEiZkPVrhSGZgdtW5OReTQ5vXAgMHStfsssab54otQk27qGWCl6TRMBqZw9TVhJg==
X-Received: by 2002:a05:6358:2624:b0:15b:249:b520 with SMTP id l36-20020a056358262400b0015b0249b520mr39351218rwc.7.1697468678028;
        Mon, 16 Oct 2023 08:04:38 -0700 (PDT)
Received: from [10.4.56.220] ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id bl17-20020a056a00281100b006be047268d5sm2706849pfb.174.2023.10.16.08.04.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 08:04:37 -0700 (PDT)
Message-ID: <77fa132c-dcc2-ebf2-bedb-7e4f3d393426@bytedance.com>
Date:   Mon, 16 Oct 2023 23:04:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
From:   "wuqiang.matt" <wuqiang.matt@bytedance.com>
Subject: Re: [PATCH v10 1/5] lib: objpool added: ring-array based lockless
 MPMC
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     linux-trace-kernel@vger.kernel.org, davem@davemloft.net,
        anil.s.keshavamurthy@intel.com, naveen.n.rao@linux.ibm.com,
        rostedt@goodmis.org, peterz@infradead.org,
        akpm@linux-foundation.org, sander@svanheule.net,
        ebiggers@google.com, dan.j.williams@intel.com, jpoimboe@kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com, mattwu@163.com
References: <20231015053251.707442-1-wuqiang.matt@bytedance.com>
 <20231015053251.707442-2-wuqiang.matt@bytedance.com>
 <20231016004356.b5f3f815cb8d7c0994934332@kernel.org>
 <1516f7d1-e11b-3244-76b9-e6ddafc29a32@bytedance.com>
 <20231016082659.6ca94a5dff368783698753f9@kernel.org>
 <7758687f-06c1-d9b2-077a-34e79925a339@bytedance.com>
 <20231016211837.b6d425d8ed760bb3306910ae@kernel.org>
Content-Language: en-US
In-Reply-To: <20231016211837.b6d425d8ed760bb3306910ae@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/16 20:18, Masami Hiramatsu (Google) wrote:
> Hi Wuqiang,
> 
> On Mon, 16 Oct 2023 10:45:30 +0800
> "wuqiang.matt" <wuqiang.matt@bytedance.com> wrote:
> 
>> On 2023/10/16 07:26, Masami Hiramatsu (Google) wrote:
>>> On Mon, 16 Oct 2023 00:06:11 +0800
>>> "wuqiang.matt" <wuqiang.matt@bytedance.com> wrote:
>>>
>>>> On 2023/10/15 23:43, Masami Hiramatsu (Google) wrote:
>>>>> On Sun, 15 Oct 2023 13:32:47 +0800
>>>>> "wuqiang.matt" <wuqiang.matt@bytedance.com> wrote:
>>>>>
>>>>>> objpool is a scalable implementation of high performance queue for
>>>>>> object allocation and reclamation, such as kretprobe instances.
>>>>>>
>>>>>> With leveraging percpu ring-array to mitigate hot spots of memory
>>>>>> contention, it delivers near-linear scalability for high parallel
>>>>>> scenarios. The objpool is best suited for the following cases:
>>>>>> 1) Memory allocation or reclamation are prohibited or too expensive
>>>>>> 2) Consumers are of different priorities, such as irqs and threads
>>>>>>
>>>>>> Limitations:
>>>>>> 1) Maximum objects (capacity) is fixed after objpool creation
>>>>>> 2) All pre-allocated objects are managed in percpu ring array,
>>>>>>       which consumes more memory than linked lists
>>>>>>
>>>>>
>>>>> Thanks for updating! This looks good to me except 2 points.
>>>>>
>>>>> [...]
>>>>>> +
>>>>>> +/* initialize object pool and pre-allocate objects */
>>>>>> +int objpool_init(struct objpool_head *pool, int nr_objs, int object_size,
>>>>>> +		gfp_t gfp, void *context, objpool_init_obj_cb objinit,
>>>>>> +		objpool_fini_cb release)
>>>>>> +{
>>>>>> +	int rc, capacity, slot_size;
>>>>>> +
>>>>>> +	/* check input parameters */
>>>>>> +	if (nr_objs <= 0 || nr_objs > OBJPOOL_NR_OBJECT_MAX ||
>>>>>> +	    object_size <= 0 || object_size > OBJPOOL_OBJECT_SIZE_MAX)
>>>>>> +		return -EINVAL;
>>>>>> +
>>>>>> +	/* align up to unsigned long size */
>>>>>> +	object_size = ALIGN(object_size, sizeof(long));
>>>>>> +
>>>>>> +	/* calculate capacity of percpu objpool_slot */
>>>>>> +	capacity = roundup_pow_of_two(nr_objs);
>>>>>
>>>>> This must be 'roundup_pow_of_two(nr_objs + 1)' because if nr_objs is power
>>>>> of 2 and all objects are pushed on the same slot, tail == head. This
>>>>> means empty and full is the same.
>>>>
>>>> That won't happen. Would tail and head wrap only when >= 2^32. When all
>>>> objects are pushed to the same slot, tail will be (head + capacity).
>>>
>>> Ah, indeed. OK.
>>>
>>>>
>>>>>
>>>>>> +	if (!capacity)
>>>>>> +		return -EINVAL;
>>>>>> +
>>>>>> +	/* initialize objpool pool */
>>>>>> +	memset(pool, 0, sizeof(struct objpool_head));
>>>>>> +	pool->nr_cpus = nr_cpu_ids;
>>>>>> +	pool->obj_size = object_size;
>>>>>> +	pool->capacity = capacity;
>>>>>> +	pool->gfp = gfp & ~__GFP_ZERO;
>>>>>> +	pool->context = context;
>>>>>> +	pool->release = release;
>>>>>> +	slot_size = pool->nr_cpus * sizeof(struct objpool_slot);
>>>>>> +	pool->cpu_slots = kzalloc(slot_size, pool->gfp);
>>>>>> +	if (!pool->cpu_slots)
>>>>>> +		return -ENOMEM;
>>>>>> +
>>>>>> +	/* initialize per-cpu slots */
>>>>>> +	rc = objpool_init_percpu_slots(pool, nr_objs, context, objinit);
>>>>>> +	if (rc)
>>>>>> +		objpool_fini_percpu_slots(pool);
>>>>>> +	else
>>>>>> +		refcount_set(&pool->ref, pool->nr_objs + 1);
>>>>>> +
>>>>>> +	return rc;
>>>>>> +}
>>>>>> +EXPORT_SYMBOL_GPL(objpool_init);
>>>>>> +
>>>>>
>>>>> [...]
>>>>>
>>>>>> +
>>>>>> +/* drop unused objects and defref objpool for releasing */
>>>>>> +void objpool_fini(struct objpool_head *pool)
>>>>>> +{
>>>>>> +	void *obj;
>>>>>> +
>>>>>> +	do {
>>>>>> +		/* grab object from objpool and drop it */
>>>>>> +		obj = objpool_pop(pool);
>>>>>> +
>>>>>> +		/*
>>>>>> +		 * drop reference of objpool anyway even if
>>>>>> +		 * the obj is NULL, since one extra ref upon
>>>>>> +		 * objpool was already grabbed during pool
>>>>>> +		 * initialization in objpool_init()
>>>>>> +		 */
>>>>>> +		if (refcount_dec_and_test(&pool->ref))
>>>>>> +			objpool_free(pool);
>>>>>
>>>>> Nit: you can call objpool_drop() instead of repeating the same thing here.
>>>>
>>>> objpool_drop won't deref objpool if given obj is NULL. But here we need
>>>> drop objpool anyway even if obj is NULL.
>>>
>>> I guess you decrement for the 'objpool' itself if obj=NULL, but I think
>>> it is a bit hacky (so you added the comment).
>>> e.g. rethook is doing something like below.
>>>
>>> ---
>>> /* extra count for this pool itself */
>>> count = 1;
>>> /* make the pool empty */
>>> while (objpool_pop(pool))
>>> 	count++;
>>>
>>> if (refcount_sub_and_test(count, &pool->ref))
>>> 	objpool_free(pool);
>>> ---
>>
>> Right, that's reasonable. Better one single atomic operation than multiple.
> 
> I found another comment issue about a small window which this may not work.
> This is not a real issue for this series because this doesn't happen on
> rethook/kretprobe, but if you apply this to other use-case, it must be
> cared.
> 
> Since we use reserve-commit on 'push' operation, this 'pop' loop will miss
> an object which is under 'push' op. I mean
> 
> CPU0                    CPU1
> 
> objpool_fini() {
> do {
>                           objpool_push() {
>                              update slot->tail; // reserve
>    obj = objpool_pop();
>                              update slot->last;  // commit
> } while (obj);
> 
> In this case, the refcount can not be 0 and we can not release objpool.
> To avoid this, we make sure all ongoing 'push()' must be finished.
> 
> Actually in the rethook/kretprobe, it already sync the rcu so this doesn't
> happen. So you should document it the user must use RCU sync after stop
> using the objpool, then call objpool_fini().
> 
> E.g.
> 
> start_using() {
> objpool_init();
> active = true;
> }
> 
> obj_alloc() {
> rcu_read_lock();
> if (active)
> 	obj = objpool_pop();
> else
> 	obj = NULL;
> rcu_read_unlock();
> }
> 
> /* use obj for something, it is OK to change the context */
> 
> obj_return() {
> rcu_read_lock();
> if (active)
> 	objpool_push(obj);
> else
> 	objpool_drop(obj);
> rcu_read_unlock();
> }
> 
> /* kretprobe style */
> stop_using() {
> active = false;
> synchronize_rcu();
> objpool_fini();
> }
> 
> /* rethook style */
> stop_using() {
> active = false;
> call_rcu(objpool_fini);
> }
> 
> Hmm, yeah, if we can add this 'active' flag to objpool, it is good. But
> since kretprobe has different design of the interface, it is hard.
> Anyway, can you add a comment that user must ensure that any 'push' including
> ongoing one does not happen while 'fini'? objpool does not care that so user
> must take care of that. For example using rcu_read_lock() for the 'push/pop'
> operation and rcu-sync before 'fini' operation.

Sure, I'll refine the comments. I prefer that it's user's duty to make sure
there are no outstanding objpool_push on the fly when calling objpool_fini.
All usecases like kretprobe/rethook/test_objpool are using rcu to handle the
asynchronous releasing of objpool. For synchronous cases, user can just call
object_free to release the whole objpool, which is also acceptable.

> Thanks,
> 
>>
>>>>
>>>>> Thank you,
>>>>>
>>>>>> +	} while (obj);
>>>>>> +}
>>>>>> +EXPORT_SYMBOL_GPL(objpool_fini);
>>>>>> -- 
>>>>>> 2.40.1
>>>>>>
>>>>
>>>> Thanks for your time
>>>>
>>>>
>>>
>>>
>>
> 
> 


