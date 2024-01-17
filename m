Return-Path: <linux-kernel+bounces-29413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81505830DF0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0074A289D78
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1270524B3E;
	Wed, 17 Jan 2024 20:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m9GvoshX"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBD224212;
	Wed, 17 Jan 2024 20:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705523172; cv=fail; b=gBrPscnBlGTelPz92Fc98fTXZsBMqI8pAKe8mxCezZcJxd/GS0VzJLKIKlafwAdsRMI11Cm7kbOukeYvHNOaCjmVcR7piO3hK9Lv2SNfbK0dLyLoPw0wS+GZEaXC69isWKz3L+HXR0qof5RoiwyiDdLxC2y14HBVZeNpfxdbuiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705523172; c=relaxed/simple;
	bh=7D6ZtiJkYbqcXnxHQT7SZKbItYXhtlXEclFhrND0sEs=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
	 Content-Type:X-NV-OnPremToCloud:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=r8kmDjPQ8DaOV6lq5KqsvPZrhe/RYFi2uSTiM+d2pmC8sHiBRfCOSdUEid86pktMix33ZsesFYBDxmba3lNfhc/hFRWnNuW75Ln1tDSwqIq8Tk4BF3ipHezzAqMXS6Oxr7ybn9JJSnd+/7wd5VKIIi5dU94OMnKp7lZsxV33JDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m9GvoshX; arc=fail smtp.client-ip=40.107.94.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOp9t3RYyttwm7m2FFTA6BZOlRC8xFHVa1zuhIVcmPyLWYacHdugA0f8fPG6bza9Yi5DeA8nLNYL90CqcoQ67RE4A+GYmVOyvFr4FWf8/AtpD17BUXhC1Uw5VcHObh4viZce9VdvPXqB1omvPVaGiFHFdXJTZKR+Cbr3gj9LWDV0lUT3PlmxBoLjaxw7+iXeVbdRv4Sv5Ujfu7ZXlZ+k4qvvu5b3bD0A1hK8wYVHWN2EssVAWgEj/EtPlV0H8rhKcxnVJU6dBvXXRjdtSmsZ/l8A5MhhOysFtvUUe4LkPszUZztgnmIuOFdWX0nlgzGHzaIJV3xMhG5DJ7/LBM1CcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OnjgjbY1gsMSXE7gOiJP98ucV4gUu7z4kxx2Su1xqt4=;
 b=kcjObB0huBwdsjK+0OqQkHHOStmQAkEZJp0LH0GXOCeTTkdz/YtUY1SYeI+x8aYPSjIeMdlNAFRypPnV3/xQfCqoDDO0tuC92L7o8akXoQCrDatkVo/oLk3ojrLZWqsRRuOk+xnKFz1ZfJfGNHInAroQGgSQk27IMwYlbW6HbYJ1jGsBzPFwARtLkTUo5RKEcNL2Vo7XwqT7U+vQXVJ5WhhMSobOuvWXP/33SrDbvZYBWrsA8NhRAfIFPi6SNBPpru/0AaFOML9+Sm4iH5aIqFL6+ojfTrFW0ARa4p0WPQQwK8zQ+v0aynS5DFR1oscq5/pz6U2okuxJSdQ+jAukdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OnjgjbY1gsMSXE7gOiJP98ucV4gUu7z4kxx2Su1xqt4=;
 b=m9GvoshX6I46n4t0ndS4I4WVUB60qcuWfdLR+YLlyHt6i6AvgfQojJsvKSdnEs6qKd2I86xyV6kvYW81rOegXsoNMbYNbIhyF943R/CHILQ3rVUl2gxGM1awamf/LVRGudIVgEmX2xhCHpgoArbTlC+GJUZWDqmVc8iMQ1uC+cCQd8y8rM62s9VHyrSCSJbOcMeTPtDZXhvml6FvLNMnumpKrvlbIWNHkFp6xh17Qm/ACib6zXjI+LdN0iDm6H1U9gNm00lgVS5y6wj+5pHehU5KJk74FM9e4FQ/t8Rjc9Kn1V0rzTW7PSRCpNK65cM5ZD5GKBcX7dwO4tdER/Pl0Q==
Received: from BL1PR13CA0238.namprd13.prod.outlook.com (2603:10b6:208:2bf::33)
 by SN7PR12MB6766.namprd12.prod.outlook.com (2603:10b6:806:26a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 20:26:08 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:2bf:cafe::e8) by BL1PR13CA0238.outlook.office365.com
 (2603:10b6:208:2bf::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.8 via Frontend
 Transport; Wed, 17 Jan 2024 20:26:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Wed, 17 Jan 2024 20:26:07 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 17 Jan
 2024 12:25:58 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 17 Jan 2024 12:25:57 -0800
Received: from build-petlozup-20240109T002231482.internal (10.127.8.12) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.986.41
 via Frontend Transport; Wed, 17 Jan 2024 12:25:57 -0800
From: Petlozu Pravareshwar <petlozup@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<p.zabel@pengutronix.de>, <dmitry.osipenko@collabora.com>,
	<ulf.hansson@linaro.org>, <kkartik@nvidia.com>, <cai.huoqing@linux.dev>,
	<spatra@nvidia.com>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <petlozup@nvidia.com>
Subject: [PATCH V2 3/3] soc/tegra: pmc: Update scratch as an optional aperture
Date: Wed, 17 Jan 2024 20:25:04 +0000
Message-ID: <20240117202504.943476-3-petlozup@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240117202504.943476-1-petlozup@nvidia.com>
References: <20240117202504.943476-1-petlozup@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|SN7PR12MB6766:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c87052d-7dc8-44b9-4f44-08dc179a898a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FTdVH/CjXtosKIB5Vr8+zR/kk6NYAOwqNZLqSLFxnqndMO0AG8PoXs0SN+HmOEaARA1f04aaEH1ey94Jzcka8l9O6d582HLVwbB/seN+sRLZO0kEJKDItGhInlK2UsJoVgl04IHVKEUwINh9/Qs3iJ+oMN3Vb6kTWZR9bMP3txkltCrLbnbA17rCOrjauaI5DBgAjnp6QzQHm2aImQyeMUTAjXS3L28ckGfSuSqwdNwSRXkdBxKt7ZnNjfQEwbqMM19C+F/mLD8eStw5EwzOw0Kh7XqmUizQ7Apoq5X1yWnEHk7Gyw21zJjZbS0NFYrrCAh2IZQjSrfVeYkqVJ00fjnns0wfWjS15ledDlg4CqIFmo5wlm12Z3GHq7sInRj9FuArwvGrAwRKbnRAgRYOhUtdekO4kF5GKlg0RbMzjFXZU8BOAe4DxUjWzrG6Zz84lmPjb57BQNCcNq+XdqIpJQzZFkC9GqJnHD5pXOenhZwZiPqtLZQfN6hY4h8UeHUqzo9D3ItRByH5K29dYh6GmEFYA545bVPyivG6SQzNPM10X9wTelW1RC0+pDpKrTMPqPkblvpxeIQViAUiHjbG7+zr7w9f4vPMILctb2iuPUmCr50IPnk4BDBpfoQIlMtQQHBi3rYbkDXDxAKBZZ+USMOEuz2xPi/N6eDBVCToCxyV/Kk4811S0uSh2w+7fYIbZGzg+ZYRX9+LlCud0xeZqtU3DiY50R0PkYEiw7r3+cuVpvVjoZ10TuHmjqO6o7a+
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(451199024)(1800799012)(82310400011)(64100799003)(186009)(46966006)(36840700001)(40470700004)(921011)(5660300002)(7416002)(2906002)(41300700001)(82740400003)(1076003)(26005)(2616005)(40460700003)(83380400001)(40480700001)(336012)(426003)(6666004)(36860700001)(478600001)(47076005)(107886003)(4326008)(8676002)(86362001)(8936002)(70206006)(70586007)(7636003)(316002)(36756003)(110136005)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 20:26:07.7525
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c87052d-7dc8-44b9-4f44-08dc179a898a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6766

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
2.25.1


