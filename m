Return-Path: <linux-kernel+bounces-133225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA85889A0CA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51052B23592
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD1816F8F8;
	Fri,  5 Apr 2024 15:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4KMGBGA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FB616F836;
	Fri,  5 Apr 2024 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712330110; cv=none; b=R/Bk7GPYiHRkO5GDOqlhBy6ebfq1DGBzfHcZz0Y5bs/BgY05szc9ZzUhfCvkU3lQCYv00etEG0YHWFZqbYW4KAkR9NbYYO/QaobdrhzI+/3lcWgxpj/dqHztoSLLH7OHXw2BKQkG1hg0nn5tshjkdgNuZLWlGkYZu5A6wL5FGPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712330110; c=relaxed/simple;
	bh=/LdsrP494psWcbVKzb4oeMdYx37H9n0G7HUYFd7B4nY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=g2n/H7H7Ia4ZNMQ9s49FEiE/QwNKFmEzPmvWRtBjCaKNMjLh8xroa/pt1RoGVduoXhRGXSnljnlA2QQ/L7yb3JxFi2GYy7Cow2nQFiJ9qATutKJut0bMoYx4wZrhtcmXjolDnO10aQeflfRyVeiy4Ll7qyjSGXZywH0Rw+NbGkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4KMGBGA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FFCEC433F1;
	Fri,  5 Apr 2024 15:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712330109;
	bh=/LdsrP494psWcbVKzb4oeMdYx37H9n0G7HUYFd7B4nY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=n4KMGBGA0SEnhwr+GQ02RaDjoJRvjyXCrFj3iJZAbb6cOWle+jrJch3E3gkzvQY7d
	 L963m+IicpgEH4itjW2qvA+xJ1L7O7UG9oDLYJd6yuuVNd0jQpjBwjDKOHb32ECZ12
	 srT9JrqB709WIxbH/76B1hLJhAwTbTL/eu8BTgPTZaoU7e63sYFy+9OxsBAS/4sY5B
	 JFyNJYKqP5oF+92uripI3kK4nUtOTLPnayb229VKraq4J+fOV/Agr9poOVeKjy6Y4s
	 Zwv++qAwJ30slvtgCAncxnfTadXbyl9wqJD8OFYC0ErYNkFSaPRVleOhTIpPLDMNMf
	 CS0hsmY/Gxpjg==
From: Kalle Valo <kvalo@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org,  ath11k@lists.infradead.org,
  ath10k@lists.infradead.org,  linux-wireless@vger.kernel.org,
  imitsyanko@quantenna.com,  geomatsi@gmail.com,
  linux-kernel@vger.kernel.org,  netdev@vger.kernel.org
Subject: Re: [PATCH 0/3] wifi: Un-embed ath10k and ath11k dummy netdev
References: <20240405122123.4156104-1-leitao@debian.org>
Date: Fri, 05 Apr 2024 18:15:05 +0300
In-Reply-To: <20240405122123.4156104-1-leitao@debian.org> (Breno Leitao's
	message of "Fri, 5 Apr 2024 05:21:15 -0700")
Message-ID: <87y19r264m.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Breno Leitao <leitao@debian.org> writes:

> struct net_device shouldn't be embedded into any structure, instead,
> the owner should use the private space to embed their state into
> net_device.
>
> This patch set fixes the problem above for ath10k and ath11k. This also
> fixes the conversion of qtnfmac driver to the new helper.
>
> This patch set depends on a series that is still under review:
> https://lore.kernel.org/all/20240404114854.2498663-1-leitao@debian.org/#t
>
> If it helps, I've pushed the tree to
> https://github.com/leitao/linux/tree/wireless-dummy
>
> PS: Due to lack of hardware, unfortunately all these patches are
> compiled tested only.
>
> Breno Leitao (3):
>   wifi: qtnfmac: Use netdev dummy allocator helper
>   wifi: ath10k: allocate dummy net_device dynamically
>   wifi: ath11k: allocate dummy net_device dynamically

Thanks for setting up the branch, that makes the testing very easy. I
now tested the branch using the commit below with ath11k WCN6855 hw2.0
on an x86 box:

5be9a125d8e7 wifi: ath11k: allocate dummy net_device dynamically

But unfortunately it crashes, the stack trace below. I can easily test
your branches, just let me know what to test. A direct 'git pull'
command is the best.

[  238.886002] rmmod ath11k_pci
[  239.530328] ------------[ cut here ]------------
[  239.530433] kernel BUG at net/core/dev.c:11066!
[  239.530621] invalid opcode: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC KASAN
[  239.530709] CPU: 5 PID: 1668 Comm: rmmod Not tainted 6.9.0-rc2+ #1367
[  239.530762] Hardware name: Intel(R) Client Systems NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0067.2021.0528.1339 05/28/2021
[  239.530848] RIP: 0010:free_netdev (net/core/dev.c:11066 (discriminator 1)) 
[ 239.530893] Code: 08 84 d2 0f 85 3c 01 00 00 0f b7 83 3a 03 00 00 48 29 c3 48 89 df e8 27 10 21 fe 48 83 c4 10 5b 41 5c 41 5d 41 5e 41 5f 5d c3 <0f> 0b 44 0f b6 25 fd 91 53 02 41 80 fc 01 0f 87 1f 14 94 00 41 83
All code
========
   0:	08 84 d2 0f 85 3c 01 	or     %al,0x13c850f(%rdx,%rdx,8)
   7:	00 00                	add    %al,(%rax)
   9:	0f b7 83 3a 03 00 00 	movzwl 0x33a(%rbx),%eax
  10:	48 29 c3             	sub    %rax,%rbx
  13:	48 89 df             	mov    %rbx,%rdi
  16:	e8 27 10 21 fe       	call   0xfffffffffe211042
  1b:	48 83 c4 10          	add    $0x10,%rsp
  1f:	5b                   	pop    %rbx
  20:	41 5c                	pop    %r12
  22:	41 5d                	pop    %r13
  24:	41 5e                	pop    %r14
  26:	41 5f                	pop    %r15
  28:	5d                   	pop    %rbp
  29:	c3                   	ret
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	44 0f b6 25 fd 91 53 	movzbl 0x25391fd(%rip),%r12d        # 0x2539231
  33:	02 
  34:	41 80 fc 01          	cmp    $0x1,%r12b
  38:	0f 87 1f 14 94 00    	ja     0x94145d
  3e:	41                   	rex.B
  3f:	83                   	.byte 0x83

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	44 0f b6 25 fd 91 53 	movzbl 0x25391fd(%rip),%r12d        # 0x2539207
   9:	02 
   a:	41 80 fc 01          	cmp    $0x1,%r12b
   e:	0f 87 1f 14 94 00    	ja     0x941433
  14:	41                   	rex.B
  15:	83                   	.byte 0x83
[  239.530977] RSP: 0018:ffffc90002dffb70 EFLAGS: 00010202
[  239.531023] RAX: 0000000000000005 RBX: ffff88810c819000 RCX: 0000000000000000
[  239.531072] RDX: 1ffff110219032d1 RSI: ffffffff87e79780 RDI: 0000000000000000
[  239.531120] RBP: ffffc90002dffba8 R08: 0000000000000001 R09: 0000000000000001
[  239.531169] R10: ffffffff897e3f17 R11: 00000000000000bb R12: ffff88810c8194e0
[  239.531224] R13: ffff88810c819178 R14: dffffc0000000000 R15: ffff88810c819688
[  239.531274] FS:  00007f462c4c4740(0000) GS:ffff888232c00000(0000) knlGS:0000000000000000
[  239.531326] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  239.531371] CR2: 000055fc93483308 CR3: 0000000113a99004 CR4: 00000000003706f0
[  239.531420] Call Trace:
[  239.531484]  <TASK>
[  239.531550] ? show_regs (arch/x86/kernel/dumpstack.c:479) 
[  239.531592] ? die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434 arch/x86/kernel/dumpstack.c:447) 
[  239.531630] ? do_trap (arch/x86/kernel/traps.c:114 arch/x86/kernel/traps.c:155) 
[  239.531669] ? do_error_trap (./arch/x86/include/asm/traps.h:58 arch/x86/kernel/traps.c:176) 
[  239.531708] ? free_netdev (net/core/dev.c:11066 (discriminator 1)) 
[  239.531749] ? handle_invalid_op (arch/x86/kernel/traps.c:214) 
[  239.531789] ? free_netdev (net/core/dev.c:11066 (discriminator 1)) 
[  239.531829] ? exc_invalid_op (arch/x86/kernel/traps.c:267) 
[  239.531868] ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:621) 
[  239.531910] ? free_netdev (net/core/dev.c:11066 (discriminator 1)) 
[  239.531952] ath11k_pcic_free_irq (drivers/net/wireless/ath/ath11k/pcic.c:312 (discriminator 2) drivers/net/wireless/ath/ath11k/pcic.c:334 (discriminator 2)) ath11k
[  239.532029] ath11k_pci_remove (drivers/net/wireless/ath/ath11k/pci.c:478 drivers/net/wireless/ath/ath11k/pci.c:987) ath11k_pci
[  239.532075] pci_device_remove (./include/linux/pm_runtime.h:129 drivers/pci/pci-driver.c:475) 
[  239.532116] device_remove (drivers/base/dd.c:569) 
[  239.532155] device_release_driver_internal (drivers/base/dd.c:1272 drivers/base/dd.c:1293) 
[  239.532198] ? __kasan_check_read (mm/kasan/shadow.c:32) 
[  239.532241] driver_detach (drivers/base/dd.c:1357) 
[  239.532281] bus_remove_driver (drivers/base/bus.c:736) 
[  239.532322] driver_unregister (drivers/base/driver.c:275) 
[  239.532362] pci_unregister_driver (./include/linux/spinlock.h:351 drivers/pci/pci-driver.c:85 drivers/pci/pci-driver.c:1467) 
[  239.532402] ? find_module_all (kernel/module/main.c:357 (discriminator 1)) 
[  239.532443] ath11k_pci_exit (drivers/net/wireless/ath/ath11k/pci.c:1069) ath11k_pci
[  239.532543] __do_sys_delete_module (kernel/module/main.c:756) 
[  239.532584] ? __kasan_slab_free (mm/kasan/common.c:274) 
[  239.532625] ? module_flags (kernel/module/main.c:700) 
[  239.532666] ? kmem_cache_free (mm/slub.c:4280 (discriminator 3) mm/slub.c:4344 (discriminator 3)) 
[  239.533366] ? __fput (fs/file_table.c:436) 
[  239.534132] ? debug_smp_processor_id (lib/smp_processor_id.c:61) 
[  239.534855] __x64_sys_delete_module (kernel/module/main.c:698) 
[  239.535620] do_syscall_64 (arch/x86/entry/common.c:52 (discriminator 1) arch/x86/entry/common.c:83 (discriminator 1)) 
[  239.536334] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 
[  239.537628] RIP: 0033:0x7f462c611c8b
[ 239.538510] Code: 73 01 c3 48 8b 0d 05 c2 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d5 c1 0c 00 f7 d8 64 89 01 48
All code
========
   0:	73 01                	jae    0x3
   2:	c3                   	ret
   3:	48 8b 0d 05 c2 0c 00 	mov    0xcc205(%rip),%rcx        # 0xcc20f
   a:	f7 d8                	neg    %eax
   c:	64 89 01             	mov    %eax,%fs:(%rcx)
   f:	48 83 c8 ff          	or     $0xffffffffffffffff,%rax
  13:	c3                   	ret
  14:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  1b:	00 00 00 
  1e:	90                   	nop
  1f:	f3 0f 1e fa          	endbr64
  23:	b8 b0 00 00 00       	mov    $0xb0,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	ret
  33:	48 8b 0d d5 c1 0c 00 	mov    0xcc1d5(%rip),%rcx        # 0xcc20f
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	ret
   9:	48 8b 0d d5 c1 0c 00 	mov    0xcc1d5(%rip),%rcx        # 0xcc1e5
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W
[  239.540022] RSP: 002b:00007fff08acd828 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
[  239.540791] RAX: ffffffffffffffda RBX: 0000555f9f0647d0 RCX: 00007f462c611c8b
[  239.541556] RDX: 000000000000000a RSI: 0000000000000800 RDI: 0000555f9f064838
[  239.542319] RBP: 00007fff08acd888 R08: 0000000000000000 R09: 0000000000000000
[  239.543087] R10: 00007f462c68dac0 R11: 0000000000000206 R12: 00007fff08acda60
[  239.543859] R13: 00007fff08acdeb7 R14: 0000555f9f0632a0 R15: 0000555f9f0647d0
[  239.544615]  </TASK>
[  239.545337] Modules linked in: ath11k_pci(-) ath11k mac80211 libarc4 cfg80211 qmi_helpers qrtr_mhi mhi qrtr nvme nvme_core
[  239.546153] ---[ end trace 0000000000000000 ]---
[  239.568717] RIP: 0010:free_netdev (net/core/dev.c:11066 (discriminator 1)) 
[ 239.569476] Code: 08 84 d2 0f 85 3c 01 00 00 0f b7 83 3a 03 00 00 48 29 c3 48 89 df e8 27 10 21 fe 48 83 c4 10 5b 41 5c 41 5d 41 5e 41 5f 5d c3 <0f> 0b 44 0f b6 25 fd 91 53 02 41 80 fc 01 0f 87 1f 14 94 00 41 83
All code
========
   0:	08 84 d2 0f 85 3c 01 	or     %al,0x13c850f(%rdx,%rdx,8)
   7:	00 00                	add    %al,(%rax)
   9:	0f b7 83 3a 03 00 00 	movzwl 0x33a(%rbx),%eax
  10:	48 29 c3             	sub    %rax,%rbx
  13:	48 89 df             	mov    %rbx,%rdi
  16:	e8 27 10 21 fe       	call   0xfffffffffe211042
  1b:	48 83 c4 10          	add    $0x10,%rsp
  1f:	5b                   	pop    %rbx
  20:	41 5c                	pop    %r12
  22:	41 5d                	pop    %r13
  24:	41 5e                	pop    %r14
  26:	41 5f                	pop    %r15
  28:	5d                   	pop    %rbp
  29:	c3                   	ret
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	44 0f b6 25 fd 91 53 	movzbl 0x25391fd(%rip),%r12d        # 0x2539231
  33:	02 
  34:	41 80 fc 01          	cmp    $0x1,%r12b
  38:	0f 87 1f 14 94 00    	ja     0x94145d
  3e:	41                   	rex.B
  3f:	83                   	.byte 0x83

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	44 0f b6 25 fd 91 53 	movzbl 0x25391fd(%rip),%r12d        # 0x2539207
   9:	02 
   a:	41 80 fc 01          	cmp    $0x1,%r12b
   e:	0f 87 1f 14 94 00    	ja     0x941433
  14:	41                   	rex.B
  15:	83                   	.byte 0x83
[  239.571082] RSP: 0018:ffffc90002dffb70 EFLAGS: 00010202
[  239.571929] RAX: 0000000000000005 RBX: ffff88810c819000 RCX: 0000000000000000
[  239.572970] RDX: 1ffff110219032d1 RSI: ffffffff87e79780 RDI: 0000000000000000
[  239.573792] RBP: ffffc90002dffba8 R08: 0000000000000001 R09: 0000000000000001
[  239.574600] R10: ffffffff897e3f17 R11: 00000000000000bb R12: ffff88810c8194e0
[  239.575368] R13: ffff88810c819178 R14: dffffc0000000000 R15: ffff88810c819688
[  239.576136] FS:  00007f462c4c4740(0000) GS:ffff888231c00000(0000) knlGS:0000000000000000
[  239.576909] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  239.577723] CR2: 0000557ff5c54118 CR3: 0000000113a99003 CR4: 00000000003706f0
[  239.578508] Kernel panic - not syncing: Fatal exception
[  239.579273] Kernel Offset: 0x3e00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[  239.608975] Rebooting in 10 seconds..


-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

