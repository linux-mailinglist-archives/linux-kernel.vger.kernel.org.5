Return-Path: <linux-kernel+bounces-88240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6B486DF09
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEF03287E29
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C7A6AF99;
	Fri,  1 Mar 2024 10:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nYDINAB7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3sPFyrr7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFC26A8C8;
	Fri,  1 Mar 2024 10:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709287873; cv=none; b=V3iPyoMt0IQF8Xes4K9g2Cjw8R1tAh11ETc2uRZAziAdlrUrUMTLLSElVyQL8tOHEYYCWYE2HPgQ+SHufCxxIiWCWLZLIiYJVugbzwD1V0CuNm4JwrpzSw/7dpFVqjnfcifKhcNIROEMx1okHbnewq1mqJ6BiqpioEG5yo5NkKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709287873; c=relaxed/simple;
	bh=AaXOghJwgnSSIXfJ/siTh9ndW4bK6IBmBDYRzswNu4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isOfMLawEEXAWk3iC+9rSl0LoI1Sa6fsjUCbzavuY1HFKowEMAzLZ2v2tGuPoD9Wone2kC6ts0gV8PNYTkt/c07h3qAL1crLaiZHi0m8IDnNLz9MHo4vxVGVLB3nAKdwdQ0IOiTY2l5rO8kIZMjRJjvYpKa1gPV05GQgO3AMQ5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nYDINAB7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3sPFyrr7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 1 Mar 2024 11:11:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709287866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gzBLZ9FAmi2WGxmvniBOMK66MNrKoPH3TdPVDaji3VE=;
	b=nYDINAB7uMNsDLHc+SlnLLLNS3/cmjCS7k66Q+p48Gc2GZ+ApqFyItFtkiVv8PvxU3CTbo
	N3EVg57lXAbFAxk9pt/8t3+okN5hra3ajwYuYy330klW/oNYEKj15HuTZb0oiCdxyJ9CtC
	OvAfwEsLyz36nFtkPhEKtd2iHeMDiIbCCfzgEAehQ9DfSzYeNVdK+gL5oGbbmczzn7m75D
	qXg5xe2fowXE0J1ln5ht3o6ofE0rlqeTRk6tV7CtDIFQymt+zwoqxkVaoQIckEBZ+Ooc7w
	SVzc8aK9dmiL73NwlZ8327TJcSOeGloTIh8yhYqZAaW6fnmBF8QPMFlEYt0gXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709287866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gzBLZ9FAmi2WGxmvniBOMK66MNrKoPH3TdPVDaji3VE=;
	b=3sPFyrr7HpwhuIzpLtCrvcGbvfmc+tmYIz3H2/LaytPD/QBVAmmBZz3qkTjQN+BTiehbkY
	fFXinX88YK6OvxDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Petr Mladek <pmladek@suse.com>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	John Ogness <john.ogness@linutronix.de>,
	Clark Williams <williams@redhat.com>, jlelli@redhat.com,
	Derek Barbosa <debarbos@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: NMI Reported with console_blast.sh
Message-ID: <20240301101105.eUPvRzUv@linutronix.de>
References: <ZcQjxa4UA6hzXHnU@thinkpad2021>
 <87v86yc88b.fsf@jogness.linutronix.de>
 <ZcaQI8l1dcBx2feC@thinkpad2021>
 <87a5o8j9gp.fsf@jogness.linutronix.de>
 <ZcqMOKtHsZ9qnxNg@thinkpad2021>
 <ZdbZz-v_lug9_t6C@thinkpad2021>
 <ZeBnUCk598gttpds@alley>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZeBnUCk598gttpds@alley>

On 2024-02-29 12:15:28 [+0100], Petr Mladek wrote:
> > [ T2481] Call Trace:
> > [ T2477] Kernel panic - not syncing: sysrq triggered crash
> > [    C0] NMI backtrace for cpu 0
> 
> This message seems to be printed by nmi_cpu_backtrace().
> 
> I am surprised. I would expect to see the backtrace printed from panic().
> It calls dump_stack() directly on the panic-CPU. And this panic() should
> be called from sysrq_handle_crash(). IMHO, it should be (normal)
> interrupt context.
> 
> Is it different on RT?

No, it is all okay and the same. panic() was triggered from sysrq which
is a threaded-IRQ and you don't see this. This triggered an NMI
backtrace on CPU0 and it shows the NMI stack. After that, the TASK
stack follows which could show panic() if the backtrace would show
something. The stack trace for NMI is prefixed with ? so it is a guess
from something on stack, not an actual unroll.

And this part:
> >   15:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
> >   1a:	0f b6 8f c1 00 00 00 	movzbl 0xc1(%rdi),%ecx
> >   21:	0f b7 57 08          	movzwl 0x8(%rdi),%edx
> >   25:	d3 e6                	shl    %cl,%esi
> >   27:	01 f2                	add    %esi,%edx
> >   29:	ec                   	in     (%dx),%al
> >   2a:*	0f b6 c0             	movzbl %al,%eax		<-- trapping instruction
> >   2d:	c3                   	ret

the error of some kind occurred here at 0x2a. But this instruction is
innocent, it simply a zeros the upper 24bit of the register eax. So this
isn't a crash, it is just where the CPUs at the time this was captured.

> >  <NMI>
> >  dump_stack_lvl (lib/dump_stack.c:107) 
> >  panic (kernel/panic.c:344) 
> >  nmi_panic (kernel/panic.c:203) 
> >  watchdog_hardlockup_check (kernel/watchdog.c:180) 
> >  __perf_event_overflow (kernel/events/core.c:9612 (discriminator 2)) 
> >  handle_pmi_common (arch/x86/events/intel/core.c:3052 (discriminator 1)) 
> >  ? set_pte_vaddr_p4d (arch/x86/mm/init_64.c:307 arch/x86/mm/init_64.c:315) 
> >  ? flush_tlb_one_kernel (./arch/x86/include/asm/paravirt.h:81 arch/x86/mm/tlb.c:1171 arch/x86/mm/tlb.c:1126) 
> >  ? native_set_fixmap (arch/x86/mm/pgtable.c:679 arch/x86/mm/pgtable.c:688) 
> >  ? ghes_copy_tofrom_phys (drivers/acpi/apei/ghes.c:330) 
> >  intel_pmu_handle_irq (./arch/x86/include/asm/msr.h:84 ./arch/x86/include/asm/msr.h:118 arch/x86/events/intel/core.c:2427 arch/x86/events/intel/core.c:3118) 
> >  perf_event_nmi_handler (arch/x86/events/core.c:1743 arch/x86/events/core.c:1729) 
> >  ? native_queued_spin_lock_slowpath (./arch/x86/include/asm/vdso/processor.h:13 ./arch/x86/include/asm/vdso/processor.h:18 kernel/locking/qspinlock.c:383) 
> >  nmi_handle (arch/x86/kernel/nmi.c:150) 
> >  ? native_queued_spin_lock_slowpath (./arch/x86/include/asm/vdso/processor.h:13 ./arch/x86/include/asm/vdso/processor.h:18 kernel/locking/qspinlock.c:383) 
> >  default_do_nmi (arch/x86/kernel/nmi.c:351) 
> >  exc_nmi (arch/x86/kernel/nmi.c:545) 
> >  end_repeat_nmi (arch/x86/entry/entry_64.S:1394) 
> 
> This actually seems to be from perf_event() used by the hardlockup
> detector. It triggers NMI.

And the stack is properly unrolled and this the third backtrace. The
second had <NMI> in it as suggesting this is from NMI but also stack
traces from tasks due to sysrq-t.
Now this last backtrace seems fine, and it appears that something tried
to acquire a raw_spinlock_t, it took too long at which point the
hardware watchdog triggered and all we got was this backtrace. Sadly we
don't see the other side to get an idea on which lock it stuck.

> Best Regards,
> Petr

Sebastian

