Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5667F3288
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbjKUPli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234494AbjKUPlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:41:36 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FDF116
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 07:41:31 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507a5edc2ebso3409e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 07:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700581290; x=1701186090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vN98iJok04mhFT1AZ9rPESZWqF/tM5+m7RdbYYi9+ZA=;
        b=XCJhgYTA+EIYJo8adFcLzXOoHHS2AC3kFLT8GhQKSbhwd+0TsLNR3ogCqC1uGlr672
         N9DMg2Wx9ARXYhJaRbpioJ2aXdoE1TUvA31zrwZLvYlYyMCG0d7/TzSP1N97HkO2WjBW
         S8ERZ7nqeNwiMhGPh7Bmeg1uKSs3OHB/vkcbZ+iGxMLwZrJL2ptPX9Kx18jdMtpq3/T4
         l1hkptsJh0P2CYLzylkNT4OCFyOnVV5H3lnIzW/u2b4iDpgh83wzEl20qN7/Gr/Ga7Oe
         Apzv2fKG6IRQ9qliNql3WFITuyblcPjyeNgZx4mz+aTimc20vtfMSoVyyGjMqXPVoXbl
         s/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700581290; x=1701186090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vN98iJok04mhFT1AZ9rPESZWqF/tM5+m7RdbYYi9+ZA=;
        b=DlhQjd2ZkUAitYG76QbD7KCyW409wUjSX6JaT75c+CMS5KK8LFbm37ab4fDIbya8Bl
         IZOy/mYzKby5T8qiBbD3RgZiUnf67h20aLnOVVgMX0weSC0kqcFi0zHCH1pHCLUccl2d
         uGOHjqaWqZ1ZKyolQE8KlN6OXPHYnQZP05pzBpY9bSwhOymNNFnqq8p2ymkVHyAO8VJL
         ikumTckMu/pM4Gxl7DXxLsYDY4hwrqIxLut/KXhzOBapTHMXpNZ1onu2fL9kblUjmuM9
         bzak2Bta/mVFw/PkfEcn827tXJS/h9/+IJjJLVVzhiW5Ani4WPtW2bFtY/fVZQofTJzw
         uJiQ==
X-Gm-Message-State: AOJu0Yw9k/TQAYCqfLmpmGQ0yNViqmtEVDvmBdCZ//O2oJ+t1aQhHYu/
        l+hj7E011FGihHk2xApEeVBbj/Vygl0hqm/Q+fsuVg==
X-Google-Smtp-Source: AGHT+IGu1j48aF+XZlxjSyhQug6UEix1rV5nGAX3HW1Tkmz2sD8xsHcA3Z1RsOAFBQnuGQhUyToPgBxzY+suaGlKO8U=
X-Received: by 2002:a05:6512:2390:b0:4fe:ffbc:ac98 with SMTP id
 c16-20020a056512239000b004feffbcac98mr5668lfv.4.1700581289573; Tue, 21 Nov
 2023 07:41:29 -0800 (PST)
MIME-Version: 1.0
References: <08f1f185-e259-4014-9ca4-6411d5c1bc65@marcan.st>
 <86pm03z0kw.wl-maz@kernel.org> <86o7fnyvrq.wl-maz@kernel.org>
In-Reply-To: <86o7fnyvrq.wl-maz@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 21 Nov 2023 07:41:17 -0800
Message-ID: <CAP-5=fWeyorotfVz_y16ibakSwbNa0fapZoxSZ1nbkt1s=uGbw@mail.gmail.com>
Subject: Re: [REGRESSION] Perf (userspace) broken on big.LITTLE systems since v6.5
To:     Marc Zyngier <maz@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Hector Martin <marcan@marcan.st>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Asahi Linux <asahi@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 7:24=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrote=
:
>
> On Tue, 21 Nov 2023 13:40:31 +0000,
> Marc Zyngier <maz@kernel.org> wrote:
> >
> > [Adding key people on Cc]
> >
> > On Tue, 21 Nov 2023 12:08:48 +0000,
> > Hector Martin <marcan@marcan.st> wrote:
> > >
> > > Perf broke on all Apple ARM64 systems (tested almost everything), and
> > > according to maz also on Juno (so, probably all big.LITTLE) since v6.=
5.
> >
> > I can confirm that at least on 6.7-rc2, perf is pretty busted on any
> > asymmetric ARM platform. It isn't clear what criteria is used to pick
> > the PMU, but nothing works anymore.
> >
> > The saving grace in my case is that Debian still ships a 6.1 perftool
> > package, but that's obviously not going to last.
> >
> > I'm happy to test potential fixes.
>
> At Mark's request, I've dumped a couple of perf (as of -rc2) runs with
> -vvv.  And it is quite entertaining (this is taskset to an 'icestorm'
> CPU):
>
> <quote>
> maz@valley-girl:~/hot-poop/arm-platforms/tools/perf$ sudo taskset -c 0 ./=
perf stat -vvv -e apple_icestorm_pmu/cycles/ -e
>  apple_firestorm_pmu/cycles/ -e cycles ls
> Using CPUID 0x00000000612f0280
> Attempt to add: apple_icestorm_pmu/cycles=3D0/
> ..after resolving event: apple_icestorm_pmu/cycles=3D0/
> Opening: unknown-hardware:HG
> ------------------------------------------------------------
> perf_event_attr:
>   type                             0 (PERF_TYPE_HARDWARE)
>   config                           0xb00000000
>   disabled                         1
> ------------------------------------------------------------
> sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8
> sys_perf_event_open failed, error -95
> Attempt to add: apple_firestorm_pmu/cycles=3D0/
> ..after resolving event: apple_firestorm_pmu/cycles=3D0/
> Control descriptor is not initialized
> Opening: apple_icestorm_pmu/cycles/
> ------------------------------------------------------------
> perf_event_attr:
>   type                             0 (PERF_TYPE_HARDWARE)
>   size                             136
>   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>   disabled                         1
>   inherit                          1
>   enable_on_exec                   1
>   exclude_guest                    1
> ------------------------------------------------------------
> sys_perf_event_open: pid 1045843  cpu -1  group_fd -1  flags 0x8 =3D 3
> Opening: apple_firestorm_pmu/cycles/
> ------------------------------------------------------------
> perf_event_attr:
>   type                             0 (PERF_TYPE_HARDWARE)
>   size                             136
>   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>   disabled                         1
>   inherit                          1
>   enable_on_exec                   1
>   exclude_guest                    1
> ------------------------------------------------------------
> sys_perf_event_open: pid 1045843  cpu -1  group_fd -1  flags 0x8 =3D 4
> Opening: cycles
> ------------------------------------------------------------
> perf_event_attr:
>   type                             0 (PERF_TYPE_HARDWARE)
>   size                             136
>   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>   disabled                         1
>   inherit                          1
>   enable_on_exec                   1
>   exclude_guest                    1
> ------------------------------------------------------------
> sys_perf_event_open: pid 1045843  cpu -1  group_fd -1  flags 0x8 =3D 5
> arch                    builtin-diff.o      builtin-mem.o        common-c=
mds.h    perf-completion.sh
> bench                   builtin-evlist.c    builtin-probe.c      CREDITS =
         perf.h
> Build                   builtin-evlist.o    builtin-probe.o      design.t=
xt       perf-in.o
> builtin-annotate.c      builtin-ftrace.c    builtin-record.c     dlfilter=
s        perf-iostat
> builtin-annotate.o      builtin-ftrace.o    builtin-record.o     Document=
ation    perf-iostat.sh
> builtin-bench.c         builtin.h           builtin-report.c     FEATURE-=
DUMP     perf.o
> builtin-bench.o         builtin-help.c      builtin-report.o     include =
         perf-read-vdso.c
> builtin-buildid-cache.c  builtin-help.o      builtin-sched.c     jvmti   =
         perf-sys.h
> builtin-buildid-cache.o  builtin-inject.c    builtin-script.c    libapi  =
 PERF-VERSION-FILE
> builtin-buildid-list.c  builtin-inject.o    builtin-script.o     libperf =
         perf-with-kcore
> builtin-buildid-list.o  builtin-kallsyms.c  builtin-stat.c       libsubcm=
d        pmu-events
> builtin-c2c.c           builtin-kallsyms.o  builtin-stat.o       libsymbo=
l        python
> builtin-c2c.o           builtin-kmem.c      builtin-timechart.c  Makefile=
         python_ext_build
> builtin-config.c        builtin-kvm.c       builtin-top.c        Makefile=
.config  scripts
> builtin-config.o        builtin-kvm.o       builtin-top.o        Makefile=
.perf    tests
> builtin-daemon.c        builtin-kwork.c     builtin-trace.c      MANIFEST=
         trace
> builtin-daemon.o        builtin-list.c      builtin-version.c    perf    =
         ui
> builtin-data.c          builtin-list.o      builtin-version.o    perf-arc=
hive     util
> builtin-data.o          builtin-lock.c      check-headers.sh     perf-arc=
hive.sh
> builtin-diff.c          builtin-mem.c       command-list.txt     perf.c
> apple_icestorm_pmu/cycles/: -1: 0 873709 0
> apple_firestorm_pmu/cycles/: -1: 0 873709 0
> cycles: -1: 0 873709 0
> apple_icestorm_pmu/cycles/: 0 873709 0
> apple_firestorm_pmu/cycles/: 0 873709 0
> cycles: 0 873709 0
>
>  Performance counter stats for 'ls':
>
>      <not counted>      apple_icestorm_pmu/cycles/                       =
                       (0.00%)
>      <not counted>      apple_firestorm_pmu/cycles/                      =
                       (0.00%)
>      <not counted>      cycles                                           =
                       (0.00%)
>
>        0.000002250 seconds time elapsed
>
>        0.000000000 seconds user
>        0.000000000 seconds sys
> </quote>
>
> If I run the same thing on another CPU cluster (firestorm), I get
> this:
>
> <quote>
> maz@valley-girl:~/hot-poop/arm-platforms/tools/perf$ sudo taskset -c 2 ./=
perf stat -vvv -e apple_icestorm_pmu/cycles/ -e
>  apple_firestorm_pmu/cycles/ -e cycles ls
> Using CPUID 0x00000000612f0280
> Attempt to add: apple_icestorm_pmu/cycles=3D0/
> ..after resolving event: apple_icestorm_pmu/cycles=3D0/
> Opening: unknown-hardware:HG
> ------------------------------------------------------------
> perf_event_attr:
>   type                             0 (PERF_TYPE_HARDWARE)
>   config                           0xb00000000
>   disabled                         1
> ------------------------------------------------------------
> sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8
> sys_perf_event_open failed, error -95
> Attempt to add: apple_firestorm_pmu/cycles=3D0/
> ..after resolving event: apple_firestorm_pmu/cycles=3D0/
> Control descriptor is not initialized
> Opening: apple_icestorm_pmu/cycles/
> ------------------------------------------------------------
> perf_event_attr:
>   type                             0 (PERF_TYPE_HARDWARE)
>   size                             136
>   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>   disabled                         1
>   inherit                          1
>   enable_on_exec                   1
>   exclude_guest                    1
> ------------------------------------------------------------
> sys_perf_event_open: pid 1045925  cpu -1  group_fd -1  flags 0x8 =3D 3
> Opening: apple_firestorm_pmu/cycles/
> ------------------------------------------------------------
> perf_event_attr:
>   type                             0 (PERF_TYPE_HARDWARE)
>   size                             136
>   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>   disabled                         1
>   inherit                          1
>   enable_on_exec                   1
>   exclude_guest                    1
> ------------------------------------------------------------
> sys_perf_event_open: pid 1045925  cpu -1  group_fd -1  flags 0x8 =3D 4
> Opening: cycles
> ------------------------------------------------------------
> perf_event_attr:
>   type                             0 (PERF_TYPE_HARDWARE)
>   size                             136
>   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>   disabled                         1
>   inherit                          1
>   enable_on_exec                   1
>   exclude_guest                    1
> ------------------------------------------------------------
> sys_perf_event_open: pid 1045925  cpu -1  group_fd -1  flags 0x8 =3D 5
> arch                    builtin-diff.o      builtin-mem.o        common-c=
mds.h    perf-completion.sh
> bench                   builtin-evlist.c    builtin-probe.c      CREDITS =
         perf.h
> Build                   builtin-evlist.o    builtin-probe.o      design.t=
xt       perf-in.o
> builtin-annotate.c      builtin-ftrace.c    builtin-record.c     dlfilter=
s        perf-iostat
> builtin-annotate.o      builtin-ftrace.o    builtin-record.o     Document=
ation    perf-iostat.sh
> builtin-bench.c         builtin.h           builtin-report.c     FEATURE-=
DUMP     perf.o
> builtin-bench.o         builtin-help.c      builtin-report.o     include =
         perf-read-vdso.c
> builtin-buildid-cache.c  builtin-help.o      builtin-sched.c     jvmti   =
         perf-sys.h
> builtin-buildid-cache.o  builtin-inject.c    builtin-script.c    libapi  =
 PERF-VERSION-FILE
> builtin-buildid-list.c  builtin-inject.o    builtin-script.o     libperf =
         perf-with-kcore
> builtin-buildid-list.o  builtin-kallsyms.c  builtin-stat.c       libsubcm=
d        pmu-events
> builtin-c2c.c           builtin-kallsyms.o  builtin-stat.o       libsymbo=
l        python
> builtin-c2c.o           builtin-kmem.c      builtin-timechart.c  Makefile=
         python_ext_build
> builtin-config.c        builtin-kvm.c       builtin-top.c        Makefile=
.config  scripts
> builtin-config.o        builtin-kvm.o       builtin-top.o        Makefile=
.perf    tests
> builtin-daemon.c        builtin-kwork.c     builtin-trace.c      MANIFEST=
         trace
> builtin-daemon.o        builtin-list.c      builtin-version.c    perf    =
         ui
> builtin-data.c          builtin-list.o      builtin-version.o    perf-arc=
hive     util
> builtin-data.o          builtin-lock.c      check-headers.sh     perf-arc=
hive.sh
> builtin-diff.c          builtin-mem.c       command-list.txt     perf.c
> apple_icestorm_pmu/cycles/: -1: 1035101 469125 469125
> apple_firestorm_pmu/cycles/: -1: 1035035 469125 469125
> cycles: -1: 1034653 469125 469125
> apple_icestorm_pmu/cycles/: 1035101 469125 469125
> apple_firestorm_pmu/cycles/: 1035035 469125 469125
> cycles: 1034653 469125 469125
>
>  Performance counter stats for 'ls':
>
>          1,035,101      apple_icestorm_pmu/cycles/
>          1,035,035      apple_firestorm_pmu/cycles/
>          1,034,653      cycles
>
>        0.000001333 seconds time elapsed
>
>        0.000000000 seconds user
>        0.000000000 seconds sys
> </quote>
>
> which doesn't make any sense either. I really don't understand what
> this PERF_TYPE_HARDWARE does here (the *real* types are 10 and 11),
> nor what this 'cycle=3D0' stuff is.

Hi Marc,

I'm unclear if you are running a newer perf tool on an older kernel or
not. In any case I'll assume the kernel and perf tool versions match.
In Linux 6.6 this patch was added to the ARM PMU:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/d=
rivers/perf/arm_pmu.c?id=3D5c816728651ae425954542fed64d21d40cb75a9f

My guess is that the apple_icestorm_pmu requires a similar patch. The
perf tool is supposed to not use extended types when they aren't
supported:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/pmus.c?h=3Dperf-tools-next#n532
So I share your confusion as to why something broke.

PERF_TYPE_HARDWARE is a legacy type where there are hardcoded type and
config values that correspond to an event. The PMU driver turns legacy
events into the real types. On BIG.little systems if the legacy events
are monitoring a task a different event is needed for each PMU (ie >1
event). In your example you are monitoring 'ls', a task, and so
different cycles events are necessary. In the high 32-bits (the
extended type) the PMU is identified.

Thanks for reporting the issue,
Ian

> /puzzled
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
