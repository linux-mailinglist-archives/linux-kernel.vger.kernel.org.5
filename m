Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FDF7DC7F6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 09:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbjJaINp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 04:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbjJaINk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 04:13:40 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38204C9;
        Tue, 31 Oct 2023 01:13:37 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-5842a7fdc61so2944780eaf.3;
        Tue, 31 Oct 2023 01:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698740016; x=1699344816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0yDQmvDeWL6oAYNC+Jue00SaqEgJzS+AxNBZ9LY+fKs=;
        b=kwJlrVlAXH4UXI1PorXj1uVPs49IakfKLOQOismGCnYsMjHQBlNzOSW0eAkPh11xLV
         vawnVPnSDBc1kfU594wCFRsialraQjvEGa/t2eThkoN29RXH3GQwd9K6781ZGyaQJdUb
         yWheM8kUwFTbYCa6xq/kZBZn7GOa8mns/8CWRGe6PsIvw9htGVgl6J7SmNjFfC3gd6KN
         1tUaiBGjtrhrMnTdyRkZrND522F0yD/fNb/zAG7CyOvmeeFAJJpDmdWN/W5u6iJvNAUY
         AupyhYdt/OzBx0c/vOkmaui0oYWNnxdG5vqGB0LycCp4nVNOJqEq5ERbgCxWYkEMrpRb
         +DYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698740016; x=1699344816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0yDQmvDeWL6oAYNC+Jue00SaqEgJzS+AxNBZ9LY+fKs=;
        b=HSjdyhhqb8AQ/rE4k1LYQBb2Vxl/IKQqnc9q5a2/0Z34limmPoRMA+3+G2n7dXROUQ
         iZkNvM2TMyXC4/6wPnQXMSfuT4iHBvmOtJ/kzM0IPekp73dWit6JomodBYpcIMys1THk
         R5YsGwuWYMNLOF38QdX6d7FjhiyLUA+XX4Fzu943GIilz+eqiqlxFsOj9ZktHxmiTM7M
         LGlsmukcinY+VrItaQMSVNagHGvtDd3OExoMV/L8ivDZfWvMuBpvVHHxuz+3gnNrbzZN
         1Xe/lJWQlaPnGa95+b15DxfAOmCD3UE7T8dkkEdMeZ7toJrHXnws9/GiBNbgomoS21bh
         dngg==
X-Gm-Message-State: AOJu0Yx9/+uds01VCk57+SiqMV0VxWZBBOtdvbusYPnt5VFZ/vxr/F9k
        vXrCOyeBiKWcbfOjPGiDywI=
X-Google-Smtp-Source: AGHT+IHBLMCmYUMBsShYBsSheIMdYBWR/ulehU9r0/CJBbvsjaKXMNbTevK90jIy3KIeuwWkrSOp9g==
X-Received: by 2002:a05:6358:6f9a:b0:169:16fb:398c with SMTP id s26-20020a0563586f9a00b0016916fb398cmr13567931rwn.22.1698740016312;
        Tue, 31 Oct 2023 01:13:36 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id r18-20020a638f52000000b00578b40a4903sm627082pgn.22.2023.10.31.01.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 01:13:35 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 7BBCA819BFD9; Tue, 31 Oct 2023 15:13:32 +0700 (WIB)
Date:   Tue, 31 Oct 2023 15:13:32 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     initramfs <initramfs@initramfs.io>,
        Linux USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: ASMedia 2464PD-based SSD enclosure hotplug failure
Message-ID: <ZUC3LAxK9Lyf2Rz9@debian.me>
References: <2fd4b2b0-0526-4946-ad05-058366f3127a@initramfs.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Pk2mZ6L2ssJqFiIL"
Content-Disposition: inline
In-Reply-To: <2fd4b2b0-0526-4946-ad05-058366f3127a@initramfs.io>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Pk2mZ6L2ssJqFiIL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 12:20:08PM +0800, initramfs wrote:
> Hi all,
>=20
> I own a ZikeDrive USB4 NVMe SSD enclosure and noticed that upon
> hotplugging the enclosure I receive the following kernel oops (6.6.0):
>=20
>     [=C2=A0 138.597027] thunderbolt 0-0:1.1: new retimer found, vendor=3D=
0x8087
>     device=3D0x15ee
>     [=C2=A0 138.626031] thunderbolt 0-1: new device found, vendor=3D0x187
>     device=3D0xd666
>     [=C2=A0 138.626046] thunderbolt 0-1: Gopod Group Limited. USB4 SSD Dr=
ive
>     Enclosure
>     [=C2=A0 138.736546] thunderbolt 0000:00:0d.2: 1:1: failed to enable l=
ane
>     bonding
>     [=C2=A0 138.736888] thunderbolt 0000:00:0d.2: 1: failed to enable CL =
states
>     [=C2=A0 138.737874] thunderbolt 0000:00:0d.2: 1: failed to enable TMU
>     [=C2=A0 138.739417] thunderbolt 0000:00:0d.2: 1:1: hop deactivation
>     failed for hop 1, index 8
>     [=C2=A0 138.739421] ------------[ cut here ]------------
>     [=C2=A0 138.739422] thunderbolt 0000:00:0d.2: path activation failed
>     [=C2=A0 138.739462] WARNING: CPU: 6 PID: 3845 at
>     drivers/thunderbolt/path.c:573 tb_path_activate+0x10f/0x480
>     [thunderbolt]
>     [=C2=A0 138.739495] Modules linked in: ccm rfcomm snd_seq_dummy
>     snd_hrtimer snd_seq snd_seq_device cmac algif_hash algif_skcipher
>     af_alg nft_ct nf_conntrack nf_defrag_ipv4 nf_defrag_ipv6 bnep
>     nf_tables nfnetlink ntfs3 snd_sof_pci_intel_tgl
>     snd_sof_intel_hda_common soundwire_intel snd_sof_intel_hda_mlink
>     soundwire_cadence snd_sof_intel_hda snd_sof_pci snd_sof_xtensa_dsp
>     snd_sof snd_sof_utils snd_soc_hdac_hda snd_hda_ext_core
>     snd_soc_acpi_intel_match snd_soc_acpi soundwire_generic_allocation
>     soundwire_bus iwlmvm intel_uncore_frequency snd_soc_core
>     intel_uncore_frequency_common intel_tcc_cooling snd_compress
>     snd_hda_codec_realtek ac97_bus x86_pkg_temp_thermal intel_powerclamp
>     snd_hda_codec_generic snd_hda_codec_hdmi snd_pcm_dmaengine coretemp
>     mac80211 snd_hda_intel hid_multitouch kvm_intel snd_intel_dspcfg
>     snd_intel_sdw_acpi libarc4 mei_pxp kvm btusb uvcvideo mei_hdcp
>     snd_hda_codec btrtl uvc processor_thermal_device_pci videobuf2_v4l2
>     btbcm irqbypass snd_hda_core iTCO_wdt processor_thermal_device
>     dm_zero btintel videodev btmtk
>     [=C2=A0 138.739535]=C2=A0 iTCO_vendor_support processor_thermal_rapl =
snd_hwdep
>     r8169 rapl ucsi_acpi intel_pmc_bxt intel_rapl_msr iwlwifi bluetooth
>     realtek videobuf2_vmalloc pmt_telemetry typec_ucsi snd_pcm spi_nor
>     intel_cstate vfat mei_me intel_rapl_common intel_lpss_pci
>     mdio_devres videobuf2_memops pmt_class snd_timer videobuf2_common
>     i2c_i801 intel_lpss intel_uncore wmi_bmof asus_nb_wmi pcspkr typec
>     ecdh_generic cfg80211 libphy mtd fat processor_thermal_rfim mc mei
>     idma64 i2c_smbus snd thunderbolt crc16 roles i2c_hid_acpi soundcore
>     intel_vsec processor_thermal_mbox igen6_edac i2c_hid int3403_thermal
>     int340x_thermal_zone int3400_thermal acpi_thermal_rel acpi_tad
>     mousedev acpi_pad joydev mac_hid pkcs8_key_parser dm_multipath
>     i2c_dev crypto_user fuse loop ip_tables x_tables btrfs
>     blake2b_generic libcrc32c crc32c_generic xor raid6_pq dm_crypt cbc
>     encrypted_keys trusted tee asn1_encoder hid_asus asus_wmi
>     ledtrig_audio sparse_keymap rfkill platform_profile usbhid i915
>     crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni
>     [=C2=A0 138.739592]=C2=A0 polyval_generic gf128mul serio_raw
>     ghash_clmulni_intel drm_buddy dm_mod sha512_ssse3 intel_gtt atkbd
>     ttm sdhci_pci vivaldi_fmap aesni_intel libps2 i2c_algo_bit cqhci
>     nvme sdhci crypto_simd drm_display_helper nvme_core xhci_pci cryptd
>     spi_intel_pci mmc_core xhci_pci_renesas nvme_common spi_intel cec
>     video i8042 serio wmi
>     [=C2=A0 138.739610] CPU: 6 PID: 3845 Comm: pool-/usr/lib/b Tainted: G
>     S=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.6.0-1-mainline #1
>     a243c5e3c83e72fc2b2243b5ea465e514d6c24c1
>     [=C2=A0 138.739614] Hardware name: ASUSTeK COMPUTER INC. ROG Zephyrus=
 M16
>     GU603ZW_GU603ZW/GU603ZW, BIOS GU603ZW.311 12/22/2022
>     [=C2=A0 138.739615] RIP: 0010:tb_path_activate+0x10f/0x480 [thunderbo=
lt]
>     [=C2=A0 138.739637] Code: 01 00 00 48 85 ed 0f 84 d7 00 00 00 48 81 c=
7 c0
>     00 00 00 e8 93 24 7b f8 48 89 ea 48 c7 c7 20 95 db c0 48 89 c6 e8 f1
>     78 f4 f7 <0f> 0b 48 8b 44 24 08 65 48 2b 04 25 28 00 00 00 0f 85 54
>     03 00 00
>     [=C2=A0 138.739639] RSP: 0018:ffffc90005937d30 EFLAGS: 00010282
>     [=C2=A0 138.739641] RAX: 0000000000000000 RBX: 00000000ffffff95 RCX:
>     0000000000000027
>     [=C2=A0 138.739642] RDX: ffff88886b3a1708 RSI: 0000000000000001 RDI:
>     ffff88886b3a1700
>     [=C2=A0 138.739644] RBP: ffff88810310edc0 R08: 0000000000000000 R09:
>     ffffc90005937bb8
>     [=C2=A0 138.739644] R10: 0000000000000003 R11: ffff88888b7aac28 R12:
>     0000000000000028
>     [=C2=A0 138.739645] R13: ffff88813ebc9100 R14: ffff888103fe5800 R15:
>     ffff8881701d8fe0
>     [=C2=A0 138.739647] FS:=C2=A0 00007fd6231fe6c0(0000) GS:ffff88886b380=
000(0000)
>     knlGS:0000000000000000
>     [=C2=A0 138.739648] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 00000000800=
50033
>     [=C2=A0 138.739650] CR2: 000055d0bbfe6610 CR3: 0000000141210000 CR4:
>     0000000000f50ee0
>     [=C2=A0 138.739651] PKRU: 55555554
>     [=C2=A0 138.739652] Call Trace:
>     [=C2=A0 138.739654]=C2=A0 <TASK>
>     [=C2=A0 138.739655]=C2=A0 ? tb_path_activate+0x10f/0x480 [thunderbolt
>     c85481cfb2695e02347db36bb54248816593d261]
>     [=C2=A0 138.739676]=C2=A0 ? __warn+0x81/0x130
>     [=C2=A0 138.739681]=C2=A0 ? tb_path_activate+0x10f/0x480 [thunderbolt
>     c85481cfb2695e02347db36bb54248816593d261]
>     [=C2=A0 138.739702]=C2=A0 ? report_bug+0x171/0x1a0
>     [=C2=A0 138.739706]=C2=A0 ? console_unlock+0x78/0x120
>     [=C2=A0 138.739710]=C2=A0 ? handle_bug+0x3c/0x80
>     [=C2=A0 138.739718]=C2=A0 ? exc_invalid_op+0x17/0x70
>     [=C2=A0 138.739721]=C2=A0 ? asm_exc_invalid_op+0x1a/0x20
>     [=C2=A0 138.739725]=C2=A0 ? tb_path_activate+0x10f/0x480 [thunderbolt
>     c85481cfb2695e02347db36bb54248816593d261]
>     [=C2=A0 138.739746]=C2=A0 tb_tunnel_restart+0xb3/0x220 [thunderbolt
>     c85481cfb2695e02347db36bb54248816593d261]
>     [=C2=A0 138.739767]=C2=A0 tb_tunnel_pci+0x1b2/0x480 [thunderbolt
>     c85481cfb2695e02347db36bb54248816593d261]
>     [=C2=A0 138.739787]=C2=A0 authorized_store+0x289/0x2d0 [thunderbolt
>     c85481cfb2695e02347db36bb54248816593d261]
>     [=C2=A0 138.739806]=C2=A0 kernfs_fop_write_iter+0x133/0x1d0
>     [=C2=A0 138.739810]=C2=A0 vfs_write+0x23b/0x420
>     [=C2=A0 138.739815]=C2=A0 ksys_write+0x6f/0xf0
>     [=C2=A0 138.739818]=C2=A0 do_syscall_64+0x5d/0x90
>     [=C2=A0 138.739820]=C2=A0 ? syscall_exit_to_user_mode+0x2b/0x40
>     [=C2=A0 138.739824]=C2=A0 ? do_syscall_64+0x6c/0x90
>     [=C2=A0 138.739826]=C2=A0 ? do_syscall_64+0x6c/0x90
>     [=C2=A0 138.739828]=C2=A0 entry_SYSCALL_64_after_hwframe+0x6e/0xd8
>     [=C2=A0 138.739830] RIP: 0033:0x7fd628ec406f
>     [=C2=A0 138.739876] Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 1=
9 4d
>     f8 ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00
>     00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 6c 4d
>     f8 ff 48
>     [=C2=A0 138.739877] RSP: 002b:00007fd6231fdc90 EFLAGS: 00000293 ORIG_=
RAX:
>     0000000000000001
>     [=C2=A0 138.739880] RAX: ffffffffffffffda RBX: 00007fd614008c40 RCX:
>     00007fd628ec406f
>     [=C2=A0 138.739881] RDX: 0000000000000001 RSI: 00007fd6231fdd30 RDI:
>     000000000000000a
>     [=C2=A0 138.739882] RBP: 00007fd6231fdd70 R08: 0000000000000000 R09:
>     00007fd6231fdba0
>     [=C2=A0 138.739883] R10: 0000000000000000 R11: 0000000000000293 R12:
>     00007fd614002e20
>     [=C2=A0 138.739884] R13: 000000000000000a R14: 0000000000000000 R15:
>     00007fd6231fdd28
>     [=C2=A0 138.739886]=C2=A0 </TASK>
>     [=C2=A0 138.739887] ---[ end trace 0000000000000000 ]---
>     [=C2=A0 138.739888] thunderbolt 0000:00:0d.2: 0:8 <-> 1:3 (PCI):
>     activation failed
>     [=C2=A0 138.740586] thunderbolt 0000:00:0d.2: 1:3: PCIe tunnel activa=
tion
>     failed, aborting
>     [=C2=A0 138.740697] thunderbolt 0-0:1.1: retimer disconnected
>     [=C2=A0 138.740791] thunderbolt 0-1: device disconnected
>=20
> the device is then rediscovered and the kernel oops reoccurs ad
> infinitum (device remaining non-functional the whole time).
>=20
> If the device was plugged in during system boot, no such error occurs
> and the device is fully functional.
> If the device is then unplugged/replugged, the above kernel oops appears
> and the device remains unusable.
>=20
> I have also tried enrolling the device prior to connect as well as
> enabling auto-authorization via udev rules as described in the "USB4 and
> Thunderbolt" admin guide, both to no avail.
>=20
> The system under test is an Asus ROG Zephyrus M16 GU603ZW (Intel
> i9-12900H [Alder Lake]) loaded with Arch Linux (tested under
> 6.5.2-arch1-1, 6.5.3-arch1-1, and 6.6.0-1-mainline [vanilla]).
>=20
> The external enclosure is fully functional with the same kernel on a
> system with a TB3-only port (Intel i7-8750H [Coffee Lake] + Intel=C2=AE H=
M370
> chipset), including hotplugging support.
> The external enclosure is also fully functional on the test system
> described above booted into Windows 11 x64.
>=20
> The bug was first reported to the Arch Linux forums with no response
> (https://bbs.archlinux.org/viewtopic.php?id=3D288731), more details can be
> found there too.
>=20

Do you have this issue on kernel v6.1?

--=20
An old man doll... just what I always wanted! - Clara

--Pk2mZ6L2ssJqFiIL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZUC3IwAKCRD2uYlJVVFO
o5yqAP9xseUMLlmnTg4yrBEnYnRMUVlg5vPfEVs2OXSU0Xga/wD+Pk/7dPaCaI6T
TvNm+LS743yEHjzFR1XYbs4exrOsJgE=
=I1zx
-----END PGP SIGNATURE-----

--Pk2mZ6L2ssJqFiIL--
