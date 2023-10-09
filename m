Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058497BDD07
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376642AbjJINDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376530AbjJINC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:02:58 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C642C91
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 06:02:56 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-406aaccb41dso12397825e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 06:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696856575; x=1697461375; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DyEATBYxN/EkL89zxBGiBE8n5rmmGde+J0DkSI2hwB0=;
        b=YAApl5xiL6APn6jeS/fYn5iro0wwsDL1H8zVI0i/+8ZA5pMo0MlnFlnnDdBjf96Cbk
         BDFaFKHo40hZ+XACz9DCtPF8tLu4AtynxNj8z0WQdEidyeqtEXuz/4ILdAJ4RYDjnoYo
         qd3paIFburkFoTChw4ReLlROrGOiDpj4UIb/ZecRpfqwBlhzUt5+OgnC6CJXEDv+ij2E
         2bNtz2vWCQZe++G0OJ2O7guW3DBmbuAt/YOo4KNlRfFD1gSWmjK80QMP1DBgVbLtXUih
         ny2dw2/iynb43phR2k52GksJBLVsgsSdpQ4PAH3MrIm9d6VXO4iky0Xud0q3joSBjuNw
         Fc4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696856575; x=1697461375;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DyEATBYxN/EkL89zxBGiBE8n5rmmGde+J0DkSI2hwB0=;
        b=F9ZDdLjLpv9GHr9ryCyWXB0hypVBql58grFuQPhM/m5ZTMhNXcnGsGmVwvrAMg/M+c
         /E8NPFe7Xc0K1FmrXQynzM5XihDVpAmpU304SfU+GZckbpVxsJ+1MgTD9px3qorH7cZ2
         0asKQZVd2uJdHUJc88hoeWG/liws68jxOTRb74lhSJsmUxFMcfCmjoeUF0UXQmM7n7Wk
         X7bMx6oOz2M7eQrJJMX6EPaif143oJ2hF/jgki+d9O+HYULczl/302xpN7EaVTeUS80s
         cezrt0jvOvgN9Wt7ReBA3EaFgQJ7bn3GQDyBwdmNCs1Jh0TflscOnPFJUmoJnvEe+Nyu
         oL6A==
X-Gm-Message-State: AOJu0YxIbqZsjVhbNt4k93EA8C57Y4Do0CUyBZwKV35taDz3fhgkztex
        hLkV9wZqnbku+3DNl8yBZBZ9xA==
X-Google-Smtp-Source: AGHT+IGZFkXjSfaTr6s5epagcOuq5I1x+XwJ3YJ+ESkKr9Z5cmbXufBpxZ/oBirro0mpVosmpnhd4Q==
X-Received: by 2002:a05:600c:3ca1:b0:405:3cc1:e115 with SMTP id bg33-20020a05600c3ca100b004053cc1e115mr13919016wmb.3.1696856574428;
        Mon, 09 Oct 2023 06:02:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:b2f5:bf53:6bd1:414e? ([2a01:e0a:999:a3a0:b2f5:bf53:6bd1:414e])
        by smtp.gmail.com with ESMTPSA id v15-20020a5d4b0f000000b00325aca09ad1sm9678417wrq.24.2023.10.09.06.02.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 06:02:54 -0700 (PDT)
Message-ID: <ef02ff0d-10b0-47db-93dc-3cb9f6db140e@rivosinc.com>
Date:   Mon, 9 Oct 2023 15:02:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] riscv: add support for misaligned trap handling in
 S-mode
Content-Language: en-US
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Topel?= <bjorn@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ron Minnich <rminnich@gmail.com>,
        Daniel Maslowski <cyrevolt@googlemail.com>,
        Conor Dooley <conor@kernel.org>
References: <20231004151405.521596-1-cleger@rivosinc.com>
 <20231004151405.521596-3-cleger@rivosinc.com>
 <871qeagw69.fsf@all.your.base.are.belong.to.us>
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <871qeagw69.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/10/2023 19:00, Björn Töpel wrote:
> Clément Léger <cleger@rivosinc.com> writes:
> 
>> Misalignment trap handling is only supported for M-mode and uses direct
>> accesses to user memory. In S-mode, when handling usermode fault, this
>> requires to use the get_user()/put_user() accessors. Implement
>> load_u8(), store_u8() and get_insn() using these accessors for
>> userspace and direct text access for kernel.
>>
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>> ---
>>  arch/riscv/Kconfig                    |   8 ++
>>  arch/riscv/include/asm/entry-common.h |  14 +++
>>  arch/riscv/kernel/Makefile            |   2 +-
>>  arch/riscv/kernel/traps.c             |   9 --
>>  arch/riscv/kernel/traps_misaligned.c  | 119 +++++++++++++++++++++++---
>>  5 files changed, 129 insertions(+), 23 deletions(-)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index d607ab0f7c6d..6e167358a897 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -636,6 +636,14 @@ config THREAD_SIZE_ORDER
>>  	  Specify the Pages of thread stack size (from 4KB to 64KB), which also
>>  	  affects irq stack size, which is equal to thread stack size.
>>  
>> +config RISCV_MISALIGNED
>> +	bool "Support misaligned load/store traps for kernel and userspace"
>> +	default y
>> +	help
>> +	  Say Y here if you want the kernel to embed support for misaligned
>> +	  load/store for both kernel and userspace. When disable, misaligned
>> +	  accesses will generate SIGBUS in userspace and panic in kernel.
>> +
>>  endmenu # "Platform type"
>>  
>>  menu "Kernel features"
>> diff --git a/arch/riscv/include/asm/entry-common.h b/arch/riscv/include/asm/entry-common.h
>> index 6e4dee49d84b..7ab5e34318c8 100644
>> --- a/arch/riscv/include/asm/entry-common.h
>> +++ b/arch/riscv/include/asm/entry-common.h
>> @@ -8,4 +8,18 @@
>>  void handle_page_fault(struct pt_regs *regs);
>>  void handle_break(struct pt_regs *regs);
>>  
>> +#ifdef CONFIG_RISCV_MISALIGNED
>> +int handle_misaligned_load(struct pt_regs *regs);
>> +int handle_misaligned_store(struct pt_regs *regs);
>> +#else
>> +static inline int handle_misaligned_load(struct pt_regs *regs)
>> +{
>> +	return -1;
>> +}
>> +static inline int handle_misaligned_store(struct pt_regs *regs)
>> +{
>> +	return -1;
>> +}
>> +#endif
>> +
>>  #endif /* _ASM_RISCV_ENTRY_COMMON_H */
>> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
>> index 95cf25d48405..0d874fb24b51 100644
>> --- a/arch/riscv/kernel/Makefile
>> +++ b/arch/riscv/kernel/Makefile
>> @@ -59,7 +59,7 @@ obj-y	+= patch.o
>>  obj-y	+= probes/
>>  obj-$(CONFIG_MMU) += vdso.o vdso/
>>  
>> -obj-$(CONFIG_RISCV_M_MODE)	+= traps_misaligned.o
>> +obj-$(CONFIG_RISCV_MISALIGNED)	+= traps_misaligned.o
>>  obj-$(CONFIG_FPU)		+= fpu.o
>>  obj-$(CONFIG_RISCV_ISA_V)	+= vector.o
>>  obj-$(CONFIG_SMP)		+= smpboot.o
>> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
>> index 19807c4d3805..d69779e4b967 100644
>> --- a/arch/riscv/kernel/traps.c
>> +++ b/arch/riscv/kernel/traps.c
>> @@ -179,14 +179,6 @@ asmlinkage __visible __trap_section void do_trap_insn_illegal(struct pt_regs *re
>>  
>>  DO_ERROR_INFO(do_trap_load_fault,
>>  	SIGSEGV, SEGV_ACCERR, "load access fault");
>> -#ifndef CONFIG_RISCV_M_MODE
>> -DO_ERROR_INFO(do_trap_load_misaligned,
>> -	SIGBUS, BUS_ADRALN, "Oops - load address misaligned");
>> -DO_ERROR_INFO(do_trap_store_misaligned,
>> -	SIGBUS, BUS_ADRALN, "Oops - store (or AMO) address misaligned");
>> -#else
>> -int handle_misaligned_load(struct pt_regs *regs);
>> -int handle_misaligned_store(struct pt_regs *regs);
>>  
>>  asmlinkage __visible __trap_section void do_trap_load_misaligned(struct pt_regs *regs)
>>  {
>> @@ -229,7 +221,6 @@ asmlinkage __visible __trap_section void do_trap_store_misaligned(struct pt_regs
>>  		irqentry_nmi_exit(regs, state);
>>  	}
>>  }
>> -#endif
>>  DO_ERROR_INFO(do_trap_store_fault,
>>  	SIGSEGV, SEGV_ACCERR, "store (or AMO) access fault");
>>  DO_ERROR_INFO(do_trap_ecall_s,
>> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
>> index e7bfb33089c1..9daed7d756ae 100644
>> --- a/arch/riscv/kernel/traps_misaligned.c
>> +++ b/arch/riscv/kernel/traps_misaligned.c
>> @@ -12,6 +12,7 @@
>>  #include <asm/processor.h>
>>  #include <asm/ptrace.h>
>>  #include <asm/csr.h>
>> +#include <asm/entry-common.h>
>>  
>>  #define INSN_MATCH_LB			0x3
>>  #define INSN_MASK_LB			0x707f
>> @@ -151,21 +152,25 @@
>>  #define PRECISION_S 0
>>  #define PRECISION_D 1
>>  
>> -static inline u8 load_u8(const u8 *addr)
>> +#ifdef CONFIG_RISCV_M_MODE
>> +static inline int load_u8(struct pt_regs *regs, const u8 *addr, u8 *r_val)
>>  {
>>  	u8 val;
>>  
>>  	asm volatile("lbu %0, %1" : "=&r" (val) : "m" (*addr));
>> +	*r_val = val;
>>  
>> -	return val;
>> +	return 0;
>>  }
>>  
>> -static inline void store_u8(u8 *addr, u8 val)
>> +static inline int store_u8(struct pt_regs *regs, u8 *addr, u8 val)
>>  {
>>  	asm volatile ("sb %0, %1\n" : : "r" (val), "m" (*addr));
>> +
>> +	return 0;
>>  }
>>  
>> -static inline ulong get_insn(ulong mepc)
>> +static inline int get_insn(struct pt_regs *regs, ulong mepc, ulong *r_insn)
>>  {
>>  	register ulong __mepc asm ("a2") = mepc;
>>  	ulong val, rvc_mask = 3, tmp;
>> @@ -194,9 +199,87 @@ static inline ulong get_insn(ulong mepc)
>>  	: [addr] "r" (__mepc), [rvc_mask] "r" (rvc_mask),
>>  	  [xlen_minus_16] "i" (XLEN_MINUS_16));
>>  
>> -	return val;
>> +	*r_insn = val;
>> +
>> +	return 0;
>> +}
>> +#else
>> +static inline int load_u8(struct pt_regs *regs, const u8 *addr, u8 *r_val)
>> +{
>> +	if (user_mode(regs)) {
>> +		return __get_user(*r_val, addr);
>> +	} else {
>> +		*r_val = *addr;
>> +		return 0;
>> +	}
> 
> One nit (...well two) ;-)
> 
> If you're respinning I'd get rid of the "inlines",and personally I
> think early exit is easier to read. Applies to the whole patch.

Noted, I'll fix that (checkpatch suggested it so that makes sense).

Clément

> 
>   | {
>   | 	if (user_mode(regs))
>   | 		return __get_user(*r_val, addr);
>   | 
>   |         *r_val = *addr;
>   | 	return 0;
>   | }
> 
> 
> Regardless if you change or not,
> 
> Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
