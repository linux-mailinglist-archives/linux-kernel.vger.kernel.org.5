Return-Path: <linux-kernel+bounces-132819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDBC899AAD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01E8A1F21C92
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2121649B3;
	Fri,  5 Apr 2024 10:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bursov.com header.i=vitaly@bursov.com header.b="oKAdne5q"
Received: from sender-of-o59.zoho.eu (sender-of-e59.zoho.eu [136.143.169.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D6C142E73
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 10:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712312750; cv=pass; b=KuZBQemVhM/QhSgdTIzlCUDQ5LqbZQSu0bUjRMvq3EhYJZBfRfqB2H/F96r4UEQ/Tn33SMiXXlP9ipY7s+qyxB6V11fjiGkM2ejhzIfmyc49WrYzANZ7NCDi7rh8zb8wh/QnixLDPmam9VzIH0yA3K4T82/QA3cr9lhFgpvB2WA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712312750; c=relaxed/simple;
	bh=NzdroCERlTyOQBlWosl8EB63jaS7KRU4sBGAquMymM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LW7R5KUovP5C6VsAwZXyYjf+Lq12yyLoU6PhG/ETEhcHhWtyKYKryz/Nej6yUPgvSt9MqJJTTzBKi4770GSSz2kVKJuJVSz1SF03Su8tzjKT/M9BbzXnanjGdtCB5qdCtzhRiy3qgfloIMetQ9Q41A9yp/wv/I35UTB4KaAk5lU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bursov.com; spf=pass smtp.mailfrom=bursov.com; dkim=pass (1024-bit key) header.d=bursov.com header.i=vitaly@bursov.com header.b=oKAdne5q; arc=pass smtp.client-ip=136.143.169.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bursov.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bursov.com
ARC-Seal: i=1; a=rsa-sha256; t=1712312719; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=dvD9oHOGrjAyfvwXKrhGBV1kb6ct+tcPpF5MAIMBnlgJwsF3LPr/L2iNJ8KHSXPuwJ6Pu+CV0x3/Xm7rphqaixgc0foSsAnjKk/yxBd/DwPsGHWGWKcE78WsWHvIOLRgpxr5xPicufk+3SVykz3OxyhJB1E0vDXJMkjdmFhb7us=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1712312719; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=1zrzCwcvIoCSICK/9sPQ4pofoixARvk+ZlTPe2a/G50=; 
	b=EEUHIsvIH2vBqXHYCxp/tq3DArVCr9wjEMKPMBQYjKC+SZBJuiPnMP7aFtCPYP69V8KspnyrgLOuHgy6RYxQUDBAiDgN/l/mZUZw788/3+xRP9uEOw9p2a3J8qG2GjdwN4zSqvknlc1zxH5yFYjIu158uXpHVHwLdCkkIA3kjyM=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=bursov.com;
	spf=pass  smtp.mailfrom=vitaly@bursov.com;
	dmarc=pass header.from=<vitaly@bursov.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1712312719;
	s=zoho; d=bursov.com; i=vitaly@bursov.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=1zrzCwcvIoCSICK/9sPQ4pofoixARvk+ZlTPe2a/G50=;
	b=oKAdne5qrietXlmYE1zMpP7OsVfwI5dWM5fA7FihDghFsoDdGGKY5FPglJA6ArYp
	GJUdZ/+MSvXWuEgGtiHzWLUpYMXqeOKo987R12rVMV6O3pkO6y9Yp1NzWlVIOp5ySrK
	bDHABwPGg/EjxjmRZBr6jnqhsPjx5Vj4uuqQZ4Pg=
Received: from [192.168.11.99] (92.60.179.150 [92.60.179.150]) by mx.zoho.eu
	with SMTPS id 171231271894851.33875152371024; Fri, 5 Apr 2024 12:25:18 +0200 (CEST)
Message-ID: <87543226-1edd-4692-84b5-31bac9cb0c5d@bursov.com>
Date: Fri, 5 Apr 2024 13:25:17 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] sched/fair: allow disabling sched_balance_newidle
 with sched_relax_domain_level
To: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org, Shrikanth Hegde <sshegde@linux.ibm.com>
References: <cover.1712147341.git.vitaly@bursov.com>
 <3bf726af-e519-4cc2-a692-19a0cf99fca7@arm.com>
Content-Language: en-US, ru-RU, uk-UA
From: Vitalii Bursov <vitaly@bursov.com>
In-Reply-To: <3bf726af-e519-4cc2-a692-19a0cf99fca7@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External



On 05.04.24 12:17, Dietmar Eggemann wrote:
> On 03/04/2024 15:28, Vitalii Bursov wrote:
>> Changes in v3:
>> - Remove levels table change from the documentation patch
>> - Link to v2: https://lore.kernel.org/lkml/cover.1711900396.git.vitaly@bursov.com/
>> Changes in v2:
>> - Split debug.c change in a separate commit and move new "level"
>> after "groups_flags"
>> - Added "Fixes" tag and updated commit message
>> - Update domain levels cgroup-v1/cpusets.rst documentation
>> - Link to v1: https://lore.kernel.org/all/cover.1711584739.git.vitaly@bursov.com/
>>
>> During the upgrade from Linux 5.4 we found a small (around 3%) 
>> performance regression which was tracked to commit 
>> c5b0a7eefc70150caf23e37bc9d639c68c87a097
>>
>>     sched/fair: Remove sysctl_sched_migration_cost condition
>>
>>     With a default value of 500us, sysctl_sched_migration_cost is
>>     significanlty higher than the cost of load_balance. Remove the
>>     condition and rely on the sd->max_newidle_lb_cost to abort
>>     newidle_balance.
>>
>> Looks like "newidle" balancing is beneficial for a lot of workloads, 
>> just not for this specific one. The workload is video encoding, there 
>> are 100s-1000s of threads, some are synchronized with mutexes and 
>> conditional variables. The process aims to have a portion of CPU idle, 
>> so no CPU cores are 100% busy. Perhaps, the performance impact we see 
>> comes from additional processing in the scheduler and additional cost 
>> like more cache misses, and not from an incorrect balancing. See
>> perf output below.
>>
>> My understanding is that "sched_relax_domain_level" cgroup parameter 
>> should control if sched_balance_newidle() is called and what's the scope
>> of the balancing is, but it doesn't fully work for this case.
>>
>> cpusets.rst documentation:
>>> The 'cpuset.sched_relax_domain_level' file allows you to request changing
>>> this searching range as you like.  This file takes int value which
>>> indicates size of searching range in levels ideally as follows,
>>> otherwise initial value -1 that indicates the cpuset has no request.
>>>  
>>> ====== ===========================================================
>>>   -1   no request. use system default or follow request of others.
>>>    0   no search.
>>>    1   search siblings (hyperthreads in a core).
>>>    2   search cores in a package.
>>>    3   search cpus in a node [= system wide on non-NUMA system]
>>>    4   search nodes in a chunk of node [on NUMA system]
>>>    5   search system wide [on NUMA system]
>>> ====== ===========================================================
> 
> IMHO, this list misses: 
> 
>       2   search cores in a cluster.
> 
> Related to CONFIG_SCHED_CLUSTER.
> Like you mentioned, if CONFIG_SCHED_CLUSTER is not configured MC becomes
> level=1.

Previous discussion in v2 on this topic:
https://lore.kernel.org/linux-kernel/78c60269-5aee-45d7-8014-2c0188f972da@bursov.com/T/#maf4ad0ef3b8c18c8bb3e3524c683b6459c6f7f64

The table certainly depends on the kernel configuraion and describing this
dependency in detail probably isn't worth it, so how the table should look
like in the documentation is debatable...

> I ran this on an Arm64 TaiShan 2280 v2, Kunpeng 920 - 4826 server:
> 
> $ numactl -H | tail -6
> node distances:
> node   0   1   2   3 
>   0:  10  12  20  22 
>   1:  12  10  22  24 
>   2:  20  22  10  12 
>   3:  22  24  12  10
> 
> $ head -8 /proc/schedstat | awk '{ print $1 " " $2 }' | tail -5
> domain0 00000000,00000000,0000000f
> domain1 00000000,00000000,00ffffff
> domain2 00000000,0000ffff,ffffffff
> domain3 000000ff,ffffffff,ffffffff
> domain4 ffffffff,ffffffff,ffffffff
> 
> with additional debug:
> 
> [   18.196484] build_sched_domain() cpu=0 name=SMT level=0
> [   18.202308] build_sched_domain() cpu=0 name=CLS level=1
> [   18.208188] build_sched_domain() cpu=0 name=MC level=2
> [   18.222550] build_sched_domain() cpu=0 name=PKG level=3
> [   18.228371] build_sched_domain() cpu=0 name=NODE level=4
> [   18.234515] build_sched_domain() cpu=0 name=NUMA level=5
> [   18.246400] build_sched_domain() cpu=0 name=NUMA level=6
> [   18.258841] build_sched_domain() cpu=0 name=NUMA level=7
> 
> /* search cores in a cluster */
> # echo 2 > /sys/fs/cgroup/cpuset/cpuset.sched_relax_domain_level
> 
> # grep . /sys/kernel/debug/sched/domains/cpu0/*/{name,flags,level}
> /sys/kernel/debug/sched/domains/cpu0/domain0/name:CLS
> /sys/kernel/debug/sched/domains/cpu0/domain1/name:MC
> /sys/kernel/debug/sched/domains/cpu0/domain2/name:NUMA
> /sys/kernel/debug/sched/domains/cpu0/domain3/name:NUMA
> /sys/kernel/debug/sched/domains/cpu0/domain4/name:NUMA
> /sys/kernel/debug/sched/domains/cpu0/domain0/flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_CLUSTER SD_SHARE_LLC SD_PREFER_SIBLING 
> /sys/kernel/debug/sched/domains/cpu0/domain1/flags:SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SHARE_LLC SD_PREFER_SIBLING 
> /sys/kernel/debug/sched/domains/cpu0/domain2/flags:SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SERIALIZE SD_OVERLAP SD_NUMA 
> /sys/kernel/debug/sched/domains/cpu0/domain3/flags:SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SERIALIZE SD_OVERLAP SD_NUMA 
> /sys/kernel/debug/sched/domains/cpu0/domain4/flags:SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SERIALIZE SD_OVERLAP SD_NUMA 
> /sys/kernel/debug/sched/domains/cpu0/domain0/level:1
> /sys/kernel/debug/sched/domains/cpu0/domain1/level:2
> /sys/kernel/debug/sched/domains/cpu0/domain2/level:5
> /sys/kernel/debug/sched/domains/cpu0/domain3/level:6
> /sys/kernel/debug/sched/domains/cpu0/domain4/level:7
> 
> LGTM.
> 
> Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
>  
>> Setting cpuset.sched_relax_domain_level to 0 works as 1.
>>
>> On a dual-CPU server, domains and levels are as follows:
>>   domain 0: level 0, SMT
>>   domain 1: level 2, MC
> 
> This is with CONFIG_SCHED_CLUSTER=y ?
> 
Yes, I tested mostly with RHEL9 and Debian12 configs on (some) x86-64
and those have CONFIG_SCHED_CLUSTER=y, but no separate CLS domain.

Thanks


