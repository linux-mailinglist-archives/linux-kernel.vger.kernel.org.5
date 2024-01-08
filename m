Return-Path: <linux-kernel+bounces-19785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6FB8273E2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3435C2851FD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC1852F71;
	Mon,  8 Jan 2024 15:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SfiHyaFX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB2551C3D;
	Mon,  8 Jan 2024 15:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHQhWBATbxtNTaFzLOiirfFfn1ajd7LUqougNej98Yv6SZB+9LVj9EY1ybgfqLaKsAaC9w1+xg6VRvYBg5kxmJtCJu7xJywkvzmGqFD39p4PcyAA0Gl46osYDAXvPGlzj9tAFb7hHc3khUrNKpgc6WigfElcySA1KcTK72VdYxD2FH+tW0ipO1+mvAF6vDTE5rV0S847sn9CYRUsUjtX0XdCi6fanbtonqSpd2PdOw2Qj63EULiRvHj4ezWuoccV6Vi3erbc5ZPlloOb8W1mlDuIZscqkeN2M1A2+eNPOc6YljQLdyVOSdZ1Cbb7+NfkOjBI1LV+W/YV4r93prCLIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1Q7kVY+LB9wtGBHnQxY+diGXvjcuVH+4TB2z8yOeGY=;
 b=H9WAuy/S0KzqD+Nah+HWQ3HCghw+qUFxDMrQ0kCchdr78IIOJolEpP/2dcoyMI3Wilwa8gRCXAneL5QR/zi+RmQjt+ycrNsMiAL6Y+aVvhfwNvqRPsOkupciiBcMC6XsJn3AqNUwTyJNw4ZTWqDahgp/uqp6NTH4YxPMigltCWRC3TBZ8Alvn5GofsrI53c0IL0plCzKasfAhsBO8QSfUqgLcUDCnjnE846zMMkcS1f3VYTSZOhZzQDuHPHz08/RBoWKkc++JU+YldRmLseBAXoM+AbsE0kQiq6XVoonIbU4QdHGPJY7RQ3h9MMH3B5aYnscHV9L0m7L+AJ/8jdqMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1Q7kVY+LB9wtGBHnQxY+diGXvjcuVH+4TB2z8yOeGY=;
 b=SfiHyaFXaeAO1QvNT7IulCe0y4XvFe9TVqn/nf2jvfJu6oYDHoNhHlirWmZx2wZN+E7fC976k1C4OvGUWbgwzGE2jGI7nn2D2dB1YOCA8tI1S7K4NHYU7La82x6d5gBexuPpBwKaKqWMxsVQVnYkDHyutty9kAYFZxf/rvPBvlI=
Received: from MN2PR20CA0054.namprd20.prod.outlook.com (2603:10b6:208:235::23)
 by LV8PR12MB9232.namprd12.prod.outlook.com (2603:10b6:408:182::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 15:40:12 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:235:cafe::3a) by MN2PR20CA0054.outlook.office365.com
 (2603:10b6:208:235::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23 via Frontend
 Transport; Mon, 8 Jan 2024 15:40:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Mon, 8 Jan 2024 15:40:12 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 8 Jan
 2024 09:39:44 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Srinivas Neeli <srinivas.neeli@amd.com>, Conor Dooley
	<conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, "moderated list:ARM/ZYNQ ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 04/14] arm64: zynqmp: Add resets property for CAN nodes
Date: Mon, 8 Jan 2024 16:39:15 +0100
Message-ID: <7bf0cc230f3c25010f9545f3f92f6f15a95d21ec.1704728353.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1704728353.git.michal.simek@amd.com>
References: <cover.1704728353.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=961; i=michal.simek@amd.com; h=from:subject:message-id; bh=j5Jy5+UwvZi804wSzRNu3IPXiSdBIBLe1K9Sb3C9tEE=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtQ54mqR7Ettfu259LDrp9C05IW/tjcu/hWvYzzXN+nER AOH78eKO2JZGASZGGTFFFmkba6c2Vs5Y4rwxcNyMHNYmUCGMHBxCsBEQnwY5kdl7wzn3Zn/xrep JfiZldd2ObXFKxjmcEqtXfXosvP+PWzndP+72WvXRd76CwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|LV8PR12MB9232:EE_
X-MS-Office365-Filtering-Correlation-Id: 1276923c-8d75-4640-26a5-08dc10601a76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OKoXn6yBsaC737DSw5pp5GeHxqrYSAnha54NXdk7cXkRBmOKMlRk+SZ0ULmKmlaUOytIPBqULfpXfOS4yM0GImyRJWVVXWODsJjMds6f75OAvihSM6oKmNEvuTGiwxJ/wF1vyZDjmabPU3ykj40+Oq0/JfBjDNtYMxWMEPLjjoDD9UlTc4DNjZdc7XJeIJhaFcJ4qXaijZgdQRJ7JsuAiM5XM39sGc6h7PLFFhqVgPA8iIX9aPAE5Kb8264wvDzjUJrTpfvDGDQIsMarDOkl03vpRfOFQOyW+PvVRXH2C/28VUqoVy3saj4sZxRriSJ196L+HOoWc8eLvsSnKqSTpa5PQX6r8fueRsFR22mRlcCn6lbkYIROpVhDi6vN4qSY0Q7VyEiYOlFbnFHiepIZSdbajSgnj02mL1Fy0F5w9ntvjnPGTZm2gXd3JZ2N6iuiAUEF9Kc7jv3Zwi4a66JtoiyHnq8vN7hY6z8raTz/I12zS7oRs85wR0z93RMLjD716thIEpob7Qqtl/Z46VQ2HcjGX6LwclGq/2qPcdU8HiJE2wop44pWPlVBKcVAqsraFVzV6Zxen+ueKu/9n0GI0ZXUrPRVjjR7gOLIjK/o9eZ2Y0oOpJLEGlKMVbkv+OUcYdGONbqVozVVJR2ZqOFchP0B1Vr9puiqPsKZ5fs1FKEPYgpZWdecqS2l67ZROC9aUXv2L6DXxqbo4hzQAbtn1lQju8y6mAnTN5jj3wPNbbXY20jKLTIXqo5hBsLK2LhbnfMnT94ydun7ptt95tiXGMnbceo781ak60DsMAPzFvE=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(82310400011)(46966006)(40470700004)(36840700001)(36860700001)(6666004)(478600001)(356005)(40480700001)(47076005)(82740400003)(40460700003)(81166007)(426003)(336012)(8676002)(16526019)(26005)(2616005)(8936002)(110136005)(4744005)(54906003)(316002)(44832011)(5660300002)(2906002)(86362001)(4326008)(70206006)(36756003)(70586007)(41300700001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 15:40:12.6310
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1276923c-8d75-4640-26a5-08dc10601a76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9232

From: Srinivas Neeli <srinivas.neeli@amd.com>

Added resets property for CAN nodes.

Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index f72fb4ea3e11..c41c935f92b1 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -286,6 +286,7 @@ can0: can@ff060000 {
 			interrupt-parent = <&gic>;
 			tx-fifo-depth = <0x40>;
 			rx-fifo-depth = <0x40>;
+			resets = <&zynqmp_reset ZYNQMP_RESET_CAN0>;
 			power-domains = <&zynqmp_firmware PD_CAN_0>;
 		};
 
@@ -298,6 +299,7 @@ can1: can@ff070000 {
 			interrupt-parent = <&gic>;
 			tx-fifo-depth = <0x40>;
 			rx-fifo-depth = <0x40>;
+			resets = <&zynqmp_reset ZYNQMP_RESET_CAN1>;
 			power-domains = <&zynqmp_firmware PD_CAN_1>;
 		};
 
-- 
2.36.1


