Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456917A6840
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 17:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbjISPko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 11:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbjISPkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 11:40:42 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4340BE
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 08:40:31 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-414ba610766so500101cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 08:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695138031; x=1695742831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+L4RfMUcaS7n7sCkiVvlHSrXVQoPmLz/+RreqVEVZU=;
        b=mfF9NQiHUVePrxzH5OPW4jxExezmZXP49wBubdHwcGHoHMIe1YYfIyh7WpCvI5to2r
         1PuKHenaiHtsjrN5pOY93EIJTUTahybo1jK2/16VrBvmBTqMZ9JaTgli1fZA2S5vg6SW
         vl7/kjB/m6fClSbnXXLgn3D0lI1uiqyPRkdbnvtLkOD8/tyJybsOjLrMF3BgsSt3Iqts
         zYJWVQr+goj7KCJrSbReH6dbXD5rATKBkibOFPa+vTTudYvWr2ZNQKbjSESQHRbONg2b
         Tj8/2HztiZ7dEMiY88YHqCPbzHSuFqSCeFBvNg/Gremkju5ni/oI2FfHkUJJKw+/nDDg
         WhbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695138031; x=1695742831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+L4RfMUcaS7n7sCkiVvlHSrXVQoPmLz/+RreqVEVZU=;
        b=jd1927AN4HMqYz1VJO9cuvqsrf2FYj2HBn72b1KbjJRnOipxh4uoZUIA/x0R6v2iaD
         KmIhD9DzrDtc8u08aa0pFFwIGsz/nVbMhZ2BS4fbOh2x/YMPd1xWQL0IkNwYl0SFQFmi
         2gNVBbwH0jKD3+oDqfWfYhD4cPsd+VciLD85bLFZMQu38BBYUptYP5p/pVV7M1P9nDcz
         U6Szyi5XFkrOmFnnFjjqE9MDdBwLA2x6v14Mg9Tq1YW2V1+kLcYIgQ2m7dmpz+oT6KLJ
         Ol8kbt8/lbJlZGwpxqLPwE4+Iabq+pSOlh0Cg2NptXgn6QgBrI2Rlj4fv1EMCFCyiQvP
         x5Jw==
X-Gm-Message-State: AOJu0YwG4YOg1oZonLNwzbC4XhrsSHVVB+/DkejqOem3rW+fwygylWIV
        hq4y7/rRzjkEc5m0CFkCqyQaT5ayxSDnWNMbxz7QvQ==
X-Google-Smtp-Source: AGHT+IEpVKiYVzKTZ3Fanjdmb++kgfxl8/JUbrJpOJAMOL62mq8USx/jq9jy8BDfZVIzfytNOidka3yKmIQwsNOBke0=
X-Received: by 2002:a05:622a:4016:b0:410:a4cb:9045 with SMTP id
 cf22-20020a05622a401600b00410a4cb9045mr303433qtb.18.1695138030517; Tue, 19
 Sep 2023 08:40:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230914211948.814999-1-irogers@google.com> <CAM9d7cgNbRs3LJh_AjqAnRkJzsTxrGr_yqVK-urtoS-B2k1S=w@mail.gmail.com>
 <ZQmfOO0tt9FuIkrj@kernel.org>
In-Reply-To: <ZQmfOO0tt9FuIkrj@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 19 Sep 2023 08:40:16 -0700
Message-ID: <CAP-5=fXn=5SXqHKxaSAxs3bwQifUTVQWnrQb5A6D=3CHygfHLg@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Enable BPF skeletons by default
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nick Terrell <terrelln@fb.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Patrice Duroux <patrice.duroux@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 6:16=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Mon, Sep 18, 2023 at 04:40:15PM -0700, Namhyung Kim escreveu:
> > On Thu, Sep 14, 2023 at 2:20=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > Enable BPF skeletons by default but warn don't fail if they can't be
> > > supported. This was the intended behavior for Linux 6.4 but it caused
> > > an issue captured in this thread:
> > > https://lore.kernel.org/lkml/20230503211801.897735-1-acme@kernel.org/
> > >
> > > This issue isn't repeated here as the previous issue related to
> > > generating vmlinux.h, which is no longer performed by default as a
> > > checked-in vmlinux.h is used instead.
> > >
> > > Unlike with those changes, the BUILD_BPF_SKEL is kept and setting it
> > > to 0 disables BPF skeletons. Also, rather than fail the build due to =
a
> > > missed dependency, dependencies are checked and BPF skeletons disable=
d
> > > if they aren't present.
> > >
> > > Some related commits:
> > > b7a2d774c9c5 perf build: Add ability to build with a generated vmlinu=
x.h
> > > a887466562b4 perf bpf skels: Stop using vmlinux.h generated from BTF,=
 use subset of used structs + CO-RE
> > > a2af0f6b8ef7 perf build: Add system include paths to BPF builds
> > > 5be6cecda080 perf bpf skels: Make vmlinux.h use bpf.h and perf_event.=
h in source directory
> > > 9a2d5178b9d5 Revert "perf build: Make BUILD_BPF_SKEL default, rename =
to NO_BPF_SKEL"
> > > a887466562b4 perf bpf skels: Stop using vmlinux.h generated from BTF,=
 use subset of used structs + CO-RE
> > > 1d7966547e11 perf build: Add warning for when vmlinux.h generation fa=
ils
> > > a980755beb5a perf build: Make BUILD_BPF_SKEL default, rename to NO_BP=
F_SKEL
> > >
> > > Ian Rogers (5):
> > >   perf version: Add status of bpf skeletons
> > >   perf build: Default BUILD_BPF_SKEL, warn/disable for missing deps
> > >   perf test: Update build test for changed BPF skeleton defaults
> > >   perf test: Ensure EXTRA_TESTS is covered in build test
> > >   perf test: Detect off-cpu support from build options
> >
> > Tested-by: Namhyung Kim <namhyung@kernel.org>
>
> Is this verbose by default now? Maybe its something on my side, but I
> noticed a higher level of verbosity, can you check?

I don't see more verbosity. Logs below.

Thanks,
Ian

$ git fetch --all
$ git checkout -b ptn-clean ptn/perf-tools-next
$ b4 am 20230914211948.814999-1-irogers@google.com
$ git am ./20230914_irogers_enable_bpf_skeletons_by_default.mbx
$ make -C tools/perf O=3D/tmp/perf clean
make: Entering directory 'tools/perf'
 CLEAN   x86
 CLEAN   libapi
 CLEAN   libbpf
 CLEAN   libsubcmd
 CLEAN   libsymbol
 CLEAN   libperf
 CLEAN   fixdep
 CLEAN   feature-detect
 CLEAN   python
 CLEAN   bpf-skel
 CLEAN   coresight
 CLEAN   core-objs
 CLEAN   core-progs
 CLEAN   core-gen
 CLEAN   Documentation
make: Leaving directory 'tools/perf'
$ make -C tools/perf O=3D/tmp/perf
make: Entering directory 'tools/perf'
  BUILD:   Doing 'make -j8' parallel build
 HOSTCC  /tmp/perf/fixdep.o
 HOSTLD  /tmp/perf/fixdep-in.o
 LINK    /tmp/perf/fixdep
Warning: Kernel ABI header differences:
 diff -u tools/include/uapi/drm/drm.h include/uapi/drm/drm.h
 diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h
 diff -u tools/include/uapi/linux/mount.h include/uapi/linux/mount.h
 diff -u tools/arch/x86/include/asm/disabled-features.h
arch/x86/include/asm/disabled-features.h
 diff -u tools/arch/x86/include/asm/cpufeatures.h
arch/x86/include/asm/cpufeatures.h
 diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-in=
dex.h
 diff -u tools/arch/x86/include/uapi/asm/prctl.h
arch/x86/include/uapi/asm/prctl.h
 diff -u tools/arch/arm64/include/uapi/asm/perf_regs.h
arch/arm64/include/uapi/asm/perf_regs.h
 diff -u tools/arch/s390/include/uapi/asm/kvm.h arch/s390/include/uapi/asm/=
kvm.h
 diff -u tools/include/uapi/asm-generic/unistd.h
include/uapi/asm-generic/unistd.h
 diff -u tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
arch/x86/entry/syscalls/syscall_64.tbl
 diff -u tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
arch/powerpc/kernel/syscalls/syscall.tbl
 diff -u tools/perf/arch/s390/entry/syscalls/syscall.tbl
arch/s390/kernel/syscalls/syscall.tbl
 diff -u tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
arch/mips/kernel/syscalls/syscall_n64.tbl
 diff -u tools/perf/util/hashmap.h tools/lib/bpf/hashmap.h
Makefile.config:607: No sys/sdt.h found, no SDT events are defined,
please install systemtap-sdt-devel or systemtap-sdt-dev
Makefile.config:1009: No libcap found, disables capability support,
please install libcap-devel/libcap-dev
Makefile.config:1022: No numa.h found, disables 'perf bench numa mem'
benchmark, please install numactl-devel/libnuma-devel/libnuma-dev
Makefile.config:1081: No libbabeltrace found, disables 'perf data' CTF
format support, please install
libbabeltrace-dev[el]/libbabeltrace-ctf-dev

Auto-detecting system features:
...                                   dwarf: [ on  ]
...                      dwarf_getlocations: [ on  ]
...                                   glibc: [ on  ]
...                                  libbfd: [ on  ]
...                          libbfd-buildid: [ on  ]
...                                  libcap: [ OFF ]
...                                  libelf: [ on  ]
...                                 libnuma: [ OFF ]
...                  numa_num_possible_cpus: [ OFF ]
...                                 libperl: [ on  ]
...                               libpython: [ on  ]
...                               libcrypto: [ on  ]
...                               libunwind: [ on  ]
...                      libdw-dwarf-unwind: [ on  ]
...                                    zlib: [ on  ]
...                                    lzma: [ on  ]
...                               get_cpuid: [ on  ]
...                                     bpf: [ on  ]
...                                  libaio: [ on  ]
...                                 libzstd: [ on  ]

 GEN     /tmp/perf/common-cmds.h
 CC      /tmp/perf/jvmti/libjvmti.o
 CC      /tmp/perf/dlfilters/dlfilter-test-api-v0.o
 CC      /tmp/perf/dlfilters/dlfilter-test-api-v2.o
 CC      /tmp/perf/dlfilters/dlfilter-show-cycles.o
 CC      /tmp/perf/jvmti/jvmti_agent.o
 MKDIR   /tmp/perf/libapi/fd/
 INSTALL /tmp/perf/libapi/include/api/cpu.h
 CC      /tmp/perf/libapi/fd/array.o
 INSTALL /tmp/perf/libapi/include/api/debug.h
 INSTALL /tmp/perf/libapi/include/api/io.h
 PERF_VERSION =3D 6.6.rc1.gda192f0aaa30
 CC      /tmp/perf/jvmti/libstring.o
 CC      /tmp/perf/jvmti/libctype.o
 LD      /tmp/perf/libapi/fd/libapi-in.o
 MKDIR   /tmp/perf/libapi/fs/
 CC      /tmp/perf/libperf/core.o
 CC      /tmp/perf/libapi/fs/fs.o
 CC      /tmp/perf/libperf/cpumap.o
 CC      /tmp/perf/libsubcmd/exec-cmd.o
 CC      /tmp/perf/libperf/threadmap.o
 INSTALL /tmp/perf/libperf/include/perf/bpf_perf.h
 LD      /tmp/perf/jvmti/jvmti-in.o
 INSTALL /tmp/perf/libperf/include/perf/core.h
 INSTALL /tmp/perf/libapi/include/api/fd/array.h
 INSTALL /tmp/perf/libsubcmd/include/subcmd/exec-cmd.h
 INSTALL /tmp/perf/libapi/include/api/fs/fs.h
 INSTALL /tmp/perf/libsubcmd/include/subcmd/help.h
 INSTALL /tmp/perf/libsubcmd/include/subcmd/pager.h
 INSTALL /tmp/perf/libapi/include/api/fs/tracing_path.h
 CC      /tmp/perf/libperf/evsel.o
 CC      /tmp/perf/libperf/evlist.o
 INSTALL libapi_headers
 CC      /tmp/perf/libperf/mmap.o
 CC      /tmp/perf/libperf/zalloc.o
 CC      /tmp/perf/libsymbol/kallsyms.o
 CC      /tmp/perf/libperf/xyarray.o
 CC      /tmp/perf/libperf/lib.o
 CC      /tmp/perf/libsubcmd/help.o
 MKDIR   /tmp/perf/libapi/fs/
 CC      /tmp/perf/libapi/fs/tracing_path.o
 CC      /tmp/perf/libsubcmd/pager.o
 INSTALL /tmp/perf/libperf/include/perf/cpumap.h
 CC      /tmp/perf/libapi/cpu.o
 INSTALL /tmp/perf/libperf/include/perf/threadmap.h
 INSTALL /tmp/perf/libperf/include/perf/evlist.h
 INSTALL /tmp/perf/libperf/include/perf/evsel.h
 INSTALL /tmp/perf/libperf/include/perf/event.h
 INSTALL /tmp/perf/libperf/include/perf/mmap.h
 INSTALL /tmp/perf/libperf/include/internal/cpumap.h
 INSTALL /tmp/perf/libperf/include/internal/evlist.h
 INSTALL /tmp/perf/libperf/include/internal/evsel.h
 LD      /tmp/perf/libsymbol/libsymbol-in.o
 LD      /tmp/perf/libperf/libperf-in.o
 INSTALL /tmp/perf/libperf/include/internal/lib.h
 INSTALL /tmp/perf/libperf/include/internal/mmap.h
 INSTALL /tmp/perf/libsymbol/include/symbol/kallsyms.h
 INSTALL /tmp/perf/libsubcmd/include/subcmd/parse-options.h
 INSTALL /tmp/perf/libperf/include/internal/rc_check.h
 CC      /tmp/perf/libapi/fs/cgroup.o
 INSTALL /tmp/perf/libperf/include/internal/threadmap.h
 INSTALL /tmp/perf/libsubcmd/include/subcmd/run-command.h
 AR      /tmp/perf/libsymbol/libsymbol.a
 INSTALL /tmp/perf/libperf/include/internal/xyarray.h
 INSTALL libsymbol_headers
 INSTALL libsubcmd_headers
 LINK    /tmp/perf/libperf-jvmti.so
 AR      /tmp/perf/libperf/libperf.a
 GEN     perf-archive
 GEN     perf-iostat
 LINK    /tmp/perf/dlfilters/dlfilter-test-api-v0.so
 CC      /tmp/perf/libsubcmd/parse-options.o
 LD      /tmp/perf/libapi/fs/libapi-in.o
 GEN     /tmp/perf/libbpf/bpf_helper_defs.h
 CC      /tmp/perf/libapi/debug.o
 LINK    /tmp/perf/dlfilters/dlfilter-test-api-v2.so
 LINK    /tmp/perf/dlfilters/dlfilter-show-cycles.so
 INSTALL libperf_headers
 CC      /tmp/perf/libapi/str_error_r.o
 INSTALL /tmp/perf/libbpf/include/bpf/bpf.h
 INSTALL /tmp/perf/libbpf/include/bpf/libbpf.h
 CC      /tmp/perf/libsubcmd/run-command.o
 INSTALL /tmp/perf/libbpf/include/bpf/btf.h
 INSTALL /tmp/perf/libbpf/include/bpf/libbpf_common.h
 INSTALL /tmp/perf/libbpf/include/bpf/libbpf_legacy.h
 INSTALL /tmp/perf/libbpf/include/bpf/bpf_helpers.h
 INSTALL /tmp/perf/libbpf/include/bpf/bpf_tracing.h
 INSTALL /tmp/perf/libbpf/include/bpf/bpf_endian.h
 INSTALL /tmp/perf/libbpf/include/bpf/bpf_core_read.h
 INSTALL /tmp/perf/libbpf/include/bpf/skel_internal.h
 INSTALL /tmp/perf/libbpf/include/bpf/libbpf_version.h
 LD      /tmp/perf/libapi/libapi-in.o
 INSTALL /tmp/perf/libbpf/include/bpf/bpf_helper_defs.h
 CC      /tmp/perf/libsubcmd/sigchain.o
 MKDIR   /tmp/perf/libbpf/staticobjs/
 CC      /tmp/perf/libbpf/staticobjs/libbpf.o
 AR      /tmp/perf/libapi/libapi.a
 CC      /tmp/perf/libsubcmd/subcmd-config.o
 INSTALL /tmp/perf/libbpf/include/bpf/usdt.bpf.h
 INSTALL libbpf_headers
 MKDIR   /tmp/perf/libbpf/staticobjs/
 CC      /tmp/perf/libbpf/staticobjs/bpf.o
 CC      /tmp/perf/libbpf/staticobjs/nlattr.o
 CC      /tmp/perf/libbpf/staticobjs/btf.o
 CC      /tmp/perf/libbpf/staticobjs/libbpf_errno.o
 CC      /tmp/perf/libbpf/staticobjs/str_error.o
 CC      /tmp/perf/libbpf/staticobjs/netlink.o
 CC      /tmp/perf/libbpf/staticobjs/bpf_prog_linfo.o
 CC      /tmp/perf/libbpf/staticobjs/libbpf_probes.o
 CC      /tmp/perf/libbpf/staticobjs/hashmap.o
 LD      /tmp/perf/libsubcmd/libsubcmd-in.o
 AR      /tmp/perf/libsubcmd/libsubcmd.a
 CC      /tmp/perf/libbpf/staticobjs/btf_dump.o
 CC      /tmp/perf/libbpf/staticobjs/ringbuf.o
 GEN     /tmp/perf/python/perf.cpython-311-x86_64-linux-gnu.so
 CC      /tmp/perf/libbpf/staticobjs/strset.o
 CC      /tmp/perf/libbpf/staticobjs/linker.o
 CC      /tmp/perf/libbpf/staticobjs/gen_loader.o
 CC      /tmp/perf/libbpf/staticobjs/relo_core.o

Auto-detecting system features:
...                         clang-bpf-co-re: [ on  ]
...                                    llvm: [ OFF ]
...                                  libcap: [ OFF ]
...                                  libbfd: [ on  ]

 MKDIR   /tmp/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf
 MKDIR   /tmp/perf/util/bpf_skel/.tmp/bootstrap/
 MKDIR   /tmp/perf/util/bpf_skel/.tmp/bootstrap/libbpf/
 INSTALL /tmp/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/hashmap.=
h
 INSTALL /tmp/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/relo_cor=
e.h
 INSTALL /tmp/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/libbpf_i=
nternal.h
 GEN     /tmp/perf/util/bpf_skel/.tmp/bootstrap/libbpf/bpf_helper_defs.h
 INSTALL /tmp/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/bpf.h
 INSTALL /tmp/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/libbpf.h
 INSTALL /tmp/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/btf.h
 INSTALL /tmp/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/libbpf_c=
ommon.h
 INSTALL /tmp/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/libbpf_l=
egacy.h
 INSTALL /tmp/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/bpf_help=
ers.h
 INSTALL /tmp/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/bpf_trac=
ing.h
 INSTALL /tmp/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/bpf_endi=
an.h
 INSTALL /tmp/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/bpf_core=
_read.h
 INSTALL /tmp/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/skel_int=
ernal.h
 INSTALL /tmp/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/libbpf_v=
ersion.h
 INSTALL /tmp/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/usdt.bpf=
.h
 INSTALL /tmp/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/bpf_help=
er_defs.h
 MKDIR   /tmp/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/
 CC      /tmp/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/libbpf.o
 CC      /tmp/perf/libbpf/staticobjs/usdt.o
 CC      /tmp/perf/libbpf/staticobjs/zip.o
 CC      /tmp/perf/libbpf/staticobjs/elf.o
 MKDIR   /tmp/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/
 CC      /tmp/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/bpf.o
 CC      /tmp/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/nlattr.o
 CC      /tmp/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/btf.o
 CC      /tmp/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/libbpf_er=
rno.o
 CC      /tmp/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/str_error=
.o
 CC      /tmp/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/netlink.o
 CC      /tmp/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/bpf_prog_=
linfo.o
 CC      /tmp/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/libbpf_pr=
obes.o
 CC      /tmp/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/hashmap.o
 CC      /tmp/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/btf_dump.=
o
 CC      /tmp/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/ringbuf.o
 CC      /tmp/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/strset.o
 CC      /tmp/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/linker.o
 CC      /tmp/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/gen_loade=
r.o
 CC      /tmp/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/relo_core=
.o
 CC      /tmp/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/usdt.o
 CC      /tmp/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/zip.o
 CC      /tmp/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/elf.o
 INSTALL libbpf_headers
 LD      /tmp/perf/libbpf/staticobjs/libbpf-in.o
 LINK    /tmp/perf/libbpf/libbpf.a
 LD      /tmp/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/libbpf-in=
.o
 LINK    /tmp/perf/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a
 CC      /tmp/perf/util/bpf_skel/.tmp/bootstrap/main.o
 CC      /tmp/perf/util/bpf_skel/.tmp/bootstrap/common.o
 CC      /tmp/perf/util/bpf_skel/.tmp/bootstrap/json_writer.o
 CC      /tmp/perf/util/bpf_skel/.tmp/bootstrap/gen.o
 CC      /tmp/perf/util/bpf_skel/.tmp/bootstrap/btf.o
 CC      /tmp/perf/util/bpf_skel/.tmp/bootstrap/xlated_dumper.o
 CC      /tmp/perf/util/bpf_skel/.tmp/bootstrap/btf_dumper.o
 CC      /tmp/perf/util/bpf_skel/.tmp/bootstrap/disasm.o
 LINK    /tmp/perf/util/bpf_skel/.tmp/bootstrap/bpftool
 CLANG   /tmp/perf/util/bpf_skel/.tmp/bpf_prog_profiler.bpf.o
 CLANG   /tmp/perf/util/bpf_skel/.tmp/bperf_leader.bpf.o
 CLANG   /tmp/perf/util/bpf_skel/.tmp/bperf_follower.bpf.o
 CLANG   /tmp/perf/util/bpf_skel/.tmp/bperf_cgroup.bpf.o
 CLANG   /tmp/perf/util/bpf_skel/.tmp/func_latency.bpf.o
 CLANG   /tmp/perf/util/bpf_skel/.tmp/off_cpu.bpf.o
 CLANG   /tmp/perf/util/bpf_skel/.tmp/lock_contention.bpf.o
 CLANG   /tmp/perf/util/bpf_skel/.tmp/kwork_trace.bpf.o
 CLANG   /tmp/perf/util/bpf_skel/.tmp/sample_filter.bpf.o
 CLANG   /tmp/perf/util/bpf_skel/.tmp/kwork_top.bpf.o
 CLANG   /tmp/perf/util/bpf_skel/.tmp/bench_uprobe.bpf.o
 CLANG   /tmp/perf/util/bpf_skel/.tmp/augmented_raw_syscalls.bpf.o
 GENSKEL /tmp/perf/util/bpf_skel/bpf_prog_profiler.skel.h
 GENSKEL /tmp/perf/util/bpf_skel/bperf_leader.skel.h
 GENSKEL /tmp/perf/util/bpf_skel/bperf_follower.skel.h
 GENSKEL /tmp/perf/util/bpf_skel/bperf_cgroup.skel.h
 GENSKEL /tmp/perf/util/bpf_skel/func_latency.skel.h
 GENSKEL /tmp/perf/util/bpf_skel/off_cpu.skel.h
 GENSKEL /tmp/perf/util/bpf_skel/bench_uprobe.skel.h
 GENSKEL /tmp/perf/util/bpf_skel/lock_contention.skel.h
 GENSKEL /tmp/perf/util/bpf_skel/kwork_top.skel.h
 GENSKEL /tmp/perf/util/bpf_skel/sample_filter.skel.h
 GENSKEL /tmp/perf/util/bpf_skel/augmented_raw_syscalls.skel.h
 GENSKEL /tmp/perf/util/bpf_skel/kwork_trace.skel.h
 CC      /tmp/perf/builtin-bench.o
 CC      /tmp/perf/builtin-annotate.o
 CC      /tmp/perf/builtin-config.o
 CC      /tmp/perf/builtin-diff.o
 CC      /tmp/perf/builtin-evlist.o
 CC      /tmp/perf/builtin-ftrace.o
 TEST    /tmp/perf/pmu-events/metric_test.log
 GEN     /tmp/perf/pmu-events/pmu-events.c
 CC      /tmp/perf/builtin-help.o
 CC      /tmp/perf/builtin-buildid-list.o
 CC      /tmp/perf/builtin-buildid-cache.o
 CC      /tmp/perf/builtin-kallsyms.o
 CC      /tmp/perf/builtin-list.o
 CC      /tmp/perf/builtin-record.o
 CC      /tmp/perf/builtin-report.o
 CC      /tmp/perf/builtin-stat.o
 CC      /tmp/perf/builtin-top.o
 CC      /tmp/perf/builtin-script.o
 CC      /tmp/perf/builtin-kvm.o
 CC      /tmp/perf/builtin-inject.o
 CC      /tmp/perf/builtin-mem.o
 CC      /tmp/perf/builtin-data.o
 CC      /tmp/perf/builtin-version.o
 CC      /tmp/perf/builtin-c2c.o
 CC      /tmp/perf/builtin-daemon.o
 CC      /tmp/perf/builtin-kmem.o
 CC      /tmp/perf/builtin-kwork.o
 CC      /tmp/perf/builtin-lock.o
 CC      /tmp/perf/builtin-sched.o
 CC      /tmp/perf/builtin-timechart.o
 CC      /tmp/perf/builtin-trace.o
 CC      /tmp/perf/trace/beauty/clone.o
 CC      /tmp/perf/bench/sched-messaging.o
 CC      /tmp/perf/tests/builtin-test.o
 CC      /tmp/perf/bench/sched-pipe.o
 CC      /tmp/perf/bench/sched-seccomp-notify.o
 CC      /tmp/perf/util/arm64-frame-pointer-unwind-support.o
 CC      /tmp/perf/trace/beauty/fcntl.o
 CC      /tmp/perf/bench/syscall.o
 CC      /tmp/perf/util/addr_location.o
 CC      /tmp/perf/trace/beauty/flock.o
 CC      /tmp/perf/bench/mem-functions.o
 CC      /tmp/perf/util/annotate.o
 CC      /tmp/perf/tests/builtin-test-list.o
 CC      /tmp/perf/trace/beauty/fsmount.o
 CC      /tmp/perf/bench/futex-hash.o
 CC      /tmp/perf/trace/beauty/fspick.o
 CC      /tmp/perf/arch/common.o
 CC      /tmp/perf/arch/x86/util/header.o
 CC      /tmp/perf/tests/parse-events.o
 CC      /tmp/perf/trace/beauty/ioctl.o
 CC      /tmp/perf/bench/futex-wake.o
 CC      /tmp/perf/arch/x86/util/tsc.o
 CC      /tmp/perf/trace/beauty/kcmp.o
 CC      /tmp/perf/bench/futex-wake-parallel.o
 CC      /tmp/perf/trace/beauty/mount_flags.o
 CC      /tmp/perf/bench/futex-requeue.o
 CC      /tmp/perf/arch/x86/util/pmu.o
 CC      /tmp/perf/trace/beauty/move_mount.o
 CC      /tmp/perf/trace/beauty/pkey_alloc.o
 CC      /tmp/perf/arch/x86/util/kvm-stat.o
 CC      /tmp/perf/bench/futex-lock-pi.o
 CC      /tmp/perf/trace/beauty/arch_prctl.o
 CC      /tmp/perf/bench/epoll-wait.o
 CC      /tmp/perf/trace/beauty/prctl.o
 CC      /tmp/perf/arch/x86/util/perf_regs.o
 CC      /tmp/perf/bench/epoll-ctl.o
 CC      /tmp/perf/pmu-events/pmu-events.o
 CC      /tmp/perf/trace/beauty/renameat.o
 CC      /tmp/perf/bench/synthesize.o
 CC      /tmp/perf/trace/beauty/sockaddr.o
 CC      /tmp/perf/arch/x86/util/topdown.o
 CC      /tmp/perf/bench/kallsyms-parse.o
 CC      /tmp/perf/trace/beauty/socket.o
 CC      /tmp/perf/arch/x86/util/machine.o
 CC      /tmp/perf/trace/beauty/statx.o
 CC      /tmp/perf/bench/find-bit-bench.o
 CC      /tmp/perf/arch/x86/util/event.o
 CC      /tmp/perf/bench/inject-buildid.o
 CC      /tmp/perf/trace/beauty/sync_file_range.o
 CC      /tmp/perf/bench/evlist-open-close.o
 CC      /tmp/perf/arch/x86/util/evlist.o
 CC      /tmp/perf/trace/beauty/timespec.o
 CC      /tmp/perf/trace/beauty/tracepoints/x86_irq_vectors.o
 CC      /tmp/perf/trace/beauty/tracepoints/x86_msr.o
 CC      /tmp/perf/arch/x86/util/mem-events.o
 CC      /tmp/perf/bench/breakpoint.o
 LD      /tmp/perf/trace/beauty/tracepoints/perf-in.o
 LD      /tmp/perf/trace/beauty/perf-in.o
 CC      /tmp/perf/ui/setup.o
 CC      /tmp/perf/scripts/perl/Perf-Trace-Util/Context.o
 CC      /tmp/perf/ui/helpline.o
 CC      /tmp/perf/arch/x86/util/evsel.o
 CC      /tmp/perf/util/block-info.o
 CC      /tmp/perf/ui/progress.o
 CC      /tmp/perf/ui/util.o
 CC      /tmp/perf/arch/x86/util/iostat.o
 CC      /tmp/perf/bench/pmu-scan.o
 CC      /tmp/perf/ui/hist.o
 CC      /tmp/perf/tests/dso-data.o
 CC      /tmp/perf/ui/stdio/hist.o
 CC      /tmp/perf/bench/uprobe.o
 LD      /tmp/perf/scripts/perl/Perf-Trace-Util/perf-in.o
 CC      /tmp/perf/arch/x86/util/env.o
 CC      /tmp/perf/scripts/python/Perf-Trace-Util/Context.o
 CC      /tmp/perf/util/block-range.o
 CC      /tmp/perf/tests/attr.o
 CC      /tmp/perf/bench/mem-memcpy-x86-64-asm.o
 CC      /tmp/perf/arch/x86/util/dwarf-regs.o
 CC      /tmp/perf/bench/mem-memset-x86-64-asm.o
 LD      /tmp/perf/bench/perf-in.o
 CC      /tmp/perf/builtin-probe.o
 CC      /tmp/perf/arch/x86/util/unwind-libunwind.o
 CC      /tmp/perf/util/build-id.o
 CC      /tmp/perf/tests/vmlinux-kallsyms.o
 CC      /tmp/perf/arch/x86/util/auxtrace.o
 LD      /tmp/perf/scripts/python/Perf-Trace-Util/perf-in.o
 LD      /tmp/perf/scripts/perf-in.o
 CC      /tmp/perf/perf.o
 CC      /tmp/perf/arch/x86/util/archinsn.o
 CC      /tmp/perf/tests/openat-syscall.o
 CC      /tmp/perf/arch/x86/util/intel-pt.o
 CC      /tmp/perf/tests/openat-syscall-all-cpus.o
 CC      /tmp/perf/tests/openat-syscall-tp-fields.o
 CC      /tmp/perf/tests/mmap-basic.o
 CC      /tmp/perf/ui/browser.o
 CC      /tmp/perf/ui/browsers/annotate.o
 CC      /tmp/perf/util/cacheline.o
 CC      /tmp/perf/ui/browsers/hists.o
 CC      /tmp/perf/util/config.o
 CC      /tmp/perf/tests/perf-record.o
 CC      /tmp/perf/tests/evsel-roundtrip-name.o
 CC      /tmp/perf/arch/x86/util/intel-bts.o
 CC      /tmp/perf/ui/tui/setup.o
 CC      /tmp/perf/tests/evsel-tp-sched.o
 CC      /tmp/perf/ui/tui/util.o
 CC      /tmp/perf/ui/browsers/map.o
 CC      /tmp/perf/tests/fdarray.o
 CC      /tmp/perf/ui/browsers/scripts.o
 CC      /tmp/perf/ui/browsers/header.o
 CC      /tmp/perf/ui/tui/helpline.o
 LD      /tmp/perf/arch/x86/util/perf-in.o
 CC      /tmp/perf/arch/x86/tests/regs_load.o
 CC      /tmp/perf/util/copyfile.o
 CC      /tmp/perf/ui/tui/progress.o
 CC      /tmp/perf/arch/x86/tests/dwarf-unwind.o
 CC      /tmp/perf/tests/pmu.o
 CC      /tmp/perf/ui/browsers/res_sample.o
 LD      /tmp/perf/ui/tui/perf-in.o
 CC      /tmp/perf/tests/pmu-events.o
 CC      /tmp/perf/tests/hists_common.o
 CC      /tmp/perf/util/ctype.o
 CC      /tmp/perf/util/db-export.o
 CC      /tmp/perf/arch/x86/tests/arch-tests.o
 CC      /tmp/perf/tests/hists_link.o
 CC      /tmp/perf/arch/x86/tests/sample-parsing.o
 CC      /tmp/perf/arch/x86/tests/hybrid.o
 CC      /tmp/perf/tests/hists_filter.o
 CC      /tmp/perf/arch/x86/tests/intel-pt-test.o
 CC      /tmp/perf/tests/hists_output.o
 CC      /tmp/perf/arch/x86/tests/bp-modify.o
 CC      /tmp/perf/arch/x86/tests/amd-ibs-via-core-pmu.o
 CC      /tmp/perf/util/env.o
 CC      /tmp/perf/tests/hists_cumulate.o
 CC      /tmp/perf/tests/python-use.o
 LD      /tmp/perf/arch/x86/tests/perf-in.o
 LD      /tmp/perf/arch/x86/perf-in.o
 LD      /tmp/perf/pmu-events/pmu-events-in.o
 CC      /tmp/perf/tests/bp_signal.o
 CC      /tmp/perf/tests/bp_signal_overflow.o
 LD      /tmp/perf/arch/perf-in.o
 CC      /tmp/perf/tests/bp_account.o
 CC      /tmp/perf/tests/wp.o
 CC      /tmp/perf/tests/task-exit.o
 CC      /tmp/perf/tests/sw-clock.o
 CC      /tmp/perf/tests/mmap-thread-lookup.o
 CC      /tmp/perf/tests/thread-maps-share.o
 CC      /tmp/perf/util/event.o
 CC      /tmp/perf/tests/switch-tracking.o
 CC      /tmp/perf/tests/keep-tracking.o
 CC      /tmp/perf/tests/code-reading.o
 CC      /tmp/perf/tests/sample-parsing.o
 CC      /tmp/perf/tests/parse-no-sample-id-all.o
 CC      /tmp/perf/tests/kmod-path.o
 LD      /tmp/perf/ui/browsers/perf-in.o
 LD      /tmp/perf/ui/perf-in.o
 CC      /tmp/perf/tests/thread-map.o
 CC      /tmp/perf/tests/topology.o
 CC      /tmp/perf/tests/mem.o
 CC      /tmp/perf/tests/cpumap.o
 CC      /tmp/perf/tests/stat.o
 CC      /tmp/perf/tests/event_update.o
 CC      /tmp/perf/tests/event-times.o
 CC      /tmp/perf/tests/expr.o
 CC      /tmp/perf/tests/backward-ring-buffer.o
 CC      /tmp/perf/tests/sdt.o
 CC      /tmp/perf/tests/is_printable_array.o
 CC      /tmp/perf/tests/bitmap.o
 CC      /tmp/perf/tests/perf-hooks.o
 CC      /tmp/perf/util/evlist.o
 CC      /tmp/perf/tests/unit_number__scnprintf.o
 CC      /tmp/perf/tests/mem2node.o
 CC      /tmp/perf/tests/maps.o
 CC      /tmp/perf/tests/time-utils-test.o
 CC      /tmp/perf/tests/genelf.o
 CC      /tmp/perf/tests/api-io.o
 CC      /tmp/perf/tests/demangle-java-test.o
 CC      /tmp/perf/tests/demangle-ocaml-test.o
 CC      /tmp/perf/tests/pfm.o
 CC      /tmp/perf/tests/parse-metric.o
 CC      /tmp/perf/tests/pe-file-parsing.o
 CC      /tmp/perf/tests/expand-cgroup.o
 CC      /tmp/perf/tests/perf-time-to-tsc.o
 CC      /tmp/perf/tests/dlfilter-test.o
 CC      /tmp/perf/tests/sigtrap.o
 CC      /tmp/perf/tests/event_groups.o
 CC      /tmp/perf/tests/symbols.o
 CC      /tmp/perf/tests/util.o
 CC      /tmp/perf/tests/dwarf-unwind.o
 CC      /tmp/perf/tests/workloads/noploop.o
 CC      /tmp/perf/tests/workloads/thloop.o
 CC      /tmp/perf/tests/workloads/leafloop.o
 CC      /tmp/perf/tests/workloads/sqrtloop.o
 CC      /tmp/perf/tests/workloads/brstack.o
 CC      /tmp/perf/tests/workloads/datasym.o
 CC      /tmp/perf/util/sideband_evlist.o
 CC      /tmp/perf/util/evsel.o
 CC      /tmp/perf/util/evsel_fprintf.o
 CC      /tmp/perf/util/perf_event_attr_fprintf.o
 CC      /tmp/perf/util/evswitch.o
 LD      /tmp/perf/tests/workloads/perf-in.o
 CC      /tmp/perf/util/find_bit.o
 LD      /tmp/perf/tests/perf-in.o
 CC      /tmp/perf/util/get_current_dir_name.o
 CC      /tmp/perf/util/levenshtein.o
 CC      /tmp/perf/util/mmap.o
 CC      /tmp/perf/util/memswap.o
 BISON   /tmp/perf/util/parse-events-bison.c
 CC      /tmp/perf/util/print-events.o
 CC      /tmp/perf/util/tracepoint.o
 CC      /tmp/perf/util/perf_regs.o
 CC      /tmp/perf/util/perf-regs-arch/perf_regs_aarch64.o
 CC      /tmp/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.o
 CC      /tmp/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.o
 CC      /tmp/perf/util/perf-regs-arch/perf_regs_arm.o
 CC      /tmp/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.o
 CC      /tmp/perf/util/scripting-engines/trace-event-perl.o
 CC      /tmp/perf/util/perf-regs-arch/perf_regs_csky.o
 CC      /tmp/perf/util/perf-regs-arch/perf_regs_loongarch.o
 LD      /tmp/perf/util/hisi-ptt-decoder/perf-in.o
 CC      /tmp/perf/util/path.o
 CC      /tmp/perf/util/print_binary.o
 CC      /tmp/perf/util/perf-regs-arch/perf_regs_mips.o
 CC      /tmp/perf/util/arm-spe-decoder/arm-spe-decoder.o
 GEN     /tmp/perf/util/intel-pt-decoder/inat-tables.c
 CC      /tmp/perf/util/intel-pt-decoder/intel-pt-log.o
 CC      /tmp/perf/util/perf-regs-arch/perf_regs_powerpc.o
 CC      /tmp/perf/util/rlimit.o
 CC      /tmp/perf/util/intel-pt-decoder/intel-pt-decoder.o
 CC      /tmp/perf/util/argv_split.o
 CC      /tmp/perf/util/rbtree.o
 CC      /tmp/perf/util/perf-regs-arch/perf_regs_riscv.o
 LD      /tmp/perf/util/arm-spe-decoder/perf-in.o
 CC      /tmp/perf/util/libstring.o
 CC      /tmp/perf/util/perf-regs-arch/perf_regs_s390.o
 CC      /tmp/perf/util/bitmap.o
 CC      /tmp/perf/util/perf-regs-arch/perf_regs_x86.o
 CC      /tmp/perf/util/intel-pt-decoder/intel-pt-insn-decoder.o
 CC      /tmp/perf/util/hweight.o
 LD      /tmp/perf/util/perf-regs-arch/perf-in.o
 CC      /tmp/perf/util/smt.o
 CC      /tmp/perf/util/strbuf.o
 CC      /tmp/perf/util/string.o
 CC      /tmp/perf/util/scripting-engines/trace-event-python.o
 CC      /tmp/perf/util/strlist.o
 CC      /tmp/perf/util/strfilter.o
 CC      /tmp/perf/util/top.o
 CC      /tmp/perf/util/usage.o
 CC      /tmp/perf/util/dso.o
 CC      /tmp/perf/util/dsos.o
 CC      /tmp/perf/util/symbol.o
 CC      /tmp/perf/util/symbol_fprintf.o
 CC      /tmp/perf/util/color.o
 CC      /tmp/perf/util/color_config.o
 CC      /tmp/perf/util/metricgroup.o
 CC      /tmp/perf/util/header.o
 CC      /tmp/perf/util/callchain.o
 CC      /tmp/perf/util/values.o
 CC      /tmp/perf/util/debug.o
 CC      /tmp/perf/util/fncache.o
 CC      /tmp/perf/util/machine.o
 CC      /tmp/perf/util/map.o
 LD      /tmp/perf/util/intel-pt-decoder/perf-in.o
 CC      /tmp/perf/util/maps.o
 LD      /tmp/perf/util/scripting-engines/perf-in.o
 CC      /tmp/perf/util/pstack.o
 CC      /tmp/perf/util/session.o
 CC      /tmp/perf/util/sample-raw.o
 CC      /tmp/perf/util/s390-sample-raw.o
 CC      /tmp/perf/util/amd-sample-raw.o
 CC      /tmp/perf/util/syscalltbl.o
 CC      /tmp/perf/util/ordered-events.o
 CC      /tmp/perf/util/namespaces.o
 CC      /tmp/perf/util/comm.o
 CC      /tmp/perf/util/thread.o
 CC      /tmp/perf/util/thread_map.o
 CC      /tmp/perf/util/parse-events-bison.o
 BISON   /tmp/perf/util/pmu-bison.c
 CC      /tmp/perf/util/pmus.o
 CC      /tmp/perf/util/svghelper.o
 CC      /tmp/perf/util/trace-event-info.o
 CC      /tmp/perf/util/trace-event-scripting.o
 CC      /tmp/perf/util/trace-event.o
 CC      /tmp/perf/util/trace-event-parse.o
 CC      /tmp/perf/util/trace-event-read.o
 CC      /tmp/perf/util/sort.o
 CC      /tmp/perf/util/hist.o
 CC      /tmp/perf/util/util.o
 CC      /tmp/perf/util/cpumap.o
 CC      /tmp/perf/util/affinity.o
 CC      /tmp/perf/util/cputopo.o
 CC      /tmp/perf/util/cgroup.o
 CC      /tmp/perf/util/target.o
 CC      /tmp/perf/util/rblist.o
 CC      /tmp/perf/util/intlist.o
 CC      /tmp/perf/util/vdso.o
 CC      /tmp/perf/util/counts.o
 CC      /tmp/perf/util/stat.o
 CC      /tmp/perf/util/stat-shadow.o
 CC      /tmp/perf/util/stat-display.o
 CC      /tmp/perf/util/perf_api_probe.o
 CC      /tmp/perf/util/record.o
 CC      /tmp/perf/util/srcline.o
 CC      /tmp/perf/util/srccode.o
 CC      /tmp/perf/util/synthetic-events.o
 CC      /tmp/perf/util/data.o
 CC      /tmp/perf/util/tsc.o
 CC      /tmp/perf/util/cloexec.o
 CC      /tmp/perf/util/call-path.o
 CC      /tmp/perf/util/rwsem.o
 CC      /tmp/perf/util/thread-stack.o
 CC      /tmp/perf/util/spark.o
 CC      /tmp/perf/util/topdown.o
 CC      /tmp/perf/util/iostat.o
 CC      /tmp/perf/util/stream.o
 CC      /tmp/perf/util/auxtrace.o
 CC      /tmp/perf/util/intel-pt.o
 CC      /tmp/perf/util/intel-bts.o
 CC      /tmp/perf/util/arm-spe.o
 CC      /tmp/perf/util/hisi-ptt.o
 CC      /tmp/perf/util/s390-cpumsf.o
 CC      /tmp/perf/util/cs-etm-base.o
 CC      /tmp/perf/util/parse-branch-options.o
 CC      /tmp/perf/util/dump-insn.o
 CC      /tmp/perf/util/parse-regs-options.o
 CC      /tmp/perf/util/parse-sublevel-options.o
 CC      /tmp/perf/util/term.o
 CC      /tmp/perf/util/help-unknown-cmd.o
 CC      /tmp/perf/util/dlfilter.o
 CC      /tmp/perf/util/mem-events.o
 CC      /tmp/perf/util/vsprintf.o
 CC      /tmp/perf/util/units.o
 CC      /tmp/perf/util/time-utils.o
 BISON   /tmp/perf/util/expr-bison.c
 CC      /tmp/perf/util/branch.o
 CC      /tmp/perf/util/mem2node.o
 CC      /tmp/perf/util/clockid.o
 CC      /tmp/perf/util/list_sort.o
 CC      /tmp/perf/util/mutex.o
 CC      /tmp/perf/util/sharded_mutex.o
 CC      /tmp/perf/util/bpf_map.o
 CC      /tmp/perf/util/bpf_counter.o
 CC      /tmp/perf/util/bpf_counter_cgroup.o
 CC      /tmp/perf/util/bpf_ftrace.o
 CC      /tmp/perf/util/bpf_off_cpu.o
 BISON   /tmp/perf/util/bpf-filter-bison.c
 CC      /tmp/perf/util/bpf_lock_contention.o
 CC      /tmp/perf/util/bpf_kwork.o
 CC      /tmp/perf/util/bpf_kwork_top.o
 CC      /tmp/perf/util/symbol-elf.o
 CC      /tmp/perf/util/probe-file.o
 CC      /tmp/perf/util/probe-event.o
 CC      /tmp/perf/util/probe-finder.o
 CC      /tmp/perf/util/dwarf-aux.o
 CC      /tmp/perf/util/dwarf-regs.o
 CC      /tmp/perf/util/unwind-libunwind-local.o
 CC      /tmp/perf/util/unwind-libunwind.o
 CC      /tmp/perf/util/data-convert-json.o
 CC      /tmp/perf/util/zlib.o
 CC      /tmp/perf/util/lzma.o
 CC      /tmp/perf/util/zstd.o
 CXX     /tmp/perf/util/demangle-cxx.o
 CC      /tmp/perf/util/demangle-ocaml.o
 CC      /tmp/perf/util/demangle-java.o
 CC      /tmp/perf/util/demangle-rust.o
 CC      /tmp/perf/util/jitdump.o
 CC      /tmp/perf/util/genelf.o
 CC      /tmp/perf/util/genelf_debug.o
 CC      /tmp/perf/util/perf-hooks.o
 CC      /tmp/perf/util/bpf-event.o
 CC      /tmp/perf/util/bpf-utils.o
 CC      /tmp/perf/util/pfm.o
 FLEX    /tmp/perf/util/parse-events-flex.c
 FLEX    /tmp/perf/util/pmu-flex.c
 CC      /tmp/perf/util/pmu-bison.o
 FLEX    /tmp/perf/util/expr-flex.c
 CC      /tmp/perf/util/expr-bison.o
 CC      /tmp/perf/util/expr.o
 FLEX    /tmp/perf/util/bpf-filter-flex.c
 CC      /tmp/perf/util/bpf-filter-bison.o
 CC      /tmp/perf/util/parse-events.o
 CC      /tmp/perf/util/parse-events-flex.o
 CC      /tmp/perf/util/pmu.o
 CC      /tmp/perf/util/pmu-flex.o
 CC      /tmp/perf/util/expr-flex.o
 CC      /tmp/perf/util/bpf-filter.o
 CC      /tmp/perf/util/bpf-filter-flex.o
 LD      /tmp/perf/util/perf-in.o
 LD      /tmp/perf/perf-in.o
 LINK    /tmp/perf/perf
