Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198167AAF57
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 12:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbjIVKUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 06:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbjIVKUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 06:20:36 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7BC1A6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 03:20:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VroHLSI/kIVneLsZ+efm5CNiCxzgyud6RHAgHtmCSBweY8RlsVZr/xsw525b2vr3TZJjsBune3Kq90InIW8qkha4zsTGPwEO/PgZIe+lUhadhos4H3Yq6XuDvX2SQLpqIbIUY9uZZU3Mu3DnnbqHh8clp++Rq+bP7vkQX7Fak5lEDDXou3kAw5M0/OQjFLNhSw3v08nSHbm2CmZBOYrHEoFpTdwJBsFsg5Vz0YJx4+Z5qI5vXAhSFToEHkHB79snrq5Wo2ulPKenMnMDGqZj3D0pt7KHmYmGmzNg4BMapxI7gR24gPzkVzHT+qQJFoBJnKGPZ2A4XIHoMTH4OrIN1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gp+VplbfTpiiviw3bqFPe3khqXgIMv6xTak0M2kyZTg=;
 b=AkXQI5zUfvfsVmkX/xD5eac60I852+ysrr/vtqTxXqAs0McfxKaQvA78OOlkwuf9PAUOSNzm5UNmT5uZ6qnvW3V2XpClU9UE+fjyks9jS51yu9UPX+rRUPztbTpotWWu1qeOHJJSd+SXt1rD71MIf8qqm7QOwIcUD6aI5X/cBQ4W84lOsI+hgq0AFe5oMSSfIQTMRqOoXxnrg/bj9wqXNiaY2e9Pq4SF42kDD8Yx875PclMmWUQ0t0wRlvUcsV17KqxlnCiAme7mwwXKlFCOZwCKFpyk3AHZ2hQ7aR08qcV1/c1GWYUANGV3uKghrRFpdE4aiv5kPMXuSmvYumk1kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gp+VplbfTpiiviw3bqFPe3khqXgIMv6xTak0M2kyZTg=;
 b=tNj9AWzUIVNat33ck24eHy9AzMgKL5beuRaN/HwNHH5WABSOk6F3MLoaaIEOF2GTix6yatuBsgZQi6icRtKek3l48iL879wg3ScXfXAuGOmoagviU8DPs6rskOk5AdfyNZcFKq9EVnOfPBY2gLncRQJ9TOXwwTCYTZntz6/Bh+c=
Received: from CY5PR19CA0044.namprd19.prod.outlook.com (2603:10b6:930:1a::24)
 by DS7PR12MB8323.namprd12.prod.outlook.com (2603:10b6:8:da::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.23; Fri, 22 Sep 2023 10:20:23 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:930:1a:cafe::5) by CY5PR19CA0044.outlook.office365.com
 (2603:10b6:930:1a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.32 via Frontend
 Transport; Fri, 22 Sep 2023 10:20:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 22 Sep 2023 10:20:23 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Sep
 2023 05:20:21 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Sep
 2023 03:20:11 -0700
Received: from xhdipdslab59.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 22 Sep 2023 05:20:03 -0500
From:   Abhijit Gangurde <abhijit.gangurde@amd.com>
To:     <gregkh@linuxfoundation.org>, <masahiroy@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Nipun.Gupta@amd.com>, <nikhil.agarwal@amd.com>,
        <puneet.gupta@amd.com>, <git@amd.com>, <michal.simek@amd.com>,
        Abhijit Gangurde <abhijit.gangurde@amd.com>,
        Nipun Gupta <nipun.gupta@amd.com>,
        "Pieter Jansen van Vuuren" <pieter.jansen-van-vuuren@amd.com>
Subject: [PATCH v5 4/5] cdx: add sysfs for bus reset
Date:   Fri, 22 Sep 2023 15:48:27 +0530
Message-ID: <20230922101828.33456-5-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230922101828.33456-1-abhijit.gangurde@amd.com>
References: <20230922101828.33456-1-abhijit.gangurde@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|DS7PR12MB8323:EE_
X-MS-Office365-Filtering-Correlation-Id: b6714efe-c9f9-4819-c5c7-08dbbb558838
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vHWNEkVFyj2uZwKKLl9bVbO6DSe8vpVNG75oWYsvrJhrEVsZwKeXV2LCGAGVSqmGk2oe3bQQKDBAe1EN9EzFUDmEEQPwnFabvbFadzZ4WB+W5qcIfz7ymKqt7+85EEvYl3YG0CiN+7wPR7L/aH0/psDEPA76U7O+0UxCUvV6IT0MGV4/AS2IgmJGu3MMIO4m/qzC8fAFuIEpof0dHhewgOEg8K3/r/OIfQF0GzlNGs+e3+6UW1yUHN4PFwXfi3AcvsTE0KfHKpL2lUwm4o9kEMvF/siSCBm4EJE/5+UpuuvkBldrqlIM9bTPtzMAK0hEjZVyCzNdDwCAQqMFwJ9WBrYIcYGE3l/l6ko/I+H6Ngv/nuBtGaIH/E+pCPO0CSxSMJe/VZoaD5Oj3CVVRPtpFGoNG+TB2PB4+bGLPGM2ZPzjzBKoWeF69unyep2KZuEQr4nKb7KVvwZBcJap7nrZAF7iC5+XqJ/s4TiO7DE3zV3kX45yNPQukr+5iI5QyD+YX3lC6+3f4yRFZh46Bm9btyxX9G1MlfKpb7l1T1hCreqkpC0qFeR6tLOBiRFfo/9xBlxZRCk5NSQnAfDw0xlkp+ZlJ8O/qnIcN2ks/1FEz9b9Zt4EhRx46IZV0Di35K1PQCINpTikIOsXHJe9Enf5YrQwea6CZBxTipAWFqtJPrMStUexP9EtMyypjgXvJDCG9pw16s6ElWf/TOD7b3bmhJsPWQ4b5wfN25dEhGChgAo/FsIQJKeSIgjMydiflbu7mno0gPx7lfvN1TZAy2vjfJ0aZXEcSvg0/xjxWZx6Rsv2rKyhm0uD/u+uQgHL26K9
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(230921699003)(451199024)(82310400011)(1800799009)(186009)(40470700004)(46966006)(36840700001)(2906002)(8936002)(4326008)(41300700001)(8676002)(5660300002)(44832011)(70206006)(316002)(54906003)(70586007)(110136005)(478600001)(6666004)(2616005)(1076003)(336012)(426003)(26005)(40460700003)(83380400001)(47076005)(40480700001)(82740400003)(81166007)(36860700001)(356005)(36756003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 10:20:23.3999
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6714efe-c9f9-4819-c5c7-08dbbb558838
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8323
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
 Changes in v5:
 - None

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

