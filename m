Return-Path: <linux-kernel+bounces-158719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CA18B2423
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40FB2288050
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C08E14A0A0;
	Thu, 25 Apr 2024 14:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="SNfVupiL"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A6D149C41
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714055496; cv=none; b=Mr87lnYODzmlC7kA0yxxaBtw2l6pB9HP4bwp0oQMckkfe4V9w04SG4ZbsRDiiuncZVUryyewropuVciPFPponcQzsPnznZVXh4Z9C48jHCF6ZkuzDlQ0dc6RPKVeFSYJjyuP2DkSQkg3s71Z75EBDEMIDmYHfVK105B7DUeahAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714055496; c=relaxed/simple;
	bh=sjedEuS2v7BXajhJ/g+/tRtZZIameKeLpYVYXqMP2pE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z8j9nPJEEVRK1tfq8LrGkk/oWUNjxWkHCboDu70slATTN/veqc1ko1RNY2e8U5gQYBviVep+cG9kGTrhNLc6ZqTeMgQInU8rTQqW1rdTsSzz8K8VYfxc+rchkobb/UC0Ur9y8/ixWMn11w0i+hI2S3KxMgkRXL/0Eo4AGWoKoGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=SNfVupiL; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P8MXoL011467;
	Thu, 25 Apr 2024 07:30:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=ekkaLXxx
	lwh8xLUqlTrlwkSaQU4fhTmytSQGex+D3fI=; b=SNfVupiLJ19KVm8zvTLq6EDE
	8r333vf/rCNxKER8/OJyjdB0NqGCt9uJHzDPKBskLGYBh3D+rtUSzUZAOYrW2SF6
	V6d6dNOmT01qRLfXenLT615qJp3Rhx6KgsZ2Jd9A0Sk5cx1NAXb8AKAS83twVpG0
	tHjRO1vNEtCFwPSblARHQgO5oced8GIPev2oQNwwu+YFdL/yx+r3FmvZ4T7btyLi
	m7DYUY0+MWPRwhy3HgUeabpncuvc2PDthPuHP8A8A3qadoc0/IzLep9N10G/7BWA
	eIUKYjil/NlfS3v5SlXKHFjpYICqLYCy0BdMA3EpgHXf8xiUuYzHyesTuTkFLg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xpxn1gfkm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 07:30:58 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 25 Apr 2024 07:30:56 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 25 Apr 2024 07:30:56 -0700
Received: from cn10ka.sclab.marvell.com (unknown [10.106.49.40])
	by maili.marvell.com (Postfix) with ESMTP id 3F0AB3F704A;
	Thu, 25 Apr 2024 07:30:56 -0700 (PDT)
From: Tanmay Jagdale <tanmay@marvell.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <nicolinc@nvidia.com>, <mshavit@google.com>,
        <baolu.lu@linux.intel.com>, <thunder.leizhen@huawei.com>,
        <set_pte_at@outlook.com>, <smostafa@google.com>
CC: <sgoutham@marvell.com>, <gcherian@marvell.com>, <jcm@jonmasters.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, Tanmay Jagdale <tanmay@marvell.com>
Subject: [PATCH V3 1/2] iommu/arm-smmu-v3: Add support for ECMDQ register mode
Date: Thu, 25 Apr 2024 07:30:53 -0700
Message-ID: <20240425143053.52305-1-tanmay@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: VFXFUKtj7kR5LJwUtMTdP5yjAoiP5pUj
X-Proofpoint-ORIG-GUID: VFXFUKtj7kR5LJwUtMTdP5yjAoiP5pUj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_14,2024-04-25_01,2023-05-22_02

From: Zhen Lei <thunder.leizhen@huawei.com>

Ensure that each core exclusively occupies an ECMDQ and all of them are
enabled during initialization. During this initialization process, any
errors will result in a fallback to using normal CMDQ.

When GERROR is triggered by ECMDQ, all ECMDQs need to be traversed: the
ECMDQs with errors will be processed and the ECMDQs without errors will
be skipped directly. Compared with register SMMU_CMDQ_PROD, register
SMMU_ECMDQ_PROD has one more 'EN' bit and one more 'ERRACK' bit. After
the error indicated by SMMU_GERROR.CMDQP_ERR is fixed, the 'ERRACK'
bit needs to be toggled to resume the corresponding ECMDQ. In order to
lockless protection against the write operation to bit 'ERRACK' during
error handling and the read operation to bit 'ERRACK' during command
insertion. Send IPI to the faulty CPU and perform the toggle operation
on the faulty CPU. Because the command insertion is protected by
local_irq_save(), so no race.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 219 +++++++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  33 +++
 2 files changed, 251 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 41f93c3ab160..8e088ca4e8e1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -352,6 +352,14 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 
 static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu)
 {
+	if (smmu->ecmdq_enabled) {
+		struct arm_smmu_ecmdq *ecmdq;
+
+		ecmdq = *this_cpu_ptr(smmu->ecmdqs);
+
+		return &ecmdq->cmdq;
+	}
+
 	return &smmu->cmdq;
 }
 
@@ -434,6 +442,43 @@ static void arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu)
 	__arm_smmu_cmdq_skip_err(smmu, &smmu->cmdq.q);
 }
 
+static void arm_smmu_ecmdq_err_ack(void *info)
+{
+	u32 prod, cons;
+	struct arm_smmu_queue *q = info;
+
+	prod = readl_relaxed(q->prod_reg);
+	cons = readl_relaxed(q->cons_reg);
+	prod &= ~ECMDQ_PROD_ERRACK;
+	prod |= cons & ECMDQ_CONS_ERR;
+	writel(prod, q->prod_reg);
+}
+
+static void arm_smmu_ecmdq_skip_err(struct arm_smmu_device *smmu)
+{
+	int i;
+	u32 prod, cons;
+	struct arm_smmu_queue *q;
+	struct arm_smmu_ecmdq *ecmdq;
+
+	if (!smmu->ecmdq_enabled)
+		return;
+
+	for (i = 0; i < smmu->nr_ecmdq; i++) {
+		ecmdq = *per_cpu_ptr(smmu->ecmdqs, i);
+		q = &ecmdq->cmdq.q;
+
+		prod = readl_relaxed(q->prod_reg);
+		cons = readl_relaxed(q->cons_reg);
+		if (((prod ^ cons) & ECMDQ_CONS_ERR) == 0)
+			continue;
+
+		__arm_smmu_cmdq_skip_err(smmu, q);
+
+		smp_call_function_single(i, arm_smmu_ecmdq_err_ack, q, true);
+	}
+}
+
 /*
  * Command queue locking.
  * This is a form of bastardised rwlock with the following major changes:
@@ -830,7 +875,10 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 		 * d. Advance the hardware prod pointer
 		 * Control dependency ordering from the entries becoming valid.
 		 */
-		writel_relaxed(prod, cmdq->q.prod_reg);
+		if (smmu->ecmdq_enabled)
+			writel_relaxed(prod | ECMDQ_PROD_EN, cmdq->q.prod_reg);
+		else
+			writel_relaxed(prod, cmdq->q.prod_reg);
 
 		/*
 		 * e. Tell the next owner we're done
@@ -1838,6 +1886,9 @@ static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
 	if (active & GERROR_CMDQ_ERR)
 		arm_smmu_cmdq_skip_err(smmu);
 
+	if (active & GERROR_CMDQP_ERR)
+		arm_smmu_ecmdq_skip_err(smmu);
+
 	writel(gerror, smmu->base + ARM_SMMU_GERRORN);
 	return IRQ_HANDLED;
 }
@@ -3154,6 +3205,20 @@ static int arm_smmu_cmdq_init(struct arm_smmu_device *smmu)
 	return 0;
 }
 
+static int arm_smmu_ecmdq_init(struct arm_smmu_cmdq *cmdq)
+{
+	unsigned int nents = 1 << cmdq->q.llq.max_n_shift;
+
+	atomic_set(&cmdq->owner_prod, 0);
+	atomic_set(&cmdq->lock, 0);
+
+	cmdq->valid_map = (atomic_long_t *)bitmap_zalloc(nents, GFP_KERNEL);
+	if (!cmdq->valid_map)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 {
 	int ret;
@@ -3503,6 +3568,36 @@ static int arm_smmu_device_disable(struct arm_smmu_device *smmu)
 	return ret;
 }
 
+static void arm_smmu_ecmdq_reset(struct arm_smmu_device *smmu)
+{
+	u32 reg;
+	int i, ret;
+	struct arm_smmu_queue *q;
+	struct arm_smmu_ecmdq *ecmdq;
+
+	if (!smmu->ecmdq_enabled)
+		return;
+
+	for (i = 0; i < smmu->nr_ecmdq; i++) {
+		ecmdq = *per_cpu_ptr(smmu->ecmdqs, i);
+
+		q = &ecmdq->cmdq.q;
+		writeq_relaxed(q->q_base, ecmdq->base + ARM_SMMU_ECMDQ_BASE);
+		writel_relaxed(q->llq.prod, ecmdq->base + ARM_SMMU_ECMDQ_PROD);
+		writel_relaxed(q->llq.cons, ecmdq->base + ARM_SMMU_ECMDQ_CONS);
+
+		/* enable ecmdq */
+		writel(ECMDQ_PROD_EN, q->prod_reg);
+		ret = readl_relaxed_poll_timeout(q->cons_reg, reg, reg & ECMDQ_CONS_ENACK,
+					  1, ARM_SMMU_POLL_TIMEOUT_US);
+		if (ret) {
+			dev_err(smmu->dev, "ecmdq[%d] enable failed\n", i);
+			smmu->ecmdq_enabled = false;
+			break;
+		}
+	}
+}
+
 static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 {
 	int ret;
@@ -3557,6 +3652,8 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 		return ret;
 	}
 
+	arm_smmu_ecmdq_reset(smmu);
+
 	/* Invalidate any cached configuration */
 	cmd.opcode = CMDQ_OP_CFGI_ALL;
 	arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
@@ -3674,6 +3771,112 @@ static void arm_smmu_device_iidr_probe(struct arm_smmu_device *smmu)
 		}
 		break;
 	}
+};
+
+static int arm_smmu_ecmdq_layout(struct arm_smmu_device *smmu)
+{
+	int cpu;
+	struct arm_smmu_ecmdq __percpu *ecmdq;
+
+	if (num_possible_cpus() <= smmu->nr_ecmdq) {
+		ecmdq = devm_alloc_percpu(smmu->dev, *ecmdq);
+		if (!ecmdq)
+			return -ENOMEM;
+
+		for_each_possible_cpu(cpu)
+			*per_cpu_ptr(smmu->ecmdqs, cpu) = per_cpu_ptr(ecmdq, cpu);
+
+		/* A core requires at most one ECMDQ */
+		smmu->nr_ecmdq = num_possible_cpus();
+
+		return 0;
+	}
+
+	return -ENOSPC;
+}
+
+static int arm_smmu_ecmdq_probe(struct arm_smmu_device *smmu)
+{
+	int ret, cpu;
+	u32 i, nump, numq, gap;
+	u32 reg, shift_increment;
+	u64 offset;
+	void __iomem *cp_regs, *cp_base;
+
+	/* IDR6 */
+	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR6);
+	nump = 1 << FIELD_GET(IDR6_LOG2NUMP, reg);
+	numq = 1 << FIELD_GET(IDR6_LOG2NUMQ, reg);
+	smmu->nr_ecmdq = nump * numq;
+	gap = ECMDQ_CP_RRESET_SIZE >> FIELD_GET(IDR6_LOG2NUMQ, reg);
+
+	cp_regs = ioremap(smmu->iobase + ARM_SMMU_ECMDQ_CP_BASE, PAGE_SIZE);
+	if (!cp_regs)
+		return -ENOMEM;
+
+	for (i = 0; i < nump; i++) {
+		u64 val, pre_addr = 0;
+
+		val = readq_relaxed(cp_regs + 32 * i);
+		if (!(val & ECMDQ_CP_PRESET)) {
+			iounmap(cp_regs);
+			dev_err(smmu->dev, "ecmdq control page %u is memory mode\n", i);
+			return -EFAULT;
+		}
+
+		if (i && ((val & ECMDQ_CP_ADDR) != (pre_addr + ECMDQ_CP_RRESET_SIZE))) {
+			iounmap(cp_regs);
+			dev_err(smmu->dev, "ecmdq_cp memory region is not contiguous\n");
+			return -EFAULT;
+		}
+
+		pre_addr = val & ECMDQ_CP_ADDR;
+	}
+
+	offset = readl_relaxed(cp_regs) & ECMDQ_CP_ADDR;
+	iounmap(cp_regs);
+
+	cp_base = devm_ioremap(smmu->dev, smmu->iobase + offset, ECMDQ_CP_RRESET_SIZE * nump);
+	if (!cp_base)
+		return -ENOMEM;
+
+	smmu->ecmdqs = devm_alloc_percpu(smmu->dev, struct arm_smmu_ecmdq *);
+	if (!smmu->ecmdqs)
+		return -ENOMEM;
+
+	ret = arm_smmu_ecmdq_layout(smmu);
+	if (ret)
+		return ret;
+
+	shift_increment = order_base_2(num_possible_cpus() / smmu->nr_ecmdq);
+
+	offset = 0;
+	for_each_possible_cpu(cpu) {
+		struct arm_smmu_ecmdq *ecmdq;
+		struct arm_smmu_queue *q;
+
+		ecmdq = *per_cpu_ptr(smmu->ecmdqs, cpu);
+		ecmdq->base = cp_base + offset;
+
+		q = &ecmdq->cmdq.q;
+
+		q->llq.max_n_shift = ECMDQ_MAX_SZ_SHIFT + shift_increment;
+		ret = arm_smmu_init_one_queue(smmu, q, ecmdq->base, ARM_SMMU_ECMDQ_PROD,
+				ARM_SMMU_ECMDQ_CONS, CMDQ_ENT_DWORDS, "ecmdq");
+		if (ret)
+			return ret;
+
+		ret = arm_smmu_ecmdq_init(&ecmdq->cmdq);
+		if (ret) {
+			dev_err(smmu->dev, "ecmdq[%d] init failed\n", i);
+			return ret;
+		}
+
+		offset += gap;
+	}
+	smmu->ecmdq_enabled = true;
+
+	return 0;
 }
 
 static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
@@ -3789,6 +3992,9 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 	if (reg & IDR1_ATTR_TYPES_OVR)
 		smmu->features |= ARM_SMMU_FEAT_ATTR_TYPES_OVR;
 
+	if (reg & IDR1_ECMDQ)
+		smmu->features |= ARM_SMMU_FEAT_ECMDQ;
+
 	/* Queue sizes, capped to ensure natural alignment */
 	smmu->cmdq.q.llq.max_n_shift = min_t(u32, CMDQ_MAX_SZ_SHIFT,
 					     FIELD_GET(IDR1_CMDQS, reg));
@@ -3896,6 +4102,16 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 
 	dev_info(smmu->dev, "ias %lu-bit, oas %lu-bit (features 0x%08x)\n",
 		 smmu->ias, smmu->oas, smmu->features);
+
+	if (smmu->features & ARM_SMMU_FEAT_ECMDQ) {
+		int err;
+
+		err = arm_smmu_ecmdq_probe(smmu);
+		if (err) {
+			dev_err(smmu->dev, "suppress ecmdq feature, errno=%d\n", err);
+			smmu->ecmdq_enabled = false;
+		}
+	}
 	return 0;
 }
 
@@ -4054,6 +4270,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	smmu->base = arm_smmu_ioremap(dev, ioaddr, ARM_SMMU_REG_SZ);
 	if (IS_ERR(smmu->base))
 		return PTR_ERR(smmu->base);
+	smmu->iobase = ioaddr;
 
 	if (arm_smmu_resource_size(smmu) > SZ_64K) {
 		smmu->page1 = arm_smmu_ioremap(dev, ioaddr + SZ_64K,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 2a19bb63e5c6..335b9f975d74 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -41,6 +41,7 @@
 #define IDR0_S2P			(1 << 0)
 
 #define ARM_SMMU_IDR1			0x4
+#define IDR1_ECMDQ			(1 << 31)
 #define IDR1_TABLES_PRESET		(1 << 30)
 #define IDR1_QUEUES_PRESET		(1 << 29)
 #define IDR1_REL			(1 << 28)
@@ -114,6 +115,7 @@
 #define ARM_SMMU_IRQ_CTRLACK		0x54
 
 #define ARM_SMMU_GERROR			0x60
+#define GERROR_CMDQP_ERR		(1 << 9)
 #define GERROR_SFM_ERR			(1 << 8)
 #define GERROR_MSI_GERROR_ABT_ERR	(1 << 7)
 #define GERROR_MSI_PRIQ_ABT_ERR		(1 << 6)
@@ -159,6 +161,26 @@
 #define ARM_SMMU_PRIQ_IRQ_CFG1		0xd8
 #define ARM_SMMU_PRIQ_IRQ_CFG2		0xdc
 
+#define ARM_SMMU_IDR6			0x190
+#define IDR6_LOG2NUMP			GENMASK(27, 24)
+#define IDR6_LOG2NUMQ			GENMASK(19, 16)
+#define IDR6_BA_DOORBELLS		GENMASK(9, 0)
+
+#define ARM_SMMU_ECMDQ_BASE		0x00
+#define ARM_SMMU_ECMDQ_PROD		0x08
+#define ARM_SMMU_ECMDQ_CONS		0x0c
+#define ECMDQ_MAX_SZ_SHIFT		8
+#define ECMDQ_PROD_EN			(1 << 31)
+#define ECMDQ_CONS_ENACK		(1 << 31)
+#define ECMDQ_CONS_ERR			(1 << 23)
+#define ECMDQ_PROD_ERRACK		(1 << 23)
+
+#define ARM_SMMU_ECMDQ_CP_BASE		0x4000
+#define ECMDQ_CP_ADDR			GENMASK_ULL(51, 12)
+#define ECMDQ_CP_CMDQGS			GENMASK_ULL(2, 1)
+#define ECMDQ_CP_PRESET			(1UL << 0)
+#define ECMDQ_CP_RRESET_SIZE		0x10000
+
 #define ARM_SMMU_REG_SZ			0xe00
 
 /* Common MSI config fields */
@@ -558,6 +580,11 @@ struct arm_smmu_cmdq {
 	atomic_t			lock;
 };
 
+struct arm_smmu_ecmdq {
+	struct arm_smmu_cmdq		cmdq;
+	void __iomem			*base;
+};
+
 struct arm_smmu_cmdq_batch {
 	u64				cmds[CMDQ_BATCH_ENTRIES * CMDQ_ENT_DWORDS];
 	int				num;
@@ -627,6 +654,7 @@ struct arm_smmu_device {
 	struct device			*dev;
 	void __iomem			*base;
 	void __iomem			*page1;
+	phys_addr_t			iobase;
 
 #define ARM_SMMU_FEAT_2_LVL_STRTAB	(1 << 0)
 #define ARM_SMMU_FEAT_2_LVL_CDTAB	(1 << 1)
@@ -649,6 +677,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_E2H		(1 << 18)
 #define ARM_SMMU_FEAT_NESTING		(1 << 19)
 #define ARM_SMMU_FEAT_ATTR_TYPES_OVR	(1 << 20)
+#define ARM_SMMU_FEAT_ECMDQ		(1 << 21)
 	u32				features;
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
@@ -657,6 +686,10 @@ struct arm_smmu_device {
 #define ARM_SMMU_OPT_CMDQ_FORCE_SYNC	(1 << 3)
 	u32				options;
 
+	struct arm_smmu_ecmdq *__percpu	*ecmdqs;
+	u32				nr_ecmdq;
+	bool				ecmdq_enabled;
+
 	struct arm_smmu_cmdq		cmdq;
 	struct arm_smmu_evtq		evtq;
 	struct arm_smmu_priq		priq;
-- 
2.34.1


