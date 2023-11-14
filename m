Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0F97EB033
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 13:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbjKNMtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 07:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbjKNMtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 07:49:13 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B0A18D;
        Tue, 14 Nov 2023 04:49:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PbtlPgFZhBDKBUm9d6qPFRloDdRUvbnMn6zsBO+yeSKTUonqhE70gChlu52rtYbnOC/VUrGVmc2h08Zv1nYOhjqs5YU5vC/BbKo6q7Xog7wUiqfH/wxzi139ro0tmWZFTeS1Hh2JWKfdlrwsFxD3BlqKBP1o8zqycMVc7Jy/mK2mrCsnGQmpYmKbkSZyWNaVQolOcxuZOlFowNISWmh1JDJMQ/NdAR1JqvSsg1KCqqx2TiVGI0jj6qgCXqPDPzfgbr8uA1XnPhD/zzu+sERzpCllHEJAY/ohxhsAOJVI0mZYaSp3gD4hQHxXn7Zi9FkYjZwOWVdXrnEFhxFOyT2dzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gyzCluOXSX0AuRgqG25XGUkoJ32Gr/T+43uwSFGn0uc=;
 b=Ibtvu7pnpF7XKfdPAFtQiOXcl49DWgTnkjW3w60Z1nVIE3n/+HDpUvwjs9t0jUp+dL8lms42aa0TO7so4RWe84aJxBgH7Rdgt+e1whDDcWsJl9uqn4hH4R0KQsbwEgO13Hpm+nYxez16qLAmzESzMX+J/13x9ZKfwZmGgg4BqWjLVI67K1Di+ho7UtKMtVbG+WWybLcwI5Nu/jhRh6zYPOxBMaYQcIOAQulZ6oJoNBhvKdyQa8/y7e0xiXPDaqZpKrpNx953QbYmfI0g0l/kGQLg/sgfRB3ZW8+LoUdiwAwHnx9XRjHyJbIIY6/inOWIEzltv9sxjww2my7pR2i/lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gyzCluOXSX0AuRgqG25XGUkoJ32Gr/T+43uwSFGn0uc=;
 b=tDa8/rdQKzT2N5VhpP00wEMghKHBoUGDbTK5mlo0k6jIH5+5JuiM9olZnqW6F3tosPvonUxeKeKywyE4KEzPhULhdCJbMFKsS8wV0kIJcX4USTpHuU5F/PL0B0H/zpY1rBvnHPaS/HIxfznaV3SmB76mwUfIEcLwFKODd+JQGZA=
Received: from MN2PR20CA0035.namprd20.prod.outlook.com (2603:10b6:208:e8::48)
 by CY5PR12MB6036.namprd12.prod.outlook.com (2603:10b6:930:2c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 12:49:04 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:208:e8:cafe::8e) by MN2PR20CA0035.outlook.office365.com
 (2603:10b6:208:e8::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17 via Frontend
 Transport; Tue, 14 Nov 2023 12:49:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.13 via Frontend Transport; Tue, 14 Nov 2023 12:49:03 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 14 Nov
 2023 06:48:55 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 14 Nov
 2023 04:48:41 -0800
Received: from xhdmubinusm40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Tue, 14 Nov 2023 06:48:38 -0600
From:   Mubin Sayyed <mubin.sayyed@amd.com>
To:     <krzysztof.kozlowski+dt@linaro.org>,
        <u.kleine-koenig@pengutronix.de>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>, <conor+dt@kernel.org>, <tglx@linutronix.de>,
        <daniel.lezcano@linaro.org>, <michal.simek@amd.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <git@amd.com>, <mubin10@gmail.com>,
        Mubin Sayyed <mubin.sayyed@amd.com>
Subject: [LINUX PATCH v2 3/3] pwm: pwm-cadence: Add support for TTC PWM
Date:   Tue, 14 Nov 2023 18:17:48 +0530
Message-ID: <20231114124748.581850-4-mubin.sayyed@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231114124748.581850-1-mubin.sayyed@amd.com>
References: <20231114124748.581850-1-mubin.sayyed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|CY5PR12MB6036:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b5494cc-2cbc-4f14-9764-08dbe510151a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p3WeKWf0KqyRDc5P1kNa0ownyLtZolfFVBoJmquZGUK4l/FbHtOFj4hCiOro9zB8KfFVFJcZyKCcE+Rv/YXzkKHvJu0EiQIZ4zbS+DPjwnjw+XAIhOeLp0oxoKAtbpYEIaFoIk2SG3UubBKBavbKQWIEwLFzBbcyfHS0Cp2a6oTjoJTuecUqWFsnytNHj1M5xNMlIEwEOW4y8K0rxE5Ttn15LvKkvChyuoo3w8vbeO9qeyW0FN8Hy4dgo7z0VqdqHkFGzmVhEX/25DCTNbjOrstdeOlzJ6jPao/jVeC20S1Za9nplPbtoXr9kp4ZioPR9ssQMustAmLt325i3ljDosvY3h7wdXnISX0UQHwjQ7GiAUPbcMVErSIA5be7xqA5nV9AA6mTLMUrOfu5zsflxwtHGAyf10BlNvAeS/zVWtDNtw+XF+aBW2ntj/OAwsuNfs3nAEsuK85w+UoA2vAx3GvDhDd7bmYcFT4HwKx2fv393X443uD2XBDP+7GjQoP/c/o+LpI4KlGyOpzy2qLrUFQI20VtDx+eBIEdOlDzxPMZjepaNNoJVmcrzmkxmvc2bQIYPmUfV3ut4f9FM8fUOp7oi8YkgV3SuyNpoowSYOwoM9PlR8FTSTHHPXpL+NTeTRuICutG+crXYjJFwOC92GBdmwaogfRhCwTLPUoLyGre5DW+ODYS5gtLix5lsTWb6wxki15/xA75dTDryQhsZG+X8FdyN7GMuJOy75i020JRTdhNTDyzgXwoVvPo/d0k78PfK3rf2ZTCOFl7czmbvg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(82310400011)(64100799003)(40470700004)(46966006)(36840700001)(2906002)(40460700003)(5660300002)(7416002)(30864003)(41300700001)(36860700001)(356005)(86362001)(36756003)(316002)(6636002)(70206006)(82740400003)(478600001)(81166007)(110136005)(70586007)(2616005)(1076003)(26005)(6666004)(336012)(47076005)(426003)(966005)(83380400001)(4326008)(44832011)(54906003)(8676002)(8936002)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 12:49:03.8890
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b5494cc-2cbc-4f14-9764-08dbe510151a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6036
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cadence TTC timer can be configured as clocksource/clockevent
or PWM device. Specific TTC device would be configured as PWM
device, if pwm-cells property is present in the device tree
node.

In case of Zynq, ZynqMP and Versal SoC's, each TTC device has 3
timers/counters, so maximum 3 PWM channels can be configured for
each TTC IP instance. Also, output of 0th PWM channel of each TTC
device can be routed to MIO or EMIO, and output of 2nd and 3rd
PWM channel can be routed only to EMIO.

Period for given PWM channel is configured through interval timer
and duty cycle through match counter.

Details for cadence TTC IP can be found in Zynq UltraScale+ TRM.

Signed-off-by: Mubin Sayyed <mubin.sayyed@amd.com>
---
Refer link given below for Zynq UltraScale+ TRM
https://docs.xilinx.com/r/en-US/ug1085-zynq-ultrascale-trm

Changes for v2:
 Use maybe_unused attribute for ttc_pwm_of_match_driver structure
 Add new function ttc_pwm_set_polarity
 Removed calls to pwm_get_state
 Replace DIV_ROUNF_CLOSEST with mul_u64_u64_div_u64
 Modify ttc_pwm_apply to remove while loop in prescalar logic
 and avoid glitch
 Calculate rate in probe and add it to private structure for further
 Drop ttc_pwm_of_xlate
 Replace of_clk_get with devm_clk_get_enabled
 Drop _OFFSET and _MASK from definitions
 Keep Kconfig and Makefile changes alphabetically sorted
 Use remove_new instead of remove
 Document limitations in driver file
---
 drivers/pwm/Kconfig       |  11 ++
 drivers/pwm/Makefile      |   1 +
 drivers/pwm/pwm-cadence.c | 370 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 382 insertions(+)
 create mode 100644 drivers/pwm/pwm-cadence.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 8ebcddf91f7b..7fd493f06496 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -152,6 +152,17 @@ config PWM_BRCMSTB
 	  To compile this driver as a module, choose M Here: the module
 	  will be called pwm-brcmstb.c.
 
+config PWM_CADENCE
+        tristate "Cadence PWM support"
+        depends on OF
+        depends on COMMON_CLK
+        help
+          Generic PWM framework driver for cadence TTC IP found on
+          Xilinx Zynq/ZynqMP/Versal SOCs. Each TTC device has 3 PWM
+          channels. Output of 0th PWM channel of each TTC device can
+          be routed to MIO or EMIO, and output of 1st and 2nd PWM
+          channels can be routed only to EMIO.
+
 config PWM_CLK
 	tristate "Clock based PWM support"
 	depends on HAVE_CLK || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index c822389c2a24..a8a11dbcb00f 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_PWM_BCM_KONA)	+= pwm-bcm-kona.o
 obj-$(CONFIG_PWM_BCM2835)	+= pwm-bcm2835.o
 obj-$(CONFIG_PWM_BERLIN)	+= pwm-berlin.o
 obj-$(CONFIG_PWM_BRCMSTB)	+= pwm-brcmstb.o
+obj-$(CONFIG_PWM_CADENCE)	+= pwm-cadence.o
 obj-$(CONFIG_PWM_CLK)		+= pwm-clk.o
 obj-$(CONFIG_PWM_CLPS711X)	+= pwm-clps711x.o
 obj-$(CONFIG_PWM_CRC)		+= pwm-crc.o
diff --git a/drivers/pwm/pwm-cadence.c b/drivers/pwm/pwm-cadence.c
new file mode 100644
index 000000000000..12aaa004bf7f
--- /dev/null
+++ b/drivers/pwm/pwm-cadence.c
@@ -0,0 +1,370 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver to configure cadence TTC timer as PWM
+ * generator
+ *
+ * Limitations:
+ * - When PWM is stopped, timer counter gets stopped immediately. This
+ *   doesn't allow the current PWM period to complete and stops abruptly.
+ * - Disabled PWM emits inactive level.
+ * - When user requests a change in  any parameter of PWM (period/duty cycle/polarity)
+ *   while PWM is in enabled state:
+ *	- PWM is stopped abruptly.
+ *	- Requested parameter is changed.
+ *	- Fresh PWM cycle is started.
+ *
+ * Copyright (C) 2023, Advanced Micro Devices, Inc.
+ */
+
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/of_address.h>
+
+#define TTC_CLK_CNTRL		0x00
+#define TTC_CNT_CNTRL		0x0C
+#define TTC_MATCH_CNT_VAL	0x30
+#define TTC_COUNT_VAL		0x18
+#define TTC_INTR_VAL		0x24
+#define TTC_ISR			0x54
+#define TTC_IER			0x60
+#define TTC_PWM_CHANNEL		0x4
+
+#define TTC_CLK_CNTRL_CSRC		BIT(5)
+#define TTC_CLK_CNTRL_PSV		GENMASK(4, 1)
+#define TTC_CLK_CNTRL_PS_EN		BIT(0)
+
+#define TTC_CNTR_CTRL_DIS		BIT(0)
+#define TTC_CNTR_CTRL_INTR_MODE_EN	BIT(1)
+#define TTC_CNTR_CTRL_MATCH_MODE_EN	BIT(3)
+#define TTC_CNTR_CTRL_RST		BIT(4)
+#define TTC_CNTR_CTRL_WAVE_EN	BIT(5)
+#define TTC_CNTR_CTRL_WAVE_POL	BIT(6)
+
+#define TTC_CNTR_CTRL_WAVE_POL_SHIFT	6
+#define TTC_CNTR_CTRL_PRESCALE_SHIFT	1
+#define TTC_PWM_MAX_CH			3
+
+/**
+ * struct ttc_pwm_priv - Private data for TTC PWM drivers
+ * @chip:	PWM chip structure representing PWM controller
+ * @clk:	TTC input clock
+ * @rate:	TTC input clock rate
+ * @max:	Maximum value of the counters
+ * @base:	Base address of TTC instance
+ */
+struct ttc_pwm_priv {
+	struct pwm_chip chip;
+	struct clk *clk;
+	unsigned long rate;
+	u32 max;
+	void __iomem *base;
+};
+
+static inline u32 ttc_pwm_readl(struct ttc_pwm_priv *priv,
+				unsigned long offset)
+{
+	return readl_relaxed(priv->base + offset);
+}
+
+static inline void ttc_pwm_writel(struct ttc_pwm_priv *priv,
+				  unsigned long offset,
+				  unsigned long val)
+{
+	writel_relaxed(val, priv->base + offset);
+}
+
+static inline u32 ttc_pwm_ch_readl(struct ttc_pwm_priv *priv,
+				   unsigned int chnum,
+				   unsigned long offset)
+{
+	unsigned long pwm_ch_offset = offset +
+				       (TTC_PWM_CHANNEL * chnum);
+
+	return ttc_pwm_readl(priv, pwm_ch_offset);
+}
+
+static inline void ttc_pwm_ch_writel(struct ttc_pwm_priv *priv,
+				     unsigned int chnum,
+				     unsigned long offset,
+				     unsigned long val)
+{
+	unsigned long pwm_ch_offset = offset +
+				       (TTC_PWM_CHANNEL * chnum);
+
+	ttc_pwm_writel(priv, pwm_ch_offset, val);
+}
+
+static inline struct ttc_pwm_priv *xilinx_pwm_chip_to_priv(struct pwm_chip *chip)
+{
+	return container_of(chip, struct ttc_pwm_priv, chip);
+}
+
+static void ttc_pwm_enable(struct ttc_pwm_priv *priv, struct pwm_device *pwm)
+{
+	u32 ctrl_reg;
+
+	ctrl_reg = ttc_pwm_ch_readl(priv, pwm->hwpwm, TTC_CNT_CNTRL);
+	ctrl_reg |= (TTC_CNTR_CTRL_INTR_MODE_EN
+				 | TTC_CNTR_CTRL_MATCH_MODE_EN | TTC_CNTR_CTRL_RST);
+	ctrl_reg &= ~(TTC_CNTR_CTRL_DIS | TTC_CNTR_CTRL_WAVE_EN);
+	ttc_pwm_ch_writel(priv, pwm->hwpwm, TTC_CNT_CNTRL, ctrl_reg);
+}
+
+static void ttc_pwm_disable(struct ttc_pwm_priv *priv, struct pwm_device *pwm)
+{
+	u32 ctrl_reg;
+
+	ctrl_reg = ttc_pwm_ch_readl(priv, pwm->hwpwm, TTC_CNT_CNTRL);
+	ctrl_reg |= TTC_CNTR_CTRL_DIS;
+
+	ttc_pwm_ch_writel(priv, pwm->hwpwm, TTC_CNT_CNTRL, ctrl_reg);
+}
+
+static void ttc_pwm_set_polarity(struct ttc_pwm_priv *priv, struct pwm_device *pwm,
+				 enum pwm_polarity polarity)
+{
+	u32 ctrl_reg;
+
+	ctrl_reg = ttc_pwm_ch_readl(priv, pwm->hwpwm, TTC_CNT_CNTRL);
+
+	if (polarity == PWM_POLARITY_NORMAL)
+		ctrl_reg |= TTC_CNTR_CTRL_WAVE_POL;
+	else
+		ctrl_reg &= (~TTC_CNTR_CTRL_WAVE_POL);
+
+	ttc_pwm_ch_writel(priv, pwm->hwpwm, TTC_CNT_CNTRL, ctrl_reg);
+}
+
+static void ttc_pwm_set_counters(struct ttc_pwm_priv *priv,
+				 struct pwm_device *pwm,
+				 u32 period_cycles,
+				 u32 duty_cycles)
+{
+	/* Set up period */
+	ttc_pwm_ch_writel(priv, pwm->hwpwm, TTC_INTR_VAL, period_cycles);
+
+	/* Set up duty cycle */
+	ttc_pwm_ch_writel(priv, pwm->hwpwm, TTC_MATCH_CNT_VAL, duty_cycles);
+}
+
+static void ttc_pwm_set_prescalar(struct ttc_pwm_priv *priv,
+				  struct pwm_device *pwm,
+				  u32 div, bool is_enable)
+{
+	u32 clk_reg;
+
+	if (is_enable) {
+		/* Set up prescalar */
+		clk_reg = ttc_pwm_ch_readl(priv, pwm->hwpwm, TTC_CLK_CNTRL);
+		clk_reg &= ~TTC_CLK_CNTRL_PSV;
+		clk_reg |= (div << TTC_CNTR_CTRL_PRESCALE_SHIFT);
+		clk_reg |= TTC_CLK_CNTRL_PS_EN;
+		ttc_pwm_ch_writel(priv, pwm->hwpwm, TTC_CLK_CNTRL, clk_reg);
+	} else {
+		/* Disable prescalar */
+		clk_reg = ttc_pwm_ch_readl(priv, pwm->hwpwm, TTC_CLK_CNTRL);
+		clk_reg &= ~TTC_CLK_CNTRL_PS_EN;
+		ttc_pwm_ch_writel(priv, pwm->hwpwm, TTC_CLK_CNTRL, clk_reg);
+	}
+}
+
+static int ttc_pwm_apply(struct pwm_chip *chip,
+			 struct pwm_device *pwm,
+			 const struct pwm_state *state)
+{
+	struct ttc_pwm_priv *priv = xilinx_pwm_chip_to_priv(chip);
+	u64 duty_cycles, period_cycles;
+	struct pwm_state cstate;
+	unsigned long rate;
+	bool flag = false;
+	u32 div = 0;
+
+	cstate = pwm->state;
+
+	if (state->polarity != cstate.polarity) {
+		if (cstate.enabled)
+			ttc_pwm_disable(priv, pwm);
+
+		ttc_pwm_set_polarity(priv, pwm, state->polarity);
+	}
+
+	rate = priv->rate;
+
+	/* Prevent overflow by limiting to the maximum possible period */
+	period_cycles = min_t(u64, state->period, ULONG_MAX * NSEC_PER_SEC);
+	period_cycles = mul_u64_u64_div_u64(period_cycles, rate, NSEC_PER_SEC);
+
+	if (period_cycles > priv->max) {
+		/*
+		 * Prescale frequency to fit requested period cycles within limit.
+		 * Prescalar divides input clock by 2^(prescale_value + 1). Maximum
+		 * supported prescalar value is 15.
+		 */
+		div = mul_u64_u64_div_u64(state->period, rate, (NSEC_PER_SEC * priv->max));
+		div = order_base_2(div);
+		if (div)
+			div -= 1;
+
+		if (div > 15)
+			return -ERANGE;
+
+		rate = DIV_ROUND_CLOSEST(rate, BIT(div + 1));
+		period_cycles = mul_u64_u64_div_u64(state->period, rate,
+						    NSEC_PER_SEC);
+		flag = true;
+	}
+
+	if (cstate.enabled)
+		ttc_pwm_disable(priv, pwm);
+
+	duty_cycles = mul_u64_u64_div_u64(state->duty_cycle, rate,
+					  NSEC_PER_SEC);
+	ttc_pwm_set_counters(priv, pwm, period_cycles, duty_cycles);
+
+	ttc_pwm_set_prescalar(priv, pwm, div, flag);
+
+	if (state->enabled)
+		ttc_pwm_enable(priv, pwm);
+	else
+		ttc_pwm_disable(priv, pwm);
+
+	return 0;
+}
+
+static int ttc_pwm_get_state(struct pwm_chip *chip,
+			     struct pwm_device *pwm,
+			     struct pwm_state *state)
+{
+	struct ttc_pwm_priv *priv = xilinx_pwm_chip_to_priv(chip);
+	u32 value, pres_en, pres = 1;
+	unsigned long rate;
+	u64 tmp;
+
+	value = ttc_pwm_ch_readl(priv, pwm->hwpwm, TTC_CNT_CNTRL);
+
+	if (value & TTC_CNTR_CTRL_WAVE_POL)
+		state->polarity = PWM_POLARITY_NORMAL;
+	else
+		state->polarity = PWM_POLARITY_INVERSED;
+
+	if (value & TTC_CNTR_CTRL_DIS)
+		state->enabled = false;
+	else
+		state->enabled = true;
+
+	rate = priv->rate;
+
+	pres_en =  ttc_pwm_ch_readl(priv, pwm->hwpwm, TTC_CLK_CNTRL);
+	pres_en	&= TTC_CLK_CNTRL_PS_EN;
+
+	if (pres_en) {
+		pres = ttc_pwm_ch_readl(priv, pwm->hwpwm, TTC_CLK_CNTRL) & TTC_CLK_CNTRL_PSV;
+		pres >>= TTC_CNTR_CTRL_PRESCALE_SHIFT;
+		/* If prescale is enabled, the count rate is divided by 2^(pres + 1) */
+		pres = BIT(pres + 1);
+	}
+
+	tmp = ttc_pwm_ch_readl(priv, pwm->hwpwm, TTC_INTR_VAL);
+	tmp *= pres;
+	state->period = DIV64_U64_ROUND_UP(tmp * NSEC_PER_SEC, rate);
+
+	tmp = ttc_pwm_ch_readl(priv, pwm->hwpwm, TTC_MATCH_CNT_VAL);
+	tmp *= pres;
+	state->duty_cycle = DIV64_U64_ROUND_UP(tmp * NSEC_PER_SEC, rate);
+
+	return 0;
+}
+
+static const struct pwm_ops ttc_pwm_ops = {
+	.apply = ttc_pwm_apply,
+	.get_state = ttc_pwm_get_state,
+	.owner = THIS_MODULE,
+};
+
+static int ttc_pwm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	u32 pwm_cells, timer_width;
+	struct ttc_pwm_priv *priv;
+	int ret;
+
+	/*
+	 * If pwm-cells property is not present in TTC node,
+	 * it would be treated as clocksource/clockevent
+	 * device.
+	 */
+	ret = of_property_read_u32(np, "#pwm-cells", &pwm_cells);
+	if (ret == -EINVAL)
+		return -ENODEV;
+
+	if (ret)
+		return dev_err_probe(dev, ret, "could not read #pwm-cells\n");
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	ret = of_property_read_u32(np, "timer-width", &timer_width);
+	if (ret)
+		timer_width = 16;
+
+	priv->max = BIT(timer_width) - 1;
+
+	priv->clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(priv->clk))
+		return dev_err_probe(dev, PTR_ERR(priv->clk),
+				     "ERROR: timer input clock not found\n");
+
+	priv->rate = clk_get_rate(priv->clk);
+
+	clk_rate_exclusive_get(priv->clk);
+
+	priv->chip.dev = dev;
+	priv->chip.ops = &ttc_pwm_ops;
+	priv->chip.npwm = TTC_PWM_MAX_CH;
+	ret = pwmchip_add(&priv->chip);
+	if (ret) {
+		clk_rate_exclusive_put(priv->clk);
+		return dev_err_probe(dev, ret, "Could not register PWM chip\n");
+	}
+
+	platform_set_drvdata(pdev, priv);
+
+	return 0;
+}
+
+static void ttc_pwm_remove(struct platform_device *pdev)
+{
+	struct ttc_pwm_priv *priv = platform_get_drvdata(pdev);
+
+	pwmchip_remove(&priv->chip);
+	clk_rate_exclusive_put(priv->clk);
+}
+
+static const struct of_device_id __maybe_unused ttc_pwm_of_match[] = {
+	{ .compatible = "cdns,ttc"},
+	{},
+};
+MODULE_DEVICE_TABLE(of, ttc_pwm_of_match);
+
+static struct platform_driver ttc_pwm_driver = {
+	.probe = ttc_pwm_probe,
+	.remove_new = ttc_pwm_remove,
+	.driver = {
+		.name = "ttc-pwm",
+		.of_match_table = of_match_ptr(ttc_pwm_of_match),
+	},
+};
+module_platform_driver(ttc_pwm_driver);
+
+MODULE_AUTHOR("Mubin Sayyed <mubin.sayyed@amd.com>");
+MODULE_DESCRIPTION("Cadence TTC PWM driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

