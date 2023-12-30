Return-Path: <linux-kernel+bounces-13354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AA58203EF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 08:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDBC31C20BAE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 07:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE5A23AF;
	Sat, 30 Dec 2023 07:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rp04hx52"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD591864;
	Sat, 30 Dec 2023 07:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7811c02cfecso488766485a.2;
        Fri, 29 Dec 2023 23:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703922537; x=1704527337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/cul2h63M3brEi2ZK+56BvsegpNVKrmDUZdVlDzAPSM=;
        b=Rp04hx52vLL/z0RucmG8b4dyO56U0hkETR4MtzAWcQvp9UglD0MJStjPCmhlE7a6gq
         CZ3TiuVeOCOo8E9wMclI7T1k+6pmnJK4VcHO/rqJMCMWmZT2aX+1t54XYdb5lBGx9JvF
         5AjuJtvCNnfJeHDsxingZvA+L40UJEXlV22ANyaxRr4nMRHYNa86hmRP4azTZ4nphtS8
         rEx9qqzUQcoaQZjKQbqpv95utzWJWecUFC1bAu72AxlTZY+0JjOzO9C0Rg5QkKy6HEMP
         GXWPgAYFcGGKU/5Pna70a0WhAu6iLMZzogOBvRKCg7nzz8QayRkx24r43dyhFLTtzj+S
         eomw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703922537; x=1704527337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/cul2h63M3brEi2ZK+56BvsegpNVKrmDUZdVlDzAPSM=;
        b=tSj+3yzwFNKRdwZminacxVJHhla7SQ5qn7W6T+qFVUEcgn/Ih1PyPQm/JWZm3Tgvd0
         0WDzR6zmLXd74z6Od6Z/x4+yGrTTj0HQ6MSuXFsZwuYR/WnnuXK0pg8vj6rB9716lfKw
         N2LZxPFM66jf/wk3KrYymh7grenDqGEvTLX6tv6JaAnyZcdHz862JXvzUJ9uatxRdUjH
         zrhhPD3r9miCMt3gZQrh5gJ1ev53xWLPMvz/wKuv2xjbYz2h9sKt+UT9keEMQVgFnQ1J
         iNOCpO7Q808xiadj2hxDAdc3tWvP7APsEixHJ2AWU0W0NlYjM+rDWbJKQiEQmo8JN81Y
         4kDA==
X-Gm-Message-State: AOJu0Yx14/crUfoKjbjIBBjWDwliRrLpp3mtVASqKLvpaidW6l8DFr33
	7JAjfLX9fezV6I0Ocwyg0E/3uYg0A/4pffd8a5c=
X-Google-Smtp-Source: AGHT+IH0IGIWdOA2lXSQyv29coSaXrp9DOdK1bLbqyG3VIoBJYx/BN8ZqQoTIDVxamRrrsxWAkAS8j4I1T4WgAaWURs=
X-Received: by 2002:a05:620a:ed8:b0:77f:95a5:8109 with SMTP id
 x24-20020a05620a0ed800b0077f95a58109mr12886020qkm.141.1703922537146; Fri, 29
 Dec 2023 23:48:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231230045105.91351-1-sergeantsagara@protonmail.com> <20231230045105.91351-3-sergeantsagara@protonmail.com>
In-Reply-To: <20231230045105.91351-3-sergeantsagara@protonmail.com>
From: Julian Calaby <julian.calaby@gmail.com>
Date: Sat, 30 Dec 2023 18:48:45 +1100
Message-ID: <CAGRGNgWYLTmRfvw94Ok_FfcEVGPa0tRg-ELxkD8K6nxTTNZ9jg@mail.gmail.com>
Subject: Re: [PATCH wireless 2/5] wifi: b43: Stop/wake correct queue in DMA Tx
 path when QoS is disabled
To: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org, 
	b43-dev@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rahul,

On Sat, Dec 30, 2023 at 3:52=E2=80=AFPM Rahul Rameshbabu
<sergeantsagara@protonmail.com> wrote:
>
> When QoS is disabled, the queue priority value will not map to the correc=
t
> ieee80211 queue since there is only one queue. Stop/wake queue 0 when QoS
> is disabled to prevent trying to stop/wake a non-existent queue and faili=
ng
> to stop/wake the actual queue instantiated.
>
> Log of issue before change (with kernel parameter qos=3D0):
>     [  +5.112651] ------------[ cut here ]------------
>     [  +0.000005] WARNING: CPU: 7 PID: 25513 at net/mac80211/util.c:449 _=
_ieee80211_wake_queue+0xd5/0x180 [mac80211]
>     [  +0.000067] Modules linked in: b43(O) snd_seq_dummy snd_hrtimer snd=
_seq snd_seq_device nft_chain_nat xt_MASQUERADE nf_nat xfrm_user xfrm_algo =
xt_addrtype overlay ccm af_packet amdgpu snd_hda_codec_cirrus snd_hda_codec=
_generic ledtrig_audio drm_exec amdxcp gpu_sched xt_conntrack nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 ip6t_rpfilter ipt_rpfilter xt_pkttype xt_LOG =
nf_log_syslog xt_tcpudp nft_compat nf_tables nfnetlink sch_fq_codel btusb u=
input iTCO_wdt ctr btrtl intel_pmc_bxt i915 intel_rapl_msr mei_hdcp mei_pxp=
 joydev at24 watchdog btintel atkbd libps2 serio radeon btbcm vivaldi_fmap =
btmtk intel_rapl_common snd_hda_codec_hdmi bluetooth uvcvideo nls_iso8859_1=
 applesmc nls_cp437 x86_pkg_temp_thermal snd_hda_intel intel_powerclamp vfa=
t videobuf2_vmalloc coretemp fat snd_intel_dspcfg crc32_pclmul uvc polyval_=
clmulni snd_intel_sdw_acpi loop videobuf2_memops snd_hda_codec tun drm_suba=
lloc_helper polyval_generic drm_ttm_helper drm_buddy tap ecdh_generic video=
buf2_v4l2 gf128mul macvlan ttm ghash_clmulni_intel ecc tg3
>     [  +0.000044]  videodev bridge snd_hda_core rapl crc16 drm_display_he=
lper cec mousedev snd_hwdep evdev intel_cstate bcm5974 hid_appleir videobuf=
2_common stp mac_hid libphy snd_pcm drm_kms_helper acpi_als mei_me intel_un=
core llc mc snd_timer intel_gtt industrialio_triggered_buffer apple_mfi_fas=
tcharge i2c_i801 mei snd lpc_ich agpgart ptp i2c_smbus thunderbolt apple_gm=
ux i2c_algo_bit kfifo_buf video industrialio soundcore pps_core wmi tiny_po=
wer_button sbs sbshc button ac cordic bcma mac80211 cfg80211 ssb rfkill lib=
arc4 kvm_intel kvm drm irqbypass fuse backlight firmware_class efi_pstore c=
onfigfs efivarfs dmi_sysfs ip_tables x_tables autofs4 dm_crypt cbc encrypte=
d_keys trusted asn1_encoder tee tpm rng_core input_leds hid_apple led_class=
 hid_generic usbhid hid sd_mod t10_pi crc64_rocksoft crc64 crc_t10dif crct1=
0dif_generic ahci libahci libata uhci_hcd ehci_pci ehci_hcd crct10dif_pclmu=
l crct10dif_common sha512_ssse3 sha512_generic sha256_ssse3 sha1_ssse3 aesn=
i_intel usbcore scsi_mod libaes crypto_simd cryptd scsi_common
>     [  +0.000055]  usb_common rtc_cmos btrfs blake2b_generic libcrc32c cr=
c32c_generic crc32c_intel xor raid6_pq dm_snapshot dm_bufio dm_mod dax [las=
t unloaded: b43(O)]
>     [  +0.000009] CPU: 7 PID: 25513 Comm: irq/17-b43 Tainted: G        W =
 O       6.6.7 #1-NixOS
>     [  +0.000003] Hardware name: Apple Inc. MacBookPro8,3/Mac-942459F5819=
B171B, BIOS 87.0.0.0.0 06/13/2019
>     [  +0.000001] RIP: 0010:__ieee80211_wake_queue+0xd5/0x180 [mac80211]
>     [  +0.000046] Code: 00 45 85 e4 0f 85 9b 00 00 00 48 8d bd 40 09 00 0=
0 f0 48 0f ba ad 48 09 00 00 00 72 0f 5b 5d 41 5c 41 5d 41 5e e9 cb 6d 3c d=
0 <0f> 0b 5b 5d 41 5c 41 5d 41 5e c3 cc cc cc cc 48 8d b4 16 94 00 00
>     [  +0.000002] RSP: 0018:ffffc90003c77d60 EFLAGS: 00010097
>     [  +0.000001] RAX: 0000000000000001 RBX: 0000000000000002 RCX: 000000=
0000000000
>     [  +0.000001] RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff88=
820b924900
>     [  +0.000002] RBP: ffff88820b924900 R08: ffffc90003c77d90 R09: 000000=
000003bfd0
>     [  +0.000001] R10: ffff88820b924900 R11: ffffc90003c77c68 R12: 000000=
0000000000
>     [  +0.000001] R13: 0000000000000000 R14: ffffc90003c77d90 R15: ffffff=
ffc0fa6f40
>     [  +0.000001] FS:  0000000000000000(0000) GS:ffff88846fb80000(0000) k=
nlGS:0000000000000000
>     [  +0.000001] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     [  +0.000001] CR2: 00007fafda7ae008 CR3: 000000046d220005 CR4: 000000=
00000606e0
>     [  +0.000002] Call Trace:
>     [  +0.000003]  <TASK>
>     [  +0.000001]  ? __ieee80211_wake_queue+0xd5/0x180 [mac80211]
>     [  +0.000044]  ? __warn+0x81/0x130
>     [  +0.000005]  ? __ieee80211_wake_queue+0xd5/0x180 [mac80211]
>     [  +0.000045]  ? report_bug+0x171/0x1a0
>     [  +0.000004]  ? handle_bug+0x41/0x70
>     [  +0.000004]  ? exc_invalid_op+0x17/0x70
>     [  +0.000003]  ? asm_exc_invalid_op+0x1a/0x20
>     [  +0.000005]  ? __ieee80211_wake_queue+0xd5/0x180 [mac80211]
>     [  +0.000043]  ieee80211_wake_queue+0x4a/0x80 [mac80211]
>     [  +0.000044]  b43_dma_handle_txstatus+0x29c/0x3a0 [b43]
>     [  +0.000016]  ? __pfx_irq_thread_fn+0x10/0x10
>     [  +0.000002]  b43_handle_txstatus+0x61/0x80 [b43]
>     [  +0.000012]  b43_interrupt_thread_handler+0x3f9/0x6b0 [b43]
>     [  +0.000011]  irq_thread_fn+0x23/0x60
>     [  +0.000002]  irq_thread+0xfe/0x1c0
>     [  +0.000002]  ? __pfx_irq_thread_dtor+0x10/0x10
>     [  +0.000001]  ? __pfx_irq_thread+0x10/0x10
>     [  +0.000001]  kthread+0xe8/0x120
>     [  +0.000003]  ? __pfx_kthread+0x10/0x10
>     [  +0.000003]  ret_from_fork+0x34/0x50
>     [  +0.000002]  ? __pfx_kthread+0x10/0x10
>     [  +0.000002]  ret_from_fork_asm+0x1b/0x30
>     [  +0.000004]  </TASK>
>     [  +0.000001] ---[ end trace 0000000000000000 ]---
>
>     [  +0.000065] ------------[ cut here ]------------
>     [  +0.000001] WARNING: CPU: 0 PID: 56077 at net/mac80211/util.c:514 _=
_ieee80211_stop_queue+0xcc/0xe0 [mac80211]
>     [  +0.000077] Modules linked in: b43(O) snd_seq_dummy snd_hrtimer snd=
_seq snd_seq_device nft_chain_nat xt_MASQUERADE nf_nat xfrm_user xfrm_algo =
xt_addrtype overlay ccm af_packet amdgpu snd_hda_codec_cirrus snd_hda_codec=
_generic ledtrig_audio drm_exec amdxcp gpu_sched xt_conntrack nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 ip6t_rpfilter ipt_rpfilter xt_pkttype xt_LOG =
nf_log_syslog xt_tcpudp nft_compat nf_tables nfnetlink sch_fq_codel btusb u=
input iTCO_wdt ctr btrtl intel_pmc_bxt i915 intel_rapl_msr mei_hdcp mei_pxp=
 joydev at24 watchdog btintel atkbd libps2 serio radeon btbcm vivaldi_fmap =
btmtk intel_rapl_common snd_hda_codec_hdmi bluetooth uvcvideo nls_iso8859_1=
 applesmc nls_cp437 x86_pkg_temp_thermal snd_hda_intel intel_powerclamp vfa=
t videobuf2_vmalloc coretemp fat snd_intel_dspcfg crc32_pclmul uvc polyval_=
clmulni snd_intel_sdw_acpi loop videobuf2_memops snd_hda_codec tun drm_suba=
lloc_helper polyval_generic drm_ttm_helper drm_buddy tap ecdh_generic video=
buf2_v4l2 gf128mul macvlan ttm ghash_clmulni_intel ecc tg3
>     [  +0.000073]  videodev bridge snd_hda_core rapl crc16 drm_display_he=
lper cec mousedev snd_hwdep evdev intel_cstate bcm5974 hid_appleir videobuf=
2_common stp mac_hid libphy snd_pcm drm_kms_helper acpi_als mei_me intel_un=
core llc mc snd_timer intel_gtt industrialio_triggered_buffer apple_mfi_fas=
tcharge i2c_i801 mei snd lpc_ich agpgart ptp i2c_smbus thunderbolt apple_gm=
ux i2c_algo_bit kfifo_buf video industrialio soundcore pps_core wmi tiny_po=
wer_button sbs sbshc button ac cordic bcma mac80211 cfg80211 ssb rfkill lib=
arc4 kvm_intel kvm drm irqbypass fuse backlight firmware_class efi_pstore c=
onfigfs efivarfs dmi_sysfs ip_tables x_tables autofs4 dm_crypt cbc encrypte=
d_keys trusted asn1_encoder tee tpm rng_core input_leds hid_apple led_class=
 hid_generic usbhid hid sd_mod t10_pi crc64_rocksoft crc64 crc_t10dif crct1=
0dif_generic ahci libahci libata uhci_hcd ehci_pci ehci_hcd crct10dif_pclmu=
l crct10dif_common sha512_ssse3 sha512_generic sha256_ssse3 sha1_ssse3 aesn=
i_intel usbcore scsi_mod libaes crypto_simd cryptd scsi_common
>     [  +0.000084]  usb_common rtc_cmos btrfs blake2b_generic libcrc32c cr=
c32c_generic crc32c_intel xor raid6_pq dm_snapshot dm_bufio dm_mod dax [las=
t unloaded: b43]
>     [  +0.000012] CPU: 0 PID: 56077 Comm: kworker/u16:17 Tainted: G      =
  W  O       6.6.7 #1-NixOS
>     [  +0.000003] Hardware name: Apple Inc. MacBookPro8,3/Mac-942459F5819=
B171B, BIOS 87.0.0.0.0 06/13/2019
>     [  +0.000001] Workqueue: phy7 b43_tx_work [b43]
>     [  +0.000019] RIP: 0010:__ieee80211_stop_queue+0xcc/0xe0 [mac80211]
>     [  +0.000076] Code: 74 11 48 8b 78 08 0f b7 d6 89 e9 4c 89 e6 e8 ab f=
4 00 00 65 ff 0d 9c b7 34 3f 0f 85 55 ff ff ff 0f 1f 44 00 00 e9 4b ff ff f=
f <0f> 0b 5b 5d 41 5c 41 5d c3 cc cc cc cc 0f 1f 80 00 00 00 00 90 90
>     [  +0.000002] RSP: 0000:ffffc90004157d50 EFLAGS: 00010097
>     [  +0.000002] RAX: 0000000000000001 RBX: 0000000000000002 RCX: 000000=
0000000000
>     [  +0.000002] RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff88=
82d65d0900
>     [  +0.000002] RBP: 0000000000000000 R08: 0000000000000001 R09: 000000=
0000000001
>     [  +0.000001] R10: 00000000000000ff R11: ffff88814d0155a0 R12: ffff88=
82d65d0900
>     [  +0.000002] R13: 0000000000000000 R14: ffff8881002d2800 R15: 000000=
00000000d0
>     [  +0.000002] FS:  0000000000000000(0000) GS:ffff88846f800000(0000) k=
nlGS:0000000000000000
>     [  +0.000003] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     [  +0.000002] CR2: 00007f2e8c10c880 CR3: 0000000385b66005 CR4: 000000=
00000606f0
>     [  +0.000002] Call Trace:
>     [  +0.000001]  <TASK>
>     [  +0.000001]  ? __ieee80211_stop_queue+0xcc/0xe0 [mac80211]
>     [  +0.000075]  ? __warn+0x81/0x130
>     [  +0.000004]  ? __ieee80211_stop_queue+0xcc/0xe0 [mac80211]
>     [  +0.000075]  ? report_bug+0x171/0x1a0
>     [  +0.000005]  ? handle_bug+0x41/0x70
>     [  +0.000003]  ? exc_invalid_op+0x17/0x70
>     [  +0.000004]  ? asm_exc_invalid_op+0x1a/0x20
>     [  +0.000004]  ? __ieee80211_stop_queue+0xcc/0xe0 [mac80211]
>     [  +0.000076]  ieee80211_stop_queue+0x36/0x50 [mac80211]
>     [  +0.000077]  b43_dma_tx+0x550/0x780 [b43]
>     [  +0.000023]  b43_tx_work+0x90/0x130 [b43]
>     [  +0.000018]  process_one_work+0x174/0x340
>     [  +0.000003]  worker_thread+0x27b/0x3a0
>     [  +0.000004]  ? __pfx_worker_thread+0x10/0x10
>     [  +0.000002]  kthread+0xe8/0x120
>     [  +0.000003]  ? __pfx_kthread+0x10/0x10
>     [  +0.000004]  ret_from_fork+0x34/0x50
>     [  +0.000002]  ? __pfx_kthread+0x10/0x10
>     [  +0.000003]  ret_from_fork_asm+0x1b/0x30
>     [  +0.000006]  </TASK>
>     [  +0.000001] ---[ end trace 0000000000000000 ]---
>
> Fixes: e6f5b934fba8 ("b43: Add QOS support")
> Signed-off-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>
> ---
>  drivers/net/wireless/broadcom/b43/dma.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/broadcom/b43/dma.c b/drivers/net/wirele=
ss/broadcom/b43/dma.c
> index 760d1a28edc6..68671de27569 100644
> --- a/drivers/net/wireless/broadcom/b43/dma.c
> +++ b/drivers/net/wireless/broadcom/b43/dma.c
> @@ -1399,7 +1399,10 @@ int b43_dma_tx(struct b43_wldev *dev, struct sk_bu=
ff *skb)
>             should_inject_overflow(ring)) {
>                 /* This TX ring is full. */
>                 unsigned int skb_mapping =3D skb_get_queue_mapping(skb);
> -               ieee80211_stop_queue(dev->wl->hw, skb_mapping);
> +               if (dev->qos_enabled)
> +                       ieee80211_stop_queue(dev->wl->hw, skb_mapping);
> +               else
> +                       ieee80211_stop_queue(dev->wl->hw, 0);

Would this be a little cleaner if we only look up the queue mapping if
QOS is enabled? I.e.


unsigned int skb_mapping =3D 0;

if (dev->qos_enabled) {
    skb_mapping =3D skb_get_queue_mapping(skb);
}

ieee80211_stop_queue(dev->wl->hw, skb_mapping);


Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/

