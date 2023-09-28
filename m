Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A3F7B10CF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 04:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjI1Cb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 22:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjI1CbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 22:31:25 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61339193
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 19:31:19 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2bff936e10fso158713021fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 19:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695868277; x=1696473077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=segOWYyTX08bYreuQQ5J+Y01iLmqZ1sgT3j3AnAFiyc=;
        b=nnex0X7lXeynhQW9L8KaNoCL3Vy2tGshO/41nqIA0u4x17Pj4xAGB5WjjqMsgmZ/Kd
         QRT+B/U97es2pKlC9NpaDIB8uc3ebwYzmlzuQreqkhllqxleEsXCvAjwINooqUvzVjCa
         rt75VmklGSWrTITpUDJvBoz7y6IhjtlaugbMfTYLfAxNhop0GI1cWiaqha1FXxsgPa9r
         NU5U/EJ46PElyhPf4xyq7WZ/swDVKbGyZDcClprOKKJ/5xC8idA+Rx0+kWlPba/XY/0w
         rx2Fs5NU0zVVH3FbRKGR5hDu/0+kUIcz6R9IBr2rO9fHLsjWDnMNkChi1A48auyxSTmE
         mGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695868277; x=1696473077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=segOWYyTX08bYreuQQ5J+Y01iLmqZ1sgT3j3AnAFiyc=;
        b=bsBLGaVTu0+vGSyWMwbQfNVtXXIR1nXioafbwTPD22kJ+SlwHRWhWlTeOZg8D95aWB
         7P6hxLkbzDP9UGFftkf681MxZmgqdjCbvmzkX4sQU9yZN2z0ZTOv9ZQYMEvrbXf6dXbg
         xB7vK3vADSiB0epeOvQUGE1qd3CLA27baTc0UYaXxT88uFDvR/v0sG8ZG6T2TTDTmLAj
         m2ilfVxK7NSXeskg9N1jbFntmNI6ECt0HGVNRoW3oIpccZaGpOhJrw1bMyn+q/QmCEAg
         JNqChY65ep3c3ozWDJoVRr1g85HOByPcZjSY9Tii+uLllb9H52DC9MV0MYWXZpd1zgYY
         Gwkg==
X-Gm-Message-State: AOJu0YxQRybJPED4/D83lJ23t9yPFsOfXh0dmA9ldzwm8MRC98kMsJeh
        YmK8xl4WRW8W2g57dmxALCEZ1uRK3PFJRzmdcuHXEgWjI0lhGxQY
X-Google-Smtp-Source: AGHT+IHi/EPcGCfD3FfOgP12BK8hsWHLhm1sfzNqdI5oDcTIPkVysvd8oI5cvINweRRqn5KBg1AC1gDf02M/aYTEUG0=
X-Received: by 2002:a19:4f4a:0:b0:504:b84f:7b19 with SMTP id
 a10-20020a194f4a000000b00504b84f7b19mr472105lfk.20.1695868276925; Wed, 27 Sep
 2023 19:31:16 -0700 (PDT)
MIME-Version: 1.0
From:   Yikebaer Aizezi <yikebaer61@gmail.com>
Date:   Thu, 28 Sep 2023 10:31:05 +0800
Message-ID: <CALcu4rbT+fMVNaO_F2izaCT+e7jzcAciFkOvk21HGJsmLcUuwQ@mail.gmail.com>
Subject: WARNING in vma_merge
To:     akpm@linux-foundation.org, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org
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

When using Healer to fuzz the Linux-6.6-rc3,  the following crash
was triggered.

HEAD commit: 6465e260f48790807eef06b583b38ca9789b6072 ( Linux 6.6-rc3=EF=BC=
=89
git tree: upstream

console output:
https://drive.google.com/file/d/1buerWpksX6CT-OKEQR74FqOO0YffAqtg/view?usp=
=3Ddrive_link
kernel config:https://drive.google.com/file/d/19l-irNJwbbXbjirevwkZpA67Wfw5=
DyOr/view?usp=3Ddrive_link
C reproducer:https://drive.google.com/file/d/1KDia7KFRB8cAuSikuZ2UCtWvpW69v=
bmJ/view?usp=3Ddrive_link
Syzlang reproducer:
https://drive.google.com/file/d/11Pbt5sdyZrqlMg35Go1dlH8IVBQjRKAI/view?usp=
=3Ddrive_link

My local Linux repository is a few commits behind the main branch, so
I pulled the latest branch and validated the crash on it. The issue
still persists.

If you fix this issue, please add the following tag to the commit:
Reported-by: Yikebaer Aizezi <yikebaer61@gmail.com>

------------[ cut here ]------------
WARNING: CPU: 2 PID: 261982 at mm/mmap.c:912 vma_merge+0x32e/0x3a20
mm/mmap.c:912
Modules linked in:
CPU: 2 PID: 261982 Comm: syz-executor.2 Not tainted 6.6.0-rc3-g6465e260f487=
 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:vma_merge+0x32e/0x3a20 mm/mmap.c:912
Code: 80 3c 02 00 0f 85 1d 2e 00 00 48 8b 04 24 48 89 de 4c 8b 30 4c
89 f7 e8 20 73 c0 ff 49 39 de 0f 84 ce 16 00 00 e8 32 77 c0 ff <0f> 0b
e8 2b 77 c0 ff 4c 89 fe 48 89 df e8 00 73 c0 ff 4c 39 fb 0f
RSP: 0018:ffffc9001031fc10 EFLAGS: 00010212
RAX: 00000000000003e1 RBX: 0000000020ffc000 RCX: ffffc90003931000
RDX: 0000000000040000 RSI: ffffffff81c1631e RDI: 0000000000000006
RBP: ffff88802526c400 R08: 0000000000000006 R09: 0000000020ff9000
R10: 0000000020ffc000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000020ff9000 R15: 0000000020ffe000
FS:  00007f1220e18640(0000) GS:ffff888063d00000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7edcef66e4 CR3: 0000000021ae1000 CR4: 0000000000750ee0
PKRU: 55555554
Call Trace:
 <TASK>
 mbind_range+0x299/0x560 mm/mempolicy.c:834
 __do_sys_set_mempolicy_home_node+0x4d3/0x830 mm/mempolicy.c:1561
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f122008eced
Code: c3 e8 97 2b 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1220e18028 EFLAGS: 00000246 ORIG_RAX: 00000000000001c2
RAX: ffffffffffffffda RBX: 00007f12201cbf80 RCX: 00007f122008eced
RDX: 0000000000000000 RSI: 0000000000004000 RDI: 0000000020ffa000
RBP: 00007f12200f04a6 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f12201cbf80 R15: 00007f1220df8000
 </TASK>
