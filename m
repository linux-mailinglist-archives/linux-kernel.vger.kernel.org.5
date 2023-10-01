Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC5A7B456F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 07:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbjJAFmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 01:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjJAFmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 01:42:46 -0400
Received: from mail-ot1-f77.google.com (mail-ot1-f77.google.com [209.85.210.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFF8C5
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 22:42:43 -0700 (PDT)
Received: by mail-ot1-f77.google.com with SMTP id 46e09a7af769-6c4717c4745so28908119a34.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 22:42:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696138963; x=1696743763;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v/M5+LwXqyyAX85mKMsy9gTo6yWmfbyn31L5z/UyU+8=;
        b=wjLGOIiKBg3FJd35l2MMp/Nrgpsb/+01LS41dNbaoPk3dEGtWYsv4xM1OwWo0yoY/e
         onZULE4ZS1S3NiL0nLZM1FDTgqpbFTBt9UGZPs6uAVTRbMGT3D95xPuyLNsYp0J9yYwE
         Ksk1TUf1osjgzWh+jWIQgZqGipQMm/BTrGNorar2+cK5LuUPqL9hrsmoCfPwPmNcjP5z
         bghWRu6EudCYpJEGZS7nhAHLEl87QNzdRW6+/mGcF0PWfr3k9VxW181LTqg/iz4nsKEF
         PGK+0iQaG3y66Hmi3gPSN3wUNkMicj87QFPSZNukwTZHlG0ypVX9bcQutbCD01SCSc5n
         qaHQ==
X-Gm-Message-State: AOJu0YyYdffbqxmGydSxw+ISSldzgmgrPJadgvg0KnD+xwOJkpj8HF0R
        w/8yya8KXuF46A5hlWQROo4oIk/AjKB14GO29UMN/WxHXmHL
X-Google-Smtp-Source: AGHT+IHm+KBlOCtpKqOgZm9yLGYWKgGx8vWflzCoD9NqXosPpFC9w5h+ha+goLbyQdOuYYlWDKhoXfnZozCQnvPZVzsCi1+2OLTg
MIME-Version: 1.0
X-Received: by 2002:a9d:6950:0:b0:6c4:77eb:7130 with SMTP id
 p16-20020a9d6950000000b006c477eb7130mr2509824oto.0.1696138963208; Sat, 30 Sep
 2023 22:42:43 -0700 (PDT)
Date:   Sat, 30 Sep 2023 22:42:43 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000644f160606a120b3@google.com>
Subject: [syzbot] [mm?] WARNING in huge_pmd_unshare
From:   syzbot <syzbot+ff00584717dadcbd2e67@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, mike.kravetz@oracle.com,
        muchun.song@linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
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

HEAD commit:    df964ce9ef9f Add linux-next specific files for 20230929
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=134e2921680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=880c828d75e38e1b
dashboard link: https://syzkaller.appspot.com/bug?extid=ff00584717dadcbd2e67
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fe7244c6057d/disk-df964ce9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/48cdc7f3b2c0/vmlinux-df964ce9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ce7c93a66da9/bzImage-df964ce9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ff00584717dadcbd2e67@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 7121 at mm/hugetlb.c:298 hugetlb_vma_assert_locked mm/hugetlb.c:298 [inline]
WARNING: CPU: 1 PID: 7121 at mm/hugetlb.c:298 huge_pmd_unshare+0x6be/0x940 mm/hugetlb.c:6904
Modules linked in:
CPU: 1 PID: 7121 Comm: syz-executor.1 Not tainted 6.6.0-rc3-next-20230929-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
RIP: 0010:hugetlb_vma_assert_locked mm/hugetlb.c:298 [inline]
RIP: 0010:huge_pmd_unshare+0x6be/0x940 mm/hugetlb.c:6904
Code: ff ff ff ff 48 81 c7 c8 00 00 00 e8 dc 89 6c 08 31 ff 41 89 c5 89 c6 e8 20 ce ae ff 45 85 ed 0f 85 67 fa ff ff e8 a2 d2 ae ff <0f> 0b e9 5b fa ff ff 31 db e9 5d fd ff ff e8 8f d2 ae ff 48 89 da
RSP: 0018:ffffc90016177678 EFLAGS: 00010283
RAX: 0000000000003492 RBX: 0000000020000000 RCX: ffffc9000aee4000
RDX: 0000000000040000 RSI: ffffffff81d9831e RDI: 0000000000000005
RBP: ffff88802a226880 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 000000000000003c R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000001 R15: ffff88807e489e88
FS:  00007fde004546c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30d2a000 CR3: 000000007f0d7000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __unmap_hugepage_range+0x4e3/0x1940 mm/hugetlb.c:5222
 unmap_hugepage_range+0x1fa/0x330 mm/hugetlb.c:5347
 hugetlb_vmdelete_list+0x11d/0x170 fs/hugetlbfs/inode.c:534
 hugetlbfs_punch_hole fs/hugetlbfs/inode.c:734 [inline]
 hugetlbfs_fallocate+0xc75/0x1050 fs/hugetlbfs/inode.c:774
 shm_fallocate+0xca/0x110 ipc/shm.c:646
 vfs_fallocate+0x46c/0xe80 fs/open.c:324
 madvise_remove mm/madvise.c:1019 [inline]
 madvise_vma_behavior+0x1c00/0x1d00 mm/madvise.c:1043
 madvise_walk_vmas+0x1cf/0x2c0 mm/madvise.c:1278
 do_madvise+0x333/0x660 mm/madvise.c:1458
 __do_sys_madvise mm/madvise.c:1471 [inline]
 __se_sys_madvise mm/madvise.c:1469 [inline]
 __x64_sys_madvise+0xaa/0x110 mm/madvise.c:1469
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fddff67cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fde004540c8 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
RAX: ffffffffffffffda RBX: 00007fddff79c050 RCX: 00007fddff67cae9
RDX: 0000000000000009 RSI: 000000000060000b RDI: 0000000020000000
RBP: 00007fddff6c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007fddff79c050 R15: 00007ffce99d7b18
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
