Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD28759147
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 11:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjGSJMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 05:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjGSJMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:12:49 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96BD10B
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 02:12:48 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fcd615d7d6so10303385e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 02:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689757967; x=1690362767;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wX2bUVJUdm0gNSGeMKdGK2i21/1BBolm7LfONnjZla0=;
        b=QZC34lzd5JM3r8Rp8FHRSWEinB1TOQAbRi/EEDuBD8C9dvO3NjyWTxc/hSVkBxlpYX
         0f0w6kOAVj3JVulIbTx+E+KWoZtMVHazeuvUp7eGB3mpLg789/3chnPYX2012jpiDHTH
         ZyJ2NqGK8EbnLfsBj67W2qtWJOU+M0aBftkIJCe/GpJFIj8Q6HMU1EwBXGyO9jJ3VdMo
         oRoS1X6g2uYAEamqMb/8nutQY1cyT4ZOI6N9aDDvxX3yYLCpu4Bw1hRKF1RUjrHFIej/
         fM0xQ8y6jDqOJoEtZECxem13N92XdY95Nu04d8vWtw9lAluwe+qE8MrZmxBRjsYR0TB7
         rbPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689757967; x=1690362767;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wX2bUVJUdm0gNSGeMKdGK2i21/1BBolm7LfONnjZla0=;
        b=Ut9NO9QTpT73ZyZH/RfWjTj4wvKMMfxDoZWdZRRNptWyVyv1Be2zmVSCve7IUeoDCr
         5FdZj/+TDsd96vA73951BpQlzuyGTcbWJxwtL4wNLCo1/Wkio9m2cRriTaijXq/YTdpF
         XQvsQV0YWVdtlCCJbGrG38DayV8JqzWxWQP2NTWfyWsvuN4N8rQA93jbFIBLMDSJ9qRn
         paTDIeZHD8gSCtYPThgpOU4M32rALV773vJ0lrIAcFJn8jSFs0dabVOgbq0IhH4AyFDd
         vjXuxRBXk7DrXCInQx4W5lXuZPVP64rTyA6r/PgoO4wqILKCLOsCajYHJBVBxLCc65g1
         fAIw==
X-Gm-Message-State: ABy/qLa74YzrzI7UmRO8qeUAcvztmfFhXuYuJUeQvp1s+Jx6bzFoMnvj
        8WBFR7CCdVReYdzN55VLOExXEVJcj7CIPnL9L3X0TQ==
X-Google-Smtp-Source: APBJJlEnVtXZT4M8E7W4vlwbq0bQ+X9mtp21HXsF24aTAaHzVHsIE84fJH7dWsRDCnaVzB28tDHY+hL/kdPbV2+gli8=
X-Received: by 2002:ac2:5df5:0:b0:4fd:d92e:31ca with SMTP id
 z21-20020ac25df5000000b004fdd92e31camr215640lfq.36.1689757966919; Wed, 19 Jul
 2023 02:12:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230718134120.81199-1-aaron.lu@intel.com> <20230718134120.81199-4-aaron.lu@intel.com>
 <CAKfTPtAu33AN6=X82T=yOgm40S8OXi+sPcF0QyD-bYRPV=xPEg@mail.gmail.com>
 <20230719051826.GB84059@ziqianlu-dell> <20230719081102.GB90441@ziqianlu-dell>
In-Reply-To: <20230719081102.GB90441@ziqianlu-dell>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 19 Jul 2023 11:12:36 +0200
Message-ID: <CAKfTPtAOC9OXjPHLRU_g1OQKaYUKcDbnZkJ=ZJpAtUucjxAOeA@mail.gmail.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jul 2023 at 10:11, Aaron Lu <aaron.lu@intel.com> wrote:
>
> On Wed, Jul 19, 2023 at 01:18:26PM +0800, Aaron Lu wrote:
> > On Tue, Jul 18, 2023 at 06:01:51PM +0200, Vincent Guittot wrote:
> > > Have you tried to remove update_cfs_group() from enqueue/dequeue and
> > > only let the tick update the share periodically ?
> >
> > patch4 kind of did that :-)
> >
>
> More about this.
>
> If I remove update_cfs_group() in dequeue_task_fair() on top of patch4
> like this:
>
> From 43d5c12f0b2180c99149e663a71c610e31023d90 Mon Sep 17 00:00:00 2001
> From: Aaron Lu <aaron.lu@intel.com>
> Date: Wed, 19 Jul 2023 14:51:07 +0800
> Subject: [PATCH 1/2] sched/fair: completely remove update_cfs_group() in
>  dequeue path
>
> ---
>  kernel/sched/fair.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 2adb6a6abbce..a21ab72819ce 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6434,7 +6434,6 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>
>                 update_load_avg(cfs_rq, se, UPDATE_TG);
>                 se_update_runnable(se);
> -               update_cfs_group(se);
>
>                 cfs_rq->h_nr_running--;
>                 cfs_rq->idle_h_nr_running -= idle_h_nr_running;
> --
> 2.40.1
>
> Than P95 latency of the schbench workload I described in patch4's
> changelog will increase to > 1ms(base and patch4's P95 < 100us):
>
> Latency percentiles (usec) runtime 300 (s) (18504 total samples)
>         50.0th: 20 (9537 samples)
>         75.0th: 25 (4869 samples)
>         90.0th: 29 (2264 samples)
>         95.0th: 2564 (909 samples)
>         *99.0th: 20768 (740 samples)
>         99.5th: 23520 (93 samples)
>         99.9th: 31520 (74 samples)
>         min=6, max=40072
>
> If I further remove update_cfs_group() completely in enqueue path on top
> of the last change:
>
> From 4e4cb31590ca2e4080ece9cfa9dfaaf26501c60d Mon Sep 17 00:00:00 2001
> From: Aaron Lu <aaron.lu@intel.com>
> Date: Wed, 19 Jul 2023 15:36:24 +0800
> Subject: [PATCH 2/2] sched/fair: completely remove update_cfs_group() from
>  enqueue path
>
> ---
>  kernel/sched/fair.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a21ab72819ce..8fc325112282 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4847,8 +4847,6 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>          */
>         update_load_avg(cfs_rq, se, UPDATE_TG | DO_ATTACH);
>         se_update_runnable(se);
> -       if (cfs_rq->nr_running > 0)
> -               update_cfs_group(se);
>         account_entity_enqueue(cfs_rq, se);
>
>         if (flags & ENQUEUE_WAKEUP)
> @@ -6344,7 +6342,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>
>                 update_load_avg(cfs_rq, se, UPDATE_TG);
>                 se_update_runnable(se);
> -               update_cfs_group(se);
>
>                 cfs_rq->h_nr_running++;
>                 cfs_rq->idle_h_nr_running += idle_h_nr_running;
> --
> 2.40.1
>
> Then P50's latency will bump to ~4ms from ~20us:
> Latency percentiles (usec) runtime 300 (s) (17940 total samples)
>         50.0th: 3996 (12092 samples)
>         75.0th: 4004 (4919 samples)
>         90.0th: 4004 (0 samples)
>         95.0th: 4012 (353 samples)
>         *99.0th: 20000 (487 samples)
>         99.5th: 20000 (0 samples)
>         99.9th: 31136 (72 samples)
>         min=7, max=37402
> real    5m36.633s
> user    47m33.947s
> sys     4m47.097s
>
> So for the read side, maybe just keep what patch4 does?

yes, skipping update_cfs_group() at enqueue bypass the opportunity to
increase the share and get more running time for the group until the
update really happen

>
> Thanks,
> Aaron
