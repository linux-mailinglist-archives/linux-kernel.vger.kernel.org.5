Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1FF9769258
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjGaJvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjGaJvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:51:20 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7899AE7C;
        Mon, 31 Jul 2023 02:50:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5Pvy7VMDcOdl55ifHSnHa8EpSfR66BmMJNcQUyWyH1IkhlcIH/tFoEW//yKZ7czqFWUpyrEGbjL0sjbCgqvxitq1khx55FPBFbsoUu9gLYbOGSgPIEEg4/Ja8itx4R0H//whOjbKQK0N2woVh4XjCTOEDmCcou+bWkVgBBrFc5/QYObJoCiuH21XUbKctBa3QJUtnXkx2lKx8FlR4DebUKwCGu/NQLJM/J31xkR4Ol0fZIKM98dQTQs6cMXEInCiIXFXQwtNF3rJQ2qXvVYQNcuMbQ0cVfhQ8nhV/UvpcLExc8y05xeahuVGSex8gv1flyJeNr+y1/LemP4w33kOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5a6QEmM2KX38lNQl1P6r/u3Q9DZVE0Zv8YABYsrNro=;
 b=I52/IW+mlhl55U3K7q9W5MB0YYzhnOXjCbLvNiLayoCyRFOQ49ZZunQG86tzCX8BDsoqfjDtXJK5e9XH8NEUfVTh/4BlyZEo4NbLOFJdHzFd0YDmBU2CsMvaJ7Xqg88GXoTKysW5HdOqPp2WfdYOkT1UxBszDT1ewnVUQipglPj2yYz4txls85s2HjH08TSn4z5uFGnMagMSvIryOB9YCXerEKnAMapFPN9+9UrrJneI3G0jmaSy9qkj5jQ/nvi1VVf5u3hx9CsUFn/pIYI6n6aJ4ip0NU8CUIpn/S7r+6CEvJCZWX+RdIgSu2ZcVj1znP7w/6zPKWGubGdf/l77ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5a6QEmM2KX38lNQl1P6r/u3Q9DZVE0Zv8YABYsrNro=;
 b=0n8kVXNUcWA/wd8vfCZIrGC4CKwzpDCeTI1Lqelv1uf3ScuFeGbU5XJZ42VbZPpmIPtJHtWoXrmFsg6ReDlGqEYV0S6REAJH8+LXF4yoqkDD706pr/lAfbtONB3qNKVrMTYgDW7Wbmz2zPot0ijHHTjKOWficz0hm/8sX6ifnOU=
Received: from BYAPR03CA0028.namprd03.prod.outlook.com (2603:10b6:a02:a8::41)
 by PH7PR12MB9067.namprd12.prod.outlook.com (2603:10b6:510:1f5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 09:50:52 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a02:a8:cafe::53) by BYAPR03CA0028.outlook.office365.com
 (2603:10b6:a02:a8::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Mon, 31 Jul 2023 09:50:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.44 via Frontend Transport; Mon, 31 Jul 2023 09:50:52 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 04:50:51 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 04:50:51 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 31 Jul 2023 04:50:46 -0500
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
Subject: [PATCH v3 4/4] pinctrl: pinctrl-zynqmp: Add support for output-enable and bias-high impedance
Date:   Mon, 31 Jul 2023 15:20:26 +0530
Message-ID: <20230731095026.3766675-5-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230731095026.3766675-1-sai.krishna.potthuri@amd.com>
References: <20230731095026.3766675-1-sai.krishna.potthuri@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT041:EE_|PH7PR12MB9067:EE_
X-MS-Office365-Filtering-Correlation-Id: aa069868-fed7-43da-a2cb-08db91aba0d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1gt5yB0nxs8utSzAOu3MSzk6uS5NdmdXMowX72HPlSWHBm3g1Ta3emI6/PaFI9RfrvvGioNtBnAybnOBNNw0JkUTIqaqjnh+0ovbNqb9TO5pmj7Fzbq0maxw5pWaag2wqpv86SMryyoAFNRdRCo1R8NSsgGRj4rsxenEHPxw5s9SAKwXgnvRCJ32G7p/xiMz/HBrzIXeTuX3lReIZ6fmit7gDv+tZU/cXmNw7zmA2UMwxk8d0xxZtQ5lUZFIC2YJotPAI+GT8CRmMetK0NEo1eHHfFU+iNoB4UJkE/9L4RAfp6UWTuEPzeM1GdMWhQQI6PbKcJs7hMZjXSxAxE1iEP511cJjoLzuZ6XRIhdHLEPT/AR1p47Y2XU9M3QtxkoimjipogmpUm1pkVo0wLsdmsHn2QyyhCMlu2vXLYq7PyKOeGXANWBsL0vuGu9FdMP+tWschnP6fRvKR6nb8nq6t4415LuoP3Bkxm2GINcTWuhkHzq2soMy25ykAweMfvUVzBaXvl7maDbzmgeYaCERdMBC112WTijsVwwJCHfMJWVNGPt0D9FfJrUUjV/Xh2U54ZSnJwY42+wa/ZR7HC0oNZAi4dNUnslapTtvDJKyPhEKXZ4UC1U5hEkqEwt7rGX2FI2Xe/EK2QB74rBNqYpKH5CS6hU7eA80F2kiFd70moy23p9nVGiM0hVHlxBg8GAPY81i1Kejqx8AC5dphmRGSzI2qr+jaa8Qxk7/EXNJlDHYI6t32CvF9Remu1+na1XmvLTriXaqBRdy2f2d5k28L8RprkKk0zQ0841BIcmZT8k=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(356005)(921005)(81166007)(82740400003)(40480700001)(86362001)(36756003)(103116003)(40460700003)(478600001)(6666004)(2616005)(336012)(186003)(1076003)(26005)(8676002)(8936002)(7416002)(5660300002)(70586007)(4326008)(70206006)(2906002)(54906003)(110136005)(41300700001)(316002)(36860700001)(426003)(83380400001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 09:50:52.5572
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa069868-fed7-43da-a2cb-08db91aba0d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9067
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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

