Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F737CD226
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 04:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjJRCJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 22:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJRCJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 22:09:09 -0400
Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88E2F7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 19:09:06 -0700 (PDT)
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-581ead8a0deso943338eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 19:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697594946; x=1698199746;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rQ7FtIypEQj/f0AClAakDsoov2FH7bW4DoRItDFF3Y4=;
        b=dNHw5C7MXCcx5GT2dbRfbd1aSBYpD7qI3N19fnm+mZ0+91U517eg9KXl34kSDU4dAk
         J6X+UJaMzrlBaVzyQKI5rNzgwcpZJCdKZqGh8Mu3yfGHqGUI6+CtxZyShVLKpDcaTDZH
         TLv4PsKl5xSydqrokI9L+5yPkXjDT0yb5CN5/sdg1rKBWFiSbjrIuLS3Rf/eh/jSwg+m
         z8JhI4RUmigJubK++MWvL+3I70IO+0oF+SdDp9HuRfgiv7v7fb680ClfJhXKGDzE7HB1
         /uAT56eestWt490KLLmBdKFkxqYi37evmVGI7Ixbi+uZP6UcyQbBWVq+ASuyBmJCHFOc
         PJ4g==
X-Gm-Message-State: AOJu0Yw6rMtV6murx6aiCuw0r9QfGWzeeDwOVWCoSy/XMMwSUjMWohQw
        Jc80XVKDGsIuNOe1TWMkH8TzBfJh+eBb5jZpQYl6qA1MPaid
X-Google-Smtp-Source: AGHT+IF55VEEnFC9axfjk4buoZPO8zoDFpjn6naxOcQfT0tnl8TKXXtSXnbzJyx64tdTShwDxZVJapPsQWtI/XcnD1cd29vZaMBQ
MIME-Version: 1.0
X-Received: by 2002:a05:6870:3282:b0:1d6:5e45:3bc7 with SMTP id
 q2-20020a056870328200b001d65e453bc7mr1646497oac.5.1697594946128; Tue, 17 Oct
 2023 19:09:06 -0700 (PDT)
Date:   Tue, 17 Oct 2023 19:09:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bc90a60607f41fc3@google.com>
Subject: [syzbot] [mm?] [kasan?] WARNING in __kfence_free (3)
From:   syzbot <syzbot+59f37b0ab4c558a5357c@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, dvyukov@google.com, elver@google.com,
        glider@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    213f891525c2 Merge tag 'probes-fixes-v6.6-rc6' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14a731f9680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4436b383d761e86
dashboard link: https://syzkaller.appspot.com/bug?extid=59f37b0ab4c558a5357c
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-213f8915.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/98b9a78b6226/vmlinux-213f8915.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8ed2ef54968f/Image-213f8915.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+59f37b0ab4c558a5357c@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 3252 at mm/kfence/core.c:1147 __kfence_free+0x7c/0xb4 mm/kfence/core.c:1147
Modules linked in:
CPU: 1 PID: 3252 Comm: syz-executor.1 Not tainted 6.6.0-rc6-syzkaller-00029-g213f891525c2 #0
Hardware name: linux,dummy-virt (DT)
pstate: 81400009 (Nzcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
pc : __kfence_free+0x7c/0xb4 mm/kfence/core.c:1147
lr : kfence_free include/linux/kfence.h:187 [inline]
lr : __slab_free+0x48c/0x508 mm/slub.c:3614
sp : ffff800082cebb50
x29: ffff800082cebb50 x28: f7ff000002c0c400 x27: ffff8000818ca8a8
x26: ffff8000821f0620 x25: 0000000000000001 x24: ffff00007ffa3000
x23: 0000000000000001 x22: ffff00007ffa3000 x21: ffff00007ffa3000
x20: ffff80008004191c x19: fffffc0001ffe8c0 x18: ffffffffffffffff
x17: ffff800080027b40 x16: ffff800080027a34 x15: ffff800080318514
x14: ffff8000800469c8 x13: ffff800080011558 x12: ffff800081897ff4
x11: ffff800081897b28 x10: ffff800080027bfc x9 : 0000000000400cc0
x8 : ffff800082cebc30 x7 : 0000000000000000 x6 : 0000000000000000
x5 : ffff80008004191c x4 : ffff00007f869000 x3 : ffff800082420338
x2 : fcff000006a24ec0 x1 : ffff00007f8a50a0 x0 : ffff00007ffa3000
Call trace:
 __kfence_free+0x7c/0xb4 mm/kfence/core.c:1147
 kfence_free include/linux/kfence.h:187 [inline]
 __slab_free+0x48c/0x508 mm/slub.c:3614
 do_slab_free mm/slub.c:3757 [inline]
 slab_free mm/slub.c:3810 [inline]
 __kmem_cache_free+0x220/0x230 mm/slub.c:3822
 kfree+0x5c/0x74 mm/slab_common.c:1072
 kvm_uevent_notify_change.part.0+0x10c/0x174 arch/arm64/kvm/../../../virt/kvm/kvm_main.c:5908
 kvm_uevent_notify_change arch/arm64/kvm/../../../virt/kvm/kvm_main.c:5878 [inline]
 kvm_dev_ioctl_create_vm arch/arm64/kvm/../../../virt/kvm/kvm_main.c:5107 [inline]
 kvm_dev_ioctl+0x3e8/0x91c arch/arm64/kvm/../../../virt/kvm/kvm_main.c:5131
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __arm64_sys_ioctl+0xac/0xf0 fs/ioctl.c:857
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:51
 el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:155
 el0_svc+0x40/0x114 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:595
---[ end trace 0000000000000000 ]---


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
