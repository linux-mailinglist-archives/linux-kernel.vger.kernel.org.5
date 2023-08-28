Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F59278AEF3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 13:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbjH1LgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 07:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbjH1Lfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 07:35:39 -0400
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049C0B3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 04:35:35 -0700 (PDT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1bf525c269cso26875915ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 04:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693222534; x=1693827334;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I7zQby2DSTpxlt/4X99olAoqXWPNxLDthtywLjuy2Fc=;
        b=AiEUp8GSx6SO0ro4yD/yL7SoZc67PFgyOdZxqPhEjYyk1mxUCCRfcQnp5z2d3tcS8O
         bYQJuTdYkJrIrJYYHB1K8OaMzvraZ8njRr+HXyZwfM/3lXZMqOUiogvpv358M1s9etMS
         UI5XOraqlOpvu3gdIWGqSqbr0Im7RAdAPKt3XoT1tN98Xa8Y6ApUimzX7DhWeIQ3NCFJ
         Lo46YZHGEhszZ5ApT8NOKn+iN82phnZ8te7ln0jyKYBJsuVK1ijp3zvtktTsCgXN4o5o
         hci9lzKuF2pMvIfo6hNOESfWEMWfuONvOCtGmeQRq69zyhwSPD2OD9DIdrawcI+04GhQ
         YcGw==
X-Gm-Message-State: AOJu0YzpQYLbOdfeAxrLMrmCdHBk5EDegshhQnS1mraSC4u6HJ6p3WsI
        JtRVVPXYEDW4yEZAaSA3A9q96Gu3d5rQzS4m9vU4OJ2ZQ4w/
X-Google-Smtp-Source: AGHT+IGYLpxnhO3sGKWxwaNSpvKP4moqd75eguTo4kqjduTscb3Ce99Hz+6y87ZAOAGPCP5AtwdxTRgzb6+ZIKRLYjUI5Nfhuh8i
MIME-Version: 1.0
X-Received: by 2002:a17:902:f683:b0:1bb:e7ce:17d9 with SMTP id
 l3-20020a170902f68300b001bbe7ce17d9mr8972219plg.6.1693222534482; Mon, 28 Aug
 2023 04:35:34 -0700 (PDT)
Date:   Mon, 28 Aug 2023 04:35:34 -0700
In-Reply-To: <20230828105904.3914-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b192c80603fa17c9@google.com>
Subject: Re: [syzbot] [kernel?] general protection fault in nfc_register_device
From:   syzbot <syzbot+bdfb03b1ec8b342c12cb@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in nfc_register_device

RBP: 00007fad795a4120 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 000000000000000b R14: 00007fad7899bf80 R15: 00007fffcac52128
 </TASK>
general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 PID: 5480 Comm: syz-executor.0 Not tainted 6.5.0-rc7-next-20230825-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:strchr+0x1b/0xb0 lib/string.c:329
Code: ad ac f7 48 8b 74 24 08 48 8b 14 24 eb 89 90 f3 0f 1e fa 48 b8 00 00 00 00 00 fc ff df 48 89 fa 55 48 c1 ea 03 53 48 83 ec 10 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 51 0f b6 07 89
RSP: 0018:ffffc90004def630 EFLAGS: 00010286
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000025 RDI: 0000000000000000
RBP: ffffc90004def6c0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffc90004def6c0
R13: 0000000000000cc0 R14: ffff8881413d4a00 R15: 0000000000000001
FS:  00007fad795a46c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fad795a3ff8 CR3: 00000000294b2000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kvasprintf_const+0x25/0x190 lib/kasprintf.c:45
 kobject_set_name_vargs+0x5a/0x130 lib/kobject.c:272
 kobject_add_varg lib/kobject.c:366 [inline]
 kobject_add+0x12a/0x240 lib/kobject.c:424
 device_add+0x2a1/0x1aa0 drivers/base/core.c:3562
 nfc_register_device+0x41/0x3c0 net/nfc/core.c:1118
 nci_register_device+0x7f4/0xb80 net/nfc/nci/core.c:1257
 virtual_ncidev_open+0x147/0x220 drivers/nfc/virtual_ncidev.c:148
 misc_open+0x3da/0x4c0 drivers/char/misc.c:165
 chrdev_open+0x277/0x700 fs/char_dev.c:414
 do_dentry_open+0x88b/0x1730 fs/open.c:929
 do_open fs/namei.c:3639 [inline]
 path_openat+0x19af/0x29c0 fs/namei.c:3796
 do_filp_open+0x1de/0x430 fs/namei.c:3823
 do_sys_openat2+0x176/0x1e0 fs/open.c:1422
 do_sys_open fs/open.c:1437 [inline]
 __do_sys_openat fs/open.c:1453 [inline]
 __se_sys_openat fs/open.c:1448 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1448
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fad7887cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fad795a40c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007fad7899bf80 RCX: 00007fad7887cae9
RDX: 0000000000000002 RSI: 0000000020000000 RDI: ffffffffffffff9c
RBP: 00007fad795a4120 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 000000000000000b R14: 00007fad7899bf80 R15: 00007fffcac52128
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:strchr+0x1b/0xb0 lib/string.c:329
Code: ad ac f7 48 8b 74 24 08 48 8b 14 24 eb 89 90 f3 0f 1e fa 48 b8 00 00 00 00 00 fc ff df 48 89 fa 55 48 c1 ea 03 53 48 83 ec 10 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 51 0f b6 07 89
RSP: 0018:ffffc90004def630 EFLAGS: 00010286
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000025 RDI: 0000000000000000
RBP: ffffc90004def6c0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffc90004def6c0
R13: 0000000000000cc0 R14: ffff8881413d4a00 R15: 0000000000000001
FS:  00007fad795a46c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff66020268 CR3: 00000000294b2000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	ad                   	lods   %ds:(%rsi),%eax
   1:	ac                   	lods   %ds:(%rsi),%al
   2:	f7 48 8b 74 24 08 48 	testl  $0x48082474,-0x75(%rax)
   9:	8b 14 24             	mov    (%rsp),%edx
   c:	eb 89                	jmp    0xffffff97
   e:	90                   	nop
   f:	f3 0f 1e fa          	endbr64
  13:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1a:	fc ff df
  1d:	48 89 fa             	mov    %rdi,%rdx
  20:	55                   	push   %rbp
  21:	48 c1 ea 03          	shr    $0x3,%rdx
  25:	53                   	push   %rbx
  26:	48 83 ec 10          	sub    $0x10,%rsp
* 2a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax <-- trapping instruction
  2e:	48 89 fa             	mov    %rdi,%rdx
  31:	83 e2 07             	and    $0x7,%edx
  34:	38 d0                	cmp    %dl,%al
  36:	7f 04                	jg     0x3c
  38:	84 c0                	test   %al,%al
  3a:	75 51                	jne    0x8d
  3c:	0f b6 07             	movzbl (%rdi),%eax
  3f:	89                   	.byte 0x89


Tested on:

commit:         62693208 Add linux-next specific files for 20230825
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15ac67b7a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8a8c992a790e5073
dashboard link: https://syzkaller.appspot.com/bug?extid=bdfb03b1ec8b342c12cb
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1254f9eba80000

