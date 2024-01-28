Return-Path: <linux-kernel+bounces-41979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C69BD83FA43
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 23:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C8B8B2209A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 22:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F333C492;
	Sun, 28 Jan 2024 22:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3ySq0O2"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0573C46E;
	Sun, 28 Jan 2024 22:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706479677; cv=none; b=Mof82NRnPtmHVomMB+0tzqkNfHbVQVuygI+Sj/PNnRFGNj+QDCI9Z2FDTpFlC8kDudAVCjkwSZ7tym/DLzBllcY03tU/Sfeo1YnKaS2PPLAuZQ1hq1W1vFvYRt1IkLlJ6BpvdhVG5wOaQdHw1h6qtOkR/T73OImlpEkrb1nKlQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706479677; c=relaxed/simple;
	bh=03zq5PpjG0G+zLQGN7iHgOolNPmH6+TwAv3syV9FsJE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ujLC85ulHB9FpeELSHtvWuk4+41QIhLHUJAhpau0NojAIGNbZO4NZPKQG/D300tLs8ZSaPp9wZC/PqbuHc//F4YtbOEjhad9SOP7vvTNvWDlksFbm510JuuD4ekM91ydRbPl/qqrFBlwGTBwezK1X/uDOEu3YpFfjc1xKvH7few=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3ySq0O2; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-42a8a3973c5so13795291cf.2;
        Sun, 28 Jan 2024 14:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706479674; x=1707084474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fIpIB0moGjSC/HRkxT5vnj8fLK8w2pwWABPQIdo5nto=;
        b=I3ySq0O2x7lGvua/Z3ffKKxF/SiPtgSpYp0u8qf0adUooSH0JgRFivp/OdrqYMXPAm
         i5LoIX+1Pt2Fhsl4ZrJZ4sGjVB6SGFA+n7URRh//3ExzA9hIJ0CZGkhRcnS9Stk/ewvC
         piEu0dNdVoVnK+pKgZNi0MzqVswYTodMNDCgxsfAsmI/Cqbkt2LIRQydAB27G+QHnhU0
         cicde2MQmD6jDiX99F7Vaxn23lo7eEZHvZDsradH1ATHFuU/30PzfJwp5NvbJDZakrOu
         Kz30bdE2i9p7ZlHmWax/DBnloIiPEg5Exdfx8i1aK17MtBUTbN/cFJbrjdDgp62Q/efd
         alJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706479674; x=1707084474;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fIpIB0moGjSC/HRkxT5vnj8fLK8w2pwWABPQIdo5nto=;
        b=aMIfTGZdMurOZklKqLqJHlf2kOF0f87mRsUa7lntJxV+eX82nSCz5mldFPNqVhbFVW
         zkOt1HHrMb+S7VhZCPr6joRFLdsoYVzBnPaTPBf+q9ak7a9eRHR4M5PhQ6RMAZM0ZZCK
         asEbn9kUsAt3YegHFhE0CPgFAckKOQTvfS6163rWl9oucYkwbpd+SYwVKPYZ4Yj3msRx
         iRGkYgtZFKmretDo6TAtknCdMRnSOPLQnR959g7n8UvdB0g5MsBHtP9hfDv60YKEGMff
         Yuzkfloc6KT2KBIZxDnHLiaE1MR1e8xBQ+HoAXEv9WLyjkEhZDeWQGdsvkpjD6qrHbr/
         ksVw==
X-Gm-Message-State: AOJu0YxIHx9IhcuZh8BHIjAzK9yBsWXWvnXhucEpRS1wd126w1915yVr
	aMV44DSIZ3kjZCQ0crmY00O/vlY0MwNt3G7fkpvLqprHUb6l6R/1
X-Google-Smtp-Source: AGHT+IGP7EoM/OG6OFQxTBIZ25LyM3ajpRCHKHoP71gtZn5IxZS0QTtJUqc+KVcbelo+2oCXhq14Ow==
X-Received: by 2002:a05:622a:53:b0:42a:5697:accb with SMTP id y19-20020a05622a005300b0042a5697accbmr5053230qtw.78.1706479674356;
        Sun, 28 Jan 2024 14:07:54 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVzZ1ImonS1FFWnqJ1hSWeyvG1I3yeC1thClRt0hugyUof+nhd12U/4WmfrsYtsHNNJ4fVlKdDcI2BkN7yNTmg5tU1D+Xhc1I+/g8p9FoJON670DS5vPmcy/vvrQlBOk6IQfl2se3xlpXA4f8fboJX1YAIoidGicqW6FS7Arx5pA5iej9foyDtE8LLJbRCsxjEAzPQjFcnQ+2shLJy5zUE6YZ6aTybNCpxDFtQW+4ypZ2RcMwhnc78ehV4VvtGNQAs0pYCCBem6a+ctivWYRlfg+jJlPvUqvqIWaVXvpyYy4tvhJcyTAke0i+YdADFSVjtgRv8HLmvl8w==
Received: from localhost (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id cn5-20020a05622a248500b0042a29013f15sm2770717qtb.82.2024.01.28.14.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 14:07:53 -0800 (PST)
Date: Sun, 28 Jan 2024 17:07:53 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Chenyuan Yang <chenyuan0y@gmail.com>, 
 willemdebruijn.kernel@gmail.com, 
 davem@davemloft.net, 
 dsahern@kernel.org, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, 
 syzkaller@googlegroups.com, 
 Zijie Zhao <zzjas98@gmail.com>
Message-ID: <65b6d03957960_3fec8b294a0@willemb.c.googlers.com.notmuch>
In-Reply-To: <CALGdzurnLbn6vL28qb07iLMtFjiNUJPygJvwAWoT2D3E7B71jg@mail.gmail.com>
References: <CALGdzurnLbn6vL28qb07iLMtFjiNUJPygJvwAWoT2D3E7B71jg@mail.gmail.com>
Subject: Re: [Linux Kernel Bug][ipv6/udp] memory leak in __ip6_append_data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Chenyuan Yang wrote:
> Dear Linux Developers for Ipv6 Network,
> 
> We encountered "memory leak in __ip6_append_data" when testing the
> ipv6 udp socket with Syzkaller and our generated specifications.
> 
> The reproducers and config for the kernel are attached.
> 
> ```
> BUG: memory leak
> unreferenced object 0xffff888018322900 (size 240):
>   comm "syz-executor115", pid 8030, jiffies 4294985782 (age 11.650s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 40 5a 8b 14 80 88 ff ff  ........@Z......
>   backtrace:
>     [<ffffffff81625419>] kmemleak_alloc_recursive
> include/linux/kmemleak.h:42 [inline]
>     [<ffffffff81625419>] slab_post_alloc_hook mm/slab.h:766 [inline]
>     [<ffffffff81625419>] slab_alloc_node mm/slub.c:3478 [inline]
>     [<ffffffff81625419>] kmem_cache_alloc_node+0x2e9/0x440 mm/slub.c:3523
>     [<ffffffff83e747e7>] __alloc_skb+0x1f7/0x220 net/core/skbuff.c:641
>     [<ffffffff83e6a06b>] alloc_skb include/linux/skbuff.h:1286 [inline]
>     [<ffffffff83e6a06b>] sock_omalloc+0x5b/0xa0 net/core/sock.c:2657
>     [<ffffffff83e7d702>] msg_zerocopy_alloc net/core/skbuff.c:1552 [inline]
>     [<ffffffff83e7d702>] msg_zerocopy_realloc+0xf2/0x340 net/core/skbuff.c:1628
>     [<ffffffff8430d3a2>] __ip6_append_data.isra.0+0x1432/0x1e50
> net/ipv6/ip6_output.c:1517
>     [<ffffffff8430decf>] ip6_append_data+0x10f/0x2e0 net/ipv6/ip6_output.c:1832
>     [<ffffffff84352bd1>] udpv6_sendmsg+0x851/0x1690 net/ipv6/udp.c:1602
>     [<ffffffff84305b39>] inet6_sendmsg+0x49/0x70 net/ipv6/af_inet6.c:657
>     [<ffffffff83e5e954>] sock_sendmsg_nosec net/socket.c:730 [inline]
>     [<ffffffff83e5e954>] __sock_sendmsg+0x54/0xb0 net/socket.c:745
>     [<ffffffff83e61982>] __sys_sendto+0x172/0x220 net/socket.c:2194
>     [<ffffffff83e61a58>] __do_sys_sendto net/socket.c:2206 [inline]
>     [<ffffffff83e61a58>] __se_sys_sendto net/socket.c:2202 [inline]
>     [<ffffffff83e61a58>] __x64_sys_sendto+0x28/0x30 net/socket.c:2202
>     [<ffffffff84ae676f>] do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>     [<ffffffff84ae676f>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
>     [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> BUG: memory leak
> unreferenced object 0xffff888014a58280 (size 640):
>   comm "syz-executor115", pid 8030, jiffies 4294985782 (age 11.650s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff81625419>] kmemleak_alloc_recursive
> include/linux/kmemleak.h:42 [inline]
>     [<ffffffff81625419>] slab_post_alloc_hook mm/slab.h:766 [inline]
>     [<ffffffff81625419>] slab_alloc_node mm/slub.c:3478 [inline]
>     [<ffffffff81625419>] kmem_cache_alloc_node+0x2e9/0x440 mm/slub.c:3523
>     [<ffffffff83e70b20>] kmalloc_reserve+0xe0/0x170 net/core/skbuff.c:560
>     [<ffffffff83e746c1>] __alloc_skb+0xd1/0x220 net/core/skbuff.c:651
>     [<ffffffff83e6a06b>] alloc_skb include/linux/skbuff.h:1286 [inline]
>     [<ffffffff83e6a06b>] sock_omalloc+0x5b/0xa0 net/core/sock.c:2657
>     [<ffffffff83e7d702>] msg_zerocopy_alloc net/core/skbuff.c:1552 [inline]
>     [<ffffffff83e7d702>] msg_zerocopy_realloc+0xf2/0x340 net/core/skbuff.c:1628
>     [<ffffffff8430d3a2>] __ip6_append_data.isra.0+0x1432/0x1e50
> net/ipv6/ip6_output.c:1517
>     [<ffffffff8430decf>] ip6_append_data+0x10f/0x2e0 net/ipv6/ip6_output.c:1832
>     [<ffffffff84352bd1>] udpv6_sendmsg+0x851/0x1690 net/ipv6/udp.c:1602
>     [<ffffffff84305b39>] inet6_sendmsg+0x49/0x70 net/ipv6/af_inet6.c:657
>     [<ffffffff83e5e954>] sock_sendmsg_nosec net/socket.c:730 [inline]
>     [<ffffffff83e5e954>] __sock_sendmsg+0x54/0xb0 net/socket.c:745
>     [<ffffffff83e61982>] __sys_sendto+0x172/0x220 net/socket.c:2194
>     [<ffffffff83e61a58>] __do_sys_sendto net/socket.c:2206 [inline]
>     [<ffffffff83e61a58>] __se_sys_sendto net/socket.c:2202 [inline]
>     [<ffffffff83e61a58>] __x64_sys_sendto+0x28/0x30 net/socket.c:2202
>     [<ffffffff84ae676f>] do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>     [<ffffffff84ae676f>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
>     [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> Syzkaller reproducer:
> # {Threaded:true Repeat:true RepeatTimes:0 Procs:1 Slowdown:1 Sandbox:
> SandboxArg:0 Leak:true NetInjection:false NetDevices:false
> NetReset:false Cgroups:false BinfmtMisc:false CloseFDs:false
> KCSAN:false DevlinkPCI:false NicVF:false USB:false VhciInjection:false
> Wifi:false IEEE802154:false Sysctl:false Swap:false UseTmpDir:false
> HandleSegv:false Repro:false Trace:false LegacyOptions:{Collide:false
> Fault:false FaultCall:0 FaultNth:0}}
> r0 = socket$KGPT_inet6_udp(0xa, 0x2, 0x11)
> setsockopt$sock_int(r0, 0x1, 0x3c, &(0x7f0000000000)=0x1, 0x4)
> sendto$KGPT_inet6_dgram_ops(r0, 0x0, 0x0, 0x24008006,
> &(0x7f0000000180)={0xa, 0x4e20, 0x0, @loopback, 0x6}, 0x1c) (async)
> sendto$KGPT_inet6_dgram_ops(r0, &(0x7f00000015c0)="98", 0x1,
> 0x4000040, &(0x7f0000000040)={0xa, 0x4e24, 0x0, @empty, 0x1}, 0x1c)
> (rerun: 64)
> ```

TL;DR: I haven't reproduced or found a bug through analysis yet.

A race, as the program requires threaded mode.

Short program:

    socket(AF_INET6, SOCK_DGRAM, IPPROTO_UDP) = 3

    setsockopt(3, SOL_SOCKET, SO_ZEROCOPY, [1], 4) = 0

    for (i = 0; i < UDP_MAX_SEGMENTS /* 64 */; i++)
            sendto(3, "\230", 1, MSG_DONTWAIT|MSG_ZEROCOPY,
                   {sa_family=AF_INET6, sin6_port=htons(20004), sin6_flowinfo=htonl(0),
                    inet_pton(AF_INET6, "::", &sin6_addr), sin6_scope_id=1}, 28) = 1

    sendto(3, NULL, 0, MSG_PEEK|MSG_DONTROUTE|MSG_MORE|MSG_ZEROCOPY|MSG_FASTOPEN,
           {sa_family=AF_INET6, sin6_port=htons(20000), sin6_flow info=htonl(0),
            inet_pton(AF_INET6, "::1", &sin6_addr), sin6_scope_id=6}, 28) = 0

Where each of the four blocks run in separate threads. In effect the two sendto
calls race.

They differ in their sendto destination addresses. But on corked sockets
only the addr argument of the first call is used.

Only the second call calls MSG_MORE, so can setup a udp packet that persists
between the calls. Kind of odd to even allocate an skb if length is 0B?

The MSG_ZEROCOPY path is only taken for non-zero length, so can be ignored on
the 0B call. In __ip6_append_data:
                    
        if ((flags & MSG_ZEROCOPY) && length) {

So one uarg reference is taken on the second call. For corked udp sockets, the
total refcount on uarg also remains 1 regardless of the number of MSG_MORE
send calls, each of which calls msg_zerocopy_realloc.

So an skb gets created and sent, using two calls (one MSG_MORE, one not). Both
calls return without error.

Question is where the uarg can get lost or acquire an extra reference.



