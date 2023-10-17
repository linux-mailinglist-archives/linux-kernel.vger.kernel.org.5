Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D397CC857
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbjJQQGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 12:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344080AbjJQQGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:06:01 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0409FF7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:05:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHNv+suG1T7ZQaHZ3nPVrcldL/jNlN3TBqytETgqfCfLeV00MDvVxXIRFcZFWsNW2KDOM5tPn3jHaljswbXbUsUQ+lN6yvbCHIXKZ2EEa3UoOk6DdmwESA+npZ4KmMtPL8ql5SA26GsKzRq0mKaZUZKL5kkMC72Uv8yt1SwwUxw/pKsVsjwT32siXD81mlFw/E1SFAELaPV+lNRdppz8U2kP1I8xuEEosVwRSdfiLek8z4hex2xKBTwTq+ZQTyPBAlFv3YaPnWGKscepX7DxBl/68iAr3NPJAkajFXrMXVnF3yJqordmaapsoE3hnaAbe7k3CtZHcBq2bLlV5nEd1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEgv4gZmpXCMNDhXuFtAzUI3/joFFTZ1DY/yehSw6kM=;
 b=iSMiQrcV+h0Uj4XAzycrmPFNi1IymOoUA5nZuP1krWfzyI0FRkWhGgIO58pTrg+BsoiIAZDtje1prhjUg5iHBCuoDRL39BZwVjGhsA7TVpoDTSQJabxymIxpPiHpQCDwGOkm101ttdO7JKu96rYX7/4oIUP+lhJs6UbCiT92/Dbtt2DZl6gqe+lqfa1mJ+rnWUz/5gRVz1qOYBt3PCRRE9XZsYID0cqEpwD/bDwn4f8VEC5YxjCx6B2LWjw2xQWJ1Hvm6yRWJybvHFTTgdulJXY7/JKY32q4C/ilsnmB9GXgVwWQgDz4MIO6DscrKXJCVi4/ED+IqjOrUeFSWCvSmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEgv4gZmpXCMNDhXuFtAzUI3/joFFTZ1DY/yehSw6kM=;
 b=DL4qCh8ytXuUWRSRpd82t+D3xo0OCw+lR6QxC05J/TdnxDWnsExWbOQabvBEEix10pZ0QUH5ZZDoTlddQSCOFxqHRA05Hyam0vzH1vs/XC67X/VXG+CSlYzq0j8+wmVfZfXl6M0pzRGILnWH97vmBZ2sFisHxOxnPNr3BPBGSyI=
Received: from CY5PR22CA0085.namprd22.prod.outlook.com (2603:10b6:930:65::10)
 by DS0PR12MB9275.namprd12.prod.outlook.com (2603:10b6:8:1be::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 16:05:56 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:930:65:cafe::a1) by CY5PR22CA0085.outlook.office365.com
 (2603:10b6:930:65::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Tue, 17 Oct 2023 16:05:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 16:05:56 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 17 Oct
 2023 11:05:50 -0500
Received: from xhdipdslab59.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 17 Oct 2023 11:05:47 -0500
From:   Abhijit Gangurde <abhijit.gangurde@amd.com>
To:     <gregkh@linuxfoundation.org>, <masahiroy@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <puneet.gupta@amd.com>, <Nipun.Gupta@amd.com>,
        <nikhil.agarwal@amd.com>, <michal.simek@amd.com>, <git@amd.com>,
        Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [PATCH v7 1/7] cdx: Remove cdx controller list from cdx bus system
Date:   Tue, 17 Oct 2023 21:34:59 +0530
Message-ID: <20231017160505.10640-2-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231017160505.10640-1-abhijit.gangurde@amd.com>
References: <20231017160505.10640-1-abhijit.gangurde@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|DS0PR12MB9275:EE_
X-MS-Office365-Filtering-Correlation-Id: 8255ee3f-51fd-4595-2718-08dbcf2af24e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g8AN7673jBeLFmbRDnIhXa7PkDKLZ5BLJTXq9lk/G8rBp+tH9yX8w4hLSSQqJSq883S70owWd9n5GyVgWRDIpvkR66m/tJe+GjbzBomz68SNol7x+WNHcUorvikdhFT4dU7VA96IrEEPoruaB1f2j6bhLEHzE15RLV+cejF34MkLUZYktEXQbKK0t6tRt2UjMmB8hgb8yJZ+sYqF84tQhOtDVlNQ7yB/tmPF4iCcYdE7iNPPJ+LstYXqVCgpsE0xBMgjgq5TYAsNrv7RKqcmBz5nG5LQUZlV/UWm19KZljiDp4uQikGF176hOe6RRJpg+Eqo72vF0W09xWUlvX7jgQFSa6F0/N47i+fvi0yJDAWUJvTBteY6ZFzq6virSXx2ftFFZ894fb6g213d7ypntf7uz7lINWU1/3PMQZ1zqETlPUfOdMmcRDUjx6CGe4AcML7F/mQIaFwkx1/ReI6VapjFvlG6JOo9/QafEwcCarT2nm/2w+UeKyDj1jRtesnhXru/j65mG+32BMf6ZClw8wIXJnKRnoEM15xA4WqsNQ8LlSJIO2R4oGcbbKJei+6SapKs2mCoFcr7JPKdwMxq8s4NUzM4zmKeseemKJgqZCTVeEQGyTEbbbCcmIvL158Kha68vxeLlncA2GL732dYk+Fg1d4uLwU25I3MBicmVyElZ+ht79JAITIOwW/rENSJmddZt8OWyacR+FtO1u0ey6GQBrYsYqpGh7+ILkUa3G06pEi4sIPgfkgExto0rq/gyA0RvQPyg4FD6/S6Y/aQZw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(1076003)(478600001)(316002)(110136005)(41300700001)(8676002)(8936002)(4326008)(70206006)(70586007)(54906003)(44832011)(5660300002)(40480700001)(82740400003)(36860700001)(81166007)(356005)(47076005)(86362001)(426003)(36756003)(336012)(26005)(83380400001)(2906002)(40460700003)(6666004)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 16:05:56.2747
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8255ee3f-51fd-4595-2718-08dbcf2af24e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9275
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
 Changes in v7:
 - None

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

