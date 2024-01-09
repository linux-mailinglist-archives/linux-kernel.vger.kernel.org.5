Return-Path: <linux-kernel+bounces-20643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB1E8282DD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13FDA1F22D81
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA0A35887;
	Tue,  9 Jan 2024 09:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hxe0lPzN"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59035328D8;
	Tue,  9 Jan 2024 09:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAsZe/+H9BhX2t1sodn1VsxaEQyWdKCXPU7Zm3YT99+U0puQRN2VjCerLvXbFX/LWgAlxy3aX8Snqk4meCsokvSiHraeQWPo8d0qB4QNO5m5y93daaV3/Vg7Hn+Cf7RqYXBY8I3gGiy+GtxsUHsx2VyCIRJvNX4gLRsx5qlXT8TaVv1pY14vRnGQ/qktCjicyDnsIJrI1orYyJVPvvrONKiG8Slacm95nlGoePrPjCaXA6Dnt74t4sxguvEvtrf4Ps46P4iM6EcKVO35jREie+LXhZlAbFWp66Z52/FLt1TQahcigoNXgl+r6t9P8Rr7WH66TMXsY2aOg8GrCygFsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3AFCufjJgoaIB5hTdZfKf7cbacIO+bgSE/0YRh3pwwY=;
 b=cWgtlieHDjSGZqnOk1Z+Htu0P2rm+2NBCxANUyRfzhrLPGawt9VS6fSz82ihGWQJccARYrPrelBiRZQZN3036jJXr72xpe88dFQbKBXqReYI77rhmX+nD2PyPXUlZu4Iy/FS9aF2rVRcw9m3c6tMMXU9Wtn/wnzpkCBd/R4G6tKc54Ee/EKRe0xR1HBquP9zVtNdOWuUMypYfruyackbJ6JcmiD1pIWb1YRtjC7dNcLf/diqmc8tBolTIrGnOdeCYybUNExts/OrVMqd7IVL2g4Ccw285V4UsWSB3qD7NYBgu6izhuG3/M9Gm2KcSdxWUzHpbEkEidx34k6hZDw9/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AFCufjJgoaIB5hTdZfKf7cbacIO+bgSE/0YRh3pwwY=;
 b=Hxe0lPzNEW9AUwNl7hhWjuiKQLkF+DsDLljY6ABID0/Sfsvc5cS7QVnklGaujJHm94wugP25foI6llKGxb24A3xi1lWo4u3Cmzk2MgAnyKK/9lwiRN3WNwWCMUWMW3TLKv2MW6VpnMpfvv8ZhjlsPuRuDc9B/ijlWNfERSnao8seHXn+VncU2vfBJlMXZaikz9qzUk4gGqQhIc2TG/clUQMnUJf87ib6Rc0qnXr+MNk7C1qlix9Ndn4B6hose04KG4hkyhL4BDtIuz9WcDK/5FXviByVOuKnwU1mUanDkAm4UrKH2/X4Lc6jH9MDnrgTXTyyjdSsLy/3NKa8IVmlew==
Received: from BL1PR13CA0229.namprd13.prod.outlook.com (2603:10b6:208:2bf::24)
 by DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.23; Tue, 9 Jan 2024 09:17:40 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::6a) by BL1PR13CA0229.outlook.office365.com
 (2603:10b6:208:2bf::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17 via Frontend
 Transport; Tue, 9 Jan 2024 09:17:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.14 via Frontend Transport; Tue, 9 Jan 2024 09:17:38 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 9 Jan 2024
 01:17:23 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 9 Jan 2024
 01:17:22 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Tue, 9 Jan 2024 01:17:18 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <mperttunen@nvidia.com>,
	<linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<krzk@kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v3 0/5] Add Tegra Security Engine driver
Date: Tue, 9 Jan 2024 14:47:03 +0530
Message-ID: <20240109091708.66977-1-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|DM8PR12MB5445:EE_
X-MS-Office365-Filtering-Correlation-Id: ad771891-27c1-4dbb-6af6-08dc10f3d37a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WNcJOW3y3WViGD0h0SQsd8PBU5KtQ7+utftWCI5CRbzrzf/RPK1ktVi7NLWYeSCjGGSnTdeywPNjtCjeMGuI+bQcJVJZzITvW9vfe9/Ngtuby1trgw1fkhoe9KMAVnLyL/Lbdi2iqe43ucakG0QUHAZi5yFIdIH/bh2bbvHP0W6Jb+vinvGISYKjvhkTy8vBSeCEdnSTj7POWoukDz0QGC2cVxop7xjD7JeBQM+XFGPkumqD6Ky7HXQjYDGXW5HZgi1WAzKhLkO5fs/BxE3Wgtd7vo+glyKj1zhquqNhH/1hUcniyj4DCx5a5o9BNTfT7EbvMaSHYWT8AWiHlDIL7lhltupnn0LUb6bpzg+hkjqIeUD47dDTTlSWfxVhx8sydFzCgjeYa8DR+ArpdXqlkObcwdlwkbQ5rJPkctQ17rKd22hsdE2/0naRaCyJQJ8CUjzhZUeR6tcm8eIyW/jJ90Qew9Gv8BqRhcFaU45wyQsNKnEGkTZCpkPuNwgofzZiCXP9AdBHi8SE+kNlUx3IA/jgLE2AedyZTK2gR4WawOh5L6zXt7mzE7qHxiJLZT4WGS9rK2+lkJDJtrwHyS68uTgHsf6yxq8ucMhbPjKufgi7QMnfS2fuiszrjChUS3Xoyqs0BGWqs1PBVeNcoxtuyjMwWtXQHISXWabVChaZqGt+r513yS0aDuUj46di3jmjK1iVK52e8oOayFwVKHv/nIiklInpjjhNhT8BECmWtyh4i8JN5Zi86VVQWDXqqS4TTmXaGyiFWknF6vupVVmBlloPPJMP84bus1JEbKhUpMDbWxqwu7o8+InwnT5+yJB9gcjPO/pOdKe+iFl+aN+WgQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(376002)(396003)(230173577357003)(230273577357003)(230922051799003)(1800799012)(451199024)(186009)(82310400011)(64100799003)(40470700004)(36840700001)(46966006)(41300700001)(426003)(7696005)(1076003)(47076005)(83380400001)(336012)(921011)(40480700001)(6666004)(40460700003)(7636003)(2906002)(70586007)(70206006)(82740400003)(478600001)(107886003)(2616005)(26005)(36860700001)(356005)(86362001)(110136005)(316002)(15650500001)(36756003)(5660300002)(7416002)(4326008)(8676002)(8936002)(357404004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 09:17:38.8693
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad771891-27c1-4dbb-6af6-08dc10f3d37a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5445

Add support for Tegra Security Engine which can accelerates various
crypto algorithms. The Engine has two separate instances within for
AES and HASH algorithms respectively.

The driver registers two crypto engines - one for AES and another for
HASH algorithms and these operate independently and both uses the host1x
bus. Additionally, it provides  hardware-assisted key protection for up to
15 symmetric keys which it can use for the cipher operations.

v2->v3:
* Update compatible in driver and device trees.
* Remove extra new lines and symbols in binding doc.
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


