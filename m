Return-Path: <linux-kernel+bounces-15635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B98822F3E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD62E1F24372
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10811A29D;
	Wed,  3 Jan 2024 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BBvMapRx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7DF1A28F;
	Wed,  3 Jan 2024 14:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704291363; x=1735827363;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/yyUwLA7odtgB81d026qZSQDwkuDgWVHXDG0DGGa+i4=;
  b=BBvMapRxySXsAW6dc+l7kD2upqbjlQHE8Ak2yFgMIxAvleaTe2P4CA1y
   Urubp82xRAh52g8+M4vFStXaXn+ZoOS2Cgdzt8XBpK1Nk2Nbcx+EPGhtF
   sk0mxfA0z1Zfv66mljILEKLGlnDN9u+aSvd+xQfi7jSQMjc42xqJuUKAn
   LFCi9lNz+vRevWA5MRmn4rxjsYORcU3hBmPRe2oxFWmEExwZdBGWft6AF
   ovGfBf1/ie242IpZUZ/BHOyrZ0i+zJyglH+UD2ozXI2+nkmO3hr+x4+lf
   8ffQFSVDj4J28fg1TKGonrOdOAZp2vnIX1Yg2GIVa1fMdfsvLACTuO8ta
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="3814304"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="3814304"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 06:16:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="953238907"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="953238907"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 06:16:02 -0800
Received: from [10.213.174.222] (kliang2-mobl1.ccr.corp.intel.com [10.213.174.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 39C8F580B99;
	Wed,  3 Jan 2024 06:16:01 -0800 (PST)
Message-ID: <48f8d7ff-1ea4-45f1-af74-d4256a64bded@linux.intel.com>
Date: Wed, 3 Jan 2024 09:15:59 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: perf test hybrid failing on 14700K
To: Ian Rogers <irogers@google.com>, Mark Rutland <mark.rutland@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <ZYbm5L7tw7bdpDpE@kernel.org>
 <4d86f3b6-eaee-4673-bdf5-3b97c1c1ad17@linux.intel.com>
 <CAP-5=fUfJ-VBGS1D2+WM_eBu4uPGvxJ2KyD4WXzgKRCfGKHTQQ@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fUfJ-VBGS1D2+WM_eBu4uPGvxJ2KyD4WXzgKRCfGKHTQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-01-02 5:41 p.m., Ian Rogers wrote:
> On Tue, Jan 2, 2024 at 7:43 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2023-12-23 8:55 a.m., Arnaldo Carvalho de Melo wrote:
>>> Hi Kan,
>>>
>>> I noticed the following problem, are you able to reproduce it?
>>>
>>> Happy solstice!
>>
>> Happy new year!
>>
>>>
>>> - Arnaldo
>>>
>>> root@number:/home/acme/Downloads# grep "model name" -m1 /proc/cpuinfo
>>> model name    : Intel(R) Core(TM) i7-14700K
>>> root@number:/home/acme/Downloads# uname -a
>>> Linux number 6.6.4-200.fc39.x86_64 #1 SMP PREEMPT_DYNAMIC Sun Dec  3 18:13:11 UTC 2023 x86_64 GNU/Linux
>>> root@number:/home/acme/Downloads# perf -vv
>>> perf version 6.7.rc6.g63daba4e2861
>>>                  dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
>>>     dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
>>>          syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
>>>                 libbfd: [ OFF ]  # HAVE_LIBBFD_SUPPORT
>>>             debuginfod: [ on  ]  # HAVE_DEBUGINFOD_SUPPORT
>>>                 libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
>>>                libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
>>> numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
>>>                libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
>>>              libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
>>>               libslang: [ on  ]  # HAVE_SLANG_SUPPORT
>>>              libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
>>>              libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
>>>     libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
>>>                   zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
>>>                   lzma: [ on  ]  # HAVE_LZMA_SUPPORT
>>>              get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
>>>                    bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
>>>                    aio: [ on  ]  # HAVE_AIO_SUPPORT
>>>                   zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
>>>                libpfm4: [ on  ]  # HAVE_LIBPFM
>>>          libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
>>>          bpf_skeletons: [ on  ]  # HAVE_BPF_SKEL
>>> root@number:/home/acme/Downloads# perf test 75
>>>  75: x86 hybrid                                                      : FAILED!
>>
>> The failure should be a regression caused by the a24d9d9dc096 ("perf
>> parse-events: Make legacy events lower priority than sysfs/JSON")
>>
>> @@ -1004,10 +1012,19 @@ static int config_term_pmu(struct
>> perf_event_attr *attr,
>>                                                            err_str, /*help=*/NULL);
>>                         return -EINVAL;
>>                 }
>> -               attr->type = PERF_TYPE_HARDWARE;
>> -               attr->config = term->val.num;
>> -               if (perf_pmus__supports_extended_type())
>> -                       attr->config |= (__u64)pmu->type << PERF_PMU_TYPE_SHIFT;
>> +               /*
>> +                * If the PMU has a sysfs or json event prefer it over
>> +                * legacy. ARM requires this.
>> +                */
>> +               if (perf_pmu__have_event(pmu, term->config))
>> For Intel hybrid, the perf_pmu__have_event() should be always true for
>> all hw events and hw cache events. So the patch will mistakenly update
>> the type to TYPE_USER. However, On Intel platforms, the type of the hw
>> events should be TYPE_HARDWARE.
>>
>> Seems ARM needs to find another way to distinguish the case.
>>
>> Ian, any suggestions?
> 
> Hi Kan/Mark,
> 
> Firstly, the perf_pmu__have_event is a test of whether
> /sys/devices/<pmu>/events or the equivalent json events have the
> specified event string like "inst_retired.any" - ie it isn't a test of
> whether the event is supported by the kernel. Mark was quite insistent
> that the behavior be changed so that if a legacy event is specified
> with a PMU, the PMU's sysfs/json event is the priority which is a big
> behavior change on x86.
> 
> To get the test passing again I've sent out a test update:
> https://lore.kernel.org/lkml/20240102215732.1125997-1-irogers@google.com/
> This switches the legacy events in the test to ones which don't have
> sysfs or json equivalents. The test is somewhat brittle as an x86 PMU
> change could decide to add /sys/devices/cpu/events/cycles alongside
> /sys/devices/cpu/events/cpu-cycles. 

I think the cycles, cpu-cycles, and instructions are treated as
architectural events in both Linux and X86. I don't think there is a
plan to change the behavior of the architectural events.

> Ideally we'd be testing all events
> on core PMUs, for legacy events they may have a sysfs/json override
> and the test expectation should expect this and assert that the type
> isn't PERF_TYPE_HARDWARE, etc. For now what I sent out is sufficient
> to get the "x86 hybrid" test passing. 

Before the a24d9d9dc096, the "cpu-cycles" and the "cycles" are
identical. It should be fine to verify either of them.

But after the a24d9d9dc096, the code path is different. So maybe it's
better to verify both of the "cpu-cycles" and the "cycles" in the x86
hybrid test. Adding a new case something as below should be enough.

	{
		.name  = "{cpu_core/cpu-cycles/,cpu_core/cycles/}",
		.check = test__hybrid_hw_group_2_event,
	},

Thanks,
Kan

> I should probably have done the
> whole Reported-by.. thing, sorry for missing that.
> 
> Thanks,
> Ian
> 
>>
>> +                       term->type_term = PARSE_EVENTS__TERM_TYPE_USER;
>> +                       term->no_value = true;
>> +               } else {
>> +                       attr->type = PERF_TYPE_HARDWARE;
>> +                       attr->config = term->val.num;
>> +                       if (perf_pmus__supports_extended_type())
>> +                               attr->config |= (__u64)pmu->type << PERF_PMU_TYPE_SHIFT;
>> +               }
>>                 return 0;
>>         }
>>         if (term->type_term == PARSE_EVENTS__TERM_TYPE_USER ||
>>
>>
>> Thanks,
>> Kan
>>> root@number:/home/acme/Downloads# perf test -v 75
>>>  75: x86 hybrid                                                      :
>>> --- start ---
>>> test child forked, pid 4111587
>>> Using CPUID GenuineIntel-6-B7-1
>>> running test 0 'cpu_core/cpu-cycles/'
>>> FAILED arch/x86/tests/hybrid.c:30 wrong type
>>> Event test failure: test 0 'cpu_core/cpu-cycles/'running test 1 '{cpu_core/cpu-cycles/,cpu_core/instructions/}'
>>> FAILED arch/x86/tests/hybrid.c:42 wrong type
>>> Event test failure: test 1 '{cpu_core/cpu-cycles/,cpu_core/instructions/}'running test 2 '{cpu-clock,cpu_core/cpu-cycles/}'
>>> FAILED arch/x86/tests/hybrid.c:65 wrong type
>>> Event test failure: test 2 '{cpu-clock,cpu_core/cpu-cycles/}'running test 3 '{cpu_core/cpu-cycles/,cpu-clock}'
>>> FAILED arch/x86/tests/hybrid.c:78 wrong type
>>> Event test failure: test 3 '{cpu_core/cpu-cycles/,cpu-clock}'running test 4 '{cpu_core/cpu-cycles/k,cpu_core/instructions/u}'
>>> FAILED arch/x86/tests/hybrid.c:95 wrong type
>>> Event test failure: test 4 '{cpu_core/cpu-cycles/k,cpu_core/instructions/u}'running test 5 'r1a'
>>> running test 6 'cpu_core/r1a/'
>>> running test 7 'cpu_core/config=10,config1,config2=3,period=1000/u'
>>> WARNING: event 'N/A' not valid (bits 0-1 of config2 '3' not supported by kernel)!
>>> running test 8 'cpu_core/LLC-loads/'
>>> test child finished with -1
>>> ---- end ----
>>> x86 hybrid: FAILED!
>>> root@number:/home/acme/Downloads#
>>>
>>> root@number:/home/acme/Downloads# perf trace -e perf_event_open perf test -F -v 75
>>>  75: x86 hybrid                                                      :
>>> --- start ---
>>> Using CPUID GenuineIntel-6-B7-1
>>> running test 0 'cpu_core/cpu-cycles/'
>>> FAILED arch/x86/tests/hybrid.c:30 wrong type
>>> Event test failure: test 0 'cpu_core/cpu-cycles/'running test 1 '{cpu_core/cpu-cycles/,cpu_core/instructions/}'
>>> FAILED arch/x86/tests/hybrid.c:42 wrong type
>>> Event test failure: test 1 '{cpu_core/cpu-cycles/,cpu_core/instructions/}'running test 2 '{cpu-clock,cpu_core/cpu-cycles/}'
>>> FAILED arch/x86/tests/hybrid.c:65 wrong type
>>> Event test failure: test 2 '{cpu-clock,cpu_core/cpu-cycles/}'running test 3 '{cpu_core/cpu-cycles/,cpu-clock}'
>>> FAILED arch/x86/tests/hybrid.c:78 wrong type
>>> Event test failure: test 3 '{cpu_core/cpu-cycles/,cpu-clock}'running test 4 '{cpu_core/cpu-cycles/k,cpu_core/instructions/u}'
>>> FAILED arch/x86/tests/hybrid.c:95 wrong type
>>> Event test failure: test 4 '{cpu_core/cpu-cycles/k,cpu_core/instructions/u}'running test 5 'r1a'
>>> running test 6 'cpu_core/r1a/'
>>> running test 7 'cpu_core/config=10,config1,config2=3,period=1000/u'
>>> WARNING: event 'N/A' not valid (bits 0-1 of config2 '3' not supported by kernel)!
>>> running test 8 'cpu_core/LLC-loads/'
>>> ---- end ----
>>> x86 hybrid: FAILED!
>>>      0.000 ( 0.008 ms): :4115165/4115165 perf_event_open(attr_uptr: { type: 0 (PERF_TYPE_HARDWARE), config: 0xa00000000, disabled: 1, { bp_len, config2 }: 0x900000000, branch_sample_type: USER|COUNTERS, sample_regs_user: 0x3ecaddffffffff, sample_stack_user: 4115165, clockid: 925535355, sample_regs_intr: 0x8140c90000a8f7, sample_max_stack: 8, sig_data: 120259084288 }, cpu: -1, group_fd: -1, flags: FD_CLOEXEC) = 3
>>>      0.010 ( 0.002 ms): :4115165/4115165 perf_event_open(attr_uptr: { type: 0 (PERF_TYPE_HARDWARE), config: 0x400000000, disabled: 1, { bp_len, config2 }: 0x900000000, branch_sample_type: USER|COUNTERS, sample_regs_user: 0x3ecaddffffffff, sample_stack_user: 4115165, clockid: 925538919, sample_regs_intr: 0x8140c90000a8f7, sample_max_stack: 8, sig_data: 120259084288 }, cpu: -1, group_fd: -1, flags: FD_CLOEXEC) = 4
>>> root@number:/home/acme/Downloads# strace -e perf_event_open perf test -F -v 75
>>>  75: x86 hybrid                                                      :
>>> --- start ---
>>> Using CPUID GenuineIntel-6-B7-1
>>> running test 0 'cpu_core/cpu-cycles/'
>>> FAILED arch/x86/tests/hybrid.c:30 wrong type
>>> Event test failure: test 0 'cpu_core/cpu-cycles/'running test 1 '{cpu_core/cpu-cycles/,cpu_core/instructions/}'
>>> FAILED arch/x86/tests/hybrid.c:42 wrong type
>>> Event test failure: test 1 '{cpu_core/cpu-cycles/,cpu_core/instructions/}'running test 2 '{cpu-clock,cpu_core/cpu-cycles/}'
>>> FAILED arch/x86/tests/hybrid.c:65 wrong type
>>> Event test failure: test 2 '{cpu-clock,cpu_core/cpu-cycles/}'running test 3 '{cpu_core/cpu-cycles/,cpu-clock}'
>>> FAILED arch/x86/tests/hybrid.c:78 wrong type
>>> Event test failure: test 3 '{cpu_core/cpu-cycles/,cpu-clock}'running test 4 '{cpu_core/cpu-cycles/k,cpu_core/instructions/u}'
>>> FAILED arch/x86/tests/hybrid.c:95 wrong type
>>> Event test failure: test 4 '{cpu_core/cpu-cycles/k,cpu_core/instructions/u}'running test 5 'r1a'
>>> running test 6 'cpu_core/r1a/'
>>> running test 7 'cpu_core/config=10,config1,config2=3,period=1000/u'
>>> WARNING: event 'N/A' not valid (bits 0-1 of config2 '3' not supported by kernel)!
>>> running test 8 'cpu_core/LLC-loads/'
>>> perf_event_open({type=PERF_TYPE_HARDWARE, size=0 /* PERF_ATTR_SIZE_??? */, config=0xa<<32|PERF_COUNT_HW_CPU_CYCLES, sample_period=0, sample_type=0, read_format=0, disabled=1, precise_ip=0 /* arbitrary skid */, ...}, 0, -1, -1, PERF_FLAG_FD_CLOEXEC) = 3
>>> perf_event_open({type=PERF_TYPE_HARDWARE, size=0 /* PERF_ATTR_SIZE_??? */, config=0x4<<32|PERF_COUNT_HW_CPU_CYCLES, sample_period=0, sample_type=0, read_format=0, disabled=1, precise_ip=0 /* arbitrary skid */, ...}, 0, -1, -1, PERF_FLAG_FD_CLOEXEC) = 4
>>> ---- end ----
>>> x86 hybrid: FAILED!
>>> +++ exited with 0 +++
>>> root@number:/home/acme/Downloads#
>>>
> 

