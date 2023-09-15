Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1716D7A14E8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 06:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjIOEzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 00:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjIOEzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 00:55:06 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B493F2718
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 21:55:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HPwJUAsEfVEApVmHHq/ye+P0iXBWqb5nX0cuG00BT4+5Kq5nMFVk1DHTfyKzy1YHvy0E1dIDZINyGkbjZPYAh0aF+Z+McBOXA/T7gE0CMru0aYxSNz0/N4nGEHgJ//z36u5FnhNdN2jd23x0kTfu/rQ5UPBxnhQGs+WfGCkrZ4MT6FE7pNQcfFINSKl5HWFa1cLjYYGIiNXpz+IoKcgRxB/jzY7TCRWhMqU9QtUQaW9zghXT1/FnFAZQCk/G2ktvC+Do5Q5bFdsonoqLwvnqPJxEo5nWjYK4ezOPao4Z1tC7vRxGDSO4CdQXr8WrWSa7TbPrBDKXRUHxvcoLGHjQYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J4C3zuGu7WnGiG9ewbMqJ6VKoEBb/yM7nn43IAPMltg=;
 b=LXPBzlWH90StYhZABfQ6IVBdvwiND9iaXVFuGUpAV8jLl3XHAzXFY0m0KUcb2x6XZnUDqxcZiiI3FZK/HHF0NHHgWwENKmWmd7luKQHlSzuwyXf13l+pjbGjkY76LEvggVKpIa2prrv/yR69oLhRZV8H7RETzjbpSCKTw1vqi307uqzRDTDgsCtHqw0KxHEnl2Fey98kA8S+IgwQ9Tjrqso6It+drg1DlVNeJK+T9VlR17SqHiUmP0AblW6sIGrVZq2R3gU6WnOHvQ7DWlHX8QXpw6TmgqLIZGylGQ5YmVjv9PyuW3anKtL52ekliapNQGloeNb9iZh7r0/s0fiLUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4C3zuGu7WnGiG9ewbMqJ6VKoEBb/yM7nn43IAPMltg=;
 b=Mn58KwovqFtS0HOzydMMAh8YRlIGtHybrkAF1pEM5hJwsD3gqI6r6vL3SKeKsCpDAO87+FshbbAjR48T1eTRwR/Qq3IkRuO1by0RfvuM1rhe1ZMqWHC6DV3UzEAVgb2h3pbKdGA+/WMczLVeGsbUaNPgQ2X3AV56lJBEIDnBgDc=
Received: from MW4PR02CA0001.namprd02.prod.outlook.com (2603:10b6:303:16d::21)
 by SA1PR12MB7317.namprd12.prod.outlook.com (2603:10b6:806:2ba::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Fri, 15 Sep
 2023 04:54:58 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:303:16d:cafe::74) by MW4PR02CA0001.outlook.office365.com
 (2603:10b6:303:16d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Fri, 15 Sep 2023 04:54:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 15 Sep 2023 04:54:57 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 23:54:28 -0500
Received: from xhdipdslab41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 14 Sep 2023 23:54:25 -0500
From:   Nipun Gupta <nipun.gupta@amd.com>
To:     <gregkh@linuxfoundation.org>, <alex.williamson@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     <git@amd.com>, <pieter.jansen-van-vuuren@amd.com>,
        <nikhil.agarwal@amd.com>, <michal.simek@amd.com>,
        <abhijit.gangurde@amd.com>, <srivatsa@csail.mit.edu>,
        Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH v8 1/3] cdx: add support for bus mastering
Date:   Fri, 15 Sep 2023 10:24:21 +0530
Message-ID: <20230915045423.31630-1-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|SA1PR12MB7317:EE_
X-MS-Office365-Filtering-Correlation-Id: 60f001d3-1ec7-470c-93c9-08dbb5a7e93b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CnIkAFhAC8xEAxsO3vo6F2BtuIPaR7iQBSTr844iGHpG7cvaqXHNCFkLTYJj78nov8to4BP26+WKSo7zyfi7u3cyLm/cze9oAv4K+TbvJ4vqFTcZeR2Jw5HcyPDWz/vY+/XtjoTiS/rvKsPqNqiT6FcLwKDBUSA4qBUgZlDOX76ZWKOU71z48SQIvQYlUS7IJVGp6hvtYDA5kD0OTZYFkSKiAULtoE2tx/zI+/l8FJMjV1r31Uk/SAhecv9sM5dLH5nRQNeZSdEGN8CXcskpq8py4Be6fmmI3YlsB1/zOGWTFRV4UAl+4ZwAmmkhQtv040CgrOsRB+SXMChe/O9k73O+zH3Xg+jzekREG6jCP5N0wmgLraEf9ECuIDE9Pb7+aayzQvooBVsDUG9kaH975k3ycAzSa8VsJWUUjg30ACtbRUyTu34GEsINY1rYUsULCqLVPsDeYL4kesAoo2Jmbl925vaLSgvpR4NJSlGG/Fes0AEXaG99xwaOTb4uXvi6vH6HhKDWnh+jVh4MRtVQmhBPq4CX6zjLYBawSCvl3mnZb3/oOQxlC0cFI7SHIUvaL4BA+/LXZDD0HS5qz1xNanJgi1+czGHlTfCj6D6tJ/VwBl6YIjckbJb/AwyfcL+4qlEMGu/EN0EjOQkMnagPfJKlBVha83wFGSj5e7j00de86lh2DID+anTsIvFbwukuWa5CGnkXXUcoG6Qh/Z1gE2Y/r63EjF+c6u5KetuReL+JEsgqAA+ATEJSPWyuWY9UUFjWLhRKUS6KrOVabDP4dA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(1800799009)(451199024)(82310400011)(186009)(36840700001)(46966006)(40470700004)(2906002)(4326008)(8936002)(8676002)(44832011)(41300700001)(5660300002)(54906003)(70206006)(316002)(70586007)(110136005)(40460700003)(478600001)(6666004)(83380400001)(36756003)(2616005)(426003)(47076005)(1076003)(336012)(81166007)(26005)(40480700001)(36860700001)(356005)(82740400003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 04:54:57.8812
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f001d3-1ec7-470c-93c9-08dbb5a7e93b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7317
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

Changes v7->v8:
- Fix a comment in cdx_mcdi_ctrl_flag_set()

Changes v6->v7:
- None

Changes v5->v6:
- change cdx_clear_master() to int return type

Changes v4->v5:
- No change in this patch, patch 2/3 and patch 3/3 are updated

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

 drivers/cdx/cdx.c                       | 32 ++++++++++++++
 drivers/cdx/controller/cdx_controller.c |  4 ++
 drivers/cdx/controller/mcdi_functions.c | 58 +++++++++++++++++++++++++
 drivers/cdx/controller/mcdi_functions.h | 13 ++++++
 include/linux/cdx/cdx_bus.h             | 18 ++++++++
 5 files changed, 125 insertions(+)

diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index d2cad4c670a0..9efb7584f952 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -182,6 +182,38 @@ cdx_match_id(const struct cdx_device_id *ids, struct cdx_device *dev)
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
+int cdx_clear_master(struct cdx_device *cdx_dev)
+{
+	struct cdx_controller *cdx = cdx_dev->cdx;
+	struct cdx_device_config dev_config;
+	int ret = -EOPNOTSUPP;
+
+	dev_config.type = CDX_DEV_BUS_MASTER_CONF;
+	dev_config.bus_master_enable = false;
+	if (cdx->ops->dev_configure)
+		ret = cdx->ops->dev_configure(cdx, cdx_dev->bus_num,
+					      cdx_dev->dev_num, &dev_config);
+
+	return ret;
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
+				  u8 dev_num, bool enable, int bit_pos)
+{
+	MCDI_DECLARE_BUF(inbuf, MC_CMD_CDX_DEVICE_CONTROL_SET_IN_LEN);
+	u32 flags;
+	int ret;
+
+	/*
+	 * Get flags and then set/reset bit at bit_pos according to
+	 * the input params.
+	 */
+	ret = cdx_mcdi_ctrl_flag_get(cdx, bus_num, dev_num, &flags);
+	if (ret)
+		return ret;
+
+	flags = flags & (u32)(~(BIT(bit_pos)));
+	if (enable)
+		flags |= (1 << bit_pos);
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
index bead71b7bc73..8320ec3b9e37 100644
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
@@ -170,4 +172,20 @@ extern struct bus_type cdx_bus_type;
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
+ *
+ * Return: 0 for success, -errno on failure
+ */
+int cdx_clear_master(struct cdx_device *cdx_dev);
+
 #endif /* _CDX_BUS_H_ */
-- 
2.17.1

