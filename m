Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1198D75E478
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 21:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjGWTWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 15:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjGWTWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 15:22:05 -0400
X-Greylist: delayed 2438 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 23 Jul 2023 12:22:04 PDT
Received: from dogben.com (dogben.com [IPv6:2400:8902:e001:2f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAC8E42
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 12:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dogben.com;
        s=main; h=Content-Transfer-Encoding:Content-Type:Message-ID:In-Reply-To:
        Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WRgPxqdsMyTj5wux3t15JKtL+RrDc8w+6+agH23hsng=; b=KKULs36stVVF/sLNpRQmEbKUFp
        n/09SOU3o5vtoPCX0ALjFBJHWu7+DqVHSXbK+8TBB0TR1bpoRFGq4MiKUwiCknWvx1BEdOWW9krJB
        D1d1J32l1426z0ofjsOOsw5pxQbsityqelzLlUgntX+fno5h5kc7pjg7xKDLdLznB5koe+xfFY368
        2m4DHh4rlO9S1zKx43HbFbJo8hqMeD0AgWZ1uMF4JhdpxKNBIEH15kK8FWm2Nr89QqsIYLYyTC1Xr
        w9K0zzAWpYeO2tcheXWVExp3HSliLwCcGRYRg4W3Si2lUPcegUbkEIJTUGgefAg2pIwWTDB1zIcZl
        ItxK+w9g==;
MIME-Version: 1.0
Date:   Mon, 24 Jul 2023 02:41:24 +0800
From:   Wei Shuyu <wsy@dogben.com>
To:     ilkka.prusi@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: WARNING: at mm/gup.c:1101 __get_user_pages in 6.4.3
In-Reply-To: <CAJuPgPMp_B-TcBq0NWJcaL-aF4YEcJvx0ain7qVOLb-trVqrsQ@mail.gmail.com>
Message-ID: <7c6b632270d0c250c5791a6db5dc3e9e@dogben.com>
X-Sender: wsy@dogben.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I can trigger this reliably by visiting chrome://crash/


[  444.608793] ------------[ cut here ]------------
[  444.608795] WARNING: CPU: 7 PID: 901 at mm/gup.c:1101 
__get_user_pages+0x4c2/0x5b0
[  444.608800] Modules linked in: nvidia_drm(PO) nvidia_modeset(PO) 
nvidia(PO) nls_ascii nls_cp437 intel_rapl_msr vfat intel_rapl_common fat 
iosf_mbi kvm_amd uvcvideo kvm snd_hda_codec_realtek 
snd_hda_codec_generic irqbypass videobuf2_vmalloc ledtrig_audio 
snd_hda_codec_hdmi videobuf2_memops crc32_pclmul uvc videobuf2_v4l2 
snd_usb_audio pl2303 snd_hda_intel video snd_hwdep usbserial videodev 
snd_intel_dspcfg drm_kms_helper snd_hda_codec snd_usbmidi_lib 
aesni_intel snd_rawmidi snd_hda_core syscopyarea videobuf2_common 
snd_seq_device sysfillrect libaes sysimgblt input_leds snd_pcm 
crypto_simd mc led_class corsair_psu joydev cryptd snd_timer drm snd 
asus_ec_sensors evdev drm_panel_orientation_quirks rapl soundcore 
sp5100_tco pcspkr watchdog tiny_power_button wmi button loop fuse 
efi_pstore pstore efivarfs dmi_sysfs ip_tables x_tables autofs4 ext4 
crc32c_generic crc16 mbcache jbd2 hid_generic usbhid hid sd_mod ahci 
libahci xhci_pci libata xhci_hcd crc32c_intel i2c_piix4 scsi_mod nvme 
usbcore igb scsi_common usb_common
[  444.608829]  i2c_algo_bit nvme_core
[  444.608831] CPU: 7 PID: 901 Comm: chrome_crashpad Tainted: P          
  O       6.4.3 #1
[  444.608833] Hardware name: ASUS System Product Name/Pro WS X570-ACE, 
BIOS 4101 03/02/2022
[  444.608834] RIP: 0010:__get_user_pages+0x4c2/0x5b0
[  444.608836] Code: 00 00 48 8d 04 d0 e9 61 fc ff ff 48 8b 43 38 f0 48 
83 28 01 0f 85 f5 fd ff ff 48 8b 43 38 48 8d 7b 30 ff 50 08 e9 e5 fd ff 
ff <0f> 0b e9 b8 fb ff ff f6 c3 04 0f 85 7b ff ff ff 49 8b 17 48 8b 05
[  444.608837] RSP: 0018:ffff9d3466e07cd0 EFLAGS: 00010202
[  444.608838] RAX: ffff9d344651c5a0 RBX: 000000000005000a RCX: 
00007ffcc64cbfff
[  444.608839] RDX: ffff9d3444d27100 RSI: 00007f2918bba000 RDI: 
ffff9d3446c49e80
[  444.608840] RBP: ffff9d3444fe50c0 R08: ffff9d3444d27108 R09: 
0000000000000001
[  444.608841] R10: ffff9d3444d27180 R11: ffff9d3444d2710c R12: 
0000000000000000
[  444.608841] R13: ffff9d3466e07de8 R14: ffff9d344651c5a0 R15: 
ffff9d3466e07d7c
[  444.608842] FS:  00007f7abfb5e840(0000) GS:ffff9d432ebc0000(0000) 
knlGS:0000000000000000
[  444.608843] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  444.608844] CR2: 000036340030d020 CR3: 000000010fc5d000 CR4: 
0000000000350ee0
[  444.608844] Call Trace:
[  444.608846]  <TASK>
[  444.608846]  ? __warn+0x6b/0xd0
[  444.608849]  ? __get_user_pages+0x4c2/0x5b0
[  444.608850]  ? report_bug+0x143/0x190
[  444.608853]  ? handle_bug+0x36/0x70
[  444.608854]  ? exc_invalid_op+0x13/0x60
[  444.608856]  ? asm_exc_invalid_op+0x16/0x20
[  444.608858]  ? __get_user_pages+0x4c2/0x5b0
[  444.608860]  get_user_pages_remote+0xfa/0x310
[  444.608861]  __access_remote_vm+0x151/0x340
[  444.608863]  mem_rw.isra.0+0xec/0x180
[  444.608865]  vfs_read+0x8e/0x2c0
[  444.608868]  ? __count_memcg_events+0x39/0x80
[  444.608869]  ? handle_mm_fault+0xac/0x260
[  444.608870]  ? __fget_light+0x8c/0xf0
[  444.608872]  __x64_sys_pread64+0x6d/0xa0
[  444.608874]  do_syscall_64+0x35/0x80
[  444.608875]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[  444.608876] RIP: 0033:0x7f7abfc58b97
[  444.608877] Code: 08 89 3c 24 48 89 4c 24 18 e8 e5 ee f8 ff 4c 8b 54 
24 18 48 8b 54 24 10 41 89 c0 48 8b 74 24 08 8b 3c 24 b8 11 00 00 00 0f 
05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 04 24 e8 35 ef f8 ff 48 8b
[  444.608878] RSP: 002b:00007fff80823d70 EFLAGS: 00000293 ORIG_RAX: 
0000000000000011
[  444.608879] RAX: ffffffffffffffda RBX: 0000000000001000 RCX: 
00007f7abfc58b97
[  444.608880] RDX: 0000000000001000 RSI: 00007fff80824060 RDI: 
0000000000000004
[  444.608881] RBP: 00007fff80823f10 R08: 0000000000000000 R09: 
000055c771a571c0
[  444.608881] R10: 00007f2918bb9880 R11: 0000000000000293 R12: 
00007f2918bb9880
[  444.608882] R13: 0000363400229880 R14: 00007fff80824060 R15: 
0000000000001000
[  444.608883]  </TASK>
[  444.608883] ---[ end trace 0000000000000000 ]---
[  444.618816] chrome[1508]: segfault at 0 ip 000055ae15e9a2d0 sp 
00007ffcc64c7bb0 error 6 in chrome[55ae11624000+a492000] likely on CPU 6 
(core 6, socket 0)
[  444.618822] Code: 41 5c 41 5e 41 5f 5d e9 de 9e 78 fb cc 0f 0b cc cc 
cc cc cc cc cc cc cc cc cc 55 48 89 e5 48 8d 3d 85 be 55 06 e8 20 2a 87 
fb <c7> 04 25 00 00 00 00 00 00 00 00 5d c3 cc cc cc 55 48 89 e5 53 50
