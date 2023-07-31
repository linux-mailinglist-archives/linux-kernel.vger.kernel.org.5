Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2317695B5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjGaMLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbjGaMKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:10:55 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BBB19AB
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 05:10:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+xQ4aVRCKoL534zpePheM47g/YM43rk7cyHnFDDgdkUs/vhoTcHJ27ASt9NwXSfKq6pAgXFAr+EOoewu/oJZ1EN+zA7S1k8ZZyRbS9vxT2IgVqHpE0CRJgjdgZhsTL7NZ7Dxa+Ha/khj9yi6+YCeNJ3PEI96ecKDS2Qhrors5LyElwiRFxWmNsoAs8KCvyTLOFM7U3EdvBXjoswdrZHlQZad36ZFvBt+KtoB4MNoV8KHqee3I0mxPyASOme1/cbhX5TEhGwwH2IMgMRLZ4aip5qJsw/va5qAvrT2cqqJF8QI3M1JGxeXN45V4ggkWwVfFZ6/gKMHJoxpge+RmPD2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wg1hHU9slQd3wQBSez9GWzOK2LAcxrLQ+kanHbds7w=;
 b=MTJwTs4KQNiyodM1cTm8L8DHD7/gnno4xESkXGM+lvquAbYkpohZG8e8ATos7m0JepoCjz+16taPfYekACsYhk1bOxjyHdOAiHyDakcToAeHjTmftJ8tFWHFdphRrZBELM4EVVqSCiBVDYVyV7Pdf9MxAHiP25vVojWbkE7i4HsYq15mx+HD4cbyH+cB+1kz7YGyK/jMEZBGpkenOLqdICZEA27nS7AEHIO7/Sq/lLjM9j+ibnfYI3v3jqxqmdnUKY1cHAlDs9KDKplW0YxKEdf68+VEbwv3nK5HsicmnzQHdvV1yyEJVgZIl4u4F5VbkD8vy0Tt4twnpPMCgOuC3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wg1hHU9slQd3wQBSez9GWzOK2LAcxrLQ+kanHbds7w=;
 b=D1EVzXlaKvn5MU4KFaYMUvbuy4u/o4BBhbCXGitlIi1b7giK8okdsUJCu/8K1xMOHELTPZP2x6R0+/Tl7LzFRVdiRRbWaJAaAoG753IvorWY5ENesytX45XWxVel7tNnww4og6dQzpFMgauy5gzgAFavZ+bF13RM2F7gM/WJYps=
Received: from MW4PR03CA0038.namprd03.prod.outlook.com (2603:10b6:303:8e::13)
 by PH7PR12MB8121.namprd12.prod.outlook.com (2603:10b6:510:2b5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Mon, 31 Jul
 2023 12:10:43 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:303:8e:cafe::5a) by MW4PR03CA0038.outlook.office365.com
 (2603:10b6:303:8e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42 via Frontend
 Transport; Mon, 31 Jul 2023 12:10:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.22 via Frontend Transport; Mon, 31 Jul 2023 12:10:42 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 07:10:42 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 05:10:41 -0700
Received: from xhdipdslab59.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 31 Jul 2023 07:10:33 -0500
From:   Abhijit Gangurde <abhijit.gangurde@amd.com>
To:     <gregkh@linuxfoundation.org>, <masahiroy@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <michal.simek@amd.com>, <git@amd.com>, <nikhil.agarwal@amd.com>,
        <Nipun.Gupta@amd.com>, Abhijit Gangurde <abhijit.gangurde@amd.com>,
        "Puneet Gupta" <puneet.gupta@amd.com>,
        Nipun Gupta <nipun.gupta@amd.com>,
        "Pieter Jansen van Vuuren" <pieter.jansen-van-vuuren@amd.com>
Subject: [PATCH v2 3/4] cdx: add sysfs for bus reset
Date:   Mon, 31 Jul 2023 17:38:12 +0530
Message-ID: <20230731120813.123247-4-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230731120813.123247-1-abhijit.gangurde@amd.com>
References: <20230731120813.123247-1-abhijit.gangurde@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|PH7PR12MB8121:EE_
X-MS-Office365-Filtering-Correlation-Id: af7075d5-ee21-4597-b4b3-08db91bf29e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uwDGoYaWS6+gLy6zASC50StTZfyBObn81Ej8rSglgKZRoXAF6NbI4rWvXMlk+8ALubM8Bj9SkT9Zls8iEmlEt5f8wbhTOus2ANQVrhGkiFdGdEozKdgvTAMPev/jllc1Ny8VcWdvGqmkefhyIFVe/Dq4q9xPgHxXLARiTFUvZPfLz0/q+6/WwJckoKCR6HtII2ro7NZectVCE6Wj3AP7g3Rz9U4NsrSi7TiVtmZyuTw3jp46PpcRWrrmPQ+/Um42k2ZpaZgmVUKv+BB99WCTl0fSPFlDXeUzM5MJz1wn5gvLr3Lrib0cRI629UYiJmidMGgKUGvZFEFoyBmsegTYxbDmHZl+mL6OQz96Xt6ZvbbiK3yk9UyhIMc4A886CKTE+Ccu3sha3WYe2e5bQsdRYjSJWStQZgKPN877GiYLbqZyaC3UTIrzYMhOflJdGrfZi67fTj0urMr579moUzesPimJFkOO86qMbsokk/VQmFjvLCW4Ijk3/s8tW3BULV8Ctazyu+vwUU2tVd1o2CB4gwCI/pfrrhWpU0wx95NZtYR/IlFvo28vcqzIgwh46cUmNTKcrpNMRiWCQqschzBwUIrH++vKLzHcnEfQ4GQtaWA9WfgfyzxD9j0qPZjee37kCoHgM47NkvKx77kguJ17w2lelppVgydOSDIRVNaTvBmE1HbcXCZNXmcjVsQmaWRjW6v6JAEVs3th8eRSvXezdUCMBdgj+IzDP25RvQk7LF7o7bWs1xCaNG2H2q8/Fwo0GAieKMN2Bf9TTWMdUgpyCg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(8936002)(8676002)(1076003)(26005)(110136005)(54906003)(41300700001)(82740400003)(316002)(4326008)(5660300002)(336012)(186003)(6666004)(70586007)(70206006)(478600001)(44832011)(86362001)(2616005)(36756003)(426003)(83380400001)(47076005)(40460700003)(36860700001)(2906002)(356005)(81166007)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 12:10:42.8061
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af7075d5-ee21-4597-b4b3-08db91bf29e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8121
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
index 28c38cc4e4f6..76219d35e321 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -112,6 +112,26 @@ int cdx_dev_reset(struct device *dev)
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
@@ -485,10 +505,31 @@ static ssize_t rescan_store(const struct bus_type *bus,
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

