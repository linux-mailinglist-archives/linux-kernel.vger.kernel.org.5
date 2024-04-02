Return-Path: <linux-kernel+bounces-127224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EF6894851
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4F66B2242F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 00:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4ED917C61;
	Tue,  2 Apr 2024 00:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="aqjyypMt";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="YYYCRpde"
Received: from mx0a-000eb902.pphosted.com (mx0a-000eb902.pphosted.com [205.220.165.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6951DF71;
	Tue,  2 Apr 2024 00:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712016779; cv=fail; b=DZ31LtbChjpKPaZUT/c9tMKO2uf6+TYjoaXlvPN/Gu+6VTQk8KcQB34tfh2pLG2j5By2QAZXFMFcZ0mZALJhbVMgoeXT+Ck7tOI7eZwqcMaezCAgudNJ7ID6GbNMsgHaWtRl0DwFw6bFx1dVK2IauBi9u83oz5Xn8bxXLVCYwk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712016779; c=relaxed/simple;
	bh=10LvToiNoXWxfAgBnRbz/Edl1JUEJ/r79jkSYD2FVwk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sYYmFUyQIihXu5OHXCLNpUTfOyO00peHZnX2HgjApYNSyLip11jVr7RvafkBCCx1Xh1B7T8VWt8EO6GFSa6engoq8+LGZBvKXUK6M5txCyxWU2LG3F4br5VGjYkywPyOROtHXbELPeYuOfcNH7NszilNJG4ULou3P7H8LqPSN/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=aqjyypMt; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=YYYCRpde; arc=fail smtp.client-ip=205.220.165.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220295.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 431Ixexh010408;
	Mon, 1 Apr 2024 19:12:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=pps1;
	 bh=gNCJ8QpPM6O7VAMSMFT9c/qqYIMZ719xiz/u8QFWKw0=; b=aqjyypMtuKRL
	cj+E6i7z0pBVKwKxR/jTfnwmJEvebn5nMxRZmy/4TRMlLJfEnOx/ywZemCbm0AO7
	NgCp6+uzd6l4VxQ7MQdy5ebrbR4i60malpiOqRv7UT+gtvfhUKve85rB5aoWKuFT
	ijPGnrasxqgPKt4EwppRM0BgSsLVGWPQSaFbl1FLn+8bKcnTwjrc/XwDEEKcmhYJ
	0pGRJVXQaJ0U9+171qYYglx5osl1YDVZ2J+U1gY1eSXnYniJ8p87hGu3SW2z6odh
	rYul/OdsdkIBrR2aey/LmLVZzd3vk0UKJ0oWWhX1DUGrE/6DIjiXFUKGeQLnae9s
	W898Bf4sHg==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 3x6d6tfyja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 19:12:34 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikImYDA6ZoFnmeBJiX1bQfYozQNYHZuHEYYTMNUV4ZokfcpfbF/RUC/VmokYX+A2cE4RZ29YzEHO2CbubJgBrzgcMf2CvP49liROR90Q8/xPGyFaFjgK3zVYwOfaIxcqaoE9lFnyl9iVY3pA1kiMby/SGPaVf3b9/xSZDp69EUgrG7KHrSUMQoIa6hoeDsibWgRPMmRXXurz/KkZ4JN5k1Y0jWeATx5Nthfwf7nYFTTwo/i2WzDfbeWiyaJLdveeIxPFSAHALHs0XjhXAcUbxt5JyZQNbZeb9Yu2fA8X31bLPtrTOfxSeJt44e1WRydmTzH/6VobSdlUq4MGqOuCdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNCJ8QpPM6O7VAMSMFT9c/qqYIMZ719xiz/u8QFWKw0=;
 b=iCELJA9UAS/20yY4M5L3KRVnKaXu99guG7mYEkSzurC47mlVMErqZ3P0COBEFmhkz0tRKnvntx3bUgO79R29PYE8lZqWC2k/3/dNQyS+Mqv4GZZThQa+ICE6IqxZpuobHt5n3RKEUzNMWspTDzbv1vDtfuiyNxxbOUX7ZuS+GJ5lJ7uW0FZpbRgf1zb0sjgAsvUU2I/rdqRzFYIqGIkTYERnuns/NFwTSUu5230cN7SXfcoR6gYfFTA1slm2z5Kn2hqcte2BrNlEl5yb3X4YKdjqflUrdC2zV4wquHdVQ/ukMlJorOG4FEsFf1V3fpxCcl+KAuv6wXQPVzBBqT3zTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNCJ8QpPM6O7VAMSMFT9c/qqYIMZ719xiz/u8QFWKw0=;
 b=YYYCRpdexR9BJUg0ma9jDED9WwNdxWQhWKBn6HzW3yrKHuSHayrUqBWH2zTZtV9MBpRUaMs4omzf4Pt+SEMCP65zQp2tbj+ts0XSlZWQzoenCJaXoVj8iAP2MkgCqV5IZkgR4Ou4Pt57UHAupcAQhneA38IdxobjdZp4d/0MsYgmVYcQCjigmoxpbO1k5T2ku/mAUN3m5lIMJzzNsdaM85a1f0eKcKOwRkeP9CoaqviZ7ybycPdZlV0NcTR4Ml5UrWbh6REXhuadjww8nkhhLaGOdSj04X3lo43yRYz2zGUJS3lDSR0vrb9l+Q6E2jjSnv7zJ2GO+BeHm+v0cCLzdQ==
Received: from PH7PR10CA0023.namprd10.prod.outlook.com (2603:10b6:510:23d::21)
 by BY5PR04MB6755.namprd04.prod.outlook.com (2603:10b6:a03:22d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 00:12:32 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:510:23d:cafe::1c) by PH7PR10CA0023.outlook.office365.com
 (2603:10b6:510:23d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Tue, 2 Apr 2024 00:12:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.78) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 00:12:31 +0000
Received: from cv1wpa-exmb2.ad.garmin.com (10.5.144.72) by
 olawpa-edge4.garmin.com (10.60.4.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 1 Apr 2024 19:12:24 -0500
Received: from cv1wpa-exmb5.ad.garmin.com (10.5.144.75) by
 CV1WPA-EXMB2.ad.garmin.com (10.5.144.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Mon, 1 Apr 2024 19:12:31 -0500
Received: from kc3wpa-exmb3.ad.garmin.com (10.65.32.83) by
 cv1wpa-exmb5.ad.garmin.com (10.5.144.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.32; Mon, 1 Apr 2024 19:12:30 -0500
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by mail.garmin.com
 (10.65.32.83) with Microsoft SMTP Server id 15.2.1258.32 via Frontend
 Transport; Mon, 1 Apr 2024 19:12:29 -0500
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
Subject: [PATCH RFC net-next 06/10] net: dsa: mv88e6xxx: Track soft bridge objects
Date: Mon, 1 Apr 2024 20:11:05 -0400
Message-ID: <20240402001137.2980589-7-Joseph.Huang@garmin.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|BY5PR04MB6755:EE_
X-MS-Office365-Filtering-Correlation-Id: d54443a5-4cee-4677-ee5f-08dc52a99734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4A7A7ODQP1WO/BWu+GAMf0m9zXKbYJkivs3lYeOvREu6Z5HKHiO5Xi/frpz6dV8Zk1F8ZCLsg1MACl4QJGunBENAZ011UlFsTN7k0cWhMWaTLcptXr6BKJWjiaIYzJIruY6pVWpdMzAjpAIttrKfpKOC+dOJV77h9+Md6NhnT61/ED+myWxLdhCdX6AiTD4/z94WRwA6nqd0KLflX2xFsQERlt/o1PZ26YDpaMoAECIXV6q+NpHIAUzpqp2br7MVnaGu6F/HR8cYif3SXglDMZNJFEc70a1D6V+wjl4VbkRr2Q98k/AJENbKVjIogvNgV7ZW9VdMUZDCF9Vccgz80t5+1wBZIQG8HGTx1oMqOz8RbIGqtpjfWaHL/4IDx7uqHLJK2H2N/Sh/qz2fp5qDm3UL1sHF55nMkKKcOOliPpSQCSNLk3bnNw7FybHk+5ctPKqvp4DbcIgt49sNwVBATtzedz2Mo2H7692RDv+N5rpO2B8yjCft9AJB0s2TrWi1315edFpwVK63LJZqzSeLy9/BMONnx39+aGbqjZ7dRc2yRg3oOfCpKSv3s9BPA53ewt2323YCnz7Ozlyhfsf9CKQxcxfESoOP1rNv9eLH08H38acR4rwN6Na9J8Nqvc5FvyW2XVgLU+jgxHZPp+G+hHCHGlqDCwFbrhbPwop9Q3OgfMg88++2nm/0CN/9veBaQYk4l/O/kaO/pnS7umemof8Bdc5KDMCq8BB/vReBqqXURbnyOMYLTFD5Gvor2UGj
X-Forefront-Antispam-Report: 
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230031)(36860700004)(7416005)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 00:12:31.8609
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d54443a5-4cee-4677-ee5f-08dc52a99734
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6755
X-Proofpoint-GUID: RBxjUKhp5xGS4ZG-fExvbXtiTt-qu37U
X-Proofpoint-ORIG-GUID: RBxjUKhp5xGS4ZG-fExvbXtiTt-qu37U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_17,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 mlxlogscore=945 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2404020000

Keep track of soft bridge objects in the driver.

Since the driver doesn't get explicit notifications about bridge creation
or destruction, just create the bridge data structure when the first port
joins the bridge via mv88e6xxx_port_bridge_join(). Similarly, destroy
the bridge after the last port left the bridge via
mv88e6xxx_port_bridge_leave().

Use the bridge's net_device pointer as the key to the list. Port
information is stored in a bitmask.

Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 85 ++++++++++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/chip.h |  3 ++
 2 files changed, 88 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index fddcb596c421..f66ddde484dc 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -43,6 +43,12 @@
 #include "serdes.h"
 #include "smi.h"
 
+struct mv88e6xxx_bridge {
+	struct list_head head;
+	struct net_device *br_dev;
+	u16 ports;
+};
+
 static void assert_reg_lock(struct mv88e6xxx_chip *chip)
 {
 	if (unlikely(!mutex_is_locked(&chip->reg_lock))) {
@@ -2958,6 +2964,60 @@ static int mv88e6xxx_port_fdb_dump(struct dsa_switch *ds, int port,
 	return err;
 }
 
+static struct mv88e6xxx_bridge *
+mv88e6xxx_bridge_create(struct mv88e6xxx_chip *chip, struct net_device *br_dev)
+{
+	struct mv88e6xxx_bridge *mv_bridge;
+
+	mv_bridge = kzalloc(sizeof(*mv_bridge), GFP_KERNEL);
+	if (!mv_bridge)
+		return ERR_PTR(-ENOMEM);
+
+	mv_bridge->br_dev = br_dev;
+	list_add(&mv_bridge->head, &chip->bridge_list);
+
+	return mv_bridge;
+}
+
+static void mv88e6xxx_bridge_destroy(struct mv88e6xxx_bridge *mv_bridge)
+{
+	list_del(&mv_bridge->head);
+
+	WARN_ON(mv_bridge->ports);
+	kfree(mv_bridge);
+}
+
+static
+struct mv88e6xxx_bridge *mv88e6xxx_bridge_by_dev(struct mv88e6xxx_chip *chip,
+						 const struct net_device *br_dev)
+{
+	struct mv88e6xxx_bridge *mv_bridge;
+
+	list_for_each_entry(mv_bridge, &chip->bridge_list, head)
+		if (mv_bridge->br_dev == br_dev)
+			return mv_bridge;
+
+	return NULL;
+}
+
+static struct mv88e6xxx_bridge *
+mv88e6xxx_bridge_get(struct mv88e6xxx_chip *chip, struct net_device *br_dev)
+{
+	struct mv88e6xxx_bridge *mv_bridge;
+
+	mv_bridge = mv88e6xxx_bridge_by_dev(chip, br_dev);
+	if (!mv_bridge)
+		mv_bridge = mv88e6xxx_bridge_create(chip, br_dev);
+
+	return mv_bridge;
+}
+
+static void mv88e6xxx_bridge_put(struct mv88e6xxx_bridge *mv_bridge)
+{
+	if (!mv_bridge->ports)
+		mv88e6xxx_bridge_destroy(mv_bridge);
+}
+
 static int mv88e6xxx_bridge_map(struct mv88e6xxx_chip *chip,
 				struct dsa_bridge bridge)
 {
@@ -3009,8 +3069,16 @@ static int mv88e6xxx_port_bridge_join(struct dsa_switch *ds, int port,
 				      struct netlink_ext_ack *extack)
 {
 	struct mv88e6xxx_chip *chip = ds->priv;
+	struct mv88e6xxx_bridge *mv_bridge;
 	int err;
 
+	mv_bridge = mv88e6xxx_bridge_get(chip, bridge.dev);
+	if (IS_ERR(mv_bridge))
+		return PTR_ERR(mv_bridge);
+
+	if (mv_bridge->ports & BIT(port))
+		return -EEXIST;
+
 	mv88e6xxx_reg_lock(chip);
 
 	err = mv88e6xxx_bridge_map(chip, bridge);
@@ -3033,6 +3101,8 @@ static int mv88e6xxx_port_bridge_join(struct dsa_switch *ds, int port,
 		*tx_fwd_offload = true;
 	}
 
+	mv_bridge->ports |= BIT(port);
+
 unlock:
 	mv88e6xxx_reg_unlock(chip);
 
@@ -3043,8 +3113,19 @@ static void mv88e6xxx_port_bridge_leave(struct dsa_switch *ds, int port,
 					struct dsa_bridge bridge)
 {
 	struct mv88e6xxx_chip *chip = ds->priv;
+	struct mv88e6xxx_bridge *mv_bridge;
 	int err;
 
+	mv_bridge = mv88e6xxx_bridge_by_dev(chip, bridge.dev);
+	if (!mv_bridge)
+		return;
+
+	if (!(mv_bridge->ports & BIT(port)))
+		return;
+
+	mv_bridge->ports &= ~BIT(port);
+	mv88e6xxx_bridge_put(mv_bridge);
+
 	mv88e6xxx_reg_lock(chip);
 
 	if (bridge.tx_fwd_offload &&
@@ -6436,6 +6517,7 @@ static struct mv88e6xxx_chip *mv88e6xxx_alloc_chip(struct device *dev)
 	INIT_LIST_HEAD(&chip->mdios);
 	idr_init(&chip->policies);
 	INIT_LIST_HEAD(&chip->msts);
+	INIT_LIST_HEAD(&chip->bridge_list);
 
 	return chip;
 }
@@ -7272,6 +7354,9 @@ static void mv88e6xxx_remove(struct mdio_device *mdiodev)
 		mv88e6xxx_g1_irq_free(chip);
 	else
 		mv88e6xxx_irq_poll_free(chip);
+
+	WARN_ON(!list_empty(&chip->bridge_list));
+
 }
 
 static void mv88e6xxx_shutdown(struct mdio_device *mdiodev)
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 85eb293381a7..a32e4564eb3d 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -432,6 +432,9 @@ struct mv88e6xxx_chip {
 
 	/* Bridge MST to SID mappings */
 	struct list_head msts;
+
+	/* software bridges */
+	struct list_head bridge_list;
 };
 
 struct mv88e6xxx_bus_ops {
-- 
2.17.1


