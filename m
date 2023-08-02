Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF3176C6B4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbjHBHXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjHBHXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:23:08 -0400
Received: from mail-oa1-f77.google.com (mail-oa1-f77.google.com [209.85.160.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB1A1996
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 00:23:06 -0700 (PDT)
Received: by mail-oa1-f77.google.com with SMTP id 586e51a60fabf-1ad12c38bceso10421156fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 00:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690960986; x=1691565786;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+UGxmnMchIG6YtvEzTjbProR0pVTHNp2FTeL1zDEaKo=;
        b=CNVZFlV7bkVysKHZEB2osBjjbFmPBJYuURUqUK6QVd24APfmhh8Z8oKl5O7+oI//RT
         wkiRowtpqzbcw4HNIXaIhMsqGp11nNzKPzzlN9G3w466gmuPxcYBAa1o+QIxt51IgkvA
         KelmjBERAWDs0n5j6DhCnMADtda8iXfJbOmpA5wMm5kDbd7+TNn7nauddIM3ET4hdHU5
         gH7QuTxf6Eb+7JW9TwrTWR+OeRoehlFw6JovH1pVjjbeysh4drGeBR+8s1hi+unzOorL
         w7rzIDz23MtFlhEVvAtlPsTidLE47t41tAWjC+8ahacMupawqXMKBMPxpQtdesCrJFTp
         5Rng==
X-Gm-Message-State: ABy/qLb6CA1/jwewXAsy6d1k6BE7yYXm/gigLl5sfjoeNYhLW7LAZfTt
        w3gaBNtOFcklGlkF131LEOdddKsT4RGfX9Kx3s43UUHEoTRA
X-Google-Smtp-Source: APBJJlFM0mGFD0D2FSx7TyxI1WfIYxGzk//gjqgj0ndgnRg/vZKpnSJELrlSC5PHu2ZlPwXA45hgsxp5Irm5AY9p+JJ7H4IRbHyz
MIME-Version: 1.0
X-Received: by 2002:a05:6870:5a84:b0:1bb:ad9e:2982 with SMTP id
 dt4-20020a0568705a8400b001bbad9e2982mr16088203oab.10.1690960985867; Wed, 02
 Aug 2023 00:23:05 -0700 (PDT)
Date:   Wed, 02 Aug 2023 00:23:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e44f2b0601eb8820@google.com>
Subject: [syzbot] [mm?] WARNING in try_to_migrate_one
From:   syzbot <syzbot+94d51f4b3c59cdad469d@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f837f0a3c948 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12e64c61a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d10d93e1ae1f229
dashboard link: https://syzkaller.appspot.com/bug?extid=94d51f4b3c59cdad469d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b77423ff9f0c/disk-f837f0a3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fe98d65e37e8/vmlinux-f837f0a3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0ce03308abc6/bzImage-f837f0a3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+94d51f4b3c59cdad469d@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 31 at arch/x86/include/asm/pgtable.h:314 try_to_migrate_one+0x19c5/0x2860 mm/rmap.c:2096
Modules linked in:
CPU: 0 PID: 31 Comm: kcompactd0 Not tainted 6.5.0-rc3-syzkaller-00225-gf837f0a3c948 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
RIP: 0010:pte_uffd_wp arch/x86/include/asm/pgtable.h:314 [inline]
RIP: 0010:try_to_migrate_one+0x19c5/0x2860 mm/rmap.c:2096
Code: 00 e8 6f 79 fe ff 84 c0 0f 84 1b 05 00 00 e8 d2 1b b6 ff e9 dc ee ff ff e8 c8 1b b6 ff 48 ff cb e9 a2 f3 ff ff e8 bb 1b b6 ff <0f> 0b e9 fa fa ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 59 ff
RSP: 0018:ffffc90000a7ede0 EFLAGS: 00010293
RAX: ffffffff81d5fa55 RBX: 0000000000000402 RCX: ffff8880136e3b80
RDX: 0000000000000000 RSI: 0000000000000402 RDI: 0000000000000402
RBP: ffffc90000a7f130 R08: ffffffff81d5f544 R09: 1ffffd4000179978
R10: dffffc0000000000 R11: fffff94000179979 R12: 0000000000000002
R13: ffffe7fffa19a000 R14: 000000002f32fc67 R15: d000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f764abf5000 CR3: 0000000081a0e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 rmap_walk_anon+0x388/0x6b0 mm/rmap.c:2441
 try_to_migrate+0x3de/0x4a0
 migrate_folio_unmap mm/migrate.c:1233 [inline]
 migrate_pages_batch+0x11c5/0x3840 mm/migrate.c:1658
 migrate_pages_sync mm/migrate.c:1823 [inline]
 migrate_pages+0x1e7c/0x3210 mm/migrate.c:1927
 compact_zone+0x308f/0x4750 mm/compaction.c:2484
 proactive_compact_node mm/compaction.c:2749 [inline]
 kcompactd+0x1082/0x1b90 mm/compaction.c:3069
 kthread+0x2b8/0x350 kernel/kthread.c:389
 ret_from_fork+0x2e/0x60 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:296
RIP: 0000:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0000:0000000000000000 EFLAGS: 00000000 ORIG_RAX: 0000000000000000
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
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
