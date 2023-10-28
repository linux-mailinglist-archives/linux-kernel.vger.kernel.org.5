Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E987DA7FD
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 18:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjJ1QQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 12:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1QQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 12:16:28 -0400
Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E886ED
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 09:16:26 -0700 (PDT)
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-3b3f893e38aso4761143b6e.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 09:16:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698509785; x=1699114585;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o0hEhIscQ/Xsk7B5flULZwRcurSz+Ug42O5a0ySLsTs=;
        b=NUGnQPKPArJmVir5EC9u7oF21HWuPpWPz2ihI3tlFKGNmrb1Vp3lKHSXnsF2bSAV+j
         wJNlBPNXpSTKfjlbp9i26TXmGHsR/S96BioFo2Y45ositm4nBsNglzmS8Jc61vrd/St6
         Ze0X+Nx/cgywyzi/91Ag2QyMloZF0D7Bil5eo46ou/Iu/OxEX3bGF0KzRHjC5MZ0nXtM
         aC1kcMSqOGd66/EN1G5Wo5cw5fHQfmxoPGgPCybF/nE7k49snupMWtBrXLKFG3rSpGvY
         6bjNv2yvdqwvj0SSrifOqDoi/T3TgwZ7EPLWGspS3FWRfqnqSoEWxlFKDTftpNo8LuyV
         Ri1w==
X-Gm-Message-State: AOJu0Yz2O6v+Q98gGyolvxBh3BVYq/jhmU/rwKUVxYrPNF3yqNOe0vX+
        zaDql8eu2VACoitxjZAA8JncguQsUuhdBD/Ai6ePKpHhkMYU
X-Google-Smtp-Source: AGHT+IFL81W1XUVEGZhOjwNRi7Ek/RKHCHPzyX22MBYry7pjh83EVJJZJcgUxHIxLbCA6fuSvi0SvR9ap2iV4nKogIs5BO3nnANq
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1cc:b0:3a4:1e93:8988 with SMTP id
 x12-20020a05680801cc00b003a41e938988mr1649632oic.10.1698509785426; Sat, 28
 Oct 2023 09:16:25 -0700 (PDT)
Date:   Sat, 28 Oct 2023 09:16:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000068704f0608c92013@google.com>
Subject: [syzbot] [ntfs?] kernel BUG in ntfs_prepare_pages_for_non_resident_write
 (2)
From:   syzbot <syzbot+05958f1fac9df0497492@syzkaller.appspotmail.com>
To:     anton@tuxera.com, linkinjeon@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com
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

HEAD commit:    d88520ad73b7 Merge tag 'pull-nfsd-fix' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16225fcd680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ee601744db6e780
dashboard link: https://syzkaller.appspot.com/bug?extid=05958f1fac9df0497492
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ea9c20c54c8e/disk-d88520ad.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/452b35a0a731/vmlinux-d88520ad.xz
kernel image: https://storage.googleapis.com/syzbot-assets/83daea53f9cf/bzImage-d88520ad.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+05958f1fac9df0497492@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/ntfs/file.c:951!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 23700 Comm: syz-executor.4 Not tainted 6.6.0-rc7-syzkaller-00018-gd88520ad73b7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
RIP: 0010:ntfs_prepare_pages_for_non_resident_write+0x42fd/0x5b90 fs/ntfs/file.c:951
Code: 85 12 02 00 00 48 8b 44 24 08 bf ff 0f 00 00 8b 58 2c 89 de e8 54 22 cf fe 81 fb ff 0f 00 00 0f 86 1a e5 ff ff e8 d3 26 cf fe <0f> 0b e8 cc 26 cf fe 0f b6 9c 24 50 01 00 00 31 ff 89 de e8 eb 21
RSP: 0018:ffffc9000356f878 EFLAGS: 00010246
RAX: 0000000000040000 RBX: fffffffffffffffd RCX: ffffc9000bff3000
RDX: 0000000000040000 RSI: ffffffff82b8b35d RDI: 0000000000000007
RBP: 0000000000000101 R08: 0000000000000007 R09: ffffffffffffffff
R10: fffffffffffffffd R11: ffffffff81dd8d15 R12: ffff88806a284018
R13: 0000000000000000 R14: dffffc0000000000 R15: 0000000000040000
FS:  00007ff492baa6c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2fd34000 CR3: 0000000079e0c000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 ntfs_perform_write.isra.0+0x63c/0x3170 fs/ntfs/file.c:1844
 ntfs_file_write_iter+0xbff/0x1e00 fs/ntfs/file.c:1916
 call_write_iter include/linux/fs.h:1956 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x650/0xe40 fs/read_write.c:584
 ksys_write+0x12f/0x250 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff491e7cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff492baa0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007ff491f9c120 RCX: 00007ff491e7cae9
RDX: 000000000000000b RSI: 00000000200007c0 RDI: 0000000000000004
RBP: 00007ff491ec847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007ff491f9c120 R15: 00007ffd5eee77b8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ntfs_prepare_pages_for_non_resident_write+0x42fd/0x5b90 fs/ntfs/file.c:951
Code: 85 12 02 00 00 48 8b 44 24 08 bf ff 0f 00 00 8b 58 2c 89 de e8 54 22 cf fe 81 fb ff 0f 00 00 0f 86 1a e5 ff ff e8 d3 26 cf fe <0f> 0b e8 cc 26 cf fe 0f b6 9c 24 50 01 00 00 31 ff 89 de e8 eb 21
RSP: 0018:ffffc9000356f878 EFLAGS: 00010246
RAX: 0000000000040000 RBX: fffffffffffffffd RCX: ffffc9000bff3000
RDX: 0000000000040000 RSI: ffffffff82b8b35d RDI: 0000000000000007
RBP: 0000000000000101 R08: 0000000000000007 R09: ffffffffffffffff
R10: fffffffffffffffd R11: ffffffff81dd8d15 R12: ffff88806a284018
R13: 0000000000000000 R14: dffffc0000000000 R15: 0000000000040000
FS:  00007ff492baa6c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020821000 CR3: 0000000079e0c000 CR4: 0000000000350ee0


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
