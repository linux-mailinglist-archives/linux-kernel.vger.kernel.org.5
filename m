Return-Path: <linux-kernel+bounces-46441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DCD843FB5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA7931C26A77
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C757AE58;
	Wed, 31 Jan 2024 12:51:18 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BD169D06
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 12:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706705476; cv=none; b=rp4w9yFxV4iQ6GIVokwpa2GidKSKloQ3vK9Z42akpWcSN3je/JFc72k7qeypa+MeV+CYxzm9UuEgSgKdBqhmB9FdpQnmrTRxHSwRJMeSnb3En/X3wGLDM0q4gX5s8erbWJvKXUsvL5kEflxsIcx1aQwPM0YR4gh2Enh+1vN51lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706705476; c=relaxed/simple;
	bh=1sbxFxuZ/FpvcHgCjw/4AgzrqP4no5wc1bamb507Hvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ePlJlbZuPngSLjQc6S24qlMvNGB6ARTVqcu6Q+6dvlgMGv4nnGUYTOcGvbPPALGGMSfFtk+LdmCaXVmOogZpmQtiBp/pEitbWF2Hj58q1KAhl00grk50ZaWpsFoCYCBjuFC7LQ6U9sLNOiCqJiIpFQOeMVz/QUQdUhpOyI7u9aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TQ1xl152Bz1FJvQ;
	Wed, 31 Jan 2024 20:46:35 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 4E7FF18001A;
	Wed, 31 Jan 2024 20:51:04 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 20:51:03 +0800
Message-ID: <ebdc0ef1-e17f-4382-af22-f46fafc93a67@huawei.com>
Date: Wed, 31 Jan 2024 20:51:02 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [mm] 728be28fae: stress-ng.rawsock.ops_per_sec
 92.8% improvement
Content-Language: en-US
To: kernel test robot <oliver.sang@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox
	<willy@infradead.org>, "Huang, Ying" <ying.huang@intel.com>, David
 Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, Mike Kravetz
	<mike.kravetz@oracle.com>, Zi Yan <ziy@nvidia.com>, <linux-mm@kvack.org>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>
References: <202401311429.be2be5fc-oliver.sang@intel.com>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <202401311429.be2be5fc-oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/1/31 15:20, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed a 92.8% improvement of stress-ng.rawsock.ops_per_sec on:
> 
> 
> commit: 728be28fae8c838d52c91dce4867133798146357 ("mm: migrate: remove THP mapcount check in numamigrate_isolate_page()")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> testcase: stress-ng
> test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
> parameters:
> 
> 	nr_threads: 100%
> 	testtime: 60s
> 	class: network
> 	test: rawsock
> 	cpufreq_governor: performance
> 
> 
> we doubt the performance improvement is caused by:
> 
>       81.65            -6.0       75.61        mpstat.cpu.all.soft%
> 
> but we still cannot connect this with code change, so this report is just FYI
> what we observed in our stress-ng tests.

The change is only related to the PMD huge page numa fault，with it，it
seems that there are more numa folio migration，see numa_pages_migrated 
and pgmigrate_success，2498->81759, but I don't know why it reduce 6%
for testcase, also skb should not use PMD huge page...

> 
> 
> 
> Details are as below:
> -------------------------------------------------------------------------------------------------->
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240131/202401311429.be2be5fc-oliver.sang@intel.com
> 
> =========================================================================================
> class/compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
>    network/gcc-12/performance/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp8/rawsock/stress-ng/60s
> 
> commit:
>    a8ac4a767d ("mm: migrate: remove PageTransHuge check in numamigrate_isolate_page()")
>    728be28fae ("mm: migrate: remove THP mapcount check in numamigrate_isolate_page()")
> 
> a8ac4a767dcd9d87 728be28fae8c838d52c91dce486
> ---------------- ---------------------------
>           %stddev     %change         %stddev
>               \          |                \
>   2.893e+08 ±  3%     +10.9%  3.208e+08 ±  6%  cpuidle..time
>      327582 ±  3%     +17.2%     383952 ±  4%  cpuidle..usage
>        0.02 ± 33%  +21362.2%       4.86 ± 24%  vmstat.procs.b
>        6087 ±  4%     +37.6%       8376 ±  4%  vmstat.system.cs
>        6.18 ± 11%      +0.5        6.71 ±  8%  mpstat.cpu.all.idle%
>        0.02 ± 41%      +0.1        0.14 ± 12%  mpstat.cpu.all.iowait%
>        0.72            +0.0        0.72        mpstat.cpu.all.irq%
>       81.65            -6.0       75.61        mpstat.cpu.all.soft%
>       10.81 ±  2%      +5.1       15.92        mpstat.cpu.all.sys%
>        0.62 ±  3%      +0.3        0.89        mpstat.cpu.all.usr%
>        0.62 ±  3%      +0.3        0.89        mpstat.cpu.all.usr%
>      294865 ±  5%     +17.5%     346453 ±  6%  turbostat.C1
>        6.38 ±  6%      +0.7        7.08 ±  7%  turbostat.C1%
>      114.67 ±172%   +1663.8%       2022 ± 28%  turbostat.POLL
>      581.00 ±  8%     -13.3%     503.83 ±  5%  perf-c2c.DRAM.local
>        6865 ±  5%     +23.4%       8471 ±  4%  perf-c2c.DRAM.remote
>       11672 ±  4%      +9.5%      12781 ±  5%  perf-c2c.HITM.local
>        2365 ± 14%     +77.4%       4195 ±  7%  perf-c2c.HITM.remote
>       14037 ±  5%     +20.9%      16977 ±  5%  perf-c2c.HITM.total
>        1.80 ±  4%     +96.8%       3.54 ±  2%  stress-ng.rawsock.MB_recv'd_per_sec
>   2.686e+08 ±  4%     +92.8%  5.177e+08 ±  2%  stress-ng.rawsock.ops
>     4365441 ±  4%     +92.8%    8416438 ±  2%  stress-ng.rawsock.ops_per_sec
>      157379 ±  3%     +20.4%     189468 ±  4%  stress-ng.time.involuntary_context_switches
>       35115           +53.9%      54057 ±  2%  stress-ng.time.minor_page_faults
>      696.83 ±  2%     +50.5%       1048        stress-ng.time.percent_of_cpu_this_job_got
>      430.92 ±  2%     +49.4%     643.73        stress-ng.time.system_time
>       12.80 ±  4%     +88.0%      24.08 ±  3%  stress-ng.time.user_time
>       42314 ±  2%    +168.1%     113467 ±  7%  stress-ng.time.voluntary_context_switches
>      120896 ±  2%      -2.4%     118016        proc-vmstat.nr_inactive_anon
>       55524            -1.1%      54939        proc-vmstat.nr_slab_unreclaimable
>      120896 ±  2%      -2.4%     118016        proc-vmstat.nr_zone_inactive_anon
>       14930 ±  3%     -24.7%      11241 ± 42%  proc-vmstat.numa_hint_faults_local
>     2138444            -5.4%    2021976        proc-vmstat.numa_hit
>     2072186            -6.5%    1937601        proc-vmstat.numa_local
>        2498 ± 24%   +3172.5%      81759 ±  7%  proc-vmstat.numa_pages_migrated
>      274877 ±  2%     +39.0%     382002 ±  3%  proc-vmstat.numa_pte_updates
>     3790765            -4.8%    3607274        proc-vmstat.pgalloc_normal
>      398562            +5.7%     421173        proc-vmstat.pgfault
>     3640715            -4.9%    3462273        proc-vmstat.pgfree
>        2498 ± 24%   +3172.5%      81759 ±  7%  proc-vmstat.pgmigrate_success
>      316024 ±  3%     +57.4%     497273        sched_debug.cfs_rq:/.avg_vruntime.avg
>      527031 ±  6%     +31.9%     695410 ±  8%  sched_debug.cfs_rq:/.avg_vruntime.max
>      225478 ±  4%     +71.8%     387338 ±  4%  sched_debug.cfs_rq:/.avg_vruntime.min
>      377256 ± 18%     +50.1%     566136 ± 13%  sched_debug.cfs_rq:/.left_vruntime.max
>        1122 ± 67%     -73.0%     302.59 ± 84%  sched_debug.cfs_rq:/.load_avg.avg
>      316031 ±  3%     +57.3%     497273        sched_debug.cfs_rq:/.min_vruntime.avg
>      527031 ±  6%     +31.9%     695409 ±  8%  sched_debug.cfs_rq:/.min_vruntime.max
>      225478 ±  4%     +71.8%     387338 ±  4%  sched_debug.cfs_rq:/.min_vruntime.min
>      377256 ± 18%     +50.1%     566136 ± 13%  sched_debug.cfs_rq:/.right_vruntime.max
>      347.20 ±  9%     +55.5%     540.03 ± 28%  sched_debug.cfs_rq:/.util_avg.stddev
>      369.30 ±  5%     +44.1%     532.30 ±  7%  sched_debug.cfs_rq:/.util_est_enqueued.avg
>      712094           -18.8%     578101 ±  4%  sched_debug.cpu.avg_idle.avg
>        5954 ±  2%     +21.0%       7207 ±  4%  sched_debug.cpu.nr_switches.avg
>        1891 ±  6%     +70.6%       3227 ±  5%  sched_debug.cpu.nr_switches.min
>       21.17 ± 28%    +195.7%      62.58 ± 10%  sched_debug.cpu.nr_uninterruptible.max
>      -16.92          +340.4%     -74.50        sched_debug.cpu.nr_uninterruptible.min
>        6.02 ±  8%    +364.8%      28.01 ± 14%  sched_debug.cpu.nr_uninterruptible.stddev
>        2.94 ± 37%    +113.3%       6.27 ± 24%  perf-sched.sch_delay.avg.ms.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg.__sys_recvfrom
>        2.51 ± 48%    +176.8%       6.96 ± 26%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
>        0.83 ± 17%    +247.9%       2.89 ±  6%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
>        0.64 ± 17%    +185.9%       1.82 ± 15%  perf-sched.sch_delay.avg.ms.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_datagram.skb_recv_datagram
>        0.07 ±133%    +368.9%       0.34 ± 37%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>        1.60 ± 17%     +87.9%       3.00 ±  6%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>      126.33 ± 14%    +134.5%     296.21 ± 18%  perf-sched.sch_delay.max.ms.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg.__sys_recvfrom
>       88.34 ± 20%    +150.1%     220.96 ± 23%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
>        1.05 ±223%   +2503.1%      27.44 ±114%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
>      198.20 ± 16%    +140.4%     476.55 ± 23%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
>      169.34 ± 39%     +99.6%     337.96 ± 28%  perf-sched.sch_delay.max.ms.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_datagram.skb_recv_datagram
>       16.98 ±128%    +539.8%     108.67 ± 52%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>      124.78 ± 22%    +123.0%     278.26 ± 67%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>        1.08 ±  8%    +146.1%       2.67 ±  9%  perf-sched.total_sch_delay.average.ms
>      474.33 ± 75%     +65.7%     786.13 ± 39%  perf-sched.total_sch_delay.max.ms
>       64.64 ±  6%     -36.3%      41.20 ± 11%  perf-sched.total_wait_and_delay.average.ms
>       23788 ± 10%     +49.8%      35644 ± 12%  perf-sched.total_wait_and_delay.count.ms
>       63.55 ±  6%     -39.4%      38.54 ± 12%  perf-sched.total_wait_time.average.ms
>       13.44 ±  6%     +17.6%      15.81 ±  8%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
>       77.35 ±  7%     -51.5%      37.54 ± 15%  perf-sched.wait_and_delay.avg.ms.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg.__sys_recvfrom
>        4.60 ± 22%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
>       24.90 ±  4%     -27.8%      17.98 ± 10%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
>       19.65 ± 16%     -64.7%       6.95 ± 17%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_datagram.skb_recv_datagram
>      138.88 ±  3%     -15.8%     116.89 ±  6%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>      367.83 ± 10%     -20.6%     292.17 ±  7%  perf-sched.wait_and_delay.count.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
>      289.00 ± 15%     +70.2%     491.83 ± 18%  perf-sched.wait_and_delay.count.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg.__sys_recvfrom
>      145.50 ± 11%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
>        2074 ± 17%    +325.3%       8822 ± 25%  perf-sched.wait_and_delay.count.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_datagram.skb_recv_datagram
>      300.28 ± 12%     +97.5%     592.92 ± 18%  perf-sched.wait_and_delay.max.ms.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg.__sys_recvfrom
>      129.21 ± 21%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
>      412.03 ± 23%     +64.2%     676.47 ± 27%  perf-sched.wait_and_delay.max.ms.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_datagram.skb_recv_datagram
>       46.21 ±107%    +293.5%     181.84 ± 20%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>       13.35 ±  6%     +16.4%      15.55 ±  9%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
>       74.41 ±  9%     -58.0%      31.27 ± 17%  perf-sched.wait_time.avg.ms.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg.__sys_recvfrom
>        4.60 ± 22%     +81.2%       8.33 ± 23%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
>       24.51 ± 14%     -28.9%      17.44 ± 24%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
>       61.41 ± 27%     -53.0%      28.86 ± 14%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
>        0.10 ±200%  +38886.9%      39.12 ±110%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
>       24.07 ±  5%     -37.3%      15.09 ± 12%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
>       19.01 ± 16%     -73.0%       5.13 ± 19%  perf-sched.wait_time.avg.ms.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_datagram.skb_recv_datagram
>      137.28 ±  2%     -17.0%     113.90 ±  6%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>       43.37 ±144%    +253.4%     153.28 ± 42%  perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
>        0.00 ±159%  +3.3e+05%       3.89 ±194%  perf-sched.wait_time.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
>        1.63 ±221%  +16137.0%     264.50 ±131%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
>   2.405e+10            -4.6%  2.293e+10        perf-stat.i.branch-instructions
>        0.28 ±  3%      +0.1        0.37 ±  2%  perf-stat.i.branch-miss-rate%
>    51251291 ±  2%     +36.9%   70177276        perf-stat.i.branch-misses
>       22.15            +3.6       25.72        perf-stat.i.cache-miss-rate%
>   1.025e+09 ±  7%     -16.7%  8.538e+08 ±  8%  perf-stat.i.cache-references
>        6143 ±  3%     +39.5%       8569 ±  5%  perf-stat.i.context-switches
>        1.62            +4.7%       1.70        perf-stat.i.cpi
>      566.63          +137.0%       1343 ±  4%  perf-stat.i.cpu-migrations
>    3.81e+10            -5.6%  3.598e+10        perf-stat.i.dTLB-loads
>        0.00 ±  8%      +0.0        0.00 ± 22%  perf-stat.i.dTLB-store-miss-rate%
>       76418 ± 11%     +48.1%     113175 ± 25%  perf-stat.i.dTLB-store-misses
>   2.412e+10            -5.0%  2.292e+10        perf-stat.i.dTLB-stores
>   1.326e+11            -4.8%  1.263e+11        perf-stat.i.instructions
>        0.62            -4.6%       0.59        perf-stat.i.ipc
>        1436 ±  2%     -13.5%       1242 ± 12%  perf-stat.i.metric.K/sec
>        1359            -5.4%       1287        perf-stat.i.metric.M/sec
>        4398 ±  2%      +7.9%       4746 ±  2%  perf-stat.i.minor-faults
>       91.42            +1.9       93.36        perf-stat.i.node-load-miss-rate%
>    42725236 ±  3%     +14.4%   48889377 ±  5%  perf-stat.i.node-load-misses
>     3460356 ±  8%     -25.1%    2591983 ± 13%  perf-stat.i.node-loads
>       84.11            +1.3       85.44        perf-stat.i.node-store-miss-rate%
>    38774401 ±  6%     +58.9%   61593486 ±  4%  perf-stat.i.node-store-misses
>     6145595 ±  2%     +38.9%    8536000        perf-stat.i.node-stores
>        4398 ±  2%      +7.9%       4747 ±  2%  perf-stat.i.page-faults
>        0.21 ±  2%      +0.1        0.30        perf-stat.overall.branch-miss-rate%
>       22.71            +3.9       26.62 ±  2%  perf-stat.overall.cache-miss-rate%
>        1.64            +4.3%       1.71        perf-stat.overall.cpi
>        0.00 ± 11%      +0.0        0.00 ± 26%  perf-stat.overall.dTLB-store-miss-rate%
>        0.61            -4.2%       0.58        perf-stat.overall.ipc
>       92.52            +2.5       94.99        perf-stat.overall.node-load-miss-rate%
>       86.30            +1.5       87.82        perf-stat.overall.node-store-miss-rate%
>   2.375e+10            -4.6%  2.266e+10        perf-stat.ps.branch-instructions
>    50207120 ±  2%     +37.4%   68982796        perf-stat.ps.branch-misses
>   1.012e+09 ±  7%     -16.6%  8.446e+08 ±  9%  perf-stat.ps.cache-references
>        5893 ±  3%     +39.8%       8240 ±  5%  perf-stat.ps.context-switches
>      545.78          +140.7%       1313 ±  4%  perf-stat.ps.cpu-migrations
>   3.764e+10            -5.5%  3.556e+10        perf-stat.ps.dTLB-loads
>       74052 ± 11%     +48.6%     110013 ± 25%  perf-stat.ps.dTLB-store-misses
>   2.383e+10            -4.9%  2.265e+10        perf-stat.ps.dTLB-stores
>    1.31e+11            -4.7%  1.248e+11        perf-stat.ps.instructions
>        4213 ±  2%      +8.1%       4553        perf-stat.ps.minor-faults
>    42211937 ±  3%     +14.6%   48392298 ±  5%  perf-stat.ps.node-load-misses
>     3418585 ±  8%     -24.9%    2565985 ± 13%  perf-stat.ps.node-loads
>    38311557 ±  6%     +59.1%   60965372 ±  4%  perf-stat.ps.node-store-misses
>     6068466 ±  2%     +39.1%    8443820        perf-stat.ps.node-stores
>        4214 ±  2%      +8.1%       4553        perf-stat.ps.page-faults
>   8.441e+12            -4.5%  8.062e+12        perf-stat.total.instructions
>       88.83            -6.8       82.04        perf-profile.calltrace.cycles-pp.sendto.stress_rawsock_child
>       88.75            -6.8       81.97        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.sendto.stress_rawsock_child
>       88.92            -6.8       82.14        perf-profile.calltrace.cycles-pp.stress_rawsock_child
>       88.71            -6.8       81.93        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendto.stress_rawsock_child
>       88.63            -6.8       81.86        perf-profile.calltrace.cycles-pp.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendto.stress_rawsock_child
>       88.59            -6.8       81.84        perf-profile.calltrace.cycles-pp.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendto
>       88.36            -6.7       81.64        perf-profile.calltrace.cycles-pp.sock_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       88.24            -6.7       81.55        perf-profile.calltrace.cycles-pp.raw_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
>       87.30            -6.6       80.74        perf-profile.calltrace.cycles-pp.raw_send_hdrinc.raw_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto
>       85.83            -6.4       79.46        perf-profile.calltrace.cycles-pp.ip_finish_output2.raw_send_hdrinc.raw_sendmsg.sock_sendmsg.__sys_sendto
>       85.79            -6.4       79.42        perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.raw_send_hdrinc.raw_sendmsg.sock_sendmsg
>       85.43            -6.3       79.13        perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.raw_send_hdrinc.raw_sendmsg
>       85.42            -6.3       79.12        perf-profile.calltrace.cycles-pp.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.raw_send_hdrinc
>       85.40            -6.3       79.10        perf-profile.calltrace.cycles-pp.__do_softirq.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2
>       85.09            -6.3       78.81        perf-profile.calltrace.cycles-pp.net_rx_action.__do_softirq.do_softirq.__local_bh_enable_ip.__dev_queue_xmit
>       85.05            -6.3       78.78        perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.__do_softirq.do_softirq
>       85.06            -6.3       78.78        perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.__do_softirq.do_softirq.__local_bh_enable_ip
>       84.98            -6.3       78.70        perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action.__do_softirq
>       84.84            -6.3       78.59        perf-profile.calltrace.cycles-pp.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action
>       84.54            -6.2       78.32        perf-profile.calltrace.cycles-pp.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll
>       84.02            -6.2       77.83        perf-profile.calltrace.cycles-pp.raw_v4_input.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog
>       63.80            -4.6       59.18        perf-profile.calltrace.cycles-pp.raw_rcv.raw_v4_input.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core
>        5.12 ±  4%      -1.7        3.43 ±  8%  perf-profile.calltrace.cycles-pp.__xfrm_policy_check2.raw_rcv.raw_v4_input.ip_protocol_deliver_rcu.ip_local_deliver_finish
>        5.24 ±  3%      -1.1        4.13 ±  2%  perf-profile.calltrace.cycles-pp.ipv4_pktinfo_prepare.raw_rcv.raw_v4_input.ip_protocol_deliver_rcu.ip_local_deliver_finish
>        3.47 ±  4%      -0.9        2.55 ±  5%  perf-profile.calltrace.cycles-pp.sk_filter_trim_cap.sock_queue_rcv_skb_reason.raw_rcv.raw_v4_input.ip_protocol_deliver_rcu
>        6.09            -0.6        5.50        perf-profile.calltrace.cycles-pp.skb_clone.raw_v4_input.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core
>        4.82            -0.6        4.26 ±  2%  perf-profile.calltrace.cycles-pp.kfree_skb_reason.raw_rcv.raw_v4_input.ip_protocol_deliver_rcu.ip_local_deliver_finish
>       43.83            -0.6       43.27        perf-profile.calltrace.cycles-pp.sock_queue_rcv_skb_reason.raw_rcv.raw_v4_input.ip_protocol_deliver_rcu.ip_local_deliver_finish
>        2.28 ±  2%      -0.5        1.75 ±  4%  perf-profile.calltrace.cycles-pp.rcu_core.__do_softirq.run_ksoftirqd.smpboot_thread_fn.kthread
>        2.28 ±  2%      -0.5        1.75 ±  4%  perf-profile.calltrace.cycles-pp.__do_softirq.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
>        2.28 ±  2%      -0.5        1.75 ±  4%  perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>        2.27 ±  2%      -0.5        1.74 ±  4%  perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.__do_softirq.run_ksoftirqd.smpboot_thread_fn
>        2.25 ±  2%      -0.5        1.73 ±  4%  perf-profile.calltrace.cycles-pp.dst_destroy.rcu_do_batch.rcu_core.__do_softirq.run_ksoftirqd
>        2.28 ±  2%      -0.5        1.76 ±  4%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>        2.29 ±  2%      -0.5        1.77 ±  4%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
>        2.29 ±  2%      -0.5        1.77 ±  4%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
>        2.29 ±  2%      -0.5        1.77 ±  4%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
>        2.92            -0.5        2.41        perf-profile.calltrace.cycles-pp.kmem_cache_free.raw_rcv.raw_v4_input.ip_protocol_deliver_rcu.ip_local_deliver_finish
>        2.03 ±  2%      -0.5        1.54 ±  4%  perf-profile.calltrace.cycles-pp.percpu_counter_add_batch.dst_destroy.rcu_do_batch.rcu_core.__do_softirq
>        3.92            -0.4        3.49 ±  2%  perf-profile.calltrace.cycles-pp.skb_release_data.kfree_skb_reason.raw_rcv.raw_v4_input.ip_protocol_deliver_rcu
>        1.53 ±  2%      -0.4        1.13 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock.percpu_counter_add_batch.dst_destroy.rcu_do_batch.rcu_core
>        4.85 ±  2%      -0.4        4.46        perf-profile.calltrace.cycles-pp.kmem_cache_alloc.skb_clone.raw_v4_input.ip_protocol_deliver_rcu.ip_local_deliver_finish
>        1.51 ±  2%      -0.4        1.11 ±  5%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.percpu_counter_add_batch.dst_destroy.rcu_do_batch
>        2.76            -0.2        2.59 ±  2%  perf-profile.calltrace.cycles-pp.dst_release.ipv4_pktinfo_prepare.raw_rcv.raw_v4_input.ip_protocol_deliver_rcu
>        0.92            -0.1        0.78        perf-profile.calltrace.cycles-pp.security_sock_rcv_skb.sk_filter_trim_cap.sock_queue_rcv_skb_reason.raw_rcv.raw_v4_input
>        0.72            -0.1        0.62 ±  4%  perf-profile.calltrace.cycles-pp.sock_alloc_send_pskb.raw_send_hdrinc.raw_sendmsg.sock_sendmsg.__sys_sendto
>        0.74 ±  4%      +0.4        1.11        perf-profile.calltrace.cycles-pp.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.raw_recvmsg
>        0.79 ±  4%      +0.4        1.22        perf-profile.calltrace.cycles-pp._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.raw_recvmsg.inet_recvmsg
>        0.39 ± 71%      +0.5        0.90 ±  4%  perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc.skb_clone.raw_v4_input.ip_protocol_deliver_rcu
>        0.95 ±  3%      +0.6        1.50 ±  2%  perf-profile.calltrace.cycles-pp.skb_release_data.consume_skb.raw_recvmsg.inet_recvmsg.sock_recvmsg
>        9.05            +0.6        9.63        perf-profile.calltrace.cycles-pp.__skb_clone.raw_v4_input.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core
>        0.00            +0.6        0.58 ±  8%  perf-profile.calltrace.cycles-pp.__unfreeze_partials.raw_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom
>        0.83 ±  5%      +0.6        1.43 ±  2%  perf-profile.calltrace.cycles-pp.check_heap_object.__check_object_size.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter
>        5.27            +0.7        6.00        perf-profile.calltrace.cycles-pp.__copy_skb_header.__skb_clone.raw_v4_input.ip_protocol_deliver_rcu.ip_local_deliver_finish
>        0.00            +0.8        0.76        perf-profile.calltrace.cycles-pp.__slab_free.raw_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom
>        0.00            +0.8        0.77 ±  2%  perf-profile.calltrace.cycles-pp.sock_rfree.skb_release_head_state.consume_skb.raw_recvmsg.inet_recvmsg
>        0.00            +0.8        0.79 ±  2%  perf-profile.calltrace.cycles-pp.move_addr_to_user.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        0.00            +0.8        0.80 ±  2%  perf-profile.calltrace.cycles-pp.skb_release_head_state.consume_skb.raw_recvmsg.inet_recvmsg.sock_recvmsg
>        1.00 ±  6%      +0.8        1.83 ±  2%  perf-profile.calltrace.cycles-pp.__check_object_size.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.raw_recvmsg
>        1.30 ±  5%      +0.9        2.17 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__skb_try_recv_datagram.__skb_recv_datagram.skb_recv_datagram
>        1.07 ±  5%      +0.9        1.96 ±  2%  perf-profile.calltrace.cycles-pp.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.raw_recvmsg.inet_recvmsg
>        1.37 ±  4%      +1.0        2.33 ±  2%  perf-profile.calltrace.cycles-pp.consume_skb.raw_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom
>        1.80 ±  5%      +1.4        3.19 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__skb_try_recv_datagram.__skb_recv_datagram.skb_recv_datagram.raw_recvmsg
>        1.44 ±  7%      +1.4        2.84 ±  2%  perf-profile.calltrace.cycles-pp.sock_def_readable.__sock_queue_rcv_skb.sock_queue_rcv_skb_reason.raw_rcv.raw_v4_input
>        2.01 ±  5%      +1.5        3.47 ±  2%  perf-profile.calltrace.cycles-pp.__skb_datagram_iter.skb_copy_datagram_iter.raw_recvmsg.inet_recvmsg.sock_recvmsg
>        2.04 ±  5%      +1.5        3.51 ±  2%  perf-profile.calltrace.cycles-pp.skb_copy_datagram_iter.raw_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom
>        1.97 ±  5%      +1.6        3.53 ±  2%  perf-profile.calltrace.cycles-pp.__skb_try_recv_datagram.__skb_recv_datagram.skb_recv_datagram.raw_recvmsg.inet_recvmsg
>        2.03 ±  6%      +1.6        3.67 ±  2%  perf-profile.calltrace.cycles-pp.__skb_recv_datagram.skb_recv_datagram.raw_recvmsg.inet_recvmsg.sock_recvmsg
>        2.05 ±  5%      +1.7        3.70 ±  2%  perf-profile.calltrace.cycles-pp.skb_recv_datagram.raw_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom
>        8.31 ±  3%      +1.7        9.99        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__sock_queue_rcv_skb.sock_queue_rcv_skb_reason.raw_rcv
>        9.31 ±  3%      +2.2       11.47        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__sock_queue_rcv_skb.sock_queue_rcv_skb_reason.raw_rcv.raw_v4_input
>        7.09 ±  5%      +5.7       12.79 ±  2%  perf-profile.calltrace.cycles-pp.raw_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
>        7.13 ±  5%      +5.7       12.88 ±  2%  perf-profile.calltrace.cycles-pp.inet_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64
>        7.29 ±  5%      +5.9       13.20 ±  2%  perf-profile.calltrace.cycles-pp.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        8.08 ±  5%      +6.7       14.74 ±  2%  perf-profile.calltrace.cycles-pp.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvfrom
>        8.11 ±  5%      +6.7       14.79 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvfrom.stress_oomable_child
>        8.20 ±  5%      +6.8       14.98 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvfrom.stress_oomable_child
>        8.26 ±  5%      +6.8       15.08 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.recvfrom.stress_oomable_child
>        8.47 ±  5%      +7.0       15.50 ±  2%  perf-profile.calltrace.cycles-pp.recvfrom.stress_oomable_child
>        8.72 ±  5%      +7.3       16.00 ±  2%  perf-profile.calltrace.cycles-pp.stress_oomable_child
>       88.87            -6.8       82.07        perf-profile.children.cycles-pp.sendto
>       87.77            -6.8       80.98        perf-profile.children.cycles-pp.__do_softirq
>       88.92            -6.8       82.14        perf-profile.children.cycles-pp.stress_rawsock_child
>       88.64            -6.8       81.87        perf-profile.children.cycles-pp.__x64_sys_sendto
>       88.60            -6.7       81.85        perf-profile.children.cycles-pp.__sys_sendto
>       88.36            -6.7       81.65        perf-profile.children.cycles-pp.sock_sendmsg
>       88.24            -6.7       81.56        perf-profile.children.cycles-pp.raw_sendmsg
>       87.31            -6.6       80.74        perf-profile.children.cycles-pp.raw_send_hdrinc
>       85.83            -6.4       79.46        perf-profile.children.cycles-pp.ip_finish_output2
>       85.79            -6.4       79.42        perf-profile.children.cycles-pp.__dev_queue_xmit
>       85.10            -6.3       78.81        perf-profile.children.cycles-pp.net_rx_action
>       85.06            -6.3       78.78        perf-profile.children.cycles-pp.process_backlog
>       85.06            -6.3       78.78        perf-profile.children.cycles-pp.__napi_poll
>       84.98            -6.3       78.71        perf-profile.children.cycles-pp.__netif_receive_skb_one_core
>       85.51            -6.3       79.24        perf-profile.children.cycles-pp.__local_bh_enable_ip
>       85.49            -6.3       79.22        perf-profile.children.cycles-pp.do_softirq
>       84.84            -6.3       78.59        perf-profile.children.cycles-pp.ip_local_deliver_finish
>       84.55            -6.2       78.32        perf-profile.children.cycles-pp.ip_protocol_deliver_rcu
>       84.52            -6.2       78.30        perf-profile.children.cycles-pp.raw_v4_input
>       64.71            -4.8       59.94        perf-profile.children.cycles-pp.raw_rcv
>        5.21 ±  4%      -1.7        3.52 ±  8%  perf-profile.children.cycles-pp.__xfrm_policy_check2
>        5.44 ±  3%      -1.1        4.32 ±  2%  perf-profile.children.cycles-pp.ipv4_pktinfo_prepare
>        3.66 ±  4%      -0.9        2.72 ±  4%  perf-profile.children.cycles-pp.sk_filter_trim_cap
>        6.31            -0.6        5.68        perf-profile.children.cycles-pp.skb_clone
>        5.12            -0.6        4.50 ±  2%  perf-profile.children.cycles-pp.kfree_skb_reason
>       44.12            -0.6       43.52        perf-profile.children.cycles-pp.sock_queue_rcv_skb_reason
>        2.28 ±  2%      -0.5        1.75 ±  4%  perf-profile.children.cycles-pp.run_ksoftirqd
>        2.28 ±  2%      -0.5        1.76 ±  4%  perf-profile.children.cycles-pp.smpboot_thread_fn
>        2.29 ±  2%      -0.5        1.77 ±  4%  perf-profile.children.cycles-pp.kthread
>        2.29 ±  2%      -0.5        1.77 ±  4%  perf-profile.children.cycles-pp.ret_from_fork
>        2.29 ±  2%      -0.5        1.77 ±  4%  perf-profile.children.cycles-pp.ret_from_fork_asm
>        2.53 ±  2%      -0.5        2.04 ±  4%  perf-profile.children.cycles-pp.dst_destroy
>        2.55 ±  3%      -0.5        2.06 ±  4%  perf-profile.children.cycles-pp.rcu_do_batch
>        2.55 ±  2%      -0.5        2.07 ±  4%  perf-profile.children.cycles-pp.rcu_core
>        5.38            -0.5        4.90        perf-profile.children.cycles-pp.kmem_cache_alloc
>        2.40 ±  2%      -0.5        1.93 ±  4%  perf-profile.children.cycles-pp.percpu_counter_add_batch
>        1.73 ±  2%      -0.4        1.35 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock
>        3.32            -0.4        2.95        perf-profile.children.cycles-pp.kmem_cache_free
>        2.92            -0.2        2.73 ±  2%  perf-profile.children.cycles-pp.dst_release
>        1.22            -0.2        1.05        perf-profile.children.cycles-pp.security_sock_rcv_skb
>        0.70            -0.1        0.58 ±  2%  perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
>        0.73            -0.1        0.62 ±  4%  perf-profile.children.cycles-pp.sock_alloc_send_pskb
>        0.36 ±  3%      -0.1        0.28 ±  9%  perf-profile.children.cycles-pp.skb_set_owner_w
>        0.48 ±  2%      -0.1        0.40 ±  3%  perf-profile.children.cycles-pp.kfree_skbmem
>        0.41            -0.1        0.35 ±  2%  perf-profile.children.cycles-pp.skb_push
>        0.35 ±  3%      -0.1        0.29 ±  3%  perf-profile.children.cycles-pp.should_failslab
>        0.41            -0.1        0.35 ±  2%  perf-profile.children.cycles-pp.apparmor_socket_sock_rcv_skb
>        0.52 ±  2%      -0.0        0.47 ±  3%  perf-profile.children.cycles-pp.ip_mc_sf_allow
>        0.25            -0.0        0.20 ±  3%  perf-profile.children.cycles-pp.dev_hard_start_xmit
>        0.23            -0.0        0.19 ±  4%  perf-profile.children.cycles-pp.loopback_xmit
>        0.38 ±  2%      -0.0        0.35        perf-profile.children.cycles-pp.__ip_select_ident
>        0.10 ±  7%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.sock_wfree
>        0.23 ±  2%      -0.0        0.20 ±  3%  perf-profile.children.cycles-pp.dst_alloc
>        0.24            -0.0        0.21 ±  3%  perf-profile.children.cycles-pp.rt_dst_alloc
>        0.07            -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.validate_xmit_skb
>        0.06            +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.stress_rawsock_client
>        0.27 ±  5%      +0.0        0.30        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
>        0.14 ±  6%      +0.0        0.17 ±  3%  perf-profile.children.cycles-pp.rt_set_nexthop
>        0.03 ± 70%      +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.__cond_resched
>        0.06 ±  7%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.syscall_return_via_sysret
>        0.06 ±  8%      +0.0        0.10 ±  3%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
>        0.06 ±  9%      +0.1        0.11 ±  3%  perf-profile.children.cycles-pp.__skb_try_recv_from_queue
>        0.11 ±  5%      +0.1        0.16 ±  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
>        0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.import_single_range
>        0.07 ±  7%      +0.1        0.12 ±  3%  perf-profile.children.cycles-pp.__virt_addr_valid
>        0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.stress_hash_mulxror32
>        0.01 ±223%      +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
>        0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
>        0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.check_stack_object
>        0.08 ± 10%      +0.1        0.14 ±  5%  perf-profile.children.cycles-pp.put_cpu_partial
>        0.07 ±  5%      +0.1        0.15 ± 12%  perf-profile.children.cycles-pp.__check_heap_object
>        0.15 ±  2%      +0.1        0.23 ±  6%  perf-profile.children.cycles-pp.aa_sk_perm
>        0.09 ± 10%      +0.1        0.17 ±  2%  perf-profile.children.cycles-pp.__put_user_nocheck_4
>        0.12 ±  5%      +0.1        0.20 ±  2%  perf-profile.children.cycles-pp.__fget_light
>        0.10 ±  5%      +0.1        0.20 ±  2%  perf-profile.children.cycles-pp.__get_user_4
>        0.14 ±  6%      +0.1        0.24 ±  4%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
>        0.15 ±  7%      +0.1        0.26 ±  2%  perf-profile.children.cycles-pp.sockfd_lookup_light
>        0.19 ±  5%      +0.1        0.31 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64
>        0.13 ±  7%      +0.1        0.26 ±  2%  perf-profile.children.cycles-pp.stress_rawsock_server
>        0.16 ± 19%      +0.1        0.29 ±  4%  perf-profile.children.cycles-pp._copy_to_user
>        0.13 ±  9%      +0.1        0.26 ±  6%  perf-profile.children.cycles-pp.security_socket_recvmsg
>        0.15 ±  8%      +0.2        0.36 ±  3%  perf-profile.children.cycles-pp.is_vmalloc_addr
>        0.20 ± 14%      +0.2        0.40 ±  7%  perf-profile.children.cycles-pp.get_partial_node
>        0.99 ±  2%      +0.3        1.31        perf-profile.children.cycles-pp.skb_release_head_state
>        0.70 ±  8%      +0.3        1.04 ±  4%  perf-profile.children.cycles-pp.___slab_alloc
>        0.25 ± 13%      +0.4        0.60 ±  8%  perf-profile.children.cycles-pp.__unfreeze_partials
>        0.84 ±  3%      +0.4        1.21        perf-profile.children.cycles-pp.__slab_free
>        0.40 ±  6%      +0.4        0.78 ±  2%  perf-profile.children.cycles-pp.sock_rfree
>        0.75 ±  4%      +0.4        1.15        perf-profile.children.cycles-pp.copyout
>        0.43 ±  8%      +0.4        0.83 ±  2%  perf-profile.children.cycles-pp.move_addr_to_user
>        0.79 ±  4%      +0.4        1.23        perf-profile.children.cycles-pp._copy_to_iter
>        9.26            +0.5        9.81        perf-profile.children.cycles-pp.__skb_clone
>        1.02 ±  4%      +0.7        1.73 ±  2%  perf-profile.children.cycles-pp.check_heap_object
>        5.36            +0.7        6.08        perf-profile.children.cycles-pp.__copy_skb_header
>        1.23 ±  5%      +0.9        2.09 ±  2%  perf-profile.children.cycles-pp.__check_object_size
>        1.08 ±  5%      +0.9        1.97 ±  2%  perf-profile.children.cycles-pp.simple_copy_to_iter
>        1.57 ±  3%      +0.9        2.51 ±  2%  perf-profile.children.cycles-pp.consume_skb
>        1.44 ±  6%      +1.4        2.84 ±  2%  perf-profile.children.cycles-pp.sock_def_readable
>        2.02 ±  5%      +1.5        3.48 ±  2%  perf-profile.children.cycles-pp.__skb_datagram_iter
>        2.04 ±  5%      +1.5        3.52 ±  2%  perf-profile.children.cycles-pp.skb_copy_datagram_iter
>        1.99 ±  5%      +1.6        3.57 ±  2%  perf-profile.children.cycles-pp.__skb_try_recv_datagram
>        2.04 ±  5%      +1.6        3.68 ±  2%  perf-profile.children.cycles-pp.__skb_recv_datagram
>        2.06 ±  5%      +1.7        3.72 ±  2%  perf-profile.children.cycles-pp.skb_recv_datagram
>       11.40 ±  3%      +2.5       13.86        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
>       11.34 ±  3%      +3.9       15.27        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
>        7.10 ±  5%      +5.7       12.82 ±  2%  perf-profile.children.cycles-pp.raw_recvmsg
>        7.14 ±  5%      +5.8       12.89 ±  2%  perf-profile.children.cycles-pp.inet_recvmsg
>        7.30 ±  5%      +5.9       13.22 ±  2%  perf-profile.children.cycles-pp.sock_recvmsg
>        8.10 ±  5%      +6.7       14.77 ±  2%  perf-profile.children.cycles-pp.__sys_recvfrom
>        8.11 ±  5%      +6.7       14.80 ±  2%  perf-profile.children.cycles-pp.__x64_sys_recvfrom
>        8.58 ±  5%      +7.1       15.71 ±  2%  perf-profile.children.cycles-pp.recvfrom
>        8.72 ±  5%      +7.3       16.00 ±  2%  perf-profile.children.cycles-pp.stress_oomable_child
>       28.65            -3.1       25.55        perf-profile.self.cycles-pp.__sock_queue_rcv_skb
>        5.01 ±  4%      -1.7        3.34 ±  8%  perf-profile.self.cycles-pp.__xfrm_policy_check2
>        4.32 ±  5%      -1.4        2.93 ±  6%  perf-profile.self.cycles-pp.raw_v4_input
>        2.50 ±  7%      -0.9        1.58 ±  8%  perf-profile.self.cycles-pp.ipv4_pktinfo_prepare
>        2.44 ±  5%      -0.8        1.66 ±  8%  perf-profile.self.cycles-pp.sk_filter_trim_cap
>        3.96            -0.7        3.28 ±  2%  perf-profile.self.cycles-pp.kmem_cache_alloc
>        3.21            -0.4        2.85        perf-profile.self.cycles-pp.kmem_cache_free
>        1.72            -0.2        1.52        perf-profile.self.cycles-pp.raw_rcv
>        3.90            -0.2        3.72        perf-profile.self.cycles-pp.__skb_clone
>        2.77            -0.2        2.60 ±  2%  perf-profile.self.cycles-pp.dst_release
>        1.01            -0.2        0.85        perf-profile.self.cycles-pp.skb_clone
>        0.92            -0.1        0.79        perf-profile.self.cycles-pp.security_sock_rcv_skb
>        0.86            -0.1        0.74 ±  2%  perf-profile.self.cycles-pp.sock_queue_rcv_skb_reason
>        0.67 ±  2%      -0.1        0.56 ±  2%  perf-profile.self.cycles-pp.kfree_skb_reason
>        0.58            -0.1        0.48 ±  2%  perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
>        0.66 ±  3%      -0.1        0.58 ±  2%  perf-profile.self.cycles-pp.percpu_counter_add_batch
>        0.35 ±  2%      -0.1        0.27 ±  9%  perf-profile.self.cycles-pp.skb_set_owner_w
>        0.26 ±  3%      -0.1        0.18 ±  6%  perf-profile.self.cycles-pp.raw_sendmsg
>        0.36 ±  2%      -0.1        0.30 ±  4%  perf-profile.self.cycles-pp.kfree_skbmem
>        0.34 ±  3%      -0.1        0.29 ±  2%  perf-profile.self.cycles-pp.ip_mc_sf_allow
>        0.31            -0.0        0.27        perf-profile.self.cycles-pp.skb_push
>        0.38            -0.0        0.34        perf-profile.self.cycles-pp.skb_release_head_state
>        0.10 ±  8%      -0.0        0.06 ± 11%  perf-profile.self.cycles-pp.sock_wfree
>        0.35 ±  2%      -0.0        0.32 ±  2%  perf-profile.self.cycles-pp.__ip_select_ident
>        0.20 ±  2%      -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.apparmor_socket_sock_rcv_skb
>        0.12 ±  3%      -0.0        0.10 ±  3%  perf-profile.self.cycles-pp.should_failslab
>        0.11            -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.__sys_sendto
>        0.06 ±  6%      +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.do_syscall_64
>        0.06 ±  9%      +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.entry_SYSCALL_64
>        0.08 ±  7%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
>        0.06 ±  6%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.syscall_return_via_sysret
>        0.06 ±  9%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.__skb_try_recv_from_queue
>        0.06 ±  6%      +0.1        0.11 ±  3%  perf-profile.self.cycles-pp.__virt_addr_valid
>        0.00            +0.1        0.05        perf-profile.self.cycles-pp.check_stack_object
>        0.00            +0.1        0.05        perf-profile.self.cycles-pp.sockfd_lookup_light
>        0.03 ± 70%      +0.1        0.09 ±  5%  perf-profile.self.cycles-pp.simple_copy_to_iter
>        0.07 ± 10%      +0.1        0.12 ±  3%  perf-profile.self.cycles-pp.move_addr_to_user
>        0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
>        0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.security_socket_recvmsg
>        0.04 ± 45%      +0.1        0.10 ±  6%  perf-profile.self.cycles-pp.__skb_recv_datagram
>        0.12 ±  3%      +0.1        0.18 ±  7%  perf-profile.self.cycles-pp.aa_sk_perm
>        0.08 ± 10%      +0.1        0.14 ±  4%  perf-profile.self.cycles-pp.put_cpu_partial
>        0.02 ±141%      +0.1        0.08 ±  4%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
>        0.10 ± 10%      +0.1        0.16 ±  3%  perf-profile.self.cycles-pp.__check_object_size
>        0.07 ±  8%      +0.1        0.14 ± 11%  perf-profile.self.cycles-pp.__check_heap_object
>        0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.sock_recvmsg
>        0.00            +0.1        0.07 ±  6%  perf-profile.self.cycles-pp.inet_recvmsg
>        0.01 ±223%      +0.1        0.08 ±  5%  perf-profile.self.cycles-pp._copy_to_iter
>        0.12 ±  6%      +0.1        0.20 ±  2%  perf-profile.self.cycles-pp.__fget_light
>        0.08 ±  8%      +0.1        0.16 ±  2%  perf-profile.self.cycles-pp.__put_user_nocheck_4
>        0.07 ±  8%      +0.1        0.15 ±  4%  perf-profile.self.cycles-pp.is_vmalloc_addr
>        0.09 ±  7%      +0.1        0.18 ±  2%  perf-profile.self.cycles-pp.__get_user_4
>        0.14 ± 12%      +0.1        0.23 ±  5%  perf-profile.self.cycles-pp.get_partial_node
>        0.13 ±  5%      +0.1        0.23 ±  4%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
>        0.12 ±  8%      +0.1        0.22 ±  2%  perf-profile.self.cycles-pp.recvfrom
>        0.10 ± 10%      +0.1        0.21 ± 12%  perf-profile.self.cycles-pp.__skb_try_recv_datagram
>        0.12 ± 11%      +0.1        0.23 ±  5%  perf-profile.self.cycles-pp.__unfreeze_partials
>        0.12 ±  4%      +0.1        0.24 ±  2%  perf-profile.self.cycles-pp.stress_rawsock_server
>        0.15 ± 19%      +0.1        0.28 ±  4%  perf-profile.self.cycles-pp._copy_to_user
>        0.46 ±  6%      +0.1        0.60 ±  2%  perf-profile.self.cycles-pp.___slab_alloc
>        0.15 ±  6%      +0.1        0.30 ±  2%  perf-profile.self.cycles-pp.__skb_datagram_iter
>        0.25 ±  6%      +0.2        0.48 ±  2%  perf-profile.self.cycles-pp.__sys_recvfrom
>        0.84 ±  3%      +0.4        1.20        perf-profile.self.cycles-pp.__slab_free
>        0.39 ±  7%      +0.4        0.77 ±  3%  perf-profile.self.cycles-pp.sock_rfree
>        0.74 ±  4%      +0.4        1.14 ±  2%  perf-profile.self.cycles-pp.copyout
>        0.87 ±  5%      +0.6        1.43 ±  2%  perf-profile.self.cycles-pp.check_heap_object
>        0.70 ±  6%      +0.7        1.38 ±  3%  perf-profile.self.cycles-pp.raw_recvmsg
>        5.24            +0.7        5.98        perf-profile.self.cycles-pp.__copy_skb_header
>        1.63 ±  4%      +1.1        2.73 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
>        1.43 ±  7%      +1.4        2.81 ±  2%  perf-profile.self.cycles-pp.sock_def_readable
>       11.39 ±  3%      +2.4       13.84        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
> 
> 
> 
> 
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are provided
> for informational purposes only. Any difference in system hardware or software
> design or configuration may affect actual performance.
> 
> 

