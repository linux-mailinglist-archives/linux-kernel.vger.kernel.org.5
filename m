Return-Path: <linux-kernel+bounces-109807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14ACF8855F2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9179CB2172D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7348200D9;
	Thu, 21 Mar 2024 08:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="AH/OJooV"
Received: from out203-205-251-53.mail.qq.com (out203-205-251-53.mail.qq.com [203.205.251.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58711B274;
	Thu, 21 Mar 2024 08:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711010742; cv=none; b=OWFG/Kkkvn8+7VDV6enGynbqrksoApo8OL3PJleni3zmv18GzsUdNfulnz/+a/C4qwQ+Pd2w2ESuMd2YG4uxy7amgmVIsDK1f1c/roMZc8sXVPPiS1zrWDZeKBqoCKT6gx3OohlCy+5RrRVZZbFqm1noPAzYtUjd9vunBMdsRNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711010742; c=relaxed/simple;
	bh=g+LZfdeazFTGr+JGC7jK8BjXtn7+zTNcTqi19c48N1o=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=Ak1tiWueV4muZxeuQIlzvZAfg5GjoSPbtCqXWLKtmWxi7+r/a37hdVIwaXpDhE9StfUfc6giZby65tIA+7Ig9EumWM00z5pnSjAgTRVJvHsn8O84YaOvLmFcLYwyArWSZz3CEuxgprunTdGvXHfVMxuUrsmVFEt+C5B7VGV4z3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=AH/OJooV; arc=none smtp.client-ip=203.205.251.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1711010738; bh=NcoVocOkWa2L4ddhVp5EYLo8ptljqh0gPzB6q2afhGc=;
	h=From:To:Cc:Subject:Date;
	b=AH/OJooVQpNPbnUDUhrwe+dtACwT+6nr8TUSA02GN1RTXJ7UCX7aZjCzEs9D7/4hn
	 xuViZZ27dDGhHlQvWayT4Uxw3xmT5m2+mb71UaXexrTecqTZWoS/0nsbaDkuarq8kN
	 1zgp1amJzhEqrxvSaCd1yPuRn12eB7FwFLv+EJIo=
Received: from localhost.localdomain ([153.3.156.52])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id B1906E6A; Thu, 21 Mar 2024 16:44:25 +0800
X-QQ-mid: xmsmtpt1711010665t9a31la8x
Message-ID: <tencent_5A50BC27A519EBD14E1B0A8685E89405850A@qq.com>
X-QQ-XMAILINFO: MGSlRwRrdVfIzOHlmzt7HFB38+yD/VxqpPe+ETTIPusgI7/sRwZyhCEntj8TCv
	 X5nrteOiqlzuaKzuNo7oXLcEJSt4IAUqBBAx2b/xZxjebA/siv1UgrccT8WzXTpMNeom7pCPbvSi
	 6opVthSXevqyHCrT1a4tB/ZxOdums61e0A973Zgk0eD7VgvBMnWP+6Fsg09DFx8ZXRnwo+FSSMav
	 XFGw5KcStBVFkEsuRC4De0beRCE5Wsd/eVBhHIdwcV1FstpkoBYMx0j6W36JrXKMEVqmdvvRrCZL
	 Xb/oRA71VfQtsJly1tiffZkLOSpBJMfOKxoPOGlOwCucX0jr9OA8XxTje3JEWoNI+cvkPTLv4DzB
	 lI3LVTGH448iZP8E7wOwrPuIfRnoOkWSlDyTt08Hzo6TthlWn0x+eorH7/3KGnpnxj4G7W8Nfw7K
	 vbgm+k7Hnan8brhBhr/VxFxo9uxzbxEugEUlsXoZnZYrBXZLpqw7YzoDHzZXUn9CPvi/rRxkHGCE
	 RABmy+F0SYj4z2+t7vo1ApZQ0u4fxFQsKwcKNa22R8LjL998w6pWdxA26U4tVES4L40cdVtvBG6z
	 CcRpowmM3UFGgO8hjeE8AeesXWxdH53GTHqa+83zJ/ZYd+q3X7PhPcwsjvI8xJSS+Usr5n/5LJuu
	 ClC9ClYXkVXCtJzRwwajG6Ne51TJ2CLmQPySCq2pMx6BcXjOJcoZX8MBkT8MtBTfU1YlB8MzHG+G
	 uZ+F4ivkylbGou6wl4Rhi1X+YIDsqw/w3lqYDnAVGVvA/s+KE7Nv7EjMLAzD8cf8OP0JtZsekiqb
	 eoQonEO7lECL3RQTsbslUKsrXBB85dpgJxw4yzHMazIdzWgk19xj25VZbJLsaIoEYa1mrL2QcjeG
	 nlQ09Aydy5/gYIlce7hmncofX0JYAl3Eg0PKiq3ZfqbExBNa7hvCRZVtneGVx0L3MnLKyaQHxHwe
	 IhLOQooUjlUbsOjytJYpa9Y//0YZHYEBvHuokPaTa+fmWrgoAxg6A5SYZ3VWFQgP4JEDggcFGXcp
	 dU3OTjNwSyRP1lVsYy/uvdiAbsgvc=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: linke li <lilinke99@qq.com>
To: 
Cc: xujianhao01@gmail.com,
	linke li <lilinke99@qq.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	Abel Wu <wuyun.abel@bytedance.com>,
	Breno Leitao <leitao@debian.org>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	David Howells <dhowells@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] net: mark racy access on sk->sk_rcvbuf
Date: Thu, 21 Mar 2024 16:44:10 +0800
X-OQ-MSGID: <20240321084414.63519-1-lilinke99@qq.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sk->sk_rcvbuf in __sock_queue_rcv_skb() and __sk_receive_skb() can be
changed by other threads. Mark this as benign using READ_ONCE(). 

This patch is aimed at reducing the number of benign races reported by
KCSAN in order to focus future debugging effort on harmful races.

Signed-off-by: linke li <lilinke99@qq.com>
---
v1 -> v2: include sk->sk_rcvbuf in __sock_queue_rcv_skb()

 net/core/sock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 5e78798456fd..61c14623a218 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -481,7 +481,7 @@ int __sock_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	unsigned long flags;
 	struct sk_buff_head *list = &sk->sk_receive_queue;
 
-	if (atomic_read(&sk->sk_rmem_alloc) >= sk->sk_rcvbuf) {
+	if (atomic_read(&sk->sk_rmem_alloc) >= READ_ONCE(sk->sk_rcvbuf)) {
 		atomic_inc(&sk->sk_drops);
 		trace_sock_rcvqueue_full(sk, skb);
 		return -ENOMEM;
@@ -551,7 +551,7 @@ int __sk_receive_skb(struct sock *sk, struct sk_buff *skb,
 
 	skb->dev = NULL;
 
-	if (sk_rcvqueues_full(sk, sk->sk_rcvbuf)) {
+	if (sk_rcvqueues_full(sk, READ_ONCE(sk->sk_rcvbuf))) {
 		atomic_inc(&sk->sk_drops);
 		goto discard_and_relse;
 	}
-- 
2.39.3 (Apple Git-146)


