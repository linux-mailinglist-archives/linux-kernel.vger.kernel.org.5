Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB837F42D8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235416AbjKVJwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235118AbjKVJwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:52:24 -0500
Received: from mail-pj1-f77.google.com (mail-pj1-f77.google.com [209.85.216.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561AB10D5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:51:19 -0800 (PST)
Received: by mail-pj1-f77.google.com with SMTP id 98e67ed59e1d1-27ffe79ec25so6939070a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:51:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700646679; x=1701251479;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l66RaqguqD/3B4IkgcVy1WBTBB1XpO/eN3kYlTYABtM=;
        b=w0YtekyzkxXPNtXZcIaNhxl7naha+vwmRNShLYs1x05LJYEpR0l7UsSMshou8G8f6U
         WeEUDjzVE8dWyuv5WOwqrIyPx2oo2aQcRXxyx5Yl4GE4u/yChkMdkhzfkxb70ghOvgoZ
         oZknBlFKYFDOaMOSh8AZT83zUYKWJgPJWWDezv5gPZC8ZaqN1r6G794RqYEZH8fdeNfK
         k8eD6qKZq/TNHUmlM+AjW/rO3Te0WkHWjV3j3gyAAX6qmXekmoBxrJTx6k0jGQXCshrR
         JHZAEaEST4KIl4Zjv0tFmfafbEhM/f0bqiv/rDLlZg72FbjOhV0KIfcV/MxutEuD90Jh
         2f5A==
X-Gm-Message-State: AOJu0YyKvQukndwXMEetBWgJ6b1fBP9yq0iZXgwCvIbYOmU/TD0IAWXM
        ri3KebgNeuv+uthE2Gw9jq8PBSL426kMlvFhNOI1zQVCi9e+
X-Google-Smtp-Source: AGHT+IENrij5vb6CyXb+xAa2zLjnSn9Iq0CiTRNBQxD6T4Hm2RR/e5gzykK6A3vl7vdVttb3v0/LwN7IL1eZg9PG1TP2kBrMpGbv
MIME-Version: 1.0
X-Received: by 2002:a17:90a:2e88:b0:283:9965:e8c9 with SMTP id
 r8-20020a17090a2e8800b002839965e8c9mr420095pjd.9.1700646678798; Wed, 22 Nov
 2023 01:51:18 -0800 (PST)
Date:   Wed, 22 Nov 2023 01:51:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002daad2060abaa9da@google.com>
Subject: [syzbot] [kernel?] general protection fault in joydev_connect
From:   syzbot <syzbot+786b124fe4ce4dc99357@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    0468be89b3fa Merge tag 'iommu-updates-v6.6' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15d71367a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=39744401c57166fc
dashboard link: https://syzkaller.appspot.com/bug?extid=786b124fe4ce4dc99357
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-0468be89.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7feba36779de/vmlinux-0468be89.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b1cdc0506491/bzImage-0468be89.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+786b124fe4ce4dc99357@syzkaller.appspotmail.com

RBP: 00007fa0905fe120 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 000000000000000b R14: 00007fa091b9bf80 R15: 00007ffd2d08f908
 </TASK>
general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 3 PID: 7070 Comm: syz-executor.3 Not tainted 6.5.0-syzkaller-10885-g0468be89b3fa #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:strchr+0x1b/0xb0 lib/string.c:329
Code: 48 ad f7 48 8b 74 24 08 48 8b 14 24 eb 89 90 f3 0f 1e fa 48 b8 00 00 00 00 00 fc ff df 48 89 fa 55 48 c1 ea 03 53 48 83 ec 10 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 51 0f b6 07 89
RSP: 0018:ffffc90006d479e0 EFLAGS: 00010282
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc9000c2ca000
RDX: 0000000000000000 RSI: 0000000000000025 RDI: 0000000000000000
RBP: ffffc90006d47a70 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffc90006d47a70
R13: 0000000000000cc0 R14: ffff888029f072f0 R15: 0000000000000001
FS:  00007fa0905fe6c0(0000) GS:ffff88806b900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005595cf80f000 CR3: 000000010b7d5000 CR4: 0000000000350ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kvasprintf_const+0x25/0x190 lib/kasprintf.c:45
 kobject_set_name_vargs+0x5a/0x130 lib/kobject.c:272
 kobject_add_varg lib/kobject.c:366 [inline]
 kobject_add+0x12a/0x240 lib/kobject.c:424
 device_add+0x290/0x1ac0 drivers/base/core.c:3560
 cdev_device_add+0x12b/0x270 fs/char_dev.c:556
 joydev_connect+0xbdc/0x1030 drivers/input/joydev.c:1001
 input_attach_handler.isra.0+0x17c/0x250 drivers/input/input.c:1064
 input_register_device+0xb1e/0x1130 drivers/input/input.c:2396
 uinput_create_device drivers/input/misc/uinput.c:365 [inline]
 uinput_ioctl_handler.isra.0+0x1308/0x1d70 drivers/input/misc/uinput.c:904
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fa091a7cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa0905fe0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fa091b9bf80 RCX: 00007fa091a7cae9
RDX: 0000000000000000 RSI: 0000000000005501 RDI: 0000000000000003
RBP: 00007fa0905fe120 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 000000000000000b R14: 00007fa091b9bf80 R15: 00007ffd2d08f908
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:strchr+0x1b/0xb0 lib/string.c:329
Code: 48 ad f7 48 8b 74 24 08 48 8b 14 24 eb 89 90 f3 0f 1e fa 48 b8 00 00 00 00 00 fc ff df 48 89 fa 55 48 c1 ea 03 53 48 83 ec 10 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 51 0f b6 07 89
RSP: 0018:ffffc90006d479e0 EFLAGS: 00010282
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc9000c2ca000
RDX: 0000000000000000 RSI: 0000000000000025 RDI: 0000000000000000
RBP: ffffc90006d47a70 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffc90006d47a70
R13: 0000000000000cc0 R14: ffff888029f072f0 R15: 0000000000000001
FS:  00007fa0905fe6c0(0000) GS:ffff88806b900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005595cf80f000 CR3: 000000010b7d5000 CR4: 0000000000350ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 ad                	lods   %ds:(%rsi),%rax
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

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
