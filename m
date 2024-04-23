Return-Path: <linux-kernel+bounces-155131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 591688AE5AA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F994284D35
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFB484A4A;
	Tue, 23 Apr 2024 12:10:39 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA207E573;
	Tue, 23 Apr 2024 12:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713874238; cv=none; b=XV/QSwaIfLw/BtsOgiR5waWPSXH9+Yy0k6p/kPay0SG9+JemQGtwCH0PkjzVkW4SP6D0e0o94ownEcdvdjd4ipRpydsiwx82q2tha8rssSqWYKsTVeJi+trT2iT5I37ulKCKvo4u8DJedl3kcLhDyozgi6g3kWILagvOCHzx3M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713874238; c=relaxed/simple;
	bh=/39bQhKJIr5pQuBxZw8k1+ITgAhk8hyYhoCVey1WnUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UByrMwlFAP0DfHY1/s/o/gs25iFgrdlBKRl9PK2D7A2quUE9DXLOhX8uN1uh5lSB7vR37zkahieQddnPig3MPnc3TiDrVKK0iJomCo5O+yd2/kic9sU3v8SgK9UVwwMv9PEarAwBcXX92EraHH0EtD5q/Z/Hhr+OaYfbG4bD06Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VP1Bd6MZMzShjQ;
	Tue, 23 Apr 2024 20:09:29 +0800 (CST)
Received: from dggpemd100004.china.huawei.com (unknown [7.185.36.20])
	by mail.maildlp.com (Postfix) with ESMTPS id 0ECE618007D;
	Tue, 23 Apr 2024 20:10:34 +0800 (CST)
Received: from [10.67.109.211] (10.67.109.211) by
 dggpemd100004.china.huawei.com (7.185.36.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 23 Apr 2024 20:10:33 +0800
Message-ID: <845c7729-a967-48b3-b93b-8b0d14007bc3@huawei.com>
Date: Tue, 23 Apr 2024 20:10:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
Content-Language: en-US
To: Wei Yang <richard.weiyang@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <linux-kbuild@vger.kernel.org>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <masahiroy@kernel.org>,
	<nathan@kernel.org>, <nicolas@fjasle.eu>, <peterz@infradead.org>,
	<jpoimboe@kernel.org>, <leitao@debian.org>, <petr.pavlu@suse.com>,
	<ruanjinjie@huawei.com>, <ndesaulniers@google.com>, <jgross@suse.com>
References: <20240422060556.1226848-1-liuyuntao12@huawei.com>
 <20240423005956.rxxq6zezbmw4ylkc@master>
From: "liuyuntao (F)" <liuyuntao12@huawei.com>
In-Reply-To: <20240423005956.rxxq6zezbmw4ylkc@master>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemd100004.china.huawei.com (7.185.36.20)



On 2024/4/23 8:59, Wei Yang wrote:
> Hi, Yuntao
> 
> I am not that familiar with this, so got some questions below.
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
>>
>> The size comparison of zImage is as follows:
>> x86_def_defconfig  i386_defconfig    tinyconfig
>> 10892288           10826240          607232          no dce
>> 10748928           10719744          529408          dce
>> 1.3%               0.98%             12.8%           shrink
>>
>> When using smaller config file, there is a significant reduction in the
>> size of the zImage.
>> ---
>> arch/x86/Kconfig              |  1 +
>> arch/x86/kernel/vmlinux.lds.S | 24 ++++++++++++------------
>> scripts/link-vmlinux.sh       |  2 +-
>> 3 files changed, 14 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index a902680b6537..92dfbc8ee4e7 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -247,6 +247,7 @@ config X86
>> 	select HAVE_FUNCTION_ERROR_INJECTION
>> 	select HAVE_KRETPROBES
>> 	select HAVE_RETHOOK
>> +	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if !CONFIG_UNWINDER_ORC && !CONFIG_MITIGATION_RETPOLINE
> 
> How to make sure only these two config affect the function?
> 

I have tested all the parameters of objtool, and only when these two 
config are removed can gc-sections take effect.

>> 	select HAVE_LIVEPATCH			if X86_64
>> 	select HAVE_MIXED_BREAKPOINTS_REGS
>> 	select HAVE_MOD_ARCH_SPECIFIC
>> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
>> index 3509afc6a672..aeee2b9b6a6a 100644
>> --- a/arch/x86/kernel/vmlinux.lds.S
>> +++ b/arch/x86/kernel/vmlinux.lds.S
>> @@ -253,7 +253,7 @@ SECTIONS
>>
>> 	.x86_cpu_dev.init : AT(ADDR(.x86_cpu_dev.init) - LOAD_OFFSET) {
>> 		__x86_cpu_dev_start = .;
>> -		*(.x86_cpu_dev.init)
>> +		KEEP(*(.x86_cpu_dev.init))
> 
> How you choose the sections to keep?
> 
> If my understanding is correct, keep the sections is for gc-section. Sounds we
> need to keep all possible section, otherwise it would mis-behave?
> 

Nicholas Piggin has mentioned it before.

> FYI, easiest way to check if you forgot to KEEP a linker table is
> to look at `readelf -S vmlinux` differences, and to see what is
> being trimmed, look at nm differences or use --print-gc-sections
> LD option to see what symbols you're trimming. Linker tables,
> boot entry, and exception entry tends to require anchoring.
https://lore.kernel.org/all/20170709031333.29443-1-npiggin@gmail.com/

>> 		__x86_cpu_dev_end = .;
>> 	}
>>
>> @@ -261,7 +261,7 @@ SECTIONS
>> 	.x86_intel_mid_dev.init : AT(ADDR(.x86_intel_mid_dev.init) - \
>> 								LOAD_OFFSET) {
>> 		__x86_intel_mid_dev_start = .;
>> -		*(.x86_intel_mid_dev.init)
>> +		KEEP(*(.x86_intel_mid_dev.init))
>> 		__x86_intel_mid_dev_end = .;
>> 	}
>> #endif
>> @@ -275,21 +275,21 @@ SECTIONS
>> 	. = ALIGN(8);
>> 	.retpoline_sites : AT(ADDR(.retpoline_sites) - LOAD_OFFSET) {
>> 		__retpoline_sites = .;
>> -		*(.retpoline_sites)
>> +		KEEP(*(.retpoline_sites))
>> 		__retpoline_sites_end = .;
>> 	}
>>
>> 	. = ALIGN(8);
>> 	.return_sites : AT(ADDR(.return_sites) - LOAD_OFFSET) {
>> 		__return_sites = .;
>> -		*(.return_sites)
>> +		KEEP(*(.return_sites))
>> 		__return_sites_end = .;
>> 	}
>>
>> 	. = ALIGN(8);
>> 	.call_sites : AT(ADDR(.call_sites) - LOAD_OFFSET) {
>> 		__call_sites = .;
>> -		*(.call_sites)
>> +		KEEP(*(.call_sites))
>> 		__call_sites_end = .;
>> 	}
>> #endif
>> @@ -298,7 +298,7 @@ SECTIONS
>> 	. = ALIGN(8);
>> 	.ibt_endbr_seal : AT(ADDR(.ibt_endbr_seal) - LOAD_OFFSET) {
>> 		__ibt_endbr_seal = .;
>> -		*(.ibt_endbr_seal)
>> +		KEEP(*(.ibt_endbr_seal))
>> 		__ibt_endbr_seal_end = .;
>> 	}
>> #endif
>> @@ -307,7 +307,7 @@ SECTIONS
>> 	. = ALIGN(8);
>> 	.cfi_sites : AT(ADDR(.cfi_sites) - LOAD_OFFSET) {
>> 		__cfi_sites = .;
>> -		*(.cfi_sites)
>> +		KEEP(*(.cfi_sites))
>> 		__cfi_sites_end = .;
>> 	}
>> #endif
>> @@ -320,7 +320,7 @@ SECTIONS
>> 	. = ALIGN(8);
>> 	.altinstructions : AT(ADDR(.altinstructions) - LOAD_OFFSET) {
>> 		__alt_instructions = .;
>> -		*(.altinstructions)
>> +		KEEP(*(.altinstructions))
>> 		__alt_instructions_end = .;
>> 	}
>>
>> @@ -330,13 +330,13 @@ SECTIONS
>> 	 * get the address and the length of them to patch the kernel safely.
>> 	 */
>> 	.altinstr_replacement : AT(ADDR(.altinstr_replacement) - LOAD_OFFSET) {
>> -		*(.altinstr_replacement)
>> +		KEEP(*(.altinstr_replacement))
>> 	}
>>
>> 	. = ALIGN(8);
>> 	.apicdrivers : AT(ADDR(.apicdrivers) - LOAD_OFFSET) {
>> 		__apicdrivers = .;
>> -		*(.apicdrivers);
>> +		KEEP(*(.apicdrivers));
>> 		__apicdrivers_end = .;
>> 	}
>>
>> @@ -406,7 +406,7 @@ SECTIONS
>> 	.brk : AT(ADDR(.brk) - LOAD_OFFSET) {
>> 		__brk_base = .;
>> 		. += 64 * 1024;		/* 64k alignment slop space */
>> -		*(.bss..brk)		/* areas brk users have reserved */
>> +		KEEP(*(.bss..brk))	/* areas brk users have reserved */
>> 		__brk_limit = .;
>> 	}
>>
>> @@ -432,7 +432,7 @@ SECTIONS
>> 	. = ALIGN(HPAGE_SIZE);
>> 	.init.scratch : AT(ADDR(.init.scratch) - LOAD_OFFSET) {
>> 		__init_scratch_begin = .;
>> -		*(.init.scratch)
>> +		KEEP(*(.init.scratch))
>> 		. = ALIGN(HPAGE_SIZE);
>> 		__init_scratch_end = .;
>> 	}
>> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
>> index 7862a8101747..7287b5a9f17d 100755
>> --- a/scripts/link-vmlinux.sh
>> +++ b/scripts/link-vmlinux.sh
>> @@ -60,7 +60,7 @@ vmlinux_link()
>> 	# skip output file argument
>> 	shift
>>
>> -	if is_enabled CONFIG_LTO_CLANG || is_enabled CONFIG_X86_KERNEL_IBT; then
>> +	if [ is_enabled CONFIG_LTO_CLANG || is_enabled CONFIG_X86_KERNEL_IBT ] && [ ! is_enabled CONFIG_LD_DEAD_CODE_DATA_ELIMINATION ]; then
>> 		# Use vmlinux.o instead of performing the slow LTO link again.
>> 		objs=vmlinux.o
>> 		libs=
>> -- 
>> 2.34.1
> 

