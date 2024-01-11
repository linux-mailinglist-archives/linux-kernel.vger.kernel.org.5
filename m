Return-Path: <linux-kernel+bounces-23927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2555282B3FE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D196B21F4D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79C652F9D;
	Thu, 11 Jan 2024 17:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NW1jqLBS"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2081.outbound.protection.outlook.com [40.107.101.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC4151C33;
	Thu, 11 Jan 2024 17:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNbgwitWcq1qhSrlwcALzSYxYMhXZdHtthrzIJkuvZB4+IcTgaHLaRv75aDf2kEHFWKocE4cykmh2oX4knh2kjNvQHXpm0v4DacCC8/v+K2Zo3JAZ2lC3sgMmfMa9FAQFSd7ZIAmnLfHFGo4zi6GY83TJ1BdKPbi2+sC/mm0wp0a3N2kKyvIKdqMUiYaOq6w7VOuUr5mwTQU6Y3YGtAxN8SLF58d8+k0w50xV1ghAWMLUF3AGGABXd4OxTHOK9QJJIBzKpCGlFFkPMEu64lM58q4r8hNoOX0d2rkEPpBNh3RBYfNJ7xpBr2/yV9saxzlPyGQYT7ANttYdvD8YQY5yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPFgkHNVClUS7oF5jmYOECByqrV+O2iNTvBYPC0Ss6w=;
 b=KIZ3rWZ6DQquw9gHGOSYo05VKtUJXcF1JCkPUlJWf7wJsFkybcck527EXwURvSFN7uvH45rF+cxXjM/beCeWGSw+M6Sm6HxQf6sScIDZVT0X9HGHajJ/eEB7YBZCMFTZbIBQPne0kbKS1GNY9OkkEU0+m1yhglO1Bdg9Q0TA7CNdO9O+Ou131gJ2A/6I4kC1iZrTPB2Sjs9W9hzBK7mBha/Cvwj4O//VhnE97EP1nL6ZvMmBn0af7T7HlkGJstRbapTJZ2zNOX+HiHwMoaBJUqm/flClWvYyGDr6OVAhJTVVinfXaNn0KS41/X7bxHVIykNbyk+U9kvKOcNZuj5UYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPFgkHNVClUS7oF5jmYOECByqrV+O2iNTvBYPC0Ss6w=;
 b=NW1jqLBSa4Q3msWmwOa5t1nDyk7PMDvvX4NB0xiHfbncKpoTvMcPO8brDBciLPJ8LGqBOgzUFaHeG78eZcn+NMloz+/p7YRBcMe/Oft8xqcQ4Iww2Febm5oqJ/Y3mR+Q31Hlif4g7ZgxZMO0IKGYPU96MmQbBg0Y3INgIJaLBZA=
Received: from SA1PR03CA0008.namprd03.prod.outlook.com (2603:10b6:806:2d3::7)
 by CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Thu, 11 Jan
 2024 17:22:29 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:2d3:cafe::9e) by SA1PR03CA0008.outlook.office365.com
 (2603:10b6:806:2d3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19 via Frontend
 Transport; Thu, 11 Jan 2024 17:22:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Thu, 11 Jan 2024 17:22:28 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 11 Jan
 2024 11:22:28 -0600
Received: from xsjblevinsk50.xilinx.com (172.19.2.206) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Thu, 11 Jan 2024 11:22:27 -0600
From: Ben Levinsky <ben.levinsky@amd.com>
To: <jassisinghbrar@gmail.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<michal.simek@amd.com>, <shubhrajyoti.datta@amd.com>,
	<jaswinder.singh@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <ben.levinsky@amd.com>
Subject: [PATCH v2 1/3] mailbox: zynqmp: Move of_match structure closer to usage
Date: Thu, 11 Jan 2024 09:22:24 -0800
Message-ID: <20240111172226.1816105-2-ben.levinsky@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240111172226.1816105-1-ben.levinsky@amd.com>
References: <20240111172226.1816105-1-ben.levinsky@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|CH3PR12MB7500:EE_
X-MS-Office365-Filtering-Correlation-Id: 218b71b2-7698-475d-4331-08dc12c9e311
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ARsAp58kLY5HT6vbUBnWk5AnVYDQz/5jXrfwDuI6wYSsoQHWARKbVR09yqNFetKpXegQj2xrTzLsZihmUnadSqxgA7X/g3uNl67uFYMpH9oNUCSHGsTIoOOt/r1h5cJ6fBJtt1gtGyIHGlS9VsoPVuMMRjH3Qub0l0BJ7MldSMEOM13zXXkNq1QwPizA2qpZBO02eQPfi6dri6TAEQ+Klk74O9sD+kbmyZkzFi0YMgy0y41EEb1+7g5YkHMQ69cOvoZsx2W/dt95SvE3fC2rpQiypB1RXb9iqEjNxr4FJNM9BBsnA7py75FPBvjfd7Hpyi6Te4HG/59zbItlPnCGSMowOEKmiLoLV0wlNuoZyW4nr15uzLSReYu4zwv0qkbpOLsRsQOijMFkPf6ug3AOm/XXvgEFkUbF4/v2/7tA4OBeHpEcsI/27+enOvxTI611FZSFkjGQIlJdEioIu4LNjobdzBPtALiTaaIY0KjrjuJN9Ig9lxne3QZ/cS8omX2YnR7pRLwiTTksufnMf5s1dykqO+Bp7zjOVILLeX/P9T6d8iRgc8LCWSb/DS3LxixkiV57uMl6yV+FoQovFBApjYNI4IgzCK3Fo2xYMmTbxqWTrX08cNMJMNl8Dgh9tBpG0ZSpZ5qkoWwlYokDVeatO3LfAGCFLWZbfBywjoogNQ2JUyHm8Ra4LbAmJJ2XD/l35W/MSLnzi6nru6vaSym31mFs9CH5LWOjZwr6wkGk5By/zENHgfxVqEf/D2U11WgbET1z3BUYPJKxXAAV8QsSXQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(82310400011)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(83380400001)(70586007)(36756003)(356005)(81166007)(86362001)(41300700001)(70206006)(36860700001)(1076003)(336012)(2616005)(26005)(47076005)(426003)(4326008)(6666004)(478600001)(2906002)(316002)(8936002)(54906003)(110136005)(15650500001)(44832011)(8676002)(5660300002)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 17:22:28.6428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 218b71b2-7698-475d-4331-08dc12c9e311
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7500

The of_match structure zynqmp_ipi_of_match is now adjacent to where it
used in the zynqmp_ipi_driver structure for readability.

Signed-off-by: Ben Levinsky <ben.levinsky@amd.com>
---
 drivers/mailbox/zynqmp-ipi-mailbox.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
index e4fcac97dbfa..951389f0b90c 100644
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


