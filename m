Return-Path: <linux-kernel+bounces-96062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A25418756AE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17A9D1F21DF6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D35B13AA2D;
	Thu,  7 Mar 2024 19:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IfYAxPUv"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ACE138481;
	Thu,  7 Mar 2024 19:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709838366; cv=none; b=admzMMV4ptKK5YFgP/MxnJArWU+lGLNJFMb6HxMPEhLdcpYYXUwztTy0DoW4+pWPU/AEXbYBVhAaevcRLDvDe8HO5Tc9B0a+NJbY0YtLZu1XZTIioFClBNsWYAiVLV3HqLq+R871n9qzDRpGkADXKtKeNc0YwWMCc9Ssn18AK7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709838366; c=relaxed/simple;
	bh=w9NIMnXWQiVChnsif4pfmm4e+bJpt5H83KwKkJjC9rU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lpsz1/FfslLgt2H8Fh7VVkjKmMVEkWOtmHE2CjVAWcV4pXDwrlCcxfkCA4qfqnBfP3Qf7TSxU/N8nCpEgye2M10DzFMCnsyx06buabWpT2MiItXLT4Al+xFT7mxg5QI147DsrNh2nGToflFg5Z0V0nNrOOThIJSPFbZ3Er3onJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IfYAxPUv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 427FxBkh018859;
	Thu, 7 Mar 2024 19:05:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=njBOwP2K3x9BNj1SHCEmmqhtRWGTl3jiZuZSs3PrC2g=; b=If
	YAxPUvsg+sn4f4dDs2Q0ujYexGjOuJpyC04kBYcXYw4r2QIz/4qevovrhRzmqJQz
	EdWr1JsDGJuGrDbpfSZ/9bxPUbuWfFAkG+D6BIMZ3GQt+HGuoAdMVWWrVVFdzIYe
	9ErQmcJ4eryGClnf+LOUizoYEH6VcJXCxYdwq5hPMkcfKU+spQhnrsjUvCbcj4Bv
	vHOKOMfuiJtOnhvmSTUYYyj99h86ifGA6aYITwoAq2mUA15Z/Z8EN8YGnnC6PpVO
	P0TAbW6j+AJkmbLJW34HMStLOo/lvynAapxXjvClyKnFMl1pK3qIyaE5PQDGlbVg
	R97e98HyonvjIv5zAMjQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wq7husfg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 19:05:46 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 427J5j8S015034
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Mar 2024 19:05:45 GMT
Received: from hu-c-gdjako-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 7 Mar 2024 11:05:44 -0800
From: Georgi Djakov <quic_c_gdjako@quicinc.com>
To: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <devicetree@vger.kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robdclark@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_cgoldswo@quicinc.com>,
        <quic_sukadev@quicinc.com>, <quic_pdaly@quicinc.com>,
        <quic_sudaraja@quicinc.com>, <djakov@kernel.org>
Subject: [PATCH v6 2/7] iommu/arm-smmu-qcom-tbu: Add Qualcomm TBU driver
Date: Thu, 7 Mar 2024 11:05:20 -0800
Message-ID: <20240307190525.395291-3-quic_c_gdjako@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240307190525.395291-1-quic_c_gdjako@quicinc.com>
References: <20240307190525.395291-1-quic_c_gdjako@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oynGxpybTFKZfzQez103ZpbX6eZ4GwIc
X-Proofpoint-ORIG-GUID: oynGxpybTFKZfzQez103ZpbX6eZ4GwIc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_14,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403070133

Operating the TBUs (Translation Buffer Units) from Linux on Qualcomm
platforms can help with debugging context faults. To help with that,
the TBUs can run ATOS (Address Translation Operations) to manually
trigger address translation of IOVA to physical address in hardware
and provide more details when a context fault happens.

The driver will control the resources needed by the TBU to allow
running the debug operations such as ATOS, check for outstanding
transactions, do snapshot capture etc.

Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
---
 drivers/iommu/Kconfig                         |   9 +
 drivers/iommu/arm/arm-smmu/Makefile           |   1 +
 .../iommu/arm/arm-smmu/arm-smmu-qcom-tbu.c    | 366 ++++++++++++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h    |   2 +
 drivers/iommu/arm/arm-smmu/arm-smmu.h         |   2 +
 5 files changed, 380 insertions(+)
 create mode 100644 drivers/iommu/arm/arm-smmu/arm-smmu-qcom-tbu.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index e0796fa84227..989e481e3151 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -374,6 +374,15 @@ config ARM_SMMU_QCOM
 	  When running on a Qualcomm platform that has the custom variant
 	  of the ARM SMMU, this needs to be built into the SMMU driver.
 
+config ARM_SMMU_QCOM_TBU
+	bool "Qualcomm TBU driver"
+	depends on ARM_SMMU_QCOM
+	help
+	  The SMMUs on Qualcomm platforms may include Translation Buffer
+	  Units (TBUs) for each master. Enabling support for these units
+	  allows to operate the TBUs and obtain additional information
+	  when debugging memory management issues like context faults.
+
 config ARM_SMMU_QCOM_DEBUG
 	bool "ARM SMMU QCOM implementation defined debug support"
 	depends on ARM_SMMU_QCOM
diff --git a/drivers/iommu/arm/arm-smmu/Makefile b/drivers/iommu/arm/arm-smmu/Makefile
index 2a5a95e8e3f9..c35ff78fcfd5 100644
--- a/drivers/iommu/arm/arm-smmu/Makefile
+++ b/drivers/iommu/arm/arm-smmu/Makefile
@@ -3,4 +3,5 @@ obj-$(CONFIG_QCOM_IOMMU) += qcom_iommu.o
 obj-$(CONFIG_ARM_SMMU) += arm_smmu.o
 arm_smmu-objs += arm-smmu.o arm-smmu-impl.o arm-smmu-nvidia.o
 arm_smmu-$(CONFIG_ARM_SMMU_QCOM) += arm-smmu-qcom.o
+arm_smmu-$(CONFIG_ARM_SMMU_QCOM_TBU) += arm-smmu-qcom-tbu.o
 arm_smmu-$(CONFIG_ARM_SMMU_QCOM_DEBUG) += arm-smmu-qcom-debug.o
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-tbu.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-tbu.c
new file mode 100644
index 000000000000..2a7c8a9cc9e6
--- /dev/null
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-tbu.c
@@ -0,0 +1,366 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved
+ */
+
+#include <linux/interconnect.h>
+#include <linux/iopoll.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+
+#include "arm-smmu.h"
+#include "arm-smmu-qcom.h"
+
+#define TBU_DBG_TIMEOUT_US		100
+#define DEBUG_AXUSER_REG		0x30
+#define DEBUG_AXUSER_CDMID		GENMASK_ULL(43, 36)
+#define DEBUG_AXUSER_CDMID_VAL		0xff
+#define DEBUG_PAR_REG			0x28
+#define DEBUG_PAR_FAULT_VAL		BIT(0)
+#define DEBUG_PAR_PA			GENMASK_ULL(47, 12)
+#define DEBUG_SID_HALT_REG		0x0
+#define DEBUG_SID_HALT_VAL		BIT(16)
+#define DEBUG_SID_HALT_SID		GENMASK(9, 0)
+#define DEBUG_SR_HALT_ACK_REG		0x20
+#define DEBUG_SR_HALT_ACK_VAL		BIT(1)
+#define DEBUG_SR_ECATS_RUNNING_VAL	BIT(0)
+#define DEBUG_TXN_AXCACHE		GENMASK(5, 2)
+#define DEBUG_TXN_AXPROT		GENMASK(8, 6)
+#define DEBUG_TXN_AXPROT_PRIV		0x1
+#define DEBUG_TXN_AXPROT_NSEC		0x2
+#define DEBUG_TXN_TRIGG_REG		0x18
+#define DEBUG_TXN_TRIGGER		BIT(0)
+#define DEBUG_VA_ADDR_REG		0x8
+
+static LIST_HEAD(tbu_list);
+static DEFINE_MUTEX(tbu_list_lock);
+static DEFINE_SPINLOCK(atos_lock);
+
+struct qcom_tbu {
+	struct device *dev;
+	struct device_node *smmu_np;
+	u32 sid_range[2];
+	struct list_head list;
+	struct clk *clk;
+	struct icc_path	*path;
+	void __iomem *base;
+	spinlock_t halt_lock; /* multiple halt or resume can't execute concurrently */
+	int halt_count;
+};
+
+static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
+{
+	return container_of(smmu, struct qcom_smmu, smmu);
+}
+
+static struct qcom_tbu *qcom_find_tbu(struct qcom_smmu *qsmmu, u32 sid)
+{
+	struct qcom_tbu *tbu;
+	u32 start, end;
+
+	mutex_lock(&tbu_list_lock);
+
+	list_for_each_entry(tbu, &tbu_list, list) {
+		start = tbu->sid_range[0];
+		end = start + tbu->sid_range[1];
+
+		if (qsmmu->smmu.dev->of_node == tbu->smmu_np &&
+		    start <= sid && sid < end) {
+			mutex_unlock(&tbu_list_lock);
+			return tbu;
+		}
+	}
+
+	mutex_unlock(&tbu_list_lock);
+	dev_err(qsmmu->smmu.dev, "Unable to find TBU for sid 0x%x\n", sid);
+	return NULL;
+}
+
+static int qcom_tbu_halt(struct qcom_tbu *tbu, struct arm_smmu_domain *smmu_domain)
+{
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	int ret = 0, idx = smmu_domain->cfg.cbndx;
+	unsigned long flags;
+	u32 val, fsr, status;
+
+	spin_lock_irqsave(&tbu->halt_lock, flags);
+	if (tbu->halt_count) {
+		tbu->halt_count++;
+		goto out;
+	}
+
+	val = readl_relaxed(tbu->base + DEBUG_SID_HALT_REG);
+	val |= DEBUG_SID_HALT_VAL;
+	writel_relaxed(val, tbu->base + DEBUG_SID_HALT_REG);
+
+	fsr = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSR);
+	if ((fsr & ARM_SMMU_FSR_FAULT) && (fsr & ARM_SMMU_FSR_SS)) {
+		u32 sctlr_orig, sctlr;
+
+		/*
+		 * We are in a fault. Our request to halt the bus will not
+		 * complete until transactions in front of us (such as the fault
+		 * itself) have completed. Disable iommu faults and terminate
+		 * any existing transactions.
+		 */
+		sctlr_orig = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_SCTLR);
+		sctlr = sctlr_orig & ~(ARM_SMMU_SCTLR_CFCFG | ARM_SMMU_SCTLR_CFIE);
+		arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_SCTLR, sctlr);
+		arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_FSR, fsr);
+		arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_RESUME, ARM_SMMU_RESUME_TERMINATE);
+		arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_SCTLR, sctlr_orig);
+	}
+
+	if (readl_poll_timeout_atomic(tbu->base + DEBUG_SR_HALT_ACK_REG, status,
+				      (status & DEBUG_SR_HALT_ACK_VAL),
+				      0, TBU_DBG_TIMEOUT_US)) {
+		dev_err(tbu->dev, "Timeout while trying to halt TBU!\n");
+		ret = -ETIMEDOUT;
+
+		val = readl_relaxed(tbu->base + DEBUG_SID_HALT_REG);
+		val &= ~DEBUG_SID_HALT_VAL;
+		writel_relaxed(val, tbu->base + DEBUG_SID_HALT_REG);
+
+		goto out;
+	}
+
+	tbu->halt_count = 1;
+
+out:
+	spin_unlock_irqrestore(&tbu->halt_lock, flags);
+	return ret;
+}
+
+static void qcom_tbu_resume(struct qcom_tbu *tbu)
+{
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(&tbu->halt_lock, flags);
+	if (!tbu->halt_count) {
+		WARN(1, "%s: halt_count is 0", dev_name(tbu->dev));
+		goto out;
+	}
+
+	if (tbu->halt_count > 1) {
+		tbu->halt_count--;
+		goto out;
+	}
+
+	val = readl_relaxed(tbu->base + DEBUG_SID_HALT_REG);
+	val &= ~DEBUG_SID_HALT_VAL;
+	writel_relaxed(val, tbu->base + DEBUG_SID_HALT_REG);
+
+	tbu->halt_count = 0;
+out:
+	spin_unlock_irqrestore(&tbu->halt_lock, flags);
+}
+
+static phys_addr_t qcom_tbu_trigger_atos(struct arm_smmu_domain *smmu_domain,
+					 struct qcom_tbu *tbu, dma_addr_t iova, u32 sid)
+{
+	bool atos_timedout = false;
+	phys_addr_t phys = 0;
+	ktime_t timeout;
+	u64 val;
+
+	/* Set address and stream-id */
+	val = readq_relaxed(tbu->base + DEBUG_SID_HALT_REG);
+	val &= ~DEBUG_SID_HALT_SID;
+	val |= FIELD_PREP(DEBUG_SID_HALT_SID, sid);
+	writeq_relaxed(val, tbu->base + DEBUG_SID_HALT_REG);
+	writeq_relaxed(iova, tbu->base + DEBUG_VA_ADDR_REG);
+	val = FIELD_PREP(DEBUG_AXUSER_CDMID, DEBUG_AXUSER_CDMID_VAL);
+	writeq_relaxed(val, tbu->base + DEBUG_AXUSER_REG);
+
+	/* Write-back read and write-allocate */
+	val = FIELD_PREP(DEBUG_TXN_AXCACHE, 0xf);
+
+	/* Non-secure access */
+	val |= FIELD_PREP(DEBUG_TXN_AXPROT, DEBUG_TXN_AXPROT_NSEC);
+
+	/* Privileged access */
+	val |= FIELD_PREP(DEBUG_TXN_AXPROT, DEBUG_TXN_AXPROT_PRIV);
+
+	val |= DEBUG_TXN_TRIGGER;
+	writeq_relaxed(val, tbu->base + DEBUG_TXN_TRIGG_REG);
+
+	timeout = ktime_add_us(ktime_get(), TBU_DBG_TIMEOUT_US);
+	for (;;) {
+		val = readl_relaxed(tbu->base + DEBUG_SR_HALT_ACK_REG);
+		if (!(val & DEBUG_SR_ECATS_RUNNING_VAL))
+			break;
+		val = readl_relaxed(tbu->base + DEBUG_PAR_REG);
+		if (val & DEBUG_PAR_FAULT_VAL)
+			break;
+		if (ktime_compare(ktime_get(), timeout) > 0) {
+			atos_timedout = true;
+			break;
+		}
+	}
+
+	val = readq_relaxed(tbu->base + DEBUG_PAR_REG);
+	if (val & DEBUG_PAR_FAULT_VAL)
+		dev_err(tbu->dev, "ATOS generated a fault interrupt! PAR = %llx, SID=0x%x\n",
+			val, sid);
+	else if (atos_timedout)
+		dev_err_ratelimited(tbu->dev, "ATOS translation timed out!\n");
+	else
+		phys = FIELD_GET(DEBUG_PAR_PA, val);
+
+	/* Reset hardware */
+	writeq_relaxed(0, tbu->base + DEBUG_TXN_TRIGG_REG);
+	writeq_relaxed(0, tbu->base + DEBUG_VA_ADDR_REG);
+	val = readl_relaxed(tbu->base + DEBUG_SID_HALT_REG);
+	val &= ~DEBUG_SID_HALT_SID;
+	writel_relaxed(val, tbu->base + DEBUG_SID_HALT_REG);
+
+	return phys;
+}
+
+static phys_addr_t qcom_iova_to_phys(struct arm_smmu_domain *smmu_domain,
+				     dma_addr_t iova, u32 sid)
+{
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
+	int idx = smmu_domain->cfg.cbndx;
+	struct qcom_tbu *tbu;
+	u32 sctlr_orig, sctlr;
+	phys_addr_t phys = 0;
+	unsigned long flags;
+	int attempt = 0;
+	int ret;
+	u64 fsr;
+
+	tbu = qcom_find_tbu(qsmmu, sid);
+	if (!tbu)
+		return 0;
+
+	ret = icc_set_bw(tbu->path, 0, UINT_MAX);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(tbu->clk);
+	if (ret)
+		goto disable_icc;
+
+	ret = qcom_tbu_halt(tbu, smmu_domain);
+	if (ret)
+		goto disable_clk;
+
+	/*
+	 * ATOS/ECATS can trigger the fault interrupt, so disable it temporarily
+	 * and check for an interrupt manually.
+	 */
+	sctlr_orig = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_SCTLR);
+	sctlr = sctlr_orig & ~(ARM_SMMU_SCTLR_CFCFG | ARM_SMMU_SCTLR_CFIE);
+	arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_SCTLR, sctlr);
+
+	fsr = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSR);
+	if (fsr & ARM_SMMU_FSR_FAULT) {
+		/* Clear pending interrupts */
+		arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_FSR, fsr);
+
+		/*
+		 * TBU halt takes care of resuming any stalled transcation.
+		 * Kept it here for completeness sake.
+		 */
+		if (fsr & ARM_SMMU_FSR_SS)
+			arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_RESUME,
+					  ARM_SMMU_RESUME_TERMINATE);
+	}
+
+	/* Only one concurrent atos operation */
+	spin_lock_irqsave(&atos_lock, flags);
+
+	/*
+	 * If the translation fails, attempt the lookup more time."
+	 */
+	do {
+		phys = qcom_tbu_trigger_atos(smmu_domain, tbu, iova, sid);
+
+		fsr = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSR);
+		if (fsr & ARM_SMMU_FSR_FAULT) {
+			/* Clear pending interrupts */
+			arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_FSR, fsr);
+
+			if (fsr & ARM_SMMU_FSR_SS)
+				arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_RESUME,
+						  ARM_SMMU_RESUME_TERMINATE);
+		}
+	} while (!phys && attempt++ < 2);
+
+	arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_SCTLR, sctlr_orig);
+	spin_unlock_irqrestore(&atos_lock, flags);
+	qcom_tbu_resume(tbu);
+
+	/* Read to complete prior write transcations */
+	readl_relaxed(tbu->base + DEBUG_SR_HALT_ACK_REG);
+
+disable_clk:
+	clk_disable_unprepare(tbu->clk);
+disable_icc:
+	icc_set_bw(tbu->path, 0, 0);
+
+	return phys;
+}
+
+static int qcom_tbu_probe(struct platform_device *pdev)
+{
+	struct of_phandle_args args = { .args_count = 2 };
+	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct qcom_tbu *tbu;
+
+	tbu = devm_kzalloc(dev, sizeof(*tbu), GFP_KERNEL);
+	if (!tbu)
+		return -ENOMEM;
+
+	tbu->dev = dev;
+	INIT_LIST_HEAD(&tbu->list);
+	spin_lock_init(&tbu->halt_lock);
+
+	if (of_parse_phandle_with_args(np, "qcom,stream-id-range", "#iommu-cells", 0, &args)) {
+		dev_err(dev, "Cannot parse the 'qcom,stream-id-range' DT property\n");
+		return -EINVAL;
+	}
+
+	tbu->smmu_np =  args.np;
+	tbu->sid_range[0] = args.args[0];
+	tbu->sid_range[1] = args.args[1];
+	of_node_put(args.np);
+
+	tbu->base = devm_of_iomap(dev, np, 0, NULL);
+	if (IS_ERR(tbu->base))
+		return PTR_ERR(tbu->base);
+
+	tbu->clk = devm_clk_get_optional(dev, NULL);
+	if (IS_ERR(tbu->clk))
+		return PTR_ERR(tbu->clk);
+
+	tbu->path = devm_of_icc_get(dev, NULL);
+	if (IS_ERR(tbu->path))
+		return PTR_ERR(tbu->path);
+
+	mutex_lock(&tbu_list_lock);
+	list_add_tail(&tbu->list, &tbu_list);
+	mutex_unlock(&tbu_list_lock);
+
+	return 0;
+}
+
+static const struct of_device_id qcom_tbu_of_match[] = {
+	{ .compatible = "qcom,sc7280-tbu" },
+	{ .compatible = "qcom,sdm845-tbu" },
+	{ }
+};
+
+static struct platform_driver qcom_tbu_driver = {
+	.driver = {
+		.name           = "qcom_tbu",
+		.of_match_table = qcom_tbu_of_match,
+	},
+	.probe = qcom_tbu_probe,
+};
+builtin_platform_driver(qcom_tbu_driver);
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
index 593910567b88..9bb3ae7d62da 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
@@ -30,6 +30,8 @@ struct qcom_smmu_match_data {
 	const struct arm_smmu_impl *adreno_impl;
 };
 
+irqreturn_t qcom_smmu_context_fault(int irq, void *dev);
+
 #ifdef CONFIG_ARM_SMMU_QCOM_DEBUG
 void qcom_smmu_tlb_sync_debug(struct arm_smmu_device *smmu);
 #else
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index 836ed6799a80..1670e95c4637 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -136,6 +136,7 @@ enum arm_smmu_cbar_type {
 #define ARM_SMMU_CBAR_VMID		GENMASK(7, 0)
 
 #define ARM_SMMU_GR1_CBFRSYNRA(n)	(0x400 + ((n) << 2))
+#define ARM_SMMU_CBFRSYNRA_SID		GENMASK(15, 0)
 
 #define ARM_SMMU_GR1_CBA2R(n)		(0x800 + ((n) << 2))
 #define ARM_SMMU_CBA2R_VMID16		GENMASK(31, 16)
@@ -238,6 +239,7 @@ enum arm_smmu_cbar_type {
 #define ARM_SMMU_CB_ATSR		0x8f0
 #define ARM_SMMU_ATSR_ACTIVE		BIT(0)
 
+#define ARM_SMMU_RESUME_TERMINATE	BIT(0)
 
 /* Maximum number of context banks per SMMU */
 #define ARM_SMMU_MAX_CBS		128

