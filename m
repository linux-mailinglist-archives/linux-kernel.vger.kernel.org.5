Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBAA7C6B78
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377933AbjJLKtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377702AbjJLKt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:49:28 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBABC4;
        Thu, 12 Oct 2023 03:49:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Db7TL8TF779bSr1XucJgdkq+GduQbAZcKSPNauxeSb7hgEOU7LieTnyUbrDLsDuBsfGAc07k5LfyMWQ5ES8dFOFiOMYKo7qNovrQKmbg88AV5t9D5xIv4q3hQhQWIIjf7SjLhPfYJc3BD27Q3KuRVe+f6zTQKIhS9dHt/GpEGSY/SmQNm0F8z8qc41kyG1oWPppTH+UFzihqtngqXETgeuBDkgncSuJW8MfiSp0tGZWYzkGMTyJwg6AGvcmRJASL7jjSSerdS/ScGYueORLoNN/tjlhugoVcsmthc08fh0TOYLZUWTc7EWjpfGTztVMnJtxTPI6ttI5YrgYUbWohWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCXyCAN+Z9iaXkCKs07MgaSMxgqw/GNeOGLQ5RSx8Lk=;
 b=K7V3eACpk0sPQvszs6jldXPJjQ/XhZBbj9xOCT9OoPzY3nDNeRljvOkyNx7+E1ridAbhvI/y751murSB/e5lkS+ZPHIrrY3DwgBN6WRPeuR4ElfsUiAmDgIAOvA3/ZCa9wLFDydUtRMoyx7+UIk0tqgq8IE+cVCsj2b1+XHOSzS+Baz+aK60rWnQfSNNka6WHL+t9fys3OrwIQOu5hWZ3A+IEqgmFh8emmOiWOCdfX8mCBOl0QiRJgddiZcE5xSPL27tjMjkWwU+ExXZRkgObEzu7Krntug1K44HvhiaKxEoSeAVffTPF3rUQyz9B8cO9MdyBheKl95vh4v1Wfj2iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCXyCAN+Z9iaXkCKs07MgaSMxgqw/GNeOGLQ5RSx8Lk=;
 b=PXkj5eIIDQpULIHHjnkOEV9Wdkxb9hE5jbtV4/kVo0EJzK9f/KW6xMoYRnajmd3PCFuGiux2Q/3PGpNjzXZsMv6JJuKkgSK2egFZPhXSruW9TDIEZNXjPP3h0ybOwLY3J4eNpJLIGbJtaRpsiE5xqzuXUIY7hCBjjVmUEZ0S5jCyDdVcpwp51RvIcxOnMoFsdVQBo/4EVbmqRyJwuaEHuLwfXt5xI4wZgNERM4P1vPff8diIaCX10/1w+nJxst9b/g21nsRiZxuMOp2uVbDgAuwW01zZpUXjSx21sLMgl4/j1hcAc1dvIz+rBY4bGWx37ebm10klRdNCgzaWZjbxjw==
Received: from CY5PR19CA0052.namprd19.prod.outlook.com (2603:10b6:930:1a::17)
 by DS0PR12MB8069.namprd12.prod.outlook.com (2603:10b6:8:f0::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.45; Thu, 12 Oct 2023 10:49:25 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:930:1a:cafe::a6) by CY5PR19CA0052.outlook.office365.com
 (2603:10b6:930:1a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.27 via Frontend
 Transport; Thu, 12 Oct 2023 10:49:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Thu, 12 Oct 2023 10:49:24 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 12 Oct
 2023 03:49:14 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 12 Oct
 2023 03:49:14 -0700
Received: from moonraker.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Thu, 12 Oct 2023 03:49:12 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Johnny Liu <johnliu@nvidia.com>,
        Ankur Pawar <ankurp@nvidia.com>
Subject: [PATCH] memory: tegra: Add Tegra234 clients for RCE and VI
Date:   Thu, 12 Oct 2023 11:49:09 +0100
Message-ID: <20231012104909.48518-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|DS0PR12MB8069:EE_
X-MS-Office365-Filtering-Correlation-Id: 2599ab24-bd66-4ff5-b53d-08dbcb10e676
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mdJb9xs3S5CEmBMtOVMW/4xshvXLVeBIvKx4HMqEjHwodtk8yLg4qGJiB0AKujqwY5rW0GYozHtJIsZfBPPhpkZXu2P5hrQ2wSjVNav22p+4He6kufiSvButBEf+0f3c2iwd87UelIkvizzClrCYsbyXyjaB8xu06scegfW+YcTsp7q12gRZHTzeTuuSI0RpqWMSJJPrYZCWYCMcfPRMpsczH8FhaX0IzLa68HX3Tc0qBghuZzoJUexn27JWQnTyN0elz3kg2IzD7KDYxKLcRQ4u2Fqg4iIKw0SWmW6BGD42l5BlsHWyPBCE6ICrLipPvjnB8MhxwYD73lntZetwcc7Pcmcoq4NtOTRzyeAm7rWuALUHBYddh9ZLeqS9k8PnQMAijbpYpd2RHtrfNndBhkO6GQ5c6UGvwSaVQbG23FHdh+zUJGhDCqpsT4tKRxU/tVCEcgOX99DIg7p9fV/5BZJGUceeuzIr72M4cYMF9qjn4PsG2KJdiyFRyq74ieSrOORnpJzj6XeSwSe54csHhXcZRGsaAv4sLaC34/Xn/G2WH/Gi98UjcWlEvntEpS9thmvIUKqPQcoTmc5gOrnZoWpBWOf20UkvKUxEDDpH4yBvuK6skQGTwbj/FztulL1FlhdrX2lckrxnmew9MEv+GQirHfG4y7WmDiBPLz2qkkjR15uFU1Pet5jUW6Rex45n8eqkl1IR5KjqOi0Hymgco9K4fWJ128ScMP4Iro5Lb2t61OlCMyAz6AY08c+lsBWE
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(82310400011)(64100799003)(46966006)(40470700004)(36840700001)(8676002)(8936002)(4326008)(41300700001)(5660300002)(40460700003)(83380400001)(2906002)(36756003)(47076005)(86362001)(7636003)(356005)(36860700001)(426003)(26005)(2616005)(1076003)(336012)(40480700001)(107886003)(82740400003)(316002)(478600001)(70206006)(70586007)(54906003)(110136005)(7049001)(7696005)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 10:49:24.8261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2599ab24-bd66-4ff5-b53d-08dbcb10e676
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8069
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Tegra234 memory client entries for the Real-time Camera Engine
(RCE) and Video Input (VI) devices.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/memory/tegra/tegra234.c | 60 +++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/memory/tegra/tegra234.c b/drivers/memory/tegra/tegra234.c
index 9e5b5dbd9c8d..42c79f9a70af 100644
--- a/drivers/memory/tegra/tegra234.c
+++ b/drivers/memory/tegra/tegra234.c
@@ -449,6 +449,18 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 				.security = 0x38c,
 			},
 		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_VIW,
+		.name = "viw",
+		.bpmp_id = TEGRA_ICC_BPMP_VI,
+		.type = TEGRA_ICC_ISO_VI,
+		.sid = TEGRA234_SID_ISO_VI,
+		.regs = {
+			.sid = {
+				.override = 0x390,
+				.security = 0x394,
+			},
+		},
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_NVDECSRD,
 		.name = "nvdecsrd",
@@ -621,6 +633,30 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 				.security = 0x50c,
 			},
 		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_VIFALR,
+		.name = "vifalr",
+		.bpmp_id = TEGRA_ICC_BPMP_VIFAL,
+		.type = TEGRA_ICC_ISO_VIFAL,
+		.sid = TEGRA234_SID_ISO_VIFALC,
+		.regs = {
+			.sid = {
+				.override = 0x5e0,
+				.security = 0x5e4,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_VIFALW,
+		.name = "vifalw",
+		.bpmp_id = TEGRA_ICC_BPMP_VIFAL,
+		.type = TEGRA_ICC_ISO_VIFAL,
+		.sid = TEGRA234_SID_ISO_VIFALC,
+		.regs = {
+			.sid = {
+				.override = 0x5e8,
+				.security = 0x5ec,
+			},
+		},
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_DLA0RDA,
 		.name = "dla0rda",
@@ -701,6 +737,30 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 				.security = 0x62c,
 			},
 		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_RCER,
+		.name = "rcer",
+		.bpmp_id = TEGRA_ICC_BPMP_RCE,
+		.type = TEGRA_ICC_NISO,
+		.sid = TEGRA234_SID_RCE,
+		.regs = {
+			.sid = {
+				.override = 0x690,
+				.security = 0x694,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_RCEW,
+		.name = "rcew",
+		.bpmp_id = TEGRA_ICC_BPMP_RCE,
+		.type = TEGRA_ICC_NISO,
+		.sid = TEGRA234_SID_RCE,
+		.regs = {
+			.sid = {
+				.override = 0x698,
+				.security = 0x69c,
+			},
+		},
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_PCIE0R,
 		.name = "pcie0r",
-- 
2.34.1

