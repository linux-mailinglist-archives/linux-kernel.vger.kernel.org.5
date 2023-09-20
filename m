Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01737A8B07
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 20:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjITSDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 14:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjITSDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 14:03:01 -0400
Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2E9A3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 11:02:55 -0700 (PDT)
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-3acfa8f8df3so119538b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 11:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695232975; x=1695837775;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5teg6OFj1pXhxaX7rzqqapjXA/AqJ3+972X/yqDBJ5k=;
        b=X0kxQZcogdG57vlLuPMHK4Fxdm5epqZpJf2ZaxE7m8HSGwxWo17IwIaWT6GQ6Ce5Q7
         8R19vPEtD2mgB45cmwxR7akxZ9KKyqJduWfJwK9R+lPxHaSMOy7JxlqZp+onuWxpRYSK
         FiuYYxtnoJdac8gSisCDpvItFguB0+3ydZioVvzubAUSZUSXD0nNbwt8wWRPmHD7IFLq
         QOBdDHD3QTj5LRGULD1TVp3Q0zwPhvWU2Yw09zwt8DZZ9OcsABnW/KShJOTANT2QVswr
         f3m8/VZqDRW3W4RCnGNPrdetqKtlEGbPpOoYgFr0Ve9RTdz6HlQbfr2R++p7edeZ/mEa
         qO9w==
X-Gm-Message-State: AOJu0YylPd2lkPTmTX2Q78E+kh6G8zBeiQ7R5cB6/hKMkYSl8ySs4DLM
        1Qm4ngL/guLA780s4K/0ui/qZftKpdsUZcCjEMScXHhBdCWp
X-Google-Smtp-Source: AGHT+IGoe5uqnvjbQP57E1f0/PkNymIgtUSx1BPpiQbSFRMO0t4C0JJlxF8jfjvKAn8EyN0LbsNFwNbYzxagQ4Xwa4hqZEgXWJga
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3026:b0:3a8:41a7:eafc with SMTP id
 ay38-20020a056808302600b003a841a7eafcmr1573311oib.7.1695232975148; Wed, 20
 Sep 2023 11:02:55 -0700 (PDT)
Date:   Wed, 20 Sep 2023 11:02:55 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004ba00e0605ce2fcf@google.com>
Subject: [syzbot] [net?] WARNING in inet_csk_get_port (2)
From:   syzbot <syzbot+71e724675ba3958edb31@syzkaller.appspotmail.com>
To:     avagin@gmail.com, davem@davemloft.net, dsahern@kernel.org,
        edumazet@google.com, kuba@kernel.org, kuniyu@amazon.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    2cf0f7156238 Merge tag 'nfs-for-6.6-2' of git://git.linux-..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17405ab0680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d594086f139d167
dashboard link: https://syzkaller.appspot.com/bug?extid=71e724675ba3958edb31
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16b2e118680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=127b55c4680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/456b02029fa8/disk-2cf0f715.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9f9ff0c00454/vmlinux-2cf0f715.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0ede19fba30f/bzImage-2cf0f715.xz

The issue was bisected to:

commit c48ef9c4aed3632566b57ba66cec6ec78624d4cb
Author: Kuniyuki Iwashima <kuniyu@amazon.com>
Date:   Mon Sep 11 18:36:57 2023 +0000

    tcp: Fix bind() regression for v4-mapped-v6 non-wildcard address.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15567dc4680000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17567dc4680000
console output: https://syzkaller.appspot.com/x/log.txt?x=13567dc4680000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+71e724675ba3958edb31@syzkaller.appspotmail.com
Fixes: c48ef9c4aed3 ("tcp: Fix bind() regression for v4-mapped-v6 non-wildcard address.")

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5049 at net/ipv4/inet_connection_sock.c:587 inet_csk_get_port+0xf96/0x2350 net/ipv4/inet_connection_sock.c:587
Modules linked in:
CPU: 0 PID: 5049 Comm: syz-executor288 Not tainted 6.6.0-rc2-syzkaller-00018-g2cf0f7156238 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
RIP: 0010:inet_csk_get_port+0xf96/0x2350 net/ipv4/inet_connection_sock.c:587
Code: 7c 24 08 e8 4c b6 8a 01 31 d2 be 88 01 00 00 48 c7 c7 e0 94 ae 8b e8 59 2e a3 f8 2e 2e 2e 31 c0 e9 04 fe ff ff e8 ca 88 d0 f8 <0f> 0b e9 0f f9 ff ff e8 be 88 d0 f8 49 8d 7e 48 e8 65 ca 5a 00 31
RSP: 0018:ffffc90003abfbf0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888026429100 RCX: 0000000000000000
RDX: ffff88807edcbb80 RSI: ffffffff88b73d66 RDI: ffff888026c49f38
RBP: ffff888026c49f30 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffffff9260f200
R13: ffff888026c49880 R14: 0000000000000000 R15: ffff888026429100
FS:  00005555557d5380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000045ad50 CR3: 0000000025754000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 inet_csk_listen_start+0x155/0x360 net/ipv4/inet_connection_sock.c:1256
 __inet_listen_sk+0x1b8/0x5c0 net/ipv4/af_inet.c:217
 inet_listen+0x93/0xd0 net/ipv4/af_inet.c:239
 __sys_listen+0x194/0x270 net/socket.c:1866
 __do_sys_listen net/socket.c:1875 [inline]
 __se_sys_listen net/socket.c:1873 [inline]
 __x64_sys_listen+0x53/0x80 net/socket.c:1873
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f3a5bce3af9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc1a1c79e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000032
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f3a5bce3af9
RDX: 00007f3a5bce3af9 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007f3a5bd565f0 R08: 0000000000000006 R09: 0000000000000006
R10: 0000000000000006 R11: 0000000000000246 R12: 0000000000000001
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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
