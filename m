Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8D1755F6F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjGQJgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjGQJfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:35:46 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AB610E4;
        Mon, 17 Jul 2023 02:34:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9fcmUBMDQAFN3j5taJbTx6w3de3ykkxfEBlxvsdd8AgpRnaF1Z88Qc4XCPSg3gzGrpNMhv6uumEfb6gqiOmfADhdK9PWilLcMLTWHqF19T/1pF25n+ifbFDtm+auSxinONDR9a5Cki+7OQjO1AVKUMFQ+8NPR2HXaEDwMNA9rNo9/S84mGRSD64czjufhT8ZjykttDw1hQeFf1Iotg+XNtO2ULbR/znh5O8Hu7cHwuCvS4Sk1aC5MUnzOoPY75wgnIKSz7Zi1vWPb0jBHZSGGUSZPAFxCExlPELKhsRSPbeWS8RUQXvXUamueMBci2BzUX3x5P0d4JawPXMABQZog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cNUJM+IT9eeDSqiHSg2XEyk6HPpXY1Dn2TSB8BELFpE=;
 b=FxApHzFMqs46I7iGQoqFzqk9HEprGZoWqQ8gJ0eIAexprbQqy9pNxHkjO0lkMqe/BzU3MEbSwmCFfbttyTtXDK/GVY36ON3/S1a75HdwE+E9+Pi9KGv1hc2yBinQdJDEpeYFgKDwiNVufMN7x59qWqDrmI7SX580pov9wzDvfNq+rSedHKfHpWTcbaOXdLFvF69D+8JXYQ5rkcquYD2Su9Vq2iwEYoWnN1FEDQ9KNiVHP4GPx6b/eFlO3HDjz1tDQqJ5+tk1+/ge47soMRYdXrXxrlF7i+LLNBgMdy74tFGbTk5d9krAnOJM0q59RLh+rHrZNqoYoW3AtEmkmQ6chA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNUJM+IT9eeDSqiHSg2XEyk6HPpXY1Dn2TSB8BELFpE=;
 b=cnbQ26HB06OSomksQ0ydeqLlENuNNBkjvwzLw2X2yMZZsx/1TgxR87n017u9Qe0fVKRwU3uRquYw2/8WY/61kNY+bMh85IaD4FavktWChBJKrTeyD886Rdu5B2SS4VtJ1/V/VHYvzk3W74LYgqfUERJijLPnb3+9vfqTnPQQ7Ng=
Received: from DM6PR18CA0021.namprd18.prod.outlook.com (2603:10b6:5:15b::34)
 by SJ2PR12MB7893.namprd12.prod.outlook.com (2603:10b6:a03:4cc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Mon, 17 Jul
 2023 09:34:35 +0000
Received: from DM6NAM11FT092.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::c5) by DM6PR18CA0021.outlook.office365.com
 (2603:10b6:5:15b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32 via Frontend
 Transport; Mon, 17 Jul 2023 09:34:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT092.mail.protection.outlook.com (10.13.173.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.33 via Frontend Transport; Mon, 17 Jul 2023 09:34:35 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 17 Jul
 2023 04:34:35 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 17 Jul
 2023 02:34:34 -0700
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Mon, 17 Jul 2023 04:34:30 -0500
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
Subject: [PATCH 2/4] firmware: xilinx: Add version check for TRISTATE configuration
Date:   Mon, 17 Jul 2023 15:03:45 +0530
Message-ID: <20230717093347.3869167-3-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230717093347.3869167-1-sai.krishna.potthuri@amd.com>
References: <20230717093347.3869167-1-sai.krishna.potthuri@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT092:EE_|SJ2PR12MB7893:EE_
X-MS-Office365-Filtering-Correlation-Id: 6054ecc1-94a8-4553-a273-08db86a908bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vs6aQD8krgkD4kYlSK2wj4vNNkP9ZfyXVFoTh2rCX+9mYVznIjr8CIuskcKfSazg67h8ZVzvegiD4Px1cu5iaXOTvT39fB3ecIe0lcbPLSH/xB2Z5fosbzPsYlzXVIqPb717p/24MPFdR4MQN0nYUYeUd41wO7GL3ZLm2a0jrXMAovn8He5PFxQe69OCeO/aE2p+Z0XiuNseKbdUuU7r2zSj4QdMFKxJCaC8glB4PYJfcWazots5w4U/YSwKQOEEkV4dZylQ1NfEBrYuI1VgAdaRNFZrhP8CdPb3jaBtbQQuqLYGK4bAgxq8JzpKfA/9nYxXk/OVm+HhCrqbbevmXYngfPZjYwgQEvtgiJkeb1w8C5UC7oGxqp9hdNEUaLv9KuW4W+lkX7U+O3VyO7LorUnghJaOyDfjZ0rKgVovU7sv4jQBytKc2mi2mEtcXLbqfnGbI9/4S0FW+uCOwTImdJlfkZewJbI/wrfPMg6raEoGKlVq+UzYC/rPV6hSAqgV6IBykqCPTdcTU+YS4oYaidvPx6K2sHo5GiC9oPHubtPG3wpD4IlNS8fteS8wpIb8j5NtU4z25udiKf42lIF1OySJ5B8/2EhoIAKR0RqVQa7UeLNgLj7FAAx42YH+Hw91r6HYj7pa7IZ6tU7ASBRoSI1ykMcd/WMO0Q6Vp9XM6hQfzHuIQ2MLIMW3WSHu0P7zbfWlHpAC71A+aH1BohQYuGl9ecohoHr700ex1Q3veKXEABjFrdtOxoj/le01NRV2MoUj6geisQ9hDe3vY3+svYltqClooN13svu4VNCrri8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(346002)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(41300700001)(8676002)(7416002)(70206006)(70586007)(2906002)(8936002)(6666004)(103116003)(54906003)(81166007)(921005)(86362001)(356005)(4326008)(36860700001)(316002)(2616005)(47076005)(36756003)(5660300002)(426003)(40460700003)(1076003)(83380400001)(336012)(186003)(26005)(82740400003)(40480700001)(110136005)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 09:34:35.6229
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6054ecc1-94a8-4553-a273-08db86a908bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT092.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7893
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

