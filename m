Return-Path: <linux-kernel+bounces-18104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA568258F6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C01EB212F9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D29D32197;
	Fri,  5 Jan 2024 17:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ayw7z/3H"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F08B32186
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 17:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50e36375f91so3483e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 09:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704475294; x=1705080094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXcIB4EPEFGRNB20l7pccqNzU6cDXX6BdjE9MlIM+c8=;
        b=Ayw7z/3HbMBqqSJeVi7mbJvpvl1U49aAbkNbVYdstMALB4hkLWQW7cigsBzZdxo31k
         Zb077TI2E4PDSNvu247NPpNwqKthGD/ZfcQtKFLB9XbD6jZghbHCTyGKupDxMAGuXqMB
         GUkeZDj29sRq2C6ecu4z1YzcuXH5bYeapjZMWG5y96JwB0sW7gDoauDUPxtcO+DPQS6X
         UbWPYuWZRx3njM4lYaE6mDcn0LMxuElkj692E5CLrAZ0+3xjWX1SJxtmSdckGj8ZBpqi
         OPlnELnuU6q4wjhpTOjZDvu8W9d8/il1We/HYjr/f9epedpNZdvzQzq9De8ourt9UyWf
         ylUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704475294; x=1705080094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yXcIB4EPEFGRNB20l7pccqNzU6cDXX6BdjE9MlIM+c8=;
        b=DsvtGRJ3RbwQjVqpkznGmJ36/2apO37TZPBcrhNf8uInBJm0zu/gCL7cJOYYss9Wvt
         uyMbzpHD3LowTANDR9jH4Ckxmb0gqMZqUC8H0t+sJf5S9g4E7YEXVjgsfUkFrjVg/Qzl
         chReU8jwXKOTQDPxlf288wy0UapU1fgETyjQ1zGFFQ7t062vjlspmQGi7DwIEbNdRhKZ
         Mn1CX2G+0M5nYIMDr5DXqe7TcQT1X8CpF+56fozbWM9lipHPH/IhX/WS4edzKdVer/By
         q+kJN3FRsJrEy67S8flqrbtKBeveTyfzwPdjBSY8B+54Jb38MLYWoxOqzzKCIixrmV3d
         d7Hw==
X-Gm-Message-State: AOJu0YwLbbBBXCfqZT+FWU+MgyPWlJSJuFYYdo28sDwI6tWWw/UvIUgn
	K9t3jOZPk8wVY5Y8O0ZdtxHborf73xNwobecVdS56vtprhB5
X-Google-Smtp-Source: AGHT+IFsofDftMeUxDdH+M4BrqFWaejW86nvFwk+Mh6RMoPch3oWq446AfGueoojmavrF3JvrPL295H7RZ7STx/TVYA=
X-Received: by 2002:a05:6512:348d:b0:50e:7314:e79f with SMTP id
 v13-20020a056512348d00b0050e7314e79fmr105990lfr.4.1704475293973; Fri, 05 Jan
 2024 09:21:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZYbm5L7tw7bdpDpE@kernel.org> <4d86f3b6-eaee-4673-bdf5-3b97c1c1ad17@linux.intel.com>
 <CAP-5=fUfJ-VBGS1D2+WM_eBu4uPGvxJ2KyD4WXzgKRCfGKHTQQ@mail.gmail.com> <ZZfwjG-HL5yOEh6z@FVFF77S0Q05N>
In-Reply-To: <ZZfwjG-HL5yOEh6z@FVFF77S0Q05N>
From: Ian Rogers <irogers@google.com>
Date: Fri, 5 Jan 2024 09:21:21 -0800
Message-ID: <CAP-5=fUK+t1p0g3dKtgyP0g3oixM1G7Xm4BFneY5EMzRW_urdw@mail.gmail.com>
Subject: Re: perf test hybrid failing on 14700K
To: Mark Rutland <mark.rutland@arm.com>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Kan Liang <kan.liang@intel.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 4:05=E2=80=AFAM Mark Rutland <mark.rutland@arm.com> =
wrote:
>
> On Tue, Jan 02, 2024 at 02:41:07PM -0800, Ian Rogers wrote:
> > On Tue, Jan 2, 2024 at 7:43=E2=80=AFAM Liang, Kan <kan.liang@linux.inte=
l.com> wrote:
> > > On 2023-12-23 8:55 a.m., Arnaldo Carvalho de Melo wrote:
> > > > Hi Kan,
> > > >
> > > > I noticed the following problem, are you able to reproduce it?
> > > >
> > > > Happy solstice!
> > >
> > > Happy new year!
>
> Godt nyt=C3=A5r!
>
> > > > - Arnaldo
> > > >
> > > > root@number:/home/acme/Downloads# grep "model name" -m1 /proc/cpuin=
fo
> > > > model name    : Intel(R) Core(TM) i7-14700K
> > > > root@number:/home/acme/Downloads# uname -a
> > > > Linux number 6.6.4-200.fc39.x86_64 #1 SMP PREEMPT_DYNAMIC Sun Dec  =
3 18:13:11 UTC 2023 x86_64 GNU/Linux
> > > > root@number:/home/acme/Downloads# perf -vv
> > > > perf version 6.7.rc6.g63daba4e2861
> > > >                  dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
> > > >     dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
> > > >          syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
> > > >                 libbfd: [ OFF ]  # HAVE_LIBBFD_SUPPORT
> > > >             debuginfod: [ on  ]  # HAVE_DEBUGINFOD_SUPPORT
> > > >                 libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
> > > >                libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
> > > > numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
> > > >                libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
> > > >              libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
> > > >               libslang: [ on  ]  # HAVE_SLANG_SUPPORT
> > > >              libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
> > > >              libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
> > > >     libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
> > > >                   zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
> > > >                   lzma: [ on  ]  # HAVE_LZMA_SUPPORT
> > > >              get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
> > > >                    bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
> > > >                    aio: [ on  ]  # HAVE_AIO_SUPPORT
> > > >                   zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
> > > >                libpfm4: [ on  ]  # HAVE_LIBPFM
> > > >          libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
> > > >          bpf_skeletons: [ on  ]  # HAVE_BPF_SKEL
> > > > root@number:/home/acme/Downloads# perf test 75
> > > >  75: x86 hybrid                                                    =
  : FAILED!
> > >
> > > The failure should be a regression caused by the a24d9d9dc096 ("perf
> > > parse-events: Make legacy events lower priority than sysfs/JSON")
> > >
> > > @@ -1004,10 +1012,19 @@ static int config_term_pmu(struct
> > > perf_event_attr *attr,
> > >                                                            err_str, /=
*help=3D*/NULL);
> > >                         return -EINVAL;
> > >                 }
> > > -               attr->type =3D PERF_TYPE_HARDWARE;
> > > -               attr->config =3D term->val.num;
> > > -               if (perf_pmus__supports_extended_type())
> > > -                       attr->config |=3D (__u64)pmu->type << PERF_PM=
U_TYPE_SHIFT;
> > > +               /*
> > > +                * If the PMU has a sysfs or json event prefer it ove=
r
> > > +                * legacy. ARM requires this.
> > > +                */
> > > +               if (perf_pmu__have_event(pmu, term->config))
> > > For Intel hybrid, the perf_pmu__have_event() should be always true fo=
r
> > > all hw events and hw cache events. So the patch will mistakenly updat=
e
> > > the type to TYPE_USER. However, On Intel platforms, the type of the h=
w
> > > events should be TYPE_HARDWARE.
> > >
> > > Seems ARM needs to find another way to distinguish the case.
> > >
> > > Ian, any suggestions?
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
>
> For the record, I was insistent that the behaviour was *restored*; that w=
as the
> existing behaivour prior to commit:
>
>  5ea8f2ccffb23983 ("perf parse-events: Support hardware events as terms")
>
> ... which was itself a big behaviour change for all architectures, in par=
t led
> to the issue that Hector and Martin were hitting on arm/arm64, and provid=
ed no
> recourse to get the prior behaviour when desired.

Fwiw, I don't agree with the description here. The original issue was
that on ARM perf's behavior had become reliant on the core PMUs being
treated as non-core PMUs in that non-core PMUs don't support things
like legacy events. This is/was unsustainable and once fixed exposed a
second bug where ARM's PMU driver didn't support legacy events
correctly, breaking Hector and Martin. I'm not aware of this issue
being fixed in the driver although the failure has been made clear by
this episode. Fixing the PMU driver wouldn't have fixed older kernels
so there is some sense in fixing the tool too.

In the perf tool we've worked around all the issues brought to us by
the ARM PMU by inverting the priority of legacy and sysfs events. Once
again an issue here and Kan was suggesting inverting the sense for
Intel. I'm working hard to make all PMUs on all architectures work the
same and the priority of legacy and sysfs/JSON events during parsing
is some what arbitrary.

It was argued about PMU namespaces in event parsing, no such concept
exists in perf's event parsing code so for the record I've never
bought this. It seemed an excuse to try push ARM's PMU driver failures
onto the perf tool. I can elaborate but don't see the point in
furthering the argument.

It was requested that ARM provide patches to improve testing coverage
for their PMU in perf test, specifically
tools/perf/tests/parse-events.c where relevant tests are skipped as
the PMU name is hard coded to "cpu" which is conventional for a core
PMU, but not on ARM. Were this testing covering big.LITTLE/hybrid
these issues should have come to light earlier.

While much has been done in the perf tool to work around latent issues
with ARM's PMU drivers and the behavior changes they have instigated,
except for 5c816728651a ("arm_pmu: Add PERF_PMU_CAP_EXTENDED_HW_TYPE
capability") where I wrote the original version, there doesn't seem to
have been progress made on the ARM PMU driver nor on ARM testing -
which was why such an issue could exist for so long, across numerous
Linux releases and ultimately break Hector and Martin.

Fwiw, I have tickets in the UK next week for FurbyFest:
https://www.linkedin.com/posts/csmcr_furbyfest-a-festschrift-for-professor-=
steve-activity-7129811310799642624-YOOe/
if it is useful for me to talk to ARM people face-to-face or with a
convenient timezone.

Thanks,
Ian

> I appreciate that the change I requested was a big behaviour change on x8=
6
> relative to v6.5, but the change above in v6.5 was a big behaviour change=
 on
> arm/arm64 relative to the behaviour established many years prior. I'm sor=
ry
> that I did not catch this earlier at the review stage.
>
> > To get the test passing again I've sent out a test update:
> > https://lore.kernel.org/lkml/20240102215732.1125997-1-irogers@google.co=
m/
>
> FWIW that looks good to me; I've given my Ack there.
>
> Thanks,
> Mark.
>
> > This switches the legacy events in the test to ones which don't have
> > sysfs or json equivalents. The test is somewhat brittle as an x86 PMU
> > change could decide to add /sys/devices/cpu/events/cycles alongside
> > /sys/devices/cpu/events/cpu-cycles. Ideally we'd be testing all events
> > on core PMUs, for legacy events they may have a sysfs/json override
> > and the test expectation should expect this and assert that the type
> > isn't PERF_TYPE_HARDWARE, etc. For now what I sent out is sufficient
> > to get the "x86 hybrid" test passing. I should probably have done the
> > whole Reported-by.. thing, sorry for missing that.
> >
> > Thanks,
> > Ian
> >
> > >
> > > +                       term->type_term =3D PARSE_EVENTS__TERM_TYPE_U=
SER;
> > > +                       term->no_value =3D true;
> > > +               } else {
> > > +                       attr->type =3D PERF_TYPE_HARDWARE;
> > > +                       attr->config =3D term->val.num;
> > > +                       if (perf_pmus__supports_extended_type())
> > > +                               attr->config |=3D (__u64)pmu->type <<=
 PERF_PMU_TYPE_SHIFT;
> > > +               }
> > >                 return 0;
> > >         }
> > >         if (term->type_term =3D=3D PARSE_EVENTS__TERM_TYPE_USER ||
> > >
> > >
> > > Thanks,
> > > Kan
> > > > root@number:/home/acme/Downloads# perf test -v 75
> > > >  75: x86 hybrid                                                    =
  :
> > > > --- start ---
> > > > test child forked, pid 4111587
> > > > Using CPUID GenuineIntel-6-B7-1
> > > > running test 0 'cpu_core/cpu-cycles/'
> > > > FAILED arch/x86/tests/hybrid.c:30 wrong type
> > > > Event test failure: test 0 'cpu_core/cpu-cycles/'running test 1 '{c=
pu_core/cpu-cycles/,cpu_core/instructions/}'
> > > > FAILED arch/x86/tests/hybrid.c:42 wrong type
> > > > Event test failure: test 1 '{cpu_core/cpu-cycles/,cpu_core/instruct=
ions/}'running test 2 '{cpu-clock,cpu_core/cpu-cycles/}'
> > > > FAILED arch/x86/tests/hybrid.c:65 wrong type
> > > > Event test failure: test 2 '{cpu-clock,cpu_core/cpu-cycles/}'runnin=
g test 3 '{cpu_core/cpu-cycles/,cpu-clock}'
> > > > FAILED arch/x86/tests/hybrid.c:78 wrong type
> > > > Event test failure: test 3 '{cpu_core/cpu-cycles/,cpu-clock}'runnin=
g test 4 '{cpu_core/cpu-cycles/k,cpu_core/instructions/u}'
> > > > FAILED arch/x86/tests/hybrid.c:95 wrong type
> > > > Event test failure: test 4 '{cpu_core/cpu-cycles/k,cpu_core/instruc=
tions/u}'running test 5 'r1a'
> > > > running test 6 'cpu_core/r1a/'
> > > > running test 7 'cpu_core/config=3D10,config1,config2=3D3,period=3D1=
000/u'
> > > > WARNING: event 'N/A' not valid (bits 0-1 of config2 '3' not support=
ed by kernel)!
> > > > running test 8 'cpu_core/LLC-loads/'
> > > > test child finished with -1
> > > > ---- end ----
> > > > x86 hybrid: FAILED!
> > > > root@number:/home/acme/Downloads#
> > > >
> > > > root@number:/home/acme/Downloads# perf trace -e perf_event_open per=
f test -F -v 75
> > > >  75: x86 hybrid                                                    =
  :
> > > > --- start ---
> > > > Using CPUID GenuineIntel-6-B7-1
> > > > running test 0 'cpu_core/cpu-cycles/'
> > > > FAILED arch/x86/tests/hybrid.c:30 wrong type
> > > > Event test failure: test 0 'cpu_core/cpu-cycles/'running test 1 '{c=
pu_core/cpu-cycles/,cpu_core/instructions/}'
> > > > FAILED arch/x86/tests/hybrid.c:42 wrong type
> > > > Event test failure: test 1 '{cpu_core/cpu-cycles/,cpu_core/instruct=
ions/}'running test 2 '{cpu-clock,cpu_core/cpu-cycles/}'
> > > > FAILED arch/x86/tests/hybrid.c:65 wrong type
> > > > Event test failure: test 2 '{cpu-clock,cpu_core/cpu-cycles/}'runnin=
g test 3 '{cpu_core/cpu-cycles/,cpu-clock}'
> > > > FAILED arch/x86/tests/hybrid.c:78 wrong type
> > > > Event test failure: test 3 '{cpu_core/cpu-cycles/,cpu-clock}'runnin=
g test 4 '{cpu_core/cpu-cycles/k,cpu_core/instructions/u}'
> > > > FAILED arch/x86/tests/hybrid.c:95 wrong type
> > > > Event test failure: test 4 '{cpu_core/cpu-cycles/k,cpu_core/instruc=
tions/u}'running test 5 'r1a'
> > > > running test 6 'cpu_core/r1a/'
> > > > running test 7 'cpu_core/config=3D10,config1,config2=3D3,period=3D1=
000/u'
> > > > WARNING: event 'N/A' not valid (bits 0-1 of config2 '3' not support=
ed by kernel)!
> > > > running test 8 'cpu_core/LLC-loads/'
> > > > ---- end ----
> > > > x86 hybrid: FAILED!
> > > >      0.000 ( 0.008 ms): :4115165/4115165 perf_event_open(attr_uptr:=
 { type: 0 (PERF_TYPE_HARDWARE), config: 0xa00000000, disabled: 1, { bp_len=
, config2 }: 0x900000000, branch_sample_type: USER|COUNTERS, sample_regs_us=
er: 0x3ecaddffffffff, sample_stack_user: 4115165, clockid: 925535355, sampl=
e_regs_intr: 0x8140c90000a8f7, sample_max_stack: 8, sig_data: 120259084288 =
}, cpu: -1, group_fd: -1, flags: FD_CLOEXEC) =3D 3
> > > >      0.010 ( 0.002 ms): :4115165/4115165 perf_event_open(attr_uptr:=
 { type: 0 (PERF_TYPE_HARDWARE), config: 0x400000000, disabled: 1, { bp_len=
, config2 }: 0x900000000, branch_sample_type: USER|COUNTERS, sample_regs_us=
er: 0x3ecaddffffffff, sample_stack_user: 4115165, clockid: 925538919, sampl=
e_regs_intr: 0x8140c90000a8f7, sample_max_stack: 8, sig_data: 120259084288 =
}, cpu: -1, group_fd: -1, flags: FD_CLOEXEC) =3D 4
> > > > root@number:/home/acme/Downloads# strace -e perf_event_open perf te=
st -F -v 75
> > > >  75: x86 hybrid                                                    =
  :
> > > > --- start ---
> > > > Using CPUID GenuineIntel-6-B7-1
> > > > running test 0 'cpu_core/cpu-cycles/'
> > > > FAILED arch/x86/tests/hybrid.c:30 wrong type
> > > > Event test failure: test 0 'cpu_core/cpu-cycles/'running test 1 '{c=
pu_core/cpu-cycles/,cpu_core/instructions/}'
> > > > FAILED arch/x86/tests/hybrid.c:42 wrong type
> > > > Event test failure: test 1 '{cpu_core/cpu-cycles/,cpu_core/instruct=
ions/}'running test 2 '{cpu-clock,cpu_core/cpu-cycles/}'
> > > > FAILED arch/x86/tests/hybrid.c:65 wrong type
> > > > Event test failure: test 2 '{cpu-clock,cpu_core/cpu-cycles/}'runnin=
g test 3 '{cpu_core/cpu-cycles/,cpu-clock}'
> > > > FAILED arch/x86/tests/hybrid.c:78 wrong type
> > > > Event test failure: test 3 '{cpu_core/cpu-cycles/,cpu-clock}'runnin=
g test 4 '{cpu_core/cpu-cycles/k,cpu_core/instructions/u}'
> > > > FAILED arch/x86/tests/hybrid.c:95 wrong type
> > > > Event test failure: test 4 '{cpu_core/cpu-cycles/k,cpu_core/instruc=
tions/u}'running test 5 'r1a'
> > > > running test 6 'cpu_core/r1a/'
> > > > running test 7 'cpu_core/config=3D10,config1,config2=3D3,period=3D1=
000/u'
> > > > WARNING: event 'N/A' not valid (bits 0-1 of config2 '3' not support=
ed by kernel)!
> > > > running test 8 'cpu_core/LLC-loads/'
> > > > perf_event_open({type=3DPERF_TYPE_HARDWARE, size=3D0 /* PERF_ATTR_S=
IZE_??? */, config=3D0xa<<32|PERF_COUNT_HW_CPU_CYCLES, sample_period=3D0, s=
ample_type=3D0, read_format=3D0, disabled=3D1, precise_ip=3D0 /* arbitrary =
skid */, ...}, 0, -1, -1, PERF_FLAG_FD_CLOEXEC) =3D 3
> > > > perf_event_open({type=3DPERF_TYPE_HARDWARE, size=3D0 /* PERF_ATTR_S=
IZE_??? */, config=3D0x4<<32|PERF_COUNT_HW_CPU_CYCLES, sample_period=3D0, s=
ample_type=3D0, read_format=3D0, disabled=3D1, precise_ip=3D0 /* arbitrary =
skid */, ...}, 0, -1, -1, PERF_FLAG_FD_CLOEXEC) =3D 4
> > > > ---- end ----
> > > > x86 hybrid: FAILED!
> > > > +++ exited with 0 +++
> > > > root@number:/home/acme/Downloads#
> > > >

