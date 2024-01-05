Return-Path: <linux-kernel+bounces-18237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C39825A61
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 19:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64B67285329
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AEF35EF8;
	Fri,  5 Jan 2024 18:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3vAuRZFM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09858358B8
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 18:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d47fae33e0so12165ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 10:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704480380; x=1705085180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5o8WFi7Y3JVUZO40vK+ToBUVkFBeuJCYvv4CXdEX38=;
        b=3vAuRZFM2p15kq8WOsL4FS2Imj/o8GeyYzDH+BtSckRHZ/KmJixClS2SBARVdCzhkC
         YMGJxtn2qIyeqK/6pQAI7ol74Lp4gdYpjumpLuqz7Gng10/alFSLu3dmudpWHMg5lv+/
         t4Z7N7bYh4xZdB56IxLpMB0hOz1dymTAQfa1NaQjKIshiu5Y9X8DY4MzeEOddIMtZzeD
         uZ7yE+2sUKK4dk7lyChfmdXZRPgN7FM+IoPh/KkOUlDfksEyWonXCwqTUVMcfZJGHQ23
         0nfN60yESknx8M803hqd9nJ8PXlw5jPrg3wxuFM8Z20TT+Exmqynnv49hmtU1jOYIpe9
         Uw+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704480380; x=1705085180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B5o8WFi7Y3JVUZO40vK+ToBUVkFBeuJCYvv4CXdEX38=;
        b=Uul/25TIFFvBx1GO5dIyisKH4IIyB7yEnNEegiRHVFVjETeOuoNCWhKfVn/svRJZcb
         mSi9s8SBUnWGGHw0Ma31L5DyN8IyGu9feRc1TbAR4YLzEo1faLdkmt4nhv8j4WZwnqrc
         6TZujmhHvzXUK+poHTLCEeDhMTqOapg1N9exyXmn4MTzf9wND02DTDO6/dwwUsQbbVzi
         u6BIhKtdZ/woRt+h113xUIbSj7TfhAk/tzJ2kg9JJDo9L0pzGk5ztLJ9NNHYDVp7AnJn
         lsjpCmDaNIXnj1rbJ/7PjIALIaFz20UROJhgV8KM/lgLlzRv5n2s6/TlaSvtMgoa4PR6
         5jCg==
X-Gm-Message-State: AOJu0Ywj0nkc334+cF1yE6JMx20pmDDIsWVLqT/tz2zXFQoNcJrjNQt4
	ZB/i+yxkqeqLjwhTJ54n0GUHa2ksFrpVm9MCKla+Izxtl5gf
X-Google-Smtp-Source: AGHT+IG/kZ0gWOiDEkIgzgjVdPdypUOFJul6MjXZXK68tqlMAiwG8HlmnlKdDibLa51Bi0llWI7V8n7CKseLUC3h5sQ=
X-Received: by 2002:a17:902:9a05:b0:1d4:11:e20a with SMTP id
 v5-20020a1709029a0500b001d40011e20amr14819plp.13.1704480379982; Fri, 05 Jan
 2024 10:46:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000a62351060e363bdc@google.com> <000000000000d4a93c060e373195@google.com>
In-Reply-To: <000000000000d4a93c060e373195@google.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Fri, 5 Jan 2024 19:46:07 +0100
Message-ID: <CANp29Y7YHm2A3AHuvmKzc0hQdZmZwyNouy6F6xnHBBE4YMa=Yw@mail.gmail.com>
Subject: Re: [syzbot] [net?] memory leak in ___neigh_create (2)
To: syzbot <syzbot+42cfec52b6508887bbe8@syzkaller.appspotmail.com>
Cc: alexander.mikhalitsyn@virtuozzo.com, davem@davemloft.net, den@openvz.org, 
	dsahern@kernel.org, edumazet@google.com, f.fainelli@gmail.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, razor@blackwall.org, syzkaller-bugs@googlegroups.com, 
	thomas.zeitlhofer+lkml@ze-it.at, thomas.zeitlhofer@ze-it.at, 
	wangyuweihx@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'm very sorry for the inconvenience due to the syzbot breakage!
The reporting was stopped.

We're figuring out what went wrong and will add more fine-grained
controls to prevent such situations in the future.

On Fri, Jan 5, 2024 at 7:41=E2=80=AFPM syzbot
<syzbot+42cfec52b6508887bbe8@syzkaller.appspotmail.com> wrote:
>
> syzbot has found a reproducer for the following issue on:
>
> HEAD commit:    2258c2dc850b Merge tag 'for-linus' of git://git.kernel.or=
g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D16f67b4448000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Da4fb7ad9185f1=
501
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D42cfec52b650888=
7bbe8
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binuti=
ls for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D14e23d44480=
000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/0e65a45877eb/dis=
k-2258c2dc.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/7617adf885a8/vmlinu=
x-2258c2dc.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/43fb89ea894a/b=
zImage-2258c2dc.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+42cfec52b6508887bbe8@syzkaller.appspotmail.com
>
> BUG: memory leak
> unreferenced object 0xffff88810b8ea400 (size 512):
>   comm "kworker/0:3", pid 4440, jiffies 4294938594 (age 1132.680s)
>   hex dump (first 32 bytes):
>     00 9c f8 0a 81 88 ff ff 80 29 23 86 ff ff ff ff  .........)#.....
>     c0 79 79 44 81 88 ff ff 72 78 ff ff 00 00 00 00  .yyD....rx......
>   backtrace:
>     [<ffffffff814f9fe6>] __do_kmalloc_node mm/slab_common.c:967 [inline]
>     [<ffffffff814f9fe6>] __kmalloc+0x46/0x120 mm/slab_common.c:981
>     [<ffffffff83b5234f>] kmalloc include/linux/slab.h:584 [inline]
>     [<ffffffff83b5234f>] kzalloc include/linux/slab.h:720 [inline]
>     [<ffffffff83b5234f>] neigh_alloc net/core/neighbour.c:476 [inline]
>     [<ffffffff83b5234f>] ___neigh_create+0xdf/0xd60 net/core/neighbour.c:=
661
>     [<ffffffff83f9f886>] ip6_finish_output2+0x776/0x9b0 net/ipv6/ip6_outp=
ut.c:125
>     [<ffffffff83fa5530>] __ip6_finish_output net/ipv6/ip6_output.c:195 [i=
nline]
>     [<ffffffff83fa5530>] ip6_finish_output+0x270/0x530 net/ipv6/ip6_outpu=
t.c:206
>     [<ffffffff83fa5893>] NF_HOOK_COND include/linux/netfilter.h:291 [inli=
ne]
>     [<ffffffff83fa5893>] ip6_output+0xa3/0x1b0 net/ipv6/ip6_output.c:227
>     [<ffffffff83ff16d9>] dst_output include/net/dst.h:444 [inline]
>     [<ffffffff83ff16d9>] NF_HOOK include/linux/netfilter.h:302 [inline]
>     [<ffffffff83ff16d9>] NF_HOOK.constprop.0+0x49/0x110 include/linux/net=
filter.h:296
>     [<ffffffff83ff19c4>] mld_sendpack+0x224/0x350 net/ipv6/mcast.c:1820
>     [<ffffffff83ff5403>] mld_send_cr net/ipv6/mcast.c:2121 [inline]
>     [<ffffffff83ff5403>] mld_ifc_work+0x2a3/0x750 net/ipv6/mcast.c:2653
>     [<ffffffff8129519a>] process_one_work+0x2ba/0x5f0 kernel/workqueue.c:=
2289
>     [<ffffffff81295ab9>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2436
>     [<ffffffff8129fb05>] kthread+0x125/0x160 kernel/kthread.c:376
>     [<ffffffff8100224f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.=
S:308
>
> BUG: memory leak
> unreferenced object 0xffff888109a7fa00 (size 512):
>   comm "kworker/0:3", pid 4440, jiffies 4294938594 (age 1132.680s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 80 29 23 86 ff ff ff ff  .........)#.....
>     00 79 79 44 81 88 ff ff 72 78 ff ff 00 00 00 00  .yyD....rx......
>   backtrace:
>     [<ffffffff814f9fe6>] __do_kmalloc_node mm/slab_common.c:967 [inline]
>     [<ffffffff814f9fe6>] __kmalloc+0x46/0x120 mm/slab_common.c:981
>     [<ffffffff83b5234f>] kmalloc include/linux/slab.h:584 [inline]
>     [<ffffffff83b5234f>] kzalloc include/linux/slab.h:720 [inline]
>     [<ffffffff83b5234f>] neigh_alloc net/core/neighbour.c:476 [inline]
>     [<ffffffff83b5234f>] ___neigh_create+0xdf/0xd60 net/core/neighbour.c:=
661
>     [<ffffffff83f9f886>] ip6_finish_output2+0x776/0x9b0 net/ipv6/ip6_outp=
ut.c:125
>     [<ffffffff83fa5530>] __ip6_finish_output net/ipv6/ip6_output.c:195 [i=
nline]
>     [<ffffffff83fa5530>] ip6_finish_output+0x270/0x530 net/ipv6/ip6_outpu=
t.c:206
>     [<ffffffff83fa5893>] NF_HOOK_COND include/linux/netfilter.h:291 [inli=
ne]
>     [<ffffffff83fa5893>] ip6_output+0xa3/0x1b0 net/ipv6/ip6_output.c:227
>     [<ffffffff83ff16d9>] dst_output include/net/dst.h:444 [inline]
>     [<ffffffff83ff16d9>] NF_HOOK include/linux/netfilter.h:302 [inline]
>     [<ffffffff83ff16d9>] NF_HOOK.constprop.0+0x49/0x110 include/linux/net=
filter.h:296
>     [<ffffffff83ff19c4>] mld_sendpack+0x224/0x350 net/ipv6/mcast.c:1820
>     [<ffffffff83ff5403>] mld_send_cr net/ipv6/mcast.c:2121 [inline]
>     [<ffffffff83ff5403>] mld_ifc_work+0x2a3/0x750 net/ipv6/mcast.c:2653
>     [<ffffffff8129519a>] process_one_work+0x2ba/0x5f0 kernel/workqueue.c:=
2289
>     [<ffffffff81295ab9>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2436
>     [<ffffffff8129fb05>] kthread+0x125/0x160 kernel/kthread.c:376
>     [<ffffffff8100224f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.=
S:308
>
> BUG: memory leak
> unreferenced object 0xffff88810a9fb400 (size 512):
>   comm "dhcpcd", pid 4638, jiffies 4294938595 (age 1132.670s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 80 29 23 86 ff ff ff ff  .........)#.....
>     c0 76 79 44 81 88 ff ff 73 78 ff ff 00 00 00 00  .vyD....sx......
>   backtrace:
>     [<ffffffff814f9fe6>] __do_kmalloc_node mm/slab_common.c:967 [inline]
>     [<ffffffff814f9fe6>] __kmalloc+0x46/0x120 mm/slab_common.c:981
>     [<ffffffff83b5234f>] kmalloc include/linux/slab.h:584 [inline]
>     [<ffffffff83b5234f>] kzalloc include/linux/slab.h:720 [inline]
>     [<ffffffff83b5234f>] neigh_alloc net/core/neighbour.c:476 [inline]
>     [<ffffffff83b5234f>] ___neigh_create+0xdf/0xd60 net/core/neighbour.c:=
661
>     [<ffffffff83f9f886>] ip6_finish_output2+0x776/0x9b0 net/ipv6/ip6_outp=
ut.c:125
>     [<ffffffff83fa5530>] __ip6_finish_output net/ipv6/ip6_output.c:195 [i=
nline]
>     [<ffffffff83fa5530>] ip6_finish_output+0x270/0x530 net/ipv6/ip6_outpu=
t.c:206
>     [<ffffffff83fa5893>] NF_HOOK_COND include/linux/netfilter.h:291 [inli=
ne]
>     [<ffffffff83fa5893>] ip6_output+0xa3/0x1b0 net/ipv6/ip6_output.c:227
>     [<ffffffff84062411>] dst_output include/net/dst.h:444 [inline]
>     [<ffffffff84062411>] ip6_local_out+0x51/0x70 net/ipv6/output_core.c:1=
55
>     [<ffffffff83fa6285>] ip6_send_skb+0x25/0xc0 net/ipv6/ip6_output.c:197=
1
>     [<ffffffff83fa6394>] ip6_push_pending_frames+0x74/0x90 net/ipv6/ip6_o=
utput.c:1991
>     [<ffffffff83fec08c>] rawv6_push_pending_frames net/ipv6/raw.c:579 [in=
line]
>     [<ffffffff83fec08c>] rawv6_sendmsg+0x16ac/0x1ba0 net/ipv6/raw.c:922
>     [<ffffffff83ebe965>] inet_sendmsg+0x45/0x70 net/ipv4/af_inet.c:827
>     [<ffffffff83af7116>] sock_sendmsg_nosec net/socket.c:714 [inline]
>     [<ffffffff83af7116>] sock_sendmsg+0x56/0x80 net/socket.c:734
>     [<ffffffff83af769d>] ____sys_sendmsg+0x38d/0x410 net/socket.c:2476
>     [<ffffffff83afbfe8>] ___sys_sendmsg+0xa8/0x110 net/socket.c:2530
>     [<ffffffff83afc178>] __sys_sendmsg+0x88/0x100 net/socket.c:2559
>     [<ffffffff848ed5b5>] do_syscall_x64 arch/x86/entry/common.c:50 [inlin=
e]
>     [<ffffffff848ed5b5>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:=
80
>     [<ffffffff84a00087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> BUG: memory leak
> unreferenced object 0xffff88810a9fba00 (size 512):
>   comm "dhcpcd", pid 4638, jiffies 4294938595 (age 1132.670s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 80 29 23 86 ff ff ff ff  .........)#.....
>     80 77 79 44 81 88 ff ff 73 78 ff ff 00 00 00 00  .wyD....sx......
>   backtrace:
>     [<ffffffff814f9fe6>] __do_kmalloc_node mm/slab_common.c:967 [inline]
>     [<ffffffff814f9fe6>] __kmalloc+0x46/0x120 mm/slab_common.c:981
>     [<ffffffff83b5234f>] kmalloc include/linux/slab.h:584 [inline]
>     [<ffffffff83b5234f>] kzalloc include/linux/slab.h:720 [inline]
>     [<ffffffff83b5234f>] neigh_alloc net/core/neighbour.c:476 [inline]
>     [<ffffffff83b5234f>] ___neigh_create+0xdf/0xd60 net/core/neighbour.c:=
661
>     [<ffffffff83f9f886>] ip6_finish_output2+0x776/0x9b0 net/ipv6/ip6_outp=
ut.c:125
>     [<ffffffff83fa5530>] __ip6_finish_output net/ipv6/ip6_output.c:195 [i=
nline]
>     [<ffffffff83fa5530>] ip6_finish_output+0x270/0x530 net/ipv6/ip6_outpu=
t.c:206
>     [<ffffffff83fa5893>] NF_HOOK_COND include/linux/netfilter.h:291 [inli=
ne]
>     [<ffffffff83fa5893>] ip6_output+0xa3/0x1b0 net/ipv6/ip6_output.c:227
>     [<ffffffff84062411>] dst_output include/net/dst.h:444 [inline]
>     [<ffffffff84062411>] ip6_local_out+0x51/0x70 net/ipv6/output_core.c:1=
55
>     [<ffffffff83fa6285>] ip6_send_skb+0x25/0xc0 net/ipv6/ip6_output.c:197=
1
>     [<ffffffff83fa6394>] ip6_push_pending_frames+0x74/0x90 net/ipv6/ip6_o=
utput.c:1991
>     [<ffffffff83fec08c>] rawv6_push_pending_frames net/ipv6/raw.c:579 [in=
line]
>     [<ffffffff83fec08c>] rawv6_sendmsg+0x16ac/0x1ba0 net/ipv6/raw.c:922
>     [<ffffffff83ebe965>] inet_sendmsg+0x45/0x70 net/ipv4/af_inet.c:827
>     [<ffffffff83af7116>] sock_sendmsg_nosec net/socket.c:714 [inline]
>     [<ffffffff83af7116>] sock_sendmsg+0x56/0x80 net/socket.c:734
>     [<ffffffff83af769d>] ____sys_sendmsg+0x38d/0x410 net/socket.c:2476
>     [<ffffffff83afbfe8>] ___sys_sendmsg+0xa8/0x110 net/socket.c:2530
>     [<ffffffff83afc178>] __sys_sendmsg+0x88/0x100 net/socket.c:2559
>     [<ffffffff848ed5b5>] do_syscall_x64 arch/x86/entry/common.c:50 [inlin=
e]
>     [<ffffffff848ed5b5>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:=
80
>     [<ffffffff84a00087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
>
>
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/000000000000d4a93c060e373195%40google.com.

