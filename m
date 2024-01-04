Return-Path: <linux-kernel+bounces-16598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8078240D9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96CB61C21B4C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269D7219E0;
	Thu,  4 Jan 2024 11:42:53 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DF32136E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 11:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-35fc70bd879so2365905ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 03:42:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704368570; x=1704973370;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uRpEy00AkAqUvVcXUy+QVoohBU74xnqN8yFS9GeMavE=;
        b=jKHyssLm/Hq4GSz61byCSGUMrdBd/Ei0YfAgA6iHalB2ql3Y4KhL2ljLJ+qir/cD0h
         Q3luM1SSxICJaamxRZZAc1+YgWWR14GLPJSmlGjVBgV7BFWFz3Wc/R1uvyvyjm2qb0ku
         ZpLyg2nFwVMUNgR8OQ5k4IYzp3WwUWnlM1AxvV4CEIsIhnCcdeD0RPPliKNFPI12ssw7
         4jnX4aBdWuVfcG3+hZKBd53yI4xyfU6q6bYlnwilQebATcDZRNtDTv8PI+GCXoYgO8jx
         0aC+Qd46/od4Qz1OuHMAHOvgP2rwubhoWbQ4tNa2khJK63ZSj4ug4UjqNYlcPPDHfvMq
         BRmg==
X-Gm-Message-State: AOJu0Yxz+81dyBkh0ayp15bzo3owGk7O4a0J5HIQzZnYuQBj4EK/5pwN
	qEFe7qg/6bv/Nj0IlZjMeAl7M5vMIqQnfUzh/Itvnn36d/3T82o=
X-Google-Smtp-Source: AGHT+IELlFYKf7Tdoj1lOiqf1R2twJpPGtkerooa8gKHtywhbnl0Yl5iRAQGSYtKYKZt7Ec8LgRrpt0ojgQuazgf4TGiiLt7IL8G
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c22:b0:35f:ff73:fe69 with SMTP id
 m2-20020a056e021c2200b0035fff73fe69mr62539ilh.6.1704368570426; Thu, 04 Jan
 2024 03:42:50 -0800 (PST)
Date: Thu, 04 Jan 2024 03:42:50 -0800
In-Reply-To: <0000000000007c85f5060dcc3a28@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000034ef50060e1d3bee@google.com>
Subject: Re: [syzbot] Re: [syzbot] [net?] general protection fault in qdisc_create
From: syzbot <syzbot+84339b9e7330daae4d66@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [net?] general protection fault in qdisc_create
Author: jiri@resnulli.us

Sun, Dec 31, 2023 at 12:04:25PM CET, syzbot+84339b9e7330daae4d66@syzkaller.appspotmail.com wrote:
>Hello,
>
>syzbot found the following issue on:
>
>HEAD commit:    c2b2ee36250d bridge: cfm: fix enum typo in br_cc_ccm_tx_pa..
>git tree:       net-next
>console+strace: https://syzkaller.appspot.com/x/log.txt?x=15812036e80000
>kernel config:  https://syzkaller.appspot.com/x/.config?x=a4e9ca8e3c104d2a
>dashboard link: https://syzkaller.appspot.com/bug?extid=84339b9e7330daae4d66
>compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13535445e80000
>C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15fed8f6e80000
>
>Downloadable assets:
>disk image: https://storage.googleapis.com/syzbot-assets/7344dc892eab/disk-c2b2ee36.raw.xz
>vmlinux: https://storage.googleapis.com/syzbot-assets/b5d04995c162/vmlinux-c2b2ee36.xz
>kernel image: https://storage.googleapis.com/syzbot-assets/9558856ab7f4/bzImage-c2b2ee36.xz
>
>The issue was bisected to:
>
>commit 913b47d3424e7d99eaf34b798c47dfa840c64a08
>Author: Victor Nogueira <victor@mojatatu.com>
>Date:   Tue Dec 19 18:16:19 2023 +0000
>
>    net/sched: Introduce tc block netdev tracking infra
>
>bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11992409e80000
>final oops:     https://syzkaller.appspot.com/x/report.txt?x=13992409e80000
>console output: https://syzkaller.appspot.com/x/log.txt?x=15992409e80000
>
>IMPORTANT: if you fix the issue, please add the following tag to the commit:
>Reported-by: syzbot+84339b9e7330daae4d66@syzkaller.appspotmail.com
>Fixes: 913b47d3424e ("net/sched: Introduce tc block netdev tracking infra")
>
>general protection fault, probably for non-canonical address 0xdffffc0000000009: 0000 [#1] PREEMPT SMP KASAN
>KASAN: null-ptr-deref in range [0x0000000000000048-0x000000000000004f]
>CPU: 1 PID: 5061 Comm: syz-executor323 Not tainted 6.7.0-rc6-syzkaller-01658-gc2b2ee36250d #0
>Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
>RIP: 0010:qdisc_block_add_dev net/sched/sch_api.c:1190 [inline]
>RIP: 0010:qdisc_create+0x69e/0x1430 net/sched/sch_api.c:1390
>Code: ea 03 80 3c 02 00 0f 85 50 0c 00 00 4c 8b 6d 08 49 8d 45 48 48 89 c2 48 89 44 24 18 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 0f 0c 00 00 31 d2 be f2 ff 00 00 48 89 df 41 ff
>RSP: 0018:ffffc9000398f420 EFLAGS: 00010206
>RAX: dffffc0000000000 RBX: ffff88802688c800 RCX: ffffffff888dbd56
>RDX: 0000000000000009 RSI: ffffffff888db6fe RDI: ffffffff8f19bde8
>RBP: ffffffff8f19bde0 R08: 0000000000000001 R09: 0000000000000000
>R10: 0000000000000001 R11: 0000000000000001 R12: ffff88804fd64000
>R13: 0000000000000000 R14: 0000000000000001 R15: ffffffff8f19bde0
>FS:  0000555556ef3380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
>CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>CR2: 0000000020001248 CR3: 0000000027f71000 CR4: 00000000003506f0
>DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>Call Trace:
> <TASK>
> tc_modify_qdisc+0x4d5/0x1c30 net/sched/sch_api.c:1788
> rtnetlink_rcv_msg+0x3c7/0xe00 net/core/rtnetlink.c:6615
> netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2543
> netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
> netlink_unicast+0x53b/0x810 net/netlink/af_netlink.c:1367
> netlink_sendmsg+0x8b7/0xd70 net/netlink/af_netlink.c:1908
> sock_sendmsg_nosec net/socket.c:730 [inline]
> __sock_sendmsg+0xd5/0x180 net/socket.c:745
> ____sys_sendmsg+0x6ac/0x940 net/socket.c:2584
> ___sys_sendmsg+0x135/0x1d0 net/socket.c:2638
> __sys_sendmsg+0x117/0x1e0 net/socket.c:2667
> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
> entry_SYSCALL_64_after_hwframe+0x63/0x6b
>RIP: 0033:0x7f9733a8a8b9
>Code: 48 83 c4 28 c3 e8 27 18 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
>RSP: 002b:00007ffd50d7c048 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
>RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9733a8a8b9
>RDX: 0000000000000000 RSI: 0000000020005840 RDI: 0000000000000003
>RBP: 0000000000000000 R08: 0000000000000000 R09: 00007ffd50d7c0c0
>R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>R13: 00007ffd50d7c248 R14: 0000000000000001 R15: 0000000000000001
> </TASK>
>Modules linked in:
>---[ end trace 0000000000000000 ]---
>RIP: 0010:qdisc_block_add_dev net/sched/sch_api.c:1190 [inline]
>RIP: 0010:qdisc_create+0x69e/0x1430 net/sched/sch_api.c:1390
>Code: ea 03 80 3c 02 00 0f 85 50 0c 00 00 4c 8b 6d 08 49 8d 45 48 48 89 c2 48 89 44 24 18 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 0f 0c 00 00 31 d2 be f2 ff 00 00 48 89 df 41 ff
>RSP: 0018:ffffc9000398f420 EFLAGS: 00010206
>RAX: dffffc0000000000 RBX: ffff88802688c800 RCX: ffffffff888dbd56
>RDX: 0000000000000009 RSI: ffffffff888db6fe RDI: ffffffff8f19bde8
>RBP: ffffffff8f19bde0 R08: 0000000000000001 R09: 0000000000000000
>R10: 0000000000000001 R11: 0000000000000001 R12: ffff88804fd64000
>R13: 0000000000000000 R14: 0000000000000001 R15: ffffffff8f19bde0
>FS:  0000555556ef3380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
>CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>CR2: 0000000020001248 CR3: 0000000027f71000 CR4: 00000000003506f0
>DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>----------------
>Code disassembly (best guess), 1 bytes skipped:
>   0:	03 80 3c 02 00 0f    	add    0xf00023c(%rax),%eax
>   6:	85 50 0c             	test   %edx,0xc(%rax)
>   9:	00 00                	add    %al,(%rax)
>   b:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
>   f:	49 8d 45 48          	lea    0x48(%r13),%rax
>  13:	48 89 c2             	mov    %rax,%rdx
>  16:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
>  1b:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
>  22:	fc ff df
>  25:	48 c1 ea 03          	shr    $0x3,%rdx
>* 29:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
>  2d:	0f 85 0f 0c 00 00    	jne    0xc42
>  33:	31 d2                	xor    %edx,%edx
>  35:	be f2 ff 00 00       	mov    $0xfff2,%esi
>  3a:	48 89 df             	mov    %rbx,%rdi
>  3d:	41                   	rex.B
>  3e:	ff                   	.byte 0xff
>
>
>---
>This report is generated by a bot. It may contain errors.
>See https://goo.gl/tpsmEJ for more information about syzbot.
>syzbot engineers can be reached at syzkaller@googlegroups.com.
>
>syzbot will keep track of this issue. See:
>https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>
>If the report is already addressed, let syzbot know by replying with:
>#syz fix: exact-commit-title
>
>If you want syzbot to run the reproducer, reply with:
>#syz test: git://repo/address.git branch-or-commit-hash

#syz test: https://github.com/jpirko/linux_mlxsw.git wip_tc_block_fix

