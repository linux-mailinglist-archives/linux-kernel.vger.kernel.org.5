Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950977C9D7D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 04:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjJPCqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 22:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjJPCqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 22:46:03 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D909CC1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 19:45:39 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-27d4372322aso1150536a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 19:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697424339; x=1698029139; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EUPjQc944rg0QPHQCfcD1FefPlzKVPcqjXoFv5/puE4=;
        b=VpksfpTjpScasDymaFyoVR+MgVfi4iKwEns3QNLBcm82simaW+ijEZXXr4Skab6hzh
         QRvc7Y3MeI0hGGYIU5uk7g4J4lPLn7KBLnANBHG0ariniKASrkIrBH8myF6oIrf4ledb
         wSjRrf+wSNMHotYPHj9HkdHp2rpNyIBqskb+y4jqmpGrG6iIT7Md3ccNdGXp2/LTWyl6
         z2mIH1gJJpwQ9pIhqZLd+iLmkQ6aKwqfeEIlKgPVi1KjL0tPocggqDIV7IAflBg0Zc/l
         wVbjBXQAWS8wfINYsQbqlcKnzecluzSCyow4A7ARPeZeDABKyW8NJAP8tnE5+M0IRB1z
         hGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697424339; x=1698029139;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EUPjQc944rg0QPHQCfcD1FefPlzKVPcqjXoFv5/puE4=;
        b=Pfutr3y+wqVfXmjG1mb7K0Wmx96obc2TNoW72NGzZukQYevgYcaGySiHCSNoULN/6d
         VLWD7fs1zbUcbDEtVt9SN0qpCE8s4pImNNoTXio9gxcVtXrfB+rCpkLKT0nboz1PmtZb
         jClA/4Zf1n0JgZoa35eOfD2ds4QUQu8QHNMTQ7Zp+uTLH5rEp4sn5ISsjRQPgbBwK2q2
         1yRaRYsSjB7n4TJxD+vwD3XSGIT7EFWeWfMn/5wgTrLWG833uqDr9zpRF6U1F7V1L0+y
         SbBjeaArcpHXqDyjYym/zUkMRFNUAwkHZ5Srhk/HbPdeIY2BSdgOSZLt7YZDsrHoMdL7
         MDOA==
X-Gm-Message-State: AOJu0YxbwkOZfApaZECq2G00dhZIMiUEKVaeeIk2Q0PVHnLy8bW1R3LA
        0YCLsh6SYgJDiwz6xAU8Lh0W5A==
X-Google-Smtp-Source: AGHT+IFAgLEJDohWowu9IlPK+uGPd2lWz/VvgKsmCCbpnGrHdVOBnBzPKcgqGZ33NJB9ZvvNbOiMxw==
X-Received: by 2002:a17:90a:196:b0:27d:3c11:3610 with SMTP id 22-20020a17090a019600b0027d3c113610mr5112371pjc.33.1697424339313;
        Sun, 15 Oct 2023 19:45:39 -0700 (PDT)
Received: from [192.168.6.6] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d8-20020a17090ae28800b0027758c7f585sm3417978pjz.52.2023.10.15.19.45.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Oct 2023 19:45:38 -0700 (PDT)
Message-ID: <7758687f-06c1-d9b2-077a-34e79925a339@bytedance.com>
Date:   Mon, 16 Oct 2023 10:45:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v10 1/5] lib: objpool added: ring-array based lockless
 MPMC
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
From:   "wuqiang.matt" <wuqiang.matt@bytedance.com>
In-Reply-To: <20231016082659.6ca94a5dff368783698753f9@kernel.org>
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

On 2023/10/16 07:26, Masami Hiramatsu (Google) wrote:
> On Mon, 16 Oct 2023 00:06:11 +0800
> "wuqiang.matt" <wuqiang.matt@bytedance.com> wrote:
> 
>> On 2023/10/15 23:43, Masami Hiramatsu (Google) wrote:
>>> On Sun, 15 Oct 2023 13:32:47 +0800
>>> "wuqiang.matt" <wuqiang.matt@bytedance.com> wrote:
>>>
>>>> objpool is a scalable implementation of high performance queue for
>>>> object allocation and reclamation, such as kretprobe instances.
>>>>
>>>> With leveraging percpu ring-array to mitigate hot spots of memory
>>>> contention, it delivers near-linear scalability for high parallel
>>>> scenarios. The objpool is best suited for the following cases:
>>>> 1) Memory allocation or reclamation are prohibited or too expensive
>>>> 2) Consumers are of different priorities, such as irqs and threads
>>>>
>>>> Limitations:
>>>> 1) Maximum objects (capacity) is fixed after objpool creation
>>>> 2) All pre-allocated objects are managed in percpu ring array,
>>>>      which consumes more memory than linked lists
>>>>
>>>
>>> Thanks for updating! This looks good to me except 2 points.
>>>
>>> [...]
>>>> +
>>>> +/* initialize object pool and pre-allocate objects */
>>>> +int objpool_init(struct objpool_head *pool, int nr_objs, int object_size,
>>>> +		gfp_t gfp, void *context, objpool_init_obj_cb objinit,
>>>> +		objpool_fini_cb release)
>>>> +{
>>>> +	int rc, capacity, slot_size;
>>>> +
>>>> +	/* check input parameters */
>>>> +	if (nr_objs <= 0 || nr_objs > OBJPOOL_NR_OBJECT_MAX ||
>>>> +	    object_size <= 0 || object_size > OBJPOOL_OBJECT_SIZE_MAX)
>>>> +		return -EINVAL;
>>>> +
>>>> +	/* align up to unsigned long size */
>>>> +	object_size = ALIGN(object_size, sizeof(long));
>>>> +
>>>> +	/* calculate capacity of percpu objpool_slot */
>>>> +	capacity = roundup_pow_of_two(nr_objs);
>>>
>>> This must be 'roundup_pow_of_two(nr_objs + 1)' because if nr_objs is power
>>> of 2 and all objects are pushed on the same slot, tail == head. This
>>> means empty and full is the same.
>>
>> That won't happen. Would tail and head wrap only when >= 2^32. When all
>> objects are pushed to the same slot, tail will be (head + capacity).
> 
> Ah, indeed. OK.
> 
>>
>>>
>>>> +	if (!capacity)
>>>> +		return -EINVAL;
>>>> +
>>>> +	/* initialize objpool pool */
>>>> +	memset(pool, 0, sizeof(struct objpool_head));
>>>> +	pool->nr_cpus = nr_cpu_ids;
>>>> +	pool->obj_size = object_size;
>>>> +	pool->capacity = capacity;
>>>> +	pool->gfp = gfp & ~__GFP_ZERO;
>>>> +	pool->context = context;
>>>> +	pool->release = release;
>>>> +	slot_size = pool->nr_cpus * sizeof(struct objpool_slot);
>>>> +	pool->cpu_slots = kzalloc(slot_size, pool->gfp);
>>>> +	if (!pool->cpu_slots)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	/* initialize per-cpu slots */
>>>> +	rc = objpool_init_percpu_slots(pool, nr_objs, context, objinit);
>>>> +	if (rc)
>>>> +		objpool_fini_percpu_slots(pool);
>>>> +	else
>>>> +		refcount_set(&pool->ref, pool->nr_objs + 1);
>>>> +
>>>> +	return rc;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(objpool_init);
>>>> +
>>>
>>> [...]
>>>
>>>> +
>>>> +/* drop unused objects and defref objpool for releasing */
>>>> +void objpool_fini(struct objpool_head *pool)
>>>> +{
>>>> +	void *obj;
>>>> +
>>>> +	do {
>>>> +		/* grab object from objpool and drop it */
>>>> +		obj = objpool_pop(pool);
>>>> +
>>>> +		/*
>>>> +		 * drop reference of objpool anyway even if
>>>> +		 * the obj is NULL, since one extra ref upon
>>>> +		 * objpool was already grabbed during pool
>>>> +		 * initialization in objpool_init()
>>>> +		 */
>>>> +		if (refcount_dec_and_test(&pool->ref))
>>>> +			objpool_free(pool);
>>>
>>> Nit: you can call objpool_drop() instead of repeating the same thing here.
>>
>> objpool_drop won't deref objpool if given obj is NULL. But here we need
>> drop objpool anyway even if obj is NULL.
> 
> I guess you decrement for the 'objpool' itself if obj=NULL, but I think
> it is a bit hacky (so you added the comment).
> e.g. rethook is doing something like below.
> 
> ---
> /* extra count for this pool itself */
> count = 1;
> /* make the pool empty */
> while (objpool_pop(pool))
> 	count++;
> 
> if (refcount_sub_and_test(count, &pool->ref))
> 	objpool_free(pool);
> ---

Right, that's reasonable. Better one single atomic operation than multiple.

>>
>>> Thank you,
>>>
>>>> +	} while (obj);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(objpool_fini);
>>>> -- 
>>>> 2.40.1
>>>>
>>
>> Thanks for your time
>>
>>
> 
> 

