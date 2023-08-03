Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8BB76E86B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 14:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234726AbjHCMhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 08:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbjHCMhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 08:37:19 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D308330EF;
        Thu,  3 Aug 2023 05:37:17 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99c10ba30afso440427866b.1;
        Thu, 03 Aug 2023 05:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691066236; x=1691671036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ppRRImnjb0wsMR8Fj1ZtcjVXFsDRqp3qO+UJYqzBAyE=;
        b=P1F63pGUU6YN5E2omXCkAv2x/bzflrfH5ZmXIxOmgpY284FxRcGmwxv236F/pKiIkI
         7NQdOOaY8eWnA5kbSNb6lvIWJLHmnokArH+LM2IZNERd2o3dBWVaQiNkBN8a4vpJCDYd
         bpeosCO3ET2BfELH29DyK7i9xw6aP60Q2T26Y66WKtaMk+hBJqHdu9XH6MUzvy32fVpi
         7t/Af3oQimCPuO2mVxBcEadKMuKJLNzva+n009M+NdCKKJmaOst6MftNvnR8qgTin0Af
         AOxvRGiCuFGlvWazWe/3yl39PLAY6XfekaP6Q/pDsyxz0c20ez3u+SIjMa+QMyCS6RSq
         WrDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691066236; x=1691671036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ppRRImnjb0wsMR8Fj1ZtcjVXFsDRqp3qO+UJYqzBAyE=;
        b=OfO0qDPMXeDnE4NFDMWXeuMfX9URoy5Lxr1G7QH1ml3/hHrRX5paMuyEgZk+s+fPhe
         T4xBt0kVTqTAZ7Uc/1VQuuWag5U9zx7h+JlXPiYFZLjG/sZ7gmHqRYNfDymkdFdL/l8Q
         jVhtJ2L5oxon++7/WPEA1HV8NPhx+6hPHGeZzK5UK52mplwu4D+WiID4ZURQayUT7RgN
         WXR79yf5sp8+ozNiLRaECpK9rfHHV6ob7TmyHUozOznO6xjp+C567erfi5HC7R4Uc4wX
         G/cwuH/TlEyAurTRF84bccK9a5JmKmMU+NPOFzTe1UcjgsZMV4zM7YBWwui3VMmkoyME
         M/Vw==
X-Gm-Message-State: ABy/qLZoWSG/CQXQNsI+ZwvmWAREEYhGc0PJNC6ZX++/VZBmdxwN9jvW
        UaG7rYr+ve3dy++dndZTYqIRwt+/wygVkYUFxgQ=
X-Google-Smtp-Source: APBJJlHI2a8HOTPwSZ8QCMLfU4WHwMQBsjDKFtfsERKOf5l/XJXKLUsburWGwRAjYucvWeKe+cbqoSS/bmzSXjNFPiI=
X-Received: by 2002:a17:907:6daa:b0:99b:af5a:fc2c with SMTP id
 sb42-20020a1709076daa00b0099baf5afc2cmr10439361ejc.26.1691066235869; Thu, 03
 Aug 2023 05:37:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230803083352.1585-1-zegao@tencent.com> <20230803083352.1585-3-zegao@tencent.com>
 <20230803051011.4833785f@gandalf.local.home>
In-Reply-To: <20230803051011.4833785f@gandalf.local.home>
From:   Ze Gao <zegao2021@gmail.com>
Date:   Thu, 3 Aug 2023 20:37:04 +0800
Message-ID: <CAD8CoPC5YwEcyqH5nBziGTi5oHuGf1ucQF63UApSPtfGW-vjSQ@mail.gmail.com>
Subject: Re: [RFC PATCH v6 2/5] perf sched: reorganize sched-out task state
 report code
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

Hi Steven,

THIS IS THE NEW CHANGELOG FOR THIS PATCH:

    perf sched: reorganize sched-out task state report code

    Passing around the task state reported by tracepoint as an
    integer creates dependencies both on the task state macros
    and TASK_STATE_TO_CHAR_STR.

    Actually we can simplify this by computing the state based
    on TASK_STATE_TO_CHAR_STR and then pass the result as a
    'char', which saves us from using these macros anymore.
    So we can remove them for good.

    Note that sched_out_state() is basically doing the same
    thing as task_state_char(), so combine them into one
    and provide an intended helper get_task_prev_state() for
    extracting task state from perf record.

    IOW, this patch does not introduce any functional changes.
    mainly for housekeeping.

    Signed-off-by: Ze Gao <zegao@tencent.com>

Suggestions?

Regards,
Ze

On Thu, Aug 3, 2023 at 5:10=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Thu,  3 Aug 2023 04:33:49 -0400
> Ze Gao <zegao2021@gmail.com> wrote:
>
> > Mainly does housekeeping work and not introduce any
> > functional change.
>
> This change log doesn't explain at all why this patch is needed, let alon=
e
> what it is even doing.
>
> -- Steve
>
>
> >
> > Signed-off-by: Ze Gao <zegao@tencent.com>
> > ---
> >  tools/perf/builtin-sched.c | 59 +++++++++++++++++---------------------
> >  1 file changed, 26 insertions(+), 33 deletions(-)
> >
> > diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> > index 8dc8f071721c..5042874ba204 100644
> > --- a/tools/perf/builtin-sched.c
> > +++ b/tools/perf/builtin-sched.c
> > @@ -94,11 +94,6 @@ struct sched_atom {
> >
> >  #define TASK_STATE_TO_CHAR_STR "RSDTtXZPI"
> >
> > -/* task state bitmask, copied from include/linux/sched.h */
> > -#define TASK_RUNNING         0
> > -#define TASK_INTERRUPTIBLE   1
> > -#define TASK_UNINTERRUPTIBLE 2
> > -
> >  enum thread_state {
> >       THREAD_SLEEPING =3D 0,
> >       THREAD_WAIT_CPU,
> > @@ -255,7 +250,7 @@ struct thread_runtime {
> >       u64 total_preempt_time;
> >       u64 total_delay_time;
> >
> > -     int last_state;
> > +     char last_state;
> >
> >       char shortname[3];
> >       bool comm_changed;
> > @@ -425,7 +420,7 @@ static void add_sched_event_wakeup(struct perf_sche=
d *sched, struct task_desc *t
> >  }
> >
> >  static void add_sched_event_sleep(struct perf_sched *sched, struct tas=
k_desc *task,
> > -                               u64 timestamp, u64 task_state __maybe_u=
nused)
> > +                               u64 timestamp, char task_state __maybe_=
unused)
> >  {
> >       struct sched_atom *event =3D get_new_event(task, timestamp);
> >
> > @@ -840,6 +835,22 @@ replay_wakeup_event(struct perf_sched *sched,
> >       return 0;
> >  }
> >
> > +static inline char task_state_char(int state)
> > +{
> > +     static const char state_to_char[] =3D "RSDTtXZPI";
> > +     unsigned int bit =3D state ? ffs(state) : 0;
> > +
> > +     return bit < sizeof(state_to_char) - 1 ? state_to_char[bit] : '?'=
;
> > +}
> > +
> > +static inline char get_task_prev_state(struct evsel *evsel,
> > +                                    struct perf_sample *sample)
> > +{
> > +     const int prev_state =3D evsel__intval(evsel, sample, "prev_state=
");
> > +
> > +     return task_state_char(prev_state);
> > +}
> > +
> >  static int replay_switch_event(struct perf_sched *sched,
> >                              struct evsel *evsel,
> >                              struct perf_sample *sample,
> > @@ -849,7 +860,7 @@ static int replay_switch_event(struct perf_sched *s=
ched,
> >                  *next_comm  =3D evsel__strval(evsel, sample, "next_com=
m");
> >       const u32 prev_pid =3D evsel__intval(evsel, sample, "prev_pid"),
> >                 next_pid =3D evsel__intval(evsel, sample, "next_pid");
> > -     const u64 prev_state =3D evsel__intval(evsel, sample, "prev_state=
");
> > +     const char prev_state =3D get_task_prev_state(evsel, sample);
> >       struct task_desc *prev, __maybe_unused *next;
> >       u64 timestamp0, timestamp =3D sample->time;
> >       int cpu =3D sample->cpu;
> > @@ -1039,12 +1050,6 @@ static int thread_atoms_insert(struct perf_sched=
 *sched, struct thread *thread)
> >       return 0;
> >  }
> >
> > -static char sched_out_state(u64 prev_state)
> > -{
> > -     const char *str =3D TASK_STATE_TO_CHAR_STR;
> > -
> > -     return str[prev_state];
> > -}
> >
> >  static int
> >  add_sched_out_event(struct work_atoms *atoms,
> > @@ -1121,7 +1126,7 @@ static int latency_switch_event(struct perf_sched=
 *sched,
> >  {
> >       const u32 prev_pid =3D evsel__intval(evsel, sample, "prev_pid"),
> >                 next_pid =3D evsel__intval(evsel, sample, "next_pid");
> > -     const u64 prev_state =3D evsel__intval(evsel, sample, "prev_state=
");
> > +     const char prev_state =3D get_task_prev_state(evsel, sample);
> >       struct work_atoms *out_events, *in_events;
> >       struct thread *sched_out, *sched_in;
> >       u64 timestamp0, timestamp =3D sample->time;
> > @@ -1157,7 +1162,7 @@ static int latency_switch_event(struct perf_sched=
 *sched,
> >                       goto out_put;
> >               }
> >       }
> > -     if (add_sched_out_event(out_events, sched_out_state(prev_state), =
timestamp))
> > +     if (add_sched_out_event(out_events, prev_state, timestamp))
> >               return -1;
> >
> >       in_events =3D thread_atoms_search(&sched->atom_root, sched_in, &s=
ched->cmp_pid);
> > @@ -2022,24 +2027,12 @@ static void timehist_header(struct perf_sched *=
sched)
> >       printf("\n");
> >  }
> >
> > -static char task_state_char(struct thread *thread, int state)
> > -{
> > -     static const char state_to_char[] =3D TASK_STATE_TO_CHAR_STR;
> > -     unsigned bit =3D state ? ffs(state) : 0;
> > -
> > -     /* 'I' for idle */
> > -     if (thread__tid(thread) =3D=3D 0)
> > -             return 'I';
> > -
> > -     return bit < sizeof(state_to_char) - 1 ? state_to_char[bit] : '?'=
;
> > -}
> > -
> >  static void timehist_print_sample(struct perf_sched *sched,
> >                                 struct evsel *evsel,
> >                                 struct perf_sample *sample,
> >                                 struct addr_location *al,
> >                                 struct thread *thread,
> > -                               u64 t, int state)
> > +                               u64 t, char state)
> >  {
> >       struct thread_runtime *tr =3D thread__priv(thread);
> >       const char *next_comm =3D evsel__strval(evsel, sample, "next_comm=
");
> > @@ -2080,7 +2073,7 @@ static void timehist_print_sample(struct perf_sch=
ed *sched,
> >       print_sched_time(tr->dt_run, 6);
> >
> >       if (sched->show_state)
> > -             printf(" %5c ", task_state_char(thread, state));
> > +             printf(" %5c ", thread->tid =3D=3D 0 ? 'I' : state);
> >
> >       if (sched->show_next) {
> >               snprintf(nstr, sizeof(nstr), "next: %s[%d]", next_comm, n=
ext_pid);
> > @@ -2152,9 +2145,9 @@ static void timehist_update_runtime_stats(struct =
thread_runtime *r,
> >               else if (r->last_time) {
> >                       u64 dt_wait =3D tprev - r->last_time;
> >
> > -                     if (r->last_state =3D=3D TASK_RUNNING)
> > +                     if (r->last_state =3D=3D 'R')
> >                               r->dt_preempt =3D dt_wait;
> > -                     else if (r->last_state =3D=3D TASK_UNINTERRUPTIBL=
E)
> > +                     else if (r->last_state =3D=3D 'D')
> >                               r->dt_iowait =3D dt_wait;
> >                       else
> >                               r->dt_sleep =3D dt_wait;
> > @@ -2579,7 +2572,7 @@ static int timehist_sched_change_event(struct per=
f_tool *tool,
> >       struct thread_runtime *tr =3D NULL;
> >       u64 tprev, t =3D sample->time;
> >       int rc =3D 0;
> > -     int state =3D evsel__intval(evsel, sample, "prev_state");
> > +     const char state =3D get_task_prev_state(evsel, sample);
> >
> >       addr_location__init(&al);
> >       if (machine__resolve(machine, &al, sample) < 0) {
>
