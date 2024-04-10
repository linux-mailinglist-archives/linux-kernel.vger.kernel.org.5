Return-Path: <linux-kernel+bounces-139348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E708A01AB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0766428352F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387EA1836C4;
	Wed, 10 Apr 2024 21:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6A0DnFX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDA3181BA1;
	Wed, 10 Apr 2024 21:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712783131; cv=none; b=aZU0+88NVtuvpurFlfJ1i/dMAY4VREt7uzi4OG70A2ee1sioCHypOCZKQwsvCqhbNwivxDi8NTB4rhGb6Z6t6FxPyYOZDq20HEK4X4qP0ikxq29yNnDvtpmDZbZHBpWo1gw1qWQm+WSgPDpwMgFU6yH1QAvwx2T1lxKmNspz0Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712783131; c=relaxed/simple;
	bh=dFDZffkTUYGV+P0ImBWIzXSsj/YRrxYkSZXtuwDs+dA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPAnPc76KxceYwP+z1SuJlqgQkFcak+fraqWFYr8HKXLaf5tLBg/dT6yUFexpEUcApHxHWsQ8Oqm9CbK/rIuj8bOYi5XKfL+GVOjwPw7m74bM5IUFnV/EzYDRyLTrB8pFZTZiqMLFPHlASq7KltErBQExQgMljJeAyv7Os+o9Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6A0DnFX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 443B6C433C7;
	Wed, 10 Apr 2024 21:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712783130;
	bh=dFDZffkTUYGV+P0ImBWIzXSsj/YRrxYkSZXtuwDs+dA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j6A0DnFXtzATeIn09HKfVSohxITGpw2CHwj2iDn28/iftBwur0p55PJTGDnOU13BT
	 SAR1re39PBigXhDJ8uMmXrPEwUyMK9n9zIA/iYD1OeIw9dYSO/KdQ6b+EvpwWfEfZv
	 g4Ba8XI7oQlEQZLImoxOCgXWdY788UdG6o0uFQbwhNJkax6VswAtqAbMZzlJu5k9Vo
	 KQy9UaOwi9OgOJFzqjYxHHB9EtU71gM7gglXkYG7pik1oxBhauLpjUM+SFomfbRYVO
	 d9r/pmeZSb0YPDg4IP51yZLo6z8KJibC6Tbx/4K2w9mgRnVa4B7KH0cnwPOdClUvX+
	 KcAsB4qUlc21g==
Date: Wed, 10 Apr 2024 18:05:27 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 3/6] perf annotate-data: Add
 hist_entry__annotate_data_tui()
Message-ID: <Zhb_F6hvWrjMcoM1@x1>
References: <20240409235000.1893969-1-namhyung@kernel.org>
 <20240409235000.1893969-4-namhyung@kernel.org>
 <Zhb0raj1yW8JhuFW@x1>
 <Zhb-17CrgZt_PdUH@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zhb-17CrgZt_PdUH@x1>

On Wed, Apr 10, 2024 at 06:04:26PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Apr 10, 2024 at 05:21:01PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Tue, Apr 09, 2024 at 04:49:57PM -0700, Namhyung Kim wrote:
> > > Support data type profiling output on TUI.
> > 
> > Added the follow to the commit log message, to make reviewing easier.
> > 
> > As followup patches I think having the DSO name together with the type
> > is important, also I think we could have a first menu with all the pairs
> > of DSO/type, sorted top down by the types with most samples, wdyt?
> > 
> > Applied.
> > 
> 
> There is something else here with the static build, checking...

Probably because of:

Makefile.config:810: slang not found, disables TUI support. Please install slang-devel, libslang-dev or libslang2-dev

Fixing...

- Arnaldo
 
> [acme@toolbox perf-tools-next]$ git log --oneline -1 ; time make -C tools/perf build-test
> 4876ac6ab208b470 (HEAD -> perf-tools-next) perf tests: Remove dependency on lscpu
> make: Entering directory '/home/acme/git/perf-tools-next/tools/perf'
> - tarpkg: ./tests/perf-targz-src-pkg .
>                  make_static: cd . && make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 NO_LIBTRACEEVENT=1 NO_LIBELF=1 -j28  DESTDIR=/tmp/tmp.jEtl6s5Npt
> cd . && make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 NO_LIBTRACEEVENT=1 NO_LIBELF=1 -j28 DESTDIR=/tmp/tmp.jEtl6s5Npt
>   BUILD:   Doing 'make -j28' parallel build
>   HOSTCC  fixdep.o
>   HOSTLD  fixdep-in.o
>   LINK    fixdep
> Warning: Kernel ABI header differences:
>   diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_drm.h
>   diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h
>   diff -u tools/include/linux/bits.h include/linux/bits.h
>   diff -u tools/arch/x86/include/asm/disabled-features.h arch/x86/include/asm/disabled-features.h
>   diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h
>   diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h
>   diff -u tools/arch/x86/include/uapi/asm/kvm.h arch/x86/include/uapi/asm/kvm.h
>   diff -u tools/arch/powerpc/include/uapi/asm/kvm.h arch/powerpc/include/uapi/asm/kvm.h
>   diff -u tools/arch/s390/include/uapi/asm/kvm.h arch/s390/include/uapi/asm/kvm.h
>   diff -u tools/arch/arm64/include/uapi/asm/kvm.h arch/arm64/include/uapi/asm/kvm.h
>   diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h
>   diff -u tools/perf/trace/beauty/arch/x86/include/asm/irq_vectors.h arch/x86/include/asm/irq_vectors.h
>   diff -u tools/perf/trace/beauty/include/uapi/linux/fs.h include/uapi/linux/fs.h
>   diff -u tools/perf/trace/beauty/include/uapi/linux/vhost.h include/uapi/linux/vhost.h
>   diff -u tools/perf/trace/beauty/include/uapi/sound/asound.h include/uapi/sound/asound.h
> Makefile.config:689: Warning: Disabled BPF skeletons as libelf is required by bpftool
> Makefile.config:730: Disabling post unwind, no support found.
> Makefile.config:798: No libcrypto.h found, disables jitted code injection, please install openssl-devel or libssl-dev
> Makefile.config:810: slang not found, disables TUI support. Please install slang-devel, libslang-dev or libslang2-dev
> Makefile.config:857: Missing perl devel files. Disabling perl scripting support, please install perl-ExtUtils-Embed/libperl-dev
> Makefile.config:897: No 'Python.h' was found: disables Python support - please install python-devel/python-dev
> Makefile.config:997: No liblzma found, disables xz kernel module decompression, please install xz-devel/liblzma-dev
> Makefile.config:1010: No libzstd found, disables trace compression, please install libzstd-dev[el] and/or set LIBZSTD_DIR
> Makefile.config:1021: No libcap found, disables capability support, please install libcap-devel/libcap-dev
> Makefile.config:1034: No numa.h found, disables 'perf bench numa mem' benchmark, please install numactl-devel/libnuma-devel/libnuma-dev
> Makefile.config:1093: No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
> Makefile.config:1105: No libcapstone found, disables disasm engine support for 'perf script', please install libcapstone-dev/capstone-devel
> Makefile.config:1170: libpfm4 not found, disables libpfm4 support. Please install libpfm4-dev
> 
> Auto-detecting system features:
> ...                                   dwarf: [ OFF ]
> ...                      dwarf_getlocations: [ OFF ]
> ...                                   glibc: [ on  ]
> ...                                  libbfd: [ OFF ]
> ...                          libbfd-buildid: [ OFF ]
> ...                                  libcap: [ OFF ]
> ...                                  libelf: [ OFF ]
> ...                                 libnuma: [ OFF ]
> ...                  numa_num_possible_cpus: [ OFF ]
> ...                                 libperl: [ OFF ]
> ...                               libpython: [ OFF ]
> ...                               libcrypto: [ OFF ]
> ...                               libunwind: [ OFF ]
> ...                      libdw-dwarf-unwind: [ OFF ]
> ...                             libcapstone: [ OFF ]
> ...                                    zlib: [ OFF ]
> ...                                    lzma: [ OFF ]
> ...                               get_cpuid: [ on  ]
> ...                                     bpf: [ on  ]
> ...                                  libaio: [ on  ]
> ...                                 libzstd: [ OFF ]
> 
>   GEN     common-cmds.h
>   CC      dlfilters/dlfilter-test-api-v0.o
>   CC      dlfilters/dlfilter-test-api-v2.o
>   CC      dlfilters/dlfilter-show-cycles.o
>   LINK    dlfilters/dlfilter-show-cycles.so
>   GEN     /home/acme/git/perf-tools-next/tools/perf/arch/arm64/include/generated/asm/sysreg-defs.h
>   LINK    dlfilters/dlfilter-test-api-v0.so
>   LINK    dlfilters/dlfilter-test-api-v2.so
>   PERF_VERSION = 6.8.g4876ac6ab208
>   GEN     perf-archive
>   GEN     perf-iostat
>   INSTALL /home/acme/git/perf-tools-next/tools/perf/libsubcmd/include/subcmd/exec-cmd.h
>   INSTALL /home/acme/git/perf-tools-next/tools/perf/libsubcmd/include/subcmd/help.h
>   INSTALL /home/acme/git/perf-tools-next/tools/perf/libsubcmd/include/subcmd/pager.h
>   INSTALL /home/acme/git/perf-tools-next/tools/perf/libsubcmd/include/subcmd/parse-options.h
>   INSTALL /home/acme/git/perf-tools-next/tools/perf/libsubcmd/include/subcmd/run-command.h
>   CC      /home/acme/git/perf-tools-next/tools/perf/libsubcmd/help.o
>   CC      /home/acme/git/perf-tools-next/tools/perf/libsubcmd/exec-cmd.o
>   CC      /home/acme/git/perf-tools-next/tools/perf/libsubcmd/pager.o
>   CC      /home/acme/git/perf-tools-next/tools/perf/libsubcmd/parse-options.o
>   CC      /home/acme/git/perf-tools-next/tools/perf/libsubcmd/run-command.o
>   CC      /home/acme/git/perf-tools-next/tools/perf/libsubcmd/sigchain.o
>   CC      /home/acme/git/perf-tools-next/tools/perf/libsubcmd/subcmd-config.o
>   INSTALL libsubcmd_headers
>   LD      /home/acme/git/perf-tools-next/tools/perf/libsubcmd/libsubcmd-in.o
>   INSTALL /home/acme/git/perf-tools-next/tools/perf/libperf/include/perf/bpf_perf.h
>   INSTALL /home/acme/git/perf-tools-next/tools/perf/libperf/include/perf/cpumap.h
>   INSTALL /home/acme/git/perf-tools-next/tools/perf/libperf/include/perf/core.h
>   INSTALL /home/acme/git/perf-tools-next/tools/perf/libapi/include/api/cpu.h
>   INSTALL /home/acme/git/perf-tools-next/tools/perf/libperf/include/perf/threadmap.h
>   INSTALL /home/acme/git/perf-tools-next/tools/perf/libperf/include/perf/evlist.h
>   INSTALL /home/acme/git/perf-tools-next/tools/perf/libperf/include/perf/event.h
>   INSTALL /home/acme/git/perf-tools-next/tools/perf/libperf/include/perf/mmap.h
>   INSTALL /home/acme/git/perf-tools-next/tools/perf/libperf/include/perf/evsel.h
>   INSTALL /home/acme/git/perf-tools-next/tools/perf/libperf/include/internal/cpumap.h
>   INSTALL /home/acme/git/perf-tools-next/tools/perf/libapi/include/api/debug.h
>   CC      /home/acme/git/perf-tools-next/tools/perf/libperf/core.o
>   INSTALL /home/acme/git/perf-tools-next/tools/perf/libperf/include/internal/evlist.h
>   INSTALL /home/acme/git/perf-tools-next/tools/perf/libperf/include/internal/evsel.h
>   INSTALL /home/acme/git/perf-tools-next/tools/perf/libapi/include/api/fd/array.h
>   INSTALL /home/acme/git/perf-tools-next/tools/perf/libapi/include/api/io.h
>   CC      /home/acme/git/perf-tools-next/tools/perf/libperf/cpumap.o
>   INSTALL /home/acme/git/perf-tools-next/tools/perf/libperf/include/internal/lib.h
>   INSTALL /home/acme/git/perf-tools-next/tools/perf/libperf/include/internal/mmap.h
>   CC      /home/acme/git/perf-tools-next/tools/perf/libperf/threadmap.o
>   INSTALL /home/acme/git/perf-tools-next/tools/perf/libapi/include/api/fs/fs.h
>   INSTALL /home/acme/git/perf-tools-next/tools/perf/libapi/include/api/fs/tracing_path.h
>   CC      /home/acme/git/perf-tools-next/tools/perf/libperf/evsel.o
>   CC      /home/acme/git/perf-tools-next/tools/perf/libperf/evlist.o
>   INSTALL /home/acme/git/perf-tools-next/tools/perf/libperf/include/internal/rc_check.h
>   INSTALL /home/acme/git/perf-tools-next/tools/perf/libperf/include/internal/threadmap.h
>   MKDIR   /home/acme/git/perf-tools-next/tools/perf/libapi/fd/
>   INSTALL /home/acme/git/perf-tools-next/tools/perf/libperf/include/internal/xyarray.h
>   CC      /home/acme/git/perf-tools-next/tools/perf/libperf/mmap.o
>   CC      /home/acme/git/perf-tools-next/tools/perf/libapi/cpu.o
>   CC      /home/acme/git/perf-tools-next/tools/perf/libperf/zalloc.o
>   CC      /home/acme/git/perf-tools-next/tools/perf/libperf/xyarray.o
>   MKDIR   /home/acme/git/perf-tools-next/tools/perf/libapi/fs/
>   CC      /home/acme/git/perf-tools-next/tools/perf/libperf/lib.o
>   MKDIR   /home/acme/git/perf-tools-next/tools/perf/libapi/fs/
>   INSTALL libapi_headers
>   CC      /home/acme/git/perf-tools-next/tools/perf/libapi/fd/array.o
>   MKDIR   /home/acme/git/perf-tools-next/tools/perf/libapi/fs/
>   INSTALL libperf_headers
>   CC      /home/acme/git/perf-tools-next/tools/perf/libapi/debug.o
>   CC      /home/acme/git/perf-tools-next/tools/perf/libapi/str_error_r.o
>   CC      /home/acme/git/perf-tools-next/tools/perf/libapi/fs/fs.o
>   AR      /home/acme/git/perf-tools-next/tools/perf/libsubcmd/libsubcmd.a
>   CC      /home/acme/git/perf-tools-next/tools/perf/libapi/fs/tracing_path.o
>   CC      /home/acme/git/perf-tools-next/tools/perf/libapi/fs/cgroup.o
>   INSTALL /home/acme/git/perf-tools-next/tools/perf/libsymbol/include/symbol/kallsyms.h
>   CC      /home/acme/git/perf-tools-next/tools/perf/libsymbol/kallsyms.o
>   LD      /home/acme/git/perf-tools-next/tools/perf/libperf/libperf-in.o
>   LD      /home/acme/git/perf-tools-next/tools/perf/libapi/fd/libapi-in.o
>   INSTALL libsymbol_headers
>   LD      /home/acme/git/perf-tools-next/tools/perf/libapi/fs/libapi-in.o
>   AR      /home/acme/git/perf-tools-next/tools/perf/libperf/libperf.a
>   LD      /home/acme/git/perf-tools-next/tools/perf/libsymbol/libsymbol-in.o
>   LD      /home/acme/git/perf-tools-next/tools/perf/libapi/libapi-in.o
>   AR      /home/acme/git/perf-tools-next/tools/perf/libsymbol/libsymbol.a
>   AR      /home/acme/git/perf-tools-next/tools/perf/libapi/libapi.a
>   CC      builtin-bench.o
>   CC      builtin-annotate.o
>   CC      builtin-config.o
>   CC      builtin-diff.o
>   CC      builtin-evlist.o
>   CC      builtin-ftrace.o
>   CC      builtin-help.o
>   CC      builtin-buildid-list.o
>   CC      builtin-buildid-cache.o
>   CC      builtin-kallsyms.o
>   CC      builtin-list.o
>   CC      builtin-record.o
>   CC      builtin-report.o
>   CC      builtin-stat.o
>   CC      builtin-top.o
>   CC      builtin-script.o
>   CC      builtin-kvm.o
>   CC      builtin-inject.o
>   CC      builtin-mem.o
>   TEST    pmu-events/metric_test.log
>   CC      builtin-data.o
>   CC      builtin-version.o
>   CC      builtin-c2c.o
>   CC      builtin-daemon.o
>   CC      bench/sched-messaging.o
>   CC      arch/common.o
>   CC      tests/builtin-test.o
>   CC      perf.o
>   CC      ui/setup.o
>   LD      scripts/perf-in.o
>   CC      tests/tests-scripts.o
>   CC      bench/sched-pipe.o
>   CC      tests/parse-events.o
>   CC      ui/helpline.o
>   CC      tests/dso-data.o
>   CC      bench/sched-seccomp-notify.o
>   CC      tests/attr.o
>   CC      tests/vmlinux-kallsyms.o
>   CC      ui/progress.o
>   CC      bench/syscall.o
>   CC      tests/perf-record.o
>   CC      arch/x86/util/header.o
>   CC      ui/util.o
>   CC      bench/mem-functions.o
>   CC      tests/evsel-roundtrip-name.o
>   CC      tests/fdarray.o
>   CC      tests/pmu.o
>   CC      arch/x86/tests/arch-tests.o
>   CC      ui/hist.o
>   CC      bench/futex-hash.o
>   CC      bench/futex-wake.o
>   CC      bench/futex-wake-parallel.o
>   CC      arch/x86/tests/sample-parsing.o
>   CC      arch/x86/tests/hybrid.o
>   CC      tests/pmu-events.o
>   CC      arch/x86/tests/intel-pt-test.o
>   CC      arch/x86/util/tsc.o
>   CC      ui/stdio/hist.o
>   CC      bench/futex-requeue.o
>   CC      bench/futex-lock-pi.o
>   CC      arch/x86/util/pmu.o
>   CC      tests/hists_common.o
>   CC      arch/x86/tests/bp-modify.o
>   CC      arch/x86/util/perf_regs.o
>   CC      arch/x86/util/topdown.o
>   CC      bench/epoll-wait.o
>   CC      arch/x86/tests/amd-ibs-via-core-pmu.o
>   CC      arch/x86/util/machine.o
>   CC      tests/hists_link.o
>   CC      bench/epoll-ctl.o
>   CC      arch/x86/util/event.o
>   CC      bench/synthesize.o
>   CC      tests/hists_filter.o
>   CC      arch/x86/util/evlist.o
>   CC      bench/kallsyms-parse.o
>   CC      arch/x86/util/mem-events.o
>   CC      bench/find-bit-bench.o
>   CC      tests/hists_output.o
>   CC      bench/inject-buildid.o
>   CC      bench/evlist-open-close.o
>   CC      tests/hists_cumulate.o
>   CC      tests/python-use.o
>   CC      bench/breakpoint.o
>   CC      arch/x86/util/evsel.o
>   LD      ui/perf-in.o
>   CC      tests/bp_signal.o
>   CC      arch/x86/util/iostat.o
>   CC      bench/pmu-scan.o
>   CC      bench/uprobe.o
>   CC      arch/x86/util/env.o
>   CC      util/arm64-frame-pointer-unwind-support.o
>   CC      util/addr_location.o
>   CC      bench/mem-memcpy-x86-64-asm.o
>   LD      arch/x86/tests/perf-in.o
>   CC      tests/bp_signal_overflow.o
>   CC      arch/x86/util/auxtrace.o
>   CC      bench/mem-memset-x86-64-asm.o
>   CC      arch/x86/util/archinsn.o
>   CC      tests/bp_account.o
>   CC      arch/x86/util/intel-pt.o
>   CC      util/annotate.o
>   CC      arch/x86/util/intel-bts.o
>   CC      util/block-info.o
>   CC      tests/wp.o
>   CC      util/block-range.o
>   CC      util/build-id.o
>   CC      tests/task-exit.o
>   CC      util/cacheline.o
>   CC      util/config.o
>   CC      tests/sw-clock.o
>   CC      util/copyfile.o
>   CC      tests/mmap-thread-lookup.o
>   CC      util/ctype.o
>   CC      tests/thread-maps-share.o
>   CC      tests/keep-tracking.o
>   CC      util/db-export.o
>   CC      tests/code-reading.o
>   CC      util/disasm.o
>   LD      bench/perf-in.o
>   CC      util/env.o
>   CC      tests/sample-parsing.o
>   CC      util/event.o
>   CC      tests/parse-no-sample-id-all.o
>   CC      tests/kmod-path.o
>   CC      tests/thread-map.o
>   CC      util/evlist.o
>   CC      tests/topology.o
>   CC      util/sideband_evlist.o
>   LD      arch/x86/util/perf-in.o
>   CC      util/evsel.o
>   CC      tests/mem.o
>   CC      util/evsel_fprintf.o
>   CC      tests/cpumap.o
>   CC      tests/stat.o
>   CC      util/perf_event_attr_fprintf.o
>   CC      tests/event_update.o
>   CC      util/evswitch.o
>   CC      tests/event-times.o
>   CC      util/find_bit.o
>   CC      tests/expr.o
>   CC      util/get_current_dir_name.o
>   CC      tests/backward-ring-buffer.o
>   CC      util/levenshtein.o
>   CC      tests/sdt.o
>   CC      tests/is_printable_array.o
>   CC      util/mmap.o
>   LD      arch/x86/perf-in.o
>   CC      util/memswap.o
>   CC      tests/bitmap.o
>   BISON   util/parse-events-bison.c
>   CC      tests/perf-hooks.o
>   CC      util/print-events.o
>   CC      tests/unit_number__scnprintf.o
>   CC      util/tracepoint.o
>   CC      util/perf_regs.o
>   CC      tests/mem2node.o
>   CC      util/perf-regs-arch/perf_regs_aarch64.o
>   LD      arch/perf-in.o
>   CC      tests/maps.o
>   CC      util/perf-regs-arch/perf_regs_arm.o
>   CC      tests/time-utils-test.o
>   CC      util/arm-spe-decoder/arm-spe-pkt-decoder.o
>   CC      util/intel-pt-decoder/intel-pt-pkt-decoder.o
>   CC      util/arm-spe-decoder/arm-spe-decoder.o
>   CC      tests/genelf.o
>   CC      util/perf-regs-arch/perf_regs_csky.o
>   CC      tests/api-io.o
>   GEN     util/intel-pt-decoder/inat-tables.c
>   CC      tests/demangle-java-test.o
>   CC      util/perf-regs-arch/perf_regs_loongarch.o
>   CC      util/path.o
>   CC      util/perf-regs-arch/perf_regs_mips.o
>   CC      tests/demangle-ocaml-test.o
>   CC      util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.o
>   LD      util/scripting-engines/perf-in.o
>   CC      util/perf-regs-arch/perf_regs_powerpc.o
>   CC      util/print_binary.o
>   CC      tests/pfm.o
>   CC      util/perf-regs-arch/perf_regs_riscv.o
>   CC      util/intel-pt-decoder/intel-pt-log.o
>   CC      util/intel-pt-decoder/intel-pt-decoder.o
>   CC      util/perf-regs-arch/perf_regs_s390.o
>   CC      util/print_insn.o
>   CC      tests/parse-metric.o
>   CC      util/perf-regs-arch/perf_regs_x86.o
>   CC      tests/pe-file-parsing.o
>   CC      tests/expand-cgroup.o
>   CC      util/rlimit.o
>   CC      tests/perf-time-to-tsc.o
>   CC      tests/dlfilter-test.o
>   CC      util/argv_split.o
>   LD      util/arm-spe-decoder/perf-in.o
>   CC      tests/sigtrap.o
>   CC      util/rbtree.o
>   CC      util/libstring.o
>   CC      tests/event_groups.o
>   CC      util/bitmap.o
>   LD      util/hisi-ptt-decoder/perf-in.o
>   CC      util/hweight.o
>   CC      util/smt.o
>   CC      tests/symbols.o
>   CC      tests/util.o
>   LD      util/perf-regs-arch/perf-in.o
>   CC      util/strbuf.o
>   CC      util/string.o
>   CC      util/strlist.o
>   CC      util/strfilter.o
>   CC      util/top.o
>   CC      util/usage.o
>   CC      tests/workloads/noploop.o
>   GEN     pmu-events/pmu-events.c
>   CC      util/dso.o
>   CC      tests/workloads/thloop.o
>   CC      util/dsos.o
>   CC      tests/workloads/leafloop.o
>   CC      tests/workloads/sqrtloop.o
>   CC      tests/workloads/brstack.o
>   CC      util/symbol.o
>   CC      tests/workloads/datasym.o
>   CC      util/symbol_fprintf.o
>   CC      util/map_symbol.o
>   CC      util/color.o
>   CC      util/color_config.o
>   CC      util/intel-pt-decoder/intel-pt-insn-decoder.o
>   CC      util/metricgroup.o
>   CC      util/header.o
>   CC      util/callchain.o
>   CC      util/values.o
>   CC      util/debug.o
>   CC      util/fncache.o
>   CC      util/machine.o
>   LD      tests/workloads/perf-in.o
>   CC      util/map.o
>   CC      util/maps.o
>   CC      util/pstack.o
>   CC      util/session.o
>   LD      util/intel-pt-decoder/perf-in.o
>   CC      util/sample-raw.o
>   CC      util/s390-sample-raw.o
>   CC      util/amd-sample-raw.o
>   LD      tests/perf-in.o
>   CC      util/ordered-events.o
>   CC      util/namespaces.o
>   CC      util/comm.o
>   CC      util/threads.o
>   CC      util/thread.o
>   CC      util/thread_map.o
>   BISON   util/pmu-bison.c
>   CC      util/pmus.o
>   CC      util/svghelper.o
>   CC      util/trace-event-scripting.o
>   CC      util/sort.o
>   CC      util/hist.o
>   CC      util/util.o
>   CC      util/cpumap.o
>   CC      util/affinity.o
>   CC      util/cputopo.o
>   CC      util/cgroup.o
>   CC      util/target.o
>   CC      util/rblist.o
>   CC      util/intlist.o
>   CC      util/vdso.o
>   CC      util/counts.o
>   CC      util/stat.o
>   CC      util/stat-shadow.o
>   CC      util/stat-display.o
>   CC      util/perf_api_probe.o
>   CC      util/record.o
>   CC      util/srcline.o
>   CC      util/srccode.o
>   CC      util/synthetic-events.o
>   CC      util/data.o
>   CC      util/tsc.o
>   CC      util/cloexec.o
>   CC      util/call-path.o
>   CC      util/rwsem.o
>   CC      util/thread-stack.o
>   CC      util/spark.o
>   CC      util/topdown.o
>   CC      util/iostat.o
>   CC      util/stream.o
>   CC      util/auxtrace.o
>   CC      util/intel-pt.o
>   CC      util/intel-bts.o
>   CC      util/arm-spe.o
>   CC      util/hisi-ptt.o
>   CC      util/s390-cpumsf.o
>   CC      util/cs-etm-base.o
>   CC      util/parse-branch-options.o
>   CC      util/dump-insn.o
>   CC      util/parse-regs-options.o
>   CC      util/parse-sublevel-options.o
>   CC      util/term.o
>   CC      util/help-unknown-cmd.o
>   CC      util/dlfilter.o
>   CC      util/mem-events.o
>   CC      util/vsprintf.o
>   CC      util/units.o
>   CC      util/time-utils.o
>   BISON   util/expr-bison.c
>   CC      util/branch.o
>   CC      util/mem2node.o
>   CC      util/clockid.o
>   CC      util/list_sort.o
>   CC      util/mutex.o
>   CC      util/sharded_mutex.o
>   CC      util/hashmap.o
>   CC      util/symbol-minimal.o
>   CC      util/data-convert-json.o
>   CC      util/demangle-ocaml.o
>   CC      util/demangle-java.o
>   CC      util/demangle-rust.o
>   CC      util/perf-hooks.o
>   FLEX    util/parse-events-flex.c
>   FLEX    util/pmu-flex.c
>   CC      util/parse-events-bison.o
>   CC      util/pmu-bison.o
>   CC      util/pmu.o
>   CC      util/pmu-flex.o
>   CC      util/parse-events.o
>   CC      util/parse-events-flex.o
>   FLEX    util/expr-flex.c
>   CC      util/expr-bison.o
>   CC      util/expr-flex.o
>   CC      util/expr.o
>   LD      util/perf-in.o
>   LD      perf-in.o
>   CC      pmu-events/pmu-events.o
>   LD      pmu-events/pmu-events-in.o
>   LINK    perf
> /usr/bin/ld: perf-in.o: in function `dlfilter__new':
> (.text+0x145617): warning: Using 'dlopen' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
> /usr/bin/ld: perf-in.o: in function `target__parse_uid':
> (.text+0x108cfe): warning: Using 'getpwnam_r' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
> /usr/bin/ld: (.text+0x108d7b): warning: Using 'getpwuid_r' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
> /usr/bin/ld: perf-in.o: in function `hists__find_annotations':
> builtin-annotate.c:(.text+0x95f): undefined reference to `hist_entry__annotate_data_tty'
> /usr/bin/ld: builtin-annotate.c:(.text+0xad3): undefined reference to `hist_entry__annotate_data_tui'
> collect2: error: ld returned 1 exit status
> make[4]: *** [Makefile.perf:733: perf] Error 1
> make[3]: *** [Makefile.perf:264: sub-make] Error 2
> make[2]: *** [Makefile:70: all] Error 2
>   test: test -x ./perf
> make[1]: *** [tests/make:330: make_static] Error 1
> make: *** [Makefile:103: build-test] Error 2
> make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
> 
> real	0m21.481s
> user	1m35.872s
> sys	0m22.854s
> ⬢[acme@toolbox perf-tools-next]$ 
> 
> 

