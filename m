Return-Path: <linux-kernel+bounces-53824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B001784A702
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3E2A1C26BBF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E7F5F482;
	Mon,  5 Feb 2024 19:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGM9f7ZX"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9961C5F541;
	Mon,  5 Feb 2024 19:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707161772; cv=none; b=R90JhTt368AvqAALyxZzbEARZK0OPeuTSCjPu97RIcaGUvnROTlqxoCWFA8IkAvUs10GcFwWXSCXOHImdYN+nePz6HvOUtEJ4I4MqcnqO1Ysbrx3hhBApCRuj/0HrpJ0iGyKJ4l2pmEEMqoPm/n4cnpJJFPQKeLOijzOmReTtbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707161772; c=relaxed/simple;
	bh=gJbzs18/acjy43NodZVJxpUKbqu2JQrasjbqLq+tgn8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=YRtczszPJGSBqwcqMxcYhMeV5fQWyttpoXUl/I6eHFTQVvX6o2b9ptIpK36el0RMS7rkrz1q1s4xcn2yxEanOrq3kWEaQM2X8ZA9fCCF3ydVJ8MVJIAzDyDTL8N2QpIJdo8NV66AOOYP8FctT/0E+7mlKgEXhpeM/v4bdprwdrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGM9f7ZX; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-68c37bf73aaso23154346d6.2;
        Mon, 05 Feb 2024 11:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707161769; x=1707766569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hyKtLjISsgsA4Pc0uf3hvWpRXC7emZfo1RqZ5lH/KE0=;
        b=BGM9f7ZX8VyHCqwh06pHzfmk+med/WM8qYDXuj5puG/oBaUwxAts8wicYZW1aO5jWI
         nSCZBUGgQ5bRMTEuNrR8F+2uWOZnWHB9NWV2n8CG9Q2QtMS5xIKuchpxNJBuWQnJsyWP
         B0AE4qhjarEnnZoM6rX4fqUnWpReLqruUPuQPzLn7OtJO4QxWQkJppnN9AD0HslV4hse
         NieWWfYWw6QKxIvO3cMIfp1jXx4qcefIym6Te2zAMqZvEhmuXop4aS6e7fmLml/kHXhL
         i8ApihV2GwJMqIdim4bJumL6lFPNK4SaJ2Icc+8LheCHBITylb9iFmwL4bGXsrwmH4pP
         w57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707161769; x=1707766569;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hyKtLjISsgsA4Pc0uf3hvWpRXC7emZfo1RqZ5lH/KE0=;
        b=PbZCUYxKCnbfzNrmB4JItEUUetylTRLmeeNZuPzCCyVS0rNFgeP4TRKEHiCzlUx8D2
         BMQO27KQE+UrROMU0Pn7X+JhrNWQWxVD+eOxNCa0gb53ipYUZjMywSOXa1dG4dfsQrMt
         AKcMw82Rm81y565msz0R+zUJt0A1+/8ddWetEHvjeA3D2/aJG6YCCXKJom4wYCT83jAN
         yF3R2BUCDG+nfR1fX3GYGVOkp+K7UIymRP3pm823tfo1X/4f0LCyxOjzwixk2O8wvE9w
         sJt1S9gTcR6z+xoHib3A3uSeYWyWhgSm62kZh0WjnM62pHIdAaVQenRxjbp5kaqxVKv0
         CtgA==
X-Gm-Message-State: AOJu0YwobW5V5U6M/SmIcOgZgWq9OI/HQhqiz1LKeXOd8VMAvGaDP7Iv
	c+uB4Z2iCyuKgOCPoASF1SKBUxxP37GsLLYai91tr2PPuagZ5/vW
X-Google-Smtp-Source: AGHT+IFkYBnjxfUnYZFyHzALB8fb8u27KmrxjghwpTkp7fqbMqXpiU4XSlXPKpJAxBD4VhEftdvKiw==
X-Received: by 2002:ad4:5c4e:0:b0:68c:a48b:1837 with SMTP id a14-20020ad45c4e000000b0068ca48b1837mr438169qva.56.1707161769319;
        Mon, 05 Feb 2024 11:36:09 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUbuUCENedczyASvNvgOsZLGNELhJsJf54VqklTvrmDRQrN8mFrDocwp7r7k2AUb04QpPCzZUBHfvPwIAdwfIh0VBEnjAkAKj7dmqZXMEfhEgaHKwv7i9j4Ix+yhK9z6awxzyRwJj9Vr5O0WKC5MeTessBMSQd8yBF7pvkHAD1YuK8lhqKcNgQNXTlKvXqfdCMjzynwyUEg2LaJ5M2MbJxoRFhzYSxiNiGlIKNP54bHPU4ZxUrezdxw+Jvbj4+QllSfMoXlM4jtpiJHzyEX0Oxs7Hb/oPHJdYVht+MLx1klC5XWqaj8zHOhbUCsuiQmnxbxE+gXFCN2WNLoMsHRMLW2Fw==
Received: from localhost (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id lx1-20020a0562145f0100b006869e0eed00sm273122qvb.26.2024.02.05.11.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 11:36:09 -0800 (PST)
Date: Mon, 05 Feb 2024 14:36:08 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Chenyuan Yang <chenyuan0y@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 dsahern@kernel.org, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 syzkaller@googlegroups.com, 
 Zijie Zhao <zzjas98@gmail.com>
Message-ID: <65c138a8be1ba_7b2e02945e@willemb.c.googlers.com.notmuch>
In-Reply-To: <CALGdzuqnnpc9PK0dJ9vW-n9oo3aM52yu44wr7-Gqf5cKQ2OfPQ@mail.gmail.com>
References: <CALGdzurnLbn6vL28qb07iLMtFjiNUJPygJvwAWoT2D3E7B71jg@mail.gmail.com>
 <65b6d03957960_3fec8b294a0@willemb.c.googlers.com.notmuch>
 <CALGdzuqnnpc9PK0dJ9vW-n9oo3aM52yu44wr7-Gqf5cKQ2OfPQ@mail.gmail.com>
Subject: Re: [Linux Kernel Bug][ipv6/udp] memory leak in __ip6_append_data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Chenyuan Yang wrote:
> Hello Willem,
> =

> Thanks for your reply!
> =

> I double-checked the reproducer and ensured it could reproduce on the
> latest kernel (hash: 3eb5ca857d38ae7a694de6e59a3de7990af87919) with
> the config attached.
> =

> ```
> root@syzkaller:~# gcc -pthread repro.c -o exe
> root@syzkaller:~# ./exe
> BUG: memory leak
> unreferenced object 0xffff88801a80c700 (size 240):
>   comm "exe", pid 12074, jiffies 4295684229 (age 11.520s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 40 1a ad 1a 80 88 ff ff  ........@.......
>   backtrace:
>     [<ffffffff81625419>] kmem_cache_alloc_node+0x2e9/0x440
>     [<ffffffff83e747e7>] __alloc_skb+0x1f7/0x220
>     [<ffffffff83e6a06b>] sock_omalloc+0x5b/0xa0
>     [<ffffffff83e7d702>] msg_zerocopy_realloc+0xf2/0x340
>     [<ffffffff8430d3a2>] __ip6_append_data.isra.0+0x1432/0x1e50
>     [<ffffffff8430decf>] ip6_append_data+0x10f/0x2e0
>     [<ffffffff84352bd1>] udpv6_sendmsg+0x851/0x1690
>     [<ffffffff84305b39>] inet6_sendmsg+0x49/0x70
>     [<ffffffff83e5e954>] __sock_sendmsg+0x54/0xb0
>     [<ffffffff83e61982>] __sys_sendto+0x172/0x220
>     [<ffffffff83e61a58>] __x64_sys_sendto+0x28/0x30
>     [<ffffffff84ae676f>] do_syscall_64+0x3f/0x110
>     [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b
> =

> BUG: memory leak
> unreferenced object 0xffff88801f2e1400 (size 640):
>   comm "exe", pid 12074, jiffies 4295684229 (age 11.520s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff81625419>] kmem_cache_alloc_node+0x2e9/0x440
>     [<ffffffff83e70b20>] kmalloc_reserve+0xe0/0x170
>     [<ffffffff83e746c1>] __alloc_skb+0xd1/0x220
>     [<ffffffff83e6a06b>] sock_omalloc+0x5b/0xa0
>     [<ffffffff83e7d702>] msg_zerocopy_realloc+0xf2/0x340
>     [<ffffffff8430d3a2>] __ip6_append_data.isra.0+0x1432/0x1e50
>     [<ffffffff8430decf>] ip6_append_data+0x10f/0x2e0
>     [<ffffffff84352bd1>] udpv6_sendmsg+0x851/0x1690
>     [<ffffffff84305b39>] inet6_sendmsg+0x49/0x70
>     [<ffffffff83e5e954>] __sock_sendmsg+0x54/0xb0
>     [<ffffffff83e61982>] __sys_sendto+0x172/0x220
>     [<ffffffff83e61a58>] __x64_sys_sendto+0x28/0x30
>     [<ffffffff84ae676f>] do_syscall_64+0x3f/0x110
>     [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b
> ```
> =

> The C reproducer needs some time while the syz program can reproduce
> the issue more quickly.
> =

> Let me know if you need further information to reproduce or debug.
> =

> Best,
> Chenyuan
> =

> On Sun, Jan 28, 2024 at 4:07=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Chenyuan Yang wrote:
> > > Dear Linux Developers for Ipv6 Network,
> > >
> > > We encountered "memory leak in __ip6_append_data" when testing the
> > > ipv6 udp socket with Syzkaller and our generated specifications.
> > >
> > > The reproducers and config for the kernel are attached.
> > >
> > > ```
> > > BUG: memory leak
> > > unreferenced object 0xffff888018322900 (size 240):
> > >   comm "syz-executor115", pid 8030, jiffies 4294985782 (age 11.650s=
)
> > >   hex dump (first 32 bytes):
> > >     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ..............=
.
> > >     00 00 00 00 00 00 00 00 40 5a 8b 14 80 88 ff ff  ........@Z....=
.
> > >   backtrace:
> > >     [<ffffffff81625419>] kmemleak_alloc_recursive
> > > include/linux/kmemleak.h:42 [inline]
> > >     [<ffffffff81625419>] slab_post_alloc_hook mm/slab.h:766 [inline=
]
> > >     [<ffffffff81625419>] slab_alloc_node mm/slub.c:3478 [inline]
> > >     [<ffffffff81625419>] kmem_cache_alloc_node+0x2e9/0x440 mm/slub.=
c:3523
> > >     [<ffffffff83e747e7>] __alloc_skb+0x1f7/0x220 net/core/skbuff.c:=
641
> > >     [<ffffffff83e6a06b>] alloc_skb include/linux/skbuff.h:1286 [inl=
ine]
> > >     [<ffffffff83e6a06b>] sock_omalloc+0x5b/0xa0 net/core/sock.c:265=
7
> > >     [<ffffffff83e7d702>] msg_zerocopy_alloc net/core/skbuff.c:1552 =
[inline]
> > >     [<ffffffff83e7d702>] msg_zerocopy_realloc+0xf2/0x340 net/core/s=
kbuff.c:1628
> > >     [<ffffffff8430d3a2>] __ip6_append_data.isra.0+0x1432/0x1e50
> > > net/ipv6/ip6_output.c:1517
> > >     [<ffffffff8430decf>] ip6_append_data+0x10f/0x2e0 net/ipv6/ip6_o=
utput.c:1832
> > >     [<ffffffff84352bd1>] udpv6_sendmsg+0x851/0x1690 net/ipv6/udp.c:=
1602
> > >     [<ffffffff84305b39>] inet6_sendmsg+0x49/0x70 net/ipv6/af_inet6.=
c:657
> > >     [<ffffffff83e5e954>] sock_sendmsg_nosec net/socket.c:730 [inlin=
e]
> > >     [<ffffffff83e5e954>] __sock_sendmsg+0x54/0xb0 net/socket.c:745
> > >     [<ffffffff83e61982>] __sys_sendto+0x172/0x220 net/socket.c:2194=

> > >     [<ffffffff83e61a58>] __do_sys_sendto net/socket.c:2206 [inline]=

> > >     [<ffffffff83e61a58>] __se_sys_sendto net/socket.c:2202 [inline]=

> > >     [<ffffffff83e61a58>] __x64_sys_sendto+0x28/0x30 net/socket.c:22=
02
> > >     [<ffffffff84ae676f>] do_syscall_x64 arch/x86/entry/common.c:51 =
[inline]
> > >     [<ffffffff84ae676f>] do_syscall_64+0x3f/0x110 arch/x86/entry/co=
mmon.c:82
> > >     [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b
> > >
> > > BUG: memory leak
> > > unreferenced object 0xffff888014a58280 (size 640):
> > >   comm "syz-executor115", pid 8030, jiffies 4294985782 (age 11.650s=
)
> > >   hex dump (first 32 bytes):
> > >     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ..............=
.
> > >     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ..............=
.
> > >   backtrace:
> > >     [<ffffffff81625419>] kmemleak_alloc_recursive
> > > include/linux/kmemleak.h:42 [inline]
> > >     [<ffffffff81625419>] slab_post_alloc_hook mm/slab.h:766 [inline=
]
> > >     [<ffffffff81625419>] slab_alloc_node mm/slub.c:3478 [inline]
> > >     [<ffffffff81625419>] kmem_cache_alloc_node+0x2e9/0x440 mm/slub.=
c:3523
> > >     [<ffffffff83e70b20>] kmalloc_reserve+0xe0/0x170 net/core/skbuff=
c:560
> > >     [<ffffffff83e746c1>] __alloc_skb+0xd1/0x220 net/core/skbuff.c:6=
51
> > >     [<ffffffff83e6a06b>] alloc_skb include/linux/skbuff.h:1286 [inl=
ine]
> > >     [<ffffffff83e6a06b>] sock_omalloc+0x5b/0xa0 net/core/sock.c:265=
7
> > >     [<ffffffff83e7d702>] msg_zerocopy_alloc net/core/skbuff.c:1552 =
[inline]
> > >     [<ffffffff83e7d702>] msg_zerocopy_realloc+0xf2/0x340 net/core/s=
kbuff.c:1628
> > >     [<ffffffff8430d3a2>] __ip6_append_data.isra.0+0x1432/0x1e50
> > > net/ipv6/ip6_output.c:1517
> > >     [<ffffffff8430decf>] ip6_append_data+0x10f/0x2e0 net/ipv6/ip6_o=
utput.c:1832
> > >     [<ffffffff84352bd1>] udpv6_sendmsg+0x851/0x1690 net/ipv6/udp.c:=
1602
> > >     [<ffffffff84305b39>] inet6_sendmsg+0x49/0x70 net/ipv6/af_inet6.=
c:657
> > >     [<ffffffff83e5e954>] sock_sendmsg_nosec net/socket.c:730 [inlin=
e]
> > >     [<ffffffff83e5e954>] __sock_sendmsg+0x54/0xb0 net/socket.c:745
> > >     [<ffffffff83e61982>] __sys_sendto+0x172/0x220 net/socket.c:2194=

> > >     [<ffffffff83e61a58>] __do_sys_sendto net/socket.c:2206 [inline]=

> > >     [<ffffffff83e61a58>] __se_sys_sendto net/socket.c:2202 [inline]=

> > >     [<ffffffff83e61a58>] __x64_sys_sendto+0x28/0x30 net/socket.c:22=
02
> > >     [<ffffffff84ae676f>] do_syscall_x64 arch/x86/entry/common.c:51 =
[inline]
> > >     [<ffffffff84ae676f>] do_syscall_64+0x3f/0x110 arch/x86/entry/co=
mmon.c:82
> > >     [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b
> > >
> > > Syzkaller reproducer:
> > > # {Threaded:true Repeat:true RepeatTimes:0 Procs:1 Slowdown:1 Sandb=
ox:
> > > SandboxArg:0 Leak:true NetInjection:false NetDevices:false
> > > NetReset:false Cgroups:false BinfmtMisc:false CloseFDs:false
> > > KCSAN:false DevlinkPCI:false NicVF:false USB:false VhciInjection:fa=
lse
> > > Wifi:false IEEE802154:false Sysctl:false Swap:false UseTmpDir:false=

> > > HandleSegv:false Repro:false Trace:false LegacyOptions:{Collide:fal=
se
> > > Fault:false FaultCall:0 FaultNth:0}}
> > > r0 =3D socket$KGPT_inet6_udp(0xa, 0x2, 0x11)
> > > setsockopt$sock_int(r0, 0x1, 0x3c, &(0x7f0000000000)=3D0x1, 0x4)
> > > sendto$KGPT_inet6_dgram_ops(r0, 0x0, 0x0, 0x24008006,
> > > &(0x7f0000000180)=3D{0xa, 0x4e20, 0x0, @loopback, 0x6}, 0x1c) (asyn=
c)
> > > sendto$KGPT_inet6_dgram_ops(r0, &(0x7f00000015c0)=3D"98", 0x1,
> > > 0x4000040, &(0x7f0000000040)=3D{0xa, 0x4e24, 0x0, @empty, 0x1}, 0x1=
c)
> > > (rerun: 64)
> > > ```
> >
> > TL;DR: I haven't reproduced or found a bug through analysis yet.
> >
> > A race, as the program requires threaded mode.
> >
> > Short program:
> >
> >     socket(AF_INET6, SOCK_DGRAM, IPPROTO_UDP) =3D 3
> >
> >     setsockopt(3, SOL_SOCKET, SO_ZEROCOPY, [1], 4) =3D 0
> >
> >     for (i =3D 0; i < UDP_MAX_SEGMENTS /* 64 */; i++)
> >             sendto(3, "\230", 1, MSG_DONTWAIT|MSG_ZEROCOPY,
> >                    {sa_family=3DAF_INET6, sin6_port=3Dhtons(20004), s=
in6_flowinfo=3Dhtonl(0),
> >                     inet_pton(AF_INET6, "::", &sin6_addr), sin6_scope=
_id=3D1}, 28) =3D 1
> >
> >     sendto(3, NULL, 0, MSG_PEEK|MSG_DONTROUTE|MSG_MORE|MSG_ZEROCOPY|M=
SG_FASTOPEN,
> >            {sa_family=3DAF_INET6, sin6_port=3Dhtons(20000), sin6_flow=
 info=3Dhtonl(0),
> >             inet_pton(AF_INET6, "::1", &sin6_addr), sin6_scope_id=3D6=
}, 28) =3D 0
> >
> > Where each of the four blocks run in separate threads. In effect the =
two sendto
> > calls race.
> >
> > They differ in their sendto destination addresses. But on corked sock=
ets
> > only the addr argument of the first call is used.
> >
> > Only the second call calls MSG_MORE, so can setup a udp packet that p=
ersists
> > between the calls. Kind of odd to even allocate an skb if length is 0=
B?
> >
> > The MSG_ZEROCOPY path is only taken for non-zero length, so can be ig=
nored on
> > the 0B call. In __ip6_append_data:
> >
> >         if ((flags & MSG_ZEROCOPY) && length) {
> >
> > So one uarg reference is taken on the second call. For corked udp soc=
kets, the
> > total refcount on uarg also remains 1 regardless of the number of MSG=
_MORE
> > send calls, each of which calls msg_zerocopy_realloc.
> >
> > So an skb gets created and sent, using two calls (one MSG_MORE, one n=
ot). Both
> > calls return without error.
> >
> > Question is where the uarg can get lost or acquire an extra reference=
.

Still no root cause. But I ran some variations to narrow down the possibi=
lities.

Besides the reported ubuf_info leak, kmemleak also reports an sk_alloc le=
ak (and
associated apparmor_sk_alloc_security leak).

Most MSG_.. flags passed are irrelevant, as can be expected as many are i=
gnored
on UDP rx.

Required are MSG_ZEROCOPY on both sendto calls, MSG_MORE on the 0B call a=
nd
MSG_DONTWAIT on the 1B call. Remove any of these as the issue no longer
reproduces.

The leak happens on a sendto 1B with MSG_ZEROCOPY | MSG_DONTWAIT. No prio=
r skb
exists. So this is not an append to the sendto 0B with MSG_MORE.

The underlying issue is a race and it is very brief. Adding even a little=

instrumentation to store some state in ubuf_info (e.g., whether this is a=

new skb or an append to a 0B payload skb), makes kmemleak stop reporting =
the
ubuf_info leak. Interestingly, it does still report the sk_alloc leak.




