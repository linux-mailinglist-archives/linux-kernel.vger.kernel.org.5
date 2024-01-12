Return-Path: <linux-kernel+bounces-24634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B95FC82BF8C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6AEE1C22FE8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 12:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E7A6A027;
	Fri, 12 Jan 2024 12:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="R8368RNu"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944876A007
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 12:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5534180f0e9so7654a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 04:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705060928; x=1705665728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dAsdRRMNENTHmN3GFUI2+NQJszM6FWe9QJkear/o/c=;
        b=R8368RNuoLGUQxQlwUvdu+LSu3HylKc1cwVUnocV+4s2/EGobg39udeDx44d3dwpDy
         2WUtkkDCu2ZO1W8KiV3Z6IL1fPguWTxy8i1uR0cbbo22lrU84i7ewDAmC+I6cUQXhkab
         Fn1aUfnwFd53u9SQGymU7KWA4ua41IMz1xZnK+O3W61ASkc8WgyWcxOk9VwyFjT0IeQh
         tiGZELR92CMIoAzu3Y/3igWjZIWhiXBWLRUAVBBMcDAQwKvmzmkc3Qy3fYrYF0JN4/zC
         jk02493SQH6PyO2PtRkKa1cMLlO1fwbgnsSxRT6yEOihsPR4qMglI9nCsCrS2Z7ntSSj
         V5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705060928; x=1705665728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9dAsdRRMNENTHmN3GFUI2+NQJszM6FWe9QJkear/o/c=;
        b=RQmjEtVPjdcIjGv9ZFoTx5o+RP6nNySV48Ib8x/Aih+iktpXENTTvmC//UGcgjhUzc
         SpdJOuNnub12D3ZbxokfSIIK86wS2ukySKbRPKnEFKygrhLzZ7Aidzckxuyl5mvHKH29
         QFq22sZc41Z5GUT2m3s8sHI1YVoxnHWsGWjYDzW4e2iANx2jmmCaIddUig8+4Qhx43gT
         +JYBE5PdyFCbWPxO+m2VEGjDNOuGnfjixKSwpKh4Knyc5Jfyl9YudavvVJypHR3VALFb
         hd9v17MClBIG61IZSaJpODldhevzLYz6h5DlE/C33/pq3QBaMYgkfpY/7K3UyBXOUHXj
         9K/g==
X-Gm-Message-State: AOJu0YzNZMktaE3ky2xY+kqoZFocuaLnL+Q7ISGYMawp+Wc6PnkNWNqk
	Hy+SnZ6j0HUIvfQziLfp+npd7+zJK8l8NkLyNlBzQJBK0wBP9xLk6unWLnbtAfaI
X-Google-Smtp-Source: AGHT+IEhXeQEzFajWvgplZ8zKMplV6cTXaxn8qEDBxdXMX5lYoErm6IwzrWMAJjCCnBDIbUAmsWv3Nn9gbZAad2Mmo8=
X-Received: by 2002:a05:6402:1d97:b0:558:c18b:6dcb with SMTP id
 dk23-20020a0564021d9700b00558c18b6dcbmr112818edb.2.1705060927680; Fri, 12 Jan
 2024 04:02:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000994e09060ebcdffb@google.com>
In-Reply-To: <000000000000994e09060ebcdffb@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 12 Jan 2024 13:01:54 +0100
Message-ID: <CANn89iKar6cuJAdQbL2n9vYWRL=yMQBEahfhXNVFNa0aax9OsQ@mail.gmail.com>
Subject: Re: [syzbot] [net?] KCSAN: data-race in ipv6_mc_down / mld_ifc_work (2)
To: syzbot <syzbot+a9400cabb1d784e49abf@syzkaller.appspotmail.com>, 
	Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 11:10=E2=80=AFAM syzbot
<syzbot+a9400cabb1d784e49abf@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    8735c7c84d1b Merge tag '6.7rc7-smb3-srv-fix' of git://git=
..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D17948c9ae8000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4da1e2da456c3=
a7d
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Da9400cabb1d784e=
49abf
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/f263d974af01/dis=
k-8735c7c8.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/9faf34fc0b3e/vmlinu=
x-8735c7c8.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/0b52a58ecd0e/b=
zImage-8735c7c8.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+a9400cabb1d784e49abf@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KCSAN: data-race in ipv6_mc_down / mld_ifc_work
>
> write to 0xffff88813a80c832 of 1 bytes by task 3771 on cpu 0:
>  mld_ifc_stop_work net/ipv6/mcast.c:1080 [inline]
>  ipv6_mc_down+0x10a/0x280 net/ipv6/mcast.c:2725
>  addrconf_ifdown+0xe32/0xf10 net/ipv6/addrconf.c:3949
>  addrconf_notify+0x310/0x980
>  notifier_call_chain kernel/notifier.c:93 [inline]
>  raw_notifier_call_chain+0x6b/0x1c0 kernel/notifier.c:461
>  __dev_notify_flags+0x205/0x3d0
>  dev_change_flags+0xab/0xd0 net/core/dev.c:8685
>  do_setlink+0x9f6/0x2430 net/core/rtnetlink.c:2916
>  rtnl_group_changelink net/core/rtnetlink.c:3458 [inline]
>  __rtnl_newlink net/core/rtnetlink.c:3717 [inline]
>  rtnl_newlink+0xbb3/0x1670 net/core/rtnetlink.c:3754
>  rtnetlink_rcv_msg+0x807/0x8c0 net/core/rtnetlink.c:6558
>  netlink_rcv_skb+0x126/0x220 net/netlink/af_netlink.c:2545
>  rtnetlink_rcv+0x1c/0x20 net/core/rtnetlink.c:6576
>  netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
>  netlink_unicast+0x589/0x650 net/netlink/af_netlink.c:1368
>  netlink_sendmsg+0x66e/0x770 net/netlink/af_netlink.c:1910
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg net/socket.c:745 [inline]
>  ____sys_sendmsg+0x37c/0x4d0 net/socket.c:2584
>  ___sys_sendmsg net/socket.c:2638 [inline]
>  __sys_sendmsg+0x1e9/0x270 net/socket.c:2667
>  __do_sys_sendmsg net/socket.c:2676 [inline]
>  __se_sys_sendmsg net/socket.c:2674 [inline]
>  __x64_sys_sendmsg+0x46/0x50 net/socket.c:2674
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
>
> write to 0xffff88813a80c832 of 1 bytes by task 22 on cpu 1:
>  mld_ifc_work+0x54c/0x7b0 net/ipv6/mcast.c:2653
>  process_one_work kernel/workqueue.c:2627 [inline]
>  process_scheduled_works+0x5b8/0xa30 kernel/workqueue.c:2700
>  worker_thread+0x525/0x730 kernel/workqueue.c:2781
>  kthread+0x1d7/0x210 kernel/kthread.c:388
>  ret_from_fork+0x48/0x60 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
>
> value changed: 0x02 -> 0x00
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 PID: 22 Comm: kworker/1:0 Not tainted 6.7.0-rc7-syzkaller-00029-g8=
735c7c84d1b #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 11/17/2023
> Workqueue: mld mld_ifc_work
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

Bug added in

commit 63ed8de4be81b699ca727e9f8e3344bd487806d7
Author: Taehee Yoo <ap420073@gmail.com>
Date:   Thu Mar 25 16:16:57 2021 +0000

    mld: add mc_lock for protecting per-interface mld data


ipv6_mc_down() calls mld_ifc_stop_work() while mc_lock is not held.

