Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85407846EC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 18:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237683AbjHVQUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 12:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237655AbjHVQUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 12:20:08 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF69CDD
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 09:20:06 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fef56e85edso89225e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 09:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692721205; x=1693326005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1e96jpiDeNzLHHJDMqox7QxGSMIFVIftRTXtTIbNUNE=;
        b=iqC7BsN0zB1xlA9Bma2CYi8UBvIGG9VAoRAuTyThinMkshwHYaMCzwM04OlpBLPa8H
         VyqYm4jCtMKlI8MnJ2teplPhU2PTkMWrjzkEyHzIEEUBMPy2elcbcQcBKqLgt0o5rrMW
         h5V3yNmS8XDEtNw7d7oRqw8LrH+45nJG8xNUQoiiHtmN6fZDjUNVJA+Qtr2TpT/BGsXv
         fXiCbSYyu11Jc799UvluZISk3q36FzO+HWQIyXk0OjTGyKcjsS9nAMfpxZShuoYGTpkd
         bGNNvMqL/2/Wzrjpf48JoV1R1UcD6BeC9NrAr5aDqM+wxIwyYHgiiMVzOVOV7viO7er0
         JvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692721205; x=1693326005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1e96jpiDeNzLHHJDMqox7QxGSMIFVIftRTXtTIbNUNE=;
        b=fbnU+XpFwpC9uopFJ18zxKTp6nF91tjml7WAI1CeNCWtrTrkjc0+sexlUi5dGT28DZ
         DlrUdE0jquaLX8YiGewH0/9MArLpcJ2AhSdSrrlJfdfsMWRFYvEz+zLSlWOytf4mZaZy
         gLO73mm38IFDrKvdmncZ9hvcgjkb0MCkiByFDEh5ACxY6yDwtVWX1qu/yfnVVCFF6jSG
         zQUXUvu18jwCSy6Idl1WbIZjHob15dZtpgg6AnPQ7RVv3sPwesYpkjWwxCweSrT1ngiW
         LPLoshm5nyckyfkNUFeSpEQhv5anIEBywJbqloo+sa0zGA7QOOYmds8nZCBzsHtWAo8r
         DW0w==
X-Gm-Message-State: AOJu0YwubazkqQU+d45m9fW/C06Dl0bAibkM9c/7YGAITpCu3jPEQuhE
        3ttGtLloN2jhH38KpDuxXJ2uhPuVx6ZR/nyW8xvV
X-Google-Smtp-Source: AGHT+IF/lRs9kwuLguGEcpYfHmTHbSURcAZIzs5g+bBTTa1QE7mBsM32z4SkHwS5JrGdwfMZZ6LFUqhInu4f25uq+kk=
X-Received: by 2002:a05:600c:5123:b0:3fe:cd3a:ef92 with SMTP id
 o35-20020a05600c512300b003fecd3aef92mr132119wms.6.1692721204639; Tue, 22 Aug
 2023 09:20:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230819060915.3001568-1-jstultz@google.com> <20230819060915.3001568-17-jstultz@google.com>
 <f6da7769-dcda-f8f9-934d-b581d3e77618@arm.com>
In-Reply-To: <f6da7769-dcda-f8f9-934d-b581d3e77618@arm.com>
From:   John Stultz <jstultz@google.com>
Date:   Tue, 22 Aug 2023 09:19:53 -0700
Message-ID: <CANDhNCqtG9fWX7cZ4ZpCkPOKJDOrRBELnAxiuLn+WK1fUpV=1g@mail.gmail.com>
Subject: Re: [PATCH v5 16/19] sched: Fix proxy/current (push,pull)ability
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        Youssef Esmat <youssefesmat@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, kernel-team@android.com,
        "Connor O'Brien" <connoro@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 8:20=E2=80=AFAM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 19/08/2023 08:08, John Stultz wrote:
> > From: Valentin Schneider <valentin.schneider@arm.com>
>
> [...]
>
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index bee7082b294f..e8065fc5c894 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -6656,6 +6656,21 @@ proxy(struct rq *rq, struct task_struct *next, s=
truct rq_flags *rf)
> >       raw_spin_unlock(&mutex->wait_lock);
> >       return ret;
> >  }
> > +
> > +static inline void proxy_tag_curr(struct rq *rq, struct task_struct *n=
ext)
> > +{
> > +     /*
> > +      * pick_next_task() calls set_next_task() on the selected task
> > +      * at some point, which ensures it is not push/pullable.
> > +      * However, the selected task *and* the ,mutex owner form an
> > +      * atomic pair wrt push/pull.
> > +      *
> > +      * Make sure owner is not pushable. Unfortunately we can only
> > +      * deal with that by means of a dequeue/enqueue cycle. :-/
> > +      */
> > +     dequeue_task(rq, next, DEQUEUE_NOCLOCK | DEQUEUE_SAVE);
> > +     enqueue_task(rq, next, ENQUEUE_NOCLOCK | ENQUEUE_RESTORE);
> > +}
> >  #else /* PROXY_EXEC */
> >  static struct task_struct *
> >  proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
> > @@ -6663,6 +6678,8 @@ proxy(struct rq *rq, struct task_struct *next, st=
ruct rq_flags *rf)
> >       BUG(); // This should never be called in the !PROXY case
> >       return next;
> >  }
> > +
> > +static inline void proxy_tag_curr(struct rq *rq, struct task_struct *n=
ext) { }
> >  #endif /* PROXY_EXEC */
> >
> >  /*
> > @@ -6711,6 +6728,7 @@ static void __sched notrace __schedule(unsigned i=
nt sched_mode)
> >       unsigned long prev_state;
> >       struct rq_flags rf;
> >       struct rq *rq;
> > +     bool proxied;
> >       int cpu;
> >
> >       cpu =3D smp_processor_id();
> > @@ -6760,6 +6778,7 @@ static void __sched notrace __schedule(unsigned i=
nt sched_mode)
> >               switch_count =3D &prev->nvcsw;
> >       }
> >
> > +     proxied =3D (rq_selected(rq) !=3D prev);
>
> Looks like proxied isn't used here. (*)

Ah. Looks like I should have split that off into a later change.
Thanks for pointing that out.

> >  pick_again:
> >       next =3D pick_next_task(rq, rq_selected(rq), &rf);
> >       rq_set_selected(rq, next);
> > @@ -6786,6 +6805,10 @@ static void __sched notrace __schedule(unsigned =
int sched_mode)
> >                * changes to task_struct made by pick_next_task().
> >                */
> >               RCU_INIT_POINTER(rq->curr, next);
> > +
> > +             if (unlikely(!task_current_selected(rq, next)))
> > +                     proxy_tag_curr(rq, next);
> > +
> >               /*
> >                * The membarrier system call requires each architecture
> >                * to have a full memory barrier after updating
> > @@ -6810,6 +6833,10 @@ static void __sched notrace __schedule(unsigned =
int sched_mode)
> >               /* Also unlocks the rq: */
> >               rq =3D context_switch(rq, prev, next, &rf);
> >       } else {
> > +             /* In case next was already curr but just got blocked_don=
or*/
> > +             if (unlikely(!task_current_selected(rq, next)))
> > +                     proxy_tag_curr(rq, next);
>
> (*) v4 had:
>
> +          /* In case next was already curr but just got blocked_donor*/
> +             if (unlikely(!proxied && next->blocked_donor))
>

That gets re-added later in the series when we add the blocked_donor tracki=
ng:
https://github.com/johnstultz-work/linux-dev/commit/00d33fb7d94bba6d230a833=
d775f83f4d90e4661#diff-cc1a82129952a910fdc4292448c2a097a2ba538bebefcf3c0638=
1e45639ae73eR7115

> > +
> >               rq->clock_update_flags &=3D ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP=
);
> >
> >               rq_unpin_lock(rq, &rf);
>
> I miss changes in enqueue_task_rt() and put_prev_task_rt() related to
> 'affinity of blocked tasks doesn't matter' from v4.

So, yeah. As I was focusing on the correctness of the proxy migration
and return paths, I realized having the push/pull logic migrate
blocked tasks independently really doesn't help things (as proxy will
push them back).

So in those call paths, we now skip trying to migrate blocked tasks,
leaving the core proxy logic to be the only one to move blocked tasks,
and the __sched check to be the one to return them to a runnable cpu
when they are unblocked.

thanks
-john
