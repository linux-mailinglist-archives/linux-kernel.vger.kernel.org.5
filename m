Return-Path: <linux-kernel+bounces-123226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EE98904C5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6CCA298525
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8CF12F360;
	Thu, 28 Mar 2024 16:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bursov.com header.i=vitaly@bursov.com header.b="tr4BIZvH"
Received: from sender-of-o51.zoho.eu (sender-of-o51.zoho.eu [136.143.169.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09D012F5BE
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 16:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711642656; cv=pass; b=iJPnbFYa/vgDr96oZZdLMKlVNcM55aJVYwMPSkl9oFou/gJ1YQsDhSaYm44FPf9qFFpqGeRgCFfgy3xTbPtFyDHylTY3KGiOPOKQVyFTmmVAgDcxY8Ccn/+RArbbz8ttDo/bZHtkyvZby7Sp9Hv5TiCkGzwf4uRPxwoYWnZdIGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711642656; c=relaxed/simple;
	bh=gknboZ9VLfFibIr5GpDjvhiL04nyLirhlWJTroxz5nM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rp4Jem9gewVIjRCyLGIPRrv05MGqpSC32Y51a47Z7aIb6A7WfT1ogWbxQZKhbt72FgArCXyBqND0IHlqoekXRKHRZQMOeXCBZKR7jd+zuVmPvHXPT/TwcWRDt7+jT0xLUAN5Rb1fB6+FeBpPKnm3hF9w3kOhrjH2a+AsRkUdBEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bursov.com; spf=pass smtp.mailfrom=bursov.com; dkim=pass (1024-bit key) header.d=bursov.com header.i=vitaly@bursov.com header.b=tr4BIZvH; arc=pass smtp.client-ip=136.143.169.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bursov.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bursov.com
ARC-Seal: i=1; a=rsa-sha256; t=1711642647; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=ecNS74Hj9GkESSpC4oUlxx7bgHc6TxO1XSUHZZzepPXxV1p3CPkCMICrHvR97Uq65ImAt6NBnfhhKihrZLxH2sysl46a52e0NyukboAM8mKbgpSIFU9sAeDaKht786IEDOWzRi/99X3ETAEw/mdHl3ULI4OgDZAkNjaaTZR/8dY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1711642647; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/3k01wFQYd9N4aYBAzoi47ZmUyAsnxRiLt/UYoqv2y8=; 
	b=RwwOAzW/qDeeZ26VxL1ttcb17v2nsN2UoOYUo+rlqVCZXJ6TfVXJju6ge86BySFsr3/qVkVohF6bjHNC/fXoVkzWovWNVe9cgGDh6lPiRFgkfMVK2A3ZBTmx2hMaImqR0vFv20ilix5VHUP+cp53E3zgoBQtWveVeBpmqTPiY2Y=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=bursov.com;
	spf=pass  smtp.mailfrom=vitaly@bursov.com;
	dmarc=pass header.from=<vitaly@bursov.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1711642647;
	s=zoho; d=bursov.com; i=vitaly@bursov.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=/3k01wFQYd9N4aYBAzoi47ZmUyAsnxRiLt/UYoqv2y8=;
	b=tr4BIZvHxU9oWLFLYLLYVxWJJj3YEgaM2c/qOYx+DcRZaRC+MXyt9Io3If0ND1gK
	/AdGuEIfiGhRW67rZnKYTpZZlAT/1AfZQ70dYRmMk/do3crr8RkPorLPyjyA4zpgBgb
	berLdxqAwsNHi+pKDzXxoxgR0iZBD2llH45br6x8=
Received: from [192.168.11.99] (217.20.170.230 [217.20.170.230]) by mx.zoho.eu
	with SMTPS id 1711642645855196.55526618397528; Thu, 28 Mar 2024 17:17:25 +0100 (CET)
Message-ID: <94c1c0d1-43c1-478e-9a98-188cd85803c9@bursov.com>
Date: Thu, 28 Mar 2024 18:17:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] sched/fair: allow disabling newidle_balance with
 sched_relax_domain_level
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org
References: <cover.1711584739.git.vitaly@bursov.com>
 <29b1db65-03c6-41a6-8556-f788c4161efd@linux.ibm.com>
Content-Language: en-US, ru-RU, uk-UA
From: Vitalii Bursov <vitaly@bursov.com>
In-Reply-To: <29b1db65-03c6-41a6-8556-f788c4161efd@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External


On 28.03.24 07:48, Shrikanth Hegde wrote:
> 
> 
> On 3/28/24 6:17 AM, Vitalii Bursov wrote:
>> Hi,
>>
>> During the upgrade from Linux 5.4 we found a small (around 3%) 
>> performance regression which was tracked to commit 
> 
> You see the regression since it is doing more newidle balance? 

In some sense, yes.

Before this commit or with this commit reverted on newer kernels,
newidle balance almost never called in this code path because
sysctl_sched_migration_cost is too high (it's set to 5ms by tuned
in "performance" profiles).

So, it's not exactly more, my understanding is that it had started
working on this and similar servers.

When it's working, perf for the process and kernel shows:
* slightly more (+10%), or much more cpu-migrations (10x or more).
It looks like new migrations come from futex syscalls in our case.
* more "cycles" and "instructions", which is understandable, as
newidle requires some work to be done. However, IPC ratio falls.
* more L1 and L2 load misses.
(I haven't checked other performance counters on this CPU)

The above certainly depends on a workload, and it concerns a specific
case when we see the overall performance regression. Perhaps, all
mentioned factors and consequences contribute. For example,
additional cache pressure may have a higher negative impact than the
benefit of newidle, but I don't know if it's the case exactly.

We haven't tried running a production workload with newidle restricted
only to SMP level yet, but a synthetic test (which may be totally
different from our real workload) shows that it is possible for SMP
newidle to be a little better compared to when it's fully disabled.
About 0.5% better in the test case instead of 1.5% worse when fully
enabled.

>> c5b0a7eefc70150caf23e37bc9d639c68c87a097
>>
>>     sched/fair: Remove sysctl_sched_migration_cost condition
>>
>>     With a default value of 500us, sysctl_sched_migration_cost is
>>     significanlty higher than the cost of load_balance. Remove the
>>     condition and rely on the sd->max_newidle_lb_cost to abort
>>     newidle_balance.
>>
>>
>> Looks like "newidle" balancing is beneficial for a lot of workloads, 
>> just not for this specific one. The workload is video encoding, there 
>> are 100s-1000s of threads, some are synchonized with mutexes and
> 
> s/synchonized/synchronized/
Thanks

>> conditional variables. The process aims to have a portion of CPU idle, 
>> so no CPU cores are 100% busy. Perhaps, the performance impact we see 
>> comes from additional processing in the scheduler and additional cost 
>> like more cache misses, and not from an incorrect balancing. See
>> perf output below.
>>
>> My understanding is that "sched_relax_domain_level" cgroup parameter 
>> should control if newidle_balance() is called and what's the scope
> 
> s/newidle_balance()/sched_balance_newidle()   at all the places since the 
> name has been changed recently. Thanks

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
>>
> 
> I think this document needs to be updated. levels need not be serial order 
> due to sched domains degenation. It should have a paragraph which tells the user
> to take a look at /sys/kernel/debug/sched/domains/cpu*/domain*/ for system 
> specific details. 
> 
Agree, it's little confusing. I can add something like this.
Thanks

>> Setting cpuset.sched_relax_domain_level to 0 works as 1.
>>
>> On a dual-CPU server, domains and levels are as follows:
>>   domain 0: level 0, SMT
>>   domain 1: level 2, MC
>>   domain 2: level 5, NUMA
>>
>> So, to support "0 no search", the value in 
>> cpuset.sched_relax_domain_level should disable SD_BALANCE_NEWIDLE for a 
>> specified level and keep it enabled for prior levels. For example, SMT 
>> level is 0, so sched_relax_domain_level=0 should exclude levels >=0.
>>
>> Instead, cpuset.sched_relax_domain_level enables the specified level,
>> which effectively removes "no search" option. See below for domain
>> flags for all cpuset.sched_relax_domain_level values.
>>
>> Proposed patch allows clearing SD_BALANCE_NEWIDLE flags when 
>> cpuset.sched_relax_domain_level is set to 0 and extends max
>> value validation range beyond sched_domain_level_max. This allows
>> setting SD_BALANCE_NEWIDLE on all levels and override platform
>> default if it does not include all levels.
>>

