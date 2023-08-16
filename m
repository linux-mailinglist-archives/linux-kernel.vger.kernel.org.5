Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227A977EBE6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 23:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346522AbjHPVcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 17:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346532AbjHPVcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 17:32:17 -0400
Received: from dogben.com (dogben.com [IPv6:2400:8902:e001:2f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407CAFD
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 14:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dogben.com;
        s=main; h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
        In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=e0Y7YVtnkfbhnudY5Y2G4Zz1+ngPmCxflbezF2GeSso=; b=UOkyUACbxRqAuLdIFJpzjMyf6x
        iHQlflFyoifPXmiZIsKPIN3f52Hw4cugeoIPRLNw0ngulsh5N2VH4CCmlMwT3ENU4/Drm+0GZOxTf
        XeGMMSfouIyMqtyHdmBrDKlzGJHR4STW7M2MSsnMrJ4aEHMapLdOYvwxzjZKTuu8VFRKT+z7lwV9M
        v5jQ4C7mKXKNuIIWw4y+IuG1pzs3MwQ5pyoRPOwCs+vDqd1iPcu00oAmZ255F3XsxxPkdXiet0drz
        ZPartclPBcyDgIBc17y4RCvJYgMr2osqOV60koMYCmL++MKrMiqo17JePr8ivB++A/C3HsC21wMWw
        k77i8TUA==;
MIME-Version: 1.0
Date:   Thu, 17 Aug 2023 05:32:13 +0800
From:   Wei Shuyu <wsy@dogben.com>
To:     Ilkka Prusi <ilkka.prusi@gmail.com>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: WARNING: at mm/gup.c:1101 __get_user_pages in 6.4.3
In-Reply-To: <CAJuPgPPZ43=h5P8326-0bBcHadnOTGOoOTEP4yJJdDDt5fF8sw@mail.gmail.com>
References: <CAJuPgPMp_B-TcBq0NWJcaL-aF4YEcJvx0ain7qVOLb-trVqrsQ@mail.gmail.com>
 <7c6b632270d0c250c5791a6db5dc3e9e@dogben.com>
 <8fbc7879-09b2-4b1c-86e0-f8835b675843@t-8ch.de>
 <882633660a17792b574bcedea1431a6c@dogben.com>
 <CAJuPgPPZ43=h5P8326-0bBcHadnOTGOoOTEP4yJJdDDt5fF8sw@mail.gmail.com>
Message-ID: <3216d79275fa5608aa48cb26b968fc5e@dogben.com>
X-Sender: wsy@dogben.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-16 14:17, Ilkka Prusi wrote:
> Well, this does lead to crash in Xwayland and so you lose the ability
> to do anything on the computer (including switching to a virtual
> console).
> So I'd say this isn't "safe" to ignore even if it does say "warning"
> instead or "error".
> 
> And it does repeat every so often. Video playback on a browser seems
> to be one way to trigger this often.
> Following is on 6.4.10.
> 
> ------------[ cut here ]------------
> WARNING: CPU: 4 PID: 159964 at mm/gup.c:1101 
> __get_user_pages+0x539/0x610
> Modules linked in: uinput(E) snd_seq_dummy(E) snd_hrtimer(E)
> snd_seq(E) binfmt_misc(E) nls_ascii(E) nls_cp850(E) vfat(E) fat(E)
> amdgpu(E) intel_rapl_msr(E) intel_rapl_common(E) iosf_mbi(E)
> snd_usb_audio(E) video(E) gpu_sched(E) snd_usbmidi_lib(E) drm_buddy(E)
> edac_mce_amd(E) drm_suballoc_helper(E) snd_hda_codec_realtek(E)
> kvm_amd(E) drm_display_helper(E) snd_hda_codec_generic(E)
> snd_hda_codec_hdmi(E) cec(E) drm_ttm_helper(E) ledtrig_audio(E)
> snd_rawmidi(E) kvm(E) snd_seq_device(E) snd_hda_intel(E)
> snd_intel_dspcfg(E) ttm(E) mc(E) snd_hda_codec(E) irqbypass(E)
> input_leds(E) drm_kms_helper(E) snd_hda_core(E) crct10dif_pclmul(E)
> snd_hwdep(E) joydev(E) snd_pcm(E) crc32_pclmul(E) syscopyarea(E)
> ghash_clmulni_intel(E) sysfillrect(E) snd_timer(E) sha512_ssse3(E)
> sysimgblt(E) sha512_generic(E) k10temp(E) snd(E) sg(E) ccp(E)
> rng_core(E) soundcore(E) aesni_intel(E) crypto_simd(E) cryptd(E)
> wmi_bmof(E) rapl(E) evdev(E) acpi_cpufreq(E) tiny_power_button(E)
> button(E) nfsd(E) auth_rpcgss(E) nfs_acl(E) lockd(E) grace(E)
>   sunrpc(E) configfs(E) loop(E) fuse(E) dm_mod(E) msr(E) efi_pstore(E)
> dmi_sysfs(E) ip_tables(E) x_tables(E) ipv6(E) autofs4(E) efivarfs(E)
> raid10(E) raid456(E) async_raid6_recov(E) async_memcpy(E) async_pq(E)
> async_xor(E) xor(E) async_tx(E) raid6_pq(E) libcrc32c(E) raid1(E)
> raid0(E) multipath(E) linear(E) md_mod(E) hid_playstation(E)
> led_class_multicolor(E) ff_memless(E) hid_generic(E) usbhid(E) hid(E)
> xhci_pci(E) xhci_hcd(E) sd_mod(E) t10_pi(E) crc32c_intel(E)
> i2c_piix4(E) usbcore(E) igb(E) i2c_algo_bit(E) usb_common(E) dca(E)
> crc64_rocksoft(E) crc64(E) wmi(E) thermal(E)
> CPU: 4 PID: 159964 Comm: chrome_crashpad Tainted: G            E
> 6.4.10-stable #167
> Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS ELITE/X570
> AORUS ELITE, BIOS F37c 05/12/2022
> RIP: 0010:__get_user_pages+0x539/0x610
> Code: 8b 84 24 c0 00 00 00 48 8d 04 d0 e9 da fd ff ff 48 89 d1 48 f7
> d1 48 21 c1 f7 c1 81 01 00 00 0f 85 58 fe ff ff e9 64 ff ff ff <0f> 0b
> e9 2d fd ff ff f6 c3 04 0f 85 54 ff ff ff 49 8b 07 48 8b 0d
> RSP: 0018:ffffc900054f7cb8 EFLAGS: 00010202
> RAX: ffff8883567d6f18 RBX: 000000000005000a RCX: 00007ffcdd723fff
> RDX: 00007ffcdd724000 RSI: 00007f7855f57000 RDI: ffff8885a93fbb68
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
> R10: ffff888137013780 R11: 0000000000000000 R12: ffff8881ac570000
> R13: ffffc900054f7dd8 R14: ffff8883567d6f18 R15: 000000000005000a
> FS:  00007fcf90f02c80(0000) GS:ffff88881e900000(0000) 
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00001b8400464300 CR3: 00000004c78d2000 CR4: 0000000000350ee0
> Call Trace:
>  <TASK>
>  ? __warn+0x6b/0xd0
>  ? __get_user_pages+0x539/0x610
>  ? report_bug+0x144/0x190
>  ? handle_bug+0x3c/0x60
>  ? exc_invalid_op+0x13/0x60
>  ? asm_exc_invalid_op+0x16/0x20
>  ? __get_user_pages+0x539/0x610
>  ? __get_user_pages+0x7f/0x610
>  get_user_pages_remote+0xfd/0x340
>  ? mtree_load+0x21/0x1f0
>  __access_remote_vm+0x16d/0x370
>  mem_rw.isra.0+0x115/0x1d0
>  vfs_read+0x95/0x2a0
>  ? __fget_files+0x8a/0xc0
>  ? lock_release+0x91/0x1a0
>  ? lock_acquire.part.0.isra.0+0x47/0x80
>  ? __fget_files+0xa2/0xc0
>  __x64_sys_pread64+0x6e/0xb0
>  do_syscall_64+0x3a/0x80
>  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> RIP: 0033:0x7fcf909151e7
> Code: 08 89 3c 24 48 89 4c 24 18 e8 e5 f4 f8 ff 4c 8b 54 24 18 48 8b
> 54 24 10 41 89 c0 48 8b 74 24 08 8b 3c 24 b8 11 00 00 00 0f 05 <48> 3d
> 00 f0 ff ff 77 31 44 89 c7 48 89 04 24 e8 35 f5 f8 ff 48 8b
> RSP: 002b:00007ffc8a765460 EFLAGS: 00000293 ORIG_RAX: 0000000000000011
> RAX: ffffffffffffffda RBX: 0000000000001000 RCX: 00007fcf909151e7
> RDX: 0000000000001000 RSI: 00007ffc8a765750 RDI: 0000000000000007
> RBP: 00007ffc8a765600 R08: 0000000000000000 R09: 000056045cb5ade0
> R10: 00007f7855f568a0 R11: 0000000000000293 R12: 00007f7855f568a0
> R13: 00001b840022a100 R14: 00007ffc8a765750 R15: 0000000000001000
>  </TASK>
> ---[ end trace 0000000000000000 ]---
> 
> $ scripts/decode_stacktrace.sh vmlinux < ~/crash_20230816
> ------------[ cut here ]------------
> WARNING: CPU: 4 PID: 159964 at mm/gup.c:1101 __get_user_pages
> (mm/gup.c:1101 (discriminator 1))
> Modules linked in: uinput(E) snd_seq_dummy(E) snd_hrtimer(E)
> snd_seq(E) binfmt_misc(E) nls_ascii(E) nls_cp850(E) vfat(E) fat(E)
> amdgpu(E) intel_rapl_msr(E) intel_rapl_common(E) iosf_mbi(E)
> snd_usb_audio(E) video(E) gpu_sched(E) snd_usbmidi_lib(E) drm_buddy(E)
> edac_mce_amd(E) drm_suballoc_helper(E) snd_hda_codec_realtek(E)
> kvm_amd(E) drm_display_helper(E) snd_hda_codec_generic(E)
> snd_hda_codec_hdmi(E) cec(E) drm_ttm_helper(E) ledtrig_audio(E)
> snd_rawmidi(E) kvm(E) snd_seq_device(E) snd_hda_intel(E)
> snd_intel_dspcfg(E) ttm(E) mc(E) snd_hda_codec(E) irqbypass(E)
> input_leds(E) drm_kms_helper(E) snd_hda_core(E) crct10dif_pclmul(E)
> snd_hwdep(E) joydev(E) snd_pcm(E) crc32_pclmul(E) syscopyarea(E)
> ghash_clmulni_intel(E) sysfillrect(E) snd_timer(E) sha512_ssse3(E)
> sysimgblt(E) sha512_generic(E) k10temp(E) snd(E) sg(E) ccp(E)
> rng_core(E) soundcore(E) aesni_intel(E) crypto_simd(E) cryptd(E)
> wmi_bmof(E) rapl(E) evdev(E) acpi_cpufreq(E) tiny_power_button(E)
> button(E) nfsd(E) auth_rpcgss(E) nfs_acl(E) lockd(E) grace(E)
> sunrpc(E) configfs(E) loop(E) fuse(E) dm_mod(E) msr(E) efi_pstore(E)
> dmi_sysfs(E) ip_tables(E) x_tables(E) ipv6(E) autofs4(E) efivarfs(E)
> raid10(E) raid456(E) async_raid6_recov(E) async_memcpy(E) async_pq(E)
> async_xor(E) xor(E) async_tx(E) raid6_pq(E) libcrc32c(E) raid1(E)
> raid0(E) multipath(E) linear(E) md_mod(E) hid_playstation(E)
> led_class_multicolor(E) ff_memless(E) hid_generic(E) usbhid(E) hid(E)
> xhci_pci(E) xhci_hcd(E) sd_mod(E) t10_pi(E) crc32c_intel(E)
> i2c_piix4(E) usbcore(E) igb(E) i2c_algo_bit(E) usb_common(E) dca(E)
> crc64_rocksoft(E) crc64(E) wmi(E) thermal(E)
> CPU: 4 PID: 159964 Comm: chrome_crashpad Tainted: G            E
> 6.4.10-stable #167
> Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS ELITE/X570
> AORUS ELITE, BIOS F37c 05/12/2022
> RIP: 0010:__get_user_pages (mm/gup.c:1101 (discriminator 1))
> Code: 8b 84 24 c0 00 00 00 48 8d 04 d0 e9 da fd ff ff 48 89 d1 48 f7
> d1 48 21 c1 f7 c1 81 01 00 00 0f 85 58 fe ff ff e9 64 ff ff ff <0f> 0b
> e9 2d fd ff ff f6 c3 04 0f 85 54 ff ff ff 49 8b 07 48 8b 0d
> All code
> ========
>    0:   8b 84 24 c0 00 00 00    mov    0xc0(%rsp),%eax
>    7:   48 8d 04 d0             lea    (%rax,%rdx,8),%rax
>    b:   e9 da fd ff ff          jmp    0xfffffffffffffdea
>   10:   48 89 d1                mov    %rdx,%rcx
>   13:   48 f7 d1                not    %rcx
>   16:   48 21 c1                and    %rax,%rcx
>   19:   f7 c1 81 01 00 00       test   $0x181,%ecx
>   1f:   0f 85 58 fe ff ff       jne    0xfffffffffffffe7d
>   25:   e9 64 ff ff ff          jmp    0xffffffffffffff8e
>   2a:*  0f 0b                   ud2             <-- trapping 
> instruction
>   2c:   e9 2d fd ff ff          jmp    0xfffffffffffffd5e
>   31:   f6 c3 04                test   $0x4,%bl
>   34:   0f 85 54 ff ff ff       jne    0xffffffffffffff8e
>   3a:   49 8b 07                mov    (%r15),%rax
>   3d:   48                      rex.W
>   3e:   8b                      .byte 0x8b
>   3f:   0d                      .byte 0xd
> 
> Code starting with the faulting instruction
> ===========================================
>    0:   0f 0b                   ud2
>    2:   e9 2d fd ff ff          jmp    0xfffffffffffffd34
>    7:   f6 c3 04                test   $0x4,%bl
>    a:   0f 85 54 ff ff ff       jne    0xffffffffffffff64
>   10:   49 8b 07                mov    (%r15),%rax
>   13:   48                      rex.W
>   14:   8b                      .byte 0x8b
>   15:   0d                      .byte 0xd
> RSP: 0018:ffffc900054f7cb8 EFLAGS: 00010202
> RAX: ffff8883567d6f18 RBX: 000000000005000a RCX: 00007ffcdd723fff
> RDX: 00007ffcdd724000 RSI: 00007f7855f57000 RDI: ffff8885a93fbb68
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
> R10: ffff888137013780 R11: 0000000000000000 R12: ffff8881ac570000
> R13: ffffc900054f7dd8 R14: ffff8883567d6f18 R15: 000000000005000a
> FS:  00007fcf90f02c80(0000) GS:ffff88881e900000(0000) 
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00001b8400464300 CR3: 00000004c78d2000 CR4: 0000000000350ee0
> Call Trace:
> <TASK>
> ? __warn (kernel/panic.c:673)
> ? __get_user_pages (mm/gup.c:1101 (discriminator 1))
> ? report_bug (lib/bug.c:180 lib/bug.c:219)
> ? handle_bug (arch/x86/kernel/traps.c:326)
> ? exc_invalid_op (arch/x86/kernel/traps.c:347 (discriminator 1))
> ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:568)
> ? __get_user_pages (mm/gup.c:1101 (discriminator 1))
> ? __get_user_pages (mm/gup.c:1100)
> get_user_pages_remote (mm/gup.c:1391 mm/gup.c:2238)
> ? mtree_load (./include/linux/rcupdate.h:327
> ./include/linux/rcupdate.h:773 lib/maple_tree.c:6223)
> __access_remote_vm (mm/memory.c:5743)
> mem_rw.isra.0 (fs/proc/base.c:867)
> vfs_read (fs/read_write.c:468)
> ? __fget_files (./include/linux/rcupdate.h:805 fs/file.c:915)
> ? lock_release (kernel/locking/lockdep.c:5381 
> kernel/locking/lockdep.c:5725)
> ? lock_acquire.part.0.isra.0 (kernel/locking/lockdep.c:467
> kernel/locking/lockdep.c:5707)
> ? __fget_files (fs/file.c:918)
> __x64_sys_pread64 (./include/linux/file.h:44 fs/read_write.c:666
> fs/read_write.c:675 fs/read_write.c:672 fs/read_write.c:672)
> do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
> entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
> RIP: 0033:0x7fcf909151e7
> Code: 08 89 3c 24 48 89 4c 24 18 e8 e5 f4 f8 ff 4c 8b 54 24 18 48 8b
> 54 24 10 41 89 c0 48 8b 74 24 08 8b 3c 24 b8 11 00 00 00 0f 05 <48> 3d
> 00 f0 ff ff 77 31 44 89 c7 48 89 04 24 e8 35 f5 f8 ff 48 8b
> All code
> ========
>    0:   08 89 3c 24 48 89       or     %cl,-0x76b7dbc4(%rcx)
>    6:   4c 24 18                rex.WR and $0x18,%al
>    9:   e8 e5 f4 f8 ff          call   0xfffffffffff8f4f3
>    e:   4c 8b 54 24 18          mov    0x18(%rsp),%r10
>   13:   48 8b 54 24 10          mov    0x10(%rsp),%rdx
>   18:   41 89 c0                mov    %eax,%r8d
>   1b:   48 8b 74 24 08          mov    0x8(%rsp),%rsi
>   20:   8b 3c 24                mov    (%rsp),%edi
>   23:   b8 11 00 00 00          mov    $0x11,%eax
>   28:   0f 05                   syscall
>   2a:*  48 3d 00 f0 ff ff       cmp    $0xfffffffffffff000,%rax
>  <-- trapping instruction
>   30:   77 31                   ja     0x63
>   32:   44 89 c7                mov    %r8d,%edi
>   35:   48 89 04 24             mov    %rax,(%rsp)
>   39:   e8 35 f5 f8 ff          call   0xfffffffffff8f573
>   3e:   48                      rex.W
>   3f:   8b                      .byte 0x8b
> 
> Code starting with the faulting instruction
> ===========================================
>    0:   48 3d 00 f0 ff ff       cmp    $0xfffffffffffff000,%rax
>    6:   77 31                   ja     0x39
>    8:   44 89 c7                mov    %r8d,%edi
>    b:   48 89 04 24             mov    %rax,(%rsp)
>    f:   e8 35 f5 f8 ff          call   0xfffffffffff8f549
>   14:   48                      rex.W
>   15:   8b                      .byte 0x8b
> RSP: 002b:00007ffc8a765460 EFLAGS: 00000293 ORIG_RAX: 0000000000000011
> RAX: ffffffffffffffda RBX: 0000000000001000 RCX: 00007fcf909151e7
> RDX: 0000000000001000 RSI: 00007ffc8a765750 RDI: 0000000000000007
> RBP: 00007ffc8a765600 R08: 0000000000000000 R09: 000056045cb5ade0
> R10: 00007f7855f568a0 R11: 0000000000000293 R12: 00007f7855f568a0
> R13: 00001b840022a100 R14: 00007ffc8a765750 R15: 0000000000001000
> </TASK>
> ---[ end trace 0000000000000000 ]---
> 

In your case, it's the gpu driver that caused the chrome crash. Then 
chrome_crashpad triggered the warning. Fixing this warning won't fix the 
gpu driver bug.



