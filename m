Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACCC769256
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjGaJvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjGaJvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:51:19 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47847E4B;
        Mon, 31 Jul 2023 02:50:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDeaW6nco5q70xRlcyT8m7DXNazYF/YKkyl3RBgWcp622arFDdqgZ1DCGaSYf0efZapl1lkqbhNdo7/ISdpB4UkMCiqcJ1aTGL2wj42JJqIA0pt3np4ie5fPY9GkqmGGkjoTKoueEWh/O1oDxAIuOmGm147d39mEj+obtK6UQnmDYP1OLayxnxv1CogCdc8ScG/A5OtgwThju31FzRYyDEFtSJh4ywTD/nJM2bVoygGEnKiq+bnY7y72+XZgfaIqkVdYWv1e21k2qPPpcx0AEfivo4lHglZQdRfQmrqf1BzSkXOm5J1GP+vBZSl3LW0++gNsDqCFDVGwD0LrkwuVOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGwcAkL9BtI4+6t1ChQx8LrlN43S64bw11xQYGFUdr4=;
 b=cJUwDlaxG766wXkaCgPau4zI7V0mgpDxt0xPLThjdrk31R3znAfy0DwJZR4ITTrQjuiV7OzvSLeHm8Cnce/GQ5xo0KmAp8jQDFyBR2PnOUU25ayJL3pd/FstO0hM8vB6YLiAiHzB9k4kcBY1OidIDT+SY2lsHE8VtzhanVu9lgWaXeRPdsixvGVhj2+oNjUMgxJbg1Vr2K+Nv97tEb6e5pVv6Qo78ivUuLmL9uJPjqBYwIkdHRlEJByz+StlVhH8KxOl0U4nPuGM3cslwtVRmlH0b1SR9U69rJerPgh5rhstcl2cyYMVlQvZF/K9BTtPSpbhvwrM8FRt3iw8qPlc4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGwcAkL9BtI4+6t1ChQx8LrlN43S64bw11xQYGFUdr4=;
 b=opIpJvc5rpcg3bIWL+khK7O1wP9Opg4DfuCm1N3ZuKUwzCtxvzdJ7kqmIrx3rzbZw6YJ3lA/oZIWxAmDoQJl1hBPYH0DFtb4QSZuJvTDhwyXG2oe2axZcPon1MNRckzB2kI2TC/X6EKOi7X8ch6WbtJyqZI2Bfj9Axk2UkNwc10=
Received: from MW4P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::34)
 by SA1PR12MB6894.namprd12.prod.outlook.com (2603:10b6:806:24d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Mon, 31 Jul
 2023 09:50:46 +0000
Received: from CO1NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::fa) by MW4P220CA0029.outlook.office365.com
 (2603:10b6:303:115::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43 via Frontend
 Transport; Mon, 31 Jul 2023 09:50:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT093.mail.protection.outlook.com (10.13.175.59) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.39 via Frontend Transport; Mon, 31 Jul 2023 09:50:45 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 04:50:42 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 04:50:41 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 31 Jul 2023 04:50:37 -0500
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
Subject: [PATCH v3 2/4] firmware: xilinx: Add version check for TRISTATE configuration
Date:   Mon, 31 Jul 2023 15:20:24 +0530
Message-ID: <20230731095026.3766675-3-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230731095026.3766675-1-sai.krishna.potthuri@amd.com>
References: <20230731095026.3766675-1-sai.krishna.potthuri@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT093:EE_|SA1PR12MB6894:EE_
X-MS-Office365-Filtering-Correlation-Id: 31b02021-a1e7-40a1-05f5-08db91ab9c8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0KYCLz2U5pZGm8wnssZAZiz65RszDkhbCitO1oX7VelZJ1hy9dSS/90Uotv+SnIOuvWZEBQwVm22Flxg2ewWe92LD0oW7LJ5iJ36xLHSn77OkqvIu3YKkXXBOfyiY8Dud5MZ6qPNXeYrunhmc5M5jjAJ6sahzyDtER9LquD71OOdHrr7R/+bANlhdD6/ag/iPa5IBxFhnGmyhlCjzBbxTxUX8SlGfL8K9dQMhLzK/bYJQWitlJO9jA14PcTQfxSpoUnHgovjcbRuXFXKT0+qODi8N3bmxdZKET62Q5Ey6G4uWoqX4eT6CHpuZYVdph7+Lx2eSPeINzpgDj14oJTRUNmt2Qm3zO1zags276Bwu15DJOSvWiTiPFNz3RmT/QUrB+U0LiIzyB+5IWRVkcMuKVZoY6My4Eg0h9dgAPHS4Aam1rWW1NNk2txvrThU+cvA4/5QO33hdvC4CZM8H3Sa9iD3RSx22WswaroqIF9GlpEb3KQ3uPeqOQux5gwezBb6IKjNRPyc7ycZ3aaK1Os49CSuQ6fwXgTaXyO0cPmEicZXSZ3KqFwQkMRQIHjE4iIwzJTYUQOXCsc6S3tFfr5c8tja5u7+K8ZBu1lyhixDHdYS8/n66dxWXCOEjeOekpG6GKlrBOHu0ZnzQlapvbDU15+7+3HaVZdy2GgJ7qog9ZH+f6evmqg9NXJDvO1agGxQsBjuXd2e3RYErY5mt4lim3C6IJyC/yJnH9ioenFldQUhoOxhD5ERIucDLEosydTmNrPm5u5JHauZrGGMkQrPFfiU/v6dU4fV6T6JCd4T2vk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(5660300002)(7416002)(70586007)(70206006)(4326008)(2906002)(40480700001)(316002)(8936002)(54906003)(41300700001)(8676002)(478600001)(110136005)(6666004)(1076003)(36860700001)(40460700003)(26005)(47076005)(426003)(83380400001)(186003)(103116003)(36756003)(2616005)(921005)(356005)(336012)(81166007)(82740400003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 09:50:45.3639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b02021-a1e7-40a1-05f5-08db91ab9c8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6894
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
Reviewed-by: Michal Simek <michal.simek@amd.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 9 +++++++++
 include/linux/firmware/xlnx-zynqmp.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index e204e2866d74..e93b12ad0ddb 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -1148,6 +1148,15 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_pinctrl_get_config);
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
index 075a8f7f1706..ac50eb98b17a 100644
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

