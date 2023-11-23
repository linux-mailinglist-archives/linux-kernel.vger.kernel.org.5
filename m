Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33F57F5773
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 05:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344631AbjKWEjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 23:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbjKWEjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 23:39:41 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6D319E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 20:39:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5E4W6v6i+39UBrzIR3V8gxDqRvtCCqoBrRqU3iFI4Bw3zmSD0vny1xIGpGF5aGWHMlHRPehEOcIZVbNrNKtbUqg63YSsZhhZD+Hk5JBN+oyA/YUTobAmUJ8VI4cO+BdtsjzAnL0gdWSXrqt73mvjco3/QCiJ/Rqufb3Vu4S3dRHPZZdicyZAY4oExtD93hSb2Wbhs7UMUI5Sw9xif449+UpKQhdhc1HuKpu8pX1iwcgEbSazkLCMU9LRtRhdQDB2m71jPcE3TiH4U0HckeUvPkU4X5I5ljcPcPH94Why1vsB1cknpO5aqAihmZRgZ51RlGNjUPxJTmzoj8UlpETCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8grwBmeLTG9VS7JldtouHOQ6c1K5q/dlpvp1qpXJHQE=;
 b=k0KO3lhvluziCwgzeSDl0OcEamOQkoyf7mPuwwR+Xn55d9dRjjX6XcKUObpw3Tjf5YXuW+xYmjhhdH+EHoWu8zQwhejktzzSxCeTCUPcl9j0N/M9K0CDXTT/gG6PuI0DA3UciHAY1jzJwYmNVjqPLg01i0AVKEB6Lhmh70Ll9NZwo7rcs8BO0lkLQ5vrHaw4SMN3RNQbSy/Hc8WEUM07WhX38o4j6N4OXabBUmaTylphRi4M5LbtPXjAAt4OnPkNF7F/o3CInntyAIHApym4aibOot+gNKP2uNkaYK/+AcV5YUXSbCR4ZCF2ZVe8lM2b7hSTZ7mqFxA/CVC85n9nTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8grwBmeLTG9VS7JldtouHOQ6c1K5q/dlpvp1qpXJHQE=;
 b=A9YftO/fU3Nb6SEFJyZg+vrLz4GDGkSzLxWcwOxInhQnq29gOfoAB2TDoPGcT6uuVaTngc4nGu78nNSXeE/4B0+64ulXrl7DMaOWVpOhxAipRenG4LRbVFGW9jhgctthf7sZxxCLlIBPbrJN+VYV2oNamSAiKliNL+3frTyFqbg=
Received: from SJ0PR13CA0202.namprd13.prod.outlook.com (2603:10b6:a03:2c3::27)
 by SN7PR12MB7788.namprd12.prod.outlook.com (2603:10b6:806:345::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Thu, 23 Nov
 2023 04:39:40 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::17) by SJ0PR13CA0202.outlook.office365.com
 (2603:10b6:a03:2c3::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16 via Frontend
 Transport; Thu, 23 Nov 2023 04:39:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Thu, 23 Nov 2023 04:39:39 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 22 Nov
 2023 22:39:38 -0600
Received: from xhdipdslab61.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 22 Nov 2023 22:39:36 -0600
From:   Abhijit Gangurde <abhijit.gangurde@amd.com>
To:     <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <Nipun.Gupta@amd.com>
CC:     <puneet.gupta@amd.com>, <nikhil.agarwal@amd.com>,
        <michal.simek@amd.com>, <git@amd.com>,
        Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [PATCH v2 2/2] cdx: Create resource debugfs file for cdx device
Date:   Thu, 23 Nov 2023 10:09:07 +0530
Message-ID: <20231123043907.4134256-2-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231123043907.4134256-1-abhijit.gangurde@amd.com>
References: <20231123043907.4134256-1-abhijit.gangurde@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|SN7PR12MB7788:EE_
X-MS-Office365-Filtering-Correlation-Id: 447e4cbf-a310-49d7-035d-08dbebde3493
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S/zlB5dJzHMZFFfFOel5Svl1ZHouuHphDHQT2CZJO+DDMKuqt2RwmTUIxbkOxcUn0mnR0g3GH7SAzvIZh/QuROCfdJLmb02UW+xnsPY4FH25ccekicOrjiYQGe1EPUz99CkaHkj6Glo3pRKkPIagfym6kwvcpJ469/700Zcd9Va5vVHlM2XPTIBB2+TqhCznKjtiuuW3fq4Hpiysaken93uVwyqBhOy9w4z55+sGh+3xwtQ5xsfhqoMy7nZ2O5e4oWKC9f21LOUJaduKjsldbxLzrNUt86BLUc2tqCw+3qbEdUvfySwj3HWxIfUKjTzJOQZNrm4TKKKIfZV6XHGNXhlRdjd9+7CZnCGIcR+EWmQ4LEcK+2Wg+FaqVd1z05eKmMpra27mDEohuPaPGGlMJtE1B5AckzNP7IG0J0muwTwAdajEKsH2mg7vAOYnFK4mQ7yE4XtMp0/dvqPILUr30p/ADhat9TMcTnZ2KLiJXr1OXkLDDGYvW3fGSLwPYtACrwPRznL4BP3nWCEiNWuZDeg0WT3LIQN2bG9gv2tZedJ9dNxJLbwl8AjcvNEFfGDu660YxdUMbiYB8VyT8GMzz8JyrbrKo6E64wxShdZ4PpMR0QqG7eA8UjQWCrnLC8rR110Aafm2BjJwEC+PGhhFjJGpXXI7owdsLn56ZbqzXHFNiwHviYn+BqEqBW/7WiM5Hon2p4hmNXeVkBSFQYx1Y2Tbot5ozdQBzDgPVzUIwk7NSQcn8bghfecaF5daD+Xdt5AR34r4vTOYoieuXHalgQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(230922051799003)(451199024)(64100799003)(186009)(82310400011)(1800799012)(40470700004)(46966006)(36840700001)(26005)(2616005)(336012)(1076003)(478600001)(426003)(47076005)(6666004)(36860700001)(5660300002)(2906002)(44832011)(41300700001)(70206006)(110136005)(70586007)(8936002)(6636002)(4326008)(8676002)(316002)(54906003)(40460700003)(356005)(82740400003)(81166007)(86362001)(36756003)(83380400001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 04:39:39.8186
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 447e4cbf-a310-49d7-035d-08dbebde3493
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7788
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resource debugfs file contains host addresses of CDX device resources.
Each line of the resource file describe type of resource, a region
with start-end and flag fields.

Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 Changes in v2:
 - Use printk format %pr for Struct Resources

 drivers/cdx/cdx.c           | 39 ++++++++++++++++++++++++++++++++++++-
 include/linux/cdx/cdx_bus.h |  2 ++
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index 4edf64f9e98d..cebac4a11202 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -65,6 +65,7 @@
 #include <linux/cdx/cdx_bus.h>
 #include <linux/iommu.h>
 #include <linux/dma-map-ops.h>
+#include <linux/debugfs.h>
 #include "cdx.h"
 
 /* Default DMA mask for devices on a CDX bus */
@@ -75,6 +76,8 @@
 static DEFINE_IDA(cdx_controller_ida);
 /* Lock to protect controller ops */
 static DEFINE_MUTEX(cdx_controller_lock);
+/* Debugfs dir for cdx bus */
+static struct dentry *cdx_debugfs_dir;
 
 static char *compat_node_name = "xlnx,versal-net-cdx";
 
@@ -149,6 +152,7 @@ static int cdx_unregister_device(struct device *dev,
 			cdx->ops->bus_disable(cdx, cdx_dev->bus_num);
 	} else {
 		cdx_destroy_res_attr(cdx_dev, MAX_CDX_DEV_RESOURCES);
+		debugfs_remove_recursive(cdx_dev->debugfs_dir);
 		kfree(cdx_dev->driver_override);
 		cdx_dev->driver_override = NULL;
 	}
@@ -552,6 +556,31 @@ static const struct attribute_group *cdx_dev_groups[] = {
 	NULL,
 };
 
+static int cdx_debug_resource_show(struct seq_file *s, void *data)
+{
+	struct cdx_device *cdx_dev = s->private;
+	int i;
+
+	for (i = 0; i < MAX_CDX_DEV_RESOURCES; i++) {
+		struct resource *res =  &cdx_dev->res[i];
+
+		seq_printf(s, "%pr\n", res);
+	}
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(cdx_debug_resource);
+
+static void cdx_device_debugfs_init(struct cdx_device *cdx_dev)
+{
+	cdx_dev->debugfs_dir = debugfs_create_dir(dev_name(&cdx_dev->dev), cdx_debugfs_dir);
+	if (IS_ERR(cdx_dev->debugfs_dir))
+		return;
+
+	debugfs_create_file("resource", 0444, cdx_dev->debugfs_dir, cdx_dev,
+			    &cdx_debug_resource_fops);
+}
+
 static ssize_t rescan_store(const struct bus_type *bus,
 			    const char *buf, size_t count)
 {
@@ -809,6 +838,8 @@ int cdx_device_add(struct cdx_dev_params *dev_params)
 		}
 	}
 
+	cdx_device_debugfs_init(cdx_dev);
+
 	return 0;
 resource_create_fail:
 	cdx_destroy_res_attr(cdx_dev, i);
@@ -913,6 +944,12 @@ EXPORT_SYMBOL_NS_GPL(cdx_unregister_controller, CDX_BUS_CONTROLLER);
 
 static int __init cdx_bus_init(void)
 {
-	return bus_register(&cdx_bus_type);
+	int ret;
+
+	ret = bus_register(&cdx_bus_type);
+	if (!ret)
+		cdx_debugfs_dir = debugfs_create_dir(cdx_bus_type.name, NULL);
+
+	return ret;
 }
 postcore_initcall(cdx_bus_init);
diff --git a/include/linux/cdx/cdx_bus.h b/include/linux/cdx/cdx_bus.h
index 3096c31d5b9f..681fd4d644ab 100644
--- a/include/linux/cdx/cdx_bus.h
+++ b/include/linux/cdx/cdx_bus.h
@@ -128,6 +128,7 @@ struct cdx_controller {
  * @dev_num: Device number for this device
  * @res: array of MMIO region entries
  * @res_attr: resource binary attribute
+ * @debugfs_dir: debugfs directory for this device
  * @res_count: number of valid MMIO regions
  * @dma_mask: Default DMA mask
  * @flags: CDX device flags
@@ -155,6 +156,7 @@ struct cdx_device {
 	u8 dev_num;
 	struct resource res[MAX_CDX_DEV_RESOURCES];
 	struct bin_attribute *res_attr[MAX_CDX_DEV_RESOURCES];
+	struct dentry *debugfs_dir;
 	u8 res_count;
 	u64 dma_mask;
 	u16 flags;
-- 
2.34.1

