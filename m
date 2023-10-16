Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542667CACC3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbjJPPBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233877AbjJPPA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:00:56 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6A7106
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:00:47 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c9b7c234a7so39586065ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697468447; x=1698073247; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QffYa8f47+Hk7lnd37D6vR0fhcrZUpT4hXtPg8meDQQ=;
        b=OPd9R4BAjFy/Hf7BsPucUo8+gq140S9EJxMPAQhI5IhMX0tLwpdUN8VBJ76ym2DYxP
         S03DD+MEIt5fWzuKORDOjtPa7Fi7og+CLesqi/8P28EvdJ+UdjKXEg/FkbWZw0WJ2yFt
         LBpcrNm1sHSVqg925m4tRJc2XlNTZH0Uq7YAgyuDoxKJ2+hrx5Y98P1jh3ZpVCxAGqQV
         sVCIUH7/j+XLW7dcT3Soa64QPHO6Ht+NaUWjtDRLVk5nEQK6igUY0iPzn0Kc05zZyQbm
         uwqGoiJ1wmHOJ87Xq/yFanIgwF2PB0xd8FQEOf3dL8Hq9zIemks+L8wIxkU5mGodpCpP
         3rYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697468447; x=1698073247;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QffYa8f47+Hk7lnd37D6vR0fhcrZUpT4hXtPg8meDQQ=;
        b=RMAAqXSHopOJI0k4nUv+Fa9zYrEvBPac88MbsEyMxF6eoXm+Qo9k69SOUUmy0NankB
         QgcrdGHpc5CtCsrKH2wKruKMAF6/xBDH71m+Eq4cqV/pG329ZCf51xRJ2e237PR73B7B
         YCFUHxRGUQnLAC+Vh3g2RXG/lkm9VHpr+ENqkY8ycUY3T3TlwgVHO39cwaMpmbr3QbGx
         Rspget4rw0rxbUiiNnmMMG1BvSmXm6OLcMTxQRsPaLI9MOfYc+mSPv1JN79BeAyDYmmV
         2+UONYdUoQkRgeXgzcK3U/pxoS5lw8VmBp0LfUovlf0Zu1MZWc/iSHTA9zZ0sqiwED7H
         s2+g==
X-Gm-Message-State: AOJu0YzBtjrDDoGsPz/aI7NSgMLRRHzNIkEpcLDrYAfquP6DtPZgGJO3
        uBmXozCsJkTWFIp2IAotnTEDWw==
X-Google-Smtp-Source: AGHT+IHKxPEZ5jm64Sthy6b0eJMKd1mmMO0rwHmS7V7YdwjOzZCUdt9CYFnWzLHLLsgbqmcyOqYUQA==
X-Received: by 2002:a17:903:248:b0:1c7:495c:87e0 with SMTP id j8-20020a170903024800b001c7495c87e0mr41801337plh.37.1697468447051;
        Mon, 16 Oct 2023 08:00:47 -0700 (PDT)
Received: from [192.168.3.101] ([104.28.240.135])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c21500b001c771740da4sm7382844pll.195.2023.10.16.08.00.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 08:00:45 -0700 (PDT)
Message-ID: <ebccb78c-df24-ea74-c0ee-c5f8d195290e@bytedance.com>
Date:   Mon, 16 Oct 2023 23:00:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Content-Language: en-US
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
From:   "wuqiang.matt" <wuqiang.matt@bytedance.com>
Subject: Re: [PATCH v10 1/5] lib: objpool added: ring-array based lockless
 MPMC
In-Reply-To: <20231016211837.b6d425d8ed760bb3306910ae@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

