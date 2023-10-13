Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B9C7C7CD8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 06:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjJMEyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 00:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjJMEyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 00:54:50 -0400
Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com [209.85.160.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F17B8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 21:54:49 -0700 (PDT)
Received: by mail-oa1-f80.google.com with SMTP id 586e51a60fabf-1e9d9455085so602379fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 21:54:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697172888; x=1697777688;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SwYVpevaQwL/6JF220Z5RzC5YKswvThkgc2P6vpL/Ho=;
        b=Hb6Qz2+eX8Sc1++VkKA5I3dqIFRJcTtGa6VHBXabwkHOFdX3DOXKi7zVJmaRXfjhbm
         bSUGUnd7jhoVMPS5N8Gt7k1VriwYjrAHYevd7WLqzyrNPEZ306dqbuBCZrtstbQc1sVX
         ISrDaTa1Iqj5qrlrKrhpws6Q7skbki1pSOMTFX1wgrKnH1wuDTmLu33YOXj3SzNe7ACo
         bzpQS9MGzsBrvYW5aTLea17Kb+4YngzmXkK6d9qjHM6WWOiNIJT+Y1FSCnfluhQwL+UR
         1R1PkZGEyKJKjEXhuHtZ4VWyu9SZCKbYQK+Mf6EBIjoREOWTUKNwDrmCQns8IIScnCur
         IjAA==
X-Gm-Message-State: AOJu0Yw1sBfCOdBhGw/lhsgy5xwM0VjFA36lYkJqaWllxqsoGfBWyIOF
        CGPQ7kttp4Wxj7V/OQK87Nq5aWEhuOyJ3wwRar1O4mj53X5b
X-Google-Smtp-Source: AGHT+IFDvtqIDlT8JaQF5luYaGpLaRwul93qlQxjWILeO1p5NrXnOHlXacfH8jMZH0Hzs4QNIH9X/NZ6AwDN7zhlOnGGTeb9jjIn
MIME-Version: 1.0
X-Received: by 2002:a05:6870:498f:b0:1e5:7384:b6c0 with SMTP id
 ho15-20020a056870498f00b001e57384b6c0mr7713769oab.0.1697172888477; Thu, 12
 Oct 2023 21:54:48 -0700 (PDT)
Date:   Thu, 12 Oct 2023 21:54:48 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000023e628060791db6b@google.com>
Subject: [syzbot] [mm?] WARNING in del_page_from_free_list
From:   syzbot <syzbot+f4c63b85f107b94a33be@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
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

syzbot found the following issue on:

HEAD commit:    98897dc735cf Add linux-next specific files for 20230914
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14bda274680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1502c503717ada5c
dashboard link: https://syzkaller.appspot.com/bug?extid=f4c63b85f107b94a33be
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/00e4c0af5a8a/disk-98897dc7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7b54a00eee56/vmlinux-98897dc7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/100094353b8e/bzImage-98897dc7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f4c63b85f107b94a33be@syzkaller.appspotmail.com

------------[ cut here ]------------
page type is 1, passed migratetype is 0 (nr=512)
WARNING: CPU: 1 PID: 21258 at mm/page_alloc.c:699 del_page_from_free_list+0x36e/0x490 mm/page_alloc.c:699
Modules linked in:
CPU: 1 PID: 21258 Comm: syz-executor.4 Not tainted 6.6.0-rc1-next-20230914-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
RIP: 0010:del_page_from_free_list+0x36e/0x490 mm/page_alloc.c:699
Code: 89 ef be 07 00 00 00 e8 e0 f6 ff ff 44 89 e1 44 89 f2 48 c7 c7 a0 b6 99 8a 48 89 c6 b8 01 00 00 00 d3 e0 89 c1 e8 22 2f 7c ff <0f> 0b e9 d2 fc ff ff 48 c7 c6 00 b8 99 8a 48 89 df e8 9c 46 f4 ff
RSP: 0018:ffffc90015f974b8 EFLAGS: 00010082
RAX: 0000000000000000 RBX: ffffea0001c50000 RCX: 0000000000000000
RDX: ffff8880b52f9dc0 RSI: ffffffff814e0396 RDI: 0000000000000001
RBP: 0000000000071400 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 000000000005f3e0 R12: 0000000000000009
R13: ffff88813fffa700 R14: 0000000000000000 R15: ffffea0001c50000
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b31328000 CR3: 000000000c976000 CR4: 00000000003506e0
Call Trace:
 <TASK>
 __free_one_page+0x3eb/0xa50 mm/page_alloc.c:830
 free_pcppages_bulk+0x2f3/0x610 mm/page_alloc.c:1233
 free_unref_page_list+0x859/0x1050 mm/page_alloc.c:2568
 release_pages+0x32a/0x14e0 mm/swap.c:1042
 __folio_batch_release+0x77/0xe0 mm/swap.c:1062
 folio_batch_release include/linux/pagevec.h:83 [inline]
 shmem_undo_range+0x580/0x1140 mm/shmem.c:1022
 shmem_truncate_range mm/shmem.c:1131 [inline]
 shmem_evict_inode+0x392/0xb50 mm/shmem.c:1260
 evict+0x2ed/0x6b0 fs/inode.c:666
 iput_final fs/inode.c:1777 [inline]
 iput.part.0+0x55e/0x7a0 fs/inode.c:1803
 iput+0x5c/0x80 fs/inode.c:1793
 dentry_unlink_inode+0x292/0x430 fs/dcache.c:401
 __dentry_kill+0x3b8/0x640 fs/dcache.c:607
 dentry_kill fs/dcache.c:733 [inline]
 dput+0x8b7/0xf80 fs/dcache.c:913
 __fput+0x536/0xa70 fs/file_table.c:392
 task_work_run+0x14d/0x240 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa92/0x2ae0 kernel/exit.c:871
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1021
 __do_sys_exit_group kernel/exit.c:1032 [inline]
 __se_sys_exit_group kernel/exit.c:1030 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1030
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fb789e7cae9
Code: Unable to access opcode bytes at 0x7fb789e7cabf.
RSP: 002b:00007ffc4f7dc4a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 000000000000001e RCX: 00007fb789e7cae9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000001 R08: 0000000000001270 R09: 0000000000000000
R10: 0000001b31720000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000001
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
