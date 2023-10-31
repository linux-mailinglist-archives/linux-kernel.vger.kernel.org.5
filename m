Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D147DC8E4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 10:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343590AbjJaJCc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 31 Oct 2023 05:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343689AbjJaJC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:02:29 -0400
Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EE091
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 02:02:23 -0700 (PDT)
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-3b56a1374afso95103b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 02:02:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698742943; x=1699347743;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gbd8Lm/cxXlJYk8RguQqD2HHq3LCFPG8wS7Enybuhz0=;
        b=TCMD7zEalwhKoyMIMXe1nDJAR4zVadAoCYZZXp+/pe9L09UKmkjyv3WqFdL1txbThg
         mk3PPMx30OxKCB8eDqaOl7r5KAyiNsysFKuc6J7BjugYnQXSnc8ymiZTcJ9O6kpRsawG
         nm/sr7BmTzZtoO6JQOA0tfjv5MirxcE1mzK/eWbVZF4+dHVK0DOVe2j0CgeJneMiCJ8s
         YM6henTDhJWtfIhprZXgfOes/8c5SLUwyTaQ/SmT5rGIE353UyN+Sw41Qt6zArNULBHi
         f4l8P3QtcdVLSY1LVjzBS00ixCQK8zUb9o57im5Wt8bJpAOzue+fpHfS8XZnxxgLRJjx
         gcMw==
X-Gm-Message-State: AOJu0Yz3w7dGmPp3ryaxQj5yazKe3/5Lc0NxREmKEqBvyvC9DwiNn3pQ
        QrWjIY7JbEBQMXvM7QU9i36MIxrppyghZxTK/XAllHVgY4OS
X-Google-Smtp-Source: AGHT+IH8AkwArgChFf8K+myrjGZEkXNpTv4Z9zj8jUH4cFkpyaSO+eVZ0/zSAlPlqMgDY06I8Jnqf7tgdYxSy2zIJoDhmMvepGHk
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1523:b0:3b2:e46e:448c with SMTP id
 u35-20020a056808152300b003b2e46e448cmr4356963oiw.3.1698742943154; Tue, 31 Oct
 2023 02:02:23 -0700 (PDT)
Date:   Tue, 31 Oct 2023 02:02:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b1093b0608ff6979@google.com>
Subject: [syzbot] [usb?] INFO: rcu detected stall in raw_ioctl
From:   syzbot <syzbot+5f996b83575ef4058638@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    9b6db9a3a675 Merge tag 'thunderbolt-for-v6.7-rc1' of git:/..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=13cae767680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a6685a8ab59f5838
dashboard link: https://syzkaller.appspot.com/bug?extid=5f996b83575ef4058638
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a7b1b6a564cc/disk-9b6db9a3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a091a2f990e1/vmlinux-9b6db9a3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5d14ab1c75e4/bzImage-9b6db9a3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5f996b83575ef4058638@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {
 1-....
 } 2684 jiffies s: 17493 root: 0x2/.
rcu: blocking rcu_node structures (internal RCU debug):
Sending NMI from CPU 0 to CPUs 1:
lowmem_reserve[]: 0 0 3924 3924
NMI backtrace for cpu 1
CPU: 1 PID: 22191 Comm: syz-executor.1 Not tainted 6.6.0-rc6-syzkaller-00158-g9b6db9a3a675 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
RIP: 0010:io_serial_out+0x8f/0xb0 drivers/tty/serial/8250/8250_port.c:424
Code: 48 8d 7d 40 44 89 e1 48 b8 00 00 00 00 00 fc ff df 48 89 fa d3 e3 48 c1 ea 03 80 3c 02 00 75 18 66 03 5d 40 44 89 e8 89 da ee <5b> 5d 41 5c 41 5d c3 e8 e5 49 16 ff eb a4 e8 3e 4a 16 ff eb e1 66
RSP: 0018:ffffc90000198388 EFLAGS: 00000006
RAX: 0000000000000000 RBX: 00000000000003f9 RCX: 0000000000000000
RDX: 00000000000003f9 RSI: ffffffff8283a005 RDI: ffffffff8c156d20
RBP: ffffffff8c156ce0 R08: 0000000000000001 R09: 000000000000001f
R10: 0000000000000000 R11: 205d314320202020 R12: 0000000000000000
R13: 0000000000000000 R14: ffffffff8c156d30 R15: 00000000000000c6
FS:  00007f0ea81f96c0(0000) GS:ffff8881f6700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0ea8217ff0 CR3: 000000011831a000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 serial_out drivers/tty/serial/8250/8250.h:122 [inline]
 serial8250_clear_IER+0x98/0xb0 drivers/tty/serial/8250/8250_port.c:717
 serial8250_console_write+0x1e9/0x1060 drivers/tty/serial/8250/8250_port.c:3417
 console_emit_next_record kernel/printk/printk.c:2910 [inline]
 console_flush_all+0x4eb/0xfb0 kernel/printk/printk.c:2966
 console_unlock+0x10c/0x260 kernel/printk/printk.c:3035
 vprintk_emit+0x17f/0x5f0 kernel/printk/printk.c:2307
 vprintk+0x7b/0x90 kernel/printk/printk_safe.c:45
 _printk+0xc8/0x100 kernel/printk/printk.c:2332
 show_free_areas+0x1257/0x2140 mm/show_mem.c:353
 __show_mem+0x34/0x140 mm/show_mem.c:409
 k_spec drivers/tty/vt/keyboard.c:667 [inline]
 k_spec+0xea/0x140 drivers/tty/vt/keyboard.c:656
 kbd_keycode drivers/tty/vt/keyboard.c:1524 [inline]
 kbd_event+0xcc8/0x17c0 drivers/tty/vt/keyboard.c:1543
 input_to_handler+0x382/0x4c0 drivers/input/input.c:132
 input_pass_values.part.0+0x52f/0x7a0 drivers/input/input.c:161
 input_pass_values drivers/input/input.c:148 [inline]
 input_event_dispose+0x5ee/0x770 drivers/input/input.c:378
 input_handle_event+0x11c/0xd80 drivers/input/input.c:406
 input_repeat_key+0x251/0x340 drivers/input/input.c:2263
 call_timer_fn+0x19e/0x580 kernel/time/timer.c:1700
 expire_timers kernel/time/timer.c:1751 [inline]
 __run_timers+0x764/0xb10 kernel/time/timer.c:2022
 run_timer_softirq+0x58/0xd0 kernel/time/timer.c:2035
 __do_softirq+0x20b/0x94e kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu kernel/softirq.c:632 [inline]
 irq_exit_rcu+0xa7/0x110 kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x8e/0xb0 arch/x86/kernel/apic/apic.c:1074
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:console_flush_all+0x9e0/0xfb0 kernel/printk/printk.c:2972
Code: 66 19 23 00 9c 5b 81 e3 00 02 00 00 31 ff 48 89 de e8 b4 68 1c 00 48 85 db 0f 85 97 03 00 00 e8 16 6d 1c 00 fb 48 8b 44 24 08 <48> 8b 14 24 0f b6 00 83 e2 07 38 d0 7f 08 84 c0 0f 85 08 05 00 00
RSP: 0018:ffffc9000d37faf0 EFLAGS: 00000293
RAX: fffff52001a6ff89 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff888120331d00 RSI: ffffffff8131088a RDI: 0000000000000007
RBP: dffffc0000000000 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 205d314320202020 R12: ffffffff88351760
R13: 0000000000000001 R14: ffffffff883517b8 R15: 0000000000000001
 console_unlock+0x10c/0x260 kernel/printk/printk.c:3035
 vprintk_emit+0x17f/0x5f0 kernel/printk/printk.c:2307
 vprintk+0x7b/0x90 kernel/printk/printk_safe.c:45
 _printk+0xc8/0x100 kernel/printk/printk.c:2332
 usb_gadget_register_driver_owner+0x1c2/0x2d0 drivers/usb/gadget/udc/core.c:1695
 raw_ioctl_run drivers/usb/gadget/legacy/raw_gadget.c:559 [inline]
 raw_ioctl+0x172f/0x2b80 drivers/usb/gadget/legacy/raw_gadget.c:1266
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0ea8eb884b
Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
RSP: 002b:00007f0ea81f6fa0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f0ea8eb884b
RDX: 0000000000000000 RSI: 0000000000005501 RDI: 0000000000000004
RBP: 00007f0ea81f8070 R08: 0000000000000010 R09: 00312e6364755f79
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f0ea81f7040 R14: 0000000020000080 R15: 00007f0ea90fcb88
 </TASK>
Node 0 Normal free:2722092kB boost:0kB min:6108kB low:10124kB high:14140kB reserved_highatomic:0KB active_anon:56432kB inactive_anon:206832kB active_file:21556kB inactive_file:162020kB unevictable:0kB writepending:48kB present:5242880kB managed:4018384kB mlocked:0kB bounce:0kB free_pcp:6736kB local_pcp:2472kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 3*4kB (M) 1*8kB (M) 2*16kB (M) 3*32kB (M) 3*64kB (M) 3*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 1*2048kB (M) 702*4096kB (M) = 2881748kB
Node 0 Normal: 833*4kB (ME) 497*8kB (UME) 242*16kB (ME) 124*32kB (UME) 42*64kB (UME) 9*128kB (ME) 1*256kB (E) 1*512kB (M) 3*1024kB (UME) 2*2048kB (UM) 658*4096kB (M) = 2722092kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
101532 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367316 pages reserved
iowarrior 2-1:0.0: iowarrior_callback - usb_submit_urb failed with result -19
Mem-Info:
active_anon:14108 inactive_anon:51414 isolated_anon:0
 active_file:5389 inactive_file:40505 isolated_file:0
 unevictable:0 dirty:0 writeback:0
 slab_reclaimable:5350 slab_unreclaimable:84376
 mapped:11391 shmem:55640 pagetables:388
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1412738 free_pcp:1798 free_cma:0
Node 0 active_anon:56432kB inactive_anon:205656kB active_file:21556kB inactive_file:162020kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:45564kB dirty:0kB writeback:0kB shmem:222560kB writeback_tmp:0kB kernel_stack:4020kB pagetables:1552kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2814 6738 6738
Node 0 DMA32 free:2881748kB boost:0kB min:4380kB low:7260kB high:10140kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2885196kB mlocked:0kB bounce:0kB free_pcp:3448kB local_pcp:3384kB free_cma:0kB
lowmem_reserve[]: 0 0 3924 3924
Node 0 Normal free:2753844kB boost:0kB min:6108kB low:10124kB high:14140kB reserved_highatomic:0KB active_anon:56432kB inactive_anon:205576kB active_file:21556kB inactive_file:162020kB unevictable:0kB writepending:0kB present:5242880kB managed:4018384kB mlocked:0kB bounce:0kB free_pcp:5844kB local_pcp:1464kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 3*4kB (M) 1*8kB (M) 2*16kB (M) 3*32kB (M) 3*64kB (M) 3*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 1*2048kB (M) 702*4096kB (M) = 2881748kB
Node 0 Normal: 1173*4kB (UME) 658*8kB (UME) 453*16kB (UME) 398*32kB (UME) 131*64kB (UME) 61*128kB (UME) 11*256kB (UME) 5*512kB (UME) 3*1024kB (UME) 2*2048kB (UM) 658*4096kB (M) = 2753844kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
101535 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367316 pages reserved
iowarrior 2-1:0.0: iowarrior_callback - usb_submit_urb failed with result -19


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
