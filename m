Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDA5782864
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 13:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbjHUL5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 07:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbjHUL5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:57:48 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEF3B4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 04:57:46 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-565439b6b3fso1497406a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 04:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692619066; x=1693223866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vv+yXgiJW+2qgzIrJ6uIx4879w0vACOVHI/CbLMMXRo=;
        b=YzpDwpqTfqA/K8qsGYnBKvbO0A2tEqJjfP9A/kvx6NdvbG4W5JCtxPNyTEDj++/gsI
         lEo/NUB63XM5COJFgFPOcdlq+d4N9ssM7ZPP1bw9tlqJE88JHXW+GAIRhIQ0QlWLyNQ9
         UmyQnvPTrgrkTCPQBYSV9xeWjsQJNlHx/1WQlFuiHu9EsVAyIdH3y9gl2PkX+B1Ca2FS
         gzMXTU1YjM4S1/70Q5uHgVwA8AZndzeLdFeo6xYg5A+OmE2oemeEgCgzeznoWZ2BCkqy
         OCqU4K6u3AfgaShVwX91o+Kaf2tJwA0w5ZA7B4CEubJqUXTnfDt6PRweV8BQrG2TUZ/l
         68MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692619066; x=1693223866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vv+yXgiJW+2qgzIrJ6uIx4879w0vACOVHI/CbLMMXRo=;
        b=Y8jZ1eo35wgLXzpMuGPl6tYrqfaIhou9UkDIWiN5xU6m+ZIkUhTwt7v/lv2XqHJ5rI
         3cLJvG+wZNCcvUObwIt3MYk6iGAgHY0Ef0V285Wn6AWvEXtyQzHrjcocSpRAndwXKpWZ
         IOetuHBWC7q/KIpPOLJKN0OQa7IOXpCdvHIHY4usWDnJ6ma+SJFVdunEwQ7tCAL9ZImC
         yjQuhd76VsaCiBTRR1rwBKqEzMv3FecMoTHprSk4UPXMCt1aP75Eb8sRTyo2jDrphz26
         wzDLrUR8uENNq98dxkJtKRCC3wWQs2G07PMq7xKn5vtl3bsiNRr8y2KFxaOEoP0dzQE5
         GfMg==
X-Gm-Message-State: AOJu0YwAZAm8tXlqRa1h2AXaVxUrou0el7EgAc2tTGx02tIExfdcukLU
        2eBEeoGAuPwSSYb7KTNDVjxNA7VJpELV+IMgBRZvSg==
X-Google-Smtp-Source: AGHT+IFM1DQBrSHS34AAts5aYanidGqfz/tX0Oa17FPVYw29/Auo3UTWQyIfSaAUxXv61+6lo0xOuepp2oKP5ktS/YM=
X-Received: by 2002:a17:90b:4a01:b0:26d:2b1d:1982 with SMTP id
 kk1-20020a17090b4a0100b0026d2b1d1982mr3459827pjb.24.1692619066049; Mon, 21
 Aug 2023 04:57:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230816024831.682107-1-aaron.lu@intel.com> <20230816024831.682107-2-aaron.lu@intel.com>
 <CAKfTPtB6sGva9eZPo2RjW1ZuzUxmKcO-9wBBJ3PJuGT9WtqwsQ@mail.gmail.com> <20230821060618.GA72709@ziqianlu-dell>
In-Reply-To: <20230821060618.GA72709@ziqianlu-dell>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 21 Aug 2023 13:57:34 +0200
Message-ID: <CAKfTPtD4PiTbUXkvByYv3_48xDW4pJR0zWkYLcDd1cJSiCdOLg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] sched/fair: ratelimit update to tg->load_avg
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org
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

On Mon, 21 Aug 2023 at 08:06, Aaron Lu <aaron.lu@intel.com> wrote:
>
> On Thu, Aug 17, 2023 at 02:56:00PM +0200, Vincent Guittot wrote:
> > On Wed, 16 Aug 2023 at 04:48, Aaron Lu <aaron.lu@intel.com> wrote:
> > >
> > > When using sysbench to benchmark Postgres in a single docker instance
> > > with sysbench's nr_threads set to nr_cpu, it is observed there are ti=
mes
> > > update_cfs_group() and update_load_avg() shows noticeable overhead on
> > > a 2sockets/112core/224cpu Intel Sapphire Rapids(SPR):
> > >
> > >     13.75%    13.74%  [kernel.vmlinux]           [k] update_cfs_group
> > >     10.63%    10.04%  [kernel.vmlinux]           [k] update_load_avg
> > >
> > > Annotate shows the cycles are mostly spent on accessing tg->load_avg
> > > with update_load_avg() being the write side and update_cfs_group() be=
ing
> > > the read side. tg->load_avg is per task group and when different task=
s
> > > of the same taskgroup running on different CPUs frequently access
> > > tg->load_avg, it can be heavily contended.
> > >
> > > The frequent access to tg->load_avg is due to task migration on wakeu=
p
> > > path, e.g. when running postgres_sysbench on a 2sockets/112cores/224c=
pus
> > > Intel Sappire Rapids, during a 5s window, the wakeup number is 14mill=
ions
> > > and migration number is 11millions and with each migration, the task'=
s
> > > load will transfer from src cfs_rq to target cfs_rq and each change
> > > involves an update to tg->load_avg. Since the workload can trigger as=
 many
> > > wakeups and migrations, the access(both read and write) to tg->load_a=
vg
> > > can be unbound. As a result, the two mentioned functions showed notic=
eable
> > > overhead. With netperf/nr_client=3Dnr_cpu/UDP_RR, the problem is wors=
e:
> > > during a 5s window, wakeup number is 21millions and migration number =
is
> > > 14millions; update_cfs_group() costs ~25% and update_load_avg() costs=
 ~16%.
> > >
> > > Reduce the overhead by limiting updates to tg->load_avg to at most on=
ce
> > > per ms. After this change, the cost of accessing tg->load_avg is grea=
tly
> > > reduced and performance improved. Detailed test results below.
> > >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > > postgres_sysbench on SPR:
> > > 25%
> > > base:   42382=C4=8519.8%
> > > patch:  50174=C4=859.5%  (noise)
> > >
> > > 50%
> > > base:   67626=C4=851.3%
> > > patch:  67365=C4=853.1%  (noise)
> > >
> > > 75%
> > > base:   100216=C4=851.2%
> > > patch:  112470=C4=850.1% +12.2%
> > >
> > > 100%
> > > base:    93671=C4=850.4%
> > > patch:  113563=C4=850.2% +21.2%
> > >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > > hackbench on ICL:
> > > group=3D1
> > > base:    114912=C4=855.2%
> > > patch:   117857=C4=852.5%  (noise)
> > >
> > > group=3D4
> > > base:    359902=C4=851.6%
> > > patch:   361685=C4=852.7%  (noise)
> > >
> > > group=3D8
> > > base:    461070=C4=850.8%
> > > patch:   491713=C4=850.3% +6.6%
> > >
> > > group=3D16
> > > base:    309032=C4=855.0%
> > > patch:   378337=C4=851.3% +22.4%
> > >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > > hackbench on SPR:
> > > group=3D1
> > > base:    100768=C4=852.9%
> > > patch:   103134=C4=852.9%  (noise)
> > >
> > > group=3D4
> > > base:    413830=C4=8512.5%
> > > patch:   378660=C4=8516.6% (noise)
> > >
> > > group=3D8
> > > base:    436124=C4=850.6%
> > > patch:   490787=C4=853.2% +12.5%
> > >
> > > group=3D16
> > > base:    457730=C4=853.2%
> > > patch:   680452=C4=851.3% +48.8%
> > >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > > netperf/udp_rr on ICL
> > > 25%
> > > base:    114413=C4=850.1%
> > > patch:   115111=C4=850.0% +0.6%
> > >
> > > 50%
> > > base:    86803=C4=850.5%
> > > patch:   86611=C4=850.0%  (noise)
> > >
> > > 75%
> > > base:    35959=C4=855.3%
> > > patch:   49801=C4=850.6% +38.5%
> > >
> > > 100%
> > > base:    61951=C4=856.4%
> > > patch:   70224=C4=850.8% +13.4%
> > >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > > netperf/udp_rr on SPR
> > > 25%
> > > base:   104954=C4=851.3%
> > > patch:  107312=C4=852.8%  (noise)
> > >
> > > 50%
> > > base:    55394=C4=854.6%
> > > patch:   54940=C4=857.4%  (noise)
> > >
> > > 75%
> > > base:    13779=C4=853.1%
> > > patch:   36105=C4=851.1% +162%
> > >
> > > 100%
> > > base:     9703=C4=853.7%
> > > patch:   28011=C4=850.2% +189%
> > >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > netperf/tcp_stream on ICL (all in noise range)
> > > 25%
> > > base:    43092=C4=850.1%
> > > patch:   42891=C4=850.5%
> > >
> > > 50%
> > > base:    19278=C4=8514.9%
> > > patch:   22369=C4=857.2%
> > >
> > > 75%
> > > base:    16822=C4=853.0%
> > > patch:   17086=C4=852.3%
> > >
> > > 100%
> > > base:    18216=C4=850.6%
> > > patch:   18078=C4=852.9%
> > >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > netperf/tcp_stream on SPR (all in noise range)
> > > 25%
> > > base:    34491=C4=850.3%
> > > patch:   34886=C4=850.5%
> > >
> > > 50%
> > > base:    19278=C4=8514.9%
> > > patch:   22369=C4=857.2%
> > >
> > > 75%
> > > base:    16822=C4=853.0%
> > > patch:   17086=C4=852.3%
> > >
> > > 100%
> > > base:    18216=C4=850.6%
> > > patch:   18078=C4=852.9%
> > >
> > > Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> > > ---
> > >  kernel/sched/fair.c  | 13 ++++++++++++-
> > >  kernel/sched/sched.h |  1 +
> > >  2 files changed, 13 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 6e79de26a25d..ab055c72cc64 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -3664,7 +3664,8 @@ static inline bool cfs_rq_is_decayed(struct cfs=
_rq *cfs_rq)
> > >   */
> > >  static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
> > >  {
> > > -       long delta =3D cfs_rq->avg.load_avg - cfs_rq->tg_load_avg_con=
trib;
> > > +       long delta;
> > > +       u64 now;
> > >
> > >         /*
> > >          * No need to update load_avg for root_task_group as it is no=
t used.
> > > @@ -3672,9 +3673,19 @@ static inline void update_tg_load_avg(struct c=
fs_rq *cfs_rq)
> > >         if (cfs_rq->tg =3D=3D &root_task_group)
> > >                 return;
> > >
> > > +       /*
> > > +        * For migration heavy workload, access to tg->load_avg can b=
e
> > > +        * unbound. Limit the update rate to at most once per ms.
> > > +        */
> > > +       now =3D sched_clock_cpu(cpu_of(rq_of(cfs_rq)));
> > > +       if (now - cfs_rq->last_update_tg_load_avg < NSEC_PER_MSEC)
> > > +               return;
> > > +
> > > +       delta =3D cfs_rq->avg.load_avg - cfs_rq->tg_load_avg_contrib;
> > >         if (abs(delta) > cfs_rq->tg_load_avg_contrib / 64) {
> > >                 atomic_long_add(delta, &cfs_rq->tg->load_avg);
> > >                 cfs_rq->tg_load_avg_contrib =3D cfs_rq->avg.load_avg;
> > > +               cfs_rq->last_update_tg_load_avg =3D now;
> > >         }
> > >  }
> > >
> > > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > > index 19af1766df2d..228a298bf3b5 100644
> > > --- a/kernel/sched/sched.h
> > > +++ b/kernel/sched/sched.h
> > > @@ -594,6 +594,7 @@ struct cfs_rq {
> > >
> > >  #ifdef CONFIG_FAIR_GROUP_SCHED
> > >         unsigned long           tg_load_avg_contrib;
> > > +       u64                     last_update_tg_load_avg;
> >
> > Moving last_update_tg_load_avg before tg_load_avg_contrib should
> > minimize the padding on 32bits arch as long is only 4 Bytes
>
> Got it. That would be:
>
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 6a8b7b9ed089..52ee7027def9 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -593,6 +593,7 @@ struct cfs_rq {
>         } removed;
>
>  #ifdef CONFIG_FAIR_GROUP_SCHED
> +       u64                     last_update_tg_load_avg;
>         unsigned long           tg_load_avg_contrib;
>         long                    propagate;
>         long                    prop_runnable_sum;
> --
> 2.41.0
>
> >
> > Apart from this, looks good to me
>
> Thanks a lot for your review!
> Can I add your reviewed-by in my next update with the above change?

Yes with the above
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

>
> Regards,
> Aaron
>
> > >         long                    propagate;
> > >         long                    prop_runnable_sum;
> > >
> > > --
> > > 2.41.0
> > >
