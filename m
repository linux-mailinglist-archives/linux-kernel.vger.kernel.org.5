Return-Path: <linux-kernel+bounces-134308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2021889B021
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 11:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04B931C20A65
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CAB1642B;
	Sun,  7 Apr 2024 09:40:46 +0000 (UTC)
Received: from fgw21-4.mail.saunalahti.fi (fgw21-4.mail.saunalahti.fi [62.142.5.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69FB63B8
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 09:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712482846; cv=none; b=nPa6Rm2yYh7DtHoPIjdZoZ6LC44/rRcXZqvOprVeZo5dvJHHygP7MITszAQ2fUz1VUBto1jvJ8B1xEVwLG6S2IIljo3mWdQ66epo1uHcyRyz4mvWRn4QBzP9uHj6fG/e20LED9D6bifvP8SJO9Njh06WBtY78gaG4MVoYpU7K9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712482846; c=relaxed/simple;
	bh=NVE+MPvgtOQ9EJnoalsry1M89pS+VC9n3NtEBUXGJbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+69/GciNWRDtKrJR7uVyENsscbvToz1x1Pv3YWvhDbbIkI2hOkVbeK8QAQomkW9Veji56BFUFgbgiGDTodumPdVN0TzZJsydfmJ80LD+zeu969C4Sm+dDsxJxxW8q2zqPQ3ANmqimbiXRabWie4zF7vT+7/2C1ubwp8P0ut//I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=fail smtp.mailfrom=iki.fi; arc=none smtp.client-ip=62.142.5.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iki.fi
Received: from ydin.reaktio.net (unknown [85.76.255.15])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id bc4a7a96-f4c2-11ee-abf4-005056bdd08f;
	Sun, 07 Apr 2024 12:39:32 +0300 (EEST)
Received: by ydin.reaktio.net (Postfix, from userid 1001)
	id 6D01520089; Sun,  7 Apr 2024 12:39:31 +0300 (EEST)
Date: Sun, 7 Apr 2024 12:39:31 +0300
From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: linux-kernel@vger.kernel.org, Norbert Preining <norbert@preining.info>,
	stable@vger.kernel.org, regressions@leemhuis.info
Subject: Re: Regression in kernel 6.8.2 fails in various ways (USB, BT, ...)
Message-ID: <20240407093931.GA28090@reaktio.net>
References: <ZgvkIZFN23rkYhtS@burischnitzel>
 <6139700.lOV4Wx5bFT@natalenko.name>
 <20240406182943.GG1099@reaktio.net>
 <2724514.mvXUDI8C0e@natalenko.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2724514.mvXUDI8C0e@natalenko.name>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sun, Apr 07, 2024 at 12:04:46AM +0200, Oleksandr Natalenko wrote:
> Hello.
>=20
> On sobota 6. dubna 2024 20:29:43, CEST Pasi K=E4rkk=E4inen wrote:
> > On Wed, Apr 03, 2024 at 09:02:21PM +0200, Oleksandr Natalenko wrote:
> > > Hello.
> > >=20
> > > On =FAter=FD 2. dubna 2024 12:55:29, CEST Norbert Preining wrote:
> > > > Hi all
> > > >=20
> > > > (please cc)
> > > >=20
> > > > I am running Arch Linux on a Lenovo X1 Carbon Gen 10.
> > > > Tests are made with uptodate system, and besides the kernel no
> > > > difference.
> > > > The kernels are as distributed by Arch, but if necessary I can comp=
ile
> > > > locally.
> > > >=20
> > > >=20
> > > > Arch Linux kernel 6.8.1 works without any problems.
> > > > Upgrading to 6.8.2 breaks a lot of things:
> > > >=20
> > > > * Plugging in my Yubikey C does not trigger any reaction
> > > >   (as a consequence scdaemon hangs)
> > > > * sending of bluetooth firmware data fails with Oops (see below)
> > > > * shutdown hangs and does not turn off the computer
> > > >=20
> > > >=20
> > > > I can repeat this behaviour on every reboot into 6.8.2.
> > > >=20
> > > > I have dmesg/journalctl -b for both kernels collected, if required,=
 I
> > > > can send them. I checked the diffs but nothing really did stand out.
> > > >=20
> > > > Yubikey plugin:
> > > > On 6.8.1 when I plug in the yubikey it lights up, and in the logs I=
 see:
> > > > [  370.767739] usb 3-1: new full-speed USB device number 5 using xh=
ci_hcd
> > > > [  370.910392] usb 3-1: New USB device found, idVendor=3D1050, idPr=
oduct=3D0407, bcdDevice=3D 5.43
> > > > [  370.910403] usb 3-1: New USB device strings: Mfr=3D1, Product=3D=
2, SerialNumber=3D0
> > > > [  370.910407] usb 3-1: Product: YubiKey OTP+FIDO+CCID
> > > > [  370.910409] usb 3-1: Manufacturer: Yubico
> > > > [  371.497496] input: Yubico YubiKey OTP+FIDO+CCID as /devices/pci0=
000:00/0000:00:14.0/usb3/3-1/3-1:1.0/0003:1050:0407.0005/input/input21
> > > > [  371.555342] hid-generic 0003:1050:0407.0005: input,hidraw4: USB =
HID v1.10 Keyboard [Yubico YubiKey OTP+FIDO+CCID] on usb-0000:00:14.0-1/inp=
ut0
> > > > [  371.557021] hid-generic 0003:1050:0407.0006: hiddev96,hidraw5: U=
SB HID v1.10 Device [Yubico YubiKey OTP+FIDO+CCID] on usb-0000:00:14.0-1/in=
put1
> > > > [  371.557145] usbcore: registered new interface driver usbhid
> > > > [  371.557151] usbhid: USB HID core driver
> > > >=20
> > > > On 6.8.2 not short blinking, and nothing in the logs.
> > > >=20
> > > >=20
> > > >=20
> > > > Bluetooth Ooops:
> > > >    14.271713] usb usb3-port10: disabled by hub (EMI?), re-enabling.=
=2E.
> > > > [   14.271725] usb 3-10: USB disconnect, device number 4
> > > > [   14.271893] Bluetooth: hci0: Failed to send firmware data (-19)
> > > > [   14.271953] Bluetooth: hci0: sending frame failed (-19)
> > > > [   14.271976] Bluetooth: hci0: Intel reset sent to retry FW downlo=
ad
> > > > [   14.427765] Bluetooth: hci0: sending frame failed (-19)
> > > > [   14.427811] BUG: kernel NULL pointer dereference, address: 00000=
00000000070
> > > > [   14.427814] #PF: supervisor read access in kernel mode
> > > > [   14.427815] #PF: error_code(0x0000) - not-present page
> > > > [   14.427816] PGD 0 P4D 0
> > > > [   14.427819] Oops: 0000 [#1] PREEMPT SMP NOPTI
> > > > [   14.427820] CPU: 0 PID: 198 Comm: kworker/u41:0 Tainted: G      =
     OE      6.8.2-arch2-1 #1 a430fb92f7ba43092b62bbe6bac995458d3d442d
> > > > [   14.427823] Hardware name: LENOVO 21CBCTO1WW/21CBCTO1WW, BIOS N3=
AET80W (1.45 ) 02/20/2024
> > > > [   14.427824] Workqueue: hci0 hci_power_on [bluetooth]
> > > > [   14.427874] RIP: 0010:btintel_read_debug_features+0x4d/0xf0 [bti=
ntel]
> > > > [   14.427880] Code: 65 48 8b 04 25 28 00 00 00 48 89 44 24 08 31 c=
0 48 8d 4c 24 07 c6 44 24 07 01 e8 de a9 ef ff 48 89 c3 48 3d 00 f0 ff ff 7=
7 49 <83> 78 70 13 75 67 48 8b 80 d0 00 00 00 be 02 00 00 00 48 89 df 48
> > > > [   14.427881] RSP: 0018:ffffb7ba80aa3cc0 EFLAGS: 00010207
> > > > [   14.427882] RAX: 0000000000000000 RBX: 0000000000000000 RCX: fff=
f965ac0ddaab0
> > > > [   14.427884] RDX: 0000000000000000 RSI: 0000000000000202 RDI: fff=
f965ac0ddaaa8
> > > > [   14.427884] RBP: ffffb7ba80aa3cf0 R08: ffff965ac0ddaab0 R09: 000=
0000000000000
> > > > [   14.427885] R10: 0000000000000001 R11: 0000000000000100 R12: fff=
f965ac0dda000
> > > > [   14.427886] R13: ffff965a84746900 R14: ffff965a8208ca05 R15: fff=
f965ac0dda6d0
> > > > [   14.427887] FS:  0000000000000000(0000) GS:ffff9661bf400000(0000=
) knlGS:0000000000000000
> > > > [   14.427888] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > [   14.427889] CR2: 0000000000000070 CR3: 00000002bb620000 CR4: 000=
0000000f50ef0
> > > > [   14.427889] PKRU: 55555554
> > > > [   14.427890] Call Trace:
> > > > [   14.427891]  <TASK>
> > > > [   14.427893]  ? __die+0x23/0x70
> > > > [   14.427898]  ? page_fault_oops+0x171/0x4e0
> > > > [   14.427901]  ? __timer_delete_sync+0x7d/0xe0
> > > > [   14.427905]  ? exc_page_fault+0x7f/0x180
> > > > [   14.427908]  ? asm_exc_page_fault+0x26/0x30
> > > > [   14.427912]  ? btintel_read_debug_features+0x4d/0xf0 [btintel 67=
35e787c9ed982ceaa471c7ab364a390a1acb37]
> > > > [   14.427916]  btintel_register_devcoredump_support.isra.0+0x3e/0x=
110 [btintel 6735e787c9ed982ceaa471c7ab364a390a1acb37]
> > > > [   14.427921]  btintel_setup_combined+0x503/0x790 [btintel 6735e78=
7c9ed982ceaa471c7ab364a390a1acb37]
> > > > [   14.427925]  hci_dev_open_sync+0x102/0xc20 [bluetooth 81a2e5f6c3=
a85f38dade670bfe91d861a9119613]
> > > > [   14.427953]  ? __schedule+0x3ee/0x1520
> > > > [   14.427956]  hci_dev_do_open+0x23/0x60 [bluetooth 81a2e5f6c3a85f=
38dade670bfe91d861a9119613]
> > > > [   14.427975]  hci_power_on+0x51/0x260 [bluetooth 81a2e5f6c3a85f38=
dade670bfe91d861a9119613]
> > > > [   14.427994]  process_one_work+0x183/0x370
> > > > [   14.427998]  worker_thread+0x3ab/0x4f0
> > > > [   14.428000]  ? __pfx_worker_thread+0x10/0x10
> > > > [   14.428001]  kthread+0xe5/0x120
> > > > [   14.428005]  ? __pfx_kthread+0x10/0x10
> > > > [   14.428006]  ret_from_fork+0x31/0x50
> > > > [   14.428009]  ? __pfx_kthread+0x10/0x10
> > > > [   14.428011]  ret_from_fork_asm+0x1b/0x30
> > > > [   14.428014]  </TASK>
> > > > [   14.428015] Modules linked in: nf_tables bnep tun btusb btrtl bt=
intel btbcm btmtk bluetooth gpio_ljca i2c_ljca ecdh_generic hid_sensor_cust=
om_intel_hinge hid_sensor_trigger industrialio_triggered_buffer kfifo_buf h=
id_sensor_iio_common industrialio hid_sensor_custom hid_sensor_hub intel_is=
htp_hid joydev vfat fat ext4 crc16 mbcache jbd2 snd_ctl_led snd_soc_skl_hda=
_dsp snd_soc_hdac_hdmi snd_soc_intel_hda_dsp_common snd_sof_probes hid_mult=
itouch hid_generic mousedev snd_hda_codec_hdmi snd_hda_codec_realtek snd_hd=
a_codec_generic snd_soc_dmic snd_sof_pci_intel_tgl snd_sof_intel_hda_common=
 soundwire_intel snd_sof_intel_hda_mlink soundwire_cadence snd_sof_intel_hd=
a snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils snd_soc_hdac_hda snd=
_hda_ext_core snd_soc_acpi_intel_match intel_uncore_frequency intel_uncore_=
frequency_common snd_soc_acpi intel_tcc_cooling iwlmvm soundwire_generic_al=
location soundwire_bus x86_pkg_temp_thermal intel_powerclamp snd_soc_core m=
ac80211 coretemp snd_compress ac97_bus snd_pcm_dmaengine kvm_intel
> > > > [   14.428048]  snd_hda_intel libarc4 ptp snd_intel_dspcfg pps_core=
 snd_intel_sdw_acpi snd_hda_codec processor_thermal_device_pci kvm processo=
r_thermal_device processor_thermal_wt_hint snd_hda_core processor_thermal_r=
fim iwlwifi iTCO_wdt irqbypass intel_rapl_msr processor_thermal_rapl mei_px=
p snd_hwdep ucsi_acpi mei_hdcp mei_wdt rapl intel_rapl_common intel_pmc_bxt=
 typec_ucsi iTCO_vendor_support intel_lpss_pci intel_cstate thinkpad_acpi m=
ei_me think_lmi snd_pcm spi_nor processor_thermal_wt_req intel_ish_ipc type=
c ntfs3 i2c_i801 intel_lpss nxp_nci_i2c ledtrig_audio processor_thermal_pow=
er_floor cfg80211 wmi_bmof intel_uncore psmouse pcspkr firmware_attributes_=
class mtd thunderbolt mei snd_timer idma64 intel_ishtp i2c_smbus ov2740 rol=
es platform_profile igen6_edac processor_thermal_mbox nxp_nci v4l2_fwnode n=
ci snd intel_skl_int3472_tps68470 int3403_thermal v4l2_async intel_pmc_core=
 soc_button_array tps68470_regulator nfc soundcore int340x_thermal_zone clk=
_tps68470 mei_vsc_hw rfkill videodev intel_vsec i2c_hid_acpi
> > > > [   14.428085]  intel_hid int3400_thermal i2c_hid pmt_telemetry mc =
pinctrl_tigerlake sparse_keymap acpi_pad acpi_thermal_rel intel_skl_int3472=
_discrete acpi_tad pmt_class mac_hid i2c_dev corefreqk(OE) sg crypto_user f=
use loop nfnetlink ip_tables x_tables btrfs blake2b_generic libcrc32c crc32=
c_generic xor raid6_pq dm_crypt cbc encrypted_keys trusted asn1_encoder tee=
 dm_mod xe drm_ttm_helper gpu_sched drm_suballoc_helper drm_gpuvm drm_exec =
spi_ljca usb_ljca i915 crct10dif_pclmul crc32_pclmul crc32c_intel polyval_c=
lmulni polyval_generic gf128mul ghash_clmulni_intel sha512_ssse3 serio_raw =
sha256_ssse3 atkbd i2c_algo_bit sha1_ssse3 drm_buddy libps2 vivaldi_fmap ae=
sni_intel ttm nvme intel_gtt crypto_simd nvme_core cryptd drm_display_helpe=
r video xhci_pci spi_intel_pci i8042 nvme_auth xhci_pci_renesas spi_intel c=
ec serio wmi
> > > > [   14.428121] CR2: 0000000000000070
> > > > [   14.428123] ---[ end trace 0000000000000000 ]---
> > > > [   14.428124] RIP: 0010:btintel_read_debug_features+0x4d/0xf0 [bti=
ntel]
> > > > [   14.428128] Code: 65 48 8b 04 25 28 00 00 00 48 89 44 24 08 31 c=
0 48 8d 4c 24 07 c6 44 24 07 01 e8 de a9 ef ff 48 89 c3 48 3d 00 f0 ff ff 7=
7 49 <83> 78 70 13 75 67 48 8b 80 d0 00 00 00 be 02 00 00 00 48 89 df 48
> > > > [   14.428130] RSP: 0018:ffffb7ba80aa3cc0 EFLAGS: 00010207
> > > > [   14.428131] RAX: 0000000000000000 RBX: 0000000000000000 RCX: fff=
f965ac0ddaab0
> > > > [   14.428131] RDX: 0000000000000000 RSI: 0000000000000202 RDI: fff=
f965ac0ddaaa8
> > > > [   14.428132] RBP: ffffb7ba80aa3cf0 R08: ffff965ac0ddaab0 R09: 000=
0000000000000
> > > > [   14.428133] R10: 0000000000000001 R11: 0000000000000100 R12: fff=
f965ac0dda000
> > > > [   14.428133] R13: ffff965a84746900 R14: ffff965a8208ca05 R15: fff=
f965ac0dda6d0
> > > > [   14.428134] FS:  0000000000000000(0000) GS:ffff9661bf400000(0000=
) knlGS:0000000000000000
> > > > [   14.428135] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > [   14.428136] CR2: 0000000000000070 CR3: 00000002bb620000 CR4: 000=
0000000f50ef0
> > > > [   14.428137] PKRU: 55555554
> > > > [   14.428137] note: kworker/u41:0[198] exited with irqs disabled
> > > > [   16.434794] Bluetooth: hci0: command 0xfc09 tx timeout
> > > >=20
> > > >=20
> > > > Thanks for any suggestions and best regards
> > > > (and please Cc)
> > > >=20
> > > > Norbert
> > > >=20
> > > > --
> > > > PREINING Norbert                              https://www.preining.=
info
> > > > arXiv / Cornell University   +   IFMGA Guide   +   TU Wien  +  TeX =
Live
> > > > GPG: 0x860CDC13   fp: F7D8 A928 26E3 16A1 9FA0 ACF0 6CAC A448 860C =
DC13
> > > >=20
> > > >=20
> > >=20
> > > The BT woe should be fixed [1] in v6.8.3.
> > >=20
> > > For other two things, would you be able to bisect?
> > >=20
> >=20
> > I noticed possible related USB problem/regression also with Linux 6.7.1=
1, eg. my USB headset is not detected at all anymore when running Linux 6.7=
=2E11. USB headset works OK with Linux 6.7.9, so the regression is included=
/backported to also either in 6.7.10 or in 6.7.11.
>=20
> It wound be nice to narrow this range down even further with bisection be=
cause there are too many changes between v6.7.9 and v6.7.11 that could caus=
e this.
>=20

I just tested more Fedora kernel rpms, and it seems Linux 6.7.10 still work=
s OK,
but 6.7.11 has the regression (eg. USB devices not detected, laptop does no=
t reboot=20
as it gets stuck before resetting the machine).

So the regression was backported to Linux 6.7.11.


Thanks,

-- Pasi


