Return-Path: <linux-kernel+bounces-100812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F954879D8C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DDC41F224CC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6237143734;
	Tue, 12 Mar 2024 21:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="SzI4tb33"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645DC4CDE0
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 21:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710279473; cv=none; b=qbfUF388vu4JQZJUTKFaEljCYPL+qKOfuQ4keq2zn4jxOB8Wq84z6DwsewGxqmKjQUIXXBMijwZ36m2pRLAtD0MXu/vMhP4xwNGQNJ2d7yhJ3p9nFkAsWKzhSQNUn4/CZGzIuVFBui0pFS8LdJT4dixxTPALyOsdhyIh8ArWOmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710279473; c=relaxed/simple;
	bh=KYZS8k9mVRtK7VpRUxpvKuIvX9l0yqURCDNIPiro8Pw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eFGnYRcmu3C6OcBRTNKV6eTLkfhpj2dG0kBGLYFAcrDM36PIlZizAHdkWtYmDEQPfhspEtMgkbCTMHf7QP1vF7JbfxBhnTSe9ZtHEyKKKYDvtpCu6kLzX8rPw0PwlKbp7cbkqiFyhN/vdb5vRi4nrtQGbKHVYsOcH/Q4qBoyKd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=SzI4tb33; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8002:4640:7285:c2ff:fefb:fd4] ([IPv6:2601:646:8002:4640:7285:c2ff:fefb:fd4])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 42CLaWIK1697040
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 12 Mar 2024 14:36:33 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 42CLaWIK1697040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024021201; t=1710279397;
	bh=RJ6XaDgEz2DLax9EMzFHq+cdHoLC0FUJtliEoq1/zbc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SzI4tb33XKwcapGVtECc4PFS1Mg6xwLKcQe85zGUfzhNscSAFhHM+mpedeoD9/Mnw
	 ttyeN60qWpkCDe+8ZbUGpbEU7MQ2IYgDiIydtsWVa/QNBe0FoAQwD8Q9txbUIJErF3
	 nMyZqkcLHfAuSQspvc5Z0SvNY4YuQcHHtUgkk0oTvKfXWhGto36ljWImPF5N2QpuHZ
	 SCBOlR9Kyuv25sGz6LBdozcKXfm5Sk4ZgEeuPtbWJNKL3w74Ul3AUOf8aNP0XXEMAR
	 PpGrBpPrdAKQ9ipTDJswtiZoiCpvkR4G5avDtj1PdYJm6vdbSOMUWOKLux28kGtio7
	 vOneQoNEQEeAg==
Message-ID: <f949f712-eacf-49a0-91ea-8062e2d1f5e0@zytor.com>
Date: Tue, 12 Mar 2024 14:36:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 00/14] Dynamic Kernel Stacks
Content-Language: en-US
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, x86@kernel.org, bp@alien8.de,
        brauner@kernel.org, bristot@redhat.com, bsegall@google.com,
        dave.hansen@linux.intel.com, dianders@chromium.org,
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
 <2cb8f02d-f21e-45d2-afe2-d1c6225240f3@zytor.com>
 <CA+CK2bC+bgOfohCEEW7nwAdakVmzg=RhUjjw=+Rw3wFALnOq-Q@mail.gmail.com>
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <CA+CK2bC+bgOfohCEEW7nwAdakVmzg=RhUjjw=+Rw3wFALnOq-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/12/24 12:45, Pasha Tatashin wrote:
>>
>> Ok, first of all, talking about "kernel memory" here is misleading.
> 
> Hi Peter,
> 
> I re-read my cover letter, and I do not see where "kernel memory" is
> mentioned. We are talking about kernel stacks overhead that is
> proportional to the user workload, as every active thread has an
> associated kernel stack. The idea is to save memory by not
> pre-allocating all pages of kernel-stacks, but instead use it as a
> safeguard when a stack actually becomes deep. Come-up with a solution
> that can handle rare deeper stacks only when needed. This could be
> done through faulting on the supported hardware (as proposed in this
> series), or via pre-map on every schedule event, and checking the
> access when thread goes off cpu (as proposed by Andy Lutomirski to
> avoid double faults on x86) .
> 
> In other words, this feature is only about one very specific type of
> kernel memory that is not even directly mapped (the feature required
> vmapped stacks).
> 
>> Unless your threads are spending nearly all their time sleeping, the
>> threads will occupy stack and TLS memory in user space as well.
> 
> Can you please elaborate, what data is contained in the kernel stack
> when thread is in user space? My series requires thread_info not to be
> in the stack by depending on THREAD_INFO_IN_TASK.
> 

My point is that what matters is total memory use, not just memory used 
in the kernel. Amdahl's law.

	-hpa


