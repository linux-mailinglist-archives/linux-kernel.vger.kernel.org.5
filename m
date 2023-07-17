Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34667755F72
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjGQJgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjGQJgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:36:02 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37410358C;
        Mon, 17 Jul 2023 02:35:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiIeOCGiidPbo+pbrAp0CdSSYPZOUyW3TZgpSFJvak22vdVOlSstDil0HsUN09LVal69ggY7Y/7A0tgRu9RRoOAjJceEuGyfyRyn7jFeyUNwLLr1K0PS0ym/Ii5OXA0TbmGZalODj61NkozUyvMMVHilFfId1cFBxpg9vJsntp6lDv2gRtmXgC64J6meorYHWR0BYLjXDs/qvI022tZ6EjhtW/Tn3vt9wiYNuAMchddtsIJdiP4bw2OUbD7iVJhId/ggnKoCwqGVTFQrOLKDOu4S3vT6NMmi0bYEfgx/9wVig9H9cUjcLnImnq9v7A0GNrHaMn8GHuxTuZg2qyI6Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5a6QEmM2KX38lNQl1P6r/u3Q9DZVE0Zv8YABYsrNro=;
 b=WxA5q01otLnof+YUL5+n+/02GPOtQeirBeHYbdECKatFLhLSuRoUU/kU/3Bbuc3gw3vV5dV9cHuYxwhdFvi8/T1895h5NvTosROlj87grBFEYZP+WKOaGIzlzjWzhGYCpQ+DkvOcxa2O7PCbOICiT//P9/ur8VjVSui38ObTzP03cHwmuu8uUGd8U4XnMRW3+2ERqiQ4oqDOqpcv9U5HICbt7VhsNAgfuvvwUzXOUihzuf2yJmM8ZMvif51YSAtTj/RXgmnyRpOdPdwKJ4RmQV/87aCDpi1Ksd9guGsSRXhsrUh0JaYcvXUCN7GMo8t+Bf6LlRbSXeWQ/o4YGEGnYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5a6QEmM2KX38lNQl1P6r/u3Q9DZVE0Zv8YABYsrNro=;
 b=TLW+k9NuOyvidRauODdhrtXrlSw+BnmAiJid/ev7OkiDCPsjg/YhCEgES+jbIZCOQFEHbHiGwmIRZhXlYq2T3FG4YedL12CCpF8rkU4XY5PuSh6zjYVJv5QZ4dI1LbzL/piiVUDr5NNYLXmZ3jKyQZEU4cPMr36iZ//onl8MG1Q=
Received: from DM6PR03CA0020.namprd03.prod.outlook.com (2603:10b6:5:40::33) by
 CH0PR12MB5369.namprd12.prod.outlook.com (2603:10b6:610:d4::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.31; Mon, 17 Jul 2023 09:34:45 +0000
Received: from DM6NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::f7) by DM6PR03CA0020.outlook.office365.com
 (2603:10b6:5:40::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Mon, 17 Jul 2023 09:34:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT114.mail.protection.outlook.com (10.13.172.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.32 via Frontend Transport; Mon, 17 Jul 2023 09:34:45 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 17 Jul
 2023 04:34:44 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 17 Jul
 2023 04:34:44 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Mon, 17 Jul 2023 04:34:40 -0500
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
Subject: [PATCH 4/4] pinctrl: pinctrl-zynqmp: Add support for output-enable and bias-high impedance
Date:   Mon, 17 Jul 2023 15:03:47 +0530
Message-ID: <20230717093347.3869167-5-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230717093347.3869167-1-sai.krishna.potthuri@amd.com>
References: <20230717093347.3869167-1-sai.krishna.potthuri@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT114:EE_|CH0PR12MB5369:EE_
X-MS-Office365-Filtering-Correlation-Id: 44511a37-30d4-47cc-cfde-08db86a90e94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +NWkWhkzNOro1WaSuWOnr1f7pHD4YHs1bLAYWx2Q9lDXMJ7jDiWt7k4WrfudJ6Y0VgWX1+49hyq+bJfCEUs0GgvCLbRS0ta2FcPqKM4glEcdAZpwP8MVSV4WMxw6J33F14MWC6l2HqtX/3KcVMOpG8IIz1RdiTijUH5ghq30zIpL5Rg2Eh9Jh8ZslSH4Qt1W+b7YnZm8zy+uw1nN/JqwbwBNyYnIFi3461v0kf5TTsBrYLELHeX3/UQh7ST9CkowFwlhLp+r4O4Z5aAIjVGL3sXFkyDKmnArdfB8jUwYWlXFz/cb0nLCL9mMYkpmLnspjkKe7m+OMGsjEVbd8eIyI9IgYVzuuHx2GQaU9s4anyBhmJJxdAocQD/+Ty8f+FVA0tf7iCHY+7+nN3GnF9Q+d52gHzIsTfp7HjRNxrgCW0SJqMxS8CvqD4klkK4YAu5rpacz/WbdXUVZPXxjNjuNNG1j2yB8HHl9HBHciGi+Z7YXURczIFT6RcRMRbROF1E643IToVEyfVQ0zK7dpxcAg4sPtgOE+ZcMAbGe4vjEdOA5aL/KPR6K5m5lqtzLj+ejA60U9/RjOM8E+B1TLp1eOY8i+lbFmXRBkGjB2ZG9Qm/mYFgtD06/WzscRRhc+W3X778c7MBmSzCxVzZt/Pmf5tzUeNVOjGdtY7nZeTstZ95JPgcuvuhO3Ckdhvpl870CgpXgQukETgiH8vmsKzYAclWz0jkqZAZc1bSo+boL0Ih2+lCfoGyUolIIuDj3OB9vX0W1wFvyT1aM616RYoWwM2RQYlrejppSCci4pTLYZHE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(2906002)(54906003)(110136005)(478600001)(8936002)(36756003)(8676002)(7416002)(41300700001)(316002)(70206006)(70586007)(4326008)(82740400003)(83380400001)(426003)(336012)(47076005)(81166007)(86362001)(921005)(356005)(103116003)(40460700003)(5660300002)(1076003)(26005)(2616005)(186003)(36860700001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 09:34:45.4504
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44511a37-30d4-47cc-cfde-08db86a90e94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5369
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to handle 'output-enable' and 'bias-high-impedance'
configurations.

Using these pinctrl properties observed hang issues with older PMUFW(Xilinx
ZynqMP Platform Management Firmware), hence reverted the patch.
Commit 9989bc33c4894e075167 ("Revert "pinctrl: pinctrl-zynqmp: Add support
for output-enable and bias-high-impedance"").

Support for configuring these properties added in PMUFW Configuration Set
version 2.0. When there is a request for these configurations from pinctrl
driver for ZynqMP platform, xilinx firmware driver checks for this version
before configuring these properties to avoid the hang issue and proceeds
further only when firmware version is >=2 otherwise it returns error.

Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
---
 drivers/pinctrl/pinctrl-zynqmp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-zynqmp.c b/drivers/pinctrl/pinctrl-zynqmp.c
index 8d2cb0999f2f..f2be341f73e1 100644
--- a/drivers/pinctrl/pinctrl-zynqmp.c
+++ b/drivers/pinctrl/pinctrl-zynqmp.c
@@ -415,6 +415,10 @@ static int zynqmp_pinconf_cfg_set(struct pinctrl_dev *pctldev,
 
 			break;
 		case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
+			param = PM_PINCTRL_CONFIG_TRI_STATE;
+			arg = PM_PINCTRL_TRI_STATE_ENABLE;
+			ret = zynqmp_pm_pinctrl_set_config(pin, param, arg);
+			break;
 		case PIN_CONFIG_MODE_LOW_POWER:
 			/*
 			 * These cases are mentioned in dts but configurable
@@ -423,6 +427,11 @@ static int zynqmp_pinconf_cfg_set(struct pinctrl_dev *pctldev,
 			 */
 			ret = 0;
 			break;
+		case PIN_CONFIG_OUTPUT_ENABLE:
+			param = PM_PINCTRL_CONFIG_TRI_STATE;
+			arg = PM_PINCTRL_TRI_STATE_DISABLE;
+			ret = zynqmp_pm_pinctrl_set_config(pin, param, arg);
+			break;
 		default:
 			dev_warn(pctldev->dev,
 				 "unsupported configuration parameter '%u'\n",
-- 
2.25.1

