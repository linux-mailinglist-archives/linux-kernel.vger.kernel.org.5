Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D8E7E3891
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 11:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbjKGKN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 05:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbjKGKNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 05:13:25 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB62F7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 02:12:59 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cc394f4cdfso37783255ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 02:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1699351978; x=1699956778; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KW3TlcvX6A8NZwMp7f8Kxy/+sTqDmiVXoF/rJgIL6L0=;
        b=Cah/ilRucYdGZypYAujItoCOVwxr8/LYziKacfaJReqfq4nIBx7yYZqpZ6s1yjjnaS
         QklvZT4WSKUz6+5oacFczJ2obKP5+DoQkvu7LFqWe8ljEvNnjc0DwQz8Rp61vzonfAlu
         +SPmoP1VjKYQYi69i5xedpFea2yBYNk/AFY7c1Tkc+qQDrPbNbaaIPQl6WJvpjd0MKFl
         8RY9G+CGJuyTU10gtwRbKeuajU1tKZln4pFR327USvRbdk8Y557XupMVK0D6q55sgS4B
         CN5fnd9hn+fp2ZE8JiSl+KUFiIVL+Z2+wWUlUizjDLoQqDCC8QzL9YM8T1dJ7uOd99Qu
         zNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699351978; x=1699956778;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KW3TlcvX6A8NZwMp7f8Kxy/+sTqDmiVXoF/rJgIL6L0=;
        b=HxD7us0Clkrgy+exGsISu7H/DvrEHvAiAUa20webJ5REchxEwBlXV9qIhUU21dukl7
         MuVwm/ogPCP0a24vhWD//CWaisN2Zv3RKtjnxOo5lPAt3MVWpdAx7ciNs8wS5NAGiLwy
         wjaVis2qlM4huOUO93AEOAmnH2Rl8rPNS9ZqG0CAjmNw+HFjbg1o/QbNqKernKa8ObXO
         14JQOE0AWf6tr74KwCWT41EbpZ9h8AjBwXLxXRnNXyJP+vzkaQc4+vWlyt969jNyo1+3
         j8qwLk2iFuws1OQl+JbCfQ3B6rPMQmpeMDuiImEucMHtl/s0suAk13p3p1JJLASRTgnV
         GTbg==
X-Gm-Message-State: AOJu0Yyx0zyr+Ehn2Lpu8MJ0OqezcxKUeQLMViv9l1h9fPXUcrQ3VAOo
        o1xFMbViWXP8bGPR+AarpXWIwA==
X-Google-Smtp-Source: AGHT+IEP9EA6zyhJc5rboncPFfJYUN59t5DyhE99mVuT4PEGZUOCfgPVHmXcDwoOxF4gBk6eUTZfww==
X-Received: by 2002:a17:902:d18d:b0:1cc:1106:cf5b with SMTP id m13-20020a170902d18d00b001cc1106cf5bmr23857294plb.19.1699351978501;
        Tue, 07 Nov 2023 02:12:58 -0800 (PST)
Received: from [10.84.153.152] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id li11-20020a170903294b00b001b0358848b0sm7349793plb.161.2023.11.07.02.12.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 02:12:58 -0800 (PST)
Message-ID: <b2b70241-04fe-4064-ba72-c5ed03a4d4fd@bytedance.com>
Date:   Tue, 7 Nov 2023 18:12:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] sched/eevdf: O(1) fastpath for task selection
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>
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
        linux-kernel@vger.kernel.org
References: <20231107090510.71322-1-wuyun.abel@bytedance.com>
 <20231107090510.71322-4-wuyun.abel@bytedance.com>
Content-Language: en-US
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20231107090510.71322-4-wuyun.abel@bytedance.com>
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

On 11/7/23 5:05 PM, Abel Wu Wrote:
> Since the RB-tree is now sorted by deadline, let's first try the
> leftmost entity which has the earliest virtual deadline. I've done
> some benchmarks to see its effectiveness.
> 
> All the benchmarks are done inside a normal cpu cgroup in a clean
> environment with cpu turbo disabled, on a dual-CPU Intel Xeon(R)
> Platinum 8260 with 2 NUMA nodes each of which has 24C/48T.
> 
>    hackbench: process/thread + pipe/socket + 1/2/4/8 groups
>    netperf:   TCP/UDP + STREAM/RR + 24/48/72/96/192 threads
>    tbench:    loopback 24/48/72/96/192 threads
>    schbench:  1/2/4/8 mthreads
> 
>    direct:    cfs_rq has only one entity
>    parity:    RUN_TO_PARITY
>    fast:      O(1) fastpath
>    slow:	     heap search
> 
>      (%)		direct	parity	fast	slow
>    hackbench	92.95	2.02	4.91	0.12
>    netperf	68.08	6.60	24.18	1.14
>    tbench	67.55	11.22	20.61	0.62
>    schbench	69.91	2.65	25.73	1.71
> 
> The above results indicate that this fastpath really makes task
> selection more efficient.
> 
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> ---
>   kernel/sched/fair.c | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 459487bf8824..a1fdd0c7a051 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -896,6 +896,7 @@ int sched_update_scaling(void)
>   static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
>   {
>   	struct rb_node *node = cfs_rq->tasks_timeline.rb_root.rb_node;
> +	struct sched_entity *se = __pick_first_entity(cfs_rq);
>   	struct sched_entity *curr = cfs_rq->curr;
>   	struct sched_entity *best = NULL;
>   
> @@ -904,7 +905,7 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
>   	 * in this cfs_rq, saving some cycles.
>   	 */
>   	if (cfs_rq->nr_running == 1)
> -		return curr && curr->on_rq ? curr : __node_2_se(node);
> +		return curr && curr->on_rq ? curr : se;

Maybe we can reduce memory footprint on curr by:

		return se ? se : curr;

>   
>   	if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
>   		curr = NULL;
> @@ -916,9 +917,14 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
>   	if (sched_feat(RUN_TO_PARITY) && curr && curr->vlag == curr->deadline)
>   		return curr;
>   
> +	/* Pick the leftmost entity if it's eligible */
> +	if (se && entity_eligible(cfs_rq, se)) {
> +		best = se;
> +		goto found;
> +	}
> +
>   	/* Heap search for the EEVD entity */
>   	while (node) {
> -		struct sched_entity *se = __node_2_se(node);
>   		struct rb_node *left = node->rb_left;
>   
>   		/*
> @@ -931,6 +937,8 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
>   			continue;
>   		}
>   
> +		se = __node_2_se(node);
> +
>   		/*
>   		 * The left subtree either is empty or has no eligible
>   		 * entity, so check the current node since it is the one
> @@ -943,7 +951,7 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
>   
>   		node = node->rb_right;
>   	}
> -
> +found:
>   	if (!best || (curr && entity_before(curr, best)))
>   		best = curr;
>   
