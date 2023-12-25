Return-Path: <linux-kernel+bounces-10927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBEE81DEC9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 08:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BB85B2101F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 07:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF1115BB;
	Mon, 25 Dec 2023 07:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNcfRVN4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB601116
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 07:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-28bd734aab4so2893172a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 23:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703488627; x=1704093427; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rrdkEvcD7jRMTYlJ9EeoZ1gCAabfUyvBPjgoB+Gbjk0=;
        b=ZNcfRVN4Z/jQgPwszA7NAH5orzYC3QBavh5Bsgy0cZPUwnEhB5qHHN3R6mVSkWRSAF
         /b7/v9ElUE9JjcirOihOShVkupGY+gHzFQBCbztNaEZSDGCTL4SmPtgdsvGHPw0w0QEA
         pI13Rc4Nd7IhO0aUgjULWLn+bR2hzoldoGR1P7iG2EStgTWlIsnj0XYyg7fhXHHAQXG6
         VSmkTv1ocgnlKK8JBv/pL23AjzrE5op2zumWOD3uVOOuaLHW/b/+xvaAFJdbATTk4pSc
         qVPPnqNahMAx9nM8Y5q+BuyxsFcPUqS8H3Fno+gbrMppg98gQZ6LfyRVmaODF8XyZXHs
         AOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703488627; x=1704093427;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rrdkEvcD7jRMTYlJ9EeoZ1gCAabfUyvBPjgoB+Gbjk0=;
        b=QoiSVTi70rQInZziX8hARwRJrUMqixDWvR3rD9LGKLiU5SvacSjXBifFCF69nf7Woc
         8XMq5JF8dOlNu2PhT5FVXsqMNvjTKwUQlfb7bFaw1ZxONJk1qXu7FYteiYM2SOk1xijp
         VsKY0mrQdXzhSdcw70hjVZQsTLzWePgXNc1mwTr215P4c2zMccSzmSvxoWVGE+eMaRke
         DnV5sO2Z5WByEvi+MUT9OE39+ZEUHzTsyW1rOf1Z9A6cd4aoOOqNJOTIwvQO7GApvnVj
         JCFtmSrUn7QWVHPqg3phsICcag68LiXXYElMNMDb2fJoB9D5n6KbkcNWX8DqEZvd6hqo
         tFHA==
X-Gm-Message-State: AOJu0Yx4lkFlfsJzAgdn26ItdU6XxgO/D0rYwVbytvGg0ldyZE1s/gIs
	bKaMxiFe2epbHr3fURX/RDv7R5eUaFdrITd3yTqlYQK/Cqo=
X-Google-Smtp-Source: AGHT+IE8FvV41HULVK1KJT31DybT+QEyUI00657adTisMHdXdSOnec2jiAOiT7xKLEKZQb0uUMbO8WCJ/kZAS77ufzU=
X-Received: by 2002:a17:90b:3c0f:b0:28c:2b59:2dc1 with SMTP id
 pb15-20020a17090b3c0f00b0028c2b592dc1mr1087179pjb.24.1703488627459; Sun, 24
 Dec 2023 23:17:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: xingwei lee <xrivendell7@gmail.com>
Date: Mon, 25 Dec 2023 15:16:57 +0800
Message-ID: <CABOYnLyiKHGJA84eAXOnPGguNcEj1MGvPuKsqP70kqzwjDiyRQ@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] KMSAN: kernel-infoleak-after-free in
 copy_siginfo_to_user (2)
To: syzbot+cfc08744435c4cf94a40@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org, luto@kernel.org, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Hello, I reproduced this bug and comfired in the latest net tree.

If you fix this issue, please add the following tag to the commit:
Reported-by: xingwei lee <xrivendell7@gmail.com>

kernel version: net 7c5e046bdcb2513f9decb3765d8bf92d604279cf
kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=4a65fa9f077ead01
with KMSAN enabled
compiler: Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

syzkaller login: root
Linux syzkaller 6.7.0-rc6-00157-g7c5e046bdcb2 #9 SMP PREEMPT_DYNAMIC
Sat Dec 23 16:03:42 CST 2023 x86_64
The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.
Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
Last login: Mon Dec 25 01:57:49 UTC 2023 on ttyS0

root@syzkaller:~/linux_amd64# ./syz-execprog -repeat 0 ../f64.txt
BUG: KMSAN: kernel-infoleak-after-free in instrument_copy_to_user
include/linux/instrumented.h:114 [inline]
BUG: KMSAN: kernel-infoleak-after-free in _copy_to_user+0xbf/0x110
lib/usercopy.c:40
instrument_copy_to_user include/linux/instrumented.h:114 [inline]
_copy_to_user+0xbf/0x110 lib/usercopy.c:40
copy_to_user include/linux/uaccess.h:191 [inline]
copy_siginfo_to_user+0x40/0x120 kernel/signal.c:3374
x64_setup_rt_frame+0x1e4b/0x2400 arch/x86/kernel/signal_64.c:194
setup_rt_frame arch/x86/kernel/signal.c:222 [inline]
handle_signal arch/x86/kernel/signal.c:266 [inline]
arch_do_signal_or_restart+0x616/0xc90 arch/x86/kernel/signal.c:311
exit_to_user_mode_loop+0xe8/0x320 kernel/entry/common.c:168
exit_to_user_mode_prepare+0x167/0x220 kernel/entry/common.c:204
__syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
syscall_exit_to_user_mode+0x2b/0x150 kernel/entry/common.c:296
do_syscall_64+0x50/0x110 arch/x86/entry/common.c:89
entry_SYSCALL_64_after_hwframe+0x63/0x6b
Uninit was stored to memory at:
copy_siginfo include/linux/signal.h:17 [inline]
collect_signal kernel/signal.c:596 [inline]
__dequeue_signal+0x52e/0x9f0 kernel/signal.c:625
dequeue_signal+0x15a/0xb40 kernel/signal.c:648
get_signal+0xbd0/0x2c50 kernel/signal.c:2784
arch_do_signal_or_restart+0x53/0xc90 arch/x86/kernel/signal.c:309
exit_to_user_mode_loop+0xe8/0x320 kernel/entry/common.c:168
exit_to_user_mode_prepare+0x167/0x220 kernel/entry/common.c:204
__syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
syscall_exit_to_user_mode+0x2b/0x150 kernel/entry/common.c:296
do_syscall_64+0x50/0x110 arch/x86/entry/common.c:89
entry_SYSCALL_64_after_hwframe+0x63/0x6b
Uninit was created at:
slab_free_hook mm/slub.c:1770 [inline]
slab_free_freelist_hook mm/slub.c:1826 [inline]
slab_free mm/slub.c:3809 [inline]
kmem_cache_free+0x63b/0x1270 mm/slub.c:3831
__sigqueue_free kernel/signal.c:460 [inline]
collect_signal kernel/signal.c:603 [inline]
__dequeue_signal+0x8e7/0x9f0 kernel/signal.c:625
dequeue_signal+0x15a/0xb40 kernel/signal.c:648
get_signal+0xbd0/0x2c50 kernel/signal.c:2784
arch_do_signal_or_restart+0x53/0xc90 arch/x86/kernel/signal.c:309
exit_to_user_mode_loop+0xe8/0x320 kernel/entry/common.c:168
exit_to_user_mode_prepare+0x167/0x220 kernel/entry/common.c:204
__syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
syscall_exit_to_user_mode+0x2b/0x150 kernel/entry/common.c:296
do_syscall_64+0x50/0x110 arch/x86/entry/common.c:89
entry_SYSCALL_64_after_hwframe+0x63/0x6b
Bytes 12-15 of 48 are uninitialized
Memory access of size 48 starts at ffff888038b73dc0
Data copied to user address 000000c0013875b0
CPU: 3 PID: 8170 Comm: syz-execprog Not tainted 6.7.0-rc6-00157-g7c5e046bdcb2 #9
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.16.2-1.fc38 04/01/2014
=====================================================
instrument_copy_to_user include/linux/instrumented.h:114 [inline]
_copy_to_user+0xbf/0x110 lib/usercopy.c:40
copy_to_user include/linux/uaccess.h:191 [inline]
copy_siginfo_to_user+0x40/0x120 kernel/signal.c:3374
x64_setup_rt_frame+0x1e4b/0x2400 arch/x86/kernel/signal_64.c:194
setup_rt_frame arch/x86/kernel/signal.c:222 [inline]
handle_signal arch/x86/kernel/signal.c:266 [inline]
arch_do_signal_or_restart+0x616/0xc90 arch/x86/kernel/signal.c:311
exit_to_user_mode_loop+0xe8/0x320 kernel/entry/common.c:168
exit_to_user_mode_prepare+0x167/0x220 kernel/entry/common.c:204
__syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
syscall_exit_to_user_mode+0x2b/0x150 kernel/entry/common.c:296
do_syscall_64+0x50/0x110 arch/x86/entry/common.c:89
entry_SYSCALL_64_after_hwframe+0x63/0x6b
Uninit was stored to memory at:
copy_siginfo include/linux/signal.h:17 [inline]
collect_signal kernel/signal.c:596 [inline]
__dequeue_signal+0x52e/0x9f0 kernel/signal.c:625
dequeue_signal+0x15a/0xb40 kernel/signal.c:648
get_signal+0xbd0/0x2c50 kernel/signal.c:2784
arch_do_signal_or_restart+0x53/0xc90 arch/x86/kernel/signal.c:309
exit_to_user_mode_loop+0xe8/0x320 kernel/entry/common.c:168
exit_to_user_mode_prepare+0x167/0x220 kernel/entry/common.c:204
__syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
syscall_exit_to_user_mode+0x2b/0x150 kernel/entry/common.c:296
do_syscall_64+0x50/0x110 arch/x86/entry/common.c:89
entry_SYSCALL_64_after_hwframe+0x63/0x6b
Uninit was created at:
slab_free_hook mm/slub.c:1770 [inline]
slab_free_freelist_hook mm/slub.c:1826 [inline]
slab_free mm/slub.c:3809 [inline]
kmem_cache_free+0x63b/0x1270 mm/slub.c:3831
__sigqueue_free kernel/signal.c:460 [inline]
collect_signal kernel/signal.c:603 [inline]
__dequeue_signal+0x8e7/0x9f0 kernel/signal.c:625
dequeue_signal+0x15a/0xb40 kernel/signal.c:648
get_signal+0xbd0/0x2c50 kernel/signal.c:2784
arch_do_signal_or_restart+0x53/0xc90 arch/x86/kernel/signal.c:309
exit_to_user_mode_loop+0xe8/0x320 kernel/entry/common.c:168
exit_to_user_mode_prepare+0x167/0x220 kernel/entry/common.c:204
__syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
syscall_exit_to_user_mode+0x2b/0x150 kernel/entry/common.c:296
do_syscall_64+0x50/0x110 arch/x86/entry/common.c:89
entry_SYSCALL_64_after_hwframe+0x63/0x6b
Bytes 12-15 of 48 are uninitialized
Memory access of size 48 starts at ffff888038b73dc0
Data copied to user address 000000c0013875b0
CPU: 3 PID: 8170 Comm: syz-execprog Not tainted 6.7.0-rc6-00157-g7c5e046bdcb2 #9
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.16.2-1.fc38 04/01/2014
=====================================================
Disabling lock debugging due to kernel taint
Kernel panic - not syncing: kmsan.panic set ...
CPU: 3 PID: 8170 Comm: syz-execprog Tainted: G B
6.7.0-rc6-00157-g7c5e046bdcb2 #9
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.16.2-1.fc38 04/01/2014
Call Trace:
<TASK>
__dump_stack lib/dump_stack.c:88 [inline]
dump_stack_lvl+0x1af/0x230 lib/dump_stack.c:106
dump_stack+0x1e/0x20 lib/dump_stack.c:113
panic+0x4d6/0xc60 kernel/panic.c:344
kmsan_report+0x2d7/0x2e0 mm/kmsan/report.c:216
kmsan_internal_check_memory+0x1ad/0x530 mm/kmsan/core.c:291
kmsan_copy_to_user+0xd3/0xf0 mm/kmsan/hooks.c:272
instrument_copy_to_user include/linux/instrumented.h:114 [inline]
_copy_to_user+0xbf/0x110 lib/usercopy.c:40
copy_to_user include/linux/uaccess.h:191 [inline]
copy_siginfo_to_user+0x40/0x120 kernel/signal.c:3374
x64_setup_rt_frame+0x1e4b/0x2400 arch/x86/kernel/signal_64.c:194
setup_rt_frame arch/x86/kernel/signal.c:222 [inline]
handle_signal arch/x86/kernel/signal.c:266 [inline]
arch_do_signal_or_restart+0x616/0xc90 arch/x86/kernel/signal.c:311
exit_to_user_mode_loop+0xe8/0x320 kernel/entry/common.c:168
exit_to_user_mode_prepare+0x167/0x220 kernel/entry/common.c:204
__syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
syscall_exit_to_user_mode+0x2b/0x150 kernel/entry/common.c:296
do_syscall_64+0x50/0x110 arch/x86/entry/common.c:89
entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x46b981
Code: 89 44 24 20 c3 cc cc cc cc 48 8b 7c 24 08 8b 74 24 10 8b 54 24
14 4c 8b 54 24 18 4c 8b 44 24 2c
RSP: 002b:000000c00129def0 EFLAGS: 00000286
RAX: 00000000000000ca RBX: 0000000000000000 RCX: 000000000046b983
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 0000000002030b58
RBP: 000000c00129df38 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000286 R12: 00000000004678e0
R13: 000000c00126e800 R14: 000000c00127e340 R15: 0000000000000001

Remember to run this repro.txt with the command: syz-execprog -repeat
0 ./repro.txt and wait for about 3-4minus, the bug triggered very
steady.

=* repro.txt =*
socket$inet_udplite(0x2, 0x2, 0x88)
socket$inet_udplite(0x2, 0x2, 0x88)
socket(0x10, 0x80002, 0x0)
r0 = bpf$BPF_PROG_RAW_TRACEPOINT_LOAD(0x5, &(0x7f0000000200)={0x18,
0x4, &(0x7f00000002c0)=ANY=[@ANYBLOB="180100001c00000000000000120000f1850000006d00000095"],
&(0x7f0000000000)='GPL\x00', 0x0, 0x0, 0x0, 0x0, 0x0, '\x00', 0x0,
0x2}, 0x90)
bpf$BPF_RAW_TRACEPOINT_OPEN(0x11,
&(0x7f0000001700)={&(0x7f0000001740)='hrtimer_expire_entry\x00', r0},
0x10)


and see also in
https://gist.github.com/xrivendell7/921e9e3bb7a4d2b8b291c0612781ce4d

I hope it helps.
Merry Christmas!
xingwei Lee

