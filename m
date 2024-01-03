Return-Path: <linux-kernel+bounces-15751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C4B82314D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07C641C23297
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43871BDD3;
	Wed,  3 Jan 2024 16:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OMx79aPg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549161BDC3
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 16:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50e77dc6880so2588e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 08:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704299504; x=1704904304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSPenRBFWmdb1h2qtTzsGFFArjapO9rniPj5ou4s+TA=;
        b=OMx79aPgnhoJAnnoNN0HzgT09kQCPD5T5XbwuSV23C2GswGlwxLFPiwxjvA5vqrj+r
         vkj8kIbHjCup1RblQ+tcM+vCHz/TpldZ/im2zAoFZduSMvpAfahCiiPEd9MQE6AlTsGx
         RjIMOh5IekNuHpOJ55VvAFq66Zx5SSKiPS/RWQwy39pusCjQcdTUzCdrF/B+BebhJ8D+
         mX+X5Y8KGdWpQa1mh0uCwhmLVwOUI/jforw6ASFSimJ7Zvoo+mm4T0GuJiEJzumDVbRa
         WC+SXQLSmIBvTL2M68/uii96US0nLDVRwt+TiH3wIZmAxXucz0uPHi3x23Yt8sH7crz7
         iWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704299504; x=1704904304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZSPenRBFWmdb1h2qtTzsGFFArjapO9rniPj5ou4s+TA=;
        b=j8lU95xydNoEmEmWB4hfFjlQQ8AIHje2O2Yf18cqvITBJeI2u5IVXMZArzpPJMWL25
         x89Qb3PDvHeU9hrDG1XtLpewZf0LElyxZ2b0q2muaeb3kbJlV2hIIvAYIKDen7bV/PCJ
         OiGUqyZc0dfjRBQVNMKjsPFlSRs7xWNU7km468IYgu8sCGj1r1jIf0tZYc0XoONMb6qG
         hd2L/TMwZ3cFMKCo5eLgCUiYIrSXb9+amyDuGHo4ThDhlLuE2qzQSf7La57UVJILbb5e
         e9EXQSTRyD+ztIejTaHA+UEhvKddlHhspsZzRvyufWjb6S3LCl4R6YOtcL0JIL4ILjBw
         EYnw==
X-Gm-Message-State: AOJu0YwmFZgMKl6kQrxH+T4m/M002BmkWzzlBflVoEnb8UbggUIwNdD2
	RjYw0DNLLUp/P+TcA0Q/CrzoqTVI2kgaBOuIwO/Be/Eo3FjU
X-Google-Smtp-Source: AGHT+IFwGa2dakGugSOe9s32qhg4JffjH7Fbrwz3fmVGqdcWLN+gQMQ6GlmBuudLEBrNNPuP4I1J0ljXYQCxX6CZfs0=
X-Received: by 2002:a05:6512:282a:b0:50e:7314:e79f with SMTP id
 cf42-20020a056512282a00b0050e7314e79fmr125561lfb.4.1704299503387; Wed, 03 Jan
 2024 08:31:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZYbm5L7tw7bdpDpE@kernel.org> <4d86f3b6-eaee-4673-bdf5-3b97c1c1ad17@linux.intel.com>
 <CAP-5=fUfJ-VBGS1D2+WM_eBu4uPGvxJ2KyD4WXzgKRCfGKHTQQ@mail.gmail.com> <48f8d7ff-1ea4-45f1-af74-d4256a64bded@linux.intel.com>
In-Reply-To: <48f8d7ff-1ea4-45f1-af74-d4256a64bded@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 3 Jan 2024 08:31:31 -0800
Message-ID: <CAP-5=fXGoRbc=pQJMqhxnzO6entrTy+k4a6HENHfvom1yUNpcQ@mail.gmail.com>
Subject: Re: perf test hybrid failing on 14700K
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Kan Liang <kan.liang@intel.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 6:16=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.co=
m> wrote:
>
>
>
> On 2024-01-02 5:41 p.m., Ian Rogers wrote:
> > On Tue, Jan 2, 2024 at 7:43=E2=80=AFAM Liang, Kan <kan.liang@linux.inte=
l.com> wrote:
> >>
> >>
> >>
> >> On 2023-12-23 8:55 a.m., Arnaldo Carvalho de Melo wrote:
> >>> Hi Kan,
> >>>
> >>> I noticed the following problem, are you able to reproduce it?
> >>>
> >>> Happy solstice!
> >>
> >> Happy new year!
> >>
> >>>
> >>> - Arnaldo
> >>>
> >>> root@number:/home/acme/Downloads# grep "model name" -m1 /proc/cpuinfo
> >>> model name    : Intel(R) Core(TM) i7-14700K
> >>> root@number:/home/acme/Downloads# uname -a
> >>> Linux number 6.6.4-200.fc39.x86_64 #1 SMP PREEMPT_DYNAMIC Sun Dec  3 =
18:13:11 UTC 2023 x86_64 GNU/Linux
> >>> root@number:/home/acme/Downloads# perf -vv
> >>> perf version 6.7.rc6.g63daba4e2861
> >>>                  dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
> >>>     dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
> >>>          syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
> >>>                 libbfd: [ OFF ]  # HAVE_LIBBFD_SUPPORT
> >>>             debuginfod: [ on  ]  # HAVE_DEBUGINFOD_SUPPORT
> >>>                 libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
> >>>                libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
> >>> numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
> >>>                libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
> >>>              libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
> >>>               libslang: [ on  ]  # HAVE_SLANG_SUPPORT
> >>>              libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
> >>>              libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
> >>>     libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
> >>>                   zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
> >>>                   lzma: [ on  ]  # HAVE_LZMA_SUPPORT
> >>>              get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
> >>>                    bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
> >>>                    aio: [ on  ]  # HAVE_AIO_SUPPORT
> >>>                   zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
> >>>                libpfm4: [ on  ]  # HAVE_LIBPFM
> >>>          libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
> >>>          bpf_skeletons: [ on  ]  # HAVE_BPF_SKEL
> >>> root@number:/home/acme/Downloads# perf test 75
> >>>  75: x86 hybrid                                                      =
: FAILED!
> >>
> >> The failure should be a regression caused by the a24d9d9dc096 ("perf
> >> parse-events: Make legacy events lower priority than sysfs/JSON")
> >>
> >> @@ -1004,10 +1012,19 @@ static int config_term_pmu(struct
> >> perf_event_attr *attr,
> >>                                                            err_str, /*=
help=3D*/NULL);
> >>                         return -EINVAL;
> >>                 }
> >> -               attr->type =3D PERF_TYPE_HARDWARE;
> >> -               attr->config =3D term->val.num;
> >> -               if (perf_pmus__supports_extended_type())
> >> -                       attr->config |=3D (__u64)pmu->type << PERF_PMU=
_TYPE_SHIFT;
> >> +               /*
> >> +                * If the PMU has a sysfs or json event prefer it over
> >> +                * legacy. ARM requires this.
> >> +                */
> >> +               if (perf_pmu__have_event(pmu, term->config))
> >> For Intel hybrid, the perf_pmu__have_event() should be always true for
> >> all hw events and hw cache events. So the patch will mistakenly update
> >> the type to TYPE_USER. However, On Intel platforms, the type of the hw
> >> events should be TYPE_HARDWARE.
> >>
> >> Seems ARM needs to find another way to distinguish the case.
> >>
> >> Ian, any suggestions?
> >
> > Hi Kan/Mark,
> >
> > Firstly, the perf_pmu__have_event is a test of whether
> > /sys/devices/<pmu>/events or the equivalent json events have the
> > specified event string like "inst_retired.any" - ie it isn't a test of
> > whether the event is supported by the kernel. Mark was quite insistent
> > that the behavior be changed so that if a legacy event is specified
> > with a PMU, the PMU's sysfs/json event is the priority which is a big
> > behavior change on x86.
> >
> > To get the test passing again I've sent out a test update:
> > https://lore.kernel.org/lkml/20240102215732.1125997-1-irogers@google.co=
m/
> > This switches the legacy events in the test to ones which don't have
> > sysfs or json equivalents. The test is somewhat brittle as an x86 PMU
> > change could decide to add /sys/devices/cpu/events/cycles alongside
> > /sys/devices/cpu/events/cpu-cycles.
>
> I think the cycles, cpu-cycles, and instructions are treated as
> architectural events in both Linux and X86. I don't think there is a
> plan to change the behavior of the architectural events.
>
> > Ideally we'd be testing all events
> > on core PMUs, for legacy events they may have a sysfs/json override
> > and the test expectation should expect this and assert that the type
> > isn't PERF_TYPE_HARDWARE, etc. For now what I sent out is sufficient
> > to get the "x86 hybrid" test passing.
>
> Before the a24d9d9dc096, the "cpu-cycles" and the "cycles" are
> identical. It should be fine to verify either of them.
>
> But after the a24d9d9dc096, the code path is different.

It isn't so much that the code path is different, after a24d9d9dc096
we prefer events defined in sysfs/json over legacy events, as that
exists for "cpu-cycles" then we get the test failures. Using "cycles"
is a fix purely because /sys/devices/cpu_core/events/cycles doesn't
exist, but this is somewhat arbitrary.

> So maybe it's
> better to verify both of the "cpu-cycles" and the "cycles" in the x86
> hybrid test. Adding a new case something as below should be enough.
>
>         {
>                 .name  =3D "{cpu_core/cpu-cycles/,cpu_core/cycles/}",
>                 .check =3D test__hybrid_hw_group_2_event,
>         },
>
> Thanks,
> Kan

More tests is a good thing, I'll add that in v2 along with the Reported-by.

Thanks,
Ian

> > I should probably have done the
> > whole Reported-by.. thing, sorry for missing that.
> >
> > Thanks,
> > Ian
> >
> >>
> >> +                       term->type_term =3D PARSE_EVENTS__TERM_TYPE_US=
ER;
> >> +                       term->no_value =3D true;
> >> +               } else {
> >> +                       attr->type =3D PERF_TYPE_HARDWARE;
> >> +                       attr->config =3D term->val.num;
> >> +                       if (perf_pmus__supports_extended_type())
> >> +                               attr->config |=3D (__u64)pmu->type << =
PERF_PMU_TYPE_SHIFT;
> >> +               }
> >>                 return 0;
> >>         }
> >>         if (term->type_term =3D=3D PARSE_EVENTS__TERM_TYPE_USER ||
> >>
> >>
> >> Thanks,
> >> Kan
> >>> root@number:/home/acme/Downloads# perf test -v 75
> >>>  75: x86 hybrid                                                      =
:
> >>> --- start ---
> >>> test child forked, pid 4111587
> >>> Using CPUID GenuineIntel-6-B7-1
> >>> running test 0 'cpu_core/cpu-cycles/'
> >>> FAILED arch/x86/tests/hybrid.c:30 wrong type
> >>> Event test failure: test 0 'cpu_core/cpu-cycles/'running test 1 '{cpu=
_core/cpu-cycles/,cpu_core/instructions/}'
> >>> FAILED arch/x86/tests/hybrid.c:42 wrong type
> >>> Event test failure: test 1 '{cpu_core/cpu-cycles/,cpu_core/instructio=
ns/}'running test 2 '{cpu-clock,cpu_core/cpu-cycles/}'
> >>> FAILED arch/x86/tests/hybrid.c:65 wrong type
> >>> Event test failure: test 2 '{cpu-clock,cpu_core/cpu-cycles/}'running =
test 3 '{cpu_core/cpu-cycles/,cpu-clock}'
> >>> FAILED arch/x86/tests/hybrid.c:78 wrong type
> >>> Event test failure: test 3 '{cpu_core/cpu-cycles/,cpu-clock}'running =
test 4 '{cpu_core/cpu-cycles/k,cpu_core/instructions/u}'
> >>> FAILED arch/x86/tests/hybrid.c:95 wrong type
> >>> Event test failure: test 4 '{cpu_core/cpu-cycles/k,cpu_core/instructi=
ons/u}'running test 5 'r1a'
> >>> running test 6 'cpu_core/r1a/'
> >>> running test 7 'cpu_core/config=3D10,config1,config2=3D3,period=3D100=
0/u'
> >>> WARNING: event 'N/A' not valid (bits 0-1 of config2 '3' not supported=
 by kernel)!
> >>> running test 8 'cpu_core/LLC-loads/'
> >>> test child finished with -1
> >>> ---- end ----
> >>> x86 hybrid: FAILED!
> >>> root@number:/home/acme/Downloads#
> >>>
> >>> root@number:/home/acme/Downloads# perf trace -e perf_event_open perf =
test -F -v 75
> >>>  75: x86 hybrid                                                      =
:
> >>> --- start ---
> >>> Using CPUID GenuineIntel-6-B7-1
> >>> running test 0 'cpu_core/cpu-cycles/'
> >>> FAILED arch/x86/tests/hybrid.c:30 wrong type
> >>> Event test failure: test 0 'cpu_core/cpu-cycles/'running test 1 '{cpu=
_core/cpu-cycles/,cpu_core/instructions/}'
> >>> FAILED arch/x86/tests/hybrid.c:42 wrong type
> >>> Event test failure: test 1 '{cpu_core/cpu-cycles/,cpu_core/instructio=
ns/}'running test 2 '{cpu-clock,cpu_core/cpu-cycles/}'
> >>> FAILED arch/x86/tests/hybrid.c:65 wrong type
> >>> Event test failure: test 2 '{cpu-clock,cpu_core/cpu-cycles/}'running =
test 3 '{cpu_core/cpu-cycles/,cpu-clock}'
> >>> FAILED arch/x86/tests/hybrid.c:78 wrong type
> >>> Event test failure: test 3 '{cpu_core/cpu-cycles/,cpu-clock}'running =
test 4 '{cpu_core/cpu-cycles/k,cpu_core/instructions/u}'
> >>> FAILED arch/x86/tests/hybrid.c:95 wrong type
> >>> Event test failure: test 4 '{cpu_core/cpu-cycles/k,cpu_core/instructi=
ons/u}'running test 5 'r1a'
> >>> running test 6 'cpu_core/r1a/'
> >>> running test 7 'cpu_core/config=3D10,config1,config2=3D3,period=3D100=
0/u'
> >>> WARNING: event 'N/A' not valid (bits 0-1 of config2 '3' not supported=
 by kernel)!
> >>> running test 8 'cpu_core/LLC-loads/'
> >>> ---- end ----
> >>> x86 hybrid: FAILED!
> >>>      0.000 ( 0.008 ms): :4115165/4115165 perf_event_open(attr_uptr: {=
 type: 0 (PERF_TYPE_HARDWARE), config: 0xa00000000, disabled: 1, { bp_len, =
config2 }: 0x900000000, branch_sample_type: USER|COUNTERS, sample_regs_user=
: 0x3ecaddffffffff, sample_stack_user: 4115165, clockid: 925535355, sample_=
regs_intr: 0x8140c90000a8f7, sample_max_stack: 8, sig_data: 120259084288 },=
 cpu: -1, group_fd: -1, flags: FD_CLOEXEC) =3D 3
> >>>      0.010 ( 0.002 ms): :4115165/4115165 perf_event_open(attr_uptr: {=
 type: 0 (PERF_TYPE_HARDWARE), config: 0x400000000, disabled: 1, { bp_len, =
config2 }: 0x900000000, branch_sample_type: USER|COUNTERS, sample_regs_user=
: 0x3ecaddffffffff, sample_stack_user: 4115165, clockid: 925538919, sample_=
regs_intr: 0x8140c90000a8f7, sample_max_stack: 8, sig_data: 120259084288 },=
 cpu: -1, group_fd: -1, flags: FD_CLOEXEC) =3D 4
> >>> root@number:/home/acme/Downloads# strace -e perf_event_open perf test=
 -F -v 75
> >>>  75: x86 hybrid                                                      =
:
> >>> --- start ---
> >>> Using CPUID GenuineIntel-6-B7-1
> >>> running test 0 'cpu_core/cpu-cycles/'
> >>> FAILED arch/x86/tests/hybrid.c:30 wrong type
> >>> Event test failure: test 0 'cpu_core/cpu-cycles/'running test 1 '{cpu=
_core/cpu-cycles/,cpu_core/instructions/}'
> >>> FAILED arch/x86/tests/hybrid.c:42 wrong type
> >>> Event test failure: test 1 '{cpu_core/cpu-cycles/,cpu_core/instructio=
ns/}'running test 2 '{cpu-clock,cpu_core/cpu-cycles/}'
> >>> FAILED arch/x86/tests/hybrid.c:65 wrong type
> >>> Event test failure: test 2 '{cpu-clock,cpu_core/cpu-cycles/}'running =
test 3 '{cpu_core/cpu-cycles/,cpu-clock}'
> >>> FAILED arch/x86/tests/hybrid.c:78 wrong type
> >>> Event test failure: test 3 '{cpu_core/cpu-cycles/,cpu-clock}'running =
test 4 '{cpu_core/cpu-cycles/k,cpu_core/instructions/u}'
> >>> FAILED arch/x86/tests/hybrid.c:95 wrong type
> >>> Event test failure: test 4 '{cpu_core/cpu-cycles/k,cpu_core/instructi=
ons/u}'running test 5 'r1a'
> >>> running test 6 'cpu_core/r1a/'
> >>> running test 7 'cpu_core/config=3D10,config1,config2=3D3,period=3D100=
0/u'
> >>> WARNING: event 'N/A' not valid (bits 0-1 of config2 '3' not supported=
 by kernel)!
> >>> running test 8 'cpu_core/LLC-loads/'
> >>> perf_event_open({type=3DPERF_TYPE_HARDWARE, size=3D0 /* PERF_ATTR_SIZ=
E_??? */, config=3D0xa<<32|PERF_COUNT_HW_CPU_CYCLES, sample_period=3D0, sam=
ple_type=3D0, read_format=3D0, disabled=3D1, precise_ip=3D0 /* arbitrary sk=
id */, ...}, 0, -1, -1, PERF_FLAG_FD_CLOEXEC) =3D 3
> >>> perf_event_open({type=3DPERF_TYPE_HARDWARE, size=3D0 /* PERF_ATTR_SIZ=
E_??? */, config=3D0x4<<32|PERF_COUNT_HW_CPU_CYCLES, sample_period=3D0, sam=
ple_type=3D0, read_format=3D0, disabled=3D1, precise_ip=3D0 /* arbitrary sk=
id */, ...}, 0, -1, -1, PERF_FLAG_FD_CLOEXEC) =3D 4
> >>> ---- end ----
> >>> x86 hybrid: FAILED!
> >>> +++ exited with 0 +++
> >>> root@number:/home/acme/Downloads#
> >>>
> >

