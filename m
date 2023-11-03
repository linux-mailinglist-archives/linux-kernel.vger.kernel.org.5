Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E127DFE70
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 04:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbjKCDhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 23:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjKCDhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 23:37:13 -0400
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1D4CE
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 20:37:06 -0700 (PDT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1e9f6006f9cso2144159fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 20:37:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698982626; x=1699587426;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uh5rI2PuAfSF/BHwUbOtXzmR4MYj4GNwrdflTHtJU8I=;
        b=AvEVn9ocVPr9NstQVNYOSH48OeTzDmjWBBuUAMTRr7UQxo3oEhH6MTdnnt12moYIfR
         uwnW1Fg+uYJf5cpqXO41grgCpR/rCa1suSXzO1rYBwF3L04W0ThHOue2pp58mbyyt7pT
         tewhHmuaXSDnRU0Vnh/RyLF+usExW6XrvrL1qC+KzOAfD5iJRXVFSvapeQbm/q77rY5O
         r6MwkuKxAHyLDAE1ZAs7DF3BAY13+/RdEhHqQhHq7PjPr4nqBkMrvrPM//BHVvXF+sNC
         YkgRTDhYpeaJxgnb53J1NAaZXzo9M/82WD4j2N1AkASe12eIP8fmQIAe7oM54ulXluKk
         1jtg==
X-Gm-Message-State: AOJu0YzBKsR+8w/rxmZN7dGTM/skAtTkCtVnejOHnF0kNkY+KCYd0efy
        iXqz14O5Ucy0W2G8FQbjdRKPvXYHlX9bP9PFW5DPYgkym+UH
X-Google-Smtp-Source: AGHT+IFkXq2OXhRt74CrJnLG1hhoCYC63DajCxLf1auT4ElKM58xfuz0rtHRUeNrNEeqQH7oN/hD8vu7Ec5rbG/nGUocVMyKKlWe
MIME-Version: 1.0
X-Received: by 2002:a05:6870:e9a1:b0:1e9:9bef:b1df with SMTP id
 r33-20020a056870e9a100b001e99befb1dfmr10055517oao.3.1698982626141; Thu, 02
 Nov 2023 20:37:06 -0700 (PDT)
Date:   Thu, 02 Nov 2023 20:37:06 -0700
In-Reply-To: <a33a632b-9cb6-3187-53b2-5e3309ea0467@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e92c4906093737be@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in diWrite
From:   syzbot <syzbot+c1056fdfe414463fdb33@syzkaller.appspotmail.com>
To:     ghandatmanas@gmail.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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
CPU: 0 PID: 5416 Comm: syz-executor.0 Not tainted 6.6.0-syzkaller-11928-gbc3012f4e3a9-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b5/0x2a0 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_out_of_bounds+0xf0/0x120 lib/ubsan.c:348
 diWrite+0x148c/0x2020 fs/jfs/jfs_imap.c:754
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
RIP: 0033:0x7fefe747ad39
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fefe859c0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 00007fefe759bf80 RCX: 00007fefe747ad39
RDX: 00000000000001ff RSI: 00000000200000c0 RDI: ffffffffffffff9c
RBP: 00007fefe74d7567 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fefe759bf80 R15: 00007ffd5e8e9838
 </TASK>
================================================================================


Tested on:

commit:         bc3012f4 Merge tag 'v6.7-p1' of git://git.kernel.org/p..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=10ece56b680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aa4ab0f6bdaaea8a
dashboard link: https://syzkaller.appspot.com/bug?extid=c1056fdfe414463fdb33
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17fe65a0e80000

