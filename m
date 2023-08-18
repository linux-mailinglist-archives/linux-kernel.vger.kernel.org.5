Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3AD0781078
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 18:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378681AbjHRQhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 12:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378682AbjHRQg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 12:36:57 -0400
Received: from mail-pl1-f208.google.com (mail-pl1-f208.google.com [209.85.214.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D123C0A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 09:36:54 -0700 (PDT)
Received: by mail-pl1-f208.google.com with SMTP id d9443c01a7336-1bdbd0a7929so14670725ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 09:36:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692376614; x=1692981414;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bSZhR6gVcA72ML2uSus2xSyyM8G/A9KFGhoQSCEA4y8=;
        b=E1fr/nQpyUSXQZE4DRbZFG3bgINIdePMin67IsdS33M6lf4BeVLzSDd4kefCd4L+dv
         K6MlCaWETso612jYqC10KAbAi7vwyMOym2rTvdj9GYtPQ9o+muArN5ONTe2gxL2pMs+1
         oQibgss8gy5g5iWjffWnBaNdjRMgVa/Jtu/78Q8VWZMJlDGMxNhJvEmpEoH09i3A9LXC
         W2SNqe2zYeLZ9EbSQBm8Y1ITeh/xLPnLOYCciSObwe4Tp8XG90r8AIJsLqKOyQowbpSB
         kFQWz+TwIroHKkLcAQ+mMHQlFGxrhrXox6kSHoxVgbatqiTMDxdymOec8w5uRN6zCzlt
         9UIw==
X-Gm-Message-State: AOJu0YxR3+zlRVaXaqNAfIoadveBDxKBbcfYG8cDXCW678kNK0P/Y23o
        aNLQFrFxQrOn4O0e9DKBNcQIzynSZGQh46lW1UQEEkoHgTMo
X-Google-Smtp-Source: AGHT+IGXX899sngJ8tvQ92ARO1tpgGyaaO+5lPxe4DxUAOZiuYcIzTTyk3Hpb3x0kW25hhoR08fkB9gkiv0VC3PiU5iF2Rdm7ecI
MIME-Version: 1.0
X-Received: by 2002:a17:902:fb0d:b0:1bc:a3b:e902 with SMTP id
 le13-20020a170902fb0d00b001bc0a3be902mr965734plb.3.1692376613958; Fri, 18 Aug
 2023 09:36:53 -0700 (PDT)
Date:   Fri, 18 Aug 2023 09:36:53 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e6c05806033522d3@google.com>
Subject: [syzbot] [hams?] general protection fault in prepare_to_wait (2)
From:   syzbot <syzbot+666c97e4686410e79649@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, ralf@linux-mips.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ace0ab3a4b54 Revert "vlan: Fix VLAN 0 memory leak"
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=152cdb63a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e670757e16affb
dashboard link: https://syzkaller.appspot.com/bug?extid=666c97e4686410e79649
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10a80fc3a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e03bf2f0ff9c/disk-ace0ab3a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ad6e79c01723/vmlinux-ace0ab3a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/617319e5afb7/bzImage-ace0ab3a.xz

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=157eda9ba80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=177eda9ba80000
console output: https://syzkaller.appspot.com/x/log.txt?x=137eda9ba80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+666c97e4686410e79649@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 0 PID: 5059 Comm: syz-executor.0 Not tainted 6.5.0-rc5-syzkaller-00194-gace0ab3a4b54 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:__lock_acquire+0x109/0x5de0 kernel/locking/lockdep.c:5012
Code: 45 85 c9 0f 84 cc 0e 00 00 44 8b 05 11 6e 23 0b 45 85 c0 0f 84 be 0d 00 00 48 ba 00 00 00 00 00 fc ff df 4c 89 d1 48 c1 e9 03 <80> 3c 11 00 0f 85 e8 40 00 00 49 81 3a a0 69 48 90 0f 84 96 0d 00
RSP: 0018:ffffc90003d6f9e0 EFLAGS: 00010006
RAX: ffff8880244c8000 RBX: 1ffff920007adf6c RCX: 0000000000000003
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000018
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000018 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f51d519a6c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f51d5158d58 CR3: 000000002943f000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire kernel/locking/lockdep.c:5761 [inline]
 lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5726
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
 prepare_to_wait+0x47/0x380 kernel/sched/wait.c:269
 nr_accept+0x20d/0x650 net/netrom/af_netrom.c:798
 do_accept+0x3a6/0x570 net/socket.c:1872
 __sys_accept4_file net/socket.c:1913 [inline]
 __sys_accept4+0x99/0x120 net/socket.c:1943
 __do_sys_accept4 net/socket.c:1954 [inline]
 __se_sys_accept4 net/socket.c:1951 [inline]
 __x64_sys_accept4+0x96/0x100 net/socket.c:1951
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f51d447cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f51d519a0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000120
RAX: ffffffffffffffda RBX: 00007f51d459bf80 RCX: 00007f51d447cae9
RDX: 0000000020000400 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007f51d44c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000800 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f51d459bf80 R15: 00007ffc25c34e48
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__lock_acquire+0x109/0x5de0 kernel/locking/lockdep.c:5012
Code: 45 85 c9 0f 84 cc 0e 00 00 44 8b 05 11 6e 23 0b 45 85 c0 0f 84 be 0d 00 00 48 ba 00 00 00 00 00 fc ff df 4c 89 d1 48 c1 e9 03 <80> 3c 11 00 0f 85 e8 40 00 00 49 81 3a a0 69 48 90 0f 84 96 0d 00
RSP: 0018:ffffc90003d6f9e0 EFLAGS: 00010006
RAX: ffff8880244c8000 RBX: 1ffff920007adf6c RCX: 0000000000000003
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000018
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000018 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f51d519a6c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f51d5158d58 CR3: 000000002943f000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	45 85 c9             	test   %r9d,%r9d
   3:	0f 84 cc 0e 00 00    	je     0xed5
   9:	44 8b 05 11 6e 23 0b 	mov    0xb236e11(%rip),%r8d        # 0xb236e21
  10:	45 85 c0             	test   %r8d,%r8d
  13:	0f 84 be 0d 00 00    	je     0xdd7
  19:	48 ba 00 00 00 00 00 	movabs $0xdffffc0000000000,%rdx
  20:	fc ff df
  23:	4c 89 d1             	mov    %r10,%rcx
  26:	48 c1 e9 03          	shr    $0x3,%rcx
* 2a:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1) <-- trapping instruction
  2e:	0f 85 e8 40 00 00    	jne    0x411c
  34:	49 81 3a a0 69 48 90 	cmpq   $0xffffffff904869a0,(%r10)
  3b:	0f                   	.byte 0xf
  3c:	84                   	.byte 0x84
  3d:	96                   	xchg   %eax,%esi
  3e:	0d                   	.byte 0xd


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
