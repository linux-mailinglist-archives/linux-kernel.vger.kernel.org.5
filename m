Return-Path: <linux-kernel+bounces-18529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F14825ECD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 08:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DB5EB22E67
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 07:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE935687;
	Sat,  6 Jan 2024 07:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WjUapb+W"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F57263AD;
	Sat,  6 Jan 2024 07:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSIW+RCe8zIINW1R09pfVE06zzYv5wxkdaJyyVbIukB51o6SAbfWUjIYYP0ELXOXDm4aEFzs9xffgprbaDDIfSuMPqJ4jaNL9hikC+3s1X0ICm7hxOON0UEm/sm/GSFpmtwDfYHoyEek1eVZUaRW5n74LUX0d2TFuFRrAptanL2AZ6o4jOua1WSGxhm4jl0nGpZOobwmaPv0/4HFm0txOIYlkiDoY3eddeUobY8DbzAFic0gTTmDH1S0GKhNlnpQTpKl38QuSnZcbju73Tkp5wdynjuGckvAMh5QwFQ7y3y2iuApedHuMDIu0FVMgPuDtzfm0k43a8kNKFetzkKB2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+zSkDCkegGMZxyQOmJbK7cVsTWX8LzEg2S9aez9dMM=;
 b=Ab+5VTKlsRNcLtSDWWMQ0s4WKRAh9tKjo3avzqPFhuZhFLIpFO8IYQGsT7+ELKkHDd0Lt63P0zB/ZsSqxxTXYC73f5obOtUhGPOFApXe8GNMo05YO/Hhh2IP4yo49ajbIHiziqv3sFC1XaBeWE5K/JUwOjbYnKnrAcKUYWinnV0XIX7+PUfqDl9WL0ur5wG0z2pxjWbHqkHswZDvm0vWs+TXPkYDbCrQkWbpAKFAFe/Z0S2cxMapvgdFroJ6OIXN82y+bFoxcEk5x4elokLE2h1uLjKO024DDtm4J0+KAtqfO6V7gzkJrgd5K531gG3/QDwQxecrexUXFXvXs34Z2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+zSkDCkegGMZxyQOmJbK7cVsTWX8LzEg2S9aez9dMM=;
 b=WjUapb+Wz2wRv6Ch34xgB+DesNRv+ExkCrRV24+eE/ufdR0a3WVcyCPl/dGVTDXA1P4y15C0fIVy+YfXQ16ag5L+NXPOzgPfIZn2tiiBA16HF41i1/HPoxxJOO4d/hcOToC2tGY/gmGq7hocLUIBNQvCJPXcW2eW3pTp3BWEnL5EYJAqpIbIlomOi1hvlHpd1vvU7fBAYW30awYxehs067awPemIXB2af5loUCoWxM6v0hGRc6j1gJT28ikqyf+icQoouNuhT2DKE7nDkwx4mCuUY06CuIK6VGem79aGPVxy0o5LgP9SohnxRRkWoB0qFXIAY+X5AGg1Az8WfcPSQw==
Received: from BL1PR13CA0389.namprd13.prod.outlook.com (2603:10b6:208:2c0::34)
 by SJ1PR12MB6122.namprd12.prod.outlook.com (2603:10b6:a03:45b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.18; Sat, 6 Jan
 2024 07:53:02 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:2c0:cafe::e1) by BL1PR13CA0389.outlook.office365.com
 (2603:10b6:208:2c0::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15 via Frontend
 Transport; Sat, 6 Jan 2024 07:53:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.12 via Frontend Transport; Sat, 6 Jan 2024 07:53:01 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 5 Jan 2024
 23:52:45 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 5 Jan 2024
 23:52:44 -0800
Received: from build-petlozup-20231217T213756539.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.986.41 via
 Frontend Transport; Fri, 5 Jan 2024 23:52:44 -0800
From: Petlozu Pravareshwar <petlozup@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<p.zabel@pengutronix.de>, <dmitry.osipenko@collabora.com>,
	<ulf.hansson@linaro.org>, <kkartik@nvidia.com>, <cai.huoqing@linux.dev>,
	<spatra@nvidia.com>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <petlozup@nvidia.com>
Subject: [PATCH 3/3] soc/tegra: pmc: Update scratch as an optional aperture
Date: Sat, 6 Jan 2024 07:51:34 +0000
Message-ID: <20240106075134.3933491-3-petlozup@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240106075134.3933491-1-petlozup@nvidia.com>
References: <20240106075134.3933491-1-petlozup@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|SJ1PR12MB6122:EE_
X-MS-Office365-Filtering-Correlation-Id: bf76b01f-1af1-444b-160c-08dc0e8c81e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qRbB3J1c57UEm4+efbUTEFi/oXSPg7fzOHO3Uxe1maYAGdlUV5ffPaTg2WC/o1i82c4C0nQMUFCME94yoNyHMVcPk7EfP1is/xYqv2P0o4COwCqRdM7TMe50N0TlnwVP05/C2XR042atGEv1Yj3ZXDUGOrVxSdjSlxWeu0V1i8rUQKrM3uZM17CPYbQMogRVy4msS6ViXYaWYJK5Jld1zFr7hwhjFyWPrri1mZZLMdHQGkDrBL4pdkbRN8zCisGs7vDfXW6Bii/NKN9ijlrKCvyRTTZJ+T6HssUvuL1fXUa1R8lha85xeWVeUQfDssaA5kez7JdHhqND6CE5/PIQqeM1yYky50nzxOXq1tDruUTCQWHtlqvHL4yJs8YjC4q7H64hWkBQ1bjHxzeKSCW6ocdeWzSCJVuF7XCeMP/f4nM1sUIYL0W2WV8rNr70WynAy5daNG7wGIUs0iF9kU2pVwOKPQcGI0lmJXjor7NQSrkfVlmC8jQIKJz9LtMAhfNxihbvin+tB9XtRnc5uzeQLwKmJIN09fQ7LUjli30LE4bNP1gHYT1+5onp0bHfJbkTXxL5skWE1VYdnyFfoAky5eMLxB72bnkJbYGadEzEfrnuMJz8J6QUV6YvoBFLu/0P23DcJN0BrYBAk+FJRCxRLHCuitCz03bVOrGhavSG1OxG6Y/OPMLl/tCy/M4afh8O4ZMOAdB2RhKL8UEM9BUq7ol94vScDETJg5rTCTGg+m3wrTcKnpx8sO5M8w0EfqZk
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(376002)(136003)(230922051799003)(186009)(82310400011)(1800799012)(64100799003)(451199024)(36840700001)(46966006)(40470700004)(107886003)(2616005)(7696005)(83380400001)(26005)(336012)(426003)(1076003)(921011)(41300700001)(86362001)(4326008)(7416002)(8676002)(8936002)(110136005)(316002)(5660300002)(2906002)(36756003)(70206006)(70586007)(6666004)(478600001)(36860700001)(356005)(7636003)(47076005)(40480700001)(82740400003)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2024 07:53:01.5024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf76b01f-1af1-444b-160c-08dc0e8c81e2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6122

Scratch address space register is used to store reboot reason. For
some Tegra234 systems, the scratch space is not available to store
the reboot reason. This is because scratch region on these systems
is not accessible by the kernel as restricted by the Hypervisor.
Such systems would delist scratch aperture from PMC DT node.

Hence this change makes scratch as optional aperture and also avoids
registering reboot notifier if scratch address space isn't mapped.

Signed-off-by: Petlozu Pravareshwar <petlozup@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 0bc983f6b088..6948f78c7a4a 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -2903,11 +2903,16 @@ static int tegra_pmc_probe(struct platform_device *pdev)
 		if (IS_ERR(pmc->aotag))
 			return PTR_ERR(pmc->aotag);
 
+		/* "scratch" is an optional aperture */
 		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
 						"scratch");
-		pmc->scratch = devm_ioremap_resource(&pdev->dev, res);
-		if (IS_ERR(pmc->scratch))
-			return PTR_ERR(pmc->scratch);
+		if (res) {
+			pmc->scratch = devm_ioremap_resource(&pdev->dev, res);
+			if (IS_ERR(pmc->scratch))
+				return PTR_ERR(pmc->scratch);
+		} else {
+			pmc->scratch = NULL;
+		}
 	}
 
 	pmc->clk = devm_clk_get_optional(&pdev->dev, "pclk");
@@ -2919,12 +2924,15 @@ static int tegra_pmc_probe(struct platform_device *pdev)
 	 * PMC should be last resort for restarting since it soft-resets
 	 * CPU without resetting everything else.
 	 */
-	err = devm_register_reboot_notifier(&pdev->dev,
-					    &tegra_pmc_reboot_notifier);
-	if (err) {
-		dev_err(&pdev->dev, "unable to register reboot notifier, %d\n",
-			err);
-		return err;
+	if (pmc->scratch) {
+		err = devm_register_reboot_notifier(&pdev->dev,
+						    &tegra_pmc_reboot_notifier);
+		if (err) {
+			dev_err(&pdev->dev,
+				"unable to register reboot notifier, %d\n",
+				err);
+			return err;
+		}
 	}
 
 	err = devm_register_sys_off_handler(&pdev->dev,
-- 
2.17.1


