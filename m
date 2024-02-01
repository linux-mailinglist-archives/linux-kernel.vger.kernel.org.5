Return-Path: <linux-kernel+bounces-48849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C873846259
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CB001F26E60
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EDF3FB09;
	Thu,  1 Feb 2024 21:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gY/mKMc9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9589D33CD2;
	Thu,  1 Feb 2024 21:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706821561; cv=none; b=Z6KSIVYHHpm/SNKXoSUGI+enugj5Ojvz82iNPpAjl64ZrlWqwq9OyQhJOcoIAxmMz3h8N+8b5w6b6v4tJHbtkkQLpQKxzSV0eqHqj52aQtQeu3yUMwCPviet9mJK1bjiGyrjCc3k5mIFmKnTYHKbTIk7dYs3QRY2PkQK0lMsmhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706821561; c=relaxed/simple;
	bh=sUqRfACCU/sVwZ7yYzdneolLPxSfqgvsYCKlsDph55w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oLl5yIOlFS/VCyZB67fwimvz2i4kuIkjcePSGNxq/+UjSKeeEpkQE+xAtiGgU63EF8OG9jraRorApiJuaI859WlluwpY8eQQvtAeyHUXFUQ/Fdo9UK4NCmBrWXYD89sm8lqgFSh+HkORgC19GcnmOcQivkRLzKc5dFWv2N2CxL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gY/mKMc9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 411KOn7G001896;
	Thu, 1 Feb 2024 21:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=PlD7IpCrzd0gete90gvN
	+H9fWqfgYW82BbKGi0OHMvo=; b=gY/mKMc93ms/4a8SI5gPyoiTrySlf/DQ59Ac
	Q37gYGaDX25ae/bSyRVszerDJ3kPnWF0AwggSBPVCziJ+Qr020FR/5KUkblHl/UN
	YOGVm+rq2aemV4E/ZOGmnZagEtdhFttNyNmGlVG5NQ8E3MJKivRHyhh5VTKIOK2j
	F26MtfdcOiybOHSAeHeUSc5Plg7o5cr40+0X+J/ZyQ6PyTIl1yeKWErPBs/IdvO7
	jCq43Ljj4Ax0PwzyA+TFylu0UZz8h9CB359wqYBPeGsZZYdsKR/A68t+njbIzsQ8
	JsCcGHkJf2HGX4APw+nF+v6hLEcwhYtvKdOwPW7/PkS5InnP+A==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w098c1fa8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 21:05:42 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 411L5fx6028661
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Feb 2024 21:05:41 GMT
Received: from hu-c-gdjako-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 1 Feb 2024 13:05:41 -0800
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
Subject: [PATCH v4 04/10] iommu/arm-smmu-qcom-tbu: Add Qualcomm TBU driver
Date: Thu, 1 Feb 2024 13:05:23 -0800
Message-ID: <20240201210529.7728-5-quic_c_gdjako@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240201210529.7728-1-quic_c_gdjako@quicinc.com>
References: <20240201210529.7728-1-quic_c_gdjako@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: QLxL-upi7hFJuy0fyzRUKRj_sPoNmQME
X-Proofpoint-GUID: QLxL-upi7hFJuy0fyzRUKRj_sPoNmQME
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_06,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 phishscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 malwarescore=0 mlxlogscore=839
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2402010163

Add a driver for the Qualcomm implementation of the MMU-500 TBU.

Operating the TBUs (Translation Buffer Units) from Linux can help
with debugging context faults. The TBUs can provide debug features
such as running ATOS (Address Translation Operations) to manually
trigger address translation of IOVA to physical address in hardware.

The driver will control the resources needed by the TBU to allow
running ATOS on the TBUs or check for outstanding transactions.

Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
---
 drivers/iommu/Kconfig                         |   8 +
 drivers/iommu/arm/arm-smmu/Makefile           |   1 +
 .../iommu/arm/arm-smmu/arm-smmu-qcom-tbu.c    | 366 ++++++++++++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h    |   2 +
 drivers/iommu/arm/arm-smmu/arm-smmu.h         |   2 +
 5 files changed, 379 insertions(+)
 create mode 100644 drivers/iommu/arm/arm-smmu/arm-smmu-qcom-tbu.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 9a29d742617e..314dc5dbe7ea 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -371,6 +371,14 @@ config ARM_SMMU_QCOM
 	  When running on a Qualcomm platform that has the custom variant
 	  of the ARM SMMU, this needs to be built into the SMMU driver.
 
+config ARM_SMMU_QCOM_TBU
+	bool "Qualcomm TBU driver"
+	depends on ARM_SMMU_QCOM
+	help
+	  The SMMU on Qualcomm platform may include a Translation Buffer
+	  Units (TBUs) for each master. Enabling support for these will
+	  allow operating the TBUs to help debugging context faults.
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
index 000000000000..c00f89f223bd
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
+struct qsmmuv500_tbu {
+	struct device *dev;
+	struct arm_smmu_device *smmu;
+	u32 sid_range[2];
+	struct list_head list;
+	struct clk *clk;
+	struct icc_path	*path;
+	void __iomem *base;
+	spinlock_t halt_lock; /* multiple halt or resume can't execute concurrently */
+	int halt_count;
+};
+
+static DEFINE_SPINLOCK(atos_lock);
+
+static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
+{
+	return container_of(smmu, struct qcom_smmu, smmu);
+}
+
+static struct qsmmuv500_tbu *qsmmuv500_find_tbu(struct qcom_smmu *qsmmu, u32 sid)
+{
+	struct qsmmuv500_tbu *tbu = NULL;
+	u32 start, end;
+
+	mutex_lock(&qsmmu->tbu_list_lock);
+
+	list_for_each_entry(tbu, &qsmmu->tbu_list, list) {
+		start = tbu->sid_range[0];
+		end = start + tbu->sid_range[1];
+
+		if (start <= sid && sid < end)
+			break;
+	}
+
+	mutex_unlock(&qsmmu->tbu_list_lock);
+
+	return tbu;
+}
+
+static int qsmmuv500_tbu_halt(struct qsmmuv500_tbu *tbu, struct arm_smmu_domain *smmu_domain)
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
+static void qsmmuv500_tbu_resume(struct qsmmuv500_tbu *tbu)
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
+static phys_addr_t qsmmuv500_tbu_trigger_atos(struct arm_smmu_domain *smmu_domain,
+					      struct qsmmuv500_tbu *tbu, dma_addr_t iova, u32 sid)
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
+static phys_addr_t qsmmuv500_iova_to_phys(struct arm_smmu_domain *smmu_domain,
+					  dma_addr_t iova, u32 sid)
+{
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
+	int idx = smmu_domain->cfg.cbndx;
+	struct qsmmuv500_tbu *tbu;
+	u32 sctlr_orig, sctlr;
+	phys_addr_t phys = 0;
+	unsigned long flags;
+	int attempt = 0;
+	int ret;
+	u64 fsr;
+
+	tbu = qsmmuv500_find_tbu(qsmmu, sid);
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
+	ret = qsmmuv500_tbu_halt(tbu, smmu_domain);
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
+		phys = qsmmuv500_tbu_trigger_atos(smmu_domain, tbu, iova, sid);
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
+	qsmmuv500_tbu_resume(tbu);
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
+static int qsmmuv500_tbu_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct arm_smmu_device *smmu;
+	struct qsmmuv500_tbu *tbu;
+	struct qcom_smmu *qsmmu;
+	int ret;
+
+	smmu = dev_get_drvdata(dev->parent);
+	if (!smmu)
+		return -EPROBE_DEFER;
+
+	qsmmu = to_qcom_smmu(smmu);
+
+	tbu = devm_kzalloc(dev, sizeof(*tbu), GFP_KERNEL);
+	if (!tbu)
+		return -ENOMEM;
+
+	tbu->dev = dev;
+	INIT_LIST_HEAD(&tbu->list);
+	spin_lock_init(&tbu->halt_lock);
+
+	tbu->base = devm_of_iomap(dev, np, 0, NULL);
+	if (IS_ERR(tbu->base))
+		return PTR_ERR(tbu->base);
+
+	ret = of_property_read_u32_array(np, "stream-id-range", tbu->sid_range, 2);
+	if (ret) {
+		dev_err(dev, "The DT property 'stream-id-range' is mandatory\n");
+		return ret;
+	}
+
+	tbu->clk = devm_clk_get_optional(dev, NULL);
+	if (IS_ERR(tbu->clk))
+		return PTR_ERR(tbu->clk);
+
+	tbu->path = devm_of_icc_get(dev, NULL);
+	if (IS_ERR(tbu->path))
+		return PTR_ERR(tbu->path);
+
+	mutex_lock(&qsmmu->tbu_list_lock);
+	list_add_tail(&tbu->list, &qsmmu->tbu_list);
+	mutex_unlock(&qsmmu->tbu_list_lock);
+
+	dev_set_drvdata(dev, tbu);
+
+	return 0;
+}
+
+static const struct of_device_id qsmmuv500_tbu_of_match[] = {
+	{ .compatible = "qcom,qsmmuv500-tbu" },
+	{ }
+};
+
+static struct platform_driver qsmmuv500_tbu_driver = {
+	.driver = {
+		.name           = "qsmmuv500-tbu",
+		.of_match_table = qsmmuv500_tbu_of_match,
+	},
+	.probe = qsmmuv500_tbu_probe,
+};
+builtin_platform_driver(qsmmuv500_tbu_driver);
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
index 77e5becc2482..528c9a8a7568 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
@@ -32,6 +32,8 @@ struct qcom_smmu_match_data {
 	const struct arm_smmu_impl *adreno_impl;
 };
 
+irqreturn_t qcom_smmu_context_fault(int irq, void *dev);
+
 #ifdef CONFIG_ARM_SMMU_QCOM_DEBUG
 void qcom_smmu_tlb_sync_debug(struct arm_smmu_device *smmu);
 #else
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index d375e910b52c..17f704920190 100644
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

