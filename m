Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086B17AA747
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 05:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjIVDU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 23:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjIVDU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 23:20:56 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35F3194
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 20:20:49 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53317e29b00so10669a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 20:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695352848; x=1695957648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDuF2lwHM47qlM2DggQvRg258/WCfsteflPgIak6C9c=;
        b=1FNfawhYe+bJHQBRDeFljhPMZyf0WTsvqNUhd3/HYe/wLNTaQSz2/NA9lTJJne/zsi
         YOZwnw9W5QjxdcoghOnEWGwEfLNt4Xqfvou9xf5UqiImimc2uyfpUYZEQiuWxxdRJ2k1
         qsnzCVhh1uKrJ3cenb6MsKfpZOzN3WWiqqqyGzrZLf1WG6y5wNO9pvDa5hraBWSRzdO3
         dOjOMSIxq4yU+SVKFnrMJAARIZO2cAEYj/ik0dUw/bsiPz+JDttpJFfS1lGiBTgrw623
         t8upPa4JL1KA1mUAzwpVi30tyCLE42YKG9hTcHE1sifuTdEQUlh9+B/fk6G2aajwnjf6
         5jwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695352848; x=1695957648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gDuF2lwHM47qlM2DggQvRg258/WCfsteflPgIak6C9c=;
        b=LHVxZFfwYp9NBcTeIpiOoesZm1n+UvFzunwLPgmGd278r37IeVJWwXHTFLJcSLojW0
         6RVUh+im40FNYeT2BsNIQ3Hglx+mKIqlH8OsVkHqNv9+Sx5QsUln7+8106ov6QsM2eYn
         SMO1fohlEsotetW7h8GlbS+Zt5GhgHyKJSRpd5TkNk4TKjY17eSFshuwur4IbHEecMSH
         vX7rtFslrmQwRP9wTRgzFu4a6YVhVkP0SX5d7Gd96X2Ijoy1fPvYsVLoaPLeilJG6ofj
         xXQxa5pbtBidim+iIvO6/OXnANvRXPPp9ej3iV2/kj3JZTiMct3S8O8k9OyzUuwPQM2K
         11Bg==
X-Gm-Message-State: AOJu0Yx8SYM8SJKsiGhE6yrqq3s4IWHTbGjMY0g/xuPL7X82RMxUwUKI
        uMwpIDTiA1IzdSfhJJ6jWa7f7T7WWKTie6o+9t5Qhg==
X-Google-Smtp-Source: AGHT+IH0x8NSZ0UtQtsCQzy4mNtj0KqdRsC+N4/IP3ICj31RZ+p6Xa96VuFUQcNPFAaqpX2oMerQNPSQ/f6vBAMr3QQ=
X-Received: by 2002:a50:cd5c:0:b0:523:b133:57fe with SMTP id
 d28-20020a50cd5c000000b00523b13357femr16387edj.1.1695352848190; Thu, 21 Sep
 2023 20:20:48 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004d83170605e16003@google.com> <CANn89iJwQ3TCSm+SMs=W90oThgRMLoiSAcTBJ9LH2AVsJY1NBA@mail.gmail.com>
 <18267b34-1dcf-08d5-5ba1-4f5162e6c43a@arista.com> <0d9983af-1483-d43e-810e-64ce6068a381@arista.com>
In-Reply-To: <0d9983af-1483-d43e-810e-64ce6068a381@arista.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 22 Sep 2023 05:20:34 +0200
Message-ID: <CANn89i+EUqRK9RsXn7Gu4iFiBcEZUzkMLmZ9vogFYxBbmaBHkQ@mail.gmail.com>
Subject: Re: [syzbot] [net?] memory leak in tcp_md5_do_add
To:     Dmitry Safonov <dima@arista.com>
Cc:     bpf@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+68662811b3d5f6695bcb@syzkaller.appspotmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 1:15=E2=80=AFAM Dmitry Safonov <dima@arista.com> wr=
ote:
>
> Hi Eric,
>
> On 9/21/23 18:01, Dmitry Safonov wrote:
> > On 9/21/23 17:59, Eric Dumazet wrote:
> >> On Thu, Sep 21, 2023 at 6:56=E2=80=AFPM syzbot
> >> <syzbot+68662811b3d5f6695bcb@syzkaller.appspotmail.com> wrote:
> >>>
> >>> Hello,
> >>>
> >>> syzbot found the following issue on:
> >>>
> >>> HEAD commit:    ee3f96b16468 Merge tag 'nfsd-6.3-1' of git://git.kern=
el.or..
> >>> git tree:       upstream
> >>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1312bba8c=
80000
> >>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df5733ca17=
57172ad
> >>> dashboard link: https://syzkaller.appspot.com/bug?extid=3D68662811b3d=
5f6695bcb
> >>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Bi=
nutils for Debian) 2.35.2
> >>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D105393a=
8c80000
> >>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1113917f4=
80000
> >>>
> >>> Downloadable assets:
> >>> disk image: https://storage.googleapis.com/syzbot-assets/29e7966ab711=
/disk-ee3f96b1.raw.xz
> >>> vmlinux: https://storage.googleapis.com/syzbot-assets/ae21b8e855de/vm=
linux-ee3f96b1.xz
> >>> kernel image: https://storage.googleapis.com/syzbot-assets/803ee0425a=
d6/bzImage-ee3f96b1.xz
> >>>
> >>> IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
> >>> Reported-by: syzbot+68662811b3d5f6695bcb@syzkaller.appspotmail.com
> >>>
> >>> executing program
> >>> BUG: memory leak
> >>> unreferenced object 0xffff88810a86f7a0 (size 32):
> >>>   comm "syz-executor325", pid 5099, jiffies 4294978342 (age 119.240s)
> >>>   hex dump (first 32 bytes):
> >>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >>>   backtrace:
> >>>     [<ffffffff81533d64>] kmalloc_trace+0x24/0x90 mm/slab_common.c:106=
1
> >>>     [<ffffffff840edaa0>] kmalloc include/linux/slab.h:580 [inline]
> >>>     [<ffffffff840edaa0>] tcp_md5sig_info_add net/ipv4/tcp_ipv4.c:1169=
 [inline]
> >>>     [<ffffffff840edaa0>] tcp_md5_do_add+0xa0/0x150 net/ipv4/tcp_ipv4.=
c:1240
> >>>     [<ffffffff84262c73>] tcp_v6_parse_md5_keys+0x253/0x4a0 net/ipv6/t=
cp_ipv6.c:671
> >>>     [<ffffffff840c720e>] do_tcp_setsockopt+0x40e/0x1360 net/ipv4/tcp.=
c:3720
> >>>     [<ffffffff840c81fb>] tcp_setsockopt+0x9b/0xa0 net/ipv4/tcp.c:3806
> >>>     [<ffffffff83d72a8b>] __sys_setsockopt+0x1ab/0x330 net/socket.c:22=
74
> >>>     [<ffffffff83d72c36>] __do_sys_setsockopt net/socket.c:2285 [inlin=
e]
> >>>     [<ffffffff83d72c36>] __se_sys_setsockopt net/socket.c:2282 [inlin=
e]
> >>>     [<ffffffff83d72c36>] __x64_sys_setsockopt+0x26/0x30 net/socket.c:=
2282
> >>>     [<ffffffff849ad699>] do_syscall_x64 arch/x86/entry/common.c:50 [i=
nline]
> >>>     [<ffffffff849ad699>] do_syscall_64+0x39/0xb0 arch/x86/entry/commo=
n.c:80
> >>>     [<ffffffff84a0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >>>
> >>> BUG: memory leak
> >>> unreferenced object 0xffff88811225ccc0 (size 192):
> >>>   comm "syz-executor325", pid 5099, jiffies 4294978342 (age 119.240s)
> >>>   hex dump (first 32 bytes):
> >>>     00 00 00 00 00 00 00 00 22 01 00 00 00 00 ad de  ........".......
> >>>     22 0a 80 00 fe 80 00 00 00 00 00 00 00 00 00 00  "...............
> >>>   backtrace:
> >>>     [<ffffffff8153444a>] __do_kmalloc_node mm/slab_common.c:966 [inli=
ne]
> >>>     [<ffffffff8153444a>] __kmalloc+0x4a/0x120 mm/slab_common.c:980
> >>>     [<ffffffff83d75c15>] kmalloc include/linux/slab.h:584 [inline]
> >>>     [<ffffffff83d75c15>] sock_kmalloc net/core/sock.c:2635 [inline]
> >>>     [<ffffffff83d75c15>] sock_kmalloc+0x65/0xa0 net/core/sock.c:2624
> >>>     [<ffffffff840eb9bb>] __tcp_md5_do_add+0xcb/0x300 net/ipv4/tcp_ipv=
4.c:1212
> >>>     [<ffffffff840eda67>] tcp_md5_do_add+0x67/0x150 net/ipv4/tcp_ipv4.=
c:1253
> >>>     [<ffffffff84262c73>] tcp_v6_parse_md5_keys+0x253/0x4a0 net/ipv6/t=
cp_ipv6.c:671
> >>>     [<ffffffff840c720e>] do_tcp_setsockopt+0x40e/0x1360 net/ipv4/tcp.=
c:3720
> >>>     [<ffffffff840c81fb>] tcp_setsockopt+0x9b/0xa0 net/ipv4/tcp.c:3806
> >>>     [<ffffffff83d72a8b>] __sys_setsockopt+0x1ab/0x330 net/socket.c:22=
74
> >>>     [<ffffffff83d72c36>] __do_sys_setsockopt net/socket.c:2285 [inlin=
e]
> >>>     [<ffffffff83d72c36>] __se_sys_setsockopt net/socket.c:2282 [inlin=
e]
> >>>     [<ffffffff83d72c36>] __x64_sys_setsockopt+0x26/0x30 net/socket.c:=
2282
> >>>     [<ffffffff849ad699>] do_syscall_x64 arch/x86/entry/common.c:50 [i=
nline]
> >>>     [<ffffffff849ad699>] do_syscall_64+0x39/0xb0 arch/x86/entry/commo=
n.c:80
> >>>     [<ffffffff84a0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >>>
> >>>
> >>>
> >>> ---
> >>> This report is generated by a bot. It may contain errors.
> >>> See https://goo.gl/tpsmEJ for more information about syzbot.
> >>> syzbot engineers can be reached at syzkaller@googlegroups.com.
> >>>
> >>> syzbot will keep track of this issue. See:
> >>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >>>
> >>> If the bug is already fixed, let syzbot know by replying with:
> >>> #syz fix: exact-commit-title
> >>>
> >>> If you want syzbot to run the reproducer, reply with:
> >>> #syz test: git://repo/address.git branch-or-commit-hash
> >>> If you attach or paste a git patch, syzbot will apply it before testi=
ng.
> >>>
> >>> If you want to overwrite bug's subsystems, reply with:
> >>> #syz set subsystems: new-subsystem
> >>> (See the list of subsystem names on the web dashboard)
> >>>
> >>> If the bug is a duplicate of another bug, reply with:
> >>> #syz dup: exact-subject-of-another-report
> >>>
> >>> If you want to undo deduplication, reply with:
> >>> #syz undup
> >>
> >> Dmitry, please take a look at this bug, we need to fix it before your
> >> patch series.
> >
> > Sure, seems reasonable to me to fix before merging something on top.
>
> It seems to me that it's related to a race between RCU grace period and
> kmemleak scan period. There seems to be a patch [1] that likely fixes
> that, albeit I couldn't verify it as all my attempts to reproduce syzbot
> issue produced only unrelated to TCP-MD5 log:
>

I doubt this, looking at the repro, which seems to abuse a not often
used feature of TCP (self connect)

# https://syzkaller.appspot.com/bug?id=3D323165b5fe193114de7a3a6a8bd16cf3a3=
c36ecf
# See https://goo.gl/kgGztJ for information about syzkaller reproducers.
#{"repeat":true,"procs":1,"slowdown":1,"sandbox":"none","sandbox_arg":0,"le=
ak":true,"netdev":true,"close_fds":true,"usb":true}
r0 =3D socket$inet6_tcp(0xa, 0x1, 0x0)
setsockopt$inet6_tcp_TCP_MD5SIG(r0, 0x6, 0xe,
&(0x7f0000000040)=3D{@in6=3D{{0xa, 0x0, 0x0, @local}}, 0x0, 0x0, 0x22,
0x0, "b05423587c18814d6b1a5f25671d09815a4687d637ffc958defc671aad3d4de8ac7d8=
8560c759d600ab650c07ef0ef162b199da0d017fe6f0ae40cfb4e241cf9a990f20f6b8c2c07=
0a61cfad8a2d2600"},
0xd8)
connect$inet6(r0, &(0x7f0000000180)=3D{0xa, 0x4001, 0x0, @ipv4=3D{'\x00',
'\xff\xff', @remote}}, 0x1c)
dup(0xffffffffffffffff)
setsockopt$SO_BINDTODEVICE(r0, 0x1, 0x19,
&(0x7f00000001c0)=3D'ip6_vti0\x00', 0xff4a)



You could not have KMEMLEAK in the kernel, and run the repro a thousand tim=
es.

Then compare /proc/slabinfo before/after.
