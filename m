Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE03276EC9E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236691AbjHCOeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236593AbjHCOdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:33:53 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE0BF0
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 07:33:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OuRznBx0D+3AYRHSbB8UpzqDF4f7tpRINqSchwUw+/rbOQF6ZY/a7ZJJs2W4BsbrCQgjYkYDNsPVK0Go21vlP9FQGGibK53ywuR5TB7cI7Sq78e6dqXkGt1T+3Kz2qgOiuKUPT+vgwpuyToDoKoftJAx3b07Ab0wiwIdW7MoQfulyNBvbhGG1Y6qq30PZlDhc6s25tN6In7wlMd6HD5NY3t+Z13UfUStXNIrWNbGIo9SDTCL6xjvf+bSf+6CAvOtUy8er56cx65vPdl9gpVxU49BmckxCh8UwxOleBfIRMdaq177cQcR8yeTjL1NZHkOLlk4bhCA+Yp1MBl7BBjYHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prxRzKnebEJ1ovhNzL9vipTjlItl5tkrLLekj391SAY=;
 b=OrlTB0BriWywpBlFG6tbIp3kTTHXK3XzVlVDlrzW/mJ6qwsYcn2wn1+FNdd3naK5gio2WQMlb8IBLoQgqL8X3mjh3hMlcLnShEbYvEQL4+u1G2bcHY0J678ON24UOoeKQA8/PC0DfmbFpyDbyTYMRqduX6YFbeI92N4ftOteXoPITXuK/f72GvVtBdCXMMp3TQa6ZR7eVfu3e1ondXf/1jWHtKmxRKXgWPfQ6HTeeNpqW6bUaJxEXe12F8+DX3kLiIKBfPOsT5d8eP4Sf6l2BQC8BcK/t54I5PfIcmC66FLKjsceQIUI2nDmzYedgDDZ/LAfMNHdWl+Lot0KnR5q/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prxRzKnebEJ1ovhNzL9vipTjlItl5tkrLLekj391SAY=;
 b=C5+cNPzmO68fW6ZOV2kFs1JWDdqXJveUDcfqwv8WIafUQhZAS3k0FojzXIApKvhkEcsNE1LBr8xLLzjeK2nf/FRGD73OuognYNdGS1ktj9z9wO0L8Iq5mPJYZoMHvZAnCdDmGyDdWWjAdNCKKlwKQndDtNxYc+h4YWZPiCQjafk=
Received: from CYZPR11CA0018.namprd11.prod.outlook.com (2603:10b6:930:8d::27)
 by IA1PR12MB8495.namprd12.prod.outlook.com (2603:10b6:208:44d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Thu, 3 Aug
 2023 14:33:00 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:930:8d:cafe::e2) by CYZPR11CA0018.outlook.office365.com
 (2603:10b6:930:8d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20 via Frontend
 Transport; Thu, 3 Aug 2023 14:33:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Thu, 3 Aug 2023 14:33:00 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 09:32:59 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 07:32:58 -0700
Received: from xhdipdslab41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 3 Aug 2023 09:32:56 -0500
From:   Nipun Gupta <nipun.gupta@amd.com>
To:     <gregkh@linuxfoundation.org>, <alex.williamson@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     <git@amd.com>, <pieter.jansen-van-vuuren@amd.com>,
        <nikhil.agarwal@amd.com>, <michal.simek@amd.com>,
        <abhijit.gangurde@amd.com>, Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH v5 1/3] cdx: add support for bus mastering
Date:   Thu, 3 Aug 2023 20:02:51 +0530
Message-ID: <20230803143253.7817-1-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|IA1PR12MB8495:EE_
X-MS-Office365-Filtering-Correlation-Id: b90a0ecf-bd2a-49ab-60fe-08db942e89aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZK4YajgBI2zVgd3IL8O1Kgx7L4ra/K9OkB2Ve0NRlb8vrMYAhNQRbPk7pNBA/i9egziVfsmQM+vL+Q+i9qtxaV1qNBhd0a+aRcC8766tEs0YdMiUWSazmXfD35/KDxGVnPunxPc2sEJRlB7gMQ4i9nXzh9O/rrBzIV5Juw40tu6f4JiaeeRxrGA6KvGDUXWHFtBERh4D9jumFpOGKnzt5k8/gkZHtZ3k2DQk3qvgbZnw4X8mDb/6QcT+V/JTjWn9H9ObJoJ2gMgNggd1z88A8bIXtwZJM5KGawh8jxnAdDmTRf1ppHvQeeILWJELLlquYt4hFqcrKQOfub4KWcaFKXyghyojglB80Uu5dOTHspVgUhvifliQXfqGIFIlOCeNAFhNgdlMwSYbuId85xAM83SNeGc0rm6+qioqZHGb7MYOVEKzri7CaAP7IWQixuYNFtRCouXoGmsP9Pcy1cucsGhcKOvKUDN776alIFoqkhSh0eAr4D67Wzh975x+Js73xguNTRaz4GwHsuyfru7WFBX2XQYuauSD1xj+luvfTsI1vaBVKzK9k7ocxW7XU6bgMb+vFX/Gn3h65aTbl3tGwtCffSIBwW0n8Vh8L/93CkLAY7z0EqP1/CgSv3k8eZa4CmU4iYkUm1RsRlzvfLVYui1Lg0zDpH1hnWrM12KAwems5mqlWnX0kQdn7dqEBjcv/NSbejGnNoId65NRLVPczxGmwegeJX4iazq4Ms0hUb3j3z1p74Mz7pR+9segAZobJRHkYgB/pq+dJknkv6PmgA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(54906003)(5660300002)(44832011)(478600001)(82740400003)(81166007)(110136005)(6666004)(356005)(40480700001)(8676002)(41300700001)(8936002)(1076003)(26005)(2906002)(4326008)(186003)(70206006)(316002)(70586007)(86362001)(336012)(2616005)(426003)(40460700003)(36860700001)(83380400001)(47076005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 14:33:00.1014
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b90a0ecf-bd2a-49ab-60fe-08db942e89aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8495
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

