Return-Path: <linux-kernel+bounces-6411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB02819884
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89D241F28D4F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 06:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03D511C81;
	Wed, 20 Dec 2023 06:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s3cHdDKo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1D214A8E;
	Wed, 20 Dec 2023 06:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GibVEpbzLmPaQ6YOuwWFc7eYcgBsYfizWfA/om5DU0ep8yynhfgBhUYE+xD35qSYGuN+ilTHGkz9BACu47FTSqEcu9tkZBDtYrvaF4EmV9aDpedqQ4XMSvgjTpP2HtnIGjw/OvIU1ITZlZa5hAtvm5zs84Nqwddgls+uMnGl5n6wdwFZDbIbl+bMhu4g1ApKCwQ070QiJbIKT0sk6byf9a0If4hloDFd5oDZUBvkeoOoPrD2PIAceudMYDZetr8h+zxlqZ0snKrH37PnApNt3FrqKS8ziq65oMGBJDyEfCtaKiUiEjUaZN9tRWDTxReSZShVDcFSAAS8Ql8XxXMxgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvpCDCJWM1UuTRRKmCuKrt9FkbqK3tcFcA3v2ZC6LF0=;
 b=fg4u1C0cjPXGxkV/sBsBLGym3p9aGuDoWOBZeAKEwwpza0v/cjRrNQRySry2FBCk0llAno2qmwGo5dumkPgaBMdEE5WIz2liJWO5kN2ouBbuXLThaSPhBiCqHurfrQvAXC44PZsOqY9SxzHa8G3GKDaK6SisXPmb/DRZum9Jvy4BXnqSegVYsdzMnVLOq6oEB5ZIx0aBNlzamgGwtYBMQeslQxQAeez54GHDCCGsIgpqpGabwGHveDJPQTT4zDpkk6m0LM6pq14XMKYHFlxWQ1xMBKXMSaSZd+Due6j7/TKXNG6zUgVQgPL+abPNgMzXjUVKYVkrMFd/0H7jmI659A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=infradead.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvpCDCJWM1UuTRRKmCuKrt9FkbqK3tcFcA3v2ZC6LF0=;
 b=s3cHdDKoXCpBjGBInBeJE3snpO6m2LR7FImkjXjiIyu3SrtZ2WJu8S+/Eon4rptAjYHrVzuOiaLloVmPXBXiAtZOTMLyewBVZsAAmc4sMQRH4x5Zbk4WwFrAEjV7+YDeS5g1NBei1dmnp/BIcQeWDQZxyimWtwia0AtUgJn0Isi13oHl3lCLDDmomUMQtf+kL27J8OuwerDuoPGEef8S7n5/1XX4LgBML+bbuuR/qnPcX5zn3TBqUVmyrQh37YhFAUNCosS19Qk+4woitxXqVO682hc6tRiQuLfRPI7uzATicXwq8jgRtuzRtdHh1LqVZtf72Ow46c0/hSyjzR17nw==
Received: from CY8PR11CA0029.namprd11.prod.outlook.com (2603:10b6:930:4a::11)
 by DM4PR12MB6327.namprd12.prod.outlook.com (2603:10b6:8:a2::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.18; Wed, 20 Dec 2023 06:10:31 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:930:4a:cafe::51) by CY8PR11CA0029.outlook.office365.com
 (2603:10b6:930:4a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Wed, 20 Dec 2023 06:10:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.14 via Frontend Transport; Wed, 20 Dec 2023 06:10:31 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 19 Dec
 2023 22:10:21 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 19 Dec 2023 22:10:20 -0800
Received: from localhost.localdomain (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Tue, 19 Dec 2023 22:10:18 -0800
From: Kartik <kkartik@nvidia.com>
To: <rdunlap@infradead.org>, <sfr@canb.auug.org.au>,
	<thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <kkartik@nvidia.com>,
	<frank.li@vivo.com>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] soc/tegra: fuse: Define tegra194_soc_attr_group for Tegra241
Date: Wed, 20 Dec 2023 11:40:13 +0530
Message-ID: <20231220061013.120173-1-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|DM4PR12MB6327:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b5095de-ecbf-4303-0d33-08dc01225ef7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3D+4DKypmi3titUhoTnnWfSDA4SoR93JjqlB2roSy3Jbc7hTzZB67lYvUMG1DY/VSLXJkLgZw5QIlcP+Pn/1d0reMOmkFw07IP3++USNO/zx2uuOihTftlfSBDcxcviYtiNanNA02LfuJVRN5of46Qj1zmCYSXAJmLb8eF4xno57oBdRu6ryqj/XlqVX8j/0VMgq1cd0VzX1b4F4jI+qluM4pj2n4w5szvIwMt1A12bcly94kRbmR/ZPhU3QFESbWautF2ty+Kb3SokknUnwTr3sqTEOJwF+qTT4vZFXElpQeixmuT/HbuHot+w6Suun9EW1ioAetreXWLoEZR3EiQGciBpvTkc/bdQ/Gbq9EDThk4kgs1CIhFk3dty0YHPq3bz2NnFMoOf6tgHIk7lwhsHVMPrwWKBpQPdVTraTVcMzSfzvN5KeDCcbzcKXeaEDQeaK9G5ElvJETOxaJa1Z4AmMRXkTlSouB0iBHHvOtxh9cNxim3ILRS86p1pPPEg17KERSf+8YcpSHKev51cWQ1wsdM67Y2zHn8mdrYhz3vXd12R1PGDodfmaQZb9CQESs0JtBqFK7qfF5kHAveSUh5PP1YaOuIf+ssqrC9t8zSEySI0L8LQ0FXRo3cs2Tb0iDrX53D9iH3j8mNehzyfvqzWwRM/P/U7JxkJJntNmQctYHl1Pn0YhKUYUn/CLm3jGJf/FFa2+7uF136iwccpGUFEbcHddd4el9fFc170upTLPzCm0mo96CPQ3DAjywYnY
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(376002)(396003)(230922051799003)(64100799003)(82310400011)(451199024)(186009)(1800799012)(46966006)(40470700004)(36840700001)(26005)(2906002)(8676002)(8936002)(36756003)(5660300002)(1076003)(6666004)(86362001)(2616005)(41300700001)(40480700001)(83380400001)(47076005)(7636003)(110136005)(70586007)(70206006)(336012)(40460700003)(426003)(36860700001)(478600001)(316002)(82740400003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 06:10:31.2595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b5095de-ecbf-4303-0d33-08dc01225ef7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6327

Tegra241 SoC data uses tegra194_soc_attr_group, which is only defined
if config CONFIG_ARCH_TEGRA_194_SOC or CONFIG_ARCH_TEGRA_234_SOC or
both are enabled. This causes a build failure if both of these configs
are disabled and CONFIG_ARCH_TEGRA_241_SOC is enabled.

Define tegra194_soc_attr_group if CONFIG_ARCH_TEGRA_241_SOC is enabled.

Signed-off-by: Kartik <kkartik@nvidia.com>
---
 drivers/soc/tegra/fuse/fuse-tegra.c | 3 ++-
 drivers/soc/tegra/fuse/fuse.h       | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index 233b8e7bb41b..c34efa5bf44c 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -407,7 +407,8 @@ const struct attribute_group tegra_soc_attr_group = {
 };
 
 #if IS_ENABLED(CONFIG_ARCH_TEGRA_194_SOC) || \
-    IS_ENABLED(CONFIG_ARCH_TEGRA_234_SOC)
+    IS_ENABLED(CONFIG_ARCH_TEGRA_234_SOC) || \
+    IS_ENABLED(CONFIG_ARCH_TEGRA_241_SOC)
 static ssize_t platform_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
diff --git a/drivers/soc/tegra/fuse/fuse.h b/drivers/soc/tegra/fuse/fuse.h
index f3b705327c20..9fee6ad6ad9e 100644
--- a/drivers/soc/tegra/fuse/fuse.h
+++ b/drivers/soc/tegra/fuse/fuse.h
@@ -124,7 +124,8 @@ extern const struct tegra_fuse_soc tegra186_fuse_soc;
 #endif
 
 #if IS_ENABLED(CONFIG_ARCH_TEGRA_194_SOC) || \
-    IS_ENABLED(CONFIG_ARCH_TEGRA_234_SOC)
+    IS_ENABLED(CONFIG_ARCH_TEGRA_234_SOC) || \
+    IS_ENABLED(CONFIG_ARCH_TEGRA_241_SOC)
 extern const struct attribute_group tegra194_soc_attr_group;
 #endif
 
-- 
2.34.1


