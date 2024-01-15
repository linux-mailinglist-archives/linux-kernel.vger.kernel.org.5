Return-Path: <linux-kernel+bounces-26175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 945AB82DC5C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E4DE1F2229F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735B11774A;
	Mon, 15 Jan 2024 15:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bnWcOZI0"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667DD1773B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 15:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7831c604a84so669162585a.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 07:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1705332714; x=1705937514; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EP7ba7EwyzSY9ixIBc2mRLxgseDIdjllwZdyqbP2x60=;
        b=bnWcOZI0rI4os91arRRX0WJQ+0DxyCC9bOsEcPX+1unzvdXKorVHO2Gs6yousJD+7A
         36EWbqx1WWgbOBKEmDG4+VLwJzjYvxlVaowYUEe3CjdbzFr6PtTaVydLibEJW6MLeDvk
         YN0rpMPPfUhYJk8XA5bUbnrSr8+RB+1wiEf7dvQvwE4T7ooZxDX1+BA7JdWgUXFhDE30
         FFRQFPhuZmmMPXZDLrxDcgCDCWCTd+96AzbntboenNTQM+cl9Ua5TC/ZzY5DnuK79bCR
         wmHXduCra0QslXXnr9+6dLo4YfG+qqJFoLFBWLZNzofurBgeXrfLS6nlG3J9TpJkQ/UR
         N2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705332714; x=1705937514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EP7ba7EwyzSY9ixIBc2mRLxgseDIdjllwZdyqbP2x60=;
        b=NM7O4UyqMfJhR14glxdBRQMHemYNNF3ya8y+4AQRUeTkNgs6j0keR8oB36AwCwEtQV
         wRi/8tYCqvoSeIFxOzhh7mw4CHYeZ1U8RI2uH9lJNt98Wb7G1dAQyRchwDiYKudxYdBQ
         z6Kl6iPXjuATHWEoXVra+O2MnoGFZfM+I2J8ylHAnYkT1bM2DnSn7VeQXUoShMKAyxCb
         d+On3sjIOHCbspQAn6uC3omGyHXXbKGe70A5Vm5RTOHybq1L+VfJQ6FJ/0T4iMEIAnnh
         Zqkl/dVfyRv5To/+pd4QJ3793yRXxubT55bkihLhODcbXj3pQ0WqF3zPdv/HiuPuyNJ7
         aKPg==
X-Gm-Message-State: AOJu0YwRbn8RrTRr7t9HN175LRNLhEoWx71syNmB5tkuJbD9TpJn3VPc
	Jf8tH13mWezgeupeYaEIKJPRblMdNtp12A==
X-Google-Smtp-Source: AGHT+IFZ5XMomkHx9ttZZVDnSfWUt6wuLw+EfcDJlqITFfaC4G9t+wjge/3sMN2PINmoCmF+HiJQzw==
X-Received: by 2002:ad4:5744:0:b0:67f:4d05:bd5 with SMTP id q4-20020ad45744000000b0067f4d050bd5mr6178880qvx.58.1705332714131;
        Mon, 15 Jan 2024 07:31:54 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id r1-20020ad44041000000b0067f24bd0afasm3353234qvp.101.2024.01.15.07.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 07:31:53 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rPOwK-003sEj-P2;
	Mon, 15 Jan 2024 11:31:52 -0400
Date: Mon, 15 Jan 2024 11:31:52 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhang Zekun <zhangzekun11@huawei.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	nicolinc@nvidia.com, mshavit@google.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Add a threshold to avoid potential
 soft lockup
Message-ID: <20240115153152.GA50608@ziepe.ca>
References: <20240115114040.6279-1-zhangzekun11@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115114040.6279-1-zhangzekun11@huawei.com>

On Mon, Jan 15, 2024 at 07:40:40PM +0800, Zhang Zekun wrote:
> The commit d5afb4b47e13 ("iommu/arm-smmu-v3: Fix soft lockup triggered
> by arm_smmu_mm_invalidate_range") has fix a soft lockup problem when
> running SVA case, but code paths from iommu_unmap and dma APIs still
> remain unfixed which could also cause potential soft lockup.
> 
> When cmdq is quite busy and don't have much space for batch submitting
> cmds, and size passed to __arm_smmu_tlb_inv_range() is large (1G in this
> case), the following softlockup is triggered.
> 
> WARN: soft lockup - CPU#71 stuck for 12s! [qemu-kvm:1303]
> ...
> Call trace:
>  dump_backtrace+0x0/0x200
>  show_stack+0x20/0x30
>  dump_stack+0xf0/0x138
>  watchdog_print_info+0x48/0x54
>  watchdog_process_before_softlockup+0x9c/0xa0
>  watchdog_timer_fn+0x1ac/0x2f0
>  __run_hrtimer+0x98/0x2b4
>  __hrtimer_run_queues+0xc0/0x13c
>  hrtimer_interrupt+0x150/0x3e4
>  arch_timer_handler_phys+0x3c/0x50
>  handle_percpu_devid_irq+0x90/0x1f4
>  __handle_domain_irq+0x84/0xfc
>  gic_handle_irq+0x88/0x2b0
>  el1_irq+0xb8/0x140
>  arm_smmu_cmdq_issue_cmdlist+0x184/0x5f4
>  __arm_smmu_tlb_inv_range+0x114/0x22c
>  arm_smmu_tlb_inv_walk+0x88/0x120
>  __arm_lpae_unmap+0x188/0x2c0
>  __arm_lpae_unmap+0x104/0x2c0
>  arm_lpae_unmap+0x68/0x80
>  arm_smmu_unmap+0x24/0x40
>  __iommu_unmap+0xd8/0x210
>  iommu_unmap+0x44/0x9c
> ...

What is the rest of the call chain? How did you get into such a large
invalidation?

> @@ -228,7 +219,7 @@ static void arm_smmu_mm_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
>  	 */
>  	size = end - start;
>  	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_RANGE_INV)) {
> -		if (size >= CMDQ_MAX_TLBI_OPS * PAGE_SIZE)
> +		if (size >= CMDQ_MAX_TLBI_OPS(PAGE_SIZE) * PAGE_SIZE)
>  			size = 0;
>  	} else {
>  		if (size == ULONG_MAX)

I would like to see the SVA code rely on the common invalidation
infrastructure, this should be pushed down into the invalidation logic
not be in the SVA code. With some adjustments we can get common
functions for all this and push the decision making into the actual
function.

Something like this, on top of my "part 3" branch
https://github.com/jgunthorpe/linux/commits/smmuv3_newapi/
split into more patches:

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 5ab976f6b108dd..b30cce97b01d06 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -30,7 +30,6 @@ static int arm_smmu_realloc_s1_domain_asid(struct arm_smmu_device *smmu,
 					   struct arm_smmu_domain *smmu_domain)
 {
 	struct arm_smmu_master_domain *master_domain;
-	u32 old_asid = smmu_domain->asid;
 	struct arm_smmu_cd target_cd;
 	unsigned long flags;
 	int ret;
@@ -68,9 +67,6 @@ static int arm_smmu_realloc_s1_domain_asid(struct arm_smmu_device *smmu,
 					&target_cd);
 	}
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
-
-	/* Clean the ASID we are about to assign to a new translation */
-	arm_smmu_tlb_inv_asid(smmu, old_asid);
 	return 0;
 }
 
@@ -175,24 +171,12 @@ static void arm_smmu_mm_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
 	 * range. So do a simple translation here by calculating size correctly.
 	 */
 	size = end - start;
-	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_RANGE_INV)) {
-		if (size >= CMDQ_MAX_TLBI_OPS * PAGE_SIZE)
-			size = 0;
-	} else {
-		if (size == ULONG_MAX)
-			size = 0;
-	}
+	if (size == ULONG_MAX)
+		size = 0;
 
-	if (!smmu_domain->btm_invalidation) {
-		ioasid_t asid = READ_ONCE(smmu_domain->asid);
-
-		if (!size)
-			arm_smmu_tlb_inv_asid(smmu_domain->smmu, asid);
-		else
-			arm_smmu_tlb_inv_range_asid(start, size, asid,
-						    PAGE_SIZE, false,
-						    smmu_domain);
-	}
+	if (!smmu_domain->btm_invalidation)
+		arm_smmu_tlb_inv_range_s1(start, size, PAGE_SIZE, false,
+					  smmu_domain);
 
 	arm_smmu_atc_inv_domain(smmu_domain, start, size);
 }
@@ -228,7 +212,7 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	}
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
-	arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_domain->asid);
+	arm_smmu_tlb_inv_all_s1(smmu_domain);
 	arm_smmu_atc_inv_domain(smmu_domain, 0, 0);
 }
 
@@ -506,6 +490,8 @@ static int arm_smmu_share_asid(struct arm_smmu_device *smmu,
 		ret = arm_smmu_realloc_s1_domain_asid(smmu, old_s1_domain);
 		if (ret)
 			goto out_restore_s1;
+		/* Clean the ASID since it was just recovered */
+		arm_smmu_tlb_inv_all_s1(smmu_domain);
 	}
 
 	smmu_domain->btm_invalidation = true;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index b07e0692eb78ea..79c85791b0c3d5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -90,6 +90,7 @@ static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu);
 static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
 				    struct arm_smmu_device *smmu);
 static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
+static void arm_smmu_tlb_inv_all_s2(struct arm_smmu_domain *smmu_domain);
 
 static void parse_driver_options(struct arm_smmu_device *smmu)
 {
@@ -965,17 +966,6 @@ static int arm_smmu_page_response(struct device *dev,
 }
 
 /* Context descriptor manipulation functions */
-void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid)
-{
-	struct arm_smmu_cmdq_ent cmd = {
-		.opcode	= smmu->features & ARM_SMMU_FEAT_E2H ?
-			CMDQ_OP_TLBI_EL2_ASID : CMDQ_OP_TLBI_NH_ASID,
-		.tlbi.asid = asid,
-	};
-
-	arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
-}
-
 #define NUM_ENTRY_QWORDS                                                \
 	(max(sizeof(struct arm_smmu_ste), sizeof(struct arm_smmu_cd)) / \
 	 sizeof(u64))
@@ -2106,8 +2096,6 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
 static void arm_smmu_tlb_inv_context(void *cookie)
 {
 	struct arm_smmu_domain *smmu_domain = cookie;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_cmdq_ent cmd;
 
 	/*
 	 * NOTE: when io-pgtable is in non-strict mode, we may get here with
@@ -2116,13 +2104,10 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 	 * insertion to guarantee those are observed before the TLBI. Do be
 	 * careful, 007.
 	 */
-	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
-		arm_smmu_tlb_inv_asid(smmu, READ_ONCE(smmu_domain->asid));
-	} else {
-		cmd.opcode	= CMDQ_OP_TLBI_S12_VMALL;
-		cmd.tlbi.vmid	= smmu_domain->vmid;
-		arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
-	}
+	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1)
+		arm_smmu_tlb_inv_all_s1(smmu_domain);
+	else
+		arm_smmu_tlb_inv_all_s2(smmu_domain);
 	arm_smmu_atc_inv_domain(smmu_domain, 0, 0);
 }
 
@@ -2197,47 +2182,69 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 	arm_smmu_cmdq_batch_submit(smmu, &cmds);
 }
 
-static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
-					  size_t granule, bool leaf,
-					  struct arm_smmu_domain *smmu_domain)
+static bool arm_smmu_inv_range_too_big(struct arm_smmu_device *smmu,
+				       size_t size, size_t granule)
 {
-	struct arm_smmu_cmdq_ent cmd = {
-		.tlbi = {
-			.leaf	= leaf,
-		},
-	};
+	unsigned max_ops;
 
-	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
-		cmd.opcode	= smmu_domain->smmu->features & ARM_SMMU_FEAT_E2H ?
-				  CMDQ_OP_TLBI_EL2_VA : CMDQ_OP_TLBI_NH_VA;
-		cmd.tlbi.asid	= smmu_domain->asid;
-	} else {
-		cmd.opcode	= CMDQ_OP_TLBI_S2_IPA;
-		cmd.tlbi.vmid	= smmu_domain->vmid;
-	}
-	__arm_smmu_tlb_inv_range(&cmd, iova, size, granule, smmu_domain);
+	/* 0 size means invalidate all */
+	if (!size || size == SIZE_MAX)
+		return true;
 
-	/*
-	 * Unfortunately, this can't be leaf-only since we may have
-	 * zapped an entire table.
-	 */
-	arm_smmu_atc_inv_domain(smmu_domain, iova, size);
+	if (smmu->features & ARM_SMMU_FEAT_RANGE_INV)
+		return false;
+
+	max_ops = 1 << (ilog2(granule) - 3);
+	return size >= max_ops * granule;
 }
 
-void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
-				 size_t granule, bool leaf,
-				 struct arm_smmu_domain *smmu_domain)
+void arm_smmu_tlb_inv_range_s1(unsigned long iova, size_t size, size_t granule,
+			       bool leaf, struct arm_smmu_domain *smmu_domain)
 {
 	struct arm_smmu_cmdq_ent cmd = {
 		.opcode	= smmu_domain->smmu->features & ARM_SMMU_FEAT_E2H ?
 			  CMDQ_OP_TLBI_EL2_VA : CMDQ_OP_TLBI_NH_VA,
 		.tlbi = {
-			.asid	= asid,
+			.asid	= READ_ONCE(smmu_domain->asid),
 			.leaf	= leaf,
 		},
 	};
 
-	__arm_smmu_tlb_inv_range(&cmd, iova, size, granule, smmu_domain);
+	if (arm_smmu_inv_range_too_big(smmu_domain->smmu, size, granule)) {
+		cmd.opcode = smmu_domain->smmu->features & ARM_SMMU_FEAT_E2H ?
+				     CMDQ_OP_TLBI_EL2_ASID :
+				     CMDQ_OP_TLBI_NH_ASID,
+		arm_smmu_cmdq_issue_cmd_with_sync(smmu_domain->smmu, &cmd);
+	} else{
+		__arm_smmu_tlb_inv_range(&cmd, iova, size, granule,
+					 smmu_domain);
+	}
+}
+
+static void arm_smmu_tlb_inv_range_s2(unsigned long iova, size_t size,
+				      size_t granule, bool leaf,
+				      struct arm_smmu_domain *smmu_domain)
+{
+	struct arm_smmu_cmdq_ent cmd = {
+		.opcode	= CMDQ_OP_TLBI_S2_IPA,
+		.tlbi = {
+			.vmid	= smmu_domain->vmid,
+			.leaf	= leaf,
+		},
+	};
+
+	if (arm_smmu_inv_range_too_big(smmu_domain->smmu, size, granule)) {
+		cmd.opcode = CMDQ_OP_TLBI_S12_VMALL;
+		arm_smmu_cmdq_issue_cmd_with_sync(smmu_domain->smmu, &cmd);
+	} else {
+		__arm_smmu_tlb_inv_range(&cmd, iova, size, granule,
+					 smmu_domain);
+	}
+}
+
+static void arm_smmu_tlb_inv_all_s2(struct arm_smmu_domain *smmu_domain)
+{
+	arm_smmu_tlb_inv_range_s2(0, 0, PAGE_SIZE, false, smmu_domain);
 }
 
 static void arm_smmu_tlb_inv_page_nosync(struct iommu_iotlb_gather *gather,
@@ -2253,7 +2260,15 @@ static void arm_smmu_tlb_inv_page_nosync(struct iommu_iotlb_gather *gather,
 static void arm_smmu_tlb_inv_walk(unsigned long iova, size_t size,
 				  size_t granule, void *cookie)
 {
-	arm_smmu_tlb_inv_range_domain(iova, size, granule, false, cookie);
+	struct arm_smmu_domain *smmu_domain = cookie;
+
+	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1)
+		arm_smmu_tlb_inv_range_s1(iova, size, granule, false,
+					  smmu_domain);
+	else
+		arm_smmu_tlb_inv_range_s2(iova, size, granule, false,
+					  smmu_domain);
+	arm_smmu_atc_inv_domain(smmu_domain, iova, size);
 }
 
 static const struct iommu_flush_ops arm_smmu_flush_ops = {
@@ -2379,7 +2394,7 @@ void arm_smmu_domain_free_id(struct arm_smmu_domain *smmu_domain)
 	if ((smmu_domain->stage == ARM_SMMU_DOMAIN_S1 ||
 	     smmu_domain->domain.type == IOMMU_DOMAIN_SVA) &&
 	    smmu_domain->asid) {
-		arm_smmu_tlb_inv_asid(smmu, smmu_domain->asid);
+		arm_smmu_tlb_inv_all_s1(smmu_domain);
 
 		/* Prevent SVA from touching the CD while we're freeing it */
 		mutex_lock(&smmu->asid_lock);
@@ -3183,13 +3198,23 @@ static void arm_smmu_iotlb_sync(struct iommu_domain *domain,
 				struct iommu_iotlb_gather *gather)
 {
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	size_t size = gather->end - gather->start + 1;
 
 	if (!gather->pgsize)
 		return;
 
-	arm_smmu_tlb_inv_range_domain(gather->start,
-				      gather->end - gather->start + 1,
-				      gather->pgsize, true, smmu_domain);
+	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1)
+		arm_smmu_tlb_inv_range_s1(gather->start, size, gather->pgsize,
+					  true, smmu_domain);
+	else
+		arm_smmu_tlb_inv_range_s2(gather->start, size, gather->pgsize,
+					  true, smmu_domain);
+
+	/*
+	 * Unfortunately, this can't be leaf-only since we may have
+	 * zapped an entire table.
+	 */
+	arm_smmu_atc_inv_domain(smmu_domain, gather->start, size);
 }
 
 static phys_addr_t
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index d65c716d4fc04f..9f5537ef97caff 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -834,10 +834,13 @@ void arm_smmu_remove_pasid(struct arm_smmu_master *master,
 int arm_smmu_domain_alloc_id(struct arm_smmu_device *smmu,
 			     struct arm_smmu_domain *smmu_domain);
 void arm_smmu_domain_free_id(struct arm_smmu_domain *smmu_domain);
-void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid);
-void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
-				 size_t granule, bool leaf,
-				 struct arm_smmu_domain *smmu_domain);
+void arm_smmu_tlb_inv_range_s1(unsigned long iova, size_t size, size_t granule,
+			       bool leaf, struct arm_smmu_domain *smmu_domain);
+static inline void arm_smmu_tlb_inv_all_s1(struct arm_smmu_domain *smmu_domain)
+{
+	arm_smmu_tlb_inv_range_s1(0, 0, PAGE_SIZE, false, smmu_domain);
+}
+
 int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
 			    unsigned long iova, size_t size);
 

