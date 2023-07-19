Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1479759915
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjGSPCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjGSPCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:02:39 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32272C7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 08:02:38 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1b06da65bdbso5311142fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 08:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689778957; x=1692370957;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=23p4tFWZwG8wa1i1eJYLdjAr9uZxY9NRKxDstLvS/KM=;
        b=gbtCE1RLmpJNZjzjHu7FY3Bgc38p2fnftUnvQQMM8CZnVMjx5vOE6wjD0K2XEmyw4r
         g9IiyNJ7UbbLq1cxm7YGBaZzhLZk1CtP3etfpws9TNW5ZvdFmm593ef9AzlFDIuIk/O0
         7PkVgjbhKgPj7yaTl9/DM1Ele7F/epC2XfPCUqEBWVjHJ4ehUHSKHwoiIMwiWIcTIYZA
         2k9LU+6tuFcCioc8VDA+SWqF2iLQ+tnC9ebx/ysxvX7LzFpuiUrMhDCinKyqfB/2HDmk
         XpPo2nLRyu3DgFxvOi8NjEa1UqvKmqw35yUeTSFR6MwMpP9QGEVvUSdWJIZLVbHBTRLu
         glsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689778957; x=1692370957;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=23p4tFWZwG8wa1i1eJYLdjAr9uZxY9NRKxDstLvS/KM=;
        b=k3ai0+RKjHqlFZVjwnhkXfyr6j/imHCUb0pznFZdanx2dhGV5ue4YIL5IqMmcHmmfg
         nDzk5QPMn3ECd1Dj4hvxF010Xo7+AfLzwbKSS2TTMQMkFG99jQ4idZ36Nd1wtvbghhLG
         lOiNMDJU6veYsVOu8MK6F4lPgvQaKknCZGmY+xewZG4cNnCk9FGVJhXHOqoMr8sttRUg
         0LX2KRuXdHGc+Xl86dykOsh0aTXAZDHQazyyM71iX3FmPoGVqNSmpB34in5JGAGSH1kr
         8J8uoKJbfpmHBGoR8yCOZ/0JDd+1iLSpW2Lv/HQsMS4jU1QpMAHsg3qgRQgS+pMKu8/8
         Ujaw==
X-Gm-Message-State: ABy/qLarLok7BHcdix8cgWJP4odoqwt33+K4AAheQOrCX/1gBPC/sF8z
        Hi3y+sAVKW3hhPpyJ3pQ3Qo32N/Xl8s=
X-Google-Smtp-Source: APBJJlFUQ+vg+CZdajLEZB9MmkGv0Ra4fiFCaoQ8iHARhI8LF5cqkIyh8jckBvJY2MqrOmcEg4ME8g==
X-Received: by 2002:a05:6808:2091:b0:3a3:9ae0:efe2 with SMTP id s17-20020a056808209100b003a39ae0efe2mr3212265oiw.20.1689778957361;
        Wed, 19 Jul 2023 08:02:37 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id s9-20020a056808008900b003a392bd501csm1835693oic.20.2023.07.19.08.02.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 08:02:36 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <ab3a70e9-60ed-0f13-e3d4-8866eaccc8c1@lwfinger.net>
Date:   Wed, 19 Jul 2023 10:02:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Subject: Crash in VirtualBox virtual machines running kernel 6.5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When I try to start a VirtualBox virtual machine running kernel 6.5-rc2, it gets 
a kernel bug as follows while trying to mount a vboxsf-shared mount:

Jul 19 08:48:19 localhost kernel: detected buffer overflow in strscpy
Jul 19 08:48:19 localhost kernel: ------------[ cut here ]------------
Jul 19 08:48:19 localhost kernel: kernel BUG at lib/string_helpers.c:1031!
Jul 19 08:48:19 localhost kernel: invalid opcode: 0000 [#1] PREEMPT SMP PTI
Jul 19 08:48:19 localhost kernel: CPU: 2 PID: 507 Comm: mount.vboxsf Not tainted 
6.5.0-rc2-1.gc159bc5-default #1 openSUSE Tumbleweed (unreleased) 
4ec79f0435e04b515527e428ee3d62093b7f6e02
Jul 19 08:48:19 localhost kernel: Hardware name: innotek GmbH 
VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
Jul 19 08:48:19 localhost kernel: RIP: 0010:fortify_panic+0x13/0x20
Jul 19 08:48:19 localhost kernel: Code: 41 5d c3 cc cc cc cc 90 90 90 90 90 90 
90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 89 fe 48 c7 c7 68 e5 c6 93 e8 ed a7 
b2 ff <0f> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90
Jul 19 08:48:19 localhost kernel: RSP: 0018:ffffa72a4047fd40 EFLAGS: 00010246
Jul 19 08:48:19 localhost kernel: RAX: 0000000000000023 RBX: ffff903ac9d8ac00 
RCX: 0000000000000000
Jul 19 08:48:19 localhost kernel: RDX: 0000000000000000 RSI: ffff903adbd274c0 
RDI: ffff903adbd274c0
Jul 19 08:48:19 localhost kernel: RBP: 0000000000000002 R08: 0000000000000000 
R09: ffffa72a4047fc00
Jul 19 08:48:19 localhost kernel: R10: 0000000000000003 R11: ffffffff94558568 
R12: ffff903ac2013f00
Jul 19 08:48:19 localhost kernel: R13: ffff903ac8492800 R14: ffff903ac7b9dd20 
R15: 0000000000000007
Jul 19 08:48:19 localhost kernel: FS:  00007f22f0cec740(0000) 
GS:ffff903adbd00000(0000) knlGS:0000000000000000
Jul 19 08:48:19 localhost kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Jul 19 08:48:19 localhost kernel: CR2: 00007f22f0e7f574 CR3: 0000000109474001 
CR4: 00000000000706e0
Jul 19 08:48:19 localhost kernel: Call Trace:
Jul 19 08:48:19 localhost kernel:  <TASK>
Jul 19 08:48:19 localhost kernel:  ? die+0x36/0x90
Jul 19 08:48:19 localhost kernel:  ? do_trap+0xda/0x100
Jul 19 08:48:19 localhost kernel:  ? fortify_panic+0x13/0x20
Jul 19 08:48:19 localhost kernel:  ? do_error_trap+0x6a/0x90
Jul 19 08:48:19 localhost kernel:  ? fortify_panic+0x13/0x20
Jul 19 08:48:19 localhost kernel:  ? exc_invalid_op+0x50/0x70
Jul 19 08:48:19 localhost kernel:  ? fortify_panic+0x13/0x20
Jul 19 08:48:19 localhost kernel:  ? asm_exc_invalid_op+0x1a/0x20
Jul 19 08:48:19 localhost kernel:  ? fortify_panic+0x13/0x20
Jul 19 08:48:19 localhost kernel:  vboxsf_fill_super+0x3bc/0x3c0 [vboxsf 
447dff7257fbc53f0b47ed873d2b02eb4773401c]
Jul 19 08:48:19 localhost kernel:  ? __pfx_vboxsf_fill_super+0x10/0x10 [vboxsf 
447dff7257fbc53f0b47ed873d2b02eb4773401c]
Jul 19 08:48:19 localhost kernel:  vfs_get_super+0x6e/0xe0
Jul 19 08:48:19 localhost kernel:  vfs_get_tree+0x29/0xd0
Jul 19 08:48:19 localhost kernel:  path_mount+0x491/0xac0
Jul 19 08:48:19 localhost kernel:  __x64_sys_mount+0x109/0x140
Jul 19 08:48:19 localhost kernel:  do_syscall_64+0x60/0x90
Jul 19 08:48:19 localhost kernel:  ? count_memcg_events.constprop.0+0x1a/0x30
Jul 19 08:48:19 localhost kernel:  ? handle_mm_fault+0x9e/0x350
Jul 19 08:48:19 localhost kernel:  ? do_user_addr_fault+0x225/0x640
Jul 19 08:48:19 localhost kernel:  ? exc_page_fault+0x71/0x160
Jul 19 08:48:19 localhost kernel:  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
Jul 19 08:48:19 localhost kernel: RIP: 0033:0x7f22f0e05b9e
Jul 19 08:48:19 localhost kernel: Code: c3 66 2e 0f 1f 84 00 00 00 00 00 90 90 
90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 49 89 ca b8 a5 00 00 00 
0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 3a 02 0d 00 f7 d8 64 89 01 48
Jul 19 08:48:19 localhost kernel: RSP: 002b:00007ffe8ba4bab8 EFLAGS: 00000212 
ORIG_RAX: 00000000000000a5
Jul 19 08:48:19 localhost kernel: RAX: ffffffffffffffda RBX: 00007ffe8ba4df04 
RCX: 00007f22f0e05b9e
Jul 19 08:48:19 localhost kernel: RDX: 000055e9ab199ba8 RSI: 00007ffe8ba4df0b 
RDI: 00007ffe8ba4df04
Jul 19 08:48:19 localhost kernel: RBP: 00007ffe8ba4bc00 R08: 00007ffe8ba4bf50 
R09: 0000000000000000
Jul 19 08:48:19 localhost kernel: R10: 0000000000000004 R11: 0000000000000212 
R12: 00007ffe8ba4df0b
Jul 19 08:48:19 localhost kernel: R13: 0000000000000011 R14: 00007ffe8ba4bf50 
R15: 00007ffe8ba4df29
Jul 19 08:48:19 localhost kernel:  </TASK>
Jul 19 08:48:19 localhost kernel: Modules linked in: vboxsf vboxguest fuse 
efi_pstore configfs dmi_sysfs ip_tables x_tables crct10dif_pclmul crc32_pclmul 
polyval_clmulni polyval_generic sr_mod ohci_pci gf128mul cdrom ohci_hcd ehci_pci 
ehci_hcd ghash_clmulni_intel sha512_ssse3 ata_generic vmwgfx video usbcore 
drm_ttm_helper ttm aesni_intel crypto_simd cryptd ata_piix wmi serio_raw btrfs 
blake2b_generic libcrc32c crc32c_intel xor raid6_pq sg dm_multipath dm_mod 
scsi_dh_rdac scsi_dh_emc scsi_dh_alua msr efivarfs
Jul 19 08:48:19 localhost kernel: ---[ end trace 0000000000000000 ]---

The traceback points to the strscpy() added in commit 883f8fe87686d, which 
ironically was submitted to avoid buffer overflows using strlcpy(); however, I 
do not think that is the problem. My suspicion is that it comes from struct 
shfl_string, and the definition of the variable-length arrays in the union, and 
that their lengths are confusing the kernel's string handling routines.

I will be happy to test any proposed patches.

Larry


