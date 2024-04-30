Return-Path: <linux-kernel+bounces-164245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E9B8B7B58
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7FEB1F2311E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A36152799;
	Tue, 30 Apr 2024 15:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bursov.com header.i=vitaly@bursov.com header.b="LtoGHcmt"
Received: from sender-of-o51.zoho.eu (sender11.zoho.eu [31.186.226.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFCF143736
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 15:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=31.186.226.224
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714490496; cv=pass; b=gZslWx3oLgjyBU8Kzb/qpbms4CxbICTZOYJGmAczHyidjiL9CGygfK/GoklTQJyuVl+EyoW1QL6zOu/kbcil+cFOJJuY9v9TI0/vE6Cc5KTn2HyYJjU9vRQQNQ7Jqxd3kLvwUwHGMAJZKL0OJOKl1bXG3xSXXyINJOlWZu/RLoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714490496; c=relaxed/simple;
	bh=5rG2CEmMl/IuKnLVQeKYTF/0EOskzKNNmSnLwlYknM4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=tjXzh1fiUtlAEdDlVdLXwk/QRiOicTsl1nD8Bl8y7glO5U9DMGtiYKyYUsvfqif6Tjp0hXBN2BEYftVRBWFnlidlNI01vLnPWoo4AW1bZZfhpn868rcY64nvO1TUs2D4rgnij9Et8bWReE2fp91hqFaaftCjmYUF9OA9jMK+D6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bursov.com; spf=pass smtp.mailfrom=bursov.com; dkim=pass (1024-bit key) header.d=bursov.com header.i=vitaly@bursov.com header.b=LtoGHcmt; arc=pass smtp.client-ip=31.186.226.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bursov.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bursov.com
Delivered-To: vitaly@bursov.com
ARC-Seal: i=1; a=rsa-sha256; t=1714489538; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=DuFGemmDqOo3x6z70oL9wvpxLStC9RqufVFR3T93lnA8gM+8z1eIo54jmzJaBORYTgndYrcCEY/3zRheW6tMp1zT8b8tEqLQxW/E0cHZodQpxukhbAvsoJZlJehvvzLm5TQ2pyivWE2YN81DZ1bEtjRQW5VaPibTd72UXxBd8Eo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1714489538; h=Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=yzgBk28EngydMzkHBpGZqagwulmWDZnXRpd9E0YHyvE=; 
	b=hmVVSD2XDBgeM4PpGDIewkTMf90PaMns4fhXM0HwbRvq9MEOInslDqvh/7QtjRnUxcJZ0VFHiEAgqLzhXabZaMF9G8I748nNdcyUl3jHAIl3Eivb1LufVEANm1D5l7k+sMWOUUlVSmyZ6I0zhbs67KmKwaiHlTev/f9rzqYprHo=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=bursov.com;
	spf=pass  smtp.mailfrom=vitaly@bursov.com;
	dmarc=pass header.from=<vitaly@bursov.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1714489538;
	s=zoho; d=bursov.com; i=vitaly@bursov.com;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To:Cc;
	bh=yzgBk28EngydMzkHBpGZqagwulmWDZnXRpd9E0YHyvE=;
	b=LtoGHcmtCiMJMX3YFYntip2oZctLvM0O38DuLFooFLMEDzR9hBiUx+RGTcKpcXwo
	KYTnPJ1826VxGWhvhj4HkOqUd9aCQGg+2W49CeVqoF6vwzoL6CpBMzmwY6KxzU+kNtm
	ASbfDcIamkoHm/QXDtbxgNtFq4C2SW1+1JyeWWMA=
Received: by mx.zoho.eu with SMTPS id 171448953497329.699883014615807;
	Tue, 30 Apr 2024 17:05:34 +0200 (CEST)
From: Vitalii Bursov <vitaly@bursov.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Vitalii Bursov <vitaly@bursov.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: [PATCH v4 0/3] sched/fair: allow disabling sched_balance_newidle with sched_relax_domain_level
Date: Tue, 30 Apr 2024 18:05:22 +0300
Message-Id: <cover.1714488502.git.vitaly@bursov.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Changes in v4:
- Updated commit messages: set Fixes tag to a proper commit,
comment about SDM macro in a debug commit.
- Link to v3: https://lore.kernel.org/lkml/cover.1712147341.git.vitaly@bursov.com/
Changes in v3:
- Remove levels table change from the documentation patch
- Link to v2: https://lore.kernel.org/lkml/cover.1711900396.git.vitaly@bursov.com/
Changes in v2:
- Split debug.c change in a separate commit and move new "level"
after "groups_flags"
- Added "Fixes" tag and updated commit message
- Update domain levels cgroup-v1/cpusets.rst documentation
- Link to v1: https://lore.kernel.org/all/cover.1711584739.git.vitaly@bursov.com/

During the upgrade from Linux 5.4 we found a small (around 3%) 
performance regression which was tracked to commit 
c5b0a7eefc70150caf23e37bc9d639c68c87a097

    sched/fair: Remove sysctl_sched_migration_cost condition

    With a default value of 500us, sysctl_sched_migration_cost is
    significanlty higher than the cost of load_balance. Remove the
    condition and rely on the sd->max_newidle_lb_cost to abort
    newidle_balance.

Looks like "newidle" balancing is beneficial for a lot of workloads, 
just not for this specific one. The workload is video encoding, there 
are 100s-1000s of threads, some are synchronized with mutexes and 
conditional variables. The process aims to have a portion of CPU idle, 
so no CPU cores are 100% busy. Perhaps, the performance impact we see 
comes from additional processing in the scheduler and additional cost 
like more cache misses, and not from an incorrect balancing. See
perf output below.

My understanding is that "sched_relax_domain_level" cgroup parameter 
should control if sched_balance_newidle() is called and what's the scope
of the balancing is, but it doesn't fully work for this case.

cpusets.rst documentation:
> The 'cpuset.sched_relax_domain_level' file allows you to request changing
> this searching range as you like.  This file takes int value which
> indicates size of searching range in levels ideally as follows,
> otherwise initial value -1 that indicates the cpuset has no request.
>  
> ====== ===========================================================
>   -1   no request. use system default or follow request of others.
>    0   no search.
>    1   search siblings (hyperthreads in a core).
>    2   search cores in a package.
>    3   search cpus in a node [= system wide on non-NUMA system]
>    4   search nodes in a chunk of node [on NUMA system]
>    5   search system wide [on NUMA system]
> ====== ===========================================================

Setting cpuset.sched_relax_domain_level to 0 works as 1.

On a dual-CPU server, domains and levels are as follows:
  domain 0: level 0, SMT
  domain 1: level 2, MC
  domain 2: level 5, NUMA

So, to support "0 no search", the value in 
cpuset.sched_relax_domain_level should disable SD_BALANCE_NEWIDLE for a 
specified level and keep it enabled for prior levels. For example, SMT 
level is 0, so sched_relax_domain_level=0 should exclude levels >=0.

Instead, cpuset.sched_relax_domain_level enables the specified level,
which effectively removes "no search" option. See below for domain
flags for all cpuset.sched_relax_domain_level values.

Proposed patch allows clearing SD_BALANCE_NEWIDLE flags when 
cpuset.sched_relax_domain_level is set to 0 and extends max
value validation range beyond sched_domain_level_max. This allows
setting SD_BALANCE_NEWIDLE on all levels and override platform
default if it does not include all levels.

Thanks

=========================
Perf output for a simimar workload/test case shows that newidle_balance
(now renamed to sched_balance_newidle) is called when handling futex and
nanosleep syscalls:
8.74%     0.40%  a.out    [kernel.vmlinux]    [k] entry_SYSCALL_64
8.34% entry_SYSCALL_64
 - do_syscall_64
    - 5.50% __x64_sys_futex
       - 5.42% do_futex
          - 3.79% futex_wait
             - 3.74% __futex_wait
                - 3.53% futex_wait_queue
                   - 3.45% schedule
                      - 3.43% __schedule
                         - 2.06% pick_next_task
                            - 1.93% pick_next_task_fair
                               - 1.87% newidle_balance
                                  - 1.52% load_balance
                                     - 1.16% find_busiest_group
                                        - 1.13% update_sd_lb_stats.constprop.0
                                             1.01% update_sg_lb_stats
                         - 0.83% dequeue_task_fair
                              0.66% dequeue_entity
          - 1.57% futex_wake
             - 1.22% wake_up_q
                - 1.20% try_to_wake_up
                     0.58% select_task_rq_fair
    - 2.44% __x64_sys_nanosleep
       - 2.36% hrtimer_nanosleep
          - 2.33% do_nanosleep
             - 2.05% schedule
                - 2.03% __schedule
                   - 1.23% pick_next_task
                      - 1.15% pick_next_task_fair
                         - 1.12% newidle_balance
                            - 0.90% load_balance
                               - 0.68% find_busiest_group
                                  - 0.66% update_sd_lb_stats.constprop.0
                                       0.59% update_sg_lb_stats
                     0.52% dequeue_task_fair

When newidle_balance is disabled (or when using older kernels), perf
output is:
6.37%     0.41%  a.out    [kernel.vmlinux]    [k] entry_SYSCALL_64
5.96% entry_SYSCALL_64
 - do_syscall_64
    - 3.97% __x64_sys_futex
       - 3.89% do_futex
          - 2.32% futex_wait
             - 2.27% __futex_wait
                - 2.05% futex_wait_queue
                   - 1.98% schedule
                      - 1.96% __schedule
                         - 0.81% dequeue_task_fair
                              0.66% dequeue_entity
                         - 0.64% pick_next_task
                              0.51% pick_next_task_fair
          - 1.52% futex_wake
             - 1.15% wake_up_q
                - try_to_wake_up
                     0.59% select_task_rq_fair
    - 1.58% __x64_sys_nanosleep
       - 1.52% hrtimer_nanosleep
          - 1.48% do_nanosleep
             - 1.20% schedule
                - 1.19% __schedule
                     0.53% dequeue_task_fair


Without a patch:
=========================
CPUs: 2 Intel(R) Xeon(R) CPU E5-2680 v3 @ 2.50GHz

# uname -r
6.8.1

# numactl -H
available: 2 nodes (0-1)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 24 25 26 27 28 29 30 31 32 33 34 35
node 0 size: 63962 MB
node 0 free: 59961 MB
node 1 cpus: 12 13 14 15 16 17 18 19 20 21 22 23 36 37 38 39 40 41 42 43 44 45 46 47
node 1 size: 64446 MB
node 1 free: 63338 MB
node distances:
node   0   1 
  0:  10  21 
  1:  21  10 

# head /proc/schedstat 
version 15
timestamp 4295347219
cpu0 0 0 0 0 0 0 3035466036 858375615 67578
domain0 0000,01000001 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0...
domain1 000f,ff000fff 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0...
domain2 ffff,ffffffff 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0...

# cd /sys/kernel/debug/sched/domains
# echo -1 > /sys/fs/cgroup/cpuset/cpuset.sched_relax_domain_level
# grep . cpu0/*/{name,flags,groups_flags,max_newidle_lb_cost}
cpu0/domain0/name:SMT
cpu0/domain1/name:MC
cpu0/domain2/name:NUMA

cpu0/domain0/flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK 
                            SD_WAKE_AFFINE SD_SHARE_CPUCAPACITY 
                            SD_SHARE_PKG_RESOURCES SD_PREFER_SIBLING
cpu0/domain1/flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK 
                            SD_WAKE_AFFINE SD_SHARE_PKG_RESOURCES 
                            SD_PREFER_SIBLING 
cpu0/domain2/flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK 
                            SD_WAKE_AFFINE SD_SERIALIZE SD_OVERLAP 
                            SD_NUMA
cpu0/domain1/groups_flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC 
                            SD_BALANCE_FORK SD_WAKE_AFFINE 
                            SD_SHARE_CPUCAPACITY SD_SHARE_PKG_RESOURCES 
                            SD_PREFER_SIBLING 
cpu0/domain2/groups_flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC 
                            SD_BALANCE_FORK SD_WAKE_AFFINE 
                            SD_SHARE_PKG_RESOURCES SD_PREFER_SIBLING 
cpu0/domain0/max_newidle_lb_cost:2236
cpu0/domain1/max_newidle_lb_cost:3444
cpu0/domain2/max_newidle_lb_cost:4590

# echo 0 > /sys/fs/cgroup/cpuset/cpuset.sched_relax_domain_level
# grep . cpu0/*/{flags,groups_flags,max_newidle_lb_cost}
cpu0/domain0/flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK 
                            SD_WAKE_AFFINE SD_SHARE_CPUCAPACITY 
                            SD_SHARE_PKG_RESOURCES SD_PREFER_SIBLING 
cpu0/domain1/flags:SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE 
                            SD_SHARE_PKG_RESOURCES SD_PREFER_SIBLING 
cpu0/domain2/flags:SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE 
                            SD_SERIALIZE SD_OVERLAP SD_NUMA 
cpu0/domain1/groups_flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC 
                            SD_BALANCE_FORK SD_WAKE_AFFINE 
                            SD_SHARE_CPUCAPACITY SD_SHARE_PKG_RESOURCES 
                            SD_PREFER_SIBLING 
cpu0/domain2/groups_flags:SD_BALANCE_EXEC SD_BALANCE_FORK 
                            SD_WAKE_AFFINE SD_SHARE_PKG_RESOURCES 
                            SD_PREFER_SIBLING 
cpu0/domain0/max_newidle_lb_cost:0
cpu0/domain1/max_newidle_lb_cost:0
cpu0/domain2/max_newidle_lb_cost:0

# echo 1 > /sys/fs/cgroup/cpuset/cpuset.sched_relax_domain_level
# grep . cpu0/*/{flags,groups_flags,max_newidle_lb_cost}

cpu0/domain0/flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK 
                            SD_WAKE_AFFINE SD_SHARE_CPUCAPACITY 
                            SD_SHARE_PKG_RESOURCES SD_PREFER_SIBLING 
cpu0/domain1/flags:SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE 
                            SD_SHARE_PKG_RESOURCES SD_PREFER_SIBLING 
cpu0/domain2/flags:SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE 
                            SD_SERIALIZE SD_OVERLAP SD_NUMA 
cpu0/domain1/groups_flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC 
                            SD_BALANCE_FORK SD_WAKE_AFFINE 
                            SD_SHARE_CPUCAPACITY SD_SHARE_PKG_RESOURCES 
                            SD_PREFER_SIBLING 
cpu0/domain2/groups_flags:SD_BALANCE_EXEC SD_BALANCE_FORK 
                            SD_WAKE_AFFINE SD_SHARE_PKG_RESOURCES 
                            SD_PREFER_SIBLING 
cpu0/domain0/max_newidle_lb_cost:309
cpu0/domain1/max_newidle_lb_cost:0
cpu0/domain2/max_newidle_lb_cost:0

# echo 2 > /sys/fs/cgroup/cpuset/cpuset.sched_relax_domain_level
# grep . cpu0/*/{flags,groups_flags,max_newidle_lb_cost}

cpu0/domain0/flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK 
                            SD_WAKE_AFFINE SD_SHARE_CPUCAPACITY 
                            SD_SHARE_PKG_RESOURCES SD_PREFER_SIBLING 
cpu0/domain1/flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK 
                            SD_WAKE_AFFINE SD_SHARE_PKG_RESOURCES 
                            SD_PREFER_SIBLING 
cpu0/domain2/flags:SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE 
                            SD_SERIALIZE SD_OVERLAP SD_NUMA 
cpu0/domain1/groups_flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC 
                            SD_BALANCE_FORK SD_WAKE_AFFINE 
                            SD_SHARE_CPUCAPACITY SD_SHARE_PKG_RESOURCES 
                            SD_PREFER_SIBLING 
cpu0/domain2/groups_flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC 
                            SD_BALANCE_FORK SD_WAKE_AFFINE 
                            SD_SHARE_PKG_RESOURCES SD_PREFER_SIBLING 
cpu0/domain0/max_newidle_lb_cost:276
cpu0/domain1/max_newidle_lb_cost:2776
cpu0/domain2/max_newidle_lb_cost:0

# echo 3 > /sys/fs/cgroup/cpuset/cpuset.sched_relax_domain_level
# grep . cpu0/*/{flags,groups_flags,max_newidle_lb_cost}
cpu0/domain0/flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK 
                            SD_WAKE_AFFINE SD_SHARE_CPUCAPACITY 
                            SD_SHARE_PKG_RESOURCES SD_PREFER_SIBLING 
cpu0/domain1/flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK 
                            SD_WAKE_AFFINE SD_SHARE_PKG_RESOURCES 
                            SD_PREFER_SIBLING 
cpu0/domain2/flags:SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE 
                            SD_SERIALIZE SD_OVERLAP SD_NUMA 
cpu0/domain1/groups_flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC 
                            SD_BALANCE_FORK SD_WAKE_AFFINE 
                            SD_SHARE_CPUCAPACITY SD_SHARE_PKG_RESOURCES 
                            SD_PREFER_SIBLING 
cpu0/domain2/groups_flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC 
                            SD_BALANCE_FORK SD_WAKE_AFFINE 
                            SD_SHARE_PKG_RESOURCES SD_PREFER_SIBLING 
cpu0/domain0/max_newidle_lb_cost:289
cpu0/domain1/max_newidle_lb_cost:3192
cpu0/domain2/max_newidle_lb_cost:0

# echo 4 > /sys/fs/cgroup/cpuset/cpuset.sched_relax_domain_level
# grep . cpu0/*/{flags,groups_flags,max_newidle_lb_cost}
cpu0/domain0/flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK 
                            SD_WAKE_AFFINE SD_SHARE_CPUCAPACITY 
                            SD_SHARE_PKG_RESOURCES SD_PREFER_SIBLING 
cpu0/domain1/flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK 
                            SD_WAKE_AFFINE SD_SHARE_PKG_RESOURCES 
                            SD_PREFER_SIBLING 
cpu0/domain2/flags:SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE 
                            SD_SERIALIZE SD_OVERLAP SD_NUMA 
cpu0/domain1/groups_flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC 
                            SD_BALANCE_FORK SD_WAKE_AFFINE 
                            SD_SHARE_CPUCAPACITY SD_SHARE_PKG_RESOURCES 
                            SD_PREFER_SIBLING 
cpu0/domain2/groups_flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC 
                            SD_BALANCE_FORK SD_WAKE_AFFINE 
                            SD_SHARE_PKG_RESOURCES SD_PREFER_SIBLING 
cpu0/domain0/max_newidle_lb_cost:1306
cpu0/domain1/max_newidle_lb_cost:1999
cpu0/domain2/max_newidle_lb_cost:0

# echo 5 > /sys/fs/cgroup/cpuset/cpuset.sched_relax_domain_level
bash: echo: write error: Invalid argument
=========================


The same system with the patch applied:
=========================
# cd /sys/kernel/debug/sched/domains
# echo -1 > /sys/fs/cgroup/cpuset/cpuset.sched_relax_domain_level
# grep . cpu0/*/{name,level,flags,groups_flags}
cpu0/domain0/name:SMT
cpu0/domain1/name:MC
cpu0/domain2/name:NUMA
cpu0/domain0/level:0
cpu0/domain1/level:2
cpu0/domain2/level:5
cpu0/domain0/flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC ...
cpu0/domain1/flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC ...
cpu0/domain2/flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC ...
cpu0/domain1/groups_flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC ...
cpu0/domain2/groups_flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC ...

# echo 0 > /sys/fs/cgroup/cpuset/cpuset.sched_relax_domain_level
# grep . cpu0/*/{flags,groups_flags}
cpu0/domain0/flags:SD_BALANCE_EXEC ...
cpu0/domain1/flags:SD_BALANCE_EXEC ...
cpu0/domain2/flags:SD_BALANCE_EXEC ...
cpu0/domain1/groups_flags:SD_BALANCE_EXEC ...
cpu0/domain2/groups_flags:SD_BALANCE_EXEC ...

# echo 1 > /sys/fs/cgroup/cpuset/cpuset.sched_relax_domain_level
# grep . cpu0/*/{flags,groups_flags}
cpu0/domain0/flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC ...
cpu0/domain1/flags:SD_BALANCE_EXEC ...
cpu0/domain2/flags:SD_BALANCE_EXEC ...
cpu0/domain1/groups_flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC ...
cpu0/domain2/groups_flags:SD_BALANCE_EXEC ...

[skip 2, same as 1]

# echo 3 > /sys/fs/cgroup/cpuset/cpuset.sched_relax_domain_level
# grep . cpu0/*/{flags,groups_flags}
cpu0/domain0/flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC ...
cpu0/domain1/flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC ...
cpu0/domain2/flags:SD_BALANCE_EXEC ...
cpu0/domain1/groups_flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC ...
cpu0/domain2/groups_flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC ...

[skip 4 and 5, same as 3]

# echo 6 > /sys/fs/cgroup/cpuset/cpuset.sched_relax_domain_level
# grep . cpu0/*/{flags,groups_flags}
cpu0/domain0/flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC ...
cpu0/domain1/flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC ...
cpu0/domain2/flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC ...
cpu0/domain1/groups_flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC ...
cpu0/domain2/groups_flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC ...

# echo 7 > /sys/fs/cgroup/cpuset/cpuset.sched_relax_domain_level
bash: echo: write error: Invalid argument
=========================

Vitalii Bursov (3):
  sched/fair: allow disabling sched_balance_newidle with
    sched_relax_domain_level
  sched/debug: dump domains' level
  docs: cgroup-v1: clarify that domain levels are system-specific

 Documentation/admin-guide/cgroup-v1/cpusets.rst | 7 ++++++-
 kernel/cgroup/cpuset.c                          | 2 +-
 kernel/sched/debug.c                            | 1 +
 kernel/sched/topology.c                         | 2 +-
 4 files changed, 9 insertions(+), 3 deletions(-)

-- 
2.20.1


