Return-Path: <linux-kernel+bounces-127216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E32894840
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13BE4B21F52
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 00:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC8833F9;
	Tue,  2 Apr 2024 00:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="NfLZ5eiM";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="YfIbR4W7"
Received: from mx0b-000eb902.pphosted.com (mx0b-000eb902.pphosted.com [205.220.177.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D2563B;
	Tue,  2 Apr 2024 00:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712016774; cv=fail; b=puaLI9Bi5AIwXVPwdTxKzBN+Sa9GNDFU1MC7ORkm0kpmbgRR+hoHlFel8UK715WydPLl6CubH1rdBytWghoa+Al3b+m0kMaVSL6CvApXxuOcsiCEqpLjZk9MpzoF9DxpRjFgnAjEQFR7vbNgYHNwEuQF2sttxvytSgbSyiYeHug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712016774; c=relaxed/simple;
	bh=UWcYZ7EZF7J4vACET6uCIAKTx3l3xJWs4KzJxoQfBr8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nrgSMNwM//RZ9wU7PL/6KYfbAq2laWfBktxLvsFd5EdaFCSRdkfru2HPtOOHdd4ooUM7e4RHAT0VWACXgCkbCaDnFwRyqsQrLhO4Ll2gA8v6TCVfvmYWyt80uOyt0FfBRQzGjrRS/Wnp9VsapWLdKlYVwyUBZB+2Vk7PwudZdck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=NfLZ5eiM; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=YfIbR4W7; arc=fail smtp.client-ip=205.220.177.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220299.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 431IxhYb023933;
	Mon, 1 Apr 2024 19:12:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=pps1;
	 bh=a60koyl3sK4k07hzMsJ3jYPnKyNmnt4o3FXJ1NJZAr8=; b=NfLZ5eiMcNAx
	KoIOhvLli8wQafyv5Wax8yMAepbT6vyI3OC9ua3myYWSQ4ltWZwlFG9bILykJfZD
	6HdgTMGJ/iYGI/q+tqS+cZTRir9povY4W96LWH4q0rLrAE41e+OXsMC0q4IaxiTg
	TRn6g8PtsifdXMAxPGVQLcp0Hm2N75zg9TV0tRo8upjrz29f5seJZNeq1kpVYtzq
	9p45iHnUK4xG+IwPwdAnGR+FndlEg3abUSGH3XPdrhCEnBCfMbxUuE3Pm27pBKJR
	PUUvrevrQMvX2WIWb1Phagn/aisPQaQ01X+DPBGKJ4+0uLgjH5hhqJhrLdg6USRs
	lQtZx/4bvg==
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 3x80hys4mm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 19:12:25 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GxeBsqzUF8M7cFLEx8CEVwfdtEJdueOuWYcuN8xmhY2PfFANeuanxfHb2M5eeYcBD9ma3R8eOjazvbUEpWDD/GVlL2OV8hXMI2pUwLL66Vu1k2odIfDPAqFpQWVP6Bk1r47FI9KxIOEiVwTw4NjITc6EWSGRmslntQj8HY522dKqnMIsJEgC2HKExTy7SsNm9IncaQn0jYoy9nHxDGPVeOpzLPSxn7uNEWuiw40pWNd7f6SiN63dEfgig+ULMv+mHa26L8cdpFxmvNSfswsxoFaWsGcx9+J/5FduMc09j9Z7pDwqP5JqAJe7DOdOHvCYbpDoSg/CIFYHflGRsSa3yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a60koyl3sK4k07hzMsJ3jYPnKyNmnt4o3FXJ1NJZAr8=;
 b=TepycmsMSU02lZ72bRKFXEW1klnmWttvw1wZHY60bJ4kkkpGm/vOVJmR+0UTqSE1tyioPKMJOpXtY0Zv4RgjpUmzEMJa4Wd4QQxfEJpOou+pZjzIkH/OBSx1ro6QW3XkycbomMC5DR84/QxLC8vjwJCfZlGnJV6pSAdMNJnq0Hg9mKmWmNFkIMhjUhh+l/Jmc8Hx7O3Q+nd7Rdk1RxRcROqrySFQfGxsesu6CJmz0hRWPZIamdumPiyf11I2wo6engeWfr89XP4nnT8QqY9LDqtEGhyZzeXBywPQhlwl8z/SZfsRggmxk18on8j0u4oFS2xkRqwg5DGfV4XUhXg15A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a60koyl3sK4k07hzMsJ3jYPnKyNmnt4o3FXJ1NJZAr8=;
 b=YfIbR4W7EN8vhEF74liNtyirQsNo0EPiWm90fXIibdBhWtmFanIK6oPtzjD9pekfA++P7bPYk6XXCkIciDzbDNtkeasz6ewltLlxm6rv10v1QsXhoEvTsOcCGfAMRFrSktlsWqO+4/zlJ4lHfevLkyF96tGzYNaBJsmmEtcbMHUGJXDnkHxiPoL8ZgSa4yTB7cWgC4Bub858Uy/x1PGtliv2h876dLfgRF6octlD9ejxpAYZILg780ztmr6JVGYRmnnXUKXHTA5AFxxVj+BV7MctY7gzZd8+nK3TeJlLQ9udyTP5f0L5LUnxSrpOrZIR1uSkGDqk2iiEHb1MLbvdoQ==
Received: from BN9PR03CA0164.namprd03.prod.outlook.com (2603:10b6:408:f4::19)
 by BN0PR04MB8207.namprd04.prod.outlook.com (2603:10b6:408:15f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 00:12:22 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:f4:cafe::c1) by BN9PR03CA0164.outlook.office365.com
 (2603:10b6:408:f4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.40 via Frontend
 Transport; Tue, 2 Apr 2024 00:12:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 00:12:22 +0000
Received: from cv1wpa-exmb4.ad.garmin.com (10.5.144.74) by
 olawpa-edge3.garmin.com (10.60.4.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 1 Apr 2024 19:12:12 -0500
Received: from cv1wpa-exmb5.ad.garmin.com (10.5.144.75) by
 CV1WPA-EXMB4.ad.garmin.com (10.5.144.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Mon, 1 Apr 2024 19:12:21 -0500
Received: from kc3wpa-exmb3.ad.garmin.com (10.65.32.83) by
 cv1wpa-exmb5.ad.garmin.com (10.5.144.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.32; Mon, 1 Apr 2024 19:12:20 -0500
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by mail.garmin.com
 (10.65.32.83) with Microsoft SMTP Server id 15.2.1258.32 via Frontend
 Transport; Mon, 1 Apr 2024 19:12:19 -0500
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
Subject: [PATCH RFC net-next 03/10] net: bridge: Always flood local subnet mc packets
Date: Mon, 1 Apr 2024 20:11:02 -0400
Message-ID: <20240402001137.2980589-4-Joseph.Huang@garmin.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|BN0PR04MB8207:EE_
X-MS-Office365-Filtering-Correlation-Id: 77ecdf74-bb9f-48e4-3be4-08dc52a9916d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	LkNi8qY+O+AVaHsrvad4rhPYoVtrbkH+Utc6WGlTDf/iWgpSZK8dey2sszCP/8yZZxLy8QmiSU6dQ7Bpg7/v17kqGydUBynFLphudCCIdsK1emC0sAOPzauvUFfsWcof4t2PTefnyOG6v4agXm02COL2PwtBzklrWery4XWdfDZjK2aWXo/W7bBRhm9nTu0uy+CURtErahjVfwJzDqCSuR1PtXrSpnRljH03EvGaBdxcnND49TQWmx3xpeGCntgH62Nv/cHzlwtccIMv3p84NqsC5nAn3B/sviIyw/zCAF1GiIv96nKq9y95pJ+alIzTHca+RXlKkjeDt2jdW0zJDGFIyT7wjmbs81WRjXoxxAlni/aL8YbAcPYSqLKbwx8qlpCcAvVIDWUISF7Lk1bNinVy85aD07+sguqtSDTA5pEFwbMwq3G5Mu2zTX5l2Xsf8k75g52SczJG8+Uq/hZTU1xNNs9BUJm5JzoH8OxxORATgi7T+y3oenE7+egJFivasqCbiVugNTfGPi0kt0Nb0NiGi7zrs9JKUSCs4YQVNU2PeXAN5DFdjmfXeURfsHgTTcW9tjHJNtHUEWF6Kl3wMfRpVC7AhuvrfrqXsgr9alQM3/1bQvuC8jQAABE2imn+hNAqvQ6JL2E4+0MjUjnM8U3RvKUfSQIOv9ifSHmpvoNcYGOBcxm5TirhHvSREPb5mvtXlPdt5ZsUJJEFx0aPKYkyDG3Vl9C9MJojMg5DV0m5prQqKDVnLNHzInJOVvdX
X-Forefront-Antispam-Report: 
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005)(7416005);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 00:12:22.1479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ecdf74-bb9f-48e4-3be4-08dc52a9916d
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8207
X-Proofpoint-GUID: sypMPbQwKW79TZKzwiZepSFDuOAaez-C
X-Proofpoint-ORIG-GUID: sypMPbQwKW79TZKzwiZepSFDuOAaez-C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_16,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404010168

Always flood packets with local multicast destination address.

If multicast flooding is disabled on a bridge port, local subnet multicast
packets from the bridge will not be forwarded out of that port, even if
IGMP snooping is running and the hosts beyond the bridge port are sending
Reports to join these groups (e.g., 224.0.0.251). This is because the bridge
blocks the creation of an mdb entry if the group is a local subnet multicast
address, which will cause these packets to be flooded via br_flood(),
but blocked by the mcast_flood flag check.

Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
---
 net/bridge/br_multicast.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 8531f0e03f41..02a5209afab8 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -3823,11 +3823,14 @@ static int br_multicast_ipv4_rcv(struct net_bridge_mcast *brmctx,
 	if (err == -ENOMSG) {
 		if (!ipv4_is_local_multicast(ip_hdr(skb)->daddr)) {
 			BR_INPUT_SKB_CB(skb)->mrouters_only = 1;
-		} else if (pim_ipv4_all_pim_routers(ip_hdr(skb)->daddr)) {
-			if (ip_hdr(skb)->protocol == IPPROTO_PIM)
-				br_multicast_pim(brmctx, pmctx, skb);
-		} else if (ipv4_is_all_snoopers(ip_hdr(skb)->daddr)) {
-			br_ip4_multicast_mrd_rcv(brmctx, pmctx, skb);
+		} else {
+			BR_INPUT_SKB_CB(skb)->force_flood = 1;
+			if (pim_ipv4_all_pim_routers(ip_hdr(skb)->daddr)) {
+				if (ip_hdr(skb)->protocol == IPPROTO_PIM)
+					br_multicast_pim(brmctx, pmctx, skb);
+			} else if (ipv4_is_all_snoopers(ip_hdr(skb)->daddr)) {
+				br_ip4_multicast_mrd_rcv(brmctx, pmctx, skb);
+			}
 		}
 
 		return 0;
-- 
2.17.1


