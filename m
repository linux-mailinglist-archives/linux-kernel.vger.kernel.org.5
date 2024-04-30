Return-Path: <linux-kernel+bounces-164621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0388B803B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27BD9283B90
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB88194C94;
	Tue, 30 Apr 2024 19:00:54 +0000 (UTC)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A446119066F;
	Tue, 30 Apr 2024 19:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714503653; cv=none; b=HPT+0IUobeykw0pU1NUXdILMoUq0dVrbwh7JdAZhxncYwG8/dG+k1KsZyrQ8xnI9FUSRnqnBBlG9MqyEPacOVlQVsP0Y0lWF51lzu9NVjTofWJ0QGqNY8a1U6nrEdUN0taSkiQvcs4dgGrTq9MKY3CjU1PpWW33A9opBW1ktvps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714503653; c=relaxed/simple;
	bh=8EcnktbTA8Ts3SFppUGtHLVOnPlsIv3k6OUKph0PCCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N6UiFehU4ALIgE9Muo0bjKx29dm6X/xcE09Cyjv0MS+Gg8vRPpzC78R9uD1SC/HxUxc4so2QvLmPjlor/+CxLxH9eAoeQWRlbp4/1WzC+DaQlP9OJepNPV2Vu/VM2EytlGv+GNo0NMClkY3EWbN+UMoDNH34FVe8g8el2K8bJN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso4124336a12.3;
        Tue, 30 Apr 2024 12:00:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714503636; x=1715108436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vAfpz50ayIGAwCDgr0CSK6wANp+m0y54ijaRJ4gAiqs=;
        b=n2rwtlmvjFfIz7A192ZDscfWezHhiA3iBL6WrbBHrxhzamFWvNT/bNx/mOmty/CCQK
         XL320p6Y4qazOx/2ngZOLULS/3KJsw07rEHrOe9Y3w1ljMG8cHk2CXV2s9fY3TzjQLIy
         ELO+pMrf3hctfJ4ko90aIazv/ggUNq6mqWChnCnq/zdcZWVYdgxEYFQN1MnIT9HsrYZD
         hE0xyWht+5p+5U0b5rCJeJEbPKwhJnxa7Coj2CRBO/meBzHE95B+H/qSvv+8Q7FXu9S6
         0q/zbe02MI5wEYkc+AEARz3e42K4r2cx5/c0nFZmMvgjJzOrVn7bTnGZHmOuaNs7isXV
         DueQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrPIn8dxZ3VKv0IZvA64qlzEOhcv8xOXoNjdiKp5EpE7deE8xC5WEOCBzAiZ3oZ6FuXS66er8rOfwWD3AEDXK10/eyWpXTHVkL0NIgheApXp5Szcw7RJuhyEk6r2fHR4kOUGxX2LsU0VO4x/33qw==
X-Gm-Message-State: AOJu0YxSI/XTvzE2tDLLENLI1UDrwX2bITg7o8VHKQT8hRwlTNTW4z6O
	dtGZ8U8B3VwSLXBXPdSbZSXcgjG8rQLVRnG3dsTSLFYmELWcbRzni8IeM+/dBZOSF/ucjVHf+wz
	Yyd1bx8vfF0YVKkBrKXq6I4qwjKE=
X-Google-Smtp-Source: AGHT+IFwisVGG1IQhQL1YXVx7M/Q7PbXm+kidchZ0l8F6XM7EwYaiEG/213FouI27e3pLjjtkoZfbrwhSpb2D6JKDO0=
X-Received: by 2002:a17:90b:1403:b0:2a2:94c0:38d4 with SMTP id
 jo3-20020a17090b140300b002a294c038d4mr369685pjb.31.1714503635613; Tue, 30 Apr
 2024 12:00:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240428053616.1125891-1-irogers@google.com> <20240428053616.1125891-2-irogers@google.com>
 <CAM9d7cjX_5SS=JGnjMLxG3fcReyuhUoJQacKVsBtcW2ngD06sw@mail.gmail.com> <CAP-5=fVE5kOip29qx=phZPfRHj+hE=gqTpMhKWmdb6T5=ipzag@mail.gmail.com>
In-Reply-To: <CAP-5=fVE5kOip29qx=phZPfRHj+hE=gqTpMhKWmdb6T5=ipzag@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 30 Apr 2024 12:00:24 -0700
Message-ID: <CAM9d7chwg29gdxjnAg3_Nqej6nY2_Sw6W6-5VMtMZX23f6MR7Q@mail.gmail.com>
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

On Mon, Apr 29, 2024 at 7:47=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Mon, Apr 29, 2024 at 2:00=E2=80=AFPM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > Hi Ian,
> >
> > On Sat, Apr 27, 2024 at 10:36=E2=80=AFPM Ian Rogers <irogers@google.com=
> wrote:
> > >
> > > Tool events unnecessarily open a dummy perf event which is useless
> > > even with `perf record` which will still open a dummy event. Change
> > > the behavior of tool events so:
> >
> > Right, I was surprised that we need a dummy event for that.
> >
> > >
> > >  - duration_time - call `rdclock` on open and then report the count a=
s
> > >    a delta since the start in evsel__read_counter. This moves code ou=
t
> > >    of builtin-stat making it more general purpose.
> > >
> > >  - user_time/system_time - open the fd as either `/proc/pid/stat` or
> > >    `/proc/stat` for cases like system wide. evsel__read_counter will
> > >    read the appropriate field out of the procfs file. These values
> > >    were previously supplied by wait4, if the procfs read fails then
> > >    the wait4 values are used, assuming the process/thread terminated.
> > >    By reading user_time and system_time this way, interval mode can b=
e
> > >    supported.
> >
> > Good improvement!
> >
> > >
> > > Opening any of the tool events for `perf record` returns invalid.
> >
> > Ok, I think those tool events are for `perf stat` only.
> >
> > But I feel like this change is a separate optimization and can be
> > independently submitted (from the retire-latency or tPEBS change).
>
> You're right, but as both pieces of code are changing the
> evsel__read_counter implementation I'd kept them together.

Ok.

>
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/builtin-stat.c |  74 ++++++-------
> > >  tools/perf/util/evsel.c   | 223 ++++++++++++++++++++++++++++++++++++=
+-
> > >  tools/perf/util/evsel.h   |   6 +
> > >  3 files changed, 259 insertions(+), 44 deletions(-)
> > >
> > > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > > index 65a3dd7ffac3..428e9721b908 100644
> > > --- a/tools/perf/builtin-stat.c
> > > +++ b/tools/perf/builtin-stat.c
> > > @@ -255,45 +255,37 @@ static int evsel__write_stat_event(struct evsel=
 *counter, int cpu_map_idx, u32 t
> > >                                            process_synthesized_event,=
 NULL);
> > >  }
> > >
> > > -static int read_single_counter(struct evsel *counter, int cpu_map_id=
x,
> > > -                              int thread, struct timespec *rs)
> > > -{
> > > -       switch(counter->tool_event) {
> > > -               case PERF_TOOL_DURATION_TIME: {
> > > -                       u64 val =3D rs->tv_nsec + rs->tv_sec*10000000=
00ULL;
> > > -                       struct perf_counts_values *count =3D
> > > -                               perf_counts(counter->counts, cpu_map_=
idx, thread);
> > > -                       count->ena =3D count->run =3D val;
> > > -                       count->val =3D val;
> > > -                       return 0;
> > > -               }
> > > -               case PERF_TOOL_USER_TIME:
> > > -               case PERF_TOOL_SYSTEM_TIME: {
> > > -                       u64 val;
> > > -                       struct perf_counts_values *count =3D
> > > -                               perf_counts(counter->counts, cpu_map_=
idx, thread);
> > > -                       if (counter->tool_event =3D=3D PERF_TOOL_USER=
_TIME)
> > > -                               val =3D ru_stats.ru_utime_usec_stat.m=
ean;
> > > -                       else
> > > -                               val =3D ru_stats.ru_stime_usec_stat.m=
ean;
> > > -                       count->ena =3D count->run =3D val;
> > > -                       count->val =3D val;
> > > -                       return 0;
> > > -               }
> > > -               default:
> > > -               case PERF_TOOL_NONE:
> > > -                       return evsel__read_counter(counter, cpu_map_i=
dx, thread);
> > > -               case PERF_TOOL_MAX:
> > > -                       /* This should never be reached */
> > > -                       return 0;
> > > +static int read_single_counter(struct evsel *counter, int cpu_map_id=
x, int thread)
> > > +{
> > > +       int err =3D evsel__read_counter(counter, cpu_map_idx, thread)=
;
> > > +
> > > +       /*
> > > +        * Reading user and system time will fail when the process
> > > +        * terminates. Use the wait4 values in that case.
> > > +        */
> > > +       if (err &&
> > > +           (counter->tool_event =3D=3D PERF_TOOL_USER_TIME ||
> > > +            counter->tool_event =3D=3D PERF_TOOL_SYSTEM_TIME)) {
> >
> > Off-topic.  I feel like we should have a (fake) pmu for the tool events
> > rather than the evsel->tool_event enum.
>
> Sounds good to me. The refactoring in this (unmerged) test change:
> https://lore.kernel.org/lkml/20240429200225.1271876-4-irogers@google.com/
> makes it so we can load a PMU from something like a temporary
> directory. It would be nice to get rid of the fake_pmu special case in
> parse-events and similarly the tool event special case. A problem is
> that libperf lacks knowledge of fake_pmus and tool events in the
> evlist and evsel code. libperf can try to apply operations to these
> events even though the only knowledge of them is in the perf tool.

Right, libperf should be aware of the tool pmu then.

>
> >
> > > +               u64 val;
> > > +               struct perf_counts_values *count =3D
> > > +                       perf_counts(counter->counts, cpu_map_idx, thr=
ead);
> > > +
> > > +               if (counter->tool_event =3D=3D PERF_TOOL_USER_TIME)
> > > +                       val =3D ru_stats.ru_utime_usec_stat.mean;
> > > +               else
> > > +                       val =3D ru_stats.ru_stime_usec_stat.mean;
> > > +               count->ena =3D count->run =3D val;
> > > +               count->val =3D val;
> > > +               return 0;
> > >         }
> > > +       return err;
> > >  }
> > >
> > >  /*
> > >   * Read out the results of a single counter:
> > >   * do not aggregate counts across CPUs in system-wide mode
> > >   */
> > > -static int read_counter_cpu(struct evsel *counter, struct timespec *=
rs, int cpu_map_idx)
> > > +static int read_counter_cpu(struct evsel *counter, int cpu_map_idx)
> > >  {
> > >         int nthreads =3D perf_thread_map__nr(evsel_list->core.threads=
);
> > >         int thread;
> > > @@ -311,7 +303,7 @@ static int read_counter_cpu(struct evsel *counter=
, struct timespec *rs, int cpu_
> > >                  * (via evsel__read_counter()) and sets their count->=
loaded.
> > >                  */
> > >                 if (!perf_counts__is_loaded(counter->counts, cpu_map_=
idx, thread) &&
> > > -                   read_single_counter(counter, cpu_map_idx, thread,=
 rs)) {
> > > +                   read_single_counter(counter, cpu_map_idx, thread)=
) {
> > >                         counter->counts->scaled =3D -1;
> > >                         perf_counts(counter->counts, cpu_map_idx, thr=
ead)->ena =3D 0;
> > >                         perf_counts(counter->counts, cpu_map_idx, thr=
ead)->run =3D 0;
> > > @@ -340,7 +332,7 @@ static int read_counter_cpu(struct evsel *counter=
, struct timespec *rs, int cpu_
> > >         return 0;
> > >  }
> > >
> > > -static int read_affinity_counters(struct timespec *rs)
> > > +static int read_affinity_counters(void)
> > >  {
> > >         struct evlist_cpu_iterator evlist_cpu_itr;
> > >         struct affinity saved_affinity, *affinity;
> > > @@ -361,10 +353,8 @@ static int read_affinity_counters(struct timespe=
c *rs)
> > >                 if (evsel__is_bpf(counter))
> > >                         continue;
> > >
> > > -               if (!counter->err) {
> > > -                       counter->err =3D read_counter_cpu(counter, rs=
,
> > > -                                                       evlist_cpu_it=
r.cpu_map_idx);
> > > -               }
> > > +               if (!counter->err)
> > > +                       counter->err =3D read_counter_cpu(counter, ev=
list_cpu_itr.cpu_map_idx);
> > >         }
> > >         if (affinity)
> > >                 affinity__cleanup(&saved_affinity);
> > > @@ -388,11 +378,11 @@ static int read_bpf_map_counters(void)
> > >         return 0;
> > >  }
> > >
> > > -static int read_counters(struct timespec *rs)
> > > +static int read_counters(void)
> > >  {
> > >         if (!stat_config.stop_read_counter) {
> > >                 if (read_bpf_map_counters() ||
> > > -                   read_affinity_counters(rs))
> > > +                   read_affinity_counters())
> > >                         return -1;
> > >         }
> > >         return 0;
> > > @@ -423,7 +413,7 @@ static void process_interval(void)
> > >
> > >         evlist__reset_aggr_stats(evsel_list);
> > >
> > > -       if (read_counters(&rs) =3D=3D 0)
> > > +       if (read_counters() =3D=3D 0)
> > >                 process_counters();
> > >
> > >         if (STAT_RECORD) {
> > > @@ -911,7 +901,7 @@ static int __run_perf_stat(int argc, const char *=
*argv, int run_idx)
> > >          * avoid arbitrary skew, we must read all counters before clo=
sing any
> > >          * group leaders.
> > >          */
> > > -       if (read_counters(&(struct timespec) { .tv_nsec =3D t1-t0 }) =
=3D=3D 0)
> > > +       if (read_counters() =3D=3D 0)
> > >                 process_counters();
> > >
> > >         /*
> >
> > I think this part can be a separate commit.  You can implement the
> > tool event handling before actually using it. :)
>
> It's possible but it opens a 3rd world where tool code is implemented
> both in evsel and also in builtin-stat. The builtin-stat code uses
> wait4 and the evsel code is using file descriptors. If tests fail
> should the 3rd world be fixed? The intent here is that we're deleting
> all the builtin-stat evsel tool code, a consequence of that is
> deleting unused function arguments. As the changes are purely deleting
> I'd prefer not to have a combined world to temporarily maintain.

I guess the tool events are only used by perf stat, is there any
tests that use the tool events?

Anyway it's not a big deal.  I just wanted to keep each change
small.  I think it's ok to add the code for tool event to evsel as
long as it's not used.  But I don't insist on it strongly.

>
> >
> > > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > > index 3536404e9447..a0a8aee7d6b9 100644
> > > --- a/tools/perf/util/evsel.c
> > > +++ b/tools/perf/util/evsel.c
> > > @@ -10,6 +10,7 @@
> > >  #include <errno.h>
> > >  #include <inttypes.h>
> > >  #include <linux/bitops.h>
> > > +#include <api/io.h>
> > >  #include <api/fs/fs.h>
> > >  #include <api/fs/tracing_path.h>
> > >  #include <linux/hw_breakpoint.h>
> > > @@ -30,6 +31,7 @@
> > >  #include "counts.h"
> > >  #include "event.h"
> > >  #include "evsel.h"
> > > +#include "time-utils.h"
> > >  #include "util/env.h"
> > >  #include "util/evsel_config.h"
> > >  #include "util/evsel_fprintf.h"
> > > @@ -1600,11 +1602,183 @@ static int evsel__read_group(struct evsel *l=
eader, int cpu_map_idx, int thread)
> > >         return evsel__process_group_data(leader, cpu_map_idx, thread,=
 data);
> > >  }
> > >
> > > +static int read_stat_field(int fd, struct perf_cpu cpu, int field, _=
_u64 *val)
> > > +{
> > > +       char buf[256];
> > > +       struct io io;
> > > +       int c, i;
> > > +
> > > +       io__init(&io, fd, buf, sizeof(buf));
> > > +
> > > +       /* Skip lines to relevant CPU. */
> > > +       for (i =3D -1; i < cpu.cpu; i++) {
> > > +               do {
> > > +                       c =3D io__get_char(&io);
> > > +                       if (c =3D=3D -1)
> > > +                               return -EINVAL;
> > > +               } while (c !=3D '\n');
> > > +       }
> > > +       /* Skip to "cpu". */
> > > +       c =3D io__get_char(&io);
> > > +       if (c !=3D 'c')
> > > +               return -EINVAL;
> > > +       c =3D io__get_char(&io);
> > > +       if (c !=3D 'p')
> > > +               return -EINVAL;
> > > +       c =3D io__get_char(&io);
> > > +       if (c !=3D 'u')
> > > +               return -EINVAL;
> > > +       /* Skip N of cpuN. */
> > > +       do {
> > > +               c =3D io__get_char(&io);
> > > +               if (c =3D=3D -1)
> > > +                       return -EINVAL;
> > > +       } while (c !=3D ' ');
> > > +
> > > +       i =3D 1;
> > > +       while (true) {
> > > +               c =3D io__get_dec(&io, val);
> > > +               if (c !=3D ' ')
> > > +                       break;
> > > +               if (field =3D=3D i)
> > > +                       return 0;
> > > +               i++;
> > > +       }
> > > +       return -EINVAL;
> > > +}
> >
> > Looks somewhat verbose, can we have something like
> > io__get_str_field() or io__get_num_filed()?
>
> I think macro magic would probably be the best way to cut down on
> verbosity, I'm not sure its a big deal given the majority of the field
> handling happens in the while loops. I'd like to skip this for now.

It's not a big deal.  But I just thought this can be generic and
live in the tools/lib. :)

>
> >
> > > +
> > > +static int read_pid_stat_field(int fd, int field, __u64 *val)
> > > +{
> > > +       char buf[256];
> > > +       struct io io;
> > > +       int c, i;
> > > +
> > > +       io__init(&io, fd, buf, sizeof(buf));
> > > +       c =3D io__get_dec(&io, val);
> > > +       if (c !=3D ' ')
> > > +               return -EINVAL;
> > > +       if (field =3D=3D 1)
> > > +               return 0;
> > > +
> > > +       /* Skip comm. */
> > > +       c =3D io__get_char(&io);
> > > +       if (c !=3D '(')
> > > +               return -EINVAL;
> > > +       do {
> > > +               c =3D io__get_char(&io);
> > > +               if (c =3D=3D -1)
> > > +                       return -EINVAL;
> > > +       } while (c !=3D ')');

Hmm.. but the possible space in the comm would make it
complicated. :(


> > > +       if (field =3D=3D 2)
> > > +               return -EINVAL;
> > > +
> > > +       /* Skip state */
> > > +       c =3D io__get_char(&io);
> > > +       if (c !=3D ' ')
> > > +               return -EINVAL;
> > > +       c =3D io__get_char(&io);
> > > +       if (c =3D=3D -1)
> > > +               return -EINVAL;
> > > +       if (field =3D=3D 3)
> > > +               return -EINVAL;
> > > +
> > > +       /* Loop over numeric fields*/
> > > +       c =3D io__get_char(&io);
> > > +       if (c !=3D ' ')
> > > +               return -EINVAL;
> > > +
> > > +       i =3D 4;
> > > +       while (true) {
> > > +               c =3D io__get_dec(&io, val);
> > > +               if (c =3D=3D -1)
> > > +                       return -EINVAL;
> > > +               if (c =3D=3D -2) {
> > > +                       /* Assume a -ve was read */
> > > +                       c =3D io__get_dec(&io, val);
> > > +                       *val *=3D -1;
> > > +               }
> > > +               if (c !=3D ' ')
> > > +                       return -EINVAL;
> > > +               if (field =3D=3D i)
> > > +                       return 0;
> > > +               i++;
> > > +       }
> > > +       return -EINVAL;
> > > +}
> > > +
> > > +static int evsel__read_tool(struct evsel *evsel, int cpu_map_idx, in=
t thread)
> > > +{
> > > +       __u64 cur_time, delta_start;
> > > +       int fd, err =3D 0;
> > > +       struct perf_counts_values *count;
> > > +       bool adjust =3D false;
> > > +
> > > +       count =3D perf_counts(evsel->counts, cpu_map_idx, thread);
> > > +
> > > +       switch (evsel->tool_event) {
> > > +       case PERF_TOOL_DURATION_TIME:
> > > +               /*
> > > +                * Pretend duration_time is only on the first CPU and=
 thread, or
> > > +                * else aggregation will scale duration_time by the n=
umber of
> > > +                * CPUs/threads.
> > > +                */
> >
> > We could set evsel->pmu->cpus to 0, if there's a tool pmu.
>
> For the CPU it already is:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/t=
ools/perf/util/parse-events.c#n314
> There isn't an equivalent for the thread. I was tempted to add an
> assert that cpu_map_idx =3D=3D 0, but it seemed more forgiving to treat i=
t
> how threads are handled - I'm always concerned about breaking existing
> code given how often I'm successful at doing it :-) . We could also
> try to divide the delta across all CPUs/threads, but that seemed
> weird.

Yeah, I think it's best if we keep a single event (cpu =3D -1, thread =3D 0=
 ?)
Then it needs to set the cpu/thread map regardless of user options.

>
> >
> > > +               if (cpu_map_idx =3D=3D 0 && thread =3D=3D 0)
> > > +                       cur_time =3D rdclock();
> > > +               else
> > > +                       cur_time =3D evsel->start_time;
> > > +               break;
> > > +       case PERF_TOOL_USER_TIME:
> > > +       case PERF_TOOL_SYSTEM_TIME: {
> > > +               bool system =3D evsel->tool_event =3D=3D PERF_TOOL_SY=
STEM_TIME;
> > > +
> > > +               fd =3D FD(evsel, cpu_map_idx, thread);
> > > +               lseek(fd, SEEK_SET, 0);
> > > +               if (evsel->pid_stat) {
> > > +                       /* The event exists solely on 1 CPU. */
> >
> > Probably the same.
>
> Similar to above. In system wide we can give per-CPU user and system
> time breakdowns, whereas the /prod/pid/stat version doesn't support
> that. The code is trying to make the most out of the information /proc
> will give it. Thinking about it, we shouldn't be pinning the user and
> system time to CPU0 in that case, so add_event_tool:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/t=
ools/perf/util/parse-events.c#n302
> should pass "0" in the duration_time case and NULL for the others.
> This should allow say "perf stat -A -I 1000 -e user_time,system_time"
> to give a per second per CPU user and system time value. This reminds
> me that it'd be nice to do similar for hwmon values, another fake PMU
> case.

That makes sense.  Actually I'm thinking if we can make the
cpu-clock and task-clock events accept the k and u modifiers.
But it'd require programming the timers on every kernel/user
context switch and everyone would hate it. ;-)

Thanks,
Namhyung

> >
> >
> > > +                       if (cpu_map_idx =3D=3D 0)
> > > +                               err =3D read_pid_stat_field(fd, syste=
m ? 15 : 14, &cur_time);
> > > +                       else
> > > +                               cur_time =3D 0;
> > > +               } else {
> > > +                       /* The event is for all threads. */
> > > +                       if (thread =3D=3D 0) {
> > > +                               struct perf_cpu cpu =3D perf_cpu_map_=
_cpu(evsel->core.cpus,
> > > +                                                                    =
   cpu_map_idx);
> > > +
> > > +                               err =3D read_stat_field(fd, cpu, syst=
em ? 3 : 1, &cur_time);
> > > +                       } else {
> > > +                               cur_time =3D 0;
> > > +                       }
> > > +               }
> > > +               adjust =3D true;
> > > +               break;
> > > +       }
> > > +       case PERF_TOOL_NONE:
> > > +       case PERF_TOOL_MAX:
> > > +       default:
> > > +               err =3D -EINVAL;
> > > +       }
> > > +       if (err)
> > > +               return err;
> > > +
> > > +       delta_start =3D cur_time - evsel->start_time;
> > > +       if (adjust) {
> > > +               __u64 ticks_per_sec =3D sysconf(_SC_CLK_TCK);
> > > +
> > > +               delta_start *=3D 1000000000 / ticks_per_sec;
> > > +       }
> > > +       count->val    =3D delta_start;
> > > +       count->ena    =3D count->run =3D delta_start;
> > > +       count->lost   =3D 0;
> > > +       return 0;
> > > +}
> > > +
> > >  int evsel__read_counter(struct evsel *evsel, int cpu_map_idx, int th=
read)
> > >  {
> > > -       u64 read_format =3D evsel->core.attr.read_format;
> > > +       if (evsel__is_tool(evsel))
> > > +               return evsel__read_tool(evsel, cpu_map_idx, thread);
> > >
> > > -       if (read_format & PERF_FORMAT_GROUP)
> > > +       if (evsel->core.attr.read_format & PERF_FORMAT_GROUP)
> > >                 return evsel__read_group(evsel, cpu_map_idx, thread);
> > >
> > >         return evsel__read_one(evsel, cpu_map_idx, thread);
> > > @@ -2005,6 +2179,13 @@ static int evsel__open_cpu(struct evsel *evsel=
, struct perf_cpu_map *cpus,
> > >         int pid =3D -1, err, old_errno;
> > >         enum rlimit_action set_rlimit =3D NO_CHANGE;
> > >
> > > +       if (evsel->tool_event =3D=3D PERF_TOOL_DURATION_TIME) {
> > > +               if (evsel->core.attr.sample_period) /* no sampling */
> > > +                       return -EINVAL;
> > > +               evsel->start_time =3D rdclock();
> > > +               return 0;
> > > +       }
> > > +
> > >         err =3D __evsel__prepare_open(evsel, cpus, threads);
> > >         if (err)
> > >                 return err;
> > > @@ -2037,6 +2218,44 @@ static int evsel__open_cpu(struct evsel *evsel=
, struct perf_cpu_map *cpus,
> > >                         if (!evsel->cgrp && !evsel->core.system_wide)
> > >                                 pid =3D perf_thread_map__pid(threads,=
 thread);
> > >
> > > +                       if (evsel->tool_event =3D=3D PERF_TOOL_USER_T=
IME ||
> > > +                           evsel->tool_event =3D=3D PERF_TOOL_SYSTEM=
_TIME) {
> > > +                               bool system =3D evsel->tool_event =3D=
=3D PERF_TOOL_SYSTEM_TIME;
> > > +
> > > +                               if (evsel->core.attr.sample_period) {
> > > +                                       /* no sampling */
> > > +                                       err =3D -EINVAL;
> > > +                                       goto out_close;
> > > +                               }
> > > +                               if (pid > -1) {
> > > +                                       char buf[64];
> > > +
> > > +                                       snprintf(buf, sizeof(buf), "/=
proc/%d/stat", pid);
> > > +                                       fd =3D open(buf, O_RDONLY);
> > > +                                       evsel->pid_stat =3D true;
> > > +                               } else {
> > > +                                       fd =3D open("/proc/stat", O_R=
DONLY);
> > > +                               }
> > > +                               FD(evsel, idx, thread) =3D fd;
> > > +                               if (fd < 0) {
> > > +                                       err =3D -errno;
> > > +                                       goto out_close;
> > > +                               }
> > > +                               if (pid > -1) {
> > > +                                       err =3D read_pid_stat_field(f=
d, system ? 15 : 14,
> > > +                                                                 &ev=
sel->start_time);
> > > +                               } else {
> > > +                                       struct perf_cpu cpu;
> > > +
> > > +                                       cpu =3D perf_cpu_map__cpu(evs=
el->core.cpus, idx);
> > > +                                       err =3D read_stat_field(fd, c=
pu, system ? 3 : 1,
> > > +                                                             &evsel-=
>start_time);
> > > +                               }
> > > +                               if (err)
> > > +                                       goto out_close;
> > > +                               continue;
> > > +                       }
> > > +
> > >                         group_fd =3D get_group_fd(evsel, idx, thread)=
;
> > >
> > >                         if (group_fd =3D=3D -2) {
> > > diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> > > index 517cff431de2..43f6fd1dcb4d 100644
> > > --- a/tools/perf/util/evsel.h
> > > +++ b/tools/perf/util/evsel.h
> > > @@ -170,6 +170,12 @@ struct evsel {
> > >
> > >         /* for missing_features */
> > >         struct perf_pmu         *pmu;
> > > +
> > > +       /* For tool events */
> > > +       /* Beginning time subtracted when the counter is read. */
> > > +       __u64 start_time;
> > > +       /* Is the tool's fd for /proc/pid/stat or /proc/stat. */
> > > +       bool pid_stat;
> > >  };
> > >
> > >  struct perf_missing_features {
> > > --
> > > 2.44.0.769.g3c40516874-goog
> > >

