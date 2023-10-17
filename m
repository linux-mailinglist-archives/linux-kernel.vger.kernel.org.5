Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537B07CC862
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344426AbjJQQHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 12:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344161AbjJQQHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:07:42 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26BCED
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:07:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BlrDMCTiAW+ALUolI6gjU7KBVX3jhmyQMNgxya2FENOQwOAca5xxP3NqEaXfoMDxDftwrOoZTxVG0uGdNtm4+EAT6hoBxS+Qk8x5dUcbYyyrr4C1x9ojvPPe4n3rnknfzLIQN5928+UL//hwycZNP2mz4Mz9kDELgWidc//488PHZaqzDfoCbV1TsvIbhtVq1pq+C0kamkJ2XtcIT8OgjxPDNJlomLT6d5mFEboasMo552ABmgk6EtCC6UA9GxEBP0xX/Nqh7emHRNhW4jlzHEWpOzVCJznq27fgVGHWx3JsBN8YD7bMNCgijleAKflTyufn8K/vY3jwXaI93dsUGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18YjIp500uOkrXtBG0tI2Zpufh2vu8Cn2Qgv0SzxYns=;
 b=jBUqN6gc7MFRBuo3vlp8WarQk0t9/Y+hHKl0v0C5OQFU9tijLmboH1hlw6lnJM789jbkYTDD9sI4WlNHxtEbBIwpkl1t/D6jvEaDhY84xrZMAb0pA7gFI8g9pkiCMqkTtwmLYMi0PzX1vZOqtag1/vVTtFYuv94cDpJc/j1UyyzZGRjPJk8vstDvippQO+TCVyIz9lr5GEq7ZfIBHuvl0ViWP7giTIBpHM9t3RvJbDJoIUQwJHpNPnjttIWx6JDRKpVHJqzQM/90pN49TyOuipFxt2rxnZo/cPJLaKIBHDJcJNtWNpcOwV/kQVeuamS7MLc7hzZPdKL0iAprVPW2Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18YjIp500uOkrXtBG0tI2Zpufh2vu8Cn2Qgv0SzxYns=;
 b=KQkcfrdLsSqAdulq/DZvbegQEz27uINW5SfSsEZuTQGHE65nTMwaqwT+/s1onOfIqYeqRVJVeitWR7M2EsxVZsJV4JCbP/dQXnTHGdyqkkNZNwN3k1UmCJcc00b0kGWa5U7tAhaGHV5Zavujti9kHSKXZ6r45RTyxInbEKz7tnk=
Received: from CY5PR19CA0132.namprd19.prod.outlook.com (2603:10b6:930:64::29)
 by LV2PR12MB5725.namprd12.prod.outlook.com (2603:10b6:408:14c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 16:07:37 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:64:cafe::a3) by CY5PR19CA0132.outlook.office365.com
 (2603:10b6:930:64::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Tue, 17 Oct 2023 16:07:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 16:07:37 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 17 Oct
 2023 11:07:22 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 17 Oct
 2023 11:07:04 -0500
Received: from xhdipdslab59.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 17 Oct 2023 11:07:02 -0500
From:   Abhijit Gangurde <abhijit.gangurde@amd.com>
To:     <gregkh@linuxfoundation.org>, <masahiroy@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <puneet.gupta@amd.com>, <Nipun.Gupta@amd.com>,
        <nikhil.agarwal@amd.com>, <michal.simek@amd.com>, <git@amd.com>,
        Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [PATCH v7 6/7] cdx: add sysfs for bus reset
Date:   Tue, 17 Oct 2023 21:35:04 +0530
Message-ID: <20231017160505.10640-7-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231017160505.10640-1-abhijit.gangurde@amd.com>
References: <20231017160505.10640-1-abhijit.gangurde@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|LV2PR12MB5725:EE_
X-MS-Office365-Filtering-Correlation-Id: 7395fd47-201d-4994-6277-08dbcf2b2e84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7JNvsRn1m588VW3lSiS36vDT+tPb6UcIBNMx6I9m8ky074Dte2jkr2E2rhraKwDH3lfMEC0C7RX3wpivn//+VcpFMjsn4pOr5nbEG/T16CE0BGnSveSo3VLCGRwTA/fIYSti3wSnUxYk98beM05W15kVT/nMmea+ftCASLQuGRea79Yn+2e7wqr69qefO0pays0NXiOOeCjqddQ5o1HfOcitZwoW8QPgUWXR/ikTGdQ82HKswqF9PKK8BpABjtF1bc8Wnv/fDOrChSwu1iwjqoTWp9v1PEjV3PeCDb36g0fHeJHy+saOpHlr3YfBfsJX0U8zNIpPa3Nke0JiTJ9SKWC2xESdkKla1+cL16/Hi4lbJO+Rm0ARBdRNhK7/mGWlLb7IAIk0rpj4HRTsW7i18+/5t9s+inIELzb7vn7zvBcY/eJIVmH+8ZQYriRuq5+Luulhq5KIe5PMt41fl2SBz3QJuhm3ufHrOKbkT379RiV6m7ujqHfvD1j5Hn84Fx4MdjT3y0ZflTBUgm99ZPn/Y4Fd5hdlbhSlysL9rMp4xDniqBUn3D+Fc0giW8LpTM0kEvnZhbXvavsBSd0WLlKGYd9ir2zyEmzNC5flZGWMbG3U/P7Ga1Ooywjw71cemDbK+NgcWvyHes2+rsLpmQM1v+M7e6vJbTZQynTUfcD7JCirEvi0lQnBqoFXk7GVyytFiv3DG6lnFmz8a+wxQtDpIUkbFUTcuPZ0afAHcQJLKgPGQ/SFC14eMDMcljzgg33xtaZu0qoy5t0JoBLr/T5O3g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(1800799009)(64100799003)(82310400011)(451199024)(186009)(36840700001)(46966006)(40470700004)(70206006)(70586007)(110136005)(478600001)(54906003)(26005)(426003)(1076003)(2616005)(316002)(336012)(86362001)(8676002)(8936002)(4326008)(2906002)(44832011)(5660300002)(41300700001)(81166007)(36756003)(47076005)(356005)(36860700001)(83380400001)(82740400003)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 16:07:37.2934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7395fd47-201d-4994-6277-08dbcf2b2e84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5725
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sysfs interface reset to reset all the devices on the CDX bus.

Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 Changes in v7:
 - None

 Changes in v6:
 - Remove reset bus attribute
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
index 8eb484c37e97..e22a7138292e 100644
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

