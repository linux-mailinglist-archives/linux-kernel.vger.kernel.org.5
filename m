Return-Path: <linux-kernel+bounces-16741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DF1824326
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA526B20BF0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D413224C2;
	Thu,  4 Jan 2024 13:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E3wacNYo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5922F224CE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 13:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50e70d8273fso3026e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 05:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704376594; x=1704981394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8QhAuQF1o9HG3a+t42leGEwTqQIpH9CJuUOwbpgqK4=;
        b=E3wacNYoiABp5dc7j4s+uI7jzLXtvK4pO/kDkOlgpcdJ4H/n6ksjqnaNdqGpm5iV1A
         tJvlQYJ7M7JUiacmAk4Qauhj8lqxcBZVYXKZh5MyY51iy0LHNi7fu3H2S6YxtJKmy7U1
         LXDYvrHvsG/fRshMAmAJKdJOzCB1ut4aMuLAD0GTc8CqA0LR5RKRln/KV2qibbnKJF9i
         BVv+ApeG568PY8Mv8Pm7iubXTTJLSFnKF3LT5me22PUhryi+x9/s/lWLM0D9gdsIapYi
         s7h/H3WnWBeX+tnFVUAU1XzAUxI1f0D5k0Yw1yGtpWgFIW7f8u1FQ4qHQ+rj+Z5hZffQ
         4uGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704376594; x=1704981394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S8QhAuQF1o9HG3a+t42leGEwTqQIpH9CJuUOwbpgqK4=;
        b=n0uX+zyRlTf93q/nA5VxjOEV4cx/UlX+6fB1QBCOVf6V86yEDp4J8pocW8ve/zpABq
         B++3ecDxCJ8wkaKPMmXBXg5uxZSXQcPNSHhVHJoJdkksgcpOBn64hjPrnnEhMA9Q7smq
         DBmTwfQZpOrHFBgS1VDwUTzCA0MQq7WZyIlpcC9UvfZ96vjqj2IGUZz/lz5jWWtJuh4i
         6WXbQGXDl3J7aRMqzBH3EZoBkHnxybq0lcR4NFy+X8M1jt5m5QrDwcCRHPOt8hNRHJv7
         fojx2gQ9eSoLqOdntRpnXMcqlX6ZZtXEqk7MxCuwtczaIBlQws8thJUNKZJe6f7jaiS+
         x+Vg==
X-Gm-Message-State: AOJu0Yy9qI/u4J0NRQfGoOwdJVvpbz04m0H62P0/NBaMHYxW1p0Psz/n
	DYa1T2kGGXHf5nuBW4wrOGWBSnT+VYtr0jNoECuWuKCpvTtb
X-Google-Smtp-Source: AGHT+IFU5cliCisU55dY1K55YVYCUwSv11WLY6DOlEiH9Z9pE/2nuzVVxixJx8rPZdoxBarpDf3As4BXVedVwToEpyo=
X-Received: by 2002:a05:6512:2215:b0:50e:754c:84f5 with SMTP id
 h21-20020a056512221500b0050e754c84f5mr225813lfu.4.1704376593875; Thu, 04 Jan
 2024 05:56:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104074259.653219-1-irogers@google.com> <ZZam-EG-UepcXtWw@kernel.org>
In-Reply-To: <ZZam-EG-UepcXtWw@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 4 Jan 2024 05:56:22 -0800
Message-ID: <CAP-5=fV+U4qSwU8nqHJMgAZTwtWs9jEm3i9yDQSVtq9Fbos5HA@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] perf vendor events intel: Alderlake/rocketlake
 metric fixes
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 4:39=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> Em Wed, Jan 03, 2024 at 11:42:56PM -0800, Ian Rogers escreveu:
> > Fix that the core PMU is being specified for 2 uncore events. Specify
> > a PMU for the alderlake UNCORE_FREQ metric.
> >
> > Conversion script updated in:
> > https://github.com/intel/perfmon/pull/126
> >
> > Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Closes: https://lore.kernel.org/lkml/ZZWOdHXJJ_oecWwm@kernel.org/
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> After this first patch:
>
> 101: perf all metricgroups test                                      : Ok
> 102: perf all metrics test                                           : FA=
ILED!
> 107: perf metrics value validation                                   : Ok
>
> 102 is now failing due to some other problem:
>
> root@number:~# perf test -v 102
> 102: perf all metrics test                                           :
> --- start ---
> test child forked, pid 2701034
> Testing tma_core_bound
> Testing tma_info_core_ilp
> Testing tma_info_memory_l2mpki
> Testing tma_memory_bound
> Testing tma_info_bad_spec_branch_misprediction_cost
> Testing tma_info_bad_spec_ipmisp_cond_ntaken
> Testing tma_info_bad_spec_ipmisp_cond_taken
> Testing tma_info_bad_spec_ipmisp_indirect
> Testing tma_info_bad_spec_ipmisp_ret
> Testing tma_info_bad_spec_ipmispredict
> Testing tma_info_bottleneck_mispredictions
> Testing tma_info_branches_callret
> Testing tma_info_branches_cond_nt
> Testing tma_info_branches_cond_tk
> Testing tma_info_branches_jump
> Testing tma_info_branches_other_branches
> Testing tma_branch_mispredicts
> Testing tma_clears_resteers
> Testing tma_machine_clears
> Testing tma_mispredicts_resteers
> Testing tma_icache_misses
> Testing tma_info_bottleneck_big_code
> Testing tma_itlb_misses
> Testing tma_unknown_branches
> Testing tma_info_inst_mix_bptkbranch
> Testing tma_info_inst_mix_ipbranch
> Testing tma_info_inst_mix_ipcall
> Testing tma_info_inst_mix_iptb
> Testing tma_info_system_ipfarbranch
> Testing tma_info_thread_uptb
> Testing tma_info_memory_fb_hpki
> Testing tma_info_memory_l1mpki
> Testing tma_info_memory_l1mpki_load
> Testing tma_info_memory_l2hpki_all
> Testing tma_info_memory_l2hpki_load
> Testing tma_info_memory_l2mpki_all
> Testing tma_info_memory_l2mpki_load
> Testing tma_info_memory_l3mpki
> Testing tma_l1_bound
> Testing tma_l2_bound
> Testing tma_l3_bound
> Testing tma_fp_scalar
> Testing tma_fp_vector
> Testing tma_fp_vector_128b
> Testing tma_fp_vector_256b
> Testing tma_int_vector_128b
> Testing tma_int_vector_256b
> Testing tma_port_0
> Testing tma_x87_use
> Testing tma_info_botlnk_l0_core_bound_likely
> Testing tma_info_core_fp_arith_utilization
> Testing tma_info_pipeline_execute
> Testing tma_info_system_gflops
> Testing tma_info_thread_execute_per_issue
> Testing tma_dsb
> Testing tma_info_frontend_dsb_coverage
> Testing tma_decoder0_alone
> Testing tma_dsb_switches
> Testing tma_info_botlnk_l2_dsb_misses
> Testing tma_info_frontend_dsb_switch_cost
> Testing tma_info_frontend_ipdsb_miss_ret
> Testing tma_mite
> Testing tma_contested_accesses
> Testing tma_false_sharing
> Testing tma_backend_bound
> Testing tma_backend_bound_aux
> Testing tma_bad_speculation
> Testing tma_frontend_bound
> Testing tma_retiring
> Testing tma_info_botlnk_l2_ic_misses
> Testing tma_info_bottleneck_instruction_fetch_bw
> Testing tma_info_frontend_fetch_upc
> Testing tma_info_frontend_icache_miss_latency
> Testing tma_info_frontend_ipunknown_branch
> Testing tma_info_frontend_lsd_coverage
> Testing tma_info_memory_tlb_code_stlb_mpki
> Testing tma_fetch_bandwidth
> Testing tma_lsd
> Testing tma_branch_resteers
> Testing tma_lcp
> Testing tma_ms_switches
> Testing tma_info_core_flopc
> Testing tma_info_inst_mix_iparith
> Testing tma_info_inst_mix_iparith_avx128
> Testing tma_info_inst_mix_iparith_avx256
> Testing tma_info_inst_mix_iparith_scalar_dp
> Testing tma_info_inst_mix_iparith_scalar_sp
> Testing tma_info_inst_mix_ipflop
> Testing tma_fetch_latency
> Testing tma_avx_assists
> Testing tma_fp_arith
> Testing tma_fp_assists
> Testing tma_info_system_cpu_utilization
> Testing tma_info_system_dram_bw_use
> Testing tma_shuffles
> Testing tma_info_frontend_l2mpki_code
> Testing tma_info_frontend_l2mpki_code_all
> Testing tma_info_inst_mix_ipload
> Testing tma_info_inst_mix_ipstore
> Testing tma_info_bottleneck_memory_bandwidth
> Testing tma_info_bottleneck_memory_data_tlbs
> Testing tma_info_bottleneck_memory_latency
> Testing tma_info_memory_core_l1d_cache_fill_bw
> Testing tma_info_memory_core_l2_cache_fill_bw
> Testing tma_info_memory_core_l3_cache_access_bw
> Testing tma_info_memory_core_l3_cache_fill_bw
> Testing tma_info_memory_load_miss_real_latency
> Testing tma_info_memory_mlp
> Testing tma_info_memory_thread_l1d_cache_fill_bw_1t
> Testing tma_info_memory_thread_l2_cache_fill_bw_1t
> Testing tma_info_memory_thread_l3_cache_access_bw_1t
> Testing tma_info_memory_thread_l3_cache_fill_bw_1t
> Testing tma_info_memory_tlb_load_stlb_mpki
> Testing tma_info_memory_tlb_page_walks_utilization
> Testing tma_info_memory_tlb_store_stlb_mpki
> Testing tma_info_system_mem_parallel_reads
> Testing tma_info_system_mem_read_latency
> Testing tma_info_system_mem_request_latency
> Testing tma_info_thread_cpi
> Testing tma_fb_full
> Testing tma_mem_bandwidth
> Testing tma_sq_full
> Testing tma_streaming_stores
> Testing tma_dram_bound
> Testing tma_store_bound
> Testing tma_l3_hit_latency
> Testing tma_mem_latency
> Testing tma_store_latency
> Testing tma_dtlb_load
> Testing tma_dtlb_store
> Testing tma_load_stlb_hit
> Testing tma_load_stlb_miss
> Testing tma_store_stlb_hit
> Testing tma_store_stlb_miss
> Testing tma_info_memory_oro_data_l2_mlp
> Testing tma_info_memory_oro_load_l2_mlp
> Testing tma_info_memory_oro_load_l2_miss_latency
> Testing tma_info_memory_oro_load_l3_miss_latency
> Testing tma_microcode_sequencer
> Testing tma_info_core_clks
> Testing tma_info_core_clks_p
> Testing tma_info_core_cpi
> Testing tma_info_core_ipc
> Testing tma_info_core_slots
> Testing tma_info_core_upi
> Testing tma_info_frontend_inst_miss_cost_dramhit_percent
> Testing tma_info_frontend_inst_miss_cost_l2hit_percent
> Testing tma_info_frontend_inst_miss_cost_l3hit_percent
> Testing tma_info_inst_mix_branch_mispredict_ratio
> Testing tma_info_inst_mix_branch_mispredict_to_unknown_branch_ratio
> Testing tma_info_inst_mix_fpdiv_uop_ratio
> Testing tma_info_inst_mix_idiv_uop_ratio
> Testing tma_info_inst_mix_ipfarbranch
> Testing tma_info_inst_mix_ipmisp_cond_ntaken
> Testing tma_info_inst_mix_ipmisp_cond_taken
> Testing tma_info_inst_mix_ipmisp_indirect
> Testing tma_info_inst_mix_ipmisp_ret
> Testing tma_info_inst_mix_ipmispredict
> Testing tma_info_inst_mix_microcode_uop_ratio
> Testing tma_info_inst_mix_x87_uop_ratio
> Testing tma_info_l1_bound_address_alias_blocks
> Testing tma_info_l1_bound_load_splits
> Testing tma_info_l1_bound_store_fwd_blocks
> Testing tma_info_memory_cycles_per_demand_load_dram_hit
> Testing tma_info_memory_cycles_per_demand_load_l2_hit
> Testing tma_info_memory_cycles_per_demand_load_l3_hit
> Testing tma_info_memory_memloadpki
> Testing tma_info_system_kernel_cpi
> Testing tma_info_system_kernel_utilization
> Testing tma_data_sharing
> Testing tma_lock_latency
> Testing tma_fused_instructions
> Testing tma_info_pipeline_ipassist
> Testing tma_info_pipeline_retire
> Testing tma_info_pipeline_strings_cycles
> Testing tma_info_thread_clks
> Testing tma_info_thread_uoppi
> Testing tma_int_operations
> Testing tma_memory_operations
> Testing tma_non_fused_branches
> Testing tma_nop_instructions
> Testing tma_other_light_ops
> Testing tma_ports_utilization
> Testing tma_ports_utilized_0
> Testing tma_ports_utilized_1
> Metric 'tma_ports_utilized_1' not printed in:
> # Running 'internals/synthesize' benchmark:
> Computing performance of single threaded perf event synthesis by
> synthesizing events on the perf process itself:
>   Average synthesis took: 49.581 usec (+- 0.030 usec)
>   Average num. events: 47.000 (+- 0.000)
>   Average time per event 1.055 usec
>   Average data synthesis took: 53.367 usec (+- 0.032 usec)
>   Average num. events: 246.000 (+- 0.000)
>   Average time per event 0.217 usec
>
>  Performance counter stats for 'perf bench internals synthesize':
>
>      <not counted>      cpu_core/TOPDOWN.SLOTS/                          =
                       (0.00%)
>      <not counted>      cpu_core/topdown-retiring/                       =
                       (0.00%)
>      <not counted>      cpu_core/topdown-mem-bound/                      =
                       (0.00%)
>      <not counted>      cpu_core/topdown-bad-spec/                       =
                       (0.00%)
>      <not counted>      cpu_core/topdown-fe-bound/                       =
                       (0.00%)
>      <not counted>      cpu_core/topdown-be-bound/                       =
                       (0.00%)
>      <not counted>      cpu_core/RESOURCE_STALLS.SCOREBOARD/             =
                           (0.00%)
>      <not counted>      cpu_core/EXE_ACTIVITY.1_PORTS_UTIL/              =
                          (0.00%)
>      <not counted>      cpu_core/EXE_ACTIVITY.BOUND_ON_LOADS/            =
                            (0.00%)
>      <not counted>      cpu_core/EXE_ACTIVITY.1_PORTS_UTIL/              =
                          (0.00%)
>      <not counted>      cpu_core/CYCLE_ACTIVITY.STALLS_TOTAL/            =
                            (0.00%)
>      <not counted>      cpu_core/CPU_CLK_UNHALTED.THREAD/                =
                        (0.00%)
>      <not counted>      cpu_core/ARITH.DIV_ACTIVE/                       =
                       (0.00%)
>      <not counted>      cpu_core/EXE_ACTIVITY.2_PORTS_UTIL,umask=3D0xc/  =
                                      (0.00%)
>      <not counted>      cpu_core/EXE_ACTIVITY.3_PORTS_UTIL,umask=3D0x80/ =
                                       (0.00%)
>
>        1.180394056 seconds time elapsed
>
>        0.409881000 seconds user
>        0.764134000 seconds sys
> Testing tma_ports_utilized_2
> Metric 'tma_ports_utilized_2' not printed in:
> # Running 'internals/synthesize' benchmark:
> Computing performance of single threaded perf event synthesis by
> synthesizing events on the perf process itself:
>   Average synthesis took: 50.456 usec (+- 0.066 usec)
>   Average num. events: 47.000 (+- 0.000)
>   Average time per event 1.074 usec
>   Average data synthesis took: 52.904 usec (+- 0.030 usec)
>   Average num. events: 246.000 (+- 0.000)
>   Average time per event 0.215 usec
>
>  Performance counter stats for 'perf bench internals synthesize':
>
>      <not counted>      cpu_core/TOPDOWN.SLOTS/                          =
                       (0.00%)
>      <not counted>      cpu_core/topdown-retiring/                       =
                       (0.00%)
>      <not counted>      cpu_core/topdown-mem-bound/                      =
                       (0.00%)
>      <not counted>      cpu_core/topdown-bad-spec/                       =
                       (0.00%)
>      <not counted>      cpu_core/topdown-fe-bound/                       =
                       (0.00%)
>      <not counted>      cpu_core/topdown-be-bound/                       =
                       (0.00%)
>      <not counted>      cpu_core/RESOURCE_STALLS.SCOREBOARD/             =
                           (0.00%)
>      <not counted>      cpu_core/EXE_ACTIVITY.1_PORTS_UTIL/              =
                          (0.00%)
>      <not counted>      cpu_core/EXE_ACTIVITY.BOUND_ON_LOADS/            =
                            (0.00%)
>      <not counted>      cpu_core/CYCLE_ACTIVITY.STALLS_TOTAL/            =
                            (0.00%)
>      <not counted>      cpu_core/CPU_CLK_UNHALTED.THREAD/                =
                        (0.00%)
>      <not counted>      cpu_core/ARITH.DIV_ACTIVE/                       =
                       (0.00%)
>      <not counted>      cpu_core/EXE_ACTIVITY.2_PORTS_UTIL,umask=3D0xc/  =
                                      (0.00%)
>      <not counted>      cpu_core/EXE_ACTIVITY.2_PORTS_UTIL/              =
                          (0.00%)
>      <not counted>      cpu_core/EXE_ACTIVITY.3_PORTS_UTIL,umask=3D0x80/ =
                                       (0.00%)
>
>        1.187012938 seconds time elapsed
>
>        0.397919000 seconds user
>        0.782854000 seconds sys
> Testing tma_ports_utilized_3m
> Metric 'tma_ports_utilized_3m' not printed in:
> # Running 'internals/synthesize' benchmark:
> Computing performance of single threaded perf event synthesis by
> synthesizing events on the perf process itself:
>   Average synthesis took: 48.248 usec (+- 0.028 usec)
>   Average num. events: 47.000 (+- 0.000)
>   Average time per event 1.027 usec
>   Average data synthesis took: 52.781 usec (+- 0.036 usec)
>   Average num. events: 245.000 (+- 0.000)
>   Average time per event 0.215 usec
>
>  Performance counter stats for 'perf bench internals synthesize':
>
>      <not counted>      cpu_core/TOPDOWN.SLOTS/                          =
                       (0.00%)
>      <not counted>      cpu_core/topdown-retiring/                       =
                       (0.00%)
>      <not counted>      cpu_core/topdown-mem-bound/                      =
                       (0.00%)
>      <not counted>      cpu_core/topdown-bad-spec/                       =
                       (0.00%)
>      <not counted>      cpu_core/topdown-fe-bound/                       =
                       (0.00%)
>      <not counted>      cpu_core/topdown-be-bound/                       =
                       (0.00%)
>      <not counted>      cpu_core/UOPS_EXECUTED.CYCLES_GE_3/              =
                          (0.00%)
>      <not counted>      cpu_core/RESOURCE_STALLS.SCOREBOARD/             =
                           (0.00%)
>      <not counted>      cpu_core/EXE_ACTIVITY.1_PORTS_UTIL/              =
                          (0.00%)
>      <not counted>      cpu_core/EXE_ACTIVITY.BOUND_ON_LOADS/            =
                            (0.00%)
>      <not counted>      cpu_core/CYCLE_ACTIVITY.STALLS_TOTAL/            =
                            (0.00%)
>      <not counted>      cpu_core/CPU_CLK_UNHALTED.THREAD/                =
                        (0.00%)
>      <not counted>      cpu_core/ARITH.DIV_ACTIVE/                       =
                       (0.00%)
>      <not counted>      cpu_core/EXE_ACTIVITY.2_PORTS_UTIL,umask=3D0xc/  =
                                      (0.00%)
>      <not counted>      cpu_core/EXE_ACTIVITY.3_PORTS_UTIL,umask=3D0x80/ =
                                       (0.00%)
>
>        1.160315379 seconds time elapsed
>
>        0.388639000 seconds user
>        0.765363000 seconds sys
> Testing tma_serializing_operation
> Testing C10_Pkg_Residency
> Testing C1_Core_Residency
> Testing C2_Pkg_Residency
> Testing C3_Pkg_Residency
> Testing C6_Core_Residency
> Testing C6_Pkg_Residency
> Testing C7_Core_Residency
> Testing C7_Pkg_Residency
> Testing C8_Pkg_Residency
> Testing C9_Pkg_Residency
> Testing tma_info_system_average_frequency
> Testing tma_info_system_turbo_utilization
> Testing tma_info_inst_mix_ipswpf
> Testing tma_info_bottleneck_branching_overhead
> Testing tma_info_core_coreipc
> Testing tma_info_thread_ipc
> Testing tma_heavy_operations
> Testing tma_light_operations
> Testing tma_info_core_core_clks
> Testing tma_info_system_smt_2t_utilization
> Testing tma_info_thread_slots_utilization
> Testing UNCORE_FREQ
> Testing tma_info_system_socket_clks
> Testing tma_info_inst_mix_instructions
> Testing tma_info_thread_slots
> Testing tma_base
> Testing tma_ms_uops
> Testing tma_resource_bound
> Testing tma_alloc_restriction
> Testing tma_branch_detect
> Testing tma_branch_resteer
> Testing tma_cisc
> Testing tma_decode
> Testing tma_divider
> Testing tma_fast_nuke
> Testing tma_few_uops_instructions
> Testing tma_fpdiv_uops
> Testing tma_mem_scheduler
> Testing tma_non_mem_scheduler
> Testing tma_nuke
> Testing tma_other_fb
> Testing tma_other_load_store
> Testing tma_other_ret
> Testing tma_predecode
> Testing tma_register
> Testing tma_reorder_buffer
> Testing tma_serialization
> Testing tma_assists
> Testing tma_disambiguation
> Testing tma_fp_assist
> Testing tma_ld_buffer
> Testing tma_memory_ordering
> Testing tma_other_l1
> Testing tma_page_fault
> Testing tma_rsv
> Testing tma_smc
> Testing tma_split_loads
> Testing tma_split_stores
> Testing tma_st_buffer
> Testing tma_stlb_hit
> Testing tma_stlb_miss
> Testing tma_store_fwd_blk
> Testing tma_alu_op_utilization
> Testing tma_load_op_utilization
> Testing tma_mixing_vectors
> Testing tma_page_faults
> Testing tma_store_op_utilization
> Testing tma_memory_fence
> Metric 'tma_memory_fence' not printed in:
> # Running 'internals/synthesize' benchmark:
> Computing performance of single threaded perf event synthesis by
> synthesizing events on the perf process itself:
>   Average synthesis took: 49.458 usec (+- 0.033 usec)
>   Average num. events: 47.000 (+- 0.000)
>   Average time per event 1.052 usec
>   Average data synthesis took: 53.268 usec (+- 0.027 usec)
>   Average num. events: 244.000 (+- 0.000)
>   Average time per event 0.218 usec
>
>  Performance counter stats for 'perf bench internals synthesize':
>
>      <not counted>      cpu_core/TOPDOWN.SLOTS/                          =
                       (0.00%)
>      <not counted>      cpu_core/topdown-retiring/                       =
                       (0.00%)
>      <not counted>      cpu_core/topdown-mem-bound/                      =
                       (0.00%)
>      <not counted>      cpu_core/topdown-bad-spec/                       =
                       (0.00%)
>      <not counted>      cpu_core/topdown-fe-bound/                       =
                       (0.00%)
>      <not counted>      cpu_core/topdown-be-bound/                       =
                       (0.00%)
>      <not counted>      cpu_core/RESOURCE_STALLS.SCOREBOARD/             =
                           (0.00%)
>      <not counted>      cpu_core/EXE_ACTIVITY.1_PORTS_UTIL/              =
                          (0.00%)
>      <not counted>      cpu_core/EXE_ACTIVITY.BOUND_ON_LOADS/            =
                            (0.00%)
>      <not counted>      cpu_core/MISC2_RETIRED.LFENCE/                   =
                       (0.00%)
>      <not counted>      cpu_core/CYCLE_ACTIVITY.STALLS_TOTAL/            =
                            (0.00%)
>      <not counted>      cpu_core/CPU_CLK_UNHALTED.THREAD/                =
                        (0.00%)
>      <not counted>      cpu_core/ARITH.DIV_ACTIVE/                       =
                       (0.00%)
>      <not counted>      cpu_core/EXE_ACTIVITY.2_PORTS_UTIL,umask=3D0xc/  =
                                      (0.00%)
>      <not counted>      cpu_core/EXE_ACTIVITY.3_PORTS_UTIL,umask=3D0x80/ =
                                       (0.00%)
>
>        1.177929044 seconds time elapsed
>
>        0.434552000 seconds user
>        0.736874000 seconds sys
> Testing tma_port_1
> Testing tma_port_6
> Testing tma_slow_pause
> Metric 'tma_slow_pause' not printed in:
> # Running 'internals/synthesize' benchmark:
> Computing performance of single threaded perf event synthesis by
> synthesizing events on the perf process itself:
>   Average synthesis took: 49.987 usec (+- 0.049 usec)
>   Average num. events: 47.000 (+- 0.000)
>   Average time per event 1.064 usec
>   Average data synthesis took: 53.490 usec (+- 0.033 usec)
>   Average num. events: 245.000 (+- 0.000)
>   Average time per event 0.218 usec
>
>  Performance counter stats for 'perf bench internals synthesize':
>
>      <not counted>      cpu_core/TOPDOWN.SLOTS/                          =
                       (0.00%)
>      <not counted>      cpu_core/topdown-retiring/                       =
                       (0.00%)
>      <not counted>      cpu_core/topdown-mem-bound/                      =
                       (0.00%)
>      <not counted>      cpu_core/topdown-bad-spec/                       =
                       (0.00%)
>      <not counted>      cpu_core/topdown-fe-bound/                       =
                       (0.00%)
>      <not counted>      cpu_core/topdown-be-bound/                       =
                       (0.00%)
>      <not counted>      cpu_core/RESOURCE_STALLS.SCOREBOARD/             =
                           (0.00%)
>      <not counted>      cpu_core/EXE_ACTIVITY.1_PORTS_UTIL/              =
                          (0.00%)
>      <not counted>      cpu_core/EXE_ACTIVITY.BOUND_ON_LOADS/            =
                            (0.00%)
>      <not counted>      cpu_core/CPU_CLK_UNHALTED.PAUSE/                 =
                       (0.00%)
>      <not counted>      cpu_core/CYCLE_ACTIVITY.STALLS_TOTAL/            =
                            (0.00%)
>      <not counted>      cpu_core/CPU_CLK_UNHALTED.THREAD/                =
                        (0.00%)
>      <not counted>      cpu_core/ARITH.DIV_ACTIVE/                       =
                       (0.00%)
>      <not counted>      cpu_core/EXE_ACTIVITY.2_PORTS_UTIL,umask=3D0xc/  =
                                      (0.00%)
>      <not counted>      cpu_core/EXE_ACTIVITY.3_PORTS_UTIL,umask=3D0x80/ =
                                       (0.00%)
>
>        1.186254766 seconds time elapsed
>
>        0.427220000 seconds user
>        0.752217000 seconds sys
> Testing smi_cycles
> Testing smi_num
> Testing tsx_aborted_cycles
> Testing tsx_cycles_per_elision
> Testing tsx_cycles_per_transaction
> Testing tsx_transactional_cycles
> test child finished with -1
> ---- end ----
> perf all metrics test: FAILED!
> root@number:~#

Have a try disabling the NMI watchdog. Agreed that there is more to
fix here but I think the PMU driver is in part to blame because
manually breaking the weak group of events is a fix. Fwiw, if we
switch to the buddy watchdog mechanism then we'll no longer need to
disable the NMI watchdog:
https://lore.kernel.org/lkml/20230421155255.1.I6bf789d21d0c3d75d382e7e51a80=
4a7a51315f2c@changeid/

Thanks,
Ian

> > ---
> >  .../arch/x86/alderlake/adl-metrics.json           | 15 ++++++++-------
> >  .../arch/x86/rocketlake/rkl-metrics.json          |  2 +-
> >  2 files changed, 9 insertions(+), 8 deletions(-)
> >
> > diff --git a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json =
b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
> > index 3388b58b8f1a..35124a4ddcb2 100644
> > --- a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
> > +++ b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
> > @@ -69,12 +69,6 @@
> >          "MetricName": "C9_Pkg_Residency",
> >          "ScaleUnit": "100%"
> >      },
> > -    {
> > -        "BriefDescription": "Uncore frequency per die [GHZ]",
> > -        "MetricExpr": "tma_info_system_socket_clks / #num_dies / durat=
ion_time / 1e9",
> > -        "MetricGroup": "SoC",
> > -        "MetricName": "UNCORE_FREQ"
> > -    },
> >      {
> >          "BriefDescription": "Percentage of cycles spent in System Mana=
gement Interrupts.",
> >          "MetricExpr": "((msr@aperf@ - cycles) / msr@aperf@ if msr@smi@=
 > 0 else 0)",
> > @@ -809,6 +803,13 @@
> >          "ScaleUnit": "100%",
> >          "Unit": "cpu_atom"
> >      },
> > +    {
> > +        "BriefDescription": "Uncore frequency per die [GHZ]",
> > +        "MetricExpr": "tma_info_system_socket_clks / #num_dies / durat=
ion_time / 1e9",
> > +        "MetricGroup": "SoC",
> > +        "MetricName": "UNCORE_FREQ",
> > +        "Unit": "cpu_core"
> > +    },
> >      {
> >          "BriefDescription": "This metric represents Core fraction of c=
ycles CPU dispatched uops on execution ports for ALU operations.",
> >          "MetricExpr": "(cpu_core@UOPS_DISPATCHED.PORT_0@ + cpu_core@UO=
PS_DISPATCHED.PORT_1@ + cpu_core@UOPS_DISPATCHED.PORT_5_11@ + cpu_core@UOPS=
_DISPATCHED.PORT_6@) / (5 * tma_info_core_core_clks)",
> > @@ -1838,7 +1839,7 @@
> >      },
> >      {
> >          "BriefDescription": "Average number of parallel data read requ=
ests to external memory",
> > -        "MetricExpr": "UNC_ARB_DAT_OCCUPANCY.RD / cpu_core@UNC_ARB_DAT=
_OCCUPANCY.RD\\,cmask\\=3D1@",
> > +        "MetricExpr": "UNC_ARB_DAT_OCCUPANCY.RD / UNC_ARB_DAT_OCCUPANC=
Y.RD@cmask\\=3D1@",
> >          "MetricGroup": "Mem;MemoryBW;SoC",
> >          "MetricName": "tma_info_system_mem_parallel_reads",
> >          "PublicDescription": "Average number of parallel data read req=
uests to external memory. Accounts for demand loads and L1/L2 prefetches",
> > diff --git a/tools/perf/pmu-events/arch/x86/rocketlake/rkl-metrics.json=
 b/tools/perf/pmu-events/arch/x86/rocketlake/rkl-metrics.json
> > index 0c880e415669..27433fc15ede 100644
> > --- a/tools/perf/pmu-events/arch/x86/rocketlake/rkl-metrics.json
> > +++ b/tools/perf/pmu-events/arch/x86/rocketlake/rkl-metrics.json
> > @@ -985,7 +985,7 @@
> >      },
> >      {
> >          "BriefDescription": "Average number of parallel data read requ=
ests to external memory",
> > -        "MetricExpr": "UNC_ARB_DAT_OCCUPANCY.RD / cpu@UNC_ARB_DAT_OCCU=
PANCY.RD\\,cmask\\=3D1@",
> > +        "MetricExpr": "UNC_ARB_DAT_OCCUPANCY.RD / UNC_ARB_DAT_OCCUPANC=
Y.RD@cmask\\=3D1@",
> >          "MetricGroup": "Mem;MemoryBW;SoC",
> >          "MetricName": "tma_info_system_mem_parallel_reads",
> >          "PublicDescription": "Average number of parallel data read req=
uests to external memory. Accounts for demand loads and L1/L2 prefetches"
> > --
> > 2.43.0.472.g3155946c3a-goog
> >
>
> --
>
> - Arnaldo
>

