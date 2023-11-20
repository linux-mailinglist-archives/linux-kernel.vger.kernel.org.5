Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCAB7F0B1F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 04:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbjKTDnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 22:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjKTDnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 22:43:10 -0500
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F6683
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 19:43:06 -0800 (PST)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-28515f4cd74so1491016a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 19:43:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700451786; x=1701056586;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bOyKkUQDo74pZloe5q3dh6gyfP8G7HtxI58TIP7S644=;
        b=dWcUvnMisR2zF7I0IcTUGaOB0jE7naJXmgvs9LigZAyerqE7FLNtqM47J29wHerHEc
         R5o339TqpX86G2nqorTeFp1fxEhVSCLUhiLbKX5uzUTR2xJQ5lqV4LzImqN1xxZ02yuE
         POGFQGf8jvPH9ZAqAvur4IJJyVmfKx1HOT/HHSgi+H0o9XDRtebU6bwqu/81pdPSYnrd
         oPTW2kJwkgIVqdtKkYUW4w+C+uqKk7rrLCFj/Sd4ThHoyBT8QqiQV8by2OqTA3EOkQPC
         j/hX6vcmGqpHmfFA56ZjkvkRHzOTnCasJMAqnIjBiK1xlWmdiXyfKz0eW+dW4s5r2MOo
         DVkw==
X-Gm-Message-State: AOJu0Ywm5nTHji8ojUT6a7DrgxwI1FGmNpiruoAaXsOkFpPM3qZnOBvU
        a8RmNFgt7tf2yv89NeIPEgUxd/hrdpzIfFETzWXY2JyD3j8l
X-Google-Smtp-Source: AGHT+IGFUmSBh9pwk7l0+FYkuoYdT2GjrdfutGVu9F8EVqmunBwjIzXf+jCanPNX2o0F/NGVUXAyPZv1YLYgN0tepLLTOPvM0QcG
MIME-Version: 1.0
X-Received: by 2002:a17:90a:77c3:b0:280:31a8:1929 with SMTP id
 e3-20020a17090a77c300b0028031a81929mr1604871pjs.7.1700451786361; Sun, 19 Nov
 2023 19:43:06 -0800 (PST)
Date:   Sun, 19 Nov 2023 19:43:06 -0800
In-Reply-To: <20231120030705.1265508-1-eadavis@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000af1897060a8d482f@google.com>
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
WARNING: CPU: 0 PID: 5828 at net/netfilter/core.c:519 __nf_unregister_net_hook+0x1de/0x670 net/netfilter/core.c:519
Modules linked in:
CPU: 0 PID: 5828 Comm: syz-executor.2 Not tainted 6.6.0-rc3-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
RIP: 0010:__nf_unregister_net_hook+0x1de/0x670 net/netfilter/core.c:519
Code: 14 02 4c 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 7a 04 00 00 8b 53 1c 48 c7 c7 c0 d4 a8 8b 8b 74 24 04 e8 b2 ce dc f8 <0f> 0b e9 ec 00 00 00 e8 46 a5 16 f9 48 89 e8 48 c1 e0 04 49 8d 7c
RSP: 0018:ffffc90003ecf2b8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff888061921800 RCX: 0000000000000000
RDX: ffff88807a4a6180 RSI: ffffffff814cf016 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff8880772b7250
R13: ffff888023717598 R14: ffff888023717500 R15: ffff88806192181c
FS:  00007f709206d6c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2411480420 CR3: 000000001c0be000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 nf_unregister_net_hook+0xd5/0x110 net/netfilter/core.c:541
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
RIP: 0033:0x7f709127cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f709206d0c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f709139bf80 RCX: 00007f709127cae9
RDX: 0000000000000000 RSI: 000000002000c2c0 RDI: 0000000000000004
RBP: 00007f70912c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f709139bf80 R15: 00007ffca21c8a28
 </TASK>


Tested on:

commit:         6465e260 Linux 6.6-rc3
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=127331b8e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d7d7928f78936aa
dashboard link: https://syzkaller.appspot.com/bug?extid=de4025c006ec68ac56fc
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14c46f2f680000

