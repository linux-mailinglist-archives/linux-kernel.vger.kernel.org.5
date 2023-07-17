Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC2E75637C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjGQM4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjGQM4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:56:45 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC831708
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 05:56:16 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b9338e4695so25760221fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 05:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689598574; x=1692190574;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uqpMk6isCWCQ9N6Ksf9KWNTK2Y+iYUe9TuXdNlKn0Xw=;
        b=ndxMVbLU1IxXmBuADbu9kgkY5jRsoBMGuyNM4E8BrKF9WSZDuBVfPyUW4wOjwm52Mz
         PTPq3AraQZjYR/YV9EdJwEFW0x72C5of8NMvo4CGt7IuSnuZ9ZkTMdELwcnNU15PxXtU
         0XhffDOgY3vngRXFlFx7Mk1m5CC1VAUMLslDqNtGr0TlYlYjQchDfmutDLgDaBG9fdXI
         FMgLcWI/xeXResOnVGrRjbrs62rrG7ZrAlQDpLzodjYq2vCgzs3+mgp/JnqvUw53pHDR
         Yzr+GbP6JVDPrep6rfEzYtKGIRZd3dST6G9GJA/4S2GBRNaqOVIul0sNn+z8JArElgzI
         uY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689598574; x=1692190574;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uqpMk6isCWCQ9N6Ksf9KWNTK2Y+iYUe9TuXdNlKn0Xw=;
        b=JlMY98QMM5ZSvEdqd1rG1uwz3P/esM8ijzCnUe8Ku6ZX3EAgxhuroYzBtY2gbNNCcm
         b2n61kj+bqvjAgaR3ru9FvZ2Fv4yCK2gXnbmXeNY3h/7Lgv0bc3Lp5BD80rHKH9xJHiQ
         pFpGssU2ZExnmCsQSMf4F3lj674Hty+W22oGJNelCnXnE92H1m4JGVTZjtFEi2lKKyt+
         pP1awFZGXHN4ItypABd2CIrMgTfUoICU4fSQOjSGkulyiRvyZhIRsp77z6/639gORMxP
         5y9A6WnACQua9dRxjCdwvKIZIJ6PtyUITpIHX0wEc42OffhrEAIExHI9RfqAU8HpMFm4
         oRKw==
X-Gm-Message-State: ABy/qLYM/DpNyB6kKc/PxVgF9qjJBfCWsBrvDvlSX0BsXcB94/wFDWOz
        5/UzblqF4YvMbajY5pvYQIcYDjbvSzzR+ltuo7NVmuqNCQg=
X-Google-Smtp-Source: APBJJlFuEf7gI7j0a1UEDSQPRKMd21kGmhVFin84+dTYeXsCYm5+lnET6ypkZaqxF1vjSHvW46g+sPJwGK6zDwI7xcw=
X-Received: by 2002:a2e:96d2:0:b0:2b4:7c31:ab8a with SMTP id
 d18-20020a2e96d2000000b002b47c31ab8amr8941163ljj.23.1689598574163; Mon, 17
 Jul 2023 05:56:14 -0700 (PDT)
MIME-Version: 1.0
From:   Ilkka Prusi <ilkka.prusi@gmail.com>
Date:   Mon, 17 Jul 2023 15:56:02 +0300
Message-ID: <CAJuPgPMp_B-TcBq0NWJcaL-aF4YEcJvx0ain7qVOLb-trVqrsQ@mail.gmail.com>
Subject: WARNING: at mm/gup.c:1101 __get_user_pages in 6.4.3
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

I found the following splat in kernel log. It looks to be triggered
from Chromium-based browser but I'm unsure what exactly caused it.

Kernel is 6.4.3, (gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils
for Debian) 2.40) #160 SMP PREEMPT_DYNAMIC Tue Jul 11 14:19:41 EEST
2023

CPU is:
   Model name:            AMD Ryzen 7 5700X 8-Core Processor
    CPU family:          25
    Model:               33


[519077.338025] ------------[ cut here ]------------
[519077.338031] WARNING: CPU: 10 PID: 219607 at mm/gup.c:1101
__get_user_pages+0x539/0x610
[519077.338038] Modules linked in: uinput(E) snd_seq_dummy(E)
snd_hrtimer(E) snd_seq(E) binfmt_misc(E) nls_ascii(E) nls_cp850(E)
vfat(E) fat(E) amdgpu(E) intel_rapl_msr(E) intel_rapl_common(E)
iosf_mbi(E) snd_hda_codec_realtek(E) edac_mce_amd(E)
snd_hda_codec_generic(E) kvm_amd(E) ledtrig_audio(E) video(E)
snd_hda_codec_hdmi(E) kvm(E) gpu_sched(E) snd_hda_intel(E)
drm_buddy(E) drm_suballoc_helper(E) snd_intel_dspcfg(E)
drm_display_helper(E) irqbypass(E) snd_usb_audio(E) snd_hda_codec(E)
cec(E) drm_ttm_helper(E) crct10dif_pclmul(E) snd_usbmidi_lib(E)
snd_rawmidi(E) ttm(E) crc32_pclmul(E) snd_seq_device(E)
snd_hda_core(E) input_leds(E) mc(E) ghash_clmulni_intel(E)
drm_kms_helper(E) sha512_ssse3(E) joydev(E) snd_hwdep(E) snd_pcm(E)
sha512_generic(E) syscopyarea(E) snd_timer(E) aesni_intel(E) snd(E)
sysfillrect(E) k10temp(E) crypto_simd(E) sg(E) evdev(E) sysimgblt(E)
cryptd(E) soundcore(E) ccp(E) rng_core(E) tiny_power_button(E) rapl(E)
button(E) acpi_cpufreq(E) wmi_bmof(E) nfsd(E) auth_rpcgss(E)
nfs_acl(E) lockd(E) msr(E)
[519077.338078]  grace(E) sunrpc(E) loop(E) fuse(E) configfs(E)
dm_mod(E) efi_pstore(E) dmi_sysfs(E) ip_tables(E) x_tables(E) ipv6(E)
autofs4(E) efivarfs(E) raid10(E) raid456(E) async_raid6_recov(E)
async_memcpy(E) async_pq(E) async_xor(E) xor(E) async_tx(E)
raid6_pq(E) libcrc32c(E) raid1(E) raid0(E) multipath(E) linear(E)
md_mod(E) hid_playstation(E) led_class_multicolor(E) ff_memless(E)
hid_generic(E) usbhid(E) hid(E) xhci_pci(E) xhci_hcd(E) sd_mod(E)
crc32c_intel(E) t10_pi(E) i2c_piix4(E) usbcore(E) igb(E)
i2c_algo_bit(E) usb_common(E) dca(E) crc64_rocksoft(E) crc64(E) wmi(E)
thermal(E)
[519077.338106] CPU: 10 PID: 219607 Comm: chrome_crashpad Tainted: G
         E      6.4.3-stable #160
[519077.338109] Hardware name: Gigabyte Technology Co., Ltd. X570
AORUS ELITE/X570 AORUS ELITE, BIOS F37c 05/12/2022
[519077.338111] RIP: 0010:__get_user_pages+0x539/0x610
[519077.338114] Code: 8b 84 24 80 00 00 00 48 8d 04 d0 e9 da fd ff ff
48 89 d1 48 f7 d1 48 21 c1 f7 c1 81 01 00 00 0f 85 58 fe ff ff e9 64
ff ff ff <0f> 0b e9 2d fd ff ff f6 c3 04 0f 85 54 ff ff ff 49 8b 07 48
8b 0d
[519077.338116] RSP: 0018:ffffc90016e07cc0 EFLAGS: 00010202
[519077.338118] RAX: ffff888127e7ee70 RBX: 000000000005000a RCX:
00007fff907c8fff
[519077.338119] RDX: 00007fff907c9000 RSI: 00007fa5c180d000 RDI:
ffff888100c2bb68
[519077.338121] RBP: 0000000000000000 R08: 0000000000000000 R09:
0000000000000001
[519077.338122] R10: ffff8886974aa780 R11: 0000000000000000 R12:
ffff88813ac11100
[519077.338123] R13: ffffc90016e07dd8 R14: ffff888127e7ee70 R15:
000000000005000a
[519077.338124] FS:  00007f1eea313c80(0000) GS:ffff88881ea80000(0000)
knlGS:0000000000000000
[519077.338126] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[519077.338127] CR2: 00000ed00046c030 CR3: 00000001fd22a000 CR4:
0000000000350ee0
[519077.338129] Call Trace:
[519077.338130]  <TASK>
[519077.338133]  ? __warn+0x6b/0xd0
[519077.338136]  ? __get_user_pages+0x539/0x610
[519077.338139]  ? report_bug+0x144/0x190
[519077.338142]  ? handle_bug+0x3c/0x60
[519077.338145]  ? exc_invalid_op+0x13/0x60
[519077.338148]  ? asm_exc_invalid_op+0x16/0x20
[519077.338152]  ? __get_user_pages+0x539/0x610
[519077.338155]  get_user_pages_remote+0xfd/0x340
[519077.338157]  ? mas_replace+0x2c1/0x340
[519077.338160]  __access_remote_vm+0x163/0x360
[519077.338162]  mem_rw.isra.0+0x115/0x1d0
[519077.338166]  vfs_read+0x95/0x2a0
[519077.338169]  ? __fget_files+0x8a/0xc0
[519077.338171]  ? lock_release+0x91/0x1a0
[519077.338174]  ? lock_acquire.part.0.isra.0+0x47/0x80
[519077.338176]  ? __fget_files+0xa2/0xc0
[519077.338178]  __x64_sys_pread64+0x6e/0xb0
[519077.338181]  do_syscall_64+0x3a/0x80
[519077.338183]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[519077.338186] RIP: 0033:0x7f1ee9c361a7
[519077.338188] Code: 08 89 3c 24 48 89 4c 24 18 e8 b5 f4 f8 ff 4c 8b
54 24 18 48 8b 54 24 10 41 89 c0 48 8b 74 24 08 8b 3c 24 b8 11 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 04 24 e8 05 f5 f8 ff
48 8b
[519077.338189] RSP: 002b:00007ffc7f5d4100 EFLAGS: 00000293 ORIG_RAX:
0000000000000011
[519077.338191] RAX: ffffffffffffffda RBX: 0000000000001000 RCX:
00007f1ee9c361a7
[519077.338192] RDX: 0000000000001000 RSI: 00007ffc7f5d43f0 RDI:
0000000000000007
[519077.338193] RBP: 00007ffc7f5d42a0 R08: 0000000000000000 R09:
000055b4e809ade0
[519077.338195] R10: 00007fa5c180c8a0 R11: 0000000000000293 R12:
00007fa5c180c8a0
[519077.338196] R13: 00000ed00022a100 R14: 00007ffc7f5d43f0 R15:
0000000000001000
[519077.338198]  </TASK>
[519077.338199] ---[ end trace 0000000000000000 ]---

The code decodes:
$ scripts/decode_stacktrace.sh vmlinux < ~/warn_get_user_pages
[519077.338025] ------------[ cut here ]------------
[519077.338031] WARNING: CPU: 10 PID: 219607 at mm/gup.c:1101
__get_user_pages (mm/gup.c:1101 (discriminator 1))
[519077.338038] Modules linked in: uinput(E) snd_seq_dummy(E)
snd_hrtimer(E) snd_seq(E) binfmt_misc(E) nls_ascii(E) nls_cp850(E)
vfat(E) fat(E) amdgpu(E) intel_rapl_msr(E) intel_rapl_common(E)
iosf_mbi(E) snd_hda_codec_realtek(E) edac_mce_amd(E)
snd_hda_codec_generic(E) kvm_amd(E) ledtrig_audio(E) video(E)
snd_hda_codec_hdmi(E) kvm(E) gpu_sched(E) snd_hda_intel(E)
drm_buddy(E) drm_suballoc_helper(E) snd_intel_dspcfg(E)
drm_display_helper(E) irqbypass(E) snd_usb_audio(E) snd_hda_codec(E)
cec(E) drm_ttm_helper(E) crct10dif_pclmul(E) snd_usbmidi_lib(E)
snd_rawmidi(E) ttm(E) crc32_pclmul(E) snd_seq_device(E)
snd_hda_core(E) input_leds(E) mc(E) ghash_clmulni_intel(E)
drm_kms_helper(E) sha512_ssse3(E) joydev(E) snd_hwdep(E) snd_pcm(E)
sha512_generic(E) syscopyarea(E) snd_timer(E) aesni_intel(E) snd(E)
sysfillrect(E) k10temp(E) crypto_simd(E) sg(E) evdev(E) sysimgblt(E)
cryptd(E) soundcore(E) ccp(E) rng_core(E) tiny_power_button(E) rapl(E)
button(E) acpi_cpufreq(E) wmi_bmof(E) nfsd(E) auth_rpcgss(E)
nfs_acl(E) lockd(E) msr(E)
[519077.338078]  grace(E) sunrpc(E) loop(E) fuse(E) configfs(E)
dm_mod(E) efi_pstore(E) dmi_sysfs(E) ip_tables(E) x_tables(E) ipv6(E)
autofs4(E) efivarfs(E) raid10(E) raid456(E) async_raid6_recov(E)
async_memcpy(E) async_pq(E) async_xor(E) xor(E) async_tx(E)
raid6_pq(E) libcrc32c(E) raid1(E) raid0(E) multipath(E) linear(E)
md_mod(E) hid_playstation(E) led_class_multicolor(E) ff_memless(E)
hid_generic(E) usbhid(E) hid(E) xhci_pci(E) xhci_hcd(E) sd_mod(E)
crc32c_intel(E) t10_pi(E) i2c_piix4(E) usbcore(E) igb(E)
i2c_algo_bit(E) usb_common(E) dca(E) crc64_rocksoft(E) crc64(E) wmi(E)
thermal(E)
[519077.338106] CPU: 10 PID: 219607 Comm: chrome_crashpad Tainted: G
         E      6.4.3-stable #160
[519077.338109] Hardware name: Gigabyte Technology Co., Ltd. X570
AORUS ELITE/X570 AORUS ELITE, BIOS F37c 05/12/2022
[519077.338111] RIP: 0010:__get_user_pages (mm/gup.c:1101 (discriminator 1))
[519077.338114] Code: 8b 84 24 80 00 00 00 48 8d 04 d0 e9 da fd ff ff
48 89 d1 48 f7 d1 48 21 c1 f7 c1 81 01 00 00 0f 85 58 fe ff ff e9 64
ff ff ff <0f> 0b e9 2d fd ff ff f6 c3 04 0f 85 54 ff ff ff 49 8b 07 48
8b 0d
All code
========
   0:   8b 84 24 80 00 00 00    mov    0x80(%rsp),%eax
   7:   48 8d 04 d0             lea    (%rax,%rdx,8),%rax
   b:   e9 da fd ff ff          jmp    0xfffffffffffffdea
  10:   48 89 d1                mov    %rdx,%rcx
  13:   48 f7 d1                not    %rcx
  16:   48 21 c1                and    %rax,%rcx
  19:   f7 c1 81 01 00 00       test   $0x181,%ecx
  1f:   0f 85 58 fe ff ff       jne    0xfffffffffffffe7d
  25:   e9 64 ff ff ff          jmp    0xffffffffffffff8e
  2a:*  0f 0b                   ud2             <-- trapping instruction
  2c:   e9 2d fd ff ff          jmp    0xfffffffffffffd5e
  31:   f6 c3 04                test   $0x4,%bl
  34:   0f 85 54 ff ff ff       jne    0xffffffffffffff8e
  3a:   49 8b 07                mov    (%r15),%rax
  3d:   48                      rex.W
  3e:   8b                      .byte 0x8b
  3f:   0d                      .byte 0xd

Code starting with the faulting instruction
===========================================
   0:   0f 0b                   ud2
   2:   e9 2d fd ff ff          jmp    0xfffffffffffffd34
   7:   f6 c3 04                test   $0x4,%bl
   a:   0f 85 54 ff ff ff       jne    0xffffffffffffff64
  10:   49 8b 07                mov    (%r15),%rax
  13:   48                      rex.W
  14:   8b                      .byte 0x8b
  15:   0d                      .byte 0xd
[519077.338116] RSP: 0018:ffffc90016e07cc0 EFLAGS: 00010202
[519077.338118] RAX: ffff888127e7ee70 RBX: 000000000005000a RCX:
00007fff907c8fff
[519077.338119] RDX: 00007fff907c9000 RSI: 00007fa5c180d000 RDI:
ffff888100c2bb68
[519077.338121] RBP: 0000000000000000 R08: 0000000000000000 R09:
0000000000000001
[519077.338122] R10: ffff8886974aa780 R11: 0000000000000000 R12:
ffff88813ac11100
[519077.338123] R13: ffffc90016e07dd8 R14: ffff888127e7ee70 R15:
000000000005000a
[519077.338124] FS:  00007f1eea313c80(0000) GS:ffff88881ea80000(0000)
knlGS:0000000000000000
[519077.338126] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[519077.338127] CR2: 00000ed00046c030 CR3: 00000001fd22a000 CR4:
0000000000350ee0
[519077.338129] Call Trace:
[519077.338130]  <TASK>
[519077.338133] ? __warn (kernel/panic.c:673)
[519077.338136] ? __get_user_pages (mm/gup.c:1101 (discriminator 1))
[519077.338139] ? report_bug (lib/bug.c:180 lib/bug.c:219)
[519077.338142] ? handle_bug (arch/x86/kernel/traps.c:324)
[519077.338145] ? exc_invalid_op (arch/x86/kernel/traps.c:345 (discriminator 1))
[519077.338148] ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:568)
[519077.338152] ? __get_user_pages (mm/gup.c:1101 (discriminator 1))
[519077.338155] get_user_pages_remote (mm/gup.c:1391 mm/gup.c:2238)
[519077.338157] ? mas_replace (lib/maple_tree.c:963
lib/maple_tree.c:1461 lib/maple_tree.c:1743 lib/maple_tree.c:1775)
[519077.338160] __access_remote_vm (mm/memory.c:5739)
[519077.338162] mem_rw.isra.0 (fs/proc/base.c:867)
[519077.338166] vfs_read (fs/read_write.c:468)
[519077.338169] ? __fget_files (./include/linux/rcupdate.h:805 fs/file.c:915)
[519077.338171] ? lock_release (kernel/locking/lockdep.c:5381
kernel/locking/lockdep.c:5725)
[519077.338174] ? lock_acquire.part.0.isra.0
(kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5707)
[519077.338176] ? __fget_files (fs/file.c:918)
[519077.338178] __x64_sys_pread64 (./include/linux/file.h:44
fs/read_write.c:666 fs/read_write.c:675 fs/read_write.c:672
fs/read_write.c:672)
[519077.338181] do_syscall_64 (arch/x86/entry/common.c:50
arch/x86/entry/common.c:80)
[519077.338183] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
[519077.338186] RIP: 0033:0x7f1ee9c361a7
[519077.338188] Code: 08 89 3c 24 48 89 4c 24 18 e8 b5 f4 f8 ff 4c 8b
54 24 18 48 8b 54 24 10 41 89 c0 48 8b 74 24 08 8b 3c 24 b8 11 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 04 24 e8 05 f5 f8 ff
48 8b
All code
========
   0:   08 89 3c 24 48 89       or     %cl,-0x76b7dbc4(%rcx)
   6:   4c 24 18                rex.WR and $0x18,%al
   9:   e8 b5 f4 f8 ff          call   0xfffffffffff8f4c3
   e:   4c 8b 54 24 18          mov    0x18(%rsp),%r10
  13:   48 8b 54 24 10          mov    0x10(%rsp),%rdx
  18:   41 89 c0                mov    %eax,%r8d
  1b:   48 8b 74 24 08          mov    0x8(%rsp),%rsi
  20:   8b 3c 24                mov    (%rsp),%edi
  23:   b8 11 00 00 00          mov    $0x11,%eax
  28:   0f 05                   syscall
  2a:*  48 3d 00 f0 ff ff       cmp    $0xfffffffffffff000,%rax
 <-- trapping instruction
  30:   77 31                   ja     0x63
  32:   44 89 c7                mov    %r8d,%edi
  35:   48 89 04 24             mov    %rax,(%rsp)
  39:   e8 05 f5 f8 ff          call   0xfffffffffff8f543
  3e:   48                      rex.W
  3f:   8b                      .byte 0x8b

Code starting with the faulting instruction
===========================================
   0:   48 3d 00 f0 ff ff       cmp    $0xfffffffffffff000,%rax
   6:   77 31                   ja     0x39
   8:   44 89 c7                mov    %r8d,%edi
   b:   48 89 04 24             mov    %rax,(%rsp)
   f:   e8 05 f5 f8 ff          call   0xfffffffffff8f519
  14:   48                      rex.W
  15:   8b                      .byte 0x8b
[519077.338189] RSP: 002b:00007ffc7f5d4100 EFLAGS: 00000293 ORIG_RAX:
0000000000000011
[519077.338191] RAX: ffffffffffffffda RBX: 0000000000001000 RCX:
00007f1ee9c361a7
[519077.338192] RDX: 0000000000001000 RSI: 00007ffc7f5d43f0 RDI:
0000000000000007
[519077.338193] RBP: 00007ffc7f5d42a0 R08: 0000000000000000 R09:
000055b4e809ade0
[519077.338195] R10: 00007fa5c180c8a0 R11: 0000000000000293 R12:
00007fa5c180c8a0
[519077.338196] R13: 00000ed00022a100 R14: 00007ffc7f5d43f0 R15:
0000000000001000
[519077.338198]  </TASK>
[519077.338199] ---[ end trace 0000000000000000 ]---


-- 
/**
 - Ilkka Prusi
 - ilkka.prusi@gmail.com
*/
