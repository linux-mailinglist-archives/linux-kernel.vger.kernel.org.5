Return-Path: <linux-kernel+bounces-72651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C61585B6B9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48D2F28DCDC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F0462172;
	Tue, 20 Feb 2024 09:06:43 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1267612FE
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 09:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708420003; cv=none; b=cS/XLZ0Mo0XWNcHI6v9l+OoRSzNK/ZXqFZnZ3mCERob1vKHnrvjGyCjE+YMwjkjVG295dRTnIuKlyTJ8pJoZtfU6GhQxQJcL/OWsFDgdxQ1W3V1O5JuG2NeHCRRqQatJPtUT/M/33DB7aMWyA9L9WgnhzSmflgb+li4DSmFhTKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708420003; c=relaxed/simple;
	bh=BgDdgeT23PH+yWwPYSF9gJbEqkYMbmFf4IwbU1QNQWk=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=l8/9RofhFfTjrW9W/Nvaf6maYnHboAgx2wDmJaX6kLcGkoK9LAxENpBr7iB9ztq3B7FzJb2oqCJWOrgLHm1P/25iDkX477+jsXBxXohqFEJNrHOqy6mYVBNvcjABRLzQkAhopVcXJjgWxqX9VsBqszbdW/LpgBFX/M4aN9pLnRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4TfD511Fd2zNlnc;
	Tue, 20 Feb 2024 17:05:09 +0800 (CST)
Received: from dggpemd200001.china.huawei.com (unknown [7.185.36.224])
	by mail.maildlp.com (Postfix) with ESMTPS id 0EE3818005E;
	Tue, 20 Feb 2024 17:06:31 +0800 (CST)
Received: from [10.174.178.120] (10.174.178.120) by
 dggpemd200001.china.huawei.com (7.185.36.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Tue, 20 Feb 2024 17:06:30 +0800
Message-ID: <1f98fd3a-9a2c-437e-8e86-8c5f575917df@huawei.com>
Date: Tue, 20 Feb 2024 17:06:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <mawupeng1@huawei.com>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<bp@suse.de>, <mingo@redhat.com>, <rdunlap@infradead.org>,
	<bhelgaas@google.com>, <linux-mm@kvack.org>
Subject: Re: [PATCH v4 0/3] Cleanup for PAT
To: <xin@zytor.com>, <akpm@linux-foundation.org>,
	<dave.hansen@linux.intel.com>, <luto@kernel.org>, <tglx@linutronix.de>,
	<peterz@infradead.org>, <hpa@zytor.com>
References: <20240220034835.507022-1-mawupeng1@huawei.com>
 <07d43633-d707-415d-a662-ecd3a50b12ae@zytor.com>
Content-Language: en-US
From: mawupeng <mawupeng1@huawei.com>
In-Reply-To: <07d43633-d707-415d-a662-ecd3a50b12ae@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemd200001.china.huawei.com (7.185.36.224)



On 2024/2/20 16:37, Xin Li wrote:
> On 2/19/2024 7:48 PM, Wupeng Ma wrote:
>> From: Ma Wupeng <mawupeng1@huawei.com>
>>
> 
> This patch set is all about follow_phys() cleanups, so "Cleanup for PAT"
> seems too generic.
> 
>> Patch #1 move follow_phys to memtype.c since only pat use this.
>> Patch #2 cleanup parameter in follow_phys.
>> Patch #3 drop the unnecessary WARN_ON_ONCE if follow_phys fails.
> 
> I'm more curious why follow_phys() ended up this way?
> 
> follow_phys() was introduced in commit 28b2ee20c7cba ("access_process_vm
> device memory infrastructure") in 2008 for getting a physical page address
> for a virtual address, and used in generic_access_phys(). And later it's
> used in x86 PAT code.
> 
> Commit 03668a4debf4f ("mm: use generic follow_pte() in follow_phys()") made
> follow_phys() more of a wrapper of follow_pte(), and commit 96667f8a4382d
> ("mm: Close race in generic_access_phys") replaced follow_phys() with
> follow_pte() in generic_access_phys(). And the end result is that
> follow_phys() is used in x86 PAT code only.

Thanks for the explanation. I have a better understanding of the history of
this function.

> 
> As follow_phys() in untrack_pfn() can be replaced with follow_pfn(), then

Yes, this can be replaced with follow_pfn().

> maybe we don't have to keep follow_phys(), and just use follow_pte() in
> track_pfn_copy()?

As follow_phys() will return unsigned long *prot which is need in track_pfn_copy(),
we need to do something with this.

Can we replace follow_pfn with follow_phys()?

Thanks!
Ma

> 
> Thanks!
>     Xin
> 
>>
>> Changelog since v3:
>> - rebase to latest linux
>> - fix compile warnings
>>
>> Changelog since v2:
>> - rebase to latest linux
>>
>> Changelog since v1:
>> - split patch #1 into two patches based on Boris's advise
>>
>> Ma Wupeng (3):
>>    x86/mm/pat: Move follow_phys to pat-related file
>>    x86/mm/pat: Cleanup unused parameter in follow_phys
>>    x86/mm/pat: Remove WARN_ON_ONCE if follow_phys fails
>>
>>   arch/x86/mm/pat/memtype.c | 32 ++++++++++++++++++++++++++------
>>   include/linux/mm.h        |  2 --
>>   mm/memory.c               | 28 ----------------------------
>>   3 files changed, 26 insertions(+), 36 deletions(-)
>>
> 
> 

