Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF8B7893E6
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 06:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjHZExJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 00:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbjHZEwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 00:52:41 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351C3128
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 21:52:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OqXEv9EInFwkHN8QjxAS5AEGg5X+Y22wV+V36Reosg+QDFgAzG2eUJpinWoEdH5FP/+178fVDHwMtBKIMLVuExIlNo+fCCeRICcDu4Bam6hI/WcD83dqRlgoJDruXtKrcrOqOKQ48MXySddQsPq/BFrNqbtzP0jZ1C6EScQkBqSGHAIohxlfTNI+gj+Czxt6vnDbiylrlZCTh+YTsB2tMsz18fwT3OciG4CZvsX2JJfciQXlTY5MRhtMY28Q+7/7htYHRwnwdJhVzYdQ3OAiLNJfs5DvLdigoMwowQXiD6BS07hTnkrsRO4CY5+YQ3rBThGe11/veJTBqXK8s2Y5eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwciXnO1pXo4dln6GTn9gw1Bnc9gtEBoBTQUraHsXik=;
 b=K+Wn72MPwY4rvYMuwV/UC9O5Omut9TjUsOL2MAIxMGf5E86PP3JITeXGMiCg3eK9bJApsFRhIP2z+PTeD8ehhNBqqhZC6CnRwbXerbh6gI7tBb0KQqDE1FlPIlj3d95KC+EZfZpEgn/FrJNDAu37Y6VGC15+MZUt8nKjpVL//zqQgSVq4ALkWvY6iSrT1mmiz9O+pb2fn7bqNDX7bRbMGkNuQoWZMsKhJCn5cMXPfrgAQCSZnVhoDe6OYaK5bHsHK/DOB930+BWs8gCf2nD4QKNfLp7Fd47mCWn/KQw9CxkfKE+0WZK4zUvxaGONBisdWAGP2FsfHDVrow+WA1wQhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwciXnO1pXo4dln6GTn9gw1Bnc9gtEBoBTQUraHsXik=;
 b=IoE9ZmZy+VRuz6B/PhJ2dHWPq+nPKFvc5Y1Kb645UxqrMi6OS4zqoHWb7VpaROmI+7+JHxQA4LlnF5lKUaTF4WbJ4v/ftxXEXoltyR0ge++eZMrEQ3hJy/vd9yu8kXulY3Tg7Yb5hiRychVOgttcWyVFykrodVQt/uKHZZa6enE=
Received: from CY5PR04CA0018.namprd04.prod.outlook.com (2603:10b6:930:1e::31)
 by MW3PR12MB4523.namprd12.prod.outlook.com (2603:10b6:303:5b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Sat, 26 Aug
 2023 04:52:33 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:930:1e:cafe::ba) by CY5PR04CA0018.outlook.office365.com
 (2603:10b6:930:1e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30 via Frontend
 Transport; Sat, 26 Aug 2023 04:52:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Sat, 26 Aug 2023 04:52:32 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 23:52:31 -0500
Received: from xhdipdslab59.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 25 Aug 2023 23:52:23 -0500
From:   Abhijit Gangurde <abhijit.gangurde@amd.com>
To:     <gregkh@linuxfoundation.org>, <masahiroy@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Nipun.Gupta@amd.com>, <nikhil.agarwal@amd.com>,
        <puneet.gupta@amd.com>, <git@amd.com>, <michal.simek@amd.com>,
        Abhijit Gangurde <abhijit.gangurde@amd.com>,
        Nipun Gupta <nipun.gupta@amd.com>,
        "Pieter Jansen van Vuuren" <pieter.jansen-van-vuuren@amd.com>
Subject: [PATCH v4 3/5] cdx: add support for bus enable and disable
Date:   Sat, 26 Aug 2023 10:19:42 +0530
Message-ID: <20230826044944.4161017-4-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230826044944.4161017-1-abhijit.gangurde@amd.com>
References: <20230826044944.4161017-1-abhijit.gangurde@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|MW3PR12MB4523:EE_
X-MS-Office365-Filtering-Correlation-Id: d361312d-0625-4359-4944-08dba5f0427d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zaRUd4IJvIquhrgqP9AxtoBZzp7g+i2jmYafChvDkCRY97tEvOe8pKMkozZuHiKkvTWrLWyBI5QbP3ue3RP36ZfxaGk7yvAhD2XX3x1N9qUSF+NieD+ucY845tJGb6Y3vFzmtr1rb0EIXEhV9ok8yGinuwoMwm61r2c23JPN/8Mqlg0juX7yT8XtH6U6E60Ix2rtajif3MW0juR5LG9/IsFJPtNEd1gG5Nf1NGgQ7T3SAwvxTvnBhRBe8jRS4w1RZbxOIiF+Nd3n0d/BMKxfR2Y3W+9KgVlwlsRj0kAhONS7vsisUCBGr9GjnyYBK4NQUHiwZXbr/yeKzNqleEKHQ6PZHRcknsWynEnbQO65ZqZVwwjZSMa6hqkMfs+B0YdaWcvn7+UvxaisncpnMcoXJg7QJq6JY2DpcJOxFvrD6ppPBi689WVkYteLBUlzKYFfisX1GuHJVt8qYm3g+PS25iqIen/gHse3ryDGK0PWYkDSLtZf/YF/7Di/u4kS5sU7SW41tOgwgFWPxHaOkBLu2t8DUcoDcWJf8Rs3ekm6+07zABsBGk/bARc4V8gfYd8houH1yHKzsrGma3/9Gr8BTliYhYsWH4mkA+O6Mj6cS3/uu8Y3xCYiz/6J3NSJEWXQ/gRWsg0Aq82ac6WunL3BiHzuNJlEk3AnMEDJGEsMzjWgzdvM/L44H5IPlNM3ZEYCYzb/VXLaH2vFMLARReG3izUnaQh4YfuWeFQ1L5Ki0bfAXke+YCjYW6kqp6Al41E5sZKeDs/prspk+fTCvHjTHQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(136003)(346002)(396003)(1800799009)(186009)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(40460700003)(6666004)(336012)(83380400001)(426003)(82740400003)(356005)(81166007)(86362001)(47076005)(36860700001)(36756003)(40480700001)(26005)(316002)(2616005)(54906003)(2906002)(110136005)(70206006)(70586007)(41300700001)(30864003)(8936002)(4326008)(8676002)(5660300002)(44832011)(1076003)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2023 04:52:32.8360
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d361312d-0625-4359-4944-08dba5f0427d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4523
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
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
Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
---
 Changes in v4:
 - Add sparse marking for lock around cdx_find_controller() function

 Changes in v3:
 - Use platform bus to locate controller

 Changes in v2:
 - Improve documentation
 - Split sysfs entry enable to enable and disable
 - sysfs entry enable and disable take bus number as an argument

 Documentation/ABI/testing/sysfs-bus-cdx | 27 +++++++
 drivers/cdx/cdx.c                       | 97 +++++++++++++++++++++++++
 drivers/cdx/controller/cdx_controller.c | 50 +++++++++++++
 drivers/cdx/controller/mc_cdx_pcol.h    | 54 ++++++++++++++
 drivers/cdx/controller/mcdi_functions.c | 24 ++++++
 drivers/cdx/controller/mcdi_functions.h | 18 +++++
 include/linux/cdx/cdx_bus.h             | 12 +++
 7 files changed, 282 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cdx b/Documentation/ABI/testing/sysfs-bus-cdx
index 7af477f49998..04c8dfe7e201 100644
--- a/Documentation/ABI/testing/sysfs-bus-cdx
+++ b/Documentation/ABI/testing/sysfs-bus-cdx
@@ -11,6 +11,33 @@ Description:
 
 		  # echo 1 > /sys/bus/cdx/rescan
 
+What:		/sys/bus/cdx/enable
+Date:		July 2023
+Contact:	nipun.gupta@amd.com
+Description:
+		Writing bus number in hex to this file will attempt to enable
+		the CDX bus. The bus number for the cdx devices can be found
+		at /sys/bus/cdx/devices/cdx-BB:DD, where BB denotes the bus
+		number for the respective device.
+
+		For example ::
+
+		  # echo 00 > /sys/bus/cdx/enable
+
+What:		/sys/bus/cdx/disable
+Date:		July 2023
+Contact:	nipun.gupta@amd.com
+Description:
+		Writing bus number in hex to this file will attempt to disable
+		the CDX bus. CDX bus should be disabled before updating the
+		devices in FPGA. The bus number for the cdx devices can be
+		found at /sys/bus/cdx/devices/cdx-BB:DD, where BB denotes the
+		bus number for the respective device.
+
+		For example ::
+
+		  # echo 00 > /sys/bus/cdx/disable
+
 What:		/sys/bus/cdx/devices/.../vendor
 Date:		March 2023
 Contact:	nipun.gupta@amd.com
diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index cbfe9a2f3646..8da043756fa4 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -70,6 +70,10 @@
 #define CDX_DEFAULT_DMA_MASK	(~0ULL)
 #define MAX_CDX_CONTROLLERS 16
 
+#define CONTROLLER_ID(X)	\
+	(((X) & CDX_CONTROLLER_ID_MASK) >> CDX_CONTROLLER_ID_SHIFT)
+#define BUS_ID(X) ((X) & CDX_BUS_NUM_MASK)
+
 /* IDA for CDX controllers registered with the CDX bus */
 static DEFINE_IDA(cdx_controller_ida);
 /* Lock to protect controller ops */
@@ -384,6 +388,97 @@ static struct attribute *cdx_dev_attrs[] = {
 };
 ATTRIBUTE_GROUPS(cdx_dev);
 
+/* Must be called with cdx_controller_lock acquired.
+ */
+static struct cdx_controller *cdx_find_controller(u8 controller_id)
+		__must_hold(&cdx_controller_lock)
+{
+	struct cdx_controller *cdx;
+	struct platform_device *pd;
+	struct device_node *np;
+
+	for_each_compatible_node(np, NULL, compat_node_name) {
+		if (!np)
+			return NULL;
+
+		pd = of_find_device_by_node(np);
+		if (!pd)
+			return NULL;
+
+		cdx = platform_get_drvdata(pd);
+		if (cdx && cdx->controller_registered && cdx->id == controller_id) {
+			put_device(&pd->dev);
+			return cdx;
+		}
+
+		put_device(&pd->dev);
+	}
+
+	return NULL;
+}
+
+static ssize_t enable_store(const struct bus_type *bus,
+			    const char *buf, size_t count)
+{
+	unsigned long controller_id;
+	struct cdx_controller *cdx;
+	u8 bus_id;
+	int ret;
+
+	if (kstrtou8(buf, 16, &bus_id))
+		return -EINVAL;
+
+	controller_id = CONTROLLER_ID(bus_id);
+	bus_id = BUS_ID(bus_id);
+
+	mutex_lock(&cdx_controller_lock);
+
+	cdx = cdx_find_controller(controller_id);
+	if (cdx)
+		if (cdx->ops->bus_enable)
+			ret = cdx->ops->bus_enable(cdx, bus_id);
+		else
+			ret = -EOPNOTSUPP;
+	else
+		ret = -EINVAL;
+
+	mutex_unlock(&cdx_controller_lock);
+
+	return ret < 0 ? ret : count;
+}
+static BUS_ATTR_WO(enable);
+
+static ssize_t disable_store(const struct bus_type *bus,
+			     const char *buf, size_t count)
+{
+	unsigned long controller_id;
+	struct cdx_controller *cdx;
+	u8 bus_id;
+	int ret;
+
+	if (kstrtou8(buf, 16, &bus_id))
+		return -EINVAL;
+
+	controller_id = CONTROLLER_ID(bus_id);
+	bus_id = BUS_ID(bus_id);
+
+	mutex_lock(&cdx_controller_lock);
+
+	cdx = cdx_find_controller(controller_id);
+	if (cdx)
+		if (cdx->ops->bus_disable)
+			ret = cdx->ops->bus_disable(cdx, bus_id);
+		else
+			ret = -EOPNOTSUPP;
+	else
+		ret = -EINVAL;
+
+	mutex_unlock(&cdx_controller_lock);
+
+	return ret < 0 ? ret : count;
+}
+static BUS_ATTR_WO(disable);
+
 static ssize_t rescan_store(const struct bus_type *bus,
 			    const char *buf, size_t count)
 {
@@ -426,6 +521,8 @@ static ssize_t rescan_store(const struct bus_type *bus,
 static BUS_ATTR_WO(rescan);
 
 static struct attribute *cdx_bus_attrs[] = {
+	&bus_attr_enable.attr,
+	&bus_attr_disable.attr,
 	&bus_attr_rescan.attr,
 	NULL,
 };
diff --git a/drivers/cdx/controller/cdx_controller.c b/drivers/cdx/controller/cdx_controller.c
index dc52f95f8978..2e4725c872d0 100644
--- a/drivers/cdx/controller/cdx_controller.c
+++ b/drivers/cdx/controller/cdx_controller.c
@@ -32,6 +32,42 @@ static const struct cdx_mcdi_ops mcdi_ops = {
 	.mcdi_request = cdx_mcdi_request,
 };
 
+static int cdx_bus_enable(struct cdx_controller *cdx, u8 bus_num)
+{
+	int ret;
+
+	if (test_bit(bus_num, cdx->bus_state))
+		return 0;
+
+	ret = cdx_mcdi_bus_enable(cdx->priv, bus_num);
+	if (!ret)
+		set_bit(bus_num, cdx->bus_state);
+
+	return ret;
+}
+
+static int cdx_bus_disable(struct cdx_controller *cdx, u8 bus_num)
+{
+	int ret;
+
+	if (!test_bit(bus_num, cdx->bus_state))
+		return 0;
+
+	ret = cdx_mcdi_bus_disable(cdx->priv, bus_num);
+	if (!ret)
+		clear_bit(bus_num, cdx->bus_state);
+
+	return ret;
+}
+
+static void cdx_bus_disable_all(struct cdx_controller *cdx)
+{
+	u8 bus_num;
+
+	for_each_set_bit(bus_num, cdx->bus_state, MAX_CDX_BUSES)
+		cdx_bus_disable(cdx, bus_num);
+}
+
 void cdx_rpmsg_post_probe(struct cdx_controller *cdx)
 {
 	/* Register CDX controller with CDX bus driver */
@@ -42,6 +78,7 @@ void cdx_rpmsg_post_probe(struct cdx_controller *cdx)
 void cdx_rpmsg_pre_remove(struct cdx_controller *cdx)
 {
 	cdx_unregister_controller(cdx);
+	cdx_bus_disable_all(cdx);
 	cdx_mcdi_wait_for_quiescence(cdx->priv, MCDI_RPC_TIMEOUT);
 }
 
@@ -80,11 +117,22 @@ static int cdx_scan_devices(struct cdx_controller *cdx)
 	for (bus_num = 0; bus_num < num_cdx_bus; bus_num++) {
 		u8 num_cdx_dev;
 
+		ret = cdx_bus_enable(cdx, bus_num);
+		if (ret && ret != -EALREADY) {
+			dev_err(cdx->dev,
+				"CDX bus %d enable failed: %d\n", bus_num, ret);
+			continue;
+		}
+
 		/* MCDI FW Read: Fetch the number of devices present */
 		ret = cdx_mcdi_get_num_devs(cdx_mcdi, bus_num);
 		if (ret < 0) {
 			dev_err(cdx->dev,
 				"Get devices on CDX bus %d failed: %d\n", bus_num, ret);
+			ret = cdx_bus_disable(cdx, bus_num);
+			if (ret)
+				dev_err(cdx->dev,
+					"CDX bus %d disable failed: %d\n", bus_num, ret);
 			continue;
 		}
 		num_cdx_dev = (u8)ret;
@@ -120,6 +168,8 @@ static int cdx_scan_devices(struct cdx_controller *cdx)
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
index 82c27b8c94e1..ac715bc84315 100644
--- a/include/linux/cdx/cdx_bus.h
+++ b/include/linux/cdx/cdx_bus.h
@@ -16,6 +16,8 @@
 #define MAX_CDX_DEV_RESOURCES	4
 #define CDX_CONTROLLER_ID_SHIFT 4
 #define CDX_BUS_NUM_MASK 0xF
+#define CDX_CONTROLLER_ID_MASK	0xF0
+#define MAX_CDX_BUSES			(CDX_BUS_NUM_MASK + 1)
 
 /* Forward declaration for CDX controller */
 struct cdx_controller;
@@ -28,6 +30,10 @@ struct cdx_device_config {
 	u8 type;
 };
 
+typedef int (*cdx_bus_enable_cb)(struct cdx_controller *cdx, u8 bus_num);
+
+typedef int (*cdx_bus_disable_cb)(struct cdx_controller *cdx, u8 bus_num);
+
 typedef int (*cdx_scan_cb)(struct cdx_controller *cdx);
 
 typedef int (*cdx_dev_configure_cb)(struct cdx_controller *cdx,
@@ -49,11 +55,15 @@ typedef int (*cdx_dev_configure_cb)(struct cdx_controller *cdx,
 
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
@@ -64,6 +74,7 @@ struct cdx_ops {
  * @priv: private data
  * @id: Controller ID
  * @controller_registered: controller registered with bus
+ * @bus_state: state of the buses(enabled/disabled)
  * @ops: CDX controller ops
  */
 struct cdx_controller {
@@ -71,6 +82,7 @@ struct cdx_controller {
 	void *priv;
 	u32 id;
 	bool controller_registered;
+	DECLARE_BITMAP(bus_state, MAX_CDX_BUSES);
 	struct cdx_ops *ops;
 };
 
-- 
2.25.1

