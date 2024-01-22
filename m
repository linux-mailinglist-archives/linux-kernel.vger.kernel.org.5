Return-Path: <linux-kernel+bounces-33972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F00F83711A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D8071F30291
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABDF5A7A6;
	Mon, 22 Jan 2024 18:20:20 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5042148CE0;
	Mon, 22 Jan 2024 18:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705947620; cv=none; b=eu0s23LbsGkJteOiZ2/mUdA7JryhAaeauaW4lSttrYK+GKynMGipMwxxwj5NAUB61zEs0b02P8jmDbEVNsYUjqh5Dwf6MNFBwFH3DvOVCLJWSDOSl6ms8b3q7bZ7Mrj+hQYDp84TWaFINQdM246fqGGsdXWSVG6fPkS38od56Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705947620; c=relaxed/simple;
	bh=H5X+U/KaE3kCsYxxYIvBmg6vy/P+UIq6sIiNfpZz/ts=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DiLVlT5jTWcr+3TVJU8ZOEOuaH7PQXGsFNmxBaDAYFIIN2kQXFa3rSAtK2jrS/pf2amCwebhI5jAnD32aKVV4ALcxvTpg4X5bGtrQb5onfDWW8+yGkAhjX66HHFPfjyt+pMGLMHLGlETcjgr1q2PSsxJmrjGXdsH94xO0m/MI0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a28fb463a28so339882166b.3;
        Mon, 22 Jan 2024 10:20:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705947616; x=1706552416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UfjyR+rXK8G2NXu1lb4+wObFJcorSaLJVEzfmJKuPjU=;
        b=oeP5nZ1ZGMPcwRIXOvaoXAdFv7ZzRJ+jNmtj9GGCkmzd/Pyha7LBinYEzhEoXtBOl4
         0KyyRLKiylf3T5MP888/ixLPTC+3eQtxcVdT2wC4v2A82wEj4wx/73HCW3b2Rczskuv2
         Zkv0ZI3rKAXhZ363ZF/ElCNPF4jp0h3ST5bDsf2AydyMBC2orTVY4zDU/2ObKAZjq33r
         pFnd4yR8kc9gU1axGGRbMUj/IlcDufjLlovk0+d4xdjiXmpXKUNpUggcObFYTIPawcqd
         aKSyJxmpPFbuJdjyzBsaSW2ky0sOmtmLJVVk+dSbqZCbQsFe6f3m63OZcWlqHGIt3O7E
         KrNg==
X-Gm-Message-State: AOJu0YxRCPcQGqHCt/xZMeEXmYj809513B6ljnQUr5AvmBc1vuw15EC+
	PqLT7G5T1J88JSWhHuzf94NOVri8sIZDOr8fvgHQ0/uRmADPm85x
X-Google-Smtp-Source: AGHT+IFp4nMux3cpKUPttvT2dKkgZPEQn99mmS/+6x3l6O5kyWpWNbpNkEaip3VgsrCs2lmblRh/NQ==
X-Received: by 2002:a17:907:c08a:b0:a2f:de73:eeb2 with SMTP id st10-20020a170907c08a00b00a2fde73eeb2mr2544713ejc.144.1705947616246;
        Mon, 22 Jan 2024 10:20:16 -0800 (PST)
Received: from localhost (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id w17-20020a17090652d100b00a28116285e0sm9296412ejn.165.2024.01.22.10.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 10:20:15 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: dsahern@kernel.org,
	weiwan@google.com,
	kuba@kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: leit@meta.com,
	netdev@vger.kernel.org (open list:NETWORKING [IPv4/IPv6]),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH RESEND net-next 2/2] net/ipv6: resolve warning in ip6_fib.c
Date: Mon, 22 Jan 2024 10:19:55 -0800
Message-Id: <20240122181955.2391676-2-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240122181955.2391676-1-leitao@debian.org>
References: <20240122181955.2391676-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some configurations, the 'iter' variable in function
fib6_repair_tree() is unused, resulting the following warning when
compiled with W=1.

    net/ipv6/ip6_fib.c:1781:6: warning: variable 'iter' set but not used [-Wunused-but-set-variable]
     1781 |         int iter = 0;
	  |             ^

It is unclear what is the advantage of this RT6_TRACE() macro[1], since
users can control pr_debug() in runtime, which is better than at
compilation time. pr_debug() has no overhead when disabled.

Remove the RT6_TRACE() in favor of simple pr_debug() helpers.

[1] Link: https://lore.kernel.org/all/ZZwSEJv2HgI0cD4J@gmail.com/
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/net/ip6_fib.h |  6 ------
 net/ipv6/ip6_fib.c    | 15 +++++++++------
 net/ipv6/route.c      |  8 ++++----
 3 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
index 9ba6413fd2e3..360b12e61850 100644
--- a/include/net/ip6_fib.h
+++ b/include/net/ip6_fib.h
@@ -30,12 +30,6 @@
 
 #define RT6_DEBUG 2
 
-#if RT6_DEBUG >= 3
-#define RT6_TRACE(x...) pr_debug(x)
-#else
-#define RT6_TRACE(x...) do { ; } while (0)
-#endif
-
 struct rt6_info;
 struct fib6_info;
 
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index fb41bec6b4b5..38a0348b1d17 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -1801,7 +1801,7 @@ static struct fib6_node *fib6_repair_tree(struct net *net,
 					    lockdep_is_held(&table->tb6_lock));
 		struct fib6_info *new_fn_leaf;
 
-		RT6_TRACE("fixing tree: plen=%d iter=%d\n", fn->fn_bit, iter);
+		pr_debug("fixing tree: plen=%d iter=%d\n", fn->fn_bit, iter);
 		iter++;
 
 		WARN_ON(fn->fn_flags & RTN_RTINFO);
@@ -1864,7 +1864,8 @@ static struct fib6_node *fib6_repair_tree(struct net *net,
 		FOR_WALKERS(net, w) {
 			if (!child) {
 				if (w->node == fn) {
-					RT6_TRACE("W %p adjusted by delnode 1, s=%d/%d\n", w, w->state, nstate);
+					pr_debug("W %p adjusted by delnode 1, s=%d/%d\n",
+						 w, w->state, nstate);
 					w->node = pn;
 					w->state = nstate;
 				}
@@ -1872,10 +1873,12 @@ static struct fib6_node *fib6_repair_tree(struct net *net,
 				if (w->node == fn) {
 					w->node = child;
 					if (children&2) {
-						RT6_TRACE("W %p adjusted by delnode 2, s=%d\n", w, w->state);
+						pr_debug("W %p adjusted by delnode 2, s=%d\n",
+							 w, w->state);
 						w->state = w->state >= FWS_R ? FWS_U : FWS_INIT;
 					} else {
-						RT6_TRACE("W %p adjusted by delnode 2, s=%d\n", w, w->state);
+						pr_debug("W %p adjusted by delnode 2, s=%d\n",
+							 w, w->state);
 						w->state = w->state >= FWS_C ? FWS_U : FWS_INIT;
 					}
 				}
@@ -1951,7 +1954,7 @@ static void fib6_del_route(struct fib6_table *table, struct fib6_node *fn,
 	read_lock(&net->ipv6.fib6_walker_lock);
 	FOR_WALKERS(net, w) {
 		if (w->state == FWS_C && w->leaf == rt) {
-			RT6_TRACE("walker %p adjusted by delroute\n", w);
+			pr_debug("walker %p adjusted by delroute\n", w);
 			w->leaf = rcu_dereference_protected(rt->fib6_next,
 					    lockdep_is_held(&table->tb6_lock));
 			if (!w->leaf)
@@ -2289,7 +2292,7 @@ static int fib6_age(struct fib6_info *rt, void *arg)
 
 	if (rt->fib6_flags & RTF_EXPIRES && rt->expires) {
 		if (time_after(now, rt->expires)) {
-			RT6_TRACE("expiring %p\n", rt);
+			pr_debug("expiring %p\n", rt);
 			return -1;
 		}
 		gc_args->more++;
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index ea1dec8448fc..63b4c6056582 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2085,12 +2085,12 @@ static void rt6_age_examine_exception(struct rt6_exception_bucket *bucket,
 	 */
 	if (!(rt->rt6i_flags & RTF_EXPIRES)) {
 		if (time_after_eq(now, rt->dst.lastuse + gc_args->timeout)) {
-			RT6_TRACE("aging clone %p\n", rt);
+			pr_debug("aging clone %p\n", rt);
 			rt6_remove_exception(bucket, rt6_ex);
 			return;
 		}
 	} else if (time_after(jiffies, rt->dst.expires)) {
-		RT6_TRACE("purging expired route %p\n", rt);
+		pr_debug("purging expired route %p\n", rt);
 		rt6_remove_exception(bucket, rt6_ex);
 		return;
 	}
@@ -2101,8 +2101,8 @@ static void rt6_age_examine_exception(struct rt6_exception_bucket *bucket,
 		neigh = __ipv6_neigh_lookup_noref(rt->dst.dev, &rt->rt6i_gateway);
 
 		if (!(neigh && (neigh->flags & NTF_ROUTER))) {
-			RT6_TRACE("purging route %p via non-router but gateway\n",
-				  rt);
+			pr_debug("purging route %p via non-router but gateway\n",
+				 rt);
 			rt6_remove_exception(bucket, rt6_ex);
 			return;
 		}
-- 
2.39.3


