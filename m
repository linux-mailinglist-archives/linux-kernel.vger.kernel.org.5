Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB5E7BDA73
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 13:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346336AbjJIL4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 07:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346332AbjJIL4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 07:56:35 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB18D6;
        Mon,  9 Oct 2023 04:56:34 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-7b0e19acda7so1365096241.0;
        Mon, 09 Oct 2023 04:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696852593; x=1697457393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIGxuY3+upQpP8Gv0wqLqjjy082uWIWVTqA7UE+bf5g=;
        b=jmFwDtS9qewj9ZmYMPTvqgG+1wx4WbSWnQyEmTxJMVpYrH5jXa4U2rY+dEHfXKmjiD
         DgdVf6idlldgJUC87HyZjJCeSr+80gtDuTTcDU2sbULX20LFMzi5lyMOFC2JG+qBp2q0
         oWUdLtaJa2N5M7oP20o5NoHa5fnLutYFU2PVsvzvxl+oqZa8zybQZNog3JARlwM34tEO
         ZmoSkHaaMFHkIziYzJ813wyIp7uTdLxPBtqhlArsUQqlw/QX7YbYWQWYJPrDFxhfnIoW
         naqSp4c4Y3mVhpEs/Hq/IpEjtPXYs8eJjSdKeMMHNLp+jov1dAYrDz90RJXvYHPi9o67
         9Hpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696852593; x=1697457393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RIGxuY3+upQpP8Gv0wqLqjjy082uWIWVTqA7UE+bf5g=;
        b=wjI8WLNqmX8Vl4Wy16evHc4YyWEO3Loe8ChCbTebC7X1236t6FlVu1EQG1xVdsfFxN
         0bYX4UU8sCHPku+vcHrE8rPs5BZPkT9oC4FTtUVT+J1peSw2UfMIMf5mwtrpK599jaQB
         KXGQv8UXXtfzCZeM5Ac+i7S0Dqs0YRPDRYgeN7yOKb6r4nukYQk51cqdeNddUBx9wUBF
         olfF40O8bqfhL2+VXQuh85+QrCRSPvvR/NdUKSf7PA1Z7Ln1FbrAMgO3HsCeZcuAI+t/
         AtEOC3/L2iZpR1w6H4oLI9xk257al0YP9aa7+bZm4fTBeFXFUs2Upp8pMk2JvVZ8mmWk
         f34A==
X-Gm-Message-State: AOJu0YyMTf1i2MvAXPQeoGCsmfqDLYPUKRwwxqjGrxsrt/5bSQWY+ZX6
        cqBtVuoJJ7wdHvcQCoJdMj1xEJe9/onwTBeQ3qQ=
X-Google-Smtp-Source: AGHT+IEm6wO1aFM9O9F1anqFu20JUwXRkPmddLsSjM5d+Ris5W+1ujhOqLDjhsBLx6WwEM0Rd2mjzSluR6X/H3+PzV8=
X-Received: by 2002:a05:6102:3a46:b0:452:7232:5c22 with SMTP id
 c6-20020a0561023a4600b0045272325c22mr12751789vsu.18.1696852592926; Mon, 09
 Oct 2023 04:56:32 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000005039270605eb0b7f@google.com>
In-Reply-To: <0000000000005039270605eb0b7f@google.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 9 Oct 2023 04:55:55 -0700
Message-ID: <CAF=yD-JN5mXvwKjqB_PMs5UDSPtCwRodDGcEHf9-Q=d60_6G5Q@mail.gmail.com>
Subject: Re: [syzbot] [net?] WARNING in skb_checksum_help (2)
To:     syzbot <syzbot+01cdbc31e9c0ae9b33ac@syzkaller.appspotmail.com>
Cc:     andrew@daynix.com, davem@davemloft.net, edumazet@google.com,
        jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, stephen@networkplumber.org,
        syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 9:28=E2=80=AFPM syzbot
<syzbot+01cdbc31e9c0ae9b33ac@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    489fa31ea873 Merge branch 'work.misc' of git://git.kernel=
...
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D1012dbf0c8000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Da8fa629ede9e7=
b9
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D01cdbc31e9c0ae9=
b33ac
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binuti=
ls for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D130cfe18c80=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D10561350c8000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/2f2344129720/dis=
k-489fa31e.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/e1be11fcb953/vmlinu=
x-489fa31e.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/4549005e4fa5/b=
zImage-489fa31e.xz
>
> The issue was bisected to:
>
> commit 860b7f27b8f78564ca5a2f607e0820b2d352a562
> Author: Andrew Melnychenko <andrew@daynix.com>
> Date:   Wed Dec 7 11:35:57 2022 +0000
>
>     linux/virtio_net.h: Support USO offload in vnet header.
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D15cb9d50c8=
0000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D17cb9d50c8=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D13cb9d50c8000=
0
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+01cdbc31e9c0ae9b33ac@syzkaller.appspotmail.com
> Fixes: 860b7f27b8f7 ("linux/virtio_net.h: Support USO offload in vnet hea=
der.")
>
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 5082 at net/core/dev.c:3260 skb_checksum_help+0x4a2/=
0x600 net/core/dev.c:3260
> Modules linked in:
> CPU: 1 PID: 5082 Comm: syz-executor228 Not tainted 6.2.0-syzkaller-10827-=
g489fa31ea873 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 02/16/2023
> RIP: 0010:skb_checksum_help+0x4a2/0x600 net/core/dev.c:3260
> Code: e0 48 83 c4 28 5b 5d 41 5c 41 5d 41 5e 41 5f c3 e8 63 15 70 f9 48 8=
9 ef 41 bc ea ff ff ff e8 35 f9 ff ff eb d4 e8 4e 15 70 f9 <0f> 0b 0f b6 1d=
 88 29 4e 06 31 ff 89 de e8 4c 11 70 f9 84 db 0f 84
> RSP: 0018:ffffc90003b6f660 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 000000000000034a RCX: 0000000000000000
> RDX: ffff888024171d40 RSI: ffffffff8814b1f2 RDI: 0000000000000004
> RBP: ffff888079090780 R08: 0000000000000004 R09: 000000000000019a
> R10: 0000000000000348 R11: 0000000000000000 R12: ffff8880790907f4
> R13: 0000000000000000 R14: ffff888079090800 R15: 0000000000000348
> FS:  00005555559ed300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000002000f000 CR3: 0000000072c0b000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  netem_enqueue+0x2b57/0x35b0 net/sched/sch_netem.c:510
>  netem_enqueue+0x2050/0x35b0 net/sched/sch_netem.c:483
>  dev_qdisc_enqueue+0x46/0x3b0 net/core/dev.c:3773
>  __dev_xmit_skb net/core/dev.c:3862 [inline]
>  __dev_queue_xmit+0x236a/0x3db0 net/core/dev.c:4210
>  packet_snd net/packet/af_packet.c:3073 [inline]
>  packet_sendmsg+0x33aa/0x55d0 net/packet/af_packet.c:3104
>  sock_sendmsg_nosec net/socket.c:722 [inline]
>  sock_sendmsg+0xde/0x190 net/socket.c:745
>  __sys_sendto+0x23a/0x340 net/socket.c:2145
>  __do_sys_sendto net/socket.c:2157 [inline]
>  __se_sys_sendto net/socket.c:2153 [inline]
>  __x64_sys_sendto+0xe1/0x1b0 net/socket.c:2153
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7fa19dae7699
> Code: 28 c3 e8 4a 15 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fffb3262e28 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
> RAX: ffffffffffffffda RBX: 00007fffb3262e48 RCX: 00007fa19dae7699
> RDX: 000000000000fc13 RSI: 0000000020000280 RDI: 0000000000000003
> RBP: 0000000000000003 R08: 0000000000000000 R09: 000000000000002f
> R10: 0000000000000800 R11: 0000000000000246 R12: 00007fffb3262e50
> R13: 00007fffb3262e70 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>
> If the bug is already fixed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite bug's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the bug is a duplicate of another bug, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

One of two reports due to the introduction of SKB_GSO_UDP_L4.

I will make checks on udp gso packets coming in over virtio more strict.

[   25.057760] skb len=3D64521 headroom=3D2 headlen=3D1355 tailroom=3D0
[   25.057760] mac=3D(2,14) net=3D(16,826) trans=3D842
[   25.057760] shinfo(txflags=3D0 nr_frags=3D2 gso(size=3D344 type=3D131074=
 segs=3D0))
[   25.057760] csum(0x201034a ip_summed=3D3 complete_sw=3D0 valid=3D0
level=3D0 start=3D842 off=3D513)
[   25.057760] hash(0x0 sw=3D0 l4=3D0) proto=3D0x0800 pkttype=3D0 iif=3D0
[   25.075806] dev name=3Dlo feat=3D0x00000516401d7c69
[   25.079134] sk family=3D17 type=3D3 proto=3D0

This is clearly a bogus packet.

Checks to add, for starters:

1. udp gso packets coming over virtio must be held to the same
UDP_MAX_SEGMENTS limit as those generated by the local stack.

2. csum_offset should always be offsetof(struct udphdr, check).

3. checksum offload is mandatory.

I needed to patch skb_dump to get the csum_start and _offset fields.
