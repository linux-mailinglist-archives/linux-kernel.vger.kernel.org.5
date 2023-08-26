Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45A07893E4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 06:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjHZExo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 00:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbjHZExK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 00:53:10 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED9A128
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 21:53:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FnzlaIdnndE+LvBSCwwZMsxsL6GnHRsLmLN+REiR7+8Nc6bh4XW75IaKJGYnVXCFOKAlYaIo03i4HUHQfB7u1xD7ZwVydMvq2VdzXNnzLS8peQjnYyotxlTPsl7bgScJqsB98j6niLm7QMJE5AI1v7NzFMRPxaytUL2UdJbISo/6SIX9pg94DGKWDiwjFu4woVVFy4lq3h7+ihQ1yskrMM0Gz3lNJlu+F2GXRYkKTTcu6OX6IbEKcSjLr4BDhaX5gbtp83HcLpxc3MjgFkdK+XRnKF4GBWqrbJ2L7HbTq3lcWUqKVcClw9U2YETV5mEKTToltUG4EJYRIVSlVAdnXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPvxb4l5Ts8zuME4soRP/ClYcqmuXe6+FESEoKvOPVQ=;
 b=Cp88pjc+0VjzLQ5O9Sx8IG+fkxYeyct8CXSdB0kdQYvvd012Vc7DnuPM53SiIwdoNG61qKRGXSTnZGJUaWXM436LWSDTygQtfqwmueqttF4s6XAnYsvPCflkgHRns87E3P78boVdM4fhV8aof3cGDUcEU4jMZx/DfKfmLuIVm9rad5s3Per3g8MXzj4cGiy1hKGhFCEZt1Vkaoshf0ZZy/shas5OO/WZzxXzTgGJ5yNpzzMAZWsM/fJYinCsKoWgySu4v3pecqO0bAin6hY4wyp4GzGwTB951l7z5P1rw6tdiiCxLEcYZSJ5dFyY5CZzlDZpqgMMvTECxxwVAJkIiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPvxb4l5Ts8zuME4soRP/ClYcqmuXe6+FESEoKvOPVQ=;
 b=Ew8xLFE5Idkjv45x76a+tmLTqxVTOQujX64XI/GlnWEDLGQO/pPB/TGugQHrOFxYwKVTqdF467N6yOKBiUqf12R3B9OqjKK5kswnwetWpQhTxKOOpSGUgqIDP337HceFsdNXl1v1GsGrjaFs8In+mDUdkncderf7Q974HLrYplY=
Received: from CY5PR04CA0023.namprd04.prod.outlook.com (2603:10b6:930:1e::30)
 by LV3PR12MB9142.namprd12.prod.outlook.com (2603:10b6:408:198::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Sat, 26 Aug
 2023 04:53:03 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:930:1e:cafe::4a) by CY5PR04CA0023.outlook.office365.com
 (2603:10b6:930:1e::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30 via Frontend
 Transport; Sat, 26 Aug 2023 04:53:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Sat, 26 Aug 2023 04:53:03 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 23:53:02 -0500
Received: from xhdipdslab59.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 25 Aug 2023 23:52:54 -0500
From:   Abhijit Gangurde <abhijit.gangurde@amd.com>
To:     <gregkh@linuxfoundation.org>, <masahiroy@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Nipun.Gupta@amd.com>, <nikhil.agarwal@amd.com>,
        <puneet.gupta@amd.com>, <git@amd.com>, <michal.simek@amd.com>,
        Abhijit Gangurde <abhijit.gangurde@amd.com>,
        Nipun Gupta <nipun.gupta@amd.com>,
        "Pieter Jansen van Vuuren" <pieter.jansen-van-vuuren@amd.com>
Subject: [PATCH v4 5/5] cdx: add sysfs for subsystem, class and revision
Date:   Sat, 26 Aug 2023 10:19:44 +0530
Message-ID: <20230826044944.4161017-6-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230826044944.4161017-1-abhijit.gangurde@amd.com>
References: <20230826044944.4161017-1-abhijit.gangurde@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|LV3PR12MB9142:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b0cc02a-ba52-4131-d82e-08dba5f05489
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AZnORRoZbZyFQq6Jtm9F8plkJSS0qTeHr0jvclN6ZTAYTcT02L3fhOFG/N/PtcDIVyv6F4pJSL3hdbubH3lgDRtiytNc+wyH95FhNrhZ0VflM1vu7JIDpjAEggVehIZhCqZy3PhsC5iKSy2gxBq/HDGIsPyTCGlnD1Dmg6MJAOeBkG3xywXV9C1FNALtGMCe73yJt9Xgy02TcXkJdGY6zShVWGR9AEW1/BZTc4hrR5bhNg0DPIla3KBGhlpOG73Jkm5ShIClr1ETrblotsHMHfGG3zl7jbczAMC3R+uCZ5bdIopmjCIw6DraLMsN+XQ7JC3l6IlWrHlpsGGCWnOqwJWjrpUE5GFHiaoFasiNR1vSHSUjMRKLk02Dq4OXViG9fNPDTwmZnop8mSUta+GpBHjFYsMGTRN3euNDB7AC5tI8CJU7C5jLFipkBTe9BGNT9OBl2MhhsEJv/Zq/+bhgtKoYfgdv/S0T9Bhk1xkZzJAPDYTXDaOmVa56Yop/Ih73CC28mJ/m0KyJUzwOocmlJsbBfZj9OjPdI3Pu8ESys/5JPHC4bkrgh8gibuwrRWe0mLEYkPq/LuAMsZTAON4N3hfPIWKggGTU+TdYHZBwJDPAGGkVkI4BMFrmUyOBtifDXNjTwoTH6C/mrlJ1WwUChCZ7F8knp4884Oktg4KcJeWxqFxluSt7BY3LweAkaiHxwvt9598oZ3xE7QX5aOz0XIfVgdx3cAVjhwmbJDeLBwRJKbRzqvJI59pTujW8KpyX2A3ClmG6VxDzroybjOTRGg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(1800799009)(451199024)(82310400011)(186009)(46966006)(36840700001)(40470700004)(82740400003)(81166007)(356005)(40460700003)(8676002)(4326008)(8936002)(54906003)(41300700001)(316002)(6666004)(36756003)(70586007)(70206006)(86362001)(110136005)(40480700001)(47076005)(26005)(478600001)(336012)(36860700001)(1076003)(44832011)(83380400001)(2906002)(30864003)(2616005)(426003)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2023 04:53:03.1173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b0cc02a-ba52-4131-d82e-08dba5f05489
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9142
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
 Changes in v4:
 - None

 Changes in v3:
 - None

 Changes in v2:
 - Improve documentation and commit message

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
index 7687b9371210..b7d5e1a3b410 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -181,7 +181,10 @@ cdx_match_one_device(const struct cdx_device_id *id,
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
@@ -327,6 +330,10 @@ static DEVICE_ATTR_RO(field)
 
 cdx_config_attr(vendor, "0x%04x\n");
 cdx_config_attr(device, "0x%04x\n");
+cdx_config_attr(subsystem_vendor, "0x%04x\n");
+cdx_config_attr(subsystem_device, "0x%04x\n");
+cdx_config_attr(revision, "0x%02x\n");
+cdx_config_attr(class, "0x%06x\n");
 
 static ssize_t remove_store(struct device *dev,
 			    struct device_attribute *attr,
@@ -372,6 +379,17 @@ static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
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
@@ -403,6 +421,11 @@ static struct attribute *cdx_dev_attrs[] = {
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
@@ -634,6 +657,10 @@ int cdx_device_add(struct cdx_dev_params *dev_params)
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
index ac715bc84315..245ef7e26d5d 100644
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
@@ -92,6 +107,10 @@ struct cdx_controller {
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
@@ -109,6 +128,10 @@ struct cdx_device {
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

