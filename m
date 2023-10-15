Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CFA7C99E3
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 18:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjJOQGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 12:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjJOQG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 12:06:27 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED388A3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 09:06:25 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c9e072472bso21328475ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 09:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697385985; x=1697990785; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+m9TMVLDEkbZEDJaRE0ie/5KoWcOFR+k5kgu1kYC8zg=;
        b=G8RMvi8Pu5mvAJmnbzAVK/14mESc595psYbXCpwU0AveCOhKql4ZFZ1mWGuNzCErdE
         KNAhzQ35hYi1f8oG+PMWKSu2+YvVJWjkTbX8FBKec7aNVU/LOjg0jVYaJplrPR7QDyuD
         XiAATpfA8si+rGcUNihfaiGTuyEunkbgK+d8xU5LHheZB235xx6W0PvPGZKUXhLMKh35
         Cuhf6YMp7Q9UpZhMC0D/hCbpmt8XbaZVkZg65qZbb/Q2SnnKEe4vakfx3Hgy4RbZWzO5
         wXeHpv+YE9dBnkYhUOs6HR8FKtI41rxfvjBnpMtOrGlJXeuHCYZKlmtIByTr9+KERbQ0
         pI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697385985; x=1697990785;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+m9TMVLDEkbZEDJaRE0ie/5KoWcOFR+k5kgu1kYC8zg=;
        b=RMZSHE8U0Cvdfzl9iJq8joLTIZXDhD/vx0L2C6n2KcjF4AjS3BrmfLJIotd8s/RbTd
         qZrHKxmBCfZmdMTlVs/k4csVUoiCRpE2SnZF5SzZm1DZKGvgvUL2zC/bAZOjnnWXx4Pu
         DmCKuDKph+SWkwC4JixtKI3Ls3DLOQ5Ndb2A3AbcP0h9s2idquCHsMtvHwLKQJIf4aIX
         7sNbCJ9JLR8+ktDged74Dt2LoPftxQa6peMQVeUYBf112Ulxf7cxjOutidvIIhvGTsZk
         G1hKhB0bUZVFbNZRizdOXoM9oYa7mc6GE5frhAmCNfwISF1U+dbNHYyymIqsXBNilR6b
         tIdw==
X-Gm-Message-State: AOJu0YxAmlE3FGbrgGrziBNneIULMdhzrk5/HBeR2PYEHb56e+p4jDMK
        fJitplUVZDHlHUfN/StDhKZGZg==
X-Google-Smtp-Source: AGHT+IErqogL25VeiX9aK1IlyGTRWzr2zCYr06wCfdDmbs8ZozaBhw6D5Al91KGjpayqICdjk8IvxA==
X-Received: by 2002:a17:903:187:b0:1c3:749f:6a5d with SMTP id z7-20020a170903018700b001c3749f6a5dmr32519021plg.4.1697385985387;
        Sun, 15 Oct 2023 09:06:25 -0700 (PDT)
Received: from [192.168.3.101] ([104.28.240.135])
        by smtp.gmail.com with ESMTPSA id e4-20020a17090301c400b001aaf2e8b1eesm6951960plh.248.2023.10.15.09.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Oct 2023 09:06:24 -0700 (PDT)
Message-ID: <1516f7d1-e11b-3244-76b9-e6ddafc29a32@bytedance.com>
Date:   Mon, 16 Oct 2023 00:06:11 +0800
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
From:   "wuqiang.matt" <wuqiang.matt@bytedance.com>
Subject: Re: [PATCH v10 1/5] lib: objpool added: ring-array based lockless
 MPMC
In-Reply-To: <20231016004356.b5f3f815cb8d7c0994934332@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/15 23:43, Masami Hiramatsu (Google) wrote:
> On Sun, 15 Oct 2023 13:32:47 +0800
> "wuqiang.matt" <wuqiang.matt@bytedance.com> wrote:
> 
>> objpool is a scalable implementation of high performance queue for
>> object allocation and reclamation, such as kretprobe instances.
>>
>> With leveraging percpu ring-array to mitigate hot spots of memory
>> contention, it delivers near-linear scalability for high parallel
>> scenarios. The objpool is best suited for the following cases:
>> 1) Memory allocation or reclamation are prohibited or too expensive
>> 2) Consumers are of different priorities, such as irqs and threads
>>
>> Limitations:
>> 1) Maximum objects (capacity) is fixed after objpool creation
>> 2) All pre-allocated objects are managed in percpu ring array,
>>     which consumes more memory than linked lists
>>
> 
> Thanks for updating! This looks good to me except 2 points.
> 
> [...]
>> +
>> +/* initialize object pool and pre-allocate objects */
>> +int objpool_init(struct objpool_head *pool, int nr_objs, int object_size,
>> +		gfp_t gfp, void *context, objpool_init_obj_cb objinit,
>> +		objpool_fini_cb release)
>> +{
>> +	int rc, capacity, slot_size;
>> +
>> +	/* check input parameters */
>> +	if (nr_objs <= 0 || nr_objs > OBJPOOL_NR_OBJECT_MAX ||
>> +	    object_size <= 0 || object_size > OBJPOOL_OBJECT_SIZE_MAX)
>> +		return -EINVAL;
>> +
>> +	/* align up to unsigned long size */
>> +	object_size = ALIGN(object_size, sizeof(long));
>> +
>> +	/* calculate capacity of percpu objpool_slot */
>> +	capacity = roundup_pow_of_two(nr_objs);
> 
> This must be 'roundup_pow_of_two(nr_objs + 1)' because if nr_objs is power
> of 2 and all objects are pushed on the same slot, tail == head. This
> means empty and full is the same.

That won't happen. Would tail and head wrap only when >= 2^32. When all
objects are pushed to the same slot, tail will be (head + capacity).

> 
>> +	if (!capacity)
>> +		return -EINVAL;
>> +
>> +	/* initialize objpool pool */
>> +	memset(pool, 0, sizeof(struct objpool_head));
>> +	pool->nr_cpus = nr_cpu_ids;
>> +	pool->obj_size = object_size;
>> +	pool->capacity = capacity;
>> +	pool->gfp = gfp & ~__GFP_ZERO;
>> +	pool->context = context;
>> +	pool->release = release;
>> +	slot_size = pool->nr_cpus * sizeof(struct objpool_slot);
>> +	pool->cpu_slots = kzalloc(slot_size, pool->gfp);
>> +	if (!pool->cpu_slots)
>> +		return -ENOMEM;
>> +
>> +	/* initialize per-cpu slots */
>> +	rc = objpool_init_percpu_slots(pool, nr_objs, context, objinit);
>> +	if (rc)
>> +		objpool_fini_percpu_slots(pool);
>> +	else
>> +		refcount_set(&pool->ref, pool->nr_objs + 1);
>> +
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL_GPL(objpool_init);
>> +
> 
> [...]
> 
>> +
>> +/* drop unused objects and defref objpool for releasing */
>> +void objpool_fini(struct objpool_head *pool)
>> +{
>> +	void *obj;
>> +
>> +	do {
>> +		/* grab object from objpool and drop it */
>> +		obj = objpool_pop(pool);
>> +
>> +		/*
>> +		 * drop reference of objpool anyway even if
>> +		 * the obj is NULL, since one extra ref upon
>> +		 * objpool was already grabbed during pool
>> +		 * initialization in objpool_init()
>> +		 */
>> +		if (refcount_dec_and_test(&pool->ref))
>> +			objpool_free(pool);
> 
> Nit: you can call objpool_drop() instead of repeating the same thing here.

objpool_drop won't deref objpool if given obj is NULL. But here we need
drop objpool anyway even if obj is NULL.

> Thank you,
> 
>> +	} while (obj);
>> +}
>> +EXPORT_SYMBOL_GPL(objpool_fini);
>> -- 
>> 2.40.1
>>

Thanks for you time


