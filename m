Return-Path: <linux-kernel+bounces-117991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A162388B212
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C170283320
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03846E60F;
	Mon, 25 Mar 2024 20:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="CL+8RpkF"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9AA5C613;
	Mon, 25 Mar 2024 20:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711400050; cv=none; b=A3uatDzxX1FAf6r2I6Pgx2z7PGzBef8dZHVm7FpyEXUl+vmjcmFAsMhZDWTDX5GvSAQ4WMYVF39x1czx425mSeh3Pt9d5ZWYiY8yqsY4dPk/tO6FpHT9NeiH5gyhBGB8TAzuq2Z5WSaQNdLSt3kJCvXMkj/aGwPw0n31EXWOySo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711400050; c=relaxed/simple;
	bh=UsuadOPE5XUQNgscef/NyQQnyL0c3yDFZvzX9R4Pwe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o3XjHF669geeudnvbuALWxkvIzzuQu3e735BEGHpfQ7KnbeL4TRcnOqMh7ZIVkehSzAxxxTuvm5h5THZkY9swWuFrPoLDwhhPktgiwt5Zqf3uCmdi2L/8vtS/k7AlaDnvzuYrMXuplakK+bs6n4ZXBC1ZaD78WhCwsRGPDxH0lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=CL+8RpkF; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 5C71D6030A;
	Mon, 25 Mar 2024 20:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1711399726;
	bh=UsuadOPE5XUQNgscef/NyQQnyL0c3yDFZvzX9R4Pwe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CL+8RpkFaNKXpH6sJVL24f37GOWJ5scHuI+tTnaxOOoWQZrF42pm8EzjKbt4LAuzW
	 iH3mVd3X+lPa/P/qt1K0TK32q9OMzxX7A6MFXR9nX5Q+042UswnNLwcbFgDursA8L8
	 Jp6il8ivBKqZ8r9G8G66Y+H0IhpeRZVQNvWo+uw269/04YqCU6iGo4bFc6u0ptNYFd
	 2kadXIv3B9x3n5iL11H47jfpzrt0hzC34uFDDAGjDBfN6T0WNDt59tuKrBANeNA/xe
	 WV8FsEDVHWLe7kpYWwAvDxL/DYWaWE1AbsAbv24327Gmc0rFyEIIMvbBqn4ep7ljYL
	 7sPgy1gTwKHLg==
Received: by x201s (Postfix, from userid 1000)
	id C7CB8204BA9; Mon, 25 Mar 2024 20:47:51 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vlad Buslov <vladbu@nvidia.com>,
	Marcelo Ricardo Leitner <mleitner@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llu@fiberby.dk
Subject: [PATCH net-next v4 2/3] net: sched: cls_api: add filter counter
Date: Mon, 25 Mar 2024 20:47:35 +0000
Message-ID: <20240325204740.1393349-3-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325204740.1393349-1-ast@fiberby.net>
References: <20240325204740.1393349-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Maintain a count of filters per block.

Counter updates are protected by cb_lock, which is
also used to protect the offload counters.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 include/net/sch_generic.h |  2 ++
 net/sched/cls_api.c       | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 120a4ca6ec9b..eb3872c22fcd 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -422,6 +422,7 @@ struct tcf_proto {
 	 */
 	spinlock_t		lock;
 	bool			deleting;
+	bool			counted;
 	refcount_t		refcnt;
 	struct rcu_head		rcu;
 	struct hlist_node	destroy_ht_node;
@@ -471,6 +472,7 @@ struct tcf_block {
 	struct flow_block flow_block;
 	struct list_head owner_list;
 	bool keep_dst;
+	atomic_t filtercnt; /* Number of filters */
 	atomic_t skipswcnt; /* Number of skip_sw filters */
 	atomic_t offloadcnt; /* Number of oddloaded filters */
 	unsigned int nooffloaddevcnt; /* Number of devs unable to do offload */
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 397c3d29659c..304a46ab0e0b 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -410,12 +410,30 @@ static void tcf_proto_get(struct tcf_proto *tp)
 	refcount_inc(&tp->refcnt);
 }
 
+static void tcf_block_filter_cnt_update(struct tcf_block *block, bool *counted, bool add)
+{
+	lockdep_assert_not_held(&block->cb_lock);
+
+	down_write(&block->cb_lock);
+	if (*counted != add) {
+		if (add) {
+			atomic_inc(&block->filtercnt);
+			*counted = true;
+		} else {
+			atomic_dec(&block->filtercnt);
+			*counted = false;
+		}
+	}
+	up_write(&block->cb_lock);
+}
+
 static void tcf_chain_put(struct tcf_chain *chain);
 
 static void tcf_proto_destroy(struct tcf_proto *tp, bool rtnl_held,
 			      bool sig_destroy, struct netlink_ext_ack *extack)
 {
 	tp->ops->destroy(tp, rtnl_held, extack);
+	tcf_block_filter_cnt_update(tp->chain->block, &tp->counted, false);
 	if (sig_destroy)
 		tcf_proto_signal_destroyed(tp->chain, tp);
 	tcf_chain_put(tp->chain);
@@ -2364,6 +2382,7 @@ static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 	err = tp->ops->change(net, skb, tp, cl, t->tcm_handle, tca, &fh,
 			      flags, extack);
 	if (err == 0) {
+		tcf_block_filter_cnt_update(block, &tp->counted, true);
 		tfilter_notify(net, skb, n, tp, block, q, parent, fh,
 			       RTM_NEWTFILTER, false, rtnl_held, extack);
 		tfilter_put(tp, fh);
-- 
2.43.0


