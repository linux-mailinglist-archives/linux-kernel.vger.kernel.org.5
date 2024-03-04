Return-Path: <linux-kernel+bounces-90052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 785B986F966
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 06:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DAC51F21909
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 05:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66C06FBD;
	Mon,  4 Mar 2024 05:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="BsMurF+d"
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D222946AD;
	Mon,  4 Mar 2024 05:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709529004; cv=none; b=cRBgobY/sEspavqlsiQS47PNlcXcMVxPbCD74F1bvaYFxOHD2oeGCW0j9AUgP/KE8ZLJ+6YwayUteNz26e7emysEYGGPiDk5VjxXRYS04bj28UqsWmaYs2+OZvT57pyCSUdqej5MbgjSYVCIwtQLzOHWdByDX2W9+WPRWl6Ybf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709529004; c=relaxed/simple;
	bh=G/uUIcpfGezZClHWnrZDD9K0NYrXcF/UXKZ/8huSANM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=rRhG8TmFolY1QzeMIvFxcnffnV9TmGF9f9w2BtZMZXwNgpbRDHSRDkZELvJMieTjjajoFI6qImsnVNpIBoYRUo9u+GlB+Yf7hidg51D45pO+gVmm00AvEhg9cKWRnlOij7rJvTF+hRHXFlb2b0N8j0v7IHwgULRoslXocnUwH9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=BsMurF+d; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709528691; bh=Uo6+rVGqUfEBi3BWpquQslrkKBAv6/iFpXZsRLuvnJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BsMurF+dAlUa39T20GoIub98PkcvLTh9NbQkMObuhCHwtGlUGwhojN1b4BMEwY5UC
	 JdiBcyPI5ArAC4LBrPXBRcOYGM63wYtnFdwVHeKMfDev76jzp53Z4cbeJu97Wm2Yfd
	 0AZrX93TgZpLs+JITlZIkeHs3TP25mpEt/ejFxjw=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 12F9C638; Mon, 04 Mar 2024 13:04:47 +0800
X-QQ-mid: xmsmtpt1709528687tnp1fwg6v
Message-ID: <tencent_FD84E7D8C6D392F1C66E89816EF36ED48C06@qq.com>
X-QQ-XMAILINFO: NkHKfw09D6j8L6Vf18I52L5AstsLXhNSNv1IFN95prqdn7p8CrYmjPJc7qeqCI
	 6+CwfYyItX5blQhwk0B2JPeRrbw70RW+B0g7+BNEGhCr0Dr0bPE98UvTf/fUWHwks8os6lM4K8/0
	 P2YejYU+PTDZ5XHCbpq8/gKSiXNTZtZue1b6LoilLQPG5nRvcmiVjZDE4Th2bk2BCwiaIbWx01EB
	 oXiNL3EgFGevORNRomYUutnH1fyCZ+Nna3oOzvMER8wsAejB54iUT+C0qN6o3Z3meiCdHpaoWVfg
	 /1WuTs4tmAHor12GkXz/4xzssJkUrTVx32pUj4LIuWOB/rGtURnR45FrVYkGl32LF67B6d5UEo51
	 OA4Myv1/DhZmKlhRcLo9sJ8h3HC9bD6cXpVuNsChF79yUfanFfeAi9J2MxHKaDbxNdYSSkXqNNhX
	 gJEh6WOI66t8K5ZTV8Jh11KW+/+d0UZ2ycdAX1vQ9LBuomhs/R3lXn5Y8SMgPQ7urj8Txs+AnWBd
	 nrIemF62rxbMyw0URkss4g9Imyh8KpgV9WG17K/GQdzUw2band0qBDPO1WuVzPbkt1bsSgxBC/hv
	 9I4LCe/baMolmXC9K1brXSe7h3S3ZRUbSUct/nZ4L1kAsrYT2W9BBl4AFRx0Qvnxmae/Q20+34Cr
	 lxIW14JzgqhqqUgdoISMgC80rEiJDM3ieTPTgi+BI99e7ybRRk1UJZWuyI9eO3JZjsWL23HvE84r
	 QMfLiqrcwZ+4Cw18dpfTzBqBdPvxOEdy9LvatFc190wTXWCDFoZuMrOcs4o85rltzrmbHibpBh1c
	 WkuR1whUeIBwYKTllNFxwI9SrKCWssfXd2N31gGkJ89igk9dQ70lPAZ7/Xx7TGPK1arjd6VQgyz9
	 OYaaVVRmzuAsaCQhjv0KxqkuhDwKCRHszGPEUWnH7SAVrDvkPq68aepldSC+ZtbYa0x2R9F6DIcc
	 QvbcPROXLCGPjtLr8ySvSxd4EfPj84nSeARKoNRdadvUwrHHL/faWXo2u3UB0s
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: edumazet@google.com
Cc: davem@davemloft.net,
	eadavis@qq.com,
	kuba@kernel.org,
	linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	ralf@linux-mips.org,
	syzbot+f770ce3566e60e5573ac@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] net/netrom: fix uninit-value in nr_route_frame
Date: Mon,  4 Mar 2024 13:04:48 +0800
X-OQ-MSGID: <20240304050447.1211572-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CANn89i+fJis6omMAuEmgkFy7iND97cA8WecRSVG6P=z15DpHnQ@mail.gmail.com>
References: <CANn89i+fJis6omMAuEmgkFy7iND97cA8WecRSVG6P=z15DpHnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[Syzbot reported]
BUG: KMSAN: uninit-value in nr_route_frame+0x4a9/0xfc0 net/netrom/nr_route.c:787
 nr_route_frame+0x4a9/0xfc0 net/netrom/nr_route.c:787
 nr_xmit+0x5a/0x1c0 net/netrom/nr_dev.c:144
 __netdev_start_xmit include/linux/netdevice.h:4980 [inline]
 netdev_start_xmit include/linux/netdevice.h:4994 [inline]
 xmit_one net/core/dev.c:3547 [inline]
 dev_hard_start_xmit+0x244/0xa10 net/core/dev.c:3563
 __dev_queue_xmit+0x33ed/0x51c0 net/core/dev.c:4351
 dev_queue_xmit include/linux/netdevice.h:3171 [inline]
 raw_sendmsg+0x64e/0xc10 net/ieee802154/socket.c:299
 ieee802154_sock_sendmsg+0x91/0xc0 net/ieee802154/socket.c:96
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2584
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
 __sys_sendmsg net/socket.c:2667 [inline]
 __do_sys_sendmsg net/socket.c:2676 [inline]
 __se_sys_sendmsg net/socket.c:2674 [inline]
 __x64_sys_sendmsg+0x307/0x490 net/socket.c:2674
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3819 [inline]
 slab_alloc_node mm/slub.c:3860 [inline]
 kmem_cache_alloc_node+0x5cb/0xbc0 mm/slub.c:3903
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:560
 __alloc_skb+0x352/0x790 net/core/skbuff.c:651
 alloc_skb include/linux/skbuff.h:1296 [inline]
 alloc_skb_with_frags+0xc8/0xbd0 net/core/skbuff.c:6394
 sock_alloc_send_pskb+0xa80/0xbf0 net/core/sock.c:2783
 sock_alloc_send_skb include/net/sock.h:1855 [inline]
 raw_sendmsg+0x367/0xc10 net/ieee802154/socket.c:282
 ieee802154_sock_sendmsg+0x91/0xc0 net/ieee802154/socket.c:96
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2584
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
 __sys_sendmsg net/socket.c:2667 [inline]
 __do_sys_sendmsg net/socket.c:2676 [inline]
 __se_sys_sendmsg net/socket.c:2674 [inline]
 __x64_sys_sendmsg+0x307/0x490 net/socket.c:2674
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

[Fix]
Let's clear all skb data at alloc time.

Reported-and-tested-by: syzbot+f770ce3566e60e5573ac@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 net/core/skbuff.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index edbbef563d4d..5ca5a608daec 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -656,6 +656,7 @@ struct sk_buff *__alloc_skb(unsigned int size, gfp_t gfp_mask,
 	 * to allow max possible filling before reallocation.
 	 */
 	prefetchw(data + SKB_WITH_OVERHEAD(size));
+	memset(data, 0, size);
 
 	/*
 	 * Only clear those fields we need to clear, not those that we will
-- 
2.43.0


