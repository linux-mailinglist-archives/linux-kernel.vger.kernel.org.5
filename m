Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F7A79B218
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376685AbjIKWUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238334AbjIKNyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:54:07 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1043FA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:53:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVJYpFpTjW333SGpq92WYfzPJmXPbFdvMgzhFOGtVoSpUaZqsvDDf9qZLmzfp42mQobRmVpNoBsBJlBwzK4VzFu18IxHGSGt6F1I7WiZh4Ux1XkOX9p1QIRG9zF542dF8RHwc3oh1LIPfXiXIZtmdfvFZ+VNPcpKjEG4aibmrImToQgVNYcMGt4bHunwaiG9KpFM0ZPP5ksbRA4NmgqMF+ExP8NZGfnblrhbQdx7NcdvF5YDm7biNwp1R8KuQqCvQ3XQad5mQ+cVM2Izto4TrDRAbJvErQqq9odLmLMsHUBctVhFEErt82GRxKk3jUfe4RV/NHFdC8AJYh254K/oSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRV7uVa4MdYsv/NmMBGUvPkC49/TPmFYBDyL922qh04=;
 b=TikdHdHiy74pjlcDbdrpXNO26crJ1yoTL5KWn3CrMtpGEU0R0H6Zmhvu+XdBvTB4WO7vOyFI+I0SMbK93VfhoErCPMbSWX+ZXObXBjanWrJFQzCGghEB2WX5OgXgiSeVMSnFrntLTTBMzP3ubzpMkpBd/2cNSYZKko5+iyauZ9qodDnbCfWbioNqnkXNfPmAnxb+/1kA06PoCVXOrsSAoR/nD9A53u/KVP1NtwCxXRQDPx3yQ1WXz4Xfog/tCReDKspWEnuD2zzKreu5PSP+dIf2Em2isS4nPc9cHXv54H3+oEtPyZCSe+OjebPLIdCf1dYJAkOAtA8CVX3NSyDeFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRV7uVa4MdYsv/NmMBGUvPkC49/TPmFYBDyL922qh04=;
 b=JEPVUBu+cg5LBJNy8qiJqWK0+V8T7TRMKf1/seQqy17+l7rznzoDS6xnTpI1oM0C5uqS2jkOX37QUcHcEWxZcRd8XQOEeiJ90JYimSIdPMcGZwl4b1u+q3+Zf1X3vYg5aXbuRuSAhcDl83kVbO86mqp/aZo6GQcrU7GS6BLWaOE=
Received: from CH5P221CA0013.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::10)
 by DM4PR12MB6063.namprd12.prod.outlook.com (2603:10b6:8:b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Mon, 11 Sep
 2023 13:53:54 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::62) by CH5P221CA0013.outlook.office365.com
 (2603:10b6:610:1f2::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35 via Frontend
 Transport; Mon, 11 Sep 2023 13:53:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.16 via Frontend Transport; Mon, 11 Sep 2023 13:53:54 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 08:53:53 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 08:53:52 -0500
Received: from xhdipdslab41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 11 Sep 2023 08:53:49 -0500
From:   Nipun Gupta <nipun.gupta@amd.com>
To:     <gregkh@linuxfoundation.org>, <maz@kernel.org>,
        <tglx@linutronix.de>, <jgg@ziepe.ca>,
        <linux-kernel@vger.kernel.org>
CC:     <git@amd.com>, <harpreet.anand@amd.com>,
        <pieter.jansen-van-vuuren@amd.com>, <nikhil.agarwal@amd.com>,
        <michal.simek@amd.com>, <abhijit.gangurde@amd.com>,
        <srivatsa@csail.mit.edu>, Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH v4] cdx: add MSI support for CDX bus
Date:   Mon, 11 Sep 2023 19:22:59 +0530
Message-ID: <20230911135259.14046-1-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|DM4PR12MB6063:EE_
X-MS-Office365-Filtering-Correlation-Id: 809633f4-bd82-43b9-4a99-08dbb2ce89bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t2U36YhYc8wO+jScRWkFzMEf8kahSEtr+YGg0OIrEA+33a+t+UhTC5iPr99H0KW8iK7wCywHdsenwjPidPCBn0b3RhDic7OXSoJwBW+avpfhG3N4RJsy0M/9LoH2n2m0NfzzfPovx2qcTHFuw0ssjtLk5F3/3chQ/SIBXGxMGhrymNOgySIblS+zcbcoWghagDeAHUA7ShxIJpOar8OhkIymXFmViefq8e0oQb/JoUQJmxYgO//9yDLc9BvYrzfRUsPRRrJYV7kC4rSnZ9dCgi7Sk8l5GlpdzQkqlBHsl4znhFIRo2fMUZoL7dh+EdpR50d+0IStpQrF/gKSQryTBGYAV1XUOgRD3NqUdCRD1/vd5NwODI+n/LnfnYl5uWg04D0L2JXoWO+0JlavH5oj2sndtAnYABRzGnWsSH07GZjpNYgtgTHJuahmR6tDYtzmWTsLU1z3MtqNB/f+PPZqC8juaabTzTBUpy9v3kKnHUyc2b21CVb6h12tBxGl84z9L36+2PxAKZqBzh1yIUyGpAu2a1LQc/Zmbhau49St+nNUDbdemi5Wo4kIOYGazw18csWQbCDbxMI9WBCmqwkRl39RrcCHYDH5WhUxzJCEpqBk4B2Gn0vuvEPp8uzjM2LXP+cb89p1C9VIdxz1z36v2AkyzhJoEH7ZFbqpmch7iO3G7Dk0eU6o0v7VR4bIXDwbpmMopTg/sjimACErWTGwbsbEq8I3t9FuhD1Mug83TsZ4ds7XvOSLI8EHSguITUO9AQTnQsjOGSxghtJQO03gMw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(136003)(396003)(186009)(1800799009)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(316002)(54906003)(70206006)(70586007)(110136005)(1076003)(26005)(336012)(426003)(2616005)(47076005)(36756003)(83380400001)(6666004)(81166007)(356005)(86362001)(82740400003)(36860700001)(40480700001)(478600001)(40460700003)(30864003)(2906002)(8676002)(5660300002)(41300700001)(4326008)(8936002)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 13:53:54.6102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 809633f4-bd82-43b9-4a99-08dbb2ce89bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6063
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CDX-MSI domain per CDX controller with gic-its domain as
a parent, to support MSI for CDX devices. CDX devices allocate
MSIs from the CDX domain. Also, introduce APIs to alloc and free
IRQs for CDX domain.

In CDX subsystem firmware is a controller for all devices and
their configuration. CDX bus controller sends all the write_msi_msg
commands to firmware running on RPU and the firmware interfaces with
actual devices to pass this information to devices

Since, CDX controller is the only way to communicate with the Firmware
for MSI write info, CDX domain per controller required in contrast to
having a CDX domain per device.

Co-developed-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
Signed-off-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
Co-developed-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
---

Changes v3->v4:
- Rebased on Linux 6.6-rc1

Changes v2->v3:
- Rebased on Linux 6.5-rc1
- Used FW provided 'msi_dev_id' as device ID for GIC instead of 'req_id'.

Changes v1->v2:
- fixed scenario where msi write was called asyncronously in
  an atomic context, by using irq_chip_(un)lock, and using sync
  MCDI API for write MSI message.
- fixed broken Signed-off-by chain.

 drivers/cdx/Kconfig                     |   1 +
 drivers/cdx/Makefile                    |   2 +-
 drivers/cdx/cdx.c                       |   9 ++
 drivers/cdx/cdx.h                       |  12 ++
 drivers/cdx/cdx_msi.c                   | 183 ++++++++++++++++++++++++
 drivers/cdx/controller/cdx_controller.c |  23 +++
 drivers/cdx/controller/mc_cdx_pcol.h    |  64 +++++++++
 drivers/cdx/controller/mcdi_functions.c |  26 +++-
 drivers/cdx/controller/mcdi_functions.h |  20 +++
 include/linux/cdx/cdx_bus.h             |  32 +++++
 kernel/irq/msi.c                        |   1 +
 11 files changed, 370 insertions(+), 3 deletions(-)
 create mode 100644 drivers/cdx/cdx_msi.c

diff --git a/drivers/cdx/Kconfig b/drivers/cdx/Kconfig
index a08958485e31..86df7ccb76bb 100644
--- a/drivers/cdx/Kconfig
+++ b/drivers/cdx/Kconfig
@@ -8,6 +8,7 @@
 config CDX_BUS
 	bool "CDX Bus driver"
 	depends on OF && ARM64
+	select GENERIC_MSI_IRQ_DOMAIN
 	help
 	  Driver to enable Composable DMA Transfer(CDX) Bus. CDX bus
 	  exposes Fabric devices which uses composable DMA IP to the
diff --git a/drivers/cdx/Makefile b/drivers/cdx/Makefile
index 0324e4914f6e..4bad79d1d188 100644
--- a/drivers/cdx/Makefile
+++ b/drivers/cdx/Makefile
@@ -5,4 +5,4 @@
 # Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
 #
 
-obj-$(CONFIG_CDX_BUS) += cdx.o controller/
+obj-$(CONFIG_CDX_BUS) += cdx.o cdx_msi.o controller/
diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index d2cad4c670a0..8d777cdacf1d 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -56,6 +56,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/of_device.h>
 #include <linux/slab.h>
@@ -478,6 +479,7 @@ int cdx_device_add(struct cdx_dev_params *dev_params)
 
 	/* Populate CDX dev params */
 	cdx_dev->req_id = dev_params->req_id;
+	cdx_dev->msi_dev_id = dev_params->msi_dev_id;
 	cdx_dev->vendor = dev_params->vendor;
 	cdx_dev->device = dev_params->device;
 	cdx_dev->bus_num = dev_params->bus_num;
@@ -491,12 +493,19 @@ int cdx_device_add(struct cdx_dev_params *dev_params)
 	cdx_dev->dev.bus = &cdx_bus_type;
 	cdx_dev->dev.dma_mask = &cdx_dev->dma_mask;
 	cdx_dev->dev.release = cdx_device_release;
+	cdx_dev->msi_write_pending = false;
+	mutex_init(&cdx_dev->irqchip_lock);
 
 	/* Set Name */
 	dev_set_name(&cdx_dev->dev, "cdx-%02x:%02x",
 		     ((cdx->id << CDX_CONTROLLER_ID_SHIFT) | (cdx_dev->bus_num & CDX_BUS_NUM_MASK)),
 		     cdx_dev->dev_num);
 
+	if (cdx->msi_domain) {
+		cdx_dev->num_msi = dev_params->num_msi;
+		dev_set_msi_domain(&cdx_dev->dev, cdx->msi_domain);
+	}
+
 	ret = device_add(&cdx_dev->dev);
 	if (ret) {
 		dev_err(&cdx_dev->dev,
diff --git a/drivers/cdx/cdx.h b/drivers/cdx/cdx.h
index c436ac7ac86f..ece11c04d646 100644
--- a/drivers/cdx/cdx.h
+++ b/drivers/cdx/cdx.h
@@ -21,6 +21,8 @@
  * @res: array of MMIO region entries
  * @res_count: number of valid MMIO regions
  * @req_id: Requestor ID associated with CDX device
+ * @msi_dev_id: MSI device ID associated with CDX device
+ * @num_msi: Number of MSI's supported by the device
  */
 struct cdx_dev_params {
 	struct cdx_controller *cdx;
@@ -31,6 +33,8 @@ struct cdx_dev_params {
 	struct resource res[MAX_CDX_DEV_RESOURCES];
 	u8 res_count;
 	u32 req_id;
+	u32 msi_dev_id;
+	u32 num_msi;
 };
 
 /**
@@ -59,4 +63,12 @@ void cdx_unregister_controller(struct cdx_controller *cdx);
  */
 int cdx_device_add(struct cdx_dev_params *dev_params);
 
+/**
+ * cdx_msi_domain_init - Init the CDX bus MSI domain.
+ * @dev: Device of the CDX bus controller
+ *
+ * Return: CDX MSI domain, NULL on failure
+ */
+struct irq_domain *cdx_msi_domain_init(struct device *dev);
+
 #endif /* _CDX_H_ */
diff --git a/drivers/cdx/cdx_msi.c b/drivers/cdx/cdx_msi.c
new file mode 100644
index 000000000000..d7f4c88428d6
--- /dev/null
+++ b/drivers/cdx/cdx_msi.c
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AMD CDX bus driver MSI support
+ *
+ * Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
+ */
+
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/msi.h>
+#include <linux/cdx/cdx_bus.h>
+
+#include "cdx.h"
+
+static void cdx_msi_write_msg(struct irq_data *irq_data,
+			      struct msi_msg *msg)
+{
+	struct msi_desc *msi_desc = irq_data_get_msi_desc(irq_data);
+	struct cdx_device *cdx_dev = to_cdx_device(msi_desc->dev);
+
+	/* We would not operate on msg here rather we wait for
+	 * irq_bus_sync_unlock() to be called from preemptible
+	 * task context.
+	 */
+	msi_desc->msg = *msg;
+	cdx_dev->msi_write_pending = true;
+}
+
+static void cdx_msi_write_irq_lock(struct irq_data *irq_data)
+{
+	struct msi_desc *msi_desc = irq_data_get_msi_desc(irq_data);
+	struct cdx_device *cdx_dev = to_cdx_device(msi_desc->dev);
+
+	mutex_lock(&cdx_dev->irqchip_lock);
+}
+
+static void cdx_msi_write_irq_unlock(struct irq_data *irq_data)
+{
+	struct msi_desc *msi_desc = irq_data_get_msi_desc(irq_data);
+	struct cdx_device *cdx_dev = to_cdx_device(msi_desc->dev);
+	struct cdx_controller *cdx = cdx_dev->cdx;
+	struct cdx_device_config dev_config;
+	int ret;
+
+	if (!cdx_dev->msi_write_pending) {
+		mutex_unlock(&cdx_dev->irqchip_lock);
+		return;
+	}
+
+	cdx_dev->msi_write_pending = false;
+	mutex_unlock(&cdx_dev->irqchip_lock);
+
+	dev_config.msi.msi_index = msi_desc->msi_index;
+	dev_config.msi.data = msi_desc->msg.data;
+	dev_config.msi.addr = ((u64)(msi_desc->msg.address_hi) << 32) |
+			      msi_desc->msg.address_lo;
+
+	dev_config.type = CDX_DEV_MSI_CONF;
+	ret = cdx->ops->dev_configure(cdx, cdx_dev->bus_num, cdx_dev->dev_num,
+				      &dev_config);
+	if (ret)
+		dev_err(&cdx_dev->dev, "Write MSI failed to CDX controller\n");
+}
+
+static struct irq_chip cdx_msi_irq_chip = {
+	.name			= "CDX-MSI",
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_eoi		= irq_chip_eoi_parent,
+	.irq_set_affinity	= msi_domain_set_affinity,
+	.irq_write_msi_msg	= cdx_msi_write_msg,
+	.irq_bus_lock		= cdx_msi_write_irq_lock,
+	.irq_bus_sync_unlock	= cdx_msi_write_irq_unlock
+};
+
+int cdx_msi_domain_alloc_irqs(struct device *dev, unsigned int irq_count)
+{
+	int ret;
+
+	ret = msi_setup_device_data(dev);
+	if (ret)
+		return ret;
+
+	ret = msi_domain_alloc_irqs_range(dev, MSI_DEFAULT_DOMAIN,
+					  0, irq_count - 1);
+	if (ret)
+		dev_err(dev, "Failed to allocate IRQs: %d\n", ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cdx_msi_domain_alloc_irqs);
+
+/* Convert an msi_desc to a globally unique identifier. */
+static irq_hw_number_t cdx_domain_calc_hwirq(struct cdx_device *dev,
+					     struct msi_desc *desc)
+{
+	return ((irq_hw_number_t)dev->msi_dev_id << 10) | desc->msi_index;
+}
+
+static void cdx_msi_set_desc(msi_alloc_info_t *arg,
+			     struct msi_desc *desc)
+{
+	arg->desc = desc;
+	arg->hwirq = cdx_domain_calc_hwirq(to_cdx_device(desc->dev), desc);
+}
+
+static int cdx_msi_prepare(struct irq_domain *msi_domain,
+			   struct device *dev,
+			   int nvec, msi_alloc_info_t *info)
+{
+	struct cdx_device *cdx_dev = to_cdx_device(dev);
+	struct device *parent = dev->parent;
+	struct msi_domain_info *msi_info;
+	u32 dev_id = 0;
+	int ret;
+
+	/* Retrieve device ID from requestor ID using parent device */
+	ret = of_map_id(parent->of_node, cdx_dev->msi_dev_id, "msi-map",
+			"msi-map-mask", NULL, &dev_id);
+	if (ret) {
+		dev_err(dev, "of_map_id failed for MSI: %d\n", ret);
+		return ret;
+	}
+
+	/* Set the device Id to be passed to the GIC-ITS */
+	info->scratchpad[0].ul = dev_id;
+
+	msi_info = msi_get_domain_info(msi_domain->parent);
+
+	return msi_info->ops->msi_prepare(msi_domain->parent, dev, nvec, info);
+}
+
+static struct msi_domain_ops cdx_msi_ops = {
+	.msi_prepare	= cdx_msi_prepare,
+	.set_desc	= cdx_msi_set_desc
+};
+
+static struct msi_domain_info cdx_msi_domain_info = {
+	.ops	= &cdx_msi_ops,
+	.chip	= &cdx_msi_irq_chip,
+	.flags	= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+		  MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS | MSI_FLAG_FREE_MSI_DESCS
+};
+
+struct irq_domain *cdx_msi_domain_init(struct device *dev)
+{
+	struct device_node *np = dev->of_node;
+	struct fwnode_handle *fwnode_handle;
+	struct irq_domain *cdx_msi_domain;
+	struct device_node *parent_node;
+	struct irq_domain *parent;
+
+	fwnode_handle = of_node_to_fwnode(np);
+
+	parent_node = of_parse_phandle(np, "msi-map", 1);
+	if (!parent_node) {
+		dev_err(dev, "msi-map not present on cdx controller\n");
+		return NULL;
+	}
+
+	parent = irq_find_matching_fwnode(of_node_to_fwnode(parent_node),
+					  DOMAIN_BUS_NEXUS);
+	if (!parent || !msi_get_domain_info(parent)) {
+		dev_err(dev, "unable to locate ITS domain\n");
+		return NULL;
+	}
+
+	cdx_msi_domain = msi_create_irq_domain(fwnode_handle, &cdx_msi_domain_info,
+					       parent);
+	if (!cdx_msi_domain) {
+		dev_err(dev, "unable to create CDX-MSI domain\n");
+		return NULL;
+	}
+
+	dev_dbg(dev, "CDX-MSI domain created\n");
+
+	return cdx_msi_domain;
+}
+EXPORT_SYMBOL_GPL(cdx_msi_domain_init);
diff --git a/drivers/cdx/controller/cdx_controller.c b/drivers/cdx/controller/cdx_controller.c
index bb4ae7970e21..22f53896cd97 100644
--- a/drivers/cdx/controller/cdx_controller.c
+++ b/drivers/cdx/controller/cdx_controller.c
@@ -9,6 +9,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/cdx/cdx_bus.h>
+#include <linux/irqdomain.h>
 
 #include "cdx_controller.h"
 #include "../cdx.h"
@@ -50,9 +51,20 @@ static int cdx_configure_device(struct cdx_controller *cdx,
 				u8 bus_num, u8 dev_num,
 				struct cdx_device_config *dev_config)
 {
+	u16 msi_index;
 	int ret = 0;
+	u32 data;
+	u64 addr;
 
 	switch (dev_config->type) {
+	case CDX_DEV_MSI_CONF:
+		msi_index = dev_config->msi.msi_index;
+		data = dev_config->msi.data;
+		addr = dev_config->msi.addr;
+
+		ret = cdx_mcdi_write_msi(cdx->priv, bus_num, dev_num,
+					 msi_index, addr, data);
+		break;
 	case CDX_DEV_RESET_CONF:
 		ret = cdx_mcdi_reset_device(cdx->priv, bus_num, dev_num);
 		break;
@@ -155,6 +167,14 @@ static int xlnx_cdx_probe(struct platform_device *pdev)
 	cdx->priv = cdx_mcdi;
 	cdx->ops = &cdx_ops;
 
+	/* Create MSI domain */
+	cdx->msi_domain = cdx_msi_domain_init(&pdev->dev);
+	if (!cdx->msi_domain) {
+		dev_err(&pdev->dev, "cdx_msi_domain_init() failed");
+		ret = -ENODEV;
+		goto cdx_msi_fail;
+	}
+
 	ret = cdx_setup_rpmsg(pdev);
 	if (ret) {
 		if (ret != -EPROBE_DEFER)
@@ -166,6 +186,8 @@ static int xlnx_cdx_probe(struct platform_device *pdev)
 	return 0;
 
 cdx_rpmsg_fail:
+	irq_domain_remove(cdx->msi_domain);
+cdx_msi_fail:
 	kfree(cdx);
 cdx_alloc_fail:
 	cdx_mcdi_finish(cdx_mcdi);
@@ -182,6 +204,7 @@ static int xlnx_cdx_remove(struct platform_device *pdev)
 
 	cdx_destroy_rpmsg(pdev);
 
+	irq_domain_remove(cdx->msi_domain);
 	kfree(cdx);
 
 	cdx_mcdi_finish(cdx_mcdi);
diff --git a/drivers/cdx/controller/mc_cdx_pcol.h b/drivers/cdx/controller/mc_cdx_pcol.h
index 4ccb7b52951b..ff2d8d2bc9ef 100644
--- a/drivers/cdx/controller/mc_cdx_pcol.h
+++ b/drivers/cdx/controller/mc_cdx_pcol.h
@@ -455,6 +455,12 @@
 #define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_REQUESTER_ID_OFST			84
 #define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_REQUESTER_ID_LEN			4
 
+/* MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_V2 msgresponse */
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_V2_LEN				92
+/* Requester ID used by device for GIC ITS DeviceID */
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_V2_REQUESTER_DEVICE_ID_OFST	88
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_V2_REQUESTER_DEVICE_ID_LEN		4
+
 /***********************************/
 /*
  * MC_CMD_CDX_DEVICE_RESET
@@ -562,6 +568,64 @@
 #define MC_CMD_CDX_DEVICE_CONTROL_GET_OUT_MMIO_REGIONS_ENABLE_LBN	2
 #define MC_CMD_CDX_DEVICE_CONTROL_GET_OUT_MMIO_REGIONS_ENABLE_WIDTH	1
 
+/***********************************/
+/*
+ * MC_CMD_CDX_DEVICE_WRITE_MSI_MSG
+ * Populates the MSI message to be used by the hardware to raise the specified
+ * interrupt vector. Versal-net implementation specific limitations are that
+ * only 4 CDX devices with MSI interrupt capability are supported and all
+ * vectors within a device must use the same write address. The command will
+ * return EINVAL if any of these limitations is violated.
+ */
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG					0x9
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_MSGSET				0x9
+#undef MC_CMD_0x9_PRIVILEGE_CTG
+
+#define MC_CMD_0x9_PRIVILEGE_CTG SRIOV_CTG_ADMIN
+
+/* MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN msgrequest */
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_LEN				28
+/* Device bus number, in range 0 to BUS_COUNT-1 */
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_BUS_OFST			0
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_BUS_LEN			4
+/* Device number relative to the bus, in range 0 to DEVICE_COUNT-1 for that bus */
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_DEVICE_OFST			4
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_DEVICE_LEN			4
+/*
+ * Device-relative MSI vector number. Must be < MSI_COUNT reported for the
+ * device.
+ */
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_MSI_VECTOR_OFST		8
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_MSI_VECTOR_LEN		4
+/* Reserved (alignment) */
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_RESERVED_OFST		12
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_RESERVED_LEN			4
+/*
+ * MSI address to be used by the hardware. Typically, on ARM systems this
+ * address is translated by the IOMMU (if enabled) and it is the responsibility
+ * of the entity managing the IOMMU (APU kernel) to supply the correct IOVA
+ * here.
+ */
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_MSI_ADDRESS_OFST		16
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_MSI_ADDRESS_LEN		8
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_MSI_ADDRESS_LO_OFST		16
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_MSI_ADDRESS_LO_LEN		4
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_MSI_ADDRESS_LO_LBN		128
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_MSI_ADDRESS_LO_WIDTH		32
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_MSI_ADDRESS_HI_OFST		20
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_MSI_ADDRESS_HI_LEN		4
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_MSI_ADDRESS_HI_LBN		160
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_MSI_ADDRESS_HI_WIDTH		32
+/*
+ * MSI data to be used by the hardware. On versal-net, only the lower 16-bits
+ * are used, the remaining bits are ignored and should be set to zero.
+ */
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_MSI_DATA_OFST		24
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_MSI_DATA_LEN			4
+
+/* MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_OUT msgresponse */
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_OUT_LEN				0
+
 /***********************************/
 /* MC_CMD_V2_EXTN - Encapsulation for a v2 extended command */
 #define MC_CMD_V2_EXTN					0x7f
diff --git a/drivers/cdx/controller/mcdi_functions.c b/drivers/cdx/controller/mcdi_functions.c
index 0158f26533dd..901ec1f53c85 100644
--- a/drivers/cdx/controller/mcdi_functions.c
+++ b/drivers/cdx/controller/mcdi_functions.c
@@ -49,7 +49,7 @@ int cdx_mcdi_get_dev_config(struct cdx_mcdi *cdx,
 			    u8 bus_num, u8 dev_num,
 			    struct cdx_dev_params *dev_params)
 {
-	MCDI_DECLARE_BUF(outbuf, MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_LEN);
+	MCDI_DECLARE_BUF(outbuf, MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_V2_LEN);
 	MCDI_DECLARE_BUF(inbuf, MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_IN_LEN);
 	struct resource *res = &dev_params->res[0];
 	size_t outlen;
@@ -64,7 +64,7 @@ int cdx_mcdi_get_dev_config(struct cdx_mcdi *cdx,
 	if (ret)
 		return ret;
 
-	if (outlen != MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_LEN)
+	if (outlen != MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_V2_LEN)
 		return -EIO;
 
 	dev_params->bus_num = bus_num;
@@ -73,6 +73,9 @@ int cdx_mcdi_get_dev_config(struct cdx_mcdi *cdx,
 	req_id = MCDI_DWORD(outbuf, CDX_BUS_GET_DEVICE_CONFIG_OUT_REQUESTER_ID);
 	dev_params->req_id = req_id;
 
+	dev_params->msi_dev_id = MCDI_DWORD(outbuf,
+					    CDX_BUS_GET_DEVICE_CONFIG_OUT_V2_REQUESTER_DEVICE_ID);
+
 	dev_params->res_count = 0;
 	if (MCDI_QWORD(outbuf, CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION0_SIZE) != 0) {
 		res[dev_params->res_count].start =
@@ -120,10 +123,29 @@ int cdx_mcdi_get_dev_config(struct cdx_mcdi *cdx,
 
 	dev_params->vendor = MCDI_WORD(outbuf, CDX_BUS_GET_DEVICE_CONFIG_OUT_VENDOR_ID);
 	dev_params->device = MCDI_WORD(outbuf, CDX_BUS_GET_DEVICE_CONFIG_OUT_DEVICE_ID);
+	dev_params->num_msi = MCDI_DWORD(outbuf, CDX_BUS_GET_DEVICE_CONFIG_OUT_MSI_COUNT);
 
 	return 0;
 }
 
+int cdx_mcdi_write_msi(struct cdx_mcdi *cdx, u8 bus_num, u8 dev_num,
+		       u32 msi_vector, u64 msi_address, u32 msi_data)
+{
+	MCDI_DECLARE_BUF(inbuf, MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_LEN);
+	int ret;
+
+	MCDI_SET_DWORD(inbuf, CDX_DEVICE_WRITE_MSI_MSG_IN_BUS, bus_num);
+	MCDI_SET_DWORD(inbuf, CDX_DEVICE_WRITE_MSI_MSG_IN_DEVICE, dev_num);
+	MCDI_SET_DWORD(inbuf, CDX_DEVICE_WRITE_MSI_MSG_IN_MSI_VECTOR, msi_vector);
+	MCDI_SET_QWORD(inbuf, CDX_DEVICE_WRITE_MSI_MSG_IN_MSI_ADDRESS, msi_address);
+	MCDI_SET_DWORD(inbuf, CDX_DEVICE_WRITE_MSI_MSG_IN_MSI_DATA, msi_data);
+
+	ret = cdx_mcdi_rpc(cdx, MC_CMD_CDX_DEVICE_WRITE_MSI_MSG, inbuf, sizeof(inbuf),
+			   NULL, 0, NULL);
+
+	return ret;
+}
+
 int cdx_mcdi_reset_device(struct cdx_mcdi *cdx, u8 bus_num, u8 dev_num)
 {
 	MCDI_DECLARE_BUF(inbuf, MC_CMD_CDX_DEVICE_RESET_IN_LEN);
diff --git a/drivers/cdx/controller/mcdi_functions.h b/drivers/cdx/controller/mcdi_functions.h
index 7440ace5539a..35a300727f34 100644
--- a/drivers/cdx/controller/mcdi_functions.h
+++ b/drivers/cdx/controller/mcdi_functions.h
@@ -47,6 +47,26 @@ int cdx_mcdi_get_dev_config(struct cdx_mcdi *cdx,
 			    u8 bus_num, u8 dev_num,
 			    struct cdx_dev_params *dev_params);
 
+/**
+ * cdx_mcdi_write_msi - Write MSI configuration for CDX device
+ * @cdx: pointer to MCDI interface.
+ * @bus_num: Bus number.
+ * @dev_num: Device number.
+ * @msi_vector: Device-relative MSI vector number.
+ *	Must be < MSI_COUNT reported for the device.
+ * @msi_address: MSI address to be used by the hardware. Typically, on ARM
+ *	systems this address is translated by the IOMMU (if enabled) and
+ *	it is the responsibility of the entity managing the IOMMU (APU kernel)
+ *	to supply the correct IOVA here.
+ * @msi_data: MSI data to be used by the hardware. On versal-net, only the
+ *	lower 16-bits are used, the remaining bits are ignored and should be
+ *	set to zero.
+ *
+ * Return: 0 on success, <0 on failure
+ */
+int cdx_mcdi_write_msi(struct cdx_mcdi *cdx, u8 bus_num, u8 dev_num,
+		       u32 msi_vector, u64 msi_address, u32 msi_data);
+
 /**
  * cdx_mcdi_reset_device - Reset cdx device represented by bus_num:dev_num
  * @cdx: pointer to MCDI interface.
diff --git a/include/linux/cdx/cdx_bus.h b/include/linux/cdx/cdx_bus.h
index bead71b7bc73..7ff8dbf2c1f1 100644
--- a/include/linux/cdx/cdx_bus.h
+++ b/include/linux/cdx/cdx_bus.h
@@ -21,11 +21,19 @@
 struct cdx_controller;
 
 enum {
+	CDX_DEV_MSI_CONF,
 	CDX_DEV_RESET_CONF,
 };
 
+struct cdx_msi_config {
+	u16 msi_index;
+	u32 data;
+	u64 addr;
+};
+
 struct cdx_device_config {
 	u8 type;
+	struct cdx_msi_config msi;
 };
 
 typedef int (*cdx_scan_cb)(struct cdx_controller *cdx);
@@ -62,12 +70,14 @@ struct cdx_ops {
  * struct cdx_controller: CDX controller object
  * @dev: Linux device associated with the CDX controller.
  * @priv: private data
+ * @msi_domain: MSI domain
  * @id: Controller ID
  * @ops: CDX controller ops
  */
 struct cdx_controller {
 	struct device *dev;
 	void *priv;
+	struct irq_domain *msi_domain;
 	u32 id;
 	struct cdx_ops *ops;
 };
@@ -86,9 +96,13 @@ struct cdx_controller {
  * @dma_mask: Default DMA mask
  * @flags: CDX device flags
  * @req_id: Requestor ID associated with CDX device
+ * @msi_dev_id: MSI Device ID associated with CDX device
+ * @num_msi: Number of MSI's supported by the device
  * @driver_override: driver name to force a match; do not set directly,
  *                   because core frees it; use driver_set_override() to
  *                   set or clear it.
+ * @irqchip_lock: lock to synchronize irq/msi configuration
+ * @msi_write_pending: MSI write pending for this device
  */
 struct cdx_device {
 	struct device dev;
@@ -102,7 +116,11 @@ struct cdx_device {
 	u64 dma_mask;
 	u16 flags;
 	u32 req_id;
+	u32 msi_dev_id;
+	u32 num_msi;
 	const char *driver_override;
+	struct mutex irqchip_lock; /* Serialize write msi configuration */
+	bool msi_write_pending;
 };
 
 #define to_cdx_device(_dev) \
@@ -162,6 +180,20 @@ void cdx_driver_unregister(struct cdx_driver *cdx_driver);
 
 extern struct bus_type cdx_bus_type;
 
+/**
+ * cdx_msi_domain_alloc_irqs - Allocate MSI's for the CDX device
+ * @dev: device pointer
+ * @irq_count: Number of MSI's to be allocated
+ *
+ * Return: 0 for success, -errno on failure
+ */
+int cdx_msi_domain_alloc_irqs(struct device *dev, unsigned int irq_count);
+
+/**
+ * cdx_msi_domain_free_irqs - Free MSI's for CDX device
+ */
+#define cdx_msi_domain_free_irqs msi_domain_free_irqs_all
+
 /**
  * cdx_dev_reset - Reset CDX device
  * @dev: device pointer
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index b4c31a5c1147..ffdd61a90027 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1637,6 +1637,7 @@ void msi_domain_free_irqs_all(struct device *dev, unsigned int domid)
 	msi_domain_free_irqs_all_locked(dev, domid);
 	msi_unlock_descs(dev);
 }
+EXPORT_SYMBOL_GPL(msi_domain_free_irqs_all);
 
 /**
  * msi_get_domain_info - Get the MSI interrupt domain info for @domain
-- 
2.17.1

