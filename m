Return-Path: <linux-kernel+bounces-130716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8D6897C11
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 01:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AAAD1C25FDF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E51E156C44;
	Wed,  3 Apr 2024 23:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=decentral.ch header.i=@decentral.ch header.b="um67KjuK"
Received: from rush.cubic.ch (rush.cubic.ch [176.9.78.115])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D519C2231A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 23:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.78.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712187316; cv=none; b=SxY8ZZokCagz1hyufjjWC695PkNR29k/pN2N/ZerT1WYOxVVyqvZn53bjJuLRhO5z9zgIsi3v2GcD0AVt2V/iN6cgWUGD1IElg9FKOsVSGQqFUVKQZb7EcQzvcGG2HSGvbME/cEOTAFz7xQo3YjjeXQV/RxXIPvXcamFNgwU7oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712187316; c=relaxed/simple;
	bh=gofMnhN0RZrgEF7WGTk00KLMfunpXl+0UpVYjKeRguc=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=R7ozJfqbHl3UJktJrmQWBdzjN5dFabPNGF72kvlC+WesqLRgJWu4nxGx3TGXrBB3ROUn31xNFpMIz6QiF1ygfAkWVoNHJsnIy1GxIBSFy64Y4y/KihFNY5D7AgJeLRdxvdQ9EyQjxkjSrbJAjSANZUnL5FNvohaI8AA5EH0CmCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decentral.ch; spf=pass smtp.mailfrom=decentral.ch; dkim=pass (2048-bit key) header.d=decentral.ch header.i=@decentral.ch header.b=um67KjuK; arc=none smtp.client-ip=176.9.78.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decentral.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decentral.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=decentral.ch; s=rsa2;
	h=Content-Transfer-Encoding:Content-Type:Subject:From:To:MIME-Version:Date:Message-ID; bh=Pc4vqPGE/iNii3sBLL3VvLlB/0S2ovGkDyN9exiWvko=;
	b=um67KjuKFIodiAXidNuQmKmDWU3XTVfl85HExQvaE5VJZ8xlho6m81Es/6fnudAkS40AopBmCm5G7E9+p6VpYmaXP9TyonXkKNfmZO9Xg4KdghdWHhlYK0fBYXAohvUBe7D9GZ1iICD+D8QbQAFVZgkU3JhOLtGcVm5bS2fUWJ0CUMrV3WiSU/qnlMAl0I5Gf5SbiBHfIBogFSTAIq3KvT17Q/ZhdzEKLpkEYOjroyBAHer7lDOLCaNw3qzcr5M+Ixy1HPn3dmRGmCQr7bGFSm2NIzGALJetF6vMqvjU4zWNbQ5P+O2QMaHGL7cdJoD3xIcPzbgCzjnCsWP27gepiQ==;
Received: from james.decentral.ch ([85.195.242.225] helo=[192.168.219.104])
	by rush.cubic.ch with esmtpa (Exim 4.76)
	(envelope-from <stuff@decentral.ch>)
	id 1rs9QL-0001l5-79
	for linux-kernel@vger.kernel.org; Thu, 04 Apr 2024 00:49:41 +0200
Message-ID: <b8dbce0c-31b4-4762-9779-6e973806433a@decentral.ch>
Date: Thu, 4 Apr 2024 00:49:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: LKML <linux-kernel@vger.kernel.org>
Content-Language: en-US
From: Tim Tassonis <stuff@decentral.ch>
Subject: Kernel Trace in recent 6.1.8n kernels
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all

Maybe this is the wrong list, as it probably only affects the 6.1.8n LTS 
kernel releases.


I noticed that since 6.1.80 or so, all my boxes print a trace when 
rebooting or halting, right at the end. It starts with 
drivers/scsi/scsi_lib.c

As everything seems already done by then, there is no "real" problem 
occuring, but maybe someone knows why this suddenly started to happen.


With qemu and the serial options, I managed to get the actual trace in text:

      Unmounting all other currently mounted file systems...[ 
58.632670] EXT4-fs (sda1): re-mounted. Quota mode: none.
   * 
[  OK  ]
[   58.684029] EXT4-fs (sda1): re-mounted. Quota mode: none.
   *   Bringing down the loopback interface... 
[  OK  ]
[   58.809326] ------------[ cut here ]------------
[   58.813524] WARNING: CPU: 0 PID: 2755 at drivers/scsi/scsi_lib.c:214 
scsi_execute_cmd+0x3b/0x2b0
[   58.828052] Modules linked in: cfg80211 8021q garp mrp stp ipv6 
crc_ccitt joydev hid_generic usbhid snd_seq_midi snd_seq_midi_event 
psmouse ppdev serio_raw atkbd libps2 vivaldi_fmap uhci_hcd ehci_pci 
ehci_hcd snd_ens1370 bochs drm_vram_helper snd_rawmidi usbcore 
drm_ttm_helper sr_mod usb_common snd_pcm cdrom e1000 i2c_piix4 ttm 
pcspkr gameport pata_acpi parport_pc parport i8042 qemu_fw_cfg serio 
rtc_cmos floppy snd_seq snd_seq_device snd_timer snd soundcore fuse
[   58.873677] CPU: 0 PID: 2755 Comm: halt Not tainted 6.1.84 #1
[   58.876424] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[   58.884106] RIP: 0010:scsi_execute_cmd+0x3b/0x2b0
[   58.885558] Code: 89 cc 55 44 89 c5 53 48 83 ec 10 4c 8b 74 24 50 48 
89 0c 24 4d 85 f6 0f 84 44 02 00 00 49 83 3e 00 74 21 41 83 7e 08 60 74 
1a <0f> 0b b8 ea ff ff ff 48 83 c4 10 5b 5d 41 5c 41 5d 41 5e 41 5f c3
[   58.891998] RSP: 0018:ffffc90000153d98 EFLAGS: 00010287
[   58.893500] RAX: ffffc90000153df8 RBX: ffff888003d22000 RCX: 
0000000000000000
[   58.895480] RDX: 0000000000000022 RSI: 0000000000000022 RDI: 
ffff888003d22000
[   58.897583] RBP: 0000000000000000 R08: 0000000000000000 R09: 
0000000000002710
[   58.900276] R10: 0000000000000000 R11: 0000000000000000 R12: 
0000000000002710
[   58.902209] R13: ffff888003d22000 R14: ffffc90000153df8 R15: 
ffffc90000153e28
[   58.904084] FS:  00007f097a95b680(0000) GS:ffff88807dc00000(0000) 
knlGS:0000000000000000
[   58.906285] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   58.907451] CR2: 00007f097a8f5431 CR3: 000000000406e000 CR4: 
00000000000006f0
[   58.908928] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[   58.910326] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[   58.911770] Call Trace:
[   58.912438]  <TASK>
[   58.912977]  ? __warn+0x78/0xd0
[   58.913751]  ? scsi_execute_cmd+0x3b/0x2b0
[   58.914757]  ? report_bug+0xe6/0x170
[   58.916267]  ? handle_bug+0x3c/0x70
[   58.917020]  ? exc_invalid_op+0x13/0x60
[   58.917807]  ? asm_exc_invalid_op+0x16/0x20
[   58.918675]  ? scsi_execute_cmd+0x3b/0x2b0
[   58.919524]  ata_cmd_ioctl+0x112/0x2b0
[   58.920435]  blkdev_ioctl+0x12e/0x260
[   58.921322]  __x64_sys_ioctl+0x8b/0xc0
[   58.922115]  do_syscall_64+0x42/0x90
[   58.922953]  entry_SYSCALL_64_after_hwframe+0x64/0xce
[   58.924002] RIP: 0033:0x7f097a87616b
[   58.924748] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 
00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 
05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[   58.928687] RSP: 002b:00007fff1e70b5b0 EFLAGS: 00000246 ORIG_RAX: 
0000000000000010
[   58.930465] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 
00007f097a87616b
[   58.932545] RDX: 00007fff1e70b614 RSI: 000000000000031f RDI: 
0000000000000004
[   58.933964] RBP: 0000000000000000 R08: 0000000000000073 R09: 
0000558c7857a343
[   58.935349] R10: 0000000000000000 R11: 0000000000000246 R12: 
0000000000000020
[   58.936727] R13: 0000558c77faf088 R14: 0000000000000001 R15: 
0000000000000000
[   58.938165]  </TASK>
[   58.938617] ---[ end trace 0000000000000000 ]---
[   58.940450] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[   58.941662] sd 0:0:0:0: [sda] Stopping disk
[   58.971754] ACPI: PM: Preparing to enter system sleep state S5
[   58.973005] reboot: Power down


Bye
Tim

