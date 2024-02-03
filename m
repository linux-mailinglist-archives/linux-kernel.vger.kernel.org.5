Return-Path: <linux-kernel+bounces-51023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBF4848529
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 11:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC0982885AC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 10:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED4D47F4A;
	Sat,  3 Feb 2024 10:18:29 +0000 (UTC)
Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C075C91E;
	Sat,  3 Feb 2024 10:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.202.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706955508; cv=none; b=gNqgAgkVg7bmTlATPLpYRaPPjokgpRs7GOhc2aYTwTPw7GD0o/DfiXXwQVLsOI/C1XkLoIMZ61FffPBybTMCYRGUp2aOW6gp3SUsZxld3VZOVzLLR879lMIQvnS5OplJRQKRq6wzwO99eWOa46k7u7Fv3Vwva7ku2/0Jlfvz0W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706955508; c=relaxed/simple;
	bh=So5ZpasHClHfJM0XlzZS2+XgZDZjJzwwtLn/vJp0lnE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=scrL5ST/vKmsq4u1ld83uGGF55f7LQoDTkcPnJ4OK8wn3/sgFiG2aHCM8VkmR/qDya2q9kLkJ2Efgchu3PmsDfCErkR+94LzIG5TFP9ZZBMUiw2rH4Wur5W2OOL87qDcBb3L5lrg21AeXRtDMA2F5pQq4ivJyV9l2IiupR0Xd0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com; spf=pass smtp.mailfrom=applied-asynchrony.com; arc=none smtp.client-ip=85.10.202.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=applied-asynchrony.com
Received: from tux.applied-asynchrony.com (p5b2e8fde.dip0.t-ipconnect.de [91.46.143.222])
	by mail.itouring.de (Postfix) with ESMTPSA id D8863D015AA;
	Sat,  3 Feb 2024 11:18:16 +0100 (CET)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
	by tux.applied-asynchrony.com (Postfix) with ESMTP id 8BCAAF01604;
	Sat,  3 Feb 2024 11:18:16 +0100 (CET)
Subject: Re: [PATCH 6.7 000/353] 6.7.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20240203035403.657508530@linuxfoundation.org>
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <9fa210ec-1086-615e-b972-f28a74df7b49@applied-asynchrony.com>
Date: Sat, 3 Feb 2024 11:18:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240203035403.657508530@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 2024-02-03 05:01, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.4 release.
> There are 353 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

On my Zen2-based Thinkpad I now get the trace below on boot; this never
happened before. The boot continues and the system seems usable.

It's out-of-order because apparently there's a workqueue involved,
but most of the information points to the patch called
"xhci-fix-possible-null-pointer-deref-during-xhci-urb.patch".

--snip--

[    0.762299] Hardware name: LENOVO 20U50001GE/20U50001GE, BIOS R19ET32W (1.16 ) 01/26/2021
[    0.762568] Workqueue: usb_hub_wq hub_event
[    0.762838] RIP: 0010:xhci_urb_enqueue+0x267/0x4c0
[    0.763108] Code: 5d 41 5c 41 5d 41 5e 41 5f c3 75 d0 bd ea ff ff ff eb c9 bd ed ff ff ff eb c2 49 8b 85 c8 03 00 00 8b 54 24 04 48 8b 7c 24 10 <48> 8b 70 10 e8 00 13 00 00 49 8b 57 40 0f b7 40 06 0f b7 52 5c 89
[    0.763395] RSP: 0018:ffffc900009cbb28 EFLAGS: 00010246
[    0.763679] RAX: 0000000000000000 RBX: ffff888100e32000 RCX: 0000000000000000
[    0.763965] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888100e32260
[    0.764039] RBP: 0000000000000001 R08: ffff8887ef42ed50 R09: 0000000000000000
[    0.764039] R10: ffff888100daeb00 R11: ffff888103a2a058 R12: ffff888100daeb00
[    0.764039] R13: ffff888100e32000 R14: 0000000000000c00 R15: ffff888103f8d800
[    0.764039] FS:  0000000000000000(0000) GS:ffff8887ef400000(0000) knlGS:0000000000000000
[    0.764039] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.764039] CR2: 0000000000000010 CR3: 0000000004429000 CR4: 0000000000350ef0
[    0.764039] Call Trace:
[    0.764039]  <TASK>
[    0.764039]  ? __die+0x1f/0x60
[    0.764039]  ? page_fault_oops+0x14d/0x410
[    0.764039]  ? prb_read_valid+0x17/0x20
[    0.764039]  ? printk_get_next_message+0x73/0x270
[    0.764039]  ? exc_page_fault+0x63/0x100
[    0.764039]  ? asm_exc_page_fault+0x22/0x30
[    0.764039]  ? xhci_urb_enqueue+0x267/0x4c0
[    0.764039]  ? xhci_urb_enqueue+0xce/0x4c0
[    0.764039]  usb_hcd_submit_urb+0xa9/0xa10
[    0.764039]  ? __schedule+0x300/0xda0
[    0.764039]  ? usleep_range_state+0x60/0x60
[    0.764039]  ? usleep_range_state+0x60/0x60
[    0.764039]  ? __cond_resched+0x16/0x40
[    0.764039]  usb_start_wait_urb+0x55/0xd0
[    0.764039]  usb_control_msg+0xcb/0x120
[    0.764039]  get_bMaxPacketSize0+0x5e/0xc0
[    0.764039]  hub_port_init+0x1fd/0xde0
[    0.764039]  hub_event+0xf89/0x1810
[    0.764039]  ? lock_timer_base+0x61/0x80
[    0.764039]  process_one_work+0x166/0x300
[    0.764039]  worker_thread+0x2e2/0x400
[    0.764039]  ? process_one_work+0x300/0x300
[    0.764039]  kthread+0xc9/0xf0
[    0.764039]  ? kthread_complete_and_exit+0x20/0x20
[    0.764039]  ret_from_fork+0x2d/0x50
[    0.764039]  ? kthread_complete_and_exit+0x20/0x20
[    0.764039]  ret_from_fork_asm+0x11/0x20
[    0.764039]  </TASK>
[    0.764039] Modules linked in:
[    0.764039] CR2: 0000000000000010
[    0.764039] ---[ end trace 0000000000000000 ]---
[    0.764039] RIP: 0010:xhci_urb_enqueue+0x267/0x4c0
[    0.764039] Code: 5d 41 5c 41 5d 41 5e 41 5f c3 75 d0 bd ea ff ff ff eb c9 bd ed ff ff ff eb c2 49 8b 85 c8 03 00 00 8b 54 24 04 48 8b 7c 24 10 <48> 8b 70 10 e8 00 13 00 00 49 8b 57 40 0f b7 40 06 0f b7 52 5c 89
[    0.764039] RSP: 0018:ffffc900009cbb28 EFLAGS: 00010246
[    0.764039] RAX: 0000000000000000 RBX: ffff888100e32000 RCX: 0000000000000000
[    0.764039] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888100e32260
[    0.764039] RBP: 0000000000000001 R08: ffff8887ef42ed50 R09: 0000000000000000
[    0.764039] R10: ffff888100daeb00 R11: ffff888103a2a058 R12: ffff888100daeb00
[    0.764039] R13: ffff888100e32000 R14: 0000000000000c00 R15: ffff888103f8d800
[    0.764039] FS:  0000000000000000(0000) GS:ffff8887ef400000(0000) knlGS:0000000000000000
[    0.764039] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.764039] CR2: 0000000000000010 CR3: 0000000004429000 CR4: 0000000000350ef0
[    0.764039] note: kworker/0:2[136] exited with irqs disabled
[    0.778061] usb 4-3: new high-speed USB device number 2 using xhci_hcd
[    0.933575] usb 4-3: New USB device found, idVendor=13d3, idProduct=56fb, bcdDevice=60.01
[    0.933871] usb 4-3: New USB device strings: Mfr=3, Product=1, SerialNumber=2
[    0.934152] usb 4-3: Product: Integrated Camera
[    0.934425] usb 4-3: Manufacturer: Azurewave
[    0.934696] usb 4-3: SerialNumber: 0000
[    1.059668] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input3
[    1.059714] ACPI: button: Power Button [PWRB]
[    1.059750] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input4
[    1.067025] usb 4-4: new full-speed USB device number 3 using xhci_hcd
[    1.067067] BUG: kernel NULL pointer dereference, address: 0000000000000010
[    1.067285] ACPI: video: Video Device [VGA] (multi-head: yes  rom: no  post: no)
[    1.067413] #PF: supervisor read access in kernel mode
[    1.068338] #PF: error_code(0x0000) - not-present page
[    1.068608] PGD 0 P4D 0
[    1.068861] Oops: 0000 [#2] SMP
[    1.069114] CPU: 0 PID: 186 Comm: kworker/0:4 Tainted: G      D            6.7.4 #1
[    1.069268] ACPI: AC: AC Adapter [AC] (on-line)
[    1.069430] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:08/LNXVIDEO:00/input/input5
[    1.069626] Hardware name: LENOVO 20U50001GE/20U50001GE, BIOS R19ET32W (1.16 ) 01/26/2021
[    1.070386] Workqueue: usb_hub_wq hub_event
[    1.070386] RIP: 0010:xhci_urb_enqueue+0x267/0x4c0
[    1.070386] Code: 5d 41 5c 41 5d 41 5e 41 5f c3 75 d0 bd ea ff ff ff eb c9 bd ed ff ff ff eb c2 49 8b 85 c8 03 00 00 8b 54 24 04 48 8b 7c 24 10 <48> 8b 70 10 e8 00 13 00 00 49 8b 57 40 0f b7 40 06 0f b7 52 5c 89
[    1.070386] RSP: 0018:ffffc90000677b28 EFLAGS: 00010246
[    1.073106] ACPI: battery: Slot [BAT0] (battery present)
[    1.070386] RAX: 0000000000000000 RBX: ffff888100167000 RCX: 0000000000000000
[    1.070386] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888100167260
[    1.070386] RBP: 0000000000000001 R08: ffff8887ef42ed50 R09: 0000000000000000
[    1.070386] R10: ffff8881043e0000 R11: ffff888103a2c858 R12: ffff8881043e0000
[    1.070386] R13: ffff888100167000 R14: 0000000000000c00 R15: ffff888103f8d680
[    1.070386] FS:  0000000000000000(0000) GS:ffff8887ef400000(0000) knlGS:0000000000000000
[    1.070386] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.070386] CR2: 0000000000000010 CR3: 0000000108214000 CR4: 0000000000350ef0
[    1.070386] Call Trace:
[    1.070386]  <TASK>
[    1.070386]  ? __die+0x1f/0x60
[    1.070386]  ? page_fault_oops+0x14d/0x410
[    1.070386]  ? prb_read_valid+0x17/0x20
[    1.070386]  ? printk_get_next_message+0x73/0x270
[    1.070386]  ? exc_page_fault+0x63/0x100
[    1.070386]  ? asm_exc_page_fault+0x22/0x30
[    1.070386]  ? xhci_urb_enqueue+0x267/0x4c0
[    1.070386]  ? xhci_urb_enqueue+0xce/0x4c0
[    1.070386]  usb_hcd_submit_urb+0xa9/0xa10
[    1.070386]  ? __schedule+0x300/0xda0
[    1.070386]  ? usleep_range_state+0x60/0x60
[    1.070386]  ? usleep_range_state+0x60/0x60
[    1.070386]  ? __cond_resched+0x16/0x40
[    1.070386]  usb_start_wait_urb+0x55/0xd0
[    1.070386]  usb_control_msg+0xcb/0x120
[    1.070386]  get_bMaxPacketSize0+0x5e/0xc0
[    1.070386]  hub_port_init+0x1fd/0xde0
[    1.070386]  hub_event+0xf89/0x1810
[    1.070386]  ? __schedule+0x300/0xda0
[    1.070386]  process_one_work+0x166/0x300
[    1.070386]  worker_thread+0x2e2/0x400
[    1.070386]  ? process_one_work+0x300/0x300
[    1.070386]  ? process_one_work+0x300/0x300
[    1.070386]  kthread+0xc9/0xf0
[    1.070386]  ? kthread_complete_and_exit+0x20/0x20
[    1.070386]  ret_from_fork+0x2d/0x50
[    1.070386]  ? kthread_complete_and_exit+0x20/0x20
[    1.070386]  ret_from_fork_asm+0x11/0x20
[    1.070386]  </TASK>
[    1.070386] Modules linked in: battery ac video wmi i2c_scmi button(+)
[    1.070386] CR2: 0000000000000010
[    1.070386] ---[ end trace 0000000000000000 ]---
[    1.070386] RIP: 0010:xhci_urb_enqueue+0x267/0x4c0
[    1.070386] Code: 5d 41 5c 41 5d 41 5e 41 5f c3 75 d0 bd ea ff ff ff eb c9 bd ed ff ff ff eb c2 49 8b 85 c8 03 00 00 8b 54 24 04 48 8b 7c 24 10 <48> 8b 70 10 e8 00 13 00 00 49 8b 57 40 0f b7 40 06 0f b7 52 5c 89
[    1.070386] RSP: 0018:ffffc900009cbb28 EFLAGS: 00010246
[    1.070386] RAX: 0000000000000000 RBX: ffff888100e32000 RCX: 0000000000000000
[    1.070386] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888100e32260
[    1.070386] RBP: 0000000000000001 R08: ffff8887ef42ed50 R09: 0000000000000000
[    1.070386] R10: ffff888100daeb00 R11: ffff888103a2a058 R12: ffff888100daeb00
[    1.070386] R13: ffff888100e32000 R14: 0000000000000c00 R15: ffff888103f8d800
[    1.070386] FS:  0000000000000000(0000) GS:ffff8887ef400000(0000) knlGS:0000000000000000
[    1.070386] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.070386] CR2: 0000000000000010 CR3: 0000000108214000 CR4: 0000000000350ef0
[    1.070386] note: kworker/0:4[186] exited with irqs disabled
[    1.089955] ACPI: button: Lid Switch [LID]

--snip--

I'll try reverting the patch in question.

-h

