Return-Path: <linux-kernel+bounces-19789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7AF8273F9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB9E6284EA1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B249353807;
	Mon,  8 Jan 2024 15:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Yc1gxHJ1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9295846B83;
	Mon,  8 Jan 2024 15:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVACGUhOftFz9hQ7jh3O2xuMPRpHcRgdm+kW48DMKJs0m9/1czWvKz8OS6u3Z+m1E7jB4mkN7IvFBSmyMKTeRx2ff9GrhzxqJrFy8RLFioJgdveozLuSuXW7m9agvic8+duYK+vfpN7X1n9sMBJ1hRSAqmEEerhWj4Y5KAZEbApN6AxfjU77nME+FAyomn5t2n4wMoLJS04xXnovUhJUo7QHqk+AKac25+jLUstcvjXmwFeJ7bDOY2+zeENBSzN2dnei18h58g8PBhaMGQXjpJIrK/CilhZ2pDjuZsj4KuDizCCEJabVglF5IWxBHIGdowP/juI4jx6h7fJW5KVxmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=reo1Hhh3ZS1q1XQFst5vKDdRSkdu0jKHCn2AfQJ6gZU=;
 b=Ivvzk4MlCTYjkxD7VFAh0+NYByAHegpJST/NXwsCMjZvxF5U7hPTuwzkfkGGZlHaWQd6Nr/dhw8lXyJTBZ57SAIh1uh0bxybErsawU1JYfu2CO3W63wb22iCjHIHFjQLuMksbwXTPN6FunGdfiNLkpr+zsN/xpPf69yCURD2Mg2X5UE4s00KAwZyFTHul52ldpL8PWSs0lbLJ6dNkYXZj5UjjuqfH8Uuek285twJ5i4oGYBqzibZLIsi6g1vZeJroPmAE6vQwU2o8+V4E1LDgGx2pPWQSPLDOhcfGy6G/I6U+Ypx9UgjGUts/EfuipL49WUS0zS9xOVyarfnfWdePA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=reo1Hhh3ZS1q1XQFst5vKDdRSkdu0jKHCn2AfQJ6gZU=;
 b=Yc1gxHJ1c/LEi1Jq/UjrkKPx5kKy0R7ZAbKms8AzfCGHVrmbZbegUSbM9ufx16UoAwH6ddf06w87j0s4Ee88QG6zNAXfukKw5ONTj5LU6W+GbKKAjRpB4ak55+r0wvODGjgkzbntyQiW5k5ZU1acBPbpOqQdu7QMb0gC89tFSwE=
Received: from BL1PR13CA0285.namprd13.prod.outlook.com (2603:10b6:208:2bc::20)
 by DM6PR12MB4220.namprd12.prod.outlook.com (2603:10b6:5:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 15:40:48 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:2bc:cafe::74) by BL1PR13CA0285.outlook.office365.com
 (2603:10b6:208:2bc::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.14 via Frontend
 Transport; Mon, 8 Jan 2024 15:40:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Mon, 8 Jan 2024 15:40:47 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 8 Jan
 2024 09:40:24 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, "moderated list:ARM/ZYNQ ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 08/14] arm64: zynqmp: Fix comment to be aligned with board name.
Date: Mon, 8 Jan 2024 16:39:19 +0100
Message-ID: <6e4215807f535d2e2b2b8055aa8574c748fe22e4.1704728353.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1704728353.git.michal.simek@amd.com>
References: <cover.1704728353.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=813; i=michal.simek@amd.com; h=from:subject:message-id; bh=nSXN7Nzdtq9RIgDtuFLbhciW5ryFsXs3gDNOJuYSkPo=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtQ54hpnTPbsdZsVeaUm4ODdi42uP3dbHNedcCZ+XXuFw 3K+KZE9HbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAij84zzNO+XBnWcLqvKJWh 4bKB/MT3MqvO9jPMM4urUZ1y6bTikevSJ1+VKoSHL9RwAwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|DM6PR12MB4220:EE_
X-MS-Office365-Filtering-Correlation-Id: 76e51983-cf9f-40bb-716d-08dc10602f8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QBR7smg9Ym1lhVOfp2TpWVm1d/hgNzrzuCUDYELXIRhF93m2ig6EIDGfTykouXlrIYsAllP5gkjocsvXzuxvYiZfr6div3pbLPlO0FzYZUHuBjAoHOFU9DbZNCWHsmB1N1uMwFK8VPAm1lerI3xaAYAO6hjeApFpX9Rcr5+iRXGy/y6D6wAT7bFqdwFzxk9zsPCbFAe/pxp2VolKJZ/8wQtNvLHP6+2gmIC3tj8zyCqPxR0ys+1C1/Ir9MZxn65Z1TNT6Oc3XIEwB2tZ/Cmlu1CLBQ2SU0dal4MRoX529AUirZ28QxCA2C3Pg89NFr7hRVXLsk0Y03Y6PufIq1/WeqdjyAfey4fN0ra4tdM0F7ngnGB1Y7x/utRHtx/lhm5pNSdGkF0ArAwYFjTS5YhSBGHC9KMu3M7UM6/b8btL1cah2JHDLrKtemFDhRB7T7QMPL2RjRtEOd7KU1uffS5pkVi3C9szPD8vVkM9py+pPttiBMXy/d0VtpBF+OxahWey9OR3SNQrY5g/7HzAowwiTDW5073RsSDti+EFYez5DdSse8JA9nwVa/ppwK5K8ankvQvPj0fEZM3A75odFAQm8fZ1PLya3DZj7w1VIU7gcrHfYHidww2Yp8J9CFjL58o+6tW+Tmtkuig7tjdIGufKZ8w+CRvrUcexl8wt8vkJllhBVHeMT3V1mRLjDP165RhtkQgwRgehg4oe9Ti5eN2gEuP41T7fHIE3BMRRpZzcc+LIKtY5BBnDhNToRx6a3sjjVoMHnRZXR24M8uCje79lR+ous7m6fDEotgLrdzqaED8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(82310400011)(36840700001)(46966006)(40470700004)(40460700003)(40480700001)(26005)(2616005)(426003)(336012)(478600001)(6666004)(82740400003)(36860700001)(86362001)(36756003)(356005)(81166007)(5660300002)(2906002)(4744005)(41300700001)(47076005)(16526019)(8676002)(70206006)(110136005)(4326008)(70586007)(54906003)(316002)(83380400001)(44832011)(8936002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 15:40:47.8193
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e51983-cf9f-40bb-716d-08dc10602f8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4220

The board was renamed from zc1275 to zcu1275 but name in comment wasn't
updated.

Fixes: 370b0e900fb0 ("arm64: zynqmp: Change zc1275 board name to zcu1275")
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revA.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revA.dts
index 7386ffb7daeb..95666a8f0544 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revA.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * dts file for Xilinx ZynqMP ZC1275
+ * dts file for Xilinx ZynqMP ZCU1275
  *
  * (C) Copyright 2017 - 2021, Xilinx, Inc.
  *
-- 
2.36.1


