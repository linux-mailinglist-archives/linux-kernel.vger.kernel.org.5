Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24A2782BD2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 16:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235990AbjHUOaa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Aug 2023 10:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235988AbjHUOa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:30:28 -0400
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0462F1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 07:30:20 -0700 (PDT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-68a56401b92so962391b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 07:30:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692628220; x=1693233020;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OL7RZntWi2M6CVAej4Rmm2qt88fQu26I6TT1XoPVdSM=;
        b=bTpvtUpg1poj+0A2JT5oiqlJMfsYA7hBrRlv3w427QiwKVznxBNRiJ5AO4mHhHQG6b
         CKfC61zPlOklqjkAV1fKRB8U9GMpi9uukNzyRrFq6N10I/vo8ulsulsTYvm3lgVDB7IP
         UQzi6+z5KUkeI+q0eZJQUnsYe4FenVO5L2OsIFpaZynQmELYWxNvicJ2Un+7I8sfHvik
         xGIxPJe1DMoh0eSz5iyHj8dq31ExScDpHVspdunI6zAvaPvnW1obEkGLMsGxs+o/Hn5K
         sfHORilmSUfjzrSqdTgpceP6/TMY1nfc5TrIrYxuvMofcgCpLMKTYjozFLetIl0eUg5G
         NYaQ==
X-Gm-Message-State: AOJu0YwfGI2oOCPxOd6VOsvT3OXehu8/62PFK/ifI8wQk3ajQF6xNq3b
        aCdpb9IaCH/ewTePNW0RLounYg7dBwVTR597ufsnD9v1lQFb
X-Google-Smtp-Source: AGHT+IEXZR4fgnps4rTOBnf2rXskoQfPtgQ20MRrDCxdIGBWLwb+nciS6qhwwsf47Gqm8PnLiOlPXea9Dj3MScVPNrB9AfztkTwz
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:2d07:b0:68a:2c24:57d1 with SMTP id
 fa7-20020a056a002d0700b0068a2c2457d1mr3711767pfb.1.1692628220353; Mon, 21 Aug
 2023 07:30:20 -0700 (PDT)
Date:   Mon, 21 Aug 2023 07:30:20 -0700
In-Reply-To: <20230821135047.2538-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cfa60306036fb7a1@google.com>
Subject: Re: [syzbot] [input?] [usb?] [serial?] INFO: rcu detected stall in console_callback
From:   syzbot <syzbot+32af18ae7b894a681f2d@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in do_idle

Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367867 pages reserved
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	1-...!: (196 ticks this GP) idle=ddec/0/0x1 softirq=25731/25733 fqs=7
rcu: 	(detected by 0, t=10537 jiffies, g=20753, q=159 ncpus=2)
Sending NMI from CPU 0 to CPUs 1:
 2812 6735
NMI backtrace for cpu 1
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.5.0-rc7-syzkaller-00004-gf7757129e3de-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:vsnprintf+0x12b/0x1870 lib/vsprintf.c:2769
Code: 6c 14 00 00 44 0f b6 23 31 ff 44 89 e6 e8 2d 9a 13 fb 45 84 e4 48 8b 6c 24 18 48 8d 44 24 50 48 89 44 24 08 0f 84 53 14 00 00 <e8> e0 9e 13 fb 48 8b 74 24 08 48 89 df e8 e3 f3 fe ff 48 c7 c6 20
RSP: 0018:ffffc90000187ff8 EFLAGS: 00000002
RAX: 0000000000000000 RBX: ffffffff8688734b RCX: ffffffff8638af33
RDX: ffff888103a68000 RSI: 0000000000000100 RDI: 0000000000000001
RBP: ffffc900001882bd R08: 0000000000000001 R09: 0000000000000000
R10: 000000000000005d R11: 000000000011f9f0 R12: ffffffff8688734b
R13: 000000000000005d R14: ffffc900001880e0 R15: 0000000000000009
FS:  0000000000000000(0000) GS:ffff8881f6700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056004a2ce148 CR3: 000000011691d000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 sprintf+0xcd/0x100 lib/vsprintf.c:3021
 print_time kernel/printk/printk.c:1327 [inline]
 info_print_prefix+0x258/0x350 kernel/printk/printk.c:1353
 record_print_text+0x143/0x410 kernel/printk/printk.c:1402
 printk_get_next_message+0x2ca/0x7c0 kernel/printk/printk.c:2809
 console_emit_next_record kernel/printk/printk.c:2844 [inline]
 console_flush_all+0x39e/0xf50 kernel/printk/printk.c:2933
 console_unlock+0xc6/0x1f0 kernel/printk/printk.c:3007
 vprintk_emit+0x1c5/0x640 kernel/printk/printk.c:2307
 vprintk+0x89/0xa0 kernel/printk/printk_safe.c:50
 _printk+0xc8/0x100 kernel/printk/printk.c:2328
 __show_free_areas+0x1239/0x2140 mm/show_mem.c:352
 __show_mem+0x34/0x140 mm/show_mem.c:409
 k_spec drivers/tty/vt/keyboard.c:667 [inline]
 k_spec+0xea/0x140 drivers/tty/vt/keyboard.c:656
 kbd_keycode drivers/tty/vt/keyboard.c:1524 [inline]
 kbd_event+0xcc8/0x17c0 drivers/tty/vt/keyboard.c:1543
 input_to_handler+0x382/0x4c0 drivers/input/input.c:132
 input_pass_values.part.0+0x542/0x7b0 drivers/input/input.c:163
 input_pass_values drivers/input/input.c:148 [inline]
 input_event_dispose+0x5ee/0x770 drivers/input/input.c:380
 input_handle_event+0x11c/0xd80 drivers/input/input.c:408
 input_repeat_key+0x251/0x340 drivers/input/input.c:2265
 call_timer_fn+0x1a0/0x580 kernel/time/timer.c:1700
 expire_timers kernel/time/timer.c:1751 [inline]
 __run_timers+0x764/0xb10 kernel/time/timer.c:2022
 run_timer_softirq+0x58/0xd0 kernel/time/timer.c:2035
 __do_softirq+0x20b/0x94e kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu kernel/softirq.c:632 [inline]
 irq_exit_rcu+0xa7/0x110 kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x8e/0xb0 arch/x86/kernel/apic/apic.c:1109
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:native_irq_disable arch/x86/include/asm/irqflags.h:37 [inline]
RIP: 0010:arch_local_irq_disable arch/x86/include/asm/irqflags.h:72 [inline]
RIP: 0010:acpi_safe_halt+0x1b/0x20 drivers/acpi/processor_idle.c:113
Code: ed c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 65 48 8b 04 25 c0 a7 03 00 48 8b 00 a8 08 75 0c 66 90 0f 00 2d 97 17 6f 00 fb f4 <fa> c3 0f 1f 00 0f b6 47 08 3c 01 74 0b 3c 02 74 05 8b 7f 04 eb 9f
RSP: 0018:ffffc9000011fd60 EFLAGS: 00000246
RAX: 0000000000004000 RBX: 0000000000000001 RCX: ffffffff863f3a2e
RDX: 0000000000000001 RSI: ffff888101e75800 RDI: ffff888101e75864
RBP: ffff888101e75864 R08: 0000000000000001 R09: ffffed103ece6d4d
R10: ffff8881f6736a6b R11: 0000000000000000 R12: ffff88810e645000
R13: ffffffff882efc00 R14: 0000000000000001 R15: 0000000000000000
 acpi_idle_enter+0xc5/0x160 drivers/acpi/processor_idle.c:707
 cpuidle_enter_state+0x82/0x500 drivers/cpuidle/cpuidle.c:267
 cpuidle_enter+0x4e/0xa0 drivers/cpuidle/cpuidle.c:388
 cpuidle_idle_call kernel/sched/idle.c:215 [inline]
 do_idle+0x315/0x3f0 kernel/sched/idle.c:282
 cpu_startup_entry+0x18/0x20 kernel/sched/idle.c:379
 start_secondary+0x200/0x290 arch/x86/kernel/smpboot.c:326
 secondary_startup_64_no_verify+0x167/0x16b
 </TASK>
rcu: rcu_preempt kthread starved for 10523 jiffies! g20753 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
 6735
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
Node 0 DMA32 free:2879700kB boost:0kB min:4380kB low:7256kB high:10132kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2883248kB mlocked:0kB bounce:0kB free_pcp:3548kB local_pcp:3484kB free_cma:0kB
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R
lowmem_reserve[]: 0
  running task     stack:29136 pid:15    ppid:2      flags:0x00004000
 0
Call Trace:
 <TASK>
 3923 3923
 context_switch kernel/sched/core.c:5381 [inline]
 __schedule+0xc79/0x30a0 kernel/sched/core.c:6710

Node 0 Normal free:3239664kB boost:0kB min:6112kB low:10128kB high:14144kB reserved_highatomic:0KB active_anon:424kB inactive_anon:36332kB active_file:33712kB inactive_file:173652kB unevictable:0kB writepending:16kB present:5242880kB managed:4018128kB mlocked:0kB bounce:0kB free_pcp:6892kB local_pcp:4856kB free_cma:0kB
lowmem_reserve[]: 0
 0 0
 schedule+0xe7/0x1b0 kernel/sched/core.c:6786
 0
 schedule_timeout+0x157/0x2c0 kernel/time/timer.c:2167

Node 0 
DMA: 0*4kB 
0*8kB 
0*16kB 
0*32kB 
 rcu_gp_fqs_loop+0x1ec/0xa50 kernel/rcu/tree.c:1609
0*64kB 
0*128kB 
0*256kB 
 rcu_gp_kthread+0x249/0x380 kernel/rcu/tree.c:1808
0*512kB 
1*1024kB 
(U) 1*2048kB 
(M) 3*4096kB 
 kthread+0x33a/0x430 kernel/kthread.c:389
(M) = 15360kB
Node 0 
 ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
DMA32: 3*4kB 
(M) 1*8kB 
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
(M) 2*16kB 
 </TASK>
(M) 3*32kB 
rcu: Stack dump where RCU GP kthread last ran:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.5.0-rc7-syzkaller-00004-gf7757129e3de-dirty #0
(M) 3*64kB 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
(M) 3*128kB 
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x31/0x70 kernel/locking/spinlock.c:194
(M) 2*256kB 
Code: f5 53 48 8b 74 24 10 48 89 fb 48 83 c7 18 e8 c6 31 ec fa 48 89 df e8 9e b0 ec fa f7 c5 00 02 00 00 75 1f 9c 58 f6 c4 02 75 2f <bf> 01 00 00 00 e8 15 37 e1 fa 65 8b 05 26 47 c2 79 85 c0 74 12 5b
(M) 2*512kB 
RSP: 0018:ffffc90000007c90 EFLAGS: 00000246
(M) 2*1024kB 

RAX: 0000000000000006 RBX: ffff88812c3b7218 RCX: 1ffffffff16f79d6
(M) 2*2048kB 
RDX: 0000000000000000 RSI: ffffffff8687a2c0 RDI: ffffffff86a59c00
(M) 701*4096kB 
RBP: 0000000000000246 R08: 0000000000000001 R09: fffffbfff16eed4d
(M) = 2879700kB
R10: ffffffff8b776a6f R11: 00000000000257e0 R12: ffff88812c3b7110
Node 0 
R13: 1ffff92000000f96 R14: ffffffff84583670 R15: 0000000000000001
Normal: 170*4kB 
FS:  0000000000000000(0000) GS:ffff8881f6600000(0000) knlGS:0000000000000000
(UME) 1513*8kB 
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
(UME) 358*16kB 
CR2: 00007f70d89c1497 CR3: 000000012d6b6000 CR4: 00000000003506f0
(UM) 1*32kB 
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
(E) 4*64kB 
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
(UME) 3*128kB 
Call Trace:
 <IRQ>
(UME) 2*256kB 
(UM) 1*512kB 
(U) 2*1024kB 
(UM) 3*2048kB 
(UME) 
784*4096kB 
(M) = 3239664kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
52019 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367867 pages reserved
Mem-Info:
active_anon:106 inactive_anon:9083 isolated_anon:0
 active_file:8428 inactive_file:43413 isolated_file:0
 unevictable:0 dirty:4 writeback:0
 slab_reclaimable:9358 slab_unreclaimable:65661
 mapped:7047 shmem:178 pagetables:470
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1533681 free_pcp:2610 free_cma:0
Node 0 active_anon:424kB inactive_anon:36332kB active_file:33712kB inactive_file:173652kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:28188kB dirty:16kB writeback:0kB shmem:712kB writeback_tmp:0kB kernel_stack:4476kB pagetables:1880kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0
 2812 6735
 6735

Node 0 
DMA32 free:2879700kB boost:0kB min:4380kB low:7256kB high:10132kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2883248kB mlocked:0kB bounce:0kB free_pcp:3548kB local_pcp:3484kB free_cma:0kB
 call_timer_fn+0x1a0/0x580 kernel/time/timer.c:1700
lowmem_reserve[]: 0
 0 3923
 3923

Node 0 
 expire_timers kernel/time/timer.c:1751 [inline]
 __run_timers+0x764/0xb10 kernel/time/timer.c:2022
Normal free:3239664kB boost:0kB min:6112kB low:10128kB high:14144kB reserved_highatomic:0KB active_anon:424kB inactive_anon:36332kB active_file:33712kB inactive_file:173652kB unevictable:0kB writepending:16kB present:5242880kB managed:4018128kB mlocked:0kB bounce:0kB free_pcp:6892kB local_pcp:4856kB free_cma:0kB
lowmem_reserve[]: 0
 0 0
 0
Node 0 
 run_timer_softirq+0x58/0xd0 kernel/time/timer.c:2035
DMA: 0*4kB 
 __do_softirq+0x20b/0x94e kernel/softirq.c:553
0*8kB 
0*16kB 
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu kernel/softirq.c:632 [inline]
 irq_exit_rcu+0xa7/0x110 kernel/softirq.c:644
0*32kB 
 sysvec_apic_timer_interrupt+0x8e/0xb0 arch/x86/kernel/apic/apic.c:1109
0*64kB 
 </IRQ>
0*128kB 
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
0*256kB 
RIP: 0010:native_irq_disable arch/x86/include/asm/irqflags.h:37 [inline]
RIP: 0010:arch_local_irq_disable arch/x86/include/asm/irqflags.h:72 [inline]
RIP: 0010:acpi_safe_halt+0x1b/0x20 drivers/acpi/processor_idle.c:113
0*512kB 
Code: ed c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 65 48 8b 04 25 c0 a7 03 00 48 8b 00 a8 08 75 0c 66 90 0f 00 2d 97 17 6f 00 fb f4 <fa> c3 0f 1f 00 0f b6 47 08 3c 01 74 0b 3c 02 74 05 8b 7f 04 eb 9f
1*1024kB 
RSP: 0018:ffffffff87c07d70 EFLAGS: 00000246
(U) 1*2048kB 

RAX: 0000000000004000 RBX: 0000000000000001 RCX: ffffffff863f3a2e
(M) 3*4096kB 
RDX: 0000000000000001 RSI: ffff888101e75000 RDI: ffff888101e75064
(M) 
RBP: ffff888101e75064 R08: 0000000000000001 R09: ffffed103ecc6d4d
= 15360kB
R10: ffff8881f6636a6b R11: 0000000000000000 R12: ffff88810e644800
Node 0 DMA32: 
R13: ffffffff882efc00 R14: 0000000000000000 R15: 0000000000000000
3*4kB 
(M) 1*8kB 
 acpi_idle_enter+0xc5/0x160 drivers/acpi/processor_idle.c:707
(M) 2*16kB 
 cpuidle_enter_state+0x82/0x500 drivers/cpuidle/cpuidle.c:267
(M) 3*32kB 
(M) 3*64kB 
 cpuidle_enter+0x4e/0xa0 drivers/cpuidle/cpuidle.c:388
(M) 3*128kB 
 cpuidle_idle_call kernel/sched/idle.c:215 [inline]
 do_idle+0x315/0x3f0 kernel/sched/idle.c:282
(M) 2*256kB 
(M) 2*512kB 
 cpu_startup_entry+0x18/0x20 kernel/sched/idle.c:379
(M) 2*1024kB 
 rest_init+0x16f/0x2b0 init/main.c:726
(M) 2*2048kB 
(M) 701*4096kB 
(M) = 2879700kB
 arch_call_rest_init+0x13/0x30 init/main.c:823
Node 0 
 start_kernel+0x39a/0x470 init/main.c:1068
Normal: 170*4kB 
 x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:556
(UME) 1513*8kB 
 x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:537
(UME) 358*16kB 
 secondary_startup_64_no_verify+0x167/0x16b
(UM) 1*32kB 
 </TASK>
(E) 4*64kB (UME) 3*128kB (UME) 2*256kB (UM) 1*512kB (U) 2*1024kB (UM) 3*2048kB (UME) 784*4096kB (M) = 3239664kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
52019 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367867 pages reserved
Mem-Info:
active_anon:106 inactive_anon:9083 isolated_anon:0
 active_file:8428 inactive_file:43413 isolated_file:0
 unevictable:0 dirty:4 writeback:0
 slab_reclaimable:9358 slab_unreclaimable:65661
 mapped:7047 shmem:178 pagetables:470
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1533681 free_pcp:2610 free_cma:0
Node 0 active_anon:424kB inactive_anon:36332kB active_file:33712kB inactive_file:173652kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:28188kB dirty:16kB writeback:0kB shmem:712kB writeback_tmp:0kB kernel_stack:4476kB pagetables:1880kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2812 6735 6735
Node 0 DMA32 free:2879700kB boost:0kB min:4380kB low:7256kB high:10132kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2883248kB mlocked:0kB bounce:0kB free_pcp:3548kB local_pcp:64kB free_cma:0kB
lowmem_reserve[]: 0 0 3923 3923
Node 0 Normal free:3239664kB boost:0kB min:6112kB low:10128kB high:14144kB reserved_highatomic:0KB active_anon:424kB inactive_anon:36332kB active_file:33712kB inactive_file:173652kB unevictable:0kB writepending:16kB present:5242880kB managed:4018128kB mlocked:0kB bounce:0kB free_pcp:6892kB local_pcp:2036kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 3*4kB (M) 1*8kB (M) 2*16kB (M) 3*32kB (M) 3*64kB (M) 3*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 2*2048kB (M) 701*4096kB (M) = 2879700kB
Node 0 Normal: 170*4kB (UME) 1513*8kB (UME) 358*16kB (UM) 1*32kB (E) 4*64kB (UME) 3*128kB (UME) 2*256kB (UM) 1*512kB (U) 2*1024kB (UM) 3*2048kB (UME) 784*4096kB (M) = 3239664kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
52019 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367867 pages reserved
Mem-Info:
active_anon:106 inactive_anon:9083 isolated_anon:0
 active_file:8428 inactive_file:43413 isolated_file:0
 unevictable:0 dirty:4 writeback:0
 slab_reclaimable:9358 slab_unreclaimable:65661
 mapped:7047 shmem:178 pagetables:470
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1533681 free_pcp:2610 free_cma:0
Node 0 active_anon:424kB inactive_anon:36332kB active_file:33712kB inactive_file:173652kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:28188kB dirty:16kB writeback:0kB shmem:712kB writeback_tmp:0kB kernel_stack:4476kB pagetables:1880kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2812 6735 6735
Node 0 DMA32 free:2879700kB boost:0kB min:4380kB low:7256kB high:10132kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2883248kB mlocked:0kB bounce:0kB free_pcp:3548kB local_pcp:3484kB free_cma:0kB
lowmem_reserve[]: 0 0 3923 3923
Node 0 Normal free:3239664kB boost:0kB min:6112kB low:10128kB high:14144kB reserved_highatomic:0KB active_anon:424kB inactive_anon:36332kB active_file:33712kB inactive_file:173652kB unevictable:0kB writepending:16kB present:5242880kB managed:4018128kB mlocked:0kB bounce:0kB free_pcp:6892kB local_pcp:4856kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 3*4kB (M) 1*8kB (M) 2*16kB (M) 3*32kB (M) 3*64kB (M) 3*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 2*2048kB (M) 701*4096kB (M) = 2879700kB
Node 0 Normal: 170*4kB (UME) 1513*8kB (UME) 358*16kB (UM) 1*32kB (E) 4*64kB (UME) 3*128kB (UME) 2*256kB (UM) 1*512kB (U) 2*1024kB (UM) 3*2048kB (UME) 784*4096kB (M) = 3239664kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
52019 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367867 pages reserved
Mem-Info:
active_anon:106 inactive_anon:9083 isolated_anon:0
 active_file:8428 inactive_file:43413 isolated_file:0
 unevictable:0 dirty:4 writeback:0
 slab_reclaimable:9358 slab_unreclaimable:65661
 mapped:7047 shmem:178 pagetables:470
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1533681 free_pcp:2610 free_cma:0
Node 0 active_anon:424kB inactive_anon:36332kB active_file:33712kB inactive_file:173652kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:28188kB dirty:16kB writeback:0kB shmem:712kB writeback_tmp:0kB kernel_stack:4476kB pagetables:1880kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2812 6735 6735
Node 0 DMA32 free:2879700kB boost:0kB min:4380kB low:7256kB high:10132kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2883248kB mlocked:0kB bounce:0kB free_pcp:3548kB local_pcp:64kB free_cma:0kB
lowmem_reserve[]: 0 0 3923 3923
Node 0 Normal free:3239664kB boost:0kB min:6112kB low:10128kB high:14144kB reserved_highatomic:0KB active_anon:424kB inactive_anon:36332kB active_file:33712kB inactive_file:173652kB unevictable:0kB writepending:16kB present:5242880kB managed:4018128kB mlocked:0kB bounce:0kB free_pcp:6892kB local_pcp:2036kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 3*4kB (M) 1*8kB (M) 2*16kB (M) 3*32kB (M) 3*64kB (M) 3*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 2*2048kB (M) 701*4096kB (M) = 2879700kB
Node 0 Normal: 170*4kB (UME) 1513*8kB (UME) 358*16kB (UM) 1*32kB (E) 4*64kB (UME) 3*128kB (UME) 2*256kB (UM) 1*512kB (U) 2*1024kB (UM) 3*2048kB (UME) 784*4096kB (M) = 3239664kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
52019 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367867 pages reserved
Mem-Info:
active_anon:106 inactive_anon:9083 isolated_anon:0
 active_file:8428 inactive_file:43413 isolated_file:0
 unevictable:0 dirty:4 writeback:0
 slab_reclaimable:9358 slab_unreclaimable:65661
 mapped:7047 shmem:178 pagetables:470
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1533681 free_pcp:2610 free_cma:0
Node 0 active_anon:424kB inactive_anon:36332kB active_file:33712kB inactive_file:173652kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:28188kB dirty:16kB writeback:0kB shmem:712kB writeback_tmp:0kB kernel_stack:4476kB pagetables:1880kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2812 6735 6735
Node 0 DMA32 free:2879700kB boost:0kB min:4380kB low:7256kB high:10132kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2883248kB mlocked:0kB bounce:0kB free_pcp:3548kB local_pcp:3484kB free_cma:0kB
lowmem_reserve[]: 0 0 3923 3923
Node 0 Normal free:3239664kB boost:0kB min:6112kB low:10128kB high:14144kB reserved_highatomic:0KB active_anon:424kB inactive_anon:36332kB active_file:33712kB inactive_file:173652kB unevictable:0kB writepending:16kB present:5242880kB managed:4018128kB mlocked:0kB bounce:0kB free_pcp:6892kB local_pcp:4856kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 3*4kB (M) 1*8kB (M) 2*16kB (M) 3*32kB (M) 3*64kB (M) 3*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 2*2048kB (M) 701*4096kB (M) = 2879700kB
Node 0 Normal: 170*4kB (UME) 1513*8kB (UME) 358*16kB (UM) 1*32kB (E) 4*64kB (UME) 3*128kB (UME) 2*256kB (UM) 1*512kB (U) 2*1024kB (UM) 3*2048kB (UME) 784*4096kB (M) = 3239664kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
52019 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367867 pages reserved
Mem-Info:
active_anon:106 inactive_anon:9083 isolated_anon:0
 active_file:8428 inactive_file:43413 isolated_file:0
 unevictable:0 dirty:4 writeback:0
 slab_reclaimable:9358 slab_unreclaimable:65661
 mapped:7047 shmem:178 pagetables:470
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1533681 free_pcp:2610 free_cma:0
Node 0 active_anon:424kB inactive_anon:36332kB active_file:33712kB inactive_file:173652kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:28188kB dirty:16kB writeback:0kB shmem:712kB writeback_tmp:0kB kernel_stack:4476kB pagetables:1880kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2812 6735 6735
Node 0 DMA32 free:2879700kB boost:0kB min:4380kB low:7256kB high:10132kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2883248kB mlocked:0kB bounce:0kB free_pcp:3548kB local_pcp:64kB free_cma:0kB
lowmem_reserve[]: 0 0 3923 3923
Node 0 Normal free:3239664kB boost:0kB min:6112kB low:10128kB high:14144kB reserved_highatomic:0KB active_anon:424kB inactive_anon:36332kB active_file:33712kB inactive_file:173652kB unevictable:0kB writepending:16kB present:5242880kB managed:4018128kB mlocked:0kB bounce:0kB free_pcp:6892kB local_pcp:2036kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 3*4kB (M) 1*8kB (M) 2*16kB (M) 3*32kB (M) 3*64kB (M) 3*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 2*2048kB (M) 701*4096kB (M) = 2879700kB
Node 0 Normal: 170*4kB (UME) 1513*8kB (UME) 358*16kB (UM) 1*32kB (E) 4*64kB (UME) 3*128kB (UME) 2*256kB (UM) 1*512kB (U) 2*1024kB (UM) 3*2048kB (UME) 784*4096kB (M) = 3239664kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
52019 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367867 pages reserved
Mem-Info:
active_anon:106 inactive_anon:9083 isolated_anon:0
 active_file:8428 inactive_file:43413 isolated_file:0
 unevictable:0 dirty:4 writeback:0
 slab_reclaimable:9358 slab_unreclaimable:65661
 mapped:7047 shmem:178 pagetables:470
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1533681 free_pcp:2610 free_cma:0
Node 0 active_anon:424kB inactive_anon:36332kB active_file:33712kB inactive_file:173652kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:28188kB dirty:16kB writeback:0kB shmem:712kB writeback_tmp:0kB kernel_stack:4476kB pagetables:1880kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2812 6735 6735
Node 0 DMA32 free:2879700kB boost:0kB min:4380kB low:7256kB high:10132kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2883248kB mlocked:0kB bounce:0kB free_pcp:3548kB local_pcp:3484kB free_cma:0kB
lowmem_reserve[]: 0 0 3923 3923
Node 0 Normal free:3239664kB boost:0kB min:6112kB low:10128kB high:14144kB reserved_highatomic:0KB active_anon:424kB inactive_anon:36332kB active_file:33712kB inactive_file:173652kB unevictable:0kB writepending:16kB present:5242880kB managed:4018128kB mlocked:0kB bounce:0kB free_pcp:6892kB local_pcp:4856kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 3*4kB (M) 1*8kB (M) 2*16kB (M) 3*32kB (M) 3*64kB (M) 3*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 2*2048kB (M) 701*4096kB (M) = 2879700kB
Node 0 Normal: 170*4kB (UME) 1513*8kB (UME) 358*16kB (UM) 1*32kB (E) 4*64kB (UME) 3*128kB (UME) 2*256kB (UM) 1*512kB (U) 2*1024kB (UM) 3*2048kB (UME) 784*4096kB (M) = 3239664kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
52019 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367867 pages reserved
Mem-Info:
active_anon:106 inactive_anon:9083 isolated_anon:0
 active_file:8428 inactive_file:43413 isolated_file:0
 unevictable:0 dirty:4 writeback:0
 slab_reclaimable:9358 slab_unreclaimable:65661
 mapped:7047 shmem:178 pagetables:470
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1533681 free_pcp:2610 free_cma:0
Node 0 active_anon:424kB inactive_anon:36332kB active_file:33712kB inactive_file:173652kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:28188kB dirty:16kB writeback:0kB shmem:712kB writeback_tmp:0kB kernel_stack:4476kB pagetables:1880kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2812 6735 6735
Node 0 DMA32 free:2879700kB boost:0kB min:4380kB low:7256kB high:10132kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2883248kB mlocked:0kB bounce:0kB free_pcp:3548kB local_pcp:64kB free_cma:0kB
lowmem_reserve[]: 0 0 3923 3923
Node 0 Normal free:3239664kB boost:0kB min:6112kB low:10128kB high:14144kB reserved_highatomic:0KB active_anon:424kB inactive_anon:36332kB active_file:33712kB inactive_file:173652kB unevictable:0kB writepending:16kB present:5242880kB managed:4018128kB mlocked:0kB bounce:0kB free_pcp:6892kB local_pcp:2036kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 3*4kB (M) 1*8kB (M) 2*16kB (M) 3*32kB (M) 3*64kB (M) 3*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 2*2048kB (M) 701*4096kB (M) = 2879700kB
Node 0 Normal: 170*4kB (UME) 1513*8kB (UME) 358*16kB (UM) 1*32kB (E) 4*64kB (UME) 3*128kB (UME) 2*256kB (UM) 1*512kB (U) 2*1024kB (UM) 3*2048kB (UME) 784*4096kB (M) = 3239664kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
52019 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367867 pages reserved
Mem-Info:
active_anon:106 inactive_anon:9083 isolated_anon:0
 active_file:8428 inactive_file:43413 isolated_file:0
 unevictable:0 dirty:4 writeback:0
 slab_reclaimable:9358 slab_unreclaimable:65661
 mapped:7047 shmem:178 pagetables:470
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1533681 free_pcp:2610 free_cma:0
Node 0 active_anon:424kB inactive_anon:36332kB active_file:33712kB inactive_file:173652kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:28188kB dirty:16kB writeback:0kB shmem:712kB writeback_tmp:0kB kernel_stack:4476kB pagetables:1880kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2812 6735 6735
Node 0 DMA32 free:2879700kB boost:0kB min:4380kB low:7256kB high:10132kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2883248kB mlocked:0kB bounce:0kB free_pcp:3548kB local_pcp:3484kB free_cma:0kB
lowmem_reserve[]: 0 0 3923 3923
Node 0 Normal free:3239664kB boost:0kB min:6112kB low:10128kB high:14144kB reserved_highatomic:0KB active_anon:424kB inactive_anon:36332kB active_file:33712kB inactive_file:173652kB unevictable:0kB writepending:16kB present:5242880kB managed:4018128kB mlocked:0kB bounce:0kB free_pcp:6892kB local_pcp:4856kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 3*4kB (M) 1*8kB (M) 2*16kB (M) 3*32kB (M) 3*64kB (M) 3*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 2*2048kB (M) 701*4096kB (M) = 2879700kB
Node 0 Normal: 170*4kB (UME) 1513*8kB (UME) 358*16kB (UM) 1*32kB (E) 4*64kB (UME) 3*128kB (UME) 2*256kB (UM) 1*512kB (U) 2*1024kB (UM) 3*2048kB (UME) 784*4096kB (M) = 3239664kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
52019 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367867 pages reserved
Mem-Info:
active_anon:106 inactive_anon:9083 isolated_anon:0
 active_file:8428 inactive_file:43413 isolated_file:0
 unevictable:0 dirty:4 writeback:0
 slab_reclaimable:9358 slab_unreclaimable:65661
 mapped:7047 shmem:178 pagetables:470
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1533681 free_pcp:2610 free_cma:0
Node 0 active_anon:424kB inactive_anon:36332kB active_file:33712kB inactive_file:173652kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:28188kB dirty:16kB writeback:0kB shmem:712kB writeback_tmp:0kB kernel_stack:4476kB pagetables:1880kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2812 6735 6735
Node 0 DMA32 free:2879700kB boost:0kB min:4380kB low:7256kB high:10132kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2883248kB mlocked:0kB bounce:0kB free_pcp:3548kB local_pcp:64kB free_cma:0kB
lowmem_reserve[]: 0 0 3923 3923
Node 0 Normal free:3239664kB boost:0kB min:6112kB low:10128kB high:14144kB reserved_highatomic:0KB active_anon:424kB inactive_anon:36332kB active_file:33712kB inactive_file:173652kB unevictable:0kB writepending:16kB present:5242880kB managed:4018128kB mlocked:0kB bounce:0kB free_pcp:6892kB local_pcp:2036kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 3*4kB (M) 1*8kB (M) 2*16kB (M) 3*32kB (M) 3*64kB (M) 3*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 2*2048kB (M) 701*4096kB (M) = 2879700kB
Node 0 Normal: 170*4kB (UME) 1513*8kB (UME) 358*16kB (UM) 1*32kB (E) 4*64kB (UME) 3*128kB (UME) 2*256kB (UM) 1*512kB (U) 2*1024kB (UM) 3*2048kB (UME) 784*4096kB (M) = 3239664kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
52019 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367867 pages reserved
Mem-Info:
active_anon:106 inactive_anon:9083 isolated_anon:0
 active_file:8428 inactive_file:43413 isolated_file:0
 unevictable:0 dirty:4 writeback:0
 slab_reclaimable:9358 slab_unreclaimable:65661
 mapped:7047 shmem:178 pagetables:470
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1533681 free_pcp:2610 free_cma:0
Node 0 active_anon:424kB inactive_anon:36332kB active_file:33712kB inactive_file:173652kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:28188kB dirty:16kB writeback:0kB shmem:712kB writeback_tmp:0kB kernel_stack:4476kB pagetables:1880kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2812 6735 6735
Node 0 DMA32 free:2879700kB boost:0kB min:4380kB low:7256kB high:10132kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2883248kB mlocked:0kB bounce:0kB free_pcp:3548kB local_pcp:3484kB free_cma:0kB
lowmem_reserve[]: 0 0 3923 3923
Node 0 Normal free:3239664kB boost:0kB min:6112kB low:10128kB high:14144kB reserved_highatomic:0KB active_anon:424kB inactive_anon:36332kB active_file:33712kB inactive_file:173652kB unevictable:0kB writepending:16kB present:5242880kB managed:4018128kB mlocked:0kB bounce:0kB free_pcp:6892kB local_pcp:4856kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 3*4kB (M) 1*8kB (M) 2*16kB (M) 3*32kB (M) 3*64kB (M) 3*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 2*2048kB (M) 701*4096kB (M) = 2879700kB
Node 0 Normal: 170*4kB (UME) 1513*8kB (UME) 358*16kB (UM) 1*32kB (E) 4*64kB (UME) 3*128kB (UME) 2*256kB (UM) 1*512kB (U) 2*1024kB (UM) 3*2048kB (UME) 784*4096kB (M) = 3239664kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
52019 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367867 pages reserved
Mem-Info:
active_anon:106 inactive_anon:9083 isolated_anon:0
 active_file:8428 inactive_file:43413 isolated_file:0
 unevictable:0 dirty:4 writeback:0
 slab_reclaimable:9358 slab_unreclaimable:65661
 mapped:7047 shmem:178 pagetables:470
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1533681 free_pcp:2610 free_cma:0
Node 0 active_anon:424kB inactive_anon:36332kB active_file:33712kB inactive_file:173652kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:28188kB dirty:16kB writeback:0kB shmem:712kB writeback_tmp:0kB kernel_stack:4476kB pagetables:1880kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2812 6735 6735
Node 0 DMA32 free:2879700kB boost:0kB min:4380kB low:7256kB high:10132kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2883248kB mlocked:0kB bounce:0kB free_pcp:3548kB local_pcp:64kB free_cma:0kB
lowmem_reserve[]: 0 0 3923 3923
Node 0 Normal free:3239664kB boost:0kB min:6112kB low:10128kB high:14144kB reserved_highatomic:0KB active_anon:424kB inactive_anon:36332kB active_file:33712kB inactive_file:173652kB unevictable:0kB writepending:16kB present:5242880kB managed:4018128kB mlocked:0kB bounce:0kB free_pcp:6892kB local_pcp:2036kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 3*4kB (M) 1*8kB (M) 2*16kB (M) 3*32kB (M) 3*64kB (M) 3*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 2*2048kB (M) 701*4096kB (M) = 2879700kB
Node 0 Normal: 170*4kB (UME) 1513*8kB (UME) 358*16kB (UM) 1*32kB (E) 4*64kB (UME) 3*128kB (UME) 2*256kB (UM) 1*512kB (U) 2*1024kB (UM) 3*2048kB (UME) 784*4096kB (M) = 3239664kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
52019 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367867 pages reserved
Mem-Info:
active_anon:106 inactive_anon:9083 isolated_anon:0
 active_file:8428 inactive_file:43413 isolated_file:0
 unevictable:0 dirty:4 writeback:0
 slab_reclaimable:9358 slab_unreclaimable:65661
 mapped:7047 shmem:178 pagetables:470
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1533681 free_pcp:2610 free_cma:0
Node 0 active_anon:424kB inactive_anon:36332kB active_file:33712kB inactive_file:173652kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:28188kB dirty:16kB writeback:0kB shmem:712kB writeback_tmp:0kB kernel_stack:4476kB pagetables:1880kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2812 6735 6735
Node 0 DMA32 free:2879700kB boost:0kB min:4380kB low:7256kB high:10132kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2883248kB mlocked:0kB bounce:0kB free_pcp:3548kB local_pcp:3484kB free_cma:0kB
lowmem_reserve[]: 0 0 3923 3923
Node 0 Normal free:3239664kB boost:0kB min:6112kB low:10128kB high:14144kB reserved_highatomic:0KB active_anon:424kB inactive_anon:36332kB active_file:33712kB inactive_file:173652kB unevictable:0kB writepending:16kB present:5242880kB managed:4018128kB mlocked:0kB bounce:0kB free_pcp:6892kB local_pcp:4856kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 3*4kB (M) 1*8kB (M) 2*16kB (M) 3*32kB (M) 3*64kB (M) 3*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 2*2048kB (M) 701*4096kB (M) = 2879700kB
Node 0 Normal: 170*4kB (UME) 1513*8kB (UME) 358*16kB (UM) 1*32kB (E) 4*64kB (UME) 3*128kB (UME) 2*256kB (UM) 1*512kB (U) 2*1024kB (UM) 3*2048kB (UME) 784*4096kB (M) = 3239664kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
52019 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367867 pages reserved
Mem-Info:
active_anon:106 inactive_anon:9083 isolated_anon:0
 active_file:8428 inactive_file:43413 isolated_file:0
 unevictable:0 dirty:4 writeback:0
 slab_reclaimable:9358 slab_unreclaimable:65661
 mapped:7047 shmem:178 pagetables:470
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1533681 free_pcp:2610 free_cma:0
Node 0 active_anon:424kB inactive_anon:36332kB active_file:33712kB inactive_file:173652kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:28188kB dirty:16kB writeback:0kB shmem:712kB writeback_tmp:0kB kernel_stack:4476kB pagetables:1880kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2812 6735 6735
Node 0 DMA32 free:2879700kB boost:0kB min:4380kB low:7256kB high:10132kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2883248kB mlocked:0kB bounce:0kB free_pcp:3548kB local_pcp:64kB free_cma:0kB
lowmem_reserve[]: 0 0 3923 3923
Node 0 Normal free:3239664kB boost:0kB min:6112kB low:10128kB high:14144kB reserved_highatomic:0KB active_anon:424kB inactive_anon:36332kB active_file:33712kB inactive_file:173652kB unevictable:0kB writepending:16kB present:5242880kB managed:4018128kB mlocked:0kB bounce:0kB free_pcp:6892kB local_pcp:2036kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 3*4kB (M) 1*8kB (M) 2*16kB (M) 3*32kB (M) 3*64kB (M) 3*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 2*2048kB (M) 701*4096kB (M) = 2879700kB
Node 0 Normal: 170*4kB (UME) 1513*8kB (UME) 358*16kB (UM) 1*32kB (E) 4*64kB (UME) 3*128kB (UME) 2*256kB (UM) 1*512kB (U) 2*1024kB (UM) 3*2048kB (UME) 784*4096kB (M) = 3239664kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
52019 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367867 pages reserved
Mem-Info:
active_anon:106 inactive_anon:9083 isolated_anon:0
 active_file:8428 inactive_file:43413 isolated_file:0
 unevictable:0 dirty:4 writeback:0
 slab_reclaimable:9358 slab_unreclaimable:65661
 mapped:7047 shmem:178 pagetables:470
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1533681 free_pcp:2610 free_cma:0
Node 0 active_anon:424kB inactive_anon:36332kB active_file:33712kB inactive_file:173652kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:28188kB dirty:16kB writeback:0kB shmem:712kB writeback_tmp:0kB kernel_stack:4476kB pagetables:1880kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2812 6735 6735
Node 0 DMA32 free:2879700kB boost:0kB min:4380kB low:7256kB high:10132kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2883248kB mlocked:0kB bounce:0kB free_pcp:3548kB local_pcp:3484kB free_cma:0kB
lowmem_reserve[]: 0 0 3923 3923
Node 0 Normal free:3239664kB boost:0kB min:6112kB low:10128kB high:14144kB reserved_highatomic:0KB active_anon:424kB inactive_anon:36332kB active_file:33712kB inactive_file:173652kB unevictable:0kB writepending:16kB present:5242880kB managed:4018128kB mlocked:0kB bounce:0kB free_pcp:6892kB local_pcp:4856kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 3*4kB (M) 1*8kB (M) 2*16kB (M) 3*32kB (M) 3*64kB (M) 3*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 2*2048kB (M) 701*4096kB (M) = 2879700kB
Node 0 Normal: 170*4kB (UME) 1513*8kB (UME) 358*16kB (UM) 1*32kB (E) 4*64kB (UME) 3*128kB (UME) 2*256kB (UM) 1*512kB (U) 2*1024kB (UM) 3*2048kB (UME) 784*4096kB (M) = 3239664kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
52019 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367867 pages reserved
Mem-Info:
active_anon:106 inactive_anon:9083 isolated_anon:0
 active_file:8428 inactive_file:43413 isolated_file:0
 unevictable:0 dirty:4 writeback:0
 slab_reclaimable:9358 slab_unreclaimable:65661
 mapped:7047 shmem:178 pagetables:470
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1533681 free_pcp:2610 free_cma:0
Node 0 active_anon:424kB inactive_anon:36332kB active_file:33712kB inactive_file:173652kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:28188kB dirty:16kB writeback:0kB shmem:712kB writeback_tmp:0kB kernel_stack:4476kB pagetables:1880kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2812 6735 6735
Node 0 DMA32 free:2879700kB boost:0kB min:4380kB low:7256kB high:10132kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2883248kB mlocked:0kB bounce:0kB free_pcp:3548kB local_pcp:64kB free_cma:0kB
lowmem_reserve[]: 0 0 3923 3923
Node 0 Normal free:3239664kB boost:0kB min:6112kB low:10128kB high:14144kB reserved_highatomic:0KB active_anon:424kB inactive_anon:36332kB active_file:33712kB inactive_file:173652kB unevictable:0kB writepending:16kB present:5242880kB managed:4018128kB mlocked:0kB bounce:0kB free_pcp:6892kB local_pcp:2036kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 3*4kB (M) 1*8kB (M) 2*16kB (M) 3*32kB (M) 3*64kB (M) 3*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 2*2048kB (M) 701*4096kB (M) = 2879700kB
Node 0 Normal: 170*4kB (UME) 1513*8kB (UME) 358*16kB (UM) 1*32kB (E) 4*64kB (UME) 3*128kB (UME) 2*256kB (UM) 1*512kB (U) 2*1024kB (UM) 3*2048kB (UME) 784*4096kB (M) = 3239664kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
52019 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367867 pages reserved
Mem-Info:
active_anon:106 inactive_anon:9083 isolated_anon:0
 active_file:8428 inactive_file:43413 isolated_file:0
 unevictable:0 dirty:4 writeback:0
 slab_reclaimable:9358 slab_unreclaimable:65661
 mapped:7047 shmem:178 pagetables:470
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1533681 free_pcp:2610 free_cma:0
Node 0 active_anon:424kB inactive_anon:36332kB active_file:33712kB inactive_file:173652kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:28188kB dirty:16kB writeback:0kB shmem:712kB writeback_tmp:0kB kernel_stack:4476kB pagetables:1880kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2812 6735 6735
Node 0 DMA32 free:2879700kB boost:0kB min:4380kB low:7256kB high:10132kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2883248kB mlocked:0kB bounce:0kB free_pcp:3548kB local_pcp:3484kB free_cma:0kB
lowmem_reserve[]: 0 0 3923 3923
Node 0 Normal free:3239664kB boost:0kB min:6112kB low:10128kB high:14144kB reserved_highatomic:0KB active_anon:424kB inactive_anon:36332kB active_file:33712kB inactive_file:173652kB unevictable:0kB writepending:16kB present:5242880kB managed:4018128kB mlocked:0kB bounce:0kB free_pcp:6892kB local_pcp:4856kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 3*4kB (M) 1*8kB (M) 2*16kB (M) 3*32kB (M) 3*64kB (M) 3*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 2*2048kB (M) 701*4096kB (M) = 2879700kB
Node 0 Normal: 170*4kB (UME) 1513*8kB (UME) 358*16kB (UM) 1*32kB (E) 4*64kB (UME) 3*128kB (UME) 2*256kB (UM) 1*512kB (U) 2*1024kB (UM) 3*2048kB (UME) 784*4096kB (M) = 3239664kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
52019 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367867 pages reserved
Mem-Info:
active_anon:106 inactive_anon:9083 isolated_anon:0
 active_file:8428 inactive_file:43413 isolated_file:0
 unevictable:0 dirty:4 writeback:0
 slab_reclaimable:9358 slab_unreclaimable:65661
 mapped:7047 shmem:178 pagetables:470
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1533681 free_pcp:2610 free_cma:0
Node 0 active_anon:424kB inactive_anon:36332kB active_file:33712kB inactive_file:173652kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:28188kB dirty:16kB writeback:0kB shmem:712kB writeback_tmp:0kB kernel_stack:4476kB pagetables:1880kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2812 6735 6735
Node 0 DMA32 free:2879700kB boost:0kB min:4380kB low:7256kB high:10132kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2883248kB mlocked:0kB bounce:0kB free_pcp:3548kB local_pcp:64kB free_cma:0kB
lowmem_reserve[]: 0 0 3923 3923
Node 0 Normal free:3239664kB boost:0kB min:6112kB low:10128kB high:14144kB reserved_highatomic:0KB active_anon:424kB inactive_anon:36332kB active_file:33712kB inactive_file:173652kB unevictable:0kB writepending:16kB present:5242880kB managed:4018128kB mlocked:0kB bounce:0kB free_pcp:6892kB local_pcp:2036kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 3*4kB (M) 1*8kB (M) 2*16kB (M) 3*32kB (M) 3*64kB (M) 3*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 2*2048kB (M) 701*4096kB (M) = 2879700kB
Node 0 Normal: 170*4kB (UME) 1513*8kB (UME) 358*16kB (UM) 1*32kB (E) 4*64kB (UME) 3*128kB (UME) 2*256kB (UM) 1*512kB (U) 2*1024kB (UM) 3*2048kB (UME) 784*4096kB (M) = 3239664kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
52019 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367867 pages reserved
Mem-Info:
active_anon:106 inactive_anon:9083 isolated_anon:0
 active_file:8428 inactive_file:43413 isolated_file:0
 unevictable:0 dirty:4 writeback:0
 slab_reclaimable:9358 slab_unreclaimable:65661
 mapped:7047 shmem:178 pagetables:470
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1533681 free_pcp:2610 free_cma:0
Node 0 active_anon:424kB inactive_anon:36332kB active_file:33712kB inactive_file:173652kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:28188kB dirty:16kB writeback:0kB shmem:712kB writeback_tmp:0kB kernel_stack:4476kB pagetables:1880kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2812 6735 6735
Node 0 DMA32 free:2879700kB boost:0kB min:4380kB low:7256kB high:10132kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2883248kB mlocked:0kB bounce:0kB free_pcp:3548kB local_pcp:3484kB free_cma:0kB
lowmem_reserve[]: 0 0 3923 3923
Node 0 Normal free:3239664kB boost:0kB min:6112kB low:10128kB high:14144kB reserved_highatomic:0KB active_anon:424kB inactive_anon:36332kB active_file:33712kB inactive_file:173652kB unevictable:0kB writepending:16kB present:5242880kB managed:4018128kB mlocked:0kB bounce:0kB free_pcp:6892kB local_pcp:4856kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 3*4kB (M) 1*8kB (M) 2*16kB (M) 3*32kB (M) 3*64kB (M) 3*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 2*2048kB (M) 701*4096kB (M) = 2879700kB
Node 0 Normal: 170*4kB (UME) 1513*8kB (UME) 358*16kB (UM) 1*32kB (E) 4*64kB (UME) 3*128kB (UME) 2*256kB (UM) 1*512kB (U) 2*1024kB (UM) 3*2048kB (UME) 784*4096kB (M) = 3239664kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
52019 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367867 pages reserved
Mem-Info:
active_anon:106 inactive_anon:9083 isolated_anon:0
 active_file:8428 inactive_file:43413 isolated_file:0
 unevictable:0 dirty:4 writeback:0
 slab_reclaimable:9358 slab_unreclaimable:65661
 mapped:7047 shmem:178 pagetables:470
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1533681 free_pcp:2610 free_cma:0
Node 0 active_anon:424kB inactive_anon:36332kB active_file:33712kB inactive_file:173652kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:28188kB dirty:16kB writeback:0kB shmem:712kB writeback_tmp:0kB kernel_stack:4476kB pagetables:1880kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2812 6735 6735
Node 0 DMA32 free:2879700kB boost:0kB min:4380kB low:7256kB high:10132kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2883248kB mlocked:0kB bounce:0kB free_pcp:3548kB local_pcp:64kB free_cma:0kB
lowmem_reserve[]: 0 0 3923 3923
Node 0 Normal free:3239664kB boost:0kB min:6112kB low:10128kB high:14144kB reserved_highatomic:0KB active_anon:424kB inactive_anon:36332kB active_file:33712kB inactive_file:173652kB unevictable:0kB writepending:16kB present:5242880kB managed:4018128kB mlocked:0kB bounce:0kB free_pcp:6892kB local_pcp:2036kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 3*4kB (M) 1*8kB (M) 2*16kB (M) 3*32kB (M) 3*64kB (M) 3*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 2*2048kB (M) 701*4096kB (M) = 2879700kB
Node 0 Normal: 170*4kB (UME) 1513*8kB (UME) 358*16kB (UM) 1*32kB (E) 4*64kB (UME) 3*128kB (UME) 2*256kB (UM) 1*512kB (U) 2*1024kB (UM) 3*2048kB (UME) 784*4096kB (M) = 3239664kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
52019 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367867 pages reserved
Mem-Info:
active_anon:106 inactive_anon:9083 isolated_anon:0
 active_file:8428 inactive_file:43413 isolated_file:0
 unevictable:0 dirty:4 writeback:0
 slab_reclaimable:9358 slab_unreclaimable:65661
 mapped:7047 shmem:178 pagetables:470
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1533681 free_pcp:2610 free_cma:0
Node 0 active_anon:424kB inactive_anon:36332kB active_file:33712kB inactive_file:173652kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:28188kB dirty:16kB writeback:0kB shmem:712kB writeback_tmp:0kB kernel_stack:4476kB pagetables:1880kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2812 6735 6735
Node 0 DMA32 free:2879700kB boost:0kB min:4380kB low:7256kB high:10132kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2883248kB mlocked:0kB bounce:0kB free_pcp:3548kB local_pcp:3484kB free_cma:0kB
lowmem_reserve[]: 0 0 3923 3923
Node 0 Normal free:3239664kB boost:0kB min:6112kB low:10128kB high:14144kB reserved_highatomic:0KB active_anon:424kB inactive_anon:36332kB active_file:33712kB inactive_file:173652kB unevictable:0kB writepending:16kB present:5242880kB managed:4018128kB mlocked:0kB bounce:0kB free_pcp:6892kB local_pcp:4856kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 3*4kB (M) 1*8kB (M) 2*16kB (M) 3*32kB (M) 3*64kB (M) 3*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 2*2048kB (M) 701*4096kB (M) = 2879700kB
Node 0 Normal: 170*4kB (UME) 1513*8kB (UME) 358*16kB (UM) 1*32kB (E) 4*64kB (UME) 3*128kB (UME) 2*256kB (UM) 1*512kB (U) 2*1024kB (UM) 3*2048kB (UME) 784*4096kB (M) = 3239664kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
52019 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367867 pages reserved
Mem-Info:
active_anon:106 inactive_anon:9083 isolated_anon:0
 active_file:8428 inactive_file:43413 isolated_file:0
 unevictable:0 dirty:4 writeback:0
 slab_reclaimable:9358 slab_unreclaimable:65661
 mapped:7047 shmem:178 pagetables:470
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1533681 free_pcp:2610 free_cma:0
Node 0 active_anon:424kB inactive_anon:36332kB active_file:33712kB inactive_file:173652kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:28188kB dirty:16kB writeback:0kB shmem:712kB writeback_tmp:0kB kernel_stack:4476kB pagetables:1880kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2812 6735 6735
Node 0 DMA32 free:2879700kB boost:0kB min:4380kB low:7256kB high:10132kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2883248kB mlocked:0kB bounce:0kB free_pcp:3548kB local_pcp:64kB free_cma:0kB
lowmem_reserve[]: 0 0 3923 3923
Node 0 Normal free:3239664kB boost:0kB min:6112kB low:10128kB high:14144kB reserved_highatomic:0KB active_anon:424kB inactive_anon:36332kB active_file:33712kB inactive_file:173652kB unevictable:0kB writepending:16kB present:5242880kB managed:4018128kB mlocked:0kB bounce:0kB free_pcp:6892kB local_pcp:2036kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 3*4kB (M) 1*8kB (M) 2*16kB (M) 3*32kB (M) 3*64kB (M) 3*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 2*2048kB (M) 701*4096kB (M) = 2879700kB
Node 0 Normal: 170*4kB (UME) 1513*8kB (UME) 358*16kB (UM) 1*32kB (E) 4*64kB (UME) 3*128kB (UME) 2*256kB (UM) 1*512kB (U) 2*1024kB (UM) 3*2048kB (UME) 784*4096kB (M) = 3239664kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
52019 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367867 pages reserved
Mem-Info:
active_anon:106 inactive_anon:9083 isolated_anon:0
 active_file:8428 inactive_file:43413 isolated_file:0
 unevictable:0 dirty:4 writeback:0
 slab_reclaimable:9358 slab_unreclaimable:65661
 mapped:7047 shmem:178 pagetables:470
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1533681 free_pcp:2610 free_cma:0
Node 0 active_anon:424kB inactive_anon:36332kB active_file:33712kB inactive_file:173652kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:28188kB dirty:16kB writeback:0kB shmem:712kB writeback_tmp:0kB kernel_stack:4476kB pagetables:1880kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2812 6735 6735
Node 0 DMA32 free:2879700kB boost:0kB min:4380kB low:7256kB high:10132kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2883248kB mlocked:0kB bounce:0kB free_pcp:3548kB local_pcp:3484kB free_cma:0kB
lowmem_reserve[]: 0 0 3923 3923
Node 0 Normal free:3239664kB boost:0kB min:6112kB low:10128kB high:14144kB reserved_highatomic:0KB active_anon:424kB inactive_anon:36332kB active_file:33712kB inactive_file:173652kB unevictable:0kB writepending:16kB present:5242880kB managed:4018128kB mlocked:0kB bounce:0kB free_pcp:6892kB local_pcp:4856kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 3*4kB (M) 1*8kB (M) 2*16kB (M) 3*32kB (M) 3*64kB (M) 3*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 2*2048kB (M) 701*4096kB (M) = 2879700kB
Node 0 Normal: 170*4kB (UME) 1513*8kB (UME) 358*16kB (UM) 1*32kB (E) 4*64kB (UME) 3*128kB (UME) 2*256kB (UM) 1*512kB (U) 2*1024kB (UM) 3*2048kB (UME) 784*4096kB (M) = 3239664kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
52019 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367867 pages reserved
Mem-Info:
active_anon:106 inactive_anon:9083 isolated_anon:0
 active_file:8428 inactive_file:43413 isolated_file:0
 unevictable:0 dirty:4 writeback:0
 slab_reclaimable:9358 slab_unreclaimable:65661
 mapped:7047 shmem:178 pagetables:470
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1533681 free_pcp:2610 free_cma:0
Node 0 active_anon:424kB inactive_anon:36332kB active_file:33712kB inactive_file:173652kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:28188kB dirty:16kB writeback:0kB shmem:712kB writeback_tmp:0kB kernel_stack:4476kB pagetables:1880kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2812 6735 6735
Node 0 DMA32 free:2879700kB boost:0kB min:4380kB low:7256kB high:10132kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2883248kB mlocked:0kB bounce:0kB free_pcp:3548kB local_pcp:64kB free_cma:0kB
lowmem_reserve[]: 0 0 3923 3923
Node 0 Normal free:3239664kB boost:0kB min:6112kB low:10128kB high:14144kB reserved_highatomic:0KB active_anon:424kB inactive_anon:36332kB active_file:33712kB inactive_file:173652kB unevictable:0kB writepending:16kB present:5242880kB managed:4018128kB mlocked:0kB bounce:0kB free_pcp:6892kB local_pcp:2036kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 3*4kB (M) 1*8kB (M) 2*16kB (M) 3*32kB (M) 3*64kB (M) 3*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 2*2048kB (M) 701*4096kB (M) = 2879700kB
Node 0 Normal: 170*4kB (UME) 1513*8kB (UME) 358*16kB (UM) 1*32kB (E) 4*64kB (UME) 3*128kB (UME) 2*256kB (UM) 1*512kB (U) 2*1024kB (UM) 3*2048kB (UME) 784*4096kB (M) = 3239664kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048k

Tested on:

commit:         f7757129 Merge tag 'v6.5-p3' of git://git.kernel.org/p..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=134533a0680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b764e732a6b12d0
dashboard link: https://syzkaller.appspot.com/bug?extid=32af18ae7b894a681f2d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16cc0c97a80000

