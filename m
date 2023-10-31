Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40E47DCB47
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 12:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbjJaLBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 07:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjJaLBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 07:01:02 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E948EA6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 04:00:59 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-694ed847889so4837024b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 04:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698750059; x=1699354859; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=13H7fqXnlgBQLewExM3ukD97upHrkxuZmW4DsfF521I=;
        b=UPRE4nd5cARtbPC0VlTMZkqUeqT0IQG5BtPrxqORVjaJlRAfcclyHXu/dpqgxhI/vH
         csYDAFBdqYSf8aETfHenooHAqBxo+E5ojAer9bZg9OdkzL5LW1NHciVfH0xNN7LYZmB0
         Pi3aWtcHO8+MF7SgHXkNE6IDj/OJ8Rtnc9Z6BvSyrtLq5Nq/O/tzW0kwoDwlArgFg8i7
         N7eodT9UuZxBBSaDkhtjMdlEsQ2MyabX6jlzV6fSXDBsFC7a6OFPsMKWQhkxl7hO9N6e
         Xmyrof68EGFo5qo8MSdtMLXxpS+P9tJvU403uvb8BJmhzQ1GIAKfLN3dhlpl8Q/GZlVY
         +h8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698750059; x=1699354859;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=13H7fqXnlgBQLewExM3ukD97upHrkxuZmW4DsfF521I=;
        b=ZHvVSJ0zMUmsXTQEewAt29+zLzj+EoetEreLvXBbhS4EiqQ1sZXnpqeU2/DB+L5jxs
         I1BL7nidfoEswb4zkDg19tr3dSVElF2RVX3Aa6Gqpq7a6HtisexAFYkL3NuC5qZ4eoS3
         JNyKuGB/yEVA7eDobh+xWx7W8i8VbcFx14IUAWrUMIRSX0608gqDBW27Aety72T981aR
         DPj6wyvwzrpZqku6WqJ7iV7Li++tZUbV9YWI8byCcDb1nKYZ9SSe4F/7GrZ8ajvqNgEM
         05zhBiUgEh4JEnnemz/G8jAB4QuRlVY0HL3XJ/DRiJGrdUkRtEaOkIERlf39D0jx/4gs
         GuJA==
X-Gm-Message-State: AOJu0Yx5koxbtnhiUGTVhhqv4+rM3Egaf8YtacbH6A8j22zpxoTUyIV4
        rrD7EcKo6lPrQz2TMNSfoaoM2Dk0N/c=
X-Google-Smtp-Source: AGHT+IH6lKCArDy/I+Rv5PfGnSBwayIKLcAqA9sMe3QMeChKs3A3kdIp+SR51ufcZTk5ORX96gTzDg==
X-Received: by 2002:a05:6a00:cd1:b0:6c0:1096:e7d3 with SMTP id b17-20020a056a000cd100b006c01096e7d3mr10789417pfv.18.1698750059046;
        Tue, 31 Oct 2023 04:00:59 -0700 (PDT)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id du10-20020a056a002b4a00b00688435a9915sm1008426pfb.189.2023.10.31.04.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 04:00:58 -0700 (PDT)
Message-ID: <d6fc2819-51d7-43b6-b813-1e955fad3c79@gmail.com>
Date:   Tue, 31 Oct 2023 18:00:54 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Cc:     Michal Hocko <mhocko@suse.com>, Greg Thelen <gthelen@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgzones@googlemail.com
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: Panic related to handle_mm_fault and asm_exc_invalid_op
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a bug report on Bugzilla [1]. Quoting from it:

> uname: Linux DebianHome 6.5.9-dhome+ #1 SMP PREEMPT_DYNAMIC Wed Oct 25 =
19:12:36 CEST 2023 x86_64 GNU/Linux
> cmdline: BOOT_IMAGE=3D/vmlinuz-6.5.9-dhome+ root=3D/dev/mapper/DebianHo=
me--vg-root ro slab_nomerge slub_debug=3DZF init_on_alloc=3D1 init_on_fre=
e=3D1 page_alloc.shuffle=3D1 pti=3Don vsyscall=3Dnone randomize_kstack_of=
fset=3Don lockdown=3Dconfidentiality quiet
>=20
> While starting firefox within KDE on Debian sid the system crashed.
>=20
>=20
> pstore snippets:
>=20
>=20
> Panic#1 Part1
> <4>[   98.426568] RIP: 0010:handle_mm_fault+0x10f3/0x1260
> <4>[   98.426570] Code: 00 00 00 66 90 eb 96 f3 0f 1e fa be 01 00 00 00=
 48 89 ea 4c 89 c1 e8 fc 82 f6 ff eb 80 0f 0b 41 bc 40 00 00 00 e9 ed fe =
ff ff <0f> 0b 41 8b 87 30 10 00 00 e9 ac ef ff ff 0f 0b 41 8b 87 30 10 00=

> <4>[   98.426571] RSP: 0000:ffffa99905543dd8 EFLAGS: 00010286
> <4>[   98.426572] RAX: 0000000000000181 RBX: 0000000000000001 RCX: ffff=
908698d10040
> <4>[   98.426574] RDX: 0000000000000354 RSI: 00007f586c38d980 RDI: ffff=
908cf1c0ddb8
> <4>[   98.426575] RBP: ffffa99905543f58 R08: 00007f586c38d980 R09: ffff=
90843fed9900
> <4>[   98.426576] R10: 0000000000000000 R11: ffff908cf1c0ddb8 R12: 0000=
000000000000
> <4>[   98.426577] R13: ffff908cf1c0ddb8 R14: 0000000000000354 R15: ffff=
908d86d70040
> <4>[   98.426580]  ? srso_alias_return_thunk+0x5/0x7f
> <4>[   98.426583]  ? srso_alias_return_thunk+0x5/0x7f
> <4>[   98.426585]  ? lock_mm_and_find_vma+0xbc/0x200
> <4>[   98.426587]  do_user_addr_fault+0x327/0x740
> <4>[   98.426590]  exc_page_fault+0x76/0x1a0
> <4>[   98.426592]  asm_exc_page_fault+0x26/0x30
> <4>[   98.426593] RIP: 0033:0x7f586c38d980
> <4>[   98.426594] Code: Unable to access opcode bytes at 0x7f586c38d956=
=2E
> <4>[   98.426595] RSP: 002b:000072d43f53cec8 EFLAGS: 00010206
> <4>[   98.426596] RAX: 0000000000000000 RBX: 000072d43f53dcdc RCX: 0000=
7564709051b8
> <4>[   98.426597] RDX: 0000000000000000 RSI: 00007f586c5412a0 RDI: 0000=
756470905028
> <4>[   98.426598] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000=
731c1f733480
> <4>[   98.426599] R10: 00000000ffffffff R11: 0000000000000246 R12: ffff=
ffffffffff80
> <4>[   98.426600] R13: 0000000000000000 R14: 00007ffc95ca2720 R15: 0000=
72d43ed3d000
> <4>[   98.426601]  </TASK>
> <0>[   98.426757] Kernel Offset: 0xb800000 from 0xffffffff81000000 (rel=
ocation range: 0xffffffff80000000-0xffffffffbfffffff)
>=20
>=20
> Panic#1 Part2
> <4>[   98.426518]  ? handle_bug+0x42/0x90
> <4>[   98.426520]  ? exc_invalid_op+0x1a/0x60
> <4>[   98.426522]  ? asm_exc_invalid_op+0x1a/0x20
> <4>[   98.426524]  ? handle_mm_fault+0x10f3/0x1260
> <4>[   98.426525]  ? srso_alias_return_thunk+0x5/0x7f
> <4>[   98.426528]  ? srso_alias_return_thunk+0x5/0x7f
> <4>[   98.426529]  ? lock_mm_and_find_vma+0xbc/0x200
> <4>[   98.426530]  do_user_addr_fault+0x327/0x740
> <4>[   98.426533]  exc_page_fault+0x76/0x1a0
> <4>[   98.426535]  asm_exc_page_fault+0x26/0x30
> <4>[   98.426537] RIP: 0033:0x7f586c38d980
> <4>[   98.426541] Code: Unable to access opcode bytes at 0x7f586c38d956=
=2E
> <4>[   98.426541] RSP: 002b:000072d43f53cec8 EFLAGS: 00010206
> <4>[   98.426542] RAX: 0000000000000000 RBX: 000072d43f53dcdc RCX: 0000=
7564709051b8
> <4>[   98.426543] RDX: 0000000000000000 RSI: 00007f586c5412a0 RDI: 0000=
756470905028
> <4>[   98.426543] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000=
731c1f733480
> <4>[   98.426544] R10: 00000000ffffffff R11: 0000000000000246 R12: ffff=
ffffffffff80
> <4>[   98.426545] R13: 0000000000000000 R14: 00007ffc95ca2720 R15: 0000=
72d43ed3d000
> <4>[   98.426546]  </TASK>
> <0>[   98.426547] Kernel panic - not syncing: kernel: panic_on_warn set=
 ...
> <4>[   98.426549] CPU: 5 PID: 1600 Comm: pipewire-pulse Tainted: G     =
           T  6.5.9-dhome+ #1
> <4>[   98.426550] Hardware name: Gigabyte Technology Co., Ltd. B650M DS=
3H/B650M DS3H, BIOS F8a 06/07/2023
> <4>[   98.426551] Call Trace:
> <4>[   98.426553]  <TASK>
> <4>[   98.426554]  panic+0x146/0x400
> <4>[   98.426556]  ? handle_mm_fault+0x10f3/0x1260
> <4>[   98.426558]  __warn+0x21b/0x2a0
> <4>[   98.426559]  ? handle_mm_fault+0x10f3/0x1260
> <4>[   98.426561]  report_bug+0x1d5/0x290
> <4>[   98.426563]  handle_bug+0x42/0x90
> <4>[   98.426565]  exc_invalid_op+0x1a/0x60
> <4>[   98.426567]  asm_exc_invalid_op+0x1a/0x20
>=20
>=20
> Panic#1 Part3
> <4>[   98.426494] CPU: 5 PID: 1600 Comm: pipewire-pulse Tainted: G     =
           T  6.5.9-dhome+ #1
> <4>[   98.426495] Hardware name: Gigabyte Technology Co., Ltd. B650M DS=
3H/B650M DS3H, BIOS F8a 06/07/2023
> <4>[   98.426496] RIP: 0010:handle_mm_fault+0x10f3/0x1260
> <4>[   98.426498] Code: 00 00 00 66 90 eb 96 f3 0f 1e fa be 01 00 00 00=
 48 89 ea 4c 89 c1 e8 fc 82 f6 ff eb 80 0f 0b 41 bc 40 00 00 00 e9 ed fe =
ff ff <0f> 0b 41 8b 87 30 10 00 00 e9 ac ef ff ff 0f 0b 41 8b 87 30 10 00=

> <4>[   98.426500] RSP: 0000:ffffa99905543dd8 EFLAGS: 00010286
> <4>[   98.426501] RAX: 0000000000000181 RBX: 0000000000000001 RCX: ffff=
908698d10040
> <4>[   98.426502] RDX: 0000000000000354 RSI: 00007f586c38d980 RDI: ffff=
908cf1c0ddb8
> <4>[   98.426502] RBP: ffffa99905543f58 R08: 00007f586c38d980 R09: ffff=
90843fed9900
> <4>[   98.426503] R10: 0000000000000000 R11: ffff908cf1c0ddb8 R12: 0000=
000000000000
> <4>[   98.426504] R13: ffff908cf1c0ddb8 R14: 0000000000000354 R15: ffff=
908d86d70040
> <4>[   98.426505] FS:  000072d43f53d6c0(0000) GS:ffff908e98540000(0000)=
 knlGS:0000000000000000
> <4>[   98.426506] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[   98.426507] CR2: 00007f586c38d980 CR3: 0000000a0496e000 CR4: 0000=
000000750ee0
> <4>[   98.426508] PKRU: 55555554
> <4>[   98.426508] Call Trace:
> <4>[   98.426510]  <TASK>
> <4>[   98.426512]  ? __warn+0x18a/0x2a0
> <4>[   98.426514]  ? handle_mm_fault+0x10f3/0x1260
> <4>[   98.426516]  ? report_bug+0x1d5/0x290
>=20
>=20
> Panic#1 Part4
> <4>[   98.426380] ------------[ cut here ]------------
> <4>[   98.426383] WARNING: CPU: 5 PID: 1600 at include/linux/memcontrol=
=2Eh:935 handle_mm_fault+0x10f3/0x1260
> <4>[   98.426389] Modules linked in: xt_CHECKSUM xt_MASQUERADE xt_connt=
rack snd_seq_dummy snd_hrtimer snd_seq snd_seq_device ipt_REJECT xt_tcpud=
p nft_compat nf_nat_tftp nf_conntrack_tftp nft_fib_inet nft_fib_ipv6 nft_=
fib_ipv4 nft_fib bridge stp llc nft_reject_inet nf_reject_ipv6 nf_reject_=
ipv4 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 n=
f_defrag_ipv4 rfkill nf_tables libcrc32c nfnetlink qrtr overlay binfmt_mi=
sc nls_ascii nls_cp437 vfat fat intel_rapl_msr intel_rapl_common snd_hda_=
codec_realtek edac_mce_amd snd_hda_codec_generic ledtrig_audio snd_hda_co=
dec_hdmi kvm_amd snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi snd_hd=
a_codec snd_hda_core kvm snd_hwdep irqbypass snd_pcm gigabyte_wmi wmi_bmo=
f sp5100_tco rapl ccp snd_timer pcspkr rng_core watchdog k10temp snd soun=
dcore joydev button evdev serio_raw sg parport_pc ppdev lp parport loop f=
use efi_pstore configfs zram zsmalloc efivarfs ip_tables x_tables autofs4=
 ext4 crc32c_generic mbcache crc16 jbd2 dm_crypt dm_mod amdgpu hid_generi=
c crc32_pclmul
> <4>[   98.426460]  crc32c_intel drm_buddy gpu_sched amdxcp drm_suballoc=
_helper i2c_algo_bit drm_display_helper usbhid ghash_clmulni_intel hid sd=
_mod sha512_ssse3 cec nvme sha512_generic rc_core nvme_core drm_ttm_helpe=
r xhci_pci ahci ttm t10_pi libahci r8169 xhci_hcd aesni_intel drm_kms_hel=
per realtek crc64_rocksoft_generic libata crc64_rocksoft crypto_simd mdio=
_devres crc_t10dif cryptd crct10dif_generic usbcore scsi_mod libphy crct1=
0dif_pclmul drm crc64 i2c_piix4 crct10dif_common scsi_common usb_common v=
ideo wmi

See Bugzilla for the full thread.

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D218048

--=20
An old man doll... just what I always wanted! - Clara
