Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34F3793315
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 02:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244138AbjIFAxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 20:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239068AbjIFAxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 20:53:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D895CDB;
        Tue,  5 Sep 2023 17:53:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19F93C433C7;
        Wed,  6 Sep 2023 00:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693961620;
        bh=4s7OE2IoewAPFnW4OBSTnH0Yr0dHnrp54bSzIvfTCVU=;
        h=From:To:Cc:Subject:Date:From;
        b=YeXPcI3qvhtwDeOTdIRtYJ3MsrtlBNRtjKMByfhma7DyJo/vuONeK4OxVjkLSy2Z7
         /NmrNyDiLDIrfEPiYEXv8fPzqOssU4+N5yP2wUVp574BI+PG0i67QMuPxGODs/9XjM
         AAQNRIEyYGz+qCc8CQMKie2GZ8RsMEOquS6pFTOLYVrI0m5QdX26Ch05rVSIi3jNQR
         Gpui5QFPU5EvroCKm2GaNENjq43gdOaQ8nFHOcX3gqN3ZiltRaqncX+KqPBJEXjPuw
         9E2+BYm4/i6cDiOSWe3+yUc7hfJQIOc6AnOQHns47czmHTEK9FChVGZHwa8CHlkBYa
         isxY1bcySG8EQ==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Aditya Gupta <adityag@linux.ibm.com>,
        Akanksha J N <akanksha@linux.ibm.com>,
        Anup Sharma <anupnewsmail@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        James Clark <james.clark@arm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Lu Hongfei <luhongfei@vivo.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools changes for v6.6
Date:   Tue,  5 Sep 2023 21:53:30 -0300
Message-ID: <20230906005330.373916-1-acme@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	Two enablement patches for RiscV are already in your tree, same
content, as reported by Stephen (linux-next), I cherry-picked them at
some point, probably the Risc-V guy didn't notice my "applied" message.

	Please consider pulling,

Best regards,

- Arnaldo


The following changes since commit 374a7f47bf401441edff0a64465e61326bf70a82:

  Merge tag '6.5-rc5-ksmbd-server' of git://git.samba.org/ksmbd (2023-08-09 21:12:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v6.6-1-2023-09-05

for you to fetch changes up to 45fc4628c15ab2cb7b2f53354b21db63f0a41f81:

  perf parse-events: Fix driver config term (2023-09-05 09:39:13 -0300)

----------------------------------------------------------------
perf tools changes for v6.6:

perf tools maintainership:

- Add git information for perf-tools and perf-tools-next trees/branches to the
  MAINTAINERS file. That is where development now takes place and myself and
  Namhyung Kim have write access, more people to come as we emulate other
  maintainer groups.

perf record:

- Record kernel data maps when 'perf record --data' is used, so that global variables can
  be resolved and used in tools that do data profiling.

perf trace:

- Remove the old, experimental support for BPF events in which a .c file was passed as
  an event: "perf trace -e hello.c" to then get compiled and loaded.

  The only known usage for that, that shipped with the kernel as an example for such events,
  augmented the raw_syscalls tracepoints and was converted to a libbpf skeleton, reusing all
  the user space components and the BPF code connected to the syscalls.

  In the end just the way to glue the BPF part and the user space type beautifiers changed,
  now being performed by libbpf skeletons.

  The next step is to use BTF to do pretty printing of all syscall types, as discussed with
  Alan Maguire and others.

  Now, on a perf built with BUILD_BPF_SKEL=1 we get most if not all path/filenames/strings,
  some of the networking data structures, perf_event_attr, etc, i.e. systemwide tracing of
  nanosleep calls and perf_event_open syscalls while 'perf stat' runs 'sleep' for 5 seconds:

  # perf trace -a -e *nanosleep,perf* perf stat -e cycles,instructions sleep 5
     0.000 (   9.034 ms): perf/327641 perf_event_open(attr_uptr: { type: 0 (PERF_TYPE_HARDWARE), size: 136, config: 0 (PERF_COUNT_HW_CPU_CYCLES), sample_type: IDENTIFIER, read_format: TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING, disabled: 1, inherit: 1, enable_on_exec: 1, exclude_guest: 1 }, pid: 327642 (perf), cpu: -1, group_fd: -1, flags: FD_CLOEXEC) = 3
     9.039 (   0.006 ms): perf/327641 perf_event_open(attr_uptr: { type: 0 (PERF_TYPE_HARDWARE), size: 136, config: 0x1 (PERF_COUNT_HW_INSTRUCTIONS), sample_type: IDENTIFIER, read_format: TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING, disabled: 1, inherit: 1, enable_on_exec: 1, exclude_guest: 1 }, pid: 327642 (perf-exec), cpu: -1, group_fd: -1, flags: FD_CLOEXEC) = 4
         ? (           ): gpm/991  ... [continued]: clock_nanosleep())               = 0
    10.133 (           ): sleep/327642 clock_nanosleep(rqtp: { .tv_sec: 5, .tv_nsec: 0 }, rmtp: 0x7ffd36f83ed0) ...
         ? (           ): pool-gsd-smart/3051  ... [continued]: clock_nanosleep())   = 0
    30.276 (           ): gpm/991 clock_nanosleep(rqtp: { .tv_sec: 2, .tv_nsec: 0 }, rmtp: 0x7ffcc6f73710) ...
   223.215 (1000.430 ms): pool-gsd-smart/3051 clock_nanosleep(rqtp: { .tv_sec: 1, .tv_nsec: 0 }, rmtp: 0x7f6e7fffec90) = 0
    30.276 (2000.394 ms): gpm/991  ... [continued]: clock_nanosleep())               = 0
  1230.814 (           ): pool-gsd-smart/3051 clock_nanosleep(rqtp: { .tv_sec: 1, .tv_nsec: 0 }, rmtp: 0x7f6e7fffec90) ...
  1230.814 (1000.404 ms): pool-gsd-smart/3051  ... [continued]: clock_nanosleep())   = 0
  2030.886 (           ): gpm/991 clock_nanosleep(rqtp: { .tv_sec: 2, .tv_nsec: 0 }, rmtp: 0x7ffcc6f73710) ...
  2237.709 (1000.153 ms): pool-gsd-smart/3051 clock_nanosleep(rqtp: { .tv_sec: 1, .tv_nsec: 0 }, rmtp: 0x7f6e7fffec90) = 0
         ? (           ): crond/1172  ... [continued]: clock_nanosleep())            = 0
  3242.699 (           ): pool-gsd-smart/3051 clock_nanosleep(rqtp: { .tv_sec: 1, .tv_nsec: 0 }, rmtp: 0x7f6e7fffec90) ...
  2030.886 (2000.385 ms): gpm/991  ... [continued]: clock_nanosleep())               = 0
  3728.078 (           ): crond/1172 clock_nanosleep(rqtp: { .tv_sec: 60, .tv_nsec: 0 }, rmtp: 0x7ffe0971dcf0) ...
  3242.699 (1000.158 ms): pool-gsd-smart/3051  ... [continued]: clock_nanosleep())   = 0
  4031.409 (           ): gpm/991 clock_nanosleep(rqtp: { .tv_sec: 2, .tv_nsec: 0 }, rmtp: 0x7ffcc6f73710) ...
    10.133 (5000.375 ms): sleep/327642  ... [continued]: clock_nanosleep())          = 0

 Performance counter stats for 'sleep 5':

         2,617,347      cycles
         1,855,997      instructions                     #    0.71  insn per cycle

       5.002282128 seconds time elapsed

       0.000855000 seconds user
       0.000852000 seconds sys
  #

perf annotate:

- Building with binutils' libopcode now is opt-in (BUILD_NONDISTRO=1) for
  licensing reasons, and we missed a build test on tools/perf/tests makefile.

  Since we now default to NDEBUG=1, we ended up segfaulting when building with
  BUILD_NONDISTRO=1 because a needed initialization routine was being "error
  checked" via an assert.

  Fix it by explicitly checking the result and aborting instead if it fails.

  We better back propagate the error, but at least 'perf annotate' on samples
  collected for a BPF program is back working when perf is built with
  BUILD_NONDISTRO=1.

perf report/top:

- Add back TUI hierarchy mode header, that is seen when using 'perf report/top --hierarchy'.

- Fix the number of entries for 'e' key in the TUI that was preventing navigation of
  lines when expanding an entry.

perf report/script:

- Support cross platform register handling, allowing a perf.data file collected
  on one architecture to have registers sampled correctly displayed when
  analysis tools such as 'perf report' and 'perf script' are used on a different
  architecture.

- Fix handling of event attributes in pipe mode, i.e. when one uses:

	perf record -o - | perf report -i -

  When no perf.data files are used.

- Handle files generated via pipe mode with a version of perf and then read
  also via pipe mode with a different version of perf, where the event attr
  record may have changed, use the record size field to properly support this
  version mismatch.

perf probe:

- Accessing global variables from uprobes isn't supported, make the error
  message state that instead of stating that some minimal kernel version is
  needed to have that feature. This seems just a tool limitation, the kernel
  probably has all that is needed.

perf tests:

- Fix a reference count related leak in the dlfilter v0 API where the result
  of a thread__find_symbol_fb() is not matched with an addr_location__exit()
  to drop the reference counts of the resolved components (machine, thread, map,
  symbol, etc). Add a dlfilter test to make sure that doesn't regresses.

- Lots of fixes for the 'perf test' written in shell script related to problems
  found with the shellcheck utility.

- Fixes for 'perf test' shell scripts testing features enabled when perf is
  built with BUILD_BPF_SKEL=1, such as 'perf stat' bpf counters.

- Add perf record sample filtering test, things like the following example, that gets
  implemented as a BPF filter attached to the event:

   # perf record -e task-clock -c 10000 --filter 'ip < 0xffffffff00000000'

- Improve the way the task_analyzer test checks if libtraceevent is linked,
  using 'perf version --build-options' instead of the more expensinve
  'perf record -e "sched:sched_switch"'.

- Add support for riscv in the mmap-basic test. (This went as well via the RiscV tree, same contents).

libperf:

- Implement riscv mmap support (This went as well via the RiscV tree, same contents).

perf script:

- New tool that converts perf.data files to the firefox profiler format so that one can use
  the visualizer at https://profiler.firefox.com/. Done by Anup Sharma as part of this year's
  Google Summer of Code.

  One can generate the output and upload it to the web interface but Anup also automated
  everything:

     perf script gecko -F 99 -a sleep 60

- Support syscall name parsing on arm64.

- Print "cgroup" field on the same line as "comm".

perf bench:

- Add new 'uprobe' benchmark to measure the overhead of uprobes with/without
  BPF programs attached to it.

- breakpoints are not available on power9, skip that test.

perf stat:

- Add #num_cpus_online literal to be used in 'perf stat' metrics, and add this extra
  'perf test' check that exemplifies its purpose:

	TEST_ASSERT_VAL("#num_cpus_online",
                       expr__parse(&num_cpus_online, ctx, "#num_cpus_online") == 0);
	TEST_ASSERT_VAL("#num_cpus", expr__parse(&num_cpus, ctx, "#num_cpus") == 0);
	TEST_ASSERT_VAL("#num_cpus >= #num_cpus_online", num_cpus >= num_cpus_online);

Miscellaneous:

- Improve tool startup time by lazily reading PMU, JSON, sysfs data.

- Improve error reporting in the parsing of events, passing YYLTYPE to error routines,
  so that the output can show were the parsing error was found.

- Add 'perf test' entries to check the parsing of events improvements.

- Fix various leak for things detected by -fsanitize=address, mostly things that would
  be freed at tool exit, including:

  - Free evsel->filter on the destructor.

  - Allow tools to register a thread->priv destructor and use it in 'perf trace'.

  - Free evsel->priv in 'perf trace'.

  - Free string returned by synthesize_perf_probe_point() when the caller fails
    to do all it needs.

- Adjust various compiler options to not consider errors some warnings when
  building with broken headers found in things like python, flex, bison, as we
  otherwise build with -Werror. Some for gcc, some for clang, some for some
  specific version of those, some for some specific version of flex or bison, or
  some specific combination of these components, bah.

- Allow customization of clang options for BPF target, this helps building on
  gentoo where there are other oddities where BPF targets gets passed some compiler
  options intended for the native build, so building with WERROR=0 helps while
  these oddities are fixed.

- Dont pass ERR_PTR() values to perf_session__delete() in 'perf top' and 'perf lock',
  fixing some segfaults when handling some odd failures.

- Add LTO build option.

- Fix format of unordered lists in the perf docs (tools/perf/Documentation).

- Overhaul the bison files, using constructs such as YYNOMEM.

- Remove unused tokens from the bison .y files.

- Add more comments to various structs.

- A few LoongArch enablement patches.

Vendor events (JSON):

- Add JSON metrics for Yitian 710 DDR (aarch64). Things like:

	EventName, BriefDescription
	visible_window_limit_reached_rd, "At least one entry in read queue reaches the visible window limit.",
	visible_window_limit_reached_wr, "At least one entry in write queue reaches the visible window limit.",
	op_is_dqsosc_mpc	       , "A DQS Oscillator MPC command to DRAM.",
	op_is_dqsosc_mrr	       , "A DQS Oscillator MRR command to DRAM.",
	op_is_tcr_mrr		       , "A Temperature Compensated Refresh(TCR) MRR command to DRAM.",

- Add AmpereOne metrics (aarch64).

- Update N2 and V2 metrics (aarch64) and events using Arm telemetry repo.

- Update scale units and descriptions of common topdown metrics on aarch64. Things like:

  - "MetricExpr": "stall_slot_frontend / (#slots * cpu_cycles)",
  - "BriefDescription": "Frontend bound L1 topdown metric",
  + "MetricExpr": "100 * (stall_slot_frontend / (#slots * cpu_cycles))",
  + "BriefDescription": "This metric is the percentage of total slots that were stalled due to resource constraints in the frontend of the processor.",

- Update events for intel: meteorlake to 1.04, sapphirerapids to 1.15, Icelake+ metric constraints.

- Update files for the power10 platform.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Aditya Gupta (1):
      perf tests task_analyzer: Check perf build options for libtraceevent support

Adrian Hunter (3):
      perf dlfilter: Add a test for resolve_address()
      perf dlfilter: Add al_cleanup()
      perf dlfilter: Avoid leak in v0 API test use of resolve_address()

Akanksha J N (1):
      perf tests trace+probe_vfs_getname: Fix shellcheck warnings about word splitting/quoting

Alexandre Ghiti (2):
      libperf: Implement riscv mmap support
      perf tests mmap-basic: Adapt for riscv

Anup Sharma (9):
      perf scripts python: Add initial script file with usage information
      perf scripts python: Extact necessary information from process event
      perf scripts python: Add classes and conversion functions
      perf scripts python: Add trace end processing and PRODUCT and CATEGORIES information
      perf scripts python: Implement add sample function and thread processing
      perf scripts python: Implement add sample function and thread processing
      perf scripts python: Add command execution for gecko script
      perf scripts python: Add support for input args in gecko script
      perf scripts python gecko: Launch the profiler UI on the default browser with the appropriate URL

Arnaldo Carvalho de Melo (34):
      perf evsel: Free evsel->filter on the destructor
      perf thread: Allow tools to register a thread->priv destructor
      perf trace: Register a thread priv destructor
      perf trace: Really free the evsel->priv area
      perf trace: Free thread_trace->files table
      MAINTAINERS: Add git information for perf-tools and perf-tools-next trees/branches
      perf bench uprobe: Add benchmark to test uprobe overhead
      perf bench uprobe: Print diff to baseline
      perf bench uprobe: Show diff to previous
      perf bench uprobe empty: Add entry attaching an empty BPF program
      perf bench uprobe trace_printk: Add entry attaching an BPF program that does a trace_printk
      perf build: Define YYNOMEM as YYNOABORT for bison < 3.81
      tools build: Add 3-component logical version comparators
      perf test bpf: Address error about non-null argument for epoll_pwait 2nd arg
      perf python: Cope with declarations after statements found in Python.h
      perf script python: Cope with declarations after statements found in Python.h
      perf annotate bpf: Don't enclose non-debug code with an assert()
      Merge remote-tracking branch 'torvalds/master' into perf-tools-next
      perf probe: Free string returned by synthesize_perf_probe_point() on failure to add a probe
      perf probe: Free string returned by synthesize_perf_probe_point() on failure in synthesize_perf_probe_command()
      perf probe: Make synthesize_perf_probe_point() private to probe-event.c
      Merge remote-tracking branch 'torvalds/master' into perf-tools-next
      perf build: Remove -Wno-unused-but-set-variable from the flex flags when building with clang < 13.0.0
      perf test trace+probe_vfs_getname.sh: Remove stray \ before /
      perf tests trace+probe_vfs_getname.sh: Accept quotes surrounding the filename
      perf dlfilter: Initialize addr_location before passing it to thread__find_symbol_fb()
      perf bpf_skel augmented_raw_syscalls: Cap the socklen parameter using &= sizeof(saddr)
      perf top: Don't pass an ERR_PTR() directly to perf_session__delete()
      perf lock: Don't pass an ERR_PTR() directly to perf_session__delete()
      perf trace: Use the augmented_raw_syscall BPF skel only for tracing syscalls
      perf trace: Use heuristic when deciding if a syscall tracepoint "const char *" field is really a string
      perf bpf augmented_raw_syscalls: Add an assert to make sure sizeof(saddr) is a power of two.
      perf bpf augmented_raw_syscalls: Add an assert to make sure sizeof(augmented_arg->value) is a power of two.
      perf lzma: Convert some pr_err() to pr_debug() as callers already use pr_debug()

Athira Rajeev (15):
      perf tests: Address signal case issues detected via shellcheck
      perf tests stat+csv_summary: Fix unused variable references detected via shellcheck
      perf tests perf_dat _converter_json: Use quoting to avoid word splitting
      perf tests stat_bpf_counters: Fix usage of '==' to address shellcheck warning
      perf tests stat+shadow_stat: Fix shellcheck warning about unused variable
      perf tests thread_loop_check_tid_10: Fix shellcheck warnings bout word splitting/quoting
      perf tests unroll_loop_thread_10: Fix shellcheck warnings about word splitting/quoting
      perf tests lib probe_vfs_getname: Fix shellcheck warnings about missing shebang/local variables
      perf tests lib waiting: Fix the shellcheck warnings about missing shebang
      perf trace x86_arch_prctl: Address shellcheck warnings about local variables
      perf arch x86: Address shellcheck warnings about unused variables in syscalltbl.sh
      perf tests record+zstd_comp_decomp: Fix the shellcheck warnings about word splitting/quoting
      perf tests stat+std_output: Fix shellcheck warnings about word splitting/quoting
      perf tests stat+std_output: Fix shellcheck warnings about word splitting/quoting and local variables
      perf symbols: Fix DSO kernel load and symbol process to correctly map DSO to its long_name, type and adjust_symbols

Changbin Du (1):
      perf docs: Fix format of unordered lists

Guilherme Amadio (1):
      perf build: Allow customization of clang options for BPF target

Ian Rogers (82):
      perf stat: Avoid uninitialized use of perf_stat_config
      perf parse-events: Avoid use uninitialized warning
      perf test: Avoid weak symbol for arch_tests
      perf build: Add LTO build option
      perf parse-events: Remove unused PE_PMU_EVENT_FAKE token
      perf parse-events: Remove unused PE_KERNEL_PMU_EVENT token
      perf parse-events: Remove two unused tokens
      perf parse-events: Add more comments to 'struct parse_events_state'
      perf parse-events: Avoid regrouped warning for wild card events
      perf parse-event: Add memory allocation test for name terms
      perf parse-events: Separate YYABORT and YYNOMEM cases
      perf parse-events: Move instances of YYABORT to YYNOMEM
      perf parse-events: Separate ENOMEM memory handling
      perf parse-events: Additional error reporting
      perf parse-events: Populate error column for BPF/tracepoint events
      perf parse-events: Improve location for add pmu
      perf parse-events: Remove ABORT_ON
      perf bpf-loader: Remove unneeded diagnostic pragma
      perf build: Don't always set -funwind-tables and -ggdb3
      perf build: Add Wextra for C++ compilation
      perf build: Disable fewer flex warnings
      perf build: Disable fewer bison warnings
      perf build: Remove -Wno-redundant-decls in 2 cases
      perf parse-event: Avoid BPF test SEGV
      perf tools: Revert enable indices setting syntax for BPF map
      perf parse-events: Remove array remnants
      perf parse-events x86: Avoid sorting uops_retired.slots
      perf vendor events intel: Update meteorlake to 1.04
      perf vendor events intel: Update sapphirerapids to 1.15
      perf vendor events intel: Update Icelake+ metric constraints
      perf script python: Add stub for PMU symbol to the python binding
      perf bpf: Remove support for embedding clang for compiling BPF events (-e foo.c)
      perf parse-events: Remove BPF event support
      perf trace: Migrate BPF augmentation to use a skeleton
      perf bpf examples: With no BPF events remove examples
      perf trace: Tidy comments related to BPF + syscall augmentation
      perf script ibs: Remove unused include
      perf pmu: Avoid a path name copy
      perf pmu: Move perf_pmu__set_format to pmu.y
      perf pmu: Reduce scope of perf_pmu_error()
      perf pmu: Avoid passing format list to perf_pmu__config_terms()
      perf pmu: Avoid passing format list to perf_pmu__format_type
      perf pmu: Avoid passing format list to perf_pmu__format_bits()
      perf pmu: Pass PMU rather than aliases and format
      perf pmu: Make the loading of formats lazy
      perf pmu: Abstract alias/event struct
      perf pmu-events: Add extra underscore to function names
      perf jevents: Group events by PMU
      perf parse-events: Improve error message for double setting
      perf s390 s390_cpumcfdg_dump: Don't scan all PMUs
      perf pmu-events: Reduce processed events by passing PMU
      perf pmu-events: Add pmu_events_table__find_event()
      perf pmu: Parse sysfs events directly from a file
      perf pmu: Prefer passing pmu to aliases list
      perf pmu: Merge JSON events with sysfs at load time
      perf pmu: Cache JSON events table
      perf pmu: Lazily add JSON events
      perf pmu: Scan type early to fail an invalid PMU quickly
      perf pmu: Be lazy about loading event info files from sysfs
      perf pmu: Lazily load sysfs aliases
      perf jevents: Sort strings in the big C string to reduce faults
      perf jevents: Don't append Unit to desc
      perf header: Fix missing PMU caps
      perf pmu: Remove logic for PMU name being NULL
      perf parse-events: Make term's config const
      perf pmu: Make id const and add missing free
      perf build-id: Simplify build_id_cache__cachedir()
      perf tui slang: Tidy casts
      perf pmus: Sort pmus by name then suffix
      perf pmus: Skip duplicate PMUs and don't print list suffix by default
      perf jevents: Use "default_core" for events with no Unit
      perf pmu: Avoid uninitialized use of alias->str
      perf parse-events: Minor help message improvements
      perf parse-events: Make common term list to strbuf helper
      perf pmu: Remove str from perf_pmu_alias
      perf metric: Add #num_cpus_online literal
      perf vendor events intel: Fix modifier in tma_info_system_mem_parallel_reads for skylake
      perf list: Don't print Unit for "default_core"
      perf parse-events: Name the two term enums
      perf parse-events: Fix propagation of term's no_value when cloning
      perf parse-events: Fixes relating to no_value terms
      perf parse-events: Fix driver config term

Ilkka Koskinen (4):
      perf vendor events arm64: Remove L1D_CACHE_LMISS from AmpereOne list
      perf vendor events arm64: AmpereOne: Mark affected STALL_* events impacted by errata
      perf vendor events arm64: Add AmpereOne metrics
      perf vendor events arm64: AmpereOne: Remove unsupported events

Ivan Babrou (1):
      perf script: Print "cgroup" field on the same line as "comm"

James Clark (8):
      perf tools: Add a place to put kernel config fragments for test runs
      perf cs-etm: Don't duplicate FIELD_GET()
      perf vendor events arm64: Update scale units and descriptions of common topdown metrics
      perf arm64: Allow version comparisons of CPU IDs
      perf test: Add a test for the new Arm CPU ID comparison behavior
      perf jevents: Add a new expression builtin strcmp_cpuid_str()
      perf vendor events arm64: Update stall_slot workaround for N2 r0p3
      perf vendor events arm64: Update N2 and V2 metrics and events using Arm telemetry repo

Jing Zhang (3):
      perf jevents: Add support for Yitian 710 DDR PMU (arm64) aliasing
      perf vendor events arm64: Add JSON metrics for Yitian 710 DDR
      perf docs: Update metric usage for Alibaba's T-Head PMU driver (arm64)

John Garry (1):
      perf jevents: Raise exception for no definition of a arch std event

Kaige Ye (1):
      perf stat-display: Check if snprintf()'s fmt argument is NULL

Kajol Jain (20):
      perf tests probe_vfs_getname: Fix shellcheck warnings about word splitting/quoting
      perf tests record_offcpu: Fix shellcheck warnings about word splitting/quoting and signal names case
      perf tests lock_contention: Fix shellcheck issue about quoting to avoid word splitting
      perf test stat_bpf_counters_cgrp: Fix shellcheck issue about logical operators
      perf tests asm_pure_loop: Fix shellcheck warning about word splitting/quote
      perf tests memcpy_thread_16k_10: Fix shellcheck warning about word splitting/quote
      perf tests lib probe: Fix shellcheck warning about about missing shebang
      perf beauty arch_errno_names: Fix shellcheck issue about local variables
      perf build: Fix shellcheck issue about quotes for check-headers.sh
      perf tests coresight thread_loop_check_tid_2: Fix shellcheck warnings about word splitting/quoting
      perf tests lib stat_output: Fix shellcheck warning about missing shebang
      perf vendor events: Update the JSON/events descriptions for power10 platform
      perf vendor events: Drop some of the JSON/events for power10 platform
      perf vendor events: Drop STORES_PER_INST metric event for power10 platform
      perf vendor events: Move JSON/events to appropriate files for power10 platform
      perf vendor events: Update JSON/events for power10 platform
      perf vendor events: Update metric event names for power10 platform
      perf vendor events: Update metric events for power10 platform
      perf bench breakpoint: Skip run if no breakpoints available
      perf lock contention: Fix typo in max-stack option description

Leo Yan (6):
      perf parse-regs: Refactor arch register parsing functions
      perf parse-regs: Introduce functions perf_arch_reg_{ip|sp}()
      perf unwind: Use perf_arch_reg_{ip|sp}() to substitute macros
      perf parse-regs: Remove unused macros PERF_REG_{IP|SP}
      perf parse-regs: Remove PERF_REGS_{MAX|MASK} from common code
      perf parse-regs: Move out arch specific header from util/perf_regs.h

Lu Hongfei (1):
      perf diff: Replaces some ',' as separator with the more usual ';'

Masami Hiramatsu (1):
      perf probe: Show correct error message about @symbol usage for uprobe

Namhyung Kim (15):
      perf symbols: Add kallsyms__get_symbol_start()
      perf machine: Include data symbols in the kernel map
      perf build: Update build rule for generated files
      perf build: Include generated header files properly
      perf hists browser: Fix hierarchy mode header
      perf hists browser: Fix the number of entries for 'e' key
      perf bpf-filter: Fix sample flag check with ||
      perf test: Add perf record sample filtering test
      perf tools: Handle old data in PERF_RECORD_ATTR
      libperf: Add perf_record_header_attr_id()
      perf tools: Convert to perf_record_header_attr_id()
      libperf: Get rid of attr.id field
      perf test shell record_bpf_filter: Skip 6.2 kernel
      perf test shell stat_bpf_counters: Fix test on Intel
      perf test stat_bpf_counters_cgrp: Enhance perf stat cgroup BPF counter test

Thomas Richter (2):
      perf build: Update feature check for clang and llvm
      perf build: Support llvm and clang support compiled in

Wei Li (2):
      perf scripts python: Support syscall name parsing on arm64
      perf scripts python: Update audit-libs package name for python3

Xiu Jianfeng (1):
      perf doc: Fix typo in perf.data-file-format.txt

Yang Jihong (1):
      perf evsel: Remove duplicate check for `field` in evsel__intval()

Yanteng Si (3):
      perf tools: Allow to use cpuinfo on LoongArch
      perf beauty mmap_flags: Fix script for archs that use the generic mman.h
      perf beauty mmap_flags: Use "test -f" instead of "[-f FILE]"

 Documentation/admin-guide/perf/alibaba_pmu.rst     |    5 +
 MAINTAINERS                                        |    2 +
 tools/build/Makefile.build                         |   10 +
 tools/build/feature/Makefile                       |   10 +-
 tools/build/feature/test-clang.cpp                 |   28 -
 tools/build/feature/test-cxx.cpp                   |   16 -
 tools/build/feature/test-llvm-version.cpp          |   12 -
 tools/build/feature/test-llvm.cpp                  |   14 -
 tools/lib/perf/include/perf/event.h                |   14 +-
 tools/lib/perf/mmap.c                              |   66 +
 tools/perf/Documentation/perf-bench.txt            |    3 +
 tools/perf/Documentation/perf-config.txt           |   33 -
 tools/perf/Documentation/perf-dlfilter.txt         |   22 +-
 tools/perf/Documentation/perf-ftrace.txt           |   16 +-
 tools/perf/Documentation/perf-record.txt           |   95 +-
 tools/perf/Documentation/perf.data-file-format.txt |    2 +-
 tools/perf/Makefile.config                         |   59 +-
 tools/perf/Makefile.perf                           |   36 +-
 tools/perf/arch/arm/include/perf_regs.h            |    3 -
 tools/perf/arch/arm/util/cs-etm.c                  |   12 +-
 tools/perf/arch/arm/util/perf_regs.c               |   11 +
 tools/perf/arch/arm/util/unwind-libdw.c            |    1 +
 tools/perf/arch/arm64/include/arch-tests.h         |    3 +
 tools/perf/arch/arm64/include/perf_regs.h          |    3 -
 tools/perf/arch/arm64/tests/Build                  |    1 +
 tools/perf/arch/arm64/tests/arch-tests.c           |    4 +
 tools/perf/arch/arm64/tests/cpuid-match.c          |   37 +
 tools/perf/arch/arm64/util/arm-spe.c               |    2 +-
 tools/perf/arch/arm64/util/header.c                |   67 +-
 tools/perf/arch/arm64/util/machine.c               |    1 +
 tools/perf/arch/arm64/util/mem-events.c            |    2 +-
 tools/perf/arch/arm64/util/perf_regs.c             |    6 +
 tools/perf/arch/arm64/util/pmu.c                   |   18 +-
 tools/perf/arch/arm64/util/unwind-libdw.c          |    1 +
 tools/perf/arch/csky/include/perf_regs.h           |    3 -
 tools/perf/arch/csky/util/perf_regs.c              |   11 +
 tools/perf/arch/csky/util/unwind-libdw.c           |    1 +
 tools/perf/arch/loongarch/include/perf_regs.h      |    2 -
 tools/perf/arch/loongarch/util/perf_regs.c         |   11 +
 tools/perf/arch/loongarch/util/unwind-libdw.c      |    1 +
 tools/perf/arch/mips/include/perf_regs.h           |    2 -
 tools/perf/arch/mips/util/perf_regs.c              |   11 +
 tools/perf/arch/powerpc/include/perf_regs.h        |    3 -
 tools/perf/arch/powerpc/util/mem-events.c          |    6 +-
 tools/perf/arch/powerpc/util/perf_regs.c           |    6 +
 tools/perf/arch/powerpc/util/unwind-libdw.c        |    1 +
 tools/perf/arch/riscv/include/perf_regs.h          |    3 -
 tools/perf/arch/riscv/util/perf_regs.c             |   11 +
 tools/perf/arch/riscv/util/unwind-libdw.c          |    1 +
 tools/perf/arch/s390/include/perf_regs.h           |    3 -
 tools/perf/arch/s390/util/perf_regs.c              |   11 +
 tools/perf/arch/s390/util/unwind-libdw.c           |    1 +
 tools/perf/arch/x86/entry/syscalls/syscalltbl.sh   |    2 +-
 tools/perf/arch/x86/include/perf_regs.h            |    2 -
 tools/perf/arch/x86/util/evlist.c                  |    7 +-
 tools/perf/arch/x86/util/evsel.c                   |    7 +-
 tools/perf/arch/x86/util/intel-pt.c                |   39 +-
 tools/perf/arch/x86/util/mem-events.c              |    8 +-
 tools/perf/arch/x86/util/perf_regs.c               |    6 +
 tools/perf/arch/x86/util/pmu.c                     |   10 +-
 tools/perf/arch/x86/util/unwind-libdw.c            |    1 +
 tools/perf/bench/Build                             |    1 +
 tools/perf/bench/bench.h                           |    3 +
 tools/perf/bench/breakpoint.c                      |   24 +-
 tools/perf/bench/pmu-scan.c                        |    8 +-
 tools/perf/bench/uprobe.c                          |  198 ++
 tools/perf/builtin-bench.c                         |    8 +
 tools/perf/builtin-diff.c                          |    4 +-
 tools/perf/builtin-list.c                          |   23 +-
 tools/perf/builtin-lock.c                          |    3 +-
 tools/perf/builtin-record.c                        |   45 -
 tools/perf/builtin-script.c                        |   22 +-
 tools/perf/builtin-top.c                           |    1 +
 tools/perf/builtin-trace.c                         |  338 ++--
 tools/perf/check-headers.sh                        |    6 +-
 tools/perf/dlfilters/dlfilter-test-api-v0.c        |   26 +-
 tools/perf/dlfilters/dlfilter-test-api-v2.c        |  377 ++++
 tools/perf/examples/bpf/5sec.c                     |   53 -
 tools/perf/examples/bpf/empty.c                    |   12 -
 tools/perf/examples/bpf/hello.c                    |   27 -
 tools/perf/examples/bpf/sys_enter_openat.c         |   33 -
 tools/perf/include/perf/perf_dlfilter.h            |   11 +-
 tools/perf/perf.c                                  |    2 -
 tools/perf/pmu-events/Build                        |    6 +
 .../arch/arm64/ampere/ampereone/cache.json         |    3 -
 .../arch/arm64/ampere/ampereone/core-imp-def.json  |  120 --
 .../arch/arm64/ampere/ampereone/metrics.json       |  362 ++++
 .../arch/arm64/ampere/ampereone/pipeline.json      |   12 +-
 .../arch/arm64/arm/neoverse-n2-v2/branch.json      |    8 -
 .../arch/arm64/arm/neoverse-n2-v2/bus.json         |   18 +-
 .../arch/arm64/arm/neoverse-n2-v2/cache.json       |  155 --
 .../arch/arm64/arm/neoverse-n2-v2/exception.json   |   45 +-
 .../arm64/arm/neoverse-n2-v2/fp_operation.json     |   22 +
 .../arch/arm64/arm/neoverse-n2-v2/general.json     |   10 +
 .../arch/arm64/arm/neoverse-n2-v2/instruction.json |  143 --
 .../arch/arm64/arm/neoverse-n2-v2/l1d_cache.json   |   54 +
 .../arch/arm64/arm/neoverse-n2-v2/l1i_cache.json   |   14 +
 .../arch/arm64/arm/neoverse-n2-v2/l2_cache.json    |   50 +
 .../arch/arm64/arm/neoverse-n2-v2/l3_cache.json    |   22 +
 .../arch/arm64/arm/neoverse-n2-v2/ll_cache.json    |   10 +
 .../arch/arm64/arm/neoverse-n2-v2/memory.json      |   39 +-
 .../arch/arm64/arm/neoverse-n2-v2/metrics.json     |  365 ++--
 .../arch/arm64/arm/neoverse-n2-v2/pipeline.json    |   23 -
 .../arch/arm64/arm/neoverse-n2-v2/retired.json     |   30 +
 .../arch/arm64/arm/neoverse-n2-v2/spe.json         |   12 +-
 .../arm64/arm/neoverse-n2-v2/spec_operation.json   |  110 +
 .../arch/arm64/arm/neoverse-n2-v2/stall.json       |   30 +
 .../arch/arm64/arm/neoverse-n2-v2/sve.json         |   50 +
 .../arch/arm64/arm/neoverse-n2-v2/tlb.json         |   66 +
 .../arch/arm64/arm/neoverse-n2-v2/trace.json       |   27 +-
 .../arm64/freescale/yitian710/sys/ali_drw.json     |  373 ++++
 .../arm64/freescale/yitian710/sys/metrics.json     |   20 +
 tools/perf/pmu-events/arch/arm64/sbsa.json         |   24 +-
 .../pmu-events/arch/powerpc/power10/cache.json     |   47 +-
 .../arch/powerpc/power10/floating_point.json       |   66 +-
 .../pmu-events/arch/powerpc/power10/frontend.json  |  197 +-
 .../pmu-events/arch/powerpc/power10/marked.json    |  224 ++-
 .../pmu-events/arch/powerpc/power10/memory.json    |   93 +-
 .../pmu-events/arch/powerpc/power10/metrics.json   |   89 +-
 .../pmu-events/arch/powerpc/power10/others.json    |  210 +-
 .../pmu-events/arch/powerpc/power10/pipeline.json  |  292 ++-
 .../perf/pmu-events/arch/powerpc/power10/pmc.json  |  198 +-
 .../arch/powerpc/power10/translation.json          |   43 +-
 .../pmu-events/arch/x86/alderlake/adl-metrics.json |   11 +-
 .../arch/x86/alderlaken/adln-metrics.json          |    2 +
 .../pmu-events/arch/x86/icelake/icl-metrics.json   |   10 +-
 .../pmu-events/arch/x86/icelakex/icx-metrics.json  |   10 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv         |    4 +-
 .../perf/pmu-events/arch/x86/meteorlake/cache.json |  165 ++
 .../arch/x86/meteorlake/floating-point.json        |    8 +
 .../pmu-events/arch/x86/meteorlake/frontend.json   |   56 +
 .../pmu-events/arch/x86/meteorlake/memory.json     |   80 +
 .../perf/pmu-events/arch/x86/meteorlake/other.json |   16 +
 .../pmu-events/arch/x86/meteorlake/pipeline.json   |  159 ++
 .../arch/x86/rocketlake/rkl-metrics.json           |   10 +-
 .../pmu-events/arch/x86/sapphirerapids/other.json  |   18 +
 .../arch/x86/sapphirerapids/spr-metrics.json       |    9 +-
 .../pmu-events/arch/x86/skylake/skl-metrics.json   |    2 +-
 .../pmu-events/arch/x86/tigerlake/tgl-metrics.json |   10 +-
 tools/perf/pmu-events/empty-pmu-events.c           |   49 +-
 tools/perf/pmu-events/jevents.py                   |  330 ++-
 tools/perf/pmu-events/metric.py                    |   17 +-
 tools/perf/pmu-events/pmu-events.h                 |   15 +-
 tools/perf/scripts/python/Perf-Trace-Util/Build    |    3 +-
 .../python/Perf-Trace-Util/lib/Perf/Trace/Util.py  |    7 +-
 tools/perf/scripts/python/bin/gecko-record         |    2 +
 tools/perf/scripts/python/bin/gecko-report         |    7 +
 tools/perf/scripts/python/gecko.py                 |  395 ++++
 tools/perf/tests/.gitignore                        |    5 -
 tools/perf/tests/Build                             |   31 -
 tools/perf/tests/bpf-script-example.c              |   60 -
 tools/perf/tests/bpf-script-test-kbuild.c          |   21 -
 tools/perf/tests/bpf-script-test-prologue.c        |   49 -
 tools/perf/tests/bpf-script-test-relocation.c      |   51 -
 tools/perf/tests/bpf.c                             |  389 ----
 tools/perf/tests/builtin-test.c                    |   14 +-
 tools/perf/tests/clang.c                           |   32 -
 tools/perf/tests/config-fragments/README           |    7 +
 tools/perf/tests/config-fragments/arm64            |    1 +
 tools/perf/tests/config-fragments/config           |   11 +
 tools/perf/tests/dlfilter-test.c                   |   38 +-
 tools/perf/tests/expr.c                            |    5 +-
 tools/perf/tests/llvm.c                            |  219 --
 tools/perf/tests/llvm.h                            |   31 -
 tools/perf/tests/make                              |    1 -
 tools/perf/tests/mmap-basic.c                      |    6 +-
 tools/perf/tests/parse-events.c                    |    4 +-
 tools/perf/tests/pmu-events.c                      |  208 +-
 tools/perf/tests/pmu.c                             |   94 +-
 tools/perf/tests/shell/coresight/asm_pure_loop.sh  |    2 +-
 .../tests/shell/coresight/memcpy_thread_16k_10.sh  |    2 +-
 .../shell/coresight/thread_loop_check_tid_10.sh    |    2 +-
 .../shell/coresight/thread_loop_check_tid_2.sh     |    2 +-
 .../tests/shell/coresight/unroll_loop_thread_10.sh |    2 +-
 tools/perf/tests/shell/lib/probe.sh                |    1 +
 tools/perf/tests/shell/lib/probe_vfs_getname.sh    |    5 +-
 tools/perf/tests/shell/lib/stat_output.sh          |    1 +
 tools/perf/tests/shell/lib/waiting.sh              |    1 +
 tools/perf/tests/shell/lock_contention.sh          |   12 +-
 tools/perf/tests/shell/probe_vfs_getname.sh        |    4 +-
 tools/perf/tests/shell/record+zstd_comp_decomp.sh  |   14 +-
 tools/perf/tests/shell/record_bpf_filter.sh        |  134 ++
 tools/perf/tests/shell/record_offcpu.sh            |    6 +-
 tools/perf/tests/shell/stat+csv_output.sh          |    2 +-
 tools/perf/tests/shell/stat+csv_summary.sh         |    4 +-
 tools/perf/tests/shell/stat+shadow_stat.sh         |    4 +-
 tools/perf/tests/shell/stat+std_output.sh          |    3 +-
 tools/perf/tests/shell/stat_bpf_counters.sh        |    8 +-
 tools/perf/tests/shell/stat_bpf_counters_cgrp.sh   |   28 +-
 tools/perf/tests/shell/test_arm_spe_fork.sh        |    2 +-
 .../tests/shell/test_perf_data_converter_json.sh   |    2 +-
 tools/perf/tests/shell/test_task_analyzer.sh       |    2 +-
 tools/perf/tests/shell/trace+probe_vfs_getname.sh  |    8 +-
 tools/perf/tests/stat.c                            |    2 +-
 tools/perf/tests/tests.h                           |    2 -
 tools/perf/trace/beauty/arch_errno_names.sh        |   15 +-
 tools/perf/trace/beauty/beauty.h                   |   15 +-
 tools/perf/trace/beauty/mmap_flags.sh              |    7 +-
 tools/perf/trace/beauty/mmap_prot.sh               |    5 +-
 tools/perf/trace/beauty/x86_arch_prctl.sh          |    6 +-
 tools/perf/ui/Build                                |    2 -
 tools/perf/ui/browser.c                            |    6 +-
 tools/perf/ui/browsers/Build                       |    5 -
 tools/perf/ui/browsers/hists.c                     |   60 +-
 tools/perf/ui/libslang.h                           |   20 +-
 tools/perf/ui/tui/helpline.c                       |    2 +-
 tools/perf/ui/tui/setup.c                          |    2 +-
 tools/perf/ui/tui/util.c                           |   12 +-
 tools/perf/util/Build                              |   72 +-
 tools/perf/util/amd-sample-raw.c                   |    1 -
 tools/perf/util/annotate.c                         |   10 +-
 tools/perf/util/bpf-filter.c                       |   14 +-
 tools/perf/util/bpf-filter.y                       |    2 +
 tools/perf/util/bpf-loader.c                       | 2110 --------------------
 tools/perf/util/bpf-loader.h                       |  216 --
 .../bpf_skel/augmented_raw_syscalls.bpf.c}         |   53 +-
 tools/perf/util/bpf_skel/bench_uprobe.bpf.c        |   23 +
 tools/perf/util/build-id.c                         |    6 +-
 tools/perf/util/c++/Build                          |    2 -
 tools/perf/util/c++/clang-c.h                      |   43 -
 tools/perf/util/c++/clang-test.cpp                 |   67 -
 tools/perf/util/c++/clang.cpp                      |  225 ---
 tools/perf/util/c++/clang.h                        |   27 -
 tools/perf/util/config.c                           |    4 -
 tools/perf/util/cs-etm.c                           |   14 +-
 tools/perf/util/dlfilter.c                         |   32 +
 tools/perf/util/env.c                              |    8 +-
 tools/perf/util/event.c                            |   30 +-
 tools/perf/util/event.h                            |    2 +
 tools/perf/util/evsel.c                            |   10 +-
 tools/perf/util/expr.c                             |   29 +-
 tools/perf/util/expr.h                             |    1 +
 tools/perf/util/expr.l                             |    1 +
 tools/perf/util/expr.y                             |   12 +-
 tools/perf/util/header.c                           |   52 +-
 tools/perf/util/libunwind/arm64.c                  |    2 -
 tools/perf/util/libunwind/x86_32.c                 |    2 -
 tools/perf/util/llvm-utils.c                       |  612 ------
 tools/perf/util/llvm-utils.h                       |   69 -
 tools/perf/util/lzma.c                             |   12 +-
 tools/perf/util/machine.c                          |    4 +-
 tools/perf/util/mem-events.c                       |   16 +-
 tools/perf/util/mem-events.h                       |    2 +-
 tools/perf/util/metricgroup.c                      |   10 +-
 tools/perf/util/parse-events.c                     |  723 +++----
 tools/perf/util/parse-events.h                     |  104 +-
 tools/perf/util/parse-events.l                     |   44 +-
 tools/perf/util/parse-events.y                     |  448 ++---
 tools/perf/util/perf-regs-arch/Build               |    9 +
 tools/perf/util/perf-regs-arch/perf_regs_aarch64.c |   96 +
 tools/perf/util/perf-regs-arch/perf_regs_arm.c     |   60 +
 tools/perf/util/perf-regs-arch/perf_regs_csky.c    |  100 +
 .../perf/util/perf-regs-arch/perf_regs_loongarch.c |   91 +
 tools/perf/util/perf-regs-arch/perf_regs_mips.c    |   87 +
 tools/perf/util/perf-regs-arch/perf_regs_powerpc.c |  145 ++
 tools/perf/util/perf-regs-arch/perf_regs_riscv.c   |   92 +
 tools/perf/util/perf-regs-arch/perf_regs_s390.c    |   96 +
 tools/perf/util/perf-regs-arch/perf_regs_x86.c     |   98 +
 tools/perf/util/perf_regs.c                        |  772 +------
 tools/perf/util/perf_regs.h                        |   56 +-
 tools/perf/util/pmu.c                              |  934 ++++++---
 tools/perf/util/pmu.h                              |  122 +-
 tools/perf/util/pmu.y                              |   35 +-
 tools/perf/util/pmus.c                             |  326 +--
 tools/perf/util/pmus.h                             |    2 +
 tools/perf/util/print-events.h                     |    1 +
 tools/perf/util/probe-event.c                      |   30 +-
 tools/perf/util/probe-event.h                      |    1 -
 tools/perf/util/python-ext-sources                 |    9 +
 tools/perf/util/python.c                           |    5 +
 tools/perf/util/s390-sample-raw.c                  |   51 +-
 tools/perf/util/scripting-engines/Build            |    3 +-
 tools/perf/util/session.c                          |    4 +-
 tools/perf/util/setup.py                           |    3 +
 tools/perf/util/stat-display.c                     |    4 +-
 tools/perf/util/stat.c                             |    2 +-
 tools/perf/util/svghelper.c                        |    2 +-
 tools/perf/util/symbol-elf.c                       |    2 +
 tools/perf/util/symbol.c                           |   15 +-
 tools/perf/util/synthetic-events.c                 |    2 +-
 tools/perf/util/thread.c                           |   13 +
 tools/perf/util/thread.h                           |    2 +
 tools/perf/util/unwind-libdw.c                     |    8 +-
 tools/perf/util/unwind-libunwind-local.c           |    6 +-
 tools/perf/util/unwind.h                           |    8 -
 tools/scripts/utilities.mak                        |   20 +
 286 files changed, 8081 insertions(+), 9121 deletions(-)
 delete mode 100644 tools/build/feature/test-clang.cpp
 delete mode 100644 tools/build/feature/test-cxx.cpp
 delete mode 100644 tools/build/feature/test-llvm-version.cpp
 delete mode 100644 tools/build/feature/test-llvm.cpp
 create mode 100644 tools/perf/arch/arm64/tests/cpuid-match.c
 create mode 100644 tools/perf/bench/uprobe.c
 create mode 100644 tools/perf/dlfilters/dlfilter-test-api-v2.c
 delete mode 100644 tools/perf/examples/bpf/5sec.c
 delete mode 100644 tools/perf/examples/bpf/empty.c
 delete mode 100644 tools/perf/examples/bpf/hello.c
 delete mode 100644 tools/perf/examples/bpf/sys_enter_openat.c
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/branch.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/fp_operation.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/general.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/l1d_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/l1i_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/l2_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/l3_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/ll_cache.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/retired.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/spec_operation.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/stall.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/sve.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/tlb.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/yitian710/sys/ali_drw.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/yitian710/sys/metrics.json
 create mode 100644 tools/perf/scripts/python/bin/gecko-record
 create mode 100755 tools/perf/scripts/python/bin/gecko-report
 create mode 100644 tools/perf/scripts/python/gecko.py
 delete mode 100644 tools/perf/tests/.gitignore
 delete mode 100644 tools/perf/tests/bpf-script-example.c
 delete mode 100644 tools/perf/tests/bpf-script-test-kbuild.c
 delete mode 100644 tools/perf/tests/bpf-script-test-prologue.c
 delete mode 100644 tools/perf/tests/bpf-script-test-relocation.c
 delete mode 100644 tools/perf/tests/bpf.c
 delete mode 100644 tools/perf/tests/clang.c
 create mode 100644 tools/perf/tests/config-fragments/README
 create mode 100644 tools/perf/tests/config-fragments/arm64
 create mode 100644 tools/perf/tests/config-fragments/config
 delete mode 100644 tools/perf/tests/llvm.c
 delete mode 100644 tools/perf/tests/llvm.h
 create mode 100755 tools/perf/tests/shell/record_bpf_filter.sh
 delete mode 100644 tools/perf/util/bpf-loader.c
 delete mode 100644 tools/perf/util/bpf-loader.h
 rename tools/perf/{examples/bpf/augmented_raw_syscalls.c => util/bpf_skel/augmented_raw_syscalls.bpf.c} (91%)
 create mode 100644 tools/perf/util/bpf_skel/bench_uprobe.bpf.c
 delete mode 100644 tools/perf/util/c++/Build
 delete mode 100644 tools/perf/util/c++/clang-c.h
 delete mode 100644 tools/perf/util/c++/clang-test.cpp
 delete mode 100644 tools/perf/util/c++/clang.cpp
 delete mode 100644 tools/perf/util/c++/clang.h
 delete mode 100644 tools/perf/util/llvm-utils.c
 delete mode 100644 tools/perf/util/llvm-utils.h
 create mode 100644 tools/perf/util/perf-regs-arch/Build
 create mode 100644 tools/perf/util/perf-regs-arch/perf_regs_aarch64.c
 create mode 100644 tools/perf/util/perf-regs-arch/perf_regs_arm.c
 create mode 100644 tools/perf/util/perf-regs-arch/perf_regs_csky.c
 create mode 100644 tools/perf/util/perf-regs-arch/perf_regs_loongarch.c
 create mode 100644 tools/perf/util/perf-regs-arch/perf_regs_mips.c
 create mode 100644 tools/perf/util/perf-regs-arch/perf_regs_powerpc.c
 create mode 100644 tools/perf/util/perf-regs-arch/perf_regs_riscv.c
 create mode 100644 tools/perf/util/perf-regs-arch/perf_regs_s390.c
 create mode 100644 tools/perf/util/perf-regs-arch/perf_regs_x86.c
