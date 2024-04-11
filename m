Return-Path: <linux-kernel+bounces-140380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AF98A138C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C94541C216BA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD736166E;
	Thu, 11 Apr 2024 11:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1fwA+UPA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D65147C7E;
	Thu, 11 Apr 2024 11:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712836134; cv=none; b=aoV+2lD3lR0hbB6xHb6Skukc4UqBD4OxiJVRrJOL8CDD05IUqoMq0/vDDOhCgPN34RKf3iBYgAmFrSVgMDM+iTT/1jYbaSneVVTZ0HPGYyWo8paoMb6ggeNaB24igVYBxqL1YndU1Q/Vojm6kZozUcFeVruOXo6dhh2LPBHph1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712836134; c=relaxed/simple;
	bh=xHO0wWJDd8mFY7nGU88/CXPqqFN1tqBD6Cj7FUEK/p8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGlS7ZuYm+OBUr/OwDRzOBpUvAPRpOUJf3efKLTvHjDB6+cXtH0O6o+cEERz23vEpLEnM5746OTAoNtL2HhTU3GZKz4r4peQuFzY4cR3YDHlLSu9G9DRrUgpb78YuveDWDLsg6Iyx8GY23szeQH2bY0MpnI2s/F/tsFNkBUBpOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1fwA+UPA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB47C433F1;
	Thu, 11 Apr 2024 11:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712836133;
	bh=xHO0wWJDd8mFY7nGU88/CXPqqFN1tqBD6Cj7FUEK/p8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1fwA+UPAa2I4Xw7vpfNi20AfPVujPsy0lCAxj07s573N3GigzeovkMTI3TdDSPAtN
	 oMAO3zE3tonDbIqwfq6v11tNtQ8qqsFqsocv0A45EGzN3hlfx+ggH61HbQ1hfSiX3S
	 T2a0NUkBeHqEtwiJLzd9EOpBE0p42rrhmi1eEOns=
Date: Thu, 11 Apr 2024 13:48:50 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Chris Rankin <rankincj@gmail.com>
Cc: Linux Stable <stable@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6.8 000/143] 6.8.6-rc1 review
Message-ID: <2024041138-earpiece-crying-c9d8@gregkh>
References: <CAK2bqV+kpG5cm5py24TusikZYO=_vWg7CVEN3oTywVhnq1mhjQ@mail.gmail.com>
 <2024041125-surgery-pending-cd06@gregkh>
 <CAK2bqVJcsjZE8k87_xNU-mQ3xXm58eCFMdouSVEMkkT57wCQFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK2bqVJcsjZE8k87_xNU-mQ3xXm58eCFMdouSVEMkkT57wCQFg@mail.gmail.com>

On Thu, Apr 11, 2024 at 12:33:13PM +0100, Chris Rankin wrote:
> My original oops is here:
> 
> [ 7737.972588] usb 2-4: USB disconnect, device number 3
> [ 7743.332135] BUG: kernel NULL pointer dereference, address: 0000000000000370
> [ 7743.337805] #PF: supervisor write access in kernel mode
> [ 7743.341730] #PF: error_code(0x0002) - not-present page
> [ 7743.345569] PGD 0 P4D 0
> [ 7743.346830] Oops: 0002 [#1] PREEMPT SMP PTI
> [ 7743.349711] CPU: 4 PID: 27870 Comm: kworker/4:0 Tainted: G
> I        6.8.4 #1
> [ 7743.356237] Hardware name: Gigabyte Technology Co., Ltd.
> EX58-UD3R/EX58-UD3R, BIOS FB  05/04/2009
> [ 7743.363830] Workqueue: events sg_remove_sfp_usercontext [sg]
> [ 7743.368196] RIP: 0010:mutex_lock+0x1e/0x2e
> [ 7743.370997] Code: 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00
> 00 51 48 89 3c 24 2e 2e 2e 31 c0 31 c0 48 8b 3c 24 65 48 8b 14 25 40
> c2 02 00 <f0> 48 0f b1 17 74 03 5a eb b9 58 c3 cc cc cc cc 90 90 90 90
> 90 90
> [ 7743.388443] RSP: 0018:ffffc90004667e00 EFLAGS: 00010246
> [ 7743.392368] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000810000d2
> [ 7743.398201] RDX: ffff88805bf30e40 RSI: ffffffffa1bbd20d RDI: 0000000000000370
> [ 7743.404034] RBP: 0000000000000370 R08: ffff8881144e2d70 R09: 00000000810000d2
> [ 7743.409867] R10: 000000000000023e R11: 000000000000023e R12: ffff8881424039c0
> [ 7743.415698] R13: dead000000000100 R14: ffff88826223a000 R15: ffff88826223a030
> [ 7743.421522] FS:  0000000000000000(0000) GS:ffff888343d00000(0000)
> knlGS:0000000000000000
> [ 7743.428308] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 7743.432745] CR2: 0000000000000370 CR3: 000000000221a000 CR4: 00000000000006f0
> [ 7743.438570] Call Trace:
> [ 7743.439715]  <TASK>
> [ 7743.440513]  ? __die_body+0x1a/0x5c
> [ 7743.442707]  ? page_fault_oops+0x32a/0x377
> [ 7743.445504]  ? fixup_exception+0x22/0x250
> [ 7743.448217]  ? exc_page_fault+0x105/0x117
> [ 7743.450928]  ? asm_exc_page_fault+0x22/0x30
> [ 7743.453850]  ? __pfx_sg_device_destroy+0x10/0x10 [sg]
> [ 7743.457602]  ? mutex_lock+0x1e/0x2e
> [ 7743.459839]  blk_trace_remove+0x15/0x35
> [ 7743.462378]  sg_device_destroy+0x1d/0x60 [sg]
> [ 7743.465438]  sg_remove_sfp_usercontext+0xd2/0xe9 [sg]
> [ 7743.469190]  process_scheduled_works+0x198/0x296
> [ 7743.472510]  worker_thread+0x1c6/0x220
> [ 7743.474962]  ? __pfx_worker_thread+0x10/0x10
> [ 7743.477934]  kthread+0xf7/0xff
> [ 7743.479694]  ? __pfx_kthread+0x10/0x10
> [ 7743.482146]  ret_from_fork+0x24/0x36
> [ 7743.484425]  ? __pfx_kthread+0x10/0x10
> [ 7743.486877]  ret_from_fork_asm+0x1b/0x30
> [ 7743.489506]  </TASK>
> [ 7743.490397] Modules linked in: udf usb_storage sg algif_hash af_alg
> snd_seq_dummy rpcrdma rdma_cm iw_cm ib_cm ib_core nf_nat_ftp
> nf_conntrack_ftp cfg80211 af_packet nf_conntrack_netbios_ns
> nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
> nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
> nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6table_nat
> ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat
> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c iptable_mangle
> iptable_raw iptable_security nfnetlink ebtable_filter ebtables
> ip6table_filter ip6_tables iptable_filter ip_tables x_tables bnep it87
> hwmon_vid binfmt_misc snd_hda_codec_realtek snd_hda_codec_generic
> snd_hda_codec_hdmi snd_hda_intel uvcvideo intel_powerclamp btusb
> btintel snd_usb_audio snd_intel_dspcfg coretemp btbcm uvc
> snd_hda_codec videobuf2_vmalloc kvm_intel snd_virtuoso bluetooth
> videobuf2_memops snd_oxygen_lib videobuf2_v4l2 snd_hda_core
> snd_usbmidi_lib videodev snd_mpu401_uart kvm videobuf2_common
> [ 7743.490474]  snd_hwdep snd_rawmidi mc snd_seq ecdh_generic
> input_leds led_class joydev snd_seq_device snd_pcm rfkill ecc r8169
> pktcdvd irqbypass gpio_ich realtek iTCO_wdt intel_cstate snd_hrtimer
> mdio_devres snd_timer libphy intel_uncore i2c_i801 snd pcspkr psmouse
> i2c_smbus acpi_cpufreq mxm_wmi soundcore lpc_ich i7core_edac
> tiny_power_button button nfsd auth_rpcgss nfs_acl lockd grace dm_mod
> sunrpc fuse configfs loop dax zram zsmalloc ext4 crc32c_generic crc16
> mbcache jbd2 amdgpu video amdxcp i2c_algo_bit mfd_core drm_ttm_helper
> ttm drm_exec gpu_sched sr_mod drm_suballoc_helper drm_buddy
> drm_display_helper cdrom sd_mod hid_microsoft usbhid drm_kms_helper
> ahci libahci pata_jmicron drm libata uhci_hcd xhci_pci ehci_pci
> ehci_hcd scsi_mod xhci_hcd usbcore drm_panel_orientation_quirks cec
> firewire_ohci crc32c_intel sha512_ssse3 rc_core sha256_ssse3 serio_raw
> firewire_core sha1_ssse3 usb_common bsg crc_itu_t scsi_common wmi msr
> [ 7743.659267] CR2: 0000000000000370
> [ 7743.661287] ---[ end trace 0000000000000000 ]---
> [ 7743.664605] RIP: 0010:mutex_lock+0x1e/0x2e
> [ 7743.667406] Code: 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00
> 00 51 48 89 3c 24 2e 2e 2e 31 c0 31 c0 48 8b 3c 24 65 48 8b 14 25 40
> c2 02 00 <f0> 48 0f b1 17 74 03 5a eb b9 58 c3 cc cc cc cc 90 90 90 90
> 90 90
> [ 7743.684850] RSP: 0018:ffffc90004667e00 EFLAGS: 00010246
> [ 7743.688767] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000810000d2
> [ 7743.694592] RDX: ffff88805bf30e40 RSI: ffffffffa1bbd20d RDI: 0000000000000370
> [ 7743.700415] RBP: 0000000000000370 R08: ffff8881144e2d70 R09: 00000000810000d2
> [ 7743.706239] R10: 000000000000023e R11: 000000000000023e R12: ffff8881424039c0
> [ 7743.712064] R13: dead000000000100 R14: ffff88826223a000 R15: ffff88826223a030
> [ 7743.717897] FS:  0000000000000000(0000) GS:ffff888343d00000(0000)
> knlGS:0000000000000000
> [ 7743.724684] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 7743.729129] CR2: 0000000000000370 CR3: 000000000221a000 CR4: 00000000000006f0
> [ 7743.734961] note: kworker/4:0[27870] exited with irqs disabled
> 
> I have no idea what the current status of the fix(?) is.

Try asking on the scsi list?

thanks,

greg k-h

