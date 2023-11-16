Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C897EDE02
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 10:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345004AbjKPJxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 04:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344956AbjKPJxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 04:53:30 -0500
Received: from mail-pg1-f207.google.com (mail-pg1-f207.google.com [209.85.215.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59028E0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:53:26 -0800 (PST)
Received: by mail-pg1-f207.google.com with SMTP id 41be03b00d2f7-5c1b986082dso652929a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:53:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700128406; x=1700733206;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TGFeETijn5gpNnYM4nN6xlKFUYFfT5fG57XpqChy2YI=;
        b=akYBnsJy9OyfHg1ZQeJEt4ExQlnnlvn9vos6jDjayCFxsm3wMtgstAR3L9fNlZcKnp
         Zz/Psy+IMYEz8lBcb/qBrkQSBrCU1T9mB7U3WI4XZlIQIybMJv2Nh3t+PTrieHqzCdcs
         Cw/Z7V7OF33qBjyADvl7SQrHtDCFVflwrQlbc+lMdg5WTp7X1le1UjInN9eXHIhtD/o0
         w+cW/Y9GtTtcaQVy3uVygpZri12D7ZoT2n3WCp+RvyBxqyPBQ9zrAgyaJ1AZIFvZKnKm
         W4h+vN4Fm9QTUBXB9o8GUf/EvRqwu61sJ44rFshDloNctjYgrTAwYRNExXn6KoIvnr0R
         ulmg==
X-Gm-Message-State: AOJu0YxhVPlJO+lwkLjk+Nrt/6jDNtEMVMR6SBXFgVCSJUapGolqccO6
        KZFdSnXNzthIdGhKEUozgeA/fiLkLEpyLQopo4Ir5Js0W0DE
X-Google-Smtp-Source: AGHT+IFogAZ4bvp2CXiUK3PU66MvCM4xJEc50QAjeA1rM2PjVZbIdOiEfChDQOJEzK8Koa8dun6hKvKBJEXoxbjN5QrEwSfcVe6q
MIME-Version: 1.0
X-Received: by 2002:a63:1017:0:b0:589:5235:b3cb with SMTP id
 f23-20020a631017000000b005895235b3cbmr204427pgl.3.1700128405845; Thu, 16 Nov
 2023 01:53:25 -0800 (PST)
Date:   Thu, 16 Nov 2023 01:53:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b3fe4d060a41fdeb@google.com>
Subject: [syzbot] [udf?] WARNING in udf_prealloc_blocks (2)
From:   syzbot <syzbot+cc2b732891efbf755b78@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    1b907d050735 Merge tag '6.7-rc-smb3-client-fixes-part2' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10d7f898e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=88e7ba51eecd9cd6
dashboard link: https://syzkaller.appspot.com/bug?extid=cc2b732891efbf755b78
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/567b9cb02431/disk-1b907d05.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7d18e697c356/vmlinux-1b907d05.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b0d7c3147ec4/bzImage-1b907d05.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cc2b732891efbf755b78@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 26000 at fs/udf/udfdecl.h:123 udf_add_free_space fs/udf/balloc.c:121 [inline]
WARNING: CPU: 1 PID: 26000 at fs/udf/udfdecl.h:123 udf_table_prealloc_blocks fs/udf/balloc.c:572 [inline]
WARNING: CPU: 1 PID: 26000 at fs/udf/udfdecl.h:123 udf_prealloc_blocks+0xf13/0x1310 fs/udf/balloc.c:705
Modules linked in:
CPU: 1 PID: 26000 Comm: syz-executor.1 Not tainted 6.6.0-syzkaller-16176-g1b907d050735 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
RIP: 0010:udf_updated_lvid fs/udf/udfdecl.h:121 [inline]
RIP: 0010:udf_add_free_space fs/udf/balloc.c:121 [inline]
RIP: 0010:udf_table_prealloc_blocks fs/udf/balloc.c:572 [inline]
RIP: 0010:udf_prealloc_blocks+0xf13/0x1310 fs/udf/balloc.c:705
Code: 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 43 a2 84 fe e9 4b f7 ff ff e8 39 a2 84 fe 0f 0b e9 67 f8 ff ff e8 2d a2 84 fe <0f> 0b e9 c9 fe ff ff 89 d9 80 e1 07 fe c1 38 c1 0f 8c 08 f2 ff ff
RSP: 0018:ffffc90015907180 EFLAGS: 00010287
RAX: ffffffff830a2023 RBX: 0000000030303d6b RCX: 0000000000040000
RDX: ffffc9000b843000 RSI: 00000000000376bd RDI: 00000000000376be
RBP: ffffc900159072f0 R08: ffffffff830a1ee6 R09: 1ffffffff1e01a45
R10: dffffc0000000000 R11: fffffbfff1e01a46 R12: ffff88801fd724c0
R13: dffffc0000000000 R14: ffff88803d3c901c R15: ffff88802220c630
FS:  00007fbe5ec496c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3093398000 CR3: 000000007b4ef000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 udf_prealloc_extents fs/udf/inode.c:1032 [inline]
 inode_getblk fs/udf/inode.c:890 [inline]
 udf_map_block+0x285d/0x5560 fs/udf/inode.c:444
 __udf_get_block+0x126/0x410 fs/udf/inode.c:458
 __block_write_begin_int+0x54d/0x1ac0 fs/buffer.c:2119
 __block_write_begin fs/buffer.c:2168 [inline]
 block_write_begin+0x9b/0x1e0 fs/buffer.c:2227
 udf_write_begin+0x10d/0x1a0 fs/udf/inode.c:261
 generic_perform_write+0x31b/0x630 mm/filemap.c:3918
 udf_file_write_iter+0x2fd/0x660 fs/udf/file.c:111
 call_write_iter include/linux/fs.h:2020 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x792/0xb20 fs/read_write.c:584
 ksys_write+0x1a0/0x2c0 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fbe5de7cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbe5ec490c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fbe5df9c050 RCX: 00007fbe5de7cae9
RDX: 000000006db6e559 RSI: 0000000020000080 RDI: 0000000000000007
RBP: 00007fbe5dec847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007fbe5df9c050 R15: 00007ffe85dd4218
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
