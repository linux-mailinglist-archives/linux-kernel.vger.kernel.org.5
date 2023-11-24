Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90827F6AD0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 04:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjKXDGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 22:06:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjKXDGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 22:06:01 -0500
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B809FD54
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 19:06:05 -0800 (PST)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1cf8890752dso16252235ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 19:06:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700795165; x=1701399965;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9tye5RLsZndCF4z9uvqv1tzmMoPwpru/z82t1thp6Cg=;
        b=QcLU47a7Sul+hWmHOOer5ncAKpmGnLK+l97C03Qx9xHtb2EY0wcJgVeGNDHJWRCEv+
         agPhPL2Kj/4E7BRGjNF24ArgMYMG9aFwgBVigKQCF6k9EXJgucAi5UAWXOL25sPzdYME
         4uMT1eHmuXXFmat/jyFvgkqvL+FRidUFh7aZT5hvszwfUPOZ+fv3Jwg4ffzlbOdJxuvO
         7K+QHUwXLAC+CsBj+DiCH46WarUuvVC2t6dmzU+6SLYYL9vxJIqRet9dktXebX+QDLUP
         SWOhVzn9XhoTW2xl6dYANQ7z0vCIgG/LMVMfp9UoxNgDcRtCYYCRnipadCSPCi0GpU1H
         hL4w==
X-Gm-Message-State: AOJu0YyrGSEC3tiuPaoDgyRCvruvM/bPVPH6jmqXHpY9ylXV2PhGFsLS
        9ELzDxBDwnq2Bhal7wXxcf8VGMsyQjRcLmNdywzj6hXt4nvBO5U=
X-Google-Smtp-Source: AGHT+IEN70WDZW4BjbphMdWupNsUgNSFXVohoSqOy1jndt2Lzp3lsckExBLSJQf5CyBM3zwNliFcAkl7XrnmYFVMlqW7lDmZ89M5
MIME-Version: 1.0
X-Received: by 2002:a17:903:2443:b0:1cf:6a75:33ba with SMTP id
 l3-20020a170903244300b001cf6a7533bamr346753pls.4.1700795165013; Thu, 23 Nov
 2023 19:06:05 -0800 (PST)
Date:   Thu, 23 Nov 2023 19:06:04 -0800
In-Reply-To: <20231124025100.2028923-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a57e9c060add3b51@google.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in indx_insert_into_buffer
From:   syzbot <syzbot+c5b339d16ffa61fd512d@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, lizhi.xu@windriver.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in indx_insert_into_buffer

R13: 000000000000000b R14: 00007ff4d479bf80 R15: 00007fff510c11d8
 </TASK>
------------[ cut here ]------------
memcpy: detected field-spanning write (size 2600) of single field "hdr1" at fs/ntfs3/index.c:1914 (size 16)
WARNING: CPU: 2 PID: 5504 at fs/ntfs3/index.c:1914 indx_insert_into_buffer.isra.0+0xffb/0x12e0 fs/ntfs3/index.c:1914
Modules linked in:
CPU: 2 PID: 5504 Comm: syz-executor.0 Not tainted 6.7.0-rc1-syzkaller-00344-g037266a5f723-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:indx_insert_into_buffer.isra.0+0xffb/0x12e0 fs/ntfs3/index.c:1914
Code: ff e8 79 ca c1 fe c6 05 5b cb 3d 0c 01 90 b9 10 00 00 00 48 c7 c2 c0 cf 03 8b 48 89 ee 48 c7 c7 20 d0 03 8b e8 46 e9 87 fe 90 <0f> 0b 90 90 e9 2d fe ff ff 4c 89 e7 e8 e4 96 17 ff e9 31 f1 ff ff
RSP: 0018:ffffc90003f9f6e8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 00000000fffffff4 RCX: ffffffff814ca799
RDX: ffff88802c56d0c0 RSI: ffffffff814ca7a6 RDI: 0000000000000001
RBP: 0000000000000a28 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000005 R12: 0000000000000000
R13: 0000000000000f78 R14: ffff88802a0da800 R15: ffff88802c18a018
FS:  00007ff4d532c6c0(0000) GS:ffff88806b800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000563e13dbe300 CR3: 000000001bcab000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 indx_insert_entry+0x1a5/0x460 fs/ntfs3/index.c:1983
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
RIP: 0033:0x7ff4d467cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff4d532c0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 00007ff4d479bf80 RCX: 00007ff4d467cae9
RDX: 0000000000000000 RSI: 0000000020000a40 RDI: 0000000020000300
RBP: 00007ff4d532c120 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 000000000000000b R14: 00007ff4d479bf80 R15: 00007fff510c11d8
 </TASK>


Tested on:

commit:         037266a5 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12026642e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af04b7c4d36966d8
dashboard link: https://syzkaller.appspot.com/bug?extid=c5b339d16ffa61fd512d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1403cb5ce80000

