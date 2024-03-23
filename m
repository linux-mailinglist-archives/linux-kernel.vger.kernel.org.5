Return-Path: <linux-kernel+bounces-112478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A1D887A51
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 21:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07BC8B214C8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 20:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165A51EB33;
	Sat, 23 Mar 2024 20:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="B9WMiUm6";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="Y3m31w5e"
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE92211C;
	Sat, 23 Mar 2024 20:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.235.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711226416; cv=none; b=B9wpp5QsbUygChq3cDvFsL56wXZ/Hhi/WEV4hJ9/MWogR3UBcFAG0WANZz9Q1Hlnj1DrMsAWAQMmW+U/UhgETaJNo3R/FGNdCynbKjJUbg66GuiSoipegkRFt9914YJgqoy/LioWgiGGvjvi8wEaGUVK2nWulnCNXZZms7k7chs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711226416; c=relaxed/simple;
	bh=rpEsb7IaKxpf3OxuRokCYgmS1wgm01Ccc75kG3vFDQc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=cWAas2RRQ7maV2AEbjHd6HpMSQ1/k9Vzit45EoIsKf6DEeSLb9NH+jlJyPino8wAG3+TXlGeiEgCKR5vY2a/cwCw5AMX0V24jqi6VQLzXwksBQNXZe9T/bKCWK+xp6Z6zSe0NMhF29f5OYgGNeUtoKGZ/PPaR2EV1f38Mh3Cnqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr; spf=pass smtp.mailfrom=alu.unizg.hr; dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b=B9WMiUm6; dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b=Y3m31w5e; arc=none smtp.client-ip=161.53.235.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alu.unizg.hr
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 59C4260186;
	Sat, 23 Mar 2024 21:40:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1711226407; bh=rpEsb7IaKxpf3OxuRokCYgmS1wgm01Ccc75kG3vFDQc=;
	h=Date:To:Cc:From:Subject:From;
	b=B9WMiUm6g7eFOpWoJ8cF00CqtyZ7oCVaNMDMDoJthzzsMIeEKiD4FqIz2VbnnSnIa
	 KV2GuvI6uvZ8k5m5fflyhWeB/KDAFEvfPfPON59QPn/JDOmeNv1EV+vuHKi8mad4B9
	 kajWmmz0ht8ZWaIXtbaiMSEnO5KgD2r3qrGuR4tMrxrOA4FWx2+PJ9Ql7MMyer4+7J
	 OLGwyszfansvaSYXTtzA7vVeVdBLAbD2mqmVJxrNSQdounbYTmSVRiKwndtcaVp+/m
	 DmFtPkh/LR/uZB5io6ygPTw7em6WkRxhUfJXZPlzC9DZlOMTHSkNAoFP/5kgaBbpBl
	 H4OAr+8LZsReg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id al9ctxFKZIc0; Sat, 23 Mar 2024 21:39:43 +0100 (CET)
Received: from [192.168.178.20] (dh207-43-75.xnet.hr [88.207.43.75])
	by domac.alu.hr (Postfix) with ESMTPSA id BB38B60182;
	Sat, 23 Mar 2024 21:39:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1711226383; bh=rpEsb7IaKxpf3OxuRokCYgmS1wgm01Ccc75kG3vFDQc=;
	h=Date:To:Cc:From:Subject:From;
	b=Y3m31w5eT9FxRWmPpKrVcoujYSHMjHDKcKrATuYBBOBF5Hhdx+UQB9z8wnJFvtJAb
	 FcdT0h09Zk/SW/G02rx148VYX/dKVnZ64dxdneKiPXStMqOIcngkYRctYImplOQq5u
	 e6gxYtVsSpytYbcLvD1B19pMXiw9EYBRpil1ObWgtjseD/7kmKjtAcdZ9QNgvGRjKG
	 c0kjRMn3Xw9JF1WmUWkM0bU5goW0Cr6JjZd6ipCDPtGdh/dIVuGxEx1plNYk/Vg7QB
	 iM/JRPXAqDpEQt0JnJeqgSTxiquB/EcgTHwEg3iNyzBLyDxPHScRfneZP39El+Wjln
	 Cfu5MACAmtzdQ==
Message-ID: <662c65f1-cb22-4916-bcd4-257cb574b207@alu.unizg.hr>
Date: Sat, 23 Mar 2024 21:39:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-modules@vger.kernel.org
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org
From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: [BUG][KMEMLEAK] modprobe: unreferenced object (size 16)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On the Ubuntu 22.04 LTS system, with recent iproute2-next toolsvand build 6.8-11743-ga4145ce1e7bc,
kmemleak system reported the following memory leaks:

unreferenced object 0xffff9da692e7e920 (size 16):
comm "modprobe", pid 2248188, jiffies 4358296226
hex dump (first 16 bytes):
68 6d 6d 5f 64 6d 69 72 72 6f 72 30 00 00 00 00  hmm_dmirror0....
backtrace (crc d64cce1d):
kmemleak_alloc (/home/marvin/linux/kernel/linux_torvalds/mm/kmemleak.c:1045)
__kmalloc_node_track_caller (/home/marvin/linux/kernel/linux_torvalds/./include/linux/kmemleak.h:42 /home/marvin/linux/kernel/linux_torvalds/mm/slub.c:3802 /home/marvin/linux/kernel/linux_torvalds/mm/slub.c:3845 /home/marvin/linux/kernel/linux_torvalds/mm/slub.c:3965 /home/marvin/linux/kernel/linux_torvalds/mm/slub.c:3986)
kvasprintf (/home/marvin/linux/kernel/linux_torvalds/lib/kasprintf.c:25)
kvasprintf_const (/home/marvin/linux/kernel/linux_torvalds/lib/kasprintf.c:50)
kobject_set_name_vargs (/home/marvin/linux/kernel/linux_torvalds/lib/kobject.c:274)
dev_set_name (/home/marvin/linux/kernel/linux_torvalds/drivers/base/core.c:3445)
drr_init (/home/marvin/linux/kernel/linux_torvalds/net/sched/sch_drr.c:233) sch_drr
do_one_initcall (/home/marvin/linux/kernel/linux_torvalds/init/main.c:1238)
do_init_module (/home/marvin/linux/kernel/linux_torvalds/kernel/module/main.c:2538)
load_module (/home/marvin/linux/kernel/linux_torvalds/kernel/module/main.c:3001)
init_module_from_file (/home/marvin/linux/kernel/linux_torvalds/kernel/module/main.c:3168)
idempotent_init_module (/home/marvin/linux/kernel/linux_torvalds/kernel/module/main.c:3185)
__x64_sys_finit_module (/home/marvin/linux/kernel/linux_torvalds/./include/linux/file.h:47 /home/marvin/linux/kernel/linux_torvalds/kernel/module/main.c:3207 /home/marvin/linux/kernel/linux_torvalds/kernel/module/main.c:3189 /home/marvin/linux/kernel/linux_torvalds/kernel/module/main.c:3189)
do_syscall_64 (/home/marvin/linux/kernel/linux_torvalds/arch/x86/entry/common.c:52 /home/marvin/linux/kernel/linux_torvalds/arch/x86/entry/common.c:83)
entry_SYSCALL_64_after_hwframe (/home/marvin/linux/kernel/linux_torvalds/arch/x86/entry/entry_64.S:129)
unreferenced object 0xffff9d9b0080bf00 (size 256):
comm "modprobe", pid 2248188, jiffies 4358296226
hex dump (first 32 bytes):
00 00 00 00 00 00 00 00 08 bf 80 00 9b 9d ff ff  ................
08 bf 80 00 9b 9d ff ff 00 d9 80 af ff ff ff ff  ................
backtrace (crc 31d67378):
kmemleak_alloc (/home/marvin/linux/kernel/linux_torvalds/mm/kmemleak.c:1045)
kmalloc_trace (/home/marvin/linux/kernel/linux_torvalds/./include/linux/kmemleak.h:42 /home/marvin/linux/kernel/linux_torvalds/mm/slub.c:3802 /home/marvin/linux/kernel/linux_torvalds/mm/slub.c:3845 /home/marvin/linux/kernel/linux_torvalds/mm/slub.c:3992)
device_add (/home/marvin/linux/kernel/linux_torvalds/drivers/base/core.c:3484 /home/marvin/linux/kernel/linux_torvalds/drivers/base/core.c:3535)
cdev_device_add (/home/marvin/linux/kernel/linux_torvalds/fs/char_dev.c:557)
drr_init (/home/marvin/linux/kernel/linux_torvalds/./include/linux/list.h:195 /home/marvin/linux/kernel/linux_torvalds/./include/linux/list.h:218 /home/marvin/linux/kernel/linux_torvalds/./include/linux/list.h:229 /home/marvin/linux/kernel/linux_torvalds/net/sched/sch_drr.c:434) sch_drr
do_one_initcall (/home/marvin/linux/kernel/linux_torvalds/init/main.c:1238)
do_init_module (/home/marvin/linux/kernel/linux_torvalds/kernel/module/main.c:2538)
load_module (/home/marvin/linux/kernel/linux_torvalds/kernel/module/main.c:3001)
init_module_from_file (/home/marvin/linux/kernel/linux_torvalds/kernel/module/main.c:3168)
idempotent_init_module (/home/marvin/linux/kernel/linux_torvalds/kernel/module/main.c:3185)
__x64_sys_finit_module (/home/marvin/linux/kernel/linux_torvalds/./include/linux/file.h:47 /home/marvin/linux/kernel/linux_torvalds/kernel/module/main.c:3207 /home/marvin/linux/kernel/linux_torvalds/kernel/module/main.c:3189 /home/marvin/linux/kernel/linux_torvalds/kernel/module/main.c:3189)
do_syscall_64 (/home/marvin/linux/kernel/linux_torvalds/arch/x86/entry/common.c:52 /home/marvin/linux/kernel/linux_torvalds/arch/x86/entry/common.c:83)
entry_SYSCALL_64_after_hwframe (/home/marvin/linux/kernel/linux_torvalds/arch/x86/entry/entry_64.S:129)
unreferenced object 0xffff9da692e7ee90 (size 16):
comm "modprobe", pid 2248188, jiffies 4358296235
hex dump (first 16 bytes):
68 6d 6d 5f 64 6d 69 72 72 6f 72 31 00 00 00 00  hmm_dmirror1....
backtrace (crc eb2ce7ad):
kmemleak_alloc (/home/marvin/linux/kernel/linux_torvalds/mm/kmemleak.c:1045)
__kmalloc_node_track_caller (/home/marvin/linux/kernel/linux_torvalds/./include/linux/kmemleak.h:42 /home/marvin/linux/kernel/linux_torvalds/mm/slub.c:3802 /home/marvin/linux/kernel/linux_torvalds/mm/slub.c:3845 /home/marvin/linux/kernel/linux_torvalds/mm/slub.c:3965 /home/marvin/linux/kernel/linux_torvalds/mm/slub.c:3986)
kvasprintf (/home/marvin/linux/kernel/linux_torvalds/lib/kasprintf.c:25)
kvasprintf_const (/home/marvin/linux/kernel/linux_torvalds/lib/kasprintf.c:50)
kobject_set_name_vargs (/home/marvin/linux/kernel/linux_torvalds/lib/kobject.c:274)
dev_set_name (/home/marvin/linux/kernel/linux_torvalds/drivers/base/core.c:3445)
drr_init (/home/marvin/linux/kernel/linux_torvalds/net/sched/sch_drr.c:233) sch_drr
do_one_initcall (/home/marvin/linux/kernel/linux_torvalds/init/main.c:1238)
do_init_module (/home/marvin/linux/kernel/linux_torvalds/kernel/module/main.c:2538)
load_module (/home/marvin/linux/kernel/linux_torvalds/kernel/module/main.c:3001)
init_module_from_file (/home/marvin/linux/kernel/linux_torvalds/kernel/module/main.c:3168)
idempotent_init_module (/home/marvin/linux/kernel/linux_torvalds/kernel/module/main.c:3185)
__x64_sys_finit_module (/home/marvin/linux/kernel/linux_torvalds/./include/linux/file.h:47 /home/marvin/linux/kernel/linux_torvalds/kernel/module/main.c:3207 /home/marvin/linux/kernel/linux_torvalds/kernel/module/main.c:3189 /home/marvin/linux/kernel/linux_torvalds/kernel/module/main.c:3189)
do_syscall_64 (/home/marvin/linux/kernel/linux_torvalds/arch/x86/entry/common.c:52 /home/marvin/linux/kernel/linux_torvalds/arch/x86/entry/common.c:83)
entry_SYSCALL_64_after_hwframe (/home/marvin/linux/kernel/linux_torvalds/arch/x86/entry/entry_64.S:129)
unreferenced object 0xffff9d9b0080be00 (size 256):
comm "modprobe", pid 2248188, jiffies 4358296235
hex dump (first 32 bytes):
00 00 00 00 00 00 00 00 08 be 80 00 9b 9d ff ff  ................
08 be 80 00 9b 9d ff ff 00 d9 80 af ff ff ff ff  ................
backtrace (crc e1a8857):
kmemleak_alloc (/home/marvin/linux/kernel/linux_torvalds/mm/kmemleak.c:1045)
kmalloc_trace (/home/marvin/linux/kernel/linux_torvalds/./include/linux/kmemleak.h:42 /home/marvin/linux/kernel/linux_torvalds/mm/slub.c:3802 /home/marvin/linux/kernel/linux_torvalds/mm/slub.c:3845 /home/marvin/linux/kernel/linux_torvalds/mm/slub.c:3992)
device_add (/home/marvin/linux/kernel/linux_torvalds/drivers/base/core.c:3484 /home/marvin/linux/kernel/linux_torvalds/drivers/base/core.c:3535)
cdev_device_add (/home/marvin/linux/kernel/linux_torvalds/fs/char_dev.c:557)
drr_init (/home/marvin/linux/kernel/linux_torvalds/./include/linux/list.h:195 /home/marvin/linux/kernel/linux_torvalds/./include/linux/list.h:218 /home/marvin/linux/kernel/linux_torvalds/./include/linux/list.h:229 /home/marvin/linux/kernel/linux_torvalds/net/sched/sch_drr.c:434) sch_drr
do_one_initcall (/home/marvin/linux/kernel/linux_torvalds/init/main.c:1238)
do_init_module (/home/marvin/linux/kernel/linux_torvalds/kernel/module/main.c:2538)
load_module (/home/marvin/linux/kernel/linux_torvalds/kernel/module/main.c:3001)
init_module_from_file (/home/marvin/linux/kernel/linux_torvalds/kernel/module/main.c:3168)
idempotent_init_module (/home/marvin/linux/kernel/linux_torvalds/kernel/module/main.c:3185)
__x64_sys_finit_module (/home/marvin/linux/kernel/linux_torvalds/./include/linux/file.h:47 /home/marvin/linux/kernel/linux_torvalds/kernel/module/main.c:3207 /home/marvin/linux/kernel/linux_torvalds/kernel/module/main.c:3189 /home/marvin/linux/kernel/linux_torvalds/kernel/module/main.c:3189)
do_syscall_64 (/home/marvin/linux/kernel/linux_torvalds/arch/x86/entry/common.c:52 /home/marvin/linux/kernel/linux_torvalds/arch/x86/entry/common.c:83)
entry_SYSCALL_64_after_hwframe (/home/marvin/linux/kernel/linux_torvalds/arch/x86/entry/entry_64.S:129)

Unless this is a false positive (which I am unable to judge), I hope this will help catch the leak.

Best regards,
Mirsad Todorovac


