Return-Path: <linux-kernel+bounces-2141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 097DD815871
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 09:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57FC11F24248
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 08:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9A714005;
	Sat, 16 Dec 2023 08:41:06 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DF112B85
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 08:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7b764f195f7so177273739f.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 00:41:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702716064; x=1703320864;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xR4iP/uJpQuLq8JRipUo+qrMjWtQc9AeQ3CpJmJLggQ=;
        b=dVJRpq/9gES4N3JgjfgTuHkoJs7E2gS0ndI5S+y3LGYyIueGk0BXAxOpxUcDHQbHM3
         utmCkkBfLL/slGSnqEAEo75Ood7+ifxCU16W+u6EBo6RVjB9K+hLEmoPfpKa6OtuaYCW
         8i9pgp8VeqhpbdgGtxmLmYBy8zVFz4AlOnuH60Va48hXtKnJx/uW2TkAmtOTXXSJQxp8
         hQkYaToSLD+SSBi4Iu4LL/pAKETU00XA2DtMWYKsHPYBXk4mU+m6Lsd5a52Wy3+yLd36
         09v6j25UqyMotg47Oa4m7NSoKyF1/mborObf6EZcgOPTLCLQ0eJ/4FZH7qKpi/5F1KZp
         Y+OA==
X-Gm-Message-State: AOJu0YzBG0t5pUkvF5W9p+l0QsFLK7AH58IlfzbSJaOjq9OKdfzfbpHd
	GX9JIkCY3fojI5NQ+POMwgHHSromqwYtPJWXVnqvS6YgSYML
X-Google-Smtp-Source: AGHT+IERYlnL4pYUd4kusQxor02mLMh5EUZ6oJmY6EbFzBCf4LKeMJCGO9JLGakHGUuZn6i0oPrWHpOadzQK0ZOdsAbmCcw3xfqd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5d:85c1:0:b0:7b7:652a:7499 with SMTP id
 e1-20020a5d85c1000000b007b7652a7499mr251912ios.0.1702716064119; Sat, 16 Dec
 2023 00:41:04 -0800 (PST)
Date: Sat, 16 Dec 2023 00:41:04 -0800
In-Reply-To: <tencent_9E4FE88DAB25DF0DED9279DDA9DD94196D07@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000027c2bb060c9c7ad9@google.com>
Subject: Re: [syzbot] [block?] INFO: task hung in bdev_release
From: syzbot <syzbot+4da851837827326a7cd4@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in bdev_release

INFO: task syz-executor.0:5863 blocked for more than 143 seconds.
      Not tainted 6.7.0-rc2-next-20231124-syzkaller-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:28560 pid:5863  tgid:5860  ppid:5422   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5399 [inline]
 __schedule+0xf15/0x5c00 kernel/sched/core.c:6726
 __schedule_loop kernel/sched/core.c:6801 [inline]
 schedule+0xe7/0x270 kernel/sched/core.c:6816
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6873
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x5b4/0x9c0 kernel/locking/mutex.c:747
 bdev_release+0xe6/0xac0 block/bdev.c:979
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
RIP: 0033:0x7fa439e7cae9
RSP: 002b:00007fa43ab210c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: 0000000000000000 RBX: 00007fa439f9c120 RCX: 00007fa439e7cae9
RDX: 0000000000000000 RSI: 000000000000ab03 RDI: 0000000000000005
RBP: 00007fa439ec847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007fa439f9c120 R15: 00007ffcbfcf7228
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/29:
 #0: ffffffff8cfacf60 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
 #0: ffffffff8cfacf60 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:747 [inline]
 #0: ffffffff8cfacf60 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6613
1 lock held by klogd/4501:
 #0: ffff8880b983c718 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:558
2 locks held by getty/4814:
 #0: ffff88802b0ea0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfc4/0x1490 drivers/tty/n_tty.c:2201
1 lock held by udevd/5406:
 #0: ffff888143f624c8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_open_by_dev+0x2a4/0xf80 block/bdev.c:860
1 lock held by syz-executor.0/5863:
 #0: ffff888143f624c8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_release+0xe6/0xac0 block/bdev.c:979
1 lock held by syz-executor.0/5879:
 #0: ffff888143f624c8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_open_by_dev+0x2a4/0xf80 block/bdev.c:860
1 lock held by syz-executor.0/5901:
 #0: ffff888143f624c8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_open_by_dev+0x2a4/0xf80 block/bdev.c:860

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
CPU: 1 PID: 2803 Comm: kworker/u4:8 Not tainted 6.7.0-rc2-next-20231124-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:__sanitizer_cov_trace_pc+0x18/0x60 kernel/kcov.c:203
Code: ff ff 31 c0 c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa 65 48 8b 15 a4 aa 7b 7e 65 8b 05 a5 aa 7b 7e a9 00 01 ff 00 <48> 8b 34 24 74 0f f6 c4 01 74 35 8b 82 fc 15 00 00 85 c0 74 2b 8b
RSP: 0018:ffffc9000aedf6b8 EFLAGS: 00000246
RAX: 0000000080000000 RBX: 0000000000000006 RCX: ffffffff8a06b051
RDX: ffff888027ccd940 RSI: 00000000000000f4 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 00000000000000f4
R10: 0000000000000000 R11: 0000000000000003 R12: ffff88804fa52d74
R13: ffff88804fa52d75 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555556ea5938 CR3: 000000001c3ba000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 _ieee802_11_parse_elems_full+0x77d/0x3b70 net/mac80211/util.c:1094
 ieee802_11_parse_elems_full+0x7f5/0x13a0 net/mac80211/util.c:1647
 ieee802_11_parse_elems_crc net/mac80211/ieee80211_i.h:2288 [inline]
 ieee802_11_parse_elems net/mac80211/ieee80211_i.h:2295 [inline]
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1573 [inline]
 ieee80211_ibss_rx_queued_mgmt+0xd41/0x3140 net/mac80211/ibss.c:1604
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
console output: https://syzkaller.appspot.com/x/log.txt?x=151fd5b2e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ca1e8655505e280
dashboard link: https://syzkaller.appspot.com/bug?extid=4da851837827326a7cd4
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14a70b56e80000


