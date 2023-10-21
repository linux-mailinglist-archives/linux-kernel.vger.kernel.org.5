Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9ED7D1EFD
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 20:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjJUSuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 14:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjJUSuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 14:50:03 -0400
Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84766F7
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 11:49:57 -0700 (PDT)
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-3b3e1c828a4so3283493b6e.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 11:49:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697914197; x=1698518997;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nGqUaHSjkgvx50op93dnxZalHgCa6+xdy0AG3heXSUw=;
        b=QOwl9kYZF8FBjNQjWCzQ/CiTvcozlhwEwj3kmaXpSgnVzx2JbxIn7jXMOO8ChhCgW7
         Do7AZMpFly3D7JOfFoW/npnfxo97jETHCYrCO5n6BcF4K7L7XtOx7mptDnjfAmco6RqA
         f8rjrmuSE6xjDOUHevwpnxYHt0hFq6BGTxB/MdiEem54lQ0qHQZg/Eutt0zSfofOBtAP
         2mzeacZT9vrxyQ4Vj1kDSZYVbSdIbZrRyIcaWJSB1dp/OHbnpUFHeGsQ0yb4Y1na6/1v
         1qxbiL+yAer7dSOY+mLSyzd/AQvfdr9JXaZSFItwtc7f+hnr6s8gREhG6OYc8yjsRIes
         owiw==
X-Gm-Message-State: AOJu0YysvGZYlHhm1KbOVmdBIVheiNplGJsTjVU2oF94E7QSNoOqze2G
        x4iE9blFQh9xbN4CKyEe7P5Pl+H9++FLxWJNHoTYnIHCfpaykJM42g==
X-Google-Smtp-Source: AGHT+IH2C3S+RovWxRUKzUeDG9whEBmqfXrNO2d1HY7UIkdx/OdmJgf4xcZ94KlPIrVoMS5T9qdRRZOy+cOQCQstzMgWzyqcID7N
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2090:b0:3ae:21ca:9b7e with SMTP id
 s16-20020a056808209000b003ae21ca9b7emr2041313oiw.2.1697914196838; Sat, 21 Oct
 2023 11:49:56 -0700 (PDT)
Date:   Sat, 21 Oct 2023 11:49:56 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008fcf9806083e7405@google.com>
Subject: [syzbot] [kernel?] KMSAN: kernel-infoleak-after-free in
 copy_siginfo_to_user (2)
From:   syzbot <syzbot+cfc08744435c4cf94a40@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, luto@kernel.org,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    dd72f9c7e512 Merge tag 'spi-fix-v6-6-rc4' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15fd7ae5680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3f3af4cd712401d4
dashboard link: https://syzkaller.appspot.com/bug?extid=cfc08744435c4cf94a40
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/70e48b37a929/disk-dd72f9c7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/60aeb36b39dc/vmlinux-dd72f9c7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/71699a83a138/bzImage-dd72f9c7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cfc08744435c4cf94a40@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: kernel-infoleak-after-free in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
BUG: KMSAN: kernel-infoleak-after-free in _copy_to_user+0xbc/0x100 lib/usercopy.c:40
 instrument_copy_to_user include/linux/instrumented.h:114 [inline]
 _copy_to_user+0xbc/0x100 lib/usercopy.c:40
 copy_to_user include/linux/uaccess.h:191 [inline]
 copy_siginfo_to_user+0x40/0x130 kernel/signal.c:3362
 x64_setup_rt_frame+0x1e74/0x2400 arch/x86/kernel/signal_64.c:197
 setup_rt_frame arch/x86/kernel/signal.c:222 [inline]
 handle_signal arch/x86/kernel/signal.c:266 [inline]
 arch_do_signal_or_restart+0x626/0xca0 arch/x86/kernel/signal.c:311
 exit_to_user_mode_loop+0xe8/0x320 kernel/entry/common.c:168
 exit_to_user_mode_prepare+0x163/0x220 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x2a/0x140 kernel/entry/common.c:296
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Uninit was stored to memory at:
 copy_siginfo include/linux/signal.h:17 [inline]
 collect_signal kernel/signal.c:596 [inline]
 __dequeue_signal+0x548/0xa00 kernel/signal.c:625
 dequeue_signal+0x14b/0xb10 kernel/signal.c:648
 get_signal+0xc3f/0x2d10 kernel/signal.c:2772
 arch_do_signal_or_restart+0x53/0xca0 arch/x86/kernel/signal.c:309
 exit_to_user_mode_loop+0xe8/0x320 kernel/entry/common.c:168
 exit_to_user_mode_prepare+0x163/0x220 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x2a/0x140 kernel/entry/common.c:296
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Uninit was created at:
 slab_free_hook mm/slub.c:1770 [inline]
 slab_free_freelist_hook mm/slub.c:1826 [inline]
 slab_free mm/slub.c:3809 [inline]
 kmem_cache_free+0x670/0x12a0 mm/slub.c:3831
 __sigqueue_free kernel/signal.c:460 [inline]
 collect_signal kernel/signal.c:603 [inline]
 __dequeue_signal+0x998/0xa00 kernel/signal.c:625
 dequeue_signal+0x14b/0xb10 kernel/signal.c:648
 get_signal+0xc3f/0x2d10 kernel/signal.c:2772
 arch_do_signal_or_restart+0x53/0xca0 arch/x86/kernel/signal.c:309
 exit_to_user_mode_loop+0xe8/0x320 kernel/entry/common.c:168
 exit_to_user_mode_prepare+0x163/0x220 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x2a/0x140 kernel/entry/common.c:296
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Bytes 12-15 of 48 are uninitialized
Memory access of size 48 starts at ffff88801301fdb0
Data copied to user address 000000c000e7bbf0

CPU: 0 PID: 5011 Comm: syz-fuzzer Not tainted 6.6.0-rc6-syzkaller-00043-gdd72f9c7e512 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
=====================================================


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
