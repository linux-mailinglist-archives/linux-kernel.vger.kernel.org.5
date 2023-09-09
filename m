Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A4C7996E8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 10:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344111AbjIIIgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 04:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236692AbjIIIgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 04:36:52 -0400
Received: from mail-pg1-f205.google.com (mail-pg1-f205.google.com [209.85.215.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B159110F9
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 01:36:47 -0700 (PDT)
Received: by mail-pg1-f205.google.com with SMTP id 41be03b00d2f7-570428954b9so3757291a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 01:36:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694248607; x=1694853407;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9DaMzJPCCqO3Sj8Zi/fs2W6mKRm6U/Kf8tVr0vb3FcY=;
        b=De/UETTOz0SdSGdZcqkn9dWJ6+zKoLqyPAIV1zXe11DunEjpTKft24wV3UUv7+ZNnR
         p33I5KtjmTNTQXLoat7Dr+uBbswcKV1Xa3eiHa6Q0/zepyc7bJgoRAqHVyv5HYk0lmuc
         WL3t32DXpUmCvrMimbdS+JR/hKQ64ZelEchY9aHMcjZSzmGk3S87I+jfJYOJ9l5MY0ee
         VXWKYOYznB8BawiJYiRMgerrRxcE9w9K6hEBrnihHuxIzaJdHGk1lzZOI4H/fnKwr8FG
         jkWnydkm7HoqgiPWlN0D26Bi7FFcgCrL02LaqXcLFcO4cPdptoDYjWevNJNUdW4Gl9lE
         bSRQ==
X-Gm-Message-State: AOJu0YzN/8P3nfexhkp/zXjyyZ2bPx+qcZVlynL8Rtsm+TjFInnn++dV
        06hXoTT4bWgeTfWSDCHtVTNQhGJCfttTFGxUelf5vrO0tcRB
X-Google-Smtp-Source: AGHT+IHvDWa6k1bW5pNkjHG2+dFjKxK96jlXp3NwM3hlkAYdVD5+FzJITBcAm6zHFDoqseaOfNfuwAGqUYGx3tJrgTJV/+2oPFlC
MIME-Version: 1.0
X-Received: by 2002:a17:903:230c:b0:1c3:5d8d:bc2f with SMTP id
 d12-20020a170903230c00b001c35d8dbc2fmr1893830plh.0.1694248607275; Sat, 09 Sep
 2023 01:36:47 -0700 (PDT)
Date:   Sat, 09 Sep 2023 01:36:47 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000065deef0604e8fe03@google.com>
Subject: [syzbot] [integrity?] [lsm?] INFO: task hung in process_measurement (2)
From:   syzbot <syzbot+1de5a37cb85a2d536330@syzkaller.appspotmail.com>
To:     dmitry.kasatkin@gmail.com, jmorris@namei.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        serge@hallyn.com, syzkaller-bugs@googlegroups.com,
        zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7ba2090ca64e Merge tag 'ceph-for-6.6-rc1' of https://githu..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14074c94680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ed626705db308b2d
dashboard link: https://syzkaller.appspot.com/bug?extid=1de5a37cb85a2d536330
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7abbf7618c3a/disk-7ba2090c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/694adc723518/vmlinux-7ba2090c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3c5d9addc4e4/bzImage-7ba2090c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1de5a37cb85a2d536330@syzkaller.appspotmail.com

INFO: task syz-executor.0:8008 blocked for more than 143 seconds.
      Not tainted 6.5.0-syzkaller-12107-g7ba2090ca64e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:27472 pid:8008  ppid:5056   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x1873/0x48f0 kernel/sched/core.c:6695
 schedule+0xc3/0x180 kernel/sched/core.c:6771
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6830
 rwsem_down_write_slowpath+0xedd/0x13a0 kernel/locking/rwsem.c:1178
 __down_write_common+0x1aa/0x200 kernel/locking/rwsem.c:1306
 inode_lock include/linux/fs.h:802 [inline]
 process_measurement+0x43b/0x1cf0 security/integrity/ima/ima_main.c:247
 ima_file_check+0xf1/0x170 security/integrity/ima/ima_main.c:543
 do_open fs/namei.c:3641 [inline]
 path_openat+0x2812/0x3180 fs/namei.c:3796
 do_filp_open+0x234/0x490 fs/namei.c:3823
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1422
 do_sys_open fs/open.c:1437 [inline]
 __do_sys_creat fs/open.c:1513 [inline]
 __se_sys_creat fs/open.c:1507 [inline]
 __x64_sys_creat+0x123/0x160 fs/open.c:1507
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fb7faa7cae9
RSP: 002b:00007fb7fb88a0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007fb7fab9c050 RCX: 00007fb7faa7cae9
RDX: 0000000000000000 RSI: 00000000000001f2 RDI: 0000000020000280
RBP: 00007fb7faac847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007fb7fab9c050 R15: 00007ffebde5d0b8
 </TASK>
INFO: lockdep is turned off.
NMI backtrace for cpu 1
CPU: 1 PID: 29 Comm: khungtaskd Not tainted 6.5.0-syzkaller-12107-g7ba2090ca64e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x498/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x310 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xdf5/0xe40 kernel/hung_task.c:379
 kthread+0x2b8/0x350 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 8771 Comm: syz-executor.0 Not tainted 6.5.0-syzkaller-12107-g7ba2090ca64e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:__asan_memset+0x31/0x40 mm/kasan/shadow.c:87
Code: 53 48 89 d3 41 89 f6 48 89 fd 48 8b 4c 24 18 48 89 d6 ba 01 00 00 00 e8 6d ea ff ff 84 c0 74 12 48 89 ef 44 89 f6 48 89 da 5b <41> 5e 5d e9 87 02 e2 08 31 c0 5b 41 5e 5d c3 f3 0f 1e fa 41 57 41
RSP: 0018:ffffc90016796d50 EFLAGS: 00000202
RAX: ffffc90016797501 RBX: ffffc90016796e78 RCX: ffffffff813d953c
RDX: 0000000000000010 RSI: 0000000000000000 RDI: ffffc90016796e90
RBP: ffffc90016796e90 R08: ffffc90016796e9f R09: 1ffff92002cf2dd3
R10: dffffc0000000000 R11: fffff52002cf2dd4 R12: ffffc90016797530
R13: dffffc0000000000 R14: 0000000000000000 R15: 1ffff92002cf2dc8
FS:  00007f87258b56c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f306edfe000 CR3: 0000000063639000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 unwind_next_frame+0x13ac/0x29e0 arch/x86/kernel/unwind_orc.c:592
 arch_stack_walk+0x146/0x1a0 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x117/0x1c0 kernel/stacktrace.c:122
 save_stack+0xfa/0x1e0 mm/page_owner.c:128
 __set_page_owner+0x29/0x380 mm/page_owner.c:192
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1536
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0x31db/0x3360 mm/page_alloc.c:3170
 __alloc_pages+0x255/0x670 mm/page_alloc.c:4426
 __folio_alloc+0x13/0x30 mm/page_alloc.c:4458
 vma_alloc_folio+0x48a/0x9a0 mm/mempolicy.c:2259
 shmem_alloc_folio mm/shmem.c:1658 [inline]
 shmem_alloc_and_acct_folio+0x438/0x9b0 mm/shmem.c:1683
 shmem_get_folio_gfp+0xca4/0x2b60 mm/shmem.c:2020
 shmem_get_folio mm/shmem.c:2143 [inline]
 shmem_write_begin+0x170/0x300 mm/shmem.c:2688
 generic_perform_write+0x31b/0x630 mm/filemap.c:3942
 shmem_file_write_iter+0xfc/0x120 mm/shmem.c:2865
 call_write_iter include/linux/fs.h:1985 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x782/0xaf0 fs/read_write.c:584
 ksys_write+0x1a0/0x2c0 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f8724a7b82f
Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 b9 80 02 00 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 0c 81 02 00 48
RSP: 002b:00007f87258b4e70 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000001000000 RCX: 00007f8724a7b82f
RDX: 0000000001000000 RSI: 00007f871b1ff000 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000012605
R10: 0000000020024d42 R11: 0000000000000293 R12: 0000000000000003
R13: 00007f87258b4f3c R14: 00007f87258b4f40 R15: 00007f871b1ff000
 </TASK>


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
