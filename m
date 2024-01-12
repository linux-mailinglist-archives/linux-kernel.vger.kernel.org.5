Return-Path: <linux-kernel+bounces-24959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0226282C54B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 19:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1E8C284305
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BAC25619;
	Fri, 12 Jan 2024 18:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RwWV8XvW"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7871AAA3
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 18:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e63ceb775so10925005e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 10:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1705083286; x=1705688086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uqc2/15asH+Psqhapypfn05bzRBMPsllW68jUs3NyuM=;
        b=RwWV8XvW6UnIzADtgsDfUIwRGBbvxarqU1x4znJ5hX1jEwAnTAsaoDYLDNJ37aVW9k
         o4IShG9VffBL38U889BuZihshK9/jFoVrN4oebQfta0BDshhiPm+GSMirP+hNrU58KX7
         8mjdZ3bOEKXiicqeWyQUH9pKGbrSMYYX1WqCne7BcrEbjRYCVeKBDmODt5OlDFOQFpzA
         /fJl+Zr51heg8DGl/pvFjKj4/Hea+DSg6v+FIXPigTN/OpSZt4PdX83x8TIJaFv/unKR
         25cqo74SzSdOf8mr5ZTnMaMvIzeZlLk2qO5eNNt/+HqVsvM0GYNtJZjZT8JnT8mHBgbq
         KzZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705083286; x=1705688086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uqc2/15asH+Psqhapypfn05bzRBMPsllW68jUs3NyuM=;
        b=CwUPGaroLdGlWWVX2WlHfmEGAuuWfQVV9xiw83JcmBeEB9K+u3YhwbmfwoU1Hlsz/k
         LCB3WrrLMrhdptiUN7kwm1qtC8B3odearuEQKT3EgLKYq/LnFQb13X3tA6wIKnDopG3i
         H25fhgADLWw+teTEWkODQxNcVOR9ZuJbFaaLiiYDDbHFhMaOfup0b4pWz2ZCWksHAnsL
         aaCfn9uCqgrr/nFDlYKEIVG1GeJSfHAqYHJUEH9nnOQEfPkCcEjjLAJ2C/xBtKOplWNL
         xtvNha3P619tAcQRf2V0oIpN1gPZkfvBD3Pq+cOoeO6LYUALtU3sye+MB6ArekxFHsq1
         txfw==
X-Gm-Message-State: AOJu0YyQzyPYuGsVZQDexEcKvLKq86ydz3ABw4Y3abVRnNDNNsuK7rHp
	cgt9uJZfjah7uTEvzXiHas/gdFQrw1hogA==
X-Google-Smtp-Source: AGHT+IFso1f8S6EqkerV5mSu2F3sOxZKxeU2Ac3/jyFPVtQPRLyYEtw85qmZBoGIHXlP8+WhHXLWuw==
X-Received: by 2002:a05:600c:35d1:b0:40e:5f54:816a with SMTP id r17-20020a05600c35d100b0040e5f54816amr578413wmq.16.1705083285912;
        Fri, 12 Jan 2024 10:14:45 -0800 (PST)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id dc4-20020a056402310400b00557b7b956e9sm2068380edb.54.2024.01.12.10.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 10:14:45 -0800 (PST)
Date: Fri, 12 Jan 2024 19:14:44 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco@dolcini.it>,
	kernel test robot <oliver.sang@intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH printk v3 02/14] printk: Adjust mapping for 32bit seq
 macros
Message-ID: <ZaGBlDTuQ0hYBpeJ@alley>
References: <20231214214201.499426-1-john.ogness@linutronix.de>
 <20231214214201.499426-3-john.ogness@linutronix.de>
 <ZaEUUZ6PICA54qVH@alley>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaEUUZ6PICA54qVH@alley>

On Fri 2024-01-12 11:28:35, Petr Mladek wrote:
> On Thu 2023-12-14 22:47:49, John Ogness wrote:
> > Note: This change only applies to 32bit architectures. On 64bit
> >       architectures the macros are NOPs.
> > 
> > __ulseq_to_u64seq() computes the upper 32 bits of the passed
> > argument value (@ulseq). The upper bits are derived from a base
> > value (@rb_next_seq) in a way that assumes @ulseq represents a
> > 64bit number that is less than or equal to @rb_next_seq.
> > 
> > Until now this mapping has been correct for all call sites. However,
> > in a follow-up commit, values of @ulseq will be passed in that are
> > higher than the base value. This requires a change to how the 32bit
> > value is mapped to a 64bit sequence number.
> > 
> > Rather than mapping @ulseq such that the base value is the end of a
> > 32bit block, map @ulseq such that the base value is in the middle of
> > a 32bit block. This allows supporting 31 bits before and after the
> > base value, which is deemed acceptable for the console sequence
> > number during runtime.
> > 
> > Here is an example to illustrate the previous and new mappings.
> > 
> > For a base value (@rb_next_seq) of 2 2000 0000...
> > 
> > Before this change the range of possible return values was:
> > 
> > 1 2000 0001 to 2 2000 0000
> > 
> > __ulseq_to_u64seq(1fff ffff) => 2 1fff ffff
> > __ulseq_to_u64seq(2000 0000) => 2 2000 0000
> > __ulseq_to_u64seq(2000 0001) => 1 2000 0001
> > __ulseq_to_u64seq(9fff ffff) => 1 9fff ffff
> > __ulseq_to_u64seq(a000 0000) => 1 a000 0000
> > __ulseq_to_u64seq(a000 0001) => 1 a000 0001
> > 
> > After this change the range of possible return values are:
> > 1 a000 0001 to 2 a000 0000
> > 
> > __ulseq_to_u64seq(1fff ffff) => 2 1fff ffff
> > __ulseq_to_u64seq(2000 0000) => 2 2000 0000
> > __ulseq_to_u64seq(2000 0001) => 2 2000 0001
> > __ulseq_to_u64seq(9fff ffff) => 2 9fff ffff
> > __ulseq_to_u64seq(a000 0000) => 2 a000 0000
> > __ulseq_to_u64seq(a000 0001) => 1 a000 0001
> > 
> > [ john.ogness: Rewrite commit message. ]
> > 
> > Reported-by: Francesco Dolcini <francesco@dolcini.it>
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202311171611.78d41dbe-oliver.sang@intel.com
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202311161555.3ee16fc9-oliver.sang@intel.com
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Signed-off-by: John Ogness <john.ogness@linutronix.de>
> 
> Great catch! It must have been complicated to debug this.
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>

That said, I am a bit nervous that a bug like this might cause
workqueue stall and panic() the kernel.

At least, this is how I read
https://lore.kernel.org/oe-lkp/202311171611.78d41dbe-oliver.sang@intel.com/

[  125.917650][    C0] workqueue events: flags=0x0
[  125.917979][    C0]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  125.917984][    C0]     pending: deferred_probe_timeout_work_func
[  125.917992][    C0] workqueue events_power_efficient: flags=0x82
[  125.919409][    C0]   pwq 4: cpus=0-1 flags=0x4 nice=0 active=1/256 refcnt=2
[  125.919412][    C0]     pending: do_cache_clean
[  125.919419][    C0] workqueue mm_percpu_wq: flags=0x8
[  125.920619][    C0]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  125.920622][    C0]     pending: vmstat_update
[  125.920632][    C0] Showing backtraces of running workers in stalled CPU-bound worker pools:
[  129.568547][    C1] rcu: INFO: rcu_sched self-detected stall on CPU
[  129.568553][    C1] rcu: 	1-....: (26250 ticks this GP) idle=3c24/1/0x40000000 softirq=5858/5934 fqs=13122
[  129.568558][    C1] rcu: 	(t=26251 jiffies g=301 q=598 ncpus=2)
[  129.568562][    C1] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W        N 6.6.0-00134-g768c33033e41 #1
[ 129.568565][ C1] EIP: desc_read (kernel/printk/printk_ringbuffer.c:439) 
[ 129.568573][ C1] Code: fb 83 c4 08 5b 5e 5f 5d c3 8d 74 26 00 0f 0b eb d2 3e 8d 74 26 00 55 89 e5 57 89 cf 56 53 89 c3 83 ec 08 8b 08 b8 ff ff ff ff <89> 55 f0 d3 e0 f7 d0 21 d0 6b f0 58 83 f9 1f 0f 87 a7 e6 83 00 03

[  129.568575][    C1] EAX: ffffffff EBX: c1d5cd60 ECX: 0000000f EDX: 3fff8001
[  129.568576][    C1] ESI: 00000001 EDI: c320fd78 EBP: c320fd28 ESP: c320fd14
[  129.568578][    C1] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00000286
[  129.568582][    C1] CR0: 80050033 CR2: b7d77b93 CR3: 022b4000 CR4: 00040690
[  129.568583][    C1] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  129.568584][    C1] DR6: fffe0ff0 DR7: 00000400
[  129.568585][    C1] Call Trace:
[ 129.568589][ C1] ? show_regs (arch/x86/kernel/dumpstack.c:479) 
[ 129.568596][ C1] ? dump_cpu_task (kernel/sched/core.c:11572) 
[ 129.568602][ C1] ? rcu_dump_cpu_stacks (include/linux/cpumask.h:143 include/linux/cpumask.h:150 include/linux/cpumask.h:212 kernel/rcu/tree_stall.h:367) 
[ 129.568606][ C1] ? vprintk (kernel/printk/printk_safe.c:46) 
[ 129.568611][ C1] ? print_cpu_stall (kernel/rcu/tree_stall.h:692) 
[ 129.568616][ C1] ? check_cpu_stall (kernel/rcu/tree_stall.h:775) 
[ 129.568620][ C1] ? rcu_sched_clock_irq (kernel/rcu/tree.c:3869 kernel/rcu/tree.c:2240) 
[ 129.568623][ C1] ? update_process_times (arch/x86/include/asm/preempt.h:27 kernel/time/timer.c:2080) 
[ 129.568628][ C1] ? tick_sched_timer (kernel/time/tick-sched.c:1497) 
[ 129.568632][ C1] ? __hrtimer_run_queues (kernel/time/hrtimer.c:1688 kernel/time/hrtimer.c:1752) 
[ 129.568636][ C1] ? cpumask_weight (arch/x86/kernel/alternative.c:1766) 
[ 129.568640][ C1] ? hrtimer_interrupt (kernel/time/hrtimer.c:1817) 
[ 129.568645][ C1] ? sysvec_call_function_single (arch/x86/kernel/apic/apic.c:1074) 
[ 129.568650][ C1] ? __sysvec_apic_timer_interrupt (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:444 include/linux/jump_label.h:260 include/linux/jump_label.h:270 arch/x86/include/asm/trace/irq_vectors.h:41 arch/x86/kernel/apic/apic.c:1081) 
[ 129.568653][ C1] ? sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1074) 
[ 129.568656][ C1] ? handle_exception (arch/x86/entry/entry_32.S:1049) 
[ 129.568662][ C1] ? sysvec_call_function_single (arch/x86/kernel/apic/apic.c:1074) 
[ 129.568664][ C1] ? desc_read (kernel/printk/printk_ringbuffer.c:439) 
[ 129.568668][ C1] ? sysvec_call_function_single (arch/x86/kernel/apic/apic.c:1074) 
[ 129.568670][ C1] ? desc_read (kernel/printk/printk_ringbuffer.c:439) 
[ 129.568675][ C1] desc_read_finalized_seq (kernel/printk/printk_ringbuffer.c:1907) 
[ 129.568680][ C1] prb_next_reserve_seq (kernel/printk/printk_ringbuffer.c:2084) 
[ 129.568682][ C1] ? nbcon_get_cpu_emergency_nesting (kernel/printk/nbcon.c:984) 
[ 129.568689][ C1] nbcon_atomic_flush_all (kernel/printk/nbcon.c:1133) 
[ 129.568692][ C1] ? nbcon_atomic_flush_all (kernel/printk/nbcon.c:1133) 
[ 129.568695][ C1] printk_trigger_flush (arch/x86/include/asm/preempt.h:85 kernel/printk/printk.c:3993) 
[ 129.568698][ C1] nbcon_cpu_emergency_exit (kernel/printk/nbcon.c:1193) 
[ 129.568701][ C1] ? refcount_warn_saturate (lib/refcount.c:28 (discriminator 3)) 
[ 129.568706][ C1] __warn (kernel/panic.c:692) 
[ 129.568711][ C1] ? refcount_warn_saturate (lib/refcount.c:28 (discriminator 3)) 
[ 129.568714][ C1] report_bug (lib/bug.c:201 lib/bug.c:219) 
[ 129.568720][ C1] ? exc_overflow (arch/x86/kernel/traps.c:250) 
[ 129.568722][ C1] handle_bug (arch/x86/kernel/traps.c:216) 
[ 129.568724][ C1] exc_invalid_op (arch/x86/kernel/traps.c:258 (discriminator 1)) 
[ 129.568727][ C1] handle_exception (arch/x86/entry/entry_32.S:1049) 
[ 129.568729][ C1] EIP: refcount_warn_saturate (lib/refcount.c:28 (discriminator 3)) 
[ 129.568731][ C1] Code: 79 18 c2 01 68 a8 b9 c3 c1 e8 03 7b cf ff 0f 0b 58 c9 c3 8d b6 00 00 00 00 c6 05 86 79 18 c2 01 68 50 b9 c3 c1 e8 e7 7a cf ff <0f> 0b 59 c9 c3 66 90 89 c2 8b 00 3d 00 00 00 c0 74 12 83 f8 01 74

It looks like it caused some loop and refcout overlow or so.
But I might be wrong.

I would like to better understand this and check if we could prevent
it somehow.

Best Regards,
Petr

