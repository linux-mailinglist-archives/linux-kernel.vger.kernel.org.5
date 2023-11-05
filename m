Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747777E1252
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 06:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjKEFQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 01:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjKEFQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 01:16:12 -0400
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345B6E3
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 22:16:10 -0700 (PDT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3b3e82429edso5175494b6e.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 22:16:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699161369; x=1699766169;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AWykN8ce09rpORiv6KAQ9pRiGSUFEB4y71TJ8FWFC+M=;
        b=vZ82m1Sl2b5Sx0GTw4TPu+1xoDvNgkf0AX1XJE7vTED9mmLeCcSPiOL4Cer7h9I8nE
         9TJv9jaqLrcm3B7z2UAd8y215h/YRosjt6SdgrOGKh8NjlUr1NnF9HGTFM4T82rYovzM
         w4c9hRm6gVZNV0Vr5XXiCZPxAT3QPFNcJGHGiRNk0MWXxIjytSAQeeoD5FfXDzfZO78s
         2s6JaRgRJLRgfD5NoLRs4p7KV8yvMnKfg4bZ2wBI0u17MQZvKcC3+77jFNGUaahNwiU5
         rc5Ij2vN8FW4Uv7H30dEWy9yzIB7+GdG80oErX11hrPTGuuLqMZ9UZ2C9cz/c7iPvMca
         uRbQ==
X-Gm-Message-State: AOJu0Yx3Su2IKsgVuG9ztDHXqE464OGVqGdu/GvetWK+XgkpF9xZ0c5D
        onZBhP2uL0JKc/6NAAmzu0EwTE+QUmkuai7HFRNXx9Z105BS
X-Google-Smtp-Source: AGHT+IE/LFlWtsbQAQFSju9/MHGsHWtgN6wrxCcFg+SKNmoIIg3BUa20QStEEjTexKjrQIDdJL+xe0mom6WnRPeRkn5KQ8HshovG
MIME-Version: 1.0
X-Received: by 2002:a05:6808:f01:b0:3ad:f860:b315 with SMTP id
 m1-20020a0568080f0100b003adf860b315mr10131436oiw.2.1699161369585; Sat, 04 Nov
 2023 22:16:09 -0700 (PDT)
Date:   Sat, 04 Nov 2023 22:16:09 -0700
In-Reply-To: <20231105050015.2524557-1-eadavis@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d9af34060960d5ee@google.com>
Subject: Re: [syzbot] [netfilter?] WARNING in __nf_unregister_net_hook (6)
From:   syzbot <syzbot+de4025c006ec68ac56fc@syzkaller.appspotmail.com>
To:     eadavis@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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
WARNING: CPU: 0 PID: 5762 at net/netfilter/core.c:522 __nf_unregister_net_hook+0x1e1/0x6a0 net/netfilter/core.c:522
Modules linked in:
CPU: 0 PID: 5762 Comm: syz-executor.5 Not tainted 6.6.0-rc3-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
RIP: 0010:__nf_unregister_net_hook+0x1e1/0x6a0 net/netfilter/core.c:522
Code: 14 02 4c 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 9f 04 00 00 8b 53 1c 48 c7 c7 80 d5 a8 8b 8b 74 24 0c e8 ef cc dc f8 <0f> 0b e9 0b 01 00 00 e8 83 a3 16 f9 44 89 e0 48 89 c2 48 c1 e2 04
RSP: 0018:ffffc90002dff2b8 EFLAGS: 00010282

RAX: 0000000000000000 RBX: ffff88802171f400 RCX: 0000000000000000
RDX: ffff888027ec0080 RSI: ffffffff814cf016 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000006
R13: ffff8880786ef2d0 R14: ffff888021deca00 R15: ffff88802171f41c
FS:  00007f7c803336c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f749c681ff8 CR3: 0000000063052000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 nf_unregister_net_hook+0xd5/0x110 net/netfilter/core.c:544
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
RIP: 0033:0x7f7c7f67cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7c803330c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f7c7f79c050 RCX: 00007f7c7f67cae9
RDX: 0000000000000000 RSI: 000000002000c2c0 RDI: 0000000000000004
RBP: 00007f7c7f6c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f7c7f79c050 R15: 00007ffe393fad78
 </TASK>


Tested on:

commit:         6465e260 Linux 6.6-rc3
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=158da6eb680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d7d7928f78936aa
dashboard link: https://syzkaller.appspot.com/bug?extid=de4025c006ec68ac56fc
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1030cd60e80000

