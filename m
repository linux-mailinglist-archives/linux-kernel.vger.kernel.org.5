Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0EA076C353
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 05:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjHBDHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 23:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjHBDHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 23:07:50 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D56AC;
        Tue,  1 Aug 2023 20:07:48 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fe2503e3easo7174468e87.2;
        Tue, 01 Aug 2023 20:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690945667; x=1691550467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdyjp2gl7Hdshoo3yvNEIVN8ZuN95p+Gft0bf/eqYok=;
        b=ckVzJIE2E/t5qhroa9kMCiavl3OwHsWUnvDf254txj9B7+u6C45hkHo3ZVMri8A28n
         CBKI6AxANNSRB3yU/wS8xtGviAQHJq/m4SOMrK+1FpaTL0pv7gPruZjq1U+OF2tXmkFZ
         C9WNQ5v8q+3Z9SwaTJDPvab48rGowf9PK3+hKNkUFrILEMzpbrazhKiKHwvbuxq0OL+l
         sfQISzA/RIb1jRPjWefnt0EvlnCHxLvNE9rtqf7WTL3t1vKe9lq+4OJAIbOGkAj1Z2Qz
         7kR/mzUY9aGyKK09Aqt0Vcvj4SD3ILm9INLFJgyRbDHUZHRakTj+UYvcRHJ1WV6LezYa
         VAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690945667; x=1691550467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hdyjp2gl7Hdshoo3yvNEIVN8ZuN95p+Gft0bf/eqYok=;
        b=R5ukyd7b+q0VlyI7CyEdYIGIcfYjNMvUSXvY9bmAJo+SpNtWSYCRzuzkP9WytlBaJL
         8DzN5kNd7KWe8MH66s2gUlO3i/3XjdbyoiyyjLRrkdNPlOIJlKgdkEwBArldeyD21GHy
         CyepHCjYTSKk9JVBegMaZCXo8Pfh9UR0nW5njeDftvRMdSYmHcgSiDKa2voXzdpSpiqR
         0mFgnKbeJVIzvIoXOXJxXYXD3Oft3COjEDM23rClNkZKNRCcalON5RfqE3U64SASHyqZ
         CbhiU8ckvnCF7opbjRX1TQqxoY5o2URHrZP1Pg5cTkfRMsFWIkPN5V0yaoFy5Ye+uA6u
         3kxA==
X-Gm-Message-State: ABy/qLYMVSyu1LYKNPfFyDo8AxjbMw5hJYFl3adXXKVPNDV2TpBjyoK0
        ZxjMnBUCxFykbKQJxb2f7ERyF55pmtXIObVwleM=
X-Google-Smtp-Source: APBJJlE5QDjxq8KY3EYE0vPpSfwBPUMoojcWq9bE5qXaahNlruGgfTS87nCrSjVcw77b+hZArhDlX2DEoqW2lrLuzhc=
X-Received: by 2002:a05:6512:2e9:b0:4fe:819:b0ed with SMTP id
 m9-20020a05651202e900b004fe0819b0edmr3292712lfq.46.1690945666554; Tue, 01 Aug
 2023 20:07:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230801090124.8050-1-zegao@tencent.com> <20230801090124.8050-5-zegao@tencent.com>
 <20230801101612.0e083e2d@gandalf.local.home>
In-Reply-To: <20230801101612.0e083e2d@gandalf.local.home>
From:   Ze Gao <zegao2021@gmail.com>
Date:   Wed, 2 Aug 2023 11:07:35 +0800
Message-ID: <CAD8CoPCYa6Lyvi-T8qarAhPcVTuA6ASCs6X4uhokZgyz_zZHUg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 4/6] sched, tracing: reorganize fields of switch
 event struct
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

Fair point, will do it in v4 as well.

Thanks,
Ze

On Tue, Aug 1, 2023 at 10:16=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Tue,  1 Aug 2023 17:01:22 +0800
> Ze Gao <zegao2021@gmail.com> wrote:
>
> > Report priorities in 'short' and prev_state in 'int' to save
> > some buffer space. And also reorder the fields so that we take
> > struct alignment into consideration to make the record compact.
> >
> > Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > Signed-off-by: Ze Gao <zegao@tencent.com>
>
> I'd swap this patch with patch 3. That is, make the field changes first.
> I'd like this to get in regardless of if the state_char is accepted. We m=
ay
> want to get this in first to see if there's any regressions before we add=
 a
> state_char.
>
> -- Steve
>
>
> > ---
> >  include/trace/events/sched.h | 22 +++++++++++-----------
> >  1 file changed, 11 insertions(+), 11 deletions(-)
> >
> > diff --git a/include/trace/events/sched.h b/include/trace/events/sched.=
h
> > index e507901bcab8..36863ffb00c6 100644
> > --- a/include/trace/events/sched.h
> > +++ b/include/trace/events/sched.h
> > @@ -188,7 +188,7 @@ DEFINE_EVENT(sched_wakeup_template, sched_wakeup_ne=
w,
> >            TP_ARGS(p));
> >
> >  #ifdef CREATE_TRACE_POINTS
> > -static inline long __trace_sched_switch_state(bool preempt,
> > +static inline int __trace_sched_switch_state(bool preempt,
> >                                             unsigned int prev_state,
> >                                             struct task_struct *p)
> >  {
> > @@ -251,25 +251,25 @@ TRACE_EVENT(sched_switch,
> >       TP_ARGS(preempt, prev, next, prev_state),
> >
> >       TP_STRUCT__entry(
> > -             __array(        char,   prev_comm,      TASK_COMM_LEN   )
> >               __field(        pid_t,  prev_pid                        )
> > -             __field(        int,    prev_prio                       )
> > -             __field(        long,   prev_state                      )
> > -             __field(        char,   prev_state_char                 )
> > -             __array(        char,   next_comm,      TASK_COMM_LEN   )
> >               __field(        pid_t,  next_pid                        )
> > -             __field(        int,    next_prio                       )
> > +             __field(        short,  prev_prio                       )
> > +             __field(        short,  next_prio                       )
> > +             __field(        int,    prev_state                      )
> > +             __array(        char,   prev_comm,      TASK_COMM_LEN   )
> > +             __array(        char,   next_comm,      TASK_COMM_LEN   )
> > +             __field(        char,   prev_state_char                 )
> >       ),
> >
> >       TP_fast_assign(
> > -             memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
> >               __entry->prev_pid               =3D prev->pid;
> > -             __entry->prev_prio              =3D prev->prio;
> > +             __entry->next_pid               =3D next->pid;
> > +             __entry->prev_prio              =3D (short) prev->prio;
> > +             __entry->next_prio              =3D (short) next->prio;
> >               __entry->prev_state             =3D __trace_sched_switch_=
state(preempt, prev_state, prev);
> >               __entry->prev_state_char        =3D __trace_sched_switch_=
state_char(preempt, prev_state, prev);
> >               memcpy(__entry->prev_comm, prev->comm, TASK_COMM_LEN);
> > -             __entry->next_pid               =3D next->pid;
> > -             __entry->next_prio              =3D next->prio;
> > +             memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
> >               /* XXX SCHED_DEADLINE */
> >       ),
> >
>
