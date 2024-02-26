Return-Path: <linux-kernel+bounces-81620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDDB867875
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7310F291B7F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F76512BE81;
	Mon, 26 Feb 2024 14:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=its-lehmann.de header.i=@its-lehmann.de header.b="EMewKM8w";
	dkim=permerror (0-bit key) header.d=its-lehmann.de header.i=@its-lehmann.de header.b="4HUGSWOC"
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465D012B151;
	Mon, 26 Feb 2024 14:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.221
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708957699; cv=pass; b=Uekx7FoGDAsnZsZf1w3NtLyIwP528FhgWk9mIE7TWupDQ5pZgmayTnjTsgwtbgPx7VXcjf7g75U+yyROH9/sZ9l4B7padonG3aCHcE6te/4uV8O2gHEopxjXrm0CCPPBNz+KFoHTY/11KQ+4Yg3w3aYpx5aVzU+Q32aG31xSrss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708957699; c=relaxed/simple;
	bh=CkdtlqZCnPfBSyt6ujqa1cES2EyLklOeUlg3XHFaQKE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VPJaMYXr1Se7xjymXiEF5CVpAu3PrMzUndZ4YktAMWz4MpnUSPV8YooTHwT5g7oIOLX5lwcn3jSKn/1g8LaNZq24JsxX+Fndrhz7hKPmEl1Z/cEDZlSswI9MshrJbcYJ0tyJ86sMrrKASHuoPiUHts/7S6SPc6+omKFHzN3Yjmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=its-lehmann.de; spf=pass smtp.mailfrom=its-lehmann.de; dkim=pass (2048-bit key) header.d=its-lehmann.de header.i=@its-lehmann.de header.b=EMewKM8w; dkim=permerror (0-bit key) header.d=its-lehmann.de header.i=@its-lehmann.de header.b=4HUGSWOC; arc=pass smtp.client-ip=81.169.146.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=its-lehmann.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=its-lehmann.de
ARC-Seal: i=1; a=rsa-sha256; t=1708956609; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ps/IutxIBlNutwo6dc9GXkjlClJTL+cAkBDEXMKCteA2Ct7YXIVKbz3vvws/QvZ1XY
    76hIMUVd+DDzx+gvBg3bP8FhIo5bEha8pafwTbAp1l9sa2aR7LmUZt9Q4mUTuvW18OTE
    gw4PH6UaFOgMm21fISR+xLvOLo0f+m5ODWR7PsvVxQU6t9Snz13EdRu5mCOinIvYZ54F
    xyd75/1YnAC3p1+zbkBhq7j/tksfzxJ8hXopbMH8MIms98fMvIJ9IakEdRIhvxwnBV+T
    iMV4BVLuOq4qRZRx3E7LRrba3CbMQ8TCtTcg1mbibl+SVDwJK4bLlQgUQ50IMpcUfLC1
    fZYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1708956609;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=BA9QvLSKxg7k0DtxtUMLkEtjYGCtYUDMjsCzfcEvpQM=;
    b=s3Mtvk98c29A+Bkudf0w/9fNnaO/pkkf72OnMMX+2Qoju6Mir0ENuUXX45+9VA2ONU
    Uu4jf41l32tjR41ZuR0cF3bcvRbi/yl/hwmA4UCqOsv5q57ngjGeOmZ8KvcDb9viiNAK
    FzL20YQqjzMvor1Yxe4Xu0D58AUeWszgJAJXJW8OSDuANx/PVg2xocgodv7tZKn5f64t
    XlRjfeO/8b4t3AwezVgozJyVNw008+rmSgCwMJsj0zHCPx4rHRi1b4yNcNX2vfKQvkJ/
    Q93Xx0VrK2GC+4lAbJTh+6tlCULi3b9f3tsgCtvDfIVA9wQYgXhvFvf6y7SWGqPAe1Ag
    3jIg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1708956609;
    s=strato-dkim-0002; d=its-lehmann.de;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=BA9QvLSKxg7k0DtxtUMLkEtjYGCtYUDMjsCzfcEvpQM=;
    b=EMewKM8wpZl5Gm0eiBE3xelsB8kZZfvId2ojA45GLuvQqmhYYSsgtRqpjTVxRdNJNe
    G3tieyZX6J8fIWqSMNqR/Jos3QfhFTqlGgwcF1cwn3IO532X7WNw2Gp2TSExok/LtyfD
    cbTIGpPmKEqYCA5qRqttMH1WT1hZ9kcif4IdKlba6+S2QiSwDxkMO9r/bx77IvLc0DEs
    vXGQRDgnIsUbs039iOSWu3JKDnVT+wsf3DeQNlanXLOJRDlYvLKQlWUmiwKA6/xeToSN
    wgseb2BL6nlYFNYWVx50iGFSMj1mswGvVWK4wL4nDeAPt0xhAUHWEMPFnsPFXdgVx977
    8p6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1708956609;
    s=strato-dkim-0003; d=its-lehmann.de;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=BA9QvLSKxg7k0DtxtUMLkEtjYGCtYUDMjsCzfcEvpQM=;
    b=4HUGSWOC+0EgVPTBfqLxdZfKGer2FiWD6MdI7kGuAmPs/B4BVuEGCTcDxmwE8h+wge
    seNVpzrMm2IDSVR8tcCg==
X-RZG-AUTH: ":O2kGeEG7b/pS1EStWDK/jCLPExyYkt/SDqe5Kvd1cpbwFslnfw5yO5h7fecBcqtpZg9l/KmVSxtGXaxS"
Received: from elf.os.its-lehmann.de
    by smtp.strato.de (RZmta 50.0.4 AUTH)
    with ESMTPSA id La9cc101QEA9BJs
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 26 Feb 2024 15:10:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by elf.os.its-lehmann.de (Postfix) with ESMTP id 043432400B90F;
	Mon, 26 Feb 2024 15:10:09 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at its-lehmann.de
Received: from elf.os.its-lehmann.de ([127.0.0.1])
	by localhost (elf.os.its-lehmann.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DOVLwyTID59J; Mon, 26 Feb 2024 15:10:06 +0100 (CET)
Received: from [IPV6:2001:470:9942:0:f8f9:20d:2ab3:3de5] (unknown [IPv6:2001:470:9942:0:f8f9:20d:2ab3:3de5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: al@its-lehmann.de)
	by elf.os.its-lehmann.de (Postfix) with ESMTPSA id 04DC82400B90D;
	Mon, 26 Feb 2024 15:10:05 +0100 (CET)
Message-ID: <9cf005c3-913f-47e2-a354-cba2ce968c48@its-lehmann.de>
Date: Mon, 26 Feb 2024 15:10:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: intel i225 NIC loses PCIe link, network becomes unusable)
Content-Language: en-US
From: Arno Lehmann <al@its-lehmann.de>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 "David S. Miller" <davem@davemloft.net>
References: <3179622f-7090-4a57-98ba-9042809a0d2a@its-lehmann.de>
Organization: IT-Service Lehmann
In-Reply-To: <3179622f-7090-4a57-98ba-9042809a0d2a@its-lehmann.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi all,

I couldn't see any replies to this issue (but I'm also not subscribed to 
the list, probably something I should consider...) but I have another 
instance of the issue reported.

Now cc'ing other parties in the hope to get indication this is already 
solved (somehow) or will be looked into.

Additional kernel messages about latest case below the quoted original mail!

On 12.02.24 at 11:39, Arno Lehmann wrote:
> Hello everybody,
> 
> I'm struggling with the problem named in the subject.
> 
> Originally reported to the debian bug tracker; you'll find the history 
> here: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1060706
> 
> Infrequently, and apparently randomly, I have the situation that the 
> PCIe link for the NIC is lost. Obviously, the network then becomes 
> unusable. rmmod / modprobe'ing the igc module does not resolve this 
> problem, a reboot is necessary.
> 
> I noticed this initially when installing the system last year, did a bit 
> of a search, found that the kernel option 'pcie_aspm=off' was supposed 
> to be useful, set that, and have that enabled ever since.
> 
> The problem persists.
> 
> Most recent case is this one:
> 
> [So Feb 11 15:47:18 2024] igc 0000:0b:00.0 eno1: NIC Link is Down
> [So Feb 11 15:47:21 2024] igc 0000:0b:00.0 eno1: NIC Link is Up 1000 
> Mbps Full Duplex, Flow Control: RX
> [So Feb 11 16:52:01 2024] igc 0000:0b:00.0 eno1: NIC Link is Down
> [So Feb 11 16:52:05 2024] igc 0000:0b:00.0 eno1: NIC Link is Up 1000 
> Mbps Full Duplex, Flow Control: RX
> 
> (I have no idea if the above to events have any relevance.)
> 
> [So Feb 11 18:47:59 2024] igc 0000:0b:00.0 eno1: PCIe link lost, device 
> now detached
> [So Feb 11 18:47:59 2024] ------------[ cut here ]------------
> [So Feb 11 18:47:59 2024] igc: Failed to read reg 0xc030!
> [So Feb 11 18:47:59 2024] WARNING: CPU: 20 PID: 136256 at 
> drivers/net/ethernet/intel/igc/igc_main.c:6583 igc_rd32+0x8d/0xa0 [igc]
> [So Feb 11 18:47:59 2024] Modules linked in: rfcomm cpufreq_userspace 
> cpufreq_powersave cpufreq_ondemand cpufreq_conservative nfsv3 nfs_acl 
> rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache 
> netfs overlay qrtr cmac algif_hash algif_skcipher af_alg bnep sunrpc 
> binfmt_misc nls_ascii nls_cp437 vfat fat ext4 mbcache jbd2 
> intel_rapl_msr intel_rapl_common btusb btrtl btbcm btintel btmtk 
> bluetooth mt7921e snd_hda_codec_hdmi mt7921_common mt76_connac_lib 
> edac_mce_amd snd_hda_intel mt76 snd_intel_dspcfg kvm_amd 
> snd_intel_sdw_acpi sha3_generic mac80211 jitterentropy_rng snd_usb_audio 
> uvcvideo snd_hda_codec drbg libarc4 videobuf2_vmalloc snd_usbmidi_lib 
> asus_nb_wmi eeepc_wmi kvm uvc videobuf2_memops snd_rawmidi ansi_cprng 
> snd_hda_core asus_wmi videobuf2_v4l2 snd_seq_device snd_hwdep 
> ecdh_generic irqbypass battery ecc ledtrig_audio videodev snd_pcm 
> sparse_keymap cfg80211 crc16 rapl snd_timer videobuf2_common 
> platform_profile wmi_bmof sp5100_tco pcspkr snd ccp mc watchdog k10temp 
> soundcore rfkill joydev sg evdev msr
> [So Feb 11 18:47:59 2024]  parport_pc ppdev lp parport fuse loop 
> efi_pstore configfs efivarfs ip_tables x_tables autofs4 xfs libcrc32c 
> crc32c_generic sd_mod dm_crypt dm_mod uas usb_storage hid_generic amdgpu 
> amdxcp drm_buddy gpu_sched usbhid i2c_algo_bit drm_suballoc_helper hid 
> drm_display_helper sr_mod cdrom cec rc_core crc32_pclmul drm_ttm_helper 
> crc32c_intel ghash_clmulni_intel ttm ahci sha512_ssse3 sha512_generic 
> libahci nvme xhci_pci drm_kms_helper libata xhci_hcd nvme_core drm 
> aesni_intel t10_pi usbcore scsi_mod crypto_simd crc64_rocksoft_generic 
> igc cryptd crc64_rocksoft crc_t10dif crct10dif_generic i2c_piix4 
> crct10dif_pclmul crc64 crct10dif_common scsi_common usb_common video wmi 
> gpio_amdpt gpio_generic button
> [So Feb 11 18:47:59 2024] CPU: 20 PID: 136256 Comm: kworker/20:0 Not 
> tainted 6.5.0-0.deb12.4-amd64 #1  Debian 6.5.10-1~bpo12+1
> [So Feb 11 18:47:59 2024] Hardware name: ASUS System Product Name/ROG 
> STRIX X670E-A GAMING WIFI, BIOS 1904 01/29/2024
> [So Feb 11 18:47:59 2024] Workqueue: events igc_watchdog_task [igc]
> [So Feb 11 18:47:59 2024] RIP: 0010:igc_rd32+0x8d/0xa0 [igc]
> [So Feb 11 18:47:59 2024] Code: 48 c7 c6 10 76 36 c0 e8 81 6a c1 d5 48 
> 8b bb 28 ff ff ff e8 05 d2 97 d5 84 c0 74 bc 89 ee 48 c7 c7 38 76 36 c0 
> e8 c3 ee 36 d5 <0f> 0b eb aa b8 ff ff ff ff e9 15 cf e7 d5 0f 1f 44 00 
> 00 90 90 90
> [So Feb 11 18:47:59 2024] RSP: 0018:ffffa203cfe8fdd8 EFLAGS: 00010282
> [So Feb 11 18:47:59 2024] RAX: 0000000000000000 RBX: ffff961b5c75ccb8 
> RCX: 0000000000000027
> [So Feb 11 18:47:59 2024] RDX: ffff962a5e7213c8 RSI: 0000000000000001 
> RDI: ffff962a5e7213c0
> [So Feb 11 18:47:59 2024] RBP: 000000000000c030 R08: 0000000000000000 
> R09: ffffa203cfe8fc68
> [So Feb 11 18:47:59 2024] R10: 0000000000000003 R11: ffff962a9de3ac28 
> R12: ffff961b5c75c000
> [So Feb 11 18:47:59 2024] R13: 0000000000000000 R14: ffff961b54c92d40 
> R15: 000000000000c030
> [So Feb 11 18:47:59 2024] FS:  0000000000000000(0000) 
> GS:ffff962a5e700000(0000) knlGS:0000000000000000
> [So Feb 11 18:47:59 2024] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [So Feb 11 18:47:59 2024] CR2: 00007fb76de93000 CR3: 00000001153d0000 
> CR4: 0000000000750ee0
> [So Feb 11 18:47:59 2024] PKRU: 55555554
> [So Feb 11 18:47:59 2024] Call Trace:
> [So Feb 11 18:47:59 2024]  <TASK>
> [So Feb 11 18:47:59 2024]  ? igc_rd32+0x8d/0xa0 [igc]
> [So Feb 11 18:47:59 2024]  ? __warn+0x81/0x130
> [So Feb 11 18:47:59 2024]  ? igc_rd32+0x8d/0xa0 [igc]
> [So Feb 11 18:47:59 2024]  ? report_bug+0x171/0x1a0
> [So Feb 11 18:47:59 2024]  ? srso_alias_return_thunk+0x5/0x7f
> [So Feb 11 18:47:59 2024]  ? prb_read_valid+0x1b/0x30
> [So Feb 11 18:47:59 2024]  ? handle_bug+0x41/0x70
> [So Feb 11 18:47:59 2024]  ? exc_invalid_op+0x17/0x70
> [So Feb 11 18:47:59 2024]  ? asm_exc_invalid_op+0x1a/0x20
> [So Feb 11 18:47:59 2024]  ? igc_rd32+0x8d/0xa0 [igc]
> [So Feb 11 18:47:59 2024]  ? igc_rd32+0x8d/0xa0 [igc]
> [So Feb 11 18:47:59 2024]  igc_update_stats+0x8a/0x6d0 [igc]
> [So Feb 11 18:47:59 2024]  igc_watchdog_task+0x9d/0x4a0 [igc]
> [So Feb 11 18:47:59 2024]  process_one_work+0x1df/0x3e0
> [So Feb 11 18:47:59 2024]  worker_thread+0x51/0x390
> [So Feb 11 18:47:59 2024]  ? __pfx_worker_thread+0x10/0x10
> [So Feb 11 18:47:59 2024]  kthread+0xe5/0x120
> [So Feb 11 18:47:59 2024]  ? __pfx_kthread+0x10/0x10
> [So Feb 11 18:47:59 2024]  ret_from_fork+0x31/0x50
> [So Feb 11 18:47:59 2024]  ? __pfx_kthread+0x10/0x10
> [So Feb 11 18:47:59 2024]  ret_from_fork_asm+0x1b/0x30
> [So Feb 11 18:47:59 2024]  </TASK>
> [So Feb 11 18:47:59 2024] ---[ end trace 0000000000000000 ]---
> 
> 
> With the guidance from the friendly folks at the debian bug tracker, we 
> could find that this happens with many kernel versions, as can be 
> derived from the following (condensed list below):
> 
> # journalctl  --grep '(Linux version|PCIe link lost)' --quiet | cat
> Aug 30 18:16:18 Zwerg kernel: Linux version 6.1.0-11-amd64 
> (debian-kernel@lists.debian.org) (gcc-12 (Debian 12.2.0-14) 12.2.0, GNU 
> ld (GNU Binutils for Debian) 2.40) #1 SMP PREEMPT_DYNAMIC Debian 
> 6.1.38-4 (2023-08-08)
> Sep 20 14:21:17 Zwerg kernel: igc 0000:0a:00.0 eno1: PCIe link lost, 
> device now detached
> Sep 20 19:47:06 Zwerg kernel: Linux version 6.1.0-11-amd64 
> (debian-kernel@lists.debian.org) (gcc-12 (Debian 12.2.0-14) 12.2.0, GNU 
> ld (GNU Binutils for Debian) 2.40) #1 SMP PREEMPT_DYNAMIC Debian 
> 6.1.38-4 (2023-08-08)
> Okt 04 17:16:08 Zwerg kernel: Linux version 6.1.0-12-amd64 
> (debian-kernel@lists.debian.org) (gcc-12 (Debian 12.2.0-14) 12.2.0, GNU 
> ld (GNU Binutils for Debian) 2.40) #1 SMP PREEMPT_DYNAMIC Debian 
> 6.1.52-1 (2023-09-07)
> Okt 06 05:44:20 Zwerg kernel: igc 0000:0a:00.0 eno1: PCIe link lost, 
> device now detached
> Okt 07 16:39:10 Zwerg kernel: igc 0000:0a:00.0 (unnamed net_device) 
> (uninitialized): PCIe link lost, device now detached
> Okt 07 16:43:41 Zwerg kernel: Linux version 6.1.0-12-amd64 
> (debian-kernel@lists.debian.org) (gcc-12 (Debian 12.2.0-14) 12.2.0, GNU 
> ld (GNU Binutils for Debian) 2.40) #1 SMP PREEMPT_DYNAMIC Debian 
> 6.1.52-1 (2023-09-07)
> Okt 23 18:23:54 Zwerg kernel: Linux version 6.1.0-12-amd64 
> (debian-kernel@lists.debian.org) (gcc-12 (Debian 12.2.0-14) 12.2.0, GNU 
> ld (GNU Binutils for Debian) 2.40) #1 SMP PREEMPT_DYNAMIC Debian 
> 6.1.52-1 (2023-09-07)
> Okt 23 18:31:25 Zwerg kernel: igc 0000:0a:00.0 eno1: PCIe link lost, 
> device now detached
> Okt 23 18:48:58 Zwerg kernel: Linux version 6.1.0-13-amd64 
> (debian-kernel@lists.debian.org) (gcc-12 (Debian 12.2.0-14) 12.2.0, GNU 
> ld (GNU Binutils for Debian) 2.40) #1 SMP PREEMPT_DYNAMIC Debian 
> 6.1.55-1 (2023-09-29)
> Okt 30 11:16:06 Zwerg kernel: igc 0000:0a:00.0 eno1: PCIe link lost, 
> device now detached
> Okt 31 13:50:06 Zwerg kernel: igc 0000:0a:00.0 (unnamed net_device) 
> (uninitialized): PCIe link lost, device now detached
> Okt 31 13:52:01 Zwerg kernel: Linux version 6.1.0-13-amd64 
> (debian-kernel@lists.debian.org) (gcc-12 (Debian 12.2.0-14) 12.2.0, GNU 
> ld (GNU Binutils for Debian) 2.40) #1 SMP PREEMPT_DYNAMIC Debian 
> 6.1.55-1 (2023-09-29)
> Nov 22 18:59:11 Zwerg kernel: igc 0000:0a:00.0 eno1: PCIe link lost, 
> device now detached
> Nov 23 12:18:19 Zwerg kernel: Linux version 6.1.0-13-amd64 
> (debian-kernel@lists.debian.org) (gcc-12 (Debian 12.2.0-14) 12.2.0, GNU 
> ld (GNU Binutils for Debian) 2.40) #1 SMP PREEMPT_DYNAMIC Debian 
> 6.1.55-1 (2023-09-29)
> Nov 23 15:45:49 Zwerg kernel: igc 0000:0a:00.0 eno1: PCIe link lost, 
> device now detached
> Nov 23 15:52:51 Zwerg kernel: Linux version 6.1.0-13-amd64 
> (debian-kernel@lists.debian.org) (gcc-12 (Debian 12.2.0-14) 12.2.0, GNU 
> ld (GNU Binutils for Debian) 2.40) #1 SMP PREEMPT_DYNAMIC Debian 
> 6.1.55-1 (2023-09-29)
> Dez 06 19:06:18 Zwerg kernel: Linux version 6.1.0-13-amd64 
> (debian-kernel@lists.debian.org) (gcc-12 (Debian 12.2.0-14) 12.2.0, GNU 
> ld (GNU Binutils for Debian) 2.40) #1 SMP PREEMPT_DYNAMIC Debian 
> 6.1.55-1 (2023-09-29)
> Dez 09 15:12:13 Zwerg kernel: Linux version 6.1.0-14-amd64 
> (debian-kernel@lists.debian.org) (gcc-12 (Debian 12.2.0-14) 12.2.0, GNU 
> ld (GNU Binutils for Debian) 2.40) #1 SMP PREEMPT_DYNAMIC Debian 
> 6.1.64-1 (2023-11-30)
> Dez 19 07:33:02 Zwerg kernel: igc 0000:0a:00.0 eno1: PCIe link lost, 
> device now detached
> Dez 20 10:29:21 Zwerg kernel: Linux version 6.1.0-15-amd64 
> (debian-kernel@lists.debian.org) (gcc-12 (Debian 12.2.0-14) 12.2.0, GNU 
> ld (GNU Binutils for Debian) 2.40) #1 SMP PREEMPT_DYNAMIC Debian 
> 6.1.66-1 (2023-12-09)
> Jan 01 09:57:40 Zwerg kernel: igc 0000:0a:00.0 eno1: PCIe link lost, 
> device now detached
> Jan 02 13:41:33 Zwerg kernel: Linux version 6.1.0-15-amd64 
> (debian-kernel@lists.debian.org) (gcc-12 (Debian 12.2.0-14) 12.2.0, GNU 
> ld (GNU Binutils for Debian) 2.40) #1 SMP PREEMPT_DYNAMIC Debian 
> 6.1.66-1 (2023-12-09)
> Jan 10 16:15:20 Zwerg kernel: igc 0000:0a:00.0 eno1: PCIe link lost, 
> device now detached
> Jan 13 11:02:41 Zwerg kernel: Linux version 6.1.0-17-amd64 
> (debian-kernel@lists.debian.org) (gcc-12 (Debian 12.2.0-14) 12.2.0, GNU 
> ld (GNU Binutils for Debian) 2.40) #1 SMP PREEMPT_DYNAMIC Debian 
> 6.1.69-1 (2023-12-30)
> Jan 13 11:16:31 Zwerg kernel: igc 0000:0a:00.0 eno1: PCIe link lost, 
> device now detached
> Jan 13 11:18:13 Zwerg kernel: Linux version 6.1.0-17-amd64 
> (debian-kernel@lists.debian.org) (gcc-12 (Debian 12.2.0-14) 12.2.0, GNU 
> ld (GNU Binutils for Debian) 2.40) #1 SMP PREEMPT_DYNAMIC Debian 
> 6.1.69-1 (2023-12-30)
> Jan 19 14:25:08 Zwerg kernel: Linux version 6.1.0-1-amd64 
> (debian-kernel@lists.debian.org) (gcc-12 (Debian 12.2.0-13) 12.2.0, GNU 
> ld (GNU Binutils for Debian) 2.39.90.20221231) #1 SMP PREEMPT_DYNAMIC 
> Debian 6.1.4-1 (2023-01-07)
> Jan 27 09:41:16 Zwerg kernel: Linux version 6.1.0-17-amd64 
> (debian-kernel@lists.debian.org) (gcc-12 (Debian 12.2.0-14) 12.2.0, GNU 
> ld (GNU Binutils for Debian) 2.40) #1 SMP PREEMPT_DYNAMIC Debian 
> 6.1.69-1 (2023-12-30)
> Jan 27 09:44:53 Zwerg kernel: igc 0000:0a:00.0 eno1: PCIe link lost, 
> device now detached
> Jan 27 09:48:05 Zwerg kernel: igc 0000:0a:00.0 (unnamed net_device) 
> (uninitialized): PCIe link lost, device now detached
> Jan 27 09:52:16 Zwerg kernel: igc 0000:0a:00.0 (unnamed net_device) 
> (uninitialized): PCIe link lost, device now detached
> Jan 27 09:58:46 Zwerg kernel: Linux version 6.1.0-1-amd64 
> (debian-kernel@lists.debian.org) (gcc-12 (Debian 12.2.0-13) 12.2.0, GNU 
> ld (GNU Binutils for Debian) 2.39.90.20221231) #1 SMP PREEMPT_DYNAMIC 
> Debian 6.1.4-1 (2023-01-07)
> Feb 01 04:19:17 Zwerg kernel: igc 0000:0a:00.0 eno1: PCIe link lost, 
> device now detached
> Feb 01 14:43:03 Zwerg kernel: igc 0000:0a:00.0 (unnamed net_device) 
> (uninitialized): PCIe link lost, device now detached
> Feb 01 14:50:04 Zwerg kernel: Linux version 6.1.0-17-amd64 
> (debian-kernel@lists.debian.org) (gcc-12 (Debian 12.2.0-14) 12.2.0, GNU 
> ld (GNU Binutils for Debian) 2.40) #1 SMP PREEMPT_DYNAMIC Debian 
> 6.1.69-1 (2023-12-30)
> Feb 01 15:28:42 Zwerg kernel: Linux version 6.5.0-0.deb12.4-amd64 
> (debian-kernel@lists.debian.org) (gcc-12 (Debian 12.2.0-14) 12.2.0, GNU 
> ld (GNU Binutils for Debian) 2.40) #1 SMP PREEMPT_DYNAMIC Debian 
> 6.5.10-1~bpo12+1 (2023-11-23)
> Feb 08 18:26:31 Zwerg kernel: Linux version 6.5.0-0.deb12.4-amd64 
> (debian-kernel@lists.debian.org) (gcc-12 (Debian 12.2.0-14) 12.2.0, GNU 
> ld (GNU Binutils for Debian) 2.40) #1 SMP PREEMPT_DYNAMIC Debian 
> 6.5.10-1~bpo12+1 (2023-11-23)
> Feb 08 18:33:38 Zwerg kernel: igc 0000:0a:00.0 eno1: PCIe link lost, 
> device now detached
> Feb 08 18:58:25 Zwerg kernel: Linux version 6.5.0-0.deb12.4-amd64 
> (debian-kernel@lists.debian.org) (gcc-12 (Debian 12.2.0-14) 12.2.0, GNU 
> ld (GNU Binutils for Debian) 2.40) #1 SMP PREEMPT_DYNAMIC Debian 
> 6.5.10-1~bpo12+1 (2023-11-23)
> Feb 08 19:00:32 Zwerg kernel: igc 0000:0b:00.0 eno1: PCIe link lost, 
> device now detached
> Feb 08 19:02:38 Zwerg kernel: igc 0000:0b:00.0 (unnamed net_device) 
> (uninitialized): PCIe link lost, device now detached
> Feb 08 19:05:30 Zwerg kernel: Linux version 6.5.0-0.deb12.4-amd64 
> (debian-kernel@lists.debian.org) (gcc-12 (Debian 12.2.0-14) 12.2.0, GNU 
> ld (GNU Binutils for Debian) 2.40) #1 SMP PREEMPT_DYNAMIC Debian 
> 6.5.10-1~bpo12+1 (2023-11-23)
> Feb 09 13:25:08 Zwerg kernel: igc 0000:0b:00.0 eno1: PCIe link lost, 
> device now detached
> Feb 09 13:27:17 Zwerg kernel: igc 0000:0b:00.0 (unnamed net_device) 
> (uninitialized): PCIe link lost, device now detached
> Feb 09 13:30:42 Zwerg kernel: Linux version 6.5.0-0.deb12.4-amd64 
> (debian-kernel@lists.debian.org) (gcc-12 (Debian 12.2.0-14) 12.2.0, GNU 
> ld (GNU Binutils for Debian) 2.40) #1 SMP PREEMPT_DYNAMIC Debian 
> 6.5.10-1~bpo12+1 (2023-11-23)
> Feb 11 18:47:57 Zwerg kernel: igc 0000:0b:00.0 eno1: PCIe link lost, 
> device now detached
> Feb 12 10:55:30 Zwerg kernel: Linux version 6.1.0-17-amd64 
> (debian-kernel@lists.debian.org) (gcc-12 (Debian 12.2.0-14) 12.2.0, GNU 
> ld (GNU Binutils for Debian) 2.40) #1 SMP PREEMPT_DYNAMIC Debian 
> 6.1.69-1 (2023-12-30)
> 
> The kernel version I used were
> 
> Debian 6.1.4-1 (2023-01-07)
> Debian 6.1.38-4 (2023-08-08)
> Debian 6.1.52-1 (2023-09-07)
> Debian 6.1.55-1 (2023-09-29)
> Debian 6.1.64-1 (2023-11-30)
> Debian 6.1.66-1 (2023-12-09)
> Debian 6.1.69-1 (2023-12-30)
> Debian 6.5.10-1~bpo12+1 (2023-11-23)
> 
> 
> At this point, it looks like at least one person with a bit of insight 
> is convinced this is an upstream issue.
> 
> Of course I'll try to provide whatever information else may be needed.
> 
> Most importantly, I think, is the hardware surrounding the NIC:
> This is an ASUSTeK COMPUTER INC. ROG STRIX X670E-A GAMING WIFI, i.e. AMD 
> X670 chipset with fershly updated BIOS: 1904 01/29/2024. CPU is an AMD 
> Ryzen 9 7900X.
> 
> I have not set any particular overclocking or performance options, just 
> tried to have all firmware settings on "conservative".
> 
> 
> Mass storage is a Western Digital SN850X NVMe device.
> 
> I have experienced two cases where the storage device apparently 
> "vanished" from the PCIe bus, which resulted in a flood of journald 
> messages that it could not log anything to persistent storage. I have 
> never seen the first few lines of thos occurences, and obviously, I have 
> no logs.
> 
> I did notice, however, that the system still responded to pings on the 
> network.
> 
> All of this seems to indicate that this might be related to PCIe power 
> management. I suspect that my gut feeling is not the best starting point 
> to decide how to proceed here.
> 
> So, if you any way to improve this situation and make the system 
> reliably usable, I'm willing to help in any way I can, but you'll have 
> to tell me what to do!


[So Feb 25 13:36:36 2024] igc 0000:0b:00.0 eno1: PCIe link lost, device 
now detached
[So Feb 25 13:36:36 2024] ------------[ cut here ]------------
[So Feb 25 13:36:36 2024] igc: Failed to read reg 0xc030!
[So Feb 25 13:36:36 2024] WARNING: CPU: 20 PID: 1152218 at 
drivers/net/ethernet/intel/igc/igc_main.c:6583 igc_rd32+0x8d/0xa0 [igc]
[So Feb 25 13:36:36 2024] Modules linked in: cpuid isofs exfat rfcomm 
cpufreq_userspace cpufreq_powersave cpufreq_ondemand 
cpufreq_conservative nfsv3 nfs_acl rpcsec_gss_krb5 auth_rpcgss nfsv4 
dns_resolver nfs lockd grace fscache netfs qrtr overlay cmac algif_hash 
algif_skcipher af_alg bnep sunrpc binfmt_misc nls_ascii nls_cp437 vfat 
fat ext4 mbcache jbd2 intel_rapl_msr intel_rapl_common btusb btrtl btbcm 
btintel mt7921e btmtk mt7921_common snd_hda_codec_hdmi bluetooth 
mt76_connac_lib edac_mce_amd mt76 snd_hda_intel kvm_amd snd_intel_dspcfg 
mac80211 snd_intel_sdw_acpi sha3_generic snd_usb_audio jitterentropy_rng 
snd_hda_codec uvcvideo kvm snd_usbmidi_lib videobuf2_vmalloc 
snd_hda_core uvc drbg videobuf2_memops snd_rawmidi libarc4 
videobuf2_v4l2 asus_nb_wmi snd_hwdep eeepc_wmi snd_seq_device asus_wmi 
ansi_cprng videodev irqbypass ecdh_generic battery snd_pcm ecc 
ledtrig_audio sparse_keymap cfg80211 crc16 rapl platform_profile 
videobuf2_common wmi_bmof sp5100_tco ccp snd_timer watchdog k10temp 
pcspkr mc snd soundcore rfkill joydev sg
[So Feb 25 13:36:36 2024]  evdev msr parport_pc ppdev lp parport fuse 
loop efi_pstore configfs efivarfs ip_tables x_tables autofs4 xfs 
libcrc32c crc32c_generic sd_mod dm_crypt dm_mod uas usb_storage 
hid_generic amdgpu amdxcp drm_buddy usbhid gpu_sched i2c_algo_bit hid 
drm_suballoc_helper sr_mod drm_display_helper cdrom cec crc32_pclmul 
rc_core crc32c_intel drm_ttm_helper ghash_clmulni_intel ttm ahci 
xhci_pci sha512_ssse3 xhci_hcd libahci sha512_generic nvme 
drm_kms_helper libata nvme_core t10_pi usbcore aesni_intel drm 
crc64_rocksoft_generic scsi_mod crypto_simd cryptd crc64_rocksoft igc 
crc_t10dif crct10dif_generic crct10dif_pclmul i2c_piix4 crc64 
crct10dif_common usb_common scsi_common video wmi gpio_amdpt 
gpio_generic button
[So Feb 25 13:36:36 2024] CPU: 20 PID: 1152218 Comm: kworker/20:1 Not 
tainted 6.5.0-0.deb12.4-amd64 #1  Debian 6.5.10-1~bpo12+1
[So Feb 25 13:36:36 2024] Hardware name: ASUS System Product Name/ROG 
STRIX X670E-A GAMING WIFI, BIOS 1904 01/29/2024
[So Feb 25 13:36:36 2024] Workqueue: events igc_watchdog_task [igc]
[So Feb 25 13:36:36 2024] RIP: 0010:igc_rd32+0x8d/0xa0 [igc]
[So Feb 25 13:36:36 2024] Code: 48 c7 c6 10 c6 37 c0 e8 81 1a 00 e8 48 
8b bb 28 ff ff ff e8 05 82 d6 e7 84 c0 74 bc 89 ee 48 c7 c7 38 c6 37 c0 
e8 c3 9e 75 e7 <0f> 0b eb aa b8 ff ff ff ff e9 15 7f 26 e8 0f 1f 44 00 
00 90 90 90
[So Feb 25 13:36:36 2024] RSP: 0018:ffffba4fe269fdd8 EFLAGS: 00010282
[So Feb 25 13:36:36 2024] RAX: 0000000000000000 RBX: ffff9cdc625c4cb8 
RCX: 0000000000000027
[So Feb 25 13:36:36 2024] RDX: ffff9ceb5e7213c8 RSI: 0000000000000001 
RDI: ffff9ceb5e7213c0
[So Feb 25 13:36:36 2024] RBP: 000000000000c030 R08: 0000000000000000 
R09: ffffba4fe269fc68
[So Feb 25 13:36:36 2024] R10: 0000000000000003 R11: ffff9ceb9de24d28 
R12: ffff9cdc625c4000
[So Feb 25 13:36:36 2024] R13: 0000000000000000 R14: ffff9cdc618b5d40 
R15: 000000000000c030
[So Feb 25 13:36:36 2024] FS:  0000000000000000(0000) 
GS:ffff9ceb5e700000(0000) knlGS:0000000000000000
[So Feb 25 13:36:36 2024] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[So Feb 25 13:36:36 2024] CR2: 00007f030a057000 CR3: 000000047234a000 
CR4: 0000000000750ee0
[So Feb 25 13:36:36 2024] PKRU: 55555554
[So Feb 25 13:36:36 2024] Call Trace:
[So Feb 25 13:36:36 2024]  <TASK>
[So Feb 25 13:36:36 2024]  ? igc_rd32+0x8d/0xa0 [igc]
[So Feb 25 13:36:36 2024]  ? __warn+0x81/0x130
[So Feb 25 13:36:36 2024]  ? igc_rd32+0x8d/0xa0 [igc]
[So Feb 25 13:36:36 2024]  ? report_bug+0x171/0x1a0
[So Feb 25 13:36:36 2024]  ? srso_alias_return_thunk+0x5/0x7f
[So Feb 25 13:36:36 2024]  ? prb_read_valid+0x1b/0x30
[So Feb 25 13:36:36 2024]  ? handle_bug+0x41/0x70
[So Feb 25 13:36:36 2024]  ? exc_invalid_op+0x17/0x70
[So Feb 25 13:36:36 2024]  ? asm_exc_invalid_op+0x1a/0x20
[So Feb 25 13:36:36 2024]  ? igc_rd32+0x8d/0xa0 [igc]
[So Feb 25 13:36:36 2024]  ? igc_rd32+0x8d/0xa0 [igc]
[So Feb 25 13:36:36 2024]  igc_update_stats+0x8a/0x6d0 [igc]
[So Feb 25 13:36:36 2024]  igc_watchdog_task+0x9d/0x4a0 [igc]
[So Feb 25 13:36:36 2024]  process_one_work+0x1df/0x3e0
[So Feb 25 13:36:36 2024]  worker_thread+0x51/0x390
[So Feb 25 13:36:36 2024]  ? __pfx_worker_thread+0x10/0x10
[So Feb 25 13:36:36 2024]  kthread+0xe5/0x120
[So Feb 25 13:36:36 2024]  ? __pfx_kthread+0x10/0x10
[So Feb 25 13:36:36 2024]  ret_from_fork+0x31/0x50
[So Feb 25 13:36:36 2024]  ? __pfx_kthread+0x10/0x10
[So Feb 25 13:36:36 2024]  ret_from_fork_asm+0x1b/0x30
[So Feb 25 13:36:36 2024]  </TASK>
[So Feb 25 13:36:36 2024] ---[ end trace 0000000000000000 ]---


Cheers,

Arno

-- 
Arno Lehmann

IT-Service Lehmann
Sandstr. 6, 49080 Osnabrück

