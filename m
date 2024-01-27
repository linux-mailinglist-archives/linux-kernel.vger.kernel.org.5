Return-Path: <linux-kernel+bounces-41280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B43A83EE5F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEEDCB23449
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6183C2C848;
	Sat, 27 Jan 2024 16:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Hh57igou"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43A22E835
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 16:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706372335; cv=none; b=JJUSsQqn4DqGUEY0bi81aPaBSXI9oSgS7CvqlxjBoozCdrR7lUzw6qsVUEbsYxbv/fYXdmMekcZ+RitSpnvOzNZ/ePTbCYctlBYpxxF7SfHs2k8wy1sMkXuOy6YSgE7nOnVNQwTnOJvszJ97o17tCWL8X7KNIkoSz4sgw/leHkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706372335; c=relaxed/simple;
	bh=mCQMrYXk5bnwwomgWMOM+JO+WRoGMQ5DgCCrKZUuqcc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JeOk/o0MJFl+VU6XA+9sGl+zMtf4SSSBUPj7H33gpMYFGGnxiRN0/SXfYW/X7GkavW/TbslVxGuUxlXCh0+35wHH1QLVHtjXNugYyktatOgA+Sy16n+W+UGPul7S1mPZE1RU2q1WgcePu4pzCIoyuzSqkBUQarmiLYr5Cla0GLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Hh57igou; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2945ce598bfso728480a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 08:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1706372333; x=1706977133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Ekp7NR9JGHvKX5tDHRTOvHiQ7p6oqRI0Ent2tTntvI=;
        b=Hh57igoumQ0C80pEdQwF2J/hYNjjhdbx9oDyObiSXcWoRWhTDzk2cKkRe2jmPvP4nW
         3QZ/4kSGI4o/cHK6pjMwhrSPkOGQXIQe2xpBkEH6XE3B+SQhYNyvJqVYjTKXRjAtuQJa
         2rL/7/AorguYRh9ZrvgO7xKS6sdqKcZbch+IdvZo7Petve+EYhuZ2887JA+bDTDkDUAM
         XPxmZusQWgkjNqgxFaSRD34NWqU3F3hbo/UXwX8lCmcGFx+FinP7SkGqhv6osJs5Fe8X
         gUS4Cudyo/V9dX9EZ2QEMrIXwaLyoy58lXQTwts3KZnRxnR0WM7Krf+JCrB7UlHdzlTo
         AfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706372333; x=1706977133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Ekp7NR9JGHvKX5tDHRTOvHiQ7p6oqRI0Ent2tTntvI=;
        b=Myte6mSgxK4mjqMar3wTHI4DoGOQoboX1Lb6xc661ljI9q1h8cW5VP2f1jLA/XwIlI
         5nhuPEBwJJwvEieR1l9QEB4xka0t7aSAa8ImTkf0Bupjc3C6YerKXrkZpUwt6T4YvqTc
         rK33Br5p82M+/j1DCZ3TcmYxcJB/PjeBHHCeA+Sbz1erIvpv2YC0OXMv15T4a/Ez2SzK
         FcRfrQ4B/HiilcBRkAoYk4zD5ZntP0pgesWJfNJ4BPcAmU1G47bhYwnk3tARbnuxUjT0
         Pgc2JVAKWwWaZ0dRv4I4lU/R5ERsz1UcAYwWTdFbTJOcPOfDu8LWLKi29cAXRtsenmOH
         8H0g==
X-Gm-Message-State: AOJu0YzTjZb01cYec9+B8DFbO3QewjvYIHFojDFH8VrlGYjllEkjaEwd
	ZaPYleG+gxDjcbh+JD8SmSoaUleONI72YVf0PimlK5KcBoNpVPfIHUQ6Ywz9DWA=
X-Google-Smtp-Source: AGHT+IG8bjgnQErzq4BE0Rgjwv3fngKcK42zpZJYDnCSRnuoHpUHefIS7rhIK2NUJYxnqucbED1hzw==
X-Received: by 2002:a17:90a:c585:b0:28e:829e:3f99 with SMTP id l5-20020a17090ac58500b0028e829e3f99mr812895pjt.69.1706372333301;
        Sat, 27 Jan 2024 08:18:53 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.86.17])
        by smtp.gmail.com with ESMTPSA id d11-20020a17090ac24b00b00290f8c708d0sm5091620pjx.57.2024.01.27.08.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 08:18:52 -0800 (PST)
From: Anup Patel <apatel@ventanamicro.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Atish Patra <atishp@atishpatra.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Saravana Kannan <saravanak@google.com>,
	Anup Patel <anup@brainfault.org>,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sinan Kaya <okaya@kernel.org>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v12 06/25] irqchip: Convert all platform MSI users to the new API
Date: Sat, 27 Jan 2024 21:47:34 +0530
Message-Id: <20240127161753.114685-7-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240127161753.114685-1-apatel@ventanamicro.com>
References: <20240127161753.114685-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

Switch all the users of the platform MSI domain over to invoke the new
interfaces which branch to the original platform MSI functions when the
irqdomain associated to the caller device does not yet provide MSI parent
functionality.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Sinan Kaya <okaya@kernel.org>
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/dma/mv_xor_v2.c                     | 8 ++++----
 drivers/dma/qcom/hidma.c                    | 6 +++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 5 +++--
 drivers/mailbox/bcm-flexrm-mailbox.c        | 8 ++++----
 drivers/perf/arm_smmuv3_pmu.c               | 4 ++--
 drivers/ufs/host/ufs-qcom.c                 | 8 ++++----
 6 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/dma/mv_xor_v2.c b/drivers/dma/mv_xor_v2.c
index 1ebfbe88e733..732663ad6d71 100644
--- a/drivers/dma/mv_xor_v2.c
+++ b/drivers/dma/mv_xor_v2.c
@@ -747,8 +747,8 @@ static int mv_xor_v2_probe(struct platform_device *pdev)
 	if (IS_ERR(xor_dev->clk))
 		return PTR_ERR(xor_dev->clk);
 
-	ret = platform_msi_domain_alloc_irqs(&pdev->dev, 1,
-					     mv_xor_v2_set_msi_msg);
+	ret = platform_device_ims_init_and_alloc_irqs(&pdev->dev, 1,
+						      mv_xor_v2_set_msi_msg);
 	if (ret)
 		return ret;
 
@@ -851,7 +851,7 @@ static int mv_xor_v2_probe(struct platform_device *pdev)
 			  xor_dev->desc_size * MV_XOR_V2_DESC_NUM,
 			  xor_dev->hw_desq_virt, xor_dev->hw_desq);
 free_msi_irqs:
-	platform_msi_domain_free_irqs(&pdev->dev);
+	platform_device_ims_free_irqs_all(&pdev->dev);
 	return ret;
 }
 
@@ -867,7 +867,7 @@ static void mv_xor_v2_remove(struct platform_device *pdev)
 
 	devm_free_irq(&pdev->dev, xor_dev->irq, xor_dev);
 
-	platform_msi_domain_free_irqs(&pdev->dev);
+	platform_device_ims_free_irqs_all(&pdev->dev);
 
 	tasklet_kill(&xor_dev->irq_tasklet);
 }
diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
index d63b93dc7047..4065d6eab49e 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -696,7 +696,7 @@ static void hidma_free_msis(struct hidma_dev *dmadev)
 			devm_free_irq(dev, virq, &dmadev->lldev);
 	}
 
-	platform_msi_domain_free_irqs(dev);
+	platform_device_ims_free_irqs_all(dev);
 #endif
 }
 
@@ -706,8 +706,8 @@ static int hidma_request_msi(struct hidma_dev *dmadev,
 #ifdef CONFIG_GENERIC_MSI_IRQ
 	int rc, i, virq;
 
-	rc = platform_msi_domain_alloc_irqs(&pdev->dev, HIDMA_MSI_INTS,
-					    hidma_write_msi_msg);
+	rc = platform_device_ims_init_and_alloc_irqs(&pdev->dev, HIDMA_MSI_INTS,
+						     hidma_write_msi_msg);
 	if (rc)
 		return rc;
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 0ffb1cf17e0b..84a765b1f64e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3125,7 +3125,8 @@ static int arm_smmu_update_gbpa(struct arm_smmu_device *smmu, u32 set, u32 clr)
 static void arm_smmu_free_msis(void *data)
 {
 	struct device *dev = data;
-	platform_msi_domain_free_irqs(dev);
+
+	platform_device_ims_free_irqs_all(dev);
 }
 
 static void arm_smmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
@@ -3166,7 +3167,7 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
 	}
 
 	/* Allocate MSIs for evtq, gerror and priq. Ignore cmdq */
-	ret = platform_msi_domain_alloc_irqs(dev, nvec, arm_smmu_write_msi_msg);
+	ret = platform_device_ims_init_and_alloc_irqs(dev, nvec, arm_smmu_write_msi_msg);
 	if (ret) {
 		dev_warn(dev, "failed to allocate MSIs - falling back to wired irqs\n");
 		return;
diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexrm-mailbox.c
index e3e28a4f7d01..333ca6c519cb 100644
--- a/drivers/mailbox/bcm-flexrm-mailbox.c
+++ b/drivers/mailbox/bcm-flexrm-mailbox.c
@@ -1587,8 +1587,8 @@ static int flexrm_mbox_probe(struct platform_device *pdev)
 	}
 
 	/* Allocate platform MSIs for each ring */
-	ret = platform_msi_domain_alloc_irqs(dev, mbox->num_rings,
-						flexrm_mbox_msi_write);
+	ret = platform_device_ims_init_and_alloc_irqs(dev, mbox->num_rings,
+						      flexrm_mbox_msi_write);
 	if (ret)
 		goto fail_destroy_cmpl_pool;
 
@@ -1641,7 +1641,7 @@ static int flexrm_mbox_probe(struct platform_device *pdev)
 
 fail_free_debugfs_root:
 	debugfs_remove_recursive(mbox->root);
-	platform_msi_domain_free_irqs(dev);
+	platform_device_ims_free_irqs_all(dev);
 fail_destroy_cmpl_pool:
 	dma_pool_destroy(mbox->cmpl_pool);
 fail_destroy_bd_pool:
@@ -1657,7 +1657,7 @@ static void flexrm_mbox_remove(struct platform_device *pdev)
 
 	debugfs_remove_recursive(mbox->root);
 
-	platform_msi_domain_free_irqs(dev);
+	platform_device_ims_free_irqs_all(dev);
 
 	dma_pool_destroy(mbox->cmpl_pool);
 	dma_pool_destroy(mbox->bd_pool);
diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index 6303b82566f9..32b604e8bdf3 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -716,7 +716,7 @@ static void smmu_pmu_free_msis(void *data)
 {
 	struct device *dev = data;
 
-	platform_msi_domain_free_irqs(dev);
+	platform_device_ims_free_irqs_all(dev);
 }
 
 static void smmu_pmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
@@ -746,7 +746,7 @@ static void smmu_pmu_setup_msi(struct smmu_pmu *pmu)
 	if (!(readl(pmu->reg_base + SMMU_PMCG_CFGR) & SMMU_PMCG_CFGR_MSI))
 		return;
 
-	ret = platform_msi_domain_alloc_irqs(dev, 1, smmu_pmu_write_msi_msg);
+	ret = platform_device_ims_init_and_alloc_irqs(dev, 1, smmu_pmu_write_msi_msg);
 	if (ret) {
 		dev_warn(dev, "failed to allocate MSIs\n");
 		return;
diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 39eef470f8fa..f4c4becdef0b 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1712,8 +1712,8 @@ static int ufs_qcom_config_esi(struct ufs_hba *hba)
 	 * 2. Poll queues do not need ESI.
 	 */
 	nr_irqs = hba->nr_hw_queues - hba->nr_queues[HCTX_TYPE_POLL];
-	ret = platform_msi_domain_alloc_irqs(hba->dev, nr_irqs,
-					     ufs_qcom_write_msi_msg);
+	ret = platform_device_ims_init_and_alloc_irqs(hba->dev, nr_irqs,
+						      ufs_qcom_write_msi_msg);
 	if (ret) {
 		dev_err(hba->dev, "Failed to request Platform MSI %d\n", ret);
 		return ret;
@@ -1742,7 +1742,7 @@ static int ufs_qcom_config_esi(struct ufs_hba *hba)
 			devm_free_irq(hba->dev, desc->irq, hba);
 		}
 		msi_unlock_descs(hba->dev);
-		platform_msi_domain_free_irqs(hba->dev);
+		platform_device_ims_free_irqs_all(hba->dev);
 	} else {
 		if (host->hw_ver.major == 6 && host->hw_ver.minor == 0 &&
 		    host->hw_ver.step == 0)
@@ -1818,7 +1818,7 @@ static void ufs_qcom_remove(struct platform_device *pdev)
 
 	pm_runtime_get_sync(&(pdev)->dev);
 	ufshcd_remove(hba);
-	platform_msi_domain_free_irqs(hba->dev);
+	platform_device_ims_free_irqs_all(hba->dev);
 }
 
 static const struct of_device_id ufs_qcom_of_match[] __maybe_unused = {
-- 
2.34.1


