Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6997DECD8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 07:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjKBG1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 02:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjKBG1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 02:27:46 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D075B10E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 23:27:40 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1eb39505ba4so415824fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 23:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698906460; x=1699511260; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LY97XwVS1CtIq+KDG3Zlhc+7zSRKCnoy+zEISQpH94w=;
        b=JUP06NMXP6Hxldb0XmGiMePUQRoulBRgVfQzQnc8G1SqcTVAyIWyviH9TPnuTipiys
         pd9zeKTSozhcUgoV+vZrQx578XCMZy6YeAGv5pHF9EPtfitQW/7d5TsCBdC4gQ8+m2Eo
         ZNZQWSffDvESw10t2w4VcZFY/dfzTmzhn6nP3WDp++2RSV5wvfDEQ9/IpVvvT6Sdg3G7
         C4JJ5m0E+mmigW4rYV8y8/d8IbrpkloABM2k2LiwzdO1AtyQ/gcQjcVDIUxXxoeh8c13
         Yub4eV+ZX7cpO/vUpjcaJlVRufGwgv8LwXbfyjGHKsYYFBKRXUhqKyX/LsG7Zwqa+s5H
         tSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698906460; x=1699511260;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LY97XwVS1CtIq+KDG3Zlhc+7zSRKCnoy+zEISQpH94w=;
        b=jOXnmQN8sVBRHpjcbE39gm+7ZSiu8s0AsyffmOSfaFCNRYrt3/4OxBz3PprZnz7CMS
         /siMQjj5dw7tkpJKwaJauqAnJjBwCfOvHzhoEj7e+4xodpxXcE5S48wnMfN/905z8Arz
         A/Qsb1Fqvd3Jr+SRYWeUcULLJne72b/UcRK7IlWlm347MCEtppyKMSM0KbWQFAkd59Jb
         aR9XsQKLAr/PkF9qWW54MkatGfSA0hBtJaj/by8TLZ+Cu2+J4V/we5Q4fNbeE5x37YT0
         Zr86P3IHqJkfJQ+Y9LUWHJdtMQuQv9C7vbZoPXmybfyUTchPfqBf7am2uny6TEMZXgO4
         gjOw==
X-Gm-Message-State: AOJu0Yyn9XZVd1OkBwML86t+YFRD2UDRWrTQQN5YkDth02rHJCXM1wsq
        Zy9IvCfIqQzdntN+/Z6CX7dzyQ==
X-Google-Smtp-Source: AGHT+IG98hJMMO+OCyZL9MNqsE+NsCXApl/8XzZLkj5lQvHnTKbMKo7UFt6DIoGCVB+otqD5Av2U4g==
X-Received: by 2002:a05:6870:e984:b0:1d5:a58d:1317 with SMTP id r4-20020a056870e98400b001d5a58d1317mr22153161oao.10.1698906460092;
        Wed, 01 Nov 2023 23:27:40 -0700 (PDT)
Received: from [10.84.152.223] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id k11-20020a637b4b000000b0059cc2f1b7basm800780pgn.11.2023.11.01.23.27.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 23:27:39 -0700 (PDT)
Message-ID: <e9638a3f-baa0-4abb-bb61-481c539c2181@bytedance.com>
Date:   Thu, 2 Nov 2023 14:27:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Track current se's EEVDF parameters
To:     s921975628@gmail.com, mingo@redhat.com, peterz@infradead.org
Cc:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org
References: <20231101174446.90413-1-s921975628@gmail.com>
Content-Language: en-US
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20231101174446.90413-1-s921975628@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/23 1:44 AM, s921975628@gmail.com Wrote:
> From: Yiwei Lin <s921975628@gmail.com>
> 
> After dequeuing the current-picked scheduling entity with
> `__dequeue_entity`, its contribution to the EEVDF parameters
> cfs_rq->avg_vruntime and cfs_rq->avg_load are also removed.
> Because these should in fact be considered for the EEVDF algorithm,
> we took curr as the special case and inserted back the contributions
> when requests for cfs_rq->avg_vruntime and cfs_rq->avg_load.

Being 'curr' means its vruntime is increasing, so does its
contribution to avg_vruntime. And you failed to explain the
most important part that how to commit its contribution to
avg_vruntime (specifically in update_curr()).

Regards,
	Abel

> 
> Functions like `entity_eligible` which is called insied a loop may
> therefore recalculate these statistics repeatly and require more effort.
> Instead, we could just avoid to remove these statistics from
> cfs_rq->avg_vruntime and cfs_rq->avg_load directly.
> 
> Signed-off-by: Yiwei Lin <s921975628@gmail.com>
> ---
>   kernel/sched/fair.c | 34 +++++++---------------------------
>   1 file changed, 7 insertions(+), 27 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 876798824..d507ade09 100644
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
>   {
>   	rb_erase_augmented_cached(&se->run_node, &cfs_rq->tasks_timeline,
>   				  &min_deadline_cb);
> -	avg_vruntime_sub(cfs_rq, se);
> +	if (!on_rq)
> +		avg_vruntime_sub(cfs_rq, se);
>   }
>   
>   struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
> @@ -3675,8 +3660,7 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
>   		/* commit outstanding execution time */
>   		if (cfs_rq->curr == se)
>   			update_curr(cfs_rq);
> -		else
> -			avg_vruntime_sub(cfs_rq, se);
> +		avg_vruntime_sub(cfs_rq, se);
>   		update_load_sub(&cfs_rq->load, se->load.weight);
>   	}
>   	dequeue_load_avg(cfs_rq, se);
> @@ -3712,8 +3696,7 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
>   	enqueue_load_avg(cfs_rq, se);
>   	if (se->on_rq) {
>   		update_load_add(&cfs_rq->load, se->load.weight);
> -		if (cfs_rq->curr != se)
> -			avg_vruntime_add(cfs_rq, se);
> +		avg_vruntime_add(cfs_rq, se);
>   	}
>   }
>   
> @@ -5023,7 +5006,6 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>   	 * EEVDF: placement strategy #1 / #2
>   	 */
>   	if (sched_feat(PLACE_LAG) && cfs_rq->nr_running) {
> -		struct sched_entity *curr = cfs_rq->curr;
>   		unsigned long load;
>   
>   		lag = se->vlag;
> @@ -5081,8 +5063,6 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>   		 *   vl_i = (W + w_i)*vl'_i / W
>   		 */
>   		load = cfs_rq->avg_load;
> -		if (curr && curr->on_rq)
> -			load += scale_load_down(curr->load.weight);
>   
>   		lag *= load + scale_load_down(se->load.weight);
>   		if (WARN_ON_ONCE(!load))
> @@ -5229,7 +5209,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>   
>   	update_entity_lag(cfs_rq, se);
>   	if (se != cfs_rq->curr)
> -		__dequeue_entity(cfs_rq, se);
> +		__dequeue_entity(cfs_rq, se, 0);
>   	se->on_rq = 0;
>   	account_entity_dequeue(cfs_rq, se);
>   
> @@ -5264,7 +5244,7 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
>   		 * runqueue.
>   		 */
>   		update_stats_wait_end_fair(cfs_rq, se);
> -		__dequeue_entity(cfs_rq, se);
> +		__dequeue_entity(cfs_rq, se, 1);
>   		update_load_avg(cfs_rq, se, UPDATE_TG);
>   		/*
>   		 * HACK, stash a copy of deadline at the point of pick in vlag,
