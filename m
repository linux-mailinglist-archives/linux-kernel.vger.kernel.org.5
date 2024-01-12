Return-Path: <linux-kernel+bounces-24849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C7782C365
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A310B22999
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE73745CD;
	Fri, 12 Jan 2024 16:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlKWgPen"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765B573198;
	Fri, 12 Jan 2024 16:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6d9bba6d773so5850599b3a.1;
        Fri, 12 Jan 2024 08:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705076193; x=1705680993; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=21WhwU0IKwpp5rHYuLTMDQxS382v9liD3E1apg8a+jI=;
        b=GlKWgPenwSADHjADSSgRE9JgPLsIfhFkL/2jl+VGoWE0TErssvKHKEiFLs0BgrRwZ7
         zB41Ef4j+mhF/aMLS+fwHEpXFaelNJZTvYSrFzRcbKU45sLOpM6EUn/NHCjkpRRPqdaa
         n8Yc5UzIAGoChB5yvmlgfej/LdydcnDMBWOjzSfqjxcb7iWZRYTAdltgQ/i04c3pzqZu
         pP0JvmZ3I+d/vixdmw76zSSG3gvGxnIryQXpaeKKMnlR7mA+DYfj5Mr3CkY452nhwjZM
         xCnMe0Ilg9+Onpvipiwk4GRR+5kJVOefjlwGimFp+ctFuyNQGh2TefG5jSrEkUulzjOE
         IE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705076193; x=1705680993;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=21WhwU0IKwpp5rHYuLTMDQxS382v9liD3E1apg8a+jI=;
        b=BhTdCSPZ3eHf6Esn9HT6TOmsoqHGWL+HxUri9XxkYD1XkJWZ3G+Jik73mF8ZA7CTQ/
         ewZ+jK7gxwUXcMf++e/pTL7L7u9bdOfS/5HuVV1tByewPKyPzG1tciPJKhNAueX8FLSJ
         GmVbEJzzWOcqJ3gGpvr3DpBwIFICgrp3btdZNqYjXu/u6AcApIuIRqlggSm7fBTRrRkm
         mHpponG3lIIo3fipFUWPG0vmaKKw5juxhkXelzOTA+SPq8nfgLDNiIi2oyH7kVVTG8Wo
         XCH7pyGQnuAAnVeoi/yIt0pDiszLTVKVfERfxcgOfvj5Hi5lkQwwMwYzRR33uGkbcdjT
         cfjA==
X-Gm-Message-State: AOJu0YwNG44jK3qXc/yYoIpbkfzWTbH2GsgrXS7zGrtemAqfBWTASKF4
	Yi5aTkAloQfzsZD/j33MOrA=
X-Google-Smtp-Source: AGHT+IFrezgLh6oo03s0GOz1Fx+Ys4atrrqqxnI+ACt0nL56PavHJL6H6GDMhMyHGo7bn5Or0ic62A==
X-Received: by 2002:a05:6a20:3ca2:b0:19a:2f62:6b57 with SMTP id b34-20020a056a203ca200b0019a2f626b57mr1440612pzj.84.1705076192595;
        Fri, 12 Jan 2024 08:16:32 -0800 (PST)
Received: from [192.168.0.4] ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id j18-20020a056a00235200b006d9a38fe569sm3354562pfj.89.2024.01.12.08.16.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 08:16:32 -0800 (PST)
Message-ID: <baa1f1e8-7fa6-fadf-584f-71f9d0b3dcdb@gmail.com>
Date: Sat, 13 Jan 2024 01:16:23 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [syzbot] [net?] KCSAN: data-race in ipv6_mc_down / mld_ifc_work
 (2)
To: Eric Dumazet <edumazet@google.com>,
 syzbot <syzbot+a9400cabb1d784e49abf@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com
References: <000000000000994e09060ebcdffb@google.com>
 <CANn89iKar6cuJAdQbL2n9vYWRL=yMQBEahfhXNVFNa0aax9OsQ@mail.gmail.com>
Content-Language: en-US
From: Taehee Yoo <ap420073@gmail.com>
In-Reply-To: <CANn89iKar6cuJAdQbL2n9vYWRL=yMQBEahfhXNVFNa0aax9OsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/12/24 21:01, Eric Dumazet wrote:

Hi Eric,
Thank you for the report!

 > On Fri, Jan 12, 2024 at 11:10 AM syzbot
 > <syzbot+a9400cabb1d784e49abf@syzkaller.appspotmail.com> wrote:
 >>
 >> Hello,
 >>
 >> syzbot found the following issue on:
 >>
 >> HEAD commit: 8735c7c84d1b Merge tag '6.7rc7-smb3-srv-fix' of 
git://git...
 >> git tree: upstream
 >> console output: https://syzkaller.appspot.com/x/log.txt?x=17948c9ae80000
 >> kernel config: 
https://syzkaller.appspot.com/x/.config?x=4da1e2da456c3a7d
 >> dashboard link: 
https://syzkaller.appspot.com/bug?extid=a9400cabb1d784e49abf
 >> compiler: Debian clang version 15.0.6, GNU ld (GNU Binutils for 
Debian) 2.40
 >>
 >> Unfortunately, I don't have any reproducer for this issue yet.
 >>
 >> Downloadable assets:
 >> disk image: 
https://storage.googleapis.com/syzbot-assets/f263d974af01/disk-8735c7c8.raw.xz
 >> vmlinux: 
https://storage.googleapis.com/syzbot-assets/9faf34fc0b3e/vmlinux-8735c7c8.xz
 >> kernel image: 
https://storage.googleapis.com/syzbot-assets/0b52a58ecd0e/bzImage-8735c7c8.xz
 >>
 >> IMPORTANT: if you fix the issue, please add the following tag to the 
commit:
 >> Reported-by: syzbot+a9400cabb1d784e49abf@syzkaller.appspotmail.com
 >>
 >> ==================================================================
 >> BUG: KCSAN: data-race in ipv6_mc_down / mld_ifc_work
 >>
 >> write to 0xffff88813a80c832 of 1 bytes by task 3771 on cpu 0:
 >> mld_ifc_stop_work net/ipv6/mcast.c:1080 [inline]
 >> ipv6_mc_down+0x10a/0x280 net/ipv6/mcast.c:2725
 >> addrconf_ifdown+0xe32/0xf10 net/ipv6/addrconf.c:3949
 >> addrconf_notify+0x310/0x980
 >> notifier_call_chain kernel/notifier.c:93 [inline]
 >> raw_notifier_call_chain+0x6b/0x1c0 kernel/notifier.c:461
 >> __dev_notify_flags+0x205/0x3d0
 >> dev_change_flags+0xab/0xd0 net/core/dev.c:8685
 >> do_setlink+0x9f6/0x2430 net/core/rtnetlink.c:2916
 >> rtnl_group_changelink net/core/rtnetlink.c:3458 [inline]
 >> __rtnl_newlink net/core/rtnetlink.c:3717 [inline]
 >> rtnl_newlink+0xbb3/0x1670 net/core/rtnetlink.c:3754
 >> rtnetlink_rcv_msg+0x807/0x8c0 net/core/rtnetlink.c:6558
 >> netlink_rcv_skb+0x126/0x220 net/netlink/af_netlink.c:2545
 >> rtnetlink_rcv+0x1c/0x20 net/core/rtnetlink.c:6576
 >> netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
 >> netlink_unicast+0x589/0x650 net/netlink/af_netlink.c:1368
 >> netlink_sendmsg+0x66e/0x770 net/netlink/af_netlink.c:1910
 >> sock_sendmsg_nosec net/socket.c:730 [inline]
 >> __sock_sendmsg net/socket.c:745 [inline]
 >> ____sys_sendmsg+0x37c/0x4d0 net/socket.c:2584
 >> ___sys_sendmsg net/socket.c:2638 [inline]
 >> __sys_sendmsg+0x1e9/0x270 net/socket.c:2667
 >> __do_sys_sendmsg net/socket.c:2676 [inline]
 >> __se_sys_sendmsg net/socket.c:2674 [inline]
 >> __x64_sys_sendmsg+0x46/0x50 net/socket.c:2674
 >> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 >> do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 >> entry_SYSCALL_64_after_hwframe+0x63/0x6b
 >>
 >> write to 0xffff88813a80c832 of 1 bytes by task 22 on cpu 1:
 >> mld_ifc_work+0x54c/0x7b0 net/ipv6/mcast.c:2653
 >> process_one_work kernel/workqueue.c:2627 [inline]
 >> process_scheduled_works+0x5b8/0xa30 kernel/workqueue.c:2700
 >> worker_thread+0x525/0x730 kernel/workqueue.c:2781
 >> kthread+0x1d7/0x210 kernel/kthread.c:388
 >> ret_from_fork+0x48/0x60 arch/x86/kernel/process.c:147
 >> ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 >>
 >> value changed: 0x02 -> 0x00
 >>
 >> Reported by Kernel Concurrency Sanitizer on:
 >> CPU: 1 PID: 22 Comm: kworker/1:0 Not tainted 
6.7.0-rc7-syzkaller-00029-g8735c7c84d1b #0
 >> Hardware name: Google Google Compute Engine/Google Compute Engine, 
BIOS Google 11/17/2023
 >> Workqueue: mld mld_ifc_work
 >> ==================================================================
 >>
 >>
 >> ---
 >> This report is generated by a bot. It may contain errors.
 >> See https://goo.gl/tpsmEJ for more information about syzbot.
 >> syzbot engineers can be reached at syzkaller@googlegroups.com.
 >>
 >> syzbot will keep track of this issue. See:
 >> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
 >>
 >> If the report is already addressed, let syzbot know by replying with:
 >> #syz fix: exact-commit-title
 >>
 >> If you want to overwrite report's subsystems, reply with:
 >> #syz set subsystems: new-subsystem
 >> (See the list of subsystem names on the web dashboard)
 >>
 >> If the report is a duplicate of another one, reply with:
 >> #syz dup: exact-subject-of-another-report
 >>
 >> If you want to undo deduplication, reply with:
 >> #syz undup
 >
 > Bug added in
 >
 > commit 63ed8de4be81b699ca727e9f8e3344bd487806d7
 > Author: Taehee Yoo <ap420073@gmail.com>
 > Date: Thu Mar 25 16:16:57 2021 +0000
 >
 > mld: add mc_lock for protecting per-interface mld data
 >
 >
 > ipv6_mc_down() calls mld_ifc_stop_work() while mc_lock is not held.

Thanks a lot for the analysis, I will look into this.

Thanks a lot!
Taehee Yoo

