Return-Path: <linux-kernel+bounces-102652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA76D87B55D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 00:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17F801C20EF8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FC45D8E0;
	Wed, 13 Mar 2024 23:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HuycSPKH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543105336D;
	Wed, 13 Mar 2024 23:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710373833; cv=none; b=iANPqg5XNT0O7aYvmfPjkUpUzsn6a55GoTMcyiIg74PmW6xGpewK+zdgL8IywCdDgw2Mj0qlDXm+w2pOgDzYG2STAyMCr2VEymKYjvvXndw/2VsA7mAxeeh4s6VULiL+EUDjdmYuKF2sRq3BqG7kWUelecotNjWQHxQuwb4izS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710373833; c=relaxed/simple;
	bh=Iqu671viOaxMlkHad01JwgU/Fjs95PK/4ZgTeuyLlzY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bK4VTh5lg/eeZ6eWefN6aDHo4Jm7u6Hqe+zo27AF8PHNhlnp3mDOXQBzjeBcuVqC3bJPfaaRWlOHqx5+1+/wq3K3vE/tujiZNKcv+Og/lMnr15pVhEnsbsM5A61SdJd/qW3lEFTgloJgDFVrlHBK1Cmgj3i0xSVZT49OvM/dwRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HuycSPKH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42DLPsT4016687;
	Wed, 13 Mar 2024 23:50:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=qcppdkim1; bh=qLX4xS4p1n/ZBfeK2M61
	jtQ4dp3fLCxHwY1VXyJBo2M=; b=HuycSPKHmYRJ1wmlQ3fsP3xyTHexqmmdFAEz
	lC/uPIyrMi/wgArR+I763UMVTucoGbWMjDIlwaoyARrytJwitLKX4Al1LjEpt3om
	7m8xlIEDE257f5o1kq1OeK7MTO7hbp1j3x/nB2XH6Nwya7eiZDQknz0ZbBAui4uR
	vnU6j4KUYJLYK6Fvz/Ipid1wjfF421JrhCUF0DxkZKMTKjMRYq5pNazC88WhH8YN
	/xkBVDi3Zk75aR013fns/KS8sUFy5rpcsMljjXEvPrDTjocBmhvVXoQYxwexhilX
	sCEKtuEBfLPFWuGVa9uve1hhNOpndFn3FADso2P06vNSt/+5qw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wu815t2mc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 23:50:07 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA02.qualcomm.com [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 42DNo5H2006782;
	Wed, 13 Mar 2024 23:50:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 3wu54qfsck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 23:50:05 +0000
Received: from NALASPPMTA02.qualcomm.com (NALASPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42DNo5T6006771;
	Wed, 13 Mar 2024 23:50:05 GMT
Received: from hu-devc-lv-u20-a-new.qualcomm.com (hu-abchauha-lv.qualcomm.com [10.81.25.35])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 42DNo4wh006732
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 23:50:05 +0000
Received: by hu-devc-lv-u20-a-new.qualcomm.com (Postfix, from userid 214165)
	id 0B920220D3; Wed, 13 Mar 2024 16:50:03 -0700 (PDT)
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
Subject: [PATCH net-next v1] Revert "net: Re-use and set mono_delivery_time bit for userspace tstamp packets"
Date: Wed, 13 Mar 2024 16:50:03 -0700
Message-Id: <20240313235003.1354814-1-quic_abchauha@quicinc.com>
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
X-Proofpoint-GUID: VMTgVnti4k-1A-Kqsfnu0y1Gq39-QNm_
X-Proofpoint-ORIG-GUID: VMTgVnti4k-1A-Kqsfnu0y1Gq39-QNm_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_10,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403130181

This reverts commit 30bb896b98fce7d823a96fc02cd69be30384a5cc.

Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
---
Reason for revert - 
https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
1. Fallback to design proposed in version 1 to have a seperate user_delivery_time
bit 
2. Keep mono_delivery_time as ease
3. Add user_delivery_time as a new bitfield will be a seperate patch 
4. do not reset the time if either mono_delivery_time or user_delivery_time is set
5. we will need a user_delivery_time bit and use that to look at sk_clockid

 include/linux/skbuff.h | 6 +++---
 net/ipv4/ip_output.c   | 1 -
 net/ipv4/raw.c         | 1 -
 net/ipv6/ip6_output.c  | 2 +-
 net/ipv6/raw.c         | 2 +-
 net/packet/af_packet.c | 4 +---
 6 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 4726298d4ed4..2dde34c29203 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -817,9 +817,9 @@ typedef unsigned char *sk_buff_data_t;
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
index ff1df64c5697..5b5a0adb927f 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1455,7 +1455,6 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
 	skb->priority = (cork->tos != -1) ? cork->priority: READ_ONCE(sk->sk_priority);
 	skb->mark = cork->mark;
 	skb->tstamp = cork->transmit_time;
-	skb->mono_delivery_time = !!skb->tstamp;
 	/*
 	 * Steal rt from cork.dst to avoid a pair of atomic_inc/atomic_dec
 	 * on dst refcount
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index c4c29fc5b73f..aea89326c697 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -353,7 +353,6 @@ static int raw_send_hdrinc(struct sock *sk, struct flowi4 *fl4,
 	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = sockc->mark;
 	skb->tstamp = sockc->transmit_time;
-	skb->mono_delivery_time = !!skb->tstamp;
 	skb_dst_set(skb, &rt->dst);
 	*rtp = NULL;
 
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 2fc1d03dc07d..a722a43dd668 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1922,7 +1922,7 @@ struct sk_buff *__ip6_make_skb(struct sock *sk,
 	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = cork->base.mark;
 	skb->tstamp = cork->base.transmit_time;
-	skb->mono_delivery_time = !!skb->tstamp;
+
 	ip6_cork_steal_dst(skb, cork);
 	IP6_INC_STATS(net, rt->rt6i_idev, IPSTATS_MIB_OUTREQUESTS);
 	if (proto == IPPROTO_ICMPV6) {
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index 13f54f8eea35..03dbb874c363 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -616,7 +616,7 @@ static int rawv6_send_hdrinc(struct sock *sk, struct msghdr *msg, int length,
 	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = sockc->mark;
 	skb->tstamp = sockc->transmit_time;
-	skb->mono_delivery_time = !!skb->tstamp;
+
 	skb_put(skb, length);
 	skb_reset_network_header(skb);
 	iph = ipv6_hdr(skb);
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 0db31ca4982d..c9bbc2686690 100644
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


