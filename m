Return-Path: <linux-kernel+bounces-49384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 972008469CF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 545312888C0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C5C17BC4;
	Fri,  2 Feb 2024 07:51:21 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E950E179AD;
	Fri,  2 Feb 2024 07:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706860280; cv=none; b=XSIgrw8xzoiTu4r2j4ZAcy3hCa9zoMrCoSNXd/VCN3OtdmUEk9GfLku/0pjdPUoHkCbHCHGr+Weqy8aZ6PZCX/yhJoEO4+CNZrfNxWgZwYX0dcPPIsvZnlQ3MiBFu85HAKaSrxFYMRVle07zJK5NDSBtIprwyIghQOlyZDdQqCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706860280; c=relaxed/simple;
	bh=6CeHjpWTHiilKMN0s9ZZArB1+0+f4ZveMoELOFvHi5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iQrFKv18/zR377u1WmtrVpUxnHHk+zYwdKESi5o6n41QGKF4PCh+ttMMeXxt7J+nc1MuC01SAJa9cqHWIQmMHCIxFtgZgdartJupdxsbThjhqsq3eSPNuVH9hBVtUCCR6pJC20Cu7U5n1opiKL5mwfDFYg1o77lkb2bmnzSq+wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TR7Fs67dFz1Q8ZP;
	Fri,  2 Feb 2024 15:49:21 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (unknown [7.193.23.234])
	by mail.maildlp.com (Postfix) with ESMTPS id 46058140414;
	Fri,  2 Feb 2024 15:51:14 +0800 (CST)
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Feb 2024 15:51:13 +0800
Message-ID: <39c1e4d2-b1d0-91ae-595e-1add4698dd7f@huawei.com>
Date: Fri, 2 Feb 2024 15:51:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH -next v4 2/3] x86/mce: rename MCE_IN_KERNEL_COPYIN to
 MCE_IN_KERNEL_COPY_MC
To: Borislav Petkov <bp@alien8.de>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	<wangkefeng.wang@huawei.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Tony Luck
	<tony.luck@intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Naoya
 Horiguchi <naoya.horiguchi@nec.com>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <linux-mm@kvack.org>, Guohanjun
	<guohanjun@huawei.com>
References: <20240111135548.3207437-1-tongtiangen@huawei.com>
 <20240111135548.3207437-3-tongtiangen@huawei.com>
 <20240131070258.GGZbnwov0g918F-FGz@fat_crate.local>
 <3009aadd-69d6-c797-20b4-95cf926b6dd9@huawei.com>
 <20240201142016.GFZbuooG9CRoK90U2C@fat_crate.local>
From: Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <20240201142016.GFZbuooG9CRoK90U2C@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600017.china.huawei.com (7.193.23.234)



在 2024/2/1 22:20, Borislav Petkov 写道:
> On Thu, Feb 01, 2024 at 07:37:25PM +0800, Tong Tiangen wrote:
>> 在 2024/1/31 15:02, Borislav Petkov 写道:
>>> On Thu, Jan 11, 2024 at 09:55:47PM +0800, Tong Tiangen wrote:
>>>> Currently, there are some kernel memory copy scenarios is also mc safe
>>>> which use copy_mc_to_kernel() or copy_mc_user_highpage().
>>>
>>> Both of those end up in copy_mc_enhanced_fast_string() which does
>>> EX_TYPE_DEFAULT_MCE_SAFE.
>>
>> OK, how about this commit msg change? :)
>>
>> Currently, there are some kernel memory copy scenarios is also mc safe
>> which use copy_mc_to_kernel() or copy_mc_user_highpage(), **both of those
>> end up in copy_mc_enhanced_fast_string() or copy_mc_fragile() which does
>> EX_TYPE_DEFAULT_MCE_SAFE.**
>>
>> In these scenarios, posion pages need to be isolated too. Therefore, a
>> macro similar to MCE_IN_KERNEL_COPYIN is required. For this reason, we
>> can rename MCE_IN_KERNEL_COPYIN to MCE_IN_KERNEL_COPY_MC, the new macro
>> can be applied to both user-to-kernel mc safe copy and kernel-to-kernel
>> mc safe copy.
> 
> Maybe my question wasn't clear: why is that renaming churn needed at
> all? What are you "fixing" here?
> 
> What is the problem that you're encountering which needs fixing?

This patch is a prepare patch and the next patch is a fix patch, the
complete logic of the two patches is as follows:

The problem i'm encountering:
-------------------------------
In the x86 mce processing, error_context() setting macro
MCE_IN_KERNEL_COPYIN to identify copy from user(user-to-kernel copy) for
fixup_type EX_TYPE_UACCESS.

Then do_machine_check() uses macro MCE_IN_KERNEL_COPYIN to isolate
posion page in memory_failure().

Currently, there are some kernel memory copy scenarios is also mc safe
which use copy_mc_to_kernel() or copy_mc_user_highpage(), these kernel-
to-kernel copy use fixup_type EX_TYPE_DEFAULT_MCE_SAFE. In these
scenarios, posion pages need to be isolated too and the current
implementation is to actively call memory_failure_queue() when the copy
fails.

Calling memory_failure_queue() separately is not a good implementation,
call it uniformly in do_machine_check() is more reasonable.

Solution:
----------
A macro similar to MCE_IN_KERNEL_COPYIN is required, so we can rename
MCE_IN_KERNEL_COPYIN to MCE_IN_KERNEL_COPY_MC, the new macro can be
applied to both user-to-kernel mc safe copy and kernel-to-kernel mc safe
copy, in error_context()，we can set MCE_IN_KERNEL_COPY_MC for both
fixup_type EX_TYPE_UACCESS and EX_TYPE_DEFAULT_MCE_SAFE.



Do you think it's clear to say so and then we can merge the two patches
to make the complete logic clearer in commit msg ?

Many thanks.
Tong.

> 
> Thx.
> 

