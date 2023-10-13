Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B1E7C8217
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjJMJbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjJMJbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:31:36 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B223BD;
        Fri, 13 Oct 2023 02:31:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J67Xse5vcO/JgXdRWsao8t4+EsNUevE41DMruoKQVEs4xGcLZ96pq+y1/tJlZF+V9lA2xLPTJY2T+VBzl1wxjXJXmPCLlmBrkZy9KRu0WItwDIk+LMfcaOVpKG+88lnIFQGS46sXM0lLKtSnzG1xBtRGHT/bASmAA+AUzN51SZlf+1aPkDvVluuUET5dL6ImEiC8VOWb8K6X3XiVakHWmBcqxKkuqxOmjkrMJhw/UkMGfZzo9MrOFgBBKCQ3wvd+aQFC2tFV0OnIXW27zkWcsIzgKDKZFZHIb/my+5KybLaJZT17sAzsuoNMGXwQ3xWGFoDhwpSSH0sJcwKhSE1M0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wuvl7rP8wu99i5uMySPY1mbgVsvXzJMnWuYXJ33hEFw=;
 b=B+i3tf8X4LtgXwp2kvfm9tdl9j5ETw7Eq+/koUc8pHxZHofU15cxNS8koNqISiaT7nwUl5TX6YbyvfarJf9fJShpXJNgdInWnuv7DRXc4dHyLscxrIQtiawLRtPnEiBE/TGbMkHGLfVOB7CGNTzFoSa7CVkver2VcQQe+lRYo4ZhXDfu4vrrTDCmVLXm1pkKaP4YbT44tSKcWlBwRgF9GLk7mFxdCIINCORFZMcLqlNFhsU5mxgvXHVwcRg2j5b7PiSBuF7WIJ8Pqt9R2t5QRK+wP9p4QVUAySzhVTAPlEz63DgmlpoBDuvt9lPJ5eUotZtBOGMO4e2MIhhYSDHMXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wuvl7rP8wu99i5uMySPY1mbgVsvXzJMnWuYXJ33hEFw=;
 b=iGnS0igqnKvJXDzM84Jx28d829jzm8hI/cLU6Nh0KwF8iXYHI1nYdCdn8smZR0x8wczN1hXFNBfwHJSS7Nehf5IW5aJDBgWattuar8fJ9bvKJtuyancfROosvOea87Mk98Rh/CA0exBlvpa3jrqkjs42ni6/foS5IYmO3KfzybI=
Received: from CY8PR02CA0004.namprd02.prod.outlook.com (2603:10b6:930:4d::21)
 by SA3PR12MB8024.namprd12.prod.outlook.com (2603:10b6:806:312::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 09:31:31 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:4d:cafe::c) by CY8PR02CA0004.outlook.office365.com
 (2603:10b6:930:4d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.30 via Frontend
 Transport; Fri, 13 Oct 2023 09:31:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 09:31:31 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 04:31:30 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 02:31:30 -0700
Received: from xsjapps55.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 13 Oct 2023 04:31:29 -0500
From:   Kris Chaplin <kris.chaplin@amd.com>
To:     <kris.chaplin@amd.com>, <thomas.delev@amd.com>,
        <michal.simek@amd.com>, <krzysztof.kozlowski@linaro.org>,
        <robh+dt@kernel.org>, <conor+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>
Subject: [PATCH 2/2] w1: Add 1-wire master driver for AMD programmable logic IP Core
Date:   Fri, 13 Oct 2023 02:30:13 -0700
Message-ID: <20231013093109.37165-3-kris.chaplin@amd.com>
X-Mailer: git-send-email 2.42.GIT
In-Reply-To: <20231013093109.37165-1-kris.chaplin@amd.com>
References: <20231013093109.37165-1-kris.chaplin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|SA3PR12MB8024:EE_
X-MS-Office365-Filtering-Correlation-Id: 82d9fb84-24b7-4b58-aabc-08dbcbcf2f5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xbpPWyEoakDHLS65O4QJ8Q6DzvYTmBCkdbwUjn9TD3inIhjhyaXHuR2xsspprptt0OijtFdXqeeJoropkz6+2QPtGzzxKFB3FqJ5LKcVjC2IhN1cXaewrR7fkb0NSBznfj0D9HumGUraMCRn8F2w/zOUUYNM6TofYkp2z5+KtirREimPihBmWOHbN2RFkDQWk6jbc60Qksc4pYGeg2cQpmJmODqTSvA2zh43Sp9VpKF73LwjuC35PMRGYRBcfIuRcLNwgcUsJH+9+aQqIjXvap/WB0JOIcikH2mGDFaeij5ijXvxw6LoE0L4yU8CuExyA0D4n8NEuIXeWdAjT+33H+aJmIoZGHJSod5nfDL8n5g0EQvBZpbqvkRdZF1o6D3rk/JSa4X+GYAWRXGBQGBbCXW9hOOVaybo+hUYb3hI1VndrFmh+rbSx6tTDvS+Myz0SKxZ0/k4P55jSb1Rlqhwfo37Mf6xTyWDFXtXyJDZV+Kd5+Y6u88N2PB3jZbFZvqQnX5O3JrcU0CN2gWkFRM0Vjdmu0SSQpxesgCV6n2kZH35pK5hC9Epu2MCU6xZs5EGttbO6WLgAoAf7+tLGWSD2t26xoLmIvz2DW0Vy9tGnE8MB8ek6tMGpAB/kX4VZ3I46Q6BglrGt3+VcqLyaxRIFngIveoIdEX9O4ukTa9mechvA6vpsZ++Q4wIo7GCxGxMiYVhCqGc50tkfyGfm3SRx7Y1nrNTDp2BAHNV4r2tgk6TqYlv9rX8ZGhMlQv0u0PQYS9yRnT0OQtJYIlPxKs8Bw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(1800799009)(82310400011)(64100799003)(451199024)(186009)(40470700004)(36840700001)(46966006)(478600001)(82740400003)(316002)(6666004)(54906003)(110136005)(70206006)(70586007)(4326008)(41300700001)(44832011)(8676002)(8936002)(356005)(36860700001)(81166007)(1076003)(426003)(26005)(40480700001)(2616005)(336012)(83380400001)(2906002)(5660300002)(40460700003)(36756003)(47076005)(86362001)(30864003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 09:31:31.5103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d9fb84-24b7-4b58-aabc-08dbcbcf2f5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8024
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a master driver to support the AMD 1-Wire programmable logic IP block.
This block guarantees protocol timing for driving off-board devices such
as thermal sensors, proms, etc.

Add file to MAINTAINERS

Co-developed-by: Thomas Delev <thomas.delev@amd.com>
Signed-off-by: Thomas Delev <thomas.delev@amd.com>
Signed-off-by: Kris Chaplin <kris.chaplin@amd.com>
---
 MAINTAINERS                 |   1 +
 drivers/w1/masters/Kconfig  |  11 +
 drivers/w1/masters/Makefile |   1 +
 drivers/w1/masters/amd_w1.c | 422 ++++++++++++++++++++++++++++++++++++
 4 files changed, 435 insertions(+)
 create mode 100644 drivers/w1/masters/amd_w1.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6ec3922b256e..7f26dab5261b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1072,6 +1072,7 @@ R:	Thomas Delev <thomas.delev@amd.com>
 R:	Michal Simek <michal.simek@amd.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/w1/amd,axi-1wire-master.yaml
+F:	drivers/w1/masters/amd_w1.c
 
 AMD XGBE DRIVER
 M:	"Shyam Sundar S K" <Shyam-sundar.S-k@amd.com>
diff --git a/drivers/w1/masters/Kconfig b/drivers/w1/masters/Kconfig
index ad316573288a..9232fd1f4e5b 100644
--- a/drivers/w1/masters/Kconfig
+++ b/drivers/w1/masters/Kconfig
@@ -67,5 +67,16 @@ config W1_MASTER_SGI
 	  This support is also available as a module.  If so, the module
 	  will be called sgi_w1.
 
+config W1_MASTER_AMD
+	tristate "AMD AXI 1-wire bus master"
+	help
+	  Say Y here is you want to support the AMD AXI 1-wire IP core.
+	  This driver makes use of the programmable logic IP to perform
+	  correctly timed 1 wire transactions without relying on GPIO timing
+	  through the kernel.
+
+	  This driver can also be built as a module.  If so, the module will be
+	  called amd_w1.
+
 endmenu
 
diff --git a/drivers/w1/masters/Makefile b/drivers/w1/masters/Makefile
index c5d85a827e52..cd3da1daaf97 100644
--- a/drivers/w1/masters/Makefile
+++ b/drivers/w1/masters/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_W1_MASTER_MXC)		+= mxc_w1.o
 obj-$(CONFIG_W1_MASTER_GPIO)		+= w1-gpio.o
 obj-$(CONFIG_HDQ_MASTER_OMAP)		+= omap_hdq.o
 obj-$(CONFIG_W1_MASTER_SGI)		+= sgi_w1.o
+obj-$(CONFIG_W1_MASTER_AMD)		+= amd_w1.o
diff --git a/drivers/w1/masters/amd_w1.c b/drivers/w1/masters/amd_w1.c
new file mode 100644
index 000000000000..04bf08c1b6d7
--- /dev/null
+++ b/drivers/w1/masters/amd_w1.c
@@ -0,0 +1,422 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * amd_w1 - AMD 1Wire bus master driver
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
+#define DRIVER_NAME	"amd_w1"
+
+struct amd_w1_local {
+	struct device *dev;
+	void __iomem *base_addr;
+	int irq;
+	atomic_t flag;
+	struct clk *clk;
+	wait_queue_head_t wait_queue;
+};
+
+/**
+ * amd_w1_write_register() - Helper to write a hardware register.
+ *
+ * @amd_w1_local:	Pointer to device structure
+ * @reg_offset:		Register offset in bytes to write
+ * @val:		Value to write
+ */
+static inline void amd_w1_write_register(struct amd_w1_local *amd_w1_local,
+					 u8 reg_offset, u32 val)
+{
+	iowrite32(val, amd_w1_local->base_addr + reg_offset);
+};
+
+/**
+ * amd_w1_read_register() - Helper to write a hardware register.
+ *
+ * @amd_w1_local:	Pointer to device structure
+ * @reg_offset:		Register offset in bytes to write
+ *
+ * Return:		Value of register read
+ */
+static inline u32 amd_w1_read_register(struct amd_w1_local *amd_w1_local, u8 reg_offset)
+{
+	return ioread32(amd_w1_local->base_addr + reg_offset);
+};
+
+/**
+ * amd_w1_wait_irq_interruptible_timeout() - Wait for IRQ with timeout.
+ *
+ * @amd_w1_local:	Pointer to device structure
+ * @IRQ:		IRQ channel to wait on
+ *
+ * Return:		%0 - OK, %-EINTR - Interrupted, %-EBUSY - Timed out
+ */
+static inline int amd_w1_wait_irq_interruptible_timeout(struct amd_w1_local *amd_w1_local, u32 IRQ)
+{
+	int ret;
+
+	/* Enable the IRQ requested and wait for flag to indicate it's been triggered */
+	amd_w1_write_register(amd_w1_local, AXIW1_IRQE_REG, IRQ);
+	ret = wait_event_interruptible_timeout(amd_w1_local->wait_queue,
+					       atomic_read(&amd_w1_local->flag) != 0,
+					       AXIW1_TIMEOUT);
+	if (ret < 0) {
+		dev_err(amd_w1_local->dev, "Wait IRQ Interrupted\n");
+		return -EINTR;
+	}
+
+	if (!ret) {
+		dev_err(amd_w1_local->dev, "Wait IRQ Timeout\n");
+		return -EBUSY;
+	}
+
+	/* Clear flag */
+	atomic_set(&amd_w1_local->flag, 0);
+	return 0;
+}
+
+/**
+ * amd_w1_touch_bit() - Performs the touch-bit function, which writes a 0 or 1 and reads the level.
+ *
+ * @data:	Pointer to device structure
+ * @bit:	The level to write
+ *
+ * Return:	The level read
+ */
+static u8 amd_w1_touch_bit(void *data, u8 bit)
+{
+	struct amd_w1_local *amd_w1_local = data;
+	u8 val = 0;
+	int rc;
+
+	/* Wait for READY signal to be 1 to ensure 1-wire IP is ready */
+	while ((amd_w1_read_register(amd_w1_local, AXIW1_STAT_REG) & AXIW1_READY) == 0) {
+		rc = amd_w1_wait_irq_interruptible_timeout(amd_w1_local, AXIW1_READY_IRQ_EN);
+		if (rc < 0)
+			return 1; /* Callee doesn't test for error. Return inactive bus state */
+	}
+
+	if (bit)
+		/* Read. Write read Bit command in register 0 */
+		amd_w1_write_register(amd_w1_local, AXIW1_INST_REG, AXIW1_READBIT);
+	else
+		/* Write. Write tx Bit command in instruction register with bit to transmit */
+		amd_w1_write_register(amd_w1_local, AXIW1_INST_REG,
+				      (AXIW1_WRITEBIT + (bit & 0x01)));
+
+	/* Write Go signal and clear control reset signal in control register */
+	amd_w1_write_register(amd_w1_local, AXIW1_CTRL_REG, AXIW1_GO);
+
+	/* Wait for done signal to be 1 */
+	while ((amd_w1_read_register(amd_w1_local, AXIW1_STAT_REG) & AXIW1_DONE) != 1) {
+		rc = amd_w1_wait_irq_interruptible_timeout(amd_w1_local, AXIW1_DONE_IRQ_EN);
+		if (rc < 0)
+			return 1; /* Callee doesn't test for error. Return inactive bus state */
+	}
+
+	/* If read, Retrieve data from register */
+	if (bit)
+		val = (u8)(amd_w1_read_register(amd_w1_local, AXIW1_DATA_REG) & AXIW1_READDATA);
+
+	/* Clear Go signal in register 1 */
+	amd_w1_write_register(amd_w1_local, AXIW1_CTRL_REG, AXI_CLEAR);
+
+	return val;
+}
+
+/**
+ * amd_w1_read_byte - Performs the read byte function.
+ *
+ * @data:	Pointer to device structure
+ * Return:	The value read
+ */
+static u8 amd_w1_read_byte(void *data)
+{
+	struct amd_w1_local *amd_w1_local = data;
+	u8 val = 0;
+	int rc;
+
+	/* Wait for READY signal to be 1 to ensure 1-wire IP is ready */
+	while ((amd_w1_read_register(amd_w1_local, AXIW1_STAT_REG) & AXIW1_READY) == 0) {
+		rc = amd_w1_wait_irq_interruptible_timeout(amd_w1_local, AXIW1_READY_IRQ_EN);
+		if (rc < 0)
+			return 0xFF; /* Return inactive bus state */
+	}
+
+	/* Write read Byte command in instruction register*/
+	amd_w1_write_register(amd_w1_local, AXIW1_INST_REG, AXIW1_READBYTE);
+	/* Write Go signal and clear control reset signal in control register */
+	amd_w1_write_register(amd_w1_local, AXIW1_CTRL_REG, AXIW1_GO);
+
+	/* Wait for done signal to be 1 */
+	while ((amd_w1_read_register(amd_w1_local, AXIW1_STAT_REG) & AXIW1_DONE) != 1) {
+		rc = amd_w1_wait_irq_interruptible_timeout(amd_w1_local, AXIW1_DONE_IRQ_EN);
+		if (rc < 0)
+			return 0xFF; /* Return inactive bus state */
+	}
+
+	/* Retrieve LSB bit in data register to get RX byte */
+	val = (u8)(amd_w1_read_register(amd_w1_local, AXIW1_DATA_REG) & 0x000000FF);
+
+	/* Clear Go signal in control register */
+	amd_w1_write_register(amd_w1_local, AXIW1_CTRL_REG, AXI_CLEAR);
+
+	return val;
+}
+
+/**
+ * amd_w1_write_byte - Performs the write byte function.
+ *
+ * @data:	The ds2482 channel pointer
+ * @val:	The value to write
+ */
+static void amd_w1_write_byte(void *data, u8 val)
+{
+	struct amd_w1_local *amd_w1_local = data;
+	int rc;
+
+	/* Wait for READY signal to be 1 to ensure 1-wire IP is ready */
+	while ((amd_w1_read_register(amd_w1_local, AXIW1_STAT_REG) & AXIW1_READY) == 0) {
+		rc = amd_w1_wait_irq_interruptible_timeout(amd_w1_local, AXIW1_READY_IRQ_EN);
+		if (rc < 0)
+			return;
+	}
+
+	/* Write tx Byte command in instruction register with bit to transmit */
+	amd_w1_write_register(amd_w1_local, AXIW1_INST_REG, (AXIW1_WRITEBYTE + val));
+	/* Write Go signal and clear control reset signal in register 1 */
+	amd_w1_write_register(amd_w1_local, AXIW1_CTRL_REG, AXIW1_GO);
+
+	/* Wait for done signal to be 1 */
+	while ((amd_w1_read_register(amd_w1_local, AXIW1_STAT_REG) & AXIW1_DONE) != 1) {
+		rc = amd_w1_wait_irq_interruptible_timeout(amd_w1_local, AXIW1_DONE_IRQ_EN);
+		if (rc < 0)
+			return;
+	}
+
+	/* Clear Go signal in control register */
+	amd_w1_write_register(amd_w1_local, AXIW1_CTRL_REG, AXI_CLEAR);
+}
+
+/**
+ * amd_w1_reset_bus() - Issues a reset bus sequence.
+ *
+ * @data:	the bus master data struct
+ * Return:	0=Device present, 1=No device present or error
+ */
+static u8 amd_w1_reset_bus(void *data)
+{
+	struct amd_w1_local *amd_w1_local = data;
+	u8 val = 0;
+	int rc;
+
+	/* Reset 1-wire Axi IP */
+	amd_w1_write_register(amd_w1_local, AXIW1_CTRL_REG, AXI_RESET);
+
+	/* Wait for READY signal to be 1 to ensure 1-wire IP is ready */
+	while ((amd_w1_read_register(amd_w1_local, AXIW1_STAT_REG) & AXIW1_READY) == 0) {
+		rc = amd_w1_wait_irq_interruptible_timeout(amd_w1_local, AXIW1_READY_IRQ_EN);
+		if (rc < 0)
+			return 1; /* Something went wrong with the hardware */
+	}
+	/* Write Initialization command in instruction register */
+	amd_w1_write_register(amd_w1_local, AXIW1_INST_REG, AXIW1_INITPRES);
+	/* Write Go signal and clear control reset signal in register 1 */
+	amd_w1_write_register(amd_w1_local, AXIW1_CTRL_REG, AXIW1_GO);
+
+	/* Wait for done signal to be 1 */
+	while ((amd_w1_read_register(amd_w1_local, AXIW1_STAT_REG) & AXIW1_DONE) != 1) {
+		rc = amd_w1_wait_irq_interruptible_timeout(amd_w1_local, AXIW1_DONE_IRQ_EN);
+		if (rc < 0)
+			return 1; /* Something went wrong with the hardware */
+	}
+	/* Retrieve MSB bit in status register to get failure bit */
+	if ((amd_w1_read_register(amd_w1_local, AXIW1_STAT_REG) & AXIW1_PRESENCE) != 0)
+		val = 1;
+
+	/* Clear Go signal in control register */
+	amd_w1_write_register(amd_w1_local, AXIW1_CTRL_REG, AXI_CLEAR);
+
+	return val;
+}
+
+/* 1-wire master structure */
+static struct w1_bus_master amd_w1_master = {
+	.touch_bit	= amd_w1_touch_bit,
+	.read_byte	= amd_w1_read_byte,
+	.write_byte	= amd_w1_write_byte,
+	.reset_bus	= amd_w1_reset_bus,
+};
+
+/* Reset the 1-wire AXI IP. Put the IP in reset state and clear registers */
+static void amd_w1_reset(struct amd_w1_local *amd_w1_local)
+{
+	amd_w1_write_register(amd_w1_local, AXIW1_CTRL_REG, AXI_RESET);
+	amd_w1_write_register(amd_w1_local, AXIW1_INST_REG, AXI_CLEAR);
+	amd_w1_write_register(amd_w1_local, AXIW1_IRQE_REG, AXI_CLEAR);
+	amd_w1_write_register(amd_w1_local, AXIW1_STAT_REG, AXI_CLEAR);
+	amd_w1_write_register(amd_w1_local, AXIW1_DATA_REG, AXI_CLEAR);
+}
+
+static irqreturn_t amd_w1_irq(int irq, void *lp)
+{
+	struct amd_w1_local *amd_w1_local = lp;
+
+	/* Clear enables in IRQ enable register */
+	amd_w1_write_register(amd_w1_local, AXIW1_IRQE_REG, AXI_CLEAR);
+
+	/* Wake up the waiting queue */
+	atomic_set(&amd_w1_local->flag, 1);
+	wake_up_interruptible(&amd_w1_local->wait_queue);
+
+	return IRQ_HANDLED;
+}
+
+static int amd_w1_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct amd_w1_local *lp;
+	u32 ver_major, ver_minor;
+	int val, rc = 0;
+
+	/* Get iospace for the device */
+	lp = devm_kzalloc(dev, sizeof(*lp), GFP_KERNEL);
+	if (!lp)
+		return -ENOMEM;
+
+	lp->dev = dev;
+	lp->base_addr = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(lp->base_addr))
+		return PTR_ERR(lp->base_addr);
+
+	/* Get IRQ for the device */
+	lp->irq = platform_get_irq(pdev, 0);
+	if (lp->irq <= 0)
+		return lp->irq;
+
+	rc = devm_request_irq(dev, lp->irq, &amd_w1_irq, IRQF_TRIGGER_HIGH, DRIVER_NAME, lp);
+	if (rc) {
+		dev_err(dev, "Could not allocate interrupt %d.\n", lp->irq);
+		return rc;
+	}
+
+	/* Initialize wait queue and flag */
+	init_waitqueue_head(&lp->wait_queue);
+
+	lp->clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(lp->clk))
+		return PTR_ERR(lp->clk);
+
+	/* Verify IP presence in HW */
+	if (amd_w1_read_register(lp, AXIW1_IPID_REG) != AXIW1_IPID) {
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
+	val = amd_w1_read_register(lp, AXIW1_IPVER_REG);
+	ver_major = FIELD_GET(AXIW1_MAJORVER_MASK, val);
+	ver_minor = FIELD_GET(AXIW1_MINORVER_MASK, val);
+
+	if (ver_major != 1) {
+		dev_err(dev, "AMD AXI W1 Master version %u.%u is not supported by this driver",
+			ver_major, ver_minor);
+		return -ENODEV;
+	}
+
+	amd_w1_master.data = (void *)lp;
+	amd_w1_reset(lp);
+
+	platform_set_drvdata(pdev, lp);
+	rc = w1_add_master_device(&amd_w1_master);
+	if (rc) {
+		dev_err(dev, "Could not add master device\n");
+		amd_w1_reset(lp);
+		return rc;
+	}
+
+	return 0;
+}
+
+static void amd_w1_remove(struct platform_device *pdev)
+{
+	struct amd_w1_local *lp = platform_get_drvdata(pdev);
+
+	w1_remove_master_device(&amd_w1_master);
+	clk_disable_unprepare(lp->clk);
+}
+
+static const struct of_device_id amd_w1_of_match[] = {
+	{ .compatible = "amd,axi-1wire-master" },
+	{ /* end of list */ },
+};
+MODULE_DEVICE_TABLE(of, amd_w1_of_match);
+
+static struct platform_driver amd_w1_driver = {
+	.probe = amd_w1_probe,
+	.remove_new = amd_w1_remove,
+	.driver = {
+		.name = DRIVER_NAME,
+		.of_match_table = amd_w1_of_match,
+	},
+};
+module_platform_driver(amd_w1_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Kris Chaplin <kris.chaplin@amd.com>");
+MODULE_DESCRIPTION("Driver for AMD AXI 1 Wire IP core");
-- 
2.42.GIT

