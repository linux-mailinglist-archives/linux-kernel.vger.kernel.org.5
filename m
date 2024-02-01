Return-Path: <linux-kernel+bounces-48274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F379845972
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB0F0B235C1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEB05D475;
	Thu,  1 Feb 2024 13:59:15 +0000 (UTC)
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEF65CDFE;
	Thu,  1 Feb 2024 13:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706795954; cv=none; b=QOJojjrF5JNsZeE4oLWK2tHNZvLa/h0M+Dqlq9oDDuqQw/LAxewM0b8U2qk1aLLfxIro7MjYydN+ZlDOxYm0DeAqNZwlkWpfMmwgzhB8fZ74o3FpVn3VBmkvpXdFzNePQZTXhIiR/VjFb3H6Vj8JX9wOCgJjkTwL/9/EexcH3xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706795954; c=relaxed/simple;
	bh=grZmON5V2pS5iBkv32N1mWLVplVq2WK7EVWyx82N3PM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AfNdfgygo5imksHCtaubnEgLXlVlOp6mfiYIexw5ElYIqLBYzp+QNc2RQIAVRug31kQIxwMR3CbCTF1tqBpDis3au9+bUujn7pthCmWjQKOfChPU1HB3puccGMiSZoRuymLb644rjAYh7Zk04UWu7dHC53/7+usEKZ8YcQAkHWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-59584f41f1eso272733eaf.1;
        Thu, 01 Feb 2024 05:59:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706795951; x=1707400751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mmjGv0GaBOTQ12K5AbRONMLGMjSiQVl1WcXF4oblEaw=;
        b=dL31krouDag1aC15QxxTUVq3QnqdR0d1W8bA9roJuQ0lQs/fgKrMLME1rSkZbFPHx/
         7cBfqOsM6Yy0ekVoW14pMCc4ButwrGMh9dM1ksAHVXDW5m6ERF45dmGKrZzwWYGOwcWE
         ygfBkXduUyrj1kMmRDupvmwzt6+riHpwLP65kzQHKX/erT8n3QbaAB9jbdVR5Qp0z+jZ
         /kmMTdPiJHlFPHSNSn62Fp+MqG/eHrHQ7131bDZ/w6c5V4tol7hR6pElv9mI6AC18/h7
         kLwilmkI4usOr0qGbzOh1+AgDvDkBq55Qffxs673+TH0BPjtC6695Xl9BGilWWORvmCD
         vptQ==
X-Forwarded-Encrypted: i=0; AJvYcCW9IgRfscCDeuf8BQ0dPDK4vLG36jyu4MMDKJFn8Zpqq1mX6fdDEYxyA3GOEQQ6U9eArcyZDujU1/1yDmYG7K9YkO4jPjqutgFy1Y47tBl6sveHUi9wQm9qacKsEkNEsQd61gglaIU=
X-Gm-Message-State: AOJu0YyP3LvO4PSbQuQ7IvPfu3Pc5QSMOk477AXjBs07zaxaNdtfb16q
	SkcQ+cCb9pDLqyHEeMuqqJxC9YQiUtzIMdCYoErA1GdcvFu7sN9MdiDn8x8m76n2woXbxrBdjhu
	uAmBTfIfyAPc1C5Rr2+eTLp6tUIU=
X-Google-Smtp-Source: AGHT+IH7vQIXGCqeFSp/9OtrwVG3NcK9LlW7sW0AUDZ0WvdPl+HQ1s36SytLRPThNUSp89nPcK/6c3Uo+r+eaoIimdQ=
X-Received: by 2002:a05:6820:2224:b0:59a:127c:bdfe with SMTP id
 cj36-20020a056820222400b0059a127cbdfemr3140773oob.1.1706795951342; Thu, 01
 Feb 2024 05:59:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109130210.31938-1-vimal.kumar32@gmail.com>
 <202401292109.f115a688-oliver.sang@intel.com> <20240201044437.GA113@DESKTOP-KA7F9LU.localdomain>
In-Reply-To: <20240201044437.GA113@DESKTOP-KA7F9LU.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 1 Feb 2024 14:59:00 +0100
Message-ID: <CAJZ5v0geH_xn9RDGRUZ1izFt2cOA7_mo8r=8C3HoqZ1icfVKBA@mail.gmail.com>
Subject: Re: [PATCH v3] PM / sleep: Mechanism to find source aborting kernel
 suspend transition
To: Vimal Kumar <vimal.kumar32@gmail.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	Chinmoy Ghosh <chinmoyghosh2001@gmail.com>, Mintu Patel <mintupatel89@gmail.com>, 
	Vishal Badole <badolevishal1116@gmail.com>, linux-pm@vger.kernel.org, rui.zhang@intel.com, 
	yu.c.chen@intel.com, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, 
	Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 5:44=E2=80=AFAM Vimal Kumar <vimal.kumar32@gmail.com=
> wrote:
>
> On Mon, Jan 29, 2024 at 10:08:32PM +0800, kernel test robot wrote:
> >
> >
> > Hello,
> >
> > kernel test robot noticed "BUG:sleeping_function_called_from_invalid_co=
ntext_at_include/linux/sched/mm.h" on:
> >
> > commit: e2d228456d500f3b00ad746b353fa85eee235b7a ("[PATCH v3] PM / slee=
p: Mechanism to find source aborting kernel suspend transition")
> > url: https://github.com/intel-lab-lkp/linux/commits/Vimal-Kumar/PM-slee=
p-Mechanism-to-find-source-aborting-kernel-suspend-transition/20240109-2105=
19
> > base: https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git =
linux-next
> > patch link: https://lore.kernel.org/all/20240109130210.31938-1-vimal.ku=
mar32@gmail.com/
> > patch subject: [PATCH v3] PM / sleep: Mechanism to find source aborting=
 kernel suspend transition
> >
> > in testcase: suspend-stress
> > version:
> > with following parameters:
> >
> >       mode: freeze
> >       iterations: 10
> >
> >
> >
> > compiler: gcc-12
> > test machine: 4 threads (Broadwell) with 8G memory
> >
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> >
> >
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202401292109.f115a688-oliver.s=
ang@intel.com
> >
> >
> > kern  :err   : [   97.935754] BUG: sleeping function called from invali=
d context at include/linux/sched/mm.h:306
> > kern  :err   : [   97.935886] in_atomic(): 1, irqs_disabled(): 1, non_b=
lock: 0, pid: 0, name: swapper/1
> > kern  :err   : [   97.936000] preempt_count: 10002, expected: 0
> > kern  :err   : [   97.936071] RCU nest depth: 0, expected: 0
> > kern  :warn  : [   97.936138] CPU: 1 PID: 0 Comm: swapper/1 Not tainted=
 6.7.0-rc8-00169-ge2d228456d50 #1
> > kern  :warn  : [   97.936255] Hardware name:  /NUC5i3RYB, BIOS RYBDWi35=
86A.0363.2017.0316.1028 03/16/2017
> > kern  :warn  : [   97.936371] Call Trace:
> > kern  :warn  : [   97.936419]  <IRQ>
> > kern :warn : [   97.936461] dump_stack_lvl (lib/dump_stack.c:107 (discr=
iminator 1))
> > kern :warn : [   97.936529] __might_resched (kernel/sched/core.c:10152)
> > kern :warn : [   97.936598] ? preempt_notifier_dec (kernel/sched/core.c=
:10106)
> > kern :warn : [   97.936672] __kmem_cache_alloc_node (include/linux/kern=
el.h:107 include/linux/sched/mm.h:306 mm/slab.h:710 mm/slub.c:3460 mm/slub.=
c:3517)
> > kern :warn : [   97.936750] ? kasprintf (lib/kasprintf.c:54)
> > kern :warn : [   97.936812] ? pointer (lib/vsprintf.c:2755)
> > kern :warn : [   97.936875] ? kasprintf (lib/kasprintf.c:54)
> > kern :warn : [   97.936936] __kmalloc_node_track_caller (include/linux/=
kasan.h:198 mm/slab_common.c:1007 mm/slab_common.c:1027)
> > kern :warn : [   97.937017] kvasprintf (lib/kasprintf.c:25)
> > kern :warn : [   97.937079] ? bust_spinlocks (lib/kasprintf.c:16)
> > kern :warn : [   97.937146] ? enqueue_hrtimer (kernel/time/hrtimer.c:10=
95 (discriminator 3))
> > kern :warn : [   97.937214] ? tick_nohz_highres_handler (kernel/time/ti=
ck-sched.c:1530)
> > kern :warn : [   97.937295] kasprintf (lib/kasprintf.c:54)
> > kern :warn : [   97.937354] ? kvasprintf_const (lib/kasprintf.c:54)
> > kern :warn : [   97.937426] ? _raw_spin_lock_irqsave (arch/x86/include/=
asm/atomic.h:115 include/linux/atomic/atomic-arch-fallback.h:2164 include/l=
inux/atomic/atomic-instrumented.h:1296 include/asm-generic/qspinlock.h:111 =
include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:111 kernel/lo=
cking/spinlock.c:162)
> > kern :warn : [   97.937501] ? _raw_read_unlock_irqrestore (kernel/locki=
ng/spinlock.c:161)
> > kern :warn : [   97.937581] ? _raw_spin_lock (arch/x86/include/asm/atom=
ic.h:115 include/linux/atomic/atomic-arch-fallback.h:2164 include/linux/ato=
mic/atomic-instrumented.h:1296 include/asm-generic/qspinlock.h:111 include/=
linux/spinlock.h:187 include/linux/spinlock_api_smp.h:134 kernel/locking/sp=
inlock.c:154)
> > kern :warn : [   97.937648] ? _raw_write_lock_irq (kernel/locking/spinl=
ock.c:153)
> > kern :warn : [   97.937719] ? irq_pm_check_wakeup (kernel/irq/pm.c:24)
> > kern :warn : [   97.937793] pm_system_wakeup (drivers/base/power/wakeup=
c:981)
> > kern :warn : [   97.937862] irq_pm_check_wakeup (kernel/irq/pm.c:24)
> > kern :warn : [   97.937933] handle_fasteoi_irq (kernel/irq/chip.c:518 k=
ernel/irq/chip.c:502 kernel/irq/chip.c:698)
> > kern :warn : [   97.938006] __common_interrupt (arch/x86/kernel/irq.c:2=
71 (discriminator 22))
> > kern :warn : [   97.938078] common_interrupt (arch/x86/kernel/irq.c:247=
 (discriminator 14))
> > kern  :warn  : [   97.938145]  </IRQ>
> > kern  :warn  : [   97.938187]  <TASK>
> > kern :warn : [   97.938230] asm_common_interrupt (arch/x86/include/asm/=
idtentry.h:640)
> > kern :warn : [   97.938301] RIP: 0010:cpuidle_enter_s2idle (arch/x86/in=
clude/asm/irqflags.h:78 drivers/cpuidle/cpuidle.c:199)
> > kern :warn : [ 97.938384] Code: d9 75 83 85 d2 7f 11 48 83 c4 20 89 d0 =
5b 5d 41 5c 41 5d 41 5e 41 5f c3 4c 89 c6 48 89 cf 89 14 24 e8 fb 64 9b 00 =
fb 8b 14 24 <eb> db 31 d2 eb d7 48 89 0c 24 48 89 74 24 08 e8 03 51 9f fe 4=
c 8b
> > All code
> > =3D=3D=3D=3D=3D=3D=3D=3D
> >    0: d9 75 83                fnstenv -0x7d(%rbp)
> >    3: 85 d2                   test   %edx,%edx
> >    5: 7f 11                   jg     0x18
> >    7: 48 83 c4 20             add    $0x20,%rsp
> >    b: 89 d0                   mov    %edx,%eax
> >    d: 5b                      pop    %rbx
> >    e: 5d                      pop    %rbp
> >    f: 41 5c                   pop    %r12
> >   11: 41 5d                   pop    %r13
> >   13: 41 5e                   pop    %r14
> >   15: 41 5f                   pop    %r15
> >   17: c3                      retq
> >   18: 4c 89 c6                mov    %r8,%rsi
> >   1b: 48 89 cf                mov    %rcx,%rdi
> >   1e: 89 14 24                mov    %edx,(%rsp)
> >   21: e8 fb 64 9b 00          callq  0x9b6521
> >   26: fb                      sti
> >   27: 8b 14 24                mov    (%rsp),%edx
> >   2a:*        eb db                   jmp    0x7              <-- trapp=
ing instruction
> >   2c: 31 d2                   xor    %edx,%edx
> >   2e: eb d7                   jmp    0x7
> >   30: 48 89 0c 24             mov    %rcx,(%rsp)
> >   34: 48 89 74 24 08          mov    %rsi,0x8(%rsp)
> >   39: e8 03 51 9f fe          callq  0xfffffffffe9f5141
> >   3e: 4c                      rex.WR
> >   3f: 8b                      .byte 0x8b
> >
> > Code starting with the faulting instruction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >    0: eb db                   jmp    0xffffffffffffffdd
> >    2: 31 d2                   xor    %edx,%edx
> >    4: eb d7                   jmp    0xffffffffffffffdd
> >    6: 48 89 0c 24             mov    %rcx,(%rsp)
> >    a: 48 89 74 24 08          mov    %rsi,0x8(%rsp)
> >    f: e8 03 51 9f fe          callq  0xfffffffffe9f5117
> >   14: 4c                      rex.WR
> >   15: 8b                      .byte 0x8b
> > kern  :warn  : [   97.938632] RSP: 0018:ffffc90000177db8 EFLAGS: 000002=
86
> > kern  :warn  : [   97.938717] RAX: 00000000037a402c RBX: 00000000000000=
09 RCX: 0000000000000000
> > kern  :warn  : [   97.938823] RDX: 0000000000000008 RSI: 0000000937e23a=
d2 RDI: 0000000000000000
> > kern  :warn  : [   97.938927] RBP: ffffffff84f7f680 R08: 00000000000000=
00 R09: ffffed1021ad5530
> > kern  :warn  : [   97.939032] R10: ffff88810d6aa987 R11: 00000000000000=
00 R12: ffff88820decca10
> > kern  :warn  : [   97.939137] R13: dffffc0000000000 R14: 000000000027ac=
40 R15: 000000000027ac40
> > kern :warn : [   97.939244] ? cpuidle_enter_s2idle (arch/x86/include/as=
m/irqflags.h:42 arch/x86/include/asm/irqflags.h:77 drivers/cpuidle/cpuidle.=
c:199)
> > kern :warn : [   97.939319] cpuidle_idle_call (kernel/sched/idle.c:190)
> > kern :warn : [   97.939389] ? arch_cpu_idle_exit+0x40/0x40
> > kern :warn : [   97.939459] ? mark_tsc_async_resets (arch/x86/kernel/ts=
c_sync.c:51)
> > kern :warn : [   97.939536] do_idle (kernel/sched/idle.c:282)
> > kern :warn : [   97.939594] cpu_startup_entry (kernel/sched/idle.c:379 =
(discriminator 1))
> > kern :warn : [   97.939662] start_secondary (arch/x86/kernel/smpboot.c:=
224 arch/x86/kernel/smpboot.c:304)
> > kern :warn : [   97.939731] ? set_cpu_sibling_map (arch/x86/kernel/smpb=
oot.c:254)
> > kern :warn : [   97.939808] ? soft_restart_cpu (arch/x86/kernel/head_64=
S:485)
> > kern :warn : [   97.939878] secondary_startup_64_no_verify (arch/x86/ke=
rnel/head_64.S:448)
> > kern  :warn  : [   97.939963]  </TASK>
> > kern :info : [   97.948803] bdw_uncore 0000:00:00.0: PM: calling pci_pm=
_resume_noirq+0x0/0x390 @ 85, parent: 00
> > kern :info : [   97.948993] bdw_uncore 0000:00:00.0: PM: pci_pm_resume_=
noirq+0x0/0x390 returned 0 after 17 usecs
> >
> >
> >
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20240129/202401292109.f115a688-=
oliver.sang@intel.com
> >
> >
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> >
>
> Hi Greg,
>
> This is an example where "pm_system_wakeup" can be called from atomic con=
text. It also gives an actual instance where we can utilise this feature to=
 find the source.
>
> The bug reported due to "GFP_KERNEL" flag, but it will be applicable for =
using "mutex_lock" as well.
> I will change to ATOMIC flag in kmalloc, as well as use raw_spin_lock* in=
stead of mutex_lock.

Maybe instead of trying to add bandaids, you could work on making the
wakeup sources infrastructure suitable for addressing your use case?

