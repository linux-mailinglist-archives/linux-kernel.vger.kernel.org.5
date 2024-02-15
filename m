Return-Path: <linux-kernel+bounces-67717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2583C856FA3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9127D1F22D71
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4928B1420D4;
	Thu, 15 Feb 2024 21:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ePUdvxez"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C88513DBB3;
	Thu, 15 Feb 2024 21:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708034205; cv=none; b=DYkI2cCteWNpWTtCmZGzhY4Xlg8jUfT0YBYBo+XVXIvzh/utQwOAZ+QRjd1fXFq6riE1KZr/QLBPVnZpQ49Y892/Sfn56R2XqpC3l1V8zUOIk8MvyhcPGa67ZKlB39Oky6zaftVZQTEI+uzJHrz+oeacKAxhHK2DfSkTcMJPOdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708034205; c=relaxed/simple;
	bh=vUMdPNC8PKiy9PBf84Bk9FC6RrQKY4ugoFk77YSvzjc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Om7otcWko3qq+R9bxhKC9MzaIdnZ7vFZseYq/uOQAlKVpDvnc5MBpNtl2KxikaYPt1ff3QF3TSsEYZUidVoY5p/RXnYTNUyrPUO6l8tfiVyHFn+HyNsnooQyFTlkgoftswxXZd7JbcEfq6aWILieBam7+uSIYZ5NblisuPpTtLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ePUdvxez; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41F82077007017;
	Thu, 15 Feb 2024 21:56:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=qcppdkim1; bh=xWMwJ7Jr+Ykzo0cSf2p9
	sC43emu2D39KJXLIjNIcDQI=; b=ePUdvxezXrCcvNVI4s6tGB1YbSgWfOQEagXy
	fzrLGTSdnPxBBW2up8P0R5l6zvY7MVTZp7u0v893UIYXV6y7zAMSb5zaaaPdi0B/
	Sk/EpXXVDR2bUoi/ZnzWR0u8Sj7xsVbdEUp518jr8Hao2GuvBqRR2/yV6Netugfd
	LLw6l/0XnC47TqfHizQdSFY1GpFSwsBI90uopwFTOZRm+wb0qU7eyDqQrqt9XiZN
	KFqR6oIOT6SNpiC9krjDBA0FlajEr4vNBL4nRXCDkPteoYSaedUYN+5zRir9jRCK
	XuoFvBcijsJHJWIDgq/1X9f8N/jqQTG/C5Na9uc7qsC39EtEgQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w92fxkh6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 21:56:34 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA05.qualcomm.com [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 41FLlMBd000874;
	Thu, 15 Feb 2024 21:56:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 3w88r6spyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 21:56:33 +0000
Received: from NALASPPMTA05.qualcomm.com (NALASPPMTA05.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41FLuWXC011241;
	Thu, 15 Feb 2024 21:56:32 GMT
Received: from hu-devc-lv-u20-a-new.qualcomm.com (hu-abchauha-lv.qualcomm.com [10.81.25.35])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 41FLuWkv011240
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 21:56:32 +0000
Received: by hu-devc-lv-u20-a-new.qualcomm.com (Postfix, from userid 214165)
	id 8B599220D9; Thu, 15 Feb 2024 13:56:32 -0800 (PST)
From: Abhishek Chauhan <quic_abchauha@quicinc.com>
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>
Cc: kernel@quicinc.com
Subject: [PATCH net-next v1] net: Add skb user timestamp flag to distinguish between timestamps
Date: Thu, 15 Feb 2024 13:56:32 -0800
Message-Id: <20240215215632.2899370-1-quic_abchauha@quicinc.com>
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
X-Proofpoint-GUID: MzUZzcnz54jRpB0ax3eecmx56iZzLMuS
X-Proofpoint-ORIG-GUID: MzUZzcnz54jRpB0ax3eecmx56iZzLMuS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_20,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 mlxscore=0 bulkscore=0 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402150171

Bridge driver today has no support to forward the userspace timestamp
packets and ends up resetting the timestamp. ETF qdisc checks the
packet coming from userspace and encounters to be 0 thereby dropping
time sensitive packets. These changes will allow userspace timestamps
packets to be forwarded from the bridge to NIC drivers.

Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
---
Note:- I am a little skeptical of using bool inside the skbuff
structure as no one today has used bool so far in the struct.
(Expecting some comments from upstream for sure) 

I am also touching the heart of sk buff so i hope this is reviewed
thoroughly. I have crossed checked multiple times on all the ipv4
/ipv6 paths where userspace timestamp is populated. I tried as much
as possible to cover all the references and made sure i put my changes
in place.  

Bug description:- If the physical network interface is bridged the 
etf packets are dropped since bridge driver before forwarding the packet
is setting the userspace timestamp to 0.

Bridge driver call stack 

[  157.120189] now is set to 1706054553072734733
[  157.120194] tx time from SKB is 0 <== SKB when reaches the etf qdisc is 0 
[  157.120195] q->last time is 0
[  157.120197] CPU: 3 PID: 9206 Comm: a.out Tainted: G        W  OE  X  -------  ---  5.14.0-999.323ES.test.el9.aarch64 #1
[  157.120201] Hardware name: Qualcomm SA8775P Ride (DT)
[  157.120202] Call trace:
[  157.120203]  dump_backtrace+0xb0/0x130
[  157.120212]  show_stack+0x1c/0x30
[  157.120215]  dump_stack_lvl+0x74/0x8c
[  157.120220]  dump_stack+0x14/0x24
[  157.120223]  etf_enqueue_timesortedlist+0x114/0x20c [sch_etf]
[  157.120230]  dev_qdisc_enqueue+0x2c/0x110
[  157.120234]  __dev_xmit_skb+0x114/0x644
[  157.120236]  __dev_queue_xmit+0x31c/0x774
[  157.120238]  br_dev_queue_push_xmit+0xd4/0x120 [bridge]
[  157.120253]  br_forward_finish+0xdc/0xec [bridge]  <== This function is culprit as its making the tstamp as 0
[root@ecbldauto-lvarm04-lnx ~]# [  157.120263]  __br_forward+0xd8/0x210 [bridge]
[  157.120272]  br_forward+0x12c/0x150 [bridge]
[  157.120281]  br_dev_xmit+0x288/0x49c [bridge]
[  157.120290]  dev_hard_start_xmit+0xe4/0x2b4
[  157.120292]  __dev_queue_xmit+0x6ac/0x774
[  157.120294]  neigh_resolve_output+0x128/0x1ec
[  157.120297]  ip_finish_output2+0x184/0x54c
[  157.120300]  __ip_finish_output+0xa4/0x19c
[  157.120302]  ip_finish_output+0x38/0xf0
[  157.120303]  ip_output+0x13c/0x1f4
[  157.120305]  ip_send_skb+0x54/0x10c
[  157.120307]  udp_send_skb+0x128/0x394
[  157.120310]  udp_sendmsg+0x7e8/0xa6c
[  157.120311]  inet_sendmsg+0x48/0x70
[  157.120313]  sock_sendmsg+0x54/0x60
[  157.120315]  ____sys_sendmsg+0x1f8/0x254
[  157.120316]  ___sys_sendmsg+0x84/0xcc
[  157.120318]  __sys_sendmsg+0x60/0xb0
[  157.120319]  __arm64_sys_sendmsg+0x28/0x30
[  157.120320]  invoke_syscall.constprop.0+0x7c/0xd0
[  157.120323]  el0_svc_common.constprop.0+0x140/0x150
[  157.120325]  do_el0_svc+0x38/0xa0
[  157.120327]  el0_svc+0x38/0x1d0
[  157.120329]  el0t_64_sync_handler+0xb4/0x130
[  157.120330]  el0t_64_sync+0x17c/0x180

After my changes:- 
[ 2215.130148] now is set to 1706056610952501031 
[ 2215.130154] tx time from SKB is 1706056610953467393 <== Time is forwarded to etf correctly
[ 2215.130155] q->last time is 1706056591423364609
[ 2215.130158] CPU: 1 PID: 108166 Comm: a.out Tainted: G        W  OE  X  -------  ---  5.14.0-999.323ES.test.el9.aarch64 #1
[ 2215.130162] Hardware name: Qualcomm SA8775P Ride (DT) [ 2215.130163] Call trace:
[ 2215.130164]  dump_backtrace+0xb0/0x130 
[ 2215.130172]  show_stack+0x1c/0x30 [root@ecbldauto-lvarm04-lnx ~]# 
[ 2215.130175]  dump_stack_lvl+0x74/0x8c [ 2215.130181]  dump_stack+0x14/0x24 
[ 2215.130184]  etf_enqueue_timesortedlist+0x114/0x20c [sch_etf] 
[ 2215.130191]  dev_qdisc_enqueue+0x2c/0x110 
[ 2215.130197]  __dev_xmit_skb+0x114/0x644 
[ 2215.130200]  __dev_queue_xmit+0x31c/0x774 
[ 2215.130202]  br_dev_queue_push_xmit+0xd4/0x120 [bridge] 
[ 2215.130217]  br_forward_finish+0xe4/0xf0 [bridge] 
[ 2215.130226]  __br_forward+0xd8/0x20c [bridge] 
[ 2215.130235]  br_forward+0x12c/0x150 [bridge] 
[ 2215.130243]  br_dev_xmit+0x288/0x49c [bridge] 
[ 2215.130252]  dev_hard_start_xmit+0xe4/0x2b4 
[ 2215.130254]  __dev_queue_xmit+0x6ac/0x774 
[ 2215.130257]  neigh_hh_output+0xcc/0x140 
[ 2215.130260]  ip_finish_output2+0x300/0x54c 
[ 2215.130262]  __ip_finish_output+0xa4/0x19c 
[ 2215.130263]  ip_finish_output+0x38/0xf0 
[ 2215.130265]  ip_output+0x13c/0x1f4 
[ 2215.130267]  ip_send_skb+0x54/0x110 
[ 2215.130269]  udp_send_skb+0x128/0x394 
[ 2215.130271]  udp_sendmsg+0x7e8/0xa6c 
[ 2215.130272]  inet_sendmsg+0x48/0x70 
[ 2215.130275]  sock_sendmsg+0x54/0x60 
[ 2215.130277]  ____sys_sendmsg+0x1f8/0x254 
[ 2215.130278]  ___sys_sendmsg+0x84/0xcc 
[ 2215.130279]  __sys_sendmsg+0x60/0xb0 
[ 2215.130281]  __arm64_sys_sendmsg+0x28/0x30 
[ 2215.130282]  invoke_syscall.constprop.0+0x7c/0xd0
[ 2215.130285]  el0_svc_common.constprop.0+0x140/0x150
[ 2215.130287]  do_el0_svc+0x38/0xa0
[ 2215.130289]  el0_svc+0x38/0x1d0
[ 2215.130291]  el0t_64_sync_handler+0xb4/0x130 
[ 2215.130292]  el0t_64_sync+0x17c/0x180


 include/linux/skbuff.h  | 13 +++++++++++++
 include/net/inet_sock.h |  1 +
 include/net/sock.h      |  1 +
 net/core/sock.c         |  1 +
 net/ipv4/ip_output.c    |  3 +++
 net/ipv4/raw.c          |  1 +
 net/ipv6/ip6_output.c   |  2 ++
 net/ipv6/raw.c          |  1 +
 net/packet/af_packet.c  |  3 +++
 9 files changed, 26 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 2dde34c29203..b098b7d30b56 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -744,6 +744,7 @@ typedef unsigned char *sk_buff_data_t;
  *	@tstamp: Time we arrived/left
  *	@skb_mstamp_ns: (aka @tstamp) earliest departure time; start point
  *		for retransmit timer
+ *	@user_delivery_time: states that timestamp was populated from userspace
  *	@rbnode: RB tree node, alternative to next/prev for netem/tcp
  *	@list: queue head
  *	@ll_node: anchor in an llist (eg socket defer_list)
@@ -879,6 +880,8 @@ struct sk_buff {
 		ktime_t		tstamp;
 		u64		skb_mstamp_ns; /* earliest departure time */
 	};
+	/* States that time is from userspace */
+	bool            user_delivery_time;
 	/*
 	 * This is the control buffer. It is free to use for every
 	 * layer. Please put your private variables there. If you
@@ -4208,6 +4211,16 @@ static inline void skb_clear_tstamp(struct sk_buff *skb)
 	if (skb->mono_delivery_time)
 		return;
 
+	/* When userspace timestamp packets are forwarded via bridge
+	 * the br_forward_finish clears the tstamp and the tstamp
+	 * from the userspace is lost. Hence the check for user
+	 * delivery time. With the below check now tc-etf qdisc will
+	 * not end up dropping the packets if the packet is forwarded via
+	 * bridge interface.
+	 */
+	if (skb->user_delivery_time)
+		return;
+
 	skb->tstamp = 0;
 }
 
diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index d94c242eb3ed..e7523545a493 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -175,6 +175,7 @@ struct inet_cork {
 	__u16			gso_size;
 	u64			transmit_time;
 	u32			mark;
+	bool			user_delivery_time;
 };
 
 struct inet_cork_full {
diff --git a/include/net/sock.h b/include/net/sock.h
index a9d99a9c583f..d54af99129a3 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1871,6 +1871,7 @@ struct sockcm_cookie {
 	u64 transmit_time;
 	u32 mark;
 	u32 tsflags;
+	bool user_delivery_time;
 };
 
 static inline void sockcm_init(struct sockcm_cookie *sockc,
diff --git a/net/core/sock.c b/net/core/sock.c
index 88bf810394a5..6cadedce7036 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2837,6 +2837,7 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
 		if (cmsg->cmsg_len != CMSG_LEN(sizeof(u64)))
 			return -EINVAL;
 		sockc->transmit_time = get_unaligned((u64 *)CMSG_DATA(cmsg));
+		sockc->user_delivery_time = true;
 		break;
 	/* SCM_RIGHTS and SCM_CREDENTIALS are semantically in SOL_UNIX. */
 	case SCM_RIGHTS:
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 5b5a0adb927f..61b59e41530e 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1321,6 +1321,7 @@ static int ip_setup_cork(struct sock *sk, struct inet_cork *cork,
 	cork->mark = ipc->sockc.mark;
 	cork->priority = ipc->priority;
 	cork->transmit_time = ipc->sockc.transmit_time;
+	cork->user_delivery_time = ipc->sockc.user_delivery_time;
 	cork->tx_flags = 0;
 	sock_tx_timestamp(sk, ipc->sockc.tsflags, &cork->tx_flags);
 
@@ -1455,6 +1456,8 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
 	skb->priority = (cork->tos != -1) ? cork->priority: READ_ONCE(sk->sk_priority);
 	skb->mark = cork->mark;
 	skb->tstamp = cork->transmit_time;
+	skb->user_delivery_time = cork->user_delivery_time;
+
 	/*
 	 * Steal rt from cork.dst to avoid a pair of atomic_inc/atomic_dec
 	 * on dst refcount
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index aea89326c697..f7af2edcd4d5 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -353,6 +353,7 @@ static int raw_send_hdrinc(struct sock *sk, struct flowi4 *fl4,
 	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = sockc->mark;
 	skb->tstamp = sockc->transmit_time;
+	skb->user_delivery_time = sockc->user_delivery_time;
 	skb_dst_set(skb, &rt->dst);
 	*rtp = NULL;
 
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index a722a43dd668..98aa180cee9e 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1396,6 +1396,7 @@ static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
 
 	cork->base.length = 0;
 	cork->base.transmit_time = ipc6->sockc.transmit_time;
+	cork->base.user_delivery_time = ipc6->sockc.user_delivery_time;
 
 	return 0;
 }
@@ -1922,6 +1923,7 @@ struct sk_buff *__ip6_make_skb(struct sock *sk,
 	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = cork->base.mark;
 	skb->tstamp = cork->base.transmit_time;
+	skb->user_delivery_time = cork->base.user_delivery_time;
 
 	ip6_cork_steal_dst(skb, cork);
 	IP6_INC_STATS(net, rt->rt6i_idev, IPSTATS_MIB_OUTREQUESTS);
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index 03dbb874c363..07f8013df556 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -616,6 +616,7 @@ static int rawv6_send_hdrinc(struct sock *sk, struct msghdr *msg, int length,
 	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = sockc->mark;
 	skb->tstamp = sockc->transmit_time;
+	skb->user_delivery_time = sockc->user_delivery_time;
 
 	skb_put(skb, length);
 	skb_reset_network_header(skb);
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index c9bbc2686690..6f119cb4addf 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2057,6 +2057,7 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
 	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = READ_ONCE(sk->sk_mark);
 	skb->tstamp = sockc.transmit_time;
+	skb->user_delivery_time = sockc.user_delivery_time;
 
 	skb_setup_tx_timestamp(skb, sockc.tsflags);
 
@@ -2586,6 +2587,7 @@ static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
 	skb->priority = READ_ONCE(po->sk.sk_priority);
 	skb->mark = READ_ONCE(po->sk.sk_mark);
 	skb->tstamp = sockc->transmit_time;
+	skb->user_delivery_time = sockc->user_delivery_time;
 	skb_setup_tx_timestamp(skb, sockc->tsflags);
 	skb_zcopy_set_nouarg(skb, ph.raw);
 
@@ -3064,6 +3066,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = sockc.mark;
 	skb->tstamp = sockc.transmit_time;
+	skb->user_delivery_time = sockc.user_delivery_time;
 
 	if (unlikely(extra_len == 4))
 		skb->no_fcs = 1;
-- 
2.25.1


