Return-Path: <linux-kernel+bounces-163033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 931C78B63F2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 23:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EA5A1F21ECB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EB2178CCF;
	Mon, 29 Apr 2024 21:00:49 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5111779AB;
	Mon, 29 Apr 2024 21:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714424448; cv=none; b=F8PbtyEEDWJ01dIhcLeXbrbc1DgFLg22hUCgaYXPTQfIydqWNThDpK3KeF6gywMqzjRNbiCTgniLUSAay+3Urx4AuVLZ6YyvenqbnczBAmUi4kSVj1ndMyfP9ScSm1ndbDPjIm5Y9nMbMvCzxv4SgNSgGFTcJkzGB8dL2JUnUSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714424448; c=relaxed/simple;
	bh=TcYjIp7CGO/N6Q52eKL5QC/QIi1BiBttmQzKBNSZksI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i3w4By9oAWi743uQOva/6M7y92WzSiR14iPgVmkcR9xvLV6rrHWIBlmLiyoCsxb4dYnCzCUhDL6tsY4JMkE0HaBi4l3LVu7UNJ8gYE87/vpe0E8BHUdV51XNXyImFQ5axkn17NjuEtoZmMDlsMqj0GbHcGhhX89lF6bdcDzSoEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e3c9300c65so41334305ad.0;
        Mon, 29 Apr 2024 14:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714424446; x=1715029246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3S4nUTjyAdXF8X+AVx6tRPEkm3T5UgsUtuyOqLwCPms=;
        b=hgTh8sJL2x/Jpk/qrNM3KEBVlJaR4tSUwt/GqLB8CBB7CqE6KsDdUqOGIdB8K7xmwA
         mXTqDKesiC4r9CN9mCvFM+VH6zBPcgtgX9aJGs4paOGA8TQsrVYc3Sbd00j7oGcJnkaq
         Mju07aMTtyZ1gI+WYGKTwJFIixhe+8u58SpJggWj5AbitbDLgwJwUlVLwGVMOQcQEbC3
         3KojeBkrpruvp0qUUbyffzHrPPn8Ory+PZjOr9jp729UBt5tKhXXQoDrixma+sLw/0Wu
         G+TpMjiwd72jnhNLwAiXcOlAYX8dDpmZTYdsupwFXMJaRW04xBsR8QSuStpDVBCVp/HV
         UGfg==
X-Forwarded-Encrypted: i=1; AJvYcCWFa/f/HA3lNRkWdBugNBRW5fWGD9WERwkYJGm3dX/KmQanR4a8rGZaQupwc92aymTuvXNcbEPGZv/jEhlJkC7lS6i47GSpVODxyhKANTAu0zHOZJ05wykcFg99hHshc5BIPGY42of9AEvU7pl8CA==
X-Gm-Message-State: AOJu0YzFDnvRdhS168smGeOqN41z53oH2MNYh/ntelJycgeeL60N5Sli
	zgmS9sGdyhEJBkR9o4FKtURiDW033s+BSs6SAa5DlOsZgkAwc8b/RPBsnBK4PDGCxZqpZPO+yxM
	Bu4xZOMESSo9kC6i5gcxDfQ0Ye6Y=
X-Google-Smtp-Source: AGHT+IHhV3SiYvQW+miU73izfYAs/U5Z5pIROm4Zor3sxof7zCpL/bQbW+Dqy67ulKrJvmcUW6FdIQzbtTpu2XPqasA=
X-Received: by 2002:a17:903:1c4:b0:1e3:c5d0:9fb8 with SMTP id
 e4-20020a17090301c400b001e3c5d09fb8mr13986360plh.42.1714424446174; Mon, 29
 Apr 2024 14:00:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240428053616.1125891-1-irogers@google.com> <20240428053616.1125891-2-irogers@google.com>
In-Reply-To: <20240428053616.1125891-2-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 29 Apr 2024 14:00:34 -0700
Message-ID: <CAM9d7cjX_5SS=JGnjMLxG3fcReyuhUoJQacKVsBtcW2ngD06sw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/3] perf evsel: Refactor tool events
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

Hi Ian,

On Sat, Apr 27, 2024 at 10:36=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> Tool events unnecessarily open a dummy perf event which is useless
> even with `perf record` which will still open a dummy event. Change
> the behavior of tool events so:

Right, I was surprised that we need a dummy event for that.

>
>  - duration_time - call `rdclock` on open and then report the count as
>    a delta since the start in evsel__read_counter. This moves code out
>    of builtin-stat making it more general purpose.
>
>  - user_time/system_time - open the fd as either `/proc/pid/stat` or
>    `/proc/stat` for cases like system wide. evsel__read_counter will
>    read the appropriate field out of the procfs file. These values
>    were previously supplied by wait4, if the procfs read fails then
>    the wait4 values are used, assuming the process/thread terminated.
>    By reading user_time and system_time this way, interval mode can be
>    supported.

Good improvement!

>
> Opening any of the tool events for `perf record` returns invalid.

Ok, I think those tool events are for `perf stat` only.

But I feel like this change is a separate optimization and can be
independently submitted (from the retire-latency or tPEBS change).

>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-stat.c |  74 ++++++-------
>  tools/perf/util/evsel.c   | 223 +++++++++++++++++++++++++++++++++++++-
>  tools/perf/util/evsel.h   |   6 +
>  3 files changed, 259 insertions(+), 44 deletions(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 65a3dd7ffac3..428e9721b908 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -255,45 +255,37 @@ static int evsel__write_stat_event(struct evsel *co=
unter, int cpu_map_idx, u32 t
>                                            process_synthesized_event, NUL=
L);
>  }
>
> -static int read_single_counter(struct evsel *counter, int cpu_map_idx,
> -                              int thread, struct timespec *rs)
> -{
> -       switch(counter->tool_event) {
> -               case PERF_TOOL_DURATION_TIME: {
> -                       u64 val =3D rs->tv_nsec + rs->tv_sec*1000000000UL=
L;
> -                       struct perf_counts_values *count =3D
> -                               perf_counts(counter->counts, cpu_map_idx,=
 thread);
> -                       count->ena =3D count->run =3D val;
> -                       count->val =3D val;
> -                       return 0;
> -               }
> -               case PERF_TOOL_USER_TIME:
> -               case PERF_TOOL_SYSTEM_TIME: {
> -                       u64 val;
> -                       struct perf_counts_values *count =3D
> -                               perf_counts(counter->counts, cpu_map_idx,=
 thread);
> -                       if (counter->tool_event =3D=3D PERF_TOOL_USER_TIM=
E)
> -                               val =3D ru_stats.ru_utime_usec_stat.mean;
> -                       else
> -                               val =3D ru_stats.ru_stime_usec_stat.mean;
> -                       count->ena =3D count->run =3D val;
> -                       count->val =3D val;
> -                       return 0;
> -               }
> -               default:
> -               case PERF_TOOL_NONE:
> -                       return evsel__read_counter(counter, cpu_map_idx, =
thread);
> -               case PERF_TOOL_MAX:
> -                       /* This should never be reached */
> -                       return 0;
> +static int read_single_counter(struct evsel *counter, int cpu_map_idx, i=
nt thread)
> +{
> +       int err =3D evsel__read_counter(counter, cpu_map_idx, thread);
> +
> +       /*
> +        * Reading user and system time will fail when the process
> +        * terminates. Use the wait4 values in that case.
> +        */
> +       if (err &&
> +           (counter->tool_event =3D=3D PERF_TOOL_USER_TIME ||
> +            counter->tool_event =3D=3D PERF_TOOL_SYSTEM_TIME)) {

Off-topic.  I feel like we should have a (fake) pmu for the tool events
rather than the evsel->tool_event enum.


> +               u64 val;
> +               struct perf_counts_values *count =3D
> +                       perf_counts(counter->counts, cpu_map_idx, thread)=
;
> +
> +               if (counter->tool_event =3D=3D PERF_TOOL_USER_TIME)
> +                       val =3D ru_stats.ru_utime_usec_stat.mean;
> +               else
> +                       val =3D ru_stats.ru_stime_usec_stat.mean;
> +               count->ena =3D count->run =3D val;
> +               count->val =3D val;
> +               return 0;
>         }
> +       return err;
>  }
>
>  /*
>   * Read out the results of a single counter:
>   * do not aggregate counts across CPUs in system-wide mode
>   */
> -static int read_counter_cpu(struct evsel *counter, struct timespec *rs, =
int cpu_map_idx)
> +static int read_counter_cpu(struct evsel *counter, int cpu_map_idx)
>  {
>         int nthreads =3D perf_thread_map__nr(evsel_list->core.threads);
>         int thread;
> @@ -311,7 +303,7 @@ static int read_counter_cpu(struct evsel *counter, st=
ruct timespec *rs, int cpu_
>                  * (via evsel__read_counter()) and sets their count->load=
ed.
>                  */
>                 if (!perf_counts__is_loaded(counter->counts, cpu_map_idx,=
 thread) &&
> -                   read_single_counter(counter, cpu_map_idx, thread, rs)=
) {
> +                   read_single_counter(counter, cpu_map_idx, thread)) {
>                         counter->counts->scaled =3D -1;
>                         perf_counts(counter->counts, cpu_map_idx, thread)=
->ena =3D 0;
>                         perf_counts(counter->counts, cpu_map_idx, thread)=
->run =3D 0;
> @@ -340,7 +332,7 @@ static int read_counter_cpu(struct evsel *counter, st=
ruct timespec *rs, int cpu_
>         return 0;
>  }
>
> -static int read_affinity_counters(struct timespec *rs)
> +static int read_affinity_counters(void)
>  {
>         struct evlist_cpu_iterator evlist_cpu_itr;
>         struct affinity saved_affinity, *affinity;
> @@ -361,10 +353,8 @@ static int read_affinity_counters(struct timespec *r=
s)
>                 if (evsel__is_bpf(counter))
>                         continue;
>
> -               if (!counter->err) {
> -                       counter->err =3D read_counter_cpu(counter, rs,
> -                                                       evlist_cpu_itr.cp=
u_map_idx);
> -               }
> +               if (!counter->err)
> +                       counter->err =3D read_counter_cpu(counter, evlist=
_cpu_itr.cpu_map_idx);
>         }
>         if (affinity)
>                 affinity__cleanup(&saved_affinity);
> @@ -388,11 +378,11 @@ static int read_bpf_map_counters(void)
>         return 0;
>  }
>
> -static int read_counters(struct timespec *rs)
> +static int read_counters(void)
>  {
>         if (!stat_config.stop_read_counter) {
>                 if (read_bpf_map_counters() ||
> -                   read_affinity_counters(rs))
> +                   read_affinity_counters())
>                         return -1;
>         }
>         return 0;
> @@ -423,7 +413,7 @@ static void process_interval(void)
>
>         evlist__reset_aggr_stats(evsel_list);
>
> -       if (read_counters(&rs) =3D=3D 0)
> +       if (read_counters() =3D=3D 0)
>                 process_counters();
>
>         if (STAT_RECORD) {
> @@ -911,7 +901,7 @@ static int __run_perf_stat(int argc, const char **arg=
v, int run_idx)
>          * avoid arbitrary skew, we must read all counters before closing=
 any
>          * group leaders.
>          */
> -       if (read_counters(&(struct timespec) { .tv_nsec =3D t1-t0 }) =3D=
=3D 0)
> +       if (read_counters() =3D=3D 0)
>                 process_counters();
>
>         /*

I think this part can be a separate commit.  You can implement the
tool event handling before actually using it. :)


> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 3536404e9447..a0a8aee7d6b9 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -10,6 +10,7 @@
>  #include <errno.h>
>  #include <inttypes.h>
>  #include <linux/bitops.h>
> +#include <api/io.h>
>  #include <api/fs/fs.h>
>  #include <api/fs/tracing_path.h>
>  #include <linux/hw_breakpoint.h>
> @@ -30,6 +31,7 @@
>  #include "counts.h"
>  #include "event.h"
>  #include "evsel.h"
> +#include "time-utils.h"
>  #include "util/env.h"
>  #include "util/evsel_config.h"
>  #include "util/evsel_fprintf.h"
> @@ -1600,11 +1602,183 @@ static int evsel__read_group(struct evsel *leade=
r, int cpu_map_idx, int thread)
>         return evsel__process_group_data(leader, cpu_map_idx, thread, dat=
a);
>  }
>
> +static int read_stat_field(int fd, struct perf_cpu cpu, int field, __u64=
 *val)
> +{
> +       char buf[256];
> +       struct io io;
> +       int c, i;
> +
> +       io__init(&io, fd, buf, sizeof(buf));
> +
> +       /* Skip lines to relevant CPU. */
> +       for (i =3D -1; i < cpu.cpu; i++) {
> +               do {
> +                       c =3D io__get_char(&io);
> +                       if (c =3D=3D -1)
> +                               return -EINVAL;
> +               } while (c !=3D '\n');
> +       }
> +       /* Skip to "cpu". */
> +       c =3D io__get_char(&io);
> +       if (c !=3D 'c')
> +               return -EINVAL;
> +       c =3D io__get_char(&io);
> +       if (c !=3D 'p')
> +               return -EINVAL;
> +       c =3D io__get_char(&io);
> +       if (c !=3D 'u')
> +               return -EINVAL;
> +       /* Skip N of cpuN. */
> +       do {
> +               c =3D io__get_char(&io);
> +               if (c =3D=3D -1)
> +                       return -EINVAL;
> +       } while (c !=3D ' ');
> +
> +       i =3D 1;
> +       while (true) {
> +               c =3D io__get_dec(&io, val);
> +               if (c !=3D ' ')
> +                       break;
> +               if (field =3D=3D i)
> +                       return 0;
> +               i++;
> +       }
> +       return -EINVAL;
> +}

Looks somewhat verbose, can we have something like
io__get_str_field() or io__get_num_filed()?


> +
> +static int read_pid_stat_field(int fd, int field, __u64 *val)
> +{
> +       char buf[256];
> +       struct io io;
> +       int c, i;
> +
> +       io__init(&io, fd, buf, sizeof(buf));
> +       c =3D io__get_dec(&io, val);
> +       if (c !=3D ' ')
> +               return -EINVAL;
> +       if (field =3D=3D 1)
> +               return 0;
> +
> +       /* Skip comm. */
> +       c =3D io__get_char(&io);
> +       if (c !=3D '(')
> +               return -EINVAL;
> +       do {
> +               c =3D io__get_char(&io);
> +               if (c =3D=3D -1)
> +                       return -EINVAL;
> +       } while (c !=3D ')');
> +       if (field =3D=3D 2)
> +               return -EINVAL;
> +
> +       /* Skip state */
> +       c =3D io__get_char(&io);
> +       if (c !=3D ' ')
> +               return -EINVAL;
> +       c =3D io__get_char(&io);
> +       if (c =3D=3D -1)
> +               return -EINVAL;
> +       if (field =3D=3D 3)
> +               return -EINVAL;
> +
> +       /* Loop over numeric fields*/
> +       c =3D io__get_char(&io);
> +       if (c !=3D ' ')
> +               return -EINVAL;
> +
> +       i =3D 4;
> +       while (true) {
> +               c =3D io__get_dec(&io, val);
> +               if (c =3D=3D -1)
> +                       return -EINVAL;
> +               if (c =3D=3D -2) {
> +                       /* Assume a -ve was read */
> +                       c =3D io__get_dec(&io, val);
> +                       *val *=3D -1;
> +               }
> +               if (c !=3D ' ')
> +                       return -EINVAL;
> +               if (field =3D=3D i)
> +                       return 0;
> +               i++;
> +       }
> +       return -EINVAL;
> +}
> +
> +static int evsel__read_tool(struct evsel *evsel, int cpu_map_idx, int th=
read)
> +{
> +       __u64 cur_time, delta_start;
> +       int fd, err =3D 0;
> +       struct perf_counts_values *count;
> +       bool adjust =3D false;
> +
> +       count =3D perf_counts(evsel->counts, cpu_map_idx, thread);
> +
> +       switch (evsel->tool_event) {
> +       case PERF_TOOL_DURATION_TIME:
> +               /*
> +                * Pretend duration_time is only on the first CPU and thr=
ead, or
> +                * else aggregation will scale duration_time by the numbe=
r of
> +                * CPUs/threads.
> +                */

We could set evsel->pmu->cpus to 0, if there's a tool pmu.


> +               if (cpu_map_idx =3D=3D 0 && thread =3D=3D 0)
> +                       cur_time =3D rdclock();
> +               else
> +                       cur_time =3D evsel->start_time;
> +               break;
> +       case PERF_TOOL_USER_TIME:
> +       case PERF_TOOL_SYSTEM_TIME: {
> +               bool system =3D evsel->tool_event =3D=3D PERF_TOOL_SYSTEM=
_TIME;
> +
> +               fd =3D FD(evsel, cpu_map_idx, thread);
> +               lseek(fd, SEEK_SET, 0);
> +               if (evsel->pid_stat) {
> +                       /* The event exists solely on 1 CPU. */

Probably the same.

Thanks,
Namhyung


> +                       if (cpu_map_idx =3D=3D 0)
> +                               err =3D read_pid_stat_field(fd, system ? =
15 : 14, &cur_time);
> +                       else
> +                               cur_time =3D 0;
> +               } else {
> +                       /* The event is for all threads. */
> +                       if (thread =3D=3D 0) {
> +                               struct perf_cpu cpu =3D perf_cpu_map__cpu=
(evsel->core.cpus,
> +                                                                       c=
pu_map_idx);
> +
> +                               err =3D read_stat_field(fd, cpu, system ?=
 3 : 1, &cur_time);
> +                       } else {
> +                               cur_time =3D 0;
> +                       }
> +               }
> +               adjust =3D true;
> +               break;
> +       }
> +       case PERF_TOOL_NONE:
> +       case PERF_TOOL_MAX:
> +       default:
> +               err =3D -EINVAL;
> +       }
> +       if (err)
> +               return err;
> +
> +       delta_start =3D cur_time - evsel->start_time;
> +       if (adjust) {
> +               __u64 ticks_per_sec =3D sysconf(_SC_CLK_TCK);
> +
> +               delta_start *=3D 1000000000 / ticks_per_sec;
> +       }
> +       count->val    =3D delta_start;
> +       count->ena    =3D count->run =3D delta_start;
> +       count->lost   =3D 0;
> +       return 0;
> +}
> +
>  int evsel__read_counter(struct evsel *evsel, int cpu_map_idx, int thread=
)
>  {
> -       u64 read_format =3D evsel->core.attr.read_format;
> +       if (evsel__is_tool(evsel))
> +               return evsel__read_tool(evsel, cpu_map_idx, thread);
>
> -       if (read_format & PERF_FORMAT_GROUP)
> +       if (evsel->core.attr.read_format & PERF_FORMAT_GROUP)
>                 return evsel__read_group(evsel, cpu_map_idx, thread);
>
>         return evsel__read_one(evsel, cpu_map_idx, thread);
> @@ -2005,6 +2179,13 @@ static int evsel__open_cpu(struct evsel *evsel, st=
ruct perf_cpu_map *cpus,
>         int pid =3D -1, err, old_errno;
>         enum rlimit_action set_rlimit =3D NO_CHANGE;
>
> +       if (evsel->tool_event =3D=3D PERF_TOOL_DURATION_TIME) {
> +               if (evsel->core.attr.sample_period) /* no sampling */
> +                       return -EINVAL;
> +               evsel->start_time =3D rdclock();
> +               return 0;
> +       }
> +
>         err =3D __evsel__prepare_open(evsel, cpus, threads);
>         if (err)
>                 return err;
> @@ -2037,6 +2218,44 @@ static int evsel__open_cpu(struct evsel *evsel, st=
ruct perf_cpu_map *cpus,
>                         if (!evsel->cgrp && !evsel->core.system_wide)
>                                 pid =3D perf_thread_map__pid(threads, thr=
ead);
>
> +                       if (evsel->tool_event =3D=3D PERF_TOOL_USER_TIME =
||
> +                           evsel->tool_event =3D=3D PERF_TOOL_SYSTEM_TIM=
E) {
> +                               bool system =3D evsel->tool_event =3D=3D =
PERF_TOOL_SYSTEM_TIME;
> +
> +                               if (evsel->core.attr.sample_period) {
> +                                       /* no sampling */
> +                                       err =3D -EINVAL;
> +                                       goto out_close;
> +                               }
> +                               if (pid > -1) {
> +                                       char buf[64];
> +
> +                                       snprintf(buf, sizeof(buf), "/proc=
/%d/stat", pid);
> +                                       fd =3D open(buf, O_RDONLY);
> +                                       evsel->pid_stat =3D true;
> +                               } else {
> +                                       fd =3D open("/proc/stat", O_RDONL=
Y);
> +                               }
> +                               FD(evsel, idx, thread) =3D fd;
> +                               if (fd < 0) {
> +                                       err =3D -errno;
> +                                       goto out_close;
> +                               }
> +                               if (pid > -1) {
> +                                       err =3D read_pid_stat_field(fd, s=
ystem ? 15 : 14,
> +                                                                 &evsel-=
>start_time);
> +                               } else {
> +                                       struct perf_cpu cpu;
> +
> +                                       cpu =3D perf_cpu_map__cpu(evsel->=
core.cpus, idx);
> +                                       err =3D read_stat_field(fd, cpu, =
system ? 3 : 1,
> +                                                             &evsel->sta=
rt_time);
> +                               }
> +                               if (err)
> +                                       goto out_close;
> +                               continue;
> +                       }
> +
>                         group_fd =3D get_group_fd(evsel, idx, thread);
>
>                         if (group_fd =3D=3D -2) {
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 517cff431de2..43f6fd1dcb4d 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -170,6 +170,12 @@ struct evsel {
>
>         /* for missing_features */
>         struct perf_pmu         *pmu;
> +
> +       /* For tool events */
> +       /* Beginning time subtracted when the counter is read. */
> +       __u64 start_time;
> +       /* Is the tool's fd for /proc/pid/stat or /proc/stat. */
> +       bool pid_stat;
>  };
>
>  struct perf_missing_features {
> --
> 2.44.0.769.g3c40516874-goog
>

