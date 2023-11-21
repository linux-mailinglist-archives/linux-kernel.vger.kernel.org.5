Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A7C7F3349
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbjKUQJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbjKUQJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:09:57 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6DE18E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 08:09:51 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-507c9305727so3749e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 08:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700582989; x=1701187789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+g6ZNjZgw0VerAKZgCKQ8Q7O7zLL0RwErGKIZaz9mc=;
        b=y+tHwY9s+Qn6iuFVHYAfZuXs/E5WDcDEp7GaV0sJhkbAiYdOtECrSUfoXgZr2LWm57
         KkTNqqwJfP92Jtb5dyC8tzijoaR6gqpjx8gY6WEKo9QBfPSY9IyIYUagRq+whRGDhGko
         LbuOCfUPJJtQfVoHUQACj5bVUr51jPvoN3yNZScju/uc2qQgyysfSWmDoXIVRRME/dQm
         4PmyfxioRjb9twol5si5Z38UM7ynr0LNqSdKiErbii50UoCeyCJyRHoJBO/DDRToerFO
         wIxM6aC7tNKbnxipS4il1so6iNSd95nDcvvTYju6vwpkA2ptaS3MMWTIk7W2Ox4IiaqZ
         nvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700582989; x=1701187789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+g6ZNjZgw0VerAKZgCKQ8Q7O7zLL0RwErGKIZaz9mc=;
        b=HvJyjQf3q4sByCbjupKOjtVW/RBC2NtdNJqfKKSVNKMxrPtMkU1qP4r5/HC/cicguH
         O6twOSITh7t4NJ9C0QGoLvmYgBw//S9pgysH0oiBkQLtzhWsOp7FoQOn2UDbCLuJNsrY
         HEoO5hemW4Tgaug4LJ1CPP+9zhtoyCKlndQEQZ1Crc8d6InEMLIECcidIQhg2iZ40tQH
         hibf6lOxMhRLTKZIWy6WDQqq2aXOEgUG+brDSajyLQoQzPunmH6/VjSa/lkd9anHvdI2
         nct6lSNVGK9lXsefD5qegFY/rpZq8ueC6YFUybyaQROvQJCEE2OwrN3iHju5h7Or8E5O
         4QPA==
X-Gm-Message-State: AOJu0YzVllVVP5EGLjy7K8XSSBLVR1LQK+cW3Q4go3cE3CJ+tiZhVChp
        BWl5xprTXhoTISJU8hNErAzN3jvu23e+chCVB268mA==
X-Google-Smtp-Source: AGHT+IG4UtwOil95BJUApTjNEFjH1OGKk15n65KDssZBRHyDiXRZfJ4V4+jne352kKufw9I/IX0Bf73XpvVxe+RlRV4=
X-Received: by 2002:ac2:5635:0:b0:505:6e12:9e70 with SMTP id
 b21-20020ac25635000000b005056e129e70mr289331lff.6.1700582989212; Tue, 21 Nov
 2023 08:09:49 -0800 (PST)
MIME-Version: 1.0
References: <08f1f185-e259-4014-9ca4-6411d5c1bc65@marcan.st>
 <86pm03z0kw.wl-maz@kernel.org> <86o7fnyvrq.wl-maz@kernel.org>
 <ZVzPUjOiH6zpUlz5@FVFF77S0Q05N.cambridge.arm.com> <CAP-5=fUB75DCL4+8YO62iPVsnxoeXGv5cLmT7eP2bHNs=xoMdg@mail.gmail.com>
 <ZVzUr7TWEYPoZrWX@FVFF77S0Q05N.cambridge.arm.com>
In-Reply-To: <ZVzUr7TWEYPoZrWX@FVFF77S0Q05N.cambridge.arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 21 Nov 2023 08:09:37 -0800
Message-ID: <CAP-5=fUWm7efu3xdUBbiifs_KNU1igwAxbXmum=V38SjHQHtXg@mail.gmail.com>
Subject: Re: [REGRESSION] Perf (userspace) broken on big.LITTLE systems since v6.5
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, Hector Martin <marcan@marcan.st>,
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 8:03=E2=80=AFAM Mark Rutland <mark.rutland@arm.com>=
 wrote:
>
> On Tue, Nov 21, 2023 at 07:46:57AM -0800, Ian Rogers wrote:
> > On Tue, Nov 21, 2023 at 7:40=E2=80=AFAM Mark Rutland <mark.rutland@arm.=
com> wrote:
> > >
> > > On Tue, Nov 21, 2023 at 03:24:25PM +0000, Marc Zyngier wrote:
> > > > On Tue, 21 Nov 2023 13:40:31 +0000,
> > > > Marc Zyngier <maz@kernel.org> wrote:
> > > > >
> > > > > [Adding key people on Cc]
> > > > >
> > > > > On Tue, 21 Nov 2023 12:08:48 +0000,
> > > > > Hector Martin <marcan@marcan.st> wrote:
> > > > > >
> > > > > > Perf broke on all Apple ARM64 systems (tested almost everything=
), and
> > > > > > according to maz also on Juno (so, probably all big.LITTLE) sin=
ce v6.5.
> > > > >
> > > > > I can confirm that at least on 6.7-rc2, perf is pretty busted on =
any
> > > > > asymmetric ARM platform. It isn't clear what criteria is used to =
pick
> > > > > the PMU, but nothing works anymore.
> > > > >
> > > > > The saving grace in my case is that Debian still ships a 6.1 perf=
tool
> > > > > package, but that's obviously not going to last.
> > > > >
> > > > > I'm happy to test potential fixes.
> > > >
> > > > At Mark's request, I've dumped a couple of perf (as of -rc2) runs w=
ith
> > > > -vvv.  And it is quite entertaining (this is taskset to an 'icestor=
m'
> > > > CPU):
> > >
> > > IIUC the tool is doing the wrong thing here and overriding explicit
> > > ${pmu}/${event}/ events with PERF_TYPE_HARDWARE events rather than ev=
ents using
> > > that ${pmu}'s type and event namespace.
> > >
> > > Regardless of the *new* ABI that allows PERF_TYPE_HARDWARE events to =
be
> > > targetted to a specific PMU, it's semantically wrong to rewrite event=
s like
> > > this since ${pmu}/${event}/ is not necessarily equivalent to a simila=
rly-named
> > > PERF_COUNT_HW_${EVENT}.
> >
> > If you name a PMU and an event then the event should only be opened on
> > that PMU, 100% agree. There's a bunch of output, but when the legacy
> > cycles event is opened it appears to be because it was explicitly
> > requested.
>
> I think you've missed that the named PMU events are being erreously trans=
formed
> into PERF_TYPE_HARDWARE events. Look at the -vvv output, e.g.
>
>   Opening: apple_firestorm_pmu/cycles/
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             0 (PERF_TYPE_HARDWARE)
>     size                             136
>     config                           0 (PERF_COUNT_HW_CPU_CYCLES)
>     sample_type                      IDENTIFIER
>     read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNIN=
G
>     disabled                         1
>     inherit                          1
>     enable_on_exec                   1
>     exclude_guest                    1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid 1045843  cpu -1  group_fd -1  flags 0x8 =3D 4
>
> ... which should not be PERF_TYPE_HARDWARE && PERF_COUNT_HW_CPU_CYCLES.
>
> Marc said that he bisected the issue down to commit:
>
>   5ea8f2ccffb23983 ("perf parse-events: Support hardware events as terms"=
)
>
> ... so it looks like something is going wrong when the events are being p=
arsed,
> e.g. losing the HW PMU information?

Ok, I think I'm getting confused by other things. This looks like the issue=
.

I think it may be working as intended, but not how you intended :-) If
a core PMU is listed and then a legacy event, the legacy event should
be opened on the core PMU as a legacy event with the extended type
set. This is to allow things like legacy cache events to be opened on
a specified PMU. Legacy event names match with a higher priority than
those in sysfs or json as they are hard coded. Presumably the
expectation was that by advertising a cycles event, presumably in
sysfs, then this is what would be matched.

Thanks,
Ian

> Thanks,
> Mark.
>
> >
> >
> > Thanks,
> > Ian
> >
> > > Mark.
> > >
> > > > <quote>
> > > > maz@valley-girl:~/hot-poop/arm-platforms/tools/perf$ sudo taskset -=
c 0 ./perf stat -vvv -e apple_icestorm_pmu/cycles/ -e
> > > >  apple_firestorm_pmu/cycles/ -e cycles ls
> > > > Using CPUID 0x00000000612f0280
> > > > Attempt to add: apple_icestorm_pmu/cycles=3D0/
> > > > ..after resolving event: apple_icestorm_pmu/cycles=3D0/
> > > > Opening: unknown-hardware:HG
> > > > ------------------------------------------------------------
> > > > perf_event_attr:
> > > >   type                             0 (PERF_TYPE_HARDWARE)
> > > >   config                           0xb00000000
> > > >   disabled                         1
> > > > ------------------------------------------------------------
> > > > sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8
> > > > sys_perf_event_open failed, error -95
> > > > Attempt to add: apple_firestorm_pmu/cycles=3D0/
> > > > ..after resolving event: apple_firestorm_pmu/cycles=3D0/
> > > > Control descriptor is not initialized
> > > > Opening: apple_icestorm_pmu/cycles/
> > > > ------------------------------------------------------------
> > > > perf_event_attr:
> > > >   type                             0 (PERF_TYPE_HARDWARE)
> > > >   size                             136
> > > >   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
> > > >   sample_type                      IDENTIFIER
> > > >   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RU=
NNING
> > > >   disabled                         1
> > > >   inherit                          1
> > > >   enable_on_exec                   1
> > > >   exclude_guest                    1
> > > > ------------------------------------------------------------
> > > > sys_perf_event_open: pid 1045843  cpu -1  group_fd -1  flags 0x8 =
=3D 3
> > > > Opening: apple_firestorm_pmu/cycles/
> > > > ------------------------------------------------------------
> > > > perf_event_attr:
> > > >   type                             0 (PERF_TYPE_HARDWARE)
> > > >   size                             136
> > > >   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
> > > >   sample_type                      IDENTIFIER
> > > >   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RU=
NNING
> > > >   disabled                         1
> > > >   inherit                          1
> > > >   enable_on_exec                   1
> > > >   exclude_guest                    1
> > > > ------------------------------------------------------------
> > > > sys_perf_event_open: pid 1045843  cpu -1  group_fd -1  flags 0x8 =
=3D 4
> > > > Opening: cycles
> > > > ------------------------------------------------------------
> > > > perf_event_attr:
> > > >   type                             0 (PERF_TYPE_HARDWARE)
> > > >   size                             136
> > > >   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
> > > >   sample_type                      IDENTIFIER
> > > >   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RU=
NNING
> > > >   disabled                         1
> > > >   inherit                          1
> > > >   enable_on_exec                   1
> > > >   exclude_guest                    1
> > > > ------------------------------------------------------------
> > > > sys_perf_event_open: pid 1045843  cpu -1  group_fd -1  flags 0x8 =
=3D 5
> > > > arch                  builtin-diff.o      builtin-mem.o        comm=
on-cmds.h    perf-completion.sh
> > > > bench                 builtin-evlist.c    builtin-probe.c      CRED=
ITS          perf.h
> > > > Build                 builtin-evlist.o    builtin-probe.o      desi=
gn.txt       perf-in.o
> > > > builtin-annotate.c    builtin-ftrace.c    builtin-record.c     dlfi=
lters        perf-iostat
> > > > builtin-annotate.o    builtin-ftrace.o    builtin-record.o     Docu=
mentation    perf-iostat.sh
> > > > builtin-bench.c               builtin.h           builtin-report.c =
    FEATURE-DUMP     perf.o
> > > > builtin-bench.o               builtin-help.c      builtin-report.o =
    include          perf-read-vdso.c
> > > > builtin-buildid-cache.c  builtin-help.o      builtin-sched.c   jvmt=
i            perf-sys.h
> > > > builtin-buildid-cache.o  builtin-inject.c    builtin-script.c  liba=
pi   PERF-VERSION-FILE
> > > > builtin-buildid-list.c        builtin-inject.o    builtin-script.o =
    libperf          perf-with-kcore
> > > > builtin-buildid-list.o        builtin-kallsyms.c  builtin-stat.c   =
    libsubcmd        pmu-events
> > > > builtin-c2c.c         builtin-kallsyms.o  builtin-stat.o       libs=
ymbol        python
> > > > builtin-c2c.o         builtin-kmem.c      builtin-timechart.c  Make=
file         python_ext_build
> > > > builtin-config.c      builtin-kvm.c       builtin-top.c        Make=
file.config  scripts
> > > > builtin-config.o      builtin-kvm.o       builtin-top.o        Make=
file.perf    tests
> > > > builtin-daemon.c      builtin-kwork.c     builtin-trace.c      MANI=
FEST         trace
> > > > builtin-daemon.o      builtin-list.c      builtin-version.c    perf=
             ui
> > > > builtin-data.c                builtin-list.o      builtin-version.o=
    perf-archive     util
> > > > builtin-data.o                builtin-lock.c      check-headers.sh =
    perf-archive.sh
> > > > builtin-diff.c                builtin-mem.c       command-list.txt =
    perf.c
> > > > apple_icestorm_pmu/cycles/: -1: 0 873709 0
> > > > apple_firestorm_pmu/cycles/: -1: 0 873709 0
> > > > cycles: -1: 0 873709 0
> > > > apple_icestorm_pmu/cycles/: 0 873709 0
> > > > apple_firestorm_pmu/cycles/: 0 873709 0
> > > > cycles: 0 873709 0
> > > >
> > > >  Performance counter stats for 'ls':
> > > >
> > > >      <not counted>      apple_icestorm_pmu/cycles/                 =
                             (0.00%)
> > > >      <not counted>      apple_firestorm_pmu/cycles/                =
                             (0.00%)
> > > >      <not counted>      cycles                                     =
                             (0.00%)
> > > >
> > > >        0.000002250 seconds time elapsed
> > > >
> > > >        0.000000000 seconds user
> > > >        0.000000000 seconds sys
> > > > </quote>
> > > >
> > > > If I run the same thing on another CPU cluster (firestorm), I get
> > > > this:
> > > >
> > > > <quote>
> > > > maz@valley-girl:~/hot-poop/arm-platforms/tools/perf$ sudo taskset -=
c 2 ./perf stat -vvv -e apple_icestorm_pmu/cycles/ -e
> > > >  apple_firestorm_pmu/cycles/ -e cycles ls
> > > > Using CPUID 0x00000000612f0280
> > > > Attempt to add: apple_icestorm_pmu/cycles=3D0/
> > > > ..after resolving event: apple_icestorm_pmu/cycles=3D0/
> > > > Opening: unknown-hardware:HG
> > > > ------------------------------------------------------------
> > > > perf_event_attr:
> > > >   type                             0 (PERF_TYPE_HARDWARE)
> > > >   config                           0xb00000000
> > > >   disabled                         1
> > > > ------------------------------------------------------------
> > > > sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8
> > > > sys_perf_event_open failed, error -95
> > > > Attempt to add: apple_firestorm_pmu/cycles=3D0/
> > > > ..after resolving event: apple_firestorm_pmu/cycles=3D0/
> > > > Control descriptor is not initialized
> > > > Opening: apple_icestorm_pmu/cycles/
> > > > ------------------------------------------------------------
> > > > perf_event_attr:
> > > >   type                             0 (PERF_TYPE_HARDWARE)
> > > >   size                             136
> > > >   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
> > > >   sample_type                      IDENTIFIER
> > > >   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RU=
NNING
> > > >   disabled                         1
> > > >   inherit                          1
> > > >   enable_on_exec                   1
> > > >   exclude_guest                    1
> > > > ------------------------------------------------------------
> > > > sys_perf_event_open: pid 1045925  cpu -1  group_fd -1  flags 0x8 =
=3D 3
> > > > Opening: apple_firestorm_pmu/cycles/
> > > > ------------------------------------------------------------
> > > > perf_event_attr:
> > > >   type                             0 (PERF_TYPE_HARDWARE)
> > > >   size                             136
> > > >   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
> > > >   sample_type                      IDENTIFIER
> > > >   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RU=
NNING
> > > >   disabled                         1
> > > >   inherit                          1
> > > >   enable_on_exec                   1
> > > >   exclude_guest                    1
> > > > ------------------------------------------------------------
> > > > sys_perf_event_open: pid 1045925  cpu -1  group_fd -1  flags 0x8 =
=3D 4
> > > > Opening: cycles
> > > > ------------------------------------------------------------
> > > > perf_event_attr:
> > > >   type                             0 (PERF_TYPE_HARDWARE)
> > > >   size                             136
> > > >   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
> > > >   sample_type                      IDENTIFIER
> > > >   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RU=
NNING
> > > >   disabled                         1
> > > >   inherit                          1
> > > >   enable_on_exec                   1
> > > >   exclude_guest                    1
> > > > ------------------------------------------------------------
> > > > sys_perf_event_open: pid 1045925  cpu -1  group_fd -1  flags 0x8 =
=3D 5
> > > > arch                  builtin-diff.o      builtin-mem.o        comm=
on-cmds.h    perf-completion.sh
> > > > bench                 builtin-evlist.c    builtin-probe.c      CRED=
ITS          perf.h
> > > > Build                 builtin-evlist.o    builtin-probe.o      desi=
gn.txt       perf-in.o
> > > > builtin-annotate.c    builtin-ftrace.c    builtin-record.c     dlfi=
lters        perf-iostat
> > > > builtin-annotate.o    builtin-ftrace.o    builtin-record.o     Docu=
mentation    perf-iostat.sh
> > > > builtin-bench.c               builtin.h           builtin-report.c =
    FEATURE-DUMP     perf.o
> > > > builtin-bench.o               builtin-help.c      builtin-report.o =
    include          perf-read-vdso.c
> > > > builtin-buildid-cache.c  builtin-help.o      builtin-sched.c   jvmt=
i            perf-sys.h
> > > > builtin-buildid-cache.o  builtin-inject.c    builtin-script.c  liba=
pi   PERF-VERSION-FILE
> > > > builtin-buildid-list.c        builtin-inject.o    builtin-script.o =
    libperf          perf-with-kcore
> > > > builtin-buildid-list.o        builtin-kallsyms.c  builtin-stat.c   =
    libsubcmd        pmu-events
> > > > builtin-c2c.c         builtin-kallsyms.o  builtin-stat.o       libs=
ymbol        python
> > > > builtin-c2c.o         builtin-kmem.c      builtin-timechart.c  Make=
file         python_ext_build
> > > > builtin-config.c      builtin-kvm.c       builtin-top.c        Make=
file.config  scripts
> > > > builtin-config.o      builtin-kvm.o       builtin-top.o        Make=
file.perf    tests
> > > > builtin-daemon.c      builtin-kwork.c     builtin-trace.c      MANI=
FEST         trace
> > > > builtin-daemon.o      builtin-list.c      builtin-version.c    perf=
             ui
> > > > builtin-data.c                builtin-list.o      builtin-version.o=
    perf-archive     util
> > > > builtin-data.o                builtin-lock.c      check-headers.sh =
    perf-archive.sh
> > > > builtin-diff.c                builtin-mem.c       command-list.txt =
    perf.c
> > > > apple_icestorm_pmu/cycles/: -1: 1035101 469125 469125
> > > > apple_firestorm_pmu/cycles/: -1: 1035035 469125 469125
> > > > cycles: -1: 1034653 469125 469125
> > > > apple_icestorm_pmu/cycles/: 1035101 469125 469125
> > > > apple_firestorm_pmu/cycles/: 1035035 469125 469125
> > > > cycles: 1034653 469125 469125
> > > >
> > > >  Performance counter stats for 'ls':
> > > >
> > > >          1,035,101      apple_icestorm_pmu/cycles/
> > > >          1,035,035      apple_firestorm_pmu/cycles/
> > > >          1,034,653      cycles
> > > >
> > > >        0.000001333 seconds time elapsed
> > > >
> > > >        0.000000000 seconds user
> > > >        0.000000000 seconds sys
> > > > </quote>
> > > >
> > > > which doesn't make any sense either. I really don't understand what
> > > > this PERF_TYPE_HARDWARE does here (the *real* types are 10 and 11),
> > > > nor what this 'cycle=3D0' stuff is.
> > > >
> > > > /puzzled
> > > >
> > > >       M.
> > > >
> > > > --
> > > > Without deviation from the norm, progress is not possible.
