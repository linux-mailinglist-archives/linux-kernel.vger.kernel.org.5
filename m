Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F047B454A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 07:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbjJAFU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 01:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjJAFUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 01:20:54 -0400
Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD71C5
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 22:20:50 -0700 (PDT)
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-57b89ce6dc0so25633090eaf.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 22:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696137650; x=1696742450;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RuyzqJDmboZ6S/cDpTxB9O2RD/pB6/5O4DPd5g462hc=;
        b=W+8Kx7CXUSN0YmIPmYQ93bEDz1BskJsrL94LIJIDl/csAC+l0rOA/Vop2FQr2SHvcW
         7zZUHDAwk8RJFYgfjd8ZyC8K4nGJxaViJ/OHdhoPl1VJFkc3UO1dI87runsHaxggF9NH
         V895VM5SHpSXveYzdznYNJTXUaY5spAmks0RDgz6duhfsUcYewfLXBHe9EXSRmDkPvOy
         C5yBYxThAAGWsS12XrU6dAuUgMjHa6LfKHaY5NN4kbbFWQvBOLRHfSdyzDQe/SjySnd1
         CdTF+usNXthXXGVrFT5JDtRK1hMslPhLrgziltz35R/4CghA/GfiF+zg5IlEgftECMmF
         qaow==
X-Gm-Message-State: AOJu0YxiODdBEEQsQRIBxpXxdu9PhaPlJnlVKYYR6xvq3h+4O1n+V9yK
        VjHXJXDMtCY+PA9NXzaaHOZlE+6z+/lOvJRRL2JMZe2F0b01
X-Google-Smtp-Source: AGHT+IHYROQ7cTZPaM1lgipXnBlrqzNhbHIOqhi15o0R9rn5rl9Nt+6sqGxd7OQFbwrzUyejnf2zaKxX9BWQfQZ5gY4e5m3CSiG1
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2099:b0:3ae:526e:2634 with SMTP id
 s25-20020a056808209900b003ae526e2634mr4154714oiw.9.1696137649966; Sat, 30 Sep
 2023 22:20:49 -0700 (PDT)
Date:   Sat, 30 Sep 2023 22:20:49 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001dd5e20606a0d265@google.com>
Subject: [syzbot] [mm?] WARNING in page_vma_mapped_walk
From:   syzbot <syzbot+dcf3f48f4bfe47a2f80a@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    df964ce9ef9f Add linux-next specific files for 20230929
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17fed5e1680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=880c828d75e38e1b
dashboard link: https://syzkaller.appspot.com/bug?extid=dcf3f48f4bfe47a2f80a
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fe7244c6057d/disk-df964ce9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/48cdc7f3b2c0/vmlinux-df964ce9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ce7c93a66da9/bzImage-df964ce9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dcf3f48f4bfe47a2f80a@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 8436 at include/linux/hugetlb.h:1289 hugetlb_walk include/linux/hugetlb.h:1289 [inline]
WARNING: CPU: 1 PID: 8436 at include/linux/hugetlb.h:1289 page_vma_mapped_walk+0x1e85/0x27a0 mm/page_vma_mapped.c:199
Modules linked in:
CPU: 1 PID: 8436 Comm: syz-executor.0 Not tainted 6.6.0-rc3-next-20230929-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
RIP: 0010:hugetlb_walk include/linux/hugetlb.h:1289 [inline]
RIP: 0010:page_vma_mapped_walk+0x1e85/0x27a0 mm/page_vma_mapped.c:199
Code: 00 be ff ff ff ff 48 81 c7 a0 01 00 00 e8 33 71 77 08 31 ff 89 c5 89 c6 e8 78 b5 b9 ff 85 ed 0f 85 64 f7 ff ff e8 fb b9 b9 ff <0f> 0b e9 58 f7 ff ff e8 ef b9 b9 ff 48 89 ef 48 81 e7 00 f0 ff ff
RSP: 0000:ffffc90004f0f6b8 EFLAGS: 00010283
RAX: 000000000001b5c2 RBX: ffff88801eca2710 RCX: ffffc9000a691000
RDX: 0000000000040000 RSI: ffffffff81ce9bc5 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 000000000000002f R12: 0000000000200000
R13: ffffffff92312af8 R14: ffffc90004f0f8c0 R15: ffffffff92312b90
FS:  00007f489c7ce6c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b31a24000 CR3: 0000000017fc0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 try_to_migrate_one+0x4a2/0x28b0 mm/rmap.c:1929
 rmap_walk_anon+0x225/0x570 mm/rmap.c:2501
 rmap_walk mm/rmap.c:2578 [inline]
 rmap_walk mm/rmap.c:2573 [inline]
 try_to_migrate+0x2b6/0x300 mm/rmap.c:2230
 unmap_and_move_huge_page mm/migrate.c:1421 [inline]
 migrate_hugetlbs mm/migrate.c:1547 [inline]
 migrate_pages+0xa42/0x27c0 mm/migrate.c:1901
 migrate_to_node mm/mempolicy.c:1097 [inline]
 do_migrate_pages+0x2e9/0x670 mm/mempolicy.c:1196
 kernel_migrate_pages+0x59b/0x780 mm/mempolicy.c:1682
 __do_sys_migrate_pages mm/mempolicy.c:1701 [inline]
 __se_sys_migrate_pages mm/mempolicy.c:1697 [inline]
 __x64_sys_migrate_pages+0x96/0x100 mm/mempolicy.c:1697
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f489ba7cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f489c7ce0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000100
RAX: ffffffffffffffda RBX: 00007f489bb9c050 RCX: 00007f489ba7cae9
RDX: 0000000020000000 RSI: 0000000000000004 RDI: 0000000000000000
RBP: 00007f489bac847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000020000080 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f489bb9c050 R15: 00007ffcda957698
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
