Return-Path: <linux-kernel+bounces-2176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20738815906
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 13:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4538C1C21714
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 12:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3434B18EB7;
	Sat, 16 Dec 2023 12:33:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5602C18EA1
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 12:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-35d36f83b3fso17330285ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 04:33:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702729984; x=1703334784;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f2J091v2BOSao/gT1JQTEZBg7RwnQFOSEWFzfwHlPSM=;
        b=GiBkgr4ePxArC93KiA/nk0L2SVG6odpM2VHnrfugqs2CEDs5IfGzKYCpEt+DjljdeA
         Y8bzjGjEIHNvY25jU9WCilItzc9PML8n+Exh21idmtpkxai2u0dD0glI1KsIYiD38EzH
         GyBrLLlGDQ3ZeE9PwbbeiBtnrFoupne4BChWVuOvkPePai9EOegkRmUHI195cwwHJoKr
         uV3wo3C33GhCwpUF1eExRtxasJIccMoG8ozFLNGCiUsrSgOH5wHKEwJPO2iIEh1nuPeW
         NC/+lrL8bwjUfnbYBG8jPhI6Rbd8RZUNRnsT96EppIcBKPS4hKqRd0ldCb5kJdGSTI57
         n62A==
X-Gm-Message-State: AOJu0YyJcYen6CqJcmjJAY04uYY5/EKTwFdTXLmutXAku2GmFBeBcner
	JnXdsV35XQdwLjYv5wpET26Zr7WHdf+a4kUq7+vu0w8JYBuH
X-Google-Smtp-Source: AGHT+IG/qlTkhcv6CnrqLiWyz/4TRjAJbLuuB7hkk8i60/YnpCJtwgMrllUieBP4MtzakDtuFzM/h2YELVWxEM1DJYzt95vNAItr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b05:b0:35d:a84e:f728 with SMTP id
 i5-20020a056e021b0500b0035da84ef728mr510146ilv.3.1702729984564; Sat, 16 Dec
 2023 04:33:04 -0800 (PST)
Date: Sat, 16 Dec 2023 04:33:04 -0800
In-Reply-To: <tencent_956C25D8BA0BBB79331B9E4D1B254B751B08@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e0eb55060c9fb76a@google.com>
Subject: Re: [syzbot] [block?] INFO: task hung in bdev_release
From: syzbot <syzbot+4da851837827326a7cd4@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in bdev_release

INFO: task syz-executor.0:5482 blocked for more than 143 seconds.
      Not tainted 6.7.0-rc2-next-20231124-syzkaller-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:27872 pid:5482  tgid:5481  ppid:5420   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5399 [inline]
 __schedule+0xf15/0x5c00 kernel/sched/core.c:6726
 __schedule_loop kernel/sched/core.c:6801 [inline]
 schedule+0xe7/0x270 kernel/sched/core.c:6816
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6873
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x5b4/0x9c0 kernel/locking/mutex.c:747
 bdev_release+0xe6/0xac0 block/bdev.c:970
 blkdev_release+0x37/0x50 block/fops.c:616
 __fput+0x270/0xbb0 fs/file_table.c:394
 task_work_run+0x14c/0x240 kernel/task_work.c:180
 get_signal+0x105a/0x2770 kernel/signal.c:2669
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:309
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11e/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x1e/0x60 kernel/entry/common.c:296
 do_syscall_64+0x4d/0x110 arch/x86/entry/common.c:88
 entry_SYSCALL_64_after_hwframe+0x62/0x6a
RIP: 0033:0x7f175807cae9
RSP: 002b:00007f1758e0c0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: 0000000000000000 RBX: 00007f175819bf80 RCX: 00007f175807cae9
RDX: 0000000000000000 RSI: 000000000000ab03 RDI: 0000000000000005
RBP: 00007f17580c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f175819bf80 R15: 00007fff4338e6d8
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/29:
 #0: ffffffff8cfacf60 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
 #0: ffffffff8cfacf60 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:747 [inline]
 #0: ffffffff8cfacf60 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6613
5 locks held by kworker/u4:5/135:
1 lock held by klogd/4502:
2 locks held by getty/4814:
 #0: ffff888026fee0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfc4/0x1490 drivers/tty/n_tty.c:2201
1 lock held by udevd/5408:
 #0: ffff88801d6e54c8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_open_by_dev+0x27c/0xf20 block/bdev.c:857
1 lock held by syz-executor.0/5482:
 #0: ffff88801d6e54c8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_release+0xe6/0xac0 block/bdev.c:970
1 lock held by syz-executor.0/5794:
 #0: ffff88801d6e54c8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_open_by_dev+0x27c/0xf20 block/bdev.c:857
1 lock held by syz-executor.0/5810:
 #0: ffff88801d6e54c8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_open_by_dev+0x27c/0xf20 block/bdev.c:857

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 29 Comm: khungtaskd Not tainted 6.7.0-rc2-next-20231124-syzkaller-dirty #0
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
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 34 Comm: kworker/u4:2 Not tainted 6.7.0-rc2-next-20231124-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4704 [inline]
RIP: 0010:__lock_acquire+0x1063/0x3b10 kernel/locking/lockdep.c:5086
Code: 08 84 d2 0f 85 4b 28 00 00 44 8b 25 6b 2d b1 0d 45 85 e4 0f 84 f6 17 00 00 90 e9 a9 fe ff ff 41 bf 02 00 00 00 e9 30 f5 ff ff <31> db e9 d1 f4 ff ff 8b 4c 24 08 49 8d 5e 22 85 c9 0f 85 53 f8 ff
RSP: 0018:ffffc90000aaf200 EFLAGS: 00000046
RAX: 0000000000000001 RBX: 00000000ffffffff RCX: 0000000000000001
RDX: 0000000000000000 RSI: 1ffff11002a5ec7f RDI: ffff8880152f5940
RBP: dffffc0000000000 R08: 0000000000000004 R09: fffffbfff23e49e8
R10: ffffffff91f24f47 R11: 0000000000000004 R12: ffff8880152f63f9
R13: ffff8880152f6400 R14: ffff8880152f64a0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe3c726fa0 CR3: 000000000cd78000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 lock_acquire kernel/locking/lockdep.c:5753 [inline]
 lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
 rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
 rcu_read_lock include/linux/rcupdate.h:747 [inline]
 pfn_valid include/linux/mmzone.h:2028 [inline]
 __virt_addr_valid+0x199/0x580 arch/x86/mm/physaddr.c:65
 kasan_addr_to_slab+0xd/0x80 mm/kasan/common.c:36
 __kasan_record_aux_stack+0xe/0xd0 mm/kasan/generic.c:492
 kvfree_call_rcu+0x70/0xbe0 kernel/rcu/tree.c:3400
 cfg80211_update_known_bss+0x802/0xa60 net/wireless/scan.c:1783
 __cfg80211_bss_update+0x1ba/0x24b0 net/wireless/scan.c:1827
 cfg80211_inform_single_bss_frame_data+0x771/0xf40 net/wireless/scan.c:2905
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
console output: https://syzkaller.appspot.com/x/log.txt?x=16e7da1ee80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ca1e8655505e280
dashboard link: https://syzkaller.appspot.com/bug?extid=4da851837827326a7cd4
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10f501e1e80000


