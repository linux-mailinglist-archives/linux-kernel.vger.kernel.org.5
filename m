Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E103E7F73BD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 13:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344777AbjKXMZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 07:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjKXMY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 07:24:58 -0500
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736C7D44
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 04:25:05 -0800 (PST)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2859052aed9so429022a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 04:25:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700828705; x=1701433505;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I6pq3i+RDfsJ86CCZXOS09cpgeZcksokI+b4uCUGd1E=;
        b=hmvARkgHq+XrMEIUWenfwgIj5uq9A99MJsa/xCWpcudHRXCuMLCBZ4yyz9FlTM/wKj
         kP7p/O7avGXFzLFqYbUMSSCD0YuQkzqySQr5cq1dECeultfhC8xnwbZI3OHO9MArIFsL
         CaiQrqqyY/Rerg8raXHAUonSo0/5vm/dFNlLrN25d8zuzvXCUCsBQWtHsS9inJBHKZIF
         MRBJ8r/tPqVj4XPmEc204R0Kr3fSjqM5jZ6TfINEML2yV5LRZAOwVc7K8pdFJNy0VhjG
         U6mXh3+/R7fPnGvS5dSD3uAfa55bvrPVYXQg+dGP7IvODThvi8euwmo6wLAHmH9+PtEm
         I2Wg==
X-Gm-Message-State: AOJu0Yw37+MQg4tITnKYTPRCxUK1JOeB5xweq+ropIC0DXyZn+e1Al+6
        aia+J9kFfGSuKKAEfOPpKDaTIMxS2DuyiimmBv+jjyQ241Nh
X-Google-Smtp-Source: AGHT+IGf+HJTEzkkFGx1LjqXngCcB2pvLewMNqyOPw7CDmy5Lk8z57qyDvS1BaeX+qu4VGZKvMZ5OtbMVWciPiw3diB58ebHKjS4
MIME-Version: 1.0
X-Received: by 2002:a17:90b:3116:b0:285:8c1e:d350 with SMTP id
 gc22-20020a17090b311600b002858c1ed350mr379984pjb.2.1700828705008; Fri, 24 Nov
 2023 04:25:05 -0800 (PST)
Date:   Fri, 24 Nov 2023 04:25:04 -0800
In-Reply-To: <tencent_75989238DDDB5DCA9922CFBF8DD225A38D07@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c933dd060ae50a53@google.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in indx_insert_into_buffer
From:   syzbot <syzbot+c5b339d16ffa61fd512d@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
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
WARNING in indx_insert_into_buffer

0, e: -12, h1: ffff88801d400018, h1s: ffff88801d402000, u1: 3960, 2600
------------[ cut here ]------------
memcpy: detected field-spanning write (size 3960) of single field "hdr1" at fs/ntfs3/index.c:1917 (size 16)
WARNING: CPU: 1 PID: 5567 at fs/ntfs3/index.c:1917 indx_insert_into_buffer.isra.0+0x10a2/0x1370 fs/ntfs3/index.c:1917
Modules linked in:
CPU: 1 PID: 5567 Comm: syz-executor.0 Not tainted 6.7.0-rc1-syzkaller-00344-g037266a5f723-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:indx_insert_into_buffer.isra.0+0x10a2/0x1370 fs/ntfs3/index.c:1917
Code: d4 c9 c1 fe c6 05 b6 cb 3d 0c 01 90 48 8b 74 24 78 b9 10 00 00 00 48 c7 c2 80 d0 03 8b 48 c7 c7 e0 d0 03 8b e8 9f e8 87 fe 90 <0f> 0b 90 90 e9 0d fe ff ff 48 c7 44 24 70 00 00 00 00 31 db e9 20
RSP: 0018:ffffc900036cf6e0 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 00000000fffffff4 RCX: ffffffff814ca799
RDX: ffff88801ead1340 RSI: ffffffff814ca7a6 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000005 R12: ffff88802703a000
R13: ffff88801fac1820 R14: ffff88802def8000 R15: ffff88801d400018
FS:  00007fe44fc446c0(0000) GS:ffff88806b700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe44ea20000 CR3: 0000000020a37000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 indx_insert_entry+0x1a5/0x460 fs/ntfs3/index.c:1987
 ni_add_name+0x4d9/0x820 fs/ntfs3/frecord.c:3055
 ni_rename+0xa1/0x1a0 fs/ntfs3/frecord.c:3087
 ntfs_rename+0x91f/0xec0 fs/ntfs3/namei.c:322
 vfs_rename+0x13e0/0x1c30 fs/namei.c:4844
 do_renameat2+0xc3c/0xdc0 fs/namei.c:4996
 __do_sys_rename fs/namei.c:5042 [inline]
 __se_sys_rename fs/namei.c:5040 [inline]
 __x64_sys_rename+0x81/0xa0 fs/namei.c:5040
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fe44ee7cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe44fc440c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 00007fe44ef9bf80 RCX: 00007fe44ee7cae9
RDX: 0000000000000000 RSI: 0000000020000a40 RDI: 0000000020000300
RBP: 00007fe44fc44120 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 000000000000000b R14: 00007fe44ef9bf80 R15: 00007fff185517f8
 </TASK>


Tested on:

commit:         037266a5 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11dade9f680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af04b7c4d36966d8
dashboard link: https://syzkaller.appspot.com/bug?extid=c5b339d16ffa61fd512d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=141879cce80000

