Return-Path: <linux-kernel+bounces-89749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A8E86F515
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 14:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 518431F215EB
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 13:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4B210A0F;
	Sun,  3 Mar 2024 13:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="eBPo8idw"
Received: from out203-205-221-249.mail.qq.com (out203-205-221-249.mail.qq.com [203.205.221.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41A6101E3;
	Sun,  3 Mar 2024 13:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709472247; cv=none; b=nLObS+pQP9lJ6XfBOLmedPMjyzySJwjJzGmVTfjQuRn2i9uJo3Fs2GLebc+3Tcvyy8b3sfA87aPbBsZkT9hrz6c4hUKZw43kZa7Qhkjla2B2YKYWw9eJxMvlpY9IiT0a6UcWZbSzI2Q6yW/n2VoYupP9rdLYVWiMXNAjfzt/tJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709472247; c=relaxed/simple;
	bh=G/uUIcpfGezZClHWnrZDD9K0NYrXcF/UXKZ/8huSANM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=lBOw/uDlgxnekWKLmZWgAsGq041Vk1YDLVWw1kPWA2nQ/tLUJDq6cS81ImppwIiDYE4XdpbJ2nL9TnYYZIXv029QjSrzzSRsHlEZZhbZ4gz0eTjZ4dtsD7k/DM646oRux3zC9EQDQrB0UbKV4Mo+JREO6wMPTeRW+O/ZDnkwaEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=eBPo8idw; arc=none smtp.client-ip=203.205.221.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709472241; bh=Uo6+rVGqUfEBi3BWpquQslrkKBAv6/iFpXZsRLuvnJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eBPo8idwVoLhTJ7X/bqvn7JnBbFiyJiyoNYw7fNldKYN1UcFh33Gkkp6vIgdCa024
	 bU5JedGe+MaGryxQ5y+doWoUSAfrXoGyoeR4YNYToAVwXEIkpBTVqA5JZHBnERFgjR
	 KuZIaMgFErJ9+CE+qw4nfoe5grhCvaEf9xfKE0ms=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 5FA2D2AD; Sun, 03 Mar 2024 21:23:58 +0800
X-QQ-mid: xmsmtpt1709472238t63b8jqob
Message-ID: <tencent_ECF3CC90A7DB86E312FF464F09BF2EEAAE06@qq.com>
X-QQ-XMAILINFO: M/NR0wiIuy70vNwuqXnPcAATd38i+Hrt5nu5F7SU8jslSYo5IjGQa9TJ1wQdik
	 Oun75WagS/8ZoK0TZ7S1N26r7C7sQE3LlrldG+1Ni9cHqmW/1dtGJmFd7UNuMZXRX03nR6tjf6nA
	 BnnVJPZa2IoJlmcNLillPdbFwsQOwMDh9kyCqBQG/msZVSusQJvScF4tHHYlu/2IfLMBIIvUn5zs
	 u2Nok8SVFOhjq7ThRqQJXlQGzDE18FVcc2e4NZ0+AT80PawnfU6XqBpXgAK9lCe4Ui12sCoBt+xJ
	 SRhCDFF/EZn3F9tLhtpDb97HlKYOWtD2XiGBBvK6dXX0WXh5oTqA/+5R2XzHW4ORYsdPVEfFeEQc
	 zlURosOWssYK+doMORe7kF2mpYo5atBOdIniDzcnmdnhh5FPoyo5xknvGSXj7kRSaqzNOIj4kwjg
	 bAQoXWnD3MWFghthM8RIdD/BJ2RqM47nkak/qSS9QTU8m/UTg4YD0he5Cbzlt8dkm4jQU3X1Ujg/
	 glXwh8TTz5zbpCAlqUDmSPanlfwYwMrlQ6GM7H0vu9CYQIm6SoP+kXBBjmMmQwRI5G0j0MyoY4xN
	 /yvSmoRZEIkVUzyAZ/21MmcqQzRzhvvJXvO3vGD+z9hUFRHiyvK/hczX4tk3cNgpx3g3pZcMIlg5
	 433FZruVXIFy3NhdSe5VX4/eQ9dBqzxXQgECQKWtiSw35fPcNrZ3qONr/wk8rIsbs4Vy86fZgFCi
	 75cxqlmiJydXeQ6tbx18hWcPgIvt/eQaUV71fUs3BpIRlhWONxsJ0AuXsW8e7beuuec2jS316bAd
	 UNn7g4SuVUbUK7ERPTH8UHsd/3Jx4od6GXy1w/UPe0sqhGtMaNDadVn9ju131bMEFNVcOCS6x2k5
	 1AY3RHKTYJ3MhCUWEQ8gvV4daC84OVxywA0W6PaWBZZUOKIaQ0dAw1gNkPEuGmGwW+/eSL1UDa2J
	 TW1DCnPf99xozrFY+0mPKrqjkmOCdlTgBc5lXrlHS3/Nplmen0p/yVRQJ0R6nc
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+f770ce3566e60e5573ac@syzkaller.appspotmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	ralf@linux-mips.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] skbuff: fix uninit-value in nr_route_frame
Date: Sun,  3 Mar 2024 21:23:59 +0800
X-OQ-MSGID: <20240303132358.639892-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000b69bf20612bf586e@google.com>
References: <000000000000b69bf20612bf586e@google.com>
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


