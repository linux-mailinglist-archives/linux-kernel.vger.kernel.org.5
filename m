Return-Path: <linux-kernel+bounces-73173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E7B85BEA7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B3571F22EC8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E423D6BFB8;
	Tue, 20 Feb 2024 14:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="vQjxhMGs"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3BE6A034
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 14:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708438865; cv=none; b=QSPz5noJ2MtlaB0tzClDPsY8uGNKQCTF9DwMxfUoXQ27e/Lv+flfXKrrdrevNM8VIoEpDMwqdv0VqpCFVRnkO7kw5UYRT/XBhTri4p6zQPJx+e/lDHWhstJnxPvBnJjZzBFYDZ345FfKElXlkcgv2O6UTFizhxXpQ9BJFMkeH1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708438865; c=relaxed/simple;
	bh=OBiveBjn5VM9ZDt6mamDRQdY7uyGzwi/eqh8BlItIjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z1I6O+oOEr/79It2K33xksoEvZdiMqg9NKFuRJFvY7a0N2qJFVQD5mAuFNTGRfszcDQTjgys8RJAOMt5LEKVVGRkhtp1fUm5tQSkgaYNTpVliR/jJCbvNAw4D5afNlXPxZXiUrHNG7ZocWUrwDYcyIdMExLXrGrlsyLdqvXns28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=vQjxhMGs; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1708438860;
	bh=OBiveBjn5VM9ZDt6mamDRQdY7uyGzwi/eqh8BlItIjk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vQjxhMGsWWVTubNoJ3+jyImWkFnqweqMpeaI9zGWBWDLqKQA17fnCfiHngg5jqMU5
	 mBHjNEb2vrfzBetFW97MlNm6JqlgT0xGEjTJnaUKm2P4S6ZONSgPqL82iUKPc9QPk3
	 QFrQmFwMiD+5AM2pqm3ain17efLkWQAwMVODmJPOmHyVif8wUBNhUYuGjiiphflnAd
	 NLuZIlseDtxu110dAiyqaxurWUAa0Z8dCu5tKx2c32tpL0+HdtVHhmU+CwwTybvWM8
	 yCVaMu03EbmszAybUULnug/LYS6fB+wy3oLNVYC0MGn02x88jE8BRIzkvVujtdVzz2
	 OLzyet9htEbDw==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TfM5R6z9Pzb2d;
	Tue, 20 Feb 2024 09:20:59 -0500 (EST)
Message-ID: <eb6498b8-9a82-4271-bb5c-bea166ccffee@efficios.com>
Date: Tue, 20 Feb 2024 09:20:58 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] sched/rseq: Consider rseq abort in page fault
 handler
Content-Language: en-US
To: Dmitry Vyukov <dvyukov@google.com>
Cc: linux-kernel@vger.kernel.org, Peter Oskolkov <posk@google.com>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Chris Kennelly <ckennelly@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski
 <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-mm@kvack.org
References: <20240215191402.681674-1-mathieu.desnoyers@efficios.com>
 <CACT4Y+YFQJE8tvHxXmJcd8Mr8NY2AYnYvQ1ZBxQQrN522KEbrg@mail.gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <CACT4Y+YFQJE8tvHxXmJcd8Mr8NY2AYnYvQ1ZBxQQrN522KEbrg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-02-20 08:53, Dmitry Vyukov wrote:
> On Thu, 15 Feb 2024 at 20:14, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> Consider rseq abort before emitting the SIGSEGV or SIGBUS signals from
>> the page fault handler.
>>
>> This allows using membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
>> to abort rseq critical sections which include memory accesses to
>> memory which mapping can be munmap'd or mprotect'd after the
>> membarrier "rseq fence" without causing SIGSEGV or SIGBUS when the page
>> fault handler triggered by a faulting memory access within a rseq
>> critical section is preempted before handling the page fault.
>>
>> The problematic scenario is:
>>
>> CPU 0                          CPU 1
>> ------------------------------------------------------------------
>>                                 old_p = P
>>                                 P = NULL
>> - rseq c.s. begins
>> - x = P
>> - if (x != NULL)
>>    - v = *x
>>      - page fault
>>      - preempted
>>                                 membarrier(MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ)
>>                                 munmap(old_p) (or mprotect(old_p))
>>      - handle page fault
>>      - force_sig_fault(SIGSEGV)
>>      - rseq resume notifier
>>        - move IP to abort IP
>>    -> SIGSEGV handler runs.
>>
>> This is solved by postponing the force_sig_fault() to return to
>> user-space when the page fault handler detects that rseq events will
>> cause the thread to call the rseq resume notifier before going back to
>> user-space. This allows the rseq resume notifier to load the userspace
>> memory pointed by rseq->rseq_cs to compare the IP with the rseq c.s.
>> range before either moving the IP to the abort handler or calling
>> force_sig_fault() with the parameters previously saved by the page fault
>> handler.
>>
>> Add a new AT_RSEQ_FEATURE_FLAGS getauxval(3) to allow user-space to
>> query whether the kernel implements this behavior (flag:
>> RSEQ_FEATURE_PAGE_FAULT_ABORT).
>>
>> Untested implementation submitted for early feedback.
>>
>> Only x86 is implemented in this PoC.
>>
>> Link: https://lore.kernel.org/lkml/CACT4Y+bXfekygoyhO7pCctjnL15=E=Zs31BUGXU0dk8d4rc1Cw@mail.gmail.com/
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Cc: Dmitry Vyukov <dvyukov@google.com>
>> Cc: Peter Oskolkov <posk@google.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: "Paul E. McKenney" <paulmck@kernel.org>
>> Cc: Boqun Feng <boqun.feng@gmail.com>
>> Cc: Chris Kennelly <ckennelly@google.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: linux-mm@kvack.org
> 
> Hi Mathieu,
> 
> Thanks for the quick fix.
> I can try to test this, but I can't apply this.
> What's the base commit for the patch?

The base commit for the patch is tag v6.7.

Thanks,

Mathieu

> 
> On top of latest upstream head v6.8-rc5:
> 
> $ patch -p1 < /tmp/patch
> patching file arch/x86/mm/fault.c
> patching file fs/binfmt_elf.c
> patching file include/linux/sched.h
> Hunk #1 succeeded at 745 (offset 2 lines).
> Hunk #2 succeeded at 1329 (offset 3 lines).
> Hunk #3 succeeded at 2143 with fuzz 2 (offset -197 lines).
> Hunk #4 FAILED at 2402.
> Hunk #5 FAILED at 2417.
> 2 out of 5 hunks FAILED -- saving rejects to file include/linux/sched.h.rej
> patching file include/linux/sched/signal.h
> Hunk #1 succeeded at 784 (offset 3 lines).
> patching file include/uapi/linux/auxvec.h
> patching file include/uapi/linux/rseq.h
> patching file kernel/rseq.c
> Hunk #2 succeeded at 299 with fuzz 1.
> 
> 
>> ---
>>   arch/x86/mm/fault.c          |  4 ++--
>>   fs/binfmt_elf.c              |  1 +
>>   include/linux/sched.h        | 16 ++++++++++++++++
>>   include/linux/sched/signal.h | 24 ++++++++++++++++++++++++
>>   include/uapi/linux/auxvec.h  |  1 +
>>   include/uapi/linux/rseq.h    |  7 +++++++
>>   kernel/rseq.c                | 36 +++++++++++++++++++++++++++++++-----
>>   7 files changed, 82 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
>> index 679b09cfe241..42ac39680cb6 100644
>> --- a/arch/x86/mm/fault.c
>> +++ b/arch/x86/mm/fault.c
>> @@ -854,7 +854,7 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
>>          if (si_code == SEGV_PKUERR)
>>                  force_sig_pkuerr((void __user *)address, pkey);
>>          else
>> -               force_sig_fault(SIGSEGV, si_code, (void __user *)address);
>> +               rseq_lazy_force_sig_fault(SIGSEGV, si_code, (void __user *)address);
>>
>>          local_irq_disable();
>>   }
>> @@ -973,7 +973,7 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
>>                  return;
>>          }
>>   #endif
>> -       force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address);
>> +       rseq_lazy_force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address);
>>   }
>>
>>   static int spurious_kernel_fault_check(unsigned long error_code, pte_t *pte)
>> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
>> index 5397b552fbeb..8fece0911c7d 100644
>> --- a/fs/binfmt_elf.c
>> +++ b/fs/binfmt_elf.c
>> @@ -273,6 +273,7 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
>>   #ifdef CONFIG_RSEQ
>>          NEW_AUX_ENT(AT_RSEQ_FEATURE_SIZE, offsetof(struct rseq, end));
>>          NEW_AUX_ENT(AT_RSEQ_ALIGN, __alignof__(struct rseq));
>> +       NEW_AUX_ENT(AT_RSEQ_FEATURE_FLAGS, RSEQ_FEATURE_FLAGS);
>>   #endif
>>   #undef NEW_AUX_ENT
>>          /* AT_NULL is zero; clear the rest too */
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index 292c31697248..39aa585ba2a3 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -743,6 +743,15 @@ struct kmap_ctrl {
>>   #endif
>>   };
>>
>> +#ifdef CONFIG_RSEQ
>> +struct rseq_lazy_sig {
>> +       bool pending;
>> +       int sig;
>> +       int code;
>> +       void __user *addr;
>> +};
>> +#endif
>> +
>>   struct task_struct {
>>   #ifdef CONFIG_THREAD_INFO_IN_TASK
>>          /*
>> @@ -1317,6 +1326,7 @@ struct task_struct {
>>           * with respect to preemption.
>>           */
>>          unsigned long rseq_event_mask;
>> +       struct rseq_lazy_sig rseq_lazy_sig;
>>   #endif
>>
>>   #ifdef CONFIG_SCHED_MM_CID
>> @@ -2330,6 +2340,8 @@ unsigned long sched_cpu_util(int cpu);
>>
>>   #ifdef CONFIG_RSEQ
>>
>> +#define RSEQ_FEATURE_FLAGS     RSEQ_FEATURE_PAGE_FAULT_ABORT
>> +
>>   /*
>>    * Map the event mask on the user-space ABI enum rseq_cs_flags
>>    * for direct mask checks.
>> @@ -2390,6 +2402,8 @@ static inline void rseq_migrate(struct task_struct *t)
>>    */
>>   static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
>>   {
>> +       WARN_ON_ONCE(current->rseq_lazy_sig.pending);
>> +
>>          if (clone_flags & CLONE_VM) {
>>                  t->rseq = NULL;
>>                  t->rseq_len = 0;
>> @@ -2405,6 +2419,8 @@ static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
>>
>>   static inline void rseq_execve(struct task_struct *t)
>>   {
>> +       WARN_ON_ONCE(current->rseq_lazy_sig.pending);
>> +
>>          t->rseq = NULL;
>>          t->rseq_len = 0;
>>          t->rseq_sig = 0;
>> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
>> index 3499c1a8b929..0d75dfde2f9b 100644
>> --- a/include/linux/sched/signal.h
>> +++ b/include/linux/sched/signal.h
>> @@ -781,4 +781,28 @@ static inline unsigned long rlimit_max(unsigned int limit)
>>          return task_rlimit_max(current, limit);
>>   }
>>
>> +#ifdef CONFIG_RSEQ
>> +
>> +static inline int rseq_lazy_force_sig_fault(int sig, int code, void __user *addr)
>> +{
>> +       struct task_struct *t = current;
>> +
>> +       if (!t->rseq_event_mask)
>> +               return force_sig_fault(sig, code, addr);
>> +       t->rseq_lazy_sig.pending = true;
>> +       t->rseq_lazy_sig.sig = sig;
>> +       t->rseq_lazy_sig.code = code;
>> +       t->rseq_lazy_sig.addr = addr;
>> +       return 0;
>> +}
>> +
>> +#else
>> +
>> +static inline int rseq_lazy_force_sig_fault(int sig, int code, void __user *addr)
>> +{
>> +       return force_sig_fault(sig, code, addr);
>> +}
>> +
>> +#endif
>> +
>>   #endif /* _LINUX_SCHED_SIGNAL_H */
>> diff --git a/include/uapi/linux/auxvec.h b/include/uapi/linux/auxvec.h
>> index 6991c4b8ab18..5044f367a219 100644
>> --- a/include/uapi/linux/auxvec.h
>> +++ b/include/uapi/linux/auxvec.h
>> @@ -32,6 +32,7 @@
>>   #define AT_HWCAP2 26   /* extension of AT_HWCAP */
>>   #define AT_RSEQ_FEATURE_SIZE   27      /* rseq supported feature size */
>>   #define AT_RSEQ_ALIGN          28      /* rseq allocation alignment */
>> +#define AT_RSEQ_FEATURE_FLAGS  29      /* rseq feature flags */
>>
>>   #define AT_EXECFN  31  /* filename of program */
>>
>> diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
>> index c233aae5eac9..0fdb192e3cd3 100644
>> --- a/include/uapi/linux/rseq.h
>> +++ b/include/uapi/linux/rseq.h
>> @@ -37,6 +37,13 @@ enum rseq_cs_flags {
>>                  (1U << RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT),
>>   };
>>
>> +/*
>> + * rseq feature flags. Query with getauxval(AT_RSEQ_FEATURE_FLAGS).
>> + */
>> +enum rseq_feature_flags {
>> +       RSEQ_FEATURE_PAGE_FAULT_ABORT = (1U << 0),
>> +};
>> +
>>   /*
>>    * struct rseq_cs is aligned on 4 * 8 bytes to ensure it is always
>>    * contained within a single cache-line. It is usually declared as
>> diff --git a/kernel/rseq.c b/kernel/rseq.c
>> index 9de6e35fe679..f686a97abb45 100644
>> --- a/kernel/rseq.c
>> +++ b/kernel/rseq.c
>> @@ -271,6 +271,25 @@ static bool in_rseq_cs(unsigned long ip, struct rseq_cs *rseq_cs)
>>          return ip - rseq_cs->start_ip < rseq_cs->post_commit_offset;
>>   }
>>
>> +static void rseq_clear_lazy_sig_fault(struct task_struct *t)
>> +{
>> +       if (!t->rseq_lazy_sig.pending)
>> +               return;
>> +       t->rseq_lazy_sig.pending = false;
>> +       t->rseq_lazy_sig.sig = 0;
>> +       t->rseq_lazy_sig.code = 0;
>> +       t->rseq_lazy_sig.addr = NULL;
>> +}
>> +
>> +static void rseq_force_lazy_sig_fault(struct task_struct *t)
>> +{
>> +       if (!t->rseq_lazy_sig.pending)
>> +               return;
>> +       force_sig_fault(t->rseq_lazy_sig.sig, t->rseq_lazy_sig.code,
>> +                       t->rseq_lazy_sig.addr);
>> +       rseq_clear_lazy_sig_fault(t);
>> +}
>> +
>>   static int rseq_ip_fixup(struct pt_regs *regs)
>>   {
>>          unsigned long ip = instruction_pointer(regs);
>> @@ -280,25 +299,32 @@ static int rseq_ip_fixup(struct pt_regs *regs)
>>
>>          ret = rseq_get_rseq_cs(t, &rseq_cs);
>>          if (ret)
>> -               return ret;
>> +               goto nofixup;
>>
>>          /*
>>           * Handle potentially not being within a critical section.
>>           * If not nested over a rseq critical section, restart is useless.
>>           * Clear the rseq_cs pointer and return.
>>           */
>> -       if (!in_rseq_cs(ip, &rseq_cs))
>> -               return clear_rseq_cs(t);
>> +       if (!in_rseq_cs(ip, &rseq_cs)) {
>> +               ret = clear_rseq_cs(t);
>> +               goto nofixup;
>> +       }
>>          ret = rseq_need_restart(t, rseq_cs.flags);
>>          if (ret <= 0)
>> -               return ret;
>> +               goto nofixup;
>>          ret = clear_rseq_cs(t);
>>          if (ret)
>> -               return ret;
>> +               goto nofixup;
>> +       rseq_clear_lazy_sig_fault(t);
>>          trace_rseq_ip_fixup(ip, rseq_cs.start_ip, rseq_cs.post_commit_offset,
>>                              rseq_cs.abort_ip);
>>          instruction_pointer_set(regs, (unsigned long)rseq_cs.abort_ip);
>>          return 0;
>> +
>> +nofixup:
>> +       rseq_force_lazy_sig_fault(t);
>> +       return ret;
>>   }
>>
>>   /*
>> --
>> 2.39.2
>>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


