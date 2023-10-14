Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADE57C9226
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 03:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbjJNBq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 21:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJNBq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 21:46:28 -0400
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832AD83
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 18:46:26 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3ae5ac8de14so4035768b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 18:46:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697247986; x=1697852786;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1sUXmaG2gzDn0Qsvf+dKDPIdOsMaqWhWkTYeFluGaGM=;
        b=lsU4cvRezbUCddi4qO3VkvR1tDkBJhFnhpT3T0NSjNHtMc6UvbP9qTYQKJPAWDjZ1y
         cKg5TDHH/mhEjD+ATbSf9l7vOlfONTjw0Q+dDnc5PiWmWt8l7EfYjAmjlt+/m0NkpJuc
         /W2al1T1ifO1TJodwFkKht38/JZRTffdS07NWXTFba6wrMUfgbqxFoTOdCRCRuT7zkl3
         wMxCyDLq7UQaETOaxmbHzTYTsXAQgAa099uKo2Sr6IeFw9U3afctUISxZTgQZha6g+uG
         pG/+A4iI932uQ7sJreyxVaJDqgzmdajx9gsvuK9o5a6zXaJi1GcpUMDk2WCiv0kxDhHD
         yaag==
X-Gm-Message-State: AOJu0YwTyQYvpC8l0YZXIPIqPxz1xLgUr1FImMddzm5/Qp7Y2J66ROLB
        lbN1+GWke+pMJIEcf9IHp9J7DT0JbyXcyQghfqzM2fzJOAtc
X-Google-Smtp-Source: AGHT+IHT+psgJJm4myHUduWBAXpCUp2omnVHCz1XmtD91RA1BuXJO7sjSSA1jUqPAZIuOC5BTcuU4GJzAYKAqRA495n9OK9GDmeA
MIME-Version: 1.0
X-Received: by 2002:a05:6808:138c:b0:3a8:48fc:aaa5 with SMTP id
 c12-20020a056808138c00b003a848fcaaa5mr14265766oiw.5.1697247985934; Fri, 13
 Oct 2023 18:46:25 -0700 (PDT)
Date:   Fri, 13 Oct 2023 18:46:25 -0700
In-Reply-To: <20231014013037.1498-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004c29680607a357c0@google.com>
Subject: Re: [syzbot] [net?] [wireless?] WARNING in ieee80211_bss_info_change_notify
 (2)
From:   syzbot <syzbot+dd4779978217b1973180@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in ieee80211_ibss_disconnect

------------[ cut here ]------------
wlan1: Failed check-sdata-in-driver check, flags: 0x0
WARNING: CPU: 0 PID: 5474 at net/mac80211/driver-ops.h:1139 drv_leave_ibss net/mac80211/driver-ops.h:1139 [inline]
WARNING: CPU: 0 PID: 5474 at net/mac80211/driver-ops.h:1139 ieee80211_ibss_disconnect+0x5d1/0x9d0 net/mac80211/ibss.c:728
Modules linked in:
CPU: 0 PID: 5474 Comm: syz-executor.0 Not tainted 6.6.0-rc5-syzkaller-00234-g8cb1f10d8c4b-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
RIP: 0010:drv_leave_ibss net/mac80211/driver-ops.h:1139 [inline]
RIP: 0010:ieee80211_ibss_disconnect+0x5d1/0x9d0 net/mac80211/ibss.c:728
Code: a5 10 09 00 00 4d 85 e4 0f 84 79 02 00 00 e8 a6 b6 d0 f7 e8 a1 b6 d0 f7 44 89 f2 4c 89 e6 48 c7 c7 20 c1 c4 8b e8 cf df 96 f7 <0f> 0b e9 c0 fe ff ff e8 83 b6 d0 f7 48 8b 3c 24 48 89 ee e8 07 f6
RSP: 0018:ffffc90003517348 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff8880176a95a0 RCX: 0000000000000000
RDX: ffff888076e92100 RSI: ffffffff814cf016 RDI: 0000000000000001
RBP: ffff8880176a8c80 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff8880176a8000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
FS:  00007f2ce0e6d6c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000556133612680 CR3: 000000006528e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ieee80211_ibss_leave+0x16/0x160 net/mac80211/ibss.c:1872
 rdev_leave_ibss net/wireless/rdev-ops.h:569 [inline]
 __cfg80211_leave_ibss+0x1a2/0x410 net/wireless/ibss.c:210
 cfg80211_leave_ibss+0x59/0x80 net/wireless/ibss.c:228
 cfg80211_change_iface+0x457/0xdf0 net/wireless/util.c:1137
 nl80211_set_interface+0x708/0x9b0 net/wireless/nl80211.c:4222
 genl_family_rcv_msg_doit+0x1fc/0x2e0 net/netlink/genetlink.c:971
 genl_family_rcv_msg net/netlink/genetlink.c:1051 [inline]
 genl_rcv_msg+0x55c/0x800 net/netlink/genetlink.c:1066
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2545
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1075
 netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
 netlink_unicast+0x536/0x810 net/netlink/af_netlink.c:1368
 netlink_sendmsg+0x93c/0xe40 net/netlink/af_netlink.c:1910
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0xd5/0x180 net/socket.c:745
 ____sys_sendmsg+0x6ac/0x940 net/socket.c:2558
 ___sys_sendmsg+0x135/0x1d0 net/socket.c:2612
 __sys_sendmsg+0x117/0x1e0 net/socket.c:2641
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f2ce007cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2ce0e6d0c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f2ce019c050 RCX: 00007f2ce007cae9
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000005
RBP: 00007f2ce00c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f2ce019c050 R15: 00007ffdee155718
 </TASK>


Tested on:

commit:         8cb1f10d Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=156a5875680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d83dadac33c08b7
dashboard link: https://syzkaller.appspot.com/bug?extid=dd4779978217b1973180
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10c2aec9680000

