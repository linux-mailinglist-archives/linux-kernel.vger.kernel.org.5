Return-Path: <linux-kernel+bounces-87815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B49E86D95E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 03:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D3911C22978
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFB239AE8;
	Fri,  1 Mar 2024 02:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="j7kjfv0f"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05D92E415;
	Fri,  1 Mar 2024 02:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709258771; cv=none; b=nMO8CzPDg20OmcweIEG6TA9G/qP2d6daFEcsWnvxlEkqc6sUJK0sOQneVz0BU45lLEzCo7f/6D4NI0+dvEe2PqW0kQK+tA/XS9MwDdPHPBRFf4QLoFqqzEdUvea2JUPKm9umnzn4m+2W6Jzm4+O7NJ04r18Gjt19eZjU4bX20Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709258771; c=relaxed/simple;
	bh=1JYDWt9/lQAdTmO6LuC+lIDS5zpDWnKHDJ+jJuhqmxI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gbmg9Nri0+xtYryDY/iMzvs9n18VwYqSwE/8fVc25UVVgwphSjHWrFnNI/AhezRA7AxjgeMKVrUQkVZY+rpO7xXrtYikmS5TWOzXj7vxvv6Xbqul82B1u3PdlhMo6SpUDBU6TyQC71uh7MJ7K9tdnkL6Z4jGvkppQjEqvJTb5Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=j7kjfv0f; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4210kho4025037;
	Fri, 1 Mar 2024 02:05:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=qcppdkim1; bh=0JZdoBk5Er3H08O48PfU
	Qe+S0VcFEHlAxA+nW8y/1as=; b=j7kjfv0f3Lvl7VpVoe26i75hMdCz8CNYSwTr
	zBKj04RtCIzUlyQ+Cp3x4Sr3mLdxbJK63LK9oODqtrlPQkD+s2+kqZ13nBurWPCQ
	4BN6H/v+GBxng7kqXigmVIAfhYj9BzZkINh18d5CAAYmrx+9nkyfpGJkscpbwyKs
	oJ2oiWMyDqnL39EPEuak9SkFriVr3O83iOk/RSPsKItf64d5M4E8QLRNRhi822h1
	GXCRvAxLUYV1T//t/lla+hA1RYpAjOTYmTEWT2VX9T2BBd62EDToA0QF/ga68qj7
	IXHiLKKxm2VCaw2vUkUfLE96qO7viOqJ9O7KzdgDAJJ/w5TxrQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wjx6c1a8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 02:05:57 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 42121gWB000388;
	Fri, 1 Mar 2024 02:05:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 3wk3wk8qh9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 02:05:57 +0000
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42125ul5005397;
	Fri, 1 Mar 2024 02:05:56 GMT
Received: from hu-devc-lv-u20-a-new.qualcomm.com (hu-abchauha-lv.qualcomm.com [10.81.25.35])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 42125uhr005396
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 02:05:56 +0000
Received: by hu-devc-lv-u20-a-new.qualcomm.com (Postfix, from userid 214165)
	id 810CE220B3; Thu, 29 Feb 2024 18:05:56 -0800 (PST)
From: Abhishek Chauhan <quic_abchauha@quicinc.com>
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>
Cc: kernel@quicinc.com
Subject: [PATCH net-next v3] net: Re-use and set mono_delivery_time bit for userspace tstamp packets
Date: Thu, 29 Feb 2024 18:05:56 -0800
Message-Id: <20240301020556.2303531-1-quic_abchauha@quicinc.com>
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
X-Proofpoint-GUID: 5pQkH1VPHdP2aPvkWYZ-sBamlGo62Vnp
X-Proofpoint-ORIG-GUID: 5pQkH1VPHdP2aPvkWYZ-sBamlGo62Vnp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_08,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 spamscore=0 mlxscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 adultscore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403010016

Bridge driver today has no support to forward the userspace timestamp
packets and ends up resetting the timestamp. ETF qdisc checks the
packet coming from userspace and encounters to be 0 thereby dropping
time sensitive packets. These changes will allow userspace timestamps
packets to be forwarded from the bridge to NIC drivers.

Setting the same bit (mono_delivery_time) to avoid dropping of
userspace tstamp packets in the forwarding path.

Existing functionality of mono_delivery_time remains unaltered here,
instead just extended with userspace tstamp support for bridge
forwarding path.

Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
---
Changes since v2
- Updated the commit subject and message. 
- Took care of few comments from Willem to re-use mono_delivery_time
  with comments and documentations in the header and source file.
- Took care of comment from Andrew on the typo in the comment.
- Existing self-test test cases are executed to make sure existing 
  implementation is not impacted as stated by Paolo.(so_txtime.sh). 
- Internal validation of UDP packets using iperf/so_priority/so_txtime
  with MQPRIO + ETF offload is executed as well.
- Test case is included below

Test 1 :- FQ + ETF (SW path)

[root@ecbldauto-lvarm04-lnx ~]# ./so_txtime.sh
[  280.640551] q->last time is 1707955476143297550
[  283.338947] IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
[  284.078429] IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready

SO_TXTIME ipv4 clock monotonic
payload:a delay:109 expected:0 (us)

SO_TXTIME ipv6 clock monotonic
payload:a delay:140 expected:0 (us)

SO_TXTIME ipv6 clock monotonic
payload:a delay:12739 expected:10000 (us)

SO_TXTIME ipv4 clock monotonic
payload:a delay:10054 expected:10000 (us)
payload:b delay:20043 expected:20000 (us)

SO_TXTIME ipv6 clock monotonic
payload:b delay:20078 expected:20000 (us)
payload:a delay:20177 expected:20000 (us)

SO_TXTIME ipv4 clock tai
send: pkt a at -1707955482913ms dropped: invalid txtime
[  287.070504] now is set to 1707955482913404839
[  287.070509] tx time from SKB is 0
/so_txtime: recv: timeout: Resource temporarily unavailable

SO_TXTIME ipv6 clock tai
send: pkt a at 0ms dropped: invalid txtime
[  287.070510] q->last time is 0
[  287.420590] now is set to 1707955483263491298
[  287.420596] tx time from SKB is 1707955483263454527
/so_txtime: recv: timeout: Resource temporarily unavailable

SO_TXTIME ipv6 clock tai
[  287.420597] q->last time is 0
[  287.700598] now is set to 1707955483543498954
[  287.700604] tx time from SKB is 1707955483553463173
payload:a delay:9655 expected:10000 (us)

SO_TXTIME ipv4 clock tai
[  287.700605] q->last time is 0
[  288.100532] now is set to 1707955483943432391
[  288.100537] tx time from SKB is 1707955483953413016
payload:a delay:9668 expected:10000 (us)[  288.100538] q->last time is 1707955483553463173

[  288.100546] now is set to 1707955483943446975
[  288.100547] tx time from SKB is 1707955483963413016
payload:b delay:20484 expected:20000 (us)

SO_TXTIME ipv6 clock tai
[  288.100547] q->last time is 1707955483553463173
[  288.440582] now is set to 1707955484283482495
[  288.440587] tx time from SKB is 1707955484303452808
payload:b delay:9648 expected:10000 (us)[  288.440588] q->last time is 1707955483963413016

[  288.440598] now is set to 1707955484283499370
payload:a delay:22037 expected:20000 (us)
[  288.440599] tx time from SKB is 1707955484293452808
OK. All tests passed


Test case 2 (MQPRIO + ETF HW offload)

[root@ecbldauto-lvarm04-lnx ~]# tc qdisc add dev eth0 handle 100: parent root mqprio num_tc 4 \
            map 0 2 1 3 3 2 2 2 2 2 2 2 2 2 2 2 \
            queues 1@0 1@1 1@2 1@3\
            hw 0
[root@ecbldauto-lvarm04-lnx ~]#
tc qdisc replace dev eth0 parent 100:4 etf \
            clockid CLOCK_TAI delta 40000  offload skip_sock_check
[   89.145838] qcom-ethqos 23040000.ethernet eth0: enabled ETF for Queue test log 3, number of queues 4, qopt enable 1, tbs queue bit 1
[   89.145846] qcom-ethqos 23040000.ethernet eth0: enabled ETF for Queue 3


[root@ecbldauto-lvarm04-lnx ~]# ./a.out -4 -c tai -S 192.168.1.1 -D 192.168.1.2 a,1,b,2

SO_TXTIME ipv4 clock tai

 glob_tstat = 1707955395256170394
[  199.623650] now is set to 1707955395256215810
[  199.623655] tx time from SKB is 1707955395257170394
[  199.623656] q->last time is 0
[  199.623663] now is set to 1707955395256230029
[  199.623664] tx time from SKB is 1707955395258170394
[  199.623665] q->last time is 0
[  199.624589] qcom-ethqos 23040000.ethernet eth0: emac ethqos tx_xmit : lauching tbs packet at 1707955395 sec and 257170394 nsec
[  199.625573] qcom-ethqos 23040000.ethernet eth0: emac ethqos tx_xmit : lauching tbs packet at 1707955395 sec and 258170394 nsec

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

 include/linux/skbuff.h | 4 ++++
 net/ipv4/ip_output.c   | 7 +++++++
 net/ipv4/raw.c         | 7 +++++++
 net/ipv6/ip6_output.c  | 8 +++++++-
 net/ipv6/raw.c         | 8 +++++++-
 net/packet/af_packet.c | 8 +++++++-
 6 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 2dde34c29203..58586d56b19f 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -820,6 +820,10 @@ typedef unsigned char *sk_buff_data_t;
  *		delivery_time in mono clock base (i.e. EDT).  Otherwise, the
  *		skb->tstamp has the (rcv) timestamp at ingress and
  *		delivery_time at egress.
+ *		This bit is also set for tstamp coming from userspace which
+ *		acts as an information in the bridge forwarding path to avoid
+ *		resetting the tstamp value when user sets the timestamp using
+ *		SO_TXTIME sockopts.
  *	@napi_id: id of the NAPI struct this skb came from
  *	@sender_cpu: (aka @napi_id) source CPU in XPS
  *	@alloc_cpu: CPU which did the skb allocation.
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 5b5a0adb927f..4ae6aea8f8d6 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1455,6 +1455,13 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
 	skb->priority = (cork->tos != -1) ? cork->priority: READ_ONCE(sk->sk_priority);
 	skb->mark = cork->mark;
 	skb->tstamp = cork->transmit_time;
+	/* Timestamp coming from userspace using CMSG is stored as part
+	 * of transmit_time as part of cork. To ensure bridge does not
+	 * drop the tstamp in the forwarding path.We are reusing bit
+	 * mono_delivery_time to avoid reset of tstamp in bridge
+	 * forwarding path.
+	 */
+	skb->mono_delivery_time = !!skb->tstamp;
 	/*
 	 * Steal rt from cork.dst to avoid a pair of atomic_inc/atomic_dec
 	 * on dst refcount
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index aea89326c697..6e67c0203be8 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -353,6 +353,13 @@ static int raw_send_hdrinc(struct sock *sk, struct flowi4 *fl4,
 	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = sockc->mark;
 	skb->tstamp = sockc->transmit_time;
+	/* Timestamp coming from userspace using CMSG is stored as part
+	 * of transmit_time as part of sockcmcookie. To ensure bridge does not
+	 * drop the tstamp in the forwarding path. We are reusing bit
+	 * mono_delivery_time to avoid reset of tstamp in bridge
+	 * forwarding path.
+	 */
+	skb->mono_delivery_time = !!skb->tstamp;
 	skb_dst_set(skb, &rt->dst);
 	*rtp = NULL;
 
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index a722a43dd668..f5b5e13a920f 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1922,7 +1922,13 @@ struct sk_buff *__ip6_make_skb(struct sock *sk,
 	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = cork->base.mark;
 	skb->tstamp = cork->base.transmit_time;
-
+	/* Timestamp coming from userspace using CMSG is stored as part
+	 * of transmit_time as part of cork. To ensure bridge does not
+	 * drop the tstamp in the forwarding path. We are reusing bit
+	 * mono_delivery_time to avoid reset of tstamp in bridge
+	 * forwarding path.
+	 */
+	skb->mono_delivery_time = !!skb->tstamp;
 	ip6_cork_steal_dst(skb, cork);
 	IP6_INC_STATS(net, rt->rt6i_idev, IPSTATS_MIB_OUTREQUESTS);
 	if (proto == IPPROTO_ICMPV6) {
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index 03dbb874c363..d2e2a1ec3de4 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -616,7 +616,13 @@ static int rawv6_send_hdrinc(struct sock *sk, struct msghdr *msg, int length,
 	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = sockc->mark;
 	skb->tstamp = sockc->transmit_time;
-
+	/* Timestamp coming from userspace using CMSG is stored as part
+	 * of transmit_time as part of sockcmcookie. To ensure bridge does not
+	 * drop the tstamp in the forwarding path.We are reusing bit
+	 * mono_delivery_time to avoid reset of tstamp in bridge
+	 * forwarding path.
+	 */
+	skb->mono_delivery_time = !!skb->tstamp;
 	skb_put(skb, length);
 	skb_reset_network_header(skb);
 	iph = ipv6_hdr(skb);
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index c9bbc2686690..949e936b5786 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2057,7 +2057,13 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
 	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = READ_ONCE(sk->sk_mark);
 	skb->tstamp = sockc.transmit_time;
-
+	/* Timestamp coming from userspace using CMSG is stored as part
+	 * of transmit_time as part of sockcmcookie. To ensure bridge does not
+	 * drop the tstamp in the forwarding path. We are reusing bit
+	 * mono_delivery_time to avoid reset of tstamp in bridge
+	 * forwarding path.
+	 */
+	skb->mono_delivery_time = !!skb->tstamp;
 	skb_setup_tx_timestamp(skb, sockc.tsflags);
 
 	if (unlikely(extra_len == 4))
-- 
2.25.1


