Return-Path: <linux-kernel+bounces-109429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0788818FA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 22:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0212B20F4C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA3285C48;
	Wed, 20 Mar 2024 21:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VOrT8yrS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1304F8B2;
	Wed, 20 Mar 2024 21:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710969546; cv=none; b=J3RQ29ojwQj/UING/qN1zUHToASe+QGb0wldd1KatJnmjubYT1Q/aj9TwUgE4jtchIJVoTRd/Z0PWgxP+KfBbWCoZlh1X2Kqo2PNlVe7RZv/OzjpTy72v14NKpGr72IyDUuwTZLuaqoC496YyF4Lf5HNMenMyTTMaMhRrtYcxd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710969546; c=relaxed/simple;
	bh=+0mxs9pp75Nz3dbwfkyI9AI1qJISBMm4k9F2F9mwXlQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PjUwSm/JT0a+bLxxm9YA27g1ZhLqNcIyUULbpSaf25nM1LHNumoxB4w571FBMfASZ7/p2n4DqwcUBQUstSOfVpADPxdnDPLnaMxOXalbhJNbAGD16GObGotiHdfuTPLfORKj2tDcb4e3e39cs+QEeDtXNkDc9O44ZS5d2sQW5Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VOrT8yrS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42KKdUSp005983;
	Wed, 20 Mar 2024 21:18:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=qcppdkim1; bh=ir3Z0tUjv2xyS6jrhndo
	a24roJ50MsmSYuMTOzNzEGY=; b=VOrT8yrSmWN9N/TWbCKpf2Kx4rW1iDAztS/Q
	G7xNUv2a94PYipDkzI3eZ+8MsyFE8rvibE4f/OZAO7lKLIrYSPO/pOaHCu22Sv0c
	rhahkRFxXTaFpuLChnVK5CPHTmdlhh5STyPeZDPjNXHjmve4VgTCourm+nV0O789
	f6/IogsASjQVqfNo8kTt1YCb7M/cxWpWvOwqmB6c9H7xl5+v80oG0GPVq71kSbfq
	7DrxeOXG/nwQPJL4nzTxV9FLlqFowlA1eWNmBN7Q88HdaGDBMGi4/Lr4m5ye2FzY
	wGyQm/Ht9JW1hL8X4V6ehH3NRp5rEVXmu9gnqXvc58ZUSn8+pw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wyrp7a536-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 21:18:41 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 42KLHVtN010662;
	Wed, 20 Mar 2024 21:18:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 3x00nwaujg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 21:18:40 +0000
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42KLIdcj011537;
	Wed, 20 Mar 2024 21:18:39 GMT
Received: from hu-devc-lv-u20-a-new.qualcomm.com (hu-abchauha-lv.qualcomm.com [10.81.25.35])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 42KLIdvH011536
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 21:18:39 +0000
Received: by hu-devc-lv-u20-a-new.qualcomm.com (Postfix, from userid 214165)
	id 6B053220C3; Wed, 20 Mar 2024 14:18:39 -0700 (PDT)
From: Abhishek Chauhan <quic_abchauha@quicinc.com>
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc: kernel@quicinc.com
Subject: [PATCH net-next v1] net: Rename mono_delivery_time to tstamp_type for scalibilty
Date: Wed, 20 Mar 2024 14:18:39 -0700
Message-Id: <20240320211839.1214034-1-quic_abchauha@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _CuLB5MxZpGOnORXBCA3FTupoxxNs6wP
X-Proofpoint-GUID: _CuLB5MxZpGOnORXBCA3FTupoxxNs6wP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_11,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 spamscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403140001 definitions=main-2403200169

mono_delivery_time was added to check if skb->tstamp has delivery
time in mono clock base (i.e. EDT) otherwise skb->tstamp has
timestamp in ingress and delivery_time at egress.

Renaming the bitfield from mono_delivery_time to tstamp_type is for
extensibilty for other timestamps such as userspace timestamp
(i.e. SO_TXTIME) set via sock opts.

Bridge driver today has no support to forward the userspace timestamp
packets and ends up resetting the timestamp. ETF qdisc checks the
packet coming from userspace and encounters to be 0 thereby dropping
time sensitive packets. These changes will allow userspace timestamps
packets to be forwarded from the bridge to NIC drivers.

In future tstamp_type:1 can be extended to support userspace timestamp
by increasing the bitfield.

Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
---
Test case executed from bpf selftest
/test_progs -t tc_redirect/tc_redirect_dtime
[ 3076.040766] IPv6: ADDRCONF(NETDEV_CHANGE): veth_src_fwd: link becomes ready
[ 3076.040809] IPv6: ADDRCONF(NETDEV_CHANGE): veth_src: link becomes ready
[ 3076.072844] IPv6: ADDRCONF(NETDEV_CHANGE): veth_dst: link becomes ready
[ 3076.072880] IPv6: ADDRCONF(NETDEV_CHANGE): veth_dst_fwd: link becomes ready
#214/5   tc_redirect/tc_redirect_dtime:OK
#214     tc_redirect:OK 


 include/linux/skbuff.h                     | 18 +++++++++---------
 include/net/inet_frag.h                    |  4 ++--
 net/bridge/netfilter/nf_conntrack_bridge.c |  6 +++---
 net/core/dev.c                             |  2 +-
 net/core/filter.c                          |  8 ++++----
 net/ipv4/inet_fragment.c                   |  2 +-
 net/ipv4/ip_fragment.c                     |  2 +-
 net/ipv4/ip_output.c                       |  8 ++++----
 net/ipv6/ip6_output.c                      |  6 +++---
 net/ipv6/netfilter.c                       |  6 +++---
 net/ipv6/netfilter/nf_conntrack_reasm.c    |  2 +-
 net/ipv6/reassembly.c                      |  2 +-
 net/sched/act_bpf.c                        |  4 ++--
 net/sched/cls_bpf.c                        |  4 ++--
 14 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 0c7c67b3a87b..8210d699d8e9 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -821,7 +821,7 @@ typedef unsigned char *sk_buff_data_t;
  *	@dst_pending_confirm: need to confirm neighbour
  *	@decrypted: Decrypted SKB
  *	@slow_gro: state present at GRO time, slower prepare step required
- *	@mono_delivery_time: When set, skb->tstamp has the
+ *	@tstamp_type: When set, skb->tstamp has the
  *		delivery_time in mono clock base (i.e. EDT).  Otherwise, the
  *		skb->tstamp has the (rcv) timestamp at ingress and
  *		delivery_time at egress.
@@ -955,7 +955,7 @@ struct sk_buff {
 	/* private: */
 	__u8			__mono_tc_offset[0];
 	/* public: */
-	__u8			mono_delivery_time:1;	/* See SKB_MONO_DELIVERY_TIME_MASK */
+	__u8			tstamp_type:1;	/* See SKB_MONO_DELIVERY_TIME_MASK */
 #ifdef CONFIG_NET_XGRESS
 	__u8			tc_at_ingress:1;	/* See TC_AT_INGRESS_MASK */
 	__u8			tc_skip_classify:1;
@@ -4257,7 +4257,7 @@ static inline void skb_get_new_timestampns(const struct sk_buff *skb,
 static inline void __net_timestamp(struct sk_buff *skb)
 {
 	skb->tstamp = ktime_get_real();
-	skb->mono_delivery_time = 0;
+	skb->tstamp_type = 0;
 }
 
 static inline ktime_t net_timedelta(ktime_t t)
@@ -4269,7 +4269,7 @@ static inline void skb_set_delivery_time(struct sk_buff *skb, ktime_t kt,
 					 bool mono)
 {
 	skb->tstamp = kt;
-	skb->mono_delivery_time = kt && mono;
+	skb->tstamp_type = kt && mono;
 }
 
 DECLARE_STATIC_KEY_FALSE(netstamp_needed_key);
@@ -4279,8 +4279,8 @@ DECLARE_STATIC_KEY_FALSE(netstamp_needed_key);
  */
 static inline void skb_clear_delivery_time(struct sk_buff *skb)
 {
-	if (skb->mono_delivery_time) {
-		skb->mono_delivery_time = 0;
+	if (skb->tstamp_type) {
+		skb->tstamp_type = 0;
 		if (static_branch_unlikely(&netstamp_needed_key))
 			skb->tstamp = ktime_get_real();
 		else
@@ -4290,7 +4290,7 @@ static inline void skb_clear_delivery_time(struct sk_buff *skb)
 
 static inline void skb_clear_tstamp(struct sk_buff *skb)
 {
-	if (skb->mono_delivery_time)
+	if (skb->tstamp_type)
 		return;
 
 	skb->tstamp = 0;
@@ -4298,7 +4298,7 @@ static inline void skb_clear_tstamp(struct sk_buff *skb)
 
 static inline ktime_t skb_tstamp(const struct sk_buff *skb)
 {
-	if (skb->mono_delivery_time)
+	if (skb->tstamp_type)
 		return 0;
 
 	return skb->tstamp;
@@ -4306,7 +4306,7 @@ static inline ktime_t skb_tstamp(const struct sk_buff *skb)
 
 static inline ktime_t skb_tstamp_cond(const struct sk_buff *skb, bool cond)
 {
-	if (!skb->mono_delivery_time && skb->tstamp)
+	if (!skb->tstamp_type && skb->tstamp)
 		return skb->tstamp;
 
 	if (static_branch_unlikely(&netstamp_needed_key) || cond)
diff --git a/include/net/inet_frag.h b/include/net/inet_frag.h
index 153960663ce4..5af6eb14c5db 100644
--- a/include/net/inet_frag.h
+++ b/include/net/inet_frag.h
@@ -76,7 +76,7 @@ struct frag_v6_compare_key {
  * @stamp: timestamp of the last received fragment
  * @len: total length of the original datagram
  * @meat: length of received fragments so far
- * @mono_delivery_time: stamp has a mono delivery time (EDT)
+ * @tstamp_type: stamp has a mono delivery time (EDT)
  * @flags: fragment queue flags
  * @max_size: maximum received fragment size
  * @fqdir: pointer to struct fqdir
@@ -97,7 +97,7 @@ struct inet_frag_queue {
 	ktime_t			stamp;
 	int			len;
 	int			meat;
-	u8			mono_delivery_time;
+	u8			tstamp_type;
 	__u8			flags;
 	u16			max_size;
 	struct fqdir		*fqdir;
diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index 6f877e31709b..989435bd1690 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -32,7 +32,7 @@ static int nf_br_ip_fragment(struct net *net, struct sock *sk,
 					   struct sk_buff *))
 {
 	int frag_max_size = BR_INPUT_SKB_CB(skb)->frag_max_size;
-	bool mono_delivery_time = skb->mono_delivery_time;
+	bool tstamp_type = skb->tstamp_type;
 	unsigned int hlen, ll_rs, mtu;
 	ktime_t tstamp = skb->tstamp;
 	struct ip_frag_state state;
@@ -82,7 +82,7 @@ static int nf_br_ip_fragment(struct net *net, struct sock *sk,
 			if (iter.frag)
 				ip_fraglist_prepare(skb, &iter);
 
-			skb_set_delivery_time(skb, tstamp, mono_delivery_time);
+			skb_set_delivery_time(skb, tstamp, tstamp_type);
 			err = output(net, sk, data, skb);
 			if (err || !iter.frag)
 				break;
@@ -113,7 +113,7 @@ static int nf_br_ip_fragment(struct net *net, struct sock *sk,
 			goto blackhole;
 		}
 
-		skb_set_delivery_time(skb2, tstamp, mono_delivery_time);
+		skb_set_delivery_time(skb2, tstamp, tstamp_type);
 		err = output(net, sk, data, skb2);
 		if (err)
 			goto blackhole;
diff --git a/net/core/dev.c b/net/core/dev.c
index 303a6ff46e4e..8b88f8118052 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2113,7 +2113,7 @@ EXPORT_SYMBOL(net_disable_timestamp);
 static inline void net_timestamp_set(struct sk_buff *skb)
 {
 	skb->tstamp = 0;
-	skb->mono_delivery_time = 0;
+	skb->tstamp_type = 0;
 	if (static_branch_unlikely(&netstamp_needed_key))
 		skb->tstamp = ktime_get_real();
 }
diff --git a/net/core/filter.c b/net/core/filter.c
index 8adf95765cdd..0f535defdd2c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7698,13 +7698,13 @@ BPF_CALL_3(bpf_skb_set_tstamp, struct sk_buff *, skb,
 		if (!tstamp)
 			return -EINVAL;
 		skb->tstamp = tstamp;
-		skb->mono_delivery_time = 1;
+		skb->tstamp_type = 1;
 		break;
 	case BPF_SKB_TSTAMP_UNSPEC:
 		if (tstamp)
 			return -EINVAL;
 		skb->tstamp = 0;
-		skb->mono_delivery_time = 0;
+		skb->tstamp_type = 0;
 		break;
 	default:
 		return -EINVAL;
@@ -9413,7 +9413,7 @@ static struct bpf_insn *bpf_convert_tstamp_read(const struct bpf_prog *prog,
 					TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK);
 		*insn++ = BPF_JMP32_IMM(BPF_JNE, tmp_reg,
 					TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK, 2);
-		/* skb->tc_at_ingress && skb->mono_delivery_time,
+		/* skb->tc_at_ingress && skb->tstamp_type:1,
 		 * read 0 as the (rcv) timestamp.
 		 */
 		*insn++ = BPF_MOV64_IMM(value_reg, 0);
@@ -9438,7 +9438,7 @@ static struct bpf_insn *bpf_convert_tstamp_write(const struct bpf_prog *prog,
 	 * the bpf prog is aware the tstamp could have delivery time.
 	 * Thus, write skb->tstamp as is if tstamp_type_access is true.
 	 * Otherwise, writing at ingress will have to clear the
-	 * mono_delivery_time bit also.
+	 * mono_delivery_time (skb->tstamp_type:1)bit also.
 	 */
 	if (!prog->tstamp_type_access) {
 		__u8 tmp_reg = BPF_REG_AX;
diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index 7072fc0783ef..25f8ee14ea73 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -578,7 +578,7 @@ void inet_frag_reasm_finish(struct inet_frag_queue *q, struct sk_buff *head,
 	skb_mark_not_on_list(head);
 	head->prev = NULL;
 	head->tstamp = q->stamp;
-	head->mono_delivery_time = q->mono_delivery_time;
+	head->tstamp_type = q->tstamp_type;
 }
 EXPORT_SYMBOL(inet_frag_reasm_finish);
 
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index a4941f53b523..1edba0d0ae90 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -355,7 +355,7 @@ static int ip_frag_queue(struct ipq *qp, struct sk_buff *skb)
 		qp->iif = dev->ifindex;
 
 	qp->q.stamp = skb->tstamp;
-	qp->q.mono_delivery_time = skb->mono_delivery_time;
+	qp->q.tstamp_type = skb->tstamp_type;
 	qp->q.meat += skb->len;
 	qp->ecn |= ecn;
 	add_frag_mem_limit(qp->q.fqdir, skb->truesize);
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 1fe794967211..e8ec7e8ae2e0 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -764,7 +764,7 @@ int ip_do_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 {
 	struct iphdr *iph;
 	struct sk_buff *skb2;
-	bool mono_delivery_time = skb->mono_delivery_time;
+	bool tstamp_type = skb->tstamp_type;
 	struct rtable *rt = skb_rtable(skb);
 	unsigned int mtu, hlen, ll_rs;
 	struct ip_fraglist_iter iter;
@@ -856,7 +856,7 @@ int ip_do_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 				}
 			}
 
-			skb_set_delivery_time(skb, tstamp, mono_delivery_time);
+			skb_set_delivery_time(skb, tstamp, tstamp_type);
 			err = output(net, sk, skb);
 
 			if (!err)
@@ -912,7 +912,7 @@ int ip_do_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 		/*
 		 *	Put this fragment into the sending queue.
 		 */
-		skb_set_delivery_time(skb2, tstamp, mono_delivery_time);
+		skb_set_delivery_time(skb2, tstamp, tstamp_type);
 		err = output(net, sk, skb2);
 		if (err)
 			goto fail;
@@ -1649,7 +1649,7 @@ void ip_send_unicast_reply(struct sock *sk, struct sk_buff *skb,
 			  arg->csumoffset) = csum_fold(csum_add(nskb->csum,
 								arg->csum));
 		nskb->ip_summed = CHECKSUM_NONE;
-		nskb->mono_delivery_time = !!transmit_time;
+		nskb->tstamp_type = !!transmit_time;
 		if (txhash)
 			skb_set_hash(nskb, txhash, PKT_HASH_TYPE_L4);
 		ip_push_pending_frames(sk, &fl4);
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index b9dd3a66e423..61ddc9549160 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -859,7 +859,7 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 	struct rt6_info *rt = (struct rt6_info *)skb_dst(skb);
 	struct ipv6_pinfo *np = skb->sk && !dev_recursion_level() ?
 				inet6_sk(skb->sk) : NULL;
-	bool mono_delivery_time = skb->mono_delivery_time;
+	bool tstamp_type = skb->tstamp_type;
 	struct ip6_frag_state state;
 	unsigned int mtu, hlen, nexthdr_offset;
 	ktime_t tstamp = skb->tstamp;
@@ -955,7 +955,7 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 			if (iter.frag)
 				ip6_fraglist_prepare(skb, &iter);
 
-			skb_set_delivery_time(skb, tstamp, mono_delivery_time);
+			skb_set_delivery_time(skb, tstamp, tstamp_type);
 			err = output(net, sk, skb);
 			if (!err)
 				IP6_INC_STATS(net, ip6_dst_idev(&rt->dst),
@@ -1016,7 +1016,7 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 		/*
 		 *	Put this fragment into the sending queue.
 		 */
-		skb_set_delivery_time(frag, tstamp, mono_delivery_time);
+		skb_set_delivery_time(frag, tstamp, tstamp_type);
 		err = output(net, sk, frag);
 		if (err)
 			goto fail;
diff --git a/net/ipv6/netfilter.c b/net/ipv6/netfilter.c
index 53d255838e6a..61f28b9a2d34 100644
--- a/net/ipv6/netfilter.c
+++ b/net/ipv6/netfilter.c
@@ -126,7 +126,7 @@ int br_ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 				  struct sk_buff *))
 {
 	int frag_max_size = BR_INPUT_SKB_CB(skb)->frag_max_size;
-	bool mono_delivery_time = skb->mono_delivery_time;
+	bool tstamp_type = skb->tstamp_type;
 	ktime_t tstamp = skb->tstamp;
 	struct ip6_frag_state state;
 	u8 *prevhdr, nexthdr = 0;
@@ -192,7 +192,7 @@ int br_ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 			if (iter.frag)
 				ip6_fraglist_prepare(skb, &iter);
 
-			skb_set_delivery_time(skb, tstamp, mono_delivery_time);
+			skb_set_delivery_time(skb, tstamp, tstamp_type);
 			err = output(net, sk, data, skb);
 			if (err || !iter.frag)
 				break;
@@ -225,7 +225,7 @@ int br_ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 			goto blackhole;
 		}
 
-		skb_set_delivery_time(skb2, tstamp, mono_delivery_time);
+		skb_set_delivery_time(skb2, tstamp, tstamp_type);
 		err = output(net, sk, data, skb2);
 		if (err)
 			goto blackhole;
diff --git a/net/ipv6/netfilter/nf_conntrack_reasm.c b/net/ipv6/netfilter/nf_conntrack_reasm.c
index 1a51a44571c3..6376555de1ae 100644
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -264,7 +264,7 @@ static int nf_ct_frag6_queue(struct frag_queue *fq, struct sk_buff *skb,
 		fq->iif = dev->ifindex;
 
 	fq->q.stamp = skb->tstamp;
-	fq->q.mono_delivery_time = skb->mono_delivery_time;
+	fq->q.tstamp_type = skb->tstamp_type;
 	fq->q.meat += skb->len;
 	fq->ecn |= ecn;
 	if (payload_len > fq->q.max_size)
diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
index acb4f119e11f..ea724ff558b4 100644
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -198,7 +198,7 @@ static int ip6_frag_queue(struct frag_queue *fq, struct sk_buff *skb,
 		fq->iif = dev->ifindex;
 
 	fq->q.stamp = skb->tstamp;
-	fq->q.mono_delivery_time = skb->mono_delivery_time;
+	fq->q.tstamp_type = skb->tstamp_type;
 	fq->q.meat += skb->len;
 	fq->ecn |= ecn;
 	add_frag_mem_limit(fq->q.fqdir, skb->truesize);
diff --git a/net/sched/act_bpf.c b/net/sched/act_bpf.c
index 0e3cf11ae5fc..d62edd36b455 100644
--- a/net/sched/act_bpf.c
+++ b/net/sched/act_bpf.c
@@ -54,8 +54,8 @@ TC_INDIRECT_SCOPE int tcf_bpf_act(struct sk_buff *skb,
 		bpf_compute_data_pointers(skb);
 		filter_res = bpf_prog_run(filter, skb);
 	}
-	if (unlikely(!skb->tstamp && skb->mono_delivery_time))
-		skb->mono_delivery_time = 0;
+	if (unlikely(!skb->tstamp && skb->tstamp_type))
+		skb->tstamp_type = 0;
 	if (skb_sk_is_prefetched(skb) && filter_res != TC_ACT_OK)
 		skb_orphan(skb);
 
diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
index 5e83e890f6a4..f9cb4378c754 100644
--- a/net/sched/cls_bpf.c
+++ b/net/sched/cls_bpf.c
@@ -104,8 +104,8 @@ TC_INDIRECT_SCOPE int cls_bpf_classify(struct sk_buff *skb,
 			bpf_compute_data_pointers(skb);
 			filter_res = bpf_prog_run(prog->filter, skb);
 		}
-		if (unlikely(!skb->tstamp && skb->mono_delivery_time))
-			skb->mono_delivery_time = 0;
+		if (unlikely(!skb->tstamp && skb->tstamp_type))
+			skb->tstamp_type = 0;
 
 		if (prog->exts_integrated) {
 			res->class   = 0;
-- 
2.25.1


