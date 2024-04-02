Return-Path: <linux-kernel+bounces-127223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06179894850
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B04CF284080
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 00:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88FD17C64;
	Tue,  2 Apr 2024 00:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="eWIGWjzH";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="EspMfqjt"
Received: from mx0b-000eb902.pphosted.com (mx0b-000eb902.pphosted.com [205.220.177.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFC08BE5;
	Tue,  2 Apr 2024 00:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712016779; cv=fail; b=VL5O7R7eqZQrudpD8GTjmwN8h3rsv8kOQE8nTVS2ujR5OecpRcNPH59uKzoqcykraFrIouhr01bNfqz4zRiUOZlEpc6bQrx7VXLexXzmfKLNQNbR53jC4M5VSF7681fdQw/0UIR/V8bPtO382kfINx6Vay4e2IGTx8+QdG5wivo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712016779; c=relaxed/simple;
	bh=TQJufkiN6+FwmkxY8Kc9C6WhsreIiFsobupB1QMJ8Xg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tmOTBtz0Yodri2zXVlziAOdzSZAt+S/OF4AnzJxaNNoe/6iil5o42/ZlIcUbg1wX60TqEEIlge6mGLNvi0UQjBbqTv9RSIqCKYGNQy6EqhFP/FylFOYBnBhHbCvqePxDkaqYSHLBY8Fc4Qy5IV75Pz4qd5v0mFCNVS4B84WN83E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=eWIGWjzH; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=EspMfqjt; arc=fail smtp.client-ip=205.220.177.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220297.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 431J0Gf0003286;
	Mon, 1 Apr 2024 19:12:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=pps1;
	 bh=hl9b1s+/NgfLZDUBljKqbssQp7LoQo+naDmi0MKelYk=; b=eWIGWjzHtQmL
	cFar6bxeRW8zxdjRkgN15td/HRkHgZUPzYyAGlP6UUygX+QzqZRQf+6CrT+zlm5X
	9Cifel910yUeCMr4fNzXz4cQAK+h82PLMbb6dppOMJNZEdpzR12c6ZwzJ/zQFVMu
	wk+pih4PykC9greRr9HBLeIT39asf5B/23imyMlMZ17kL/uZjZb2lD1uofa0oBXO
	DzzL5Qlmy1EIPdy1l+1vym90/DiJzDhZpMSRo+1V8sNSAI6vP+y3yxvqNbo4Y2ti
	luApv/SjAHHR12RLf46r2SaFRcS6Br4TQ5X/vtM/fmys9DwzKbS32zyclwOE6EAb
	mcKfIfM8Zg==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 3x808696h3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 19:12:37 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVWlbziF7wBdm57bymx/EU88idFIonUmMyDehskJA2N2PpI0X4EEYcM3L8BDrBPcRTK7EtL99+anPlTl/6TwHXrjHt4g4ITv4jmn0zGB92RXCedm1mi5tWh41xuBhbVNSODpUP/j2um5v9QMdyPAhLxoyLEOU0cvhAXJ5CqWIY1Pzyjb4VLA27S/4CKke/o47FAf1FrwLvJD3c0blHA5X3ElG8oO6SIxUj8mCmph/ZmQ9WZcnMpKLhDID7DBcr56ktn6kO6P7ngxhA3GInYn4ez52JC4ju5ZKAJ71r78epdRbmEaD8GMOEmDE6RF3l+ADEL1xGDJhJ9JqoyxNuWcRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hl9b1s+/NgfLZDUBljKqbssQp7LoQo+naDmi0MKelYk=;
 b=RlmmPRsinliGR+K1AbJZHLnJjvJEvRFb3GPJE+PWc9evYqbJbuFAeZFZk8IrQyAGKxrkvovQvbzf1i6K+UhFPkQdYo4CbFXOYgEYMgsBaxmStY65ehpQT9tWgW5yyRF9R0fH9/Wx8qC8OJCQX5lRwFx5AOCjZRmqKiAGJqS07LU4QVcoxWzSsWbwLb+qXgQ61+3TSQUHZGK4AWJyiUg+VB2nl7mxrP80Lr+vGFrUzh5cqhCRP1qhSEjnN1EFBZQRg2X7s1zbNI7zDaY37QoGUd+54CRI8zSkYIE+d6EXLCe3rmdWTG/IJzL741LnIm2kBtd518vv0B4gLHjhMhb2xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hl9b1s+/NgfLZDUBljKqbssQp7LoQo+naDmi0MKelYk=;
 b=EspMfqjtCAcTHpW7LiRlmWKhU5PJMh3mMlk7XB8iTy/ycmP43HFOoxwr86NHCX9Qmn7ZU/H+OriD0VC+CRzix12kG7cAuulAWfDdgdcOgIuyBKyP6W+lzREsfOjGRT9rijou6xdKqvsIYZcky2dYYnnR5xh823tGXsOag//kuqplUDh/EJyFuwfrISWcE/u19dCLJkYNs9lCx9eFJalVUVu3ep7xhkcArUUDaKGln7M6cKryifalZE+gRqe0N2/XYdCqs3KyXq/sbUHFL46Q+tkMD8UmwnddmsdF0ylerQrWRkbmL6vrNGwgdAZdxZ3dUIoe4L8yKfutkmg9WpMINQ==
Received: from DM6PR08CA0057.namprd08.prod.outlook.com (2603:10b6:5:1e0::31)
 by CH0PR04MB8097.namprd04.prod.outlook.com (2603:10b6:610:f5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 00:12:35 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:5:1e0:cafe::3b) by DM6PR08CA0057.outlook.office365.com
 (2603:10b6:5:1e0::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Tue, 2 Apr 2024 00:12:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.81) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 00:12:35 +0000
Received: from cv1wpa-exmb3.ad.garmin.com (10.5.144.73) by
 olawpa-edge4.garmin.com (10.60.4.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 1 Apr 2024 19:12:27 -0500
Received: from cv1wpa-exmb5.ad.garmin.com (10.5.144.75) by
 cv1wpa-exmb3.ad.garmin.com (10.5.144.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.37; Mon, 1 Apr 2024 19:12:34 -0500
Received: from kc3wpa-exmb3.ad.garmin.com (10.65.32.83) by
 cv1wpa-exmb5.ad.garmin.com (10.5.144.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.32; Mon, 1 Apr 2024 19:12:33 -0500
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by mail.garmin.com
 (10.65.32.83) with Microsoft SMTP Server id 15.2.1258.32 via Frontend
 Transport; Mon, 1 Apr 2024 19:12:33 -0500
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
Subject: [PATCH RFC net-next 07/10] net: dsa: mv88e6xxx: Track bridge mdb objects
Date: Mon, 1 Apr 2024 20:11:06 -0400
Message-ID: <20240402001137.2980589-8-Joseph.Huang@garmin.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|CH0PR04MB8097:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f99e027-0c30-4414-40a3-08dc52a99922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	XrFxhwE7FssqrLjnrBO/JoatIlbvZdqyXy8xR7zDKCpo76Witkn/pYlv+jIXYlPVRrnLuLk5GsbrRQVyNU4xCR44O1TGOp9fDzcYf+yKzKAlAgke2udMq8ykHug+DGed1priQ51w0Tw2qsxPNPZUvMjNnGD/B4ysqtr7+IswbNSKOcPV7OlBynflW4DSjUJc+iAsi0FwVT8/EXfNXzD5grCOCxLSCXxMIL+lpdGE5oP/Df8EjgoVTIr8l8TYxSkRu8aodh1yJ0Mp86+PU8yJgyrtAnjE+kLEdevMtIy2rO7KY4k7jUZqbwJ668g4ePWlf3I+Ta1qPVopnjANH7fgF/WmJ0wqvyYQOHn3/uqok3siBztyGW09KbDvFTyYfjyZL2qxMy8U2pUpJU0bNY4DTgAoR1wN4LRR69Z/8L1GqngoqKIDG0HbGUIXVDcNNoYtEmfgNm8XygpNkYm52prz/0UL7q3jNOWqPfUvDLxuImnXOZUmyyCLhs5eeoZoFqKgdlM/FYLeN56Ocmpdwpi638txID+Qkx169aVhWsYjl5l9gpIB5el1vmTWHmbZ9Y/zJvwnDzuu3+cVjNlycx/rH00ehlPIMiYnjvFzuDVEktu7LL8Gi51b6XM7H6pcosyUNkfCBFAg7tOzHDyAKF4vpGivOs5vqPYUbqCXas0Rfg3vZQEazG7jq7IJaDBT66T0eSxhRRtRP+hVHNzmctXLjdUMLpRaG6PXz93NcudaHbxWLCR+SRHKY4HBgAfS+Je0
X-Forefront-Antispam-Report: 
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230031)(7416005)(376005)(82310400014)(36860700004)(1800799015);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 00:12:35.0939
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f99e027-0c30-4414-40a3-08dc52a99922
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8097
X-Proofpoint-ORIG-GUID: nHpMqpoJ1mrr7prrOOz8KxzvLv56tl-q
X-Proofpoint-GUID: nHpMqpoJ1mrr7prrOOz8KxzvLv56tl-q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_16,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 impostorscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403210001 definitions=main-2404010168

Keep track of bridge mdb objects in the driver.

Similar to the previous patch, since the driver doesn't get explicit
notifications about mdb group creation or destruction, just create
the mdb group when the first port joins the group via
mv88e6xxx_port_mdb_add(), and destroys the group when the last port left
the group via mv88e6xxx_port_mdb_del().

Use the group's L2 address together with the VLAN ID as the key to the list.
Port membership is again stored in a bitmask.

Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 117 +++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index f66ddde484dc..32a613c965b1 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -47,6 +47,14 @@ struct mv88e6xxx_bridge {
 	struct list_head head;
 	struct net_device *br_dev;
 	u16 ports;
+	struct list_head br_mdb_list;
+};
+
+struct mv88e6xxx_br_mdb {
+	struct list_head head;
+	unsigned char addr[ETH_ALEN];
+	u16 vid;
+	u16 portvec;
 };
 
 static void assert_reg_lock(struct mv88e6xxx_chip *chip)
@@ -2974,6 +2982,7 @@ mv88e6xxx_bridge_create(struct mv88e6xxx_chip *chip, struct net_device *br_dev)
 		return ERR_PTR(-ENOMEM);
 
 	mv_bridge->br_dev = br_dev;
+	INIT_LIST_HEAD(&mv_bridge->br_mdb_list);
 	list_add(&mv_bridge->head, &chip->bridge_list);
 
 	return mv_bridge;
@@ -2984,6 +2993,7 @@ static void mv88e6xxx_bridge_destroy(struct mv88e6xxx_bridge *mv_bridge)
 	list_del(&mv_bridge->head);
 
 	WARN_ON(mv_bridge->ports);
+	WARN_ON(!list_empty(&mv_bridge->br_mdb_list));
 	kfree(mv_bridge);
 }
 
@@ -6583,16 +6593,101 @@ static int mv88e6xxx_change_tag_protocol(struct dsa_switch *ds,
 	return err;
 }
 
+static struct mv88e6xxx_br_mdb *
+mv88e6xxx_br_mdb_create(struct mv88e6xxx_bridge *mv_bridge,
+			const struct switchdev_obj_port_mdb *mdb)
+{
+	struct mv88e6xxx_br_mdb *mv_br_mdb;
+
+	mv_br_mdb = kzalloc(sizeof(*mv_br_mdb), GFP_KERNEL);
+	if (!mv_br_mdb)
+		return ERR_PTR(-ENOMEM);
+
+	ether_addr_copy(mv_br_mdb->addr, mdb->addr);
+	mv_br_mdb->vid = mdb->vid;
+	list_add(&mv_br_mdb->head, &mv_bridge->br_mdb_list);
+
+	return mv_br_mdb;
+}
+
+static void mv88e6xxx_br_mdb_destroy(struct mv88e6xxx_br_mdb *mv_br_mdb)
+{
+	list_del(&mv_br_mdb->head);
+
+	WARN_ON(mv_br_mdb->portvec);
+	kfree(mv_br_mdb);
+}
+
+static struct mv88e6xxx_br_mdb *
+mv88e6xxx_br_mdb_find(struct mv88e6xxx_bridge *mv_bridge,
+		      const struct switchdev_obj_port_mdb *mdb)
+{
+	struct mv88e6xxx_br_mdb *mv_br_mdb;
+
+	list_for_each_entry(mv_br_mdb, &mv_bridge->br_mdb_list, head)
+		if (ether_addr_equal(mv_br_mdb->addr, mdb->addr) &&
+		    mv_br_mdb->vid == mdb->vid)
+			return mv_br_mdb;
+
+	return NULL;
+}
+
+static struct mv88e6xxx_br_mdb *
+mv88e6xxx_br_mdb_get(struct mv88e6xxx_bridge *mv_bridge,
+		     const struct switchdev_obj_port_mdb *mdb)
+{
+	struct mv88e6xxx_br_mdb *mv_br_mdb;
+
+	mv_br_mdb = mv88e6xxx_br_mdb_find(mv_bridge, mdb);
+	if (!mv_br_mdb)
+		mv_br_mdb = mv88e6xxx_br_mdb_create(mv_bridge, mdb);
+
+	return mv_br_mdb;
+}
+
+static void mv88e6xxx_br_mdb_put(struct mv88e6xxx_br_mdb *mv_br_mdb)
+{
+	if (!mv_br_mdb->portvec)
+		mv88e6xxx_br_mdb_destroy(mv_br_mdb);
+}
+
 static int mv88e6xxx_port_mdb_add(struct dsa_switch *ds, int port,
 				  const struct switchdev_obj_port_mdb *mdb,
 				  struct dsa_db db)
 {
 	struct mv88e6xxx_chip *chip = ds->priv;
+	struct mv88e6xxx_bridge *mv_bridge;
+	struct mv88e6xxx_br_mdb *mv_br_mdb;
+	struct net_device *orig_dev;
+	struct net_device *br_dev;
 	int err;
 
+	orig_dev = mdb->obj.orig_dev;
+	br_dev = netdev_master_upper_dev_get(orig_dev);
+	if (!br_dev)
+		br_dev = orig_dev;
+
+	mv_bridge = mv88e6xxx_bridge_by_dev(chip, br_dev);
+	if (!mv_bridge)
+		return -EINVAL;
+
+	mv_br_mdb = mv88e6xxx_br_mdb_get(mv_bridge, mdb);
+	if (IS_ERR(mv_br_mdb))
+		return PTR_ERR(mv_br_mdb);
+
+	if (mv_br_mdb->portvec & BIT(port))
+		return -EEXIST;
+
 	mv88e6xxx_reg_lock(chip);
 	err = mv88e6xxx_port_db_load_purge(chip, port, mdb->addr, mdb->vid,
 					   MV88E6XXX_G1_ATU_DATA_STATE_MC_STATIC);
+
+	if (err)
+		goto out;
+
+	mv_br_mdb->portvec |= BIT(port);
+
+out:
 	mv88e6xxx_reg_unlock(chip);
 
 	return err;
@@ -6603,10 +6698,32 @@ static int mv88e6xxx_port_mdb_del(struct dsa_switch *ds, int port,
 				  struct dsa_db db)
 {
 	struct mv88e6xxx_chip *chip = ds->priv;
+	struct mv88e6xxx_bridge *mv_bridge;
+	struct mv88e6xxx_br_mdb *mv_br_mdb;
+	struct net_device *orig_dev;
+	struct net_device *br_dev;
 	int err;
 
+	orig_dev = mdb->obj.orig_dev;
+	br_dev = netdev_master_upper_dev_get(orig_dev);
+	if (!br_dev)
+		br_dev = orig_dev;
+
+	mv_bridge = mv88e6xxx_bridge_by_dev(chip, br_dev);
+	if (!mv_bridge)
+		return -EINVAL;
+
+	mv_br_mdb = mv88e6xxx_br_mdb_find(mv_bridge, mdb);
+	if (!mv_br_mdb)
+		return -ENOENT;
+
+	if (!(mv_br_mdb->portvec & BIT(port)))
+		return -ENOENT;
+
 	mv88e6xxx_reg_lock(chip);
 	err = mv88e6xxx_port_db_load_purge(chip, port, mdb->addr, mdb->vid, 0);
+	mv_br_mdb->portvec &= ~BIT(port);
+	mv88e6xxx_br_mdb_put(mv_br_mdb);
 	mv88e6xxx_reg_unlock(chip);
 
 	return err;
-- 
2.17.1


