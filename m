Return-Path: <linux-kernel+bounces-67626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF5E856E2B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F7B91C22F9F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34115145345;
	Thu, 15 Feb 2024 19:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NeN8419m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HSu3W5Zi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E8B13B29C;
	Thu, 15 Feb 2024 19:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708027026; cv=none; b=rqV9txaI8j5dE4zXP5zbmp9TkBuxx0aG4AklqC1eUYoNBHYi5ELNv9RX02W4urW50xMzfqqqqTHGWOpMf79p2SvBVjPrCAZRKc/JyNZXuzj0EnF3ZSZhe8UghO8qKSQf0TKY17TMf63Axdo6k0usm75sK4p+kwwQub0XMvTjE1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708027026; c=relaxed/simple;
	bh=oN/sRPq4jlm3VlQuVcRbwooM4x22nJ5CpF0K43mSqlM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Zby9nVwikt5G+YVgUV9g+hHs+pK5KkNU7yP67vafnZTTVjq/EovtN1UrM57bcw4NS+x/dA3sTrz/WEtQqyQTRqcuFjLy8SS+eNuRzpW6s6+vAMPcErnjVSkHDqP3WakN0YiJzoc/RhA2Lefj+s2fZeNvsTXl24dbnI1ZNdvr6kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NeN8419m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HSu3W5Zi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 Feb 2024 19:57:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708027022;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SQyWViTCkGHwwQLwoYKftdoPFYphFQziEYmHaFnotk0=;
	b=NeN8419msXExC1O9tVciHE958eUL75fnQzedzD2PpjLwU0Oo03aAPKcnm9jCmUJ+q/vurM
	TbezujBdZM9tqQUQWPgcl3L8aJH1oEYcyu6RX1xf604nleuhr4ivdMN35TEZcrRgVvQ+3Z
	Ornkr/SBhrnclmWJ/dso944yjbwdawz8YWGVXFXRpWbAxGInXO0s8vGmEwkm5EionereOo
	LV08ScA/lqzREOvhwPKmAqxcnvUIsYO6EGtJTSm/LiCWj/vVBYmP7/7M1+iatCr8eavRor
	8Dx6zb7i3CUgV0bkz5FaQXoXQ/ouK7PQ0CVTL56RYyrnuCxdEeKOAswyMU9mPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708027022;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SQyWViTCkGHwwQLwoYKftdoPFYphFQziEYmHaFnotk0=;
	b=HSu3W5ZiKWGz3r/G2PcbqcFdEPKVQAAtMeiNyUuuqwtpILTb1g74sebVD8qaZsb/C/i57Q
	yDBTO3AWbY3jiWDQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] irqchip: Convert all platform MSI users to the new API
Cc: Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240127161753.114685-7-apatel@ventanamicro.com>
References: <20240127161753.114685-7-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170802702171.398.10668994835459911252.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     14fd06c776b5289a43c91cdc64bac3bdbc7b397e
Gitweb:        https://git.kernel.org/tip/14fd06c776b5289a43c91cdc64bac3bdbc7b397e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 27 Jan 2024 21:47:34 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 17:55:40 +01:00

irqchip: Convert all platform MSI users to the new API

Switch all the users of the platform MSI domain over to invoke the new
interfaces which branch to the original platform MSI functions when the
irqdomain associated to the caller device does not yet provide MSI parent
functionality.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240127161753.114685-7-apatel@ventanamicro.com

---
 drivers/dma/mv_xor_v2.c                     | 8 ++++----
 drivers/dma/qcom/hidma.c                    | 6 +++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 5 +++--
 drivers/mailbox/bcm-flexrm-mailbox.c        | 8 ++++----
 drivers/perf/arm_smmuv3_pmu.c               | 4 ++--
 drivers/ufs/host/ufs-qcom.c                 | 8 ++++----
 6 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/dma/mv_xor_v2.c b/drivers/dma/mv_xor_v2.c
index 1ebfbe8..97ebc79 100644
--- a/drivers/dma/mv_xor_v2.c
+++ b/drivers/dma/mv_xor_v2.c
@@ -747,8 +747,8 @@ static int mv_xor_v2_probe(struct platform_device *pdev)
 	if (IS_ERR(xor_dev->clk))
 		return PTR_ERR(xor_dev->clk);
 
-	ret = platform_msi_domain_alloc_irqs(&pdev->dev, 1,
-					     mv_xor_v2_set_msi_msg);
+	ret = platform_device_msi_init_and_alloc_irqs(&pdev->dev, 1,
+						      mv_xor_v2_set_msi_msg);
 	if (ret)
 		return ret;
 
@@ -851,7 +851,7 @@ free_hw_desq:
 			  xor_dev->desc_size * MV_XOR_V2_DESC_NUM,
 			  xor_dev->hw_desq_virt, xor_dev->hw_desq);
 free_msi_irqs:
-	platform_msi_domain_free_irqs(&pdev->dev);
+	platform_device_msi_free_irqs_all(&pdev->dev);
 	return ret;
 }
 
@@ -867,7 +867,7 @@ static void mv_xor_v2_remove(struct platform_device *pdev)
 
 	devm_free_irq(&pdev->dev, xor_dev->irq, xor_dev);
 
-	platform_msi_domain_free_irqs(&pdev->dev);
+	platform_device_msi_free_irqs_all(&pdev->dev);
 
 	tasklet_kill(&xor_dev->irq_tasklet);
 }
diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
index d63b93d..202ac95 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -696,7 +696,7 @@ static void hidma_free_msis(struct hidma_dev *dmadev)
 			devm_free_irq(dev, virq, &dmadev->lldev);
 	}
 
-	platform_msi_domain_free_irqs(dev);
+	platform_device_msi_free_irqs_all(dev);
 #endif
 }
 
@@ -706,8 +706,8 @@ static int hidma_request_msi(struct hidma_dev *dmadev,
 #ifdef CONFIG_GENERIC_MSI_IRQ
 	int rc, i, virq;
 
-	rc = platform_msi_domain_alloc_irqs(&pdev->dev, HIDMA_MSI_INTS,
-					    hidma_write_msi_msg);
+	rc = platform_device_msi_init_and_alloc_irqs(&pdev->dev, HIDMA_MSI_INTS,
+						     hidma_write_msi_msg);
 	if (rc)
 		return rc;
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 0ffb1cf..a74a509 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3125,7 +3125,8 @@ static int arm_smmu_update_gbpa(struct arm_smmu_device *smmu, u32 set, u32 clr)
 static void arm_smmu_free_msis(void *data)
 {
 	struct device *dev = data;
-	platform_msi_domain_free_irqs(dev);
+
+	platform_device_msi_free_irqs_all(dev);
 }
 
 static void arm_smmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
@@ -3166,7 +3167,7 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
 	}
 
 	/* Allocate MSIs for evtq, gerror and priq. Ignore cmdq */
-	ret = platform_msi_domain_alloc_irqs(dev, nvec, arm_smmu_write_msi_msg);
+	ret = platform_device_msi_init_and_alloc_irqs(dev, nvec, arm_smmu_write_msi_msg);
 	if (ret) {
 		dev_warn(dev, "failed to allocate MSIs - falling back to wired irqs\n");
 		return;
diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexrm-mailbox.c
index e3e28a4..b1abc2a 100644
--- a/drivers/mailbox/bcm-flexrm-mailbox.c
+++ b/drivers/mailbox/bcm-flexrm-mailbox.c
@@ -1587,8 +1587,8 @@ static int flexrm_mbox_probe(struct platform_device *pdev)
 	}
 
 	/* Allocate platform MSIs for each ring */
-	ret = platform_msi_domain_alloc_irqs(dev, mbox->num_rings,
-						flexrm_mbox_msi_write);
+	ret = platform_device_msi_init_and_alloc_irqs(dev, mbox->num_rings,
+						      flexrm_mbox_msi_write);
 	if (ret)
 		goto fail_destroy_cmpl_pool;
 
@@ -1641,7 +1641,7 @@ skip_debugfs:
 
 fail_free_debugfs_root:
 	debugfs_remove_recursive(mbox->root);
-	platform_msi_domain_free_irqs(dev);
+	platform_device_msi_free_irqs_all(dev);
 fail_destroy_cmpl_pool:
 	dma_pool_destroy(mbox->cmpl_pool);
 fail_destroy_bd_pool:
@@ -1657,7 +1657,7 @@ static void flexrm_mbox_remove(struct platform_device *pdev)
 
 	debugfs_remove_recursive(mbox->root);
 
-	platform_msi_domain_free_irqs(dev);
+	platform_device_msi_free_irqs_all(dev);
 
 	dma_pool_destroy(mbox->cmpl_pool);
 	dma_pool_destroy(mbox->bd_pool);
diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index 6303b82..9e5d7fa 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -716,7 +716,7 @@ static void smmu_pmu_free_msis(void *data)
 {
 	struct device *dev = data;
 
-	platform_msi_domain_free_irqs(dev);
+	platform_device_msi_free_irqs_all(dev);
 }
 
 static void smmu_pmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
@@ -746,7 +746,7 @@ static void smmu_pmu_setup_msi(struct smmu_pmu *pmu)
 	if (!(readl(pmu->reg_base + SMMU_PMCG_CFGR) & SMMU_PMCG_CFGR_MSI))
 		return;
 
-	ret = platform_msi_domain_alloc_irqs(dev, 1, smmu_pmu_write_msi_msg);
+	ret = platform_device_msi_init_and_alloc_irqs(dev, 1, smmu_pmu_write_msi_msg);
 	if (ret) {
 		dev_warn(dev, "failed to allocate MSIs\n");
 		return;
diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 39eef47..8fde520 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1712,8 +1712,8 @@ static int ufs_qcom_config_esi(struct ufs_hba *hba)
 	 * 2. Poll queues do not need ESI.
 	 */
 	nr_irqs = hba->nr_hw_queues - hba->nr_queues[HCTX_TYPE_POLL];
-	ret = platform_msi_domain_alloc_irqs(hba->dev, nr_irqs,
-					     ufs_qcom_write_msi_msg);
+	ret = platform_device_msi_init_and_alloc_irqs(hba->dev, nr_irqs,
+						      ufs_qcom_write_msi_msg);
 	if (ret) {
 		dev_err(hba->dev, "Failed to request Platform MSI %d\n", ret);
 		return ret;
@@ -1742,7 +1742,7 @@ static int ufs_qcom_config_esi(struct ufs_hba *hba)
 			devm_free_irq(hba->dev, desc->irq, hba);
 		}
 		msi_unlock_descs(hba->dev);
-		platform_msi_domain_free_irqs(hba->dev);
+		platform_device_msi_free_irqs_all(hba->dev);
 	} else {
 		if (host->hw_ver.major == 6 && host->hw_ver.minor == 0 &&
 		    host->hw_ver.step == 0)
@@ -1818,7 +1818,7 @@ static void ufs_qcom_remove(struct platform_device *pdev)
 
 	pm_runtime_get_sync(&(pdev)->dev);
 	ufshcd_remove(hba);
-	platform_msi_domain_free_irqs(hba->dev);
+	platform_device_msi_free_irqs_all(hba->dev);
 }
 
 static const struct of_device_id ufs_qcom_of_match[] __maybe_unused = {

