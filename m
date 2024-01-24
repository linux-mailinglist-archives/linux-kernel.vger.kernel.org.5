Return-Path: <linux-kernel+bounces-36211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC240839D93
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4941F1F27CE0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED83A32;
	Wed, 24 Jan 2024 00:17:39 +0000 (UTC)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D840160;
	Wed, 24 Jan 2024 00:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706055458; cv=none; b=B3EStGHEc2ptazyyWd7dUGc4HFB8c65eO2Sd77O5WSXBwR2YBaPRq7Y+TnClB3ThfAOGqNB0fOcJGoq5SCV6WrGUgyJ7S3Rh8KTzQBlFECw3iT1D1iQxFsVNaawbH51ajT82TBHEd6QI70hr8HXAIxTKgZAFDuZw4LOgiTYm+y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706055458; c=relaxed/simple;
	bh=7S5gsebecCEWrzl2p5jH+A1M/fJoxrLb2LBCC2nJkMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gaqrCd4Gmsxbqxjt0cVbldy6vNrA5nmETV3zCSFHhT7dBBNzzpp63IuCfnlmCBkG7cW0zt1GxtdGHVZ49eCtwhRyE+jUBT0RnFeUuIiWLqJuFS/prE7/dqMQ1018NGNhE3fECKDElgO5iMfR+mRPkrvx0bJfQNPja9hX64UZxZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bd72353d9fso4006636b6e.3;
        Tue, 23 Jan 2024 16:17:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706055456; x=1706660256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uLqC1jIvMWI3cEp/YCvbp1WDnCj+e3OT+PtehIgxizk=;
        b=WJMXv0uFFPeL2J5o/FqDzC/EHPdGofqS0EpDEtRMSkdzrVd73+V0tIdFpZnovFEucd
         0YXCeN2luKSb/bAPx3n+YT6BWP2Ct5bKjUfap0DklXRSIJ0msBG+rmuC6bNptDsEPHNm
         fZbGHSE/V2svmAyhEtwgGOiCguzShPtcdL5zhdpEcLVWrl39slbFBc9sfzNEsiHF2wUn
         6kx+h2R4Kmk0ut+8OsNWX2rKUuZfy6vsC5oCXSaSZvyRZOoy8ujOVe9kpPUk5LFvMw31
         ur+F9NVDgmK/d0l4DHXwygs//B7tpSi9MJYuQY6xg5mYM9bkqnfiAmhgaeznA92lqH5E
         W3sg==
X-Gm-Message-State: AOJu0YyxbYM1BCjRgEAP98YHgsPJYYcIQVAZGfn2c7nCKiSUhYBM1+He
	IKJR7V12AliK4ccqh0k2JW81BJrEhZ1KNDk9ULWLWmm1OnhsPGWO0uPYJVUXSDYyiwD1EEweon+
	iRIqm2eBlqOT0ozSPz1vdU9XgbUdcpLCiV0k=
X-Google-Smtp-Source: AGHT+IEH2tTLbdxyXcpp6O17qio1Fb5OogJb9d5vLFTTq082EUe4OMFbqbp/epWgYE+atgK26KfLNLHj9wVCU+vWzaw=
X-Received: by 2002:a05:6808:1201:b0:3bd:9dc0:d39e with SMTP id
 a1-20020a056808120100b003bd9dc0d39emr793916oil.97.1706055456212; Tue, 23 Jan
 2024 16:17:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD8CoPAr_bGNmmxkQpb1V7TeGtRE5=epC+5n-B2QiCH4QZjfxA@mail.gmail.com>
 <20240123022425.1611483-1-zegao@tencent.com>
In-Reply-To: <20240123022425.1611483-1-zegao@tencent.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 23 Jan 2024 16:17:25 -0800
Message-ID: <CAM9d7cjThFo=7x+vrqNz3LFfpdisbEEzWZUbJ5JGipH2vaJVjw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] perf sched: Commit to evsel__taskstate() to parse
 task state info
To: Ze Gao <zegao2021@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Ze Gao <zegao@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 6:24=E2=80=AFPM Ze Gao <zegao2021@gmail.com> wrote:
>
> Now that we have evsel__taskstate() which no longer relies on the
> hardcoded task state string and has good backward compatibility,
> we have a good reason to use it.
>
> Note TASK_STATE_TO_CHAR_STR and task bitmasks are useless now so
> we remove them for good. And now we pass the state info back and
> forth in a symbolic char which explains itself well instead.
>
> Signed-off-by: Ze Gao <zegao@tencent.com>

Thanks for the update!
Namhyung


> ---
>  tools/perf/builtin-sched.c | 46 +++++++++-----------------------------
>  1 file changed, 10 insertions(+), 36 deletions(-)
>
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index ced6fffe8110..42d5fc5d6b7b 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -92,13 +92,6 @@ struct sched_atom {
>         struct task_desc        *wakee;
>  };
>
> -#define TASK_STATE_TO_CHAR_STR "RSDTtXZPI"
> -
> -/* task state bitmask, copied from include/linux/sched.h */
> -#define TASK_RUNNING           0
> -#define TASK_INTERRUPTIBLE     1
> -#define TASK_UNINTERRUPTIBLE   2
> -
>  enum thread_state {
>         THREAD_SLEEPING =3D 0,
>         THREAD_WAIT_CPU,
> @@ -255,7 +248,7 @@ struct thread_runtime {
>         u64 total_preempt_time;
>         u64 total_delay_time;
>
> -       int last_state;
> +       char last_state;
>
>         char shortname[3];
>         bool comm_changed;
> @@ -425,7 +418,7 @@ static void add_sched_event_wakeup(struct perf_sched =
*sched, struct task_desc *t
>  }
>
>  static void add_sched_event_sleep(struct perf_sched *sched, struct task_=
desc *task,
> -                                 u64 timestamp, u64 task_state __maybe_u=
nused)
> +                                 u64 timestamp, const char task_state __=
maybe_unused)
>  {
>         struct sched_atom *event =3D get_new_event(task, timestamp);
>
> @@ -849,7 +842,7 @@ static int replay_switch_event(struct perf_sched *sch=
ed,
>                    *next_comm  =3D evsel__strval(evsel, sample, "next_com=
m");
>         const u32 prev_pid =3D evsel__intval(evsel, sample, "prev_pid"),
>                   next_pid =3D evsel__intval(evsel, sample, "next_pid");
> -       const u64 prev_state =3D evsel__intval(evsel, sample, "prev_state=
");
> +       const char prev_state =3D evsel__taskstate(evsel, sample, "prev_s=
tate");
>         struct task_desc *prev, __maybe_unused *next;
>         u64 timestamp0, timestamp =3D sample->time;
>         int cpu =3D sample->cpu;
> @@ -1039,13 +1032,6 @@ static int thread_atoms_insert(struct perf_sched *=
sched, struct thread *thread)
>         return 0;
>  }
>
> -static char sched_out_state(u64 prev_state)
> -{
> -       const char *str =3D TASK_STATE_TO_CHAR_STR;
> -
> -       return str[prev_state];
> -}
> -
>  static int
>  add_sched_out_event(struct work_atoms *atoms,
>                     char run_state,
> @@ -1121,7 +1107,7 @@ static int latency_switch_event(struct perf_sched *=
sched,
>  {
>         const u32 prev_pid =3D evsel__intval(evsel, sample, "prev_pid"),
>                   next_pid =3D evsel__intval(evsel, sample, "next_pid");
> -       const u64 prev_state =3D evsel__intval(evsel, sample, "prev_state=
");
> +       const char prev_state =3D evsel__taskstate(evsel, sample, "prev_s=
tate");
>         struct work_atoms *out_events, *in_events;
>         struct thread *sched_out, *sched_in;
>         u64 timestamp0, timestamp =3D sample->time;
> @@ -1157,7 +1143,7 @@ static int latency_switch_event(struct perf_sched *=
sched,
>                         goto out_put;
>                 }
>         }
> -       if (add_sched_out_event(out_events, sched_out_state(prev_state), =
timestamp))
> +       if (add_sched_out_event(out_events, prev_state, timestamp))
>                 return -1;
>
>         in_events =3D thread_atoms_search(&sched->atom_root, sched_in, &s=
ched->cmp_pid);
> @@ -2022,24 +2008,12 @@ static void timehist_header(struct perf_sched *sc=
hed)
>         printf("\n");
>  }
>
> -static char task_state_char(struct thread *thread, int state)
> -{
> -       static const char state_to_char[] =3D TASK_STATE_TO_CHAR_STR;
> -       unsigned bit =3D state ? ffs(state) : 0;
> -
> -       /* 'I' for idle */
> -       if (thread__tid(thread) =3D=3D 0)
> -               return 'I';
> -
> -       return bit < sizeof(state_to_char) - 1 ? state_to_char[bit] : '?'=
;
> -}
> -
>  static void timehist_print_sample(struct perf_sched *sched,
>                                   struct evsel *evsel,
>                                   struct perf_sample *sample,
>                                   struct addr_location *al,
>                                   struct thread *thread,
> -                                 u64 t, int state)
> +                                 u64 t, const char state)
>  {
>         struct thread_runtime *tr =3D thread__priv(thread);
>         const char *next_comm =3D evsel__strval(evsel, sample, "next_comm=
");
> @@ -2080,7 +2054,7 @@ static void timehist_print_sample(struct perf_sched=
 *sched,
>         print_sched_time(tr->dt_run, 6);
>
>         if (sched->show_state)
> -               printf(" %5c ", task_state_char(thread, state));
> +               printf(" %5c ", thread__tid(thread) =3D=3D 0 ? 'I' : stat=
e);
>
>         if (sched->show_next) {
>                 snprintf(nstr, sizeof(nstr), "next: %s[%d]", next_comm, n=
ext_pid);
> @@ -2152,9 +2126,9 @@ static void timehist_update_runtime_stats(struct th=
read_runtime *r,
>                 else if (r->last_time) {
>                         u64 dt_wait =3D tprev - r->last_time;
>
> -                       if (r->last_state =3D=3D TASK_RUNNING)
> +                       if (r->last_state =3D=3D 'R')
>                                 r->dt_preempt =3D dt_wait;
> -                       else if (r->last_state =3D=3D TASK_UNINTERRUPTIBL=
E)
> +                       else if (r->last_state =3D=3D 'D')
>                                 r->dt_iowait =3D dt_wait;
>                         else
>                                 r->dt_sleep =3D dt_wait;
> @@ -2579,7 +2553,7 @@ static int timehist_sched_change_event(struct perf_=
tool *tool,
>         struct thread_runtime *tr =3D NULL;
>         u64 tprev, t =3D sample->time;
>         int rc =3D 0;
> -       int state =3D evsel__intval(evsel, sample, "prev_state");
> +       const char state =3D evsel__taskstate(evsel, sample, "prev_state"=
);
>
>         addr_location__init(&al);
>         if (machine__resolve(machine, &al, sample) < 0) {
> --
> 2.41.0
>

