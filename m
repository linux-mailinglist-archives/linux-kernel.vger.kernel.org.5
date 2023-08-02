Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5DD076C348
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 05:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjHBDEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 23:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjHBDEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 23:04:01 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F207C11D;
        Tue,  1 Aug 2023 20:03:55 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-522bc9556f5so5041919a12.0;
        Tue, 01 Aug 2023 20:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690945434; x=1691550234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rRDW343rKr3uaSvf+MuL3Eyi4eGed4kF3MaiwtYb/ts=;
        b=nP7+2MTCMINDLvVjbKX+brXHBi8NOv2/ncNW4+V2pSVlTCEUrDD+7OpTfBTjEVIPDB
         CN7fOKtwsrCRpUx6jzW0fIt8ELZIJlv4opLYWxdF1r01lu3mXBrwgbkOTMmP7XUXkqKm
         3eAhLATTDg5fDWg+aDXzFEuQY2PAVxDXds24sGURBojrDXPDKYgBZiM97kzqp3B0N5z1
         nVkePLvLJG9QuXobVcIJlCMsOZQIaa5QVJOvRty8nhEgOdUcWTum7NIbyMz9EZt+Vr73
         C+hpyV2ge7uwX9/OmKT6Z1c9dw3K0EJlt/66CX694mI3H3imckucFjHup2up2+cpdCkZ
         7QHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690945434; x=1691550234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rRDW343rKr3uaSvf+MuL3Eyi4eGed4kF3MaiwtYb/ts=;
        b=D1QS812shG6049Yn4V/bDb9ESenrcuQ0yu3AONFOV9VBDX9IaMMwXjd3E1M1YSlgwN
         p17ONyjmstOSXywslqcsWQS5Le9n9ii2LbuVUEjh5F8tDvOGQE+a/lzW6q8qTwrydpvF
         PTo9fKRcmxGAPMUitUzmmO6ZSWMxfUiNjcd1SXpkLppteRxtKtJhQBUJWJxhRdE9ys3D
         zcMXUPkfnf4utIsYBch591PPcxvi9vELHnN9lEjisvljdoq1G3Xqc1bkTfS2TMEIa4RP
         fqvDZBrx5/gKly56NstrQIdTJanyGOo+jICNTcVL17IYEpY6zDDtbk91pdx350ta6ksu
         I3bQ==
X-Gm-Message-State: ABy/qLa1RoMUsiaTQozoQd8pF28Nw3CTC91hQPWT7lLqp3DM7fuw26eV
        y9DAZ6hw4mMgkbSj2El6djcgZt7AMOF8MlxfieQ=
X-Google-Smtp-Source: APBJJlHWT0tISsKHvlwoWc5tzUWGfgF9GauSizJRNtGCLahO8ZzBiX4g4OZFAE2hxHF4+BcMu7v++0N2lkOiq8OiSbI=
X-Received: by 2002:a05:6402:180f:b0:521:7a5e:ab1e with SMTP id
 g15-20020a056402180f00b005217a5eab1emr4097953edy.21.1690945433945; Tue, 01
 Aug 2023 20:03:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230801090124.8050-1-zegao@tencent.com> <20230801090124.8050-4-zegao@tencent.com>
 <20230801113401.GC79828@hirez.programming.kicks-ass.net> <CAD8CoPA-cqe+hY8dHjO+6WhcL2VKy2Wq=rYSSkwUqBFRJ4ECWg@mail.gmail.com>
 <20230801134142.GC11704@hirez.programming.kicks-ass.net>
In-Reply-To: <20230801134142.GC11704@hirez.programming.kicks-ass.net>
From:   Ze Gao <zegao2021@gmail.com>
Date:   Wed, 2 Aug 2023 11:03:42 +0800
Message-ID: <CAD8CoPDR=jn4-kE2r=RX0FPk_9LhXps=ZkdBqWDb7Vy05ur3Pg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 3/6] sched, tracing: add to report task state in
 symbolic chars
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org, Ze Gao <zegao@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 1, 2023 at 9:42=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Tue, Aug 01, 2023 at 09:03:51PM +0800, Ze Gao wrote:
>
> > It's just the design that exporting internal details is fundamentally w=
rong.
>
> This is tracing... it wasn't supposed to be ABI (although it somehow

Sorry, I'm confused. And it sounds contradicting here
because you said this change is abi break before.

> ended up being one). But even then, things like PF_foo get exposed in
> procfs but even that we change.
>
> The whole point of tracing is to see internals in order to figure out
> wth is going wrong.

Fair point, but I think tracepoints are somewhat different from
kprobes/raw_tracepoints due to their stable nature. And I think
at least more and more observability tools use them in this way.

With all due respect, If it was for kernel developers only, what's the
point of leaking this since now we have raw tracepoints support?
Does that mean all tracepoints are useless now? Apparently the
answer is no. So I'm not convinced by this "for internal inspecting"
defense to not ignore what the problem is.

Honestly, I would've never thought to change this if I I got the correct
meaning for values I captured like 0x80/0x100  when I tried to look it up
in include/linux/sched.h the first time. But it really annoyed me to
figure out what it is only after I dived into the kernel and collected all
the pieces.  And you know what, when I turned to the famous in-tree perf
for possible help, only to find out it's horribly broken and still uses an
outdated state char array to interpret this weird raw value.

Anyway, we have to accept the fact that prev_state leaves a huge burden
on its users to make things right.  And I'm open and glad to see any
solutions (possibly better than this one) or efforts or suggestions to impr=
ove
this.

Regards,
Ze

> > And even worse,  I did not see any userspace tool is aware of masquerad=
ed
> > states like TASK_REPORT_IDLE and TASK_REPORT_MAX and let alone
> > parse it correctly.
>
> That's probably because I never use tools, I just look at the raw trace
> output -- sometimes an impromptu awk script. I'm pretty sure I ran with
> something like the below when I did the freezer rewrite -- or perhaps I
> just stuck in trace_printk() and didn't even bother with the
> tracepoints, I can't remember.
>
> > > Why do we need this character anyway, why not just print the state in
> > > hex and leave it at that? These single character state things are a
> > > relic, please just let them die.
> >
> > I believe hex is ok only after having the reported task state mapping
> > appear in the uapi headers, otherwise it's still useless to userspace
> > especially for value like TASK_REPORT_IDLE and TASK_REPORT_MAX, which
> > need to dig into the kernel to see what the hell is going on here.
> >
> > Thoughts?
>
> If you're tracing the kernel, you had better know what the kernel is
> doing, otherwise you get to keep the pieces.
>
> Anyway, if you're doing BPF then why do you care about the trace event
> at all, just attach to the raw tracepoint and consume @preemt, @prev,
> @next and @prev_state.
>
> ---
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index fbb99a61f714..cb0c1251729e 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -186,36 +186,6 @@ DEFINE_EVENT(sched_wakeup_template, sched_wakeup_new=
,
>              TP_PROTO(struct task_struct *p),
>              TP_ARGS(p));
>
> -#ifdef CREATE_TRACE_POINTS
> -static inline long __trace_sched_switch_state(bool preempt,
> -                                             unsigned int prev_state,
> -                                             struct task_struct *p)
> -{
> -       unsigned int state;
> -
> -#ifdef CONFIG_SCHED_DEBUG
> -       BUG_ON(p !=3D current);
> -#endif /* CONFIG_SCHED_DEBUG */
> -
> -       /*
> -        * Preemption ignores task state, therefore preempted tasks are a=
lways
> -        * RUNNING (we will not have dequeued if state !=3D RUNNING).
> -        */
> -       if (preempt)
> -               return TASK_REPORT_MAX;
> -
> -       /*
> -        * task_state_index() uses fls() and returns a value from 0-8 ran=
ge.
> -        * Decrement it by 1 (except TASK_RUNNING state i.e 0) before usi=
ng
> -        * it for left shift operation to get the correct task->state
> -        * mapping.
> -        */
> -       state =3D __task_state_index(prev_state, p->exit_state);
> -
> -       return state ? (1 << (state - 1)) : state;
> -}
> -#endif /* CREATE_TRACE_POINTS */
> -
>  /*
>   * Tracepoint for task switches, performed by the scheduler:
>   */
> @@ -242,29 +212,16 @@ TRACE_EVENT(sched_switch,
>                 memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
>                 __entry->prev_pid       =3D prev->pid;
>                 __entry->prev_prio      =3D prev->prio;
> -               __entry->prev_state     =3D __trace_sched_switch_state(pr=
eempt, prev_state, prev);
> +               __entry->prev_state     =3D prev_state | (preempt * TASK_=
STATE_MAX);
>                 memcpy(__entry->prev_comm, prev->comm, TASK_COMM_LEN);
>                 __entry->next_pid       =3D next->pid;
>                 __entry->next_prio      =3D next->prio;
>                 /* XXX SCHED_DEADLINE */
>         ),
>
> -       TP_printk("prev_comm=3D%s prev_pid=3D%d prev_prio=3D%d prev_state=
=3D%s%s =3D=3D> next_comm=3D%s next_pid=3D%d next_prio=3D%d",
> +       TP_printk("prev_comm=3D%s prev_pid=3D%d prev_prio=3D%d prev_state=
=3D%x =3D=3D> next_comm=3D%s next_pid=3D%d next_prio=3D%d",
>                 __entry->prev_comm, __entry->prev_pid, __entry->prev_prio=
,
> -
> -               (__entry->prev_state & (TASK_REPORT_MAX - 1)) ?
> -                 __print_flags(__entry->prev_state & (TASK_REPORT_MAX - =
1), "|",
> -                               { TASK_INTERRUPTIBLE, "S" },
> -                               { TASK_UNINTERRUPTIBLE, "D" },
> -                               { __TASK_STOPPED, "T" },
> -                               { __TASK_TRACED, "t" },
> -                               { EXIT_DEAD, "X" },
> -                               { EXIT_ZOMBIE, "Z" },
> -                               { TASK_PARKED, "P" },
> -                               { TASK_DEAD, "I" }) :
> -                 "R",
> -
> -               __entry->prev_state & TASK_REPORT_MAX ? "+" : "",
> +               __entry->prev_state,
>                 __entry->next_comm, __entry->next_pid, __entry->next_prio=
)
>  );
>
