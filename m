Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1912577B02A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 05:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbjHNDe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 23:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbjHNDdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 23:33:39 -0400
Received: from mail-pj1-f80.google.com (mail-pj1-f80.google.com [209.85.216.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4111BC8
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 20:32:48 -0700 (PDT)
Received: by mail-pj1-f80.google.com with SMTP id 98e67ed59e1d1-26b362e4141so3085949a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 20:32:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691983967; x=1692588767;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+cylwmDNW7JKQ6N6AHEkHm5tFBbzoC/Jb4px0DmBX8w=;
        b=Az9/3N8YJmHJQqFZ2xScS0OwLytGxwwJq4j3NZW0+3ASyIsx69dX+fwfLuYrsxa4cj
         mLCbi3XFfqbzzbx+zBeb4+OtWoFXM4+1bqQS77Cg/BERgnem0UMpDEwK0bFaMUu4DKkl
         OZzaRlm85VQrFegyDtqqJp+ND7JxEQYJh5Ait75168DX9cvq8Wmdy3q0TsLX6RRbzEQD
         r08v7uX5AbstoeJwmdwQ3cRbNlIrpLOn8Jelk7M5Amzvfc8tYY/iBfs4MqAywIlkdmF5
         XOUWCMr8SMuuvSYHKxx91CSWR+dJ/H0wysTyrff9LoqxzpCt61RAZI05lzwTeOhlbnGS
         kT6Q==
X-Gm-Message-State: AOJu0YxQNRI7dCcwkZRtGfjPSVZDhEoNEUZn4ujKYQZZe5UuA2um6WsZ
        2jhSrLiHLktXjBgloVwH8L8li5k4H1NG3auCvGnHPfohCIRL
X-Google-Smtp-Source: AGHT+IF3hEKWeg6Nn7BUbVcgrMEiMZ6b+TxzHlqPUoCaVcZRs5GQmTy9JjgReKIT1K/+An2otTENkaPYri5UqrjT6i5O1wrLSQoc
MIME-Version: 1.0
X-Received: by 2002:a17:90a:9907:b0:269:3c79:9b15 with SMTP id
 b7-20020a17090a990700b002693c799b15mr1973060pjp.5.1691983967680; Sun, 13 Aug
 2023 20:32:47 -0700 (PDT)
Date:   Sun, 13 Aug 2023 20:32:47 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005bfece0602d9b7c8@google.com>
Subject: [syzbot] [net?] WARNING in ip_tunnel_delete_nets (2)
From:   syzbot <syzbot+b7a5f4ad84b87ee1b3ae@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
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

HEAD commit:    2ccdd1b13c59 Linux 6.5-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16e56ef7a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8fc59e2140295873
dashboard link: https://syzkaller.appspot.com/bug?extid=b7a5f4ad84b87ee1b3ae
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e6e598627dd6/disk-2ccdd1b1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/486c6739d779/vmlinux-2ccdd1b1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5da0f3ac1d56/bzImage-2ccdd1b1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b7a5f4ad84b87ee1b3ae@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 18960 at net/core/dev.c:10876 unregister_netdevice_many_notify+0x14d8/0x19a0 net/core/dev.c:10876
Modules linked in:
CPU: 0 PID: 18960 Comm: kworker/u4:2 Not tainted 6.5.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Workqueue: netns cleanup_net
RIP: 0010:unregister_netdevice_many_notify+0x14d8/0x19a0 net/core/dev.c:10876
Code: b4 1a 00 00 48 c7 c6 e0 0e 81 8b 48 c7 c7 20 0f 81 8b c6 05 11 62 6c 06 01 e8 44 21 23 f9 0f 0b e9 64 f7 ff ff e8 d8 5f 5c f9 <0f> 0b e9 3b f7 ff ff e8 cc 8f af f9 e9 fc ec ff ff 4c 89 e7 e8 1f
RSP: 0018:ffffc900002cfa28 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 000000007cf48c01 RCX: 0000000000000000
RDX: ffff8880391ba080 RSI: ffffffff8828c0e8 RDI: 0000000000000001
RBP: ffff888077db4000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 000000000000004e R12: ffff88802380c900
R13: 0000000000000000 R14: 0000000000000002 R15: ffff88802380c900
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c001ac9010 CR3: 000000001ea93000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ip_tunnel_delete_nets+0x2bb/0x3a0 net/ipv4/ip_tunnel.c:1144
 ops_exit_list+0x125/0x170 net/core/net_namespace.c:175
 cleanup_net+0x505/0xb20 net/core/net_namespace.c:614
 process_one_work+0xaa2/0x16f0 kernel/workqueue.c:2600
 worker_thread+0x687/0x1110 kernel/workqueue.c:2751
 kthread+0x33a/0x430 kernel/kthread.c:389
 ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
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

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
