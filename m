Return-Path: <linux-kernel+bounces-32944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A03DE836259
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C50341C26529
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4003A8FE;
	Mon, 22 Jan 2024 11:43:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4D43B18D;
	Mon, 22 Jan 2024 11:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705923794; cv=none; b=SwR0gmMceWTRwfwWfsMu9+M56AkHyOfTfZ2Q+ooorqEZMtb1lWmjHEI7ppkMQkzfSFYm7TRQcB+1eId1EfSaaAQ+Mkop6p33FkMoGWsFDCdHHJW1+8YzDAof5Kq/gQfzpfkKpr5M4X6+30FVw/ZGc0q1JVjkz4uZ7AXmj73j9g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705923794; c=relaxed/simple;
	bh=BR5ImnN5PjytourpJQxDiTP1o+j/gh6mLgn7VT/o2dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+3Sw0mOwRXR33DymEUOV4cHdRPEuiQy4Zhy89tVbgdXdDjq3x/MJE6uTem6ftH+uFDM6IofgKCUhJSz+mcd2sNf59Pgq+zDTtCBAE+hHawb5KiQNHfBFZYmzeanRinAh+A1RyMJf6/OLEB3+YkEdTwlvEeX8HM3VSA1SgyOKQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CECE1FB;
	Mon, 22 Jan 2024 03:43:55 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.47.106])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA3D23F5A1;
	Mon, 22 Jan 2024 03:43:07 -0800 (PST)
Date: Mon, 22 Jan 2024 11:43:04 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: syzbot <syzbot+4ac05c048fbcdd0e3444@syzkaller.appspotmail.com>
Cc: acme@kernel.org, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, irogers@google.com,
	jolsa@kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mingo@redhat.com,
	namhyung@kernel.org, peterz@infradead.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [perf?] WARNING in ctx_sched_in (2)
Message-ID: <Za5UyGdZ0r1T0YT-@FVFF77S0Q05N>
References: <00000000000042993b060f842a0c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000042993b060f842a0c@google.com>

On Sun, Jan 21, 2024 at 11:56:19PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    1b1934dbbdcf Merge tag 'docs-6.8-2' of git://git.lwn.net/l..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1275fc93e80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=68ea41b98043e6e8
> dashboard link: https://syzkaller.appspot.com/bug?extid=4ac05c048fbcdd0e3444
> compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-1b1934db.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/00b728a4f3de/vmlinux-1b1934db.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/5a3fe8452d59/Image-1b1934db.gz.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4ac05c048fbcdd0e3444@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 11671 at kernel/events/core.c:3923 ctx_sched_in+0xb0/0x14c kernel/events/core.c:3936

It looks like that's:

	WARN_ON_ONCE(cpuctx->task_ctx != ctx);

.. for an active context.

That warning could be because cpuctx->task_ctx is a different context (or NULL).

> Modules linked in:
> CPU: 1 PID: 11671 Comm: syz-executor.0 Not tainted 6.7.0-syzkaller-10085-g1b1934dbbdcf #0
> Hardware name: linux,dummy-virt (DT)
> pstate: 004000c9 (nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : ctx_sched_in+0xb0/0x14c kernel/events/core.c:3923
> lr : perf_event_sched_in kernel/events/core.c:2677 [inline]
> lr : perf_event_context_sched_in kernel/events/core.c:3983 [inline]
> lr : __perf_event_task_sched_in+0x11c/0x1d0 kernel/events/core.c:4012
> sp : ffff8000835e3940
> x29: ffff8000835e3940 x28: f2ff00002c4d7570 x27: 000000000000000e
> x26: 0000000000000001 x25: f5ff00004b7fbc78 x24: f5ff00004b7fb600
> x23: f9ff000002eab600 x22: 0000000000000002 x21: 0000000000000007
> x20: faff000014d8c900 x19: ffff00007f9d00b8 x18: ffff800083abbba8
> x17: ffff7ffffd514000 x16: ffff800080008000 x15: 0000000000000001
> x14: 000000000000006e x13: 0000000000000000 x12: ffff8000824dfe70
> x11: 0000000000000001 x10: 68221d39881c888f x9 : 9edf92a6ba7012f5
> x8 : f5ff00004b7fc7a8 x7 : 0000000000000004 x6 : 0000000000000001
> x5 : ffff7ffffd514000 x4 : 0000000000000000 x3 : ffff7ffffd514000
> x2 : f5ff00004b7fb600 x1 : 0000000000000002 x0 : 0000000000000000
> Call trace:
>  ctx_sched_in+0xb0/0x14c kernel/events/core.c:3936
>  perf_event_sched_in kernel/events/core.c:2677 [inline]
>  perf_event_context_sched_in kernel/events/core.c:3983 [inline]
>  __perf_event_task_sched_in+0x11c/0x1d0 kernel/events/core.c:4012
>  perf_event_task_sched_in include/linux/perf_event.h:1484 [inline]
>  finish_task_switch.isra.0+0x104/0x248 kernel/sched/core.c:5269
>  context_switch kernel/sched/core.c:5403 [inline]
>  __schedule+0x328/0x8a8 kernel/sched/core.c:6727
>  preempt_schedule_common kernel/sched/core.c:6904 [inline]
>  preempt_schedule+0x48/0x60 kernel/sched/core.c:6928
>  __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
>  _raw_spin_unlock_irqrestore+0x34/0x44 kernel/locking/spinlock.c:194
>  spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
>  unlock_page_lruvec_irqrestore include/linux/memcontrol.h:1672 [inline]
>  release_pages+0xf4/0x530 mm/swap.c:1039
>  free_pages_and_swap_cache+0x58/0x68 mm/swap_state.c:316
>  tlb_batch_pages_flush+0x54/0x8c mm/mmu_gather.c:98
>  tlb_flush_mmu_free mm/mmu_gather.c:293 [inline]
>  tlb_flush_mmu mm/mmu_gather.c:300 [inline]
>  tlb_finish_mmu+0x74/0x1c0 mm/mmu_gather.c:392
>  exit_mmap+0x144/0x280 mm/mmap.c:3290
>  __mmput+0x3c/0x170 kernel/fork.c:1343
>  mmput+0x50/0x5c kernel/fork.c:1365
>  exit_mm kernel/exit.c:569 [inline]
>  do_exit+0x288/0x960 kernel/exit.c:858
>  __do_sys_exit kernel/exit.c:987 [inline]
>  __se_sys_exit kernel/exit.c:985 [inline]
>  do_group_exit+0x0/0x90 kernel/exit.c:985
>  __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
>  invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:51
>  el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:136
>  do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:155
>  el0_svc+0x34/0xd8 arch/arm64/kernel/entry-common.c:678
>  el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:696
>  el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:595
> ---[ end trace 0000000000000000 ]---
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000028
> Mem abort info:
>   ESR = 0x0000000096000005
>   EC = 0x25: DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
>   FSC = 0x05: level 1 translation fault
> Data abort info:
>   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
>   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> user pgtable: 4k pages, 48-bit VAs, pgdp=0000000054ec7000
> [0000000000000028] pgd=0800000045bd1003, p4d=0800000045bd1003, pud=0000000000000000
> Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 1 PID: 11671 Comm: syz-executor.0 Tainted: G        W          6.7.0-syzkaller-10085-g1b1934dbbdcf #0
> Hardware name: linux,dummy-virt (DT)
> pstate: 004000c9 (nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : perf_ctx_sched_task_cb+0x14/0x80 kernel/events/core.c:3484

It looks like this is within:

	list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry)

That could indicate that ctx->pmu_ctx_list has been corrupted, and if so that
might explain the earlier splat, if we walk from a corrupted entry an interpet
some arbitrary memory as a PMU context.

I'll take a look, but I suspect this'll be painful to pin down.

Mark.

> lr : perf_event_context_sched_in kernel/events/core.c:3985 [inline]
> lr : __perf_event_task_sched_in+0x140/0x1d0 kernel/events/core.c:4012
> sp : ffff8000835e3950
> x29: ffff8000835e3950 x28: f2ff00002c4d7570 x27: 000000000000000e
> x26: 0000000000000001 x25: f5ff00004b7fbc78 x24: f5ff00004b7fb600
> x23: f9ff000002eab600 x22: f5ff00004b7fb600 x21: faff000014d8c900
> x20: 0000000000000000 x19: ffff8000824bc0b8 x18: ffff800083abbba8
> x17: ffff7ffffd514000 x16: ffff800080008000 x15: 0000000000000001
> x14: 000000000000006e x13: 0000000000000000 x12: ffff8000824dfe70
> x11: 0000000000000001 x10: 68221d39881c888f x9 : 9edf92a6ba7012f5
> x8 : f5ff00004b7fc7a8 x7 : 0000000000000004 x6 : 0000000000000001
> x5 : ffff7ffffd514000 x4 : 0000000000000000 x3 : ffff7ffffd514000
> x2 : f5ff00004b7fb600 x1 : 0000000000000001 x0 : 0000000000000000
> Call trace:
>  perf_ctx_sched_task_cb+0x14/0x80 kernel/events/core.c:3484
>  perf_event_context_sched_in kernel/events/core.c:3985 [inline]
>  __perf_event_task_sched_in+0x140/0x1d0 kernel/events/core.c:4012
>  perf_event_task_sched_in include/linux/perf_event.h:1484 [inline]
>  finish_task_switch.isra.0+0x104/0x248 kernel/sched/core.c:5269
>  context_switch kernel/sched/core.c:5403 [inline]
>  __schedule+0x328/0x8a8 kernel/sched/core.c:6727
>  preempt_schedule_common kernel/sched/core.c:6904 [inline]
>  preempt_schedule+0x48/0x60 kernel/sched/core.c:6928
>  __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
>  _raw_spin_unlock_irqrestore+0x34/0x44 kernel/locking/spinlock.c:194
>  spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
>  unlock_page_lruvec_irqrestore include/linux/memcontrol.h:1672 [inline]
>  release_pages+0xf4/0x530 mm/swap.c:1039
>  free_pages_and_swap_cache+0x58/0x68 mm/swap_state.c:316
>  tlb_batch_pages_flush+0x54/0x8c mm/mmu_gather.c:98
>  tlb_flush_mmu_free mm/mmu_gather.c:293 [inline]
>  tlb_flush_mmu mm/mmu_gather.c:300 [inline]
>  tlb_finish_mmu+0x74/0x1c0 mm/mmu_gather.c:392
>  exit_mmap+0x144/0x280 mm/mmap.c:3290
>  __mmput+0x3c/0x170 kernel/fork.c:1343
>  mmput+0x50/0x5c kernel/fork.c:1365
>  exit_mm kernel/exit.c:569 [inline]
>  do_exit+0x288/0x960 kernel/exit.c:858
>  __do_sys_exit kernel/exit.c:987 [inline]
>  __se_sys_exit kernel/exit.c:985 [inline]
>  do_group_exit+0x0/0x90 kernel/exit.c:985
>  __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
>  invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:51
>  el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:136
>  do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:155
>  el0_svc+0x34/0xd8 arch/arm64/kernel/entry-common.c:678
>  el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:696
>  el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:595
> Code: a9bd7bfd 910003fd a90153f3 aa0003f4 (f8428e80) 
> ---[ end trace 0000000000000000 ]---
> ----------------
> Code disassembly (best guess):
>    0:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
>    4:	910003fd 	mov	x29, sp
>    8:	a90153f3 	stp	x19, x20, [sp, #16]
>    c:	aa0003f4 	mov	x20, x0
> * 10:	f8428e80 	ldr	x0, [x20, #40]! <-- trapping instruction
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

