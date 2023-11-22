Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAC67F3F71
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 09:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbjKVIDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 03:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234966AbjKVID3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 03:03:29 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606CB110
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 00:03:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=je0tKIhntnBp+Imne9RdkQek30ym+r/DzEcHf3BkOJEo4aW6DhL8IO3uFQtUqgyT7T1cS4U00j82JZ7rFhCVE87aYybpcWN36dUciH7xY/TpHCCaErYHZKRZpZDvXvql2vU8moPdxx+GSyFYebMwdkpiU2aw/X3iJX8BgzFSfF24gMaVT+kGxzO0SjIWA1/bhYSWQuIo/zM4hGS/TsOY4AyY+eoMBZ2lLb9eDYTlXnPpulPwRZoMgRkwRLMpvzcQhS027rRYVhvzWsG8M70QBp6wQxuhuetF7grxASAdXICIF8BpD0Q/EpOd8G7IRHrieK7Su9dUtQN3zebT9ggHvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8jn3RKSGW+UK6pLa1fN9RoACYuz7Prrixw0YTYU7tg=;
 b=esSUshG8vwxqC13TuWHoL0TblFWu5g1+4jzjskEtk6H7+Q33WIKfohy2ZCaOP3elmgsMZ1kd/DPzJwf0bG5H/zU9vJZUL5lDB4kKCc7XUoyoNwz8bQGyZL+oT4ZjpmE06Am/ybkzbAMdaHi3RbaiGr9xtH8uNQcD/QVAt/I8JEVbq8uSospzvqvP5iN5Jq1mcikyCq5GzPG6Macx+7UVvu6C5pOujMGktuVh8Kg71X6B9KWw68OCJyOFCAU7dPURwkArRhLve8VdjcIYDENFWUCuDzrpSQs8VUGR2nIS7QWSNgQfJxwLCy2RNVz0Z8ouTd0+HYFUFaDP4QQaHccRlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8jn3RKSGW+UK6pLa1fN9RoACYuz7Prrixw0YTYU7tg=;
 b=WJUyguwH0e55N2nN9N+XrpOBI5+D/cJAtOVQ1sXc6BIrW6poGmuV63YS/CKHMaMXcz6hcF7Uy9mvl48plK9b4Jj8h0nynYEZhWXWm7lMZys6w+ZZ4oXfwRxUL5zlXG/DCRGplQm7sCgLb3ABeWWjm2Cl/GIpah5v8RVhqj6JSQo=
Received: from CH5P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::29)
 by CH3PR12MB8909.namprd12.prod.outlook.com (2603:10b6:610:179::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 08:03:23 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::8a) by CH5P221CA0005.outlook.office365.com
 (2603:10b6:610:1f2::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18 via Frontend
 Transport; Wed, 22 Nov 2023 08:03:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Wed, 22 Nov 2023 08:03:23 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 22 Nov
 2023 02:03:20 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 22 Nov
 2023 00:03:20 -0800
Received: from xhdipdslab61.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 22 Nov 2023 02:03:18 -0600
From:   Abhijit Gangurde <abhijit.gangurde@amd.com>
To:     <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <Nipun.Gupta@amd.com>
CC:     <puneet.gupta@amd.com>, <nikhil.agarwal@amd.com>,
        <michal.simek@amd.com>, <git@amd.com>,
        Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [PATCH 2/2] cdx: Create resource debugfs file for cdx device
Date:   Wed, 22 Nov 2023 13:33:00 +0530
Message-ID: <20231122080300.3727388-2-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231122080300.3727388-1-abhijit.gangurde@amd.com>
References: <20231122080300.3727388-1-abhijit.gangurde@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|CH3PR12MB8909:EE_
X-MS-Office365-Filtering-Correlation-Id: eedf9794-1c72-4ff2-3b16-08dbeb317faf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SuE/8VP17npSAQOScRXtUqNoLxp9cacWps7X5bQjPn117cJYdxAE+OXgOLbEx3ap356kYLIbwUcfX3utDqNwRQuMsR5Kh51lKxVfRzEjsuo9LSoGJ9YRF62sIZoML6bvsn+bBgZY7QcZSiQgLt/ctOKjBs/6eJFkEP+vWRL25ow+N1jB+XcZiR7UQyAzn50AWPrN/EmoJLRGKXd6SvMFyZ5QEGh9dNgMrSrEXG5oNkWiyAtDdhESGcXOgvAn8ZTkMoSvn0GVf8a89fi7EuKpkcvJ45ZLedWNGflqFfDAEXOJYosf1X9Rhwrgl3mBhycFLn6KYjzqnti5aGCubgRgCHZmNoiaRaEKliY8bEIbtf8axVW3643QOMiy/qbA2lVyqy54YO8co58M3SJHVv88UwpPoja9dVX2yjfFpSHjTECftAY7rnIsO7PTz26B1UlM7vd67k7EBBqDfkt2+Rgk8qQcp0YTW9hZJBXQkBEuVkFEPVfEBMabl0EPdFGRCOdpyV1zblnxeex0YPYBE2OBPNQ6F9bnuBBkS12cGSi580EsapPjFNjnwxcKqg1LJrTDMrnJq4eRUm2nymvNC/vDrJ7oEwWocIz4rb1YPZIJuCVAp7F9nnw0aM7PXDUxd2SwgpP5rUi1DR8Nxi/kJ6pN1qkodiA1WroAVoj9IQdjpnJ+rbCbJXKcDrPnqG96GDT8T1ORII3SJG1Y4WxVesK2veMsnEf3eTjM6511Ns9AUjq636qLDm+YYOIDuvQNvQojlDQXsG6NABokjtCFUxw0mQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(82310400011)(1800799012)(64100799003)(186009)(451199024)(36840700001)(46966006)(40470700004)(44832011)(5660300002)(40480700001)(8676002)(8936002)(4326008)(41300700001)(2906002)(70586007)(70206006)(110136005)(316002)(54906003)(6636002)(40460700003)(47076005)(26005)(478600001)(1076003)(36756003)(6666004)(2616005)(426003)(336012)(356005)(81166007)(36860700001)(83380400001)(86362001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 08:03:23.0547
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eedf9794-1c72-4ff2-3b16-08dbeb317faf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8909
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resource debugfs file contains host addresses of CDX device resources.
Each line of the resource file describe a region with start, end and
flag fields.

Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 drivers/cdx/cdx.c           | 42 ++++++++++++++++++++++++++++++++++++-
 include/linux/cdx/cdx_bus.h |  2 ++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index 4edf64f9e98d..e01376272ed3 100644
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
@@ -552,6 +556,34 @@ static const struct attribute_group *cdx_dev_groups[] = {
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
+		seq_printf(s, "0x%016llx 0x%016llx 0x%016llx\n",
+			   (unsigned long long)res->start,
+			   (unsigned long long)res->end,
+			   (unsigned long long)res->flags);
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
@@ -809,6 +841,8 @@ int cdx_device_add(struct cdx_dev_params *dev_params)
 		}
 	}
 
+	cdx_device_debugfs_init(cdx_dev);
+
 	return 0;
 resource_create_fail:
 	cdx_destroy_res_attr(cdx_dev, i);
@@ -913,6 +947,12 @@ EXPORT_SYMBOL_NS_GPL(cdx_unregister_controller, CDX_BUS_CONTROLLER);
 
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

