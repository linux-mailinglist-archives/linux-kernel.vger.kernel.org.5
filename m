Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4B37D3D72
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjJWRYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjJWRYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:24:51 -0400
Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com [209.85.210.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A9CA2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:24:49 -0700 (PDT)
Received: by mail-ot1-f80.google.com with SMTP id 46e09a7af769-6cf61d80fafso1191629a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:24:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698081888; x=1698686688;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dsLqKH9JCxLrEaZWl5kI+Sf/LVnZmpsmAw2gKYYRk2c=;
        b=C2l/EhIQCMDmag4Z7KSvSzsP5ZSONdbDzoHOrwEITerofIXJT3fx8TLNVWrPJnGuDk
         pdhOppOB5GvqzIwaHCnPmD5C5tV9Ycfbc3xHq/T9cNmxHw1sdUnPCXEFupnHMQC/ntiU
         D6YCHwWyHGtL4oSaG63OetUzPhesErslpcp3m77JLXZ1K/OpduqHxreC2frte3VZcH0h
         1dw7y2YO/h5WKSFNM7JTFX74rHi+d4Q4Pi4RSHMpXzL/vg76Q+VjZN+2jymIRuLDM9ru
         ruI5ZAlejWedvP3cIcLiYZBls7ingLcs7fJoHkiK8KUvEq2BasPjB+G5AouwU69i5qc/
         r0uA==
X-Gm-Message-State: AOJu0YwxuKe4Ou8yMiI+z4HVbMpiwFkDvxw5xYX4fOcO9zEXmI8cCGpu
        w+m1USHeCeQyQp7p8LIaZMacY0TyUE1osLpyZckg5jspSVAm
X-Google-Smtp-Source: AGHT+IEJNU/PwRLWHGOPmUPObo8hgCgSIzUJJfWcgmXQ0v0QmOJAFoi588CPia1DKIoo5wKNJ8kIvcJXhMT99r+RGN8A+DWfSm2h
MIME-Version: 1.0
X-Received: by 2002:a05:6870:a446:b0:1e9:9b32:3e56 with SMTP id
 n6-20020a056870a44600b001e99b323e56mr4798162oal.7.1698081888294; Mon, 23 Oct
 2023 10:24:48 -0700 (PDT)
Date:   Mon, 23 Oct 2023 10:24:48 -0700
In-Reply-To: <000000000000985ef90607610b0a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c05f1b0608657fde@google.com>
Subject: Re: [syzbot] [mm?] WARNING: suspicious RCU usage in mas_walk (3)
From:   syzbot <syzbot+79fcba037b6df73756d3@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, postmaster@duagon.onmicrosoft.com,
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    e8361b005d7c Add linux-next specific files for 20231023
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1207cb05680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=75e8fc3570ec9a74
dashboard link: https://syzkaller.appspot.com/bug?extid=79fcba037b6df73756d3
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=107fab89680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e28a7944599e/disk-e8361b00.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7dd355dbe055/vmlinux-e8361b00.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7b2a9050635d/bzImage-e8361b00.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+79fcba037b6df73756d3@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
6.6.0-rc6-next-20231023-syzkaller #0 Not tainted
-----------------------------
lib/maple_tree.c:856 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
no locks held by syz-executor.4/5222.

stack backtrace:
CPU: 0 PID: 5222 Comm: syz-executor.4 Not tainted 6.6.0-rc6-next-20231023-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
 lockdep_rcu_suspicious+0x20b/0x3a0 kernel/locking/lockdep.c:6711
 mas_root lib/maple_tree.c:856 [inline]
 mas_root lib/maple_tree.c:854 [inline]
 mas_start lib/maple_tree.c:1385 [inline]
 mas_state_walk lib/maple_tree.c:3705 [inline]
 mas_walk+0x4d1/0x7d0 lib/maple_tree.c:4888
 mas_find_setup lib/maple_tree.c:5948 [inline]
 mas_find+0x1e6/0x400 lib/maple_tree.c:5989
 vma_find include/linux/mm.h:952 [inline]
 do_mbind+0xc8f/0x1010 mm/mempolicy.c:1328
 kernel_mbind+0x1d4/0x1f0 mm/mempolicy.c:1486
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x62/0x6a
RIP: 0033:0x7f9979c7cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9978ffe0c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ed
RAX: ffffffffffffffda RBX: 00007f9979d9c050 RCX: 00007f9979c7cae9
RDX: 0000000000000003 RSI: 0000000000005000 RDI: 0000000020182000
RBP: 00007f9979cc847a R08: 000000000000007f R09: 0000000000000003
R10: 0000000020000040 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f9979d9c050 R15: 00007ffdbdd465f8
 </TASK>

=============================
WARNING: suspicious RCU usage
6.6.0-rc6-next-20231023-syzkaller #0 Not tainted
-----------------------------
lib/maple_tree.c:812 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
no locks held by syz-executor.4/5222.

stack backtrace:
CPU: 0 PID: 5222 Comm: syz-executor.4 Not tainted 6.6.0-rc6-next-20231023-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
 lockdep_rcu_suspicious+0x20b/0x3a0 kernel/locking/lockdep.c:6711
 mt_slot lib/maple_tree.c:812 [inline]
 mt_slot lib/maple_tree.c:809 [inline]
 mtree_range_walk+0x6c5/0x9b0 lib/maple_tree.c:2827
 mas_state_walk lib/maple_tree.c:3712 [inline]
 mas_walk+0x374/0x7d0 lib/maple_tree.c:4888
 mas_find_setup lib/maple_tree.c:5948 [inline]
 mas_find+0x1e6/0x400 lib/maple_tree.c:5989
 vma_find include/linux/mm.h:952 [inline]
 do_mbind+0xc8f/0x1010 mm/mempolicy.c:1328
 kernel_mbind+0x1d4/0x1f0 mm/mempolicy.c:1486
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x62/0x6a
RIP: 0033:0x7f9979c7cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9978ffe0c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ed
RAX: ffffffffffffffda RBX: 00007f9979d9c050 RCX: 00007f9979c7cae9
RDX: 0000000000000003 RSI: 0000000000005000 RDI: 0000000020182000
RBP: 00007f9979cc847a R08: 000000000000007f R09: 0000000000000003
R10: 0000000020000040 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f9979d9c050 R15: 00007ffdbdd465f8
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
