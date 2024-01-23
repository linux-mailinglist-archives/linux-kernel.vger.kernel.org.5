Return-Path: <linux-kernel+bounces-34627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E24838540
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC8BC1C2A5FD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749FB7E598;
	Tue, 23 Jan 2024 02:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEcvA9TN"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AE57E58C;
	Tue, 23 Jan 2024 02:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975778; cv=none; b=okPdlG4F7VfOFWdihEiIM17zfg0AwreDXZvZ+PZ1oMJLBfSuL/PN69cRAGpEcICvG0IXyebAWftJB+n09xjQqNaZmxgg60sPerNIbRtwxLJd6zfKtOa5sEfq6nJYJUZWJdbxdA+M/UooxHTvPzkAD3KOQNtN7QsDbcC3oErRPf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975778; c=relaxed/simple;
	bh=1fEvgP1GHGJ2vym6gZ0VwZ8YW/OG2sxOSW1Ybq90FzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f6/xcbvPnnQn5ioSRWUXDGLAktJVKZ94NQw6kSO1pPyQLDtxyOxzUZtRfst9+8yl8FOYwIyg6+zr59Md9NfElzh7ASGBsppzAyiB0SSxlAaoz8lt1/y28/dsQA/WWb3KKmjU/LCNtH/n70QFx7BIUZF0kJ1ZRKeDnbkslmmCSqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEcvA9TN; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cf108f6a2dso2084181fa.3;
        Mon, 22 Jan 2024 18:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705975774; x=1706580574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZyJo1Zi6quHLgXv0MkZRT56Eb8LwDVxOUotPPkzA82s=;
        b=JEcvA9TNFjm31XlC3ookOuB8MWWSDonOC/rZbB6vHm06l9SwRjdRoyxx3/c7V2ukUW
         lIZVYg28869JHRSW8sHUFZCM2y2pTDCGKtxZv37kL2K8mqkx0wvOQEFd2y8kPR2w77w2
         yAjAPGXC4xVNpODhFX9SEL/aYKE5QHxu9OBI6lfDbMvPmYE2Dp30pbzwq0czmUxiAprw
         KnOBTaRtodQjLmuHeIcj7vu6KcYssBRX0JGfNYcUgG9JPPyvfy4y8SR3O6gAsIXwB9Mv
         zdThd8P/nSJ7PpK8CeMl4GhR7cp0KHn3GZdQQLwHTaaMlAqtOvUmwDyXNHoU160QjYxY
         u0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705975774; x=1706580574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZyJo1Zi6quHLgXv0MkZRT56Eb8LwDVxOUotPPkzA82s=;
        b=UimjZxpJ1lHC1NQacjwf6cN2UkpnnRQqP3CIX051FJ3ETI9By9lpzTYzlhncFFCo/b
         vvE/dNXPUTGJ3JRrgIF1QeeHXHIaES4pZDF3tv1jdPm5eQzNyelK9oSk3SYeEGXjSoTh
         QO5zeXBSkjtg3ml2NP1hxyuxdaklmkU0Twlw8HaaZoFtLB1H1CCSFPLft7KiVsyEUBtD
         KVhD4ia9YWN2hP+0zbqxNxLHximgWTRPjTpYEgDZdeEJ39dMZxC2GTtOMuQpacePat3i
         5EIYYMNGdJQ+RbolLut3+sIMeQ3rTLph/BYkezmeoC9ANO8xJE0ict5m+Q8Z4zWm8wiA
         BFDA==
X-Gm-Message-State: AOJu0YwCw3RKrEAJcXuTdXH7OBvgV12BbwoSK1J4cIRo7LgucEYBBG8H
	isS9dxzht6COhJ1KxFqsM3iDjDVgEprclq+Qb2viYEQyY7L29ho+SDiOGSzP7ApTZCw1VCpG4S2
	pWGaWS3tKeXadiscJ9ezGBfg0xQE=
X-Google-Smtp-Source: AGHT+IGbvFTtsgDCkX+MOJlIg5MbReNaiNol9DCh/IyM8rPRYxAp9/Wzq0DYyKRT8dNw7KERAzJlbLxsCWEWB3rpoD4=
X-Received: by 2002:a2e:7817:0:b0:2cd:f47e:c0ae with SMTP id
 t23-20020a2e7817000000b002cdf47ec0aemr2072346ljc.64.1705975774274; Mon, 22
 Jan 2024 18:09:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122070859.1394479-2-zegao@tencent.com> <20240122070859.1394479-6-zegao@tencent.com>
 <CAM9d7cjWdZa9oh-6CmydvtzOEkkWMip8yfxTS4L_PZnq4K7B1w@mail.gmail.com>
In-Reply-To: <CAM9d7cjWdZa9oh-6CmydvtzOEkkWMip8yfxTS4L_PZnq4K7B1w@mail.gmail.com>
From: Ze Gao <zegao2021@gmail.com>
Date: Tue, 23 Jan 2024 10:09:22 +0800
Message-ID: <CAD8CoPAr_bGNmmxkQpb1V7TeGtRE5=epC+5n-B2QiCH4QZjfxA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] perf sched: Commit to evsel__taskstate() to parse
 task state info
To: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Ze Gao <zegao@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 8:38=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> On Sun, Jan 21, 2024 at 11:11=E2=80=AFPM Ze Gao <zegao2021@gmail.com> wro=
te:
> >
> > Now that we have evsel__taskstate() which no longer relies on the
> > hardcoded task state string and has good backward compatibility,
> > we have a good reason to use it.
> >
> > Note TASK_STATE_TO_CHAR_STR and task bitmasks are useless now so
> > we remove them for good. And now we pass the state info back and
> > forth in a symbolic char which explains itself well instead.
> >
> > Signed-off-by: Ze Gao <zegao@tencent.com>
> > ---
> >  tools/perf/builtin-sched.c | 46 +++++++++-----------------------------
> >  1 file changed, 10 insertions(+), 36 deletions(-)
> >
> > diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> > index ced6fffe8110..f1d62f6b6cab 100644
> > --- a/tools/perf/builtin-sched.c
> > +++ b/tools/perf/builtin-sched.c
> > @@ -92,13 +92,6 @@ struct sched_atom {
> >         struct task_desc        *wakee;
> >  };
> >
> > -#define TASK_STATE_TO_CHAR_STR "RSDTtXZPI"
> > -
> > -/* task state bitmask, copied from include/linux/sched.h */
> > -#define TASK_RUNNING           0
> > -#define TASK_INTERRUPTIBLE     1
> > -#define TASK_UNINTERRUPTIBLE   2
> > -
> >  enum thread_state {
> >         THREAD_SLEEPING =3D 0,
> >         THREAD_WAIT_CPU,
> > @@ -255,7 +248,7 @@ struct thread_runtime {
> >         u64 total_preempt_time;
> >         u64 total_delay_time;
> >
> > -       int last_state;
> > +       char last_state;
> >
> >         char shortname[3];
> >         bool comm_changed;
> > @@ -425,7 +418,7 @@ static void add_sched_event_wakeup(struct perf_sche=
d *sched, struct task_desc *t
> >  }
> >
> >  static void add_sched_event_sleep(struct perf_sched *sched, struct tas=
k_desc *task,
> > -                                 u64 timestamp, u64 task_state __maybe=
_unused)
> > +                                 u64 timestamp, const char task_state =
__maybe_unused)
> >  {
> >         struct sched_atom *event =3D get_new_event(task, timestamp);
> >
> > @@ -849,7 +842,7 @@ static int replay_switch_event(struct perf_sched *s=
ched,
> >                    *next_comm  =3D evsel__strval(evsel, sample, "next_c=
omm");
> >         const u32 prev_pid =3D evsel__intval(evsel, sample, "prev_pid")=
,
> >                   next_pid =3D evsel__intval(evsel, sample, "next_pid")=
;
> > -       const u64 prev_state =3D evsel__intval(evsel, sample, "prev_sta=
te");
> > +       const char prev_state =3D evsel__taskstate(evsel, sample, "prev=
_state");
> >         struct task_desc *prev, __maybe_unused *next;
> >         u64 timestamp0, timestamp =3D sample->time;
> >         int cpu =3D sample->cpu;
> > @@ -1039,13 +1032,6 @@ static int thread_atoms_insert(struct perf_sched=
 *sched, struct thread *thread)
> >         return 0;
> >  }
> >
> > -static char sched_out_state(u64 prev_state)
> > -{
> > -       const char *str =3D TASK_STATE_TO_CHAR_STR;
> > -
> > -       return str[prev_state];
> > -}
> > -
> >  static int
> >  add_sched_out_event(struct work_atoms *atoms,
> >                     char run_state,
> > @@ -1121,7 +1107,7 @@ static int latency_switch_event(struct perf_sched=
 *sched,
> >  {
> >         const u32 prev_pid =3D evsel__intval(evsel, sample, "prev_pid")=
,
> >                   next_pid =3D evsel__intval(evsel, sample, "next_pid")=
;
> > -       const u64 prev_state =3D evsel__intval(evsel, sample, "prev_sta=
te");
> > +       const char prev_state =3D evsel__taskstate(evsel, sample, "prev=
_state");
> >         struct work_atoms *out_events, *in_events;
> >         struct thread *sched_out, *sched_in;
> >         u64 timestamp0, timestamp =3D sample->time;
> > @@ -1157,7 +1143,7 @@ static int latency_switch_event(struct perf_sched=
 *sched,
> >                         goto out_put;
> >                 }
> >         }
> > -       if (add_sched_out_event(out_events, sched_out_state(prev_state)=
, timestamp))
> > +       if (add_sched_out_event(out_events, prev_state, timestamp))
> >                 return -1;
> >
> >         in_events =3D thread_atoms_search(&sched->atom_root, sched_in, =
&sched->cmp_pid);
> > @@ -2022,24 +2008,12 @@ static void timehist_header(struct perf_sched *=
sched)
> >         printf("\n");
> >  }
> >
> > -static char task_state_char(struct thread *thread, int state)
> > -{
> > -       static const char state_to_char[] =3D TASK_STATE_TO_CHAR_STR;
> > -       unsigned bit =3D state ? ffs(state) : 0;
> > -
> > -       /* 'I' for idle */
> > -       if (thread__tid(thread) =3D=3D 0)
> > -               return 'I';
> > -
> > -       return bit < sizeof(state_to_char) - 1 ? state_to_char[bit] : '=
?';
> > -}
> > -
> >  static void timehist_print_sample(struct perf_sched *sched,
> >                                   struct evsel *evsel,
> >                                   struct perf_sample *sample,
> >                                   struct addr_location *al,
> >                                   struct thread *thread,
> > -                                 u64 t, int state)
> > +                                 u64 t, const char state)
> >  {
> >         struct thread_runtime *tr =3D thread__priv(thread);
> >         const char *next_comm =3D evsel__strval(evsel, sample, "next_co=
mm");
> > @@ -2080,7 +2054,7 @@ static void timehist_print_sample(struct perf_sch=
ed *sched,
> >         print_sched_time(tr->dt_run, 6);
> >
> >         if (sched->show_state)
> > -               printf(" %5c ", task_state_char(thread, state));
> > +               printf(" %5c ", thread->tid =3D=3D 0 ? 'I' : state);
>
> This resulted in a build error with reference count checker.
>
>   $ make EXTRA_CFLAGS=3D-DREFCNT_CHECKING=3D1
>   ...
>   builtin-sched.c: In function =E2=80=98timehist_print_sample=E2=80=99:
>   builtin-sched.c:2057:39: error: =E2=80=98struct thread=E2=80=99 has no =
member named =E2=80=98tid=E2=80=99
>    2057 |                 printf(" %5c ", thread->tid =3D=3D 0 ? 'I' : st=
ate);
>         |
>
> The struct thread is protected by the refcount checker so
> you should not access the members directly.  Instead,
> please use a help function like thread__tid().

Thanks for pointing this out. Commit ee84a3032b74("
perf thread: Add accessor functions for thread") introduced
this accessor which i overlooked. My bad :(.

Will send a fix in-reply-to this patch separately.

Thanks,
        -- Ze

> Thanks,
> Namhyung
>
> >
> >         if (sched->show_next) {
> >                 snprintf(nstr, sizeof(nstr), "next: %s[%d]", next_comm,=
 next_pid);
> > @@ -2152,9 +2126,9 @@ static void timehist_update_runtime_stats(struct =
thread_runtime *r,
> >                 else if (r->last_time) {
> >                         u64 dt_wait =3D tprev - r->last_time;
> >
> > -                       if (r->last_state =3D=3D TASK_RUNNING)
> > +                       if (r->last_state =3D=3D 'R')
> >                                 r->dt_preempt =3D dt_wait;
> > -                       else if (r->last_state =3D=3D TASK_UNINTERRUPTI=
BLE)
> > +                       else if (r->last_state =3D=3D 'D')
> >                                 r->dt_iowait =3D dt_wait;
> >                         else
> >                                 r->dt_sleep =3D dt_wait;
> > @@ -2579,7 +2553,7 @@ static int timehist_sched_change_event(struct per=
f_tool *tool,
> >         struct thread_runtime *tr =3D NULL;
> >         u64 tprev, t =3D sample->time;
> >         int rc =3D 0;
> > -       int state =3D evsel__intval(evsel, sample, "prev_state");
> > +       const char state =3D evsel__taskstate(evsel, sample, "prev_stat=
e");
> >
> >         addr_location__init(&al);
> >         if (machine__resolve(machine, &al, sample) < 0) {
> > --
> > 2.41.0
> >

