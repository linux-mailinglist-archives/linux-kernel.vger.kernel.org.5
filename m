Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6DC810C54
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 09:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjLMIYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 03:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjLMIYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 03:24:42 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CCB91
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 00:24:48 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3b9e7f4a0d7so4337958b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 00:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702455888; x=1703060688; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6v1Ba8YaX+pMQZF3in4IJSoafdVQFQX6Sy/KwMfRTv8=;
        b=xemkWMutT0QK9U0bFNB+eksWPDcKo1TAUmpdsFCLMf+hUhzI0fL6+Pdiio6fhB7fvb
         W1wvl5ILf/x2IeP73f85+updOI8QFudUgy6Evv4yNrNLvW39UHZCJqmMjLrFphG/A5hD
         I0dyHSmTU4dia02DWuLJIyhD07iiEiA+9A1IEuLh0ZYa0TxhdKJUqbQUDca2eD/y7XtW
         K/Ho+pfJetquSQgHQKNrk9l8NLCxuOcXtlRuFcmkfdWx0PXGPglm7vwUGuPvY1onPyPD
         L/m1ueHAG7BDL/iNtbUt0FrUYalIMbjQcmFSnINTAFZDLMuhFjPymPSEOq7uzxvpJ4us
         ubYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702455888; x=1703060688;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6v1Ba8YaX+pMQZF3in4IJSoafdVQFQX6Sy/KwMfRTv8=;
        b=qBrZOvE9NS1OlGpuGTC2gTEkqog6ajyrxcgkPppfAXof/12v8uHkhtTFrlTh2gBpys
         YAXoX/35DxtQneRJurjc0IyphIqfszsFCA/oLnyjcSOd+8FfqCGGGCOa+AjTBK1eYpGK
         BV/CLmWc46JU2lwHwW3xRXmpPq+n6FgAEO+uE0Pm5oB5BClH4yVTQpmsJ0SPUZysAUfe
         Z+m6+9P4JNvut92ZC+uZ14K1D1rdWq3O2MorgKr0TBawhnkO8H0BREwrM1vzOdYGjxS9
         bENq+WFsyCleESoKjUng11XblojplXUzM9lQ793OM6mfTBiVoPrGCmZ6kdeWQPrCcp18
         CY6A==
X-Gm-Message-State: AOJu0YzyvFY9lRbLeOKbS0IAsoQO7XlbSEjyEidwbHUExfJ1A9AY15Me
        +z/WMhnwCocEtHtqzS3F427YSSMDCJtqTj88IimB7Q==
X-Google-Smtp-Source: AGHT+IEluTb+7yq5r/J4hwbSv13OWjRXXWAyn4x0A7dGDmZ/ff4CRrZ0WvlXpfTfrxh+s9RqrmROHZ/NVabOkut21iw=
X-Received: by 2002:a05:6808:1983:b0:3b9:da2c:e5a9 with SMTP id
 bj3-20020a056808198300b003b9da2ce5a9mr9598920oib.62.1702455887866; Wed, 13
 Dec 2023 00:24:47 -0800 (PST)
MIME-Version: 1.0
References: <202312131510+0800-wangjinchao@xfusion.com> <d0dc8c52-e2ab-4d49-b9fc-23e15ab101a0@bytedance.com>
In-Reply-To: <d0dc8c52-e2ab-4d49-b9fc-23e15ab101a0@bytedance.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 13 Dec 2023 09:24:36 +0100
Message-ID: <CAKfTPtDVQK0DryE9XCgcdXk1Az4NjDsf+Cesf1Fq8=qV-mQVzQ@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: merge same code in enqueue_task_fair
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     WangJinchao <wangjinchao@xfusion.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, stone.xulei@xfusion.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2023 at 09:19, Abel Wu <wuyun.abel@bytedance.com> wrote:
>
> Hi Jinchao,
>
> On 12/13/23 3:12 PM, WangJinchao Wrote:
> > The code below is duplicated in two for loops and need to be
> >     consolidated
>
> It doesn't need to, but it can actually bring some benefit from
> the point of view of text size, especially in warehouse-scale
> computers where icache is extremely contended.
>
> add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-56 (-56)
> Function                                     old     new   delta
> enqueue_task_fair                            936     880     -56
> Total: Before=64899, After=64843, chg -0.09%
>
> >
> > Signed-off-by: WangJinchao <wangjinchao@xfusion.com>
> > ---
> >   kernel/sched/fair.c | 31 ++++++++-----------------------
> >   1 file changed, 8 insertions(+), 23 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index d7a3c63a2171..e1373bfd4f2e 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6681,30 +6681,15 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >               cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
> >
> >       for_each_sched_entity(se) {
> > -             if (se->on_rq)
> > -                     break;
> >               cfs_rq = cfs_rq_of(se);
> > -             enqueue_entity(cfs_rq, se, flags);
> > -
> > -             cfs_rq->h_nr_running++;
> > -             cfs_rq->idle_h_nr_running += idle_h_nr_running;
> > -
> > -             if (cfs_rq_is_idle(cfs_rq))
> > -                     idle_h_nr_running = 1;
> > -
> > -             /* end evaluation on encountering a throttled cfs_rq */
> > -             if (cfs_rq_throttled(cfs_rq))
> > -                     goto enqueue_throttle;
> > -
> > -             flags = ENQUEUE_WAKEUP;
> > -     }
> > -
> > -     for_each_sched_entity(se) {
> > -             cfs_rq = cfs_rq_of(se);
> > -
> > -             update_load_avg(cfs_rq, se, UPDATE_TG);
> > -             se_update_runnable(se);
> > -             update_cfs_group(se);
> > +             if (se->on_rq) {
> > +                     update_load_avg(cfs_rq, se, UPDATE_TG);
> > +                     se_update_runnable(se);
> > +                     update_cfs_group(se);
> > +             } else {
> > +                     enqueue_entity(cfs_rq, se, flags);
> > +                     flags = ENQUEUE_WAKEUP;
> > +             }
> >
> >               cfs_rq->h_nr_running++;
> >               cfs_rq->idle_h_nr_running += idle_h_nr_running;
>
> I have no strong opinon about this 'cleanup', but the same pattern
> can also be found in dequeue_task_fair() and I think it would be
> better get them synchronized.

I agree, I don't see any benefit from this change

>
> Thanks,
>         Abel
