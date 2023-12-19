Return-Path: <linux-kernel+bounces-4719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FB2818124
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 06:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A448BB23E5C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 05:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7249BE79;
	Tue, 19 Dec 2023 05:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OLkwRozU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2042.outbound.protection.outlook.com [40.107.96.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D458F4D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 05:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WmSfd4vUn7psRWHSCcLOXH9zqmL2dDYptLhod3XPnEq+oAaRzbTSneXAHdBQuakrEtyfhPBZTGh85bwSHzvZBfMnAJg+R1DlTDonwKmS29y0sMOjJRLJi3h8Rx2kBaD8YtXcV0qFApTNQ8v8hYE1ThTx36YW2x/fPXEH3yHu9aofStbGZs8M8Ey9IDyQ6ogxFHMIX2WYz49VnJ4X/zp2LuwmZO+qAlvSJHAQkCg9EIkFq66tmHfb87u/+LddHb2ARg4p5b3Yb8UpJLSqnAYfDKu3/wR8WhPkqkWjNpzLlDhdwytmYE7pIy4bWK80L8FyOJOKvKrpnqZYz2JjqHGUbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmqG0n32ktuAdZDprmZUiMMAlDSZyICjmp1qpej5fqw=;
 b=eRmZTKjAKZAo12t2N/jqn7Kq8ktuyXAPioLfoKd1UrzxcVpoECz0AuZFxvmXmKmi4bmuWX+KypLr9KkUADZrlmraRmaFCwSVaBnexMB9wo6u1LNmeVgEFGzxdLTGOfmY093lvB6f9OpyNdNjnqWXNAR7x7+LqKm+P4eIEmPf2J2xxjA90QQWbVzTU5iGhT6zD06BelgLawAXf2/DGIHopVbIGC25a+mvJ6v4Hez5XsB7/1OhdRW0IJMXm0a3f6iPDnXlX8pgn34V16l+yK0HKhaYpOYgYB6itZbMqWASJJDHuddoTEJVDUlrelNDQ57g4PBn+6Jrs9FarVm36S4IqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmqG0n32ktuAdZDprmZUiMMAlDSZyICjmp1qpej5fqw=;
 b=OLkwRozUR/8gY4ZxWGLgShxXYXWFgJYAPfF062qSSL9rkWF2jxo+VKJKchsHZPWXYvHnSV0d0eZZKWAbBoeKd9+I/5j/JSWAqjkBQqNHQD2vz02FvGPSR9YgEoeLvLWJ8TG7rqX1smo4L3iVXlWTez0SLx1wga2GTH2FhLyrRk0=
Received: from DM6PR01CA0023.prod.exchangelabs.com (2603:10b6:5:296::28) by
 PH7PR12MB7140.namprd12.prod.outlook.com (2603:10b6:510:200::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 05:50:48 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:5:296:cafe::2) by DM6PR01CA0023.outlook.office365.com
 (2603:10b6:5:296::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38 via Frontend
 Transport; Tue, 19 Dec 2023 05:50:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Tue, 19 Dec 2023 05:50:48 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 18 Dec
 2023 23:50:48 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 18 Dec
 2023 23:50:47 -0600
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Mon, 18 Dec 2023 23:50:46 -0600
From: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To: <michal.simek@amd.com>, <gregkh@linuxfoundation.org>,
	<sai.krishna.potthuri@amd.com>, <linus.walleij@linaro.org>,
	<nava.kishore.manne@amd.com>, <dhaval.r.shah@amd.com>, <robh@kernel.org>,
	<marex@denx.de>, <roman.gushchin@linux.dev>, <arnd@arndb.de>,
	<shubhrajyoti.datta@amd.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Subject: [PATCH V2 1/2] firmware: xilinx: Export function to use in other module
Date: Mon, 18 Dec 2023 21:50:24 -0800
Message-ID: <20231219055025.27570-2-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231219055025.27570-1-jay.buddhabhatti@amd.com>
References: <20231219055025.27570-1-jay.buddhabhatti@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|PH7PR12MB7140:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c5090ba-00b1-445a-9e17-08dc00567385
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d7eTF5YU7gHQ4cDTLw4QHQrLs4Mp2KEq85BOnLmI+n5PDOmwCwzyEctVd6uOz51Hjb++GVk7tWiEQaO24IID/0Nq0y1ExZri8X1lEXfJsBCcEtUylRcBAuSDpGPwpQAmfiKaI+Waz6LINhTlE9ZrBJlnNsZqkv/qKDysOsAFnywz6yy0jldAY/FsWRGzCqIjD2fsjTJqs0Naw+om4tj6jTToKk8YSdGPT7QcknGzlCRrynSWp/NU0NUSm+cpoYmTwyn8WBK218FZPvKEPc3hwzYfdxRIVTcSWDleiLLupvezg16NvJlZ5Q0EoFMY+obN8LHK4tPQGKyJhShme58GG2NHXgzLGHCxFkitVoJ54tlulz1P+YbRFi+uJXncFwNS5SYgl/JkKFcms6duX8POCOABYc8oBncuFX3XuQgzFQiEzuUJlKPu3R16tUFiDHIT4/oUK+k7pPvmfflNsJbe6tHURejLaZWStBoCZi7Fg5ehTvnhyVjgEvb8jHr90zE4q9q742XIn8BKCvGfIJW8EQ7tVzHnK+Pl2z6uUW8wdWwNXtesSmNW6p/JzhbuQbfXK1dgz4KXzYnc2jr5xBrDNZ7RXERMHwdfWzFtaoy1n3qr8+ZsJ7MqUY0B7SO9eVuSOfsYodpqXoQ2opKbCbmubTjpnwhuipAQTK9gnuQNX371kZdwKunrheSetY2G6qbHP9W8xbpdGwY1oLCGjgEFtS2ehCGmcXwff9afUyRgWNk2Ald2vo1RPJsG3EJMUamZyo3Ht74pSD6y6gSNKs4FjqKQovwwkwl4FZp9s01J1v0=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(82310400011)(64100799003)(186009)(451199024)(1800799012)(36840700001)(46966006)(40470700004)(40480700001)(86362001)(81166007)(356005)(36756003)(82740400003)(40460700003)(6666004)(478600001)(41300700001)(54906003)(6636002)(70206006)(70586007)(921008)(1076003)(336012)(26005)(2616005)(47076005)(83380400001)(426003)(2906002)(110136005)(44832011)(5660300002)(36860700001)(316002)(8936002)(8676002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 05:50:48.4310
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c5090ba-00b1-445a-9e17-08dc00567385
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7140

Export zynqmp_pm_get_family_info() to access and find family information
in other module.

Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 3 ++-
 include/linux/firmware/xlnx-zynqmp.h | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index b0d22d4455d9..313965f79dd7 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -414,7 +414,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_get_chipid);
  *
  * Return: Returns status, either success or error+reason
  */
-static int zynqmp_pm_get_family_info(u32 *family, u32 *subfamily)
+int zynqmp_pm_get_family_info(u32 *family, u32 *subfamily)
 {
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 	u32 idcode;
@@ -439,6 +439,7 @@ static int zynqmp_pm_get_family_info(u32 *family, u32 *subfamily)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(zynqmp_pm_get_family_info);
 
 /**
  * zynqmp_pm_get_trustzone_version() - Get secure trustzone firmware version
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index d1ea3898564c..2375ce9b38df 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -515,6 +515,7 @@ int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
 #if IS_REACHABLE(CONFIG_ZYNQMP_FIRMWARE)
 int zynqmp_pm_get_api_version(u32 *version);
 int zynqmp_pm_get_chipid(u32 *idcode, u32 *version);
+int zynqmp_pm_get_family_info(u32 *family, u32 *subfamily);
 int zynqmp_pm_query_data(struct zynqmp_pm_query_data qdata, u32 *out);
 int zynqmp_pm_clock_enable(u32 clock_id);
 int zynqmp_pm_clock_disable(u32 clock_id);
@@ -596,6 +597,11 @@ static inline int zynqmp_pm_get_chipid(u32 *idcode, u32 *version)
 	return -ENODEV;
 }
 
+static inline int zynqmp_pm_get_family_info(u32 *family, u32 *subfamily)
+{
+	return -ENODEV;
+}
+
 static inline int zynqmp_pm_query_data(struct zynqmp_pm_query_data qdata,
 				       u32 *out)
 {
-- 
2.17.1


