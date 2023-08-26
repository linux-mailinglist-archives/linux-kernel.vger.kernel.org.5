Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B683A7893E7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 06:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjHZEwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 00:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjHZEwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 00:52:03 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7826E2137
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 21:51:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VzxDSdN+0prcsJ3g0Xf62DlFaP8v8RSLAE/OGeegwH93wWzWi5xzSkhYnV9ImnDGdQvV67QpdUXbDSJb6P55H7xp5zvUPEkiylqSHDsz4N1p5EuzisN542JRhFQQrRYAP+qK7ypEy/9IFaelOqLvqYrW2EBq0uCN+RrA2DNtGmZu74TKGDsWtUxRjvQ612sBExTpVr43gixl9c15aqfor2JYIPghZ09ahDg41oxyAwA3CFkfZJkBDLGUkTFAaJjG9VeORC9bUeGt7ESbK3EdLo4obpAQ2bLezrp360fR7n/xwmVtMNVtXSw8PJzITyaJKw1WhkUMBzSY+z4z74fCVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f88kgwzT4HIkL9puzbph1MsoBva+epZs24z6mKop6BE=;
 b=Z00G9IgMmRcpGzMSs64vVBq0rTwSmpmipfXWj+kX2cu948LdJWC2KoxWTR1GXHEnNwv3BNPbddSj6Ej5HI0a6lEhwR6sT/ft/FUo3lxP0dzEnhaJQU9sea1AUXwLYWa9OExt7s6uPf8T1diIXLhv9CqXoRNhqNm5MYVVOQWSHg+r5BsGcCazvRwuC++0rIgcK33zwX3BQXoWY2s1d1CoIjF9AQi4AAavBdzaaNE5exLrZwaY3OyQ1Juf0abGnL2U61dGNPGTgnKXzz0digWM0PVMsRC649vklDA0gjayAJGtahUvF5gcQRkssFnf3FOMLC0NVJubvp4wXf0gvjuSmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f88kgwzT4HIkL9puzbph1MsoBva+epZs24z6mKop6BE=;
 b=PvYjvxDWgWXIQc0DYLTiAiYl0cT+Rtd39vphvb22cEQ95XQ4oCD13RZNVf443eR+gdhsdsMS2KAn/Xixe8XRvrwro5SlRvzpjQTU4GOvnRV0+hnyoKX50zJ0+4gfG0fEOqQggcK+aonxnsnBnAy9cM7zwolsBL+khe7ucVK5jDY=
Received: from CY8PR02CA0013.namprd02.prod.outlook.com (2603:10b6:930:4d::24)
 by PH7PR12MB7113.namprd12.prod.outlook.com (2603:10b6:510:1ec::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Sat, 26 Aug
 2023 04:51:54 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:930:4d:cafe::ed) by CY8PR02CA0013.outlook.office365.com
 (2603:10b6:930:4d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34 via Frontend
 Transport; Sat, 26 Aug 2023 04:51:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Sat, 26 Aug 2023 04:51:53 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 23:51:52 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 23:51:49 -0500
Received: from xhdipdslab59.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 25 Aug 2023 23:51:46 -0500
From:   Abhijit Gangurde <abhijit.gangurde@amd.com>
To:     <gregkh@linuxfoundation.org>, <masahiroy@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Nipun.Gupta@amd.com>, <nikhil.agarwal@amd.com>,
        <puneet.gupta@amd.com>, <git@amd.com>, <michal.simek@amd.com>,
        Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [PATCH v4 1/5] cdx: Remove cdx controller list from cdx bus system
Date:   Sat, 26 Aug 2023 10:19:40 +0530
Message-ID: <20230826044944.4161017-2-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230826044944.4161017-1-abhijit.gangurde@amd.com>
References: <20230826044944.4161017-1-abhijit.gangurde@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|PH7PR12MB7113:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a72cac0-3c50-4424-931f-08dba5f02aff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Lx0cwkQZQCkBK1mRILLuMdC1pKwkXu+OKU8zMb6lwm5mAzEUUpq5w01KrgsyNpDD3vKdjEjcKSbXJkeBidEscZJ7iF1WY24U+f3hmB4loEDTHmqm3ehj09OdzkBWRETVUVe4Nz7DLodbpBkImy4xK3MHG7dAtcvWDLU7LeKJ0mYbvkXyGKj0TMYgg+fBzFpc0orMFFdnZ2h4gqvjQoE7gI/Oitb/5YdX8kXlwPhmALz5B3F3qMJ8ZflqWvo+1QKh1gPHmpN9GZZKtmVYrVHW1EM7IW5sSQgMV7fjpN/sr+hjZxb6jBXbpqMnsqkHlmxjBUipRyM4RVRf6ja0Ek3tjdLUAI9iaPEwB+sGxvQD0AAg967Z+QPHsRkqv2ZTorKCaRbCbpfHxeiJxV8cvAVWVHDvIBS9h3dSOJJx9vgE6fNE2N/Un90TUKh7XEBo53d8EaZ7PPnDxJbbYAPMcUGWc+MkMPa8QApiab5tzc5LNMoQy3Tg0NYrTdPVlG0yWL7tccKpHKOgZR7jCoxjaIG63vdDDxkdzmQOw9mLQcLe1vSLTPyE+Zs0h2Ox1htuw/EXLdkVP4HocjFkAJHBlGwqOvGFfeMg+Z7CW+hCpLtFjFq6tOQjG3mmnqSfIQcm4TiR6NMjUHFPed7LR0xxtuIq633CpuH+UgA4ACGAVLWryxFJTH28vS8Vv0s0y1DmB61nngx3SBDQKC9liO4KHqGqzg27qGHRvVk7Pj4feSvWWfk5JluhdXWPrbQP9F0CgMXuLkWjG7PDEG99nRva+5+dA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(136003)(396003)(82310400011)(186009)(1800799009)(451199024)(36840700001)(46966006)(40470700004)(40460700003)(2616005)(1076003)(5660300002)(8676002)(4326008)(8936002)(47076005)(426003)(36756003)(83380400001)(336012)(44832011)(36860700001)(26005)(40480700001)(82740400003)(6666004)(356005)(81166007)(70206006)(54906003)(70586007)(316002)(110136005)(478600001)(41300700001)(2906002)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2023 04:51:53.4246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a72cac0-3c50-4424-931f-08dba5f02aff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7113
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
 Changes in v4:
 - Make cdx_controller_ida as static

 Changes in v3:
 - New patch in the series
 - Remove xarray list and use platform bus
 - Use ida to get unique id for controller

 drivers/cdx/cdx.c           | 39 ++++++++++++++++++++++++-------------
 include/linux/cdx/cdx_bus.h |  2 ++
 2 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index d2cad4c670a0..600482694161 100644
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
@@ -520,17 +530,19 @@ int cdx_register_controller(struct cdx_controller *cdx)
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
 	cdx->ops->scan(cdx);
+	cdx->controller_registered = true;
 
 	return 0;
 }
@@ -541,8 +553,9 @@ void cdx_unregister_controller(struct cdx_controller *cdx)
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
2.25.1

