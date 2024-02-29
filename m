Return-Path: <linux-kernel+bounces-87132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E5186CFF6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39C2E1F23412
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768867A12C;
	Thu, 29 Feb 2024 16:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="g939HP+w"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A75C5B1E7
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 16:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709225914; cv=none; b=SpkewvW7UIbhDsraRSwMPLsuoMaAjeo/7xbFJK5c8CeS1dvKZhZQ251Kyp7ERvcG6PChZElT2hnnl/MSODIsQ2TmJzIwLPpyYCu3hHU5O35EjkhtZwetal8heyEW/ajqyq/RW6ew5sA2FFlsa/V3G98/W7fA8eRmb0fSSA/qaG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709225914; c=relaxed/simple;
	bh=rLcg+QFxMO4tfDr/Ll/BSdaEnJ9/peAnLuEhE/ktC7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWqdFbo+/cLSX0jgFT1vFN45Wg+23461tRS41RLkboTw10Qtz/s8x5LRQbwQst4YQk7v/NOjNmMNLos3slABSziUfT9Rdt0USfZDN3nViT9t4ZwlUFuvEMApLcv8opk7MhGVK79m34ArKgXz4ysaLNHjEAnvIeucqp3TsiGvr/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=g939HP+w; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5132010e5d1so1242975e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 08:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709225909; x=1709830709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UHaD3gz7UZ3gDZtHuuClG/CvFKBpOvfiky+iLvUCPh8=;
        b=g939HP+wEJ9s1s1koAiQhg0iR/44hT9HPXk4d8pFUXvBZNXRQK2q8BpdowxPIwEUWx
         RP4XRhtnmnv38B9ZI9xQh1fxEvKJ6s/aFZNOnFn1wdOkkMbuqROwXBAwmTo9I9Uh5Qf7
         d5RUGAUNb9Ctn44KfUWxTb7durLpJOf4tZRmFIUrMqwxpnoS6bvC4KseflC9ezXrEMI2
         gDYc0cQX+JWwLcbRs6cWIbr6nAsI6GyNEOxfbjESqkbUFjMUnEjV12DB0OApXJn8T0QT
         6qggi+PiBbkGK1Nh3uABH/97hQRGfyeuT8ThLR41CtiQNPKBKO36qPES7EKlOcVvg9Gl
         d3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709225909; x=1709830709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHaD3gz7UZ3gDZtHuuClG/CvFKBpOvfiky+iLvUCPh8=;
        b=q6GoWMkI4BcuDbeQoNakVKmpWV2vANbb1/fuYLfGPPS5kB4YyeoTlFHZJ7reH8wrEm
         UVVs/znk8Cc9oG/YY09megi9qPHkQ188QoWneojNGxDcjG3kigyEn9CytRJRyZGmz2cl
         WvRUeavACzGE7q37bqWEMZX6mxffa5QBCqCGnEgXKxbbJXZu+7oWH0MJJgr6SL1hVVRa
         1fqdF4nv/5PP+Qlrn+Sr1rBMClpCVWf+hlVOu2+kPYH91kVd7WuJG5bbEvDG53XbeDLs
         Nb2iQs/S6guLumIGWxEiQ1edSevmWTwOXPSJPYUPRSu5e+ISPxT2FyOqEJ9T2G9hsjcf
         MbrA==
X-Forwarded-Encrypted: i=1; AJvYcCWsN/SAtMw6V0qXh7/L4Bm3K8P/NRaUgGrmTsmmtQ7t/aTAjKC4ul09L1TdZ+ovo6s+HFTLA6NU9gWJSEiZYcQIhJfEi3URZQh5bDYn
X-Gm-Message-State: AOJu0Yww/ay1Vnug6LC3A+Zcq9BMv35/uW3TLTqMjXjID8L+Cvg6FKnz
	4j0ZOngjMYN3I0dJJOoogzMYigIMIhgNrMFv4s9FFFalaojRVoAhVOuc31psZ10=
X-Google-Smtp-Source: AGHT+IFS/gHlHbP8qb9npNeK/79DqgVLrHzdnFqgu0ECL5vdficQaV0eujo5UT9w6GvBSKjKWVVUqw==
X-Received: by 2002:a05:6512:481e:b0:512:f2c5:6 with SMTP id eo30-20020a056512481e00b00512f2c50006mr1712001lfb.6.1709225908758;
        Thu, 29 Feb 2024 08:58:28 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id u2-20020adfeb42000000b0033b483d1abcsm2206252wrn.53.2024.02.29.08.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 08:58:28 -0800 (PST)
Date: Thu, 29 Feb 2024 17:58:25 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: syzbot <syzbot+3c47b5843403a45aef57@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] possible deadlock in team_port_change_check (2)
Message-ID: <ZeC3sSwEcZSfh0fz@nanopsycho>
References: <000000000000a97e9f061287624c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000a97e9f061287624c@google.com>

Thu, Feb 29, 2024 at 05:02:25PM CET, syzbot+3c47b5843403a45aef57@syzkaller.appspotmail.com wrote:
>Hello,
>
>syzbot found the following issue on:
>
>HEAD commit:    2a770cdc4382 tun: Fix xdp_rxq_info's queue_index when deta..
>git tree:       net
>console output: https://syzkaller.appspot.com/x/log.txt?x=11bfb032180000
>kernel config:  https://syzkaller.appspot.com/x/.config?x=eff9f3183d0a20dd
>dashboard link: https://syzkaller.appspot.com/bug?extid=3c47b5843403a45aef57
>compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>
>Unfortunately, I don't have any reproducer for this issue yet.
>
>Downloadable assets:
>disk image: https://storage.googleapis.com/syzbot-assets/54ceb0944449/disk-2a770cdc.raw.xz
>vmlinux: https://storage.googleapis.com/syzbot-assets/69b79e7b7a86/vmlinux-2a770cdc.xz
>kernel image: https://storage.googleapis.com/syzbot-assets/dedbc599c2f7/bzImage-2a770cdc.xz
>
>IMPORTANT: if you fix the issue, please add the following tag to the commit:
>Reported-by: syzbot+3c47b5843403a45aef57@syzkaller.appspotmail.com
>
>============================================
>WARNING: possible recursive locking detected
>6.8.0-rc5-syzkaller-00129-g2a770cdc4382 #0 Not tainted
>--------------------------------------------
>syz-executor.1/20275 is trying to acquire lock:
>ffff888045338d00 (team->team_lock_key#2){+.+.}-{3:3}, at: team_port_change_check+0x51/0x1e0 drivers/net/team/team.c:2997
>
>but task is already holding lock:
>ffff888045338d00 (team->team_lock_key#2){+.+.}-{3:3}, at: team_add_slave+0xad/0x2750 drivers/net/team/team.c:1974
>
>other info that might help us debug this:
> Possible unsafe locking scenario:
>
>       CPU0
>       ----
>  lock(team->team_lock_key#2);
>  lock(team->team_lock_key#2);
>
> *** DEADLOCK ***
>
> May be due to missing lock nesting notation
>
>2 locks held by syz-executor.1/20275:
> #0: ffffffff8f3759c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
> #0: ffffffff8f3759c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x82c/0x1040 net/core/rtnetlink.c:6615
> #1: ffff888045338d00 (team->team_lock_key#2){+.+.}-{3:3}, at: team_add_slave+0xad/0x2750 drivers/net/team/team.c:1974

Interesting. Looks like syscaller is adding netdev to team when the vlan
on the same netdev is enslaved in the same team. In real life, does not
make any sense at all. Will try to fix this deadlock tomorrow.


>
>stack backtrace:
>CPU: 0 PID: 20275 Comm: syz-executor.1 Not tainted 6.8.0-rc5-syzkaller-00129-g2a770cdc4382 #0
>Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
>Call Trace:
> <TASK>
> __dump_stack lib/dump_stack.c:88 [inline]
> dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
> check_deadlock kernel/locking/lockdep.c:3062 [inline]
> validate_chain+0x15c0/0x58e0 kernel/locking/lockdep.c:3856
> __lock_acquire+0x1345/0x1fd0 kernel/locking/lockdep.c:5137
> lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
> __mutex_lock_common kernel/locking/mutex.c:608 [inline]
> __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
> team_port_change_check+0x51/0x1e0 drivers/net/team/team.c:2997
> team_device_event+0x161/0x5b0 drivers/net/team/team.c:3023
> notifier_call_chain+0x18f/0x3b0 kernel/notifier.c:93
> call_netdevice_notifiers_extack net/core/dev.c:2004 [inline]
> call_netdevice_notifiers net/core/dev.c:2018 [inline]
> dev_close_many+0x33c/0x4c0 net/core/dev.c:1559
> vlan_device_event+0x18b7/0x1de0 net/8021q/vlan.c:449
> notifier_call_chain+0x18f/0x3b0 kernel/notifier.c:93
> call_netdevice_notifiers_extack net/core/dev.c:2004 [inline]
> call_netdevice_notifiers net/core/dev.c:2018 [inline]
> dev_close_many+0x33c/0x4c0 net/core/dev.c:1559
> dev_close+0x1c0/0x2c0 net/core/dev.c:1581
> team_port_add drivers/net/team/team.c:1312 [inline]
> team_add_slave+0x1aef/0x2750 drivers/net/team/team.c:1975
> do_set_master net/core/rtnetlink.c:2707 [inline]
> do_setlink+0xe58/0x41c0 net/core/rtnetlink.c:2913
> rtnl_setlink+0x40d/0x5a0 net/core/rtnetlink.c:3209
> rtnetlink_rcv_msg+0x885/0x1040 net/core/rtnetlink.c:6618
> netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2543
> netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
> netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1367
> netlink_sendmsg+0xa3b/0xd70 net/netlink/af_netlink.c:1908
> sock_sendmsg_nosec net/socket.c:730 [inline]
> __sock_sendmsg+0x221/0x270 net/socket.c:745
> sock_write_iter+0x2dd/0x400 net/socket.c:1160
> do_iter_readv_writev+0x46c/0x640
> vfs_writev+0x395/0xbb0 fs/read_write.c:971
> do_writev+0x1b1/0x350 fs/read_write.c:1018
> do_syscall_64+0xf9/0x240
> entry_SYSCALL_64_after_hwframe+0x6f/0x77
>RIP: 0033:0x7ff40be7dda9
>Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
>RSP: 002b:00007ff40cb2f0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
>RAX: ffffffffffffffda RBX: 00007ff40bfabf80 RCX: 00007ff40be7dda9
>RDX: 0000000000000001 RSI: 0000000020000400 RDI: 0000000000000003
>RBP: 00007ff40beca47a R08: 0000000000000000 R09: 0000000000000000
>R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>R13: 000000000000000b R14: 00007ff40bfabf80 R15: 00007ffdeb79a408
> </TASK>
>
>
>---
>This report is generated by a bot. It may contain errors.
>See https://goo.gl/tpsmEJ for more information about syzbot.
>syzbot engineers can be reached at syzkaller@googlegroups.com.
>
>syzbot will keep track of this issue. See:
>https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
>If the report is already addressed, let syzbot know by replying with:
>#syz fix: exact-commit-title
>
>If you want to overwrite report's subsystems, reply with:
>#syz set subsystems: new-subsystem
>(See the list of subsystem names on the web dashboard)
>
>If the report is a duplicate of another one, reply with:
>#syz dup: exact-subject-of-another-report
>
>If you want to undo deduplication, reply with:
>#syz undup

