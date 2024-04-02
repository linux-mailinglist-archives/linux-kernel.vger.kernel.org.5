Return-Path: <linux-kernel+bounces-127217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C74894841
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7EA72830AB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 00:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F47279F5;
	Tue,  2 Apr 2024 00:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="GiRi0L68";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="TJTg5Ngo"
Received: from mx0b-000eb902.pphosted.com (mx0b-000eb902.pphosted.com [205.220.177.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9119B81E;
	Tue,  2 Apr 2024 00:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712016774; cv=fail; b=qyWSrw294oyUCEEfOOc8wl4koYRBvkyZC9B0z/8zvh63NEzKuGqkzhDb8ew0AP9oIhJ6RQCEA4MYkxAXSfWc/GP5XC4IH4M+cp61UD8c5A/ozGa6b1UkY+w4/B2umvL4hoAtCCFBNq6mp5ekip6+6M3QrpU+5dXQNopNEiFxgs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712016774; c=relaxed/simple;
	bh=wsXF30yh9ge3GMsxMDm/SY7ZXK3PyAMck3oGLU2/8tg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B0FD9g+MG4nBdVSQQXM3JghTOubq7qe13Lea1BgqFkxjIpwa0h/wmhlpYVQRCFjsThUj325mXN6o/kzbzNWyUFO5RA8YggXdxEqIS0G1u8eGfZ4jNe0TRjFWYKb2rI81X7A3KGsczbBdhfbY+mqPQ2Xn2M8msjt/AmhEnQowCbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=GiRi0L68; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=TJTg5Ngo; arc=fail smtp.client-ip=205.220.177.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220299.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 431IxhiT023940;
	Mon, 1 Apr 2024 19:12:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=pps1;
	 bh=CTJNy+dHkorgc388simu6OXyJa6YT69jpJ/6JvKUu7g=; b=GiRi0L68mpkb
	QubHzCaHQyyJCZexKrGiEjuaR1kpTYjmJEhH/lCObjWwE2SUmeboUrmNR4S5stmD
	VMqapao1IJ6rKmtFyPrpSz3n2ehDJOFioH0IFnZfd2hWIdsyHW6isIoGi9egGPBD
	37a8yjGNVXF0DtgXieXJtoRburmS+8KVwOou0iKuaeCDuMu2CIQcPSkHY9u5SE3F
	/apswMitd6/kMpD04jFi1QvrfyZ0GBniTpxyh6dUFN4OQrYV7Hp+bOc1t3O5omq7
	zipOIaYfIQKpK/xdWBqXJ5ZIHgWjU9eMjcDfe0sVLtl52/d+Tz0VWhWibfRofvEc
	59tZIUOy5Q==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 3x80hys4mk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 19:12:23 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dhDe46TwvIRxf7hSW6eE+m5r9K2bvNTK1ue+xeDGOGSjU7Hih5WKNIMF9FEQTyHvjMrg7SkOH3GhGm9S59yY07BnNuEsL+dyswhtesf3BYApEYds2wRyDqMA7ZjRKo/9Wy+GFYSE3PsKyV7Pz91tkfqqu3ZKvI2Q9uur5YdV2Ufar+C62bsN0jxKFXaHRx87EodVah5gKYc/4GuDD7vUZZ4B09QN+aidKiILqrEagX1Add0qbeIKT4yW+mo2FjbvbEtu8r/y+4y2g2H6UxIGk2Udu78lLCGGoA47TTe7QqqS9yTKkbmqV5ZezSrUeMoabzPsZTT+r/KNCTJDJC1jyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTJNy+dHkorgc388simu6OXyJa6YT69jpJ/6JvKUu7g=;
 b=bxfF7v1ROp5Zb+i9bqljh0J2gYzb3Gr7QJlEYNwn/HjlsyidhvBS/ozF6RpunnxTrssQ0T84s3dBkG2PSna+lnUJwpZnOMOtLNGLq5Z/AzXI/t3DmvVMnDGtbITydqtJixHp7NsXFgLEyG9zNvlHi9pTph6SIptrEnG7TQIw8qrPYe4TwXVuL2xOvdHmWGeHjMGazDqLtIQx6wYU0acUHrDYQDywF20O7fgjGqx/9PcPCl4BEIzIsgOcj09UAooUa0AYyvZyZm2wSdxafW1oYvuRRmlgOolz+gWOel8Zt4wGVeeTScoM2T4ONyKiVGXbMcF9kYXbXoBvUdL5FS9GGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTJNy+dHkorgc388simu6OXyJa6YT69jpJ/6JvKUu7g=;
 b=TJTg5NgonX/VTg4v79Vx+RoVF4eUrNRfZBac3QtXA2XJFcpcH7XBILxKubqHan/6+9bFcwi2Yz3Qn/a3xVPXS6F0ulNvV50De4DTUBH64jTXhoDVgyBKtVbNbtbjEW7Fuwm4Rzy4b3xn91AjiOtILQHzQoc60mJGyqGZKG66k/CqCYOy6ezuRxwwtDp1GmPVIpvVWMiG8FeQdHVHDYrTxZcxBgB8HnZwEo21Avz2ZlQO82nuhYWcqNilSPlF68lCmVjc5KBoybAmBMDv87NMPhM8gsh/nGo7ooaEM+aoSxQrPlQbQK9Gbofbg4SglX4/WJQxTN4HfmM6H24qyofxjA==
Received: from SJ0PR13CA0149.namprd13.prod.outlook.com (2603:10b6:a03:2c6::34)
 by SJ0PR04MB8247.namprd04.prod.outlook.com (2603:10b6:a03:3fa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 00:12:18 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::ab) by SJ0PR13CA0149.outlook.office365.com
 (2603:10b6:a03:2c6::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25 via Frontend
 Transport; Tue, 2 Apr 2024 00:12:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 00:12:18 +0000
Received: from cv1wpa-exmb1.ad.garmin.com (10.5.144.71) by
 olawpa-edge5.garmin.com (10.60.4.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 1 Apr 2024 19:12:07 -0500
Received: from cv1wpa-exmb5.ad.garmin.com (10.5.144.75) by
 CV1WPA-EXMB1.ad.garmin.com (10.5.144.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.37; Mon, 1 Apr 2024 19:12:15 -0500
Received: from kc3wpa-exmb3.ad.garmin.com (10.65.32.83) by
 cv1wpa-exmb5.ad.garmin.com (10.5.144.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.32; Mon, 1 Apr 2024 19:12:14 -0500
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by mail.garmin.com
 (10.65.32.83) with Microsoft SMTP Server id 15.2.1258.32 via Frontend
 Transport; Mon, 1 Apr 2024 19:12:13 -0500
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
Subject: [PATCH RFC net-next 01/10] net: bridge: Flood Queries even when mc flood is disabled
Date: Mon, 1 Apr 2024 20:11:00 -0400
Message-ID: <20240402001137.2980589-2-Joseph.Huang@garmin.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|SJ0PR04MB8247:EE_
X-MS-Office365-Filtering-Correlation-Id: 15f43726-0cc8-46f8-dd14-08dc52a98f3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	LuSOw911TyxWvc6Gd/B04uGPz/HtEaiHZxeXmEkQy464MrSPwBuPvIWCJY9u6RwOxc5Lr4duozGy+/i/etvVAUZDGSAe89JJAT0sNfj2uPdFHT/j8lVW3rPUWnjQ2pFQYyMj2bRiJiKClZ05xPX6TuO6JGxQp3hIKneFH5UQZbhAaau61LvoUug3yB7Js64zmiL0EYzjQbEdUmGsfQqFvTl/taJZmmGOufowwPjms+CC/l65wj3pe+O8vOeeZdeMuVxcymvEFS9POJt2x/eM1ClvKcCtFmPtGtlPqOV/RTrWxMxp1YbTpoGVS3RMQ0XyUXnufbcDe8yheb578jB3B+yj70kq+LJHjRgbwLVW/enmaB5h+b8q8cE3tH/wYGvTcKujs/4BwrgrmKwg+ZuyNjAfCTekh7s3gTeAoKcKEr+1sL7sIRDJHoi2E1DfwKxeNyxnxF8t6Ia0zEBS5h5N2K5JwbKslDAI1YVc7d4+gXDcMWHVnv6hMUDIaZZF7IdLW0YPtwoxEbutX6Klpf84VqE/lKaKGb/61+z8Ij81XrI/EACiHEtLRMWRxBXPhO3t6Te7CPIi5XXOc4Of5WTwJKt14dNUt3QoQKhmA5AZI2zMViBngx7v7qHbVgdEmYLQBMBgGhoY7iAxRuOE8GWeyaLQBScoJBv7MEFB502ImfSMYbx/LnNoZVd/nVZcbcgG4/1mPGByCEuuu2U5BWgxrFzASO3G/5y5mlcQZgUcmfuVhct7ZGMDMkzBOhw1lTBx
X-Forefront-Antispam-Report: 
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005)(7416005);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 00:12:18.4468
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f43726-0cc8-46f8-dd14-08dc52a98f3a
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8247
X-Proofpoint-GUID: 2BKmK7QelfwEkQmFLCBEaLd8Q-ZE9o4C
X-Proofpoint-ORIG-GUID: 2BKmK7QelfwEkQmFLCBEaLd8Q-ZE9o4C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_16,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404010168

Modify the forwarding path so that received Queries are always flooded
even when multicast flooding is disabled on a bridge port.

In current implementation, when multicast flooding is disabled on a bridge
port, Queries received from other Querier will not be forwarded out of
that bridge port. This unfortunately breaks multicast snooping.

Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
---
 net/bridge/br_forward.c   | 3 ++-
 net/bridge/br_multicast.c | 3 +++
 net/bridge/br_private.h   | 3 +++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index 7431f89e897b..6c18ea37b5f5 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -216,7 +216,8 @@ void br_flood(struct net_bridge *br, struct sk_buff *skb,
 				continue;
 			break;
 		case BR_PKT_MULTICAST:
-			if (!(p->flags & BR_MCAST_FLOOD) && skb->dev != br->dev)
+			if (!(p->flags & BR_MCAST_FLOOD) && skb->dev != br->dev &&
+			    !BR_INPUT_SKB_CB_FORCE_FLOOD(skb))
 				continue;
 			break;
 		case BR_PKT_BROADCAST:
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 9a1cb5079a7a..42d900549227 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -3851,6 +3851,7 @@ static int br_multicast_ipv4_rcv(struct net_bridge_mcast *brmctx,
 		err = br_ip4_multicast_igmp3_report(brmctx, pmctx, skb, vid);
 		break;
 	case IGMP_HOST_MEMBERSHIP_QUERY:
+		BR_INPUT_SKB_CB(skb)->force_flood = 1;
 		br_ip4_multicast_query(brmctx, pmctx, skb, vid);
 		break;
 	case IGMP_HOST_LEAVE_MESSAGE:
@@ -3916,6 +3917,7 @@ static int br_multicast_ipv6_rcv(struct net_bridge_mcast *brmctx,
 		err = br_ip6_multicast_mld2_report(brmctx, pmctx, skb, vid);
 		break;
 	case ICMPV6_MGM_QUERY:
+		BR_INPUT_SKB_CB(skb)->force_flood = 1;
 		err = br_ip6_multicast_query(brmctx, pmctx, skb, vid);
 		break;
 	case ICMPV6_MGM_REDUCTION:
@@ -3941,6 +3943,7 @@ int br_multicast_rcv(struct net_bridge_mcast **brmctx,
 
 	BR_INPUT_SKB_CB(skb)->igmp = 0;
 	BR_INPUT_SKB_CB(skb)->mrouters_only = 0;
+	BR_INPUT_SKB_CB(skb)->force_flood = 0;
 
 	if (!br_opt_get((*brmctx)->br, BROPT_MULTICAST_ENABLED))
 		return 0;
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 86ea5e6689b5..c28e0cd0855c 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -586,6 +586,7 @@ struct br_input_skb_cb {
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
 	u8 igmp;
 	u8 mrouters_only:1;
+	u8 force_flood:1;
 #endif
 	u8 proxyarp_replied:1;
 	u8 src_port_isolated:1;
@@ -620,8 +621,10 @@ struct br_input_skb_cb {
 
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
 # define BR_INPUT_SKB_CB_MROUTERS_ONLY(__skb)	(BR_INPUT_SKB_CB(__skb)->mrouters_only)
+# define BR_INPUT_SKB_CB_FORCE_FLOOD(__skb)	(BR_INPUT_SKB_CB(__skb)->force_flood)
 #else
 # define BR_INPUT_SKB_CB_MROUTERS_ONLY(__skb)	(0)
+# define BR_INPUT_SKB_CB_FORCE_FLOOD(__skb)	(0)
 #endif
 
 #define br_printk(level, br, format, args...)	\
-- 
2.17.1


