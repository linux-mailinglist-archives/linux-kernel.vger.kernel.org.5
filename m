Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519E679F41D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 23:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbjIMVwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 17:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbjIMVwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 17:52:07 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C8C173A;
        Wed, 13 Sep 2023 14:52:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUEccPtopLT2MT1gvcA3jAX5fiBRww08wHsFZOWZb6HJ8lq9eIp+whOWkJvFandpfRKp40BtjkS4i4AxV+aVtlZDcZFjZxAedfXc2QAgGKl/gmfa2LwZoE0ayAtJ0ZYKcQBjCAmZ6hHWrmL2FjVlP1kzKScwZMU/rrQOLG5mcIprDh8Fz/SfZCA0gcz+uFK3GKjHzzcceWrm0zp+T0KAzDUicO+l19BwkBKB9r30rKs7IxHxtRXNo7lYC7t44PLi01PxQlrrAfZe6GxzcjwJwxf2kKsv2m0JKz0RoGexEIGi6x3bOMDLnEDzjWtVJY5YfXx46KOWTTyuHa5XpbrcsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QF8IoQ5zWt4PyCihCm7jImF7RuodYE8K1KFxOfMw/ug=;
 b=dXEC1i1kK9Bg8abe3Aa7FVIeM6qnzGMWN6GB22Gl3odv1KzkJ9Z224l0GwZqrXBmP+IDAUcBYXva7Ub6fau/Hs/eEKH5NlUGYfYt0jYkG5Luw8KoUmjCM+g0Uohk1xqXkzgGMvDGfduodjqvK3G1iaOo6Ip1U35dsVBilZ1YYIl6LLF2o3hsFWdXA1Ta+XtFNOZ2lM/55x76qi+k+WrPhmB+GF0V709Vi4MPG6ji+A5/EgxJ8cY31Az8Q3dNr4hO2YkISs6KM5GTKH9Ktp9TuJglemGdvAhlko8jR5bx0D2KFsCypo9lQFTnY+oOj90nRDRvf/OwdC8d8GjbaxGQYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QF8IoQ5zWt4PyCihCm7jImF7RuodYE8K1KFxOfMw/ug=;
 b=bxFqYCtogvHaXDcHfYYWN7tKdNNkGBVI/G4vDG6J2RPSfHWVUTyYV296AglDMJfRutQFXf1Uo+QJ/HIb/SrEfm1xfg6dQ2iHp2DP+Oo/pnozblFCNEZbDt0JDYp+Uh7FY/v3ssrX0qI1A8vr9kg/XJ1W9iXVVXdM+fV38+oMqjc=
Received: from DS7PR06CA0003.namprd06.prod.outlook.com (2603:10b6:8:2a::27) by
 BY1PR12MB8448.namprd12.prod.outlook.com (2603:10b6:a03:534::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Wed, 13 Sep
 2023 21:51:59 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:8:2a:cafe::56) by DS7PR06CA0003.outlook.office365.com
 (2603:10b6:8:2a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Wed, 13 Sep 2023 21:51:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 13 Sep 2023 21:51:59 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 13 Sep 2023 16:51:55 -0500
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
Subject: [PATCH v16 6/6] soc: amd: Add support for AMD Pensando SoC Controller
Date:   Wed, 13 Sep 2023 14:49:44 -0700
Message-ID: <20230913214944.59804-7-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230913214944.59804-1-blarson@amd.com>
References: <20230913214944.59804-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|BY1PR12MB8448:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fe64117-396b-451e-4f95-08dbb4a3a7ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +uozfXiCRzDMkzYcYsHzNHCNNJukc+J60v+Khn1e7HIIBybalMCS9waC10/BXz7LAttvTQE9J6UD37SfLBlnLTiqdvm0E7zOp2ZZB0cfgpPEtgHADJz0KmH6+eaizj6jyWMN+VoFvjwGDHwOeeyNBZSBFIjL7vO4rrqC0oX3O5DyNfby5+TTpnmgVMz9RtsvHFGyTuXOjw9XHTGMxhoabsWByY2nepiKtd4hvA8R/csTqGcCRZh70GqPZIjnVzwgeVxGoVAueUuaU5UMByImbOZxpT11pg1a4/aHYZCU8sgfWeJCbqcVLmDOZDSsfZPjaf8Uoy9jhQ+lMl1g8aPvV0KgEaasUPO28ULEGYiisNT5W8fga1b1FVKAn31ymruvpOS2ppfcZWYNjm75uMVEVw1o2VAf5Er2dIq0Yynw8MeCD7MTqTdWuxZ0/OQwoeYyVSsozDlFKSb2Ka4J/AZEnI8WViwEdZdWSAKp0lfhkAetFAKl1tpIEU/CxjNf4kooYMSVGgUdg+XdYZjWI1etmACxn5mYspcI88Ybd5Iz/5XOLGRIv9Mr2SZowttViTmVhEaI1WZkRJ3/JKBfOlR569D9lAd78QoxlplSeMxb1iF+JOomLnhpj4pZsxk7hvrR4AWGVvcq4ILQfkYnSW5aDH9iYrIAahX6CAu0ycHigEN8JPhQ381BJMQutFX9iSqFxtCkDusryNG1LYZXNaU5YR0vRSgclpp839ydjK90MKMFOyhFdhg9gpNLhJoELuyzNW0zo5SP1o7NpeRJEsgIcQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(1800799009)(82310400011)(186009)(451199024)(36840700001)(46966006)(40470700004)(5660300002)(70206006)(70586007)(41300700001)(54906003)(4326008)(8676002)(8936002)(316002)(6916009)(81166007)(36756003)(40460700003)(478600001)(7406005)(7416002)(16526019)(83380400001)(26005)(2616005)(426003)(1076003)(336012)(30864003)(2906002)(356005)(82740400003)(47076005)(40480700001)(36860700001)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 21:51:59.1939
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe64117-396b-451e-4f95-08dbb4a3a7ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8448
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
- Delete unused definitions in amd-pensando-ctrl.h 
- Makefile change to compile for ARCH_PENSANDO

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
 include/uapi/linux/amd-pensando-ctrl.h |  26 +++
 6 files changed, 357 insertions(+)
 create mode 100644 drivers/soc/amd/Kconfig
 create mode 100644 drivers/soc/amd/Makefile
 create mode 100644 drivers/soc/amd/pensando-ctrl.c
 create mode 100644 include/uapi/linux/amd-pensando-ctrl.h

diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index d21e75d69294..1a8a42141e78 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -2,6 +2,7 @@
 menu "SOC (System On Chip) specific Drivers"
 
 source "drivers/soc/actions/Kconfig"
+source "drivers/soc/amd/Kconfig"
 source "drivers/soc/amlogic/Kconfig"
 source "drivers/soc/apple/Kconfig"
 source "drivers/soc/aspeed/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 0706a27d13be..dbd651fcbecc 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -3,6 +3,7 @@
 # Makefile for the Linux Kernel SOC specific device drivers.
 #
 
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
index 000000000000..626b85e3fdb5
--- /dev/null
+++ b/include/uapi/linux/amd-pensando-ctrl.h
@@ -0,0 +1,26 @@
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

