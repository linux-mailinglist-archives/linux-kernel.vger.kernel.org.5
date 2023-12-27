Return-Path: <linux-kernel+bounces-12305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 144E881F2F7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 00:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3B9F1C21016
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 23:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF92498B6;
	Wed, 27 Dec 2023 23:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dWL+iN9T"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C0049896;
	Wed, 27 Dec 2023 23:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDCV/XEKiZ+HsSeF7MBvDnC+os2mPSh+QjzF48Iu/mjDEjPVBdzV6dUheIBP5VXsel7JJik6iqQ2nScz5DrQ+rQqchg8okxb2DJo+puVm1qY446jwhk7UpWvGJc1zTwIYK5ufIqsGrryQAsz56TD+G+kRJ3C2b0qOWxHHWc4GGH/nsqb+CKWXUoh1VDXK8cQn+slZwRVpOi/pqHaWlypECMlBP3AJFQek4uMIeGr4oIRgKb2r/axPTTX9iU+QojgMgY3AgNeYyhAbrip0RhfK7PjWRnTq/rty31zsKSqaSn/56aUFCVnwbA3iagsbUZjbQWrsX3n5sLZuHk4iXlFfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1QLYHabttXnUFGnQ8MZBduvKPRiYw4cCnYekrsESfio=;
 b=meHdh67ZVPoPdsMTuFeRE1dYN4eUADfvNbIiniyNF9MBjsiho8t1bOFa/JM5gpK7S5F5DnQ3sP4WH/3E2bXVGg644okhP+LYBMhnZ5qa3VInDbPaWbGn4mAEizn0Mn1/tFHh6RWbRaIsVbyr+6qBuJsNibk3r1clVNMsDMegDxRa/2H+cevNccPREkpz367JE1/K74wjb++iY0rIt+yus92y+1pl5i8zN+79ULhjbeWBVbDg/vNOoj2Smuy+yXoc1A9Q6HTNGUlywWrQIVseYoQdvJQGN5c5CacYG5xz7H9gypb2HY50igeUoddYjvSBM9v2OOdmFzQ3ir0tSAjBUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QLYHabttXnUFGnQ8MZBduvKPRiYw4cCnYekrsESfio=;
 b=dWL+iN9Tt6ZEop5etEC2iaZSdqUDAX/Z4tJ8hzgh5TlX5bumH0+MTnF3dg6oDLjpjVUoeQbMpx3GGpDA8uwpz5ndDIPmsne0FfQrVKSIsAtsb7vvGKOCKaiWYn4Uk4GcjB7T6Opk0HMNalINOj9D0/BWYrUmebAD0XMBoS8qaQUnMmqwddiA2UrEb5Qr4hN2W8y8mHTPQ9qmAdkrj4TkHJ2HAjqQznT7CR0UYG0vNS8L2Z6MUtKQputdAHZcjtNDOoBMnn16+yPhU0rdvo4a3hGZmhu1yA81U1O0qSdXGaSSc2bPIdeNRVjrR3SM3IhVFaF1A7aw0lawD9mfCFKuAg==
Received: from DS7PR05CA0007.namprd05.prod.outlook.com (2603:10b6:5:3b9::12)
 by BY5PR12MB4180.namprd12.prod.outlook.com (2603:10b6:a03:213::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 23:17:03 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:5:3b9:cafe::89) by DS7PR05CA0007.outlook.office365.com
 (2603:10b6:5:3b9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.7 via Frontend
 Transport; Wed, 27 Dec 2023 23:17:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7135.14 via Frontend Transport; Wed, 27 Dec 2023 23:17:02 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 27 Dec
 2023 15:17:01 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 27 Dec 2023 15:17:01 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Wed, 27 Dec 2023 15:17:00 -0800
From: Asmaa Mnebhi <asmaa@nvidia.com>
To: <davem@davemloft.net>, <marek.mojik@nic.cz>, <netdev@vger.kernel.org>
CC: Asmaa Mnebhi <asmaa@nvidia.com>, <davthompson@nvidia.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/1] net: phy: micrel: Add workaround for incomplete autonegotiation
Date: Wed, 27 Dec 2023 18:16:57 -0500
Message-ID: <20231227231657.15152-1-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|BY5PR12MB4180:EE_
X-MS-Office365-Filtering-Correlation-Id: 615197c9-3748-4169-a05a-08dc0731ef05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vTS2yeVMv6pPFlUebO4B3f69UK0jx21/fAoFiKcK6MyZZl2oECYf8YgXHpxgMSZkIljRX1Uyg/wVwL1BPwsNwYIJ3iyzUAoFXhkPSJ6LViLoMe1yXyN1e0Hbd0TuQpm3yIDJiiF8/SZv3HFUP+YrSNOj+r0vr3s0iVBdpnaK6f3DA3RNBokHBp0GF8uB6EvwtV5/Yf0tQXtFgM+AvSEQH9UVo5YIbKpmoU8T5V/CRHPunuMTZBUP6xK8JehPa2q2NKg5jjrXEZ0FD5uOAKRF6ljHoGPp1uDlguL8IUFGi0R9H8ZK52B/kgeJJJt2dwfRFvswB5jJ9NLPsCkmN/wbbexmnNMjW1RJrLenNpP1v8BFjovHDPeZW5RyBmRqLHZh8b3D/EU72XEvePAZRI2Lv3XMtJTwYqPgW3lUEc/77plNgypEIzDM8yTqCPsh+71mdU2PkcVw1Jzd2LkzeaSlUcGzzZ2u3PWN/+G7Hg6omdN5DQnXN1whhndWfzzZrWWoi1pqZDH0m3FohjdHnlmZR5CAj3T8s5jkyeFRgWn6MMbjweMoylAZHh5zVbIkoKvE4Sk3VBLgL78+rZH6SFR8QCxmkfkllcmfI4KF2A3qcDg38t3XGwCgVxsK7iKFpJ6OuGkUaoPY20iMp8j/CErgCD+M852IXd0CPzuLmCLq6gZdFjIqwdLHk6RhwISihVpheqKuZWYyVMG5Rc1uXEjuqQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39850400004)(136003)(396003)(346002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(82310400011)(36840700001)(46966006)(316002)(26005)(8676002)(8936002)(478600001)(1076003)(7696005)(86362001)(2616005)(36756003)(336012)(82740400003)(7636003)(6666004)(36860700001)(356005)(426003)(54906003)(110136005)(47076005)(41300700001)(70586007)(70206006)(5660300002)(40480700001)(2906002)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 23:17:02.3433
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 615197c9-3748-4169-a05a-08dc0731ef05
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4180

Very rarely, the KSZ9031 fails to complete autonegotiation although it was
initiated via phy_start(). As a result, the link stays down. Restarting
autonegotiation when in this state solves the issue.

Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
---
v1->v2:
- Use msleep() instead of mdelay()

 drivers/net/phy/micrel.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 08e3915001c3..9952a073413f 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -1475,6 +1475,7 @@ static int ksz9031_get_features(struct phy_device *phydev)
 
 static int ksz9031_read_status(struct phy_device *phydev)
 {
+	u8 timeout = 10;
 	int err;
 	int regval;
 
@@ -1494,6 +1495,22 @@ static int ksz9031_read_status(struct phy_device *phydev)
 		return genphy_config_aneg(phydev);
 	}
 
+	/* KSZ9031's autonegotiation takes normally 4-5 seconds to complete.
+	 * Occasionally it fails to complete autonegotiation. The workaround is
+	 * to restart it.
+	 */
+        if (phydev->autoneg == AUTONEG_ENABLE) {
+		while (timeout) {
+			if (phy_aneg_done(phydev))
+				break;
+			msleep(1000);
+			timeout--;
+		};
+
+		if (timeout == 0)
+			phy_restart_aneg(phydev);
+	}
+
 	return 0;
 }
 
-- 
2.30.1


