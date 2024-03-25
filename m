Return-Path: <linux-kernel+bounces-117688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD7188B4E4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C48ABE50EA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3545A7A8;
	Mon, 25 Mar 2024 18:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="X4IynXHZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5104556771;
	Mon, 25 Mar 2024 18:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711390630; cv=none; b=CfdTH0tssw2uF5lk81SVVNQb2H9PLfSBXBrYmh1K5wYuHK5ALJ/e5LhPwfnXOeY6+TdOgbwwISd1myEiu2SPTrA2zVXZBCOD6ZoxcLn9Owrx1eg6MKoojHa7rmYg+++vqg14bepM/qJD8rGjmG07AnFhJdtV+3lBqbfJYD+I/O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711390630; c=relaxed/simple;
	bh=58Vii5USz2JDmZl/fAG+vKozHwYdZ+qXm1Wg65M7EZk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VlYifHu13/XB+lfXFIg8OH+Lq9hnRRlSEJWUhiEziMOQmNXFatwkVKMtkKDdAMwurlOnuNyiJZD1eIpAVsSSgHY+5AP8ZYh4ny568i3QW1kUJaXVARE+RaqHsbZkuHWY5On3BMtbQJGaEGlq3kSTOfq0H1MsjlZrPUWIBnDi8w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=X4IynXHZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42PFnN2v022142;
	Mon, 25 Mar 2024 18:17:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=a9YjfQCTWPZojqkhdk+a
	pqVRe07gEl2O5k20A2X0xG4=; b=X4IynXHZByahUMMST8IwjqWXMiOHdLf09U+g
	tL+ULrSWXMmZX/DbPRX98fIQyx4j4gj/DALS7cbm+Ejp632mnvoRP+YEffaPG+FZ
	vyn0yoTwXCp1TvNWRb5yqHFM+YLWbt3jTICHWBfPzFGovc64jWEGqLaKmG8Qf3Y5
	FmQm5xusi4ww+c6KQJbPu/wOqYuEB20WK10kkTmc0xeL7DdSlq0/W2Kgtd0dg7ys
	N26uAUlw0Rz+gWX9eMO0t5bvxCiXf6An1wC7Ep0dGWc4vE5N0iQm0NFL9V2pwWPu
	I4QlT1T/nU3zfRY3VUBWzISSULKpeUQ35JDhmEgjWbEFwZQ6Gw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x38am92c8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 18:17:02 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42PIH2XJ030861
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 18:17:02 GMT
Received: from hu-okukatla-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 25 Mar 2024 11:16:57 -0700
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
Subject: [PATCH v4 2/4] interconnect: qcom: sc7280: enable QoS programming
Date: Mon, 25 Mar 2024 23:46:26 +0530
Message-ID: <20240325181628.9407-3-quic_okukatla@quicinc.com>
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
X-Proofpoint-ORIG-GUID: WlKwcQCLg1vKU0J9INkZ5RSKOxgDqtGb
X-Proofpoint-GUID: WlKwcQCLg1vKU0J9INkZ5RSKOxgDqtGb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_16,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403250107

Enable QoS for the master ports with predefined values
for priority and urgency.

Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>
---
 drivers/interconnect/qcom/sc7280.c | 332 +++++++++++++++++++++++++++++
 1 file changed, 332 insertions(+)

diff --git a/drivers/interconnect/qcom/sc7280.c b/drivers/interconnect/qcom/sc7280.c
index 7d33694368e8..1e1002c4d3d8 100644
--- a/drivers/interconnect/qcom/sc7280.c
+++ b/drivers/interconnect/qcom/sc7280.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
  *
  */
 
@@ -16,29 +17,53 @@
 #include "icc-rpmh.h"
 #include "sc7280.h"
 
+static const struct qcom_icc_qosbox qhm_qspi_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x7000 },
+	.prio = 2,
+	.urg_fwd = 0,
+};
+
 static struct qcom_icc_node qhm_qspi = {
 	.name = "qhm_qspi",
 	.id = SC7280_MASTER_QSPI_0,
 	.channels = 1,
 	.buswidth = 4,
+	.qosbox = &qhm_qspi_qos,
 	.num_links = 1,
 	.links = { SC7280_SLAVE_A1NOC_SNOC },
 };
 
+static const struct qcom_icc_qosbox qhm_qup0_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x11000 },
+	.prio = 2,
+	.urg_fwd = 0,
+};
+
 static struct qcom_icc_node qhm_qup0 = {
 	.name = "qhm_qup0",
 	.id = SC7280_MASTER_QUP_0,
 	.channels = 1,
 	.buswidth = 4,
+	.qosbox = &qhm_qup0_qos,
 	.num_links = 1,
 	.links = { SC7280_SLAVE_A1NOC_SNOC },
 };
 
+static const struct qcom_icc_qosbox qhm_qup1_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x8000 },
+	.prio = 2,
+	.urg_fwd = 0,
+};
+
 static struct qcom_icc_node qhm_qup1 = {
 	.name = "qhm_qup1",
 	.id = SC7280_MASTER_QUP_1,
 	.channels = 1,
 	.buswidth = 4,
+	.qosbox = &qhm_qup1_qos,
 	.num_links = 1,
 	.links = { SC7280_SLAVE_A1NOC_SNOC },
 };
@@ -52,38 +77,70 @@ static struct qcom_icc_node qnm_a1noc_cfg = {
 	.links = { SC7280_SLAVE_SERVICE_A1NOC },
 };
 
+static const struct qcom_icc_qosbox xm_sdc1_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0xc000 },
+	.prio = 2,
+	.urg_fwd = 0,
+};
+
 static struct qcom_icc_node xm_sdc1 = {
 	.name = "xm_sdc1",
 	.id = SC7280_MASTER_SDCC_1,
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &xm_sdc1_qos,
 	.num_links = 1,
 	.links = { SC7280_SLAVE_A1NOC_SNOC },
 };
 
+static const struct qcom_icc_qosbox xm_sdc2_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0xe000 },
+	.prio = 2,
+	.urg_fwd = 0,
+};
+
 static struct qcom_icc_node xm_sdc2 = {
 	.name = "xm_sdc2",
 	.id = SC7280_MASTER_SDCC_2,
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &xm_sdc2_qos,
 	.num_links = 1,
 	.links = { SC7280_SLAVE_A1NOC_SNOC },
 };
 
+static const struct qcom_icc_qosbox xm_sdc4_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x9000 },
+	.prio = 2,
+	.urg_fwd = 0,
+};
+
 static struct qcom_icc_node xm_sdc4 = {
 	.name = "xm_sdc4",
 	.id = SC7280_MASTER_SDCC_4,
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &xm_sdc4_qos,
 	.num_links = 1,
 	.links = { SC7280_SLAVE_A1NOC_SNOC },
 };
 
+static const struct qcom_icc_qosbox xm_ufs_mem_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0xa000 },
+	.prio = 2,
+	.urg_fwd = 0,
+};
+
 static struct qcom_icc_node xm_ufs_mem = {
 	.name = "xm_ufs_mem",
 	.id = SC7280_MASTER_UFS_MEM,
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &xm_ufs_mem_qos,
 	.num_links = 1,
 	.links = { SC7280_SLAVE_A1NOC_SNOC },
 };
@@ -97,20 +154,36 @@ static struct qcom_icc_node xm_usb2 = {
 	.links = { SC7280_SLAVE_A1NOC_SNOC },
 };
 
+static const struct qcom_icc_qosbox xm_usb3_0_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0xb000 },
+	.prio = 2,
+	.urg_fwd = 0,
+};
+
 static struct qcom_icc_node xm_usb3_0 = {
 	.name = "xm_usb3_0",
 	.id = SC7280_MASTER_USB3_0,
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &xm_usb3_0_qos,
 	.num_links = 1,
 	.links = { SC7280_SLAVE_A1NOC_SNOC },
 };
 
+static const struct qcom_icc_qosbox qhm_qdss_bam_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x18000 },
+	.prio = 2,
+	.urg_fwd = 0,
+};
+
 static struct qcom_icc_node qhm_qdss_bam = {
 	.name = "qhm_qdss_bam",
 	.id = SC7280_MASTER_QDSS_BAM,
 	.channels = 1,
 	.buswidth = 4,
+	.qosbox = &qhm_qdss_bam_qos,
 	.num_links = 1,
 	.links = { SC7280_SLAVE_A2NOC_SNOC },
 };
@@ -124,29 +197,53 @@ static struct qcom_icc_node qnm_a2noc_cfg = {
 	.links = { SC7280_SLAVE_SERVICE_A2NOC },
 };
 
+static const struct qcom_icc_qosbox qnm_cnoc_datapath_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x1c000 },
+	.prio = 2,
+	.urg_fwd = 0,
+};
+
 static struct qcom_icc_node qnm_cnoc_datapath = {
 	.name = "qnm_cnoc_datapath",
 	.id = SC7280_MASTER_CNOC_A2NOC,
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &qnm_cnoc_datapath_qos,
 	.num_links = 1,
 	.links = { SC7280_SLAVE_A2NOC_SNOC },
 };
 
+static const struct qcom_icc_qosbox qxm_crypto_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x1d000 },
+	.prio = 2,
+	.urg_fwd = 0,
+};
+
 static struct qcom_icc_node qxm_crypto = {
 	.name = "qxm_crypto",
 	.id = SC7280_MASTER_CRYPTO,
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &qxm_crypto_qos,
 	.num_links = 1,
 	.links = { SC7280_SLAVE_A2NOC_SNOC },
 };
 
+static const struct qcom_icc_qosbox qxm_ipa_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x10000 },
+	.prio = 2,
+	.urg_fwd = 0,
+};
+
 static struct qcom_icc_node qxm_ipa = {
 	.name = "qxm_ipa",
 	.id = SC7280_MASTER_IPA,
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &qxm_ipa_qos,
 	.num_links = 1,
 	.links = { SC7280_SLAVE_A2NOC_SNOC },
 };
@@ -168,11 +265,19 @@ static struct qcom_icc_node xm_pcie3_1 = {
 	.links = { SC7280_SLAVE_ANOC_PCIE_GEM_NOC },
 };
 
+static const struct qcom_icc_qosbox xm_qdss_etr_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x15000 },
+	.prio = 2,
+	.urg_fwd = 0,
+};
+
 static struct qcom_icc_node xm_qdss_etr = {
 	.name = "xm_qdss_etr",
 	.id = SC7280_MASTER_QDSS_ETR,
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &xm_qdss_etr_qos,
 	.num_links = 1,
 	.links = { SC7280_SLAVE_A2NOC_SNOC },
 };
@@ -300,20 +405,36 @@ static struct qcom_icc_node qnm_cnoc_dc_noc = {
 	.links = { SC7280_SLAVE_LLCC_CFG, SC7280_SLAVE_GEM_NOC_CFG },
 };
 
+static const struct qcom_icc_qosbox alm_gpu_tcu_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0xd7000 },
+	.prio = 2,
+	.urg_fwd = 0,
+};
+
 static struct qcom_icc_node alm_gpu_tcu = {
 	.name = "alm_gpu_tcu",
 	.id = SC7280_MASTER_GPU_TCU,
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &alm_gpu_tcu_qos,
 	.num_links = 2,
 	.links = { SC7280_SLAVE_GEM_NOC_CNOC, SC7280_SLAVE_LLCC },
 };
 
+static const struct qcom_icc_qosbox alm_sys_tcu_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0xd6000 },
+	.prio = 6,
+	.urg_fwd = 0,
+};
+
 static struct qcom_icc_node alm_sys_tcu = {
 	.name = "alm_sys_tcu",
 	.id = SC7280_MASTER_SYS_TCU,
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &alm_sys_tcu_qos,
 	.num_links = 2,
 	.links = { SC7280_SLAVE_GEM_NOC_CNOC, SC7280_SLAVE_LLCC },
 };
@@ -328,11 +449,19 @@ static struct qcom_icc_node chm_apps = {
 		   SC7280_SLAVE_MEM_NOC_PCIE_SNOC },
 };
 
+static const struct qcom_icc_qosbox qnm_cmpnoc_qos = {
+	.num_ports = 2,
+	.port_offsets = { 0x21000, 0x61000 },
+	.prio = 0,
+	.urg_fwd = 1,
+};
+
 static struct qcom_icc_node qnm_cmpnoc = {
 	.name = "qnm_cmpnoc",
 	.id = SC7280_MASTER_COMPUTE_NOC,
 	.channels = 2,
 	.buswidth = 32,
+	.qosbox = &qnm_cmpnoc_qos,
 	.num_links = 2,
 	.links = { SC7280_SLAVE_GEM_NOC_CNOC, SC7280_SLAVE_LLCC },
 };
@@ -348,29 +477,53 @@ static struct qcom_icc_node qnm_gemnoc_cfg = {
 		   SC7280_SLAVE_SERVICE_GEM_NOC },
 };
 
+static const struct qcom_icc_qosbox qnm_gpu_qos = {
+	.num_ports = 2,
+	.port_offsets = { 0x22000, 0x62000 },
+	.prio = 0,
+	.urg_fwd = 0,
+};
+
 static struct qcom_icc_node qnm_gpu = {
 	.name = "qnm_gpu",
 	.id = SC7280_MASTER_GFX3D,
 	.channels = 2,
 	.buswidth = 32,
+	.qosbox = &qnm_gpu_qos,
 	.num_links = 2,
 	.links = { SC7280_SLAVE_GEM_NOC_CNOC, SC7280_SLAVE_LLCC },
 };
 
+static const struct qcom_icc_qosbox qnm_mnoc_hf_qos = {
+	.num_ports = 2,
+	.port_offsets = { 0x23000, 0x63000 },
+	.prio = 0,
+	.urg_fwd = 1,
+};
+
 static struct qcom_icc_node qnm_mnoc_hf = {
 	.name = "qnm_mnoc_hf",
 	.id = SC7280_MASTER_MNOC_HF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
+	.qosbox = &qnm_mnoc_hf_qos,
 	.num_links = 1,
 	.links = { SC7280_SLAVE_LLCC },
 };
 
+static const struct qcom_icc_qosbox qnm_mnoc_sf_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0xcf000 },
+	.prio = 0,
+	.urg_fwd = 1,
+};
+
 static struct qcom_icc_node qnm_mnoc_sf = {
 	.name = "qnm_mnoc_sf",
 	.id = SC7280_MASTER_MNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 32,
+	.qosbox = &qnm_mnoc_sf_qos,
 	.num_links = 2,
 	.links = { SC7280_SLAVE_GEM_NOC_CNOC, SC7280_SLAVE_LLCC },
 };
@@ -384,20 +537,36 @@ static struct qcom_icc_node qnm_pcie = {
 	.links = { SC7280_SLAVE_GEM_NOC_CNOC, SC7280_SLAVE_LLCC },
 };
 
+static const struct qcom_icc_qosbox qnm_snoc_gc_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0xd3000 },
+	.prio = 0,
+	.urg_fwd = 1,
+};
+
 static struct qcom_icc_node qnm_snoc_gc = {
 	.name = "qnm_snoc_gc",
 	.id = SC7280_MASTER_SNOC_GC_MEM_NOC,
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &qnm_snoc_gc_qos,
 	.num_links = 1,
 	.links = { SC7280_SLAVE_LLCC },
 };
 
+static const struct qcom_icc_qosbox qnm_snoc_sf_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0xd4000 },
+	.prio = 0,
+	.urg_fwd = 1,
+};
+
 static struct qcom_icc_node qnm_snoc_sf = {
 	.name = "qnm_snoc_sf",
 	.id = SC7280_MASTER_SNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
+	.qosbox = &qnm_snoc_sf_qos,
 	.num_links = 3,
 	.links = { SC7280_SLAVE_GEM_NOC_CNOC, SC7280_SLAVE_LLCC,
 		   SC7280_SLAVE_MEM_NOC_PCIE_SNOC },
@@ -432,56 +601,104 @@ static struct qcom_icc_node qnm_mnoc_cfg = {
 	.links = { SC7280_SLAVE_SERVICE_MNOC },
 };
 
+static const struct qcom_icc_qosbox qnm_video0_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x14000 },
+	.prio = 0,
+	.urg_fwd = 1,
+};
+
 static struct qcom_icc_node qnm_video0 = {
 	.name = "qnm_video0",
 	.id = SC7280_MASTER_VIDEO_P0,
 	.channels = 1,
 	.buswidth = 32,
+	.qosbox = &qnm_video0_qos,
 	.num_links = 1,
 	.links = { SC7280_SLAVE_MNOC_SF_MEM_NOC },
 };
 
+static const struct qcom_icc_qosbox qnm_video_cpu_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x15000 },
+	.prio = 0,
+	.urg_fwd = 1,
+};
+
 static struct qcom_icc_node qnm_video_cpu = {
 	.name = "qnm_video_cpu",
 	.id = SC7280_MASTER_VIDEO_PROC,
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &qnm_video_cpu_qos,
 	.num_links = 1,
 	.links = { SC7280_SLAVE_MNOC_SF_MEM_NOC },
 };
 
+static const struct qcom_icc_qosbox qxm_camnoc_hf_qos = {
+	.num_ports = 2,
+	.port_offsets = { 0x10000, 0x10180 },
+	.prio = 0,
+	.urg_fwd = 1,
+};
+
 static struct qcom_icc_node qxm_camnoc_hf = {
 	.name = "qxm_camnoc_hf",
 	.id = SC7280_MASTER_CAMNOC_HF,
 	.channels = 2,
 	.buswidth = 32,
+	.qosbox = &qxm_camnoc_hf_qos,
 	.num_links = 1,
 	.links = { SC7280_SLAVE_MNOC_HF_MEM_NOC },
 };
 
+static const struct qcom_icc_qosbox qxm_camnoc_icp_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x11000 },
+	.prio = 0,
+	.urg_fwd = 1,
+};
+
 static struct qcom_icc_node qxm_camnoc_icp = {
 	.name = "qxm_camnoc_icp",
 	.id = SC7280_MASTER_CAMNOC_ICP,
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &qxm_camnoc_icp_qos,
 	.num_links = 1,
 	.links = { SC7280_SLAVE_MNOC_SF_MEM_NOC },
 };
 
+static const struct qcom_icc_qosbox qxm_camnoc_sf_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x12000 },
+	.prio = 0,
+	.urg_fwd = 1,
+};
+
 static struct qcom_icc_node qxm_camnoc_sf = {
 	.name = "qxm_camnoc_sf",
 	.id = SC7280_MASTER_CAMNOC_SF,
 	.channels = 1,
 	.buswidth = 32,
+	.qosbox = &qxm_camnoc_sf_qos,
 	.num_links = 1,
 	.links = { SC7280_SLAVE_MNOC_SF_MEM_NOC },
 };
 
+static const struct qcom_icc_qosbox qxm_mdp0_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x16000 },
+	.prio = 0,
+	.urg_fwd = 1,
+};
+
 static struct qcom_icc_node qxm_mdp0 = {
 	.name = "qxm_mdp0",
 	.id = SC7280_MASTER_MDP0,
 	.channels = 1,
 	.buswidth = 32,
+	.qosbox = &qxm_mdp0_qos,
 	.num_links = 1,
 	.links = { SC7280_SLAVE_MNOC_HF_MEM_NOC },
 };
@@ -531,20 +748,36 @@ static struct qcom_icc_node qnm_snoc_cfg = {
 	.links = { SC7280_SLAVE_SERVICE_SNOC },
 };
 
+static const struct qcom_icc_qosbox qxm_pimem_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x8000 },
+	.prio = 2,
+	.urg_fwd = 0,
+};
+
 static struct qcom_icc_node qxm_pimem = {
 	.name = "qxm_pimem",
 	.id = SC7280_MASTER_PIMEM,
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &qxm_pimem_qos,
 	.num_links = 1,
 	.links = { SC7280_SLAVE_SNOC_GEM_NOC_GC },
 };
 
+static const struct qcom_icc_qosbox xm_gic_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0xa000 },
+	.prio = 2,
+	.urg_fwd = 0,
+};
+
 static struct qcom_icc_node xm_gic = {
 	.name = "xm_gic",
 	.id = SC7280_MASTER_GIC,
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &xm_gic_qos,
 	.num_links = 1,
 	.links = { SC7280_SLAVE_SNOC_GEM_NOC_GC },
 };
@@ -1502,7 +1735,16 @@ static struct qcom_icc_node * const aggre1_noc_nodes[] = {
 	[SLAVE_SERVICE_A1NOC] = &srvc_aggre1_noc,
 };
 
+static const struct regmap_config sc7280_aggre1_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x1c080,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc sc7280_aggre1_noc = {
+	.config = &sc7280_aggre1_noc_regmap_config,
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 	.bcms = aggre1_noc_bcms,
@@ -1513,6 +1755,14 @@ static struct qcom_icc_bcm * const aggre2_noc_bcms[] = {
 	&bcm_ce0,
 };
 
+static const struct regmap_config sc7280_aggre2_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x2b080,
+	.fast_io = true,
+};
+
 static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 	[MASTER_QDSS_BAM] = &qhm_qdss_bam,
 	[MASTER_A2NOC_CFG] = &qnm_a2noc_cfg,
@@ -1525,6 +1775,7 @@ static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc7280_aggre2_noc = {
+	.config = &sc7280_aggre2_noc_regmap_config,
 	.nodes = aggre2_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
 	.bcms = aggre2_noc_bcms,
@@ -1605,7 +1856,16 @@ static struct qcom_icc_node * const cnoc2_nodes[] = {
 	[SLAVE_SNOC_CFG] = &qns_snoc_cfg,
 };
 
+static const struct regmap_config sc7280_cnoc2_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x1000,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc sc7280_cnoc2 = {
+	.config = &sc7280_cnoc2_regmap_config,
 	.nodes = cnoc2_nodes,
 	.num_nodes = ARRAY_SIZE(cnoc2_nodes),
 	.bcms = cnoc2_bcms,
@@ -1637,7 +1897,16 @@ static struct qcom_icc_node * const cnoc3_nodes[] = {
 	[SLAVE_TCU] = &xs_sys_tcu_cfg,
 };
 
+static const struct regmap_config sc7280_cnoc3_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x1000,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc sc7280_cnoc3 = {
+	.config = &sc7280_cnoc3_regmap_config,
 	.nodes = cnoc3_nodes,
 	.num_nodes = ARRAY_SIZE(cnoc3_nodes),
 	.bcms = cnoc3_bcms,
@@ -1653,7 +1922,16 @@ static struct qcom_icc_node * const dc_noc_nodes[] = {
 	[SLAVE_GEM_NOC_CFG] = &qns_gemnoc,
 };
 
+static const struct regmap_config sc7280_dc_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x5080,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc sc7280_dc_noc = {
+	.config = &sc7280_dc_noc_regmap_config,
 	.nodes = dc_noc_nodes,
 	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
 	.bcms = dc_noc_bcms,
@@ -1689,7 +1967,16 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
 	[SLAVE_SERVICE_GEM_NOC] = &srvc_sys_gemnoc,
 };
 
+static const struct regmap_config sc7280_gem_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0xe2200,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc sc7280_gem_noc = {
+	.config = &sc7280_gem_noc_regmap_config,
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
 	.bcms = gem_noc_bcms,
@@ -1709,7 +1996,16 @@ static struct qcom_icc_node * const lpass_ag_noc_nodes[] = {
 	[SLAVE_SERVICE_LPASS_AG_NOC] = &srvc_niu_lpass_agnoc,
 };
 
+static const struct regmap_config sc7280_lpass_ag_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0xf080,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc sc7280_lpass_ag_noc = {
+	.config = &sc7280_lpass_ag_noc_regmap_config,
 	.nodes = lpass_ag_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_ag_noc_nodes),
 	.bcms = lpass_ag_noc_bcms,
@@ -1726,7 +2022,16 @@ static struct qcom_icc_node * const mc_virt_nodes[] = {
 	[SLAVE_EBI1] = &ebi,
 };
 
+static const struct regmap_config sc7280_mc_virt_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x4,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc sc7280_mc_virt = {
+	.config = &sc7280_mc_virt_regmap_config,
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
@@ -1753,7 +2058,16 @@ static struct qcom_icc_node * const mmss_noc_nodes[] = {
 	[SLAVE_SERVICE_MNOC] = &srvc_mnoc,
 };
 
+static const struct regmap_config sc7280_mmss_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x1e080,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc sc7280_mmss_noc = {
+	.config = &sc7280_mmss_noc_regmap_config,
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
 	.bcms = mmss_noc_bcms,
@@ -1772,7 +2086,16 @@ static struct qcom_icc_node * const nsp_noc_nodes[] = {
 	[SLAVE_SERVICE_NSP_NOC] = &service_nsp_noc,
 };
 
+static const struct regmap_config sc7280_nsp_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x10000,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc sc7280_nsp_noc = {
+	.config = &sc7280_nsp_noc_regmap_config,
 	.nodes = nsp_noc_nodes,
 	.num_nodes = ARRAY_SIZE(nsp_noc_nodes),
 	.bcms = nsp_noc_bcms,
@@ -1797,7 +2120,16 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 	[SLAVE_SERVICE_SNOC] = &srvc_snoc,
 };
 
+static const struct regmap_config sc7280_system_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x15480,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc sc7280_system_noc = {
+	.config = &sc7280_system_noc_regmap_config,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
-- 
2.17.1


