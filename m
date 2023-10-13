Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786BA7C7D83
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 08:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjJMGKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 02:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjJMGKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 02:10:36 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D20F7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 23:10:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/94HXS1jJDs8HMyoUNP8gMc4mN3bwyZvBDvjJMobFqwfSnMtk0d/3FcGexQ/TEsufFnQRsCmpDZtJJaVuP5/ZpfPbqPFscVK7FoFa9DWlTRE47FOTAm8P8NZ81Em43DhnarKTykZbnPTzjAD4ZMK5PUYxbVOb3JP45U+EgMRKl4hjxCek33/Ng2GC/4FzeqJc5dRjpZEHe2g+C8u0flhosXQjHzrj8MK4RduVEfRXJkQqG3tyEVqVcjqe3zVX+CUVsAXxIopi/rn0G23fBTraOVhe0PCUaMJ7n8CT7h1H/9mvl2ffkYyGcpDfC9ro6qz1BoFEeP3lqZ8r5lMBFNmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OyfNZUnc/ArPxaff9x/aiveev08idKZ/LBl1Y4YLvsU=;
 b=EEGsGTna9r24PbjJ6bOHCKD0ErUkN5ARBynWK9bsrJEQ08lrl/tr40R6GRIZ2SV87TAY9kNlSAfJfRZ9MY+x//SG4d4mj7rHtrbkTy9+fPNqX5hqar/W2Ko9DVtJ2A4Ju1OfGws3ygDjrAit1KR2UJxW2tzX15O6648C087EvWO3PkiHe5jDMLpoxHy7m1rQWF3/eeAiD35/w5Z+IGJWxnxPF8n8fKFrtxBXJ1lLFAqUjOfrfRuhfsShawIRN74f8IjabglJ+z/VqzLYBkOIYoPlf9h4CMu9P7GFtR1VkoEUI9OdH5lkq52fJyqDyP/av7LgB9p9PdB0Cw29kDC8iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OyfNZUnc/ArPxaff9x/aiveev08idKZ/LBl1Y4YLvsU=;
 b=yDSAMIqqfSQPHmiAiGC/YGSzg+bQHHC6T5GZ2UTR4/XRRDQIZyrvdMAtuYw8EaLGnZLYiN1316q5uMczOwELQKHhL+tRzcgHYNtD8Gv3GTPzclW7iF80ydcaH4W5bCmYjvEIHRQf10lK8T3bRAn7RpQiQr2O5OjPb925/qKcJdg=
Received: from CY5PR22CA0040.namprd22.prod.outlook.com (2603:10b6:930:1d::16)
 by PH0PR12MB5450.namprd12.prod.outlook.com (2603:10b6:510:e8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Fri, 13 Oct
 2023 06:10:28 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:930:1d:cafe::3c) by CY5PR22CA0040.outlook.office365.com
 (2603:10b6:930:1d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.31 via Frontend
 Transport; Fri, 13 Oct 2023 06:10:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 06:10:28 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 01:10:03 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 23:10:02 -0700
Received: from xhdipdslab59.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 13 Oct 2023 01:09:55 -0500
From:   Abhijit Gangurde <abhijit.gangurde@amd.com>
To:     <gregkh@linuxfoundation.org>, <masahiroy@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Nipun.Gupta@amd.com>, <nikhil.agarwal@amd.com>,
        <puneet.gupta@amd.com>, <git@amd.com>, <michal.simek@amd.com>,
        Abhijit Gangurde <abhijit.gangurde@amd.com>,
        Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH v6 4/6] cdx: add support for bus enable and disable
Date:   Fri, 13 Oct 2023 11:38:48 +0530
Message-ID: <20231013060850.424929-5-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231013060850.424929-1-abhijit.gangurde@amd.com>
References: <20231013060850.424929-1-abhijit.gangurde@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|PH0PR12MB5450:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a23940c-27e6-4c8a-c876-08dbcbb31919
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IrDzJzo2zBp5gUnvmi1TCHC7Txgf3uzqN9rgBDWwtO5tfA1soGM3Hl4vewYpD90QIcwYGI7dd9ZS6V0wQtPXenS+GnIZELD2eRrm6OIEcDRcgOHLu4xImWq6URh3rHxreB9s/plxWsjh1/qBLqdA+bgpkEzbQ5zKaJVFmTP9BFAa89cRcCinz3mfuxov7tHn+aEtK6j+gtShstq7yPKXAIErVlKvC/mJjdYGO9VWJy9+NF7llRaYr6ZbTZ82sHbIbfQiBCOqSfc3gIn6TmHI42sTHv1JvC1mqiBAVa0OGY+KKSf3ua04XkLCcpKV+3E/RSj1MGwdcTFww8ah1YMjSNjAsxg3a8McyFpy7VCRODkKMD5m/+K9dZNVIdBJTVdKnrLTytiCA4B/GELoXe4jooFjHNhQ1YJ00HwPbfhz40UeG2wD82/kmsnh1xf0ncibJhBoeTbbBCyn8WU8dGwlgOLFLYshDfkv/A8sOBkSXJ4TpvIsmBrIx8RcWbU3r1ghUHfFA+m609p3YBnfeJhTyQ2gJPyZhY0HlIQivzydPL9NvKjouYuqf8KRsVAZSXLmlyq7b+cffEOwtKARj3Ab5hWkI6mocLQuhrpZ0OaaNhxS0IHUMtWH888vn8zqE0Q37yXXAex/LH16YlQKGSbvbFKaBk+yCDB+5jkTNH8ZQuTelqMqxoiMi+D2EvRqFX9mT8klEDoc8HrV1RR4qVt/FcpNZokyA4a8TMqDXZmV15/++bRx5mkt7MVNMISXCyXEWGXp9iOzc/Gr6HQ7brZluw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(82310400011)(40470700004)(36840700001)(46966006)(1076003)(2616005)(6666004)(82740400003)(36756003)(81166007)(40480700001)(40460700003)(86362001)(356005)(36860700001)(316002)(2906002)(30864003)(47076005)(336012)(44832011)(41300700001)(478600001)(426003)(4326008)(26005)(83380400001)(8936002)(5660300002)(70586007)(70206006)(8676002)(110136005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 06:10:28.2668
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a23940c-27e6-4c8a-c876-08dbcbb31919
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5450
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CDX bus needs to be disabled before updating/writing devices
in the FPGA. Once the devices are written, the bus shall be
rescanned. This change provides sysfs entry to enable/disable the
CDX bus.

Co-developed-by: Nipun Gupta <nipun.gupta@amd.com>
Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 Changes in v6:
 - Remove bus attributes enable and disable
 - Add enable attribute for cdx device visible only for bus device.

 Changes in v5:
 - Rebased on Linux 6.6

 Changes in v4:
 - Add sparse marking for lock around cdx_find_controller() function

 Changes in v3:
 - Use platform bus to locate controller

 Changes in v2:
 - Improve documentation
 - Split sysfs entry enable to enable and disable
 - sysfs entry enable and disable take bus number as an argument

 Documentation/ABI/testing/sysfs-bus-cdx | 13 +++++
 drivers/cdx/cdx.c                       | 72 +++++++++++++++++++++++++
 drivers/cdx/controller/cdx_controller.c | 12 +++++
 drivers/cdx/controller/mc_cdx_pcol.h    | 54 +++++++++++++++++++
 drivers/cdx/controller/mcdi_functions.c | 24 +++++++++
 drivers/cdx/controller/mcdi_functions.h | 18 +++++++
 include/linux/cdx/cdx_bus.h             | 10 ++++
 7 files changed, 203 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cdx b/Documentation/ABI/testing/sysfs-bus-cdx
index 7af477f49998..c12bdaa4152a 100644
--- a/Documentation/ABI/testing/sysfs-bus-cdx
+++ b/Documentation/ABI/testing/sysfs-bus-cdx
@@ -28,6 +28,19 @@ Description:
 		of a device manufacturer.
 		Combination of Vendor ID and Device ID identifies a device.
 
+What:		/sys/bus/cdx/devices/.../enable
+Date:		October 2023
+Contact:	abhijit.gangurde@amd.com
+Description:
+		CDX bus should be disabled before updating the devices in FPGA.
+		Writing n/0/off will attempt to disable the CDX bus and.
+		writing y/1/on will attempt to enable the CDX bus. Reading this file
+		gives the current state of the bus, 1 for enabled and 0 for disabled.
+
+		For example::
+
+		  # echo 1 > /sys/bus/cdx/.../enable
+
 What:		/sys/bus/cdx/devices/.../reset
 Date:		March 2023
 Contact:	nipun.gupta@amd.com
diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index 18da06e0babe..3d7bdd2647a3 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -124,9 +124,12 @@ static int cdx_unregister_device(struct device *dev,
 				 void *data)
 {
 	struct cdx_device *cdx_dev = to_cdx_device(dev);
+	struct cdx_controller *cdx = cdx_dev->cdx;
 
 	if (cdx_dev->is_bus) {
 		device_for_each_child(dev, NULL, cdx_unregister_device);
+		if (cdx_dev->enabled && cdx->ops->bus_disable)
+			cdx->ops->bus_disable(cdx, cdx_dev->bus_num);
 	} else {
 		kfree(cdx_dev->driver_override);
 		cdx_dev->driver_override = NULL;
@@ -383,6 +386,41 @@ static ssize_t driver_override_show(struct device *dev,
 }
 static DEVICE_ATTR_RW(driver_override);
 
+static ssize_t enable_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct cdx_device *cdx_dev = to_cdx_device(dev);
+	struct cdx_controller *cdx = cdx_dev->cdx;
+	bool enable;
+	int ret;
+
+	if (kstrtobool(buf, &enable) < 0)
+		return -EINVAL;
+
+	if (enable == cdx_dev->enabled)
+		return count;
+
+	if (enable && cdx->ops->bus_enable)
+		ret = cdx->ops->bus_enable(cdx, cdx_dev->bus_num);
+	else if (!enable && cdx->ops->bus_disable)
+		ret = cdx->ops->bus_disable(cdx, cdx_dev->bus_num);
+	else
+		ret = -EOPNOTSUPP;
+
+	if (!ret)
+		cdx_dev->enabled = enable;
+
+	return ret < 0 ? ret : count;
+}
+
+static ssize_t enable_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct cdx_device *cdx_dev = to_cdx_device(dev);
+
+	return sysfs_emit(buf, "%u\n", cdx_dev->enabled);
+}
+static DEVICE_ATTR_RW(enable);
+
 static umode_t cdx_dev_attrs_are_visible(struct kobject *kobj, struct attribute *a, int n)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -395,6 +433,18 @@ static umode_t cdx_dev_attrs_are_visible(struct kobject *kobj, struct attribute
 	return 0;
 }
 
+static umode_t cdx_bus_attrs_are_visible(struct kobject *kobj, struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct cdx_device *cdx_dev;
+
+	cdx_dev = to_cdx_device(dev);
+	if (cdx_dev->is_bus)
+		return a->mode;
+
+	return 0;
+}
+
 static struct attribute *cdx_dev_attrs[] = {
 	&dev_attr_remove.attr,
 	&dev_attr_reset.attr,
@@ -409,8 +459,19 @@ static const struct attribute_group cdx_dev_group = {
 	.is_visible = cdx_dev_attrs_are_visible,
 };
 
+static struct attribute *cdx_bus_dev_attrs[] = {
+	&dev_attr_enable.attr,
+	NULL,
+};
+
+static const struct attribute_group cdx_bus_dev_group = {
+	.attrs = cdx_bus_dev_attrs,
+	.is_visible = cdx_bus_attrs_are_visible,
+};
+
 static const struct attribute_group *cdx_dev_groups[] = {
 	&cdx_dev_group,
+	&cdx_bus_dev_group,
 	NULL,
 };
 
@@ -588,8 +649,19 @@ struct device *cdx_bus_add(struct cdx_controller *cdx, u8 bus_num)
 		goto device_add_fail;
 	}
 
+	if (cdx->ops->bus_enable) {
+		ret = cdx->ops->bus_enable(cdx, bus_num);
+		if (ret && ret != -EALREADY) {
+			dev_err(cdx->dev, "cdx bus enable failed: %d\n", ret);
+			goto bus_enable_fail;
+		}
+	}
+
+	cdx_dev->enabled = true;
 	return &cdx_dev->dev;
 
+bus_enable_fail:
+	device_del(&cdx_dev->dev);
 device_add_fail:
 	put_device(&cdx_dev->dev);
 
diff --git a/drivers/cdx/controller/cdx_controller.c b/drivers/cdx/controller/cdx_controller.c
index d1d4606f6c1a..b818f9815ea8 100644
--- a/drivers/cdx/controller/cdx_controller.c
+++ b/drivers/cdx/controller/cdx_controller.c
@@ -33,6 +33,16 @@ static const struct cdx_mcdi_ops mcdi_ops = {
 	.mcdi_request = cdx_mcdi_request,
 };
 
+static int cdx_bus_enable(struct cdx_controller *cdx, u8 bus_num)
+{
+	return cdx_mcdi_bus_enable(cdx->priv, bus_num);
+}
+
+static int cdx_bus_disable(struct cdx_controller *cdx, u8 bus_num)
+{
+	return cdx_mcdi_bus_disable(cdx->priv, bus_num);
+}
+
 void cdx_rpmsg_post_probe(struct cdx_controller *cdx)
 {
 	/* Register CDX controller with CDX bus driver */
@@ -128,6 +138,8 @@ static int cdx_scan_devices(struct cdx_controller *cdx)
 }
 
 static struct cdx_ops cdx_ops = {
+	.bus_enable		= cdx_bus_enable,
+	.bus_disable	= cdx_bus_disable,
 	.scan		= cdx_scan_devices,
 	.dev_configure	= cdx_configure_device,
 };
diff --git a/drivers/cdx/controller/mc_cdx_pcol.h b/drivers/cdx/controller/mc_cdx_pcol.h
index 4ccb7b52951b..2de019406b57 100644
--- a/drivers/cdx/controller/mc_cdx_pcol.h
+++ b/drivers/cdx/controller/mc_cdx_pcol.h
@@ -455,6 +455,60 @@
 #define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_REQUESTER_ID_OFST			84
 #define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_REQUESTER_ID_LEN			4
 
+/***********************************/
+/*
+ * MC_CMD_CDX_BUS_DOWN
+ * Asserting reset on the CDX bus causes all devices on the bus to be quiesced.
+ * DMA bus mastering is disabled and any pending DMA request are flushed. Once
+ * the response is returned, the devices are guaranteed to no longer issue DMA
+ * requests or raise MSI interrupts. Further device MMIO accesses may have
+ * undefined results. While the bus reset is asserted, any of the enumeration
+ * or device configuration MCDIs will fail with EAGAIN. It is only legal to
+ * reload the relevant PL region containing CDX devices if the corresponding CDX
+ * bus is in reset. Depending on the implementation, the firmware may or may
+ * not enforce this restriction and it is up to the caller to make sure this
+ * requirement is satisfied.
+ */
+#define MC_CMD_CDX_BUS_DOWN					0x4
+#define MC_CMD_CDX_BUS_DOWN_MSGSET			0x4
+
+/* MC_CMD_CDX_BUS_DOWN_IN msgrequest */
+#define MC_CMD_CDX_BUS_DOWN_IN_LEN			4
+/* Bus number to put in reset, in range 0 to BUS_COUNT-1 */
+#define MC_CMD_CDX_BUS_DOWN_IN_BUS_OFST		0
+#define MC_CMD_CDX_BUS_DOWN_IN_BUS_LEN		4
+
+/*
+ * MC_CMD_CDX_BUS_DOWN_OUT msgresponse: The bus is quiesced, no further
+ * upstream traffic for devices on this bus.
+ */
+#define MC_CMD_CDX_BUS_DOWN_OUT_LEN			0
+
+/***********************************/
+/*
+ * MC_CMD_CDX_BUS_UP
+ * After bus reset is de-asserted, devices are in a state which is functionally
+ * equivalent to each device having been reset with MC_CMD_CDX_DEVICE_RESET. In
+ * other words, device logic is reset in a hardware-specific way, MMIO accesses
+ * are forwarded to the device, DMA bus mastering is disabled and needs to be
+ * re-enabled with MC_CMD_CDX_DEVICE_DMA_ENABLE once the driver is ready to
+ * start servicing DMA. If the underlying number of devices or device resources
+ * changed (e.g. if PL was reloaded) while the bus was in reset, the bus driver
+ * is expected to re-enumerate the bus. Returns EALREADY if the bus was already
+ * up before the call.
+ */
+#define MC_CMD_CDX_BUS_UP					0x5
+#define MC_CMD_CDX_BUS_UP_MSGSET			0x5
+
+/* MC_CMD_CDX_BUS_UP_IN msgrequest */
+#define MC_CMD_CDX_BUS_UP_IN_LEN			4
+/* Bus number to take out of reset, in range 0 to BUS_COUNT-1 */
+#define MC_CMD_CDX_BUS_UP_IN_BUS_OFST		0
+#define MC_CMD_CDX_BUS_UP_IN_BUS_LEN		4
+
+/* MC_CMD_CDX_BUS_UP_OUT msgresponse: The bus can now be enumerated. */
+#define MC_CMD_CDX_BUS_UP_OUT_LEN			0
+
 /***********************************/
 /*
  * MC_CMD_CDX_DEVICE_RESET
diff --git a/drivers/cdx/controller/mcdi_functions.c b/drivers/cdx/controller/mcdi_functions.c
index 0158f26533dd..0e1e35d91242 100644
--- a/drivers/cdx/controller/mcdi_functions.c
+++ b/drivers/cdx/controller/mcdi_functions.c
@@ -124,6 +124,30 @@ int cdx_mcdi_get_dev_config(struct cdx_mcdi *cdx,
 	return 0;
 }
 
+int cdx_mcdi_bus_enable(struct cdx_mcdi *cdx, u8 bus_num)
+{
+	MCDI_DECLARE_BUF(inbuf, MC_CMD_CDX_BUS_UP_IN_LEN);
+	int ret;
+
+	MCDI_SET_DWORD(inbuf, CDX_BUS_UP_IN_BUS, bus_num);
+	ret = cdx_mcdi_rpc(cdx, MC_CMD_CDX_BUS_UP, inbuf, sizeof(inbuf),
+			   NULL, 0, NULL);
+
+	return ret;
+}
+
+int cdx_mcdi_bus_disable(struct cdx_mcdi *cdx, u8 bus_num)
+{
+	MCDI_DECLARE_BUF(inbuf, MC_CMD_CDX_BUS_DOWN_IN_LEN);
+	int ret;
+
+	MCDI_SET_DWORD(inbuf, CDX_BUS_DOWN_IN_BUS, bus_num);
+	ret = cdx_mcdi_rpc(cdx, MC_CMD_CDX_BUS_DOWN, inbuf, sizeof(inbuf),
+			   NULL, 0, NULL);
+
+	return ret;
+}
+
 int cdx_mcdi_reset_device(struct cdx_mcdi *cdx, u8 bus_num, u8 dev_num)
 {
 	MCDI_DECLARE_BUF(inbuf, MC_CMD_CDX_DEVICE_RESET_IN_LEN);
diff --git a/drivers/cdx/controller/mcdi_functions.h b/drivers/cdx/controller/mcdi_functions.h
index 7440ace5539a..28973d5ec3ab 100644
--- a/drivers/cdx/controller/mcdi_functions.h
+++ b/drivers/cdx/controller/mcdi_functions.h
@@ -47,6 +47,24 @@ int cdx_mcdi_get_dev_config(struct cdx_mcdi *cdx,
 			    u8 bus_num, u8 dev_num,
 			    struct cdx_dev_params *dev_params);
 
+/**
+ * cdx_mcdi_bus_enable - Enable CDX bus represented by bus_num
+ * @cdx: pointer to MCDI interface.
+ * @bus_num: Bus number.
+ *
+ * Return: 0 on success, <0 on failure
+ */
+int cdx_mcdi_bus_enable(struct cdx_mcdi *cdx, u8 bus_num);
+
+/**
+ * cdx_mcdi_bus_disable - Disable CDX bus represented by bus_num
+ * @cdx: pointer to MCDI interface.
+ * @bus_num: Bus number.
+ *
+ * Return: 0 on success, <0 on failure
+ */
+int cdx_mcdi_bus_disable(struct cdx_mcdi *cdx, u8 bus_num);
+
 /**
  * cdx_mcdi_reset_device - Reset cdx device represented by bus_num:dev_num
  * @cdx: pointer to MCDI interface.
diff --git a/include/linux/cdx/cdx_bus.h b/include/linux/cdx/cdx_bus.h
index b5e4b7e05666..18e95076d1d5 100644
--- a/include/linux/cdx/cdx_bus.h
+++ b/include/linux/cdx/cdx_bus.h
@@ -28,6 +28,10 @@ struct cdx_device_config {
 	u8 type;
 };
 
+typedef int (*cdx_bus_enable_cb)(struct cdx_controller *cdx, u8 bus_num);
+
+typedef int (*cdx_bus_disable_cb)(struct cdx_controller *cdx, u8 bus_num);
+
 typedef int (*cdx_scan_cb)(struct cdx_controller *cdx);
 
 typedef int (*cdx_dev_configure_cb)(struct cdx_controller *cdx,
@@ -49,11 +53,15 @@ typedef int (*cdx_dev_configure_cb)(struct cdx_controller *cdx,
 
 /**
  * struct cdx_ops - Callbacks supported by CDX controller.
+ * @bus_enable: enable bus on the controller
+ * @bus_disable: disable bus on the controller
  * @scan: scan the devices on the controller
  * @dev_configure: configuration like reset, master_enable,
  *		   msi_config etc for a CDX device
  */
 struct cdx_ops {
+	cdx_bus_enable_cb bus_enable;
+	cdx_bus_disable_cb bus_disable;
 	cdx_scan_cb scan;
 	cdx_dev_configure_cb dev_configure;
 };
@@ -89,6 +97,7 @@ struct cdx_controller {
  * @flags: CDX device flags
  * @req_id: Requestor ID associated with CDX device
  * @is_bus: Is this bus device
+ * @enabled: is this bus enabled
  * @driver_override: driver name to force a match; do not set directly,
  *                   because core frees it; use driver_set_override() to
  *                   set or clear it.
@@ -106,6 +115,7 @@ struct cdx_device {
 	u16 flags;
 	u32 req_id;
 	bool is_bus;
+	bool enabled;
 	const char *driver_override;
 };
 
-- 
2.34.1

