Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC187578E0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 12:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbjGRKHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 06:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjGRKHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 06:07:05 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F6BAC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 03:07:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TX43MvkQRRyT66SCC1F7eTkrmcHNUiLRbZmxItpmgxgHi2vdQ+/NiFfXWr7o4Lria3GEQrmkgthpKDPjgiqAf1LPoTzVUFexh80rNq0WqmcExy1lrPp0T0jxjQMFmO/Bsq/4P4X6jsPu0Iuz1q2SgUYEO8S2VqkcB1vdV5/SIxqw0y1aVxwjCrSvFfug/+JKDPgr6ncf2MdavAh84MKcgfufJUqs28Gmizg5GzUzSNu+1kf0IdUXuRWbSGXQF0ERZopqCp0o2I7vdKbekKHquN8NT69feFENk7ISS3cOX+tKyCyZNCFiv7LZpf5oV5TFTUux+wgM/ptFxakXleDPFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxM31rgwyR4onQrmS34rLirBafDExaAsoSsWm+DdvGk=;
 b=Ots0g6IUzTRCJ419QbyZ41GUSJ4FGJz/kQUki+hJHgXncSRt8Jsgjnw/34POQBTaVt17DsUjyr/RXDbiZ8Uw9KmaQ9y84rgBgTJEWAj4qnXFpd1sRB0gO+QCNzvBzArYp2a/U9QupSYEXJ14zF6QUIEhITsD/VsgXo/2nmT8thi3rvhvcuzNR8t7c8Cl9slrc7qx6uviCiVZMYq5UqcWlzpjzO9envDvmmjUO/V78Xp/KCr3aLEhLZcREAR0k7uZfTMHT3ADfWGKj4jz7+HvqX4frMk64J+Jad5Rq34tNb+HXHkAZAnN5JTLbOAqn5wpeaMsrXRARst2AEvkuz/YVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxM31rgwyR4onQrmS34rLirBafDExaAsoSsWm+DdvGk=;
 b=TOjsw9wEvwsoDlyyv6RbSvnE4PDZvx3Mk4OWwgLbEBlx2tfKMBPG3Qhn8BCQMXRr6zh7InHTLs5FbwYaYrvKx7e8CBOCjHB1clDhgfrWeoernXBo42yAIg1XAIGjitm4tn3dlz7YKXrjSE7pimmaPZCZJTzWYLWYONtdVz38zKU=
Received: from DM6PR06CA0013.namprd06.prod.outlook.com (2603:10b6:5:120::26)
 by DM4PR12MB8497.namprd12.prod.outlook.com (2603:10b6:8:180::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 10:07:00 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::8f) by DM6PR06CA0013.outlook.office365.com
 (2603:10b6:5:120::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18 via Frontend
 Transport; Tue, 18 Jul 2023 10:07:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.33 via Frontend Transport; Tue, 18 Jul 2023 10:07:00 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 18 Jul
 2023 05:06:56 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 18 Jul
 2023 05:06:56 -0500
Received: from xhdipdslab41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Tue, 18 Jul 2023 05:06:53 -0500
From:   Nipun Gupta <nipun.gupta@amd.com>
To:     <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
CC:     <git@amd.com>, <pieter.jansen-van-vuuren@amd.com>,
        <nikhil.agarwal@amd.com>, <michal.simek@amd.com>,
        <abhijit.gangurde@amd.com>, Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH] cdx: add support for bus mastering
Date:   Tue, 18 Jul 2023 15:36:51 +0530
Message-ID: <20230718100651.18317-1-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT065:EE_|DM4PR12MB8497:EE_
X-MS-Office365-Filtering-Correlation-Id: 28f384c3-bb23-46c5-34f9-08db8776ba32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AVMVbf5GLnr4J4missLEyv2HWwSOBJQssORxr9nqwwsk6296Qs0rvTq/IXTpTOethu29snImSHfE2lJOxFcB5F82eD8dcaq4NmFID5pm0VfHedlx8gmWNp5WkfdgcbmDCXdpxmmqquytthT7bs3lyMXrfm/wedAlQpuvTNp1vcP5w6aAG1xBqGoOq3HTj26MpbsA19GaPIXDhZdMkEOwQjV4Kb0rYB/MZEnqL9yO+Lg06ueS+aHNbIwCXlbRH8pJLLJRGIWEkJjQFFZeNxVBTrIu1Quhn7uylWO/mD0Oc4NRMwUQ5HTsLLlouw22qKTedU6RRHPr9MlKdY20WdPRTLCjx7qOEkKu/7W6K/Dp7bTVEQfyPbCFA+DKE0FsIjvgb0+F/TxXipmD+3V/JC36lc2Ju0tNY4tvImToch5R+GsP8Ngrkw899iv9QY2h4FcJU7Po+pgsTpVLaJ9brAe3csPrDQ8JABpQyRQLD3u7UHMeEsNgDv9ujopvEJSiXtocJZJo5IAVuNU77c5ge6IlOVe1DRJt+G8D7JEgDbEf2SvtZSwJ/zJbQj7RLuGiBSA5rmZwprR+OGVVfLlyXgmzY9nM7eEd0vD2iMekg4KcsXnNR1m/MLVDUa9gfP78jfxlGB4mwKFrZ8HvIWlIwEIUwlyxKEKBzFwbFfZK5ymJNFcu9hQlG81tpSVq9ZJoFyb16SyxIQSwwKGMyKQZCsixNP0ZUOjhV3i100d0IUdaOBBJWdSk9DCSyUOtaRNfODuajNBDtr8dcOwVFympqUFo8g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(8676002)(8936002)(26005)(41300700001)(1076003)(40460700003)(110136005)(54906003)(81166007)(356005)(70206006)(478600001)(40480700001)(70586007)(4326008)(316002)(36756003)(82740400003)(86362001)(47076005)(83380400001)(426003)(2906002)(44832011)(2616005)(5660300002)(336012)(186003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 10:07:00.2019
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f384c3-bb23-46c5-34f9-08db8776ba32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8497
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce cdx_set_master() and cdx_clear_master() APIs
to support enable and disable of bus mastering. Drivers
need to use these APIs to enable/disable DMAs from the
CDX devices.

Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
---
 drivers/cdx/cdx.c                       | 32 ++++++++++++++
 drivers/cdx/controller/cdx_controller.c |  4 ++
 drivers/cdx/controller/mcdi_functions.c | 57 +++++++++++++++++++++++++
 drivers/cdx/controller/mcdi_functions.h | 13 ++++++
 include/linux/cdx/cdx_bus.h             | 16 +++++++
 5 files changed, 122 insertions(+)

diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index d2cad4c670a0..efb24672b7d9 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -182,6 +182,38 @@ cdx_match_id(const struct cdx_device_id *ids, struct cdx_device *dev)
 	return NULL;
 }
 
+int cdx_set_master(struct cdx_device *cdx_dev)
+{
+	struct cdx_controller *cdx = cdx_dev->cdx;
+	struct cdx_device_config dev_config;
+	int ret;
+
+	dev_config.type = CDX_DEV_BUS_MASTER_CONF;
+	dev_config.bme = true;
+	ret = cdx->ops->dev_configure(cdx, cdx_dev->bus_num,
+				      cdx_dev->dev_num, &dev_config);
+	if (ret)
+		dev_err(&cdx_dev->dev, "device master enable failed\n");
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cdx_set_master);
+
+void cdx_clear_master(struct cdx_device *cdx_dev)
+{
+	struct cdx_controller *cdx = cdx_dev->cdx;
+	struct cdx_device_config dev_config;
+	int ret;
+
+	dev_config.type = CDX_DEV_BUS_MASTER_CONF;
+	dev_config.bme = false;
+	ret = cdx->ops->dev_configure(cdx, cdx_dev->bus_num,
+				      cdx_dev->dev_num, &dev_config);
+	if (ret)
+		dev_err(&cdx_dev->dev, "device master disable failed\n");
+}
+EXPORT_SYMBOL_GPL(cdx_clear_master);
+
 /**
  * cdx_bus_match - device to driver matching callback
  * @dev: the cdx device to match against
diff --git a/drivers/cdx/controller/cdx_controller.c b/drivers/cdx/controller/cdx_controller.c
index dc52f95f8978..ba670f0427d3 100644
--- a/drivers/cdx/controller/cdx_controller.c
+++ b/drivers/cdx/controller/cdx_controller.c
@@ -55,6 +55,10 @@ static int cdx_configure_device(struct cdx_controller *cdx,
 	case CDX_DEV_RESET_CONF:
 		ret = cdx_mcdi_reset_device(cdx->priv, bus_num, dev_num);
 		break;
+	case CDX_DEV_BUS_MASTER_CONF:
+		ret = cdx_mcdi_bus_master_enable(cdx->priv, bus_num, dev_num,
+						 dev_config->bme);
+		break;
 	default:
 		ret = -EINVAL;
 	}
diff --git a/drivers/cdx/controller/mcdi_functions.c b/drivers/cdx/controller/mcdi_functions.c
index 0158f26533dd..c4c00f376006 100644
--- a/drivers/cdx/controller/mcdi_functions.c
+++ b/drivers/cdx/controller/mcdi_functions.c
@@ -137,3 +137,60 @@ int cdx_mcdi_reset_device(struct cdx_mcdi *cdx, u8 bus_num, u8 dev_num)
 
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
+	int ret, en;
+	u32 flags;
+
+	/*
+	 * Get flags and then set/reset BUS_MASTER_BIT according to
+	 * the input params.
+	 */
+	ret = cdx_mcdi_ctrl_flag_get(cdx, bus_num, dev_num, &flags);
+	if (ret)
+		return ret;
+
+	en = enable ? 1 : 0;
+	flags = (flags & (u32)(~(BIT(lbn)))) | (en << lbn);
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
index bead71b7bc73..acb4e40bd20e 100644
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
+	bool bme;
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

