Return-Path: <linux-kernel+bounces-36271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0574839E3D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26D601C25671
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11A51381;
	Wed, 24 Jan 2024 01:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="w7rjGixl"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C8210E6
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 01:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706059789; cv=none; b=hS8/rq7p6EVWvfqj62VxdLMYOOHiwEovCG+lbFBL4juQScL67CLPJMQOLQ1l1W8EVrA2mm2B0G8mOcdu1GTV8VgKqZEPJD30Qm9ANChPwAhxlDJWCIQz5XV4RI/DefdnSfw0V/q6Lq+BlVzTbR75AchdQ54VQz/wlRFY8tg6BvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706059789; c=relaxed/simple;
	bh=LE66kJu4hVpSN+qHT1WdB0wFdWHrCE8XWrvd+6Kcc0Q=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=JCV/PbbiVqD/75fx50nVgaJoRxqZDRUkAxUFLEHxFXH3z1hWI9DAIOKJdmiwQ7usQpznsqReZeUGaiHsxRKiPuC7z1C53Q1dmZfE27ZC2HYaIJupuvr+rC9e9ha6e9x5tgwrxmBPKxbSXmo9wn86yEmpymNRYbPVt37tvYzQxPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=w7rjGixl; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1706059475; bh=4fR2pMO3VZ6t+WGmY8/iEYyP0Wk8N6+SImSjNbWePos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=w7rjGixlbaXETWH/m3Jm+DZVD75hTizmYRSnjTIKFAxubwGq96uXRtGsybU9impjK
	 SaRQAZYm+YJEALn0oKxDvgBgNvnfLWdufPJhbgT6LOKmz2rjWE6CISxOhTplipIOib
	 RS+6h0mO1LucVOyqC9mlKwM34xJoIHJFWA1ZaFNI=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 6211A428; Wed, 24 Jan 2024 09:24:33 +0800
X-QQ-mid: xmsmtpt1706059473t4llu2rh7
Message-ID: <tencent_748DB7122CDDCBDDB29965CF870D9225BF07@qq.com>
X-QQ-XMAILINFO: MesT5uKpDagVPJ3kolclE5lfPKVB+RJ86Ll0dZN8DGO+bfPoIOw4FoKeKB2kBW
	 ta3FFa+wUFL6bR//Yk67I1fPVte2rLCuURZUvgMkRQ5nqs4i5/uMFAzFbeN2iTNUru4HEvyjObEG
	 8GWGxP0ucilLjcAIpHNkTHhwti1tM/x32rU9Nt+sWm9NFgmVy42XwiabmhmgDpUp3NQXPIs189Od
	 bqVBEvIPlL3iCCiqQEBNI5ne4ZqRg6FQIO2eTwtclJtQ9XOAJaTSAtMxwYqI/2vejzODE6SMsioJ
	 YX+kqRgXZ5t71RCQra197FTDycvHHn33aYhPCi7oL/dbixpp1uFluJglEZ3KYubabjlgGlml3o3p
	 1KekFiJNdhjs2f9uaFzcThUcgZBVTCqjDUOkD+HXyiPQRGjYZOS8nEy0rMdi9X91a2YNg2J/3xfY
	 SQN7Xhky5vPFpH2x49u0hqq4Zsz32C6ezpFx8MA3dPwgohUIiy+woU67lkDaFox/2GLPcHU5AYU3
	 uwmCKni4J1TdSvNVGHnFL73ckw44ErC/1wYVkaB5uuA2Tb04ze2RX7ZPsxpoKp1Kw6pdPI2CnfbP
	 Ud/lothlbPePNjqelw79MO8T1Bxqd3bJNshHMYs+WwZJ9ri4J9HE8urYZAXH9389YpEwJUfta0Gt
	 6GtsqkRJ+lC2VtT2JV5WQB/bahnTIzBEkF27p70Olj9vGOgQgL3oXkv0yf3pXUcZL6u+/5oujM1C
	 nMofPzlmx4JlphiJyNPj03L3E6NAIfqOI7lCqM2hC3ZrqP+B6/8k9lmu9r/yoBLUNlRhPbqaBudj
	 etRpx0FHCehn6Yi/414pXhIdd/AyrlUz7tqwG7IXiKp0J/bp875nVoereskSydVUTTWlXsCV94fw
	 5QsQT8AlPIYDG/IbljIaVL0HflZxKQF8bQMOmoJKBmtvnsyAs2897cyYxbIELabi/y2Hg5IagL
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+1d37bef05da87b99c5a6@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [can?] memory leak in j1939_netdev_start
Date: Wed, 24 Jan 2024 09:24:34 +0800
X-OQ-MSGID: <20240124012433.4165387-2-eadavis@qq.com>
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
index fe3df23a2595..4e5f6037db46 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -283,6 +283,7 @@ static void j1939_session_destroy(struct j1939_session *session)
 	}
 	__j1939_session_drop(session);
 	j1939_priv_put(session->priv);
+	printk("free session: %p, %s\n", session, __func__);
 	kfree(session);
 }
 
@@ -1552,6 +1553,8 @@ j1939_session *j1939_session_fresh_new(struct j1939_priv *priv,
 	/* alloc data area */
 	skb_put(skb, size);
 	/* skb is recounted in j1939_session_new() */
+	printk("s: %p, skb: %p, size: %d, csk: %d, %s\n", 
+		session, skb, size, sizeof(struct can_skb_priv), __func__);
 	return session;
 }
 
@@ -1758,6 +1761,7 @@ static void j1939_xtp_rx_rts(struct j1939_priv *priv, struct sk_buff *skb,
 		j1939_tp_set_rxtimeout(session, 1250);
 	}
 
+	printk("s: %p, %s\n", session, __func__);
 	j1939_session_put(session);
 }
 
@@ -2005,6 +2009,8 @@ struct j1939_session *j1939_tp_send(struct j1939_priv *priv,
 	if (!session)
 		return ERR_PTR(-ENOMEM);
 
+	printk("s: %p, size: %d, %s\n", session, size, __func__);
+
 	/* skb is recounted in j1939_session_new() */
 	sock_hold(skb->sk);
 	session->sk = skb->sk;


