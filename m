Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AED7807846
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 19:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378772AbjLFS60 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Dec 2023 13:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378945AbjLFS6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 13:58:24 -0500
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7CDD53
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 10:58:28 -0800 (PST)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6d7fc0322e5so115299a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 10:58:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701889108; x=1702493908;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xmf2LAxMIXPzeJNBwaDifE4wRPnB7Vykuuevu9JSGjQ=;
        b=HBNaDMdR45ec/iTq+ucoIduRNO9hsx1L+jHvjBpw0xx0tWF6FKRBqedifgowvhPMl5
         +aZ8GJmBmO0GlL7QDXo8E9J5ibMe9zEAs48Ota19x3ckcbbaXZ7QOrOOCmPDUV6whK2e
         6SzYEzCMRgoxHHQHoJVbtDY5cTdEvyWicPqS5Pb13XrbtEevcaamUCMLHnUrf1Yd/qSL
         VmVVEYVJlvP/AoLen2Z02hHNXPhpXUhUaPt0hmsyRxdb0AU3aXk4vx7+6F+ci5j/6TST
         a4XaJiRm3T5JFe5z+cV1vfja3mrgSsqFM3vpffuQTZkzbT+d3q2CIaWWwDFhDflFL3d+
         xgsQ==
X-Gm-Message-State: AOJu0YyuvFMDy8tjLq5rthpBNTUENaP4ZUlvB/xic1JjFhRX15I1sX2M
        OFXCjn8z4yih2pbZMeEFa/El+d0DuuRdozgxQxXXDSYiwnqP3R8=
X-Google-Smtp-Source: AGHT+IFd1fCpoeHmcaeFw/KL0tm4fuxX124n87O9cd/fR8RzeH5xlvDMGmqfpkjXAo6p46ZtbmkFhLi3xQnNJzoa8cdpDWFFtf6A
MIME-Version: 1.0
X-Received: by 2002:a05:6871:3402:b0:1fb:fed:9b65 with SMTP id
 nh2-20020a056871340200b001fb0fed9b65mr1552585oac.5.1701889107427; Wed, 06 Dec
 2023 10:58:27 -0800 (PST)
Date:   Wed, 06 Dec 2023 10:58:27 -0800
In-Reply-To: <000000000000fdfe4b060b91993f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b206cf060bdbefcb@google.com>
Subject: Re: [syzbot] Re: [syzbot] [fs?] general protection fault in pagemap_scan_hugetlb_entry
From:   syzbot <syzbot+6e2ccedb96d1174e6a5f@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [fs?] general protection fault in pagemap_scan_hugetlb_entry
Author: sidhartha.kumar@oracle.com

#syz test

________________________________
From: syzbot <syzbot+6e2ccedb96d1174e6a5f@syzkaller.appspotmail.com>
Sent: Saturday, December 2, 2023 6:17 PM
To: akpm@linux-foundation.org <akpm@linux-foundation.org>; dan.carpenter@linaro.org <dan.carpenter@linaro.org>; linux-fsdevel@vger.kernel.org <linux-fsdevel@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; linux-mm@kvack.org <linux-mm@kvack.org>; llvm@lists.linux.dev <llvm@lists.linux.dev>; Mike Kravetz <mike.kravetz@oracle.com>; muchun.song@linux.dev <muchun.song@linux.dev>; nathan@kernel.org <nathan@kernel.org>; ndesaulniers@google.com <ndesaulniers@google.com>; Sidhartha Kumar <sidhartha.kumar@oracle.com>; syzkaller-bugs@googlegroups.com <syzkaller-bugs@googlegroups.com>; trix@redhat.com <trix@redhat.com>
Subject: [syzbot] [fs?] general protection fault in pagemap_scan_hugetlb_entry

Hello,

syzbot found the following issue on:

HEAD commit:    df60cee26a2e Merge tag '6.7-rc3-smb3-server-fixes' of git:..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17ad46fce80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bb39fe85d254f638
dashboard link: https://syzkaller.appspot.com/bug?extid=6e2ccedb96d1174e6a5f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17befd62e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10d5a90ce80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c632017e0dc4/disk-df60cee2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f94c8fa25aeb/vmlinux-df60cee2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/af80f80c708b/bzImage-df60cee2.xz

The issue was bisected to:

commit a08c7193e4f18dc8508f2d07d0de2c5b94cb39a3
Author: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Date:   Tue Sep 26 19:20:17 2023 +0000

    mm/filemap: remove hugetlb special casing in filemap.c

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17f61552e80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=140e1552e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=100e1552e80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6e2ccedb96d1174e6a5f@syzkaller.appspotmail.com
Fixes: a08c7193e4f1 ("mm/filemap: remove hugetlb special casing in filemap.c")

general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 5072 Comm: syz-executor107 Not tainted 6.7.0-rc3-syzkaller-00014-gdf60cee26a2e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
RIP: 0010:pagemap_scan_backout_range fs/proc/task_mmu.c:1946 [inline]
RIP: 0010:pagemap_scan_hugetlb_entry+0x6ca/0x1130 fs/proc/task_mmu.c:2254
Code: 3c 02 00 0f 85 68 09 00 00 48 8b 83 80 00 00 00 48 8d 04 40 4d 8d 6c c5 00 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 <80> 3c 02 00 0f 85 51 09 00 00 4d 8b 75 00 48 8b 7c 24 08 4c 89 f6
RSP: 0018:ffffc90003a2fa50 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffffc90003a2fdb0 RCX: ffffffff82111e46
RDX: 0000000000000000 RSI: ffffffff82111e54 RDI: ffffc90003a2fe30
RBP: 1ffff92000745f52 R08: 0000000000000006 R09: 0000000020ffc000
R10: 00000000211f9000 R11: ffffffff915f5de8 R12: ffff8880299e0300
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000020ffc000
FS:  0000555555c7b380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005fdeb8 CR3: 00000000752b4000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 walk_hugetlb_range mm/pagewalk.c:326 [inline]
 __walk_page_range+0x36c/0x770 mm/pagewalk.c:393
 walk_page_range+0x626/0xa80 mm/pagewalk.c:521
 do_pagemap_scan+0x40d/0xcd0 fs/proc/task_mmu.c:2437
 do_pagemap_cmd+0x5e/0x80 fs/proc/task_mmu.c:2478
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f171819d669
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffbe81bb68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fffbe81bb80 RCX: 00007f171819d669
RDX: 0000000020000040 RSI: 00000000c0606610 RDI: 0000000000000003
RBP: 00007f1718210610 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000286 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fffbe81bdb8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:pagemap_scan_backout_range fs/proc/task_mmu.c:1946 [inline]
RIP: 0010:pagemap_scan_hugetlb_entry+0x6ca/0x1130 fs/proc/task_mmu.c:2254
Code: 3c 02 00 0f 85 68 09 00 00 48 8b 83 80 00 00 00 48 8d 04 40 4d 8d 6c c5 00 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 <80> 3c 02 00 0f 85 51 09 00 00 4d 8b 75 00 48 8b 7c 24 08 4c 89 f6
RSP: 0018:ffffc90003a2fa50 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffffc90003a2fdb0 RCX: ffffffff82111e46
RDX: 0000000000000000 RSI: ffffffff82111e54 RDI: ffffc90003a2fe30
RBP: 1ffff92000745f52 R08: 0000000000000006 R09: 0000000020ffc000
R10: 00000000211f9000 R11: ffffffff915f5de8 R12: ffff8880299e0300
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000020ffc000
FS:  0000555555c7b380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005fdeb8 CR3: 00000000752b4000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:   3c 02                    cmp    $0x2,%al
   2:   00 0f                    add    %cl,(%rdi)
   4:   85 68 09                 test   %ebp,0x9(%rax)
   7:   00 00                    add    %al,(%rax)
   9:   48 8b 83 80 00 00 00     mov    0x80(%rbx),%rax
  10:   48 8d 04 40              lea    (%rax,%rax,2),%rax
  14:   4d 8d 6c c5 00           lea    0x0(%r13,%rax,8),%r13
  19:   48 b8 00 00 00 00 00     movabs $0xdffffc0000000000,%rax
  20:   fc ff df
  23:   4c 89 ea                 mov    %r13,%rdx
  26:   48 c1 ea 03              shr    $0x3,%rdx
* 2a:   80 3c 02 00              cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:   0f 85 51 09 00 00        jne    0x985
  34:   4d 8b 75 00              mov    0x0(%r13),%r14
  38:   48 8b 7c 24 08           mov    0x8(%rsp),%rdi
  3d:   4c 89 f6                 mov    %r14,%rsi


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
