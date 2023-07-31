Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF04769253
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjGaJvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjGaJvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:51:17 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6A7E65;
        Mon, 31 Jul 2023 02:50:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SbvNXN3rBwseUmk2wJBZvg24OcLuoROu1WDe9oZtuqqlHIKuZofEeGPc65xFvvC45VzBJuFRPwiesofMOanLp7La5FAO2YNGt44iZU4/uRcQX9qTfKLpYfyo3ZW9yxXo4J5GLFw3jUzwHtIrH+jevbzJa+u1UuA+0KTyEkGAq+pcEZ3kZcqZQOcuZIHtRNEnvF2EzwDDIkeIC4SNIA5wLps1ao7WtSsMDpJiN6dGoXRdikMugaN46T/aG5fDYX5BSvstL2qr/lZdMKFLHIHRLLhGBuow2H23kNgsurVo/hdweYukLaFlGkyw3pGb1E28L/wgiIyPj+vFhOsxOy8i3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOvxlEc20D00TShqhr2K0fPNv6SMNlfnnyJNQTfF7gc=;
 b=a0l70FNKVyhF9nCbEA1KQ6wuKacZ5fJSW0yW/RBQWbJYz37New7nFv4BiItEV6zZ6VN+ymhK5jbR62fXBFdxmGMSVxXsklbFJOTtdCyFOlNI4W2cVRJmgM//UnDdDtpc5w+Ac1pbn5RBv1y0wG24ZQhFjCKCcziQlUmlLCf/UJMeVtoovhArugbHHZLgz3kKhROpn6ouNgA4rNLzE7q3Rw+IdJC/96Ln/DzFG8PY7YK9MN5ySf+Oqx8hrdb1ejrPXSNh3Wi1CjO6/f8mKeWhzENg6zf8n3TeZw2zHxjh8CWAr1WfPIKn4+sjo0JKkQqqj5rCZ8RZ5c1KjOivGUY1zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOvxlEc20D00TShqhr2K0fPNv6SMNlfnnyJNQTfF7gc=;
 b=uOpMQVYRVZCpv59YizTP+h9Ay2UyDLN+iIE/6OFcNmH0hIruaCpQJcySRKs/RyPwqaNKg6lBn+/ki0pbvp3XZE/pG0udWX30XgzIEkIM8WB0fZnIh8joIHZHljwXDzNpP1RQrBoEdP3VAnr+o7c6PgIXlJiITuwKQDyGlMQU0HI=
Received: from MW4P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::13)
 by LV8PR12MB9135.namprd12.prod.outlook.com (2603:10b6:408:18c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 09:50:38 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:303:114:cafe::fe) by MW4P222CA0008.outlook.office365.com
 (2603:10b6:303:114::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42 via Frontend
 Transport; Mon, 31 Jul 2023 09:50:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.0 via Frontend Transport; Mon, 31 Jul 2023 09:50:37 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 04:50:37 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 04:50:36 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 31 Jul 2023 04:50:32 -0500
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
Subject: [PATCH v3 1/4] firmware: xilinx: Add support to get platform information
Date:   Mon, 31 Jul 2023 15:20:23 +0530
Message-ID: <20230731095026.3766675-2-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230731095026.3766675-1-sai.krishna.potthuri@amd.com>
References: <20230731095026.3766675-1-sai.krishna.potthuri@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|LV8PR12MB9135:EE_
X-MS-Office365-Filtering-Correlation-Id: fb9f08e0-4b0c-47f2-c0d1-08db91ab9823
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wlV4rwD9evf8HEWaORkDDCtCOrtvzMRAOdpvJDkXc4Zm8O3mBRxqqbKa4vkDfR0NJ+NcYOd86sLnQOH+wNLUPN1BAEZPbYKWcT7MAfGli5r8NnQQbIQZI0J4ejHPeDUgHGHmk6fostMq21Gu6MSs5mw31mjv77eKVA1npx/DS/Anxy3X0SBNfQ4Ct6gK8STEa0RlD3osnA5fEx6RKlz/FqQL5I9zziJcK2Z2f4jV1NqQXpqvgm5p61eZIm9+BKuT35W5PaiufmmmZ2hEs3wZ9k3Zf55YQvmouh0zPzB4NNB4dCpDjdN/rZHxnhJlo9Y/LoqIWKtizIuAm9X4zEwAv4kpZLDaToL8ICu9fLUpMJq1eFZDAvIAoNsP2LHT1UNCa82FcxXKIQRBp4Obv2DyG7fgJm7MH8uTN7FcOcPo6qLVZ8WRfmfCBrsKNfdSsyDqA6XFkwSvWJMGzVoWuRYwepdYRLRaDIEw2hwItw2Ts9z/w300oEY5I2gmpItTPHCGLrJncCXB3hkWw4juKoxxdnZByp3U0r51U6lQoDx1sQufORzfPfiJwRfWuZ6TO18sY8RnXQCJ7dmfARsd741djk21wCayznujv9WejezK6T9qljiv9dT7bV40SjNudSSYd4/LbfFRByj0L80Xd6iflMMu33ER3d/naIjtWvGY1xTamkYov7z4N18zapsr9Fk5ld33qa+flAeAUy2XNjfhZ0+cWD6vR+Al+vX5hSSB+9ahYWuVlY56uxnuiPnGMETXkh2bGyp5YgOdDHR+qxUqXNXv5/+RKiaoJSiY5B2cAOI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(47076005)(36860700001)(36756003)(40460700003)(40480700001)(2616005)(1076003)(26005)(336012)(186003)(426003)(70206006)(70586007)(7416002)(81166007)(356005)(921005)(54906003)(103116003)(110136005)(82740400003)(86362001)(316002)(4326008)(5660300002)(8676002)(8936002)(41300700001)(2906002)(6666004)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 09:50:37.9253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb9f08e0-4b0c-47f2-c0d1-08db91ab9823
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9135
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
Reviewed-by: Michal Simek <michal.simek@amd.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 40 ++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 11 ++++++++
 2 files changed, 51 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index a736db4a5825..e204e2866d74 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -339,6 +339,8 @@ int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
 
 static u32 pm_api_version;
 static u32 pm_tz_version;
+static u32 pm_family_code;
+static u32 pm_sub_family_code;
 
 int zynqmp_pm_register_sgi(u32 sgi_num, u32 reset)
 {
@@ -404,6 +406,39 @@ int zynqmp_pm_get_chipid(u32 *idcode, u32 *version)
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
+	pm_family_code = FIELD_GET(FAMILY_CODE_MASK, idcode);
+	pm_sub_family_code = FIELD_GET(SUB_FAMILY_CODE_MASK, idcode);
+	*family = pm_family_code;
+	*subfamily = pm_sub_family_code;
+
+	return 0;
+}
+
 /**
  * zynqmp_pm_get_trustzone_version() - Get secure trustzone firmware version
  * @version:	Returned version value
@@ -1911,6 +1946,11 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
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
index f5da51677069..075a8f7f1706 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -34,6 +34,17 @@
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
+#define FAMILY_CODE_MASK	GENMASK(27, 21)
+#define SUB_FAMILY_CODE_MASK	GENMASK(20, 19)
+
 /* ATF only commands */
 #define TF_A_PM_REGISTER_SGI		0xa04
 #define PM_GET_TRUSTZONE_VERSION	0xa03
-- 
2.25.1

