Return-Path: <linux-kernel+bounces-84309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E2B86A4CD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B3511F2504F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E606125;
	Wed, 28 Feb 2024 01:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O3J4VIcj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347DA4A25;
	Wed, 28 Feb 2024 01:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709082774; cv=none; b=bRZP4q+tAp9XxBkLuvFTPigWEEUedRwW91vWJX4tQy8O3Rjb0n9qhnKsR6xXUBNB5/ef0Ll1QkuYyI4tD3lnRdkfmCL/F30JuRcYrQgiOH+D9dYzL7jezW6WdhNYrB65BYIMiVZUtG57qjA3DMjwBuMg2mJB/smIIak9gmNVTMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709082774; c=relaxed/simple;
	bh=/7E3jPDtwBqPYwqb84X2Zs+YG8y0YBARyNpYtTVIElU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ernvzOZ/A/pnYuLYHwXaRirZr1CJWRCWVa3WHkfqmqf2FWTAHWYP+1Y0k6LCn9r/W1pRGFSDbYRVyuQmnBOM32u1155HEcwDRFPt5VntcYvMh4kVtefGsKng12MiFZrTrwQdQ1NJZklgsL9Y4B7FPzDTvzvbjKuViqp+7oD5kL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=O3J4VIcj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41S0Tkr0001350;
	Wed, 28 Feb 2024 01:12:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=qcppdkim1; bh=R9gQkKviol0B+TCxQlYg
	KsRGV00sI+N7h2caDL85j9g=; b=O3J4VIcjd0rl+2dU/MXhq00Ortb0ejYIyd3/
	t9m7fKZ0BFyiK/DMkIUhrr5rDVfxo8Jxsncwr+5z+fac3IKT2zGAx91UQdDZU2Lc
	aT1EdSJ6RAbdzR30F5bylOFbv2X4RkbtQvpoeQynO7Gxrcyy8tJ36oF2kj/r27kK
	TE6u0mykzommQyW/8mPQRhl5AKzMrNECmnIOpoJtVPJ/jJcTWf+hklEc1zvgrn9D
	H/K4hY83qbMy3dlzHEgG0Ms7H3iZb+05UDoJ9YiTphh1hkorLXQMRG97DZr1kINB
	M2IFPF4P94xeNZZitCliVkUOg6aeqEnveuc2sf7fqftzzYy7bA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3whp65rk51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 01:12:39 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 41S16eWi002169;
	Wed, 28 Feb 2024 01:12:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 3whkg2jwv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 01:12:19 +0000
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41S17BCk002568;
	Wed, 28 Feb 2024 01:12:19 GMT
Received: from hu-devc-lv-u20-a-new.qualcomm.com (hu-abchauha-lv.qualcomm.com [10.81.25.35])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 41S1CJ1i008516
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 01:12:19 +0000
Received: by hu-devc-lv-u20-a-new.qualcomm.com (Postfix, from userid 214165)
	id 49BF7220EE; Tue, 27 Feb 2024 17:12:19 -0800 (PST)
From: Abhishek Chauhan <quic_abchauha@quicinc.com>
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>
Cc: kernel@quicinc.com
Subject: [PATCH net-next v2] net: Modify mono_delivery_time with clockid_delivery_time
Date: Tue, 27 Feb 2024 17:12:19 -0800
Message-Id: <20240228011219.1119105-1-quic_abchauha@quicinc.com>
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
X-Proofpoint-GUID: yJ-LnWhq1C6AxFJSXI4NES28n6W4l6K1
X-Proofpoint-ORIG-GUID: yJ-LnWhq1C6AxFJSXI4NES28n6W4l6K1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_11,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=999 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402280008

Bridge driver today has no support to forward the userspace timestamp
packets and ends up resetting the timestamp. ETF qdisc checks the
packet coming from userspace and encounters to be 0 thereby dropping
time sensitive packets. These changes will allow userspace timestamps
packets to be forwarded from the bridge to NIC drivers.

Existing functionality of mono_delivery_time is not altered here
instead just extended with userspace tstamp support for bridge
forwarding path.

Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
---
Changes since v1 
- Changed the commit subject as i am modifying the mono_delivery_time 
  bit with clockid_delivery_time.
- Took care of suggestion mentioned by Willem to use the same bit for 
  userspace delivery time as there are no conflicts between TCP and 
  SCM_TXTIME, because explicit cmsg makes no sense for TCP and only
  RAW and DGRAM sockets interprets it. 
- Clear explaination of why this is needed mentioned below and this 
  is extending the work done by Martin for mono_delivery_time 
  https://patchwork.kernel.org/project/netdevbpf/patch/20220302195525.3480280-1-kafai@fb.com/
- Version 1 patch can be referenced with below link which states 
  the exact problem with tc-etf and discussions which took place
  https://lore.kernel.org/all/20240215215632.2899370-1-quic_abchauha@quicinc.com/

 include/linux/skbuff.h                     | 22 +++++++++++++---------
 net/bridge/netfilter/nf_conntrack_bridge.c |  2 +-
 net/core/dev.c                             |  2 +-
 net/core/filter.c                          |  6 +++---
 net/ieee802154/6lowpan/reassembly.c        |  2 +-
 net/ipv4/inet_fragment.c                   |  2 +-
 net/ipv4/ip_fragment.c                     |  2 +-
 net/ipv4/ip_output.c                       | 13 +++++++++++--
 net/ipv4/raw.c                             |  9 +++++++++
 net/ipv6/ip6_output.c                      | 12 ++++++++++--
 net/ipv6/netfilter.c                       |  2 +-
 net/ipv6/netfilter/nf_conntrack_reasm.c    |  2 +-
 net/ipv6/raw.c                             | 10 +++++++++-
 net/ipv6/reassembly.c                      |  2 +-
 net/sched/act_bpf.c                        |  4 ++--
 net/sched/cls_bpf.c                        |  4 ++--
 16 files changed, 67 insertions(+), 29 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 2dde34c29203..24a34d56cfa3 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -816,10 +816,14 @@ typedef unsigned char *sk_buff_data_t;
  *	@dst_pending_confirm: need to confirm neighbour
  *	@decrypted: Decrypted SKB
  *	@slow_gro: state present at GRO time, slower prepare step required
- *	@mono_delivery_time: When set, skb->tstamp has the
+ *	@clockid_delivery_time: When set, skb->tstamp has the
  *		delivery_time in mono clock base (i.e. EDT).  Otherwise, the
  *		skb->tstamp has the (rcv) timestamp at ingress and
  *		delivery_time at egress.
+ *		This bit is also set if the tstamp is set from userspace which
+ *		acts as an information in the bridge forwarding path to net
+ *		reset the tstamp value when user sets the timestamp using
+ *		SO_TXTIME sockopts
  *	@napi_id: id of the NAPI struct this skb came from
  *	@sender_cpu: (aka @napi_id) source CPU in XPS
  *	@alloc_cpu: CPU which did the skb allocation.
@@ -950,7 +954,7 @@ struct sk_buff {
 	/* private: */
 	__u8			__mono_tc_offset[0];
 	/* public: */
-	__u8			mono_delivery_time:1;	/* See SKB_MONO_DELIVERY_TIME_MASK */
+	__u8			clockid_delivery_time:1; /* See SKB_MONO_DELIVERY_TIME_MASK */
 #ifdef CONFIG_NET_XGRESS
 	__u8			tc_at_ingress:1;	/* See TC_AT_INGRESS_MASK */
 	__u8			tc_skip_classify:1;
@@ -4172,7 +4176,7 @@ static inline void skb_get_new_timestampns(const struct sk_buff *skb,
 static inline void __net_timestamp(struct sk_buff *skb)
 {
 	skb->tstamp = ktime_get_real();
-	skb->mono_delivery_time = 0;
+	skb->clockid_delivery_time = 0;
 }
 
 static inline ktime_t net_timedelta(ktime_t t)
@@ -4184,7 +4188,7 @@ static inline void skb_set_delivery_time(struct sk_buff *skb, ktime_t kt,
 					 bool mono)
 {
 	skb->tstamp = kt;
-	skb->mono_delivery_time = kt && mono;
+	skb->clockid_delivery_time = kt && mono;
 }
 
 DECLARE_STATIC_KEY_FALSE(netstamp_needed_key);
@@ -4194,8 +4198,8 @@ DECLARE_STATIC_KEY_FALSE(netstamp_needed_key);
  */
 static inline void skb_clear_delivery_time(struct sk_buff *skb)
 {
-	if (skb->mono_delivery_time) {
-		skb->mono_delivery_time = 0;
+	if (skb->clockid_delivery_time) {
+		skb->clockid_delivery_time = 0;
 		if (static_branch_unlikely(&netstamp_needed_key))
 			skb->tstamp = ktime_get_real();
 		else
@@ -4205,7 +4209,7 @@ static inline void skb_clear_delivery_time(struct sk_buff *skb)
 
 static inline void skb_clear_tstamp(struct sk_buff *skb)
 {
-	if (skb->mono_delivery_time)
+	if (skb->clockid_delivery_time)
 		return;
 
 	skb->tstamp = 0;
@@ -4213,7 +4217,7 @@ static inline void skb_clear_tstamp(struct sk_buff *skb)
 
 static inline ktime_t skb_tstamp(const struct sk_buff *skb)
 {
-	if (skb->mono_delivery_time)
+	if (skb->clockid_delivery_time)
 		return 0;
 
 	return skb->tstamp;
@@ -4221,7 +4225,7 @@ static inline ktime_t skb_tstamp(const struct sk_buff *skb)
 
 static inline ktime_t skb_tstamp_cond(const struct sk_buff *skb, bool cond)
 {
-	if (!skb->mono_delivery_time && skb->tstamp)
+	if (!skb->clockid_delivery_time && skb->tstamp)
 		return skb->tstamp;
 
 	if (static_branch_unlikely(&netstamp_needed_key) || cond)
diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index abb090f94ed2..cfc9eeaf23fb 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -32,7 +32,7 @@ static int nf_br_ip_fragment(struct net *net, struct sock *sk,
 					   struct sk_buff *))
 {
 	int frag_max_size = BR_INPUT_SKB_CB(skb)->frag_max_size;
-	bool mono_delivery_time = skb->mono_delivery_time;
+	bool mono_delivery_time = skb->clockid_delivery_time;
 	unsigned int hlen, ll_rs, mtu;
 	ktime_t tstamp = skb->tstamp;
 	struct ip_frag_state state;
diff --git a/net/core/dev.c b/net/core/dev.c
index bd230ce8fa79..2d6556444f55 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2137,7 +2137,7 @@ EXPORT_SYMBOL(net_disable_timestamp);
 static inline void net_timestamp_set(struct sk_buff *skb)
 {
 	skb->tstamp = 0;
-	skb->mono_delivery_time = 0;
+	skb->clockid_delivery_time = 0;
 	if (static_branch_unlikely(&netstamp_needed_key))
 		skb->tstamp = ktime_get_real();
 }
diff --git a/net/core/filter.c b/net/core/filter.c
index 524adf1fa6d0..c653cff185cb 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7698,13 +7698,13 @@ BPF_CALL_3(bpf_skb_set_tstamp, struct sk_buff *, skb,
 		if (!tstamp)
 			return -EINVAL;
 		skb->tstamp = tstamp;
-		skb->mono_delivery_time = 1;
+		skb->clockid_delivery_time = 1;
 		break;
 	case BPF_SKB_TSTAMP_UNSPEC:
 		if (tstamp)
 			return -EINVAL;
 		skb->tstamp = 0;
-		skb->mono_delivery_time = 0;
+		skb->clockid_delivery_time = 0;
 		break;
 	default:
 		return -EINVAL;
@@ -9413,7 +9413,7 @@ static struct bpf_insn *bpf_convert_tstamp_read(const struct bpf_prog *prog,
 					TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK);
 		*insn++ = BPF_JMP32_IMM(BPF_JNE, tmp_reg,
 					TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK, 2);
-		/* skb->tc_at_ingress && skb->mono_delivery_time,
+		/* skb->tc_at_ingress && skb->clockid_delivery_time,
 		 * read 0 as the (rcv) timestamp.
 		 */
 		*insn++ = BPF_MOV64_IMM(value_reg, 0);
diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
index 6dd960ec558c..651ca0a81e61 100644
--- a/net/ieee802154/6lowpan/reassembly.c
+++ b/net/ieee802154/6lowpan/reassembly.c
@@ -130,7 +130,7 @@ static int lowpan_frag_queue(struct lowpan_frag_queue *fq,
 		goto err;
 
 	fq->q.stamp = skb->tstamp;
-	fq->q.mono_delivery_time = skb->mono_delivery_time;
+	fq->q.mono_delivery_time = skb->clockid_delivery_time;
 	if (frag_type == LOWPAN_DISPATCH_FRAG1)
 		fq->q.flags |= INET_FRAG_FIRST_IN;
 
diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index 7072fc0783ef..71958ea6ffd6 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -578,7 +578,7 @@ void inet_frag_reasm_finish(struct inet_frag_queue *q, struct sk_buff *head,
 	skb_mark_not_on_list(head);
 	head->prev = NULL;
 	head->tstamp = q->stamp;
-	head->mono_delivery_time = q->mono_delivery_time;
+	head->clockid_delivery_time = q->mono_delivery_time;
 }
 EXPORT_SYMBOL(inet_frag_reasm_finish);
 
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index a4941f53b523..6f41fdfda84e 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -355,7 +355,7 @@ static int ip_frag_queue(struct ipq *qp, struct sk_buff *skb)
 		qp->iif = dev->ifindex;
 
 	qp->q.stamp = skb->tstamp;
-	qp->q.mono_delivery_time = skb->mono_delivery_time;
+	qp->q.mono_delivery_time = skb->clockid_delivery_time;
 	qp->q.meat += skb->len;
 	qp->ecn |= ecn;
 	add_frag_mem_limit(qp->q.fqdir, skb->truesize);
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 5b5a0adb927f..1b31171b58a4 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -764,7 +764,7 @@ int ip_do_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 {
 	struct iphdr *iph;
 	struct sk_buff *skb2;
-	bool mono_delivery_time = skb->mono_delivery_time;
+	bool mono_delivery_time = skb->clockid_delivery_time;
 	struct rtable *rt = skb_rtable(skb);
 	unsigned int mtu, hlen, ll_rs;
 	struct ip_fraglist_iter iter;
@@ -1455,6 +1455,15 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
 	skb->priority = (cork->tos != -1) ? cork->priority: READ_ONCE(sk->sk_priority);
 	skb->mark = cork->mark;
 	skb->tstamp = cork->transmit_time;
+	/* TX timestamp from userspace can be set by setting SO_TXTIME flag
+	 * Once userspace sets the SO_TXTIME flag internally SOCK_TXTIME is set
+	 * So we are setting the clockid_delivery_time based on if SOCK_TXTIME is
+	 * set or not.
+	 * Note:- the reason why we cannot use clockid to set the bool flag
+	 * is because if userspace sets Monotonic clocks the macro value for
+	 * monotonic clocks is 0 and !!clockid will return 0 for monotonic.
+	 */
+	skb->clockid_delivery_time = sock_flag(sk, SOCK_TXTIME);
 	/*
 	 * Steal rt from cork.dst to avoid a pair of atomic_inc/atomic_dec
 	 * on dst refcount
@@ -1646,7 +1655,7 @@ void ip_send_unicast_reply(struct sock *sk, struct sk_buff *skb,
 			  arg->csumoffset) = csum_fold(csum_add(nskb->csum,
 								arg->csum));
 		nskb->ip_summed = CHECKSUM_NONE;
-		nskb->mono_delivery_time = !!transmit_time;
+		nskb->clockid_delivery_time = !!transmit_time;
 		if (txhash)
 			skb_set_hash(nskb, txhash, PKT_HASH_TYPE_L4);
 		ip_push_pending_frames(sk, &fl4);
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index aea89326c697..6ade217c4251 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -353,6 +353,15 @@ static int raw_send_hdrinc(struct sock *sk, struct flowi4 *fl4,
 	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = sockc->mark;
 	skb->tstamp = sockc->transmit_time;
+	/* TX timestamp from userspace can be set by setting SO_TXTIME flag
+	 * Once userspace sets the SO_TXTIME flag internally SOCK_TXTIME is set
+	 * So we are setting the clockid_delivery_time based on if SOCK_TXTIME is
+	 * set or not.
+	 * Note:- the reason why we cannot use clockid to set the bool flag
+	 * is because if userspace sets Monotonic clocks the macro value for
+	 * monotonic clocks is 0 and !!clockid will return 0 for monotonic.
+	 */
+	skb->clockid_delivery_time = sock_flag(sk, SOCK_TXTIME);
 	skb_dst_set(skb, &rt->dst);
 	*rtp = NULL;
 
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index a722a43dd668..e4548e395c3d 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -859,7 +859,7 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 	struct rt6_info *rt = (struct rt6_info *)skb_dst(skb);
 	struct ipv6_pinfo *np = skb->sk && !dev_recursion_level() ?
 				inet6_sk(skb->sk) : NULL;
-	bool mono_delivery_time = skb->mono_delivery_time;
+	bool mono_delivery_time = skb->clockid_delivery_time;
 	struct ip6_frag_state state;
 	unsigned int mtu, hlen, nexthdr_offset;
 	ktime_t tstamp = skb->tstamp;
@@ -1922,7 +1922,15 @@ struct sk_buff *__ip6_make_skb(struct sock *sk,
 	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = cork->base.mark;
 	skb->tstamp = cork->base.transmit_time;
-
+	/* TX timestamp from userspace can be set by setting SO_TXTIME flag
+	 * Once userspace sets the SO_TXTIME flag internally SOCK_TXTIME is set
+	 * So we are setting the clockid_delivery_time based on if SOCK_TXTIME is
+	 * set or not.
+	 * Note:- the reason why we cannot use clockid to set the bool flag
+	 * is because if userspace sets Monotonic clocks the macro value for
+	 *  monotonic clocks is 0 and !!clockid will return 0 for monotonic.
+	 */
+	skb->clockid_delivery_time = sock_flag(sk, SOCK_TXTIME);
 	ip6_cork_steal_dst(skb, cork);
 	IP6_INC_STATS(net, rt->rt6i_idev, IPSTATS_MIB_OUTREQUESTS);
 	if (proto == IPPROTO_ICMPV6) {
diff --git a/net/ipv6/netfilter.c b/net/ipv6/netfilter.c
index 53d255838e6a..33bc6b0f3b13 100644
--- a/net/ipv6/netfilter.c
+++ b/net/ipv6/netfilter.c
@@ -126,7 +126,7 @@ int br_ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 				  struct sk_buff *))
 {
 	int frag_max_size = BR_INPUT_SKB_CB(skb)->frag_max_size;
-	bool mono_delivery_time = skb->mono_delivery_time;
+	bool mono_delivery_time = skb->clockid_delivery_time;
 	ktime_t tstamp = skb->tstamp;
 	struct ip6_frag_state state;
 	u8 *prevhdr, nexthdr = 0;
diff --git a/net/ipv6/netfilter/nf_conntrack_reasm.c b/net/ipv6/netfilter/nf_conntrack_reasm.c
index b2dd48911c8d..65cdc41c2bba 100644
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -264,7 +264,7 @@ static int nf_ct_frag6_queue(struct frag_queue *fq, struct sk_buff *skb,
 		fq->iif = dev->ifindex;
 
 	fq->q.stamp = skb->tstamp;
-	fq->q.mono_delivery_time = skb->mono_delivery_time;
+	fq->q.mono_delivery_time = skb->clockid_delivery_time;
 	fq->q.meat += skb->len;
 	fq->ecn |= ecn;
 	if (payload_len > fq->q.max_size)
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index 03dbb874c363..1b95ccb50066 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -616,7 +616,15 @@ static int rawv6_send_hdrinc(struct sock *sk, struct msghdr *msg, int length,
 	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = sockc->mark;
 	skb->tstamp = sockc->transmit_time;
-
+	/* TX timestamp from userspace can be set by setting SO_TXTIME flag
+	 * Once userspace sets the SO_TXTIME flag internally SOCK_TXTIME is set
+	 * So we are setting the clockid_delivery_time based on if SOCK_TXTIME is
+	 * set or not.
+	 * Note:- the reason why we cannot use clockid to set the bool flag
+	 * is because if userspace sets Monotonic clocks the macro value for
+	 * monotonic clocks is 0 and !!clockid will return 0 for monotonic.
+	 */
+	skb->clockid_delivery_time = sock_flag(sk, SOCK_TXTIME);
 	skb_put(skb, length);
 	skb_reset_network_header(skb);
 	iph = ipv6_hdr(skb);
diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
index 5ebc47da1000..ad0e6832b199 100644
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -198,7 +198,7 @@ static int ip6_frag_queue(struct frag_queue *fq, struct sk_buff *skb,
 		fq->iif = dev->ifindex;
 
 	fq->q.stamp = skb->tstamp;
-	fq->q.mono_delivery_time = skb->mono_delivery_time;
+	fq->q.mono_delivery_time = skb->clockid_delivery_time;
 	fq->q.meat += skb->len;
 	fq->ecn |= ecn;
 	add_frag_mem_limit(fq->q.fqdir, skb->truesize);
diff --git a/net/sched/act_bpf.c b/net/sched/act_bpf.c
index 0e3cf11ae5fc..47f46fcb1827 100644
--- a/net/sched/act_bpf.c
+++ b/net/sched/act_bpf.c
@@ -54,8 +54,8 @@ TC_INDIRECT_SCOPE int tcf_bpf_act(struct sk_buff *skb,
 		bpf_compute_data_pointers(skb);
 		filter_res = bpf_prog_run(filter, skb);
 	}
-	if (unlikely(!skb->tstamp && skb->mono_delivery_time))
-		skb->mono_delivery_time = 0;
+	if (unlikely(!skb->tstamp && skb->clockid_delivery_time))
+		skb->clockid_delivery_time = 0;
 	if (skb_sk_is_prefetched(skb) && filter_res != TC_ACT_OK)
 		skb_orphan(skb);
 
diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
index 5e83e890f6a4..fc85a7619f07 100644
--- a/net/sched/cls_bpf.c
+++ b/net/sched/cls_bpf.c
@@ -104,8 +104,8 @@ TC_INDIRECT_SCOPE int cls_bpf_classify(struct sk_buff *skb,
 			bpf_compute_data_pointers(skb);
 			filter_res = bpf_prog_run(prog->filter, skb);
 		}
-		if (unlikely(!skb->tstamp && skb->mono_delivery_time))
-			skb->mono_delivery_time = 0;
+		if (unlikely(!skb->tstamp && skb->clockid_delivery_time))
+			skb->clockid_delivery_time = 0;
 
 		if (prog->exts_integrated) {
 			res->class   = 0;
-- 
2.25.1


