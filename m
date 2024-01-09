Return-Path: <linux-kernel+bounces-20652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB0D828300
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06032289243
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1B0364AF;
	Tue,  9 Jan 2024 09:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="twsTy56z"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7D02D7AF;
	Tue,  9 Jan 2024 09:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGceS2+wNko8rLXxoYbeOO7hdxwBHh1ymuwdCdWYvxwQsbsg93/RocpPxj2KTFmBCgXE5vRIwwnT3HNzx9V1njuHn2YC+kiGBT8Btzv8qgK6KzZkh9lhvpiXO2BQ1ihMp6ZrGtUFqO7q2UzmYahoVhFULEM4djvokmx6VfEI+M2MvCjYqTZfRqjNrj/cm3/xwiXc+9+TVq2NAHtAOoz9HHnWJ4/6wi+tInithy6q6Mf+2JKBh3dQgM0aFpWOTRzY2cFV7BFYqdVugacxB8vwKxYcXYkIOoH3u9A/OurG7NP3gYtSBx2i3E1aUCu86/4wOF93+Z0gTlPdOEN1NlCScg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6pRStI4WXQmaoaemj41poelpm530T3JjqRn9zS7st0=;
 b=H8TQ0SEzaT2+YgbX9kBJ6xIUxmRyMnzQT1+ILQmwo/beeom19pzOoKKlwYTcK3lXtJD9RPm7ql0aEiRA3gbzJNo437B1sIrVhVBDxtPb8sutM8gzc2Wkc9rydvItG3WWK5O5xajeIGUIR3hVZW75q0I4pVmvpFZvgfnKM7xOxMvXW9kfuZLdFJJJwOPdyUHBDkJ75geThJaTXhHV/vnPLG/LNvpUvD9YEv6AkSrELPIymcigwAlLK1eOi6u8WElcZRI/8RaLv7L5vcrJJcQ9l7rkDuA5KqnCxY/9DhMAKTLatx66Tw75OqkZ/tmxp3ALPvKmxfLtLPxakJt189Etqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6pRStI4WXQmaoaemj41poelpm530T3JjqRn9zS7st0=;
 b=twsTy56zUqkpXTs4o+TVOl92mK/iYEq7JqJRPJtAbiNcF7gSIJDtRFKqBYAtdOavmIiP0LXUFEcbXCkiDrnGUnr79M/Sr8s4rIOUIB1dO6g2XB72Y/AYezE4HE+Fpkkhp7qY3vsrMI52lyAKAVWdiH94won8uTmYviRaP1q1+DTqaYC83udlI/jgocYCNszzGEIgv//MheqU57ykMaQ0/c7udryWK63NHCNugRmAclUKwga6BXUH3jufQ4ZorGMqMRdS4YCxgZWh6PR90Xq0dQwlTbILl9r0KGk5XKQnWMpt9p40a4w2cSVs7w1PrDIMTMwGCOAXdEysGugDPbE0bA==
Received: from PH8PR20CA0011.namprd20.prod.outlook.com (2603:10b6:510:23c::14)
 by LV2PR12MB5726.namprd12.prod.outlook.com (2603:10b6:408:17e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 09:19:02 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:510:23c:cafe::a6) by PH8PR20CA0011.outlook.office365.com
 (2603:10b6:510:23c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23 via Frontend
 Transport; Tue, 9 Jan 2024 09:19:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.13 via Frontend Transport; Tue, 9 Jan 2024 09:19:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 9 Jan 2024
 01:18:49 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 9 Jan 2024
 01:18:48 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Tue, 9 Jan 2024 01:18:44 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <mperttunen@nvidia.com>,
	<linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<krzk@kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v3 4/5] arm64: defconfig: Enable Tegra Security Engine
Date: Tue, 9 Jan 2024 14:47:07 +0530
Message-ID: <20240109091708.66977-5-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240109091708.66977-1-akhilrajeev@nvidia.com>
References: <20240109091708.66977-1-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|LV2PR12MB5726:EE_
X-MS-Office365-Filtering-Correlation-Id: a2d7e4bf-7ebf-483d-5ce8-08dc10f404d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0FBTM2NhrwUcBknYXdk9DY41jmJfvN1H4crvfUWvEblhE/x8+Kcwjcc1usUn41p0cLIfZLjRIeq5oNZ+01uD3ZseSyEvBfaIF6hXin+erb1EVnKJNsOlEei3TwHzWomfGr0K1pITCCK20p8mhJKJ0n5QKIYknlBRQac/Eixmj1O66b8kG/H1gfBPLiFbroWO4bea/zkaoHM5aPtSTufDqKj/mopg/lflOe+HxH2gzJbIEnF8qAnZYySIbjihS9Sq8z6rf4ONe8KddonIbN4r6Kmp1eotDRpUdWsfbGtl9akOSse1Du7SrgqHzZTp7oF0ANjV/TR4JXzsHFCKWdbwyRVKlrepgGdBvy7f/hufGUZ96LYpnHCLTra3llcSk/HdOX8Hw3OVxI5nVacuhU5I11DadgeRmdptuI88yuLzyVAYOlIoWqNM/BVtOz/OXcRHSQcgyRAeLQkSG943nMTwAiKlU8aHinsmR4WfDwDY2El7ASojgoeQbfeVFG44nRFJR8ONMChQO6YSHv7L7shtudAUE4QjrIixSY4u5CeH0RlhK+A4xlwKp++wpAzB/d0ff1Ev7U+rrcH0m78gzTC7a38b56dTwPn4owR/1p30ifADl8H8uKCpkEkMi35L1nuW53gPb4yLzk6cFlDlFmVm2+CKxoE5/DCV6JLQU3JO4pBWjYWlOdwHLv/qubcNSQ73vHi++oZSmEWjsDrXPjbFZWtr+wLNRjdUTdBYUcKKDg0udbGXk9xZJAUgFpH79hVE9Yax6a3KD8k0k7MpucMS5A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(186009)(82310400011)(451199024)(64100799003)(1800799012)(36840700001)(46966006)(40470700004)(4326008)(70206006)(70586007)(47076005)(8676002)(8936002)(26005)(1076003)(426003)(336012)(478600001)(107886003)(2616005)(83380400001)(2906002)(41300700001)(15650500001)(5660300002)(82740400003)(4744005)(7416002)(7696005)(7636003)(316002)(356005)(40480700001)(86362001)(36860700001)(6666004)(36756003)(921011)(110136005)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 09:19:01.7780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d7e4bf-7ebf-483d-5ce8-08dc10f404d9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5726

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


