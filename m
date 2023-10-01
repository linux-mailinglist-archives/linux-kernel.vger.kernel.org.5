Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8867B4542
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 07:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbjJAE64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 00:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjJAE6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 00:58:53 -0400
Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F48BC
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 21:58:49 -0700 (PDT)
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-3af602b6512so9522310b6e.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 21:58:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696136329; x=1696741129;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YSXLw/2P4TcYGoWH6ynzUMbdZXrdu9zISKczKzcyQrw=;
        b=rTDN64DFqDDANNka/FGAIQRieYf0Q1AQKGq8CXNiXH25scNX0/2H8WrDd8EErkUGDY
         QX5tRvO2VYSC/1EI2pZb9d52/DNtlSbdac3MFKJsn77DYB49zlj2szb445NLHOGheAOQ
         CxnFDNr5s3XYX3thbL8epZYmlgCcFPSSqgxnpOP50gvZ8os+UX+s5RskNB65pW3Er1gp
         LeEiTe+uH3cO7VMPlDv8D6XLm05h9T3ZVPQjGT7Vi86o74W+RJK5flGKW5LrfxeM9gqp
         WiPTCzDsXMF2IQDePTYEqqF3Pk8wnQ1xBV4su9Xccx2IbUr9o0EkthEkFnXHyPURAIPl
         I/PQ==
X-Gm-Message-State: AOJu0Yx+c4JQgkJjmkJgiEjG561Rg9S5ECtc2PIc9Bi9AJs2C93uNa1E
        bGjG3ghyozkO33zsvScQbqpOTbHKjSmLu2W04a1BcejxsF4K
X-Google-Smtp-Source: AGHT+IEZQ+sLkFr6P2H6byzG+97VGtFdZx4CAw4V3787yadeAPjk9o+9aS8tZHqV3vG08Gmj3OraE8BdASWoeZusUaJAoBW8qwdl
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1288:b0:3ae:1e08:41ee with SMTP id
 a8-20020a056808128800b003ae1e0841eemr4339822oiw.5.1696136328839; Sat, 30 Sep
 2023 21:58:48 -0700 (PDT)
Date:   Sat, 30 Sep 2023 21:58:48 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005f05820606a0838a@google.com>
Subject: [syzbot] [mm?] WARNING in copy_hugetlb_page_range
From:   syzbot <syzbot+ec78016e3d67860eec28@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, mike.kravetz@oracle.com,
        muchun.song@linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    df964ce9ef9f Add linux-next specific files for 20230929
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12d60d01680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=880c828d75e38e1b
dashboard link: https://syzkaller.appspot.com/bug?extid=ec78016e3d67860eec28
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fe7244c6057d/disk-df964ce9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/48cdc7f3b2c0/vmlinux-df964ce9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ce7c93a66da9/bzImage-df964ce9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ec78016e3d67860eec28@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 6510 at include/linux/hugetlb.h:1289 hugetlb_walk include/linux/hugetlb.h:1289 [inline]
WARNING: CPU: 0 PID: 6510 at include/linux/hugetlb.h:1289 copy_hugetlb_page_range+0x675/0x3520 mm/hugetlb.c:4940
Modules linked in:
CPU: 0 PID: 6510 Comm: syz-executor.5 Not tainted 6.6.0-rc3-next-20230929-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
RIP: 0010:hugetlb_walk include/linux/hugetlb.h:1289 [inline]
RIP: 0010:copy_hugetlb_page_range+0x675/0x3520 mm/hugetlb.c:4940
Code: 00 be ff ff ff ff 48 81 c7 a0 01 00 00 e8 63 46 6c 08 31 ff 89 c5 89 c6 e8 a8 8a ae ff 85 ed 0f 85 dd fd ff ff e8 2b 8f ae ff <0f> 0b e9 d1 fd ff ff e8 1f 8f ae ff 49 89 ec 31 ff 41 81 e4 ff 0f
RSP: 0000:ffffc900059574a0 EFLAGS: 00010287
RAX: 000000000000c9e1 RBX: 0000000020000000 RCX: ffffc9000bdec000
RDX: 0000000000040000 RSI: ffffffff81d9c695 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: ffffffff910db240 R12: ffff888027212f80
R13: ffff8880177d0e00 R14: 0000000020000000 R15: dffffc0000000000
FS:  00007f2f1edb46c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b3152b000 CR3: 000000001d027000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 copy_page_range+0x1dc2/0x3c40 mm/memory.c:1293
 dup_mmap+0x13f3/0x1d80 kernel/fork.c:758
 dup_mm kernel/fork.c:1686 [inline]
 copy_mm kernel/fork.c:1735 [inline]
 copy_process+0x6cc9/0x74b0 kernel/fork.c:2497
 kernel_clone+0xfd/0x920 kernel/fork.c:2902
 __do_sys_clone3+0x1f1/0x260 kernel/fork.c:3203
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f2f1e07cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2f1edb3f98 EFLAGS: 00000246 ORIG_RAX: 00000000000001b3
RAX: ffffffffffffffda RBX: 0000000000000058 RCX: 00007f2f1e07cae9
RDX: 00007f2f1edb3fb0 RSI: 0000000000000058 RDI: 00007f2f1edb3fb0
RBP: 00007f2f1e0c847a R08: 0000000000000000 R09: 0000000000000058
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f2f1e19c050 R15: 00007ffe03b1a6e8
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
