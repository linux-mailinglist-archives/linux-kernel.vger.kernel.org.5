Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6A177B691
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 12:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbjHNKXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 06:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbjHNKXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:23:05 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53555EA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 03:23:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUVT+r2s6cHesDyUp5yPFhm2X36cpQUh57PNIZxc39XjNNRVbEzTZ003BEGE3aCzMUWeXIKZfd9BEFeE6U5DMt7tcOjt0P7PL2GRfPdJ89rE1a/KsS6URuZNNS6OVzyJzcNq32Vz+EQkSsufMHRjq3Xsf8OcZSjwSEFLovBswzTlfFL9RS6VDTsJBg25y/hNYtyomFSLCoaCUx/L9USTcnO8GiJcaXWNLipiS0WkILSBsEPokVogG9uoGzMHQ9gOBcCrm3tvOdzWNo7d+HmbIOoJ4H5sAJXU6xWaRHKtzIq4zk5m2uWQdxsay/atlEDC0xfeNGO4ZTFMDxT6PpQTSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=koYiG5b+GWQDB0dH/1k77y56afMIb3pFYQZuH3sjXss=;
 b=VU6fsb2h1KU1HM0ZaomiHGPxtyQBr7lmmzTUy9iBvnZz4WV9psst44BLQVMgW3Aw0U1TDoVkRrI4s7qqkm6t8Qu7RBHue4NhyP/LhQpROJCp1hkoESNn/sSMBtkS+Jf4c4PjavzYILfFvOpez4j7fuIFkJ047Y9v2AAUI7Ti4utEy8shk08yj75mlGsCtiyKUz28DllYicWixX/3Fv58O2hc9uGySV4w9qCAwlzc+DdxHZ3uZ0tR679qr6DPPXraQdw+mwZG2RqrMdAFixl/dhiiUoj4MNOwz+VY7iMFckMxSTLsx37HONpQKUzGs5jNHRXBgqUDepl8xXpIis4PdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=koYiG5b+GWQDB0dH/1k77y56afMIb3pFYQZuH3sjXss=;
 b=pT/+VWNL9vjkFhQnvtKBvHFLSttjZ2/EKGurG5u49ulMwkI6E0kvLRE4aGSPcib9ZneEomwSdwtEzTjmV8vb/m/JgbQviTrsuViBcOkQbDXDWMBon2IxjdBs6fhfLal1OcGVnwa6wkNLQhTH46WZTxjz0E7YV9JIom1/MKbJAOQ=
Received: from CH0PR13CA0041.namprd13.prod.outlook.com (2603:10b6:610:b2::16)
 by BY5PR12MB5015.namprd12.prod.outlook.com (2603:10b6:a03:1db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 10:22:59 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:610:b2:cafe::6b) by CH0PR13CA0041.outlook.office365.com
 (2603:10b6:610:b2::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.13 via Frontend
 Transport; Mon, 14 Aug 2023 10:22:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.12 via Frontend Transport; Mon, 14 Aug 2023 10:22:59 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 14 Aug
 2023 05:22:57 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 14 Aug
 2023 05:22:56 -0500
Received: from xhdipdslab59.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 14 Aug 2023 05:22:53 -0500
From:   Abhijit Gangurde <abhijit.gangurde@amd.com>
To:     <gregkh@linuxfoundation.org>, <masahiroy@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Nipun.Gupta@amd.com>, <nikhil.agarwal@amd.com>,
        <puneet.gupta@amd.com>, <git@amd.com>, <michal.simek@amd.com>,
        Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [PATCH v3 1/5] cdx: Remove cdx controller list from cdx bus system
Date:   Mon, 14 Aug 2023 15:52:19 +0530
Message-ID: <20230814102223.418046-2-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230814102223.418046-1-abhijit.gangurde@amd.com>
References: <20230814102223.418046-1-abhijit.gangurde@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|BY5PR12MB5015:EE_
X-MS-Office365-Filtering-Correlation-Id: d39b34b5-ad93-4779-373d-08db9cb06ef1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WRbRc4gADKfdBH0epXiI0VlrZ7P+cRMW67cnUDC9+AEzOIJwgnFff/oG8CuKRC+z5qP7lAfafywqNbJ4povOZfCAagW7cCloZ+bJtSWG4ZU8eqyIXbUWA4TmOXSQcnQzkbNSBcPgVrnl4NCb9G+/vxy/GCG9N2nGs2QW+cFTVuJx3Og+zg6iResjuIvBei33JeKkRADqyh5cDJXtk+tHoSdBhIgDO/r2h7ldJ43v/FB/6+C/HbhBv41y0Os8UGiHJxzUGBD5xEVWXRz52gG1y9UKmf7l6c9xWZ0V7rBUqn0OwB42fbRRyadc3gSPBzQ8vFUNeWJSa8VKB0Zea4z04Maf0BWwxlp066RSwL8l1qcu0NDvvo5aMm+UoHjfhbimHtHO+NGDMPf50Rxh4AzE5KdArKkiCUhkyeCmiJWe4Ber83j3Fm42jY4uKr9MOo3+RVS80H7rB8+FiwDMjfKkLIeylVx9ggRSr7+iVD1lW6Naw50VLw2X+jh3M1H03pNyEAi2E/J8rjMD0/IOck4EZNoXl85nzu6E6c37RFNi9kt2TTGpP07ePkRswM75ZCynw2QCaiXyCH1bZ85K/xuxchMJiDAZZhlnOHnUjDx/LVuxax+/2dnGwTwvwfBOoLhM6HcuvFnGXVwRuZKMMXRS21IA2/FLa6PZpjdd1EE9NreV9VhR3NFan5dBLQhg6zOCQhBnWqaFRpYga4Kiq720us4KBHMDscs77W4eGm+RBX94ISJ6GS0rIwwK+ocGqGM/wJol56ehwcQTb3fKk1dDXg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(346002)(82310400008)(451199021)(1800799006)(186006)(46966006)(40470700004)(36840700001)(40480700001)(54906003)(110136005)(6666004)(40460700003)(478600001)(81166007)(356005)(82740400003)(5660300002)(2906002)(36756003)(86362001)(44832011)(4326008)(70586007)(70206006)(41300700001)(336012)(8936002)(316002)(8676002)(1076003)(26005)(36860700001)(83380400001)(426003)(47076005)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 10:22:59.1442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d39b34b5-ad93-4779-373d-08db9cb06ef1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5015
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove xarray list of cdx controller. Instead, use platform bus
to locate the cdx controller using compat string used by cdx
controller platform driver.

Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 drivers/cdx/cdx.c           | 39 ++++++++++++++++++++++++-------------
 include/linux/cdx/cdx_bus.h |  2 ++
 2 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index d2cad4c670a0..1c0f76cf4f15 100644
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
+DEFINE_IDA(cdx_controller_ida);
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

