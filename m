Return-Path: <linux-kernel+bounces-30580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEB68320F1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 22:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97DF21F25C64
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 21:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB613173E;
	Thu, 18 Jan 2024 21:37:32 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3801E486;
	Thu, 18 Jan 2024 21:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705613852; cv=none; b=HDZ/uuZJH4OkONuFlFJi+ShCnv6CbYoe0rdpSWMc3vfzxPBuInS9noFUFE1P5/Ev7RqumOHy6sUFxBXOy6RPx8XfTovxWeGx5f0ZMvGs4j9XfslKhT2eNAXcNj8isLLl062Kq3tmPH3/nN3Z6MrgudQ8avTsE0wEX31PesayfNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705613852; c=relaxed/simple;
	bh=CnEI21X70mU5g6+Ac0zxeWTlzVejTJYNKLurbo2aEig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AIzfUqXGCMJE6UgRcAYkc2GuFB39o7fp5wcEwpiz3NsIRiFIGQTDqJIl20488BfxCLbbKq1qjFkkLYzuWYpXwBr3pNlsKoiZ+tCz7XulshNxc/+IdqmFrfpHmDc2n1UgQa7neOvzV6gS1xQlCF3ixtk5aYEwWj9Riz5rUU66HhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id AE5E8140132; Thu, 18 Jan 2024 22:37:20 +0100 (CET)
Date: Thu, 18 Jan 2024 22:37:20 +0100
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
	Dell.Client.Kernel@dell.com, regressions@lists.linux.dev
Subject: Re: PS/2 keyboard of laptop Dell XPS 13 9360 goes missing after S3
Message-ID: <ZamaEBy+wyWcf8Ec@cae.in-ulm.de>
References: <0aa4a61f-c939-46fe-a572-08022e8931c7@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0aa4a61f-c939-46fe-a572-08022e8931c7@molgen.mpg.de>


Hi Paul,

On Thu, Jan 18, 2024 at 01:57:50PM +0100, Paul Menzel wrote:
> [ 7487.040106] ------------[ cut here ]------------
> [ 7487.040108] refcount_t: underflow; use-after-free.
> [ 7487.040117] WARNING: CPU: 2 PID: 54815 at lib/refcount.c:28 refcount_w=
arn_saturate+0xbe/0x110
> [ 7487.040123] Modules linked in: sctp libcrc32c typec_displayport r8153_=
ecm cdc_ether usbnet sd_mod r8152 sg mii uas usb_storage scsi_mod scsi_comm=
on l2tp_ppp xfrm_interface l2tp_netlink xfrm6_tunnel l2tp_core tunnel6 tunn=
el4 ip6_udp_tunnel xfrm_user udp_tunnel xfrm_algo pppox ppp_generic slhc ct=
r ccm snd_seq_dummy snd_hrtimer snd_seq snd_seq_device qrtr snd_sof_pci_int=
el_skl snd_sof_intel_hda_common soundwire_intel soundwire_generic_allocatio=
n snd_hda_codec_hdmi snd_sof_intel_hda_mlink soundwire_cadence snd_sof_inte=
l_hda snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils soundwire_bus sn=
d_ctl_led snd_soc_avs snd_soc_hda_codec snd_soc_skl snd_hda_codec_realtek s=
nd_soc_hdac_hda ath10k_pci snd_hda_ext_core binfmt_misc snd_hda_codec_gener=
ic ath10k_core btusb snd_soc_sst_ipc btrtl snd_soc_sst_dsp snd_soc_acpi_int=
el_match btintel nls_ascii btbcm nls_cp437 ath snd_soc_acpi btmtk mac80211 =
vfat bluetooth snd_soc_core x86_pkg_temp_thermal fat intel_powerclamp coret=
emp kvm_intel snd_compress snd_pcm_dmaengine dell_laptop
> [ 7487.040173]  snd_hda_intel mei_pxp mei_hdcp mei_wdt i915 ledtrig_audio=
 snd_intel_dspcfg libarc4 snd_intel_sdw_acpi kvm intel_rapl_msr snd_hda_cod=
ec sha3_generic joydev jitterentropy_rng dell_smm_hwmon uvcvideo snd_hda_co=
re cfg80211 videobuf2_vmalloc drbg uvc irqbypass snd_hwdep rapl snd_pcm vid=
eobuf2_memops videobuf2_v4l2 dell_wmi intel_cstate ansi_cprng dell_smbios v=
ideodev snd_timer dcdbas intel_uncore ucsi_acpi ecdh_generic mei_me typec_u=
csi iTCO_wdt intel_pmc_bxt snd iTCO_vendor_support wmi_bmof intel_wmi_thund=
erbolt watchdog dell_wmi_descriptor pcspkr mei videobuf2_common soundcore r=
fkill drm_buddy typec ecc mc intel_pch_thermal drm_display_helper cec intel=
_vbtn soc_button_array rc_core processor_thermal_device_pci_legacy processo=
r_thermal_device ttm processor_thermal_wt_hint processor_thermal_rfim proce=
ssor_thermal_rapl int3400_thermal drm_kms_helper int3403_thermal intel_rapl=
_common acpi_thermal_rel intel_pmc_core intel_hid intel_xhci_usb_role_switc=
h processor_thermal_wt_req button processor_thermal_power_floor
> [ 7487.040218]  processor_thermal_mbox sparse_keymap evdev acpi_pad int34=
0x_thermal_zone ac intel_soc_dts_iosf i2c_algo_bit roles hid_multitouch ser=
io_raw msr parport_pc ppdev lp parport loop efi_pstore configfs nfnetlink e=
fivarfs ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 crc32c_generic d=
m_crypt dm_mod usbhid nvme crc32_pclmul crc32c_intel nvme_core t10_pi hid_g=
eneric ghash_clmulni_intel crc64_rocksoft_generic sha512_ssse3 crc64_rockso=
ft i2c_hid_acpi crc_t10dif i2c_hid crct10dif_generic xhci_pci sha512_generi=
c drm xhci_hcd sha256_ssse3 intel_lpss_pci crct10dif_pclmul i2c_i801 crc64 =
usbcore sha1_ssse3 crct10dif_common i2c_smbus hid battery intel_lpss idma64=
 usb_common video wmi aesni_intel crypto_simd cryptd
> [ 7487.040256] CPU: 2 PID: 54815 Comm: kworker/u8:61 Not tainted 6.7-amd6=
4 #1  Debian 6.7-1~exp1
> [ 7487.040258] Hardware name: Dell Inc. XPS 13 9360/0596KF, BIOS 2.21.0 0=
6/02/2022
> [ 7487.040260] Workqueue: USBC000:00-con1 ucsi_poll_worker [typec_ucsi]
> [ 7487.040269] RIP: 0010:refcount_warn_saturate+0xbe/0x110
> [ 7487.040272] Code: 01 01 e8 f5 22 a9 ff 0f 0b c3 cc cc cc cc 80 3d e1 6=
2 7e 01 00 75 85 48 c7 c7 38 ca 8f 89 c6 05 d1 62 7e 01 01 e8 d2 22 a9 ff <=
0f> 0b c3 cc cc cc cc 80 3d bf 62 7e 01 00 0f 85 5e ff ff ff 48 c7
> [ 7487.040274] RSP: 0000:ffffb653c149fd90 EFLAGS: 00010282
> [ 7487.040276] RAX: 0000000000000000 RBX: ffffa07c8687ac08 RCX: 000000000=
0000027
> [ 7487.040278] RDX: ffffa07ff1521408 RSI: 0000000000000001 RDI: ffffa07ff=
1521400
> [ 7487.040279] RBP: ffffa07c8687ac00 R08: 0000000000000000 R09: 65646e752=
03a745f
> [ 7487.040280] R10: 75203b776f6c6672 R11: 72657466612d6573 R12: 000000000=
0000000
> [ 7487.040281] R13: ffffa07c8484fc40 R14: ffffffff8951ffa0 R15: ffffa07ee=
4b06b48
> [ 7487.040282] FS:  0000000000000000(0000) GS:ffffa07ff1500000(0000) knlG=
S:0000000000000000
> [ 7487.040283] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 7487.040285] CR2: 0000000000000000 CR3: 0000000246820001 CR4: 000000000=
03706f0
> [ 7487.040286] Call Trace:
> [ 7487.040288]  <TASK>
> [ 7487.040289]  ? refcount_warn_saturate+0xbe/0x110
> [ 7487.040292]  ? __warn+0x81/0x130
> [ 7487.040298]  ? refcount_warn_saturate+0xbe/0x110
> [ 7487.040300]  ? report_bug+0x171/0x1a0
> [ 7487.040304]  ? console_unlock+0xcb/0x120
> [ 7487.040307]  ? handle_bug+0x3c/0x80
> [ 7487.040309]  ? exc_invalid_op+0x17/0x70
> [ 7487.040311]  ? asm_exc_invalid_op+0x1a/0x20
> [ 7487.040315]  ? refcount_warn_saturate+0xbe/0x110
> [ 7487.040319]  typec_altmode_release+0x49/0xc0 [typec]
> [ 7487.040334]  device_release+0x34/0x90
> [ 7487.040339]  kobject_put+0x78/0x190
> [ 7487.040341]  ucsi_unregister_altmodes+0x41/0xa0 [typec_ucsi]
> [ 7487.040347]  ucsi_unregister_partner.part.0+0x77/0xa0 [typec_ucsi]
> [ 7487.040353]  ucsi_check_connection+0x73/0xc0 [typec_ucsi]
> [ 7487.040359]  ucsi_poll_worker+0x3a/0x110 [typec_ucsi]
> [ 7487.040365]  process_one_work+0x171/0x340
> [ 7487.040369]  worker_thread+0x27b/0x3a0
> [ 7487.040372]  ? __pfx_worker_thread+0x10/0x10
> [ 7487.040374]  kthread+0xe5/0x120
> [ 7487.040376]  ? __pfx_kthread+0x10/0x10
> [ 7487.040378]  ret_from_fork+0x31/0x50
> [ 7487.040381]  ? __pfx_kthread+0x10/0x10
> [ 7487.040382]  ret_from_fork_asm+0x1b/0x30
> [ 7487.040388]  </TASK>
> [ 7487.040388] ---[ end trace 0000000000000000 ]---

It is probably unrelated but there is the above warning in your logs
during resume. The warning is related to USB-C and can be avoided if
you do not connect anything to the USB-C ports for the duration of the
test. The real fix for this warning made it into Linus's tree today.

    regards  Christian


