Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B181D7F1322
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 13:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbjKTMWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 07:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbjKTMWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 07:22:31 -0500
Received: from mail-pf1-f205.google.com (mail-pf1-f205.google.com [209.85.210.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4D5EB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 04:22:27 -0800 (PST)
Received: by mail-pf1-f205.google.com with SMTP id d2e1a72fcca58-6b74afe92dbso4925740b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 04:22:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700482947; x=1701087747;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fw31MFHJ1e61+W+iQEgWSL31uVgjkGuivJh7Ct5zSno=;
        b=d5oEiwvUBeIqUMuq9zljE4yAOacamVA3QZmyo5vYiQPiuKm5MLw10hVbFitWIJ4lnt
         Viv9IvRn6v5oqFCABKhKjKkC004BhCt3cWTqVrJgu3DLNY/wmDut4Z4lzF2XWuMpvWIN
         gqP5wHPSxrPYBcwIoW2ZAhKYxJNW97gBrluuTXjUuL72JD4TOfKnqGD6IKuonMG+tIfB
         nZe4STbfeBQuBtQimYhAboz+6BQi9AB0GE1dDHc4/UBOJ0pxuxKEDcUZnZZQTJTDKIda
         0c82nZprznTp0+05gzuTvY93KgAcBZ6D5HfQX0JtmaKVM/vq/wr+qCsWakoeFiUQg3uJ
         de9A==
X-Gm-Message-State: AOJu0Yx+l4fe4kzMW4gCQGXvr6rZdogXTB8lfDnjvJjSekH7DBgTp/Vl
        jMvDRzlJNuPS/VtRVh4cY3qxnHujOVVVhD2PpwXgonlMkvQo
X-Google-Smtp-Source: AGHT+IEfz/rvqygg+44ElXcHj5ORzSu0NhcMmRQ87wTgJO+RLtEX7yZ8Lo9wfuATYdccMuAH5ZZ/4N0IGS4DVg2tg8D0Ly7tRkFy
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:e0e:b0:6be:3dca:7d9d with SMTP id
 bq14-20020a056a000e0e00b006be3dca7d9dmr2035893pfb.5.1700482945313; Mon, 20
 Nov 2023 04:22:25 -0800 (PST)
Date:   Mon, 20 Nov 2023 04:22:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e6f3f4060a94898f@google.com>
Subject: [syzbot] [reiserfs?] WARNING in reiserfs_ioctl (2)
From:   syzbot <syzbot+1226ab53d5b557d64251@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    c42d9eeef8e5 Merge tag 'hardening-v6.7-rc2' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1304d797680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d05dd66e2eb2c872
dashboard link: https://syzkaller.appspot.com/bug?extid=1226ab53d5b557d64251
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2ef75a216da3/disk-c42d9eee.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dc9e5a2c2dd2/vmlinux-c42d9eee.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0f11915f952a/bzImage-c42d9eee.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1226ab53d5b557d64251@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: CPU: 1 PID: 4030 at kernel/locking/mutex.c:582 __mutex_lock_common kernel/locking/mutex.c:582 [inline]
WARNING: CPU: 1 PID: 4030 at kernel/locking/mutex.c:582 __mutex_lock+0xc36/0xd60 kernel/locking/mutex.c:747
Modules linked in:
CPU: 1 PID: 4030 Comm: syz-executor.0 Not tainted 6.7.0-rc1-syzkaller-00019-gc42d9eeef8e5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
RIP: 0010:__mutex_lock_common kernel/locking/mutex.c:582 [inline]
RIP: 0010:__mutex_lock+0xc36/0xd60 kernel/locking/mutex.c:747
Code: 0f b6 04 20 84 c0 0f 85 18 01 00 00 83 3d 21 d6 e0 03 00 75 19 90 48 c7 c7 40 9a 6a 8b 48 c7 c6 e0 9a 6a 8b e8 cb 39 34 f6 90 <0f> 0b 90 90 90 e9 c8 f4 ff ff 90 0f 0b 90 e9 d6 f8 ff ff 90 0f 0b
RSP: 0018:ffffc9000328fd20 EFLAGS: 00010246
RAX: 7ede61b6dd80c100 RBX: 0000000000000000 RCX: 0000000000040000
RDX: ffffc90004c51000 RSI: 00000000000023d8 RDI: 00000000000023d9
RBP: ffffc9000328fe78 R08: ffffffff81545a92 R09: 1ffff11017325172
R10: dffffc0000000000 R11: ffffed1017325173 R12: dffffc0000000000
R13: ffff88803671b028 R14: 0000000000000000 R15: dffffc0000000000
FS:  00007f847f8926c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdf0d8e5000 CR3: 0000000028105000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 reiserfs_write_lock+0x7a/0xd0 fs/reiserfs/lock.c:27
 reiserfs_ioctl+0x74/0x2f0 fs/reiserfs/ioctl.c:81
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x45/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f847ea7cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f847f8920c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f847eb9bf80 RCX: 00007f847ea7cae9
RDX: 0000000020000080 RSI: 00000000c0185879 RDI: 0000000000000005
RBP: 00007f847eac847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f847eb9bf80 R15: 00007ffcbd03c0f8
 </TASK>


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
