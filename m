Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C078E7C63D6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 06:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376943AbjJLEPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 00:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjJLEPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 00:15:52 -0400
Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB65A9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 21:15:50 -0700 (PDT)
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-57eeeb2f0f1so752230eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 21:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697084149; x=1697688949;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YBXoHOkqUGg4RWo2K6wfFEtoxqhmWk9b2QZG2FiUpXg=;
        b=VMCcH1CRYwbevxM40fL5eOimrhHbxY9qzBVpw1fMy6IMoX+vvKUBjlyXQdNBz4BmgK
         2tsKhdMYualKh7F96XzWiSrGcSjxNNHmKB0rSiCwj6jBxhO/GV+821K+XOH/FjY8LuSx
         OBSyg7Pb7+3mGfszk9wEZDZBD27/0HU6trmd/JER0shNkCh/IqR9QEnr4nojMKjKf6Y9
         rVGc0xBeiDyBZHSQhJL6DTujfB/4PR6fIpk9Ds3yl35FfyhoShlK6hObc0h4XPzEAdAg
         5lkgqpgzsmd/2vOoX4uIo/qYg661qqI1fWwEbxZ5SODMPuaAu4rQZdskSMu+oy1ffxBa
         wUXw==
X-Gm-Message-State: AOJu0Yxgzri/N+qVNuRNfgu0/c4BnAnDxW4P1xbe93eKv5Uy8cQaMJbd
        cpM78uxUTMY50icp4mLnobk9mkfDsvamX3J+W+ef7LmTz6y9
X-Google-Smtp-Source: AGHT+IGxfSmy4bmlPTVE+Ei+zINCJ9Vj+G1r/fk3veqYglPpXzhkLnEQGfxyZ5ray6FlsmRKU8AFs5aPi60UKFaI5LDf+n6CXtVt
MIME-Version: 1.0
X-Received: by 2002:a4a:33c8:0:b0:57b:6d64:b425 with SMTP id
 q191-20020a4a33c8000000b0057b6d64b425mr7040220ooq.1.1697084149575; Wed, 11
 Oct 2023 21:15:49 -0700 (PDT)
Date:   Wed, 11 Oct 2023 21:15:49 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e3ba3806077d3110@google.com>
Subject: [syzbot] [net?] [wireless?] possible deadlock in ieee80211_change_mac
From:   syzbot <syzbot+25b3a0b24216651bc2af@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com,
        johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    48533eca606e net: sock_dequeue_err_skb() optimization
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=134bea0e680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37e6eb4526c4e801
dashboard link: https://syzkaller.appspot.com/bug?extid=25b3a0b24216651bc2af
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b31e70149a77/disk-48533eca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e85019d639e1/vmlinux-48533eca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4f699a5f4501/bzImage-48533eca.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+25b3a0b24216651bc2af@syzkaller.appspotmail.com

bond3: (slave wlan1): Releasing backup interface
============================================
WARNING: possible recursive locking detected
6.6.0-rc4-syzkaller-01096-g48533eca606e #0 Not tainted
--------------------------------------------
kworker/u4:20/1920 is trying to acquire lock:
ffff888029960768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: wiphy_lock include/net/cfg80211.h:5870 [inline]
ffff888029960768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: ieee80211_change_mac+0x8c/0x13a0 net/mac80211/iface.c:301

but task is already holding lock:
ffff888029960768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: wiphy_lock include/net/cfg80211.h:5870 [inline]
ffff888029960768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: ieee80211_remove_interfaces+0xfe/0x750 net/mac80211/iface.c:2253

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&rdev->wiphy.mtx);
  lock(&rdev->wiphy.mtx);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

5 locks held by kworker/u4:20/1920:
 #0: ffff888012c73d38 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work+0x787/0x15c0 kernel/workqueue.c:2605
 #1: ffffc9000fa5fd80 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work+0x7e9/0x15c0 kernel/workqueue.c:2606
 #2: ffffffff8e5eedd0 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0x9f/0xb20 net/core/net_namespace.c:576
 #3: ffffffff8e6040e8 (rtnl_mutex){+.+.}-{3:3}, at: ieee80211_unregister_hw+0x4d/0x3a0 net/mac80211/main.c:1486
 #4: ffff888029960768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: wiphy_lock include/net/cfg80211.h:5870 [inline]
 #4: ffff888029960768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: ieee80211_remove_interfaces+0xfe/0x750 net/mac80211/iface.c:2253

stack backtrace:
CPU: 1 PID: 1920 Comm: kworker/u4:20 Not tainted 6.6.0-rc4-syzkaller-01096-g48533eca606e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 check_deadlock kernel/locking/lockdep.c:3062 [inline]
 validate_chain kernel/locking/lockdep.c:3855 [inline]
 __lock_acquire+0x2971/0x5de0 kernel/locking/lockdep.c:5136
 lock_acquire kernel/locking/lockdep.c:5753 [inline]
 lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5718
 __mutex_lock_common kernel/locking/mutex.c:603 [inline]
 __mutex_lock+0x181/0x1340 kernel/locking/mutex.c:747
 wiphy_lock include/net/cfg80211.h:5870 [inline]
 ieee80211_change_mac+0x8c/0x13a0 net/mac80211/iface.c:301
 dev_set_mac_address+0x303/0x4a0 net/core/dev.c:8855
 __bond_release_one+0xb1b/0x17e0 drivers/net/bonding/bond_main.c:2504
 bond_slave_netdev_event drivers/net/bonding/bond_main.c:3888 [inline]
 bond_netdev_event+0xbab/0xd30 drivers/net/bonding/bond_main.c:4006
 notifier_call_chain+0xb6/0x3b0 kernel/notifier.c:93
 call_netdevice_notifiers_info+0xb9/0x130 net/core/dev.c:1970
 call_netdevice_notifiers_extack net/core/dev.c:2008 [inline]
 call_netdevice_notifiers net/core/dev.c:2022 [inline]
 unregister_netdevice_many_notify+0x85f/0x1a20 net/core/dev.c:10960
 unregister_netdevice_many net/core/dev.c:11016 [inline]
 unregister_netdevice_queue+0x2e5/0x3c0 net/core/dev.c:10896
 unregister_netdevice include/linux/netdevice.h:3116 [inline]
 _cfg80211_unregister_wdev+0x61c/0x7e0 net/wireless/core.c:1204
 ieee80211_remove_interfaces+0x36d/0x750 net/mac80211/iface.c:2278
 ieee80211_unregister_hw+0x55/0x3a0 net/mac80211/main.c:1493
 mac80211_hwsim_del_radio drivers/net/wireless/virtual/mac80211_hwsim.c:5410 [inline]
 hwsim_exit_net+0x3a8/0x7d0 drivers/net/wireless/virtual/mac80211_hwsim.c:6287
 ops_exit_list+0xb0/0x170 net/core/net_namespace.c:170
 cleanup_net+0x505/0xb20 net/core/net_namespace.c:614
 process_one_work+0x884/0x15c0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>


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
