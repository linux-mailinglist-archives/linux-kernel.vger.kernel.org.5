Return-Path: <linux-kernel+bounces-144058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 047488A4159
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 10:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39396B216E9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 08:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165D5224EF;
	Sun, 14 Apr 2024 08:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9RRAXuf"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDBA18AF4
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 08:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713084623; cv=none; b=mWuDYQj902F499TnRTIZLHWbkQqoJulRJXlwwW78tOB8PBSDfougHZBb/NlQss6BVc8y6wcgJa/5s1xD8t40xzsxmJeG6FRKYlrM9NhE50iQJuqmjmrmIn0h+9NZVIB4A1PqtU/xX157kN1KkcMasCGCxG4WtVpPpQZbHh7BzmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713084623; c=relaxed/simple;
	bh=NNPumB7LchL6aoCn51NvwLKnP+1ATOWWUfnd7rGpxn8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=q9hjqG649NegZkfpY9D43mYVcxFvDGZQyMwGcX4kRqJV6Hsrnp4mUhv3woyh8RWewxl3hHXpu+PON+V+iwBRYKQLDpracnbcEDVR9/1y67afDKvVsLdnpWvCcxW5fc6b09Af/manf8+0UQQrYhkE+8DV7lB3kBCZvf+XV7/eDu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9RRAXuf; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-417e327773cso14604425e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 01:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713084620; x=1713689420; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=436excT5e+VgNjsnhYEu2T5nOJsC9/0bFlxYKR5yiEs=;
        b=a9RRAXufLj47cp+1jNyozD6VJLcZ8pUXLjmZnb/WB8DWUL1rGhVtPY1AR4gVwjlYWB
         ppsmNkhcnVJK04txNkvlJM3Na/Qi4R5WmPZp7JgoQHLp0B0OdGE2uAU4ZAfxp5afAvkL
         sXuaurZWIamGVO7zvEswunLC+bXYOO2CRCZFxomxjFFVCFEmiNtG4o/8s2vJ0ZRRd0lq
         lyDrZB7YrX5HwI5ZwRLQcRvLDl+ktMKhk97d0ZFCvcrZjxFJ+fZ3CuRfr7EytPsup5pI
         3ZXWCg8pRqipTvGqC3HlKukR0rmsMptrCLlSXY+zPpfRgYThOJhC4q/tG21hN4R6K/P1
         781Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713084620; x=1713689420;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=436excT5e+VgNjsnhYEu2T5nOJsC9/0bFlxYKR5yiEs=;
        b=U9w5JuMSYUBD9OW5YTrz4oZTar10Z608ta2pVuKMm5rz5SQKgosIyTjoxySobAUdjJ
         gzCfPR23QXeyPs3I7BUM1hKqThD04RXigpOGX+2335fUe4qfKoaAlhZqOOJvMCv3Dl4R
         094Rt8XEiEKned0VYfjhhrjDQP2zizOG33U5jcH2lrpTINFupLnerucGwIPf8VLg7zMz
         4y9aA5eatwcBSsbZMScuaTHVqT4a9YeLdxdolidTKLhIBOQSWqz7E+o62OEfBucz1nym
         2n4WW7H1jLY18ffGEjmMH1U1ePqMqw+uFhpaWj/6lpIGmwMW7YfM71aQKVYaIThqn/16
         rFOw==
X-Gm-Message-State: AOJu0YzYy8tRf8ahLuz6uYZD1qhkrwfY++aditQH03pLdC0c/KorypjV
	T4yLdOgEgKinec7QDIU4Ka7t5m8B8X4zPNhUHu0fLYqBFczs9tqM
X-Google-Smtp-Source: AGHT+IEHfMKes7Tm7lzTmqPCg631or+CsH1NVZIAfHfTBV5eB3ZTsluhDW1Z2UZ8BE1EPG+mkL9xAQ==
X-Received: by 2002:a05:600c:4f0d:b0:418:2f9:12de with SMTP id l13-20020a05600c4f0d00b0041802f912demr5495392wmq.2.1713084619644;
        Sun, 14 Apr 2024 01:50:19 -0700 (PDT)
Received: from nz.home (host86-152-202-149.range86-152.btcentralplus.com. [86.152.202.149])
        by smtp.gmail.com with ESMTPSA id p15-20020a05600c468f00b00417da22df18sm10987831wmo.9.2024.04.14.01.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 01:50:19 -0700 (PDT)
Received: by nz.home (Postfix, from userid 1000)
	id 639391909A4514; Sun, 14 Apr 2024 09:50:18 +0100 (BST)
Date: Sun, 14 Apr 2024 09:50:18 +0100
From: Sergei Trofimovich <slyich@gmail.com>
To: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: 6.8 to 6.9.0-rc3: kernel NULL pointer dereference in
 pick_next_task_fair+0x89
Message-ID: <ZhuYyrh3mweP_Kd8@nz.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi kernel/sched/ maintainers!

Over past few days my machines started OOpsing when a nightly kernel
build starts. I don't have a reliable reproducer. The builder should use
`idle` CPU scheduling policy.

Which debugging options should I try to get a better clue what causes
the crash?

Thank you!

Adding a few backtraces in hope that they are useful.

Most recent one:

<1>[161961.133291] BUG: kernel NULL pointer dereference, address: 000000000=
00000a0
<1>[161961.133296] #PF: supervisor read access in kernel mode
<1>[161961.133298] #PF: error_code(0x0000) - not-present page
<6>[161961.133299] PGD 0 P4D 0
<4>[161961.133301] Oops: 0000 [#1] PREEMPT SMP NOPTI
<4>[161961.133303] CPU: 1 PID: 1181910 Comm: as Not tainted 6.9.0-rc3 #1-Ni=
xOS
<4>[161961.133305] Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS =
ULTRA/X570 AORUS ULTRA, BIOS F32 GK 01/19/2021
<4>[161961.133306] RIP: 0010:pick_next_task_fair+0x89/0x5a0
<4>[161961.133311] Code: 00 00 00 49 81 bc 24 b0 02 00 00 a0 89 7a 95 75 5e=
 4d 89 f7 eb 27 4c 89 ff e8 d3 9f ff ff 84 c0 75 3f 4c 89 ff e8 57 11 ff ff=
 <4c> 8b b8 a0 00 00 00 48 89 c3 4d 85 ff 0f 84 01 01 00 00 49 8b 47
Oops#1 Part3
<4>[161961.133312] RSP: 0018:ffffbeece7437d90 EFLAGS: 00010082
<4>[161961.133314] RAX: 0000000000000000 RBX: ffffa2647e2b5380 RCX: 0000000=
000000400
<4>[161961.133315] RDX: 9b9d1e7d431adc5a RSI: 00000000000004d6 RDI: 0000000=
0000000d6
<4>[161961.133315] RBP: ffffa2647e2b5380 R08: 00000000000000d6 R09: 0000000=
000000002
<4>[161961.133316] R10: 00000000fa83b2da R11: 0000000000da2bc9 R12: ffffa24=
eb3b31200
<4>[161961.133317] R13: ffffbeece7437e18 R14: ffffa2647e2b5480 R15: ffffa26=
47e2b5480
<4>[161961.133318] FS:  0000000000000000(0000) GS:ffffa2647e280000(0000) kn=
lGS:0000000000000000
<4>[161961.133319] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[161961.133319] CR2: 00000000000000a0 CR3: 000000183ea20000 CR4: 0000000=
000f50ef0
<4>[161961.133320] PKRU: 55555554
<4>[161961.133321] Call Trace:
<4>[161961.133322]  <TASK>
<4>[161961.133326]  ? __die+0x23/0x70
<4>[161961.133329]  ? page_fault_oops+0x173/0x580
<4>[161961.133332]  ? exc_page_fault+0x71/0x150
<4>[161961.133335]  ? asm_exc_page_fault+0x26/0x30
<4>[161961.133341]  ? pick_next_task_fair+0x89/0x5a0
<4>[161961.133343]  __schedule+0x184/0x1540
<4>[161961.133346]  ? sysvec_irq_work+0xe/0x80
<4>[161961.133347]  ? __mod_memcg_state+0x84/0x100
<4>[161961.133350]  ? refill_stock+0x1a/0x30
<4>[161961.133352]  do_task_dead+0x42/0x50
<4>[161961.133355]  do_exit+0x7a9/0xaa0
<4>[161961.133358]  do_group_exit+0x30/0x80
<4>[161961.133360]  __x64_sys_exit_group+0x18/0x20
<4>[161961.133362]  do_syscall_64+0xba/0x210
<4>[161961.133364]  entry_SYSCALL_64_after_hwframe+0x72/0x7a
<4>[161961.133367] RIP: 0033:0x7ffff7d3e3ed
Oops#1 Part2
<4>[161961.133403] Code: Unable to access opcode bytes at 0x7ffff7d3e3c3.
<4>[161961.133403] RSP: 002b:00007ffffffe42f8 EFLAGS: 00000202 ORIG_RAX: 00=
000000000000e7
<4>[161961.133405] RAX: ffffffffffffffda RBX: 00007ffff7e46fa8 RCX: 00007ff=
ff7d3e3ed
<4>[161961.133405] RDX: 00000000000000e7 RSI: ffffffffffffff88 RDI: 0000000=
000000000
<4>[161961.133406] RBP: 0000000000000001 R08: 00007ffffffe4298 R09: 0000000=
000000006
<4>[161961.133406] R10: 0000000000000038 R11: 0000000000000202 R12: 0000000=
000000000
<4>[161961.133407] R13: 0000000000000000 R14: 00007ffff7e45680 R15: 00007ff=
ff7e46fc0
<4>[161961.133408]  </TASK>
<4>[161961.133409] Modules linked in: tcp_diag inet_diag nhpoly1305_avx2 nh=
poly1305_sse2 nhpoly1305 chacha_generic chacha_x86_64 libchacha adiantum li=
bpoly1305 camellia_generic camellia_aesni_avx2 camellia_aesni_avx_x86_64 ca=
mellia_x86_64 cast5_avx_x86_64 cast5_generic cast_common blowfish_generic b=
lowfish_x86_64 blowfish_common serpent_avx2 serpent_avx_x86_64 serpent_sse2=
_x86_64 serpent_generic xts twofish_generic twofish_avx_x86_64 twofish_x86_=
64_3way twofish_x86_64 twofish_common aes_generic lrw snd_seq_dummy snd_hrt=
imer snd_seq snd_seq_device ctr af_packet ccm algif_aead crypto_null des3_e=
de_x86_64 cbc des_generic libdes algif_skcipher dummy cmac md4 algif_hash a=
f_alg msr nft_chain_nat xt_MASQUERADE nf_nat nls_utf8 nls_cp866 vfat fat xt=
_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 amdgpu ip6t_rpfilter =
ipt_rpfilter xt_pkttype xt_LOG nf_log_syslog xt_tcpudp nft_compat iwlmvm tc=
p_bbr sch_fq nf_tables mac80211 tls atkbd snd_hda_codec_hdmi libps2 intel_r=
apl_msr serio libarc4 edac_mce_amd vivaldi_fmap edac_core
Oops#1 Part1
<4>[161961.133452]  snd_hda_intel snd_intel_dspcfg amd_atl snd_intel_sdw_ac=
pi btusb intel_rapl_common snd_hda_codec amdxcp drm_exec crc32_pclmul polyv=
al_clmulni btrtl gpu_sched polyval_generic gf128mul drm_buddy btintel loop =
btbcm ghash_clmulni_intel drm_suballoc_helper cpufreq_ondemand btmtk sha512=
_ssse3 drm_ttm_helper iwlwifi snd_hda_core sha512_generic bluetooth ttm sha=
256_ssse3 snd_hwdep tun sha1_ssse3 wmi_bmof gigabyte_wmi drm_display_helper=
 snd_pcm tap mxm_wmi aesni_intel crypto_simd cryptd ecdh_generic input_leds=
 ecc led_class cec snd_timer macvlan evdev mousedev crc16 libaes joydev cfg=
80211 mac_hid sp5100_tco video rapl snd bridge acpi_cpufreq k10temp igb bac=
klight soundcore stp watchdog ptp llc tiny_power_button pps_core i2c_piix4 =
rfkill dca i2c_algo_bit thermal wmi button kvm_amd ccp rng_core kvm fuse co=
nfigfs efi_pstore nfnetlink zstd zram efivarfs dmi_sysfs ip_tables x_tables=
 autofs4 sd_mod hid_generic usbhid hid ahci libahci libata xhci_pci xhci_pc=
i_renesas nvme firmware_class nvme_core xhci_hcd scsi_mod t10_pi
<4>[161961.133500]  crc64_rocksoft crc64 crc_t10dif crct10dif_generic scsi_=
common crct10dif_pclmul crct10dif_common rtc_cmos dm_mod dax btrfs blake2b_=
generic libcrc32c crc32c_generic crc32c_intel xor raid6_pq
<4>[161961.133508] CR2: 00000000000000a0
<4>[161961.133510] ---[ end trace 0000000000000000 ]---

Previous crashes:

<1>[70053.502250] BUG: kernel NULL pointer dereference, address: 0000000000=
0000a0
<1>[70053.502255] #PF: supervisor read access in kernel mode
<1>[70053.502257] #PF: error_code(0x0000) - not-present page
<6>[70053.502258] PGD 1e1ccec067 P4D 1e1ccec067 PUD 196e968067 PMD 0
<4>[70053.502261] Oops: 0000 [#1] PREEMPT SMP NOPTI
<4>[70053.502263] CPU: 3 PID: 3124643 Comm: strip Not tainted 6.8.2 #1-NixOS
<4>[70053.502265] Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS U=
LTRA/X570 AORUS ULTRA, BIOS F32 GK 01/19/2021
<4>[70053.502266] RIP: 0010:pick_next_task_fair+0x89/0x5a0
<4>[70053.502271] Code: 00 00 00 49 81 bc 24 b0 02 00 00 e0 b8 99 9b 75 5e =
4d 89 f7 eb 27 4c 89 ff e8 83 9e ff ff 84 c0 75 3f 4c 89 ff e8 67 11 ff ff =
<4c> 8b b8 a0 00 00 00 48 89 c3 4d 85 ff 0f 84 01 01 00 00 49 8b 47
Oops#1 Part3
<4>[70053.502272] RSP: 0000:ffffa5e16860fe30 EFLAGS: 00010082
<4>[70053.502273] RAX: 0000000000000000 RBX: ffff98ff3e3b3640 RCX: 00000000=
00000400
<4>[70053.502274] RDX: a4bd7da6e65033f8 RSI: 00000000000004e4 RDI: 00000000=
000000e4
<4>[70053.502275] RBP: ffff98ff3e3b3640 R08: 00000000000000e4 R09: 00000000=
00000002
<4>[70053.502276] R10: ffffffff9c006110 R11: 00000000000075da R12: ffff98e0=
893091c0
<4>[70053.502276] R13: ffffa5e16860feb8 R14: ffff98ff3e3b3740 R15: ffff98ff=
3e3b3740
<4>[70053.502277] FS:  0000000000000000(0000) GS:ffff98ff3e380000(0000) knl=
GS:0000000000000000
<4>[70053.502278] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[70053.502279] CR2: 00000000000000a0 CR3: 000000055953e000 CR4: 00000000=
00f50ef0
<4>[70053.502280] PKRU: 55555554
<4>[70053.502280] Call Trace:
<4>[70053.502282]  <TASK>
<4>[70053.502286]  ? __die+0x23/0x70
<4>[70053.502289]  ? page_fault_oops+0x171/0x4e0
<4>[70053.502291]  ? __slab_free+0xdf/0x360
<4>[70053.502294]  ? exc_page_fault+0x72/0x160
<4>[70053.502297]  ? asm_exc_page_fault+0x26/0x30
<4>[70053.502302]  ? pick_next_task_fair+0x89/0x5a0
<4>[70053.502303]  __schedule+0x185/0x1550
<4>[70053.502306]  ? sched_clock+0x10/0x30
<4>[70053.502308]  ? __do_softirq+0x17a/0x2ca
<4>[70053.502310]  schedule+0x32/0xd0
<4>[70053.502311]  irqentry_exit_to_user_mode+0x1dc/0x230
<4>[70053.502313]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
<4>[70053.502315] RIP: 0033:0x7ffff7fdbe06
<4>[70053.502341] Code: c5 08 31 c0 80 fa 3d 74 1f 84 d2 74 1b 0f 1f 80 00 =
00 00 00 83 c0 01 48 63 d0 41 0f b6 14 11 84 d2 74 c1 80 fa 3d 75 ec 84 d2 =
<74> b8 44 8d 40 01 4d 63 c0 4d 01 c8 4d 85 ed 0f 84 bf 00 00 00 4c
Oops#1 Part2
<4>[70053.502342] RSP: 002b:00007fffffff67f0 EFLAGS: 00000202
<4>[70053.502343] RAX: 000000000000000b RBX: ffff800008004b57 RCX: 00007fff=
ffff981b
<4>[70053.502344] RDX: 000000000000003d RSI: 000000000000004e RDI: 00007fff=
f7ffca71
<4>[70053.502344] RBP: 00007ffff7ffb440 R08: 00007fffffff9828 R09: 00007fff=
ffff986a
<4>[70053.502345] R10: 000000000000037f R11: 0000000000000064 R12: 00007fff=
f7ffca71
<4>[70053.502346] R13: 00007fffffff6c28 R14: 00007ffff7fc9000 R15: 00007fff=
f7fc95b0
<4>[70053.502347]  </TASK>
<4>[70053.502348] Modules linked in: tcp_diag inet_diag nhpoly1305_avx2 nhp=
oly1305_sse2 nhpoly1305 chacha_generic chacha_x86_64 libchacha adiantum lib=
poly1305 camellia_generic camellia_aesni_avx2 camellia_aesni_avx_x86_64 cam=
ellia_x86_64 cast5_avx_x86_64 cast5_generic cast_common blowfish_generic bl=
owfish_x86_64 blowfish_common serpent_avx2 serpent_avx_x86_64 serpent_sse2_=
x86_64 serpent_generic xts twofish_generic twofish_avx_x86_64 twofish_x86_6=
4_3way twofish_x86_64 twofish_common aes_generic lrw snd_seq_dummy snd_hrti=
mer snd_seq snd_seq_device ctr af_packet ccm algif_aead crypto_null des3_ed=
e_x86_64 cbc des_generic libdes algif_skcipher dummy cmac md4 algif_hash af=
_alg msr nft_chain_nat nls_utf8 xt_MASQUERADE nls_cp866 nf_nat vfat fat xt_=
conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 amdgpu ip6t_rpfilter i=
pt_rpfilter iwlmvm xt_pkttype xt_LOG nf_log_syslog xt_tcpudp nft_compat mac=
80211 nf_tables tcp_bbr sch_fq libarc4 snd_hda_codec_hdmi intel_rapl_msr tl=
s btusb btrtl atkbd snd_hda_intel btintel edac_mce_amd libps2
Oops#1 Part1
<4>[70053.502381]  btbcm snd_intel_dspcfg serio snd_intel_sdw_acpi btmtk ed=
ac_core iwlwifi vivaldi_fmap intel_rapl_common amdxcp drm_exec snd_hda_code=
c bluetooth gpu_sched crc32_pclmul drm_buddy polyval_clmulni polyval_generi=
c gf128mul snd_hda_core ghash_clmulni_intel drm_suballoc_helper loop sha512=
_ssse3 sha512_generic drm_ttm_helper ttm snd_hwdep cpufreq_ondemand sha256_=
ssse3 tun drm_display_helper snd_pcm sha1_ssse3 gigabyte_wmi ecdh_generic w=
mi_bmof mxm_wmi cec input_leds tap igb aesni_intel ecc snd_timer video mous=
edev led_class evdev crypto_simd sp5100_tco macvlan cfg80211 joydev crc16 m=
ac_hid cryptd libaes ptp rapl snd pps_core watchdog bridge acpi_cpufreq tin=
y_power_button soundcore backlight dca k10temp stp i2c_piix4 i2c_algo_bit r=
fkill llc thermal wmi button kvm_amd ccp rng_core kvm irqbypass fuse efi_ps=
tore configfs nfnetlink zstd zram efivarfs dmi_sysfs ip_tables x_tables aut=
ofs4 sd_mod hid_generic usbhid hid ahci libahci libata xhci_pci xhci_pci_re=
nesas nvme firmware_class nvme_core xhci_hcd scsi_mod t10_pi
<4>[70053.502423]  crc64_rocksoft crc64 crc_t10dif crct10dif_generic scsi_c=
ommon crct10dif_pclmul crct10dif_common rtc_cmos dm_mod dax btrfs blake2b_g=
eneric libcrc32c crc32c_generic crc32c_intel xor raid6_pq
<4>[70053.502431] CR2: 00000000000000a0
<4>[70053.502433] ---[ end trace 0000000000000000 ]---

Another one:

<1>[626079.354590] BUG: kernel NULL pointer dereference, address: 000000000=
00000a0
<1>[626079.354596] #PF: supervisor read access in kernel mode
<1>[626079.354597] #PF: error_code(0x0000) - not-present page
<6>[626079.354598] PGD 2c985c067 P4D 2c985c067 PUD 2686ef067 PMD 0
<4>[626079.354602] Oops: 0000 [#2] PREEMPT SMP NOPTI
<4>[626079.354603] CPU: 3 PID: 21065 Comm: pahole Tainted: G      D        =
    6.8.2 #1-NixOS
<4>[626079.354605] Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS =
ULTRA/X570 AORUS ULTRA, BIOS F32 GK 01/19/2021
<4>[626079.354606] RIP: 0010:pick_next_task_fair+0x89/0x5a0
<4>[626079.354612] Code: 00 00 00 49 81 bc 24 b0 02 00 00 e0 b8 19 ba 75 5e=
 4d 89 f7 eb 27 4c 89 ff e8 83 9e ff ff 84 c0 75 3f 4c 89 ff e8 67 11 ff ff=
 <4c> 8b b8 a0 00 00 00 48 89 c3 4d 85 ff 0f 84 01 01 00 00 49 8b 47
Oops#2 Part3
<4>[626079.354613] RSP: 0000:ffffb5d93a157e30 EFLAGS: 00010082
<4>[626079.354614] RAX: 0000000000000000 RBX: ffff9bd83e3b3640 RCX: 0000000=
000000800
<4>[626079.354615] RDX: e55c7ab36e3e44c0 RSI: 0000000000000850 RDI: 0000000=
000000050
<4>[626079.354616] RBP: ffff9bd83e3b3640 R08: 0000000000000050 R09: 0000000=
000000002
<4>[626079.354617] R10: ffff9bd83e3b3790 R11: 0000000000000000 R12: ffff9bb=
e12582380
<4>[626079.354617] R13: ffffb5d93a157eb8 R14: ffff9bd83e3b3740 R15: ffff9bd=
83e3b3740
<4>[626079.354618] FS:  00007ffff7b37740(0000) GS:ffff9bd83e380000(0000) kn=
lGS:0000000000000000
<4>[626079.354619] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[626079.354620] CR2: 00000000000000a0 CR3: 000000038926a000 CR4: 0000000=
000f50ef0
<4>[626079.354621] PKRU: 55555554
<4>[626079.354622] Call Trace:
<4>[626079.354624]  <TASK>
<4>[626079.354628]  ? __die+0x23/0x70
<4>[626079.354631]  ? page_fault_oops+0x171/0x4e0
<4>[626079.354634]  ? exc_page_fault+0x72/0x160
<4>[626079.354637]  ? asm_exc_page_fault+0x26/0x30
<4>[626079.354641]  ? pick_next_task_fair+0x89/0x5a0
<4>[626079.354643]  __schedule+0x185/0x1550
<4>[626079.354645]  ? sched_clock+0x10/0x30
<4>[626079.354647]  ? __do_softirq+0x17a/0x2ca
<4>[626079.354650]  schedule+0x32/0xd0
<4>[626079.354651]  irqentry_exit_to_user_mode+0x1dc/0x230
<4>[626079.354653]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
<4>[626079.354654] RIP: 0033:0x7ffff7e5a550
<4>[626079.354685] Code: 00 0c 00 00 00 eb cb e8 1e 8f ff ff 66 66 2e 0f 1f=
 84 00 00 00 00 00 0f 1f 00 55 89 f5 53 48 89 fb 48 83 ec 08 8b 47 54 39 c6=
 <73> 11 66 0f 1f 44 00 00 48 8b 5b 48 8b 43 54 39 c5 72 f5 89 ea 29
Oops#2 Part2
<4>[626079.354686] RSP: 002b:00007fffffff64c0 EFLAGS: 00000202
<4>[626079.354687] RAX: 0000000000000000 RBX: 00000000004151a0 RCX: 0000000=
000008df2
<4>[626079.354688] RDX: 00000000000ca7b2 RSI: 00000000000ca7bf RDI: 0000000=
0004151a0
<4>[626079.354688] RBP: 00000000000ca7bf R08: 000000007fffffff R09: 0000000=
00001a6f7
<4>[626079.354689] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ff=
ff7e99b34
<4>[626079.354690] R13: 00007ffff7148e34 R14: 00007ffff7148d64 R15: 0000000=
0000ca7bf
<4>[626079.354691]  </TASK>
<4>[626079.354691] Modules linked in: uvcvideo videobuf2_vmalloc uvc videob=
uf2_memops videobuf2_v4l2 snd_usb_audio videodev snd_usbmidi_lib snd_ump vi=
deobuf2_common snd_rawmidi mc nhpoly1305_avx2 nhpoly1305_sse2 nhpoly1305 ch=
acha_generic chacha_x86_64 libchacha adiantum libpoly1305 camellia_generic =
camellia_aesni_avx2 camellia_aesni_avx_x86_64 camellia_x86_64 cast5_avx_x86=
_64 cast5_generic cast_common blowfish_generic blowfish_x86_64 blowfish_com=
mon serpent_avx2 serpent_avx_x86_64 serpent_sse2_x86_64 serpent_generic xts=
 twofish_generic twofish_avx_x86_64 twofish_x86_64_3way twofish_x86_64 twof=
ish_common aes_generic lrw tcp_diag inet_diag snd_seq_dummy snd_hrtimer snd=
_seq snd_seq_device ctr af_packet ccm algif_aead crypto_null des3_ede_x86_6=
4 cbc des_generic libdes algif_skcipher dummy cmac md4 algif_hash af_alg ms=
r nft_chain_nat xt_MASQUERADE nf_nat xt_conntrack nf_conntrack nf_defrag_ip=
v6 nf_defrag_ipv4 amdgpu ip6t_rpfilter ipt_rpfilter xt_pkttype xt_LOG nf_lo=
g_syslog xt_tcpudp nft_compat iwlmvm nls_utf8 nls_cp866 tcp_bbr
Oops#2 Part1
<4>[626079.354725]  vfat nf_tables sch_fq fat mac80211 tls btusb edac_mce_a=
md btrtl atkbd btintel snd_hda_codec_hdmi edac_core btbcm intel_rapl_msr bt=
mtk libps2 serio libarc4 snd_hda_intel intel_rapl_common vivaldi_fmap gigab=
yte_wmi mxm_wmi wmi_bmof snd_intel_dspcfg crc32_pclmul bluetooth polyval_cl=
mulni snd_intel_sdw_acpi polyval_generic amdxcp loop drm_exec gf128mul iwlw=
ifi snd_hda_codec ghash_clmulni_intel gpu_sched cpufreq_ondemand sha512_sss=
e3 sha512_generic drm_buddy tun drm_suballoc_helper sha256_ssse3 drm_ttm_he=
lper ecdh_generic tap input_leds snd_hda_core sha1_ssse3 aesni_intel ecc mo=
usedev evdev ttm macvlan snd_hwdep led_class crypto_simd crc16 igb joydev m=
ac_hid libaes bridge drm_display_helper snd_pcm cryptd cfg80211 stp snd_tim=
er rapl cec ptp sp5100_tco llc snd acpi_cpufreq pps_core tiny_power_button =
watchdog video soundcore backlight dca k10temp rfkill i2c_algo_bit i2c_piix=
4 kvm_amd wmi thermal button ccp rng_core kvm irqbypass fuse configfs efi_p=
store nfnetlink zstd zram efivarfs dmi_sysfs ip_tables x_tables
<4>[626079.354766]  autofs4 sd_mod hid_generic usbhid hid ahci libahci liba=
ta xhci_pci xhci_pci_renesas nvme firmware_class nvme_core xhci_hcd scsi_mo=
d t10_pi crc64_rocksoft crc64 crc_t10dif crct10dif_generic scsi_common crct=
10dif_pclmul crct10dif_common rtc_cmos dm_mod dax btrfs blake2b_generic lib=
crc32c crc32c_generic crc32c_intel xor raid6_pq
<4>[626079.354780] CR2: 00000000000000a0
<4>[626079.354781] ---[ end trace 0000000000000000 ]---

--=20

  Sergei

