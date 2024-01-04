Return-Path: <linux-kernel+bounces-17067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF52A8247CE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13A611C24045
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70A728DB8;
	Thu,  4 Jan 2024 17:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dSl2ffrD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4B828DA0
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 17:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-553e36acfbaso377a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 09:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704390716; x=1704995516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B74JqfZyQlvHE8okDbReQQjqktg4m15F066ZG6l5Rrw=;
        b=dSl2ffrD1Zc6qV1nU7fkxfFrSzWNQNHiuxpU7JoYLlkeZer7asXYAfF2/6ksCYJBnQ
         M5IXWDgcNER2hrDLCbvJb3QiegNVBqYHqk6qNA21Z1X4wrLtSJmaGMlCFN4Jh9S2n+4v
         OYFp99+ma8bTIV/iiJhtG2CAH4j+Ro3PQNpPA4UsLLUhdAQQj+wx8JQpnxPLc8vGaPxk
         Gxu9oNyTgv79kIx0vuNM00d65LrbwLWz3XB4O/Gz7nmiUud2hk0Yh1pCfaeATeHQ3JZD
         gGK0HVAPiTHD8oO2RxjYPlGfp6KoqA1lBa9ITFhXYiJZl/S6S+whIf6UyNIhyqoKvvr2
         Ss+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704390716; x=1704995516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B74JqfZyQlvHE8okDbReQQjqktg4m15F066ZG6l5Rrw=;
        b=chraYEE4yh3ACZDkDCvKWLT+3nuFM15ltKRw/of+j13ksU1HyNLEeQ2ZdRxDJJPYM6
         xco4lIRXLSa4G2JK0QcyZZpeDX2VbNPuz0bmSfNa3O9yh78nN3MrZvbqghLN2g9KvgJY
         Z+CX3dvFJKho2Q+O4In5t/QT/HTD7DXU7NLMOas9YZZmXBvADezDExi9jKj0RXxdCJVq
         nN17Yp/+mFv5BtxBjTeuaFqt1gjb0dsxAUlujT53YGe2Kjnno+gzAtdphlSnyGeUF/O+
         fL+s3Pr2Hd0L4QzfS2JaesfZdaqokM0YlCs+EVORp2cqyGNAWPtulxeI0OZTuAbtWBVC
         RluA==
X-Gm-Message-State: AOJu0YxxIc3Eozyzl7/bUenNtVzEc7LIwI/ruDhQ5ZtV9S/HzNqO5YsO
	IBubL0S5rB/eKcE/ElhCcFmptQHDP2A9vINBsSQRuxh5gp5x
X-Google-Smtp-Source: AGHT+IFEAPvvuFWx88JngOw4Y9x/ZbIkJrHBt25yhvCdNyPzK4HGYk53JY9+vHuiXlAQeDwGwei73oXLhSnEOfRInXc=
X-Received: by 2002:a50:d4d2:0:b0:557:1142:d5bb with SMTP id
 e18-20020a50d4d2000000b005571142d5bbmr4311edj.4.1704390716226; Thu, 04 Jan
 2024 09:51:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104074259.653219-1-irogers@google.com> <ZZam-EG-UepcXtWw@kernel.org>
 <CAP-5=fV+U4qSwU8nqHJMgAZTwtWs9jEm3i9yDQSVtq9Fbos5HA@mail.gmail.com> <8af821dc-d173-483d-8b69-b8e041538561@linux.intel.com>
In-Reply-To: <8af821dc-d173-483d-8b69-b8e041538561@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 4 Jan 2024 09:51:44 -0800
Message-ID: <CAP-5=fVTEcbJdG6_L+GH5RGCtpFhpjWyyhYu0Fhx5CRRqZcqDg@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] perf vendor events intel: Alderlake/rocketlake
 metric fixes
To: "Liang, Kan" <kan.liang@linux.intel.com>, "Wang, Weilin" <weilin.wang@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 6:30=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.co=
m> wrote:
>
>
>
> On 2024-01-04 8:56 a.m., Ian Rogers wrote:
> >> Testing tma_slow_pause
> >> Metric 'tma_slow_pause' not printed in:
> >> # Running 'internals/synthesize' benchmark:
> >> Computing performance of single threaded perf event synthesis by
> >> synthesizing events on the perf process itself:
> >>   Average synthesis took: 49.987 usec (+- 0.049 usec)
> >>   Average num. events: 47.000 (+- 0.000)
> >>   Average time per event 1.064 usec
> >>   Average data synthesis took: 53.490 usec (+- 0.033 usec)
> >>   Average num. events: 245.000 (+- 0.000)
> >>   Average time per event 0.218 usec
> >>
> >>  Performance counter stats for 'perf bench internals synthesize':
> >>
> >>      <not counted>      cpu_core/TOPDOWN.SLOTS/                       =
                          (0.00%)
> >>      <not counted>      cpu_core/topdown-retiring/                    =
                          (0.00%)
> >>      <not counted>      cpu_core/topdown-mem-bound/                   =
                          (0.00%)
> >>      <not counted>      cpu_core/topdown-bad-spec/                    =
                          (0.00%)
> >>      <not counted>      cpu_core/topdown-fe-bound/                    =
                          (0.00%)
> >>      <not counted>      cpu_core/topdown-be-bound/                    =
                          (0.00%)
> >>      <not counted>      cpu_core/RESOURCE_STALLS.SCOREBOARD/          =
                              (0.00%)
> >>      <not counted>      cpu_core/EXE_ACTIVITY.1_PORTS_UTIL/           =
                             (0.00%)
> >>      <not counted>      cpu_core/EXE_ACTIVITY.BOUND_ON_LOADS/         =
                               (0.00%)
> >>      <not counted>      cpu_core/CPU_CLK_UNHALTED.PAUSE/              =
                          (0.00%)
> >>      <not counted>      cpu_core/CYCLE_ACTIVITY.STALLS_TOTAL/         =
                               (0.00%)
> >>      <not counted>      cpu_core/CPU_CLK_UNHALTED.THREAD/             =
                           (0.00%)
> >>      <not counted>      cpu_core/ARITH.DIV_ACTIVE/                    =
                          (0.00%)
> >>      <not counted>      cpu_core/EXE_ACTIVITY.2_PORTS_UTIL,umask=3D0xc=
/                                        (0.00%)
> >>      <not counted>      cpu_core/EXE_ACTIVITY.3_PORTS_UTIL,umask=3D0x8=
0/                                        (0.00%)
> >>
> >>        1.186254766 seconds time elapsed
> >>
> >>        0.427220000 seconds user
> >>        0.752217000 seconds sys
> >> Testing smi_cycles
> >> Testing smi_num
> >> Testing tsx_aborted_cycles
> >> Testing tsx_cycles_per_elision
> >> Testing tsx_cycles_per_transaction
> >> Testing tsx_transactional_cycles
> >> test child finished with -1
> >> ---- end ----
> >> perf all metrics test: FAILED!
> >> root@number:~#
> > Have a try disabling the NMI watchdog. Agreed that there is more to
> > fix here but I think the PMU driver is in part to blame because
> > manually breaking the weak group of events is a fix.
>
> I think we have a NO_GROUP_EVENTS_NMI metric constraint to mark a group
> which require disabling of the NMI watchdog.
> Maybe we should mark the group a NO_GROUP_EVENTS_NMI metric.

+Weilin due to the affects of event grouping.

Thanks Kan, NO_GROUP_EVENTS_NMI would be good. Something I see for
tma_ports_utilized_1 that may be worsening things is:

```
Testing tma_ports_utilized_1
Metric 'tma_ports_utilized_1' not printed in:
# Running 'internals/synthesize' benchmark:
Computing performance of single threaded perf event synthesis by
synthesizing events on the perf process itself:
  Average synthesis took: 49.581 usec (+- 0.030 usec)
  Average num. events: 47.000 (+- 0.000)
  Average time per event 1.055 usec
  Average data synthesis took: 53.367 usec (+- 0.032 usec)
  Average num. events: 246.000 (+- 0.000)
  Average time per event 0.217 usec

 Performance counter stats for 'perf bench internals synthesize':

     <not counted>      cpu_core/TOPDOWN.SLOTS/
                         (0.00%)
     <not counted>      cpu_core/topdown-retiring/
                         (0.00%)
     <not counted>      cpu_core/topdown-mem-bound/
                         (0.00%)
     <not counted>      cpu_core/topdown-bad-spec/
                         (0.00%)
     <not counted>      cpu_core/topdown-fe-bound/
                         (0.00%)
     <not counted>      cpu_core/topdown-be-bound/
                         (0.00%)
     <not counted>      cpu_core/RESOURCE_STALLS.SCOREBOARD/
                             (0.00%)
     <not counted>      cpu_core/EXE_ACTIVITY.1_PORTS_UTIL/
                            (0.00%)
     <not counted>      cpu_core/EXE_ACTIVITY.BOUND_ON_LOADS/
                              (0.00%)
     <not counted>      cpu_core/EXE_ACTIVITY.1_PORTS_UTIL/
                            (0.00%)
     <not counted>      cpu_core/CYCLE_ACTIVITY.STALLS_TOTAL/
                              (0.00%)
     <not counted>      cpu_core/CPU_CLK_UNHALTED.THREAD/
                          (0.00%)
     <not counted>      cpu_core/ARITH.DIV_ACTIVE/
                         (0.00%)
     <not counted>      cpu_core/EXE_ACTIVITY.2_PORTS_UTIL,umask=3D0xc/
                                      (0.00%)
     <not counted>      cpu_core/EXE_ACTIVITY.3_PORTS_UTIL,umask=3D0x80/
                                       (0.00%)

       1.180394056 seconds time elapsed

       0.409881000 seconds user
       0.764134000 seconds sys
```

The event EXE_ACTIVITY.1_PORTS_UTIL is repeated, this is because the
metric code deduplicates events based purely on their name and so
doesn't realize EXE_ACTIVITY.1_PORTS_UTIL is the same as
cpu_core@EXE_ACTIVITY.1_PORTS_UTIL@. This is a hybrid only glitch as
we only prefix with a PMU for hybrid metrics, and I should find and
remove why there's no PMU for the 1 case of EXE_ACTIVITY.1_PORTS_UTIL.

This problem doesn't occur for tma_slow_pause and I wondered if you
could give insight. That metric has the counters below:
```
$ perf stat -M tma_slow_pause -a sleep 0.1

Performance counter stats for 'system wide':

    <not counted>      cpu_core/TOPDOWN.SLOTS/
                        (0.00%)
    <not counted>      cpu_core/topdown-retiring/
                        (0.00%)
    <not counted>      cpu_core/topdown-mem-bound/
                        (0.00%)
    <not counted>      cpu_core/topdown-bad-spec/
                        (0.00%)
    <not counted>      cpu_core/topdown-fe-bound/
                        (0.00%)
    <not counted>      cpu_core/topdown-be-bound/
                        (0.00%)
    <not counted>      cpu_core/RESOURCE_STALLS.SCOREBOARD/
                            (0.00%)
    <not counted>      cpu_core/EXE_ACTIVITY.1_PORTS_UTIL/
                           (0.00%)
    <not counted>      cpu_core/EXE_ACTIVITY.BOUND_ON_LOADS/
                             (0.00%)
    <not counted>      cpu_core/CPU_CLK_UNHALTED.PAUSE/
                        (0.00%)
    <not counted>      cpu_core/CYCLE_ACTIVITY.STALLS_TOTAL/
                             (0.00%)
    <not counted>      cpu_core/CPU_CLK_UNHALTED.THREAD/
                         (0.00%)
    <not counted>      cpu_core/ARITH.DIV_ACTIVE/
                        (0.00%)
    <not counted>      cpu_core/EXE_ACTIVITY.2_PORTS_UTIL,umask=3D0xc/
                                     (0.00%)
    <not counted>      cpu_core/EXE_ACTIVITY.3_PORTS_UTIL,umask=3D0x80/
                                      (0.00%)

      0.102074888 seconds time elapsed
```

With -vv I see the event string is:
'{RESOURCE_STALLS.SCOREBOARD/metric-id=3DRESOURCE_STALLS.SCOREBOARD/,cpu_co=
re/EXE_ACTIVITY.1_PORTS_UTIL,metric-id=3Dcpu_core!3EXE_ACTIVITY.1_PORTS_UTI=
L!3/,cpu_core/TOPDOWN.SLOTS,metric-id=3Dcpu_core!3TOPDOWN.SLOTS!3/,cpu_core=
/EXE_ACTIVITY.BOUND_ON_LOADS,metric-id=3Dcpu_core!3EXE_ACTIVITY.BOUND_ON_LO=
ADS!3/,cpu_core/topdown-retiring,metric-id=3Dcpu_core!3topdown!1retiring!3/=
,cpu_core/topdown-mem-bound,metric-id=3Dcpu_core!3topdown!1mem!1bound!3/,cp=
u_core/topdown-bad-spec,metric-id=3Dcpu_core!3topdown!1bad!1spec!3/,CPU_CLK=
_UNHALTED.PAUSE/metric-id=3DCPU_CLK_UNHALTED.PAUSE/,cpu_core/CYCLE_ACTIVITY=
.STALLS_TOTAL,metric-id=3Dcpu_core!3CYCLE_ACTIVITY.STALLS_TOTAL!3/,cpu_core=
/CPU_CLK_UNHALTED.THREAD,metric-id=3Dcpu_core!3CPU_CLK_UNHALTED.THREAD!3/,c=
pu_core/ARITH.DIV_ACTIVE,metric-id=3Dcpu_core!3ARITH.DIV_ACTIVE!3/,cpu_core=
/topdown-fe-bound,metric-id=3Dcpu_core!3topdown!1fe!1bound!3/,cpu_core/EXE_=
ACTIVITY.2_PORTS_UTIL,umask=3D0xc,metric-id=3Dcpu_core!3EXE_ACTIVITY.2_PORT=
S_UTIL!0umask!20xc!3/,cpu_core/EXE_ACTIVITY.3_PORTS_UTIL,umask=3D0x80,metri=
c-id=3Dcpu_core!3EXE_ACTIVITY.3_PORTS_UTIL!0umask!20x80!3/,cpu_core/topdown=
-be-bound,metric-id=3Dcpu_core!3topdown!1be!1bound!3/}:W'

which without the metric-ids becomes:
'{RESOURCE_STALLS.SCOREBOARD,cpu_core/EXE_ACTIVITY.1_PORTS_UTIL/,cpu_core/T=
OPDOWN.SLOTS/,cpu_core/EXE_ACTIVITY.BOUND_ON_LOADS/,cpu_core/topdown-retiri=
ng/,cpu_core/topdown-mem-bound/,cpu_core/topdown-bad-spec/,CPU_CLK_UNHALTED=
.PAUSE,cpu_core/CYCLE_ACTIVITY.STALLS_TOTAL/,cpu_core/CPU_CLK_UNHALTED.THRE=
AD/,cpu_core/ARITH.DIV_ACTIVE/,cpu_core/topdown-fe-bound/,cpu_core/EXE_ACTI=
VITY.2_PORTS_UTIL,umask=3D0xc/,cpu_core/EXE_ACTIVITY.3_PORTS_UTIL,umask=3D0=
x80/,cpu_core/topdown-be-bound/}:W'

I count 9 none slots/top-down counters there, but I see
CPU_CLK_UNHALTED.THREAD can use fixed counter 1. Should
perf_event_open fail for a CPU that has a pinned use of a fixed
counter and the group needs the fixed counter? I'm guessing you don't
want this as CPU_CLK_UNHALTED.THREAD can also go on a generic counter
and the driver doesn't want to count counter usage, it seems feasible
to add it though. I guess we need a NO_GROUP_EVENTS_NMI whenever
CPU_CLK_UNHALTED.THREAD is an event and 8 generic counters are in use.

Checking on Tigerlake I see:
```
$ perf stat -M tma_slow_pause -a sleep 0.1

Performance counter stats for 'system wide':

      105,210,913      TOPDOWN.SLOTS                    #      0.1 %
tma_slow_pause           (72.65%)
        6,701,129      topdown-retiring
                        (72.65%)
       52,359,712      topdown-fe-bound
                        (72.65%)
       32,904,532      topdown-be-bound
                        (72.65%)
       14,117,814      topdown-bad-spec
                        (72.65%)
        6,602,391      RESOURCE_STALLS.SCOREBOARD
                        (76.17%)
        4,220,773      cpu/EXE_ACTIVITY.3_PORTS_UTIL,umask=3D0x80/
                                 (76.73%)
          421,812      EXE_ACTIVITY.BOUND_ON_STORES
                        (76.69%)
        5,164,088      EXE_ACTIVITY.1_PORTS_UTIL
                        (76.70%)
          299,681      cpu/INT_MISC.RECOVERY_CYCLES,cmask=3D1,edge/
                                  (76.69%)
              245      MISC_RETIRED.PAUSE_INST
                        (76.67%)
       58,403,687      CPU_CLK_UNHALTED.THREAD
                        (76.72%)
       25,297,841      CYCLE_ACTIVITY.STALLS_MEM_ANY
                        (76.67%)
        3,788,772      EXE_ACTIVITY.2_PORTS_UTIL
                        (62.69%)
       20,973,875      CYCLE_ACTIVITY.STALLS_TOTAL
                        (62.16%)
           68,053      ARITH.DIVIDER_ACTIVE
                        (62.18%)

      0.102624327 seconds time elapsed
```
so 10 generic counters which would never fit and the weak group is
broken - the difference in the metric explaining why I've not been
seeing the issue. I think I need to add alderlake/sapphirerapids
constraints here:
https://github.com/captain5050/perfmon/blob/main/scripts/create_perf_json.p=
y#L1382
Ideally we'd automate the constraint generation (or the PMU driver
would help us out by failing to open the weak group).

Thanks,
Ian


> Thanks,
> Kan
>
> > Fwiw, if we
> > switch to the buddy watchdog mechanism then we'll no longer need to
> > disable the NMI watchdog:
> > https://lore.kernel.org/lkml/20230421155255.1.I6bf789d21d0c3d75d382e7e5=
1a804a7a51315f2c@changeid/
>

