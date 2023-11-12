Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4A47E8F8F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 12:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjKLLEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 06:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjKLLEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 06:04:49 -0500
Received: from mail-pg1-f207.google.com (mail-pg1-f207.google.com [209.85.215.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2B82D5E
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 03:04:46 -0800 (PST)
Received: by mail-pg1-f207.google.com with SMTP id 41be03b00d2f7-5aaae6f46e1so4080195a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 03:04:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699787086; x=1700391886;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3RnzHBbhjkhazRCLz60AVFolh9Rj4jRAESAh5FIgDJs=;
        b=G/WRZZAgVByAAHcQOeRPEsiA9hgNQjXjuLxTmoG+/HkcK5FziH6on11Feezkfq6N+r
         3qQ7tzBgbtwTqiH0gRVHJTnnI4umiXxWcY7m54cIEeRihcsAlS36lm86I1l+65/D0tWk
         O+5saNlR6UJ/fO83E2J8nS9hPtVvsBq5GkFMkMbxCbiUaM3w2RWKOZ72alZ93YnC7MyK
         nmKfEwOxtYB9gKbLtlNrniUn6g0sYO/qxvalhMGhGYC516Ey88g7Om+2qAVaY9jkaxPP
         rX7NU12AhyHMKPZ/YPbvtq3uBP0DkY8Oqy+L9twgFPEeS0EqrHXHD9mtZFou320H8oC/
         ppuQ==
X-Gm-Message-State: AOJu0YwgKQbdHiatfXHdxVykIX2H97huqC9y5/fUJRWkCypXwDm1wlkc
        hvE3KQi0jpcccOvHc3goXYWqUdkaXEzBWU8+NBKBDafLsBeB/lLa8g==
X-Google-Smtp-Source: AGHT+IHVEOXEIEPUxwLJVnIdbFzLeY+MiRS5cGspCfcG0qAPQZlv+dwSeNjFXF1KHYsV7dZLIi3gid9O683/mZPy83lsU0QDm2Se
MIME-Version: 1.0
X-Received: by 2002:a05:6a02:496:b0:5bd:8130:d2a3 with SMTP id
 bw22-20020a056a02049600b005bd8130d2a3mr1279056pgb.5.1699787085952; Sun, 12
 Nov 2023 03:04:45 -0800 (PST)
Date:   Sun, 12 Nov 2023 03:04:45 -0800
In-Reply-To: <000000000000f5ce160602f29dd6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000073bd820609f2857d@google.com>
Subject: Re: [syzbot] Re: [syzbot] [btrfs?] memory leak in btrfs_ref_tree_mod
From:   syzbot <syzbot+d66de4cbf532749df35f@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
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

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [btrfs?] memory leak in btrfs_ref_tree_mod
Author: bragathemanick0908@gmail.com

#syz test: 
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git 
25aa0bebba72b318e71fe205bfd1236550cc9534

On 15/08/23 14:45, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    25aa0bebba72 Merge tag 'net-6.5-rc6' of git://git.kernel.o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=169577fda80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2bf8962e4f7984f4
> dashboard link: https://syzkaller.appspot.com/bug?extid=d66de4cbf532749df35f
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148191c3a80000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/76b0857d2814/disk-25aa0beb.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/a01574755257/vmlinux-25aa0beb.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/262002db770e/bzImage-25aa0beb.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/b93cffaa6717/mount_0.gz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+d66de4cbf532749df35f@syzkaller.appspotmail.com
>
> BUG: memory leak
> unreferenced object 0xffff888129851240 (size 64):
>    comm "syz-executor.0", pid 5069, jiffies 4294977377 (age 16.480s)
>    hex dump (first 32 bytes):
>      01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>    backtrace:
>      [<ffffffff815545e5>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1076
>      [<ffffffff821731b1>] kmalloc include/linux/slab.h:582 [inline]
>      [<ffffffff821731b1>] btrfs_ref_tree_mod+0x211/0xb80 fs/btrfs/ref-verify.c:768
>      [<ffffffff820444f6>] btrfs_free_tree_block+0x116/0x450 fs/btrfs/extent-tree.c:3250
>      [<ffffffff8202d775>] __btrfs_cow_block+0x6a5/0xa30 fs/btrfs/ctree.c:601
>      [<ffffffff8202dc54>] btrfs_cow_block+0x154/0x2b0 fs/btrfs/ctree.c:712
>      [<ffffffff8206013c>] commit_cowonly_roots+0x8c/0x3f0 fs/btrfs/transaction.c:1276
>      [<ffffffff820647c9>] btrfs_commit_transaction+0x999/0x15c0 fs/btrfs/transaction.c:2410
>      [<ffffffff8205a516>] btrfs_commit_super+0x86/0xb0 fs/btrfs/disk-io.c:4195
>      [<ffffffff8205c743>] close_ctree+0x543/0x730 fs/btrfs/disk-io.c:4349
>      [<ffffffff8166b44e>] generic_shutdown_super+0x9e/0x1c0 fs/super.c:499
>      [<ffffffff8166b769>] kill_anon_super+0x19/0x30 fs/super.c:1110
>      [<ffffffff8202357d>] btrfs_kill_super+0x1d/0x30 fs/btrfs/super.c:2138
>      [<ffffffff8166ca46>] deactivate_locked_super+0x46/0xd0 fs/super.c:330
>      [<ffffffff8166cb6c>] deactivate_super fs/super.c:361 [inline]
>      [<ffffffff8166cb6c>] deactivate_super+0x9c/0xb0 fs/super.c:357
>      [<ffffffff816a8931>] cleanup_mnt+0x121/0x210 fs/namespace.c:1254
>      [<ffffffff812becaf>] task_work_run+0x8f/0xe0 kernel/task_work.c:179
>
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the bug is already fixed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to change bug's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the bug is a duplicate of another bug, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>
