Return-Path: <linux-kernel+bounces-97787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D22876F67
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 07:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F02721F21961
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 06:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BA92E62A;
	Sat,  9 Mar 2024 06:42:19 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808EA3612E
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 06:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709966538; cv=none; b=XDpPSADJvLF02GjHliL6Nb/KDDwftrViHi+UZ79UGgcUVr2ClaSGok51IBFOXhOILiSVCdn2O9NARZSsuU6nc/G7ZOY/nnc1tC3LWo7CGCYD6qYbbhJED0Z/ZykBECR9xKKptb+CTZ/xOHbOj4mYeGlIY1m/jWd7mkAYG4AHBHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709966538; c=relaxed/simple;
	bh=Y5HcKdStIMQ2aKST6hCtrGfu9XNN6Puo12V+C0G+xOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dZso7CWV54PTL4fXXk9GLxQFMmhvBkdCCVQH8gdR2vwUjHRZ3xlJD2ABswvleFJA5wUAjQ5N7K/jQQCE6eRLZHnOGRv7OKB3uTRBktTEp6fqmmNT/akvwU6XUxCVn/7flUFaHdgLaV4gECDmZlYfiNlgcHmsxrTcIlCoZRIXUc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TsD0w5XCwz1Z1LJ;
	Sat,  9 Mar 2024 14:39:44 +0800 (CST)
Received: from dggpemd100004.china.huawei.com (unknown [7.185.36.20])
	by mail.maildlp.com (Postfix) with ESMTPS id B585B18001A;
	Sat,  9 Mar 2024 14:42:08 +0800 (CST)
Received: from [10.67.109.211] (10.67.109.211) by
 dggpemd100004.china.huawei.com (7.185.36.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sat, 9 Mar 2024 14:42:08 +0800
Message-ID: <c5e22e1e-1544-4e03-bca9-680515732bd3@huawei.com>
Date: Sat, 9 Mar 2024 14:42:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-next v2] arm32: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Fangrui Song <maskray@google.com>, Russell King <linux@armlinux.org.uk>,
	Andrew Davis <afd@ti.com>, Andrew Morton <akpm@linux-foundation.org>, "Kirill
 A. Shutemov" <kirill.shutemov@linux.intel.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Jonathan Corbet <corbet@lwn.net>, Mike Rapoport
	<rppt@kernel.org>, Rob Herring <robh@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>,
	<llvm@lists.linux.dev>
References: <20240307151231.654025-1-liuyuntao12@huawei.com>
 <58cc1053-7208-4b22-99cb-210fdf700569@app.fastmail.com>
 <CAMj1kXFEdRZsy8FovGrfWotoaws1KoKbFv5q+7yKL=pRV8zkZw@mail.gmail.com>
From: "liuyuntao (F)" <liuyuntao12@huawei.com>
In-Reply-To: <CAMj1kXFEdRZsy8FovGrfWotoaws1KoKbFv5q+7yKL=pRV8zkZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemd100004.china.huawei.com (7.185.36.20)



On 2024/3/8 22:27, Ard Biesheuvel wrote:
> On Fri, 8 Mar 2024 at 14:16, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> On Thu, Mar 7, 2024, at 16:12, Yuntao Liu wrote:
>>> The current arm32 architecture does not yet support the
>>> HAVE_LD_DEAD_CODE_DATA_ELIMINATION feature. arm32 is widely used in
>>> embedded scenarios, and enabling this feature would be beneficial for
>>> reducing the size of the kernel image.
>>>
>>> In order to make this work, we keep the necessary tables by annotating
>>> them with KEEP, also it requires further changes to linker script to KEEP
>>> some tables and wildcard compiler generated sections into the right place.
>>>
>>> It boots normally with defconfig, vexpress_defconfig and tinyconfig.
>>>
>>> The size comparison of zImage is as follows:
>>> defconfig       vexpress_defconfig      tinyconfig
>>> 5137712         5138024                 424192          no dce
>>> 5032560         4997824                 298384          dce
>>> 2.0%            2.7%                    29.7%           shrink
>>>
>>> When using smaller config file, there is a significant reduction in the
>>> size of the zImage.
>>>
>>> We also tested this patch on a commercially available single-board
>>> computer, and the comparison is as follows:
>>> a15eb_config
>>> 2161384         no dce
>>> 2092240         dce
>>> 3.2%            shrink
>>>
>>> The zImage size has been reduced by approximately 3.2%, which is 70KB on
>>> 2.1M.
>>>
>>> Signed-off-by: Yuntao Liu <liuyuntao12@huawei.com>
>>
>> I've retested with both gcc-13 and clang-18, and so no
>> more build issues. Your previous version already worked
>> fine for me.
>>
>> I did some tests combining this with CONFIG_TRIM_UNUSED_KSYMS,
>> which showed a significant improvement as expected. I also
>> tried combining it with an experimental CONFIG_LTO_CLANG
>> patch, but that did not show any further improvements.
>>
>> Tested-by: Arnd Bergmann <arnd@arndb.de>
>> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>>
>> Adding Ard Biesheuvel and Fangrui Song to Cc, so they can comment
>> on the ARM_VECTORS_TEXT workaround. I don't understand enough of
>> the details of what is going on here.
>>
> 
> Thanks for the cc
> 
>> Full quote of the patch below so they can see the whole thing.
>>
>> If they are also happy with the patch, I think you can send it
>> into Russell's patch tracker at
>> https://www.armlinux.org.uk/developer/patches/info.php
>>
> 
> No, not happy at all :-)
> 
> The resulting kernel does not boot (built with GCC or Clang). And the
> patch is buggy (see below)
> 
>>> ---
>>> v2:
>>>     - Support config XIP_KERNEL.
>>>     - Support LLVM compilation.
>>>
>>> v1: https://lore.kernel.org/all/20240220081527.23408-1-liuyuntao12@huawei.com/
>>> ---
>>>   arch/arm/Kconfig                       |  1 +
>>>   arch/arm/boot/compressed/vmlinux.lds.S |  4 ++--
>>>   arch/arm/include/asm/vmlinux.lds.h     | 18 +++++++++++++++++-
>>>   arch/arm/kernel/vmlinux-xip.lds.S      |  8 ++++++--
>>>   arch/arm/kernel/vmlinux.lds.S          | 10 +++++++---
>>>   5 files changed, 33 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>>> index 0af6709570d1..de78ceb821df 100644
>>> --- a/arch/arm/Kconfig
>>> +++ b/arch/arm/Kconfig
>>> @@ -113,6 +113,7 @@ config ARM
>>>        select HAVE_KERNEL_XZ
>>>        select HAVE_KPROBES if !XIP_KERNEL && !CPU_ENDIAN_BE32 && !CPU_V7M
>>>        select HAVE_KRETPROBES if HAVE_KPROBES
>>> +     select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
>>>        select HAVE_MOD_ARCH_SPECIFIC
>>>        select HAVE_NMI
>>>        select HAVE_OPTPROBES if !THUMB2_KERNEL
>>> diff --git a/arch/arm/boot/compressed/vmlinux.lds.S
>>> b/arch/arm/boot/compressed/vmlinux.lds.S
>>> index 3fcb3e62dc56..da21244aa892 100644
>>> --- a/arch/arm/boot/compressed/vmlinux.lds.S
>>> +++ b/arch/arm/boot/compressed/vmlinux.lds.S
>>> @@ -89,7 +89,7 @@ SECTIONS
>>>        * The EFI stub always executes from RAM, and runs strictly before
>>> the
>>>        * decompressor, so we can make an exception for its r/w data, and
>>> keep it
>>>        */
>>> -    *(.data.efistub .bss.efistub)
>>> +    *(.data.* .bss.*)
> 
> Why is this necessary? There is a reason we don't allow .data in the
> decompressor.
> 

Arnd previously asked about this bit also. When CONFIG_EFI and
CONFIG_LD_DEAD_CODE_DATA_ELIMINATION was enabled,I came across
a link failure using ld:
           arm-linux-gnueabi-ld: warning: orphan section 
`.data.efi_loglevel' from `drivers/firmware/efi/libstub/printk.stub.o' 
being placed in section `.data.efi_loglevel'
arm-linux-gnueabi-ld: warning: orphan section `.data.screen_info_guid' 
from `drivers/firmware/efi/libstub/screen_info.stub.o' being placed in 
section `.data.screen_info_guid'
arm-linux-gnueabi-ld: warning: orphan section `.data.cpu_state_guid' 
from `drivers/firmware/efi/libstub/arm32-stub.stub.o' being placed in 
section `.data.cpu_state_guid'
arm-linux-gnueabi-ld: warning: orphan section `.data.efi_nokaslr' from 
`drivers/firmware/efi/libstub/efi-stub-helper.stub.o' being placed in 
section `.data.efi_nokaslr'
arm-linux-gnueabi-ld: error: zImage file size is incorrect

So I changed .data.efistub to .data.*., the same to .bss.efistub. 

Perhaps it looks clearer like this.

--- a/arch/arm/boot/compressed/vmlinux.lds.S
+++ b/arch/arm/boot/compressed/vmlinux.lds.S
@@ -89,7 +89,11 @@ SECTIONS
       * The EFI stub always executes from RAM, and runs strictly before the
       * decompressor, so we can make an exception for its r/w data, and 
keep it
       */
+#ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
      *(.data.* .bss.*)
+#else
+    *(.data.efistub .bss.efistub)
+#endif
      __pecoff_data_end = .;

      /*

Which approach do you prefer, or do you have a better way?


> On Tue, Feb 20, 2024, at 10:53, liuyuntao (F) wrote:
>> 在 2024/2/20 16:40, Arnd Bergmann 写道:
>>> On Tue, Feb 20, 2024, at 09:15, Yuntao Liu wrote:
>> #
>> # ARM discards the .data section because it disallows r/w data in the
>> # decompressor. So move our .data to .data.efistub and .bss to .bss.efistub,
>> # which are preserved explicitly by the decompressor linker script.
>> #
>> STUBCOPY_FLAGS-$(CONFIG_ARM)	+= --rename-section .data=.data.efistub	\
>> 				   --rename-section .bss=.bss.efistub,load,alloc
>>
>> ---
>>
>> I think that .data.efistub represents the entire .data section, the same 
>> applies to .bss as well,
>>
>> so i move all .data and .bss into the stub here.
>>
> 
> Ok, I see. 



>>>       __pecoff_data_end = .;
>>>
>>>       /*
>>> @@ -125,7 +125,7 @@ SECTIONS
>>>
>>>     . = BSS_START;
>>>     __bss_start = .;
>>> -  .bss                       : { *(.bss) }
>>> +  .bss                       : { *(.bss .bss.*) }
>>>     _end = .;
>>>
>>>     . = ALIGN(8);              /* the stack must be 64-bit aligned */
>>> diff --git a/arch/arm/include/asm/vmlinux.lds.h
>>> b/arch/arm/include/asm/vmlinux.lds.h
>>> index 4c8632d5c432..dfe2b6ad6b51 100644
>>> --- a/arch/arm/include/asm/vmlinux.lds.h
>>> +++ b/arch/arm/include/asm/vmlinux.lds.h
>>> @@ -42,7 +42,7 @@
>>>   #define PROC_INFO                                                    \
>>>                . = ALIGN(4);                                           \
>>>                __proc_info_begin = .;                                  \
>>> -             *(.proc.info.init)                                      \
>>> +             KEEP(*(.proc.info.init))                                \
>>>                __proc_info_end = .;
>>>
>>>   #define IDMAP_TEXT                                                   \
>>> @@ -87,6 +87,22 @@
>>>                *(.vfp11_veneer)                                        \
>>>                *(.v4_bx)
>>>
>>> +/*
>>> +When CONFIG_LD_DEAD_CODE_DATA_ELIMINATION is enabled, it is important
>>> to
>>> +annotate .vectors sections with KEEP. While linking with ld, it is
>>> +acceptable to directly use KEEP with .vectors sections in ARM_VECTORS.
>>> +However, when using ld.lld for linking, KEEP is not recognized within
>>> the
>>> +OVERLAY command; it is treated as a regular string. Hence, it is
>>> advisable
>>> +to define a distinct section here that explicitly retains the .vectors
>>> +sections when CONFIG_LD_DEAD_CODE_DATA_ELIMINATION is turned on.
>>> +*/
>>> +#define ARM_VECTORS_TEXT                                             \
>>> +     .vectors.text : {                                               \
>>> +             KEEP(*(.vectors))                                       \
>>> +             KEEP(*(.vectors.bhb.loop8))                             \
>>> +             KEEP(*(.vectors.bhb.bpiall))                            \
>>> +       }
>>> +
> 
> This looks fishy to me. How is this supposed to work? You cannot emit
> these sections into some random other place in the binary.
> 
> And also, ARM_VECTORS_TEXT is never used (by accident, see below)

Yes, this way to KEEP .vectors section is not good.

> 
>>>   #define ARM_TEXT                                                     \
>>>                IDMAP_TEXT                                              \
>>>                __entry_text_start = .;                                 \
>>> diff --git a/arch/arm/kernel/vmlinux-xip.lds.S
>>> b/arch/arm/kernel/vmlinux-xip.lds.S
>>> index c16d196b5aad..035fa18060b3 100644
>>> --- a/arch/arm/kernel/vmlinux-xip.lds.S
>>> +++ b/arch/arm/kernel/vmlinux-xip.lds.S
>>> @@ -63,7 +63,7 @@ SECTIONS
>>>        . = ALIGN(4);
>>>        __ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) {
>>>                __start___ex_table = .;
>>> -             ARM_MMU_KEEP(*(__ex_table))
>>> +             ARM_MMU_KEEP(KEEP(*(__ex_table)))
>>>                __stop___ex_table = .;
>>>        }
>>>
>>> @@ -83,7 +83,7 @@ SECTIONS
>>>        }
>>>        .init.arch.info : {
>>>                __arch_info_begin = .;
>>> -             *(.arch.info.init)
>>> +             KEEP(*(.arch.info.init))
>>>                __arch_info_end = .;
>>>        }
>>>        .init.tagtable : {
>>> @@ -135,6 +135,10 @@ SECTIONS
>>>        ARM_TCM
>>>   #endif
>>>
>>> +#ifdef LD_DEAD_CODE_DATA_ELIMINATION
> 
> This should be CONFIG_LD_DEAD_CODE_DATA_ELIMINATION

My mistake, and thank you for pointing out it.

> 
>>> +     ARM_VECTORS_TEXT
>>> +#endif
>>> +
>>>        /*
>>>         * End of copied data. We need a dummy section to get its LMA.
>>>         * Also located before final ALIGN() as trailing padding is not stored
>>> diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
>>> index bd9127c4b451..2cfb890c93fb 100644
>>> --- a/arch/arm/kernel/vmlinux.lds.S
>>> +++ b/arch/arm/kernel/vmlinux.lds.S
>>> @@ -74,7 +74,7 @@ SECTIONS
>>>        . = ALIGN(4);
>>>        __ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) {
>>>                __start___ex_table = .;
>>> -             ARM_MMU_KEEP(*(__ex_table))
>>> +             ARM_MMU_KEEP(KEEP(*(__ex_table)))
>>>                __stop___ex_table = .;
>>>        }
>>>
>>> @@ -99,7 +99,7 @@ SECTIONS
>>>        }
>>>        .init.arch.info : {
>>>                __arch_info_begin = .;
>>> -             *(.arch.info.init)
>>> +             KEEP(*(.arch.info.init))
>>>                __arch_info_end = .;
>>>        }
>>>        .init.tagtable : {
>>> @@ -116,7 +116,7 @@ SECTIONS
>>>   #endif
>>>        .init.pv_table : {
>>>                __pv_table_begin = .;
>>> -             *(.pv_table)
>>> +             KEEP(*(.pv_table))
>>>                __pv_table_end = .;
>>>        }
>>
>> I previously asked about this bit, since it appeared that this
>> might prevent a lot of code from being discarded when
>> CONFIG_ARM_PATCH_PHYS_VIRT is set. I tested this again now,
>> and found this makes very little practical difference, so
>> it's all good.
>>
>>> @@ -134,6 +134,10 @@ SECTIONS
>>>        ARM_TCM
>>>   #endif
>>>
>>> +#ifdef LD_DEAD_CODE_DATA_ELIMINATION
> 
> Same here
> 
> 
>>> +     ARM_VECTORS_TEXT
>>> +#endif
>>> +
>>>   #ifdef CONFIG_STRICT_KERNEL_RWX
>>>        . = ALIGN(1<<SECTION_SHIFT);
>>>   #else

