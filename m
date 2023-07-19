Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B1F759133
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 11:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjGSJJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 05:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjGSJJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:09:39 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB3C1735
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 02:09:37 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51e29ede885so9405689a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 02:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689757775; x=1690362575;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=05lEZ3OPdoMN+4RQpdLeXNL97o7PTYxLw/XeUp1lOT8=;
        b=ldX6bAlyQQVHhHW+bhkeV1l1RvpWt3O50fg568da5WwOCZt1FMiMfzCFWQwR5R3vwt
         M4nwuUj+hZTMhkEQoRJV34EHw+KCLexrjSWp2e4M46oKG075qV5t3CEjDVKqnC5ssKJh
         Ts3lgkFrdX7fu3fPVvqxbTDoV0FhsU36/mybvfCMmudTtILzzvjDSh4MoTLdNGNPxH3E
         hssxjsahDlu1wYdThKcL+8EghLJDuTqfGtWht9ZTBGfCWo02qJZ8JJRc7XVqNnlvfbX8
         GRskh573cRf16BcBTXhjO3JXwmvFqpugEidU9Qgm3H8GMe8tLltDWX6aN9vo1a7pzA5r
         RZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689757775; x=1690362575;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=05lEZ3OPdoMN+4RQpdLeXNL97o7PTYxLw/XeUp1lOT8=;
        b=lgg4EaOGFZ4TZXuIu1T5kFRWO1mCpPvAf9R8P9uTcPYDtP5XbjY2zq3cousExq3/LT
         kJpWJNREXafbqspJR5hjTntYBuYvAhTXarZAGg/8lSGTXtNo5UiOKrTxvA6kjsGAOaPG
         EZF09oAfREgGDiUzmr00fEr1a/U5US/sDpJjAGShGo0I+lMQrMZ+MwvJ09ACybS8A6lc
         P+zGpJft8MHm1W4jqTC9E9tFZu1toSsNhyHYWnAkB2Au00V/9BqmitPlfqIkv4SNClfZ
         nXSHKUNZ1a98Sewo5fqzA057ksoVD0QyDQnVVRWEvWVvUeCmp75iSEIw0AL6W8QTbFB1
         wKOw==
X-Gm-Message-State: ABy/qLYk+kZ7pVXBfShJBCXjjWsvlsSCFplHxpaRzNSSjF+qvPDmdKrE
        WlNYBKRvgDaghmLeRkJka5jzbxe3XV46DeBKAII7Fg==
X-Google-Smtp-Source: APBJJlG/CXh8TL8Gic5MO44ov11lomNcZxcWoHWMpWdTCZo2MATzz1wlgmrc3ud/gk3qJIkOvf7IuEJAc9cFPmFbXok=
X-Received: by 2002:a50:ee0e:0:b0:51e:5ec8:d2f7 with SMTP id
 g14-20020a50ee0e000000b0051e5ec8d2f7mr1734992eds.30.1689757775436; Wed, 19
 Jul 2023 02:09:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230718134120.81199-1-aaron.lu@intel.com> <20230718134120.81199-4-aaron.lu@intel.com>
 <CAKfTPtAu33AN6=X82T=yOgm40S8OXi+sPcF0QyD-bYRPV=xPEg@mail.gmail.com> <20230719051826.GB84059@ziqianlu-dell>
In-Reply-To: <20230719051826.GB84059@ziqianlu-dell>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 19 Jul 2023 11:09:24 +0200
Message-ID: <CAKfTPtANpC5XV8_02ZhRwoUyzK_GjEiqYiG7rZWu6WLaeZ9RJQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] sched/fair: delay update_tg_load_avg() for
 cfs_rq's removed load
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
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jul 2023 at 07:18, Aaron Lu <aaron.lu@intel.com> wrote:
>
> On Tue, Jul 18, 2023 at 06:01:51PM +0200, Vincent Guittot wrote:
> > On Tue, 18 Jul 2023 at 15:41, Aaron Lu <aaron.lu@intel.com> wrote:
> > >
> > > When a workload involves many wake time task migrations, tg->load_avg
> > > can be heavily contended among CPUs because every migration involves
> > > removing the task's load from its src cfs_rq and attach that load to
> > > its new cfs_rq. Both the remove and attach requires an update to
> > > tg->load_avg as well as propagating the change up the hierarchy.
> > >
> > > E.g. when running postgres_sysbench on a 2sockets/112cores/224cpus Intel
> > > Sappire Rapids, during a 5s window, the wakeup number is 14millions and
> > > migration number is 11millions. Since the workload can trigger many
> > > wakeups and migrations, the access(both read and write) to tg->load_avg
> > > can be unbound. For the above said workload, the profile shows
> > > update_cfs_group() costs ~13% and update_load_avg() costs ~10%. With
> > > netperf/nr_client=nr_cpu/UDP_RR, the wakeup number is 21millions and
> > > migration number is 14millions; update_cfs_group() costs ~25% and
> > > update_load_avg() costs ~16%.
> > >
> > > This patch is an attempt to reduce the cost of accessing tg->load_avg.
> >
> > here you mention tg->load_avg which is updated with update_tg_load_avg()
> >
> > but your patch below modifies the local update of cfs's util_avg,
> > runnable_avg  and load_avg which need to be maintained up to date
>
> Yes, since it delayed propagating the removed load, the upper cfs_rqs'
> *_avg could be updated later than current code.
>
> > You should be better to delay or rate limit the call to
> > update_tg_load_avg() or calc_group_shares()/update_cfs_group() which
> > access tg->load_avg and are the culprit instead of modifying other
> > place.
>
> Thanks for the suggestion and I think it makes perfect sense.
>
> I tried below to rate limit the update to tg->load_avg at most once per
> ms in update_tg_load_avg():
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a80a73909dc2..e48fd0e6982d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3665,6 +3665,7 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
>  static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
>  {
>         long delta = cfs_rq->avg.load_avg - cfs_rq->tg_load_avg_contrib;
> +       u64 now = cfs_rq_clock_pelt(cfs_rq);
>
>         /*
>          * No need to update load_avg for root_task_group as it is not used.
> @@ -3672,9 +3673,11 @@ static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
>         if (cfs_rq->tg == &root_task_group)
>                 return;
>
> -       if (abs(delta) > cfs_rq->tg_load_avg_contrib / 64) {
> +       if ((now - cfs_rq->last_update_tg_load_avg > 1000000) &&
> +           abs(delta) > cfs_rq->tg_load_avg_contrib / 64) {
>                 atomic_long_add(delta, &cfs_rq->tg->load_avg);
>                 cfs_rq->tg_load_avg_contrib = cfs_rq->avg.load_avg;
> +               cfs_rq->last_update_tg_load_avg = now;
>         }
>  }
>
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 14dfaafb3a8f..b5201d44d820 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -594,6 +594,7 @@ struct cfs_rq {
>
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>         unsigned long           tg_load_avg_contrib;
> +       u64                     last_update_tg_load_avg;
>         long                    propagate;
>         long                    prop_runnable_sum;
>
> From some quick tests using postgres_sysbench and netperf/UDP_RR on SPR,
> this alone already delivers good results. For postgres_sysbench, the two
> functions cost dropped to 1%-2% each; and for netperf/UDP_RR, the two
> functions cost dropped to ~2% and ~4%. Togerther with some more rate
> limiting on the read side, I think the end result will be better. Does
> the above look reasonable to you?

Yes, that seems a better way to limit write access

>
> Alternatively, I can remove some callsites of update_tg_load_avg() like
> you suggested below and only call update_tg_load_avg() when cfs_rq is
> decayed(really just decayed, not when it detected it has removed load
> pending or load propagated from its children). This way it would give us
> similar result as above(roughly once per ms).
>
> >
> > Have you tried to remove update_cfs_group() from enqueue/dequeue and
> > only let the tick update the share periodically ?
>
> patch4 kind of did that :-)

That's what I have noticed when reading patch 4 :-)

>
> >
> > Have you tried to make update_tg_load_avg() return early ? the change
> > of cfs' load_avg is written in the tg->load_avg only when the change
> > is bigger than 1.5%. maybe increase it to 6% ?
>
> Yes, increase the delta is also a good way to limit the update to
> tg->load_avg. Will try that too.
>
> >
> > Or like for update_cfs_group, remove it from attach/detach entity and
> > let the periodic update to propagate the change
> >
> > But please don't touch local update of *_avg
>
> OK I see.
>
> Thanks again for the comments, they are very helpful.
