Return-Path: <linux-kernel+bounces-118566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2942388BCB2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 928761F3703F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F022714290;
	Tue, 26 Mar 2024 08:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="o5RySH/H"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A16C1C286;
	Tue, 26 Mar 2024 08:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711442673; cv=none; b=arVH+vGEVpp//ZoAAU9YToeUKd7m8uWOiApQI9pcq0j9wIvNt7VABlcQZwSszBEz/YY7mQdGlrHSpcYLaPPz9k07UVVee0+cbgZ9fpakMNdPSTsAJ3/Ix+f3lLAYFUc3tOiZvs+WLeVv177/P6dtgavx6N2mDmVwFOYCPlRgXq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711442673; c=relaxed/simple;
	bh=APa7Qh/XECmJeitAT7v+nld7zAoLL1mQdyP7gB1jaKE=;
	h=Message-ID:Date:MIME-Version:From:Subject:Cc:To:Content-Type; b=XFYbDW2BVqtfWDMqtEsCk0gC0FgfKSdO2ICiJ7NoRucFWwG42edPkdFWlWOGSXlhuSzMaFS//dBrZ9RRob5PnEemUegUz2QoDNejeOYKOv4R6hzTqvx18EMi0nGq1NjmCvlMmN9kg7hYRq9jkLsKdccDTiOietZ9ON5X64Czro4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=o5RySH/H; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:To:Cc:
	Subject:From:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=an+o6slt69CGSHDROxqx3mE66C8JLZtE4p2n0leHw5M=; t=1711442671; x=1711874671;
	 b=o5RySH/HSoU5hoQG5NEsDcJfe0ExrjpFjAPgAZIly44mJKWolMeCjnYvpwSbg+gHak2bGIOI3h
	54mtbzCH/1zQLC3FBgBHP5JhW7fO1CaxBMFp72UPlDECrSpGsLM5unGQ7W0txXwFRdzhQDKcM5PEZ
	TRKcJ1ng/1MaJwGRTLEgNFf+6/0l/mkT2AFduqYmkyBzgEiTMDTxY5txXJkLrMbHsDfKhQKsOIWJJ
	tiyXpuhu//n7e6C/FXqAnvz/UbJNEzHCpKL47ZBptkoGh6+n0Ahz0b83koTcfFQhMNL7Yj07S1MTT
	P9Yp2eFN1j+LCNsocPR2wq8dF/Z74M8++qc2g==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rp2Q0-0003nz-Ps; Tue, 26 Mar 2024 09:44:28 +0100
Message-ID: <08275279-7462-4f4a-a0ee-8aa015f829bc@leemhuis.info>
Date: Tue, 26 Mar 2024 09:44:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: en-US, de-DE
Subject: [REGRESSION] Oops during init in btintel_read_debug_features with
 today's mainline
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 n7RI
Cc: Linux kernel regressions list <regressions@lists.linux.dev>,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1711442671;c53996ea;
X-HE-SMSGID: 1rp2Q0-0003nz-Ps

Lo! Just booted 6.9 for the first time and noticed the Bluetooth code
causes an Oops (see below) during boot that did not happen with 6.8 and
earlier. This is on Fedora 40 with a vanilla kernel on a Lenovo Thinkpad
T14s Gen1 AMD.

Do I need to bisect this? Or is this known already? Or does anyone by
chance an idea what might cause this? Or is there some other way to get
down to the problem?

Ciao, Thorsten

[Full dmesg: https://www.leemhuis.info/files/misc/dmesg-6.9-btprob]

[   19.903869] Bluetooth: hci0: Found device firmware: intel/ibt-20-1-3.s=
fi
[   19.903908] Bluetooth: hci0: Boot Address: 0x24800
[   19.903913] Bluetooth: hci0: Firmware Version: 255-255.255
[   19.906245] usb 6-4: USB disconnect, device number 3
[   19.906364] usb 2-2: Found UVC 1.50 device Integrated Camera (04f2:b6c=
b)
[   19.906583] Bluetooth: hci0: FW download error recovery failed (-19)
[   19.906649] Bluetooth: hci0: sending frame failed (-19)
[   19.906666] BUG: kernel NULL pointer dereference, address: 00000000000=
00070
[   19.906672] #PF: supervisor read access in kernel mode
[   19.906677] #PF: error_code(0x0000) - not-present page
[   19.906681] PGD 0 P4D 0
[   19.906688] Oops: 0000 [#1] PREEMPT SMP NOPTI
[   19.906701] Hardware name: LENOVO 20UH001HGE/20UH001HGE, BIOS R1CET77W=
(1.46 ) 10/26/2023
[   19.906706] Workqueue: hci0 hci_power_on [bluetooth]
[   19.906775] RIP: 0010:btintel_read_debug_features (/usr/src/debug/[...=
]/drivers/bluetooth/btintel.c:1306) btintel
[ 19.906789] Code: 00 00 00 48 89 6c 24 08 48 89 f5 48 8d 4c 24 07 be a6 =
fc 00 00 c6 44 24 07 01 e8 30 46 2a 00 48 89 c3 48 3d 00 f0 ff ff 77 49 <=
83> 78 70 13 75 67 48 8b 80 d0 00 00 00 be 02 00 00 00 48 89 df 48
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	00 00                	add    %al,(%rax)
   2:	00 48 89             	add    %cl,-0x77(%rax)
   5:	6c                   	insb   (%dx),%es:(%rdi)
   6:	24 08                	and    $0x8,%al
   8:	48 89 f5             	mov    %rsi,%rbp
   b:	48 8d 4c 24 07       	lea    0x7(%rsp),%rcx
  10:	be a6 fc 00 00       	mov    $0xfca6,%esi
  15:	c6 44 24 07 01       	movb   $0x1,0x7(%rsp)
  1a:	e8 30 46 2a 00       	call   0x2a464f
  1f:	48 89 c3             	mov    %rax,%rbx
  22:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
  28:	77 49                	ja     0x73
  2a:*	83 78 70 13          	cmpl   $0x13,0x70(%rax)		<-- trapping instru=
ction
  2e:	75 67                	jne    0x97
  30:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
  37:	be 02 00 00 00       	mov    $0x2,%esi
  3c:	48 89 df             	mov    %rbx,%rdi
  3f:	48                   	rex.W

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	83 78 70 13          	cmpl   $0x13,0x70(%rax)
   4:	75 67                	jne    0x6d
   6:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   d:	be 02 00 00 00       	mov    $0x2,%esi
  12:	48 89 df             	mov    %rbx,%rdi
  15:	48                   	rex.W
[   19.906795] RSP: 0018:ffffb2bd80797cc0 EFLAGS: 00010207
[   19.906801] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff90328=
5506ab0
[   19.906806] RDX: 0000000000000000 RSI: 0000000000000202 RDI: ffff90328=
5506aa8
[   19.906810] RBP: ffffb2bd80797cf0 R08: ffff903285506ab0 R09: 000000000=
0000000
[   19.906814] R10: 000000000000000a R11: 0000000000000000 R12: ffff90328=
5506000
[   19.906818] R13: ffffb2bd80797d3e R14: ffff9032855066c8 R15: 000000000=
0000000
[   19.906823] FS:  0000000000000000(0000) GS:ffff90357fb00000(0000) knlG=
S:0000000000000000
[   19.906828] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   19.906832] CR2: 0000000000000070 CR3: 0000000104fb4000 CR4: 000000000=
0350ef0
[   19.906837] Call Trace:
[   19.906842]  <TASK>
[   19.906846] ? __die_body.cold (/usr/src/debug/[...]/arch/x86/kernel/du=
mpstack.c:478 (discriminator 1) /usr/src/debug/[...]/arch/x86/kernel/dump=
stack.c:465 (discriminator 1) /usr/src/debug/[...]/arch/x86/kernel/dumpst=
ack.c:420 (discriminator 1))=20
[   19.906856] ? page_fault_oops (/usr/src/debug/[...]/arch/x86/mm/fault.=
c:709 (discriminator 1))=20
[   19.906869] ? exc_page_fault (/usr/src/debug/[...]/./arch/x86/include/=
asm/paravirt.h:693 /usr/src/debug/[...]/arch/x86/mm/fault.c:1513 /usr/src=
/debug/[...]/arch/x86/mm/fault.c:1563)=20
[   19.906877] ? asm_exc_page_fault (/usr/src/debug/[...]/./arch/x86/incl=
ude/asm/idtentry.h:623)=20
[   19.906889] ? btintel_read_debug_features (/usr/src/debug/[...]/driver=
s/bluetooth/btintel.c:1306) btintel
[   19.906903] btintel_register_devcoredump_support.isra.0 (/usr/src/debu=
g/[...]/drivers/bluetooth/btintel.c:1531) btintel
[   19.906917] btintel_setup_combined (/usr/src/debug/[...]/drivers/bluet=
ooth/btintel.c:2993) btintel
[   19.906928] ? rpm_check_suspend_allowed (/usr/src/debug/[...]/drivers/=
base/power/runtime.c:277 (discriminator 1))=20
[   19.906943] hci_dev_open_sync (/usr/src/debug/[...]/net/bluetooth/hci_=
sync.c:4820 /usr/src/debug/[...]/net/bluetooth/hci_sync.c:4888 /usr/src/d=
ebug/[...]/net/bluetooth/hci_sync.c:4988) bluetooth
[   19.907012] ? ttwu_queue_wakelist (/usr/src/debug/[...]/kernel/sched/c=
ore.c:4036)=20
[   19.907022] hci_dev_do_open (/usr/src/debug/[...]/net/bluetooth/hci_co=
re.c:485) bluetooth
[   19.907078] hci_power_on (/usr/src/debug/[...]/net/bluetooth/hci_core.=
c:1016) bluetooth
[   19.907135] process_one_work (/usr/src/debug/[...]/./arch/x86/include/=
asm/jump_label.h:27 /usr/src/debug/[...]/./include/linux/jump_label.h:207=
 /usr/src/debug/[...]/./include/trace/events/workqueue.h:108 /usr/src/deb=
ug/[...]/kernel/workqueue.c:3259)=20
[   19.907144] worker_thread (/usr/src/debug/[...]/kernel/workqueue.c:332=
9 (discriminator 2) /usr/src/debug/[...]/kernel/workqueue.c:3416 (discrim=
inator 2))=20
[   19.907152] ? __pfx_worker_thread (/usr/src/debug/[...]/kernel/workque=
ue.c:3362)=20
[   19.907157] kthread (/usr/src/debug/[...]/kernel/kthread.c:388)=20
[   19.907164] ? __pfx_kthread (/usr/src/debug/[...]/kernel/kthread.c:341=
)=20
[   19.907171] ret_from_fork (/usr/src/debug/[...]/arch/x86/kernel/proces=
s.c:153)=20
[   19.907180] ? __pfx_kthread (/usr/src/debug/[...]/kernel/kthread.c:341=
)=20
[   19.907186] ret_from_fork_asm (/usr/src/debug/[...]/arch/x86/entry/ent=
ry_64.S:256)=20
[   19.907199]  </TASK>
[   19.907203] Modules linked in: amd_atl ac97_bus snd_intel_dspcfg snd_p=
cm_dmaengine intel_rapl_common snd_intel_sdw_acpi snd_rpl_pci_acp6x snd_a=
cp_pci snd_hda_codec uvcvideo(+) edac_mce_amd uvc snd_hda_core snd_acp_le=
gacy_common snd_pci_acp6x snd_hwdep kvm_amd videobuf2_vmalloc btusb video=
buf2_memops snd_seq tps6598x videobuf2_v4l2 btrtl kvm videobuf2_common bt=
intel btbcm snd_seq_device videodev ledtrig_audio btmtk iwlwifi snd_pci_a=
cp5x vfat think_lmi(+) firmware_attributes_class rapl bluetooth mc pcspkr=
 snd_pcm acpi_cpufreq fat wmi_bmof cfg80211 snd_rn_pci_acp3x snd_acp_conf=
ig thinkpad_acpi snd_soc_acpi k10temp snd_timer platform_profile ipmi_dev=
intf snd_pci_acp3x i2c_piix4 snd rfkill ipmi_msghandler soundcore serial_=
multi_instantiate i2c_scmi amd_pmc joydev loop dm_multipath nfnetlink zra=
m dm_crypt r8152 uas mii usb_storage amdgpu crct10dif_pclmul crc32_pclmul=
 crc32c_intel amdxcp polyval_clmulni i2c_algo_bit rtsx_pci_sdmmc drm_ttm_=
helper polyval_generic ttm ghash_clmulni_intel drm_exec mmc_core nvme sha=
512_ssse3
[   19.907365]  gpu_sched drm_suballoc_helper sha256_ssse3 drm_buddy sha1=
_ssse3 drm_display_helper nvme_core ucsi_acpi nvme_auth ccp typec_ucsi rt=
sx_pci cec r8169 sp5100_tco typec realtek video wmi serio_raw hid_microso=
ft ff_memless scsi_dh_rdac scsi_dh_emc scsi_dh_alua ip6_tables ip_tables =
pkcs8_key_parser fuse
[   19.907429] CR2: 0000000000000070
[   19.907435] ---[ end trace 0000000000000000 ]---
[   19.907439] RIP: 0010:btintel_read_debug_features (/usr/src/debug/[...=
]/drivers/bluetooth/btintel.c:1306) btintel
[ 19.907452] Code: 00 00 00 48 89 6c 24 08 48 89 f5 48 8d 4c 24 07 be a6 =
fc 00 00 c6 44 24 07 01 e8 30 46 2a 00 48 89 c3 48 3d 00 f0 ff ff 77 49 <=
83> 78 70 13 75 67 48 8b 80 d0 00 00 00 be 02 00 00 00 48 89 df 48
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	00 00                	add    %al,(%rax)
   2:	00 48 89             	add    %cl,-0x77(%rax)
   5:	6c                   	insb   (%dx),%es:(%rdi)
   6:	24 08                	and    $0x8,%al
   8:	48 89 f5             	mov    %rsi,%rbp
   b:	48 8d 4c 24 07       	lea    0x7(%rsp),%rcx
  10:	be a6 fc 00 00       	mov    $0xfca6,%esi
  15:	c6 44 24 07 01       	movb   $0x1,0x7(%rsp)
  1a:	e8 30 46 2a 00       	call   0x2a464f
  1f:	48 89 c3             	mov    %rax,%rbx
  22:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
  28:	77 49                	ja     0x73
  2a:*	83 78 70 13          	cmpl   $0x13,0x70(%rax)		<-- trapping instru=
ction
  2e:	75 67                	jne    0x97
  30:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
  37:	be 02 00 00 00       	mov    $0x2,%esi
  3c:	48 89 df             	mov    %rbx,%rdi
  3f:	48                   	rex.W

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	83 78 70 13          	cmpl   $0x13,0x70(%rax)
   4:	75 67                	jne    0x6d
   6:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   d:	be 02 00 00 00       	mov    $0x2,%esi
  12:	48 89 df             	mov    %rbx,%rdi
  15:	48                   	rex.W
[   19.907457] RSP: 0018:ffffb2bd80797cc0 EFLAGS: 00010207
[   19.907463] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff90328=
5506ab0
[   19.907468] RDX: 0000000000000000 RSI: 0000000000000202 RDI: ffff90328=
5506aa8
[   19.907473] RBP: ffffb2bd80797cf0 R08: ffff903285506ab0 R09: 000000000=
0000000
[   19.907477] R10: 000000000000000a R11: 0000000000000000 R12: ffff90328=
5506000
[   19.907481] R13: ffffb2bd80797d3e R14: ffff9032855066c8 R15: 000000000=
0000000
[   19.907486] FS:  0000000000000000(0000) GS:ffff90357fb00000(0000) knlG=
S:0000000000000000
[   19.907491] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   19.907496] CR2: 0000000000000070 CR3: 0000000104fb4000 CR4: 000000000=
0350ef0
[   19.907501] note: kworker/u51:0[158] exited with irqs disabled
[   19.911758] usbcore: registered new interface driver uvcvideo
[   19.921626] intel_rapl_common: Found RAPL domain package
[   19.921637] intel_rapl_common: Found RAPL domain core

--=20

#regzbot introduced v6.8..v6.9-rc1
#regzbot title bluetooth: oops during init in btintel_read_debug_features=

#regzbot ignore-activity

