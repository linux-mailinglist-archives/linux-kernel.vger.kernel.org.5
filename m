Return-Path: <linux-kernel+bounces-52032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7AB849319
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 05:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF3881C20294
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 04:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729D5B65F;
	Mon,  5 Feb 2024 04:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByolKCBG"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F46AD58;
	Mon,  5 Feb 2024 04:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707108888; cv=none; b=rUwksxP52nCvn5nCaag4RFIEcT34UcOZ2JRtHVlwF13IW4qnhyXHDMx2byslt7fof+8bg/f2LMEOPkuMGH8Ckdwdna7SXYDqanERMiOZHG/Lo9VGK4OU5h4bxjcTRgGXkAU+rwq4lZ5nSXnVXFEgxHMtEgUbhO4FqMiXKqMvRRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707108888; c=relaxed/simple;
	bh=nMpSfqi7ZFISY+EjBOdFx+jM4cvPJbCuZ+FU4pDq434=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=by9v2fgUUjUXjvjJtwH8pEdXTTJF1K2Hto25dHBSp5Do0LY9j4yVS3HT+TF392xRDH9vBpozgN7kvSF5qu70a31NdRU4O8XRY9hjL+aQUJUIgPzxxbCAsgkJn6o4uQe8wFipd2wpqUFz+KJ543TvUVmoA1fDCZ3n6dFNjE8ODpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ByolKCBG; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d7858a469aso28619115ad.2;
        Sun, 04 Feb 2024 20:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707108886; x=1707713686; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XnqizP/EpRlVpKir0OkN1dao+NwnPy/m8rTS5fbKrfE=;
        b=ByolKCBGJ2OECQZbYv+CjWXKgevH1LLbDRe1fCO3M66Zc7cXcbgKiH8OSJUgUJ5Cod
         hr+UuEmrri0gANB/+CT/aCrU57RTV7DJgnBf7/r+BZqgID16HieUVX5eXrbCtgWXCyMt
         UbJRb9S0L1pqDIWA69KgEizLBpqPvE18+hi7zceWzSMMXrbyHhqtLa9rAXPIwq3XUwnA
         EurT6Jr0mMN7PZc40koPqXjbpoMtTy9bNawQJOZNmpdX/P018lxLW1fOC1k65Ya/o6Ge
         LGdo+mg78wQ3LExlIy5BZ0RH/qa1JpAMW2KqHpIxzp11KQOOBltGEK5y+KKTtpXOHxr7
         gs6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707108886; x=1707713686;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XnqizP/EpRlVpKir0OkN1dao+NwnPy/m8rTS5fbKrfE=;
        b=ZrVNGLZNwJQ60vl2Ctb0ykiCKgYXsnvFLLjwSLS7MQbuhFEhO8bJllOyU0q01mRRhm
         dHu2a/8qAGHrUJ9ZpIg/CJv1zKyBaEw8iBIEWHVfObaZwQ/f1rNjJXsS5kYQxlRoHlUU
         dnAAmMwup2YktNB8yo5gdLNa/kRkOvtEd4YpJ5OhcnlyxiXIv7D4gZRudu9Xf/Pv/3kg
         6Y/bGGCfbm72G9nAzHn+bFyUjr8rHg6otCXpbEBpBykw18AOXEu1IhyK81e+Ncw6DU8u
         PxTXbNZ0m5WXwnC4MNbR2a7aKyURdjqNdXdt4+yoPXfBLTN79Ww09XL8M2ArUnBBthg5
         NFVQ==
X-Gm-Message-State: AOJu0Yw//mgoTOC6x7NBVVYaOKj4t+qcpke2NNl3ffrDUNY4Cv7za9p/
	ZksEdlhFF/JsUJc65t+UBrRBm0ApTKl9Jk5HHdgd/UU5CgMZ7apA
X-Google-Smtp-Source: AGHT+IGdZ9Nw6ndgNYJku3ELmOXxUaZunIWT8f4DhM5qEPPYYtPD7anuyhDPQxzkfH1JDGj9cJ9tgw==
X-Received: by 2002:a17:903:32cb:b0:1d9:6091:6f3b with SMTP id i11-20020a17090332cb00b001d960916f3bmr10636022plr.47.1707108885784;
        Sun, 04 Feb 2024 20:54:45 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVIA/+b2reYSvJMvM+siPd2sFvQPfuLg75ymFAuYTXPMllItAYb8lkTDY3WJpaLmf2mrolAbjUoYcVpaDUKKrCbjVY/FqAPqCptmNgxKYdRD82eZGRZ/2nY6HIxKM0Rgi0GbGZXkSB+81mC1TUsCM7w0JF0oTXfV2AcSPyteXXmtsp6xLj/EwBMd96uuQn6cum1tISKPNI8RhypSK56rfVz/IaHOmJTUtaAUInNBHx386lRUHKoTBsApFjUE5Id1H59VEruLySkGcQk+o0PYIU2Fl+/bGa85KCjRZlb1OkrIoPKpBZsWP8QEPTLG+Qy4J/E7uUvd76ILT6oMBagEH3/QTKMhWZEBpCtES3WJyTvhn+JPG1jERRBJ0mqeB3Pk75ubjThSxw50aM3PVprFhdMgdRW5QgGftkGGqFfW8cKPVrfjc7rkA==
Received: from DESKTOP-KA7F9LU.localdomain ([2406:7400:63:bcee:3010:3a5c:b341:6b38])
        by smtp.gmail.com with ESMTPSA id l4-20020a170903244400b001d9620dd3fdsm5257270pls.206.2024.02.04.20.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 20:54:45 -0800 (PST)
Date: Mon, 5 Feb 2024 10:24:39 +0530
From: Vimal Kumar <vimal.kumar32@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, Chinmoy Ghosh <chinmoyghosh2001@gmail.com>,
	Mintu Patel <mintupatel89@gmail.com>,
	Vishal Badole <badolevishal1116@gmail.com>,
	linux-pm@vger.kernel.org, rui.zhang@intel.com, yu.c.chen@intel.com,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PM / sleep: Mechanism to find source aborting kernel
 suspend transition
Message-ID: <20240205045439.GA2553@DESKTOP-KA7F9LU.localdomain>
References: <20240109130210.31938-1-vimal.kumar32@gmail.com>
 <202401292109.f115a688-oliver.sang@intel.com>
 <20240201044437.GA113@DESKTOP-KA7F9LU.localdomain>
 <CAJZ5v0geH_xn9RDGRUZ1izFt2cOA7_mo8r=8C3HoqZ1icfVKBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0geH_xn9RDGRUZ1izFt2cOA7_mo8r=8C3HoqZ1icfVKBA@mail.gmail.com>

On Thu, Feb 01, 2024 at 02:59:00PM +0100, Rafael J. Wysocki wrote:
> On Thu, Feb 1, 2024 at 5:44 AM Vimal Kumar <vimal.kumar32@gmail.com> wrote:
> >
> > On Mon, Jan 29, 2024 at 10:08:32PM +0800, kernel test robot wrote:
> > >
> > >
> > > Hello,
> > >
B> > > kernel test robot noticed "BUG:sleeping_function_called_from_invalid_context_at_include/linux/sched/mm.h" on:
> > >
> > > commit: e2d228456d500f3b00ad746b353fa85eee235b7a ("[PATCH v3] PM / sleep: Mechanism to find source aborting kernel suspend transition")
> > > url: https://github.com/intel-lab-lkp/linux/commits/Vimal-Kumar/PM-sleep-Mechanism-to-find-source-aborting-kernel-suspend-transition/20240109-210519
> > > base: https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git linux-next
> > > patch link: https://lore.kernel.org/all/20240109130210.31938-1-vimal.kumar32@gmail.com/
> > > patch subject: [PATCH v3] PM / sleep: Mechanism to find source aborting kernel suspend transition
> > >
> > > in testcase: suspend-stress
> > > version:
> > > with following parameters:
> > >
> > >       mode: freeze
> > >       iterations: 10
> > >
> > >
> > >
> > > compiler: gcc-12
> > > test machine: 4 threads (Broadwell) with 8G memory
> > >
> > > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > >
> > >
> > >
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > > | Closes: https://lore.kernel.org/oe-lkp/202401292109.f115a688-oliver.sang@intel.com
> > >
> > >
> > > kern  :err   : [   97.935754] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
> > > kern  :err   : [   97.935886] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 0, name: swapper/1
> > > kern  :err   : [   97.936000] preempt_count: 10002, expected: 0
> > > kern  :err   : [   97.936071] RCU nest depth: 0, expected: 0
> > > kern  :warn  : [   97.936138] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.7.0-rc8-00169-ge2d228456d50 #1
> > > kern  :warn  : [   97.936255] Hardware name:  /NUC5i3RYB, BIOS RYBDWi35.86A.0363.2017.0316.1028 03/16/2017
> > > kern  :warn  : [   97.936371] Call Trace:
> > > kern  :warn  : [   97.936419]  <IRQ>
> > > kern :warn : [   97.936461] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1))
> > > kern :warn : [   97.936529] __might_resched (kernel/sched/core.c:10152)
> > > kern :warn : [   97.936598] ? preempt_notifier_dec (kernel/sched/core.c:10106)
> > > kern :warn : [   97.936672] __kmem_cache_alloc_node (include/linux/kernel.h:107 include/linux/sched/mm.h:306 mm/slab.h:710 mm/slub.c:3460 mm/slub.c:3517)
> > > kern :warn : [   97.936750] ? kasprintf (lib/kasprintf.c:54)
> > > kern :warn : [   97.936812] ? pointer (lib/vsprintf.c:2755)
> > > kern :warn : [   97.936875] ? kasprintf (lib/kasprintf.c:54)
> > > kern :warn : [   97.936936] __kmalloc_node_track_caller (include/linux/kasan.h:198 mm/slab_common.c:1007 mm/slab_common.c:1027)
> > > kern :warn : [   97.937017] kvasprintf (lib/kasprintf.c:25)
> > > kern :warn : [   97.937079] ? bust_spinlocks (lib/kasprintf.c:16)
> > > kern :warn : [   97.937146] ? enqueue_hrtimer (kernel/time/hrtimer.c:1095 (discriminator 3))
> > > kern :warn : [   97.937214] ? tick_nohz_highres_handler (kernel/time/tick-sched.c:1530)
> > > kern :warn : [   97.937295] kasprintf (lib/kasprintf.c:54)
> > > kern :warn : [   97.937354] ? kvasprintf_const (lib/kasprintf.c:54)
> > > kern :warn : [   97.937426] ? _raw_spin_lock_irqsave (arch/x86/include/asm/atomic.h:115 include/linux/atomic/atomic-arch-fallback.h:2164 include/linux/atomic/atomic-instrumented.h:1296 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162)
> > > kern :warn : [   97.937501] ? _raw_read_unlock_irqrestore (kernel/locking/spinlock.c:161)
> > > kern :warn : [   97.937581] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:115 include/linux/atomic/atomic-arch-fallback.h:2164 include/linux/atomic/atomic-instrumented.h:1296 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154)
> > > kern :warn : [   97.937648] ? _raw_write_lock_irq (kernel/locking/spinlock.c:153)
> > > kern :warn : [   97.937719] ? irq_pm_check_wakeup (kernel/irq/pm.c:24)
> > > kern :warn : [   97.937793] pm_system_wakeup (drivers/base/power/wakeup.c:981)
> > > kern :warn : [   97.937862] irq_pm_check_wakeup (kernel/irq/pm.c:24)
> > > kern :warn : [   97.937933] handle_fasteoi_irq (kernel/irq/chip.c:518 kernel/irq/chip.c:502 kernel/irq/chip.c:698)
> > > kern :warn : [   97.938006] __common_interrupt (arch/x86/kernel/irq.c:271 (discriminator 22))
> > > kern :warn : [   97.938078] common_interrupt (arch/x86/kernel/irq.c:247 (discriminator 14))
> > > kern  :warn  : [   97.938145]  </IRQ>
> > > kern  :warn  : [   97.938187]  <TASK>
> > > kern :warn : [   97.938230] asm_common_interrupt (arch/x86/include/asm/idtentry.h:640)
> > > kern :warn : [   97.938301] RIP: 0010:cpuidle_enter_s2idle (arch/x86/include/asm/irqflags.h:78 drivers/cpuidle/cpuidle.c:199)
> > > kern :warn : [ 97.938384] Code: d9 75 83 85 d2 7f 11 48 83 c4 20 89 d0 5b 5d 41 5c 41 5d 41 5e 41 5f c3 4c 89 c6 48 89 cf 89 14 24 e8 fb 64 9b 00 fb 8b 14 24 <eb> db 31 d2 eb d7 48 89 0c 24 48 89 74 24 08 e8 03 51 9f fe 4c 8b
> > > All code
> > > ========
> > >    0: d9 75 83                fnstenv -0x7d(%rbp)
> > >    3: 85 d2                   test   %edx,%edx
> > >    5: 7f 11                   jg     0x18
> > >    7: 48 83 c4 20             add    $0x20,%rsp
> > >    b: 89 d0                   mov    %edx,%eax
> > >    d: 5b                      pop    %rbx
> > >    e: 5d                      pop    %rbp
> > >    f: 41 5c                   pop    %r12
> > >   11: 41 5d                   pop    %r13
> > >   13: 41 5e                   pop    %r14
> > >   15: 41 5f                   pop    %r15
> > >   17: c3                      retq
> > >   18: 4c 89 c6                mov    %r8,%rsi
> > >   1b: 48 89 cf                mov    %rcx,%rdi
> > >   1e: 89 14 24                mov    %edx,(%rsp)
> > >   21: e8 fb 64 9b 00          callq  0x9b6521
> > >   26: fb                      sti
> > >   27: 8b 14 24                mov    (%rsp),%edx
> > >   2a:*        eb db                   jmp    0x7              <-- trapping instruction
> > >   2c: 31 d2                   xor    %edx,%edx
> > >   2e: eb d7                   jmp    0x7
> > >   30: 48 89 0c 24             mov    %rcx,(%rsp)
> > >   34: 48 89 74 24 08          mov    %rsi,0x8(%rsp)
> > >   39: e8 03 51 9f fe          callq  0xfffffffffe9f5141
> > >   3e: 4c                      rex.WR
> > >   3f: 8b                      .byte 0x8b
> > >
> > > Code starting with the faulting instruction
> > > ===========================================
> > >    0: eb db                   jmp    0xffffffffffffffdd
> > >    2: 31 d2                   xor    %edx,%edx
> > >    4: eb d7                   jmp    0xffffffffffffffdd
> > >    6: 48 89 0c 24             mov    %rcx,(%rsp)
> > >    a: 48 89 74 24 08          mov    %rsi,0x8(%rsp)
> > >    f: e8 03 51 9f fe          callq  0xfffffffffe9f5117
> > >   14: 4c                      rex.WR
> > >   15: 8b                      .byte 0x8b
> > > kern  :warn  : [   97.938632] RSP: 0018:ffffc90000177db8 EFLAGS: 00000286
> > > kern  :warn  : [   97.938717] RAX: 00000000037a402c RBX: 0000000000000009 RCX: 0000000000000000
> > > kern  :warn  : [   97.938823] RDX: 0000000000000008 RSI: 0000000937e23ad2 RDI: 0000000000000000
> > > kern  :warn  : [   97.938927] RBP: ffffffff84f7f680 R08: 0000000000000000 R09: ffffed1021ad5530
> > > kern  :warn  : [   97.939032] R10: ffff88810d6aa987 R11: 0000000000000000 R12: ffff88820decca10
> > > kern  :warn  : [   97.939137] R13: dffffc0000000000 R14: 000000000027ac40 R15: 000000000027ac40
> > > kern :warn : [   97.939244] ? cpuidle_enter_s2idle (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:77 drivers/cpuidle/cpuidle.c:199)
> > > kern :warn : [   97.939319] cpuidle_idle_call (kernel/sched/idle.c:190)
> > > kern :warn : [   97.939389] ? arch_cpu_idle_exit+0x40/0x40
> > > kern :warn : [   97.939459] ? mark_tsc_async_resets (arch/x86/kernel/tsc_sync.c:51)
> > > kern :warn : [   97.939536] do_idle (kernel/sched/idle.c:282)
> > > kern :warn : [   97.939594] cpu_startup_entry (kernel/sched/idle.c:379 (discriminator 1))
> > > kern :warn : [   97.939662] start_secondary (arch/x86/kernel/smpboot.c:224 arch/x86/kernel/smpboot.c:304)
> > > kern :warn : [   97.939731] ? set_cpu_sibling_map (arch/x86/kernel/smpboot.c:254)
> > > kern :warn : [   97.939808] ? soft_restart_cpu (arch/x86/kernel/head_64.S:485)
> > > kern :warn : [   97.939878] secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:448)
> > > kern  :warn  : [   97.939963]  </TASK>
> > > kern :info : [   97.948803] bdw_uncore 0000:00:00.0: PM: calling pci_pm_resume_noirq+0x0/0x390 @ 85, parent: 00
> > > kern :info : [   97.948993] bdw_uncore 0000:00:00.0: PM: pci_pm_resume_noirq+0x0/0x390 returned 0 after 17 usecs
> > >
> > >
> > >
> > > The kernel config and materials to reproduce are available at:
> > > https://download.01.org/0day-ci/archive/20240129/202401292109.f115a688-oliver.sang@intel.com
> > >
> > >
> > >
> > > --
> > > 0-DAY CI Kernel Test Service
> > > https://github.com/intel/lkp-tests/wiki
> > >
> >
> > Hi Greg,
> >
> > This is an example where "pm_system_wakeup" can be called from atomic context. It also gives an actual instance where we can utilise this feature to find the source.
> >
> > The bug reported due to "GFP_KERNEL" flag, but it will be applicable for using "mutex_lock" as well.
> > I will change to ATOMIC flag in kmalloc, as well as use raw_spin_lock* instead of mutex_lock.
> 
> Maybe instead of trying to add bandaids, you could work on making the
> wakeup sources infrastructure suitable for addressing your use case?

Sure, Rafael. Thanks for acknowledging it. We are making a plan to correct wakeup sources infrastructure but this patch will help those products
which are already released and seeking for "how to debug and fix".

As per my understanding, this current patch will help find the issues in projects that are based on <6.8 mainline, and
the developer/OEM/ODM can find and fix the issues easily.

Warm Regards,
Vimal Kumar

