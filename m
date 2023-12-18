Return-Path: <linux-kernel+bounces-3259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F2F816A05
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C204B20E42
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DCD125AD;
	Mon, 18 Dec 2023 09:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Oe3RVOw7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768EE11CA6
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 09:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNXpjuuNiwrg+pItMC7Pb1O5rwG3ZM4la6zCd9joRkH5S3blvUZnH8PiEoJBlhonuWEcmoKnVIJx1sbIES5xL0/qGe+ICdIS7/R2OFGdsH3AMiIZPGX4ymo3gI2GZ++IiBl/wV7KbhMDHXQ6Q5La5Bu92eSv57TmygoqzoXWAie6V/g2MvdAe4ZNsxzSao4ek68tfhTtlnzfOSdv6tHx7R8IFyiTsh633zGw3W5N+fJit7kxsKli34TFtULYkhmgG+xhI/xmxhgEyMN6smXph7xsjr67SwC7DSZ6TFtPdcrbTPjzoSNRyctaZ+x3oge1CjW+BfV3GZ8IZJ1rVMM2Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTdFTDH34zqFL+os6DSLDnQ6k9aq/OmzQzh+OzCCuSQ=;
 b=kOWpuWBd1qW0RIY/Du+hdx6XjN9Xd8TC9ijxMPrkDE4pULprR3ZDalZY5PjrfpKShhMpHpf6nPFIvwSvPug1lZ4k7QR6FY+DKC8RO36jvcv/bAl95iL6ef9wjnsWlMxUxUOqvjGNaYGvGO+EnNNUsWrYUBHKG9+6y3J0kWIiCd5SVAjpHVDmZgsk5OXJi8/lAW3RMV42BbuvhK8RLfgTv6c/6UDEkfWIqT7S8h9cHhusVGVxTHw0m7ORh7XLNaK9dse8Xm4SMuZpKT5YD/j5LO1bWrSGB4SaHoj+iPqxt577l1vD/CMvjS5S+A2mk2jQyEsGt+vXqimt7XoN9f7m3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTdFTDH34zqFL+os6DSLDnQ6k9aq/OmzQzh+OzCCuSQ=;
 b=Oe3RVOw7eP6KuvTlLWgQH3CuTDInWqrFhIq9pB/j3svFcrsstXs7YMpgUeQtuhqVVc6qngapRppdM2xrpOzy54aB31w0vUErhrYtzkD4+0gzssLMOHdaeuN6w8ZZnXIgt6Dc0oqe6jBODSSDQf38hDcAt6eXrHpXmG2d1iT0S4M=
Received: from DM6PR03CA0043.namprd03.prod.outlook.com (2603:10b6:5:100::20)
 by DS0PR12MB7873.namprd12.prod.outlook.com (2603:10b6:8:142::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Mon, 18 Dec
 2023 09:41:35 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:5:100:cafe::a5) by DM6PR03CA0043.outlook.office365.com
 (2603:10b6:5:100::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37 via Frontend
 Transport; Mon, 18 Dec 2023 09:41:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Mon, 18 Dec 2023 09:41:35 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 18 Dec
 2023 03:41:34 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 18 Dec
 2023 03:41:08 -0600
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Mon, 18 Dec 2023 03:41:07 -0600
From: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To: <michal.simek@amd.com>, <gregkh@linuxfoundation.org>,
	<sai.krishna.potthuri@amd.com>, <linus.walleij@linaro.org>,
	<nava.kishore.manne@amd.com>, <dhaval.r.shah@amd.com>, <robh@kernel.org>,
	<marex@denx.de>, <roman.gushchin@linux.dev>, <arnd@arndb.de>,
	<shubhrajyoti.datta@amd.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Subject: [PATCH 2/2] drivers: soc: xilinx: add check for platform
Date: Mon, 18 Dec 2023 01:40:09 -0800
Message-ID: <20231218094009.13528-3-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231218094009.13528-1-jay.buddhabhatti@amd.com>
References: <20231218094009.13528-1-jay.buddhabhatti@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|DS0PR12MB7873:EE_
X-MS-Office365-Filtering-Correlation-Id: 03b171a2-0b9a-4c0c-da91-08dbffad86bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AGhuAjGA4W20HKOxPrJ0z+nPJ34xcl0Aaj+VKzVsKtvRVAB2TQXrOwI+inZcxLrhpS41/6VCHskl7BonJ+BkmHWw20cSzJo8uTXzkCEU5TTCdSx4LCoAHOtyJyN0ib391rjZ0lecrXInrWaGKyYLWb/sBC5+zCTvtXtcFJ+qkQ2aA00BDmDe2qZOA1IoT5heYNw0q0Zio0iwBo1RGHRJh68rA1UdfGGJVOjcDbMfhCDHD/B1Rq+auXUR4PjtIIO4YqhNLzV0GdFgcYC5yYHUaEgUDlSQj33D68OUneUTzCsw9ZaVAwrlH+BeIRBfr+YJErCVH1NoJSi5W8/G/NmUV0V5Tc7GSjk4OCHCUJxW1FCh+iEIPhc+8LztCP65aPKkloSe8CXiJ8feSIUxhR0+9F9T1o9jVGa7ra8dpPMcoUAEJZS3s37dvvVqoQtTyW0NeANVyjYVYZCuM8RtuqhxFKHR6M0lzJkrx49C3FPih1kzPn/C6c/Kwr6YbNSQ6t53IdeKPF+HTn11ToGnQtf1sGwpxyh5JOuQ7Ocr3XlJ9SeCOJUG81Cgdw/6Z+QXf0KVSC67VuPkcVXIHK+o1CFgG23h85HDnmOfSiFazeHbpSgr2CFZeGLjnCoSTsikEiWmS/kBGH+4bAlRIoSiauCKVuYjFrZpBk62FMs3oNRH9yw5QyYmo7FtJQTARRjUZHl63+TArI7T4wpri91DLjBNdFhkazwwMl2zmN/A07jBSptbcJ3SOTcjPJugm0zzx7hFXhXpKtXfLWVVr5w+pZ5AdtifuZBNruyA/3hVnUQQz50=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(396003)(346002)(230922051799003)(186009)(82310400011)(64100799003)(451199024)(1800799012)(36840700001)(46966006)(40470700004)(921008)(40480700001)(40460700003)(70206006)(70586007)(6636002)(81166007)(356005)(82740400003)(36756003)(86362001)(36860700001)(1076003)(336012)(26005)(426003)(83380400001)(2616005)(2906002)(316002)(8676002)(8936002)(54906003)(110136005)(478600001)(5660300002)(47076005)(44832011)(41300700001)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 09:41:35.7159
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b171a2-0b9a-4c0c-da91-08dbffad86bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7873

Some error event IDs for Versal and Versal NET are different.
Both the platforms should access their respective error event
IDs so use sub_family_code to check for Versal or Versal NET
platform and check error IDs for respective platforms.

Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
---
 drivers/soc/xilinx/xlnx_event_manager.c | 25 ++++++++++++++++++++-----
 include/linux/firmware/xlnx-zynqmp.h    | 16 ++++++++++++----
 2 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/xilinx/xlnx_event_manager.c b/drivers/soc/xilinx/xlnx_event_manager.c
index 86a048a10a13..78f9a3c6ae11 100644
--- a/drivers/soc/xilinx/xlnx_event_manager.c
+++ b/drivers/soc/xilinx/xlnx_event_manager.c
@@ -77,11 +77,26 @@ struct registered_event_data {
 
 static bool xlnx_is_error_event(const u32 node_id)
 {
-	if (node_id == EVENT_ERROR_PMC_ERR1 ||
-	    node_id == EVENT_ERROR_PMC_ERR2 ||
-	    node_id == EVENT_ERROR_PSM_ERR1 ||
-	    node_id == EVENT_ERROR_PSM_ERR2)
-		return true;
+	u32 pm_family_code, pm_sub_family_code;
+
+	zynqmp_pm_get_family_info(&pm_family_code, &pm_sub_family_code);
+
+	if (pm_sub_family_code == VERSAL_SUB_FAMILY_CODE) {
+		if (node_id == VERSAL_EVENT_ERROR_PMC_ERR1 ||
+		    node_id == VERSAL_EVENT_ERROR_PMC_ERR2 ||
+		    node_id == VERSAL_EVENT_ERROR_PSM_ERR1 ||
+		    node_id == VERSAL_EVENT_ERROR_PSM_ERR2)
+			return true;
+	} else {
+		if (node_id == VERSAL_NET_EVENT_ERROR_PMC_ERR1 ||
+		    node_id == VERSAL_NET_EVENT_ERROR_PMC_ERR2 ||
+		    node_id == VERSAL_NET_EVENT_ERROR_PMC_ERR3 ||
+		    node_id == VERSAL_NET_EVENT_ERROR_PSM_ERR1 ||
+		    node_id == VERSAL_NET_EVENT_ERROR_PSM_ERR2 ||
+		    node_id == VERSAL_NET_EVENT_ERROR_PSM_ERR3 ||
+		    node_id == VERSAL_NET_EVENT_ERROR_PSM_ERR4)
+			return true;
+	}
 
 	return false;
 }
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 2375ce9b38df..2cfd78f232dc 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -91,10 +91,18 @@
 /*
  * Node IDs for the Error Events.
  */
-#define EVENT_ERROR_PMC_ERR1	(0x28100000U)
-#define EVENT_ERROR_PMC_ERR2	(0x28104000U)
-#define EVENT_ERROR_PSM_ERR1	(0x28108000U)
-#define EVENT_ERROR_PSM_ERR2	(0x2810C000U)
+#define VERSAL_EVENT_ERROR_PMC_ERR1	(0x28100000U)
+#define VERSAL_EVENT_ERROR_PMC_ERR2	(0x28104000U)
+#define VERSAL_EVENT_ERROR_PSM_ERR1	(0x28108000U)
+#define VERSAL_EVENT_ERROR_PSM_ERR2	(0x2810C000U)
+
+#define VERSAL_NET_EVENT_ERROR_PMC_ERR1	(0x28100000U)
+#define VERSAL_NET_EVENT_ERROR_PMC_ERR2	(0x28104000U)
+#define VERSAL_NET_EVENT_ERROR_PMC_ERR3	(0x28108000U)
+#define VERSAL_NET_EVENT_ERROR_PSM_ERR1	(0x2810C000U)
+#define VERSAL_NET_EVENT_ERROR_PSM_ERR2	(0x28110000U)
+#define VERSAL_NET_EVENT_ERROR_PSM_ERR3	(0x28114000U)
+#define VERSAL_NET_EVENT_ERROR_PSM_ERR4	(0x28118000U)
 
 /* ZynqMP SD tap delay tuning */
 #define SD_ITAPDLY	0xFF180314
-- 
2.17.1


