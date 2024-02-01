Return-Path: <linux-kernel+bounces-47625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D3984506B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB394285F29
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 04:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF4B3BB2D;
	Thu,  1 Feb 2024 04:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWvRomln"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD673BB3A;
	Thu,  1 Feb 2024 04:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706762686; cv=none; b=llddo8IyyHmh8kUh4gFCIL8zYDTcmXNrSUGnIXRnLlp+hzoxVfYnau/VQf5QqkRH3cls7ROR8LGyMXLGwPjiD+tjzGQ8BnA48eQ8umacRZrsRq3IqTbDhGq+ioBMGhE/zHXW3OQNexYCk2EFkCPZKjE50iMCsIONe2T+MxtqICs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706762686; c=relaxed/simple;
	bh=O3YNxEURedLah+jh5cdhC4CNq9Up33rclZoW27fQ2mE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfoUsQvlNHoCYKJR9IaH6Kp4mpetUIrAbFEMT444AuntzmKEgAOu5gnbMpEACEFPUVJV9RRYf7wKAv3ZNzhT+Iiu0p6LbZKI6ATxv/RGbvbnh3n8PbD5wgWCxgwJOQH54fcQLmc3cyCX2Av9C82B7FU7/qn5qM+9LyNUHkeSmbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWvRomln; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5d81b08d6f2so490892a12.0;
        Wed, 31 Jan 2024 20:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706762684; x=1707367484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=029aTVFkjgA0Uk9YLk2Zmxx1CgB9jt1AKIBVMS50BZ0=;
        b=gWvRomlnJECzpQkZqhg7aBiu8TA3PWzkzrp8ZZcufh2cCwXwjl8vfRUo+Qt6x+QNp+
         LpwiI8eHlHdgSLe9mFRfXQWxEZhKzOhhlVqdHfiYPGTuYTF7SSMXQnxHnIFIVIyuyH4f
         d2itw4weatrFstiSTWAMSJRmpIOrWtjD3APg3qslCBL5DP8xTgJOsyDOOwHtA5euRjuk
         3Yr7fNy3uZWgYm2MjaShmZYbSe7XicLlkVnFoD2asY/5vllWaj7g6nbidW72rwXI/nRL
         xxHZ4xxGP0L44WYKi1TQJOkpdCapS9B9+7hx3pATqm5zO9rjZSs73mOU/FLCxjWfwv0X
         6w6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706762684; x=1707367484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=029aTVFkjgA0Uk9YLk2Zmxx1CgB9jt1AKIBVMS50BZ0=;
        b=t9zNm771wOwaWLkyLg+uGnEm8cc/T+0U6FkbzXQtmqVZY0xSvAIzGZPemdsOH88hMW
         FZ9Pxc07ETlPZgnnAXMCQjZlcNG2b3h7W7HuIQ9RlXG1WY6PoqQJBAIPtZfjfAOmJMgd
         HGhMBshRR6pV+nkMevXzUICiv80RVL41TTlQjsCNgodLY5AZ13IZda1hh2vHAxedTJqb
         HRLm7cX50wWp99m9uQKgJVg659eylA0RUmc2B07ADd7/E3tgxxmYb3HoRMfjMTJjE8Xw
         AVj3YgbCoJ+BsepB0Ioh34LAPT6O4Z74/xA5VvUhdB7XbPGamIZD2Uypt0BVyfrz0YMq
         ra6A==
X-Gm-Message-State: AOJu0YzCJKHJ9AxJEbzqpZNSSs2DkIZeFNjT04isHxZRWbCYN09DMTlE
	AQ6gjo8niauFgqipDAo8e+mcRvCI3URXlb9JOQgmiC1qsN1I8FZ0
X-Google-Smtp-Source: AGHT+IEgjfqkHg9Xl5zI+NftQVJzx82WOUpJINg2UU982xIGXjktk6aUBdG/SJITSMJ5rzXTe31FzQ==
X-Received: by 2002:a05:6a21:3398:b0:19c:b3e8:d073 with SMTP id yy24-20020a056a21339800b0019cb3e8d073mr1450296pzb.37.1706762683546;
        Wed, 31 Jan 2024 20:44:43 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXsPjFuWyfWZzmLA/jTy1ypQFQ3e53OpylaHuWTZXKsZjisn2tu0pGeHiWkeRlfaHaZaQPcPNnlHv1e6JB50Oq5BJ9EtnWdUkUaY2a9k/ONmWvCodzOuMYwEx9P4dipMQjSnvsbRayydeVKL61niPUq1rdnsHMEz9hlKLCK1jtV6bFSP4lsq1dnFcM5dnnCgBcOxxBDmdhiq/TSF1gO8Z27whd+a2MATC9qi/da15sgBNkIKOV7uGk72N7Y0bAmYsghHBvl5zaDH+8uAag6D28+nW1RxIT9NEmWem6guFDz2fPthhV7hW/ylWygKrpIfDJuDIFILTMNNclMM1DPHTG3lKCTKvvCDUq3sQ5pT9ZYIdOkuzHmTXwyDqJLKtyI2D8nPUgIz+SQDmw+T2t9jNE2u17Wfko7rBa/lmELC4jkedw=
Received: from DESKTOP-KA7F9LU.localdomain ([2406:7400:63:9bee:605d:5ce4:9585:1c44])
        by smtp.gmail.com with ESMTPSA id fm27-20020a056a002f9b00b006dd8a07696csm10671271pfb.106.2024.01.31.20.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 20:44:42 -0800 (PST)
Date: Thu, 1 Feb 2024 10:14:37 +0530
From: Vimal Kumar <vimal.kumar32@gmail.com>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
	Chinmoy Ghosh <chinmoyghosh2001@gmail.com>,
	Mintu Patel <mintupatel89@gmail.com>,
	Vishal Badole <badolevishal1116@gmail.com>,
	linux-pm@vger.kernel.org, rui.zhang@intel.com, yu.c.chen@intel.com,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PM / sleep: Mechanism to find source aborting kernel
 suspend transition
Message-ID: <20240201044437.GA113@DESKTOP-KA7F9LU.localdomain>
References: <20240109130210.31938-1-vimal.kumar32@gmail.com>
 <202401292109.f115a688-oliver.sang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202401292109.f115a688-oliver.sang@intel.com>

On Mon, Jan 29, 2024 at 10:08:32PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "BUG:sleeping_function_called_from_invalid_context_at_include/linux/sched/mm.h" on:
> 
> commit: e2d228456d500f3b00ad746b353fa85eee235b7a ("[PATCH v3] PM / sleep: Mechanism to find source aborting kernel suspend transition")
> url: https://github.com/intel-lab-lkp/linux/commits/Vimal-Kumar/PM-sleep-Mechanism-to-find-source-aborting-kernel-suspend-transition/20240109-210519
> base: https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git linux-next
> patch link: https://lore.kernel.org/all/20240109130210.31938-1-vimal.kumar32@gmail.com/
> patch subject: [PATCH v3] PM / sleep: Mechanism to find source aborting kernel suspend transition
> 
> in testcase: suspend-stress
> version: 
> with following parameters:
> 
> 	mode: freeze
> 	iterations: 10
> 
> 
> 
> compiler: gcc-12
> test machine: 4 threads (Broadwell) with 8G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202401292109.f115a688-oliver.sang@intel.com
> 
> 
> kern  :err   : [   97.935754] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
> kern  :err   : [   97.935886] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 0, name: swapper/1
> kern  :err   : [   97.936000] preempt_count: 10002, expected: 0
> kern  :err   : [   97.936071] RCU nest depth: 0, expected: 0
> kern  :warn  : [   97.936138] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.7.0-rc8-00169-ge2d228456d50 #1
> kern  :warn  : [   97.936255] Hardware name:  /NUC5i3RYB, BIOS RYBDWi35.86A.0363.2017.0316.1028 03/16/2017
> kern  :warn  : [   97.936371] Call Trace:
> kern  :warn  : [   97.936419]  <IRQ>
> kern :warn : [   97.936461] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
> kern :warn : [   97.936529] __might_resched (kernel/sched/core.c:10152) 
> kern :warn : [   97.936598] ? preempt_notifier_dec (kernel/sched/core.c:10106) 
> kern :warn : [   97.936672] __kmem_cache_alloc_node (include/linux/kernel.h:107 include/linux/sched/mm.h:306 mm/slab.h:710 mm/slub.c:3460 mm/slub.c:3517) 
> kern :warn : [   97.936750] ? kasprintf (lib/kasprintf.c:54) 
> kern :warn : [   97.936812] ? pointer (lib/vsprintf.c:2755) 
> kern :warn : [   97.936875] ? kasprintf (lib/kasprintf.c:54) 
> kern :warn : [   97.936936] __kmalloc_node_track_caller (include/linux/kasan.h:198 mm/slab_common.c:1007 mm/slab_common.c:1027) 
> kern :warn : [   97.937017] kvasprintf (lib/kasprintf.c:25) 
> kern :warn : [   97.937079] ? bust_spinlocks (lib/kasprintf.c:16) 
> kern :warn : [   97.937146] ? enqueue_hrtimer (kernel/time/hrtimer.c:1095 (discriminator 3)) 
> kern :warn : [   97.937214] ? tick_nohz_highres_handler (kernel/time/tick-sched.c:1530) 
> kern :warn : [   97.937295] kasprintf (lib/kasprintf.c:54) 
> kern :warn : [   97.937354] ? kvasprintf_const (lib/kasprintf.c:54) 
> kern :warn : [   97.937426] ? _raw_spin_lock_irqsave (arch/x86/include/asm/atomic.h:115 include/linux/atomic/atomic-arch-fallback.h:2164 include/linux/atomic/atomic-instrumented.h:1296 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162) 
> kern :warn : [   97.937501] ? _raw_read_unlock_irqrestore (kernel/locking/spinlock.c:161) 
> kern :warn : [   97.937581] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:115 include/linux/atomic/atomic-arch-fallback.h:2164 include/linux/atomic/atomic-instrumented.h:1296 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
> kern :warn : [   97.937648] ? _raw_write_lock_irq (kernel/locking/spinlock.c:153) 
> kern :warn : [   97.937719] ? irq_pm_check_wakeup (kernel/irq/pm.c:24) 
> kern :warn : [   97.937793] pm_system_wakeup (drivers/base/power/wakeup.c:981) 
> kern :warn : [   97.937862] irq_pm_check_wakeup (kernel/irq/pm.c:24) 
> kern :warn : [   97.937933] handle_fasteoi_irq (kernel/irq/chip.c:518 kernel/irq/chip.c:502 kernel/irq/chip.c:698) 
> kern :warn : [   97.938006] __common_interrupt (arch/x86/kernel/irq.c:271 (discriminator 22)) 
> kern :warn : [   97.938078] common_interrupt (arch/x86/kernel/irq.c:247 (discriminator 14)) 
> kern  :warn  : [   97.938145]  </IRQ>
> kern  :warn  : [   97.938187]  <TASK>
> kern :warn : [   97.938230] asm_common_interrupt (arch/x86/include/asm/idtentry.h:640) 
> kern :warn : [   97.938301] RIP: 0010:cpuidle_enter_s2idle (arch/x86/include/asm/irqflags.h:78 drivers/cpuidle/cpuidle.c:199) 
> kern :warn : [ 97.938384] Code: d9 75 83 85 d2 7f 11 48 83 c4 20 89 d0 5b 5d 41 5c 41 5d 41 5e 41 5f c3 4c 89 c6 48 89 cf 89 14 24 e8 fb 64 9b 00 fb 8b 14 24 <eb> db 31 d2 eb d7 48 89 0c 24 48 89 74 24 08 e8 03 51 9f fe 4c 8b
> All code
> ========
>    0:	d9 75 83             	fnstenv -0x7d(%rbp)
>    3:	85 d2                	test   %edx,%edx
>    5:	7f 11                	jg     0x18
>    7:	48 83 c4 20          	add    $0x20,%rsp
>    b:	89 d0                	mov    %edx,%eax
>    d:	5b                   	pop    %rbx
>    e:	5d                   	pop    %rbp
>    f:	41 5c                	pop    %r12
>   11:	41 5d                	pop    %r13
>   13:	41 5e                	pop    %r14
>   15:	41 5f                	pop    %r15
>   17:	c3                   	retq   
>   18:	4c 89 c6             	mov    %r8,%rsi
>   1b:	48 89 cf             	mov    %rcx,%rdi
>   1e:	89 14 24             	mov    %edx,(%rsp)
>   21:	e8 fb 64 9b 00       	callq  0x9b6521
>   26:	fb                   	sti    
>   27:	8b 14 24             	mov    (%rsp),%edx
>   2a:*	eb db                	jmp    0x7		<-- trapping instruction
>   2c:	31 d2                	xor    %edx,%edx
>   2e:	eb d7                	jmp    0x7
>   30:	48 89 0c 24          	mov    %rcx,(%rsp)
>   34:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
>   39:	e8 03 51 9f fe       	callq  0xfffffffffe9f5141
>   3e:	4c                   	rex.WR
>   3f:	8b                   	.byte 0x8b
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	eb db                	jmp    0xffffffffffffffdd
>    2:	31 d2                	xor    %edx,%edx
>    4:	eb d7                	jmp    0xffffffffffffffdd
>    6:	48 89 0c 24          	mov    %rcx,(%rsp)
>    a:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
>    f:	e8 03 51 9f fe       	callq  0xfffffffffe9f5117
>   14:	4c                   	rex.WR
>   15:	8b                   	.byte 0x8b
> kern  :warn  : [   97.938632] RSP: 0018:ffffc90000177db8 EFLAGS: 00000286
> kern  :warn  : [   97.938717] RAX: 00000000037a402c RBX: 0000000000000009 RCX: 0000000000000000
> kern  :warn  : [   97.938823] RDX: 0000000000000008 RSI: 0000000937e23ad2 RDI: 0000000000000000
> kern  :warn  : [   97.938927] RBP: ffffffff84f7f680 R08: 0000000000000000 R09: ffffed1021ad5530
> kern  :warn  : [   97.939032] R10: ffff88810d6aa987 R11: 0000000000000000 R12: ffff88820decca10
> kern  :warn  : [   97.939137] R13: dffffc0000000000 R14: 000000000027ac40 R15: 000000000027ac40
> kern :warn : [   97.939244] ? cpuidle_enter_s2idle (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:77 drivers/cpuidle/cpuidle.c:199) 
> kern :warn : [   97.939319] cpuidle_idle_call (kernel/sched/idle.c:190) 
> kern :warn : [   97.939389] ? arch_cpu_idle_exit+0x40/0x40 
> kern :warn : [   97.939459] ? mark_tsc_async_resets (arch/x86/kernel/tsc_sync.c:51) 
> kern :warn : [   97.939536] do_idle (kernel/sched/idle.c:282) 
> kern :warn : [   97.939594] cpu_startup_entry (kernel/sched/idle.c:379 (discriminator 1)) 
> kern :warn : [   97.939662] start_secondary (arch/x86/kernel/smpboot.c:224 arch/x86/kernel/smpboot.c:304) 
> kern :warn : [   97.939731] ? set_cpu_sibling_map (arch/x86/kernel/smpboot.c:254) 
> kern :warn : [   97.939808] ? soft_restart_cpu (arch/x86/kernel/head_64.S:485) 
> kern :warn : [   97.939878] secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:448) 
> kern  :warn  : [   97.939963]  </TASK>
> kern :info : [   97.948803] bdw_uncore 0000:00:00.0: PM: calling pci_pm_resume_noirq+0x0/0x390 @ 85, parent: 00 
> kern :info : [   97.948993] bdw_uncore 0000:00:00.0: PM: pci_pm_resume_noirq+0x0/0x390 returned 0 after 17 usecs 
> 
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240129/202401292109.f115a688-oliver.sang@intel.com
> 
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

Hi Greg,

This is an example where "pm_system_wakeup" can be called from atomic context. It also gives an actual instance where we can utilise this feature to find the source.

The bug reported due to "GFP_KERNEL" flag, but it will be applicable for using "mutex_lock" as well.
I will change to ATOMIC flag in kmalloc, as well as use raw_spin_lock* instead of mutex_lock.


Warm regards,
Vimal Kumar  

