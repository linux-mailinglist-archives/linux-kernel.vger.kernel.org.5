Return-Path: <linux-kernel+bounces-9419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4780481C53E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 07:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2A6F287257
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 06:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE5D8F63;
	Fri, 22 Dec 2023 06:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="t2w61e/j"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53B18F57
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 06:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SecFmpZIy2ICzINrDC8g6PoxsSOO5lGffAoFkcZFbIMNYCwfDa5Y76VOebaLDHzRRG5sX/tod3zOdeBB088BeN1HBXKvJQDEuw29C0i5mmUUv/ak38K0FF/ZbRy3nyxBiFYRheaG+WESKD3JfsrmPMxvKQLuAZ527Hc/6EL6z22Q0IK/pqjJorXYXfThgGHTroOA1Nqa+SpncQi/1wS6KZ7ayYRKbk3bvvFF+Z2ogn9LdRM5/cipgpSIxLNX7oFpGHp9djVo/aVTeXB2+gldz/13el2lwIoNL4UYHBWM2q/JmlcRJowhGucytomClaRHZ2mTKM7SDk61LD7eWK2nnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8grwBmeLTG9VS7JldtouHOQ6c1K5q/dlpvp1qpXJHQE=;
 b=LBcCXSDS7thnG3dhK35PFt47CUWIrCLOirrj7RWHHixIGrI1mMh6EV0hX6ly6POkF7IzuPLwiUQgI7EieBbLh9ffYtYccNUmxbXBMYFJ3vkNQhLitfP41Gttx6NYrO96coKokLHy1xK12eMlqcebIjuVyAcM1dHEPU21Xr6ZupTIsFQTuAHybM5FI8T2pDZcgCVfH+w1rEQQSDj483IiNSzns7H2Dn28fH6fhzsIuEVgFODEiWmUD6ZISLNfvaCT+wDdLe8ncc/TrFvuT/GRy57x0InKAn0uqlRSs/wHvM/4GcvI20q95hCXItqLtWHpYJ0TyK6669zBNbx1HOEyXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8grwBmeLTG9VS7JldtouHOQ6c1K5q/dlpvp1qpXJHQE=;
 b=t2w61e/j/fxhPCPu0kaltzZ8c+v1FfRCt1k+ZH+q42HCH8mbhodH7ynIsIRCj8y7KGBaM3O4vJsAroaClrhqOiyjdqaiiNMkgPBK1JjKC+qkeeYb+KsZMUwjhAxKbNNfum/69GWUfgRN98yuBb6uNjIsKxra2WsCdjBvJYWfVQw=
Received: from PH0PR07CA0045.namprd07.prod.outlook.com (2603:10b6:510:e::20)
 by BN9PR12MB5323.namprd12.prod.outlook.com (2603:10b6:408:104::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 06:46:41 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:510:e:cafe::3f) by PH0PR07CA0045.outlook.office365.com
 (2603:10b6:510:e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21 via Frontend
 Transport; Fri, 22 Dec 2023 06:46:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 22 Dec 2023 06:46:40 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 22 Dec
 2023 00:46:39 -0600
Received: from xhdipdslab61.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Fri, 22 Dec 2023 00:46:37 -0600
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
	<Nipun.Gupta@amd.com>
CC: <puneet.gupta@amd.com>, <nikhil.agarwal@amd.com>, <michal.simek@amd.com>,
	<git@amd.com>, Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [PATCH RESEND v2 2/2] cdx: Create resource debugfs file for cdx device
Date: Fri, 22 Dec 2023 12:16:27 +0530
Message-ID: <20231222064627.2828960-2-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231222064627.2828960-1-abhijit.gangurde@amd.com>
References: <20231222064627.2828960-1-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|BN9PR12MB5323:EE_
X-MS-Office365-Filtering-Correlation-Id: acef555e-091d-43c8-b33f-08dc02b9c0b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	54vDw5TsPhBeH+CzRyPWECQkakV1M7JenXYA2MwuCuhJsx1zbZaEyxUwJwiHUH5sCn2PxI2ofFdaDcR5BwDa6piel2dEwKGC43MKOEU3wOY4U7lxNgOWq5WGV1x1w1jFkIT6qMhegVS9N/X0VtLnIhkU4qIVQnQxXHGwc8izJU+PpsPrkWzN9zoxZn2OK1qvs4W6Yirm4KdNZsETXWk21fdOJAgca+T0oTNR0B7bS+PnbxLpQRWdclBGZhYcQwtviTU/Lu8BHRqSCpfBnj0F1f6lNGkCoGw366KLI2erJx6QBGHuxpSPYzgTu0QB+dJIsK+URM40qIiFqMBaSBKv+FJx/uVb/wLcoUPMU64ntg0E3g+L22rEtEgqi5TM0ckqPX9CAibduE9DzCSiAGKxUFquZaKrhrkzEuvCYVPKvCBNPsO/q6gwYk+I2tnzXLAs+wNi7EoRk+p1CJi3CyNixtrMzVkCd37fhq/7AVqFwciIPjmL+vTU62YW8PaVr/HNq69ZhOn8aTcENgId/RL/R6fWJc9pNHeGHpkt6qG7qQGU3Ot41EmZ6CPdUUzpHraJwdwdr2Xdf3TD+AHsUTuw1O5C6hbbty9zXLNMdoitrz9UwvicwT9deovMpNf/Jq9DNtU7Tc8HR9fi7vK6Z0WLhNiEL1ZWit1vJBWvLD8apEMdODDVBvi8nxCxtlFg2lhYNvFQPP/cZ1H2dMu/tVJkTIzExuUEzSFgDft2FAb6eJmdvzx2IdDUBzpXQ8JLej0Yp+rpBY+PSxD/Lu6rfgEK7A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(346002)(136003)(230922051799003)(1800799012)(82310400011)(451199024)(64100799003)(186009)(40470700004)(36840700001)(46966006)(40480700001)(36860700001)(44832011)(47076005)(336012)(83380400001)(426003)(2616005)(478600001)(8676002)(4326008)(8936002)(316002)(2906002)(5660300002)(110136005)(54906003)(6666004)(70586007)(70206006)(6636002)(40460700003)(81166007)(82740400003)(356005)(26005)(86362001)(1076003)(36756003)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 06:46:40.4390
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acef555e-091d-43c8-b33f-08dc02b9c0b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5323

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


