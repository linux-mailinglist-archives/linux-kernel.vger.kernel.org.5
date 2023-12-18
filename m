Return-Path: <linux-kernel+bounces-3260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A6B816A06
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4274EB21A92
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E514134A1;
	Mon, 18 Dec 2023 09:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AD9Fjw2l"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731BF12B9C
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 09:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLIgHpRlx/wz6ToUuCpKSwJsPHBxdhzcl/0A2dtE8HWvmmJIgoQ76stMLjGcDcYGhEcbltD9u8IfLd5RMdaUDkS09wxlaE9y435h5m63vgDDmo5jMMbJzzn2kmzpMikS/64fl49iASfzV0pJrHdn4Mb78HNvUor35AvxbxbSsKX5WReJg6Qb0IBgmlkZqd2EDAD7lo79+L76mf6sRNKHZwMn40+FcSHt7kvJUnv4sldNIRHbr/WudIG1A+anTmmLmTSIcWYy5mwo/0+l60e9Vs4v+a1gR0f3Jz928SaDNM0yxnaElG0o2fTwDoc1FzxRrxifPWNUhlSl+lARBfZewA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmqG0n32ktuAdZDprmZUiMMAlDSZyICjmp1qpej5fqw=;
 b=m3tPWq0JwdtScV8innP/B2mavVOjHJuYAsyxAfO9jSnzVmArB+MfgEw92SSytOu3lh7LBbMTYHr4MFjwGS7owVCX/+jE5w65opBPsUqTcvAUKg/Qc/aN1S+rTBozkIBLKzbPnD5+ES+rO88ksEvN3w7Qold8+pn3HQ1XRFqHZ9nBX1TJGu0XjZbBzUqcQfvI0bOH3n3l2C2SBm3mANZLFgVZsvyWkD2nlVJi3Cb03g1P6y788KxX/IMKYVBZ8kxEWdrUfsW35/hHUpaZNMP5EeAebpG5HSmMQKnaRBJ1f3ASbc0fUpoGni4YB6PosS+seUy3B9PgWTprgpas9IxqdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmqG0n32ktuAdZDprmZUiMMAlDSZyICjmp1qpej5fqw=;
 b=AD9Fjw2lRyoS2K5kOXBjz4dD/gjwz7wHAnTMbn9pdS6xYS3kpMRjUFPc8DHYRacvTbEhl9oR+Lcszm0oTTjQ+JZJbnjhqhhmY1/wVjEgDH2LI8E90fH1dw/Md6cRwl+JRTLcuNAfjvp3PPC7wT0yQ/p1/xxR+QMzQtUipCi7AMs=
Received: from DM6PR03CA0056.namprd03.prod.outlook.com (2603:10b6:5:100::33)
 by MN0PR12MB5810.namprd12.prod.outlook.com (2603:10b6:208:376::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Mon, 18 Dec
 2023 09:41:40 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:5:100:cafe::24) by DM6PR03CA0056.outlook.office365.com
 (2603:10b6:5:100::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37 via Frontend
 Transport; Mon, 18 Dec 2023 09:41:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Mon, 18 Dec 2023 09:41:39 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 18 Dec
 2023 03:41:34 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 18 Dec
 2023 03:41:07 -0600
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Mon, 18 Dec 2023 03:41:06 -0600
From: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To: <michal.simek@amd.com>, <gregkh@linuxfoundation.org>,
	<sai.krishna.potthuri@amd.com>, <linus.walleij@linaro.org>,
	<nava.kishore.manne@amd.com>, <dhaval.r.shah@amd.com>, <robh@kernel.org>,
	<marex@denx.de>, <roman.gushchin@linux.dev>, <arnd@arndb.de>,
	<shubhrajyoti.datta@amd.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Subject: [PATCH 1/2] firmware: xilinx: Export function to use in other module
Date: Mon, 18 Dec 2023 01:40:08 -0800
Message-ID: <20231218094009.13528-2-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231218094009.13528-1-jay.buddhabhatti@amd.com>
References: <20231218094009.13528-1-jay.buddhabhatti@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|MN0PR12MB5810:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f2424c4-4e67-4406-f79a-08dbffad8941
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1qo1U9FlaCEGB8DtMMWqpREA18mJiUPsGuFya6XKeRmHAzAHcAOlEiPberAJT4eEdqJ6MSKzHfc6o2SlRVi0bfsOWYjqjdgNSaGY9yVH59QRELChoMjjMGsxkY8BnkuJqpEovOM/kdNfTDuih5UxBwQEXvOG9tCNtZeTeWnFmXw06FYSLkfN2wAnz4U9wiLQf4J4wBVAaoEvMsidgqdZbOIMt8n0+id4lK5td88C5BZB0kxi8LaGeaxrd5jAsTtdyfvVcn2e2Rnls1mQk38KVFPgNk5UeR8jIlrz5wmpdDdCxzOO9fvcBag3CpraxQiIJds0UlxU2ExV7l2QqADgVywmiG4IviDZxnHsFYKWxNueLpAYs2mHjrOvPTeIk4Q1AtVJ0hB2cOV3nl4nxYk4JnKRG0NJ2VeTuGNt99smi8I3UE6nPasYE386fS5VA6ysLc5MLx8j2KOAkqusznIAuitOTtg4nnnYfzUcoHCO67QNRhQmqEx88vddtrLHB6ZacgXjJAklRrFslmNzpkrvemQaVXj2EZ0GLhJm9n+yuqrJxGARgNXa0vQY2BvyLHheuhN4LfUqZk17lq+ruq5BU3OIf5osK93q+Ll69Bfp3P4vZjkb2A+Mmf73oo0TU69gqFA2AfTZcZ6UIjLKP46z8QDK4Q90HZwVOKjgWP5zCiU9SdRwjCDYJjWyDeJRbZqY0l815+eLSSa0Spw5Al83YX6KgEV1A87WaPKR93AN1j2eXJXrQtv1vTKreaA+lfjRLet1N1WbQTqYsYxEgc8jYuKj0c1ddVJoKINu/5z1b/w=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(82310400011)(46966006)(40470700004)(36840700001)(40460700003)(1076003)(26005)(336012)(2616005)(426003)(36860700001)(83380400001)(47076005)(5660300002)(44832011)(2906002)(41300700001)(478600001)(316002)(54906003)(8676002)(8936002)(4326008)(70206006)(70586007)(110136005)(6636002)(356005)(82740400003)(81166007)(36756003)(86362001)(921008)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 09:41:39.9502
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f2424c4-4e67-4406-f79a-08dbffad8941
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5810

Export zynqmp_pm_get_family_info() to access and find family information
in other module.

Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 3 ++-
 include/linux/firmware/xlnx-zynqmp.h | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index b0d22d4455d9..313965f79dd7 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -414,7 +414,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_get_chipid);
  *
  * Return: Returns status, either success or error+reason
  */
-static int zynqmp_pm_get_family_info(u32 *family, u32 *subfamily)
+int zynqmp_pm_get_family_info(u32 *family, u32 *subfamily)
 {
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 	u32 idcode;
@@ -439,6 +439,7 @@ static int zynqmp_pm_get_family_info(u32 *family, u32 *subfamily)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(zynqmp_pm_get_family_info);
 
 /**
  * zynqmp_pm_get_trustzone_version() - Get secure trustzone firmware version
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index d1ea3898564c..2375ce9b38df 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -515,6 +515,7 @@ int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
 #if IS_REACHABLE(CONFIG_ZYNQMP_FIRMWARE)
 int zynqmp_pm_get_api_version(u32 *version);
 int zynqmp_pm_get_chipid(u32 *idcode, u32 *version);
+int zynqmp_pm_get_family_info(u32 *family, u32 *subfamily);
 int zynqmp_pm_query_data(struct zynqmp_pm_query_data qdata, u32 *out);
 int zynqmp_pm_clock_enable(u32 clock_id);
 int zynqmp_pm_clock_disable(u32 clock_id);
@@ -596,6 +597,11 @@ static inline int zynqmp_pm_get_chipid(u32 *idcode, u32 *version)
 	return -ENODEV;
 }
 
+static inline int zynqmp_pm_get_family_info(u32 *family, u32 *subfamily)
+{
+	return -ENODEV;
+}
+
 static inline int zynqmp_pm_query_data(struct zynqmp_pm_query_data qdata,
 				       u32 *out)
 {
-- 
2.17.1


