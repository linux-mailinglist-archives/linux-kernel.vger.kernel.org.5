Return-Path: <linux-kernel+bounces-82521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2678685C2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 562461C2223E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBBF4C9B;
	Tue, 27 Feb 2024 01:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iJpepMV9"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FAE23B1;
	Tue, 27 Feb 2024 01:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708997292; cv=none; b=A3JkMwfJTq0VbbibQtZUoIpTPDkSzm42P//0uxJq23cch3ZQNILh7PYzuBD7/nR2EG3ys7CH1Ev9O85/ShqA3+SZ+UcbQ7d4clKm+j3pPiJ4eV2VdJe8m4D8UbTAcAglf/520E+mcmYRVyFL5jyjk5pakzQWytdqRG+PWG2Hg1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708997292; c=relaxed/simple;
	bh=x/9y0iYxQ2751n6PkReyi2LAu5t4bFG9SimZ/Iziglw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Koy8/m3pkZKroWDUgppAjJijfsCoyNjTx22aa+r6Yg3V/a28DE4lQA2enCU24ZopZg7H/fxULkHcMeaaiwfq0l/2363aPzg/GljtkOGRNaVF8ThLKua4qZhmMsAVWomQaaNxMwHvMOtvM8YL1+DN9S98LGkJDjpRJ1pB+TttNTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iJpepMV9; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708997282; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=YCczuCEnDCQbWnMy3gj+btunpyzvXLyTsTyWXZ+74LY=;
	b=iJpepMV9nqSfZBBgbAiRLVcjsMEkyVYsPPSHVi1JmOuD8CMlaS+jTcD2emyJrdE6GM3zb33UZVKzinSpRPevlcNr2UiKNM+C5LERN80/YY6cKyznfS7OZEt4Bppdz6SlBA+tR9KKnosUCjorpXAnn+phBZyl5//N65BjL2lsgRQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=32;SR=0;TI=SMTPD_---0W1KvRet_1708997278;
Received: from 30.240.112.180(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0W1KvRet_1708997278)
          by smtp.aliyun-inc.com;
          Tue, 27 Feb 2024 09:28:00 +0800
Message-ID: <76cc249c-31b2-4fd9-a36c-9ec184ffe01c@linux.alibaba.com>
Date: Tue, 27 Feb 2024 09:27:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/3] mm: memory-failure: move return value
 documentation to function declaration
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: rafael@kernel.org, wangkefeng.wang@huawei.com, tanxiaofei@huawei.com,
 mawupeng1@huawei.com, tony.luck@intel.com, linmiaohe@huawei.com,
 naoya.horiguchi@nec.com, james.morse@arm.com, gregkh@linuxfoundation.org,
 will@kernel.org, jarkko@kernel.org, linux-acpi@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 linux-edac@vger.kernel.org, x86@kernel.org, justin.he@arm.com,
 ardb@kernel.org, ying.huang@intel.com, ashish.kalra@amd.com,
 baolin.wang@linux.alibaba.com, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, lenb@kernel.org, hpa@zytor.com,
 robert.moore@intel.com, lvying6@huawei.com, xiexiuqi@huawei.com,
 zhuo.song@linux.alibaba.com
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20240204080144.7977-3-xueshuai@linux.alibaba.com>
 <20240226104611.GCZdxr82q-Wcms7R3S@fat_crate.local>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20240226104611.GCZdxr82q-Wcms7R3S@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024/2/26 18:46, Borislav Petkov wrote:
> On Sun, Feb 04, 2024 at 04:01:43PM +0800, Shuai Xue wrote:
>> Part of return value comments for memory_failure() were originally
>> documented at the call site. Move those comments to the function
>> declaration to improve code readability and to provide developers with
>> immediate access to function usage and return information.
>>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> ---
>>  arch/x86/kernel/cpu/mce/core.c | 9 +--------
>>  mm/memory-failure.c            | 9 ++++++---
>>  2 files changed, 7 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
>> index bc39252bc54f..822b21eb48ad 100644
>> --- a/arch/x86/kernel/cpu/mce/core.c
>> +++ b/arch/x86/kernel/cpu/mce/core.c
>> @@ -1365,17 +1365,10 @@ static void kill_me_maybe(struct callback_head *cb)
>>  		return;
>>  	}
>>  
>> -	/*
>> -	 * -EHWPOISON from memory_failure() means that it already sent SIGBUS
>> -	 * to the current process with the proper error info,
>> -	 * -EOPNOTSUPP means hwpoison_filter() filtered the error event,
>> -	 *
>> -	 * In both cases, no further processing is required.
>> -	 */
>>  	if (ret == -EHWPOISON || ret == -EOPNOTSUPP)
>>  		return;
>>  
>> -	pr_err("Memory error not recovered");
>> +	pr_err("Sending SIGBUS to current task due to memory error not recovered");
> 
> Unrelated change.

Yes, I will drop the error message change.

> 
>>  	kill_me_now(cb);
>>  }
>>  
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 636280d04008..d33729c48eff 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -2175,9 +2175,12 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
>>   * Must run in process context (e.g. a work queue) with interrupts
>>   * enabled and no spinlocks held.
>>   *
>> - * Return: 0 for successfully handled the memory error,
>> - *         -EOPNOTSUPP for hwpoison_filter() filtered the error event,
>> - *         < 0(except -EOPNOTSUPP) on failure.
>> + * Return values:
>> + *   0             - success
>> + *   -EOPNOTSUPP   - hwpoison_filter() filtered the error event.
>> + *   -EHWPOISON    - sent SIGBUS to the current process with the proper
>> + *                   error info by kill_accessing_process().
> 
> kill_accessing_process() is not the only one returning -EHWPOISON.
> 
> And if you look at the code, it should be:
> 
> 	-EHWPOISON	- the page was already poisoned, potentially
> 			kill process
> 
> or so.
> 

You are right, will fix it in next version.

Thank you.

Best Regards.
Shuai


