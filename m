Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E5678CCC2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 21:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239312AbjH2TOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 15:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239292AbjH2TNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 15:13:38 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B164FD;
        Tue, 29 Aug 2023 12:13:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6z3D8Kg28ta5y1j9DzM8wu2TbftIMQhu4n80OePP6FDiuBGUSfBHiy/IR1S6Co0ajtt7OpcBtC5orVRTNsOzyPhGIu3DrgNP5RqIf4eZs/xVKLIyakeYJlwNS3hWMOpGNP6fwS+l/EaAZ9jN0pI2YSKLRSKGwtoVzUkEoeAioucwnhlpvnfsoMlilnqEERptqYJOyuH8ft0k33l9k2+8y4E0rRHkajN20Q/1c4NA/VBbOW9HKlS8jLpel4JfCkT3Ec5gaHzzlRTvt/NnWZeVcXsz4KgmuV4kmvDIVm1+oKIhtPtHFmpo2JANcYVLEZi4f9+IeBZxblhXHVDS9BRQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6ZZU76wYya+WtJsgWGBPJyx2qSpL1LcTseHyqw2emA=;
 b=lQvwoD1j0h7W6LJp6oCfhN5twu+b7aI4aw8AraTrN+yJt7+bdgo/wm+yaSEzIUHtHTfMAbpHT2Uy01BcW8uXwF/kFUCz9RMtUK7zKnc5XKd0bFcb47ZcV7q/Ea8hMMUMxybv6a9JHqpyIF2lKtxJMnQuieAZ2TnBBfWCXMf9kRbhGspphgo1bJ7MoPShmO3OUBHfwCCP/VEk7EtPnDLO9YeV8tueyUGXuyF+sSBQfBQb1/RTZXbsIP2zoD51lfj+39NLE9lVh4V23oIqZXQuveG6r092/djb3Odo/s3VtylfoIxUM2NPKpFjhCfhdOpINDDDs5PtKTd0S+1XeyAIow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6ZZU76wYya+WtJsgWGBPJyx2qSpL1LcTseHyqw2emA=;
 b=2Y1KFI+r7SXvwW+MGGcpHyDldAWFSGj8aZ1S6NTNZoGOweJHB4feD0lGmxtOe0IDAlNslV13HIejGcFKgOviRLR2fWLxaqxgnrmz6FkzMxzzcIDN3/6QV464OPI2pIvRsfoXHlpNXzVlnIZ2vncZayS1s5EhrVpfu5Ktidyl7+c=
Received: from MW4PR04CA0064.namprd04.prod.outlook.com (2603:10b6:303:6b::9)
 by DM4PR12MB6445.namprd12.prod.outlook.com (2603:10b6:8:bd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Tue, 29 Aug
 2023 19:13:33 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:303:6b:cafe::24) by MW4PR04CA0064.outlook.office365.com
 (2603:10b6:303:6b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35 via Frontend
 Transport; Tue, 29 Aug 2023 19:13:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Tue, 29 Aug 2023 19:13:33 +0000
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
Subject: [PATCH 1/3] pinctrl: amd: Clear `Less2secSts` and `Less10secSts` for GPIO0
Date:   Tue, 29 Aug 2023 11:56:25 -0500
Message-ID: <20230829165627.156542-2-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|DM4PR12MB6445:EE_
X-MS-Office365-Filtering-Correlation-Id: fa570ee3-e95f-4074-fc93-08dba8c409dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eYB7CzKYSyIvfu8KwSJD7xg7eu2xpJgzLLzH6SUxEtGXAoM7y8J6bnHOHRcGBBv7rvwoNL6tdkda9aq3sXQ6X+NbpWdKjjh3rn5NFBaYzWkbUk5v5Sn46O7U8wbp4YEQJZBeusdbtZ4EBAu9Iw4WDWA41uW/A5UiEadNd4K2FsFd8a+uk++wQxel7cHWbiAfvIbyBE62+hiJ+52FoEa6pO9N4/f7pYe2KXNAQJfUz9uKgZ2o5IPgP9zKnOUbf8pw9ABvzRNnb3AOZVkHqj20NPIkIxWv1Q7pafbhfGn/rCJv0xniLH0axg45tzT7wudSgSZbZqmWJODoW/paTzdPH44ZXFufP5gSoGeVCdQHcNkDODSbYbW8usenjfrVtuuzWfgNWzfClWIy7AHCNkk0XHmNlU3wWH3SOZIGLulfxQgjCdZTu+/+MjIjPwXGwLT10UYTfnpawDBQ4BQivnBSdL3OCULTzEwG4cTORfLs9ssOrt77acw0vouO0DkGR+CP9Y8XML1wt7ly6c18ZI0kXfxhd+Pf5rn+0Ejih1utj3lDVVrMePf0ZtuVEXwsQjmPFm8EYhn6vxszQ/Jd+ZrVN1KR6J3Lk4cmHHrlusYNBeH5PIUK7yCsF8yj+vzmg4ewIHO/E4fmOwI3ALbc0VTvsCKzJz7/NCI3TkVkJptyaYMd1aM9ct7Rn0oXdHgkUPtfflHzBfMV0dv84vxUXx8JJnVnkq7Bo028eRfVaR+DRaTpbJMN1SFk1tZhaO1DkXfi/CWnZa9dC9jEwwemu3JH1CfiL8PB2AyKdjahKqfMQvy6JHhEHPx0oQPPpd1Bp7QJVUW8Yu8r9/uJvhZ6LqskWA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(1800799009)(451199024)(82310400011)(186009)(46966006)(36840700001)(40470700004)(1076003)(40460700003)(2616005)(4326008)(5660300002)(8676002)(8936002)(83380400001)(47076005)(36756003)(426003)(336012)(36860700001)(40480700001)(26005)(16526019)(6666004)(82740400003)(44832011)(356005)(70206006)(81166007)(7696005)(54906003)(70586007)(316002)(6916009)(478600001)(966005)(41300700001)(2906002)(86362001)(81973001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 19:13:33.4184
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa570ee3-e95f-4074-fc93-08dba8c409dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6445
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On systems that don't program GPIO0 through _AEI may still control
the power button via this GPIO.  When the GPIO master controller
register has bit 15 configured for `EnWinBlueBtn` this will cause
GPIO 0 to behave differently. If the user presses the button for
less than 2 seconds or less than 10 seconds then it is expected
that interrupt status must be cleared by the GPIO driver.

Reported-by: Luca Pigliacampo <lucapgl2001@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217833
Fixes: a855724dc08b ("pinctrl: amd: Fix mistake in handling clearing pins at startup")
Link: https://www.amd.com/content/dam/amd/en/documents/archived-tech-docs/programmer-references/55072_AMD_Family_15h_Models_70h-7Fh_BKDG.pdf p948
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pinctrl/pinctrl-amd.c | 9 +++++++++
 drivers/pinctrl/pinctrl-amd.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 74241b2ff21e..37d64fa55b66 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -590,6 +590,7 @@ static const struct irq_chip amd_gpio_irqchip = {
 	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
+#define GPIO0_LESS_TIME	(BIT(GPIO0_LESS_2_OFF) | BIT(GPIO0_LESS_10_OFF))
 #define PIN_IRQ_PENDING	(BIT(INTERRUPT_STS_OFF) | BIT(WAKE_STS_OFF))
 
 static bool do_amd_gpio_irq_handler(int irq, void *dev_id)
@@ -610,6 +611,14 @@ static bool do_amd_gpio_irq_handler(int irq, void *dev_id)
 	status |= readl(gpio_dev->base + WAKE_INT_STATUS_REG0);
 	raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
 
+	/* check GPIO0 specifically for Less2 and Less10 */
+	regval = readl(gpio_dev->base);
+	if (regval & GPIO0_LESS_TIME) {
+		pm_pr_dbg("GPIO0 was pressed for less than %d seconds\n",
+			  regval & BIT(GPIO0_LESS_10_OFF) ? 10 : 2);
+		writel(regval | BIT(INTERRUPT_STS_OFF), gpio_dev->base);
+	}
+
 	/* Bit 0-45 contain the relevant status bits */
 	status &= (1ULL << 46) - 1;
 	regs = gpio_dev->base;
diff --git a/drivers/pinctrl/pinctrl-amd.h b/drivers/pinctrl/pinctrl-amd.h
index 34c5c3e71fb2..3ea9a5275845 100644
--- a/drivers/pinctrl/pinctrl-amd.h
+++ b/drivers/pinctrl/pinctrl-amd.h
@@ -45,6 +45,8 @@
 #define WAKECNTRL_Z_OFF			27
 #define INTERRUPT_STS_OFF		28
 #define WAKE_STS_OFF			29
+#define GPIO0_LESS_2_OFF		30
+#define GPIO0_LESS_10_OFF		31
 
 #define DB_TMR_OUT_MASK	0xFUL
 #define DB_CNTRl_MASK	0x3UL
-- 
2.34.1

