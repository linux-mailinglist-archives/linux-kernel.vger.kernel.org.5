Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1397FEA9D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 09:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344889AbjK3IaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 03:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344881AbjK3IaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 03:30:14 -0500
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9008510E2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 00:30:18 -0800 (PST)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6cdd6206017so822028b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 00:30:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701333018; x=1701937818;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pIw1JWWT8TnVD6HbKTVvuR/5VtUWqfCmmFWn9LBakHY=;
        b=KN9nt1QqgGjT4H87zt2GddkkT22ukOC4g/rJpI17DglS8X7Meg2mbxaafI27k6an0b
         07x7fIEFV096jJV4nTKYFlXGDcpNrD8mOG90rHwi3M+D2IcdE+MnJo7fTpOtwdyzhVg1
         aDWR0k/o+G9/uk9wEvk4raEAI9PgblhhqOwMDx1a2cy5xBp2ervrjceqD49ZE6zCJLDO
         vGQaaN8OQPPGRgYDHv4jdJVw9Eyg3lz6pN7r45PFubsurFDhSyKUOSV+IzWz9fxyUhyg
         37kHebtcDmu9X8Twyaho6xJjhps4uFjq1eaJSWGbKbxucyLXGMt2HaUh3p2SLZ2TywkP
         Of4Q==
X-Gm-Message-State: AOJu0YyVrQb2EOUIvvo8Z7G5E0RL2tTsju9AB/jznQsOf5oR5asAo1Bg
        z7ZbqJms876qomfnWQJYvRZ3p8kWN+4AIZctXQ/z2i/8u7q0
X-Google-Smtp-Source: AGHT+IFbutBmUZfwpexHXYZG5aEDMpJIxfd0+ggfyPZdji7eh9GhZt1t2/yrc8QSkSBVy3CwHfwsiFsCEl+LIBCdACB+oFRh/Ter
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:1249:b0:6cd:f18e:175 with SMTP id
 u9-20020a056a00124900b006cdf18e0175mr15597pfi.0.1701333017837; Thu, 30 Nov
 2023 00:30:17 -0800 (PST)
Date:   Thu, 30 Nov 2023 00:30:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002ca935060b5a7682@google.com>
Subject: [syzbot] [net?] WARNING in cleanup_net (3)
From:   syzbot <syzbot+9ada62e1dc03fdc41982@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d90b0276af8f Merge tag 'hardening-v6.6-rc3' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12c4675c680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d594086f139d167
dashboard link: https://syzkaller.appspot.com/bug?extid=9ada62e1dc03fdc41982
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-d90b0276.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c6997ebf3cf3/vmlinux-d90b0276.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d893c5c3f98f/bzImage-d90b0276.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9ada62e1dc03fdc41982@syzkaller.appspotmail.com

     do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
     entry_SYSENTER_compat_after_hwframe+0x70/0x82
------------[ cut here ]------------
WARNING: CPU: 1 PID: 1093 at lib/ref_tracker.c:179 spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
WARNING: CPU: 1 PID: 1093 at lib/ref_tracker.c:179 ref_tracker_dir_exit+0x3e2/0x680 lib/ref_tracker.c:178
Modules linked in:
CPU: 1 PID: 1093 Comm: kworker/u16:7 Not tainted 6.6.0-rc2-syzkaller-00337-gd90b0276af8f #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:ref_tracker_dir_exit+0x3e2/0x680 lib/ref_tracker.c:179
Code: 85 07 02 00 00 4d 39 f5 49 8b 06 4d 89 f7 0f 85 0e ff ff ff 48 8b 2c 24 e8 4b 7b 32 fd 48 8b 74 24 18 48 89 ef e8 ce d8 ec 05 <0f> 0b e8 37 7b 32 fd 48 8d 5d 44 be 04 00 00 00 48 89 df e8 b6 34
RSP: 0018:ffffc90006ee7b78 EFLAGS: 00010246
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffff8a8cab20 RDI: 0000000000000001
RBP: ffff8880591981e0 R08: 0000000000000001 R09: fffffbfff233dff7
R10: ffffffff919effbf R11: 0000000000000114 R12: ffff888059198230
R13: ffff888059198230 R14: ffff888059198230 R15: ffff888059198230
FS:  0000000000000000(0000) GS:ffff88802c700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000057ab404c CR3: 0000000070f05000 CR4: 0000000000350ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 00000000ffff00f1 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 net_free net/core/net_namespace.c:448 [inline]
 net_free net/core/net_namespace.c:442 [inline]
 cleanup_net+0x8d4/0xb20 net/core/net_namespace.c:635
 process_one_work+0x884/0x15c0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
