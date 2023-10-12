Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79407C650E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 08:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377117AbjJLGDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 02:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbjJLGDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 02:03:03 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8531B7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:03:01 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-406553f6976so1866835e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697090580; x=1697695380; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pRRMKGAUW6RUAYK+75pYRfPZyU+GE9gdXl6ARgE9wEc=;
        b=T3+nVz5p5aazETXdXw2A0QncI1Dy3XV3YESZiITD2Ei4NPUssoIwvw+T3apO2I5sNR
         3+rH3HKLDPC2l6mJFIQw3v0qL4Q9PFjJMPpd9pq/6yaMkQvZyoULC85x0jgS56zX1G7O
         YlUAjPh7lgusf+aeYZefbH9wJ87y+Tu8tzMo3fj6EtAKdZN+86fw63NIdPfErEZNB1gy
         QxW96CoRUKzOSEbq3/iioMNN/QbT36ijNir/2gdNEKu1TBLXFKzzSA3QhPa7/N01txPk
         dff5Ke/ar7FwD+BMT0GXu03fEo472Sw2ahuqjHYuIq2nc0DAKmlfvM+5u/O7rgbOqFQ6
         4dcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697090580; x=1697695380;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pRRMKGAUW6RUAYK+75pYRfPZyU+GE9gdXl6ARgE9wEc=;
        b=lRCN/sHVC2UkaBAVh4fuSqlBDy1NE3Z027w04upfpBPoA3NmqE4dNerGFk8lsLsEpJ
         J5D3pYgPFxXWXgQZil018q0zubH2NlGwGb6sN+HockLEY0CJ0v2BwtEsFz/F5kPesgZD
         kq4Chh7uX4hclB1Fkbv9fQKc0+j27UlexNQPpPlK1zJJdXBtOXAv0QyCM2gQHiBBpwUQ
         kae3YhcqNdL81HwHAYhorf2GWBDgglRNY50Qro7Zn5CxblYUgiu8U8HUkVDUavDmeboy
         ar/S6NL95gmjoxvy/8ef/BMfbcZUtZXdgR6HWqmxIMyDRxK9yjk1xDOGIKJNnmoKKGre
         Ew5A==
X-Gm-Message-State: AOJu0YxFdrV/hfLgf1pXMINofMvcz4d4JtAC8YDkm6iv6LSI3fypJ7Sg
        9ST7Rz0UDPJrkoB22WvujHk=
X-Google-Smtp-Source: AGHT+IGyVAilJBym4rCRN+Xslym4KuSff1SY2lwgi9/bHFd+4nN0AJvqTFxn+Za0nS6jtke9ne5YhQ==
X-Received: by 2002:a05:600c:5114:b0:405:4127:f471 with SMTP id o20-20020a05600c511400b004054127f471mr20280728wms.1.1697090579998;
        Wed, 11 Oct 2023 23:02:59 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id bd5-20020a05600c1f0500b004030e8ff964sm21112122wmb.34.2023.10.11.23.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 23:02:59 -0700 (PDT)
Date:   Thu, 12 Oct 2023 08:02:58 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] staging: rtl8192u: Fix two crashing bugs
Message-ID: <cover.1697089416.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Question: Fix or remove rtl8192u?

I found a USB WLAN Stick with a rtl8192u. I got it last Saturday and=20
found out that the firmware is missing in my ubuntu 20.04. I found it on=20
the web and fixed it. When I started the driver my computer crashed. The=20
missing part was: priv->priv_wq =3D alloc_workqueue("priv_wq", 0, 0);=20
Fixing this the next error was a network =3D kzalloc(sizeof(*network),=20
GFP_KERNEL); in wrong context which leads to a crash of my computer.=20
Fixing this the next error is more depending on what I do with the stick.

When lucky the connection is build up and I can surf and download at maximu=
m speed (12,5MB/s) several gigabytes.

But when I open the window to see other stations the computer crashes again=
=2E Find a possible dump at the end.

Hint from Arnd Bergmann on the 10/11/23:
https://lore.kernel.org/linux-staging/db98d9ac-7650-4a72-8eb9-4def1f17ea0d@=
app.fastmail.com/T/#t
I see the two bugs were introduced in 2016 by commit 1761a85c3bed3
("staging: rtl8192u: Remove create_workqueue()") and in 2021 by
commit 061e390b7c87f ("staging: rtl8192u: ieee80211_softmac: Move a
large data struct onto the heap"), so it's been broken for a while.

[  +0.043662] alg name:CCMP
[  +0.724234] rtl819xU 1-1.6:1.0 wlan0: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D>rx ADDBAREQ from :9c:a2:f4:67:5d:c0
[  +0.000016] rtl819xU 1-1.6:1.0 wlan0: =3D=3D=3D=3D=3D>to send ADDBARSP
[Oct10 00:42] BUG: kernel NULL pointer dereference, address: 00000000000001=
c0
[  +0.000008] #PF: supervisor read access in kernel mode
[  +0.000002] #PF: error_code(0x0000) - not-present page
[  +0.000002] PGD 0 P4D 0=20
[  +0.000004] Oops: 0000 [#1] PREEMPT SMP PTI
[  +0.000003] CPU: 0 PID: 1246 Comm: wpa_supplicant Tainted: G         C OE=
      6.6.0-rc1+ #15
[  +0.000003] Hardware name: FUJITSU ESPRIMO P710/D3161-A1, BIOS V4.6.5.3 R=
1.16.0 for D3161-A1x 10/29/2012
[  +0.000002] RIP: 0010:__queue_work+0x38/0x610
[  +0.000005] Code: 89 fe 41 55 41 54 49 89 d4 53 48 89 f3 48 83 ec 18 8b 0=
d 43 23 ce 01 85 c9 74 0f 65 8b 05 c0 af ee 45 85 c0 0f 84 da 02 00 00 <f7>=
 83 c0 01 00 00 00 80 01 00 0f 85 eb 02 00 00 e8 33 d6 0a 00 31
[  +0.000003] RSP: 0018:ffffc90002e6bc28 EFLAGS: 00010046
[  +0.000002] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000000000=
0001
[  +0.000002] RDX: ffff88817ff1a8d8 RSI: 0000000000000000 RDI: 000000000000=
2000
[  +0.000002] RBP: ffffc90002e6bc68 R08: 0000000000000000 R09: 000000000000=
0000
[  +0.000001] R10: ffffc90002e6bca0 R11: ffffffffc0fff3e2 R12: ffff88817ff1=
a8d8
[  +0.000002] R13: 0000000000000001 R14: 0000000000002000 R15: 000000000000=
0000
[  +0.000002] FS:  00007f9be4ad9140(0000) GS:ffff888215400000(0000) knlGS:0=
000000000000000
[  +0.000002] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000002] CR2: 00000000000001c0 CR3: 00000001127ce005 CR4: 000000000017=
06f0
[  +0.000002] Call Trace:
[  +0.000002]  <TASK>
[  +0.000011]  ? show_regs+0x68/0x70
[  +0.000005]  ? __die_body+0x20/0x70
[  +0.000004]  ? __die+0x2b/0x40
[  +0.000003]  ? page_fault_oops+0x160/0x480
[  +0.000003]  ? search_bpf_extables+0xad/0x160
[  +0.000004]  ? __queue_work+0x38/0x610
[  +0.000002]  ? search_exception_tables+0x5f/0x70
[  +0.000004]  ? kernelmode_fixup_or_oops+0xa2/0x120
[  +0.000011]  ? __bad_area_nosemaphore+0x197/0x250
[  +0.000003]  ? up_read+0xc3/0x270
[  +0.000004]  ? bad_area_nosemaphore+0x16/0x20
[  +0.000002]  ? do_user_addr_fault+0x34d/0xa40
[  +0.000004]  ? exc_page_fault+0x84/0x210
[  +0.000005]  ? asm_exc_page_fault+0x27/0x30
[  +0.000006]  ? ieee80211_wx_set_scan+0x22/0x80 [r8192u_usb]
[  +0.000022]  ? __queue_work+0x38/0x610
[  +0.000003]  ? debug_smp_processor_id+0x17/0x20
[  +0.000004]  queue_work_on+0x7e/0x80
[  +0.000003]  ieee80211_wx_set_scan+0x77/0x80 [r8192u_usb]
[  +0.000016]  r8192_wx_set_scan+0x128/0x190 [r8192u_usb]
[  +0.000014]  ioctl_standard_iw_point+0x2e6/0x390
[  +0.000004]  ? __pfx_r8192_wx_set_scan+0x10/0x10 [r8192u_usb]
[  +0.000014]  ? sched_clock_noinstr+0x9/0x10
[  +0.000003]  ? local_clock_noinstr+0x10/0xd0
[  +0.000004]  ioctl_standard_call+0xaa/0xe0
[  +0.000003]  ? netdev_name_node_lookup+0x65/0x90
[  +0.000003]  ? __pfx_ioctl_private_call+0x10/0x10
[  +0.000003]  ? __pfx_ioctl_standard_call+0x10/0x10
[  +0.000004]  wireless_process_ioctl+0x149/0x170
[  +0.000004]  wext_handle_ioctl+0x9e/0x100
[  +0.000005]  sock_ioctl+0x203/0x340
[  +0.000005]  ? syscall_enter_from_user_mode+0x21/0x60
[  +0.000004]  __x64_sys_ioctl+0x98/0xd0
[  +0.000005]  do_syscall_64+0x3b/0x90
[  +0.000004]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[  +0.000003] RIP: 0033:0x7f9be47223ab
[  +0.000003] Code: 0f 1e fa 48 8b 05 e5 7a 0d 00 64 c7 00 26 00 00 00 48 c=
7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48>=
 3d 01 f0 ff ff 73 01 c3 48 8b 0d b5 7a 0d 00 f7 d8 64 89 01 48
[  +0.000002] RSP: 002b:00007ffdecbeeed8 EFLAGS: 00000246 ORIG_RAX: 0000000=
000000010
[  +0.000003] RAX: ffffffffffffffda RBX: 000055e97efd0580 RCX: 00007f9be472=
23ab
[  +0.000002] RDX: 00007ffdecbeeee0 RSI: 0000000000008b18 RDI: 000000000000=
0009
[  +0.000001] RBP: 0000000000000000 R08: 0000000000000000 R09: 000000000000=
0010
[  +0.000002] R10: 00007ffdecbfa080 R11: 0000000000000246 R12: 000055e97efa=
4db0
[  +0.000001] R13: 0000000000000000 R14: 00007ffdecbeeee0 R15: 000055e97efa=
27c8
[  +0.000005]  </TASK>
[  +0.000001] Modules linked in: ccm r8192u_usb(COE) cfg80211 lib80211 liba=
rc4 xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink xfrm_user xfr=
m_algo iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc=
32c xt_addrtype iptable_filter bpfilter br_netfilter bridge stp llc overlay=
 nls_iso8859_1 snd_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_gene=
ric ledtrig_audio intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal int=
el_powerclamp coretemp kvm_intel kvm crct10dif_pclmul ghash_clmulni_intel s=
ha512_ssse3 snd_hda_intel sch5627 mei_hdcp snd_intel_dspcfg aesni_intel snd=
_intel_sdw_acpi crypto_simd binfmt_misc snd_hda_codec cryptd i915 snd_hda_c=
ore rapl sch56xx_common snd_hwdep intel_cstate joydev snd_pcm input_leds sn=
d_seq_midi serio_raw snd_seq_midi_event at24 drm_buddy snd_rawmidi snd_seq =
ttm snd_seq_device drm_display_helper cec snd_timer rc_core drm_kms_helper =
snd mei_me i2c_algo_bit tpm_infineon soundcore mei mac_hid sch_fq_codel msr=
 parport_pc ppdev lp parport drm ramoops reed_solomon
[  +0.000063]  efi_pstore ip_tables x_tables autofs4 hid_generic usbhid hid=
 i2c_i801 crc32_pclmul i2c_smbus ahci e1000e lpc_ich libahci xhci_pci xhci_=
pci_renesas video wmi
[  +0.000016] CR2: 00000000000001c0
[  +0.000003] ---[ end trace 0000000000000000 ]---
[  +0.000973] pstore: backend (efi_pstore) writing error (-5)
[  +0.000003] RIP: 0010:__queue_work+0x38/0x610
[  +0.000003] Code: 89 fe 41 55 41 54 49 89 d4 53 48 89 f3 48 83 ec 18 8b 0=
d 43 23 ce 01 85 c9 74 0f 65 8b 05 c0 af ee 45 85 c0 0f 84 da 02 00 00 <f7>=
 83 c0 01 00 00 00 80 01 00 0f 85 eb 02 00 00 e8 33 d6 0a 00 31
[  +0.000002] RSP: 0018:ffffc90002e6bc28 EFLAGS: 00010046
[  +0.000003] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000000000=
0001
[  +0.000002] RDX: ffff88817ff1a8d8 RSI: 0000000000000000 RDI: 000000000000=
2000
[  +0.000001] RBP: ffffc90002e6bc68 R08: 0000000000000000 R09: 000000000000=
0000
[  +0.000002] R10: ffffc90002e6bca0 R11: ffffffffc0fff3e2 R12: ffff88817ff1=
a8d8
[  +0.000001] R13: 0000000000000001 R14: 0000000000002000 R15: 000000000000=
0000
[  +0.000002] FS:  00007f9be4ad9140(0000) GS:ffff888215400000(0000) knlGS:0=
000000000000000
[  +0.000002] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000002] CR2: 00000000000001c0 CR3: 00000001127ce005 CR4: 000000000017=
06f0
[  +0.000002] note: wpa_supplicant[1246] exited with irqs disabled


Philipp Hortmann (2):
  staging: rtl8192u: Fix missing alloc_workqueue()
  staging: rtl8192u: Fix sleeping kzalloc() called from invalid context

 .../rtl8192u/ieee80211/ieee80211_softmac.c    | 19 ++++++++-----------
 drivers/staging/rtl8192u/r8192U.h             |  1 +
 drivers/staging/rtl8192u/r8192U_core.c        | 12 ++++++++++++
 3 files changed, 21 insertions(+), 11 deletions(-)

--=20
2.42.0

