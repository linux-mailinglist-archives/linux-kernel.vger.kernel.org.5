Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4974C780E4B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 16:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353001AbjHROtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 10:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346049AbjHROtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:49:24 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1623E13D;
        Fri, 18 Aug 2023 07:49:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddXQiRq2R+aPBk7c9Ux84ygpx03NSeYKlp1EfpmS8EPZ9f4E6ttUTCFUQw4xxpxhTKnI2RYkjcD0aWIEItz251Q/69he10kcu58gh3DZigg/bi3LogJWHj5HoSdANcsful613iMvgfk0KMDWprHLRlvUailheZn13Q6qIShqYrjT5dVZYo/x60Zwq66UzuCwT+FAOBrGBdGMm9+38v2Q4yaJc97bWr7x5RfdzNWzxCcv6iWCyDspBgoXHwhSitw1L3o1z0UncryQ5CQZykPkNux94VQvewMExWR7LKMaCZpJTwLcddhdQFpOzUJFN6CSoOFr39mmdcG5XKnrIwb58g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqS1Zly3e8UdCu/ZcuU7Gt/aBD2XCjEIw6SWS+jfsQ8=;
 b=KLGTb/xjoX7rlCDqC+F34SV0aXOe7xzleHfTgr4jwSyC4A4avg+/vu1ps5Mhgy8Cq80D924LoxxvdgYkUHJRQHtwkEufv9oJVkQIP3ik3sdOQ8WEnopRI9b45VIFqsB/Ypk0QKUs/wdGUDRBtEn/M19BLKWefGIv8kwgNQQiAoC0CSRFu0G996OUrbL7M14HwII3dpdlPg3P7EXtbPwBuqA2tVcOhDeqdUEEvXg6gtVp0sJfxxLU5+1J29rsMwHqA91NuC0UxM8FZn+LoiyDQPIZyFEPGXCj6CzuiHIv3jfXRUXbXS7QuY/JwQ2HEOPzzTrBVEG8a0nHtiJdwrrPsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqS1Zly3e8UdCu/ZcuU7Gt/aBD2XCjEIw6SWS+jfsQ8=;
 b=mrzRcl3vAmQ8xV/1uHb36VpsfRms2+/yYivXZxJk5k7a6IW5y3DgKN/IyzaK3x+liCDxl/DNVL5AgqBXokMLQT+zKnharKnIPc3XY9L9UoBuYIZDo5h4VwiutqUAz5IWU1MD591SuaVxSJISvj3BSRAC2OiszILPwgYAcDInm8E=
Received: from BYAPR05CA0073.namprd05.prod.outlook.com (2603:10b6:a03:e0::14)
 by SA1PR12MB5658.namprd12.prod.outlook.com (2603:10b6:806:235::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 14:49:19 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:a03:e0:cafe::d9) by BYAPR05CA0073.outlook.office365.com
 (2603:10b6:a03:e0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Fri, 18 Aug 2023 14:49:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Fri, 18 Aug 2023 14:49:19 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 18 Aug
 2023 09:49:17 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <linus.walleij@linaro.org>, <Basavaraj.Natikar@amd.com>,
        <Shyam-sundar.S-k@amd.com>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>,
        Sachi King <nakato@nakato.io>, <stable@vger.kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Shubhra Prakash Nandi <email2shubhra@gmail.com>,
        Carsten Hatger <xmb8dsv4@gmail.com>
Subject: [PATCH] pinctrl: amd: Mask wake bits on probe again
Date:   Fri, 18 Aug 2023 09:48:50 -0500
Message-ID: <20230818144850.1439-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|SA1PR12MB5658:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c3af051-7521-464e-69f6-08db9ffa4d71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wVNBV3iVeHGJgJxE1PGI5uKO04SH+D1WshCVZms8u7/tYicPnLPvrmFbqh/x/FQVCa/PXss2179WasibI2HoKmTAs7M6emnb5XMOQhZCZEhOiigne9zfvfsEMoLRbT9TrRe3ybE42uiO7EfpGkzyAdfsprEfoebYFLmhDPj1vTP94JFkGsfckwMPxq2cUnTQLoU17LvgagBfkoTX0jmheTjnLay909qUo5QrGpXi2n6HALafEhgwpYIITI66edL2lzSIhN9ldMq6Fzvi6NIxcJTOHU7IuVjNd2R6mhwrVBa1Ov5X0Q5B9+zQEOzmJdjima+o/eCS0f241EKkD/FPjTM4NjJKWSpt7PQ8mDBTZXlNpmp0o+q/7qAvJuQfdT7D9pSEXiOAtnrws2Ier/U24bc1ADdx4qhEj7rzAa1RtaVhpFA6pz+IflZN1g62j7nYnu8cQoneGmE8SYo0OYNLRqifZp6ZCgYYgQoS3z+3lcURk9s09u08bNY7VAIkvwaJaQe14l5PMW1a310FvGsNAMV/jMqbH2C0ung2yC59STegiv0OfSCvK8yxoKemce5XjJbDo5OOAOwqXhWoHc83y1hqgA290NiwCOoZ0E32H9CcZIy7X5oYPTzTJet8giOE3CNc2SohraMGRJtn/hINM1gJ9ll+m0aM/PmdCqBT7mxnPDUMEYaZCIxAZuOsaNNh/IarDf0+UTo7NeLiJgdxnPF1etZzmVFbj6sXrA69R3lPZ6Yye5zMMTCsDvSsLeiCl5JOCzskPae4P7PXYkHInMbXw60QSemreHyDmddDKJ0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199024)(82310400011)(1800799009)(186009)(40470700004)(36840700001)(46966006)(36756003)(86362001)(82740400003)(81166007)(356005)(40480700001)(966005)(16526019)(2616005)(5660300002)(44832011)(7696005)(70586007)(70206006)(6666004)(6636002)(54906003)(110136005)(316002)(26005)(41300700001)(1076003)(4326008)(8936002)(8676002)(40460700003)(478600001)(83380400001)(36860700001)(47076005)(426003)(2906002)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 14:49:19.1569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c3af051-7521-464e-69f6-08db9ffa4d71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5658
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shubhra reports that their laptop is heating up over s2idle. Even though
it's getting into the deepest state, it appears to be having spurious
wakeup events.

While debugging a tangential issue with the RTC Carsten reports that recent
6.1.y based kernel face a similar problem.

Looking at acpidump and GPIO register comparisons these spurious wakeup
events are from the GPIO associated with the I2C touchpad on both laptops
and occur even when the touchpad is not marked as a wake source by the
kernel.

This means that the boot firmware has programmed these bits and because
Linux didn't touch them lead to spurious wakeup events from that GPIO.

To fix this issue, restore most of the code that previously would clear all
the bits associated with wakeup sources. This will allow the kernel to only
program the wake up sources that are necessary.

This is similar to what was done previously; but only the wake bits are
cleared by default instead of interrupts and wake bits.  If any other
problems are reported then it may make sense to clear interrupts again too.

Cc: Sachi King <nakato@nakato.io>
Cc: stable@vger.kernel.org
Cc: Thorsten Leemhuis <regressions@leemhuis.info>
Fixes: 65f6c7c91cb2 ("pinctrl: amd: Revert "pinctrl: amd: disable and mask interrupts on probe"")
Reported-by: "Shubhra Prakash Nandi" <email2shubhra@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217754
Reported-by: "Carsten Hatger" <xmb8dsv4@gmail.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217626#c28
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pinctrl/pinctrl-amd.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 20bd97a603d9c..74241b2ff21e3 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -862,6 +862,33 @@ static const struct pinconf_ops amd_pinconf_ops = {
 	.pin_config_group_set = amd_pinconf_group_set,
 };
 
+static void amd_gpio_irq_init(struct amd_gpio *gpio_dev)
+{
+	struct pinctrl_desc *desc = gpio_dev->pctrl->desc;
+	unsigned long flags;
+	u32 pin_reg, mask;
+	int i;
+
+	mask = BIT(WAKE_CNTRL_OFF_S0I3) | BIT(WAKE_CNTRL_OFF_S3) |
+		BIT(WAKE_CNTRL_OFF_S4);
+
+	for (i = 0; i < desc->npins; i++) {
+		int pin = desc->pins[i].number;
+		const struct pin_desc *pd = pin_desc_get(gpio_dev->pctrl, pin);
+
+		if (!pd)
+			continue;
+
+		raw_spin_lock_irqsave(&gpio_dev->lock, flags);
+
+		pin_reg = readl(gpio_dev->base + pin * 4);
+		pin_reg &= ~mask;
+		writel(pin_reg, gpio_dev->base + pin * 4);
+
+		raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
+	}
+}
+
 #ifdef CONFIG_PM_SLEEP
 static bool amd_gpio_should_save(struct amd_gpio *gpio_dev, unsigned int pin)
 {
@@ -1099,6 +1126,9 @@ static int amd_gpio_probe(struct platform_device *pdev)
 		return PTR_ERR(gpio_dev->pctrl);
 	}
 
+	/* Disable and mask interrupts */
+	amd_gpio_irq_init(gpio_dev);
+
 	girq = &gpio_dev->gc.irq;
 	gpio_irq_chip_set_chip(girq, &amd_gpio_irqchip);
 	/* This will let us handle the parent IRQ in the driver */
-- 
2.34.1

