Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DD17E5103
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 08:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343569AbjKHHb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 02:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235179AbjKHHb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 02:31:27 -0500
Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD041AC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 23:31:25 -0800 (PST)
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-3b2e0f24de0so9600616b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 23:31:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699428685; x=1700033485;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iuwi9LoRNPTnGg3HnHKZq0zKA0LoMB0CPtFduQXuLnQ=;
        b=M2Xfy80yLa8Mwy8QIu8Us2EQ/jyuDb69wK/o9H3DG57lgYbGsR9YOMyi2TIjPTFUQZ
         FbRXL2xi/p1huRGT0xOaLaIZrJeIOlcEtFk7NV3kGdfETxEwyXrFR/424Lybwjb5OHCs
         3d950Ocdv7j1jCPtthsUshyx+3KkzSh4kTOgG+iYa+GmMHW/OjIMWHqEliBzFyhBdaQv
         ag7I3PulqzcTceceqIrGr7lkkOtR1dmbKRsdVCp2GC0v1a4xDfAF/pkrwtaAQmxb26ub
         cjAduckPmYezyr35lRtnBnU8j0Qo41LiQxS1RZsJRMpUoTuhazLfSY+gqNl69Ei9mt5x
         R4Dg==
X-Gm-Message-State: AOJu0YyTulI5hoDvoU2wML3luAopJgr7CM0vr7tFdcP8nuiEmJVeaRqG
        v3NkaVcdDs7Q/H9Kpqfayu9LMXBXdlBa74ja/Ucd+heQzH0s
X-Google-Smtp-Source: AGHT+IEJ7qbPqNyyendRvdsmZ95KHEi3UZN3+kxGz3GzpP7lUukkN3OUzXgY++/jrVX5SVi81Vr7omj7zSTjrlo8DLlTUWltytTS
MIME-Version: 1.0
X-Received: by 2002:a05:6808:21a2:b0:3a9:b964:820e with SMTP id
 be34-20020a05680821a200b003a9b964820emr592188oib.3.1699428685033; Tue, 07 Nov
 2023 23:31:25 -0800 (PST)
Date:   Tue, 07 Nov 2023 23:31:24 -0800
In-Reply-To: <00000000000057faf606067f1f32@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000017b74d06099f1375@google.com>
Subject: Re: [syzbot] [bluetooth?] memory leak in prepare_creds (4)
From:   syzbot <syzbot+2a478080bd86d36bb5ea@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    13d88ac54ddd Merge tag 'vfs-6.7.fsid' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10740c7b680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ecfdf78a410c834
dashboard link: https://syzkaller.appspot.com/bug?extid=2a478080bd86d36bb5ea
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d8fd7f680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=107b137f680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9bb27a01f17c/disk-13d88ac5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fb496feed171/vmlinux-13d88ac5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f4da22719ffa/bzImage-13d88ac5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2a478080bd86d36bb5ea@syzkaller.appspotmail.com

Warning: Permanently added '10.128.0.113' (ED25519) to the list of known hosts.
executing program
executing program
BUG: memory leak
unreferenced object 0xffff888107c20600 (size 192):
  comm "syz-executor418", pid 5027, jiffies 4294942544 (age 13.100s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81630798>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff81630798>] slab_post_alloc_hook mm/slab.h:766 [inline]
    [<ffffffff81630798>] slab_alloc_node mm/slub.c:3478 [inline]
    [<ffffffff81630798>] slab_alloc mm/slub.c:3486 [inline]
    [<ffffffff81630798>] __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
    [<ffffffff81630798>] kmem_cache_alloc+0x298/0x430 mm/slub.c:3502
    [<ffffffff812e0d5b>] prepare_creds+0x2b/0x4e0 kernel/cred.c:269
    [<ffffffff812e17c4>] copy_creds+0x44/0x280 kernel/cred.c:373
    [<ffffffff812927ba>] copy_process+0x6aa/0x25c0 kernel/fork.c:2366
    [<ffffffff8129487b>] kernel_clone+0x11b/0x690 kernel/fork.c:2907
    [<ffffffff81294e6c>] __do_sys_clone+0x7c/0xb0 kernel/fork.c:3050
    [<ffffffff84b67d8f>] do_syscall_x64 arch/x86/entry/common.c:51 [inline]
    [<ffffffff84b67d8f>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b

BUG: memory leak
unreferenced object 0xffff888107470a80 (size 16):
  comm "syz-executor418", pid 5027, jiffies 4294942544 (age 13.100s)
  hex dump (first 16 bytes):
    00 00 00 00 00 00 00 00 00 c3 87 00 81 88 ff ff  ................
  backtrace:
    [<ffffffff8163331d>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff8163331d>] slab_post_alloc_hook mm/slab.h:766 [inline]
    [<ffffffff8163331d>] slab_alloc_node mm/slub.c:3478 [inline]
    [<ffffffff8163331d>] __kmem_cache_alloc_node+0x2dd/0x3f0 mm/slub.c:3517
    [<ffffffff8157e81b>] __do_kmalloc_node mm/slab_common.c:1006 [inline]
    [<ffffffff8157e81b>] __kmalloc+0x4b/0x150 mm/slab_common.c:1020
    [<ffffffff82364631>] kmalloc include/linux/slab.h:604 [inline]
    [<ffffffff82364631>] kzalloc include/linux/slab.h:721 [inline]
    [<ffffffff82364631>] lsm_cred_alloc security/security.c:577 [inline]
    [<ffffffff82364631>] security_prepare_creds+0x121/0x140 security/security.c:2950
    [<ffffffff812e1059>] prepare_creds+0x329/0x4e0 kernel/cred.c:300
    [<ffffffff812e17c4>] copy_creds+0x44/0x280 kernel/cred.c:373
    [<ffffffff812927ba>] copy_process+0x6aa/0x25c0 kernel/fork.c:2366
    [<ffffffff8129487b>] kernel_clone+0x11b/0x690 kernel/fork.c:2907
    [<ffffffff81294e6c>] __do_sys_clone+0x7c/0xb0 kernel/fork.c:3050
    [<ffffffff84b67d8f>] do_syscall_x64 arch/x86/entry/common.c:51 [inline]
    [<ffffffff84b67d8f>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b



---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
