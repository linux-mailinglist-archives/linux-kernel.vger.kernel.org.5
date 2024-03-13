Return-Path: <linux-kernel+bounces-102504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 391CB87B30B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A0531C211F7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA3951C49;
	Wed, 13 Mar 2024 20:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FpybdMVs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33712E629;
	Wed, 13 Mar 2024 20:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710363276; cv=none; b=CBS3qZmnMrfBfYLiECDRBjE41l/QATZzurEdW2lHS2sOWLxMJwwKxHNFBydelpp4RqXE2LnjqhsB27RP1RwMS5OhbgmHv5EsUTVzGmQjikXnFb+SiPcTRpoH8yVr8od0+lRlh1+mGJUBHOeBKBz9FClTjKNM3MkbvQIH9BV6T0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710363276; c=relaxed/simple;
	bh=8fTrmeAJ9SU1grtRfV3cLnMUmwPr5ur8F51YcUeyqKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bKm+Our2e8TeEgzfKd0MKbirem6LKKqKQ/fF2S3haRLQOHFKxmDZLmgc1hckRoGrC+/tn11hYHiW966UQ3ZTINi2Z3ly0AKDESS4D/p11hX6kBofsiyfHaUItMgapWT+5u4O2GQF65MoUmd09x6rM6tdeolpDkB9FCnhSaP6beM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FpybdMVs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B72BC433F1;
	Wed, 13 Mar 2024 20:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710363276;
	bh=8fTrmeAJ9SU1grtRfV3cLnMUmwPr5ur8F51YcUeyqKI=;
	h=From:To:Cc:Subject:Date:From;
	b=FpybdMVsX/o6TC57LONPmHZM8TfKldxFuMj6w23arB+/Pbskp5lXhK7FzTQBU4ZpL
	 9l5h9M2qbrGDGRIWZ02RYkB3f+orN4wTArrcxkFdq6H84fTy+5AIcaTYsXaOh7HQof
	 Hi+7+umXKBd3bcTAuBbtnbplq9SeqMsPGBDSsu3L/2jBzEdaCxKT2rd2JSs9I0oyKh
	 Y77DVRNNF06Zvz8C07U4m5hUAnwO2xrZMLAXJSXCXCikw6GnCHHPidjCBCX098xIP+
	 IXeBgQtYPgNDmxekoQVh1GXxbzaRxD5B/OCkhDB2ldiwB+RzubzaNMXkEDLPH95ra8
	 k3tPG4Kc0ZW6Q==
From: Namhyung Kim <namhyung@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [GIT PULL] perf tools changes for v6.9
Date: Wed, 13 Mar 2024 13:54:34 -0700
Message-ID: <20240313205434.3066697-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please consider pulling perf-tools changes for v6.9.

Note that there was a merge conflict with kvm-riscv tree in linux-next.  It was
because of a tree-wide change in the Makefile to remove unnecessary assignments.
As it's mostly in the perf tools change, it went through the perf-tools tree.
I think it's straight-forward to resolve and I don't see the conflict as of the
current master but I'd like to inform you anyway.  You can see the resolution
in the below message.

  https://lore.kernel.org/r/20240307145422.0de43782@canb.auug.org.au

Thanks,
Namhyung

----------------------------------------------------------------
The following changes since commit fdd0ae72b34e56eb5e896d067c49a78ecb451032:

  perf tools headers: update the asm-generic/unaligned.h copy with the kernel sources (2024-01-31 14:02:41 -0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v6.9-2024-03-13

for you to fetch changes up to 0f66dfe7b91d2743cc71dfff37af503215b204ef:

  perf annotate: Add comments in the data structures (2024-03-06 20:25:48 -0800)

----------------------------------------------------------------
perf tools changes for v6.9

perf stat
---------
* Support new 'cluster' aggregation mode for shared resources depending on the
  hardware configuration.

    $ sudo perf stat -a --per-cluster -e cycles,instructions sleep 1

     Performance counter stats for 'system wide':

    S0-D0-CLS0    2         85,051,822      cycles
    S0-D0-CLS0    2         73,909,908      instructions      #    0.87  insn per cycle
    S0-D0-CLS2    2         93,365,918      cycles
    S0-D0-CLS2    2         83,006,158      instructions      #    0.89  insn per cycle
    S0-D0-CLS4    2        104,157,523      cycles
    S0-D0-CLS4    2         53,234,396      instructions      #    0.51  insn per cycle
    S0-D0-CLS6    2         65,891,079      cycles
    S0-D0-CLS6    2         41,478,273      instructions      #    0.63  insn per cycle

           1.002407989 seconds time elapsed

* Various fixes and cleanups for event metrics including NaN handling.

perf script
-----------
* Use libcapstone if available to disassemble the instructions.  This enables
  'perf script -F disasm' and 'perf script --insn-trace=disasm' (for Intel-PT).

    $ perf script -F event,ip,disasm
    cycles:P:  ffffffffa988d428             wrmsr
    cycles:P:  ffffffffa9839d25             movq %rax, %r14
    cycles:P:  ffffffffa9cdcaf0             endbr64
    cycles:P:  ffffffffa988d428             wrmsr
    cycles:P:  ffffffffa988d428             wrmsr
    cycles:P:  ffffffffaa401f86             iretq
    cycles:P:  ffffffffa99c4de5             movq 0x30(%rcx), %r8
    cycles:P:  ffffffffa988d428             wrmsr
    cycles:P:  ffffffffaa401f86             iretq
    cycles:P:  ffffffffa9907983             movl 0x68(%rbx), %eax
    cycles:P:  ffffffffa988d428             wrmsr

* Expose sample ID / stream ID to python scripts

perf test
---------
* Add more perf test cases from Redhat internal test suites.  This time it adds
  the base infra and a few perf probe tests.  More to come. :)

* Add 'perf test -p' for parallel execution and fix some issues found by the
  parallel test.

* Support symbol test to print symbols in given (active) module:

    $ perf test -F -v Symbols --dso /lib/modules/$(uname -r)/kernel/fs/ext4/ext4.ko
    --- start ---
    Testing /lib/modules/6.5.13-1rodete2-amd64/kernel/fs/ext4/ext4.ko
    Overlapping symbols:
     7a990-7a9a0 l __pfx_ext4_exit_fs
     7a990-7a9a0 g __pfx_cleanup_module
    Overlapping symbols:
     7a9a0-7aa1c l ext4_exit_fs
     7a9a0-7aa1c g cleanup_module
    ...

JSON metric updates
-------------------
* A new round of Intel metric updates.

* Support Power11 PVR (compatible to Power10).

* Fix cache latency events on Zen 4 to set SliceId properly.

Internal
--------
* Fix reference counting for 'map' data structure, tireless work from Ian!

* More memory optimization for struct thread and annotate histogram.  Now,
  'perf report' (TUI) and 'perf annotate' should be much lighter-weight in
  terms of memory footprint.

* Support cross-arch perf register access.  Clean up the build configuration
  so that it can detect arch-register support at runtime.  This can allow to
  parse register data in sample which was recorded in a different arch.

Others
------
* Sync task state in 'perf sched' to kernel using trace event fields.  The
  task states have been changed so tools cannot assume a fixed encoding.

* Clean up 'perf mem' to generalize the arch-specific events.

* Add support for local and global variables to data type profiling.  This
  would increase the success rate of type resolution with DWARF.

* Add short option -H for --hierarchy in 'perf report' and 'perf top'.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>

----------------------------------------------------------------
Adrian Hunter (3):
      perf tools: Make it possible to see perf's kernel and module memory mappings
      perf symbols: Slightly improve module file executable section mappings
      perf test: Enable Symbols test to work with a current module dso

Andi Kleen (2):
      perf report: Prevent segfault with --no-parent
      perf Documentation: Add some more hints to tips.txt

Arnaldo Carvalho de Melo (4):
      perf bpf: Clean up the generated/copied vmlinux.h
      perf augmented_raw_syscalls.bpf: Move 'struct timespec64' to vmlinux.h
      perf bpf: Check that the minimal vmlinux.h installed is the latest one
      perf test: Use TEST_FAIL in the TEST_ASSERT macros instead of -1

Ben Gainey (1):
      tools: perf: Expose sample ID / stream ID to python scripts

Changbin Du (5):
      perf: build: introduce the libcapstone
      perf: util: use capstone disasm engine to show assembly instructions
      perf: script: add field 'disasm' to display mnemonic instructions
      perf: script: add raw|disasm arguments to --insn-trace option
      perf: script: prefer capstone to XED

Christophe JAILLET (1):
      perf pmu: Fix a potential memory leak in perf_pmu__lookup()

Colin Ian King (1):
      perf test: Fix spelling mistake "curent" -> "current"

Ian Rogers (71):
      perf pmu: Treat the msr pmu as software
      perf tsc: Add missing newlines to debug statements
      perf parse-events: Improve error location of terms cloned from an event
      perf parse-events: Print all errors
      perf jevents: Drop or simplify small integer values
      perf kvm powerpc: Fix build
      perf srcline: Add missed addr2line closes
      perf maps: Switch from rbtree to lazily sorted array for addresses
      perf maps: Get map before returning in maps__find
      perf maps: Get map before returning in maps__find_by_name
      perf maps: Get map before returning in maps__find_next_entry
      perf maps: Hide maps internals
      perf maps: Locking tidy up of nr_maps
      perf expr: Allow NaN to be a valid number
      perf expr: Fix "has_event" function for metric style events
      perf stat: Avoid metric-only segv
      perf metric: Don't remove scale from counts
      perf vendor events intel: Update alderlake events to v1.24
      perf vendor events intel: Update alderlaken events to v1.24
      perf vendor events intel: Update broadwell events to v29
      perf vendor events intel: Update emeraldrapids events to v1.03
      perf vendor events intel: Update grandridge events to v1.01
      perf vendor events intel: Update haswell events to v35
      perf vendor events intel: Update icelake events to v1.21
      perf vendor events intel: Update meteorlake events to v1.07
      perf vendor events intel: Update rocketlake events to v1.02
      perf vendor events intel: Update sierraforst events to v1.01
      perf vendor events intel: Update skylake events to v58
      perf vendor events intel: Update tigerlake events to v1.15
      perf vendor events intel: Update alderlake TMA metrics to 4.7
      perf vendor events intel: Update broadwell TMA metrics to 4.7
      perf vendor events intel: Update broadwellde TMA metrics to 4.7
      perf vendor events intel: Update broadwellx TMA metrics to 4.7
      perf vendor events intel: Update cascadelakex TMA metrics to 4.7
      perf vendor events intel: Update haswell TMA metrics to 4.7
      perf vendor events intel: Update haswellx TMA metrics to 4.7
      perf vendor events intel: Update icelake TMA metrics to 4.7
      perf vendor events intel: Update icelakex TMA metrics to 4.7
      perf vendor events intel: Update ivybridge TMA metrics to 4.7
      perf vendor events intel: Update ivytown TMA metrics to 4.7
      perf vendor events intel: Update jaketown TMA metrics to 4.7
      perf vendor events intel: Update rocketlake TMA metrics to 4.7
      perf vendor events intel: Update sandybridge TMA metrics to 4.7
      perf vendor events intel: Update sapphirerapids TMA metrics to 4.7
      perf vendor events intel: Update skylake TMA metrics to 4.7
      perf vendor events intel: Update skylakex TMA metrics to 4.7
      perf vendor events intel: Update tigerlake TMA metrics to 4.7
      perf list: For metricgroup only list include description
      perf stat: Pass fewer metric arguments
      perf metrics: Compute unmerged uncore metrics individually
      perf stat: Fix metric-only aggregation index
      perf thread_map: Skip exited threads when scanning /proc
      perf list: Add scandirat compatibility function
      perf tests: Avoid fork in perf_has_symbol test
      tools subcmd: Add a no exec function call option
      perf test: Rename builtin-test-list and add missed header guard
      perf tests: Use scandirat for shell script finding
      perf tests: Run time generate shell test suites
      perf tests: Add option to run tests in parallel
      perf metrics: Fix metric matching
      perf metrics: Fix segv for metrics with no events
      libperf evlist: Avoid out-of-bounds access
      perf map: Fix map reference count issues
      perf vendor events intel: Add umasks/occ_sel to PCU events.
      perf report: Sort child tasks by tid
      perf trace: Ignore thread hashing in summary
      perf machine: Move fprintf to for_each loop and a callback
      perf machine: Move machine's threads into its own abstraction
      perf threads: Move threads to its own files
      perf threads: Switch from rbtree to hashmap
      perf threads: Reduce table size from 256 to 8

Ilkka Koskinen (1):
      perf data convert: Fix segfault when converting to json when cpu_desc isn't set

James Clark (4):
      perf evlist: Fix evlist__new_default() for > 1 core PMU
      perf version: Display availability of HAVE_DWARF_UNWIND_SUPPORT
      perf test: Skip test_arm_callgraph_fp.sh if unwinding isn't built in
      perf version: Display availability of OpenCSD support

Kan Liang (8):
      perf mem: Add mem_events into the supported perf_pmu
      perf mem: Clean up perf_mem_events__ptr()
      perf mem: Clean up perf_mem_events__name()
      perf mem: Clean up perf_mem_event__supported()
      perf mem: Clean up is_mem_loads_aux_event()
      perf mem: Clean up perf_mem_events__record_args()
      perf mem: Clean up perf_pmus__num_mem_pmus()
      perf script: Print source line for each jump in brstackinsn

Leo Yan (4):
      perf build: Remove unused CONFIG_PERF_REGS
      perf parse-regs: Always build perf register functions
      perf parse-regs: Introduce a weak function arch__sample_reg_masks()
      perf build: Cleanup perf register configuration

Madhavan Srinivasan (1):
      perf/pmu-events/powerpc: Update json mapfile with Power11 PVR

Mark Rutland (1):
      perf print-events: make is_event_supported() more robust

Masahiro Yamada (1):
      treewide: remove meaningless assignments in Makefiles

Michael Petlan (1):
      perf testsuite: Install kprobe tests and common files

Namhyung Kim (19):
      perf annotate-data: Parse 'lock' prefix from llvm-objdump
      perf annotate-data: Handle macro fusion on x86
      perf annotate-data: Handle array style accesses
      perf annotate-data: Add stack operation pseudo type
      perf annotate-data: Handle PC-relative addressing
      perf annotate-data: Support global variables
      perf dwarf-aux: Add die_get_cfa()
      perf annotate-data: Support stack variables
      perf dwarf-aux: Check allowed DWARF Ops
      perf tools: Add -H short option for --hierarchy
      perf record: Display data size on pipe mode
      perf tools: Remove misleading comments on map functions
      Merge branch 'perf-tools' into perf-tools-next
      perf tools: Fixup module symbol end address properly
      perf lock contention: Account contending locks too
      perf annotate: Add a hashmap for symbol histogram
      perf annotate: Calculate instruction overhead using hashmap
      perf annotate: Remove sym_hist.addr[] array
      perf annotate: Add comments in the data structures

Sandipan Das (1):
      perf vendor events amd: Fix Zen 4 cache latency events

Thomas Richter (2):
      perf test: raise limit to 20 percent for perf_stat_--bpf-counters_test
      perf list: fix short description for some cache events

Veronika Molnarova (6):
      perf testsuite: Add common regex patters
      perf testsuite: Add common setting for shell tests
      perf testsuite: Add initialization script for shell tests
      perf testsuite: Add test case for perf probe
      perf testsuite: Add common output checking helpers
      perf testsuite: Add test for kprobe handling

Weilin Wang (1):
      perf test: Simplify metric value validation test final report

Yang Jihong (10):
      perf build: Check whether pkg-config is installed when libtraceevent is linked
      perf record: Fix possible incorrect free in record__switch_output()
      perf record: Check conflict between '--timestamp-filename' option and pipe mode before recording
      perf data: Minor code style alignment cleanup
      perf evsel: Fix duplicate initialization of data->id in evsel__parse_sample()
      perf sched: Move start_work_mutex and work_done_wait_mutex initialization to perf_sched__replay()
      perf sched: Fix memory leak in perf_sched__map()
      perf sched: Move curr_thread initialization to perf_sched__map()
      perf sched: Move curr_pid and cpu_last_switched initialization to perf_sched__{lat|map|replay}()
      perf thread_map: Free strlist on normal path in thread_map__new_by_tid_str()

Yicong Yang (2):
      perf test: Skip metric w/o event name on arm64 in stat STD output linter
      perf stat: Support per-cluster aggregation

Ze Gao (5):
      perf sched: Sync state char array with the kernel
      perf util: Add helpers to parse task state string from libtraceevent
      perf util: Add evsel__taskstate() to parse the task state info instead
      perf sched: Commit to evsel__taskstate() to parse task state info
      perf evsel: Rename get_states() to parse_task_states() and make it public

 tools/build/Makefile.feature                       |    2 +
 tools/build/feature/Makefile                       |    4 +
 tools/build/feature/test-all.c                     |    4 +
 tools/build/feature/test-libcapstone.c             |   11 +
 tools/lib/perf/evlist.c                            |   18 +-
 tools/lib/perf/include/internal/evlist.h           |    4 +-
 tools/lib/subcmd/run-command.c                     |    2 +
 tools/lib/subcmd/run-command.h                     |    2 +
 tools/perf/Documentation/perf-intel-pt.txt         |   14 +-
 tools/perf/Documentation/perf-report.txt           |   29 +-
 tools/perf/Documentation/perf-script-python.txt    |    4 +-
 tools/perf/Documentation/perf-script.txt           |   20 +-
 tools/perf/Documentation/perf-stat.txt             |   11 +
 tools/perf/Documentation/perf-top.txt              |   32 +-
 tools/perf/Documentation/perf.txt                  |    2 +
 tools/perf/Documentation/tips.txt                  |   31 +-
 tools/perf/Makefile.config                         |  142 +-
 tools/perf/Makefile.perf                           |   18 +-
 tools/perf/arch/arm/util/perf_regs.c               |    7 +-
 tools/perf/arch/arm/util/pmu.c                     |    3 +
 tools/perf/arch/arm64/Makefile                     |    2 +-
 tools/perf/arch/arm64/util/machine.c               |    2 +
 tools/perf/arch/arm64/util/mem-events.c            |   39 +-
 tools/perf/arch/arm64/util/mem-events.h            |    7 +
 tools/perf/arch/arm64/util/perf_regs.c             |    7 +-
 tools/perf/arch/csky/util/perf_regs.c              |    7 +-
 tools/perf/arch/loongarch/Makefile                 |    2 +-
 tools/perf/arch/loongarch/util/perf_regs.c         |    7 +-
 tools/perf/arch/mips/Makefile                      |    2 +-
 tools/perf/arch/mips/util/perf_regs.c              |    7 +-
 tools/perf/arch/powerpc/Makefile                   |    2 +-
 tools/perf/arch/powerpc/util/Build                 |    1 +
 tools/perf/arch/powerpc/util/kvm-stat.c            |    2 +-
 tools/perf/arch/powerpc/util/mem-events.c          |   16 +-
 tools/perf/arch/powerpc/util/mem-events.h          |    7 +
 tools/perf/arch/powerpc/util/perf_regs.c           |    7 +-
 tools/perf/arch/powerpc/util/pmu.c                 |   12 +
 tools/perf/arch/riscv/util/perf_regs.c             |    7 +-
 tools/perf/arch/s390/Makefile                      |    2 +-
 tools/perf/arch/s390/util/perf_regs.c              |    7 +-
 tools/perf/arch/x86/Makefile                       |    2 +-
 tools/perf/arch/x86/tests/dwarf-unwind.c           |    1 +
 tools/perf/arch/x86/tests/hybrid.c                 |    5 +-
 tools/perf/arch/x86/util/mem-events.c              |   99 +-
 tools/perf/arch/x86/util/mem-events.h              |   10 +
 tools/perf/arch/x86/util/perf_regs.c               |    7 +-
 tools/perf/arch/x86/util/pmu.c                     |   19 +-
 tools/perf/arch/x86/util/tsc.c                     |    4 +-
 tools/perf/builtin-c2c.c                           |   45 +-
 tools/perf/builtin-list.c                          |   21 +-
 tools/perf/builtin-mem.c                           |   48 +-
 tools/perf/builtin-record.c                        |   19 +-
 tools/perf/builtin-report.c                        |  221 +-
 tools/perf/builtin-sched.c                         |  220 +-
 tools/perf/builtin-script.c                        |   66 +-
 tools/perf/builtin-stat.c                          |   52 +-
 tools/perf/builtin-top.c                           |    2 +-
 tools/perf/builtin-trace.c                         |   41 +-
 tools/perf/builtin-version.c                       |    3 +
 tools/perf/pmu-events/arch/powerpc/mapfile.csv     |    1 +
 .../perf/pmu-events/arch/s390/cf_z16/extended.json |   62 +-
 .../pmu-events/arch/x86/alderlake/adl-metrics.json |  459 ++--
 .../arch/x86/alderlake/floating-point.json         |   30 +-
 .../arch/x86/alderlake/metricgroups.json           |   11 +-
 .../perf/pmu-events/arch/x86/alderlake/other.json  |   10 +
 .../pmu-events/arch/x86/alderlake/pipeline.json    |   13 +
 .../perf/pmu-events/arch/x86/alderlaken/other.json |    9 +
 .../pmu-events/arch/x86/alderlaken/pipeline.json   |    9 +
 tools/perf/pmu-events/arch/x86/amdzen4/cache.json  |   56 +
 .../pmu-events/arch/x86/broadwell/bdw-metrics.json |  204 +-
 .../perf/pmu-events/arch/x86/broadwell/memory.json |    2 +-
 .../arch/x86/broadwell/metricgroups.json           |    7 +-
 .../arch/x86/broadwellde/bdwde-metrics.json        |  191 +-
 .../arch/x86/broadwellde/metricgroups.json         |    7 +-
 .../arch/x86/broadwellde/uncore-power.json         |    3 +
 .../arch/x86/broadwellx/bdx-metrics.json           |  250 +-
 .../arch/x86/broadwellx/metricgroups.json          |    7 +-
 .../arch/x86/broadwellx/uncore-power.json          |    3 +
 .../arch/x86/cascadelakex/clx-metrics.json         |  566 ++--
 .../arch/x86/cascadelakex/metricgroups.json        |   12 +-
 .../arch/x86/cascadelakex/uncore-power.json        |    3 +
 .../arch/x86/emeraldrapids/uncore-cache.json       |  152 ++
 .../perf/pmu-events/arch/x86/grandridge/cache.json |  185 ++
 .../arch/x86/grandridge/floating-point.json        |   68 +
 .../pmu-events/arch/x86/grandridge/frontend.json   |   16 +
 .../pmu-events/arch/x86/grandridge/memory.json     |   66 +
 .../perf/pmu-events/arch/x86/grandridge/other.json |   16 +
 .../pmu-events/arch/x86/grandridge/pipeline.json   |  353 +++
 .../arch/x86/grandridge/uncore-cache.json          | 1795 ++++++++++++
 .../arch/x86/grandridge/uncore-interconnect.json   |  175 ++
 .../pmu-events/arch/x86/grandridge/uncore-io.json  | 1187 ++++++++
 .../arch/x86/grandridge/uncore-memory.json         |  385 +++
 .../arch/x86/grandridge/uncore-power.json          |   10 +
 .../arch/x86/grandridge/virtual-memory.json        |  113 +-
 .../pmu-events/arch/x86/haswell/hsw-metrics.json   |  178 +-
 tools/perf/pmu-events/arch/x86/haswell/memory.json |    2 +-
 .../pmu-events/arch/x86/haswell/metricgroups.json  |    7 +-
 .../pmu-events/arch/x86/haswellx/hsx-metrics.json  |  224 +-
 .../pmu-events/arch/x86/haswellx/metricgroups.json |    7 +-
 .../pmu-events/arch/x86/haswellx/uncore-power.json |    3 +
 .../pmu-events/arch/x86/icelake/icl-metrics.json   |  398 ++-
 tools/perf/pmu-events/arch/x86/icelake/memory.json |    1 +
 .../pmu-events/arch/x86/icelake/metricgroups.json  |   12 +-
 tools/perf/pmu-events/arch/x86/icelake/other.json  |    2 +-
 .../perf/pmu-events/arch/x86/icelake/pipeline.json |   10 +-
 .../pmu-events/arch/x86/icelakex/icx-metrics.json  |  586 ++--
 .../pmu-events/arch/x86/icelakex/metricgroups.json |   12 +-
 .../pmu-events/arch/x86/icelakex/uncore-power.json |    3 +
 .../pmu-events/arch/x86/ivybridge/ivb-metrics.json |  197 +-
 .../arch/x86/ivybridge/metricgroups.json           |    7 +-
 .../pmu-events/arch/x86/ivytown/ivt-metrics.json   |  200 +-
 .../pmu-events/arch/x86/ivytown/metricgroups.json  |    7 +-
 .../pmu-events/arch/x86/ivytown/uncore-power.json  |    3 +
 .../pmu-events/arch/x86/jaketown/jkt-metrics.json  |   64 +-
 .../pmu-events/arch/x86/jaketown/metricgroups.json |    7 +-
 .../pmu-events/arch/x86/jaketown/uncore-power.json |    3 +
 tools/perf/pmu-events/arch/x86/mapfile.csv         |   24 +-
 .../perf/pmu-events/arch/x86/meteorlake/cache.json |    8 +-
 .../arch/x86/meteorlake/floating-point.json        |   86 +-
 .../perf/pmu-events/arch/x86/meteorlake/other.json |   10 +
 .../pmu-events/arch/x86/meteorlake/pipeline.json   |   76 +
 .../arch/x86/meteorlake/virtual-memory.json        |   36 +
 .../pmu-events/arch/x86/rocketlake/memory.json     |    1 +
 .../arch/x86/rocketlake/metricgroups.json          |   12 +-
 .../perf/pmu-events/arch/x86/rocketlake/other.json |    2 +-
 .../pmu-events/arch/x86/rocketlake/pipeline.json   |   10 +-
 .../arch/x86/rocketlake/rkl-metrics.json           |  406 +--
 .../arch/x86/sandybridge/metricgroups.json         |    7 +-
 .../arch/x86/sandybridge/snb-metrics.json          |   71 +-
 .../arch/x86/sapphirerapids/metricgroups.json      |   12 +-
 .../arch/x86/sapphirerapids/spr-metrics.json       |  773 ++++--
 .../pmu-events/arch/x86/sierraforest/cache.json    |  185 ++
 .../arch/x86/sierraforest/floating-point.json      |   68 +
 .../pmu-events/arch/x86/sierraforest/frontend.json |   16 +
 .../pmu-events/arch/x86/sierraforest/memory.json   |   66 +
 .../pmu-events/arch/x86/sierraforest/other.json    |   16 +
 .../pmu-events/arch/x86/sierraforest/pipeline.json |  360 +++
 .../arch/x86/sierraforest/uncore-cache.json        | 2853 ++++++++++++++++++++
 .../arch/x86/sierraforest/uncore-cxl.json          |   10 +
 .../arch/x86/sierraforest/uncore-interconnect.json | 1228 +++++++++
 .../arch/x86/sierraforest/uncore-io.json           | 1634 +++++++++++
 .../arch/x86/sierraforest/uncore-memory.json       |  385 +++
 .../arch/x86/sierraforest/uncore-power.json        |   10 +
 .../arch/x86/sierraforest/virtual-memory.json      |  113 +-
 tools/perf/pmu-events/arch/x86/skylake/memory.json |    2 +-
 .../pmu-events/arch/x86/skylake/metricgroups.json  |   12 +-
 .../perf/pmu-events/arch/x86/skylake/pipeline.json |    2 +-
 .../pmu-events/arch/x86/skylake/skl-metrics.json   |  395 +--
 .../arch/x86/skylake/virtual-memory.json           |    2 +-
 .../pmu-events/arch/x86/skylakex/metricgroups.json |   12 +-
 .../pmu-events/arch/x86/skylakex/skx-metrics.json  |  548 ++--
 .../pmu-events/arch/x86/skylakex/uncore-power.json |    3 +
 .../arch/x86/snowridgex/uncore-power.json          |    3 +
 .../arch/x86/tigerlake/metricgroups.json           |   12 +-
 .../perf/pmu-events/arch/x86/tigerlake/other.json  |    2 +-
 .../pmu-events/arch/x86/tigerlake/pipeline.json    |   10 +-
 .../pmu-events/arch/x86/tigerlake/tgl-metrics.json |  406 +--
 .../arch/x86/tigerlake/uncore-interconnect.json    |    2 +
 tools/perf/pmu-events/jevents.py                   |   27 +-
 tools/perf/tests/Build                             |    2 +-
 tools/perf/tests/builtin-test-list.c               |  207 --
 tools/perf/tests/builtin-test-list.h               |   12 -
 tools/perf/tests/builtin-test.c                    |  378 +--
 tools/perf/tests/expand-cgroup.c                   |    3 +-
 tools/perf/tests/make                              |    4 +-
 tools/perf/tests/maps.c                            |    3 +
 tools/perf/tests/parse-events.c                    |    9 +-
 tools/perf/tests/pmu-events.c                      |   22 +-
 tools/perf/tests/shell/base_probe/settings.sh      |   48 +
 .../tests/shell/base_probe/test_adding_kernel.sh   |  278 ++
 .../tests/shell/common/check_all_lines_matched.pl  |   39 +
 .../tests/shell/common/check_all_patterns_found.pl |   34 +
 .../tests/shell/common/check_no_patterns_found.pl  |   34 +
 tools/perf/tests/shell/common/init.sh              |  117 +
 tools/perf/tests/shell/common/patterns.sh          |  268 ++
 tools/perf/tests/shell/common/settings.sh          |   79 +
 tools/perf/tests/shell/lib/perf_has_symbol.sh      |    2 +-
 .../perf/tests/shell/lib/perf_json_output_lint.py  |    4 +-
 .../perf/tests/shell/lib/perf_metric_validation.py |  231 +-
 tools/perf/tests/shell/lib/stat_output.sh          |   12 +
 tools/perf/tests/shell/perftool-testsuite_probe.sh |   23 +
 tools/perf/tests/shell/stat+csv_output.sh          |    2 +
 tools/perf/tests/shell/stat+json_output.sh         |   13 +
 tools/perf/tests/shell/stat+std_output.sh          |    4 +-
 tools/perf/tests/shell/stat_bpf_counters.sh        |   12 +-
 tools/perf/tests/shell/stat_metrics_values.sh      |    4 +-
 tools/perf/tests/shell/test_arm_callgraph_fp.sh    |    6 +
 tools/perf/tests/symbols.c                         |   68 +
 tools/perf/tests/tests-scripts.c                   |  257 ++
 tools/perf/tests/tests-scripts.h                   |    9 +
 tools/perf/tests/tests.h                           |   16 +-
 tools/perf/tests/thread-maps-share.c               |    8 +-
 tools/perf/tests/vmlinux-kallsyms.c                |   10 +-
 tools/perf/ui/browsers/res_sample.c                |    2 +-
 tools/perf/ui/browsers/scripts.c                   |    2 +-
 tools/perf/ui/gtk/annotate.c                       |   14 +-
 tools/perf/util/Build                              |    2 +
 tools/perf/util/annotate-data.c                    |  119 +-
 tools/perf/util/annotate-data.h                    |    8 +-
 tools/perf/util/annotate.c                         |  269 +-
 tools/perf/util/annotate.h                         |   98 +-
 tools/perf/util/bpf-event.c                        |    1 +
 tools/perf/util/bpf_lock_contention.c              |  124 +-
 .../util/bpf_skel/augmented_raw_syscalls.bpf.c     |   15 +-
 tools/perf/util/bpf_skel/lock_contention.bpf.c     |   16 +-
 tools/perf/util/bpf_skel/lock_data.h               |    7 +
 tools/perf/util/bpf_skel/vmlinux/vmlinux.h         |    7 +
 tools/perf/util/callchain.c                        |    2 +-
 tools/perf/util/cpumap.c                           |   33 +-
 tools/perf/util/cpumap.h                           |   19 +-
 tools/perf/util/data-convert-json.c                |    4 +-
 tools/perf/util/data.c                             |   10 +-
 tools/perf/util/data.h                             |    6 +-
 tools/perf/util/debug.c                            |    3 +
 tools/perf/util/debug.h                            |    1 +
 tools/perf/util/dwarf-aux.c                        |  187 +-
 tools/perf/util/dwarf-aux.h                        |   18 +
 tools/perf/util/env.h                              |    1 +
 tools/perf/util/event.c                            |    4 +-
 tools/perf/util/evsel.c                            |   34 +-
 tools/perf/util/evsel.h                            |    1 +
 tools/perf/util/expr.c                             |   20 +-
 tools/perf/util/expr.l                             |    9 +
 tools/perf/util/machine.c                          |  375 +--
 tools/perf/util/machine.h                          |   30 +-
 tools/perf/util/map.c                              |    9 +-
 tools/perf/util/maps.c                             | 1306 +++++----
 tools/perf/util/maps.h                             |   65 +-
 tools/perf/util/mem-events.c                       |  217 +-
 tools/perf/util/mem-events.h                       |   19 +-
 tools/perf/util/metricgroup.c                      |   24 +-
 tools/perf/util/parse-events.c                     |   92 +-
 tools/perf/util/parse-events.h                     |   14 +-
 tools/perf/util/parse-events.y                     |    2 -
 tools/perf/util/parse-regs-options.c               |    8 +-
 tools/perf/util/perf-regs-arch/perf_regs_aarch64.c |    4 -
 tools/perf/util/perf-regs-arch/perf_regs_arm.c     |    4 -
 tools/perf/util/perf-regs-arch/perf_regs_csky.c    |    4 -
 .../perf/util/perf-regs-arch/perf_regs_loongarch.c |    4 -
 tools/perf/util/perf-regs-arch/perf_regs_mips.c    |    4 -
 tools/perf/util/perf-regs-arch/perf_regs_powerpc.c |    4 -
 tools/perf/util/perf-regs-arch/perf_regs_riscv.c   |    4 -
 tools/perf/util/perf-regs-arch/perf_regs_s390.c    |    4 -
 tools/perf/util/perf-regs-arch/perf_regs_x86.c     |    4 -
 tools/perf/util/perf_regs.c                        |   11 +-
 tools/perf/util/perf_regs.h                        |   34 +-
 tools/perf/util/pmu.c                              |   32 +-
 tools/perf/util/pmu.h                              |    7 +
 tools/perf/util/pmus.c                             |    6 -
 tools/perf/util/pmus.h                             |    1 -
 tools/perf/util/print-events.c                     |   40 +-
 tools/perf/util/print_insn.c                       |  135 +
 tools/perf/util/print_insn.h                       |   16 +
 tools/perf/util/probe-event.c                      |    5 +-
 tools/perf/util/python-ext-sources                 |    1 +
 tools/perf/util/python.c                           |    1 +
 tools/perf/util/rb_resort.h                        |    5 -
 .../util/scripting-engines/trace-event-python.c    |    8 +-
 tools/perf/util/session.c                          |   11 +
 tools/perf/util/session.h                          |    2 +
 tools/perf/util/setup.py                           |    1 +
 tools/perf/util/sort.c                             |    2 +-
 tools/perf/util/srcline.c                          |    2 +
 tools/perf/util/stat-display.c                     |   24 +-
 tools/perf/util/stat-shadow.c                      |   72 +-
 tools/perf/util/stat.h                             |    1 +
 tools/perf/util/symbol-elf.c                       |   79 +-
 tools/perf/util/symbol.c                           |   52 +-
 tools/perf/util/thread.c                           |    4 +-
 tools/perf/util/thread.h                           |    7 -
 tools/perf/util/thread_map.c                       |   11 +-
 tools/perf/util/threads.c                          |  190 ++
 tools/perf/util/threads.h                          |   35 +
 tools/perf/util/trace-event-parse.c                |  113 +
 tools/perf/util/trace-event.h                      |    3 +
 tools/perf/util/unwind-libdw.c                     |    2 +-
 tools/perf/util/unwind-libunwind-local.c           |    2 +-
 tools/perf/util/unwind-libunwind.c                 |    7 +-
 tools/perf/util/util.c                             |   19 +
 tools/perf/util/util.h                             |    8 +
 tools/scripts/Makefile.include                     |    2 +-
 tools/testing/selftests/kvm/Makefile               |    4 +-
 282 files changed, 21268 insertions(+), 4813 deletions(-)
 create mode 100644 tools/build/feature/test-libcapstone.c
 create mode 100644 tools/perf/arch/arm64/util/mem-events.h
 create mode 100644 tools/perf/arch/powerpc/util/mem-events.h
 create mode 100644 tools/perf/arch/powerpc/util/pmu.c
 create mode 100644 tools/perf/arch/x86/util/mem-events.h
 create mode 100644 tools/perf/pmu-events/arch/x86/grandridge/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/grandridge/uncore-cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/grandridge/uncore-interconnect.json
 create mode 100644 tools/perf/pmu-events/arch/x86/grandridge/uncore-io.json
 create mode 100644 tools/perf/pmu-events/arch/x86/grandridge/uncore-memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/grandridge/uncore-power.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sierraforest/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sierraforest/uncore-cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sierraforest/uncore-cxl.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sierraforest/uncore-interconnect.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sierraforest/uncore-io.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sierraforest/uncore-memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sierraforest/uncore-power.json
 delete mode 100644 tools/perf/tests/builtin-test-list.c
 delete mode 100644 tools/perf/tests/builtin-test-list.h
 create mode 100644 tools/perf/tests/shell/base_probe/settings.sh
 create mode 100755 tools/perf/tests/shell/base_probe/test_adding_kernel.sh
 create mode 100755 tools/perf/tests/shell/common/check_all_lines_matched.pl
 create mode 100755 tools/perf/tests/shell/common/check_all_patterns_found.pl
 create mode 100755 tools/perf/tests/shell/common/check_no_patterns_found.pl
 create mode 100644 tools/perf/tests/shell/common/init.sh
 create mode 100644 tools/perf/tests/shell/common/patterns.sh
 create mode 100644 tools/perf/tests/shell/common/settings.sh
 create mode 100755 tools/perf/tests/shell/perftool-testsuite_probe.sh
 create mode 100644 tools/perf/tests/tests-scripts.c
 create mode 100644 tools/perf/tests/tests-scripts.h
 create mode 100644 tools/perf/util/print_insn.c
 create mode 100644 tools/perf/util/print_insn.h
 create mode 100644 tools/perf/util/threads.c
 create mode 100644 tools/perf/util/threads.h

