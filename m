Return-Path: <linux-kernel+bounces-21906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 033E9829676
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C9691F263CD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1873FB04;
	Wed, 10 Jan 2024 09:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5qFXl8Pw"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC31C3EA92
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 09:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XT0VATfvsn5huIo2H9ryUdJj1Ox/kt5hH/JI+j3+YFI6Tof3taRft2tpIvRPOo5C3TXG/WIHhoSHRaq4cajDMpC/wuGsx5mC/wxyXKZ/xUC6WFj2uBS8tlYPOl4VC2U/CBRlDa0m93SAlLO26vlaEJWptb2U3u5QTqrWOsbU30ZoHsnpdegktfG8gY97JCq9n7KFHoHvUdePMsJbdsfBXNr8UOrP3UOy5IJOGihN6A2md4jdK5dGDIdQMJEEuHHWVYGA4vmSdc3Kfv6XqxC72Zh4Hz4exXHyLUsoNHOIS91Cl/RwpjHmmIV/S6qrRErlHINqDUHzVDAT3wV9yiGEPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3FUll9g48yT28JmsXARXTAemBCjApLBkCbQGE4O98M=;
 b=jt/WN36APKtTnkCsTwP9712VpV0Jiaf1zKPCMz2sOF0aR6sokjkESTaP/FORctCBTaM+BEdgacGCrcFipb65YAMMzQExV2eZ7oNcG+s2RJlm1vFiOCJdsTnU4qSC8jcf9CGdsSTlLp0KZhuUGEu/3s75nFV5TptufO8blxJBJ/Un91M8HTi9DNk4lWPp8FfyZ6m2oNDn4Cj8xfUq6pH4OsM6Y9vMgrlyukBlzfFcxE0fLMq3a/Aeft3ivvv3g2opODsPJnTMarTMPhdtDKpVoMX33USKWGR1DPo7G7MR90oSqhzRd3D6/KA07ypqeESLWqjy42hVZhxXmV1hcFo0/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3FUll9g48yT28JmsXARXTAemBCjApLBkCbQGE4O98M=;
 b=5qFXl8Pw6qaA4zg+sXOoeMukHX7riwM1mpEEEX4gO8wHIFb7uvS2plOW/5kGkOTwKEipVfnkyuIgg25kvYjFZTMiX++8RYmA37ruduhph8++QVu0ssFwEXDG88A9U8gOQeNLFEUbSQ0Xqt2mDCWMLGQYhMCL3j7Z+U7+SpLzY54=
Received: from DM6PR13CA0028.namprd13.prod.outlook.com (2603:10b6:5:bc::41) by
 MN2PR12MB4127.namprd12.prod.outlook.com (2603:10b6:208:1d1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.24; Wed, 10 Jan
 2024 09:45:18 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:5:bc:cafe::aa) by DM6PR13CA0028.outlook.office365.com
 (2603:10b6:5:bc::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18 via Frontend
 Transport; Wed, 10 Jan 2024 09:45:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 09:45:17 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 03:45:15 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34
 via Frontend Transport; Wed, 10 Jan 2024 03:45:11 -0600
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>, <vkoul@kernel.org>
CC: <alsa-devel@alsa-project.org>, <yung-chuan.liao@linux.intel.com>,
	<pierre-louis.bossart@linux.intel.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <vinod.koul@intel.com>,
	<venkataprasad.potturu@amd.com>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V2 03/13] drivers: soundwire: amd: refactor amd soundwire manager device node creation
Date: Wed, 10 Jan 2024 15:14:06 +0530
Message-ID: <20240110094416.853610-4-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110094416.853610-1-Vijendar.Mukunda@amd.com>
References: <20240110094416.853610-1-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|MN2PR12MB4127:EE_
X-MS-Office365-Filtering-Correlation-Id: a6584d98-b059-4e76-e971-08dc11c0da65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xKB+D5bnJfu5zihavYNhG6r/7m5O1TobVVNulUg6qUeUQSTIxZwyUBNm5gcYl7IvE71/+6mIS9vMKB389GvyijQ8R3bD0eZbIobJLtz2hk/ipK6UK2+bOr3NuTgPR+dXs/JDeoc+Bhs8IUiUuftpmR426j+dSEIMRO8MZhlMHK0MdT4aBx5575UBGSEGc64w1yIr/hZ/Xtx123aIKqgdCAifF4hW4LdAo5shFnHBnHKKGXtwCxxDfACaWO1fxWzcu9zihLyI58q1Iv8DxDYA5RgfUyUBqZWaKVG7NQDrHM3ayaoWM6Gf56+vKtbnhSZ7DE/ABYGMpCLKGqZFiY6WOFv+Np8QK//NygQ3IOCN3L1TQQzg5gi17XGgiNIccPfHloo04PlN0j9QkzP5QUmqy45cMFsaDTxoUwngislZx6i1aywofvZeOc2Hd5MBKq/qDMOLFjazeMdToc7Y9Q+PGLiqYbKE58MExTVhKKRRi/vCUlC/RkXR8JoTQZmXSw2KdzAvyMAMm7Ikt+S4SqOhQwRZ7b1jcTnGOKqsrVHYFLjgUosG5ES1Azq6FmGACkBRKYdUOsgJPWSxjbagMAkMwh/D5dlsN79FXKtm2SeUKDw/sBMrH0cdxf8qMcEDPFx4SL4IVp/W6MHczpH3+GxvYEJOU+kUAHlQfqIgT5Jw75tQERNOPUC2qRfqFNHmtk9frUktgQhv9l+92DwzcbRJIoRLlMKswYaiCPdfh6iECSarz/Bj/nItumLxooP2HENFmgZJiPqmMt0NwiNuQdqPOw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799012)(40470700004)(36840700001)(46966006)(478600001)(36860700001)(5660300002)(6666004)(86362001)(7696005)(2616005)(8676002)(316002)(8936002)(41300700001)(110136005)(54906003)(70206006)(70586007)(36756003)(47076005)(82740400003)(83380400001)(426003)(336012)(26005)(1076003)(81166007)(356005)(4326008)(40480700001)(2906002)(30864003)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 09:45:17.4804
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6584d98-b059-4e76-e971-08dc11c0da65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4127

Refactor amd SoundWire manager device node creation logic and implement generic
functions to have a common functionality for SoundWire manager platform device
creation, start and exit sequence for both legacy(NO DSP) and SOF stack for AMD
platforms. These functions will be invoked from legacy and SOF stack.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 drivers/soundwire/Makefile        |   2 +-
 drivers/soundwire/amd_init.c      | 147 ++++++++++++++++++++++++++++++
 drivers/soundwire/amd_init.h      |  13 +++
 drivers/soundwire/amd_manager.c   |  16 +---
 include/linux/soundwire/sdw_amd.h |  54 ++++++++++-
 5 files changed, 218 insertions(+), 14 deletions(-)
 create mode 100644 drivers/soundwire/amd_init.c
 create mode 100644 drivers/soundwire/amd_init.h

diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
index 657f5888a77b..e80a2c2cf3e7 100644
--- a/drivers/soundwire/Makefile
+++ b/drivers/soundwire/Makefile
@@ -20,7 +20,7 @@ soundwire-bus-y += irq.o
 endif
 
 #AMD driver
-soundwire-amd-y :=	amd_manager.o
+soundwire-amd-y := amd_init.o amd_manager.o
 obj-$(CONFIG_SOUNDWIRE_AMD) += soundwire-amd.o
 
 #Cadence Objs
diff --git a/drivers/soundwire/amd_init.c b/drivers/soundwire/amd_init.c
new file mode 100644
index 000000000000..d732ab0bfd59
--- /dev/null
+++ b/drivers/soundwire/amd_init.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/*
+ * SoundWire AMD Manager Initialize routines
+ *
+ * Initializes and creates SDW devices based on ACPI and Hardware values
+ *
+ * Copyright 2023 Advanced Micro Devices, Inc.
+ */
+
+#include <linux/acpi.h>
+#include <linux/export.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include "amd_init.h"
+
+static int sdw_amd_cleanup(struct sdw_amd_ctx *ctx)
+{
+	int i;
+
+	for (i = 0; i < ctx->count; i++) {
+		if (!(ctx->link_mask & BIT(i)))
+			continue;
+		platform_device_unregister(ctx->pdev[i]);
+	}
+
+	return 0;
+}
+
+static struct sdw_amd_ctx *sdw_amd_probe_controller(struct sdw_amd_res *res)
+{
+	struct sdw_amd_ctx *ctx;
+	struct acpi_device *adev;
+	struct resource *sdw_res;
+	struct acp_sdw_pdata sdw_pdata[2];
+	struct platform_device_info pdevinfo[2];
+	u32 link_mask;
+	int count, index;
+
+	if (!res)
+		return NULL;
+
+	adev = acpi_fetch_acpi_dev(res->handle);
+	if (!adev)
+		return NULL;
+
+	if (!res->count)
+		return NULL;
+
+	count = res->count;
+	dev_dbg(&adev->dev, "Creating %d SDW Link devices\n", count);
+
+	/*
+	 * we need to alloc/free memory manually and can't use devm:
+	 * this routine may be called from a workqueue, and not from
+	 * the parent .probe.
+	 * If devm_ was used, the memory might never be freed on errors.
+	 */
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return NULL;
+
+	ctx->count = count;
+	ctx->link_mask = res->link_mask;
+	sdw_res = kzalloc(sizeof(*sdw_res), GFP_KERNEL);
+	if (!sdw_res) {
+		kfree(ctx);
+		return NULL;
+	}
+	sdw_res->flags = IORESOURCE_MEM;
+	sdw_res->start = res->addr;
+	sdw_res->end = res->addr + res->reg_range;
+	memset(&pdevinfo, 0, sizeof(pdevinfo));
+	link_mask = ctx->link_mask;
+	for (index = 0; index < count; index++) {
+		if (!(link_mask & BIT(index)))
+			continue;
+
+		sdw_pdata[index].instance = index;
+		sdw_pdata[index].acp_sdw_lock = res->acp_lock;
+		pdevinfo[index].name = "amd_sdw_manager";
+		pdevinfo[index].id = index;
+		pdevinfo[index].parent = res->parent;
+		pdevinfo[index].num_res = 1;
+		pdevinfo[index].res = sdw_res;
+		pdevinfo[index].data = &sdw_pdata[index];
+		pdevinfo[index].size_data = sizeof(struct acp_sdw_pdata);
+		pdevinfo[index].fwnode = acpi_fwnode_handle(adev);
+		ctx->pdev[index] = platform_device_register_full(&pdevinfo[index]);
+		if (IS_ERR(ctx->pdev[index]))
+			goto err;
+	}
+	kfree(sdw_res);
+	return ctx;
+err:
+	while (index--) {
+		if (!(link_mask & BIT(index)))
+			continue;
+
+		platform_device_unregister(ctx->pdev[index]);
+	}
+
+	kfree(sdw_res);
+	kfree(ctx);
+	return NULL;
+}
+
+static int sdw_amd_startup(struct sdw_amd_ctx *ctx)
+{
+	struct amd_sdw_manager *amd_manager;
+	int i, ret;
+
+	/* Startup SDW Manager devices */
+	for (i = 0; i < ctx->count; i++) {
+		if (!(ctx->link_mask & BIT(i)))
+			continue;
+		amd_manager = dev_get_drvdata(&ctx->pdev[i]->dev);
+		ret = amd_sdw_manager_start(amd_manager);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+int sdw_amd_probe(struct sdw_amd_res *res, struct sdw_amd_ctx **sdw_ctx)
+{
+	*sdw_ctx = sdw_amd_probe_controller(res);
+	if (!*sdw_ctx)
+		return -ENODEV;
+
+	return sdw_amd_startup(*sdw_ctx);
+}
+EXPORT_SYMBOL_NS(sdw_amd_probe, SOUNDWIRE_AMD_INIT);
+
+void sdw_amd_exit(struct sdw_amd_ctx *ctx)
+{
+	sdw_amd_cleanup(ctx);
+	kfree(ctx->ids);
+	kfree(ctx);
+}
+EXPORT_SYMBOL_NS(sdw_amd_exit, SOUNDWIRE_AMD_INIT);
+
+MODULE_AUTHOR("Vijendar.Mukunda@amd.com");
+MODULE_DESCRIPTION("AMD SoundWire Init Library");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/soundwire/amd_init.h b/drivers/soundwire/amd_init.h
new file mode 100644
index 000000000000..f710703ffae9
--- /dev/null
+++ b/drivers/soundwire/amd_init.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/*
+ * Copyright (C) 2023 Advanced Micro Devices, Inc. All rights reserved.
+ */
+
+#ifndef __AMD_INIT_H
+#define __AMD_INIT_H
+
+#include <linux/soundwire/sdw_amd.h>
+
+int amd_sdw_manager_start(struct amd_sdw_manager *amd_manager);
+
+#endif
diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index afa2d83b7e69..0fcf8f8545b1 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -19,6 +19,7 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include "bus.h"
+#include "amd_init.h"
 #include "amd_manager.h"
 
 #define DRV_NAME "amd_sdw_manager"
@@ -864,10 +865,8 @@ static void amd_sdw_irq_thread(struct work_struct *work)
 	writel(0x00, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_0TO7);
 }
 
-static void amd_sdw_probe_work(struct work_struct *work)
+int amd_sdw_manager_start(struct amd_sdw_manager *amd_manager)
 {
-	struct amd_sdw_manager *amd_manager = container_of(work, struct amd_sdw_manager,
-							   probe_work);
 	struct sdw_master_prop *prop;
 	int ret;
 
@@ -876,11 +875,11 @@ static void amd_sdw_probe_work(struct work_struct *work)
 		amd_enable_sdw_pads(amd_manager);
 		ret = amd_init_sdw_manager(amd_manager);
 		if (ret)
-			return;
+			return ret;
 		amd_enable_sdw_interrupts(amd_manager);
 		ret = amd_enable_sdw_manager(amd_manager);
 		if (ret)
-			return;
+			return ret;
 		amd_sdw_set_frameshape(amd_manager);
 	}
 	/* Enable runtime PM */
@@ -889,6 +888,7 @@ static void amd_sdw_probe_work(struct work_struct *work)
 	pm_runtime_mark_last_busy(amd_manager->dev);
 	pm_runtime_set_active(amd_manager->dev);
 	pm_runtime_enable(amd_manager->dev);
+	return 0;
 }
 
 static int amd_sdw_manager_probe(struct platform_device *pdev)
@@ -964,11 +964,6 @@ static int amd_sdw_manager_probe(struct platform_device *pdev)
 	dev_set_drvdata(dev, amd_manager);
 	INIT_WORK(&amd_manager->amd_sdw_irq_thread, amd_sdw_irq_thread);
 	INIT_WORK(&amd_manager->amd_sdw_work, amd_sdw_update_slave_status_work);
-	INIT_WORK(&amd_manager->probe_work, amd_sdw_probe_work);
-	/*
-	 * Instead of having lengthy probe sequence, use deferred probe.
-	 */
-	schedule_work(&amd_manager->probe_work);
 	return 0;
 }
 
@@ -978,7 +973,6 @@ static void amd_sdw_manager_remove(struct platform_device *pdev)
 	int ret;
 
 	pm_runtime_disable(&pdev->dev);
-	cancel_work_sync(&amd_manager->probe_work);
 	amd_disable_sdw_interrupts(amd_manager);
 	sdw_bus_master_delete(&amd_manager->bus);
 	ret = amd_disable_sdw_manager(amd_manager);
diff --git a/include/linux/soundwire/sdw_amd.h b/include/linux/soundwire/sdw_amd.h
index 56b4117c087a..1e5ff4c46365 100644
--- a/include/linux/soundwire/sdw_amd.h
+++ b/include/linux/soundwire/sdw_amd.h
@@ -26,6 +26,7 @@
 #define AMD_SDW_POWER_OFF_MODE		2
 #define ACP_SDW0	0
 #define ACP_SDW1	1
+#define AMD_SDW_MAX_MANAGER_COUNT	2
 
 struct acp_sdw_pdata {
 	u16 instance;
@@ -63,7 +64,6 @@ struct sdw_amd_dai_runtime {
  * @reg_mask: register mask structure per manager instance
  * @amd_sdw_irq_thread: SoundWire manager irq workqueue
  * @amd_sdw_work: peripheral status work queue
- * @probe_work: SoundWire manager probe workqueue
  * @acp_sdw_lock: mutex to protect acp share register access
  * @status: peripheral devices status array
  * @num_din_ports: number of input ports
@@ -87,7 +87,6 @@ struct amd_sdw_manager {
 	struct sdw_manager_reg_mask *reg_mask;
 	struct work_struct amd_sdw_irq_thread;
 	struct work_struct amd_sdw_work;
-	struct work_struct probe_work;
 	/* mutex to protect acp common register access */
 	struct mutex *acp_sdw_lock;
 
@@ -120,5 +119,56 @@ struct sdw_amd_acpi_info {
 	u32 link_mask;
 };
 
+/**
+ * struct sdw_amd_ctx - context allocated by the controller
+ * driver probe
+ * @count: link count
+ * @num_slaves: total number of devices exposed across all enabled links
+ * @link_mask: bit-wise mask listing SoundWire links reported by the
+ * Controller
+ * @ids: array of slave_id, representing Slaves exposed across all enabled
+ * links
+ * @pdev: platform device structure
+ */
+struct sdw_amd_ctx {
+	int count;
+	int num_slaves;
+	u32 link_mask;
+	struct sdw_extended_slave_id *ids;
+	struct platform_device *pdev[AMD_SDW_MAX_MANAGER_COUNT];
+};
+
+/**
+ * struct sdw_amd_res - Soundwire AMD global resource structure,
+ * typically populated by the DSP driver/Legacy driver
+ *
+ * @addr: acp pci device resource start address
+ * @reg_range: ACP register range
+ * @link_mask: bit-wise mask listing links selected by the DSP driver/
+ * legacy driver
+ * @count: link count
+ * @mmio_base: mmio base of SoundWire registers
+ * @handle: ACPI parent handle
+ * @parent: parent device
+ * @dev: device implementing hwparams and free callbacks
+ * @acp_lock: mutex protecting acp common registers access
+ */
+struct sdw_amd_res {
+	u32 addr;
+	u32 reg_range;
+	u32 link_mask;
+	int count;
+	void __iomem *mmio_base;
+	acpi_handle handle;
+	struct device *parent;
+	struct device *dev;
+	/* use to protect acp common registers access */
+	struct mutex *acp_lock;
+};
+
+int sdw_amd_probe(struct sdw_amd_res *res, struct sdw_amd_ctx **ctx);
+
+void sdw_amd_exit(struct sdw_amd_ctx *ctx);
+
 int amd_sdw_scan_controller(struct sdw_amd_acpi_info *info);
 #endif
-- 
2.34.1


