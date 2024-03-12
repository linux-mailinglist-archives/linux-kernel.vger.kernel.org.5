Return-Path: <linux-kernel+bounces-100591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 704F4879A88
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 259FD281D9C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A5C138499;
	Tue, 12 Mar 2024 17:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="mLp1Ekhg"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEADC138483
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 17:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710263971; cv=none; b=m2HsNy701y8bVW66CU4rN0zdjR2jyM6zL8Sgw59SQLCdaouV+I9V0uSdOgWHLu2AQV/qbzcNsJMGaQjiBf964TdOE9VDi0/Eob8eNY9hRKzMsgnWI3WzX5olitH7lubrvkG1TuozkguettEZ8FHfZGG3gYQAFUic/f9DCFJaiVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710263971; c=relaxed/simple;
	bh=hdtuhTEpAOXd9JCt1DPtGZWNz6gzkTQigsXJb9JT4bY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Hqa/5Ee0fiTbtD6z9qaRS8SaAMl222BHEDlCUkZndjEQs6H78h5u0QUR59Jxhwqz8AbWOo/ldBWUS3mIDQUKfxIhIqaFUUR6RDYYzpP3awvyhUDiOSl1dplviB3tZiQ9xfGplPyQJEtYHY4DKRUlpqKO7ZvjwIlgBwF1PjVX0zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=mLp1Ekhg; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8002:4640:7285:c2ff:fefb:fd4] ([IPv6:2601:646:8002:4640:7285:c2ff:fefb:fd4])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 42CHIGVW1562136
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 12 Mar 2024 10:18:16 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 42CHIGVW1562136
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024021201; t=1710263899;
	bh=Qe3oFmqY5MEQgBRHG9tAoiRCX5zfTbErpUtF36h8c24=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=mLp1EkhgGinRLcAGo8uGBaxXRz4LyCYuneOqQidnn7SHNigpbVDY+9R9UYgZaugvz
	 pybLWZ5O1JTDCT4asghe5oUkn6PLjyI/zfGKtfiwR5bN4zqH9pRFu90V+e88Aebqp2
	 vszN1QorH3ASTGbSs4NJ5WS1jmYrdiI0HWqDN2dFYjbIGrmJY68nFyzsJFMdMpfPcZ
	 p0LUGdVWGyBe3LoXS2WoQkQ/ea0HIp1eUXwRnqkBiTiIDXE+WV2By5fA4lbPCQEbB+
	 CcWgj1ozJ4SJm3cdsS8LRFyiI4ADdFFe/NIsv56OqXZwHXXQLSFDnY14wTBYTp4UTd
	 YH5rvrAVUJrZQ==
Message-ID: <2cb8f02d-f21e-45d2-afe2-d1c6225240f3@zytor.com>
Date: Tue, 12 Mar 2024 10:18:10 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 00/14] Dynamic Kernel Stacks
Content-Language: en-US
To: Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, x86@kernel.org,
        bp@alien8.de, brauner@kernel.org, bristot@redhat.com,
        bsegall@google.com, dave.hansen@linux.intel.com, dianders@chromium.org,
        dietmar.eggemann@arm.com, eric.devolder@oracle.com, hca@linux.ibm.com,
        hch@infradead.org, jacob.jun.pan@linux.intel.com, jgg@ziepe.ca,
        jpoimboe@kernel.org, jroedel@suse.de, juri.lelli@redhat.com,
        kent.overstreet@linux.dev, kinseyho@google.com,
        kirill.shutemov@linux.intel.com, lstoakes@gmail.com, luto@kernel.org,
        mgorman@suse.de, mic@digikod.net, michael.christie@oracle.com,
        mingo@redhat.com, mjguzik@gmail.com, mst@redhat.com, npiggin@gmail.com,
        peterz@infradead.org, pmladek@suse.com, rick.p.edgecombe@intel.com,
        rostedt@goodmis.org, surenb@google.com, tglx@linutronix.de,
        urezki@gmail.com, vincent.guittot@linaro.org, vschneid@redhat.com
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/11/24 09:46, Pasha Tatashin wrote:
> This is follow-up to the LSF/MM proposal [1]. Please provide your
> thoughts and comments about dynamic kernel stacks feature. This is a WIP
> has not been tested beside booting on some machines, and running LKDTM
> thread exhaust tests. The series also lacks selftests, and
> documentations.
> 
> This feature allows to grow kernel stack dynamically, from 4KiB and up
> to the THREAD_SIZE. The intend is to save memory on fleet machines. From
> the initial experiments it shows to save on average 70-75% of the kernel
> stack memory.
> 
> The average depth of a kernel thread depends on the workload, profiling,
> virtualization, compiler optimizations, and driver implementations.
> However, the table below shows the amount of kernel stack memory before
> vs. after on idling freshly booted machines:
> 
> CPU           #Cores #Stacks  BASE(kb) Dynamic(kb)   Saving
> AMD Genoa        384    5786    92576       23388    74.74%
> Intel Skylake    112    3182    50912       12860    74.74%
> AMD Rome         128    3401    54416       14784    72.83%
> AMD Rome         256    4908    78528       20876    73.42%
> Intel Haswell     72    2644    42304       10624    74.89%
> 
> Some workloads with that have millions of threads would can benefit
> significantly from this feature.
> 

Ok, first of all, talking about "kernel memory" here is misleading. 
Unless your threads are spending nearly all their time sleeping, the 
threads will occupy stack and TLS memory in user space as well.

Second, non-dynamic kernel memory is one of the core design decisions in 
Linux from early on. This means there are lot of deeply embedded 
assumptions which would have to be untangled.

Linus would, of course, be the real authority on this, but if someone 
would ask me what the fundamental design philosophies of the Linux 
kernel are -- the design decisions which make Linux Linux, if you will 
-- I would say:

	1. Non-dynamic kernel memory
	2. Permanent mapping of physical memory
	3. Kernel API modeled closely after the POSIX API
	   (no complicated user space layers)
	4. Fast system call entry/exit (a necessity for a
	   kernel API based on simple system calls)
	5. Monolithic (but modular) kernel environment
	   (not cross-privilege, coroutine or message passing)

Third, *IF* this is something that should be done (and I personally 
strongly suspect it should not), at least on x86-64 it probably should 
be for FRED hardware only. With FRED, it is possible to set the #PF 
event stack level to 1, which will cause an automatic stack switch for 
#PF in kernel space (only). However, even in kernel space, #PF can sleep 
if it references a user space page, in which case it would have to be 
demoted back onto the ring 0 stack (there are multiple ways of doing 
that, but it does entail an overhead.)

	-hpa

