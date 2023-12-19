Return-Path: <linux-kernel+bounces-5221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55916818822
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D462C1F26754
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6A618E1D;
	Tue, 19 Dec 2023 12:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EyFkE610"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CA41A58B;
	Tue, 19 Dec 2023 12:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=luZf6X2pPe8NhqzvlSlpn0lVsCADsHXxN8pYg8kttzrHPesnsvT2f9wkPa+KobFUtWTa7zYK8GsFCc+4p++MMpajuC/R8mvFnibL0IZAUrAOfFKVxq97aDP0MTL4Qao6NJDO/KanviyXrec3xY501gmrBww2hAYheT0USGe4/0ttgmaR1M50Nygr2czumOVCdTrT//VgZxfefQWjyvnXMz2ZBSYghOQycEE617lFyb3MCEQmOlGAT/s2VsaHf6j6fzEEetdR7+mrB3Xm7G/mBNa47gAx58BPI6LSqVjrb3xSK+bN5RijK4tBbm23Bl91PDhDSRJpKUoy4IPm8Mi8yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+o5KvE8nwX0WSeMin6w0eEZKvdESyMS9s4vHsWXmjE=;
 b=gYHyLkV/EkZTD6kgf0Yi32psxnwxzjJ/rAAnkhrVzYgUD6aBOWSl2ItOBVBpLzkCRRUmHupolMvxcM/weqMzmvmPB7ZGUsqvls3NfDmlmkeFhD5OKKNzctA5h0MVo/8LfnQmGLi8kQQd8xQZocgvsxe03572nu+WLkjduTx52k1qX/3M2+H3vwGqAkZ8PxHp8DLJlrKjL7I+s9npqUaAt95aEiSOhwOk4MaV/vtNXYHR0h0gX3W89RGj4kLKS07nAgEiIZdGPjpItCtFHEVa+yCan+uJKqPzS1ipnuDKRdIC6GTTgVKwj3ux9VX4gUQ+uM/cjUY6ERVhOPVHwdoMQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+o5KvE8nwX0WSeMin6w0eEZKvdESyMS9s4vHsWXmjE=;
 b=EyFkE610JRBPP8FP+f4/Rj7/XJi+RJoxAerqS4ukSidmAhR5zyH5MEJbspGxAOBe9yTAQVEMgvz1yPyWMc3DKUHPzg+FbOYpxeVzrtXs4oujs9hwfIf6sn31Nh5nTPo6K0NTX2/B6zcK1lvczocRLy7eqJ6fbDzeC/A1+rrEQ/PStaxWJ410LogL9YAb1QRDBVYLgI/czZOlVbquP3SomSbKh3R4+WjDRqiHlH5JSI6UREVahpesT/EjLFMfsogFQ2T4GtplMMvwK7+i5313jXtY3zh7NPbrNVLujFqXWN9u5enz9xaQ5JNEBW3TDRw7uZ1syE2wnhHAwKsmDGab1Q==
Received: from CY5PR15CA0120.namprd15.prod.outlook.com (2603:10b6:930:68::9)
 by IA0PR12MB7507.namprd12.prod.outlook.com (2603:10b6:208:441::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.39; Tue, 19 Dec
 2023 12:57:07 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:930:68:cafe::7d) by CY5PR15CA0120.outlook.office365.com
 (2603:10b6:930:68::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Tue, 19 Dec 2023 12:57:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.14 via Frontend Transport; Tue, 19 Dec 2023 12:57:06 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 19 Dec
 2023 04:57:03 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 19 Dec 2023 04:57:02 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Tue, 19 Dec 2023 04:56:58 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <mperttunen@nvidia.com>,
	<linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<krzk@kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v2 2/5] gpu: host1x: Add Tegra SE to SID table
Date: Tue, 19 Dec 2023 18:26:11 +0530
Message-ID: <20231219125614.33062-3-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|IA0PR12MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fe1d319-0ca3-4a9f-2d6e-08dc00920144
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OCEzItbdZW85anmhaXzZnpSPQzNpSoYZKpWcDdEzQRmagKdmqEPizgoJFA+k/kCfjmNLetbM3dFPUwGnlRPJ7+hdZKBYvNnmfIxK1cvSwzSD2P8guPYaiA2khb2KDCLTb3W1dno6g6CA3ZoW1qZKsZadR52APgV+o9EaSTpKvTaR8B++7EV/Z4UwC8gMA+IX+c3MmYfL/z/DPmGuLwxuO47EDLrkeo+B99TwnJzr2MXAyXhJtAYrf8HoOFgWfboxh7PibUId9vR3gqLZkchzT1T6o3g24T3oqGOxbXCtGQsxZxMrgXD8dwV1fWuv9qWSgqrWSbQRtlh9iS34cjVd77dR/jm6VoAuDGeiubX3X2jMYijsVowXvqrX6hakZiM3SPA5Dg772lWqWWi4kRRb7HlnHm5gK/ySrh8BUsBLbqMDqPWb115JHNQqQ3RMhziT2+dPiw0bhVlkWFCJkubydFIjPca/WDYBfsuPa2Xv4zkWQdaqvWQ2bIKyS99YmdbrNCdylglLiRyXeRWGMpK2G3VCq/rGYJhT7SDgBqtR01Ec8qU72tACjNPQgUnd42XDFtNUbrd6G23yHpal27+1UTi/I6SvtXxsYq9aNGrA08kYEEyGLxLn3Le4ePZGTvyfCHEStCzn1CJWQg3mcc5tQ+YoXRmr0KiICw9obRGNZl/9PUji2RjKyeZudTKbwRiuqXN1vbKMceBnOJGk8RaZlT2ATmSwZpl/jJKrfHjowGlesEgsmFu3O1HcZyV+XU23NUT+4hXFcaoza6W1Py5GO16y3pnx2fV7MQrGvE7AEjNx0JN15xhfYldnN8bv7XYt
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(82310400011)(36840700001)(46966006)(40470700004)(36860700001)(7636003)(356005)(40480700001)(47076005)(40460700003)(26005)(336012)(426003)(1076003)(83380400001)(2616005)(107886003)(36756003)(86362001)(921008)(82740400003)(7696005)(6666004)(478600001)(316002)(110136005)(70586007)(70206006)(4744005)(4326008)(8936002)(8676002)(7416002)(2906002)(5660300002)(41300700001)(32563001)(357404004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 12:57:06.5144
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fe1d319-0ca3-4a9f-2d6e-08dc00920144
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7507

Add Tegra Security Engine details to the SID table in host1x driver.
These will be referred when registering the SE as host1x device.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 drivers/gpu/host1x/dev.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index 42fd504abbcd..b564c7042235 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -214,6 +214,30 @@ static const struct host1x_info host1x07_info = {
  * and firmware stream ID in the MMIO path table.
  */
 static const struct host1x_sid_entry tegra234_sid_table[] = {
+	{
+		/* SE2 MMIO */
+		.base = 0x1658,
+		.offset = 0x90,
+		.limit = 0x90
+	},
+	{
+		/* SE4 MMIO */
+		.base = 0x1660,
+		.offset = 0x90,
+		.limit = 0x90
+	},
+	{
+		/* SE2 channel */
+		.base = 0x1738,
+		.offset = 0x90,
+		.limit = 0x90
+	},
+	{
+		/* SE4 channel */
+		.base = 0x1740,
+		.offset = 0x90,
+		.limit = 0x90
+	},
 	{
 		/* VIC channel */
 		.base = 0x17b8,
-- 
2.17.1


