Return-Path: <linux-kernel+bounces-5219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C0D81881A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 931CCB24A93
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D285618B04;
	Tue, 19 Dec 2023 12:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d25JrXNx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643641A727;
	Tue, 19 Dec 2023 12:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVKjC0PQc4CTUD6qn3g5CDvg0OSE8VUr5xXHxn+iHvriga5EyUkDLmG2puf87j9/F9ilVgsmRsroVHe+ekU/L6v+E/xDcFqwMENzSb3NmqPpTLJzy2xH/xRz589Lmu2k2kpTtQi4NQGns/tGPsq06HGRwxqMhDBuNPc8+Hi5FYg8qyrzfsXvKPb1Jy+PvhvZjv4CXvpZuiv8VPyn79qcHFuoR/cngBxqinH7wnIjPoByi64AyYVitdeaBOEKadXQ5pTu7ePhFHShPbkwZeAIr0HwbUBQ6Lh1v14iP1ocb4QvCcRXgbFZsPrLzdsJTBTW4MFM+tFORd4cCNgiu+9b7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0GPcQrknPxZPHPZqtdVTXBd6be4EA7eXWFwaujW65s=;
 b=KIzQwsqkJkqg5nhix/TEYoQVc2Q5GYBGKfNF9ki7AiJxui4fdYuXXVv8bnEUgvMlf6RoI80aFlsplUyj1LRcG8it/o6JtI4Q4bmguCDCeMjNSg7FMkEqFjb1y+kjNa7fm8WUWWhRFO7utvs4eXClnxJUQxj+WgQ5wxzS0Oc8UZ730t2eLAesviENty6RNlduAtkEpcUiRUQOfqySymAkBtS1YS14q7GV7f/0wBV8KTt5zr7i5egtH+eCSiemQ5q4NOL7YoxwrgqGrzh6ni0e3wM/5V5Yngl1zvlMc+zKqhW49K909C7tjukMtv8McBznn2VYmLP6vPYcWkWyZi3TYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0GPcQrknPxZPHPZqtdVTXBd6be4EA7eXWFwaujW65s=;
 b=d25JrXNxUuiGAUkFlfElDrSwoBjhKuFbF+tFsM7zHyfy40EHZC6+HTYEdbi2OvEj0WflB/6I+NV1//SUTmqbyD1eLLpJbKbhsy1y4J7I6PX/jCalaxDSKYgWTrbYPbuVXuJV/gCt0tYgotA98/R+sbFpc6HONTqzoCMYU3YkzH5RBsMh2Jyoi2dkpIBZc7iLsSsBcXcMj4XMUP14r7pROlGVBIGnTMG5bEIRl9hdIQ4MKj+ni+06UaCX7xh46w32GdMsRws0UAFQl6/YoJINd5tJk79/y4/yMn3oKsFUGISAwtmmk/HRESnqZIuD7lkPx08B91hZrxsJ/kCiKRn1jg==
Received: from CYZPR11CA0002.namprd11.prod.outlook.com (2603:10b6:930:8d::8)
 by SJ2PR12MB7963.namprd12.prod.outlook.com (2603:10b6:a03:4c1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Tue, 19 Dec
 2023 12:56:41 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:930:8d:cafe::fd) by CYZPR11CA0002.outlook.office365.com
 (2603:10b6:930:8d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Tue, 19 Dec 2023 12:56:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.14 via Frontend Transport; Tue, 19 Dec 2023 12:56:39 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 19 Dec
 2023 04:56:37 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 19 Dec 2023 04:56:37 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Tue, 19 Dec 2023 04:56:32 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <mperttunen@nvidia.com>,
	<linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<krzk@kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v2 0/5] Add Tegra Security Engine driver
Date: Tue, 19 Dec 2023 18:26:09 +0530
Message-ID: <20231219125614.33062-1-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|SJ2PR12MB7963:EE_
X-MS-Office365-Filtering-Correlation-Id: 0848f709-3b5e-4d38-07f1-08dc0091f16b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qdMP+FHWxnKmoxJVqJeJDt2vEeFti4fM7PmLnu30Ybe53UwSrX4FlfpEiqPsVef6UO+76loxR7fkJW6/c+9OTJm+Gxaard9FIzUv54ia7afI5y5Vk/IlXrraFddmWWO678jOTHmGSrbHeiHOAXf8H4MWPE0AarvQpyf0O8LLDZkSirf1qoe5909P7geuw5CjXFjaIYBpPGCYrbW9p6KLrLB6/lcF8y8OcLxAHfUXSwakLAtrMN1IJtWDTrucGG7WlNHDhRc8OYFgEVkotHQspHWQ4VqG9fhfKddqJGDK585S6GwHfIboetV9VxC64uY94vnq7DBD0H7PMVdxOD1bsb7eiuDOCw52q52HpTpYHOpx/d//RLoGT3DDOG+8cC8oIGpHR9+C0DUmyHNSPYvgtKuoyxrtmbVbZ6EKbBhaRHXeDtGyfyWMgqTq0Rp/0qeKDQK2NWwjCkb2095mwg7Q3ghXNnM3kkBGhgwHalQ2kvlgn0i7lqnWBcfTgE0tV1IgRxmyWVkRNF5qiePaOikMw7DUSEb0QA2Q82QPr1/7bwem+wVzPbkvwiQe48zBftLF/NBPir/52NPyj1Q4PeY3yaJRMwwPr5wOOE84C5WPj7L8a7fxp5y10etcw8gfyYQs4gGWX3p91QbPtoRir7Yxs/w7qt/pBbBMuHjQenY+w9qm0Dh3s5e/GRPLdV05gqAMv6w43N/WcRRqELCUUD0XOLbnv8X3+YN7O224jiKsfGtgqRStYNyUgR3lqHIC0hIZYrz6Uchl2U/quvJEky2uuCDn4VEr3lqS0scyXyW1CaowCRF0PDCb7QO40RLMVAdXwJ0O29AX2D79wtjuARZGLg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(230173577357003)(230273577357003)(230922051799003)(1800799012)(451199024)(82310400011)(186009)(64100799003)(46966006)(36840700001)(40470700004)(426003)(107886003)(7696005)(2616005)(1076003)(6666004)(26005)(15650500001)(478600001)(36860700001)(70206006)(2906002)(7416002)(5660300002)(83380400001)(47076005)(8936002)(4326008)(41300700001)(8676002)(110136005)(316002)(70586007)(356005)(7636003)(82740400003)(921008)(36756003)(86362001)(336012)(40480700001)(40460700003)(357404004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 12:56:39.9411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0848f709-3b5e-4d38-07f1-08dc0091f16b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7963

Add support for Tegra Security Engine which can accelerates various
crypto algorithms. The Engine has two separate instances within for
AES and HASH algorithms respectively.

The driver registers two crypto engines - one for AES and another for
HASH algorithms and these operate independently and both uses the host1x
bus. Additionally, it provides  hardware-assisted key protection for up to
15 symmetric keys which it can use for the cipher operations.

v1->v2:
* Update probe errors with 'dev_err_probe'.
* Clean up function prototypes and redundant prints.
* Remove readl/writel wrappers.
* Fix test bot warnings.

Akhil R (5):
  dt-bindings: crypto: Add Tegra Security Engine
  gpu: host1x: Add Tegra SE to SID table
  crypto: tegra: Add Tegra Security Engine driver
  arm64: defconfig: Enable Tegra Security Engine
  arm64: tegra: Add Tegra Security Engine DT nodes

 .../crypto/nvidia,tegra234-se-aes.yaml        |   53 +
 .../crypto/nvidia,tegra234-se-hash.yaml       |   53 +
 MAINTAINERS                                   |    5 +
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      |   16 +
 arch/arm64/configs/defconfig                  |    1 +
 drivers/crypto/Kconfig                        |    8 +
 drivers/crypto/Makefile                       |    1 +
 drivers/crypto/tegra/Makefile                 |    9 +
 drivers/crypto/tegra/tegra-se-aes.c           | 1932 +++++++++++++++++
 drivers/crypto/tegra/tegra-se-hash.c          | 1022 +++++++++
 drivers/crypto/tegra/tegra-se-key.c           |  155 ++
 drivers/crypto/tegra/tegra-se-main.c          |  439 ++++
 drivers/crypto/tegra/tegra-se.h               |  569 +++++
 drivers/gpu/host1x/dev.c                      |   24 +
 14 files changed, 4287 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/nvidia,tegra234-se-aes.yaml
 create mode 100644 Documentation/devicetree/bindings/crypto/nvidia,tegra234-se-hash.yaml
 create mode 100644 drivers/crypto/tegra/Makefile
 create mode 100644 drivers/crypto/tegra/tegra-se-aes.c
 create mode 100644 drivers/crypto/tegra/tegra-se-hash.c
 create mode 100644 drivers/crypto/tegra/tegra-se-key.c
 create mode 100644 drivers/crypto/tegra/tegra-se-main.c
 create mode 100644 drivers/crypto/tegra/tegra-se.h

-- 
2.17.1


