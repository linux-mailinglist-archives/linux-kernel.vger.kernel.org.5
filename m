Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074107D4534
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 03:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjJXB5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 21:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbjJXB5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 21:57:49 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F6FBC
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 18:57:25 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6bee11456baso3140054b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 18:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698112645; x=1698717445; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d4ilQaCjBFof12nTMUAKVjh1+Nzxbc/fLlZlSC9amDc=;
        b=E3HxIfLkNaJBiL2cTNItxhFt7AoqX1CW9MOU2b9DRoxNs4RjARdy2/Tikve7xhYKIU
         MvXQzvkvRyT67pwZUiQjbtbpjX9+93zrIYYNoxljJr6kyi+ZvuBW2kzETTGhZy03xQyw
         oi9l9enTL+9jbHYrERiwPY4ZfDGQREEW1XhId1+Qfc0icxt86VXhaEP7ZJvNWcY9ADjg
         YwYh0xRW+/nRfJC5GUZ9KJ/Ax3q9WDQApdzfZGJImXdVfathFJQXHMFxqVrpLCjDxLLg
         DJJxlCr/Kt5szqT8nxlu2Os1jaM6AbiaSGYUtG1+HmcHzZH9cXLQ6ZO6/2WDTkb5LIVI
         /jRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698112645; x=1698717445;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d4ilQaCjBFof12nTMUAKVjh1+Nzxbc/fLlZlSC9amDc=;
        b=cbymRCoxyIWfi+z8Cpt7Oh4sBkQr7BsVk+vsh8vSVmUyV/7hqYsXsSNZEyM/xBYNK7
         3k8IHD1UkHZUhE7weWYk6yMQOzmeIX4y2Jj9Ub8RKEQg5T35dGZInubURuBAf6K6/9uO
         SUog9PBciMeUoSl7V+ay3RPNQQgK1UMeQT4afMmZTvRK6B6hmSPvls87gQFROSkNSuX3
         kSNYXF8JL7D03VVK4LVu7w4RhIkPdW7nKWZlerB4uYTKwnC2yhWqU7lFNqV/pdPloQMS
         3JSNdJfG2P+XYwgQoFZv+RbHFr/2ERCijMfHFxX7t8p+c99FLt2P8Jw/RJIuPTCRAdX/
         5dWw==
X-Gm-Message-State: AOJu0YxCfBYjaPuNiJtvs62g0xAOpczxYAvxrYYdDyLL6G+ow/SKtneL
        6us/BorDkWm9N+h4JrACSZxSGQ==
X-Google-Smtp-Source: AGHT+IFkYNThXCc22dnCJgmxDm0IR7q/5f7jyJTz5TGW6dDInQACUTjc1uU5JFaEzH5xGA6ntZRIuA==
X-Received: by 2002:a05:6a20:e195:b0:16b:bbca:4a5d with SMTP id ks21-20020a056a20e19500b0016bbbca4a5dmr1201633pzb.62.1698112645187;
        Mon, 23 Oct 2023 18:57:25 -0700 (PDT)
Received: from [192.168.6.6] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id nk5-20020a17090b194500b00268b439a0cbsm6324806pjb.23.2023.10.23.18.57.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 18:57:24 -0700 (PDT)
Message-ID: <ca8d6571-a67d-bc3c-5d34-2eae623bf985@bytedance.com>
Date:   Tue, 24 Oct 2023 09:57:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v1] lib,kprobes: using try_cmpxchg_local in objpool_push
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-trace-kernel@vger.kernel.org, davem@davemloft.net,
        anil.s.keshavamurthy@intel.com, naveen.n.rao@linux.ibm.com,
        peterz@infradead.org, akpm@linux-foundation.org,
        sander@svanheule.net, ebiggers@google.com,
        dan.j.williams@intel.com, jpoimboe@kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com, mattwu@163.com
References: <20231023112452.6290-1-wuqiang.matt@bytedance.com>
 <20231023114304.1bebb327@gandalf.local.home>
 <20231024100134.2dbabbf01f968a000507ba94@kernel.org>
Content-Language: en-US
From:   "wuqiang.matt" <wuqiang.matt@bytedance.com>
In-Reply-To: <20231024100134.2dbabbf01f968a000507ba94@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/24 09:01, Masami Hiramatsu (Google) wrote:
> On Mon, 23 Oct 2023 11:43:04 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> On Mon, 23 Oct 2023 19:24:52 +0800
>> "wuqiang.matt" <wuqiang.matt@bytedance.com> wrote:
>>
>>> The objpool_push can only happen on local cpu node, so only the local
>>> cpu can touch slot->tail and slot->last, which ensures the correctness
>>> of using cmpxchg without lock prefix (using try_cmpxchg_local instead
>>> of try_cmpxchg_acquire).
>>>
>>> Testing with IACA found the lock version of pop/push pair costs 16.46
>>> cycles and local-push version costs 15.63 cycles. Kretprobe throughput
>>> is improved to 1.019 times of the lock version for x86_64 systems.
>>>
>>> OS: Debian 10 X86_64, Linux 6.6rc6 with freelist
>>> HW: XEON 8336C x 2, 64 cores/128 threads, DDR4 3200MT/s
>>>
>>>                   1T         2T         4T         8T        16T
>>>    lock:    29909085   59865637  119692073  239750369  478005250
>>>    local:   30297523   60532376  121147338  242598499  484620355
>>>                  32T        48T        64T        96T       128T
>>>    lock:   957553042 1435814086 1680872925 2043126796 2165424198
>>>    local:  968526317 1454991286 1861053557 2059530343 2171732306
>>>
>>> Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
>>> ---
>>>   lib/objpool.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/lib/objpool.c b/lib/objpool.c
>>> index ce0087f64400..a032701beccb 100644
>>> --- a/lib/objpool.c
>>> +++ b/lib/objpool.c
>>> @@ -166,7 +166,7 @@ objpool_try_add_slot(void *obj, struct objpool_head *pool, int cpu)
>>>   		head = READ_ONCE(slot->head);
>>>   		/* fault caught: something must be wrong */
>>>   		WARN_ON_ONCE(tail - head > pool->nr_objs);
>>> -	} while (!try_cmpxchg_acquire(&slot->tail, &tail, tail + 1));
>>> +	} while (!try_cmpxchg_local(&slot->tail, &tail, tail + 1));
>>>   
>>>   	/* now the tail position is reserved for the given obj */
>>>   	WRITE_ONCE(slot->entries[tail & slot->mask], obj);
>>
>> I'm good with the change, but I don't like how "cpu" is passed to this
>> function. It currently is only used in one location, which does:
>>
>> 	rc = objpool_try_add_slot(obj, pool, raw_smp_processor_id());
>>
>> Which makes this change fine. But there's nothing here to prevent someone
>> for some reason passing another CPU to that function.
>>
>> If we are to make that change, I would be much more comfortable with
>> removing "int cpu" as a parameter to objpool_try_add_slot() and adding:
>>
>> 	int cpu = raw_smp_processor_id();
>>
>> Which now shows that this function *only* deals with the current CPU.
> 
> Oh indeed. It used to search all CPUs to push the object, but
> I asked him to stop that because there should be enough space to
> push it in the local ring. This is a remnant of that time.

Yes, good catch. Thanks for the explanation.

> Wuqiang, can you make another patch to fix it?

I'm thinking of removing the inline function objpool_try_add_slot and merging
its functionality to objpool_push, like the followings:


/* reclaim an object to object pool */
int objpool_push(void *obj, struct objpool_head *pool)
{
	struct objpool_slot *slot;
	uint32_t head, tail;
	unsigned long flags;

	/* disable local irq to avoid preemption & interruption */
	raw_local_irq_save(flags);

	slot = pool->cpu_slots[raw_smp_processor_id()];

	/* loading tail and head as a local snapshot, tail first */
	tail = READ_ONCE(slot->tail);

	do {
		head = READ_ONCE(slot->head);
		/* fault caught: something must be wrong */
		WARN_ON_ONCE(tail - head > pool->nr_objs);
	} while (!try_cmpxchg_local(&slot->tail, &tail, tail + 1));

	/* now the tail position is reserved for the given obj */
	WRITE_ONCE(slot->entries[tail & slot->mask], obj);
	/* update sequence to make this obj available for pop() */
	smp_store_release(&slot->last, tail + 1);

	raw_local_irq_restore(flags);

	return 0;
}

I'll prepare a new patch for this improvement.

> Thank you,
> 
>>
>> -- Steve
> 

Thanks for your time,
wuqiang
