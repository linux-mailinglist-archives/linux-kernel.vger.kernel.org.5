Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CC8771767
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 01:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjHFX4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 19:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjHFX4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 19:56:00 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF63E6A;
        Sun,  6 Aug 2023 16:55:58 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1bfca0ec8b9so567504fac.2;
        Sun, 06 Aug 2023 16:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691366157; x=1691970957;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxycwpVWghs+ISNhruYavL3gu63UsPevoTZd0CwoV6k=;
        b=eEpO3VDBrgBHicUQXvNxfBMwrYrXeAKrXXenulILeLBKDIUVq828gHF+Ijww5E0okb
         qehPuEwJPCkOGfNBZXKdV2AGSgJoGE6vncz9wZ+5ojHU4wRN0HU3FUdlVh1X9/YQ7omF
         J1laOK528uoOal02a+w6pJMocScRsFcLJD2IDg9JJd0Wr/WJ5hCZhE1xgQKw3TjP8Nsz
         zJj9VWVefAXAY1r5mj4n+KWUgnB5iOzK+B+ZEYETpYf9JwRs/QR+5rFyBGVnZgnT3Yrl
         qdqJpN3NXrWNizz9NJwOb/hswRXhqEjpjJNsOn1sxj5AeiOtb6EBGHP2Sd9AITKkJnV4
         Tb5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691366157; x=1691970957;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zxycwpVWghs+ISNhruYavL3gu63UsPevoTZd0CwoV6k=;
        b=ZIN/X5qXEn5JEXG2J6EjeFM8gsrGJo+SGcclAwMwT1Rag5WXhGjEWsJ9+gAjWRRAb+
         or3WXP0SSgt3aFornWRj0faQieEJ0KV2q0rnngxBid3LBZoRaMMQ8xQcMZWlhsWnNlvy
         peJ/ttAYg5kuR0e9svpBLskUjwUVRV05e6uTkO3XM8UR7xZkmHcjctT2aGpk59qE9DAq
         OIbX6JHdX+udppehwgMPQCgmf5CXR/Pn3e675kw/4jOMPHOSuS+QCKZmxgsoI1MzNuhg
         ZPzV5spvKxAwHhHm7A5hGSqUHbuc87oGXiS9bUgW6H6mMC6mdW1nlqvizq8eLA1hfLwV
         7KGA==
X-Gm-Message-State: AOJu0YxPhk8ATzggymWCyw200iQnTMJ0GrphTNEXE9bjCnF4qlhwBup4
        5cTD55lT9frhr+MXxgq/teSJJIoUHpo=
X-Google-Smtp-Source: AGHT+IEoGtOBwj9+s0tgOSJKuExQqv9LOmV8/UAzEEg3GKzU4pE7Vl40ENewyEQNHp3R/UGLbo9FLg==
X-Received: by 2002:a05:6870:9686:b0:1aa:f3:5b3b with SMTP id o6-20020a056870968600b001aa00f35b3bmr8260073oaq.17.1691366156731;
        Sun, 06 Aug 2023 16:55:56 -0700 (PDT)
Received: from [192.168.0.105] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id ey14-20020a056a0038ce00b006870ed427b2sm4999467pfb.94.2023.08.06.16.55.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Aug 2023 16:55:56 -0700 (PDT)
Message-ID: <c7f1bf9b-b183-bf6e-1cbb-d43f72494083@gmail.com>
Date:   Mon, 7 Aug 2023 06:55:49 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To:     Huang Rui <ray.huang@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        =?UTF-8?Q?Jannik_Gl=c3=bcckert?= <jannik.glueckert@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Power Management <linux-pm@vger.kernel.org>,
        Linux LLVM Build Support <llvm@lists.linux.dev>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: CFI violation when reading amd_pstate/status
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a bug report on Bugzilla [1]. Quoting from it:

> On kernel 6.4.7, with amd_pstate=3Dactive, with a Ryzen 7700X
> I get a Clang CFI violation when reading /sys/devices/system/cpu/amd_ps=
tate/status
>=20
> This is reproduceable with every read, I have only tried with amd_pstat=
e=3Dactive
>=20
> With the following CFI and Clang configs, Clang 16.0.6
> CONFIG_CFI_CLANG=3Dy
> CONFIG_CFI_PERMISSIVE=3Dy
> CONFIG_LTO_CLANG=3Dy
> CONFIG_LTO_CLANG_THIN=3Dy
>=20
> Below is the full call trace, let me know if you need a trace with debu=
g info.
>=20
> [ 4947.849350] CFI failure at dev_attr_show+0x24/0x60 (target: show_sta=
tus+0x0/0x70; expected type: 0x8651b1de)
> [ 4947.849358] WARNING: CPU: 2 PID: 16519 at dev_attr_show+0x24/0x60
> [ 4947.849360] Modules linked in: binfmt_misc nf_conntrack_netbios_ns n=
f_conntrack_broadcast wireguard curve25519_x86_64 libcurve25519_generic i=
p6_udp_tunnel udp_tunnel snd_seq_dummy snd_hrtimer snd_seq rfcomm joydev =
uhid xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_nat_tftp nf_con=
ntrack_tftp nft_fib_inet nft_fib_ipv6 nft_fib_ipv4 nft_fib nft_reject_ine=
t nf_reject_ipv6 nf_reject_ipv4 nft_reject nft_ct nft_chain_nat bridge 80=
21q mrp garp stp llc nf_tables ebtable_nat ebtable_broute ip6table_nat ip=
6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat nf_conntr=
ack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw iptable_secu=
rity ip_set nfnetlink ebtable_filter ebtables ip6table_filter ip6_tables =
iptable_filter ip_tables bnep vfat fat amdgpu snd_hda_codec_realtek snd_h=
da_codec_generic snd_hda_codec_hdmi snd_hda_intel mt7921e vfio_pci intel_=
rapl_msr mt7921_common intel_rapl_common mt76_connac_lib edac_mce_amd vfi=
o_pci_core mt76 vfio_iommu_type1 vfio kvm_amd iommufd iommu_v2 snd_usb_au=
dio
> [ 4947.849379]  snd_intel_dspcfg gpu_sched snd_intel_sdw_acpi mac80211 =
drm_suballoc_helper snd_usbmidi_lib i2c_algo_bit drm_ttm_helper snd_hda_c=
odec btusb ttm btrtl libarc4 btmtk snd_hda_core snd_rawmidi kvm snd_seq_d=
evice drm_display_helper btintel snd_hwdep mc btbcm irqbypass cfg80211 ce=
c snd_pcm asus_nb_wmi bluetooth eeepc_wmi snd_timer asus_wmi drm_kms_help=
er ledtrig_audio sparse_keymap snd gpio_amdpt platform_profile gpio_gener=
ic drm_buddy rfkill soundcore rapl i2c_piix4 wmi_bmof pcspkr k10temp lm92=
 nct6775_core hwmon_vid fuse loop dm_crypt crct10dif_pclmul polyval_clmul=
ni polyval_generic ghash_clmulni_intel nvme sp5100_tco ccp r8169 nvme_cor=
e nvme_common video wmi sunrpc
> [ 4947.849398] CPU: 2 PID: 16519 Comm: cat Tainted: P                  =
 6.4.7-gentoo-dist-hardened #1
> [ 4947.849399] Hardware name: ASUS System Product Name/TUF GAMING B650M=
-PLUS WIFI, BIOS 1616 05/16/2023
> [ 4947.849400] RIP: 0010:dev_attr_show+0x24/0x60
> [ 4947.849401] Code: 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 41 56=
 53 4c 8b 5e 10 4d 85 db 74 34 49 89 f6 41 ba 22 4e ae 79 45 03 53 f1 74 =
02 <0f> 0b 41 ff d3 0f 1f 00 48 89 c3 48 3d 00 10 00 00 7c 19 49 8b 76
> [ 4947.849403] RSP: 0018:ffffb33a03d9fd10 EFLAGS: 00010203
> [ 4947.849404] RAX: ffff922f11509980 RBX: ffff9230e86f43c0 RCX: 0000000=
000000000
> [ 4947.849404] RDX: ffff922f1746b000 RSI: ffffffffaee25f10 RDI: ffff922=
f0005f800
> [ 4947.849405] RBP: ffff9230e86f43e8 R08: 0000000000001000 R09: ffff922=
f1746b000
> [ 4947.849405] R10: 0000000015e419ad R11: ffffffffadda9330 R12: fffffff=
fae8aa188
> [ 4947.849406] R13: ffff9233bbcb6fc0 R14: ffffffffaee25f10 R15: ffff922=
f1746b000
> [ 4947.849407] FS:  00007eff007b4740(0000) GS:ffff923657e80000(0000) kn=
lGS:0000000000000000
> [ 4947.849407] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 4947.849408] CR2: 00007eff0099f000 CR3: 000000010a0a2000 CR4: 0000000=
000750ee0
> [ 4947.849409] PKRU: 55555554
> [ 4947.849409] Call Trace:
> [ 4947.849410]  <TASK>
> [ 4947.849411]  ? __warn+0xcf/0x1c0
> [ 4947.849414]  ? dev_attr_show+0x24/0x60
> [ 4947.849415]  ? report_cfi_failure+0x4e/0x60
> [ 4947.849417]  ? handle_cfi_failure+0x14c/0x1d0
> [ 4947.849419]  ? __cfi_show_status+0x10/0x10
> [ 4947.849420]  ? handle_bug+0x4f/0x90
> [ 4947.849421]  ? exc_invalid_op+0x1a/0x60
> [ 4947.849422]  ? asm_exc_invalid_op+0x1a/0x20
> [ 4947.849424]  ? __cfi_show_status+0x10/0x10
> [ 4947.849425]  ? dev_attr_show+0x24/0x60
> [ 4947.849426]  sysfs_kf_seq_show+0xa6/0x110
> [ 4947.849433]  seq_read_iter+0x16c/0x4b0
> [ 4947.849436]  vfs_read+0x272/0x2d0
> [ 4947.849438]  ksys_read+0x72/0xe0
> [ 4947.849439]  do_syscall_64+0x76/0xb0
> [ 4947.849440]  ? do_user_addr_fault+0x252/0x650
> [ 4947.849442]  ? exc_page_fault+0x7a/0x1b0
> [ 4947.849443]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [ 4947.849444] RIP: 0033:0x7eff008b2651
> [ 4947.849445] Code: b5 fe ff ff 48 8d 3d 66 42 0a 00 50 e8 68 1b 02 00=
 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 80 3d ad 0d 0e 00 00 74 13 31 c0 0f =
05 <48> 3d 00 f0 ff ff 77 57 c3 66 0f 1f 44 00 00 53 48 83 ec 20 48 89
> [ 4947.849446] RSP: 002b:00007ffecca23268 EFLAGS: 00000246 ORIG_RAX: 00=
00000000000000
> [ 4947.849447] RAX: ffffffffffffffda RBX: 0000000000008000 RCX: 00007ef=
f008b2651
> [ 4947.849447] RDX: 0000000000020000 RSI: 00007eff009a0000 RDI: 0000000=
000000003
> [ 4947.849448] RBP: 0000000000000003 R08: 00000000ffffffff R09: 0000000=
000000000
> [ 4947.849448] R10: 0000000000000022 R11: 0000000000000246 R12: 0000000=
000020000
> [ 4947.849449] R13: 0000000000000000 R14: 00007eff009a0000 R15: 0000000=
000020000
> [ 4947.849450]  </TASK>
> [ 4947.849450] ---[ end trace 0000000000000000 ]---

See Bugzilla for the full thread.

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D217765

--=20
An old man doll... just what I always wanted! - Clara
