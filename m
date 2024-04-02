Return-Path: <linux-kernel+bounces-127221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D6289484E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E87A1F22BE9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 00:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486B2175BC;
	Tue,  2 Apr 2024 00:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="KCYlgI37";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="irf8Xo/X"
Received: from mx0a-000eb902.pphosted.com (mx0a-000eb902.pphosted.com [205.220.165.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F4929AB;
	Tue,  2 Apr 2024 00:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712016778; cv=fail; b=MfUDWBCUmomP3SvvqVRBdcpEQP53PjHkJ4FEyFq836i4OAups7jUS3X6yxcKhdwUKtvqy4tdzfQXT+ZN2pSz2kVTup9lpScop9Sst3eurLOPudrIFaSFrkzRoXvPAx74eou2fwituSdljGJEezd4CO0YhORI41quP+juKkr75z8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712016778; c=relaxed/simple;
	bh=MNNI14WvZxnxVDzMezADwis2ZV539eOg4RYEB0AMbf4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GceXZU7yG53wotleUSWMR5D8WpYQZrmiyVSl97h2ezME/+tDiQihplHsBXTSFLD8GeN5KyaYd2jCGrrgFK5BftSDN0KnpUtT9em+e6nEYgEFPaBO/Qg8bJuUNjyqzrhqMiVK208UzrhaEZGarFCIZjtgCQALPQI12Vrv49PeOtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=KCYlgI37; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=irf8Xo/X; arc=fail smtp.client-ip=205.220.165.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220296.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 431Ixg2M023096;
	Mon, 1 Apr 2024 19:12:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=pps1;
	 bh=a4U0GDF9RFbSPVoEgm/DDUa/de3VmMWRfFdDUCamaCc=; b=KCYlgI375FLi
	GzDRuddTsS0k8pbHMkkdqYXDhFDQJ9sCZ49Ek7nlZJyCD3CL7GNO6Pud7SozLACg
	NHYX9yxvBExwn/hR4YV9IZL088yJHeggpTJVL6atYgfBfnKkRJr5ppZreLDyivnH
	nW+LAwTUlHO/yKhxrWsmAqgsNa//M36LsojNTdageWu7ndgBefcFa1DGi3VuuKzr
	PcZrhehePOZUF0qRiqSMQiMFTkaN1iJIQiFB7G6Qv5m7TgraIBvIs9WB5WnYW9Vn
	4vPu2MfExHOFe6svw72HCyWM8rulcuUFkiIRZBkzy4F7x0K+ptmf/P2jLNxNV6Xm
	sb0LQmSnjQ==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 3x6g44qfbt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 19:12:20 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OPR0kVDZpobk8UH4PKOX5k3jAEh30lI5hKtrYNgqQJMn6C5mcZSHHFxuu/+6aPP2+oz9XgXdLdk2FxlnnzR5ANDxeTtka8jSG0BQtFOWsfJg62hw8nOwBy9euHVeC94FLXOSCixYKH8A0winw3ZGUymkOlgisgimCUXXtCpELz9zVvt8ed2OMGn+zA+MPsosl/fQaVND5ZnkhaoSqV34+0MeE33CfAAOmYSH45IXEFjGVzSHs+26tcJe+4TXPpsVoR6Q+TNua1wN/+9O0sp14dUnCNl/AOt28njQxuE/zA3J2xPJJ7GXqO4wn8qvObCiY2sNaeHlWA8ProKmzabXrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4U0GDF9RFbSPVoEgm/DDUa/de3VmMWRfFdDUCamaCc=;
 b=H9MjewJIV4XcHIndYec0uYghuvqO/vCHD/vyo644OsVaFjjgKBxIe1EigGw4n2wtJ1At5lHIMrafUNdGP51ccyL4UJI82oqaLxTBCj+BE9WV/vZI9d3OO7vd6UL5LH0PF4y8cWxQyJ3a6vE4ydeRkTc2lNcxv0+08bODwbYyzVHGvvlA/S0gta8NhFDtZ6TGEXntq2dUqJpZVF6Jb9KvA5Ts6R9ppezHQBuo1DM760GoqsK46vqvwApkSzlC3Of8PXw7JJbDg1/p/hj+YqguYWtF4dCP4fLerKFlV+rLVq1PwPF8pkftASJO9XIEvCM1iFoK2FJNeHoX8SfgJXo31w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4U0GDF9RFbSPVoEgm/DDUa/de3VmMWRfFdDUCamaCc=;
 b=irf8Xo/XfCWdg5tAntkoCrD+c+jMtPOkohCk/fGuPuX1q0riGTl1Z8v9eoOu0MZUz91PCqy5wGbguu13Ew513mxjCKu/od+DUMGx799gsPSlFAGEFy6haGmuOMVAc2b9i2vyN7fFxj/zDN7LPcFEu0yj20I8FJ+Gw9KFt12I4G5A+mh6HNw3eXCv4ws9a+jfWKNWALNnc5c4TTpmIs9UuQJ8cCUesvfidw6h8leNfAw3Is484DvQSlP50p9jShDkyzZnEw4k/vILcXn80rahb5eBt0y8rJWsIbddX92FBLtJEKutIy1jwbtk28+09CRhBWryouDsAuKNjaoxPqHDRA==
Received: from BN9PR03CA0176.namprd03.prod.outlook.com (2603:10b6:408:f4::31)
 by SA0PR04MB7340.namprd04.prod.outlook.com (2603:10b6:806:e1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 00:12:19 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:f4:cafe::b0) by BN9PR03CA0176.outlook.office365.com
 (2603:10b6:408:f4::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.40 via Frontend
 Transport; Tue, 2 Apr 2024 00:12:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 00:12:18 +0000
Received: from cv1wpa-exmb2.ad.garmin.com (10.5.144.72) by
 olawpa-edge3.garmin.com (10.60.4.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 1 Apr 2024 19:12:09 -0500
Received: from cv1wpa-exmb5.ad.garmin.com (10.5.144.75) by
 CV1WPA-EXMB2.ad.garmin.com (10.5.144.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Mon, 1 Apr 2024 19:12:18 -0500
Received: from kc3wpa-exmb3.ad.garmin.com (10.65.32.83) by
 cv1wpa-exmb5.ad.garmin.com (10.5.144.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.32; Mon, 1 Apr 2024 19:12:17 -0500
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by mail.garmin.com
 (10.65.32.83) with Microsoft SMTP Server id 15.2.1258.32 via Frontend
 Transport; Mon, 1 Apr 2024 19:12:16 -0500
From: Joseph Huang <Joseph.Huang@garmin.com>
To: <netdev@vger.kernel.org>
CC: Joseph Huang <Joseph.Huang@garmin.com>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, "Roopa
 Prabhu" <roopa@nvidia.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>,
        <linux-kernel@vger.kernel.org>, <bridge@lists.linux.dev>
Subject: [PATCH RFC net-next 02/10] net: bridge: Always multicast_flood Reports
Date: Mon, 1 Apr 2024 20:11:01 -0400
Message-ID: <20240402001137.2980589-3-Joseph.Huang@garmin.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240402001137.2980589-1-Joseph.Huang@garmin.com>
References: <20240402001137.2980589-1-Joseph.Huang@garmin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|SA0PR04MB7340:EE_
X-MS-Office365-Filtering-Correlation-Id: e0e20870-cc33-473c-a311-08dc52a98f4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ptQacw1M4Xa5vLnfuJEiGRsOAM7vXFXcqvAQevmP9QFS28aVScx5soRFD0r+l3t1angIEZeF9o5Ijo9UO0o1zgNOjA+IYSsvQlsan/Pmd6xXNGfaAGdMvumfkOLPJkhnBP1d7byWHbxGJ0lCPg6AdfgG9hzB+CuTB4azvLJ8N9zS3SSSQ1KpG/UKQws4jYXFezdgDnEBpxCqK6koLuvuPEbFoSF0a9t0WbisuSpJmvzsq70qfwDmvlMvejPJG2zQI4br9l0ZNCEY75RL+yZN5edMepkEu+hvVnBZ7nA4oucniGjmQdzbkSQSkxpRRiBoFWEQ/v3fq8l5uFzQcJKZHqEZLBrUpcUwfCdJhihXtC73EmoGGaciFIbZBMgOzewJEkQ2PkRyfNOwwlFAp30EFYGmyLWkt6wq3No7UTAN2E+jnhuB9p2VwOQOTwTQ8oGWlhXku7uGKvAbncz0bPWiGcBXJwQBZ7ZVP/EMBfjqZn8/qW+Xjbw2Ee9ltDUZ2QRkv+5ofLLTifIIivamyUyQBx4gF1yZ+NDngMSm9wTmTTcYCA7K7zuBZYkPBL4jvrIIKkQ3fh1v+jDKFlS1+Nw0YpZro92Q7POQ/Z0cN1PfGkOV6UxNM5800KIchFnQtIthJ72xif3BZeB4QQR4HdabMHNXSba/M6KML9zet/XFhtZ+qLUHEfzXeHdtjObkc4ZSXxdxhVcg0yT4a5p/E8GZPij8XcH7mKDUWb6moiqkj67oe/BgaZgnpXhOMkdcUXH4
X-Forefront-Antispam-Report: 
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(7416005)(1800799015)(376005);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 00:12:18.5854
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0e20870-cc33-473c-a311-08dc52a98f4d
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7340
X-Proofpoint-GUID: tJJADjvwhknu33qI0j1gLH_r78aXxl_J
X-Proofpoint-ORIG-GUID: tJJADjvwhknu33qI0j1gLH_r78aXxl_J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_17,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 priorityscore=1501 phishscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404020000

Modify the forwarding path so that IGMPv1/v2/MLDv1 Reports are always
flooded by br_multicast_flood(), regardless of the check done
by br_multicast_querier_exists().

This patch fixes the problems where shortly after a system boots up,
the first couple of Reports are not handled properly in that:

1) The Report from the Host is being flooded (via br_flood) to all
   bridge ports, and
2) If the mrouter port's multicast flooding is disabled, the Reports
   received from other hosts will not be forwarded to the Querier.

Fixes: b00589af3b04 ("bridge: disable snooping if there is no querier")

Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
---
 net/bridge/br_device.c    | 5 +++--
 net/bridge/br_input.c     | 5 +++--
 net/bridge/br_multicast.c | 5 +++++
 net/bridge/br_private.h   | 3 +++
 4 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index c366ccc8b3db..5c09b9dd61dc 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -93,8 +93,9 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 		}
 
 		mdst = br_mdb_entry_skb_get(brmctx, skb, vid);
-		if ((mdst || BR_INPUT_SKB_CB_MROUTERS_ONLY(skb)) &&
-		    br_multicast_querier_exists(brmctx, eth_hdr(skb), mdst))
+		if (((mdst || BR_INPUT_SKB_CB_MROUTERS_ONLY(skb)) &&
+		     br_multicast_querier_exists(brmctx, eth_hdr(skb), mdst)) ||
+		    BR_INPUT_SKB_CB_FORCE_MC_FLOOD(skb))
 			br_multicast_flood(mdst, skb, brmctx, false, true);
 		else
 			br_flood(br, skb, BR_PKT_MULTICAST, false, true, vid);
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index f21097e73482..8e614ab20966 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -176,8 +176,9 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 	switch (pkt_type) {
 	case BR_PKT_MULTICAST:
 		mdst = br_mdb_entry_skb_get(brmctx, skb, vid);
-		if ((mdst || BR_INPUT_SKB_CB_MROUTERS_ONLY(skb)) &&
-		    br_multicast_querier_exists(brmctx, eth_hdr(skb), mdst)) {
+		if (((mdst || BR_INPUT_SKB_CB_MROUTERS_ONLY(skb)) &&
+		     br_multicast_querier_exists(brmctx, eth_hdr(skb), mdst)) ||
+		    BR_INPUT_SKB_CB_FORCE_MC_FLOOD(skb)) {
 			if ((mdst && mdst->host_joined) ||
 			    br_multicast_is_router(brmctx, skb)) {
 				local_rcv = true;
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 42d900549227..8531f0e03f41 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -3844,6 +3844,7 @@ static int br_multicast_ipv4_rcv(struct net_bridge_mcast *brmctx,
 	case IGMP_HOST_MEMBERSHIP_REPORT:
 	case IGMPV2_HOST_MEMBERSHIP_REPORT:
 		BR_INPUT_SKB_CB(skb)->mrouters_only = 1;
+		BR_INPUT_SKB_CB(skb)->force_mc_flood = 1;
 		err = br_ip4_multicast_add_group(brmctx, pmctx, ih->group, vid,
 						 src, true);
 		break;
@@ -3855,6 +3856,7 @@ static int br_multicast_ipv4_rcv(struct net_bridge_mcast *brmctx,
 		br_ip4_multicast_query(brmctx, pmctx, skb, vid);
 		break;
 	case IGMP_HOST_LEAVE_MESSAGE:
+		BR_INPUT_SKB_CB(skb)->force_mc_flood = 1;
 		br_ip4_multicast_leave_group(brmctx, pmctx, ih->group, vid, src);
 		break;
 	}
@@ -3910,6 +3912,7 @@ static int br_multicast_ipv6_rcv(struct net_bridge_mcast *brmctx,
 	case ICMPV6_MGM_REPORT:
 		src = eth_hdr(skb)->h_source;
 		BR_INPUT_SKB_CB(skb)->mrouters_only = 1;
+		BR_INPUT_SKB_CB(skb)->force_mc_flood = 1;
 		err = br_ip6_multicast_add_group(brmctx, pmctx, &mld->mld_mca,
 						 vid, src, true);
 		break;
@@ -3922,6 +3925,7 @@ static int br_multicast_ipv6_rcv(struct net_bridge_mcast *brmctx,
 		break;
 	case ICMPV6_MGM_REDUCTION:
 		src = eth_hdr(skb)->h_source;
+		BR_INPUT_SKB_CB(skb)->force_mc_flood = 1;
 		br_ip6_multicast_leave_group(brmctx, pmctx, &mld->mld_mca, vid,
 					     src);
 		break;
@@ -3944,6 +3948,7 @@ int br_multicast_rcv(struct net_bridge_mcast **brmctx,
 	BR_INPUT_SKB_CB(skb)->igmp = 0;
 	BR_INPUT_SKB_CB(skb)->mrouters_only = 0;
 	BR_INPUT_SKB_CB(skb)->force_flood = 0;
+	BR_INPUT_SKB_CB(skb)->force_mc_flood = 0;
 
 	if (!br_opt_get((*brmctx)->br, BROPT_MULTICAST_ENABLED))
 		return 0;
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index c28e0cd0855c..d72a632a1ad2 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -587,6 +587,7 @@ struct br_input_skb_cb {
 	u8 igmp;
 	u8 mrouters_only:1;
 	u8 force_flood:1;
+	u8 force_mc_flood:1;
 #endif
 	u8 proxyarp_replied:1;
 	u8 src_port_isolated:1;
@@ -622,9 +623,11 @@ struct br_input_skb_cb {
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
 # define BR_INPUT_SKB_CB_MROUTERS_ONLY(__skb)	(BR_INPUT_SKB_CB(__skb)->mrouters_only)
 # define BR_INPUT_SKB_CB_FORCE_FLOOD(__skb)	(BR_INPUT_SKB_CB(__skb)->force_flood)
+# define BR_INPUT_SKB_CB_FORCE_MC_FLOOD(__skb)	(BR_INPUT_SKB_CB(__skb)->force_mc_flood)
 #else
 # define BR_INPUT_SKB_CB_MROUTERS_ONLY(__skb)	(0)
 # define BR_INPUT_SKB_CB_FORCE_FLOOD(__skb)	(0)
+# define BR_INPUT_SKB_CB_FORCE_MC_FLOOD(__skb)	(0)
 #endif
 
 #define br_printk(level, br, format, args...)	\
-- 
2.17.1


