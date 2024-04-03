Return-Path: <linux-kernel+bounces-130510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92974897912
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48766288F8F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1647815530B;
	Wed,  3 Apr 2024 19:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="h41plVnJ"
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A518A1552F8;
	Wed,  3 Apr 2024 19:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712172927; cv=none; b=pDxOKR5p2IDdErc7+BDwx9fT06t/QCN06wwE39Q4LvxSdNzcDG1D5RsWcaHB6qpH11Xf4OvYu5nsYXZEccwDxhiwuHhkjeMD5vnCXsFRi/SB1/yxnqptbaE3V8wFHqGwiVUIr/Xr3u3G8RpTv+EUBjb0+KH7dysBUIMbUNUz+h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712172927; c=relaxed/simple;
	bh=ujufbwWZJfJOporjunHN0GyMKfDAGy55nllGcF0sf24=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=diUfgYWicMrwg/SUkbsCnILj/rjRzmL34X9ZjjmNQFh2CEulyOxiuz8fID3DdN0lJavj1IqfV9xbsI/rVmYZeGhQlZeXxna8xnAVXRSyO6jnwRu8nqyD1G3xb5BMJ5UA1+1oFEvSHb36URseQichwpBBTvyHkgEGhHw6SA0PA2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=h41plVnJ; arc=none smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 51B7A2C0066;
	Wed,  3 Apr 2024 19:35:16 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 9C52413C2B0;
	Wed,  3 Apr 2024 12:35:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 9C52413C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1712172914;
	bh=ujufbwWZJfJOporjunHN0GyMKfDAGy55nllGcF0sf24=;
	h=Date:Subject:From:To:References:Cc:In-Reply-To:From;
	b=h41plVnJBzvfoFxMpllnlLr5FxLL8OjWOThH+BTO8iB13ZPqLnadv00j9vhSHsCDv
	 3ewL9EOXAf+Zxb+HjNCTtnt9w7Wle2t+uuqFbo8nwHofQDHagrkYM5uUlej3uCvgP9
	 sxAyEc5SCABQxmjtTKShfQ8pe9NV4nmy7tqdIb84=
Message-ID: <89a9eec3-337f-3c9f-6bbe-00a26a15287c@candelatech.com>
Date: Wed, 3 Apr 2024 12:35:14 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: 6.9.0-rc2+ kernel hangs on boot (bisected, maybe LED related)
Content-Language: en-US
From: Ben Greear <greearb@candelatech.com>
To: LKML <linux-kernel@vger.kernel.org>, linux-leds@vger.kernel.org
References: <30f757e3-73c5-5473-c1f8-328bab98fd7d@candelatech.com>
 <30819e01-43ce-638f-0cc6-067d6a8d03c7@candelatech.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Organization: Candela Technologies
In-Reply-To: <30819e01-43ce-638f-0cc6-067d6a8d03c7@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1712172917-66J5KxXt_Tbm
X-MDID-O:
 us5;at1;1712172917;66J5KxXt_Tbm;<greearb@candelatech.com>;caed28f67fcfef59186de1009c7fafea

On 4/2/24 10:38, Ben Greear wrote:
> On 4/2/24 09:37, Ben Greear wrote:
>> Hello,
>>
>> Sometime between rc1 and today's rc2, my system quit booting.
>> I'm not seeing any splats, it just stops.  Evidently before
>> sysrq is enabled.
>>
>> [  OK  ] Started Flush Journal to Persistent Storage.
>> [  OK  ] Started udev Coldplug all Devices.
>>           Starting udev Wait for Complete Device Initialization...
>> [  OK  ] Listening on Load/Save RF …itch Status /dev/rfkill Watch.
>> [  OK  ] Created slice system-lvm2\x2dpvscan.slice.
>>           Starting LVM2 PV scan on device 8:19...
>>           Starting LVM2 PV scan on device 8:3...
>> [  OK  ] Started Device-mapper event daemon.
>> iwlwifi 0000:04:00.0: WRT: Invalid buffer destination: 0
>> sysrq: This sysrq operation is disabled.
>>
>> I can start a bisect, but in case anyone knows the answer already, please let me know.
>>
>> Thanks,
>> Ben
>>
> 
> So, deadlock I guess....
> 
>   INFO: task kworker/5:13:648 blocked for more than 180 seconds.
>        Not tainted 6.9.0-rc2+ #23
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/5:13    state:D stack:0     pid:648   tgid:648   ppid:2      flags:0x00004000
> Workqueue: events deferred_probe_timeout_work_func
> Call Trace:
>   <TASK>
>   __schedule+0x43d/0xe20
>   schedule+0x31/0x130
>   schedule_timeout+0x1b9/0x1d0
>   ? mark_held_locks+0x49/0x70
>   ? lockdep_hardirqs_on_prepare+0xd6/0x170
>   __wait_for_common+0xb9/0x1d0
>   ? usleep_range_state+0xb0/0xb0
>   ? __flush_work+0x1ff/0x460
>   __flush_work+0x287/0x460
>   ? flush_workqueue_prep_pwqs+0x120/0x120
>   deferred_probe_timeout_work_func+0x2b/0xa0
>   process_one_work+0x212/0x710
>   ? lock_is_held_type+0xa5/0x110
>   worker_thread+0x188/0x340
>   ? rescuer_thread+0x380/0x380
>   kthread+0xd7/0x110
>   ? kthread_complete_and_exit+0x20/0x20
>   ret_from_fork+0x28/0x40
>   ? kthread_complete_and_exit+0x20/0x20
>   ret_from_fork_asm+0x11/0x20
>   </TASK>
> INFO: task udevadm:763 blocked for more than 180 seconds.
>        Not tainted 6.9.0-rc2+ #23
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:udevadm         state:D stack:0     pid:763   tgid:763   ppid:1      flags:0x00000000
> Call Trace:
>   <TASK>
>   __schedule+0x43d/0xe20
>   schedule+0x31/0x130
>   schedule_timeout+0x1b9/0x1d0
>   ? __wait_for_common+0xb0/0x1d0
>   ? lock_release+0xc6/0x290
>   ? lockdep_hardirqs_on_prepare+0xd6/0x170
>   __wait_for_common+0xb9/0x1d0
>   ? usleep_range_state+0xb0/0xb0
>   ? __flush_work+0x1ff/0x460
>   __flush_work+0x287/0x460
>   ? flush_workqueue_prep_pwqs+0x120/0x120
>   fsnotify_destroy_group+0x66/0xf0
>   inotify_release+0x12/0x40
>   __fput+0xa6/0x2d0
>   __x64_sys_close+0x33/0x70
>   do_syscall_64+0x6c/0x170
>   entry_SYSCALL_64_after_hwframe+0x46/0x4e
> RIP: 0033:0x7f744d5bc878
> RSP: 002b:00007ffcef12f8d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
> RAX: ffffffffffffffda RBX: 00007f744cd048c0 RCX: 00007f744d5bc878
> RDX: ffffffffffffff80 RSI: 0000000000000000 RDI: 0000000000000003
> RBP: 0000000000000003 R08: 000055f9ce349fb0 R09: 0000000000000000
> R10: 00007ffcef12f8f0 R11: 0000000000000246 R12: 0000000000000002
> R13: 0000000007270e00 R14: 000055f99670c9b8 R15: 0000000000000002
>   </TASK>
> INFO: task modprobe:968 blocked for more than 180 seconds.
>        Not tainted 6.9.0-rc2+ #23
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:modprobe        state:D stack:0     pid:968   tgid:968   ppid:65     flags:0x00000000
> Call Trace:
>   <TASK>
>   __schedule+0x43d/0xe20
>   schedule+0x31/0x130
>   schedule_timeout+0x1b9/0x1d0
>   ? __wait_for_common+0xb0/0x1d0
>   ? lock_release+0xc6/0x290
>   ? lockdep_hardirqs_on_prepare+0xd6/0x170
>   __wait_for_common+0xb9/0x1d0
>   ? usleep_range_state+0xb0/0xb0
>   idempotent_init_module+0x1ae/0x290
>   __x64_sys_finit_module+0x55/0xb0
>   do_syscall_64+0x6c/0x170
>   entry_SYSCALL_64_after_hwframe+0x46/0x4e
> RIP: 0033:0x7fde25530ddd
> RSP: 002b:00007fffac078518 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> RAX: ffffffffffffffda RBX: 0000558758e28ef0 RCX: 00007fde25530ddd
> RDX: 0000000000000000 RSI: 000055873cebf358 RDI: 0000000000000001
> RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000246 R12: 000055873cebf358
> R13: 0000000000000000 R14: 0000558758e29020 R15: 0000558758e28ef0
>   </TASK>
> INFO: task modprobe:969 blocked for more than 180 seconds.
>        Not tainted 6.9.0-rc2+ #23
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:modprobe        state:D stack:0     pid:969   tgid:969   ppid:93     flags:0x00000000
> Call Trace:
>   <TASK>
>   __schedule+0x43d/0xe20
>   schedule+0x31/0x130
>   schedule_timeout+0x1b9/0x1d0
>   ? __wait_for_common+0xb0/0x1d0
>   ? lock_release+0xc6/0x290
>   ? lockdep_hardirqs_on_prepare+0xd6/0x170
>   __wait_for_common+0xb9/0x1d0
>   ? usleep_range_state+0xb0/0xb0
>   idempotent_init_module+0x1ae/0x290
>   __x64_sys_finit_module+0x55/0xb0
>   do_syscall_64+0x6c/0x170
>   entry_SYSCALL_64_after_hwframe+0x46/0x4e
> RIP: 0033:0x7f338d516ddd
> RSP: 002b:00007ffd155cd1e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> RAX: ffffffffffffffda RBX: 000056092cb0def0 RCX: 00007f338d516ddd
> RDX: 0000000000000000 RSI: 00005608ecb4a358 RDI: 0000000000000001
> RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000246 R12: 00005608ecb4a358
> R13: 0000000000000000 R14: 000056092cb0e020 R15: 000056092cb0def0
>   </TASK>
> INFO: task modprobe:1044 blocked for more than 180 seconds.
>        Not tainted 6.9.0-rc2+ #23
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:modprobe        state:D stack:0     pid:1044  tgid:1044  ppid:10     flags:0x00000000
> Call Trace:
>   <TASK>
>   __schedule+0x43d/0xe20
>   schedule+0x31/0x130
>   schedule_timeout+0x1b9/0x1d0
>   ? __wait_for_common+0xb0/0x1d0
>   ? lock_release+0xc6/0x290
>   ? lockdep_hardirqs_on_prepare+0xd6/0x170
>   __wait_for_common+0xb9/0x1d0
>   ? usleep_range_state+0xb0/0xb0
>   idempotent_init_module+0x1ae/0x290
>   __x64_sys_finit_module+0x55/0xb0
>   do_syscall_64+0x6c/0x170
>   entry_SYSCALL_64_after_hwframe+0x46/0x4e
> RIP: 0033:0x7f7637b30ddd
> RSP: 002b:00007ffe6251da78 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> RAX: ffffffffffffffda RBX: 000055b889cb3ef0 RCX: 00007f7637b30ddd
> RDX: 0000000000000000 RSI: 000055b854eea358 RDI: 0000000000000001
> RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000246 R12: 000055b854eea358
> R13: 0000000000000000 R14: 000055b889cb4020 R15: 000055b889cb3ef0
>   </TASK>
> INFO: task modprobe:1047 blocked for more than 180 seconds.
>        Not tainted 6.9.0-rc2+ #23
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:modprobe        state:D stack:0     pid:1047  tgid:1047  ppid:113    flags:0x00000000
> Call Trace:
>   <TASK>
>   __schedule+0x43d/0xe20
>   schedule+0x31/0x130
>   schedule_timeout+0x1b9/0x1d0
>   ? __wait_for_common+0xb0/0x1d0
>   ? lock_release+0xc6/0x290
>   ? lockdep_hardirqs_on_prepare+0xd6/0x170
>   __wait_for_common+0xb9/0x1d0
>   ? usleep_range_state+0xb0/0xb0
>   idempotent_init_module+0x1ae/0x290
>   __x64_sys_finit_module+0x55/0xb0
>   do_syscall_64+0x6c/0x170
>   entry_SYSCALL_64_after_hwframe+0x46/0x4e
> RIP: 0033:0x7f3907130ddd
> RSP: 002b:00007ffc36e4eb08 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> RAX: ffffffffffffffda RBX: 000056100a856ef0 RCX: 00007f3907130ddd
> RDX: 0000000000000000 RSI: 0000560fff0ec358 RDI: 0000000000000001
> RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000246 R12: 0000560fff0ec358
> R13: 0000000000000000 R14: 000056100a857020 R15: 000056100a856ef0
>   </TASK>
> INFO: task modprobe:1056 blocked for more than 180 seconds.
>        Not tainted 6.9.0-rc2+ #23
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:modprobe        state:D stack:0     pid:1056  tgid:1056  ppid:1045   flags:0x00000000
> Call Trace:
>   <TASK>
>   __schedule+0x43d/0xe20
>   schedule+0x31/0x130
>   schedule_timeout+0x1b9/0x1d0
>   ? __wait_for_common+0xb0/0x1d0
>   ? lock_release+0xc6/0x290
>   ? lockdep_hardirqs_on_prepare+0xd6/0x170
>   __wait_for_common+0xb9/0x1d0
>   ? usleep_range_state+0xb0/0xb0
>   idempotent_init_module+0x1ae/0x290
>   __x64_sys_finit_module+0x55/0xb0
>   do_syscall_64+0x6c/0x170
>   entry_SYSCALL_64_after_hwframe+0x46/0x4e
> RIP: 0033:0x7fcb1e730ddd
> RSP: 002b:00007ffc692d0ad8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> RAX: ffffffffffffffda RBX: 000055f8d8828ef0 RCX: 00007fcb1e730ddd
> RDX: 0000000000000000 RSI: 000055f8bff36358 RDI: 0000000000000001
> RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000246 R12: 000055f8bff36358
> R13: 0000000000000000 R14: 000055f8d8829020 R15: 000055f8d8828ef0
>   </TASK>
> INFO: task modprobe:1058 blocked for more than 180 seconds.
>        Not tainted 6.9.0-rc2+ #23
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:modprobe        state:D stack:0     pid:1058  tgid:1058  ppid:1051   flags:0x00000000
> Call Trace:
>   <TASK>
>   __schedule+0x43d/0xe20
>   schedule+0x31/0x130
>   schedule_timeout+0x1b9/0x1d0
>   ? __wait_for_common+0xb0/0x1d0
>   ? lock_release+0xc6/0x290
>   ? lockdep_hardirqs_on_prepare+0xd6/0x170
>   __wait_for_common+0xb9/0x1d0
>   ? usleep_range_state+0xb0/0xb0
>   idempotent_init_module+0x1ae/0x290
>   __x64_sys_finit_module+0x55/0xb0
>   do_syscall_64+0x6c/0x170
>   entry_SYSCALL_64_after_hwframe+0x46/0x4e
> RIP: 0033:0x7f0a17b30ddd
> RSP: 002b:00007fff56d619e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> RAX: ffffffffffffffda RBX: 000055abd6741ef0 RCX: 00007f0a17b30ddd
> RDX: 0000000000000000 RSI: 000055abc6586358 RDI: 0000000000000001
> RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000246 R12: 000055abc6586358
> R13: 0000000000000000 R14: 000055abd6742020 R15: 000055abd6741ef0
>   </TASK>
> INFO: task modprobe:1060 blocked for more than 181 seconds.
>        Not tainted 6.9.0-rc2+ #23
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:modprobe        state:D stack:0     pid:1060  tgid:1060  ppid:1057   flags:0x00000000
> Call Trace:
>   <TASK>
>   __schedule+0x43d/0xe20
>   schedule+0x31/0x130
>   schedule_timeout+0x1b9/0x1d0
>   ? __wait_for_common+0xb0/0x1d0
>   ? lock_release+0xc6/0x290
>   ? lockdep_hardirqs_on_prepare+0xd6/0x170
>   __wait_for_common+0xb9/0x1d0
>   ? usleep_range_state+0xb0/0xb0
>   idempotent_init_module+0x1ae/0x290
>   __x64_sys_finit_module+0x55/0xb0
>   do_syscall_64+0x6c/0x170
>   entry_SYSCALL_64_after_hwframe+0x46/0x4e
> RIP: 0033:0x7f12c0130ddd
> RSP: 002b:00007ffccdef0488 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> RAX: ffffffffffffffda RBX: 000056249db40ef0 RCX: 00007f12c0130ddd
> RDX: 0000000000000000 RSI: 0000562471e4d358 RDI: 0000000000000001
> RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000246 R12: 0000562471e4d358
> R13: 0000000000000000 R14: 000056249db41020 R15: 000056249db40ef0
>   </TASK>
> 
> Showing all locks held in the system:
> 2 locks held by systemd/1:
>   #0: ffff88812a7a10a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x1f/0x50
>   #1: ffff88812a7a1130 (&tty->atomic_write_lock){+.+.}-{4:4}, at: file_tty_write.constprop.0+0xab/0x330
> 2 locks held by kworker/0:1/9:
>   #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
>   #1: ffffc900000afe50 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
> 2 locks held by kworker/u32:0/10:
>   #0: ffff888120070948 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
>   #1: ffffc900000b7e50 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
> 2 locks held by kworker/3:0/37:
>   #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
>   #1: ffffc900001cbe50 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
> 2 locks held by kworker/7:0/61:
>   #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
>   #1: ffffc9000029be50 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
> 2 locks held by kworker/u32:1/65:
>   #0: ffff888120070948 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
>   #1: ffffc900002bfe50 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
> 1 lock held by khungtaskd/66:
>   #0: ffffffff8296e760 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x32/0x1c0
> 2 locks held by kworker/1:1/79:
>   #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
>   #1: ffffc9000032fe50 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
> 2 locks held by kworker/u32:2/93:
>   #0: ffff888120070948 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
>   #1: ffffc900003d3e50 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
> 2 locks held by kworker/6:1/94:
>   #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
>   #1: ffffc900003dbe50 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
> 2 locks held by kworker/3:1/96:
>   #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
>   #1: ffffc900003ebe50 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
> 2 locks held by kworker/1:2/102:
>   #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
>   #1: ffffc90000eabe50 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
> 2 locks held by kworker/u32:3/107:
>   #0: ffff888120070948 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
>   #1: ffffc90000ed3e50 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
> 2 locks held by kworker/u32:4/113:
>   #0: ffff888120070948 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
>   #1: ffffc90000f03e50 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
> 2 locks held by kworker/6:2/189:
>   #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
>   #1: ffffc90000e0fe50 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
> 2 locks held by kworker/6:5/196:
>   #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
>   #1: ffffc90000f13e50 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
> 2 locks held by kworker/6:6/197:
>   #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
>   #1: ffffc90000f23e50 ((work_completion)(&(&hda->probe_work)->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
> 2 locks held by kworker/6:8/199:
>   #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
>   #1: ffffc90000f53e50 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
> 2 locks held by kworker/7:2/296:
>   #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
>   #1: ffffc9000105be50 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
> 2 locks held by kworker/7:3/297:
>   #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
>   #1: ffffc90001043e50 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
> 2 locks held by kworker/7:4/298:
>   #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
>   #1: ffffc90001063e50 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
> 2 locks held by kworker/7:5/320:
>   #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
>   #1: ffffc90001003e50 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
> 2 locks held by kworker/2:2/371:
>   #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
>   #1: ffffc9000104be50 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
> 2 locks held by kworker/5:13/648:
>   #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
>   #1: ffffc9000198fe50 ((deferred_probe_timeout_work).work){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
> 2 locks held by kworker/5:14/649:
>   #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
>   #1: ffffc90001997e50 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
> 2 locks held by kworker/5:15/650:
>   #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
>   #1: ffffc9000199fe50 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
> 2 locks held by kworker/5:16/651:
>   #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
>   #1: ffffc900019a7e50 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
> 2 locks held by kworker/4:3/722:
>   #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
>   #1: ffffc90001a27e50 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
> 2 locks held by kworker/1:4/768:
>   #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
>   #1: ffffc900010d7e50 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
> 2 locks held by kworker/1:5/769:
>   #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
>   #1: ffffc900010dfe50 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
> 2 locks held by kworker/0:2/849:
>   #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
>   #1: ffffc90001353e50 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
> 2 locks held by lvm/860:
>   #0: ffff8881323c19a8 (&md->type_lock){+.+.}-{4:4}, at: table_load+0xc9/0x400
>   #1: ffff88813200c3b8 (&mddev->reconfig_mutex){+.+.}-{4:4}, at: raid_ctr+0x13b3/0x2860 [dm_raid]
> 2 locks held by modprobe/1019:
>   #0: ffffffffa0ca7b68 (iwlwifi_opmode_table_mtx){+.+.}-{4:4}, at: iwl_opmode_register+0x27/0xd0 [iwlwifi]
>   #1: ffff888139f88270 (&led_cdev->led_access){+.+.}-{4:4}, at: led_classdev_register_ext+0x195/0x450
> 2 locks held by kworker/u32:5/1045:
>   #0: ffff888120070948 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
>   #1: ffffc90004367e50 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
> 2 locks held by kworker/u32:6/1051:
>   #0: ffff888120070948 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
>   #1: ffffc90004703e50 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
> 2 locks held by kworker/u32:7/1057:
>   #0: ffff888120070948 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
>   #1: ffffc90004a97e50 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
> 2 locks held by kworker/3:3/1111:
>   #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
>   #1: ffffc90005bafe50 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
> 2 locks held by kworker/3:4/1132:
>   #0: ffff88812006c548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x41e/0x710
>   #1: ffffc90005e13e50 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x1d1/0x710
> 
> =============================================
> 
> 

I ran a bisect on this.  The tagged bad commit is a LED related merge, but commit
shows no code changes when I look at it in git.  I double checked that the
merge is bad by manually going to it again at the end of the bisect and
indeed it fails.

 From looking at lockdep, this below may be interesting.  I do have 24 intel be200 radios
in this system, so maybe lots of iwlwifi radios help trigger the problem?

 > 2 locks held by modprobe/1019:
 >   #0: ffffffffa0ca7b68 (iwlwifi_opmode_table_mtx){+.+.}-{4:4}, at: iwl_opmode_register+0x27/0xd0 [iwlwifi]
 >   #1: ffff888139f88270 (&led_cdev->led_access){+.+.}-{4:4}, at: led_classdev_register_ext+0x195/0x450

Please let me know if you have any suggestions for how to debug this further.

[greearb@ben-dt5 linux-2.6]$ git bisect log
git bisect start
# status: waiting for both good and bad commits
# good: [e8f897f4afef0031fe618a8e94127a0934896aba] Linux 6.8
git bisect good e8f897f4afef0031fe618a8e94127a0934896aba
# status: waiting for bad commit, 1 good commit known
# bad: [4cece764965020c22cff7665b18a012006359095] Linux 6.9-rc1
git bisect bad 4cece764965020c22cff7665b18a012006359095
# good: [e5e038b7ae9da96b93974bf072ca1876899a01a3] Merge tag 'fs_for_v6.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs
git bisect good e5e038b7ae9da96b93974bf072ca1876899a01a3
# bad: [32a50540c3d26341698505998dfca5b0e8fb4fd4] Merge tag 'bcachefs-2024-03-13' of https://evilpiepirate.org/git/bcachefs
git bisect bad 32a50540c3d26341698505998dfca5b0e8fb4fd4
# good: [a3df5d5422b4edfcfe658d5057e7e059571e32ce] Merge tag 'pinctrl-v6.9-1' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl
git bisect good a3df5d5422b4edfcfe658d5057e7e059571e32ce
# bad: [c0a614e82ece41d15b7a66f43ee79f4dbdbc925a] Merge tag 'lsm-pr-20240314' of git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm
git bisect bad c0a614e82ece41d15b7a66f43ee79f4dbdbc925a
# bad: [705c1da8fa4816fb0159b5602fef1df5946a3ee2] Merge tag 'pci-v6.9-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci
git bisect bad 705c1da8fa4816fb0159b5602fef1df5946a3ee2
# bad: [f5c31bcf604db54470868f3118a60dc4a9ba8813] Merge tag 'leds-next-6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/lee/leds
git bisect bad f5c31bcf604db54470868f3118a60dc4a9ba8813
# good: [8403ce70be339d462892a2b935ae30ee52416f92] Merge tag 'mfd-next-6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd
git bisect good 8403ce70be339d462892a2b935ae30ee52416f92
# good: [2cd0d1db31e78a63553876f8e6a4c9dcc1f9c061] leds: expresswire: Don't depend on NEW_LEDS
git bisect good 2cd0d1db31e78a63553876f8e6a4c9dcc1f9c061
# good: [23749cf3dfff5dcd706183ade1d27198a37b3881] backlight: gpio: Simplify with dev_err_probe()
git bisect good 23749cf3dfff5dcd706183ade1d27198a37b3881
# good: [2c7c70f54f791ece44541a9254c1a73790fd4595] dt-bindings: leds: Add NCP5623 multi-LED Controller
git bisect good 2c7c70f54f791ece44541a9254c1a73790fd4595
# good: [c9128ed7b9edeb2b6f1faec06d96b2fd5bc72cb8] backlight: lm3630a_bl: Simplify probe return on gpio request error
git bisect good c9128ed7b9edeb2b6f1faec06d96b2fd5bc72cb8
# good: [45066c4bbe8ca25f9f282245b84568116c783f1d] leds: ncp5623: Add MS suffix to time defines
git bisect good 45066c4bbe8ca25f9f282245b84568116c783f1d
# good: [f3d8f29d1f59230b8c2a09e6dee7db7bd295e42c] Merge tag 'backlight-next-6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight
git bisect good f3d8f29d1f59230b8c2a09e6dee7db7bd295e42c
# first bad commit: [f5c31bcf604db54470868f3118a60dc4a9ba8813] Merge tag 'leds-next-6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/lee/leds
[greearb@ben-dt5 linux-2.6]$

Thanks,
Ben

