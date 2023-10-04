Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1533B7B7AA5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 10:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241765AbjJDIu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 04:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241838AbjJDIuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 04:50:54 -0400
Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D095DA6
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 01:50:50 -0700 (PDT)
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-3ae5a4f9954so2667085b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 01:50:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696409450; x=1697014250;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TaoDc56+fM5Rrge+RQsWrQdw3MmD+mZSmrc8p71R9go=;
        b=FfTlk3pwsdl2rPNyuJZYHLmFQ8lnPu23VuKlhzgbjCOBN2Dtc+1+4whilmfBm0qepF
         zTZFMvY0ekD3zuw47E0tBJ1CA8T4zzosTts1p0RexsNUvvBp3sLCMx2lf9tQOQkwb17g
         YiW9Z8C96ZImGW1EeXEPlJ8M/cnLhZU4Md+Cg7AZWP8FlFptdot/kUpBEPaU6TGftaUW
         t0a/tBIHAzMAZsXUuOph1ZUS8V1KOG5XK0tIsI3rtBLGfhkETyoULAE+xFsaqherv/0N
         lbelefLEaaMlhqz/XAbXXhEFaTGFm1tPDP0iCRWGII5QsVcsxbv0lI1BLF8WUYOUAEBV
         lFow==
X-Gm-Message-State: AOJu0YwJW/Kc4TjxOuqfzgJ1kcM3jquQvyRktJj8+zhomjGt9g1r5N0p
        DoYnTBzbCan++A9POBuRt2cTWqhjfhk3SZX6lepXkFMsFACd
X-Google-Smtp-Source: AGHT+IE75NWbRpO0xTo18dN2Fkyt7GhlwehV9ofSgv1jvfSnJOWnPiU+5Vac4+9mfgYoU/X+uOVu3zeyLf75OyBpuKOcbAhGXrVM
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2001:b0:3ac:b428:844d with SMTP id
 q1-20020a056808200100b003acb428844dmr980351oiw.8.1696409450292; Wed, 04 Oct
 2023 01:50:50 -0700 (PDT)
Date:   Wed, 04 Oct 2023 01:50:50 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000adae8a0606e01a11@google.com>
Subject: [syzbot] [mm?] WARNING in shmem_evict_inode (2)
From:   syzbot <syzbot+511ea6c5201cd9855fea@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    9f3ebbef746f Merge tag '6.6-rc3-ksmbd-server-fixes' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1601a86e680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bb54ecdfa197f132
dashboard link: https://syzkaller.appspot.com/bug?extid=511ea6c5201cd9855fea
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-9f3ebbef.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ffda2bb1181d/vmlinux-9f3ebbef.xz
kernel image: https://storage.googleapis.com/syzbot-assets/df09a869d412/bzImage-9f3ebbef.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+511ea6c5201cd9855fea@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 15996 at mm/shmem.c:1266 shmem_evict_inode+0x871/0xb50 mm/shmem.c:1266
Modules linked in:
CPU: 0 PID: 15996 Comm: syz-executor.2 Not tainted 6.6.0-rc3-syzkaller-00146-g9f3ebbef746f #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:shmem_evict_inode+0x871/0xb50 mm/shmem.c:1266
Code: 89 e6 e8 f2 1f c7 ff 45 85 e4 75 aa e8 78 24 c7 ff 48 8b 74 24 28 48 8b 7c 24 30 e8 d9 0c a4 ff e9 1a fe ff ff e8 5f 24 c7 ff <0f> 0b e9 d3 f9 ff ff e8 53 24 c7 ff 4c 89 e2 48 b8 00 00 00 00 00
RSP: 0018:ffffc90028e0f810 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88801e0757b0 RCX: 0000000000000000
RDX: ffff888021fa0000 RSI: ffffffff81c0a261 RDI: 0000000000000007
RBP: ffffc90028e0f940 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000008 R11: 0000000000000000 R12: 0000000000000008
R13: 0000000000000000 R14: ffff88801e0757e0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88802c600000(0000) knlGS:0000000000000000
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000f72e320e CR3: 0000000019a4e000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 evict+0x2ed/0x6b0 fs/inode.c:664
 iput_final fs/inode.c:1775 [inline]
 iput.part.0+0x55e/0x7a0 fs/inode.c:1801
 iput+0x5c/0x80 fs/inode.c:1791
 dentry_unlink_inode+0x292/0x430 fs/dcache.c:401
 __dentry_kill+0x3b8/0x640 fs/dcache.c:607
 dentry_kill fs/dcache.c:733 [inline]
 dput+0x8b7/0xf80 fs/dcache.c:913
 __fput+0x536/0xa70 fs/file_table.c:392
 task_work_run+0x14d/0x240 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa92/0x2a20 kernel/exit.c:874
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1024
 get_signal+0x23ba/0x2790 kernel/signal.c:2892
 arch_do_signal_or_restart+0x90/0x7f0 arch/x86/kernel/signal.c:309
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x1d/0x60 kernel/entry/common.c:296
 __do_fast_syscall_32+0x6d/0xe0 arch/x86/entry/common.c:181
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x70/0x82
RIP: 0023:0xf7f5e579
Code: Unable to access opcode bytes at 0xf7f5e54f.
RSP: 002b:00000000f7f3865c EFLAGS: 00000292 ORIG_RAX: 00000000000000f0
RAX: fffffffffffffe00 RBX: 00000000f737b050 RCX: 0000000000000080
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000f737b054
RBP: 0000000000000081 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
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

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
