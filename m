Return-Path: <linux-kernel+bounces-86615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 426DA86C7D5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83267B24965
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947D87B3D2;
	Thu, 29 Feb 2024 11:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="K8sDH5wr"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E627B3C8
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 11:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709205334; cv=none; b=LCbXPLQHc5htLUPQtRGbhbJX4d8/WOCXHas/5QH4fZfFWUaHz1IGSsef8/sb9qb2eTDsj0AoggoOyS6go/4siym4DsgSNEPGvUzuAp5IyDNl6Eja87fl9zNTJuwpaevqRrQmGvTUMupA8LKXT5lyZOC7kvDN3GjeI2ZMW9mQLyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709205334; c=relaxed/simple;
	bh=ScTDnUT9IZGYo0LqitQ5RSdISNWE/aRBZO9O6Khzj/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwpegFz94qsdlb+nEe3xnP2O+SKkWCgNtt9NSUXqiHD4qgZDhpdZ2gyR8mxZYnDrMvd+5TFV1hbtCyDAGCNyhZ3IIS+PTtW7IxQmXkLmVh/Q1q0ojJnH7Wki3isr6SQJXDlXhzUGbDY8XXyKVxpnj+1kIhCfEDJql9nv3S5mXZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=K8sDH5wr; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3fb8b0b7acso113798466b.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 03:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1709205330; x=1709810130; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2SaPisXXPwpfscbXUoD4Ne3IHOWXdxOYE/Rc0bOEU6s=;
        b=K8sDH5wrdZqmf21G0aMKUHSBjXpg8l+O87JWKJxDI99j1U7bZgVR603m3G3RfyXhR2
         W0GbKWj7VuzHYi2UJDruQXoX+WU3jKga2Ol/lYiixIIkGJAX2RMYl4G3dSrSixGmOD1I
         7k+if87wxeCD6nctBI/aUMRv1RHbrkCSyHx7w1rHs2Yf1LwFa/ORH3Bcm8lkH5CDQVS8
         AxNYw/nLCynfEXO7fGGgt17q1Lp/Jqw61WR1z+CH7iXe//wz9E2/yvJupMZ4YR1cpWLJ
         wZdHjPLHYoyAcZJXrprBjZVZpLsJF3Yhw7Olgn+kQqSBjIKZju89Lc3eEy059NlFjEK8
         mMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709205330; x=1709810130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2SaPisXXPwpfscbXUoD4Ne3IHOWXdxOYE/Rc0bOEU6s=;
        b=W3J/Gf4Q7g5Nl2r3k58I3xCc/1G7Ukcix/Cho6wzfpJe/RxmrkanaoJhQoGcocb4JX
         xebtqAvbNplQ3WlyVCahd5sWojgk0rh/hlS+fDbHjqYqJBob6JFS2/CGGwDofIgx5mqX
         Ybu9wb0cAl3lX6ZrCfJyf0phYHz/oeP9wkYcjSsqvfBDr3ifBhC6fpxpKJPBl29TMi+S
         Mccli06vxAVXc9hkk2NIeVcLjFB3FnXVxxsmvCckQK2ppVvJfdSQwyEbkV6zH/FUGWSy
         yocj99YYQakDj59UXjwzA6O/CFlzq6KXrlkvnRsKNvQO9ntwgCs1+V0pKhDsdAtzgMCe
         U22Q==
X-Forwarded-Encrypted: i=1; AJvYcCUj9YcO6P/HwaM/scDYDxp4RybMW2/hAIF1uiK0Av+Ko0cMwxP3TsMKlsHH7vXHH6zKvRErdQNdKCc785eZT0ZYnrEpdxfWZhGknlDd
X-Gm-Message-State: AOJu0YwuP/fZthKmEtIRST8aU1rDZDnHjuDeK/EalymHgJeCDAUNTAEA
	bbI/aV0X1Zf4GnNCWAfsyWfucKce+bbygKo9JVsFculnnyCLPoAqZ2HBGpkPnGw=
X-Google-Smtp-Source: AGHT+IG2WMBKHw1LhMLbKDVEImIvZHBwSAOcpRcokkU1J9us4Hrjay05s7Z+RyUbUS2E/QGnznmg5w==
X-Received: by 2002:a17:906:37d1:b0:a44:19a9:7ef3 with SMTP id o17-20020a17090637d100b00a4419a97ef3mr1205430ejc.23.1709205330345;
        Thu, 29 Feb 2024 03:15:30 -0800 (PST)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id st11-20020a170907c08b00b00a3f5c39bf2asm588221ejc.0.2024.02.29.03.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 03:15:29 -0800 (PST)
Date: Thu, 29 Feb 2024 12:15:28 +0100
From: Petr Mladek <pmladek@suse.com>
To: "John B. Wyatt IV" <jwyatt@redhat.com>
Cc: John Ogness <john.ogness@linutronix.de>,
	Clark Williams <williams@redhat.com>, jlelli@redhat.com,
	Derek Barbosa <debarbos@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: NMI Reported with console_blast.sh
Message-ID: <ZeBnUCk598gttpds@alley>
References: <ZcQjxa4UA6hzXHnU@thinkpad2021>
 <87v86yc88b.fsf@jogness.linutronix.de>
 <ZcaQI8l1dcBx2feC@thinkpad2021>
 <87a5o8j9gp.fsf@jogness.linutronix.de>
 <ZcqMOKtHsZ9qnxNg@thinkpad2021>
 <ZdbZz-v_lug9_t6C@thinkpad2021>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdbZz-v_lug9_t6C@thinkpad2021>

On Thu 2024-02-22 00:21:19, John B. Wyatt IV wrote:
> On Mon, Feb 12, 2024 at 04:23:04PM -0500, John B. Wyatt IV wrote:
> > 
> > Red Hat's conservers are having an issue with the machine I was testing
> > on. It may take me a while to get back to you with more test results.
> > 
> 
> Found a work-around with conserver. I was able to follow up on the printk-caller
> info you requested.
> 
> I found 2 additional NMIs for a total of 3. Number 2 is very
> large-please feel free to let me know what specific information you
> wanted if it was unnecessary.
> 
> This first one (the original) is with the real-time profile (no preemption).
> The next two are with the performance-througput (no preemption).
> 
> This is what real-time NMI reports with the caller information enabled. It
> looks like it is lacking some information compared to the other two further below.
> 
> [ T2481] Call Trace:
> [ T2477] Kernel panic - not syncing: sysrq triggered crash
> [    C0] NMI backtrace for cpu 0

This message seems to be printed by nmi_cpu_backtrace().

I am surprised. I would expect to see the backtrace printed from panic().
It calls dump_stack() directly on the panic-CPU. And this panic() should
be called from sysrq_handle_crash(). IMHO, it should be (normal)
interrupt context.

Is it different on RT?

Or have you somehow modified the kernel to use NMI for sysrq?



> [    C0] Hardware name: Intel Corporation D50DNP1SBB/D50DNP1SBB, BIOS SE5C7411.86B.9409.D04.2212261349 12/26/2022
> [ C0] RIP: 0010:io_serial_in (arch/x86/kernel/early_printk.c:100)

I guess that this RIP is from the normal context.
It looks like the NMI interrupted an early_printk() call.

> [ C0] Code: cc 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 0f b6 8f c1 00 00 00 0f b7 57 08 d3 e6 01 f2 ec <0f> b6 c0 c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90
> All code
> ========
>    0:	cc                   	int3
>    1:	0f 1f 40 00          	nopl   0x0(%rax)
>    5:	90                   	nop
>    6:	90                   	nop
>    7:	90                   	nop
>    8:	90                   	nop
>    9:	90                   	nop
>    a:	90                   	nop
>    b:	90                   	nop
>    c:	90                   	nop
>    d:	90                   	nop
>    e:	90                   	nop
>    f:	90                   	nop
>   10:	90                   	nop
>   11:	90                   	nop
>   12:	90                   	nop
>   13:	90                   	nop
>   14:	90                   	nop
>   15:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
>   1a:	0f b6 8f c1 00 00 00 	movzbl 0xc1(%rdi),%ecx
>   21:	0f b7 57 08          	movzwl 0x8(%rdi),%edx
>   25:	d3 e6                	shl    %cl,%esi
>   27:	01 f2                	add    %esi,%edx
>   29:	ec                   	in     (%dx),%al
>   2a:*	0f b6 c0             	movzbl %al,%eax		<-- trapping instruction
>   2d:	c3                   	ret
>   2e:	cc                   	int3
>   2f:	cc                   	int3
>   30:	cc                   	int3
>   31:	cc                   	int3
>   32:	0f 1f 00             	nopl   (%rax)
>   35:	90                   	nop
>   36:	90                   	nop
>   37:	90                   	nop
>   38:	90                   	nop
>   39:	90                   	nop
>   3a:	90                   	nop
>   3b:	90                   	nop
>   3c:	90                   	nop
>   3d:	90                   	nop
>   3e:	90                   	nop
>   3f:	90                   	nop
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	0f b6 c0             	movzbl %al,%eax
>    3:	c3                   	ret
>    4:	cc                   	int3
>    5:	cc                   	int3
>    6:	cc                   	int3
>    7:	cc                   	int3
>    8:	0f 1f 00             	nopl   (%rax)
>    b:	90                   	nop
>    c:	90                   	nop
>    d:	90                   	nop
>    e:	90                   	nop
>    f:	90                   	nop
>   10:	90                   	nop
>   11:	90                   	nop
>   12:	90                   	nop
>   13:	90                   	nop
>   14:	90                   	nop
>   15:	90                   	nop
> [    C0] RSP: 0018:ff4507d95ec1fac0 EFLAGS: 00000002
> [    C0] RAX: ffffffffa13d6f00 RBX: 0000000000000000 RCX: 0000000000000000
> [    C0] RDX: 00000000000003fd RSI: 0000000000000005 RDI: ffffffffa3ad49c0
> [    C0] RBP: 000000000000270f R08: ffffffffa39c73b3 R09: ff4507d95ec1fa1f
> [    C0] R10: 0000000031383432 R11: 0000000038343254 R12: 0000000000000020
> [    C0] R13: ffffffffa3ad49c0 R14: 0000000000000000 R15: 0000000000000000
> [    C0] FS:  00007fd6cce81740(0000) GS:ff1ef00bbf800000(0000) knlGS:0000000000000000
> [    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    C0] CR2: 00007fd6cd05d650 CR3: 000000208e5bc004 CR4: 0000000000771ef0
> [    C0] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [    C0] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
> [    C0] PKRU: 55555554
> [    C0] Call Trace:
> [    C0]  <NMI>
> [ C0] ? nmi_cpu_backtrace (lib/nmi_backtrace.c:115) 
> [ C0] ? nmi_cpu_backtrace_handler (arch/x86/kernel/apic/hw_nmi.c:47 (discriminator 1)) 
> [ C0] ? nmi_handle (arch/x86/kernel/nmi.c:150) 
> [ C0] ? io_serial_in (arch/x86/kernel/early_printk.c:100) 
> [ C0] ? default_do_nmi (arch/x86/kernel/nmi.c:351) 
> [ C0] ? exc_nmi (arch/x86/kernel/nmi.c:545) 
> [ C0] ? end_repeat_nmi (arch/x86/entry/entry_64.S:1394) 
> [ C0] ? mem_serial_out (drivers/tty/serial/8250/8250_port.c:368) 
> [ C0] ? io_serial_in (arch/x86/kernel/early_printk.c:100) 
> [ C0] ? io_serial_in (arch/x86/kernel/early_printk.c:100) 
> [ C0] ? io_serial_in (arch/x86/kernel/early_printk.c:100) 
> [    C0]  </NMI>

I think that <NMI> and </NMI> mean that the backtrace is from
the NMI stack.

Note that all entries are prefixed by '?'. It means that they
were found on the stack but they are not part of the current
call chain.

If the above is true then I miss the backtrace from the normal
context stack which has been interrupted by the NMI.

> [    C0]  <TASK>
> 
> ------------------------------------
> 
> Compared to the two NMIs with throughput-performance (no preemption)
> 
>   <NMI>
>   cpus=0
>    .runnable_avg                  : 3072
>  kthread (kernel/kthread.c:388) 
>    .util_est_enqueued             : 0
>   stack:0     pid:1733  tgid:1733  ppid:2      flags:0x00004000
>    .min_vruntime                  : 2084315.290254
>    .removed.load_avg              : 0
>    .avg_vruntime                  : 2084315.290254
>  console_blast.s  3497     34770.405603 N     34773.405603         3.000000     34764.898340         4   120 
>    .util_avg                      : 1024
>    .util_avg                      : 1024

It looks like messages from more (many) CPUs are mixed. I guess that they
are printed by print_cfs_rq(). But the order looks random.

Also I wonder why it is printed from NMI context. Maybe, it is from
some perf event, similar to hardlockup detector?

[...]

>    .se->avg.load_avg              : 7
>    .rt_throttled                  : 0
>  ? do_syscall_64 (arch/x86/entry/common.c:102) 
>   </NMI>
> 
> ---------------------------------
> 
>  <NMI>
>  dump_stack_lvl (lib/dump_stack.c:107) 
>  panic (kernel/panic.c:344) 
>  nmi_panic (kernel/panic.c:203) 
>  watchdog_hardlockup_check (kernel/watchdog.c:180) 
>  __perf_event_overflow (kernel/events/core.c:9612 (discriminator 2)) 
>  handle_pmi_common (arch/x86/events/intel/core.c:3052 (discriminator 1)) 
>  ? set_pte_vaddr_p4d (arch/x86/mm/init_64.c:307 arch/x86/mm/init_64.c:315) 
>  ? flush_tlb_one_kernel (./arch/x86/include/asm/paravirt.h:81 arch/x86/mm/tlb.c:1171 arch/x86/mm/tlb.c:1126) 
>  ? native_set_fixmap (arch/x86/mm/pgtable.c:679 arch/x86/mm/pgtable.c:688) 
>  ? ghes_copy_tofrom_phys (drivers/acpi/apei/ghes.c:330) 
>  intel_pmu_handle_irq (./arch/x86/include/asm/msr.h:84 ./arch/x86/include/asm/msr.h:118 arch/x86/events/intel/core.c:2427 arch/x86/events/intel/core.c:3118) 
>  perf_event_nmi_handler (arch/x86/events/core.c:1743 arch/x86/events/core.c:1729) 
>  ? native_queued_spin_lock_slowpath (./arch/x86/include/asm/vdso/processor.h:13 ./arch/x86/include/asm/vdso/processor.h:18 kernel/locking/qspinlock.c:383) 
>  nmi_handle (arch/x86/kernel/nmi.c:150) 
>  ? native_queued_spin_lock_slowpath (./arch/x86/include/asm/vdso/processor.h:13 ./arch/x86/include/asm/vdso/processor.h:18 kernel/locking/qspinlock.c:383) 
>  default_do_nmi (arch/x86/kernel/nmi.c:351) 
>  exc_nmi (arch/x86/kernel/nmi.c:545) 
>  end_repeat_nmi (arch/x86/entry/entry_64.S:1394) 

This actually seems to be from perf_event() used by the hardlockup
detector. It triggers NMI.

Best Regards,
Petr

