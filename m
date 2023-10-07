Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239247BC993
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 20:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344080AbjJGSeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 14:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJGSeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 14:34:01 -0400
Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com [209.85.160.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA109C2
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 11:33:51 -0700 (PDT)
Received: by mail-oa1-f80.google.com with SMTP id 586e51a60fabf-1dd691b1037so5009553fac.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Oct 2023 11:33:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696703631; x=1697308431;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YRY4ZQ41Bg9zPG+xFZ0ZH7y84tUqPOIQ4L9dgVu2AMM=;
        b=Vru2SPPJiB/GQPQNFwqEwd99fFBhAN6IY9i7Lsre41dol1w1T0cMNcwWP33IQQCqGF
         kZbU0+mlDUY0SNophY9TOqYCzooMpWBvWCu042V9HwoxYsqtunCCHWmVws3U34Gp4dYH
         HAK//G3yMxAPvvA7QMud7k959+O403bR2WgmrB5COBE7pztpGcBcq5syjj/v6IcW0vGT
         tBJrkCd7D69YWJ5eI/cSHRWmuY7GN2BDmZ7dZKnk8uwH2NWrNKNjnsBUhPIXoOzZoaCn
         czjH9Z8DceSkUlWmXPsvzQKMcZhqjDYmUqVixWi/FwMoFiOuE2ae5p19WxFacGiUiT2N
         JCEg==
X-Gm-Message-State: AOJu0Yy5ZVdmGMSZsPt/f3PRYB/lBbBOTb++kjk0Oj8iCjPstH3nNnks
        8QocMVh56mWEkHg3dxBRTv8Zv/DY1EIik0LGVlb0ePOOqcv3
X-Google-Smtp-Source: AGHT+IHjuQlCQwgJFUP3DX0nAOU8Ira5+4zKc6rR34EBBvt9ppDBFCSWX3pqU2GdrjvU5Ip9BjKLtEjZ1nToLzwJ39vcSkT6vOlV
MIME-Version: 1.0
X-Received: by 2002:a05:6870:a8ad:b0:1d6:899d:6ed9 with SMTP id
 eb45-20020a056870a8ad00b001d6899d6ed9mr4402414oab.9.1696703630839; Sat, 07
 Oct 2023 11:33:50 -0700 (PDT)
Date:   Sat, 07 Oct 2023 11:33:50 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003495bf060724994a@google.com>
Subject: [syzbot] [net?] [usb?] INFO: rcu detected stall in worker_thread (9)
From:   syzbot <syzbot+225bfad78b079744fd5e@syzkaller.appspotmail.com>
To:     bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ce36c8b14987 Merge tag 'ubifs-for-linus-6.6-rc5' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1172ade1680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=57da1ac039c4c78a
dashboard link: https://syzkaller.appspot.com/bug?extid=225bfad78b079744fd5e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10429ee6680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4081cc91aa2a/disk-ce36c8b1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/eaf09d1ab3e5/vmlinux-ce36c8b1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c542d28356db/bzImage-ce36c8b1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+225bfad78b079744fd5e@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 1-....
 } 2682 jiffies s: 16081 root: 0x2/.
rcu: blocking rcu_node structures (internal RCU debug):

Sending NMI from CPU 0 to CPUs 1:
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
NMI backtrace for cpu 1
CPU: 1 PID: 5131 Comm: kworker/1:5 Not tainted 6.6.0-rc4-syzkaller-00012-gce36c8b14987 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Workqueue: events nsim_dev_trap_report_work
RIP: 0010:io_serial_in+0x76/0xb0 drivers/tty/serial/8250/8250_port.c:417
Code: 60 35 c6 fc 89 e9 41 d3 e6 48 83 c3 40 48 89 d8 48 c1 e8 03 42 80 3c 38 00 74 08 48 89 df e8 51 b1 20 fd 44 03 33 44 89 f2 ec <0f> b6 c0 5b 41 5e 41 5f 5d c3 89 e9 80 e1 07 38 c1 7c ad 48 89 ef
RSP: 0018:ffffc900001efed8 EFLAGS: 00000002
RAX: 1ffffffff2443700 RBX: ffffffff9221bd60 RCX: 0000000000000000
RDX: 00000000000003fd RSI: 0000000000000000 RDI: 0000000000000020
RBP: 0000000000000000 R08: ffffffff84c7d646 R09: 1ffff110039be046
R10: dffffc0000000000 R11: ffffed10039be047 R12: dffffc0000000000
R13: 0000000000002703 R14: 00000000000003fd R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcd51aff0f0 CR3: 000000000d130000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 serial_in drivers/tty/serial/8250/8250.h:117 [inline]
 serial_lsr_in drivers/tty/serial/8250/8250.h:139 [inline]
 wait_for_lsr drivers/tty/serial/8250/8250_port.c:2089 [inline]
 serial8250_console_fifo_write drivers/tty/serial/8250/8250_port.c:3374 [inline]
 serial8250_console_write+0x110e/0x1820 drivers/tty/serial/8250/8250_port.c:3452
 console_emit_next_record kernel/printk/printk.c:2910 [inline]
 console_flush_all+0x7ff/0xec0 kernel/printk/printk.c:2966
 console_unlock+0x13b/0x4d0 kernel/printk/printk.c:3035
 vprintk_emit+0x508/0x720 kernel/printk/printk.c:2307
 dev_vprintk_emit+0x2ae/0x330 drivers/base/core.c:4849
 dev_printk_emit+0xdd/0x120 drivers/base/core.c:4860
 _dev_warn+0x122/0x170 drivers/base/core.c:4916
 usb_rx_callback_intf0+0x156/0x190 drivers/media/rc/imon.c:1771
 __usb_hcd_giveback_urb+0x371/0x530 drivers/usb/core/hcd.c:1650
 dummy_timer+0x8aa/0x3210 drivers/usb/gadget/udc/dummy_hcd.c:1987
 call_timer_fn+0x17a/0x580 kernel/time/timer.c:1700
 expire_timers kernel/time/timer.c:1751 [inline]
 __run_timers+0x64f/0x860 kernel/time/timer.c:2022
 run_timer_softirq+0x67/0xf0 kernel/time/timer.c:2035
 __do_softirq+0x2ab/0x908 kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu+0xf1/0x1b0 kernel/softirq.c:632
 irq_exit_rcu+0x9/0x20 kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1074
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:jhash2 include/linux/jhash.h:129 [inline]
RIP: 0010:hash_stack lib/stackdepot.c:322 [inline]
RIP: 0010:__stack_depot_save+0x64/0x650 lib/stackdepot.c:382
Code: 00 43 8d 34 00 46 8d 34 c5 7b 71 f5 75 83 fe 04 72 70 44 89 f5 44 89 f0 4c 89 fa 03 02 03 6a 04 44 03 72 08 44 89 f7 c1 c7 04 <44> 29 f0 31 c7 41 01 ee 29 fd 89 fb c1 c3 06 31 eb 44 01 f7 89 d9
RSP: 0018:ffffc900043df6b8 EFLAGS: 00000a07
RAX: 00000000062d8798 RBX: 00000000fe584f8b RCX: 00000000838c8150
RDX: ffffc900043df758 RSI: 0000000000000004 RDI: 00000000385a93f7
RBP: 000000006c0b3f46 R08: 000000000000000b R09: ffffffff813da4e7
R10: 0000000000000002 R11: ffff888026631dc0 R12: 0000000000000820
R13: 0000000000000001 R14: 000000007385a93f R15: ffffc900043df710
 kasan_save_stack mm/kasan/common.c:46 [inline]
 kasan_set_track+0x61/0x70 mm/kasan/common.c:52
 __kasan_slab_alloc+0x66/0x70 mm/kasan/common.c:328
 kasan_slab_alloc include/linux/kasan.h:188 [inline]
 slab_post_alloc_hook+0x67/0x3d0 mm/slab.h:762
 slab_alloc_node mm/slub.c:3478 [inline]
 kmem_cache_alloc_node+0x148/0x330 mm/slub.c:3523
 __alloc_skb+0x181/0x420 net/core/skbuff.c:640
 alloc_skb include/linux/skbuff.h:1286 [inline]
 nsim_dev_trap_skb_build drivers/net/netdevsim/dev.c:748 [inline]
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:805 [inline]
 nsim_dev_trap_report_work+0x250/0xa90 drivers/net/netdevsim/dev.c:850
 process_one_work kernel/workqueue.c:2630 [inline]
 process_scheduled_works+0x90f/0x1400 kernel/workqueue.c:2703
 worker_thread+0xa5f/0xff0 kernel/workqueue.c:2784
 kthread+0x2d3/0x370 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
raw-gadget.5 gadget.4: ignoring, device is not running
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
