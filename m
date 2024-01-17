Return-Path: <linux-kernel+bounces-29279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5932C830C0B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D754B1F25F6D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7576723750;
	Wed, 17 Jan 2024 17:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KBheOyoz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20C1225D8;
	Wed, 17 Jan 2024 17:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705512940; cv=none; b=E7GYBv+1F5uljik6ItFQaMIcgCYzLMlSF6Wxdv1qcwaNkq7eC604fWkOaUnGKLZR7N7228TL2JmkB+4vWwQZ1INY5i/Os8qvWQeUFA3y1HMb43jsnDTIQ/bVDgYcEJzRP22tr1hmPjjpT4oag3SBwO4bm4wSmz1THL3XwrhUhpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705512940; c=relaxed/simple;
	bh=bVaRjVXvsKbN+ut9y5hYJWHMrNYeEbJznCfLiJefQqw=;
	h=Received:DKIM-Signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=X1iXmo+Ou5uskzgMFKYmJmTxQejeRZbxHTzC5fpUZmJRVQ91JmOdKbtZlL+cHLERHh2jCi/kMs461/H8RD8UMK+Ax3SHmh6nx+pIHWraVgZAzKKlxfTG1FdlYp9/Cds2Q0TCHlqYpHINyaY+/khFDkcLLzQ+i0Fe7tJ7S1guM0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KBheOyoz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40HAcSNv018222;
	Wed, 17 Jan 2024 17:35:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=TPK8T0PCXJl0wUiZEraT8oMcykbXFOqxE7qz3cyqbw0=; b=KB
	heOyozyS3E9wBBwWpeu/gyIJpEkruGZAmOBNur9kkrf1OKPum0GO586CMbyi3Hkj
	HtakT/Ock/ANTiVvQOnFqYUM7y5RxffyD2nLl9PEs9GwJJ4D5U7iW3XnC6TXCPKC
	W0wFekXOSozeryGwovsnAavHA7YqBQBZ/8F2mK6PwPate1VICbLHfNQ4Uj85faBn
	Y4h3+KMQ98wpwUyknr3LEb17LldI1Ofkp0VT8zODI0Bq9tNJ+alDXf0Ot2W4DKIc
	Fmfp6l7O8MKoxigydNujj9VzcXLqUo0O9Zc0pJ+Weozl4O4kBrnN+GHEVvKgKxhA
	33LZJz1OjvswfkyHRHNA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vp83fskmp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 17:35:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40HHZT8U011381
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 17:35:29 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 09:35:24 -0800
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jassisinghbrar@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_rgottimu@quicinc.com>,
        <quic_kshivnan@quicinc.com>, <quic_sibis@quicinc.com>,
        <conor+dt@kernel.org>
Subject: [RFC 2/7] mailbox: Add support for QTI CPUCP mailbox controller
Date: Wed, 17 Jan 2024 23:04:53 +0530
Message-ID: <20240117173458.2312669-3-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240117173458.2312669-1-quic_sibis@quicinc.com>
References: <20240117173458.2312669-1-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dgA7SeFflXYs9_1T1uykOwSjxRWIv3co
X-Proofpoint-GUID: dgA7SeFflXYs9_1T1uykOwSjxRWIv3co
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_10,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401170127

Add support for CPUSS Control Processor (CPUCP) mailbox controller,
this driver enables communication between AP and CPUCP by acting as
a doorbell between them.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 drivers/mailbox/Kconfig           |   8 +
 drivers/mailbox/Makefile          |   2 +
 drivers/mailbox/qcom-cpucp-mbox.c | 265 ++++++++++++++++++++++++++++++
 3 files changed, 275 insertions(+)
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
index 000000000000..22ea6c802286
--- /dev/null
+++ b/drivers/mailbox/qcom-cpucp-mbox.c
@@ -0,0 +1,265 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/platform_device.h>
+#include <linux/mailbox_controller.h>
+#include <linux/module.h>
+
+#define APSS_CPUCP_IPC_CHAN_SUPPORTED		3
+#define APSS_CPUCP_MBOX_CMD_OFF			0x4
+
+/* Tx Registers */
+#define APSS_CPUCP_TX_MBOX_IDR			0
+#define APSS_CPUCP_TX_MBOX_CMD			0x100
+
+/* Rx Registers */
+#define APSS_CPUCP_RX_MBOX_IDR			0
+#define APSS_CPUCP_RX_MBOX_CMD			0x100
+#define APSS_CPUCP_RX_MBOX_MAP			0x4000
+#define APSS_CPUCP_RX_MBOX_STAT			0x4400
+#define APSS_CPUCP_RX_MBOX_CLEAR		0x4800
+#define APSS_CPUCP_RX_MBOX_EN			0x4C00
+#define APSS_CPUCP_RX_MBOX_CMD_MASK		0xFFFFFFFFFFFFFFFF
+
+/**
+ * struct qcom_cpucp_mbox - Holder for the mailbox driver
+ * @chans:			The mailbox channel
+ * @mbox:			The mailbox controller
+ * @tx_base:			Base address of the CPUCP tx registers
+ * @rx_base:			Base address of the CPUCP rx registers
+ * @dev:			Device associated with this instance
+ * @irq:			CPUCP to AP irq
+ */
+struct qcom_cpucp_mbox {
+	struct mbox_chan chans[APSS_CPUCP_IPC_CHAN_SUPPORTED];
+	struct mbox_controller mbox;
+	void __iomem *tx_base;
+	void __iomem *rx_base;
+	struct device *dev;
+	int irq;
+	int num_chan;
+};
+
+static irqreturn_t qcom_cpucp_mbox_irq_fn(int irq, void *data)
+{
+	struct qcom_cpucp_mbox *cpucp = data;
+	u64 status;
+	u32 val;
+	int i;
+
+	status = readq(cpucp->rx_base + APSS_CPUCP_RX_MBOX_STAT);
+
+	for (i = 0; i < cpucp->num_chan; i++) {
+		val = 0;
+		if (status & ((u64)1 << i)) {
+			val = readl(cpucp->rx_base + APSS_CPUCP_RX_MBOX_CMD + (i * 8) + APSS_CPUCP_MBOX_CMD_OFF);
+			if (!IS_ERR(cpucp->chans[i].con_priv))
+				mbox_chan_received_data(&cpucp->chans[i], &val);
+			writeq(status, cpucp->rx_base + APSS_CPUCP_RX_MBOX_CLEAR);
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int qcom_cpucp_mbox_startup(struct mbox_chan *chan)
+{
+	struct qcom_cpucp_mbox *cpucp = container_of(chan->mbox, struct qcom_cpucp_mbox, mbox);
+	unsigned long chan_id = (unsigned long)chan->con_priv;
+	u64 val;
+
+	val = readq(cpucp->rx_base + APSS_CPUCP_RX_MBOX_EN);
+	val |= ((u64)1 << chan_id);
+	writeq(val, cpucp->rx_base + APSS_CPUCP_RX_MBOX_EN);
+
+	return 0;
+}
+
+static void qcom_cpucp_mbox_shutdown(struct mbox_chan *chan)
+{
+	struct qcom_cpucp_mbox *cpucp = container_of(chan->mbox, struct qcom_cpucp_mbox, mbox);
+	unsigned long chan_id = (unsigned long)chan->con_priv;
+	u64 val;
+
+	val = readq(cpucp->rx_base + APSS_CPUCP_RX_MBOX_EN);
+	val &= ~((u64)1 << chan_id);
+	writeq(val, cpucp->rx_base + APSS_CPUCP_RX_MBOX_EN);
+
+	chan->con_priv = ERR_PTR(-EINVAL);
+}
+
+static int qcom_cpucp_mbox_send_data(struct mbox_chan *chan, void *data)
+{
+	struct qcom_cpucp_mbox *cpucp = container_of(chan->mbox, struct qcom_cpucp_mbox, mbox);
+	unsigned long chan_id = (unsigned long)chan->con_priv;
+	u32 val = (unsigned long)data;
+
+	writel(val, cpucp->tx_base + APSS_CPUCP_TX_MBOX_CMD + (chan_id * 8) + APSS_CPUCP_MBOX_CMD_OFF);
+
+	return 0;
+}
+
+static struct mbox_chan *qcom_cpucp_mbox_xlate(struct mbox_controller *mbox,
+					       const struct of_phandle_args *sp)
+{
+	unsigned long ind = sp->args[0];
+
+	if (sp->args_count != 1)
+		return ERR_PTR(-EINVAL);
+
+	if (ind >= mbox->num_chans)
+		return ERR_PTR(-EINVAL);
+
+	if (!IS_ERR(mbox->chans[ind].con_priv))
+		return ERR_PTR(-EBUSY);
+
+	mbox->chans[ind].con_priv = (void *)ind;
+
+	return &mbox->chans[ind];
+}
+
+static const struct mbox_chan_ops qcom_cpucp_mbox_chan_ops = {
+	.startup = qcom_cpucp_mbox_startup,
+	.send_data = qcom_cpucp_mbox_send_data,
+	.shutdown = qcom_cpucp_mbox_shutdown
+};
+
+static int qcom_cpucp_setup_mbox(struct qcom_cpucp_mbox *cpucp)
+{
+	struct device *dev = cpucp->dev;
+	struct mbox_controller *mbox;
+	unsigned long i;
+
+	/* Initialize channel identifiers */
+	for (i = 0; i < ARRAY_SIZE(cpucp->chans); i++)
+		cpucp->chans[i].con_priv = ERR_PTR(-EINVAL);
+
+	mbox = &cpucp->mbox;
+	mbox->dev = dev;
+	mbox->num_chans = cpucp->num_chan;
+	mbox->chans = cpucp->chans;
+	mbox->ops = &qcom_cpucp_mbox_chan_ops;
+	mbox->of_xlate = qcom_cpucp_mbox_xlate;
+	mbox->txdone_irq = false;
+	mbox->txdone_poll = false;
+
+	return mbox_controller_register(mbox);
+}
+
+static int qcom_cpucp_mbox_probe(struct platform_device *pdev)
+{
+	struct qcom_cpucp_mbox *cpucp;
+	struct resource *res;
+	int ret;
+
+	cpucp = devm_kzalloc(&pdev->dev, sizeof(*cpucp), GFP_KERNEL);
+	if (!cpucp)
+		return -ENOMEM;
+
+	cpucp->dev = &pdev->dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "Failed to get the cpucp rx base address\n");
+		return -ENODEV;
+	}
+
+	cpucp->rx_base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	if (!cpucp->rx_base) {
+		dev_err(&pdev->dev, "Failed to ioremap cpucp tx base\n");
+		return -ENOMEM;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!res) {
+		dev_err(&pdev->dev, "Failed to get the cpucp tx base address\n");
+		return -ENODEV;
+	}
+
+	cpucp->tx_base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	if (!cpucp->tx_base) {
+		dev_err(&pdev->dev, "Failed to ioremap cpucp tx base\n");
+		return -ENOMEM;
+	}
+
+	writeq(0, cpucp->rx_base + APSS_CPUCP_RX_MBOX_EN);
+	writeq(0, cpucp->rx_base + APSS_CPUCP_RX_MBOX_CLEAR);
+	writeq(0, cpucp->rx_base + APSS_CPUCP_RX_MBOX_MAP);
+
+	cpucp->irq = platform_get_irq(pdev, 0);
+	if (cpucp->irq < 0) {
+		dev_err(&pdev->dev, "Failed to get the IRQ\n");
+		return cpucp->irq;
+	}
+
+	ret = devm_request_irq(&pdev->dev, cpucp->irq, qcom_cpucp_mbox_irq_fn,
+			       IRQF_TRIGGER_HIGH, "apss_cpucp_mbox", cpucp);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to register the irq: %d\n", ret);
+		return ret;
+	}
+
+	writeq(APSS_CPUCP_RX_MBOX_CMD_MASK, cpucp->rx_base + APSS_CPUCP_RX_MBOX_MAP);
+
+	cpucp->num_chan = APSS_CPUCP_IPC_CHAN_SUPPORTED;
+	ret = qcom_cpucp_setup_mbox(cpucp);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to create mailbox\n");
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, cpucp);
+
+	return 0;
+}
+
+static int qcom_cpucp_mbox_remove(struct platform_device *pdev)
+{
+	struct qcom_cpucp_mbox *cpucp = platform_get_drvdata(pdev);
+
+	mbox_controller_unregister(&cpucp->mbox);
+
+	return 0;
+}
+
+static const struct of_device_id qcom_cpucp_mbox_of_match[] = {
+	{ .compatible = "qcom,cpucp-mbox"},
+	{}
+};
+MODULE_DEVICE_TABLE(of, qcom_cpucp_mbox_of_match);
+
+static struct platform_driver qcom_cpucp_mbox_driver = {
+	.probe = qcom_cpucp_mbox_probe,
+	.remove = qcom_cpucp_mbox_remove,
+	.driver = {
+		.name = "qcom_cpucp_mbox",
+		.of_match_table = qcom_cpucp_mbox_of_match,
+		.suppress_bind_attrs = true,
+	},
+};
+
+static int __init qcom_cpucp_mbox_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&qcom_cpucp_mbox_driver);
+	if (ret)
+		pr_err("%s: qcom_cpucp_mbox register failed %d\n", __func__, ret);
+
+	return ret;
+}
+module_init(qcom_cpucp_mbox_init);
+
+static __exit void qcom_cpucp_mbox_exit(void)
+{
+	platform_driver_unregister(&qcom_cpucp_mbox_driver);
+}
+module_exit(qcom_cpucp_mbox_exit);
+
+MODULE_DESCRIPTION("QTI CPUCP MBOX Driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1


