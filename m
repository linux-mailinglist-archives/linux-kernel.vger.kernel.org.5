Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F05809BEA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 06:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbjLHFtZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 8 Dec 2023 00:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLHFtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 00:49:24 -0500
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB517171E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 21:49:30 -0800 (PST)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3b88ac1f09cso2584237b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 21:49:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702014570; x=1702619370;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EBETvfzqD613YhTilF3AjV0DFOJ1h9L9RHJVTqPEc4I=;
        b=oPHt5goEzMi/hxsrcg8pCLOjOsRn6U0xo6te9a0wDFS8O7NlwzfAQmyr/m2D6DQ9AM
         UDpyc64EbRwoKRvOFEkbK/2/FPDvpmdeSmcwP2/Cv4ombodWvYnxtN5NqW/klBWX1P/i
         JalCu4+DnsNq3fr3EoWIAngjyxCYu1IKvIpQOQvlKtOZmyHUgRHsQ167kAo+tcwH93S/
         ZW6CRwyevq4ZyW/4QMP57BWCf5kSn2iHfJz56Ng+Qb8gVuQK8Qyk3w8bCi3+HambffT2
         l0julcbxsAfrZUkiXboNbCLjSYGm+rrzEWYjPxuXKkdzEk6O0yevakKcBtfuwOzYwLHL
         OrYA==
X-Gm-Message-State: AOJu0YxUUff+5u0Up+XdmQE6mMoZvo211M6ffnFOpiN1E5BiKkKjTfRB
        xqf9L0HIHcNvprEpYU4uzZULX7hb2Ry54Ycf4AwJKQY2hTvl
X-Google-Smtp-Source: AGHT+IGTXQuNC7u7vqdQYM+6O11D5RpwL6kUUVMO4/Cp2Zrs3PRDYQt67c7BML2ZNrm8Ywr/ErSf0Z3/6BFiJxf71Ij3tT3TspNB
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1481:b0:3b9:e51b:d2b5 with SMTP id
 e1-20020a056808148100b003b9e51bd2b5mr1503281oiw.11.1702014570091; Thu, 07 Dec
 2023 21:49:30 -0800 (PST)
Date:   Thu, 07 Dec 2023 21:49:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000da5a60060bf925f0@google.com>
Subject: [syzbot] [dri?] WARNING in drm_gem_prime_fd_to_handle
From:   syzbot <syzbot+268d319a7bfd92f4ae01@syzkaller.appspotmail.com>
To:     airlied@gmail.com, christian.koenig@amd.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sumit.semwal@linaro.org, syzkaller-bugs@googlegroups.com,
        tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    33cc938e65a9 Linux 6.7-rc4
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1348e51ce80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b50bd31249191be8
dashboard link: https://syzkaller.appspot.com/bug?extid=268d319a7bfd92f4ae01
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1552cce4e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1065c954e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ecc4a2a6bd50/disk-33cc938e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1be71f7cd7b2/vmlinux-33cc938e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/54de78eb11a7/bzImage-33cc938e.xz

The issue was bisected to:

commit 85e26dd5100a182bf8448050427539c0a66ab793
Author: Christian König <christian.koenig@amd.com>
Date:   Thu Jan 26 09:24:26 2023 +0000

    drm/client: fix circular reference counting issue

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12624b4ae80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11624b4ae80000
console output: https://syzkaller.appspot.com/x/log.txt?x=16624b4ae80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+268d319a7bfd92f4ae01@syzkaller.appspotmail.com
Fixes: 85e26dd5100a ("drm/client: fix circular reference counting issue")

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5069 at drivers/gpu/drm/drm_prime.c:326 drm_gem_prime_fd_to_handle+0x4be/0x550 drivers/gpu/drm/drm_prime.c:326
Modules linked in:
CPU: 1 PID: 5069 Comm: syz-executor183 Not tainted 6.7.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
RIP: 0010:drm_gem_prime_fd_to_handle+0x4be/0x550 drivers/gpu/drm/drm_prime.c:326
Code: 00 00 48 89 df e8 72 71 6e ff e9 e9 fd ff ff e8 38 01 94 fc 4c 89 ff 41 89 dc e8 5d cd 8e 05 e9 b8 fe ff ff e8 23 01 94 fc 90 <0f> 0b 90 e9 47 fd ff ff e8 85 a7 ea fc e9 16 fc ff ff e8 7b a7 ea
RSP: 0018:ffffc90003d07c48 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888146686800 RCX: ffffffff84f3861b
RDX: ffff88807a279dc0 RSI: ffffffff84f3891d RDI: ffff888146686928
RBP: ffff88801f379c00 R08: 0000000000000007 R09: fffffffffffff000
R10: ffff888146686800 R11: 0000000000000001 R12: ffff88801f378800
R13: ffff888143b66000 R14: ffffc90003d07e10 R15: ffff88801cbd8c10
FS:  00007f772497c6c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005fdeb8 CR3: 000000007d240000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 drm_prime_fd_to_handle_ioctl+0xcf/0x100 drivers/gpu/drm/drm_prime.c:375
 drm_ioctl_kernel+0x28c/0x4d0 drivers/gpu/drm/drm_ioctl.c:792
 drm_ioctl+0x5cb/0xbf0 drivers/gpu/drm/drm_ioctl.c:895
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f77249bd1b9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f772497c218 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f7724a45408 RCX: 00007f77249bd1b9
RDX: 0000000020000180 RSI: 00000000c00c642e RDI: 0000000000000004
RBP: 00007f7724a45400 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f7724a4540c
R13: 00007f7724a12018 R14: 0023647261632f69 R15: 6972642f7665642f
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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
