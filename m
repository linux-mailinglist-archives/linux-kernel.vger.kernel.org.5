Return-Path: <linux-kernel+bounces-92258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D57871D97
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75C6F1F27979
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFE355E46;
	Tue,  5 Mar 2024 11:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMtDDROV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B055490A;
	Tue,  5 Mar 2024 11:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709637666; cv=none; b=Ak4EhkkPETOQqsocnTEtxLkHwu1Q4HpJhVGt1Q8m/8ebFksOHz7vdledz5lyFn58KhG9tOSq/KKvkCyHEksftl9zGHlXhXHcc8yVCpgilaCrbymFhtdKN0A4SCThkWzg/nG0ESDK06ermH77sRpm9zLL3R6TiKoOWnZwyEgl/to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709637666; c=relaxed/simple;
	bh=B9uXyeIIymQs3DVoAN869AJzTg+k83+bPlFd9fF6PgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sOckfKBOj3xL3lSm9W8iUkGK9Rz7J3NhQMxk1ZUGHJyIRFjmo6Qu0dHUsLiohbD8VeMBAdr2wCZv7uQ10iHgqmruq/sYr/c/lUD93+EUCA4S511r7S7UT1xr1OJIA0v7qs9xD8FgMTBC346pIHVfIclDyfavU3pwU8LsTBzDFBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMtDDROV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82155C433F1;
	Tue,  5 Mar 2024 11:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709637666;
	bh=B9uXyeIIymQs3DVoAN869AJzTg+k83+bPlFd9fF6PgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iMtDDROVB+G3Eg0k5IhfrjGKeh6seSgmffjnkz/RMxUCJ1h+yunP8bat2TwtOKF9a
	 m3L9qi20WGWcMkTXNsbH07OmC+zzT88VDnYl7HNoGyrrM2aOvVqzjj7iWQ27QY+nug
	 kcUdAIgKPpN/7Cp/QfI2If+rgCijjIGLO31i0hFFoSSTBiNJGN/IN9aaK+1vmOrvb1
	 7JCd1+bwfsaY4FkKBUHc9vk2MsBaNUBTejA62Xx2N2S8HzBaXonD/Eg43bsgwUmpti
	 TOUaDEv/4CnordTxzu1JINJGzp61MQzYtHRmFx46V3ViJTP4RigwD4keVcNdmmVLCh
	 66rNGUyo9HAHA==
Date: Tue, 5 Mar 2024 12:21:03 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Oliver Sang <oliver.sang@intel.com>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>, ying.huang@intel.com,
	feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [tip:timers/core] [timers]  7ee9887703:  netperf.Throughput_Mbps
 -1.2% regression
Message-ID: <ZecAHxE+y6BHVET8@lothringen>
References: <202403011511.24defbbd-oliver.sang@intel.com>
 <ZeUWreWcp4UWQ081@pavilion.home>
 <ZeUuLPXfLCmB39qq@xsang-OptiPlex-9020>
 <ZeWwYUY56IG0yzzQ@localhost.localdomain>
 <ZeaAx662HfbpMLdg@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZeaAx662HfbpMLdg@xsang-OptiPlex-9020>

On Tue, Mar 05, 2024 at 10:17:43AM +0800, Oliver Sang wrote:
> 57e95a5c4117dc6a b2cf7507e18649a30512515ec0c a184d9835a0a689261ea6a4a8db
> ---------------- --------------------------- ---------------------------
>          %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \
>    1364607           +11.8%    1525991           +10.3%    1504946        cpuidle..usage

Does it mean more time spent in idle/C-states? That's unclear...

>      45.86 ±  4%      +8.4%      49.70 ±  5%      +3.5%      47.46 ±  6%  boot-time.boot
>       5430 ±  5%      +9.0%       5921 ±  5%      +3.8%       5636 ±  6%  boot-time.idle
>       0.03            +0.0        0.04            +0.0        0.04        mpstat.cpu.all.soft%
>       0.04            +0.0        0.08            +0.0        0.08 ±  2%  mpstat.cpu.all.sys%
>       4.14            -8.9%       3.77 ±  2%      -8.3%       3.79 ±  2%  mpstat.max_utilization_pct
>      20726 ± 63%    +246.1%      71744 ± 53%     +68.2%      34867 ± 72%  numa-numastat.node0.other_node
>    1431327 ±  7%     +13.9%    1630876 ±  3%     +14.8%    1643375 ±  7%  numa-numastat.node1.numa_hit
>      37532 ± 35%     +62.1%      60841 ± 63%    +160.8%      97891 ± 25%  numa-numastat.node1.other_node
>     201.33 ±  3%     -28.5%     144.00 ±  8%     -26.8%     147.40 ± 11%  perf-c2c.DRAM.remote
>     187.83 ±  3%     -21.4%     147.67 ±  6%     -37.0%     118.40 ± 11%  perf-c2c.HITM.local
>      40.67 ±  7%     -54.5%      18.50 ± 19%     -59.7%      16.40 ± 11%  perf-c2c.HITM.remote
>       1.36 ±  4%     +10.7%       1.51 ±  3%     +12.7%       1.53 ±  5%  vmstat.procs.r
>       5654            -1.9%       5549            -2.8%       5497        vmstat.system.cs
>       5232           +10.7%       5790            +8.8%       5690        vmstat.system.in
>      15247 ±  6%      -5.0%      14490 ±  9%      -8.8%      13903 ±  5%  numa-meminfo.node0.PageTables
>      12499 ±  6%    +115.6%      26951 ±  3%    +118.3%      27288 ±  2%  numa-meminfo.node1.Active
>      12489 ±  6%    +115.7%      26940 ±  3%    +118.2%      27249 ±  2%  numa-meminfo.node1.Active(anon)
>      12488 ±  6%    +114.2%      26754 ±  3%    +118.2%      27255 ±  2%  numa-meminfo.node1.Shmem
>     102.17 ±  8%    +906.2%       1028 ±  5%    +910.1%       1032 ±  5%  time.involuntary_context_switches

There is a lot more involuntary context switches. This could be due to timers
performing wake ups expiring more often on busy CPUs.

[...]
>       4178 ±  2%     +86.3%       7784           +87.3%       7826 ±  2%  proc-vmstat.nr_zone_active_anon
>    3064698            +4.4%    3200938            +4.2%    3193539        proc-vmstat.numa_hit
>    3006439            +2.1%    3068397            +1.8%    3060785        proc-vmstat.numa_local
>      58258          +127.6%     132587          +127.9%     132758        proc-vmstat.numa_other
>       8114 ±  2%     +63.2%      13244 ±  4%     +62.6%      13190 ±  2%  proc-vmstat.pgactivate
>     986600            +1.2%     998606            +0.9%     995307        proc-vmstat.pgfault
>      20.00         +1905.0%     401.00 ± 79%   +2050.0%     430.00 ± 79%  proc-vmstat.unevictable_pgs_culled
>      15.14           +17.0%      17.72           +17.4%      17.77        perf-stat.i.MPKI
>  1.702e+08            +3.5%  1.762e+08            +3.3%  1.758e+08        perf-stat.i.branch-instructions
>       1.68            +0.1        1.80            +0.1        1.81        perf-stat.i.branch-miss-rate%
>    7174339            +1.2%    7262760            +1.4%    7276699        perf-stat.i.branch-misses
>      18.46            +3.4       21.86            +3.4       21.87        perf-stat.i.cache-miss-rate%
>    4047319           +20.6%    4880009           +20.4%    4874638        perf-stat.i.cache-misses
>   22007366            +2.6%   22586331            +2.5%   22565036        perf-stat.i.cache-references
>       5620            -1.6%       5532            -2.5%       5482        perf-stat.i.context-switches
>       1.84           +17.0%       2.15           +16.5%       2.14        perf-stat.i.cpi
>  9.159e+08           +12.8%  1.033e+09           +12.4%   1.03e+09        perf-stat.i.cpu-cycles
>     161.08          +193.1%     472.19 ±  2%    +192.1%     470.47 ±  4%  perf-stat.i.cpu-migrations

A lot more task migrations. Not sure how to explain that.

[...]
>     160.61          +193.0%     470.58 ±  2%    +191.9%     468.79 ±  4%  perf-stat.ps.cpu-migrations
>  8.433e+08            +3.0%  8.685e+08            +2.7%  8.665e+08        perf-stat.ps.instructions
>  2.551e+11            +3.3%  2.636e+11            +3.1%  2.631e+11        perf-stat.total.instructions
>      31.82 ±  3%     -13.0       18.83 ± 12%     -13.2       18.65 ±  6%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
>      36.90 ±  2%     -12.6       24.32 ± 10%     -12.3       24.62 ±  5%  perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
>      27.61 ±  3%     -12.5       15.09 ± 14%     -12.4       15.24 ±  5%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
>      31.75 ±  2%     -12.0       19.79 ± 12%     -11.6       20.11 ±  5%  perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call

Fewer C3 entries.

[...]
>       4.94 ±  5%      +5.0        9.93 ±  9%      +5.2       10.09 ± 13%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
>       4.94 ±  5%      +5.0        9.93 ±  9%      +5.2       10.09 ± 13%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
>       4.94 ±  5%      +5.0        9.93 ±  9%      +5.2       10.09 ± 13%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
>       2.83 ±  9%      +5.3        8.09 ± 13%      +5.4        8.24 ± 15%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>       1.70 ± 12%      +5.6        7.28 ± 14%      +5.8        7.54 ± 15%  perf-profile.calltrace.cycles-pp.net_rx_action.__do_softirq.run_ksoftirqd.smpboot_thread_fn.kthread
>       1.70 ± 13%      +5.6        7.28 ± 14%      +5.8        7.54 ± 15%  perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.__do_softirq.run_ksoftirqd.smpboot_thread_fn
>       1.70 ± 13%      +5.6        7.28 ± 14%      +5.8        7.54 ± 15%  perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.__do_softirq.run_ksoftirqd
>       1.73 ± 12%      +5.6        7.31 ± 14%      +5.8        7.57 ± 15%  perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>       1.73 ± 12%      +5.6        7.31 ± 14%      +5.8        7.57 ± 15%  perf-profile.calltrace.cycles-pp.__do_softirq.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork

More time spent in ksoftirqd. One theory is that remote timer expiry delay napi
polling, or the other way around...

>       0.00           +13.2       13.15 ± 49%     +11.3       11.25 ± 55%  perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle

But a lot more poll_idle time spent. Which is suprising. Also this should impact
power and not throughput...

Thanks.

