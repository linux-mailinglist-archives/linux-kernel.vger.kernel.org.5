Return-Path: <linux-kernel+bounces-17893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 811338254A4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE89A1F258A5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 13:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95D02D7A5;
	Fri,  5 Jan 2024 13:49:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EA32D78A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 13:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-35ff7c81f4aso11579315ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 05:49:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704462545; x=1705067345;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rnfsj3CC47hV0GWGaKAjQE/gG0n9+oVhOPJMQj/q4Tw=;
        b=ZO4ipVMO6rFBc5cUjfN5F4gYIF0Mn4Ay2PGvwgXo+QaMO8PCfWbfSZkjxANyMHXO2Q
         5werfZgvDDXaWG1qhrkp5/J6aGFMGXTXq5QA2rbocPXvZAhbY9FhqGyMin+AQOxSzIt1
         wj4/+/ggJ3bUPSZldGFe2vVQUKAMd3W0h5GHpCU2AEd+ydmUPZeHuVeBmCe2/Up0TuIr
         AlXkWq2qiX9haEI0ZHxV9sm1rUTZzM4GxyOdvrTKwn2aY3wAIYQfoN6G73YgdaXJTC60
         IESr2OxFmA9s5HQhlC87v5VS/PZTIoM6/VrBqhf3MiqhIv5oiY4bQ0cELAwK9gux2LMF
         iQ/Q==
X-Gm-Message-State: AOJu0YzQxioFqk4+6G31nVH/GDfFQhRGMo1g49KKffB22ZbTP2i1JoI1
	jUYFD9JFxhPO9hvpmixez6wrIQ2SxF1JaZOcEzJ/x4P+ETQV
X-Google-Smtp-Source: AGHT+IHOQcK83Z6Y8YYRyuHxJGZZb4ug022igPZYRdy0erUDWCUwA1o+6ftpXAkVb2oTxf9ltMsHXoXPxOnGy3m7HzsQFJASGFgz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20c7:b0:35f:c723:1f7b with SMTP id
 7-20020a056e0220c700b0035fc7231f7bmr264831ilq.1.1704462545072; Fri, 05 Jan
 2024 05:49:05 -0800 (PST)
Date: Fri, 05 Jan 2024 05:49:05 -0800
In-Reply-To: <tencent_684C75F177D366163C3136DE97A436404A09@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000883cc0060e331cff@google.com>
Subject: Re: [syzbot] [reiserfs?] general protection fault in __fget_files (2)
From: syzbot <syzbot+63cebbb27f598a7f901b@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: trying to register non-static key in psi_account_irqtime

INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 1 PID: 5487 Comm: syz-executor.0 Not tainted 6.7.0-rc7-syzkaller-00016-gf5837722ffec-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 assign_lock_key kernel/locking/lockdep.c:976 [inline]
 register_lock_class+0xc1e/0x1220 kernel/locking/lockdep.c:1289
 __lock_acquire+0x112/0x3b20 kernel/locking/lockdep.c:5014
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1ae/0x520 kernel/locking/lockdep.c:5719
 do_write_seqcount_begin_nested include/linux/seqlock.h:525 [inline]
 do_write_seqcount_begin include/linux/seqlock.h:551 [inline]
 psi_account_irqtime+0x29f/0x510 kernel/sched/psi.c:1016
 update_rq_clock_task kernel/sched/core.c:725 [inline]
 update_rq_clock kernel/sched/core.c:769 [inline]
 update_rq_clock+0x24c/0xb30 kernel/sched/core.c:750
 scheduler_tick+0xee/0x650 kernel/sched/core.c:5648
 update_process_times+0x19f/0x220 kernel/time/timer.c:2076
 tick_sched_handle+0x8e/0x170 kernel/time/tick-sched.c:255
 tick_nohz_highres_handler+0xe9/0x110 kernel/time/tick-sched.c:1516
 __run_hrtimer kernel/time/hrtimer.c:1688 [inline]
 __hrtimer_run_queues+0x647/0xc20 kernel/time/hrtimer.c:1752
 hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1814
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1065 [inline]
 __sysvec_apic_timer_interrupt+0x105/0x400 arch/x86/kernel/apic/apic.c:1082
 sysvec_apic_timer_interrupt+0x90/0xb0 arch/x86/kernel/apic/apic.c:1076
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:memmove+0x28/0x1b0 arch/x86/lib/memmove_64.S:44
Code: c3 90 f3 0f 1e fa 48 89 f8 48 39 fe 7d 0f 49 89 f0 49 01 d0 49 39 f8 0f 8f b5 00 00 00 48 83 fa 20 0f 82 01 01 00 00 48 89 d1 <f3> a4 c3 48 81 fa a8 02 00 00 72 05 40 38 fe 74 47 48 83 ea 20 48
RSP: 0018:ffffc9000382ef40 EFLAGS: 00010286

RAX: ffff8880653d3030 RBX: 0000000000000030 RCX: fffffffffccb761b
RDX: fffffffffffffec9 RSI: ffff88806871c8ae RDI: ffff88806871b8de
RBP: dffffc0000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000008 R11: 00000fe800000001 R12: 0000000000000001
R13: ffffc9000382f120 R14: ffff8880653d30d8 R15: 0000000000000fd0
 leaf_paste_in_buffer+0x26c/0xb80 fs/reiserfs/lbalance.c:1017
 balance_leaf_new_nodes_paste_whole fs/reiserfs/do_balan.c:1171 [inline]
 balance_leaf_new_nodes_paste fs/reiserfs/do_balan.c:1215 [inline]
 balance_leaf_new_nodes fs/reiserfs/do_balan.c:1246 [inline]
 balance_leaf+0x3d2e/0xcda0 fs/reiserfs/do_balan.c:1450
 do_balance+0x337/0x840 fs/reiserfs/do_balan.c:1888
 reiserfs_paste_into_item+0x62b/0x7c0 fs/reiserfs/stree.c:2158
 reiserfs_get_block+0x117f/0x4570 fs/reiserfs/inode.c:1069
 __block_write_begin_int+0x3c0/0x1560 fs/buffer.c:2119
 reiserfs_write_begin+0x350/0x7d0 fs/reiserfs/inode.c:2767
 generic_cont_expand_simple+0x11f/0x200 fs/buffer.c:2473
 reiserfs_setattr+0x36d/0x12a0 fs/reiserfs/inode.c:3298
 notify_change+0x742/0x11c0 fs/attr.c:499
 do_truncate+0x15c/0x220 fs/open.c:66
 do_sys_ftruncate+0x6a2/0x790 fs/open.c:194
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f580747cce9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f580826a0c8 EFLAGS: 00000246
 ORIG_RAX: 000000000000004d
RAX: ffffffffffffffda RBX: 00007f580759bf80 RCX: 00007f580747cce9
RDX: 0000000000000000 RSI: 0000000002007fff RDI: 0000000000000005
RBP: 00007f58074c947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f580759bf80 R15: 00007fffc7bc8578
 </TASK>
----------------
Code disassembly (best guess):
   0:	c3                   	ret
   1:	90                   	nop
   2:	f3 0f 1e fa          	endbr64
   6:	48 89 f8             	mov    %rdi,%rax
   9:	48 39 fe             	cmp    %rdi,%rsi
   c:	7d 0f                	jge    0x1d
   e:	49 89 f0             	mov    %rsi,%r8
  11:	49 01 d0             	add    %rdx,%r8
  14:	49 39 f8             	cmp    %rdi,%r8
  17:	0f 8f b5 00 00 00    	jg     0xd2
  1d:	48 83 fa 20          	cmp    $0x20,%rdx
  21:	0f 82 01 01 00 00    	jb     0x128
  27:	48 89 d1             	mov    %rdx,%rcx
* 2a:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi) <-- trapping instruction
  2c:	c3                   	ret
  2d:	48 81 fa a8 02 00 00 	cmp    $0x2a8,%rdx
  34:	72 05                	jb     0x3b
  36:	40 38 fe             	cmp    %dil,%sil
  39:	74 47                	je     0x82
  3b:	48 83 ea 20          	sub    $0x20,%rdx
  3f:	48                   	rex.W


Tested on:

commit:         f5837722 Merge tag 'mm-hotfixes-stable-2023-12-27-15-0..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=135b91c9e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=da1c95d4e55dda83
dashboard link: https://syzkaller.appspot.com/bug?extid=63cebbb27f598a7f901b
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11972409e80000


