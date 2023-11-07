Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7E87E47D9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 19:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343886AbjKGSJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 13:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234968AbjKGSJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 13:09:25 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2086.outbound.protection.outlook.com [40.107.96.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10C1C0;
        Tue,  7 Nov 2023 10:09:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bw+kgmGC37CjF1k/zhIG5EVN4iEAtzH7vGgfNwKcV/tO1yl2TGMHsPzfk1290OG15l9M4EdaxmhQEz/Tm2rQtzCyrI+T7SLfrGe3WqMrlkoI2lQjhPlmRd+nDCX0MIOIyIqkGgjM7ekoTV2CEggwUNeGYlAZ2PHb/haF6zF6P2n8crXVSypSU+keRcbWXiqB6Kojf8z4MC+D4/rldwVL2Mx1t/nUCsCbTJyjVcDrAT9ORY1WB4WnwsOF8YW1V2he9C2/RdSGlr9CIF9nHQ2zaOwrvKoo7GyewPTIoXGlZt4S0G/9dpfoVm/cjFwNZk5xljYhDss8Yax4A5sqYq12cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3L/syzb4Rc6HWePmcB1r2c4/nuOZUqDc2EG4HGtQMBU=;
 b=fYwQ4CEiv5//jNJgymzP09KxAOVtc0jz5L6pj9AkyfFs2DANR4IMsUIz/V+yW8BobZUAgBvVGJgIJXJO1Mt4Br37TAihukuAYLjE1O2Ia/mGbUFFg3TLMIgKCAHEIU/cTT3b/lbw+az09mH6tQQhgDeB9pynIot1KZAOofayDUcOM/vzIHPXx9GjeDe5rI6RPvEXIoUylnt7KW5a0XiN0pE8sJrvelNx0S3+/GefZkHso4iKClVX/Ygv1mGSTwZwgef1Ol0gAamCh4GjcUiuTyn8aud48WTPaH1AnU2h0bTdjrbFSAEloxFB7OxyTGn3AqoLmstks4z3TcnNxjujvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3L/syzb4Rc6HWePmcB1r2c4/nuOZUqDc2EG4HGtQMBU=;
 b=0Xx+w5UWcKWotayd3eRU/N/Vim2/Ix6jzrZBFDfnqtxjyG0tFgvYq+OV8emJNrUBOL07T5w0+s0dGkBpClB5uTTBGEePc7J4Tu+Qyc/ZduzjKgT2DumUpxSGRYkNGBkpnzG/Lnyn+Ub0McMQDQraZJyMnr2W0BRl68SF2pRJW4Y=
Received: from SA1P222CA0124.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::12)
 by CH0PR12MB5218.namprd12.prod.outlook.com (2603:10b6:610:d1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 18:09:20 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:3c5:cafe::8f) by SA1P222CA0124.outlook.office365.com
 (2603:10b6:806:3c5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Tue, 7 Nov 2023 18:09:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Tue, 7 Nov 2023 18:09:19 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 7 Nov
 2023 12:09:19 -0600
Received: from xsjapps58.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Tue, 7 Nov 2023 12:09:18 -0600
From:   Kris Chaplin <kris.chaplin@amd.com>
To:     <kris.chaplin@amd.com>, <thomas.delev@amd.com>,
        <michal.simek@amd.com>, <krzysztof.kozlowski@linaro.org>,
        <robh+dt@kernel.org>, <conor+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>
Subject: [PATCH v3 2/2] w1: Add AXI 1-wire host driver for AMD programmable logic IP core
Date:   Tue, 7 Nov 2023 10:06:52 -0800
Message-ID: <20231107180814.615933-3-kris.chaplin@amd.com>
X-Mailer: git-send-email 2.42.GIT
In-Reply-To: <20231107180814.615933-1-kris.chaplin@amd.com>
References: <20231107180814.615933-1-kris.chaplin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|CH0PR12MB5218:EE_
X-MS-Office365-Filtering-Correlation-Id: 09141526-3760-4a9f-bafb-08dbdfbca9d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eM4mDlXujtzrBYjuYUko9Oabif1YP/42qCRYSwz1GylevB1EUq1jmNTokr9bDslM337mteprHdA9o04qQYETKv+LFlurPlGAbnpstPCbWGyyfnLVeAVUBdxQ1dVhhFo3iMWxiZF5iPlu8eug3dL+eSTolflJ1Hk01x/7VGeFIOS3UbAATMOxydKK9lx+fyXOhCvYclaQQ0ssy2JtHbAdDTEEAhjdeBvwOgQQhur8GmhjEqkN8qMl9yP/hpKK/J78bOmzJxAyvY6OiZNa2lutRqrhWnu2LaENUitH0FZpC3rzCjzIvHKorvP5O8mTn1Ga+qe4hjJpnKW76IXyTOPtvvw5+w2jn4phCRwwlesLer+Ip7RWHh7/LW0HtHILSc/+0uyiajQ30F4W3ILMvT8q6gFlcPi6tns9QGNRkNkla1Hadi62p6onpkiVm6WRl+KBN6hjaLEgrLL5XHgUu9hshKXzvXafyfAPqF9rh0afvhyDXTgegHq0aJxBUBl0uQlGypqMZPK1V5/oRGbinVEjeCiMViWWjN6MrbMbIrG3dcH07NOqoYTZWFxslZCAcW+GKuoPvsWQT9W0/kGLD7yJn4nhILJzytnEQNXUzIu9LUEuS8lul5Cpd7c2FEcT2vVPMoIf5AHdLKpbk5nOPWW0qhQyXcn8CZ2dvMDcC4l1Tixxcgk+aHyUJziNa0wGttIQshu3AzptgT5NHu3+aQeZFZfUgKk1uaRDvjI8wBLOLJ6kXbJny3QE4o73QwP0wQJslIJOb51fdwYcdOymmCfYzA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(1800799009)(82310400011)(64100799003)(451199024)(186009)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(426003)(4326008)(47076005)(83380400001)(26005)(336012)(1076003)(2616005)(36860700001)(44832011)(8936002)(41300700001)(8676002)(30864003)(2906002)(316002)(5660300002)(54906003)(70206006)(478600001)(6666004)(110136005)(70586007)(36756003)(86362001)(356005)(82740400003)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 18:09:19.6865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09141526-3760-4a9f-bafb-08dbdfbca9d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5218
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a host driver to support the AMD 1-Wire programmable logic IP block.
This block guarantees protocol timing for driving off-board devices such
as thermal sensors, proms, etc.

Add file to MAINTAINERS

Co-developed-by: Thomas Delev <thomas.delev@amd.com>
Signed-off-by: Thomas Delev <thomas.delev@amd.com>
Signed-off-by: Kris Chaplin <kris.chaplin@amd.com>
---
 MAINTAINERS                     |   1 +
 drivers/w1/masters/Kconfig      |  11 +
 drivers/w1/masters/Makefile     |   1 +
 drivers/w1/masters/amd_axi_w1.c | 395 ++++++++++++++++++++++++++++++++
 4 files changed, 408 insertions(+)
 create mode 100644 drivers/w1/masters/amd_axi_w1.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2b23febfaf72..d6c6b89a0e66 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -897,6 +897,7 @@ R:	Thomas Delev <thomas.delev@amd.com>
 R:	Michal Simek <michal.simek@amd.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/w1/amd,axi-1wire-host.yaml
+F:	drivers/w1/masters/amd_axi_w1.c
 
 AMD CDX BUS DRIVER
 M:	Nipun Gupta <nipun.gupta@amd.com>
diff --git a/drivers/w1/masters/Kconfig b/drivers/w1/masters/Kconfig
index ad316573288a..513c0b114337 100644
--- a/drivers/w1/masters/Kconfig
+++ b/drivers/w1/masters/Kconfig
@@ -5,6 +5,17 @@
 
 menu "1-wire Bus Masters"
 
+config W1_MASTER_AMD_AXI
+	tristate "AMD AXI 1-wire bus host"
+	help
+	  Say Y here is you want to support the AMD AXI 1-wire IP core.
+	  This driver makes use of the programmable logic IP to perform
+	  correctly timed 1 wire transactions without relying on GPIO timing
+	  through the kernel.
+
+	  This driver can also be built as a module.  If so, the module will be
+	  called amd_w1_axi.
+
 config W1_MASTER_MATROX
 	tristate "Matrox G400 transport layer for 1-wire"
 	depends on PCI
diff --git a/drivers/w1/masters/Makefile b/drivers/w1/masters/Makefile
index c5d85a827e52..6c5a21f9b88c 100644
--- a/drivers/w1/masters/Makefile
+++ b/drivers/w1/masters/Makefile
@@ -3,6 +3,7 @@
 # Makefile for 1-wire bus master drivers.
 #
 
+obj-$(CONFIG_W1_MASTER_AMD_AXI)		+= amd_axi_w1.o
 obj-$(CONFIG_W1_MASTER_MATROX)		+= matrox_w1.o
 obj-$(CONFIG_W1_MASTER_DS2490)		+= ds2490.o
 obj-$(CONFIG_W1_MASTER_DS2482)		+= ds2482.o
diff --git a/drivers/w1/masters/amd_axi_w1.c b/drivers/w1/masters/amd_axi_w1.c
new file mode 100644
index 000000000000..24a05c2de5f1
--- /dev/null
+++ b/drivers/w1/masters/amd_axi_w1.c
@@ -0,0 +1,395 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * amd_axi_w1 - AMD 1Wire programmable logic bus host driver
+ *
+ * Copyright (C) 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
+ */
+
+#include <linux/atomic.h>
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+
+#include <linux/w1.h>
+
+/* 1-wire AMD IP definition */
+#define AXIW1_IPID	0x10ee4453
+/* Registers offset */
+#define AXIW1_INST_REG	0x0
+#define AXIW1_CTRL_REG	0x4
+#define AXIW1_IRQE_REG	0x8
+#define AXIW1_STAT_REG	0xC
+#define AXIW1_DATA_REG	0x10
+#define AXIW1_IPVER_REG	0x18
+#define AXIW1_IPID_REG	0x1C
+/* Instructions */
+#define AXIW1_INITPRES	0x0800
+#define AXIW1_READBIT	0x0C00
+#define AXIW1_WRITEBIT	0x0E00
+#define AXIW1_READBYTE	0x0D00
+#define AXIW1_WRITEBYTE	0x0F00
+/* Status flag masks */
+#define AXIW1_DONE	BIT(0)
+#define AXIW1_READY	BIT(4)
+#define AXIW1_PRESENCE	BIT(31)
+#define AXIW1_MAJORVER_MASK	GENMASK(23, 8)
+#define AXIW1_MINORVER_MASK	GENMASK(7, 0)
+/* Control flag */
+#define AXIW1_GO	BIT(0)
+#define AXI_CLEAR	0
+#define AXI_RESET	BIT(31)
+#define AXIW1_READDATA	BIT(0)
+/* Interrupt Enable */
+#define AXIW1_READY_IRQ_EN	BIT(4)
+#define AXIW1_DONE_IRQ_EN	BIT(0)
+
+#define AXIW1_TIMEOUT	msecs_to_jiffies(100)
+
+#define DRIVER_NAME	"amd_axi_w1"
+
+struct amd_axi_w1_local {
+	struct device *dev;
+	void __iomem *base_addr;
+	int irq;
+	atomic_t flag;			/* Set on IRQ, cleared once serviced */
+	wait_queue_head_t wait_queue;
+	struct w1_bus_master bus_host;
+};
+
+/**
+ * amd_axi_w1_wait_irq_interruptible_timeout() - Wait for IRQ with timeout.
+ *
+ * @amd_axi_w1_local:	Pointer to device structure
+ * @IRQ:		IRQ channel to wait on
+ *
+ * Return:		%0 - OK, %-EINTR - Interrupted, %-EBUSY - Timed out
+ */
+static int amd_axi_w1_wait_irq_interruptible_timeout(struct amd_axi_w1_local *amd_axi_w1_local,
+						     u32 IRQ)
+{
+	int ret;
+
+	/* Enable the IRQ requested and wait for flag to indicate it's been triggered */
+	iowrite32(IRQ, amd_axi_w1_local->base_addr + AXIW1_IRQE_REG);
+	ret = wait_event_interruptible_timeout(amd_axi_w1_local->wait_queue,
+					       atomic_read(&amd_axi_w1_local->flag) != 0,
+					       AXIW1_TIMEOUT);
+	if (ret < 0) {
+		dev_err(amd_axi_w1_local->dev, "Wait IRQ Interrupted\n");
+		return -EINTR;
+	}
+
+	if (!ret) {
+		dev_err(amd_axi_w1_local->dev, "Wait IRQ Timeout\n");
+		return -EBUSY;
+	}
+
+	atomic_set(&amd_axi_w1_local->flag, 0);
+	return 0;
+}
+
+/**
+ * amd_axi_w1_touch_bit() - Performs the touch-bit function - write a 0 or 1 and reads the level.
+ *
+ * @data:	Pointer to device structure
+ * @bit:	The level to write
+ *
+ * Return:	The level read
+ */
+static u8 amd_axi_w1_touch_bit(void *data, u8 bit)
+{
+	struct amd_axi_w1_local *amd_axi_w1_local = data;
+	u8 val = 0;
+	int rc;
+
+	/* Wait for READY signal to be 1 to ensure 1-wire IP is ready */
+	while ((ioread32(amd_axi_w1_local->base_addr + AXIW1_STAT_REG) & AXIW1_READY) == 0) {
+		rc = amd_axi_w1_wait_irq_interruptible_timeout(amd_axi_w1_local,
+							       AXIW1_READY_IRQ_EN);
+		if (rc < 0)
+			return 1; /* Callee doesn't test for error. Return inactive bus state */
+	}
+
+	if (bit)
+		/* Read. Write read Bit command in register 0 */
+		iowrite32(AXIW1_READBIT, amd_axi_w1_local->base_addr + AXIW1_INST_REG);
+	else
+		/* Write. Write tx Bit command in instruction register with bit to transmit */
+		iowrite32(AXIW1_WRITEBIT + (bit & 0x01),
+			  amd_axi_w1_local->base_addr + AXIW1_INST_REG);
+
+	/* Write Go signal and clear control reset signal in control register */
+	iowrite32(AXIW1_GO, amd_axi_w1_local->base_addr + AXIW1_CTRL_REG);
+
+	/* Wait for done signal to be 1 */
+	while ((ioread32(amd_axi_w1_local->base_addr + AXIW1_STAT_REG) & AXIW1_DONE) != 1) {
+		rc = amd_axi_w1_wait_irq_interruptible_timeout(amd_axi_w1_local, AXIW1_DONE_IRQ_EN);
+		if (rc < 0)
+			return 1; /* Callee doesn't test for error. Return inactive bus state */
+	}
+
+	/* If read, Retrieve data from register */
+	if (bit)
+		val = (u8)(ioread32(amd_axi_w1_local->base_addr + AXIW1_DATA_REG) & AXIW1_READDATA);
+
+	/* Clear Go signal in register 1 */
+	iowrite32(AXI_CLEAR, amd_axi_w1_local->base_addr + AXIW1_CTRL_REG);
+
+	return val;
+}
+
+/**
+ * amd_axi_w1_read_byte - Performs the read byte function.
+ *
+ * @data:	Pointer to device structure
+ * Return:	The value read
+ */
+static u8 amd_axi_w1_read_byte(void *data)
+{
+	struct amd_axi_w1_local *amd_axi_w1_local = data;
+	u8 val = 0;
+	int rc;
+
+	/* Wait for READY signal to be 1 to ensure 1-wire IP is ready */
+	while ((ioread32(amd_axi_w1_local->base_addr + AXIW1_STAT_REG) & AXIW1_READY) == 0) {
+		rc = amd_axi_w1_wait_irq_interruptible_timeout(amd_axi_w1_local,
+							       AXIW1_READY_IRQ_EN);
+		if (rc < 0)
+			return 0xFF; /* Return inactive bus state */
+	}
+
+	/* Write read Byte command in instruction register*/
+	iowrite32(AXIW1_READBYTE, amd_axi_w1_local->base_addr + AXIW1_INST_REG);
+
+	/* Write Go signal and clear control reset signal in control register */
+	iowrite32(AXIW1_GO, amd_axi_w1_local->base_addr + AXIW1_CTRL_REG);
+
+	/* Wait for done signal to be 1 */
+	while ((ioread32(amd_axi_w1_local->base_addr + AXIW1_STAT_REG) & AXIW1_DONE) != 1) {
+		rc = amd_axi_w1_wait_irq_interruptible_timeout(amd_axi_w1_local, AXIW1_DONE_IRQ_EN);
+		if (rc < 0)
+			return 0xFF; /* Return inactive bus state */
+	}
+
+	/* Retrieve LSB bit in data register to get RX byte */
+	val = (u8)(ioread32(amd_axi_w1_local->base_addr + AXIW1_DATA_REG) & 0x000000FF);
+
+	/* Clear Go signal in control register */
+	iowrite32(AXI_CLEAR, amd_axi_w1_local->base_addr + AXIW1_CTRL_REG);
+
+	return val;
+}
+
+/**
+ * amd_axi_w1_write_byte - Performs the write byte function.
+ *
+ * @data:	The ds2482 channel pointer
+ * @val:	The value to write
+ */
+static void amd_axi_w1_write_byte(void *data, u8 val)
+{
+	struct amd_axi_w1_local *amd_axi_w1_local = data;
+	int rc;
+
+	/* Wait for READY signal to be 1 to ensure 1-wire IP is ready */
+	while ((ioread32(amd_axi_w1_local->base_addr + AXIW1_STAT_REG) & AXIW1_READY) == 0) {
+		rc = amd_axi_w1_wait_irq_interruptible_timeout(amd_axi_w1_local,
+							       AXIW1_READY_IRQ_EN);
+		if (rc < 0)
+			return;
+	}
+
+	/* Write tx Byte command in instruction register with bit to transmit */
+	iowrite32(AXIW1_WRITEBYTE + val, amd_axi_w1_local->base_addr + AXIW1_INST_REG);
+
+	/* Write Go signal and clear control reset signal in register 1 */
+	iowrite32(AXIW1_GO, amd_axi_w1_local->base_addr + AXIW1_CTRL_REG);
+
+	/* Wait for done signal to be 1 */
+	while ((ioread32(amd_axi_w1_local->base_addr + AXIW1_STAT_REG) & AXIW1_DONE) != 1) {
+		rc = amd_axi_w1_wait_irq_interruptible_timeout(amd_axi_w1_local,
+							       AXIW1_DONE_IRQ_EN);
+		if (rc < 0)
+			return;
+	}
+
+	/* Clear Go signal in control register */
+	iowrite32(AXI_CLEAR, amd_axi_w1_local->base_addr + AXIW1_CTRL_REG);
+}
+
+/**
+ * amd_axi_w1_reset_bus() - Issues a reset bus sequence.
+ *
+ * @data:	the bus host data struct
+ * Return:	0=Device present, 1=No device present or error
+ */
+static u8 amd_axi_w1_reset_bus(void *data)
+{
+	struct amd_axi_w1_local *amd_axi_w1_local = data;
+	u8 val = 0;
+	int rc;
+
+	/* Reset 1-wire Axi IP */
+	iowrite32(AXI_RESET, amd_axi_w1_local->base_addr + AXIW1_CTRL_REG);
+
+	/* Wait for READY signal to be 1 to ensure 1-wire IP is ready */
+	while ((ioread32(amd_axi_w1_local->base_addr + AXIW1_STAT_REG) & AXIW1_READY) == 0) {
+		rc = amd_axi_w1_wait_irq_interruptible_timeout(amd_axi_w1_local,
+							       AXIW1_READY_IRQ_EN);
+		if (rc < 0)
+			return 1; /* Something went wrong with the hardware */
+	}
+	/* Write Initialization command in instruction register */
+	iowrite32(AXIW1_INITPRES, amd_axi_w1_local->base_addr + AXIW1_INST_REG);
+
+	/* Write Go signal and clear control reset signal in register 1 */
+	iowrite32(AXIW1_GO, amd_axi_w1_local->base_addr + AXIW1_CTRL_REG);
+
+	/* Wait for done signal to be 1 */
+	while ((ioread32(amd_axi_w1_local->base_addr + AXIW1_STAT_REG) & AXIW1_DONE) != 1) {
+		rc = amd_axi_w1_wait_irq_interruptible_timeout(amd_axi_w1_local, AXIW1_DONE_IRQ_EN);
+		if (rc < 0)
+			return 1; /* Something went wrong with the hardware */
+	}
+	/* Retrieve MSB bit in status register to get failure bit */
+	if ((ioread32(amd_axi_w1_local->base_addr + AXIW1_STAT_REG) & AXIW1_PRESENCE) != 0)
+		val = 1;
+
+	/* Clear Go signal in control register */
+	iowrite32(AXI_CLEAR, amd_axi_w1_local->base_addr + AXIW1_CTRL_REG);
+
+	return val;
+}
+
+/* Reset the 1-wire AXI IP. Put the IP in reset state and clear registers */
+static void amd_axi_w1_reset(struct amd_axi_w1_local *amd_axi_w1_local)
+{
+	iowrite32(AXI_RESET, amd_axi_w1_local->base_addr + AXIW1_CTRL_REG);
+	iowrite32(AXI_CLEAR, amd_axi_w1_local->base_addr + AXIW1_INST_REG);
+	iowrite32(AXI_CLEAR, amd_axi_w1_local->base_addr + AXIW1_IRQE_REG);
+	iowrite32(AXI_CLEAR, amd_axi_w1_local->base_addr + AXIW1_STAT_REG);
+	iowrite32(AXI_CLEAR, amd_axi_w1_local->base_addr + AXIW1_DATA_REG);
+}
+
+static irqreturn_t amd_axi_w1_irq(int irq, void *lp)
+{
+	struct amd_axi_w1_local *amd_axi_w1_local = lp;
+
+	/* Reset interrupt trigger */
+	iowrite32(AXI_CLEAR, amd_axi_w1_local->base_addr + AXIW1_IRQE_REG);
+
+	atomic_set(&amd_axi_w1_local->flag, 1);
+	wake_up_interruptible(&amd_axi_w1_local->wait_queue);
+
+	return IRQ_HANDLED;
+}
+
+static int amd_axi_w1_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct amd_axi_w1_local *lp;
+	struct clk *clk;
+	u32 ver_major, ver_minor;
+	int val, rc = 0;
+
+	lp = devm_kzalloc(dev, sizeof(*lp), GFP_KERNEL);
+	if (!lp)
+		return -ENOMEM;
+
+	lp->dev = dev;
+	lp->base_addr = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(lp->base_addr))
+		return PTR_ERR(lp->base_addr);
+
+	lp->irq = platform_get_irq(pdev, 0);
+	if (lp->irq < 0)
+		return lp->irq;
+
+	rc = devm_request_irq(dev, lp->irq, &amd_axi_w1_irq, IRQF_TRIGGER_HIGH, DRIVER_NAME, lp);
+	if (rc)
+		return rc;
+
+	/* Initialize wait queue and flag */
+	init_waitqueue_head(&lp->wait_queue);
+
+	clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	/* Verify IP presence in HW */
+	if (ioread32(lp->base_addr + AXIW1_IPID_REG) != AXIW1_IPID) {
+		dev_err(dev, "AMD 1-wire IP not detected in hardware\n");
+		return -ENODEV;
+	}
+
+	/*
+	 * Allow for future driver expansion supporting new hardware features
+	 * This driver currently only supports hardware 1.x, but include logic
+	 * to detect if a potentially incompatible future version is used
+	 * by reading major version ID. It is highly undesirable for new IP versions
+	 * to break the API, but this code will at least allow for graceful failure
+	 * should that happen. Future new features can be enabled by hardware
+	 * incrementing the minor version and augmenting the driver to detect capability
+	 * using the minor version number
+	 */
+	val = ioread32(lp->base_addr + AXIW1_IPVER_REG);
+	ver_major = FIELD_GET(AXIW1_MAJORVER_MASK, val);
+	ver_minor = FIELD_GET(AXIW1_MINORVER_MASK, val);
+
+	if (ver_major != 1) {
+		dev_err(dev, "AMD AXI W1 host version %u.%u is not supported by this driver",
+			ver_major, ver_minor);
+		return -ENODEV;
+	}
+
+	lp->bus_host.data = lp;
+	lp->bus_host.touch_bit = amd_axi_w1_touch_bit;
+	lp->bus_host.read_byte = amd_axi_w1_read_byte;
+	lp->bus_host.write_byte = amd_axi_w1_write_byte;
+	lp->bus_host.reset_bus = amd_axi_w1_reset_bus;
+
+	amd_axi_w1_reset(lp);
+
+	platform_set_drvdata(pdev, lp);
+	rc = w1_add_master_device(&lp->bus_host);
+	if (rc) {
+		dev_err(dev, "Could not add host device\n");
+		return rc;
+	}
+
+	return 0;
+}
+
+static void amd_axi_w1_remove(struct platform_device *pdev)
+{
+	struct amd_axi_w1_local *lp = platform_get_drvdata(pdev);
+
+	w1_remove_master_device(&lp->bus_host);
+}
+
+static const struct of_device_id amd_axi_w1_of_match[] = {
+	{ .compatible = "amd,axi-1wire-host" },
+	{ /* end of list */ },
+};
+MODULE_DEVICE_TABLE(of, amd_axi_w1_of_match);
+
+static struct platform_driver amd_axi_w1_driver = {
+	.probe = amd_axi_w1_probe,
+	.remove_new = amd_axi_w1_remove,
+	.driver = {
+		.name = DRIVER_NAME,
+		.of_match_table = amd_axi_w1_of_match,
+	},
+};
+module_platform_driver(amd_axi_w1_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Kris Chaplin <kris.chaplin@amd.com>");
+MODULE_DESCRIPTION("Driver for AMD AXI 1 Wire IP core");
-- 
2.42.GIT

