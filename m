Return-Path: <linux-kernel+bounces-133922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E27F89AAF0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 14:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AFBB1F219FA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 12:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0E82E85B;
	Sat,  6 Apr 2024 12:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUKhrxJJ"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812282C1A3;
	Sat,  6 Apr 2024 12:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712407550; cv=none; b=NYsCcfuLN14TqIzAvond+aG1am23vH4ZBsUNQOKlgvgxOuZdM7L0ZZDcGKW/9jx2SsLpPGZq5xEHgBmLD+QPXaPwNFpkimIHNfWn2VW3Jmu73J0EHuIriOKzYGIr+a1MVrl7NjHmkMvhHLOHMqKVnme9xpCoY7bbTQXcjMrR1dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712407550; c=relaxed/simple;
	bh=zqrIMrWz1tY522A/RdgycKAYpp2J4fWAnX81SH3uUHk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=e0kcugINVU8x49uChVM0SdR0l1SsZcnI0LEx9kKBJbGNU+hrL+DrXnSuG8gZG55HPIcfvjCuVQbmh5nW9/ei4QR4kwfGr0q5jYUU+P4W2aX0Z44S9ZjJesLh6zTAhEnWFAcxjd3xWyKonXwKdaFowC/gBaYn+nnHmHaS55nlcr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUKhrxJJ; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6964b1c529cso21173106d6.0;
        Sat, 06 Apr 2024 05:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712407547; x=1713012347; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tPsXILqyi2QTO7kx1TnKRTZOOsGEinvVHmdko8cu3Qo=;
        b=nUKhrxJJKlIf5r46jNxHqXK33pl0ovNbwqWj2GhNk1ZAX0RPLToAmNzdIpug5j6dt0
         FC/gXRUg0MYrkLM3LU/McRP5/MlGb/3KbJaoW/ROnx0TEx+xH+IUWFRTDf49ll8iQi/Z
         n21mC7GUk66lEGrAB4K8axo7Z+ERbdf3gzGMvPV/v1BHru17+hqjckGrgYWEwVn3OLKI
         XUybpt9KdZ38iwBKEd00NCk2uedXXGmghRkfZ1hrGJJ4P/zIyalRb50UEonq1WxR9FQt
         VV6zaDZEF0GyAqea5v1mZlooDgCfQZCYRC2zgtrHeSEWeO3ZyOTQ9fUycx2QRBdgKYaZ
         /6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712407547; x=1713012347;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tPsXILqyi2QTO7kx1TnKRTZOOsGEinvVHmdko8cu3Qo=;
        b=c7vv57fjS9sr2VulfVAx0qW/0h22uGHJxMLbiGbEChqsHUUlEM3Tb6XBetT2tE6lGx
         F5kVB8/w+NKaq96XXgO2iCk0OwTiVsGrDUGrr/r9hM7HDrZF16qIgguvdD/fq6m0yHU6
         47FhDp0x+bizeV+4xoKhH5AyDgmWI5/9I0YvTW0ynPVEGl8nwwgt4IMwFUp6cSD+BRFB
         Y/8c8HDik5IskKAVym1vMaqtPNfnRSmvaxDYzyAl14us9ap/gmMw1BYOdDXNuZXcA0/P
         KEWossehiU6x9hO498AH1qlqmCymfo/e6uIihnZoDG/eGCHZEewyNWCS5jBAahFbyPxv
         EWiA==
X-Gm-Message-State: AOJu0Yx6a3auSPNHz3M7QlH/qq+vr/Fj/gE1hVRcHo6N+tJ+Kunnms2A
	l0Mnj84cG8dPXuY42uGdyQTF/Myg/YjJOWvMy8WVnNiknfSPtJIG0GRH1tXvVjeNSwL53xDX64x
	ioZimi09ILczttrPWNhysAwoaJKPv/o3Lvpo=
X-Google-Smtp-Source: AGHT+IElW+XAObgCXq6AhQVh8RR8fEZ6DyIc2BLoovIPkauURywG6UVXPWbBlGoHhUZSNaFtr2ml5caP5JozGuBrXxM=
X-Received: by 2002:a05:6214:aca:b0:699:3ed0:f303 with SMTP id
 g10-20020a0562140aca00b006993ed0f303mr5086114qvi.60.1712407546949; Sat, 06
 Apr 2024 05:45:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Chris Rankin <rankincj@gmail.com>
Date: Sat, 6 Apr 2024 13:45:35 +0100
Message-ID: <CAK2bqV+P-791k0bgcUDMkGYiOdqLL4tBanC6CXwCdRpMPPsYgw@mail.gmail.com>
Subject: [OOPS][STABLE] NULL pointer dereferenced with Linux 6.8.4
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux Stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

Just noticed this OOPS in my vanilla 6.8.4 kernel dmesg log. The USB
device here is an optical drive, although oddly I wasn't unplugging it
at the time. I was actually remounting it as a different user:

$ udisksctl unmount -b /dev/sr1
<SWITCH USER>
$ udisksctl mount -b /dev/sr1

[ 7737.972588] usb 2-4: USB disconnect, device number 3
[ 7743.332135] BUG: kernel NULL pointer dereference, address: 0000000000000370
[ 7743.337805] #PF: supervisor write access in kernel mode
[ 7743.341730] #PF: error_code(0x0002) - not-present page
[ 7743.345569] PGD 0 P4D 0
[ 7743.346830] Oops: 0002 [#1] PREEMPT SMP PTI
[ 7743.349711] CPU: 4 PID: 27870 Comm: kworker/4:0 Tainted: G
I        6.8.4 #1
[ 7743.356237] Hardware name: Gigabyte Technology Co., Ltd.
EX58-UD3R/EX58-UD3R, BIOS FB  05/04/2009
[ 7743.363830] Workqueue: events sg_remove_sfp_usercontext [sg]
[ 7743.368196] RIP: 0010:mutex_lock+0x1e/0x2e
[ 7743.370997] Code: 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00
00 51 48 89 3c 24 2e 2e 2e 31 c0 31 c0 48 8b 3c 24 65 48 8b 14 25 40
c2 02 00 <f0> 48 0f b1 17 74 03 5a eb b9 58 c3 cc cc cc cc 90 90 90 90
90 90
[ 7743.388443] RSP: 0018:ffffc90004667e00 EFLAGS: 00010246
[ 7743.392368] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000810000d2
[ 7743.398201] RDX: ffff88805bf30e40 RSI: ffffffffa1bbd20d RDI: 0000000000000370
[ 7743.404034] RBP: 0000000000000370 R08: ffff8881144e2d70 R09: 00000000810000d2
[ 7743.409867] R10: 000000000000023e R11: 000000000000023e R12: ffff8881424039c0
[ 7743.415698] R13: dead000000000100 R14: ffff88826223a000 R15: ffff88826223a030
[ 7743.421522] FS:  0000000000000000(0000) GS:ffff888343d00000(0000)
knlGS:0000000000000000
[ 7743.428308] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 7743.432745] CR2: 0000000000000370 CR3: 000000000221a000 CR4: 00000000000006f0
[ 7743.438570] Call Trace:
[ 7743.439715]  <TASK>
[ 7743.440513]  ? __die_body+0x1a/0x5c
[ 7743.442707]  ? page_fault_oops+0x32a/0x377
[ 7743.445504]  ? fixup_exception+0x22/0x250
[ 7743.448217]  ? exc_page_fault+0x105/0x117
[ 7743.450928]  ? asm_exc_page_fault+0x22/0x30
[ 7743.453850]  ? __pfx_sg_device_destroy+0x10/0x10 [sg]
[ 7743.457602]  ? mutex_lock+0x1e/0x2e
[ 7743.459839]  blk_trace_remove+0x15/0x35
[ 7743.462378]  sg_device_destroy+0x1d/0x60 [sg]
[ 7743.465438]  sg_remove_sfp_usercontext+0xd2/0xe9 [sg]
[ 7743.469190]  process_scheduled_works+0x198/0x296
[ 7743.472510]  worker_thread+0x1c6/0x220
[ 7743.474962]  ? __pfx_worker_thread+0x10/0x10
[ 7743.477934]  kthread+0xf7/0xff
[ 7743.479694]  ? __pfx_kthread+0x10/0x10
[ 7743.482146]  ret_from_fork+0x24/0x36
[ 7743.484425]  ? __pfx_kthread+0x10/0x10
[ 7743.486877]  ret_from_fork_asm+0x1b/0x30
[ 7743.489506]  </TASK>
[ 7743.490397] Modules linked in: udf usb_storage sg algif_hash af_alg
snd_seq_dummy rpcrdma rdma_cm iw_cm ib_cm ib_core nf_nat_ftp
nf_conntrack_ftp cfg80211 af_packet nf_conntrack_netbios_ns
nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6table_nat
ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c iptable_mangle
iptable_raw iptable_security nfnetlink ebtable_filter ebtables
ip6table_filter ip6_tables iptable_filter ip_tables x_tables bnep it87
hwmon_vid binfmt_misc snd_hda_codec_realtek snd_hda_codec_generic
snd_hda_codec_hdmi snd_hda_intel uvcvideo intel_powerclamp btusb
btintel snd_usb_audio snd_intel_dspcfg coretemp btbcm uvc
snd_hda_codec videobuf2_vmalloc kvm_intel snd_virtuoso bluetooth
videobuf2_memops snd_oxygen_lib videobuf2_v4l2 snd_hda_core
snd_usbmidi_lib videodev snd_mpu401_uart kvm videobuf2_common
[ 7743.490474]  snd_hwdep snd_rawmidi mc snd_seq ecdh_generic
input_leds led_class joydev snd_seq_device snd_pcm rfkill ecc r8169
pktcdvd irqbypass gpio_ich realtek iTCO_wdt intel_cstate snd_hrtimer
mdio_devres snd_timer libphy intel_uncore i2c_i801 snd pcspkr psmouse
i2c_smbus acpi_cpufreq mxm_wmi soundcore lpc_ich i7core_edac
tiny_power_button button nfsd auth_rpcgss nfs_acl lockd grace dm_mod
sunrpc fuse configfs loop dax zram zsmalloc ext4 crc32c_generic crc16
mbcache jbd2 amdgpu video amdxcp i2c_algo_bit mfd_core drm_ttm_helper
ttm drm_exec gpu_sched sr_mod drm_suballoc_helper drm_buddy
drm_display_helper cdrom sd_mod hid_microsoft usbhid drm_kms_helper
ahci libahci pata_jmicron drm libata uhci_hcd xhci_pci ehci_pci
ehci_hcd scsi_mod xhci_hcd usbcore drm_panel_orientation_quirks cec
firewire_ohci crc32c_intel sha512_ssse3 rc_core sha256_ssse3 serio_raw
firewire_core sha1_ssse3 usb_common bsg crc_itu_t scsi_common wmi msr
[ 7743.659267] CR2: 0000000000000370
[ 7743.661287] ---[ end trace 0000000000000000 ]---
[ 7743.664605] RIP: 0010:mutex_lock+0x1e/0x2e
[ 7743.667406] Code: 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00
00 51 48 89 3c 24 2e 2e 2e 31 c0 31 c0 48 8b 3c 24 65 48 8b 14 25 40
c2 02 00 <f0> 48 0f b1 17 74 03 5a eb b9 58 c3 cc cc cc cc 90 90 90 90
90 90
[ 7743.684850] RSP: 0018:ffffc90004667e00 EFLAGS: 00010246
[ 7743.688767] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000810000d2
[ 7743.694592] RDX: ffff88805bf30e40 RSI: ffffffffa1bbd20d RDI: 0000000000000370
[ 7743.700415] RBP: 0000000000000370 R08: ffff8881144e2d70 R09: 00000000810000d2
[ 7743.706239] R10: 000000000000023e R11: 000000000000023e R12: ffff8881424039c0
[ 7743.712064] R13: dead000000000100 R14: ffff88826223a000 R15: ffff88826223a030
[ 7743.717897] FS:  0000000000000000(0000) GS:ffff888343d00000(0000)
knlGS:0000000000000000
[ 7743.724684] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 7743.729129] CR2: 0000000000000370 CR3: 000000000221a000 CR4: 00000000000006f0
[ 7743.734961] note: kworker/4:0[27870] exited with irqs disabled

