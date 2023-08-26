Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36ECF78991A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 22:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjHZUm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 16:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjHZUmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 16:42:03 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C17EE6A
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 13:41:59 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4013454fa93so17554125e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 13:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1693082518; x=1693687318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E7YN0wCnIq+t8XafVYpgVaLqsH4A98UuAWrQzG8X/LI=;
        b=StCsZmo1lPqed69uGsGJWmupb8iSz/a6VVg2PD/Nv/ReJW2pZekZcq5JFq+OTiS6pA
         xCkiOcLRjDwVCihnDmdbHE0Vb0BVYqE+JwTB5NvZWfqyqDcO0U/1YbNrviNaWnuFg+R6
         KJz5ZlYY7EN3YKUEnKRRgqt9ulaupDqTk0+DTz6HTr+S6boK3s1Yt4bRhZxe79ZcLoRC
         8hLHG39Uc+7JChFRvfko1cAs+eWOZgBErF0V3nZyn6pfc8nz8a6fHadtLcRlj+qS6eYL
         RMQ4q2Ge0I2f8+0SESEapP7IFGKRo3XC6tc+5gBYcqa+IhWOb9UM5pj9AzOBQhX2E2XJ
         SqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693082518; x=1693687318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E7YN0wCnIq+t8XafVYpgVaLqsH4A98UuAWrQzG8X/LI=;
        b=EeRoBNpleNwICMGYuDKsn1gKo1DYa2rUxcEbjTl6v2CZTEwtVRXhrtKUuxRGzD3hGb
         PNWNuNhN7qIEKxyEcSX1Ls9jsUKoAjCtxTC21XLGGU5p26M7anNXbCwri9R3l6pAUVJp
         vGLJFWcbiMEnet9Dh9/1UL4i4mCcXkQ/XH5wnpACzTdlFO1hvO10zq7cBjaTHqsAQwf/
         EOZjFcphQ6WQHl/ml8L184Um/48/McjCUiOOaN5HZjajQbosGsxEfRcI5UpCypMX+9AF
         zqbNBS23Rt7nE3M0Zez5mFUXSmuBQGbXArgGtDZhVtZQCp/Ce1El2wLUBDdAzEJ7X/3m
         ee/A==
X-Gm-Message-State: AOJu0YyXDJLQXagZiz3NZCU3OQS95C3ZFYDVl5cc/0xwhu6mAli4ekU4
        HunN87jylGImch4ttVNoJiE8PA==
X-Google-Smtp-Source: AGHT+IGkpLKXHWWbAJl9BDM6aWVZGrb69jLmc5BIgx+3cnaEzs0eZFHYSRP3GNwtTxzSUcdGEF6iig==
X-Received: by 2002:a7b:cb96:0:b0:401:b53e:6c54 with SMTP id m22-20020a7bcb96000000b00401b53e6c54mr4034046wmi.7.1693082518031;
        Sat, 26 Aug 2023 13:41:58 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id f2-20020a7bcd02000000b003fba6a0c881sm9153780wmj.43.2023.08.26.13.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 13:41:57 -0700 (PDT)
Date:   Sat, 26 Aug 2023 21:41:56 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        Wei Wang <wvw@google.com>, Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hongyan Xia <hongyan.xia2@arm.com>
Subject: Re: [PATCH v4 1/3] sched/uclamp: Set max_spare_cap_cpu even if
 max_spare_cap is 0
Message-ID: <20230826204156.5gznalle6qzwl7y3@airbuntu>
References: <20230821224504.710576-1-qyousef@layalina.io>
 <20230821224504.710576-2-qyousef@layalina.io>
 <d5407fdf-8e49-1035-3188-f96248c96c44@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d5407fdf-8e49-1035-3188-f96248c96c44@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/23/23 12:30, Dietmar Eggemann wrote:
> On 22/08/2023 00:45, Qais Yousef wrote:
> > When uclamp_max is being used, the util of the task could be higher than
> > the spare capacity of the CPU, but due to uclamp_max value we force fit
> > it there.
> > 
> > The way the condition for checking for max_spare_cap in
> > find_energy_efficient_cpu() was constructed; it ignored any CPU that has
> > its spare_cap less than or _equal_ to max_spare_cap. Since we initialize
> > max_spare_cap to 0; this lead to never setting max_spare_cap_cpu and
> > hence ending up never performing compute_energy() for this cluster and
> > missing an opportunity for a better energy efficient placement to honour
> > uclamp_max setting.
> > 
> > 	max_spare_cap = 0;
> > 	cpu_cap = capacity_of(cpu) - task_util(p);  // 0 if task_util(p) is high
> 
> Nitpick:
> 
> s/task_util(p)/cpu_util(cpu, p, cpu, ...) which is
> 
> max(cpu_util + task_util, cpu_util_est + task_util_est)
> 
> > 
> > 	...
> > 
> > 	util_fits_cpu(...);		// will return true if uclamp_max forces it to fit
> > 
> > 	...
> > 
> > 	// this logic will fail to update max_spare_cap_cpu if cpu_cap is 0
> > 	if (cpu_cap > max_spare_cap) {
> > 		max_spare_cap = cpu_cap;
> > 		max_spare_cap_cpu = cpu;
> > 	}
> > 
> > prev_spare_cap suffers from a similar problem.
> > 
> > Fix the logic by converting the variables into long and treating -1
> > value as 'not populated' instead of 0 which is a viable and correct
> > spare capacity value. We need to be careful signed comparison is used
> > when comparing with cpu_cap in one of the conditions.
> > 
> > Fixes: 1d42509e475c ("sched/fair: Make EAS wakeup placement consider uclamp restrictions")
> > Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> > Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> > ---
> >  kernel/sched/fair.c | 11 +++++------
> >  1 file changed, 5 insertions(+), 6 deletions(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 0b7445cd5af9..5da6538ed220 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7707,11 +7707,10 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >  	for (; pd; pd = pd->next) {
> >  		unsigned long util_min = p_util_min, util_max = p_util_max;
> >  		unsigned long cpu_cap, cpu_thermal_cap, util;
> > -		unsigned long cur_delta, max_spare_cap = 0;
> > +		long prev_spare_cap = -1, max_spare_cap = -1;
> >  		unsigned long rq_util_min, rq_util_max;
> > -		unsigned long prev_spare_cap = 0;
> > +		unsigned long cur_delta, base_energy;
> >  		int max_spare_cap_cpu = -1;
> > -		unsigned long base_energy;
> >  		int fits, max_fits = -1;
> >  
> >  		cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask);
> > @@ -7774,7 +7773,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >  				prev_spare_cap = cpu_cap;
> >  				prev_fits = fits;
> >  			} else if ((fits > max_fits) ||
> > -				   ((fits == max_fits) && (cpu_cap > max_spare_cap))) {
> > +				   ((fits == max_fits) && ((long)cpu_cap > max_spare_cap))) {
> >  				/*
> >  				 * Find the CPU with the maximum spare capacity
> >  				 * among the remaining CPUs in the performance
> > @@ -7786,7 +7785,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >  			}
> >  		}
> >  
> > -		if (max_spare_cap_cpu < 0 && prev_spare_cap == 0)
> > +		if (max_spare_cap_cpu < 0 && prev_spare_cap < 0)
> >  			continue;
> >  
> >  		eenv_pd_busy_time(&eenv, cpus, p);
> > @@ -7794,7 +7793,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >  		base_energy = compute_energy(&eenv, pd, cpus, p, -1);
> >  
> >  		/* Evaluate the energy impact of using prev_cpu. */
> > -		if (prev_spare_cap > 0) {
> > +		if (prev_spare_cap > -1) {
> >  			prev_delta = compute_energy(&eenv, pd, cpus, p,
> >  						    prev_cpu);
> >  			/* CPU utilization has changed */
> 
> We still need a solution to deal with situations in which `pd + task
> contribution` > `pd_capacity`:
> 
>   compute_energy()
> 
>     if (dst_cpu >= 0)
>      busy_time = min(pd_capacity, pd_busy_time + task_busy_time);
>                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>                                   pd + task contribution
> 
> busy_time is based on util (ENERGY_UTIL), not on the uclamp values
> (FREQUENCY_UTIL) we try to fit into a PD (and finally onto a CPU).
> 
> With that as a reminder for us and the change in the cover letter:

This is not being ignored, but I don't see this as an urgent problem too. There
are more pressing issues that make uclamp_max not effective in practice, and
this ain't a bottleneck yet. Actually it might be doing a good thing as there's
a desire to keep those tasks away on smallest CPU. But we shall visit this
later for sure, don't worry :-) Ultimately we want EAS algorithm to be the
judge of best placement for sure.

I hope to send patches to address load balancer and max aggregation issues in
the coming weeks.

> 
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Thanks for the review!

I will wait for the maintainers to see if they would like a v5 to address the
nitpicks or it's actually good enough and happy to pick this up. I think the
commit messages explain the problem clear enough and doesn't warrant sending
a new version. But happy to do so if there's insistence :-)


Thanks!

--
Qais Yousef
