Return-Path: <linux-kernel+bounces-120162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5699D88D383
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 01:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7358B23735
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 00:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D824B1BDDB;
	Wed, 27 Mar 2024 00:48:17 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983D328EC;
	Wed, 27 Mar 2024 00:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711500497; cv=none; b=KDNiEW1gXB8PPWBA5dUJ/L/lGfpzN4MlBnE3lcHktyWMUPN1iZIAdNDxfTi7INLC8uP3Q2XoirjHDRZr3I2LaALUWOPeFaZvdI1LZzjDHP4+TKbv8lBJPKPAJtM4fD8IgnPNMbj8/gYPVATfKVEgZtTv7DlObCTyVHEPXFrW5PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711500497; c=relaxed/simple;
	bh=hWuZXrxDD/5dw1ptkdk4OsxL5BtRsRdCmo6PnucLDH0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=VGOrXVrOPgGCG7reS9UJg+BjS12SR1B2sPTZKz/6oj52E/oapAkhkO0C6xY10Xo4+qTpG6NaTMvqmt4HvFE4652yGwEtUIH2ATztXQBwkrcFTPs+/6LvLcXtYxq6TdYJ2U8EQS68TXqMS03cCA4/VvymbfX5cjqoNWdA3zF2/kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4V47LN0cv7z1GDJm;
	Wed, 27 Mar 2024 08:47:40 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (unknown [7.193.23.234])
	by mail.maildlp.com (Postfix) with ESMTPS id 795961A0172;
	Wed, 27 Mar 2024 08:48:10 +0800 (CST)
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Mar 2024 08:48:09 +0800
Message-ID: <cf82a480-568e-7ce0-5394-bd6c511c067e@huawei.com>
Date: Wed, 27 Mar 2024 08:48:08 +0800
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
From: Tong Tiangen <tongtiangen@huawei.com>
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
 <100198dd-320f-68e6-9c09-210620940a74@huawei.com>
In-Reply-To: <100198dd-320f-68e6-9c09-210620940a74@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600017.china.huawei.com (7.193.23.234)

Hi Petkov：

	Kindly ping...

Thanks,
Tong.

在 2024/2/18 18:08, Tong Tiangen 写道:
> 
> 
> 在 2024/2/7 20:29, Borislav Petkov 写道:
>> On Sun, Feb 04, 2024 at 04:26:26PM +0800, Tong Tiangen wrote:
>>> diff --git a/arch/x86/kernel/cpu/mce/severity.c 
>>> b/arch/x86/kernel/cpu/mce/severity.c
>>> index bca780fa5e57..b2cce1b6c96d 100644
>>> --- a/arch/x86/kernel/cpu/mce/severity.c
>>> +++ b/arch/x86/kernel/cpu/mce/severity.c
>>> @@ -292,11 +292,11 @@ static noinstr int error_context(struct mce *m, 
>>> struct pt_regs *regs)
>>>       case EX_TYPE_UACCESS:
>>>           if (!copy_user)
>>>               return IN_KERNEL;
>>> +        fallthrough;
>>> +    case EX_TYPE_DEFAULT_MCE_SAFE:
>>>           m->kflags |= MCE_IN_KERNEL_COPYIN;
>>>           fallthrough;
>>
>> I knew something was still bugging me here and this is still wrong.
>>
>> Let's imagine this flow:
>>
>> copy_mc_to_user() - note *src is kernel memory
>> |-> copy_mc_enhanced_fast_string or copy_mc_fragile - it's the same thing
>>    |-> -#MC, exception type EX_TYPE_DEFAULT_MCE_SAFE
>>      |-> error_context():
>>         case EX_TYPE_DEFAULT_MCE_SAFE:
>>                  m->kflags |= MCE_IN_KERNEL_COPYIN;
>>
>> MCE_IN_KERNEL_COPYIN does kill_me_never():
>>
>>     pr_err("Kernel accessed poison in user space at %llx\n", 
>> p->mce_addr);
>>
>> but that's reading from kernel memory!
> 
> Hi:
> 
> 1. The copy_mc_to_kernel() is used in the coredump, KSM, and COW
> scenarios, in these scenarios, the src mem stores the user data and the
> kernel use kernel address to access the src mem(using kmap()).
> 
> 2. the src mem of copy_mc_to_user() is currently only used by the DAX:
> 
>    dax_iomap_iter()
>      -> dax_copy_to_iter()
>        -> _copy_mc_to_iter
>          -> copy_to_user_iter_mc()
>            -> copy_mc_to_user()
> 
> DAX is also used to store user data，such as pmem，pmem uses the kernel
> address to access src mem(memremap_pages()):
> 
>    pmem_attach_disk()
>      -> devm_memremap_pages()
>        -> memremap_pages()
> 
> 3. EX_TYPE_DEFAULT_MCE_SAFE is only used in
> copy_mc_to_user()/copy_mc_to_kernel()。
> 
> 4. Therefore, for EX_TYPE_DEFAULT_MCE_SAFE, the memory page where the
> hardware error occurs stores user data, these page can be securely
> isolated. This is different from UACCESS, which can be securely isolated
> only COPYIN(the src mem is user data) is checked.
> 
> Based on the above understanding, I think the original logic should be
> fine, except for the pr_err() in kill_me_never().
> 
> Thanks.
> Tong.
> 
>>
>> IOW, I *think* that switch statement should be this:
>>
>>     switch (fixup_type) {
>>     case EX_TYPE_UACCESS:
>>     case EX_TYPE_DEFAULT_MCE_SAFE:
>>         if (!copy_user)
>>             return IN_KERNEL;
>>
>>         m->kflags |= MCE_IN_KERNEL_COPYIN;
>>         fallthrough;
>>
>>     case EX_TYPE_FAULT_MCE_SAFE:
>>         m->kflags |= MCE_IN_KERNEL_RECOV;
>>         return IN_KERNEL_RECOV;
>>
>>     default:
>>         return IN_KERNEL;
>>     }
>>
>> Provided I'm not missing a case and provided is_copy_from_user() really
>> detects all cases properly.
>>
>> And then patch 3 is wrong because we only can handle "copy in" - not
>> just any copy.
>>
>> Thx.
>>

