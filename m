Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A2E80E8AD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 11:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbjLLKHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 05:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346161AbjLLKHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 05:07:19 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01rlnn2045.outbound.protection.outlook.com [40.95.54.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B639418B;
        Tue, 12 Dec 2023 02:07:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mYAN0XnCtcP4lG+zWRSb65b43Z1diNvMGOoXkLEKvXbJ2HrYnc1fQdnId0nGhg1T2RR34oS8NUGjgfuD/VWYQQfMUM2ScbLovRSmrj7SvdaCVapGSvK1W6zsJGycDNIvt3PckXy0kcOLcaFjV/s4FQqT+S69DHQKF0ekFsj9Kot+QILqGwJuM9xGyFgdgXfQBjuUcsqGr/A3TIWxIirob/gHM38kO18h1iMcTBnV1X66UHa2J+ZO6WMZ8PQ0aOw3x9LrH6Pv8w4Vwtea2X9c7L9+ItMcXCaSC4HPHfEE6NKEk3d3pM3bq96tSkaJJoGe95R72k2uUg4SUjumBjbUTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4foCvPDNVwDXo0EbsLQRBGehdzooLI7HpoDU0GsiPE=;
 b=Mm1/jQtcaalqtQDP/j0ZJR+gNo1UsbocbHVLJ2td89MrUJYCq+mRsjv1ISeHo4L+N286n1ehGvF1edy8tlqtTkMjIM1SDwY87FOiciDFQpaHd4JpunynsGjjBcbrzMHyv3sHd1V+SKgr/E3sx1QK/t2Qd29BKkZ1x6drggBEFvaCO+IHNYV/Y1RBHCnMpFnzozi/HnjSmFTJ4OJYWvh7BXOAIaQckTLMFm9qdRpptYHAH0qq6UajOmDCShfIPD/wsIoiS9uii3cHkRJ5LQi8rRhMKNfYj2gLdth3noUrn+W1kCkjt/sjiBTQWxg7sUOiqZZQqFhXEk7eGKdtNyUHwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 211.75.126.7) smtp.rcpttodomain=arndb.de smtp.mailfrom=gmail.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4foCvPDNVwDXo0EbsLQRBGehdzooLI7HpoDU0GsiPE=;
 b=uVZoIwvHgjBe0S4vw0Fow5EftxTXPw5zqKrVr0NuPqY2Ds7sIzsrgUklH+ySMvFN0uW+HRQgnWNYm8wvt8DOzNM6b599J2ZIPWJKZZGL327KgrvHn68dsSQmDZkHzRRHH901KEgiIVTdsW9s87DAowqTl2syGTJUf3yZAvVBpWY=
Received: from SG2PR04CA0203.apcprd04.prod.outlook.com (2603:1096:4:187::22)
 by SEZPR03MB8894.apcprd03.prod.outlook.com (2603:1096:101:252::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 10:07:12 +0000
Received: from SG1PEPF000082E6.apcprd02.prod.outlook.com
 (2603:1096:4:187:cafe::c9) by SG2PR04CA0203.outlook.office365.com
 (2603:1096:4:187::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33 via Frontend
 Transport; Tue, 12 Dec 2023 10:07:12 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 211.75.126.7)
 smtp.mailfrom=gmail.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 211.75.126.7 as permitted sender)
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 SG1PEPF000082E6.mail.protection.outlook.com (10.167.240.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Tue, 12 Dec 2023 10:07:11 +0000
Received: from NTHCCAS02.nuvoton.com (10.1.9.121) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 12 Dec
 2023 18:07:10 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Tue, 12 Dec
 2023 18:07:10 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 12 Dec 2023 18:07:09 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
        by taln58.nuvoton.co.il (Postfix) with ESMTP id 307205F5D9;
        Tue, 12 Dec 2023 12:07:09 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <arnd@arndb.de>, <pmenzel@molgen.mpg.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <j.neuschaefer@gmx.net>
CC:     <openbmc@lists.ozlabs.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v2 3/3] soc: nuvoton: add NPCM BPC driver
Date:   Tue, 12 Dec 2023 12:07:03 +0200
Message-ID: <20231212100703.3374555-4-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212100703.3374555-1-tmaimon77@gmail.com>
References: <20231212100703.3374555-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: ip=[211.75.126.7];domain=NTHCCAS01.nuvoton.com
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E6:EE_|SEZPR03MB8894:EE_
X-MS-Office365-Filtering-Correlation-Id: 65485c7b-91c8-43c1-8da1-08dbfafa1b95
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0HylM7X7cTdPAfkELZ56Lo26Y9+tFzLE7ZEIrGIReB7AAbQESu4M1vq28cgWTiIHVDSMkSVl5iZxgoVq5dxN9jIp3k4yXetz9Xf2Qnm9inIqAhuGKRgF8ZT7hCmb+t/B5xEKgBbvfrm7+LnqXp99lpoNxNxNAzUTA9PnhwyMLKJ35VTYNreVpzPR886wDWuL/2JleVA1V9bZztYT/V438VI1sCUQTChjbL2TEfE3Cl4QHdo8eOzKPpNZvlxlRM0TV86Bi4tHCa/1/+dJ+WGLUuHCZY+IjP4FuKvT72E92L6SBNTdZwTHQjF3UhP2IaWv4UKVOAiXvNq04jsJCM1tNz/hXNaF/RO631zMlm21k2NUEaEblo41FZ0MfX1va4oZaY0bPp0vNjCJOf5dNlLrIKiXl1ShwNq/gfw4fGuUuPOpItcHFzUutPdpxg4BWRFuUjxghPxCU0UkrsgLn6bB6kitegeAroYH6dwwgQExhiHOXww7aYJv243x+QDLTxULVhnB5VPfvCGQCk40tv1uoooQ7KuO3Gf9Yzp2x1cklSkV5vw2xD9He/fM9dtakcNPGBh4sS5ZcdlAXTM+3jK9CQ31LiXUwLsQXXLfz2c8h+chT+EYwYLcDmmLoQ4pHWz7PxMttOwv/FDaw4eCvF+dF/z4ir4ohafnf6JkZmTGpdoECxpfcNNdsr5Y+sJX8fsq4Jb/dYTCU7qSbFpMM9SG4I7lryeGH23P0yikkpoFnAVE++D6c9daQLyFheEr7QV0rQRDUBR5EArgb1X8IqvqnT+9RdMEnLPKzu4Ph2RpkWTW4KlRc8HvGh2ZgTuFl6EM
X-Forefront-Antispam-Report: CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(82310400011)(451199024)(48200799006)(61400799012)(64100799003)(40470700004)(46966006)(40480700001)(6266002)(73392003)(336012)(26005)(82202003)(1076003)(2616005)(40460700003)(82740400003)(921008)(81166007)(55446002)(86362001)(356005)(36756003)(47076005)(30864003)(5660300002)(83380400001)(7416002)(498600001)(35950700001)(6666004)(70586007)(70206006)(316002)(110136005)(8936002)(8676002)(54906003)(41300700001)(4326008)(2906002)(76482006);DIR:OUT;SFP:1022;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 10:07:11.3048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65485c7b-91c8-43c1-8da1-08dbfafa1b95
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E6.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8894
X-Spam-Status: No, score=2.9 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,PDS_HELO_SPF_FAIL,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_FAIL,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Nuvoton BMC NPCM BIOS post code (BPC) driver.

The NPCM BPC monitoring two configurable I/O address written by the host
on the bus.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 drivers/soc/nuvoton/Kconfig    |   9 +
 drivers/soc/nuvoton/Makefile   |   1 +
 drivers/soc/nuvoton/npcm-bpc.c | 388 +++++++++++++++++++++++++++++++++
 3 files changed, 398 insertions(+)
 create mode 100644 drivers/soc/nuvoton/npcm-bpc.c

diff --git a/drivers/soc/nuvoton/Kconfig b/drivers/soc/nuvoton/Kconfig
index d5102f5f0c28..ebd162633942 100644
--- a/drivers/soc/nuvoton/Kconfig
+++ b/drivers/soc/nuvoton/Kconfig
@@ -2,6 +2,15 @@
 
 menu "NUVOTON SoC drivers"
 
+config NPCM_BPC
+	tristate "NPCM BIOS Post Code support"
+	depends on (ARCH_NPCM || COMPILE_TEST)
+	help
+	  Provides NPCM driver to control the BIOS Post Code
+	  interface which allows the BMC to monitor and save
+	  the data written by the host to an arbitrary I/O port,
+	  the BPC is connected to the host thourgh LPC or eSPI bus.
+
 config WPCM450_SOC
 	tristate "Nuvoton WPCM450 SoC driver"
 	default y if ARCH_WPCM450
diff --git a/drivers/soc/nuvoton/Makefile b/drivers/soc/nuvoton/Makefile
index e30317b4e829..c6c96079c6e9 100644
--- a/drivers/soc/nuvoton/Makefile
+++ b/drivers/soc/nuvoton/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_NPCM_BPC)		+= npcm-bpc.o
 obj-$(CONFIG_WPCM450_SOC)	+= wpcm450-soc.o
diff --git a/drivers/soc/nuvoton/npcm-bpc.c b/drivers/soc/nuvoton/npcm-bpc.c
new file mode 100644
index 000000000000..149b05f0ac77
--- /dev/null
+++ b/drivers/soc/nuvoton/npcm-bpc.c
@@ -0,0 +1,388 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2020 Nuvoton Technology corporation.
+
+#include <linux/fs.h>
+#include <linux/bitops.h>
+#include <linux/interrupt.h>
+#include <linux/kfifo.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/miscdevice.h>
+#include <linux/poll.h>
+
+#define DEVICE_NAME	"npcm-bpc"
+
+#define NUM_BPC_CHANNELS	2
+#define DW_PAD_SIZE		3
+
+/* BIOS POST Code FIFO Registers */
+#define NPCM_BPCFA2L_REG	0x2 //BIOS POST Code FIFO Address 2 LSB
+#define NPCM_BPCFA2M_REG	0x4 //BIOS POST Code FIFO Address 2 MSB
+#define NPCM_BPCFEN_REG		0x6 //BIOS POST Code FIFO Enable
+#define NPCM_BPCFSTAT_REG	0x8 //BIOS POST Code FIFO Status
+#define NPCM_BPCFDATA_REG	0xA //BIOS POST Code FIFO Data
+#define NPCM_BPCFMSTAT_REG	0xC //BIOS POST Code FIFO Miscellaneous Status
+#define NPCM_BPCFA1L_REG	0x10 //BIOS POST Code FIFO Address 1 LSB
+#define NPCM_BPCFA1M_REG	0x12 //BIOS POST Code FIFO Address 1 MSB
+
+/* BIOS register data */
+#define FIFO_IOADDR1_ENABLE	0x80
+#define FIFO_IOADDR2_ENABLE	0x40
+
+/* BPC interface package and structure definition */
+#define BPC_KFIFO_SIZE		0x400
+
+/* BPC register data */
+#define FIFO_DATA_VALID		0x80
+#define FIFO_OVERFLOW		0x20
+#define FIFO_READY_INT_ENABLE	0x8
+#define FIFO_DWCAPTURE		0x4
+#define FIFO_ADDR_DECODE	0x1
+
+/* Host Reset */
+#define HOST_RESET_INT_ENABLE	0x10
+#define HOST_RESET_CHANGED	0x40
+
+struct npcm_bpc_channel {
+	struct npcm_bpc	*data;
+	struct kfifo		fifo;
+	wait_queue_head_t	wq;
+	bool			host_reset;
+	struct miscdevice	miscdev;
+};
+
+struct npcm_bpc {
+	void __iomem		*base;
+	struct device		*dev;
+	int			irq;
+	bool			en_dwcap;
+	struct npcm_bpc_channel	ch[NUM_BPC_CHANNELS];
+};
+
+static struct npcm_bpc_channel *npcm_file_to_ch(struct file *file)
+{
+	return container_of(file->private_data, struct npcm_bpc_channel,
+			    miscdev);
+}
+
+static ssize_t npcm_bpc_read(struct file *file, char __user *buffer,
+			     size_t count, loff_t *ppos)
+{
+	struct npcm_bpc_channel *chan = npcm_file_to_ch(file);
+	struct npcm_bpc *bpc = chan->data;
+	unsigned int copied;
+	int cond_size = 1;
+	int ret = 0;
+
+	if (bpc->en_dwcap)
+		cond_size = 3;
+
+	if (kfifo_len(&chan->fifo) < cond_size) {
+		if (file->f_flags & O_NONBLOCK)
+			return -EAGAIN;
+
+		ret = wait_event_interruptible
+			(chan->wq, kfifo_len(&chan->fifo) > cond_size);
+		if (ret == -ERESTARTSYS)
+			return -EINTR;
+	}
+
+	ret = kfifo_to_user(&chan->fifo, buffer, count, &copied);
+
+	return ret ? ret : copied;
+}
+
+static __poll_t npcm_bpc_poll(struct file *file, struct poll_table_struct *pt)
+{
+	struct npcm_bpc_channel *chan = npcm_file_to_ch(file);
+	__poll_t mask = 0;
+
+	poll_wait(file, &chan->wq, pt);
+	if (!kfifo_is_empty(&chan->fifo))
+		mask |= POLLIN;
+
+	if (chan->host_reset) {
+		mask |= POLLHUP;
+		chan->host_reset = false;
+	}
+
+	return mask;
+}
+
+static const struct file_operations npcm_bpc_fops = {
+	.owner		= THIS_MODULE,
+	.read		= npcm_bpc_read,
+	.poll		= npcm_bpc_poll,
+	.llseek		= noop_llseek,
+};
+
+static irqreturn_t npcm_bpc_irq(int irq, void *arg)
+{
+	struct npcm_bpc *bpc = arg;
+	u8 fifo_st, host_st, data;
+	bool isr_flag = false;
+	u8 last_addr_bit = 0;
+	u8 padzero[3] = {0};
+	u8 addr_index = 0;
+
+	fifo_st = ioread8(bpc->base + NPCM_BPCFSTAT_REG);
+	while (FIFO_DATA_VALID & fifo_st) {
+		 /* If dwcapture enabled only channel 0 (FIFO 0) used */
+		if (!bpc->en_dwcap)
+			addr_index = fifo_st & FIFO_ADDR_DECODE;
+		else
+			last_addr_bit = fifo_st & FIFO_ADDR_DECODE;
+
+		/* Read data from FIFO to clear interrupt */
+		data = ioread8(bpc->base + NPCM_BPCFDATA_REG);
+		if (kfifo_is_full(&bpc->ch[addr_index].fifo))
+			kfifo_skip(&bpc->ch[addr_index].fifo);
+		kfifo_put(&bpc->ch[addr_index].fifo, data);
+		if (fifo_st & FIFO_OVERFLOW)
+			dev_warn(bpc->dev, "BIOS Post Codes FIFO Overflow\n");
+
+		fifo_st = ioread8(bpc->base + NPCM_BPCFSTAT_REG);
+		if (bpc->en_dwcap && last_addr_bit) {
+			if ((fifo_st & FIFO_ADDR_DECODE) ||
+			    ((FIFO_DATA_VALID & fifo_st) == 0)) {
+				while (kfifo_avail(&bpc->ch[addr_index].fifo) < DW_PAD_SIZE)
+					kfifo_skip(&bpc->ch[addr_index].fifo);
+				kfifo_in(&bpc->ch[addr_index].fifo,
+					 padzero, DW_PAD_SIZE);
+			}
+		}
+		isr_flag = true;
+	}
+
+	host_st = ioread8(bpc->base + NPCM_BPCFMSTAT_REG);
+	if (host_st & HOST_RESET_CHANGED) {
+		iowrite8(HOST_RESET_CHANGED,
+			 bpc->base + NPCM_BPCFMSTAT_REG);
+		bpc->ch[addr_index].host_reset = true;
+		isr_flag = true;
+	}
+
+	if (isr_flag) {
+		wake_up_interruptible(&bpc->ch[addr_index].wq);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+static int npcm_bpc_config_irq(struct npcm_bpc *bpc,
+			       struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	int rc;
+
+	bpc->irq = platform_get_irq(pdev, 0);
+	if (bpc->irq < 0) {
+		dev_err(dev, "get IRQ failed\n");
+		return bpc->irq;
+	}
+
+	rc = devm_request_irq(dev, bpc->irq,
+			      npcm_bpc_irq, IRQF_SHARED,
+			      DEVICE_NAME, bpc);
+	if (rc < 0) {
+		dev_warn(dev, "Unable to request IRQ %d\n", bpc->irq);
+		return rc;
+	}
+
+	return 0;
+}
+
+static int npcm_enable_bpc(struct npcm_bpc *bpc, struct device *dev,
+			   int channel, u16 host_port)
+{
+	u8 addr_en, reg_en;
+	int err;
+
+	init_waitqueue_head(&bpc->ch[channel].wq);
+
+	err = kfifo_alloc(&bpc->ch[channel].fifo, BPC_KFIFO_SIZE,
+			  GFP_KERNEL);
+	if (err)
+		return err;
+
+	bpc->ch[channel].miscdev.minor = MISC_DYNAMIC_MINOR;
+	bpc->ch[channel].miscdev.name =
+		devm_kasprintf(dev, GFP_KERNEL, "%s%d", DEVICE_NAME, channel);
+	bpc->ch[channel].miscdev.fops = &npcm_bpc_fops;
+	bpc->ch[channel].miscdev.parent = dev;
+	err = misc_register(&bpc->ch[channel].miscdev);
+	if (err)
+		return err;
+
+	bpc->ch[channel].data = bpc;
+	bpc->ch[channel].host_reset = false;
+
+	/* Enable host snoop channel at requested port */
+	switch (channel) {
+	case 0:
+		addr_en = FIFO_IOADDR1_ENABLE;
+		iowrite8((u8)host_port & 0xFF,
+			 bpc->base + NPCM_BPCFA1L_REG);
+		iowrite8((u8)(host_port >> 8),
+			 bpc->base + NPCM_BPCFA1M_REG);
+		break;
+	case 1:
+		addr_en = FIFO_IOADDR2_ENABLE;
+		iowrite8((u8)host_port & 0xFF,
+			 bpc->base + NPCM_BPCFA2L_REG);
+		iowrite8((u8)(host_port >> 8),
+			 bpc->base + NPCM_BPCFA2M_REG);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (bpc->en_dwcap)
+		addr_en = FIFO_DWCAPTURE;
+
+	/*
+	 * Enable FIFO Ready Interrupt, FIFO Capture of I/O addr,
+	 * and Host Reset
+	 */
+	reg_en = ioread8(bpc->base + NPCM_BPCFEN_REG);
+	iowrite8(reg_en | addr_en | FIFO_READY_INT_ENABLE |
+		 HOST_RESET_INT_ENABLE, bpc->base + NPCM_BPCFEN_REG);
+
+	return 0;
+}
+
+static void npcm_disable_bpc(struct npcm_bpc *bpc, int channel)
+{
+	u8 reg_en;
+
+	switch (channel) {
+	case 0:
+		reg_en = ioread8(bpc->base + NPCM_BPCFEN_REG);
+		if (bpc->en_dwcap)
+			iowrite8(reg_en & ~FIFO_DWCAPTURE,
+				 bpc->base + NPCM_BPCFEN_REG);
+		else
+			iowrite8(reg_en & ~FIFO_IOADDR1_ENABLE,
+				 bpc->base + NPCM_BPCFEN_REG);
+		break;
+	case 1:
+		reg_en = ioread8(bpc->base + NPCM_BPCFEN_REG);
+		iowrite8(reg_en & ~FIFO_IOADDR2_ENABLE,
+			 bpc->base + NPCM_BPCFEN_REG);
+		break;
+	default:
+		return;
+	}
+
+	if (!(reg_en & (FIFO_IOADDR1_ENABLE | FIFO_IOADDR2_ENABLE)))
+		iowrite8(reg_en &
+			 ~(FIFO_READY_INT_ENABLE | HOST_RESET_INT_ENABLE),
+			 bpc->base + NPCM_BPCFEN_REG);
+
+	kfifo_free(&bpc->ch[channel].fifo);
+	misc_deregister(&bpc->ch[channel].miscdev);
+}
+
+static int npcm_bpc_probe(struct platform_device *pdev)
+{
+	struct npcm_bpc *bpc;
+	struct device *dev;
+	u32 port;
+	int err;
+
+	dev = &pdev->dev;
+
+	bpc = devm_kzalloc(dev, sizeof(*bpc), GFP_KERNEL);
+	if (!bpc)
+		return -ENOMEM;
+
+	bpc->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(bpc->base))
+		return PTR_ERR(bpc->base);
+
+	dev_set_drvdata(&pdev->dev, bpc);
+
+	err = of_property_read_u32_index(dev->of_node, "nuvoton,monitor-ports",
+					 0, &port);
+	if (err) {
+		dev_err(dev, "no monitor ports configured\n");
+		return -ENODEV;
+	}
+
+	bpc->en_dwcap =
+		of_property_read_bool(dev->of_node, "nuvoton,bpc-en-dwcapture");
+
+	bpc->dev = dev;
+
+	err = npcm_bpc_config_irq(bpc, pdev);
+	if (err)
+		return err;
+
+	err = npcm_enable_bpc(bpc, dev, 0, port);
+	if (err) {
+		dev_err(dev, "Enable BIOS post code I/O port 0 failed\n");
+		return err;
+	}
+
+	/*
+	 * Configuration of second BPC channel port is optional
+	 * Double-Word Capture ignoring address 2
+	 */
+	if (!bpc->en_dwcap) {
+		if (of_property_read_u32_index(dev->of_node,
+					       "nuvoton,monitor-ports", 1,
+					       &port) == 0) {
+			err = npcm_enable_bpc(bpc, dev, 1, port);
+			if (err) {
+				dev_err(dev, "Enable BIOS post code I/O port 1 failed, disable I/O port 0\n");
+				npcm_disable_bpc(bpc, 0);
+				return err;
+			}
+		}
+	}
+
+	pr_info("NPCM BIOS Post Code probe\n");
+
+	return err;
+}
+
+static int npcm_bpc_remove(struct platform_device *pdev)
+{
+	struct npcm_bpc *bpc = dev_get_drvdata(&pdev->dev);
+	u8 reg_en;
+
+	reg_en = ioread8(bpc->base + NPCM_BPCFEN_REG);
+
+	if (reg_en & FIFO_IOADDR1_ENABLE)
+		npcm_disable_bpc(bpc, 0);
+	if (reg_en & FIFO_IOADDR2_ENABLE)
+		npcm_disable_bpc(bpc, 1);
+
+	return 0;
+}
+
+static const struct of_device_id npcm_bpc_match[] = {
+	{ .compatible = "nuvoton,npcm750-bpc" },
+	{ .compatible = "nuvoton,npcm845-bpc" },
+	{ },
+};
+
+static struct platform_driver npcm_bpc_driver = {
+	.driver = {
+		.name		= DEVICE_NAME,
+		.of_match_table = npcm_bpc_match,
+	},
+	.probe = npcm_bpc_probe,
+	.remove = npcm_bpc_remove,
+};
+
+module_platform_driver(npcm_bpc_driver);
+
+MODULE_DEVICE_TABLE(of, npcm_bpc_match);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Tomer Maimon <tomer.maimon@nuvoton.com>");
+MODULE_DESCRIPTION("NPCM BIOS post code monitoring device driver");
-- 
2.34.1

