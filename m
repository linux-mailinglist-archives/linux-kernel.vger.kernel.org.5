Return-Path: <linux-kernel+bounces-132083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B31C898F78
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1F1AB2AB8D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10AC1350CF;
	Thu,  4 Apr 2024 20:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="Yc61DdAw"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A11134733
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 20:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712261598; cv=none; b=OX6Hz1EL2SCsO3bzcH/xOWSphHTaiUfArBHH5sKGvjAVGe7EXoC16cZfk9QTc7xYCAdOHOh6yWMsLmwua0Bx0w7UDQUEav1OZEJJXr3v7eMMwGO93yiBHhscyrzonaFgnY197ZaO2JJtWhPdO55+U0dUzW3FcevnXnlXA/2lHyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712261598; c=relaxed/simple;
	bh=MtMfGB7FH6RoXXq2+aUs70YoAHP7p/Zh23dvXEoiUio=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=GVIJDr18cl9gZES9Hdhi9AtE96gVCI8vcklsXW2C8Gx1MgfS5JirYMaf8BxJCyPU5/dbUv6hkBjguwZ8wULFICDcT0lREJH4WeE5ZzOMyhNxMqhY/fcshheRPawdbrwiwVkHx/wKz/+z2JozpDP/p9iE/jnBw/zoTU30bkbBRtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=Yc61DdAw; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e2b1cd446fso7869895ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 13:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1712261596; x=1712866396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mUAL9RLsULnbJgPVDzb+qmxwNae1uJap47Wq1rbrKPw=;
        b=Yc61DdAw6xND5P9a11CKzXapa6q5hL3Kht7Db1Zbisl1/YKtg8rBBXEEH5oEyeVdwt
         XnN7z9VamyCExsiJULLlMo/MPU95QFAcc0vBP9oMSkQz9lm1WpvP2zbA6RacOk8ehcA+
         6gtXFFmHprojy5p3lPUkt7ku2qIaHGIwLjhrHOHqsRQmB8vsNPp3/QQTUmwafyO6wRgo
         CoMTZXUjCQVlHjCEMj8fPtguRRPUGqv0+tJS3+yIVIPHMeb5b2QoLAavEaymVvkSeTaY
         uQ7yPCOEKXMerglAzds8AqQQ0/otG3kkZMENMvHygieKN0Xlkh0+GRfWhGxbmMdkM124
         M79w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712261596; x=1712866396;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUAL9RLsULnbJgPVDzb+qmxwNae1uJap47Wq1rbrKPw=;
        b=Ow9v4Jh1mHOYbqtf6t994XHuYqwxvwaXLDMEoBQLpQTpGAgD0kC/di2180Nj8CaChj
         pRM/bspIwwjqgFGWnSHOcsy62xEH4t0VrxqUoCPlXSdflBJKjnmjGqw0LPMfsPUN+oek
         XPBzwvF4waDlTeiUw5VVtKxc8CKckpO77hzO3UozotvxlTcjPmM+aMOOgPOu38owVgSP
         QUy5tJS/4JlFkxceaF9JHOdbAZ9eihP4PlIw4VGJN6D7PMH6zJEJyk9KKLiHWsRwHqsO
         jb4xAhGk97QgK2aeiXEHQjzy+w+S/6t/7arsnC6lwcVipmJ+DXyRBGUBbvFGjyubpDz0
         NskA==
X-Forwarded-Encrypted: i=1; AJvYcCXfvS9KP5poscUjo/c8/8ZPBWHCvXj4Qu27Gf7jvHWyaiBjVcbAMzHpn7tO9nZlFu2spy5IYligNhpXeAco+KTC02ka/Nlpv4l5MVyE
X-Gm-Message-State: AOJu0Yz8y0QlhwG8J8XrZVjjksI7/jOFUTRjau2YbsbXPWiDPcXMJLlz
	cE2AjUbjHMtXWq2waJzQoutxFNL+0e4s6o+qqUxNFP1gQzdJWwgKavMQPTguD4E=
X-Google-Smtp-Source: AGHT+IGgwVSfPRNKtx9Jf4OL/W8qOt/gsfmr5K1tuYOatYpNyhpDKyZ2oO0seu2QZI/uO8RorGBWHQ==
X-Received: by 2002:a17:902:c155:b0:1e2:5e77:4cd with SMTP id 21-20020a170902c15500b001e25e7704cdmr3199719plj.7.1712261595505;
        Thu, 04 Apr 2024 13:13:15 -0700 (PDT)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id b3-20020a170903228300b001e2c2d694cdsm20633plh.31.2024.04.04.13.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 13:13:15 -0700 (PDT)
Date: Thu, 04 Apr 2024 13:13:15 -0700 (PDT)
X-Google-Original-Date: Thu, 04 Apr 2024 13:13:13 PDT (-0700)
Subject:     Re: [External] [PATCH] riscv: process: Fix kernel gp leakage
In-Reply-To: <7312eb06-c9dd-4a0e-98bc-ea4e8ace7b10@ghiti.fr>
CC: sorear@fastmail.com, cuiyunhui@bytedance.com, linux-riscv@lists.infradead.org,
  Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: alex@ghiti.fr
Message-ID: <mhng-c2329625-3c61-4c53-86c6-5989b03505f5@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Tue, 02 Apr 2024 02:21:15 PDT (-0700), alex@ghiti.fr wrote:
> Hi Stefan,
>
> On 27/03/2024 17:53, Stefan O'Rear wrote:
>> On Wed, Mar 27, 2024, at 4:43 AM, yunhui cui wrote:
>>> Hi Stefan,
>>>
>>> On Wed, Mar 27, 2024 at 2:14 PM Stefan O'Rear <sorear@fastmail.com> wrote:
>>>> childregs represents the registers which are active for the new thread
>>>> in user context. For a kernel thread, childregs->gp is never used since
>>>> the kernel gp is not touched by switch_to. For a user mode helper, the
>>>> gp value can be observed in user space after execve or possibly by other
>>>> means.
>>>>
>>>> Fixes: 7db91e57a0ac ("RISC-V: Task implementation")
>>>> Signed-off-by: Stefan O'Rear <sorear@fastmail.com>
>>>> ---
>>>>   arch/riscv/kernel/process.c | 3 ---
>>>>   1 file changed, 3 deletions(-)
>>>>
>>>> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
>>>> index 92922dbd5b5c..51042f48da17 100644
>>>> --- a/arch/riscv/kernel/process.c
>>>> +++ b/arch/riscv/kernel/process.c
>>>> @@ -27,8 +27,6 @@
>>>>   #include <asm/vector.h>
>>>>   #include <asm/cpufeature.h>
>>>>
>>>> -register unsigned long gp_in_global __asm__("gp");
>>>> -
>>>>   #if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_STACKPROTECTOR_PER_TASK)
>>>>   #include <linux/stackprotector.h>
>>>>   unsigned long __stack_chk_guard __read_mostly;
>>>> @@ -207,7 +205,6 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
>>>>          if (unlikely(args->fn)) {
>>>>                  /* Kernel thread */
>>>>                  memset(childregs, 0, sizeof(struct pt_regs));
>>>> -               childregs->gp = gp_in_global;
>>>>                  /* Supervisor/Machine, irqs on: */
>>>>                  childregs->status = SR_PP | SR_PIE;
>>>>
>>>> --
>>>> 2.40.1
>>>>
>>>>
>>> Can you help express in more detail what the problem was before fixing it?
>> It's a KASLR bypass, since gp_in_global is the address of the kernel symbol
>> __global_pointer$.
>>
>> The /* Kernel thread */ comment is somewhat inaccurate in that it is also used
>> for user_mode_helper threads, which exec a user process, e.g. /sbin/init or
>> when /proc/sys/kernel/core_pattern is a pipe. Such threads do not have
>> PF_KTHREAD set and are valid targets for ptrace etc. even before they exec.
>>
>> childregs is the *user* context during syscall execution and it is observable
>> from userspace in at least five ways:
>>
>> 1. kernel_execve does not currently clear integer registers, so the starting
>>     register state for PID 1 and other user processes started by the kernel has
>>     sp = user stack, gp = kernel __global_pointer$, all other integer registers
>>     zeroed by the memset in the patch comment.
>
>
> So as I  did not this know this path really well, I played a bit and I
> can confirm that usermode processes reach userspace with the gp = kernel:
>
> Thread 1 hit Breakpoint 12, 0x00007fff82487fc4 in ?? ()
> 1: x/i $pc
> => 0x7fff82487fc4:    mv    a0,sp
> 3: /x $gp = 0xffffffff817fee50
>
>
>>
>>     This is a bug in its own right, but I'm unwilling to bet that it is the only
>>     way to exploit the issue addressed by this patch.
>>
>> 2. ptrace(PTRACE_GETREGSET): you can PTRACE_ATTACH to a user_mode_helper thread
>>     before it execs, but ptrace requires SIGSTOP to be delivered which can only
>>     happen at user/kernel boundaries.
>>
>> 3. /proc/*/task/*/syscall: this is perfectly happy to read pt_regs for
>>     user_mode_helpers before the exec completes, but gp is not one of the
>>     registers it returns.
>>
>> 4. PERF_SAMPLE_REGS_USER: LOCKDOWN_PERF normally prevents access to kernel
>>     addresses via PERF_SAMPLE_REGS_INTR, but due to this bug kernel addresses
>>     are also exposed via PERF_SAMPLE_REGS_USER which is permitted under
>>     LOCKDOWN_PERF. I have not attempted to write exploit code.
>>
>> 5. Much of the tracing infrastructure allows access to user registers. I have
>>     not attempted to determine which forms of tracing allow access to user
>>     registers without already allowing access to kernel registers.
>>
>> Does this help? How much of this should be in the commit message?
>
>
> I'd put them all, but up to you, at least the first usecase that I was
> able to reproduce should be added to the commit log.

I just pasted it all in the commit, it seems generally useful for people 
running into the commit.  With the Link tags maybe it's less important 
these days, but I always just err on the side of putting more stuff in 
the commit messages.

> You can add:
>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>
> And this should go to -fixes.

It's queued up for the tester.

> Thanks,
>
> Alex
>
>
>>
>> -s
>>
>>> Thanks,
>>> Yunhui
>>>
>>> _______________________________________________
>>> linux-riscv mailing list
>>> linux-riscv@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv

