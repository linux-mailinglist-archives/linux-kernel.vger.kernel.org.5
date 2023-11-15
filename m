Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54957EC76D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjKOPgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjKOPgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:36:15 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231E0C2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 07:36:12 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6c34e87b571so5881891b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 07:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700062571; x=1700667371; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Wpoudhb3vVHFBoeOvpD9W3TMZTjpbuJDlDAFO1VUr8=;
        b=buhmx0KkVx3Tc3vrxKFdc8wmYLvaFRmFmEJ/HLwFJGlzVVByw2cRBUNw3EAkF3oiFj
         omSRaDaF4lmN87Bc4Pd2rzE1NiOEKt6wxQMjtKfep2aFwYh6nWGUmdMShQul5YzTndTx
         jx+/LUCFI8hDhdHHgWxgMH/iKZoiKydhy40rW9lulKGMT2OHtKfwbLCSS3ncozA+uCwT
         EyU+sCv7+zAB4EiuaYcbL0J/5FLqKUl9uIzT/GpQG2VSd/1dgfNRvE2QlXvaIoK3Hfdy
         lRcS8w/v/YKdMahxmREL3vq1yM4sU+93gVjHu7XDey7/dFOXC8s5g545rm4HM4+zsdPA
         4tMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700062571; x=1700667371;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Wpoudhb3vVHFBoeOvpD9W3TMZTjpbuJDlDAFO1VUr8=;
        b=WyRSqpisusVzmwPE2ItvZ7+Afnegs3tw2IwyiqYUbgvKa0H8SQrjzNqi1haYLIIYj0
         zPU5+hcAQ1tpX8Q/sLBt8T/02QCzH5Z1CsPnYKPFuBEVRM6cB9OFFlrlfQfNxWqyWFlE
         TWfNhUavEtzhUUPxxai38GMmp7LR/uFUk7Pvd7REqvc74pgusR3jNnj8TYY5EKZ7YYeD
         G0tE0AYNi7UAitdBc+fzdw1WBMkONFvnGtL9lXtzrvbCIyBRZtThDHuymyyPXXKlCTy6
         x5HxZM+XaQdx1lX1fW13Bn9dM6vqOTt12y7VQfJDBTNbNsRQvPfmKAjT6y+6lE9FhLKK
         PvYQ==
X-Gm-Message-State: AOJu0YyFcSdYhDhlTWQVs2RdZbT6wnlpIHUBg/I1c6tttqDExOB2Hg8f
        Wo/mPptHl91odeyoz2jFKRE=
X-Google-Smtp-Source: AGHT+IH1o2o0Iy91deaWxTXzVPNUO0oiT0oXMUwT774sNsmj+LOcxz+KKrRoOcpwVjkdIiAB5YgciA==
X-Received: by 2002:a05:6a20:394b:b0:17a:4891:e33 with SMTP id r11-20020a056a20394b00b0017a48910e33mr11918460pzg.4.1700062571406;
        Wed, 15 Nov 2023 07:36:11 -0800 (PST)
Received: from [192.168.1.105] (111-255-239-171.dynamic-ip.hinet.net. [111.255.239.171])
        by smtp.gmail.com with ESMTPSA id b66-20020a633445000000b005b8ea15c338sm1318628pga.62.2023.11.15.07.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 07:36:11 -0800 (PST)
Message-ID: <da42f1d7-adfe-485e-987e-3e8dae78b4c2@gmail.com>
Date:   Wed, 15 Nov 2023 23:36:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] sched/eevdf: Fix vruntime adjustment on reweight
Content-Language: en-US
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Barry Song <21cnbao@gmail.com>,
        Benjamin Segall <bsegall@google.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Mike Galbraith <efault@gmx.de>,
        Qais Yousef <qyousef@layalina.io>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Yicong Yang <yangyicong@huawei.com>,
        Youssef Esmat <youssefesmat@chromium.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>
References: <20231107090510.71322-1-wuyun.abel@bytedance.com>
 <20231107090510.71322-2-wuyun.abel@bytedance.com>
From:   Yiwei Lin <s921975628@gmail.com>
In-Reply-To: <20231107090510.71322-2-wuyun.abel@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/7/23 17:05, Abel Wu wrote:
> vruntime of the (on_rq && !0-lag) entity needs to be adjusted when
> it gets re-weighted, and the calculations can be simplified based
> on the fact that re-weight won't change the w-average of all the
> entities. Please check the proofs in comments.
>
> But adjusting vruntime can also cause position change in RB-tree
> hence require re-queue to fix up which might be costly. This might
> be avoided by deferring adjustment to the time the entity actually
> leaves tree (dequeue/pick), but that will negatively affect task
> selection and probably not good enough either.
>
> Fixes: 147f3efaa241 ("sched/fair: Implement an EEVDF-like scheduling policy")
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> ---
>   kernel/sched/fair.c | 151 +++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 128 insertions(+), 23 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8767988242ee..b00d09a9b601 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3666,41 +3666,140 @@ static inline void
>   dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) { }
>   #endif
>   
> +static void reweight_eevdf(struct cfs_rq *cfs_rq, struct sched_entity *se,
> +			   unsigned long weight)
> +{
> +	unsigned long old_weight = se->load.weight;
> +	u64 avruntime = avg_vruntime(cfs_rq);
> +	s64 vlag, vslice;
> +
> +	/*
> +	 * VRUNTIME
> +	 * ========
> +	 *
> +	 * COROLLARY #1: The virtual runtime of the entity needs to be
> +	 * adjusted if re-weight at !0-lag point.
> +	 *
> +	 * Proof: For contradiction assume this is not true, so we can
> +	 * re-weight without changing vruntime at !0-lag point.
> +	 *
> +	 *             Weight	VRuntime   Avg-VRuntime
> +	 *     before    w          v            V
> +	 *      after    w'         v'           V'
> +	 *
> +	 * Since lag needs to be preserved through re-weight:
> +	 *
> +	 *	lag = (V - v)*w = (V'- v')*w', where v = v'
> +	 *	==>	V' = (V - v)*w/w' + v		(1)
> +	 *
> +	 * Let W be the total weight of the entities before reweight,
> +	 * since V' is the new weighted average of entities:
> +	 *
> +	 *	V' = (WV + w'v - wv) / (W + w' - w)	(2)
> +	 *
> +	 * by using (1) & (2) we obtain:
> +	 *
> +	 *	(WV + w'v - wv) / (W + w' - w) = (V - v)*w/w' + v
> +	 *	==> (WV-Wv+Wv+w'v-wv)/(W+w'-w) = (V - v)*w/w' + v
> +	 *	==> (WV - Wv)/(W + w' - w) + v = (V - v)*w/w' + v
> +	 *	==>	(V - v)*W/(W + w' - w) = (V - v)*w/w' (3)
> +	 *
> +	 * Since we are doing at !0-lag point which means V != v, we
> +	 * can simplify (3):
> +	 *
> +	 *	==>	W / (W + w' - w) = w / w'
> +	 *	==>	Ww' = Ww + ww' - ww
> +	 *	==>	W * (w' - w) = w * (w' - w)
> +	 *	==>	W = w	(re-weight indicates w' != w)
> +	 *
> +	 * So the cfs_rq contains only one entity, hence vruntime of
> +	 * the entity @v should always equal to the cfs_rq's weighted
> +	 * average vruntime @V, which means we will always re-weight
> +	 * at 0-lag point, thus breach assumption. Proof completed.
> +	 *
> +	 *
> +	 * COROLLARY #2: Re-weight does NOT affect weighted average
> +	 * vruntime of all the entities.
> +	 *
> +	 * Proof: According to corollary #1, Eq. (1) should be:
> +	 *
> +	 *	(V - v)*w = (V' - v')*w'
> +	 *	==>    v' = V' - (V - v)*w/w'		(4)
> +	 *
> +	 * According to the weighted average formula, we have:
> +	 *
> +	 *	V' = (WV - wv + w'v') / (W - w + w')
> +	 *	   = (WV - wv + w'(V' - (V - v)w/w')) / (W - w + w')
> +	 *	   = (WV - wv + w'V' - Vw + wv) / (W - w + w')
> +	 *	   = (WV + w'V' - Vw) / (W - w + w')
> +	 *
> +	 *	==>  V'*(W - w + w') = WV + w'V' - Vw
> +	 *	==>	V' * (W - w) = (W - w) * V	(5)
> +	 *
> +	 * If the entity is the only one in the cfs_rq, then reweight
> +	 * always occurs at 0-lag point, so V won't change. Or else
> +	 * there are other entities, hence W != w, then Eq. (5) turns
> +	 * into V' = V. So V won't change in either case, proof done.
> +	 *
> +	 *
> +	 * So according to corollary #1 & #2, the effect of re-weight
> +	 * on vruntime should be:
> +	 *
> +	 *	v' = V' - (V - v) * w / w'		(4)
> +	 *	   = V  - (V - v) * w / w'
> +	 *	   = V  - vl * w / w'
> +	 *	   = V  - vl'
> +	 */
> +	if (avruntime != se->vruntime) {
> +		vlag = (s64)(avruntime - se->vruntime);
> +		vlag = div_s64(vlag * old_weight, weight);
> +		se->vruntime = avruntime - vlag;
> +	}
> +
> +	/*
> +	 * DEADLINE
> +	 * ========
> +	 *
> +	 * When the weight changes, the virtual time slope changes and
> +	 * we should adjust the relative virtual deadline accordingly.
> +	 *
> +	 *	d' = v' + (d - v)*w/w'
> +	 *	   = V' - (V - v)*w/w' + (d - v)*w/w'
> +	 *	   = V  - (V - v)*w/w' + (d - v)*w/w'
> +	 *	   = V  + (d - V)*w/w'
> +	 */
> +	vslice = (s64)(se->deadline - avruntime);
> +	vslice = div_s64(vslice * old_weight, weight);
> +	se->deadline = avruntime + vslice;
> +}
> +
>   static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
>   			    unsigned long weight)
>   {
> -	unsigned long old_weight = se->load.weight;
> +	bool curr = cfs_rq->curr == se;
>   
>   	if (se->on_rq) {
>   		/* commit outstanding execution time */
> -		if (cfs_rq->curr == se)
> +		if (curr)
>   			update_curr(cfs_rq);
>   		else
> -			avg_vruntime_sub(cfs_rq, se);
> +			__dequeue_entity(cfs_rq, se);
>   		update_load_sub(&cfs_rq->load, se->load.weight);
>   	}
>   	dequeue_load_avg(cfs_rq, se);
>   
> -	update_load_set(&se->load, weight);
> -
>   	if (!se->on_rq) {
>   		/*
>   		 * Because we keep se->vlag = V - v_i, while: lag_i = w_i*(V - v_i),
>   		 * we need to scale se->vlag when w_i changes.
>   		 */
> -		se->vlag = div_s64(se->vlag * old_weight, weight);
> +		se->vlag = div_s64(se->vlag * se->load.weight, weight);
>   	} else {
> -		s64 deadline = se->deadline - se->vruntime;
> -		/*
> -		 * When the weight changes, the virtual time slope changes and
> -		 * we should adjust the relative virtual deadline accordingly.
> -		 */
> -		deadline = div_s64(deadline * old_weight, weight);
> -		se->deadline = se->vruntime + deadline;
> -		if (se != cfs_rq->curr)
> -			min_deadline_cb_propagate(&se->run_node, NULL);
> +		reweight_eevdf(cfs_rq, se, weight);
>   	}
>   
> +	update_load_set(&se->load, weight);
> +
>   #ifdef CONFIG_SMP
>   	do {
>   		u32 divider = get_pelt_divider(&se->avg);
> @@ -3712,8 +3811,17 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
>   	enqueue_load_avg(cfs_rq, se);
>   	if (se->on_rq) {
>   		update_load_add(&cfs_rq->load, se->load.weight);
> -		if (cfs_rq->curr != se)
> -			avg_vruntime_add(cfs_rq, se);
> +		if (!curr) {
> +			/*
> +			 * The entity's vruntime has been adjusted, so let's check
> +			 * whether the rq-wide min_vruntime needs updated too. Since
> +			 * the calculations above require stable min_vruntime rather
> +			 * than up-to-date one, we do the update at the end of the
> +			 * reweight process.
> +			 */
> +			__enqueue_entity(cfs_rq, se);
> +			update_min_vruntime(cfs_rq);
> +		}
>   	}
>   }
Sorry if I am asking stupid question...... It looks like 
reweight_entity() may have chance to change the weight of cfs_rq->curr 
entity, but we'll never update_min_vruntime() when reweighting it. Is 
there any reason that we can skip the update_min_vruntime() for this case?
>   
> @@ -3857,14 +3965,11 @@ static void update_cfs_group(struct sched_entity *se)
>   
>   #ifndef CONFIG_SMP
>   	shares = READ_ONCE(gcfs_rq->tg->shares);
> -
> -	if (likely(se->load.weight == shares))
> -		return;
>   #else
> -	shares   = calc_group_shares(gcfs_rq);
> +	shares = calc_group_shares(gcfs_rq);
>   #endif
> -
> -	reweight_entity(cfs_rq_of(se), se, shares);
> +	if (unlikely(se->load.weight != shares))
> +		reweight_entity(cfs_rq_of(se), se, shares);
>   }
>   
>   #else /* CONFIG_FAIR_GROUP_SCHED */

Thanks,
Yiwei Lin

