Return-Path: <linux-kernel+bounces-153728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 696FC8AD266
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20E0728242A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7F91552E5;
	Mon, 22 Apr 2024 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CemZJokq"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0217C154C12;
	Mon, 22 Apr 2024 16:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713804077; cv=none; b=h1Rkkkhtzosle4PPO65sv5CcE0MR25q2+ShSu5f8vRa4z+bbDXOuWgT5vJZCM/k3aZVtDGmD7Vk8n136kXNUCNOIZeWfT2xKCNJUHtEDxZ1O3pDjiGbk0g8+C3i1igV2fCahaO1lvGDr++BCFm7nTqpwb9pPBsBuUwIy4X8Ol14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713804077; c=relaxed/simple;
	bh=PHJB2W4F+zF9rniZKNPZdogMOvun2Jeka65k9pyMFl8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oXL1mQVGq2KwVyx28YGZHX0PZ4UN6aGnYXAasvscMObmB4bmukiY/fgsdePjVNfxbaP6qiBZcKAsQ7SBjHR7iwDRMMHVW/EaLIA32xDdoYYaEqThU9EOeWJUUwpOTMbWnwj2IqJrSjGKvt2SgmbeR/Iy95ZTn7Wd4E/GqdnY3ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CemZJokq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43MEQwCX013739;
	Mon, 22 Apr 2024 16:41:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=yxgrCDiCVcCYMUqbE99to2LGxSl1iSqHfQeCGd5Pwf0=; b=Ce
	mZJokqCL+CpHiXdAZE8nY7Ia9g3htezHYiz0kTXzIBabQyJpTawfJx00GCK/R7UU
	i2HvsZATm0vTnwqqxeUPmWcw8Q9Vzw7amvLBpXtq3Dqju2jcj5ZmsXjYYIn7FqCG
	T8at4Ir69JtAExp3eGO93XMYUDKe7C5Q+MOSrhIKhoSwpTp1IozKyIZstJ69Uemz
	sXOvcDZxWJ1zKSPj5OIf9r3AuYRxAk/3W+ogn1malknwkCib69ciM982uHMz7bRY
	f0IvDpg30YjlKg8EX0jCs4Mnioh5UpKtrWUgSx1oc7YxNVFpD3Ux/F1PaAi5W6iG
	MnxZgII7FUQUaxHsiP0w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xm4qdd41k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 16:41:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43MGf7Pj021856
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 16:41:07 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 22 Apr 2024 09:41:01 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jassisinghbrar@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <dmitry.baryshkov@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_rgottimu@quicinc.com>,
        <quic_kshivnan@quicinc.com>, <quic_sibis@quicinc.com>,
        <conor+dt@kernel.org>, <quic_gkohli@quicinc.com>,
        <quic_nkela@quicinc.com>, <quic_psodagud@quicinc.com>,
        <abel.vesa@linaro.org>
Subject: [PATCH V4 2/5] mailbox: Add support for QTI CPUCP mailbox controller
Date: Mon, 22 Apr 2024 22:10:32 +0530
Message-ID: <20240422164035.1045501-3-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240422164035.1045501-1-quic_sibis@quicinc.com>
References: <20240422164035.1045501-1-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rd6yQa2tsmg14YYr3MzUMWVo2c86_l6M
X-Proofpoint-ORIG-GUID: rd6yQa2tsmg14YYr3MzUMWVo2c86_l6M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220070

Add support for CPUSS Control Processor (CPUCP) mailbox controller,
this driver enables communication between AP and CPUCP by acting as
a doorbell between them.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

V3:
* Fix copyright info in cpucp driver. [Bjorn]
* Drop unused APSS_CPUCP_TX_MBOX_IDR, value init and drv_data. [Bjorn/Dmitry]
* Convert to lower case hex. [Bjorn]
* Convert irq and dev to local variables. [Bjorn]
* Replace for and if with for_each_set_bit. [Bjorn]
* Document the need for spinlock. [Bjorn]
* Add space after " for aesthetics. [Bjorn]
* Include io.h and re-order platform_device.h
* Use GENMASK_ULL to generate APSS_CPUCP_RX_MBOX_CMD_MASK.
* Pick Rb.

 drivers/mailbox/Kconfig           |   8 ++
 drivers/mailbox/Makefile          |   2 +
 drivers/mailbox/qcom-cpucp-mbox.c | 179 ++++++++++++++++++++++++++++++
 3 files changed, 189 insertions(+)
 create mode 100644 drivers/mailbox/qcom-cpucp-mbox.c

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 42940108a187..23741a6f054e 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -273,6 +273,14 @@ config SPRD_MBOX
 	  to send message between application processors and MCU. Say Y here if
 	  you want to build the Spreatrum mailbox controller driver.
 
+config QCOM_CPUCP_MBOX
+	tristate "Qualcomm Technologies, Inc. CPUCP mailbox driver"
+	depends on ARCH_QCOM || COMPILE_TEST
+	help
+	  Qualcomm Technologies, Inc. CPUSS Control Processor (CPUCP) mailbox
+	  controller driver enables communication between AP and CPUCP. Say
+	  Y here if you want to build this driver.
+
 config QCOM_IPCC
 	tristate "Qualcomm Technologies, Inc. IPCC driver"
 	depends on ARCH_QCOM || COMPILE_TEST
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index 18793e6caa2f..53b512800bde 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -59,4 +59,6 @@ obj-$(CONFIG_SUN6I_MSGBOX)	+= sun6i-msgbox.o
 
 obj-$(CONFIG_SPRD_MBOX)		+= sprd-mailbox.o
 
+obj-$(CONFIG_QCOM_CPUCP_MBOX)	+= qcom-cpucp-mbox.o
+
 obj-$(CONFIG_QCOM_IPCC)		+= qcom-ipcc.o
diff --git a/drivers/mailbox/qcom-cpucp-mbox.c b/drivers/mailbox/qcom-cpucp-mbox.c
new file mode 100644
index 000000000000..78d0872a0e33
--- /dev/null
+++ b/drivers/mailbox/qcom-cpucp-mbox.c
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/bitops.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/mailbox_controller.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#define APSS_CPUCP_IPC_CHAN_SUPPORTED		3
+#define APSS_CPUCP_MBOX_CMD_OFF			0x4
+
+/* Tx Registers */
+#define APSS_CPUCP_TX_MBOX_CMD(i)		(0x100 + ((i) * 8))
+
+/* Rx Registers */
+#define APSS_CPUCP_RX_MBOX_CMD(i)		(0x100 + ((i) * 8))
+#define APSS_CPUCP_RX_MBOX_MAP			0x4000
+#define APSS_CPUCP_RX_MBOX_STAT			0x4400
+#define APSS_CPUCP_RX_MBOX_CLEAR		0x4800
+#define APSS_CPUCP_RX_MBOX_EN			0x4c00
+#define APSS_CPUCP_RX_MBOX_CMD_MASK		GENMASK_ULL(63, 0)
+
+/**
+ * struct qcom_cpucp_mbox - Holder for the mailbox driver
+ * @chans:			The mailbox channel
+ * @mbox:			The mailbox controller
+ * @tx_base:			Base address of the CPUCP tx registers
+ * @rx_base:			Base address of the CPUCP rx registers
+ */
+struct qcom_cpucp_mbox {
+	struct mbox_chan chans[APSS_CPUCP_IPC_CHAN_SUPPORTED];
+	struct mbox_controller mbox;
+	void __iomem *tx_base;
+	void __iomem *rx_base;
+};
+
+static inline int channel_number(struct mbox_chan *chan)
+{
+	return chan - chan->mbox->chans;
+}
+
+static irqreturn_t qcom_cpucp_mbox_irq_fn(int irq, void *data)
+{
+	struct qcom_cpucp_mbox *cpucp = data;
+	struct mbox_chan *chan;
+	unsigned long flags;
+	u64 status;
+	u32 val;
+	int i;
+
+	status = readq(cpucp->rx_base + APSS_CPUCP_RX_MBOX_STAT);
+
+	for_each_set_bit(i, (unsigned long *)&status, APSS_CPUCP_IPC_CHAN_SUPPORTED) {
+		val = readl(cpucp->rx_base + APSS_CPUCP_RX_MBOX_CMD(i) + APSS_CPUCP_MBOX_CMD_OFF);
+		chan = &cpucp->chans[i];
+		/* Provide mutual exclusion with changes to chan->cl */
+		spin_lock_irqsave(&chan->lock, flags);
+		if (chan->cl)
+			mbox_chan_received_data(chan, &val);
+		writeq(BIT(i), cpucp->rx_base + APSS_CPUCP_RX_MBOX_CLEAR);
+		spin_unlock_irqrestore(&chan->lock, flags);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int qcom_cpucp_mbox_startup(struct mbox_chan *chan)
+{
+	struct qcom_cpucp_mbox *cpucp = container_of(chan->mbox, struct qcom_cpucp_mbox, mbox);
+	unsigned long chan_id = channel_number(chan);
+	u64 val;
+
+	val = readq(cpucp->rx_base + APSS_CPUCP_RX_MBOX_EN);
+	val |= BIT(chan_id);
+	writeq(val, cpucp->rx_base + APSS_CPUCP_RX_MBOX_EN);
+
+	return 0;
+}
+
+static void qcom_cpucp_mbox_shutdown(struct mbox_chan *chan)
+{
+	struct qcom_cpucp_mbox *cpucp = container_of(chan->mbox, struct qcom_cpucp_mbox, mbox);
+	unsigned long chan_id = channel_number(chan);
+	u64 val;
+
+	val = readq(cpucp->rx_base + APSS_CPUCP_RX_MBOX_EN);
+	val &= ~BIT(chan_id);
+	writeq(val, cpucp->rx_base + APSS_CPUCP_RX_MBOX_EN);
+}
+
+static int qcom_cpucp_mbox_send_data(struct mbox_chan *chan, void *data)
+{
+	struct qcom_cpucp_mbox *cpucp = container_of(chan->mbox, struct qcom_cpucp_mbox, mbox);
+	unsigned long chan_id = channel_number(chan);
+	u32 *val = data;
+
+	writel(*val, cpucp->tx_base + APSS_CPUCP_TX_MBOX_CMD(chan_id) + APSS_CPUCP_MBOX_CMD_OFF);
+
+	return 0;
+}
+
+static const struct mbox_chan_ops qcom_cpucp_mbox_chan_ops = {
+	.startup = qcom_cpucp_mbox_startup,
+	.send_data = qcom_cpucp_mbox_send_data,
+	.shutdown = qcom_cpucp_mbox_shutdown
+};
+
+static int qcom_cpucp_mbox_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct qcom_cpucp_mbox *cpucp;
+	struct mbox_controller *mbox;
+	int irq, ret;
+
+	cpucp = devm_kzalloc(dev, sizeof(*cpucp), GFP_KERNEL);
+	if (!cpucp)
+		return -ENOMEM;
+
+	cpucp->rx_base = devm_of_iomap(dev, dev->of_node, 0, NULL);
+	if (IS_ERR(cpucp->rx_base))
+		return PTR_ERR(cpucp->rx_base);
+
+	cpucp->tx_base = devm_of_iomap(dev, dev->of_node, 1, NULL);
+	if (IS_ERR(cpucp->tx_base))
+		return PTR_ERR(cpucp->tx_base);
+
+	writeq(0, cpucp->rx_base + APSS_CPUCP_RX_MBOX_EN);
+	writeq(0, cpucp->rx_base + APSS_CPUCP_RX_MBOX_CLEAR);
+	writeq(0, cpucp->rx_base + APSS_CPUCP_RX_MBOX_MAP);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_irq(dev, irq, qcom_cpucp_mbox_irq_fn,
+			       IRQF_TRIGGER_HIGH, "apss_cpucp_mbox", cpucp);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to register irq: %d\n", irq);
+
+	writeq(APSS_CPUCP_RX_MBOX_CMD_MASK, cpucp->rx_base + APSS_CPUCP_RX_MBOX_MAP);
+
+	mbox = &cpucp->mbox;
+	mbox->dev = dev;
+	mbox->num_chans = APSS_CPUCP_IPC_CHAN_SUPPORTED;
+	mbox->chans = cpucp->chans;
+	mbox->ops = &qcom_cpucp_mbox_chan_ops;
+	mbox->txdone_irq = false;
+	mbox->txdone_poll = false;
+
+	ret = devm_mbox_controller_register(dev, mbox);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to create mailbox\n");
+
+	return 0;
+}
+
+static const struct of_device_id qcom_cpucp_mbox_of_match[] = {
+	{ .compatible = "qcom,x1e80100-cpucp-mbox" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, qcom_cpucp_mbox_of_match);
+
+static struct platform_driver qcom_cpucp_mbox_driver = {
+	.probe = qcom_cpucp_mbox_probe,
+	.driver = {
+		.name = "qcom_cpucp_mbox",
+		.of_match_table = qcom_cpucp_mbox_of_match,
+	},
+};
+module_platform_driver(qcom_cpucp_mbox_driver);
+
+MODULE_DESCRIPTION("QTI CPUCP MBOX Driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1


