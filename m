Return-Path: <linux-kernel+bounces-35013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A5D838A80
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDD5F1F22778
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE3C5A0EC;
	Tue, 23 Jan 2024 09:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="yM50sxVJ"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4AC5A0E1
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 09:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706002993; cv=none; b=eQdJv5oNfAucV9H6mVs7C4A9unlz2SzWcPoAfb7IRx6BQHsmhz1Px6aBLjxswjiLQBAOIgsWB64zv0niquuytP7Fw5Mw5EeE2jEEZMWqC5VHXHkY4GW+UEVlbFc1oblJigOZkgRkn1YELx5GNYi+9cmyDOfDcy51ynBtd0d3k1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706002993; c=relaxed/simple;
	bh=YPP0YTe/9IJFtbCkKNrxhkrt4sm0OkXTj+Zqrs0nRp0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=AJDvNV+N+kC0g2W3/JxhyAEA49UaLrf2BsE8P6qcWYiGUYRqbPV685cbgAT12nJt1blcQIIK1SxY6uUcLkkj3DR0W7WXn9QUWZxfAgu9NMdmS8H3Js0vJzrf8XaKIqth5ZBerfLrTgrbW0JRRJ1l2/fEJqjEbgxHalj+AA04bjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=yM50sxVJ; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1706002980; bh=+CRKnVcR3h+JM71OjkQUJDD8vGVitvaueNse3CJrgh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=yM50sxVJwP9FGMLfz+1b11V658hXyxPwn8svVdELsgGoOj2skeRC7Rry3gVxp42kg
	 krL4xdpZybDehMARFRNsK1CtSoO5UOnFRwusbifRZvXxYKBFdxroK71FnAVNNx/yLa
	 5hIhSeI0pLm8VK9CU3M56mh9a25T1hfSz46ULbWU=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 9E301E78; Tue, 23 Jan 2024 17:39:35 +0800
X-QQ-mid: xmsmtpt1706002775tmlm02b91
Message-ID: <tencent_EA9AECE6CEAC79FA6CAC2DDD6D0095E8EA0A@qq.com>
X-QQ-XMAILINFO: MyirvGjpKb1jsLensBhyuSzjwEXhI/W0gU14Gsp1+R0Qhxif/85j9gMCyAJQv+
	 RugVqwsNKn42/hjoCKSnvh6uFSjoahOjIK+1Opzzybw6qfGqMGMTayw9VT6c0mXWOnirDon0mTx8
	 C7hjWsXEBCIMVMp2IN/oE7n3j0MSodfTpG2/M3Quj7zukGpEJpLTyzNmOYACPOkhF80DNvhokk+M
	 ZaLitHB2F8nqWLAkl0I4PhtBAwrOYY+zpEzwTN/qwqusMmcrmVAV5/9kaj+8LYc8AweWtMVSvpEX
	 b0Eql2+bN92mGI0yzHRTGDNeo+HxIF60lQQ+CjFgSWkrIfyiresX5oftOUNkUiVE7wiYBvQGuqJv
	 mKWLghkA1hXTTqmiVUeMTjBjL7b6izGjMWqhK2cFMVNHK1m6zzdbPr4ww3JzetsmrO9eCSYkjuEF
	 Sml6+PeTwfj4RvoIDaZHX27tVhhlMQbFJIg4KjDGoBTbzMQSI2KI1A5SoicBbMoHCRJYMIvbAzjk
	 NqHUWSj/kUQjR7/rqzARLVv9Nk771RBjX/5td7dS1M2Oriy9qximGa7IG2sMcvvlRnhqAAQ7kpd/
	 NWdDAH8JrbBwuDOzX84hLDtKJtV2grtEMuEpW6sLl8pDnk2QP/l2kHPPTeNYDzIZsckeqNOYRSfV
	 NYS4VkbyF198Nm3bOeFhcRvu/9yQeqd2JIPlC8iz4eyTLQz6y8TnShthuAvaKq0WeMgTUIwzojdQ
	 bpuMMj7NmIcEyWXBfAGre5EhALwDDfh0ou/9KOWirP6+nRbQVgQ2ZYcep0Z8XkZ22kF++pSRICnL
	 mAPqmB1s5jTrB47oJAp0kU158EpDGhTjyOu20yo3zX5hk+AwjTgn6tiuhsmF1Ogte6xC0f6mHNFm
	 lxgxgk1qWoDmhU6VtH2hXMC4l2/7nIhsnUymPz42P1+SL5s8eTrx0bpge528jdEx6UHpGaxfKkAB
	 FQh03KxhHDhgLCkyfYeA==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+1d37bef05da87b99c5a6@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [can?] memory leak in j1939_netdev_start
Date: Tue, 23 Jan 2024 17:39:35 +0800
X-OQ-MSGID: <20240123093934.3441462-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00000000000060446d060af10f08@google.com>
References: <00000000000060446d060af10f08@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test memory leak in j1939_netdev_start

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 14c431663233..1d1f1348eeca 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -141,6 +141,7 @@ static void j1939_sk_queue_drop_all(struct j1939_priv *priv,
 				 sk_session_queue_entry) {
 		list_del_init(&session->sk_session_queue_entry);
 		session->err = err;
+		printk("s: %p, %s\n", session, __func__);
 		j1939_session_put(session);
 	}
 	spin_unlock_bh(&jsk->sk_session_queue_lock);
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index fe3df23a2595..0b09bf60b08b 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -278,6 +278,7 @@ static void j1939_session_destroy(struct j1939_session *session)
 
 	while ((skb = skb_dequeue(&session->skb_queue)) != NULL) {
 		/* drop ref taken in j1939_session_skb_queue() */
+		printk("s: %p, skb: %p, %s\n", session, skb, __func__);
 		skb_unref(skb);
 		kfree_skb(skb);
 	}
@@ -1552,6 +1553,7 @@ j1939_session *j1939_session_fresh_new(struct j1939_priv *priv,
 	/* alloc data area */
 	skb_put(skb, size);
 	/* skb is recounted in j1939_session_new() */
+	printk("s: %p, skb: %p, %s\n", session, skb, __func__);
 	return session;
 }
 
@@ -1758,6 +1760,7 @@ static void j1939_xtp_rx_rts(struct j1939_priv *priv, struct sk_buff *skb,
 		j1939_tp_set_rxtimeout(session, 1250);
 	}
 
+	printk("s: %p, %s\n", session, __func__);
 	j1939_session_put(session);
 }
 


