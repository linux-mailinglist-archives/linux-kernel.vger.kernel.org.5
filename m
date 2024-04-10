Return-Path: <linux-kernel+bounces-138970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 084CC89FCC9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1B9E28521A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F41817B4ED;
	Wed, 10 Apr 2024 16:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="r+aUGJgf"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA8617994F;
	Wed, 10 Apr 2024 16:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712766316; cv=none; b=UiWdsis9emmW2j1uJn1D9cWA8hd5uD4iTuRyrMSDa5Z0Coggxkp6Rrk9hNzPwrRion16VAZZ8JRSg/XLpbboUiEfNTetvWNxIZeMRblM6Dq5wsPzOaRrv/ZDapU6eLaM9bFlKj539ukoiziv0odgg5EJci1E8tnhOjUHaGi/kw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712766316; c=relaxed/simple;
	bh=2gJA4rHfL9dqsK+eNOjwMwvOJeLBWc3X+6nAzu05HEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ufVyR5YDeVSWWjb2ig3T4Tsa8RLDccw2RMD3cu4JUQ4vhYyACpQINu/bwLV9HhyeHpOsZue5BjZggkIwSWvfjoEtsO3lp6xuw7pRjb27U5Fs6JUykg0eyArDjWhKpWcRdkXlxcOeBpBtETGkzSzQL2kbwfmpwwuWojYLh+pGn8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=r+aUGJgf; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=saGSvct2JZoYZcslUnIdtJoxuWNfItAItxmptfx5t6M=;
	t=1712766314; x=1713198314; b=r+aUGJgf8xm3u77kE9ptxkegeVph9f2z7n3wpEwnr4yuKVd
	19aNP1xkwuX3slHGqyVNozyy0fC06js0jnO4unvgUlhcGumJ764UOdCqbbYHQZzMgSAJMw+XnsX2R
	yxZ4dCRY5TB/grqagu2czxg5MGnqeNWbiS/+N17n0O4m1bUsTf0aUB2q3Gjw+ZnNib2vKU/slnUyi
	9V62ZswmwtkZmvcPQepZubdEMoa9T9wWNRXsewFNw5hS9hoQfVS/G1l12ZUJ5/t5yzEj8R4h8GCMU
	X1vu6FfQqQXCq7CQUBPrwHqA8Nuji/RuT1b/tO9zfMebCvO9r/utaB5lOnjOy0Uw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rual2-0000tR-J1; Wed, 10 Apr 2024 18:25:08 +0200
Message-ID: <842fde07-d532-4c9e-8b4e-3447509e040e@leemhuis.info>
Date: Wed, 10 Apr 2024 18:25:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Call Trace when adding vCPU to guest
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, xiangfeix.ma@intel.com,
 Dongli Zhang <dongli.zhang@oracle.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <b4929457-23b8-4ad4-8324-cc1cde5ecece@leemhuis.info>
 <87bk6h49tq.ffs@tglx> <b9e54d33-7f5e-45a5-b215-d3f9daef5a8e@leemhuis.info>
 <871q7d46e7.ffs@tglx>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <871q7d46e7.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1712766314;ba62f412;
X-HE-SMSGID: 1rual2-0000tR-J1

On 10.04.24 16:52, Thomas Gleixner wrote:
> On Wed, Apr 10 2024 at 15:48, Thorsten Leemhuis wrote:
>> On 10.04.24 15:38, Thomas Gleixner wrote:
>>> On Wed, Apr 10 2024 at 09:34, Linux regression tracking (Thorsten Leemhuis) wrote:
>>>> To quote from https://bugzilla.kernel.org/show_bug.cgi?id=218698
>>> [...]
>>>>> When hot adding a vCPU to the guest, the guest happens Call Trace and reboot.
>>> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/urgent&id=a9025cd1c673a8d6eefc79d911075b8b452eba8f
>>> It'll be in rc4
>> Ahh, splendid, thx for replying! Ciao, Thorsten
>>
>> #regzbot fix: a9025cd1c673a8d6eefc79d911075b8b452eb
> 
> Ooops. No!
> [...] 

Ha, happens. :-D

> generic_processor_info() was removed during the 6.9 merge window with
> the topology rework before v6.9-rc1.
> 
> So the guest kernel _cannot_ be v6.9-rc2 at all.

Ma, XiangfeiX (the reporter) is CCed and might be able to clarify.

Meanwhile Dongli Zhang (now CCed, too) also joined the bug report and
added this comment:

"""
I can reproduce as well. But the callstack is different. It finally
reaches at topo_set_cpuids().

/home/zhang/kvm/qemu-8.2.0/build/qemu-system-x86_64 \
-hda disk.qcow2 -m 8G -smp 4,maxcpus=128 -vnc :5 -enable-kvm -cpu host \
-netdev user,id=user0,hostfwd=tcp::5025-:22 \
-device virtio-net-pci,netdev=user0,id=net0,mac=12:14:10:12:14:16,bus=pci.0,addr=0x3 \
-kernel /home/zhang/img/debug/mainline-linux/arch/x86_64/boot/bzImage \
-append "root=/dev/sda3 init=/sbin/init text loglevel=7 console=ttyS0" \
-monitor stdio

(qemu) device_add driver=host-x86_64-cpu,socket-id=0,core-id=4,thread-id=0


[   27.060885] BUG: unable to handle page fault for address: ffffffff83a69778
[   27.061954] #PF: supervisor write access in kernel mode
[   27.062604] #PF: error_code(0x0003) - permissions violation
[   27.063286] PGD 40c49067 P4D 40c49067 PUD 40c4a063 PMD 102213063 PTE 8000000040a69021
[   27.064273] Oops: 0003 [#1] PREEMPT SMP PTI
[   27.064799] CPU: 2 PID: 39 Comm: kworker/u256:1 Not tainted 6.9.0-rc3 #1
[   27.065611] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[   27.066992] Workqueue: kacpi_hotplug acpi_hotplug_work_fn
[   27.067669] RIP: 0010:topo_set_cpuids+0x26/0x70
[   27.068242] Code: 90 90 90 90 48 8b 05 d9 bd da 01 48 85 c0 74 31 89 ff 48 8d 04 b8 89 30 48 8b 05 bd bd da 01 48 85 c0 74 3c 48 8d 04 b8 89 10 <f0> 48 0f ab 3d 79 9e 97 01 f0 48 0f ab 3d 40 03 df 01 c3 cc cc cc
[   27.070471] RSP: 0018:ffffc3980034bc28 EFLAGS: 00010286
[   27.071130] RAX: ffffa0bbb6f15160 RBX: 0000000000000004 RCX: 0000000000000040
[   27.072004] RDX: 0000000000000004 RSI: 0000000000000004 RDI: 0000000000000004
[   27.072858] RBP: ffffa0ba80d68540 R08: 000000000001d4c0 R09: 0000000000000001
[   27.073713] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000004
[   27.074565] R13: ffffa0ba883b6c10 R14: ffffa0ba809a9040 R15: 0000000000000000
[   27.075418] FS:  0000000000000000(0000) GS:ffffa0bbb6e80000(0000) knlGS:0000000000000000
[   27.076424] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   27.077121] CR2: ffffffff83a69778 CR3: 000000010f946006 CR4: 0000000000370ef0
[   27.077976] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   27.078830] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   27.079685] Call Trace:
[   27.080031]  <TASK>
[   27.080341]  ? __die+0x1f/0x70
[   27.080755]  ? page_fault_oops+0x17b/0x490
[   27.081305]  ? search_exception_tables+0x37/0x50
[   27.081897]  ? exc_page_fault+0xba/0x160
[   27.082402]  ? asm_exc_page_fault+0x26/0x30
[   27.082929]  ? topo_set_cpuids+0x26/0x70
[   27.083432]  topology_hotplug_apic+0x54/0xa0
[   27.083979]  acpi_map_cpu+0x1c/0x80
[   27.084437]  acpi_processor_add+0x361/0x630
[   27.084968]  acpi_bus_attach+0x151/0x230
[   27.085473]  ? __pfx_acpi_dev_for_one_check+0x10/0x10
[   27.086091]  device_for_each_child+0x68/0xb0
[   27.086638]  acpi_dev_for_each_child+0x37/0x60
[   27.087197]  ? __pfx_acpi_bus_attach+0x10/0x10
[   27.087757]  acpi_bus_attach+0x89/0x230
[   27.088251]  acpi_bus_scan+0x77/0x1f0
[   27.088753]  acpi_scan_rescan_bus+0x3c/0x70
[   27.089300]  acpi_device_hotplug+0x3a3/0x480
[   27.089840]  acpi_hotplug_work_fn+0x19/0x30
[   27.090369]  process_one_work+0x14c/0x360
[   27.090880]  worker_thread+0x2c5/0x3d0
[   27.091387]  ? __pfx_worker_thread+0x10/0x10
[   27.091941]  kthread+0xd3/0x100
[   27.092361]  ? __pfx_kthread+0x10/0x10
[   27.092843]  ret_from_fork+0x2f/0x50
[   27.093309]  ? __pfx_kthread+0x10/0x10
[   27.093788]  ret_from_fork_asm+0x1a/0x30
[   27.094293]  </TASK>
[   27.094601] Modules linked in:
[   27.095007] CR2: ffffffff83a69778
[   27.095444] ---[ end trace 0000000000000000 ]---
[   27.096018] RIP: 0010:topo_set_cpuids+0x26/0x70
[   27.096590] Code: 90 90 90 90 48 8b 05 d9 bd da 01 48 85 c0 74 31 89 ff 48 8d 04 b8 89 30 48 8b 05 bd bd da 01 48 85 c0 74 3c 48 8d 04 b8 89 10 <f0> 48 0f ab 3d 79 9e 97 01 f0 48 0f ab 3d 40 03 df 01 c3 cc cc cc
[   27.098808] RSP: 0018:ffffc3980034bc28 EFLAGS: 00010286
[   27.099452] RAX: ffffa0bbb6f15160 RBX: 0000000000000004 RCX: 0000000000000040
[   27.100305] RDX: 0000000000000004 RSI: 0000000000000004 RDI: 0000000000000004
[   27.101153] RBP: ffffa0ba80d68540 R08: 000000000001d4c0 R09: 0000000000000001
[   27.102141] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000004
[   27.102995] R13: ffffa0ba883b6c10 R14: ffffa0ba809a9040 R15: 0000000000000000
[   27.103851] FS:  0000000000000000(0000) GS:ffffa0bbb6e80000(0000) knlGS:0000000000000000
[   27.104857] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   27.105559] CR2: ffffffff83a69778 CR3: 000000010f946006 CR4: 0000000000370ef0
[   27.106411] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   27.107264] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

----------------------

I am not able to reproduce with the below:

x86/topology: Don't update cpu_possible_map in topo_set_cpuids()
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/urgent&id=a9025cd1c673a8d6eefc79d911075b8b452eba8f
"""

Ciao, Thorsten (who hopes that people will continue on the list now,
as playing man-in-the middle is tedious)

