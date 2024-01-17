Return-Path: <linux-kernel+bounces-29073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CD58307E0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFBB0B24891
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7926B2032C;
	Wed, 17 Jan 2024 14:21:03 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD7D200CB
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 14:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705501263; cv=none; b=k8rbJOIB2lG/EcqajiD2dIFBjzrs+ySqHqT8LC9MBv1CNMeTrtlvytDXx4B/riAfmwCwuEuK9yFeZ6KDp9KIRinLxcvrXIjl0ofCaX9RKxB4yuvI0g9iR+if70qierPEuK+pkMrCEdTYXibyWmMYYTafqWLUCePEcfvlmlqKI+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705501263; c=relaxed/simple;
	bh=QTt3NxgnO3h06z8kuyBtWXpxxpfLImOSJaHvIQ9Cp4g=;
	h=Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:Content-Language:To:CC:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy; b=IojSjxRDXORDiMfi3F95CriWvin/fLQBU4nQwnpjPFxj8dcWtIUvy6fT84VvqXOXhACfH074NCKEMR7JxxI3U+PsZuqEh277IrALp9gvLhtylw72BYsk9So5ogNpQYsnIsBgl6PH/B9K6ixNlqNAJ/Yl7ZKLJb5IMjma64IQsvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TFSh410xQzsW0k;
	Wed, 17 Jan 2024 22:20:04 +0800 (CST)
Received: from dggpeml500004.china.huawei.com (unknown [7.185.36.140])
	by mail.maildlp.com (Postfix) with ESMTPS id 0DE1414053B;
	Wed, 17 Jan 2024 22:20:43 +0800 (CST)
Received: from [10.174.186.25] (10.174.186.25) by
 dggpeml500004.china.huawei.com (7.185.36.140) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 22:20:38 +0800
Message-ID: <89fe1503-6d62-90ca-5edb-e11c74846a00@huawei.com>
Date: Wed, 17 Jan 2024 22:20:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [bug report] GICv4.1: VM performance degradation due to not
 trapping vCPU WFI
Content-Language: en-US
To: Marc Zyngier <maz@kernel.org>
CC: <oliver.upton@linux.dev>, <yuzenghui@huawei.com>, <james.morse@arm.com>,
	<suzuki.poulose@arm.com>, <will@kernel.org>, <catalin.marinas@arm.com>,
	<wanghaibin.wang@huawei.com>, <kvmarm@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<jiangkunkun@huawei.com>
References: <a481ef04-ddd2-dfc1-41b1-d2ec45c6a3b5@huawei.com>
 <86v87t8ras.wl-maz@kernel.org>
From: "sundongxu (A)" <sundongxu3@huawei.com>
In-Reply-To: <86v87t8ras.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500004.china.huawei.com (7.185.36.140)

Hi Marc,

Thank you for your reply.

On 2024/1/16 19:13, Marc Zyngier wrote:
> On Tue, 16 Jan 2024 03:26:08 +0000,
> "sundongxu (A)" <sundongxu3@huawei.com> wrote:
>>
>> Hi Guys,
>>
>> We found a problem about GICv4/4.1, for example:
>> We use QEMU to start a VM (4 vCPUs and 8G memory), VM disk was
>> configured with virtio, and the network is configured with vhost-net,
>> the CPU affinity of the vCPU and emulator is as follows, in VM xml:
>>
>>   <cputune>
>>     <vcpupin vcpu='0' cpuset='4'/>
>>     <vcpupin vcpu='1' cpuset='5'/>
>>     <vcpupin vcpu='2' cpuset='6'/>
>>     <vcpupin vcpu='3' cpuset='7'/>
>>     <emulatorpin cpuset='4,5,6,7'/>
>>   </cputune>
>>
>> Running Mysql in the VM, and sysbench (Mysql benchmark) on the host,
>> the performance index is tps, the higher the better.
>> If the host only enabled GICv3, the tps will be around 1400.
>> If the host enabled GICv4.1, other configurations remain unchanged, the
>> tps will be around 40.
>>
>> We found that when the host enabled GICv4.1, because vSGI is directly
>> injected to VM, and most time vCPU exclusively occupy the pCPU, vCPU
>> will not trap when executing the WFI instruction. Then from the host
>> view, the CPU usage of vCPU0~vCPU3 is almost 100%. When running mysql
>> service in VM, the vhost-net and qemu processes also need to obtain
>> enough CPU time, but unfortunately these processes cannot get that much
>> time (for example, only GICv3 enabled, the cpu usage of vhost-net is
>> about 43%, but with GICv4.1 enabled, it becomes 0~2%). During the test,
>> it was found that vhost-net sleeps and wakes up very frequently. When
>> vhost-net wakes up, it often cannot obtain CPU in time (because of
>> wake-up preemption check). After waking up, vhost-net will usually run
>> for a short period of time before going to sleep again.
> 
> Can you elaborate on this preemption check issue?

Well, I forgot to post the version of my kernel(5.10).
I've noticed that the scheduler of mainline kernel is EEVDF, while my
kernel's scheduler is still CFS. I feel sorry if my report misled you.

With the CFS scheduler, if vhost-net thread wake-up, the scheduler
need to check whether vhost-net could preempt vCPU
(check_preempt_wakeup->wakeup_preempt_entity).
From my understanding, if vhost-net want to run on CPU，the conditions
need to meet：
1. the difference between vhost-net's vruntime and current running
thread's vruntime exceeds sched_wakeup_granularity_ns (in my host,
it's 15ms, and the sched_latency_ns is 24ms).
2. If condition 1 is not met, the CFS scheduler thinks vhost-net
should not preempt current thread, the vhost-net will be enqueued and
wait for the tick preempt check. In tick preempt check, the vhost-net
could run when the growth of current thread vruntime is already higher
than sched_min_granularity_ns (in my host, it's 10ms), since the last
time current thread was preempted.
So, if vhost-net wake-up preemption fails, it needs to wait for a
while, but in the meantime, maybe vCPU is just running WFI.

Frankly, the sched_wakeup_granularity_ns (default 4ms) and
sched_wakeup_granularity_ns(default 3ms) are set too high, So I reset
these parameters to default value and test again. Here is the result:
If the host enabled GICv3, the tps will be around 1300.
If the host enabled GICv4.1 with WFI no trapping, the tps will be
around 235.

I tested the kernel 6.5rc2 (git checkout 752182b24bf4), it has the
same issue.

And I also tested it in mainline kernel (6.7, with EEVDF), the result
as below:
If the host only enabled GICv3, the tps will be around 377.
If the host enabled GICv4.1 with WFI no trapping, the tps will be
around 323.
If the host enabled GICv4.1 with WFI trapping, the tps will be around
387.
With host enabled GICv3 the tps is much lower than when the scheduler
is CFS. Looks like there's a serious issue, but I haven't found it yet.

> 
>>
>> If the host enabled GICv4.1, and force vCPU to trap when executing WFI,
>> the tps will be around 1400.
>>
>> On the other hand, when vCPU executes WFI instruction without trapping,
>> the vcpu wake-up delay will be significantly improved. For example, the
>> result of running cyclictest in VM:
>> WFI trap           6us
>> WFI no trap        2us
>>
>> Currently, I add a KVM module parameter to control whether the vCPU
>> traps (by set or clear HCR_TWI) when executing the WFI instruction with
>> host enabled GICv4/4.1, and by default, vCPU traps are set.
>>
>> Or, it there a better way?
> 
> As you foudn out, KVM has an adaptive way of dealing with HCR_TWI,
> turning it off when the vcpu is alone in the run queue. Which means it
> doesn't compete with any other thread. How comes the other threads
> don't register as being runnable?

Actually，other threads is registered as runnable，but they may not get
CPU immediately. 

> 
> Effectively, we apply the same principle to vSGIs as to vLPIs, and it
> was found that this heuristic was pretty beneficial to vLPIs. I'm a
> bit surprised that vSGIs are so different in their usage pattern.

IMO, the point is hypervisor not trapping vCPU WFI, rather than
vSGI/vLPI usage pattern.

> 
> Does it help if you move your "emulatorpin" to some other physical
> CPUs?

Yes，it does, in kernel 5.10 or 6.5rc1.

Thanks,
	Dongxu
> 
> Thanks,
> 
> 	M.
> 


