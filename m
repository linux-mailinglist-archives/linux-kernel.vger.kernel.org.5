Return-Path: <linux-kernel+bounces-36750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D0583A600
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F3F41F2DC09
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AB6182AF;
	Wed, 24 Jan 2024 09:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Rd93sRiC"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D16E199A1;
	Wed, 24 Jan 2024 09:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706090043; cv=none; b=D2zycf3zQSmhmPQ4Pgl2U4YUq/6xpaX5pBmlhoChtHjV3FKz1oUbb463iILET9fVGeYDCfsZBu6ajM5OW1tuDl5fVVgV71lxcCyh5w7Vrn8zw22xm5GtxPWOBBG1OMF8/quAIHzh6CEIeNBsGc703K6/7zPbGFgHjUKSMvL08SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706090043; c=relaxed/simple;
	bh=4Z5kVAD504PXgXHpRZbSYXB89wLReUfjg0EUkGKIWFI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U/tEcj6O50+8mUVgMmWmYvjBYRJre990ZamFhSqiXV8mDzesXSAWOpZzyWu8Zk/l+mNJe1S/bpfE8fIG/6/5aCZinKL6WeK2AD9oT1xcJJnjQiW72r9hhEd/Sqc361CmwT+VvUeQt7bcUn+HFmLJQCEOYr2+NRFl37cZKh2j5KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Rd93sRiC; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40O8DHNZ001531;
	Wed, 24 Jan 2024 01:53:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=AasYkI4r
	rhFAfhG6QpysYCiqXDwTf5ICJYy7lovOYEU=; b=Rd93sRiC0PsNVWv/NsYJOBmF
	oBc59+jaykoj9DZr4e4gaJkUyiyKJ2xxoJMR8GMSwpCq7/cUUxJPrPrGWa5cWHuj
	78zv6szqGk5iUv1g4z++t7ScrpqpaX50yNvZUI5bq5Ma4fwG2sycnfZItRlhL8+O
	X3ItJrpTu9wNDyo0s0LqMfd3/BGub5euG9UfmZPDwfStQPX6agkF09AG/KAFBVJo
	eYVxG+BglHzjunroaYTj5FHlla/ZBRNDZViGq+y2h02+x4WqaaKi7f+pVd9wDhRU
	BC/StNxMsAQbogiNE2y/HkN6RqOuyleVxbcB7K6SFwgTamLudesGBiybVa14AQ==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3vtxun8abh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 01:53:47 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 24 Jan
 2024 01:53:45 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 24 Jan 2024 01:53:45 -0800
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id 1FFE53F706C;
	Wed, 24 Jan 2024 01:53:40 -0800 (PST)
From: Suman Ghosh <sumang@marvell.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <sgoutham@marvell.com>, <sbhatta@marvell.com>,
        <jerinj@marvell.com>, <gakula@marvell.com>, <hkelam@marvell.com>,
        <lcherian@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Suman Ghosh <sumang@marvell.com>
Subject: [net-next PATCH] octeontx2-af: Add filter profiles in hardware to extract packet headers
Date: Wed, 24 Jan 2024 15:23:38 +0530
Message-ID: <20240124095338.1964327-1-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: VMFybODiJKOabnoFfMQR-RQyuD8oXPS0
X-Proofpoint-GUID: VMFybODiJKOabnoFfMQR-RQyuD8oXPS0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_04,2024-01-23_02,2023-05-22_02

This patch adds hardware profile supports for extracting packet headers.
It makes sure that hardware is capabale of extracting ICMP, CPT, ERSPAN
headers.

Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |   1 +
 .../net/ethernet/marvell/octeontx2/af/npc.h   |  15 +-
 .../marvell/octeontx2/af/npc_profile.h        | 617 ++++++++++++++++--
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |   7 +
 4 files changed, 571 insertions(+), 69 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index edeb0f737312..bb8d60e7bab1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1114,6 +1114,7 @@ struct nix_rss_flowkey_cfg {
 #define NIX_FLOW_KEY_TYPE_INNR_UDP      BIT(15)
 #define NIX_FLOW_KEY_TYPE_INNR_SCTP     BIT(16)
 #define NIX_FLOW_KEY_TYPE_INNR_ETH_DMAC BIT(17)
+#define NIX_FLOW_KEY_TYPE_CUSTOM0	BIT(19)
 #define NIX_FLOW_KEY_TYPE_VLAN		BIT(20)
 #define NIX_FLOW_KEY_TYPE_IPV4_PROTO	BIT(21)
 #define NIX_FLOW_KEY_TYPE_AH		BIT(22)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
index b0b4dea548e1..3e6de9d7dde3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
@@ -85,8 +85,7 @@ enum npc_kpu_lc_ltype {
 enum npc_kpu_ld_ltype {
 	NPC_LT_LD_TCP = 1,
 	NPC_LT_LD_UDP,
-	NPC_LT_LD_ICMP,
-	NPC_LT_LD_SCTP,
+	NPC_LT_LD_SCTP = 4,
 	NPC_LT_LD_ICMP6,
 	NPC_LT_LD_CUSTOM0,
 	NPC_LT_LD_CUSTOM1,
@@ -97,6 +96,7 @@ enum npc_kpu_ld_ltype {
 	NPC_LT_LD_NSH,
 	NPC_LT_LD_TU_MPLS_IN_NSH,
 	NPC_LT_LD_TU_MPLS_IN_IP,
+	NPC_LT_LD_ICMP,
 };
 
 enum npc_kpu_le_ltype {
@@ -140,14 +140,14 @@ enum npc_kpu_lg_ltype {
 enum npc_kpu_lh_ltype {
 	NPC_LT_LH_TU_TCP = 1,
 	NPC_LT_LH_TU_UDP,
-	NPC_LT_LH_TU_ICMP,
-	NPC_LT_LH_TU_SCTP,
+	NPC_LT_LH_TU_SCTP = 4,
 	NPC_LT_LH_TU_ICMP6,
+	NPC_LT_LH_CUSTOM0,
+	NPC_LT_LH_CUSTOM1,
 	NPC_LT_LH_TU_IGMP = 8,
 	NPC_LT_LH_TU_ESP,
 	NPC_LT_LH_TU_AH,
-	NPC_LT_LH_CUSTOM0 = 0xE,
-	NPC_LT_LH_CUSTOM1 = 0xF,
+	NPC_LT_LH_TU_ICMP = 0xF,
 };
 
 /* NPC port kind defines how the incoming or outgoing packets
@@ -155,10 +155,11 @@ enum npc_kpu_lh_ltype {
  * Software assigns pkind for each incoming port such as CGX
  * Ethernet interfaces, LBK interfaces, etc.
  */
-#define NPC_UNRESERVED_PKIND_COUNT NPC_RX_CUSTOM_PRE_L2_PKIND
+#define NPC_UNRESERVED_PKIND_COUNT NPC_RX_CPT_HDR_PTP_PKIND
 
 enum npc_pkind_type {
 	NPC_RX_LBK_PKIND = 0ULL,
+	NPC_RX_CPT_HDR_PTP_PKIND = 54ULL,
 	NPC_RX_CUSTOM_PRE_L2_PKIND = 55ULL,
 	NPC_RX_VLAN_EXDSA_PKIND = 56ULL,
 	NPC_RX_CHLEN24B_PKIND = 57ULL,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/npc_profile.h b/drivers/net/ethernet/marvell/octeontx2/af/npc_profile.h
index a820bad3abb2..41de72c8607f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/npc_profile.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/npc_profile.h
@@ -35,6 +35,7 @@
 #define NPC_ETYPE_NSH		0x894f
 #define NPC_ETYPE_DSA		0xdada
 #define NPC_ETYPE_PPPOE		0x8864
+#define NPC_ETYPE_ERSPA		0x88be
 
 #define NPC_PPP_IP		0x0021
 #define NPC_PPP_IP6		0x0057
@@ -59,6 +60,9 @@
 #define NPC_IPNH_MPLS		137
 #define NPC_IPNH_HOSTID		139
 #define NPC_IPNH_SHIM6		140
+#define NPC_IPNH_CUSTOM		253
+
+#define NPC_IP6_ROUTE_TYPE	4
 
 #define NPC_UDP_PORT_PTP_E	319
 #define NPC_UDP_PORT_PTP_G	320
@@ -187,6 +191,7 @@ enum npc_kpu_parser_state {
 	NPC_S_KPU2_EXDSA,
 	NPC_S_KPU2_CPT_CTAG,
 	NPC_S_KPU2_CPT_QINQ,
+	NPC_S_KPU2_MT,
 	NPC_S_KPU3_CTAG,
 	NPC_S_KPU3_STAG,
 	NPC_S_KPU3_QINQ,
@@ -231,6 +236,7 @@ enum npc_kpu_parser_state {
 	NPC_S_KPU8_ICMP6,
 	NPC_S_KPU8_GRE,
 	NPC_S_KPU8_AH,
+	NPC_S_KPU8_CUSTOM,
 	NPC_S_KPU9_TU_MPLS_IN_GRE,
 	NPC_S_KPU9_TU_MPLS_IN_NSH,
 	NPC_S_KPU9_TU_MPLS_IN_IP,
@@ -242,6 +248,7 @@ enum npc_kpu_parser_state {
 	NPC_S_KPU9_GTPC,
 	NPC_S_KPU9_GTPU,
 	NPC_S_KPU9_ESP,
+	NPC_S_KPU9_CUSTOM,
 	NPC_S_KPU10_TU_MPLS_IN_VXLANGPE,
 	NPC_S_KPU10_TU_MPLS_PL,
 	NPC_S_KPU10_TU_MPLS,
@@ -318,10 +325,10 @@ enum npc_kpu_lc_uflag {
 	NPC_F_LC_U_UNK_PROTO = 0x10,
 	NPC_F_LC_U_IP_FRAG = 0x20,
 	NPC_F_LC_U_IP6_FRAG = 0x40,
+	NPC_F_LC_L_6TO4 = 0x80,
 };
 enum npc_kpu_lc_lflag {
 	NPC_F_LC_L_IP_IN_IP = 1,
-	NPC_F_LC_L_6TO4,
 	NPC_F_LC_L_MPLS_IN_IP,
 	NPC_F_LC_L_IP6_TUN_IP6,
 	NPC_F_LC_L_IP6_MPLS_IN_IP,
@@ -334,6 +341,8 @@ enum npc_kpu_lc_lflag {
 	NPC_F_LC_L_EXT_MOBILITY,
 	NPC_F_LC_L_EXT_HOSTID,
 	NPC_F_LC_L_EXT_SHIM6,
+	NPC_F_LC_L_IP6_SRH_SEG_1,
+	NPC_F_LC_L_IP6_SRH_SEG_2,
 };
 
 enum npc_kpu_ld_lflag {
@@ -970,10 +979,10 @@ static struct npc_kpu_profile_action ikpu_action_entries[] = {
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
 		12, 16, 20, 0, 0,
-		NPC_S_KPU1_ETHER, 0, 0,
+		NPC_S_KPU1_CPT_HDR, 48, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
-		0, 0, 0, 0,
+		0, 7, 0, 0,
 
 	},
 	{
@@ -2785,6 +2794,24 @@ static struct npc_kpu_profile_cam kpu2_cam_entries[] = {
 		0x0000,
 		0x0000,
 	},
+	{
+		NPC_S_KPU2_MT, 0xff,
+		NPC_ETYPE_CTAG,
+		0xffff,
+		0x0000,
+		0x0000,
+		0x0000,
+		0x0000,
+	},
+	{
+		NPC_S_KPU2_MT, 0xff,
+		0x0000,
+		0x0000,
+		0x0000,
+		0x0000,
+		0x0000,
+		0x0000,
+	},
 	{
 		NPC_S_NA, 0X00,
 		0x0000,
@@ -4495,6 +4522,24 @@ static struct npc_kpu_profile_cam kpu5_cam_entries[] = {
 		0x0000,
 		0x0000,
 	},
+	{
+		NPC_S_KPU5_IP6, 0xff,
+		NPC_IPNH_ROUT << 8,
+		0xff00,
+		NPC_IP_VER_6,
+		NPC_IP_VER_MASK,
+		(NPC_IP6_ROUTE_TYPE << 8) | 1,
+		0xffff,
+	},
+	{
+		NPC_S_KPU5_IP6, 0xff,
+		NPC_IPNH_ROUT << 8,
+		0xff00,
+		NPC_IP_VER_6,
+		NPC_IP_VER_MASK,
+		(NPC_IP6_ROUTE_TYPE << 8) | 2,
+		0xffff,
+	},
 	{
 		NPC_S_KPU5_IP6, 0xff,
 		NPC_IPNH_ROUT << 8,
@@ -4774,6 +4819,15 @@ static struct npc_kpu_profile_cam kpu5_cam_entries[] = {
 		0x0000,
 		0x0000,
 	},
+	{
+		NPC_S_KPU5_CPT_IP, 0xff,
+		NPC_IPNH_CUSTOM,
+		0x00ff,
+		NPC_IP_VER_4 | NPC_IP_HDR_LEN_5,
+		NPC_IP_VER_MASK | NPC_IP_HDR_LEN_MASK,
+		0x0000,
+		0x0000,
+	},
 	{
 		NPC_S_KPU5_CPT_IP, 0xff,
 		0x0000,
@@ -4882,6 +4936,15 @@ static struct npc_kpu_profile_cam kpu5_cam_entries[] = {
 		0x0000,
 		0x0000,
 	},
+	{
+		NPC_S_KPU5_CPT_IP, 0xff,
+		NPC_IPNH_CUSTOM,
+		0x00ff,
+		NPC_IP_VER_4,
+		NPC_IP_VER_MASK,
+		0x0000,
+		0x0000,
+	},
 	{
 		NPC_S_KPU5_CPT_IP, 0xff,
 		0x0000,
@@ -5062,6 +5125,15 @@ static struct npc_kpu_profile_cam kpu5_cam_entries[] = {
 		0x0000,
 		0x0000,
 	},
+	{
+		NPC_S_KPU5_CPT_IP6, 0xff,
+		NPC_IPNH_CUSTOM << 8,
+		0xff00,
+		NPC_IP_VER_6,
+		NPC_IP_VER_MASK,
+		0x0000,
+		0x0000,
+	},
 	{
 		NPC_S_KPU5_CPT_IP6, 0xff,
 		0x0000,
@@ -5206,6 +5278,15 @@ static struct npc_kpu_profile_cam kpu6_cam_entries[] = {
 		0x0000,
 		0x0000,
 	},
+	{
+		NPC_S_KPU6_IP6_FRAG, 0xff,
+		NPC_IPNH_CUSTOM << 8,
+		0xff00,
+		0x0000,
+		NPC_IP6_FRAG_FRAGOFF,
+		0x0000,
+		0x0000,
+	},
 	{
 		NPC_S_KPU6_IP6_FRAG, 0xff,
 		0x0000,
@@ -5323,6 +5404,15 @@ static struct npc_kpu_profile_cam kpu6_cam_entries[] = {
 		0x0000,
 		0x0000,
 	},
+	{
+		NPC_S_KPU6_IP6_HOP_DEST, 0xff,
+		NPC_IPNH_CUSTOM << 8,
+		0xff00,
+		0x0000,
+		0x0000,
+		0x0000,
+		0x0000,
+	},
 	{
 		NPC_S_KPU6_IP6_HOP_DEST, 0xff,
 		0x0000,
@@ -5431,6 +5521,15 @@ static struct npc_kpu_profile_cam kpu6_cam_entries[] = {
 		0x0000,
 		0x0000,
 	},
+	{
+		NPC_S_KPU6_IP6_ROUT, 0xff,
+		NPC_IPNH_CUSTOM << 8,
+		0xff00,
+		0x0000,
+		0x0000,
+		0x0000,
+		0x0000,
+	},
 	{
 		NPC_S_KPU6_IP6_ROUT, 0xff,
 		0x0000,
@@ -5530,6 +5629,15 @@ static struct npc_kpu_profile_cam kpu6_cam_entries[] = {
 		0x0000,
 		0x0000,
 	},
+	{
+		NPC_S_KPU6_IP6_CPT_FRAG, 0xff,
+		NPC_IPNH_CUSTOM << 8,
+		0xff00,
+		0x0000,
+		0x0000,
+		0x0000,
+		0x0000,
+	},
 	{
 		NPC_S_KPU6_IP6_CPT_FRAG, 0xff,
 		0x0000,
@@ -5647,6 +5755,15 @@ static struct npc_kpu_profile_cam kpu6_cam_entries[] = {
 		0x0000,
 		0x0000,
 	},
+	{
+		NPC_S_KPU6_IP6_CPT_HOP_DEST, 0xff,
+		NPC_IPNH_CUSTOM << 8,
+		0xff00,
+		0x0000,
+		0x0000,
+		0x0000,
+		0x0000,
+	},
 	{
 		NPC_S_KPU6_IP6_CPT_HOP_DEST, 0xff,
 		0x0000,
@@ -5755,6 +5872,15 @@ static struct npc_kpu_profile_cam kpu6_cam_entries[] = {
 		0x0000,
 		0x0000,
 	},
+	{
+		NPC_S_KPU6_IP6_CPT_ROUT, 0xff,
+		NPC_IPNH_CUSTOM << 8,
+		0xff00,
+		0x0000,
+		0x0000,
+		0x0000,
+		0x0000,
+	},
 	{
 		NPC_S_KPU6_IP6_CPT_ROUT, 0xff,
 		0x0000,
@@ -5881,6 +6007,15 @@ static struct npc_kpu_profile_cam kpu7_cam_entries[] = {
 		0x0000,
 		0x0000,
 	},
+	{
+		NPC_S_KPU7_IP6_ROUT, 0xff,
+		NPC_IPNH_CUSTOM << 8,
+		0xff00,
+		0x0000,
+		0x0000,
+		0x0000,
+		0x0000,
+	},
 	{
 		NPC_S_KPU7_IP6_ROUT, 0xff,
 		0x0000,
@@ -5980,6 +6115,15 @@ static struct npc_kpu_profile_cam kpu7_cam_entries[] = {
 		0x0000,
 		0x0000,
 	},
+	{
+		NPC_S_KPU7_IP6_FRAG, 0xff,
+		NPC_IPNH_CUSTOM << 8,
+		0xff00,
+		0x0000,
+		NPC_IP6_FRAG_FRAGOFF,
+		0x0000,
+		0x0000,
+	},
 	{
 		NPC_S_KPU7_IP6_FRAG, 0xff,
 		0x0000,
@@ -6079,6 +6223,15 @@ static struct npc_kpu_profile_cam kpu7_cam_entries[] = {
 		0x0000,
 		0x0000,
 	},
+	{
+		NPC_S_KPU7_CPT_IP6_FRAG, 0xff,
+		NPC_IPNH_CUSTOM << 8,
+		0xff00,
+		0x0000,
+		0x0000,
+		0x0000,
+		0x0000,
+	},
 	{
 		NPC_S_KPU7_CPT_IP6_FRAG, 0xff,
 		0x0000,
@@ -6304,6 +6457,15 @@ static struct npc_kpu_profile_cam kpu8_cam_entries[] = {
 		0x0000,
 		0x0000,
 	},
+	{
+		NPC_S_KPU8_UDP, 0xff,
+		NPC_UDP_PORT_ESP,
+		0xffff,
+		0x0000,
+		0x0000,
+		0x0009,
+		0xffff,
+	},
 	{
 		NPC_S_KPU8_UDP, 0xff,
 		NPC_UDP_PORT_ESP,
@@ -6754,6 +6916,78 @@ static struct npc_kpu_profile_cam kpu8_cam_entries[] = {
 		0x0000,
 		0x0000,
 	},
+	{
+		NPC_S_KPU8_GRE, 0xff,
+		NPC_ETYPE_ERSPA,
+		0xffff,
+		0x0000,
+		0xffff,
+		0x0000,
+		0x0000,
+	},
+	{
+		NPC_S_KPU8_GRE, 0xff,
+		NPC_ETYPE_ERSPA,
+		0xffff,
+		NPC_GRE_F_CSUM,
+		0xffff,
+		0x0000,
+		0x0000,
+	},
+	{
+		NPC_S_KPU8_GRE, 0xff,
+		NPC_ETYPE_ERSPA,
+		0xffff,
+		NPC_GRE_F_KEY,
+		0xffff,
+		0x0000,
+		0x0000,
+	},
+	{
+		NPC_S_KPU8_GRE, 0xff,
+		NPC_ETYPE_ERSPA,
+		0xffff,
+		NPC_GRE_F_SEQ,
+		0xffff,
+		0x0000,
+		0x0000,
+	},
+	{
+		NPC_S_KPU8_GRE, 0xff,
+		NPC_ETYPE_ERSPA,
+		0xffff,
+		NPC_GRE_F_CSUM | NPC_GRE_F_KEY,
+		0xffff,
+		0x0000,
+		0x0000,
+	},
+	{
+		NPC_S_KPU8_GRE, 0xff,
+		NPC_ETYPE_ERSPA,
+		0xffff,
+		NPC_GRE_F_CSUM | NPC_GRE_F_SEQ,
+		0xffff,
+		0x0000,
+		0x0000,
+	},
+	{
+		NPC_S_KPU8_GRE, 0xff,
+		NPC_ETYPE_ERSPA,
+		0xffff,
+		NPC_GRE_F_KEY | NPC_GRE_F_SEQ,
+		0xffff,
+		0x0000,
+		0x0000,
+	},
+	{
+		NPC_S_KPU8_GRE, 0xff,
+		NPC_ETYPE_ERSPA,
+		0xffff,
+		NPC_GRE_F_CSUM | NPC_GRE_F_KEY | NPC_GRE_F_SEQ,
+		0xffff,
+		0x0000,
+		0x0000,
+	},
 	{
 		NPC_S_KPU8_GRE, 0xff,
 		0x0000,
@@ -6835,6 +7069,15 @@ static struct npc_kpu_profile_cam kpu8_cam_entries[] = {
 		0x0000,
 		0x0000,
 	},
+	{
+		NPC_S_KPU8_CUSTOM, 0xff,
+		0x0000,
+		0x0000,
+		0x0000,
+		0x0000,
+		0x0000,
+		0x0000,
+	},
 	{
 		NPC_S_NA, 0X00,
 		0x0000,
@@ -7303,6 +7546,24 @@ static struct npc_kpu_profile_cam kpu9_cam_entries[] = {
 		0x0000,
 		0x0000,
 	},
+	{
+		NPC_S_KPU9_CUSTOM, 0xff,
+		0x4000,
+		0xf000,
+		0x0000,
+		0x0000,
+		0x0000,
+		0x0000,
+	},
+	{
+		NPC_S_KPU9_CUSTOM, 0xff,
+		0x6000,
+		0xf000,
+		0x0000,
+		0x0000,
+		0x0000,
+		0x0000,
+	},
 	{
 		NPC_S_NA, 0X00,
 		0x0000,
@@ -8384,7 +8645,7 @@ static struct npc_kpu_profile_action kpu1_action_entries[] = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		6, 0, 0, 3, 0,
+		6, 0, 42, 3, 0,
 		NPC_S_KPU5_IP6, 14, 1,
 		NPC_LID_LA, NPC_LT_LA_ETHER,
 		0,
@@ -8536,7 +8797,7 @@ static struct npc_kpu_profile_action kpu1_action_entries[] = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		6, 0, 0, 3, 0,
+		6, 0, 42, 3, 0,
 		NPC_S_KPU5_IP6, 22, 1,
 		NPC_LID_LA, NPC_LT_LA_IH_NIX_ETHER,
 		NPC_F_LA_U_HAS_IH_NIX,
@@ -8693,7 +8954,7 @@ static struct npc_kpu_profile_action kpu1_action_entries[] = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		6, 0, 0, 3, 0,
+		6, 0, 42, 3, 0,
 		NPC_S_KPU5_IP6, 30, 1,
 		NPC_LID_LA, NPC_LT_LA_HIGIG2_ETHER,
 		NPC_F_LA_U_HAS_HIGIG2,
@@ -8818,7 +9079,7 @@ static struct npc_kpu_profile_action kpu1_action_entries[] = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		6, 0, 0, 3, 0,
+		6, 0, 42, 3, 0,
 		NPC_S_KPU5_IP6, 38, 1,
 		NPC_LID_LA, NPC_LT_LA_IH_NIX_HIGIG2_ETHER,
 		NPC_F_LA_U_HAS_IH_NIX | NPC_F_LA_U_HAS_HIGIG2,
@@ -8947,7 +9208,7 @@ static struct npc_kpu_profile_action kpu1_action_entries[] = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		6, 0, 0, 3, 0,
+		6, 0, 42, 3, 0,
 		NPC_S_KPU5_IP6, 14, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -9124,7 +9385,7 @@ static struct npc_kpu_profile_action kpu2_action_entries[] = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		6, 0, 0, 2, 0,
+		6, 0, 42, 2, 0,
 		NPC_S_KPU5_IP6, 6, 1,
 		NPC_LID_LB, NPC_LT_LB_CTAG,
 		0,
@@ -9204,7 +9465,7 @@ static struct npc_kpu_profile_action kpu2_action_entries[] = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		6, 0, 0, 2, 0,
+		6, 0, 42, 2, 0,
 		NPC_S_KPU5_IP6, 14, 1,
 		NPC_LID_LB, NPC_LT_LB_PPPOE,
 		0,
@@ -9213,7 +9474,7 @@ static struct npc_kpu_profile_action kpu2_action_entries[] = {
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
 		0, 0, 0, 0, 1,
-		NPC_S_NA, 0, 1,
+		NPC_S_NA, 6, 1,
 		NPC_LID_LB, NPC_LT_LB_CTAG,
 		NPC_F_LB_U_UNK_ETYPE,
 		0, 0, 0, 0,
@@ -9228,7 +9489,7 @@ static struct npc_kpu_profile_action kpu2_action_entries[] = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		6, 0, 0, 2, 0,
+		6, 0, 42, 2, 0,
 		NPC_S_KPU5_IP6, 10, 1,
 		NPC_LID_LB, NPC_LT_LB_STAG_QINQ,
 		NPC_F_LB_U_MORE_TAG | NPC_F_LB_L_WITH_CTAG,
@@ -9324,7 +9585,7 @@ static struct npc_kpu_profile_action kpu2_action_entries[] = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		6, 0, 0, 2, 0,
+		6, 0, 42, 2, 0,
 		NPC_S_KPU5_IP6, 24, 1,
 		NPC_LID_LB, NPC_LT_LB_BTAG,
 		NPC_F_LB_U_MORE_TAG | NPC_F_LB_L_WITH_ITAG,
@@ -9428,7 +9689,7 @@ static struct npc_kpu_profile_action kpu2_action_entries[] = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		6, 0, 0, 2, 0,
+		6, 0, 42, 2, 0,
 		NPC_S_KPU5_IP6, 10, 1,
 		NPC_LID_LB, NPC_LT_LB_STAG_QINQ,
 		NPC_F_LB_U_MORE_TAG | NPC_F_LB_L_WITH_CTAG,
@@ -9532,7 +9793,7 @@ static struct npc_kpu_profile_action kpu2_action_entries[] = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		6, 0, 0, 2, 0,
+		6, 0, 42, 2, 0,
 		NPC_S_KPU5_IP6, 10, 1,
 		NPC_LID_LB, NPC_LT_LB_ETAG,
 		0,
@@ -9628,7 +9889,7 @@ static struct npc_kpu_profile_action kpu2_action_entries[] = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		6, 0, 0, 2, 0,
+		6, 0, 42, 2, 0,
 		NPC_S_KPU5_IP6, 28, 1,
 		NPC_LID_LB, NPC_LT_LB_ETAG,
 		NPC_F_LB_U_MORE_TAG | NPC_F_LB_L_WITH_ITAG,
@@ -9684,7 +9945,7 @@ static struct npc_kpu_profile_action kpu2_action_entries[] = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		6, 0, 0, 2, 0,
+		6, 0, 42, 2, 0,
 		NPC_S_KPU5_IP6, 10, 1,
 		NPC_LID_LB, NPC_LT_LB_STAG_QINQ,
 		0,
@@ -9757,7 +10018,7 @@ static struct npc_kpu_profile_action kpu2_action_entries[] = {
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
 		0, 0, 0, 0, 1,
-		NPC_S_NA, 0, 1,
+		NPC_S_NA, 8, 1,
 		NPC_LID_LB, NPC_LT_LB_STAG_QINQ,
 		NPC_F_LB_U_UNK_ETYPE,
 		0, 0, 0, 0,
@@ -9772,7 +10033,7 @@ static struct npc_kpu_profile_action kpu2_action_entries[] = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		6, 0, 0, 2, 0,
+		6, 0, 42, 2, 0,
 		NPC_S_KPU5_IP6, 18, 1,
 		NPC_LID_LB, NPC_LT_LB_EDSA,
 		NPC_F_LB_L_EDSA,
@@ -9836,7 +10097,7 @@ static struct npc_kpu_profile_action kpu2_action_entries[] = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		6, 0, 0, 2, 0,
+		6, 0, 42, 2, 0,
 		NPC_S_KPU5_IP6, 10, 1,
 		NPC_LID_LB, NPC_LT_LB_EXDSA,
 		NPC_F_LB_L_EXDSA,
@@ -9922,6 +10183,22 @@ static struct npc_kpu_profile_action kpu2_action_entries[] = {
 		NPC_F_LB_U_MORE_TAG | NPC_F_LB_L_WITH_CTAG,
 		0, 0, 0, 0,
 	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		4, 0, 0, 0, 0,
+		NPC_S_KPU3_CTAG, 0, 1,
+		NPC_LID_LB, NPC_LT_LB_CTAG,
+		0,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		0, 0, 0, 0, 0,
+		NPC_S_KPU3_CTAG_C, 0, 0,
+		NPC_LID_LB, NPC_LT_NA,
+		0,
+		0, 0, 0, 0,
+	},
 	{
 		NPC_ERRLEV_LB, NPC_EC_L2_K3,
 		0, 0, 0, 0, 1,
@@ -9949,7 +10226,7 @@ static struct npc_kpu_profile_action kpu3_action_entries[] = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		6, 0, 0, 1, 0,
+		6, 0, 42, 1, 0,
 		NPC_S_KPU5_IP6, 6, 0,
 		NPC_LID_LB, NPC_LT_NA,
 		0,
@@ -10029,7 +10306,7 @@ static struct npc_kpu_profile_action kpu3_action_entries[] = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		6, 0, 0, 1, 0,
+		6, 0, 42, 1, 0,
 		NPC_S_KPU5_IP6, 8, 0,
 		NPC_LID_LB, NPC_LT_NA,
 		0,
@@ -10101,7 +10378,7 @@ static struct npc_kpu_profile_action kpu3_action_entries[] = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		6, 0, 0, 1, 0,
+		6, 0, 42, 1, 0,
 		NPC_S_KPU5_IP6, 4, 0,
 		NPC_LID_LB, NPC_LT_NA,
 		0,
@@ -10165,7 +10442,7 @@ static struct npc_kpu_profile_action kpu3_action_entries[] = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		6, 0, 0, 1, 0,
+		6, 0, 42, 1, 0,
 		NPC_S_KPU5_IP6, 8, 0,
 		NPC_LID_LB, NPC_LT_NA,
 		0,
@@ -10237,7 +10514,7 @@ static struct npc_kpu_profile_action kpu3_action_entries[] = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		6, 0, 0, 1, 0,
+		6, 0, 42, 1, 0,
 		NPC_S_KPU5_IP6, 4, 0,
 		NPC_LID_LB, NPC_LT_NA,
 		0,
@@ -10310,80 +10587,80 @@ static struct npc_kpu_profile_action kpu3_action_entries[] = {
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
 		8, 0, 6, 1, 0,
-		NPC_S_KPU5_IP, 4, 1,
-		NPC_LID_LB, NPC_LT_LB_CTAG,
+		NPC_S_KPU5_IP, 2, 0,
+		NPC_LID_LB, NPC_LT_NA,
 		0,
 		0, 0, 0, 0,
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		6, 0, 0, 1, 0,
-		NPC_S_KPU5_IP6, 4, 1,
-		NPC_LID_LB, NPC_LT_LB_CTAG,
+		6, 0, 42, 1, 0,
+		NPC_S_KPU5_IP6, 2, 0,
+		NPC_LID_LB, NPC_LT_NA,
 		0,
 		0, 0, 0, 0,
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
 		0, 0, 0, 1, 0,
-		NPC_S_KPU5_ARP, 4, 1,
-		NPC_LID_LB, NPC_LT_LB_CTAG,
+		NPC_S_KPU5_ARP, 2, 0,
+		NPC_LID_LB, NPC_LT_NA,
 		0,
 		0, 0, 0, 0,
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
 		0, 0, 0, 1, 0,
-		NPC_S_KPU5_RARP, 4, 1,
-		NPC_LID_LB, NPC_LT_LB_CTAG,
+		NPC_S_KPU5_RARP, 2, 0,
+		NPC_LID_LB, NPC_LT_NA,
 		0,
 		0, 0, 0, 0,
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
 		0, 0, 0, 1, 0,
-		NPC_S_KPU5_PTP, 4, 1,
-		NPC_LID_LB, NPC_LT_LB_CTAG,
+		NPC_S_KPU5_PTP, 2, 0,
+		NPC_LID_LB, NPC_LT_NA,
 		0,
 		0, 0, 0, 0,
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
 		0, 0, 0, 1, 0,
-		NPC_S_KPU5_FCOE, 4, 1,
-		NPC_LID_LB, NPC_LT_LB_CTAG,
+		NPC_S_KPU5_FCOE, 2, 0,
+		NPC_LID_LB, NPC_LT_NA,
 		0,
 		0, 0, 0, 0,
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
 		2, 6, 10, 0, 0,
-		NPC_S_KPU4_MPLS, 4, 1,
-		NPC_LID_LB, NPC_LT_LB_CTAG,
+		NPC_S_KPU4_MPLS, 2, 0,
+		NPC_LID_LB, NPC_LT_NA,
 		0,
 		0, 0, 0, 0,
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
 		2, 6, 10, 0, 0,
-		NPC_S_KPU4_MPLS, 4, 1,
-		NPC_LID_LB, NPC_LT_LB_CTAG,
+		NPC_S_KPU4_MPLS, 2, 0,
+		NPC_LID_LB, NPC_LT_NA,
 		0,
 		0, 0, 0, 0,
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
 		2, 0, 0, 0, 0,
-		NPC_S_KPU4_NSH, 4, 1,
-		NPC_LID_LB, NPC_LT_LB_CTAG,
+		NPC_S_KPU4_NSH, 2, 0,
+		NPC_LID_LB, NPC_LT_NA,
 		0,
 		0, 0, 0, 0,
 	},
 	{
 		NPC_ERRLEV_LB, NPC_EC_L2_K3_ETYPE_UNK,
 		0, 0, 0, 0, 1,
-		NPC_S_NA, 0, 1,
-		NPC_LID_LB, NPC_LT_LB_CTAG,
+		NPC_S_NA, 0, 0,
+		NPC_LID_LB, NPC_LT_NA,
 		0,
 		0, 0, 0, 0,
 	},
@@ -10397,7 +10674,7 @@ static struct npc_kpu_profile_action kpu3_action_entries[] = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		6, 0, 0, 1, 0,
+		6, 0, 42, 1, 0,
 		NPC_S_KPU5_IP6, 8, 1,
 		NPC_LID_LB, NPC_LT_LB_STAG_QINQ,
 		0,
@@ -10469,7 +10746,7 @@ static struct npc_kpu_profile_action kpu3_action_entries[] = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		6, 0, 0, 1, 0,
+		6, 0, 42, 1, 0,
 		NPC_S_KPU5_IP6, 4, 1,
 		NPC_LID_LB, NPC_LT_LB_STAG_QINQ,
 		0,
@@ -10533,7 +10810,7 @@ static struct npc_kpu_profile_action kpu3_action_entries[] = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		6, 0, 0, 1, 0,
+		6, 0, 42, 1, 0,
 		NPC_S_KPU5_IP6, 8, 1,
 		NPC_LID_LB, NPC_LT_LB_STAG_QINQ,
 		0,
@@ -10605,7 +10882,7 @@ static struct npc_kpu_profile_action kpu3_action_entries[] = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		6, 0, 0, 1, 0,
+		6, 0, 42, 1, 0,
 		NPC_S_KPU5_IP6, 4, 1,
 		NPC_LID_LB, NPC_LT_LB_STAG_QINQ,
 		0,
@@ -10685,7 +10962,7 @@ static struct npc_kpu_profile_action kpu3_action_entries[] = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		6, 0, 0, 1, 0,
+		6, 0, 42, 1, 0,
 		NPC_S_KPU5_IP6, 10, 1,
 		NPC_LID_LB, NPC_LT_LB_DSA,
 		NPC_F_LB_L_DSA,
@@ -10733,7 +11010,7 @@ static struct npc_kpu_profile_action kpu3_action_entries[] = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		6, 0, 0, 1, 0,
+		6, 0, 42, 1, 0,
 		NPC_S_KPU5_IP6, 14, 1,
 		NPC_LID_LB, NPC_LT_LB_DSA_VLAN,
 		NPC_F_LB_L_DSA_VLAN,
@@ -10894,7 +11171,7 @@ static struct npc_kpu_profile_action kpu4_action_entries[] = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		6, 0, 0, 0, 0,
+		6, 0, 42, 0, 0,
 		NPC_S_KPU5_IP6, 6, 1,
 		NPC_LID_LB, NPC_LT_LB_FDSA,
 		NPC_F_LB_L_FDSA,
@@ -10942,7 +11219,7 @@ static struct npc_kpu_profile_action kpu4_action_entries[] = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		6, 0, 0, 0, 0,
+		6, 0, 42, 0, 0,
 		NPC_S_KPU5_IP6, 10, 1,
 		NPC_LID_LB, NPC_LT_LB_FDSA,
 		NPC_F_LB_L_FDSA,
@@ -10990,7 +11267,7 @@ static struct npc_kpu_profile_action kpu4_action_entries[] = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		6, 0, 0, 0, 0,
+		6, 0, 42, 0, 0,
 		NPC_S_KPU5_IP6, 14, 1,
 		NPC_LID_LB, NPC_LT_LB_PPPOE,
 		0,
@@ -11014,7 +11291,7 @@ static struct npc_kpu_profile_action kpu4_action_entries[] = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		6, 0, 0, 0, 0,
+		6, 0, 42, 0, 0,
 		NPC_S_KPU5_IP6, 2, 0,
 		NPC_LID_LC, NPC_LT_NA,
 		0,
@@ -11063,15 +11340,15 @@ static struct npc_kpu_profile_action kpu4_action_entries[] = {
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
 		8, 0, 6, 0, 0,
-		NPC_S_KPU5_IP, 10, 0,
+		NPC_S_KPU5_IP, 10, 1,
 		NPC_LID_LB, NPC_LT_LB_PPPOE,
 		0,
 		0, 0, 0, 0,
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		6, 0, 0, 0, 0,
-		NPC_S_KPU5_IP6, 10, 0,
+		6, 0, 42, 0, 0,
+		NPC_S_KPU5_IP6, 10, 1,
 		NPC_LID_LB, NPC_LT_LB_PPPOE,
 		0,
 		0, 0, 0, 0,
@@ -11119,7 +11396,7 @@ static struct npc_kpu_profile_action kpu5_action_entries[] = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		2, 0, 0, 2, 0,
+		2, 0, 4, 2, 0,
 		NPC_S_KPU8_UDP, 20, 1,
 		NPC_LID_LC, NPC_LT_LC_IP,
 		0,
@@ -11223,7 +11500,7 @@ static struct npc_kpu_profile_action kpu5_action_entries[] = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		2, 8, 10, 2, 0,
+		2, 8, 4, 2, 0,
 		NPC_S_KPU8_UDP, 0, 1,
 		NPC_LID_LC, NPC_LT_LC_IP_OPT,
 		0,
@@ -11445,6 +11722,22 @@ static struct npc_kpu_profile_action kpu5_action_entries[] = {
 		NPC_F_LC_L_EXT_DEST,
 		0, 0, 0, 0,
 	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		0, 0, 0, 0, 0,
+		NPC_S_KPU6_IP6_ROUT, 40, 1,
+		NPC_LID_LC, NPC_LT_LC_IP6_EXT,
+		NPC_F_LC_L_IP6_SRH_SEG_1,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		0, 0, 0, 0, 0,
+		NPC_S_KPU6_IP6_ROUT, 40, 1,
+		NPC_LID_LC, NPC_LT_LC_IP6_EXT,
+		NPC_F_LC_L_IP6_SRH_SEG_2,
+		0, 0, 0, 0,
+	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
 		0, 0, 0, 0, 0,
@@ -11693,6 +11986,14 @@ static struct npc_kpu_profile_action kpu5_action_entries[] = {
 		NPC_F_LC_L_MPLS_IN_IP,
 		0, 0, 0, 0,
 	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		0, 0, 0, 2, 0,
+		NPC_S_KPU8_CUSTOM, 20, 1,
+		NPC_LID_LC, NPC_LT_LC_IP,
+		0,
+		0, 0, 0, 0,
+	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
 		0, 0, 0, 0, 1,
@@ -11789,6 +12090,14 @@ static struct npc_kpu_profile_action kpu5_action_entries[] = {
 		NPC_F_LC_L_MPLS_IN_IP,
 		0, 0xf, 0, 2,
 	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		0, 0, 0, 2, 0,
+		NPC_S_KPU8_CUSTOM, 0, 1,
+		NPC_LID_LC, NPC_LT_LC_IP_OPT,
+		0,
+		0, 0xf, 0, 2,
+	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
 		0, 0, 0, 0, 1,
@@ -11949,6 +12258,14 @@ static struct npc_kpu_profile_action kpu5_action_entries[] = {
 		NPC_F_LC_L_EXT_SHIM6,
 		0, 0, 0, 0,
 	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		0, 0, 0, 2, 0,
+		NPC_S_KPU8_CUSTOM, 40, 1,
+		NPC_LID_LC, NPC_LT_LC_IP6,
+		0,
+		0, 0, 0, 0,
+	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
 		0, 0, 0, 0, 1,
@@ -12078,6 +12395,14 @@ static struct npc_kpu_profile_action kpu6_action_entries[] = {
 		0,
 		0, 0, 0, 0,
 	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		0, 0, 0, 1, 0,
+		NPC_S_KPU8_CUSTOM, 8, 0,
+		NPC_LID_LC, NPC_LT_NA,
+		0,
+		0, 0, 0, 0,
+	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
 		0, 0, 0, 0, 1,
@@ -12182,6 +12507,14 @@ static struct npc_kpu_profile_action kpu6_action_entries[] = {
 		0,
 		1, 0xff, 0, 3,
 	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		0, 0, 0, 1, 0,
+		NPC_S_KPU8_CUSTOM, 8, 0,
+		NPC_LID_LC, NPC_LT_NA,
+		0,
+		1, 0xff, 0, 3,
+	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
 		0, 0, 0, 0, 1,
@@ -12278,6 +12611,14 @@ static struct npc_kpu_profile_action kpu6_action_entries[] = {
 		0,
 		1, 0xff, 0, 3,
 	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		0, 0, 0, 1, 0,
+		NPC_S_KPU8_CUSTOM, 8, 0,
+		NPC_LID_LC, NPC_LT_NA,
+		0,
+		1, 0xff, 0, 3,
+	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
 		0, 0, 0, 0, 1,
@@ -12366,6 +12707,14 @@ static struct npc_kpu_profile_action kpu6_action_entries[] = {
 		0,
 		0, 0, 0, 0,
 	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		0, 0, 0, 1, 0,
+		NPC_S_KPU8_CUSTOM, 8, 0,
+		NPC_LID_LC, NPC_LT_NA,
+		0,
+		0, 0, 0, 0,
+	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
 		0, 0, 0, 0, 1,
@@ -12470,6 +12819,14 @@ static struct npc_kpu_profile_action kpu6_action_entries[] = {
 		0,
 		1, 0xff, 0, 3,
 	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		0, 0, 0, 1, 0,
+		NPC_S_KPU8_CUSTOM, 8, 0,
+		NPC_LID_LC, NPC_LT_NA,
+		0,
+		1, 0xff, 0, 3,
+	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
 		0, 0, 0, 0, 1,
@@ -12566,6 +12923,14 @@ static struct npc_kpu_profile_action kpu6_action_entries[] = {
 		0,
 		1, 0xff, 0, 3,
 	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		0, 0, 0, 1, 0,
+		NPC_S_KPU8_CUSTOM, 8, 0,
+		NPC_LID_LC, NPC_LT_NA,
+		0,
+		1, 0xff, 0, 3,
+	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
 		0, 0, 0, 0, 1,
@@ -12679,6 +13044,14 @@ static struct npc_kpu_profile_action kpu7_action_entries[] = {
 		0,
 		1, 0xff, 0, 3,
 	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		0, 0, 0, 0, 0,
+		NPC_S_KPU8_CUSTOM, 8, 0,
+		NPC_LID_LC, NPC_LT_NA,
+		0,
+		1, 0xff, 0, 3,
+	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
 		0, 0, 0, 0, 1,
@@ -12767,6 +13140,14 @@ static struct npc_kpu_profile_action kpu7_action_entries[] = {
 		0,
 		0, 0, 0, 0,
 	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		0, 0, 0, 0, 0,
+		NPC_S_KPU8_CUSTOM, 8, 0,
+		NPC_LID_LC, NPC_LT_NA,
+		0,
+		0, 0, 0, 0,
+	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
 		0, 0, 0, 0, 1,
@@ -12855,6 +13236,14 @@ static struct npc_kpu_profile_action kpu7_action_entries[] = {
 		0,
 		0, 0, 0, 0,
 	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		0, 0, 0, 0, 0,
+		NPC_S_KPU8_CUSTOM, 8, 0,
+		NPC_LID_LC, NPC_LT_NA,
+		0,
+		0, 0, 0, 0,
+	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
 		0, 0, 0, 0, 1,
@@ -13056,6 +13445,14 @@ static struct npc_kpu_profile_action kpu8_action_entries[] = {
 		0,
 		0, 0, 0, 0,
 	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		0, 0, 0, 0, 1,
+		NPC_S_NA, 8, 1,
+		NPC_LID_LD, NPC_LT_LD_UDP,
+		0,
+		0, 0, 0, 0,
+	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
 		0, 0, 0, 0, 0,
@@ -13456,6 +13853,70 @@ static struct npc_kpu_profile_action kpu8_action_entries[] = {
 		NPC_F_LD_L_GRE_HAS_CSUM_KEY_SEQ,
 		0, 0, 0, 0,
 	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		12, 16, 20, 2, 0,
+		NPC_S_KPU11_TU_ETHER, 12, 1,
+		NPC_LID_LD, NPC_LT_LD_GRE,
+		0,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		12, 16, 20, 2, 0,
+		NPC_S_KPU11_TU_ETHER, 16, 1,
+		NPC_LID_LD, NPC_LT_LD_GRE,
+		NPC_F_LD_L_GRE_HAS_CSUM,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		12, 16, 20, 2, 0,
+		NPC_S_KPU11_TU_ETHER, 16, 1,
+		NPC_LID_LD, NPC_LT_LD_GRE,
+		NPC_F_LD_L_GRE_HAS_KEY,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		12, 16, 20, 2, 0,
+		NPC_S_KPU11_TU_ETHER, 16, 1,
+		NPC_LID_LD, NPC_LT_LD_GRE,
+		NPC_F_LD_L_GRE_HAS_SEQ,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		12, 16, 20, 2, 0,
+		NPC_S_KPU11_TU_ETHER, 20, 1,
+		NPC_LID_LD, NPC_LT_LD_GRE,
+		NPC_F_LD_L_GRE_HAS_CSUM_KEY,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		12, 16, 20, 2, 0,
+		NPC_S_KPU11_TU_ETHER, 20, 1,
+		NPC_LID_LD, NPC_LT_LD_GRE,
+		NPC_F_LD_L_GRE_HAS_CSUM_SEQ,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		12, 16, 20, 2, 0,
+		NPC_S_KPU11_TU_ETHER, 20, 1,
+		NPC_LID_LD, NPC_LT_LD_GRE,
+		NPC_F_LD_L_GRE_HAS_KEY_SEQ,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		12, 16, 20, 2, 0,
+		NPC_S_KPU11_TU_ETHER, 24, 1,
+		NPC_LID_LD, NPC_LT_LD_GRE,
+		NPC_F_LD_L_GRE_HAS_CSUM_KEY_SEQ,
+		0, 0, 0, 0,
+	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
 		0, 0, 0, 0, 1,
@@ -13528,6 +13989,14 @@ static struct npc_kpu_profile_action kpu8_action_entries[] = {
 		0,
 		0, 0, 0, 0,
 	},
+	{
+		NPC_ERRLEV_LD, NPC_EC_NOERR,
+		0, 0, 0, 0, 0,
+		NPC_S_KPU9_CUSTOM, 0, 1,
+		NPC_LID_LF, NPC_LT_LF_CUSTOM0,
+		0,
+		0, 0xff, 0, 0,
+	},
 	{
 		NPC_ERRLEV_LD, NPC_EC_UNK,
 		0, 0, 0, 0, 1,
@@ -13945,6 +14414,22 @@ static struct npc_kpu_profile_action kpu9_action_entries[] = {
 		0,
 		0, 0, 0, 0,
 	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		8, 0, 6, 2, 0,
+		NPC_S_KPU12_TU_IP, 0, 0,
+		NPC_LID_LE, NPC_LT_NA,
+		0,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		6, 0, 0, 2, 0,
+		NPC_S_KPU12_TU_IP6, 0, 0,
+		NPC_LID_LE, NPC_LT_NA,
+		0,
+		0, 0, 0, 0,
+	},
 	{
 		NPC_ERRLEV_LE, NPC_EC_UNK,
 		0, 0, 0, 0, 1,
@@ -15105,7 +15590,9 @@ static struct npc_lt_def_cfg npc_lt_defaults = {
 	},
 	.rx_et = {
 		{
-			.lid = NPC_LID_LB,
+			.offset = -2,
+			.valid = 1,
+			.lid = NPC_LID_LC,
 			.ltype_match = NPC_LT_NA,
 			.ltype_mask = 0x0,
 		},
@@ -15139,6 +15626,12 @@ static struct npc_mcam_kex npc_mkex_default = {
 				/* Ethertype: 2 bytes, KW0[55:40] */
 				KEX_LD_CFG(0x01, 0xc, 0x1, 0x0, 0x5),
 			},
+			[NPC_LT_LA_CPT_HDR] = {
+				/* DMAC: 6 bytes, KW1[55:8] */
+				KEX_LD_CFG(0x05, 0x0, 0x1, 0x0, NPC_KEXOF_DMAC),
+				/* Ethertype: 2 bytes, KW0[55:40] */
+				KEX_LD_CFG(0x01, 0xc, 0x1, 0x0, 0x5),
+			},
 			/* Layer A: HiGig2: */
 			[NPC_LT_LA_HIGIG2_ETHER] = {
 				/* Classification: 2 bytes, KW1[23:8] */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 66203a90f052..febd00c63bf6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -4039,6 +4039,13 @@ static int set_flowkey_fields(struct nix_rx_flowkey_alg *alg, u32 flow_cfg)
 			field->ltype_match = NPC_LT_LE_GTPU;
 			field->ltype_mask = 0xF;
 			break;
+		case NIX_FLOW_KEY_TYPE_CUSTOM0:
+			field->lid = NPC_LID_LC;
+			field->hdr_offset = 6;
+			field->bytesm1 = 1; /* 2 Bytes*/
+			field->ltype_match = NPC_LT_LC_CUSTOM0;
+			field->ltype_mask = 0xF;
+			break;
 		case NIX_FLOW_KEY_TYPE_VLAN:
 			field->lid = NPC_LID_LB;
 			field->hdr_offset = 2; /* Skip TPID (2-bytes) */
-- 
2.25.1


