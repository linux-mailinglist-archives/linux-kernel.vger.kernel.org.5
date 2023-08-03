Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDE076E5EC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 12:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbjHCKzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 06:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjHCKzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 06:55:46 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9341AB;
        Thu,  3 Aug 2023 03:55:44 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so4194129a12.0;
        Thu, 03 Aug 2023 03:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691060143; x=1691664943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mbQImGIoYqtoRkNqIk+yJGoSi/80qEOyrC5e+XSgi1k=;
        b=scej0RhAsMPY3H4QUNINXN2VeRHixd9bGG8xsN72U6bKwVoBCvE3uQOcPb85lwTI7e
         Nxm/anautxtLkz/chYBg9mUPZbjqa8nzz4J2nGmbyycfSOhl7U1SPxql/5Wg4/4nXJtt
         uXd1ckeACPeURhBS95UT33Yo7aHfmKz2HYvoIc7Y5KwOQWfVOmN+sFgpHREgomyjhDBF
         w47Qyz0kLuGT5K/swdN2f4FU6aIcD+nkbQMgJ0qsjG1x4ov1etrFTz6hNfPQ2V0kXk2Y
         s+Bc4vbqFid3byB/IhykjvYzDEY7sZZMhL9weakfXjogXkV0kAICDvTIPXqZlVxrTHjT
         TlTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691060143; x=1691664943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mbQImGIoYqtoRkNqIk+yJGoSi/80qEOyrC5e+XSgi1k=;
        b=DckqLAF1Je/bZUqebMUZRUXIVJfJaS8KrrKT9/am3bWZNMNbxonoVhnU5PsQ6KOIPm
         XXFjUzbTXDUoibPVrlVOUKYjokhqnohszcPOoBANZDO45jj2EF/2Q2qE+xoiblH7Ujh0
         HKpeW8QnsSCGVjcrLf4cRr0kMFzHReixLaIPkrFeBF6fRFfrdOEiLyXHKkaa1irSJ780
         qMAnO4frbVsam2yiVxu+ynvGb3qgYwwVMFTYw0EArvk2UAIFcxc1/2ieQX3da2fuhFKq
         QJXU4vsnrdtca27JDPtHgHYL2GVRz4elg/rQ6i9UwoxMTnl8V3NXqU9zjeK5Crh45y12
         ZVZQ==
X-Gm-Message-State: ABy/qLa9jKvAE1DO4v8tOcwJCOAdENOb0WLLCuSUHDdi7SNVinzDVBei
        W1TcLWghAAQpyGiAdFw+Ba+jJYIpTtOCjpZyrZHbZCJTm95HrQ==
X-Google-Smtp-Source: APBJJlHbHtPiFgLPGm45/6fntr2mqG6bus6N966l0sTWv17Wi4cwvMe1VkToxGlg3s6NA5N5ByPlZDumz/oZk9DUgns=
X-Received: by 2002:a05:6402:517a:b0:522:582c:f427 with SMTP id
 d26-20020a056402517a00b00522582cf427mr11174095ede.14.1691060143340; Thu, 03
 Aug 2023 03:55:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230803083352.1585-1-zegao@tencent.com> <20230803083352.1585-5-zegao@tencent.com>
 <20230803052930.33337082@gandalf.local.home>
In-Reply-To: <20230803052930.33337082@gandalf.local.home>
From:   Ze Gao <zegao2021@gmail.com>
Date:   Thu, 3 Aug 2023 18:55:32 +0800
Message-ID: <CAD8CoPBeqgF8bYDBb4WGuBPgTNBCki9-U2XsoY9r55HcBA1+-A@mail.gmail.com>
Subject: Re: [RFC PATCH v6 4/5] sched, tracing: add to report task state in
 symbolic chars
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, Ze Gao <zegao@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 5:29=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Thu,  3 Aug 2023 04:33:51 -0400
> Ze Gao <zegao2021@gmail.com> wrote:
>
> > Internal representations of task state are likely to be changed
> > or ordered, and reporting them to userspace without exporting
> > them as part of API is basically wrong, which can easily break
> > a userspace observability tool as kernel evolves. For example,
> > perf suffers from this and still reports wrong states as of this
> > writing.
> >
> > OTOH, some masqueraded states like TASK_REPORT_IDLE and
> > TASK_REPORT_MAX are also reported inadvertently, which confuses
> > things even more and most userspace tools do not even take them
> > into consideration.
> >
> > So add a new variable in company with the old raw value to
> > report task state in symbolic chars, which are self-explaining
> > and no further translation is needed. Of course this does not
> > break any userspace tool.
> >
> > Note for PREEMPT_ACTIVE, we introduce 'p' to report it and use
> > the old conventions for the rest.
>
> The above is actually good.
>
>
> >
> > Signed-off-by: Ze Gao <zegao@tencent.com>
> > Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Acked-by: Ian Rogers <irogers@google.com>
> > ---
> >  include/trace/events/sched.h | 44 ++++++++++++++++++++++--------------
> >  1 file changed, 27 insertions(+), 17 deletions(-)
> >
> > diff --git a/include/trace/events/sched.h b/include/trace/events/sched.=
h
> > index 43492daefa6f..ae5b486cc969 100644
> > --- a/include/trace/events/sched.h
> > +++ b/include/trace/events/sched.h
> > @@ -6,6 +6,7 @@
> >  #define _TRACE_SCHED_H
> >
> >  #include <linux/kthread.h>
> > +#include <linux/sched.h>
> >  #include <linux/sched/numa_balancing.h>
> >  #include <linux/tracepoint.h>
> >  #include <linux/binfmts.h>
> > @@ -214,6 +215,27 @@ static inline short __trace_sched_switch_state(boo=
l preempt,
> >
> >       return state ? (1 << (state - 1)) : state;
> >  }
> > +
> > +static inline char __trace_sched_switch_state_char(bool preempt,
> > +                                                unsigned int prev_stat=
e,
> > +                                                struct task_struct *p)
> > +{
> > +     long state;
> > +
> > +#ifdef CONFIG_SCHED_DEBUG
> > +     WARN_ON_ONCE(p !=3D current);
> > +#endif /* CONFIG_SCHED_DEBUG */
> > +
> > +     /*
> > +      * For PREEMPT_ACTIVE, we introduce 'p' to report it and use the =
old
> > +      * conventions for the rest.
> > +      */
> > +     if (preempt)
> > +             return 'p';
> > +
> > +     state =3D __task_state_index(prev_state, p->exit_state);
> > +     return task_index_to_char(state);
> > +}
> >  #endif /* CREATE_TRACE_POINTS */
> >
> >  /*
> > @@ -236,6 +258,7 @@ TRACE_EVENT(sched_switch,
> >               __array(        char,   prev_comm,      TASK_COMM_LEN   )
> >               __array(        char,   next_comm,      TASK_COMM_LEN   )
> >               __field(        short,  prev_state                      )
> > +             __field(        char,   prev_state_char                 )
> >       ),
> >
> >       TP_fast_assign(
> > @@ -246,26 +269,13 @@ TRACE_EVENT(sched_switch,
> >               memcpy(__entry->prev_comm, prev->comm, TASK_COMM_LEN);
> >               memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
> >               __entry->prev_state             =3D __trace_sched_switch_=
state(preempt, prev_state, prev);
> > +             __entry->prev_state_char        =3D __trace_sched_switch_=
state_char(preempt, prev_state, prev);
> >               /* XXX SCHED_DEADLINE */
> >       ),
> >
> > -     TP_printk("prev_comm=3D%s prev_pid=3D%d prev_prio=3D%d prev_state=
=3D%s%s =3D=3D> next_comm=3D%s next_pid=3D%d next_prio=3D%d",
> > -             __entry->prev_comm, __entry->prev_pid, __entry->prev_prio=
,
> > -
> > -             (__entry->prev_state & (TASK_REPORT_MAX - 1)) ?
> > -               __print_flags(__entry->prev_state & (TASK_REPORT_MAX - =
1), "|",
> > -                             { TASK_INTERRUPTIBLE, "S" },
> > -                             { TASK_UNINTERRUPTIBLE, "D" },
> > -                             { __TASK_STOPPED, "T" },
> > -                             { __TASK_TRACED, "t" },
> > -                             { EXIT_DEAD, "X" },
> > -                             { EXIT_ZOMBIE, "Z" },
> > -                             { TASK_PARKED, "P" },
> > -                             { TASK_DEAD, "I" }) :
> > -               "R",
>
> I just realized, I have user space code that looks at this. As in the for=
mat file we have:
>
> print fmt: "prev_comm=3D%s prev_pid=3D%d prev_prio=3D%d prev_state=3D%s%s=
 =3D=3D> next_comm=3D%s next_pid=3D%d next_prio=3D%d", REC->prev_comm, REC-=
>prev_pid, REC->prev_prio, (REC->prev_state & ((((0x00000000 | 0x00000001 |=
 0x00000002 | 0x00000004 | 0x00000008 | 0x00000010 | 0x00000020 | 0x0000004=
0) + 1) << 1) - 1)) ? __print_flags(REC->prev_state & ((((0x00000000 | 0x00=
000001 | 0x00000002 | 0x00000004 | 0x00000008 | 0x00000010 | 0x00000020 | 0=
x00000040) + 1) << 1) - 1), "|", { 0x00000001, "S" }, { 0x00000002, "D" }, =
{ 0x00000004, "T" }, { 0x00000008, "t" }, { 0x00000010, "X" }, { 0x00000020=
, "Z" }, { 0x00000040, "P" }, { 0x00000080, "I" }) : "R", REC->prev_state &=
 (((0x00000000 | 0x00000001 | 0x00000002 | 0x00000004 | 0x00000008 | 0x0000=
0010 | 0x00000020 | 0x00000040) + 1) << 1) ? "+" : "", REC->next_comm, REC-=
>next_pid, REC->next_prio
>
> And I have used this in applications to find out what values "S" and "D"
> are.
>
> So, we need to keep that still. But we can add the prev_state_char to the
> output too.
>
>   "prev_comm=3D%s prev_pid=3D%d prev_prio=3D%d prev_state=3D%s%s[%c] =3D=
=3D> next_comm=3D%s next_pid=3D%d next_prio=3D%d"

Good point!

But I see Peter has strong opinions over this change badly. So I'm not
sure if it's worth the effort to push this anymore :/ And apparently We
failed to convince each other over this problem.

How about we only keep all the fixing patches and throw away this
'prev_state_char' thing?

Again, I'm not meant to upset anyone here.  But Tons of thanks for your
sage reviews on this.

Thoughts?

Thanks,
Ze
