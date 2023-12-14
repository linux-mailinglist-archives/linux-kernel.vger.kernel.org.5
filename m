Return-Path: <linux-kernel+bounces-116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCF6813C64
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79935B21890
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FE754275;
	Thu, 14 Dec 2023 21:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ajUXps82"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2056.outbound.protection.outlook.com [40.107.96.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF04273FD
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 21:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lY0WaXNUyBYkI27kPJ6h1o51FwOZjdHJCsOw0C3stBllC9Quk0FxQZet6o2EWm0WgiegP2C/OsYyOhEIBC4q9wmqWlD6kmMMj1PvChgh6J2kVhIsiyrbr+AX63+OfHwbdkcIIrQw0GUKjVSxJtNXzOrkYPB/of8/s3GupLZxKD2MCm2t3ex9x6zE7/v545WjU4IWdbx5w73TJ7Q89fN+i3kkXnnC4P0EEFqT06TUXH7T3LYT18AAlRJsCzlQIfNoS5FJcLESowYtvyXMEFaGyAiWcIw172bPNEqUNYAql+snLzTm3ZqQ85mrTMYRrvk6yNaYuCKcMl7dRTwITSxzvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJaW3xmFHW6u2hIIQXXhRYmYvsNTroIdrN2SHojrJkc=;
 b=TAlgTP+jbD7tuh/Hyc5OOC9DT4ozEpj/3WRx8dSJCsXyu4B+V2h5/6a8Sl85QA6rELVkrlsdFnD5ceQ43k4m3pqU0caOBNKDJKbJn1LxxftCoa639XNjOhnrNF9JP/fkt2i7yvgHOZ/lYBTwB5788wkQvBGxdTXuraYh4CLsbJlpc9eXLhtsPsWtU/4pg09wBUm88Rw7UWHSvSBcHFhZ9i8/Iv4HB93t9mnQP9dCr9NolsyN8atBZTWhyi7SutDA07UNyCF4od+llZm5S1sk/mdgu2TwBysZkr5TY7z2WmktHmZSvkwUKR5QAPuC05PIHYgV0xRSR1Ibv+j6IZ0IVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJaW3xmFHW6u2hIIQXXhRYmYvsNTroIdrN2SHojrJkc=;
 b=ajUXps82BgIsUHHBBgdh3XpBxwpdnXCKLf3YdiXNl/WIRaa/fJlJC6lCbIlhKOM16o/7VokepAix6LM2qbXMaK/kQfaLEZxr7uUa7/A64/QgEidIWynUw8HEh891z7c/iWC87xLy32vdaIOPZFfc2O+sv8Tp6plUldBXoYw3imU=
Received: from MN2PR19CA0023.namprd19.prod.outlook.com (2603:10b6:208:178::36)
 by SA0PR12MB4463.namprd12.prod.outlook.com (2603:10b6:806:92::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 21:13:56 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:178:cafe::f9) by MN2PR19CA0023.outlook.office365.com
 (2603:10b6:208:178::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Thu, 14 Dec 2023 21:13:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Thu, 14 Dec 2023 21:13:56 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 14 Dec
 2023 15:13:56 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 14 Dec
 2023 15:13:55 -0600
Received: from xsjblevinsk50.xilinx.com (172.19.2.206) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Thu, 14 Dec 2023 15:13:55 -0600
From: Ben Levinsky <ben.levinsky@amd.com>
To: <jassisinghbrar@gmail.com>, <linux-kernel@vger.kernel.org>,
	<michal.simek@amd.com>
CC: <shubhrajyoti.datta@amd.com>, <tanmay.shah@amd.com>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 1/3] mailbox: zynqmp: Move of_match structure closer to usage
Date: Thu, 14 Dec 2023 13:13:52 -0800
Message-ID: <20231214211354.348294-2-ben.levinsky@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231214211354.348294-1-ben.levinsky@amd.com>
References: <20231214211354.348294-1-ben.levinsky@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|SA0PR12MB4463:EE_
X-MS-Office365-Filtering-Correlation-Id: 63570b73-a785-4db4-6f1b-08dbfce99530
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bSLDt/cEiKwEoPvfHStbmtjKhdcvEIs8NiHKhpxL7MLfeUkMFZW6hKdI0TVtrVD2SiQmW9VYiTsHKwUhTgysiTltogvLDbN3+xupRpunh+UnDKgnDhWW9sBZk12Ua0yvFUhXuKRjUoPolhfnz4vK6hRgoayP7mX+1XWl8gp6NNlVNZfinnbdTZjHWnrz2+G1WYXKAbaVASwxfzuVubiarqbn1QFK2AYJ116p7C5+uOejUlZ9nD+2VqufuGLGOfjMbIW8uvpI62RhzWB1+LCL+8EEibBVr59i+jGhJiNia4vlk2QymfgwTu5IK16gublDsWFJYQGatd3YNGQ4HX5enYWNDrtWDs+gPSco/oZ9zigryt1Q2CU/+1b3vj617M/jMGNfZHUXlEO/CuaSFfWXHDpoxkFVrGOzUy7FspICdeOWoe+6nSJLYcoNLs/4jT5KmgxJ0GPh5DITxZCCyz5Y5eqLbM+NKHTHkAM8wxIWZt1Dr+1+v3UvKbrBP3b4PK46BdCcMZMctuaB2jwIabTDgG0dAitE2JcD5KJvw2qym7Hr3fz03BXV+cYJY6vHXME7UDlCQQs3j1wNRcgGpMqtMB7o7NX1KIM9ulqRlAeYuJtdA+VORV5783nYauheL0aWJb7v9+tSecdw0Z7PyFHKTjzeLrhr7EgDC8SiKJg/M1WxNiHNROUCQDuJoMsoeh1StT3gJqqMAKu1Cq1HD5J8EGpng+r+jUKY4P1YiiTgFTW1Gh46SAa0mzI83kHIackN8L10b/oaN26/hs43CD/zKg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(82310400011)(46966006)(40470700004)(36840700001)(44832011)(5660300002)(40480700001)(15650500001)(6666004)(478600001)(2906002)(82740400003)(356005)(26005)(2616005)(81166007)(86362001)(40460700003)(36756003)(1076003)(70586007)(6636002)(54906003)(316002)(70206006)(4326008)(8676002)(8936002)(110136005)(41300700001)(426003)(336012)(83380400001)(36860700001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 21:13:56.3147
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63570b73-a785-4db4-6f1b-08dbfce99530
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4463

The of_match structure zynqmp_ipi_of_match is now adjacent to where it
used in the zynqmp_ipi_driver structure for readability.

Signed-off-by: Ben Levinsky <ben.levinsky@amd.com>
---
 drivers/mailbox/zynqmp-ipi-mailbox.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
index 7fa533e80dd9..2c10aa01b3bb 100644
--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
@@ -416,11 +416,6 @@ static struct mbox_chan *zynqmp_ipi_of_xlate(struct mbox_controller *mbox,
 	return chan;
 }
 
-static const struct of_device_id zynqmp_ipi_of_match[] = {
-	{ .compatible = "xlnx,zynqmp-ipi-mailbox" },
-	{},
-};
-MODULE_DEVICE_TABLE(of, zynqmp_ipi_of_match);
 
 /**
  * zynqmp_ipi_mbox_get_buf_res - Get buffer resource from the IPI dev node
@@ -698,6 +693,12 @@ static int zynqmp_ipi_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id zynqmp_ipi_of_match[] = {
+	{ .compatible = "xlnx,zynqmp-ipi-mailbox" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, zynqmp_ipi_of_match);
+
 static struct platform_driver zynqmp_ipi_driver = {
 	.probe = zynqmp_ipi_probe,
 	.remove = zynqmp_ipi_remove,
-- 
2.25.1


