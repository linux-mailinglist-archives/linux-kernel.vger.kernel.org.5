Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2A87AAF52
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 12:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbjIVKT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 06:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjIVKT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 06:19:26 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFCA197
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 03:19:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mAtIqGs04Wcrq6BjbHIlzkZOMx+gxSs1kTxh71NeiBSKPBiR/1dHf4DTC9k0oC/X0uf2W0YQuE9TS6YguxapbUbbycJ1kd0biactlgweISoELLzm8zL4xmhcTB4q15x2zJIdou9yNZ/Jw2k0Dsux2iary9MhUrSp0PBxwR0W0NTe0mO9Xz6DWMzXiCs5TrZQL0ChnidwzDWCyTa6Anu/kfgE7u1Yh/hfjssxNNhGsoX+dEFRX7J+tcAGUXgCHOChoa0qf/ZiXpBjpourPVoOreq5aygTKsKE3kaW9m7G2wY5WtFm7K8hdOAdumLh3R2TfEQY/YiQP7alx+B7C2eEKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQPgYZttx18Ab09nriY4pUCqwoIkpLh/VVTksvePzbA=;
 b=f3PZHqhs/4PB5NueySaII8xvO1EmQcKGyKXi6ZT555WDhn/3gOedZdm3w2LGasOg3jAOLiokGqii4PcsCPed0NjWGylqy8H21Lg4+UYe0WPwNSMgyqEqIDjE5qUeNtKQOQQ6PG6gwImxdagVkvvd73YqRN2RDdXQg8FSdHx18kpsE+PBeFqyRZyg05HG0aHQ2POtEwCfSP2LxY+/xHxVs0PEln6onroqlmChPau4oIR+rcfNtV5cF5BqQHECBlFMa6Og+jBlQ01JK5MUzWSqQH2cBBoEVikTxfGYNzR/yith1bFtBUFFPqpRT2H1ZCdzozwj2BAF8BwYEZRtSEXVaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQPgYZttx18Ab09nriY4pUCqwoIkpLh/VVTksvePzbA=;
 b=2yeA6oJiatyCGLr5ZfKnU1R+QGg2UoTZIHxzjdua0/Mjhx+tjPU3wPIHZLBD9sc+RAiLLkneRMB6kIHul0z3PbREMsyiOeWciNrBR/af3o5J8FUJkZxlrkCft57aERqwjVdOUGkHOVbFI7fYyBNIggtFjX60xboUo4nHWI6iRqI=
Received: from DS7PR03CA0076.namprd03.prod.outlook.com (2603:10b6:5:3bb::21)
 by DS0PR12MB6440.namprd12.prod.outlook.com (2603:10b6:8:c8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 22 Sep
 2023 10:19:17 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:3bb:cafe::d8) by DS7PR03CA0076.outlook.office365.com
 (2603:10b6:5:3bb::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.31 via Frontend
 Transport; Fri, 22 Sep 2023 10:19:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 22 Sep 2023 10:19:17 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Sep
 2023 05:19:16 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Sep
 2023 03:19:16 -0700
Received: from xhdipdslab59.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 22 Sep 2023 05:19:13 -0500
From:   Abhijit Gangurde <abhijit.gangurde@amd.com>
To:     <gregkh@linuxfoundation.org>, <masahiroy@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Nipun.Gupta@amd.com>, <nikhil.agarwal@amd.com>,
        <puneet.gupta@amd.com>, <git@amd.com>, <michal.simek@amd.com>,
        Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [PATCH v5 1/5] cdx: Remove cdx controller list from cdx bus system
Date:   Fri, 22 Sep 2023 15:48:24 +0530
Message-ID: <20230922101828.33456-2-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230922101828.33456-1-abhijit.gangurde@amd.com>
References: <20230922101828.33456-1-abhijit.gangurde@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|DS0PR12MB6440:EE_
X-MS-Office365-Filtering-Correlation-Id: d88d40c6-1c15-43f7-5145-08dbbb5560b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zP/HJVkKgyly2cKYNnFF7dQNYsavVtLD2pZjDhbiIEPWdiD7I8slbeQkCe1khIeQxRv3djC2LEkGJ+iPeLfVgwZ7IHhxyy1TOUF3Uazkz0UVfSbke5kZ8UVAp39Ihqt0TVWGFwJdvls6u9ybHQg7kHyZe30JYo/c8PGOKF7YQbtWWrgSxSqqJMFeU9ZCYFHcx/mHUNDnyITLqm7O5OhMa+7E/F3/VkUhndypzqeCjSsn8VD4TpefrnwjsslIkPE88e77CkVcYipOu01kjiowzTxQBnAH9XrWhv0xZq+3pjzruL+gT7ZrbCBVC9ORzFKsva9rtERgWXQbS9rj4FsKnea000XRt+k9/qRilJ0Umo6MzuDE88MhxT6jN/Vij43WnlXD4JptFYYvkiM4IV+FRTgMYs7ayD8wCsBkQmH6Lo9SDt5fqLOys3drwb+V7N59kp0aeWwJm10r6qc7+dUBUzoCQxY+Vx6tcmMU6G9GOhwQYnMiXYyO/cYwflXfNQLugm6FplLSHEZKlyraTzlFzjWEhLanHUviJs3uzYuFDxJbe3bAAZoi2Y1EgBswq6+ji5SGpOJC7U38WvcAqBn9IaWg7lJ02BnZvniAgtfM6H+18yTGW21Z0JappTkny+zUlXLIAewI8TfYohVCJ9cCR1KV+33ULsLsFnnw0NzLFx55zkQAA17BN9WntwESEDZrOsTzNMTtRBtSWGT8dL5ZxrskAqCz22X925pT/9ivantFRxAApXCP+uGJhxI7ACqtIQn2G6i7TIU8KkX1lfBd91WyMDps+cftqtMMpQmtCcgIceitt/71m8vqbhGiYuTp
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(376002)(396003)(186009)(1800799009)(82310400011)(451199024)(230921699003)(36840700001)(46966006)(40470700004)(82740400003)(81166007)(356005)(86362001)(36756003)(40480700001)(40460700003)(478600001)(2906002)(6666004)(54906003)(110136005)(70586007)(70206006)(2616005)(8676002)(8936002)(4326008)(44832011)(5660300002)(316002)(41300700001)(47076005)(83380400001)(36860700001)(26005)(1076003)(426003)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 10:19:17.1647
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d88d40c6-1c15-43f7-5145-08dbbb5560b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6440
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
 Changes in v5:
 - None

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

