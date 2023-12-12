Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE79B80EDD4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346580AbjLLNm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346530AbjLLNm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:42:26 -0500
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6B6B3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 05:42:32 -0800 (PST)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3b9e358994fso8109639b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 05:42:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702388551; x=1702993351;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9lr/imkOYa5nk1h6kKwJCa39yKpwIsegcMLxoKTU+9k=;
        b=He5+t92M8b9cyoLN5fV8NH9lteRBeeBny2YIyys9/qxiEnUyQYMysaNEVnAtyHUqvQ
         7ze97SMjq9HvcMDnZErtnV4rF+xgef1zFh7SKuqy3MG6xyNKtYc9DPbDwWD8+21oFtJM
         sWmkhZ9S/Q3icb+TXBeHpk5sFmX2eIVY6Jr2Coyz4qxoMNeYp17CEleV6h9quZb9rlJY
         ZeVTiKxgVB2S6SH/nXbefr4zIAImHiTuQqxi1mHxJuQNd2M/mMD2Ips97W4k4YxpPP+j
         k93OD8MnNGg8+W7cuIi/qe/iBhOJCS3LDrWmHKHJHj5jA6WwFXP9bDQb8bT4QtEg5+R2
         qj6g==
X-Gm-Message-State: AOJu0Yw9466sjfpfNAq91gwWIvrpopY3tb1K9XeXMjrom6bifUafAdld
        IuyjRlyMhnWhxAuA0SxoZDoI81NtWJoBEwMdQdNvJevyCkAc
X-Google-Smtp-Source: AGHT+IHu6TGYoEeVuLFFTX36HYq3U26i7JeGQS4QDsgK6GqNUpHkYLT1qIxZDJR2AYxTtkwjWqZPAHtjoZUJnQ3w6wkvDc0YBP9P
MIME-Version: 1.0
X-Received: by 2002:a05:6808:13c4:b0:3b8:752e:ca8b with SMTP id
 d4-20020a05680813c400b003b8752eca8bmr6061192oiw.11.1702388551738; Tue, 12 Dec
 2023 05:42:31 -0800 (PST)
Date:   Tue, 12 Dec 2023 05:42:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e56be2060c50384c@google.com>
Subject: [syzbot] [mm?] UBSAN: shift-out-of-bounds in xa_load
From:   syzbot <syzbot+bd5b57a026c028fc99b1@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    bee0e7762ad2 Merge tag 'for-linus-iommufd' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=159a938ce80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ffc3b780d2eb08e4
dashboard link: https://syzkaller.appspot.com/bug?extid=bd5b57a026c028fc99b1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ea3746c5fd0b/disk-bee0e776.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7b21a5c93cec/vmlinux-bee0e776.xz
kernel image: https://storage.googleapis.com/syzbot-assets/72c56b464d44/bzImage-bee0e776.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bd5b57a026c028fc99b1@syzkaller.appspotmail.com

================================================================================
UBSAN: shift-out-of-bounds in lib/xarray.c:195:22
shift exponent 72 is too large for 64-bit type 'long unsigned int'
CPU: 0 PID: 5105 Comm: syz-executor.3 Not tainted 6.7.0-rc4-syzkaller-00009-gbee0e7762ad2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_shift_out_of_bounds+0x2a6/0x480 lib/ubsan.c:387
 xas_start.cold+0x35/0x3a lib/xarray.c:195
 xas_load+0x1c/0x140 lib/xarray.c:237
 xa_load+0xf9/0x2c0 lib/xarray.c:1461
 list_lru_from_memcg_idx mm/list_lru.c:56 [inline]
 list_lru_from_memcg_idx mm/list_lru.c:53 [inline]
 list_lru_from_kmem mm/list_lru.c:78 [inline]
 list_lru_add+0x3d2/0x540 mm/list_lru.c:128
 __inode_add_lru.part.0+0x109/0x1d0 fs/inode.c:467
 __inode_add_lru fs/inode.c:460 [inline]
 iput_final fs/inode.c:1754 [inline]
 iput.part.0+0x6a9/0x7b0 fs/inode.c:1803
 iput+0x5c/0x80 fs/inode.c:1793
 dentry_unlink_inode+0x292/0x430 fs/dcache.c:401
 __dentry_kill+0x3b8/0x640 fs/dcache.c:607
 shrink_dentry_list+0x11e/0x4a0 fs/dcache.c:1201
 shrink_dcache_parent+0xdf/0x3b0 fs/dcache.c:1652
 do_one_tree fs/dcache.c:1681 [inline]
 shrink_dcache_for_umount+0x79/0x340 fs/dcache.c:1698
 generic_shutdown_super+0x76/0x3d0 fs/super.c:668
 kill_block_super+0x3b/0x90 fs/super.c:1667
 deactivate_locked_super+0xbc/0x1a0 fs/super.c:484
 deactivate_super+0xde/0x100 fs/super.c:517
 cleanup_mnt+0x222/0x450 fs/namespace.c:1256
 task_work_run+0x14d/0x240 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa92/0x2ae0 kernel/exit.c:871
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1021
 __do_sys_exit_group kernel/exit.c:1032 [inline]
 __se_sys_exit_group kernel/exit.c:1030 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1030
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7faf0c27cae9
Code: Unable to access opcode bytes at 0x7faf0c27cabf.
RSP: 002b:00007fff1203b1f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 000000000000000b RCX: 00007faf0c27cae9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000000000b
RBP: 00007fff1203b88c R08: 0000000000000001 R09: 000000000000000b
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000032
R13: 000000000012dca2 R14: 000000000012d97d R15: 0000000000000004
 </TASK>
================================================================================


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
