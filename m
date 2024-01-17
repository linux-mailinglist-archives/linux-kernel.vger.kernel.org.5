Return-Path: <linux-kernel+bounces-29280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 811C2830C10
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15471281072
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A8A2376A;
	Wed, 17 Jan 2024 17:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jELdXV+t"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B3622EE3;
	Wed, 17 Jan 2024 17:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705512943; cv=none; b=i+LLqYG9xYkqUGwiDTggJrbgIxWpxkAsFIGx1emKRiV8W23VaDys39W4glvxvoRGJu5eULBFenT3m3u1AK2EN8g5ir4TTnipmY4WJZfz602mVlvrC8g5fOE+pzkWYit5c4swJhGDelv1xmaoG/YHZ58vHTE1bH3x9qFcNwSeZTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705512943; c=relaxed/simple;
	bh=iv6iYQwGt0Rs/w7EWvp3lxEnVPQzf5nYsR+HtYiQw3I=;
	h=Received:DKIM-Signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=Tx5taNTyp2Y0a4VuvA1AmTKUrJw0/36FeiWwPxgeOsXrFdckRRtnRV5mDTx1NFvQ/pNqihgndjwIEosMqpabeKZRaMq1iZcap7XAtuGMbeksotA4M2hYM1hgTOodXbJi0cfVXsGoWUcwJ9QY/8Z9NMqCMXVhzEp3+3L656c8d2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jELdXV+t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40HCPHU5004683;
	Wed, 17 Jan 2024 17:35:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=9DlYdMmEAlD+vd2dPuuZlN2YWuO1JFrM/f8+4sXb5FY=; b=jE
	LdXV+tYJdCYSouqon3au96tMpa7maYoK+gu7zYdZy//HVsQ1uAAauIZ44GkwmEmB
	Rr4zUntwhXEChKowpJsgSDSTVXmmYFZKjnyl0q8XdEfgPv67h58rL+uitbl4eK4n
	tEkbuT1uQlkX4qyhA5UJZZCCrFNPTaDWzTvg9KOoF7n0orDYvL4U1HjiuGL6mY62
	Z5A2b7Ks0ymvQWBpm7qrQ8ANw2XdGRwB78iwRhNpXqX18f9iMXBII4J8MLECiCTP
	q5n2d8FK3/bR9EopZ5yfr0wz8sGMWnwJW4dlE/wdcvZEuzHW+Ey6IPRTeUYRNM8l
	3BP+1z3pvxe3BZhGyVLg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vp83fskmy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 17:35:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40HHZXgw015294
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 17:35:33 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 09:35:29 -0800
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jassisinghbrar@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_rgottimu@quicinc.com>,
        <quic_kshivnan@quicinc.com>, <quic_sibis@quicinc.com>,
        <conor+dt@kernel.org>, Amir Vajid <avajid@quicinc.com>
Subject: [RFC 3/7] firmware: arm_scmi: Add QCOM vendor protocol
Date: Wed, 17 Jan 2024 23:04:54 +0530
Message-ID: <20240117173458.2312669-4-quic_sibis@quicinc.com>
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
X-Proofpoint-ORIG-GUID: fiizNltG2SFv9ixb67SrkEYOAbMjMueW
X-Proofpoint-GUID: fiizNltG2SFv9ixb67SrkEYOAbMjMueW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_10,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401170127

From: Shivnandan Kumar <quic_kshivnan@quicinc.com>

SCMI QCOM vendor protocol provides interface to communicate with SCMI
controller and enable vendor specific features like bus scaling capable
of running on it.

Signed-off-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
Co-developed-by: Ramakrishna Gottimukkula <quic_rgottimu@quicinc.com>
Signed-off-by: Ramakrishna Gottimukkula <quic_rgottimu@quicinc.com>
Co-developed-by: Amir Vajid <avajid@quicinc.com>
Signed-off-by: Amir Vajid <avajid@quicinc.com>
Co-developed-by: Sibi Sankar <quic_sibis@quicinc.com>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 drivers/firmware/arm_scmi/Kconfig            |  11 ++
 drivers/firmware/arm_scmi/Makefile           |   1 +
 drivers/firmware/arm_scmi/qcom_scmi_vendor.c | 160 +++++++++++++++++++
 include/linux/qcom_scmi_vendor.h             |  36 +++++
 4 files changed, 208 insertions(+)
 create mode 100644 drivers/firmware/arm_scmi/qcom_scmi_vendor.c
 create mode 100644 include/linux/qcom_scmi_vendor.h

diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index aa5842be19b2..86b5d6c18ec4 100644
--- a/drivers/firmware/arm_scmi/Kconfig
+++ b/drivers/firmware/arm_scmi/Kconfig
@@ -180,4 +180,15 @@ config ARM_SCMI_POWER_CONTROL
 	  called scmi_power_control. Note this may needed early in boot to catch
 	  early shutdown/reboot SCMI requests.
 
+config QCOM_SCMI_VENDOR_PROTOCOL
+	tristate "Qualcomm Technologies, Inc. Qcom SCMI vendor Protocol"
+	depends on ARM || ARM64 || COMPILE_TEST
+	depends on ARM_SCMI_PROTOCOL
+	help
+	  The SCMI QCOM vendor protocol provides interface to communicate with SCMI
+	  controller and enable vendor specific features like bus scaling.
+
+	  This driver defines the commands or message ID's used for this
+	  communication and also exposes the ops used by the clients.
+
 endmenu
diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index a7bc4796519c..eaeb788b93c6 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-core.o
 obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-module.o
 
 obj-$(CONFIG_ARM_SCMI_POWER_CONTROL) += scmi_power_control.o
+obj-$(CONFIG_QCOM_SCMI_VENDOR_PROTOCOL) += qcom_scmi_vendor.o
 
 ifeq ($(CONFIG_THUMB2_KERNEL)$(CONFIG_CC_IS_CLANG),yy)
 # The use of R7 in the SMCCC conflicts with the compiler's use of R7 as a frame
diff --git a/drivers/firmware/arm_scmi/qcom_scmi_vendor.c b/drivers/firmware/arm_scmi/qcom_scmi_vendor.c
new file mode 100644
index 000000000000..878b99f0d1ef
--- /dev/null
+++ b/drivers/firmware/arm_scmi/qcom_scmi_vendor.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/qcom_scmi_vendor.h>
+
+#include "common.h"
+
+#define	EXTENDED_MSG_ID			0
+#define	SCMI_MAX_TX_RX_SIZE		128
+#define	PROTOCOL_PAYLOAD_SIZE		16
+#define	SET_PARAM			0x10
+#define	GET_PARAM			0x11
+#define	START_ACTIVITY			0x12
+#define	STOP_ACTIVITY			0x13
+
+static int qcom_scmi_set_param(const struct scmi_protocol_handle *ph, void *buf, u64 algo_str,
+			       u32 param_id, size_t size)
+{
+	int ret = -EINVAL;
+	struct scmi_xfer *t;
+	u32 *msg;
+
+	if (!ph || !ph->xops)
+		return ret;
+
+	ret = ph->xops->xfer_get_init(ph, SET_PARAM, size + PROTOCOL_PAYLOAD_SIZE,
+				      SCMI_MAX_TX_RX_SIZE, &t);
+	if (ret)
+		return ret;
+
+	msg = t->tx.buf;
+	*msg++ = cpu_to_le32(EXTENDED_MSG_ID);
+	*msg++ = cpu_to_le32(algo_str & GENMASK(31, 0));
+	*msg++ = cpu_to_le32((algo_str & GENMASK(63, 32)) >> 32);
+	*msg++ = cpu_to_le32(param_id);
+	memcpy(msg, buf, size);
+	ret = ph->xops->do_xfer(ph, t);
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int qcom_scmi_get_param(const struct scmi_protocol_handle *ph, void *buf, u64 algo_str,
+			       u32 param_id, size_t tx_size, size_t rx_size)
+{
+	int ret = -EINVAL;
+	struct scmi_xfer *t;
+	u32 *msg;
+
+	if (!ph || !ph->xops || !buf)
+		return ret;
+
+	ret = ph->xops->xfer_get_init(ph, GET_PARAM, tx_size + PROTOCOL_PAYLOAD_SIZE,
+				      SCMI_MAX_TX_RX_SIZE, &t);
+	if (ret)
+		return ret;
+
+	msg = t->tx.buf;
+	*msg++ = cpu_to_le32(EXTENDED_MSG_ID);
+	*msg++ = cpu_to_le32(algo_str & GENMASK(31, 0));
+	*msg++ = cpu_to_le32((algo_str & GENMASK(63, 32)) >> 32);
+	*msg++ = cpu_to_le32(param_id);
+	memcpy(msg, buf, tx_size);
+	ret = ph->xops->do_xfer(ph, t);
+	if (t->rx.len > rx_size) {
+		pr_err("SCMI received buffer size %zu is more than expected size %zu\n",
+		       t->rx.len, rx_size);
+		return -EMSGSIZE;
+	}
+	memcpy(buf, t->rx.buf, t->rx.len);
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int qcom_scmi_start_activity(const struct scmi_protocol_handle *ph,
+				    void *buf, u64 algo_str, u32 param_id, size_t size)
+{
+	int ret = -EINVAL;
+	struct scmi_xfer *t;
+	u32 *msg;
+
+	if (!ph || !ph->xops)
+		return ret;
+
+	ret = ph->xops->xfer_get_init(ph, START_ACTIVITY, size + PROTOCOL_PAYLOAD_SIZE,
+				      SCMI_MAX_TX_RX_SIZE, &t);
+	if (ret)
+		return ret;
+
+	msg = t->tx.buf;
+	*msg++ = cpu_to_le32(EXTENDED_MSG_ID);
+	*msg++ = cpu_to_le32(algo_str & GENMASK(31, 0));
+	*msg++ = cpu_to_le32((algo_str & GENMASK(63, 32)) >> 32);
+	*msg++ = cpu_to_le32(param_id);
+	memcpy(msg, buf, size);
+	ret = ph->xops->do_xfer(ph, t);
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int qcom_scmi_stop_activity(const struct scmi_protocol_handle *ph, void *buf, u64 algo_str,
+				   u32 param_id, size_t size)
+{
+	int ret = -EINVAL;
+	struct scmi_xfer *t;
+	u32 *msg;
+
+	if (!ph || !ph->xops)
+		return ret;
+
+	ret = ph->xops->xfer_get_init(ph, STOP_ACTIVITY, size + PROTOCOL_PAYLOAD_SIZE,
+				      SCMI_MAX_TX_RX_SIZE, &t);
+	if (ret)
+		return ret;
+
+	msg = t->tx.buf;
+	*msg++ = cpu_to_le32(EXTENDED_MSG_ID);
+	*msg++ = cpu_to_le32(algo_str & GENMASK(31, 0));
+	*msg++ = cpu_to_le32((algo_str & GENMASK(63, 32)) >> 32);
+	*msg++ = cpu_to_le32(param_id);
+	memcpy(msg, buf, size);
+	ret = ph->xops->do_xfer(ph, t);
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static struct qcom_scmi_vendor_ops qcom_proto_ops = {
+	.set_param = qcom_scmi_set_param,
+	.get_param = qcom_scmi_get_param,
+	.start_activity = qcom_scmi_start_activity,
+	.stop_activity = qcom_scmi_stop_activity,
+};
+
+static int qcom_scmi_vendor_protocol_init(const struct scmi_protocol_handle *ph)
+{
+	u32 version;
+
+	ph->xops->version_get(ph, &version);
+
+	dev_info(ph->dev, "qcom scmi version %d.%d\n",
+		 PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
+
+	return 0;
+}
+
+static const struct scmi_protocol qcom_scmi_vendor = {
+	.id = QCOM_SCMI_VENDOR_PROTOCOL,
+	.owner = THIS_MODULE,
+	.instance_init = &qcom_scmi_vendor_protocol_init,
+	.ops = &qcom_proto_ops,
+};
+module_scmi_protocol(qcom_scmi_vendor);
+
+MODULE_DESCRIPTION("QTI SCMI vendor protocol");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/qcom_scmi_vendor.h b/include/linux/qcom_scmi_vendor.h
new file mode 100644
index 000000000000..bde57bb18367
--- /dev/null
+++ b/include/linux/qcom_scmi_vendor.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * QTI SCMI vendor protocol's header
+ *
+ * Copyright (c) 2024, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _QCOM_SCMI_VENDOR_H
+#define _QCOM_SCMI_VENDOR_H
+
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/types.h>
+
+#define QCOM_SCMI_VENDOR_PROTOCOL    0x80
+
+struct scmi_protocol_handle;
+extern struct scmi_device *get_qcom_scmi_device(void);
+
+/**
+ * struct qcom_scmi_vendor_ops - represents the various operations provided
+ *				 by qcom scmi vendor protocol
+ */
+struct qcom_scmi_vendor_ops {
+	int (*set_param)(const struct scmi_protocol_handle *ph, void *buf, u64 algo_str,
+			 u32 param_id, size_t size);
+	int (*get_param)(const struct scmi_protocol_handle *ph, void *buf, u64 algo_str,
+			 u32 param_id, size_t tx_size, size_t rx_size);
+	int (*start_activity)(const struct scmi_protocol_handle *ph, void *buf, u64 algo_str,
+			      u32 param_id, size_t size);
+	int (*stop_activity)(const struct scmi_protocol_handle *ph, void *buf, u64 algo_str,
+			     u32 param_id, size_t size);
+};
+
+#endif /* _QCOM_SCMI_VENDOR_H */
+
-- 
2.34.1


