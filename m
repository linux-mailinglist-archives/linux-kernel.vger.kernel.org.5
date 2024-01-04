Return-Path: <linux-kernel+bounces-16995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DECE98246F7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53E4A1F253C0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A622C196;
	Thu,  4 Jan 2024 17:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4EC9aSto"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AE128DA5;
	Thu,  4 Jan 2024 17:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfF+otDr4/uElkm1WhDNXMyr8oanzR5vADyAigiI/qMLeL8KvQXJKmRUdtrcs7ENR65bj+u15pjBymlj07vhgBSZ1Oh/2DUrTzhe3ItywO3NqaHryvW2ARrrKRRk9u5PahX1xwagHBTVMFe8T0BrZeGTymvesO6OnwDudk/0uwU+Qdj2HER4OIZmv3aUK+/qTu8aDoQIJk8et2t/H91uNOsXsX3kgkVUaqwM6uqA4BkXNGYzEUHpoaoQDPU8gfPxKZV4Cd+edc8SongnxTbFEgYZUOVa3vLI9tgI6IpJyADsTPMwx7pQg56iWqXcfOVlRs28bbBZHcCqnqHPqp7REA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NstUmn740aiVmK2E7Q6KI+t5aKsOpGZHOE4KgGcl/0E=;
 b=d70AKCeUrkJRl/fodsPjM9wJmqH/EcEqQcRPxQS/3/6Q1Gdh2a1Ec/W1xsGH2Nut5eIOJiXKuYHCnRqv7Epne4MLkPl3GTuGfaB9mGxJHjRapJPE77nBjLHzCQ4x+bS4+ZXvPppdAu02ztHk7XnJyz1yAjN4cs0McEHCSSSI/nWAF08BnycR/JQa//2+87NaJ1gJgDgyv4hLNnwtIRrROjS/Dboz8Z8u+nXvfhiT4hCaRUawnBvDeQ7lWXv6Uerb5rumF2X55zTFVurxntYnF1rfA6Cs7huwoWYZld6AiSR2cvPT5Q3Sdo6w4lwPZRECK0R2jO5a7IcJNQI5fkSryQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NstUmn740aiVmK2E7Q6KI+t5aKsOpGZHOE4KgGcl/0E=;
 b=4EC9aSto/cQ+bw8ddssYWs4pSbBGsw8+1ZOaQEeZmjgBAir0RzQUSB2BgWBNGDuQGm1LwTzgIda5HvMBL5aB/+IMyvKh/8jcDAu+TQ7k+9mdjhS/F/YKAuwfxHkhWHqz518A20yd9pLNCE0Ih5q4pVi3Z3nZ4b7gFXdJy/poKIc=
Received: from DS7PR03CA0221.namprd03.prod.outlook.com (2603:10b6:5:3ba::16)
 by MN0PR12MB6341.namprd12.prod.outlook.com (2603:10b6:208:3c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Thu, 4 Jan
 2024 17:12:38 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:3ba:cafe::e0) by DS7PR03CA0221.outlook.office365.com
 (2603:10b6:5:3ba::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13 via Frontend
 Transport; Thu, 4 Jan 2024 17:12:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 17:12:37 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 4 Jan
 2024 11:12:36 -0600
From: Brett Creeley <brett.creeley@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH net-next 2/8] pds_core: Cancel AQ work on teardown
Date: Thu, 4 Jan 2024 09:12:15 -0800
Message-ID: <20240104171221.31399-3-brett.creeley@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240104171221.31399-1-brett.creeley@amd.com>
References: <20240104171221.31399-1-brett.creeley@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|MN0PR12MB6341:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eca0ff6-5843-4c84-ff2e-08dc0d485a1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	quINrKpWU0luNQ2TPsIWbjulM9I92FUMDj1l1F8GNNH55wQJoG67bSkF/wKHupDdcQPEPVOi1VBvtot8Yldo+8FY7AsARPWepEOULMiKkGGjsQlf0MtmauVYQ/jH6Gv5nWzfSNPvnFyVBrzbvWZkm34eKwl/b9To/MgOSJ6HTepEcLhXgvRONOHJJzbRfdv+sWEDLG+Nl/DIHiEmsgl/ZRoCUSFLv1NnEJ79UekeHTby1ytRYxLUx1FQKBRFHPBqxRXIi86J+H5hUaPhWY65uFoRhHkn6OhBK8bUTwXBnIa9XDss5g/ybVjOv0z5D5Xgvu3D0oz6GFwNkcCPcxCMDaMGAMN5yWQ4AM3uGIrERvsB88HJk9MCiBg3+28kiO1y8d1APhNheQZPa7e3C8z2UurY97GJIkoOrnlflNKRv39mYA+TMrUioCtvqXReVMC8wjq2VWFHmhD3ZjBho/wGlhzPv/TVwEmLNqY1uoIOMmxrdAx8GjJfkJqvMjOd+Yyh5N7pgjZZCNoRCYNtpISS6RMII1tQKzcWzQIKJnpEnGcP9zRTC/oyLN8U4Q8lMutRI75cY2byQCdaiPOfcdGepirRoEP2ZR2VOaIwWYiczjGcCtHWC1pRjXZOkZUQlSqP5rUM5qJFWoiuB4W0r3MLO7kWWRgmsMta18FUiXlgFdKhotYqmiFSLC4hENfun6v2XAA3HLfGQ3cIbzI9viecYPy8nJsma2ZogV9NZnFo9iw+F781gBR5pEn6l64DabqOeTXbmGLKbJbQPc9fY6ogQA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(396003)(346002)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(82310400011)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(478600001)(426003)(336012)(26005)(6666004)(1076003)(82740400003)(81166007)(36860700001)(86362001)(36756003)(356005)(2906002)(5660300002)(41300700001)(47076005)(2616005)(83380400001)(16526019)(110136005)(70206006)(8676002)(54906003)(316002)(70586007)(44832011)(4326008)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 17:12:37.8417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eca0ff6-5843-4c84-ff2e-08dc0d485a1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6341

There is a small window where pdsc_work_thread()
calls pdsc_process_adminq() and pdsc_process_adminq()
passes the PDSC_S_STOPPING_DRIVER check and starts
to process adminq/notifyq work and then the driver
starts a fw_down cycle. This could cause some
undefined behavior if the notifyqcq/adminqcq are
free'd while pdsc_process_adminq() is running. Use
cancel_work_sync() on the adminqcq's work struct
to make sure any pending work items are cancelled
and any in progress work items are completed.

Also, make sure to not call cancel_work_sync() if
the work item has not be initialized. Without this,
traces will happen in cases where a reset fails and
teardown is called again or if reset fails and the
driver is removed.

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/amd/pds_core/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index 0d2091e9eb28..b582729331eb 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -464,6 +464,8 @@ void pdsc_teardown(struct pdsc *pdsc, bool removing)
 
 	if (!pdsc->pdev->is_virtfn)
 		pdsc_devcmd_reset(pdsc);
+	if (pdsc->adminqcq.work.func)
+		cancel_work_sync(&pdsc->adminqcq.work);
 	pdsc_qcq_free(pdsc, &pdsc->notifyqcq);
 	pdsc_qcq_free(pdsc, &pdsc->adminqcq);
 
-- 
2.17.1


