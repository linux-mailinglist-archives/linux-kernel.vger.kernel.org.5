Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F777695B2
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjGaMKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGaMK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:10:28 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3C310E7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 05:10:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKXaf1WJNfgn0Vl7wgFLQdYx/tB3t1SYanofIT2MBQLMyK4Jp3EkicVHfvVaHb0ccCEYs5Jkd7T187KDuSTW790qW3uz/7Jnd+uLJ6i9Vm5qTMCfnwG3muu4LGUBO/cOFIDqeMEDsuGaJdNMMmSZKdSEZesSFmuaL7F5HO6NCINf1/OYjwsBUbm9wR1F16tNUi/ULrJ1q9na1IsQwRKHi25CiddUO2J78kh3/IKSLCuwlxPk9+DGumYEUiO3CDp734GkixI3sB7qqmQlOIQvG6FUKjVRY7wiiVAkKM2bG6vChBqIK4tBOphCtyW+8kQ7+zb40UmyfzoxDsmbnPe8Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZomFaUQz5uBPrRS5hAQrKqRXYZbvw8npwBFNglX3YnE=;
 b=V7zrnav9xaVPjP/cjdYZ1P2apWfpmMwajOqNgjFxMM47OfjwVbcUbXE45/fp4n/qhnOSDXmH07z3ugfiQvoY711Y0q3V48ZERA4GSQQKyaJNSK9sFZdYZysFg4usMAroTBe3GroRQdg8aPvQ+F3kNmAIZd9sN2gzEgyUKDvN3idpvNyu8+UdYefI/b9WETKTsSUiUy2mkYc1Vcs5ogqUAZ6ebuKLUNzDDpLWqkmxjQ19utAMBrSjmUr511HPIKIc+dpN203T9h3oFZatq0Z1vczKM5Nhp4RHyOH6cJl/GD5/Qbxg0skSYlOqmfjeYxCoj2yF7w2mWpEH7ZZJn/cQVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZomFaUQz5uBPrRS5hAQrKqRXYZbvw8npwBFNglX3YnE=;
 b=0iXxKD35vjpMSFh7rIgpYhouU7YFMrq55ig5TfFLPWpWitxizfp9J+EDwDoqrjC+rzpEB0UeeigcYcFTyP031MBEVht/Utch/qvWUu3/fy3JjZ8C5vlLT2tNzPMgq6HOrWWKr938ZLqbPU4PgCFM1Tn9eWv0FUg1d5dH4b94XFs=
Received: from SJ0PR05CA0157.namprd05.prod.outlook.com (2603:10b6:a03:339::12)
 by CH2PR12MB4088.namprd12.prod.outlook.com (2603:10b6:610:a5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Mon, 31 Jul
 2023 12:10:20 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::20) by SJ0PR05CA0157.outlook.office365.com
 (2603:10b6:a03:339::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.12 via Frontend
 Transport; Mon, 31 Jul 2023 12:10:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.22 via Frontend Transport; Mon, 31 Jul 2023 12:10:20 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 07:10:19 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 05:10:19 -0700
Received: from xhdipdslab59.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 31 Jul 2023 07:10:11 -0500
From:   Abhijit Gangurde <abhijit.gangurde@amd.com>
To:     <gregkh@linuxfoundation.org>, <masahiroy@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <michal.simek@amd.com>, <git@amd.com>, <nikhil.agarwal@amd.com>,
        <Nipun.Gupta@amd.com>, Abhijit Gangurde <abhijit.gangurde@amd.com>,
        "Nipun Gupta" <nipun.gupta@amd.com>,
        Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Subject: [PATCH v2 2/4] cdx: add support for bus enable and disable
Date:   Mon, 31 Jul 2023 17:38:11 +0530
Message-ID: <20230731120813.123247-3-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230731120813.123247-1-abhijit.gangurde@amd.com>
References: <20230731120813.123247-1-abhijit.gangurde@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|CH2PR12MB4088:EE_
X-MS-Office365-Filtering-Correlation-Id: eea0278a-f035-4720-f8e5-08db91bf1c71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WLutJzCrgZnIPP4fuzyo6nNPGA4+f0RU21//BpWlxxZRyyB9dzLznWOOKuk45P2ufPhjuBu+slnp7+Wdtiye/n2A9w4Ah0lgfl3YkvBpgLISgLqTFRmn2zUFVJrCTpSL4tApmfclOD5yFB+STsTw1rGomP5YmPmM8XE70hDG0cLY+HyckVYtJTTP2UKSEf9konltrHtlgHMU0IL8+qmqRigzktE398ZWi5hk4u0dzuxDaPGgz1uQyBVOzoI6mYTBO4fYR4xvRtYtRtJ1kMqaM0Bgj7O1KNtSf4yMz4RbiWvt2lmETtP4SsSvGWzPBi66btQeD/x1/DQn5rydgoB1X2/YoSds1O5AM+qppDkKGq9toflSZMcqOIsh1DOyFE1HDooOc63tJVxNnlQSMb7PwdhpYxYjTLaJefF1QnazbxWOddOcuaLctdpeJaoorcyRgJuuytAzmLDVrAMb7vZvxoLMv8Xk+THhTSwbaiGSo1ELaa7d6L8OcwiTAnGHyAkAAwdYL6Jv4GmtqnfCBzy6NgrxuRrDjXQAS1kpKixQ1ui1nD0gBilfgbl6slrC1KKNStI9AXd9F58FstCoVHFcpSrQwg8lhpolaYXFFRg2/JWbrOe0qmwdnmqJLul4yokAm65W78ZObnQc0CNt4MCR0NtFAcRfKg/AxD0T4NZpa+UcO2AtK6ALyrxr9B4MBgT9VmxLmuLq3JnPeNKEyJefY77gNv28mXJyt8DKBkVsWqOS8P+zGJSt+2BENLI5EzHmLfXktiejL+BW8H/js5/k5g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(40460700003)(86362001)(40480700001)(36860700001)(47076005)(186003)(36756003)(2616005)(336012)(83380400001)(426003)(1076003)(26005)(81166007)(82740400003)(356005)(5660300002)(8676002)(41300700001)(8936002)(70206006)(70586007)(2906002)(30864003)(316002)(478600001)(110136005)(54906003)(4326008)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 12:10:20.3507
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eea0278a-f035-4720-f8e5-08db91bf1c71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4088
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
 Documentation/ABI/testing/sysfs-bus-cdx | 27 ++++++++++
 drivers/cdx/cdx.c                       | 72 +++++++++++++++++++++++++
 drivers/cdx/controller/cdx_controller.c | 50 +++++++++++++++++
 drivers/cdx/controller/mc_cdx_pcol.h    | 54 +++++++++++++++++++
 drivers/cdx/controller/mcdi_functions.c | 24 +++++++++
 drivers/cdx/controller/mcdi_functions.h | 18 +++++++
 include/linux/cdx/cdx_bus.h             | 12 +++++
 7 files changed, 257 insertions(+)

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
index 66797c8fe400..28c38cc4e4f6 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -70,6 +70,10 @@
 #define CDX_DEFAULT_DMA_MASK	(~0ULL)
 #define MAX_CDX_CONTROLLERS 16
 
+#define CONTROLLER_ID(X)	\
+	(((X) & CDX_CONTROLLER_ID_MASK) >> CDX_CONTROLLER_ID_SHIFT)
+#define BUS_ID(X) ((X) & CDX_BUS_NUM_MASK)
+
 /* CDX controllers registered with the CDX bus */
 static DEFINE_XARRAY_ALLOC(cdx_controllers);
 /* Lock to protect controller ops and controller list */
@@ -382,6 +386,72 @@ static struct attribute *cdx_dev_attrs[] = {
 };
 ATTRIBUTE_GROUPS(cdx_dev);
 
+static ssize_t enable_store(const struct bus_type *bus,
+			    const char *buf, size_t count)
+{
+	struct cdx_controller *cdx;
+	unsigned long controller_id;
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
+	cdx = xa_load(&cdx_controllers, controller_id);
+	if (!cdx) {
+		mutex_unlock(&cdx_controller_lock);
+		return -EINVAL;
+	}
+
+	if (cdx->ops->bus_disable)
+		ret = cdx->ops->bus_enable(cdx, bus_id);
+	else
+		ret = -EOPNOTSUPP;
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
+	struct cdx_controller *cdx;
+	unsigned long controller_id;
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
+	cdx = xa_load(&cdx_controllers, controller_id);
+	if (!cdx) {
+		mutex_unlock(&cdx_controller_lock);
+		return -EINVAL;
+	}
+
+	if (cdx->ops->bus_disable)
+		ret = cdx->ops->bus_disable(cdx, bus_id);
+	else
+		ret = -EOPNOTSUPP;
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
@@ -416,6 +486,8 @@ static ssize_t rescan_store(const struct bus_type *bus,
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
index bead71b7bc73..f26b53884359 100644
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
@@ -63,12 +73,14 @@ struct cdx_ops {
  * @dev: Linux device associated with the CDX controller.
  * @priv: private data
  * @id: Controller ID
+ * @bus_state: state of the buses(enabled/disabled)
  * @ops: CDX controller ops
  */
 struct cdx_controller {
 	struct device *dev;
 	void *priv;
 	u32 id;
+	DECLARE_BITMAP(bus_state, MAX_CDX_BUSES);
 	struct cdx_ops *ops;
 };
 
-- 
2.25.1

