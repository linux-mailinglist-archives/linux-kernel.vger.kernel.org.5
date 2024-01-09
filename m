Return-Path: <linux-kernel+bounces-21237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F3C828C60
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A5641F2750D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03AF3D0DA;
	Tue,  9 Jan 2024 18:18:38 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BBD3C467
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 18:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3607ddfac7eso32878285ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 10:18:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704824313; x=1705429113;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IVNBp7CVtVvMwR9d9eUcDyeR5cBx4C5s7uDtehl7VXQ=;
        b=CvzbVnjb1QMTxaTH1qAx1BV28JMPDdTI7G1KVskTxBJTzH85Io8FBiaf8P8SZ9kRoZ
         Wzqs5lrBSOp4Xkxe0vUa7+0PeDq0c1tazPQqkdpvJ78EwZcXOx/m36S/StrZN4Rm02Og
         Q3rSZkvlBBwz8/N9aVZSrfxhD/aGOAHcK/ynuc9Pk5v7Wxzg6yRqRvt2jHcFwMSg3CwY
         d3r/5RHODvV0T/fj6X1FHNuJZs1fyESuYkFDlZQ612MYTjDMEYFTfIR0f9kSmJmILLmQ
         0A6Abt7Wt1UZbrojfstvTkHb4KXibwF/+yfXqlwwV38696hwDztRjx1hFW0bI4lSei16
         S9WA==
X-Gm-Message-State: AOJu0Yw7yCNDcRYLtivzUUo4UoWvBAy1i2/+ABVxaRQkWdxpTsaIs0LT
	7GdMKGmUzXRZeKLDYf7gTSanvYiNfeQyZyOm3qvWXncB5C/2yDs=
X-Google-Smtp-Source: AGHT+IEmP5XmvzvG/JAbcfIVit5KZw6ZMUc2VUth8UXDlFwEm0Vrv68qTho+3W6sd5rTSH/PDB0QUlRqUKBQJY4Rj8YezbNum3K4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b46:b0:35f:535a:9c64 with SMTP id
 f6-20020a056e020b4600b0035f535a9c64mr734842ilu.3.1704824313725; Tue, 09 Jan
 2024 10:18:33 -0800 (PST)
Date: Tue, 09 Jan 2024 10:18:33 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009fcc26060e8757ad@google.com>
Subject: [syzbot] [modules?] INFO: task hung in _vm_unmap_aliases (3)
From: syzbot <syzbot+fe8f8efd070d727de971@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	mcgrof@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    610a9b8f49fb Linux 6.7-rc8
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=137c4981e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c1d9baf5d2241e14
dashboard link: https://syzkaller.appspot.com/bug?extid=fe8f8efd070d727de971
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d5c931e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14e4e3d9e80000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/8ead8862021c/non_bootable_disk-610a9b8f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5dcc5fecebbd/vmlinux-610a9b8f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ac6cb620d377/zImage-610a9b8f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fe8f8efd070d727de971@syzkaller.appspotmail.com

INFO: task kworker/0:1:9 blocked for more than 450 seconds.
      Not tainted 6.7.0-rc8-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:1     state:D stack:0     pid:9     tgid:9     ppid:2      flags:0x00000000
Workqueue: events bpf_prog_free_deferred
Backtrace: 
[<81855408>] (__schedule) from [<81856028>] (__schedule_loop kernel/sched/core.c:6763 [inline])
[<81855408>] (__schedule) from [<81856028>] (schedule+0x2c/0xb8 kernel/sched/core.c:6778)
 r10:82c16005 r9:00000000 r8:8270dad4 r7:00000002 r6:df83dda4 r5:82dee000
 r4:82dee000
[<81855ffc>] (schedule) from [<818565d0>] (schedule_preempt_disabled+0x18/0x24 kernel/sched/core.c:6835)
 r5:82dee000 r4:8270dad0
[<818565b8>] (schedule_preempt_disabled) from [<81858eb8>] (__mutex_lock_common kernel/locking/mutex.c:679 [inline])
[<818565b8>] (schedule_preempt_disabled) from [<81858eb8>] (__mutex_lock.constprop.0+0x2e8/0xae0 kernel/locking/mutex.c:747)
[<81858bd0>] (__mutex_lock.constprop.0) from [<81859784>] (__mutex_lock_slowpath+0x14/0x18 kernel/locking/mutex.c:1035)
 r10:82c16005 r9:df83de30 r8:00000000 r7:ffffffff r6:00000000 r5:84791b40
 r4:00000000
[<81859770>] (__mutex_lock_slowpath) from [<818597c4>] (mutex_lock+0x3c/0x40 kernel/locking/mutex.c:286)
[<81859788>] (mutex_lock) from [<804898b0>] (_vm_unmap_aliases+0x60/0x2e4 mm/vmalloc.c:2267)
[<80489850>] (_vm_unmap_aliases) from [<8048d450>] (vm_reset_perms mm/vmalloc.c:2753 [inline])
[<80489850>] (_vm_unmap_aliases) from [<8048d450>] (vfree+0x170/0x1e0 mm/vmalloc.c:2832)
 r10:82c16005 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:84791b40
 r4:00000000
[<8048d2e0>] (vfree) from [<802e9a2c>] (module_memfree+0x30/0x50 kernel/module/main.c:1189)
 r9:847f7400 r8:00000000 r7:00000000 r6:82c16000 r5:00001000 r4:7f077000
[<802e99fc>] (module_memfree) from [<80386f54>] (bpf_jit_free_exec+0x10/0x14 kernel/bpf/core.c:1023)
 r5:00001000 r4:ea91f000
[<80386f44>] (bpf_jit_free_exec) from [<80387114>] (bpf_jit_binary_free kernel/bpf/core.c:1069 [inline])
[<80386f44>] (bpf_jit_free_exec) from [<80387114>] (bpf_jit_free+0x68/0xe4 kernel/bpf/core.c:1194)
[<803870ac>] (bpf_jit_free) from [<80387318>] (bpf_prog_free_deferred+0x188/0x1a0 kernel/bpf/core.c:2744)
 r5:847f7750 r4:82c0bc00
[<80387190>] (bpf_prog_free_deferred) from [<802668f4>] (process_one_work+0x19c/0x4a4 kernel/workqueue.c:2627)
 r9:82dee000 r8:00000000 r7:dddd12c0 r6:82c16000 r5:847f7750 r4:82c0bc00
[<80266758>] (process_one_work) from [<80266e3c>] (process_scheduled_works kernel/workqueue.c:2700 [inline])
[<80266758>] (process_one_work) from [<80266e3c>] (worker_thread+0x240/0x48c kernel/workqueue.c:2781)
 r10:61c88647 r9:82dee000 r8:dddd12e0 r7:82604d40 r6:dddd12c0 r5:82c0bc2c
 r4:82c0bc00
[<80266bfc>] (worker_thread) from [<8026e29c>] (kthread+0x104/0x134 kernel/kthread.c:388)
 r10:00000000 r9:df839e90 r8:82cb8640 r7:82c0bc00 r6:80266bfc r5:82dee000
 r4:82cb8100
[<8026e198>] (kthread) from [<80200104>] (ret_from_fork+0x14/0x30 arch/arm/kernel/entry-common.S:134)
Exception stack(0xdf83dfb0 to 0xdf83dff8)
dfa0:                                     00000000 00000000 00000000 00000000
dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:8026e198 r4:82cb8100
INFO: task kworker/1:3:117 blocked for more than 450 seconds.
      Not tainted 6.7.0-rc8-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:3     state:D stack:0     pid:117   tgid:117   ppid:2      flags:0x00000000
Workqueue: events bpf_prog_free_deferred
Backtrace: 
[<81855408>] (__schedule) from [<81856028>] (__schedule_loop kernel/sched/core.c:6763 [inline])
[<81855408>] (__schedule) from [<81856028>] (schedule+0x2c/0xb8 kernel/sched/core.c:6778)
 r10:82c16205 r9:00000000 r8:8270dad4 r7:00000002 r6:df981da4 r5:834f6c00
 r4:834f6c00
[<81855ffc>] (schedule) from [<818565d0>] (schedule_preempt_disabled+0x18/0x24 kernel/sched/core.c:6835)
 r5:834f6c00 r4:8270dad0
[<818565b8>] (schedule_preempt_disabled) from [<81858eb8>] (__mutex_lock_common kernel/locking/mutex.c:679 [inline])
[<818565b8>] (schedule_preempt_disabled) from [<81858eb8>] (__mutex_lock.constprop.0+0x2e8/0xae0 kernel/locking/mutex.c:747)
[<81858bd0>] (__mutex_lock.constprop.0) from [<81859784>] (__mutex_lock_slowpath+0x14/0x18 kernel/locking/mutex.c:1035)
 r10:82c16205 r9:df981e30 r8:00000000 r7:ffffffff r6:00000000 r5:846de4c0
 r4:00000000
[<81859770>] (__mutex_lock_slowpath) from [<818597c4>] (mutex_lock+0x3c/0x40 kernel/locking/mutex.c:286)
[<81859788>] (mutex_lock) from [<804898b0>] (_vm_unmap_aliases+0x60/0x2e4 mm/vmalloc.c:2267)
[<80489850>] (_vm_unmap_aliases) from [<8048d450>] (vm_reset_perms mm/vmalloc.c:2753 [inline])
[<80489850>] (_vm_unmap_aliases) from [<8048d450>] (vfree+0x170/0x1e0 mm/vmalloc.c:2832)
 r10:82c16205 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:846de4c0
 r4:00000000
[<8048d2e0>] (vfree) from [<802e9a2c>] (module_memfree+0x30/0x50 kernel/module/main.c:1189)
 r9:844ee400 r8:00000000 r7:00000000 r6:82c16200 r5:00001000 r4:7f00b000
[<802e99fc>] (module_memfree) from [<80386f54>] (bpf_jit_free_exec+0x10/0x14 kernel/bpf/core.c:1023)
 r5:00001000 r4:df93b000
[<80386f44>] (bpf_jit_free_exec) from [<80387114>] (bpf_jit_binary_free kernel/bpf/core.c:1069 [inline])
[<80386f44>] (bpf_jit_free_exec) from [<80387114>] (bpf_jit_free+0x68/0xe4 kernel/bpf/core.c:1194)
[<803870ac>] (bpf_jit_free) from [<80387318>] (bpf_prog_free_deferred+0x188/0x1a0 kernel/bpf/core.c:2744)
 r5:844ee750 r4:82e58f80
[<80387190>] (bpf_prog_free_deferred) from [<802668f4>] (process_one_work+0x19c/0x4a4 kernel/workqueue.c:2627)
 r9:834f6c00 r8:00000080 r7:ddde42c0 r6:82c16200 r5:844ee750 r4:82e58f80
[<80266758>] (process_one_work) from [<80266e3c>] (process_scheduled_works kernel/workqueue.c:2700 [inline])
[<80266758>] (process_one_work) from [<80266e3c>] (worker_thread+0x240/0x48c kernel/workqueue.c:2781)
 r10:61c88647 r9:834f6c00 r8:ddde42e0 r7:82604d40 r6:ddde42c0 r5:82e58fac
 r4:82e58f80
[<80266bfc>] (worker_thread) from [<8026e29c>] (kthread+0x104/0x134 kernel/kthread.c:388)
 r10:00000000 r9:df999e90 r8:83421500 r7:82e58f80 r6:80266bfc r5:834f6c00
 r4:82eb9e40
[<8026e198>] (kthread) from [<80200104>] (ret_from_fork+0x14/0x30 arch/arm/kernel/entry-common.S:134)
Exception stack(0xdf981fb0 to 0xdf981ff8)
1fa0:                                     00000000 00000000 00000000 00000000
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:8026e198 r4:82eb9e40
INFO: task kworker/0:3:1564 blocked for more than 450 seconds.
      Not tainted 6.7.0-rc8-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:3     state:D stack:0     pid:1564  tgid:1564  ppid:2      flags:0x00000000
Workqueue: events bpf_prog_free_deferred
Backtrace: 
[<81855408>] (__schedule) from [<81856028>] (__schedule_loop kernel/sched/core.c:6763 [inline])
[<81855408>] (__schedule) from [<81856028>] (schedule+0x2c/0xb8 kernel/sched/core.c:6778)
 r10:82c16005 r9:00000000 r8:8270dad4 r7:00000002 r6:eada5da4 r5:8362a400
 r4:8362a400
[<81855ffc>] (schedule) from [<818565d0>] (schedule_preempt_disabled+0x18/0x24 kernel/sched/core.c:6835)
 r5:8362a400 r4:8270dad0
[<818565b8>] (schedule_preempt_disabled) from [<81858eb8>] (__mutex_lock_common kernel/locking/mutex.c:679 [inline])
[<818565b8>] (schedule_preempt_disabled) from [<81858eb8>] (__mutex_lock.constprop.0+0x2e8/0xae0 kernel/locking/mutex.c:747)
[<81858bd0>] (__mutex_lock.constprop.0) from [<81859784>] (__mutex_lock_slowpath+0x14/0x18 kernel/locking/mutex.c:1035)
 r10:82c16005 r9:eada5e30 r8:00000000 r7:ffffffff r6:00000000 r5:8481e980
 r4:00000000
[<81859770>] (__mutex_lock_slowpath) from [<818597c4>] (mutex_lock+0x3c/0x40 kernel/locking/mutex.c:286)
[<81859788>] (mutex_lock) from [<804898b0>] (_vm_unmap_aliases+0x60/0x2e4 mm/vmalloc.c:2267)
[<80489850>] (_vm_unmap_aliases) from [<8048d450>] (vm_reset_perms mm/vmalloc.c:2753 [inline])
[<80489850>] (_vm_unmap_aliases) from [<8048d450>] (vfree+0x170/0x1e0 mm/vmalloc.c:2832)
 r10:82c16005 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:8481e980
 r4:00000000
[<8048d2e0>] (vfree) from [<802e9a2c>] (module_memfree+0x30/0x50 kernel/module/main.c:1189)
 r9:847ef000 r8:00000000 r7:00000000 r6:82c16000 r5:00001000 r4:7f0db000
[<802e99fc>] (module_memfree) from [<80386f54>] (bpf_jit_free_exec+0x10/0x14 kernel/bpf/core.c:1023)
 r5:00001000 r4:e487d000
[<80386f44>] (bpf_jit_free_exec) from [<80387114>] (bpf_jit_binary_free kernel/bpf/core.c:1069 [inline])
[<80386f44>] (bpf_jit_free_exec) from [<80387114>] (bpf_jit_free+0x68/0xe4 kernel/bpf/core.c:1194)
[<803870ac>] (bpf_jit_free) from [<80387318>] (bpf_prog_free_deferred+0x188/0x1a0 kernel/bpf/core.c:2744)
 r5:847ef350 r4:83e72200
[<80387190>] (bpf_prog_free_deferred) from [<802668f4>] (process_one_work+0x19c/0x4a4 kernel/workqueue.c:2627)
 r9:8362a400 r8:00000000 r7:dddd12c0 r6:82c16000 r5:847ef350 r4:83e72200
[<80266758>] (process_one_work) from [<80266e3c>] (process_scheduled_works kernel/workqueue.c:2700 [inline])
[<80266758>] (process_one_work) from [<80266e3c>] (worker_thread+0x240/0x48c kernel/workqueue.c:2781)
 r10:61c88647 r9:8362a400 r8:dddd12e0 r7:82604d40 r6:dddd12c0 r5:83e7222c
 r4:83e72200
[<80266bfc>] (worker_thread) from [<8026e29c>] (kthread+0x104/0x134 kernel/kthread.c:388)
 r10:00000000 r9:df839e90 r8:8385d7c0 r7:83e72200 r6:80266bfc r5:8362a400
 r4:83e76d40
[<8026e198>] (kthread) from [<80200104>] (ret_from_fork+0x14/0x30 arch/arm/kernel/entry-common.S:134)
Exception stack(0xeada5fb0 to 0xeada5ff8)
5fa0:                                     00000000 00000000 00000000 00000000
5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:8026e198 r4:83e76d40
INFO: task kworker/0:0:3003 blocked for more than 450 seconds.
      Not tainted 6.7.0-rc8-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:0     state:D stack:0     pid:3003  tgid:3003  ppid:2      flags:0x00000000
Workqueue: events bpf_prog_free_deferred
Backtrace: 
[<81855408>] (__schedule) from [<81856028>] (__schedule_loop kernel/sched/core.c:6763 [inline])
[<81855408>] (__schedule) from [<81856028>] (schedule+0x2c/0xb8 kernel/sched/core.c:6778)
 r10:82c16005 r9:00000000 r8:8270dad4 r7:00000002 r6:df9a5da4 r5:82dfe000
 r4:82dfe000
[<81855ffc>] (schedule) from [<818565d0>] (schedule_preempt_disabled+0x18/0x24 kernel/sched/core.c:6835)
 r5:82dfe000 r4:8270dad0
[<818565b8>] (schedule_preempt_disabled) from [<81858eb8>] (__mutex_lock_common kernel/locking/mutex.c:679 [inline])
[<818565b8>] (schedule_preempt_disabled) from [<81858eb8>] (__mutex_lock.constprop.0+0x2e8/0xae0 kernel/locking/mutex.c:747)
[<81858bd0>] (__mutex_lock.constprop.0) from [<81859784>] (__mutex_lock_slowpath+0x14/0x18 kernel/locking/mutex.c:1035)
 r10:82c16005 r9:df9a5e30 r8:00000000 r7:ffffffff r6:00000000 r5:8481e900
 r4:00000000
[<81859770>] (__mutex_lock_slowpath) from [<818597c4>] (mutex_lock+0x3c/0x40 kernel/locking/mutex.c:286)
[<81859788>] (mutex_lock) from [<804898b0>] (_vm_unmap_aliases+0x60/0x2e4 mm/vmalloc.c:2267)
[<80489850>] (_vm_unmap_aliases) from [<8048d450>] (vm_reset_perms mm/vmalloc.c:2753 [inline])
[<80489850>] (_vm_unmap_aliases) from [<8048d450>] (vfree+0x170/0x1e0 mm/vmalloc.c:2832)
 r10:82c16005 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:8481e900
 r4:00000000
[<8048d2e0>] (vfree) from [<802e9a2c>] (module_memfree+0x30/0x50 kernel/module/main.c:1189)
 r9:847eec00 r8:00000000 r7:00000000 r6:82c16000 r5:00001000 r4:7f0d9000
[<802e99fc>] (module_memfree) from [<80386f54>] (bpf_jit_free_exec+0x10/0x14 kernel/bpf/core.c:1023)
 r5:00001000 r4:e486f000
[<80386f44>] (bpf_jit_free_exec) from [<80387114>] (bpf_jit_binary_free kernel/bpf/core.c:1069 [inline])
[<80386f44>] (bpf_jit_free_exec) from [<80387114>] (bpf_jit_free+0x68/0xe4 kernel/bpf/core.c:1194)
[<803870ac>] (bpf_jit_free) from [<80387318>] (bpf_prog_free_deferred+0x188/0x1a0 kernel/bpf/core.c:2744)
 r5:847eef50 r4:84563380
[<80387190>] (bpf_prog_free_deferred) from [<802668f4>] (process_one_work+0x19c/0x4a4 kernel/workqueue.c:2627)
 r9:82dfe000 r8:00000000 r7:dddd12c0 r6:82c16000 r5:847eef50 r4:84563380
[<80266758>] (process_one_work) from [<80266e3c>] (process_scheduled_works kernel/workqueue.c:2700 [inline])
[<80266758>] (process_one_work) from [<80266e3c>] (worker_thread+0x240/0x48c kernel/workqueue.c:2781)
 r10:61c88647 r9:82dfe000 r8:dddd12e0 r7:82604d40 r6:dddd12c0 r5:845633ac
 r4:84563380
[<80266bfc>] (worker_thread) from [<8026e29c>] (kthread+0x104/0x134 kernel/kthread.c:388)
 r10:00000000 r9:eada5e90 r8:84551600 r7:84563380 r6:80266bfc r5:82dfe000
 r4:83ee7880
[<8026e198>] (kthread) from [<80200104>] (ret_from_fork+0x14/0x30 arch/arm/kernel/entry-common.S:134)
Exception stack(0xdf9a5fb0 to 0xdf9a5ff8)
5fa0:                                     00000000 00000000 00000000 00000000
5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:8026e198 r4:83ee7880
INFO: task kworker/1:1:3010 blocked for more than 450 seconds.
      Not tainted 6.7.0-rc8-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:1     state:D stack:0     pid:3010  tgid:3010  ppid:2      flags:0x00000000
Workqueue: events bpf_prog_free_deferred
Backtrace: 
[<81855408>] (__schedule) from [<81856028>] (__schedule_loop kernel/sched/core.c:6763 [inline])
[<81855408>] (__schedule) from [<81856028>] (schedule+0x2c/0xb8 kernel/sched/core.c:6778)
 r10:82c16205 r9:00000000 r8:8270dad4 r7:00000002 r6:df88dda4 r5:82dfbc00
 r4:82dfbc00
[<81855ffc>] (schedule) from [<818565d0>] (schedule_preempt_disabled+0x18/0x24 kernel/sched/core.c:6835)
 r5:82dfbc00 r4:8270dad0
[<818565b8>] (schedule_preempt_disabled) from [<81858eb8>] (__mutex_lock_common kernel/locking/mutex.c:679 [inline])
[<818565b8>] (schedule_preempt_disabled) from [<81858eb8>] (__mutex_lock.constprop.0+0x2e8/0xae0 kernel/locking/mutex.c:747)
[<81858bd0>] (__mutex_lock.constprop.0) from [<81859784>] (__mutex_lock_slowpath+0x14/0x18 kernel/locking/mutex.c:1035)
 r10:82c16205 r9:df88de30 r8:00000000 r7:ffffffff r6:00000000 r5:8478a640
 r4:00000000
[<81859770>] (__mutex_lock_slowpath) from [<818597c4>] (mutex_lock+0x3c/0x40 kernel/locking/mutex.c:286)
[<81859788>] (mutex_lock) from [<804898b0>] (_vm_unmap_aliases+0x60/0x2e4 mm/vmalloc.c:2267)
[<80489850>] (_vm_unmap_aliases) from [<8048d450>] (vm_reset_perms mm/vmalloc.c:2753 [inline])
[<80489850>] (_vm_unmap_aliases) from [<8048d450>] (vfree+0x170/0x1e0 mm/vmalloc.c:2832)
 r10:82c16205 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:8478a640
 r4:00000000
[<8048d2e0>] (vfree) from [<802e9a2c>] (module_memfree+0x30/0x50 kernel/module/main.c:1189)
 r9:84652400 r8:00000000 r7:00000000 r6:82c16200 r5:00001000 r4:7f165000
[<802e99fc>] (module_memfree) from [<80386f54>] (bpf_jit_free_exec+0x10/0x14 kernel/bpf/core.c:1023)
 r5:00001000 r4:eab0f000
[<80386f44>] (bpf_jit_free_exec) from [<80387114>] (bpf_jit_binary_free kernel/bpf/core.c:1069 [inline])
[<80386f44>] (bpf_jit_free_exec) from [<80387114>] (bpf_jit_free+0x68/0xe4 kernel/bpf/core.c:1194)
[<803870ac>] (bpf_jit_free) from [<80387318>] (bpf_prog_free_deferred+0x188/0x1a0 kernel/bpf/core.c:2744)
 r5:84652750 r4:84395d00
[<80387190>] (bpf_prog_free_deferred) from [<802668f4>] (process_one_work+0x19c/0x4a4 kernel/workqueue.c:2627)
 r9:82dfbc00 r8:00000080 r7:ddde42c0 r6:82c16200 r5:84652750 r4:84395d00
[<80266758>] (process_one_work) from [<80266e3c>] (process_scheduled_works kernel/workqueue.c:2700 [inline])
[<80266758>] (process_one_work) from [<80266e3c>] (worker_thread+0x240/0x48c kernel/workqueue.c:2781)
 r10:61c88647 r9:82dfbc00 r8:ddde42e0 r7:82604d40 r6:ddde42c0 r5:84395d2c
 r4:84395d00
[<80266bfc>] (worker_thread) from [<8026e29c>] (kthread+0x104/0x134 kernel/kthread.c:388)
 r10:00000000 r9:df981e90 r8:83e7cdc0 r7:84395d00 r6:80266bfc r5:82dfbc00
 r4:82cc8fc0
[<8026e198>] (kthread) from [<80200104>] (ret_from_fork+0x14/0x30 arch/arm/kernel/entry-common.S:134)
Exception stack(0xdf88dfb0 to 0xdf88dff8)
dfa0:                                     00000000 00000000 00000000 00000000
dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:8026e198 r4:82cc8fc0
INFO: task kworker/1:4:3011 blocked for more than 450 seconds.
      Not tainted 6.7.0-rc8-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:4     state:D stack:0     pid:3011  tgid:3011  ppid:2      flags:0x00000000
Workqueue: events bpf_prog_free_deferred
Backtrace: 
[<81855408>] (__schedule) from [<81856028>] (__schedule_loop kernel/sched/core.c:6763 [inline])
[<81855408>] (__schedule) from [<81856028>] (schedule+0x2c/0xb8 kernel/sched/core.c:6778)
 r10:82c16205 r9:00000000 r8:8270dad4 r7:00000002 r6:df9a1da4 r5:82df9800
 r4:82df9800
[<81855ffc>] (schedule) from [<818565d0>] (schedule_preempt_disabled+0x18/0x24 kernel/sched/core.c:6835)
 r5:82df9800 r4:8270dad0
[<818565b8>] (schedule_preempt_disabled) from [<81858eb8>] (__mutex_lock_common kernel/locking/mutex.c:679 [inline])
[<818565b8>] (schedule_preempt_disabled) from [<81858eb8>] (__mutex_lock.constprop.0+0x2e8/0xae0 kernel/locking/mutex.c:747)
[<81858bd0>] (__mutex_lock.constprop.0) from [<81859784>] (__mutex_lock_slowpath+0x14/0x18 kernel/locking/mutex.c:1035)
 r10:82c16205 r9:df9a1e30 r8:00000000 r7:ffffffff r6:00000000 r5:8461bc00
 r4:00000000
[<81859770>] (__mutex_lock_slowpath) from [<818597c4>] (mutex_lock+0x3c/0x40 kernel/locking/mutex.c:286)
[<81859788>] (mutex_lock) from [<804898b0>] (_vm_unmap_aliases+0x60/0x2e4 mm/vmalloc.c:2267)
[<80489850>] (_vm_unmap_aliases) from [<8048d450>] (vm_reset_perms mm/vmalloc.c:2753 [inline])
[<80489850>] (_vm_unmap_aliases) from [<8048d450>] (vfree+0x170/0x1e0 mm/vmalloc.c:2832)
 r10:82c16205 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:8461bc00
 r4:00000000
[<8048d2e0>] (vfree) from [<802e9a2c>] (module_memfree+0x30/0x50 kernel/module/main.c:1189)
 r9:848f7400 r8:00000000 r7:00000000 r6:82c16200 r5:00001000 r4:7f083000
[<802e99fc>] (module_memfree) from [<80386f54>] (bpf_jit_free_exec+0x10/0x14 kernel/bpf/core.c:1023)
 r5:00001000 r4:dfb79000
[<80386f44>] (bpf_jit_free_exec) from [<80387114>] (bpf_jit_binary_free kernel/bpf/core.c:1069 [inline])
[<80386f44>] (bpf_jit_free_exec) from [<80387114>] (bpf_jit_free+0x68/0xe4 kernel/bpf/core.c:1194)
[<803870ac>] (bpf_jit_free) from [<80387318>] (bpf_prog_free_deferred+0x188/0x1a0 kernel/bpf/core.c:2744)
 r5:848f7750 r4:84395e00
[<80387190>] (bpf_prog_free_deferred) from [<802668f4>] (process_one_work+0x19c/0x4a4 kernel/workqueue.c:2627)
 r9:82df9800 r8:00000080 r7:ddde42c0 r6:82c16200 r5:848f7750 r4:84395e00
[<80266758>] (process_one_work) from [<80266e3c>] (process_scheduled_works kernel/workqueue.c:2700 [inline])
[<80266758>] (process_one_work) from [<80266e3c>] (worker_thread+0x240/0x48c kernel/workqueue.c:2781)
 r10:61c88647 r9:82df9800 r8:ddde42e0 r7:82604d40 r6:ddde42c0 r5:84395e2c
 r4:84395e00
[<80266bfc>] (worker_thread) from [<8026e29c>] (kthread+0x104/0x134 kernel/kthread.c:388)
 r10:00000000 r9:df88de90 r8:84556c80 r7:84395e00 r6:80266bfc r5:82df9800
 r4:82cc8fc0
[<8026e198>] (kthread) from [<80200104>] (ret_from_fork+0x14/0x30 arch/arm/kernel/entry-common.S:134)
Exception stack(0xdf9a1fb0 to 0xdf9a1ff8)
1fa0:                                     00000000 00000000 00000000 00000000
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:8026e198 r4:82cc8fc0
INFO: task kworker/1:5:3013 blocked for more than 450 seconds.
      Not tainted 6.7.0-rc8-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:5     state:D stack:0     pid:3013  tgid:3013  ppid:2      flags:0x00000000
Workqueue: events bpf_prog_free_deferred
Backtrace: 
[<81855408>] (__schedule) from [<81856028>] (__schedule_loop kernel/sched/core.c:6763 [inline])
[<81855408>] (__schedule) from [<81856028>] (schedule+0x2c/0xb8 kernel/sched/core.c:6778)
 r10:82c16205 r9:00000000 r8:8270dad4 r7:00000002 r6:df98dda4 r5:83e66000
 r4:83e66000
[<81855ffc>] (schedule) from [<818565d0>] (schedule_preempt_disabled+0x18/0x24 kernel/sched/core.c:6835)
 r5:83e66000 r4:8270dad0
[<818565b8>] (schedule_preempt_disabled) from [<81858eb8>] (__mutex_lock_common kernel/locking/mutex.c:679 [inline])
[<818565b8>] (schedule_preempt_disabled) from [<81858eb8>] (__mutex_lock.constprop.0+0x2e8/0xae0 kernel/locking/mutex.c:747)
[<81858bd0>] (__mutex_lock.constprop.0) from [<81859784>] (__mutex_lock_slowpath+0x14/0x18 kernel/locking/mutex.c:1035)
 r10:82c16205 r9:df98de30 r8:00000000 r7:ffffffff r6:00000000 r5:84836400
 r4:00000000
[<81859770>] (__mutex_lock_slowpath) from [<818597c4>] (mutex_lock+0x3c/0x40 kernel/locking/mutex.c:286)
[<81859788>] (mutex_lock) from [<804898b0>] (_vm_unmap_aliases+0x60/0x2e4 mm/vmalloc.c:2267)
[<80489850>] (_vm_unmap_aliases) from [<8048d450>] (vm_reset_perms mm/vmalloc.c:2753 [inline])
[<80489850>] (_vm_unmap_aliases) from [<8048d450>] (vfree+0x170/0x1e0 mm/vmalloc.c:2832)
 r10:82c16205 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:84836400
 r4:00000000
[<8048d2e0>] (vfree) from [<802e9a2c>] (module_memfree+0x30/0x50 kernel/module/main.c:1189)
 r9:847ab800 r8:00000000 r7:00000000 r6:82c16200 r5:00001000 r4:7f029000
[<802e99fc>] (module_memfree) from [<80386f54>] (bpf_jit_free_exec+0x10/0x14 kernel/bpf/core.c:1023)
 r5:00001000 r4:df995000
[<80386f44>] (bpf_jit_free_exec) from [<80387114>] (bpf_jit_binary_free kernel/bpf/core.c:1069 [inline])
[<80386f44>] (bpf_jit_free_exec) from [<80387114>] (bpf_jit_free+0x68/0xe4 kernel/bpf/core.c:1194)
[<803870ac>] (bpf_jit_free) from [<80387318>] (bpf_prog_free_deferred+0x188/0x1a0 kernel/bpf/core.c:2744)
 r5:847abb50 r4:84395b80
[<80387190>] (bpf_prog_free_deferred) from [<802668f4>] (process_one_work+0x19c/0x4a4 kernel/workqueue.c:2627)
 r9:83e66000 r8:00000080 r7:ddde42c0 r6:82c16200 r5:847abb50 r4:84395b80
[<80266758>] (process_one_work) from [<80266e3c>] (process_scheduled_works kernel/workqueue.c:2700 [inline])
[<80266758>] (process_one_work) from [<80266e3c>] (worker_thread+0x240/0x48c kernel/workqueue.c:2781)
 r10:61c88647 r9:83e66000 r8:ddde42e0 r7:82604d40 r6:ddde42c0 r5:84395bac
 r4:84395b80
[<80266bfc>] (worker_thread) from [<8026e29c>] (kthread+0x104/0x134 kernel/kthread.c:388)
 r10:00000000 r9:df9a1e90 r8:82cc8fc0 r7:84395b80 r6:80266bfc r5:83e66000
 r4:83dc4f40
[<8026e198>] (kthread) from [<80200104>] (ret_from_fork+0x14/0x30 arch/arm/kernel/entry-common.S:134)
Exception stack(0xdf98dfb0 to 0xdf98dff8)
dfa0:                                     00000000 00000000 00000000 00000000
dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:8026e198 r4:83dc4f40
INFO: task kworker/0:2:3016 blocked for more than 450 seconds.
      Not tainted 6.7.0-rc8-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:2     state:D stack:0     pid:3016  tgid:3016  ppid:2      flags:0x00000000
Workqueue: events bpf_prog_free_deferred
Backtrace: 
[<81855408>] (__schedule) from [<81856028>] (__schedule_loop kernel/sched/core.c:6763 [inline])
[<81855408>] (__schedule) from [<81856028>] (schedule+0x2c/0xb8 kernel/sched/core.c:6778)
 r10:82c16005 r9:00000000 r8:8270dad4 r7:00000002 r6:df9bdda4 r5:83e51800
 r4:83e51800
[<81855ffc>] (schedule) from [<818565d0>] (schedule_preempt_disabled+0x18/0x24 kernel/sched/core.c:6835)
 r5:83e51800 r4:8270dad0
[<818565b8>] (schedule_preempt_disabled) from [<81858eb8>] (__mutex_lock_common kernel/locking/mutex.c:679 [inline])
[<818565b8>] (schedule_preempt_disabled) from [<81858eb8>] (__mutex_lock.constprop.0+0x2e8/0xae0 kernel/locking/mutex.c:747)
[<81858bd0>] (__mutex_lock.constprop.0) from [<81859784>] (__mutex_lock_slowpath+0x14/0x18 kernel/locking/mutex.c:1035)
 r10:82c16005 r9:df9bde30 r8:00000000 r7:ffffffff r6:00000000 r5:84832040
 r4:00000000
[<81859770>] (__mutex_lock_slowpath) from [<818597c4>] (mutex_lock+0x3c/0x40 kernel/locking/mutex.c:286)
[<81859788>] (mutex_lock) from [<804898b0>] (_vm_unmap_aliases+0x60/0x2e4 mm/vmalloc.c:2267)
[<80489850>] (_vm_unmap_aliases) from [<8048d450>] (vm_reset_perms mm/vmalloc.c:2753 [inline])
[<80489850>] (_vm_unmap_aliases) from [<8048d450>] (vfree+0x170/0x1e0 mm/vmalloc.c:2832)
 r10:82c16005 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:84832040
 r4:00000000
[<8048d2e0>] (vfree) from [<802e9a2c>] (module_memfree+0x30/0x50 kernel/module/main.c:1189)
 r9:847f4c00 r8:00000000 r7:00000000 r6:82c16000 r5:00001000 r4:7f02d000
[<802e99fc>] (module_memfree) from [<80386f54>] (bpf_jit_free_exec+0x10/0x14 kernel/bpf/core.c:1023)
 r5:00001000 r4:dfa03000
[<80386f44>] (bpf_jit_free_exec) from [<80387114>] (bpf_jit_binary_free kernel/bpf/core.c:1069 [inline])
[<80386f44>] (bpf_jit_free_exec) from [<80387114>] (bpf_jit_free+0x68/0xe4 kernel/bpf/core.c:1194)
[<803870ac>] (bpf_jit_free) from [<80387318>] (bpf_prog_free_deferred+0x188/0x1a0 kernel/bpf/core.c:2744)
 r5:847f4f50 r4:84563400
[<80387190>] (bpf_prog_free_deferred) from [<802668f4>] (process_one_work+0x19c/0x4a4 kernel/workqueue.c:2627)
 r9:83e51800 r8:00000000 r7:dddd12c0 r6:82c16000 r5:847f4f50 r4:84563400
[<80266758>] (process_one_work) from [<80266e3c>] (process_scheduled_works kernel/workqueue.c:2700 [inline])
[<80266758>] (process_one_work) from [<80266e3c>] (worker_thread+0x240/0x48c kernel/workqueue.c:2781)
 r10:61c88647 r9:83e51800 r8:dddd12e0 r7:82604d40 r6:dddd12c0 r5:8456342c
 r4:84563400
[<80266bfc>] (worker_thread) from [<8026e29c>] (kthread+0x104/0x134 kernel/kthread.c:388)
 r10:00000000 r9:eada5e90 r8:8453a140 r7:84563400 r6:80266bfc r5:83e51800
 r4:8356cc40
[<8026e198>] (kthread) from [<80200104>] (ret_from_fork+0x14/0x30 arch/arm/kernel/entry-common.S:134)
Exception stack(0xdf9bdfb0 to 0xdf9bdff8)
dfa0:                                     00000000 00000000 00000000 00000000
dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:8026e198 r4:8356cc40
INFO: task kworker/0:4:3017 blocked for more than 450 seconds.
      Not tainted 6.7.0-rc8-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:4     state:D stack:0     pid:3017  tgid:3017  ppid:2      flags:0x00000000
Workqueue: events bpf_prog_free_deferred
Backtrace: 
[<81855408>] (__schedule) from [<81856028>] (__schedule_loop kernel/sched/core.c:6763 [inline])
[<81855408>] (__schedule) from [<81856028>] (schedule+0x2c/0xb8 kernel/sched/core.c:6778)
 r10:82c16005 r9:00000000 r8:8270dad4 r7:00000002 r6:df9c5da4 r5:83e50000
 r4:83e50000
[<81855ffc>] (schedule) from [<818565d0>] (schedule_preempt_disabled+0x18/0x24 kernel/sched/core.c:6835)
 r5:83e50000 r4:8270dad0
[<818565b8>] (schedule_preempt_disabled) from [<81858eb8>] (__mutex_lock_common kernel/locking/mutex.c:679 [inline])
[<818565b8>] (schedule_preempt_disabled) from [<81858eb8>] (__mutex_lock.constprop.0+0x2e8/0xae0 kernel/locking/mutex.c:747)
[<81858bd0>] (__mutex_lock.constprop.0) from [<81859784>] (__mutex_lock_slowpath+0x14/0x18 kernel/locking/mutex.c:1035)
 r10:82c16005 r9:df9c5e30 r8:00000000 r7:ffffffff r6:00000000 r5:8481ec00
 r4:00000000
[<81859770>] (__mutex_lock_slowpath) from [<818597c4>] (mutex_lock+0x3c/0x40 kernel/locking/mutex.c:286)
[<81859788>] (mutex_lock) from [<804898b0>] (_vm_unmap_aliases+0x60/0x2e4 mm/vmalloc.c:2267)
[<80489850>] (_vm_unmap_aliases) from [<8048d450>] (vm_reset_perms mm/vmalloc.c:2753 [inline])
[<80489850>] (_vm_unmap_aliases) from [<8048d450>] (vfree+0x170/0x1e0 mm/vmalloc.c:2832)
 r10:82c16005 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:8481ec00
 r4:00000000
[<8048d2e0>] (vfree) from [<802e9a2c>] (module_memfree+0x30/0x50 kernel/module/main.c:1189)
 r9:847ef800 r8:00000000 r7:00000000 r6:82c16000 r5:00001000 r4:7f125000
[<802e99fc>] (module_memfree) from [<80386f54>] (bpf_jit_free_exec+0x10/0x14 kernel/bpf/core.c:1023)
 r5:00001000 r4:e889b000
[<80386f44>] (bpf_jit_free_exec) from [<80387114>] (bpf_jit_binary_free kernel/bpf/core.c:1069 [inline])
[<80386f44>] (bpf_jit_free_exec) from [<80387114>] (bpf_jit_free+0x68/0xe4 kernel/bpf/core.c:1194)
[<803870ac>] (bpf_jit_free) from [<80387318>] (bpf_prog_free_deferred+0x188/0x1a0 kernel/bpf/core.c:2744)
 r5:847efb50 r4:84563480
[<80387190>] (bpf_prog_free_deferred) from [<802668f4>] (process_one_work+0x19c/0x4a4 kernel/workqueue.c:2627)
 r9:83e50000 r8:00000000 r7:dddd12c0 r6:82c16000 r5:847efb50 r4:84563480
[<80266758>] (process_one_work) from [<80266e3c>] (process_scheduled_works kernel/workqueue.c:2700 [inline])
[<80266758>] (process_one_work) from [<80266e3c>] (worker_thread+0x240/0x48c kernel/workqueue.c:2781)
 r10:61c88647 r9:83e50000 r8:dddd12e0 r7:82604d40 r6:dddd12c0 r5:845634ac
 r4:84563480
[<80266bfc>] (worker_thread) from [<8026e29c>] (kthread+0x104/0x134 kernel/kthread.c:388)
 r10:00000000 r9:df9bde90 r8:8453a700 r7:84563480 r6:80266bfc r5:83e50000
 r4:840eafc0
[<8026e198>] (kthread) from [<80200104>] (ret_from_fork+0x14/0x30 arch/arm/kernel/entry-common.S:134)
Exception stack(0xdf9c5fb0 to 0xdf9c5ff8)
5fa0:                                     00000000 00000000 00000000 00000000
5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:8026e198 r4:840eafc0
INFO: task kworker/0:5:3019 blocked for more than 450 seconds.
      Not tainted 6.7.0-rc8-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:5     state:D stack:0     pid:3019  tgid:3019  ppid:2      flags:0x00000000
Workqueue: events bpf_prog_free_deferred
Backtrace: 
[<81855408>] (__schedule) from [<81856028>] (__schedule_loop kernel/sched/core.c:6763 [inline])
[<81855408>] (__schedule) from [<81856028>] (schedule+0x2c/0xb8 kernel/sched/core.c:6778)
 r10:82c16005 r9:00000000 r8:8270dad4 r7:00000002 r6:df9cdda4 r5:83e53c00
 r4:83e53c00
[<81855ffc>] (schedule) from [<818565d0>] (schedule_preempt_disabled+0x18/0x24 kernel/sched/core.c:6835)
 r5:83e53c00 r4:8270dad0
[<818565b8>] (schedule_preempt_disabled) from [<81858eb8>] (__mutex_lock_common kernel/locking/mutex.c:679 [inline])
[<818565b8>] (schedule_preempt_disabled) from [<81858eb8>] (__mutex_lock.constprop.0+0x2e8/0xae0 kernel/locking/mutex.c:747)
[<81858bd0>] (__mutex_lock.constprop.0) from [<81859784>] (__mutex_lock_slowpath+0x14/0x18 kernel/locking/mutex.c:1035)
 r10:82c16005 r9:df9cde30 r8:00000000 r7:ffffffff r6:00000000 r5:8481ed40
 r4:00000000
[<81859770>] (__mutex_lock_slowpath) from [<818597c4>] (mutex_lock+0x3c/0x40 kernel/locking/mutex.c:286)
[<81859788>] (mutex_lock) from [<804898b0>] (_vm_unmap_aliases+0x60/0x2e4 mm/vmalloc.c:2267)
[<80489850>] (_vm_unmap_aliases) from [<8048d450>] (vm_reset_perms mm/vmalloc.c:2753 [inline])
[<80489850>] (_vm_unmap_aliases) from [<8048d450>] (vfree+0x170/0x1e0 mm/vmalloc.c:2832)
 r10:82c16005 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:8481ed40
 r4:00000000
[<8048d2e0>] (vfree) from [<802e9a2c>] (module_memfree+0x30/0x50 kernel/module/main.c:1189)
 r9:847efc00 r8:00000000 r7:00000000 r6:82c16000 r5:00001000 r4:7f127000
[<802e99fc>] (module_memfree) from [<80386f54>] (bpf_jit_free_exec+0x10/0x14 kernel/bpf/core.c:1023)
 r5:00001000 r4:e88a3000
[<80386f44>] (bpf_jit_free_exec) from [<80387114>] (bpf_jit_binary_free kernel/bpf/core.c:1069 [inline])
[<80386f44>] (bpf_jit_free_exec) from [<80387114>] (bpf_jit_free+0x68/0xe4 kernel/bpf/core.c:1194)
[<803870ac>] (bpf_jit_free) from [<80387318>] (bpf_prog_free_deferred+0x188/0x1a0 kernel/bpf/core.c:2744)
 r5:847eff50 r4:84563500
[<80387190>] (bpf_prog_free_deferred) from [<802668f4>] (process_one_work+0x19c/0x4a4 kernel/workqueue.c:2627)
 r9:83e53c00 r8:00000000 r7:dddd12c0 r6:82c16000 r5:847eff50 r4:84563500
[<80266758>] (process_one_work) from [<80266e3c>] (process_scheduled_works kernel/workqueue.c:2700 [inline])
[<80266758>] (process_one_work) from [<80266e3c>] (worker_thread+0x240/0x48c kernel/workqueue.c:2781)
 r10:61c88647 r9:83e53c00 r8:dddd12e0 r7:82604d40 r6:dddd12c0 r5:8456352c
 r4:84563500
[<80266bfc>] (worker_thread) from [<8026e29c>] (kthread+0x104/0x134 kernel/kthread.c:388)
 r10:00000000 r9:df9bde90 r8:83d869c0 r7:84563500 r6:80266bfc r5:83e53c00
 r4:840eafc0
[<8026e198>] (kthread) from [<80200104>] (ret_from_fork+0x14/0x30 arch/arm/kernel/entry-common.S:134)
Exception stack(0xdf9cdfb0 to 0xdf9cdff8)
dfa0:                                     00000000 00000000 00000000 00000000
dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:8026e198 r4:840eafc0
Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings
NMI backtrace for cpu 0
CPU: 0 PID: 30 Comm: khungtaskd Not tainted 6.7.0-rc8-syzkaller #0
Hardware name: ARM-Versatile Express
Backtrace: 
[<8183402c>] (dump_backtrace) from [<81834128>] (show_stack+0x18/0x1c arch/arm/kernel/traps.c:256)
 r7:00000000 r6:00000113 r5:60000193 r4:81fc0e84
[<81834110>] (show_stack) from [<818516ac>] (__dump_stack lib/dump_stack.c:88 [inline])
[<81834110>] (show_stack) from [<818516ac>] (dump_stack_lvl+0x48/0x54 lib/dump_stack.c:106)
[<81851664>] (dump_stack_lvl) from [<818516d0>] (dump_stack+0x18/0x1c lib/dump_stack.c:113)
 r5:00000000 r4:00000001
[<818516b8>] (dump_stack) from [<818213e0>] (nmi_cpu_backtrace+0x160/0x17c lib/nmi_backtrace.c:113)
[<81821280>] (nmi_cpu_backtrace) from [<8182152c>] (nmi_trigger_cpumask_backtrace+0x130/0x1d8 lib/nmi_backtrace.c:62)
 r7:00000000 r6:8260c494 r5:8261a7d8 r4:ffffffff
[<818213fc>] (nmi_trigger_cpumask_backtrace) from [<802104d4>] (arch_trigger_cpumask_backtrace+0x18/0x1c arch/arm/kernel/smp.c:851)
 r9:827df3df r8:8289ceb4 r7:8260c5e4 r6:00007d6b r5:8261adc8 r4:848fef2c
[<802104bc>] (arch_trigger_cpumask_backtrace) from [<80346b50>] (trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline])
[<802104bc>] (arch_trigger_cpumask_backtrace) from [<80346b50>] (check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline])
[<802104bc>] (arch_trigger_cpumask_backtrace) from [<80346b50>] (watchdog+0x48c/0x59c kernel/hung_task.c:379)
[<803466c4>] (watchdog) from [<8026e29c>] (kthread+0x104/0x134 kernel/kthread.c:388)
 r10:00000000 r9:df819e58 r8:82e21340 r7:00000000 r6:803466c4 r5:82e70c00
 r4:82ec6940
[<8026e198>] (kthread) from [<80200104>] (ret_from_fork+0x14/0x30 arch/arm/kernel/entry-common.S:134)
Exception stack(0xdf8d9fb0 to 0xdf8d9ff8)
9fa0:                                     00000000 00000000 00000000 00000000
9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:8026e198 r4:82ec6940
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 2801 Comm: klogd Not tainted 6.7.0-rc8-syzkaller #0
Hardware name: ARM-Versatile Express
PC is at 0x76da8608
LR is at 0x76d8d764
pc : [<76da8608>]    lr : [<76d8d764>]    psr: 20000010
sp : 7eedebc8  ip : 76e70e78  fp : 76f4a21a
r10: 76e70e60  r9 : 00000006  r8 : 76e70e60
r7 : 7eedebf4  r6 : 7eedebf8  r5 : 7eedec14  r4 : 01bfb1a8
r3 : 01bfb258  r2 : 01bfb008  r1 : 00002000  r0 : 00000001
Flags: nzCv  IRQs on  FIQs on  Mode USER_32  ISA ARM  Segment none
Control: 30c5387d  Table: 842afd80  DAC: 00000000
Backtrace: invalid frame pointer 0x76f4a21a


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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

