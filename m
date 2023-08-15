Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8525E77CEEF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237940AbjHOPSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237986AbjHOPRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:17:41 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5401991;
        Tue, 15 Aug 2023 08:17:36 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9a828c920so84222831fa.1;
        Tue, 15 Aug 2023 08:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692112655; x=1692717455;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DWD0RfABUTGcF4AzQT54lx9NYP3JMf1YOTydnYYLjg4=;
        b=egxXHnByZAY943nQhWw+5wTfGrj9c6ZJqR/hdsg1hZb66RN7j0i6QjWJkGvM1qDFAw
         jTMMfxhsJs/kH5TwGngJl1GIhhNrGuoK4knRbIdllMgmRFZFiMOKYd7XMsqj5qXMauL9
         zqDp1H8qdLNSued4K3oZNGi3mXASyk48t6Koh940Do7FAMq5ADTktwLg2duxw0w230st
         k1riVo+ZLZkob3JziWTGDITndxt52pQDXg1orr33QkAhm6At0+N4kB/zw6UvQpmbx+k8
         ckpDVUhbGpLhsPTG4/AMOCJY45aU+RFeVGJ0aEeow5hLNIG5fp0vP7lvX7dXSNRP2CUv
         /51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692112655; x=1692717455;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DWD0RfABUTGcF4AzQT54lx9NYP3JMf1YOTydnYYLjg4=;
        b=j/3+K4Q4Ym8BrZ/eWl8yRXWmK5o+gDUwGBHoVoHmuk1qYG0AWlBjpy6QeI5Ts0+b4C
         v71gNFtjLjodGDpT103FcF4hDgeVi/etXXJbdlNFyMYYLtdrRUzzdZSlvju5VM7pd7mF
         NJSm1xKQzg4eLYdOUDD9y2Suo2jGe6/Zuq4wrVAGaavJlbjUcecl9911qC3r7PtC2Sr9
         RiFjkSfO+G9gP3F7AaciFSOczk5LZaYUBX3TXzZKfM9TVGEgxlSWkLO1XaxBdoV0i7Cs
         iHKTkYPq/Oj9BV01d8NjscJJ8HzWXaB90FOHUmAnWAjPiXovsYUKnr2MnIhASpt1O25F
         /y2Q==
X-Gm-Message-State: AOJu0YyCqHP251ySEidyuX0gg5i5cpJjvSoCCMQX6lSsYssQTTsdPcy1
        dmQ7qMj5wc0U9lhDzoQbqfI3sYa39ZkCcx1Qiv8=
X-Google-Smtp-Source: AGHT+IFeQKHyRO2p4Uz1GgOy9LYH/6rsoKi4jtBf3TMVD8fG4qGG4ZzS/mX6E9UiGjPeAd5wl6Z4EDKW6Otk6VqcgIc=
X-Received: by 2002:a2e:9958:0:b0:2b9:ea6b:64b with SMTP id
 r24-20020a2e9958000000b002b9ea6b064bmr8956864ljj.37.1692112654688; Tue, 15
 Aug 2023 08:17:34 -0700 (PDT)
MIME-Version: 1.0
From:   Yikebaer Aizezi <yikebaer61@gmail.com>
Date:   Tue, 15 Aug 2023 23:17:22 +0800
Message-ID: <CALcu4ratoUmf_LvW1ExB_VWXmpMtBu0EY3y4SdawaKS1mSjq5g@mail.gmail.com>
Subject: WARNING in ip6_tnl_exit_batch_net
To:     davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
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
https://drive.google.com/file/d/1ltIU2bvgBY5RQd832oDuxrWz7JP7FbLi/view?usp=
=3Ddrive_link
kernel config:https://drive.google.com/file/d/1V8arEniPN_yA0gYKWFr-hCZR6AGF=
PpfB/view?usp=3Ddrive_link
C reproducer:https://drive.google.com/file/d/1bk8vG04VswMLyahjItM-Cmq86UKPu=
pmg/view?usp=3Ddrive_link
Syzlang reproducer:
https://drive.google.com/file/d/1ZhcjI74kh0UzAjXWbQSZTeCVM43wZ3Hq/view?usp=
=3Ddrive_link

If you fix this issue, please add the following tag to the commit:
Reported-by: Yikebaer Aizezi <yikebaer61@gmail.com>

------------[ cut here ]------------
WARNING: CPU: 0 PID: 11 at net/core/dev.c:10876
unregister_netdevice_many_notify+0x13eb/0x18a0 net/core/dev.c:10876
Modules linked in:
CPU: 0 PID: 11 Comm: kworker/u4:0 Not tainted 6.5.0-rc6 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:unregister_netdevice_many_notify+0x13eb/0x18a0 net/core/dev.c:108=
76
Code: b4 1a 00 00 48 c7 c6 00 89 f7 8a 48 c7 c7 40 89 f7 8a c6 05 3f
4c 56 06 01 e8 71 b9 9e f9 0f 0b e9 49 f7 ff ff e8


    55 b5 d6 f9 <0f> 0b e9 20 f7 ff ff e8 49 b5 d6 f9 0f 0b e9 5f f7
ff ff e8 6d 81
RSP: 0018:ffffc900000dfa40 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 000000000c15ba01 RCX: 0000000000000000
RDX: ffff88801405bc00 RSI: ffffffff87a9b59b RDI: 0000000000000001
RBP: ffff8880288d2900 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 000000000008e001 R12: 0000000000000000
R13: ffff8880288d2900 R14: ffff888027768000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888063c00000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055d3acdd9680 CR3: 0000000018876000 CR4: 0000000000750ef0
PKRU: 55555554
Call Trace:
 <TASK>
 ip6_tnl_exit_batch_net+0x579/0x6e0 net/ipv6/ip6_tunnel.c:2278
 ops_exit_list+0x125/0x170 net/core/net_namespace.c:175
 cleanup_net+0x4ea/0xb10 net/core/net_namespace.c:614
 process_one_work+0xa22/0x16e0 kernel/workqueue.c:2600
 worker_thread+0x679/0x10c0 kernel/workqueue.c:2751
 kthread+0x33a/0x430 kernel/kthread.c:389
 ret_from_fork+0x28/0x60 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>

Modules linked in:
CPU: 0 PID: 11 Comm: kworker/u4:0 Not tainted 6.5.0-rc6 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:unregister_netdevice_many_notify+0x13eb/0x18a0 net/core/dev.c:108=
76
Code: b4 1a 00 00 48 c7 c6 00 89 f7 8a 48 c7 c7 40 89 f7 8a c6 05 3f
4c 56 06 01 e8 71 b9 9e f9 0f 0b e9 49 f7 ff ff e8


    55 b5 d6 f9 <0f> 0b e9 20 f7 ff ff e8 49 b5 d6 f9 0f 0b e9 5f f7
ff ff e8 6d 81
RSP: 0018:ffffc900000dfa40 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 000000000c15ba01 RCX: 0000000000000000
RDX: ffff88801405bc00 RSI: ffffffff87a9b59b RDI: 0000000000000001
RBP: ffff8880288d2900 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 000000000008e001 R12: 0000000000000000
R13: ffff8880288d2900 R14: ffff888027768000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888063c00000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055d3acdd9680 CR3: 0000000018876000 CR4: 0000000000750ef0
PKRU: 55555554
Call Trace:
 <TASK>
 ip6_tnl_exit_batch_net+0x579/0x6e0 net/ipv6/ip6_tunnel.c:2278
 ops_exit_list+0x125/0x170 net/core/net_namespace.c:175
 cleanup_net+0x4ea/0xb10 net/core/net_namespace.c:614
 process_one_work+0xa22/0x16e0 kernel/workqueue.c:2600
 worker_thread+0x679/0x10c0 kernel/workqueue.c:2751
 kthread+0x33a/0x430 kernel/kthread.c:389
 ret_from_fork+0x28/0x60 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
Kernel panic - not syncing: kernel: panic_on_warn set ...
CPU: 0 PID: 11 Comm: kworker/u4:0 Not tainted 6.5.0-rc6 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Workqueue: netns cleanup_net
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
RIP: 0010:unregister_netdevice_many_notify+0x13eb/0x18a0 net/core/dev.c:108=
76
Code: b4 1a 00 00 48 c7 c6 00 89 f7 8a 48 c7 c7 40 89 f7 8a c6 05 3f
4c 56 06 01 e8 71 b9 9e f9 0f 0b e9 49 f7 ff ff e8


    55 b5 d6 f9 <0f> 0b e9 20 f7 ff ff e8 49 b5 d6 f9 0f 0b e9 5f f7
ff ff e8 6d 81
RSP: 0018:ffffc900000dfa40 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 000000000c15ba01 RCX: 0000000000000000
RDX: ffff88801405bc00 RSI: ffffffff87a9b59b RDI: 0000000000000001
RBP: ffff8880288d2900 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 000000000008e001 R12: 0000000000000000
R13: ffff8880288d2900 R14: ffff888027768000 R15: dffffc0000000000
 ip6_tnl_exit_batch_net+0x579/0x6e0 net/ipv6/ip6_tunnel.c:2278
 ops_exit_list+0x125/0x170 net/core/net_namespace.c:175
 cleanup_net+0x4ea/0xb10 net/core/net_namespace.c:614
 process_one_work+0xa22/0x16e0 kernel/workqueue.c:2600
 worker_thread+0x679/0x10c0 kernel/workqueue.c:2751
 kthread+0x33a/0x430 kernel/kthread.c:389
 ret_from_fork+0x28/0x60 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
Dumping ftrace buffer:
   (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 1 seconds..
