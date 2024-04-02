Return-Path: <linux-kernel+bounces-127222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE51789484D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C74A1F22BBD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 00:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCA9175A9;
	Tue,  2 Apr 2024 00:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="d2MgsXi/";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="WZsp86om"
Received: from mx0b-000eb902.pphosted.com (mx0b-000eb902.pphosted.com [205.220.177.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991AF8F55;
	Tue,  2 Apr 2024 00:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712016778; cv=fail; b=FDFck6g87xjORP5m+t932K1YetvChLLA2OhizevtWySn/2jaVf7OaDDC9yl1UHL7zxqH4opdTVl+UYlTmVQgUxeQsjLpV3dxUu23vYoDoygUuhYx0lFtMcHmWp69JqsgiNLZJlH1uMzgdiZ/t7a1WqWIVi/TefVk/jyXxWrrSr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712016778; c=relaxed/simple;
	bh=5TGqXAvhXwrSbRgkS004xwxIpl8XG1LCoaH1KiwOVpo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pp473rXl5xU0M7FUV7Okq3MBeA4HK9sWGvgbPAVxoXP6VPJQGrPtxnWNJp+XVSqf3kGl89rBYJTLq6ky+Zc4I4VCgr80AYgUVeMYYbLUlN3WvuK/9I6mY+yOTYCC1p+nie6Rvn90y9GdadYNB/YVGks+vH9HbFWJlZrvu8G3zlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=d2MgsXi/; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=WZsp86om; arc=fail smtp.client-ip=205.220.177.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220299.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 431IxkdW023959;
	Mon, 1 Apr 2024 19:12:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=pps1;
	 bh=goUQk12ltS91eBM/WmM3D11GRLslmEU7So87SEeWlzM=; b=d2MgsXi/UhkC
	PF6IytJBK0xk0jgOvfDy5B4Qz6p7t8PYk6RsNy2y3UvK9qBns6vytqk5MJfA497R
	DzRQEcw3wJJd+JlE2FDEiwygMmEo94w38d2ReUd463scyQjBWzMCOUOT/YViD5la
	3Vb9/BPHnGhspj5w78A5ZQpyVmug/mdJ514WJ4RVemEMFURUTJQlbcptY+GVknzp
	nv2KcIEcVeYvQyx2celxsoz5QkwDsgsM4SfOw+nB90gxq22ZKgkpYgj++GYbK1Uh
	ku6YDX0l64MfYpim5VbJ3iCyB5+HjaoxhdpRue/YE7swoCUwmTKCYLReb+HFMOJU
	20q6HqhpSg==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 3x80hys4n1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 19:12:40 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRY+vpuRPURrVG3ddpqhEZK85/gLP+1/4ZjkrUcQv1/+Tm1nyY9W9NaWG6tfIxzt4hvQsI30+vHEKCEDEVllYQeFbXCZmgn+Q+Z3qsN2wP2aFkzRCAhwQBlLw+afCHbu0+t9bC7PsUdGroLgDgfiMDm2j7nqldyKXAJUeMG+WhJW7gCux/0PEjK8vWM9PeOo/v+KXZy7AkD2DUuu4lhPjn4wUGa1H5YofGDafUvqSb6uwtM3z4gjOprfDPP7URNbJlj+9kLtYywaoz7MjbCN1y5jmkecSAlAKqpTQVr4+pRJzYFFDyJVcm0C4m8Q+V8RheUCH5Hk6GzQCC3I2l72sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=goUQk12ltS91eBM/WmM3D11GRLslmEU7So87SEeWlzM=;
 b=VRroQG9nl2QWAmCdugO5V7iGpSE/npjKqRgasRdc49RXcodGjZ0xDMR3GNMGxdkDKxaX5kyuTLLEErtLdHRs9Yr5nSwJdWO/5MnqXfzEsCgKT270tCP8T/vSx3I/5/2gH6ljeqHlJXFRit5nOHMudSOYVKumBvmVT8qb95fApDik7dX5BdRd4l4QGkzYYC8hegvxySQT5uMDItZZOoQ31mZfHdyUDaJtEpAv525CfER5l5XrTWV3lczFGbhbf7e7LRFJBgdQI0swPQ2wH0i7OGs275eYHRNUUHahbqQOvNnAJFSTOIQ2TME06X2xVUsVsXVhaFotVFWLxbyK0g7aVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=goUQk12ltS91eBM/WmM3D11GRLslmEU7So87SEeWlzM=;
 b=WZsp86ommixX0EuqsL3mK9TH6fhqgtXlXZ1BHwrkc+a7K6Xw0hijKTFLB/u8W9BYs4ICAMD/NBh9Wvqgb8eC8gocyYylVMZqVCHdHE5ZJN9Fog/a2G2uF2bN86LZaarsmdr9equo0C9dMOTn5wg/CB6LAF3EDkBiJ8zKxaMH1voV/V8VD0z6lwkackYN9b2FvzbBrra21HwM6KrNgRDH7hbve6bYiQYmQ/H4kk38wdFJvgZxHM1dt1bHk0JVw+LIi3QrhbDczLOVUcVpTdIOG9ybW1QCpJafGQ3B+T9zWCv0A9yW7omW7zPOTpqOzITAJ/FX69Z2SRx2MVD4KEfWPA==
Received: from DM6PR06CA0017.namprd06.prod.outlook.com (2603:10b6:5:120::30)
 by SJ2PR04MB8534.namprd04.prod.outlook.com (2603:10b6:a03:4f4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 00:12:38 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:5:120:cafe::1a) by DM6PR06CA0017.outlook.office365.com
 (2603:10b6:5:120::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Tue, 2 Apr 2024 00:12:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 00:12:38 +0000
Received: from cv1wpa-exmb3.ad.garmin.com (10.5.144.73) by
 olawpa-edge2.garmin.com (10.60.4.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 1 Apr 2024 19:12:29 -0500
Received: from OLAWPA-EXMB2.ad.garmin.com (10.5.144.14) by
 cv1wpa-exmb3.ad.garmin.com (10.5.144.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.37; Mon, 1 Apr 2024 19:12:37 -0500
Received: from kc3wpa-exmb3.ad.garmin.com (10.65.32.83) by
 OLAWPA-EXMB2.ad.garmin.com (10.5.144.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.37; Mon, 1 Apr 2024 19:12:37 -0500
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by mail.garmin.com
 (10.65.32.83) with Microsoft SMTP Server id 15.2.1258.32 via Frontend
 Transport; Mon, 1 Apr 2024 19:12:36 -0500
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
Subject: [PATCH RFC net-next 08/10] net: dsa: mv88e6xxx: Convert MAB to use bit flags
Date: Mon, 1 Apr 2024 20:11:07 -0400
Message-ID: <20240402001137.2980589-9-Joseph.Huang@garmin.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|SJ2PR04MB8534:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cbedd3a-2d67-4f62-c60e-08dc52a99b0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	7JlLqAQsNgq03AzZjW0OLw6UKaI8N6gKb9pmpQMQ7mFfZFkHtqsk/n7ZiPmat4xyCEzn9SAnbnY+Uz8VZuRohecgXj6OVFVcWDBk7/OYbF0WVYYLWYK4oQvQolC1X7hzY79zwEp0ZrG/sRQDSmwpIvUgS+S2mFX6v3LWLubi727V4kzdt+hKZt5qM62cDayNOql3NKjCa+M9/VptgF/aV3J2+6pCa0+8nRIjwVjCxitJBBQ2tOIJXL2gx9gsjtV/zKu8a7ktLwKQIet8F0nvg+IF+yV9nEAY+0xx58lhbKQRXzFnTFj3sgDm58l822Vik9FwIIdqOPlWeRzYq4rVw1ZuJ+sZEkDsHu2P4sZRbAxb1ebYqIHUEBQTVgpjiboLihaMVGYvD73JD3MJ2Y8yx2VdMHQGl+DbGVrI8wJFG4QjVi+j+XixNObA0Y/XL9neoXRxMxcL5EEEBCj+zqaLBVq689Me66Dg3YuEUAJfh06tjz38OAnpNPgOdI+2fqcGDP8Gk5/QIhsGrQi8ZshCWgHVoorFGv0GLxMw2g2OEAEuSj1ZJ8/Cf84nhw1JaygcfGJu1D7HM4UvYFeztQHm/IIgcyo70UcQu+zOp22fNxjZtiw6JcIWJHwCmMm19MfJjOYVzsYN4oll3rZx6MS/ijhPlFoTWAmPb/8AHaPy0CV7BZrSqm2BXgPhhmYcgKeorjhL6VUZ/iS2yQ0tBTqYGTyiECAKsy5lOwXFbKq7u8+gxnCfu7tpgC9umu4dbiqh
X-Forefront-Antispam-Report: 
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004)(7416005)(1800799015);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 00:12:38.2864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cbedd3a-2d67-4f62-c60e-08dc52a99b0b
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8534
X-Proofpoint-GUID: PToDxVzJGDt2txwy7UwejQEUci7ug19t
X-Proofpoint-ORIG-GUID: PToDxVzJGDt2txwy7UwejQEUci7ug19t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_16,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404010168

Convert MAB (MacAuth Bypass) flag to use bitmap.

A new port flag will be added with a subsequent patch. Convert the
'mab' member to a bit in a bitmask to save space.

Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
---
 drivers/net/dsa/mv88e6xxx/chip.h        | 12 ++++++++----
 drivers/net/dsa/mv88e6xxx/global1_atu.c |  3 ++-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index a32e4564eb3d..205f6777c2ac 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -272,6 +272,9 @@ struct mv88e6xxx_vlan {
 	bool	valid;
 };
 
+/* MacAuth Bypass Control Flag */
+#define MV88E6XXX_PORT_FLAG_MAB		BIT(0)
+
 struct mv88e6xxx_port {
 	struct mv88e6xxx_chip *chip;
 	int port;
@@ -288,9 +291,7 @@ struct mv88e6xxx_port {
 	bool mirror_egress;
 	struct devlink_region *region;
 	void *pcs_private;
-
-	/* MacAuth Bypass control flag */
-	bool mab;
+	unsigned int flags;
 };
 
 enum mv88e6xxx_region_id {
@@ -802,7 +803,10 @@ static inline bool mv88e6xxx_is_invalid_port(struct mv88e6xxx_chip *chip, int po
 static inline void mv88e6xxx_port_set_mab(struct mv88e6xxx_chip *chip,
 					  int port, bool mab)
 {
-	chip->ports[port].mab = mab;
+	if (mab)
+		chip->ports[port].flags |= MV88E6XXX_PORT_FLAG_MAB;
+	else
+		chip->ports[port].flags &= ~MV88E6XXX_PORT_FLAG_MAB;
 }
 
 int mv88e6xxx_read(struct mv88e6xxx_chip *chip, int addr, int reg, u16 *val);
diff --git a/drivers/net/dsa/mv88e6xxx/global1_atu.c b/drivers/net/dsa/mv88e6xxx/global1_atu.c
index ce3b3690c3c0..06d0c526e33d 100644
--- a/drivers/net/dsa/mv88e6xxx/global1_atu.c
+++ b/drivers/net/dsa/mv88e6xxx/global1_atu.c
@@ -445,7 +445,8 @@ static irqreturn_t mv88e6xxx_g1_atu_prob_irq_thread_fn(int irq, void *dev_id)
 						   fid);
 		chip->ports[spid].atu_miss_violation++;
 
-		if (fid != MV88E6XXX_FID_STANDALONE && chip->ports[spid].mab) {
+		if (fid != MV88E6XXX_FID_STANDALONE &&
+		    !!(chip->ports[spid].flags & MV88E6XXX_PORT_FLAG_MAB)) {
 			err = mv88e6xxx_handle_miss_violation(chip, spid,
 							      &entry, fid);
 			if (err)
-- 
2.17.1


