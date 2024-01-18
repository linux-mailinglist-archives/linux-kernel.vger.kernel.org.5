Return-Path: <linux-kernel+bounces-29786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAE783136D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FC30283401
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6D1C126;
	Thu, 18 Jan 2024 07:56:37 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111C6125A6
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 07:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705564596; cv=none; b=qXQHHIIoh/h2HNBt57V5xZVDOaCOAzYwbmG9uO/J7h2UraXX/bN0RguUnQMd38sRcIepPdOws+Qc5q8fwnWHqYrM3FAsDc+UQJDjSoIKVBAx1XyERjQ0FArulbya12szNDn6Xd/HgRtMFzyS2r7Gc2CjlauNU8tcOFepZ26cjdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705564596; c=relaxed/simple;
	bh=2hcdQMhALmEHs/B/xSjTTqqDn29RnDN9oet6bHzzXrU=;
	h=Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:CC:References:Content-Language:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy; b=HxPlH35SBp2Y0lpedg89pMFtvrnxTLDhbWuDok8UotUJrTmTlwUSweH+9qLKazrPEzWCEqqG5uqgq57BICE/juUwR0KBB+fNQgVnTGMT3WsL/2MuFrcKj9Gukq4mUvncIOukKPH4a/tuJcuU0PAWJsTawrdM8Ett9Ho/yaDbM5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TFw5756ghz29kLB;
	Thu, 18 Jan 2024 15:54:51 +0800 (CST)
Received: from dggpeml500004.china.huawei.com (unknown [7.185.36.140])
	by mail.maildlp.com (Postfix) with ESMTPS id 9EE571A0172;
	Thu, 18 Jan 2024 15:56:30 +0800 (CST)
Received: from [10.174.186.25] (10.174.186.25) by
 dggpeml500004.china.huawei.com (7.185.36.140) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 15:56:30 +0800
Message-ID: <6572d6eb-a3f0-445b-8167-13d0600dd7e8@huawei.com>
Date: Thu, 18 Jan 2024 15:56:27 +0800
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
To: Oliver Upton <oliver.upton@linux.dev>
CC: Marc Zyngier <maz@kernel.org>, <yuzenghui@huawei.com>,
	<james.morse@arm.com>, <suzuki.poulose@arm.com>, <will@kernel.org>,
	<catalin.marinas@arm.com>, <wanghaibin.wang@huawei.com>,
	<kvmarm@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <jiangkunkun@huawei.com>
References: <a481ef04-ddd2-dfc1-41b1-d2ec45c6a3b5@huawei.com>
 <86v87t8ras.wl-maz@kernel.org>
 <89fe1503-6d62-90ca-5edb-e11c74846a00@huawei.com>
 <ZagFVNsA1aLuxorp@linux.dev>
Content-Language: en-US
From: "sundongxu (A)" <sundongxu3@huawei.com>
In-Reply-To: <ZagFVNsA1aLuxorp@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500004.china.huawei.com (7.185.36.140)

On 2024/1/18 0:50, Oliver Upton wrote:
> On Wed, Jan 17, 2024 at 10:20:32PM +0800, sundongxu (A) wrote:
>> On 2024/1/16 19:13, Marc Zyngier wrote:
>>> On Tue, 16 Jan 2024 03:26:08 +0000, "sundongxu (A)" <sundongxu3@huawei.com> wrote:
>>>> We found a problem about GICv4/4.1, for example:
>>>> We use QEMU to start a VM (4 vCPUs and 8G memory), VM disk was
>>>> configured with virtio, and the network is configured with vhost-net,
>>>> the CPU affinity of the vCPU and emulator is as follows, in VM xml:
> 
> <snip>
> 
>>>>   <cputune>
>>>>     <vcpupin vcpu='0' cpuset='4'/>
>>>>     <vcpupin vcpu='1' cpuset='5'/>
>>>>     <vcpupin vcpu='2' cpuset='6'/>
>>>>     <vcpupin vcpu='3' cpuset='7'/>
>>>>     <emulatorpin cpuset='4,5,6,7'/>
>>>>   </cputune>
> 
> </snip>
> 
>>> Effectively, we apply the same principle to vSGIs as to vLPIs, and it
>>> was found that this heuristic was pretty beneficial to vLPIs. I'm a
>>> bit surprised that vSGIs are so different in their usage pattern.
>>
>> IMO, the point is hypervisor not trapping vCPU WFI, rather than
>> vSGI/vLPI usage pattern.
> 
> Sure, that's what's affecting your use case, but the logic in the kernel
> came about because improving virtual interrupt injection has been found
> to be generally useful.
> 
>>>
>>> Does it help if you move your "emulatorpin" to some other physical
>>> CPUs?
>>
>> Yes，it does, in kernel 5.10 or 6.5rc1.
> 
> Won't your VM have a poor experience in this configuration regardless of WFx
> traps? The value of vCPU pinning is to *isolate* the vCPU threads from
> noise/overheads of the host and scheduler latencies. Seems to me that
> VMM overhead threads are being forced to take time away from the guest.

When the emulators and vCPUs have affinity on same CPUs, the VM
performance is worse than when emulators and vCPUs have affinity on
different CPUs. Emulators will steal time from vCPU, since we need them
to deal with some IO/net requests. If we allocate 4 pCPUs to one VM, we
do not want it's emulators to run on other pCPU, which may interfere
with other VMs. May be SPDK/DPDK will alleviate the issue.

> 
> Nevertheless, disabling WFI traps isn't going to work well for
> overcommitted scenarios. The thought of tacking on more hacks in KVM has be
> a bit uneasy, perhaps instead we can give userspace an interface to explicitly
> enable/disable WFx traps and let it pick a suitable policy.

Agreed, I added a KVM parameter to do that, and default trapping vCPU WFI.

Thanks,
	Dongxu


