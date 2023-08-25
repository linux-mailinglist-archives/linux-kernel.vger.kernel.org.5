Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB44788842
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 15:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245037AbjHYNR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 09:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245073AbjHYNRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 09:17:36 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED7E2117
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 06:17:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NskqS41Evx/wjdfjfCo/czrKBos/gDsh8jRdzVK6sf4ljeiRkij81IPZ+b2LdQUn6nPVVzfHvCusKpX6dIQqRMt2ab7H1vAP5sHnxW/ho5pDXckhi5srrHQgi3vRHRoOdrDk2LtAR0LLkgto8QO5E4iEhJAq3CqfKxz6Mc4zGznM+T6ACXiHIiMHWL9+rVfowqxTlBe8tJnaL08XVcTXKweRwXuu0BTbL7waN0SPMCduY+LkCaw0XqTKZVeUcP6dOjR9Iyi1OyUEhQT41z+tj8daXydFBCOKOLpzoqu63DbEpUoPniDpcirlJV3yUoCYGl2SSIXULVbk25gtatXyhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=od8D7+KvReh6A1jwHDgHskpApYaSe3oxUqI0QshTxa8=;
 b=ODvHlOR2x3pSfaBDpSchcyjuX6sOmomoB8GVxF/GwrVzF0ZJV3yhO4sX+wPj/dDmEaL1KE7sI/7mifzYJG3eIGckoziaoThxkpRSkpBs/KAm+MsA9fKW1ZoX04VoJaE/JO1YySJV3W5aZG3gh1HCTaI+szpyEtKvjt7H/9uozGK8YKVsTZ8e07KtjcO4c9mo/vxClnZpyR0PBwXd3ZB5L2hiB3QzHoKCBdIHlZsQ0wt/3zu7KXeT01/kFh6JAkfN4RZJKG4ZanJvNRXjIlI1hKAfai4/0mjwwnsHqb/xypnqr5dHBKYAMA1A8GSywJf3pHYVPM9MRkz+f/PYjdbNGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=od8D7+KvReh6A1jwHDgHskpApYaSe3oxUqI0QshTxa8=;
 b=3bPkn2spFBxrKCPS7MeSYyEcWxofBjtuPyFUPA7cPCprCb02nZk9Cdw2bGg7Z6xCIhsLotoSYQ6bXtPwya+3sjCQirL8J1FjZw6drmU/c3LrH7Voo4uh8rbRL2A64B96Ph/lze1NhOIL10DBBZaOOMDiJQ2HlU2LGXE7c5vDUkA=
Received: from SN4PR0501CA0107.namprd05.prod.outlook.com
 (2603:10b6:803:42::24) by BN9PR12MB5226.namprd12.prod.outlook.com
 (2603:10b6:408:11f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30; Fri, 25 Aug
 2023 13:17:28 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:803:42:cafe::e0) by SN4PR0501CA0107.outlook.office365.com
 (2603:10b6:803:42::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.20 via Frontend
 Transport; Fri, 25 Aug 2023 13:17:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Fri, 25 Aug 2023 13:17:27 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 08:17:27 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 08:17:26 -0500
Received: from xhdipdslab41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 25 Aug 2023 08:17:23 -0500
From:   Nipun Gupta <nipun.gupta@amd.com>
To:     <gregkh@linuxfoundation.org>, <alex.williamson@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     <git@amd.com>, <pieter.jansen-van-vuuren@amd.com>,
        <nikhil.agarwal@amd.com>, <michal.simek@amd.com>,
        <abhijit.gangurde@amd.com>, Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH v7 1/3] cdx: add support for bus mastering
Date:   Fri, 25 Aug 2023 18:47:14 +0530
Message-ID: <20230825131716.28610-1-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|BN9PR12MB5226:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ba5a619-4902-462b-e463-08dba56da136
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0kp4Wo6pdx9jleMB8sjxGP96AT1+OFPpTEBNPyMVt6ap3NCZ4CeM+SbVu3flc+zGUJ60QAtbMLUie29BrjwQ3igbX/GK4HXjNLr6gaT7PNAAfL0+7LG6dIKAfTiH87OzBaDpJq/jhnWWhwlwplsxqEDhqqNqF5zJ77LrHUmbibDz5SLSdpXmpgs2bUhhdIPPUNjiL3Z+fCqBuFJipAWCRMHbKml6uQpxsk0HDmPuHScClKwBLFx9/hxRm/FD+v3cOg8myfEuD+pueIglq9xgw/dpf5JZpq87UPDmOmtLm1Je+5R4YPWDa9V4JDtyWVvwOjiFsrb0fnvrvUhQIsSvmETWSWIQbnWYGSjBLnL11jxDy5cl6Dq61pM3XsAycujertSVWLsiWE95DGdTfyQTICNHSvtwV0aMe+HvtWc+XivBiYag7WfyUdYyvY/49gjosF5HS/W1HOFrsr7gYmjS6UnsnuIBvr79aEPPhmr2mraUs4leM4+9C0uJTItuqgAQAtu2lsCaMuEumc+T4Vxqx5Z+vhWLJMP3hSqb41+Fl8hT1L1mV0zEgxIq82+IfJRaq0rEVBjt29CpJOCByP5QQDxug+XpfqR45f7ZQLdLGDdY0HjqehY26hqeN3q71j1MiPI2aeV4poSMsbhK58OOPfLeuxwYNoi5nsLzUBmeLaBWrubjwIhifEhdxYIHvtMGyZz9hDEd79iL85i7dSn745ClmsH7cWfASysteQjqyJQBe0zLtJwKxEblQBCvDBCw4Gh/tyNkfz58WznNcNDHsw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(136003)(39860400002)(1800799009)(451199024)(82310400011)(186009)(40470700004)(36840700001)(46966006)(1076003)(36860700001)(44832011)(336012)(83380400001)(478600001)(26005)(47076005)(40480700001)(2616005)(426003)(5660300002)(2906002)(8936002)(8676002)(4326008)(356005)(82740400003)(81166007)(40460700003)(110136005)(70206006)(70586007)(86362001)(41300700001)(54906003)(316002)(36756003)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 13:17:27.7179
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba5a619-4902-462b-e463-08dba56da136
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5226
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

