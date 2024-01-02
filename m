Return-Path: <linux-kernel+bounces-14571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB55F821EFB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 16:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E31D51C225A8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E81E14AAA;
	Tue,  2 Jan 2024 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hbO0gXR5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688E014A8A;
	Tue,  2 Jan 2024 15:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704210207; x=1735746207;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iTjbcBqWZsHpyuIiJWXNPkMaNtdMh4dG3Zx9FutWPw0=;
  b=hbO0gXR5b/f6Q7OgewH59A1JVHRDWvf6y1tdvxU8iLnyPOF1RqWZ/CZr
   tnbDB4HrDhyDRJhjt7KorwrqoXqnQ4ZnPKjtjESmMzRCa0r/QLdE7D9rk
   HB9Va9y64EpIVC0Z+8xRj0Bj+s3XsF4vtYrkmzWtfp8Plgh53cSEUED9n
   FB17aXgEn8XCXjn7kx0ECCAY/KZm9oCCFf7VlX4pWZXNWjUn55bcRQA76
   AoWVwxppn8f45ib3D+E0lfM9wsj9wH4881L8JAVYhB9nfCFg0OD0Jy5LY
   a+nLo99ebSf/mIcR0tQaCTioqlTVxMdOx2Qkv9fyNfXacUyr8E++HTa80
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="461195889"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="461195889"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 07:43:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="772871443"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="772871443"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 07:43:26 -0800
Received: from [10.212.82.180] (kliang2-mobl1.ccr.corp.intel.com [10.212.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 9D4A5580C28;
	Tue,  2 Jan 2024 07:43:25 -0800 (PST)
Message-ID: <4d86f3b6-eaee-4673-bdf5-3b97c1c1ad17@linux.intel.com>
Date: Tue, 2 Jan 2024 10:43:24 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: perf test hybrid failing on 14700K
Content-Language: en-US
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Kan Liang <kan.liang@intel.com>, Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <ZYbm5L7tw7bdpDpE@kernel.org>
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <ZYbm5L7tw7bdpDpE@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2023-12-23 8:55 a.m., Arnaldo Carvalho de Melo wrote:
> Hi Kan,
> 
> I noticed the following problem, are you able to reproduce it?
> 
> Happy solstice!

Happy new year!

> 
> - Arnaldo
> 
> root@number:/home/acme/Downloads# grep "model name" -m1 /proc/cpuinfo
> model name	: Intel(R) Core(TM) i7-14700K
> root@number:/home/acme/Downloads# uname -a
> Linux number 6.6.4-200.fc39.x86_64 #1 SMP PREEMPT_DYNAMIC Sun Dec  3 18:13:11 UTC 2023 x86_64 GNU/Linux
> root@number:/home/acme/Downloads# perf -vv
> perf version 6.7.rc6.g63daba4e2861
>                  dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
>     dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
>          syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
>                 libbfd: [ OFF ]  # HAVE_LIBBFD_SUPPORT
>             debuginfod: [ on  ]  # HAVE_DEBUGINFOD_SUPPORT
>                 libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
>                libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
> numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
>                libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
>              libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
>               libslang: [ on  ]  # HAVE_SLANG_SUPPORT
>              libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
>              libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
>     libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
>                   zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
>                   lzma: [ on  ]  # HAVE_LZMA_SUPPORT
>              get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
>                    bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
>                    aio: [ on  ]  # HAVE_AIO_SUPPORT
>                   zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
>                libpfm4: [ on  ]  # HAVE_LIBPFM
>          libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
>          bpf_skeletons: [ on  ]  # HAVE_BPF_SKEL
> root@number:/home/acme/Downloads# perf test 75
>  75: x86 hybrid                                                      : FAILED!

The failure should be a regression caused by the a24d9d9dc096 ("perf
parse-events: Make legacy events lower priority than sysfs/JSON")

@@ -1004,10 +1012,19 @@ static int config_term_pmu(struct
perf_event_attr *attr,
 							   err_str, /*help=*/NULL);
 			return -EINVAL;
 		}
-		attr->type = PERF_TYPE_HARDWARE;
-		attr->config = term->val.num;
-		if (perf_pmus__supports_extended_type())
-			attr->config |= (__u64)pmu->type << PERF_PMU_TYPE_SHIFT;
+		/*
+		 * If the PMU has a sysfs or json event prefer it over
+		 * legacy. ARM requires this.
+		 */
+		if (perf_pmu__have_event(pmu, term->config))
For Intel hybrid, the perf_pmu__have_event() should be always true for
all hw events and hw cache events. So the patch will mistakenly update
the type to TYPE_USER. However, On Intel platforms, the type of the hw
events should be TYPE_HARDWARE.

Seems ARM needs to find another way to distinguish the case.

Ian, any suggestions?

+			term->type_term = PARSE_EVENTS__TERM_TYPE_USER;
+			term->no_value = true;
+		} else {
+			attr->type = PERF_TYPE_HARDWARE;
+			attr->config = term->val.num;
+			if (perf_pmus__supports_extended_type())
+				attr->config |= (__u64)pmu->type << PERF_PMU_TYPE_SHIFT;
+		}
 		return 0;
 	}
 	if (term->type_term == PARSE_EVENTS__TERM_TYPE_USER ||


Thanks,
Kan
> root@number:/home/acme/Downloads# perf test -v 75
>  75: x86 hybrid                                                      :
> --- start ---
> test child forked, pid 4111587
> Using CPUID GenuineIntel-6-B7-1
> running test 0 'cpu_core/cpu-cycles/'
> FAILED arch/x86/tests/hybrid.c:30 wrong type
> Event test failure: test 0 'cpu_core/cpu-cycles/'running test 1 '{cpu_core/cpu-cycles/,cpu_core/instructions/}'
> FAILED arch/x86/tests/hybrid.c:42 wrong type
> Event test failure: test 1 '{cpu_core/cpu-cycles/,cpu_core/instructions/}'running test 2 '{cpu-clock,cpu_core/cpu-cycles/}'
> FAILED arch/x86/tests/hybrid.c:65 wrong type
> Event test failure: test 2 '{cpu-clock,cpu_core/cpu-cycles/}'running test 3 '{cpu_core/cpu-cycles/,cpu-clock}'
> FAILED arch/x86/tests/hybrid.c:78 wrong type
> Event test failure: test 3 '{cpu_core/cpu-cycles/,cpu-clock}'running test 4 '{cpu_core/cpu-cycles/k,cpu_core/instructions/u}'
> FAILED arch/x86/tests/hybrid.c:95 wrong type
> Event test failure: test 4 '{cpu_core/cpu-cycles/k,cpu_core/instructions/u}'running test 5 'r1a'
> running test 6 'cpu_core/r1a/'
> running test 7 'cpu_core/config=10,config1,config2=3,period=1000/u'
> WARNING: event 'N/A' not valid (bits 0-1 of config2 '3' not supported by kernel)!
> running test 8 'cpu_core/LLC-loads/'
> test child finished with -1
> ---- end ----
> x86 hybrid: FAILED!
> root@number:/home/acme/Downloads#
> 
> root@number:/home/acme/Downloads# perf trace -e perf_event_open perf test -F -v 75
>  75: x86 hybrid                                                      :
> --- start ---
> Using CPUID GenuineIntel-6-B7-1
> running test 0 'cpu_core/cpu-cycles/'
> FAILED arch/x86/tests/hybrid.c:30 wrong type
> Event test failure: test 0 'cpu_core/cpu-cycles/'running test 1 '{cpu_core/cpu-cycles/,cpu_core/instructions/}'
> FAILED arch/x86/tests/hybrid.c:42 wrong type
> Event test failure: test 1 '{cpu_core/cpu-cycles/,cpu_core/instructions/}'running test 2 '{cpu-clock,cpu_core/cpu-cycles/}'
> FAILED arch/x86/tests/hybrid.c:65 wrong type
> Event test failure: test 2 '{cpu-clock,cpu_core/cpu-cycles/}'running test 3 '{cpu_core/cpu-cycles/,cpu-clock}'
> FAILED arch/x86/tests/hybrid.c:78 wrong type
> Event test failure: test 3 '{cpu_core/cpu-cycles/,cpu-clock}'running test 4 '{cpu_core/cpu-cycles/k,cpu_core/instructions/u}'
> FAILED arch/x86/tests/hybrid.c:95 wrong type
> Event test failure: test 4 '{cpu_core/cpu-cycles/k,cpu_core/instructions/u}'running test 5 'r1a'
> running test 6 'cpu_core/r1a/'
> running test 7 'cpu_core/config=10,config1,config2=3,period=1000/u'
> WARNING: event 'N/A' not valid (bits 0-1 of config2 '3' not supported by kernel)!
> running test 8 'cpu_core/LLC-loads/'
> ---- end ----
> x86 hybrid: FAILED!
>      0.000 ( 0.008 ms): :4115165/4115165 perf_event_open(attr_uptr: { type: 0 (PERF_TYPE_HARDWARE), config: 0xa00000000, disabled: 1, { bp_len, config2 }: 0x900000000, branch_sample_type: USER|COUNTERS, sample_regs_user: 0x3ecaddffffffff, sample_stack_user: 4115165, clockid: 925535355, sample_regs_intr: 0x8140c90000a8f7, sample_max_stack: 8, sig_data: 120259084288 }, cpu: -1, group_fd: -1, flags: FD_CLOEXEC) = 3
>      0.010 ( 0.002 ms): :4115165/4115165 perf_event_open(attr_uptr: { type: 0 (PERF_TYPE_HARDWARE), config: 0x400000000, disabled: 1, { bp_len, config2 }: 0x900000000, branch_sample_type: USER|COUNTERS, sample_regs_user: 0x3ecaddffffffff, sample_stack_user: 4115165, clockid: 925538919, sample_regs_intr: 0x8140c90000a8f7, sample_max_stack: 8, sig_data: 120259084288 }, cpu: -1, group_fd: -1, flags: FD_CLOEXEC) = 4
> root@number:/home/acme/Downloads# strace -e perf_event_open perf test -F -v 75
>  75: x86 hybrid                                                      :
> --- start ---
> Using CPUID GenuineIntel-6-B7-1
> running test 0 'cpu_core/cpu-cycles/'
> FAILED arch/x86/tests/hybrid.c:30 wrong type
> Event test failure: test 0 'cpu_core/cpu-cycles/'running test 1 '{cpu_core/cpu-cycles/,cpu_core/instructions/}'
> FAILED arch/x86/tests/hybrid.c:42 wrong type
> Event test failure: test 1 '{cpu_core/cpu-cycles/,cpu_core/instructions/}'running test 2 '{cpu-clock,cpu_core/cpu-cycles/}'
> FAILED arch/x86/tests/hybrid.c:65 wrong type
> Event test failure: test 2 '{cpu-clock,cpu_core/cpu-cycles/}'running test 3 '{cpu_core/cpu-cycles/,cpu-clock}'
> FAILED arch/x86/tests/hybrid.c:78 wrong type
> Event test failure: test 3 '{cpu_core/cpu-cycles/,cpu-clock}'running test 4 '{cpu_core/cpu-cycles/k,cpu_core/instructions/u}'
> FAILED arch/x86/tests/hybrid.c:95 wrong type
> Event test failure: test 4 '{cpu_core/cpu-cycles/k,cpu_core/instructions/u}'running test 5 'r1a'
> running test 6 'cpu_core/r1a/'
> running test 7 'cpu_core/config=10,config1,config2=3,period=1000/u'
> WARNING: event 'N/A' not valid (bits 0-1 of config2 '3' not supported by kernel)!
> running test 8 'cpu_core/LLC-loads/'
> perf_event_open({type=PERF_TYPE_HARDWARE, size=0 /* PERF_ATTR_SIZE_??? */, config=0xa<<32|PERF_COUNT_HW_CPU_CYCLES, sample_period=0, sample_type=0, read_format=0, disabled=1, precise_ip=0 /* arbitrary skid */, ...}, 0, -1, -1, PERF_FLAG_FD_CLOEXEC) = 3
> perf_event_open({type=PERF_TYPE_HARDWARE, size=0 /* PERF_ATTR_SIZE_??? */, config=0x4<<32|PERF_COUNT_HW_CPU_CYCLES, sample_period=0, sample_type=0, read_format=0, disabled=1, precise_ip=0 /* arbitrary skid */, ...}, 0, -1, -1, PERF_FLAG_FD_CLOEXEC) = 4
> ---- end ----
> x86 hybrid: FAILED!
> +++ exited with 0 +++
> root@number:/home/acme/Downloads#
> 

