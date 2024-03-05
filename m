Return-Path: <linux-kernel+bounces-92552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71661872215
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CC6F2835D8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4651C1272CF;
	Tue,  5 Mar 2024 14:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="Yf3+m6UZ"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49101126F02;
	Tue,  5 Mar 2024 14:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709650509; cv=none; b=rrwEf2hBrCTZL/WE1dBsF1SeLB7+IpyUgU04MS0UjzOyx5TQX1AfjtamKQboiZazhs1C0GpAXJX902DfmILZWwx1R8HNA3HKMdkr/tuMsXFyxWQhKL/Me+uMwRHyxSNOWUMygeQV+88EvsBlDivZ2t34RTg8PAK/oeHU43EQ/Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709650509; c=relaxed/simple;
	bh=pULFdc99bT3kGEpnmoQAhimYHSPZ/ND5NNhVMP7CCsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=liQUptXF2J5CQW2pRasQqzuP36cKO8cRFRQcgNGcEzIoYVAB/EQKexjYtvLjDquEt1Ew6oiSoJdMbtUeHFrR4SwXaRnZN8w8lRozSgqK31sUgzXI0xpetrbT5X+ws35nXJYwaq9x6QfM1kGJkT7wlV2pWXSlQsnzO3WHDMeICkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=Yf3+m6UZ; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 4F87D6030A;
	Tue,  5 Mar 2024 14:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1709650004;
	bh=pULFdc99bT3kGEpnmoQAhimYHSPZ/ND5NNhVMP7CCsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yf3+m6UZIMWaExbbTUHdQit25mDp1RfY7efon8v+vYW/yQMkFS5NoDDsS874lCOoV
	 +4kzeLD+7M29F+cL62qLIVkMf4uMrxpXv3r7V927AY7u0ImD6LiNyOUpULjdZaKwpD
	 EluZY+27FZYXh2+kFIV7LsoMok9AT6//hITtnyqtw5fassekrQWs3Q4TLIcrMsA+M0
	 8NLtfM5WIrAQJEJAtkjOGXbOWCp2gmDhon6Bupv+1+g1gHFrtEoTTUQOvOzqKpFxyA
	 YjqjqGiilqM9DSdGTYkP3+zu6hKSXvNDYx9tIofND+94DI/TWzQFSc6Tr70EW4+XZB
	 AQEK+O/j1VJ5A==
Received: by x201s (Postfix, from userid 1000)
	id 66584200F83; Tue,  5 Mar 2024 14:44:59 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Vlad Buslov <vladbu@nvidia.com>,
	Marcelo Ricardo Leitner <mleitner@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llu@fiberby.dk
Subject: [PATCH net-next v2 2/3] net: sched: cls_api: add filter counter
Date: Tue,  5 Mar 2024 14:43:55 +0000
Message-ID: <20240305144404.569632-3-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240305144404.569632-1-ast@fiberby.net>
References: <20240305144404.569632-1-ast@fiberby.net>
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
index 46a63d1818a0..7af0621db226 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -427,6 +427,7 @@ struct tcf_proto {
 	 */
 	spinlock_t		lock;
 	bool			deleting;
+	bool			counted;
 	refcount_t		refcnt;
 	struct rcu_head		rcu;
 	struct hlist_node	destroy_ht_node;
@@ -476,6 +477,7 @@ struct tcf_block {
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


