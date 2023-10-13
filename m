Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273BA7C7D81
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 08:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjJMGKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 02:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjJMGKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 02:10:16 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10311E6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 23:10:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6K+mHTq6vBsqP2o4s9sLuRvUb2scwzZSFMWoObSDmQJJu7yxj4w5HNduwkstO3qyTS8ylPfhb1xiYkVMu8f20F3X2JL9OlXwr/k4eAYT+Tjx5v1zl5Q2AVySHgtY5RVh09VmhrYbK50+aNwt3ieO5o0OJKEwyGXHHlHgyRjWaDVUn1UYWyZf3cXpf7kRTL8V1+/7o/0RIrzcg6rqyFx9jRpz/chmEjY5jIzUKodF+QNNtet3kZ0q+jsIMJigSFas8DXVGjRYmv8Esp6DDq3X5aQyj/g46KJkNsH26zJsC4/7mh6P7QyjC3BYcNj5UWbidC0MnKIA6zzRLIDzeDi2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7mvsK5jN3Gcr+swLaFh22G6BimQ2EN2yCUsez4/XpvE=;
 b=bn0zFpwjdI6vS5C/CurYe9/6SfUN5fSs/G7PkSNTSJqel/lBFSk0GkTDSszUcOo3yXcRYseRz/YCngPHdovwmkoObuT3baJXm4ugDBll1LppWp8DQDXwqPAdkpm48GEFYCNh9VdbmoLK8f4+0tMdAsvAWcAJ7oJ9RrTwrzsJ8DkUqmpcbKGGSY9u345ptu9IihKVreTCihKA58+gMWJsZ3zlTWgTAwthdfFcPapS10YT6gXQBqS8C9Khi10+FP7eZ2nOehfvdlEqXOwsBNnvJBa83bgHZQ20rM/q5PbxX7NMMzKJurm8UYmjFM1lywh4mnQnI/HUjmWmtfa4cycCcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mvsK5jN3Gcr+swLaFh22G6BimQ2EN2yCUsez4/XpvE=;
 b=U46EJdNOCLDmTrflIQ27UOBYf02b8WIytfalzlh97eZA9qCfKtglyohIrHTchw1OalyNm6oKSvx7fmQ5CpRtXERIbD3VsHG39YbcINGyf2a9EuuhSA4xoY/P6QVg8VwVWbn0kFLbYQvnH2qkwwpHrNNCAGNWQwcdG4rvTN3vxoU=
Received: from BL1PR13CA0199.namprd13.prod.outlook.com (2603:10b6:208:2be::24)
 by DM6PR12MB4122.namprd12.prod.outlook.com (2603:10b6:5:214::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Fri, 13 Oct
 2023 06:10:10 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::ad) by BL1PR13CA0199.outlook.office365.com
 (2603:10b6:208:2be::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.27 via Frontend
 Transport; Fri, 13 Oct 2023 06:10:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 06:10:10 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 01:10:09 -0500
Received: from xhdipdslab59.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 13 Oct 2023 01:10:07 -0500
From:   Abhijit Gangurde <abhijit.gangurde@amd.com>
To:     <gregkh@linuxfoundation.org>, <masahiroy@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Nipun.Gupta@amd.com>, <nikhil.agarwal@amd.com>,
        <puneet.gupta@amd.com>, <git@amd.com>, <michal.simek@amd.com>,
        Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [PATCH v6 5/6] cdx: add sysfs for bus reset
Date:   Fri, 13 Oct 2023 11:38:49 +0530
Message-ID: <20231013060850.424929-6-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231013060850.424929-1-abhijit.gangurde@amd.com>
References: <20231013060850.424929-1-abhijit.gangurde@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|DM6PR12MB4122:EE_
X-MS-Office365-Filtering-Correlation-Id: 80b9039c-6831-410f-fb59-08dbcbb30e49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a6R8aQIdNHbWKPhDYcY0/hGz432bF9QdyCr9o+VkFSACZ7iBd1mE92JCJKngQN6q2LdIE7r309Zekv2wQGr36PPAf06GXFao2LvApPyq5BBn96Ko/ShsRGRptUxFXgHnSJNEaUn1l/+153RSR/b6HYreqTQF0Hzu2XyPs5pfxD1GHuqXV1rv6A2bsHPRbFoK68gn59Z40GOarT50LwOOcYwcQycASR/nZp2NwmI+OpNfaum5cVc6ObSt/AOUjhBgtTcevxNlXpXn6frNa1EzsVSQRWgUOfajuKNGNqmeUkCTRyDKBkQw2f3t0T8v6qWlLsfyVZOH0hulABm5m1FCBhQHAa944RNDyqwO53BS2jEmXQOR00Uwf5XNDtjZDNNsYdbW+7CO5pFnIZi+ePwEeBTnbTQ2wYU/PbfWJkvit7ycA/KkXLBIKfAe9T2NpjGW3t7JBy/PM1x/tgUa/wm0u1QTKYfPKgQVZRM1X+gLbyt8GCUHFcewh+cvDNGDdx2gfe8XapQWkOzETq39qR+cneA+MBwSsXgDTOjVGV52Xs9IWVkaQl/Hc0wH5Qb4pfwNGq/Ty4gZ2hHC6Qs7wan40JQKMBYO5EB0pX3l91VichcwhidQ8S0unh1dxpeGtwbjKiXT0TA67WjbMuM2y/R798fkocZPllFhxBAo/ogro9CAoiGpMnzIh4T6Ut1piN3/XoqCjiPx/8XaKh7kUcGsZcaxZ7waurtmSjn74VDpjZGYh3ei9uAU1oAyH/n5M3K7TYHEed64FxF4vQY/D3J92g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(1800799009)(64100799003)(82310400011)(186009)(451199024)(40470700004)(46966006)(36840700001)(41300700001)(6666004)(1076003)(2616005)(82740400003)(40480700001)(44832011)(316002)(36756003)(86362001)(478600001)(356005)(36860700001)(81166007)(40460700003)(2906002)(336012)(47076005)(426003)(4326008)(26005)(83380400001)(5660300002)(70586007)(70206006)(8676002)(110136005)(54906003)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 06:10:10.1902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80b9039c-6831-410f-fb59-08dbcbb30e49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4122
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

Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 Changes in v6:
 - Remove bus attributes reset
 - Use reset attribute of cdx device for bus reset.

 Changes in v5:
 - None

 Changes in v4:
 - None

 Changes in v3:
 - None

 Changes in v2:
 - Improve documentation
 - sysfs entry reset takes bus number as an argument

 Documentation/ABI/testing/sysfs-bus-cdx |  8 ++++----
 drivers/cdx/cdx.c                       | 26 +++++++++++++++++++++----
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cdx b/Documentation/ABI/testing/sysfs-bus-cdx
index c12bdaa4152a..c2c54abffed5 100644
--- a/Documentation/ABI/testing/sysfs-bus-cdx
+++ b/Documentation/ABI/testing/sysfs-bus-cdx
@@ -45,10 +45,10 @@ What:		/sys/bus/cdx/devices/.../reset
 Date:		March 2023
 Contact:	nipun.gupta@amd.com
 Description:
-		Writing y/1/on to this file resets the CDX device.
-		On resetting the device, the corresponding driver is notified
-		twice, once before the device is being reset, and again after
-		the reset has been complete.
+		Writing y/1/on to this file resets the CDX device or all devices
+		on the bus. On resetting the device, the corresponding driver is
+		notified twice, once before the device is being reset, and again
+		after the reset has been complete.
 
 		For example::
 
diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index 3d7bdd2647a3..5f713a83effa 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -110,6 +110,20 @@ int cdx_dev_reset(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(cdx_dev_reset);
 
+/**
+ * reset_cdx_device - Reset a CDX device
+ * @dev: CDX device
+ * @data: This is always passed as NULL, and is not used in this API,
+ *    but is required here as the device_for_each_child() API expects
+ *    the passed function to have this as an argument.
+ *
+ * Return: -errno on failure, 0 on success.
+ */
+static int reset_cdx_device(struct device *dev, void *data)
+{
+	return cdx_dev_reset(dev);
+}
+
 /**
  * cdx_unregister_device - Unregister a CDX device
  * @dev: CDX device
@@ -343,6 +357,7 @@ static DEVICE_ATTR_WO(remove);
 static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
 			   const char *buf, size_t count)
 {
+	struct cdx_device *cdx_dev = to_cdx_device(dev);
 	bool val;
 	int ret;
 
@@ -352,11 +367,13 @@ static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
 	if (!val)
 		return -EINVAL;
 
-	ret = cdx_dev_reset(dev);
-	if (ret)
-		return ret;
+	if (cdx_dev->is_bus)
+		/* Reset all the devices attached to cdx bus */
+		ret = device_for_each_child(dev, NULL, reset_cdx_device);
+	else
+		ret = cdx_dev_reset(dev);
 
-	return count;
+	return ret < 0 ? ret : count;
 }
 static DEVICE_ATTR_WO(reset);
 
@@ -461,6 +478,7 @@ static const struct attribute_group cdx_dev_group = {
 
 static struct attribute *cdx_bus_dev_attrs[] = {
 	&dev_attr_enable.attr,
+	&dev_attr_reset.attr,
 	NULL,
 };
 
-- 
2.34.1

