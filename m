Return-Path: <linux-kernel+bounces-35472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 047338391AC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6B5528A784
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2812E5FDDE;
	Tue, 23 Jan 2024 14:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JdyVPO2e"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BB45FDD4;
	Tue, 23 Jan 2024 14:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706021208; cv=none; b=OicK4w2p1xroCn+EJ3Gguih3HgKpkC6A6ejmF86WJlZ6lDLuW8ZLPZXZmwkAGb2Ux0B06FC2Y9AbBD2LPA8oLaISC6qiFRzEEdRPiapOBXZ+EMwAuVgW+xfUQgQfCuAcZOesOLfArtJRjoWeCVcjU0/vBZczfPzUtZG24S606b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706021208; c=relaxed/simple;
	bh=E0Ny0SESv2K/jz5tdLet34cpK9Kz6ZqFDoEs1ffpZ1U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dI6S4ia9X+yXoHEQXuKhETLCmYkBC/qd07dOl9MDDGcttmNBGdcsrZW8FFR9jCZOdjYxZKTK+QcJ/xN1werXWMQW3xWcDzrQSFvzoYJYNL2yCSkBiBa1eoiocTtqiesTEDC5AvgO+lY+4rPHStR4zQfKHGA9lGJeKv4Y0qqo9HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JdyVPO2e; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40N6kkkb025950;
	Tue, 23 Jan 2024 14:46:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=SIzPrUsNSPZsfCiYgGP7
	SErqXgSNyKrKCr5RR2xdKRI=; b=JdyVPO2eEaGUv/3aKhbYpH8Pn5H80txAtIrB
	Zq+Nw/Oamar5tvHRGXkrT7cHfu0W7SmD8KvjdjT4QWwte88AcpLRazzjQKPQF/b/
	sqwdIve0AZ1J7LLJLwK/7uMghmw2Gp7d8ZGilmtBJsg6bRrbdmWhxm+611hg2u9c
	7r4r5KgaZPSMjkwPHN7XeUZv7w5/hWQ1ovjD9L5hXs9vqicbzrg9DFwACQHabBj6
	14PhanguMJOq5HOk1BP1HPpnUdLL+EHHn3GP37GgM45rab2aU/vPWotZOBCZN1FX
	BLBa0j8ajdfkZhPN2V8amVYlRXEnvvCyRJPeE5lzjDJWl4RC5w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vt06mj3xm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 14:46:29 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40NEkSwE014902
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 14:46:28 GMT
Received: from hu-bibekkum-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 23 Jan 2024 06:46:22 -0800
From: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <dmitry.baryshkov@linaro.org>, <konrad.dybcio@linaro.org>,
        <jsnitsel@redhat.com>, <quic_bjorande@quicinc.com>, <mani@kernel.org>,
        <quic_eberman@quicinc.com>, <robdclark@chromium.org>,
        <u.kleine-koenig@pengutronix.de>, <robh@kernel.org>,
        <vladimir.oltean@nxp.com>, <quic_pkondeti@quicinc.com>,
        <quic_molvera@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        Bibek Kumar Patro
	<quic_bibekkum@quicinc.com>
Subject: [PATCH v9 3/5] iommu/arm-smmu: introduction of ACTLR for custom prefetcher settings
Date: Tue, 23 Jan 2024 20:15:41 +0530
Message-ID: <20240123144543.9405-4-quic_bibekkum@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240123144543.9405-1-quic_bibekkum@quicinc.com>
References: <20240123144543.9405-1-quic_bibekkum@quicinc.com>
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
X-Proofpoint-GUID: 2Qg6IAHnYPAGJObQQSjcHUhinUf9OLic
X-Proofpoint-ORIG-GUID: 2Qg6IAHnYPAGJObQQSjcHUhinUf9OLic
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_06,2024-01-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401230106

Currently in Qualcomm  SoCs the default prefetch is set to 1 which allows
the TLB to fetch just the next page table. MMU-500 features ACTLR
register which is implementation defined and is used for Qualcomm SoCs
to have a custom prefetch setting enabling TLB to prefetch the next set
of page tables accordingly allowing for faster translations.

ACTLR value is unique for each SMR (Stream matching register) and stored
in a pre-populated table. This value is set to the register during
context bank initialisation.

Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 61 ++++++++++++++++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h | 16 +++++-
 drivers/iommu/arm/arm-smmu/arm-smmu.c      |  5 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.h      |  5 ++
 4 files changed, 84 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 333daeb18c1c..6004c6d9a7b2 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -215,10 +215,42 @@ static bool qcom_adreno_can_do_ttbr1(struct arm_smmu_device *smmu)
 	return true;
 }

+static void qcom_smmu_set_actlr(struct device *dev, struct arm_smmu_device *smmu, int cbndx,
+		const struct actlr_config *actlrcfg, const size_t num_actlrcfg)
+{
+	struct arm_smmu_master_cfg *cfg = dev_iommu_priv_get(dev);
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct arm_smmu_smr *smr;
+	u16 mask;
+	int idx;
+	u16 id;
+	int i;
+	int j;
+
+	for (i = 0; i < num_actlrcfg; i++) {
+		id = actlrcfg[i].sid;
+		mask = actlrcfg[i].mask;
+
+		for_each_cfg_sme(cfg, fwspec, j, idx) {
+			smr = &smmu->smrs[idx];
+			if (smr_is_subset(smr, id, mask)) {
+				arm_smmu_cb_write(smmu, cbndx, ARM_SMMU_CB_ACTLR,
+						actlrcfg[i].actlr);
+				break;
+			}
+		}
+	}
+}
+
 static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
 		struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
 {
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
+	const struct actlr_variant *actlrvar;
+	int cbndx = smmu_domain->cfg.cbndx;
 	struct adreno_smmu_priv *priv;
+	int i;

 	smmu_domain->cfg.flush_walk_prefer_tlbiasid = true;

@@ -248,6 +280,18 @@ static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
 	priv->set_stall = qcom_adreno_smmu_set_stall;
 	priv->resume_translation = qcom_adreno_smmu_resume_translation;

+	actlrvar = qsmmu->data->actlrvar;
+	if (!actlrvar)
+		return 0;
+
+	for (i = 0; i < qsmmu->data->num_smmu ; i++) {
+		if (actlrvar[i].io_start == smmu->ioaddr) {
+			qcom_smmu_set_actlr(dev, smmu, cbndx, actlrvar[i].actlrcfg,
+				       actlrvar[i].num_actlrcfg);
+			break;
+		}
+	}
+
 	return 0;
 }

@@ -274,7 +318,24 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
 		struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
 {
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
+	const struct actlr_variant *actlrvar;
+	int cbndx = smmu_domain->cfg.cbndx;
+	int i;
+
 	smmu_domain->cfg.flush_walk_prefer_tlbiasid = true;
+	actlrvar = qsmmu->data->actlrvar;
+	if (!actlrvar)
+		return 0;
+
+	for (i = 0; i < qsmmu->data->num_smmu ; i++) {
+		if (actlrvar[i].io_start == smmu->ioaddr) {
+			qcom_smmu_set_actlr(dev, smmu, cbndx, actlrvar[i].actlrcfg,
+				       actlrvar[i].num_actlrcfg);
+			break;
+		}
+	}

 	return 0;
 }
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
index f3b91963e234..3f651242de7c 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2022-2023, Qualcomm Innovation Center, Inc. All rights reserved.
  */

 #ifndef _ARM_SMMU_QCOM_H
@@ -24,8 +24,22 @@ struct qcom_smmu_config {
 	const u32 *reg_offset;
 };

+struct actlr_config {
+	u16 sid;
+	u16 mask;
+	u32 actlr;
+};
+
+struct actlr_variant {
+	const resource_size_t io_start;
+	const struct actlr_config * const actlrcfg;
+	const size_t num_actlrcfg;
+};
+
 struct qcom_smmu_match_data {
+	const struct actlr_variant * const actlrvar;
 	const struct qcom_smmu_config *cfg;
+	const size_t num_smmu;
 	const struct arm_smmu_impl *impl;
 	const struct arm_smmu_impl *adreno_impl;
 };
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index d6d1a2a55cc0..0c7f700b27dd 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -990,9 +990,10 @@ static int arm_smmu_find_sme(struct arm_smmu_device *smmu, u16 id, u16 mask)
 		 * expect simply identical entries for this case, but there's
 		 * no harm in accommodating the generalisation.
 		 */
-		if ((mask & smrs[i].mask) == mask &&
-		    !((id ^ smrs[i].id) & ~smrs[i].mask))
+
+		if (smr_is_subset(&smrs[i], id, mask))
 			return i;
+
 		/*
 		 * If the new entry has any other overlap with an existing one,
 		 * though, then there always exists at least one stream ID
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index 703fd5817ec1..2e4f65412c6b 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -501,6 +501,11 @@ static inline void arm_smmu_writeq(struct arm_smmu_device *smmu, int page,
 		writeq_relaxed(val, arm_smmu_page(smmu, page) + offset);
 }

+static inline bool smr_is_subset(struct arm_smmu_smr *smrs, u16 id, u16 mask)
+{
+	return (mask & smrs->mask) == mask && !((id ^ smrs->id) & ~smrs->mask);
+}
+
 #define ARM_SMMU_GR0		0
 #define ARM_SMMU_GR1		1
 #define ARM_SMMU_CB(s, n)	((s)->numpage + (n))
--
2.17.1


