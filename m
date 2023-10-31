Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E167DCB35
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 11:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjJaK4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 06:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjJaK43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 06:56:29 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65279A6;
        Tue, 31 Oct 2023 03:56:27 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5b980391d70so1954843a12.0;
        Tue, 31 Oct 2023 03:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698749787; x=1699354587; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h7qez367jKYKaWLzqPHkUsAreXX07tNKmEBtn/BB0/g=;
        b=iZa4jdWG/s3y2lTZFjzfGNxGEd3tKi9tf1/tcJRZiHbvI5z0tUWBUz2udXyuGQSLSJ
         cljBa0oJY9FT848rnUqGsCsTj7IdCh3VQlAf2GK0sB68k4EZKEwd18i2tRIUViNh3ojt
         XCqfBg+TVg5g2WqPg4P94aW97gLMMCnMh8Ix5/AdOo3NtBpguOTQanEqWgiZdAoMcw0d
         11cy018URdqFRaiEWK+yZDGecWupIXNkE3vdvOlL5p9uIuhNGE/YsCj7wmJxeM1wLL6O
         3GPk/ZEvpHUuQ5pMDahqCjbJX87N9oCkbmfSERA8SwBjdGXGsitmQAnaqRx2k/cOE/9K
         Ngfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698749787; x=1699354587;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h7qez367jKYKaWLzqPHkUsAreXX07tNKmEBtn/BB0/g=;
        b=CGTwlTWlLUnUCv6nMgzsAYB/x9IYDXhoU0KaKVuEqVu3yC6nAA0vKTDhYV4ZKcrEdU
         vALIDMjhTh+aNacrSK+020J6w/02O1nDdF2hpAFQw/8dSdBWno4ZBNhokTxxU/02kbCt
         wVYggmzdaUwsXoRtLa7ejOgIV/H7zJJzxl1BsxvdN/YsewXG9bI5cgz3OTtPCIT7DT8B
         dGfX8UMM8vtr7aO3W1axGEoK0j/eJqHm2/CojPbrf7tXqaZZ6Zr4xmVyQEAZcx2oRizm
         hyPUINETEyCd9OmPaVfm0I9KXOiC7j5owQzeBWlWSvkhypgOCkHuAQVsLhTIpM6PRJc3
         1Uow==
X-Gm-Message-State: AOJu0YxHwWrJ4VrFFmBpwFUTgpN2BqvrdmsSvOvquTEqJNyfmpgO57gS
        qRdOmSAIy+Uur2y2HW994ehr8LzaCjM=
X-Google-Smtp-Source: AGHT+IEIvEt+Nyd59FkpEmM0jVZ1Qg8PZ7FuhIcWSXs+gYuDVYaq6iFg2dEVuEj2J2PbvMYqFrbvuA==
X-Received: by 2002:a05:6a21:32a2:b0:14c:f16a:2b78 with SMTP id yt34-20020a056a2132a200b0014cf16a2b78mr15999447pzb.45.1698749786708;
        Tue, 31 Oct 2023 03:56:26 -0700 (PDT)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id m20-20020aa78a14000000b006b24b99afd4sm1040512pfa.176.2023.10.31.03.56.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 03:56:25 -0700 (PDT)
Message-ID: <c22ccb68-64b6-404b-a8a8-f800770e2cfb@gmail.com>
Date:   Tue, 31 Oct 2023 17:56:22 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ASMedia 2464PD-based SSD enclosure hotplug failure
Content-Language: en-US
To:     initramfs <initramfs@initramfs.io>,
        Linux USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <2fd4b2b0-0526-4946-ad05-058366f3127a@initramfs.io>
 <ZUC3LAxK9Lyf2Rz9@debian.me>
 <44d23bf5-9875-4ce8-a361-fb4e678f23f2@initramfs.io>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <44d23bf5-9875-4ce8-a361-fb4e678f23f2@initramfs.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/2023 16:04, initramfs wrote:
> Yes the same issue occurs on the LTS kernel (tried 6.1.60):
> 
>     [  125.380911] thunderbolt 0-0:1.1: new retimer found, vendor=0x8087
>     device=0x15ee
>     [  125.404923] thunderbolt 0-1: new device found, vendor=0x187
>     device=0xd666
>     [  125.404935] thunderbolt 0-1: Gopod Group Limited. USB4 SSD Drive
>     Enclosure
>     [  125.511460] thunderbolt 0000:00:0d.2: 1:1: failed to enable lane
>     bonding
>     [  125.511793] thunderbolt 0000:00:0d.2: 1: failed to enable
>     CL0s/CL1 on upstream port
>     [  125.512698] thunderbolt 0000:00:0d.2: 1: failed to enable TMU
>     [  125.514122] thunderbolt 0000:00:0d.2: 1:1: hop deactivation
>     failed for hop 1, index 8
>     [  125.514126] ------------[ cut here ]------------
>     [  125.514126] thunderbolt 0000:00:0d.2: path activation failed
>     [  125.514160] WARNING: CPU: 6 PID: 3029 at
>     drivers/thunderbolt/path.c:573 tb_path_activate+0x10f/0x480
>     [thunderbolt]
>     [  125.514176] Modules linked in: ccm rfcomm snd_seq_dummy
>     snd_hrtimer snd_seq snd_seq_device nft_ct nf_conntrack
>     nf_defrag_ipv6 nf_defrag_ipv4 cmac algif_hash algif_skcipher af_alg
>     bnep nf_tables nfnetlink ntfs3 snd_sof_pci_intel_tgl
>     snd_sof_intel_hda_common soundwire_intel
>     soundwire_generic_allocation soundwire_cadence snd_sof_intel_hda
>     snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils
>     snd_soc_hdac_hda snd_hda_ext_core snd_soc_acpi_intel_match
>     intel_tcc_cooling snd_soc_acpi x86_pkg_temp_thermal soundwire_bus
>     intel_powerclamp coretemp snd_soc_core snd_compress iwlmvm ac97_bus
>     kvm_intel snd_hda_codec_realtek snd_hda_codec_generic
>     snd_hda_codec_hdmi snd_pcm_dmaengine mei_pxp mei_hdcp kvm
>     snd_hda_intel mac80211 uvcvideo snd_intel_dspcfg irqbypass
>     pmt_telemetry processor_thermal_device_pci videobuf2_vmalloc
>     iTCO_wdt snd_intel_sdw_acpi btusb intel_pmc_bxt videobuf2_memops
>     snd_hda_codec processor_thermal_device btrtl rapl libarc4
>     videobuf2_v4l2 videobuf2_common intel_cstate hid_multitouch
>     [  125.514200]  iTCO_vendor_support intel_rapl_msr pmt_class
>     snd_hda_core btbcm processor_thermal_rfim iwlwifi r8169
>     processor_thermal_mbox mei_me btintel ucsi_acpi snd_hwdep
>     intel_uncore dm_zero pcspkr asus_nb_wmi wmi_bmof realtek spi_nor
>     typec_ucsi vfat btmtk processor_thermal_rapl videodev snd_pcm
>     intel_lpss_pci bluetooth i2c_hid_acpi i2c_i801 snd_timer mdio_devres
>     intel_lpss fat mtd cfg80211 i2c_smbus ecdh_generic typec snd libphy
>     idma64 thunderbolt mc mei roles intel_vsec crc16 igen6_edac
>     soundcore intel_rapl_common i2c_hid joydev int3403_thermal mousedev
>     int340x_thermal_zone int3400_thermal acpi_tad acpi_thermal_rel
>     acpi_pad mac_hid pkcs8_key_parser dm_multipath i2c_dev crypto_user
>     fuse loop ip_tables x_tables btrfs blake2b_generic libcrc32c
>     crc32c_generic xor raid6_pq dm_crypt cbc encrypted_keys trusted
>     asn1_encoder tee hid_asus asus_wmi ledtrig_audio sparse_keymap
>     platform_profile rfkill usbhid dm_mod i915 crct10dif_pclmul
>     crc32_pclmul crc32c_intel serio_raw polyval_clmulni atkbd
>     [  125.514230]  polyval_generic libps2 gf128mul vivaldi_fmap
>     ghash_clmulni_intel sdhci_pci drm_buddy sha512_ssse3 nvme intel_gtt
>     cqhci aesni_intel drm_display_helper sdhci crypto_simd nvme_core
>     cryptd spi_intel_pci cec xhci_pci mmc_core spi_intel nvme_common
>     xhci_pci_renesas ttm i8042 video serio wmi
>     [  125.514241] CPU: 6 PID: 3029 Comm: pool-/usr/lib/b Tainted: G
>     S                 6.1.60-1-lts #1
>     788389645ca0dfa4ffa30b1532df8c1764b26b03
>     [  125.514243] Hardware name: ASUSTeK COMPUTER INC. ROG Zephyrus M16
>     GU603ZW_GU603ZW/GU603ZW, BIOS GU603ZW.311 12/22/2022
>     [  125.514244] RIP: 0010:tb_path_activate+0x10f/0x480 [thunderbolt]
>     [  125.514253] Code: 01 00 00 48 85 ed 0f 84 d7 00 00 00 48 81 c7 d0
>     00 00 00 e8 b3 ca d6 eb 48 89 ea 48 c7 c7 18 a6 e9 c0 48 89 c6 e8 b1
>     b0 62 eb <0f> 0b 48 8b 44 24 08 65 48 2b 04 25 28 00 00 00 0f 85 54
>     03 00 00
>     [  125.514254] RSP: 0018:ffffadad859b7cb0 EFLAGS: 00010282
>     [  125.514256] RAX: 0000000000000000 RBX: 00000000ffffff95 RCX:
>     0000000000000027
>     [  125.514257] RDX: ffff8c56eb3a1668 RSI: 0000000000000001 RDI:
>     ffff8c56eb3a1660
>     [  125.514257] RBP: ffff8c4f83121790 R08: 0000000000000000 R09:
>     ffffadad859b7b28
>     [  125.514258] R10: 0000000000000003 R11: ffff8c570b7a5fe8 R12:
>     0000000000000028
>     [  125.514258] R13: ffff8c505a524d00 R14: ffff8c4f8f880000 R15:
>     ffff8c4f851d4da0
>     [  125.514259] FS:  00007f29a19fe6c0(0000) GS:ffff8c56eb380000(0000)
>     knlGS:0000000000000000
>     [  125.514260] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     [  125.514261] CR2: 000056005d26e1d0 CR3: 0000000111ef8000 CR4:
>     0000000000f50ee0
>     [  125.514262] PKRU: 55555554
>     [  125.514262] Call Trace:
>     [  125.514264]  <TASK>
>     [  125.514264]  ? tb_path_activate+0x10f/0x480 [thunderbolt
>     f4f72a0462286342085ff69fa5e3502c86c4ec5a]
>     [  125.514273]  ? __warn+0x7d/0xd0
>     [  125.514277]  ? tb_path_activate+0x10f/0x480 [thunderbolt
>     f4f72a0462286342085ff69fa5e3502c86c4ec5a]
>     [  125.514285]  ? report_bug+0xe6/0x150
>     [  125.514288]  ? handle_bug+0x3c/0x80
>     [  125.514291]  ? exc_invalid_op+0x17/0x70
>     [  125.514292]  ? asm_exc_invalid_op+0x1a/0x20
>     [  125.514295]  ? tb_path_activate+0x10f/0x480 [thunderbolt
>     f4f72a0462286342085ff69fa5e3502c86c4ec5a]
>     [  125.514303]  tb_tunnel_restart+0x99/0x180 [thunderbolt
>     f4f72a0462286342085ff69fa5e3502c86c4ec5a]
>     [  125.514312]  tb_tunnel_pci+0x17b/0x370 [thunderbolt
>     f4f72a0462286342085ff69fa5e3502c86c4ec5a]
>     [  125.514321]  authorized_store+0x289/0x2d0 [thunderbolt
>     f4f72a0462286342085ff69fa5e3502c86c4ec5a]
>     [  125.514330]  kernfs_fop_write_iter+0x133/0x1d0
>     [  125.514333]  vfs_write+0x236/0x3f0
>     [  125.514335]  ksys_write+0x6f/0xf0
>     [  125.514337]  do_syscall_64+0x5d/0x90
>     [  125.514339]  ? exit_to_user_mode_prepare+0x18a/0x1f0
>     [  125.514341]  ? syscall_exit_to_user_mode+0x2b/0x40
>     [  125.514342]  ? do_syscall_64+0x6c/0x90
>     [  125.514343]  ? exit_to_user_mode_prepare+0x18a/0x1f0
>     [  125.514345]  ? syscall_exit_to_user_mode+0x2b/0x40
>     [  125.514345]  ? do_syscall_64+0x6c/0x90
>     [  125.514347]  entry_SYSCALL_64_after_hwframe+0x64/0xce
>     [  125.514349] RIP: 0033:0x7f29a36a906f
>     [  125.514368] Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 19 4d
>     f8 ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00
>     00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 6c 4d
>     f8 ff 48
>     [  125.514369] RSP: 002b:00007f29a19fdc90 EFLAGS: 00000293 ORIG_RAX:
>     0000000000000001
>     [  125.514370] RAX: ffffffffffffffda RBX: 00007f2998008c40 RCX:
>     00007f29a36a906f
>     [  125.514371] RDX: 0000000000000001 RSI: 00007f29a19fdd30 RDI:
>     000000000000000a
>     [  125.514372] RBP: 00007f29a19fdd70 R08: 0000000000000000 R09:
>     00007f29a19fdba0
>     [  125.514372] R10: 0000000000000000 R11: 0000000000000293 R12:
>     00007f2998002e20
>     [  125.514373] R13: 000000000000000a R14: 0000000000000000 R15:
>     00007f29a19fdd28
>     [  125.514374]  </TASK>
>     [  125.514374] ---[ end trace 0000000000000000 ]---
>     [  125.514376] thunderbolt 0000:00:0d.2: 0:8 <-> 1:3 (PCI):
>     activation failed
>     [  125.515359] thunderbolt 0000:00:0d.2: 1:3: PCIe tunnel activation
>     failed, aborting
>     [  125.515397] thunderbolt 0-0:1.1: retimer disconnected
>     [  125.515454] thunderbolt 0-1: device disconnected
> 

Please don't top-post; reply inline with appropriate context instead.

Thanks for information!

-- 
An old man doll... just what I always wanted! - Clara

