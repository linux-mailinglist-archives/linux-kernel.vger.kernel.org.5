Return-Path: <linux-kernel+bounces-20654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7423828305
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6AAA1C242A0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCEC364C7;
	Tue,  9 Jan 2024 09:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D7cnWRlB"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53862E636;
	Tue,  9 Jan 2024 09:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7ub18pfF4VppFO+2stLJMKGLggSnklo75aW6BbnsK2nXDJ8QZknhOpBRLJw9N+13tZ4m2k9lj46qmhlPN3Eg1cGOCA0YNGj6frul7BphVC4DN2P92rffZX7C0wImn43qEttqVD3LwfKjkH/HEtubxUGnbiabhKqpBe3ml0moD2M+ug81aF7i+tNygHcfT+CGBNAJGM7y001fZbsnsp6iL2eAanuB7L6hUFU2nmRN/iS4v9HwysGlr43xl54uST6ZLo0cDxXvWAeQfZ81tNcRdJWzNkqmLoPEmUbO0z1H0QgjI+DLWDeqdtBquF6pmhKyXPeZE0ZrVyWye0jzDpwQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JtakwJF2Bp/VGmlWNt/aPHSW8I2UW+8++6zg+6yNoeU=;
 b=jKA2Kf8aHpX8afrwHGe28K8WAQPgjJOi+plbhuhl9Scaz/8VxJgzG7Op+ujiOY1gSQPDUiQ3sSjNGp/qefKjFgjVDByeI5BGnRTUnuHC/qIP/N6nrA/+SIaq3sVLLDKS9bKLUAIYcBuYr9Lz9G5cd5wZXQnn6Z9K4fJ0RX08AZu2KDRdigif45wh31Nw6bdAZPafEcuHXSrXmbiSGuR1mOdaUwYtWq+XUIw1wKDneqWYfsyvY/L6jOKWiWxp7/MyxLkjxAdltV9xL+l2XRkIfLFmb+vqpDcTJGHRCnsRWdw/1dYXMYmE3NLqnZT0fvakhuloqb1BXAuPE1ykli3+Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JtakwJF2Bp/VGmlWNt/aPHSW8I2UW+8++6zg+6yNoeU=;
 b=D7cnWRlBqc+JVtyO7UVPcl3aYoLf9cWbsbYHNW0gAXcTtaqHRMUWFY5abxqxgrDtONgWeWxmFJifWB23zdvLgs8FmY37Txm8+k++5kdf08ASfGh8S8GaEqFZ59hMvUMg7V8g6oW5CGvHZbyNvf/FQRBQPePVYOOFushDiyP+OpqmFpLJOVndQ8wxTaksH+AxClf+24PchBvoIM2SiG9N50UYc2uTYWo6fd/lcls+0wN5sbh7MOw/TWZb9SLwt36fhs63Rj0B7j8z577/OpfituZlov3xExdeO/RqPQB7zhNCU2hXfPRYeHTSJ7QPBA9TPC1SP+SdymLaeDFKYG3q+Q==
Received: from MN2PR13CA0031.namprd13.prod.outlook.com (2603:10b6:208:160::44)
 by BL1PR12MB5971.namprd12.prod.outlook.com (2603:10b6:208:39a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Tue, 9 Jan
 2024 09:19:22 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:160:cafe::c2) by MN2PR13CA0031.outlook.office365.com
 (2603:10b6:208:160::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.15 via Frontend
 Transport; Tue, 9 Jan 2024 09:19:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.14 via Frontend Transport; Tue, 9 Jan 2024 09:19:22 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 9 Jan 2024
 01:19:08 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 9 Jan 2024
 01:19:08 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Tue, 9 Jan 2024 01:19:04 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <mperttunen@nvidia.com>,
	<linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<krzk@kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v3 5/5] arm64: tegra: Add Tegra Security Engine DT nodes
Date: Tue, 9 Jan 2024 14:47:08 +0530
Message-ID: <20240109091708.66977-6-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|BL1PR12MB5971:EE_
X-MS-Office365-Filtering-Correlation-Id: 6863e457-3508-406e-6eef-08dc10f410fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hnFOJ7oer6UcB2+rsAv4Fzh7cPzDW/8QCPqCbcXcxJnivnfVXOoRbktFDEcijSp/iZYtfJDIVo0X6gOXA/iVQ8kgFp4OrU79YvvLdI9RIRKEvXC3IX9dppXNWw2hDNUu40ZYKihhZlNejYLhr8l/mS5VFfU8A9tYkCsU5ISOMHgPMEM0DQyI0vzkukpXkASiPYvLaUR0bAWKVNEBBHQISgr4m+zpOVpOVFNqQmqg+ECPTAsxJVudB8M4OLQbSnteMGOmce3RSoUt6ixjYswStqYgOChG3TrieBjylMgq93dHSSimaCDi5ecExRaU8My0gJf8ogb6D0hcTwSA0BQd6Sg/xlCEiQCLLPXsdz6Cu4mPciW7+4itO5t2tsBTVJH09a31YRJJufI8sXbKK/56MhD1E+aqLCg3vvpkWpYvL9aYCsuonrYeCaauqHoFl6Nou1HtI8xeNguTJ/OBt0Gi1nQPWRSBK/zJUcBxIiwfHL1U0i32cI9TLnOK8uzdh4pYwn9GZBIBvECUlcN3/+UjC9Np4OKKIHVGvj5LPkVNmuFKzqBbpVegMlB7IOFNzyXKVRuwYOkxW6id0LxswGcqlrdO3syCwJSMpHHJD1Tit8nc3kEJ3cTtd+zbRqrFqVlREv18jtt1Gy/JU2SzBNReRZXdUOGKjD5OAYwRkFAscsHqV0/aXm3BmhRqEImNaidb0j3I32CNgp5u2R33JfZW+0WEcoozkPV9BTkYA5sEVuCDzoty29SFGmh7vQxjld/1
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(82310400011)(186009)(40470700004)(46966006)(36840700001)(4744005)(7416002)(36860700001)(5660300002)(478600001)(7696005)(8676002)(107886003)(2616005)(86362001)(8936002)(41300700001)(110136005)(316002)(36756003)(70586007)(70206006)(82740400003)(47076005)(83380400001)(1076003)(26005)(336012)(426003)(356005)(7636003)(4326008)(921011)(40480700001)(2906002)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 09:19:22.0714
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6863e457-3508-406e-6eef-08dc10f410fb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5971

Add device tree nodes for Tegra AES and HASH engines.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index 3f16595d099c..8a6eae4b4365 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -2304,6 +2304,22 @@
 				 */
 				status = "disabled";
 			};
+
+			crypto@15820000 {
+				compatible = "nvidia,tegra234-se-aes";
+				reg = <0x00 0x15820000 0x00 0x10000>;
+				clocks = <&bpmp TEGRA234_CLK_SE>;
+				iommus = <&smmu_niso1 TEGRA234_SID_SES_SE1>;
+				dma-coherent;
+			};
+
+			crypto@15840000 {
+				compatible = "nvidia,tegra234-se-hash";
+				reg = <0x00 0x15840000 0x00 0x10000>;
+				clocks = <&bpmp TEGRA234_CLK_SE>;
+				iommus = <&smmu_niso1 TEGRA234_SID_SES_SE1>;
+				dma-coherent;
+			};
 		};
 
 		pcie@140a0000 {
-- 
2.17.1


