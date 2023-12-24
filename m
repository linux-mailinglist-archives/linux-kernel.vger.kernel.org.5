Return-Path: <linux-kernel+bounces-10617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A7981D770
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 01:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D87C01C20F78
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 00:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C0981C;
	Sun, 24 Dec 2023 00:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WctLmaTu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7A47FC
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 00:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5945fef58caso598614eaf.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 16:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703379262; x=1703984062; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N4bnGwYi+9tKWCImVXCAQKKGXAznpNgouam2lekmrDY=;
        b=WctLmaTuPV7kh8qpIL1ifVNYD3rcdOGmF9Rb2miMPCxSQUzMPVJ+zlEo3gQrvZkSM9
         oxQHW46PQpVpdWgLG4AR+QbsJCbjqZlFatgRy/5KVMU67kOQUcnf2GNGrNu+ZjelAH1j
         Fe/LHFs9gQUeCo4hza7sREaragfXD2fWu1UAJbNFkTyeHC+AgFB6+hXLu4PKh+vQVrsw
         SRnytu2lyy8P+HruCQwRbd7I5TEscwIbpCU5s+CLnkE56B37xvqNANR7VTqPT1OuJHyy
         1tWdqJXArrsgu74sOgOu/Ta+8RGGOjU+XWR7ynKHkEUjTHwxr+CIlZHhsSrvbxga66EY
         ZSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703379262; x=1703984062;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N4bnGwYi+9tKWCImVXCAQKKGXAznpNgouam2lekmrDY=;
        b=HwmA0TBCzP+n7e82Q5KE8XPIOJ/qZ1Dlh4ntBxkI0GNtMW/mInD/Yw0quWDmYo5f6y
         6Bf/w++9YTU3fTVo7trNqc6q3Ie5rt4JNRRSNjlboo+F7A8yfDQy+noLoAUlIk0YEACH
         LMH0RrMM3T08DSjlLUDP7MM0yjVcYuLTyJGTEkgOierrnLX/2gKoVKc7udV+KT6a5bej
         eKG7Mw+ciS/lnX+1pvFoge9jvC5sz9ZMec5f75tBqg4Xv1WND0OSB4KxUee+8VAm1oOG
         5Ly0nA4tbNzIAKcNsYFBgzY6g7kytPVjm9isAlWH/5vv3+boD0V2gcNsm4VpNnqR2KpG
         E7PA==
X-Gm-Message-State: AOJu0Yw3soA/Zn/+iRHlbu98cRNBZXwkXwA2+EN3dHvhOafRaMkkpb39
	vaZO6sMTK3OPKKO0sZpjdOA1PTIItw5qrljfm6yXJKsE0J8=
X-Google-Smtp-Source: AGHT+IH0ypx5ajVKG9QQ7WjswFMuxScuDbjUERNIDWKShU7yHwI9eCT9ZZwaMVL6GLUf/o+ijUyKCfpnSSzflsg83ew=
X-Received: by 2002:a05:6358:9106:b0:174:d596:d1ea with SMTP id
 q6-20020a056358910600b00174d596d1eamr2741912rwq.49.1703379262422; Sat, 23 Dec
 2023 16:54:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Chris Bainbridge <chris.bainbridge@gmail.com>
Date: Sun, 24 Dec 2023 00:54:11 +0000
Message-ID: <CAP-bSRb3SXpgo_BEdqZB-p1K5625fMegRZ17ZkPE1J8ZYgEHDg@mail.gmail.com>
Subject: BUG: use-after-free bisected to "usb: typec: class: fix
 typec_altmode_put_partner to put plugs"
To: rdbabiera@google.com
Cc: heikki.krogerus@linux.intel.com, Greg KH <gregkh@linuxfoundation.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello,

A use-after-free error has appeared after a recent commit. This occurs
when I unplug the USB-C dock (HP G5).


b17b7fe6dd5c6ff74b38b0758ca799cdbb79e26e is the first bad commit
commit b17b7fe6dd5c6ff74b38b0758ca799cdbb79e26e
Author: RD Babiera <rdbabiera@google.com>
Date:   Wed Nov 29 19:23:50 2023 +0000

    usb: typec: class: fix typec_altmode_put_partner to put plugs


[   86.738038] usb 1-1: USB disconnect, device number 2
[   86.738052] usb 1-1.2: USB disconnect, device number 4
[   86.746191] [drm] DM_MST: stopping TM on aconnector:
0000000012454e94 [id: 101]
[   86.757367] usb 2-1: USB disconnect, device number 2
[   86.757373] usb 2-1.3: USB disconnect, device number 3
[   86.757378] usb 2-1.3.3: USB disconnect, device number 5
[   86.788662] r8152-cfgselector 2-1.4: USB disconnect, device number 4
[   86.788937] r8152 2-1.4:1.0 enx64c901a35e3d: Stop submitting intr,
status -108
[   86.803049] ------------[ cut here ]------------
[   86.803052] refcount_t: underflow; use-after-free.
[   86.803059] WARNING: CPU: 0 PID: 2971 at lib/refcount.c:28
refcount_warn_saturate+0xbe/0x110
[   86.803067] Modules linked in: rfcomm ctr ccm xt_conntrack
nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user xfrm_algo xt_addrtype
nft_compat nf_tables nfnetlink br_netfilter bridge stp llc
nvme_fabrics snd_seq_dummy snd_hrtimer snd_seq overlay qrtr cmac
algif_hash algif_skcipher af_alg bnep binfmt_misc rtw89_8852ae
rtw89_8852a nls_ascii rtw89_pci nls_cp437 vfat rtw89_core btusb fat
btrtl btintel btbcm ext4 snd_ctl_led btmtk snd_hda_codec_realtek
bluetooth mac80211 snd_hda_codec_generic intel_rapl_msr mbcache
snd_hda_codec_hdmi ledtrig_audio intel_rapl_common snd_acp3x_rn
snd_acp3x_pdm_dma jbd2 snd_soc_dmic uvcvideo snd_usb_audio
snd_hda_intel kvm_amd snd_soc_core snd_intel_dspcfg videobuf2_vmalloc
snd_hda_codec sha3_generic snd_usbmidi_lib videobuf2_memops
jitterentropy_rng snd_pci_acp6x kvm uvc snd_hwdep snd_hda_core drbg
videobuf2_v4l2 snd_pci_acp5x snd_rawmidi libarc4 snd_pcm
snd_seq_device snd_rn_pci_acp3x videodev ansi_cprng cfg80211 ucsi_acpi
hp_wmi
[   86.803149]  snd_timer irqbypass snd_acp_config ecdh_generic
typec_ucsi sparse_keymap videobuf2_common snd snd_soc_acpi ecc roles
ccp rapl platform_profile mc joydev sg pcspkr k10temp rfkill
snd_pci_acp3x crc16 soundcore wmi_bmof typec ac battery button
serio_raw evdev amd_pmc acpi_tad hid_multitouch msr parport_pc ppdev
lp fuse parport loop efi_pstore configfs efivarfs ip_tables x_tables
autofs4 btrfs blake2b_generic libcrc32c crc32c_generic xor raid6_pq
dm_crypt hid_microsoft ff_memless hid_cmedia amdgpu r8153_ecm
cdc_ether usbnet r8152 mii usbhid dm_mod sd_mod uas usb_storage
scsi_mod scsi_common i2c_algo_bit drm_ttm_helper ttm nvme drm_exec
drm_suballoc_helper nvme_core amdxcp t10_pi drm_buddy
crc64_rocksoft_generic gpu_sched hid_generic crc64_rocksoft
drm_display_helper crc32_pclmul xhci_pci crc_t10dif i2c_hid_acpi
drm_kms_helper crc32c_intel xhci_hcd crct10dif_generic i2c_hid
ghash_clmulni_intel amd_sfh crct10dif_pclmul sha512_ssse3 drm usbcore
cec video hid crc64 sha512_generic rc_core i2c_piix4 usb_common fan
[   86.803237]  crct10dif_common wmi aesni_intel crypto_simd cryptd
[   86.803243] CPU: 0 PID: 2971 Comm: kworker/0:6 Not tainted 6.7.0-rc6+ #728
[   86.803245] Hardware name: HP HP Pavilion Aero Laptop
13-be0xxx/8916, BIOS F.12 04/11/2023
[   86.803246] Workqueue: events ucsi_handle_connector_change [typec_ucsi]
[   86.803254] RIP: 0010:refcount_warn_saturate+0xbe/0x110
[   86.803257] Code: 01 01 e8 d5 1d ab ff 0f 0b e9 c9 3d 70 00 80 3d
92 22 40 01 00 75 85 48 c7 c7 28 5d ab 9f c6 05 82 22 40 01 01 e8 b2
1d ab ff <0f> 0b e9 a6 3d 70 00 80 3d 6d 22 40 01 00 0f 85 5e ff ff ff
48 c7
[   86.803258] RSP: 0018:ffffc900032d7d90 EFLAGS: 00010282
[   86.803260] RAX: 0000000000000000 RBX: ffff888103d28808 RCX: 0000000000000000
[   86.803262] RDX: 0000000000000002 RSI: ffffffff9fa36b45 RDI: 00000000ffffffff
[   86.803263] RBP: ffff888103d28800 R08: 0000000000000000 R09: ffffc900032d7c18
[   86.803264] R10: 0000000000000003 R11: ffffffffa00d2368 R12: 0000000000000000
[   86.803265] R13: ffff8881058ac280 R14: ffffffff9f71cb20 R15: ffff88816282b838
[   86.803266] FS:  0000000000000000(0000) GS:ffff88840e400000(0000)
knlGS:0000000000000000
[   86.803268] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   86.803269] CR2: 0000562440baafc0 CR3: 000000002bc20000 CR4: 0000000000750ef0
[   86.803271] PKRU: 55555554
[   86.803271] Call Trace:
[   86.803274]  <TASK>
[   86.803275]  ? refcount_warn_saturate+0xbe/0x110
[   86.803277]  ? __warn+0x81/0x130
[   86.803282]  ? refcount_warn_saturate+0xbe/0x110
[   86.803285]  ? report_bug+0x191/0x1c0
[   86.803288]  ? srso_alias_return_thunk+0x5/0xfbef5
[   86.803292]  ? console_unlock+0x78/0x120
[   86.803296]  ? handle_bug+0x41/0x70
[   86.803300]  ? exc_invalid_op+0x17/0x70
[   86.803302]  ? asm_exc_invalid_op+0x1a/0x20
[   86.803308]  ? refcount_warn_saturate+0xbe/0x110
[   86.803311]  typec_altmode_release+0x49/0xc0 [typec]
[   86.803321]  device_release+0x37/0x90
[   86.803325]  kobject_put+0x7b/0x190
[   86.803329]  ucsi_unregister_altmodes+0x41/0x90 [typec_ucsi]
[   86.803334]  ucsi_unregister_partner.part.0+0x77/0xa0 [typec_ucsi]
[   86.803339]  ucsi_handle_connector_change+0x1bb/0x310 [typec_ucsi]
[   86.803344]  process_one_work+0x174/0x340
[   86.803349]  worker_thread+0x27b/0x3a0
[   86.803352]  ? __pfx_worker_thread+0x10/0x10
[   86.803354]  kthread+0xf7/0x130
[   86.803356]  ? __pfx_kthread+0x10/0x10
[   86.803359]  ret_from_fork+0x34/0x50
[   86.803362]  ? __pfx_kthread+0x10/0x10
[   86.803364]  ret_from_fork_asm+0x1b/0x30
[   86.803370]  </TASK>
[   86.803371] ---[ end trace 0000000000000000 ]---
[   86.932845] usb 1-1.3: USB disconnect, device number 6
[   86.932852] usb 1-1.3.3: USB disconnect, device number 8
[   86.932855] usb 1-1.3.3.1: USB disconnect, device number 9
[   87.028738] usb 1-1.3.3.2: USB disconnect, device number 10
[   87.028745] usb 1-1.3.3.2.1: USB disconnect, device number 12
[   87.124962] usb 1-1.3.3.2.4: USB disconnect, device number 13
[   87.508733] usb 1-1.3.3.3: USB disconnect, device number 11
[   87.604996] usb 1-1.5: USB disconnect, device number 7


Possibly related (?) but perhaps not - I suspect this is a
longstanding bug in amdgpu, but mention it for completeness - is the
following when I plug the USB-C cable back in:


[  926.075580] amdgpu 0000:03:00.0: [drm] *ERROR* Failed to get ACT
after 3000ms, last status: 00
[  926.075589] BUG: kernel NULL pointer dereference, address: 0000000000000008
[  926.075591] #PF: supervisor read access in kernel mode
[  926.075594] #PF: error_code(0x0000) - not-present page
[  926.075596] PGD 0 P4D 0
[  926.075600] Oops: 0000 [#1] PREEMPT SMP NOPTI
[  926.075603] CPU: 2 PID: 1069 Comm: Xorg Not tainted 6.7.0-rc4+ #739
[  926.075606] Hardware name: HP HP Pavilion Aero Laptop
13-be0xxx/8916, BIOS F.12 04/11/2023
[  926.075608] RIP: 0010:drm_dp_add_payload_part2+0xb9/0xf0 [drm_display_helper]
[  926.075626] Code: 8b 78 08 e8 99 65 5d fc 44 89 f0 5b 41 5c 41 5d
41 5e 5d 31 d2 31 c9 31 f6 31 ff 45 31 c0 e9 09 b7 de fc 48 8b 80 58
05 00 00 <48> 8b 76 08 4c 8b 40 60 48 85 f6 74 04 48 8b 76 08 48 c7 c1
28 14
[  926.075628] RSP: 0018:ffffc900016df4f8 EFLAGS: 00010297
[  926.075631] RAX: ffff888112224000 RBX: ffff888112224000 RCX: 0000000000000000
[  926.075633] RDX: ffff88811133cc00 RSI: 0000000000000000 RDI: ffff88810c45e580
[  926.075635] RBP: ffffc900016df518 R08: 0000000000000000 R09: 0000000000000000
[  926.075637] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
[  926.075639] R13: ffffc900016df538 R14: ffff88810ab638a0 R15: ffff88810c45e000
[  926.075641] FS:  00007f29f8e0eac0(0000) GS:ffff88840e680000(0000)
knlGS:0000000000000000
[  926.075643] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  926.075645] CR2: 0000000000000008 CR3: 000000010577a000 CR4: 0000000000750ef0
[  926.075647] PKRU: 55555554
[  926.075649] Call Trace:
[  926.075651]  <TASK>
[  926.075655]  ? show_regs+0x6d/0x80
[  926.075660]  ? __die+0x24/0x80
[  926.075664]  ? page_fault_oops+0x176/0x500
[  926.075668]  ? srso_alias_return_thunk+0x5/0xfbef5
[  926.075673]  ? srso_alias_return_thunk+0x5/0xfbef5
[  926.075675]  ? __irq_work_queue_local+0x43/0xf0
[  926.075682]  ? do_user_addr_fault+0x306/0x6b0
[  926.075685]  ? set_dev_info+0x130/0x1c0
[  926.075690]  ? exc_page_fault+0x83/0x1b0
[  926.075695]  ? asm_exc_page_fault+0x27/0x30
[  926.075702]  ? drm_dp_add_payload_part2+0xb9/0xf0 [drm_display_helper]
[  926.075715]  dm_helpers_dp_mst_send_payload_allocation+0xfc/0x130 [amdgpu]
[  926.076008]  link_set_dpms_on+0xa9b/0xe60 [amdgpu]
[  926.076277]  ? srso_alias_return_thunk+0x5/0xfbef5
[  926.076281]  ? generic_reg_update_ex+0xc0/0x250 [amdgpu]
[  926.076517]  dce110_apply_ctx_to_hw+0x8b1/0xa80 [amdgpu]
[  926.076767]  ? srso_alias_return_thunk+0x5/0xfbef5
[  926.076770]  ? dcn10_wait_for_mpcc_disconnect+0x174/0x240 [amdgpu]
[  926.076980]  dc_commit_state_no_check+0x4a6/0x1980 [amdgpu]
[  926.077168]  dc_commit_streams+0x2f2/0x6d0 [amdgpu]
[  926.077355]  amdgpu_dm_atomic_commit_tail+0x633/0x4040 [amdgpu]
[  926.077563]  ? srso_alias_return_thunk+0x5/0xfbef5
[  926.077565]  ? dm_crtc_get_scanoutpos+0x96/0x110 [amdgpu]
[  926.077772]  ? srso_alias_return_thunk+0x5/0xfbef5
[  926.077774]  ? srso_alias_return_thunk+0x5/0xfbef5
[  926.077776]  ? ktime_get+0x48/0xc0
[  926.077780]  ? amdgpu_display_get_crtc_scanoutpos+0x9e/0x1c0 [amdgpu]
[  926.077917]  ? srso_alias_return_thunk+0x5/0xfbef5
[  926.077919]  ? amdgpu_crtc_get_scanout_position+0x27/0x50 [amdgpu]
[  926.078051]  ? srso_alias_return_thunk+0x5/0xfbef5
[  926.078055]  ?
drm_crtc_vblank_helper_get_vblank_timestamp_internal+0x100/0x3f0 [drm]
[  926.078081]  ? srso_alias_return_thunk+0x5/0xfbef5
[  926.078083]  ? wait_for_completion_timeout+0x119/0x150
[  926.078086]  ? drm_crtc_get_last_vbltimestamp+0x59/0x90 [drm]
[  926.078106]  ? srso_alias_return_thunk+0x5/0xfbef5
[  926.078110]  commit_tail+0xc2/0x190 [drm_kms_helper]
[  926.078121]  ? srso_alias_return_thunk+0x5/0xfbef5
[  926.078123]  ? drm_atomic_helper_swap_state+0x246/0x380 [drm_kms_helper]
[  926.078133]  drm_atomic_helper_commit+0x11d/0x150 [drm_kms_helper]
[  926.078144]  drm_atomic_commit+0x99/0xd0 [drm]
[  926.078162]  ? __pfx___drm_printfn_info+0x10/0x10 [drm]
[  926.078183]  drm_mode_obj_set_property_ioctl+0x17d/0x440 [drm]
[  926.078204]  ? srso_alias_return_thunk+0x5/0xfbef5
[  926.078208]  ? __pfx_drm_mode_obj_set_property_ioctl+0x10/0x10 [drm]
[  926.078226]  drm_ioctl_kernel+0xde/0x190 [drm]
[  926.078246]  ? srso_alias_return_thunk+0x5/0xfbef5
[  926.078249]  drm_ioctl+0x2d0/0x550 [drm]
[  926.078268]  ? __pfx_drm_mode_obj_set_property_ioctl+0x10/0x10 [drm]
[  926.078289]  amdgpu_drm_ioctl+0x4e/0x90 [amdgpu]
[  926.078418]  __x64_sys_ioctl+0xa3/0xf0
[  926.078423]  do_syscall_64+0x5f/0xf0
[  926.078427]  ? srso_alias_return_thunk+0x5/0xfbef5
[  926.078429]  ? exit_to_user_mode_prepare+0xa5/0x190
[  926.078433]  ? srso_alias_return_thunk+0x5/0xfbef5
[  926.078435]  ? syscall_exit_to_user_mode+0x37/0x60
[  926.078438]  ? srso_alias_return_thunk+0x5/0xfbef5
[  926.078440]  ? do_syscall_64+0x6b/0xf0
[  926.078442]  ? srso_alias_return_thunk+0x5/0xfbef5
[  926.078444]  ? do_syscall_64+0x6b/0xf0
[  926.078446]  ? do_syscall_64+0x6b/0xf0
[  926.078449]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[  926.078452] RIP: 0033:0x7f29f91238ef
[  926.078469] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24
10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00
00 0f 05 <89> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28
00 00
[  926.078471] RSP: 002b:00007ffc50bc5660 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[  926.078474] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f29f91238ef
[  926.078475] RDX: 00007ffc50bc56f0 RSI: 00000000c01864ba RDI: 000000000000000f
[  926.078477] RBP: 00007ffc50bc56f0 R08: 0000000000000092 R09: 00000000000000ff
[  926.078478] R10: 000000000ffef001 R11: 0000000000000246 R12: 00000000c01864ba
[  926.078480] R13: 000000000000000f R14: 00005632b254d660 R15: 0000000000000fff
[  926.078483]  </TASK>
[  926.078485] Modules linked in: r8153_ecm cdc_ether usbnet
hid_microsoft ff_memless r8152 mii hid_cmedia snd_usb_audio
snd_usbmidi_lib usbhid snd_ump rfcomm snd_seq_dummy snd_hrtimer ccm
cmac algif_hash algif_skcipher af_alg bnep amdgpu binfmt_misc
nls_iso8859_1 snd_soc_dmic snd_acp3x_pdm_dma snd_acp3x_rn
snd_sof_amd_rembrandt snd_sof_amd_renoir snd_sof_amd_acp snd_ctl_led
snd_sof_xtensa_dsp snd_sof_pci snd_hda_codec_realtek snd_sof
snd_hda_codec_generic rtw89_8852ae snd_sof_utils snd_hda_codec_hdmi
ledtrig_audio rtw89_8852a snd_hda_intel snd_soc_core snd_intel_dspcfg
intel_rapl_msr rtw89_pci snd_compress snd_hda_codec rtw89_core
uvcvideo intel_rapl_common snd_pci_ps snd_hwdep amdxcp kvm_amd
videobuf2_vmalloc snd_rpl_pci_acp6x i2c_algo_bit snd_hda_core
snd_acp_pci kvm drm_ttm_helper snd_seq_midi videobuf2_memops
snd_acp_legacy_common mac80211 snd_seq_midi_event ttm btusb
snd_pci_acp6x uvc irqbypass snd_rawmidi snd_pcm btrtl videobuf2_v4l2
crct10dif_pclmul btintel drm_exec crc32_pclmul btbcm snd_pci_acp5x
gpu_sched
[  926.078553]  snd_seq videodev drm_suballoc_helper polyval_clmulni
snd_rn_pci_acp3x btmtk polyval_generic drm_buddy snd_seq_device
ghash_clmulni_intel snd_timer videobuf2_common drm_display_helper
bluetooth snd_acp_config aesni_intel mc drm_kms_helper crypto_simd snd
libarc4 snd_soc_acpi soundcore hp_wmi video snd_pci_acp3x cfg80211 cec
cryptd sparse_keymap platform_profile ecdh_generic input_leds joydev
wmi_bmof ccp rc_core ecc i2c_piix4 rapl k10temp serio_raw
hid_multitouch mac_hid wmi amd_pmc acpi_tad msr parport_pc ppdev lp
parport efi_pstore dmi_sysfs ip_tables x_tables autofs4 uas
usb_storage btrfs blake2b_generic libcrc32c xor raid6_pq i2c_hid_acpi
i2c_hid ucsi_acpi drm hid_generic nvme typec_ucsi amd_sfh nvme_core
xhci_pci typec hid xhci_pci_renesas
[  926.078614] CR2: 0000000000000008
[  926.078616] ---[ end trace 0000000000000000 ]---
[  926.281235] RIP: 0010:drm_dp_add_payload_part2+0xb9/0xf0 [drm_display_helper]
[  926.281251] Code: 8b 78 08 e8 99 65 5d fc 44 89 f0 5b 41 5c 41 5d
41 5e 5d 31 d2 31 c9 31 f6 31 ff 45 31 c0 e9 09 b7 de fc 48 8b 80 58
05 00 00 <48> 8b 76 08 4c 8b 40 60 48 85 f6 74 04 48 8b 76 08 48 c7 c1
28 14
[  926.281254] RSP: 0018:ffffc900016df4f8 EFLAGS: 00010297
[  926.281258] RAX: ffff888112224000 RBX: ffff888112224000 RCX: 0000000000000000
[  926.281260] RDX: ffff88811133cc00 RSI: 0000000000000000 RDI: ffff88810c45e580
[  926.281261] RBP: ffffc900016df518 R08: 0000000000000000 R09: 0000000000000000
[  926.281263] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
[  926.281265] R13: ffffc900016df538 R14: ffff88810ab638a0 R15: ffff88810c45e000
[  926.281267] FS:  00007f29f8e0eac0(0000) GS:ffff88840e680000(0000)
knlGS:0000000000000000
[  926.281270] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  926.281272] CR2: 0000000000000008 CR3: 000000010577a000 CR4: 0000000000750ef0
[  926.281274] PKRU: 55555554

