Return-Path: <linux-kernel+bounces-33160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE37283656A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D33B41C238C6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA7F219E1;
	Mon, 22 Jan 2024 14:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="U1pvw+BD"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767A53D550;
	Mon, 22 Jan 2024 14:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705933879; cv=none; b=WkJRxFyxl/sLm1YrcZzMaGTGmmMaHbXaAH0AOFtqwOvIiqFwU/mwvwq3X/mXkoFHflQSSFsKiYEApq0FvU8cEIIgMDtHCgy34RIZ1lzB9uNSTu2VRX3FcoIzLThMTI4nK4udetQUd+LRb/rScezRw36FsTVEq/GJP8yzIKcedW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705933879; c=relaxed/simple;
	bh=n6/Wm9uq6jQFOeztnGQBRjL1epRV9c4NE00JXIJe1Ls=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mcJg/jz9x6VbT+hluHXzJ/wUXHb17TxRlipI7fNA/emMAFKJj7SKJSVuVfBcAsvFNjgea5az6p8SFDMXvg32YbDXxfJliDZMRyRQIdelTCyimsRloyeTAYrmrD6KJ5Q+8RUUi/iSWHvs5OVhw1eDmYl4sB0pPqwhkrqhmAe/TRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=U1pvw+BD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40MCl3Li026658;
	Mon, 22 Jan 2024 14:31:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=z2kjwOLOuKlWXjG+J6gD
	u49OXXkPcmB6fgFPvYuP1bw=; b=U1pvw+BDNVww4kyKmC+dQqp83cw7G0imbNnf
	rx9fK3HkgX7JNx0sf4fyV+R7zQhbHy8GGokVpQPU5sDxjgWEaA6Q/FjK8deJZg7I
	2j0qo7LrAazzptpOA9zY9Bi5IGycBZKwtql4Fo86nx0bs7B++ubGCAYxihcTupnx
	YOB3PHEx5nxN6lmLtN5VTyaK57rjqBmEMgpentWrkDH8J3WiD9q/CIDdAi+QBLGJ
	slNXQUHDdzAaqLiZYAN520afsAh065AjWQo7LziRpPd1HWZWy3CLxQpxKYHOimDP
	aR8O1eXHIIWn5golxqs3iXmTyM6ZPVV08R6qGpIT1j8r17pVFQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vr7bqm4p6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 14:31:12 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40MEVBG8013314
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 14:31:11 GMT
Received: from hu-okukatla-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 22 Jan 2024 06:31:09 -0800
From: Odelu Kukatla <quic_okukatla@quicinc.com>
To: <georgi.djakov@linaro.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad
 Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [2/4] interconnect: qcom: sc7280: enable qos programming
Date: Mon, 22 Jan 2024 20:00:28 +0530
Message-ID: <20240122143030.11904-3-quic_okukatla@quicinc.com>
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
X-Proofpoint-GUID: je0jS25zwT9GyZoS4JGt0a3ED3u47HbH
X-Proofpoint-ORIG-GUID: je0jS25zwT9GyZoS4JGt0a3ED3u47HbH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_05,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0
 clxscore=1015 spamscore=0 mlxlogscore=875 mlxscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401220098

Enable QoS for the master ports with predefined values
for priority and urgency.

Change-Id: I1c4515402bcd6df8eed814be096aa5e1fc16cef6
Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>
---
 drivers/interconnect/qcom/sc7280.c | 250 +++++++++++++++++++++++++++++
 1 file changed, 250 insertions(+)

diff --git a/drivers/interconnect/qcom/sc7280.c b/drivers/interconnect/qcom/sc7280.c
index 7d33694368e8..719844c34894 100644
--- a/drivers/interconnect/qcom/sc7280.c
+++ b/drivers/interconnect/qcom/sc7280.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
  *
  */
 
@@ -16,29 +17,59 @@
 #include "icc-rpmh.h"
 #include "sc7280.h"
 
+static const struct regmap_config icc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+};
+
+static struct qcom_icc_qosbox qhm_qspi_qos = {
+	.num_ports = 1,
+	.offsets = { 0x7000 },
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
 
+static struct qcom_icc_qosbox qhm_qup0_qos = {
+	.num_ports = 1,
+	.offsets = { 0x11000 },
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
 
+static struct qcom_icc_qosbox qhm_qup1_qos = {
+	.num_ports = 1,
+	.offsets = { 0x8000 },
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
@@ -52,38 +83,70 @@ static struct qcom_icc_node qnm_a1noc_cfg = {
 	.links = { SC7280_SLAVE_SERVICE_A1NOC },
 };
 
+static struct qcom_icc_qosbox xm_sdc1_qos = {
+	.num_ports = 1,
+	.offsets = { 0xc000 },
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
 
+static struct qcom_icc_qosbox xm_sdc2_qos = {
+	.num_ports = 1,
+	.offsets = { 0xe000 },
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
 
+static struct qcom_icc_qosbox xm_sdc4_qos = {
+	.num_ports = 1,
+	.offsets = { 0x9000 },
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
 
+static struct qcom_icc_qosbox xm_ufs_mem_qos = {
+	.num_ports = 1,
+	.offsets = { 0xa000 },
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
@@ -97,20 +160,36 @@ static struct qcom_icc_node xm_usb2 = {
 	.links = { SC7280_SLAVE_A1NOC_SNOC },
 };
 
+static struct qcom_icc_qosbox xm_usb3_0_qos = {
+	.num_ports = 1,
+	.offsets = { 0xb000 },
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
 
+static struct qcom_icc_qosbox qhm_qdss_bam_qos = {
+	.num_ports = 1,
+	.offsets = { 0x18000 },
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
@@ -124,29 +203,53 @@ static struct qcom_icc_node qnm_a2noc_cfg = {
 	.links = { SC7280_SLAVE_SERVICE_A2NOC },
 };
 
+static struct qcom_icc_qosbox qnm_cnoc_datapath_qos = {
+	.num_ports = 1,
+	.offsets = { 0x1c000 },
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
 
+static struct qcom_icc_qosbox qxm_crypto_qos = {
+	.num_ports = 1,
+	.offsets = { 0x1d000 },
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
 
+static struct qcom_icc_qosbox qxm_ipa_qos = {
+	.num_ports = 1,
+	.offsets = { 0x10000 },
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
@@ -168,11 +271,19 @@ static struct qcom_icc_node xm_pcie3_1 = {
 	.links = { SC7280_SLAVE_ANOC_PCIE_GEM_NOC },
 };
 
+static struct qcom_icc_qosbox xm_qdss_etr_qos = {
+	.num_ports = 1,
+	.offsets = { 0x15000 },
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
@@ -300,20 +411,36 @@ static struct qcom_icc_node qnm_cnoc_dc_noc = {
 	.links = { SC7280_SLAVE_LLCC_CFG, SC7280_SLAVE_GEM_NOC_CFG },
 };
 
+static struct qcom_icc_qosbox alm_gpu_tcu_qos = {
+	.num_ports = 1,
+	.offsets = { 0xd7000 },
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
 
+static struct qcom_icc_qosbox alm_sys_tcu_qos = {
+	.num_ports = 1,
+	.offsets = { 0xd6000 },
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
@@ -328,11 +455,19 @@ static struct qcom_icc_node chm_apps = {
 		   SC7280_SLAVE_MEM_NOC_PCIE_SNOC },
 };
 
+static struct qcom_icc_qosbox qnm_cmpnoc_qos = {
+	.num_ports = 2,
+	.offsets = { 0x21000, 0x61000 },
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
@@ -348,29 +483,53 @@ static struct qcom_icc_node qnm_gemnoc_cfg = {
 		   SC7280_SLAVE_SERVICE_GEM_NOC },
 };
 
+static struct qcom_icc_qosbox qnm_gpu_qos = {
+	.num_ports = 2,
+	.offsets = { 0x22000, 0x62000 },
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
 
+static struct qcom_icc_qosbox qnm_mnoc_hf_qos = {
+	.num_ports = 2,
+	.offsets = { 0x23000, 0x63000 },
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
 
+static struct qcom_icc_qosbox qnm_mnoc_sf_qos = {
+	.num_ports = 1,
+	.offsets = { 0xcf000 },
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
@@ -384,20 +543,36 @@ static struct qcom_icc_node qnm_pcie = {
 	.links = { SC7280_SLAVE_GEM_NOC_CNOC, SC7280_SLAVE_LLCC },
 };
 
+static struct qcom_icc_qosbox qnm_snoc_gc_qos = {
+	.num_ports = 1,
+	.offsets = { 0xd3000 },
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
 
+static struct qcom_icc_qosbox qnm_snoc_sf_qos = {
+	.num_ports = 1,
+	.offsets = { 0xd4000 },
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
@@ -432,56 +607,104 @@ static struct qcom_icc_node qnm_mnoc_cfg = {
 	.links = { SC7280_SLAVE_SERVICE_MNOC },
 };
 
+static struct qcom_icc_qosbox qnm_video0_qos = {
+	.num_ports = 1,
+	.offsets = { 0x14000 },
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
 
+static struct qcom_icc_qosbox qnm_video_cpu_qos = {
+	.num_ports = 1,
+	.offsets = { 0x15000 },
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
 
+static struct qcom_icc_qosbox qxm_camnoc_hf_qos = {
+	.num_ports = 2,
+	.offsets = { 0x10000, 0x10180 },
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
 
+static struct qcom_icc_qosbox qxm_camnoc_icp_qos = {
+	.num_ports = 1,
+	.offsets = { 0x11000 },
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
 
+static struct qcom_icc_qosbox qxm_camnoc_sf_qos = {
+	.num_ports = 1,
+	.offsets = { 0x12000 },
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
 
+static struct qcom_icc_qosbox qxm_mdp0_qos = {
+	.num_ports = 1,
+	.offsets = { 0x16000 },
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
@@ -531,20 +754,36 @@ static struct qcom_icc_node qnm_snoc_cfg = {
 	.links = { SC7280_SLAVE_SERVICE_SNOC },
 };
 
+static struct qcom_icc_qosbox qxm_pimem_qos = {
+	.num_ports = 1,
+	.offsets = { 0x8000 },
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
 
+static struct qcom_icc_qosbox xm_gic_qos = {
+	.num_ports = 1,
+	.offsets = { 0xa000 },
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
@@ -1503,6 +1742,7 @@ static struct qcom_icc_node * const aggre1_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc7280_aggre1_noc = {
+	.config = &icc_regmap_config,
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 	.bcms = aggre1_noc_bcms,
@@ -1525,6 +1765,7 @@ static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc7280_aggre2_noc = {
+	.config = &icc_regmap_config,
 	.nodes = aggre2_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
 	.bcms = aggre2_noc_bcms,
@@ -1606,6 +1847,7 @@ static struct qcom_icc_node * const cnoc2_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc7280_cnoc2 = {
+	.config = &icc_regmap_config,
 	.nodes = cnoc2_nodes,
 	.num_nodes = ARRAY_SIZE(cnoc2_nodes),
 	.bcms = cnoc2_bcms,
@@ -1638,6 +1880,7 @@ static struct qcom_icc_node * const cnoc3_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc7280_cnoc3 = {
+	.config = &icc_regmap_config,
 	.nodes = cnoc3_nodes,
 	.num_nodes = ARRAY_SIZE(cnoc3_nodes),
 	.bcms = cnoc3_bcms,
@@ -1654,6 +1897,7 @@ static struct qcom_icc_node * const dc_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc7280_dc_noc = {
+	.config = &icc_regmap_config,
 	.nodes = dc_noc_nodes,
 	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
 	.bcms = dc_noc_bcms,
@@ -1690,6 +1934,7 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc7280_gem_noc = {
+	.config = &icc_regmap_config,
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
 	.bcms = gem_noc_bcms,
@@ -1710,6 +1955,7 @@ static struct qcom_icc_node * const lpass_ag_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc7280_lpass_ag_noc = {
+	.config = &icc_regmap_config,
 	.nodes = lpass_ag_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_ag_noc_nodes),
 	.bcms = lpass_ag_noc_bcms,
@@ -1727,6 +1973,7 @@ static struct qcom_icc_node * const mc_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc7280_mc_virt = {
+	.config = &icc_regmap_config,
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
@@ -1754,6 +2001,7 @@ static struct qcom_icc_node * const mmss_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc7280_mmss_noc = {
+	.config = &icc_regmap_config,
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
 	.bcms = mmss_noc_bcms,
@@ -1773,6 +2021,7 @@ static struct qcom_icc_node * const nsp_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc7280_nsp_noc = {
+	.config = &icc_regmap_config,
 	.nodes = nsp_noc_nodes,
 	.num_nodes = ARRAY_SIZE(nsp_noc_nodes),
 	.bcms = nsp_noc_bcms,
@@ -1798,6 +2047,7 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc7280_system_noc = {
+	.config = &icc_regmap_config,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


