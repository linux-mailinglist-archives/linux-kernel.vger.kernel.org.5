Return-Path: <linux-kernel+bounces-122726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A66F88FC20
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3F26B21218
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E69C7D061;
	Thu, 28 Mar 2024 09:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bAkTXbSk"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8ADB657DF;
	Thu, 28 Mar 2024 09:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711619490; cv=none; b=EB4p0M9rqWxbmlzKhPSuyGCuqsT/1qOZzqgjAMkMMiPUOCsS5jg6B88PGwdUL5VmYpiBIerU5pD6Uv9mLjLQWF6mvnuhYu6mVWlAQqLcOUWOQtRlMQJuyCoMrbhjkCiKVYpcuzkO1Q+8OVhxn/2fYVpmbfnK+M46P7fsWxERXF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711619490; c=relaxed/simple;
	bh=lgu4cXT7x8xPdtXWfpYx5qzXqhvaFWvi98hMi4WpmTE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nLbvQBmGxKdDWqjHMTEbxV9tCbV9GDLdXj0s9E0HsMVd+JUL6CI6lsRlVRe1vNXSNKjdC23BurH2EtnUCLIsSSt6Gh4mbecVFiBC0JBIUunqT/TZkfAs7DZJ5Cda9NK4Eml436fQqlpERm7FFirGbnbge5TtVo7FTonCclVw39U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bAkTXbSk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42S9pLAG025886;
	Thu, 28 Mar 2024 09:51:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=kCJPxXEqJOGiq9A6ONhK7V1KWr+4lz+Vx1eTzcpQlz0=; b=bA
	kTXbSkfMHBuRg5ypKtsocrBLWElb60g6i+sFMQ7/uhR66Yf6vc/kefWQtgyM/COB
	sR8OigrWSu23KHut3y01A3Gx2rZrb2NyaEcqYgx2Ueqq3rz6bGI1D+2UUiI9x/Ve
	dIj1t7kRqJDpK/zfye6CR0QmRkYt1W9ST+SBgHNQP6nLko9qhpY1d0tmSsLwEbY5
	M2wPCf7t7M8EC5FF4UMWhOLtCoEqTd8rIM35UN/HWT+iJV/Se0mNYYbGitxLywLt
	dTn0zx+NHiDDq8+kfwg494ut+pJUGTC6uEbL5rM5uzXyg5XlokJHlkNfmPJjPKDc
	dbYNmAzQYZbyCuMFJrOA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x4u20awfh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 09:51:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42S9pK6M010044
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 09:51:20 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Mar 2024 02:51:14 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jassisinghbrar@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_rgottimu@quicinc.com>,
        <quic_kshivnan@quicinc.com>, <quic_sibis@quicinc.com>,
        <conor+dt@kernel.org>, <quic_gkohli@quicinc.com>,
        <quic_nkela@quicinc.com>, <quic_psodagud@quicinc.com>
Subject: [PATCH 2/5] mailbox: Add support for QTI CPUCP mailbox controller
Date: Thu, 28 Mar 2024 15:20:41 +0530
Message-ID: <20240328095044.2926125-3-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328095044.2926125-1-quic_sibis@quicinc.com>
References: <20240328095044.2926125-1-quic_sibis@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 55OBdVx8SXdeYMHkJJCrx1CcZ3xHhTfh
X-Proofpoint-GUID: 55OBdVx8SXdeYMHkJJCrx1CcZ3xHhTfh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_09,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403210001 definitions=main-2403280066

Add support for CPUSS Control Processor (CPUCP) mailbox controller,
this driver enables communication between AP and CPUCP by acting as
a doorbell between them.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

rfc:
* Use chan->lock and chan->cl to detect if the channel is no longer
  Available. [Dmitry]
* Use BIT() instead of using manual shifts. [Dmitry]
* Don't use integer as a pointer value. [Dmitry]
* Allow it to default to of_mbox_index_xlate. [Dmitry]
* Use devm_of_iomap. [Dmitry]
* Use module_platform_driver instead of module init/exit. [Dmitry]
* Get channel number using mailbox core (like other drivers) and
  further simplify the driver by dropping setup_mbox func.

 drivers/mailbox/Kconfig           |   8 ++
 drivers/mailbox/Makefile          |   2 +
 drivers/mailbox/qcom-cpucp-mbox.c | 205 ++++++++++++++++++++++++++++++
 3 files changed, 215 insertions(+)
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
index 000000000000..e27a258fe57a
--- /dev/null
+++ b/drivers/mailbox/qcom-cpucp-mbox.c
@@ -0,0 +1,205 @@
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
+	for (i = 0; i < APSS_CPUCP_IPC_CHAN_SUPPORTED; i++) {
+		val = 0;
+		if (status & ((u64)1 << i)) {
+			val = readl(cpucp->rx_base + APSS_CPUCP_RX_MBOX_CMD + (i * 8) + APSS_CPUCP_MBOX_CMD_OFF);
+			chan = &cpucp->chans[i];
+			spin_lock_irqsave(&chan->lock, flags);
+			if (chan->cl)
+				mbox_chan_received_data(chan, &val);
+			spin_unlock_irqrestore(&chan->lock, flags);
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
+	writel(*val, cpucp->tx_base + APSS_CPUCP_TX_MBOX_CMD + (chan_id * 8) + APSS_CPUCP_MBOX_CMD_OFF);
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
+	struct qcom_cpucp_mbox *cpucp;
+	struct mbox_controller *mbox;
+	int ret;
+
+	cpucp = devm_kzalloc(&pdev->dev, sizeof(*cpucp), GFP_KERNEL);
+	if (!cpucp)
+		return -ENOMEM;
+
+	cpucp->dev = &pdev->dev;
+
+	cpucp->rx_base = devm_of_iomap(cpucp->dev, cpucp->dev->of_node, 0, NULL);
+	if (IS_ERR(cpucp->rx_base))
+		return PTR_ERR(cpucp->rx_base);
+
+	cpucp->tx_base = devm_of_iomap(cpucp->dev, cpucp->dev->of_node, 1, NULL);
+	if (IS_ERR(cpucp->tx_base))
+		return PTR_ERR(cpucp->tx_base);
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
+	mbox = &cpucp->mbox;
+	mbox->dev = cpucp->dev;
+	mbox->num_chans = APSS_CPUCP_IPC_CHAN_SUPPORTED;
+	mbox->chans = cpucp->chans;
+	mbox->ops = &qcom_cpucp_mbox_chan_ops;
+	mbox->txdone_irq = false;
+	mbox->txdone_poll = false;
+
+	ret = mbox_controller_register(mbox);
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
+	{ .compatible = "qcom,x1e80100-cpucp-mbox"},
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
+module_platform_driver(qcom_cpucp_mbox_driver);
+
+MODULE_DESCRIPTION("QTI CPUCP MBOX Driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1


