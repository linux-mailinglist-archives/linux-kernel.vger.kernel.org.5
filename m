Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB6E763470
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbjGZLCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjGZLCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:02:40 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AB89B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 04:02:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2iUnd7giw4iJddWj/sU+hbcaujCyknjCL++ZSa+kVe9P31+t9UsAW69d6iRT4YEQ9FTY/HvkQGMDgUOn/Mp20qHodTgy8JJvAEptidI+/S0bUtjSiM1W1ypJJFX7ZV4AhA4QAXFdsJtiAGYmUW0jZMEFZ+KhseIHY4pE9/4CasL4VGOlj5HmQ7WA1OSrDjPqIqVQmmg/BV/6MgitDIWm9HKIjZlJiRH5awDdTL7neAUN70OtFlJ7N741TtT+PPp2KRyGMFp9yx0oNg4yvsXLxgtkG6Pm4WI5wtUeVQOOqe+n78gGW9HkPP1h2F2V4WQ1n43NBjeJkYKalGmgTwLrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SjVkBaURuq++rgBcyk7gBPfCsQ7UmQ+UrK8PCAQLaSw=;
 b=JmCY1IP2yi8Up8gxWGTcOMTDftSEHDQ5T/j1+XvqYvqtqq73IR6xNIDpSbfvzgXqDkSCODEmCzIperCPDwOLexfiHpO/oJRcXmEPVRCqJySHPB8klkWV5Up7ZySFIzY3yLOJqQumGzUwk7vs9FuzIkV8PjMgfmD8YGj55wYmDURvS5H78eIyGZThjpwQpi150DJX93Zv0PxqF9cEq0yttUXBNlB17qRBpvPiB7/fTr4rq2BI6sSqNwQEsN5CoF7t6Thx6M9IseXfjj4Z/zjuq/tmvZjeXsWj1mKvEU48RV4tz9MDRxDpU2CH4woaaxyzSmC8OpXKODgeyGT42igyig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjVkBaURuq++rgBcyk7gBPfCsQ7UmQ+UrK8PCAQLaSw=;
 b=YRRnvDN7lrBGDpAUnghutQ/R/zOJuogqr/3aurQufHE4G2h/WN7dJ4i2wg1etf1lSviGrT5ZThkaLQlsbX5ric7U0f69j/geLKHEF/gIRciZwkHp4PJOLIGuzsqsDL5KcJFoY0kjtzh88s1lycZ5ngmJufAMvdEzUh6STTO5TNI=
Received: from MW3PR06CA0019.namprd06.prod.outlook.com (2603:10b6:303:2a::24)
 by CYXPR12MB9388.namprd12.prod.outlook.com (2603:10b6:930:e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Wed, 26 Jul
 2023 11:02:33 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::70) by MW3PR06CA0019.outlook.office365.com
 (2603:10b6:303:2a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33 via Frontend
 Transport; Wed, 26 Jul 2023 11:02:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Wed, 26 Jul 2023 11:02:33 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 06:02:31 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 06:02:30 -0500
Received: from xhdipdslab41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 26 Jul 2023 06:02:28 -0500
From:   Nipun Gupta <nipun.gupta@amd.com>
To:     <gregkh@linuxfoundation.org>, <alex.williamson@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     <git@amd.com>, <pieter.jansen-van-vuuren@amd.com>,
        <nikhil.agarwal@amd.com>, <michal.simek@amd.com>,
        <abhijit.gangurde@amd.com>, Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH 1/2 v4] cdx: add support for bus mastering
Date:   Wed, 26 Jul 2023 16:32:19 +0530
Message-ID: <20230726110220.26486-1-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT060:EE_|CYXPR12MB9388:EE_
X-MS-Office365-Filtering-Correlation-Id: d2ed6e4f-2ca8-413a-de8f-08db8dc7d037
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VPmRTZTeQVO5CJ5FWVcdF4qlIJnLnM65eHPsvQgJj9+gmOQuEY9uXlciURhP9xKYWEsyq5/mcfurY2OPzxX3oOh31411QGnRJTg4QX1bTrFnFJPly0NoTYU5pfas1oWI2WlAwIAfMjPUjgQ71bJ00GMpfnkJwfi6TjbOlBZtc/gyI5vSLBGUJ1JB6uiynM/Xy18V74pqnVH/I5xji0LjEFGYUcjEnDgGdGM+jECxN0LCnCQ2AAgCuq56cCTtYjJv5ucgSG3MEmk+jUcUQoQudZZIauSWP+iaCuXl2de0uw8A13sndcbWILm84Xqch2I6BTfqmqFHqKXDncrKIg3v9Rp5/jZT5GA3DKBq89qivZmz7dV1rKjes9Vp7wp9J3/oP2hOIYksiwiQxELui3YWQoBiSDLVLl7aKOi3lXV5Pktv/c39sIHTn+B0R4UwBhFHtbEzs3lFjd41p/rQkRZgoEUrnYCEK37byrXz1bpsKObdzcWalWHL4zqFQ3OMkE9yHROhRjMA1W7kFs4uDqm1DWgcy1DgcX9KqAfm/HpaXbDc7EGtc3FJospZtbQhPJgf+6IRh2+TcW/wmY8mYFMpgh6wDaJKt+cW8xG+k0G7CXsAZDvIAhr3ugaeDWO1MjKin+EU78Wik1H/eEMWXPIF1q2qZC8BtrrA9Z8bKX3+22uPLgRpIsEWeUgsW8wVh8kAM3rVlLgH9lBglFiq+lXCPrMU/eE+NT4KoGVpYXysBXdi/WTHwhqf/kkWZJMmR/hOVKSzemh8YGjuKDb/HDfI7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(136003)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(81166007)(1076003)(47076005)(82740400003)(2906002)(36756003)(356005)(8676002)(426003)(186003)(2616005)(36860700001)(44832011)(26005)(40480700001)(5660300002)(8936002)(83380400001)(40460700003)(336012)(4326008)(478600001)(316002)(6666004)(86362001)(70206006)(54906003)(41300700001)(70586007)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 11:02:33.2669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ed6e4f-2ca8-413a-de8f-08db8dc7d037
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9388
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce cdx_set_master() and cdx_clear_master() APIs to support
enable and disable of bus mastering. Drivers need to use these APIs to
enable/disable DMAs from the CDX devices.

Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
---
Changes v3->v4:
- Added user of the Bus master enable and disable APIs in patch 2/2.
  There is no change in this patch.

Changes v2->v3:
- Changed return value from EOPNOTSUPP to -EOPNOTSUPP in
  cdx_set_master()

Changes v1->v2:
- Replace bme with bus_master_enable
- Added check for dev_configure API callback
- remove un-necessary error prints
- changed conditional to if-else
- updated commit message to use 72 columns

 drivers/cdx/cdx.c                       | 29 +++++++++++++
 drivers/cdx/controller/cdx_controller.c |  4 ++
 drivers/cdx/controller/mcdi_functions.c | 58 +++++++++++++++++++++++++
 drivers/cdx/controller/mcdi_functions.h | 13 ++++++
 include/linux/cdx/cdx_bus.h             | 16 +++++++
 5 files changed, 120 insertions(+)

diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index d2cad4c670a0..10c6281b59c3 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -182,6 +182,35 @@ cdx_match_id(const struct cdx_device_id *ids, struct cdx_device *dev)
 	return NULL;
 }
 
+int cdx_set_master(struct cdx_device *cdx_dev)
+{
+	struct cdx_controller *cdx = cdx_dev->cdx;
+	struct cdx_device_config dev_config;
+	int ret = -EOPNOTSUPP;
+
+	dev_config.type = CDX_DEV_BUS_MASTER_CONF;
+	dev_config.bus_master_enable = true;
+	if (cdx->ops->dev_configure)
+		ret = cdx->ops->dev_configure(cdx, cdx_dev->bus_num,
+					      cdx_dev->dev_num, &dev_config);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cdx_set_master);
+
+void cdx_clear_master(struct cdx_device *cdx_dev)
+{
+	struct cdx_controller *cdx = cdx_dev->cdx;
+	struct cdx_device_config dev_config;
+
+	dev_config.type = CDX_DEV_BUS_MASTER_CONF;
+	dev_config.bus_master_enable = false;
+	if (cdx->ops->dev_configure)
+		cdx->ops->dev_configure(cdx, cdx_dev->bus_num,
+					cdx_dev->dev_num, &dev_config);
+}
+EXPORT_SYMBOL_GPL(cdx_clear_master);
+
 /**
  * cdx_bus_match - device to driver matching callback
  * @dev: the cdx device to match against
diff --git a/drivers/cdx/controller/cdx_controller.c b/drivers/cdx/controller/cdx_controller.c
index dc52f95f8978..39aa569d8e07 100644
--- a/drivers/cdx/controller/cdx_controller.c
+++ b/drivers/cdx/controller/cdx_controller.c
@@ -55,6 +55,10 @@ static int cdx_configure_device(struct cdx_controller *cdx,
 	case CDX_DEV_RESET_CONF:
 		ret = cdx_mcdi_reset_device(cdx->priv, bus_num, dev_num);
 		break;
+	case CDX_DEV_BUS_MASTER_CONF:
+		ret = cdx_mcdi_bus_master_enable(cdx->priv, bus_num, dev_num,
+						 dev_config->bus_master_enable);
+		break;
 	default:
 		ret = -EINVAL;
 	}
diff --git a/drivers/cdx/controller/mcdi_functions.c b/drivers/cdx/controller/mcdi_functions.c
index 0158f26533dd..6acd8fea4586 100644
--- a/drivers/cdx/controller/mcdi_functions.c
+++ b/drivers/cdx/controller/mcdi_functions.c
@@ -137,3 +137,61 @@ int cdx_mcdi_reset_device(struct cdx_mcdi *cdx, u8 bus_num, u8 dev_num)
 
 	return ret;
 }
+
+static int cdx_mcdi_ctrl_flag_get(struct cdx_mcdi *cdx, u8 bus_num,
+				  u8 dev_num, u32 *flags)
+{
+	MCDI_DECLARE_BUF(inbuf, MC_CMD_CDX_DEVICE_CONTROL_GET_IN_LEN);
+	MCDI_DECLARE_BUF(outbuf, MC_CMD_CDX_DEVICE_CONTROL_GET_OUT_LEN);
+	size_t outlen;
+	int ret;
+
+	MCDI_SET_DWORD(inbuf, CDX_DEVICE_CONTROL_GET_IN_BUS, bus_num);
+	MCDI_SET_DWORD(inbuf, CDX_DEVICE_CONTROL_GET_IN_DEVICE, dev_num);
+	ret = cdx_mcdi_rpc(cdx, MC_CMD_CDX_DEVICE_CONTROL_GET, inbuf,
+			   sizeof(inbuf), outbuf, sizeof(outbuf), &outlen);
+	if (ret)
+		return ret;
+
+	if (outlen != MC_CMD_CDX_DEVICE_CONTROL_GET_OUT_LEN)
+		return -EIO;
+
+	*flags = MCDI_DWORD(outbuf, CDX_DEVICE_CONTROL_GET_OUT_FLAGS);
+
+	return 0;
+}
+
+static int cdx_mcdi_ctrl_flag_set(struct cdx_mcdi *cdx, u8 bus_num,
+				  u8 dev_num, bool enable, int lbn)
+{
+	MCDI_DECLARE_BUF(inbuf, MC_CMD_CDX_DEVICE_CONTROL_SET_IN_LEN);
+	u32 flags;
+	int ret;
+
+	/*
+	 * Get flags and then set/reset BUS_MASTER_BIT according to
+	 * the input params.
+	 */
+	ret = cdx_mcdi_ctrl_flag_get(cdx, bus_num, dev_num, &flags);
+	if (ret)
+		return ret;
+
+	flags = flags & (u32)(~(BIT(lbn)));
+	if (enable)
+		flags |= (1 << lbn);
+
+	MCDI_SET_DWORD(inbuf, CDX_DEVICE_CONTROL_SET_IN_BUS, bus_num);
+	MCDI_SET_DWORD(inbuf, CDX_DEVICE_CONTROL_SET_IN_DEVICE, dev_num);
+	MCDI_SET_DWORD(inbuf, CDX_DEVICE_CONTROL_SET_IN_FLAGS, flags);
+	ret = cdx_mcdi_rpc(cdx, MC_CMD_CDX_DEVICE_CONTROL_SET, inbuf,
+			   sizeof(inbuf), NULL, 0, NULL);
+
+	return ret;
+}
+
+int cdx_mcdi_bus_master_enable(struct cdx_mcdi *cdx, u8 bus_num,
+			       u8 dev_num, bool enable)
+{
+	return cdx_mcdi_ctrl_flag_set(cdx, bus_num, dev_num, enable,
+			MC_CMD_CDX_DEVICE_CONTROL_SET_IN_BUS_MASTER_ENABLE_LBN);
+}
diff --git a/drivers/cdx/controller/mcdi_functions.h b/drivers/cdx/controller/mcdi_functions.h
index 7440ace5539a..a448d6581eb4 100644
--- a/drivers/cdx/controller/mcdi_functions.h
+++ b/drivers/cdx/controller/mcdi_functions.h
@@ -58,4 +58,17 @@ int cdx_mcdi_get_dev_config(struct cdx_mcdi *cdx,
 int cdx_mcdi_reset_device(struct cdx_mcdi *cdx,
 			  u8 bus_num, u8 dev_num);
 
+/**
+ * cdx_mcdi_bus_master_enable - Set/Reset bus mastering for cdx device
+ *				represented by bus_num:dev_num
+ * @cdx: pointer to MCDI interface.
+ * @bus_num: Bus number.
+ * @dev_num: Device number.
+ * @enable: Enable bus mastering if set, disable otherwise.
+ *
+ * Return: 0 on success, <0 on failure
+ */
+int cdx_mcdi_bus_master_enable(struct cdx_mcdi *cdx, u8 bus_num,
+			       u8 dev_num, bool enable);
+
 #endif /* CDX_MCDI_FUNCTIONS_H */
diff --git a/include/linux/cdx/cdx_bus.h b/include/linux/cdx/cdx_bus.h
index bead71b7bc73..1816c279879e 100644
--- a/include/linux/cdx/cdx_bus.h
+++ b/include/linux/cdx/cdx_bus.h
@@ -21,11 +21,13 @@
 struct cdx_controller;
 
 enum {
+	CDX_DEV_BUS_MASTER_CONF,
 	CDX_DEV_RESET_CONF,
 };
 
 struct cdx_device_config {
 	u8 type;
+	bool bus_master_enable;
 };
 
 typedef int (*cdx_scan_cb)(struct cdx_controller *cdx);
@@ -170,4 +172,18 @@ extern struct bus_type cdx_bus_type;
  */
 int cdx_dev_reset(struct device *dev);
 
+/**
+ * cdx_set_master - enables bus-mastering for CDX device
+ * @cdx_dev: the CDX device to enable
+ *
+ * Return: 0 for success, -errno on failure
+ */
+int cdx_set_master(struct cdx_device *cdx_dev);
+
+/**
+ * cdx_clear_master - disables bus-mastering for CDX device
+ * @cdx_dev: the CDX device to disable
+ */
+void cdx_clear_master(struct cdx_device *cdx_dev);
+
 #endif /* _CDX_BUS_H_ */
-- 
2.17.1

