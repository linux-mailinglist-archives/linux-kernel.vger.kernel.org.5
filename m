Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16937B2CF2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 09:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbjI2HTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 03:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbjI2HTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 03:19:48 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102CA199;
        Fri, 29 Sep 2023 00:19:46 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-27740ce6c76so6914095a91.0;
        Fri, 29 Sep 2023 00:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695971985; x=1696576785; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/yQogWhePVc0xd3M0EsdYeQWpzQqK9uNx5gstxkkto=;
        b=gCTZfqOvY8opdiBSoQBMXj9uNSN8xMj5+ZIopBf5ceTkvG7WbJzoMxOwNI3O9rcOaQ
         oCJUq0WQsUIlqPMpeO5c1UeY6MVmsWp237jUfTRlV9DK+qBrIAhh1sTqk+m3dlM3xA/Z
         KLxd5mPr83JFDMw9B+XeH6eL15KtBjWDaQUHMs5gV1tirVbOpbHP+GZVmW/IAdXDyEkO
         Ld4NIwQOWHOt2Ld0URlLSf3c6s0FhoADT34G2ESddm6ISf1Uy1A0C21dxmlVebDDv+Ix
         jRmq0aj/XkhB8/kX2Uvs4E2Trev9MEuwZMsgd6u/Z5Z0D2Feo/uLNvFLlLV65HFKwy1t
         bdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695971985; x=1696576785;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U/yQogWhePVc0xd3M0EsdYeQWpzQqK9uNx5gstxkkto=;
        b=pNR4UjGlKQmbbBTAnz0ETkJ+ckmnhtuJH4iBxYOnsQmawsdWAC0WrNIt0HCMqg5sCE
         cE+hAVwn8ufksJhqinBU4OWFNij2WKoNSgn47btohsuo3NFc0tRQJag4JXoRaLJmQfYA
         e6T2JOcoBArceLEP/1diOhqfBk3DftpnxbS7DYv7FcgDiLKIkDDqhwBCfhFKeLp5XA6d
         Kgnzz4zMZEHYnfkfKqTxBQu0EwNyMZadKeyu2rk2/C+YppDZCl3lXOodhTc07KqTdZvr
         w+O78q9pYJrXMH9vgMcnZPleMR0tm2K6q7SIpRNJk0S4nZ6PmCzNEWHaBqYT9/BDDEoI
         o7nw==
X-Gm-Message-State: AOJu0YykWq2Trxxx42XDE9qQHJgztUsCacxM9dBxerjdqs0XtafOy3qS
        kbbgkLW1qp4A0GQKg896oa5ll8c4UiE=
X-Google-Smtp-Source: AGHT+IF3UFKf/vyWWaSko/vCpdpuaf40RHXfsD9wScT3PQIWQHc73d1dORDwAx5QNtGZbCtqPaziCg==
X-Received: by 2002:a17:90a:9c08:b0:277:522d:11e5 with SMTP id h8-20020a17090a9c0800b00277522d11e5mr3188344pjp.2.1695971985296;
        Fri, 29 Sep 2023 00:19:45 -0700 (PDT)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id fv21-20020a17090b0e9500b002775281b9easm727668pjb.50.2023.09.29.00.19.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 00:19:44 -0700 (PDT)
Message-ID: <8461340f-c7c8-4e1e-b7fa-a0e4b9a6c2a8@gmail.com>
Date:   Fri, 29 Sep 2023 14:19:36 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Marcus Seyfarth <m.seyfarth@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux RCU <rcu@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: [6.5.5] System slowdown during compilation workload and RIP:
 lazy_rcu_shrink_scan
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

> ith Kernel 6.5.5, I've noticed a sudden system slowdown during a heavy compilation workload even though plenty of free RAM still available (only around 9 GB used out of 48 GB RAM in total). I first thought of being OOM, but as stated, plenty of free RAM was still available. The system freezed for a couple of seconds, became responsive again for some seconds but this cycle repeated itself until rebooting the system. While the compilation workload could finish (albeit slowly), the system became next to unusable for anything else.
> 
> In the logs, I've seen the following: 
> 
> [ 4394.309138] ------------[ cut here ]------------
> [ 4394.309141] ------------[ cut here ]------------
> [ 4394.309143] WARNING: CPU: 11 PID: 436221 at kernel/rcu/tree_nocb.h:124 call_rcu+0xa85/0x14e0
> [ 4394.309142] WARNING: CPU: 8 PID: 366 at kernel/rcu/tree_nocb.h:104 lazy_rcu_shrink_scan+0x311/0x340
> [ 4394.309150] Modules linked in:
> [ 4394.309151] Modules linked in:
> [ 4394.309151]  vfat
> [ 4394.309152]  vfat
> [ 4394.309153]  fat
> [ 4394.309153]  fat
> [ 4394.309155]  snd_hda_codec_realtek
> [ 4394.309155]  snd_hda_codec_realtek
> [ 4394.309156]  snd_hda_codec_generic
> [ 4394.309156]  snd_hda_codec_generic ledtrig_audio
> [ 4394.309158]  ledtrig_audio intel_rapl_msr
> [ 4394.309159]  intel_rapl_msr
> [ 4394.309160]  snd_hda_codec_hdmi
> [ 4394.309160]  snd_hda_codec_hdmi
> [ 4394.309162]  intel_rapl_common
> [ 4394.309162]  intel_rapl_common
> [ 4394.309163]  sb_edac
> [ 4394.309163]  sb_edac x86_pkg_temp_thermal
> [ 4394.309165]  x86_pkg_temp_thermal intel_powerclamp
> [ 4394.309166]  intel_powerclamp snd_hda_intel
> [ 4394.309167]  snd_hda_intel snd_intel_dspcfg
> [ 4394.309168]  snd_intel_dspcfg snd_hda_codec
> [ 4394.309170]  snd_hda_codec snd_hwdep
> [ 4394.309171]  snd_hwdep
> [ 4394.309172]  coretemp
> [ 4394.309172]  coretemp
> [ 4394.309173]  crct10dif_pclmul
> [ 4394.309173]  crct10dif_pclmul snd_hda_core
> [ 4394.309174]  snd_hda_core crc32_pclmul
> [ 4394.309175]  crc32_pclmul
> [ 4394.309177]  polyval_clmulni
> [ 4394.309177]  polyval_clmulni polyval_generic
> [ 4394.309178]  polyval_generic gf128mul
> [ 4394.309179]  gf128mul
> [ 4394.309180]  ghash_clmulni_intel
> [ 4394.309180]  ghash_clmulni_intel sha512_ssse3
> [ 4394.309181]  sha512_ssse3 snd_pcm
> [ 4394.309182]  snd_pcm
> [ 4394.309184]  sha256_ssse3
> [ 4394.309184]  sha256_ssse3
> [ 4394.309185]  sha1_ssse3
> [ 4394.309185]  sha1_ssse3
> [ 4394.309186]  aesni_intel
> [ 4394.309186]  aesni_intel
> [ 4394.309188]  snd_timer
> [ 4394.309188]  snd_timer crypto_simd
> [ 4394.309189]  crypto_simd cryptd
> [ 4394.309190]  cryptd i2c_i801
> [ 4394.309191]  i2c_i801 acpi_cpufreq
> [ 4394.309192]  acpi_cpufreq i2c_smbus
> [ 4394.309194]  i2c_smbus snd
> [ 4394.309195]  snd igb
> [ 4394.309196]  igb lpc_ich
> [ 4394.309197]  lpc_ich
> [ 4394.309198]  soundcore mei_wdt
> [ 4394.309199]  soundcore mei_wdt
> [ 4394.309200]  razerkbd(O)
> [ 4394.309201]  razerkbd(O)
> [ 4394.309201]  mousedev sch_fq_codel
> [ 4394.309202]  mousedev sch_fq_codel
> [ 4394.309203]  usbip_host usbip_core
> [ 4394.309204]  usbip_host usbip_core
> [ 4394.309206]  pkcs8_key_parser crypto_user
> [ 4394.309207]  pkcs8_key_parser crypto_user
> [ 4394.309208]  fuse loop
> [ 4394.309209]  fuse
> [ 4394.309210]  zram
> [ 4394.309210]  loop zram
> [ 4394.309211]  bpf_preload ip_tables
> [ 4394.309212]  bpf_preload
> [ 4394.309214]  x_tables
> [ 4394.309214]  ip_tables x_tables
> [ 4394.309215]  ext4
> [ 4394.309216]  ext4
> [ 4394.309216]  crc32c_generic mbcache
> [ 4394.309218]  crc32c_generic mbcache
> [ 4394.309219]  crc16
> [ 4394.309220]  crc16
> [ 4394.309220]  jbd2 usbhid
> [ 4394.309221]  jbd2 usbhid
> [ 4394.309222]  amdgpu mfd_core
> [ 4394.309223]  amdgpu
> [ 4394.309224]  drm_buddy drm_suballoc_helper
> [ 4394.309225]  mfd_core
> [ 4394.309226]  crc32c_intel
> [ 4394.309226]  drm_buddy drm_suballoc_helper
> [ 4394.309227]  video drm_ttm_helper
> [ 4394.309228]  crc32c_intel
> [ 4394.309229]  ttm i2c_algo_bit
> [ 4394.309230]  video drm_ttm_helper
> [ 4394.309231]  drm_display_helper cec
> [ 4394.309232]  ttm i2c_algo_bit
> [ 4394.309234]  xhci_pci gpu_sched
> [ 4394.309235]  drm_display_helper
> [ 4394.309236]  xhci_pci_renesas
> [ 4394.309236]  cec xhci_pci
> [ 4394.309237]  amdxcp wmi
> [ 4394.309238]  gpu_sched xhci_pci_renesas
> 
> [ 4394.309240]  amdxcp wmi
> [ 4394.309240] CPU: 8 PID: 366 Comm: kswapd0 Tainted: G           O       6.5.5-2.1-cachyos-lto #1 cc6c6175d85fa32a794326555b105a9657ffd076
> [ 4394.309244] Hardware name: LENOVO GAMING TF/X99-TF Gaming, BIOS CX99DE26 10/10/2020
> [ 4394.309242] CPU: 11 PID: 436221 Comm: cc1plus Tainted: G           O       6.5.5-2.1-cachyos-lto #1 cc6c6175d85fa32a794326555b105a9657ffd076
> [ 4394.309245] RIP: 0010:lazy_rcu_shrink_scan+0x311/0x340
> [ 4394.309246] Hardware name: LENOVO GAMING TF/X99-TF Gaming, BIOS CX99DE26 10/10/2020
> [ 4394.309248] Code: 03 00 00 75 25 4c 89 e7 e8 ac 81 87 00 f0 41 ff 8e 74 01 00 00 41 f6 86 e8 00 00 00 04 0f 85 1a fe ff ff 0f 0b e9 13 fe ff ff <0f> 0b eb d7 48 c7 c7 20 ff ec 9c e8 ff d1 86 00 31 c0 49 83 fd 01
> [ 4394.309248] RIP: 0010:call_rcu+0xa85/0x14e0
> [ 4394.309250] RSP: 0000:ffff8e82a3fdba88 EFLAGS: 00010093
> [ 4394.309251] Code: 02 00 00 00 0f 85 f0 00 00 00 f6 83 e8 00 00 00 01 74 ac 48 8b 83 80 00 00 00 48 83 38 00 0f 94 c0 89 44 24 08 e9 06 f9 ff ff <0f> 0b 0f ae e8 e9 d3 f6 ff ff 0f 0b e9 cc f6 ff ff 4c 89 ef e8 62
> 
> [ 4394.309253] RAX: 0000000000000008 RBX: 000000000000000b RCX: 0000000000000000
> [ 4394.309254] RSP: 0000:ffff8e7a8a033388 EFLAGS: 00010002
> [ 4394.309255] RDX: ffff8e84cf8b0148 RSI: 0000000000000286 RDI: ffff8e84cf8f0140
> 
> [ 4394.309257] RBP: 0000000000000001 R08: ffff8e84cf82c540 R09: 0000000000000094
> [ 4394.309258] RAX: 000000000000000b RBX: ffff8e84cf8eff40 RCX: 0000000000001388
> [ 4394.309258] R10: 0000000000000001 R11: 0000000000000000 R12: ffff8e84cf8f0140
> [ 4394.309260] RDX: 40000077ed480115 RSI: ffff8e84cf8effb8 RDI: ffff8e7db6814da8
> [ 4394.309260] R13: 0000000000000006 R14: ffff8e84cf8eff40 R15: 0000000000000202
> [ 4394.309262] FS:  0000000000000000(0000) GS:ffff8e84cf800000(0000) knlGS:0000000000000000
> [ 4394.309262] RBP: 0000000000000002 R08: 0000000000000040 R09: ffff8e7db6814d90
> [ 4394.309264] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 4394.309264] R10: 000000000000000c R11: ffff8e843519d4f0 R12: ffff8e84cf8f0148
> [ 4394.309266] CR2: 00007f86c9ef0000 CR3: 0000000163681001 CR4: 00000000001706e0
> [ 4394.309266] R13: 0000000000000002 R14: 0000000000000000 R15: ffff8e7db6814da8
> [ 4394.309268] Call Trace:
> [ 4394.309268] FS:  00007f1566065b40(0000) GS:ffff8e84cf8c0000(0000) knlGS:0000000000000000
> [ 4394.309270] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 4394.309271]  <TASK>
> [ 4394.309272] CR2: 00007f1548773000 CR3: 00000007a5401003 CR4: 00000000001706e0
> [ 4394.309274] Call Trace:
> [ 4394.309276]  <TASK>
> [ 4394.309274]  ? __warn+0x9e/0x160
> [ 4394.309278]  ? lazy_rcu_shrink_scan+0x311/0x340
> [ 4394.309278]  ? __warn+0x9e/0x160
> [ 4394.309282]  ? call_rcu+0xa85/0x14e0
> [ 4394.309281]  ? report_bug+0x147/0x180
> [ 4394.309284]  ? handle_bug+0x48/0x80
> [ 4394.309285]  ? report_bug+0x147/0x180
> [ 4394.309287]  ? exc_invalid_op+0x16/0x40
> [ 4394.309289]  ? handle_bug+0x48/0x80
> [ 4394.309290]  ? asm_exc_invalid_op+0x16/0x20
> [ 4394.309292]  ? exc_invalid_op+0x16/0x40
> [ 4394.309294]  ? lazy_rcu_shrink_scan+0x311/0x340
> [ 4394.309295]  ? asm_exc_invalid_op+0x16/0x20
> [ 4394.309297]  ? lazy_rcu_shrink_scan+0x10e/0x340
> [ 4394.309299]  shrink_slab+0x95a/0xae0
> [ 4394.309300]  ? call_rcu+0xa85/0x14e0
> [ 4394.309303]  shrink_node+0x1b48/0x29c0
> [ 4394.309303]  ? sysvec_apic_timer_interrupt+0x11/0x80
> [ 4394.309308]  kswapd+0x9fd/0x13e0
> [ 4394.309307]  xas_store+0xb7a/0x1480
> [ 4394.309311]  ? schedule+0x61a/0x1d20
> [ 4394.309313]  shadow_lru_isolate+0x103/0x1c0
> [ 4394.309314]  kthread+0x1bd/0x260
> [ 4394.309317]  ? check_move_unevictable_folios+0x4a0/0x4a0
> [ 4394.309318]  ? xas_store+0x1480/0x1480
> [ 4394.309321]  ? count_shadow_nodes+0x460/0x460
> [ 4394.309321]  ? __blk_mq_get_driver_tag+0x180/0x180
> [ 4394.309325]  ret_from_fork+0x30/0x40
> [ 4394.309324]  __list_lru_walk_one+0x10f/0x1c0
> [ 4394.309328]  ? __blk_mq_get_driver_tag+0x180/0x180
> [ 4394.309331]  ret_from_fork_asm+0x11/0x20
> [ 4394.309331]  ? count_shadow_nodes+0x460/0x460
> [ 4394.309334]  </TASK>
> [ 4394.309334]  list_lru_walk_one_irq+0x53/0x80
> [ 4394.309335] ---[ end trace 0000000000000000 ]---
> [ 4394.309338]  shrink_slab+0x95a/0xae0
> [ 4394.309341]  shrink_node+0x1b48/0x29c0
> [ 4394.309344]  ? __rmqueue_pcplist+0x2e4/0x1660
> [ 4394.309350]  do_try_to_free_pages+0x21b/0x700
> [ 4394.309355]  try_to_free_pages+0x193/0xb80
> [ 4394.309361]  __folio_alloc+0xa65/0x6e80
> [ 4394.309364]  ? __alloc_pages+0x19b/0x3580
> [ 4394.309370]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
> [ 4394.309374]  ? __pte_offset_map_lock+0x143/0x200
> [ 4394.309379]  do_pte_missing+0x647/0x2da0
> [ 4394.309385]  ? task_tick_fair+0x745/0x2880
> [ 4394.309390]  handle_mm_fault+0x97d/0xdc0
> [ 4394.309395]  do_user_addr_fault+0x66a/0x2f80
> [ 4394.309401]  exc_page_fault+0x66/0x160
> [ 4394.309405]  asm_exc_page_fault+0x22/0x30
> [ 4394.309408] RIP: 0033:0x7f1560da1c5d
> [ 4394.309425] Code: 4c 17 f0 c3 66 0f 1f 84 00 00 00 00 00 48 8b 4c 16 f8 48 8b 36 48 89 37 48 89 4c 17 f8 c3 c5 fe 6f 54 16 e0 c5 fe 6f 5c 16 c0 <c5> fe 7f 07 c5 fe 7f 4f 20 c5 fe 7f 54 17 e0 c5 fe 7f 5c 17 c0 c5
> [ 4394.309426] RSP: 002b:00007ffcbe93e318 EFLAGS: 00010246
> [ 4394.309428] RAX: 00007f1548773000 RBX: 00007f1548773000 RCX: 000000000000001f
> [ 4394.309430] RDX: 0000000000000080 RSI: 00007f155c0dc880 RDI: 00007f1548773000
> [ 4394.309431] RBP: 00007ffcbe93e370 R08: 0000000000000000 R09: 00000007f1548773
> [ 4394.309433] R10: 00007f1548773000 R11: 000000000000a795 R12: 00007f155c0dc880
> [ 4394.309434] R13: 0000000000000026 R14: 0000000000000026 R15: 0000000000000003
> [ 4394.309437]  </TASK>
> [ 4394.309438] ---[ end trace 0000000000000000 ]---

See Bugzilla for the full thread and attached full dmesg output.

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217948

-- 
An old man doll... just what I always wanted! - Clara
