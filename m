Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255BC811D85
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379222AbjLMSxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLMSxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:53:17 -0500
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639D2B2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:53:23 -0800 (PST)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1d30efd624fso18556265ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:53:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702493603; x=1703098403;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VTv6ovblVvKA179oLhmxkIJrl4mAKz3esEqgRyhM1CM=;
        b=nFiIkKptvYNp7bmTPPm/4DyrMkeCDsom8X/ykQ3IduGVzmn8f9muOEUVyqkMB3Ka98
         tniVagnfEGHHxdfIr1iRBkx+m4n9E4VGo5HBBhLueLk7orwDebEfvyIcX434rc4ULbfM
         o+8Fw2yWGZ53dzghx1imkY5EQRpTd683atpk2Tho0k+4ujBSI5gvfr1VMla9puQFtXDs
         4mxxSMbDB9rBs+CY5ePWhPrPzIffHHQnsvEYlKwZJtaqa0NanOpxiYCQGZwx0otMtZE6
         Op+NUDtP3BDayoYHc0nfHDmM67RApsiuJ+9oymV2/2HuKiqACY/23N4dJ5Bfv8fh7Trx
         EUXQ==
X-Gm-Message-State: AOJu0YyjFfl0q8EwwwMuus0QciCfrT+M1/JU6GwX9/iTwyDvB4/tnkfH
        FBey+gdH4uMz+vqmsAE+OaKTC73x7Q8PEPPEW+Ini3YlNtEB
X-Google-Smtp-Source: AGHT+IGQtW1JMfTiwBqo43nYV6+CU59vOxaGjjvGuLQHPRQ+1JMfzGlc0LwPq7YpyiyME/HiTZHDVkLzy9quJKYTCbNIbc803R6G
MIME-Version: 1.0
X-Received: by 2002:a17:902:f68d:b0:1d0:5d31:4671 with SMTP id
 l13-20020a170902f68d00b001d05d314671mr491502plg.4.1702493602983; Wed, 13 Dec
 2023 10:53:22 -0800 (PST)
Date:   Wed, 13 Dec 2023 10:53:22 -0800
In-Reply-To: <0000000000004f4579060c68431b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000703582060c68aeab@google.com>
Subject: Re: [syzbot] [mptcp?] WARNING in mptcp_check_listen_stop
From:   syzbot <syzbot+5a01c3a666e726bc8752@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, martineau@kernel.org,
        matttbe@kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    2513974cc3e1 Merge branch 'stmmac-bug-fixes'
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=116337fae80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b50bd31249191be8
dashboard link: https://syzkaller.appspot.com/bug?extid=5a01c3a666e726bc8752
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1119061ee80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=110ca006e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fbf7f04433a8/disk-2513974c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f839967d18d6/vmlinux-2513974c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/10f6c15a1f15/bzImage-2513974c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5a01c3a666e726bc8752@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5075 at net/mptcp/protocol.c:2999 mptcp_check_listen_stop.part.0+0x17b/0x240 net/mptcp/protocol.c:2999
Modules linked in:
CPU: 0 PID: 5075 Comm: syz-executor686 Not tainted 6.7.0-rc4-syzkaller-00167-g2513974cc3e1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
RIP: 0010:mptcp_check_listen_stop.part.0+0x17b/0x240 net/mptcp/protocol.c:2999
Code: 00 00 00 0f b6 45 12 88 44 24 20 44 0f b6 6c 24 20 bf 0a 00 00 00 44 89 ee e8 c1 66 24 f7 41 80 fd 0a 74 2b e8 86 6b 24 f7 90 <0f> 0b 90 e8 7d 6b 24 f7 48 b8 00 00 00 00 00 fc ff df 49 c7 04 04
RSP: 0018:ffffc900039efb50 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff8880187b8000 RCX: ffffffff8a63221f
RDX: ffff8880137a0000 RSI: ffffffff8a63222a RDI: 0000000000000001
RBP: ffff888018b30000 R08: 0000000000000001 R09: 000000000000000a
R10: 0000000000000007 R11: 0000000000000002 R12: 1ffff9200073df6a
R13: 0000000000000007 R14: ffff8880187b8012 R15: 000000000000000a
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8ccb1dd0f0 CR3: 000000000cd77000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 mptcp_check_listen_stop net/mptcp/protocol.c:3032 [inline]
 __mptcp_close+0x888/0xa10 net/mptcp/protocol.c:3020
 mptcp_close+0x28/0xf0 net/mptcp/protocol.c:3087
 inet_release+0x132/0x270 net/ipv4/af_inet.c:433
 inet6_release+0x4f/0x70 net/ipv6/af_inet6.c:485
 __sock_release+0xae/0x260 net/socket.c:659
 sock_close+0x1c/0x20 net/socket.c:1419
 __fput+0x270/0xbb0 fs/file_table.c:394
 task_work_run+0x14d/0x240 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa92/0x2ae0 kernel/exit.c:871
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1021
 __do_sys_exit_group kernel/exit.c:1032 [inline]
 __se_sys_exit_group kernel/exit.c:1030 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1030
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f8ccb161d79
Code: Unable to access opcode bytes at 0x7f8ccb161d4f.
RSP: 002b:00007ffce6b9dbd8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f8ccb161d79
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007f8ccb1dc290 R08: ffffffffffffffb8 R09: 00007ffce6b9ddf8
R10: 00007ffce6b9ddf8 R11: 0000000000000246 R12: 00007f8ccb1dc290
R13: 0000000000000000 R14: 00007f8ccb1dcce0 R15: 00007f8ccb133b40
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
