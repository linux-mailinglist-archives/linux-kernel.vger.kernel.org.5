Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC20C7CE9D5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 23:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbjJRVNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 17:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344745AbjJRVMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 17:12:50 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2072.outbound.protection.outlook.com [40.107.7.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA40018F;
        Wed, 18 Oct 2023 14:11:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ulwa7q8+LqF5lplAdOhP6m7RHEKEP5xxApybip5giiTZBx77nZS1M1mt/kiKLnRj6nvS4eXW03v3JeJ3o4Y+fpV5WkJssNcEiz1hnI+O5Kd1U0VjeMCHw1Z8prLV8H/ftZaSg+S9RY2UW48XGLw40u5Vkti+oGegkHIn2s3MRmjGSgw/l8CxlAAml7ZQog6WTAmdC+u6qWpvbDDT9OOOo2JiJdOI0Xs8T4n1fctvfrQ0CzABn+/HzK/JcAnenaVowcfzcjhFViAYhixluWnfCgqDkiFku3Wk+quz49LoXSMVLxeBUixDO5O3w3YtYJwyxgWGZq8B3PIWXvLzWvRgXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dGl6VmKGZ7TK/47tUUGnq1OBm7Lx/yZgukFc0RvKfs=;
 b=CfZlZuYCKuD22wemWiVPfgSvhr2ZdvkdxgsIM04Gz7rWMYexkrSRSiHSMNTDbNV9Zo61Zs2FtrDX9YqDDL4Kxdq2NKEuz//hYPdBPe9HgF+o8c8ReRht97Siqm1vbfzdjBe/19UnYtuFf4HKXQSIN7Xi7rUHDRKULwAOiADw/e+EjUaJ/5DHY0r88ozMX/puj+O+k7UH2RPAjrFPYUVNB+pOhkO8g4S5XN/dLmU52G0bsjKCMhdPxYOhQbC5nBvnL/1C4s1izrQuK6o3B8a4WQQ7j//HyUQgMighl2iqLk2W9elE+50EDgR/e+PzG4ZirFjDuag0FMy4hSkys1OclA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dGl6VmKGZ7TK/47tUUGnq1OBm7Lx/yZgukFc0RvKfs=;
 b=RmFTUbIf5nKL5LqtXFhrsTtWCWJfLnEcTIz5WayxE/jQ8Vp/XoPTe+zYFrERXHq+aRfyxW6Hy6vqf9nZ4jcQKVpypDemt7IU7ovFsya9pjGc3/rC0XzmncECo8lr4kpvTMt9NfKEO1Od7NxSjGiXhN2qUA4lpFYUkE8mqk3XtTI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB9377.eurprd04.prod.outlook.com (2603:10a6:10:36b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.7; Wed, 18 Oct
 2023 21:11:28 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 21:11:28 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org (open list),
        linux-serial@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS)
Cc:     alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
        imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        miquel.raynal@bootlin.com
Subject: [PATCH 1/1] tty: i3c: add tty over i3c master support
Date:   Wed, 18 Oct 2023 17:11:09 -0400
Message-Id: <20231018211111.3437929-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0002.namprd07.prod.outlook.com
 (2603:10b6:a03:505::25) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB9377:EE_
X-MS-Office365-Filtering-Correlation-Id: 01095c4e-d87d-4078-2c1a-08dbd01ecb15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 00aNqUGLqUlLRvUzYm0TvBXcCa2IllzG9t5PdGQEXVNerlEWG409Z6rzxX1i19QlrrKGC0EPIaeo8+m/7zt1vs/5UJWFX5bLB/lWi8zAMLot0FKBlEiUp5KC/SY27QDkDd6MMNBKz09+zFNuV3nIoJ8Nx/SHxSsLTdYrW+3bCPiYPcSNY+R+R0oUy8B9ckIBzz0eT2GmvIlmIsNsukXk40Vj55D+fJhymnKVfNpl4INbC4ypSMw9VNnws5nfBFrCk2kPt/xs17SBhQ1MJ/QUW5Qs6Bo3kOFeOJTTAXEQxCs5f4VCj0wKX7rkYZl1k0cMtViv0DOl1ZpYsaBfNpAGNHtgM7GAeZc3gRzDDnUu4rYNLixpLkFtRtxt/5IWI6Zq1fZ7dGXck8hIKCtF7l4rBeF9q8+C9GoiqOBZzZaB8RJXFdycwtrX9NYmL+sovmfjVNwu3zNR3UwN1ihZ25ltJBT3xoX2TwjTj+8w8VlMEFmqG4kwg0Okwh/IsKUZCpDZiZAF9guHRSKLNRMpJSoSPZUNAhWAju5r8J94Mywh8pcDoeQ9dZfgcIfYh1j0piDLiy+2nggtDFfCHC+kB9ScV2ZUsPv/T+ThVPjgE75pj8vOahEr9jscNBmtdVILZUSV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(38350700005)(36756003)(66556008)(66476007)(66946007)(110136005)(86362001)(38100700002)(26005)(83380400001)(2616005)(1076003)(6666004)(52116002)(6506007)(6512007)(966005)(6486002)(7416002)(2906002)(478600001)(316002)(4326008)(30864003)(41300700001)(5660300002)(8936002)(8676002)(42413004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2LlqROTd6HW4x/9N00uIRBJ4tv60voMtuRsbJpnprrLhiw8K4dGg2fYgbV68?=
 =?us-ascii?Q?5AGkO6OhkwSkaVl0GmXKKb4o4LYwZDjf5VexnHZ0n5YRRlrjXREM1lJwjGCF?=
 =?us-ascii?Q?eU3ZVRd+szDAyvuWHrc5iLDX3fPfgToT3D5cWbShJ/MMXC8Mn0jnXBFJGJMy?=
 =?us-ascii?Q?kSNYTtXdnRPIxo9th0cmUphGzncr1h1YMULxRuVRiAG9uR7knm4mfGevm2aa?=
 =?us-ascii?Q?Uaf7raJ/c6Vhjug43gv88o6z60usin2JXvt3EV9N8UzV/bK+vPR7J+STRtxK?=
 =?us-ascii?Q?ZQ8pfTZt6EQL8sZCLPxZGOjMRhoHWYkEV+hlAMSMpzHLhp8eNiVcyfy4itOP?=
 =?us-ascii?Q?5NOTLMjPzhhwmZoXi5+zGtzzPDM4IA44Ne2m6ko90hP1SuPm4OwjbWazzlIQ?=
 =?us-ascii?Q?a3BsFxzY+vvd9YTBQRyj5gJiS4hUlOUxC1vNcRNEzXqxtkn0dYRJxzTLCpBw?=
 =?us-ascii?Q?hKUkdYf69HpEYAsgplgMl4eYU71A9xEbU09LKDCoZrekeWLwOdi0kQwwhSIb?=
 =?us-ascii?Q?TVu1RE1nRwl1VFAcUEbDqMdiVin45ruzFvkWeHVa1Y457qYdDFMu4+H0TATz?=
 =?us-ascii?Q?8jRTq3V//S/Yn2Ty/glyn2Yp3fCwr/O3RGEuDfK8N3TwfwguFtdyzUDpL7f3?=
 =?us-ascii?Q?eoCRN8eFaSZu3YDTU/wRYKulcVddILNDmaxy7+Z8B6NQARoemI5VCAa13EfP?=
 =?us-ascii?Q?eX7ODKcEpfDxZQ6L8tIYVEbmgFC359gECLkmYveiZbbTsMXrPoa4Hh0U0ueg?=
 =?us-ascii?Q?CNdVDz8a/DA2/kO/Qxa9ZJUATBWJRmR3NOzuLMFy4wj9EzuluhI8KOsUrQCc?=
 =?us-ascii?Q?WxvN07ir2XAwapjaGEttCY8MHN4FXVAVxn1PiRSnW5WwLauPgDSLgVdpbc0w?=
 =?us-ascii?Q?KPeyvwAZhpdQfYdzT3jdN6Ilm1z+oJqb2TUlTlxuc+V4wy3rpdsGNkmrHasy?=
 =?us-ascii?Q?yvCQqCI8jfOdlCThh2ZhQeaF7tugKtO+rcU52FrjF/4GHu85tquQDu/wOsKc?=
 =?us-ascii?Q?qeqRmBFIs9qeEG6KR0YgmAI/zVeI+egNltvIw/Mh1Ax2zgnsUjl0utVQWpfw?=
 =?us-ascii?Q?fGdGcoXLm6AhJ+m+P14w3pcJt0DNP6JbyGHvYhdRzoO9Pr8RM87EsnH+4THs?=
 =?us-ascii?Q?KgNy1PQ/q0mYFMf6hxrNOFscJXSnsMVbCxqDuH7lgUH5PQ/22CHw+MLNDi/V?=
 =?us-ascii?Q?prL7vi1nb7jvxD7KEwiR3iYiRTzwv0ibWQfZL/PfiPFGuFqw9b5Y7QpZBNSl?=
 =?us-ascii?Q?sJ3LmmREIEhUX/UvpliwPc3P7tExhVEiCxYOMHzjYmCr/V3DxNLfOfABvmI+?=
 =?us-ascii?Q?2rD3UVqFzLj2r8cUUHe+pJQ83owOaC+GkpoBfr92cqUPSSC1oreVFg3HdAaP?=
 =?us-ascii?Q?bMDJ28k/oFK2dNEGHubLPRjsj14qmEigHR1jX1YHxLPnCUzD43mb/1bKSacN?=
 =?us-ascii?Q?dcaC+NwsRfFPT6W9lU4v+dsEPspDdqWNnRDNXgX3w+8jic8vkhyo8ud8xrhr?=
 =?us-ascii?Q?uvmwpZc+2pTVLIBM2SgwARau7Y35VFovPFfvtWcck2p9G6phVvnoQlyeApnY?=
 =?us-ascii?Q?R40S7WeygEMlMXnC+kY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01095c4e-d87d-4078-2c1a-08dbd01ecb15
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 21:11:28.0851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k936KvP8mlUCmaaGd/UlOwJK4ejI6WAz3hNQWkaa9JqTE/b692Jj6sNBtXlX7RHNU5fg8GBlTEjAyuF+9CZQaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9377
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new driver to allow tty over i3c master.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    This patch depend on
    https://lore.kernel.org/imx/20231018205929.3435110-1-Frank.Li@nxp.com/T/#t

 drivers/tty/Kconfig   |   8 +
 drivers/tty/Makefile  |   1 +
 drivers/tty/i3c_tty.c | 466 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 475 insertions(+)
 create mode 100644 drivers/tty/i3c_tty.c

diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index 5646dc6242cd9..6d91fe6a211a1 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -412,6 +412,14 @@ config RPMSG_TTY
 	  To compile this driver as a module, choose M here: the module will be
 	  called rpmsg_tty.
 
+config I3C_TTY
+	tristate "tty over i3c"
+	depends on I3C
+	help
+	  Select this options if you'd like use tty over I3C master controller
+
+	  If unsure, say N
+
 endif # TTY
 
 source "drivers/tty/serdev/Kconfig"
diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
index 07aca5184a55d..f329f9c7d308a 100644
--- a/drivers/tty/Makefile
+++ b/drivers/tty/Makefile
@@ -27,5 +27,6 @@ obj-$(CONFIG_GOLDFISH_TTY)	+= goldfish.o
 obj-$(CONFIG_MIPS_EJTAG_FDC_TTY) += mips_ejtag_fdc.o
 obj-$(CONFIG_VCC)		+= vcc.o
 obj-$(CONFIG_RPMSG_TTY)		+= rpmsg_tty.o
+obj-$(CONFIG_I3C_TTY)		+= i3c_tty.o
 
 obj-y += ipwireless/
diff --git a/drivers/tty/i3c_tty.c b/drivers/tty/i3c_tty.c
new file mode 100644
index 0000000000000..fe45bf94a8cf2
--- /dev/null
+++ b/drivers/tty/i3c_tty.c
@@ -0,0 +1,466 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2023 NXP.
+ *
+ * Author: Frank Li <Frank.Li@nxp.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/i3c/device.h>
+#include <linux/i3c/master.h>
+#include <linux/slab.h>
+#include <linux/console.h>
+#include <linux/serial_core.h>
+#include <linux/interrupt.h>
+#include <linux/workqueue.h>
+#include <linux/tty_flip.h>
+
+static DEFINE_IDR(i3c_tty_minors);
+static DEFINE_MUTEX(i3c_tty_minors_lock);
+
+static struct tty_driver *i3c_tty_driver;
+
+#define I3C_TTY_MINORS		256
+#define I3C_TTY_TRANS_SIZE	16
+#define I3C_TTY_RX_STOP		BIT(0)
+#define I3C_TTY_RETRY		20
+#define I3C_TTY_YIELD_US	100
+
+struct ttyi3c_port {
+	struct tty_port port;
+	int minor;
+	unsigned int txfifo_size;
+	unsigned int rxfifo_size;
+	struct circ_buf xmit;
+	spinlock_t xlock; /* protect xmit */
+	void *buffer;
+	struct i3c_device *i3cdev;
+	struct work_struct txwork;
+	struct work_struct rxwork;
+	struct completion txcomplete;
+	struct workqueue_struct *workqueue;
+	atomic_t status;
+};
+
+static const struct i3c_device_id i3c_ids[] = {
+	I3C_DEVICE(0x011B, 0x1000, NULL),
+	{ /* sentinel */ },
+};
+
+static int i3c_port_activate(struct tty_port *port, struct tty_struct *tty)
+{
+	struct ttyi3c_port *sport = container_of(port, struct ttyi3c_port, port);
+
+	atomic_set(&sport->status, 0);
+
+	return i3c_device_enable_ibi(sport->i3cdev);
+}
+
+static void i3c_port_shutdown(struct tty_port *port)
+{
+	struct ttyi3c_port *sport =
+		container_of(port, struct ttyi3c_port, port);
+
+	i3c_device_disable_ibi(sport->i3cdev);
+}
+
+static void i3c_port_destruct(struct tty_port *port)
+{
+	struct ttyi3c_port *sport =
+		container_of(port, struct ttyi3c_port, port);
+
+	mutex_lock(&i3c_tty_minors_lock);
+	idr_remove(&i3c_tty_minors, sport->minor);
+	mutex_unlock(&i3c_tty_minors_lock);
+}
+
+static const struct tty_port_operations i3c_port_ops = {
+	.shutdown = i3c_port_shutdown,
+	.activate = i3c_port_activate,
+	.destruct = i3c_port_destruct,
+};
+
+static struct ttyi3c_port *i3c_get_by_minor(unsigned int minor)
+{
+	struct ttyi3c_port *sport;
+
+	mutex_lock(&i3c_tty_minors_lock);
+	sport = idr_find(&i3c_tty_minors, minor);
+	mutex_unlock(&i3c_tty_minors_lock);
+
+	return sport;
+}
+
+static int i3c_install(struct tty_driver *driver, struct tty_struct *tty)
+{
+	struct ttyi3c_port *sport;
+	int ret;
+
+	sport = i3c_get_by_minor(tty->index);
+	if (!sport)
+		return -ENODEV;
+
+	ret = tty_standard_install(driver, tty);
+	if (ret)
+		return ret;
+
+	tty->driver_data = sport;
+
+	return 0;
+}
+
+static ssize_t i3c_write(struct tty_struct *tty, const unsigned char *buf, size_t count)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+	struct circ_buf *circ = &sport->xmit;
+	unsigned long flags;
+	int c, ret = 0;
+
+	spin_lock_irqsave(&sport->xlock, flags);
+	while (1) {
+		c = CIRC_SPACE_TO_END(circ->head, circ->tail, UART_XMIT_SIZE);
+		if (count < c)
+			c = count;
+		if (c <= 0)
+			break;
+
+		memcpy(circ->buf + circ->head, buf, c);
+		circ->head = (circ->head + c) & (UART_XMIT_SIZE - 1);
+		buf += c;
+		count -= c;
+		ret += c;
+	}
+	spin_unlock_irqrestore(&sport->xlock, flags);
+
+	if (circ->head != circ->tail)
+		queue_work(sport->workqueue, &sport->txwork);
+
+	return ret;
+}
+
+static int i3c_put_char(struct tty_struct *tty, unsigned char ch)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+	struct circ_buf *circ = &sport->xmit;
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&sport->xlock, flags);
+
+	if (sport && CIRC_SPACE(circ->head, circ->tail, UART_XMIT_SIZE) != 0) {
+		circ->buf[circ->head] = ch;
+		circ->head = (circ->head + 1) & (UART_XMIT_SIZE - 1);
+		ret = 1;
+	}
+
+	spin_unlock_irqrestore(&sport->xlock, flags);
+
+	return ret;
+}
+
+static void i3c_flush_chars(struct tty_struct *tty)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+
+	queue_work(sport->workqueue, &sport->txwork);
+}
+
+static unsigned int i3c_write_room(struct tty_struct *tty)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+	struct circ_buf *circ = &sport->xmit;
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&sport->xlock, flags);
+	ret = CIRC_SPACE(circ->head, circ->tail, UART_XMIT_SIZE);
+	spin_unlock_irqrestore(&sport->xlock, flags);
+
+	return ret;
+}
+
+static void i3c_throttle(struct tty_struct *tty)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+
+	atomic_or(I3C_TTY_RX_STOP, &sport->status);
+}
+
+static void i3c_unthrottle(struct tty_struct *tty)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+
+	atomic_andnot(I3C_TTY_RX_STOP, &sport->status);
+
+	queue_work(sport->workqueue, &sport->rxwork);
+}
+
+static int i3c_open(struct tty_struct *tty, struct file *filp)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+
+	return tty_port_open(&sport->port, tty, filp);
+}
+
+static void i3c_close(struct tty_struct *tty, struct file *filp)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+
+	if (!sport)
+		return;
+
+	tty_port_close(tty->port, tty, filp);
+}
+
+static void i3c_wait_until_sent(struct tty_struct *tty, int timeout)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+
+	wait_for_completion_timeout(&sport->txcomplete, timeout);
+	reinit_completion(&sport->txcomplete);
+}
+
+static const struct tty_operations i3c_tty_ops = {
+	.install = i3c_install,
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
+static void i3c_controller_irq_handler(struct i3c_device *dev,
+				       const struct i3c_ibi_payload *payload)
+{
+	struct ttyi3c_port *sport = dev_get_drvdata(&dev->dev);
+
+	queue_work(sport->workqueue, &sport->rxwork);
+}
+
+static void tty_i3c_rxwork(struct work_struct *work)
+{
+	struct ttyi3c_port *sport = container_of(work, struct ttyi3c_port, rxwork);
+	struct i3c_priv_xfer xfers;
+	int retry = I3C_TTY_RETRY;
+	u16 status = BIT(0);
+
+	do {
+		memset(&xfers, 0, sizeof(xfers));
+		xfers.data.in = sport->buffer;
+		xfers.len = I3C_TTY_TRANS_SIZE;
+		xfers.rnw = 1;
+
+		if (I3C_TTY_RX_STOP & atomic_read(&sport->status))
+			break;
+
+		i3c_device_do_priv_xfers(sport->i3cdev, &xfers, 1);
+
+		if (xfers.actual_len) {
+			tty_insert_flip_string(&sport->port, sport->buffer, xfers.actual_len);
+			retry = 20;
+			continue;
+		} else {
+			status = BIT(0);
+			i3c_device_getstatus_format1(sport->i3cdev, &status);
+			/*
+			 * Target side need some time to fill data into fifo. Target side may not
+			 * have hardware update status in real time. Software update status always
+			 * need some delays.
+			 *
+			 * Generally, target side have cicular buffer in memory, it will be moved
+			 * into FIFO by CPU or DMA. 'status' just show if cicular buffer empty. But
+			 * there are gap, espcially CPU have not response irq to fill FIFO in time.
+			 * So xfers.actual will be zero, wait for little time to avoid flood
+			 * transfer in i3c bus.
+			 */
+			usleep_range(I3C_TTY_YIELD_US, 10 * I3C_TTY_YIELD_US);
+			retry--;
+		}
+
+	} while (retry && (status & BIT(0)));
+
+	tty_flip_buffer_push(&sport->port);
+}
+
+static void tty_i3c_txwork(struct work_struct *work)
+{
+	struct ttyi3c_port *sport = container_of(work, struct ttyi3c_port, txwork);
+	struct circ_buf *circ = &sport->xmit;
+	int cnt = CIRC_CNT(circ->head, circ->tail, UART_XMIT_SIZE);
+	struct i3c_priv_xfer xfers;
+	int retry = I3C_TTY_RETRY;
+	unsigned long flags;
+	int actual;
+	int ret;
+
+	while (cnt > 0 && retry) {
+		xfers.rnw = 0;
+		xfers.len = CIRC_CNT_TO_END(circ->head, circ->tail, UART_XMIT_SIZE);
+		xfers.len = min_t(u16, 16, xfers.len);
+		xfers.data.out = circ->buf + circ->tail;
+
+		ret = i3c_device_do_priv_xfers(sport->i3cdev, &xfers, 1);
+		if (ret) {
+			/*
+			 * Target side may not move data out of FIFO. delay can't resolve problem,
+			 * just reduce some possiblity. Target can't end I3C SDR mode write
+			 * transfer, discard data is reasonable when FIFO overrun.
+			 */
+			usleep_range(I3C_TTY_YIELD_US, 10 * I3C_TTY_YIELD_US);
+			retry--;
+		} else {
+			retry = 0;
+		}
+
+		actual = xfers.len;
+
+		circ->tail = (circ->tail + actual) & (UART_XMIT_SIZE - 1);
+
+		if (CIRC_CNT(circ->head, circ->tail, UART_XMIT_SIZE) < WAKEUP_CHARS)
+			tty_port_tty_wakeup(&sport->port);
+
+		cnt = CIRC_CNT(circ->head, circ->tail, UART_XMIT_SIZE);
+	}
+
+	spin_lock_irqsave(&sport->xlock, flags);
+	if (circ->head == circ->tail)
+		complete(&sport->txcomplete);
+	spin_unlock_irqrestore(&sport->xlock, flags);
+}
+
+static int i3c_probe(struct i3c_device *i3cdev)
+{
+	struct ttyi3c_port *port;
+	struct device *tty_dev;
+	struct i3c_ibi_setup req;
+	int minor;
+	int ret;
+
+	port = devm_kzalloc(&i3cdev->dev, sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
+
+	port->i3cdev = i3cdev;
+	port->buffer = devm_kzalloc(&i3cdev->dev, UART_XMIT_SIZE, GFP_KERNEL);
+	if (!port->buffer)
+		return -ENOMEM;
+
+	port->xmit.buf = devm_kzalloc(&i3cdev->dev, UART_XMIT_SIZE, GFP_KERNEL);
+	if (!port->xmit.buf)
+		return -ENOMEM;
+
+	dev_set_drvdata(&i3cdev->dev, port);
+
+	req.max_payload_len = 8;
+	req.num_slots = 4;
+	req.handler = &i3c_controller_irq_handler;
+
+	ret = i3c_device_request_ibi(i3cdev, &req);
+	if (ret)
+		return -EINVAL;
+
+	mutex_lock(&i3c_tty_minors_lock);
+	minor = idr_alloc(&i3c_tty_minors, port, 0, I3C_TTY_MINORS, GFP_KERNEL);
+	mutex_unlock(&i3c_tty_minors_lock);
+
+	if (minor < 0)
+		return -EINVAL;
+
+	spin_lock_init(&port->xlock);
+	INIT_WORK(&port->txwork, tty_i3c_txwork);
+	INIT_WORK(&port->rxwork, tty_i3c_rxwork);
+	init_completion(&port->txcomplete);
+
+	port->workqueue = alloc_workqueue("%s", 0, 0, dev_name(&i3cdev->dev));
+	if (!port->workqueue)
+		return -ENOMEM;
+
+	tty_port_init(&port->port);
+	port->port.ops = &i3c_port_ops;
+
+	tty_dev = tty_port_register_device(&port->port, i3c_tty_driver, minor,
+					   &i3cdev->dev);
+	if (IS_ERR(tty_dev)) {
+		destroy_workqueue(port->workqueue);
+		return PTR_ERR(tty_dev);
+	}
+
+	port->minor = minor;
+
+	return 0;
+}
+
+void i3c_remove(struct i3c_device *dev)
+{
+	struct ttyi3c_port *sport = dev_get_drvdata(&dev->dev);
+
+	tty_port_unregister_device(&sport->port, i3c_tty_driver, sport->minor);
+	cancel_work_sync(&sport->txwork);
+	destroy_workqueue(sport->workqueue);
+}
+
+static struct i3c_driver i3c_driver = {
+	.driver = {
+		.name = "ttyi3c",
+	},
+	.probe = i3c_probe,
+	.remove = i3c_remove,
+	.id_table = i3c_ids,
+};
+
+static int __init i3c_tty_init(void)
+{
+	int ret;
+
+	i3c_tty_driver = tty_alloc_driver(I3C_TTY_MINORS,
+					  TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV);
+
+	if (IS_ERR(i3c_tty_driver))
+		return PTR_ERR(i3c_tty_driver);
+
+	i3c_tty_driver->driver_name = "ttyI3C";
+	i3c_tty_driver->name = "ttyI3C";
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
+	if (ret) {
+		tty_driver_kref_put(i3c_tty_driver);
+		return ret;
+	}
+
+	ret = i3c_driver_register(&i3c_driver);
+	if (ret) {
+		tty_unregister_driver(i3c_tty_driver);
+		tty_driver_kref_put(i3c_tty_driver);
+	}
+
+	return ret;
+}
+
+static void __exit i3c_tty_exit(void)
+{
+	i3c_driver_unregister(&i3c_driver);
+	tty_unregister_driver(i3c_tty_driver);
+	tty_driver_kref_put(i3c_tty_driver);
+	idr_destroy(&i3c_tty_minors);
+}
+
+module_init(i3c_tty_init);
+module_exit(i3c_tty_exit);
+
+MODULE_LICENSE("GPL");
-- 
2.34.1

