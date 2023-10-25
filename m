Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7147D6CBB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 15:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344347AbjJYNJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 09:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344246AbjJYNJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 09:09:54 -0400
Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35896131
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 06:09:51 -0700 (PDT)
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-581e74f7dd5so8815058eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 06:09:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698239390; x=1698844190;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gVvou1i/S2SrxgRYtwSrOSdXF9KAotPX0rTNJQUAQjY=;
        b=IMSCUEd8iNeMp1EQt41/opCdXbqPgZYfJKatrw63NqsRQmVohGIJvDUTJ09iBtzuq3
         jC56sHZjT5hjw0x2V0Op7kZDf6MwPqLsQgORUXK3RsSMUH6ILdSk8BKSVCEBlI/33pJG
         CyuH9JcYeJsQEXwqX2gL8phr/LVPrJkSNbjF3XHqhqcEIefUrC13+9xs3GpnUJd+Gv3w
         o8Ho3yAUf5gmdR9wQgD6ncJU7W9oe21kYVFUNmkGL3X19TOVIjnJspIGvcOhPy2rAZfm
         rbJf3+5abr2440yA3pV2IH+SVPu8BO5RFhA3o05v6gxxmtr8ndFs0wYkgKbgIFijOATp
         2YdQ==
X-Gm-Message-State: AOJu0YxVHgv0G0hwRR0C9+1ZQ8swlgEV5E4RnuVQ9U22+bXSYb5GPncr
        jveCqNBulgPSuAlr8scfeukFAd9hhjKZ3gABmERjfCNpQfQY
X-Google-Smtp-Source: AGHT+IE3MDDhYp60257/LIBDtCE0m01CNsDUT0NqJTNR1yfirIPZ0PBGbtDDMWUeTwHqwT+I7c9VYcstv9ayfV6yD4lx4zsQN2XH
MIME-Version: 1.0
X-Received: by 2002:a05:6870:171d:b0:1e9:9202:20c2 with SMTP id
 h29-20020a056870171d00b001e9920220c2mr6759363oae.0.1698239390550; Wed, 25 Oct
 2023 06:09:50 -0700 (PDT)
Date:   Wed, 25 Oct 2023 06:09:50 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009e122006088a2b8d@google.com>
Subject: [syzbot] [dccp?] general protection fault in dccp_write_xmit (2)
From:   syzbot <syzbot+c71bc336c5061153b502@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dccp@vger.kernel.org, edumazet@google.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    05d3ef8bba77 Linux 6.6-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=120b3971680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=667b53b8e7487997
dashboard link: https://syzkaller.appspot.com/bug?extid=c71bc336c5061153b502
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a9faa0dd3d80/disk-05d3ef8b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cea22e55cef7/vmlinux-05d3ef8b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d0679f322d2a/bzImage-05d3ef8b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c71bc336c5061153b502@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 PID: 1906 Comm: syz-executor.4 Not tainted 6.6.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
RIP: 0010:ccid_hc_tx_send_packet net/dccp/ccid.h:166 [inline]
RIP: 0010:dccp_write_xmit+0x66/0x1d0 net/dccp/output.c:356
Code: 00 48 85 c0 49 89 c4 0f 84 03 01 00 00 e8 52 d8 0c f8 41 80 3e 00 0f 85 45 01 00 00 48 8b 9d f8 08 00 00 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 0f 85 1f 01 00 00 48 8b 1b 48 8d bb b0 00 00 00 48
RSP: 0018:ffffc90004cff870 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff888016f85940 RSI: ffffffff897af1de RDI: ffff888020ba5c40
RBP: ffff888020ba5c40 R08: 0000000000000001 R09: fffffbfff2339be7
R10: ffffffff919cdf3f R11: 0000000000000000 R12: ffff888075c38280
R13: dffffc0000000000 R14: ffffed1004174ca7 R15: ffff888020ba6538
FS:  00007f31f81d66c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9c878ffc83 CR3: 0000000066952000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 dccp_sendmsg+0x968/0xcc0 net/dccp/proto.c:801
 inet_sendmsg+0x9d/0xe0 net/ipv4/af_inet.c:846
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0xd5/0x180 net/socket.c:745
 ____sys_sendmsg+0x2ac/0x940 net/socket.c:2558
 ___sys_sendmsg+0x135/0x1d0 net/socket.c:2612
 __sys_sendmmsg+0x1a1/0x450 net/socket.c:2698
 __do_sys_sendmmsg net/socket.c:2727 [inline]
 __se_sys_sendmmsg net/socket.c:2724 [inline]
 __x64_sys_sendmmsg+0x9c/0x100 net/socket.c:2724
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f31f747cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f31f81d60c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00007f31f759c050 RCX: 00007f31f747cae9
RDX: 0000000000000002 RSI: 00000000200014c0 RDI: 0000000000000004
RBP: 00007f31f74c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f31f759c050 R15: 00007f31f76bfa48
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ccid_hc_tx_send_packet net/dccp/ccid.h:166 [inline]
RIP: 0010:dccp_write_xmit+0x66/0x1d0 net/dccp/output.c:356
Code: 00 48 85 c0 49 89 c4 0f 84 03 01 00 00 e8 52 d8 0c f8 41 80 3e 00 0f 85 45 01 00 00 48 8b 9d f8 08 00 00 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 0f 85 1f 01 00 00 48 8b 1b 48 8d bb b0 00 00 00 48
RSP: 0018:ffffc90004cff870 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff888016f85940 RSI: ffffffff897af1de RDI: ffff888020ba5c40
RBP: ffff888020ba5c40 R08: 0000000000000001 R09: fffffbfff2339be7
R10: ffffffff919cdf3f R11: 0000000000000000 R12: ffff888075c38280
R13: dffffc0000000000 R14: ffffed1004174ca7 R15: ffff888020ba6538
FS:  00007f31f81d66c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5f4e398000 CR3: 0000000066952000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	00 48 85             	add    %cl,-0x7b(%rax)
   3:	c0 49 89 c4          	rorb   $0xc4,-0x77(%rcx)
   7:	0f 84 03 01 00 00    	je     0x110
   d:	e8 52 d8 0c f8       	call   0xf80cd864
  12:	41 80 3e 00          	cmpb   $0x0,(%r14)
  16:	0f 85 45 01 00 00    	jne    0x161
  1c:	48 8b 9d f8 08 00 00 	mov    0x8f8(%rbp),%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2f:	0f 85 1f 01 00 00    	jne    0x154
  35:	48 8b 1b             	mov    (%rbx),%rbx
  38:	48 8d bb b0 00 00 00 	lea    0xb0(%rbx),%rdi
  3f:	48                   	rex.W


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
