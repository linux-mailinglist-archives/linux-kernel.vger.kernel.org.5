Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5632775B27D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbjGTPZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbjGTPZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:25:16 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF99226B3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:25:07 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fb863edcb6so1458625e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689866706; x=1690471506;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j1KRZ58fZO4K0PGPlKCEU4ew+SC12d01sHEHlN/ft4E=;
        b=xgZCobKB5fxteUZockwPQu3aYRlt8w2nv4R7iZLAy4P/QijtNVh3p4TKZq2ta3mxZe
         MdDJC5cOhzDme/nju0GLqd3ylcbKnHC8O5Z8OBSNcz6/2GVJfiRaPHERjeXthVeueTmO
         Bb+/60zoKaQZlZDCrVjC6JEGyhBLeHTE4mhrvfG8rhDL9NTsnNKI3OJnGOY8tMq1ck+5
         lClf3leNoVD5Ylo4h0216diAxbTfWdZknoZrYZiWX1UzIiHn9X0Z0lciI7qXMGmIU5X6
         0/N8YbKoOJRpxWGA8xpgG1NykyKGWugTvwQ4GE2v0XZHfr0bHhRgUZ69+89uwK0i8LfR
         jA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689866706; x=1690471506;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j1KRZ58fZO4K0PGPlKCEU4ew+SC12d01sHEHlN/ft4E=;
        b=BbWBfhHC8bgzl3IIwI+vUx3Oeb9yX+v3YHA9gqmbg86y4d5WbBCPQikOWPsOVQHQPi
         Rzac0x7GxOj0RaiZnr/8NTNL+iGhqIo5GHyqeudZhdKNdMggGAV6Dt9lR69RgQzOM6HF
         ip1ukCBUnvozuZmGvliM8CRAbUVwiwx/2EewEzlv8VSevuEfLXyu1lNKy7H486E+55wm
         CupA6tV5KLK6EdEGkWlVIonGMT1fxH0oCiYErhqt1VOx19+ILx3Rx+OCLsPc9rJdtLuI
         CA4wrdMBjpqb00QbCuiulIvYtnY0DpwM+z4na075tKI23VcmYf2wVq0GlB4VoIXeSnd3
         NANw==
X-Gm-Message-State: ABy/qLbhyKxhQRMGFVMyzPlSxWUIEUTTe4H2tmM2nLMawrUfElI9/Px4
        NAYPJQz5wasZn/cKw95GNfFoZlDBpAwqGYVX3hv03w==
X-Google-Smtp-Source: APBJJlHo4atp1fdGOc9UBiWSKWaMfFGnjSmU+A3lfkgtDqu7BUVAmnJxpHBSz3bGUC5NJIJGpt79XuWP2mgXOC1RCBo=
X-Received: by 2002:ac2:5a59:0:b0:4f8:77f1:299a with SMTP id
 r25-20020ac25a59000000b004f877f1299amr2568972lfn.42.1689866705738; Thu, 20
 Jul 2023 08:25:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230718134120.81199-1-aaron.lu@intel.com> <20230718134120.81199-4-aaron.lu@intel.com>
 <CAKfTPtAu33AN6=X82T=yOgm40S8OXi+sPcF0QyD-bYRPV=xPEg@mail.gmail.com>
 <20230719051826.GB84059@ziqianlu-dell> <20230719080105.GA90441@ziqianlu-dell>
 <CAKfTPtCnvOehfrz1OSW+rmkKW+28bdGw8fU+AvVrZTxkHibL_g@mail.gmail.com>
 <20230719132914.GA91858@ziqianlu-dell> <CAKfTPtAqpAo8Y9BdWZ-fmnyYgA8PEtFbObqWJxc-hs2Ktqkt3Q@mail.gmail.com>
 <20230720144233.GA185317@ziqianlu-dell> <CAKfTPtANqtEQjv2UThb5s0TPCS2adhC_14Gfv5ayAOva9Mib8g@mail.gmail.com>
 <96efae1a-37f6-c8da-5cdb-07b460307d6b@arm.com>
In-Reply-To: <96efae1a-37f6-c8da-5cdb-07b460307d6b@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 20 Jul 2023 17:24:54 +0200
Message-ID: <CAKfTPtByYm1rd0DeC-DwhbVckZ61Z2=B-ztHXvLc_B5C4ry-xw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] sched/fair: delay update_tg_load_avg() for
 cfs_rq's removed load
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Aaron Lu <aaron.lu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jul 2023 at 17:22, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 20/07/2023 17:02, Vincent Guittot wrote:
> > On Thu, 20 Jul 2023 at 16:42, Aaron Lu <aaron.lu@intel.com> wrote:
> >>
> >> On Thu, Jul 20, 2023 at 03:10:30PM +0200, Vincent Guittot wrote:
> >>> On Wed, 19 Jul 2023 at 15:29, Aaron Lu <aaron.lu@intel.com> wrote:
> >>>>
> >>>> On Wed, Jul 19, 2023 at 11:47:06AM +0200, Vincent Guittot wrote:
> >>>>> On Wed, 19 Jul 2023 at 10:01, Aaron Lu <aaron.lu@intel.com> wrote:
> >>>>>>
> >>>>>> On Wed, Jul 19, 2023 at 01:18:26PM +0800, Aaron Lu wrote:
>
> [...]
>
> > What was wrong with your proposal to limit the update inside
> > update_tg_load_avg()  ? except maybe s/1000000/NSEC_PER_MSEC/ and
> > computing delta after testing the time since last update
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index a80a73909dc2..e48fd0e6982d 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -3665,6 +3665,7 @@ static inline bool cfs_rq_is_decayed(struct
> > cfs_rq *cfs_rq)
> >  static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
> >  {
> >         long delta = cfs_rq->avg.load_avg - cfs_rq->tg_load_avg_contrib;
> > +       u64 now = cfs_rq_clock_pelt(cfs_rq);
>
> Could this be `u64 now = sched_clock_cpu()` like in
> migrate_se_pelt_lag() or newidle_balance() to avoid the time morphing
> due to PELT's frequency and uArch invariance?

yes that's a good point. I missed this

> >
> >         /*
> >          * No need to update load_avg for root_task_group as it is not used.
>
> [...]
>
