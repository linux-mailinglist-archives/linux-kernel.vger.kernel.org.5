Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DEF80B9AB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 08:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjLJHgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 02:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjLJHgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 02:36:00 -0500
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A938A106
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 23:36:06 -0800 (PST)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3b9dff5942fso4939923b6e.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 23:36:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702193766; x=1702798566;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fSmnz/5E1URbsDXTcRSZ8VE8A0zVjiZdSSSYw32sibo=;
        b=cGJ1xc7KY4qIuvqXUZrviUtfjbTdGVAqgI4wnJBEgsOtnnVKGiuvGP/AMZafoaW2aO
         hnnpjzhsXVkBkAzMxY9vrdgBkM9h+C5QF41hhJ+nPVHvFl9qEBvo+0eQIKE0yestcNtC
         ZsP2x3ZvFTYT9m82VOvjOO7Zeli85mthFSykdls3pR3jZo1TFxo6PCwrBCTmBq7lpFll
         1tdrBsFtTyFFrE+m5cgvCoUHC/FGXHPPiaRK5lQZl3ig3wDWFZfzNXoDjVg3VmGdFUfI
         qNRgpyIUXuQLoxd4axq+ubbmF3fFkEO1QOYWjWvQAh5bouHc+6gPAxqO+R+2yb+S5PLN
         PUcQ==
X-Gm-Message-State: AOJu0Yz0LR7pAzH3F8dLukHEa+CSBySj78EL6zZfyfllcxZVDu50YzMo
        cp4y3hYLKLrYJOs0FWR7dG40WuzP7HWyw6GHqMUXZUpZZHUB
X-Google-Smtp-Source: AGHT+IFCxGMtStiqgM/51Xvk++2OvLNjOZFLH428tWDczK3ODa2dJIv7TSfs+moj7pW8y63wRrsedl1AJYFXWEIus0LOjyCw1cvf
MIME-Version: 1.0
X-Received: by 2002:a05:6808:221c:b0:3ad:29a4:f54f with SMTP id
 bd28-20020a056808221c00b003ad29a4f54fmr2555744oib.4.1702193765959; Sat, 09
 Dec 2023 23:36:05 -0800 (PST)
Date:   Sat, 09 Dec 2023 23:36:05 -0800
In-Reply-To: <tencent_B4064DC995AEF2AEC3CC9E27EE06ED12D706@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c2518e060c22de21@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in diNewExt
From:   syzbot <syzbot+553d90297e6d2f50dbc7@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
UBSAN: array-index-out-of-bounds in diNewExt

loop0: detected capacity change from 0 to 32768
agno: -878706688, ipimap: ffff88806b342930, iagp: ffff888024d4f000, sbi: ffff888016657a00, agl2s: 13
agno: -878706688, ipimap: ffff88806b342930, iagp: ffff888024d4f000, sbi: ffff888016657a00, agl2s: 13
================================================================================
UBSAN: array-index-out-of-bounds in fs/jfs/jfs_imap.c:2367:2
index -878706688 is out of range for type 'struct iagctl[128]'
CPU: 0 PID: 5481 Comm: syz-executor.0 Not tainted 6.7.0-rc4-syzkaller-00009-gbee0e7762ad2-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_out_of_bounds+0x11c/0x150 lib/ubsan.c:348
 diNewExt+0x3b39/0x3e00 fs/jfs/jfs_imap.c:2367
 diAllocExt fs/jfs/jfs_imap.c:1949 [inline]
 diAllocAG+0xbe8/0x1e50 fs/jfs/jfs_imap.c:1666
 diAlloc+0x1d3/0x1760 fs/jfs/jfs_imap.c:1587
 ialloc+0x8f/0x900 fs/jfs/jfs_inode.c:56
 jfs_mkdir+0x1c5/0xb90 fs/jfs/namei.c:225
 vfs_mkdir+0x2f1/0x4b0 fs/namei.c:4106
 do_mkdirat+0x264/0x3a0 fs/namei.c:4129
 __do_sys_mkdirat fs/namei.c:4144 [inline]
 __se_sys_mkdirat fs/namei.c:4142 [inline]
 __x64_sys_mkdirat+0x89/0xa0 fs/namei.c:4142
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x45/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f857287b5e7
Code: 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 02 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8571bfdee8 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f857287b5e7
RDX: 00000000000001ff RSI: 0000000020000140 RDI: 00000000ffffff9c
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000020000140
R13: 00007f8571bfdf40 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
================================================================================


Tested on:

commit:         bee0e776 Merge tag 'for-linus-iommufd' of git://git.ke..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=135fd132e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b45dfd882e46ec91
dashboard link: https://syzkaller.appspot.com/bug?extid=553d90297e6d2f50dbc7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10668e46e80000

