Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67149755F69
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjGQJgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjGQJfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:35:39 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C09173B;
        Mon, 17 Jul 2023 02:34:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cgcTmZUjetwte3N1e5GKweCnoSSRPRXnA/GyWoYBxdxGii3NgaPRIqwQWlLLip3BAXog8ko0eJ8eB8lbqYlU3HKiXv4EVb/j7YFdA0ypRqEcCPcGDlCn8U5BLcANRrjPUSBYesuzn6gi22L8L9rVYJO8rp1/S3MsYpBHVtUV0X5MkaW2DTQYYnwnc3pW/wgdPlcC66vkGp8SsZT2qJtO3wJFXh2/ksfEmsQyCSLB8RkTJmkG6zCBdgaiQW+k/7l9kWQP67dJi3tHq0bE8gQRaYTCP0VwFZsmSdCnEAxiLqlZLuqi51MjCM2FiuGf5vtGS8J5oZlcKgisMeKhmFiZ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHIItiCgk7GS9F3ClxxPTL+qbEQc4AbSiOApPMJFNYE=;
 b=HGCrISUoaZGbw5LKfiNTH2ecALMQklCjoVqIDMVTk6jyAqwGzn2SGipmCZHcpAeIxiV/9eAAF6VGX3BqGDvZzZJ3y9Fcfyjftg5k28Apo1Zl/FZSDOawgqDVfWsRTjst3FwqFLxFKbROzjwm9IzZSd3BNHpBQJlHw87XCMigOY+6V1kWSK1GR5h7ibzY4DGlglYT+vPl7nQMRKvpFgeWM6K/7I5XJHkGF7VJSQHNvI+dfU03kfKjxCAKIEutg39YmTXei4/7WuTvYDyErL5RfZJAf/kfVqClWE3/FoUxRNpb+KPwFF2nB+aVvInGn9LPxpmDt/RHb7ugJfHi/mQqeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHIItiCgk7GS9F3ClxxPTL+qbEQc4AbSiOApPMJFNYE=;
 b=Oof3qFc4BoT6EJvikQTq5v8VCwLDczbp6QLu9O841V984iJ0QQrpt3LAvSIkm8v5T3Sauy7KzD3ztOtQW42iecLJjX4/bCNbPslVUwN1OSpSAjvE4gogHR5oy02ITyIZEO90EPAtQnvlAgpf83NZn5aX5BL9tjZMxkHmVmLAt1w=
Received: from DS7PR03CA0201.namprd03.prod.outlook.com (2603:10b6:5:3b6::26)
 by CH3PR12MB8582.namprd12.prod.outlook.com (2603:10b6:610:163::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 09:34:33 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::22) by DS7PR03CA0201.outlook.office365.com
 (2603:10b6:5:3b6::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Mon, 17 Jul 2023 09:34:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.32 via Frontend Transport; Mon, 17 Jul 2023 09:34:32 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 17 Jul
 2023 04:34:30 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 17 Jul
 2023 04:34:29 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Mon, 17 Jul 2023 04:34:01 -0500
From:   Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Tanmay Shah <tanmay.shah@amd.com>,
        Ben Levinsky <ben.levinsky@amd.com>,
        Marek Vasut <marex@denx.de>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Arnd Bergmann <arnd@arndb.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <saikrishna12468@gmail.com>,
        <git@amd.com>, Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: [PATCH 1/4] firmware: xilinx: Add support to get platform information
Date:   Mon, 17 Jul 2023 15:03:44 +0530
Message-ID: <20230717093347.3869167-2-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230717093347.3869167-1-sai.krishna.potthuri@amd.com>
References: <20230717093347.3869167-1-sai.krishna.potthuri@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT053:EE_|CH3PR12MB8582:EE_
X-MS-Office365-Filtering-Correlation-Id: 6479342e-8b16-4cae-b423-08db86a90723
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: or8Qyc2PvIn4i9vsUuXUOWbO/DzhW1khdK3aRkr6suhwm2QN/zeiRJxmPdci6gdbGeNW8KkvTw6yBywV61iPt5KOmZ1AnT75Q3+5LoTn6U9eBnuEyvJl3QcXntXhFF85WEzKVJKLrNrw/M5UxVfcwd9YJmt7hdzVHzb2xrajHHns7Equ0LYRqUGngXIqDYXSF506byNnDMWJMqeMOblrnnxoVIi9Dbl7Y0TfpIhy3k0sgQiz8x960G4RZB/3jJg+NL6f2c22lQtTof8h9mYF4YvGjxqRsx/LiqTFgCGcB25M/JMDI1QRxM/hJyKoZ7t8q2FmyN9qcvQM8KoraWtLowth+PYx9am9k61hjDT3l5F1mvBBM6o0ZPF4dJiDDmlv7QkVc2UKP1Kg5EizlOPWzaZIGDRqjvQCmkyCGJ+UFX8pTmlCAmH18ej2gOauX2MxJvKAGHX1RsWBgnSSfUZvBSa3JPS0dOPawlwbDb+3K7fcdNNFtWfFGXeozFOYUB8UiN7FuvYhctexoqOoYRLfV0Lampd5I8Fy1W7XNpFkSUurBUXcPBz8glM8ObL17YAxtuZ6RaAYGTDez7ENJKZNQ1NL57p0kmObyAAt3EBAlUX7rgJ8QXaSIbjEcR6X+bS7HJgoXcvpaJW5aj7L3sk++UGwfHA70v24e2hUw568E4jcqpt/zozo6rgz2fbHRRL7jGymJGwzuK4h/F2LazqDu0DRpqTWiJQy68wUDzZLoG/d77B4Mi1/QYwbYXPkFlTmYAyjMTlQTKkd5ELC6QF3sH7bjLqQQfRtQgPiCfVz2wo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(2906002)(54906003)(110136005)(478600001)(6666004)(8936002)(36756003)(8676002)(7416002)(41300700001)(316002)(70206006)(70586007)(4326008)(82740400003)(426003)(336012)(47076005)(81166007)(86362001)(921005)(356005)(103116003)(40460700003)(5660300002)(1076003)(26005)(2616005)(186003)(36860700001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 09:34:32.9807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6479342e-8b16-4cae-b423-08db86a90723
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8582
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dhaval Shah <dhaval.r.shah@amd.com>

Add function to get family code and sub family code from the idcode. This
family code and sub family code helps to identify the platform.
Family code of any platform is on bits 21 to 27 and Sub family code is on
bits 19 and 20.

Signed-off-by: Dhaval Shah <dhaval.r.shah@amd.com>
Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 42 ++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 13 +++++++++
 2 files changed, 55 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index a736db4a5825..f9498e7ea694 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -339,6 +339,8 @@ int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
 
 static u32 pm_api_version;
 static u32 pm_tz_version;
+static u32 pm_family_code;
+static u32 pm_sub_family_code;
 
 int zynqmp_pm_register_sgi(u32 sgi_num, u32 reset)
 {
@@ -404,6 +406,41 @@ int zynqmp_pm_get_chipid(u32 *idcode, u32 *version)
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_get_chipid);
 
+/**
+ * zynqmp_pm_get_family_info() - Get family info of platform
+ * @family:	Returned family code value
+ * @subfamily:	Returned sub-family code value
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_get_family_info(u32 *family, u32 *subfamily)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	u32 idcode;
+	int ret;
+
+	/* Check is family or sub-family code already received */
+	if (pm_family_code && pm_sub_family_code) {
+		*family = pm_family_code;
+		*subfamily = pm_sub_family_code;
+		return 0;
+	}
+
+	ret = zynqmp_pm_invoke_fn(PM_GET_CHIPID, 0, 0, 0, 0, ret_payload);
+	if (ret < 0)
+		return ret;
+
+	idcode = ret_payload[1];
+	pm_family_code = FIELD_GET(GENMASK(FAMILY_CODE_MSB, FAMILY_CODE_LSB),
+				   idcode);
+	pm_sub_family_code = FIELD_GET(GENMASK(SUB_FAMILY_CODE_MSB,
+					       SUB_FAMILY_CODE_LSB), idcode);
+	*family = pm_family_code;
+	*subfamily = pm_sub_family_code;
+
+	return 0;
+}
+
 /**
  * zynqmp_pm_get_trustzone_version() - Get secure trustzone firmware version
  * @version:	Returned version value
@@ -1911,6 +1948,11 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
 	pr_info("%s Platform Management API v%d.%d\n", __func__,
 		pm_api_version >> 16, pm_api_version & 0xFFFF);
 
+	/* Get the Family code and sub family code of platform */
+	ret = zynqmp_pm_get_family_info(&pm_family_code, &pm_sub_family_code);
+	if (ret < 0)
+		return ret;
+
 	/* Check trustzone version number */
 	ret = zynqmp_pm_get_trustzone_version(&pm_tz_version);
 	if (ret)
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index f5da51677069..d7f94b42ad4c 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -34,6 +34,19 @@
 /* PM API versions */
 #define PM_API_VERSION_2	2
 
+#define ZYNQMP_FAMILY_CODE 0x23
+#define VERSAL_FAMILY_CODE 0x26
+
+/* When all subfamily of platform need to support */
+#define ALL_SUB_FAMILY_CODE		0x00
+#define VERSAL_SUB_FAMILY_CODE		0x01
+#define VERSALNET_SUB_FAMILY_CODE	0x03
+
+#define FAMILY_CODE_LSB	21
+#define FAMILY_CODE_MSB	27
+#define SUB_FAMILY_CODE_LSB	19
+#define SUB_FAMILY_CODE_MSB	20
+
 /* ATF only commands */
 #define TF_A_PM_REGISTER_SGI		0xa04
 #define PM_GET_TRUSTZONE_VERSION	0xa03
-- 
2.25.1

