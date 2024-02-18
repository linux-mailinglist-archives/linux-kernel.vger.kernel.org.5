Return-Path: <linux-kernel+bounces-70328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF85859623
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 11:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6590A1C21364
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 10:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DA21BF3D;
	Sun, 18 Feb 2024 10:08:30 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69413FBE1;
	Sun, 18 Feb 2024 10:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708250909; cv=none; b=I5vRcYE1dEEIOR/kw8lKk3rPgCmJFHNvGXQOkQ+jttQQ2MsYPapPmur1JVOKvdgD3F4YeS+JibYbJO8RL8Bb2cYgnGraMBSOe0m5I8PIiDrQd7R3QKx3TWrOrI/82PY3F7BY3ieFt4Gn0vEsuyFhpyE+MTwZ30dtZc49Fy/BcMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708250909; c=relaxed/simple;
	bh=LaBlhBnxg6dQJQlqoJUHDWjODNXxe/GPvW3ozfStz+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hBcFPuSo8uI8239J/X5utwvbdCl4p5BPRhLCbAfq8RQkY7dJYmpYKr6pB8ykDXXP+RvgNon+UHyotuWMbML12ap5vHeyclWubgF6g+yl+Y8YQ9/MPLVqQj6dlw+DJaBOy5lLAWlG7I5lqtSqdfwwLUrwjJawVX4+FgR7qdD4tDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Td1XL1yLyz1Q8sf;
	Sun, 18 Feb 2024 18:06:10 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (unknown [7.193.23.234])
	by mail.maildlp.com (Postfix) with ESMTPS id C2A4B1A0172;
	Sun, 18 Feb 2024 18:08:16 +0800 (CST)
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 18 Feb 2024 18:08:15 +0800
Message-ID: <100198dd-320f-68e6-9c09-210620940a74@huawei.com>
Date: Sun, 18 Feb 2024 18:08:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH -next v5 2/3] x86/mce: set MCE_IN_KERNEL_COPYIN for
 DEFAULT_MCE_SAFE exception
To: Borislav Petkov <bp@alien8.de>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	<wangkefeng.wang@huawei.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Tony Luck
	<tony.luck@intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Naoya
 Horiguchi <naoya.horiguchi@nec.com>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <linux-mm@kvack.org>, Guohanjun
	<guohanjun@huawei.com>
References: <20240204082627.3892816-1-tongtiangen@huawei.com>
 <20240204082627.3892816-3-tongtiangen@huawei.com>
 <20240207122942.GRZcN3tqWkV-WE-pak@fat_crate.local>
From: Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <20240207122942.GRZcN3tqWkV-WE-pak@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600017.china.huawei.com (7.193.23.234)



在 2024/2/7 20:29, Borislav Petkov 写道:
> On Sun, Feb 04, 2024 at 04:26:26PM +0800, Tong Tiangen wrote:
>> diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
>> index bca780fa5e57..b2cce1b6c96d 100644
>> --- a/arch/x86/kernel/cpu/mce/severity.c
>> +++ b/arch/x86/kernel/cpu/mce/severity.c
>> @@ -292,11 +292,11 @@ static noinstr int error_context(struct mce *m, struct pt_regs *regs)
>>   	case EX_TYPE_UACCESS:
>>   		if (!copy_user)
>>   			return IN_KERNEL;
>> +		fallthrough;
>> +	case EX_TYPE_DEFAULT_MCE_SAFE:
>>   		m->kflags |= MCE_IN_KERNEL_COPYIN;
>>   		fallthrough;
> 
> I knew something was still bugging me here and this is still wrong.
> 
> Let's imagine this flow:
> 
> copy_mc_to_user() - note *src is kernel memory
> |-> copy_mc_enhanced_fast_string or copy_mc_fragile - it's the same thing
>    |-> -#MC, exception type EX_TYPE_DEFAULT_MCE_SAFE
>      |-> error_context():
>         case EX_TYPE_DEFAULT_MCE_SAFE:
>                  m->kflags |= MCE_IN_KERNEL_COPYIN;
> 
> MCE_IN_KERNEL_COPYIN does kill_me_never():
> 
> 	pr_err("Kernel accessed poison in user space at %llx\n", p->mce_addr);
> 
> but that's reading from kernel memory!

Hi:

1. The copy_mc_to_kernel() is used in the coredump, KSM, and COW
scenarios, in these scenarios, the src mem stores the user data and the
kernel use kernel address to access the src mem(using kmap()).

2. the src mem of copy_mc_to_user() is currently only used by the DAX:

   dax_iomap_iter()
     -> dax_copy_to_iter()
       -> _copy_mc_to_iter
         -> copy_to_user_iter_mc()
           -> copy_mc_to_user()

DAX is also used to store user data，such as pmem，pmem uses the kernel
address to access src mem(memremap_pages()):

   pmem_attach_disk()
     -> devm_memremap_pages()
       -> memremap_pages()

3. EX_TYPE_DEFAULT_MCE_SAFE is only used in
copy_mc_to_user()/copy_mc_to_kernel()。

4. Therefore, for EX_TYPE_DEFAULT_MCE_SAFE, the memory page where the
hardware error occurs stores user data, these page can be securely
isolated. This is different from UACCESS, which can be securely isolated
only COPYIN(the src mem is user data) is checked.

Based on the above understanding, I think the original logic should be
fine, except for the pr_err() in kill_me_never().

Thanks.
Tong.

> 
> IOW, I *think* that switch statement should be this:
> 
> 	switch (fixup_type) {
> 	case EX_TYPE_UACCESS:
> 	case EX_TYPE_DEFAULT_MCE_SAFE:
> 		if (!copy_user)
> 			return IN_KERNEL;
> 
> 		m->kflags |= MCE_IN_KERNEL_COPYIN;
> 		fallthrough;
> 
> 	case EX_TYPE_FAULT_MCE_SAFE:
> 		m->kflags |= MCE_IN_KERNEL_RECOV;
> 		return IN_KERNEL_RECOV;
> 
> 	default:
> 		return IN_KERNEL;
> 	}
> 
> Provided I'm not missing a case and provided is_copy_from_user() really
> detects all cases properly.
> 
> And then patch 3 is wrong because we only can handle "copy in" - not
> just any copy.
> 
> Thx.
> 

