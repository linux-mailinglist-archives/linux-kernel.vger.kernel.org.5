Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C82D7DFB81
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 21:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345007AbjKBU1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 16:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbjKBU1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 16:27:09 -0400
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73519188
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 13:27:03 -0700 (PDT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1ef4782ef93so1690173fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 13:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698956822; x=1699561622;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i/AE2jCHPgbGRlkIG16yYkHlAKH6dWvuLy8rFJbVS4k=;
        b=n3eBddzZjw2nmT1vcKR88oIvjsTaUA5Y7tmIZH35cgmxoXhLcbWM/YkrYdSJcxRLCT
         ZRChYsnfuFhZkr5IobxO1yTCCsRL3epIWLwWqrzSMEpmEkNkgb34C6SaoNDiOAk2AODe
         GVmjlTyTpjcOFVvn4cOnfNZ5h2rmaqfj3X/IOuhAn9WACQkg30m7qjgYWAazjdC0ega1
         OMGwudsKB8zkIrm1VKSKAzF4e25ovZE89oyJ3k6v5YkJJDOZSsa/6J6fRKxXasXx1erl
         X2q76WwVaC44g58jei35/5BE6N3LclKL52qUbnSNPHA+nI3ncs1N6Wsxn1msoDvz3csf
         f7ig==
X-Gm-Message-State: AOJu0YxOTihWFuoFADE4IT1xtf2xlKjzvs8DOiOR7JqrdKSSPS5qDxhl
        GJKG8VjYRn19rduAhd5NO/z/HFvmTArOqlsCRO/5yTR0X70O
X-Google-Smtp-Source: AGHT+IGDf3z+i2zWSNnT6hvivcmD8q7LAHj2r7XQq6rNI/ZGYoQpUHPmGKI/llYKECHJgzO6WvXzSHvhyxmqwKSCQwS9XjTeGGRb
MIME-Version: 1.0
X-Received: by 2002:a05:6870:65a5:b0:1e9:6d19:935b with SMTP id
 fp37-20020a05687065a500b001e96d19935bmr523942oab.5.1698956822694; Thu, 02 Nov
 2023 13:27:02 -0700 (PDT)
Date:   Thu, 02 Nov 2023 13:27:02 -0700
In-Reply-To: <526dbcf1-a6ee-54b5-15a4-756979ae2d90@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e7d1a0060931353a@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in diWrite
From:   syzbot <syzbot+c1056fdfe414463fdb33@syzkaller.appspotmail.com>
To:     ghandatmanas@gmail.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
UBSAN: array-index-out-of-bounds in diWrite

diWrite: Offset too large
================================================================================
UBSAN: array-index-out-of-bounds in fs/jfs/jfs_imap.c:754:4
index 255 is out of range for type 'struct dtslot[128]'
CPU: 1 PID: 5407 Comm: syz-executor.0 Not tainted 6.6.0-syzkaller-10396-g4652b8e4f3ff-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b5/0x2a0 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_out_of_bounds+0xf0/0x120 lib/ubsan.c:348
 diWrite+0x1168/0x2060 fs/jfs/jfs_imap.c:754
 txCommit+0xa03/0x6a00 fs/jfs/jfs_txnmgr.c:1255
 jfs_mkdir+0x8d7/0xad0 fs/jfs/namei.c:290
 vfs_mkdir+0x2f1/0x4b0 fs/namei.c:4106
 do_mkdirat+0x255/0x390 fs/namei.c:4129
 __do_sys_mkdirat fs/namei.c:4144 [inline]
 __se_sys_mkdirat fs/namei.c:4142 [inline]
 __x64_sys_mkdirat+0x89/0xa0 fs/namei.c:4142
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fa34307ad39
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa3441290c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 00007fa34319bf80 RCX: 00007fa34307ad39
RDX: 00000000000001ff RSI: 00000000200000c0 RDI: ffffffffffffff9c
RBP: 00007fa3430d7567 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fa34319bf80 R15: 00007ffd3c0fbd48
 </TASK>
================================================================================


Tested on:

commit:         4652b8e4 Merge tag '6.7-rc-ksmbd-server-fixes' of git:..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=15fb1f07680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8aa5f62c74d2e2d5
dashboard link: https://syzkaller.appspot.com/bug?extid=c1056fdfe414463fdb33
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10e93ef7680000

