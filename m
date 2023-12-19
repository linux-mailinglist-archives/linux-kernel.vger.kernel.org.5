Return-Path: <linux-kernel+bounces-5223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5503A818828
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A452B22380
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D75218EC1;
	Tue, 19 Dec 2023 12:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LOMcPuRX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFBE1A5A7;
	Tue, 19 Dec 2023 12:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/z6pLShC6VUDHispkSTsw+gwpR2a0BQwczp2I8DmKDvi1nXNH7/0CWcNZgQbylp36nXPKtvK5F1NO/hrMdfhRohRItNWTvoDxRfx7tCewqQUxgT5t0DdAEj/HJe9IcxwFqKrOzrBCJiiiLiEZw8bV/m3dWi1cENfYtCNgK+vsvdawMN+9235HTkHpY8ySTlayuFoDa0KLAy9nO2ZbbhwAG48ZMVTPXLPobAFWhawNVPWMch7VpSgZfx0Dk1B1lzEUvcII2gHidSbR6MauunIXNgMLu0EIVEcEdy3LDVAmORTqOyQJt0BrVjWxVIMzNAc8smRqYiFfpDuxLS7G1wVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6pRStI4WXQmaoaemj41poelpm530T3JjqRn9zS7st0=;
 b=Lw67YW+uCAWvjg8gwQAb/LQn5LHp8v0ZHa8y4KtDZf3P6MJzq6MBkOcMIfTsVyEmRypHUr3t9BWUtLr2pcWk1DrFK/Wfy4BffV6eicSWRQWPjoZxVZctFR0rnp0X9I8yB/RPnjTHZX2Erl9oisQ0aufEWYiQsjlaMU0pXKdvv2JDHW0Li5osBjr8roaex1P5vEKgrp354E/sIoQIFL8g5e29lAFf0xj5sq7WQYiixr6OhqWZr/YrPe36ldbPl6FiUwHpo6e1IIDqC2xQ0oA/rRleyHwkJcJqpgwvW7vyMCekYQExYOz1kqrtmMibNm3jf5aq+e2kZJ28jpuBbOkX0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6pRStI4WXQmaoaemj41poelpm530T3JjqRn9zS7st0=;
 b=LOMcPuRXi/HRDtKg1fdJqYsMfu+4hXRunhwy0aOcKwajPG43ZPdaVJm7wTKkDth9ziwFImfqYsR4U8N5YKByiTvNzqFZIn+lTZY2ws4CCGYp5J48KHOTVMFur/Nu2xFEUWlF1Y3ZM76hZZNpuSHK7LHtyFt5ljAGOzC68bINlrlb3HgPFZgG6L9SuTUkrFf5WDv8C7ygr2hM5zicFyofkj1esYvfr8PfOlIC5dTFPDs1MvkoKevHFhb8z4wWeLrdgygnNY46pWsbgTOLLPA/D5v2J4lsip3JhVfbWtNTiWEJUoTDJ4LpchWP0b+QRpam7YQbxl7ic/K9Qm+H223fiA==
Received: from CY5PR22CA0034.namprd22.prod.outlook.com (2603:10b6:930:1d::10)
 by MN0PR12MB6199.namprd12.prod.outlook.com (2603:10b6:208:3c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Tue, 19 Dec
 2023 12:57:24 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:930:1d:cafe::5c) by CY5PR22CA0034.outlook.office365.com
 (2603:10b6:930:1d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38 via Frontend
 Transport; Tue, 19 Dec 2023 12:57:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.14 via Frontend Transport; Tue, 19 Dec 2023 12:57:22 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 19 Dec
 2023 04:57:17 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 19 Dec 2023 04:57:17 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Tue, 19 Dec 2023 04:57:13 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <mperttunen@nvidia.com>,
	<linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<krzk@kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v2 4/5] arm64: defconfig: Enable Tegra Security Engine
Date: Tue, 19 Dec 2023 18:26:13 +0530
Message-ID: <20231219125614.33062-5-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231219125614.33062-1-akhilrajeev@nvidia.com>
References: <20231219125614.33062-1-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|MN0PR12MB6199:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a2eedaa-4776-4b9b-6c59-08dc00920aed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	me3CdcCVEEbePCo9E1fdXRV4BsEsmKxT33BF9odXJNCrWNQOLurHgt6+7m5Cq3FuS05tUodGplDRYDtaQH4NmOfUco8ef+ngFyMiU4oKnzXYmK7ohHj7TD4oB7ie4tzW0CaPY9G91CwXBBkFHc48mVF8zCDIAO5D11jqX8Eu2AxqPJ9nvwwezy/GnSRZJ73cHC9rY+LXcCpiJpTs/9LR0lfZqm/N1ox2+dJFK7h04WO7V7DAKoz5pqpCL9+uyriL2hxZ0Kv8+rxKD1aA4h9eRzo1bCxGzWt6M4G2QQeiS8P82x99aI/QulwMXXbz1fC7ys7zQ4KE0lxbBR5TcjL3tPqfrA7LtrGzOC/AW1I8YLA+B/JWAwIKhhVZ4mk7jKwS+ryM6NfNTswCo4Fu3O+UsMCCUbCVHyIKJGGGQM5r2IFxPSS4osN1BJHEFXTXxqM1YvjM41YdHepKj/57uDcntC9v4dYDqbnRSD3WGTO1HBdcbFcdXSHNiIPwiZvXDKPJDJcWyInz0ScvhZX/gOd0NznaPwPbpEt0FvE3xG96hzgCOqT+aMg4aUV611YCrKlcFgRXegsSbB9KB54FqZU2vJyHpowbvCWTpUqMAC7FurtxufBCqBZ2RpGXoqawWut+Zc5FTDaJuy/K5BqggBoQ6dsIrdIxIG7pDvrstxiB7fj590AFKt+dPoP9twzpE1zhWm+w/2/MhjzLGfO0t2KTJnSdrFh9jHPOi5u5s5n2QERw5RgNyifHBUUcYslzCci2xvkABZPwTmN9ktTFpRHL2g==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(82310400011)(64100799003)(186009)(451199024)(1800799012)(40470700004)(36840700001)(46966006)(40480700001)(7416002)(47076005)(4326008)(8936002)(8676002)(5660300002)(7696005)(4744005)(83380400001)(70206006)(316002)(426003)(70586007)(15650500001)(2906002)(36860700001)(110136005)(336012)(7636003)(82740400003)(1076003)(356005)(107886003)(86362001)(26005)(478600001)(2616005)(36756003)(41300700001)(40460700003)(921008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 12:57:22.7387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a2eedaa-4776-4b9b-6c59-08dc00920aed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6199

Enable Tegra Security Engine which can accelerate various
AES and HASH algorithms on supported hardware.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0e67a4849b91..4f5b01cc3b1a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1602,6 +1602,7 @@ CONFIG_CRYPTO_DEV_FSL_CAAM=m
 CONFIG_CRYPTO_DEV_FSL_DPAA2_CAAM=m
 CONFIG_CRYPTO_DEV_QCE=m
 CONFIG_CRYPTO_DEV_QCOM_RNG=m
+CONFIG_CRYPTO_DEV_TEGRA=m
 CONFIG_CRYPTO_DEV_CCREE=m
 CONFIG_CRYPTO_DEV_HISI_SEC2=m
 CONFIG_CRYPTO_DEV_HISI_ZIP=m
-- 
2.17.1


