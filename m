Return-Path: <linux-kernel+bounces-49774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EAA846F48
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD632B2BA8A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEC313F019;
	Fri,  2 Feb 2024 11:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKBHgSzg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FECD13EFF7;
	Fri,  2 Feb 2024 11:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706874020; cv=none; b=ubjq9rNsoybodQq/IXmzCtZrLFJcQbN5tOE8T+TSaDOctK98L3ujBy2ZVtwSPhLG+k6vE0p389FFmi797P/myQFZJYEID7vsQu8LJ1APQSRTDW0QRQL9xq7k/nc62DkEje6R1SNrlJxttBpjL3ATlVElHIMWXAIdSsGcZXSib5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706874020; c=relaxed/simple;
	bh=5yc+86w3yyKe04H5iWLy/uFSmTiMA2lqTHZoCkfPUCU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N994CICy0d3e3TbHE438XoUTwV0KkCohpGSeG4ivX5ueyi+W+sozp7yN4H9674OCK+g3mttShyD/sEkLmCxLK/nBKfCekh7KXcBbw/S1GJU+l3sMtit8NFJcYpg6pGwSLHboaGKJJd2HgcJaO+L0y8Wz6+lJ/KAMtBeHBxJIXfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKBHgSzg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5922C43390;
	Fri,  2 Feb 2024 11:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706874020;
	bh=5yc+86w3yyKe04H5iWLy/uFSmTiMA2lqTHZoCkfPUCU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oKBHgSzgToOEaPb7eGUdUc89q9lOc3ljyY4AmNcHzLGpkghl/p3DZyThZ0VBdclyg
	 y6Towp76lYE7rY6yb8JmF0n9cwYQlIAlDRHT6lUAtQ8sbZSzJlNENqy2SP/eGvI1gH
	 UDq87w1cCevNlVI4ibvzQUT7rgW+2nJamNlvBJwGnFg6olaKRf7TIRkq5s/5NBVRVC
	 dFhD65oy6cZVusDR+NKPj39+y2gYBRtRcFB4zp67+vEbPIhk9cDQS/z+4GKxE9C6fP
	 6sUeDVjMig67fVvbhlmRtK+6cwoNPm9V7mVpFCoeIFzNX9WR+ShS7b9WgcrgdJMZhr
	 ql6/2lVJ1h+AA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 02 Feb 2024 12:40:07 +0100
Subject: [PATCH net-next 1/5] mptcp: annotate access for msk keys
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-upstream-net-next-20240202-mptcp-annotate-lockless-access-v1-1-031d6680afdc@kernel.org>
References: <20240202-upstream-net-next-20240202-mptcp-annotate-lockless-access-v1-0-031d6680afdc@kernel.org>
In-Reply-To: <20240202-upstream-net-next-20240202-mptcp-annotate-lockless-access-v1-0-031d6680afdc@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang.tang@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=4822; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=96HWwfDzSrjT/wYUKZiVvF6RaRUdJdTbmitFuA8YVr4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlvNSeT6koPoNWOPabIN9mKiAw/EcaIERSBZoZ/
 /nhmOYhhz2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZbzUngAKCRD2t4JPQmmg
 czaKEADS+YXwH4jzDmGv2L3+5H/uS0oZWbZ8jjEHdWwXxUenyXHbDGBJ550y/EgvdfNIjSt82Eg
 /NinqEmTQNm32OMumcQ2ZnzUnr7o3n6sZd3iHsc+YUp5dYNskjVOLeo7xdIr6juDed4gTowIacC
 NaJjZRSeU1bByIm7gar9Gded4/m567WLtHsnq7S7RaDFy3gYVOWpcVstq7aOQtdKB3TibnjHhoQ
 EFWKbxsztiuQeLPOsKtH7o0U8OcFcpQvwbpDOXgdYRdDQBIudaHAawmFpuMiE9IO5H2GU1x4YPE
 J7AuPDcQUBdHLOtG7czM3gykGLhaFkb89MaU4+9UzDp3z1Y+UCnhbvMAxk1JB08+SURWnhrhYt7
 qjFVkIHZvi4rhFPZQblkS9bBs/E6Pa8gW6Yu2RFYCE13G6rz4+RK4zgTtfkjtysA6nKOqJ9b488
 ECTZi7YyManvuzRzSNfVqh6iXAIHMEt6YrsnLv8ncH3VJIFLidlaXKzKnAkJOW9WA3/a1VNjxaS
 zhPRztHSPDf+hdz/Wtl18NGCXot4Fps5NG50s6v5uLimfWKFFZ4gD8DF1AG+nlqIjTywsucXyim
 uxGaesC5g+n+9Dx5kmw8/ix9FhBaOz8G4wLwsCJxOSn9Kdfb1uIBcIAzu3RVhNbYBF/1VcE74/o
 ylz59Htow+Ix3eA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

Both the local and the remote key follow the same locking
schema, put in place the proper ONCE accessors.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c  | 12 ++++++------
 net/mptcp/protocol.c |  2 +-
 net/mptcp/protocol.h |  6 ++++--
 net/mptcp/subflow.c  | 10 ++++++----
 4 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index d2527d189a79..5e2b130d8680 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -689,8 +689,8 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 	opts->suboptions |= OPTION_MPTCP_ADD_ADDR;
 	if (!echo) {
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDRTX);
-		opts->ahmac = add_addr_generate_hmac(msk->local_key,
-						     msk->remote_key,
+		opts->ahmac = add_addr_generate_hmac(READ_ONCE(msk->local_key),
+						     READ_ONCE(msk->remote_key),
 						     &opts->addr);
 	} else {
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADDTX);
@@ -792,7 +792,7 @@ static bool mptcp_established_options_fastclose(struct sock *sk,
 
 	*size = TCPOLEN_MPTCP_FASTCLOSE;
 	opts->suboptions |= OPTION_MPTCP_FASTCLOSE;
-	opts->rcvr_key = msk->remote_key;
+	opts->rcvr_key = READ_ONCE(msk->remote_key);
 
 	pr_debug("FASTCLOSE key=%llu", opts->rcvr_key);
 	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFASTCLOSETX);
@@ -1099,8 +1099,8 @@ static bool add_addr_hmac_valid(struct mptcp_sock *msk,
 	if (mp_opt->echo)
 		return true;
 
-	hmac = add_addr_generate_hmac(msk->remote_key,
-				      msk->local_key,
+	hmac = add_addr_generate_hmac(READ_ONCE(msk->remote_key),
+				      READ_ONCE(msk->local_key),
 				      &mp_opt->addr);
 
 	pr_debug("msk=%p, ahmac=%llu, mp_opt->ahmac=%llu\n",
@@ -1147,7 +1147,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 
 	if (unlikely(mp_opt.suboptions != OPTION_MPTCP_DSS)) {
 		if ((mp_opt.suboptions & OPTION_MPTCP_FASTCLOSE) &&
-		    msk->local_key == mp_opt.rcvr_key) {
+		    READ_ONCE(msk->local_key) == mp_opt.rcvr_key) {
 			WRITE_ONCE(msk->rcv_fastclose, true);
 			mptcp_schedule_work((struct sock *)msk);
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFASTCLOSERX);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 028e8b473626..874f019c5093 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3193,7 +3193,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	__mptcp_init_sock(nsk);
 
 	msk = mptcp_sk(nsk);
-	msk->local_key = subflow_req->local_key;
+	WRITE_ONCE(msk->local_key, subflow_req->local_key);
 	msk->token = subflow_req->token;
 	msk->in_accept_queue = 1;
 	WRITE_ONCE(msk->fully_established, false);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3517f2d24a22..13b8cf8ec704 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -260,8 +260,10 @@ struct mptcp_data_frag {
 struct mptcp_sock {
 	/* inet_connection_sock must be the first member */
 	struct inet_connection_sock sk;
-	u64		local_key;
-	u64		remote_key;
+	u64		local_key;		/* protected by the first subflow socket lock
+						 * lockless access read
+						 */
+	u64		remote_key;		/* same as above */
 	u64		write_seq;
 	u64		bytes_sent;
 	u64		snd_nxt;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 0dcb721c89d1..d60b83511302 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -75,7 +75,8 @@ static void subflow_req_create_thmac(struct mptcp_subflow_request_sock *subflow_
 
 	get_random_bytes(&subflow_req->local_nonce, sizeof(u32));
 
-	subflow_generate_hmac(msk->local_key, msk->remote_key,
+	subflow_generate_hmac(READ_ONCE(msk->local_key),
+			      READ_ONCE(msk->remote_key),
 			      subflow_req->local_nonce,
 			      subflow_req->remote_nonce, hmac);
 
@@ -694,7 +695,8 @@ static bool subflow_hmac_valid(const struct request_sock *req,
 	if (!msk)
 		return false;
 
-	subflow_generate_hmac(msk->remote_key, msk->local_key,
+	subflow_generate_hmac(READ_ONCE(msk->remote_key),
+			      READ_ONCE(msk->local_key),
 			      subflow_req->remote_nonce,
 			      subflow_req->local_nonce, hmac);
 
@@ -1530,8 +1532,8 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	mptcp_pm_get_flags_and_ifindex_by_id(msk, local_id,
 					     &flags, &ifindex);
 	subflow->remote_key_valid = 1;
-	subflow->remote_key = msk->remote_key;
-	subflow->local_key = msk->local_key;
+	subflow->remote_key = READ_ONCE(msk->remote_key);
+	subflow->local_key = READ_ONCE(msk->local_key);
 	subflow->token = msk->token;
 	mptcp_info2sockaddr(loc, &addr, ssk->sk_family);
 

-- 
2.43.0


