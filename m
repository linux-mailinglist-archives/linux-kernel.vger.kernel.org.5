Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719987CC85F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343979AbjJQQHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 12:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343532AbjJQQHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:07:33 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8187695
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:07:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRDL2KTbVc2EIQvPvxsW6Q47U+/e7LGWNlBNGMPAWPCyspbdFUuxiQAFp2nSUMOTlv702XaXP9W+NkdJuoS/5yYG55I8UEfIAHZnO+/L0TSFAugfbmP9QMfVlFg97aPAGLyGmnF3NNS3kWf/RQ3iSmgxVdDHTrI5SiYWmCljoTB4D+xDBRcl1eRE+wtNY1QCBt4Noalt62wOd6Tzo8cKYCsU+Jkk64pqXvF/HKfXDAX5MDltaL1/w3fMSFxlwLDxT1lQ4iO4q6zVno77ZaChdn80UmQ8mAYOGr5QqJoor2Kt2MFB4XafLcjnNY+3w26anUdgqrfnfTkQlU/Lmb22Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0YozevfbJj5mDbmFW3hI0vInRjlWTpJifXbaws/599k=;
 b=Opg++0wbea1xXakZ/9vSETHWVPSv+pUGf8xSM6K9Mn1496gsvZ3o4guiDVjc1uKDC32kCMs0GyOhEaCLNJ7u/DRt4Eyh02rxvcqO38RVeXaJ6/MOkMuMkigd+GHz7Q3SvlXRWTFPb+/wvszk11jRikAU1wHvUxS8SGDsCwROWLIAJ6JcBR7+Qlg4S73ORFTS7bcmNbM30oOP4xhBHPdBz9ynTQCHGBvaFIkS4+F/2R3gd25R0hEAHE2eu0Qfu6cG41LVuy6ntaRfGrj2JH5Q9YpfsQ/2GB83FdkejFnEhmkZJoWYsxDFAb1BGsvatt+mJB8OJc79avr9SEqqJr/neA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YozevfbJj5mDbmFW3hI0vInRjlWTpJifXbaws/599k=;
 b=CPTfvZF+UiybMJshYMnWh5lV6hUQd80EBsEFF3Oa6TU3J2aO4Kj1YIHcs6g3ZxJrdIujCKzDcIXfIt1LMRLZKcBQ2/NiASBYw0S95B4VWqbFY6sed0XI0c+K8pXpyMgOX8hYsPD5Wai5U6flHKuc2kOUT61mkfZWMNio6FKs6+k=
Received: from CY5PR19CA0109.namprd19.prod.outlook.com (2603:10b6:930:64::6)
 by IA1PR12MB8286.namprd12.prod.outlook.com (2603:10b6:208:3f8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 16:07:27 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:64:cafe::34) by CY5PR19CA0109.outlook.office365.com
 (2603:10b6:930:64::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Tue, 17 Oct 2023 16:07:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 16:07:27 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 17 Oct
 2023 11:06:45 -0500
Received: from xhdipdslab59.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 17 Oct 2023 11:06:42 -0500
From:   Abhijit Gangurde <abhijit.gangurde@amd.com>
To:     <gregkh@linuxfoundation.org>, <masahiroy@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <puneet.gupta@amd.com>, <Nipun.Gupta@amd.com>,
        <nikhil.agarwal@amd.com>, <michal.simek@amd.com>, <git@amd.com>,
        Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [PATCH v7 4/7] cdx: Register cdx bus as a device on cdx subsystem
Date:   Tue, 17 Oct 2023 21:35:02 +0530
Message-ID: <20231017160505.10640-5-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231017160505.10640-1-abhijit.gangurde@amd.com>
References: <20231017160505.10640-1-abhijit.gangurde@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|IA1PR12MB8286:EE_
X-MS-Office365-Filtering-Correlation-Id: 5962b305-4374-4ef2-b6ab-08dbcf2b28c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OgCL0N3yIyZGZARYnJBFgGhm+detPxGwXrxNXbvxKx1oBdzolrsbJ0/4lBt5y//kA4egyLS+pISVrD2wY3V4bVTBrrOApdWrntI5dIM9Nq1v4yl1D+sKROIZQsV0dg5W7MxBgBlVwqktxtT/DAaXUfYWGJDpEiZK6Hc4JQmqLVJZG8hEZ5KAaYZ/KszeIMotOo3JrZlpIhqN2EP86Lj46hVS/inLZWJ/VFzkJ2u48WKy1dcWEXAoRUIXv9331qjbAKyoJfMhJXCKkCgbupo4C7S3gy3BEdO6piefvisE/Z3HXI2SCFpFfrpIpRsFug4XRhY/++k6YoXfbU8DEh+uXmnPRkz0XJLWBq/yxIHTCoXbg110t9qQe1l07LoT5jljrdYQ+TmD/GvYIkd9/HxtUaMg/cfoPAmMgX0c78CR43NBl1Ohdkp4zk2YwvL82H5noPGeZtjCCjAmOzbOiSEVnuSdn5jhpqqHU7LBAU7Ru225TYS3a7r4JI33o2W5PP6Rvmu2OuzyOnFsea5gdqOM3G2BGYj47u7RPRQ1lVBoSsrLg6/V3wecMk3+yd0uAUf64xHxKmoyQ3UIr2ErpQbyXL70Wdf4fxgWWLiBex33aXTM6U1YK396e7MgdbyxB5uI08hMxcAwHvCONQEkko0iI+SIrS8rso+q9/wDZHPkfSygHK4b7ra0TlJlHAwW95AEpIOv+QvNr2gd+VNbkywN8SGF91wdTtK62FTiiM1YtuYRlFWXyXWaky8oAn4BW+pE0svHUJ8WoPR2gUbeDnFzww==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(39860400002)(136003)(346002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(83380400001)(336012)(426003)(26005)(1076003)(5660300002)(8936002)(41300700001)(4326008)(110136005)(8676002)(44832011)(2616005)(36756003)(40460700003)(86362001)(356005)(40480700001)(82740400003)(81166007)(36860700001)(47076005)(2906002)(478600001)(6666004)(316002)(70586007)(54906003)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 16:07:27.1839
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5962b305-4374-4ef2-b6ab-08dbcf2b28c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8286
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While scanning for CDX devices, register newly discovered bus as a
cdx device. CDX device attributes are visible based on device type.

Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 Changes in v7:
 - None

 Changes in v6:
 - New patch in the series
 - Register cdx bus as a device on cdx subsystem

 drivers/cdx/cdx.c                       | 77 +++++++++++++++++++++++--
 drivers/cdx/cdx.h                       | 14 ++++-
 drivers/cdx/controller/cdx_controller.c |  7 +++
 include/linux/cdx/cdx_bus.h             |  2 +
 4 files changed, 93 insertions(+), 7 deletions(-)

diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index ee0913f04758..cf5306580c21 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -125,8 +125,13 @@ static int cdx_unregister_device(struct device *dev,
 {
 	struct cdx_device *cdx_dev = to_cdx_device(dev);
 
-	kfree(cdx_dev->driver_override);
-	cdx_dev->driver_override = NULL;
+	if (cdx_dev->is_bus) {
+		device_for_each_child(dev, NULL, cdx_unregister_device);
+	} else {
+		kfree(cdx_dev->driver_override);
+		cdx_dev->driver_override = NULL;
+	}
+
 	/*
 	 * Do not free cdx_dev here as it would be freed in
 	 * cdx_device_release() called from within put_device().
@@ -201,6 +206,9 @@ static int cdx_bus_match(struct device *dev, struct device_driver *drv)
 	const struct cdx_device_id *found_id = NULL;
 	const struct cdx_device_id *ids;
 
+	if (cdx_dev->is_bus)
+		return false;
+
 	ids = cdx_drv->match_id_table;
 
 	/* When driver_override is set, only bind to the matching driver */
@@ -265,10 +273,11 @@ static int cdx_dma_configure(struct device *dev)
 {
 	struct cdx_driver *cdx_drv = to_cdx_driver(dev->driver);
 	struct cdx_device *cdx_dev = to_cdx_device(dev);
+	struct cdx_controller *cdx = cdx_dev->cdx;
 	u32 input_id = cdx_dev->req_id;
 	int ret;
 
-	ret = of_dma_configure_id(dev, dev->parent->of_node, 0, &input_id);
+	ret = of_dma_configure_id(dev, cdx->dev->of_node, 0, &input_id);
 	if (ret && ret != -EPROBE_DEFER) {
 		dev_err(dev, "of_dma_configure_id() failed\n");
 		return ret;
@@ -374,6 +383,18 @@ static ssize_t driver_override_show(struct device *dev,
 }
 static DEVICE_ATTR_RW(driver_override);
 
+static umode_t cdx_dev_attrs_are_visible(struct kobject *kobj, struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct cdx_device *cdx_dev;
+
+	cdx_dev = to_cdx_device(dev);
+	if (!cdx_dev->is_bus)
+		return a->mode;
+
+	return 0;
+}
+
 static struct attribute *cdx_dev_attrs[] = {
 	&dev_attr_remove.attr,
 	&dev_attr_reset.attr,
@@ -382,7 +403,16 @@ static struct attribute *cdx_dev_attrs[] = {
 	&dev_attr_driver_override.attr,
 	NULL,
 };
-ATTRIBUTE_GROUPS(cdx_dev);
+
+static const struct attribute_group cdx_dev_group = {
+	.attrs = cdx_dev_attrs,
+	.is_visible = cdx_dev_attrs_are_visible,
+};
+
+static const struct attribute_group *cdx_dev_groups[] = {
+	&cdx_dev_group,
+	NULL,
+};
 
 static ssize_t rescan_store(const struct bus_type *bus,
 			    const char *buf, size_t count)
@@ -479,7 +509,6 @@ static void cdx_device_release(struct device *dev)
 int cdx_device_add(struct cdx_dev_params *dev_params)
 {
 	struct cdx_controller *cdx = dev_params->cdx;
-	struct device *parent = cdx->dev;
 	struct cdx_device *cdx_dev;
 	int ret;
 
@@ -503,7 +532,7 @@ int cdx_device_add(struct cdx_dev_params *dev_params)
 
 	/* Initialize generic device */
 	device_initialize(&cdx_dev->dev);
-	cdx_dev->dev.parent = parent;
+	cdx_dev->dev.parent = dev_params->parent;
 	cdx_dev->dev.bus = &cdx_bus_type;
 	cdx_dev->dev.dma_mask = &cdx_dev->dma_mask;
 	cdx_dev->dev.release = cdx_device_release;
@@ -532,6 +561,42 @@ int cdx_device_add(struct cdx_dev_params *dev_params)
 }
 EXPORT_SYMBOL_NS_GPL(cdx_device_add, CDX_BUS_CONTROLLER);
 
+struct device *cdx_bus_add(struct cdx_controller *cdx, u8 bus_num)
+{
+	struct cdx_device *cdx_dev;
+	int ret;
+
+	cdx_dev = kzalloc(sizeof(*cdx_dev), GFP_KERNEL);
+	if (!cdx_dev)
+		return NULL;
+
+	device_initialize(&cdx_dev->dev);
+	cdx_dev->cdx = cdx;
+
+	cdx_dev->dev.parent = cdx->dev;
+	cdx_dev->dev.bus = &cdx_bus_type;
+	cdx_dev->dev.release = cdx_device_release;
+	cdx_dev->is_bus = true;
+	cdx_dev->bus_num = bus_num;
+
+	dev_set_name(&cdx_dev->dev, "cdx-%02x",
+		     ((cdx->id << CDX_CONTROLLER_ID_SHIFT) | (bus_num & CDX_BUS_NUM_MASK)));
+
+	ret = device_add(&cdx_dev->dev);
+	if (ret) {
+		dev_err(&cdx_dev->dev, "cdx bus device add failed: %d\n", ret);
+		goto device_add_fail;
+	}
+
+	return &cdx_dev->dev;
+
+device_add_fail:
+	put_device(&cdx_dev->dev);
+
+	return NULL;
+}
+EXPORT_SYMBOL_NS_GPL(cdx_bus_add, CDX_BUS_CONTROLLER);
+
 int cdx_register_controller(struct cdx_controller *cdx)
 {
 	int ret;
diff --git a/drivers/cdx/cdx.h b/drivers/cdx/cdx.h
index c436ac7ac86f..1f593deb4c9e 100644
--- a/drivers/cdx/cdx.h
+++ b/drivers/cdx/cdx.h
@@ -13,7 +13,7 @@
 /**
  * struct cdx_dev_params - CDX device parameters
  * @cdx: CDX controller associated with the device
- * @parent: Associated CDX controller
+ * @parent: Associated CDX Bus device
  * @vendor: Vendor ID for CDX device
  * @device: Device ID for CDX device
  * @bus_num: Bus number for this CDX device
@@ -24,6 +24,7 @@
  */
 struct cdx_dev_params {
 	struct cdx_controller *cdx;
+	struct device *parent;
 	u16 vendor;
 	u16 device;
 	u8 bus_num;
@@ -59,4 +60,15 @@ void cdx_unregister_controller(struct cdx_controller *cdx);
  */
 int cdx_device_add(struct cdx_dev_params *dev_params);
 
+/**
+ * cdx_bus_add - Add a CDX bus. This function adds a bus on the CDX bus
+ *		subsystem. It creates a CDX device for the corresponding bus and
+ *		also registers an associated Linux generic device.
+ * @cdx: Associated CDX controller
+ * @us_num: Bus number
+ *
+ * Return: associated Linux generic device pointer on success or NULL on failure.
+ */
+struct device *cdx_bus_add(struct cdx_controller *cdx, u8 bus_num);
+
 #endif /* _CDX_H_ */
diff --git a/drivers/cdx/controller/cdx_controller.c b/drivers/cdx/controller/cdx_controller.c
index 3f86663fbacf..b4e0d6b40339 100644
--- a/drivers/cdx/controller/cdx_controller.c
+++ b/drivers/cdx/controller/cdx_controller.c
@@ -79,8 +79,14 @@ static int cdx_scan_devices(struct cdx_controller *cdx)
 	num_cdx_bus = (u8)ret;
 
 	for (bus_num = 0; bus_num < num_cdx_bus; bus_num++) {
+		struct device *bus_dev;
 		u8 num_cdx_dev;
 
+		/* Add the bus on cdx subsystem */
+		bus_dev = cdx_bus_add(cdx, bus_num);
+		if (!bus_dev)
+			continue;
+
 		/* MCDI FW Read: Fetch the number of devices present */
 		ret = cdx_mcdi_get_num_devs(cdx_mcdi, bus_num);
 		if (ret < 0) {
@@ -103,6 +109,7 @@ static int cdx_scan_devices(struct cdx_controller *cdx)
 				continue;
 			}
 			dev_params.cdx = cdx;
+			dev_params.parent = bus_dev;
 
 			/* Add the device to the cdx bus */
 			ret = cdx_device_add(&dev_params);
diff --git a/include/linux/cdx/cdx_bus.h b/include/linux/cdx/cdx_bus.h
index 82c27b8c94e1..b5e4b7e05666 100644
--- a/include/linux/cdx/cdx_bus.h
+++ b/include/linux/cdx/cdx_bus.h
@@ -88,6 +88,7 @@ struct cdx_controller {
  * @dma_mask: Default DMA mask
  * @flags: CDX device flags
  * @req_id: Requestor ID associated with CDX device
+ * @is_bus: Is this bus device
  * @driver_override: driver name to force a match; do not set directly,
  *                   because core frees it; use driver_set_override() to
  *                   set or clear it.
@@ -104,6 +105,7 @@ struct cdx_device {
 	u64 dma_mask;
 	u16 flags;
 	u32 req_id;
+	bool is_bus;
 	const char *driver_override;
 };
 
-- 
2.34.1

