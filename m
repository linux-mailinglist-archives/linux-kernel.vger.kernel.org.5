Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C96F7E1578
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 18:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjKER2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 12:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjKER2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 12:28:13 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC29C5
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 09:28:09 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3b566ee5f1dso2462680b6e.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Nov 2023 09:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscv-rocks.de; s=google; t=1699205288; x=1699810088; darn=vger.kernel.org;
        h=organization:user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:mail-followup-to
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CxEo13rkkkReg1cOZIpcwOL6ZV6Hhh+kOqWNDou1TGs=;
        b=dph9zTRXXletBd+KmhOkTxjCGHfsAHXh5IVvEmYe6YpnligV2oFL4tJQTieaXyPsRq
         RX7Opvicj1z6EoD6fPFYefFYWiHAkMwCfOlhePTIskh29qw0QJP8vHhpCZMsJnnhMuRL
         AB6EzogOW/HebaL+N4toDS3vJf3WdGstzFtbw+nU7gMxzBgtNGeyLY88eb8vURqV9xKf
         jP4tpzPJkUAyYDr20wpjzMZQ3iraMrUyriz2CeF64i2M8DsS0hIhmgXc7L1eJlhNMTKU
         TDwlD0oY9s6x4TvHfcqPB2QhAT3WgvUt6D8KjoMfmC8Zg9eI7WtLRHlx/hDNZJ9oXC+/
         lUjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699205288; x=1699810088;
        h=organization:user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:mail-followup-to
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CxEo13rkkkReg1cOZIpcwOL6ZV6Hhh+kOqWNDou1TGs=;
        b=AxW8rWDXFR735A0yhYJgwvP+Gl+FubCUTgtb5M055H2/dHm8FOVPVC9wEWKDMo5gTB
         EXnFeVsCg/scZiE7c2TfpC/qu7T3G94Z0QgG3eFKOjgADxikekQfp4dnGum1wHbtUo05
         Itk3eVSOnoP0QYHOuXRfS/zZcHrLEM3jFLHF2Df6X7JG0sDhesSmqhkTNAFhRM/kZnsD
         fhDd//U1QQH9O7hgfYncAtvJBk4WWnmHGazXTpMTpBg9kcZeOolDVKXtYPiUNZXTdLIM
         wxxIJuY5vEdTXsn4HvGH+KSk0+y2pa73mdcd3O31Rgrf8cZeCI9Hbrf3k8oi5W2V/aUN
         Hh6Q==
X-Gm-Message-State: AOJu0Yzawnw3l5ASTi+Cy7kSaKAq+lJ7vn45kUm6buNv9SMil1bMzy1b
        jdMPa1Wk2z5h5eXRowyjLVJCYg==
X-Google-Smtp-Source: AGHT+IEaHEe+mp3Jf9583vnndZXg8wMjwozEkczrzSzAKbgVH9Gt1hk1Sp+58+a15V3xkwhS1WT6NA==
X-Received: by 2002:a05:6808:3a0b:b0:3b5:95a0:ee80 with SMTP id gr11-20020a0568083a0b00b003b595a0ee80mr8032294oib.15.1699205287753;
        Sun, 05 Nov 2023 09:28:07 -0800 (PST)
Received: from fedora.fritz.box (p5494469c.dip0.t-ipconnect.de. [84.148.70.156])
        by smtp.gmail.com with ESMTPSA id x13-20020a056808144d00b003b274008e46sm963841oiv.0.2023.11.05.09.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 09:28:07 -0800 (PST)
Date:   Sun, 5 Nov 2023 18:28:03 +0100
From:   Damian Tometzki <damian@riscv-rocks.de>
To:     John Sanpe <sanpeqf@gmail.com>, linux-cifs@vger.kernel.org
Cc:     linkinjeon@kernel.org, pc@manguebit.com,
        linux-kernel@vger.kernel.org
Subject: smb cifs: Linux 6.7 pre rc-1 kernel dump in smb2_get_aead_req
Message-ID: <ZUfQo47uo0p2ZsYg@fedora.fritz.box>
Reply-To: Damian Tometzki <damian@riscv-rocks.de>
Mail-Followup-To: John Sanpe <sanpeqf@gmail.com>,
        linux-cifs@vger.kernel.org, linkinjeon@kernel.org, pc@manguebit.com,
        linux-kernel@vger.kernel.org
References: <20231022183917.1013135-1-sanpeqf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231022183917.1013135-1-sanpeqf@gmail.com>
User-Agent: Mutt
X-Operating-System: Linux Fedora release 39 (Thirty Nine) (Kernel
 6.5.9-300.fc39.x86_64)
Organization: Linux hacker
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hello together,

i get the following kernel dump when i try mount a cifs drive:=20

[   83.380977] CIFS: Attempting to mount //dtometzki.file.core.windows.net/=
sadata
[   83.530165] ------------[ cut here ]------------
[   83.530171] WARNING: CPU: 7 PID: 4584 at fs/smb/client/cifsglob.h:2165 s=
mb2_get_aead_req+0x3fc/0x420 [cifs]
[   83.530271] Modules linked in: nls_utf8 cifs cifs_arc4 nls_ucs2_utils ci=
fs_md4 dns_resolver fscache netfs uinput rfcomm snd_seq_dummy snd_hrtimer n=
f_conntrack_netlink xt_addrtype br_netfilter xt_CHECKSUM xt_MASQUERADE xt_c=
onntrack ipt_REJECT nf_nat_tftp nf_conntrack_tftp nf_conntrack_netbios_ns n=
f_conntrack_broadcast nft_fib_inet bridge nft_fib_ipv6 nft_fib_ipv4 nft_fib=
 stp llc nft_reject_inet nf_reject_ipv6 nft_reject nf_reject_ipv4 nft_ct nf=
t_chain_nat overlay ip6table_nat ip6table_mangle ip6table_raw ip6table_secu=
rity iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_=
mangle iptable_raw iptable_security ip_set nf_tables nfnetlink ip6table_fil=
ter iptable_filter qrtr bnep sunrpc binfmt_misc snd_ctl_led snd_soc_skl_hda=
_dsp snd_soc_hdac_hdmi snd_sof_probes snd_soc_intel_hda_dsp_common snd_soc_=
dmic snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic snd_sof=
_pci_intel_tgl snd_sof_intel_hda_common snd_sof_intel_hda soundwire_intel s=
nd_sof_intel_hda_mlink soundwire_generic_allocation
[   83.530352]  soundwire_cadence snd_sof_pci snd_sof_xtensa_dsp intel_tcc_=
cooling iTCO_wdt snd_sof x86_pkg_temp_thermal intel_pmc_bxt intel_powerclam=
p iTCO_vendor_support snd_sof_utils snd_soc_hdac_hda coretemp snd_hda_ext_c=
ore snd_soc_acpi_intel_match mei_hdcp mei_pxp kvm_intel snd_soc_acpi soundw=
ire_bus snd_soc_core kvm snd_compress intel_rapl_msr ac97_bus vfat snd_pcm_=
dmaengine fat iwlmvm pmt_telemetry pmt_class snd_hda_intel irqbypass snd_in=
tel_dspcfg snd_intel_sdw_acpi rapl mac80211 snd_hda_codec btusb snd_hda_cor=
e uvcvideo btbcm libarc4 snd_hwdep processor_thermal_device_pci_legacy uvc =
btintel videobuf2_v4l2 intel_cstate videobuf2_vmalloc snd_seq videobuf2_mem=
ops processor_thermal_device snd_seq_device btrtl processor_thermal_power_f=
loor videobuf2_common processor_thermal_wt_req intel_uncore snd_pcm iwlwifi=
 videodev i2c_i801 btmtk processor_thermal_wt_hint think_lmi mc firmware_at=
tributes_class wmi_bmof processor_thermal_rfim thinkpad_acpi bluetooth snd_=
timer i2c_smbus mei_me processor_thermal_mbox cfg80211
[   83.530438]  ledtrig_audio processor_thermal_rapl idma64 mei platform_pr=
ofile intel_rapl_common thunderbolt intel_vsec igen6_edac intel_soc_dts_ios=
f rfkill snd int3403_thermal soundcore soc_button_array int340x_thermal_zon=
e int3400_thermal intel_hid acpi_thermal_rel acpi_pad sparse_keymap acpi_ta=
d joydev squashfs loop zram i915 crct10dif_pclmul crc32_pclmul crc32c_intel=
 drm_buddy polyval_clmulni ttm polyval_generic i2c_algo_bit drm_display_hel=
per cec ghash_clmulni_intel hid_multitouch sha512_ssse3 video nvme sha256_s=
sse3 ucsi_acpi sha1_ssse3 typec_ucsi nvme_core i2c_hid_acpi typec i2c_hid w=
mi pinctrl_tigerlake serio_raw scsi_dh_rdac scsi_dh_emc scsi_dh_alua ip6_ta=
bles ip_tables dm_multipath fuse
[   83.530503] CPU: 7 PID: 4584 Comm: mount.cifs Tainted: G        W       =
   6.6.0 #61
[   83.530508] Hardware name: LENOVO 20XWCTO1WW/20XWCTO1WW, BIOS N32ET86W (=
1.62 ) 07/12/2023
[   83.530511] RIP: 0010:smb2_get_aead_req+0x3fc/0x420 [cifs]
[   83.530631] Code: 08 48 8b 44 24 10 48 8b 8c 24 a8 00 00 00 48 89 01 48 =
8b 44 24 30 48 83 c4 70 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc cc <0f=
> 0b 41 bc fb ff ff ff 44 89 e0 31 ff 8b 74 24 24 48 3d 00 f0 ff
[   83.530636] RSP: 0018:ffffc90007893678 EFLAGS: 00010293
[   83.530642] RAX: 0000000000000010 RBX: 0000000000000000 RCX: ffffc900078=
937b0
[   83.530646] RDX: 0000000000000002 RSI: ffff88819f594038 RDI: ffff8881a5a=
d5040
[   83.530649] RBP: 0000000000000000 R08: ffffc90007893740 R09: ffffc900078=
93758
[   83.530652] R10: ffffc90007893760 R11: ffffffff81791d20 R12: 00000000000=
00002
[   83.530655] R13: 0000000000000000 R14: 0000000000000014 R15: ffff88819f5=
94038
[   83.530658] FS:  00007f654431a780(0000) GS:ffff88844f7c0000(0000) knlGS:=
0000000000000000
[   83.530663] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   83.530666] CR2: 00007ffdeb730008 CR3: 000000019d246001 CR4: 0000000000f=
70ef0
[   83.530671] PKRU: 55555554
[   83.530673] Call Trace:
[   83.530680]  <TASK>
[   83.530686]  ? __warn+0xc8/0x1c0
[   83.530696]  ? smb2_get_aead_req+0x3fc/0x420 [cifs]
[   83.530807]  ? report_bug+0x163/0x200
[   83.530814]  ? handle_bug+0x42/0x70
[   83.530821]  ? exc_invalid_op+0x1a/0x50
[   83.530829]  ? asm_exc_invalid_op+0x1a/0x20
[   83.530837]  ? __pfx_crypto_ccm_setauthsize+0x10/0x10
[   83.530846]  ? smb2_get_aead_req+0x3fc/0x420 [cifs]
[   83.530951]  ? aes_set_key+0x5c/0x90
[   83.530961]  crypt_message+0x33e/0x550 [cifs]
[   83.531080]  smb3_init_transform_rq+0x27d/0x3f0 [cifs]
[   83.531202]  ? smb_send_rqst+0x74/0x160 [cifs]
[   83.531329]  smb_send_rqst+0xc7/0x160 [cifs]
[   83.531453]  compound_send_recv+0x3ca/0x9f0 [cifs]
[   83.531589]  ? preempt_count_add+0x67/0xb0
[   83.531599]  ? _raw_spin_lock+0x1d/0x40
[   83.531609]  cifs_send_recv+0x25/0x30 [cifs]
[   83.531730]  SMB2_tcon+0x38a/0x820 [cifs]
[   83.531854]  ? preempt_count_add+0x67/0xb0
[   83.531864]  cifs_get_smb_ses+0x69c/0xee0 [cifs]
[   83.531991]  cifs_mount_get_session+0x76/0x1d0 [cifs]
[   83.532113]  dfs_mount_share+0x74/0x9d0 [cifs]
[   83.532232]  ? smb3_fs_context_dup+0x134/0x1e0 [cifs]
[   83.532352]  ? __kmem_cache_alloc_node+0x181/0x280
[   83.532361]  ? slab_post_alloc_hook+0x78/0x360
[   83.532372]  cifs_mount+0x6e/0x2e0 [cifs]
[   83.532495]  cifs_smb3_do_mount+0x143/0x300 [cifs]
[   83.532638]  smb3_get_tree+0x15e/0x290 [cifs]
[   83.532759]  vfs_get_tree+0x2d/0xe0
[   83.532767]  do_new_mount+0x124/0x340
[   83.532779]  __se_sys_mount+0x143/0x1a0
[   83.532788]  do_syscall_64+0x68/0x100
[   83.532797]  ? preempt_count_add+0x5a/0xb0
[   83.532806]  ? up_read+0x43/0xd0
[   83.532815]  ? do_user_addr_fault+0x220/0x790
[   83.532826]  ? exc_page_fault+0x7a/0x1b0
[   83.532834]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[   83.532843] RIP: 0033:0x7f65444338ee
[   83.532921] Code: 48 8b 0d 45 15 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 =
2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 12 15 0c 00 f7 d8 64 89 01 48
[   83.532926] RSP: 002b:00007fffc0fa5308 EFLAGS: 00000246 ORIG_RAX: 000000=
00000000a5
[   83.532934] RAX: ffffffffffffffda RBX: 000000000000000a RCX: 00007f65444=
338ee
[   83.532938] RDX: 000055641db9a476 RSI: 000055641db9a4dc RDI: 00007fffc0f=
a573d
[   83.532941] RBP: 00007fffc0fa53c0 R08: 000055641f5dceb0 R09: 00000000000=
00000
[   83.532945] R10: 0000000000000000 R11: 0000000000000246 R12: 000055641db=
9a03f
[   83.532949] R13: 000055641f5ddf40 R14: 00007fffc0fa573d R15: 00007f65445=
20000
[   83.532957]  </TASK>
[   83.532959] ---[ end trace 0000000000000000 ]---
[   83.532967] BUG: unable to handle page fault for address: 0000001fffffff=
40
[   83.532974] #PF: supervisor read access in kernel mode
[   83.532980] #PF: error_code(0x0000) - not-present page
[   83.532985] PGD 0 P4D 0=20
[   83.532993] Oops: 0000 [#1] PREEMPT SMP NOPTI
[   83.533000] CPU: 7 PID: 4584 Comm: mount.cifs Tainted: G        W       =
   6.6.0 #61
[   83.533008] Hardware name: LENOVO 20XWCTO1WW/20XWCTO1WW, BIOS N32ET86W (=
1.62 ) 07/12/2023
[   83.533011] RIP: 0010:smb2_get_aead_req+0x282/0x420 [cifs]
[   83.533134] Code: 8d 3c 0a 48 83 c7 07 48 83 e7 f8 48 89 7c 24 10 48 3d =
00 f0 ff ff 0f 87 74 01 00 00 48 89 44 24 30 41 8d 4c 24 ff 48 c1 e1 05 <48=
> 8b 14 0f 48 83 e2 fc 48 83 ca 02 48 89 14 0f 85 f6 0f 84 06 01
[   83.533140] RSP: 0018:ffffc90007893678 EFLAGS: 00010202
[   83.533147] RAX: 00000000fffffffb RBX: 0000000000000000 RCX: 0000001ffff=
fff40
[   83.533152] RDX: 0000000000000002 RSI: 0000000000000002 RDI: 00000000000=
00000
[   83.533159] RBP: 0000000000000000 R08: ffffc90007893740 R09: ffffc900078=
93758
[   83.533163] R10: ffffc90007893760 R11: ffffffff81791d20 R12: 00000000fff=
ffffb
[   83.533168] R13: 0000000000000000 R14: 0000000000000014 R15: ffff88819f5=
94038
[   83.533173] FS:  00007f654431a780(0000) GS:ffff88844f7c0000(0000) knlGS:=
0000000000000000
[   83.533179] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   83.533184] CR2: 0000001fffffff40 CR3: 000000019d246001 CR4: 0000000000f=
70ef0
[   83.533189] PKRU: 55555554
[   83.533193] Call Trace:
[   83.533197]  <TASK>
[   83.533201]  ? __die_body+0x68/0xb0
[   83.533211]  ? page_fault_oops+0x388/0x3f0
[   83.533224]  ? exc_page_fault+0x7a/0x1b0
[   83.533233]  ? asm_exc_page_fault+0x26/0x30
[   83.533243]  ? __pfx_crypto_ccm_setauthsize+0x10/0x10
[   83.533253]  ? smb2_get_aead_req+0x282/0x420 [cifs]
[   83.533376]  ? aes_set_key+0x5c/0x90
[   83.533387]  crypt_message+0x33e/0x550 [cifs]
[   83.533515]  smb3_init_transform_rq+0x27d/0x3f0 [cifs]
[   83.533652]  ? smb_send_rqst+0x74/0x160 [cifs]
[   83.533801]  smb_send_rqst+0xc7/0x160 [cifs]
[   83.533950]  compound_send_recv+0x3ca/0x9f0 [cifs]
[   83.534102]  ? preempt_count_add+0x67/0xb0
[   83.534112]  ? _raw_spin_lock+0x1d/0x40
[   83.534121]  cifs_send_recv+0x25/0x30 [cifs]
[   83.534229]  SMB2_tcon+0x38a/0x820 [cifs]
[   83.534354]  ? preempt_count_add+0x67/0xb0
[   83.534363]  cifs_get_smb_ses+0x69c/0xee0 [cifs]
[   83.534487]  cifs_mount_get_session+0x76/0x1d0 [cifs]
[   83.534610]  dfs_mount_share+0x74/0x9d0 [cifs]
[   83.534704]  ? smb3_fs_context_dup+0x134/0x1e0 [cifs]
[   83.534790]  ? __kmem_cache_alloc_node+0x181/0x280
[   83.534797]  ? slab_post_alloc_hook+0x78/0x360
[   83.534804]  cifs_mount+0x6e/0x2e0 [cifs]
[   83.534893]  cifs_smb3_do_mount+0x143/0x300 [cifs]
[   83.534981]  smb3_get_tree+0x15e/0x290 [cifs]
[   83.535069]  vfs_get_tree+0x2d/0xe0
[   83.535073]  do_new_mount+0x124/0x340
[   83.535080]  __se_sys_mount+0x143/0x1a0
[   83.535087]  do_syscall_64+0x68/0x100
[   83.535093]  ? preempt_count_add+0x5a/0xb0
[   83.535100]  ? up_read+0x43/0xd0
[   83.535106]  ? do_user_addr_fault+0x220/0x790
[   83.535113]  ? exc_page_fault+0x7a/0x1b0
[   83.535119]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[   83.535125] RIP: 0033:0x7f65444338ee
[   83.535144] Code: 48 8b 0d 45 15 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 =
2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 12 15 0c 00 f7 d8 64 89 01 48
[   83.535148] RSP: 002b:00007fffc0fa5308 EFLAGS: 00000246 ORIG_RAX: 000000=
00000000a5
[   83.535153] RAX: ffffffffffffffda RBX: 000000000000000a RCX: 00007f65444=
338ee
[   83.535156] RDX: 000055641db9a476 RSI: 000055641db9a4dc RDI: 00007fffc0f=
a573d
[   83.535158] RBP: 00007fffc0fa53c0 R08: 000055641f5dceb0 R09: 00000000000=
00000
[   83.535161] R10: 0000000000000000 R11: 0000000000000246 R12: 000055641db=
9a03f
[   83.535163] R13: 000055641f5ddf40 R14: 00007fffc0fa573d R15: 00007f65445=
20000
[   83.535168]  </TASK>
[   83.535170] Modules linked in: nls_utf8 cifs cifs_arc4 nls_ucs2_utils ci=
fs_md4 dns_resolver fscache netfs uinput rfcomm snd_seq_dummy snd_hrtimer n=
f_conntrack_netlink xt_addrtype br_netfilter xt_CHECKSUM xt_MASQUERADE xt_c=
onntrack ipt_REJECT nf_nat_tftp nf_conntrack_tftp nf_conntrack_netbios_ns n=
f_conntrack_broadcast nft_fib_inet bridge nft_fib_ipv6 nft_fib_ipv4 nft_fib=
 stp llc nft_reject_inet nf_reject_ipv6 nft_reject nf_reject_ipv4 nft_ct nf=
t_chain_nat overlay ip6table_nat ip6table_mangle ip6table_raw ip6table_secu=
rity iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_=
mangle iptable_raw iptable_security ip_set nf_tables nfnetlink ip6table_fil=
ter iptable_filter qrtr bnep sunrpc binfmt_misc snd_ctl_led snd_soc_skl_hda=
_dsp snd_soc_hdac_hdmi snd_sof_probes snd_soc_intel_hda_dsp_common snd_soc_=
dmic snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic snd_sof=
_pci_intel_tgl snd_sof_intel_hda_common snd_sof_intel_hda soundwire_intel s=
nd_sof_intel_hda_mlink soundwire_generic_allocation
[   83.535241]  soundwire_cadence snd_sof_pci snd_sof_xtensa_dsp intel_tcc_=
cooling iTCO_wdt snd_sof x86_pkg_temp_thermal intel_pmc_bxt intel_powerclam=
p iTCO_vendor_support snd_sof_utils snd_soc_hdac_hda coretemp snd_hda_ext_c=
ore snd_soc_acpi_intel_match mei_hdcp mei_pxp kvm_intel snd_soc_acpi soundw=
ire_bus snd_soc_core kvm snd_compress intel_rapl_msr ac97_bus vfat snd_pcm_=
dmaengine fat iwlmvm pmt_telemetry pmt_class snd_hda_intel irqbypass snd_in=
tel_dspcfg snd_intel_sdw_acpi rapl mac80211 snd_hda_codec btusb snd_hda_cor=
e uvcvideo btbcm libarc4 snd_hwdep processor_thermal_device_pci_legacy uvc =
btintel videobuf2_v4l2 intel_cstate videobuf2_vmalloc snd_seq videobuf2_mem=
ops processor_thermal_device snd_seq_device btrtl processor_thermal_power_f=
loor videobuf2_common processor_thermal_wt_req intel_uncore snd_pcm iwlwifi=
 videodev i2c_i801 btmtk processor_thermal_wt_hint think_lmi mc firmware_at=
tributes_class wmi_bmof processor_thermal_rfim thinkpad_acpi bluetooth snd_=
timer i2c_smbus mei_me processor_thermal_mbox cfg80211
[   83.535316]  ledtrig_audio processor_thermal_rapl idma64 mei platform_pr=
ofile intel_rapl_common thunderbolt intel_vsec igen6_edac intel_soc_dts_ios=
f rfkill snd int3403_thermal soundcore soc_button_array int340x_thermal_zon=
e int3400_thermal intel_hid acpi_thermal_rel acpi_pad sparse_keymap acpi_ta=
d joydev squashfs loop zram i915 crct10dif_pclmul crc32_pclmul crc32c_intel=
 drm_buddy polyval_clmulni ttm polyval_generic i2c_algo_bit drm_display_hel=
per cec ghash_clmulni_intel hid_multitouch sha512_ssse3 video nvme sha256_s=
sse3 ucsi_acpi sha1_ssse3 typec_ucsi nvme_core i2c_hid_acpi typec i2c_hid w=
mi pinctrl_tigerlake serio_raw scsi_dh_rdac scsi_dh_emc scsi_dh_alua ip6_ta=
bles ip_tables dm_multipath fuse
[   83.535379] CR2: 0000001fffffff40
[   83.535383] ---[ end trace 0000000000000000 ]---
[   83.535386] RIP: 0010:smb2_get_aead_req+0x282/0x420 [cifs]
[   83.535473] Code: 8d 3c 0a 48 83 c7 07 48 83 e7 f8 48 89 7c 24 10 48 3d =
00 f0 ff ff 0f 87 74 01 00 00 48 89 44 24 30 41 8d 4c 24 ff 48 c1 e1 05 <48=
> 8b 14 0f 48 83 e2 fc 48 83 ca 02 48 89 14 0f 85 f6 0f 84 06 01
[   83.535476] RSP: 0018:ffffc90007893678 EFLAGS: 00010202
[   83.535480] RAX: 00000000fffffffb RBX: 0000000000000000 RCX: 0000001ffff=
fff40
[   83.535483] RDX: 0000000000000002 RSI: 0000000000000002 RDI: 00000000000=
00000
[   83.535485] RBP: 0000000000000000 R08: ffffc90007893740 R09: ffffc900078=
93758
[   83.535487] R10: ffffc90007893760 R11: ffffffff81791d20 R12: 00000000fff=
ffffb
[   83.535490] R13: 0000000000000000 R14: 0000000000000014 R15: ffff88819f5=
94038
[   83.535493] FS:  00007f654431a780(0000) GS:ffff88844f7c0000(0000) knlGS:=
0000000000000000
[   83.535496] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   83.535499] CR2: 0000001fffffff40 CR3: 000000019d246001 CR4: 0000000000f=
70ef0
[   83.535502] PKRU: 55555554
[   83.535504] note: mount.cifs[4584] exited with irqs disabled
