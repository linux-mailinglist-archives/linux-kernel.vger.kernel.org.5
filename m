Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64017C0007
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbjJJPL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbjJJPL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:11:26 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A2AC6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 08:11:22 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2773f776f49so4228607a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 08:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696950681; x=1697555481; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3o7lXdoi8/vCLslYBSAmuDPbLS9cWUrXNd7Dt/FwkyM=;
        b=jE+8Hby9QphLm+cAbmirVgK4cZkU3wnoYlSh0ZrKARgMEZum4unVkkxwKUJReIVQcr
         2IvK/ao+lLjpBmTgBg5gKcCCzkMnSLYaekVZDQSNsI9x/MWVrtmS40PRGxo3nIm0HoCj
         zfw4r9etx2gte5knSKw6uk4vxxAUpWw9lN6B9YyHQxzqCAs0wuHzM0qk4ABGS8B9AJym
         T8sfTXLjKzEeRdwcunhqSbmbR5n6mwVM/pdy1H20e/4ByKPZ15Lu3+fMWoWhQyTqA9DI
         rqUdMgkMb3qqiHGqC2Vj3g72ozDHYRxRAjXvR2Z9G0RsR/otcj+ZzoVcnAdcBATmtakW
         FcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696950681; x=1697555481;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3o7lXdoi8/vCLslYBSAmuDPbLS9cWUrXNd7Dt/FwkyM=;
        b=hISNlZigN6JO4SArFJ9FwAzTV+451D2G5TV/cCtbA5xfJ1F0hobxg3n6G4nElfe/hM
         Nf6xHXy5STPqGUlHqXsGsspLzLGkf9IswVo555e5AaM4OVtsZ8MWQy5NwhjMuBWNXVxB
         XhAxx0EJ90Gyb2/dHJzYIVlR6tzKluVz/yJCaavmuwCrJlxAQb6TMBR07vroVN9+8TnO
         8YvnVrt2cJFXtMOvEM3c6dY4M1rZ3zv/M9O2ubL8Zp8uH1fnvN23v6ar0MPKsp6TT8L5
         GE6aT0gngyncihofjCJvvppaB1A8+hsW/eAZ8m9tUEi8r+V0PhOillS/ppSPlIXAqIwx
         hw9Q==
X-Gm-Message-State: AOJu0YzbweTetyt92WmWs3TOTZ5Re+d5Xhx/kXLWaFE/ou8gcm5c3PvJ
        yA9fGJpypeKV4R9Yo7DkK8qi4h0NGC0GoergeCElKA==
X-Google-Smtp-Source: AGHT+IFGwML8SQsmbPamtfa9arU12vj+EEyX/jO155FOoLf2gqCrMYJgh7RCBKMWjxziEuTu5LQFgxFPEYDRtLtGeLs=
X-Received: by 2002:a17:90a:634c:b0:277:7810:ac74 with SMTP id
 v12-20020a17090a634c00b002777810ac74mr25857925pjs.10.1696950675992; Tue, 10
 Oct 2023 08:11:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230929183350.239721-1-mathieu.desnoyers@efficios.com>
 <ZRfKKxBzfu+kf0tM@chenyu5-mobl2.ccr.corp.intel.com> <0f3cfff3-0df4-3cb7-95cb-ea378517e13b@efficios.com>
 <ZSOMOhhkPIFmvz97@chenyu5-mobl2.ccr.corp.intel.com> <ebe4e40f-37df-40a9-9dfc-7f2a458151bd@efficios.com>
In-Reply-To: <ebe4e40f-37df-40a9-9dfc-7f2a458151bd@efficios.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 10 Oct 2023 17:11:04 +0200
Message-ID: <CAKfTPtBsGeVsfS=PkmsQzpH=yibBwQzdwydsu3D7gxU6GMqpMw@mail.gmail.com>
Subject: Re: [RFC PATCH] sched/fair: Bias runqueue selection towards almost
 idle prev CPU
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Chen Yu <yu.c.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Aaron Lu <aaron.lu@intel.com>, Tim Chen <tim.c.chen@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2023 at 15:49, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2023-10-09 01:14, Chen Yu wrote:
> > On 2023-09-30 at 07:45:38 -0400, Mathieu Desnoyers wrote:
> >> On 9/30/23 03:11, Chen Yu wrote:
> >>> Hi Mathieu,
> >>>
> >>> On 2023-09-29 at 14:33:50 -0400, Mathieu Desnoyers wrote:
> >>>> Introduce the WAKEUP_BIAS_PREV_IDLE scheduler feature. It biases
> >>>> select_task_rq towards the previous CPU if it was almost idle
> >>>> (avg_load <= 0.1%).
> >>>
> >>> Yes, this is a promising direction IMO. One question is that,
> >>> can cfs_rq->avg.load_avg be used for percentage comparison?
> >>> If I understand correctly, load_avg reflects that more than
> >>> 1 tasks could have been running this runqueue, and the
> >>> load_avg is the direct proportion to the load_weight of that
> >>> cfs_rq. Besides, LOAD_AVG_MAX seems to not be the max value
> >>> that load_avg can reach, it is the sum of
> >>> 1024 * (y + y^1 + y^2 ... )
> >>>
> >>> For example,
> >>> taskset -c 1 nice -n -20 stress -c 1
> >>> cat /sys/kernel/debug/sched/debug | grep 'cfs_rq\[1\]' -A 12 | grep "\.load_avg"
> >>>     .load_avg                      : 88763
> >>>     .load_avg                      : 1024
> >>>
> >>> 88763 is higher than LOAD_AVG_MAX=47742
> >>
> >> I would have expected the load_avg to be limited to LOAD_AVG_MAX somehow,
> >> but it appears that it does not happen in practice.
> >>
> >> That being said, if the cutoff is really at 0.1% or 0.2% of the real max,
> >> does it really matter ?
> >>
> >>> Maybe the util_avg can be used for precentage comparison I suppose?
> >> [...]
> >>> Or
> >>> return cpu_util_without(cpu_rq(cpu), p) * 1000 <= capacity_orig_of(cpu) ?
> >>
> >> Unfortunately using util_avg does not seem to work based on my testing.
> >> Even at utilization thresholds at 0.1%, 1% and 10%.
> >>
> >> Based on comments in fair.c:
> >>
> >>   * CPU utilization is the sum of running time of runnable tasks plus the
> >>   * recent utilization of currently non-runnable tasks on that CPU.
> >>
> >> I think we don't want to include currently non-runnable tasks in the
> >> statistics we use, because we are trying to figure out if the cpu is a
> >> idle-enough target based on the tasks which are currently running, for the
> >> purpose of runqueue selection when waking up a task which is considered at
> >> that point in time a non-runnable task on that cpu, and which is about to
> >> become runnable again.
> >>
> >
> > Although LOAD_AVG_MAX is not the max possible load_avg, we still want to find
> > a proper threshold to decide if the CPU is almost idle. The LOAD_AVG_MAX
> > based threshold is modified a little bit:
> >
> > The theory is, if there is only 1 task on the CPU, and that task has a nice
> > of 0, the task runs 50 us every 1000 us, then this CPU is regarded as almost
> > idle.
> >
> > The load_sum of the task is:
> > 50 * (1 + y + y^2 + ... + y^n)
> > The corresponding avg_load of the task is approximately
> > NICE_0_WEIGHT * load_sum / LOAD_AVG_MAX = 50.
> > So:
> >
> > /* which is close to LOAD_AVG_MAX/1000 = 47 */
> > #define ALMOST_IDLE_CPU_LOAD   50
>
> Sorry to be slow at understanding this concept, but this whole "load"
> value is still somewhat magic to me.
>
> Should it vary based on CONFIG_HZ_{100,250,300,1000}, or is it
> independent ? Where is it documented that the load is a value in "us"
> out of a window of 1000 us ?

nowhere because load_avg is not in usec. load_avg is the sum of
entities' load_avg which is based on the weight of the entity. The
weight of an entity is in the range [2:88761] and as a result its
load_avg. LOAD_AVG_MAX can be used with the *_sum fields but not the
*_avg fields of struct sched_avg

If you want to evaluate the idleness of a CPU with pelt signal, you
should better use util_avg or runnable_avg which are unweighted values
in the range [0:1024]



>
> And with this value "50", it would cover the case where there is only a
> single task taking less than 50us per 1000us, and cases where the sum
> for the set of tasks on the runqueue is taking less than 50us per 1000us
> overall.
>
> >
> > static bool
> > almost_idle_cpu(int cpu, struct task_struct *p)
> > {
> >         if (!sched_feat(WAKEUP_BIAS_PREV_IDLE))
> >                 return false;
> >         return cpu_load_without(cpu_rq(cpu), p) <= ALMOST_IDLE_CPU_LOAD;
> > }
> >
> > Tested this on Intel Xeon Platinum 8360Y, Ice Lake server, 36 core/package,
> > total 72 core/144 CPUs. Slight improvement is observed in hackbench socket mode:
> >
> > socket mode:
> > hackbench -g 16 -f 20 -l 480000 -s 100
> >
> > Before patch:
> > Running in process mode with 16 groups using 40 file descriptors each (== 640 tasks)
> > Each sender will pass 480000 messages of 100 bytes
> > Time: 81.084
> >
> > After patch:
> > Running in process mode with 16 groups using 40 file descriptors each (== 640 tasks)
> > Each sender will pass 480000 messages of 100 bytes
> > Time: 78.083
> >
> >
> > pipe mode:
> > hackbench -g 16 -f 20 --pipe  -l 480000 -s 100
> >
> > Before patch:
> > Running in process mode with 16 groups using 40 file descriptors each (== 640 tasks)
> > Each sender will pass 480000 messages of 100 bytes
> > Time: 38.219
> >
> > After patch:
> > Running in process mode with 16 groups using 40 file descriptors each (== 640 tasks)
> > Each sender will pass 480000 messages of 100 bytes
> > Time: 38.348
> >
> > It suggests that, if the workload has larger working-set/cache footprint, waking up
> > the task on its previous CPU could get more benefit.
>
> In those tests, what is the average % of idleness of your cpus ?
>
> Thanks,
>
> Mathieu
>
> >
> > thanks,
> > Chenyu
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
>
