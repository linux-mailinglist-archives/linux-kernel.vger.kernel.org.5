Return-Path: <linux-kernel+bounces-21473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B09828FEA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68EB41F261AD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40743DBBE;
	Tue,  9 Jan 2024 22:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHzIi4GM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9923DBA9;
	Tue,  9 Jan 2024 22:28:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66B9C433C7;
	Tue,  9 Jan 2024 22:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704839301;
	bh=qOl+huBG/lLt5d4eTx1vJLFSu7uPBA8ErFMXZjcnJXk=;
	h=From:To:Cc:Subject:Date:From;
	b=VHzIi4GM8jZ8Vph0E0gNWHoqz5s85wqzTMIfwbTf2wmklYrIo/tegK+3wx51HDfog
	 uF1IBdFDveJrl8xR38q7S/YE8yg+BWJnDXlH+Igr5SDRropKgU4QGbRq3UAS2R3UwL
	 5pjOOb3t/0qC8hsF+6axC0R078r1BDG6YpPonjdSNOosjsgD6N8Rnbhq+IHBpl4KZN
	 O4OPgsZhCsVelyYV7AhAen6RMwFunmSX/OA2tTGDmNXI6i+cDN/3ICbPbKt8ovAOtb
	 MVkeIPNS5VFjPSOY9mtgEMHecJw6SxkzF98uD9JMIQBfpfgZKBFowhfhByHkfRnNqS
	 mQfZsfIfTN3lQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ammy Yi <ammy.yi@intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Benjamin Gray <bgray@linux.ibm.com>,
	Chengen Du <chengen.du@canonical.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	David Laight <David.Laight@ACULAB.COM>,
	Disha Goel <disgoel@linux.ibm.com>,
	Guo Ren <guoren@kernel.org>,
	Hector Martin <marcan@marcan.st>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	James Clark <james.clark@arm.com>,
	Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Leo Yan <leo.yan@linaro.org>,
	Likhitha Korrapati <likhitha@linux.ibm.com>,
	Marc Zyngier <maz@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Nick Forrington <nick.forrington@arm.com>,
	Paran Lee <p4ranlee@gmail.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>,
	zhujun2 <zhujun2@cmss.chinamobile.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools changes for v6.8
Date: Tue,  9 Jan 2024 19:28:04 -0300
Message-ID: <20240109222804.28583-1-acme@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

	Please consider pulling,

Best regards,

- Arnaldo

The following changes since commit 2cf4f94d8e8646803f8fb0facf134b0cd7fb691a:

  Merge tag 'scsi-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi (2023-12-18 11:11:09 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v6.8-1-2024-01-09

for you to fetch changes up to d988c9f511af71a3445b6a4f3a2c67208ff8e480:

  MAINTAINERS: Add Namhyung as tools/perf/ co-maintainer (2024-01-08 17:29:15 -0300)

----------------------------------------------------------------
perf tools improvements and fixes for v6.8:

- Add Namhyung Kim as tools/perf/ co-maintainer, we're taking turns processing
  patches, switching roles from perf-tools to perf-tools-next at each Linux
  release.

Data profiling:

- Associate samples that identify loads and stores with data structures. This
  uses events available on Intel, AMD and others and DWARF info:

    # To get memory access samples in kernel for 1 second (on Intel)
    $ perf mem record -a -K --ldlat=4 -- sleep 1

    # Similar for the AMD (but it requires 6.3+ kernel for BPF filters)
    $ perf mem record -a --filter 'mem_op == load || mem_op == store, ip > 0x8000000000000000' -- sleep 1

  Then, amongst several modes of post processing, one can do things like:

    $ perf report -s type,typeoff --hierarchy --group --stdio
    ...
    #
    # Samples: 10K of events 'cpu/mem-loads,ldlat=4/P, cpu/mem-stores/P, dummy:u'
    # Event count (approx.): 602758064
    #
    #                    Overhead  Data Type / Data Type Offset
    # ...........................  ............................
    #
        26.09%   3.28%   0.00%     long unsigned int
           26.09%   3.28%   0.00%     long unsigned int +0 (no field)
        18.48%   0.73%   0.00%     struct page
           10.83%   0.02%   0.00%     struct page +8 (lru.next)
            3.90%   0.28%   0.00%     struct page +0 (flags)
            3.45%   0.06%   0.00%     struct page +24 (mapping)
            0.25%   0.28%   0.00%     struct page +48 (_mapcount.counter)
            0.02%   0.06%   0.00%     struct page +32 (index)
            0.02%   0.00%   0.00%     struct page +52 (_refcount.counter)
            0.02%   0.01%   0.00%     struct page +56 (memcg_data)
            0.00%   0.01%   0.00%     struct page +16 (lru.prev)
        15.37%  17.54%   0.00%     (stack operation)
           15.37%  17.54%   0.00%     (stack operation) +0 (no field)
        11.71%  50.27%   0.00%     (unknown)
           11.71%  50.27%   0.00%     (unknown) +0 (no field)

    $ perf annotate --data-type
    ...
    Annotate type: 'struct cfs_rq' in [kernel.kallsyms] (13 samples):
    ============================================================================
        samples     offset       size  field
             13          0        640  struct cfs_rq         {
              2          0         16      struct load_weight       load {
              2          0          8          unsigned long        weight;
              0          8          4          u32  inv_weight;
                                           };
              0         16          8      unsigned long    runnable_weight;
              0         24          4      unsigned int     nr_running;
              1         28          4      unsigned int     h_nr_running;
    ...

    $ perf annotate --data-type=page --group
    Annotate type: 'struct page' in [kernel.kallsyms] (480 samples):
     event[0] = cpu/mem-loads,ldlat=4/P
     event[1] = cpu/mem-stores/P
     event[2] = dummy:u
    ===================================================================================
             samples  offset  size  field
    447  33        0       0    64  struct page     {
    108   8        0       0     8	 long unsigned int  flags;
    319  13        0       8    40	 union       {
    319  13        0       8    40          struct          {
    236   2        0       8    16              union       {
    236   2        0       8    16                  struct list_head       lru {
    236   1        0       8     8                      struct list_head*  next;
      0   1        0      16     8                      struct list_head*  prev;
                                                    };
    236   2        0       8    16                  struct          {
    236   1        0       8     8                      void*      __filler;
      0   1        0      16     4                      unsigned int       mlock_count;
                                                    };
    236   2        0       8    16                  struct list_head       buddy_list {
    236   1        0       8     8                      struct list_head*  next;
      0   1        0      16     8                      struct list_head*  prev;
                                                    };
    236   2        0       8    16                  struct list_head       pcp_list {
    236   1        0       8     8                      struct list_head*  next;
      0   1        0      16     8                      struct list_head*  prev;
                                                    };
                                                };
     82   4        0      24     8              struct address_space*      mapping;
      1   7        0      32     8              union       {
      1   7        0      32     8                  long unsigned int      index;
      1   7        0      32     8                  long unsigned int      share;
                                                };
      0   0        0      40     8              long unsigned int  private;
                                                              };

  This uses the existing annotate code, calling objdump to do the disassembly,
  with improvements to avoid having this take too long, but longer term a
  switch to a disassembler library, possibly reusing code in the kernel will
  be pursued.

  This is the initial implementation, please use it and report impressions and
  bugs. Make sure the kernel-debuginfo packages match the running kernel. The
  'perf report' phase for non short perf.data files may take a while.

  There is a great article about it on LWN:

  https://lwn.net/Articles/955709/ - "Data-type profiling for perf"

  One last test I did while writing this text, on a AMD Ryzen 5950X, using a distro
  kernel, while doing a simple 'find /' on an otherwise idle system resulted in:

  # uname -r
  6.6.9-100.fc38.x86_64
  # perf -vv | grep BPF_
                   bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
         bpf_skeletons: [ on  ]  # HAVE_BPF_SKEL
  # rpm -qa | grep kernel-debuginfo
  kernel-debuginfo-common-x86_64-6.6.9-100.fc38.x86_64
  kernel-debuginfo-6.6.9-100.fc38.x86_64
  #
  # perf mem record -a --filter 'mem_op == load || mem_op == store, ip > 0x8000000000000000'
  ^C[ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 2.199 MB perf.data (2913 samples) ]
  #
  # ls -la perf.data
  -rw-------. 1 root root 2346486 Jan  9 18:36 perf.data
  # perf evlist
  ibs_op//
  dummy:u
  # perf evlist -v
  ibs_op//: type: 11, size: 136, config: 0, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|ADDR|CPU|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT, read_format: ID, disabled: 1, inherit: 1, freq: 1, sample_id_all: 1
  dummy:u: type: 1 (PERF_TYPE_SOFTWARE), size: 136, config: 0x9 (PERF_COUNT_SW_DUMMY), { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|ADDR|CPU|IDENTIFIER|DATA_SRC|WEIGHT, read_format: ID, inherit: 1, exclude_kernel: 1, exclude_hv: 1, mmap: 1, comm: 1, task: 1, mmap_data: 1, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1
  #
  # perf report -s type,typeoff --hierarchy --group --stdio
  # Total Lost Samples: 0
  #
  # Samples: 2K of events 'ibs_op//, dummy:u'
  # Event count (approx.): 1904553038
  #
  #            Overhead  Data Type / Data Type Offset
  # ...................  ............................
  #
      73.70%   0.00%     (unknown)
         73.70%   0.00%     (unknown) +0 (no field)
       3.01%   0.00%     long unsigned int
          3.00%   0.00%     long unsigned int +0 (no field)
          0.01%   0.00%     long unsigned int +2 (no field)
       2.73%   0.00%     struct task_struct
          1.71%   0.00%     struct task_struct +52 (on_cpu)
          0.38%   0.00%     struct task_struct +2104 (rcu_read_unlock_special.b.blocked)
          0.23%   0.00%     struct task_struct +2100 (rcu_read_lock_nesting)
          0.14%   0.00%     struct task_struct +2384 ()
          0.06%   0.00%     struct task_struct +3096 (signal)
          0.05%   0.00%     struct task_struct +3616 (cgroups)
          0.05%   0.00%     struct task_struct +2344 (active_mm)
          0.02%   0.00%     struct task_struct +46 (flags)
          0.02%   0.00%     struct task_struct +2096 (migration_disabled)
          0.01%   0.00%     struct task_struct +24 (__state)
          0.01%   0.00%     struct task_struct +3956 (mm_cid_active)
          0.01%   0.00%     struct task_struct +1048 (cpus_ptr)
          0.01%   0.00%     struct task_struct +184 (se.group_node.next)
          0.01%   0.00%     struct task_struct +20 (thread_info.cpu)
          0.00%   0.00%     struct task_struct +104 (on_rq)
          0.00%   0.00%     struct task_struct +2456 (pid)
       1.36%   0.00%     struct module
          0.59%   0.00%     struct module +952 (kallsyms)
          0.42%   0.00%     struct module +0 (state)
          0.23%   0.00%     struct module +8 (list.next)
          0.12%   0.00%     struct module +216 (syms)
       0.95%   0.00%     struct inode
          0.41%   0.00%     struct inode +40 (i_sb)
          0.22%   0.00%     struct inode +0 (i_mode)
          0.06%   0.00%     struct inode +76 (i_rdev)
          0.06%   0.00%     struct inode +56 (i_security)
  <SNIP>

perf top/report:

- Don't ignore job control, allowing control+Z + bg to work.

- Add s390 raw data interpretation for PAI (Processor Activity Instrumentation)
  counters.

perf archive:

- Add new option '--all' to pack perf.data with DSOs.

- Add new option '--unpack' to expand tarballs.

Initialization speedups:

- Lazily initialize zstd streams to save memory when not using it.

- Lazily allocate/size mmap event copy.

- Lazy load kernel symbols in 'perf record'.

- Be lazier in allocating lost samples buffer in 'perf record'.

- Don't synthesize BPF events when disabled via the command line (perf record --no-bpf-event).

Assorted improvements:

- Show note on AMD systems that the :p, :pp, :ppp and :P are all the same, as
  IBS (Instruction Based Sampling) is used and it is inherentely precise, not
  having levels of precision like in Intel systems.

- When 'cycles' isn't available, fall back to the "task-clock" event when not
  system wide, not to 'cpu-clock'.

- Add --debug-file option to redirect debug output, e.g.:

    $ perf --debug-file /tmp/perf.log record -v true

- Shrink 'struct map' to under one cacheline by avoiding function pointers for
  selecting if addresses are identity or DSO relative, and using just a byte for
  some boolean struct members.

- Resolve the arch specific strerrno just once to use in perf_env__arch_strerrno().

- Reduce memory for recording PERF_RECORD_LOST_SAMPLES event.

Assorted fixes:

- Fix the default 'perf top' usage on Intel hybrid systems, now it starts with
  a browser showing the number of samples for Efficiency (cpu_atom/cycles/P) and
  Performance (cpu_core/cycles/P). This behaviour is similar on ARM64, with its
  respective set of big.LITTLE processors.

- Fix segfault on build_mem_topology() error path.

- Fix 'perf mem' error on hybrid related to availability of mem event in a PMU.

- Fix missing reference count gets (map, maps) in the db-export code.

- Avoid recursively taking env->bpf_progs.lock in the 'perf_env' code.

- Use the newly introduced maps__for_each_map() to add missing locking around
  iteration of 'struct map' entries.

- Parse NOTE segments until the build id is found, don't stop on the first one,
  ELF files may have several such NOTE segments.

- Remove 'egrep' usage, its deprecated, use 'grep -E' instead.

- Warn first about missing libelf, not libbpf, that depends on libelf.

- Use alternative to 'find ... -printf' as this isn't supported in busybox.

- Address python 3.6 DeprecationWarning for string scapes.

- Fix memory leak in uniq() in libsubcmd.

- Fix man page formatting for 'perf lock'

- Fix some spelling mistakes.

perf tests:

- Fail shell tests that needs some symbol in perf itself if it is stripped.
  These tests check if a symbol is resolved, if some hot function is indeed
  detected by profiling, etc.

- The 'perf test sigtrap' test is currently failing on PREEMPT_RT, skip it if
  sleeping spinlocks are detected (using BTF) and point to the mailing list
  discussion about it. This test is also being skipped on several architectures
  (powerpc, s390x, arm and aarch64) due to other pending issues with intruction
  breakpoints.

- Adjust test case perf record offcpu profiling tests for s390.

- Fix 'Setup struct perf_event_attr' fails on s390 on z/VM guest, addressing
  issues caused by the fallback from cycles to task-clock done in this release.

- Fix mask for VG register in the user-regs test.

- Use shellcheck on 'perf test' shell scripts automatically to make sure changes
  don't introduce things it flags as problematic.

- Add option to change objdump binary and allow it to be set via 'perf config'.

- Add basic 'perf script', 'perf list --json" and 'perf diff' tests.

- Basic branch counter support.

- Make DSO tests a suite rather than individual.

- Remove atomics from test_loop to avoid test failures.

- Fix call chain match on powerpc for the record+probe_libc_inet_pton test.

- Improve Intel hybrid tests.

Vendor event files (JSON):

powerpc:

- Update datasource event name to fix duplicate events on IBM's Power10.

- Add PVN for HX-C2000 CPU with Power8 Architecture.

Intel:

- Alderlake/rocketlake metric fixes.

- Update emeraldrapids events to v1.02.

- Update icelakex events to v1.23.

- Update sapphirerapids events to v1.17.

- Add skx, clx, icx and spr upi bandwidth metric.

AMD:

- Add Zen 4 memory controller events.

RISC-V:

- Add StarFive Dubhe-80 and Dubhe-90 JSON files.
  https://www.starfivetech.com/en/site/cpu-u

- Add T-HEAD C9xx JSON file.
  https://github.com/riscv-software-src/opensbi/blob/master/docs/platform/thead-c9xx.md

ARM64:

- Remove UTF-8 characters from cmn.json, that were causing build failure in some
  distros.

- Add core PMU events and metrics for Ampere One X.

- Rename Ampere One's BPU_FLUSH_MEM_FAULT to GPC_FLUSH_MEM_FAULT

libperf:

- Rename several perf_cpu_map constructor names to clarify what they really do.

- Ditto for some other methods, coping with some issues in their semantics,
  like perf_cpu_map__empty() -> perf_cpu_map__has_any_cpu_or_is_empty().

- Document perf_cpu_map__nr()'s behavior

perf stat:

- Exit if parse groups fails.

- Combine the -A/--no-aggr and --no-merge options.

- Fix help message for --metric-no-threshold option.

Hardware tracing:

ARM64 CoreSight:

- Bump minimum OpenCSD version to ensure a bugfix is present.

- Add 'T' itrace option for timestamp trace

- Set start vm addr of exectable file to 0 and don't ignore first sample on the
  arm-cs-trace-disasm.py 'perf script'.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (8):
      perf header: Fix segfault on build_mem_topology() error path
      perf tests lib: Add perf_has_symbol.sh
      perf tests: Skip pipe test if noploop symbol is missing
      perf tests: Skip record test if test_loop symbol is missing
      perf tests: Skip Arm64 callgraphs test if leafloop symbol is missing
      perf tests: Skip branch stack sampling test if brstack_bench symbol is missing
      perf tests: Make data symbol test wait for perf to start
      perf tests: Skip data symbol test if buf1 symbol is missing

Ahelenia Ziemiańska (1):
      perf TUI: Don't ignore job control

Arnaldo Carvalho de Melo (14):
      perf beauty socket/prctl_option: Cope with extended regexp complaint by grep
      perf tests make: Remove the last egrep call, use 'grep -E' instead
      perf build: Warn about missing libelf before warning about missing libbpf
      tools: Disable __packed attribute compiler warning due to -Werror=attributes
      perf header: Additional note on AMD IBS for max_precise pmu cap
      perf test sigtrap: Generalize the BTF routine to reuse it in this test
      perf tests sigtrap: Skip if running on a kernel with sleepable spinlocks
      libapi: Add missing linux/types.h header to get the __u64 type on io.h
      perf beauty: Don't use 'find ... -printf' as it isn't available in busybox
      perf env: Introduce perf_env__arch_strerrno()
      perf env: Cache the arch specific strerrno function in perf_env__arch_strerrno()
      perf evlist: Move event attributes to after the / when uniquefying using the PMU name
      Merge remote-tracking branch 'torvalds/master' into perf-tools-next
      MAINTAINERS: Add Namhyung as tools/perf/ co-maintainer

Athira Rajeev (2):
      perf tools: Add perf binary dependent rule for shellcheck log in Makefile.perf
      perf vendor events powerpc: Update datasource event name to fix duplicate events

Ben Gainey (1):
      perf db-export: Fix missing reference count get in call_path_from_sample()

Benjamin Gray (1):
      perf tools: Address python 3.6 DeprecationWarning for string scapes

Chengen Du (1):
      perf symbols: Parse NOTE segments until the build id is found

Colin Ian King (2):
      perf tools: Fix spelling mistake "parametrized" -> "parameterized"
      perf bench sched-seccomp-notify: Fix spelling mistake "synchronious" -> "synchronous"

Ian Rogers (63):
      perf record: Lazy load kernel symbols
      perf machine thread: Remove exited threads by default
      perf bpf: Don't synthesize BPF events when disabled
      perf parse-events: Make legacy events lower priority than sysfs/JSON
      perf vendor events: Add skx, clx, icx and spr upi bandwidth metric
      perf mmap: Lazily initialize zstd streams to save memory when not using it
      libperf: Lazily allocate/size mmap event copy
      tools api fs: Switch filename__read_str to use io.h
      tools api fs: Avoid reading whole file for a 1 byte bool
      perf build: Shellcheck support for OUTPUT directory
      perf test: Use common python setup library
      perf test: Add basic 'perf list --json" test
      perf test: Add basic 'perf diff' test
      perf evsel: Fallback to "task-clock" when not system wide
      perf record: Be lazier in allocating lost samples buffer
      perf test shell diff: Skip test if test_loop symbol is missing in the perf binary
      perf map: Simplify map_ip/unmap_ip and make 'struct map' smaller
      perf maps: Move symbol maps functions to maps.c
      perf thread: Add missing RC_CHK_EQUAL
      perf stat: Exit perf stat if parse groups fails
      perf stat: Fix help message for --metric-no-threshold option
      libperf cpumap: Rename perf_cpu_map__dummy_new() to perf_cpu_map__new_any_cpu()
      libperf cpumap: Rename perf_cpu_map__default_new() to perf_cpu_map__new_online_cpus() and prefer sysfs
      libperf cpumap: Rename perf_cpu_map__empty() to perf_cpu_map__has_any_cpu_or_is_empty()
      libperf cpumap: Replace usage of perf_cpu_map__new(NULL) with perf_cpu_map__new_online_cpus()
      libperf cpumap: Add for_each_cpu() that skips the "any CPU" case
      perf stat: Combine the -A/--no-aggr and --no-merge options
      perf tests: Make DSO tests a suite rather than individual
      perf top: Avoid repeated function calls to perf_cpu_map__nr().
      libperf cpumap: Document perf_cpu_map__nr()'s behavior
      perf map: Improve map/unmap parameter names
      perf maps: Add maps__for_each_map to iterate maps holding the lock
      perf events x86: Use function to add missing lock
      perf report: Use function to add missing maps lock
      perf tests: Use function to add missing maps lock
      perf machine: Use function to add missing maps lock
      perf probe-event: Use function to add missing maps lock
      perf symbol: Use function to add missing maps lock
      perf synthetic-events: Use function to add missing maps lock
      perf thread: Use function to add missing maps lock
      perf unwind: Use function to add missing maps lock
      perf vdso: Use function to add missing maps lock
      perf maps: Reduce scope of maps__for_each_entry()
      perf maps: Add remove maps function to remove a map based on callback
      perf debug: Expose debug file
      perf maps: Refactor maps__fixup_overlappings()
      perf maps: Do simple merge if given map doesn't overlap
      perf maps: Rename clone to copy from
      perf maps: Add maps__load_first()
      perf maps: Add find next entry to give entry after the given map
      perf maps: Reduce scope of map_rb_node and maps internals
      perf maps: Fix up overlaps during fixup_end
      perf env: Avoid recursively taking env->bpf_progs.lock
      perf record: Reduce memory for recording PERF_RECORD_LOST_SAMPLES event
      perf stat: Fix hard coded LL miss units
      perf x86 test: Update hybrid expectations
      perf x86 test: Add hybrid test for conflicting legacy/sysfs event
      perf vendor events intel: Alderlake/rocketlake metric fixes
      perf vendor events intel: Update emeraldrapids events to v1.02
      perf vendor events intel: Update icelakex events to v1.23
      perf vendor events intel: Update sapphirerapids events to v1.17
      libsubcmd: Fix memory leak in uniq()
      perf tests: Add perf script test

Ilkka Koskinen (2):
      perf vendor events arm64 AmpereOne: Rename BPU_FLUSH_MEM_FAULT to GPC_FLUSH_MEM_FAULT
      perf vendor events arm64 AmpereOneX: Add core PMU events and metrics

Inochi Amaoto (1):
      perf vendor events riscv: add T-HEAD C9xx JSON file

James Clark (4):
      perf test: Add option to change objdump binary
      perf test: Add support for setting objdump binary via perf config
      perf cs-etm: Bump minimum OpenCSD version to ensure a bugfix is present
      perf test: Use existing config value for objdump path

Ji Sheng Teoh (2):
      perf vendor events riscv: Add StarFive Dubhe-80 JSON file
      perf vendor events riscv: Add StarFive Dubhe-90 JSON file

JiaLong.Yang (1):
      perf vendor events powerpc: Add PVN for HX-C2000 CPU with Power8 Architecture

Jing Zhang (1):
      perf vendor events: Remove UTF-8 characters from cmn.json

Kan Liang (7):
      tools headers UAPI: Sync include/uapi/linux/perf_event.h header with the kernel
      perf header: Support num and width of branch counters
      perf tools: Add branch counter knob
      perf test: Basic branch counter support
      perf mem: Fix error on hybrid related to availability of mem event in a PMU
      perf top: Use evsel's cpus to replace user_requested_cpus
      perf top: Uniform the event name for the hybrid machine

Leo Yan (2):
      perf auxtrace: Add 'T' itrace option for timestamp trace
      perf cs-etm: Enable itrace option 'T'

Likhitha Korrapati (1):
      perf test record+probe_libc_inet_pton: Fix call chain match on powerpc

Namhyung Kim (45):
      perf test: Simplify "object code reading" test
      perf annotate: Split branch stack cycles information out of 'struct annotation_line'
      perf annotate: Split branch stack cycles info from 'struct annotation'
      perf annotate: Move max_coverage from 'struct annotation' to 'struct annotated_branch'
      perf annotate: Move some source code related fields from 'struct annotation' to 'struct annotated_source'
      perf annotate: Move offsets array from 'struct annotation' to 'struct annotated_source'
      perf annotate: Pass "-l" option to objdump conditionally
      perf annotate: Move raw_comment and raw_func_start fields out of 'struct ins_operands'
      perf tools: Add util/debuginfo.[ch] files
      perf dwarf-aux: Fix die_get_typename() for void *
      perf dwarf-aux: Move #else block of #ifdef HAVE_DWARF_GETLOCATIONS_SUPPORT code to the header file
      perf dwarf-aux: Add die_get_scopes() alternative to dwarf_getscopes()
      perf dwarf-aux: Add die_find_variable_by_reg() helper
      perf build: Add feature check for dwarf_getcfi()
      perf probe: Convert to check dwarf_getcfi feature
      perf annotate: Check if operand has multiple regs
      perf dwarf-aux: Add die_find_variable_by_addr()
      perf annotate: Introduce global annotation_options
      perf report: Convert to the global annotation_options
      perf top: Convert to the global annotation_options
      perf annotate: Use global annotation_options
      perf ui/browser/annotate: Use global annotation_options
      perf annotate: Ensure init/exit for global options
      perf annotate: Remove remaining usages of local annotation options
      perf annotate: Get rid of local annotation options
      perf genelf: Set ELF program header addresses properly
      perf unwind-libdw: Handle JIT-generated DSOs properly
      perf unwind-libunwind: Fix base address for .eh_frame
      perf dwarf-aux: Factor out die_get_typename_from_type()
      perf dwarf-regs: Add get_dwarf_regnum()
      perf annotate-data: Add find_data_type() to get type from memory access
      perf annotate-data: Add dso->data_types tree
      perf annotate: Factor out evsel__get_arch()
      perf annotate: Add annotate_get_insn_location()
      perf annotate: Implement hist_entry__get_data_type()
      perf report: Add 'type' sort key
      perf report: Support data type profiling
      perf annotate-data: Add member field in the data type
      perf annotate-data: Update sample histogram for type
      perf report: Add 'typeoff' sort key
      perf report: Add 'symoff' sort key
      perf annotate: Add --data-type option
      perf annotate: Support event group display
      perf annotate: Add --type-stat option for debugging
      perf annotate: Add --insn-stat option for debugging

Nick Forrington (2):
      perf test: Remove atomics from test_loop to avoid test failures
      perf docs: Fix man page formatting for 'perf lock'

Paran Lee (1):
      perf script python: Fail check on dynamic allocation

Ruidong Tian (2):
      perf scripts python arm-cs-trace-disasm.py: Set start vm addr of exectable file to 0
      perf scripts python arm-cs-trace-disasm.py: Do not ignore disam first sample

Sandipan Das (1):
      perf vendor events amd: Add Zen 4 memory controller events

Thomas Richter (4):
      perf tests offcpu: Adjust test case perf record offcpu profiling tests for s390
      perf report: Add s390 raw data interpretation for PAI counters
      perf report: Remove warning on missing raw data for s390
      perf test: test case 'Setup struct perf_event_attr' fails on s390 on z/vm

Veronika Molnarova (3):
      perf test record user-regs: Fix mask for vg register
      perf archive: Add new option '--all' to pack perf.data with DSOs
      perf archive: Add new option '--unpack' to expand tarballs

Yang Jihong (2):
      perf tools: Add the python_ext_build directory to .gitignore
      perf tools: Add --debug-file option to redirect debug output

Yicong Yang (2):
      perf header: Fix one memory leakage in perf_event__fprintf_event_update()
      perf hisi-ptt: Fix one memory leakage in hisi_ptt_process_auxtrace_event()

zhaimingbing (3):
      perf tests attr: Fix spelling mistake "whic" to "which"
      perf script perl: Fail check on dynamic allocation
      perf lock: Fix a memory leak on an error path

zhujun2 (1):
      perf tests coresight: Remove unused variables

 MAINTAINERS                                        |   2 +-
 tools/build/Makefile.feature                       |   1 +
 tools/build/feature/Makefile                       |   4 +
 tools/build/feature/test-dwarf_getcfi.c            |   9 +
 tools/build/feature/test-libopencsd.c              |   4 +-
 tools/include/uapi/linux/perf_event.h              |  13 +
 tools/lib/api/fs/fs.c                              |  80 +--
 tools/lib/api/io.h                                 |  12 +-
 tools/lib/perf/Documentation/examples/sampling.c   |   2 +-
 tools/lib/perf/Documentation/libperf-sampling.txt  |   2 +-
 tools/lib/perf/Documentation/libperf.txt           |   4 +-
 tools/lib/perf/cpumap.c                            |  65 +-
 tools/lib/perf/evlist.c                            |   6 +-
 tools/lib/perf/evsel.c                             |   2 +-
 tools/lib/perf/include/internal/mmap.h             |   3 +-
 tools/lib/perf/include/perf/cpumap.h               |  40 +-
 tools/lib/perf/libperf.map                         |   6 +-
 tools/lib/perf/mmap.c                              |  20 +-
 tools/lib/perf/tests/test-cpumap.c                 |   4 +-
 tools/lib/perf/tests/test-evlist.c                 |   6 +-
 tools/lib/perf/tests/test-evsel.c                  |   2 +-
 tools/lib/subcmd/help.c                            |  18 +-
 tools/perf/.gitignore                              |   4 +
 tools/perf/Documentation/itrace.txt                |   1 +
 tools/perf/Documentation/perf-annotate.txt         |  11 +
 tools/perf/Documentation/perf-config.txt           |   4 +-
 tools/perf/Documentation/perf-list.txt             |  12 +-
 tools/perf/Documentation/perf-lock.txt             |   2 +-
 tools/perf/Documentation/perf-record.txt           |   4 +
 tools/perf/Documentation/perf-report.txt           |   3 +
 tools/perf/Documentation/perf-stat.txt             |  52 +-
 tools/perf/Documentation/perf.txt                  |   3 +
 tools/perf/Makefile.config                         |  13 +-
 tools/perf/Makefile.perf                           |  13 +-
 tools/perf/arch/arm/util/cs-etm.c                  |  16 +-
 tools/perf/arch/arm64/util/arm-spe.c               |   4 +-
 tools/perf/arch/arm64/util/header.c                |   2 +-
 tools/perf/arch/loongarch/annotate/instructions.c  |   6 +-
 tools/perf/arch/x86/tests/hybrid.c                 |  37 +-
 tools/perf/arch/x86/util/dwarf-regs.c              |  38 ++
 tools/perf/arch/x86/util/event.c                   | 103 +--
 tools/perf/arch/x86/util/intel-bts.c               |   4 +-
 tools/perf/arch/x86/util/intel-pt.c                |  10 +-
 tools/perf/bench/epoll-ctl.c                       |   2 +-
 tools/perf/bench/epoll-wait.c                      |   2 +-
 tools/perf/bench/futex-hash.c                      |   2 +-
 tools/perf/bench/futex-lock-pi.c                   |   2 +-
 tools/perf/bench/futex-requeue.c                   |   2 +-
 tools/perf/bench/futex-wake-parallel.c             |   2 +-
 tools/perf/bench/futex-wake.c                      |   2 +-
 tools/perf/bench/sched-seccomp-notify.c            |   2 +-
 tools/perf/builtin-annotate.c                      | 300 ++++++++-
 tools/perf/builtin-c2c.c                           |   2 +-
 tools/perf/builtin-ftrace.c                        |   2 +-
 tools/perf/builtin-inject.c                        |   6 +
 tools/perf/builtin-lock.c                          |   4 +-
 tools/perf/builtin-record.c                        |  93 ++-
 tools/perf/builtin-report.c                        | 113 ++--
 tools/perf/builtin-stat.c                          |  33 +-
 tools/perf/builtin-top.c                           |  52 +-
 tools/perf/builtin-trace.c                         |   6 +-
 tools/perf/perf-archive.sh                         |  86 ++-
 tools/perf/perf.c                                  |  30 +
 .../arch/arm64/ampere/ampereone/core-imp-def.json  |   2 +-
 .../arch/arm64/ampere/ampereonex/branch.json       | 125 ++++
 .../arch/arm64/ampere/ampereonex/bus.json          |  20 +
 .../arch/arm64/ampere/ampereonex/cache.json        | 206 ++++++
 .../arch/arm64/ampere/ampereonex/core-imp-def.json | 464 ++++++++++++++
 .../arch/arm64/ampere/ampereonex/exception.json    |  47 ++
 .../arch/arm64/ampere/ampereonex/instruction.json  | 128 ++++
 .../arch/arm64/ampere/ampereonex/intrinsic.json    |  14 +
 .../arch/arm64/ampere/ampereonex/memory.json       |  41 ++
 .../arch/arm64/ampere/ampereonex/metrics.json      | 442 +++++++++++++
 .../arch/arm64/ampere/ampereonex/mmu.json          | 170 +++++
 .../arch/arm64/ampere/ampereonex/pipeline.json     |  41 ++
 .../arch/arm64/ampere/ampereonex/spe.json          |  14 +
 .../pmu-events/arch/arm64/arm/cmn/sys/cmn.json     |   2 +-
 tools/perf/pmu-events/arch/arm64/mapfile.csv       |   1 +
 tools/perf/pmu-events/arch/powerpc/mapfile.csv     |   3 +-
 .../arch/powerpc/power10/datasource.json           |  18 +-
 tools/perf/pmu-events/arch/riscv/mapfile.csv       |   2 +
 .../arch/riscv/starfive/dubhe-80/common.json       | 172 ++++++
 .../arch/riscv/starfive/dubhe-80/firmware.json     |  68 ++
 .../arch/riscv/thead/c900-legacy/cache.json        |  67 ++
 .../arch/riscv/thead/c900-legacy/firmware.json     |  68 ++
 .../arch/riscv/thead/c900-legacy/instruction.json  |  72 +++
 .../arch/riscv/thead/c900-legacy/microarch.json    |  80 +++
 .../pmu-events/arch/x86/alderlake/adl-metrics.json |  15 +-
 .../arch/x86/amdzen4/memory-controller.json        | 101 +++
 .../pmu-events/arch/x86/amdzen4/recommended.json   |  84 +++
 .../arch/x86/cascadelakex/clx-metrics.json         |   6 +
 .../arch/x86/emeraldrapids/floating-point.json     |  27 +-
 .../arch/x86/emeraldrapids/pipeline.json           |  18 +-
 .../x86/emeraldrapids/uncore-interconnect.json     |   8 +-
 .../arch/x86/emeraldrapids/uncore-io.json          |  30 +
 .../pmu-events/arch/x86/icelakex/icx-metrics.json  |   6 +
 tools/perf/pmu-events/arch/x86/icelakex/other.json |   2 +-
 .../pmu-events/arch/x86/icelakex/pipeline.json     |   2 +-
 .../arch/x86/icelakex/uncore-interconnect.json     |   6 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv         |   6 +-
 .../arch/x86/rocketlake/rkl-metrics.json           |   2 +-
 .../arch/x86/sapphirerapids/floating-point.json    |  27 +-
 .../arch/x86/sapphirerapids/pipeline.json          |   2 +-
 .../arch/x86/sapphirerapids/spr-metrics.json       |   6 +
 .../x86/sapphirerapids/uncore-interconnect.json    |   8 +-
 .../arch/x86/sapphirerapids/uncore-io.json         |  30 +
 .../pmu-events/arch/x86/skylakex/skx-metrics.json  |   6 +
 tools/perf/pmu-events/jevents.py                   |   4 +-
 tools/perf/scripts/python/arm-cs-trace-disasm.py   |  30 +-
 tools/perf/scripts/python/compaction-times.py      |   2 +-
 tools/perf/scripts/python/exported-sql-viewer.py   |   4 +-
 tools/perf/tests/Build                             |  14 +
 tools/perf/tests/attr.c                            |   2 +-
 tools/perf/tests/attr/base-record                  |   2 +-
 .../attr/test-record-user-regs-no-sve-aarch64      |   2 +-
 .../tests/attr/test-record-user-regs-sve-aarch64   |   2 +-
 tools/perf/tests/builtin-test.c                    |  17 +-
 tools/perf/tests/code-reading.c                    |  80 +--
 tools/perf/tests/cpumap.c                          |   2 +-
 tools/perf/tests/dso-data.c                        |  15 +-
 tools/perf/tests/keep-tracking.c                   |   2 +-
 tools/perf/tests/make                              |   2 +-
 tools/perf/tests/maps.c                            |  61 +-
 tools/perf/tests/mmap-basic.c                      |   2 +-
 tools/perf/tests/openat-syscall-all-cpus.c         |   2 +-
 tools/perf/tests/parse-events.c                    | 260 +++++---
 tools/perf/tests/perf-time-to-tsc.c                |   2 +-
 .../shell/coresight/memcpy_thread/memcpy_thread.c  |   1 -
 .../shell/coresight/thread_loop/thread_loop.c      |   1 -
 .../unroll_loop_thread/unroll_loop_thread.c        |   1 -
 tools/perf/tests/shell/diff.sh                     | 108 ++++
 tools/perf/tests/shell/lib/perf_has_symbol.sh      |  21 +
 tools/perf/tests/shell/lib/setup_python.sh         |  16 +
 tools/perf/tests/shell/list.sh                     |  19 +
 tools/perf/tests/shell/pipe_test.sh                |   9 +-
 .../tests/shell/record+probe_libc_inet_pton.sh     |   5 +-
 tools/perf/tests/shell/record.sh                   |  38 +-
 tools/perf/tests/shell/record_offcpu.sh            |   4 +-
 tools/perf/tests/shell/script.sh                   |  66 ++
 tools/perf/tests/shell/stat+json_output.sh         |  16 +-
 tools/perf/tests/shell/stat_all_pmu.sh             |   2 +-
 tools/perf/tests/shell/stat_metrics_values.sh      |  14 +-
 tools/perf/tests/shell/test_arm_callgraph_fp.sh    |   6 +
 tools/perf/tests/shell/test_brstack.sh             |   6 +
 tools/perf/tests/shell/test_data_symbol.sh         |  16 +-
 .../tests/shell/test_perf_data_converter_json.sh   |  13 +-
 tools/perf/tests/sigtrap.c                         | 106 +++-
 tools/perf/tests/sw-clock.c                        |   2 +-
 tools/perf/tests/switch-tracking.c                 |   2 +-
 tools/perf/tests/task-exit.c                       |   2 +-
 tools/perf/tests/tests.h                           |   1 +
 tools/perf/tests/topology.c                        |   2 +-
 tools/perf/tests/vmlinux-kallsyms.c                | 181 +++---
 tools/perf/tests/workloads/thloop.c                |   4 +-
 tools/perf/trace/beauty/arch_errno_names.sh        |  10 +-
 tools/perf/trace/beauty/beauty.h                   |   2 -
 tools/perf/trace/beauty/prctl_option.sh            |   4 +-
 tools/perf/trace/beauty/socket.sh                  |   4 +-
 tools/perf/ui/browsers/annotate.c                  | 104 ++--
 tools/perf/ui/browsers/hists.c                     |  36 +-
 tools/perf/ui/browsers/hists.h                     |   2 -
 tools/perf/ui/browsers/scripts.c                   |   1 +
 tools/perf/ui/gtk/annotate.c                       |   6 +-
 tools/perf/ui/gtk/gtk.h                            |   2 -
 tools/perf/ui/tui/setup.c                          |  22 +
 tools/perf/util/Build                              |   2 +
 tools/perf/util/annotate-data.c                    | 405 ++++++++++++
 tools/perf/util/annotate-data.h                    | 143 +++++
 tools/perf/util/annotate.c                         | 687 ++++++++++++++++-----
 tools/perf/util/annotate.h                         | 144 +++--
 tools/perf/util/auxtrace.c                         |   7 +-
 tools/perf/util/auxtrace.h                         |   3 +
 tools/perf/util/block-info.c                       |  10 +-
 tools/perf/util/block-info.h                       |   3 +-
 tools/perf/util/block-range.c                      |   7 +-
 tools/perf/util/bpf-event.c                        |  11 +-
 tools/perf/util/bpf-event.h                        |  12 +-
 tools/perf/util/bpf_counter.c                      |   2 +-
 tools/perf/util/bpf_lock_contention.c              |   2 +-
 tools/perf/util/compress.h                         |   7 +-
 tools/perf/util/cpumap.c                           |   2 +-
 tools/perf/util/cputopo.c                          |   2 +-
 tools/perf/util/cs-etm.c                           |  21 +-
 tools/perf/util/db-export.c                        |   4 +-
 tools/perf/util/debug.c                            |  22 +-
 tools/perf/util/debug.h                            |   1 +
 tools/perf/util/debuginfo.c                        | 205 ++++++
 tools/perf/util/debuginfo.h                        |  64 ++
 tools/perf/util/dso.c                              |   4 +
 tools/perf/util/dso.h                              |   2 +
 tools/perf/util/dwarf-aux.c                        | 249 +++++++-
 tools/perf/util/dwarf-aux.h                        |  51 +-
 tools/perf/util/dwarf-regs.c                       |  34 +
 tools/perf/util/env.c                              |  82 ++-
 tools/perf/util/env.h                              |  17 +
 tools/perf/util/event.c                            |   4 +-
 tools/perf/util/evlist.c                           |  34 +-
 tools/perf/util/evlist.h                           |   1 +
 tools/perf/util/evsel.c                            |  55 +-
 tools/perf/util/evsel.h                            |   4 +-
 tools/perf/util/genelf.c                           |   6 +-
 tools/perf/util/header.c                           |  43 +-
 tools/perf/util/hisi-ptt.c                         |   1 +
 tools/perf/util/hist.h                             |  28 +-
 tools/perf/util/include/dwarf-regs.h               |  19 +
 tools/perf/util/machine.c                          |  75 ++-
 tools/perf/util/map.c                              |  20 +-
 tools/perf/util/map.h                              |  83 +--
 tools/perf/util/maps.c                             | 528 +++++++++++++---
 tools/perf/util/maps.h                             |  48 +-
 tools/perf/util/mem-events.c                       |  25 +-
 tools/perf/util/mmap.c                             |   5 +-
 tools/perf/util/mmap.h                             |   1 -
 tools/perf/util/parse-branch-options.c             |   1 +
 tools/perf/util/parse-events.c                     |  52 +-
 tools/perf/util/perf_api_probe.c                   |   4 +-
 tools/perf/util/perf_event_attr_fprintf.c          |   1 +
 tools/perf/util/pmu.c                              |   8 +-
 tools/perf/util/pmu.h                              |   3 +-
 tools/perf/util/probe-event.c                      |  40 +-
 tools/perf/util/probe-finder.c                     | 201 +-----
 tools/perf/util/probe-finder.h                     |  19 +-
 tools/perf/util/record.c                           |   4 +-
 tools/perf/util/s390-cpumcf-kernel.h               |   2 +
 tools/perf/util/s390-sample-raw.c                  | 114 +++-
 tools/perf/util/sample.h                           |   1 +
 .../perf/util/scripting-engines/trace-event-perl.c |   3 +
 .../util/scripting-engines/trace-event-python.c    |  17 +-
 tools/perf/util/session.c                          |  20 +-
 tools/perf/util/sort.c                             | 216 ++++++-
 tools/perf/util/sort.h                             |   7 +
 tools/perf/util/stat-display.c                     |   2 +-
 tools/perf/util/stat-shadow.c                      |   2 +-
 tools/perf/util/stat.c                             |   4 +-
 tools/perf/util/stat.h                             |   1 -
 tools/perf/util/symbol-elf.c                       |   6 +-
 tools/perf/util/symbol-minimal.c                   |  10 +-
 tools/perf/util/symbol.c                           | 306 +--------
 tools/perf/util/symbol.h                           |   1 -
 tools/perf/util/symbol_conf.h                      |   6 +-
 tools/perf/util/synthetic-events.c                 | 118 ++--
 tools/perf/util/thread.c                           |  42 +-
 tools/perf/util/thread.h                           |  14 +
 tools/perf/util/top.c                              |   9 +-
 tools/perf/util/top.h                              |   1 -
 tools/perf/util/unwind-libdw.c                     |  21 +-
 tools/perf/util/unwind-libunwind-local.c           |  34 +-
 tools/perf/util/vdso.c                             |  35 +-
 tools/perf/util/zstd.c                             |  63 +-
 249 files changed, 7843 insertions(+), 2141 deletions(-)
 create mode 100644 tools/build/feature/test-dwarf_getcfi.c
 mode change 100644 => 100755 tools/perf/perf-archive.sh
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereonex/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereonex/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereonex/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereonex/core-imp-def.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereonex/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereonex/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereonex/intrinsic.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereonex/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereonex/mmu.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereonex/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereonex/spe.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/starfive/dubhe-80/common.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/starfive/dubhe-80/firmware.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/thead/c900-legacy/cache.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/thead/c900-legacy/firmware.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/thead/c900-legacy/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/thead/c900-legacy/microarch.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/memory-controller.json
 create mode 100755 tools/perf/tests/shell/diff.sh
 create mode 100644 tools/perf/tests/shell/lib/perf_has_symbol.sh
 create mode 100644 tools/perf/tests/shell/lib/setup_python.sh
 create mode 100755 tools/perf/tests/shell/list.sh
 create mode 100755 tools/perf/tests/shell/script.sh
 create mode 100644 tools/perf/util/annotate-data.c
 create mode 100644 tools/perf/util/annotate-data.h
 create mode 100644 tools/perf/util/debuginfo.c
 create mode 100644 tools/perf/util/debuginfo.h

