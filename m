Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BF07AAC64
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbjIVIOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbjIVIOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:14:15 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73012D69
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 01:13:15 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4053c6f0d55so7096155e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 01:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695370394; x=1695975194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ImV7moxaH4nIogkks9X+lfrtLjUx4JnnRZu2gqe0D7Y=;
        b=CuvOYzf6JBdS+sIJ2wVZWkdjVJLbu0huqQIkOVIB6VlOnRsS2da3+StyuppplwmgMB
         PZZdb/AtnxcWHgGbvieFoeOcYaoRDskyAn1qZmXklPIF07EVs4BzjqKsrYebWtvHOIL8
         JUQ4zE8LjL2xtljmJUWbT497NPjhaDmpWbxaWmm7b9VdlY4+4QEh85n/D/X5LkoNgLWw
         1wsqT53U2Bek0CCBSDu2kIb5VLhLneGVw+KEsg/amRr1L59DiYqEFaW+vZFct1d63Lq1
         47nQ5AHc1jdifmeFPbt32ReNUCPvdH+RPN5Z4PTSYxcXwo/FAiFAMfB1EpoUWxnZCjz4
         iLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695370394; x=1695975194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ImV7moxaH4nIogkks9X+lfrtLjUx4JnnRZu2gqe0D7Y=;
        b=hNSS9jlOmLhvpyVIqRarK5t+m0qz2aE31Bfdl7c0PvIqPwLPP3J1hNmrn4/t3N6dH9
         A0Fo2dKiAJ4HfaqflelvoXQhcoYIDiO5e1fucijAsLkauONcDPuXRJwmKpHBfSgqxVBk
         8ooZACMuhgbJ6Rbc4dcUzMfdjDfECvQpUEcXrOCCxu6aYA+/BoWmpsW6qQdEjuHtfUE7
         wf/yjo9ci3WPXA+xjB593fhb8d/8cNWxc/Turs9SU6BUBJGzPnmN1NwiLwnVy3Ff/t54
         rUA9O/SBX/q15e3ywC/7q9xMbmBpebr17DoEDfkggw8OtIrNVcKq0NYimAtIEM1+TRUT
         hSOQ==
X-Gm-Message-State: AOJu0Yzs8FAyJFr+xxCQxw0/P3cb3yuEA0PZbypo5asc1VhH588e41Br
        VtHDI1hhpxm2dTJ/cJCjZus=
X-Google-Smtp-Source: AGHT+IHZXrTDNWEUiO4R4XIJ2G4AXv673JlDpNQ5kGCxOeOAIs6gUcGYNk+oehnYoJZRXpP+yVvz7w==
X-Received: by 2002:a1c:4b12:0:b0:3fe:1f93:8cf4 with SMTP id y18-20020a1c4b12000000b003fe1f938cf4mr7545608wma.8.1695370394101;
        Fri, 22 Sep 2023 01:13:14 -0700 (PDT)
Received: from gmail.com (1F2EF49C.nat.pool.telekom.hu. [31.46.244.156])
        by smtp.gmail.com with ESMTPSA id c23-20020a7bc857000000b003fefca26c72sm3981686wml.23.2023.09.22.01.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 01:13:13 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 22 Sep 2023 10:13:11 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched: fix warning in bandwidth distribution
Message-ID: <ZQ1Ml8fudWETJkY6@gmail.com>
References: <20230922013750.874131-1-joshdon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922013750.874131-1-joshdon@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Josh Don <joshdon@google.com> wrote:

> We've observed the following warning being hit in
> distribute_cfs_runtime():
> 	SCHED_WARN_ON(cfs_rq->runtime_remaining > 0)
> 
> We have the following race:
> 
> - cpu0: running bandwidth distribution (distribute_cfs_runtime).
>   Inspects the local cfs_rq and makes its runtime_remaining positive.
>   However, we defer unthrottling the local cfs_rq until after
>   considering all remote cfs_rq's.
> - cpu1: starts running bandwidth distribution from the slack timer. When
>   it finds the cfs_rq for cpu 0 on the throttled list, it observers the
>   that the cfs_rq is throttled, yet is not on the CSD list, and has a
>   positive runtime_remaining, thus triggering the warning in
>   distribute_cfs_runtime.
> 
> To fix this, we can rework the local unthrottling logic to put the local
> cfs_rq on a local list, so that any future bandwidth distributions will
> realize that the cfs_rq is about to be unthrottled.
> 
> Signed-off-by: Josh Don <joshdon@google.com>
> ---
> v2: Fix build error on !CONFIG_SMP
> 
>  kernel/sched/fair.c | 43 +++++++++++++++++++++++++++++++++----------
>  1 file changed, 33 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 384900bf87eb..3d1886ea18fe 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5743,13 +5743,16 @@ static void unthrottle_cfs_rq_async(struct cfs_rq *cfs_rq)
>  
>  static bool distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
>  {
> -	struct cfs_rq *local_unthrottle = NULL;
>  	int this_cpu = smp_processor_id();
>  	u64 runtime, remaining = 1;
>  	bool throttled = false;
>  	struct cfs_rq *cfs_rq;
>  	struct rq_flags rf;
>  	struct rq *rq;
> +#ifdef CONFIG_SMP
> +	struct cfs_rq *tmp;
> +	LIST_HEAD(local_unthrottle);
> +#endif
>  
>  	rcu_read_lock();
>  	list_for_each_entry_rcu(cfs_rq, &cfs_b->throttled_cfs_rq,
> @@ -5786,11 +5789,21 @@ static bool distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
>  
>  		/* we check whether we're throttled above */
>  		if (cfs_rq->runtime_remaining > 0) {
> -			if (cpu_of(rq) != this_cpu ||
> -			    SCHED_WARN_ON(local_unthrottle))
> +#ifdef CONFIG_SMP
> +			if (cpu_of(rq) != this_cpu) {
>  				unthrottle_cfs_rq_async(cfs_rq);
> -			else
> -				local_unthrottle = cfs_rq;
> +			} else {
> +				/*
> +				 * We currently only expect to be unthrottling
> +				 * a single cfs_rq locally.
> +				 */
> +				SCHED_WARN_ON(!list_empty(&local_unthrottle));
> +				list_add_tail(&cfs_rq->throttled_csd_list,
> +					      &local_unthrottle);
> +			}
> +#else
> +			unthrottle_cfs_rq_async(cfs_rq);
> +#endif
>  		} else {
>  			throttled = true;
>  		}
> @@ -5798,15 +5811,25 @@ static bool distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
>  next:
>  		rq_unlock_irqrestore(rq, &rf);
>  	}
> -	rcu_read_unlock();
>  
> -	if (local_unthrottle) {
> -		rq = cpu_rq(this_cpu);
> +#ifdef CONFIG_SMP
> +	list_for_each_entry_safe(cfs_rq, tmp, &local_unthrottle,
> +				 throttled_csd_list) {
> +		struct rq *rq = rq_of(cfs_rq);
> +
>  		rq_lock_irqsave(rq, &rf);
> -		if (cfs_rq_throttled(local_unthrottle))
> -			unthrottle_cfs_rq(local_unthrottle);
> +
> +		list_del_init(&cfs_rq->throttled_csd_list);
> +
> +		if (cfs_rq_throttled(cfs_rq))
> +			unthrottle_cfs_rq(cfs_rq);
> +
>  		rq_unlock_irqrestore(rq, &rf);
>  	}
> +	SCHED_WARN_ON(!list_empty(&local_unthrottle));
> +#endif

So instead of uglifying the code with seldom-tested !CONFIG_SMP #ifdefs, 
please fold the !SMP code into SMP code: make ->throttled_csd_list 
unconditional in a preparatory patch (even if it's essentially unused on 
!SMP), then add what is basically your v1 patch as a second patch in the 
series to fix the bug.

We want to unify as much of the SMP and !SMP codepaths as possible, even 
when it casuses a bit of runtime overhead for !SMP.

Thanks,

	Ingo
