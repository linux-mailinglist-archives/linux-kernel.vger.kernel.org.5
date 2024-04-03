Return-Path: <linux-kernel+bounces-129831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2ABB8970F9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C69E31C2088C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F327D14831E;
	Wed,  3 Apr 2024 13:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ETVAFgaE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB571487D0;
	Wed,  3 Apr 2024 13:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712150793; cv=none; b=nPR0l6CXHMB++B3bR3KjU0ZukEe6wBKNDM5PvKVHIhIGycvRC1MMLZysnL2seKf0oXu9TyXhivVuKkGoypbTbzzhjnztC4rEtSCXiQT5akjWECsNgXS8xq7zuushOrhn5V5SuRpVLjU3E18VKcBrSR3CxvUnebfjmc6EeAFAW0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712150793; c=relaxed/simple;
	bh=/3wLZxf5xRA3Th1RKCb6GEQOSFpocSLbzEOho5yeuOI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YEewkP7k3ekE8grP6njJwZaWVlvtj9dGt1xr7nQAbJB9Hmd5wSMkZ+W1l5WaGsuTvuyc4f/8ngwHbfevhbDZcraKl0vSLyAbyaNgto++frNJ637TDsKevQMrPfOL28FJeXxLSAdmw0Jgnbcn5BRnSNLn/miobm6z+s6bBfO/UcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ETVAFgaE; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712150792; x=1743686792;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/3wLZxf5xRA3Th1RKCb6GEQOSFpocSLbzEOho5yeuOI=;
  b=ETVAFgaEIEiQr5pZFDfYUMwZ1xP+4qL3iowqwVPPRdgiy8bT0a3z7QjD
   B5HG18b7O1e63G1KW+SxORr7SD6pN2otoQ8ABosBrnrIJlxxGIDPPAGzh
   BEmxPzmigyrynRuJbF1JD33v0uhWJUKEI8LtajdkJyio17Fzh9wZ8AYHK
   GoDOT0y8wSSaT8fECrpqKLI7bJTAKuPe4BqUimeUnpSo6L6S9efrNVy9v
   iRQKJ1rSBJKMOsw34hI5OcuOtsHcaebS/nVKJSwzbF1E9IYFoKGuzDfR2
   ymKG/F64Aq3GbwpEU9VvwwFnL3+kAaFqFjWwSpyRJYVJL7dC4kVPoqz7F
   w==;
X-CSE-ConnectionGUID: KcVctqcxTeGgcArekqYMlw==
X-CSE-MsgGUID: wtRcT4T6QjiQ6AVx9N1YrA==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="10349259"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="10349259"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 06:26:31 -0700
X-CSE-ConnectionGUID: Lm2iEyKMTdGeGcwEwGbkJw==
X-CSE-MsgGUID: SUfJ7OZ6SxuSVi++MSNQog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="22921457"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa003.fm.intel.com with ESMTP; 03 Apr 2024 06:26:27 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Dmitry Safonov <dima@arista.com>,
	Francesco Ruggeri <fruggeri@arista.com>,
	Salam Noureddine <noureddine@arista.com>,
	David Ahern <dsahern@kernel.org>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net/tcp: move TCP hash fail messages out of line
Date: Wed,  3 Apr 2024 15:24:56 +0200
Message-ID: <20240403132456.41709-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tcp_hash_fail() is used multiple times on hotpath, including static
inlines. It contains a couple branches and a lot of code, which all
gets inlined into the call sites. For example, one call emits two
calls to net_ratelimit() etc.
Move as much as we can out of line to a new global function. Use enum
to determine the type of failure. Check for net_ratelimit() only once,
format common fields only once as well to pass only unique strings to
pr_info().
The result for vmlinux with Clang 19:

add/remove: 2/0 grow/shrink: 0/4 up/down: 773/-4908 (-4135)
Function                                     old     new   delta
__tcp_hash_fail                                -     757    +757
__pfx___tcp_hash_fail                          -      16     +16
tcp_inbound_ao_hash                         1819    1062    -757
tcp_ao_verify_hash                          1217     451    -766
tcp_inbound_md5_hash                        1591     374   -1217
tcp_inbound_hash                            3566    1398   -2168

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/tcp.h    |  15 ++---
 include/net/tcp_ao.h |  58 ++++++++-----------
 net/ipv4/tcp.c       | 129 +++++++++++++++++++++++++++++++++++++------
 net/ipv4/tcp_ao.c    |  13 ++---
 4 files changed, 148 insertions(+), 67 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 9ab5b37e9d53..fa2303c788cf 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2809,17 +2809,14 @@ tcp_inbound_hash(struct sock *sk, const struct request_sock *req,
 
 	/* Invalid option or two times meet any of auth options */
 	if (tcp_parse_auth_options(th, &md5_location, &aoh)) {
-		tcp_hash_fail("TCP segment has incorrect auth options set",
-			      family, skb, "");
+		tcp_hash_fail(TCP_HASH_FAIL_OPTS, family, skb);
 		return SKB_DROP_REASON_TCP_AUTH_HDR;
 	}
 
 	if (req) {
 		if (tcp_rsk_used_ao(req) != !!aoh) {
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOBAD);
-			tcp_hash_fail("TCP connection can't start/end using TCP-AO",
-				      family, skb, "%s",
-				      !aoh ? "missing AO" : "AO signed");
+			tcp_hash_fail(TCP_HASH_FAIL_CONN, family, skb, !aoh);
 			return SKB_DROP_REASON_TCP_AOFAILURE;
 		}
 	}
@@ -2837,14 +2834,14 @@ tcp_inbound_hash(struct sock *sk, const struct request_sock *req,
 		 * always at least one current_key.
 		 */
 		if (tcp_ao_required(sk, saddr, family, l3index, true)) {
-			tcp_hash_fail("AO hash is required, but not found",
-					family, skb, "L3 index %d", l3index);
+			tcp_hash_fail(TCP_HASH_FAIL_NOAO, family, skb,
+				      l3index);
 			return SKB_DROP_REASON_TCP_AONOTFOUND;
 		}
 		if (unlikely(tcp_md5_do_lookup(sk, l3index, saddr, family))) {
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5NOTFOUND);
-			tcp_hash_fail("MD5 Hash not found",
-				      family, skb, "L3 index %d", l3index);
+			tcp_hash_fail(TCP_HASH_FAIL_NOMD5, family, skb,
+				      l3index);
 			return SKB_DROP_REASON_TCP_MD5NOTFOUND;
 		}
 		return SKB_NOT_DROPPED_YET;
diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index 471e177362b4..a00d765be30b 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -143,42 +143,32 @@ extern struct static_key_false_deferred tcp_ao_needed;
 #define static_branch_tcp_ao()	false
 #endif
 
-static inline bool tcp_hash_should_produce_warnings(void)
-{
-	return static_branch_tcp_md5() || static_branch_tcp_ao();
-}
+enum {
+	TCP_HASH_FAIL_OPTS,
+	TCP_HASH_FAIL_CONN,
+	TCP_HASH_FAIL_NOAO,
+	TCP_HASH_FAIL_NOMD5,
+	TCP_HASH_FAIL_UNEXP,
+	TCP_HASH_FAIL_INET,
+	TCP_HASH_FAIL_LEN,
+	TCP_HASH_FAIL_MIS,
+	TCP_HASH_FAIL_NOKEY,
+	TCP_HASH_FAIL_NOID,
+};
+
+void __tcp_hash_fail(u8 reason, u8 family, const struct sk_buff *skb,
+		     int arg0, int arg1, int arg2);
 
-#define tcp_hash_fail(msg, family, skb, fmt, ...)			\
-do {									\
-	const struct tcphdr *th = tcp_hdr(skb);				\
-	char hdr_flags[6];						\
-	char *f = hdr_flags;						\
-									\
-	if (!tcp_hash_should_produce_warnings())			\
-		break;							\
-	if (th->fin)							\
-		*f++ = 'F';						\
-	if (th->syn)							\
-		*f++ = 'S';						\
-	if (th->rst)							\
-		*f++ = 'R';						\
-	if (th->psh)							\
-		*f++ = 'P';						\
-	if (th->ack)							\
-		*f++ = '.';						\
-	*f = 0;								\
-	if ((family) == AF_INET) {					\
-		net_info_ratelimited("%s for %pI4.%d->%pI4.%d [%s] " fmt "\n", \
-				msg, &ip_hdr(skb)->saddr, ntohs(th->source), \
-				&ip_hdr(skb)->daddr, ntohs(th->dest),	\
-				hdr_flags, ##__VA_ARGS__);		\
-	} else {							\
-		net_info_ratelimited("%s for [%pI6c].%d->[%pI6c].%d [%s]" fmt "\n", \
-				msg, &ipv6_hdr(skb)->saddr, ntohs(th->source), \
-				&ipv6_hdr(skb)->daddr, ntohs(th->dest),	\
-				hdr_flags, ##__VA_ARGS__);		\
-	}								\
+#define _tcp_hash_fail(reason, family, skb, ua, ...) do {		    \
+	if (static_branch_tcp_md5() || static_branch_tcp_ao()) {	    \
+		int ua[] = { __VA_ARGS__ + 0, 0, 0, 0, };		    \
+									    \
+		__tcp_hash_fail(reason, family, skb, ua[0], ua[1], ua[2]);  \
+	}								    \
 } while (0)
+#define tcp_hash_fail(reason, family, skb, ...)				    \
+	_tcp_hash_fail(reason, family, skb, __UNIQUE_ID(args_),		    \
+		       ##__VA_ARGS__)
 
 #ifdef CONFIG_TCP_AO
 /* TCP-AO structures and functions */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e767721b3a58..a8a9e0f7f768 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4379,6 +4379,116 @@ int tcp_getsockopt(struct sock *sk, int level, int optname, char __user *optval,
 }
 EXPORT_SYMBOL(tcp_getsockopt);
 
+#if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
+static const char *tcp_hash_fail_common(u8 family, const struct sk_buff *skb)
+{
+	const struct tcphdr *th = tcp_hdr(skb);
+	char hdr_flags[6];
+	char *f = hdr_flags;
+
+	if (th->fin)
+		*f++ = 'F';
+	if (th->syn)
+		*f++ = 'S';
+	if (th->rst)
+		*f++ = 'R';
+	if (th->psh)
+		*f++ = 'P';
+	if (th->ack)
+		*f++ = '.';
+	*f = '\0';
+
+	if (family == AF_INET)
+		return kasprintf(GFP_ATOMIC,
+				 " for %pI4.%d->%pI4.%d [%s] ",
+				 &ip_hdr(skb)->saddr, ntohs(th->source),
+				 &ip_hdr(skb)->daddr, ntohs(th->dest),
+				 hdr_flags);
+	else
+		return kasprintf(GFP_ATOMIC,
+				 " for [%pI6c].%d->[%pI6c].%d [%s] ",
+				 &ipv6_hdr(skb)->saddr, ntohs(th->source),
+				 &ipv6_hdr(skb)->daddr, ntohs(th->dest),
+				 hdr_flags);
+}
+
+void __tcp_hash_fail(u8 reason, u8 family, const struct sk_buff *skb,
+		     int arg0, int arg1, int arg2)
+{
+	const char *common __free(kfree) = NULL;
+
+	if (!net_ratelimit())
+		return;
+
+	common = tcp_hash_fail_common(family, skb);
+	if (!common)
+		return;
+
+#define tcp_hash_fail_msg(msg, common, fmt, ...)		\
+	pr_info(msg "%s" fmt "\n", common, ##__VA_ARGS__)
+	switch (reason) {
+	case TCP_HASH_FAIL_OPTS:
+		tcp_hash_fail_msg("TCP segment has incorrect auth options set",
+				  common, "");
+		break;
+	case TCP_HASH_FAIL_CONN:
+		tcp_hash_fail_msg("TCP connection can't start/end using TCP-AO",
+				  common, "%s",
+				  arg0 ? "missing AO" : "AO signed");
+		break;
+	case TCP_HASH_FAIL_NOAO:
+		tcp_hash_fail_msg("AO hash is required, but not found",
+				  common, "L3 index %d", arg0);
+		break;
+	case TCP_HASH_FAIL_NOMD5:
+		tcp_hash_fail_msg("MD5 Hash not found", common, "L3 index %d",
+				  arg0);
+		break;
+	case TCP_HASH_FAIL_UNEXP:
+		tcp_hash_fail_msg("Unexpected MD5 Hash found", common, "");
+		break;
+	case TCP_HASH_FAIL_INET:
+		if (family == AF_INET) {
+			tcp_hash_fail_msg("MD5 Hash failed", common,
+					  "%s L3 index %d",
+					  arg0 ?
+					  "tcp_v4_calc_md5_hash failed" : "",
+					  arg1);
+		} else {
+			if (arg0)
+				tcp_hash_fail_msg("MD5 Hash failed",
+						  common, "L3 index %d",
+						  arg1);
+			else
+				tcp_hash_fail_msg("MD5 Hash mismatch",
+						  common, "L3 index %d",
+						  arg1);
+		}
+		break;
+	case TCP_HASH_FAIL_LEN:
+		tcp_hash_fail_msg("AO hash wrong length", common,
+				  "%u != %d L3 index: %d", arg0, arg1, arg2);
+		break;
+	case TCP_HASH_FAIL_MIS:
+		tcp_hash_fail_msg("AO hash mismatch", common, "L3 index: %d",
+				  arg0);
+		break;
+	case TCP_HASH_FAIL_NOKEY:
+		tcp_hash_fail_msg("AO key not found", common,
+				  "keyid: %u L3 index: %d", arg0, arg1);
+		break;
+	case TCP_HASH_FAIL_NOID:
+		tcp_hash_fail_msg("Requested by the peer AO key id not found",
+				  common, "L3 index: %d", arg0);
+		break;
+	default:
+		break;
+	}
+#undef tcp_hash_fail_msg
+}
+EXPORT_SYMBOL(__tcp_hash_fail);
+#endif /* CONFIG_TCP_MD5SIG || CONFIG_TCP_AO */
+
 #ifdef CONFIG_TCP_MD5SIG
 int tcp_md5_sigpool_id = -1;
 EXPORT_SYMBOL_GPL(tcp_md5_sigpool_id);
@@ -4450,7 +4560,7 @@ tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
 
 	if (!key && hash_location) {
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5UNEXPECTED);
-		tcp_hash_fail("Unexpected MD5 Hash found", family, skb, "");
+		tcp_hash_fail(TCP_HASH_FAIL_UNEXP, family, skb);
 		return SKB_DROP_REASON_TCP_MD5UNEXPECTED;
 	}
 
@@ -4465,21 +4575,8 @@ tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
 							 NULL, skb);
 	if (genhash || memcmp(hash_location, newhash, 16) != 0) {
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5FAILURE);
-		if (family == AF_INET) {
-			tcp_hash_fail("MD5 Hash failed", AF_INET, skb, "%s L3 index %d",
-				      genhash ? "tcp_v4_calc_md5_hash failed"
-				      : "", l3index);
-		} else {
-			if (genhash) {
-				tcp_hash_fail("MD5 Hash failed",
-					      AF_INET6, skb, "L3 index %d",
-					      l3index);
-			} else {
-				tcp_hash_fail("MD5 Hash mismatch",
-					      AF_INET6, skb, "L3 index %d",
-					      l3index);
-			}
-		}
+		tcp_hash_fail(TCP_HASH_FAIL_INET, family, skb, genhash,
+			      l3index);
 		return SKB_DROP_REASON_TCP_MD5FAILURE;
 	}
 	return SKB_NOT_DROPPED_YET;
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index 3afeeb68e8a7..f4dbb23e549b 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -892,8 +892,7 @@ tcp_ao_verify_hash(const struct sock *sk, const struct sk_buff *skb,
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOBAD);
 		atomic64_inc(&info->counters.pkt_bad);
 		atomic64_inc(&key->pkt_bad);
-		tcp_hash_fail("AO hash wrong length", family, skb,
-			      "%u != %d L3index: %d", maclen,
+		tcp_hash_fail(TCP_HASH_FAIL_LEN, family, skb, maclen,
 			      tcp_ao_maclen(key), l3index);
 		return SKB_DROP_REASON_TCP_AOFAILURE;
 	}
@@ -909,8 +908,7 @@ tcp_ao_verify_hash(const struct sock *sk, const struct sk_buff *skb,
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOBAD);
 		atomic64_inc(&info->counters.pkt_bad);
 		atomic64_inc(&key->pkt_bad);
-		tcp_hash_fail("AO hash mismatch", family, skb,
-			      "L3index: %d", l3index);
+		tcp_hash_fail(TCP_HASH_FAIL_MIS, family, skb, l3index);
 		kfree(hash_buf);
 		return SKB_DROP_REASON_TCP_AOFAILURE;
 	}
@@ -938,8 +936,8 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
 	info = rcu_dereference(tcp_sk(sk)->ao_info);
 	if (!info) {
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOKEYNOTFOUND);
-		tcp_hash_fail("AO key not found", family, skb,
-			      "keyid: %u L3index: %d", aoh->keyid, l3index);
+		tcp_hash_fail(TCP_HASH_FAIL_NOKEY, family, skb, aoh->keyid,
+			      l3index);
 		return SKB_DROP_REASON_TCP_AOUNEXPECTED;
 	}
 
@@ -1041,8 +1039,7 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
 key_not_found:
 	NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOKEYNOTFOUND);
 	atomic64_inc(&info->counters.key_not_found);
-	tcp_hash_fail("Requested by the peer AO key id not found",
-		      family, skb, "L3index: %d", l3index);
+	tcp_hash_fail(TCP_HASH_FAIL_NOID, family, skb, l3index);
 	return SKB_DROP_REASON_TCP_AOKEYNOTFOUND;
 }
 
-- 
2.44.0


