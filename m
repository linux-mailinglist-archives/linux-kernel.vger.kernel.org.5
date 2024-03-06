Return-Path: <linux-kernel+bounces-93430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C27B7872FA2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CD181F25D81
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65F75C8F3;
	Wed,  6 Mar 2024 07:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aSFzF0Io"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127C85C5F7;
	Wed,  6 Mar 2024 07:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709710252; cv=none; b=HPwqeZLHJPgtU0cprMSKLoAZHPs0a1odJ86CVCORbRx9li9tiGdIgiJX1s+il+2fpaF3zmDhIZDno6ktL25R3z6gfkQTmiKOkC57Yttld3DhDFyIMefg4MXP8KIJnpJcjgo2wBfJ4ruqWI4GuVSRSWKRTVXv3TbUlPI5kEc5Rec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709710252; c=relaxed/simple;
	bh=c1bftpDuIOmUwgy2gnxRjxmco5Z0u5DKZrGSG+jJz6w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NWK1EPwwSf93QUko1VLeNBUYT53c6Mxp9eYZCx1iH5IQzjqJOUxbEckoTwHIotKKHXfVa6Bl67ZeE4TGzB8OQj/1C/xI6rGBs/pu93UqX/n4Z9Yk31RwNrXBy2o0BwYpsu0qTokiaAg0G/DtzNQlCmWBboWpftWi48BU+tUQhyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aSFzF0Io; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42668cFV020915;
	Wed, 6 Mar 2024 07:30:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=S10ty99sebGJdDg/EZze
	O5bavZLB9qCBiYbmsMoBeSo=; b=aSFzF0IoL1tiiOlaNgk4JIOciJsVE21iIe/N
	S9404WkbNe/U0ERmdOKQcqe1cefKXMCTGCGcvM405B5d2qut6052TDwAAO+5NJt4
	duh7lA4/v/7F0YkRnxgN5nDJ9BXusagyvI8P6StsqxOanTPVqkAnam9+1gimpEZa
	zYJTV53JwnU3UcXTsP54soNIdnzLx1k1FYavo2ZAWVSrKM/IsIB7q4ygWdrcPvb3
	d1gc3Xc4HuXbFeWnPxjLO+VCqdwFSClZFBEbJGWwi3LJ6VWR0EWNUHCVYuwzeeVA
	7w1odt6PC1jLH8FCjm3P9M/awUR+rDwYjNadXkQ9ToL8faVSmg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wpjy3r5mk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 07:30:46 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4267Uivl023706
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Mar 2024 07:30:44 GMT
Received: from hu-okukatla-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 5 Mar 2024 23:30:39 -0800
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
Subject: [PATCH v3 1/4] interconnect: qcom: icc-rpmh: Add QoS configuration support
Date: Wed, 6 Mar 2024 13:00:13 +0530
Message-ID: <20240306073016.2163-2-quic_okukatla@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240306073016.2163-1-quic_okukatla@quicinc.com>
References: <20240306073016.2163-1-quic_okukatla@quicinc.com>
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
X-Proofpoint-GUID: -LPk5ON0g1L3tEQEuuEcfRSAIizXgoh-
X-Proofpoint-ORIG-GUID: -LPk5ON0g1L3tEQEuuEcfRSAIizXgoh-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_04,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403060058

It adds QoS support for QNOC device and includes support for
configuring priority, priority forward disable, urgency forwarding.
This helps in priortizing the traffic originating from different
interconnect masters at NoC(Network On Chip).

Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>
---
 drivers/interconnect/qcom/icc-rpmh.c | 105 +++++++++++++++++++++++++++
 drivers/interconnect/qcom/icc-rpmh.h |  32 ++++++++
 2 files changed, 137 insertions(+)

diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
index c1aa265c1f4e..b4681849df80 100644
--- a/drivers/interconnect/qcom/icc-rpmh.c
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -1,19 +1,57 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
+#include <linux/clk.h>
 #include <linux/interconnect.h>
 #include <linux/interconnect-provider.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/slab.h>
+#include <linux/bitfield.h>
 
 #include "bcm-voter.h"
 #include "icc-common.h"
 #include "icc-rpmh.h"
 
+/* QNOC QoS */
+#define QOSGEN_MAINCTL_LO(p, qp)	(0x8 + (p->port_offsets[qp]))
+#define QOS_SLV_URG_MSG_EN_MASK		BIT_MASK(3)
+#define QOS_DFLT_PRIO_MASK		GENMASK(6, 4)
+#define QOS_DISABLE_MASK		BIT_MASK(24)
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
+	if (!qp->regmap || !qos)
+		return;
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
@@ -159,6 +197,36 @@ int qcom_icc_bcm_init(struct qcom_icc_bcm *bcm, struct device *dev)
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
@@ -199,7 +267,9 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
 
 	qp->dev = dev;
 	qp->bcms = desc->bcms;
+	qp->nodes = desc->nodes;
 	qp->num_bcms = desc->num_bcms;
+	qp->num_nodes = desc->num_nodes;
 
 	qp->voter = of_bcm_voter_get(qp->dev, NULL);
 	if (IS_ERR(qp->voter))
@@ -229,6 +299,41 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
 		data->nodes[i] = node;
 	}
 
+	if (desc->config) {
+		struct resource *res;
+		void __iomem *base;
+
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		if (!res) {
+			dev_warn(dev, "Skipping QoS, failed to get resource\n");
+			goto skip_qos_config;
+		}
+
+		base = devm_ioremap(dev, res->start, resource_size(res));
+		if (IS_ERR(base)) {
+			dev_warn(dev, "Skipping QoS, ioremap failed: %ld\n", PTR_ERR(base));
+			goto skip_qos_config;
+		};
+
+		qp->regmap = devm_regmap_init_mmio(dev, base, desc->config);
+
+		if (IS_ERR(qp->regmap)) {
+			dev_warn(dev, "Skipping QoS, regmap failed; %ld\n", PTR_ERR(qp->regmap));
+			goto skip_qos_config;
+		}
+
+		qp->num_clks = devm_clk_bulk_get_all(qp->dev, &qp->clks);
+		if (qp->num_clks < 0) {
+			dev_warn(dev, "Skipping QoS, failed to get clk: %d\n", qp->num_clks);
+			goto skip_qos_config;
+		}
+
+		ret = qcom_icc_rpmh_configure_qos(qp);
+		if (ret)
+			dev_warn(dev, "Failed to program QoS: %d\n", ret);
+	}
+
+skip_qos_config:
 	ret = icc_provider_register(provider);
 	if (ret)
 		goto err_remove_nodes;
diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
index 2de29460e808..a0533d8aeffe 100644
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
@@ -41,6 +53,23 @@ struct bcm_db {
 	u8 reserved;
 };
 
+/**
+ * struct qcom_icc_qosbox - Qualcomm specific QoS config
+ * @prio: priority value assigned to requests on the node
+ * @urg_fwd: whether to forward the urgency promotion issued by master(endpoint), or discard
+ * @prio_fwd_disable: whether to forward the priority driven by mster, or override by @prio
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
@@ -58,6 +87,7 @@ struct bcm_db {
  * @max_peak: current max aggregate value of all peak bw requests
  * @bcms: list of bcms associated with this logical node
  * @num_bcms: num of @bcms
+ * @qosbox: qos config data associated with node
  */
 struct qcom_icc_node {
 	const char *name;
@@ -70,6 +100,7 @@ struct qcom_icc_node {
 	u64 max_peak[QCOM_ICC_NUM_BUCKETS];
 	struct qcom_icc_bcm *bcms[MAX_BCM_PER_NODE];
 	size_t num_bcms;
+	const struct qcom_icc_qosbox *qosbox;
 };
 
 /**
@@ -114,6 +145,7 @@ struct qcom_icc_fabric {
 };
 
 struct qcom_icc_desc {
+	const struct regmap_config *config;
 	struct qcom_icc_node * const *nodes;
 	size_t num_nodes;
 	struct qcom_icc_bcm * const *bcms;
-- 
2.17.1


