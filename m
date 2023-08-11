Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8167796C0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 20:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236991AbjHKSGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 14:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237054AbjHKSG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 14:06:26 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79AA3A89;
        Fri, 11 Aug 2023 11:06:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErSodoj/vzxmcxob8kRXysR1MPjR4N1hELgQdcqoBxQ0bvMXszyNwdNmXlswC2CNuN6EzUKz1w6xzBm4c8w/Y7vX6VI8QoAe7kdMfq4Yye8OeWqR6zdR71QzhIK5pswR3hHXtocKOrIGeMAnUUC7+9A/c7d3G4jpjKEVCV2gJIMjBP+4hGS/H5mCXFRIWHdOQcSGgo5PQB/VH/fnHHnsZPCxnzgexm5ct0TkycLRCz7c3vdxY+C2yXK2lNLX/HmuYFzECwj8HEZyjPLSL/w4M3u9KB3D2cMWT91/V1lh8YUB8foOTb3wMuQtvLx7tD2O+Wg9RqdfW5MgIdujLWOkVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nbjsTcW0dO19YX5kTNBEdvG6hKyTAhkMDdU/C/vLZeg=;
 b=O7vAmsIxR+3exXSy9ucmttv86C/RbnQzDHJN/UgOaHaA0CYZCHjpIEoeDCO8pCCa/DJcS0k8ZwU/x5nQnJvcozAmPcM1dnAOS5rkQMS9CKAvhHCigc+FDntpZBgV1Ri+Jhc4fA6Vn6W7HkCUNcsOU99Ro1a5gXR+/SL1BNgpSyBIpJ7ZV6lJsKhXNeAUhnRhhZOyyaf1jNsWYAohjNROHiFWUsUq5U8xyjgIcKm6lDmJYXjEZt7xRnMZ2ffTjXgf/nCWu1UGSRC3ifrV78abaZKLH3x0oqZ0vCz09oiFhASAq40E1j7UZu+isKz+2g2r2vWi4j+YvuRpAzMw61aeoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbjsTcW0dO19YX5kTNBEdvG6hKyTAhkMDdU/C/vLZeg=;
 b=r5GNNWEPVK1814wGAV4WQzbx38jGzyqIMKoihqb9ZApFbjNLnMaL0+QNceA6kWf4BcOlpDvTv6lMPhQhj0ID6waz3tIOTD9qBBwwBpkiUI9nDR+Pe10BnLvehvwCPvnvOY6PJoYKnNhYxSoszXNkGKQBPQ2vGsCIwTU54yXEzw8=
Received: from SN7PR04CA0092.namprd04.prod.outlook.com (2603:10b6:806:122::7)
 by DS0PR12MB8787.namprd12.prod.outlook.com (2603:10b6:8:14e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 18:06:13 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:122:cafe::4) by SN7PR04CA0092.outlook.office365.com
 (2603:10b6:806:122::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.31 via Frontend
 Transport; Fri, 11 Aug 2023 18:06:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 11 Aug 2023 18:06:13 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 11 Aug 2023 13:05:53 -0500
From:   Brad Larson <blarson@amd.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <adrian.hunter@intel.com>,
        <alcooperx@gmail.com>, <andy.shevchenko@gmail.com>,
        <arnd@arndb.de>, <blarson@amd.com>, <brendan.higgins@linux.dev>,
        <briannorris@chromium.org>, <catalin.marinas@arm.com>,
        <conor+dt@kernel.org>, <davidgow@google.com>, <gsomlo@gmail.com>,
        <gerg@linux-m68k.org>, <hal.feng@starfivetech.com>,
        <hasegawa-hitomi@fujitsu.com>, <j.neuschaefer@gmx.net>,
        <joel@jms.id.au>, <kernel@esmil.dk>, <krzk@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee@kernel.org>,
        <lee.jones@linaro.org>, <broonie@kernel.org>,
        <p.zabel@pengutronix.de>, <rdunlap@infradead.org>,
        <robh+dt@kernel.org>, <samuel@sholland.org>,
        <fancer.lancer@gmail.com>, <skhan@linuxfoundation.org>,
        <suravee.suthikulpanit@amd.com>, <thomas.lendacky@amd.com>,
        <tonyhuang.sunplus@gmail.com>, <ulf.hansson@linaro.org>,
        <vaishnav.a@ti.com>, <walker.chen@starfivetech.com>,
        <will@kernel.org>, <zhuyinbo@loongson.cn>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v15 6/6] soc: amd: Add support for AMD Pensando SoC Controller
Date:   Fri, 11 Aug 2023 11:05:19 -0700
Message-ID: <20230811180519.29644-7-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230811180519.29644-1-blarson@amd.com>
References: <20230811180519.29644-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|DS0PR12MB8787:EE_
X-MS-Office365-Filtering-Correlation-Id: dc1d6a56-edeb-4b9b-afbb-08db9a95a621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9rPidfPL2qfKCKAxMIwquYkjvIBT1JNC0L3C+CJ++DA0AEnAFJo6aESezl+EZAmWPLJkJKldOFazdGf54xRFho5Oo7dWhCkLA2Lw+BdzZgmcFZ3G64d+t2ZimAXq2XRdcZewWg+loN90wJSkzKDQaLdkpGkH6JgpoCCcf95I+BQet09yScaGokMLsX1IBRU1VutBwbAHAaqPcPZaSvYFFz3oujUdi3fEFQ70jWGZpOoJXQfLbdK6nFGih1iXLFPgzlNmzpGOcTEWjVfSZO59DwiRfCkP0XbEyUobm69DRbKpcCy5vr45VZ6FxqRIxb86gvfQjUAhn3UCcmju7hJfu90c05yAaPPUkt/CzW18vEGASr0uCi5+NOrdHKWHMubixoDswfopFPEVkQIMiP+eWSpXylO/clCFYdH2atlNU4NjXUcOm7xuUnEZOCSdRSD+V8YQj18aeRuyc6g3EZI+TGOCGh/o3gkGBG09l+mpdt+XIRfI/GxC+UMFwFKgO/WstdAUDFjdbaODhivAHRTpDKg6GV6BMHDkBqUT+MgU51ZQDJRfRmmFRCUhIUstQGZTz2uvwguzIPEoOpF/d17tV8AUHa6y7Izlp3BTC5EOUYvPtEgVsfBDDigBwli7ID96yQ9h3F15xt2U3ZIYoHdrGZnHYWj/kunSrXtsa35+g+BjrfAWytb2YWquDymy4c420hlF9YaV+OZhzxzz4yCovsl4OV07Fo0jLWtQg5kt16/lR/akg268cbIyNuIHFsZpC1zwC4jBtBcopf5N1wyXOw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(186006)(1800799006)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(2616005)(316002)(81166007)(40480700001)(356005)(426003)(478600001)(82740400003)(40460700003)(6666004)(336012)(16526019)(1076003)(26005)(5660300002)(36756003)(8676002)(8936002)(41300700001)(7406005)(7416002)(47076005)(4326008)(2906002)(54906003)(36860700001)(6916009)(83380400001)(70206006)(30864003)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 18:06:13.0462
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc1d6a56-edeb-4b9b-afbb-08db9a95a621
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8787
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Pensando SoC controller is a SPI connected companion device
that is present in all Pensando SoC board designs.  The essential
board management registers are accessed on chip select 0 with
board mgmt IO support accessed using additional chip selects.

Signed-off-by: Brad Larson <blarson@amd.com>
---

v15 changes:
- Drop custom ioctl and use existing miscdevice interface.
- Makefile change to only compile for ARCH_PENSANDO

v14 changes:
- Save 8 bytes of code size by swapping spi_device and reset_controller_dev
  in penctrl_device
- Code simplification and clarity from review inputs
- Set penctrl_spi_driver.driver.name to match compatible pensando-elba-ctrl
- Remove unused include in amd-pensando-ctrl.h
- Rebase to linux-next 6.4.0-rc1 class_create() API change

v13 changes:
- Update include list in pensando-ctrl.c
- Change variable spi_dev to spi throughout
- Removed unneeded variable initialization, simplification of
  error checks, remove extra castings, and use dev_err_probe()
- Sort the includes in amd-pensando-ctrl.h
- Updates to cleanup if there is an error in penctrl_spi_probe()

v12 changes:
- Fix gcc-12.1.0 warning

v11 changes:
- Fix the compatible to be specific 'amd,pensando-elba-ctrl'

v10 changes:
- Different driver implementation specific to this Pensando controller device.
- Moved to soc/amd directory under new name based on guidance.  This driver is
  of no use to any design other than all Pensando SoC based cards.
- Removed use of builtin_driver, can be built as a module.

v9 changes:
- Previously patch 14/17
- After the change to the device tree node and squashing
  reset-cells into the parent simplified this to not use
  any MFD API and move it to drivers/spi/pensando-sr.c.
- Change the naming to remove elba since this driver is common
  for all Pensando SoC designs .
- Default yes SPI_PENSANDO_SR for ARCH_PENSANDO

---
 drivers/soc/Kconfig                    |   1 +
 drivers/soc/Makefile                   |   1 +
 drivers/soc/amd/Kconfig                |  16 ++
 drivers/soc/amd/Makefile               |   2 +
 drivers/soc/amd/pensando-ctrl.c        | 311 +++++++++++++++++++++++++
 include/uapi/linux/amd-pensando-ctrl.h |  27 +++
 6 files changed, 358 insertions(+)
 create mode 100644 drivers/soc/amd/Kconfig
 create mode 100644 drivers/soc/amd/Makefile
 create mode 100644 drivers/soc/amd/pensando-ctrl.c
 create mode 100644 include/uapi/linux/amd-pensando-ctrl.h

diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index 4e176280113a..4e9453fdcb2f 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -3,6 +3,7 @@ menu "SOC (System On Chip) specific Drivers"
 
 source "drivers/soc/actions/Kconfig"
 source "drivers/soc/amlogic/Kconfig"
+source "drivers/soc/amd/Kconfig"
 source "drivers/soc/apple/Kconfig"
 source "drivers/soc/aspeed/Kconfig"
 source "drivers/soc/atmel/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 3b0f9fb3b5c8..1b2fc9caff8b 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -4,6 +4,7 @@
 #
 
 obj-$(CONFIG_ARCH_ACTIONS)	+= actions/
+obj-$(CONFIG_ARCH_PENSANDO)	+= amd/
 obj-y				+= apple/
 obj-y				+= aspeed/
 obj-$(CONFIG_ARCH_AT91)		+= atmel/
diff --git a/drivers/soc/amd/Kconfig b/drivers/soc/amd/Kconfig
new file mode 100644
index 000000000000..011d5339d14e
--- /dev/null
+++ b/drivers/soc/amd/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-only
+menu "AMD Pensando SoC drivers"
+
+config AMD_PENSANDO_CTRL
+	tristate "AMD Pensando SoC Controller"
+	depends on SPI_MASTER=y
+	depends on (ARCH_PENSANDO && OF) || COMPILE_TEST
+	default ARCH_PENSANDO
+	select REGMAP_SPI
+	select MFD_SYSCON
+	help
+	  Enables AMD Pensando SoC controller device support.  This is a SPI
+	  attached companion device in all Pensando SoC board designs which
+	  provides essential board control/status registers and management IO
+	  support.
+endmenu
diff --git a/drivers/soc/amd/Makefile b/drivers/soc/amd/Makefile
new file mode 100644
index 000000000000..a2de0424f68d
--- /dev/null
+++ b/drivers/soc/amd/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_AMD_PENSANDO_CTRL)	+= pensando-ctrl.o
diff --git a/drivers/soc/amd/pensando-ctrl.c b/drivers/soc/amd/pensando-ctrl.c
new file mode 100644
index 000000000000..0b5a3a54d624
--- /dev/null
+++ b/drivers/soc/amd/pensando-ctrl.c
@@ -0,0 +1,311 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * AMD Pensando SoC Controller
+ *
+ * Userspace interface and reset driver support for SPI connected Pensando SoC
+ * controller device.  This device is present in all Pensando SoC designs and
+ * contains board control/status registers and management IO support.
+ *
+ * Copyright 2023 Advanced Micro Devices, Inc.
+ */
+
+#include <linux/cdev.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/miscdevice.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/reset-controller.h>
+#include <linux/spi/spi.h>
+#include <linux/uaccess.h>
+
+#include <linux/amd-pensando-ctrl.h>
+
+struct penctrl_device {
+	struct reset_controller_dev rcdev;
+	struct spi_device *spi;
+};
+
+static struct penctrl_device *penctrl;
+static DEFINE_MUTEX(spi_lock);
+
+static long
+penctrl_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	struct penctrl_device *penctrl;
+	u8 tx_buf[PENCTRL_MAX_MSG_LEN];
+	u8 rx_buf[PENCTRL_MAX_MSG_LEN];
+	struct spi_transfer t[2] = {};
+	struct penctrl_spi_xfer *msg;
+	struct spi_device *spi;
+	unsigned int num_msgs;
+	struct spi_message m;
+	u32 size;
+	int ret;
+
+	/* Get a reference to the SPI device */
+	penctrl = filp->private_data;
+	if (!penctrl)
+		return -ESHUTDOWN;
+
+	spi = spi_dev_get(penctrl->spi);
+	if (!spi)
+		return -ESHUTDOWN;
+
+	/* Verify and prepare SPI message */
+	size = _IOC_SIZE(cmd);
+	num_msgs = size / sizeof(struct penctrl_spi_xfer);
+	if (num_msgs > 2 || size == 0 || size % sizeof(struct penctrl_spi_xfer)) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+	msg = memdup_user((struct penctrl_spi_xfer *)arg, size);
+	if (IS_ERR(msg)) {
+		ret = PTR_ERR(msg);
+		goto out_unlock;
+	}
+	if (msg->len > PENCTRL_MAX_MSG_LEN) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	t[0].tx_buf = tx_buf;
+	t[0].len = msg->len;
+	if (copy_from_user(tx_buf, (void __user *)msg->tx_buf, msg->len)) {
+		ret = -EFAULT;
+		goto out_unlock;
+	}
+	if (num_msgs > 1) {
+		msg++;
+		if (msg->len > PENCTRL_MAX_MSG_LEN) {
+			ret = -EINVAL;
+			goto out_unlock;
+		}
+		t[1].rx_buf = rx_buf;
+		t[1].len = msg->len;
+	}
+	spi_message_init_with_transfers(&m, t, num_msgs);
+
+	/* Perform the transfer */
+	mutex_lock(&spi_lock);
+	ret = spi_sync(spi, &m);
+	mutex_unlock(&spi_lock);
+
+	if (ret || (num_msgs == 1))
+		goto out_unlock;
+
+	if (copy_to_user((void __user *)msg->rx_buf, rx_buf, msg->len))
+		ret = -EFAULT;
+
+out_unlock:
+	spi_dev_put(spi);
+	return ret;
+}
+
+static int penctrl_open(struct inode *inode, struct file *filp)
+{
+	struct spi_device *spi;
+	u8 current_cs;
+
+	filp->private_data = penctrl;
+	current_cs = iminor(inode);
+	spi = penctrl->spi;
+	spi->chip_select = current_cs;
+	spi_set_csgpiod(spi, 0, spi->controller->cs_gpiods[current_cs]);
+	spi_setup(spi);
+	return stream_open(inode, filp);
+}
+
+static int penctrl_release(struct inode *inode, struct file *filp)
+{
+	filp->private_data = NULL;
+	return 0;
+}
+
+static const struct file_operations penctrl_fops = {
+	.owner		= THIS_MODULE,
+	.unlocked_ioctl = penctrl_ioctl,
+	.open		= penctrl_open,
+	.release	= penctrl_release,
+	.llseek		= no_llseek,
+};
+
+static int penctrl_regs_read(struct penctrl_device *penctrl, u32 reg, u32 *val)
+{
+	struct spi_device *spi = penctrl->spi;
+	struct spi_transfer t[2] = {};
+	struct spi_message m;
+	u8 txbuf[3];
+	u8 rxbuf[1];
+	int ret;
+
+	txbuf[0] = PENCTRL_SPI_CMD_REGRD;
+	txbuf[1] = reg;
+	txbuf[2] = 0;
+	t[0].tx_buf = txbuf;
+	t[0].len = sizeof(txbuf);
+
+	rxbuf[0] = 0;
+	t[1].rx_buf = rxbuf;
+	t[1].len = sizeof(rxbuf);
+
+	spi_message_init_with_transfers(&m, t, ARRAY_SIZE(t));
+	ret = spi_sync(spi, &m);
+	if (ret)
+		return ret;
+
+	*val = rxbuf[0];
+	return 0;
+}
+
+static int penctrl_regs_write(struct penctrl_device *penctrl, u32 reg, u32 val)
+{
+	struct spi_device *spi = penctrl->spi;
+	struct spi_transfer t = {};
+	struct spi_message m;
+	u8 txbuf[4];
+
+	txbuf[0] = PENCTRL_SPI_CMD_REGWR;
+	txbuf[1] = reg;
+	txbuf[2] = val;
+	txbuf[3] = 0;
+
+	t.tx_buf = txbuf;
+	t.len = sizeof(txbuf);
+	spi_message_init_with_transfers(&m, &t, 1);
+	return spi_sync(spi, &m);
+}
+
+static int penctrl_reset_assert(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	struct penctrl_device *penctrl =
+		container_of(rcdev, struct penctrl_device, rcdev);
+	struct spi_device *spi = penctrl->spi;
+	unsigned int val;
+	int ret;
+
+	mutex_lock(&spi_lock);
+	spi->chip_select = 0;
+	spi_set_csgpiod(spi, 0, spi->controller->cs_gpiods[0]);
+	spi_setup(spi);
+	ret = penctrl_regs_read(penctrl, PENCTRL_REG_CTRL0, &val);
+	if (ret) {
+		dev_err(&spi->dev, "error reading ctrl0 reg\n");
+		goto out_unlock;
+	}
+
+	val |= BIT(6);
+	ret = penctrl_regs_write(penctrl, PENCTRL_REG_CTRL0, val);
+	if (ret)
+		dev_err(&spi->dev, "error writing ctrl0 reg\n");
+
+out_unlock:
+	mutex_unlock(&spi_lock);
+	return ret;
+}
+
+static int penctrl_reset_deassert(struct reset_controller_dev *rcdev,
+				  unsigned long id)
+{
+	struct penctrl_device *penctrl =
+		container_of(rcdev, struct penctrl_device, rcdev);
+	struct spi_device *spi = penctrl->spi;
+	unsigned int val;
+	int ret;
+
+	mutex_lock(&spi_lock);
+	spi->chip_select = 0;
+	spi_set_csgpiod(spi, 0, spi->controller->cs_gpiods[0]);
+	spi_setup(spi);
+	ret = penctrl_regs_read(penctrl, PENCTRL_REG_CTRL0, &val);
+	if (ret) {
+		dev_err(&spi->dev, "error reading ctrl0 reg\n");
+		goto out_unlock;
+	}
+
+	val &= ~BIT(6);
+	ret = penctrl_regs_write(penctrl, PENCTRL_REG_CTRL0, val);
+	if (ret)
+		dev_err(&spi->dev, "error writing ctrl0 reg\n");
+
+out_unlock:
+	mutex_unlock(&spi_lock);
+	return ret;
+}
+
+static const struct reset_control_ops penctrl_reset_ops = {
+	.assert = penctrl_reset_assert,
+	.deassert = penctrl_reset_deassert,
+};
+
+static struct miscdevice penctrl_devices[] = {
+	{ .minor = 0, .name = "penctrl.0", .fops = &penctrl_fops },
+	{ .minor = 1, .name = "penctrl.1", .fops = &penctrl_fops },
+	{ .minor = 2, .name = "penctrl.2", .fops = &penctrl_fops },
+	{ .minor = 3, .name = "penctrl.3", .fops = &penctrl_fops },
+};
+
+static int penctrl_spi_probe(struct spi_device *spi)
+{
+	int i, ret;
+
+	/* Allocate driver data */
+	penctrl = kzalloc(sizeof(*penctrl), GFP_KERNEL);
+	if (!penctrl)
+		return -ENOMEM;
+
+	penctrl->spi = spi;
+	mutex_init(&spi_lock);
+
+	for (i = 0; i < ARRAY_SIZE(penctrl_devices); i++) {
+		ret = misc_register(&penctrl_devices[i]);
+		if (ret) {
+			dev_err(&spi->dev, "Failed to register device %s\n",
+				penctrl_devices[i].name);
+			goto cleanup;
+		}
+	}
+
+	/* Register reset controller */
+	penctrl->rcdev.dev = &spi->dev;
+	penctrl->rcdev.ops = &penctrl_reset_ops;
+	penctrl->rcdev.owner = THIS_MODULE;
+	penctrl->rcdev.of_node = spi->dev.of_node;
+	penctrl->rcdev.nr_resets = 1;
+	device_set_node(penctrl->rcdev.dev, dev_fwnode(&spi->dev));
+
+	ret = reset_controller_register(&penctrl->rcdev);
+	if (ret)
+		return dev_err_probe(&spi->dev, ret,
+				     "failed to register reset controller\n");
+	return 0;
+
+cleanup:
+	for (i = 0; i < ARRAY_SIZE(penctrl_devices); i++) {
+		if (penctrl_devices[i].this_device)
+			misc_deregister(&penctrl_devices[i]);
+	}
+	return ret;
+}
+
+static const struct of_device_id penctrl_dt_match[] = {
+	{ .compatible = "amd,pensando-elba-ctrl" },
+	{ /* sentinel */ }
+};
+
+static struct spi_driver penctrl_spi_driver = {
+	.probe = penctrl_spi_probe,
+	.driver = {
+		.name = "pensando-elba-ctrl",
+		.of_match_table = penctrl_dt_match,
+	},
+};
+module_spi_driver(penctrl_spi_driver);
+
+MODULE_AUTHOR("Brad Larson <blarson@amd.com>");
+MODULE_DESCRIPTION("AMD Pensando SoC Controller via SPI");
+MODULE_LICENSE("GPL");
diff --git a/include/uapi/linux/amd-pensando-ctrl.h b/include/uapi/linux/amd-pensando-ctrl.h
new file mode 100644
index 000000000000..46958271c5dd
--- /dev/null
+++ b/include/uapi/linux/amd-pensando-ctrl.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Userspace interface for /dev/penctrl
+ *
+ * This file can be used by applications that need to communicate
+ * with the AMD Pensando SoC controller device via the ioctl interface.
+ */
+#ifndef _UAPI_LINUX_AMD_PENSANDO_CTRL_H
+#define _UAPI_LINUX_AMD_PENSANDO_CTRL_H
+
+#include <linux/types.h>
+
+#define PENCTRL_SPI_CMD_REGRD	0x0b
+#define PENCTRL_SPI_CMD_REGWR	0x02
+#define PENCTRL_MAX_MSG_LEN	16
+#define PENCTRL_MAX_REG		0xff
+#define PENCTRL_REG_CTRL0	0x10
+
+struct penctrl_spi_xfer {
+	__u64 tx_buf;
+	__u64 rx_buf;
+	__u32 len;
+	__u32 speed_hz;
+	__u64 compat;
+};
+
+#endif /* _UAPI_LINUX_AMD_PENSANDO_CTRL_H */
-- 
2.17.1

