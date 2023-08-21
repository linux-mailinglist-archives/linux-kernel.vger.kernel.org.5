Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375D77835D9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 00:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjHUWg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 18:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHUWgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 18:36:54 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EFAFD
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 15:36:52 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fee769fd53so22100315e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 15:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1692657411; x=1693262211;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MFj0aDdnMwdjhjqXyKxvEjp7gWB0IRos9bPslxm0vQc=;
        b=ZHnGVUixa7Edk6VVjgSY6LC9844CN6w2zXKnIuHQ2Fpro1Mf3NHyDLa7XG7ucXpVgu
         2Zq+P1O+jnmGWmW5YBWcNc6lelKqCSoR2FLHJKdiZ9ct5upu9mjW8fAkkzfKspA6kBas
         deMffRQNHXXO2kHQs2dlV5m+74cB4iAcQPZC07U0BFZL8/e+0n7VjA6EZFMosGbBBknB
         94cG+EW8EvqTbKWAJ+dLUjwJqcyRMi5b4mYngsKd9kjE7yRgxKXXopJ+wWrenS3w7zlk
         dnsMe9a1Cq8Ndvpg/CWuCY2FW7kjJZ6Y4TvsfKAtj8LqwmkYSnkXfb+LH44s6ksHJ0Fb
         wUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692657411; x=1693262211;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFj0aDdnMwdjhjqXyKxvEjp7gWB0IRos9bPslxm0vQc=;
        b=c64gu9z17aNIh+v5fQvOj6IieKAxyFCRDNt6h2876AunRjy9k7VsM+kwkEXMVb1snU
         ZPCEAIfj4BZX5rbcq+pfi1lNz58lvgcD6aB+SWla5hW6We0tinhAT5yQMuyYWe7yYE7q
         9sEswPQSF2Z7ze9PPZhZnhFul5TI6wc9aY9Vh7tMzu/6QJLthSdc8I1rGBBkhfryVTNZ
         jworCr5ne6vAEAOjrvzt0j2rsav9Pgq9OHmHUdj0FDebppoF3kbs29jfXQAhxL8Brv5a
         RS+iVs5Tmdt9CG5HSrnoPJ+qmpiIDPie0LQ4es5cRHgOsj6UQCxPs2WWvljAOmZKwlIf
         XzCQ==
X-Gm-Message-State: AOJu0YyJ1zG1/POXgas+obQMxkLWNn2smBGA8v3CE8L8qdZ0DfIbC8D3
        UdRMH1Mxu2ryoXoEZJGoHTaiuQ==
X-Google-Smtp-Source: AGHT+IFW9qGZBkIRx0vNpbniJEtTJvOapJlaPfxOf1JeC64fp87YabYgkQUCcUwCGU1/SGUS3WXhwQ==
X-Received: by 2002:a7b:c7d4:0:b0:3fa:93b0:a69c with SMTP id z20-20020a7bc7d4000000b003fa93b0a69cmr5919589wmk.24.1692657411282;
        Mon, 21 Aug 2023 15:36:51 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id q1-20020a1cf301000000b003feea62440bsm7427273wmq.43.2023.08.21.15.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 15:36:50 -0700 (PDT)
Date:   Mon, 21 Aug 2023 23:36:49 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, Wei Wang <wvw@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hongyan Xia <hongyan.xia2@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v3 3/3] sched/tp: Add new tracepoint to track compute
 energy computation
Message-ID: <20230821223649.aixoldq3udm2jw6t@airbuntu>
References: <20230717215717.309174-1-qyousef@layalina.io>
 <20230717215717.309174-4-qyousef@layalina.io>
 <0491f666-0995-357c-0905-6c9863ee9c9f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0491f666-0995-357c-0905-6c9863ee9c9f@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz

On 08/21/23 10:04, Lukasz Luba wrote:
> Hi Qais,
> 
> On 7/17/23 22:57, Qais Yousef wrote:
> > It was useful to track feec() placement decision and debug the spare
> > capacity and optimization issues vs uclamp_max.
> > 
> > Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> > ---
> >   include/trace/events/sched.h | 4 ++++
> >   kernel/sched/core.c          | 1 +
> >   kernel/sched/fair.c          | 7 ++++++-
> >   3 files changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> > index fbb99a61f714..20cc884f72ff 100644
> > --- a/include/trace/events/sched.h
> > +++ b/include/trace/events/sched.h
> > @@ -735,6 +735,10 @@ DECLARE_TRACE(sched_update_nr_running_tp,
> >   	TP_PROTO(struct rq *rq, int change),
> >   	TP_ARGS(rq, change));
> > +DECLARE_TRACE(sched_compute_energy_tp,
> > +	TP_PROTO(struct task_struct *p, int dst_cpu, unsigned long energy),
> > +	TP_ARGS(p, dst_cpu, energy));
> > +
> >   #endif /* _TRACE_SCHED_H */
> >   /* This part must be outside protection */
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 83e36547af17..2deca2dca625 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -114,6 +114,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_overutilized_tp);
> >   EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_cfs_tp);
> >   EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_se_tp);
> >   EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
> > +EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
> >   DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index c701f490ca4c..23e026393210 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7493,11 +7493,16 @@ compute_energy(struct energy_env *eenv, struct perf_domain *pd,
> >   {
> >   	unsigned long max_util = eenv_pd_max_util(eenv, pd_cpus, p, dst_cpu);
> >   	unsigned long busy_time = eenv->pd_busy_time;
> > +	unsigned long energy;
> >   	if (dst_cpu >= 0)
> >   		busy_time = min(eenv->pd_cap, busy_time + eenv->task_busy_time);
> > -	return em_cpu_energy(pd->em_pd, max_util, busy_time, eenv->cpu_cap);
> > +	energy = em_cpu_energy(pd->em_pd, max_util, busy_time, eenv->cpu_cap);
> > +
> > +	trace_sched_compute_energy_tp(p, dst_cpu, energy);
> 
> You've probably missed to add the change that we discussed in v2:
> 
> https://lore.kernel.org/lkml/20230221120832.x642tqohxv5nascr@airbuntu/
> 
> The max_util and busy_time. This would help us in our tool.

Ah, I did indeed. Sorry about that. Will send v4 then.


Cheers

--
Qais Yousef
