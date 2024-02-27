Return-Path: <linux-kernel+bounces-82840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68113868A70
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E82901F24A56
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B35F56441;
	Tue, 27 Feb 2024 08:07:04 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4365355E57
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 08:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709021223; cv=none; b=rH7CyZTyLGOnDcM6TfWigk0+gdFAMDCVAJUdYD+PZ9Xh189qMm+a47dCV53NSgfP2PRYtHoIv5pHrQlb6pJj45ESSJD+IW4aQmU66jGAzL5EtOKRJrFhreRrufH1u4zdCnLaMb7aFAkVwz5JidhW3TpzdIZtAEJ28mqkH6uWLuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709021223; c=relaxed/simple;
	bh=el6qsNeaAwUNsgLqdmCw9AHZGV8d1vDRZODuQmwejPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cjY4cNMtV7AVHOrrkbifFgLs6QcJODTJdtLSHULVaVBBuELpBKyIAs6MBe/5WaT7k9wHtktOJw1Q5qAbly4yTJ1r9WRZuAEbvAY9O6+s3fRgkgzX4wkDJSTroaaasfWp/LbuWmlNpWxA4bWL118HXTZul5ssEnL9IZcmvH/xQhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TkVQv59Cqz1xpYd;
	Tue, 27 Feb 2024 16:05:27 +0800 (CST)
Received: from dggpemd100004.china.huawei.com (unknown [7.185.36.20])
	by mail.maildlp.com (Postfix) with ESMTPS id A9D211400F4;
	Tue, 27 Feb 2024 16:06:56 +0800 (CST)
Received: from [10.67.109.211] (10.67.109.211) by
 dggpemd100004.china.huawei.com (7.185.36.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 27 Feb 2024 16:06:56 +0800
Message-ID: <2397d8dd-8053-4167-9aac-f5d7c05a98da@huawei.com>
Date: Tue, 27 Feb 2024 16:06:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] arm32: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Russell King <linux@armlinux.org.uk>, Andrew Davis <afd@ti.com>, Andrew
 Morton <akpm@linux-foundation.org>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Jonathan Corbet <corbet@lwn.net>, Mike Rapoport
	<rppt@kernel.org>, Rob Herring <robh@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>
References: <20240220081527.23408-1-liuyuntao12@huawei.com>
 <1342759e-b967-4ec4-98d5-48146f81f695@app.fastmail.com>
 <38c09a4b-69cc-4dc5-8a68-e5f5597613ac@huawei.com>
 <30b01c65-12f2-4ee0-81d5-c7a2da2c36b4@app.fastmail.com>
 <4e9396ca-460b-49ca-818e-73f0a8997b15@huawei.com>
 <58297ee9-4f33-4b3b-bd00-b44e86965892@app.fastmail.com>
From: "liuyuntao (F)" <liuyuntao12@huawei.com>
In-Reply-To: <58297ee9-4f33-4b3b-bd00-b44e86965892@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemd100004.china.huawei.com (7.185.36.20)



On 2024/2/23 0:04, Arnd Bergmann wrote:
> On Thu, Feb 22, 2024, at 12:24, liuyuntao (F) wrote:
>>
>> The position of the caret has been moved below the right brace
>> of { KEEP(*(.vectors.bhb.loop8)) }, indicating that lld is treating
>> the entire `KEEP(*(.vectors))` as a file name. This could potentially be
>> a bug in lld. Perhaps we can temporarily
>> enable the DCE option only when option LD_IS_LLD is disabled,
>> like risc-v:
>>
>> `select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if !LD_IS_LLD`.
> 
> I would really like to see this working with lld if at all
> possible, as it allows the combination of gc-sections with
> lto and CONFIG_TRIM_UNUSED_KSYMS.
> 
> I experimented with lld myself now and I did get a booting
> kernel even without the the KEEP() on the vectors. I also
> see that this is the only use of OVERLAY in the kernel, so
> I hope that we can find a way to make it work with existing
> lld after all, either without the KEEP or without the OVERLAY.
> 
> Did you see any problems without the KEEP() on the vectors?
> 
>       Arnd

Hi, Arnd. I have added a global symbol g_keep1 in .vectors, g_keep2 in 
vectors.bhb.loop8 and g_keep3 in .vectors.bhb.bpiall respectively. I 
also added another section to reference these three global symbols, to 
prevent these sections from being removed during linking with --gc-sections.

It worked,but there should be a better way to achieve it. the patch:

diff --git a/arch/arm/include/asm/vmlinux.lds.h 
b/arch/arm/include/asm/vmlinux.lds.h
index f2ff79f740ab..d60f6e83a9f7 100644
--- a/arch/arm/include/asm/vmlinux.lds.h
+++ b/arch/arm/include/asm/vmlinux.lds.h
@@ -125,13 +125,13 @@
         __vectors_lma = .;                                              \
         OVERLAY 0xffff0000 : NOCROSSREFS AT(__vectors_lma) {            \
                 .vectors {                                              \
-                       KEEP(*(.vectors))                               \
+                       *(.vectors)                                     \
                 }                                                       \
                 .vectors.bhb.loop8 {                                    \
-                       KEEP(*(.vectors.bhb.loop8))                     \
+                       *(.vectors.bhb.loop8)                           \
                 }                                                       \
                 .vectors.bhb.bpiall {                                   \
-                       KEEP(*(.vectors.bhb.bpiall))                    \
+                       *(.vectors.bhb.bpiall)                          \
                 }                                                       \
         }                                                               \
         ARM_LMA(__vectors, .vectors);                                   \
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 6150a716828c..84536e805da0 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -1075,6 +1075,9 @@ THUMB(    .reloc  ., R_ARM_THM_PC12, 
L__vector_swi               )
         W(b)    vector_addrexcptn
         W(b)    vector_irq
         W(b)    vector_fiq
+       .global g_keep1
+       g_keep1:
+               .word 0

  #ifdef CONFIG_HARDEN_BRANCH_HISTORY
         .section .vectors.bhb.loop8, "ax", %progbits
@@ -1088,6 +1091,9 @@ THUMB(    .reloc  ., R_ARM_THM_PC12, 
L__vector_bhb_loop8_swi     )
         W(b)    vector_addrexcptn
         W(b)    vector_bhb_loop8_irq
         W(b)    vector_bhb_loop8_fiq
+       .global g_keep2
+       g_keep2:
+               .word 0

         .section .vectors.bhb.bpiall, "ax", %progbits
         W(b)    vector_rst
@@ -1100,6 +1106,9 @@ THUMB(    .reloc  ., R_ARM_THM_PC12, 
L__vector_bhb_bpiall_swi    )
         W(b)    vector_addrexcptn
         W(b)    vector_bhb_bpiall_irq
         W(b)    vector_bhb_bpiall_fiq
+       .global g_keep3
+       g_keep3:
+               .word 0
  #endif

         .data
@@ -1108,3 +1117,8 @@ THUMB(    .reloc  ., R_ARM_THM_PC12, 
L__vector_bhb_bpiall_swi    )
         .globl  cr_alignment
  cr_alignment:
         .space  4
+
+.section .keep_vectors, "ax", %progbits
+       LDR r0, =g_keep1
+       LDR r1, =g_keep2
+       LDR r2, =g_keep3
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 01a887c1141a..5cdfb4ba3ac4 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -62,6 +62,7 @@ SECTIONS
         .text : {                       /* Real text segment            */
                 _stext = .;             /* Text and read-only data      */
                 ARM_TEXT
+               KEEP(*(.keep_vectors))
         }

  #ifdef CONFIG_DEBUG_ALIGN_RODATA
-- 
2.34.1

 > I would really like to see this working with lld if at all
 > possible, as it allows the combination of gc-sections with
 > lto and CONFIG_TRIM_UNUSED_KSYMS.
Then, I enabled config CONFIG_LTO_CLANG_THIN in arm32, but
came across a link failure using clang/lld:

following symbols must have non local/private scope:
free_mem_end_ptr
free_mem_ptr
malloc_count
malloc_ptr
output_data

in file arch/arm/boot/compressed/Makefile:
# We need to prevent any GOTOFF relocs being used with references
# to symbols in the .bss section since we cannot relocate them
# independently from the rest at run time.  This can be achieved by
# ensuring that no private .bss symbols exist, as global symbols
# always have a GOT entry which is what we need.
# The .data section is already discarded by the linker script so no need
# to bother about it here.
check_for_bad_syms = \
bad_syms=$$($(NM) $@ | sed -n 's/^.\{8\} [bc] \(.*\)/\1/p') && \
[ -z "$$bad_syms" ] || \
   ( echo "following symbols must have non local/private scope:" >&2; \
     echo "$$bad_syms" >&2; false )

Turn on the config CONFIG_LTO_CLANG_THIN , use nm to check the type of 
these symbols as 'b', turn off the config type to 'B'. I tried to 
explicitly declare these variables using 
__attribute__((visibility("default")), but it didn't take effect on the 
variable `output_data`.
ld.lld: warning: 
thinlto-cache/llvmcache-285C4672B80361F1DA67C743A5C8350FDDEEC8E3:(.data.malloc_ptr) 
is being placed in '.data.':

ld.lld: warning: 
thinlto-cache/llvmcache-285C4672B80361F1DA67C743A5C8350FDDEEC8E3:(.data.malloc_ptr) 
is being placed in '.data.'
ld.lld: warning: 
thinlto-cache/llvmcache-285C4672B80361F1DA67C743A5C8350FDDEEC8E3:(.data.malloc_count) 
is being placed in '.dat'
following symbols must have non local/private scope:
output_data

