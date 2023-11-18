Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE9E7EFDCD
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 06:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjKRFNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 00:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKRFNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 00:13:08 -0500
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88585D57
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 21:13:05 -0800 (PST)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-28011e1cdcbso3242335a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 21:13:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700284385; x=1700889185;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vk10fpM+ANK8M2rcModIuCfSLpyIqRBlsh1ZSCXV64s=;
        b=N3jGM9FRq7heX0iKPpXKY+0kmcjUuyPEpVpUj2lKZM+2fOh32Q1Ycr6694uMsx3UwP
         zzEkBdzrYSf5ae5LOg8rrV5cb8oaDDJ+UixU3pzyEJrRzV0rLM6dCG3o9DXRpWLDF1b8
         +OoalJPOekIGjrBT9oZuvS8dG1XOOS5Qsk0K7ARZpshiX1CvCjrmMOra52UnXMXxrfBU
         fSVBBUL6ootGG5thdjEZB/EHGrlGC7XJvniJ/Inh/tESpRPKv5HMKj48C5rYXQRkS5Qe
         0cXAaj0v1o1z+wg6erq2UfKB6SzFewv5LILnSM0MT1woHNqdd0VyT3FBcBULAPKNvgHr
         xv+g==
X-Gm-Message-State: AOJu0Yx6XNSV2x/x72NmbphW+jxmmL4WZiPICSai78VPr3nrapp4wBlH
        0FUpK36irjmfNHBdX+OULO/Ct7WYjo+ycN/43nV3vpztXKxx
X-Google-Smtp-Source: AGHT+IHTueeJs7hYKRTEyD4m0ReeDtovPqMBBYP5iVlMaPvqZtL8ouUwjtv7fibxXd3eEpuq2h8GTCKV32Bc77vIiKzBpI8/x75p
MIME-Version: 1.0
X-Received: by 2002:a17:90a:62c8:b0:27d:e40a:96d3 with SMTP id
 k8-20020a17090a62c800b0027de40a96d3mr398320pjs.2.1700284385155; Fri, 17 Nov
 2023 21:13:05 -0800 (PST)
Date:   Fri, 17 Nov 2023 21:13:04 -0800
In-Reply-To: <tencent_72961A37384AFC744F774366863D91364409@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cb628c060a664eb0@google.com>
Subject: Re: [syzbot] [dri?] divide error in drm_mode_debug_printmodeline
From:   syzbot <syzbot+2e93e6fb36e6fdc56574@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
divide error in drm_mode_debug_printmodeline

mode: ffff888140bc9490, ht: 1344, vt: 806, c: 65000, vsc: 0, den: 1083264, num: 65000, drm_mode_vrefresh
mode: ffff88807c374000, ht: 128, vt: 32768, c: 128, vsc: 1024, den: 4294967296, num: 128, drm_mode_vrefresh
divide error: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5448 Comm: syz-executor.0 Not tainted 6.6.0-rc7-syzkaller-00142-g888cf78c29e2-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
RIP: 0010:drm_mode_vrefresh drivers/gpu/drm/drm_modes.c:1305 [inline]
RIP: 0010:drm_mode_debug_printmodeline+0x308/0x5d0 drivers/gpu/drm/drm_modes.c:60
Code: b4 8c 4c 8b 7c 24 30 41 57 55 e8 53 c9 e7 05 48 83 c4 18 44 89 f8 48 69 c8 e8 03 00 00 48 89 e8 48 d1 e8 48 01 c8 89 e9 31 d2 <48> f7 f1 49 89 c0 e9 81 fd ff ff 89 e9 80 e1 07 fe c1 38 c1 0f 8c
RSP: 0018:ffffc90004e1f8d0 EFLAGS: 00010246
RAX: 000000008001f400 RBX: ffff88807c374000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 0000000100000000 R08: ffffffff81711cfc R09: 1ffff920009c3e6c
R10: dffffc0000000000 R11: fffff520009c3e6d R12: dffffc0000000000
R13: 0000000000000080 R14: 1ffff1100f86e801 R15: 0000000000000080
FS:  00007fb08687c6c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb085b980c0 CR3: 000000007eb58000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 drm_mode_setcrtc+0x83b/0x1880 drivers/gpu/drm/drm_crtc.c:794
 drm_ioctl_kernel+0x349/0x4f0 drivers/gpu/drm/drm_ioctl.c:789
 drm_ioctl+0x636/0xb00 drivers/gpu/drm/drm_ioctl.c:892
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fb085a7cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb08687c0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fb085b9bf80 RCX: 00007fb085a7cae9
RDX: 0000000020000180 RSI: 00000000c06864a2 RDI: 0000000000000003
RBP: 00007fb085ac847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fb085b9bf80 R15: 00007ffe452acab8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:drm_mode_vrefresh drivers/gpu/drm/drm_modes.c:1305 [inline]
RIP: 0010:drm_mode_debug_printmodeline+0x308/0x5d0 drivers/gpu/drm/drm_modes.c:60
Code: b4 8c 4c 8b 7c 24 30 41 57 55 e8 53 c9 e7 05 48 83 c4 18 44 89 f8 48 69 c8 e8 03 00 00 48 89 e8 48 d1 e8 48 01 c8 89 e9 31 d2 <48> f7 f1 49 89 c0 e9 81 fd ff ff 89 e9 80 e1 07 fe c1 38 c1 0f 8c
RSP: 0018:ffffc90004e1f8d0 EFLAGS: 00010246
RAX: 000000008001f400 RBX: ffff88807c374000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 0000000100000000 R08: ffffffff81711cfc R09: 1ffff920009c3e6c
R10: dffffc0000000000 R11: fffff520009c3e6d R12: dffffc0000000000
R13: 0000000000000080 R14: 1ffff1100f86e801 R15: 0000000000000080
FS:  00007fb08687c6c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc82ccfc378 CR3: 000000007eb58000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	b4 8c                	mov    $0x8c,%ah
   2:	4c 8b 7c 24 30       	mov    0x30(%rsp),%r15
   7:	41 57                	push   %r15
   9:	55                   	push   %rbp
   a:	e8 53 c9 e7 05       	call   0x5e7c962
   f:	48 83 c4 18          	add    $0x18,%rsp
  13:	44 89 f8             	mov    %r15d,%eax
  16:	48 69 c8 e8 03 00 00 	imul   $0x3e8,%rax,%rcx
  1d:	48 89 e8             	mov    %rbp,%rax
  20:	48 d1 e8             	shr    %rax
  23:	48 01 c8             	add    %rcx,%rax
  26:	89 e9                	mov    %ebp,%ecx
  28:	31 d2                	xor    %edx,%edx
* 2a:	48 f7 f1             	div    %rcx <-- trapping instruction
  2d:	49 89 c0             	mov    %rax,%r8
  30:	e9 81 fd ff ff       	jmp    0xfffffdb6
  35:	89 e9                	mov    %ebp,%ecx
  37:	80 e1 07             	and    $0x7,%cl
  3a:	fe c1                	inc    %cl
  3c:	38 c1                	cmp    %al,%cl
  3e:	0f                   	.byte 0xf
  3f:	8c                   	.byte 0x8c


Tested on:

commit:         888cf78c Merge tag 'iommu-fix-v6.6-rc7' of git://git.k..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=146669b8e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f0d47f0e0359e88e
dashboard link: https://syzkaller.appspot.com/bug?extid=2e93e6fb36e6fdc56574
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10890c77680000

