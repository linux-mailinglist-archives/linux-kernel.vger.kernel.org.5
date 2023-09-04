Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB9D79121F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352408AbjIDH25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbjIDH2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:28:55 -0400
Received: from mail-pf1-f205.google.com (mail-pf1-f205.google.com [209.85.210.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B1611A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 00:28:48 -0700 (PDT)
Received: by mail-pf1-f205.google.com with SMTP id d2e1a72fcca58-68a43131e39so1237422b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 00:28:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693812528; x=1694417328;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QVgiY8OA75rHhUIt6YHyqN9CngkIgv7Jcz7IdH8I8GI=;
        b=IQOQ1lS+tENOJHXjOgLvLlhHn/Nehl5JJELnuiK4ShpjtC2z2UNv6vaomeRUOdzVmz
         1NkLsomeFLL/vU28RnnyNYgLuNFc9TQhfEqCqfXH7U2QRDhfOACZmAOk92OCwYff/9XQ
         L/6vaMJAkG1bh3nNXsN/ikIh3FtqqUa/DhzDSOUMBbBImH65ZVVkuf+5tYAiYnfYEcm+
         3vh/U6nXOPs9knTN0V1GSAnZRFfJ9/ARdFnWRsLaw7QvgmKxiWBu5F6vRPjRR0xLgDwt
         gA7EZ1IrAh9IMC1sBy+fJRR6fuwiSR4L+AbiENPbFF4Pod2WJXMRSCo696bEV5GVDTlA
         Co6A==
X-Gm-Message-State: AOJu0YzbozZdJzCr7peuuWdvrVRZfoSXiimHGNI/wapdTh6JZ49v2F8Z
        fUVpsYXoXuEECt53URSm2HuVDE0q3dCh03pvmD2ONoTMNVPs
X-Google-Smtp-Source: AGHT+IF/xvb0iQBQjQ+RPYcTS1ZMDO/tOriyfyhlA+qM1gTNV0udPmlBs571HgpqHPqh8CTUvXo4gDEA8xsSBWeIDQAPCDePaKew
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:a8d:b0:68a:55ff:3a01 with SMTP id
 b13-20020a056a000a8d00b0068a55ff3a01mr3850818pfl.0.1693812528416; Mon, 04 Sep
 2023 00:28:48 -0700 (PDT)
Date:   Mon, 04 Sep 2023 00:28:48 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000128dfc060483768b@google.com>
Subject: [syzbot] [kernel?] general protection fault in rfkill_register
From:   syzbot <syzbot+0e04fda096b0ca4f4d6c@syzkaller.appspotmail.com>
To:     andriy.shevchenko@linux.intel.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b84acc11b1c9 Merge tag 'fbdev-for-6.6-rc1' of git://git.ke..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17f3c1a8680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3aba740d8a88ff1d
dashboard link: https://syzkaller.appspot.com/bug?extid=0e04fda096b0ca4f4d6c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16dd4f50680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16af7e70680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8b5634407855/disk-b84acc11.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/31f561af0e06/vmlinux-b84acc11.xz
kernel image: https://storage.googleapis.com/syzbot-assets/37275212826f/bzImage-b84acc11.xz

The issue was bisected to:

commit d21fdd07cea418c0d98c8a15fc95b8b8970801e7
Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Thu Aug 17 09:12:21 2023 +0000

    driver core: Return proper error code when dev_set_name() fails

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=126a5357a80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=116a5357a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=166a5357a80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0e04fda096b0ca4f4d6c@syzkaller.appspotmail.com
Fixes: d21fdd07cea4 ("driver core: Return proper error code when dev_set_name() fails")

RBP: 0000000000000002 R08: 00007ffead0f5096 R09: 00000000000000a0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffead0f530c
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>
general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 PID: 5042 Comm: syz-executor363 Not tainted 6.5.0-syzkaller-10204-gb84acc11b1c9 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:strchr+0x1b/0xb0 lib/string.c:329
Code: 31 af f7 48 8b 74 24 08 48 8b 14 24 eb 89 90 f3 0f 1e fa 48 b8 00 00 00 00 00 fc ff df 48 89 fa 55 48 c1 ea 03 53 48 83 ec 10 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 51 0f b6 07 89
RSP: 0018:ffffc900044cf5f0 EFLAGS: 00010286
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000025 RDI: 0000000000000000
RBP: ffffc900044cf680 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffffc900044cf680
R13: 0000000000000cc0 R14: ffff888141735018 R15: 0000000000000001
FS:  0000555556c58380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000310 CR3: 00000000230cc000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 kvasprintf_const+0x25/0x190 lib/kasprintf.c:45
 kobject_set_name_vargs+0x5a/0x130 lib/kobject.c:272
 kobject_add_varg lib/kobject.c:366 [inline]
 kobject_add+0x12a/0x240 lib/kobject.c:424
 device_add+0x290/0x1ac0 drivers/base/core.c:3560
 rfkill_register+0x1a9/0xb00 net/rfkill/core.c:1070
 nfc_register_device+0x11f/0x3c0 net/nfc/core.c:1132
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
RIP: 0033:0x7fdf558b4cf9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffead0f52f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007ffead0f5310 RCX: 00007fdf558b4cf9
RDX: 0000000000000002 RSI: 0000000020000300 RDI: ffffffffffffff9c
RBP: 0000000000000002 R08: 00007ffead0f5096 R09: 00000000000000a0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffead0f530c
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:strchr+0x1b/0xb0 lib/string.c:329
Code: 31 af f7 48 8b 74 24 08 48 8b 14 24 eb 89 90 f3 0f 1e fa 48 b8 00 00 00 00 00 fc ff df 48 89 fa 55 48 c1 ea 03 53 48 83 ec 10 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 51 0f b6 07 89
RSP: 0018:ffffc900044cf5f0 EFLAGS: 00010286
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000025 RDI: 0000000000000000
RBP: ffffc900044cf680 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffffc900044cf680
R13: 0000000000000cc0 R14: ffff888141735018 R15: 0000000000000001
FS:  0000555556c58380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000310 CR3: 00000000230cc000 CR4: 0000000000350ee0
----------------
Code disassembly (best guess):
   0:	31 af f7 48 8b 74    	xor    %ebp,0x748b48f7(%rdi)
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
