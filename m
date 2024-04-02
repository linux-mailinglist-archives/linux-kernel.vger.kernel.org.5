Return-Path: <linux-kernel+bounces-127219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73874894846
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 010441F22907
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 00:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023CEEAC7;
	Tue,  2 Apr 2024 00:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="AapHN/x7";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="i9I4QpkD"
Received: from mx0a-000eb902.pphosted.com (mx0a-000eb902.pphosted.com [205.220.165.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28F42107;
	Tue,  2 Apr 2024 00:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712016776; cv=fail; b=ce9QlVruWoMYUiBKu6cwyW2il96KwKKaUMo47bv7BDWpIv4MCk2krhxkWK/Ogg4uMvwX5tJr3vCv9gIBVM7NwXuiQSTeMfp5pEPORnRjXJ6mL484j++16KIhybAJ0yxcoQUjSb+wZs0wSIxFTIH2dvMUoyeojNBxVzwzWzm+1eY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712016776; c=relaxed/simple;
	bh=8wZf9G7hTWyo09J/RapitcvH7k6Akgj24a2GxCDygSs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fOwcSEko6A/MkviVV0Oo9e1KFU7Fz9+XeJ4Wq4SuX7ofgmQJp2kq143gK6k+npTTov1JAOm8G8GpjJ18clkkp5iT0x7eOMFNngGLq0h1xajfjzEWFPS1nqAVKpOR/NAQXniQ95IDMV0+Eo02T76sj34PsjrBJw1Q1p9fz6N4bQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=AapHN/x7; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=i9I4QpkD; arc=fail smtp.client-ip=205.220.165.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220295.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 431J00Zq011380;
	Mon, 1 Apr 2024 19:12:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=pps1;
	 bh=2FrUqD7C17W4jEYKn/TxgYjSvbgMFjeqVFsoOdy5czs=; b=AapHN/x7cGf9
	IfGx1reezWmBBzXBW+RSJci3cD6aJf4HhzT7HYpv/QMQpWyVrf3Bz+HfnykVnqcZ
	v7aj7fiMIw6dg9eWYhQTh3e9id0/Z5/p4z3FdWxV/1DMG8G9dYC99euQm54SwMFv
	g0MBYEeadjaWto2Cp0i8Sb71IZKTM2J6rsKmG9gKPO/I3MmhE7qdh5I/4j1jQu9B
	oO9RMyALZt6GLZ+8iOCZWL/lmNbZqD/40HiBoNLfghYLuQEPpU3efQZx41DGIq+L
	7QhtKdiG3yS5lAez1HknmNsGq95Bu933O5rNhOJtP2rSjk9XvPjXa/oUmhooK6bg
	d8KtJwAd/A==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 3x6d6tfyj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 19:12:31 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6+P/GvoaLALMMEnb5wvxGpYpcLV92zKhYe6DyQWefmFbDabSpKdHFRpPNrFBfn4QUh74zyBPXtSOgOUf3IJCW/NUtFvLHcBaP28McJp6tXkQ9U0r7EYDSgwZVCa/N+/HhJO8qp+h3OoY4MzhH2YTdMJZdy6/MyeepBmKSo796SGNnbl5eDEzwQrr14jh2/S1BusXM1WT3Iwh7RJ21mPUaWodf9BqVQq//x2Y6PuaNkJ4nDpBTAl9c8NrAcE0c/7aTy1WaeFTEHnoaTeZGqzRzWNhCMNqpNazEhx0BFhqqYsKPVeADAg3rX/WAr3lQUDsi3wnYBolCC1HnmPIfHk3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2FrUqD7C17W4jEYKn/TxgYjSvbgMFjeqVFsoOdy5czs=;
 b=jcPdgOSYm2MKk9H6hGKNl56YGetTSm9SGuNDnja2lTZenhYc5wTfLSgg5uLfPcTvIAkIu/1md3XTs/HvqOmlwv3dNhA9NQeMb1gzHU+EIfFvRER6xY0Nm1mmifQZfsjWESSj53ryskSLLyUHR35VGRI4JammKMYWgbsknUjFtL5QXqar1BJMM1caMg7qZCEMBpcUxVY0DRFUg4UbZgjVAKPGh7IWCtT28VgkK+qELdjmr64fj3Uz29d4pxzoak1ehk5Pua0HjvtCwB4RfzfDunlIxGcIZSsncCrk68keYHQ5+R/1X01E7JA19feQgJEPr853yXiYv6C0TlEhJ/mgqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FrUqD7C17W4jEYKn/TxgYjSvbgMFjeqVFsoOdy5czs=;
 b=i9I4QpkD05oXuLgR0qFIV14iowCrTwJ7AhcZiEFw5uPkIM+KR6AqTOtrptvwQvbvHCUeYglmVNAiyu3CDE7IOL1dBJ77ciS4uOiu9L588v+Vry4MimL8LPdBNKGjcgySRy1uQJDxd7H8pWBS8erw6qcXyzMjZNXrW2ep0g3q41uBzj3nVvKgtGgqZvNEeYjeRUvOjA/Xf7LLBTCpZGXrktRGn6vjW3nB+tgFWlxHmrfEteg3n6LOKe8ikIIu6O5pyMeVYwhGyeNeLDCLK8YHAfybCpX72lT/MYeXLdMXVt+pEFnE3jQ1klScO5hNOxzrWEJspvuuBPei1mXU7CKf8w==
Received: from CH0P223CA0014.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::18)
 by BY5PR04MB7042.namprd04.prod.outlook.com (2603:10b6:a03:22f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 00:12:25 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:610:116:cafe::b2) by CH0P223CA0014.outlook.office365.com
 (2603:10b6:610:116::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Tue, 2 Apr 2024 00:12:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.0 via Frontend Transport; Tue, 2 Apr 2024 00:12:24 +0000
Received: from cv1wpa-exmb3.ad.garmin.com (10.5.144.73) by
 olawpa-edge1.garmin.com (10.60.4.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 1 Apr 2024 19:12:16 -0500
Received: from cv1wpa-exmb5.ad.garmin.com (10.5.144.75) by
 cv1wpa-exmb3.ad.garmin.com (10.5.144.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.37; Mon, 1 Apr 2024 19:12:24 -0500
Received: from kc3wpa-exmb3.ad.garmin.com (10.65.32.83) by
 cv1wpa-exmb5.ad.garmin.com (10.5.144.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.32; Mon, 1 Apr 2024 19:12:23 -0500
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by mail.garmin.com
 (10.65.32.83) with Microsoft SMTP Server id 15.2.1258.32 via Frontend
 Transport; Mon, 1 Apr 2024 19:12:23 -0500
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
Subject: [PATCH RFC net-next 04/10] net: dsa: mv88e6xxx: Add all hosts mc addr to ATU
Date: Mon, 1 Apr 2024 20:11:03 -0400
Message-ID: <20240402001137.2980589-5-Joseph.Huang@garmin.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|BY5PR04MB7042:EE_
X-MS-Office365-Filtering-Correlation-Id: 7baa287e-6dc6-482a-b1fd-08dc52a9931f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ADWkrYeCe9/4zQwZToNkSqgwgNvnmldDfQx+FoVaFQLLD4mllbg2u2n/xHP552nJF6/p96goDqUZFkpBsdeQSlGVgUSapimwy8FH/SeqsyKivbgTdkAMzQXGW+caWrywY3Eiiw6V1EnALB+gfDVxf897HTjCzkP20obV8cc2Mm8PFUKIGD91jVVVZ5l/KoDQYyY2tc7KhVR7HM137te+ZLQpbI6EDNUeCVf/O6Rl7gpZeUwUJKPOMyG8xPWpMxU+jQT8sfjn1yvJn+4T2wwgd2RAYdPP42XgkHDShbn0UxajY/bPmcrjxEwgZuQMpQyJvGUeYIEodu1SLsbtNMECLWGOtjOKCNjEvOJPK/aBdfYF4Ux2FbeLS6FRYrqA4T8c+7gSC2NFcd0fAix46LiTeAY/f6VD0N7ZtzLL5wDd9jDLsvmvwEMb0ZzXros/A+hyxXPgTInuv6XBQZGIj5uFn/NSRHcnHPfDj93ztC056zhCP3Gp57KcOiugwxaDITu8LzjflIZOlQ4u/ZAaGSByrcexi3+RjDAlY7FbODw7bSQqCK6OguQW8wTEgzfTx+wLUJwODcpRqglKIKJy96mbu2wwvrNVLCq7GSgC4dNfA102xbRNi5nMGfmFhT/N3rGsR+2x5EaH6MM7LaILAuRpyUezimdEmMwtsyquEXp1OLnKIkxc+GLi4ACE+OpPSGhvNpePERmIHg9E9mUL6iBACzmyS8FTKNo6zycxwS+uXG9TIwRwvhEmBjWMf43/jKo9
X-Forefront-Antispam-Report: 
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(7416005)(376005)(1800799015);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 00:12:24.9952
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7baa287e-6dc6-482a-b1fd-08dc52a9931f
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7042
X-Proofpoint-GUID: H7cVO4xao41MGbyUzl2U-wa9jR3bG28Y
X-Proofpoint-ORIG-GUID: H7cVO4xao41MGbyUzl2U-wa9jR3bG28Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_17,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2404020000

Add local network all hosts multicast address (224.0.0.1) and link-local
all nodes multicast address (ff02::1) to the ATU so that IGMP/MLD
Queries can be forwarded even when multicast flooding is disabled on a
port.

Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
---
 drivers/net/dsa/mv88e6xxx/Kconfig | 12 ++++++++
 drivers/net/dsa/mv88e6xxx/chip.c  | 47 +++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/Kconfig b/drivers/net/dsa/mv88e6xxx/Kconfig
index e3181d5471df..ef7798bf50d7 100644
--- a/drivers/net/dsa/mv88e6xxx/Kconfig
+++ b/drivers/net/dsa/mv88e6xxx/Kconfig
@@ -17,3 +17,15 @@ config NET_DSA_MV88E6XXX_PTP
 	help
 	  Say Y to enable PTP hardware timestamping on Marvell 88E6xxx switch
 	  chips that support it.
+
+config NET_DSA_MV88E6XXX_ALWAYS_FLOOD_LOCAL_ALL_HOSTS_ADDRESS
+	bool "Always flood local all hosts multicast packets"
+	depends on NET_DSA_MV88E6XXX
+	help
+	  When set to Y, always flood multicast packets destined for
+	  224.0.0.1 (Local Network All Hosts multicast address) and
+	  ff02::1 (Link-Local All Nodes multicast address), even when
+	  multicast flooding is disabled for a port.  This is so that
+	  multicast snooping can continue to function even when
+	  multicast flooding is disabled.
+	  If in doubt, say N.
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 9ed1821184ec..fddcb596c421 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -2488,6 +2488,41 @@ static int mv88e6xxx_broadcast_setup(struct mv88e6xxx_chip *chip, u16 vid)
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_NET_DSA_MV88E6XXX_ALWAYS_FLOOD_LOCAL_ALL_HOSTS_ADDRESS)
+static int mv88e6xxx_port_add_multicast(struct mv88e6xxx_chip *chip, int port,
+					u16 vid)
+{
+	u8 state = MV88E6XXX_G1_ATU_DATA_STATE_MC_STATIC;
+	const char multicast[][ETH_ALEN] = {
+		{ 0x01, 0x00, 0x5e, 0x00, 0x00, 0x01 },
+		{ 0x33, 0x33, 0x00, 0x00, 0x00, 0x01 }
+	};
+	int i, err;
+
+	for (i = 0; i < ARRAY_SIZE(multicast); i++) {
+		err = mv88e6xxx_port_db_load_purge(chip, port, multicast[i], vid, state);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int mv88e6xxx_multicast_setup(struct mv88e6xxx_chip *chip, u16 vid)
+{
+	int port;
+	int err;
+
+	for (port = 0; port < mv88e6xxx_num_ports(chip); port++) {
+		err = mv88e6xxx_port_add_multicast(chip, port, vid);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+#endif
+
 struct mv88e6xxx_port_broadcast_sync_ctx {
 	int port;
 	bool flood;
@@ -2572,6 +2607,12 @@ static int mv88e6xxx_port_vlan_join(struct mv88e6xxx_chip *chip, int port,
 		err = mv88e6xxx_broadcast_setup(chip, vlan.vid);
 		if (err)
 			return err;
+
+#if IS_ENABLED(CONFIG_NET_DSA_MV88E6XXX_ALWAYS_FLOOD_LOCAL_ALL_HOSTS_ADDRESS)
+		err = mv88e6xxx_multicast_setup(chip, vlan.vid);
+		if (err)
+			return err;
+#endif
 	} else if (vlan.member[port] != member) {
 		vlan.member[port] = member;
 
@@ -3930,6 +3971,12 @@ static int mv88e6xxx_setup(struct dsa_switch *ds)
 	if (err)
 		goto unlock;
 
+#if IS_ENABLED(CONFIG_NET_DSA_MV88E6XXX_ALWAYS_FLOOD_LOCAL_ALL_HOSTS_ADDRESS)
+	err = mv88e6xxx_multicast_setup(chip, 0);
+	if (err)
+		goto unlock;
+#endif
+
 	err = mv88e6xxx_pot_setup(chip);
 	if (err)
 		goto unlock;
-- 
2.17.1


