Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443C97E8B45
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 15:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjKKOrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 09:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjKKOrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 09:47:10 -0500
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131C43AB9
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 06:47:07 -0800 (PST)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-280051630e5so3553493a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 06:47:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699714025; x=1700318825;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iQm1NCJBI3DVkYRlCskxdiSqXN+6wR7W71BOolJrFkg=;
        b=TE26WyzZ1Lvnv9Oq/nvIRINIk837rjCuwOE846iJUo/b/qb6/g7DD84hZ5zhF9AB2Z
         QtsKfIQ5l0P7NeLBOzaJFBysObjcs1DD/vMK7r8NJhhbXX3LtPRR4JgMKsotVYnUTXoL
         bPgYwBlEz900xm7ER32nC/o9+14v8SD3MtOqb1wgT9EKXKTo5TFFcRmq1wrM788yrbdn
         k8CIPhmUnNcSrakBjq5pOlMxWK3um+BeGJGZDzSFJ3jG+XySyjVeTChm8WeKsItMqJVo
         ErB/+NuHv4L8y7xw7/HwJ/SU6W+N5iLiF+j80sRIBGkqlkgPXQ2W7Tm4vRMcO23wuORT
         wQMQ==
X-Gm-Message-State: AOJu0YyXYIwfBm0LPWftgiQvakPLfPh7xLALzSMDWxZ+hOlHZhEgeWVa
        oZWBYwfCkVV+yUHIlne9w8F8aEXkmENH82lB1pFC6FqYWoxq5Ug=
X-Google-Smtp-Source: AGHT+IGJfTLqodUJqbhIfQe5SsSj+AweEvHq0Gw2PSVXShS4l35EpwXmphWrYgSwl39hLMtGgfk4SdLVqUrFdQPobceaF7tKpphc
MIME-Version: 1.0
X-Received: by 2002:a17:90a:d105:b0:27d:63e0:792 with SMTP id
 l5-20020a17090ad10500b0027d63e00792mr541030pju.2.1699714025109; Sat, 11 Nov
 2023 06:47:05 -0800 (PST)
Date:   Sat, 11 Nov 2023 06:47:04 -0800
In-Reply-To: <GV1PR10MB656393AB6AC7AD6B055814C3E8ADA@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000afbee90609e182ee@google.com>
Subject: Re: [syzbot] [block?] WARNING in floppy_revalidate
From:   syzbot <syzbot+c5732f0517748c2c8051@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        yuran.pereira@hotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in floppy_revalidate

------------[ cut here ]------------
WARNING: CPU: 2 PID: 5371 at drivers/block/floppy.c:999 schedule_bh drivers/block/floppy.c:999 [inline]
WARNING: CPU: 2 PID: 5371 at drivers/block/floppy.c:999 process_fd_request drivers/block/floppy.c:2847 [inline]
WARNING: CPU: 2 PID: 5371 at drivers/block/floppy.c:999 floppy_revalidate.isra.0+0x911/0xca0 drivers/block/floppy.c:4214
Modules linked in:
CPU: 2 PID: 5371 Comm: syz-executor.0 Not tainted 6.6.0-syzkaller-16159-g3ca112b71f35 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:schedule_bh drivers/block/floppy.c:999 [inline]
RIP: 0010:process_fd_request drivers/block/floppy.c:2847 [inline]
RIP: 0010:floppy_revalidate.isra.0+0x911/0xca0 drivers/block/floppy.c:4214
Code: 07 0f 86 d2 f7 ff ff 48 89 de 48 c7 c7 20 ca f8 8c e8 43 9b 81 ff e9 be f7 ff ff e8 59 4f 0e fd e9 77 fa ff ff e8 df 7a ba fc <0f> 0b e9 04 fb ff ff e8 d3 7a ba fc 48 83 fb 07 0f 87 58 03 00 00
RSP: 0018:ffffc9000383f8e8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffff84c93273
RDX: ffff888022140000 RSI: ffffffff84c93771 RDI: 0000000000000001
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000001
R13: ffff88801e762000 R14: 0000000000000050 R15: 0000000000000001
FS:  00007f2ea16386c0(0000) GS:ffff88806ba00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2ea0588000 CR3: 0000000017284000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 floppy_open+0xa74/0xe00 drivers/block/floppy.c:4061
 blkdev_get_whole+0x93/0x2c0 block/bdev.c:640
 blkdev_get_by_dev.part.0+0x211/0xb20 block/bdev.c:795
 blkdev_get_by_dev block/bdev.c:851 [inline]
 bdev_open_by_dev+0x166/0x1c0 block/bdev.c:840
 blkdev_open+0xe6/0x390 block/fops.c:600
 do_dentry_open+0x8d4/0x18d0 fs/open.c:948
 do_open fs/namei.c:3622 [inline]
 path_openat+0x1d26/0x2c20 fs/namei.c:3779
 do_filp_open+0x1cb/0x410 fs/namei.c:3809
 do_sys_openat2+0x15c/0x1c0 fs/open.c:1440
 do_sys_open fs/open.c:1455 [inline]
 __do_sys_openat fs/open.c:1471 [inline]
 __se_sys_openat fs/open.c:1466 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1466
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x3f/0xe0 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f2ea0478640
Code: 48 89 44 24 20 75 93 44 89 54 24 0c e8 09 7e 02 00 44 8b 54 24 0c 89 da 48 89 ee 41 89 c0 bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 77 38 44 89 c7 89 44 24 0c e8 5c 7e 02 00 8b 44
RSP: 002b:00007f2ea1637c00 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f2ea0478640
RDX: 0000000000000000 RSI: 00007f2ea1637ca0 RDI: 00000000ffffff9c
RBP: 00007f2ea1637ca0 R08: 0000000000000000 R09: 002364662f766564
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 000000000000000b R14: 00007f2ea058bf60 R15: 00007ffef761ff28
 </TASK>


Tested on:

commit:         3ca112b7 Merge tag 'probes-fixes-v6.7-rc1' of git://gi..
git tree:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1491ec2f680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=44a532e1ba684f13
dashboard link: https://syzkaller.appspot.com/bug?extid=c5732f0517748c2c8051
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
