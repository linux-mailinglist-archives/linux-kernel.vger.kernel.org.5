Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1760E7CFC71
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346084AbjJSO0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346065AbjJSO0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:26:15 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9C4134;
        Thu, 19 Oct 2023 07:26:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=drtHYkX53+hNuXtXNnZ31G3n6WO3w+0+fXwKIBR6PChkjXDD4MqoEt/rcXvWbllGjoqgxnwgf3Hq5zN1+ulL8XVB/9fgFy1/u2S0axnRpYzDNYu2Vy91vqdTxIoA2mRKbVeSJfB5+aJW/v6EgWY6zsn7xUMDwILdA3fM1khCQ336gdZC0uRtv8w3btdgHf9wqyOSHrcV7UkNjAvpCAGwBm/UIqmngtVzJ92TjrooousEhWsOlS/fcYmJqN9hbDTFAUuPC5XYcgBytyrRumNSFRlRWlwE91XVjqUBiaT9hBv7DzoCUuJSBy4wrYNqNSQSljrFfyUvdsJsc9HfupcqVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNpm5YRfFXNs4d/Xy28ixEzGCBbphkzpxq9vNLYOblk=;
 b=X5Yoa/z58APk60c87R9vSIP1vH/iBHNMaO5VUUen6YqU4rE6TVfQ72eZCrG26dJpnjHoTEO+IXJw8p1Ct8nGdg4AkjhCr57N9MV/MdSSdQfwvKFe/6dLKxAPzRpCwvcZJXfsv/iuQR+djfEx8tTnsRiJZ9fgOt5xiSRLrxkHCDhw2yzLKnYvVhW1+R+HS+7Coq141/oGC4bkfRqmRmsFYPs5S18F8qXsr7pri+IjXDNTglevAZDAYUGCmAe5+stoHax38C1ZITcl9h6igb7NzrV8/iMpqVtLysWe4OO89/88R2WGoXDzAuml+mC1RVNVlYam90/ihj7WVQ3AiADi1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNpm5YRfFXNs4d/Xy28ixEzGCBbphkzpxq9vNLYOblk=;
 b=poegFmw2qjaJ7dw4ZtXWFwi2yuhOb7LzSoFxdLtp+Jyg1tgijl+ul+RQDYhxibR6D0+iputPgjUOwr+rO0vZCu+iSyyrJTK3InoJbR7fsU9YUTH85YY7H3xxs1eH8pOGobNnDlI8ursVRD+fRgjfXzlYy5HYTBkEtxpk5xtPAV0=
Received: from SA1P222CA0020.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::21)
 by SA0PR12MB4558.namprd12.prod.outlook.com (2603:10b6:806:72::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 14:26:09 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:22c:cafe::b3) by SA1P222CA0020.outlook.office365.com
 (2603:10b6:806:22c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Thu, 19 Oct 2023 14:26:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Thu, 19 Oct 2023 14:26:09 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 09:26:08 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 09:26:07 -0500
Received: from xsjapps55.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 19 Oct 2023 09:26:06 -0500
From:   Kris Chaplin <kris.chaplin@amd.com>
To:     <kris.chaplin@amd.com>, <thomas.delev@amd.com>,
        <michal.simek@amd.com>, <krzysztof.kozlowski@linaro.org>,
        <robh+dt@kernel.org>, <conor+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>
Subject: [PATCH v2 2/2] w1: Add AXI 1-wire host driver for AMD programmable logic IP core
Date:   Thu, 19 Oct 2023 07:24:18 -0700
Message-ID: <20231019142526.10592-3-kris.chaplin@amd.com>
X-Mailer: git-send-email 2.42.GIT
In-Reply-To: <20231019142526.10592-1-kris.chaplin@amd.com>
References: <20231013093109.37165-1-kris.chaplin@amd.com>
 <20231019142526.10592-1-kris.chaplin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|SA0PR12MB4558:EE_
X-MS-Office365-Filtering-Correlation-Id: 560d473a-428d-4727-666c-08dbd0af56df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /q+jHNEz+cEjTdWzpDPrM3aCL9tWhtLueX6MJitxP5FjdDd9D96nlqYnqCVLmdYPxuGmsK7+UKcpBZBJAlog6BoGd5z4n1Pj6QLkizkX3Fr+4Xh2BQKligELatGBVB3iiuD+Lw2NW1GwctkXEMJ0/0xPZzNqXzB3zrWuPW9Fv42WG7Ge8bJAG1aBD60Ic5eO5xsEGcI2DsRnWk7SYBQnNm4EkmF6TyUEP6DiSECDcE4EymmrizdL4klwuEXjdybznEdMx88hcY1esgBiUBKHMUBXXS6q4iKV+jOmnAJFq8KS1PFLMRbHJLRwZjUz3d4Raz3bD4Kne+YmL6CN8KygNfLOQ6Oey7o1nmwf3L1y7IvUvsCGsaSdehDeMmue5nTrOQ+Oi+NbgwUmdQeJkCNIZv/6ZdOE9+Ze2DeRoBjiGVYarXv++Euz6nqcVAmZ3Na/oAM44L+oudNT1D0UQN65ywDEB08RY46ohoHbS7H5fl+kMdTiT80ItWi3FMFJeQgot23Aao9pAZfc5dhrSJH7ZZC9G1KYuuibdFnxsuB0EqIhxu0Kw65G1GonNFeUoJ4CgIT2ei/Tcbt8YfMO5r4Pg+gpJ53vCOu922StfGqkGduslfK9lq19F8zCncN8yFrmoVkvzD7QQT0yoT5evaLTjsrOD7QCVMJjbWKf18b5EtC1l+N55cWDmAaNK+kOuaiV4akopYfmBCREzEJQcga2Dn3HmxS/TgxgpwzrEk29jk4Asn4VzzMvLWuxAfjMyoJYWv6dHevmKmB2Z5ADn+Uoww==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(346002)(136003)(230922051799003)(451199024)(186009)(64100799003)(82310400011)(1800799009)(36840700001)(40470700004)(46966006)(4326008)(83380400001)(40480700001)(478600001)(8936002)(8676002)(2616005)(86362001)(426003)(30864003)(81166007)(2906002)(47076005)(6666004)(44832011)(41300700001)(36756003)(26005)(1076003)(356005)(36860700001)(336012)(40460700003)(82740400003)(5660300002)(110136005)(70206006)(70586007)(316002)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 14:26:09.7767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 560d473a-428d-4727-666c-08dbd0af56df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4558
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 3dacb7ed6e3b..c31b17df3be9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -896,6 +896,7 @@ R:	Thomas Delev <thomas.delev@amd.com>
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

