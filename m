Return-Path: <linux-kernel+bounces-155122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD7A8AE588
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4A391F21D25
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7670F1353F8;
	Tue, 23 Apr 2024 12:02:59 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C5784D03;
	Tue, 23 Apr 2024 12:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713873779; cv=none; b=EPdvRrU+ULOSSA+YCZVW9YkLUDccZCDEf2Vq9CtiYiWJdlOvS/Z1TDDJyNRVXckzHGnp/6BhJkNGXTpipVLuM5hubLRWdWlfpQv6RhUGJ1QHsglPk3lBiIeQhiPx4x2zjFJRii6XxE/SoRED2zzDl1R2Z9Ry5aHPiKzyPUfQYuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713873779; c=relaxed/simple;
	bh=1ItToBvcyt1iWmaL689oE/hXmhEYnsUVoAMXlT6YVLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JXIg1G9bVGsZ4BVOC0IrdzVYwX7wbwB5t2ffCcLsQI2gb4B8IWcHGuUv0Xtlktmg4c877UEaF4gJK5aRLhi0Vh4DA+kcKiKrvvevZH3i/jgmcb7rOHwWgsC8lQ3lpVlQaejatl+3pTmDYtE5o8C9b9WyQi8zg9X6Ix1gDtVgQ7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VP0zW0PtMzvPs3;
	Tue, 23 Apr 2024 19:59:51 +0800 (CST)
Received: from dggpemd100004.china.huawei.com (unknown [7.185.36.20])
	by mail.maildlp.com (Postfix) with ESMTPS id 7B8A318006B;
	Tue, 23 Apr 2024 20:02:51 +0800 (CST)
Received: from [10.67.109.211] (10.67.109.211) by
 dggpemd100004.china.huawei.com (7.185.36.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 23 Apr 2024 20:02:51 +0800
Message-ID: <e68acf91-f9bb-4468-bf37-dc295c717577@huawei.com>
Date: Tue, 23 Apr 2024 20:02:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
Content-Language: en-US
To: Nathan Chancellor <nathan@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-kbuild@vger.kernel.org>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <masahiroy@kernel.org>,
	<nicolas@fjasle.eu>, <peterz@infradead.org>, <jpoimboe@kernel.org>,
	<leitao@debian.org>, <petr.pavlu@suse.com>, <richard.weiyang@gmail.com>,
	<ruanjinjie@huawei.com>, <ndesaulniers@google.com>, <jgross@suse.com>
References: <20240422060556.1226848-1-liuyuntao12@huawei.com>
 <20240422192448.GA19445@dev-arch.thelio-3990X>
From: "liuyuntao (F)" <liuyuntao12@huawei.com>
In-Reply-To: <20240422192448.GA19445@dev-arch.thelio-3990X>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemd100004.china.huawei.com (7.185.36.20)



On 2024/4/23 3:24, Nathan Chancellor wrote:
> Hi Yuntao,
> 
> Just a drive by review since I saw this patch via another CC in my
> inbox, I would wait for x86 maintainer thoughts before sending a v2.
> 
> On Mon, Apr 22, 2024 at 06:05:56AM +0000, Yuntao Liu wrote:
>> The current x86 architecture does not yet support the
>> HAVE_LD_DEAD_CODE_DATA_ELIMINATION feature. x86 is widely used in
>> embedded scenarios, and enabling this feature would be beneficial for
>> reducing the size of the kernel image.
>>
>> In order to make this work, we keep the necessary tables by annotating
>> them with KEEP, also it requires further changes to linker script to KEEP
>> some tables and wildcard compiler generated sections into the right place.
>>
>> Enabling CONFIG_UNWINDER_ORC or CONFIG_MITIGATION_RETPOLINE will enable
>> the objtool's --orc and --retpoline parameters, which will alter the
>> layout of the binary file, thereby preventing gc-sections from functioning
>> properly. Therefore, HAVE_LD_DEAD_CODE_DATA_ELIMINATION should only be
>> selected when they are not enabled.
>>
>> Enabling CONFIG_LTO_CLANG or CONFIG_X86_KERNEL_IBT will use vmlinux.o
>> instead of performing the slow LTO link again. This can also prevent
>> gc-sections from functioning properly. Therefore, using this optimization
>> when CONFIG_LD_DEAD_CODE_DATA_ELIMINATION is not enabled.
> 
> These two paragraphs indicate to me that this feature will be
> unselectable the vast majority of x86 configurations, why should the
> upstream kernel support it in that case?
> 

Just to refine the DEAD_CODE_DATA_ELIMINATION this feature, it might 
also offer users an extra choice in certain situations.

>> The size comparison of zImage is as follows:
> 
>                           ^ bzImage?
> 

Yes, it should be bzImage.

>> x86_def_defconfig  i386_defconfig    tinyconfig
>> 10892288           10826240          607232          no dce
>> 10748928           10719744          529408          dce
>> 1.3%               0.98%             12.8%           shrink
>>
>> When using smaller config file, there is a significant reduction in the
>> size of the zImage.
> 
> Same here.
> 
> What toolchain was this tested with? There have been behavior
> differences between the GNU and LLVM toolchains that have shown up when
> dead code elimination is enabled, such as with 32-bit ARM [1] and RISC-V
> [2]. While I am not saying there are any problems here, it would be good
> to qualify how well this has been tested and perhaps do some testing
> with other toolchains and versions, especially since you are touching
> areas guarded by CONFIG_LTO_CLANG. Does the resulting kernel boot and
> run properly?
> 
> [1]: https://lore.kernel.org/30b01c65-12f2-4ee0-81d5-c7a2da2c36b4@app.fastmail.com/
> [2]: https://lore.kernel.org/20230622215327.GA1135447@dev-arch.thelio-3990X/
> 

I use GNU toolchains, and the kernel boots well with x86_64_defconfig in 
qemu.
Using LLVM toolchains, I came acrossa link failure:
> ld.lld: error: undefined hidden symbol: __alt_reloc_selftest               
> referenced by alternative.c                                            
>                .thinlto-cache/llvmcache-6140C39409062E0AC950603FE9B6042154C497B6:(.altinstr_replacement+0x30)
I am still struggling with it.

>> ---
>>   arch/x86/Kconfig              |  1 +
>>   arch/x86/kernel/vmlinux.lds.S | 24 ++++++++++++------------
>>   scripts/link-vmlinux.sh       |  2 +-
>>   3 files changed, 14 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index a902680b6537..92dfbc8ee4e7 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -247,6 +247,7 @@ config X86
>>   	select HAVE_FUNCTION_ERROR_INJECTION
>>   	select HAVE_KRETPROBES
>>   	select HAVE_RETHOOK
>> +	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if !CONFIG_UNWINDER_ORC && !CONFIG_MITIGATION_RETPOLINE
> 
> This is incorrect, it should be
> 
>      select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if !UNWINDER_ORC && !MITIGATION_RETPOLINE
> 

It is my mistake.

>>   	select HAVE_LIVEPATCH			if X86_64
>>   	select HAVE_MIXED_BREAKPOINTS_REGS
>>   	select HAVE_MOD_ARCH_SPECIFIC
> 
> Cheers,
> Nathan

