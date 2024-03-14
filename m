Return-Path: <linux-kernel+bounces-103728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D72E87C3AE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8A751F22EC9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D5A75814;
	Thu, 14 Mar 2024 19:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gX90QrD4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7EA2BB13;
	Thu, 14 Mar 2024 19:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710444280; cv=none; b=C1rerqgVKYku0Vs38TSc6nVz9Mz45Bwn00NpK+yv1UGGTmTr4ww1yS9v/9qFQ29Damk6BCoAg9DguQNyhEG5BZpSJA/z6RI3zx2MEsTASMYN0LDbGbU1uFd+p3LO2vGd+nm7ui8TdZJooJFwWH+Hp9TK5yrZmXsXIU53GCI1Www=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710444280; c=relaxed/simple;
	bh=bmaxMALUKgLtv7SudtVMFmvD4JDuAXqqTz5DADE5p+o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r1nsQHjgwaLbu0T67R/kqLRTTAuDfq0ry84IMzZ6iE9a6DdI+CN08AOu8ObPNTKyKJU0eNwtz3npa8W3oenn21EozngWvfUGh9M+h9U1jpuu6j2OqPqI7PHrV6gagrnUs/lBhTMR+yKINiW7PwD3j67u1g56PK+bZj+ZWhNy6Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gX90QrD4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42EDU9Zi018536;
	Thu, 14 Mar 2024 19:24:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=qcppdkim1; bh=v+5g7bLm6rjN0ZOMZykp
	wvh+wm82hsuHU/ymlwIQ2Qs=; b=gX90QrD4cXn44BRjDmkMaDZup/tH9eAH8HZp
	cIsw6d8CR+vCVOkmKnbb60NWUsZwOpQYER+RAXfo8FXVhPWfS1+fdfwRaImYEGHU
	DOLowQYPUjYiu6fzVLIVYLIOC4Cgg8oPm2HHve7KIS5YXqHuBHiNm4JyxOQZ+rSQ
	kRLlNU0+Xk7Ij999+IDJ8T1TBr3CWR3xIdYaPycsLCMBZtsjXittXRUH6iNp8RC7
	pzFgHMOT23JxPjnHtmY7rRcugm1nKH1UlqUx04kfRhB/q9x6IFx+WUDSnZrgh21p
	wB7ttwjG9cUFU5NlvNQ3/m1q8nNApvRZ6ixcxLJR0ROC7zfBkw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wuy3y96nr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 19:24:08 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 42EJO5ix018743;
	Thu, 14 Mar 2024 19:24:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 3wv61e0gwa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 19:24:05 +0000
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42EJO409018736;
	Thu, 14 Mar 2024 19:24:05 GMT
Received: from hu-devc-lv-u20-a-new.qualcomm.com (hu-abchauha-lv.qualcomm.com [10.81.25.35])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 42EJO4Wk018732
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 19:24:04 +0000
Received: by hu-devc-lv-u20-a-new.qualcomm.com (Postfix, from userid 214165)
	id 30D9522072; Thu, 14 Mar 2024 12:24:04 -0700 (PDT)
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
Subject: [PATCH net-next v3] Revert "net: Re-use and set mono_delivery_time bit for userspace tstamp packets"
Date: Thu, 14 Mar 2024 12:24:04 -0700
Message-Id: <20240314192404.1867189-1-quic_abchauha@quicinc.com>
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
X-Proofpoint-GUID: 5BkjKfNz1R_RzTDoWQoFez4WsxTfs_iG
X-Proofpoint-ORIG-GUID: 5BkjKfNz1R_RzTDoWQoFez4WsxTfs_iG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403140149

This reverts commit 885c36e59f46375c138de18ff1692f18eff67b7f.

The patch currently broke the bpf selftest test_tc_dtime because
uapi field __sk_buff->tstamp_type depends on skb->mono_delivery_time which
does not necessarily mean mono with the original fix as the bit was re-used
for userspace timestamp as well to avoid tstamp reset in the forwarding
path. To solve this we need to keep mono_delivery_time as is and
introduce another bit called user_delivery_time and fall back to the
initial proposal of setting the user_delivery_time bit based on
sk_clockid set from userspace.

Fixes: 885c36e59f46 ("net: Re-use and set mono_delivery_time bit for userspace tstamp packets")
Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
---
Changes since v2
- Fixed minor comments given by Willem 
- Added Fixes tag as mentioned by Jakub
- Corrected the SHA 

Changes since v1
- Took care of Jakub's comment to explain more about the 
  revert commit 
- Added Link to the discussion of the problem found in the 
  original commit. 
  
 include/linux/skbuff.h | 6 +++---
 net/ipv4/ip_output.c   | 1 -
 net/ipv4/raw.c         | 1 -
 net/ipv6/ip6_output.c  | 2 +-
 net/ipv6/raw.c         | 2 +-
 net/packet/af_packet.c | 4 +---
 6 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 3023bc2be6a1..7d56ce195120 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -822,9 +822,9 @@ typedef unsigned char *sk_buff_data_t;
  *	@decrypted: Decrypted SKB
  *	@slow_gro: state present at GRO time, slower prepare step required
  *	@mono_delivery_time: When set, skb->tstamp has the
- *		delivery_time in mono clock base (i.e., EDT) or a clock base chosen
- *		by SO_TXTIME. If zero, skb->tstamp has the (rcv) timestamp at
- *		ingress.
+ *		delivery_time in mono clock base (i.e. EDT).  Otherwise, the
+ *		skb->tstamp has the (rcv) timestamp at ingress and
+ *		delivery_time at egress.
  *	@napi_id: id of the NAPI struct this skb came from
  *	@sender_cpu: (aka @napi_id) source CPU in XPS
  *	@alloc_cpu: CPU which did the skb allocation.
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 33f93dc730a3..1fe794967211 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1458,7 +1458,6 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
 	skb->priority = (cork->tos != -1) ? cork->priority: READ_ONCE(sk->sk_priority);
 	skb->mark = cork->mark;
 	skb->tstamp = cork->transmit_time;
-	skb->mono_delivery_time = !!skb->tstamp;
 	/*
 	 * Steal rt from cork.dst to avoid a pair of atomic_inc/atomic_dec
 	 * on dst refcount
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 42ac434cfcfa..12b3740393ba 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -360,7 +360,6 @@ static int raw_send_hdrinc(struct sock *sk, struct flowi4 *fl4,
 	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = sockc->mark;
 	skb->tstamp = sockc->transmit_time;
-	skb->mono_delivery_time = !!skb->tstamp;
 	skb_dst_set(skb, &rt->dst);
 	*rtp = NULL;
 
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 02eeca5492cd..b9dd3a66e423 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1925,7 +1925,7 @@ struct sk_buff *__ip6_make_skb(struct sock *sk,
 	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = cork->base.mark;
 	skb->tstamp = cork->base.transmit_time;
-	skb->mono_delivery_time = !!skb->tstamp;
+
 	ip6_cork_steal_dst(skb, cork);
 	IP6_INC_STATS(net, rt->rt6i_idev, IPSTATS_MIB_OUTREQUESTS);
 	if (proto == IPPROTO_ICMPV6) {
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index ca49e6617afa..0d896ca7b589 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -622,7 +622,7 @@ static int rawv6_send_hdrinc(struct sock *sk, struct msghdr *msg, int length,
 	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = sockc->mark;
 	skb->tstamp = sockc->transmit_time;
-	skb->mono_delivery_time = !!skb->tstamp;
+
 	skb_put(skb, length);
 	skb_reset_network_header(skb);
 	iph = ipv6_hdr(skb);
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 61270826b9ac..4c4fbdd2f96f 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2057,7 +2057,7 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
 	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = READ_ONCE(sk->sk_mark);
 	skb->tstamp = sockc.transmit_time;
-	skb->mono_delivery_time = !!skb->tstamp;
+
 	skb_setup_tx_timestamp(skb, sockc.tsflags);
 
 	if (unlikely(extra_len == 4))
@@ -2586,7 +2586,6 @@ static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
 	skb->priority = READ_ONCE(po->sk.sk_priority);
 	skb->mark = READ_ONCE(po->sk.sk_mark);
 	skb->tstamp = sockc->transmit_time;
-	skb->mono_delivery_time = !!skb->tstamp;
 	skb_setup_tx_timestamp(skb, sockc->tsflags);
 	skb_zcopy_set_nouarg(skb, ph.raw);
 
@@ -3065,7 +3064,6 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = sockc.mark;
 	skb->tstamp = sockc.transmit_time;
-	skb->mono_delivery_time = !!skb->tstamp;
 
 	if (unlikely(extra_len == 4))
 		skb->no_fcs = 1;
-- 
2.25.1


