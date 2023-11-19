Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D8C7F0596
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 12:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjKSLLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 06:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjKSLLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 06:11:10 -0500
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B7FC4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 03:11:07 -0800 (PST)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6bd00edc63fso5534908b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 03:11:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700392267; x=1700997067;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rdsO4AUnITD9PoozWHMmzjMt0xhalvGcMRxOJEUTZ2w=;
        b=MAgPFaZuKuEuVx5/FXlFYf4Yyql2pYNxTyNGvI0uKu2cFX89ETgI3/Hs0a53HusTAq
         EHwHbSw2kIpukAJhHEis7GDI0dvMxWsXzx9Q5eT3XeIGNxK22uyBbXys+iTROT+SwV8F
         /ZATQsdAAeYWFUhWd9kDhkpOIT7E3VGdhpdRnbvkLs/9+eO+L2GWwdKmpVrSXyHHtt+V
         gizOeuM2xapo3zoln08DHiiFfYqGfDxY4eivwur0d3ayb47q0AKRB9Avn5nCtm9VRjQC
         eDEhHbebYYW8zhtFJdP9AvT6Pmgm93nuvibF5eKOi3hRdHrVMoeAtbrZ8NXuqTucyMlb
         NNjw==
X-Gm-Message-State: AOJu0YxefllFxrwvzicAvBAXo0cwA1A4p0FXotV/iaSzv1zf+TzbkmCo
        g4UllVsW9NMbx/Hd3B8/7jnrpfr13KM3kGSI8qOzhON/UkP5
X-Google-Smtp-Source: AGHT+IGnzU80hHnsaWyBZPB8k2oQ6Lc8GCmOXquYPS1EEyaiR6S9w65xq+nv7IbTzq6gCYGTz201ryZXIdcnjR4wJdua5jV1g14x
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:301d:b0:6c6:aaa4:5da8 with SMTP id
 ay29-20020a056a00301d00b006c6aaa45da8mr1207856pfb.3.1700392267141; Sun, 19
 Nov 2023 03:11:07 -0800 (PST)
Date:   Sun, 19 Nov 2023 03:11:06 -0800
In-Reply-To: <20231119103215.698030-1-eadavis@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000fd93f060a7f6d47@google.com>
Subject: Re: [syzbot] [netfilter?] WARNING in __nf_unregister_net_hook (6)
From:   syzbot <syzbot+de4025c006ec68ac56fc@syzkaller.appspotmail.com>
To:     eadavis@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in __nf_unregister_net_hook

------------[ cut here ]------------
hook not found, pf 2 num 1
WARNING: CPU: 1 PID: 6126 at net/netfilter/core.c:517 __nf_unregister_net_hook+0x1de/0x670 net/netfilter/core.c:517
Modules linked in:

CPU: 1 PID: 6126 Comm: syz-executor.1 Not tainted 6.6.0-rc3-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
RIP: 0010:__nf_unregister_net_hook+0x1de/0x670 net/netfilter/core.c:517
Code: 14 02 4c 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 7a 04 00 00 8b 53 1c 48 c7 c7 c0 d4 a8 8b 8b 74 24 04 e8 b2 ce dc f8 <0f> 0b e9 ec 00 00 00 e8 46 a5 16 f9 48 89 e8 48 c1 e0 04 49 8d 7c
RSP: 0018:ffffc9000378f2b8 EFLAGS: 00010282

RAX: 0000000000000000 RBX: ffff88805fc88800 RCX: 0000000000000000
RDX: ffff88801db5c200 RSI: ffffffff814cf016 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: fffffffffffddb78 R12: ffff888029249250
R13: ffff888064376598 R14: ffff888064376500 R15: ffff88805fc8881c
FS:  00007f560e44d6c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055555691d938 CR3: 0000000063604000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 nf_unregister_net_hook+0xd5/0x110 net/netfilter/core.c:539
 __nf_tables_unregister_hook net/netfilter/nf_tables_api.c:361 [inline]
 __nf_tables_unregister_hook+0x1a0/0x220 net/netfilter/nf_tables_api.c:340
 nf_tables_unregister_hook net/netfilter/nf_tables_api.c:368 [inline]
 nf_tables_commit+0x410f/0x59f0 net/netfilter/nf_tables_api.c:9992
 nfnetlink_rcv_batch+0xf36/0x2500 net/netfilter/nfnetlink.c:569
 nfnetlink_rcv_skb_batch net/netfilter/nfnetlink.c:639 [inline]
 nfnetlink_rcv+0x3bf/0x430 net/netfilter/nfnetlink.c:657
 netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
 netlink_unicast+0x536/0x810 net/netlink/af_netlink.c:1368
 netlink_sendmsg+0x93c/0xe40 net/netlink/af_netlink.c:1910
 sock_sendmsg_nosec net/socket.c:730 [inline]
 sock_sendmsg+0xd9/0x180 net/socket.c:753
 ____sys_sendmsg+0x6ac/0x940 net/socket.c:2541
 ___sys_sendmsg+0x135/0x1d0 net/socket.c:2595
 __sys_sendmsg+0x117/0x1e0 net/socket.c:2624
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f560d67cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f560e44d0c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f560d79c050 RCX: 00007f560d67cae9
RDX: 0000000000000000 RSI: 000000002000c2c0 RDI: 0000000000000004
RBP: 00007f560d6c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f560d79c050 R15: 00007fffbdf48218
 </TASK>


Tested on:

commit:         6465e260 Linux 6.6-rc3
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=104a2e24e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d7d7928f78936aa
dashboard link: https://syzkaller.appspot.com/bug?extid=de4025c006ec68ac56fc
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11b643d4e80000

