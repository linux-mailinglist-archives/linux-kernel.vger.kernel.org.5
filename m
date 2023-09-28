Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1617B1542
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjI1HqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjI1HqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:46:23 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26058F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:46:20 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-405d70d19bcso14414865e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1695887179; x=1696491979; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+rg1Ne0t86kMdu3fxYJuBqKtXK+ow8wHfug79dUhtVg=;
        b=BX7nGcKixxM+LMBdcUW08tbiX7fEN5jqx/y2ECWYQ5NtHaDa449Q/oFJ/FRHGnADBE
         D/bGVJ0tn65n50N/DUlBWmW3OHKW1cWn0SR/EjTlkbHt9XH97WYQ3NxE9+a/kWc/pWj2
         rf9xGRg2BxPbRWaUM6dBKwjRPJnWBX7VkeQVXPnaB1OeydIlmz4c8ax9oqfkpelRSi0M
         6xfsYsoJ0eromVjnTXSsT+KXa5Xhep6zsdkf0nZOdBESB3CyWO3UYAgqB7Wx59xgB46p
         3QN4a0oc9bFg7FbH9zjjRfR0v12SmolShRnT2gPCu0RUteFxJ3omIq0Lh8O+5QwkkrLn
         kfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695887179; x=1696491979;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+rg1Ne0t86kMdu3fxYJuBqKtXK+ow8wHfug79dUhtVg=;
        b=VozyNNMBPhBeTRZyO/03ifrJzDVzxoBCr7v0gv+2IwEl3GflBIny64pYrq69cAZkge
         sndHhRyG68WL6cUzGcOfwRSDMpXp9gHCoB6rHmVGXKbu5hh7cNIgG5qlFmYZ5Ikq0yqu
         3Qh3PFwXM35PIYolLaDfIZkVg8W8E7e0arBdXA/xZJkD15/xMpE85hLWtFzqrO7/L1Lc
         P7H+K+phyInbqJPEdusjp0wxyK0quH5S+iCgQNEiFVBnfjI4/tJl3DTOvMmMXnGUYnJk
         XqfX4fIBZwKXwc4igbBWdqAZ1kpuvS1DpF5C+qiLgMIW27/BBQ82Fz/34Ziftp9Gve38
         vbEw==
X-Gm-Message-State: AOJu0YzvG8BsfE5b4eKflScUTmFvN41yrbOK27GKG8xhkxYfdChTpqjy
        OfmbpEpiQZsKkjzi5KSzSqjbrQ==
X-Google-Smtp-Source: AGHT+IEaEzwm/AaCjrVcQWTmxAimbl5qfaBEeSB9TwhWPU7AdIePkuNjOPzyIu1g4Lt4KvFo0Fjd8A==
X-Received: by 2002:a05:600c:3b88:b0:405:1ba2:4fcf with SMTP id n8-20020a05600c3b8800b004051ba24fcfmr449703wms.4.1695887179248;
        Thu, 28 Sep 2023 00:46:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:866e:3285:a245:a33f? ([2a01:e0a:999:a3a0:866e:3285:a245:a33f])
        by smtp.gmail.com with ESMTPSA id t1-20020a1c7701000000b003fe23b10fdfsm22245518wmi.36.2023.09.28.00.46.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 00:46:18 -0700 (PDT)
Message-ID: <c9db8acf-98fe-4533-8fa1-7a4394e51e21@rivosinc.com>
Date:   Thu, 28 Sep 2023 09:46:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] riscv: report misaligned accesses emulation to
 hwprobe
Content-Language: en-US
To:     Evan Green <evan@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Topel?= <bjorn@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ron Minnich <rminnich@gmail.com>,
        Daniel Maslowski <cyrevolt@googlemail.com>
References: <20230926150316.1129648-1-cleger@rivosinc.com>
 <20230926150316.1129648-7-cleger@rivosinc.com>
 <CALs-HssC7oEg0H84D4_gkHpujhBbOOqX-W3k=WrD3SBEGHmaYg@mail.gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <CALs-HssC7oEg0H84D4_gkHpujhBbOOqX-W3k=WrD3SBEGHmaYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/09/2023 23:57, Evan Green wrote:
> On Tue, Sep 26, 2023 at 8:03 AM Clément Léger <cleger@rivosinc.com> wrote:
>>
>> hwprobe provides a way to report if misaligned access are emulated. In
>> order to correctly populate that feature, we can check if it actually
>> traps when doing a misaligned access. This can be checked using an
>> exception table entry which will actually be used when a misaligned
>> access is done from kernel mode.
>>
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>> ---
>>  arch/riscv/include/asm/cpufeature.h  |  6 +++
>>  arch/riscv/kernel/cpufeature.c       |  6 ++-
>>  arch/riscv/kernel/setup.c            |  1 +
>>  arch/riscv/kernel/traps_misaligned.c | 63 +++++++++++++++++++++++++++-
>>  4 files changed, 74 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
>> index d0345bd659c9..c1f0ef02cd7d 100644
>> --- a/arch/riscv/include/asm/cpufeature.h
>> +++ b/arch/riscv/include/asm/cpufeature.h
>> @@ -8,6 +8,7 @@
>>
>>  #include <linux/bitmap.h>
>>  #include <asm/hwcap.h>
>> +#include <asm/hwprobe.h>
>>
>>  /*
>>   * These are probed via a device_initcall(), via either the SBI or directly
>> @@ -32,4 +33,9 @@ extern struct riscv_isainfo hart_isa[NR_CPUS];
>>
>>  void check_unaligned_access(int cpu);
>>
>> +bool unaligned_ctl_available(void);
>> +
>> +bool check_unaligned_access_emulated(int cpu);
>> +void unaligned_emulation_finish(void);
>> +
>>  #endif
>> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
>> index 1cfbba65d11a..fbbde800bc21 100644
>> --- a/arch/riscv/kernel/cpufeature.c
>> +++ b/arch/riscv/kernel/cpufeature.c
>> @@ -568,6 +568,9 @@ void check_unaligned_access(int cpu)
>>         void *src;
>>         long speed = RISCV_HWPROBE_MISALIGNED_SLOW;
>>
>> +       if (check_unaligned_access_emulated(cpu))
> 
> This spot (referenced below).
> 
>> +               return;
>> +
>>         page = alloc_pages(GFP_NOWAIT, get_order(MISALIGNED_BUFFER_SIZE));
>>         if (!page) {
>>                 pr_warn("Can't alloc pages to measure memcpy performance");
>> @@ -645,9 +648,10 @@ void check_unaligned_access(int cpu)
>>         __free_pages(page, get_order(MISALIGNED_BUFFER_SIZE));
>>  }
>>
>> -static int check_unaligned_access_boot_cpu(void)
>> +static int __init check_unaligned_access_boot_cpu(void)
>>  {
>>         check_unaligned_access(0);
>> +       unaligned_emulation_finish();
>>         return 0;
>>  }
>>
>> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
>> index e600aab116a4..3af6ad4df7cf 100644
>> --- a/arch/riscv/kernel/setup.c
>> +++ b/arch/riscv/kernel/setup.c
>> @@ -26,6 +26,7 @@
>>  #include <asm/acpi.h>
>>  #include <asm/alternative.h>
>>  #include <asm/cacheflush.h>
>> +#include <asm/cpufeature.h>
>>  #include <asm/cpu_ops.h>
>>  #include <asm/early_ioremap.h>
>>  #include <asm/pgtable.h>
>> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
>> index b5fb1ff078e3..fa81f6952fa4 100644
>> --- a/arch/riscv/kernel/traps_misaligned.c
>> +++ b/arch/riscv/kernel/traps_misaligned.c
>> @@ -9,11 +9,14 @@
>>  #include <linux/perf_event.h>
>>  #include <linux/irq.h>
>>  #include <linux/stringify.h>
>> +#include <linux/prctl.h>
>>
>>  #include <asm/processor.h>
>>  #include <asm/ptrace.h>
>>  #include <asm/csr.h>
>>  #include <asm/entry-common.h>
>> +#include <asm/hwprobe.h>
>> +#include <asm/cpufeature.h>
>>
>>  #define INSN_MATCH_LB                  0x3
>>  #define INSN_MASK_LB                   0x707f
>> @@ -396,8 +399,10 @@ union reg_data {
>>         u64 data_u64;
>>  };
>>
>> +static bool unaligned_ctl __read_mostly;
>> +
>>  /* sysctl hooks */
>> -int unaligned_enabled __read_mostly = 1;       /* Enabled by default */
>> +int unaligned_enabled __read_mostly;
>>
>>  int handle_misaligned_load(struct pt_regs *regs)
>>  {
>> @@ -412,6 +417,9 @@ int handle_misaligned_load(struct pt_regs *regs)
>>         if (!unaligned_enabled)
>>                 return -1;
>>
>> +       if (user_mode(regs) && (current->thread.align_ctl & PR_UNALIGN_SIGBUS))
>> +               return -1;
>> +
>>         if (get_insn(regs, epc, &insn))
>>                 return -1;
>>
>> @@ -511,6 +519,9 @@ int handle_misaligned_store(struct pt_regs *regs)
>>         if (!unaligned_enabled)
>>                 return -1;
>>
>> +       if (user_mode(regs) && (current->thread.align_ctl & PR_UNALIGN_SIGBUS))
>> +               return -1;
>> +
>>         if (get_insn(regs, epc, &insn))
>>                 return -1;
>>
>> @@ -585,3 +596,53 @@ int handle_misaligned_store(struct pt_regs *regs)
>>
>>         return 0;
>>  }
>> +
>> +bool check_unaligned_access_emulated(int cpu)
>> +{
>> +       unsigned long emulated = 1, tmp_var;
>> +
>> +       /* Use a fixup to detect if misaligned access triggered an exception */
>> +       __asm__ __volatile__ (
>> +               "1:\n"
>> +               "       "REG_L" %[tmp], 1(%[ptr])\n"
>> +               "       li %[emulated], 0\n"
>> +               "2:\n"
>> +               _ASM_EXTABLE(1b, 2b)
>> +       : [emulated] "+r" (emulated), [tmp] "=r" (tmp_var)
>> +       : [ptr] "r" (&tmp_var)
>> +       : "memory");
>> +
>> +       if (!emulated)
>> +               return false;
>> +
>> +       per_cpu(misaligned_access_speed, cpu) =
>> +               RISCV_HWPROBE_MISALIGNED_EMULATED;
> 
> For tidiness, can we move the assignment of this per-cpu variable into
> check_unaligned_access(), at the spot I referenced above. That way
> people looking to see how this variable is set don't have to hunt
> through multiple locations.

Agreed, that seems better.

> 
>> +
>> +       return true;
>> +}
>> +
>> +void __init unaligned_emulation_finish(void)
>> +{
>> +       int cpu;
>> +
>> +       /*
>> +        * We can only support PR_UNALIGN controls if all CPUs have misaligned
>> +        * accesses emulated since tasks requesting such control can run on any
>> +        * CPU.
>> +        */
>> +       for_each_possible_cpu(cpu) {
>> +               if (per_cpu(misaligned_access_speed, cpu) !=
>> +                   RISCV_HWPROBE_MISALIGNED_EMULATED) {
>> +                       goto out;
>> +               }
>> +       }
>> +       unaligned_ctl = true;
> 
> This doesn't handle the case where a CPU is hotplugged later that
> doesn't match with the others. You may want to add a patch that fails
> the onlining of that new CPU if unaligned_ctl is true and
> new_cpu.misaligned_access_speed != EMULATED.

So actually, this will require a bit more plumbing as I realize the
switch to disable misalignment support is global. This switch should
only be disabled at boot which means I won't be able to disable it at
runtime (while hiotplugging a CPU) for CPU detection. There are multiple
ways to handle that:

1- Have a per-cpu switch for misalignment handling which would be
disabled only when detection is needed.

2- Assume that once detected at boot-time, emulation will not change.

Not sure which one is better though. Advice are welcomed.

Clément

> 
> -Evan
