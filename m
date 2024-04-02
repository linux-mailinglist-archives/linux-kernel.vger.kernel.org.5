Return-Path: <linux-kernel+bounces-127220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E915894848
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9AAD281659
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 00:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF66EECC;
	Tue,  2 Apr 2024 00:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="GVlhvV0M";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="aIgnKhUD"
Received: from mx0a-000eb902.pphosted.com (mx0a-000eb902.pphosted.com [205.220.165.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B550A2C9E;
	Tue,  2 Apr 2024 00:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712016776; cv=fail; b=URlDpgb8Zrr8TXJmjG/bZFCjwevJg02oHma7MWo/vHulJQ9CTfKE23RbG6lVx1J9DNj1AgcsDxz+1fUkEumliVxwt96NedpGIzGTinxsuX4KCew1YGipZVI0wbw+p+dzaevBWduC1FH2N/Ydpg7VID1QuupkAd5Q5hj/dFzTJ4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712016776; c=relaxed/simple;
	bh=0l5hsdHDLVVnywoch5SQrIbuIghnUX5nqsuzUE76m88=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kl2h6j/y3TJXlC0ZMJbxijAfVzLbTcYVkPFY18jMsU/fOitAG74V9TlNqsWtgutRULXi+KwG0gtajYqIhsqXEmR50p0SXciiwdm3UH/daVCT8zTX8qwZqXKPrGym1HQArzntSOjglq7e6272ViytSF8uCjbzGZmpD9XI5tjeKUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=GVlhvV0M; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=aIgnKhUD; arc=fail smtp.client-ip=205.220.165.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220295.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 431Ixexg010408;
	Mon, 1 Apr 2024 19:12:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=pps1;
	 bh=Rg2UydNof9shahdUvJueK7G9agfcFnQPz3zx5dpxrzs=; b=GVlhvV0MD/62
	lXqXi9A6/BApV+7aopQZFr8c0UheK1FXXHfSpCK1XdUlF2jtJVWXPBARCi59FnzP
	cAVQfMmMZIjM7K6Tv4Mz4cTLIR1udi3h57mhWtDDHEXlWhm3wH+ubIbIdvCzJn5S
	6khIYC809Ueoo4RRjLw0SiAQ5voFAv5++r9thOmeV9wsptKtV4dAcshmcu6NQHa0
	1xNvxLYhgAvwNrFCM/RZNhFJ2afolpggW4egTjA50ZmMJLqEdLB4N8UdcH6ApH2Q
	esF3w0GG8RlQFfIQ5dSLKLi55OsTjWUbJlGJjAQhnzLwKHo9MTPaGzyyrFCKnckD
	dE1H55pFxg==
Received: from bl0pr05cu006.outbound.protection.outlook.com (mail-eastusazlp17013025.outbound.protection.outlook.com [40.93.11.25])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 3x6d6tfyj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 19:12:31 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IwiA6G23P+yZ54MBIYjgbr0Ku9+OUE99msQrWssEQlUGiwF0W6akzyE1In1kOyDTiziaoel06yseitleQrdQrFMVf3wDR1Buubvv+eLQJvFYzZCakXje8uK0koL1x6x82MoyhRtdm3kUEvvdUuzSRDxH26DLNUgDJ3sd4odcWY3CAusW9YqNYzp4OLfTo5wIHcdkGN+U7bZ3pI7S7eE2JFFOWbNpfo7V0ilO59Y1JpwYMJ/9y48F6j7X44QtJA/b7ZW4mYSgvLmTXgzpz74P1vLeWg0//jr4EOzuavw0sEjCVBmM+GFVVLJ5cBAc9b/Hu2pSWy0r940F4VFuWX5lsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rg2UydNof9shahdUvJueK7G9agfcFnQPz3zx5dpxrzs=;
 b=M4vNb2GND4j4k0R+jGPPBUDMAkTkEjY0rmjhEhRE2SjaMS//DVEEucI9J3uWH918sseayUZ+liKRXSoTt2yZi9hHsPGaKAR+h7qJ5s5z7I4zr1097tLS+oW7qC48IjwfP5MA+ZTJ9VaVYFsQJDPf9YcM0krQeJ3YUqrgjH6bURGvu6yAf17mpRWut6s6Gji+NftgDcXV7J43MMHANkh7iryVp/4nbNiweP9Vw2psXysBk+M9nGt3JI9HPyMEjotsRXStFdsM/M9d5EstPhdI0Xh2ImXPxbJDnnwK1CeJXbJoyLZYcmhYph2BkaHolXkbn6U7YA9vvn4TC0xD/q1UgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rg2UydNof9shahdUvJueK7G9agfcFnQPz3zx5dpxrzs=;
 b=aIgnKhUDH4lNgWn4kDE19quhI5ylf2UsubuPFEhpa9AN816rsjVG6wGs1k8vM1GAxjsKvKJ7MYoxUDczk6X+0e5UPWBaN6GK0q2yrL2hqpzgB2iL0tdRfERdDLNItg35h9BzH8PeSMj+tr/rJAqFnxqNPVL7QtKOj/pQ31rOFNUkA0wY3UBlC3L/RJzm5wlQ+CbamJLQ9Pjna9y7sjIbzyuzkOEzlsUoqKFggBkS1e/0fKV7NRngyeca/B/koCcx7TpwBacpQ74o+AuOIeqGzgHa2A4EkH5BT69OVR9HSvfPLRYrop7OTLhTQm9UgqVBJn/pFfICleeixviyFh6CPw==
Received: from BYAPR06CA0018.namprd06.prod.outlook.com (2603:10b6:a03:d4::31)
 by SJ0PR04MB7773.namprd04.prod.outlook.com (2603:10b6:a03:302::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 00:12:29 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::5a) by BYAPR06CA0018.outlook.office365.com
 (2603:10b6:a03:d4::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Tue, 2 Apr 2024 00:12:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 00:12:28 +0000
Received: from cv1wpa-exmb1.ad.garmin.com (10.5.144.71) by
 olawpa-edge5.garmin.com (10.60.4.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 1 Apr 2024 19:12:19 -0500
Received: from cv1wpa-exmb5.ad.garmin.com (10.5.144.75) by
 CV1WPA-EXMB1.ad.garmin.com (10.5.144.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.37; Mon, 1 Apr 2024 19:12:27 -0500
Received: from kc3wpa-exmb3.ad.garmin.com (10.65.32.83) by
 cv1wpa-exmb5.ad.garmin.com (10.5.144.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.32; Mon, 1 Apr 2024 19:12:27 -0500
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by mail.garmin.com
 (10.65.32.83) with Microsoft SMTP Server id 15.2.1258.32 via Frontend
 Transport; Mon, 1 Apr 2024 19:12:26 -0500
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
Subject: [PATCH RFC net-next 05/10] net: dsa: Add support for PORT_MROUTER attribute
Date: Mon, 1 Apr 2024 20:11:04 -0400
Message-ID: <20240402001137.2980589-6-Joseph.Huang@garmin.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|SJ0PR04MB7773:EE_
X-MS-Office365-Filtering-Correlation-Id: 8791e8b4-c6ff-4bf5-ff7e-08dc52a9955e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	9MQQonZ8w14KBM6bqLbTpfFOdLDhPt8cYjoKxmGkmCkXZr5FerpzMKsUQrI5Wll26Zir4eK06W5O/44TVQo1iJltPByRWA8wP5pV/gSsMFdOgRXGzxbTSKloKmQWhbVsuZlog11rxd27QFYmkmLT9KKE0BkwVOvOoNYxyMGzgw6jXNRXu3meG8RTKRlGMbKDXi67Oqvdyy03TuX8DBXV8MJI8zC9ePIv/+EhIoQ5YIMUuoOtjx6gTNW8gKD9TB3buVuAGV+wdG5KKSm/XxQ5uupvzhg+Vx2kEXZRRSMz+GaD93ZNWBjBg4J9OM0/jg5J7AduPKkp9ldLR7BIbOdmQvq9FD3Jj18eyB8YiujcY7RB+CsX41DkgKxFgzIuHrI+r/qbvSbQyS36TwSwhIwmGWTI81rI73dyEwfEBg+qkgQ2nVFFe5j8obx6jBZvO7xqL7QSzQxkY9le2gEIqOklxVDVtRMDjfXuMTRp8TY0Ae4zpb42bk1C43fzn56qK4+mxCu8bC2DAT3sBKZ7iY0PBJrUZC3Yl6KypEvGD9+WLqHFunMzMyjZe8W4t/xweum/Scr9uDgbYII4afOk0TzPPCBmuuig7gcgPaQonfrXP+XhPLNSOrnboOd89ij2D6fSjfbsh1thsVGryhCZ2UWmx9ni8IYijG24KmWezgIKFpiZIIAo7b0V9fD1PsJDUL1SYmlnFThLqhD37/DFMhnjGMcQDa6j8JdnRRe0+8oQ2BG/WZBK8goZWYbVBR2IEZlQ
X-Forefront-Antispam-Report: 
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(7416005)(376005)(1800799015);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 00:12:28.7499
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8791e8b4-c6ff-4bf5-ff7e-08dc52a9955e
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7773
X-Proofpoint-GUID: NShXKpIRB4-u1fUT1aplDxZ93JsQY3pZ
X-Proofpoint-ORIG-GUID: NShXKpIRB4-u1fUT1aplDxZ93JsQY3pZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_17,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2404020000

Add support for delivering SWITCHDEV_ATTR_ID_PORT_MROUTER event to DSA
subsystem. This is essentially 08cc83c ("net: dsa: add support for
BRIDGE_MROUTER attribute") repurposed for PORT_MROUTER.

Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
---
 include/net/dsa.h |  2 ++
 net/dsa/port.c    | 11 +++++++++++
 net/dsa/port.h    |  2 ++
 net/dsa/user.c    |  6 ++++++
 4 files changed, 21 insertions(+)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 7c0da9effe4e..5dc5838caa9c 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -1037,6 +1037,8 @@ struct dsa_switch_ops {
 	int	(*port_bridge_flags)(struct dsa_switch *ds, int port,
 				     struct switchdev_brport_flags flags,
 				     struct netlink_ext_ack *extack);
+	int	(*port_mrouter)(struct dsa_switch *ds, int port, bool mrouter,
+				struct netlink_ext_ack *extack);
 	void	(*port_set_host_flood)(struct dsa_switch *ds, int port,
 				       bool uc, bool mc);
 
diff --git a/net/dsa/port.c b/net/dsa/port.c
index c42dac87671b..3f689cb713aa 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -948,6 +948,17 @@ int dsa_port_bridge_flags(struct dsa_port *dp,
 	return 0;
 }
 
+int dsa_port_mrouter(struct dsa_port *dp, bool mrouter,
+		     struct netlink_ext_ack *extack)
+{
+	struct dsa_switch *ds = dp->ds;
+
+	if (!ds->ops->port_mrouter)
+		return -EOPNOTSUPP;
+
+	return ds->ops->port_mrouter(ds, dp->index, mrouter, extack);
+}
+
 void dsa_port_set_host_flood(struct dsa_port *dp, bool uc, bool mc)
 {
 	struct dsa_switch *ds = dp->ds;
diff --git a/net/dsa/port.h b/net/dsa/port.h
index 6bc3291573c0..85102e1659ae 100644
--- a/net/dsa/port.h
+++ b/net/dsa/port.h
@@ -81,6 +81,8 @@ int dsa_port_pre_bridge_flags(const struct dsa_port *dp,
 int dsa_port_bridge_flags(struct dsa_port *dp,
 			  struct switchdev_brport_flags flags,
 			  struct netlink_ext_ack *extack);
+int dsa_port_mrouter(struct dsa_port *dp, bool mrouter,
+		     struct netlink_ext_ack *extack);
 int dsa_port_vlan_add(struct dsa_port *dp,
 		      const struct switchdev_obj_port_vlan *vlan,
 		      struct netlink_ext_ack *extack);
diff --git a/net/dsa/user.c b/net/dsa/user.c
index 16d395bb1a1f..f69c4df143f7 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -647,6 +647,12 @@ static int dsa_user_port_attr_set(struct net_device *dev, const void *ctx,
 
 		ret = dsa_port_bridge_flags(dp, attr->u.brport_flags, extack);
 		break;
+	case SWITCHDEV_ATTR_ID_PORT_MROUTER:
+		if (!dsa_port_offloads_bridge_port(dp, attr->orig_dev))
+			return -EOPNOTSUPP;
+
+		ret = dsa_port_mrouter(dp, attr->u.mrouter, extack);
+		break;
 	case SWITCHDEV_ATTR_ID_VLAN_MSTI:
 		if (!dsa_port_offloads_bridge_dev(dp, attr->orig_dev))
 			return -EOPNOTSUPP;
-- 
2.17.1


