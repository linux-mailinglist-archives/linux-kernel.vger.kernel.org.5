Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EDF78A95C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 11:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjH1JyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 05:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjH1Jxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 05:53:41 -0400
Received: from mail-pg1-f207.google.com (mail-pg1-f207.google.com [209.85.215.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3B4103
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 02:53:38 -0700 (PDT)
Received: by mail-pg1-f207.google.com with SMTP id 41be03b00d2f7-56f89b2535dso3154855a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 02:53:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693216417; x=1693821217;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x7dWcFNPPCCI9yThhBQMTZFWveF2+1+YSBEVckSTzFA=;
        b=Z6dTXuiUp3KTjaUPuFKIDTAl7ABsPPKFOxz9fgsIHx4eq/cAxT9XP1ir6cH48FYzhV
         pTXSdh71pugKVpqZU+/XRITZKjT2MU3Tqn1M+WuUqfLwrHtkwWsvbcveHTHTsiY7OKwP
         lgvD65DbnjDnFTvAUvq6cIo5C7zJkZXi3mofcsCyHH1zUC0YOtiNT6NY6n4FI5k+Mrq0
         ado7bhzZ3hXb11t9DrQG3PIHalp8vfawkhKCbO1wcreBQBiFRP9EBiHGYfP11TX04d8C
         pTZ575EjTIr9J2UAI2/dNbmsB9UzQBR/mNK/NJokjxsdUutkBvf4kyNcDyES/intcYSw
         OTrA==
X-Gm-Message-State: AOJu0Yx4AtFoSmqoaxlAzRQGh1yAtn561kn/KYzbtOU7TfSbOM2sOOtI
        WNly11YKTmp0rAIkBmFry+LnmOswP/BwaukJ/8C2MigzH01U
X-Google-Smtp-Source: AGHT+IGvN4NGZ45y0j8neiA+OQrrpJIGNX5f9Af1dK8NOtGwF+89wJIn/unOhDp+RrdLxSNgLB1wqAwFbETsmGyXAF7C8oMxO6SJ
MIME-Version: 1.0
X-Received: by 2002:a63:3c0b:0:b0:56a:b197:12ca with SMTP id
 j11-20020a633c0b000000b0056ab19712camr5154443pga.2.1693216417731; Mon, 28 Aug
 2023 02:53:37 -0700 (PDT)
Date:   Mon, 28 Aug 2023 02:53:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001b6a0c0603f8ab85@google.com>
Subject: [syzbot] [kernel?] general protection fault in nfc_register_device
From:   syzbot <syzbot+bdfb03b1ec8b342c12cb@syzkaller.appspotmail.com>
To:     andriy.shevchenko@linux.intel.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    626932085009 Add linux-next specific files for 20230825
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11f70287a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8a8c992a790e5073
dashboard link: https://syzkaller.appspot.com/bug?extid=bdfb03b1ec8b342c12cb
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=127e0db7a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12fceccba80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/46ec18b3c2fb/disk-62693208.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b4ea0cb78498/vmlinux-62693208.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5fb3938c7272/bzImage-62693208.xz

The issue was bisected to:

commit d21fdd07cea418c0d98c8a15fc95b8b8970801e7
Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Thu Aug 17 09:12:21 2023 +0000

    driver core: Return proper error code when dev_set_name() fails

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10abc1e0680000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12abc1e0680000
console output: https://syzkaller.appspot.com/x/log.txt?x=14abc1e0680000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bdfb03b1ec8b342c12cb@syzkaller.appspotmail.com
Fixes: d21fdd07cea4 ("driver core: Return proper error code when dev_set_name() fails")

RBP: 0000000000000002 R08: 00007ffdb1dc9296 R09: 00000000000000a0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffdb1dc950c
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>
general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 5056 Comm: syz-executor350 Not tainted 6.5.0-rc7-next-20230825-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:strchr+0x1b/0xb0 lib/string.c:329
Code: ad ac f7 48 8b 74 24 08 48 8b 14 24 eb 89 90 f3 0f 1e fa 48 b8 00 00 00 00 00 fc ff df 48 89 fa 55 48 c1 ea 03 53 48 83 ec 10 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 51 0f b6 07 89
RSP: 0018:ffffc90003a3f630 EFLAGS: 00010286
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000025 RDI: 0000000000000000
RBP: ffffc90003a3f6c0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffc90003a3f6c0
R13: 0000000000000cc0 R14: ffff88801e01d180 R15: 0000000000000001
FS:  0000555555c8e380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe716281c00 CR3: 00000000730bb000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kvasprintf_const+0x25/0x190 lib/kasprintf.c:45
 kobject_set_name_vargs+0x5a/0x130 lib/kobject.c:272
 kobject_add_varg lib/kobject.c:366 [inline]
 kobject_add+0x12a/0x240 lib/kobject.c:424
 device_add+0x290/0x1ac0 drivers/base/core.c:3560
 nfc_register_device+0x41/0x3c0 net/nfc/core.c:1118
 nci_register_device+0x7f4/0xb80 net/nfc/nci/core.c:1257
 virtual_ncidev_open+0x147/0x220 drivers/nfc/virtual_ncidev.c:148
 misc_open+0x3da/0x4c0 drivers/char/misc.c:165
 chrdev_open+0x277/0x700 fs/char_dev.c:414
 do_dentry_open+0x88b/0x1730 fs/open.c:929
 do_open fs/namei.c:3639 [inline]
 path_openat+0x19af/0x29c0 fs/namei.c:3796
 do_filp_open+0x1de/0x430 fs/namei.c:3823
 do_sys_openat2+0x176/0x1e0 fs/open.c:1422
 do_sys_open fs/open.c:1437 [inline]
 __do_sys_openat fs/open.c:1453 [inline]
 __se_sys_openat fs/open.c:1448 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1448
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fe71624ecf9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdb1dc94f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007ffdb1dc9510 RCX: 00007fe71624ecf9
RDX: 0000000000000002 RSI: 0000000020000000 RDI: ffffffffffffff9c
RBP: 0000000000000002 R08: 00007ffdb1dc9296 R09: 00000000000000a0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffdb1dc950c
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:strchr+0x1b/0xb0 lib/string.c:329
Code: ad ac f7 48 8b 74 24 08 48 8b 14 24 eb 89 90 f3 0f 1e fa 48 b8 00 00 00 00 00 fc ff df 48 89 fa 55 48 c1 ea 03 53 48 83 ec 10 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 51 0f b6 07 89
RSP: 0018:ffffc90003a3f630 EFLAGS: 00010286
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000025 RDI: 0000000000000000
RBP: ffffc90003a3f6c0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffc90003a3f6c0
R13: 0000000000000cc0 R14: ffff88801e01d180 R15: 0000000000000001
FS:  0000555555c8e380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe716281c00 CR3: 00000000730bb000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	ad                   	lods   %ds:(%rsi),%eax
   1:	ac                   	lods   %ds:(%rsi),%al
   2:	f7 48 8b 74 24 08 48 	testl  $0x48082474,-0x75(%rax)
   9:	8b 14 24             	mov    (%rsp),%edx
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
