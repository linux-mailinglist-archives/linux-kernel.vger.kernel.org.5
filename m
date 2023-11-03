Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A8D7E00E6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbjKCGqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 02:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbjKCGqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 02:46:48 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD052CA
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 23:46:42 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6bd73395bceso1502837b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 23:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698994002; x=1699598802; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SUd2UsTXD/DclMZGdmP0bxcAoC3bE5zE1SDWkgEvK8c=;
        b=jchpm+lN+rmESh08NkIwY4EVBb+s7pizVx9MlfceN9PuOTqu67tJ14cfIsMnmNoQpM
         lIZWK//XNu9GYIYutOr4MYy1qH/rTXx64ZYADfwCCqoDeolkpmaIEtpynTxbftkMZICb
         XHWFNmMz0ySFBbiZW9/3JSiG+zSZdAkgaJtLpZw2GN8Bc1SEKNsTdInktAp/rrkQ3FF8
         val5bMBceJvqmBwQB3/IpJ4EApktn1PobZeaaxU/TOu+fE36H4KRiSMDjS5Y37SRnkBi
         X2RG5HtI/TUxXj1xkOToNBczowuQThh6jU4fO2NZxP40/Xyu3uR1w4yMCbb9svaOXcwW
         bnug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698994002; x=1699598802;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SUd2UsTXD/DclMZGdmP0bxcAoC3bE5zE1SDWkgEvK8c=;
        b=JeigcmJZNw4xPyoOLFGXR65WuTfINDgtQVDnNmy72JK2c6urY9KdiuEgBhJZogv4g+
         TPYf23tzaT8f2iFPwdZrOaSFzt9WQCp7arM3SSpWtESGRFcomE7A81PJ5C4GJF2OzTfH
         XTxkSQ3tEYWmg1BhmwXPlbhFyR6y9gK9P+LcbnbF3PXRKxPkOLojtGtSNy5ZIoOtLdeu
         9CVa0Fw8mG36wpQCV19lOTb01+W93TtvICDsLhtqYgTBX0mSc18HqVuRBz1W/bUfLr6p
         Y/iGgFpsipXS/VltSExA8hXDz6son3mz6d43Bp1kgx+rcpxgd26imI1vHmoPLMvykGrr
         bDKg==
X-Gm-Message-State: AOJu0YzuPlUK2kXMKhg3DAIGuRy4FahHj9pOW9luI5miIX4LZUJ8QWxA
        8JSsYZuCV3AUJ9Zta/DoCuABnw==
X-Google-Smtp-Source: AGHT+IFzGVKA6RcX/+vOuyvJ5oAvcXdU+tV/6XG9AHXS1GZaDf+CwU/O6KMIP7r0EQ6yaf+4LX94Ow==
X-Received: by 2002:a05:6a00:21cc:b0:6c3:415a:5c05 with SMTP id t12-20020a056a0021cc00b006c3415a5c05mr2441066pfj.14.1698994002160;
        Thu, 02 Nov 2023 23:46:42 -0700 (PDT)
Received: from [10.84.152.223] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id x184-20020a6363c1000000b0057412d84d25sm716962pgb.4.2023.11.02.23.46.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 23:46:41 -0700 (PDT)
Message-ID: <1f90d44f-e20c-445a-8bc5-8440c870176e@bytedance.com>
Date:   Fri, 3 Nov 2023 14:45:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] sched/fair: Track current se's EEVDF parameters
Content-Language: en-US
To:     Yiwei Lin <s921975628@gmail.com>, mingo@redhat.com,
        peterz@infradead.org
Cc:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org
References: <20231102142022.19302-1-s921975628@gmail.com>
 <20231102142022.19302-2-s921975628@gmail.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20231102142022.19302-2-s921975628@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/23 10:20 PM, Yiwei Lin Wrote:
> After dequeuing the current-picked scheduling entity with
> `__dequeue_entity`, its contribution to the EEVDF parameters
> cfs_rq->avg_vruntime and cfs_rq->avg_load are also removed.
> Because these should in fact be considered for the EEVDF algorithm,
> we took curr as the special case and inserted back the contributions
> when requests for cfs_rq->avg_vruntime and cfs_rq->avg_load.
> 
> Functions like `entity_eligible` which is called insied a loop may
> therefore recalculate these statistics repeatly and require more effort.
> Instead, we could just avoid to remove these statistics from
> cfs_rq->avg_vruntime and cfs_rq->avg_load directly.
> 
> Signed-off-by: Yiwei Lin <s921975628@gmail.com>
> ---
>   kernel/sched/fair.c | 39 +++++++++++----------------------------
>   1 file changed, 11 insertions(+), 28 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 876798824..a10a73603 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -655,17 +655,9 @@ void avg_vruntime_update(struct cfs_rq *cfs_rq, s64 delta)
>    */
>   u64 avg_vruntime(struct cfs_rq *cfs_rq)
>   {
> -	struct sched_entity *curr = cfs_rq->curr;
>   	s64 avg = cfs_rq->avg_vruntime;
>   	long load = cfs_rq->avg_load;
>   
> -	if (curr && curr->on_rq) {
> -		unsigned long weight = scale_load_down(curr->load.weight);
> -
> -		avg += entity_key(cfs_rq, curr) * weight;
> -		load += weight;
> -	}
> -
>   	if (load) {
>   		/* sign flips effective floor / ceil */
>   		if (avg < 0)
> @@ -722,17 +714,9 @@ static void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
>    */
>   int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se)
>   {
> -	struct sched_entity *curr = cfs_rq->curr;
>   	s64 avg = cfs_rq->avg_vruntime;
>   	long load = cfs_rq->avg_load;
>   
> -	if (curr && curr->on_rq) {
> -		unsigned long weight = scale_load_down(curr->load.weight);
> -
> -		avg += entity_key(cfs_rq, curr) * weight;
> -		load += weight;
> -	}
> -
>   	return avg >= entity_key(cfs_rq, se) * load;
>   }
>   
> @@ -821,11 +805,12 @@ static void __enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
>   				__entity_less, &min_deadline_cb);
>   }
>   
> -static void __dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
> +static void __dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, bool on_rq)

Please don't add such complexity. Since avg_vruntime includes the whole
cfs_rq after this change, you can simply avg_vruntime_add() when doing
enqueue_entity() and avg_vruntime_sub() in dequeue_entity().

>   {
>   	rb_erase_augmented_cached(&se->run_node, &cfs_rq->tasks_timeline,
>   				  &min_deadline_cb);
> -	avg_vruntime_sub(cfs_rq, se);
> +	if (!on_rq)
> +		avg_vruntime_sub(cfs_rq, se);
>   }
>   
>   struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
> @@ -1137,6 +1122,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
>   	struct sched_entity *curr = cfs_rq->curr;
>   	u64 now = rq_clock_task(rq_of(cfs_rq));
>   	u64 delta_exec;
> +	u64 delta_fair;
>   
>   	if (unlikely(!curr))
>   		return;
> @@ -1158,7 +1144,9 @@ static void update_curr(struct cfs_rq *cfs_rq)
>   	curr->sum_exec_runtime += delta_exec;
>   	schedstat_add(cfs_rq->exec_clock, delta_exec);
>   
> -	curr->vruntime += calc_delta_fair(delta_exec, curr);
> +	delta_fair = calc_delta_fair(delta_exec, curr);
> +	curr->vruntime += delta_fair;
> +	cfs_rq->avg_vruntime += delta_fair * scale_load_down(curr->load.weight);

What if curr->load.weight changes in this time slice?

>   	update_deadline(cfs_rq, curr);
>   	update_min_vruntime(cfs_rq);
>   
> @@ -3675,8 +3663,7 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
>   		/* commit outstanding execution time */
>   		if (cfs_rq->curr == se)
>   			update_curr(cfs_rq);
> -		else
> -			avg_vruntime_sub(cfs_rq, se);
> +		avg_vruntime_sub(cfs_rq, se);
>   		update_load_sub(&cfs_rq->load, se->load.weight);
>   	}
>   	dequeue_load_avg(cfs_rq, se);
> @@ -3712,8 +3699,7 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
>   	enqueue_load_avg(cfs_rq, se);
>   	if (se->on_rq) {
>   		update_load_add(&cfs_rq->load, se->load.weight);
> -		if (cfs_rq->curr != se)
> -			avg_vruntime_add(cfs_rq, se);
> +		avg_vruntime_add(cfs_rq, se);
>   	}
>   }
>   
> @@ -5023,7 +5009,6 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>   	 * EEVDF: placement strategy #1 / #2
>   	 */
>   	if (sched_feat(PLACE_LAG) && cfs_rq->nr_running) {
> -		struct sched_entity *curr = cfs_rq->curr;
>   		unsigned long load;
>   
>   		lag = se->vlag;
> @@ -5081,8 +5066,6 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>   		 *   vl_i = (W + w_i)*vl'_i / W
>   		 */
>   		load = cfs_rq->avg_load;
> -		if (curr && curr->on_rq)
> -			load += scale_load_down(curr->load.weight);
>   
>   		lag *= load + scale_load_down(se->load.weight);
>   		if (WARN_ON_ONCE(!load))
> @@ -5229,7 +5212,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>   
>   	update_entity_lag(cfs_rq, se);
>   	if (se != cfs_rq->curr)
> -		__dequeue_entity(cfs_rq, se);
> +		__dequeue_entity(cfs_rq, se, 0);
>   	se->on_rq = 0;
>   	account_entity_dequeue(cfs_rq, se);
>   
> @@ -5264,7 +5247,7 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
>   		 * runqueue.
>   		 */
>   		update_stats_wait_end_fair(cfs_rq, se);
> -		__dequeue_entity(cfs_rq, se);
> +		__dequeue_entity(cfs_rq, se, 1);
>   		update_load_avg(cfs_rq, se, UPDATE_TG);
>   		/*
>   		 * HACK, stash a copy of deadline at the point of pick in vlag,
