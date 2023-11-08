Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B107E59A2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 16:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbjKHPBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 10:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjKHPBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 10:01:41 -0500
Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8041BE4
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 07:01:39 -0800 (PST)
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-6cd0a9b5a90so9707225a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 07:01:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699455698; x=1700060498;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6LqIztK5sqIUqLI07DaATWBMeUGb1bfpP4v378T+XPo=;
        b=HEP/7ggqFPDC9BNy6j6u2bhtFcbA6JFF3J+VSU173cN1NUjCIv4EfJksx0J3cLLXlk
         Z+yyUHmbueA5PPKXSxwoVHAgXBbrGSGmcLd/K6Eo3FLIuEELi7ranBKe/tKjANFPhSrB
         M6wx+4ol4oSO+Em128oJO29bf2KOtrm9mnPNV2s/aDyt6FiU6w7pyLEBu3pmNPcCik6S
         35ypkQP6YR0CyCOOIhkWk/fA892+VedIYkxKY2WhYQ3e9Zktdhgem72zlQoEmQ87FHPy
         rcKyoUJ+Ld822BV6y4SlX7Mqsedtftm6qnCECPYl3bbbJGjs94ywmihHeyuPE7KCFraE
         044A==
X-Gm-Message-State: AOJu0YwyPsOfhoIFGar1gn0t6HULSQfAeNrPKK4YO4VnrZ3Zn3KT4ukF
        SewpTwD7+tDsoY4a73pDcRMuuMioo6NhTKF5FNPxzgX4+Dto
X-Google-Smtp-Source: AGHT+IEwZUGdPuRRvdDTfVm4G4F3cDzyWKXpEThqnBqQlVhZHwBf5AITtkOsINuLkwH5t9O5gP9WjF91cWvPSmTEAZkC1m21H3mb
MIME-Version: 1.0
X-Received: by 2002:a05:6830:2445:b0:6bf:27b3:3d29 with SMTP id
 x5-20020a056830244500b006bf27b33d29mr602704otr.5.1699455693260; Wed, 08 Nov
 2023 07:01:33 -0800 (PST)
Date:   Wed, 08 Nov 2023 07:01:33 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e890bc0609a55cff@google.com>
Subject: [syzbot] [f2fs?] kernel BUG in f2fs_evict_inode (2)
From:   syzbot <syzbot+31e4659a3fe953aec2f4@syzkaller.appspotmail.com>
To:     chao@kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    90b0c2b2edd1 Merge tag 'pinctrl-v6.7-1' of git://git.kerne..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10222eeb680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=93ac5233c138249e
dashboard link: https://syzkaller.appspot.com/bug?extid=31e4659a3fe953aec2f4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13a2847b680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1579d0df680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/10c213d23300/disk-90b0c2b2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0c55e6e441c1/vmlinux-90b0c2b2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c7f0436ea052/bzImage-90b0c2b2.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/dbf260983b94/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+31e4659a3fe953aec2f4@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/f2fs/inode.c:933!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5054 Comm: syz-executor410 Not tainted 6.6.0-syzkaller-14142-g90b0c2b2edd1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
RIP: 0010:f2fs_evict_inode+0x1576/0x1590 fs/f2fs/inode.c:933
Code: fd 31 ff 89 de e8 5a 4f bf fd 40 84 ed 75 29 e8 c0 4c bf fd 4c 8b 74 24 08 e9 c9 eb ff ff e8 b1 4c bf fd 0f 0b e8 aa 4c bf fd <0f> 0b e8 a3 4c bf fd 0f 0b e9 f6 fe ff ff e8 97 4c bf fd e8 72 e7
RSP: 0018:ffffc900039df918 EFLAGS: 00010293
RAX: ffffffff83cf9f56 RBX: 0000000000000002 RCX: ffff888014b30000
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff83cf984a R09: 1ffff1100ed0061d
R10: dffffc0000000000 R11: ffffed100ed0061e R12: 1ffff1100ed0058f
R13: ffff888076802c38 R14: ffff8880768030e8 R15: dffffc0000000000
FS:  00005555556ae3c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdbe23ce18 CR3: 00000000727e8000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 evict+0x2a4/0x620 fs/inode.c:664
 dispose_list fs/inode.c:697 [inline]
 evict_inodes+0x5f8/0x690 fs/inode.c:747
 generic_shutdown_super+0x9d/0x2c0 fs/super.c:675
 kill_block_super+0x44/0x90 fs/super.c:1667
 kill_f2fs_super+0x303/0x3b0 fs/f2fs/super.c:4894
 deactivate_locked_super+0xc1/0x130 fs/super.c:484
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1256
 task_work_run+0x24a/0x300 kernel/task_work.c:180
 ptrace_notify+0x2cd/0x380 kernel/signal.c:2399
 ptrace_report_syscall include/linux/ptrace.h:411 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:473 [inline]
 syscall_exit_work kernel/entry/common.c:251 [inline]
 syscall_exit_to_user_mode_prepare kernel/entry/common.c:278 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x15c/0x280 kernel/entry/common.c:296
 do_syscall_64+0x50/0x110 arch/x86/entry/common.c:88
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fa1a5e8ee77
Code: 08 00 48 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b0 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffdbe23d5c8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000021a97 RCX: 00007fa1a5e8ee77
RDX: 0000000000000000 RSI: 000000000000000a RDI: 00007ffdbe23d680
RBP: 00007ffdbe23d680 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000202 R12: 00007ffdbe23e740
R13: 00005555556af700 R14: 431bde82d7b634db R15: 00007ffdbe23e6e4
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:f2fs_evict_inode+0x1576/0x1590 fs/f2fs/inode.c:933
Code: fd 31 ff 89 de e8 5a 4f bf fd 40 84 ed 75 29 e8 c0 4c bf fd 4c 8b 74 24 08 e9 c9 eb ff ff e8 b1 4c bf fd 0f 0b e8 aa 4c bf fd <0f> 0b e8 a3 4c bf fd 0f 0b e9 f6 fe ff ff e8 97 4c bf fd e8 72 e7
RSP: 0018:ffffc900039df918 EFLAGS: 00010293
RAX: ffffffff83cf9f56 RBX: 0000000000000002 RCX: ffff888014b30000
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff83cf984a R09: 1ffff1100ed0061d
R10: dffffc0000000000 R11: ffffed100ed0061e R12: 1ffff1100ed0058f
R13: ffff888076802c38 R14: ffff8880768030e8 R15: dffffc0000000000
FS:  00005555556ae3c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdbe23ce18 CR3: 00000000727e8000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
