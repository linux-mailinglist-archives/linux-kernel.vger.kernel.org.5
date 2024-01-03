Return-Path: <linux-kernel+bounces-15238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 454078228EA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 08:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D4661C23069
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 07:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF3418035;
	Wed,  3 Jan 2024 07:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dKqESCQl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FD2182A1;
	Wed,  3 Jan 2024 07:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PIgo7bXsiaKAZEk0ltJJleeEuL99qKKejH1/J7yeGqdtDbcImjU2Ks6SMtVRHKDCsIZOtFUR2bT1tK0NlOWBm7sC6sJeg0Fa9N8kea3okSeXsU51VeJWuss3j7QXhE5velUhzFp4oePporgPH3YjuJ3SAlhZsqxtPDl3wMp+UbF+Fjxowexrc1891yEnh2o3BSUwBgCWWPcpcL04EHLyLLopkLSHJRdWVVKc+C2Edr2U02l+/XN+yz/j2WdyikIeid6AV+WmQt19nNbymnHLhNiPIEJM1DGdZWu+DM2NLPmuIiC9SfAfoeTUJH/n+F9tl5SSGWaPPmjw2SV9QwqgKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VElIniLMDSesrJPxroM2HJ5S4bT9DgNdb8TJqF4hkWs=;
 b=E7nLF898mFGpqXmSF5xLBla20Uh0ouhQjVNYOBDG4hs8YxovrdHCBZQVqu7OA/Snq+o7jy5AtVM/eoYIOZENUex3+Yg8wiZ8AsUOQKte+M9akPbfNGhuFv2m+wHihTf/5bTcsxRUcn/LIDf9zxiO1TbvCnH9TA602jFNGCcVRLmnP8+pyYpkyUVBZtRWEwwOmE6avHBq8HhcWNyOLnCf2Q+GcP+jPfJKY3Z5Lxe5xZjUWb5CugF6h53ZuoMA2nH7MNZoBOhlWD4zxP6kkDEXUvqytfN57fJXlLu1WiqkTET/Xn6OtyL1rtAC1bJys35IczWSHbhmXgqQEZ8pnRm81g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=baylibre.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VElIniLMDSesrJPxroM2HJ5S4bT9DgNdb8TJqF4hkWs=;
 b=dKqESCQllEeJeFapCqXdSjebRqBlxMb5Cz8Vq/EyyCQJMIuPpgCRPq/0cMpaYbvcjTkdlBL/2DwYrwkBV//WluF64ravvD+OWYgKMJLaoWK+M+Ul+xaeaAiAqGxSkOTjk/1RK79QPV40fUyofVoCzYLfDlDj3tXaoHg9IZKHBP0=
Received: from DM6PR12CA0032.namprd12.prod.outlook.com (2603:10b6:5:1c0::45)
 by PH7PR12MB8016.namprd12.prod.outlook.com (2603:10b6:510:26b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 07:20:46 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:5:1c0:cafe::d) by DM6PR12CA0032.outlook.office365.com
 (2603:10b6:5:1c0::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21 via Frontend
 Transport; Wed, 3 Jan 2024 07:20:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Wed, 3 Jan 2024 07:20:45 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 3 Jan
 2024 01:20:38 -0600
Received: from xsjwillw50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 3 Jan 2024 01:20:38 -0600
From: Naman Trivedi Manojbhai <naman.trivedimanojbhai@amd.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <michal.simek@amd.com>,
	<abel.vesa@linaro.org>, <robh@kernel.org>, <krzysztof.kozlowski@linaro.org>,
	<angelogioacchino.delregno@collabora.com>
CC: <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Naman Trivedi Manojbhai
	<naman.trivedimanojbhai@amd.com>
Subject: [PATCH] drivers: clk: zynqmp: remove clock name dependency
Date: Tue, 2 Jan 2024 23:20:17 -0800
Message-ID: <20240103072017.1646007-1-naman.trivedimanojbhai@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|PH7PR12MB8016:EE_
X-MS-Office365-Filtering-Correlation-Id: 53a77fd1-68a7-4c96-e8ee-08dc0c2c80d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iwT4CDlTZxLpVNzMd7u4wG47sayhdp20uZ13WISSM6JiZ7EbkhPraRumnhtqOI4DDFLrvhBMVcQJkziPlpDh3xoTlw814HnOCMJ8ee21XVgkQRsQcFsDthJJho+o8uF1o2JdN0HY04Y8tiOjHyhuvnHtCUC2IwlmiUfBwfx/ydghq60lyrehDhZ+M6OF3AncXrbPsuSz2SH/JboQJwIotHcskdon9SG7FztDih3KK/fC3SA5JTHEg8cSvKryvz5mynLmbLlsc7+CLooOeF5plP4tkTfR6C9EQ5E4KZJQd5Wnsgz3BCRvg6Z8PDwnE6f8qy4Jkh/8bPxDX+r3vkEy5GHzZ21U65ZvwoDPf9dQrXliDeihDue5Xp/v/sRc2XgPx80zw0jWod0y8A3zVJ+8osivQlFUkmYBp9L6ox4li62XjO1ZH/LFDeV9gl9c8uL/xyrtVhr4l0SlzsA9S1iShN1ysdG+pu+8jsDBjQnPolqE1lWoMqrt4CcYowEpwVX7f2DvMWO5XD0tTNBX8Ba9t8y9DXUCow4GySHnF3Xvpz4xF4AuNS0zFO0yK4uv8RCYIDxR1BmMGVqkPIOy3OW27A0z3eMsatI7FLGvE+M+DLRpDJUkvsD1tSXxswQUgiZj1mrjKeLBxBs/DBPHV217P8UymMmxw2IwNZSOfR17qQE9dHNwIiW+SJqGh/26oqP7K6lyNXPS6Z25w2ecjmZ+84+5ia7ZtGKroy2FhJcDoDpWEkkjwAaYhmJlLtGPWzJLGxd2f8TmoSaml+zhi5djZCEzm/YioYbKRlEVkNiN8cqRRoLGf/1OIlKYSAVryG6/
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(230273577357003)(230173577357003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(6666004)(36860700001)(82740400003)(36756003)(81166007)(86362001)(356005)(478600001)(5660300002)(2906002)(26005)(2616005)(426003)(336012)(1076003)(47076005)(54906003)(70586007)(316002)(70206006)(8936002)(4326008)(110136005)(8676002)(41300700001)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 07:20:45.8648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a77fd1-68a7-4c96-e8ee-08dc0c2c80d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8016

Currently, from zynqmp_get_parent_list() function the clock driver
references the clock by name instead of its reference from device tree.
This causes problem when the clock name in the device tree is changed.

Remove hard dependency of clock name and update the logic to use clock
reference from device tree instead of clock name.

Signed-off-by: Naman Trivedi Manojbhai <naman.trivedimanojbhai@amd.com>
---
 drivers/clk/zynqmp/clkc.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/zynqmp/clkc.c b/drivers/clk/zynqmp/clkc.c
index a91d98e238c2..87915de083d9 100644
--- a/drivers/clk/zynqmp/clkc.c
+++ b/drivers/clk/zynqmp/clkc.c
@@ -549,18 +549,46 @@ static int zynqmp_get_parent_list(struct device_node *np, u32 clk_id,
 	u32 total_parents = clock[clk_id].num_parents;
 	struct clock_topology *clk_nodes;
 	struct clock_parent *parents;
+	struct clk *clk_parent;
+	char *clk_name;
 
 	clk_nodes = clock[clk_id].node;
 	parents = clock[clk_id].parent;
 
 	for (i = 0; i < total_parents; i++) {
 		if (!parents[i].flag) {
+			ret = of_property_match_string(np, "clock-names",
+						       parents[i].name);
+			if (ret >= 0) {
+				clk_parent = of_clk_get(np, ret);
+				if (clk_parent) {
+					clk_name = __clk_get_name(clk_parent);
+					if (clk_name)
+						strcpy(parents[i].name, clk_name);
+					else
+						return 1;
+				} else {
+					return 1;
+				}
+			}
 			parent_list[i] = parents[i].name;
 		} else if (parents[i].flag == PARENT_CLK_EXTERNAL) {
 			ret = of_property_match_string(np, "clock-names",
 						       parents[i].name);
-			if (ret < 0)
+			if (ret < 0) {
 				strcpy(parents[i].name, "dummy_name");
+			} else {
+				clk_parent = of_clk_get(np, ret);
+				if (clk_parent) {
+					clk_name = __clk_get_name(clk_parent);
+					if (clk_name)
+						strcpy(parents[i].name, clk_name);
+					else
+						return 1;
+				} else {
+					return 1;
+				}
+			}
 			parent_list[i] = parents[i].name;
 		} else {
 			strcat(parents[i].name,
-- 
2.25.1


