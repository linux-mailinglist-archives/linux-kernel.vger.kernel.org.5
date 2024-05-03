Return-Path: <linux-kernel+bounces-168057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 682E58BB328
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98F671C209CA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1DF159217;
	Fri,  3 May 2024 18:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TLGXYmS4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GeoN2E19"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73953158D75;
	Fri,  3 May 2024 18:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714761012; cv=none; b=CxYf9dQmjuXznOFg3GmfU4N0H+71sx/5HUe8KqpS23zNXtlUgfDJYBpXHzUN6hXsVTlNYAwUs2G65QCRQoMhrLh1N+5AsgHgum6DIAQNLswHGiUmGN8G/jJMWUSZf5dp6XxlxKcYy3gK2/wODS1Yz3Ihi3OqHAHsOaXkioAspLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714761012; c=relaxed/simple;
	bh=bqzM87LOMftzliWhYJsIqE05aE0+TuySDGTAO0goYyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C4ULaM+vN9awlWBqfhA7ZjWW6b0zl1GcDV+tJUXw3QWVuEtNj+LuwqD4EHecuegWZIOVtOSCvTuyOsDetAegw5aMqjZjxkgHeB65b6cegpDpRla1FMubEiLZ1704+bRRr9QhiBLujetljIg9m2XHLQQGZK7Ccj+Mr9X3MX/DIeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TLGXYmS4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GeoN2E19; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714761007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FPrvqok0v8KL/h2cmtllHWTg95fRWT2uDug0W0NGbSA=;
	b=TLGXYmS48uR4l4t3jkM1UgRDY0eN8bLVpPnQdFRsk4bcX1vI+nZgMdfP95YMZwpCx8BpSF
	NBp0LmwpcOdW6r7ICS3jlOkpSLPzjqd3li9RhZR5m6HG30zE3YQTwJtlvEU4u2rRe81rN7
	PonqaDtlSB1XUeNRMjD7PC2U+lQCjP3nyKvMwCZ7YgJYhzUhGl03A03FGn4OcMb+XAg4ao
	DTF78Y7Zmx6nkOBalSCiLcqwBOMRMKHcJdXbK0Bhfy2HgcBrkD2J75hHGvblgiJLr3C0jA
	AbfeXX2hV4rUJMMSoN5dWraesoYzqJ53X6nbQ65d3NDX8SQvICty7qQ6c+oXcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714761007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FPrvqok0v8KL/h2cmtllHWTg95fRWT2uDug0W0NGbSA=;
	b=GeoN2E19t/3CDZcmhQJ+KroiNoiN2qyawYUHPKOTA344mWUzaqYyTV3M0NYHF4aNUZvxpb
	b4cKcXx8zFwV59Ag==
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH net-next 06/15] net/ipv4: Use nested-BH locking for ipv4_tcp_sk.
Date: Fri,  3 May 2024 20:25:10 +0200
Message-ID: <20240503182957.1042122-7-bigeasy@linutronix.de>
In-Reply-To: <20240503182957.1042122-1-bigeasy@linutronix.de>
References: <20240503182957.1042122-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

ipv4_tcp_sk is a per-CPU variable and relies on disabled BH for its
locking. Without per-CPU locking in local_bh_disable() on PREEMPT_RT
this data structure requires explicit locking.

Make a struct with a sock member (original ipv4_tcp_sk) and a
local_lock_t and use local_lock_nested_bh() for locking. This change
adds only lockdep coverage and does not alter the functional behaviour
for !PREEMPT_RT.

Cc: David Ahern <dsahern@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/net/sock.h  |  5 +++++
 net/ipv4/tcp_ipv4.c | 15 +++++++++++----
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 0450494a1766a..8380898d71267 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -544,6 +544,11 @@ struct sock {
 	netns_tracker		ns_tracker;
 };
=20
+struct sock_bh_locked {
+	struct sock *sock;
+	local_lock_t bh_lock;
+};
+
 enum sk_pacing {
 	SK_PACING_NONE		=3D 0,
 	SK_PACING_NEEDED	=3D 1,
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 0427deca3e0eb..eefeff2d2f2b1 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -93,7 +93,9 @@ static int tcp_v4_md5_hash_hdr(char *md5_hash, const stru=
ct tcp_md5sig_key *key,
 struct inet_hashinfo tcp_hashinfo;
 EXPORT_SYMBOL(tcp_hashinfo);
=20
-static DEFINE_PER_CPU(struct sock *, ipv4_tcp_sk);
+static DEFINE_PER_CPU(struct sock_bh_locked, ipv4_tcp_sk) =3D {
+	.bh_lock =3D INIT_LOCAL_LOCK(bh_lock),
+};
=20
 static u32 tcp_v4_init_seq(const struct sk_buff *skb)
 {
@@ -879,7 +881,9 @@ static void tcp_v4_send_reset(const struct sock *sk, st=
ruct sk_buff *skb,
 	arg.tos =3D ip_hdr(skb)->tos;
 	arg.uid =3D sock_net_uid(net, sk && sk_fullsock(sk) ? sk : NULL);
 	local_bh_disable();
-	ctl_sk =3D this_cpu_read(ipv4_tcp_sk);
+	local_lock_nested_bh(&ipv4_tcp_sk.bh_lock);
+	ctl_sk =3D this_cpu_read(ipv4_tcp_sk.sock);
+
 	sock_net_set(ctl_sk, net);
 	if (sk) {
 		ctl_sk->sk_mark =3D (sk->sk_state =3D=3D TCP_TIME_WAIT) ?
@@ -904,6 +908,7 @@ static void tcp_v4_send_reset(const struct sock *sk, st=
ruct sk_buff *skb,
 	sock_net_set(ctl_sk, &init_net);
 	__TCP_INC_STATS(net, TCP_MIB_OUTSEGS);
 	__TCP_INC_STATS(net, TCP_MIB_OUTRSTS);
+	local_unlock_nested_bh(&ipv4_tcp_sk.bh_lock);
 	local_bh_enable();
=20
 #ifdef CONFIG_TCP_MD5SIG
@@ -999,7 +1004,8 @@ static void tcp_v4_send_ack(const struct sock *sk,
 	arg.tos =3D tos;
 	arg.uid =3D sock_net_uid(net, sk_fullsock(sk) ? sk : NULL);
 	local_bh_disable();
-	ctl_sk =3D this_cpu_read(ipv4_tcp_sk);
+	local_lock_nested_bh(&ipv4_tcp_sk.bh_lock);
+	ctl_sk =3D this_cpu_read(ipv4_tcp_sk.sock);
 	sock_net_set(ctl_sk, net);
 	ctl_sk->sk_mark =3D (sk->sk_state =3D=3D TCP_TIME_WAIT) ?
 			   inet_twsk(sk)->tw_mark : READ_ONCE(sk->sk_mark);
@@ -1014,6 +1020,7 @@ static void tcp_v4_send_ack(const struct sock *sk,
=20
 	sock_net_set(ctl_sk, &init_net);
 	__TCP_INC_STATS(net, TCP_MIB_OUTSEGS);
+	local_unlock_nested_bh(&ipv4_tcp_sk.bh_lock);
 	local_bh_enable();
 }
=20
@@ -3620,7 +3627,7 @@ void __init tcp_v4_init(void)
 		 */
 		inet_sk(sk)->pmtudisc =3D IP_PMTUDISC_DO;
=20
-		per_cpu(ipv4_tcp_sk, cpu) =3D sk;
+		per_cpu(ipv4_tcp_sk.sock, cpu) =3D sk;
 	}
 	if (register_pernet_subsys(&tcp_sk_ops))
 		panic("Failed to create the TCP control socket.\n");
--=20
2.43.0


