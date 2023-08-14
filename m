Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789C977B699
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 12:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234701AbjHNKYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 06:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235186AbjHNKYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:24:00 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2060.outbound.protection.outlook.com [40.107.102.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A45710F2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 03:23:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GO21fAWm6toJs95SxzoWI0FGhdSzzvxpatsu7YkLyb5ubtzTJj7Z7AgskPIRQNfPitfCjY2Zmnm1eEVWZNaL/PwpQh5fBbQW7D0Qhbo9mcGpzBdhpYUlXiZ9Lmcj1ZfNM9wmvgoWfA6E4E0YBBt+j5p6m4wyDEa1IEoA3hYev3Z2Ite4kXftIdOhFWPuC61Myqo7WThry1gPoPv+bYF6nw9hZJaUFRoPNufkmyOOiAi02gnMx817ip+HeOuz48R08+jfQlP7Sgeg8MnImuXrP3FojZavT9GA0dzaaF40ra1x2I3lWkMA1HkdkxLQqQno/Y1sYoIY8xJmSaug9+cyWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WfesIPXea56XQVifh1FWl/0Fwat6oQfFLTUz0hSARWo=;
 b=WMBWfIueCDsPJdter+2Lz/vu4WOeIWzfaVnGR5BronCxToLHOgMMlmORKKaalT7NfEMlaadAC7ZF8d3UlYG+rWBHUmHeNzagsQDgvlRVIyc6LN62kmgD+N4UwYI1xFMAvmCVmljvikM+Q2xTr9xJt8a4ZN0+zbMAAm8vbub+XbAhJAv8v74x10m52O79CeyUiNgcaUHgxZVfEKJ/LEsVRSlLQ0hDTMGDA1nFgkKEcwTwrom1WnpLUWENC1JvxSPMxjkpS0AvMPC1H4wF6OXqlcWoqhb36ZeiPL0gq5FamFRA3h/b0GOLfognnsDmlEN5EwOySEUWHkcrcWOQTlS/CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfesIPXea56XQVifh1FWl/0Fwat6oQfFLTUz0hSARWo=;
 b=VSw7SHgtR2Q67iVJgxi48MDxhqQ4qF0VuZX6zgPKbwEVwHciu+lggHoGeoAwij6L4ymIP7HCPWTdx92CIhQxAOk5br6lFR4TKwMDR6P5gWvSXRLRk5uCNYsWdsKjfC8bJ46vgj0jPu+uFPjMBgEs6L7tzEcRxsYM9a7gzzyvvy8=
Received: from CY5PR19CA0047.namprd19.prod.outlook.com (2603:10b6:930:1a::6)
 by MW4PR12MB7381.namprd12.prod.outlook.com (2603:10b6:303:219::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 10:23:50 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:930:1a:cafe::42) by CY5PR19CA0047.outlook.office365.com
 (2603:10b6:930:1a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Mon, 14 Aug 2023 10:23:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.12 via Frontend Transport; Mon, 14 Aug 2023 10:23:49 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 14 Aug
 2023 05:23:48 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 14 Aug
 2023 03:23:48 -0700
Received: from xhdipdslab59.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 14 Aug 2023 05:23:40 -0500
From:   Abhijit Gangurde <abhijit.gangurde@amd.com>
To:     <gregkh@linuxfoundation.org>, <masahiroy@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Nipun.Gupta@amd.com>, <nikhil.agarwal@amd.com>,
        <puneet.gupta@amd.com>, <git@amd.com>, <michal.simek@amd.com>,
        Abhijit Gangurde <abhijit.gangurde@amd.com>,
        Nipun Gupta <nipun.gupta@amd.com>,
        "Pieter Jansen van Vuuren" <pieter.jansen-van-vuuren@amd.com>
Subject: [PATCH v3 4/5] cdx: add sysfs for bus reset
Date:   Mon, 14 Aug 2023 15:52:22 +0530
Message-ID: <20230814102223.418046-5-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230814102223.418046-1-abhijit.gangurde@amd.com>
References: <20230814102223.418046-1-abhijit.gangurde@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|MW4PR12MB7381:EE_
X-MS-Office365-Filtering-Correlation-Id: a139f0c7-130c-4d4c-d53b-08db9cb08d22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VVl+DQFnbwu+VKCwghoswEdgMPN/AAt+9OJQKdKmFs8Hbukb4FRckbQVKPF9IldO1TXDH9RA6eKjANLyLWC+kFNrCO3GW6UQ79Lmvvvh7fP59x6yX5lG26Irtk1NyLTViisoj+WeZkKOpV0OVvNxmM3BSke2RkYA7gQfb4m9Hj3H4GilR5CpJu0lD0GbgVrOSrEWLJyYYrnDIswXtpppMs9mJLwylT15+NdQknQlT9QUuezm6KYGiTfRGjlx0VaSbhNzq8MnVlEo9CPEqvA//EWkM+Zf1ZeNEsp5c8rYfrivncLYfLAiIxC+5yHXYdaig64bAJ76W2W9KJzQa4JUdtXSG13rCTDutq9D+Ht0t212fYbLDTHBeP+dJGFvWIAxJ17eP0z5k2stOfn5Myrt7RuHXGVUiVejRqVDhiaMT8OTxuHvsrPlPqdnD4kVf/Oe/s3ERf+d13VENqFK6rR3auUgW7tFHtGdpaISQ4Fl+091KMiWX0TkKHvmhhFeFj3TwzlK/O2pUm+27w96Fv3HfpIj/WA2zifH6nXqYOPjVbueU+NShI8+W0NExmptz4zv7U3GLE0QYYfSo3LQKN8S9fK/Rd4665LlmSHzF+rjPtT6NcCFZE6K6gCb5EKXHq9FvAmGeoFNVBefxEr63jibyQ6fbC7gKrh6jTrzCjD92xuHGWSnzADRhGLnZHue+s0WuIsmM2wHgBJVDYUenwj9q6PKBmIUL5Mx4MLhGWtrf1JhGDw2PP7nkRZzJ/Fih+gqwZOhBjdlIJqYqki4MljJ9Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(39860400002)(82310400008)(451199021)(1800799006)(186006)(46966006)(40470700004)(36840700001)(40480700001)(54906003)(110136005)(6666004)(40460700003)(478600001)(81166007)(356005)(82740400003)(5660300002)(2906002)(36756003)(86362001)(44832011)(4326008)(70206006)(70586007)(41300700001)(8936002)(8676002)(316002)(336012)(1076003)(26005)(36860700001)(47076005)(83380400001)(2616005)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 10:23:49.8167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a139f0c7-130c-4d4c-d53b-08db9cb08d22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7381
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
index 411beb035fdd..6c48b322a8f2 100644
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
@@ -517,10 +537,31 @@ static ssize_t rescan_store(const struct bus_type *bus,
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

