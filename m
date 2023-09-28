Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C45D7B1CAD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 14:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbjI1Mjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 08:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbjI1Mjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 08:39:42 -0400
Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com [209.85.160.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCFB139
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 05:39:39 -0700 (PDT)
Received: by mail-oa1-f80.google.com with SMTP id 586e51a60fabf-1e122a7b3f3so80012fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 05:39:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695904779; x=1696509579;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jevz1aHUBwU4uRYvTUoYpDv/bvWb4GE53HcLNdy3s4g=;
        b=e/o/UAbThVpoiUn/WfpwFsfzhzq9OFwGLsAFy4CPyVbiCF6WQS6m7d3JFuKwKqqVCS
         8VbSs/b9OyLkZxSawX9OUJBij5+bQH/oF9S4zxJmm6I6wmvRYeDtmiXHKBpnBvqqKuvE
         zfWaV7/Paw1961uPCd5X2NUY3QrlGCGCSS5KNWqSDtlalZEG4yyoq0JfWC4CfLuq3xfk
         qwGD0kOrGdQEVsKp5QmKEcSJ/CD2ti/jY0HOGS7VeTv/qf2SOQu5hTdCE4X7mCKFKOGC
         s66peoUwvc0zAd1sVgBrHSPtxp09FxX9H4I09Q3NNNVtxCOyAqcVPmrYX9NNalIz3XVx
         QtRA==
X-Gm-Message-State: AOJu0Yx6z0Irxys/ADxXaboNyxnHDZaZvOaPhl63rwmaYLKNzGWrlcs0
        e36pc26/NkMRaoDm7XISnLrR8NyDdH4lePODMBLp7jpcMmN3
X-Google-Smtp-Source: AGHT+IF+tGoV4uxaTQ/zdwl2ZaJnmdjSs2bcHo8WJKEiSAZD6jmIQM5TVx8AfijNJMuib4JYzCqihL+K1SwZ+Qmbj3BVNPUMJ0Z7
MIME-Version: 1.0
X-Received: by 2002:a05:6870:c784:b0:1e1:509:417a with SMTP id
 dy4-20020a056870c78400b001e10509417amr439319oab.3.1695904779351; Thu, 28 Sep
 2023 05:39:39 -0700 (PDT)
Date:   Thu, 28 Sep 2023 05:39:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f2412406066a99fc@google.com>
Subject: [syzbot] [ntfs3?] WARNING in pivot_root
From:   syzbot <syzbot+8f6bf34e4614f7c14d20@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
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

HEAD commit:    940fcc189c51 Add linux-next specific files for 20230921
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=177ba9ea680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1f140ae6e669ac24
dashboard link: https://syzkaller.appspot.com/bug?extid=8f6bf34e4614f7c14d20
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16bf6c66680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b8921b235c24/disk-940fcc18.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c80a9f6bcdd4/vmlinux-940fcc18.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ed10a4df6950/bzImage-940fcc18.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/f85df51588c9/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8f6bf34e4614f7c14d20@syzkaller.appspotmail.com

DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) != current) && !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE)): count = 0x0, magic = 0xffff888065021950, owner = 0x0, curr 0xffff888014bf5940, list empty
WARNING: CPU: 1 PID: 12010 at kernel/locking/rwsem.c:1369 __up_write kernel/locking/rwsem.c:1369 [inline]
WARNING: CPU: 1 PID: 12010 at kernel/locking/rwsem.c:1369 up_write+0x458/0x510 kernel/locking/rwsem.c:1632
Modules linked in:
CPU: 1 PID: 12010 Comm: syz-executor.5 Not tainted 6.6.0-rc2-next-20230921-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
RIP: 0010:__up_write kernel/locking/rwsem.c:1369 [inline]
RIP: 0010:up_write+0x458/0x510 kernel/locking/rwsem.c:1632
Code: c1 ea 03 80 3c 02 00 75 50 48 8b 13 4d 89 f1 41 55 4d 89 f8 4c 89 e1 48 c7 c6 a0 a1 8c 8a 48 c7 c7 c0 a0 8c 8a e8 58 c2 e6 ff <0f> 0b 5a e9 aa fc ff ff 48 89 ef e8 a8 62 77 00 e9 17 fd ff ff 48
RSP: 0018:ffffc9000a427db0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff888065021950 RCX: 0000000000000000
RDX: ffff888014bf5940 RSI: ffffffff814e0c56 RDI: 0000000000000001
RBP: ffff888065021958 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 205d303130323154 R12: ffff888065021950
R13: ffffffff8a8ca000 R14: ffff888014bf5940 R15: 0000000000000000
FS:  00007fd662a136c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6bf48c8390 CR3: 000000007377a000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 inode_unlock include/linux/fs.h:807 [inline]
 unlock_mount fs/namespace.c:2510 [inline]
 __do_sys_pivot_root+0x11f9/0x1660 fs/namespace.c:4254
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fd661c7cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd662a130c8 EFLAGS: 00000246 ORIG_RAX: 000000000000009b
RAX: ffffffffffffffda RBX: 00007fd661d9c050 RCX: 00007fd661c7cae9
RDX: 0000000000000000 RSI: 0000000020000040 RDI: 0000000020000000
RBP: 00007fd661cc847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fd661d9c050 R15: 00007ffc9588c7b8
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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
