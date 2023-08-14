Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21CB77B1DA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 08:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbjHNGuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 02:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbjHNGuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 02:50:03 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B86EE5E
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 23:50:01 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fe9f226cdbso2199690e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 23:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691995799; x=1692600599;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lm5f99L+h1JSYyjk5EEvbPnrq5YGNN50N4Z/7PTJY9g=;
        b=Fz86JQ9/hoYzC8m+syUBZBShwLvxBrJEAEuekiH55hyz61H1acRCjPHCl2GQraqHUP
         5MEIXKrPfyG0hYdPCCPJ1+QjToRiHYG7jQbcXZBS45/0H3YyaDXXQkEiDkLydlKzHXwG
         S9MiKQmPBvKHHs8LCkNnw4qliWhlaskqjROq7lomo4kbbW6HQsEOasm938JcYiRk/5rM
         XysU7Z6+7utIPJo1WHKiAKnZJbknI8yyZesOghHR/KPEqwqqDGHtZVMseLmBa0ie+HEX
         I/c3K2Jx1920UcQ/LjhtJ0x4Au/Khtkcyh2vRo9fabBN/VTIvL85lE2yCJ8yMmAIA4/I
         L52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691995799; x=1692600599;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lm5f99L+h1JSYyjk5EEvbPnrq5YGNN50N4Z/7PTJY9g=;
        b=VlXuirRkCkDxJTu3TUwGgalZPgMvgljRkJSMAGw6XSCz9mAww1nmQzd6bnpkUBa/3w
         9xx765qoV18vDjX/aH2xedIXCd9HFTxTEeGlEwpCLwjNAqbjcg85Sf3Op5RuHlHw+MQq
         N+mRpg7OeRILf02Eo4YE126JxXzWhnSIKi72gzNXqf2BYAX1K8HhUDMxaJnG8lwNxzcF
         fmLbaYyJoNL/NNrm9MOxM1YwkBZ35XosvKTyowwXn3CexOtHawVdGmUqJjEQKrPGxIFR
         QNRHh44gIbkvowairGdBUmaFNoP0hbcyBSr1e7csGSotSryfRjGp6+edqrHQcn6Yxrtl
         LzIQ==
X-Gm-Message-State: AOJu0YxxeqrhqtbbOIkm2e+RbLR7Y8LhrKxsowPT8tugAAY4fC5ZO5gK
        gLIxO615QsAGqfcPwx+hn1iMlW5xjNtXFs8RpL4=
X-Google-Smtp-Source: AGHT+IHPbKal32P5mVB5UQfTt5STP80hLVUx9Olt0Op0gXGG+rlTIdVNGMuDa024c8c41gnhu+2Iq/YoywZMQLY3N8g=
X-Received: by 2002:a05:6512:3e26:b0:4ff:7004:545e with SMTP id
 i38-20020a0565123e2600b004ff7004545emr2898164lfv.4.1691995798829; Sun, 13 Aug
 2023 23:49:58 -0700 (PDT)
MIME-Version: 1.0
From:   Yikebaer Aizezi <yikebaer61@gmail.com>
Date:   Mon, 14 Aug 2023 14:49:47 +0800
Message-ID: <CALcu4rbCwMHyi3w7Ruv=eRw-nq7+cxz8fJ+WCoN932mDjg-vBg@mail.gmail.com>
Subject: WARNING in kernfs_remove_by_name_ns
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When using Healer to fuzz the Linux-6.5-rc5,  the following crash
was triggered.

HEAD commit: 52a93d39b17dc7eb98b6aa3edb93943248e03b2f (tag: v6.5-rc5)
git tree: upstream

And I also tried to reproduce this crash on Latest Linux-6.5-rc6, it
still exist.

console output:
https://drive.google.com/file/d/13w-zb4aiQDvG_nVXK78QgfL9we1p9F-K/view?usp=drive_link
kernel config:https://drive.google.com/file/d/1pm18DQ4m7cYtvcsgJ_kJIR2XQGzg9F-l/view?usp=drive_link
C reproducer:https://drive.google.com/file/d/1roP_zfxeRnrNKij8sKq2_A7MfEicuj1j/view?usp=drive_link
Syzlang reproducer:
https://drive.google.com/file/d/1kk2socy9SmEqyZSFRyAUver8cxoiOOH6/view?usp=drive_link

If you fix this issue, please add the following tag to the commit:
Reported-by: Yikebaer Aizezi <yikebaer61@gmail.com>


memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=8437 'syz-executor'
loop1: detected capacity change from 0 to 32768
BTRFS: device fsid 84eb0a0b-d357-4bc1-8741-9d3223c15974 devid 1
transid 7 /dev/loop1 scanned by syz-executor (8437)
BTRFS info (device loop1): using xxhash64 (xxhash64-generic) checksum algorithm
BTRFS info (device loop1): disk space caching is enabled
BTRFS info (device loop1): enabling ssd optimizations
BTRFS info (device loop1): auto enabling async discard
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 1
CPU: 0 PID: 8437 Comm: syz-executor Not tainted 6.5.0-rc5 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x132/0x150 lib/dump_stack.c:106
 fail_dump lib/fault-inject.c:52 [inline]
 should_fail_ex+0x49f/0x5b0 lib/fault-inject.c:153
 should_failslab+0x5/0x10 mm/slab_common.c:1471
 slab_pre_alloc_hook mm/slab.h:711 [inline]
 slab_alloc_node mm/slub.c:3452 [inline]
 slab_alloc mm/slub.c:3478 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3485 [inline]
 kmem_cache_alloc+0x5e/0x390 mm/slub.c:3494
 kmem_cache_zalloc include/linux/slab.h:693 [inline]
 __kernfs_new_node+0xd4/0x8c0 fs/kernfs/dir.c:611
 kernfs_new_node+0x93/0x120 fs/kernfs/dir.c:675
 __kernfs_create_file+0x51/0x350 fs/kernfs/file.c:1047
 sysfs_add_file_mode_ns+0x20d/0x3e0 fs/sysfs/file.c:294
 create_files fs/sysfs/group.c:64 [inline]
 internal_create_group+0x319/0xb30 fs/sysfs/group.c:152
 internal_create_groups.part.0+0x90/0x140 fs/sysfs/group.c:192
 internal_create_groups fs/sysfs/group.c:188 [inline]
 sysfs_create_groups+0x25/0x50 fs/sysfs/group.c:218
 create_dir lib/kobject.c:70 [inline]
 kobject_add_internal+0x316/0x9b0 lib/kobject.c:233
 kobject_add_varg lib/kobject.c:367 [inline]
 kobject_init_and_add+0xfd/0x170 lib/kobject.c:450
 btrfs_sysfs_add_qgroups+0x160/0x280 fs/btrfs/sysfs.c:2288
 btrfs_quota_enable+0x2c5/0x1d20 fs/btrfs/qgroup.c:991
 btrfs_ioctl_quota_ctl fs/btrfs/ioctl.c:3694 [inline]
 btrfs_ioctl+0x4855/0x59d0 fs/btrfs/ioctl.c:4657
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x199/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x47959d
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b4 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa2a6973068 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000059c0a0 RCX: 000000000047959d
RDX: 0000000020005800 RSI: 00000000c0109428 RDI: 0000000000000003
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000059c0ac
R13: 000000000000000b R14: 0000000000437250 R15: 00007fa2a6953000
 </TASK>
kobject: kobject_add_internal failed for qgroups (error: -12 parent:
84eb0a0b-d357-4bc1-8741-9d3223c15974)
------------[ cut here ]------------
kernfs: can not remove 'enabled', no directory
WARNING: CPU: 0 PID: 8437 at fs/kernfs/dir.c:1658
kernfs_remove_by_name_ns+0xfd/0x120 fs/kernfs/dir.c:1658
Modules linked in:
CPU: 0 PID: 8437 Comm: syz-executor Not tainted 6.5.0-rc5 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:kernfs_remove_by_name_ns+0xfd/0x120 fs/kernfs/dir.c:1658
Code: c3 e8 b7 f3 79 ff 4c 89 e7 41 bc fe ff ff ff e8 49 20 5a ff eb
da e8 a2 f3 79 ff 4c 89 ee 48 c7 c7 60 e1 ff 89 e8 a3 f7 41 ff <0f> 0b
41 bc fe ff ff ff eb bc e8 84 be c9 ff e9 61 ff ff ff e8 7a
RSP: 0018:ffffc90006e7f910 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffffffff8c917868 RCX: ffffc90002b09000
RDX: 0000000000040000 RSI: ffffffff81486023 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 203a73666e72656b R12: 0000000000000000
R13: ffffffff8a38a4c0 R14: 0000000000000000 R15: ffff888029514038
FS:  00007fa2a6973640(0000) GS:ffff888063c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000505c10 CR3: 0000000029112000 CR4: 0000000000750ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
 kernfs_remove_by_name include/linux/kernfs.h:618 [inline]
 remove_files+0x96/0x1c0 fs/sysfs/group.c:28
 sysfs_remove_group+0x87/0x170 fs/sysfs/group.c:292
 sysfs_remove_groups fs/sysfs/group.c:316 [inline]
 sysfs_remove_groups+0x5c/0xa0 fs/sysfs/group.c:308
 __kobject_del+0x89/0x1f0 lib/kobject.c:588
 kobject_del lib/kobject.c:620 [inline]
 kobject_del+0x3c/0x60 lib/kobject.c:612
 btrfs_sysfs_del_qgroups fs/btrfs/sysfs.c:2263 [inline]
 btrfs_sysfs_del_qgroups+0x119/0x1a0 fs/btrfs/sysfs.c:2251
 btrfs_sysfs_add_qgroups+0x204/0x280 fs/btrfs/sysfs.c:2302
 btrfs_quota_enable+0x2c5/0x1d20 fs/btrfs/qgroup.c:991
 btrfs_ioctl_quota_ctl fs/btrfs/ioctl.c:3694 [inline]
 btrfs_ioctl+0x4855/0x59d0 fs/btrfs/ioctl.c:4657
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x199/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x47959d
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b4 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa2a6973068 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000059c0a0 RCX: 000000000047959d
RDX: 0000000020005800 RSI: 00000000c0109428 RDI: 0000000000000003
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000059c0ac
R13: 000000000000000b R14: 0000000000437250 R15: 00007fa2a6953000
 </TASK>

Modules linked in:
CPU: 0 PID: 8437 Comm: syz-executor Not tainted 6.5.0-rc5 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:kernfs_remove_by_name_ns+0xfd/0x120 fs/kernfs/dir.c:1658
Code: c3 e8 b7 f3 79 ff 4c 89 e7 41 bc fe ff ff ff e8 49 20 5a ff eb
da e8 a2 f3 79 ff 4c 89 ee 48 c7 c7 60 e1 ff 89 e8 a3 f7 41 ff <0f> 0b
41 bc fe ff ff ff eb bc e8 84 be c9 ff e9 61 ff ff ff e8 7a
RSP: 0018:ffffc90006e7f910 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffffffff8c917868 RCX: ffffc90002b09000
RDX: 0000000000040000 RSI: ffffffff81486023 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 203a73666e72656b R12: 0000000000000000
R13: ffffffff8a38a4c0 R14: 0000000000000000 R15: ffff888029514038
FS:  00007fa2a6973640(0000) GS:ffff888063c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000505c10 CR3: 0000000029112000 CR4: 0000000000750ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
 kernfs_remove_by_name include/linux/kernfs.h:618 [inline]
 remove_files+0x96/0x1c0 fs/sysfs/group.c:28
 sysfs_remove_group+0x87/0x170 fs/sysfs/group.c:292
 sysfs_remove_groups fs/sysfs/group.c:316 [inline]
 sysfs_remove_groups+0x5c/0xa0 fs/sysfs/group.c:308
 __kobject_del+0x89/0x1f0 lib/kobject.c:588
 kobject_del lib/kobject.c:620 [inline]
 kobject_del+0x3c/0x60 lib/kobject.c:612
 btrfs_sysfs_del_qgroups fs/btrfs/sysfs.c:2263 [inline]
 btrfs_sysfs_del_qgroups+0x119/0x1a0 fs/btrfs/sysfs.c:2251
 btrfs_sysfs_add_qgroups+0x204/0x280 fs/btrfs/sysfs.c:2302
 btrfs_quota_enable+0x2c5/0x1d20 fs/btrfs/qgroup.c:991
 btrfs_ioctl_quota_ctl fs/btrfs/ioctl.c:3694 [inline]
 btrfs_ioctl+0x4855/0x59d0 fs/btrfs/ioctl.c:4657
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x199/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x47959d
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b4 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa2a6973068 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000059c0a0 RCX: 000000000047959d
RDX: 0000000020005800 RSI: 00000000c0109428 RDI: 0000000000000003
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000059c0ac
R13: 000000000000000b R14: 0000000000437250 R15: 00007fa2a6953000
 </TASK>
Kernel panic - not syncing: kernel: panic_on_warn set ...
CPU: 0 PID: 8437 Comm: syz-executor Not tainted 6.5.0-rc5 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd5/0x150 lib/dump_stack.c:106
 panic+0x67e/0x730 kernel/panic.c:340
 check_panic_on_warn+0xad/0xb0 kernel/panic.c:236
 __warn+0xee/0x390 kernel/panic.c:673
 __report_bug lib/bug.c:199 [inline]
 report_bug+0x2d9/0x500 lib/bug.c:219
 handle_bug+0x3c/0x70 arch/x86/kernel/traps.c:324
 exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:345
 asm_exc_invalid_op+0x16/0x20 arch/x86/include/asm/idtentry.h:568
RIP: 0010:kernfs_remove_by_name_ns+0xfd/0x120 fs/kernfs/dir.c:1658
Code: c3 e8 b7 f3 79 ff 4c 89 e7 41 bc fe ff ff ff e8 49 20 5a ff eb
da e8 a2 f3 79 ff 4c 89 ee 48 c7 c7 60 e1 ff 89 e8 a3 f7 41 ff <0f> 0b
41 bc fe ff ff ff eb bc e8 84 be c9 ff e9 61 ff ff ff e8 7a
RSP: 0018:ffffc90006e7f910 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffffffff8c917868 RCX: ffffc90002b09000
RDX: 0000000000040000 RSI: ffffffff81486023 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 203a73666e72656b R12: 0000000000000000
R13: ffffffff8a38a4c0 R14: 0000000000000000 R15: ffff888029514038
 kernfs_remove_by_name include/linux/kernfs.h:618 [inline]
 remove_files+0x96/0x1c0 fs/sysfs/group.c:28
 sysfs_remove_group+0x87/0x170 fs/sysfs/group.c:292
 sysfs_remove_groups fs/sysfs/group.c:316 [inline]
 sysfs_remove_groups+0x5c/0xa0 fs/sysfs/group.c:308
 __kobject_del+0x89/0x1f0 lib/kobject.c:588
 kobject_del lib/kobject.c:620 [inline]
 kobject_del+0x3c/0x60 lib/kobject.c:612
 btrfs_sysfs_del_qgroups fs/btrfs/sysfs.c:2263 [inline]
 btrfs_sysfs_del_qgroups+0x119/0x1a0 fs/btrfs/sysfs.c:2251
 btrfs_sysfs_add_qgroups+0x204/0x280 fs/btrfs/sysfs.c:2302
 btrfs_quota_enable+0x2c5/0x1d20 fs/btrfs/qgroup.c:991
 btrfs_ioctl_quota_ctl fs/btrfs/ioctl.c:3694 [inline]
 btrfs_ioctl+0x4855/0x59d0 fs/btrfs/ioctl.c:4657
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x199/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x47959d
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b4 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa2a6973068 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000059c0a0 RCX: 000000000047959d
RDX: 0000000020005800 RSI: 00000000c0109428 RDI: 0000000000000003
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000059c0ac
R13: 000000000000000b R14: 0000000000437250 R15: 00007fa2a6953000
 </TASK>
Dumping ftrace buffer:
   (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 1 seconds..
