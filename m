Return-Path: <linux-kernel+bounces-29412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C43830DED
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADD1D283DAD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FD424B46;
	Wed, 17 Jan 2024 20:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W6fnQ+br"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FD924212;
	Wed, 17 Jan 2024 20:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705523161; cv=fail; b=A3MliP/Ee8za9FvXilk7Qa9WArGqaleQQSpBe/2si2YaZme9z7QTj2BT4hq6+QSBYqFnYJL9i4mN/k3eqNU21541lLRwXKCcgljRddTEq12WzP3CKyc0VokCcJjbvbhPjQvTDFOR41nyQYb9o0TMOFL9cUhLScseKIJoGCzbsko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705523161; c=relaxed/simple;
	bh=sM5TDWDdkTciCDHu7XfvC8zn4w5olz6VbTVdqilybWg=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:X-NVConfidentiality:
	 Content-Transfer-Encoding:Content-Type:X-NV-OnPremToCloud:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=NcAXair7486JDTSDzJ68GW0Yl7+JdXHd4fmpfyUNPT++DUIFNwcKjBCvvY1miV00s29nt6w/wfkWGsACF1120eg6H3A0ZcSGVQKB8YQWboqf8H4YXNGzvG09/VsBVwJq82neLkNH/GmtZG1GSAUxUHbRYlib31vICI2wvKSKvGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W6fnQ+br; arc=fail smtp.client-ip=40.107.220.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldVUC4eiPtDGpzB27d7+gp9JZYeYM7iiCWJteV50zbYplwGAbC1PxESxgi6YCrBXaQDKz1HQOYAVI/XIELuSfoAXobqLf/CHJEKrsxV8yx7hnKigTixylLBSU6vfvdLCIE1cePABaHANeIZKVbmkaYda4xZll8RkUj0cq5R0ILpzKNFvy50ef93qLeub3YDmM/ZP3cex1H28L5GodbtBW6spX+wC9iZQitZZkMjztUNsgD/IixlQNsxGQeomBfEY2Z96Nz04PS2Q5u9vzIoOAlds15LD2mE0tujikzNWs9Jv3wWijzhjNzUskHD2IeOOIAR5zgFPa1Gx0uFrWnTknw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJiEybngMI92Iy3qwnXSroDE5w9t3lDBr8Wk4gE436Q=;
 b=fNvTZMWf2zk9oE2agLrA7E9u5WpUpTAPQISBCs4YBGjAA/S6BioSrc4NxQ2py9oa1V8zd4Hn9tutoWLEjBeqhhRAF6Fgta5NA3oONLwSzEEE3xTkf6R6wQH8Zizy/y4A6uBzizi4xcTr5t0MhqkjEou7hqjnMQekt0Mkjg2UJ3shuZl0uyp2o1I+ZsCtSoOCuzm9PPQuoMTsvbD/x73u+tRUFub9U2Hix9YTdZrLTfE/txtIDWVk3gzN6M9lM8hwGLow3RrjO2zTo2VAlJSV8Zv/WkCKeIVViqpL5Wcu9CAacckMkUleFuN9uEDtD2KM9MXPQjeXyp5CrIwiYER0yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJiEybngMI92Iy3qwnXSroDE5w9t3lDBr8Wk4gE436Q=;
 b=W6fnQ+br94zOO2imYcp5pMN3QGlas7HZgaq7H/IEH2w6e26ybKM2Nvuy2TjkYVDBwX5oNftFy/i+01T4x9FMFHYwrFtlARTmhO1e3qRQngQxCUUoXZ4fYQTC1WgbGWHUNsDqZL2rV92Zw6n7Dy+mz3/EJ20lpS4SxcVHmg86mXRypY/3nRUxkdh83bdgUl2X1gnDzl4WPosxjQmLogsiq/Ip5xIVbAr8QWaUQjdnTRmZn8QlDTfUAwy59vdl7pdZeqsGb/Zv6ILIl5qn1jTkNObd3XqVIkv2QS5DSoo/OotQKVd6Z5keQzJPSePoBYy3hKkZtkUCEUkx1gj0kz062A==
Received: from BL1PR13CA0318.namprd13.prod.outlook.com (2603:10b6:208:2c1::23)
 by IA0PR12MB8745.namprd12.prod.outlook.com (2603:10b6:208:48d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 20:25:56 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:2c1:cafe::2d) by BL1PR13CA0318.outlook.office365.com
 (2603:10b6:208:2c1::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23 via Frontend
 Transport; Wed, 17 Jan 2024 20:25:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Wed, 17 Jan 2024 20:25:56 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 17 Jan
 2024 12:25:34 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 17 Jan 2024 12:25:33 -0800
Received: from build-petlozup-20240109T002231482.internal (10.127.8.12) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.986.41
 via Frontend Transport; Wed, 17 Jan 2024 12:25:33 -0800
From: Petlozu Pravareshwar <petlozup@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<p.zabel@pengutronix.de>, <dmitry.osipenko@collabora.com>,
	<ulf.hansson@linaro.org>, <kkartik@nvidia.com>, <cai.huoqing@linux.dev>,
	<spatra@nvidia.com>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <petlozup@nvidia.com>
Subject: [PATCH V2 1/3] soc/tegra: pmc: Update address mapping sequence for PMC apertures
Date: Wed, 17 Jan 2024 20:25:02 +0000
Message-ID: <20240117202504.943476-1-petlozup@nvidia.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|IA0PR12MB8745:EE_
X-MS-Office365-Filtering-Correlation-Id: fec80020-a929-40f5-1d81-08dc179a82d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	t8osFbnTl8WlPa5UwE6jcQUxuwQ8vm5IelZkloT7TZj30h4D1WVYjB10QzoRw278Zez1H/g1HTS7xrvOPwhXHNrwEU29422aleFqTHxPndHMENQqdCtsP42ya9jBuvxq0/VGH2T6cZNsrVcOQ+ST08SCh6POqqjMY+HnJ0CGpwAI3JfsIU8CiXJxE8D06fhgrj6BH+aD6fPKaBkfgg2En8SOydVraCL8BVFE5M2QXDqZcgnhnZy6MmInriu/j8WFUsviH8uyeN5Mgk5aIa/CZNIFWTYGIiq7Zl7QhaTaiYiToh+rbbNre9pm+vjdP2cwgk+5Q2TJ6a4Qen0a7ddl9xXEnei+CzI6TjBRSz989g+hSBWuBvd9fL0CYfqrcG9z8qajJMGE2LeXlzeDxbSo8qpWkvNLYSDiiKqfycOiI2jkb+6aFzIun0ChHaMI4kFG6rnE+oKbO3SF3EQf15cGjyV/L2zNyE0S6y3edgSGPU17iLffHVKWIF513H9xfWpP0zCmrjHSv/QZyEettfyPAldDt6SFTfUfUAp1KCzejR0z6QxUJ2oNwJQ/RVz/h/GDC+koxoR3Q3c1dQJ6BjTvNcze6TUFdN1lsLLH95Aan0xdYbT3o1/Gchj7crw42rUCR9mNJfNiwDsQKETBtgBhsmw5BPNb9Vwpb8A6+DtZcthy69to70+rylsikuVRhNeVUPBCBh8XaKgTpg34IsCDBIxb29717WvPvLwquXsomEOGR4/uIE+/Ijj/XcQIC2UK
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(82310400011)(40470700004)(46966006)(36840700001)(83380400001)(47076005)(1076003)(107886003)(26005)(426003)(336012)(2616005)(82740400003)(36860700001)(8676002)(4326008)(8936002)(478600001)(2906002)(41300700001)(7416002)(110136005)(6666004)(70586007)(70206006)(5660300002)(316002)(921011)(356005)(7636003)(86362001)(36756003)(40460700003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 20:25:56.5234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fec80020-a929-40f5-1d81-08dc179a82d4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8745

On Tegra SoCs prior to Tegra186, PMC has single address range only.
Starting from and after Tegra186, PMC has additional address ranges
apart from base address range. Currently in PMC driver, we try to
map these additional address ranges on all SoCs and if we fail then
we assume that the range is not valid for an SoC. This change makes
it more explicit on which address ranges are expected to be present
on which SoCs and maps the additional address ranges only on SoCs
from and after Tegra186.

Signed-off-by: Petlozu Pravareshwar <petlozup@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 6dfcc7f50ece..0bc983f6b088 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -384,6 +384,7 @@ struct tegra_pmc_soc {
 	bool has_blink_output;
 	bool has_usb_sleepwalk;
 	bool supports_core_domain;
+	bool has_single_mmio_aperture;
 };
 
 /**
@@ -2885,31 +2886,28 @@ static int tegra_pmc_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "wake");
-	if (res) {
+	if (pmc->soc->has_single_mmio_aperture) {
+		pmc->wake = base;
+		pmc->aotag = base;
+		pmc->scratch = base;
+	} else {
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+						"wake");
 		pmc->wake = devm_ioremap_resource(&pdev->dev, res);
 		if (IS_ERR(pmc->wake))
 			return PTR_ERR(pmc->wake);
-	} else {
-		pmc->wake = base;
-	}
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "aotag");
-	if (res) {
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+						"aotag");
 		pmc->aotag = devm_ioremap_resource(&pdev->dev, res);
 		if (IS_ERR(pmc->aotag))
 			return PTR_ERR(pmc->aotag);
-	} else {
-		pmc->aotag = base;
-	}
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "scratch");
-	if (res) {
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+						"scratch");
 		pmc->scratch = devm_ioremap_resource(&pdev->dev, res);
 		if (IS_ERR(pmc->scratch))
 			return PTR_ERR(pmc->scratch);
-	} else {
-		pmc->scratch = base;
 	}
 
 	pmc->clk = devm_clk_get_optional(&pdev->dev, "pclk");
@@ -3300,6 +3298,7 @@ static const struct tegra_pmc_soc tegra20_pmc_soc = {
 	.num_pmc_clks = 0,
 	.has_blink_output = true,
 	.has_usb_sleepwalk = true,
+	.has_single_mmio_aperture = true,
 };
 
 static const char * const tegra30_powergates[] = {
@@ -3361,6 +3360,7 @@ static const struct tegra_pmc_soc tegra30_pmc_soc = {
 	.num_pmc_clks = ARRAY_SIZE(tegra_pmc_clks_data),
 	.has_blink_output = true,
 	.has_usb_sleepwalk = true,
+	.has_single_mmio_aperture = true,
 };
 
 static const char * const tegra114_powergates[] = {
@@ -3418,6 +3418,7 @@ static const struct tegra_pmc_soc tegra114_pmc_soc = {
 	.num_pmc_clks = ARRAY_SIZE(tegra_pmc_clks_data),
 	.has_blink_output = true,
 	.has_usb_sleepwalk = true,
+	.has_single_mmio_aperture = true,
 };
 
 static const char * const tegra124_powergates[] = {
@@ -3562,6 +3563,7 @@ static const struct tegra_pmc_soc tegra124_pmc_soc = {
 	.num_pmc_clks = ARRAY_SIZE(tegra_pmc_clks_data),
 	.has_blink_output = true,
 	.has_usb_sleepwalk = true,
+	.has_single_mmio_aperture = true,
 };
 
 static const char * const tegra210_powergates[] = {
@@ -3725,6 +3727,7 @@ static const struct tegra_pmc_soc tegra210_pmc_soc = {
 	.num_pmc_clks = ARRAY_SIZE(tegra_pmc_clks_data),
 	.has_blink_output = true,
 	.has_usb_sleepwalk = true,
+	.has_single_mmio_aperture = true,
 };
 
 static const struct tegra_io_pad_soc tegra186_io_pads[] = {
@@ -3922,6 +3925,7 @@ static const struct tegra_pmc_soc tegra186_pmc_soc = {
 	.num_pmc_clks = 0,
 	.has_blink_output = false,
 	.has_usb_sleepwalk = false,
+	.has_single_mmio_aperture = false,
 };
 
 static const struct tegra_io_pad_soc tegra194_io_pads[] = {
@@ -4107,6 +4111,7 @@ static const struct tegra_pmc_soc tegra194_pmc_soc = {
 	.num_pmc_clks = 0,
 	.has_blink_output = false,
 	.has_usb_sleepwalk = false,
+	.has_single_mmio_aperture = false,
 };
 
 static const struct tegra_io_pad_soc tegra234_io_pads[] = {
@@ -4235,6 +4240,7 @@ static const struct tegra_pmc_soc tegra234_pmc_soc = {
 	.pmc_clks_data = NULL,
 	.num_pmc_clks = 0,
 	.has_blink_output = false,
+	.has_single_mmio_aperture = false,
 };
 
 static const struct of_device_id tegra_pmc_match[] = {
-- 
2.25.1


