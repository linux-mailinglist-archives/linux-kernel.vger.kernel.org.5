Return-Path: <linux-kernel+bounces-18527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EB5825EC0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 08:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CD041C236B3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 07:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA21346BF;
	Sat,  6 Jan 2024 07:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NILdqwF9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2070.outbound.protection.outlook.com [40.107.96.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ED55232;
	Sat,  6 Jan 2024 07:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IlU6CapIOAhspY/npnNo0cDX0wWYmvsH3d9x+pDFd3GVqLqMb69YO0RJNfuWSYPfkheOcIbwgeh0LtETF1dk7TEUKaBrZ82UBbS3kCbUJ2bSu4zMxmhfLmTsY97IGgE4Xsd7wBJNW/YxeESroWaxonXbenRwiCF4VZ6CDIS0FrhIk62R+TT9+co59tV5iTd6pzRIpyX9x51eBAsMGQVP0KNmg7Cy56N4DN7uVypwDRyCdfmHGYFe9XN4Razd3dfgJRXuvIZhrGfKZizaPtTHHV997EYXkaO2+BuBfVr0xT1UsSFtjzv1Wf3290JxEgIb4q7OgbpY3XEdZ6Gv0QnjoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvjztS7so92mNXj5AyvvI7xMsN+GCzW9UZvZG1fEHz4=;
 b=E2arftG/ZAtR3dBxqB3fPwQksqJ4OdtLjAs32De7f/4fHuRERX7gbTAzP5E4Zjt+gh/Mfu1yLsV1A8jpurUojAr2i8P/DuKz0O0HD2LGSG+8VG8rAiCb+gEgiPTdLeCbeZ88wmmIIpJ+3YY3BZkLo82g4Cj5Qyvav4pMK9Nbo0h/yhvTXLAmJY1BUUcKbTjwXKxy/FciM821zM1s/fYgfAjQdplEBLnHDGMHoJJV6Z/WTGmFDR3cfJDhLyVJxwK/Ktch5NdX7qHhlK105Qozi0EXrv+UfZLOJ9u59U9mY8pf3WRDOMB77FtMts2XdAaeJHiG78MAB0/MUoayBIifqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvjztS7so92mNXj5AyvvI7xMsN+GCzW9UZvZG1fEHz4=;
 b=NILdqwF9iPg+qsOAO+x4I8KbuJDTG7ltEKWMJnZDlmju2FuS8TzicJuIUJfhWEhnwsBjQAPbASxW/50Rj+1at6IjYDElPq5dasV7jYqVPQ8l8QX1vJMs+xuv3XzkfSclXNMK9QNgIRuCoB+0Qc2gzYqMbR+fbTJQSF4u8+KYZJhQixMvnVhvvDBtUMf4Hp3n6pI+CWFLuCnAO0ADupLIsYGXmnfV/zvP6wTHt9OOUKV3hDv7bKf5caDqA8R+jqCDVlcXFJEEMwJFhqTslrXEj9fRizHdCuTU5FspPOSMQTuT67ME5G2wTFTT/TdQLo8pV+h0YGmzC7huBxkuEDa/TA==
Received: from BYAPR01CA0019.prod.exchangelabs.com (2603:10b6:a02:80::32) by
 MW6PR12MB8916.namprd12.prod.outlook.com (2603:10b6:303:24b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.18; Sat, 6 Jan
 2024 07:52:26 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a02:80:cafe::f8) by BYAPR01CA0019.outlook.office365.com
 (2603:10b6:a02:80::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.18 via Frontend
 Transport; Sat, 6 Jan 2024 07:52:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.12 via Frontend Transport; Sat, 6 Jan 2024 07:52:26 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 5 Jan 2024
 23:52:14 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 5 Jan 2024
 23:52:13 -0800
Received: from build-petlozup-20231217T213756539.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.986.41 via
 Frontend Transport; Fri, 5 Jan 2024 23:52:13 -0800
From: Petlozu Pravareshwar <petlozup@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<p.zabel@pengutronix.de>, <dmitry.osipenko@collabora.com>,
	<ulf.hansson@linaro.org>, <kkartik@nvidia.com>, <cai.huoqing@linux.dev>,
	<spatra@nvidia.com>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <petlozup@nvidia.com>
Subject: [PATCH 1/3] soc/tegra: pmc: Update address mapping sequence for PMC apertures
Date: Sat, 6 Jan 2024 07:51:32 +0000
Message-ID: <20240106075134.3933491-1-petlozup@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|MW6PR12MB8916:EE_
X-MS-Office365-Filtering-Correlation-Id: 220909dc-9a10-4555-5a73-08dc0e8c6cda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zqDsNiXtBXQqASj6h+ddfeoEjiCF0kNKZI1hoRyKrsvzWgXiFXVt2RB1KYf+CCL363BBer9o5Kl/g4McoBI9bOb6Vvv4u4th4rMe/9JECMkpjGnLZjptIyKIG6xVdwgwIigxbYiYSP30ZoepY6bI/+N7auNXmxFlXVmnctMmuKjbrUTFnEGYIwfvudawnGVPxsyh4M5EopLXqof+S6nAfmqNAL61uhmMm6Uv5ri/vlwAkC2gtiHALzzfBOjqO40H5GNSQYaFq90COXnhGwtkE3k4eBjknauoo2HPu6JDLFgEWf7IpY/IHupfnFD01U/Olnf5i9HIflc3UIdE4iOQvp3AJC6mXNroCyS1M7dFMEYAPTqrtteBgjILr1tPsGy7zRNFw0Q+W1nlxRfUQ0h92Wh0dhYgKALpO56DpzdK7R4XC4WUIsaeIyWqZKZT/41n51JZpbgRr/s/jIV3Lz+nGCscIy0PVdnXZCkksdeD54PJUaFCeBqIdYBWhBLY8CL8hoDN37oIuyDEy71Ye00sE9LBAhoXoVZiv0ecDlr9SXPh5E9uWbysNLEt4QgrS3UGXoRlQgZNrj7NvAAPYNyVYrpMksjVOoieYnWzLupN2B6pqluTcPrDGOlXc8OT0uNQdY2fFU46thZceKNn8nTUxv6whUuMfBcGPhNUyUVbrx7KfpIUkuF9hKT8Ndfypo1V5NQ97xX6DURUngDG8hfQKoUvXq1yi8D1pZhDfrDNC3Z3lVNRABiYBEnxfAnHTJNB
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(1800799012)(451199024)(82310400011)(64100799003)(186009)(36840700001)(46966006)(40470700004)(1076003)(26005)(426003)(336012)(2616005)(478600001)(6666004)(7696005)(47076005)(36860700001)(83380400001)(107886003)(2906002)(5660300002)(7416002)(41300700001)(316002)(70206006)(110136005)(4326008)(8936002)(8676002)(70586007)(921011)(82740400003)(86362001)(356005)(7636003)(36756003)(40460700003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2024 07:52:26.2977
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 220909dc-9a10-4555-5a73-08dc0e8c6cda
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8916

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
2.17.1


