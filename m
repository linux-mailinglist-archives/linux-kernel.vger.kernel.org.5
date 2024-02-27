Return-Path: <linux-kernel+bounces-83733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1E7869DBE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E140F2855B1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61B04EB4D;
	Tue, 27 Feb 2024 17:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="i2K1txuE"
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDFE2836D
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 17:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709055086; cv=none; b=KK2aj8nsM0tn51ve+MFWgUqg9rKIKwX0Td2pH45uDx6PzI48HarPR36HZaHRnGGnT2rHdTAsu4QSLD/bO+ZtY0GwCt4/Tu2SShCFn9PEPqzQvSGZ/M4kh2sUDZ10xzWua5uxeTkbHfhI2r0asF3o3aTswp6Rcc3deQfr2J6r4bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709055086; c=relaxed/simple;
	bh=9QJ0p6m//VqRaNyLV/QrLceScK2lqm09h/eJV1eZ+Ok=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=L1Zk9GGRjEJCoBtpIEOJa8jUHi8Yp1bRxWkN6gVMFBadPt35qiJDSFKrd2PuJm6aEb7+wDI3trpTZD/Qx64a+sfKNSenYWeT1WvxpbQgDwOLpm417w5lE8PT1pXVz+dz1K8MkPk25gpHNZuUZdFJnSn98VB13vKhbMEwEGnDE9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=i2K1txuE; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 58D0CC4006A
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 17:31:22 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 0FC5113C2B0
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 09:31:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 0FC5113C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1709055081;
	bh=9QJ0p6m//VqRaNyLV/QrLceScK2lqm09h/eJV1eZ+Ok=;
	h=Date:To:From:Subject:From;
	b=i2K1txuE7z8O/yxh+kW6GOS9XgG6LdOOsTC8euSdU95LkxRWh3ChAnUNfwhV35pqZ
	 F4cwZA6b6yHvhPUO5tUWoN0X4GWLmeA9Bl7X1wVQY25/I98nnxm5tYmuP2jcZQWGdA
	 TdAs3wUSqiOGhtjsmASw3WWOe7L9USuKrqQIn2Ok=
Message-ID: <73a2db13-1be4-8b86-e46f-5ac423fd3352@candelatech.com>
Date: Tue, 27 Feb 2024 09:31:20 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: LKML <linux-kernel@vger.kernel.org>
From: Ben Greear <greearb@candelatech.com>
Subject: lockdep reports invalid wait context, dmar fault and serial console
 related.
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1709055083-lyFPnjR1URAS
X-MDID-O:
 us5;ut7;1709055083;lyFPnjR1URAS;<greearb@candelatech.com>;c71d53d8b4bf163c84f4470b0e4d7294

Hello,

I saw this splat while running a lockdep kernel.  The DMAR warning is related to mtk7915
driver, but aside from filling logs, it appears to not be a serious problem.  I have also
not seen any obvious actual problems related to the serial console in this case.  Never
the less, maybe someone with knowledge in this area with have a more informed understanding
of how important this is.

[    2.706497] DMAR: DRHD: handling fault status reg 3

[    2.706552] =============================
[    2.706552] [ BUG: Invalid wait context ]
[    2.706553] 6.7.5+ #3 Not tainted
[    2.706554] -----------------------------
[    2.706555] swapper/0/0 is trying to lock:
[    2.706556] ffffffff83db4cf8 (&port_lock_key){-.-.}-{3:3}, at: serial8250_console_write+0x82/0x480
[    2.706563] other info that might help us debug this:
[    2.706563] context-{2:2}
[    2.706564] 4 locks held by swapper/0/0:
[    2.706565]  #0: ffff888108065c70 (&iommu->register_lock){-...}-{2:2}, at: dmar_fault+0x1d/0x310
[    2.706568]  #1: ffffffff8296a480 (console_lock){+.+.}-{0:0}, at: _printk+0x53/0x70
[    2.706572]  #2: ffffffff8296a4d0 (console_srcu){....}-{0:0}, at: console_flush_all+0x84/0x510
[    2.706576]  #3: ffffffff8288a260 (console_owner){-...}-{0:0}, at: console_flush_all+0x1fa/0x510
[    2.706579] stack backtrace:
[    2.706579] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.7.5+ #3
[    2.706581] Hardware name: Default string Default string/SKYBAY, BIOS 5.12 08/04/2020
[    2.706581] Call Trace:
[    2.706582]  <IRQ>
[    2.706583]  dump_stack_lvl+0x57/0x90
[    2.706588]  __lock_acquire+0x9cc/0x2380
[    2.706590]  ? stack_trace_save+0x46/0x70
[    2.706595]  ? save_trace+0x4e/0x330
[    2.706597]  lock_acquire+0xc6/0x2b0
[    2.706598]  ? serial8250_console_write+0x82/0x480
[    2.706600]  _raw_spin_lock_irqsave+0x3f/0x60
[    2.706604]  ? serial8250_console_write+0x82/0x480
[    2.706605]  serial8250_console_write+0x82/0x480
[    2.706606]  ? console_flush_all+0x1fa/0x510
[    2.706608]  ? console_flush_all+0x1e8/0x510
[    2.706610]  ? lock_release+0xc5/0x270
[    2.706612]  console_flush_all+0x222/0x510
[    2.706613]  ? console_flush_all+0x1fa/0x510
[    2.706615]  ? console_flush_all+0x1fa/0x510
[    2.706617]  console_unlock+0x3f/0x140
[    2.706619]  vprintk_emit+0xa1/0x320
[    2.706621]  ? lock_release+0xc5/0x270
[    2.706622]  _printk+0x53/0x70
[    2.706624]  ? ___ratelimit+0x85/0x110
[    2.706626]  dmar_fault+0x2f0/0x310
[    2.706627]  ? find_held_lock+0x2b/0x80
[    2.706628]  __handle_irq_event_percpu+0x7c/0x230
[    2.706630]  handle_irq_event+0x2f/0x70
[    2.706631]  handle_edge_irq+0x7c/0x210
[    2.706634]  __common_interrupt+0x3d/0xe0
[    2.706636]  common_interrupt+0x7d/0xa0
[    2.706639]  </IRQ>
[    2.706639]  <TASK>
[    2.706640]  asm_common_interrupt+0x22/0x40
[    2.706641] RIP: 0010:cpuidle_enter_state+0xf6/0x4f0
[    2.706643] Code: c0 48 0f a3 05 fb fd c0 00 0f 82 f8 02 00 00 31 ff e8 4e 55 30 ff 45 84 ff 0f 85 c8 02 00 00 e8 30 9c 3e ff fb 0f 1f 44 00 00 <45> 85 f6 0f 
88 e7 01 00 00 49 63 d6 48 8d 04 52 48 8d 04 82 49 8d
[    2.706645] RSP: 0018:ffffffff82803e28 EFLAGS: 00000206
[    2.706646] RAX: 0000000000008a3f RBX: ffffe8ffffa262f0 RCX: 000000000000001f
[    2.706647] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff81ee0ef0
[    2.706647] RBP: 0000000000000004 R08: 0000000000000001 R09: 0000000000000001
[    2.706648] R10: ffffffff828254c0 R11: ffffffff82825ed0 R12: ffffffff829ee520
[    2.706649] R13: 00000000a15167b5 R14: 0000000000000004 R15: 0000000000000000
[    2.706650]  ? cpuidle_enter_state+0xf0/0x4f0
[    2.706652]  ? cpuidle_enter_state+0xf0/0x4f0
[    2.706653]  cpuidle_enter+0x24/0x40
[    2.706656]  do_idle+0x1e8/0x240
[    2.706660]  cpu_startup_entry+0x21/0x30
[    2.706662]  rest_init+0xe0/0x180
[    2.706663]  arch_call_rest_init+0x5/0x20
[    2.706667]  start_kernel+0x860/0xa70
[    2.706669]  ? load_ucode_intel_bsp+0x46/0x80
[    2.706671]  x86_64_start_reservations+0x14/0x30
[    2.706674]  x86_64_start_kernel+0x79/0x80
[    2.706676]  secondary_startup_64_no_verify+0x178/0x17b
[    2.706681]  </TASK>
[    2.708867] systemd-journald[267]: /etc/systemd/journald.conf:1: Assignment outside of section. Ignoring.
[    2.710908] DMAR: [DMA Read NO_PASID] Request device [15:00.0] fault addr 0xffff1000 [fault reason 0x06] PTE Read access is not set

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


