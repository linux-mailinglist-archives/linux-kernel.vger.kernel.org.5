Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4E27CC861
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344312AbjJQQHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 12:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344086AbjJQQHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:07:41 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2055.outbound.protection.outlook.com [40.107.212.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2981BF1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:07:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chjp0DHyevhNoHYjwve8KS6Y+KMiu71iw5ONKCNcWthBS/p1XtsXlKjAlcpVN14MmvuwQkx3Ij/tF2zKsenGoDCHfmmIn2fB0xAH/VvEeT8+2wksKp8RDDmviF3EIQirO/1XrrIYWlD1nM8r/UPTasRu62lke1yjzy5epGHtCk2aKBk+n2K+Wa1tS8vuxM1RtALCe6ZLrkkJb2kuDJxksCob+GeAEVQA7dT9WyPLCE3Sm+dfBmjq0x5psmB5AL8BqhE9gP7KoGjBMFfNjqtCKCCvnNGk6ECupVo4oexloTn8ot3fv0Ibsa+fcwQSAdb/bqRCEddrQxCcsWTtE/Y40A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umz+4Rk6yawkyKXLyp6wAlQ2z2qafBWJd6be28L/WMw=;
 b=W0Y7nBW3K4vMoHNqCgpG/Ol4xEXh9xIlg70zk8Ee5EAYxtCXzcvyZBxRwXKFJqHQALSR8MDL9/n5ki6WnE0OmXKnmw8QoqYLUJXtp2+L42wXiB+syU3weoNVvlW8bi/4HFykZCdT/iwv8vGTRZuSr1iS9AsGgVjH3a5lnIBC12GmCc7sFYmsmfEHrJ9v+nCQOA0RsVjskXK308+Ut0bIZIYHJEk0tpNU9bBlMRgGO9C9vhVeyrpayGlFulieUUtCJIhZUNotw6gYOCygQ2xNvVe1YTR5ZjmNKO+z2uwEE3myCKwfR0n1Y4atmnNQvoZMNBIZ4W3B20/Yu1HrfBNn2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umz+4Rk6yawkyKXLyp6wAlQ2z2qafBWJd6be28L/WMw=;
 b=PyGL3BkHftRJVoYqeWJofgfMcKbqS5dVso+qhQZxEsWt0X+P/yaRyqO89QmhM8dAANK9bYlpyHGF2+gsouPSmpMSK/6Mdokpbtve1IFfXoaT6JgxypjJMquG+2p8kr/MAHoKIPZDI3w0V2UaGBuCBX33BmQWz6sb+f/pNsoP0Vs=
Received: from CY5P221CA0056.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:4::27) by
 CO6PR12MB5458.namprd12.prod.outlook.com (2603:10b6:5:35b::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.46; Tue, 17 Oct 2023 16:07:35 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:930:4:cafe::d2) by CY5P221CA0056.outlook.office365.com
 (2603:10b6:930:4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Tue, 17 Oct 2023 16:07:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 16:07:34 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 17 Oct
 2023 11:07:20 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 17 Oct
 2023 11:07:15 -0500
Received: from xhdipdslab59.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 17 Oct 2023 11:07:07 -0500
From:   Abhijit Gangurde <abhijit.gangurde@amd.com>
To:     <gregkh@linuxfoundation.org>, <masahiroy@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <puneet.gupta@amd.com>, <Nipun.Gupta@amd.com>,
        <nikhil.agarwal@amd.com>, <michal.simek@amd.com>, <git@amd.com>,
        Abhijit Gangurde <abhijit.gangurde@amd.com>,
        Nipun Gupta <nipun.gupta@amd.com>,
        "Pieter Jansen van Vuuren" <pieter.jansen-van-vuuren@amd.com>
Subject: [PATCH v7 7/7] cdx: add sysfs for subsystem, class and revision
Date:   Tue, 17 Oct 2023 21:35:05 +0530
Message-ID: <20231017160505.10640-8-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231017160505.10640-1-abhijit.gangurde@amd.com>
References: <20231017160505.10640-1-abhijit.gangurde@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|CO6PR12MB5458:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cce923d-176c-4a57-5595-08dbcf2b2d78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RKblKfX76RwhRY0rX61l+reIckcV48W8ZgXuRpNFy4L8vkwUq3lqZ/7c3SNFZL5jnLAelF6oBFKftzhZrJJlvLPvC/LWnQvr1R5K+DkxCuMZXB8eFycneMLX45hZIyorIqDz8EJ6bp7abvfrJgKI5CIqKLw222O7NU5R+nJc+9lbHl9q1AkMMe0pvqprwdJFS5+RI8TFEnA7kNND814NZyiSSK/+zZqFkSUXDXaeMO1sSw95S31wtYwTMpt+bFv1HadTVHxUOAPSZg5ylY3EcaS+tv2nBJ3hqYbtpnPk99Kc/xNrRvFa0W4uCrOVHFX+u3Y/qXExScT6xDzq+I2aqf+MB9CEjPDuDCHyCMDf6QCBMsWNfAuoFxSX/IwfvKjtPmev8XvavsLD2BJFXr75vRxkzHncy8tuhme3v0srQ3yusoxSEXnWX27GZzc0xHTmqaEUu7A2AEVo6pzU8Sfi6TlkuUjygQjPtNDokY+l/4gMcgxuv7N2kT3Q0D9kT+ncGwMTgr36Y0p6U7jgnKJW9szDBRV3FHnnw6wx79+20vQQY5ZCdJS+3TnYNugoGfTLz4Mr0snWX4mpeKxtt463wK+FzhmdNlJoskFAnmIlDALbJgQCSsnVvscU0hIZ9oVR5mO71skhG9FAbdKpeARHICIr/NVMV39DQvQrZrSzTh+7pNlwNpw4eZOtX45XE3oSwJzpu22UchHTvc7Go5ilOabSlANc3N6Qo73wKxhX21VotW/cB1xjEuWTwlER0vWMZ7aV6PzM7fm/hy3gNbtnqQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(136003)(376002)(230922051799003)(1800799009)(186009)(64100799003)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(83380400001)(8676002)(40460700003)(26005)(336012)(2616005)(40480700001)(81166007)(82740400003)(426003)(1076003)(356005)(41300700001)(4326008)(5660300002)(44832011)(30864003)(110136005)(36756003)(70586007)(8936002)(86362001)(54906003)(70206006)(316002)(2906002)(478600001)(36860700001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 16:07:34.9273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cce923d-176c-4a57-5595-08dbcf2b2d78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5458
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
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
 Changes in v7:
 - None

 Changes in v6:
 - None

 Changes in v5:
 - None

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
index c2c54abffed5..8c067ff99e54 100644
--- a/Documentation/ABI/testing/sysfs-bus-cdx
+++ b/Documentation/ABI/testing/sysfs-bus-cdx
@@ -28,6 +28,36 @@ Description:
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
 What:		/sys/bus/cdx/devices/.../enable
 Date:		October 2023
 Contact:	abhijit.gangurde@amd.com
@@ -67,3 +97,18 @@ Description:
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
index e22a7138292e..3dcda7513818 100644
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
@@ -329,6 +332,10 @@ static DEVICE_ATTR_RO(field)
 
 cdx_config_attr(vendor, "0x%04x\n");
 cdx_config_attr(device, "0x%04x\n");
+cdx_config_attr(subsystem_vendor, "0x%04x\n");
+cdx_config_attr(subsystem_device, "0x%04x\n");
+cdx_config_attr(revision, "0x%02x\n");
+cdx_config_attr(class, "0x%06x\n");
 
 static ssize_t remove_store(struct device *dev,
 			    struct device_attribute *attr,
@@ -377,6 +384,17 @@ static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
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
@@ -467,6 +485,11 @@ static struct attribute *cdx_dev_attrs[] = {
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
@@ -604,6 +627,10 @@ int cdx_device_add(struct cdx_dev_params *dev_params)
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
index 1f593deb4c9e..300ad8be7a34 100644
--- a/drivers/cdx/cdx.h
+++ b/drivers/cdx/cdx.h
@@ -16,22 +16,30 @@
  * @parent: Associated CDX Bus device
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
 	struct device *parent;
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
index 18e95076d1d5..cf9738e3a957 100644
--- a/include/linux/cdx/cdx_bus.h
+++ b/include/linux/cdx/cdx_bus.h
@@ -38,6 +38,19 @@ typedef int (*cdx_dev_configure_cb)(struct cdx_controller *cdx,
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
@@ -46,10 +59,12 @@ typedef int (*cdx_dev_configure_cb)(struct cdx_controller *cdx,
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
@@ -88,6 +103,10 @@ struct cdx_controller {
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
index 7056751c29b1..2b28faca9585 100644
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
2.34.1

