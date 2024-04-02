Return-Path: <linux-kernel+bounces-128437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE42A895ACF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27BF71F21C1D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB3915A4A6;
	Tue,  2 Apr 2024 17:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="hsdlIBS7"
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043D717582
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 17:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079509; cv=none; b=Um1che+a9khqdVDSxyuZZ+PBoiatglofjYgzYLPVEGtCGT9+2FaELkF/IqSWMfFtvuYkPfI6e7UGmz48bLK6+4Y6VpkyU8lnSTGTjii8JWXqsTWgZKJWHmdV3kF+yNqxlsctqQrkoRklEWK1jZhKm4UsVoyzSQFuW7H7H+MVhNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079509; c=relaxed/simple;
	bh=ir+4+naPsdWX8LSyAClpF/Nf2lvpor8zHNPk4Dagn/Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=F5cpuFVZ0sFIyXWDU4BZ/XT4wmvNbidiBV1rvmiKUZGKAx4n1sKfxL/lmN3E4FKkx79HXh/M9ctuLHPsd+8fJKFJg7BcvkkEG3MPwfMvRRBCq5BQTrVC6cOOXuVrChKXwzeBbqxZQXfEdm9zmbtKAVkBAbW0Djce9B5wRJIImtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=hsdlIBS7; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 3590C3C0071
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 17:38:19 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id AB6C213C2B0
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 10:38:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com AB6C213C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1712079498;
	bh=ir+4+naPsdWX8LSyAClpF/Nf2lvpor8zHNPk4Dagn/Q=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=hsdlIBS7uNxfcZOIFrqvTHzPPsk+uR4R4uzK04ob5fC7a3vzrW//WQmiqIejk7uv2
	 ahcoqQKV207ruP6tw1RF1cwtBSOyF1qlxHhs1iDTJkQ5GouMsZ9V85uzjcyLBegdry
	 7q8y9LD/XlOm3UU1P/Q2eCg48J8QUjrRrbVz1ik4=
Message-ID: <30819e01-43ce-638f-0cc6-067d6a8d03c7@candelatech.com>
Date: Tue, 2 Apr 2024 10:38:18 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: 6.9.0-rc2+ kernel hangs on boot.
Content-Language: en-US
From: Ben Greear <greearb@candelatech.com>
To: LKML <linux-kernel@vger.kernel.org>
References: <30f757e3-73c5-5473-c1f8-328bab98fd7d@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <30f757e3-73c5-5473-c1f8-328bab98fd7d@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1712079499-4ffM3zQ6kniz
X-MDID-O:
 us5;at1;1712079499;4ffM3zQ6kniz;<greearb@candelatech.com>;c71d53d8b4bf163c84f4470b0e4d7294

On 4/2/24 09:37, Ben Greear wrote:
> Hello,
> 
> Sometime between rc1 and today's rc2, my system quit booting.
> I'm not seeing any splats, it just stops.  Evidently before
> sysrq is enabled.
> 
> [  OK  ] Started Flush Journal to Persistent Storage.
> [  OK  ] Started udev Coldplug all Devices.
>           Starting udev Wait for Complete Device Initialization...
> [  OK  ] Listening on Load/Save RF …itch Status /dev/rfkill Watch.
> [  OK  ] Created slice system-lvm2\x2dpvscan.slice.
>           Starting LVM2 PV scan on device 8:19...
>           Starting LVM2 PV scan on device 8:3...
> [  OK  ] Started Device-mapper event daemon.
> iwlwifi 0000:04:00.0: WRT: Invalid buffer destination: 0
> sysrq: This sysrq operation is disabled.
> 
> I can start a bisect, but in case anyone knows the answer already, please let me know.
> 
> Thanks,
> Ben
> 

So, deadlock I guess....

  INFO: task kworker/5:13:648 blocked for more than 180 seconds.
       Not tainted 6.9.0-rc2+ #23
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/5:13    state:D stack:0     pid:648   tgid:648   ppid:2      flags:0x00004000
Workqueue: events deferred_probe_timeout_work_func
Call Trace:
  <TASK>
  __schedule+0x43d/0xe20
  schedule+0x31/0x130
  schedule_timeout+0x1b9/0x1d0
  ? mark_held_locks+0x49/0x70
  ? lockdep_hardirqs_on_prepare+0xd6/0x170
  __wait_for_common+0xb9/0x1d0
  ? usleep_range_state+0xb0/0xb0
  ? __flush_work+0x1ff/0x460
  __flush_work+0x287/0x460
  ? flush_workqueue_prep_pwqs+0x120/0x120
  deferred_probe_timeout_work_func+0x2b/0xa0
  process_one_work+0x212/0x710
  ? lock_is_held_type+0xa5/0x110
  worker_thread+0x188/0x340
  ? rescuer_thread+0x380/0x380
  kthread+0xd7/0x110
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x28/0x40
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork_asm+0x11/0x20
  </TASK>
INFO: task udevadm:763 blocked for more than 180 seconds.
       Not tainted 6.9.0-rc2+ #23
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevadm         state:D stack:0     pid:763   tgid:763   ppid:1      flags:0x00000000
Call Trace:
  <TASK>
  __schedule+0x43d/0xe20
  schedule+0x31/0x130
  schedule_timeout+0x1b9/0x1d0
  ? __wait_for_common+0xb0/0x1d0
  ? lock_release+0xc6/0x290
  ? lockdep_hardirqs_on_prepare+0xd6/0x170
  __wait_for_common+0xb9/0x1d0
  ? usleep_range_state+0xb0/0xb0
  ? __flush_work+0x1ff/0x460
  __flush_work+0x287/0x460
  ? flush_workqueue_prep_pwqs+0x120/0x120
  fsnotify_destroy_group+0x66/0xf0
  inotify_release+0x12/0x40
  __fput+0xa6/0x2d0
  __x64_sys_close+0x33/0x70
  do_syscall_64+0x6c/0x170
  entry_SYSCALL_64_after_hwframe+0x46/0x4e
RIP: 0033:0x7f744d5bc878
RSP: 002b:00007ffcef12f8d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 00007f744cd048c0 RCX: 00007f744d5bc878
RDX: ffffffffffffff80 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000000000003 R08: 000055f9ce349fb0 R09: 0000000000000000
R10: 00007ffcef12f8f0 R11: 0000000000000246 R12: 0000000000000002
R13: 0000000007270e00 R14: 000055f99670c9b8 R15: 0000000000000002
  </TASK>
INFO: task modprobe:968 blocked for more than 180 seconds.
       Not tainted 6.9.0-rc2+ #23
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:modprobe        state:D stack:0     pid:968   tgid:968   ppid:65     flags:0x00000000
Call Trace:
  <TASK>
  __schedule+0x43d/0xe20
  schedule+0x31/0x130
  schedule_timeout+0x1b9/0x1d0
  ? __wait_for_common+0xb0/0x1d0
  ? lock_release+0xc6/0x290
  ? lockdep_hardirqs_on_prepare+0xd6/0x170
  __wait_for_common+0xb9/0x1d0
  ? usleep_range_state+0xb0/0xb0
  idempotent_init_module+0x1ae/0x290
  __x64_sys_finit_module+0x55/0xb0
  do_syscall_64+0x6c/0x170
  entry_SYSCALL_64_after_hwframe+0x46/0x4e
RIP: 0033:0x7fde25530ddd
RSP: 002b:00007fffac078518 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 0000558758e28ef0 RCX: 00007fde25530ddd
RDX: 0000000000000000 RSI: 000055873cebf358 RDI: 0000000000000001
RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000246 R12: 000055873cebf358
R13: 0000000000000000 R14: 0000558758e29020 R15: 0000558758e28ef0
  </TASK>
INFO: task modprobe:969 blocked for more than 180 seconds.
       Not tainted 6.9.0-rc2+ #23
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:modprobe        state:D stack:0     pid:969   tgid:969   ppid:93     flags:0x00000000
Call Trace:
  <TASK>
  __schedule+0x43d/0xe20
  schedule+0x31/0x130
  schedule_timeout+0x1b9/0x1d0
  ? __wait_for_common+0xb0/0x1d0
  ? lock_release+0xc6/0x290
  ? lockdep_hardirqs_on_prepare+0xd6/0x170
  __wait_for_common+0xb9/0x1d0
  ? usleep_range_state+0xb0/0xb0
  idempotent_init_module+0x1ae/0x290
  __x64_sys_finit_module+0x55/0xb0
  do_syscall_64+0x6c/0x170
  entry_SYSCALL_64_after_hwframe+0x46/0x4e
RIP: 0033:0x7f338d516ddd
RSP: 002b:00007ffd155cd1e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 000056092cb0def0 RCX: 00007f338d516ddd
RDX: 0000000000000000 RSI: 00005608ecb4a358 RDI: 0000000000000001
RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000246 R12: 00005608ecb4a358
R13: 0000000000000000 R14: 000056092cb0e020 R15: 000056092cb0def0
  </TASK>
INFO: task modprobe:1044 blocked for more than 180 seconds.
       Not tainted 6.9.0-rc2+ #23
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:modprobe        state:D stack:0     pid:1044  tgid:1044  ppid:10     flags:0x00000000
Call Trace:
  <TASK>
  __schedule+0x43d/0xe20
  schedule+0x31/0x130
  schedule_timeout+0x1b9/0x1d0
  ? __wait_for_common+0xb0/0x1d0
  ? lock_release+0xc6/0x290
  ? lockdep_hardirqs_on_prepare+0xd6/0x170
  __wait_for_common+0xb9/0x1d0
  ? usleep_range_state+0xb0/0xb0
  idempotent_init_module+0x1ae/0x290
  __x64_sys_finit_module+0x55/0xb0
  do_syscall_64+0x6c/0x170
  entry_SYSCALL_64_after_hwframe+0x46/0x4e
RIP: 0033:0x7f7637b30ddd
RSP: 002b:00007ffe6251da78 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 000055b889cb3ef0 RCX: 00007f7637b30ddd
RDX: 0000000000000000 RSI: 000055b854eea358 RDI: 0000000000000001
RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000246 R12: 000055b854eea358
R13: 0000000000000000 R14: 000055b889cb4020 R15: 000055b889cb3ef0
  </TASK>
INFO: task modprobe:1047 blocked for more than 180 seconds.
       Not tainted 6.9.0-rc2+ #23
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:modprobe        state:D stack:0     pid:1047  tgid:1047  ppid:113    flags:0x00000000
Call Trace:
  <TASK>
  __schedule+0x43d/0xe20
  schedule+0x31/0x130
  schedule_timeout+0x1b9/0x1d0
  ? __wait_for_common+0xb0/0x1d0
  ? lock_release+0xc6/0x290
  ? lockdep_hardirqs_on_prepare+0xd6/0x170
  __wait_for_common+0xb9/0x1d0
  ? usleep_range_state+0xb0/0xb0
  idempotent_init_module+0x1ae/0x290
  __x64_sys_finit_module+0x55/0xb0
  do_syscall_64+0x6c/0x170
  entry_SYSCALL_64_after_hwframe+0x46/0x4e
RIP: 0033:0x7f3907130ddd
RSP: 002b:00007ffc36e4eb08 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 000056100a856ef0 RCX: 00007f3907130ddd
RDX: 0000000000000000 RSI: 0000560fff0ec358 RDI: 0000000000000001
RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000246 R12: 0000560fff0ec358
R13: 0000000000000000 R14: 000056100a857020 R15: 000056100a856ef0
  </TASK>
INFO: task modprobe:1056 blocked for more than 180 seconds.
       Not tainted 6.9.0-rc2+ #23
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:modprobe        state:D stack:0     pid:1056  tgid:1056  ppid:1045   flags:0x00000000
Call Trace:
  <TASK>
  __schedule+0x43d/0xe20
  schedule+0x31/0x130
  schedule_timeout+0x1b9/0x1d0
  ? __wait_for_common+0xb0/0x1d0
  ? lock_release+0xc6/0x290
  ? lockdep_hardirqs_on_prepare+0xd6/0x170
  __wait_for_common+0xb9/0x1d0
  ? usleep_range_state+0xb0/0xb0
  idempotent_init_module+0x1ae/0x290
  __x64_sys_finit_module+0x55/0xb0
  do_syscall_64+0x6c/0x170
  entry_SYSCALL_64_after_hwframe+0x46/0x4e
RIP: 0033:0x7fcb1e730ddd
RSP: 002b:00007ffc692d0ad8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 000055f8d8828ef0 RCX: 00007fcb1e730ddd
RDX: 0000000000000000 RSI: 000055f8bff36358 RDI: 0000000000000001
RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000246 R12: 000055f8bff36358
R13: 0000000000000000 R14: 000055f8d8829020 R15: 000055f8d8828ef0
  </TASK>
INFO: task modprobe:1058 blocked for more than 180 seconds.
       Not tainted 6.9.0-rc2+ #23
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:modprobe        state:D stack:0     pid:1058  tgid:1058  ppid:1051   flags:0x00000000
Call Trace:
  <TASK>
  __schedule+0x43d/0xe20
  schedule+0x31/0x130
  schedule_timeout+0x1b9/0x1d0
  ? __wait_for_common+0xb0/0x1d0
  ? lock_release+0xc6/0x290
  ? lockdep_hardirqs_on_prepare+0xd6/0x170
  __wait_for_common+0xb9/0x1d0
  ? usleep_range_state+0xb0/0xb0
  idempotent_init_module+0x1ae/0x290
  __x64_sys_finit_module+0x55/0xb0
  do_syscall_64+0x6c/0x170
  entry_SYSCALL_64_after_hwframe+0x46/0x4e
RIP: 0033:0x7f0a17b30ddd
RSP: 002b:00007fff56d619e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 000055abd6741ef0 RCX: 00007f0a17b30ddd
RDX: 0000000000000000 RSI: 000055abc6586358 RDI: 0000000000000001
RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000246 R12: 000055abc6586358
R13: 0000000000000000 R14: 000055abd6742020 R15: 000055abd6741ef0
  </TASK>
INFO: task modprobe:1060 blocked for more than 181 seconds.
       Not tainted 6.9.0-rc2+ #23
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:modprobe        state:D stack:0     pid:1060  tgid:1060  ppid:1057   flags:0x00000000
Call Trace:
  <TASK>
  __schedule+0x43d/0xe20
  schedule+0x31/0x130
  schedule_timeout+0x1b9/0x1d0
  ? __wait_for_common+0xb0/0x1d0
  ? lock_release+0xc6/0x290
  ? lockdep_hardirqs_on_prepare+0xd6/0x170
  __wait_for_common+0xb9/0x1d0
  ? usleep_range_state+0xb0/0xb0
  idempotent_init_module+0x1ae/0x290
  __x64_sys_finit_module+0x55/0xb0
  do_syscall_64+0x6c/0x170
  entry_SYSCALL_64_after_hwframe+0x46/0x4e
RIP: 0033:0x7f12c0130ddd
RSP: 002b:00007ffccdef0488 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 000056249db40ef0 RCX: 00007f12c0130ddd
RDX: 0000000000000000 RSI: 0000562471e4d358 RDI: 0000000000000001
RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000246 R12: 0000562471e4d358
R13: 0000000000000000 R14: 000056249db41020 R15: 000056249db40ef0
  </TASK>

Showing all locks held in the system:
2 locks held by systemd/1:
  #0: ffff88812a7a10a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x1f/0x50
  #1: ffff88812a7a1130 (&tty->atomic_write_lock){+.+.}-{4:4}, at: file_tty_write.constprop.0+0xab/0x330
2 locks held by kworker/0:1/9:
  #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
  #1: ffffc900000afe50 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
2 locks held by kworker/u32:0/10:
  #0: ffff888120070948 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
  #1: ffffc900000b7e50 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
2 locks held by kworker/3:0/37:
  #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
  #1: ffffc900001cbe50 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
2 locks held by kworker/7:0/61:
  #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
  #1: ffffc9000029be50 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
2 locks held by kworker/u32:1/65:
  #0: ffff888120070948 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
  #1: ffffc900002bfe50 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
1 lock held by khungtaskd/66:
  #0: ffffffff8296e760 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x32/0x1c0
2 locks held by kworker/1:1/79:
  #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
  #1: ffffc9000032fe50 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
2 locks held by kworker/u32:2/93:
  #0: ffff888120070948 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
  #1: ffffc900003d3e50 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
2 locks held by kworker/6:1/94:
  #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
  #1: ffffc900003dbe50 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
2 locks held by kworker/3:1/96:
  #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
  #1: ffffc900003ebe50 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
2 locks held by kworker/1:2/102:
  #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
  #1: ffffc90000eabe50 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
2 locks held by kworker/u32:3/107:
  #0: ffff888120070948 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
  #1: ffffc90000ed3e50 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
2 locks held by kworker/u32:4/113:
  #0: ffff888120070948 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
  #1: ffffc90000f03e50 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
2 locks held by kworker/6:2/189:
  #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
  #1: ffffc90000e0fe50 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
2 locks held by kworker/6:5/196:
  #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
  #1: ffffc90000f13e50 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
2 locks held by kworker/6:6/197:
  #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
  #1: ffffc90000f23e50 ((work_completion)(&(&hda->probe_work)->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
2 locks held by kworker/6:8/199:
  #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
  #1: ffffc90000f53e50 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
2 locks held by kworker/7:2/296:
  #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
  #1: ffffc9000105be50 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
2 locks held by kworker/7:3/297:
  #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
  #1: ffffc90001043e50 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
2 locks held by kworker/7:4/298:
  #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
  #1: ffffc90001063e50 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
2 locks held by kworker/7:5/320:
  #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
  #1: ffffc90001003e50 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
2 locks held by kworker/2:2/371:
  #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
  #1: ffffc9000104be50 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
2 locks held by kworker/5:13/648:
  #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
  #1: ffffc9000198fe50 ((deferred_probe_timeout_work).work){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
2 locks held by kworker/5:14/649:
  #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
  #1: ffffc90001997e50 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
2 locks held by kworker/5:15/650:
  #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
  #1: ffffc9000199fe50 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
2 locks held by kworker/5:16/651:
  #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
  #1: ffffc900019a7e50 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
2 locks held by kworker/4:3/722:
  #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
  #1: ffffc90001a27e50 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
2 locks held by kworker/1:4/768:
  #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
  #1: ffffc900010d7e50 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
2 locks held by kworker/1:5/769:
  #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
  #1: ffffc900010dfe50 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
2 locks held by kworker/0:2/849:
  #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
  #1: ffffc90001353e50 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
2 locks held by lvm/860:
  #0: ffff8881323c19a8 (&md->type_lock){+.+.}-{4:4}, at: table_load+0xc9/0x400
  #1: ffff88813200c3b8 (&mddev->reconfig_mutex){+.+.}-{4:4}, at: raid_ctr+0x13b3/0x2860 [dm_raid]
2 locks held by modprobe/1019:
  #0: ffffffffa0ca7b68 (iwlwifi_opmode_table_mtx){+.+.}-{4:4}, at: iwl_opmode_register+0x27/0xd0 [iwlwifi]
  #1: ffff888139f88270 (&led_cdev->led_access){+.+.}-{4:4}, at: led_classdev_register_ext+0x195/0x450
2 locks held by kworker/u32:5/1045:
  #0: ffff888120070948 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
  #1: ffffc90004367e50 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
2 locks held by kworker/u32:6/1051:
  #0: ffff888120070948 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
  #1: ffffc90004703e50 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
2 locks held by kworker/u32:7/1057:
  #0: ffff888120070948 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
  #1: ffffc90004a97e50 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
2 locks held by kworker/3:3/1111:
  #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
  #1: ffffc90005bafe50 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
2 locks held by kworker/3:4/1132:
  #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
  #1: ffffc90005e13e50 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710

=============================================


