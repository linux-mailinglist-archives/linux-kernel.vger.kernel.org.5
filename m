Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85A37EC352
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 14:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343873AbjKONKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 08:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343723AbjKONKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 08:10:23 -0500
Received: from mail-pj1-f78.google.com (mail-pj1-f78.google.com [209.85.216.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3444311D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 05:10:20 -0800 (PST)
Received: by mail-pj1-f78.google.com with SMTP id 98e67ed59e1d1-280051630e5so792524a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 05:10:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700053819; x=1700658619;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GGFOD+SswvszkCd9NdrJ4tCTHqRxa0bbMEMtPHBloQw=;
        b=jEBWhM7ifTaJnEdV2OraeTOJ65geK0Z0AoNRvdmxLkNEKgB73g/chxY1I13NZpYVJ5
         rQeBNEtMNIblUrz4jVpKLo1X81Yus9Yd8idSSD51mhskyo/OsIWZahYrGl+kDGgiE0c/
         wn29iTNnC8ZerFbXLoDSIPF6CrLrcnbtk9YPQj9Jh0E37jzJ/DsoYErxf9pwGFcgtCvv
         c+/idAehF7zSDXBDuWi9YPt2M6KOoA4K9Mv3Av+H59d6pl3kfbULa4/gHZZ0KkFwhUEK
         8UGf8bvN8QpmMFJ69tC2U4YzVl+tJinUAoIzxHBksUuPypiQUCnLkDk+5lRCQwW6wPe7
         qvJg==
X-Gm-Message-State: AOJu0Yx0Hh6WRQQab7Za9CoDC/lfinopoDYLBnKEwLOCaYxUEhTdGuOh
        65aRvGrCtHfzRjAp/rS79b/YgyMZg1f/co7XeGykde47jwpC
X-Google-Smtp-Source: AGHT+IHgmAzP2ljyYih+VgCgRxouP/AWnFtK4XziDV6ioyFOGmSQOQcPcVI+Mp6K9HvwIn6yI6HWxrVm6L5REW+ZLDq38QZUYYL7
MIME-Version: 1.0
X-Received: by 2002:a17:90b:38d1:b0:280:37ee:d2ab with SMTP id
 nn17-20020a17090b38d100b0028037eed2abmr3787626pjb.1.1700053819662; Wed, 15
 Nov 2023 05:10:19 -0800 (PST)
Date:   Wed, 15 Nov 2023 05:10:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000526f2060a30a085@google.com>
Subject: [syzbot] [squashfs?] WARNING in squashfs_read_data
From:   syzbot <syzbot+32d3767580a1ea339a81@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        phillip@squashfs.org.uk, squashfs-devel@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_BL_SPAMCOP_NET,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ac347a0655db Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=145669a7680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=287570229f5c0a7c
dashboard link: https://syzkaller.appspot.com/bug?extid=32d3767580a1ea339a81
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=159441ff680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d2822f680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/00e30e1a5133/disk-ac347a06.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/07c43bc37935/vmlinux-ac347a06.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c6690c715398/bzImage-ac347a06.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/296bbea0ae0a/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+32d3767580a1ea339a81@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5071 at fs/squashfs/block.c:46 copy_bio_to_actor fs/squashfs/block.c:46 [inline]
WARNING: CPU: 0 PID: 5071 at fs/squashfs/block.c:46 squashfs_read_data+0xda4/0xf80 fs/squashfs/block.c:344
Modules linked in:
CPU: 0 PID: 5071 Comm: syz-executor362 Not tainted 6.6.0-syzkaller-16039-gac347a0655db #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
RIP: 0010:copy_bio_to_actor fs/squashfs/block.c:46 [inline]
RIP: 0010:squashfs_read_data+0xda4/0xf80 fs/squashfs/block.c:344
Code: 04 02 48 89 da 83 e2 07 38 d0 0f 8f 9b f9 ff ff 84 c0 0f 84 93 f9 ff ff 48 89 df e8 06 89 90 ff e9 86 f9 ff ff e8 9c 57 3a ff <0f> 0b 31 ed e9 51 f5 ff ff e8 8e 57 3a ff 0f 0b e9 df f9 ff ff e8
RSP: 0018:ffffc900033de780 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff824d3e77
RDX: ffff8880211001c0 RSI: ffffffff824d4354 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000000
R10: 0000000000000000 R11: ffffffff8a83d81f R12: 0000000000000000
R13: ffff888061b26000 R14: 0000000000000000 R15: ffff88801f0d6e00
FS:  00005555567dd380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005fdeb8 CR3: 0000000014ee9000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 squashfs_readahead+0x16fd/0x24b0 fs/squashfs/file.c:599
 read_pages+0x1d1/0xdb0 mm/readahead.c:160
 page_cache_ra_unbounded+0x457/0x5e0 mm/readahead.c:269
 do_page_cache_ra mm/readahead.c:299 [inline]
 page_cache_ra_order+0x72b/0xa80 mm/readahead.c:546
 ondemand_readahead+0x493/0x1130 mm/readahead.c:668
 page_cache_sync_ra+0x174/0x1d0 mm/readahead.c:695
 page_cache_sync_readahead include/linux/pagemap.h:1266 [inline]
 filemap_get_pages+0xc06/0x1830 mm/filemap.c:2497
 filemap_read+0x39b/0xcf0 mm/filemap.c:2593
 generic_file_read_iter+0x346/0x450 mm/filemap.c:2772
 __kernel_read+0x301/0x870 fs/read_write.c:428
 integrity_kernel_read+0x7f/0xb0 security/integrity/iint.c:221
 ima_calc_file_hash_tfm+0x2c5/0x3d0 security/integrity/ima/ima_crypto.c:485
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
 ima_calc_file_hash+0x1c6/0x4a0 security/integrity/ima/ima_crypto.c:573
 ima_collect_measurement+0x85e/0xa20 security/integrity/ima/ima_api.c:290
 process_measurement+0xe92/0x2260 security/integrity/ima/ima_main.c:359
 ima_file_check+0xc2/0x110 security/integrity/ima/ima_main.c:557
 do_open fs/namei.c:3624 [inline]
 path_openat+0x77b/0x2c40 fs/namei.c:3779
 do_filp_open+0x1de/0x430 fs/namei.c:3809
 do_sys_openat2+0x176/0x1e0 fs/open.c:1440
 do_sys_open fs/open.c:1455 [inline]
 __do_sys_openat fs/open.c:1471 [inline]
 __se_sys_openat fs/open.c:1466 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1466
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fb1acea25f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe1b0ce9b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0031656c69662f2e RCX: 00007fb1acea25f9
RDX: 0000000000000000 RSI: 0000000020000000 RDI: ffffffffffffff9c
RBP: 00007fb1acf15610 R08: 00000000000001e0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffe1b0ceb88 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


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
