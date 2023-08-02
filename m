Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5982A76CB7C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 13:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbjHBLIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 07:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbjHBLI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:08:27 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B94C1FCF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 04:08:26 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2680ccc1d52so3833489a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 04:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690974505; x=1691579305;
        h=content-transfer-encoding:subject:cc:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HN4yL9Ko67hBibaQtI8bqdyy0f3U3Ny1uhYF2yLwlQ8=;
        b=GQZyJfbgsRz9nNrAGCts8b4/2MOEMy3S9AeJuWzhkuKlD9iW3mhZMPYEysDmxjapEg
         56oHNng4Y3ImRd8B/13g1+W0IDzlmS1f/mlsMtmb1neEcJj0TJ4TcDEvVspQp4ZKas9R
         HYsqNOVpO/LolK8ERdlP6mjW3JGFDuOIT9T59H+NhgGs2Fa99K3QAkC5a5ekk6znN+az
         MLRS5K4gpJJvrrWya2h+76sd22lbwhID63tKbswPacEhYv4Q0J0Ds+NNv4viKBVbdbL2
         ohG/szm18hERu6cn2tGJ+ZeTE4b2oXuTfNJOC+w+qPZY9gkebpS3v8Da57J2E4v+J+QS
         ttdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690974505; x=1691579305;
        h=content-transfer-encoding:subject:cc:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HN4yL9Ko67hBibaQtI8bqdyy0f3U3Ny1uhYF2yLwlQ8=;
        b=Dy3BTiBTCnMRlUgYfar5BM7+VCmmdjkHbcC0r6cUKfXYLW2UTGFedPsKR6qPTsJ9hF
         YLAxYQxKgIwT5jppZAnZJhvhElkawSZK0iPOMlmIC5EiCnvbtEMp6f3yxkRnTDpuTTmP
         /SAFObVRKxsnC9FKo8KlbZtOCc61thJmnlyQrnD3uJCyoTV7Q3NncNYDPYhU+yx2ehSb
         YNeMEaC7a/c7ZDtSU/eeAxJMHkPTSOaSoK8iwgFEG3va2WlUaqbDu3XE1fpG/pMua1xR
         NVP5qa1+mgJUxGB+a+KG02xRoGg9oxt7XD8TXfB69BQmd2vIj/E7wIkukI6K8Uz9EADY
         mw4g==
X-Gm-Message-State: ABy/qLauTTrd/R0UGTU9ECJkBP9ng1uESuWM/mwuancK/edOUIh8nvFm
        dcrIfheKNkm3Dn86/SiWyhK7LDTeYZU=
X-Google-Smtp-Source: APBJJlFuxaM/ap7LahQ7bEdeqW1QLwRIaT165kyavi8a1q4dCF1PT3erL/L51C3YlMQ95f05ijztSQ==
X-Received: by 2002:a17:90b:3556:b0:268:25b7:1922 with SMTP id lt22-20020a17090b355600b0026825b71922mr13151147pjb.5.1690974505514;
        Wed, 02 Aug 2023 04:08:25 -0700 (PDT)
Received: from [192.168.0.105] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id p5-20020a17090a284500b00262fc3d911esm997808pjf.28.2023.08.02.04.08.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 04:08:25 -0700 (PDT)
Message-ID: <428d8fe9-8c19-ddba-b36e-7db5524e8d04@gmail.com>
Date:   Wed, 2 Aug 2023 18:08:20 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Alistair Popple <apopple@nvidia.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco <rodomar705@protonmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Regressions <regressions@lists.linux.dev>
Subject: Fwd: Kernel memory management bug at mm/migrate.c:662 when flushing
 caches
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> I hit this kernel bug on the latest 6.3.9 kernel after executing this s=
cript to cleanup hugepages from the kernel before booting up a Windows 11=
 VM with QEMU (otherwise I don't have enough contiguous memory to allocat=
e the pages to the VM)
>=20
> snip
> if [[ $VM_ACTION =3D=3D 'prepare' ]];
> then
>     sync
>     echo 3 > /proc/sys/vm/drop_caches
>     echo 1 > /proc/sys/vm/compact_memory
> endsnip
>=20
> Attached is the full QEMU script that I used. I do use ZFS as a root fi=
lesystem, as you can see from the loaded modules.
>=20
> Ever seen something similar? On first bootup this is fine, it works fin=
e. Any subsequent call cause to kill the script with the error below.
>=20
> [ 2682.534320] bash (54689): drop_caches: 3
> [ 2682.624207] ------------[ cut here ]------------
> [ 2682.624211] kernel BUG at mm/migrate.c:662!
> [ 2682.624219] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> [ 2682.624223] CPU: 2 PID: 54689 Comm: bash Tainted: P           OE    =
  6.3.9-arch1-1 #1 124dc55df4f5272ccb409f39ef4872fc2b3376a2
> [ 2682.624226] Hardware name: System manufacturer System Product Name/R=
OG STRIX B450-F GAMING, BIOS 5102 05/31/2023
> [ 2682.624228] RIP: 0010:migrate_folio_extra+0x6c/0x70
> [ 2682.624234] Code: de 48 89 ef e8 35 e2 ff ff 5b 44 89 e0 5d 41 5c 41=
 5d e9 e7 6d 9d 00 e8 22 e2 ff ff 44 89 e0 5b 5d 41 5c 41 5d e9 d4 6d 9d =
00 <0f> 0b 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f
> [ 2682.624236] RSP: 0018:ffffb4685b5038f8 EFLAGS: 00010282
> [ 2682.624238] RAX: 02ffff0000008025 RBX: ffffd9f684f02740 RCX: 0000000=
000000002
> [ 2682.624240] RDX: ffffd9f684f02740 RSI: ffffd9f68d958dc0 RDI: ffff99d=
8d1cfe728
> [ 2682.624241] RBP: ffff99d8d1cfe728 R08: 0000000000000000 R09: 0000000=
000000000
> [ 2682.624242] R10: ffffd9f68d958dc8 R11: 0000000004020000 R12: ffffd9f=
68d958dc0
> [ 2682.624243] R13: 0000000000000002 R14: ffffd9f684f02740 R15: ffffb46=
85b5039b8
> [ 2682.624245] FS:  00007f78b8182740(0000) GS:ffff99de9ea80000(0000) kn=
lGS:0000000000000000
> [ 2682.624246] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2682.624248] CR2: 00007fe9a0001960 CR3: 000000011e406000 CR4: 0000000=
0003506e0
> [ 2682.624249] Call Trace:
> [ 2682.624251]  <TASK>
> [ 2682.624253]  ? die+0x36/0x90
> [ 2682.624258]  ? do_trap+0xda/0x100
> [ 2682.624261]  ? migrate_folio_extra+0x6c/0x70
> [ 2682.624263]  ? do_error_trap+0x6a/0x90
> [ 2682.624266]  ? migrate_folio_extra+0x6c/0x70
> [ 2682.624268]  ? exc_invalid_op+0x50/0x70
> [ 2682.624271]  ? migrate_folio_extra+0x6c/0x70
> [ 2682.624273]  ? asm_exc_invalid_op+0x1a/0x20
> [ 2682.624278]  ? migrate_folio_extra+0x6c/0x70
> [ 2682.624280]  move_to_new_folio+0x136/0x150
> [ 2682.624283]  migrate_pages_batch+0x913/0xd30
> [ 2682.624285]  ? __pfx_compaction_free+0x10/0x10
> [ 2682.624289]  ? __pfx_remove_migration_pte+0x10/0x10
> [ 2682.624292]  migrate_pages+0xc61/0xde0
> [ 2682.624295]  ? __pfx_compaction_alloc+0x10/0x10
> [ 2682.624296]  ? __pfx_compaction_free+0x10/0x10
> [ 2682.624300]  compact_zone+0x865/0xda0
> [ 2682.624303]  compact_node+0x88/0xc0
> [ 2682.624306]  sysctl_compaction_handler+0x46/0x80
> [ 2682.624308]  proc_sys_call_handler+0x1bd/0x2e0
> [ 2682.624312]  vfs_write+0x239/0x3f0
> [ 2682.624316]  ksys_write+0x6f/0xf0
> [ 2682.624317]  do_syscall_64+0x60/0x90
> [ 2682.624322]  ? syscall_exit_to_user_mode+0x1b/0x40
> [ 2682.624324]  ? do_syscall_64+0x6c/0x90
> [ 2682.624327]  ? syscall_exit_to_user_mode+0x1b/0x40
> [ 2682.624329]  ? exc_page_fault+0x7c/0x180
> [ 2682.624330]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [ 2682.624333] RIP: 0033:0x7f78b82f5bc4
> [ 2682.624355] Code: 15 99 11 0e 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff=
 eb b7 0f 1f 00 f3 0f 1e fa 80 3d 3d 99 0e 00 00 74 13 b8 01 00 00 00 0f =
05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 48 83 ec 28 48 89 54 24 18 48
> [ 2682.624356] RSP: 002b:00007ffd9d25ed18 EFLAGS: 00000202 ORIG_RAX: 00=
00000000000001
> [ 2682.624358] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f7=
8b82f5bc4
> [ 2682.624359] RDX: 0000000000000002 RSI: 000055c97c5f05c0 RDI: 0000000=
000000001
> [ 2682.624360] RBP: 000055c97c5f05c0 R08: 0000000000000073 R09: 0000000=
000000001
> [ 2682.624362] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000=
000000002
> [ 2682.624363] R13: 00007f78b83d86a0 R14: 0000000000000002 R15: 00007f7=
8b83d3ca0
> [ 2682.624365]  </TASK>
> [ 2682.624366] Modules linked in: vhost_net vhost vhost_iotlb tap tun s=
nd_seq_dummy snd_hrtimer snd_seq xt_CHECKSUM xt_MASQUERADE xt_conntrack i=
pt_REJECT nf_reject_ipv4 xt_tcpudp ip6table_mangle ip6table_nat ip6table_=
filter ip6_tables iptable_mangle iptable_nat nf_nat nf_conntrack nf_defra=
g_ipv6 nf_defrag_ipv4 libcrc32c iptable_filter bridge stp llc intel_rapl_=
msr intel_rapl_common edac_mce_amd kvm_amd snd_hda_codec_realtek snd_hda_=
codec_generic kvm snd_hda_codec_hdmi snd_usb_audio btusb btrtl snd_hda_in=
tel btbcm snd_intel_dspcfg crct10dif_pclmul btintel crc32_pclmul snd_inte=
l_sdw_acpi btmtk vfat polyval_clmulni snd_usbmidi_lib polyval_generic fat=
 snd_hda_codec ext4 gf128mul snd_rawmidi eeepc_wmi bluetooth ghash_clmuln=
i_intel snd_hda_core sha512_ssse3 asus_wmi snd_seq_device aesni_intel mc =
ledtrig_audio snd_hwdep crc32c_generic crypto_simd snd_pcm sparse_keymap =
crc32c_intel igb ecdh_generic platform_profile sp5100_tco cryptd snd_time=
r mbcache rapl rfkill wmi_bmof pcspkr dca asus_wmi_sensors snd i2c_piix4 =
zenpower(OE) ccp
> [ 2682.624417]  jbd2 crc16 soundcore gpio_amdpt gpio_generic mousedev a=
cpi_cpufreq joydev mac_hid dm_multipath i2c_dev crypto_user loop fuse dm_=
mod bpf_preload ip_tables x_tables usbhid zfs(POE) zunicode(POE) zzstd(OE=
) zlua(OE) zavl(POE) icp(POE) zcommon(POE) znvpair(POE) spl(OE) nouveau n=
vme nvme_core xhci_pci nvme_common xhci_pci_renesas vfio_pci vfio_pci_cor=
e irqbypass vfio_iommu_type1 vfio iommufd amdgpu i2c_algo_bit drm_ttm_hel=
per ttm mxm_wmi video wmi drm_buddy gpu_sched drm_display_helper cec
> [ 2682.624456] ---[ end trace 0000000000000000 ]---
> [ 2682.624457] RIP: 0010:migrate_folio_extra+0x6c/0x70
> [ 2682.624461] Code: de 48 89 ef e8 35 e2 ff ff 5b 44 89 e0 5d 41 5c 41=
 5d e9 e7 6d 9d 00 e8 22 e2 ff ff 44 89 e0 5b 5d 41 5c 41 5d e9 d4 6d 9d =
00 <0f> 0b 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f
> [ 2682.624463] RSP: 0018:ffffb4685b5038f8 EFLAGS: 00010282
> [ 2682.624465] RAX: 02ffff0000008025 RBX: ffffd9f684f02740 RCX: 0000000=
000000002
> [ 2682.624466] RDX: ffffd9f684f02740 RSI: ffffd9f68d958dc0 RDI: ffff99d=
8d1cfe728
> [ 2682.624467] RBP: ffff99d8d1cfe728 R08: 0000000000000000 R09: 0000000=
000000000
> [ 2682.624469] R10: ffffd9f68d958dc8 R11: 0000000004020000 R12: ffffd9f=
68d958dc0
> [ 2682.624470] R13: 0000000000000002 R14: ffffd9f684f02740 R15: ffffb46=
85b5039b8
> [ 2682.624472] FS:  00007f78b8182740(0000) GS:ffff99de9ea80000(0000) kn=
lGS:0000000000000000
> [ 2682.624473] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2682.624475] CR2: 00007fe9a0001960 CR3: 000000011e406000 CR4: 0000000=
0003506e0

See Bugzilla for the full thread and attached QEMU hook script to
reproduce this regression.

Anyway, I'm adding it to regzbot:

#regzbot introduced: v6.2..v6.3 https://bugzilla.kernel.org/show_bug.cgi?=
id=3D217747
#regzbot title: kernel memory bug when cleaning hugepages before QEMU boo=
t

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D217747

--=20
An old man doll... just what I always wanted! - Clara
