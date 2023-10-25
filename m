Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8167D6D7D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 15:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343719AbjJYNlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 09:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234735AbjJYNld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 09:41:33 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E50E138;
        Wed, 25 Oct 2023 06:41:27 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PCPILP025706;
        Wed, 25 Oct 2023 13:41:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=yxRxS7WkdNDoBm5muKLLarCqQXMTUU5V43T5VrYss94=;
 b=g+BfeKks1izfrrajPFxXz5VZG8RQbqkoibyoduP1/enWoEo3hk8oM/CNUe1asFIVkbWh
 wpxEc58vQn7mSPNKUoP/3oHciNSghged4dAhKQ8UiyXlqBvTv11Y1113RwpQHD8bKaz0
 0YpBZHNi5+Ez8ty3ynd92gCxGMyDTSMtdhVLOOoDVK1BxJP586AD9aMa/bSaRNLl8jGC
 QFzaREF6Dyf4iTCsCbe4oigYYMEmthlz6iM8obmafPRtWHdDueBa5wAetK74zv709S7b
 yYwNZGUuPRQ4XpPdhOCaRyj+bkR5EurlynarRfV3j4grxpedHdH8keK9gANBABhtyy6k Dg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3txtbf15hj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 13:41:20 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39PDfJsQ001979
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 13:41:19 GMT
Received: from blr-ubuntu-87.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 25 Oct 2023 06:41:13 -0700
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <andersson@kernel.org>, <djakov@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <agross@kernel.org>, <conor+dt@kernel.org>,
        <quic_rjendra@quicinc.com>, <abel.vesa@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_tsoni@quicinc.com>, <neil.armstrong@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH 2/2] interconnect: qcom: Add SC8380XP interconnect provider driver
Date:   Wed, 25 Oct 2023 19:10:49 +0530
Message-ID: <20231025134049.9734-3-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231025134049.9734-1-quic_sibis@quicinc.com>
References: <20231025134049.9734-1-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Lr9BA9rzG9ORrjzYxNduIhudA-LSQkBT
X-Proofpoint-ORIG-GUID: Lr9BA9rzG9ORrjzYxNduIhudA-LSQkBT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_02,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 clxscore=1015 bulkscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310250118
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajendra Nayak <quic_rjendra@quicinc.com>

Add driver for the Qualcomm interconnect buses found in SC8380XP based
platforms. The topology consists of several NoCs that are controlled by
a remote processor that collects the aggregated bandwidth for each
master-slave pairs.

Co-developed-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 drivers/interconnect/qcom/Kconfig    |    9 +
 drivers/interconnect/qcom/Makefile   |    2 +
 drivers/interconnect/qcom/sc8380xp.c | 2328 ++++++++++++++++++++++++++
 drivers/interconnect/qcom/sc8380xp.h |  192 +++
 4 files changed, 2531 insertions(+)
 create mode 100644 drivers/interconnect/qcom/sc8380xp.c
 create mode 100644 drivers/interconnect/qcom/sc8380xp.h

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index 62b516d38d03..03233684c6d2 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -137,6 +137,15 @@ config INTERCONNECT_QCOM_SC8280XP
 	  This is a driver for the Qualcomm Network-on-Chip on SC8280XP-based
 	  platforms.
 
+config INTERCONNECT_QCOM_SC8380XP
+	tristate "Qualcomm SC8380XP interconnect driver"
+	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	select INTERCONNECT_QCOM_RPMH
+	select INTERCONNECT_QCOM_BCM_VOTER
+	help
+	  This is a driver for the Qualcomm Network-on-Chip on SC8380XP-based
+	  platforms.
+
 config INTERCONNECT_QCOM_SDM660
 	tristate "Qualcomm SDM660 interconnect driver"
 	depends on INTERCONNECT_QCOM
diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
index c5320e293960..ffa838eb94da 100644
--- a/drivers/interconnect/qcom/Makefile
+++ b/drivers/interconnect/qcom/Makefile
@@ -18,6 +18,7 @@ qnoc-sc7180-objs			:= sc7180.o
 qnoc-sc7280-objs                        := sc7280.o
 qnoc-sc8180x-objs			:= sc8180x.o
 qnoc-sc8280xp-objs			:= sc8280xp.o
+qnoc-sc8380xp-objs			:= sc8380xp.o
 qnoc-sdm660-objs			:= sdm660.o
 qnoc-sdm670-objs			:= sdm670.o
 qnoc-sdm845-objs			:= sdm845.o
@@ -47,6 +48,7 @@ obj-$(CONFIG_INTERCONNECT_QCOM_SC7180) += qnoc-sc7180.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SC7280) += qnoc-sc7280.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SC8180X) += qnoc-sc8180x.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SC8280XP) += qnoc-sc8280xp.o
+obj-$(CONFIG_INTERCONNECT_QCOM_SC8380XP) += qnoc-sc8380xp.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SDM660) += qnoc-sdm660.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SDM670) += qnoc-sdm670.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SDM845) += qnoc-sdm845.o
diff --git a/drivers/interconnect/qcom/sc8380xp.c b/drivers/interconnect/qcom/sc8380xp.c
new file mode 100644
index 000000000000..7c98d4ea913e
--- /dev/null
+++ b/drivers/interconnect/qcom/sc8380xp.c
@@ -0,0 +1,2328 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2023, Linaro Limited
+ *
+ */
+
+#include <linux/device.h>
+#include <linux/interconnect.h>
+#include <linux/interconnect-provider.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <dt-bindings/interconnect/qcom,sc8380xp-rpmh.h>
+
+#include "bcm-voter.h"
+#include "icc-common.h"
+#include "icc-rpmh.h"
+#include "sc8380xp.h"
+
+static struct qcom_icc_node qhm_qspi = {
+	.name = "qhm_qspi",
+	.id = SC8380XP_MASTER_QSPI_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node qhm_qup1 = {
+	.name = "qhm_qup1",
+	.id = SC8380XP_MASTER_QUP_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_sdc4 = {
+	.name = "xm_sdc4",
+	.id = SC8380XP_MASTER_SDCC_4,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_ufs_mem = {
+	.name = "xm_ufs_mem",
+	.id = SC8380XP_MASTER_UFS_MEM,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node qhm_qup0 = {
+	.name = "qhm_qup0",
+	.id = SC8380XP_MASTER_QUP_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qhm_qup2 = {
+	.name = "qhm_qup2",
+	.id = SC8380XP_MASTER_QUP_2,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qxm_crypto = {
+	.name = "qxm_crypto",
+	.id = SC8380XP_MASTER_CRYPTO,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qxm_sp = {
+	.name = "qxm_sp",
+	.id = SC8380XP_MASTER_SP,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_qdss_etr_0 = {
+	.name = "xm_qdss_etr_0",
+	.id = SC8380XP_MASTER_QDSS_ETR,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_qdss_etr_1 = {
+	.name = "xm_qdss_etr_1",
+	.id = SC8380XP_MASTER_QDSS_ETR_1,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_sdc2 = {
+	.name = "xm_sdc2",
+	.id = SC8380XP_MASTER_SDCC_2,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node ddr_perf_mode_master = {
+	.name = "ddr_perf_mode_master",
+	.id = SC8380XP_MASTER_DDR_PERF_MODE,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_DDR_PERF_MODE },
+};
+
+static struct qcom_icc_node qup0_core_master = {
+	.name = "qup0_core_master",
+	.id = SC8380XP_MASTER_QUP_CORE_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_QUP_CORE_0 },
+};
+
+static struct qcom_icc_node qup1_core_master = {
+	.name = "qup1_core_master",
+	.id = SC8380XP_MASTER_QUP_CORE_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_QUP_CORE_1 },
+};
+
+static struct qcom_icc_node qup2_core_master = {
+	.name = "qup2_core_master",
+	.id = SC8380XP_MASTER_QUP_CORE_2,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_QUP_CORE_2 },
+};
+
+static struct qcom_icc_node qsm_cfg = {
+	.name = "qsm_cfg",
+	.id = SC8380XP_MASTER_CNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 47,
+	.links = { SC8380XP_SLAVE_AHB2PHY_SOUTH, SC8380XP_SLAVE_AHB2PHY_NORTH,
+		   SC8380XP_SLAVE_AHB2PHY_2, SC8380XP_SLAVE_AV1_ENC_CFG,
+		   SC8380XP_SLAVE_CAMERA_CFG, SC8380XP_SLAVE_CLK_CTL,
+		   SC8380XP_SLAVE_CRYPTO_0_CFG, SC8380XP_SLAVE_DISPLAY_CFG,
+		   SC8380XP_SLAVE_GFX3D_CFG, SC8380XP_SLAVE_IMEM_CFG,
+		   SC8380XP_SLAVE_IPC_ROUTER_CFG, SC8380XP_SLAVE_PCIE_0_CFG,
+		   SC8380XP_SLAVE_PCIE_1_CFG, SC8380XP_SLAVE_PCIE_2_CFG,
+		   SC8380XP_SLAVE_PCIE_3_CFG, SC8380XP_SLAVE_PCIE_4_CFG,
+		   SC8380XP_SLAVE_PCIE_5_CFG, SC8380XP_SLAVE_PCIE_6A_CFG,
+		   SC8380XP_SLAVE_PCIE_6B_CFG, SC8380XP_SLAVE_PCIE_RSC_CFG,
+		   SC8380XP_SLAVE_PDM, SC8380XP_SLAVE_PRNG,
+		   SC8380XP_SLAVE_QDSS_CFG, SC8380XP_SLAVE_QSPI_0,
+		   SC8380XP_SLAVE_QUP_0, SC8380XP_SLAVE_QUP_1,
+		   SC8380XP_SLAVE_QUP_2, SC8380XP_SLAVE_SDCC_2,
+		   SC8380XP_SLAVE_SDCC_4, SC8380XP_SLAVE_SMMUV3_CFG,
+		   SC8380XP_SLAVE_TCSR, SC8380XP_SLAVE_TLMM,
+		   SC8380XP_SLAVE_UFS_MEM_CFG, SC8380XP_SLAVE_USB2,
+		   SC8380XP_SLAVE_USB3_0, SC8380XP_SLAVE_USB3_1,
+		   SC8380XP_SLAVE_USB3_2, SC8380XP_SLAVE_USB3_MP,
+		   SC8380XP_SLAVE_USB4_0, SC8380XP_SLAVE_USB4_1,
+		   SC8380XP_SLAVE_USB4_2, SC8380XP_SLAVE_VENUS_CFG,
+		   SC8380XP_SLAVE_LPASS_QTB_CFG, SC8380XP_SLAVE_CNOC_MNOC_CFG,
+		   SC8380XP_SLAVE_NSP_QTB_CFG, SC8380XP_SLAVE_QDSS_STM,
+		   SC8380XP_SLAVE_TCU },
+};
+
+static struct qcom_icc_node qnm_gemnoc_cnoc = {
+	.name = "qnm_gemnoc_cnoc",
+	.id = SC8380XP_MASTER_GEM_NOC_CNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 6,
+	.links = { SC8380XP_SLAVE_AOSS, SC8380XP_SLAVE_TME_CFG,
+		   SC8380XP_SLAVE_APPSS, SC8380XP_SLAVE_CNOC_CFG,
+		   SC8380XP_SLAVE_BOOT_IMEM, SC8380XP_SLAVE_IMEM },
+};
+
+static struct qcom_icc_node qnm_gemnoc_pcie = {
+	.name = "qnm_gemnoc_pcie",
+	.id = SC8380XP_MASTER_GEM_NOC_PCIE_SNOC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 8,
+	.links = { SC8380XP_SLAVE_PCIE_0, SC8380XP_SLAVE_PCIE_1,
+		   SC8380XP_SLAVE_PCIE_2, SC8380XP_SLAVE_PCIE_3,
+		   SC8380XP_SLAVE_PCIE_4, SC8380XP_SLAVE_PCIE_5,
+		   SC8380XP_SLAVE_PCIE_6A, SC8380XP_SLAVE_PCIE_6B },
+};
+
+static struct qcom_icc_node alm_gpu_tcu = {
+	.name = "alm_gpu_tcu",
+	.id = SC8380XP_MASTER_GPU_TCU,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.links = { SC8380XP_SLAVE_GEM_NOC_CNOC, SC8380XP_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node alm_pcie_tcu = {
+	.name = "alm_pcie_tcu",
+	.id = SC8380XP_MASTER_PCIE_TCU,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.links = { SC8380XP_SLAVE_GEM_NOC_CNOC, SC8380XP_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node alm_sys_tcu = {
+	.name = "alm_sys_tcu",
+	.id = SC8380XP_MASTER_SYS_TCU,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.links = { SC8380XP_SLAVE_GEM_NOC_CNOC, SC8380XP_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node chm_apps = {
+	.name = "chm_apps",
+	.id = SC8380XP_MASTER_APPSS_PROC,
+	.channels = 6,
+	.buswidth = 32,
+	.num_links = 3,
+	.links = { SC8380XP_SLAVE_GEM_NOC_CNOC, SC8380XP_SLAVE_LLCC,
+		   SC8380XP_SLAVE_MEM_NOC_PCIE_SNOC },
+};
+
+static struct qcom_icc_node qnm_gpu = {
+	.name = "qnm_gpu",
+	.id = SC8380XP_MASTER_GFX3D,
+	.channels = 4,
+	.buswidth = 32,
+	.num_links = 2,
+	.links = { SC8380XP_SLAVE_GEM_NOC_CNOC, SC8380XP_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_lpass = {
+	.name = "qnm_lpass",
+	.id = SC8380XP_MASTER_LPASS_GEM_NOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 3,
+	.links = { SC8380XP_SLAVE_GEM_NOC_CNOC, SC8380XP_SLAVE_LLCC,
+		   SC8380XP_SLAVE_MEM_NOC_PCIE_SNOC },
+};
+
+static struct qcom_icc_node qnm_mnoc_hf = {
+	.name = "qnm_mnoc_hf",
+	.id = SC8380XP_MASTER_MNOC_HF_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 2,
+	.links = { SC8380XP_SLAVE_GEM_NOC_CNOC, SC8380XP_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_mnoc_sf = {
+	.name = "qnm_mnoc_sf",
+	.id = SC8380XP_MASTER_MNOC_SF_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 2,
+	.links = { SC8380XP_SLAVE_GEM_NOC_CNOC, SC8380XP_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_nsp_noc = {
+	.name = "qnm_nsp_noc",
+	.id = SC8380XP_MASTER_COMPUTE_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 3,
+	.links = { SC8380XP_SLAVE_GEM_NOC_CNOC, SC8380XP_SLAVE_LLCC,
+		   SC8380XP_SLAVE_MEM_NOC_PCIE_SNOC },
+};
+
+static struct qcom_icc_node qnm_pcie = {
+	.name = "qnm_pcie",
+	.id = SC8380XP_MASTER_ANOC_PCIE_GEM_NOC,
+	.channels = 1,
+	.buswidth = 64,
+	.num_links = 2,
+	.links = { SC8380XP_SLAVE_GEM_NOC_CNOC, SC8380XP_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_snoc_sf = {
+	.name = "qnm_snoc_sf",
+	.id = SC8380XP_MASTER_SNOC_SF_MEM_NOC,
+	.channels = 1,
+	.buswidth = 64,
+	.num_links = 3,
+	.links = { SC8380XP_SLAVE_GEM_NOC_CNOC, SC8380XP_SLAVE_LLCC,
+		   SC8380XP_SLAVE_MEM_NOC_PCIE_SNOC },
+};
+
+static struct qcom_icc_node xm_gic = {
+	.name = "xm_gic",
+	.id = SC8380XP_MASTER_GIC2,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_lpiaon_noc = {
+	.name = "qnm_lpiaon_noc",
+	.id = SC8380XP_MASTER_LPIAON_NOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_LPASS_GEM_NOC },
+};
+
+static struct qcom_icc_node qnm_lpass_lpinoc = {
+	.name = "qnm_lpass_lpinoc",
+	.id = SC8380XP_MASTER_LPASS_LPINOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_LPIAON_NOC_LPASS_AG_NOC },
+};
+
+static struct qcom_icc_node qxm_lpinoc_dsp_axim = {
+	.name = "qxm_lpinoc_dsp_axim",
+	.id = SC8380XP_MASTER_LPASS_PROC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_LPICX_NOC_LPIAON_NOC },
+};
+
+static struct qcom_icc_node llcc_mc = {
+	.name = "llcc_mc",
+	.id = SC8380XP_MASTER_LLCC,
+	.channels = 8,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_EBI1 },
+};
+
+static struct qcom_icc_node qnm_av1_enc = {
+	.name = "qnm_av1_enc",
+	.id = SC8380XP_MASTER_AV1_ENC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_camnoc_hf = {
+	.name = "qnm_camnoc_hf",
+	.id = SC8380XP_MASTER_CAMNOC_HF,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_camnoc_icp = {
+	.name = "qnm_camnoc_icp",
+	.id = SC8380XP_MASTER_CAMNOC_ICP,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_camnoc_sf = {
+	.name = "qnm_camnoc_sf",
+	.id = SC8380XP_MASTER_CAMNOC_SF,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_eva = {
+	.name = "qnm_eva",
+	.id = SC8380XP_MASTER_EVA,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_mdp = {
+	.name = "qnm_mdp",
+	.id = SC8380XP_MASTER_MDP,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_video = {
+	.name = "qnm_video",
+	.id = SC8380XP_MASTER_VIDEO,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_video_cv_cpu = {
+	.name = "qnm_video_cv_cpu",
+	.id = SC8380XP_MASTER_VIDEO_CV_PROC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_video_v_cpu = {
+	.name = "qnm_video_v_cpu",
+	.id = SC8380XP_MASTER_VIDEO_V_PROC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qsm_mnoc_cfg = {
+	.name = "qsm_mnoc_cfg",
+	.id = SC8380XP_MASTER_CNOC_MNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_SERVICE_MNOC },
+};
+
+static struct qcom_icc_node qxm_nsp = {
+	.name = "qxm_nsp",
+	.id = SC8380XP_MASTER_CDSP_PROC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_CDSP_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_pcie_north_gem_noc = {
+	.name = "qnm_pcie_north_gem_noc",
+	.id = SC8380XP_MASTER_PCIE_NORTH,
+	.channels = 1,
+	.buswidth = 64,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_ANOC_PCIE_GEM_NOC },
+};
+
+static struct qcom_icc_node qnm_pcie_south_gem_noc = {
+	.name = "qnm_pcie_south_gem_noc",
+	.id = SC8380XP_MASTER_PCIE_SOUTH,
+	.channels = 1,
+	.buswidth = 64,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_ANOC_PCIE_GEM_NOC },
+};
+
+static struct qcom_icc_node xm_pcie_3 = {
+	.name = "xm_pcie_3",
+	.id = SC8380XP_MASTER_PCIE_3,
+	.channels = 1,
+	.buswidth = 64,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_PCIE_NORTH },
+};
+
+static struct qcom_icc_node xm_pcie_4 = {
+	.name = "xm_pcie_4",
+	.id = SC8380XP_MASTER_PCIE_4,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_PCIE_NORTH },
+};
+
+static struct qcom_icc_node xm_pcie_5 = {
+	.name = "xm_pcie_5",
+	.id = SC8380XP_MASTER_PCIE_5,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_PCIE_NORTH },
+};
+
+static struct qcom_icc_node xm_pcie_0 = {
+	.name = "xm_pcie_0",
+	.id = SC8380XP_MASTER_PCIE_0,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_PCIE_SOUTH },
+};
+
+static struct qcom_icc_node xm_pcie_1 = {
+	.name = "xm_pcie_1",
+	.id = SC8380XP_MASTER_PCIE_1,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_PCIE_SOUTH },
+};
+
+static struct qcom_icc_node xm_pcie_2 = {
+	.name = "xm_pcie_2",
+	.id = SC8380XP_MASTER_PCIE_2,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_PCIE_SOUTH },
+};
+
+static struct qcom_icc_node xm_pcie_6a = {
+	.name = "xm_pcie_6a",
+	.id = SC8380XP_MASTER_PCIE_6A,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_PCIE_SOUTH },
+};
+
+static struct qcom_icc_node xm_pcie_6b = {
+	.name = "xm_pcie_6b",
+	.id = SC8380XP_MASTER_PCIE_6B,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_PCIE_SOUTH },
+};
+
+static struct qcom_icc_node qnm_aggre1_noc = {
+	.name = "qnm_aggre1_noc",
+	.id = SC8380XP_MASTER_A1NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_SNOC_GEM_NOC_SF },
+};
+
+static struct qcom_icc_node qnm_aggre2_noc = {
+	.name = "qnm_aggre2_noc",
+	.id = SC8380XP_MASTER_A2NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_SNOC_GEM_NOC_SF },
+};
+
+static struct qcom_icc_node qnm_gic = {
+	.name = "qnm_gic",
+	.id = SC8380XP_MASTER_GIC1,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_SNOC_GEM_NOC_SF },
+};
+
+static struct qcom_icc_node qnm_usb_anoc = {
+	.name = "qnm_usb_anoc",
+	.id = SC8380XP_MASTER_USB_NOC_SNOC,
+	.channels = 1,
+	.buswidth = 64,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_SNOC_GEM_NOC_SF },
+};
+
+static struct qcom_icc_node qnm_aggre_usb_north_snoc = {
+	.name = "qnm_aggre_usb_north_snoc",
+	.id = SC8380XP_MASTER_AGGRE_USB_NORTH,
+	.channels = 1,
+	.buswidth = 64,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_USB_NOC_SNOC },
+};
+
+static struct qcom_icc_node qnm_aggre_usb_south_snoc = {
+	.name = "qnm_aggre_usb_south_snoc",
+	.id = SC8380XP_MASTER_AGGRE_USB_SOUTH,
+	.channels = 1,
+	.buswidth = 64,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_USB_NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_usb2_0 = {
+	.name = "xm_usb2_0",
+	.id = SC8380XP_MASTER_USB2,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_AGGRE_USB_NORTH },
+};
+
+static struct qcom_icc_node xm_usb3_mp = {
+	.name = "xm_usb3_mp",
+	.id = SC8380XP_MASTER_USB3_MP,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_AGGRE_USB_NORTH },
+};
+
+static struct qcom_icc_node xm_usb3_0 = {
+	.name = "xm_usb3_0",
+	.id = SC8380XP_MASTER_USB3_0,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_AGGRE_USB_SOUTH },
+};
+
+static struct qcom_icc_node xm_usb3_1 = {
+	.name = "xm_usb3_1",
+	.id = SC8380XP_MASTER_USB3_1,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_AGGRE_USB_SOUTH },
+};
+
+static struct qcom_icc_node xm_usb3_2 = {
+	.name = "xm_usb3_2",
+	.id = SC8380XP_MASTER_USB3_2,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_AGGRE_USB_SOUTH },
+};
+
+static struct qcom_icc_node xm_usb4_0 = {
+	.name = "xm_usb4_0",
+	.id = SC8380XP_MASTER_USB4_0,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_AGGRE_USB_SOUTH },
+};
+
+static struct qcom_icc_node xm_usb4_1 = {
+	.name = "xm_usb4_1",
+	.id = SC8380XP_MASTER_USB4_1,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_AGGRE_USB_SOUTH },
+};
+
+static struct qcom_icc_node xm_usb4_2 = {
+	.name = "xm_usb4_2",
+	.id = SC8380XP_MASTER_USB4_2,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_AGGRE_USB_SOUTH },
+};
+
+static struct qcom_icc_node qnm_mnoc_hf_disp = {
+	.name = "qnm_mnoc_hf_disp",
+	.id = SC8380XP_MASTER_MNOC_HF_MEM_NOC_DISP,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_LLCC_DISP },
+};
+
+static struct qcom_icc_node qnm_pcie_disp = {
+	.name = "qnm_pcie_disp",
+	.id = SC8380XP_MASTER_ANOC_PCIE_GEM_NOC_DISP,
+	.channels = 1,
+	.buswidth = 64,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_LLCC_DISP },
+};
+
+static struct qcom_icc_node llcc_mc_disp = {
+	.name = "llcc_mc_disp",
+	.id = SC8380XP_MASTER_LLCC_DISP,
+	.channels = 8,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_EBI1_DISP },
+};
+
+static struct qcom_icc_node qnm_mdp_disp = {
+	.name = "qnm_mdp_disp",
+	.id = SC8380XP_MASTER_MDP_DISP,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_MNOC_HF_MEM_NOC_DISP },
+};
+
+static struct qcom_icc_node qnm_pcie_pcie = {
+	.name = "qnm_pcie_pcie",
+	.id = SC8380XP_MASTER_ANOC_PCIE_GEM_NOC_PCIE,
+	.channels = 1,
+	.buswidth = 64,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_LLCC_PCIE },
+};
+
+static struct qcom_icc_node llcc_mc_pcie = {
+	.name = "llcc_mc_pcie",
+	.id = SC8380XP_MASTER_LLCC_PCIE,
+	.channels = 8,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_EBI1_PCIE },
+};
+
+static struct qcom_icc_node qnm_pcie_north_gem_noc_pcie = {
+	.name = "qnm_pcie_north_gem_noc_pcie",
+	.id = SC8380XP_MASTER_PCIE_NORTH_PCIE,
+	.channels = 1,
+	.buswidth = 64,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_ANOC_PCIE_GEM_NOC_PCIE },
+};
+
+static struct qcom_icc_node qnm_pcie_south_gem_noc_pcie = {
+	.name = "qnm_pcie_south_gem_noc_pcie",
+	.id = SC8380XP_MASTER_PCIE_SOUTH_PCIE,
+	.channels = 1,
+	.buswidth = 64,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_ANOC_PCIE_GEM_NOC_PCIE },
+};
+
+static struct qcom_icc_node xm_pcie_3_pcie = {
+	.name = "xm_pcie_3_pcie",
+	.id = SC8380XP_MASTER_PCIE_3_PCIE,
+	.channels = 1,
+	.buswidth = 64,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_PCIE_NORTH_PCIE },
+};
+
+static struct qcom_icc_node xm_pcie_4_pcie = {
+	.name = "xm_pcie_4_pcie",
+	.id = SC8380XP_MASTER_PCIE_4_PCIE,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_PCIE_NORTH_PCIE },
+};
+
+static struct qcom_icc_node xm_pcie_5_pcie = {
+	.name = "xm_pcie_5_pcie",
+	.id = SC8380XP_MASTER_PCIE_5_PCIE,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_PCIE_NORTH_PCIE },
+};
+
+static struct qcom_icc_node xm_pcie_0_pcie = {
+	.name = "xm_pcie_0_pcie",
+	.id = SC8380XP_MASTER_PCIE_0_PCIE,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_PCIE_SOUTH_PCIE },
+};
+
+static struct qcom_icc_node xm_pcie_1_pcie = {
+	.name = "xm_pcie_1_pcie",
+	.id = SC8380XP_MASTER_PCIE_1_PCIE,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_PCIE_SOUTH_PCIE },
+};
+
+static struct qcom_icc_node xm_pcie_2_pcie = {
+	.name = "xm_pcie_2_pcie",
+	.id = SC8380XP_MASTER_PCIE_2_PCIE,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_PCIE_SOUTH_PCIE },
+};
+
+static struct qcom_icc_node xm_pcie_6a_pcie = {
+	.name = "xm_pcie_6a_pcie",
+	.id = SC8380XP_MASTER_PCIE_6A_PCIE,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_PCIE_SOUTH_PCIE },
+};
+
+static struct qcom_icc_node xm_pcie_6b_pcie = {
+	.name = "xm_pcie_6b_pcie",
+	.id = SC8380XP_MASTER_PCIE_6B_PCIE,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC8380XP_SLAVE_PCIE_SOUTH_PCIE },
+};
+
+static struct qcom_icc_node qns_a1noc_snoc = {
+	.name = "qns_a1noc_snoc",
+	.id = SC8380XP_SLAVE_A1NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC8380XP_MASTER_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node qns_a2noc_snoc = {
+	.name = "qns_a2noc_snoc",
+	.id = SC8380XP_SLAVE_A2NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC8380XP_MASTER_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node ddr_perf_mode_slave = {
+	.name = "ddr_perf_mode_slave",
+	.id = SC8380XP_SLAVE_DDR_PERF_MODE,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qup0_core_slave = {
+	.name = "qup0_core_slave",
+	.id = SC8380XP_SLAVE_QUP_CORE_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qup1_core_slave = {
+	.name = "qup1_core_slave",
+	.id = SC8380XP_SLAVE_QUP_CORE_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qup2_core_slave = {
+	.name = "qup2_core_slave",
+	.id = SC8380XP_SLAVE_QUP_CORE_2,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_ahb2phy0 = {
+	.name = "qhs_ahb2phy0",
+	.id = SC8380XP_SLAVE_AHB2PHY_SOUTH,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_ahb2phy1 = {
+	.name = "qhs_ahb2phy1",
+	.id = SC8380XP_SLAVE_AHB2PHY_NORTH,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_ahb2phy2 = {
+	.name = "qhs_ahb2phy2",
+	.id = SC8380XP_SLAVE_AHB2PHY_2,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_av1_enc_cfg = {
+	.name = "qhs_av1_enc_cfg",
+	.id = SC8380XP_SLAVE_AV1_ENC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_camera_cfg = {
+	.name = "qhs_camera_cfg",
+	.id = SC8380XP_SLAVE_CAMERA_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_clk_ctl = {
+	.name = "qhs_clk_ctl",
+	.id = SC8380XP_SLAVE_CLK_CTL,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_crypto0_cfg = {
+	.name = "qhs_crypto0_cfg",
+	.id = SC8380XP_SLAVE_CRYPTO_0_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_display_cfg = {
+	.name = "qhs_display_cfg",
+	.id = SC8380XP_SLAVE_DISPLAY_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_gpuss_cfg = {
+	.name = "qhs_gpuss_cfg",
+	.id = SC8380XP_SLAVE_GFX3D_CFG,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_imem_cfg = {
+	.name = "qhs_imem_cfg",
+	.id = SC8380XP_SLAVE_IMEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_ipc_router = {
+	.name = "qhs_ipc_router",
+	.id = SC8380XP_SLAVE_IPC_ROUTER_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_pcie0_cfg = {
+	.name = "qhs_pcie0_cfg",
+	.id = SC8380XP_SLAVE_PCIE_0_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_pcie1_cfg = {
+	.name = "qhs_pcie1_cfg",
+	.id = SC8380XP_SLAVE_PCIE_1_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_pcie2_cfg = {
+	.name = "qhs_pcie2_cfg",
+	.id = SC8380XP_SLAVE_PCIE_2_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_pcie3_cfg = {
+	.name = "qhs_pcie3_cfg",
+	.id = SC8380XP_SLAVE_PCIE_3_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_pcie4_cfg = {
+	.name = "qhs_pcie4_cfg",
+	.id = SC8380XP_SLAVE_PCIE_4_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_pcie5_cfg = {
+	.name = "qhs_pcie5_cfg",
+	.id = SC8380XP_SLAVE_PCIE_5_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_pcie6a_cfg = {
+	.name = "qhs_pcie6a_cfg",
+	.id = SC8380XP_SLAVE_PCIE_6A_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_pcie6b_cfg = {
+	.name = "qhs_pcie6b_cfg",
+	.id = SC8380XP_SLAVE_PCIE_6B_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_pcie_rsc_cfg = {
+	.name = "qhs_pcie_rsc_cfg",
+	.id = SC8380XP_SLAVE_PCIE_RSC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_pdm = {
+	.name = "qhs_pdm",
+	.id = SC8380XP_SLAVE_PDM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_prng = {
+	.name = "qhs_prng",
+	.id = SC8380XP_SLAVE_PRNG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_qdss_cfg = {
+	.name = "qhs_qdss_cfg",
+	.id = SC8380XP_SLAVE_QDSS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_qspi = {
+	.name = "qhs_qspi",
+	.id = SC8380XP_SLAVE_QSPI_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_qup0 = {
+	.name = "qhs_qup0",
+	.id = SC8380XP_SLAVE_QUP_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_qup1 = {
+	.name = "qhs_qup1",
+	.id = SC8380XP_SLAVE_QUP_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_qup2 = {
+	.name = "qhs_qup2",
+	.id = SC8380XP_SLAVE_QUP_2,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_sdc2 = {
+	.name = "qhs_sdc2",
+	.id = SC8380XP_SLAVE_SDCC_2,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_sdc4 = {
+	.name = "qhs_sdc4",
+	.id = SC8380XP_SLAVE_SDCC_4,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_smmuv3_cfg = {
+	.name = "qhs_smmuv3_cfg",
+	.id = SC8380XP_SLAVE_SMMUV3_CFG,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_tcsr = {
+	.name = "qhs_tcsr",
+	.id = SC8380XP_SLAVE_TCSR,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_tlmm = {
+	.name = "qhs_tlmm",
+	.id = SC8380XP_SLAVE_TLMM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_ufs_mem_cfg = {
+	.name = "qhs_ufs_mem_cfg",
+	.id = SC8380XP_SLAVE_UFS_MEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_usb2_0_cfg = {
+	.name = "qhs_usb2_0_cfg",
+	.id = SC8380XP_SLAVE_USB2,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_usb3_0_cfg = {
+	.name = "qhs_usb3_0_cfg",
+	.id = SC8380XP_SLAVE_USB3_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_usb3_1_cfg = {
+	.name = "qhs_usb3_1_cfg",
+	.id = SC8380XP_SLAVE_USB3_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_usb3_2_cfg = {
+	.name = "qhs_usb3_2_cfg",
+	.id = SC8380XP_SLAVE_USB3_2,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_usb3_mp_cfg = {
+	.name = "qhs_usb3_mp_cfg",
+	.id = SC8380XP_SLAVE_USB3_MP,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_usb4_0_cfg = {
+	.name = "qhs_usb4_0_cfg",
+	.id = SC8380XP_SLAVE_USB4_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_usb4_1_cfg = {
+	.name = "qhs_usb4_1_cfg",
+	.id = SC8380XP_SLAVE_USB4_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_usb4_2_cfg = {
+	.name = "qhs_usb4_2_cfg",
+	.id = SC8380XP_SLAVE_USB4_2,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_venus_cfg = {
+	.name = "qhs_venus_cfg",
+	.id = SC8380XP_SLAVE_VENUS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qss_lpass_qtb_cfg = {
+	.name = "qss_lpass_qtb_cfg",
+	.id = SC8380XP_SLAVE_LPASS_QTB_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qss_mnoc_cfg = {
+	.name = "qss_mnoc_cfg",
+	.id = SC8380XP_SLAVE_CNOC_MNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC8380XP_MASTER_CNOC_MNOC_CFG },
+};
+
+static struct qcom_icc_node qss_nsp_qtb_cfg = {
+	.name = "qss_nsp_qtb_cfg",
+	.id = SC8380XP_SLAVE_NSP_QTB_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node xs_qdss_stm = {
+	.name = "xs_qdss_stm",
+	.id = SC8380XP_SLAVE_QDSS_STM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node xs_sys_tcu_cfg = {
+	.name = "xs_sys_tcu_cfg",
+	.id = SC8380XP_SLAVE_TCU,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_aoss = {
+	.name = "qhs_aoss",
+	.id = SC8380XP_SLAVE_AOSS,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_tme_cfg = {
+	.name = "qhs_tme_cfg",
+	.id = SC8380XP_SLAVE_TME_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_apss = {
+	.name = "qns_apss",
+	.id = SC8380XP_SLAVE_APPSS,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qss_cfg = {
+	.name = "qss_cfg",
+	.id = SC8380XP_SLAVE_CNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC8380XP_MASTER_CNOC_CFG },
+};
+
+static struct qcom_icc_node qxs_boot_imem = {
+	.name = "qxs_boot_imem",
+	.id = SC8380XP_SLAVE_BOOT_IMEM,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qxs_imem = {
+	.name = "qxs_imem",
+	.id = SC8380XP_SLAVE_IMEM,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node xs_pcie_0 = {
+	.name = "xs_pcie_0",
+	.id = SC8380XP_SLAVE_PCIE_0,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node xs_pcie_1 = {
+	.name = "xs_pcie_1",
+	.id = SC8380XP_SLAVE_PCIE_1,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node xs_pcie_2 = {
+	.name = "xs_pcie_2",
+	.id = SC8380XP_SLAVE_PCIE_2,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node xs_pcie_3 = {
+	.name = "xs_pcie_3",
+	.id = SC8380XP_SLAVE_PCIE_3,
+	.channels = 1,
+	.buswidth = 64,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node xs_pcie_4 = {
+	.name = "xs_pcie_4",
+	.id = SC8380XP_SLAVE_PCIE_4,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node xs_pcie_5 = {
+	.name = "xs_pcie_5",
+	.id = SC8380XP_SLAVE_PCIE_5,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node xs_pcie_6a = {
+	.name = "xs_pcie_6a",
+	.id = SC8380XP_SLAVE_PCIE_6A,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node xs_pcie_6b = {
+	.name = "xs_pcie_6b",
+	.id = SC8380XP_SLAVE_PCIE_6B,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_gem_noc_cnoc = {
+	.name = "qns_gem_noc_cnoc",
+	.id = SC8380XP_SLAVE_GEM_NOC_CNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC8380XP_MASTER_GEM_NOC_CNOC },
+};
+
+static struct qcom_icc_node qns_llcc = {
+	.name = "qns_llcc",
+	.id = SC8380XP_SLAVE_LLCC,
+	.channels = 8,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC8380XP_MASTER_LLCC },
+};
+
+static struct qcom_icc_node qns_pcie = {
+	.name = "qns_pcie",
+	.id = SC8380XP_SLAVE_MEM_NOC_PCIE_SNOC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC8380XP_MASTER_GEM_NOC_PCIE_SNOC },
+};
+
+static struct qcom_icc_node qns_lpass_ag_noc_gemnoc = {
+	.name = "qns_lpass_ag_noc_gemnoc",
+	.id = SC8380XP_SLAVE_LPASS_GEM_NOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC8380XP_MASTER_LPASS_GEM_NOC },
+};
+
+static struct qcom_icc_node qns_lpass_aggnoc = {
+	.name = "qns_lpass_aggnoc",
+	.id = SC8380XP_SLAVE_LPIAON_NOC_LPASS_AG_NOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC8380XP_MASTER_LPIAON_NOC },
+};
+
+static struct qcom_icc_node qns_lpi_aon_noc = {
+	.name = "qns_lpi_aon_noc",
+	.id = SC8380XP_SLAVE_LPICX_NOC_LPIAON_NOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC8380XP_MASTER_LPASS_LPINOC },
+};
+
+static struct qcom_icc_node ebi = {
+	.name = "ebi",
+	.id = SC8380XP_SLAVE_EBI1,
+	.channels = 8,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_mem_noc_hf = {
+	.name = "qns_mem_noc_hf",
+	.id = SC8380XP_SLAVE_MNOC_HF_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC8380XP_MASTER_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qns_mem_noc_sf = {
+	.name = "qns_mem_noc_sf",
+	.id = SC8380XP_SLAVE_MNOC_SF_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC8380XP_MASTER_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node srvc_mnoc = {
+	.name = "srvc_mnoc",
+	.id = SC8380XP_SLAVE_SERVICE_MNOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_nsp_gemnoc = {
+	.name = "qns_nsp_gemnoc",
+	.id = SC8380XP_SLAVE_CDSP_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC8380XP_MASTER_COMPUTE_NOC },
+};
+
+static struct qcom_icc_node qns_pcie_mem_noc = {
+	.name = "qns_pcie_mem_noc",
+	.id = SC8380XP_SLAVE_ANOC_PCIE_GEM_NOC,
+	.channels = 1,
+	.buswidth = 64,
+	.num_links = 1,
+	.links = { SC8380XP_MASTER_ANOC_PCIE_GEM_NOC },
+};
+
+static struct qcom_icc_node qns_pcie_north_gem_noc = {
+	.name = "qns_pcie_north_gem_noc",
+	.id = SC8380XP_SLAVE_PCIE_NORTH,
+	.channels = 1,
+	.buswidth = 64,
+	.num_links = 1,
+	.links = { SC8380XP_MASTER_PCIE_NORTH },
+};
+
+static struct qcom_icc_node qns_pcie_south_gem_noc = {
+	.name = "qns_pcie_south_gem_noc",
+	.id = SC8380XP_SLAVE_PCIE_SOUTH,
+	.channels = 1,
+	.buswidth = 64,
+	.num_links = 1,
+	.links = { SC8380XP_MASTER_PCIE_SOUTH },
+};
+
+static struct qcom_icc_node qns_gemnoc_sf = {
+	.name = "qns_gemnoc_sf",
+	.id = SC8380XP_SLAVE_SNOC_GEM_NOC_SF,
+	.channels = 1,
+	.buswidth = 64,
+	.num_links = 1,
+	.links = { SC8380XP_MASTER_SNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qns_aggre_usb_snoc = {
+	.name = "qns_aggre_usb_snoc",
+	.id = SC8380XP_SLAVE_USB_NOC_SNOC,
+	.channels = 1,
+	.buswidth = 64,
+	.num_links = 1,
+	.links = { SC8380XP_MASTER_USB_NOC_SNOC },
+};
+
+static struct qcom_icc_node qns_aggre_usb_north_snoc = {
+	.name = "qns_aggre_usb_north_snoc",
+	.id = SC8380XP_SLAVE_AGGRE_USB_NORTH,
+	.channels = 1,
+	.buswidth = 64,
+	.num_links = 1,
+	.links = { SC8380XP_MASTER_AGGRE_USB_NORTH },
+};
+
+static struct qcom_icc_node qns_aggre_usb_south_snoc = {
+	.name = "qns_aggre_usb_south_snoc",
+	.id = SC8380XP_SLAVE_AGGRE_USB_SOUTH,
+	.channels = 1,
+	.buswidth = 64,
+	.num_links = 1,
+	.links = { SC8380XP_MASTER_AGGRE_USB_SOUTH },
+};
+
+static struct qcom_icc_node qns_llcc_disp = {
+	.name = "qns_llcc_disp",
+	.id = SC8380XP_SLAVE_LLCC_DISP,
+	.channels = 8,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC8380XP_MASTER_LLCC_DISP },
+};
+
+static struct qcom_icc_node ebi_disp = {
+	.name = "ebi_disp",
+	.id = SC8380XP_SLAVE_EBI1_DISP,
+	.channels = 8,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_mem_noc_hf_disp = {
+	.name = "qns_mem_noc_hf_disp",
+	.id = SC8380XP_SLAVE_MNOC_HF_MEM_NOC_DISP,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC8380XP_MASTER_MNOC_HF_MEM_NOC_DISP },
+};
+
+static struct qcom_icc_node qns_llcc_pcie = {
+	.name = "qns_llcc_pcie",
+	.id = SC8380XP_SLAVE_LLCC_PCIE,
+	.channels = 8,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC8380XP_MASTER_LLCC_PCIE },
+};
+
+static struct qcom_icc_node ebi_pcie = {
+	.name = "ebi_pcie",
+	.id = SC8380XP_SLAVE_EBI1_PCIE,
+	.channels = 8,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_pcie_mem_noc_pcie = {
+	.name = "qns_pcie_mem_noc_pcie",
+	.id = SC8380XP_SLAVE_ANOC_PCIE_GEM_NOC_PCIE,
+	.channels = 1,
+	.buswidth = 64,
+	.num_links = 1,
+	.links = { SC8380XP_MASTER_ANOC_PCIE_GEM_NOC_PCIE },
+};
+
+static struct qcom_icc_node qns_pcie_north_gem_noc_pcie = {
+	.name = "qns_pcie_north_gem_noc_pcie",
+	.id = SC8380XP_SLAVE_PCIE_NORTH_PCIE,
+	.channels = 1,
+	.buswidth = 64,
+	.num_links = 1,
+	.links = { SC8380XP_MASTER_PCIE_NORTH_PCIE },
+};
+
+static struct qcom_icc_node qns_pcie_south_gem_noc_pcie = {
+	.name = "qns_pcie_south_gem_noc_pcie",
+	.id = SC8380XP_SLAVE_PCIE_SOUTH_PCIE,
+	.channels = 1,
+	.buswidth = 64,
+	.num_links = 1,
+	.links = { SC8380XP_MASTER_PCIE_SOUTH_PCIE },
+};
+
+static struct qcom_icc_bcm bcm_acv = {
+	.name = "ACV",
+	.num_nodes = 1,
+	.nodes = { &ebi },
+};
+
+static struct qcom_icc_bcm bcm_acv_perf = {
+	.name = "ACV_PERF",
+	.num_nodes = 1,
+	.nodes = { &ddr_perf_mode_slave },
+};
+
+static struct qcom_icc_bcm bcm_ce0 = {
+	.name = "CE0",
+	.num_nodes = 1,
+	.nodes = { &qxm_crypto },
+};
+
+static struct qcom_icc_bcm bcm_cn0 = {
+	.name = "CN0",
+	.keepalive = true,
+	.num_nodes = 63,
+	.nodes = { &qsm_cfg, &qhs_ahb2phy0,
+		   &qhs_ahb2phy1, &qhs_ahb2phy2,
+		   &qhs_av1_enc_cfg, &qhs_camera_cfg,
+		   &qhs_clk_ctl, &qhs_crypto0_cfg,
+		   &qhs_gpuss_cfg, &qhs_imem_cfg,
+		   &qhs_ipc_router, &qhs_pcie0_cfg,
+		   &qhs_pcie1_cfg, &qhs_pcie2_cfg,
+		   &qhs_pcie3_cfg, &qhs_pcie4_cfg,
+		   &qhs_pcie5_cfg, &qhs_pcie6a_cfg,
+		   &qhs_pcie6b_cfg, &qhs_pcie_rsc_cfg,
+		   &qhs_pdm, &qhs_prng,
+		   &qhs_qdss_cfg, &qhs_qspi,
+		   &qhs_qup0, &qhs_qup1,
+		   &qhs_qup2, &qhs_sdc2,
+		   &qhs_sdc4, &qhs_smmuv3_cfg,
+		   &qhs_tcsr, &qhs_tlmm,
+		   &qhs_ufs_mem_cfg, &qhs_usb2_0_cfg,
+		   &qhs_usb3_0_cfg, &qhs_usb3_1_cfg,
+		   &qhs_usb3_2_cfg, &qhs_usb3_mp_cfg,
+		   &qhs_usb4_0_cfg, &qhs_usb4_1_cfg,
+		   &qhs_usb4_2_cfg, &qhs_venus_cfg,
+		   &qss_lpass_qtb_cfg, &qss_mnoc_cfg,
+		   &qss_nsp_qtb_cfg, &xs_qdss_stm,
+		   &xs_sys_tcu_cfg, &qnm_gemnoc_cnoc,
+		   &qnm_gemnoc_pcie, &qhs_aoss,
+		   &qhs_tme_cfg, &qns_apss,
+		   &qss_cfg, &qxs_boot_imem,
+		   &qxs_imem, &xs_pcie_0,
+		   &xs_pcie_1, &xs_pcie_2,
+		   &xs_pcie_3, &xs_pcie_4,
+		   &xs_pcie_5, &xs_pcie_6a,
+		   &xs_pcie_6b },
+};
+
+static struct qcom_icc_bcm bcm_cn1 = {
+	.name = "CN1",
+	.num_nodes = 1,
+	.nodes = { &qhs_display_cfg },
+};
+
+static struct qcom_icc_bcm bcm_co0 = {
+	.name = "CO0",
+	.num_nodes = 2,
+	.nodes = { &qxm_nsp, &qns_nsp_gemnoc },
+};
+
+static struct qcom_icc_bcm bcm_lp0 = {
+	.name = "LP0",
+	.num_nodes = 2,
+	.nodes = { &qnm_lpass_lpinoc, &qns_lpass_aggnoc },
+};
+
+static struct qcom_icc_bcm bcm_mc0 = {
+	.name = "MC0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &ebi },
+};
+
+static struct qcom_icc_bcm bcm_mm0 = {
+	.name = "MM0",
+	.num_nodes = 1,
+	.nodes = { &qns_mem_noc_hf },
+};
+
+static struct qcom_icc_bcm bcm_mm1 = {
+	.name = "MM1",
+	.num_nodes = 10,
+	.nodes = { &qnm_av1_enc, &qnm_camnoc_hf,
+		   &qnm_camnoc_icp, &qnm_camnoc_sf,
+		   &qnm_eva, &qnm_mdp,
+		   &qnm_video, &qnm_video_cv_cpu,
+		   &qnm_video_v_cpu, &qns_mem_noc_sf },
+};
+
+static struct qcom_icc_bcm bcm_pc0 = {
+	.name = "PC0",
+	.num_nodes = 1,
+	.nodes = { &qns_pcie_mem_noc },
+};
+
+static struct qcom_icc_bcm bcm_qup0 = {
+	.name = "QUP0",
+	.keepalive = true,
+	.vote_scale = 1,
+	.num_nodes = 1,
+	.nodes = { &qup0_core_slave },
+};
+
+static struct qcom_icc_bcm bcm_qup1 = {
+	.name = "QUP1",
+	.keepalive = true,
+	.vote_scale = 1,
+	.num_nodes = 1,
+	.nodes = { &qup1_core_slave },
+};
+
+static struct qcom_icc_bcm bcm_qup2 = {
+	.name = "QUP2",
+	.keepalive = true,
+	.vote_scale = 1,
+	.num_nodes = 1,
+	.nodes = { &qup2_core_slave },
+};
+
+static struct qcom_icc_bcm bcm_sh0 = {
+	.name = "SH0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qns_llcc },
+};
+
+static struct qcom_icc_bcm bcm_sh1 = {
+	.name = "SH1",
+	.num_nodes = 13,
+	.nodes = { &alm_gpu_tcu, &alm_pcie_tcu,
+		   &alm_sys_tcu, &chm_apps,
+		   &qnm_gpu, &qnm_lpass,
+		   &qnm_mnoc_hf, &qnm_mnoc_sf,
+		   &qnm_nsp_noc, &qnm_pcie,
+		   &xm_gic, &qns_gem_noc_cnoc,
+		   &qns_pcie },
+};
+
+static struct qcom_icc_bcm bcm_sn0 = {
+	.name = "SN0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qns_gemnoc_sf },
+};
+
+static struct qcom_icc_bcm bcm_sn2 = {
+	.name = "SN2",
+	.num_nodes = 1,
+	.nodes = { &qnm_aggre1_noc },
+};
+
+static struct qcom_icc_bcm bcm_sn3 = {
+	.name = "SN3",
+	.num_nodes = 1,
+	.nodes = { &qnm_aggre2_noc },
+};
+
+static struct qcom_icc_bcm bcm_sn4 = {
+	.name = "SN4",
+	.num_nodes = 1,
+	.nodes = { &qnm_usb_anoc },
+};
+
+static struct qcom_icc_bcm bcm_acv_disp = {
+	.name = "ACV",
+	.num_nodes = 1,
+	.nodes = { &ebi_disp },
+};
+
+static struct qcom_icc_bcm bcm_mc0_disp = {
+	.name = "MC0",
+	.num_nodes = 1,
+	.nodes = { &ebi_disp },
+};
+
+static struct qcom_icc_bcm bcm_mm0_disp = {
+	.name = "MM0",
+	.num_nodes = 1,
+	.nodes = { &qns_mem_noc_hf_disp },
+};
+
+static struct qcom_icc_bcm bcm_mm1_disp = {
+	.name = "MM1",
+	.num_nodes = 1,
+	.nodes = { &qnm_mdp_disp },
+};
+
+static struct qcom_icc_bcm bcm_sh0_disp = {
+	.name = "SH0",
+	.num_nodes = 1,
+	.nodes = { &qns_llcc_disp },
+};
+
+static struct qcom_icc_bcm bcm_sh1_disp = {
+	.name = "SH1",
+	.num_nodes = 2,
+	.nodes = { &qnm_mnoc_hf_disp, &qnm_pcie_disp },
+};
+
+static struct qcom_icc_bcm bcm_acv_pcie = {
+	.name = "ACV",
+	.num_nodes = 1,
+	.nodes = { &ebi_pcie },
+};
+
+static struct qcom_icc_bcm bcm_mc0_pcie = {
+	.name = "MC0",
+	.num_nodes = 1,
+	.nodes = { &ebi_pcie },
+};
+
+static struct qcom_icc_bcm bcm_pc0_pcie = {
+	.name = "PC0",
+	.num_nodes = 1,
+	.nodes = { &qns_pcie_mem_noc_pcie },
+};
+
+static struct qcom_icc_bcm bcm_sh0_pcie = {
+	.name = "SH0",
+	.num_nodes = 1,
+	.nodes = { &qns_llcc_pcie },
+};
+
+static struct qcom_icc_bcm bcm_sh1_pcie = {
+	.name = "SH1",
+	.num_nodes = 1,
+	.nodes = { &qnm_pcie_pcie },
+};
+
+static struct qcom_icc_bcm *aggre1_noc_bcms[] = {
+};
+
+static struct qcom_icc_node * const aggre1_noc_nodes[] = {
+	[MASTER_QSPI_0] = &qhm_qspi,
+	[MASTER_QUP_1] = &qhm_qup1,
+	[MASTER_SDCC_4] = &xm_sdc4,
+	[MASTER_UFS_MEM] = &xm_ufs_mem,
+	[SLAVE_A1NOC_SNOC] = &qns_a1noc_snoc,
+};
+
+static const struct qcom_icc_desc sc8380xp_aggre1_noc = {
+	.nodes = aggre1_noc_nodes,
+	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
+	.bcms = aggre1_noc_bcms,
+	.num_bcms = ARRAY_SIZE(aggre1_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const aggre2_noc_bcms[] = {
+	&bcm_ce0,
+};
+
+static struct qcom_icc_node * const aggre2_noc_nodes[] = {
+	[MASTER_QUP_0] = &qhm_qup0,
+	[MASTER_QUP_2] = &qhm_qup2,
+	[MASTER_CRYPTO] = &qxm_crypto,
+	[MASTER_SP] = &qxm_sp,
+	[MASTER_QDSS_ETR] = &xm_qdss_etr_0,
+	[MASTER_QDSS_ETR_1] = &xm_qdss_etr_1,
+	[MASTER_SDCC_2] = &xm_sdc2,
+	[SLAVE_A2NOC_SNOC] = &qns_a2noc_snoc,
+};
+
+static const struct qcom_icc_desc sc8380xp_aggre2_noc = {
+	.nodes = aggre2_noc_nodes,
+	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
+	.bcms = aggre2_noc_bcms,
+	.num_bcms = ARRAY_SIZE(aggre2_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const clk_virt_bcms[] = {
+	&bcm_acv_perf,
+	&bcm_qup0,
+	&bcm_qup1,
+	&bcm_qup2,
+};
+
+static struct qcom_icc_node * const clk_virt_nodes[] = {
+	[MASTER_DDR_PERF_MODE] = &ddr_perf_mode_master,
+	[MASTER_QUP_CORE_0] = &qup0_core_master,
+	[MASTER_QUP_CORE_1] = &qup1_core_master,
+	[MASTER_QUP_CORE_2] = &qup2_core_master,
+	[SLAVE_DDR_PERF_MODE] = &ddr_perf_mode_slave,
+	[SLAVE_QUP_CORE_0] = &qup0_core_slave,
+	[SLAVE_QUP_CORE_1] = &qup1_core_slave,
+	[SLAVE_QUP_CORE_2] = &qup2_core_slave,
+};
+
+static const struct qcom_icc_desc sc8380xp_clk_virt = {
+	.nodes = clk_virt_nodes,
+	.num_nodes = ARRAY_SIZE(clk_virt_nodes),
+	.bcms = clk_virt_bcms,
+	.num_bcms = ARRAY_SIZE(clk_virt_bcms),
+};
+
+static struct qcom_icc_bcm * const cnoc_cfg_bcms[] = {
+	&bcm_cn0,
+	&bcm_cn1,
+};
+
+static struct qcom_icc_node * const cnoc_cfg_nodes[] = {
+	[MASTER_CNOC_CFG] = &qsm_cfg,
+	[SLAVE_AHB2PHY_SOUTH] = &qhs_ahb2phy0,
+	[SLAVE_AHB2PHY_NORTH] = &qhs_ahb2phy1,
+	[SLAVE_AHB2PHY_2] = &qhs_ahb2phy2,
+	[SLAVE_AV1_ENC_CFG] = &qhs_av1_enc_cfg,
+	[SLAVE_CAMERA_CFG] = &qhs_camera_cfg,
+	[SLAVE_CLK_CTL] = &qhs_clk_ctl,
+	[SLAVE_CRYPTO_0_CFG] = &qhs_crypto0_cfg,
+	[SLAVE_DISPLAY_CFG] = &qhs_display_cfg,
+	[SLAVE_GFX3D_CFG] = &qhs_gpuss_cfg,
+	[SLAVE_IMEM_CFG] = &qhs_imem_cfg,
+	[SLAVE_IPC_ROUTER_CFG] = &qhs_ipc_router,
+	[SLAVE_PCIE_0_CFG] = &qhs_pcie0_cfg,
+	[SLAVE_PCIE_1_CFG] = &qhs_pcie1_cfg,
+	[SLAVE_PCIE_2_CFG] = &qhs_pcie2_cfg,
+	[SLAVE_PCIE_3_CFG] = &qhs_pcie3_cfg,
+	[SLAVE_PCIE_4_CFG] = &qhs_pcie4_cfg,
+	[SLAVE_PCIE_5_CFG] = &qhs_pcie5_cfg,
+	[SLAVE_PCIE_6A_CFG] = &qhs_pcie6a_cfg,
+	[SLAVE_PCIE_6B_CFG] = &qhs_pcie6b_cfg,
+	[SLAVE_PCIE_RSC_CFG] = &qhs_pcie_rsc_cfg,
+	[SLAVE_PDM] = &qhs_pdm,
+	[SLAVE_PRNG] = &qhs_prng,
+	[SLAVE_QDSS_CFG] = &qhs_qdss_cfg,
+	[SLAVE_QSPI_0] = &qhs_qspi,
+	[SLAVE_QUP_0] = &qhs_qup0,
+	[SLAVE_QUP_1] = &qhs_qup1,
+	[SLAVE_QUP_2] = &qhs_qup2,
+	[SLAVE_SDCC_2] = &qhs_sdc2,
+	[SLAVE_SDCC_4] = &qhs_sdc4,
+	[SLAVE_SMMUV3_CFG] = &qhs_smmuv3_cfg,
+	[SLAVE_TCSR] = &qhs_tcsr,
+	[SLAVE_TLMM] = &qhs_tlmm,
+	[SLAVE_UFS_MEM_CFG] = &qhs_ufs_mem_cfg,
+	[SLAVE_USB2] = &qhs_usb2_0_cfg,
+	[SLAVE_USB3_0] = &qhs_usb3_0_cfg,
+	[SLAVE_USB3_1] = &qhs_usb3_1_cfg,
+	[SLAVE_USB3_2] = &qhs_usb3_2_cfg,
+	[SLAVE_USB3_MP] = &qhs_usb3_mp_cfg,
+	[SLAVE_USB4_0] = &qhs_usb4_0_cfg,
+	[SLAVE_USB4_1] = &qhs_usb4_1_cfg,
+	[SLAVE_USB4_2] = &qhs_usb4_2_cfg,
+	[SLAVE_VENUS_CFG] = &qhs_venus_cfg,
+	[SLAVE_LPASS_QTB_CFG] = &qss_lpass_qtb_cfg,
+	[SLAVE_CNOC_MNOC_CFG] = &qss_mnoc_cfg,
+	[SLAVE_NSP_QTB_CFG] = &qss_nsp_qtb_cfg,
+	[SLAVE_QDSS_STM] = &xs_qdss_stm,
+	[SLAVE_TCU] = &xs_sys_tcu_cfg,
+};
+
+static const struct qcom_icc_desc sc8380xp_cnoc_cfg = {
+	.nodes = cnoc_cfg_nodes,
+	.num_nodes = ARRAY_SIZE(cnoc_cfg_nodes),
+	.bcms = cnoc_cfg_bcms,
+	.num_bcms = ARRAY_SIZE(cnoc_cfg_bcms),
+};
+
+static struct qcom_icc_bcm * const cnoc_main_bcms[] = {
+	&bcm_cn0,
+};
+
+static struct qcom_icc_node * const cnoc_main_nodes[] = {
+	[MASTER_GEM_NOC_CNOC] = &qnm_gemnoc_cnoc,
+	[MASTER_GEM_NOC_PCIE_SNOC] = &qnm_gemnoc_pcie,
+	[SLAVE_AOSS] = &qhs_aoss,
+	[SLAVE_TME_CFG] = &qhs_tme_cfg,
+	[SLAVE_APPSS] = &qns_apss,
+	[SLAVE_CNOC_CFG] = &qss_cfg,
+	[SLAVE_BOOT_IMEM] = &qxs_boot_imem,
+	[SLAVE_IMEM] = &qxs_imem,
+	[SLAVE_PCIE_0] = &xs_pcie_0,
+	[SLAVE_PCIE_1] = &xs_pcie_1,
+	[SLAVE_PCIE_2] = &xs_pcie_2,
+	[SLAVE_PCIE_3] = &xs_pcie_3,
+	[SLAVE_PCIE_4] = &xs_pcie_4,
+	[SLAVE_PCIE_5] = &xs_pcie_5,
+	[SLAVE_PCIE_6A] = &xs_pcie_6a,
+	[SLAVE_PCIE_6B] = &xs_pcie_6b,
+};
+
+static const struct qcom_icc_desc sc8380xp_cnoc_main = {
+	.nodes = cnoc_main_nodes,
+	.num_nodes = ARRAY_SIZE(cnoc_main_nodes),
+	.bcms = cnoc_main_bcms,
+	.num_bcms = ARRAY_SIZE(cnoc_main_bcms),
+};
+
+static struct qcom_icc_bcm * const gem_noc_bcms[] = {
+	&bcm_sh0,
+	&bcm_sh1,
+	&bcm_sh0_disp,
+	&bcm_sh1_disp,
+	&bcm_sh0_pcie,
+	&bcm_sh1_pcie,
+};
+
+static struct qcom_icc_node * const gem_noc_nodes[] = {
+	[MASTER_GPU_TCU] = &alm_gpu_tcu,
+	[MASTER_PCIE_TCU] = &alm_pcie_tcu,
+	[MASTER_SYS_TCU] = &alm_sys_tcu,
+	[MASTER_APPSS_PROC] = &chm_apps,
+	[MASTER_GFX3D] = &qnm_gpu,
+	[MASTER_LPASS_GEM_NOC] = &qnm_lpass,
+	[MASTER_MNOC_HF_MEM_NOC] = &qnm_mnoc_hf,
+	[MASTER_MNOC_SF_MEM_NOC] = &qnm_mnoc_sf,
+	[MASTER_COMPUTE_NOC] = &qnm_nsp_noc,
+	[MASTER_ANOC_PCIE_GEM_NOC] = &qnm_pcie,
+	[MASTER_SNOC_SF_MEM_NOC] = &qnm_snoc_sf,
+	[MASTER_GIC2] = &xm_gic,
+	[SLAVE_GEM_NOC_CNOC] = &qns_gem_noc_cnoc,
+	[SLAVE_LLCC] = &qns_llcc,
+	[SLAVE_MEM_NOC_PCIE_SNOC] = &qns_pcie,
+	[MASTER_MNOC_HF_MEM_NOC_DISP] = &qnm_mnoc_hf_disp,
+	[MASTER_ANOC_PCIE_GEM_NOC_DISP] = &qnm_pcie_disp,
+	[SLAVE_LLCC_DISP] = &qns_llcc_disp,
+	[MASTER_ANOC_PCIE_GEM_NOC_PCIE] = &qnm_pcie_pcie,
+	[SLAVE_LLCC_PCIE] = &qns_llcc_pcie,
+};
+
+static const struct qcom_icc_desc sc8380xp_gem_noc = {
+	.nodes = gem_noc_nodes,
+	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
+	.bcms = gem_noc_bcms,
+	.num_bcms = ARRAY_SIZE(gem_noc_bcms),
+};
+
+static struct qcom_icc_bcm *lpass_ag_noc_bcms[] = {
+};
+
+static struct qcom_icc_node * const lpass_ag_noc_nodes[] = {
+	[MASTER_LPIAON_NOC] = &qnm_lpiaon_noc,
+	[SLAVE_LPASS_GEM_NOC] = &qns_lpass_ag_noc_gemnoc,
+};
+
+static const struct qcom_icc_desc sc8380xp_lpass_ag_noc = {
+	.nodes = lpass_ag_noc_nodes,
+	.num_nodes = ARRAY_SIZE(lpass_ag_noc_nodes),
+	.bcms = lpass_ag_noc_bcms,
+	.num_bcms = ARRAY_SIZE(lpass_ag_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const lpass_lpiaon_noc_bcms[] = {
+	&bcm_lp0,
+};
+
+static struct qcom_icc_node * const lpass_lpiaon_noc_nodes[] = {
+	[MASTER_LPASS_LPINOC] = &qnm_lpass_lpinoc,
+	[SLAVE_LPIAON_NOC_LPASS_AG_NOC] = &qns_lpass_aggnoc,
+};
+
+static const struct qcom_icc_desc sc8380xp_lpass_lpiaon_noc = {
+	.nodes = lpass_lpiaon_noc_nodes,
+	.num_nodes = ARRAY_SIZE(lpass_lpiaon_noc_nodes),
+	.bcms = lpass_lpiaon_noc_bcms,
+	.num_bcms = ARRAY_SIZE(lpass_lpiaon_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const lpass_lpicx_noc_bcms[] = {
+};
+
+static struct qcom_icc_node * const lpass_lpicx_noc_nodes[] = {
+	[MASTER_LPASS_PROC] = &qxm_lpinoc_dsp_axim,
+	[SLAVE_LPICX_NOC_LPIAON_NOC] = &qns_lpi_aon_noc,
+};
+
+static const struct qcom_icc_desc sc8380xp_lpass_lpicx_noc = {
+	.nodes = lpass_lpicx_noc_nodes,
+	.num_nodes = ARRAY_SIZE(lpass_lpicx_noc_nodes),
+	.bcms = lpass_lpicx_noc_bcms,
+	.num_bcms = ARRAY_SIZE(lpass_lpicx_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const mc_virt_bcms[] = {
+	&bcm_acv,
+	&bcm_mc0,
+	&bcm_acv_disp,
+	&bcm_mc0_disp,
+	&bcm_acv_pcie,
+	&bcm_mc0_pcie,
+};
+
+static struct qcom_icc_node * const mc_virt_nodes[] = {
+	[MASTER_LLCC] = &llcc_mc,
+	[SLAVE_EBI1] = &ebi,
+	[MASTER_LLCC_DISP] = &llcc_mc_disp,
+	[SLAVE_EBI1_DISP] = &ebi_disp,
+	[MASTER_LLCC_PCIE] = &llcc_mc_pcie,
+	[SLAVE_EBI1_PCIE] = &ebi_pcie,
+};
+
+static const struct qcom_icc_desc sc8380xp_mc_virt = {
+	.nodes = mc_virt_nodes,
+	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
+	.bcms = mc_virt_bcms,
+	.num_bcms = ARRAY_SIZE(mc_virt_bcms),
+};
+
+static struct qcom_icc_bcm * const mmss_noc_bcms[] = {
+	&bcm_mm0,
+	&bcm_mm1,
+	&bcm_mm0_disp,
+	&bcm_mm1_disp,
+};
+
+static struct qcom_icc_node * const mmss_noc_nodes[] = {
+	[MASTER_AV1_ENC] = &qnm_av1_enc,
+	[MASTER_CAMNOC_HF] = &qnm_camnoc_hf,
+	[MASTER_CAMNOC_ICP] = &qnm_camnoc_icp,
+	[MASTER_CAMNOC_SF] = &qnm_camnoc_sf,
+	[MASTER_EVA] = &qnm_eva,
+	[MASTER_MDP] = &qnm_mdp,
+	[MASTER_VIDEO] = &qnm_video,
+	[MASTER_VIDEO_CV_PROC] = &qnm_video_cv_cpu,
+	[MASTER_VIDEO_V_PROC] = &qnm_video_v_cpu,
+	[MASTER_CNOC_MNOC_CFG] = &qsm_mnoc_cfg,
+	[SLAVE_MNOC_HF_MEM_NOC] = &qns_mem_noc_hf,
+	[SLAVE_MNOC_SF_MEM_NOC] = &qns_mem_noc_sf,
+	[SLAVE_SERVICE_MNOC] = &srvc_mnoc,
+	[MASTER_MDP_DISP] = &qnm_mdp_disp,
+	[SLAVE_MNOC_HF_MEM_NOC_DISP] = &qns_mem_noc_hf_disp,
+};
+
+static const struct qcom_icc_desc sc8380xp_mmss_noc = {
+	.nodes = mmss_noc_nodes,
+	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
+	.bcms = mmss_noc_bcms,
+	.num_bcms = ARRAY_SIZE(mmss_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const nsp_noc_bcms[] = {
+	&bcm_co0,
+};
+
+static struct qcom_icc_node * const nsp_noc_nodes[] = {
+	[MASTER_CDSP_PROC] = &qxm_nsp,
+	[SLAVE_CDSP_MEM_NOC] = &qns_nsp_gemnoc,
+};
+
+static const struct qcom_icc_desc sc8380xp_nsp_noc = {
+	.nodes = nsp_noc_nodes,
+	.num_nodes = ARRAY_SIZE(nsp_noc_nodes),
+	.bcms = nsp_noc_bcms,
+	.num_bcms = ARRAY_SIZE(nsp_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const pcie_center_anoc_bcms[] = {
+	&bcm_pc0,
+	&bcm_pc0_pcie,
+};
+
+static struct qcom_icc_node * const pcie_center_anoc_nodes[] = {
+	[MASTER_PCIE_NORTH] = &qnm_pcie_north_gem_noc,
+	[MASTER_PCIE_SOUTH] = &qnm_pcie_south_gem_noc,
+	[SLAVE_ANOC_PCIE_GEM_NOC] = &qns_pcie_mem_noc,
+	[MASTER_PCIE_NORTH_PCIE] = &qnm_pcie_north_gem_noc_pcie,
+	[MASTER_PCIE_SOUTH_PCIE] = &qnm_pcie_south_gem_noc_pcie,
+	[SLAVE_ANOC_PCIE_GEM_NOC_PCIE] = &qns_pcie_mem_noc_pcie,
+};
+
+static const struct qcom_icc_desc sc8380xp_pcie_center_anoc = {
+	.nodes = pcie_center_anoc_nodes,
+	.num_nodes = ARRAY_SIZE(pcie_center_anoc_nodes),
+	.bcms = pcie_center_anoc_bcms,
+	.num_bcms = ARRAY_SIZE(pcie_center_anoc_bcms),
+};
+
+static struct qcom_icc_bcm * const pcie_north_anoc_bcms[] = {
+};
+
+static struct qcom_icc_node * const pcie_north_anoc_nodes[] = {
+	[MASTER_PCIE_3] = &xm_pcie_3,
+	[MASTER_PCIE_4] = &xm_pcie_4,
+	[MASTER_PCIE_5] = &xm_pcie_5,
+	[SLAVE_PCIE_NORTH] = &qns_pcie_north_gem_noc,
+	[MASTER_PCIE_3_PCIE] = &xm_pcie_3_pcie,
+	[MASTER_PCIE_4_PCIE] = &xm_pcie_4_pcie,
+	[MASTER_PCIE_5_PCIE] = &xm_pcie_5_pcie,
+	[SLAVE_PCIE_NORTH_PCIE] = &qns_pcie_north_gem_noc_pcie,
+};
+
+static const struct qcom_icc_desc sc8380xp_pcie_north_anoc = {
+	.nodes = pcie_north_anoc_nodes,
+	.num_nodes = ARRAY_SIZE(pcie_north_anoc_nodes),
+	.bcms = pcie_north_anoc_bcms,
+	.num_bcms = ARRAY_SIZE(pcie_north_anoc_bcms),
+};
+
+static struct qcom_icc_bcm *pcie_south_anoc_bcms[] = {
+};
+
+static struct qcom_icc_node * const pcie_south_anoc_nodes[] = {
+	[MASTER_PCIE_0] = &xm_pcie_0,
+	[MASTER_PCIE_1] = &xm_pcie_1,
+	[MASTER_PCIE_2] = &xm_pcie_2,
+	[MASTER_PCIE_6A] = &xm_pcie_6a,
+	[MASTER_PCIE_6B] = &xm_pcie_6b,
+	[SLAVE_PCIE_SOUTH] = &qns_pcie_south_gem_noc,
+	[MASTER_PCIE_0_PCIE] = &xm_pcie_0_pcie,
+	[MASTER_PCIE_1_PCIE] = &xm_pcie_1_pcie,
+	[MASTER_PCIE_2_PCIE] = &xm_pcie_2_pcie,
+	[MASTER_PCIE_6A_PCIE] = &xm_pcie_6a_pcie,
+	[MASTER_PCIE_6B_PCIE] = &xm_pcie_6b_pcie,
+	[SLAVE_PCIE_SOUTH_PCIE] = &qns_pcie_south_gem_noc_pcie,
+};
+
+static const struct qcom_icc_desc sc8380xp_pcie_south_anoc = {
+	.nodes = pcie_south_anoc_nodes,
+	.num_nodes = ARRAY_SIZE(pcie_south_anoc_nodes),
+	.bcms = pcie_south_anoc_bcms,
+	.num_bcms = ARRAY_SIZE(pcie_south_anoc_bcms),
+};
+
+static struct qcom_icc_bcm *system_noc_bcms[] = {
+	&bcm_sn0,
+	&bcm_sn2,
+	&bcm_sn3,
+	&bcm_sn4,
+};
+
+static struct qcom_icc_node * const system_noc_nodes[] = {
+	[MASTER_A1NOC_SNOC] = &qnm_aggre1_noc,
+	[MASTER_A2NOC_SNOC] = &qnm_aggre2_noc,
+	[MASTER_GIC1] = &qnm_gic,
+	[MASTER_USB_NOC_SNOC] = &qnm_usb_anoc,
+	[SLAVE_SNOC_GEM_NOC_SF] = &qns_gemnoc_sf,
+};
+
+static const struct qcom_icc_desc sc8380xp_system_noc = {
+	.nodes = system_noc_nodes,
+	.num_nodes = ARRAY_SIZE(system_noc_nodes),
+	.bcms = system_noc_bcms,
+	.num_bcms = ARRAY_SIZE(system_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const usb_center_anoc_bcms[] = {
+};
+
+static struct qcom_icc_node * const usb_center_anoc_nodes[] = {
+	[MASTER_AGGRE_USB_NORTH] = &qnm_aggre_usb_north_snoc,
+	[MASTER_AGGRE_USB_SOUTH] = &qnm_aggre_usb_south_snoc,
+	[SLAVE_USB_NOC_SNOC] = &qns_aggre_usb_snoc,
+};
+
+static const struct qcom_icc_desc sc8380xp_usb_center_anoc = {
+	.nodes = usb_center_anoc_nodes,
+	.num_nodes = ARRAY_SIZE(usb_center_anoc_nodes),
+	.bcms = usb_center_anoc_bcms,
+	.num_bcms = ARRAY_SIZE(usb_center_anoc_bcms),
+};
+
+static struct qcom_icc_bcm *usb_north_anoc_bcms[] = {
+};
+
+static struct qcom_icc_node * const usb_north_anoc_nodes[] = {
+	[MASTER_USB2] = &xm_usb2_0,
+	[MASTER_USB3_MP] = &xm_usb3_mp,
+	[SLAVE_AGGRE_USB_NORTH] = &qns_aggre_usb_north_snoc,
+};
+
+static const struct qcom_icc_desc sc8380xp_usb_north_anoc = {
+	.nodes = usb_north_anoc_nodes,
+	.num_nodes = ARRAY_SIZE(usb_north_anoc_nodes),
+	.bcms = usb_north_anoc_bcms,
+	.num_bcms = ARRAY_SIZE(usb_north_anoc_bcms),
+};
+
+static struct qcom_icc_bcm *usb_south_anoc_bcms[] = {
+};
+
+static struct qcom_icc_node * const usb_south_anoc_nodes[] = {
+	[MASTER_USB3_0] = &xm_usb3_0,
+	[MASTER_USB3_1] = &xm_usb3_1,
+	[MASTER_USB3_2] = &xm_usb3_2,
+	[MASTER_USB4_0] = &xm_usb4_0,
+	[MASTER_USB4_1] = &xm_usb4_1,
+	[MASTER_USB4_2] = &xm_usb4_2,
+	[SLAVE_AGGRE_USB_SOUTH] = &qns_aggre_usb_south_snoc,
+};
+
+static const struct qcom_icc_desc sc8380xp_usb_south_anoc = {
+	.nodes = usb_south_anoc_nodes,
+	.num_nodes = ARRAY_SIZE(usb_south_anoc_nodes),
+	.bcms = usb_south_anoc_bcms,
+	.num_bcms = ARRAY_SIZE(usb_south_anoc_bcms),
+};
+
+static const struct of_device_id qnoc_of_match[] = {
+	{ .compatible = "qcom,sc8380xp-aggre1-noc", .data = &sc8380xp_aggre1_noc},
+	{ .compatible = "qcom,sc8380xp-aggre2-noc", .data = &sc8380xp_aggre2_noc},
+	{ .compatible = "qcom,sc8380xp-clk-virt", .data = &sc8380xp_clk_virt},
+	{ .compatible = "qcom,sc8380xp-cnoc-cfg", .data = &sc8380xp_cnoc_cfg},
+	{ .compatible = "qcom,sc8380xp-cnoc-main", .data = &sc8380xp_cnoc_main},
+	{ .compatible = "qcom,sc8380xp-gem-noc", .data = &sc8380xp_gem_noc},
+	{ .compatible = "qcom,sc8380xp-lpass-ag-noc", .data = &sc8380xp_lpass_ag_noc},
+	{ .compatible = "qcom,sc8380xp-lpass-lpiaon-noc", .data = &sc8380xp_lpass_lpiaon_noc},
+	{ .compatible = "qcom,sc8380xp-lpass-lpicx-noc", .data = &sc8380xp_lpass_lpicx_noc},
+	{ .compatible = "qcom,sc8380xp-mc-virt", .data = &sc8380xp_mc_virt},
+	{ .compatible = "qcom,sc8380xp-mmss-noc", .data = &sc8380xp_mmss_noc},
+	{ .compatible = "qcom,sc8380xp-nsp-noc", .data = &sc8380xp_nsp_noc},
+	{ .compatible = "qcom,sc8380xp-pcie-center-anoc", .data = &sc8380xp_pcie_center_anoc},
+	{ .compatible = "qcom,sc8380xp-pcie-north-anoc", .data = &sc8380xp_pcie_north_anoc},
+	{ .compatible = "qcom,sc8380xp-pcie-south-anoc", .data = &sc8380xp_pcie_south_anoc},
+	{ .compatible = "qcom,sc8380xp-system-noc", .data = &sc8380xp_system_noc},
+	{ .compatible = "qcom,sc8380xp-usb-center-anoc", .data = &sc8380xp_usb_center_anoc},
+	{ .compatible = "qcom,sc8380xp-usb-north-anoc", .data = &sc8380xp_usb_north_anoc},
+	{ .compatible = "qcom,sc8380xp-usb-south-anoc", .data = &sc8380xp_usb_south_anoc},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, qnoc_of_match);
+
+static struct platform_driver qnoc_driver = {
+	.probe = qcom_icc_rpmh_probe,
+	.remove_new = qcom_icc_rpmh_remove,
+	.driver = {
+		.name = "qnoc-sc8380xp",
+		.of_match_table = qnoc_of_match,
+		.sync_state = icc_sync_state,
+	},
+};
+
+static int __init qnoc_driver_init(void)
+{
+	return platform_driver_register(&qnoc_driver);
+}
+core_initcall(qnoc_driver_init);
+
+static void __exit qnoc_driver_exit(void)
+{
+	platform_driver_unregister(&qnoc_driver);
+}
+module_exit(qnoc_driver_exit);
+
+MODULE_DESCRIPTION("sc8380xp NoC driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/interconnect/qcom/sc8380xp.h b/drivers/interconnect/qcom/sc8380xp.h
new file mode 100644
index 000000000000..1ed2131dc034
--- /dev/null
+++ b/drivers/interconnect/qcom/sc8380xp.h
@@ -0,0 +1,192 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * SC8380XP interconnect IDs
+ *
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef __DRIVERS_INTERCONNECT_QCOM_SC8380XP_H
+#define __DRIVERS_INTERCONNECT_QCOM_SC8380XP_H
+
+#define SC8380XP_MASTER_A1NOC_SNOC			0
+#define SC8380XP_MASTER_A2NOC_SNOC			1
+#define SC8380XP_MASTER_ANOC_PCIE_GEM_NOC		2
+#define SC8380XP_MASTER_ANOC_PCIE_GEM_NOC_DISP		3
+#define SC8380XP_MASTER_APPSS_PROC			4
+#define SC8380XP_MASTER_CAMNOC_HF			5
+#define SC8380XP_MASTER_CAMNOC_ICP			6
+#define SC8380XP_MASTER_CAMNOC_SF			7
+#define SC8380XP_MASTER_CDSP_PROC			8
+#define SC8380XP_MASTER_CNOC_CFG			9
+#define SC8380XP_MASTER_CNOC_MNOC_CFG			10
+#define SC8380XP_MASTER_COMPUTE_NOC			11
+#define SC8380XP_MASTER_CRYPTO				12
+#define SC8380XP_MASTER_GEM_NOC_CNOC			13
+#define SC8380XP_MASTER_GEM_NOC_PCIE_SNOC		14
+#define SC8380XP_MASTER_GFX3D				15
+#define SC8380XP_MASTER_GPU_TCU				16
+#define SC8380XP_MASTER_IPA				17
+#define SC8380XP_MASTER_LLCC				18
+#define SC8380XP_MASTER_LLCC_DISP			19
+#define SC8380XP_MASTER_LPASS_GEM_NOC			20
+#define SC8380XP_MASTER_LPASS_LPINOC			21
+#define SC8380XP_MASTER_LPASS_PROC			22
+#define SC8380XP_MASTER_LPIAON_NOC			23
+#define SC8380XP_MASTER_MDP				24
+#define SC8380XP_MASTER_MDP_DISP			25
+#define SC8380XP_MASTER_MNOC_HF_MEM_NOC			26
+#define SC8380XP_MASTER_MNOC_HF_MEM_NOC_DISP		27
+#define SC8380XP_MASTER_MNOC_SF_MEM_NOC			28
+#define SC8380XP_MASTER_PCIE_0				29
+#define SC8380XP_MASTER_PCIE_1				30
+#define SC8380XP_MASTER_QDSS_ETR			31
+#define SC8380XP_MASTER_QDSS_ETR_1			32
+#define SC8380XP_MASTER_QSPI_0				33
+#define SC8380XP_MASTER_QUP_0				34
+#define SC8380XP_MASTER_QUP_1				35
+#define SC8380XP_MASTER_QUP_2				36
+#define SC8380XP_MASTER_QUP_CORE_0			37
+#define SC8380XP_MASTER_QUP_CORE_1			38
+#define SC8380XP_MASTER_SDCC_2				39
+#define SC8380XP_MASTER_SDCC_4				40
+#define SC8380XP_MASTER_SNOC_SF_MEM_NOC			41
+#define SC8380XP_MASTER_SP				42
+#define SC8380XP_MASTER_SYS_TCU				43
+#define SC8380XP_MASTER_UFS_MEM				44
+#define SC8380XP_MASTER_USB3_0				45
+#define SC8380XP_MASTER_VIDEO				46
+#define SC8380XP_MASTER_VIDEO_CV_PROC			47
+#define SC8380XP_MASTER_VIDEO_V_PROC			48
+#define SC8380XP_SLAVE_A1NOC_SNOC			49
+#define SC8380XP_SLAVE_A2NOC_SNOC			50
+#define SC8380XP_SLAVE_AHB2PHY_NORTH			51
+#define SC8380XP_SLAVE_AHB2PHY_SOUTH			52
+#define SC8380XP_SLAVE_ANOC_PCIE_GEM_NOC		53
+#define SC8380XP_SLAVE_AOSS				54
+#define SC8380XP_SLAVE_APPSS				55
+#define SC8380XP_SLAVE_BOOT_IMEM			56
+#define SC8380XP_SLAVE_CAMERA_CFG			57
+#define SC8380XP_SLAVE_CDSP_MEM_NOC			58
+#define SC8380XP_SLAVE_CLK_CTL				59
+#define SC8380XP_SLAVE_CNOC_CFG				60
+#define SC8380XP_SLAVE_CNOC_MNOC_CFG			61
+#define SC8380XP_SLAVE_CRYPTO_0_CFG			62
+#define SC8380XP_SLAVE_DISPLAY_CFG			63
+#define SC8380XP_SLAVE_EBI1				64
+#define SC8380XP_SLAVE_EBI1_DISP			65
+#define SC8380XP_SLAVE_GEM_NOC_CNOC			66
+#define SC8380XP_SLAVE_GFX3D_CFG			67
+#define SC8380XP_SLAVE_IMEM				68
+#define SC8380XP_SLAVE_IMEM_CFG				69
+#define SC8380XP_SLAVE_IPC_ROUTER_CFG			70
+#define SC8380XP_SLAVE_LLCC				71
+#define SC8380XP_SLAVE_LLCC_DISP			72
+#define SC8380XP_SLAVE_LPASS_GEM_NOC			73
+#define SC8380XP_SLAVE_LPASS_QTB_CFG			74
+#define SC8380XP_SLAVE_LPIAON_NOC_LPASS_AG_NOC		75
+#define SC8380XP_SLAVE_LPICX_NOC_LPIAON_NOC		76
+#define SC8380XP_SLAVE_MEM_NOC_PCIE_SNOC		77
+#define SC8380XP_SLAVE_MNOC_HF_MEM_NOC			78
+#define SC8380XP_SLAVE_MNOC_HF_MEM_NOC_DISP		79
+#define SC8380XP_SLAVE_MNOC_SF_MEM_NOC			80
+#define SC8380XP_SLAVE_NSP_QTB_CFG			81
+#define SC8380XP_SLAVE_PCIE_0				82
+#define SC8380XP_SLAVE_PCIE_0_CFG			83
+#define SC8380XP_SLAVE_PCIE_1				84
+#define SC8380XP_SLAVE_PCIE_1_CFG			85
+#define SC8380XP_SLAVE_PDM				86
+#define SC8380XP_SLAVE_PRNG				87
+#define SC8380XP_SLAVE_QDSS_CFG				88
+#define SC8380XP_SLAVE_QDSS_STM				89
+#define SC8380XP_SLAVE_QSPI_0				90
+#define SC8380XP_SLAVE_QUP_1				91
+#define SC8380XP_SLAVE_QUP_2				92
+#define SC8380XP_SLAVE_QUP_CORE_0			93
+#define SC8380XP_SLAVE_QUP_CORE_1			94
+#define SC8380XP_SLAVE_QUP_CORE_2			95
+#define SC8380XP_SLAVE_SDCC_2				96
+#define SC8380XP_SLAVE_SDCC_4				97
+#define SC8380XP_SLAVE_SERVICE_MNOC			98
+#define SC8380XP_SLAVE_SNOC_GEM_NOC_SF			99
+#define SC8380XP_SLAVE_TCSR				100
+#define SC8380XP_SLAVE_TCU				101
+#define SC8380XP_SLAVE_TLMM				102
+#define SC8380XP_SLAVE_TME_CFG				103
+#define SC8380XP_SLAVE_UFS_MEM_CFG			104
+#define SC8380XP_SLAVE_USB3_0				105
+#define SC8380XP_SLAVE_VENUS_CFG			106
+#define SC8380XP_MASTER_DDR_PERF_MODE			107
+#define SC8380XP_MASTER_QUP_CORE_2			108
+#define SC8380XP_MASTER_PCIE_TCU			109
+#define SC8380XP_MASTER_GIC2				110
+#define SC8380XP_MASTER_AV1_ENC				111
+#define SC8380XP_MASTER_EVA				112
+#define SC8380XP_MASTER_PCIE_NORTH			113
+#define SC8380XP_MASTER_PCIE_SOUTH			114
+#define SC8380XP_MASTER_PCIE_3				115
+#define SC8380XP_MASTER_PCIE_4				116
+#define SC8380XP_MASTER_PCIE_5				117
+#define SC8380XP_MASTER_PCIE_2				118
+#define SC8380XP_MASTER_PCIE_6A				119
+#define SC8380XP_MASTER_PCIE_6B				120
+#define SC8380XP_MASTER_GIC1				121
+#define SC8380XP_MASTER_USB_NOC_SNOC			122
+#define SC8380XP_MASTER_AGGRE_USB_NORTH			123
+#define SC8380XP_MASTER_AGGRE_USB_SOUTH			124
+#define SC8380XP_MASTER_USB2				125
+#define SC8380XP_MASTER_USB3_MP				126
+#define SC8380XP_MASTER_USB3_1				127
+#define SC8380XP_MASTER_USB3_2				128
+#define SC8380XP_MASTER_USB4_0				129
+#define SC8380XP_MASTER_USB4_1				130
+#define SC8380XP_MASTER_USB4_2				131
+#define SC8380XP_MASTER_ANOC_PCIE_GEM_NOC_PCIE		132
+#define SC8380XP_MASTER_LLCC_PCIE			133
+#define SC8380XP_MASTER_PCIE_NORTH_PCIE			134
+#define SC8380XP_MASTER_PCIE_SOUTH_PCIE			135
+#define SC8380XP_MASTER_PCIE_3_PCIE			136
+#define SC8380XP_MASTER_PCIE_4_PCIE			137
+#define SC8380XP_MASTER_PCIE_5_PCIE			138
+#define SC8380XP_MASTER_PCIE_0_PCIE			139
+#define SC8380XP_MASTER_PCIE_1_PCIE			140
+#define SC8380XP_MASTER_PCIE_2_PCIE			141
+#define SC8380XP_MASTER_PCIE_6A_PCIE			142
+#define SC8380XP_MASTER_PCIE_6B_PCIE			143
+#define SC8380XP_SLAVE_AHB2PHY_2			144
+#define SC8380XP_SLAVE_AV1_ENC_CFG			145
+#define SC8380XP_SLAVE_PCIE_2_CFG			146
+#define SC8380XP_SLAVE_PCIE_3_CFG			147
+#define SC8380XP_SLAVE_PCIE_4_CFG			148
+#define SC8380XP_SLAVE_PCIE_5_CFG			149
+#define SC8380XP_SLAVE_PCIE_6A_CFG			150
+#define SC8380XP_SLAVE_PCIE_6B_CFG			151
+#define SC8380XP_SLAVE_PCIE_RSC_CFG			152
+#define SC8380XP_SLAVE_QUP_0				153
+#define SC8380XP_SLAVE_SMMUV3_CFG			154
+#define SC8380XP_SLAVE_USB2				155
+#define SC8380XP_SLAVE_USB3_1				156
+#define SC8380XP_SLAVE_USB3_2				157
+#define SC8380XP_SLAVE_USB3_MP				158
+#define SC8380XP_SLAVE_USB4_0				159
+#define SC8380XP_SLAVE_USB4_1				160
+#define SC8380XP_SLAVE_USB4_2				161
+#define SC8380XP_SLAVE_PCIE_2				162
+#define SC8380XP_SLAVE_PCIE_3				163
+#define SC8380XP_SLAVE_PCIE_4				164
+#define SC8380XP_SLAVE_PCIE_5				165
+#define SC8380XP_SLAVE_PCIE_6A				166
+#define SC8380XP_SLAVE_PCIE_6B				167
+#define SC8380XP_SLAVE_DDR_PERF_MODE			168
+#define SC8380XP_SLAVE_PCIE_NORTH			169
+#define SC8380XP_SLAVE_PCIE_SOUTH			170
+#define SC8380XP_SLAVE_USB_NOC_SNOC			171
+#define SC8380XP_SLAVE_AGGRE_USB_NORTH			172
+#define SC8380XP_SLAVE_AGGRE_USB_SOUTH			173
+#define SC8380XP_SLAVE_LLCC_PCIE			174
+#define SC8380XP_SLAVE_EBI1_PCIE			175
+#define SC8380XP_SLAVE_ANOC_PCIE_GEM_NOC_PCIE		176
+#define SC8380XP_SLAVE_PCIE_NORTH_PCIE			177
+#define SC8380XP_SLAVE_PCIE_SOUTH_PCIE			178
+
+#endif
-- 
2.17.1

