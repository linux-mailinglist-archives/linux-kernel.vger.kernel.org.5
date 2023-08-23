Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36E3784FCA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 07:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbjHWFF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 01:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbjHWFF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 01:05:57 -0400
Received: from mail-pg1-f205.google.com (mail-pg1-f205.google.com [209.85.215.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBE1E57
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 22:05:55 -0700 (PDT)
Received: by mail-pg1-f205.google.com with SMTP id 41be03b00d2f7-564fa3b49e1so5620274a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 22:05:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692767155; x=1693371955;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8EYOZVLvlRuZv7TQU5HwS8/TUk4n+oYtzH2VL9bdkB4=;
        b=l+VJWcfpQ+j9tFbC7nCLj2NtYq7uFYM4JDyoq5SR0D7Da9DaFQClrOi+NG0m1e5fMY
         yVeoaOSVBY8IeaWiVGeQouoVyEzpVkC+2w7RUyiKg0X3jzaHKw2+6Xsyh3BLf803ZWcv
         0aCEoro5E1uzwjWjOf8E9w55rxhhRP3RphnPm9zti3dRMTlRxzuW1Uo3IehlufVoNPRX
         zjWhv6dzzYLHdi9MeQorXQgjovyN82CcmkX6DZantUwpvGxW5z21Ec7X3Mc3vVDZysqp
         mCBuXLyotZABxG63HaK2NrdsmKWfKoVUeiMRObF6OUmne3sMq3d5n1rcBLjGN9LC+Wve
         jsTg==
X-Gm-Message-State: AOJu0YxGr4SOyIPHklmClOIUBRLOF4VjN5WqNEprin0mI1193XUHX1jA
        rp9LtbqmQIyxt4cxRUb7/syNn3NpdlO8ho2tqlK6TDborYV4
X-Google-Smtp-Source: AGHT+IFhBrPHex9t/FWzMU+x63TBDxBs6D3YviHcnPcc/aqWrC9ItklUH766Q1lFWE2fj4XiqCwSeNeWUZK5ttKiSFva7/Ab23i8
MIME-Version: 1.0
X-Received: by 2002:a65:66c9:0:b0:564:4a9e:1b80 with SMTP id
 c9-20020a6566c9000000b005644a9e1b80mr2336511pgw.6.1692767155278; Tue, 22 Aug
 2023 22:05:55 -0700 (PDT)
Date:   Tue, 22 Aug 2023 22:05:55 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fa5b8c060390104f@google.com>
Subject: [syzbot] [net?] WARNING: suspicious RCU usage in inetdev_event
From:   syzbot <syzbot+c670c371a962d1334881@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    144e22e7569a selftests/net: Add log.txt and tools to .giti..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=1706640fa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aa796b6080b04102
dashboard link: https://syzkaller.appspot.com/bug?extid=c670c371a962d1334881
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c2b82060a69a/disk-144e22e7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5b660bbc0308/vmlinux-144e22e7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/243ca7530ae8/bzImage-144e22e7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c670c371a962d1334881@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
6.5.0-rc6-syzkaller-00144-g144e22e7569a #0 Not tainted
-----------------------------
include/linux/inetdevice.h:250 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
2 locks held by syz-executor.4/21034:
 #0: ffffffff8e47afb0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1077
 #1: ffffffff8e47b068 (genl_mutex){+.+.}-{3:3}, at: genl_lock net/netlink/genetlink.c:33 [inline]
 #1: ffffffff8e47b068 (genl_mutex){+.+.}-{3:3}, at: genl_rcv_msg+0x573/0x800 net/netlink/genetlink.c:1065

stack backtrace:
CPU: 0 PID: 21034 Comm: syz-executor.4 Not tainted 6.5.0-rc6-syzkaller-00144-g144e22e7569a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
 lockdep_rcu_suspicious+0x20c/0x3b0 kernel/locking/lockdep.c:6719
 __in_dev_get_rtnl include/linux/inetdevice.h:250 [inline]
 inetdev_event+0x444/0x1900 net/ipv4/devinet.c:1532
 notifier_call_chain+0xb6/0x3b0 kernel/notifier.c:93
 call_netdevice_notifiers_info+0xb9/0x130 net/core/dev.c:1962
 call_netdevice_notifiers_extack net/core/dev.c:2000 [inline]
 call_netdevice_notifiers net/core/dev.c:2014 [inline]
 dev_set_mtu_ext+0x1e8/0x5d0 net/core/dev.c:8664
 dev_set_mtu+0xb1/0x160 net/core/dev.c:8694
 batadv_update_min_mtu+0x6e/0x90 net/batman-adv/hard-interface.c:645
 batadv_netlink_set_mesh+0x7d8/0x14e0 net/batman-adv/netlink.c:498
 genl_family_rcv_msg_doit.isra.0+0x1ef/0x2d0 net/netlink/genetlink.c:970
 genl_family_rcv_msg net/netlink/genetlink.c:1050 [inline]
 genl_rcv_msg+0x559/0x800 net/netlink/genetlink.c:1067
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2549
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1078
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0x539/0x800 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x93c/0xe30 net/netlink/af_netlink.c:1914
 sock_sendmsg_nosec net/socket.c:725 [inline]
 sock_sendmsg+0xd9/0x180 net/socket.c:748
 ____sys_sendmsg+0x6ac/0x940 net/socket.c:2494
 ___sys_sendmsg+0x135/0x1d0 net/socket.c:2548
 __sys_sendmsg+0x117/0x1e0 net/socket.c:2577
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0093a7cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f00948330c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f0093b9bf80 RCX: 00007f0093a7cae9
RDX: 0000000000000000 RSI: 00000000200005c0 RDI: 0000000000000003
RBP: 00007f0093ac847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f0093b9bf80 R15: 00007ffdab8adf58
 </TASK>
------------[ cut here ]------------
RTNL: assertion failed at net/ipv4/devinet.c (1534)
WARNING: CPU: 1 PID: 21034 at net/ipv4/devinet.c:1534 inetdev_event+0x1142/0x1900 net/ipv4/devinet.c:1534
Modules linked in:
CPU: 1 PID: 21034 Comm: syz-executor.4 Not tainted 6.5.0-rc6-syzkaller-00144-g144e22e7569a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:inetdev_event+0x1142/0x1900 net/ipv4/devinet.c:1534
Code: 0f 85 d1 ef ff ff e8 2d 8c c7 f8 ba fe 05 00 00 48 c7 c6 60 62 8d 8b 48 c7 c7 a0 62 8d 8b c6 05 03 5a d7 05 01 e8 4e 4e 8e f8 <0f> 0b e9 a6 ef ff ff e8 02 8c c7 f8 4c 89 ef e8 da cb ff ff 48 c7
RSP: 0018:ffffc900068b7190 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000018 RCX: ffffc90014f77000
RDX: 0000000000040000 RSI: ffffffff814ccc86 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff88802d8fc340
R13: ffff88802d8fc000 R14: ffffffff8e550860 R15: 0000000000000000
FS:  00007f00948336c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2f964000 CR3: 0000000029d00000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 notifier_call_chain+0xb6/0x3b0 kernel/notifier.c:93
 call_netdevice_notifiers_info+0xb9/0x130 net/core/dev.c:1962
 call_netdevice_notifiers_extack net/core/dev.c:2000 [inline]
 call_netdevice_notifiers net/core/dev.c:2014 [inline]
 dev_set_mtu_ext+0x1e8/0x5d0 net/core/dev.c:8664
 dev_set_mtu+0xb1/0x160 net/core/dev.c:8694
 batadv_update_min_mtu+0x6e/0x90 net/batman-adv/hard-interface.c:645
 batadv_netlink_set_mesh+0x7d8/0x14e0 net/batman-adv/netlink.c:498
 genl_family_rcv_msg_doit.isra.0+0x1ef/0x2d0 net/netlink/genetlink.c:970
 genl_family_rcv_msg net/netlink/genetlink.c:1050 [inline]
 genl_rcv_msg+0x559/0x800 net/netlink/genetlink.c:1067
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2549
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1078
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0x539/0x800 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x93c/0xe30 net/netlink/af_netlink.c:1914
 sock_sendmsg_nosec net/socket.c:725 [inline]
 sock_sendmsg+0xd9/0x180 net/socket.c:748
 ____sys_sendmsg+0x6ac/0x940 net/socket.c:2494
 ___sys_sendmsg+0x135/0x1d0 net/socket.c:2548
 __sys_sendmsg+0x117/0x1e0 net/socket.c:2577
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0093a7cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f00948330c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f0093b9bf80 RCX: 00007f0093a7cae9
RDX: 0000000000000000 RSI: 00000000200005c0 RDI: 0000000000000003
RBP: 00007f0093ac847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f0093b9bf80 R15: 00007ffdab8adf58
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
