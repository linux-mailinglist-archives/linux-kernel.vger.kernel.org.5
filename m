Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFBA798461
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 10:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237952AbjIHIrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 04:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjIHIrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 04:47:03 -0400
Received: from mail-pg1-f208.google.com (mail-pg1-f208.google.com [209.85.215.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B291BE6
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 01:46:58 -0700 (PDT)
Received: by mail-pg1-f208.google.com with SMTP id 41be03b00d2f7-573c84224easo2531011a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 01:46:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694162817; x=1694767617;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FMXJpghyOhqovU2L13PsGuPmT91hB5S49awdBDMBk38=;
        b=sreiPAQUE5JXg+zNqixTKugyv62crU2eFf0kYyGo2ChnNOiSyAR07JcKY3JpxgBWAF
         iwH5ujXu7q5/rn6/hnVyKXai181q6Zxmyt573SBPz6nPMB2UyNDtgocueH3Di/TYFyg2
         8EF8T2SWDeSnVS97inxbxv1sKF9zNu+LcLOS586kK0aQ6JibL6Z9RtrtKEMiFJ01wg6G
         E0KQfQw0iBEwUE2luSwTKo3yYUiCTHZYPln3S/+IeyK1ce5fpm2KfrOZaRP8H1ZatWW3
         59X2a6CZSYITWmu4x8SXcxuifgAyJqBl+isYZyXyM5piDf35Ckt23N5Ix5+7r21k9vmv
         Ukww==
X-Gm-Message-State: AOJu0YxtrSj78DRMdPqKH2iB2YRBfN5RBkY94jmOABDmliesUAwZnUrL
        982q0Jpp9gf76ycK+qjGsJJn0OJx3ryjBXt6rON0WIXs0qbm
X-Google-Smtp-Source: AGHT+IGmNiE55XOWrc5iYbCsONV42puRMimYScq1DXkM0RskLxZ7o5F95nllO9w9eczKDfcFdgy2Vian/kffCXWJRtx7EfAg1pCT
MIME-Version: 1.0
X-Received: by 2002:a63:9313:0:b0:569:450d:cf3d with SMTP id
 b19-20020a639313000000b00569450dcf3dmr297800pge.6.1694162817649; Fri, 08 Sep
 2023 01:46:57 -0700 (PDT)
Date:   Fri, 08 Sep 2023 01:46:57 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f014150604d5040a@google.com>
Subject: [syzbot] [kernel?] general protection fault in serio_handle_event
From:   syzbot <syzbot+bbc59256015533127d80@syzkaller.appspotmail.com>
To:     andriy.shevchenko@linux.intel.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    db906f0ca6bb Merge tag 'phy-for-6.6' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11f66447a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3bd57a1ac08277b0
dashboard link: https://syzkaller.appspot.com/bug?extid=bbc59256015533127d80
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=138b9848680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1537ea00680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3c57e6e58eb2/disk-db906f0c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f999d9f3cd94/vmlinux-db906f0c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9d9c5e553ff2/bzImage-db906f0c.xz

The issue was bisected to:

commit d21fdd07cea418c0d98c8a15fc95b8b8970801e7
Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Thu Aug 17 09:12:21 2023 +0000

    driver core: Return proper error code when dev_set_name() fails

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=122032f0680000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=112032f0680000
console output: https://syzkaller.appspot.com/x/log.txt?x=162032f0680000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bbc59256015533127d80@syzkaller.appspotmail.com
Fixes: d21fdd07cea4 ("driver core: Return proper error code when dev_set_name() fails")

general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 774 Comm: kworker/0:2 Not tainted 6.5.0-syzkaller-11275-gdb906f0ca6bb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Workqueue: events_long serio_handle_event
RIP: 0010:strchr+0x1b/0xb0 lib/string.c:329
Code: 01 ae f7 48 8b 74 24 08 48 8b 14 24 eb 89 90 f3 0f 1e fa 48 b8 00 00 00 00 00 fc ff df 48 89 fa 55 48 c1 ea 03 53 48 83 ec 10 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 51 0f b6 07 89
RSP: 0018:ffffc90003ccfa58 EFLAGS: 00010282
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000025 RDI: 0000000000000000
RBP: ffffc90003ccfae8 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffc90003ccfae8
R13: 0000000000000cc0 R14: 0000000000000000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7335610882 CR3: 000000006e989000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 kvasprintf_const+0x25/0x190 lib/kasprintf.c:45
 kobject_set_name_vargs+0x5a/0x130 lib/kobject.c:272
 kobject_add_varg lib/kobject.c:366 [inline]
 kobject_add+0x12a/0x240 lib/kobject.c:424
 device_add+0x290/0x1ac0 drivers/base/core.c:3560
 serio_add_port drivers/input/serio/serio.c:539 [inline]
 serio_handle_event+0x63b/0xa90 drivers/input/serio/serio.c:207
 process_one_work+0x887/0x15d0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8bb/0x1290 kernel/workqueue.c:2784
 kthread+0x33a/0x430 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:strchr+0x1b/0xb0 lib/string.c:329
Code: 01 ae f7 48 8b 74 24 08 48 8b 14 24 eb 89 90 f3 0f 1e fa 48 b8 00 00 00 00 00 fc ff df 48 89 fa 55 48 c1 ea 03 53 48 83 ec 10 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 51 0f b6 07 89
RSP: 0018:ffffc90003ccfa58 EFLAGS: 00010282
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000025 RDI: 0000000000000000
RBP: ffffc90003ccfae8 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffc90003ccfae8
R13: 0000000000000cc0 R14: 0000000000000000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f733558f000 CR3: 0000000078402000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	01 ae f7 48 8b 74    	add    %ebp,0x748b48f7(%rsi)
   6:	24 08                	and    $0x8,%al
   8:	48 8b 14 24          	mov    (%rsp),%rdx
   c:	eb 89                	jmp    0xffffff97
   e:	90                   	nop
   f:	f3 0f 1e fa          	endbr64
  13:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1a:	fc ff df
  1d:	48 89 fa             	mov    %rdi,%rdx
  20:	55                   	push   %rbp
  21:	48 c1 ea 03          	shr    $0x3,%rdx
  25:	53                   	push   %rbx
  26:	48 83 ec 10          	sub    $0x10,%rsp
* 2a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax <-- trapping instruction
  2e:	48 89 fa             	mov    %rdi,%rdx
  31:	83 e2 07             	and    $0x7,%edx
  34:	38 d0                	cmp    %dl,%al
  36:	7f 04                	jg     0x3c
  38:	84 c0                	test   %al,%al
  3a:	75 51                	jne    0x8d
  3c:	0f b6 07             	movzbl (%rdi),%eax
  3f:	89                   	.byte 0x89


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
