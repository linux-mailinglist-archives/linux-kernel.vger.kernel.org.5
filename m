Return-Path: <linux-kernel+bounces-34975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B42B5838A1C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 693681F26AB5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516F25811E;
	Tue, 23 Jan 2024 09:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="G7wO2Lz3"
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120BF58114
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 09:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706001532; cv=none; b=r3xirEbwWRQqRdQUl4HVomPKUduvBCTZy8OtWm3nU9TOz6eVZIfValt/H9RKtaueQZW6K+6UI0S18pckBTuNhB4MqER1GskmG+pw6fBPmf3oZ0jtruMbrFCrsGWtCYYqsjjEohl8j4uX9WiyhFOKN1Vt5YHPfsVpbSdlfoLFU1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706001532; c=relaxed/simple;
	bh=aAGgqY+rMgNNKy/gloryFu6vmcVkrONZJRen5Osj/5g=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=GmY3+YEkpn54Wv8z8OMzdATe7OKj65MGkPEV/f1k+3Wd7rtGidoIof79SUQHkZz0wE418/XZOMGLbNe3nVUh+q0APtqlxVrnZNQVVDyx5X6MFYKXY0PZasi59JW9zafts5WhH3wB4Zjmdm+56BW3kApDerefwZq8KKVWPSS+5qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=G7wO2Lz3; arc=none smtp.client-ip=203.205.221.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1706001521; bh=lRy1jxHb+0LX8QlNoKRPQZV2gc3nzm5+xpwR2/5JSv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G7wO2Lz3CkLxn0xusWOu5zb5pAPXvazpIhu19EBDanI8OTZBvGCHknhtiOGijeaCd
	 N65k/0HhzCQeZvqJ/Ob27tTO+BYe6P0YiLUy3vN3FEV6MktaXSGt7nk5Ci8sOwUkOx
	 /SBcesXchf7+gEj9BPEdcj9HIse1mcuoeKuXu0zs=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id 30A1ECEB; Tue, 23 Jan 2024 17:12:10 +0800
X-QQ-mid: xmsmtpt1706001130tlxq65waw
Message-ID: <tencent_9744F767376B06D113772362E96A43A14405@qq.com>
X-QQ-XMAILINFO: NDAhN78L72+TYqMQdjygMcxuOS7nTfYfezPpsRaKCR5Rtrat2VeFEc2yYeNarE
	 UoJEfvayF6lYml1+u373ay0v7UjLPyDEJuPlYkmK8DnhypOgo2QudPORberPvYgMQSNnke2ns4Jv
	 g8UnYXuoYNHYG/pZ3tF2a9pKRG/TWz1aO0lAQQIFuOPo6WKTAzA7HhgPrRtzehCNMc2e9o9p5huG
	 gB6KFELNBR87bYPrqBzYbNDrrk3ITLlRE/ks5adfdbBMVtBGhuv/UAHMR698pMHba/ge3+WQEu23
	 gLwO9Npm4+umWFRpxP+6WPbzR2WzfJFvuu4wWBV1KUD0fC9jj64yrJ+iiZnc7M8jIdGgIEaMKlSu
	 jVo07cJVpBgfy1zPoT9wPWFFsNU0ZUXrLgpClQofG1OLLbPykPRNENoa1xqudz2PtxZG5DOsatJV
	 HEyaR7ttE1ROV4DRUW5X59qWrfncp/gO+hGk1L0gwjwMoOef7jjPdB529A3a2AwC8vxgpZNjAJTn
	 1LeKbCVNG4yJXzibyWExXQ9DyjzdYI6pNTVzaVjXeG3k/GGD+jrqzrce+LF2VQ0hevnhqU2ICYwc
	 wbWax38C3r2Lv2iCdk/6UpXFKXwv1hAhfDWdSSyOmiG25uD2WfnFHUBwjweFh95ZyMFydTgrhG6v
	 79QvBnN5UmqbCpYI7buXFEPIfSFeYv2/iDHA7ZHGsOMscXIHSHPBCWxmTPe2bd2Ut5+Ufhy9vxQ6
	 ExeztAnh+hIBKZa2ckdEubGyaYT+WxR57jirEA5DMybjiwMLu9V95HxhBpqIGqD99onvi4EOsQfX
	 Auzhpxln1G/9ezCNp5xsAbGIekliFJ80qBDDiZEeVlgbNb2f1HToN23tkughbBbGeb0we6tQuBfI
	 pjEZlF7zN/cT0t2Okb0Sj+jB1cN3GFcgcvnDdy5OQEgejznx/2wI0C6pMx44khoKdaFr+TZ+TQ
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+1d37bef05da87b99c5a6@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [can?] memory leak in j1939_netdev_start
Date: Tue, 23 Jan 2024 17:12:11 +0800
X-OQ-MSGID: <20240123091210.3404807-2-eadavis@qq.com>
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

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 98b1cc82c4af

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
 


