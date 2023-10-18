Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230E87CE7B7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 21:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjJRT3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 15:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjJRT3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 15:29:50 -0400
Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com [209.85.160.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F001B118
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 12:29:47 -0700 (PDT)
Received: by mail-oa1-f78.google.com with SMTP id 586e51a60fabf-1e9d9455085so8357023fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 12:29:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697657387; x=1698262187;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cxfq6wmnLMiB4JBOgxz9GR9Ys4DwzgSQYdYJl6M89qg=;
        b=A8i7OCSX7B/v5Wap/MTkCP01Gz1v7F5Bd/rEe6tkMDmPHy0ag0qW31N2L+fv3YxGkT
         FEzae87goFBm3hLnc8nSDOI95AgpXO298/jS97QO6YFrPJaiSHfBiqnz6tlQa7e0QL5u
         x7bHzGUA86PQwD7LoKCLgWyu2vOh5fpsVB6E7UobLXsGVvt9JKokVRxFU/O7CGVCehpB
         xydgowaHJ6/pFeJR/zmlPmJHgwe5bwjwel3IB14MxLEZRP7que5FhzhnFvTpdIeJUm79
         6OVXaW7UEl03vA4BQ91YRAmdzqLT3qT4pTMAuz84yWBVvcevCU0fotRIgOh39xsIy8Q/
         4eBA==
X-Gm-Message-State: AOJu0YxhxRuN/ir2ufsSlVpvK3rFGUj47EQh0EKtroFMA9rwORNdkvlz
        oBOnunQiO3cl6WRpghr5j8SuaO1JpqNx4XTC5edpsxR3+ynB
X-Google-Smtp-Source: AGHT+IFTTXumSim65r//KELC0c/avMIwNGSPCrFLyoHbmmjrD4D+licdYo+C/pZOpFUySdMySUlEdzAMh1nxxmyRO6xX1B7SXIxT
MIME-Version: 1.0
X-Received: by 2002:a05:6870:d60b:b0:1e9:8e86:e661 with SMTP id
 a11-20020a056870d60b00b001e98e86e661mr141979oaq.8.1697657387310; Wed, 18 Oct
 2023 12:29:47 -0700 (PDT)
Date:   Wed, 18 Oct 2023 12:29:47 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000085670f060802a9bd@google.com>
Subject: [syzbot] [mm?] [fs?] general protection fault in folio_flags
From:   syzbot <syzbot+1e2648076cadf48ad9a1@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
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

HEAD commit:    2dac75696c6d Add linux-next specific files for 20231018
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13858275680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6f8545e1ef7a2b66
dashboard link: https://syzkaller.appspot.com/bug?extid=1e2648076cadf48ad9a1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17543ee5680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=101f5fe5680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2375f16ed327/disk-2dac7569.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c80aee6e2e6c/vmlinux-2dac7569.xz
kernel image: https://storage.googleapis.com/syzbot-assets/664dc23b738d/bzImage-2dac7569.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1e2648076cadf48ad9a1@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 PID: 5710 Comm: syz-executor155 Not tainted 6.6.0-rc6-next-20231018-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
RIP: 0010:PageTail include/linux/page-flags.h:286 [inline]
RIP: 0010:folio_flags.constprop.0+0x21/0x150 include/linux/page-flags.h:313
Code: 84 00 00 00 00 00 0f 1f 00 41 54 55 53 48 89 fb e8 14 2f a4 ff 48 8d 7b 08 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 00 01 00 00 48 8b 6b 08 31 ff 83 e5 01 48 89 ee
RSP: 0018:ffffc90004367968 EFLAGS: 00010247
RAX: dffffc0000000000 RBX: fffffffffffffffe RCX: ffffffff81b7e126
RDX: 0000000000000000 RSI: ffffffff81e49d1c RDI: 0000000000000006
RBP: 0000000020200000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 1ffffffff1976fb9 R12: ffff88801675b900
R13: ffff888025f9f680 R14: fffffffffffffffe R15: 1ffff9200086cf3d
FS:  00007f2f2a17c6c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2f2a17cd58 CR3: 000000001bfa0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 folio_test_head include/linux/page-flags.h:790 [inline]
 folio_test_large include/linux/page-flags.h:811 [inline]
 folio_order include/linux/mm.h:1079 [inline]
 collapse_pte_mapped_thp+0x42d/0x13b0 mm/khugepaged.c:1512
 madvise_collapse+0x875/0xaf0 mm/khugepaged.c:2761
 madvise_vma_behavior+0x1fe/0x1d00 mm/madvise.c:1086
 madvise_walk_vmas+0x1cf/0x2c0 mm/madvise.c:1260
 do_madvise+0x333/0x660 mm/madvise.c:1440
 __do_sys_madvise mm/madvise.c:1453 [inline]
 __se_sys_madvise mm/madvise.c:1451 [inline]
 __x64_sys_madvise+0xaa/0x110 mm/madvise.c:1451
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f2f2a1dc7a9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 01 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2f2a17c238 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
RAX: ffffffffffffffda RBX: 00007f2f2a266318 RCX: 00007f2f2a1dc7a9
RDX: 0000000000000019 RSI: 000000000060005f RDI: 0000000020000000
RBP: 00007f2f2a266310 R08: 00007ffe616d77f7 R09: 00007f2f2a17c6c0
R10: 0000000000000000 R11: 0000000000000246 R12: b635773f07ebbeef
R13: 000000000000006e R14: 00007ffe616d7710 R15: 00007ffe616d77f8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:PageTail include/linux/page-flags.h:286 [inline]
RIP: 0010:folio_flags.constprop.0+0x21/0x150 include/linux/page-flags.h:313
Code: 84 00 00 00 00 00 0f 1f 00 41 54 55 53 48 89 fb e8 14 2f a4 ff 48 8d 7b 08 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 00 01 00 00 48 8b 6b 08 31 ff 83 e5 01 48 89 ee
RSP: 0018:ffffc90004367968 EFLAGS: 00010247
RAX: dffffc0000000000 RBX: fffffffffffffffe RCX: ffffffff81b7e126
RDX: 0000000000000000 RSI: ffffffff81e49d1c RDI: 0000000000000006
RBP: 0000000020200000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 1ffffffff1976fb9 R12: ffff88801675b900
R13: ffff888025f9f680 R14: fffffffffffffffe R15: 1ffff9200086cf3d
FS:  00007f2f2a17c6c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2f2a17cd58 CR3: 000000001bfa0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	84 00                	test   %al,(%rax)
   2:	00 00                	add    %al,(%rax)
   4:	00 00                	add    %al,(%rax)
   6:	0f 1f 00             	nopl   (%rax)
   9:	41 54                	push   %r12
   b:	55                   	push   %rbp
   c:	53                   	push   %rbx
   d:	48 89 fb             	mov    %rdi,%rbx
  10:	e8 14 2f a4 ff       	call   0xffa42f29
  15:	48 8d 7b 08          	lea    0x8(%rbx),%rdi
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 00 01 00 00    	jne    0x134
  34:	48 8b 6b 08          	mov    0x8(%rbx),%rbp
  38:	31 ff                	xor    %edi,%edi
  3a:	83 e5 01             	and    $0x1,%ebp
  3d:	48 89 ee             	mov    %rbp,%rsi


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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
