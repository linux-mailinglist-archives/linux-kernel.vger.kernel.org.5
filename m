Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E927C8729
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 15:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjJMNsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 09:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjJMNst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 09:48:49 -0400
Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B56C0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 06:48:46 -0700 (PDT)
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-3b29c7f5ddcso3254254b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 06:48:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697204926; x=1697809726;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PAToOXxytmP0bdAjlmkiTifK8QLT8kt36CiJBg+FFy0=;
        b=nlaPSF7j70J4iEu+8cdirOxJwVxrVPXv7YJtrmFcpghQ2SU1xrDCAapwsMaw7LsZqa
         GnwWj8VBeCGXuSDHswAS0wOwriW7qbNz/uBRR5jfa/r4E+u82HdWXSI9xL2GzVYoDQDJ
         N6Wdp5V+2nUdN32JtTMf1frJdJZeEbtWYDJZDw2k6hUkbaMHi0IH/gRuaytuCMMAWyGw
         qDcF8TFOTDv/SG7dvEQa2bFyaCSKf2LMrbSvCc7dkKbZBIL1utouN/+P2/fuwyRKVV+x
         UUK6WPAKV/cLSJQQuufC0suGp7LY1MbKc+oLGizOOtsG72pz5unerAAw9JBsMvXb4NGv
         89Gg==
X-Gm-Message-State: AOJu0Yxu70dsfAMoIursnYBcvbyeWzwcL57j2T+1I/4kV3skgsoomH2Z
        Q0J5K1WhEGz50AaaiXJoYklNPiaXZBEjJQwVbtAJPRCHu0x5
X-Google-Smtp-Source: AGHT+IHwQqVSuyN8b5e7pFfV6gmpo7/Y08Y0hIgwtlDJlxTyNL9a/AIS3pkCsKWE04aDohzv7ykbtJXmwtmm1RpA71IYy3VB6Wd8
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1883:b0:3af:6406:ade7 with SMTP id
 bi3-20020a056808188300b003af6406ade7mr13007847oib.0.1697204925896; Fri, 13
 Oct 2023 06:48:45 -0700 (PDT)
Date:   Fri, 13 Oct 2023 06:48:45 -0700
In-Reply-To: <0000000000006a3d0d060785f027@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b81f1b06079950b6@google.com>
Subject: Re: [syzbot] [net?] [wireless?] WARNING in ieee80211_bss_info_change_notify
 (2)
From:   syzbot <syzbot+dd4779978217b1973180@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com,
        johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    ce583d5fb9d3 Merge tag 'for-v6.6-rc2' of git://git.kernel...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=125f7d55680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d83dadac33c08b7
dashboard link: https://syzkaller.appspot.com/bug?extid=dd4779978217b1973180
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=157a58e5680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=170cf875680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/43a421473cd1/disk-ce583d5f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/76dd974a032f/vmlinux-ce583d5f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5c8c2ff05ef3/bzImage-ce583d5f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dd4779978217b1973180@syzkaller.appspotmail.com

netlink: 'syz-executor374': attribute type 27 has an invalid length.
------------[ cut here ]------------
wlan1: Failed check-sdata-in-driver check, flags: 0x0
WARNING: CPU: 1 PID: 5036 at net/mac80211/main.c:236 ieee80211_bss_info_change_notify+0x2c9/0x820 net/mac80211/main.c:236
Modules linked in:
CPU: 1 PID: 5036 Comm: syz-executor374 Not tainted 6.6.0-rc5-syzkaller-00171-gce583d5fb9d3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
RIP: 0010:ieee80211_bss_info_change_notify+0x2c9/0x820 net/mac80211/main.c:236
Code: 00 00 e8 5a e1 d6 f7 48 8b 74 24 08 48 89 74 24 08 e8 4b e1 d6 f7 8b 14 24 48 c7 c7 e0 7b c4 8b 48 8b 74 24 08 e8 77 0a 9d f7 <0f> 0b e8 30 e1 d6 f7 4c 89 f2 48 b8 00 00 00 00 00 fc ff df 48 c1
RSP: 0018:ffffc9000344f2f8 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff88807da50c80 RCX: 0000000000000000
RDX: ffff88807d852040 RSI: ffffffff814cf016 RDI: 0000000000000001
RBP: 0000000000000a00 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff888072358e20
R13: ffff88807da528b0 R14: ffff88807da515a0 R15: 0000000000000000
FS:  0000555556919380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f934a6ed463 CR3: 00000000268ad000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ieee80211_ibss_disconnect+0x411/0x9d0 net/mac80211/ibss.c:726
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
RIP: 0033:0x7f934a6ef4e9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 d1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc0722bea8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f934a6ef4e9
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007ffc0722bf20 R15: 00007ffc0722bf10
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
