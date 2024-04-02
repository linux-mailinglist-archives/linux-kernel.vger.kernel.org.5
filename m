Return-Path: <linux-kernel+bounces-127225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56181894853
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C19C5B2281A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 00:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7043A1C683;
	Tue,  2 Apr 2024 00:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="tvd8MLjO";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="AfPqKO0I"
Received: from mx0b-000eb902.pphosted.com (mx0b-000eb902.pphosted.com [205.220.177.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1069217C7F;
	Tue,  2 Apr 2024 00:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712016785; cv=fail; b=gHLuP/r7OjAy4M7uQR9oR4PaDQySFkOSZkemvaAkUVmB/iraBmwyttCtdHy6l4pqFOk7q03h/LKu7XwoouK6IMSr032Z+X86WefWksb5PGoQkFV3j0jdA8Lc+avoSDP+5dVBBsSEhgrLeTW8fsGjB2vULos2jtl1UoKlTAKuy0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712016785; c=relaxed/simple;
	bh=Wc73mW7EnGFKOH9xhFC4rNfn4cnTBtDwqBe/JF6WTO4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qq0rj54Lh8OYgxM/3qklY20krzG/svE8Gxz1bljWc0hp5TzVLw+djFWy4FtFEdjGOhw79N/rAU1q6fLcq2WjE4EUXHGopsoB+esv/8SdUdc5wunAtp2JANj4guOJmjyHmil8qimEuDaI2RW3qXf5Fs7Gm0CSFX1jf9TC+vp1Ni4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=tvd8MLjO; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=AfPqKO0I; arc=fail smtp.client-ip=205.220.177.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220297.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 431IxpjL002781;
	Mon, 1 Apr 2024 19:12:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=pps1;
	 bh=mMJgjAePvMZmBF+A9ormyhlsr8Ss5uPilTWqIEI2O+Y=; b=tvd8MLjO5dMt
	G8E8bj6/mC64+idH3j0Rmz0QprIvoGHwpuGSyKwYLUCoi6qr/inIGaaW0ETQAm/N
	stgBxCMQAFj5yBOgBjhK6jQdhk0HPWcsUobkUOCcPeJnnb+xvHoIHTPjX/fpFDgZ
	79K4NaTELt5XAqou40+faT2g6Cg7l0fa+H/S0Xk7Jw4k9B1QVxtSlS8cdBXgFp0p
	WzIy1iYnvu9zUHRLScjScGjD0nbiueIteDGSBIwf50rYDQ+wy9n1B/9ZYP8ULQ+Q
	hD+JgNL+7+R3aLgw6IeAImtZqFdUrzuV5wzdWQ8uVerf0MQoOTAotyHmDvXJpFnc
	agDu60RTXg==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 3x808696h9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 19:12:46 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CjJUIMQzvlgo5rsOG1UkE5itxULbfNTWsf+L7PRMbouELAGBVZcupykWrGA5pJd4uDLYyiizR266tYpX+4h8pHxCjwJaV9fVkjxmxQIQxxazcsUg63wAOBJlft/aqALqBJsribHCx9KhSOZb5WKxhZcuE4cmnztJfdbKg2xhOHvEzzklAKIQUThhT8oTJBn656eXlY+BDdWVj2REyOQ4fWcOkNSYNcxXD9swF47kdyiCGZ+2wKRqlUc6EWxw88su3tM+HI3CVXG+efM8v+lljP8pv2Lb00bhmLaVK2Yujh8bv0ynWzp6lLl4XNwZI9fXHRi2ObULPsnywU94UbrrpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMJgjAePvMZmBF+A9ormyhlsr8Ss5uPilTWqIEI2O+Y=;
 b=JXNWAAURgho2lZ3PVW5TGtMmA9jTLkgoKPKFGcoJhnpSwokHxiVWY6zHX1ri/yQPlZnJGBoA+x7hr7QlM5OjEtM+M1VZqGfZok0p1b5X566osw7grdE8p1a56Yb9DtCr3SF8hx3KqXgFguUdD6h4cmjiU/et8CAIaW9QYFbeyE/otQXaeFaHiA1D7Tx14eYIxNiOoGhVV1vrHJBcm/SjbNTnBMNnU42eD+egE35eFbQtO50DpHMmoJr+fM2lRy67CGEq87Gq7ePu09U+37LwPNchRju72H/rlVCKrAYu2IH0vgip+/OU25UCxsHjmJ9dFLEUiy+U61sXHg4Cf0vTHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMJgjAePvMZmBF+A9ormyhlsr8Ss5uPilTWqIEI2O+Y=;
 b=AfPqKO0IZLdUuYq5scLrWhHVVn5V7JE8Qk5VVhK69Rk2S6kj1fI0lS1Ok730gfEifCxaIsjdqdrAU10oFU7fBKfGlknEOPo9T1zS6iMplO1pWU9kfBCpkpuPSn0XiHv1BPdtfJCPzklRX415Ndt11QAGwPKbuuvsvNgHt1RXN30xqqinjoOfEcXMXloHa/VW1zszmFQ4sBY9An3ExsuipS+dNcq6AWbZT1kyif5QPKdVId22iNzJM2wP513+RrBsR9riTfL0RqmOeKtYJYGf2LGGxTDWijPoPbK9LJ49Wv88OzvwbXfzNX6US4KmhVr79JrSfwSMq3vUPPwUehky8g==
Received: from PH7PR17CA0003.namprd17.prod.outlook.com (2603:10b6:510:324::23)
 by DM6PR04MB7004.namprd04.prod.outlook.com (2603:10b6:5:245::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 00:12:42 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:510:324:cafe::6c) by PH7PR17CA0003.outlook.office365.com
 (2603:10b6:510:324::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Tue, 2 Apr 2024 00:12:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.77) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 00:12:42 +0000
Received: from OLAWPA-EXMB1.ad.garmin.com (10.5.144.23) by
 olawpa-edge4.garmin.com (10.60.4.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 1 Apr 2024 19:12:34 -0500
Received: from cv1wpa-exmb5.ad.garmin.com (10.5.144.75) by
 olawpa-exmb1.ad.garmin.com (10.5.144.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Mon, 1 Apr 2024 19:12:41 -0500
Received: from kc3wpa-exmb3.ad.garmin.com (10.65.32.83) by
 cv1wpa-exmb5.ad.garmin.com (10.5.144.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.32; Mon, 1 Apr 2024 19:12:40 -0500
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by mail.garmin.com
 (10.65.32.83) with Microsoft SMTP Server id 15.2.1258.32 via Frontend
 Transport; Mon, 1 Apr 2024 19:12:39 -0500
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
Subject: [PATCH RFC net-next 09/10] net: dsa: mv88e6xxx: Enable mc flood for mrouter port
Date: Mon, 1 Apr 2024 20:11:08 -0400
Message-ID: <20240402001137.2980589-10-Joseph.Huang@garmin.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|DM6PR04MB7004:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dc8e2b4-5a84-4462-d0e1-08dc52a99d48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	8ijRXn2wR6VV5h88zPUj8FZVMIyktsqRphsNs3tPS6xFISAQfkl48MqDOtCUotmMXoacrAPPWClcBO/xXxUhWFpyS4WYrorQYgOjBNzXT4wHDhOwuc2KrKiirgS1jckKvk8H4sNA7hXgp2QfTdboiI6e1cVxpgFfPCEBGalpzMInuASJd9scA2+PkjHQBzm76vC6VK5J6mNYFVdA/7olpl3PDPTVFZDZLnRfeAvaKdmP2dPsrgm2f3okZoEsQ59YmG8rUyW5eOn6ACPpc2nktw8s7Vzlwsv6Jsbgiypo9i1+hFoCAV5/YXTDKAuuBIvqjGGZYNneFs5RQzfF927JUYO8Lvht0JbubtMjMyjOABW9hiyNjauVaNZvNE+zn4jxWtSJIRSML1agoqbAHR9HaE9YgzEhmtk2fYq6kq8d9lpdhAfTIEpNu+GTvhj40eS2dHRRZU3DRZNPs+n5P5E0i+rbOupQCygflsrBgBxuCLmzqk5GCjvvfNM7ZVctSahlD/Ygsr7t8kp4+V/Kcdt13+gC1+OgfVGNwa/RjMgC9fRKF/l5VrFCer54FzbLVe1eKxTcvqpCW5VshJdEriaILbPfmW06GJ1NzI/PG3Gl2ZmriEFAWpgP7zi20f8+rMT1TqBGXAcoy0dMighjIzbg7pmDBgBKrhMPNxttxE7n4B267/EPKATeMlU2g5/MDhuP5uDjb6/NHEwM8UuoS5/urY8xZxQncfn6HqhBLqvfaFQs1EzVTwtFwDwkXvz1DqpM
X-Forefront-Antispam-Report: 
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(7416005)(36860700004);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 00:12:42.0107
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc8e2b4-5a84-4462-d0e1-08dc52a99d48
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7004
X-Proofpoint-ORIG-GUID: 9AFrCKegaumqDp1-oi1oZPU64ACH3ExY
X-Proofpoint-GUID: 9AFrCKegaumqDp1-oi1oZPU64ACH3ExY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_16,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 impostorscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403210001 definitions=main-2404010168

When a port turns into an mrouter port, enable multicast flooding
on that port even if multicast flooding is disabled by user config. This
is necessary so that in a distributed system, the multicast packets
can be forwarded to the Querier when the multicast source is attached
to a Non-Querier bridge.

Consider the following scenario:

                 +--------------------+
                 |                    |
                 |      Snooping      |    +------------+
                 |      Bridge 1      |----| Listener 1 |
                 |     (Querier)      |    +------------+
                 |                    |
                 +--------------------+
                           |
                           |
                 +--------------------+
                 |    | mrouter |     |
+-----------+    |    +---------+     |
| MC Source |----|      Snooping      |
+-----------|    |      Bridge 2      |
                 |    (Non-Querier)   |
                 +--------------------+

In this scenario, Listener 1 will never receive multicast traffic
from MC Source if multicast flooding is disabled on the mrouter port on
Snooping Bridge 2.

Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 86 ++++++++++++++++++++++++++++++--
 drivers/net/dsa/mv88e6xxx/chip.h |  1 +
 2 files changed, 83 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 32a613c965b1..9831aa370921 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -47,6 +47,7 @@ struct mv88e6xxx_bridge {
 	struct list_head head;
 	struct net_device *br_dev;
 	u16 ports;
+	u16 mrouter_ports;
 	struct list_head br_mdb_list;
 };
 
@@ -2993,6 +2994,7 @@ static void mv88e6xxx_bridge_destroy(struct mv88e6xxx_bridge *mv_bridge)
 	list_del(&mv_bridge->head);
 
 	WARN_ON(mv_bridge->ports);
+	WARN_ON(mv_bridge->mrouter_ports);
 	WARN_ON(!list_empty(&mv_bridge->br_mdb_list));
 	kfree(mv_bridge);
 }
@@ -3010,6 +3012,19 @@ struct mv88e6xxx_bridge *mv88e6xxx_bridge_by_dev(struct mv88e6xxx_chip *chip,
 	return NULL;
 }
 
+static
+struct mv88e6xxx_bridge *mv88e6xxx_bridge_by_port(struct mv88e6xxx_chip *chip,
+						  int port)
+{
+	struct mv88e6xxx_bridge *mv_bridge;
+
+	list_for_each_entry(mv_bridge, &chip->bridge_list, head)
+		if (mv_bridge->ports & BIT(port))
+			return mv_bridge;
+
+	return NULL;
+}
+
 static struct mv88e6xxx_bridge *
 mv88e6xxx_bridge_get(struct mv88e6xxx_chip *chip, struct net_device *br_dev)
 {
@@ -6849,11 +6864,28 @@ static int mv88e6xxx_port_bridge_flags(struct dsa_switch *ds, int port,
 
 	if (flags.mask & BR_MCAST_FLOOD) {
 		bool multicast = !!(flags.val & BR_MCAST_FLOOD);
+		struct mv88e6xxx_bridge *mv_bridge;
+		struct mv88e6xxx_port *p;
+		bool mrouter;
 
-		err = chip->info->ops->port_set_mcast_flood(chip, port,
-							    multicast);
-		if (err)
-			goto out;
+		mv_bridge = mv88e6xxx_bridge_by_port(chip, port);
+		if (!mv_bridge)
+			return -EINVAL;
+
+		p = &chip->ports[port];
+		mrouter = !!(mv_bridge->mrouter_ports & BIT(port));
+
+		if (!mrouter) {
+			err = chip->info->ops->port_set_mcast_flood(chip, port,
+								    multicast);
+			if (err)
+				goto out;
+		}
+
+		if (multicast)
+			p->flags |= MV88E6XXX_PORT_FLAG_MC_FLOOD;
+		else
+			p->flags &= ~MV88E6XXX_PORT_FLAG_MC_FLOOD;
 	}
 
 	if (flags.mask & BR_BCAST_FLOOD) {
@@ -6883,6 +6915,51 @@ static int mv88e6xxx_port_bridge_flags(struct dsa_switch *ds, int port,
 	return err;
 }
 
+static int mv88e6xxx_port_mrouter(struct dsa_switch *ds, int port,
+				  bool mrouter,
+				  struct netlink_ext_ack *extack)
+{
+	struct mv88e6xxx_chip *chip = ds->priv;
+	struct mv88e6xxx_bridge *mv_bridge;
+	struct mv88e6xxx_port *p;
+	bool old_mrouter;
+	bool mc_flood;
+	int err;
+
+	if (!chip->info->ops->port_set_mcast_flood)
+		return -EOPNOTSUPP;
+
+	mv_bridge = mv88e6xxx_bridge_by_port(chip, port);
+	if (!mv_bridge)
+		return -EINVAL;
+
+	old_mrouter = !!(mv_bridge->mrouter_ports & BIT(port));
+	if (mrouter == old_mrouter)
+		return 0;
+
+	p = &chip->ports[port];
+	mc_flood = !!(p->flags & MV88E6XXX_PORT_FLAG_MC_FLOOD);
+
+	mv88e6xxx_reg_lock(chip);
+
+	if (!mc_flood) {
+		err = chip->info->ops->port_set_mcast_flood(chip, port,
+							    mrouter);
+		if (err)
+			goto out;
+	}
+
+	if (mrouter)
+		mv_bridge->mrouter_ports |= BIT(port);
+	else
+		mv_bridge->mrouter_ports &= ~BIT(port);
+
+out:
+	mv88e6xxx_reg_unlock(chip);
+
+	return err;
+}
+
 static bool mv88e6xxx_lag_can_offload(struct dsa_switch *ds,
 				      struct dsa_lag lag,
 				      struct netdev_lag_upper_info *info,
@@ -7199,6 +7276,7 @@ static const struct dsa_switch_ops mv88e6xxx_switch_ops = {
 	.port_bridge_leave	= mv88e6xxx_port_bridge_leave,
 	.port_pre_bridge_flags	= mv88e6xxx_port_pre_bridge_flags,
 	.port_bridge_flags	= mv88e6xxx_port_bridge_flags,
+	.port_mrouter		= mv88e6xxx_port_mrouter,
 	.port_stp_state_set	= mv88e6xxx_port_stp_state_set,
 	.port_mst_state_set	= mv88e6xxx_port_mst_state_set,
 	.port_fast_age		= mv88e6xxx_port_fast_age,
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 205f6777c2ac..47e056dc7925 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -274,6 +274,7 @@ struct mv88e6xxx_vlan {
 
 /* MacAuth Bypass Control Flag */
 #define MV88E6XXX_PORT_FLAG_MAB		BIT(0)
+#define MV88E6XXX_PORT_FLAG_MC_FLOOD	BIT(1)
 
 struct mv88e6xxx_port {
 	struct mv88e6xxx_chip *chip;
-- 
2.17.1


