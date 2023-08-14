Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC61F77B680
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 12:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbjHNKUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 06:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235023AbjHNKUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:20:18 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D2694;
        Mon, 14 Aug 2023 03:20:17 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b9f48b6796so62261551fa.3;
        Mon, 14 Aug 2023 03:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692008415; x=1692613215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ag33O9lTiJVhm7/4CtJTCGFSv1kDdRxMMiWVk+OXiug=;
        b=BXNTaI7EC32mYKM4YsWIof0Et5UJElg7ITVfxMuw02eiT4/Z90OMsj8yRjfcJZOvoK
         rpcACq1sGofHWfzwQhIsVsSlRM2ynK3r/KCPzJ/kEc3toEoh/imPe+4zHCncrxn+uew5
         W55qyzfct2W6R/pOuMRiWyeqNYfwuwLuSC+JoKAn9YGVaKrZRlcqOPDg0OYspPJq9HF9
         Aeu3TKbJtHD133nz9ofaQQY3pokqCI4Prs0gX+RbpJwt+writhRPRN8xeyPcyccnCH0b
         xiK1vO3esBRYcVzueKFH2CgIEFEnM3f0CU0Rq+XAQoBY4pvZ6cqzJGH9tGRn0jEOqK4z
         KRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692008415; x=1692613215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ag33O9lTiJVhm7/4CtJTCGFSv1kDdRxMMiWVk+OXiug=;
        b=Zk5YM8Ae93LDuczh659wE6UtvtszgepatzQxO1i358tg/RfdNdrKauKzZA1W7fe8Yx
         1+kODo6347XZbQTyVz1VPgRlIgtudNUj3B51vGK3TaQptviiOiMRnqPWakcrl+ox9rdb
         K7eNy0bKzTjVZO9Xc/p5CLq/YLhHzHd4uum7NDcE2Y28qW/Ys1LkJBRi8HwdiT72/pc8
         ooWrdemjhWB1FbQj8mswhW4Q73pv1vWrEqYXHzHUZrUoMpX+DL3nd/nKtFCbbrZRcBAA
         zIdO1OyvH1CZyAXd2TGoHlXEps7zfLFLdTRek+URfnL+t8ZDnQGorlbB8lQ76HVD37fu
         wnhg==
X-Gm-Message-State: AOJu0Yx2fzourJ9qjInnjDJOM3eUJ2FWal0jDKAZ7XpNkmPnt9vn6muG
        3uQc4YqjfTUVEc4L7jAHpptP5ywYsTJi3exLNjBILRZc8Ln+BXLQ
X-Google-Smtp-Source: AGHT+IG2jHImZblgMbvegmssYufW7bmmGVRX1o/cG5wmJqKIx3dKPXZGrjmOE9igtdsmvb8451n1zhqRIO2wwTupDhw=
X-Received: by 2002:a2e:9817:0:b0:2b5:80c9:1266 with SMTP id
 a23-20020a2e9817000000b002b580c91266mr7195481ljj.43.1692008414448; Mon, 14
 Aug 2023 03:20:14 -0700 (PDT)
MIME-Version: 1.0
From:   Yikebaer Aizezi <yikebaer61@gmail.com>
Date:   Mon, 14 Aug 2023 18:20:01 +0800
Message-ID: <CALcu4rYL4DJdGR=0Uk8Z9q9N2ihX5Y+mkeEjqrdjE62WL+98CA@mail.gmail.com>
Subject: WARNING in get_vaddr_frames
To:     linux-media@vger.kernel.org, m.szyprowski@samsung.com,
        tfiga@chromium.org
Cc:     mchehab@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When using Healer to fuzz the Latest Linux-6.5-rc6,  the following crash
was triggered.

HEAD commit: 2ccdd1b13c591d306f0401d98dedc4bdcd02b421 (tag: v6.5-rc6=EF=BC=
=89
git tree: upstream

console output:
https://drive.google.com/file/d/1qIDQrn_fde3SaSG2JkkL7kv1Rn2e1jlR/view?usp=
=3Ddrive_link
kernel config:https://drive.google.com/file/d/12QL_tHgc9I7N3m1Fqwuya83dltM8=
RM3z/view?usp=3Ddrive_link
C reproducer:https://drive.google.com/file/d/1bWDPAydevQrNvBZSwtSXE9ommhfVY=
qdr/view?usp=3Ddrive_link
Syzlang reproducer:
https://drive.google.com/file/d/1BDx-cyYRS68mMlqvnJ9GF3KTIRet1_Tk/view?usp=
=3Ddrive_link

If you fix this issue, please add the following tag to the commit:
Reported-by: Yikebaer Aizezi <yikebaer61@gmail.com>

get_vaddr_frames() cannot follow VM_IO mapping
WARNING: CPU: 1 PID: 12030 at
drivers/media/common/videobuf2/frame_vector.c:63 get_vaddr_frames
drivers/media/common/videobuf2/frame_vector.c:63 [inline]
WARNING: CPU: 1 PID: 12030 at
drivers/media/common/videobuf2/frame_vector.c:63
get_vaddr_frames+0x1fd/0x210
drivers/media/common/videobuf2/frame_vector.c:36
Modules linked in:
CPU: 1 PID: 12030 Comm: syz-executor Not tainted 6.5.0-rc6 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:get_vaddr_frames
drivers/media/common/videobuf2/frame_vector.c:63 [inline]
RIP: 0010:get_vaddr_frames+0x1fd/0x210
drivers/media/common/videobuf2/frame_vector.c:36
Code: 50 71 fb e9 06 ff ff ff e8 70 50 71 fb e9 cd fe ff ff e8 e6 83
21 fb 48 c7 c7 20 c5 b6 8a c6 05 e1 19 a1 07 01 e8 e3 87 e9 fa <0f> 0b
e9 53 ff ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 90 41 57 41
RSP: 0018:ffffc90005b57818 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffffc9000d800000 RCX: ffffc90003181000
RDX: 0000000000040000 RSI: ffffffff81487083 RDI: 0000000000000001
RBP: ffffc9000d800004 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
R13: 00000000ffffffb5 R14: ffffffffff600000 R15: ffff888018a8c800
FS:  00007fc39c269640(0000) GS:ffff888135c00000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc39c268f98 CR3: 000000010b298000 CR4: 0000000000750ee0
PKRU: 55555554
Call Trace:
 <TASK>
 vb2_create_framevec+0x60/0xd0
drivers/media/common/videobuf2/videobuf2-memops.c:52
 vb2_vmalloc_get_userptr+0x133/0x530
drivers/media/common/videobuf2/videobuf2-vmalloc.c:89
 __prepare_userptr.constprop.0+0x6a8/0x1610
drivers/media/common/videobuf2/videobuf2-core.c:1180
 __buf_prepare+0x623/0x810 drivers/media/common/videobuf2/videobuf2-core.c:=
1422
 vb2_core_prepare_buf+0xe0/0x330
drivers/media/common/videobuf2/videobuf2-core.c:1561
 vb2_prepare_buf+0xff/0x180 drivers/media/common/videobuf2/videobuf2-v4l2.c=
:738
 v4l2_m2m_prepare_buf+0xe4/0x1e0 drivers/media/v4l2-core/v4l2-mem2mem.c:823
 v4l_prepare_buf drivers/media/v4l2-core/v4l2-ioctl.c:2158 [inline]
 v4l_prepare_buf+0x92/0xc0 drivers/media/v4l2-core/v4l2-ioctl.c:2152
 __video_do_ioctl+0xba2/0xf20 drivers/media/v4l2-core/v4l2-ioctl.c:3046
 video_usercopy+0x3fb/0x14a0 drivers/media/v4l2-core/v4l2-ioctl.c:3387
 v4l2_ioctl+0x1b9/0x250 drivers/media/v4l2-core/v4l2-dev.c:364
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x199/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc39b09442d
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b4 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc39c269048 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fc39b1cc0a0 RCX: 00007fc39b09442d
RDX: 0000000020000080 RSI: 00000000c058565d RDI: 0000000000000003
RBP: 00007fc39b1014b8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fc39b100b51
R13: 000000000000000b R14: 00007fc39b1cc0a0 R15: 00007fc39c249000
 </TASK>

Modules linked in:
CPU: 1 PID: 12030 Comm: syz-executor Not tainted 6.5.0-rc6 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:get_vaddr_frames
drivers/media/common/videobuf2/frame_vector.c:63 [inline]
RIP: 0010:get_vaddr_frames+0x1fd/0x210
drivers/media/common/videobuf2/frame_vector.c:36
Code: 50 71 fb e9 06 ff ff ff e8 70 50 71 fb e9 cd fe ff ff e8 e6 83
21 fb 48 c7 c7 20 c5 b6 8a c6 05 e1 19 a1 07 01 e8 e3 87 e9 fa <0f> 0b
e9 53 ff ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 90 41 57 41
RSP: 0018:ffffc90005b57818 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffffc9000d800000 RCX: ffffc90003181000
RDX: 0000000000040000 RSI: ffffffff81487083 RDI: 0000000000000001
RBP: ffffc9000d800004 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
R13: 00000000ffffffb5 R14: ffffffffff600000 R15: ffff888018a8c800
FS:  00007fc39c269640(0000) GS:ffff888135c00000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc39c268f98 CR3: 000000010b298000 CR4: 0000000000750ee0
PKRU: 55555554
Call Trace:
 <TASK>
 vb2_create_framevec+0x60/0xd0
drivers/media/common/videobuf2/videobuf2-memops.c:52
 vb2_vmalloc_get_userptr+0x133/0x530
drivers/media/common/videobuf2/videobuf2-vmalloc.c:89
 __prepare_userptr.constprop.0+0x6a8/0x1610
drivers/media/common/videobuf2/videobuf2-core.c:1180
 __buf_prepare+0x623/0x810 drivers/media/common/videobuf2/videobuf2-core.c:=
1422
 vb2_core_prepare_buf+0xe0/0x330
drivers/media/common/videobuf2/videobuf2-core.c:1561
 vb2_prepare_buf+0xff/0x180 drivers/media/common/videobuf2/videobuf2-v4l2.c=
:738
 v4l2_m2m_prepare_buf+0xe4/0x1e0 drivers/media/v4l2-core/v4l2-mem2mem.c:823
 v4l_prepare_buf drivers/media/v4l2-core/v4l2-ioctl.c:2158 [inline]
 v4l_prepare_buf+0x92/0xc0 drivers/media/v4l2-core/v4l2-ioctl.c:2152
 __video_do_ioctl+0xba2/0xf20 drivers/media/v4l2-core/v4l2-ioctl.c:3046
 video_usercopy+0x3fb/0x14a0 drivers/media/v4l2-core/v4l2-ioctl.c:3387
 v4l2_ioctl+0x1b9/0x250 drivers/media/v4l2-core/v4l2-dev.c:364
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x199/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc39b09442d
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b4 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc39c269048 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fc39b1cc0a0 RCX: 00007fc39b09442d
RDX: 0000000020000080 RSI: 00000000c058565d RDI: 0000000000000003
RBP: 00007fc39b1014b8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fc39b100b51
R13: 000000000000000b R14: 00007fc39b1cc0a0 R15: 00007fc39c249000
 </TASK>
Kernel panic - not syncing: kernel: panic_on_warn set ...
CPU: 1 PID: 12030 Comm: syz-executor Not tainted 6.5.0-rc6 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd5/0x150 lib/dump_stack.c:106
 panic+0x67e/0x730 kernel/panic.c:340
 check_panic_on_warn+0xad/0xb0 kernel/panic.c:236
 __warn+0xee/0x390 kernel/panic.c:673
 __report_bug lib/bug.c:199 [inline]
 report_bug+0x2d9/0x500 lib/bug.c:219
 handle_bug+0x3c/0x70 arch/x86/kernel/traps.c:326
 exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:347
 asm_exc_invalid_op+0x16/0x20 arch/x86/include/asm/idtentry.h:568
RIP: 0010:get_vaddr_frames
drivers/media/common/videobuf2/frame_vector.c:63 [inline]
RIP: 0010:get_vaddr_frames+0x1fd/0x210
drivers/media/common/videobuf2/frame_vector.c:36
Code: 50 71 fb e9 06 ff ff ff e8 70 50 71 fb e9 cd fe ff ff e8 e6 83
21 fb 48 c7 c7 20 c5 b6 8a c6 05 e1 19 a1 07 01 e8 e3 87 e9 fa <0f> 0b
e9 53 ff ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 90 41 57 41
RSP: 0018:ffffc90005b57818 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffffc9000d800000 RCX: ffffc90003181000
RDX: 0000000000040000 RSI: ffffffff81487083 RDI: 0000000000000001
RBP: ffffc9000d800004 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
R13: 00000000ffffffb5 R14: ffffffffff600000 R15: ffff888018a8c800
 vb2_create_framevec+0x60/0xd0
drivers/media/common/videobuf2/videobuf2-memops.c:52
 vb2_vmalloc_get_userptr+0x133/0x530
drivers/media/common/videobuf2/videobuf2-vmalloc.c:89
 __prepare_userptr.constprop.0+0x6a8/0x1610
drivers/media/common/videobuf2/videobuf2-core.c:1180
 __buf_prepare+0x623/0x810 drivers/media/common/videobuf2/videobuf2-core.c:=
1422
 vb2_core_prepare_buf+0xe0/0x330
drivers/media/common/videobuf2/videobuf2-core.c:1561
 vb2_prepare_buf+0xff/0x180 drivers/media/common/videobuf2/videobuf2-v4l2.c=
:738
 v4l2_m2m_prepare_buf+0xe4/0x1e0 drivers/media/v4l2-core/v4l2-mem2mem.c:823
 v4l_prepare_buf drivers/media/v4l2-core/v4l2-ioctl.c:2158 [inline]
 v4l_prepare_buf+0x92/0xc0 drivers/media/v4l2-core/v4l2-ioctl.c:2152
 __video_do_ioctl+0xba2/0xf20 drivers/media/v4l2-core/v4l2-ioctl.c:3046
 video_usercopy+0x3fb/0x14a0 drivers/media/v4l2-core/v4l2-ioctl.c:3387
 v4l2_ioctl+0x1b9/0x250 drivers/media/v4l2-core/v4l2-dev.c:364
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x199/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc39b09442d
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b4 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc39c269048 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fc39b1cc0a0 RCX: 00007fc39b09442d
RDX: 0000000020000080 RSI: 00000000c058565d RDI: 0000000000000003
RBP: 00007fc39b1014b8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fc39b100b51
R13: 000000000000000b R14: 00007fc39b1cc0a0 R15: 00007fc39c249000
 </TASK>
Dumping ftrace buffer:
   (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 1 seconds..
