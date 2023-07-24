Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B8A75EE3B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjGXIrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbjGXIrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:47:33 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDA010C7;
        Mon, 24 Jul 2023 01:47:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/WkA+IcbwmHbteZiubrWJVikyspU6KC4XfdhnE8h/2DZUlLRhdkyAZocAJ5wa4v8S25QP7qKLT4CbXoVFtlJu7BvopJOa263jmXFs3Wdgmyj1y4mVl2C9h7QC8LODgkizCcyGoOMChpoYDzIMj3PImYJUNH0Yxv12ylw+c/a6/fkyUyW4UE60DV637bbpZgySAXvxYjHtSqxWG1CUBlG0MFJYn5TkycmOwXgnPok/XBcM6msOsw32Nt7lOBEpiw3u8JSTPGl4g2a2Tn0Eqv4lPhHTToy1SsFiJq2rVg7pv4bwnljrxkLRMJDvTy+tz5ZKHp62upEqr8I+FL4sjeIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5a6QEmM2KX38lNQl1P6r/u3Q9DZVE0Zv8YABYsrNro=;
 b=FZFQlbp6mp5zDWBV4GBDXcbcBkVwM67PzJp4LCeehrw1Hwa7u4M3tJRpehb5wS/RBRv8wnkbTjGnV4dQkxbiERb2h1E033JCXdRSzQizlIz6t03GT49doKKhMQrKlDuiMQM3mjWJE/qIEKvxEZMHKzZjPaCmGvrELJcvNFKRxoY9iApxDW2Tz4NfrrvEZxv7Qt06IG/wS/6YK/bB7E6espSR1R3dVVjPmCfWTZlIqw96f8o6woGWo7qRBA0gJnk1w5AuG2fmb2GW/3k+6CgQyKQTQU8/c2fIO3K6v+U9TAktfJkedkGFT6ljDZC2OxfPNvDuN6bdbOKaqv9zYnpDGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5a6QEmM2KX38lNQl1P6r/u3Q9DZVE0Zv8YABYsrNro=;
 b=AofTyCVt/RrF2l8mDHW9j/bZOLEHT0xfIlvtIv4fmPMj3qlFeFDTCxlmDXa5VH1igd03+Qu42NUHjRVWJZXJXZsoX1t/JQdhGNE0T6hSvw90pLeM64UGeT1mxgC6oDmNqyY7kh6aUP6c6XDi3uuj8ODEYcyOmQ852ChkdLGOeX4=
Received: from DS7PR05CA0072.namprd05.prod.outlook.com (2603:10b6:8:57::7) by
 IA0PR12MB7602.namprd12.prod.outlook.com (2603:10b6:208:43a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 08:47:19 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::63) by DS7PR05CA0072.outlook.office365.com
 (2603:10b6:8:57::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.24 via Frontend
 Transport; Mon, 24 Jul 2023 08:47:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.25 via Frontend Transport; Mon, 24 Jul 2023 08:47:19 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 24 Jul
 2023 03:46:59 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 24 Jul
 2023 01:46:58 -0700
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 24 Jul 2023 03:46:54 -0500
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
Subject: [PATCH v2 4/4] pinctrl: pinctrl-zynqmp: Add support for output-enable and bias-high impedance
Date:   Mon, 24 Jul 2023 14:15:54 +0530
Message-ID: <20230724084554.1924378-5-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230724084554.1924378-1-sai.krishna.potthuri@amd.com>
References: <20230724084554.1924378-1-sai.krishna.potthuri@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT068:EE_|IA0PR12MB7602:EE_
X-MS-Office365-Filtering-Correlation-Id: e5692687-196f-4ab0-36b8-08db8c22971f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QtSauVc2EO/YprQXxyO1XIlJPJJ4Ah61pjbb3Iek0ozA8C6E+NZLBGUxwr54FSRPb0b4Vg9iD1vCKCwTr5gj7F/XwAIQzskEOZtIoa57A6pZVGBkF7SCsowPbn5tDpmQ5tr5ll+n76PDS8T2bWukABmF8qYAXo+DnNxUmBouY3dfYk+ZKcK5rU3V275CWJL+G+u3nxsLjANXtL+WYYUwhPJy2hDYRBEYijqF7UxCwierR/E6whAjdvmd+Wf1AGc/bhd1y2OHL6/AlM7N8OJXHL1eAnKrO7YJ9N8KUuLiHPy4xRduLC9RkzUnG3eZK+27Hp/ZcUggPFiUthMMHFiyOz9sWejrq5qvJWD2uLZHrm+h5HVq5JAnx0Jx4IOu1VU1VBKOv9wqZv6sQaO2lDGUUgJlhV4ZIjD8tg8teCUii20yn6M7RkjvDyHJXBQWK0ZwF93C6fCTm22gSQ3vpsa+EKmTEy+W1VCu0BSaABtAQ76Oy8SVV8oEpDln32tch1r+LDsdH5YIPTPTMjdo+VvwEELuBN8R89cWOhVfzcLpJgxkbbU04IjC5n1+4kupUpY7+ZU6DLvRV7i/vLHsq41W8IRl1kc+MIMQwyo9uLrHJPJNZIhkZbcgEKV9e/dtaUyJuuw44ygr3qYNLE6pWeqyy/6afIMPDCA+wQOuSIyVyacqfr1JXLPLdxsTKh9gKvgVv/33h4Z1DyuuZSC0QilVsJvOcv2D+8IsYbkPX2JlwVsIuQtAIXAiKMSnXrwUv4Q5Bs05ppI6CAORUDtcx8c5jho5G2ZuHWHevOM5b/0ATdU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(478600001)(54906003)(110136005)(47076005)(83380400001)(426003)(36860700001)(103116003)(36756003)(86362001)(40460700003)(40480700001)(2906002)(2616005)(336012)(186003)(26005)(1076003)(316002)(82740400003)(81166007)(356005)(921005)(70206006)(4326008)(70586007)(41300700001)(8676002)(8936002)(5660300002)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 08:47:19.4457
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5692687-196f-4ab0-36b8-08db8c22971f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7602
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

