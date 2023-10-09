Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8200E7BDD21
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376685AbjJINHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376666AbjJINHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:07:38 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF57A9C
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 06:07:36 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50336906010so835066e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 06:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696856855; x=1697461655; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6TClY2bjuzp0oQfiTg2EZYUityMo+ODVekcdIVsrbGs=;
        b=A+FyFiFAjCzCpxieDsdQATCwHg/Izrcum3J2oa/MjWw0fsD6+QVyZ50VfyJPl9zDvb
         IEdtCL7TBSpUQZ8KISHvkIjqVE4a+UjmxlixZMJy/Sf4xMqubj2CwCn06waJJHNGhPcd
         NEl09ziUe6snsirBpJTUkllHKvLIpqBSUJ9Z9Tusl1PehJeweDQt15+iNXJnZfXQvGZe
         GHHiocp3cuc4S6ueWRSUx5EtJK5OTkx/yyTQbJC2BZmsSgJtp+bJVp5SojuDS3poXc/v
         EhOIboWrdAu9MQg1OOro4lt4LOurtCASeGzrnMRn7feoVUBEIjBWkbtD1m/W3SENJ6MX
         GmBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696856855; x=1697461655;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6TClY2bjuzp0oQfiTg2EZYUityMo+ODVekcdIVsrbGs=;
        b=uE8I3kIv3kDqBgfyxb3hQDeJC9W+B8FwbL+B8Hi1wD2vhiXe/+BvL8tk17vcfWb6/p
         Rh/HN8WZFC6AqPBhkuM3AaNsu7diSQzDs1TYJd8iFagW63cQDsE6P6ac9G4p7YLH80xx
         Ni0l5fYOHNegmV+mRI+H0iwb3TaUb8Ytm1b9yFuYuMK7bcIhgicWznylfyn2ZxkG6juD
         rVJ3usTOZBum8zC8vBt2H0N6qGxqAlqfeyQR7oVsQSj50aAR5wF4+peIl/DU0PS/zg82
         oCKYhkBRb7G4SE45bt75eogBi34kp3uDhBwhsujcMlVmCvSxsBinkBJDIprLkT6SbjIz
         ozrw==
X-Gm-Message-State: AOJu0YxIX7HOubC5byBIFoo1pvzCRtZm4oMtr9fFgzP2MsUW5bWURGhw
        cekvUeyOpzOeTuVtlRrO5m9p7FZCEYJfUfgMr7uVSg==
X-Google-Smtp-Source: AGHT+IGqXAG+k8cnbfMkroNM8RcYmdVlpwhTIGff1+S35kvEf7V7BmcGQ3I4Rs948h8aTPP1zJihlA==
X-Received: by 2002:a5d:5592:0:b0:317:5f08:32a3 with SMTP id i18-20020a5d5592000000b003175f0832a3mr10768050wrv.6.1696856834196;
        Mon, 09 Oct 2023 06:07:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:b2f5:bf53:6bd1:414e? ([2a01:e0a:999:a3a0:b2f5:bf53:6bd1:414e])
        by smtp.gmail.com with ESMTPSA id o17-20020a5d6851000000b0031779a6b451sm9617794wrw.83.2023.10.09.06.07.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 06:07:13 -0700 (PDT)
Message-ID: <761f38c5-8bd2-40bf-a82c-120b5dbbd6ab@rivosinc.com>
Date:   Mon, 9 Oct 2023 15:07:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] riscv: report misaligned accesses emulation to
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
        Daniel Maslowski <cyrevolt@googlemail.com>,
        Conor Dooley <conor@kernel.org>
References: <20231004151405.521596-1-cleger@rivosinc.com>
 <20231004151405.521596-8-cleger@rivosinc.com>
 <CALs-HstxNBag7g74XSMJ-qu_ihp4WzA+PV2mf0MDkaRF3gV33w@mail.gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <CALs-HstxNBag7g74XSMJ-qu_ihp4WzA+PV2mf0MDkaRF3gV33w@mail.gmail.com>
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



On 04/10/2023 18:14, Evan Green wrote:
> On Wed, Oct 4, 2023 at 8:14 AM Clément Léger <cleger@rivosinc.com> wrote:
>>
>> hwprobe provides a way to report if misaligned access are emulated. In
>> order to correctly populate that feature, we can check if it actually
>> traps when doing a misaligned access. This can be checked using an
>> exception table entry which will actually be used when a misaligned
>> access is done from kernel mode.
>>
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>> ---
>>  arch/riscv/include/asm/cpufeature.h  | 18 +++++++++
>>  arch/riscv/kernel/cpufeature.c       |  4 ++
>>  arch/riscv/kernel/smpboot.c          |  2 +-
>>  arch/riscv/kernel/traps_misaligned.c | 56 ++++++++++++++++++++++++++++
>>  4 files changed, 79 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
>> index d0345bd659c9..e4ae6af51876 100644
>> --- a/arch/riscv/include/asm/cpufeature.h
>> +++ b/arch/riscv/include/asm/cpufeature.h
>> @@ -32,4 +32,22 @@ extern struct riscv_isainfo hart_isa[NR_CPUS];
>>
>>  void check_unaligned_access(int cpu);
>>
>> +#ifdef CONFIG_RISCV_MISALIGNED
>> +bool unaligned_ctl_available(void);
>> +bool check_unaligned_access_emulated(int cpu);
>> +void unaligned_emulation_finish(void);
>> +#else
>> +static inline bool unaligned_ctl_available(void)
>> +{
>> +       return false;
>> +}
>> +
>> +static inline bool check_unaligned_access_emulated(int cpu)
>> +{
>> +       return false;
>> +}
>> +
>> +static inline void unaligned_emulation_finish(void) {}
>> +#endif
>> +
>>  #endif
>> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
>> index 356e5677eeb1..fbbde800bc21 100644
>> --- a/arch/riscv/kernel/cpufeature.c
>> +++ b/arch/riscv/kernel/cpufeature.c
>> @@ -568,6 +568,9 @@ void check_unaligned_access(int cpu)
>>         void *src;
>>         long speed = RISCV_HWPROBE_MISALIGNED_SLOW;
>>
>> +       if (check_unaligned_access_emulated(cpu))
>> +               return;
>> +
>>         page = alloc_pages(GFP_NOWAIT, get_order(MISALIGNED_BUFFER_SIZE));
>>         if (!page) {
>>                 pr_warn("Can't alloc pages to measure memcpy performance");
>> @@ -648,6 +651,7 @@ void check_unaligned_access(int cpu)
>>  static int __init check_unaligned_access_boot_cpu(void)
>>  {
>>         check_unaligned_access(0);
>> +       unaligned_emulation_finish();
>>         return 0;
>>  }
>>
>> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
>> index 1b8da4e40a4d..5d9858d6ad26 100644
>> --- a/arch/riscv/kernel/smpboot.c
>> +++ b/arch/riscv/kernel/smpboot.c
>> @@ -245,8 +245,8 @@ asmlinkage __visible void smp_callin(void)
>>         riscv_ipi_enable();
>>
>>         numa_add_cpu(curr_cpuid);
>> -       set_cpu_online(curr_cpuid, 1);
>>         check_unaligned_access(curr_cpuid);
>> +       set_cpu_online(curr_cpuid, 1);
>>
>>         if (has_vector()) {
>>                 if (riscv_v_setup_vsize())
>> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
>> index b5fb1ff078e3..d99b95084b6c 100644
>> --- a/arch/riscv/kernel/traps_misaligned.c
>> +++ b/arch/riscv/kernel/traps_misaligned.c
>> @@ -14,6 +14,8 @@
>>  #include <asm/ptrace.h>
>>  #include <asm/csr.h>
>>  #include <asm/entry-common.h>
>> +#include <asm/hwprobe.h>
>> +#include <asm/cpufeature.h>
>>
>>  #define INSN_MATCH_LB                  0x3
>>  #define INSN_MASK_LB                   0x707f
>> @@ -396,6 +398,8 @@ union reg_data {
>>         u64 data_u64;
>>  };
>>
>> +static bool unaligned_ctl __read_mostly;
>> +
>>  /* sysctl hooks */
>>  int unaligned_enabled __read_mostly = 1;       /* Enabled by default */
>>
>> @@ -409,6 +413,8 @@ int handle_misaligned_load(struct pt_regs *regs)
>>
>>         perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
>>
>> +       *this_cpu_ptr(&misaligned_access_speed) = RISCV_HWPROBE_MISALIGNED_EMULATED;
>> +
>>         if (!unaligned_enabled)
>>                 return -1;
>>
>> @@ -585,3 +591,53 @@ int handle_misaligned_store(struct pt_regs *regs)
>>
>>         return 0;
>>  }
>> +
>> +bool check_unaligned_access_emulated(int cpu)
>> +{
>> +       long *mas_ptr = per_cpu_ptr(&misaligned_access_speed, cpu);
>> +       unsigned long tmp_var, tmp_val;
>> +       bool misaligned_emu_detected;
>> +
>> +       *mas_ptr = RISCV_HWPROBE_MISALIGNED_UNKNOWN;
>> +
>> +       __asm__ __volatile__ (
>> +               "       "REG_L" %[tmp], 1(%[ptr])\n"
>> +               : [tmp] "=r" (tmp_val) : [ptr] "r" (&tmp_var) : "memory");
>> +
>> +       misaligned_emu_detected = (*mas_ptr == RISCV_HWPROBE_MISALIGNED_EMULATED);
>> +       /*
>> +        * If unaligned_ctl is already set, this means that we detected that all
>> +        * CPUS uses emulated misaligned access at boot time. If that changed
>> +        * when hotplugging the new cpu, this is something we don't handle.
>> +        */
>> +       if (unlikely(unaligned_ctl && !misaligned_emu_detected)) {
>> +               pr_crit("CPU misaligned accesses non homogeneous (expected all emulated)\n");
>> +               while (true)
>> +                       cpu_relax();
> 
> So the idea is to spin long enough that the
> wait_for_completion(&cpu_running, 1000ms) times out? Maybe there
> should be a wfi() in here as well so we're not just burning white hot.

Hi Evan,

Yes the idea is to let the timeout fail. We could potentially add some
shared state to report an error during bring up and thus not wait up to
the timeout end. I'll check that.

Regarding th wfi(), the cpu_relax() call is actually meant to do that.
On RISC-V implementation, it ends up on a pause if Zihintpause is available

> Have you verified that if we get here, the CPU will also get taken
> back down after the timeout? I wonder if __cpu_up() also needs a call
> to stop the CPU, in the case where that wait_for_completion_timeout()
> times out.

I actually checked that it is not brought up but not the complete path
to check if it is correctly brought down, I'll check that.

> 
> It also might be more intuitive to reorganize this such that the death
> loop happens in smp_callin(), as check_unaligned_access_emulated() is
> not a function you'd expect might sometimes never return.

Yes, that makes sense.

Clément

> 
> -Evan
