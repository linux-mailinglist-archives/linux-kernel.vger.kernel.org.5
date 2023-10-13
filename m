Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4237C7D7C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 08:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjJMGJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 02:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjJMGJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 02:09:35 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15129CF
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 23:09:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQQLR6Ue6w7jBNpFG4s+Od6A45GB/yvQ6Avx8xPVmv11Eb3O4mTu5NtfCY/oxm4lcGHUZ3eWhwKUzUhNC5fBPynVH/leotFoMixB0P70PLKjMoZ6BjSEqYxiDePk/TIAhPsmVMVA12NbQwCWfI97HO4E+EUw1A3g68EWrfA9Tfqawgn0GZEzKdohMQ+dOyfBMShmLprU+KiAloPsf/haEGRg8VPuPm/xTxdmtK5VG49Sybs+k9EhaCSw+sj7w8MHLsXZR43YAIxfmiTDzfrtSHU31ThmuCVIB/WhDIQBUIHMdGTcNjIIWCWLiG2prnZlhTQBOFixVozxhWv0mSOd8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spbV+7FTpGZ/9IgAK4Axmw2Z9j6wq/fN+HUj5HQLVXE=;
 b=QyYXmARoUHkRb5c77Rsc1YFVA7unXkp+xbgOwj9f4T1Mrq5M/tOM/dHzn5oEETQEUbiXN2R4Z+ut45VsAxYyx/X7cg31DPnbidsHTY0X6eZ8Qb9eGo2I9JCk5YjYLVPy+qIqMn3vz8jQK8IQfBiqSWvTrid+WWPis8vzbKvf9U4l9GBjvFuiXHCW6uozJX+JU4Yjqc8qIE4cLZ5SHRWZoSaemxDC64AWl5rX9+PCiqTdXUCWJ6oqs6F48lPcI/LWv+FIgDc7mTC3KULvAfl4OEoPNl9riVFCu5+8qKa/z7cLvUpvoBTp3KGbnNVAxnGdfXZBwwb+5079zsNT5q55SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spbV+7FTpGZ/9IgAK4Axmw2Z9j6wq/fN+HUj5HQLVXE=;
 b=vGt5eTwglEu+JvIkaDrgxFmCscSVknSkxXlS+63nD+/1T4zn2rTK41ofILFW/XweRKjrZ1awPe6koAqp7Umi3oaAxDvVy0/YeJcV/S+UZzZiJ/QrfZTB2IflXlQPXXNjJSfz6i9ApXigz/+TfXEGSpXmCPMRhZDy4TDxEGJeL5Q=
Received: from CY8PR02CA0020.namprd02.prod.outlook.com (2603:10b6:930:4d::23)
 by DS7PR12MB6119.namprd12.prod.outlook.com (2603:10b6:8:99::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.45; Fri, 13 Oct 2023 06:09:28 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:930:4d:cafe::e5) by CY8PR02CA0020.outlook.office365.com
 (2603:10b6:930:4d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.29 via Frontend
 Transport; Fri, 13 Oct 2023 06:09:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 06:09:28 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 01:09:23 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 23:09:23 -0700
Received: from xhdipdslab59.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 13 Oct 2023 01:09:20 -0500
From:   Abhijit Gangurde <abhijit.gangurde@amd.com>
To:     <gregkh@linuxfoundation.org>, <masahiroy@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Nipun.Gupta@amd.com>, <nikhil.agarwal@amd.com>,
        <puneet.gupta@amd.com>, <git@amd.com>, <michal.simek@amd.com>,
        Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [PATCH v6 1/6] cdx: Remove cdx controller list from cdx bus system
Date:   Fri, 13 Oct 2023 11:38:45 +0530
Message-ID: <20231013060850.424929-2-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231013060850.424929-1-abhijit.gangurde@amd.com>
References: <20231013060850.424929-1-abhijit.gangurde@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|DS7PR12MB6119:EE_
X-MS-Office365-Filtering-Correlation-Id: 6308be7b-aa9d-4695-8705-08dbcbb2f56d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +w//W8J3QOZCeLJ/o5jSv0QyxVn8VUy5mFCx+4h0nWaij7L8gjVGikJk6pcgAratGo7MrbUBgvjnb/lrASjeuqlEQCnj/uOOnRnRTO+S/7I/BxMpn45idPu9vAPDeOAV5xVT7QhxuRBr0BUandIFVjnkzCtMaMqew76zEt/Q93jGt9EPuv0UkflxEesdCDUvbLxaqd2o6aic9aI68xmVviuJcPJCFyBV68AMzxlxpAoH93Ivlzlfc++aKgRoYiQbC1Gn8lK7LqOjJe6K/LhZFQT7JccYnvCSdW/5yIJY0K4+W4Z7cbllPKfJg+keIVqNaO7pLEvj4mDrpxj9UAUQu44QLoryqtQAb1UtE4uih2ytgZcijuA36HXGU/nIoS93wF4Ss1hnxF1PC+4P2Qq53BoU30dUPXJxiR0tFVWuh/N9ZNK91o1WBoaZdPtGKrgPcwCmUXE190CTWxzIcAS3vtW5egAcQJ5aLIBi84Gu5+N4Dea3hWpee4GssvdXwB6rPzqgfbEOfVdH2b5mup0sL0Uq3Os6QZwTMnWQWSecweJ4LRvZTyWg0xHRlE06a/dx/I+iA5JFVz24rE1StjYFWkS2vN18meMJBgpGCE/mlTlBzZrohpGbV5nM8NYEG1/HYaN5BnkwB2344FzJmJSxdG7rPyoelTeG/WzKI5wgnYQwpkzEfbPnLo0/teiOjZ7g/bwOjO2Ze4GLSaXLagwYirA/KVXh5a7O7BjRWoqNLkq9wE3xuceCrEJq00Pvv4oCFSaDv/mVMSg/0FeNVcS/uw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(82310400011)(36840700001)(46966006)(40470700004)(26005)(426003)(336012)(82740400003)(44832011)(40480700001)(36756003)(316002)(83380400001)(70206006)(54906003)(70586007)(110136005)(86362001)(81166007)(1076003)(356005)(2616005)(47076005)(36860700001)(40460700003)(478600001)(2906002)(6666004)(5660300002)(8676002)(8936002)(4326008)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 06:09:28.4176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6308be7b-aa9d-4695-8705-08dbcbb2f56d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6119
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove xarray list of cdx controller. Instead, use platform bus
to locate the cdx controller using compat string used by cdx
controller platform driver.
Also, use ida to allocate a unique id for the controller.

Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 Changes in v6:
 - Added conditional check before scan()

 Changes in v5:
 - None

 Changes in v4:
 - Make cdx_controller_ida as static

 Changes in v3:
 - New patch in the series
 - Remove xarray list and use platform bus
 - Use ida to get unique id for controller

 drivers/cdx/cdx.c           | 42 ++++++++++++++++++++++++-------------
 include/linux/cdx/cdx_bus.h |  2 ++
 2 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index d2cad4c670a0..0252fc92433d 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -60,7 +60,7 @@
 #include <linux/of_device.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
-#include <linux/xarray.h>
+#include <linux/idr.h>
 #include <linux/cdx/cdx_bus.h>
 #include <linux/iommu.h>
 #include <linux/dma-map-ops.h>
@@ -70,8 +70,10 @@
 #define CDX_DEFAULT_DMA_MASK	(~0ULL)
 #define MAX_CDX_CONTROLLERS 16
 
-/* CDX controllers registered with the CDX bus */
-static DEFINE_XARRAY_ALLOC(cdx_controllers);
+/* IDA for CDX controllers registered with the CDX bus */
+static DEFINE_IDA(cdx_controller_ida);
+
+static char *compat_node_name = "xlnx,versal-net-cdx";
 
 /**
  * cdx_dev_reset - Reset a CDX device
@@ -384,7 +386,8 @@ static ssize_t rescan_store(const struct bus_type *bus,
 			    const char *buf, size_t count)
 {
 	struct cdx_controller *cdx;
-	unsigned long index;
+	struct platform_device *pd;
+	struct device_node *np;
 	bool val;
 
 	if (kstrtobool(buf, &val) < 0)
@@ -397,12 +400,19 @@ static ssize_t rescan_store(const struct bus_type *bus,
 	cdx_unregister_devices(&cdx_bus_type);
 
 	/* Rescan all the devices */
-	xa_for_each(&cdx_controllers, index, cdx) {
-		int ret;
+	for_each_compatible_node(np, NULL, compat_node_name) {
+		if (!np)
+			return -EINVAL;
 
-		ret = cdx->ops->scan(cdx);
-		if (ret)
-			dev_err(cdx->dev, "cdx bus scanning failed\n");
+		pd = of_find_device_by_node(np);
+		if (!pd)
+			return -EINVAL;
+
+		cdx = platform_get_drvdata(pd);
+		if (cdx && cdx->controller_registered && cdx->ops->scan)
+			cdx->ops->scan(cdx);
+
+		put_device(&pd->dev);
 	}
 
 	return count;
@@ -520,17 +530,20 @@ int cdx_register_controller(struct cdx_controller *cdx)
 {
 	int ret;
 
-	ret = xa_alloc(&cdx_controllers, &cdx->id, cdx,
-		       XA_LIMIT(0, MAX_CDX_CONTROLLERS - 1), GFP_KERNEL);
-	if (ret) {
+	ret = ida_alloc_range(&cdx_controller_ida, 0,  MAX_CDX_CONTROLLERS - 1, GFP_KERNEL);
+	if (ret < 0) {
 		dev_err(cdx->dev,
 			"No free index available. Maximum controllers already registered\n");
 		cdx->id = (u8)MAX_CDX_CONTROLLERS;
 		return ret;
 	}
 
+	cdx->id = ret;
+
 	/* Scan all the devices */
-	cdx->ops->scan(cdx);
+	if (cdx->ops->scan)
+		cdx->ops->scan(cdx);
+	cdx->controller_registered = true;
 
 	return 0;
 }
@@ -541,8 +554,9 @@ void cdx_unregister_controller(struct cdx_controller *cdx)
 	if (cdx->id >= MAX_CDX_CONTROLLERS)
 		return;
 
+	cdx->controller_registered = false;
 	device_for_each_child(cdx->dev, NULL, cdx_unregister_device);
-	xa_erase(&cdx_controllers, cdx->id);
+	ida_free(&cdx_controller_ida, cdx->id);
 }
 EXPORT_SYMBOL_GPL(cdx_unregister_controller);
 
diff --git a/include/linux/cdx/cdx_bus.h b/include/linux/cdx/cdx_bus.h
index bead71b7bc73..82c27b8c94e1 100644
--- a/include/linux/cdx/cdx_bus.h
+++ b/include/linux/cdx/cdx_bus.h
@@ -63,12 +63,14 @@ struct cdx_ops {
  * @dev: Linux device associated with the CDX controller.
  * @priv: private data
  * @id: Controller ID
+ * @controller_registered: controller registered with bus
  * @ops: CDX controller ops
  */
 struct cdx_controller {
 	struct device *dev;
 	void *priv;
 	u32 id;
+	bool controller_registered;
 	struct cdx_ops *ops;
 };
 
-- 
2.34.1

