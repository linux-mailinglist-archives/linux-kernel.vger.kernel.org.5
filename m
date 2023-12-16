Return-Path: <linux-kernel+bounces-2200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24604815946
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 14:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCCA6284EFC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 13:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2DE28DB8;
	Sat, 16 Dec 2023 13:31:09 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D891D69E
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 13:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7b6f8b66df0so195078939f.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 05:31:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702733466; x=1703338266;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mmUrxXcFPZ2Tz5VtztZlmm6/kP116pVW3IQUZc38b6w=;
        b=D43RlbFT+afT4d3fLO9Twzhj1W9q9eECLGIcG7jxL0lyd2V38TCkxVfTfFWXoo2frY
         24uMrWjAD0X/Ud+r9wk8GMIVb6VNgt2yw6Riu9DyRIODz1GKFMSJjKT3UCwRtdcOiLO2
         SYu5Z+0uzpyYI8zAxNeHD3uPmDATCVPdUqfz2EILeFRAp+WyE3zaT0Q5S+VcNsfuIBry
         1hgG7BshH7aNZfqVZdVwiURMeWN85Z2OHNYVt2tV6Ml+MFFWEVhP24xkG1+f28RT74Er
         ub0x+GH4LAQ/kXdMnLncvaXIH2zc8mWJ7cv7nAcyYqS4OpE6JbL+/2OfECmGJnwUIPTd
         /7Tg==
X-Gm-Message-State: AOJu0YxoM38vOlZVSwWHCykN+itoBCDkkCtGoRSnjyS9BBKvEDEShwuX
	TuTf8v3cXeRmvmUaHKxVCf70hiBBh4unHGq4XoFSlgGsdoH4
X-Google-Smtp-Source: AGHT+IHZJy3xMoHAL3XqSNB3v0RBPI8ihvzPcPeyR5BagHSceEV24/Stnv+D8dUHose9LOFfZXO7DpTeEtDrtvkPAVjOSLMsKUjp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:37a3:b0:466:6576:2b64 with SMTP id
 w35-20020a05663837a300b0046665762b64mr565123jal.3.1702733466399; Sat, 16 Dec
 2023 05:31:06 -0800 (PST)
Date: Sat, 16 Dec 2023 05:31:06 -0800
In-Reply-To: <tencent_82482E1D6F90963CE8E2EF9ACD6079866D0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000698726060ca087c8@google.com>
Subject: Re: [syzbot] [block?] INFO: task hung in bdev_release
From: syzbot <syzbot+4da851837827326a7cd4@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in bdev_release

INFO: task syz-executor.0:5519 blocked for more than 143 seconds.
      Not tainted 6.7.0-rc2-next-20231124-syzkaller-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:28208 pid:5519  tgid:5519  ppid:5421   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5399 [inline]
 __schedule+0xf15/0x5c00 kernel/sched/core.c:6726
 __schedule_loop kernel/sched/core.c:6801 [inline]
 schedule+0xe7/0x270 kernel/sched/core.c:6816
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6873
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x5b4/0x9c0 kernel/locking/mutex.c:747
 bdev_release+0xe6/0xac0 block/bdev.c:973
 blkdev_release+0x37/0x50 block/fops.c:616
 __fput+0x270/0xbb0 fs/file_table.c:394
 __fput_sync+0x47/0x50 fs/file_table.c:475
 __do_sys_close fs/open.c:1591 [inline]
 __se_sys_close fs/open.c:1576 [inline]
 __x64_sys_close+0x86/0xf0 fs/open.c:1576
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x62/0x6a
RIP: 0033:0x7fc4db47b9da
RSP: 002b:00007fff600ff100 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 00007fc4db47b9da
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 00007fc4db59d980 R08: 0000001b2e860000 R09: 0000000000000001
R10: 00007fff601ac080 R11: 0000000000000293 R12: 000000000001c90d
R13: ffffffffffffffff R14: 00007fc4db000000 R15: 000000000001c5cc
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/29:
 #0: ffffffff8cfacf60 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
 #0: ffffffff8cfacf60 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:747 [inline]
 #0: ffffffff8cfacf60 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6613
2 locks held by getty/4821:
 #0: ffff8880272c20a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfc4/0x1490 drivers/tty/n_tty.c:2201
1 lock held by udevd/5406:
 #0: ffff88801da974c8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_open_by_dev+0x27c/0xed0 block/bdev.c:859
1 lock held by syz-executor.0/5519:
 #0: ffff88801da974c8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_release+0xe6/0xac0 block/bdev.c:973
1 lock held by syz-executor.0/5806:
 #0: ffff88801da974c8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_open_by_dev+0x27c/0xed0 block/bdev.c:859
1 lock held by syz-executor.0/5823:
 #0: ffff88801da974c8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_open_by_dev+0x27c/0xed0 block/bdev.c:859

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 29 Comm: khungtaskd Not tainted 6.7.0-rc2-next-20231124-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x277/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x299/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xf86/0x1210 kernel/hung_task.c:379
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 48 Comm: kworker/u4:3 Not tainted 6.7.0-rc2-next-20231124-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:find_held_lock+0x9/0x110 kernel/locking/lockdep.c:5236
Code: 0d a5 77 00 e9 18 ff ff ff e8 03 a5 77 00 4c 8d 44 24 20 eb 95 66 66 2e 0f 1f 84 00 00 00 00 00 90 41 57 44 8d 7a ff 49 63 c7 <41> 56 49 89 ce 48 8d 04 80 41 55 49 89 f5 41 54 55 89 d5 53 48 8d
RSP: 0018:ffffc90000b8eff8 EFLAGS: 00000006
RAX: 0000000000000004 RBX: 0000000000000003 RCX: ffffc90000b8f058
RDX: 0000000000000005 RSI: ffff8880b9840860 RDI: ffff888019edbb80
RBP: 1ffff92000171e03 R08: 0000000000000000 R09: fffffbfff1e32732
R10: ffffffff8f193997 R11: 0000000000000004 R12: ffff8880b9840860
R13: 0000000000000005 R14: ffff888019edc638 R15: 0000000000000004
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd39e31e4c CR3: 000000000cd78000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 __lock_release kernel/locking/lockdep.c:5428 [inline]
 lock_release+0x1fd/0x6a0 kernel/locking/lockdep.c:5773
 local_lock_release include/linux/local_lock_internal.h:38 [inline]
 ___slab_alloc+0x98b/0x1700 mm/slub.c:3139
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3297
 __slab_alloc_node mm/slub.c:3350 [inline]
 slab_alloc_node mm/slub.c:3442 [inline]
 __kmem_cache_alloc_node+0x131/0x310 mm/slub.c:3491
 __do_kmalloc_node mm/slab_common.c:1006 [inline]
 __kmalloc+0x49/0x90 mm/slab_common.c:1020
 kmalloc include/linux/slab.h:604 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 ieee802_11_parse_elems_full+0xee/0x13a0 net/mac80211/util.c:1628
 ieee802_11_parse_elems_crc net/mac80211/ieee80211_i.h:2288 [inline]
 ieee802_11_parse_elems net/mac80211/ieee80211_i.h:2295 [inline]
 ieee80211_inform_bss+0x120/0x1150 net/mac80211/scan.c:79
 rdev_inform_bss+0xf9/0x440 net/wireless/rdev-ops.h:418
 cfg80211_inform_single_bss_frame_data+0x7b7/0xf40 net/wireless/scan.c:2909
 cfg80211_inform_bss_frame_data+0xbf/0x290 net/wireless/scan.c:2936
 ieee80211_bss_info_update+0x300/0x8f0 net/mac80211/scan.c:205
 ieee80211_rx_bss_info net/mac80211/ibss.c:1098 [inline]
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1577 [inline]
 ieee80211_ibss_rx_queued_mgmt+0x198a/0x3140 net/mac80211/ibss.c:1604
 ieee80211_iface_process_skb net/mac80211/iface.c:1589 [inline]
 ieee80211_iface_work+0xa67/0xda0 net/mac80211/iface.c:1643
 cfg80211_wiphy_work+0x24e/0x330 net/wireless/core.c:435
 process_one_work+0x8a4/0x15f0 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x8b6/0x1290 kernel/workqueue.c:2787
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>


Tested on:

commit:         8c9660f6 Add linux-next specific files for 20231124
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13446c06e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ca1e8655505e280
dashboard link: https://syzkaller.appspot.com/bug?extid=4da851837827326a7cd4
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=165e748ae80000


