Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497677695B6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjGaMLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjGaMLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:11:16 -0400
Received: from outbound.mail.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6116110FD
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 05:11:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKGqR3n/vPL1AetOXMxPgZWwVLc8+CIzAGkez6OK+DsE7k2if3hNHWsCK9AItn6QhdbKD6DPWHb7kcRUjIs+i7EAzrfF4W1bJI3os4DGLNDwE5OwIT+04RchZh6H6d/8UbvblPr5VJdZDuMxTlrv2WwW96wD23R8NGmDZ2N95slEwTDWXnSQVxHlaqFskq0czhzP7dm8roXWYTko52kcVCa7Cdjxq2g27qd7d9ME4Sb5Z0GTuzxO9xYm2Xr3vIshXdFru8gEhC/bvRZoJU929Wa1+l4I/FT+Eu5rIuuEy5X5hVvpydhgDmQsAdEFY6cjoR9VahLi2O96NqC3xnykvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34m9eFsxdD5FjKksPu9wrcS1GjPWiGXy6bPKeTxxRfM=;
 b=Ud4XXsncrAklJZkmOUU1N/W5uc0R8Li9vp7rlS0Ml/haNtDYkurN9fThxiiBixsRvBI9dlf0+RIIL3kPyvb27cfK0tCmq5m6WtrFImzVFhl8Q+ln8MXNemZ+60sPckN6xA1andlZKRCr0rOXFlmNngONxOPi/jVtxKiyjo0iVimtCCwJQL4c0H0vxRbaZqrq4wnHUdnbJ6SuvssdhlWYLI9zkx4rY3OHeiA4+eh0xoBD9aR8syJJV/YXRGeHZ6RErIn/oxjeDpVZEUaKhYTqNs9hmyUKbmuO6Ol2aUn7YmAN6Tei50UdDND+M3rok+LSqyPf/79ClkAQgc51pPlxUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34m9eFsxdD5FjKksPu9wrcS1GjPWiGXy6bPKeTxxRfM=;
 b=Ws8Vq94IIxSHOfQ7jRXxdCGk+Z7z4LTNTo5MXFkLdTF+vOp9meZMdCA4saDISsAcqMu9PcsWGcb3Ybe3LMRZcx2IlCH0UiYEn+pd6l3fBCqaUpxQHnkfZKGKCjePQUGQZfQeSIUjSoYBMEri/+mkDA9vhdU4DEXWFFHVRvyx9sI=
Received: from BY3PR03CA0024.namprd03.prod.outlook.com (2603:10b6:a03:39a::29)
 by BN9PR12MB5049.namprd12.prod.outlook.com (2603:10b6:408:132::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 12:10:59 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::14) by BY3PR03CA0024.outlook.office365.com
 (2603:10b6:a03:39a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Mon, 31 Jul 2023 12:10:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.22 via Frontend Transport; Mon, 31 Jul 2023 12:10:58 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 07:10:57 -0500
Received: from xhdipdslab59.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 31 Jul 2023 07:10:49 -0500
From:   Abhijit Gangurde <abhijit.gangurde@amd.com>
To:     <gregkh@linuxfoundation.org>, <masahiroy@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <michal.simek@amd.com>, <git@amd.com>, <nikhil.agarwal@amd.com>,
        <Nipun.Gupta@amd.com>, Abhijit Gangurde <abhijit.gangurde@amd.com>,
        "Puneet Gupta" <puneet.gupta@amd.com>,
        Nipun Gupta <nipun.gupta@amd.com>,
        "Pieter Jansen van Vuuren" <pieter.jansen-van-vuuren@amd.com>
Subject: [PATCH v2 4/4] cdx: add sysfs for subsystem, class and revision
Date:   Mon, 31 Jul 2023 17:38:13 +0530
Message-ID: <20230731120813.123247-5-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230731120813.123247-1-abhijit.gangurde@amd.com>
References: <20230731120813.123247-1-abhijit.gangurde@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|BN9PR12MB5049:EE_
X-MS-Office365-Filtering-Correlation-Id: a3299d27-ecb8-4ed6-9eb5-08db91bf333e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YcHRoERDuLtkY++Jtb2Hh/rsxPW7ZrLaWlQAxua8MM5z195+gvGiJbt7hcYPbETOOjUUAbsO6YIrSGUfSsd4MdLgYtf1kU9By3yNhBSCBaKv5LivwaO3hl/UoimSXEmlwWijadKkGQ7UkaFr1LSr64tUPQkf4Uy+lRkMvwiKlgZDLkx5ZYX8FaijNAonkblzFcQEKG/XOjPyIixyzN8g8m7PN7A3GfpV1jBfNgT4U+MRBC7SQHB/N8foQCKNhiKYzsIzySbK4t8w92eZwzhEqpjm15PgqQotaLjrWOyOtXxRwb0daR6HoPB12Dlscx8z6naSgK0S9cT+4dId1YrY20rvAIdKtDCLQszbUD1+1JyQKao7m01dlOZdaFkz4ecIDnXII/naD74vb2sMQnOakjjDnbbyAd2zHemxkZmLBmBVwhRcZVV9ysr6GcJamgtkeyQf1yFuA+Ct46D5ULZDdsQtxCpSbzUf4JhzLt0Fu3IYb1vzQNqNYU3tu2nCVKIczG18x5yJEZjcKt8OFUUNWuOjMdbnytOjgFoRlucsi2i4hCOEjM3hmG0QpWWASRmnt+SrcJDbLKg4NN5Y2tpCmhSdPorLeD/7Y4IgPDxFqZpy5SNbcscoElSVOVCByVQG3DO7BL1KgCqdxgLxKb7h01hU0gTGFQPxd1dPdl310i+LUQo97CRlzFGMZunyyMF8XNDvZ3rv/ir+E6tqheN1c5AVRQq87sqtNLeIRW+qPiK+eF/+q5Rb9ZH+BZXsyei21YqwZsFPxbsT1wi1q4OeIw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(376002)(396003)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(47076005)(36860700001)(36756003)(40480700001)(40460700003)(2616005)(1076003)(26005)(83380400001)(186003)(336012)(426003)(44832011)(70206006)(70586007)(81166007)(356005)(54906003)(110136005)(82740400003)(86362001)(316002)(4326008)(5660300002)(8676002)(8936002)(41300700001)(2906002)(6666004)(478600001)(30864003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 12:10:58.5861
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3299d27-ecb8-4ed6-9eb5-08db91bf333e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5049
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CDX controller provides subsystem vendor, subsystem device, class and
revision info of the device along with vendor and device ID in native
endian format. CDX Bus system uses this information to bind the cdx
device to the cdx device driver.

Co-developed-by: Puneet Gupta <puneet.gupta@amd.com>
Signed-off-by: Puneet Gupta <puneet.gupta@amd.com>
Co-developed-by: Nipun Gupta <nipun.gupta@amd.com>
Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
---
 Documentation/ABI/testing/sysfs-bus-cdx | 45 +++++++++++++++++++++++++
 drivers/cdx/cdx.c                       | 29 +++++++++++++++-
 drivers/cdx/cdx.h                       |  8 +++++
 drivers/cdx/controller/mcdi_functions.c |  7 ++++
 include/linux/cdx/cdx_bus.h             | 27 +++++++++++++--
 include/linux/mod_devicetable.h         | 10 ++++++
 scripts/mod/devicetable-offsets.c       |  4 +++
 scripts/mod/file2alias.c                |  8 +++++
 8 files changed, 135 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cdx b/Documentation/ABI/testing/sysfs-bus-cdx
index d25875359741..e71a6daccfbe 100644
--- a/Documentation/ABI/testing/sysfs-bus-cdx
+++ b/Documentation/ABI/testing/sysfs-bus-cdx
@@ -70,6 +70,36 @@ Description:
 		of a device manufacturer.
 		Combination of Vendor ID and Device ID identifies a device.
 
+What:		/sys/bus/cdx/devices/.../subsystem_vendor
+Date:		July 2023
+Contact:	puneet.gupta@amd.com
+Description:
+		Subsystem Vendor ID for this CDX device, in hexadecimal.
+		Subsystem Vendor ID is 16 bit identifier specific to the
+		card manufacturer.
+
+What:		/sys/bus/cdx/devices/.../subsystem_device
+Date:		July 2023
+Contact:	puneet.gupta@amd.com
+Description:
+		Subsystem Device ID for this CDX device, in hexadecimal
+		Subsystem Device ID is 16 bit identifier specific to the
+		card manufacturer.
+
+What:		/sys/bus/cdx/devices/.../class
+Date:		July 2023
+Contact:	puneet.gupta@amd.com
+Description:
+		This file contains the class of the CDX device, in hexadecimal.
+		Class is 24 bit identifier specifies the functionality of the device.
+
+What:		/sys/bus/cdx/devices/.../revision
+Date:		July 2023
+Contact:	puneet.gupta@amd.com
+Description:
+		This file contains the revision field of the CDX device, in hexadecimal.
+		Revision is 8 bit revision identifier of the device.
+
 What:		/sys/bus/cdx/devices/.../reset
 Date:		March 2023
 Contact:	nipun.gupta@amd.com
@@ -96,3 +126,18 @@ Description:
 		For example::
 
 		  # echo 1 > /sys/bus/cdx/devices/.../remove
+
+What:		/sys/bus/cdx/devices/.../modalias
+Date:		July 2023
+Contact:	nipun.gupta@amd.com
+Description:
+		This attribute indicates the CDX ID of the device.
+		That is in the format:
+		cdx:vXXXXdXXXXsvXXXXsdXXXXcXXXXXX,
+		where:
+
+		    - vXXXX contains the vendor ID;
+		    - dXXXX contains the device ID;
+		    - svXXXX contains the subsystem vendor ID;
+		    - sdXXXX contains the subsystem device ID;
+		    - cXXXXXX contains the device class.
diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index 76219d35e321..806b2ed2af06 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -179,7 +179,10 @@ cdx_match_one_device(const struct cdx_device_id *id,
 {
 	/* Use vendor ID and device ID for matching */
 	if ((id->vendor == CDX_ANY_ID || id->vendor == dev->vendor) &&
-	    (id->device == CDX_ANY_ID || id->device == dev->device))
+	    (id->device == CDX_ANY_ID || id->device == dev->device) &&
+	    (id->subvendor == CDX_ANY_ID || id->subvendor == dev->subsystem_vendor) &&
+	    (id->subdevice == CDX_ANY_ID || id->subdevice == dev->subsystem_device) &&
+	    !((id->class ^ dev->class) & id->class_mask))
 		return id;
 	return NULL;
 }
@@ -325,6 +328,10 @@ static DEVICE_ATTR_RO(field)
 
 cdx_config_attr(vendor, "0x%04x\n");
 cdx_config_attr(device, "0x%04x\n");
+cdx_config_attr(subsystem_vendor, "0x%04x\n");
+cdx_config_attr(subsystem_device, "0x%04x\n");
+cdx_config_attr(revision, "0x%02x\n");
+cdx_config_attr(class, "0x%06x\n");
 
 static ssize_t remove_store(struct device *dev,
 			    struct device_attribute *attr,
@@ -370,6 +377,17 @@ static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_WO(reset);
 
+static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	struct cdx_device *cdx_dev = to_cdx_device(dev);
+
+	return sprintf(buf, "cdx:v%04Xd%04Xsv%04Xsd%04Xc%06X\n", cdx_dev->vendor,
+			cdx_dev->device, cdx_dev->subsystem_vendor, cdx_dev->subsystem_device,
+			cdx_dev->class);
+}
+static DEVICE_ATTR_RO(modalias);
+
 static ssize_t driver_override_store(struct device *dev,
 				     struct device_attribute *attr,
 				     const char *buf, size_t count)
@@ -401,6 +419,11 @@ static struct attribute *cdx_dev_attrs[] = {
 	&dev_attr_reset.attr,
 	&dev_attr_vendor.attr,
 	&dev_attr_device.attr,
+	&dev_attr_subsystem_vendor.attr,
+	&dev_attr_subsystem_device.attr,
+	&dev_attr_class.attr,
+	&dev_attr_revision.attr,
+	&dev_attr_modalias.attr,
 	&dev_attr_driver_override.attr,
 	NULL,
 };
@@ -599,6 +622,10 @@ int cdx_device_add(struct cdx_dev_params *dev_params)
 	cdx_dev->req_id = dev_params->req_id;
 	cdx_dev->vendor = dev_params->vendor;
 	cdx_dev->device = dev_params->device;
+	cdx_dev->subsystem_vendor = dev_params->subsys_vendor;
+	cdx_dev->subsystem_device = dev_params->subsys_device;
+	cdx_dev->class = dev_params->class;
+	cdx_dev->revision = dev_params->revision;
 	cdx_dev->bus_num = dev_params->bus_num;
 	cdx_dev->dev_num = dev_params->dev_num;
 	cdx_dev->cdx = dev_params->cdx;
diff --git a/drivers/cdx/cdx.h b/drivers/cdx/cdx.h
index c436ac7ac86f..d17b5a501e8d 100644
--- a/drivers/cdx/cdx.h
+++ b/drivers/cdx/cdx.h
@@ -16,21 +16,29 @@
  * @parent: Associated CDX controller
  * @vendor: Vendor ID for CDX device
  * @device: Device ID for CDX device
+ * @subsys_vendor: Sub vendor ID for CDX device
+ * @subsys_device: Sub device ID for CDX device
  * @bus_num: Bus number for this CDX device
  * @dev_num: Device number for this device
  * @res: array of MMIO region entries
  * @res_count: number of valid MMIO regions
  * @req_id: Requestor ID associated with CDX device
+ * @class: Class of the CDX Device
+ * @revision: Revision of the CDX device
  */
 struct cdx_dev_params {
 	struct cdx_controller *cdx;
 	u16 vendor;
 	u16 device;
+	u16 subsys_vendor;
+	u16 subsys_device;
 	u8 bus_num;
 	u8 dev_num;
 	struct resource res[MAX_CDX_DEV_RESOURCES];
 	u8 res_count;
 	u32 req_id;
+	u32 class;
+	u8 revision;
 };
 
 /**
diff --git a/drivers/cdx/controller/mcdi_functions.c b/drivers/cdx/controller/mcdi_functions.c
index 0e1e35d91242..65dca2aa1d3f 100644
--- a/drivers/cdx/controller/mcdi_functions.c
+++ b/drivers/cdx/controller/mcdi_functions.c
@@ -120,6 +120,13 @@ int cdx_mcdi_get_dev_config(struct cdx_mcdi *cdx,
 
 	dev_params->vendor = MCDI_WORD(outbuf, CDX_BUS_GET_DEVICE_CONFIG_OUT_VENDOR_ID);
 	dev_params->device = MCDI_WORD(outbuf, CDX_BUS_GET_DEVICE_CONFIG_OUT_DEVICE_ID);
+	dev_params->subsys_vendor = MCDI_WORD(outbuf,
+					      CDX_BUS_GET_DEVICE_CONFIG_OUT_SUBSYS_VENDOR_ID);
+	dev_params->subsys_device = MCDI_WORD(outbuf,
+					      CDX_BUS_GET_DEVICE_CONFIG_OUT_SUBSYS_DEVICE_ID);
+	dev_params->class = MCDI_DWORD(outbuf,
+				       CDX_BUS_GET_DEVICE_CONFIG_OUT_DEVICE_CLASS) & 0xFFFFFF;
+	dev_params->revision = MCDI_BYTE(outbuf, CDX_BUS_GET_DEVICE_CONFIG_OUT_DEVICE_REVISION);
 
 	return 0;
 }
diff --git a/include/linux/cdx/cdx_bus.h b/include/linux/cdx/cdx_bus.h
index f26b53884359..46ced2cb2291 100644
--- a/include/linux/cdx/cdx_bus.h
+++ b/include/linux/cdx/cdx_bus.h
@@ -40,6 +40,19 @@ typedef int (*cdx_dev_configure_cb)(struct cdx_controller *cdx,
 				    u8 bus_num, u8 dev_num,
 				    struct cdx_device_config *dev_config);
 
+/**
+ * CDX_DEVICE - macro used to describe a specific CDX device
+ * @vend: the 16 bit CDX Vendor ID
+ * @dev: the 16 bit CDX Device ID
+ *
+ * This macro is used to create a struct cdx_device_id that matches a
+ * specific device. The subvendor and subdevice fields will be set to
+ * CDX_ANY_ID.
+ */
+#define CDX_DEVICE(vend, dev) \
+	.vendor = (vend), .device = (dev), \
+	.subvendor = CDX_ANY_ID, .subdevice = CDX_ANY_ID
+
 /**
  * CDX_DEVICE_DRIVER_OVERRIDE - macro used to describe a CDX device with
  *                              override_only flags.
@@ -48,10 +61,12 @@ typedef int (*cdx_dev_configure_cb)(struct cdx_controller *cdx,
  * @driver_override: the 32 bit CDX Device override_only
  *
  * This macro is used to create a struct cdx_device_id that matches only a
- * driver_override device.
+ * driver_override device. The subvendor and subdevice fields will be set to
+ * CDX_ANY_ID.
  */
 #define CDX_DEVICE_DRIVER_OVERRIDE(vend, dev, driver_override) \
-	.vendor = (vend), .device = (dev), .override_only = (driver_override)
+	.vendor = (vend), .device = (dev), .subvendor = CDX_ANY_ID,\
+	.subdevice = CDX_ANY_ID, .override_only = (driver_override)
 
 /**
  * struct cdx_ops - Callbacks supported by CDX controller.
@@ -90,6 +105,10 @@ struct cdx_controller {
  * @cdx: CDX controller associated with the device
  * @vendor: Vendor ID for CDX device
  * @device: Device ID for CDX device
+ * @subsystem_vendor: Subsystem Vendor ID for CDX device
+ * @subsystem_device: Subsystem Device ID for CDX device
+ * @class: Class for the CDX device
+ * @revision: Revision of the CDX device
  * @bus_num: Bus number for this CDX device
  * @dev_num: Device number for this device
  * @res: array of MMIO region entries
@@ -107,6 +126,10 @@ struct cdx_device {
 	struct cdx_controller *cdx;
 	u16 vendor;
 	u16 device;
+	u16 subsystem_vendor;
+	u16 subsystem_device;
+	u32 class;
+	u8 revision;
 	u8 bus_num;
 	u8 dev_num;
 	struct resource res[MAX_CDX_DEV_RESOURCES];
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index b0678b093cb2..aa3c28781248 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -935,6 +935,12 @@ enum {
  * struct cdx_device_id - CDX device identifier
  * @vendor: Vendor ID
  * @device: Device ID
+ * @subvendor: Subsystem vendor ID (or CDX_ANY_ID)
+ * @subdevice: Subsystem device ID (or CDX_ANY_ID)
+ * @class: Device class
+ *         Most drivers do not need to specify class/class_mask
+ *         as vendor/device is normally sufficient.
+ * @class_mask: Limit which sub-fields of the class field are compared.
  * @override_only: Match only when dev->driver_override is this driver.
  *
  * Type of entries in the "device Id" table for CDX devices supported by
@@ -943,6 +949,10 @@ enum {
 struct cdx_device_id {
 	__u16 vendor;
 	__u16 device;
+	__u16 subvendor;
+	__u16 subdevice;
+	__u32 class;
+	__u32 class_mask;
 	__u32 override_only;
 };
 
diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-offsets.c
index abe65f8968dd..7a659aa3114a 100644
--- a/scripts/mod/devicetable-offsets.c
+++ b/scripts/mod/devicetable-offsets.c
@@ -265,6 +265,10 @@ int main(void)
 	DEVID(cdx_device_id);
 	DEVID_FIELD(cdx_device_id, vendor);
 	DEVID_FIELD(cdx_device_id, device);
+	DEVID_FIELD(cdx_device_id, subvendor);
+	DEVID_FIELD(cdx_device_id, subdevice);
+	DEVID_FIELD(cdx_device_id, class);
+	DEVID_FIELD(cdx_device_id, class_mask);
 	DEVID_FIELD(cdx_device_id, override_only);
 
 	return 0;
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 38120f932b0d..abc4781d5db7 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -1458,6 +1458,10 @@ static int do_cdx_entry(const char *filename, void *symval,
 {
 	DEF_FIELD(symval, cdx_device_id, vendor);
 	DEF_FIELD(symval, cdx_device_id, device);
+	DEF_FIELD(symval, cdx_device_id, subvendor);
+	DEF_FIELD(symval, cdx_device_id, subdevice);
+	DEF_FIELD(symval, cdx_device_id, class);
+	DEF_FIELD(symval, cdx_device_id, class_mask);
 	DEF_FIELD(symval, cdx_device_id, override_only);
 
 	switch (override_only) {
@@ -1475,6 +1479,10 @@ static int do_cdx_entry(const char *filename, void *symval,
 
 	ADD(alias, "v", vendor != CDX_ANY_ID, vendor);
 	ADD(alias, "d", device != CDX_ANY_ID, device);
+	ADD(alias, "sv", subvendor != CDX_ANY_ID, subvendor);
+	ADD(alias, "sd", subdevice != CDX_ANY_ID, subdevice);
+	ADD(alias, "c", class_mask == 0xFFFFFF, class);
+
 	return 1;
 }
 
-- 
2.25.1

