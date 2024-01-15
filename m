Return-Path: <linux-kernel+bounces-25763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2721382D56A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92A16B21432
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CD2C130;
	Mon, 15 Jan 2024 08:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Am3pX1MB"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75054BE73
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 08:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e60d74b81so1407645e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 00:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705309064; x=1705913864; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CazGSXwdcpPxFBxKppxDhdiPA+kZIHhA11pNpO0o5ko=;
        b=Am3pX1MBVzPmDABepf8NXOiVYHW1H4qf598tjR2rmiVeiMnmXbyr3M/YqSTbWWlGyk
         fzydRaj4EIix9wLyenxv7X5W19sGjs78t/5zHuJ88GYOGl4cUdpbKvLojnk0U930Se9J
         zszscfWv3FnboxYb6GI4+/XeqYZOVC8y6JgoXX+B1vn12NZDScUuXnO+S5P3vlZagizu
         cT67zCGcfReBX4FIXGXrmJG0CRZLv3pP7uMZrBkmi0Y15vukZoG/CUGEzWPEegyFZ+am
         +eMaou+Qojh5G1mYeYH4yf+rjCD4FYx8Lm9qFTZS5ksOkHZDpyifF1s/fBKJnzAbHayW
         9lYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705309064; x=1705913864;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CazGSXwdcpPxFBxKppxDhdiPA+kZIHhA11pNpO0o5ko=;
        b=WKfqZAHYAtWzOIqkzxwHjItxsK2f4RCWZDxHfnyYLAAvJogIbzP22XqKPkbmi7NlTd
         c+tnqYE5a7/4BbkTgVWxrNd6HPjLWb8AtUyJuFh/mOeqRfwP9TVB6iBXmIm0Efz54lfx
         ktU0RqDgd+HCzej/TRAkJsylqb7nrvzoMSHnGxrkv9wctkTYx9VxPnZBx9caMTDaB/cq
         pHqbk9qMlpgwGZVcwo/W6/bYuQzTXLrIy+sVXNGXmaKC4tLB/MfiPZBOu9pxOyCQQemO
         C5gC8YUYjQW1vPzNGYBbCyPKQLAWfFyu8oSxElcvZekRVjDlEme/ZhSbjpL6s7BXaLqb
         uY4A==
X-Gm-Message-State: AOJu0YyStE/Kfj/dZLstSc1fTjAjVmkG5L2nJKqrgejvkoq1pw4CAJ0G
	7qEzj/y3bDTbXJKOWI911leWOMciySVqxQ==
X-Google-Smtp-Source: AGHT+IGio3C4U6p8gJYLTJB+ni1vOBoqU4T+Ju98KP5Ab87TKdNVud5T96IEQ4fMt2lA33ktXlxNDA==
X-Received: by 2002:a05:600c:1c88:b0:40e:52a4:f275 with SMTP id k8-20020a05600c1c8800b0040e52a4f275mr6388988wms.3.1705309064249;
        Mon, 15 Jan 2024 00:57:44 -0800 (PST)
Received: from ?IPV6:2a01:e0a:999:a3a0:2776:b76f:d500:7056? ([2a01:e0a:999:a3a0:2776:b76f:d500:7056])
        by smtp.gmail.com with ESMTPSA id c11-20020a05600c0a4b00b0040d53588d94sm19150611wmq.46.2024.01.15.00.57.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 00:57:43 -0800 (PST)
Message-ID: <38fb1df5-e828-4c8c-8e23-6e12b1f12cd9@rivosinc.com>
Date: Mon, 15 Jan 2024 09:57:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/3] riscv: add support for SBI Supervisor Software
 Events extension
Content-Language: en-US
To: Deepak Gupta <debug@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Atish Patra <atishp@atishpatra.org>, Anup Patel <apatel@ventanamicro.com>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Himanshu Chauhan <hchauhan@ventanamicro.com>,
 Xu Lu <luxu.kernel@bytedance.com>
References: <20240112111720.2975069-1-cleger@rivosinc.com>
 <20240112111720.2975069-3-cleger@rivosinc.com>
 <ZaHcsh40zuoQOq/h@debug.ba.rivosinc.com>
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <ZaHcsh40zuoQOq/h@debug.ba.rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Deepak,

On 13/01/2024 01:43, Deepak Gupta wrote:
> On Fri, Jan 12, 2024 at 12:17:14PM +0100, Clément Léger wrote:
>> The SBI SSE extension allows the supervisor software to be notified by
>> the SBI of specific events that are not maskable. The context switch is
>> handled partially by the firmware which will save registers a0, a6, a7.
>> When entering kernel we can rely on these 3 registers to setup the stack
>> and save all the registers.
>>
>> Since each events (and each CPU for local events) have their own
>> context and can preempt each other, allocate a stack for each of them
>> (and for each cpu for local events).
>>
>> When completing the event, if we were coming from kernel with interrupts
>> disabled, simply return there. If coming from userspace or kernel with
>> interrupts enabled, simulate an interrupt exception to allow delivery of
>> signal to user task. For instance this can happen, when a RAS event has
>> been generated and a SIGBUS has been sent to a task.
>>
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>> ---
>> arch/riscv/include/asm/asm-prototypes.h |   4 +
>> arch/riscv/include/asm/asm.h            |  42 +-
>> arch/riscv/include/asm/scs.h            |   7 +
>> arch/riscv/include/asm/sse.h            |  12 +
>> arch/riscv/include/asm/thread_info.h    |   1 +
>> arch/riscv/kernel/Makefile              |   1 +
>> arch/riscv/kernel/asm-offsets.c         |  26 ++
>> arch/riscv/kernel/entry.S               | 202 +++++++++
>> arch/riscv/kernel/sse.c                 | 130 ++++++
>> arch/riscv/kernel/stacktrace.c          |  13 +
>> arch/riscv/kernel/vmlinux.lds.S         |   6 +
>> drivers/firmware/Kconfig                |  10 +
>> drivers/firmware/Makefile               |   1 +
>> drivers/firmware/riscv_sse.c            | 567 ++++++++++++++++++++++++
>> include/linux/riscv_sse.h               |  76 ++++
>> 15 files changed, 1089 insertions(+), 9 deletions(-)
>> create mode 100644 arch/riscv/include/asm/sse.h
>> create mode 100644 arch/riscv/kernel/sse.c
>> create mode 100644 drivers/firmware/riscv_sse.c
>> create mode 100644 include/linux/riscv_sse.h
>>
>> diff --git a/arch/riscv/include/asm/asm-prototypes.h
>> b/arch/riscv/include/asm/asm-prototypes.h
>> index 36b955c762ba..d163912166d4 100644
>> --- a/arch/riscv/include/asm/asm-prototypes.h
>> +++ b/arch/riscv/include/asm/asm-prototypes.h
>> @@ -3,6 +3,8 @@
>> #define _ASM_RISCV_PROTOTYPES_H
>>
>> #include <linux/ftrace.h>
>> +#include <linux/riscv_sse.h>
>> +#include <asm/sse.h>
>> #include <asm-generic/asm-prototypes.h>
>>
>> long long __lshrti3(long long a, int b);
>> @@ -28,5 +30,7 @@ DECLARE_DO_ERROR_INFO(do_trap_break);
>> asmlinkage void handle_bad_stack(struct pt_regs *regs);
>> asmlinkage void do_page_fault(struct pt_regs *regs);
>> asmlinkage void do_irq(struct pt_regs *regs);
>> +asmlinkage void do_sse(struct sse_registered_event *reg_evt,
>> +                struct pt_regs *reg);
>>
>> #endif /* _ASM_RISCV_PROTOTYPES_H */
>> diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
>> index b0487b39e674..b5cdd791fc26 100644
>> --- a/arch/riscv/include/asm/asm.h
>> +++ b/arch/riscv/include/asm/asm.h
>> @@ -123,20 +123,16 @@
>> .endm
>> #endif /* CONFIG_SHADOW_CALL_STACK */
>>
>> -    /* save all GPs except x1 ~ x5 */
>> -    .macro save_from_x6_to_x31
>> +    .macro save_x6_to_x31_except_x10_x16_x17
>>     REG_S x6,  PT_T1(sp)
>>     REG_S x7,  PT_T2(sp)
>>     REG_S x8,  PT_S0(sp)
>>     REG_S x9,  PT_S1(sp)
>> -    REG_S x10, PT_A0(sp)
>>     REG_S x11, PT_A1(sp)
>>     REG_S x12, PT_A2(sp)
>>     REG_S x13, PT_A3(sp)
>>     REG_S x14, PT_A4(sp)
>>     REG_S x15, PT_A5(sp)
>> -    REG_S x16, PT_A6(sp)
>> -    REG_S x17, PT_A7(sp)
>>     REG_S x18, PT_S2(sp)
>>     REG_S x19, PT_S3(sp)
>>     REG_S x20, PT_S4(sp)
>> @@ -153,20 +149,33 @@
>>     REG_S x31, PT_T6(sp)
>>     .endm
>>
>> +    /* save all GPs except x1 ~ x5 */
>> +    .macro save_from_x6_to_x31
>> +    save_x6_to_x31_except_x10_x16_x17
>> +    REG_S x10, PT_A0(sp)
>> +    REG_S x16, PT_A6(sp)
>> +    REG_S x17, PT_A7(sp)
>> +    .endm
>> +
>> +    .macro save_regs_for_sse
>> +    save_x6_to_x31_except_x10_x16_x17
>> +    REG_S ra,  PT_RA(sp)
>> +    REG_S gp,  PT_GP(sp)
>> +    REG_S tp,  PT_TP(sp)
>> +    REG_S t0,  PT_T0(sp)
>> +    .endm
>> +
>>     /* restore all GPs except x1 ~ x5 */
>> -    .macro restore_from_x6_to_x31
>> +    .macro restore_from_x6_to_x31_except_x10_x16_x17
>>     REG_L x6,  PT_T1(sp)
>>     REG_L x7,  PT_T2(sp)
>>     REG_L x8,  PT_S0(sp)
>>     REG_L x9,  PT_S1(sp)
>> -    REG_L x10, PT_A0(sp)
>>     REG_L x11, PT_A1(sp)
>>     REG_L x12, PT_A2(sp)
>>     REG_L x13, PT_A3(sp)
>>     REG_L x14, PT_A4(sp)
>>     REG_L x15, PT_A5(sp)
>> -    REG_L x16, PT_A6(sp)
>> -    REG_L x17, PT_A7(sp)
>>     REG_L x18, PT_S2(sp)
>>     REG_L x19, PT_S3(sp)
>>     REG_L x20, PT_S4(sp)
>> @@ -183,6 +192,21 @@
>>     REG_L x31, PT_T6(sp)
>>     .endm
>>
>> +    .macro restore_from_x6_to_x31
>> +    restore_from_x6_to_x31_except_x10_x16_x17
>> +    REG_L x10, PT_A0(sp)
>> +    REG_L x16, PT_A6(sp)
>> +    REG_L x17, PT_A7(sp)
>> +    .endm
>> +
>> +    .macro restore_regs_for_sse
>> +    restore_from_x6_to_x31_except_x10_x16_x17
>> +    REG_L ra,  PT_RA(sp)
>> +    REG_L gp,  PT_GP(sp)
>> +    REG_L tp,  PT_TP(sp)
>> +    REG_L t0,  PT_T0(sp)
>> +    .endm
>> +
>> #endif /* __ASSEMBLY__ */
>>
>> #endif /* _ASM_RISCV_ASM_H */
>> diff --git a/arch/riscv/include/asm/scs.h b/arch/riscv/include/asm/scs.h
>> index 0e45db78b24b..62344daad73d 100644
>> --- a/arch/riscv/include/asm/scs.h
>> +++ b/arch/riscv/include/asm/scs.h
>> @@ -18,6 +18,11 @@
>>     load_per_cpu gp, irq_shadow_call_stack_ptr, \tmp
>> .endm
>>
>> +/* Load the per-CPU IRQ shadow call stack to gp. */
>> +.macro scs_load_sse_stack reg_evt
>> +    REG_L gp, SSE_REG_EVT_SHADOW_STACK(\reg_evt)
>> +.endm
>> +
>> /* Load task_scs_sp(current) to gp. */
>> .macro scs_load_current
>>     REG_L    gp, TASK_TI_SCS_SP(tp)
>> @@ -41,6 +46,8 @@
>> .endm
>> .macro scs_load_irq_stack tmp
>> .endm
>> +.macro scs_load_sse_stack reg_evt
>> +.endm
>> .macro scs_load_current
>> .endm
>> .macro scs_load_current_if_task_changed prev
>> diff --git a/arch/riscv/include/asm/sse.h b/arch/riscv/include/asm/sse.h
>> new file mode 100644
>> index 000000000000..7f8e6f09085c
>> --- /dev/null
>> +++ b/arch/riscv/include/asm/sse.h
>> @@ -0,0 +1,12 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (C) 2023 Rivos Inc.
>> + */
>> +#ifndef __ASM_SSE_H
>> +#define __ASM_SSE_H
>> +
>> +struct sse_registered_event;
>> +int sse_init_event(int cpu, struct sse_registered_event *reg_evt);
>> +void sse_free_event(struct sse_registered_event *reg_evt);
>> +
>> +#endif
>> diff --git a/arch/riscv/include/asm/thread_info.h
>> b/arch/riscv/include/asm/thread_info.h
>> index 574779900bfb..90f357dc5bf3 100644
>> --- a/arch/riscv/include/asm/thread_info.h
>> +++ b/arch/riscv/include/asm/thread_info.h
>> @@ -31,6 +31,7 @@
>> #define SHADOW_OVERFLOW_STACK_SIZE (1024)
>>
>> #define IRQ_STACK_SIZE        THREAD_SIZE
>> +#define SSE_STACK_SIZE        THREAD_SIZE
>>
>> #ifndef __ASSEMBLY__
>>
>> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
>> index fee22a3d1b53..a2febdc1618b 100644
>> --- a/arch/riscv/kernel/Makefile
>> +++ b/arch/riscv/kernel/Makefile
>> @@ -80,6 +80,7 @@ obj-$(CONFIG_DYNAMIC_FTRACE)    += mcount-dyn.o
>> obj-$(CONFIG_PERF_EVENTS)    += perf_callchain.o
>> obj-$(CONFIG_HAVE_PERF_REGS)    += perf_regs.o
>> obj-$(CONFIG_RISCV_SBI)        += sbi.o
>> +obj-$(CONFIG_RISCV_SSE)        += sse.o
>> ifeq ($(CONFIG_RISCV_SBI), y)
>> obj-$(CONFIG_SMP)        += sbi-ipi.o
>> obj-$(CONFIG_SMP) += cpu_ops_sbi.o
>> diff --git a/arch/riscv/kernel/asm-offsets.c
>> b/arch/riscv/kernel/asm-offsets.c
>> index a03129f40c46..eee99c0fbd27 100644
>> --- a/arch/riscv/kernel/asm-offsets.c
>> +++ b/arch/riscv/kernel/asm-offsets.c
>> @@ -10,12 +10,16 @@
>> #include <linux/mm.h>
>> #include <linux/sched.h>
>> #include <linux/suspend.h>
>> +#include <linux/riscv_sse.h>
>> #include <asm/kvm_host.h>
>> #include <asm/thread_info.h>
>> #include <asm/ptrace.h>
>> #include <asm/cpu_ops_sbi.h>
>> #include <asm/stacktrace.h>
>> +#include <asm/sbi.h>
>> +#include <asm/sse.h>
>> #include <asm/suspend.h>
>> +#include <asm/stacktrace.h>
>>
>> void asm_offsets(void);
>>
>> @@ -488,4 +492,26 @@ void asm_offsets(void)
>>     DEFINE(STACKFRAME_SIZE_ON_STACK, ALIGN(sizeof(struct stackframe),
>> STACK_ALIGN));
>>     OFFSET(STACKFRAME_FP, stackframe, fp);
>>     OFFSET(STACKFRAME_RA, stackframe, ra);
>> +
>> +#ifdef CONFIG_RISCV_SSE
>> +    OFFSET(SSE_REG_EVT_STACK, sse_registered_event, stack);
>> +    OFFSET(SSE_REG_EVT_SHADOW_STACK, sse_registered_event,
>> shadow_stack);
>> +    OFFSET(SSE_REG_EVT_EVT_ID, sse_registered_event, evt_id);
>> +    OFFSET(SSE_REG_EVT_STATE, sse_registered_event, state);
>> +    OFFSET(SSE_REG_EVT_STATE_PHYS, sse_registered_event, state_phys);
>> +    OFFSET(SSE_REG_EVT_STATE_MODE, sse_registered_event, state.mode);
>> +    OFFSET(SSE_REG_EVT_STATE_PC, sse_registered_event, state.pc);
>> +    OFFSET(SSE_REG_EVT_STATE_A0, sse_registered_event, state.a0);
>> +    OFFSET(SSE_REG_EVT_STATE_A6, sse_registered_event, state.a6);
>> +    OFFSET(SSE_REG_EVT_STATE_A7, sse_registered_event, state.a7);
>> +
>> +    DEFINE(SBI_EXT_SSE, SBI_EXT_SSE);
>> +    DEFINE(SBI_SSE_EVENT_COMPLETE, SBI_SSE_EVENT_COMPLETE);
>> +    DEFINE(SBI_SSE_EVENT_ATTR_READ, SBI_SSE_EVENT_ATTR_READ);
> 
> 
>> +    DEFINE(SBI_SSE_ATTR_INTERRUPTED_MODE,
>> SBI_SSE_ATTR_INTERRUPTED_MODE);
>> +    DEFINE(SBI_SSE_ATTR_INTERRUPTED_SIZE, SBI_SSE_ATTR_INTERRUPTED_A7 -
>> +                          SBI_SSE_ATTR_INTERRUPTED_MODE);
>> +#endif
>> +
>> +    DEFINE(ASM_PAGE_OFFSET, CONFIG_PAGE_OFFSET);
>> }
>> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
>> index 54ca4564a926..c9046c59e06c 100644
>> --- a/arch/riscv/kernel/entry.S
>> +++ b/arch/riscv/kernel/entry.S
>> @@ -19,17 +19,49 @@
>>
>>     .section .irqentry.text, "ax"
>>
>> +#ifdef CONFIG_RISCV_SSE
>> +#define IN_TP            0
>> +#define IN_SSCRATCH        1
>> +#define PRV_U_TASK_LOC(loc)    (loc << 0)
>> +#define PRV_S_TASK_LOC(loc)    (loc << 1)
>> +#define TASK_LOC(s_loc, u_loc)    (PRV_U_TASK_LOC(u_loc) |
>> PRV_S_TASK_LOC(s_loc))
>> +#define TASK_LOC_ENTRY_SIZE    (RISCV_SZPTR + 1)
>> +
>> +/* __SSE_TASK_LOC - Annotate e'xception code with the location of
>> current task
>> + *            struct when coming from S/U mode
>> + *
>> + * When entering handle_exception(), the current task struct is
>> located either
>> + * in tp or sscratch depending on interrupted mode. Since SSE
>> handlers can be
>> + * triggered at any time during the execution of the kernel, we need
>> to be able
>> + * to retrieve the current task struct even if in handle_exception.
>> This macro
>> + * create an entry into the __task_loc section that holds the
>> location of
>> + * the current task struct for the subsequent assembly located after
>> that up to
>> + * .Lret_from_exception_end or the next __TASK_LOC.
>> + */
>> +#define __SSE_TASK_LOC(s_loc, u_loc)            \
>> +    .pushsection __task_loc,"a";    \
>> +    RISCV_PTR 99f;                \
>> +    .byte TASK_LOC(s_loc, u_loc);        \
>> +    .popsection;                \
>> +    99:
>> +#else
>> +#define __SSE_TASK_LOC(s_loc, u_loc)
>> +#endif
>> +
>> SYM_CODE_START(handle_exception)
>>     /*
>>      * If coming from userspace, preserve the user thread pointer and
>> load
>>      * the kernel thread pointer.  If we came from the kernel, the
>> scratch
>>      * register will contain 0, and we should continue on the current TP.
>>      */
>> +__SSE_TASK_LOC(IN_TP, IN_SSCRATCH)
>>     csrrw tp, CSR_SCRATCH, tp
>> +__SSE_TASK_LOC(IN_SSCRATCH, IN_TP)
>>     bnez tp, .Lsave_context
>>
>> .Lrestore_kernel_tpsp:
>>     csrr tp, CSR_SCRATCH
>> +__SSE_TASK_LOC(IN_TP, IN_TP)
>>     REG_S sp, TASK_TI_KERNEL_SP(tp)
>>
>> #ifdef CONFIG_VMAP_STACK
>> @@ -160,6 +192,7 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
>>     REG_SC x0, a2, PT_EPC(sp)
>>
>>     csrw CSR_STATUS, a0
>> +__SSE_TASK_LOC(IN_TP, IN_SSCRATCH)
>>     csrw CSR_EPC, a2
>>
>>     REG_L x1,  PT_RA(sp)
>> @@ -175,6 +208,7 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
>> #else
>>     sret
>> #endif
>> +.Lret_from_exception_end:
>> SYM_CODE_END(ret_from_exception)
>>
>> #ifdef CONFIG_VMAP_STACK
>> @@ -262,6 +296,171 @@ SYM_FUNC_START(call_on_irq_stack)
>> SYM_FUNC_END(call_on_irq_stack)
>> #endif /* CONFIG_IRQ_STACKS */
>>
>> +#ifdef CONFIG_RISCV_SSE
>> +
>> +/* When entering handle_sse, the following registers are set:
>> + * a0: contains struct sse_registered_event pointer.
>> + *
>> + * See sse_entry_init().
>> + */
>> +SYM_CODE_START(handle_sse)
>> +    /* Save stack temporarily */
>> +    move a7, sp
>> +    /* Set entry stack */
>> +    REG_L sp, SSE_REG_EVT_STACK(a0)
>> +    li a6, IRQ_STACK_SIZE
> 
> SSE_STACK_SIZE ?

Yes

> 
>> +    add sp, sp, a6
>> +
>> +    addi sp, sp, -(PT_SIZE_ON_STACK)
>> +    REG_S a7,  PT_SP(sp)
>> +    save_regs_for_sse
>> +
>> +    load_global_pointer
>> +    scs_load_sse_stack a0
>> +
>> +    REG_L s3, SSE_REG_EVT_EVT_ID(a0)
>> +    /* a0 is clobbered by sbi calls return, save it for later
>> (reg_event)*/
>> +    move s2, a0
>> +    /* event id */
>> +    move a0, s3
>> +    /* base_attr_id */
>> +    li a1, SBI_SSE_ATTR_INTERRUPTED_MODE
>> +    /* attr_count */
>> +    li a2, SBI_SSE_ATTR_INTERRUPTED_SIZE
>> +    /* phys_lo */
>> +    REG_L a3, SSE_REG_EVT_STATE_PHYS(s2)
>> +    /* phys_hi */
>> +    move a4, zero
>> +    li a7, SBI_EXT_SSE
>> +    li a6, SBI_SSE_EVENT_ATTR_READ
> 
> Doesn't this interface allow kernel to perform writes to any physical
> location
> using sbi as proxy? or sbi fw will perform some sort of whitelisting and
> actually
> will write to physical location belonging to kernel and will exclude
> physical
> memory location belonging to opensbi firmware. If it doesn't then using
> this interface
> kernel can use sbi fw as a proxy to perform some controlled writes in fw
> memory.
> Let me know if my understanding is incorrect here.

The SBI code actually check for the memory to belong to S-mode of the
domain of this hart. So I think this is safe on that side.

> 
>> +    ecall
>> +
>> +    REG_L t2, SSE_REG_EVT_STATE_MODE(s2)
>> +
>> +    /*
>> +     * Depending on where the sse event interrupted the kernel
>> execution,
>> +     * sscratch content might be 0 or not even if kernel was
>> interrupted.
>> +     * This might happen if the sse event was triggered while in
>> +     * handle_exception() right after entry. In that case, sscratch
>> might
>> +     * contain 0 if coming from kernel. In order to handle that easily,
>> +     * simply save sscratch content and restore it when returning
>> from sse
>> +     * event.
>> +     */
>> +    csrr s4, CSR_SSCRATCH
>> +    /*
>> +     * Save CAUSE and TVAL in case of nested exceptions, EPC/STATUS are
>> +     * already saved/restored by handle_exception() for nested
>> exceptions.
>> +     */
>> +    csrr a2, CSR_SCAUSE
>> +    csrr a3, CSR_STVAL
>> +    REG_S a2, PT_CAUSE(sp)
>> +    REG_S a3, PT_BADADDR(sp)
>> +    andi s5, t2, 0x1
>> +
>> +    move a0, s2 /* reg_evt for do_sse() */
>> +    move a1, sp /* pt_regs for do_sse() */
>> +
>> +    /* Userspace was interrupted, simply restore TP from scratch */
>> +    bnez s5, .Lsse_from_kernel
>> +    /* Set tp to point to sscratch content */
>> +    move tp, s4
>> +    j .Lcall_do_sse
>> +
>> +.Lsse_from_kernel:
>> +    REG_L t0, SSE_REG_EVT_STATE_PC(s2)
>> +#ifdef CONFIG_FRAME_POINTER
>> +    /*
>> +     * Else, kernel was interrupted and we will create a correct
>> stack frame
>> +     * from interrupted context.
>> +     */
>> +    addi sp, sp, -STACKFRAME_SIZE_ON_STACK
>> +    REG_S s0, STACKFRAME_FP(sp)
>> +    REG_S t0, STACKFRAME_RA(sp)
>> +    addi s0, sp, STACKFRAME_SIZE_ON_STACK
>> +#endif
>> +
>> +    /*
>> +     * If interrupting the kernel during exception handling
>> +     * (see handle_exception), then, we might have tp either in
>> SSCRATCH or
>> +     * in tp, this part is non regular and requires some more work to
>> +     * determine were is located the current task.
>> +     */
>> +    la t1, handle_exception
>> +    la t2, .Lret_from_exception_end
> 
> Since SSE events are nested, is below possible ?
> 
> Event 1 happened when `handle_exception` < PC < `ret_from_exception` and
> `tp = 0`
> `handle_see` is called and this code hasn't reached a point of obtaining
> correct `tp`
> Firmware is triggered again on this or another hart.
> Firmware decides to inject another event on this hart (either global or
> local) i.e. Event 2
> 
> Now `handle_sse` for Event 2 will think I am good because PC is outside
> the range of `handle_exception`
> and `ret_from_exception`. And go ahead and call `do_sse` which will lead
> to crash eventually.

And you are right :D That part of the exception is a pain to handle,
I(ll try to find a way to handle nested event at the beginning of SSE
handler.

> 
> 
>> +    bltu t0, t1, .Lcall_do_sse
>> +    bltu t0, t2, .Lsse_exception_slow_path
>> +
>> +.Lcall_do_sse:
>> +    /* In-kernel scratch is 0 */
>> +    csrw CSR_SCRATCH, x0
>> +    la ra, ret_from_sse
>> +    tail do_sse
>> +
>> +.global ret_from_sse
>> +ret_from_sse:
>> +    /* Restore saved CSRs */
>> +    csrw CSR_SSCRATCH, s4
>> +    /* Preserve event_id before restoring registers */
>> +    move a6, s3
>> +
>> +#ifdef CONFIG_FRAME_POINTER
>> +    /* Frame pointer is created only when kernel is interrupted */
>> +    beqz s5, .Lret_from_sse_to_user
>> +    addi sp, sp, STACKFRAME_SIZE_ON_STACK
>> +.Lret_from_sse_to_user:
>> +#endif
>> +
>> +    REG_L a2, PT_CAUSE(sp)
>> +    REG_L a3, PT_BADADDR(sp)
>> +    csrw CSR_SCAUSE, a2
>> +    csrw CSR_STVAL, a3
>> +
>> +    restore_regs_for_sse
>> +    REG_L sp,  PT_SP(sp)
>> +
>> +    /* prepare ecall with event_id */
>> +    move a0, a6
>> +    li a7, SBI_EXT_SSE
>> +    li a6, SBI_SSE_EVENT_COMPLETE
>> +    ecall
>> +
>> +/*
>> + * t0 contains interrupted pc
>> + * When called, t0 must be in [handle_exception,
>> .Lret_from_exception_end[
>> + */
>> +.Lsse_exception_slow_path:
>> +    la t3, __stop___task_loc
>> +    add t3, t3, -TASK_LOC_ENTRY_SIZE
>> +    la t4, __start___task_loc
>> +    /*
>> +     * Reverse iterate the task location section to find where is
>> located
>> +     * the task struct
>> +     */
>> +1:
>> +    REG_L    t2, 0(t3)
>> +    bgeu t0, t2, 2f
>> +    add t3, t3, -TASK_LOC_ENTRY_SIZE
>> +    bgeu t3, t4, 1b
>> +
>> +2:
>> +    lbu t2, RISCV_SZPTR(t3)
>> +
>> +    /* Get the value of SR_SPP */
>> +    csrr t1, CSR_SSTATUS
>> +    andi t1, t1, SR_SPP
>> +    snez t1, t1
>> +
>> +    srl t2, t2, t1
>> +    andi t2, t2, 1
>> +    beqz t2, .Lcall_do_sse
>> +
>> +_restore_tp_from_sscratch:
>> +    csrr tp, CSR_SCRATCH
>> +    j .Lcall_do_sse
>> +
>> +SYM_CODE_END(handle_sse)
>> +#endif
>> +
>> /*
>>  * Integer register context switch
>>  * The callee-saved registers must be saved and restored.
>> @@ -348,3 +547,6 @@ SYM_DATA_START(__user_rt_sigreturn)
>>     ecall
>> SYM_DATA_END(__user_rt_sigreturn)
>> #endif
>> +
>> +sse_panic_string:
>> +    .ascii "SSE TP is invalid, last state %px"
> Is this string used somewhere? I don't see it in this commit.

Nice catch, it was actually used as a part of sanity check code. I'll
remove that.

Thanks,

Clément

