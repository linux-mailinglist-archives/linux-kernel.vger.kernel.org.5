Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5919F791B0B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 18:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352179AbjIDQAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 12:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241905AbjIDQAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 12:00:09 -0400
Received: from mail-pl1-f205.google.com (mail-pl1-f205.google.com [209.85.214.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EB71BE
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 09:00:03 -0700 (PDT)
Received: by mail-pl1-f205.google.com with SMTP id d9443c01a7336-1c093862623so22038375ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 09:00:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693843203; x=1694448003;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+O3G+dlqCRtnovR02+v2yf1Tamh83CEJZbdexepJT5w=;
        b=Ne8ohRib9asTS2T78Y8REsjAvhwxIrMNn2JSWS6l/JTIf/lLVvBKjts4prUZ/5hLRF
         3bRutqz8utoIQtNbAlNTPVls02vao1IO5PL114/nuyNzfutWZxrmgY7QR7xJPY70pi0J
         TVYiwXQb0A2bcWjGqGBXqzRfCsRBDMK6a/QwPmUo5WfTbgEnuQOnAsd6OUP4HHexMU2h
         FfXArgg5N/CGpZvbvadJLqZw+2CfIZiM9OHX4uBCDVjZxQgVo6jyVjKpMUIYWGm68hBP
         Poi9AJR5r8CvRltoZ5paKw+6Kl1tQpNAKOeenvTWxowJeNn+RnWuMvjPjzbbdocjUHLj
         CHqQ==
X-Gm-Message-State: AOJu0YxVWSJ8pAapODE9WkxkmMs5z+6WUO8CgEj7r3nGjd0AvfSP7gfE
        0LT5A8LRrSwnobQHBtHBMCzu9vGF4PvRyLq9xTUc3zDWHpU/
X-Google-Smtp-Source: AGHT+IE4hY1cOldP6E1tE8K6v9oucZ0pUa4JKR7Q8el9qijGMkJhK8JTHvG0bVYm6TQgfeBmuBxCgssMGLGtlQSDM4LK1AE6mRQC
MIME-Version: 1.0
X-Received: by 2002:a17:903:5c5:b0:1ba:a36d:f82c with SMTP id
 kf5-20020a17090305c500b001baa36df82cmr2950872plb.7.1693843203111; Mon, 04 Sep
 2023 09:00:03 -0700 (PDT)
Date:   Mon, 04 Sep 2023 09:00:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006d415806048a9aee@google.com>
Subject: [syzbot] [mm?] BUG: unable to handle kernel paging request in list_lru_add
From:   syzbot <syzbot+2403e3909382fbdeaf6c@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    708283abf896 Merge tag 'dmaengine-6.6-rc1' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17424cd0680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=15f37e053f1602f8
dashboard link: https://syzkaller.appspot.com/bug?extid=2403e3909382fbdeaf6c
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-708283ab.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ae645c88b07f/vmlinux-708283ab.xz
kernel image: https://storage.googleapis.com/syzbot-assets/32d5997bb055/Image-708283ab.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2403e3909382fbdeaf6c@syzkaller.appspotmail.com

Unable to handle kernel paging request at virtual address dfff800000000001
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[dfff800000000001] address between user and kernel address ranges
Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 2922 Comm: udevd Not tainted 6.5.0-syzkaller-11329-g708283abf896 #0
Hardware name: linux,dummy-virt (DT)
pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : list_add_tail include/linux/list.h:183 [inline]
pc : list_lru_add+0x174/0x464 mm/list_lru.c:129
lr : list_lru_from_memcg_idx mm/list_lru.c:56 [inline]
lr : list_lru_from_memcg_idx mm/list_lru.c:53 [inline]
lr : list_lru_from_kmem mm/list_lru.c:78 [inline]
lr : list_lru_add+0x354/0x464 mm/list_lru.c:128
sp : ffff80008dd57520
x29: ffff80008dd57520 x28: 0000000000000008 x27: ffff0000378c4000
x26: 0000000000000001 x25: 0000000000000000 x24: 0000000000000000
x23: 1fffe0000293550a x22: 0000000000000000 x21: ffff000012d1c7a0
x20: ffff0000149aa850 x19: ffff0000146f7a00 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: ffff800080915234
x14: ffff800080914c58 x13: ffff800080914c58 x12: 000000000000f1f1
x11: dfff800000000000 x10: 00000000f3000000 x9 : 00000000f3f3f3f3
x8 : ffff700011baae76 x7 : 00000000f1f1f1f1 x6 : dfff800000000000
x5 : ffff700011baae7a x4 : 00000000f204f1f1 x3 : 1fffe0000d51ff28
x2 : 0000000000000000 x1 : 0000000000000000 x0 : dfff800000000000
Call trace:
 list_add_tail include/linux/list.h:183 [inline]
 list_lru_add+0x174/0x464 mm/list_lru.c:129
 d_lru_add+0x180/0x31c fs/dcache.c:431
 retain_dentry fs/dcache.c:685 [inline]
 dput+0x4ac/0x96c fs/dcache.c:908
 handle_mounts fs/namei.c:1554 [inline]
 step_into+0xc18/0x16c4 fs/namei.c:1839
 walk_component+0xa8/0x484 fs/namei.c:2007
 link_path_walk.part.0.constprop.0+0x4cc/0x970 fs/namei.c:2328
 link_path_walk fs/namei.c:2253 [inline]
 path_openat+0x1bc/0x2058 fs/namei.c:3792
 do_filp_open+0x16c/0x330 fs/namei.c:3823
 do_sys_openat2+0x12c/0x160 fs/open.c:1422
 do_sys_open fs/open.c:1437 [inline]
 __do_sys_openat fs/open.c:1453 [inline]
 __se_sys_openat fs/open.c:1448 [inline]
 __arm64_sys_openat+0x12c/0x1b8 fs/open.c:1448
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x6c/0x258 arch/arm64/kernel/syscall.c:51
 el0_svc_common.constprop.0+0xac/0x230 arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x40/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x58/0x140 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
Code: 9100231c d2d00000 f2fbffe0 d343ff9a (38e06b40) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	9100231c 	add	x28, x24, #0x8
   4:	d2d00000 	mov	x0, #0x800000000000        	// #140737488355328
   8:	f2fbffe0 	movk	x0, #0xdfff, lsl #48
   c:	d343ff9a 	lsr	x26, x28, #3
* 10:	38e06b40 	ldrsb	w0, [x26, x0] <-- trapping instruction


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
