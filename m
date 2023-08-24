Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B6C786FE3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 15:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238267AbjHXNEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 09:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238203AbjHXNEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 09:04:08 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48569CEE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 06:04:06 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-569deb93999so3021662a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 06:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692882246; x=1693487046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1o+2vd8c1a4db2KHxk6F8Sj0RF0g8Sua7zW/c976nvQ=;
        b=MZDS1sEFd+HsZ+aTpjqthosRZvdHFRXYAoCWXfa/sP8D98tdd2rjvn47oBPxW+UHN6
         /e5RzIY2nZEteSNkRCmTpF7YPZt50mtHhCZ2MOJoxhcRSPrfl5vTo1gHeP/iEQZ/sVwS
         f2/bd0iTScYUW7/2EGbaAAjWukCWHkXSo2QK8HxUuh7PxbLPV24vAG+HW8EfcH0rjozP
         OhKjqssLD3FEOLWcOTDNTAkmbGKRaVGsbm6OiAKxwvAisKD6yKDI2ATTpHZGnYY7dqyx
         zTeIWWaZrM4DgtV1RkoPDYsiII32dGQTvLHoaIffauG3/8chPqTYVcGjDmgekerrBMDs
         8n6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692882246; x=1693487046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1o+2vd8c1a4db2KHxk6F8Sj0RF0g8Sua7zW/c976nvQ=;
        b=FFa7eecQW/Ox+zzeQ9DhfeT30PREWAtJaBV9t6uBvDXcqjnLzHtHwSD68KocVuF2Wk
         9fPQpdiaSL2T8QIM183HUlj9wfRyqOLpuPOPGwrUMyk2a6EbI+7exucVvLT1FjlYZOTX
         957m0edMVhaIs8jHfCTkRMnl7ht/y6fY5K3cVrdd9v9FuSjw0NyBvfQBwyOx7h17n8oh
         H4NdxKE93WnSRlBelxcvUrCxQqM8Woy1gvQsou50TDRSGDCmiQGnneroIcbDaKjQO9E5
         cFqekn7/7pUS+uIMk+WjMQRkAaS0V+sH4MZeh/Z0tO8NVht0svoaAu3Eo0JNU03gSsNk
         YoFg==
X-Gm-Message-State: AOJu0Yym1ON+EM3zYcWZ+m9AADKjZlTxkFrdCRA1gFnMN4SD5tRvpyRg
        cZYi1iTlGxJmoi8/4s/sOZgV/L68OKlfq/7ce3aQLg==
X-Google-Smtp-Source: AGHT+IGrqMmOSeHA06K1Myxf5V23X1bVD9OLQANMJzne2qABEH0M+Hnk3Khp/XLXU6jjxhl+ebFwya5kKpDxIrBgwPY=
X-Received: by 2002:a05:6a20:6d9d:b0:13d:ac08:6b79 with SMTP id
 gl29-20020a056a206d9d00b0013dac086b79mr10488240pzb.60.1692882245454; Thu, 24
 Aug 2023 06:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230823060832.454842-1-aaron.lu@intel.com> <20230823060832.454842-2-aaron.lu@intel.com>
 <fd568884-9df4-2990-7b81-655fc7f63a4a@efficios.com> <20230824080142.GB459974@ziqianlu-dell>
 <2192e838-48d1-9dec-5769-74a4a048f3c2@efficios.com>
In-Reply-To: <2192e838-48d1-9dec-5769-74a4a048f3c2@efficios.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 24 Aug 2023 15:03:54 +0200
Message-ID: <CAKfTPtDSjWCyrKpf6ftQtBi9zZC=zQn0tx7e1_eLRMi0M02FpA@mail.gmail.com>
Subject: Re: [PATCH 1/1] sched/fair: ratelimit update to tg->load_avg
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Aaron Lu <aaron.lu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Yu Chen <yu.c.chen@intel.com>,
        Waiman Long <longman@redhat.com>,
        Deng Pan <pan.deng@intel.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Aug 2023 at 14:55, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 8/24/23 04:01, Aaron Lu wrote:
> > On Wed, Aug 23, 2023 at 10:05:31AM -0400, Mathieu Desnoyers wrote:
> >> On 8/23/23 02:08, Aaron Lu wrote:
> >>> When using sysbench to benchmark Postgres in a single docker instance
> >>> with sysbench's nr_threads set to nr_cpu, it is observed there are ti=
mes
> >>> update_cfs_group() and update_load_avg() shows noticeable overhead on
> >>> a 2sockets/112core/224cpu Intel Sapphire Rapids(SPR):
> >>>
> >>>       13.75%    13.74%  [kernel.vmlinux]           [k] update_cfs_gro=
up
> >>>       10.63%    10.04%  [kernel.vmlinux]           [k] update_load_av=
g
> >>>
> >>> Annotate shows the cycles are mostly spent on accessing tg->load_avg
> >>> with update_load_avg() being the write side and update_cfs_group() be=
ing
> >>> the read side. tg->load_avg is per task group and when different task=
s
> >>> of the same taskgroup running on different CPUs frequently access
> >>> tg->load_avg, it can be heavily contended.
> >>>
> >>> E.g. when running postgres_sysbench on a 2sockets/112cores/224cpus In=
tel
> >>> Sappire Rapids, during a 5s window, the wakeup number is 14millions a=
nd
> >>> migration number is 11millions and with each migration, the task's lo=
ad
> >>> will transfer from src cfs_rq to target cfs_rq and each change involv=
es
> >>> an update to tg->load_avg. Since the workload can trigger as many wak=
eups
> >>> and migrations, the access(both read and write) to tg->load_avg can b=
e
> >>> unbound. As a result, the two mentioned functions showed noticeable
> >>> overhead. With netperf/nr_client=3Dnr_cpu/UDP_RR, the problem is wors=
e:
> >>> during a 5s window, wakeup number is 21millions and migration number =
is
> >>> 14millions; update_cfs_group() costs ~25% and update_load_avg() costs=
 ~16%.
> >>>
> >>> Reduce the overhead by limiting updates to tg->load_avg to at most on=
ce
> >>> per ms. After this change, the cost of accessing tg->load_avg is grea=
tly
> >>> reduced and performance improved. Detailed test results below.
> >>
> >> By applying your patch on top of my patchset at:
> >>
> >> https://lore.kernel.org/lkml/20230822113133.643238-1-mathieu.desnoyers=
@efficios.com/
> >>
> >> The combined hackbench results look very promising:
> >>
> >> (hackbench -g 32 -f 20 --threads --pipe -l 480000 -s 100)
> >> (192 cores AMD EPYC 9654 96-Core Processor (over 2 sockets), with hype=
rthreading)
> >>
> >> Baseline:                                       49s
> >> With L2-ttwu-queue-skip:                        34s (30% speedup)
> >> With L2-ttwu-queue-skip + ratelimit-load-avg:   26s (46% speedup)
> >>
> >> Feel free to apply my:
> >>
> >> Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> >> Tested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> >
> > Thanks a lot for running this and reviewing the patch.
> > I'll add your number and tag in the changelog when sending a new
> > version.
>
> Now that I come to think of it, I have comment: why use
> sched_clock_cpu() rather than just read the jiffies value ? AFAIR,
> sched_clock can be slower than needed when read from a "remote" cpu on
> architectures that have an unsynchronized tsc.
>
> Considering that you only need a time reference more or less accurate at
> the millisecond level, I suspect that jiffies is what you are looking
> for here. This is what the NUMA balance code and rseq mm_cid use to
> execute work every N milliseconds.

tick can 4ms or even 10ms which means a rate limit up between 10ms to
20ms in the latter case

>
> Thanks,
>
> Mathieu
>
> >
> > Regards,
> > Aaron
> >
> >>>
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> >>> postgres_sysbench on SPR:
> >>> 25%
> >>> base:   42382=C2=B119.8%
> >>> patch:  50174=C2=B19.5%  (noise)
> >>>
> >>> 50%
> >>> base:   67626=C2=B11.3%
> >>> patch:  67365=C2=B13.1%  (noise)
> >>>
> >>> 75%
> >>> base:   100216=C2=B11.2%
> >>> patch:  112470=C2=B10.1% +12.2%
> >>>
> >>> 100%
> >>> base:    93671=C2=B10.4%
> >>> patch:  113563=C2=B10.2% +21.2%
> >>>
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> >>> hackbench on ICL:
> >>> group=3D1
> >>> base:    114912=C2=B15.2%
> >>> patch:   117857=C2=B12.5%  (noise)
> >>>
> >>> group=3D4
> >>> base:    359902=C2=B11.6%
> >>> patch:   361685=C2=B12.7%  (noise)
> >>>
> >>> group=3D8
> >>> base:    461070=C2=B10.8%
> >>> patch:   491713=C2=B10.3% +6.6%
> >>>
> >>> group=3D16
> >>> base:    309032=C2=B15.0%
> >>> patch:   378337=C2=B11.3% +22.4%
> >>>
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> >>> hackbench on SPR:
> >>> group=3D1
> >>> base:    100768=C2=B12.9%
> >>> patch:   103134=C2=B12.9%  (noise)
> >>>
> >>> group=3D4
> >>> base:    413830=C2=B112.5%
> >>> patch:   378660=C2=B116.6% (noise)
> >>>
> >>> group=3D8
> >>> base:    436124=C2=B10.6%
> >>> patch:   490787=C2=B13.2% +12.5%
> >>>
> >>> group=3D16
> >>> base:    457730=C2=B13.2%
> >>> patch:   680452=C2=B11.3% +48.8%
> >>>
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> >>> netperf/udp_rr on ICL
> >>> 25%
> >>> base:    114413=C2=B10.1%
> >>> patch:   115111=C2=B10.0% +0.6%
> >>>
> >>> 50%
> >>> base:    86803=C2=B10.5%
> >>> patch:   86611=C2=B10.0%  (noise)
> >>>
> >>> 75%
> >>> base:    35959=C2=B15.3%
> >>> patch:   49801=C2=B10.6% +38.5%
> >>>
> >>> 100%
> >>> base:    61951=C2=B16.4%
> >>> patch:   70224=C2=B10.8% +13.4%
> >>>
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> >>> netperf/udp_rr on SPR
> >>> 25%
> >>> base:   104954=C2=B11.3%
> >>> patch:  107312=C2=B12.8%  (noise)
> >>>
> >>> 50%
> >>> base:    55394=C2=B14.6%
> >>> patch:   54940=C2=B17.4%  (noise)
> >>>
> >>> 75%
> >>> base:    13779=C2=B13.1%
> >>> patch:   36105=C2=B11.1% +162%
> >>>
> >>> 100%
> >>> base:     9703=C2=B13.7%
> >>> patch:   28011=C2=B10.2% +189%
> >>>
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> netperf/tcp_stream on ICL (all in noise range)
> >>> 25%
> >>> base:    43092=C2=B10.1%
> >>> patch:   42891=C2=B10.5%
> >>>
> >>> 50%
> >>> base:    19278=C2=B114.9%
> >>> patch:   22369=C2=B17.2%
> >>>
> >>> 75%
> >>> base:    16822=C2=B13.0%
> >>> patch:   17086=C2=B12.3%
> >>>
> >>> 100%
> >>> base:    18216=C2=B10.6%
> >>> patch:   18078=C2=B12.9%
> >>>
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> netperf/tcp_stream on SPR (all in noise range)
> >>> 25%
> >>> base:    34491=C2=B10.3%
> >>> patch:   34886=C2=B10.5%
> >>>
> >>> 50%
> >>> base:    19278=C2=B114.9%
> >>> patch:   22369=C2=B17.2%
> >>>
> >>> 75%
> >>> base:    16822=C2=B13.0%
> >>> patch:   17086=C2=B12.3%
> >>>
> >>> 100%
> >>> base:    18216=C2=B10.6%
> >>> patch:   18078=C2=B12.9%
> >>>
> >>> Reported-by: Nitin Tekchandani <nitin.tekchandani@intel.com>
> >>> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> >>> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> >>> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> >>> ---
> >>>    kernel/sched/fair.c  | 13 ++++++++++++-
> >>>    kernel/sched/sched.h |  1 +
> >>>    2 files changed, 13 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >>> index c28206499a3d..a5462d1fcc48 100644
> >>> --- a/kernel/sched/fair.c
> >>> +++ b/kernel/sched/fair.c
> >>> @@ -3664,7 +3664,8 @@ static inline bool cfs_rq_is_decayed(struct cfs=
_rq *cfs_rq)
> >>>     */
> >>>    static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
> >>>    {
> >>> -   long delta =3D cfs_rq->avg.load_avg - cfs_rq->tg_load_avg_contrib=
;
> >>> +   long delta;
> >>> +   u64 now;
> >>>     /*
> >>>      * No need to update load_avg for root_task_group as it is not us=
ed.
> >>> @@ -3672,9 +3673,19 @@ static inline void update_tg_load_avg(struct c=
fs_rq *cfs_rq)
> >>>     if (cfs_rq->tg =3D=3D &root_task_group)
> >>>             return;
> >>> +   /*
> >>> +    * For migration heavy workload, access to tg->load_avg can be
> >>> +    * unbound. Limit the update rate to at most once per ms.
> >>> +    */
> >>> +   now =3D sched_clock_cpu(cpu_of(rq_of(cfs_rq)));
> >>> +   if (now - cfs_rq->last_update_tg_load_avg < NSEC_PER_MSEC)
> >>> +           return;
> >>> +
> >>> +   delta =3D cfs_rq->avg.load_avg - cfs_rq->tg_load_avg_contrib;
> >>>     if (abs(delta) > cfs_rq->tg_load_avg_contrib / 64) {
> >>>             atomic_long_add(delta, &cfs_rq->tg->load_avg);
> >>>             cfs_rq->tg_load_avg_contrib =3D cfs_rq->avg.load_avg;
> >>> +           cfs_rq->last_update_tg_load_avg =3D now;
> >>>     }
> >>>    }
> >>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> >>> index 6a8b7b9ed089..52ee7027def9 100644
> >>> --- a/kernel/sched/sched.h
> >>> +++ b/kernel/sched/sched.h
> >>> @@ -593,6 +593,7 @@ struct cfs_rq {
> >>>     } removed;
> >>>    #ifdef CONFIG_FAIR_GROUP_SCHED
> >>> +   u64                     last_update_tg_load_avg;
> >>>     unsigned long           tg_load_avg_contrib;
> >>>     long                    propagate;
> >>>     long                    prop_runnable_sum;
> >>
> >> --
> >> Mathieu Desnoyers
> >> EfficiOS Inc.
> >> https://www.efficios.com
> >>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
>
