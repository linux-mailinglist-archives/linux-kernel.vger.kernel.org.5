Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E387A57A2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 05:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjISDCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 23:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjISDCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 23:02:36 -0400
Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CD1114
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 20:02:29 -0700 (PDT)
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-57b1eb743a6so159405eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 20:02:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695092548; x=1695697348;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MaqLK16llZ/wvyy7UxMMijoHIaVAzxb+XWz5BBQvrZI=;
        b=Zk3Qkk79shKQ5U9HXsXfd8eMBrR74i5goTE9bsqUI5JTQ2F30yR+e9CEHmGaDZzwL/
         OsHjs294vnvtiZmXoAEZM9wHRmMvomKW6dmpeUnj9rlmrKgJmkyrY3/dN2rZgLUZ2qR2
         /ha2AAWA2opP56yIS/BoYQ7JvUIdKFoYZTg5nG8mXAn1HHRx28BJGFDN8LZaqSWU+lU6
         D5Qggww/0mGCHSnLzvHD+JW7loy+MiuwoxwfE1UGgy7RYqbwvSFuH1I0kT62WBBdUOVd
         t3y8kU4RgAjyWePvBpKw/HaN0dlXqdAaprwUXuX5JGBsXhLVy+Ap5HLLxNIFW69f+fqW
         9L7g==
X-Gm-Message-State: AOJu0YzDLeE4XhLVD3Xy3oeoT3V02lxpPcsOrED6o6rcckXMOcMVxiE/
        A/mdk2leNY/ydJ+81cA3suQ01LXbSDdsGhqMyiZBUJQyLdEs
X-Google-Smtp-Source: AGHT+IHQtvH57kf7xPi1DlcyP1hy0pc7QoXUS0O5fULd6Xnrc67+DAMUX+KpWmEtNVl7PCru4naMSF+BRQ4oO2YMiVaJz61kUE5N
MIME-Version: 1.0
X-Received: by 2002:a05:6870:5b25:b0:1d5:98bd:ef3e with SMTP id
 ds37-20020a0568705b2500b001d598bdef3emr4149935oab.0.1695092548466; Mon, 18
 Sep 2023 20:02:28 -0700 (PDT)
Date:   Mon, 18 Sep 2023 20:02:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000367e390605ad7ddf@google.com>
Subject: [syzbot] [net?] [wireless?] WARNING in ieee80211_get_ringparam
From:   syzbot <syzbot+c12a771b218dcbba32e1@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com,
        emmanuel.grumbach@intel.com, johannes.berg@intel.com,
        johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    dfa449a58323 Add linux-next specific files for 20230915
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=161201c2680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e204dda2e58397ec
dashboard link: https://syzkaller.appspot.com/bug?extid=c12a771b218dcbba32e1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=138a0972680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10441362680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/34f9995871ed/disk-dfa449a5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/95e2e1c3ab9e/vmlinux-dfa449a5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cfc6db9684d4/bzImage-dfa449a5.xz

The issue was bisected to:

commit 0e8185ce1ddebf9de43b1f0fa92bf6dbba6ffb86
Author: Johannes Berg <johannes.berg@intel.com>
Date:   Mon Aug 28 11:59:52 2023 +0000

    wifi: mac80211: check wiphy mutex in ops

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1235acc4680000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1135acc4680000
console output: https://syzkaller.appspot.com/x/log.txt?x=1635acc4680000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c12a771b218dcbba32e1@syzkaller.appspotmail.com
Fixes: 0e8185ce1dde ("wifi: mac80211: check wiphy mutex in ops")

UDPLite: UDP-Lite is deprecated and scheduled to be removed in 2025, please contact the netdev mailing list
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5044 at net/mac80211/driver-ops.h:797 drv_get_ringparam net/mac80211/driver-ops.h:797 [inline]
WARNING: CPU: 0 PID: 5044 at net/mac80211/driver-ops.h:797 ieee80211_get_ringparam+0x346/0x400 net/mac80211/ethtool.c:38
Modules linked in:
CPU: 0 PID: 5044 Comm: syz-executor217 Not tainted 6.6.0-rc1-next-20230915-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
RIP: 0010:drv_get_ringparam net/mac80211/driver-ops.h:797 [inline]
RIP: 0010:ieee80211_get_ringparam+0x346/0x400 net/mac80211/ethtool.c:38
Code: 60 07 00 00 be ff ff ff ff 48 8d 78 68 e8 b2 b3 83 00 31 ff 89 c5 89 c6 e8 b7 fc c9 f7 85 ed 0f 85 b6 fd ff ff e8 3a 01 ca f7 <0f> 0b e9 aa fd ff ff e8 2e 01 ca f7 e8 39 94 b2 f7 31 ff 89 c5 89
RSP: 0018:ffffc9000390f840 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88801f908700 RCX: 0000000000000000
RDX: ffff88807ae70000 RSI: ffffffff89bde526 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: ffffffff910d7bf8 R12: ffff88801f908e20
R13: ffffc9000390fa30 R14: ffffc9000390fa34 R15: ffffc9000390fa24
FS:  0000555556e0a380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004585c0 CR3: 0000000073ab1000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ethtool_set_ringparam net/ethtool/ioctl.c:1776 [inline]
 __dev_ethtool net/ethtool/ioctl.c:2902 [inline]
 dev_ethtool+0x23b6/0x58c0 net/ethtool/ioctl.c:3091
 dev_ioctl+0x29e/0x1090 net/core/dev_ioctl.c:722
 sock_do_ioctl+0x198/0x270 net/socket.c:1217
 sock_ioctl+0x229/0x6b0 net/socket.c:1322
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f9eaa316329
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffefb1f5478 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffefb1f5648 RCX: 00007f9eaa316329
RDX: 0000000020000040 RSI: 0000000000008946 RDI: 0000000000000003
RBP: 00007f9eaa389610 R08: 0000000000000000 R09: 00007ffefb1f5648
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffefb1f5638 R14: 0000000000000001 R15: 0000000000000001
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
