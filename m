Return-Path: <linux-kernel+bounces-33159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 455DD836592
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5DD8B29C52
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685203D548;
	Mon, 22 Jan 2024 14:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HPtScfYK"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A268219E1;
	Mon, 22 Jan 2024 14:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705933875; cv=none; b=c9Qgxrw+fznoEbSMD4H6w+kjjhfgtWEtCJ9q7Zx4ulVCgD5XLdSIjELUxkzkbzSPDFrm1KcbNBtD46AYxAr/XIkXj2lA+p55m6p58MHbbDFd/U3+lXbtRzXs4WfIHQpZuzoRE6Gjk0dmHZc3vFZrO2/NuFus2hBomjvQDxzU+M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705933875; c=relaxed/simple;
	bh=AC/70wpazrZWNr4rE8gxFwCbbSnq5achdRLEc+LJVJA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XDqQkG69XgYTghkBrlChc0kvfF6YtHH5OVPB0iehh2Sc0c3Fb9tG7gXm59AM4DuJFtko0eM3z6dhFjl+orSD3/kewOEXWHsxMtcFHHIeBoHrGSymulbzB1/a+y8cePloFcgw/NJ1NsHs456ikfqzIvyg+i9jizxIs9K/KJOh4ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HPtScfYK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40M4uorU004389;
	Mon, 22 Jan 2024 14:31:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=NQZGJF+V13pzIVwBU4xC
	gR5v/bom8HG+fNQolMnEmnI=; b=HPtScfYKH5UHDLj7HVIu7TeEJlh20AmhLIyu
	gNja1icMbkRl+xSe3x0PB/uwDyD+hg9yzo3z5q/SfGHD29M1SrBXdOsiPAkcTp2Z
	dEL11Jx8en1Pb6Wi6IjnAKAe6QKGQB5arhQz0T1Er2VFCrDVBmKWh9P6HqEV5Y9d
	bA/+xaEdtwZbyPUP/Z0SioD7nKWJeUq7hxwWUPmyS6fQPrvgHKXp2/loVjkR8/xA
	rMW3iaUmyfxV3FlblS2Z7POMF4jwEicYPSsTecKlCgJxNP0T2GTLoJjYK1dMRSaj
	QEs0M1T0sMQK5DkKfSKRtN5s0Osv8VWLOjD6hR7UtbFk9nFW9g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vr7fd465q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 14:31:09 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40MEV8FT013289
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 14:31:08 GMT
Received: from hu-okukatla-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 22 Jan 2024 06:31:06 -0800
From: Odelu Kukatla <quic_okukatla@quicinc.com>
To: <georgi.djakov@linaro.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad
 Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [1/4] interconnect: qcom: icc-rpmh: Add QoS config support
Date: Mon, 22 Jan 2024 20:00:27 +0530
Message-ID: <20240122143030.11904-2-quic_okukatla@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240122143030.11904-1-quic_okukatla@quicinc.com>
References: <20240122143030.11904-1-quic_okukatla@quicinc.com>
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
X-Proofpoint-GUID: xHcduqy2EGR95t1XoLf3UFFOzyKFhb--
X-Proofpoint-ORIG-GUID: xHcduqy2EGR95t1XoLf3UFFOzyKFhb--
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_05,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1011 suspectscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401220098

Introduce support to initialize QoS settings for QNOC platforms.

Change-Id: I068d49cbcfec5d34c01e5adc930eec72d306ed89
Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>
---
 drivers/interconnect/qcom/icc-rpmh.c | 158 +++++++++++++++++++++++++++
 drivers/interconnect/qcom/icc-rpmh.h |  33 ++++++
 2 files changed, 191 insertions(+)

diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
index c1aa265c1f4e..49334065ccfa 100644
--- a/drivers/interconnect/qcom/icc-rpmh.c
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -1,8 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
+#include <linux/clk.h>
 #include <linux/interconnect.h>
 #include <linux/interconnect-provider.h>
 #include <linux/module.h>
@@ -14,6 +16,37 @@
 #include "icc-common.h"
 #include "icc-rpmh.h"
 
+/* QNOC QoS */
+#define QOSGEN_MAINCTL_LO(p, qp)	(0x8 + (p->offsets[qp]))
+#define QOS_SLV_URG_MSG_EN_SHFT		3
+#define QOS_DFLT_PRIO_MASK		0x7
+#define QOS_DFLT_PRIO_SHFT		4
+#define QOS_DISABLE_SHIFT		24
+
+/**
+ * qcom_icc_set_qos - initialize static QoS configurations
+ * @node: qcom icc node to operate on
+ */
+static void qcom_icc_set_qos(struct qcom_icc_node *node)
+{
+	struct qcom_icc_qosbox *qos = node->qosbox;
+	int port;
+
+	for (port = 0; port < qos->num_ports; port++) {
+		regmap_update_bits(node->regmap, QOSGEN_MAINCTL_LO(qos, port),
+				   BIT(QOS_DISABLE_SHIFT),
+				   qos->prio_fwd_disable << QOS_DISABLE_SHIFT);
+
+		regmap_update_bits(node->regmap, QOSGEN_MAINCTL_LO(qos, port),
+				   QOS_DFLT_PRIO_MASK << QOS_DFLT_PRIO_SHFT,
+				   qos->prio << QOS_DFLT_PRIO_SHFT);
+
+		regmap_update_bits(node->regmap, QOSGEN_MAINCTL_LO(qos, port),
+				   BIT(QOS_SLV_URG_MSG_EN_SHFT),
+				   qos->urg_fwd << QOS_SLV_URG_MSG_EN_SHFT);
+	}
+}
+
 /**
  * qcom_icc_pre_aggregate - cleans up stale values from prior icc_set
  * @node: icc node to operate on
@@ -159,6 +192,113 @@ int qcom_icc_bcm_init(struct qcom_icc_bcm *bcm, struct device *dev)
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
+	if (ret) {
+		dev_err(qp->dev, "failed to enable clocks for QoS\n");
+		return ret;
+	}
+
+	return 0;
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
+int qcom_icc_rpmh_configure_qos(struct qcom_icc_provider *qp)
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
+			qcom_icc_set_qos(qnode);
+	}
+
+	disable_qos_deps(qp);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(qcom_icc_rpmh_configure_qos);
+
+static struct regmap *qcom_icc_rpmh_map(struct platform_device *pdev,
+					const struct qcom_icc_desc *desc)
+{
+	void __iomem *base;
+	struct resource *res;
+	struct device *dev = &pdev->dev;
+
+	if (!desc->config)
+		return NULL;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return NULL;
+
+	base = devm_ioremap(dev, res->start, resource_size(res));
+	if (IS_ERR(base))
+		return ERR_CAST(base);
+
+	return devm_regmap_init_mmio(dev, base, desc->config);
+}
+
 int qcom_icc_rpmh_probe(struct platform_device *pdev)
 {
 	const struct qcom_icc_desc *desc;
@@ -199,12 +339,22 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
 
 	qp->dev = dev;
 	qp->bcms = desc->bcms;
+	qp->nodes = desc->nodes;
 	qp->num_bcms = desc->num_bcms;
+	qp->num_nodes = desc->num_nodes;
 
 	qp->voter = of_bcm_voter_get(qp->dev, NULL);
 	if (IS_ERR(qp->voter))
 		return PTR_ERR(qp->voter);
 
+	qp->regmap = qcom_icc_rpmh_map(pdev, desc);
+	if (IS_ERR(qp->regmap))
+		return PTR_ERR(qp->regmap);
+
+	qp->num_clks = devm_clk_bulk_get_all(qp->dev, &qp->clks);
+	if (qp->num_clks < 0)
+		return qp->num_clks;
+
 	for (i = 0; i < qp->num_bcms; i++)
 		qcom_icc_bcm_init(qp->bcms[i], dev);
 
@@ -213,6 +363,8 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
 		if (!qn)
 			continue;
 
+		qn->regmap = dev_get_regmap(qp->dev, NULL);
+
 		node = icc_node_create(qn->id);
 		if (IS_ERR(node)) {
 			ret = PTR_ERR(node);
@@ -229,6 +381,10 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
 		data->nodes[i] = node;
 	}
 
+	ret = qcom_icc_rpmh_configure_qos(qp);
+	if (ret)
+		goto err_remove_nodes;
+
 	ret = icc_provider_register(provider);
 	if (ret)
 		goto err_remove_nodes;
@@ -247,6 +403,7 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
 err_deregister_provider:
 	icc_provider_deregister(provider);
 err_remove_nodes:
+	clk_bulk_put_all(qp->num_clks, qp->clks);
 	icc_nodes_remove(provider);
 
 	return ret;
@@ -258,6 +415,7 @@ void qcom_icc_rpmh_remove(struct platform_device *pdev)
 	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
 
 	icc_provider_deregister(&qp->provider);
+	clk_bulk_put_all(qp->num_clks, qp->clks);
 	icc_nodes_remove(&qp->provider);
 }
 EXPORT_SYMBOL_GPL(qcom_icc_rpmh_remove);
diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
index 2de29460e808..8fb674ff4637 100644
--- a/drivers/interconnect/qcom/icc-rpmh.h
+++ b/drivers/interconnect/qcom/icc-rpmh.h
@@ -7,6 +7,7 @@
 #define __DRIVERS_INTERCONNECT_QCOM_ICC_RPMH_H__
 
 #include <dt-bindings/interconnect/qcom,icc.h>
+#include <linux/regmap.h>
 
 #define to_qcom_provider(_provider) \
 	container_of(_provider, struct qcom_icc_provider, provider)
@@ -18,6 +19,11 @@
  * @bcms: list of bcms that maps to the provider
  * @num_bcms: number of @bcms
  * @voter: bcm voter targeted by this provider
+ * @nodes: list of interconnect nodes that maps to the provider
+ * @num_nodes: number of @nodes
+ * @regmap: used for QOS registers access
+ * @clks : clks required for register access
+ * @num_clks: number of @clks
  */
 struct qcom_icc_provider {
 	struct icc_provider provider;
@@ -25,6 +31,11 @@ struct qcom_icc_provider {
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
@@ -41,6 +52,23 @@ struct bcm_db {
 	u8 reserved;
 };
 
+/**
+ * struct qcom_icc_qosbox - Qualcomm Technologies, Inc specific QoS config
+ * @prio: priority value assigned to requests on the node
+ * @urg_fwd: if set, master priority is used for requests.
+ * @prio_fwd_disable: if set, master priority is ignored and NOCs default priority is used.
+ * @num_ports: number of @ports
+ * @offsets: qos register offsets
+ */
+
+struct qcom_icc_qosbox {
+	u32 prio;
+	u32 urg_fwd;
+	bool prio_fwd_disable;
+	u32 num_ports;
+	u32 offsets[];
+};
+
 #define MAX_LINKS		128
 #define MAX_BCMS		64
 #define MAX_BCM_PER_NODE	3
@@ -58,6 +86,8 @@ struct bcm_db {
  * @max_peak: current max aggregate value of all peak bw requests
  * @bcms: list of bcms associated with this logical node
  * @num_bcms: num of @bcms
+ * @regmap: used for QOS registers access
+ * @qosbox: qos config data associated with node
  */
 struct qcom_icc_node {
 	const char *name;
@@ -70,6 +100,8 @@ struct qcom_icc_node {
 	u64 max_peak[QCOM_ICC_NUM_BUCKETS];
 	struct qcom_icc_bcm *bcms[MAX_BCM_PER_NODE];
 	size_t num_bcms;
+	struct regmap *regmap;
+	struct qcom_icc_qosbox *qosbox;
 };
 
 /**
@@ -114,6 +146,7 @@ struct qcom_icc_fabric {
 };
 
 struct qcom_icc_desc {
+	const struct regmap_config *config;
 	struct qcom_icc_node * const *nodes;
 	size_t num_nodes;
 	struct qcom_icc_bcm * const *bcms;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


