Return-Path: <linux-kernel+bounces-22570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC30829FD4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 120E51C22210
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07C04E1AA;
	Wed, 10 Jan 2024 17:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KGK0TBFz"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2069.outbound.protection.outlook.com [40.107.20.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF704E1CB;
	Wed, 10 Jan 2024 17:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGutTUreXUfr1nBGohjGmOTb7k7PIH0jt+4xdDwCGg42hBYh3iob16fB33EIZ9IDGhBHNjTEcHKUaW0c4EK1XdCsJSH7OHfvaegF1Hzy0KjTO7IG0caEIzqkad+qM1C0MEy5oAGaxGYJRWrIC0EcC9doIJnFAr8eWyRzhzrBT2L31yldwRnehnBUEDFoW5nHpRjMOvK0LN8NlLyGLKaCa0s+tn3Was31KL3WwGT0Gpi0ebxQ7WwqYRTRLUVXi7reOdd9z/rRIUjDG5GQML5/nl3bLS+B3YQu0FAB6QAYU29Fbzt9XQwWwFxyTslDW/zQiyQDT5uBFXgnGmRnXoPhEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9ibCah//y7mPmevD/ktMv3Kp/63ZSS5kxU8AH8LwAM=;
 b=aAF/Tf+ltyug0LVNTL58TdCyoPBigdRqmLGF9+X6XQL40j7V2/XlxZrFCtVVC3lxz0kGn9fk20HwrA4wKIF17eoKeA7N8FmQgX2hpDKQ9zN/i3F8ZtUldrC5z0qmMinJ106N3mbODVUhcbkFBfq8+GeLqtd2F30LTzp1N7wscDiwkJKxaalanl68e6pvsCupBoe3UiMG6p5uCpZPxACPIXbMGG2HPfI43huV1okMG/uv/5wEcHdJgFVtwMWHzhctqkYiOAw1KvqdTJcyiJhx3Y6vkYz1931+siIRfI2Kcs7szu+qVjtqd8yrgaSv02Yb5WaQ6z4xnBoY5WspW0SYSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9ibCah//y7mPmevD/ktMv3Kp/63ZSS5kxU8AH8LwAM=;
 b=KGK0TBFzXAVC9xLmPJlE5qBEP4fUJcNkJe3zK1T/24MKDJR2rzRQkPRrUsnKnZXO6nMODCkSlg3f26TMjj7fapA0G71kdSzqMtCYM0Af3cThWSba09bHswmTVQMw/h90Ex2I6QtxJ0b+CfSK19cftDXRyUQuXa7lL7W1oFNVhrI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com (2603:10a6:20b:23f::5)
 by DB9PR04MB9332.eurprd04.prod.outlook.com (2603:10a6:10:36c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 17:53:00 +0000
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469]) by AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469%4]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 17:53:00 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com,
	robh@kernel.org
Cc: alexandre.belloni@bootlin.com,
	conor.culhane@silvaco.com,
	gregkh@linuxfoundation.org,
	imx@lists.linux.dev,
	jirislaby@kernel.org,
	joe@perches.com,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	miquel.raynal@bootlin.com,
	zbigniew.lukwinski@linux.intel.com,
	devicetree@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	krzysztof.kozlowski@linaro.org
Subject: [PATCH v2 5/7] i3c: target: func: add tty driver
Date: Wed, 10 Jan 2024 12:52:19 -0500
Message-Id: <20240110175221.2335480-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110175221.2335480-1-Frank.Li@nxp.com>
References: <20240110175221.2335480-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0145.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::30) To AS8PR04MB7511.eurprd04.prod.outlook.com
 (2603:10a6:20b:23f::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB7511:EE_|DB9PR04MB9332:EE_
X-MS-Office365-Filtering-Correlation-Id: 503505dd-dbb6-4b4d-7d39-08dc1204fc87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CZyHKsSt38ldpWhQy6IMz2IrEt97bMKJJKgoz4HBHrdTT83ycDKDRRNjot8bOuLbBeOEWBQbPuVFRmJFhlBlauXpyLtYelMp09Ogu6KZgHoFLma/Tc0c1Tr9MJ4NP3eLaYnG6pK+vTBtB+ExHxQ95h3XetZgHgXu1pIpyRDTFGYCIG+9u+8PUna9tQT9ID1+S1Y8MlLOxJJbXgioUysC7O+S+uFjGf+0gdSZ1f+tI2EIIEC/9/Rn9UEsbBRVFEF9gzfuXDpiBt93L0B1uQKAHY3mCq3c+Cv6oss5d8OTiD0+5v48j7z6q+iKz9bWWRM9s9kuCM7zhr2XOVLk5WVMb7r96ryGtgssPQ3bUjeXftUHrRCmEdFaZFXnqtE1goLOt0y4m5F8sGFdj4PC6TEdLU1Dhz/UDI5yFWroetyStgKNQ4mYw+/YZY7ixp3uzRIEzsrv1BPsop1JxKhdd0A7055dXEyBPHZAYtx203NbkjfHATHzvdZPTwYOXnwLN55xTVBdbkS0YvDxdvJqZYGx3pdxibXh9gaT9w6mtZjHux9gVgD5aoKVf8iDNRdAEF0Lpj+uTzgFI/apGURlaGOXtfUztSYOrAU69j5pza7nRJT1tHaqGexc5VPlz0p+zUFd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7511.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(396003)(136003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6486002)(8676002)(8936002)(86362001)(5660300002)(4326008)(66556008)(30864003)(66476007)(316002)(66946007)(7416002)(38350700005)(36756003)(2906002)(41300700001)(38100700002)(6512007)(52116002)(6666004)(83380400001)(6506007)(1076003)(26005)(2616005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cDMeX0uYfefZcU1bHt3jNhh0ML8e9+6U/P3uAkqgo9MO+qXRwW1j3Ji1EPqu?=
 =?us-ascii?Q?7/mavcVl85xCJyjl9L40oTbdP/rSjQm6tPRPNjo9coPmGPozjZShrnYXIR6M?=
 =?us-ascii?Q?EqUIerJdCL306aplNGTyCZnMx0vpuS/hO9NtrbYoa7BSTbJ/v6tDKPens5m4?=
 =?us-ascii?Q?iGCsFANTYqKxvNMncwTqBJNyIHA1AXtH+NzocaMlVuG51c2nQVMcK6zXlsCq?=
 =?us-ascii?Q?ysTf083XAbDtLKsh5denQNC2a6XDrlwrRPiS8nRycMCqeFxrf6wSackRi5f/?=
 =?us-ascii?Q?oY5SEc9gCF/NynjWP1yabkwyehm4i5UuI4E3IHra99nG+2GdVge7luv81sAF?=
 =?us-ascii?Q?nbTw15UVWNOCipHpwnNJtZgbmFhVNGvaw/3LtNw8ePfk9cJftR8GJVZQLg2e?=
 =?us-ascii?Q?KBIA0hN4PouZJ262PFMrTD6HeG72VrC1HkIqS3FUJslRv1RpKctOdDln+Ewv?=
 =?us-ascii?Q?6nf0gaJG3f066NEJmbv6wHqpwRNqd72qtKcy1b4HWqWUZl5Ytddf7G40N4PP?=
 =?us-ascii?Q?EOLfTdstAMBtW6TMo3l329V7yAQgjQ3eNnfrM3MlqZjyeQzdPKEMYfThuagQ?=
 =?us-ascii?Q?dYm5yTq6jrc6GvcwkBnXcZAUVfubQsm39uosyQVTzMFvzkvzAH0Snm1nK9NQ?=
 =?us-ascii?Q?TL0FmOk1v6VzSOWNgFFfd3HhwQPwiz62rPZWe3gGoaBOP+lTV9IUoIkl+TvJ?=
 =?us-ascii?Q?eNi5Jz722O/r3DljZ6+iMkMNZz0Gr49QDRJ5QbtNKs/mXNp4+Vg4xsoBI5e6?=
 =?us-ascii?Q?uvDVO+zszkppDJUEQWXh6xIIo6cCIXRhna9EioDSe/wjdmSXiHZSOazv0pgJ?=
 =?us-ascii?Q?cBDLv7kDTx9mA8aXjUaolblOEc9p+TSKRZasdpfdrU/bJ6dLGb6rKo8ag0m2?=
 =?us-ascii?Q?oT+jGILA0DFcFheaGwSA7pbcVj33Qa42RgP8CBXMFpc1oqEH/Np1sbco0VB5?=
 =?us-ascii?Q?fgKmZ+qiX0aRBDi5R7QTb7+tVGLX+DMBasUFxREYpB7xBisYhUUVzJ/hU83x?=
 =?us-ascii?Q?1RqoAwpxztZ0AtBIKNw+oU0MmjQdcadx422ggvw1L0ZjjSJXNEuMLJ8vhqSl?=
 =?us-ascii?Q?UZ5pTj0Eu8LuOVjzO/MycUKvdks2+5EzmtLg2Cmt/mJGNO2sHKyvWuZ7XfCj?=
 =?us-ascii?Q?+WrEbiHsJfIrIt2LXB9+D4SHFTDYB+IgrjR2/OQNEtakCPY94cClBiAh3znf?=
 =?us-ascii?Q?OiR2LyU4ZcUB3XCy64esm/oeN6rFLxgrCEJ+/aJOrhm8HhcsSREVRrmNpw9H?=
 =?us-ascii?Q?ibBCqd6Dl6GFaqcrdBC5VV4wFWG/mHQeCO98YjqIazCiRM2Jfa4jKDMpu4yN?=
 =?us-ascii?Q?lHSLzwcoNFzMeKeN5lDyDKR17CJG9+BXoGAtr1fuEIfcfcSnSj8vkkMA+nTV?=
 =?us-ascii?Q?P8/T0veCz4tjHCv4x4l5irOE3ORBKZcIkd4W/1rzJ9/WomPk/gxR+ATOZp9O?=
 =?us-ascii?Q?CWHs//vnTUDhuVnFVqH/Hth/LMz30nPu+oedJvWDT+g2StTDeis8B1R80xk2?=
 =?us-ascii?Q?0AGAKOgCmNmOBptNFZZN9zToh4X12WPCNRZjaJjUpEgOJwgJ0AR3P8v5qwpU?=
 =?us-ascii?Q?vk5VFElTwpms9bxABMs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 503505dd-dbb6-4b4d-7d39-08dc1204fc87
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7511.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 17:53:00.7510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rk9hhklvHRE6wVzpuBm29SvI3MF2+TmJHWEPwcVIlW2Ah4KhOZjEst/xOjDfDFGB1BLUqxU53LVKvUWXHAAB/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9332

Add tty over I3C target function driver.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/Kconfig       |   1 +
 drivers/i3c/Makefile      |   1 +
 drivers/i3c/func/Kconfig  |   9 +
 drivers/i3c/func/Makefile |   3 +
 drivers/i3c/func/tty.c    | 475 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 489 insertions(+)
 create mode 100644 drivers/i3c/func/Kconfig
 create mode 100644 drivers/i3c/func/Makefile
 create mode 100644 drivers/i3c/func/tty.c

diff --git a/drivers/i3c/Kconfig b/drivers/i3c/Kconfig
index 08ceef313f831..e524a8777e182 100644
--- a/drivers/i3c/Kconfig
+++ b/drivers/i3c/Kconfig
@@ -50,4 +50,5 @@ config I3C_TARGET_CONFIGFS
 
 if I3C_TARGET
 source "drivers/i3c/target/Kconfig"
+source "drivers/i3c/func/Kconfig"
 endif # I3C_TARGET
diff --git a/drivers/i3c/Makefile b/drivers/i3c/Makefile
index c36455cb852ea..1f7e5fa9d25c2 100644
--- a/drivers/i3c/Makefile
+++ b/drivers/i3c/Makefile
@@ -5,3 +5,4 @@ obj-$(CONFIG_I3C)		+= master/
 obj-$(CONFIG_I3C_TARGET)		+= target.o
 obj-$(CONFIG_I3C_TARGET_CONFIGFS)	+= i3c-cfs.o
 obj-$(CONFIG_I3C_TARGET)		+= target/
+obj-$(CONFIG_I3C_TARGET)		+= func/
diff --git a/drivers/i3c/func/Kconfig b/drivers/i3c/func/Kconfig
new file mode 100644
index 0000000000000..6302061e02279
--- /dev/null
+++ b/drivers/i3c/func/Kconfig
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config I3C_TARGET_FUNC_TTY
+	tristate "PCI Endpoint Test driver"
+	depends on I3C_TARGET
+	help
+	  I3C Target TTY Function Driver.
+
+	  General TTY over I3C target controller function drivers.
diff --git a/drivers/i3c/func/Makefile b/drivers/i3c/func/Makefile
new file mode 100644
index 0000000000000..16b3b9301496b
--- /dev/null
+++ b/drivers/i3c/func/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_I3C_TARGET_FUNC_TTY)              += tty.o
diff --git a/drivers/i3c/func/tty.c b/drivers/i3c/func/tty.c
new file mode 100644
index 0000000000000..bad99c08be0ac
--- /dev/null
+++ b/drivers/i3c/func/tty.c
@@ -0,0 +1,475 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 NXP
+ * Author: Frank Li <Frank.Li@nxp.com>
+ */
+
+#include <linux/iopoll.h>
+#include <linux/i3c/target.h>
+#include <linux/serial_core.h>
+#include <linux/slab.h>
+#include <linux/tty_flip.h>
+
+static DEFINE_IDR(i3c_tty_minors);
+
+static struct tty_driver *i3c_tty_driver;
+
+#define I3C_TTY_MINORS		8
+
+#define I3C_TX_NOEMPTY		BIT(0)
+#define I3C_TTY_TRANS_SIZE	16
+#define I3C_TTY_IBI_TX		BIT(0)
+
+struct ttyi3c_port {
+	struct tty_port port;
+	int minor;
+	struct i3c_target_func *i3cdev;
+	struct completion txcomplete;
+	spinlock_t xlock;
+	void *buffer;
+	struct work_struct work;
+	u16 status;
+	struct i3c_request *req;
+};
+
+static void i3c_target_tty_rx_complete(struct i3c_request *req)
+{
+	struct ttyi3c_port *port = req->context;
+
+	if (req->status == I3C_REQUEST_CANCEL) {
+		i3c_target_ctrl_free_request(req);
+		return;
+	}
+
+	tty_insert_flip_string(&port->port, req->buf, req->actual);
+	tty_flip_buffer_push(&port->port);
+
+	req->actual = 0;
+	req->status = 0;
+	i3c_target_ctrl_queue(req, GFP_KERNEL);
+}
+
+static void i3c_target_tty_tx_complete(struct i3c_request *req)
+{
+	struct ttyi3c_port *sport = req->context;
+	unsigned long flags;
+
+	if (req->status == I3C_REQUEST_CANCEL) {
+		i3c_target_ctrl_free_request(req);
+		return;
+	}
+
+	spin_lock_irqsave(&sport->xlock, flags);
+	kfifo_dma_out_finish(&sport->port.xmit_fifo, req->actual);
+	sport->req = NULL;
+
+	if (kfifo_is_empty(&sport->port.xmit_fifo))
+		complete(&sport->txcomplete);
+	else
+		queue_work(system_unbound_wq, &sport->work);
+
+	if (kfifo_len(&sport->port.xmit_fifo) < WAKEUP_CHARS)
+		tty_port_tty_wakeup(&sport->port);
+	spin_unlock_irqrestore(&sport->xlock, flags);
+
+	i3c_target_ctrl_free_request(req);
+}
+
+static void i3c_target_tty_i3c_work(struct work_struct *work)
+{
+	struct ttyi3c_port *sport = container_of(work, struct ttyi3c_port, work);
+	struct i3c_request *req = sport->req;
+	struct scatterlist sg[1];
+	unsigned int nents;
+	u8 ibi;
+
+	if (kfifo_is_empty(&sport->port.xmit_fifo))
+		return;
+
+	if (!req) {
+		req = i3c_target_ctrl_alloc_request(sport->i3cdev->ctrl, GFP_KERNEL);
+		if (!req)
+			return;
+
+		sg_init_table(sg, ARRAY_SIZE(sg));
+		nents = kfifo_dma_out_prepare(&sport->port.xmit_fifo, sg, ARRAY_SIZE(sg),
+					      UART_XMIT_SIZE);
+		if (!nents)
+			goto err;
+
+		req->length = sg->length;
+		req->buf =  sg_virt(sg);
+
+		req->complete = i3c_target_tty_tx_complete;
+		req->context = sport;
+		req->tx = true;
+
+		if (i3c_target_ctrl_queue(req, GFP_KERNEL))
+			goto err;
+
+		sport->req = req;
+	}
+
+	ibi = I3C_TTY_IBI_TX;
+	i3c_target_ctrl_raise_ibi(sport->i3cdev->ctrl, &ibi, 1);
+
+	return;
+
+err:
+	i3c_target_ctrl_free_request(req);
+}
+
+static int i3c_port_activate(struct tty_port *port, struct tty_struct *tty)
+{
+	struct ttyi3c_port *sport = container_of(port, struct ttyi3c_port, port);
+	const struct i3c_target_ctrl_features *feature;
+	struct i3c_target_func *func = sport->i3cdev;
+	struct i3c_request *req;
+	int rxfifo_size;
+	int offset = 0;
+	int ret;
+
+	feature = i3c_target_ctrl_get_features(func->ctrl);
+	if (!feature)
+		return -EINVAL;
+
+	ret = tty_port_alloc_xmit_buf(port);
+	if (ret)
+		return ret;
+
+	sport->buffer = (void *)get_zeroed_page(GFP_KERNEL);
+	if (!sport->buffer)
+		goto err_alloc_rx_buf;
+
+	rxfifo_size = feature->rx_fifo_sz;
+
+	if (!rxfifo_size)
+		rxfifo_size = I3C_TTY_TRANS_SIZE;
+
+	do {
+		req = i3c_target_ctrl_alloc_request(func->ctrl, GFP_KERNEL);
+		if (!req)
+			goto err_alloc_req;
+
+		req->buf = (void *) (sport->buffer + offset);
+		req->length = rxfifo_size;
+		req->context = sport;
+		req->complete = i3c_target_tty_rx_complete;
+		offset += rxfifo_size;
+
+		if (i3c_target_ctrl_queue(req, GFP_KERNEL))
+			goto err_alloc_req;
+	} while (req && (offset + rxfifo_size) < UART_XMIT_SIZE);
+
+	reinit_completion(&sport->txcomplete);
+
+	return 0;
+
+err_alloc_req:
+	i3c_target_ctrl_cancel_all_reqs(func->ctrl, false);
+	free_page((unsigned long)sport->buffer);
+err_alloc_rx_buf:
+	tty_port_free_xmit_buf(port);
+	return -ENOMEM;
+}
+
+static void i3c_port_shutdown(struct tty_port *port)
+{
+	struct ttyi3c_port *sport =
+		container_of(port, struct ttyi3c_port, port);
+
+	cancel_work_sync(&sport->work);
+
+	i3c_target_ctrl_cancel_all_reqs(sport->i3cdev->ctrl, true);
+	i3c_target_ctrl_cancel_all_reqs(sport->i3cdev->ctrl, false);
+
+	i3c_target_ctrl_fifo_flush(sport->i3cdev->ctrl, true);
+	i3c_target_ctrl_fifo_flush(sport->i3cdev->ctrl, false);
+
+	tty_port_free_xmit_buf(port);
+	free_page((unsigned long)sport->buffer);
+}
+
+static void i3c_port_destruct(struct tty_port *port)
+{
+	struct ttyi3c_port *sport =
+		container_of(port, struct ttyi3c_port, port);
+
+	idr_remove(&i3c_tty_minors, sport->minor);
+}
+
+static const struct tty_port_operations i3c_port_ops = {
+	.shutdown = i3c_port_shutdown,
+	.activate = i3c_port_activate,
+	.destruct = i3c_port_destruct,
+};
+
+static int i3c_target_tty_bind(struct i3c_target_func *func)
+{
+	struct ttyi3c_port *sport;
+	struct device *tty_dev;
+	int minor;
+	int ret;
+
+	sport = dev_get_drvdata(&func->dev);
+
+	if (i3c_target_ctrl_set_config(func->ctrl, func)) {
+		dev_err(&func->dev, "failure set i3c config\n");
+		return -EINVAL;
+	}
+
+	spin_lock_init(&sport->xlock);
+	init_completion(&sport->txcomplete);
+
+	ret = minor = idr_alloc(&i3c_tty_minors, sport, 0, I3C_TTY_MINORS, GFP_KERNEL);
+
+	if (minor < 0)
+		goto err_idr_alloc;
+
+	tty_port_init(&sport->port);
+	sport->port.ops = &i3c_port_ops;
+
+	tty_dev = tty_port_register_device(&sport->port, i3c_tty_driver, minor,
+					   &func->dev);
+	if (IS_ERR(tty_dev)) {
+		ret = PTR_ERR(tty_dev);
+		goto err_register_port;
+	}
+
+	sport->minor = minor;
+	ret = i3c_target_ctrl_enable(func->ctrl);
+	if (ret)
+		goto err_ctrl_enable;
+
+	return 0;
+
+err_ctrl_enable:
+	tty_port_unregister_device(&sport->port, i3c_tty_driver, sport->minor);
+err_register_port:
+	idr_remove(&i3c_tty_minors, sport->minor);
+err_idr_alloc:
+	i3c_target_ctrl_cancel_all_reqs(func->ctrl, false);
+	dev_err(&func->dev, "bind failure\n");
+
+	return ret;
+}
+
+static void i3c_target_tty_unbind(struct i3c_target_func *func)
+{
+	struct ttyi3c_port *sport;
+
+	sport = dev_get_drvdata(&func->dev);
+
+	cancel_work_sync(&sport->work);
+
+	i3c_target_ctrl_disable(func->ctrl);
+	i3c_target_ctrl_cancel_all_reqs(func->ctrl, 0);
+	i3c_target_ctrl_cancel_all_reqs(func->ctrl, 1);
+
+	tty_port_unregister_device(&sport->port, i3c_tty_driver, sport->minor);
+
+	free_page((unsigned long)sport->buffer);
+}
+
+static struct i3c_target_func_ops i3c_func_ops = {
+	.bind   = i3c_target_tty_bind,
+	.unbind = i3c_target_tty_unbind,
+};
+
+static int i3c_tty_probe(struct i3c_target_func *func)
+{
+	struct device *dev = &func->dev;
+	struct ttyi3c_port *port;
+
+	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
+
+	port->i3cdev = func;
+	dev_set_drvdata(&func->dev, port);
+
+	INIT_WORK(&port->work, i3c_target_tty_i3c_work);
+
+	return 0;
+}
+
+static ssize_t i3c_write(struct tty_struct *tty, const unsigned char *buf, size_t count)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+	unsigned long flags;
+	bool is_empty;
+	int ret = 0;
+
+	spin_lock_irqsave(&sport->xlock, flags);
+	ret = kfifo_in(&sport->port.xmit_fifo, buf, count);
+	is_empty = kfifo_is_empty(&sport->port.xmit_fifo);
+	i3c_target_ctrl_set_status_format1(sport->i3cdev->ctrl, sport->status | I3C_TX_NOEMPTY);
+	spin_unlock_irqrestore(&sport->xlock, flags);
+
+	if (!is_empty)
+		queue_work(system_unbound_wq, &sport->work);
+
+	return ret;
+}
+
+static int i3c_put_char(struct tty_struct *tty, unsigned char ch)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&sport->xlock, flags);
+	ret = kfifo_put(&sport->port.xmit_fifo, ch);
+	spin_unlock_irqrestore(&sport->xlock, flags);
+
+	return ret;
+}
+
+static void i3c_flush_chars(struct tty_struct *tty)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&sport->xlock, flags);
+	if (!kfifo_is_empty(&sport->port.xmit_fifo))
+		queue_work(system_unbound_wq, &sport->work);
+	spin_unlock_irqrestore(&sport->xlock, flags);
+}
+
+static unsigned int i3c_write_room(struct tty_struct *tty)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+
+	return kfifo_avail(&sport->port.xmit_fifo);
+}
+
+static void i3c_throttle(struct tty_struct *tty)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+
+	i3c_target_ctrl_cancel_all_reqs(sport->i3cdev->ctrl, false);
+}
+
+static void i3c_unthrottle(struct tty_struct *tty)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+
+	i3c_port_activate(&sport->port, tty);
+}
+
+static int i3c_open(struct tty_struct *tty, struct file *filp)
+{
+	struct ttyi3c_port *sport = container_of(tty->port, struct ttyi3c_port, port);
+	int ret;
+
+	tty->driver_data = sport;
+
+	if (!i3c_target_ctrl_get_addr(sport->i3cdev->ctrl)) {
+		dev_dbg(&sport->i3cdev->dev, "No target addr assigned, try hotjoin");
+		ret = i3c_target_ctrl_hotjoin(sport->i3cdev->ctrl);
+		if (ret) {
+			dev_err(&sport->i3cdev->dev, "Hotjoin failure, check connection");
+			return ret;
+		}
+	}
+
+	return tty_port_open(&sport->port, tty, filp);
+}
+
+static void i3c_close(struct tty_struct *tty, struct file *filp)
+{
+	tty_port_close(tty->port, tty, filp);
+}
+
+static void i3c_wait_until_sent(struct tty_struct *tty, int timeout)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+	int val;
+	int ret;
+	u8 ibi = I3C_TTY_IBI_TX;
+	int retry = 100;
+
+	if (!kfifo_is_empty(&sport->port.xmit_fifo)) {
+		do {
+			ret = wait_for_completion_timeout(&sport->txcomplete, timeout / 100);
+			if (ret)
+				break;
+			i3c_target_ctrl_raise_ibi(sport->i3cdev->ctrl, &ibi, 1);
+		} while (retry--);
+
+		reinit_completion(&sport->txcomplete);
+	}
+
+	read_poll_timeout(i3c_target_ctrl_fifo_status, val, !val, 100, timeout, false,
+			  sport->i3cdev->ctrl, true);
+
+	i3c_target_ctrl_set_status_format1(sport->i3cdev->ctrl, sport->status & (~I3C_TX_NOEMPTY));
+}
+
+static const struct tty_operations i3c_tty_ops = {
+	.open = i3c_open,
+	.close = i3c_close,
+	.write = i3c_write,
+	.put_char = i3c_put_char,
+	.flush_chars = i3c_flush_chars,
+	.write_room = i3c_write_room,
+	.throttle = i3c_throttle,
+	.unthrottle = i3c_unthrottle,
+	.wait_until_sent = i3c_wait_until_sent,
+};
+
+DECLARE_I3C_TARGET_FUNC(tty, i3c_tty_probe, NULL, &i3c_func_ops);
+
+static int __init i3c_tty_init(void)
+{
+	int ret;
+
+	i3c_tty_driver = tty_alloc_driver(
+		I3C_TTY_MINORS, TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV);
+
+	if (IS_ERR(i3c_tty_driver))
+		return PTR_ERR(i3c_tty_driver);
+
+	i3c_tty_driver->driver_name = "ttySI3C", i3c_tty_driver->name = "ttySI3C",
+	i3c_tty_driver->minor_start = 0,
+	i3c_tty_driver->type = TTY_DRIVER_TYPE_SERIAL,
+	i3c_tty_driver->subtype = SERIAL_TYPE_NORMAL,
+	i3c_tty_driver->init_termios = tty_std_termios;
+	i3c_tty_driver->init_termios.c_cflag = B9600 | CS8 | CREAD | HUPCL |
+					       CLOCAL;
+	i3c_tty_driver->init_termios.c_lflag = 0;
+
+	tty_set_operations(i3c_tty_driver, &i3c_tty_ops);
+
+	ret = tty_register_driver(i3c_tty_driver);
+	if (ret)
+		goto err_register_tty_driver;
+
+	ret = i3c_target_func_register_driver(&ttyi3c_func);
+	if (ret)
+		goto err_register_i3c_driver;
+
+	return 0;
+
+err_register_i3c_driver:
+	tty_unregister_driver(i3c_tty_driver);
+
+err_register_tty_driver:
+	tty_driver_kref_put(i3c_tty_driver);
+
+	return ret;
+}
+
+static void __exit i3c_tty_exit(void)
+{
+	i3c_target_func_unregister_driver(&ttyi3c_func);
+	tty_unregister_driver(i3c_tty_driver);
+	tty_driver_kref_put(i3c_tty_driver);
+	idr_destroy(&i3c_tty_minors);
+}
+
+module_init(i3c_tty_init);
+module_exit(i3c_tty_exit);
+
+MODULE_LICENSE("GPL");
+
-- 
2.34.1


