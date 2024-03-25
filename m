Return-Path: <linux-kernel+bounces-117687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7969F88AE6D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 046671FA388C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05234641;
	Mon, 25 Mar 2024 18:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nNTp6z7v"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7B3259C;
	Mon, 25 Mar 2024 18:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711390624; cv=none; b=SuHXvBGNcrdIdc7V0ZnHBbBW6hyIpY0L4C+fgDIX0+633SRcTqag1rjLBzNSyV+YMGNz+rN1QwLO3GoZm6fR8LBLk6brCT68RUKDLK19uv3r18VymYBXVqL0l67RX6kGKdSyvvElqXVo8uURto3/oRETYj2SRA2jWBIUi+mCx+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711390624; c=relaxed/simple;
	bh=7Gy7rDBd0lacsg60oFmYDOrt2RxXSF8sJrzYt3YXJkw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BDm7kCIuDVkjc/q3QkSfNJx2TOz/vL1MddjSyCrQ/cXUSj02SUys+XCggzcFtMS7gANQdwJFK4LLrL2saadNl3B0e2rJsRrl7TxoHxrlhRulzVZ5DeukpSaOpLDZHySZw9C/3YBATK7pQ4EibqXLySDd98eSHjqO5zsE7jB07Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nNTp6z7v; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42P7F2Tr012133;
	Mon, 25 Mar 2024 18:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=oCVzZSr5RvaTbHKjG5Qr
	82NpeJtdzIJBcj4b/VU6FdQ=; b=nNTp6z7vOgKxEF2DT8CSevM5pKkGJ316IlGg
	Q1WvEG9GYyp8PWu7uWTvWhy3XwKHwD2VoHUh7yQdJMpsKtmrd1zeEODhqhScahMS
	rVKQWtqh37suTdmAg39uVwaENyBXNK0EOI/XYCik0qkmb4GpOO5cbeFp3ipfm/CQ
	w7gxRxqY2eoy2jEkhw86C7Bu0oQPfA51wDz6gBHLwJYS4X12DIn6I91W1/OY8j//
	Kd4BsXxGGIR6T0ABdtk+9s4Oo48zDSrF/FdYgktVSoGh1Wlayts2p9fMg7b4hjPU
	MuGvcQ+JwWnD29WCrWeh7S5Qpc2L8pnv8i8l4EyeQmWb9IcCvQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x31wssvaw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 18:16:57 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42PIGuoq022973
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 18:16:56 GMT
Received: from hu-okukatla-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 25 Mar 2024 11:16:52 -0700
From: Odelu Kukatla <quic_okukatla@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Kees Cook <keescook@chromium.org>, <cros-qcom-dts-watchers@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <quic_rlaggysh@quicinc.com>,
        <quic_mdtipton@quicinc.com>
Subject: [PATCH v4 1/4] interconnect: qcom: icc-rpmh: Add QoS configuration support
Date: Mon, 25 Mar 2024 23:46:25 +0530
Message-ID: <20240325181628.9407-2-quic_okukatla@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240325181628.9407-1-quic_okukatla@quicinc.com>
References: <20240325181628.9407-1-quic_okukatla@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bTksVrKyjmcadXY_dEfmOgBR8pSbeAcK
X-Proofpoint-ORIG-GUID: bTksVrKyjmcadXY_dEfmOgBR8pSbeAcK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_16,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403250107

It adds QoS support for QNOC device and includes support for
configuring priority, priority forward disable, urgency forwarding.
This helps in priortizing the traffic originating from different
interconnect masters at NoC(Network On Chip).

Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>
---
 drivers/interconnect/qcom/icc-rpmh.c | 99 ++++++++++++++++++++++++++++
 drivers/interconnect/qcom/icc-rpmh.h | 34 ++++++++++
 2 files changed, 133 insertions(+)

diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
index c1aa265c1f4e..bc85701ee027 100644
--- a/drivers/interconnect/qcom/icc-rpmh.c
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -1,8 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
+#include <linux/bitfield.h>
+#include <linux/clk.h>
 #include <linux/interconnect.h>
 #include <linux/interconnect-provider.h>
 #include <linux/module.h>
@@ -14,6 +17,38 @@
 #include "icc-common.h"
 #include "icc-rpmh.h"
 
+/* QNOC QoS */
+#define QOSGEN_MAINCTL_LO(p, qp)	(0x8 + (p->port_offsets[qp]))
+#define QOS_SLV_URG_MSG_EN_MASK		GENMASK(3, 3)
+#define QOS_DFLT_PRIO_MASK		GENMASK(6, 4)
+#define QOS_DISABLE_MASK		GENMASK(24, 24)
+
+/**
+ * qcom_icc_set_qos - initialize static QoS configurations
+ * @qp: qcom icc provider to which @node belongs
+ * @node: qcom icc node to operate on
+ */
+static void qcom_icc_set_qos(struct qcom_icc_provider *qp,
+				struct qcom_icc_node *node)
+{
+	const struct qcom_icc_qosbox *qos = node->qosbox;
+	int port;
+
+	for (port = 0; port < qos->num_ports; port++) {
+		regmap_update_bits(qp->regmap, QOSGEN_MAINCTL_LO(qos, port),
+				   QOS_DISABLE_MASK,
+				   FIELD_PREP(QOS_DISABLE_MASK, qos->prio_fwd_disable));
+
+		regmap_update_bits(qp->regmap, QOSGEN_MAINCTL_LO(qos, port),
+				   QOS_DFLT_PRIO_MASK,
+				   FIELD_PREP(QOS_DFLT_PRIO_MASK, qos->prio));
+
+		regmap_update_bits(qp->regmap, QOSGEN_MAINCTL_LO(qos, port),
+				   QOS_SLV_URG_MSG_EN_MASK,
+				   FIELD_PREP(QOS_SLV_URG_MSG_EN_MASK, qos->urg_fwd));
+	}
+}
+
 /**
  * qcom_icc_pre_aggregate - cleans up stale values from prior icc_set
  * @node: icc node to operate on
@@ -159,6 +194,36 @@ int qcom_icc_bcm_init(struct qcom_icc_bcm *bcm, struct device *dev)
 }
 EXPORT_SYMBOL_GPL(qcom_icc_bcm_init);
 
+/**
+ * qcom_icc_rpmh_configure_qos - configure QoS parameters
+ * @qp: qcom icc provider associated with QoS endpoint nodes
+ *
+ * Return: 0 on success, or an error code otherwise
+ */
+static int qcom_icc_rpmh_configure_qos(struct qcom_icc_provider *qp)
+{
+	struct qcom_icc_node *qnode;
+	size_t i;
+	int ret;
+
+	ret = clk_bulk_prepare_enable(qp->num_clks, qp->clks);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < qp->num_nodes; i++) {
+		qnode = qp->nodes[i];
+		if (!qnode)
+			continue;
+
+		if (qnode->qosbox)
+			qcom_icc_set_qos(qp, qnode);
+	}
+
+	clk_bulk_disable_unprepare(qp->num_clks, qp->clks);
+
+	return ret;
+}
+
 int qcom_icc_rpmh_probe(struct platform_device *pdev)
 {
 	const struct qcom_icc_desc *desc;
@@ -199,7 +264,9 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
 
 	qp->dev = dev;
 	qp->bcms = desc->bcms;
+	qp->nodes = desc->nodes;
 	qp->num_bcms = desc->num_bcms;
+	qp->num_nodes = desc->num_nodes;
 
 	qp->voter = of_bcm_voter_get(qp->dev, NULL);
 	if (IS_ERR(qp->voter))
@@ -229,6 +296,38 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
 		data->nodes[i] = node;
 	}
 
+	if (desc->config) {
+		struct resource *res;
+		void __iomem *base;
+
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		if (!res)
+			goto skip_qos_config;
+
+		base = devm_ioremap_resource(dev, res);
+		if (IS_ERR(base)) {
+			dev_info(dev, "Skipping QoS, ioremap failed: %ld\n", PTR_ERR(base));
+			goto skip_qos_config;
+		};
+
+		qp->regmap = devm_regmap_init_mmio(dev, base, desc->config);
+		if (IS_ERR(qp->regmap)) {
+			dev_info(dev, "Skipping QoS, regmap failed; %ld\n", PTR_ERR(qp->regmap));
+			goto skip_qos_config;
+		}
+
+		qp->num_clks = devm_clk_bulk_get_all(qp->dev, &qp->clks);
+		if (qp->num_clks < 0) {
+			dev_info(dev, "Skipping QoS, failed to get clk: %d\n", qp->num_clks);
+			goto skip_qos_config;
+		}
+
+		ret = qcom_icc_rpmh_configure_qos(qp);
+		if (ret)
+			dev_info(dev, "Failed to program QoS: %d\n", ret);
+	}
+
+skip_qos_config:
 	ret = icc_provider_register(provider);
 	if (ret)
 		goto err_remove_nodes;
diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
index 2de29460e808..4fdc75c84c95 100644
--- a/drivers/interconnect/qcom/icc-rpmh.h
+++ b/drivers/interconnect/qcom/icc-rpmh.h
@@ -1,12 +1,14 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef __DRIVERS_INTERCONNECT_QCOM_ICC_RPMH_H__
 #define __DRIVERS_INTERCONNECT_QCOM_ICC_RPMH_H__
 
 #include <dt-bindings/interconnect/qcom,icc.h>
+#include <linux/regmap.h>
 
 #define to_qcom_provider(_provider) \
 	container_of(_provider, struct qcom_icc_provider, provider)
@@ -18,6 +20,11 @@
  * @bcms: list of bcms that maps to the provider
  * @num_bcms: number of @bcms
  * @voter: bcm voter targeted by this provider
+ * @nodes: list of icc nodes that maps to the provider
+ * @num_nodes: number of @nodes
+ * @regmap: used for QoS, register access
+ * @clks : clks required for register access
+ * @num_clks: number of @clks
  */
 struct qcom_icc_provider {
 	struct icc_provider provider;
@@ -25,6 +32,11 @@ struct qcom_icc_provider {
 	struct qcom_icc_bcm * const *bcms;
 	size_t num_bcms;
 	struct bcm_voter *voter;
+	struct qcom_icc_node * const *nodes;
+	size_t num_nodes;
+	struct regmap *regmap;
+	struct clk_bulk_data *clks;
+	int num_clks;
 };
 
 /**
@@ -41,6 +53,25 @@ struct bcm_db {
 	u8 reserved;
 };
 
+/**
+ * struct qcom_icc_qosbox - Qualcomm specific QoS config
+ * @prio: priority value assigned to requests on the node
+ * @urg_fwd: whether to forward the urgency promotion issued by master
+ * (endpoint), or discard
+ * @prio_fwd_disable: whether to forward the priority driven by master, or
+ * override by @prio
+ * @num_ports: number of @ports
+ * @port_offsets: qos register offsets
+ */
+
+struct qcom_icc_qosbox {
+	const u32 prio;
+	const bool urg_fwd;
+	const bool prio_fwd_disable;
+	const u32 num_ports;
+	const u32 port_offsets[] __counted_by(num_ports);
+};
+
 #define MAX_LINKS		128
 #define MAX_BCMS		64
 #define MAX_BCM_PER_NODE	3
@@ -58,6 +89,7 @@ struct bcm_db {
  * @max_peak: current max aggregate value of all peak bw requests
  * @bcms: list of bcms associated with this logical node
  * @num_bcms: num of @bcms
+ * @qosbox: qos config data associated with node
  */
 struct qcom_icc_node {
 	const char *name;
@@ -70,6 +102,7 @@ struct qcom_icc_node {
 	u64 max_peak[QCOM_ICC_NUM_BUCKETS];
 	struct qcom_icc_bcm *bcms[MAX_BCM_PER_NODE];
 	size_t num_bcms;
+	const struct qcom_icc_qosbox *qosbox;
 };
 
 /**
@@ -114,6 +147,7 @@ struct qcom_icc_fabric {
 };
 
 struct qcom_icc_desc {
+	const struct regmap_config *config;
 	struct qcom_icc_node * const *nodes;
 	size_t num_nodes;
 	struct qcom_icc_bcm * const *bcms;
-- 
2.17.1


