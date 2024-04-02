Return-Path: <linux-kernel+bounces-127226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01622894855
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA52A284B7A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 00:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C56C29428;
	Tue,  2 Apr 2024 00:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="BrZtose8";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="Nq/vjVmH"
Received: from mx0a-000eb902.pphosted.com (mx0a-000eb902.pphosted.com [205.220.165.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C198BE5;
	Tue,  2 Apr 2024 00:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712016790; cv=fail; b=ZzKDpU0WBu3GlPEbTWTbbcDSmZJqXJl0QJD1oY7Av1nf5jmR1oB+iI+cyOPsZoQ/BaDhRRTdfOz4FWFPDXIL2lHfX3f5xeFWKuy+oC0XPcaB72gWibkqVBZDiCrtfNec0/0+KcQVO48L56wGYHK1rbNFlkmjI8eG4F8mZV85JuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712016790; c=relaxed/simple;
	bh=d5S34E/iXzM43tARvSbiaNhoyfF8l5I8oWBQHnKRCkM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mFrXV9Mng1JRBneIAzQ5UTeYk+0qBjAVGw+RKMlv8d2aR0Pg/YA2URASQ/z8D4ZGAm0FJ+2Odo8EPFXEO35o7v2SMM4Ry7No+8kyHE2qM7GnOFddRDYTqnEkpyT/tiXqEwq+NlQb4xaVGa1J5ROR9BYfjWxa0Lsgyn//aZpQzd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=BrZtose8; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=Nq/vjVmH; arc=fail smtp.client-ip=205.220.165.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220296.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 431IxgfX023122;
	Mon, 1 Apr 2024 19:12:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=pps1;
	 bh=hLplZnSuUkFYB855mcaK/aOKAKXTOkfxg/5K7XfhhUE=; b=BrZtose82gMH
	JuVwK63caSknRsyytO9873027JNQIkknVKlxJc49J/KnIfyykACq+MwAyhCzmoxt
	Mapa+khM7nKmwikod/ycPyJ+OBY6mQM+t1xYJoUlJQLX/P9xvLVWZ1kFTRraOekO
	Vn6oML8hlra9xa2U81m7dgFtC2pqP32UpSxlx1YTN7mslVP4GZSGNA0Zsw9KV2qi
	Xwh3m6feAA9dU8sFxwDkLXXLxLrgA5BXnIBkSH6rNhHV3GT+bEnRifSZAGW7li54
	7F4ry7kL/E5KSPerU2hQTKz7KFYL/mL9XTw6wElXICnHvtk0Gx2ukZ6yyavpz6mT
	vljQxuVTVA==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 3x6g44qfce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 19:12:49 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KlfCv64nN/xzh++GZ/IbJgf4+3ecc0JmeJt0z6i0OfA7fbeKf+b3wTtmy+I3MOvq1Sx7sg9KXjnihHNLgergct54Bg1bDRitQR//WP9cfAtWw8FFI+6rflPevFGHZSNfZTtFR+v2NNyOKZFvFxLTAu6J9LhQNz3BRB0POuRWLFK36s5qkf3RstTOQ/Fbh9JRFhCZuQ7TCL4JF+U5cxcRESydaRKP7nUF34WHNBd4KFWhgG3HwRk9uQD2bIBbuM23i1MlFVFmebXUVp+EVQl5kq48e6oQ0Y8APiC/whFdHqIMjnQsXUB6jo/kHa7yDLQ42cWu/k4/LeKGV2KVNTdenA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLplZnSuUkFYB855mcaK/aOKAKXTOkfxg/5K7XfhhUE=;
 b=LYymD/8z+H9bwbemBrbpdztDya2VCSG5i4nI8IV7zPsTSyT7KhZTzVjKHedzMAp3K0/UJeklh5PqcUsQYqUf7sAsnjid3VLEk3TE3wtIcB/i2WV6Ce4hGf1SlI5cegYkbtup0MRpwzckKkgt6hcoa4k9PnDtbTuyqqCW9aMv18VvFEtHevBN0lWrMWn33GltpOGYzAY+xRu1T785/n13OFciqDj1RPFxaeUF3jyivS3g3rNc7jlL8c2X6BFCQet2Up6XP9iuEUtZtZiU578YVpw4izaGorG0XB2P7d4mYQ2p0o39w1NjYBypRYUefEapPksogEdR9T8I/Kct4xbFvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLplZnSuUkFYB855mcaK/aOKAKXTOkfxg/5K7XfhhUE=;
 b=Nq/vjVmHfYf50gEe8YJDKBdy3rYWJygOrOhTdZX652bZ0zR9mqXbFGu/RLlZR/qqYLiLwFXQ3IkavPx6Ei+FN6PQBy2EJw2TdmzshdWDQGOageKkUVcfQDG/xnOsEFDl+m2ulzaDJpAT1OaZh078TP67hiLlbyq1JDjPd/giTAkdKq1IOolBUGhiippf33sZkvgJJN6U30U6acWo/qc7Tb1mnJJq/5oqmTtfTdkF9JaI+ch1H9tf2zvW9ghWhze/K1uN5mUAHtkHT1YoRYGv3Q4LNiY6jPBmMcnSroga3DCeogTgho4OHIdDwBm7ynOAmwVIAzm00AqSMijvz4ZziQ==
Received: from CH2PR08CA0009.namprd08.prod.outlook.com (2603:10b6:610:5a::19)
 by SJ0PR04MB7744.namprd04.prod.outlook.com (2603:10b6:a03:32e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 00:12:47 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:5a:cafe::25) by CH2PR08CA0009.outlook.office365.com
 (2603:10b6:610:5a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Tue, 2 Apr 2024 00:12:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.0 via Frontend Transport; Tue, 2 Apr 2024 00:12:47 +0000
Received: from OLAWPA-EXMB12.ad.garmin.com (10.5.144.16) by
 olawpa-edge1.garmin.com (10.60.4.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 1 Apr 2024 19:12:36 -0500
Received: from cv1wpa-exmb5.ad.garmin.com (10.5.144.75) by
 OLAWPA-EXMB12.ad.garmin.com (10.5.144.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Mon, 1 Apr 2024 19:12:45 -0500
Received: from kc3wpa-exmb3.ad.garmin.com (10.65.32.83) by
 cv1wpa-exmb5.ad.garmin.com (10.5.144.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.32; Mon, 1 Apr 2024 19:12:44 -0500
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by mail.garmin.com
 (10.65.32.83) with Microsoft SMTP Server id 15.2.1258.32 via Frontend
 Transport; Mon, 1 Apr 2024 19:12:43 -0500
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
Subject: [PATCH RFC net-next 10/10] net: dsa: mv88e6xxx: Offload mrouter port
Date: Mon, 1 Apr 2024 20:11:09 -0400
Message-ID: <20240402001137.2980589-11-Joseph.Huang@garmin.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|SJ0PR04MB7744:EE_
X-MS-Office365-Filtering-Correlation-Id: acdae5a1-2fdc-4f7c-1289-08dc52a9a049
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	pQuscw4fHJaKklmvZYr7oaVf8CgfhQJD78w6urgU6SVD2pnkvZBAQxntaxF6ZltRLQtllrFVrK0Z701tfwsxchyF4KPhLaY/LfrNpllG4+67gUVcTQ00Pc68ceS5bPcn30dEwnbw3KDndvanGVvkVddhoQ6f2daydj87BYsz6Rsmf6S8ydYr/tgt7HSQ9g+tFnlbiXab33fJ6Z8AzyfaQaAw4pUwOv7VnCsMeGDjgasNRvwzvUfQqZUMtKw1jOr7OP6Eq1D8Ce8ao3wLEh9/ITaQ8txCT/NrMAEW33J3akxXWV//lvV3sfhTEU8+koUSIJRoEPVVMt4vbYhlhF8pqHhM41rBBiUDf6na5FuVA7wR5VHv0SIhPb7tgucXl+lXaH9JlLsjFizbikvPpxUnE/7UV1PWWaF+iul6CAkVkVj4Zj/V7mJyt1lhdL1pcu6YGq1thOGdR8UgIw20RzaioKjgZ31LcL8ZTgLBX+jv5EXSYX99cUpuGZlGP8Atmm9OmEfnW4qO5G1tqIzqPJBwtmeQTgZECNzk52mVyE9/U3OBt24TKjrntNWqLq7CL4I3c/3l8luj9ZTzaGoLzccltQpjVI536M7DukG9Jd+ulHRLG5wEY3BKOqLHUMane43HQJ3wdbZ+en5OQ7RAkzV9+a0wfJSVqxFZKXPvLdfctF2vs1HFKUTESKZKml11n0Ro+F2uw4zwWiEE0cw8pC83KE/oieIwQvJViaQ+Xe7h/m4/Hg4vWg2lePpk4aBM6MWT
X-Forefront-Antispam-Report: 
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(7416005)(376005)(1800799015);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 00:12:47.0768
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acdae5a1-2fdc-4f7c-1289-08dc52a9a049
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7744
X-Proofpoint-GUID: z5TMBgS6yqwOLReJtOEv4nMEwdA-lVFd
X-Proofpoint-ORIG-GUID: z5TMBgS6yqwOLReJtOEv4nMEwdA-lVFd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_17,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 priorityscore=1501 phishscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404020000

Offload mrouter port forwarding to mv88e6xxx.

Currently multicast snooping fails to forward traffic in some cases
where there are multiple hardware-offloading bridges involved.

Consider the following scenario:

                 +--------------------+
                 |                    |
                 |      Snooping   +--|    +------------+
                 |      Bridge 1   |P1|----| Listener 1 |
                 |     (Querier)   +--|    +------------+
                 |                    |
                 +--------------------+
                           |
                           |
                 +--------------------+
                 |    | mrouter |     |
+-----------+    |    +---------+  +--|    +------------+
| MC Source |----|      Snooping   |P2|----| Listener 2 |
+-----------|    |      Bridge 2   +--|    +------------+
                 |    (Non-Querier)   |
                 +--------------------+

In this scenario, Listener 2 is able to receive multicast traffic from
MC Source while Listener 1 is not. The reason is that on Snooping
Bridge 2, when the (soft) bridge attempts to forward a packet to
the mrouter port via br_multicast_flood(), the effort is blocked by
nbp_switchdev_allowed_egress(), since offload_fwd_mark indicates that
the packet should have been handled by the hardware already. Listener 2
would receive the packets without any problem since P2 is programmed unto
the switch chip as a member of the group; however, the mrouter port
would not since the mrouter port would normally not be a member of any
group, and thus will not be added to the address database on the switch
chip of Snooping Bridge 2.

Even if nbp_switchdev_allowed_egress() did not block the forwarding,
it would still be better to offload the forwarding to the switch
rather than letting the bridge handle the forwarding in software.

Before this patch, mv88e6xxx programming matches exactly with mdb:

 +-----+
 | mdb |
 +-----+
    |
 +----------------------------------------------+
 |  |        +--------------------------------+ |
 |  |        | both in mdb and mv88e6xxx      | |
 |  |        | +------+   +------+   +------+ | |
 |  +--------|-| port |---| port |---| port | | |
 |           | +------+   +------+   +------+ | |
 | mv88e6xxx +--------------------------------+ |
 +----------------------------------------------+

After this patch, some entries will only exist in mv88e6xxx and not
in mdb:

 +-----+
 | mdb |
 +-----+
    |
 +---------------------------------------------------------------------+
 |  |        +--------------------------------++---------------------+ |
 |  |        |  both in mdb and mv88e6xxx     ||  only in mv88e6xxx  | |
 |  |        | +------+   +------+   +------+ || +------+   +------+ | |
 |  +--------|-| port |---| port |---| port |-||-|  mr  |---|  mr  | | |
 |           | +------+   +------+   +------+ || +------+   +------+ | |
 | mv88e6xxx +--------------------------------++---------------------+ |
 +---------------------------------------------------------------------+

Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 104 ++++++++++++++++++++++++++++---
 1 file changed, 94 insertions(+), 10 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 9831aa370921..ab519e4d9e4f 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -2194,13 +2194,10 @@ mv88e6xxx_port_vlan_prepare(struct dsa_switch *ds, int port,
 	return err;
 }
 
-static int mv88e6xxx_port_db_load_purge(struct mv88e6xxx_chip *chip, int port,
-					const unsigned char *addr, u16 vid,
-					u8 state)
+static int mv88e6xxx_fid_from_vid(struct mv88e6xxx_chip *chip, u16 vid,
+				  u16 *fid)
 {
-	struct mv88e6xxx_atu_entry entry;
 	struct mv88e6xxx_vtu_entry vlan;
-	u16 fid;
 	int err;
 
 	/* Ports have two private address databases: one for when the port is
@@ -2211,7 +2208,7 @@ static int mv88e6xxx_port_db_load_purge(struct mv88e6xxx_chip *chip, int port,
 	 * VLAN ID into the port's database used for VLAN-unaware bridging.
 	 */
 	if (vid == 0) {
-		fid = MV88E6XXX_FID_BRIDGED;
+		*fid = MV88E6XXX_FID_BRIDGED;
 	} else {
 		err = mv88e6xxx_vtu_get(chip, vid, &vlan);
 		if (err)
@@ -2221,9 +2218,24 @@ static int mv88e6xxx_port_db_load_purge(struct mv88e6xxx_chip *chip, int port,
 		if (!vlan.valid)
 			return -EOPNOTSUPP;
 
-		fid = vlan.fid;
+		*fid = vlan.fid;
 	}
 
+	return 0;
+}
+
+static int mv88e6xxx_port_db_load_purge(struct mv88e6xxx_chip *chip, int port,
+					const unsigned char *addr, u16 vid,
+					u8 state)
+{
+	struct mv88e6xxx_atu_entry entry;
+	u16 fid;
+	int err;
+
+	err = mv88e6xxx_fid_from_vid(chip, vid, &fid);
+	if (err)
+		return err;
+
 	entry.state = 0;
 	ether_addr_copy(entry.mac, addr);
 	eth_addr_dec(entry.mac);
@@ -2255,6 +2267,30 @@ static int mv88e6xxx_port_db_load_purge(struct mv88e6xxx_chip *chip, int port,
 	return mv88e6xxx_g1_atu_loadpurge(chip, fid, &entry);
 }
 
+static int mv88e6xxx_port_mdb_load_purge(struct mv88e6xxx_chip *chip,
+					 int portvec,
+					 const unsigned char *addr,
+					 u16 vid)
+{
+	struct mv88e6xxx_atu_entry entry;
+	u16 fid;
+	int err;
+
+	err = mv88e6xxx_fid_from_vid(chip, vid, &fid);
+	if (err)
+		return err;
+
+	memset(&entry, 0, sizeof(entry));
+	ether_addr_copy(entry.mac, addr);
+	entry.portvec = portvec;
+	if (!entry.portvec)
+		entry.state = 0;
+	else
+		entry.state = MV88E6XXX_G1_ATU_DATA_STATE_MC_STATIC;
+
+	return mv88e6xxx_g1_atu_loadpurge(chip, fid, &entry);
+}
+
 static int mv88e6xxx_policy_apply(struct mv88e6xxx_chip *chip, int port,
 				  const struct mv88e6xxx_policy *policy)
 {
@@ -6666,6 +6702,12 @@ static void mv88e6xxx_br_mdb_put(struct mv88e6xxx_br_mdb *mv_br_mdb)
 		mv88e6xxx_br_mdb_destroy(mv_br_mdb);
 }
 
+static u16 mv88e6xxx_br_mdb_portvec_fixup(struct mv88e6xxx_bridge *mv_bridge,
+					  u16 portvec)
+{
+	return portvec ? (portvec | mv_bridge->mrouter_ports) : portvec;
+}
+
 static int mv88e6xxx_port_mdb_add(struct dsa_switch *ds, int port,
 				  const struct switchdev_obj_port_mdb *mdb,
 				  struct dsa_db db)
@@ -6675,6 +6717,7 @@ static int mv88e6xxx_port_mdb_add(struct dsa_switch *ds, int port,
 	struct mv88e6xxx_br_mdb *mv_br_mdb;
 	struct net_device *orig_dev;
 	struct net_device *br_dev;
+	u16 portvec;
 	int err;
 
 	orig_dev = mdb->obj.orig_dev;
@@ -6693,9 +6736,11 @@ static int mv88e6xxx_port_mdb_add(struct dsa_switch *ds, int port,
 	if (mv_br_mdb->portvec & BIT(port))
 		return -EEXIST;
 
+	portvec = mv_br_mdb->portvec | BIT(port);
+	portvec = mv88e6xxx_br_mdb_portvec_fixup(mv_bridge, portvec);
+
 	mv88e6xxx_reg_lock(chip);
-	err = mv88e6xxx_port_db_load_purge(chip, port, mdb->addr, mdb->vid,
-					   MV88E6XXX_G1_ATU_DATA_STATE_MC_STATIC);
+	err = mv88e6xxx_port_mdb_load_purge(chip, portvec, mdb->addr, mdb->vid);
 
 	if (err)
 		goto out;
@@ -6717,6 +6762,7 @@ static int mv88e6xxx_port_mdb_del(struct dsa_switch *ds, int port,
 	struct mv88e6xxx_br_mdb *mv_br_mdb;
 	struct net_device *orig_dev;
 	struct net_device *br_dev;
+	u16 portvec;
 	int err;
 
 	orig_dev = mdb->obj.orig_dev;
@@ -6735,8 +6781,11 @@ static int mv88e6xxx_port_mdb_del(struct dsa_switch *ds, int port,
 	if (!(mv_br_mdb->portvec & BIT(port)))
 		return -ENOENT;
 
+	portvec = mv_br_mdb->portvec & ~BIT(port);
+	portvec = mv88e6xxx_br_mdb_portvec_fixup(mv_bridge, portvec);
+
 	mv88e6xxx_reg_lock(chip);
-	err = mv88e6xxx_port_db_load_purge(chip, port, mdb->addr, mdb->vid, 0);
+	err = mv88e6xxx_port_mdb_load_purge(chip, portvec, mdb->addr, mdb->vid);
 	mv_br_mdb->portvec &= ~BIT(port);
 	mv88e6xxx_br_mdb_put(mv_br_mdb);
 	mv88e6xxx_reg_unlock(chip);
@@ -6921,9 +6970,11 @@ static int mv88e6xxx_port_mrouter(struct dsa_switch *ds, int port,
 {
 	struct mv88e6xxx_chip *chip = ds->priv;
 	struct mv88e6xxx_bridge *mv_bridge;
+	struct mv88e6xxx_br_mdb *mv_br_mdb;
 	struct mv88e6xxx_port *p;
 	bool old_mrouter;
 	bool mc_flood;
+	u16 portvec;
 	int err;
 
 	if (!chip->info->ops->port_set_mcast_flood)
@@ -6949,11 +7000,44 @@ static int mv88e6xxx_port_mrouter(struct dsa_switch *ds, int port,
 			goto out;
 	}
 
+	list_for_each_entry(mv_br_mdb, &mv_bridge->br_mdb_list, head) {
+		portvec = mv_br_mdb->portvec;
+		portvec = mv88e6xxx_br_mdb_portvec_fixup(mv_bridge, portvec);
+
+		if (mrouter)
+			portvec |= BIT(port);
+		else
+			portvec &= ~BIT(port);
+
+		err = mv88e6xxx_port_mdb_load_purge(chip, portvec,
+						    mv_br_mdb->addr,
+						    mv_br_mdb->vid);
+		if (err)
+			goto out_port_mdb_load_purge;
+	}
+
 	if (mrouter)
 		mv_bridge->mrouter_ports |= BIT(port);
 	else
 		mv_bridge->mrouter_ports &= ~BIT(port);
 
+	mv88e6xxx_reg_unlock(chip);
+
+	return 0;
+
+out_port_mdb_load_purge:
+	list_for_each_entry_continue_reverse(mv_br_mdb,
+					     &mv_bridge->br_mdb_list,
+					     head) {
+		portvec = mv_br_mdb->portvec;
+		portvec = mv88e6xxx_br_mdb_portvec_fixup(mv_bridge, portvec);
+		mv88e6xxx_port_mdb_load_purge(chip, portvec,
+					      mv_br_mdb->addr,
+					      mv_br_mdb->vid);
+	}
+
+	if (!mc_flood)
+		chip->info->ops->port_set_mcast_flood(chip, port, old_mrouter);
 out:
 	mv88e6xxx_reg_unlock(chip);
 
-- 
2.17.1


