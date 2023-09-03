Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40421790A7F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 03:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235469AbjICBtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 21:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbjICBs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 21:48:59 -0400
Received: from mail-pj1-f79.google.com (mail-pj1-f79.google.com [209.85.216.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C8E131
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 18:48:56 -0700 (PDT)
Received: by mail-pj1-f79.google.com with SMTP id 98e67ed59e1d1-26d52dc97e3so264779a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 18:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693705736; x=1694310536;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vJf/Eooxdqn3wqXqB/Vii7TxecGvCAC/nj0JGOKvT0c=;
        b=Uj5QG8xu3Gz1Zw8w34fAxPQhoYgnAEpYRGcIX//aMZzXRF02+TCE3LISSlm49BAG9h
         g9QjhVXyWPk+i7csNTYZNy1G1/4odqL9AJy0TGXOfkYLCw5FQB/KcLtoB8IRENiG7qTC
         cs2d4zTSmk/J3u3hJwJBrgddiuGuaP3OrO/+XFcf5fKHHsiUw4tIP7V/78QoIEtLomR9
         772c99fHHTg0zF4oQWKt2AcF/ZUhUCUKcMOVk+p89rnE0aIgBITTQvkJf36ghcNJ+iPg
         Qjs55yPzDQS6Lz/8tScIu2VTzACRe1AQ80qplxbNRZ3xVAF3mrLfOKGa9p8bxt0iBmfN
         Y1pg==
X-Gm-Message-State: AOJu0YzKjlJpW4WS11WJyvk1E9CwgfMTKTopHglu8yd2WDCuRM2ckMDX
        WNQ3ZITbP7rhrDO1vWw5WTVBiDO8I2KzfWG9FucHEIhxtYyi
X-Google-Smtp-Source: AGHT+IEFEX6CFZNVFPeqX7v6f3QzzaPk9plI5xoyZwo92AT/6EpnmOualPivPJbgREY5sUP34UhQQQ2CeW9fEHhkVfvkuO0U+UYn
MIME-Version: 1.0
X-Received: by 2002:a17:90b:3d3:b0:26d:26eb:c577 with SMTP id
 go19-20020a17090b03d300b0026d26ebc577mr1478202pjb.6.1693705735819; Sat, 02
 Sep 2023 18:48:55 -0700 (PDT)
Date:   Sat, 02 Sep 2023 18:48:55 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bcd80b06046a98ac@google.com>
Subject: [syzbot] [wireless?] WARNING in ieee80211_link_release_channel
From:   syzbot <syzbot+9817a610349542589c42@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com,
        johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d68b4b6f307d Merge tag 'mm-nonmm-stable-2023-08-28-22-48' ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=147267b7a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c45ae22e154d76fa
dashboard link: https://syzkaller.appspot.com/bug?extid=9817a610349542589c42
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=128eab18680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/eaa3c711dd68/disk-d68b4b6f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3ed6d023ff63/vmlinux-d68b4b6f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cc05f8831f38/bzImage-d68b4b6f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9817a610349542589c42@syzkaller.appspotmail.com

RBP: 00007f64c7d70120 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 000000000000006e R14: 00007f64c719c050 R15: 00007f64c72bfa48
 </TASK>
wlan1: failed to insert STA entry for the AP (error -12)
------------[ cut here ]------------
WARNING: CPU: 0 PID: 7597 at net/mac80211/chan.c:2021 ieee80211_link_release_channel+0x19f/0x200 net/mac80211/chan.c:2021
Modules linked in:
CPU: 0 PID: 7597 Comm: syz-executor.5 Not tainted 6.5.0-syzkaller-04592-gd68b4b6f307d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:ieee80211_link_release_channel+0x19f/0x200 net/mac80211/chan.c:2021
Code: ff ff ff ff 48 8d b8 f0 1c 00 00 e8 3b 33 79 00 31 ff 41 89 c5 89 c6 e8 cf 7e c7 f7 45 85 ed 0f 85 6d ff ff ff e8 51 83 c7 f7 <0f> 0b e9 61 ff ff ff 48 c7 c7 d0 28 ad 8e e8 6e 2f 1d f8 e9 3a ff
RSP: 0018:ffffc9000a0d6b08 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88806730e3a8 RCX: 0000000000000000
RDX: ffff8880271ebb80 RSI: ffffffff89c00a5f RDI: 0000000000000005
RBP: ffff88806730cc80 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff88806730d580
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f64c7d706c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5579f1bff8 CR3: 0000000075757000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ieee80211_prep_connection+0x62a/0x14f0 net/mac80211/mlme.c:7065
 ieee80211_mgd_auth+0xa1a/0x1490 net/mac80211/mlme.c:7205
 rdev_auth net/wireless/rdev-ops.h:481 [inline]
 cfg80211_mlme_auth+0x551/0x910 net/wireless/mlme.c:289
 cfg80211_conn_do_work+0x64e/0xfe0 net/wireless/sme.c:181
 cfg80211_sme_connect net/wireless/sme.c:638 [inline]
 cfg80211_connect+0xf07/0x20c0 net/wireless/sme.c:1528
 nl80211_connect+0x13ef/0x1d50 net/wireless/nl80211.c:12018
 genl_family_rcv_msg_doit+0x1fc/0x2e0 net/netlink/genetlink.c:971
 genl_family_rcv_msg net/netlink/genetlink.c:1051 [inline]
 genl_rcv_msg+0x55c/0x800 net/netlink/genetlink.c:1066
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2545
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1075
 netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
 netlink_unicast+0x536/0x810 net/netlink/af_netlink.c:1368
 netlink_sendmsg+0x93c/0xe40 net/netlink/af_netlink.c:1910
 sock_sendmsg_nosec net/socket.c:728 [inline]
 sock_sendmsg+0xd9/0x180 net/socket.c:751
 ____sys_sendmsg+0x6ac/0x940 net/socket.c:2538
 ___sys_sendmsg+0x135/0x1d0 net/socket.c:2592
 __sys_sendmsg+0x117/0x1e0 net/socket.c:2621
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f64c707cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f64c7d700c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f64c719c050 RCX: 00007f64c707cae9
RDX: 0000000000000000 RSI: 00000000200001c0 RDI: 0000000000000003
RBP: 00007f64c7d70120 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 000000000000006e R14: 00007f64c719c050 R15: 00007f64c72bfa48
 </TASK>


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
