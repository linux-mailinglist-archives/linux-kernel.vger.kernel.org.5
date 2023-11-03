Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2BB7E042D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 15:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377603AbjKCOCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 10:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjKCOCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 10:02:03 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D97DD4F
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 07:01:59 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6c3077984e8so2008764b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 07:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699020119; x=1699624919; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CJnh3SEzHJP7RdxEm/t005SLzxHQRntzCtaQBOBnGCU=;
        b=DL8Eihun2PB+WLI/UtogsucJdLlGITZnDJjh2p94IAIjZLLaqjwCcjCSldxs5gACwY
         MZDGOJYv/6uy22HldEzXJsIev0SidV8mbajrwWY/IWrjtXJqPf6GuD3cuHLbOUPs/ghO
         BrXlq4KDty+LaI4nw5Ct4qNm33SSztY0oY3PxCbgLoh1sv6QglLz0wVJ+ewJb/Lov1kf
         WjSNBEkVHfPHBCDGrhI3HxAHUpeg+zWo0QmT8tir4IZYjwdN5B8jlSDRltnwmlyZtwt4
         aCzIiLQ5frTp4iOG00mB7RQdzEk+Kikp5ZLN2cLF3NmzJnq5d7jwGe+Yo3f+Cwy1VOc/
         H7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699020119; x=1699624919;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CJnh3SEzHJP7RdxEm/t005SLzxHQRntzCtaQBOBnGCU=;
        b=MzTXkwFrnZdEUQDD4mneUN7TPbYioFTKFvFUnoH9qDkfa4lvD+CxkJYpyA2uX5D12D
         joQi0jD0w3Tv8bhdFxSYbcBfO7gA98EyHMyMRcrV/j0IGXDJBpCIDuw8yfxL8G4QCyT6
         RfIrvGtc2x7/yq9bu8bZC30ENBTc1LCifZO94gkIm/tFUgfhUhYLkNBNInUv62WrF3cP
         cV8i2cimf6oimbAzWXf+EiAF2anw12LDfkDEy0En+PnZ+Xm2nb+XKGCWZdikOcgpEE0+
         SCd4Xrt9fFPQto4pgFOnsglh0PJzuOKVplSA7JOKmSVNCz+DQnzz21fhxhJyi9kYI3L/
         +ugg==
X-Gm-Message-State: AOJu0YzC7zYDLTtW13bL2PqimxfhiCTYoZT3tSfrUNJZHtRWtnJPUfkr
        kYJxZJicPQ31VCngUab+Km4=
X-Google-Smtp-Source: AGHT+IGUtJ4V0VprCnLeb7fkbRuO8aDvsGuP4u3QoVEcG4vZ9Lmr3mvTphtErJC//Hi5mbJi4QEwbw==
X-Received: by 2002:a05:6a00:3929:b0:68b:f529:a329 with SMTP id fh41-20020a056a00392900b0068bf529a329mr21301061pfb.5.1699020118467;
        Fri, 03 Nov 2023 07:01:58 -0700 (PDT)
Received: from [192.168.1.105] (111-255-201-13.dynamic-ip.hinet.net. [111.255.201.13])
        by smtp.gmail.com with ESMTPSA id h16-20020a056a00219000b006c346c98a90sm1524500pfi.92.2023.11.03.07.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Nov 2023 07:01:58 -0700 (PDT)
Message-ID: <26a71d5c-9a4a-4064-8155-a14126a654f8@gmail.com>
Date:   Fri, 3 Nov 2023 22:01:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] sched/fair: Track current se's EEVDF parameters
Content-Language: en-US
To:     Abel Wu <wuyun.abel@bytedance.com>, mingo@redhat.com,
        peterz@infradead.org
Cc:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org
References: <20231102142022.19302-1-s921975628@gmail.com>
 <20231102142022.19302-2-s921975628@gmail.com>
 <1f90d44f-e20c-445a-8bc5-8440c870176e@bytedance.com>
From:   Yiwei Lin <s921975628@gmail.com>
In-Reply-To: <1f90d44f-e20c-445a-8bc5-8440c870176e@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/3/23 14:45, Abel Wu wrote:
> On 11/2/23 10:20 PM, Yiwei Lin Wrote:
>> After dequeuing the current-picked scheduling entity with
>> `__dequeue_entity`, its contribution to the EEVDF parameters
>> cfs_rq->avg_vruntime and cfs_rq->avg_load are also removed.
>> Because these should in fact be considered for the EEVDF algorithm,
>> we took curr as the special case and inserted back the contributions
>> when requests for cfs_rq->avg_vruntime and cfs_rq->avg_load.
>>
>> Functions like `entity_eligible` which is called insied a loop may
>> therefore recalculate these statistics repeatly and require more effort.
>> Instead, we could just avoid to remove these statistics from
>> cfs_rq->avg_vruntime and cfs_rq->avg_load directly.
>>
>> Signed-off-by: Yiwei Lin <s921975628@gmail.com>
>> ---
>>   kernel/sched/fair.c | 39 +++++++++++----------------------------
>>   1 file changed, 11 insertions(+), 28 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 876798824..a10a73603 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -655,17 +655,9 @@ void avg_vruntime_update(struct cfs_rq *cfs_rq, 
>> s64 delta)
>>    */
>>   u64 avg_vruntime(struct cfs_rq *cfs_rq)
>>   {
>> -    struct sched_entity *curr = cfs_rq->curr;
>>       s64 avg = cfs_rq->avg_vruntime;
>>       long load = cfs_rq->avg_load;
>>   -    if (curr && curr->on_rq) {
>> -        unsigned long weight = scale_load_down(curr->load.weight);
>> -
>> -        avg += entity_key(cfs_rq, curr) * weight;
>> -        load += weight;
>> -    }
>> -
>>       if (load) {
>>           /* sign flips effective floor / ceil */
>>           if (avg < 0)
>> @@ -722,17 +714,9 @@ static void update_entity_lag(struct cfs_rq 
>> *cfs_rq, struct sched_entity *se)
>>    */
>>   int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se)
>>   {
>> -    struct sched_entity *curr = cfs_rq->curr;
>>       s64 avg = cfs_rq->avg_vruntime;
>>       long load = cfs_rq->avg_load;
>>   -    if (curr && curr->on_rq) {
>> -        unsigned long weight = scale_load_down(curr->load.weight);
>> -
>> -        avg += entity_key(cfs_rq, curr) * weight;
>> -        load += weight;
>> -    }
>> -
>>       return avg >= entity_key(cfs_rq, se) * load;
>>   }
>>   @@ -821,11 +805,12 @@ static void __enqueue_entity(struct cfs_rq 
>> *cfs_rq, struct sched_entity *se)
>>                   __entity_less, &min_deadline_cb);
>>   }
>>   -static void __dequeue_entity(struct cfs_rq *cfs_rq, struct 
>> sched_entity *se)
>> +static void __dequeue_entity(struct cfs_rq *cfs_rq, struct 
>> sched_entity *se, bool on_rq)
>
> Please don't add such complexity. Since avg_vruntime includes the whole
> cfs_rq after this change, you can simply avg_vruntime_add() when doing
> enqueue_entity() and avg_vruntime_sub() in dequeue_entity().
>
Right. I should consider that we'll also use __enqueue_entity to put 
back the 'curr', and
avg_vruntime_add() when doing enqueue_entity() and avg_vruntime_sub() in 
dequeue_entity()
as you mentioned could not only simplify the implementation but also 
address to this issue.
I'll fix it.

>>   {
>>       rb_erase_augmented_cached(&se->run_node, &cfs_rq->tasks_timeline,
>>                     &min_deadline_cb);
>> -    avg_vruntime_sub(cfs_rq, se);
>> +    if (!on_rq)
>> +        avg_vruntime_sub(cfs_rq, se);
>>   }
>>     struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
>> @@ -1137,6 +1122,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
>>       struct sched_entity *curr = cfs_rq->curr;
>>       u64 now = rq_clock_task(rq_of(cfs_rq));
>>       u64 delta_exec;
>> +    u64 delta_fair;
>>         if (unlikely(!curr))
>>           return;
>> @@ -1158,7 +1144,9 @@ static void update_curr(struct cfs_rq *cfs_rq)
>>       curr->sum_exec_runtime += delta_exec;
>>       schedstat_add(cfs_rq->exec_clock, delta_exec);
>>   -    curr->vruntime += calc_delta_fair(delta_exec, curr);
>> +    delta_fair = calc_delta_fair(delta_exec, curr);
>> +    curr->vruntime += delta_fair;
>> +    cfs_rq->avg_vruntime += delta_fair * 
>> scale_load_down(curr->load.weight);
>
> What if curr->load.weight changes in this time slice?

The change on reweight_entity now don't separate curr and other 
entities. If curr->load.weight is changed,
reweight_entity will do:
1. update_curr() to account the latest contribution of vruntime with old 
weight.
2. avg_vruntime_sub() to remove the curr vruntime with old weight
3. avg_vruntime_add() to insert the curr vruntime with new weight
Although step1 and step2 could be merged together when re-weighting the 
curr entity, but it
seems just find to general implement reweight_entity.

