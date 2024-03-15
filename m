Return-Path: <linux-kernel+bounces-104136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D104D87C996
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65BEC1F212EA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A0E14AAD;
	Fri, 15 Mar 2024 08:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSHLSHYN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6466B14A81
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 08:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710490005; cv=none; b=ZTYVtpEkBhHBGKxLnH5KRtbTReOuNQf+86Gq/FhDkQx6qfVZQk13utZAaKITx2AyVycNi/PGv+BG3hpLTq/jBp6a0hGU6sXmyuziEqMZOte3g7arVIzbAXNfKWBQDFxEmqX8Hk7CpDHQzh5SEqF75t3qGJt6qUDsb8cdCYUHM0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710490005; c=relaxed/simple;
	bh=5JjXqE38u0wCIujr+4TRlsMSuwAm9YX6+YLBWQQO298=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RQdzqMTEdh1vriSAUAumEz9kR+LpmU/k5lktlwbIwZwIpFxF74nZHMXBzpyWLAB+mXKyzBzFEqu90FSmH6x6dTkQmaNXIFNxdZ3EAFCjQWH4TNWvluk221VZOCXWHO50PdKq7xW9rlElZM38IGy26QjbJH58tOkcuxmtY4n7JLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSHLSHYN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6FCC43601
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 08:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710490004;
	bh=5JjXqE38u0wCIujr+4TRlsMSuwAm9YX6+YLBWQQO298=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oSHLSHYNGzylGeM5jnKKBPjreaWnn09LLn6wJZqiB/E/ke/G8sBe566FNVRNegpWB
	 fK2SAmCZazT8j9XYxrJm0zvvIlviHrN9lLIaVYOsvH29P7RGuH/92L51HJd2+b6E1c
	 v9VaEwrDoG5PvWUWhmhQNm8j1fXVgrCl2lyurcNFv/BsSQMkXMUjLr3K9pPSjDu/Sw
	 SRLO3mYuOqSZ2Zg5TLJcynMPZ3AEm2SpGplxa2wBOrztM++oGBsWG2XCrLevhSWNiB
	 W8ChQlwGcZuGgeHtajANJOaiavnkSdkfSDfV8CnYszKevg9EjmDcYpCYEV0NJrT17h
	 S2zspi5QwiHyw==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d4541bf57eso23315281fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 01:06:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU9Nlf1APXUcjoGeUdWnRll4SEyl36orxU2fCA2e5cPX4r2F+ZcTFpuHd4uKCX8QyfN2+HrrbbHBLzEkyzHqeTwBZY31d0v6pjVggGC
X-Gm-Message-State: AOJu0Yy2oGEHMd4aXdF6+0nSxvsgAriFdI18a0Hqp/TGS4twEHLiIaqd
	5iVDfM89FCNsw2NrzGV3B/uOt4j8iiWts7bq0eeQ7MMRfpfgC2kD2e09UKI/xj1fs8OVkGLVSHB
	7u3SDTfdQN3wtF+wS4RRW41z9ztY=
X-Google-Smtp-Source: AGHT+IFc1FAwEp/Ie3iwJRtFwE551q+JfGcABAQzn89RhJdhgQgQNKNmApZYs2m5wSh8ve2nmrWUuEcL2OonYiSHE7I=
X-Received: by 2002:a2e:90ce:0:b0:2d4:67e3:aa47 with SMTP id
 o14-20020a2e90ce000000b002d467e3aa47mr2640997ljg.48.1710490003010; Fri, 15
 Mar 2024 01:06:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315063154.696633-1-liuyuntao12@huawei.com>
In-Reply-To: <20240315063154.696633-1-liuyuntao12@huawei.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 15 Mar 2024 09:06:31 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH+FaddHV5--kqB_wVgw_M682MvchPB1BoCuDuA6vVyvg@mail.gmail.com>
Message-ID: <CAMj1kXH+FaddHV5--kqB_wVgw_M682MvchPB1BoCuDuA6vVyvg@mail.gmail.com>
Subject: Re: [PATCH-next v3] arm32: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
To: Yuntao Liu <liuyuntao12@huawei.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	arnd@arndb.de, geert@linux-m68k.org, linux@armlinux.org.uk, afd@ti.com, 
	akpm@linux-foundation.org, kirill.shutemov@linux.intel.com, 
	geert+renesas@glider.be, corbet@lwn.net, rppt@kernel.org, robh@kernel.org, 
	tglx@linutronix.de, linus.walleij@linaro.org, maskray@google.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Mar 2024 at 07:37, Yuntao Liu <liuyuntao12@huawei.com> wrote:
>
> The current arm32 architecture does not yet support the
> HAVE_LD_DEAD_CODE_DATA_ELIMINATION feature. arm32 is widely used in
> embedded scenarios, and enabling this feature would be beneficial for
> reducing the size of the kernel image.
>
> In order to make this work, we keep the necessary tables by annotating
> them with KEEP, also it requires further changes to linker script to KEEP
> some tables and wildcard compiler generated sections into the right place.
> When using ld.lld for linking, the KEEP keyword is not recognized within
> the OVERLAY command, Ard proposed a concise method to solve this problem.
>
> It boots normally with defconfig, vexpress_defconfig and tinyconfig.
> The size comparison of zImage is as follows:
> defconfig       vexpress_defconfig      tinyconfig
> 5137712         5138024                 424192          no dce
> 5032560         4997824                 298384          dce
> 2.0%            2.7%                    29.7%           shrink
>
> When using smaller config file, there is a significant reduction in the
> size of the zImage.
>
> We also tested this patch on a commercially available single-board
> computer, and the comparison is as follows:
> a15eb_config
> 2161384         no dce
> 2092240         dce
> 3.2%            shrink
>
> The zImage size has been reduced by approximately 3.2%, which is 70KB on
> 2.1M.
>
> Signed-off-by: Yuntao Liu <liuyuntao12@huawei.com>
> Tested-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v3:
>    - A better way to KEEP .vectors section for ld.lld linking.
>
> v2:
>    - Support config XIP_KERNEL.
>    - Support LLVM compilation.
>    - https://lore.kernel.org/all/20240307151231.654025-1-liuyuntao12@huawei.com/
>
> v1: https://lore.kernel.org/all/20240220081527.23408-1-liuyuntao12@huawei.com/
> ---
>  arch/arm/Kconfig                       | 1 +
>  arch/arm/boot/compressed/vmlinux.lds.S | 6 +++++-
>  arch/arm/include/asm/vmlinux.lds.h     | 2 +-
>  arch/arm/kernel/entry-armv.S           | 3 +++
>  arch/arm/kernel/vmlinux-xip.lds.S      | 4 ++--
>  arch/arm/kernel/vmlinux.lds.S          | 6 +++---
>  6 files changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index b14aed3a17ab..45f25f6e7a62 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -114,6 +114,7 @@ config ARM
>         select HAVE_KERNEL_XZ
>         select HAVE_KPROBES if !XIP_KERNEL && !CPU_ENDIAN_BE32 && !CPU_V7M
>         select HAVE_KRETPROBES if HAVE_KPROBES
> +       select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
>         select HAVE_MOD_ARCH_SPECIFIC
>         select HAVE_NMI
>         select HAVE_OPTPROBES if !THUMB2_KERNEL
> diff --git a/arch/arm/boot/compressed/vmlinux.lds.S b/arch/arm/boot/compressed/vmlinux.lds.S
> index 3fcb3e62dc56..affd30714f01 100644
> --- a/arch/arm/boot/compressed/vmlinux.lds.S
> +++ b/arch/arm/boot/compressed/vmlinux.lds.S
> @@ -89,7 +89,11 @@ SECTIONS
>       * The EFI stub always executes from RAM, and runs strictly before the
>       * decompressor, so we can make an exception for its r/w data, and keep it
>       */
> +#ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
> +    *(.data.* .bss.*)
> +#else
>      *(.data.efistub .bss.efistub)
> +#endif
>      __pecoff_data_end = .;
>

This is still not right.

Can you just add -fno-data-sections to cflags-$(CONFIG_ARM) in
drivers/firmware/efi/libstub/Makefile?


>      /*
> @@ -125,7 +129,7 @@ SECTIONS
>
>    . = BSS_START;
>    __bss_start = .;
> -  .bss                 : { *(.bss) }
> +  .bss                 : { *(.bss .bss.*) }
>    _end = .;
>
>    . = ALIGN(8);                /* the stack must be 64-bit aligned */
> diff --git a/arch/arm/include/asm/vmlinux.lds.h b/arch/arm/include/asm/vmlinux.lds.h
> index 4c8632d5c432..d60f6e83a9f7 100644
> --- a/arch/arm/include/asm/vmlinux.lds.h
> +++ b/arch/arm/include/asm/vmlinux.lds.h
> @@ -42,7 +42,7 @@
>  #define PROC_INFO                                                      \
>                 . = ALIGN(4);                                           \
>                 __proc_info_begin = .;                                  \
> -               *(.proc.info.init)                                      \
> +               KEEP(*(.proc.info.init))                                \
>                 __proc_info_end = .;
>
>  #define IDMAP_TEXT                                                     \
> diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
> index 6150a716828c..f01d23a220e6 100644
> --- a/arch/arm/kernel/entry-armv.S
> +++ b/arch/arm/kernel/entry-armv.S
> @@ -1065,6 +1065,7 @@ vector_addrexcptn:
>         .globl  vector_fiq
>
>         .section .vectors, "ax", %progbits
> +       .reloc  .text, R_ARM_NONE, .
>         W(b)    vector_rst
>         W(b)    vector_und
>  ARM(   .reloc  ., R_ARM_LDR_PC_G0, .L__vector_swi              )
> @@ -1078,6 +1079,7 @@ THUMB(    .reloc  ., R_ARM_THM_PC12, .L__vector_swi               )
>
>  #ifdef CONFIG_HARDEN_BRANCH_HISTORY
>         .section .vectors.bhb.loop8, "ax", %progbits
> +       .reloc  .text, R_ARM_NONE, .
>         W(b)    vector_rst
>         W(b)    vector_bhb_loop8_und
>  ARM(   .reloc  ., R_ARM_LDR_PC_G0, .L__vector_bhb_loop8_swi    )
> @@ -1090,6 +1092,7 @@ THUMB(    .reloc  ., R_ARM_THM_PC12, .L__vector_bhb_loop8_swi     )
>         W(b)    vector_bhb_loop8_fiq
>
>         .section .vectors.bhb.bpiall, "ax", %progbits
> +       .reloc  .text, R_ARM_NONE, .
>         W(b)    vector_rst
>         W(b)    vector_bhb_bpiall_und
>  ARM(   .reloc  ., R_ARM_LDR_PC_G0, .L__vector_bhb_bpiall_swi   )
> diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
> index c16d196b5aad..5eddb75a7174 100644
> --- a/arch/arm/kernel/vmlinux-xip.lds.S
> +++ b/arch/arm/kernel/vmlinux-xip.lds.S
> @@ -63,7 +63,7 @@ SECTIONS
>         . = ALIGN(4);
>         __ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) {
>                 __start___ex_table = .;
> -               ARM_MMU_KEEP(*(__ex_table))
> +               ARM_MMU_KEEP(KEEP(*(__ex_table)))
>                 __stop___ex_table = .;
>         }
>
> @@ -83,7 +83,7 @@ SECTIONS
>         }
>         .init.arch.info : {
>                 __arch_info_begin = .;
> -               *(.arch.info.init)
> +               KEEP(*(.arch.info.init))
>                 __arch_info_end = .;
>         }
>         .init.tagtable : {
> diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
> index bd9127c4b451..de373c6c2ae8 100644
> --- a/arch/arm/kernel/vmlinux.lds.S
> +++ b/arch/arm/kernel/vmlinux.lds.S
> @@ -74,7 +74,7 @@ SECTIONS
>         . = ALIGN(4);
>         __ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) {
>                 __start___ex_table = .;
> -               ARM_MMU_KEEP(*(__ex_table))
> +               ARM_MMU_KEEP(KEEP(*(__ex_table)))
>                 __stop___ex_table = .;
>         }
>
> @@ -99,7 +99,7 @@ SECTIONS
>         }
>         .init.arch.info : {
>                 __arch_info_begin = .;
> -               *(.arch.info.init)
> +               KEEP(*(.arch.info.init))
>                 __arch_info_end = .;
>         }
>         .init.tagtable : {
> @@ -116,7 +116,7 @@ SECTIONS
>  #endif
>         .init.pv_table : {
>                 __pv_table_begin = .;
> -               *(.pv_table)
> +               KEEP(*(.pv_table))
>                 __pv_table_end = .;
>         }
>
> --
> 2.34.1
>

