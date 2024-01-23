Return-Path: <linux-kernel+bounces-34528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BE7837E04
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E1C11C2612C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DC056755;
	Tue, 23 Jan 2024 00:38:17 +0000 (UTC)
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AD24E1D0;
	Tue, 23 Jan 2024 00:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970297; cv=none; b=qnJ4/RoWjssXbBv0jdp2+ItE52VNP02PQkKVvqjSjd+tbNhH1BvKjpDs1GesRg6CfHvZKN/A5HXd/EIerYD/kHk73x3X52zfRAQBQieTNZTg85BISfatgf3YeDUcs+XWE5Z0zCNMp11MFmGnm099hkhA1M53Um+MPzWEt+M5H58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970297; c=relaxed/simple;
	bh=1f6ds+PzqCOuGKAn4vCGEwmO9VbdsXZdA+pxwer+96c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tw1YLlrc0pk/t9mfwEQwpzsNoPxtecjBgMcuusxlRsHrwYGp5Ri8vhiVLfyT1QWqnN4+h+Dp1GPJuES0ev0T991uaqCliYfwb3r7zZNWHVgid/jvY88rc8jHqWckMppcPHEAH+isvztAjnMv53RSwLHjrMy0qnB4qeLJc6BEWXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-595ac2b6c59so2455150eaf.2;
        Mon, 22 Jan 2024 16:38:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970294; x=1706575094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7pFnzcW0cMQ5USerji8uEumVMyt2s6WDXvMVlGp/NTc=;
        b=Q2Tam5jq0mDoGIok7qMHxQrsvun978c2xVy5W5Qb/SSYgo5LTKZba0tm3bpBQUrabM
         8d//ltBSpZmSGwsnJlK6UPLxNvRM+EU000EPPpDOcRN3F5+g164qu1Ev/4aDYEH9ZXKc
         d+YyrygsFGaJBCGyhMbIG4KQFXfMVkZoi5aBDTTepNUQCCs/tba4vfnd73HY2gNdMQts
         8NAPF8No+zZrvTij4h+DdxtpffMkQCAn6gga2p+QtUwFeRo0D8pqpqmWuzu1QUpUhsOz
         dOdBPIKy8nYklgnglGz9NlGnxmP/1V1c+xYlZqhddbmNBe9KEAb28ebNY7diwyuJDr6A
         Z3vA==
X-Gm-Message-State: AOJu0Yyu/Avf6JvDT2VMQOzmobJfUk687FOIQv4a1vIwX6x3hNXf9fkL
	8yr9GMOou+Rz218sNRoV7mOGJoXj+R7oN8uvpvlJtG8xipuKHwqeeCb9lqUcs+UmPpZS61PiHqp
	JFZaBPRBdErcAEeiSi+3vwLRpxb0=
X-Google-Smtp-Source: AGHT+IFgbYCDKFVyj17JxJqJ0bt5MEN3Rp6fBSDs193Kx6Eh/ELM074Qbj4qiswwpUtK9QkPhNNoaog6hOPEeIin/Nk=
X-Received: by 2002:a05:6358:9141:b0:175:c16b:126f with SMTP id
 r1-20020a056358914100b00175c16b126fmr3726702rwr.56.1705970294244; Mon, 22 Jan
 2024 16:38:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122070859.1394479-2-zegao@tencent.com> <20240122070859.1394479-6-zegao@tencent.com>
In-Reply-To: <20240122070859.1394479-6-zegao@tencent.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 22 Jan 2024 16:38:03 -0800
Message-ID: <CAM9d7cjWdZa9oh-6CmydvtzOEkkWMip8yfxTS4L_PZnq4K7B1w@mail.gmail.com>
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

Hello,

On Sun, Jan 21, 2024 at 11:11=E2=80=AFPM Ze Gao <zegao2021@gmail.com> wrote=
:
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
> ---
>  tools/perf/builtin-sched.c | 46 +++++++++-----------------------------
>  1 file changed, 10 insertions(+), 36 deletions(-)
>
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index ced6fffe8110..f1d62f6b6cab 100644
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
> +               printf(" %5c ", thread->tid =3D=3D 0 ? 'I' : state);

This resulted in a build error with reference count checker.

  $ make EXTRA_CFLAGS=3D-DREFCNT_CHECKING=3D1
  ...
  builtin-sched.c: In function =E2=80=98timehist_print_sample=E2=80=99:
  builtin-sched.c:2057:39: error: =E2=80=98struct thread=E2=80=99 has no me=
mber named =E2=80=98tid=E2=80=99
   2057 |                 printf(" %5c ", thread->tid =3D=3D 0 ? 'I' : stat=
e);
        |

The struct thread is protected by the refcount checker so
you should not access the members directly.  Instead,
please use a help function like thread__tid().

Thanks,
Namhyung

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

