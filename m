Return-Path: <linux-kernel+bounces-164722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 943E48B81B0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 23:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3C0F1C223CC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28741A0B0E;
	Tue, 30 Apr 2024 21:00:24 +0000 (UTC)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C20B8F6E;
	Tue, 30 Apr 2024 21:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714510824; cv=none; b=J/GJ0ub136G/HBxiDyPkJit+GZV0NscIkOJSAbFbbsoE3lCFCtx1iJrhCj8sZcqWh0U41DvUtwrUlDm3bCdTyglwndGuBXN/vl0UHc6Uc/LB5GLfLP+MpUQuUlJ+N59E5lzhTuXSZdp8i+t86Zg+XFL0Lb6J++271qZCh1e05Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714510824; c=relaxed/simple;
	bh=zcbNgeImiQt8aRUifDGN4mFMrkWlHNmzjSo4AxTlRqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XRkWU9B1xRcc5CgBNprTX214cpYuYpNiHeOtvtWI8dhGe7nSEwgO6F1A7eCM/79QiJKMTH4ItEGPKt/oT7wDjUuw8PMKnVQuKmSvLEONPST4BtWFhE0w7gF1e/bE9D0/yffrvXumDgn3voV0gx2z+JRk6xm02WySLKB3iGF4BRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso4539669a12.0;
        Tue, 30 Apr 2024 14:00:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714510822; x=1715115622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4iKBByVjl8fozaqhR11zT2eh308X82b/Cs/F6vPGSKU=;
        b=OMMwmrJp6c+tu/Jya9SGAtNUhjbuC85euMCy9c2ZnjTLXke+z8WtwmhohnsYx5sEr5
         IzJzCZduDvmArJxDQD35vstnFjZDgtKImcAC+Ek9QMvA8oxDuQRfxHS/BIt4fEAkWIJI
         OmGIRe9YNlQFCe6xtVODlOn5UFVHcdL7jrK00eDTS++1MwBSQNl8eJKxrdwigK1V7PAQ
         VAbqepFUXV9hcnUYugYcqggC2FRPkRO7Yw0XqQy6wDNpJYtSRquQCR+Uq0eVmNokIXNl
         1xZ8tgwiTcqMDrlTvOjUuBClFzweA0XBY5D+YshCYA6ZdIVV2z4CHMWw3Lncz+pDDRTX
         uuvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXI1xRqSF8VPpoKSDX6yUVSEG+vs+VubcWeqauFoK/jduutIjYrrX82vANYacBUJCUkqWqicGzCvpMfyfzx3ynZBH8Ey4DljTTN4CVJE177PzGskVdpqx9HerVCZ1GDoj0162EK/2hWdBJpMllYqA==
X-Gm-Message-State: AOJu0Yw0WfqoR5jeP10ZW93RB+ROLLps/LfxkDomyYC2IaFFv7Skd9Qd
	slrn6LWsmmFAzWbiD2Zfbb3e2hBNoDYiGLbqSaIiOP7GjSwn90hAxBG5KPfEjwd4VCuBKPnrPwW
	TYuGyaS0ZioR/8QbG7vd5hFcRz0s=
X-Google-Smtp-Source: AGHT+IFMOM//Pe1ySWf1xdgbZLWkFEyTF0/Q2dEiIvS9SSAADa8Qupj63Yj5pfecMaFZP51tO4t7eoNKYx21+EWe38M=
X-Received: by 2002:a17:90b:50cc:b0:2ad:da23:da0b with SMTP id
 sb12-20020a17090b50cc00b002adda23da0bmr738146pjb.34.1714510821219; Tue, 30
 Apr 2024 14:00:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240428053616.1125891-1-irogers@google.com> <20240428053616.1125891-4-irogers@google.com>
 <CAM9d7cgzTsfk3C+dTN80f5FhB1rmfturjuUUwvSTeUvny5eWKw@mail.gmail.com> <CAP-5=fU-XaA=NB8hpWZjUcUrP5D96rKqSJ5SW2a4BX6k+606_Q@mail.gmail.com>
In-Reply-To: <CAP-5=fU-XaA=NB8hpWZjUcUrP5D96rKqSJ5SW2a4BX6k+606_Q@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 30 Apr 2024 14:00:10 -0700
Message-ID: <CAM9d7chsHcA4v=gthyD79aPyhsFhOXZs1-c8+J1Sc7JWG_9oAg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/3] perf evsel: Add retirement latency event support
To: Ian Rogers <irogers@google.com>
Cc: weilin.wang@intel.com, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Ze Gao <zegao2021@gmail.com>, Leo Yan <leo.yan@linux.dev>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Song Liu <song@kernel.org>, James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 8:27=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Mon, Apr 29, 2024 at 2:31=E2=80=AFPM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > On Sat, Apr 27, 2024 at 10:36=E2=80=AFPM Ian Rogers <irogers@google.com=
> wrote:
> > >
> > > When a retirement latency event is processed it sets a flag on the
> > > evsel. This change makes it so that when the flag is set evsel
> > > opening, reading and exiting report values from child perf record and
> > > perf report processes.
> > >
> > > Something similar was suggested by Namhyung Kim in:
> > > https://lore.kernel.org/lkml/CAM9d7cgdQQn5GYB7t++xuoMdeqPXiEkkcop69+r=
D06RAnu9-EQ@mail.gmail.com/
> > >
> > > This is trying to add support for retirement latency directly in
> > > events rather than through metric changes, as suggested by Weilin Wan=
g in:
> > > https://lore.kernel.org/lkml/20240402214436.1409476-1-weilin.wang@int=
el.com/
> >
> > This seems to create perf record + report pair for each R event
> > while Weilin's patch handled multiple events at once.
>
> Some issues with this change:
>  -  perf stat treats any SIGCHLD to the parent as the workload
> completing. Properly supporting child processes means perhaps using
> sigaction and detecting the child process that terminates. As
> evsel__read_counter sends a kill it triggers the SIGCHLD that ends
> perf stat and thereby breaking interval mode.

Right, the interval mode is tricky to support.

>  - there's a pair of processes per-CPU so that per-CPU mode is
> supported. Ideally we'd start a single process and read every CPU in
> that process in one go, then the evsel__read_counter code would read
> each CPU's count at once.

Also if there're more than one events.

>  - record/report restarts happen on each evsel__read_counter as there
> doesn't seem to be enough functionality in control-fds to  do a
> periodic dumping.

Hmm.. maybe something like perf top.

>  - the evsel__open_cpu has a "sleep 0.1" workload to avoid gathering
> too many samples and overloading the perf report process.

Yeah, maybe with a lower frequency too.

>  - there's no way to disable the dummy event in perf record, even
> though all we want is one field out of retirement latency samples.

Right, in this case we don't care about the sideband events.

>
> Given fixing all of these would be a lot of work, I think it is
> similar or less work to just directly read the retirement latency from
> events in perf stat. Making perf stat allow events that have a
> sampling buffer is troublesome not least as the mmaps are associated
> with the evlist:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/t=
ools/perf/util/evlist.h#n65
> and so the evlist code assumes every evsel is sampling.
>
> Given all of this, I think these patches are a quick way to add the
> retirement latency support and then proper sampling support in `perf
> stat` can be worked on next to lower the overhead.

Ok, one more thing I asked to Weilin is documentation.
I don't think we all clearly understand what is TPEBS and
why do want to do this stuff.  Writing down the situation
would help others (including future me) understand the
problem and current solution.

Thanks,
Namhyung


>
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/util/evsel.c | 186 ++++++++++++++++++++++++++++++++++++++=
+-
> > >  tools/perf/util/evsel.h |   3 +
> > >  2 files changed, 188 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > > index a0a8aee7d6b9..17c123cddde3 100644
> > > --- a/tools/perf/util/evsel.c
> > > +++ b/tools/perf/util/evsel.c
> > > @@ -22,6 +22,7 @@
> > >  #include <sys/resource.h>
> > >  #include <sys/types.h>
> > >  #include <dirent.h>
> > > +#include <signal.h>
> > >  #include <stdlib.h>
> > >  #include <perf/evsel.h>
> > >  #include "asm/bug.h"
> > > @@ -58,6 +59,7 @@
> > >  #include <internal/xyarray.h>
> > >  #include <internal/lib.h>
> > >  #include <internal/threadmap.h>
> > > +#include <subcmd/run-command.h>
> > >
> > >  #include <linux/ctype.h>
> > >
> > > @@ -493,6 +495,162 @@ struct evsel *evsel__newtp_idx(const char *sys,=
 const char *name, int idx)
> > >  }
> > >  #endif
> > >
> > > +static int evsel__start_retire_latency_cpu(struct evsel *evsel, stru=
ct perf_cpu_map *cpus,
> > > +                                         int cpu_map_idx)
> > > +{
> > > +       char buf[16];
> > > +       int pipefd[2];
> > > +       int err, i;
> > > +       struct perf_cpu cpu =3D perf_cpu_map__cpu(cpus, cpu_map_idx);
> > > +       struct child_process *child_record =3D
> > > +               xyarray__entry(evsel->children, cpu_map_idx, 0);
> > > +       struct child_process *child_report =3D
> > > +               xyarray__entry(evsel->children, cpu_map_idx, 1);
> > > +       char *event =3D strdup(evsel__name(evsel));
> > > +       /* TODO: the dummy event also won't be used, but there's no o=
ption to disable. */
> > > +       const char *record_argv[15] =3D {
> > > +               [0] =3D "perf",
> > > +               [1] =3D "record",
> > > +               [2] =3D "--synth=3Dno",
> > > +               [3] =3D "--no-bpf-event",
> > > +               [4] =3D "-W",
> > > +               [5] =3D "-o",
> > > +               [6] =3D "-",
> > > +               [7] =3D "-e",
> > > +       };
> > > +       const char *report_argv[] =3D {
> > > +               [0] =3D "perf",
> > > +               [1] =3D "report",
> > > +               [2] =3D "-i",
> > > +               [3] =3D "-",
> > > +               [4] =3D "-q",
> > > +               [5] =3D "-F",
> > > +               [6] =3D "retire_lat",
> > > +               NULL,
> > > +       };
> > > +
> > > +       if (evsel->core.attr.sample_period) /* no sampling */
> > > +               return -EINVAL;
> > > +
> > > +       if (!event)
> > > +               return -ENOMEM;
> > > +
> > > +       /* Change the R modifier to the maximum precision one. */
> > > +       for (i =3D strlen(event) - 1; i > 0; i--) {
> > > +               if (event[i] =3D=3D 'R')
> > > +                       break;
> > > +               if (event[i] =3D=3D ':' || event[i] =3D=3D '/')
> > > +                       i =3D 0;
> > > +       }
> > > +       if (i <=3D 0) {
> > > +               pr_err("Expected retired latency 'R'\n");
> > > +               return -EINVAL;
> > > +       }
> > > +       event[i] =3D 'P';
> > > +
> > > +       i =3D 8;
> > > +       record_argv[i++] =3D event;
> > > +       if (verbose) {
> > > +               record_argv[i++] =3D verbose > 1 ? "-vv" : "-v";
> > > +       }
> > > +       if (cpu.cpu >=3D 0) {
> > > +               record_argv[i++] =3D "-C";
> > > +               snprintf(buf, sizeof(buf), "%d", cpu.cpu);
> > > +               record_argv[i++] =3D buf;
> > > +       } else {
> > > +               record_argv[i++] =3D "-a";
> > > +       }
> > > +       /* TODO: use something like the control fds to control perf r=
ecord behavior. */
> > > +       record_argv[i++] =3D "sleep";
> > > +       record_argv[i++] =3D "0.1";
> >
> > This might be too short and the record process can exit
> > before perf report (but I guess it's fine when using a pipe).
> > Also I'm not sure if it's ok to get the retire latency of 100 ms
> > regardless of the execution of the given workload.
>
> Ack. As said above, I think the correct longer term thing is to remove
> the forked processes.
>
> > > +
> > > +       if (pipe(pipefd) < 0) {
> > > +               free(event);
> > > +               return -errno;
> > > +       }
> > > +
> > > +       child_record->argv =3D record_argv;
> > > +       child_record->pid =3D -1;
> > > +       child_record->no_stdin =3D 1;
> > > +       if (verbose)
> > > +               child_record->err =3D fileno(stderr);
> > > +       else
> > > +               child_record->no_stderr =3D 1;
> > > +       child_record->out =3D pipefd[1];
> > > +       err =3D start_command(child_record);
> > > +       free(event);
> > > +       if (err)
> > > +               return err;
> > > +
> > > +       child_report->argv =3D report_argv;
> > > +       child_report->pid =3D -1;
> > > +       if (verbose)
> > > +               child_report->err =3D fileno(stderr);
> > > +       else
> > > +               child_report->no_stderr =3D 1;
> > > +       child_report->in =3D pipefd[0];
> > > +       child_report->out =3D -1;
> > > +       return start_command(child_report);
> > > +}
> > > +
> > > +static int evsel__finish_retire_latency_cpu(struct evsel *evsel, int=
 cpu_map_idx)
> > > +{
> > > +       struct child_process *child_record =3D
> > > +               xyarray__entry(evsel->children, cpu_map_idx, 0);
> > > +       struct child_process *child_report =3D
> > > +               xyarray__entry(evsel->children, cpu_map_idx, 1);
> > > +
> > > +       if (child_record->pid > 0)
> > > +               finish_command(child_record);
> > > +       if (child_report->pid > 0)
> > > +               finish_command(child_report);
> > > +       return 0;
> > > +}
> > > +
> > > +static int evsel__read_retire_latency(struct evsel *evsel, int cpu_m=
ap_idx, int thread)
> > > +{
> > > +       struct child_process *child_record =3D xyarray__entry(evsel->=
children, cpu_map_idx, 0);
> > > +       struct child_process *child_report =3D xyarray__entry(evsel->=
children, cpu_map_idx, 1);
> > > +       struct perf_counts_values *count =3D perf_counts(evsel->count=
s, cpu_map_idx, thread);
> > > +       char buf[256];
> > > +       int err;
> > > +
> > > +       kill(child_record->pid, SIGTERM);
> > > +       err =3D read(child_report->out, buf, sizeof(buf));
> > > +       if (err < 0 || strlen(buf) =3D=3D 0)
> > > +               return -1;
> > > +
> > > +       count->val =3D atoll(buf);
> > > +       count->ena =3D 1;
> > > +       count->run =3D 1;
> > > +       count->id =3D 0;
> > > +       count->lost =3D 0;
> > > +
> > > +       /*
> > > +        * TODO: The SIGCHLD from the children exiting will cause int=
erval mode
> > > +        *       to stop, use the control fd to avoid this.
> > > +        */
> > > +       err =3D evsel__finish_retire_latency_cpu(evsel, cpu_map_idx);
> > > +       if (err)
> > > +               return err;
> > > +
> > > +       /* Restart the counter. */
> > > +       return evsel__start_retire_latency_cpu(evsel, evsel->core.cpu=
s, cpu_map_idx);
> >
> > Is this for the interval mode?  Then I think it's better to move the
> > logic there and let this code just do the 'read'.
>
> For encapsulation's sake I'm trying to make it so that we don't put
> event reading logic into perf stat. perf stat just makes
> counters/evsels and asks the code to read them. Behind the scenes we
> do things like this, reading /proc for tool events, potentially other
> things for hwmon, etc. We should be able to update event parsing and
> evsel and from this get support for a new counter type - is my hope.
>
> >
> > > +}
> > > +
> > > +static int evsel__finish_retire_latency(struct evsel *evsel)
> > > +{
> > > +       int idx;
> > > +
> > > +       perf_cpu_map__for_each_idx(idx, evsel->core.cpus) {
> > > +               int err =3D evsel__finish_retire_latency_cpu(evsel, i=
dx);
> > > +
> > > +               if (err)
> > > +                       return err;
> > > +       }
> > > +       return 0;
> > > +}
> > > +
> > >  const char *const evsel__hw_names[PERF_COUNT_HW_MAX] =3D {
> > >         "cycles",
> > >         "instructions",
> > > @@ -1465,6 +1623,10 @@ static void evsel__free_config_terms(struct ev=
sel *evsel)
> > >
> > >  void evsel__exit(struct evsel *evsel)
> > >  {
> > > +       if (evsel->children) {
> > > +               evsel__finish_retire_latency(evsel);
> > > +               zfree(&evsel->children);
> >
> > You'd better call xyarray__delete() and set it to NULL.
>
> Okay.
>
> Thanks,
> Ian
>
> > Thanks,
> > Namhyung
> >
> > > +       }
> > >         assert(list_empty(&evsel->core.node));
> > >         assert(evsel->evlist =3D=3D NULL);
> > >         bpf_counter__destroy(evsel);
> > > @@ -1778,6 +1940,9 @@ int evsel__read_counter(struct evsel *evsel, in=
t cpu_map_idx, int thread)
> > >         if (evsel__is_tool(evsel))
> > >                 return evsel__read_tool(evsel, cpu_map_idx, thread);
> > >
> > > +       if (evsel->retire_lat)
> > > +               return evsel__read_retire_latency(evsel, cpu_map_idx,=
 thread);
> > > +
> > >         if (evsel->core.attr.read_format & PERF_FORMAT_GROUP)
> > >                 return evsel__read_group(evsel, cpu_map_idx, thread);
> > >
> > > @@ -1993,10 +2158,22 @@ static int __evsel__prepare_open(struct evsel=
 *evsel, struct perf_cpu_map *cpus,
> > >                 threads =3D empty_thread_map;
> > >         }
> > >
> > > -       if (evsel->core.fd =3D=3D NULL &&
> > > +       if (!evsel->retire_lat && evsel->core.fd =3D=3D NULL &&
> > >             perf_evsel__alloc_fd(&evsel->core, perf_cpu_map__nr(cpus)=
, nthreads) < 0)
> > >                 return -ENOMEM;
> > >
> > > +       if (evsel->retire_lat && evsel->children =3D=3D NULL) {
> > > +               /*
> > > +                * Use ylen of 2, [0] is the record and [1] is the re=
port
> > > +                * command. Currently retirement latency doesn't supp=
ort
> > > +                * per-thread mode.
> > > +                */
> > > +               evsel->children =3D xyarray__new(perf_cpu_map__nr(cpu=
s), /*ylen=3D*/2,
> > > +                                       sizeof(struct child_process))=
;
> > > +               if (!evsel->children)
> > > +                       return -ENOMEM;
> > > +       }
> > > +
> > >         evsel->open_flags =3D PERF_FLAG_FD_CLOEXEC;
> > >         if (evsel->cgrp)
> > >                 evsel->open_flags |=3D PERF_FLAG_PID_CGROUP;
> > > @@ -2209,6 +2386,13 @@ static int evsel__open_cpu(struct evsel *evsel=
, struct perf_cpu_map *cpus,
> > >
> > >         for (idx =3D start_cpu_map_idx; idx < end_cpu_map_idx; idx++)=
 {
> > >
> > > +               if (evsel->retire_lat) {
> > > +                       err =3D evsel__start_retire_latency_cpu(evsel=
, cpus, idx);
> > > +                       if (err)
> > > +                               goto out_close;
> > > +                       continue;
> > > +               }
> > > +
> > >                 for (thread =3D 0; thread < nthreads; thread++) {
> > >                         int fd, group_fd;
> > >  retry_open:
> > > diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> > > index bd8e84954e34..3c0806436e64 100644
> > > --- a/tools/perf/util/evsel.h
> > > +++ b/tools/perf/util/evsel.h
> > > @@ -177,6 +177,9 @@ struct evsel {
> > >         __u64 start_time;
> > >         /* Is the tool's fd for /proc/pid/stat or /proc/stat. */
> > >         bool pid_stat;
> > > +
> > > +       /* Used for retire_lat child process. */
> > > +       struct xyarray *children;
> > >  };
> > >
> > >  struct perf_missing_features {
> > > --
> > > 2.44.0.769.g3c40516874-goog
> > >

