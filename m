Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A177893E2
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 06:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbjHZExN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 00:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbjHZEw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 00:52:58 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2042.outbound.protection.outlook.com [40.107.95.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3F2128
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 21:52:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IFXRKWNlUYFf7Y6U/1wXr86jF8UwaGzVj4p9O48DokX4euEGMnRHoDQj0FyucaniB2/5kJ7hhZ/5uUQkEn6rCnmI7m4WlH+HCfJtZ/s7t0g9EckHrg1xyVxQyw0RP/WU6GhGy5rzKfXpDRNt7vgHBaZFOQ5zx69BsSbcSSv5KJQQfQBoj7GgaKwHW+5pT8k/dWmS2wf/BjF6ea67LpnZLFJqDlGxe/aGyxnj0Vj37F5to6EdeuO3eNvAdAknGEpxkWu1mdcuY+UvYXBayT61bWqZ+JXJI075k22WZluqiAYivkQ7zziULCNZ6oOyaW4jG+BLgRJvn1B2FfDojjMYvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZETCDN1zxWuzsgQ2+mQdkzAQPjI0E8IlyLi3MIwZ/fc=;
 b=UrUq1FnuILzi4VBuVKqrrPaiK8JFH8R9zaG8f3vyYPih9Je5RFLoycxFe2sGFGzLij9QFKW9R0BfvEn4UiV6+UP7O4IAP43KPJfiPkvEFeSvr+hwLc+YQUZ4m0Ip07r9sPraUnFrlIcDrQPmQluEK1wOZ3OYoSOPFpd+pjN/iA61+kHDwijzPw+0b+HNtP4upc1Ot0E+5jJWV2d5Da8/ycpjSiWzKYsD8lBUsUzklUkxsmI/VWWCtsjrO0zu22z953rlPTmwt5jw6azVNljecvyuPOL5nLJbWNCX9aM+fMIpL1euDZ2GpeCwtTnoI34/gsP65cN/Mvg4RLwCGIDWcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZETCDN1zxWuzsgQ2+mQdkzAQPjI0E8IlyLi3MIwZ/fc=;
 b=MMo6vtoWeRgrE9aexeG5EdDbfbK0hCiKm8HmCvdlV4oiYa9xbGq+d2hVey06/e5mTM5tTwAUUuQqnGLGv19E/J2hy+WM9B1Bn0slJLMwjxp2I125jKoqymiot7mqcJRPa3xZrlCvNymESO651MNQLZHsEWHSPMEIivWk5i0oNus=
Received: from CY5PR15CA0007.namprd15.prod.outlook.com (2603:10b6:930:14::13)
 by LV3PR12MB9093.namprd12.prod.outlook.com (2603:10b6:408:19d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30; Sat, 26 Aug
 2023 04:52:53 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:930:14:cafe::cc) by CY5PR15CA0007.outlook.office365.com
 (2603:10b6:930:14::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30 via Frontend
 Transport; Sat, 26 Aug 2023 04:52:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Sat, 26 Aug 2023 04:52:52 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 23:52:52 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 23:52:51 -0500
Received: from xhdipdslab59.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 25 Aug 2023 23:52:43 -0500
From:   Abhijit Gangurde <abhijit.gangurde@amd.com>
To:     <gregkh@linuxfoundation.org>, <masahiroy@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Nipun.Gupta@amd.com>, <nikhil.agarwal@amd.com>,
        <puneet.gupta@amd.com>, <git@amd.com>, <michal.simek@amd.com>,
        Abhijit Gangurde <abhijit.gangurde@amd.com>,
        Nipun Gupta <nipun.gupta@amd.com>,
        "Pieter Jansen van Vuuren" <pieter.jansen-van-vuuren@amd.com>
Subject: [PATCH v4 4/5] cdx: add sysfs for bus reset
Date:   Sat, 26 Aug 2023 10:19:43 +0530
Message-ID: <20230826044944.4161017-5-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230826044944.4161017-1-abhijit.gangurde@amd.com>
References: <20230826044944.4161017-1-abhijit.gangurde@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|LV3PR12MB9093:EE_
X-MS-Office365-Filtering-Correlation-Id: b4d7024c-e0f4-4cf6-0747-08dba5f04e70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RYsdICYb/B4+wOeijbELRfU4RDT7XYnctRpbNHGDRqsSdWEbTnbdkiS9ldSgoWLX3eVd8qYf8dKsJl8ayJIpOvk2VcrRXXxXXxd7MiEPCPirijPNJKyouDJzNTGWgJVNMJQTWLDohi4wKa7ewlk5IHzeA7ofRGYgld9O9/gRD44bEx9V88lSys+Ote29XS0fYj/B2sK5/CJvyTJxD8eW2UUw3YamN1Uh1SrpjUMr9YVoCkZZklS/nVUVAEERe8qlP4f6OZbcftQShzXNkc3P6CVdO8oG9DlojoirM+pq+J6kVq+uNL8jS7OUO38BJ9Q11OOHjAvr7eI+XQQvlt5CKIjJKSe5pPrsP/QtjyH1Q8IkRZRy9IZ7YqS5KLOvejCeQblcAc2pK839CY8tL8Ty55UXSKIuURru0v/++xFLhxNv/Abkxi4+Y+/oYP0h7i2pKzRy1SUPMhT5z3NWl7BA8z9VBbEPRWj4AAhK7tNofisz+QEtJFx2zXXlioQKcxcALDJQEyt6iCZaQXn3GbeGUxae1wnjzfFRrt4oj/41kxk6X96r5gg9NRY751jSd4140L/nAe31J0N7VIjpIEaqXksjFD8fiYU4DCa89MMub7VX12EcA3riVTO8e0NR1rxAH8Xw3C61WeHBKz/S2MiGZmqQSPqcil4oNj+7Q15f9TioSI7BKPoP0XO0y6ej2BX5gJ2pZIPsOCj/EPm+K3Ko6EDMdaI/upHCYEPSDe3KUplYLT/I/Au8MOHRCSbaovXJgUb7iJlZLE0Knd4/zVh9TA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(1800799009)(451199024)(82310400011)(186009)(36840700001)(46966006)(40470700004)(81166007)(82740400003)(356005)(40460700003)(8676002)(4326008)(8936002)(54906003)(41300700001)(316002)(36756003)(70586007)(70206006)(86362001)(110136005)(40480700001)(47076005)(26005)(478600001)(1076003)(44832011)(36860700001)(336012)(83380400001)(2906002)(2616005)(426003)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2023 04:52:52.8662
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4d7024c-e0f4-4cf6-0747-08dba5f04e70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9093
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sysfs interface reset to reset all the devices on the CDX bus.

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
 - Improve documentation
 - sysfs entry reset takes bus number as an argument

 Documentation/ABI/testing/sysfs-bus-cdx | 15 +++++++++
 drivers/cdx/cdx.c                       | 41 +++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cdx b/Documentation/ABI/testing/sysfs-bus-cdx
index 04c8dfe7e201..d25875359741 100644
--- a/Documentation/ABI/testing/sysfs-bus-cdx
+++ b/Documentation/ABI/testing/sysfs-bus-cdx
@@ -38,6 +38,21 @@ Description:
 
 		  # echo 00 > /sys/bus/cdx/disable
 
+What:		/sys/bus/cdx/reset
+Date:		July 2023
+Contact:	puneet.gupta@amd.com
+Description:
+		Writing bus number in hex to this file will attempt to reset
+		all the devices present on the bus. Resetting a device would
+		clear all existing configuration of the device and put the
+		device in default state. The bus number for the cdx devices can
+		be found at /sys/bus/cdx/devices/cdx-BB:DD, where BB denotes
+		the bus number for the respective device.
+
+		For example ::
+
+		  # echo 00 > /sys/bus/cdx/reset
+
 What:		/sys/bus/cdx/devices/.../vendor
 Date:		March 2023
 Contact:	nipun.gupta@amd.com
diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index 8da043756fa4..7687b9371210 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -114,6 +114,26 @@ int cdx_dev_reset(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(cdx_dev_reset);
 
+/**
+ * reset_cdx_device - Reset a CDX device
+ * @dev: CDX device
+ * @data: Bus number
+ *    If bus number matches to the device's bus then this device
+ *    is reset else this is no op.
+ *
+ * Return: -errno on failure, 0 on success.
+ */
+static int reset_cdx_device(struct device *dev, void *data)
+{
+	struct cdx_device *cdx_dev = to_cdx_device(dev);
+	u8 bus_num = *((u8 *)data);
+
+	if (cdx_dev->bus_num == bus_num)
+		return cdx_dev_reset(dev);
+
+	return 0;
+}
+
 /**
  * cdx_unregister_device - Unregister a CDX device
  * @dev: CDX device
@@ -520,10 +540,31 @@ static ssize_t rescan_store(const struct bus_type *bus,
 }
 static BUS_ATTR_WO(rescan);
 
+static ssize_t bus_reset_store(const struct bus_type *bus,
+			       const char *buf, size_t count)
+{
+	u8 bus_id;
+	int ret;
+
+	if (kstrtou8(buf, 16, &bus_id))
+		return -EINVAL;
+
+	bus_id = BUS_ID(bus_id);
+	mutex_lock(&cdx_controller_lock);
+	/* Reset all the devices attached to cdx bus */
+	ret = bus_for_each_dev(bus, NULL, (void *)&bus_id, reset_cdx_device);
+	mutex_unlock(&cdx_controller_lock);
+
+	return ret < 0 ? ret : count;
+}
+static struct bus_attribute bus_attr_reset =  __ATTR(reset, 0200, NULL,
+								bus_reset_store);
+
 static struct attribute *cdx_bus_attrs[] = {
 	&bus_attr_enable.attr,
 	&bus_attr_disable.attr,
 	&bus_attr_rescan.attr,
+	&bus_attr_reset.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(cdx_bus);
-- 
2.25.1

