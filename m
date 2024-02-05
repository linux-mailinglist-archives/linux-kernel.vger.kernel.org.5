Return-Path: <linux-kernel+bounces-52857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E4C849D7E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4AF41F23F7F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82082C860;
	Mon,  5 Feb 2024 14:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="W+I4xzI6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B6E2C684;
	Mon,  5 Feb 2024 14:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707145055; cv=none; b=jlqq7esm1SvoUAv7NjVIlOIjnIdpE30fW/pxJ+V+ppOjS/FQLyAh39egQ4q3APPpHtq5FOvmiUz1GxGhKowK6Cf186a/FZmddaRwO5X6u3YlkUli4CtUxZV6eVeS4DpuJ4LtrSgQyDehLe7pOphtmUY4HyWzz69SP2GbPJuV1K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707145055; c=relaxed/simple;
	bh=Sq4QTsUJi4BXRQJo5fupydxWu9eORNhMzU/I3HB7mLo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eN4NdNVlChu6fm+j+4RPy7Zrr1u3o4CpOzxUdYqF4Z1ZT48dXjM2eyKjlImzRcsLK1BdtanNPk7ZqNH0DC/iPwmlq2ck0cKokIP4ScDz40Or7gH9N8VERZfepd3XADCNUVocx3Rcb6zder/FKluVEwC9IBXQrvyZVhNzMGhjWc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=W+I4xzI6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 415CT8uV029473;
	Mon, 5 Feb 2024 14:57:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=hzepEa1TlJ6DoUcmdy4Q
	2d/qBXNBnyRWqYbOEdl+5PI=; b=W+I4xzI6fEuQzDdA20U4h76c5afC7eZ96KTl
	oJIYhWeABW+/dxQyGAlsK+RdDi9D6YHmPGansqL5RrFbKUNkIJSHAXkGiHw4/7ez
	MfJFNDgWmzhxMfl/UtliYYVwK0M+anZs/FBgBBwaBxSrNmkttmxv3B5LLProw4Jf
	f6wp5pVuwi9M68hF3GmFlkn0rYUboTMtCoRhivshLPNkmKpiVUp9/SIYgO2twusW
	umE5wxvaX69HoJqJAOqqTN2J5iJJnttaxIvhsPAxpoS3cIF1WESEw/oq0oomPa6V
	Wjzk/L3ZH/fnKlPY5PMQE0D+GMdtPIs1yreBMMvgidcpV1PEQw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w2rk71611-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 14:57:28 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 415EvRtM028010
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Feb 2024 14:57:27 GMT
Received: from hu-okukatla-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 06:57:23 -0800
From: Odelu Kukatla <quic_okukatla@quicinc.com>
To: <djakov@kernel.org>
CC: <rafael@kernel.org>, <corbet@lwn.net>, <linux-pm@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_okukatla@quicinc.com>, <quic_viveka@quicinc.com>,
        <peterz@infradead.org>, <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <konrad.dybcio@linaro.org>,
        <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/4] interconnect: qcom: icc-rpmh: Add QoS configuration support
Date: Mon, 5 Feb 2024 20:26:03 +0530
Message-ID: <20240205145606.16936-2-quic_okukatla@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240205145606.16936-1-quic_okukatla@quicinc.com>
References: <20240205145606.16936-1-quic_okukatla@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: h95uCteWcgdfkbdZ9st83jxwI6132CM3
X-Proofpoint-ORIG-GUID: h95uCteWcgdfkbdZ9st83jxwI6132CM3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_09,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402050113

It adds QoS support for QNOC device and includes support for
configuring priority, priority forward disable, urgency forwarding.
This helps in priortizing the traffic originating from different
interconnect masters at NoC(Network On Chip).

Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>
---
 drivers/interconnect/qcom/icc-rpmh.c | 161 ++++++++++++++++++++++++++-
 drivers/interconnect/qcom/icc-rpmh.h |  32 ++++++
 2 files changed, 189 insertions(+), 4 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
index c1aa265c1f4e..67e600f1191d 100644
--- a/drivers/interconnect/qcom/icc-rpmh.c
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -1,28 +1,69 @@
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
+#include <linux/bits.h>
 
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
+	if (!qp->regmap)
+		return;
+
+	if (!qos)
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
  */
 void qcom_icc_pre_aggregate(struct icc_node *node)
 {
-	size_t i;
-	struct qcom_icc_node *qn;
 	struct qcom_icc_provider *qp;
+	struct qcom_icc_node *qn;
+	size_t i;
 
 	qn = node->data;
 	qp = to_qcom_provider(node->provider);
@@ -49,8 +90,8 @@ EXPORT_SYMBOL_GPL(qcom_icc_pre_aggregate);
 int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
 		       u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
 {
-	size_t i;
 	struct qcom_icc_node *qn;
+	size_t i;
 
 	qn = node->data;
 
@@ -159,13 +200,96 @@ int qcom_icc_bcm_init(struct qcom_icc_bcm *bcm, struct device *dev)
 }
 EXPORT_SYMBOL_GPL(qcom_icc_bcm_init);
 
+static bool bcm_needs_qos_proxy(struct qcom_icc_bcm *bcm)
+{
+	int i;
+
+	for (i = 0; i < bcm->num_nodes; i++)
+		if (bcm->nodes[i]->qosbox)
+			return true;
+
+	return false;
+}
+
+static int enable_qos_deps(struct qcom_icc_provider *qp)
+{
+	struct qcom_icc_bcm *bcm;
+	bool keepalive;
+	int ret, i;
+
+	for (i = 0; i < qp->num_bcms; i++) {
+		bcm = qp->bcms[i];
+		if (bcm_needs_qos_proxy(bcm)) {
+			keepalive = bcm->keepalive;
+			bcm->keepalive = true;
+
+			qcom_icc_bcm_voter_add(qp->voter, bcm);
+			ret = qcom_icc_bcm_voter_commit(qp->voter);
+
+			bcm->keepalive = keepalive;
+
+			if (ret) {
+				dev_err(qp->dev, "failed to vote BW to %s for QoS\n",
+					bcm->name);
+				return ret;
+			}
+		}
+	}
+
+	ret = clk_bulk_prepare_enable(qp->num_clks, qp->clks);
+	if (ret)
+		dev_err(qp->dev, "failed to enable clocks for QoS\n");
+
+	return ret;
+}
+
+static void disable_qos_deps(struct qcom_icc_provider *qp)
+{
+	struct qcom_icc_bcm *bcm;
+	int i;
+
+	clk_bulk_disable_unprepare(qp->num_clks, qp->clks);
+
+	for (i = 0; i < qp->num_bcms; i++) {
+		bcm = qp->bcms[i];
+		if (bcm_needs_qos_proxy(bcm)) {
+			qcom_icc_bcm_voter_add(qp->voter, bcm);
+			qcom_icc_bcm_voter_commit(qp->voter);
+		}
+	}
+}
+
+static int qcom_icc_rpmh_configure_qos(struct qcom_icc_provider *qp)
+{
+	struct qcom_icc_node *qnode;
+	size_t i;
+	int ret;
+
+	ret = enable_qos_deps(qp);
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
+	disable_qos_deps(qp);
+
+	return ret;
+}
+
 int qcom_icc_rpmh_probe(struct platform_device *pdev)
 {
+	struct qcom_icc_node * const *qnodes, *qn;
 	const struct qcom_icc_desc *desc;
 	struct device *dev = &pdev->dev;
 	struct icc_onecell_data *data;
 	struct icc_provider *provider;
-	struct qcom_icc_node * const *qnodes, *qn;
 	struct qcom_icc_provider *qp;
 	struct icc_node *node;
 	size_t num_nodes, i, j;
@@ -199,12 +323,35 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
 
 	qp->dev = dev;
 	qp->bcms = desc->bcms;
+	qp->nodes = desc->nodes;
 	qp->num_bcms = desc->num_bcms;
+	qp->num_nodes = desc->num_nodes;
 
 	qp->voter = of_bcm_voter_get(qp->dev, NULL);
 	if (IS_ERR(qp->voter))
 		return PTR_ERR(qp->voter);
 
+	if (desc->config) {
+		struct resource *res;
+		void __iomem *base;
+
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		if (!res)
+			return -ENODEV;
+
+		base = devm_ioremap(dev, res->start, resource_size(res));
+		if (IS_ERR(base))
+			return PTR_ERR(base);
+
+		qp->regmap = devm_regmap_init_mmio(dev, base, desc->config);
+		if (IS_ERR(qp->regmap))
+			return PTR_ERR(qp->regmap);
+	}
+
+	qp->num_clks = devm_clk_bulk_get_all(qp->dev, &qp->clks);
+	if (qp->num_clks < 0)
+		return qp->num_clks;
+
 	for (i = 0; i < qp->num_bcms; i++)
 		qcom_icc_bcm_init(qp->bcms[i], dev);
 
@@ -229,6 +376,10 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
 		data->nodes[i] = node;
 	}
 
+	ret = qcom_icc_rpmh_configure_qos(qp);
+	if (ret)
+		goto err_remove_nodes;
+
 	ret = icc_provider_register(provider);
 	if (ret)
 		goto err_remove_nodes;
@@ -247,6 +398,7 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
 err_deregister_provider:
 	icc_provider_deregister(provider);
 err_remove_nodes:
+	clk_bulk_put_all(qp->num_clks, qp->clks);
 	icc_nodes_remove(provider);
 
 	return ret;
@@ -258,6 +410,7 @@ void qcom_icc_rpmh_remove(struct platform_device *pdev)
 	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
 
 	icc_provider_deregister(&qp->provider);
+	clk_bulk_put_all(qp->num_clks, qp->clks);
 	icc_nodes_remove(&qp->provider);
 }
 EXPORT_SYMBOL_GPL(qcom_icc_rpmh_remove);
diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
index 2de29460e808..65cef156f212 100644
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
+ * @urg_fwd: if set, master priority is used for requests.
+ * @prio_fwd_disable: if set, master priority is ignored and NoC's default priority is used.
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


