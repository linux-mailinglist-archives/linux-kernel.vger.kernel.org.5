Return-Path: <linux-kernel+bounces-92815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 303D4872670
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 468B1B2310F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DAE18AED;
	Tue,  5 Mar 2024 18:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Ny91e9ox"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0667E17BBA;
	Tue,  5 Mar 2024 18:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709662657; cv=none; b=A22wCcv7iPP0/wclqvL+pV9lUQFrVEwQkmlgnFtw+dIEqVWUJDUdXMsNXwVudeQeREPhaua00QiJeNQ7o6QVGIC+6yOk7aF4xurIoiGmizOz2UjZwkuSIHN1yha1STClZHIZbfMatqXb3E9teeOI5R/o4qm3tOcHpkjHX7bwLwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709662657; c=relaxed/simple;
	bh=pKwUTjpsiCUTZE6Y7+RXqePazo0PBfe1Pm4l6OUy8aE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ig6uvTBT0fur7USTcLr1jJC7zrzgl8F43dYCdWJSxwKgkehehw6iCcEHhMnOun2LAHHTj/P7bVhkx/zAIsxzvBXgK8B8Ijaa1+ojoxyyDRawXky7WO8Puz9N1lRxPYeFvDUXHM2tMKpuzXAx5YGZbf2HQgU5nY4Ztxh8lw53swY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Ny91e9ox; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 425Dfvhx010320;
	Tue, 5 Mar 2024 10:17:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=wUo4AMll
	YeNPsaijKY9ERTjDT9BT1xnhIuAOleJqmzA=; b=Ny91e9oxQIOSy93pVxHhOqU+
	EFRDt72CkiwwCOyOim2Nhi2jVwlulDm015+olrd0MY2pLisy4miVmywtOgnjCyTY
	bTXIKM++2nHyk+R8a+22lZ1p/FJuj/gSYJpvgU8AlKqAtpgNO68zywb81smdKhj8
	5dRLxQzKNrA+dOtoa5nqqTYest0oX+FfilNGTIUeDWo/ID29d7FJC//xZ7WZjbYZ
	/p3ca3m+p9pOzmzF5+s67ihJuSEtUr8D5fJ7WiIzQ5MKKhZJptqhpNjf3iTkQuLH
	Cj4LddfrY1xDv+Ke7NX5OCA9huDZHcFLWXnd3oRCC5sGLFYkMj1ucNK75NCw4w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3wp13s230w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 10:17:17 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Tue, 5 Mar 2024 10:17:17 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 5 Mar 2024 10:17:17 -0800
Received: from hyd1425.marvell.com (unknown [10.29.37.83])
	by maili.marvell.com (Postfix) with ESMTP id 4F53D5B693B;
	Tue,  5 Mar 2024 10:17:13 -0800 (PST)
From: Sai Krishna <saikrishnag@marvell.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <hkelam@marvell.com>, <sbhatta@marvell.com>
CC: Sai Krishna <saikrishnag@marvell.com>
Subject: [net-next PATCH] octeontx2-pf: Add TC flower offload support for TCP flags
Date: Tue, 5 Mar 2024 23:46:06 +0530
Message-ID: <20240305181606.244208-1-saikrishnag@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: oEmlo3HWSwhLJgjxdPc3iVx8i_OpghL9
X-Proofpoint-ORIG-GUID: oEmlo3HWSwhLJgjxdPc3iVx8i_OpghL9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_15,2024-03-05_01,2023-05-22_02

This patch adds TC offload support for matching TCP flags
from TCP header.

Example usage:
tc qdisc add dev eth0 ingress

TC rule to drop the TCP SYN packets:
tc filter add dev eth0 ingress protocol ip flower ip_proto tcp tcp_flags
0x02/0x3f skip_sw action drop

Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h      |  1 +
 drivers/net/ethernet/marvell/octeontx2/af/npc.h       |  1 +
 .../net/ethernet/marvell/octeontx2/af/rvu_debugfs.c   |  4 ++++
 .../net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c    |  8 ++++++--
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c  | 11 +++++++++++
 5 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 94217b9981a6..cfe8a8327e1b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1557,6 +1557,7 @@ struct flow_msg {
 	u32 mpls_lse[4];
 	u8 icmp_type;
 	u8 icmp_code;
+	__be16 tcp_flags;
 };
 
 struct npc_install_flow_req {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
index 3e6de9d7dde3..d883157393ea 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
@@ -217,6 +217,7 @@ enum key_fields {
 	NPC_MPLS4_TTL,
 	NPC_TYPE_ICMP,
 	NPC_CODE_ICMP,
+	NPC_TCP_FLAGS,
 	NPC_HEADER_FIELDS_MAX,
 	NPC_CHAN = NPC_HEADER_FIELDS_MAX, /* Valid when Rx */
 	NPC_PF_FUNC, /* Valid when Tx */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index e6d7914ce61c..2500f5ba4f5a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -2870,6 +2870,10 @@ static void rvu_dbg_npc_mcam_show_flows(struct seq_file *s,
 			seq_printf(s, "%d ", ntohs(rule->packet.dport));
 			seq_printf(s, "mask 0x%x\n", ntohs(rule->mask.dport));
 			break;
+		case NPC_TCP_FLAGS:
+			seq_printf(s, "%d ", rule->packet.tcp_flags);
+			seq_printf(s, "mask 0x%x\n", rule->mask.tcp_flags);
+			break;
 		case NPC_IPSEC_SPI:
 			seq_printf(s, "0x%x ", ntohl(rule->packet.spi));
 			seq_printf(s, "mask 0x%x\n", ntohl(rule->mask.spi));
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index c75669c8fde7..c181e7aa9eb6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -53,6 +53,7 @@ static const char * const npc_flow_names[] = {
 	[NPC_MPLS4_TTL]     = "lse depth 4",
 	[NPC_TYPE_ICMP] = "icmp type",
 	[NPC_CODE_ICMP] = "icmp code",
+	[NPC_TCP_FLAGS] = "tcp flags",
 	[NPC_UNKNOWN]	= "unknown",
 };
 
@@ -530,6 +531,7 @@ do {									       \
 	NPC_SCAN_HDR(NPC_DPORT_SCTP, NPC_LID_LD, NPC_LT_LD_SCTP, 2, 2);
 	NPC_SCAN_HDR(NPC_TYPE_ICMP, NPC_LID_LD, NPC_LT_LD_ICMP, 0, 1);
 	NPC_SCAN_HDR(NPC_CODE_ICMP, NPC_LID_LD, NPC_LT_LD_ICMP, 1, 1);
+	NPC_SCAN_HDR(NPC_TCP_FLAGS, NPC_LID_LD, NPC_LT_LD_TCP, 12, 2);
 	NPC_SCAN_HDR(NPC_ETYPE_ETHER, NPC_LID_LA, NPC_LT_LA_ETHER, 12, 2);
 	NPC_SCAN_HDR(NPC_ETYPE_TAG1, NPC_LID_LB, NPC_LT_LB_CTAG, 4, 2);
 	NPC_SCAN_HDR(NPC_ETYPE_TAG2, NPC_LID_LB, NPC_LT_LB_STAG_QINQ, 8, 2);
@@ -574,7 +576,8 @@ static void npc_set_features(struct rvu *rvu, int blkaddr, u8 intf)
 		       BIT_ULL(NPC_DPORT_TCP) | BIT_ULL(NPC_DPORT_UDP) |
 		       BIT_ULL(NPC_SPORT_SCTP) | BIT_ULL(NPC_DPORT_SCTP) |
 		       BIT_ULL(NPC_SPORT_SCTP) | BIT_ULL(NPC_DPORT_SCTP) |
-		       BIT_ULL(NPC_TYPE_ICMP) | BIT_ULL(NPC_CODE_ICMP);
+		       BIT_ULL(NPC_TYPE_ICMP) | BIT_ULL(NPC_CODE_ICMP) |
+		       BIT_ULL(NPC_TCP_FLAGS);
 
 	/* for tcp/udp/sctp corresponding layer type should be in the key */
 	if (*features & proto_flags) {
@@ -982,7 +985,8 @@ do {									      \
 		       mask->icmp_type, 0);
 	NPC_WRITE_FLOW(NPC_CODE_ICMP, icmp_code, pkt->icmp_code, 0,
 		       mask->icmp_code, 0);
-
+	NPC_WRITE_FLOW(NPC_TCP_FLAGS, tcp_flags, ntohs(pkt->tcp_flags), 0,
+		       ntohs(mask->tcp_flags), 0);
 	NPC_WRITE_FLOW(NPC_IPSEC_SPI, spi, ntohl(pkt->spi), 0,
 		       ntohl(mask->spi), 0);
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
index 4fd44b6eecea..87bdb93cb066 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
@@ -638,6 +638,7 @@ static int otx2_tc_prepare_flow(struct otx2_nic *nic, struct otx2_tc_flow *node,
 	      BIT(FLOW_DISSECTOR_KEY_IPSEC) |
 	      BIT_ULL(FLOW_DISSECTOR_KEY_MPLS) |
 	      BIT_ULL(FLOW_DISSECTOR_KEY_ICMP) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_TCP) |
 	      BIT_ULL(FLOW_DISSECTOR_KEY_IP))))  {
 		netdev_info(nic->netdev, "unsupported flow used key 0x%llx",
 			    dissector->used_keys);
@@ -857,6 +858,16 @@ static int otx2_tc_prepare_flow(struct otx2_nic *nic, struct otx2_tc_flow *node,
 		}
 	}
 
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_TCP)) {
+		struct flow_match_tcp match;
+
+		flow_rule_match_tcp(rule, &match);
+
+		flow_spec->tcp_flags = match.key->flags;
+		flow_mask->tcp_flags = match.mask->flags;
+		req->features |= BIT_ULL(NPC_TCP_FLAGS);
+	}
+
 	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_MPLS)) {
 		struct flow_match_mpls match;
 		u8 bit;
-- 
2.25.1


