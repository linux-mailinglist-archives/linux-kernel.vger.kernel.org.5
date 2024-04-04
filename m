Return-Path: <linux-kernel+bounces-131891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A89898D43
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C73941C23476
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCD412E1D3;
	Thu,  4 Apr 2024 17:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="v9psreqD"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF2B1F61C;
	Thu,  4 Apr 2024 17:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712252027; cv=none; b=JXljr+u9Q1OLw15eco+AcWYEQTHIxdrZ3fCUUAgc8G33wsITwTwaK1oY6Q3WjQ9VBjy4viu7P9Zgp8ei0t4HLc/BKacKcejX4I071INd5TkJpbCm51EFIyTW1LLfhJItddoTOgkOWyPzr1V0eXFxzF/Id6P60d0bd7JAlVolkRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712252027; c=relaxed/simple;
	bh=doQitWhcREUucrKSoXjTMVT5G7H4c7wT88p3P9zRIBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=RdTyd8go8lSP46rsMRug6v5fF7YSB8vZcHu8qRMcauSvyXBKDJTs6kvDTN8tIF7kP4XMm8ToEWT76UevhNzkahg3cr9B+GuFbjD1QITbwrSzMaE2f3UkCrPMQTpyanCTykc7AquNRsDFqEi1O8byusIfmMVtM+ngEwpMYvfcJds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=v9psreqD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:Cc:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=ND8ykMVV3E5+HLxjXKeng5Frf4NNoBw+6beGYw/Y9Wg=; b=v9psreqD1j9YeRI4P8sv+9kFGr
	yVOBZUxh9jqTkqllUpojAoM17YI2XSMahcLp7Vpjpah3wcQCi3Lu62RIR2uu+2ZR+6+XeQxUmomRc
	aGuojZnu/Ovy3q8zk85QTPQ6EJ1oAeKGr0FsrtyTftMQ5+iC3zv4cr4djbX4OESJDe4h66upvTrPU
	88g9k4TIlRRfNM7GP2Gu1+sUFDJc8GYDcSIa1SeUtbCOs0TO1pY5EofEHfe5QgvA1OxjiPVnH+mgd
	gLeE1Qg4QsT7QQSGlJbWfUZfg4vGUsOioK9RFS9S3wJvVUc9hJ0QzJzDcSRBb5T6HnXBvw0DSxWeD
	KA03qBfA==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsQy9-00000003f2Z-0s4d;
	Thu, 04 Apr 2024 17:33:45 +0000
Message-ID: <b5e73e45-4951-4eb0-91fd-2cb5998c8061@infradead.org>
Date: Thu, 4 Apr 2024 10:33:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel Trace in recent 6.1.8n kernels
To: Tim Tassonis <stuff@decentral.ch>, LKML <linux-kernel@vger.kernel.org>
References: <b8dbce0c-31b4-4762-9779-6e973806433a@decentral.ch>
Content-Language: en-US
Cc: stable <stable@vger.kernel.org>, linux-scsi@vger.kernel.org
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <b8dbce0c-31b4-4762-9779-6e973806433a@decentral.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[+ stable & scsi]

On 4/3/24 3:49 PM, Tim Tassonis wrote:
> Hi all
> 
> Maybe this is the wrong list, as it probably only affects the 6.1.8n LTS kernel releases.
> 
> 
> I noticed that since 6.1.80 or so, all my boxes print a trace when rebooting or halting, right at the end. It starts with drivers/scsi/scsi_lib.c
> 
> As everything seems already done by then, there is no "real" problem occuring, but maybe someone knows why this suddenly started to happen.
> 
> 
> With qemu and the serial options, I managed to get the actual trace in text:
> 
>      Unmounting all other currently mounted file systems...[ 58.632670] EXT4-fs (sda1): re-mounted. Quota mode: none.
>   * [  OK  ]
> [   58.684029] EXT4-fs (sda1): re-mounted. Quota mode: none.
>   *   Bringing down the loopback interface... [  OK  ]
> [   58.809326] ------------[ cut here ]------------
> [   58.813524] WARNING: CPU: 0 PID: 2755 at drivers/scsi/scsi_lib.c:214 scsi_execute_cmd+0x3b/0x2b0
> [   58.828052] Modules linked in: cfg80211 8021q garp mrp stp ipv6 crc_ccitt joydev hid_generic usbhid snd_seq_midi snd_seq_midi_event psmouse ppdev serio_raw atkbd libps2 vivaldi_fmap uhci_hcd ehci_pci ehci_hcd snd_ens1370 bochs drm_vram_helper snd_rawmidi usbcore drm_ttm_helper sr_mod usb_common snd_pcm cdrom e1000 i2c_piix4 ttm pcspkr gameport pata_acpi parport_pc parport i8042 qemu_fw_cfg serio rtc_cmos floppy snd_seq snd_seq_device snd_timer snd soundcore fuse
> [   58.873677] CPU: 0 PID: 2755 Comm: halt Not tainted 6.1.84 #1
> [   58.876424] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [   58.884106] RIP: 0010:scsi_execute_cmd+0x3b/0x2b0
> [   58.885558] Code: 89 cc 55 44 89 c5 53 48 83 ec 10 4c 8b 74 24 50 48 89 0c 24 4d 85 f6 0f 84 44 02 00 00 49 83 3e 00 74 21 41 83 7e 08 60 74 1a <0f> 0b b8 ea ff ff ff 48 83 c4 10 5b 5d 41 5c 41 5d 41 5e 41 5f c3
> [   58.891998] RSP: 0018:ffffc90000153d98 EFLAGS: 00010287
> [   58.893500] RAX: ffffc90000153df8 RBX: ffff888003d22000 RCX: 0000000000000000
> [   58.895480] RDX: 0000000000000022 RSI: 0000000000000022 RDI: ffff888003d22000
> [   58.897583] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000002710
> [   58.900276] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000002710
> [   58.902209] R13: ffff888003d22000 R14: ffffc90000153df8 R15: ffffc90000153e28
> [   58.904084] FS:  00007f097a95b680(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
> [   58.906285] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   58.907451] CR2: 00007f097a8f5431 CR3: 000000000406e000 CR4: 00000000000006f0
> [   58.908928] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   58.910326] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   58.911770] Call Trace:
> [   58.912438]  <TASK>
> [   58.912977]  ? __warn+0x78/0xd0
> [   58.913751]  ? scsi_execute_cmd+0x3b/0x2b0
> [   58.914757]  ? report_bug+0xe6/0x170
> [   58.916267]  ? handle_bug+0x3c/0x70
> [   58.917020]  ? exc_invalid_op+0x13/0x60
> [   58.917807]  ? asm_exc_invalid_op+0x16/0x20
> [   58.918675]  ? scsi_execute_cmd+0x3b/0x2b0
> [   58.919524]  ata_cmd_ioctl+0x112/0x2b0
> [   58.920435]  blkdev_ioctl+0x12e/0x260
> [   58.921322]  __x64_sys_ioctl+0x8b/0xc0
> [   58.922115]  do_syscall_64+0x42/0x90
> [   58.922953]  entry_SYSCALL_64_after_hwframe+0x64/0xce
> [   58.924002] RIP: 0033:0x7f097a87616b
> [   58.924748] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
> [   58.928687] RSP: 002b:00007fff1e70b5b0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> [   58.930465] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f097a87616b
> [   58.932545] RDX: 00007fff1e70b614 RSI: 000000000000031f RDI: 0000000000000004
> [   58.933964] RBP: 0000000000000000 R08: 0000000000000073 R09: 0000558c7857a343
> [   58.935349] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000020
> [   58.936727] R13: 0000558c77faf088 R14: 0000000000000001 R15: 0000000000000000
> [   58.938165]  </TASK>
> [   58.938617] ---[ end trace 0000000000000000 ]---
> [   58.940450] sd 0:0:0:0: [sda] Synchronizing SCSI cache
> [   58.941662] sd 0:0:0:0: [sda] Stopping disk
> [   58.971754] ACPI: PM: Preparing to enter system sleep state S5
> [   58.973005] reboot: Power down
> 
> 
> Bye
> Tim
> 

-- 
#Randy

