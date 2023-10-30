Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536A87DB64D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 10:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjJ3JpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 05:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjJ3JpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 05:45:21 -0400
Received: from mail-ot1-f77.google.com (mail-ot1-f77.google.com [209.85.210.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F71B6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 02:45:18 -0700 (PDT)
Received: by mail-ot1-f77.google.com with SMTP id 46e09a7af769-6c660a0f0e8so6276865a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 02:45:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698659118; x=1699263918;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5cUlCW+oUuA4rDUbWNaPuuksqf5bLUTo+sDRchUiF9A=;
        b=kxM9mCqjX7sgQlYUdZvbmsTwsZ/iLsn+jRe9LY+RbqNmeRH2etLjog/9Ra0n5wFK/Q
         S/h594j67gUV4cftmGvpcjmDbA+8dP4nf6BEoEFcHEpOc7umwwHVcHEN2V2ahexb1lgw
         YgKgbjEwfwlncJasf7VVAUqj+E1aG2C+PNbket8r5xmqDBPHPYsWvSXzTUGhVJJhfJMU
         qG/SkS7IehjKNioSmFUdgh7XCTHImAviX/yQVPCk1jvO3gkdTx/xhWTL39ePltivEQMw
         1/ynloAhLtkaJGb3RG1jcz87rm1e6zxRMBLdq9KXeQPSCFe7eHve6CZHeJIGd/YO9vIp
         ECXw==
X-Gm-Message-State: AOJu0Yxnu3uwKPfT4qESuLxcu+7oWBmxCr1bF4xfAAiASmRpBDOgr0TY
        DwLv7Qi+1Dbj26dYxBoqwWicNebFtDTUL2O4LTxRjNxL6LYXKEzVWw==
X-Google-Smtp-Source: AGHT+IEdMseqOuS9zkg0H9RusIfTyT1ObgEDjr8JXwZ1vvJMkcjjnU0DOOy5iIf8Kbk31bVHLn9RNCxd4ZZGpLXzFDq0NNtzh6qk
MIME-Version: 1.0
X-Received: by 2002:a05:6830:486d:b0:6c4:76b9:fe5a with SMTP id
 dx13-20020a056830486d00b006c476b9fe5amr2556790otb.5.1698659118282; Mon, 30
 Oct 2023 02:45:18 -0700 (PDT)
Date:   Mon, 30 Oct 2023 02:45:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000056ff300608ebe535@google.com>
Subject: [syzbot] [kernel?] UBSAN: shift-out-of-bounds in radix_tree_next_chunk
From:   syzbot <syzbot+976652f128ff5167eac4@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    611da07b89fd Merge tag 'acpi-6.6-rc8' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1516c4a5680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb98fe061049a6e4
dashboard link: https://syzkaller.appspot.com/bug?extid=976652f128ff5167eac4
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-611da07b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/07d6b4a56141/vmlinux-611da07b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0bd9b637a667/bzImage-611da07b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+976652f128ff5167eac4@syzkaller.appspotmail.com

================================================================================
UBSAN: shift-out-of-bounds in lib/radix-tree.c:213:30
shift exponent 72 is too large for 64-bit type 'long unsigned int'
CPU: 2 PID: 5174 Comm: syz-executor.3 Not tainted 6.6.0-rc7-syzkaller-00041-g611da07b89fd #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_shift_out_of_bounds+0x27a/0x600 lib/ubsan.c:387
 shift_maxindex lib/radix-tree.c:213 [inline]
 node_maxindex lib/radix-tree.c:218 [inline]
 radix_tree_load_root lib/radix-tree.c:397 [inline]
 radix_tree_next_chunk.cold+0x56/0x152 lib/radix-tree.c:1178
 idr_get_next_ul+0x225/0x2e0 lib/idr.c:236
 idr_get_next+0x9c/0x150 lib/idr.c:267
 zap_pid_ns_processes+0x1c0/0x690 kernel/pid_namespace.c:205
 find_child_reaper kernel/exit.c:608 [inline]
 forget_original_parent kernel/exit.c:697 [inline]
 exit_notify kernel/exit.c:734 [inline]
 do_exit+0x230d/0x2a20 kernel/exit.c:894
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1024
 __do_sys_exit_group kernel/exit.c:1035 [inline]
 __se_sys_exit_group kernel/exit.c:1033 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1033
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f3529e7cae9
Code: Unable to access opcode bytes at 0x7f3529e7cabf.
RSP: 002b:00007ffeea9062f8 EFLAGS: 000[  651.199428][ T5174] RSP: 002b:00007ffeea9062f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
==================================================================
BUG: KASAN: out-of-bounds in prb_reserve+0xdc8/0xf20 kernel/printk/printk_ringbuffer.c:1503
Write of size 8 at addr ffffc900035ff090 by task syz-executor.3/5174

CPU: 2 PID: 5174 Comm: syz-executor.3 Not tainted 6.6.0-rc7-syzkaller-00041-g611da07b89fd #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 prb_reserve+0xdc8/0xf20 kernel/printk/printk_ringbuffer.c:1503
 vprintk_store+0x49c/0xb80 kernel/printk/printk.c:2232


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
