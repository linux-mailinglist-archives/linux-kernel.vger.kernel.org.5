Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9C0754DD7
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 10:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjGPIVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 04:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjGPIVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 04:21:51 -0400
Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D041D18F
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 01:21:49 -0700 (PDT)
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-39fb9cce400so5404492b6e.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 01:21:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689495709; x=1692087709;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z/9vVWmFMMeqNG0xDcaixSejDntCvADQME2O0gHEl4Q=;
        b=ANkmywQLEBNgwEKUI9+PxWqNir7kk1OxqOemZ3d6DK7Bbu8zXJU9rzNO/yl6/e5g8N
         ATl0g1A566BE1WWsUiRtPoTy8CbQWRs30TtAvqkreSmAPqVAbG5DFbFtu7LFWjzTSUHn
         ciO7+JtAYlyixUWRaUB2uISby1FOqkKycMgH9rL2+GUcXxxVXJYdmoGROpj9XBz9X4eG
         EhLCBjSlrLrf6TQF0Cko0SDKq4K0jvsfRGxoIH8/uR6Z7ZdMS8zhluRytPabnSHWtVHK
         IRiToXcBwjHeZCRBlWTlUPfvTZ2BBHCkWZJUv4imy99ZiI293vl8E6UbhZ9WYmxM+oU+
         78Ug==
X-Gm-Message-State: ABy/qLby6j2UeO+INXAPJY8QSsBfGRaCSYUy8o/kuNN1CPbtgZ0NmY39
        Rm6sYvKXTuTsXC+RA1XDcm2txmCd5cqgHH58Xn67Upn2fpvl
X-Google-Smtp-Source: APBJJlEddIYY1oNa9o+XsPUUVXCVS1PtHLHzqRRrNf18e45dUc9ZoAKM+2PZ+09CLYXBZYmkLMUll3a4gL/uvKPgU5GrvrrUSbk5
MIME-Version: 1.0
X-Received: by 2002:a05:6808:14c4:b0:39e:de07:a6b7 with SMTP id
 f4-20020a05680814c400b0039ede07a6b7mr12516901oiw.1.1689495709214; Sun, 16 Jul
 2023 01:21:49 -0700 (PDT)
Date:   Sun, 16 Jul 2023 01:21:49 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000098ed3a0600965f89@google.com>
Subject: [syzbot] [alsa?] memory leak in snd_seq_create_port
From:   syzbot <syzbot+cf8e7fa4eeec59b3d485@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3f01e9fed845 Merge tag 'linux-watchdog-6.5-rc2' of git://w..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14b07344a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=75da4f0a455bdbd3
dashboard link: https://syzkaller.appspot.com/bug?extid=cf8e7fa4eeec59b3d485
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15877dc2a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12905004a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/441fb7ea58b8/disk-3f01e9fe.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8fa7790ba0c3/vmlinux-3f01e9fe.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5e7a6471dadf/bzImage-3f01e9fe.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cf8e7fa4eeec59b3d485@syzkaller.appspotmail.com

Warning: Permanently added '10.128.1.1' (ED25519) to the list of known hosts.
executing program
executing program
BUG: memory leak
unreferenced object 0xffff888100877000 (size 512):
  comm "syz-executor257", pid 5012, jiffies 4294941742 (age 12.790s)
  hex dump (first 32 bytes):
    80 ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8154bf94>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1076
    [<ffffffff83d29e28>] kmalloc include/linux/slab.h:582 [inline]
    [<ffffffff83d29e28>] kzalloc include/linux/slab.h:703 [inline]
    [<ffffffff83d29e28>] snd_seq_create_port+0x78/0x300 sound/core/seq/seq_ports.c:135
    [<ffffffff83d1f681>] snd_seq_ioctl_create_port+0xe1/0x2a0 sound/core/seq/seq_clientmgr.c:1324
    [<ffffffff83d20e5e>] snd_seq_ioctl+0x13e/0x290 sound/core/seq/seq_clientmgr.c:2327
    [<ffffffff81685173>] vfs_ioctl fs/ioctl.c:51 [inline]
    [<ffffffff81685173>] __do_sys_ioctl fs/ioctl.c:870 [inline]
    [<ffffffff81685173>] __se_sys_ioctl fs/ioctl.c:856 [inline]
    [<ffffffff81685173>] __x64_sys_ioctl+0x103/0x140 fs/ioctl.c:856
    [<ffffffff84a77ff9>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84a77ff9>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888106742c00 (size 512):
  comm "syz-executor257", pid 5013, jiffies 4294942276 (age 7.450s)
  hex dump (first 32 bytes):
    80 ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8154bf94>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1076
    [<ffffffff83d29e28>] kmalloc include/linux/slab.h:582 [inline]
    [<ffffffff83d29e28>] kzalloc include/linux/slab.h:703 [inline]
    [<ffffffff83d29e28>] snd_seq_create_port+0x78/0x300 sound/core/seq/seq_ports.c:135
    [<ffffffff83d1f681>] snd_seq_ioctl_create_port+0xe1/0x2a0 sound/core/seq/seq_clientmgr.c:1324
    [<ffffffff83d20e5e>] snd_seq_ioctl+0x13e/0x290 sound/core/seq/seq_clientmgr.c:2327
    [<ffffffff81685173>] vfs_ioctl fs/ioctl.c:51 [inline]
    [<ffffffff81685173>] __do_sys_ioctl fs/ioctl.c:870 [inline]
    [<ffffffff81685173>] __se_sys_ioctl fs/ioctl.c:856 [inline]
    [<ffffffff81685173>] __x64_sys_ioctl+0x103/0x140 fs/ioctl.c:856
    [<ffffffff84a77ff9>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84a77ff9>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
