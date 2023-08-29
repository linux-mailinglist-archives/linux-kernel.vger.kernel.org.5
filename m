Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1128678CCBC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 21:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjH2TOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 15:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239333AbjH2TNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 15:13:42 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E44BFC;
        Tue, 29 Aug 2023 12:13:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5RnqzWMU8GMvjfyFdk4OeJ//rUx6xfmHZ6i4HnLSxRK7piy+bxixQVE2Oy8WFGHWUEpynIUuFMEi7GdivRPl+fKA37d1WE4X0B6JIhHyibaM+kcnRTC3/ifQ8xJMjyK03LQvHmQUfSVlnOSxsd8EpBwhP9J+wXE7vfd0A+M3JCqdtn01ceufg3pL57YM2zCJlNdkLB4RlCUvszDYpDsGq5B3hnQ7UYJmu/i2PZbfVhPPUGfKhe6BiGLItCY5wXa4d0mtVFwdh0iZ79hj5pGkT63TtyN/8cJMGwwGYqikK1GBktp1+dN0Lnjqxkxq0PjBg7EZRT+fISq+iRNhwNxzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bIIOOp1EEKCXv+IqY7ZPRoosbRCFLXt43a2CBHtJFAE=;
 b=F65mAE84Ix86Ih3OupyTijtA1rpNvmhmyr1UICvPHpK0nfmcaGk4i0ni2LjifoLNijINFo662THpToXuQ6+ZNSHD51roZrYy1atLwh8NXZBjPerdWbgDqjRXSQ1Y7UfsTVTT3tVGHr8qbgcpAqU7STIQCs9aiuMAhg2koOs4XNZnzo3vHIqibiakiCYrSzlll0uXAeOkNOiP1IB9/SVKvRexSzjcHuUnfI7DHc2RbSuF6X1ubcMDu+fp7AYsYIi4+5ilFF8zbzT2nU+uy1Z+5x93+3R2jwtZZhZLiNFGQSqi/Y3d1ImmnKr3JC3KJ9lcyB+QnUygV9KJ7rTXGEVt7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIIOOp1EEKCXv+IqY7ZPRoosbRCFLXt43a2CBHtJFAE=;
 b=dhY9EXJmK7oTnnR7fiA9FO4VC1FkktAENlMqspXDn2B7acL+ClZktA8n+ig3N2hF0LEdByWo3Wokwbdyh7//+839f5F4Wjsk1if14Qlk0Yc9NOWAp8VGa9nL9DQjSwdiZNf+RDcgxhqL3I/jJCyhAVLveU/b5VDVgOp+HRRJ/OU=
Received: from MW4PR04CA0075.namprd04.prod.outlook.com (2603:10b6:303:6b::20)
 by BY5PR12MB4276.namprd12.prod.outlook.com (2603:10b6:a03:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 19:13:35 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:303:6b:cafe::bf) by MW4PR04CA0075.outlook.office365.com
 (2603:10b6:303:6b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.36 via Frontend
 Transport; Tue, 29 Aug 2023 19:13:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Tue, 29 Aug 2023 19:13:35 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 29 Aug
 2023 14:13:32 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <linus.walleij@linaro.org>
CC:     <Shyam-sundar.S-k@amd.com>, <Basavaraj.Natikar@amd.com>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <regressions@lists.linux.dev>, <lucapgl2001@gmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/3] pinctrl: amd: Add a module parameter to configure power button behavior
Date:   Tue, 29 Aug 2023 11:56:26 -0500
Message-ID: <20230829165627.156542-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829165627.156542-1-mario.limonciello@amd.com>
References: <20230829165627.156542-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|BY5PR12MB4276:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ed928a4-f814-42a1-1649-08dba8c40afb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0fQN0d4czjOvIKCzgniuwsoLVln+LgLB6RUCxXS/0sJIN8KQDk80fCxlC17oTS6ShpF+DpDmCfAGvDMfwDvkGP5CnJ2EOiQ/iWDwQ+1QqRMDcs+IPsdPWUwaviVKoPzRGYc0iXtTK6gNq0j7OFHmWnS22VefhVuBBEMzNWknb2YTfbhzpK+vDtNaNvkIQAZtJ8vLHsne8rSyu13an0FZKJET27NI/Lvw9bvJCYizxEb3iiNGJ/AzY6jOUimfr3u7/9BAsQ2X3m+B8Lj10x3QHj1USg+9SbpyPaCzsasLeUmp1bYj3npvThU8DwoPYwO/vTPFBnwsWPOO+BPTWtFrhhL5lvXwWN0QQkZx6S12ueszP5mb+yx9MMnGVqlvy7Qu/DZoAdD5VTaRZMqcTfUbvL0m8wsNOi5YVsVf3/sfcTC/IwZFFR1XM3U+2HgrXInZJ1jfHaObGoJZrV9pPk/dqIu+7K68YW4My4HuS1asEzgg2EWyt3611SqsQDJqRemyzRkp39JAUMkYbxfhNdZtx20Lc4zDyICR2z76Zh5UDjVTeMTjSyoDpAxzONMLzGLwW3Adk7Ra9RfAiDiLIkBtOxyWgscUKE18kt5nMU12D7UxfIHq3ZytsuK22wtzISUl8LfLsUGHuPa/JiQnT6EIwgz/O+qPzwu0jt5/hGW1WQumKIr0pg3C4G8eguJrye6/2lBNgjpmoki67MyjLjiUBlVqiJ1T2r+1AYHverM9Chu6Pa4q+AkrMQ24VsHti+BWg1OPJ9fh/tARoQatknw/kg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(346002)(136003)(39860400002)(1800799009)(186009)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(81166007)(356005)(82740400003)(8936002)(6666004)(70206006)(70586007)(478600001)(7696005)(45080400002)(54906003)(316002)(41300700001)(40460700003)(26005)(36756003)(44832011)(8676002)(1076003)(5660300002)(2906002)(6916009)(2616005)(47076005)(86362001)(16526019)(36860700001)(40480700001)(336012)(426003)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 19:13:35.2934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed928a4-f814-42a1-1649-08dba8c40afb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4276
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On pinctrl-amd supported systems there is a bit in the GPIO controller
register that controls the debounce behavior. The traditional debounce
behavior is configured by software, whereas the 'WinBlue' debounce behavior
is handled internally in the GPIO controller and conforms to Microsoft
requirements.

For any users that find this behavior not desirable, add a module parameter
to force the traditional debounce behavior.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pinctrl/pinctrl-amd.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 37d64fa55b66..a2468a988be3 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -36,6 +36,11 @@
 #include "pinctrl-utils.h"
 #include "pinctrl-amd.h"
 
+static int powerbtn = -1;
+module_param(powerbtn, int, 0444);
+MODULE_PARM_DESC(powerbtn,
+		 "Power button debouncing: 0=traditional, 1=windows, -1=auto");
+
 static int amd_gpio_get_direction(struct gpio_chip *gc, unsigned offset)
 {
 	unsigned long flags;
@@ -1075,6 +1080,30 @@ static void amd_get_iomux_res(struct amd_gpio *gpio_dev)
 	desc->pmxops = NULL;
 }
 
+static void handle_powerbtn(struct amd_gpio *gpio_dev)
+{
+	u32 pin_reg;
+
+	if (powerbtn == -1)
+		return;
+
+	pin_reg = readl(gpio_dev->base + WAKE_INT_MASTER_REG);
+	switch (powerbtn) {
+	case 0:
+		pin_reg &= ~INTERNAL_GPIO0_DEBOUNCE;
+		break;
+	case 1:
+		pin_reg |= INTERNAL_GPIO0_DEBOUNCE;
+		break;
+	default:
+		dev_err(&gpio_dev->pdev->dev, "Invalid module parameter %d\n",
+			powerbtn);
+		return;
+	}
+
+	writel(pin_reg, gpio_dev->base + WAKE_INT_MASTER_REG);
+}
+
 static int amd_gpio_probe(struct platform_device *pdev)
 {
 	int ret = 0;
@@ -1095,6 +1124,8 @@ static int amd_gpio_probe(struct platform_device *pdev)
 		return PTR_ERR(gpio_dev->base);
 	}
 
+	handle_powerbtn(gpio_dev);
+
 	gpio_dev->irq = platform_get_irq(pdev, 0);
 	if (gpio_dev->irq < 0)
 		return gpio_dev->irq;
-- 
2.34.1

