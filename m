Return-Path: <linux-kernel+bounces-22572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CAD829FDC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5099C1F28A8A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140AF4F1EB;
	Wed, 10 Jan 2024 17:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mOXRNWSP"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2054.outbound.protection.outlook.com [40.107.22.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B66C4EB5A;
	Wed, 10 Jan 2024 17:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0T5QFbhdD1A/sz5OuX8Df3pzlFqpxlccpm+b2tB84ZXsePizemFPgQ8CmRaZaK9cExjwgOpCod53wixFqykzbMTtr91FEo+vnOmC4+7UORx4mIIf5B485C9bYITEWIV+Wwp3d92G0xuUgXQCox6JYKS6vTNnfbLPjOBHpplRuYFSZVchkGhlgTkMymSZecY/Fgj4PWxvpCToAE+H2/JrzJtV4/8BGl9cDmSkjryow8fg9JKhMpCvIzlBs5zRKkoIGTmPLrkzp0D2dt+ykZF1o/5KKLtXLvtsCRDtlr7fDqMeXwwKEhNKk+3h57Hb7LXEt5dpLQw0ALvsbCxMysMDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHpGrkXF/xotQPsa1pWRHrVAGIt4WeuA5s3QpXwuvU0=;
 b=buXEDrYWMbfqmcmnEq9BEFuEy3oihUg1MHDNG0p7m5L3GnHxlWkqq0N7jdQj0NLPIO8hj3zByzXFMEEzkv4og8XZHa3oWS9ylX0wfqPGi6h0J4z/qHLucSg0lmVJ34EOyWb+CVE16DYe7HnnP5x0ahGR4YggohQe30ZqjP+RtCNwXbr8+U4XsEMuUccsBkWrHmVgcy19SdQYkfeFKfjUiFMZon/PSiIa9Vyzogz8O682KxSf0fOMR0kO+7prqGmT64tojVp53/iPf8ytilqjrC9L9aEmgd2CDHZ5eIx/JPpgKXZ+4XA7G/n6xK7BOHieomhJ6bmWjx60fVCMK21jsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHpGrkXF/xotQPsa1pWRHrVAGIt4WeuA5s3QpXwuvU0=;
 b=mOXRNWSPMC5nk3urj5e09Yq0MjSYgnbTrzi3Ct1J3n9fbfbHs/tEcR3H1eZhOcBClXNsgkRa9ezCoT8A25we24budeJyMRWzzny8ca6S/ncwz9FCQwWqsmt+pBDkFDcmtMFzTEqwVuZE/ZwUcnxRxG+zViqRYsHfYnRkQVYtYyQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com (2603:10a6:20b:23f::5)
 by PA4PR04MB9392.eurprd04.prod.outlook.com (2603:10a6:102:2ab::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Wed, 10 Jan
 2024 17:53:09 +0000
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469]) by AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469%4]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 17:53:09 +0000
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
Subject: [PATCH v2 7/7] tty: i3c: add TTY over I3C master support
Date: Wed, 10 Jan 2024 12:52:21 -0500
Message-Id: <20240110175221.2335480-8-Frank.Li@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AS8PR04MB7511:EE_|PA4PR04MB9392:EE_
X-MS-Office365-Filtering-Correlation-Id: 638553cc-ba42-4689-bfa3-08dc12050155
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KGDEb6G4LZclddMsGuX9qJJVGnT6on7fvrl2kHvEEHvNl77AVL1aaulMzyauXtMMfEbahJ9x6UHFAR5YqcOWmUStfo0e2F/rEL8pFvxHLUhT1EhMxoRUctmrAL4PPou0DqUmcFC28hui7sPxL7VmS+QWvA+eQ7Hrkk4DYhd59RO/uzUyGxIebZysJ7MeaURAGcce7VPszaNMLwYnLfFE0AgdYfOgvyGyOg7bbtd8BzX+bCO+TTfk+y2jpIGX28ogkkJWbeYliFCijUVipcgF4/B53EJPwnOiqvga83MuBk6+fmGY7uiTfF4WF670hIUM3z1OwERqan8JvBYpY7nTOj0yHI14AcJRIqNUjveve2wd37WB8Yn4DBdAYIT6d/ktRmtZExAkT8QRpJVIfLs9aAOnC/9CHG5k/nI9dlpiZu2ngycX78WIac4yB5hyZXYFJXvqNSXPmuocJrjIpeYkLHteE6/Qv7CB+gNlkFMi/1THhRIFluSy6sSStEub7gP7WUTzCqMm+mY0eDIRbKo71tfuuFh+/Hxvq7byvJrdXDb8+gRDRXbiR9s9GZMpikieBNUXI6BTGKJBT1LFp5OO15M/L+pZT31mggdU3QZJeTRVDrFMmXbzmhWrTDygBJMs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7511.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(36756003)(52116002)(6486002)(478600001)(38350700005)(86362001)(2616005)(1076003)(26005)(83380400001)(5660300002)(7416002)(2906002)(30864003)(316002)(6666004)(6512007)(6506007)(8936002)(8676002)(4326008)(66946007)(41300700001)(38100700002)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sDyDeS9u9WnPF2sDNeAxeTPaWJNU2/PPC37aGHrC7k6zTmJnngXaUy54zGN9?=
 =?us-ascii?Q?Ud85g8BF05mQcpNmU6Y+9hrhLFaA/6StPA+WLQf5J8OKFdHnimrzl60LXTiJ?=
 =?us-ascii?Q?c7I86MYgwzivBMcVBooNKvi6ZB585eTjgq19NCITrFO7QYG7Z4ZrPm3sSRW5?=
 =?us-ascii?Q?gH3tIfg1PS+cs/teB7Ddt2GnDd4g9yhHJZTgZcO/BPxgaD0i3ZI0j5MImORz?=
 =?us-ascii?Q?OlPAZ1k6MnXKsYSiOotqj7iWbsjbIwQKA1olcxDPoQxGw+Qg206upWlKmCXU?=
 =?us-ascii?Q?NDNR7sLLUAZGVw++iIBl1rtOjkocBqzmsGkCihh1eN7NCDbU64JHR4hgWbU1?=
 =?us-ascii?Q?sVwcbGVNQeNTamKUBzBcHl62nCIycL9yK0hlXaIK6kVGmyeJ3U3vwy6VzXPS?=
 =?us-ascii?Q?+THWSKmvPNwwlVCIY39PEyAfNVSWlTQpZtCriiSwB208+YAPmJ6o+B7eNJ6l?=
 =?us-ascii?Q?ywQsmKLAup6yl2V13jxbTrK/UlQzswUEBzHy7/JPFpw3rDoZHWZG5e6HSFf1?=
 =?us-ascii?Q?ZSP5cjyhTJfQk4yRBwN8FEaJKZTfJyilus7I+Lsmo6Ab+xTRUSCkz5qbEn7W?=
 =?us-ascii?Q?8Sqs/ErdwjNt53ir4vfxQT60eTyNY6E4H5Wm/C8KMJ7iWGgVW6tmqp1+QSM0?=
 =?us-ascii?Q?V7De37vGy2E1Vmdu3SwzATCGK7fDrF97nitlogs/JtD7S02vRQGOg/YPRFbj?=
 =?us-ascii?Q?47LnGTl9ZRJNwmytleDTh9X6oYa1eXLWeA3QwSUNHhjkQ3O75LKLU0gfdevS?=
 =?us-ascii?Q?jFF48KR7W73hyNfMtbp+WDtPzwA2nibWKVO6vLSNd5XQjt91F+ny5LAbDq8j?=
 =?us-ascii?Q?QpUM1885DmAxEDUlJf5wzar5r4XVlvXWps9rto5DunWJz4IABBlnQwZHd/lZ?=
 =?us-ascii?Q?eMQKoSOMhx/wIbVoPg51crnQGDpvPrAnRyPsByWmXO6m0KKPyYQN/0TrGpkG?=
 =?us-ascii?Q?CTtmePxq+xPX+oS1XmLvE01zdZufciIR9064VdxvPl7YljlTw/6GXRPlsUVk?=
 =?us-ascii?Q?e3lnZmwiB70eqj/I7CNv1aCCwLskD9xiv+GlAqNo3RE+3JLfyKZpugiQdfsf?=
 =?us-ascii?Q?gFCSh2xluiYikiCWdZaqLmwT0Dd8HMy865qjX2ZG2OILFuT8AtTsckhyxZ65?=
 =?us-ascii?Q?M4+QZXPV75SinnFmAJFf8ODmKX62PSef5UWpB8jMYCDhoJ0iEcUkjze+N78l?=
 =?us-ascii?Q?O2Ch4uu6VdHz+U71TglDAHOOU57hno/JzVrO93woFWpa8CAUzCIweNKxBXIR?=
 =?us-ascii?Q?sOMBSUvTBuy+OygbBlkRnQXtwBoBHsANcTm8T4BLm3c7bCHHLWHtGV5xc1z8?=
 =?us-ascii?Q?rGd+yOvQCCxBnLnpMy1h/XyLG6dSqoxNFzzrN6DBNsugElmzioizolzQD8Zj?=
 =?us-ascii?Q?FBVgLjdl0JSVQNycJ+aHjPwzJHrjwZW7WsdM+xvsdP21zSFVKK5H70qBR3CL?=
 =?us-ascii?Q?gwhmXSZ3LXUIagP5PutT9+V3qUenVkHM8RTq8ruGYlEGFbK3vNGT5pnNnFiz?=
 =?us-ascii?Q?ww1Qd7YY9UUwt+3FiIFfS9kUSTGiDyEHXKnF/8rFBthvMes7XP3aACKiuaSc?=
 =?us-ascii?Q?5Xwe2pLSQLbMhUoahc0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 638553cc-ba42-4689-bfa3-08dc12050155
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7511.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 17:53:08.9288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZWfXDhpCWJJJTZmZlkmM5XEuY4wK0e5G2G8rYyZunv1uuwbxknJVnjQNsrBaQHM/BWPJ4BDO2cxHVRmaYkSo+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9392

In typical embedded Linux systems, UART consoles require at least two pins,
TX and RX. In scenarios where I2C/I3C devices like sensors or PMICs are
present, we can save these two pins by using this driver. Pins is crucial
resources, especially in small chip packages.

This introduces support for using the I3C bus to transfer console tty data,
effectively replacing the need for dedicated UART pins. This not only
conserves valuable pin resources but also facilitates testing of I3C's
advanced features, including early termination, in-band interrupt (IBI)
support, and the creation of more complex data patterns. Additionally,
it aids in identifying and addressing issues within the I3C controller
driver.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Version number use i3c target patches.
    Change v2
    - using system_unbound_wq working queue
    - fixed accoring to Jiri Slaby's comments
    
    Change before send with i3c target support
    
    Change from v4 to v5
    - send in i3c improvememtn patches.
    
    Change from v2 to v4
    - none
    
    Change from v1 to v2
    - update commit message.
    - using goto for err handle
    - using one working queue for all tty-i3c device
    - fixed typo found by js
    - update kconfig help
    - using kfifo
    
    Still below items not be fixed (according to Jiri Slaby's comments)
    - rxwork thread: need trigger from two position.
    - common thread queue: need some suggestion

 drivers/tty/Kconfig   |  13 ++
 drivers/tty/Makefile  |   1 +
 drivers/tty/i3c_tty.c | 426 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 440 insertions(+)
 create mode 100644 drivers/tty/i3c_tty.c

diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index 5646dc6242cd9..9ab4cd480e9f8 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -412,6 +412,19 @@ config RPMSG_TTY
 	  To compile this driver as a module, choose M here: the module will be
 	  called rpmsg_tty.
 
+config I3C_TTY
+	tristate "TTY over I3C"
+	depends on I3C
+	help
+	  Select this option to use TTY over I3C master controller.
+
+	  This makes it possible for user-space programs to send and receive
+	  data as a standard tty protocol. I3C provide relatively higher data
+	  transfer rate and less pin numbers, SDA/SCL are shared with other
+	  devices.
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
index 0000000000000..e1e2a64b21863
--- /dev/null
+++ b/drivers/tty/i3c_tty.c
@@ -0,0 +1,426 @@
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
+#define I3C_TTY_MINORS		8
+#define I3C_TTY_TRANS_SIZE	16
+#define I3C_TTY_RX_STOP		0
+#define I3C_TTY_RETRY		20
+#define I3C_TTY_YIELD_US	100
+
+struct ttyi3c_port {
+	struct tty_port port;
+	int minor;
+	spinlock_t xlock; /* protect xmit */
+	u8 tx_buff[I3C_TTY_TRANS_SIZE];
+	u8 rx_buff[I3C_TTY_TRANS_SIZE];
+	struct i3c_device *i3cdev;
+	struct work_struct txwork;
+	struct work_struct rxwork;
+	struct completion txcomplete;
+	unsigned long status;
+	u32 buf_overrun;
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
+	int ret;
+
+	ret = tty_port_alloc_xmit_buf(port);
+	if (ret < 0)
+		return ret;
+
+	sport->status = 0;
+
+	ret = i3c_device_enable_ibi(sport->i3cdev);
+	if (ret) {
+		tty_port_free_xmit_buf(port);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void i3c_port_shutdown(struct tty_port *port)
+{
+	struct ttyi3c_port *sport =
+		container_of(port, struct ttyi3c_port, port);
+
+	i3c_device_disable_ibi(sport->i3cdev);
+	tty_port_free_xmit_buf(port);
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
+static ssize_t i3c_write(struct tty_struct *tty, const unsigned char *buf, size_t count)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+	unsigned long flags;
+	bool is_empty;
+	int ret;
+
+	spin_lock_irqsave(&sport->xlock, flags);
+	ret = kfifo_in(&sport->port.xmit_fifo, buf, count);
+	is_empty = kfifo_is_empty(&sport->port.xmit_fifo);
+	spin_unlock_irqrestore(&sport->xlock, flags);
+
+	if (!is_empty)
+		queue_work(system_unbound_wq, &sport->txwork);
+
+	return ret;
+}
+
+static int i3c_put_char(struct tty_struct *tty, unsigned char ch)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+	unsigned long flags;
+	int ret;
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
+
+	queue_work(system_unbound_wq, &sport->txwork);
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
+	clear_bit(I3C_TTY_RX_STOP, &sport->status);
+}
+
+static void i3c_unthrottle(struct tty_struct *tty)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+
+	set_bit(I3C_TTY_RX_STOP, &sport->status);
+
+	queue_work(system_unbound_wq, &sport->rxwork);
+}
+
+static int i3c_open(struct tty_struct *tty, struct file *filp)
+{
+	struct ttyi3c_port *sport = container_of(tty->port, struct ttyi3c_port, port);
+
+	tty->driver_data = sport;
+
+	return tty_port_open(&sport->port, tty, filp);
+}
+
+static void i3c_close(struct tty_struct *tty, struct file *filp)
+{
+	tty_port_close(tty->port, tty, filp);
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
+};
+
+static void i3c_controller_irq_handler(struct i3c_device *dev,
+				       const struct i3c_ibi_payload *payload)
+{
+	struct ttyi3c_port *sport = dev_get_drvdata(&dev->dev);
+
+	/* i3c_unthrottle also queue the work to fetch pending data in target side */
+	queue_work(system_unbound_wq, &sport->rxwork);
+}
+
+static void tty_i3c_rxwork(struct work_struct *work)
+{
+	struct ttyi3c_port *sport = container_of(work, struct ttyi3c_port, rxwork);
+	struct i3c_priv_xfer xfers;
+	u32 retry = I3C_TTY_RETRY;
+	u16 status = BIT(0);
+	int ret;
+
+	memset(&xfers, 0, sizeof(xfers));
+	xfers.data.in = sport->rx_buff;
+	xfers.len = I3C_TTY_TRANS_SIZE;
+	xfers.rnw = 1;
+
+	do {
+		if (test_bit(I3C_TTY_RX_STOP, &sport->status))
+			break;
+
+		i3c_device_do_priv_xfers(sport->i3cdev, &xfers, 1);
+
+		if (xfers.actual_len) {
+			ret = tty_insert_flip_string(&sport->port, sport->rx_buff,
+						     xfers.actual_len);
+			if (ret < xfers.actual_len)
+				sport->buf_overrun++;
+
+			retry = I3C_TTY_RETRY;
+			continue;
+		}
+
+		status = BIT(0);
+		i3c_device_getstatus_format1(sport->i3cdev, &status);
+		/*
+		 * Target side needs some time to fill data into fifo. Target side may not
+		 * have hardware update status in real time. Software update status always
+		 * needs some delays.
+		 *
+		 * Generally, target side have circular buffer in memory, it will be moved
+		 * into FIFO by CPU or DMA. 'status' just show if circular buffer empty. But
+		 * there are gap, especially CPU have not response irq to fill FIFO in time.
+		 * So xfers.actual will be zero, wait for little time to avoid flood
+		 * transfer in i3c bus.
+		 */
+		usleep_range(I3C_TTY_YIELD_US, 10 * I3C_TTY_YIELD_US);
+		retry--;
+
+	} while (retry && (status & BIT(0)));
+
+	tty_flip_buffer_push(&sport->port);
+}
+
+static void tty_i3c_txwork(struct work_struct *work)
+{
+	struct ttyi3c_port *sport = container_of(work, struct ttyi3c_port, txwork);
+	struct i3c_priv_xfer xfers;
+	u32 retry = I3C_TTY_RETRY;
+	unsigned long flags;
+	int ret;
+
+	xfers.rnw = 0;
+	xfers.data.out = sport->tx_buff;
+
+	while (!kfifo_is_empty(&sport->port.xmit_fifo)) {
+		spin_lock_irqsave(&sport->xlock, flags);
+		xfers.len = kfifo_out_peek(&sport->port.xmit_fifo, sport->tx_buff,
+					   I3C_TTY_TRANS_SIZE);
+		spin_unlock_irqrestore(&sport->xlock, flags);
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
+			retry = I3C_TTY_RETRY;
+		}
+
+		if (ret == 0 || retry == 0) {
+			/* when retry == 0, means need discard the data */
+			spin_lock_irqsave(&sport->xlock, flags);
+			ret = kfifo_out(&sport->port.xmit_fifo, sport->tx_buff, xfers.len);
+			spin_unlock_irqrestore(&sport->xlock, flags);
+		}
+	}
+
+	spin_lock_irqsave(&sport->xlock, flags);
+	if (kfifo_len(&sport->port.xmit_fifo) < WAKEUP_CHARS)
+		tty_port_tty_wakeup(&sport->port);
+	spin_unlock_irqrestore(&sport->xlock, flags);
+}
+
+static int i3c_probe(struct i3c_device *i3cdev)
+{
+	struct ttyi3c_port *sport;
+	struct device *tty_dev;
+	struct i3c_ibi_setup req;
+	int minor;
+	int ret;
+
+	sport = devm_kzalloc(&i3cdev->dev, sizeof(*sport), GFP_KERNEL);
+	if (!sport)
+		return -ENOMEM;
+
+	sport->i3cdev = i3cdev;
+
+	dev_set_drvdata(&i3cdev->dev, sport);
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
+	minor = idr_alloc(&i3c_tty_minors, sport, 0, I3C_TTY_MINORS, GFP_KERNEL);
+	mutex_unlock(&i3c_tty_minors_lock);
+
+	if (minor < 0) {
+		ret = -EINVAL;
+		goto err_idr_alloc;
+	}
+
+	spin_lock_init(&sport->xlock);
+	INIT_WORK(&sport->txwork, tty_i3c_txwork);
+	INIT_WORK(&sport->rxwork, tty_i3c_rxwork);
+	init_completion(&sport->txcomplete);
+
+	tty_port_init(&sport->port);
+	sport->port.ops = &i3c_port_ops;
+
+	tty_dev = tty_port_register_device(&sport->port, i3c_tty_driver, minor,
+					   &i3cdev->dev);
+	if (IS_ERR(tty_dev)) {
+		ret = PTR_ERR(tty_dev);
+		goto err_tty_port_register;
+	}
+
+	sport->minor = minor;
+
+	return 0;
+
+err_tty_port_register:
+	tty_port_put(&sport->port);
+
+	mutex_lock(&i3c_tty_minors_lock);
+	idr_remove(&i3c_tty_minors, minor);
+	mutex_unlock(&i3c_tty_minors_lock);
+
+err_idr_alloc:
+	i3c_device_free_ibi(i3cdev);
+
+	return ret;
+}
+
+void i3c_remove(struct i3c_device *dev)
+{
+	struct ttyi3c_port *sport = dev_get_drvdata(&dev->dev);
+
+	tty_port_unregister_device(&sport->port, i3c_tty_driver, sport->minor);
+	cancel_work_sync(&sport->txwork);
+
+	tty_port_put(&sport->port);
+
+	mutex_lock(&i3c_tty_minors_lock);
+	idr_remove(&i3c_tty_minors, sport->minor);
+	mutex_unlock(&i3c_tty_minors_lock);
+
+	i3c_device_free_ibi(sport->i3cdev);
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
+	if (ret)
+		goto err_tty_register_driver;
+
+	ret = i3c_driver_register(&i3c_driver);
+	if (ret)
+		goto err_i3c_driver_register;
+
+	return 0;
+
+err_i3c_driver_register:
+	tty_unregister_driver(i3c_tty_driver);
+
+err_tty_register_driver:
+	tty_driver_kref_put(i3c_tty_driver);
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


