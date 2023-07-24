Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3EE975EE2E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbjGXIqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjGXIqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:46:23 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EE71A1;
        Mon, 24 Jul 2023 01:46:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j640vLtALdGw59z9aIN5NxKpC5yx2roA0mO6FAnA6Njvl963Q7JWn84iSbMlT9xyO6zruXeVI//BYNX+/qSWwpL9yUH5kIi6lM1/po+Kh6IEKDG5rCCIbFG7pjvujTDiwRMMX2hUcayBB+kdOm6+TjVnGo/VOhrM5Nrh7lGgt44SKi9iVjFVAsszluwPaFOkDGoKY4H6uShgOqSAys+ZBur8SH+tdyBHL+Cjop/fawhxjt+jl/FWoFdhtmcl63npG8YmXeRoikGHM3rR/Uz3DNl3sSpA/I3qztyssjl6cQalxxr2LIlNpZ77pc/CvfqX4OB3sUBbtiraWYNQLZeqhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHIItiCgk7GS9F3ClxxPTL+qbEQc4AbSiOApPMJFNYE=;
 b=L6x5E4UQh1r/S6WXeoEoV1ck/He4ecSkGn3yOCPNbV5HdlKnfTvCofGhz8NqZsURKOTtMHGEvzmHUdi86tmmfU/yYaO2lHed/eWi+Tk7u7OdFVWjxJZ6VGp+4ke1edtvWc80hZkSUcAlaFr/U0ygLX0m1YcEuxZjti7fxag07gw0VCsjCgr1oLvB2EU9eT7g6OgTr1YUzJJc68augfNRGE/ViPcDdHMDHlUIt0lxdSJSrhjAMAwdjalQl7Q6Ge33V9ByPo8KVMvLHEOlanvqvzJDKkCU8PKUjS6kHvcVmG7Wr+I4uVoo3eHMWILpmbzrVSy/59QWV+3fl9CanXBJDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHIItiCgk7GS9F3ClxxPTL+qbEQc4AbSiOApPMJFNYE=;
 b=dqDWw04z11Dsz2/LMnt+Pb5AUwStwnftOvuHfP4l+O+ulkQftE5LjCKfcUSO98bjxImQULVjgtNUAw6VISs5UbHjdXRwsua5GGqCy7WXcc+90cwgEcLi4AKqsc76zhwD2AW0obo3eaalWHL0z0PrSNGZjHgnkpg+wMhOK6ZJCpA=
Received: from BN0PR03CA0046.namprd03.prod.outlook.com (2603:10b6:408:e7::21)
 by SA0PR12MB4590.namprd12.prod.outlook.com (2603:10b6:806:93::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 08:46:17 +0000
Received: from BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::56) by BN0PR03CA0046.outlook.office365.com
 (2603:10b6:408:e7::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33 via Frontend
 Transport; Mon, 24 Jul 2023 08:46:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT078.mail.protection.outlook.com (10.13.176.251) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.24 via Frontend Transport; Mon, 24 Jul 2023 08:46:17 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 24 Jul
 2023 03:46:16 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 24 Jul
 2023 03:46:16 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 24 Jul 2023 03:46:12 -0500
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
Subject: [PATCH v2 1/4] firmware: xilinx: Add support to get platform information
Date:   Mon, 24 Jul 2023 14:15:51 +0530
Message-ID: <20230724084554.1924378-2-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230724084554.1924378-1-sai.krishna.potthuri@amd.com>
References: <20230724084554.1924378-1-sai.krishna.potthuri@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT078:EE_|SA0PR12MB4590:EE_
X-MS-Office365-Filtering-Correlation-Id: 446bdba2-0ad1-4bd7-f4e5-08db8c22720e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OpIpW5mv/vhdOsV9CXFTz6J1xwJL2TdKmqFIPrDTBph8J7EzBc+IGE7HtOKwByeP8GKAX8Om2mOsX16xakYt38l7Ar07Q8OahBQaU0OgNysEZkWeAVij8SgZjMIkmDEhwyTbkasdnR+M31k7iI1eTCarEzvMRf3YyqJ6wBTBSDuxawZHL5AZhwr334+hGhc31vTKSeR+7aWuCxdUNpX6f4sJoh+NpVM1eHxJHiTRAWL/irVD5nJiE8v6dMcwz9nbAmSVeK+N4PImXYWa7HU63f4CqFPzoeKe1P5a8CQkQ1sZD5hbdr1Zo6+hg2muXp9eV/O3y8MRMwMNUZJJLNAyJoivjuKVahkjavYReZbvEUqrQMOBWsZSeDNlpdJI6XjD056NEPYN8ZkMLt+3dFHJQATXj95X2HlmSywvVzSLuJnRVdRWu/tgtV/8f0X+rcKLaicfgvJJLm6TBhhKvAkEn/OcJPSFbkO/XQFy1vNrK96yHJtloN8tEwdGeSA9iUZMptgTEkWY4GjMzpNlyln0Ux5awvRdVcKRLQuv0KY1jBL283HdahmTr+AsfZDLkL6LpgsRgeymFJ6umAFRTCwPLk6oJTXFV7l09t8nJfIqHPfk3vAlhLu8QovAhy/LRkgIp7B5PPBhl88PnuunaMCfguTtErvcQwWjYP6AoXfaAELmeclOdFY01ctWAuuinpQW/Htw+OwuVSDuWkLF3n70B5BQaoRx0nmNFaeGiHfT62BJDyi8vndqyRL9K2Ec5qtQ6XThRLnITtQb+T/eHh3vn2b/VF2d3dIWQgcm+q7hMKA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(6666004)(478600001)(4326008)(316002)(40480700001)(70206006)(70586007)(110136005)(41300700001)(54906003)(103116003)(36756003)(36860700001)(8676002)(8936002)(7416002)(40460700003)(26005)(186003)(1076003)(336012)(5660300002)(86362001)(82740400003)(2616005)(426003)(81166007)(921005)(356005)(2906002)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 08:46:17.2947
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 446bdba2-0ad1-4bd7-f4e5-08db8c22720e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4590
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
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

