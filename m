Return-Path: <linux-kernel+bounces-17159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4897782490A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C757B21113
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158752C19E;
	Thu,  4 Jan 2024 19:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ot0d+wXR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9239B2C19C;
	Thu,  4 Jan 2024 19:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704396605; x=1735932605;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XbrYYoSXE3YaF1Ch/5mpDGYMPOH5jY4B+4OnS5lYTe8=;
  b=Ot0d+wXRxZkQZnn8j5fZSq3nvSt5tiJVnTSP9aBJbxYo5GjQiIfWz5K6
   qeso8fY8sctm1nrFRtGgB4WzToF7ox8PW+Ib6jjCaVLqfaDOXbJWpROR9
   dOwdje8RJlja/pMMTEnsoPijkHhFXxjf0oVUp6hyn8+F27Q7l66+S03Ir
   diBbvkupRAA1trRWHlvl/QdJYEduTSjQUm32uaFm22na4nxO8CwHcF7Qu
   jbGIVIkKkwtLEPlSzpRdx/u9GEGgC59BtNDiM/aAQtlqemdUDhiAdxziA
   QDElp8lTOQujJuFxrYrBaacZTWG5xnZsh4O+UpysVsy629s/Y+eZca90X
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="483519558"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="483519558"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 11:30:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="780517687"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="780517687"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 11:30:04 -0800
Received: from [10.209.154.172] (kliang2-mobl1.ccr.corp.intel.com [10.209.154.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 7B5F6580BF8;
	Thu,  4 Jan 2024 11:30:02 -0800 (PST)
Message-ID: <550563df-f8ac-4aa7-99de-ccf94cea8513@linux.intel.com>
Date: Thu, 4 Jan 2024 14:30:01 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] perf vendor events intel: Alderlake/rocketlake
 metric fixes
Content-Language: en-US
To: Ian Rogers <irogers@google.com>, "Wang, Weilin" <weilin.wang@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Edward Baker <edward.baker@intel.com>
References: <20240104074259.653219-1-irogers@google.com>
 <ZZam-EG-UepcXtWw@kernel.org>
 <CAP-5=fV+U4qSwU8nqHJMgAZTwtWs9jEm3i9yDQSVtq9Fbos5HA@mail.gmail.com>
 <8af821dc-d173-483d-8b69-b8e041538561@linux.intel.com>
 <CAP-5=fVTEcbJdG6_L+GH5RGCtpFhpjWyyhYu0Fhx5CRRqZcqDg@mail.gmail.com>
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fVTEcbJdG6_L+GH5RGCtpFhpjWyyhYu0Fhx5CRRqZcqDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 2024-01-04 12:51 p.m., Ian Rogers wrote:
> On Thu, Jan 4, 2024 at 6:30=E2=80=AFAM Liang, Kan <kan.liang@linux.inte=
l.com> wrote:
>>
>>
>>
>> On 2024-01-04 8:56 a.m., Ian Rogers wrote:
>>>> Testing tma_slow_pause
>>>> Metric 'tma_slow_pause' not printed in:
>>>> # Running 'internals/synthesize' benchmark:
>>>> Computing performance of single threaded perf event synthesis by
>>>> synthesizing events on the perf process itself:
>>>>   Average synthesis took: 49.987 usec (+- 0.049 usec)
>>>>   Average num. events: 47.000 (+- 0.000)
>>>>   Average time per event 1.064 usec
>>>>   Average data synthesis took: 53.490 usec (+- 0.033 usec)
>>>>   Average num. events: 245.000 (+- 0.000)
>>>>   Average time per event 0.218 usec
>>>>
>>>>  Performance counter stats for 'perf bench internals synthesize':
>>>>
>>>>      <not counted>      cpu_core/TOPDOWN.SLOTS/                     =
                            (0.00%)
>>>>      <not counted>      cpu_core/topdown-retiring/                  =
                            (0.00%)
>>>>      <not counted>      cpu_core/topdown-mem-bound/                 =
                            (0.00%)
>>>>      <not counted>      cpu_core/topdown-bad-spec/                  =
                            (0.00%)
>>>>      <not counted>      cpu_core/topdown-fe-bound/                  =
                            (0.00%)
>>>>      <not counted>      cpu_core/topdown-be-bound/                  =
                            (0.00%)
>>>>      <not counted>      cpu_core/RESOURCE_STALLS.SCOREBOARD/        =
                                (0.00%)
>>>>      <not counted>      cpu_core/EXE_ACTIVITY.1_PORTS_UTIL/         =
                               (0.00%)
>>>>      <not counted>      cpu_core/EXE_ACTIVITY.BOUND_ON_LOADS/       =
                                 (0.00%)
>>>>      <not counted>      cpu_core/CPU_CLK_UNHALTED.PAUSE/            =
                            (0.00%)
>>>>      <not counted>      cpu_core/CYCLE_ACTIVITY.STALLS_TOTAL/       =
                                 (0.00%)
>>>>      <not counted>      cpu_core/CPU_CLK_UNHALTED.THREAD/           =
                             (0.00%)
>>>>      <not counted>      cpu_core/ARITH.DIV_ACTIVE/                  =
                            (0.00%)
>>>>      <not counted>      cpu_core/EXE_ACTIVITY.2_PORTS_UTIL,umask=3D0=
xc/                                        (0.00%)
>>>>      <not counted>      cpu_core/EXE_ACTIVITY.3_PORTS_UTIL,umask=3D0=
x80/                                        (0.00%)
>>>>
>>>>        1.186254766 seconds time elapsed
>>>>
>>>>        0.427220000 seconds user
>>>>        0.752217000 seconds sys
>>>> Testing smi_cycles
>>>> Testing smi_num
>>>> Testing tsx_aborted_cycles
>>>> Testing tsx_cycles_per_elision
>>>> Testing tsx_cycles_per_transaction
>>>> Testing tsx_transactional_cycles
>>>> test child finished with -1
>>>> ---- end ----
>>>> perf all metrics test: FAILED!
>>>> root@number:~#
>>> Have a try disabling the NMI watchdog. Agreed that there is more to
>>> fix here but I think the PMU driver is in part to blame because
>>> manually breaking the weak group of events is a fix.
>>
>> I think we have a NO_GROUP_EVENTS_NMI metric constraint to mark a grou=
p
>> which require disabling of the NMI watchdog.
>> Maybe we should mark the group a NO_GROUP_EVENTS_NMI metric.
>=20
> +Weilin due to the affects of event grouping.
>=20
> Thanks Kan, NO_GROUP_EVENTS_NMI would be good. Something I see for
> tma_ports_utilized_1 that may be worsening things is:
>=20
> ```
> Testing tma_ports_utilized_1
> Metric 'tma_ports_utilized_1' not printed in:
> # Running 'internals/synthesize' benchmark:
> Computing performance of single threaded perf event synthesis by
> synthesizing events on the perf process itself:
>   Average synthesis took: 49.581 usec (+- 0.030 usec)
>   Average num. events: 47.000 (+- 0.000)
>   Average time per event 1.055 usec
>   Average data synthesis took: 53.367 usec (+- 0.032 usec)
>   Average num. events: 246.000 (+- 0.000)
>   Average time per event 0.217 usec
>=20
>  Performance counter stats for 'perf bench internals synthesize':
>=20
>      <not counted>      cpu_core/TOPDOWN.SLOTS/
>                          (0.00%)
>      <not counted>      cpu_core/topdown-retiring/
>                          (0.00%)
>      <not counted>      cpu_core/topdown-mem-bound/
>                          (0.00%)
>      <not counted>      cpu_core/topdown-bad-spec/
>                          (0.00%)
>      <not counted>      cpu_core/topdown-fe-bound/
>                          (0.00%)
>      <not counted>      cpu_core/topdown-be-bound/
>                          (0.00%)
>      <not counted>      cpu_core/RESOURCE_STALLS.SCOREBOARD/
>                              (0.00%)
>      <not counted>      cpu_core/EXE_ACTIVITY.1_PORTS_UTIL/
>                             (0.00%)
>      <not counted>      cpu_core/EXE_ACTIVITY.BOUND_ON_LOADS/
>                               (0.00%)
>      <not counted>      cpu_core/EXE_ACTIVITY.1_PORTS_UTIL/
>                             (0.00%)
>      <not counted>      cpu_core/CYCLE_ACTIVITY.STALLS_TOTAL/
>                               (0.00%)
>      <not counted>      cpu_core/CPU_CLK_UNHALTED.THREAD/
>                           (0.00%)
>      <not counted>      cpu_core/ARITH.DIV_ACTIVE/
>                          (0.00%)
>      <not counted>      cpu_core/EXE_ACTIVITY.2_PORTS_UTIL,umask=3D0xc/=

>                                       (0.00%)
>      <not counted>      cpu_core/EXE_ACTIVITY.3_PORTS_UTIL,umask=3D0x80=
/
>                                        (0.00%)
>=20
>        1.180394056 seconds time elapsed
>=20
>        0.409881000 seconds user
>        0.764134000 seconds sys
> ```
>=20
> The event EXE_ACTIVITY.1_PORTS_UTIL is repeated, this is because the
> metric code deduplicates events based purely on their name and so
> doesn't realize EXE_ACTIVITY.1_PORTS_UTIL is the same as
> cpu_core@EXE_ACTIVITY.1_PORTS_UTIL@. This is a hybrid only glitch as
> we only prefix with a PMU for hybrid metrics, and I should find and
> remove why there's no PMU for the 1 case of EXE_ACTIVITY.1_PORTS_UTIL.
>=20
> This problem doesn't occur for tma_slow_pause and I wondered if you
> could give insight. That metric has the counters below:
> ```
> $ perf stat -M tma_slow_pause -a sleep 0.1
>=20
> Performance counter stats for 'system wide':
>=20
>     <not counted>      cpu_core/TOPDOWN.SLOTS/
>                         (0.00%)
>     <not counted>      cpu_core/topdown-retiring/
>                         (0.00%)
>     <not counted>      cpu_core/topdown-mem-bound/
>                         (0.00%)
>     <not counted>      cpu_core/topdown-bad-spec/
>                         (0.00%)
>     <not counted>      cpu_core/topdown-fe-bound/
>                         (0.00%)
>     <not counted>      cpu_core/topdown-be-bound/
>                         (0.00%)
>     <not counted>      cpu_core/RESOURCE_STALLS.SCOREBOARD/
>                             (0.00%)
>     <not counted>      cpu_core/EXE_ACTIVITY.1_PORTS_UTIL/
>                            (0.00%)
>     <not counted>      cpu_core/EXE_ACTIVITY.BOUND_ON_LOADS/
>                              (0.00%)
>     <not counted>      cpu_core/CPU_CLK_UNHALTED.PAUSE/
>                         (0.00%)
>     <not counted>      cpu_core/CYCLE_ACTIVITY.STALLS_TOTAL/
>                              (0.00%)
>     <not counted>      cpu_core/CPU_CLK_UNHALTED.THREAD/
>                          (0.00%)
>     <not counted>      cpu_core/ARITH.DIV_ACTIVE/
>                         (0.00%)
>     <not counted>      cpu_core/EXE_ACTIVITY.2_PORTS_UTIL,umask=3D0xc/
>                                      (0.00%)
>     <not counted>      cpu_core/EXE_ACTIVITY.3_PORTS_UTIL,umask=3D0x80/=

>                                       (0.00%)
>=20
>       0.102074888 seconds time elapsed
> ```
>=20
> With -vv I see the event string is:
> '{RESOURCE_STALLS.SCOREBOARD/metric-id=3DRESOURCE_STALLS.SCOREBOARD/,cp=
u_core/EXE_ACTIVITY.1_PORTS_UTIL,metric-id=3Dcpu_core!3EXE_ACTIVITY.1_POR=
TS_UTIL!3/,cpu_core/TOPDOWN.SLOTS,metric-id=3Dcpu_core!3TOPDOWN.SLOTS!3/,=
cpu_core/EXE_ACTIVITY.BOUND_ON_LOADS,metric-id=3Dcpu_core!3EXE_ACTIVITY.B=
OUND_ON_LOADS!3/,cpu_core/topdown-retiring,metric-id=3Dcpu_core!3topdown!=
1retiring!3/,cpu_core/topdown-mem-bound,metric-id=3Dcpu_core!3topdown!1me=
m!1bound!3/,cpu_core/topdown-bad-spec,metric-id=3Dcpu_core!3topdown!1bad!=
1spec!3/,CPU_CLK_UNHALTED.PAUSE/metric-id=3DCPU_CLK_UNHALTED.PAUSE/,cpu_c=
ore/CYCLE_ACTIVITY.STALLS_TOTAL,metric-id=3Dcpu_core!3CYCLE_ACTIVITY.STAL=
LS_TOTAL!3/,cpu_core/CPU_CLK_UNHALTED.THREAD,metric-id=3Dcpu_core!3CPU_CL=
K_UNHALTED.THREAD!3/,cpu_core/ARITH.DIV_ACTIVE,metric-id=3Dcpu_core!3ARIT=
H.DIV_ACTIVE!3/,cpu_core/topdown-fe-bound,metric-id=3Dcpu_core!3topdown!1=
fe!1bound!3/,cpu_core/EXE_ACTIVITY.2_PORTS_UTIL,umask=3D0xc,metric-id=3Dc=
pu_core!3EXE_ACTIVITY.2_PORTS_UTIL!0umask!20xc!3/,cpu_core/EXE_ACTIVITY.3=
_PORTS_UTIL,umask=3D0x80,metric-id=3Dcpu_core!3EXE_ACTIVITY.3_PORTS_UTIL!=
0umask!20x80!3/,cpu_core/topdown-be-bound,metric-id=3Dcpu_core!3topdown!1=
be!1bound!3/}:W'
>=20
> which without the metric-ids becomes:
> '{RESOURCE_STALLS.SCOREBOARD,cpu_core/EXE_ACTIVITY.1_PORTS_UTIL/,cpu_co=
re/TOPDOWN.SLOTS/,cpu_core/EXE_ACTIVITY.BOUND_ON_LOADS/,cpu_core/topdown-=
retiring/,cpu_core/topdown-mem-bound/,cpu_core/topdown-bad-spec/,CPU_CLK_=
UNHALTED.PAUSE,cpu_core/CYCLE_ACTIVITY.STALLS_TOTAL/,cpu_core/CPU_CLK_UNH=
ALTED.THREAD/,cpu_core/ARITH.DIV_ACTIVE/,cpu_core/topdown-fe-bound/,cpu_c=
ore/EXE_ACTIVITY.2_PORTS_UTIL,umask=3D0xc/,cpu_core/EXE_ACTIVITY.3_PORTS_=
UTIL,umask=3D0x80/,cpu_core/topdown-be-bound/}:W'
>=20
> I count 9 none slots/top-down counters there, but I see
> CPU_CLK_UNHALTED.THREAD can use fixed counter 1. Should
> perf_event_open fail for a CPU that has a pinned use of a fixed
> counter and the group needs the fixed counter?

I tried, but the idea was rejected.

> I'm guessing you don't
> want this as CPU_CLK_UNHALTED.THREAD can also go on a generic counter
> and the driver doesn't want to count counter usage, it seems feasible
> to add it though. I guess we need a NO_GROUP_EVENTS_NMI whenever
> CPU_CLK_UNHALTED.THREAD is an event and 8 generic counters are in use.

Yes, it looks good to me.

>=20
> Checking on Tigerlake I see:
> ```
> $ perf stat -M tma_slow_pause -a sleep 0.1
>=20
> Performance counter stats for 'system wide':
>=20
>       105,210,913      TOPDOWN.SLOTS                    #      0.1 %
> tma_slow_pause           (72.65%)
>         6,701,129      topdown-retiring
>                         (72.65%)
>        52,359,712      topdown-fe-bound
>                         (72.65%)
>        32,904,532      topdown-be-bound
>                         (72.65%)
>        14,117,814      topdown-bad-spec
>                         (72.65%)
>         6,602,391      RESOURCE_STALLS.SCOREBOARD
>                         (76.17%)
>         4,220,773      cpu/EXE_ACTIVITY.3_PORTS_UTIL,umask=3D0x80/
>                                  (76.73%)
>           421,812      EXE_ACTIVITY.BOUND_ON_STORES
>                         (76.69%)
>         5,164,088      EXE_ACTIVITY.1_PORTS_UTIL
>                         (76.70%)
>           299,681      cpu/INT_MISC.RECOVERY_CYCLES,cmask=3D1,edge/
>                                   (76.69%)
>               245      MISC_RETIRED.PAUSE_INST
>                         (76.67%)
>        58,403,687      CPU_CLK_UNHALTED.THREAD
>                         (76.72%)
>        25,297,841      CYCLE_ACTIVITY.STALLS_MEM_ANY
>                         (76.67%)
>         3,788,772      EXE_ACTIVITY.2_PORTS_UTIL
>                         (62.69%)
>        20,973,875      CYCLE_ACTIVITY.STALLS_TOTAL
>                         (62.16%)
>            68,053      ARITH.DIVIDER_ACTIVE
>                         (62.18%)
>=20
>       0.102624327 seconds time elapsed
> ```
> so 10 generic counters which would never fit and the weak group is
> broken - the difference in the metric explaining why I've not been
> seeing the issue. I think I need to add alderlake/sapphirerapids
> constraints here:
> https://github.com/captain5050/perfmon/blob/main/scripts/create_perf_js=
on.py#L1382
> Ideally we'd automate the constraint generation (or the PMU driver
> would help us out by failing to open the weak group).

Yes, an automation will be great. The NO_GROUP_EVENTS_NMI can be set for
a group which has CPU_CLK_UNHALTED.THREAD and the number of core events
(expect topdown) =3D=3D the max number of GP counters + 1.

Thanks,
Kan
>=20
> Thanks,
> Ian
>=20
>=20
>> Thanks,
>> Kan
>>
>>> Fwiw, if we
>>> switch to the buddy watchdog mechanism then we'll no longer need to
>>> disable the NMI watchdog:
>>> https://lore.kernel.org/lkml/20230421155255.1.I6bf789d21d0c3d75d382e7=
e51a804a7a51315f2c@changeid/
>>
>=20

