Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A1675EE32
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjGXIrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjGXIrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:47:00 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFAB418E;
        Mon, 24 Jul 2023 01:46:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHMMFhyEJw/l4LPWm256YhBaxVeeMkYF5lJhMwRbe1rECedjD8BSviUEByEbyTBE4taMTh+Pb86xTR3yV9wvgGrjEuWDY4QUsJVU9WvZtAAAKM0qserJ5urQmCp4Lry73Wg1HzWY3y2qvQS10UacJOkQUmLiUgAJwqgz+o8jPJ4amdwF4PgNIr8R46mDoM1z09gCpmxwgVK2XKnC2teqTYI8hV3FmunoochO3TCopok4gtnrXh40ew7Y7ttrIre5nRNmpbYT7rtBt2JhyUQZ69av2QcGugPt7QNvVQU/Oo/RogxeAhCkPZnCwEXp218V4437II1lFHA5I07QhLcy3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cNUJM+IT9eeDSqiHSg2XEyk6HPpXY1Dn2TSB8BELFpE=;
 b=PC5catmzPm9LmkNySOkWQ2CB8ydmijV+P2DptAiXM9pkbv6MlK56KrNRloAo5+w5pGGDBOlVA5X/jMrpCK1jcUb77eee/yda/CQl7+XArUvtsTrNI6p6imFKwRbeKNiSgAYD4eWTUhHA90DT8ume4yhI8FcNEJOnIq57VHVvBrx8K40enfMoBdeE9Ts4H+pn0gA4aeu6+X6czzpLx2jXTlOT1OQ9+ir6TXQ9Uf/yQQBafSlo2zizNMlx/gV5MPCG3Cx/RqJ3ulx5fPCaBu7w81+u2AeOKu6UlFq2jtgGuLPSqq7WZcbmzbMvFUI3r4dy6CiJwgyP+u0H1xCPeoFcLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNUJM+IT9eeDSqiHSg2XEyk6HPpXY1Dn2TSB8BELFpE=;
 b=wJIOhABiDoqBuBs+CAd9/ZLTj+x1vdhQfqCk4WSFt/kE3vp5QuH0aL5BYOsHKWaDNeRWC9gGZIPRghaXfYLyTDykRlF1QevOgyVeHU3oDClTzN+wVx/7+/zkitQVMSakUHDeIzQJNALlHzRoKkgPLy41dq5A3MOActP5j38YvVc=
Received: from BN9PR03CA0692.namprd03.prod.outlook.com (2603:10b6:408:ef::7)
 by SA1PR12MB7039.namprd12.prod.outlook.com (2603:10b6:806:24e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 08:46:56 +0000
Received: from BN8NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ef:cafe::63) by BN9PR03CA0692.outlook.office365.com
 (2603:10b6:408:ef::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32 via Frontend
 Transport; Mon, 24 Jul 2023 08:46:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT100.mail.protection.outlook.com (10.13.177.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.24 via Frontend Transport; Mon, 24 Jul 2023 08:46:55 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 24 Jul
 2023 03:46:53 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 24 Jul
 2023 03:46:21 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 24 Jul 2023 03:46:16 -0500
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
Subject: [PATCH v2 2/4] firmware: xilinx: Add version check for TRISTATE configuration
Date:   Mon, 24 Jul 2023 14:15:52 +0530
Message-ID: <20230724084554.1924378-3-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230724084554.1924378-1-sai.krishna.potthuri@amd.com>
References: <20230724084554.1924378-1-sai.krishna.potthuri@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT100:EE_|SA1PR12MB7039:EE_
X-MS-Office365-Filtering-Correlation-Id: 64d3006a-4672-4c85-0519-08db8c228903
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eEdj69ns861gBTEYCkH5IAhy0PMR/eQkusgT/PNHu9fUWsQyl8DkmP1KcBkZnSJhG3tPLIEgHLpb5ucwnYV/OicQWHxCbO81JyPnB6vyeeiGAs5+fCngwtFcImG8hws8QDZU2Zb20qsQyeTBriyR9lowoPtvW8/09Wx5f20/ydDcVH2JDSKLgp0+DJzUxIxMrsSID2U+TcpKZOZrodcEk6ZvKT5x3QstqsOH40XhUC0qfDqWxEIvAwyOjuG3rpXJ5ZPQ6c9uOd1VmwZ7UWKCJ1OsFzHfF9ktkLUwabvWekMoUBzp0BTH5qBXtM7X/o3I5kJxC5kpJNrx9asU5xna1PoTQfw8zXLwT9lXjsxQGqDhDv9g8+mY96b9hrjS5fN3wfxLzLIhl88Dm/GptzS81OACaf8o3AXO+ePSI7Raw8GNuro1fFr+S0feq6/W7alPHyj9adSQrGn94Upj5U9bKX8ZG8T8Kh1lNpSADexAzgR8mZnMWjG0Ba5XCoFBOvqFOR4I+y39kcJU/9qghzKptOiCpB+ZlFht5PxLaRurJ5Tw4Dku2H7/8usR4IqerafDr84+TuMWraiGjUsWUcq2UTUfxxA2YaxFqRcQ6RGQXAYAPRjWr0gyGvs7jZkUGgrrax7N2OPK8gsJ5Wn+Vo/gGyYi049lpm/NeicBGlCdT7ws/yuOkGvlUSFl5ve0wyeGHDiIMU+v63L7NTOIN0XwxI40IQcSmpJ5iLLj7DShKZ8aNnqZDo7DMn8gLBvX7Ygm66tlvYB+7r++Zi9Pkb/Bq9KITkVf1G8ZSb7q47hEakA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(478600001)(8676002)(110136005)(8936002)(2906002)(40480700001)(40460700003)(70586007)(70206006)(4326008)(316002)(41300700001)(103116003)(5660300002)(54906003)(36756003)(7416002)(82740400003)(86362001)(1076003)(336012)(186003)(26005)(47076005)(2616005)(426003)(81166007)(921005)(356005)(6666004)(36860700001)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 08:46:55.8041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d3006a-4672-4c85-0519-08db8c228903
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7039
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for configuring TRISTATE parameter is added in ZYNQMP PMUFW(Xilinx
ZynqMP Platform Management Firmware) Configuration Param Set version 2.0.
If the requested configuration is TRISTATE and platform is ZYNQMP then
check the version before requesting Xilinx firmware to set the
configuration.

Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 9 +++++++++
 include/linux/firmware/xlnx-zynqmp.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index f9498e7ea694..307717f24a98 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -1150,6 +1150,15 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_pinctrl_get_config);
 int zynqmp_pm_pinctrl_set_config(const u32 pin, const u32 param,
 				 u32 value)
 {
+	int ret;
+
+	if (pm_family_code == ZYNQMP_FAMILY_CODE &&
+	    param == PM_PINCTRL_CONFIG_TRI_STATE) {
+		ret = zynqmp_pm_feature(PM_PINCTRL_CONFIG_PARAM_SET);
+		if (ret < PM_PINCTRL_PARAM_SET_VERSION)
+			return -EOPNOTSUPP;
+	}
+
 	return zynqmp_pm_invoke_fn(PM_PINCTRL_CONFIG_PARAM_SET, pin,
 				   param, value, 0, NULL);
 }
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index d7f94b42ad4c..6359eeea8dd7 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -34,6 +34,8 @@
 /* PM API versions */
 #define PM_API_VERSION_2	2
 
+#define PM_PINCTRL_PARAM_SET_VERSION	2
+
 #define ZYNQMP_FAMILY_CODE 0x23
 #define VERSAL_FAMILY_CODE 0x26
 
-- 
2.25.1

