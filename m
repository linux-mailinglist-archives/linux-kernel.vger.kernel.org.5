Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A127A1FBA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 15:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235295AbjIONVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 09:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235289AbjIONVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 09:21:36 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B90E2736
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 06:21:25 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59beea5ce93so32562097b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 06:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694784085; x=1695388885; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=slHApP6J3mxiZqIO3QLpbI9JKNPWtKRvLmicwhoDCkc=;
        b=CkzygINnC8g2Y2cxlOPjAOV9Ei4xKpebNbd+0gTsmAIdRxSzvDStLZZ4vTVCJ7gqOp
         /zf6IvnCK/I2iNW6OJKI8vLcPv3ioWAJbOdIt7Pbsh2vNieBPQwJv2BhexGXJ5yEH4fE
         akG1iuOrjXr3IXrDntYiMNKfsmqB+Le07yHmzutlHpEwxkN1z7oQrZGBr53cyEL/lc4h
         q+guGJR+fnDth/BxpbtHoLApBtZgLOA0bGZwyGbi1pyP0ejlpYs9mckWQkb1uNUkR7Rd
         PrSHA4/bZWnTwPqO/so9ONacmkHX/ENMih4ldIRrKX9DIM3gu6fUFvFA4srMykNKrTRP
         Uekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694784085; x=1695388885;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=slHApP6J3mxiZqIO3QLpbI9JKNPWtKRvLmicwhoDCkc=;
        b=Unw7VdqVU88N3a1FtZNwABgVs1tE6L1d+oF5zwIQm4XYv3dWayd5WcLxU0viw53q8O
         qlQEjy488wEPyWg/gYfam/H7NrMHmSIG9CmqPwI28BMBUWiEC2GXbQ12wVNkceTcZmKv
         PJZfbWZWKD+Qd6QXTdymAjfimgJn8Ph6oG+nGOm0m6ZZ353E9fuSiDhisxSXmI0DB1Rc
         RfvmcIqi6wP9Yo0Zroh03zvoct+ja+hJiF2TWvCn8naR1bsFmJI7DkOgOw/qGvZb3q09
         6lbda9KH22PuKZja9sPQtvxNJ/ym3fDXDzENhiPH8g7s8IcVz/rL0VqjZDZWfHOqiaOB
         yMGQ==
X-Gm-Message-State: AOJu0Yx7cpaA1pTeYMRQPaRVIhAdfaPxf8pfWWk25NXrHDfbScZRei3F
        zxbnbNIevkv8cQPmMWz1jFfE+bFaPvmX
X-Google-Smtp-Source: AGHT+IEV0oXc3fM6UG5C8uyUIfPWEhUgexegIYHod9RrHGoxt93Dg6aNtbgou6lJn5nheJpJyVCB/Hj5nUTC
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:47bc:d53f:1c50:a3f2])
 (user=mshavit job=sendgmr) by 2002:a81:b388:0:b0:56c:e9fe:3cb4 with SMTP id
 r130-20020a81b388000000b0056ce9fe3cb4mr58272ywh.1.1694784084812; Fri, 15 Sep
 2023 06:21:24 -0700 (PDT)
Date:   Fri, 15 Sep 2023 21:17:37 +0800
In-Reply-To: <20230915132051.2646055-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230915132051.2646055-1-mshavit@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230915211705.v8.6.Ice063dcf87d1b777a72e008d9e3406d2bcf6d876@changeid>
Subject: [PATCH v8 6/9] iommu/arm-smmu-v3: Move CD table to arm_smmu_master
From:   Michael Shavit <mshavit@google.com>
To:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     nicolinc@nvidia.com, jgg@nvidia.com, jean-philippe@linaro.org,
        robin.murphy@arm.com, will@kernel.org,
        Michael Shavit <mshavit@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dawei Li <set_pte_at@outlook.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tomas Krcka <krckatom@amazon.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With this change, each master will now own its own CD table instead of
sharing one with other masters attached to the same domain. Attaching a
stage 1 domain installs CD entries into the master's CD table. SVA
writes its CD entries into each master's CD table if the domain is
shared across masters.

Also add the device to the devices list before writing the CD to the
table so that SVA will know that the CD needs to be re-written to this
device's CD table as well if it decides to update the CD's ASID
concurrently with this function.

Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Michael Shavit <mshavit@google.com>
---

(no changes since v7)

Changes in v7:
- Update commit message to be more clear about locking purpose.
- Removed redundant newline

Changes in v6:
- Grab the asid lock while writing the RID CD to prevent a race with
  SVA.
- Add the device to the devices list before writing the CD to the table
  and installing the CD table.
- Undo arm_smmu_finalise_s1 rename
- Minor comment fix
- Consistently check cdtab pointer instead of cdtab_dma

Changes in v5:
- Clear the 0th CD entry when the domain is detached. Not clearing it
  caused a bug in arm_smmu_write_ctx_desc which doesn't expect the entry
  to already be set.

Changes in v4:
- Added comment about the cd_table's dependency on the iommu core's
  group mutex.
- Narrowed the range of code for which the domain's init_mutex is held
  on attach since it now only protects the arm_smmu_domain_finalise
  call.

Changes in v2:
- Allocate CD table when it's first needed instead of on probe.

Changes in v1:
- The master's CD table allocation was previously split to a different
  commit. This change now atomically allocates the new CD table, uses
  it, and removes the old one.

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 100 +++++++++++---------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   7 +-
 2 files changed, 58 insertions(+), 49 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d8919d3afdabb..25ce62d25732c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1025,7 +1025,7 @@ static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_master *master, u32 ssid)
 	unsigned int idx;
 	struct arm_smmu_l1_ctx_desc *l1_desc;
 	struct arm_smmu_device *smmu = master->smmu;
-	struct arm_smmu_ctx_desc_cfg *cdcfg = &master->domain->cd_table;
+	struct arm_smmu_ctx_desc_cfg *cdcfg = &master->cd_table;
 
 	if (cdcfg->s1fmt == STRTAB_STE_0_S1FMT_LINEAR)
 		return cdcfg->cdtab + ssid * CTXDESC_CD_DWORDS;
@@ -1062,7 +1062,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
 	u64 val;
 	bool cd_live;
 	__le64 *cdptr;
-	struct arm_smmu_ctx_desc_cfg *cd_table = &master->domain->cd_table;
+	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
 
 	if (WARN_ON(ssid >= (1 << cd_table->s1cdmax)))
 		return -E2BIG;
@@ -1125,14 +1125,13 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
 	return 0;
 }
 
-static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain,
-				    struct arm_smmu_master *master)
+static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master)
 {
 	int ret;
 	size_t l1size;
 	size_t max_contexts;
 	struct arm_smmu_device *smmu = master->smmu;
-	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->cd_table;
+	struct arm_smmu_ctx_desc_cfg *cdcfg = &master->cd_table;
 
 	cdcfg->stall_enabled = master->stall_enabled;
 	cdcfg->s1cdmax = master->ssid_bits;
@@ -1176,12 +1175,12 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain,
 	return ret;
 }
 
-static void arm_smmu_free_cd_tables(struct arm_smmu_domain *smmu_domain)
+static void arm_smmu_free_cd_tables(struct arm_smmu_master *master)
 {
 	int i;
 	size_t size, l1size;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->cd_table;
+	struct arm_smmu_device *smmu = master->smmu;
+	struct arm_smmu_ctx_desc_cfg *cdcfg = &master->cd_table;
 
 	if (cdcfg->l1_desc) {
 		size = CTXDESC_L2_ENTRIES * (CTXDESC_CD_DWORDS << 3);
@@ -1289,7 +1288,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 	if (smmu_domain) {
 		switch (smmu_domain->stage) {
 		case ARM_SMMU_DOMAIN_S1:
-			cd_table = &smmu_domain->cd_table;
+			cd_table = &master->cd_table;
 			break;
 		case ARM_SMMU_DOMAIN_S2:
 		case ARM_SMMU_DOMAIN_NESTED:
@@ -2057,14 +2056,10 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 
 	free_io_pgtable_ops(smmu_domain->pgtbl_ops);
 
-	/* Free the CD and ASID, if we allocated them */
+	/* Free the ASID or VMID */
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
-		struct arm_smmu_ctx_desc_cfg *cd_table = &smmu_domain->cd_table;
-
 		/* Prevent SVA from touching the CD while we're freeing it */
 		mutex_lock(&arm_smmu_asid_lock);
-		if (cd_table->cdtab)
-			arm_smmu_free_cd_tables(smmu_domain);
 		arm_smmu_free_asid(&smmu_domain->cd);
 		mutex_unlock(&arm_smmu_asid_lock);
 	} else {
@@ -2095,10 +2090,6 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	if (ret)
 		goto out_unlock;
 
-	ret = arm_smmu_alloc_cd_tables(smmu_domain, master);
-	if (ret)
-		goto out_free_asid;
-
 	cd->asid	= (u16)asid;
 	cd->ttbr	= pgtbl_cfg->arm_lpae_s1_cfg.ttbr;
 	cd->tcr		= FIELD_PREP(CTXDESC_CD_0_TCR_T0SZ, tcr->tsz) |
@@ -2110,17 +2101,9 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 			  CTXDESC_CD_0_TCR_EPD1 | CTXDESC_CD_0_AA64;
 	cd->mair	= pgtbl_cfg->arm_lpae_s1_cfg.mair;
 
-	ret = arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID, cd);
-	if (ret)
-		goto out_free_cd_tables;
-
 	mutex_unlock(&arm_smmu_asid_lock);
 	return 0;
 
-out_free_cd_tables:
-	arm_smmu_free_cd_tables(smmu_domain);
-out_free_asid:
-	arm_smmu_free_asid(cd);
 out_unlock:
 	mutex_unlock(&arm_smmu_asid_lock);
 	return ret;
@@ -2384,6 +2367,14 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 	master->domain = NULL;
 	master->ats_enabled = false;
 	arm_smmu_install_ste_for_dev(master);
+	/*
+	 * Clearing the CD entry isn't strictly required to detach the domain
+	 * since the table is uninstalled anyway, but it helps avoid confusion
+	 * in the call to arm_smmu_write_ctx_desc on the next attach (which
+	 * expects the entry to be empty).
+	 */
+	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 && master->cd_table.cdtab)
+		arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID, NULL);
 }
 
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
@@ -2418,23 +2409,14 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	if (!smmu_domain->smmu) {
 		smmu_domain->smmu = smmu;
 		ret = arm_smmu_domain_finalise(domain, master);
-		if (ret) {
+		if (ret)
 			smmu_domain->smmu = NULL;
-			goto out_unlock;
-		}
-	} else if (smmu_domain->smmu != smmu) {
-		ret = -EINVAL;
-		goto out_unlock;
-	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
-		   master->ssid_bits != smmu_domain->cd_table.s1cdmax) {
+	} else if (smmu_domain->smmu != smmu)
 		ret = -EINVAL;
-		goto out_unlock;
-	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
-		   smmu_domain->cd_table.stall_enabled !=
-			   master->stall_enabled) {
-		ret = -EINVAL;
-		goto out_unlock;
-	}
+
+	mutex_unlock(&smmu_domain->init_mutex);
+	if (ret)
+		return ret;
 
 	master->domain = smmu_domain;
 
@@ -2448,16 +2430,42 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	if (smmu_domain->stage != ARM_SMMU_DOMAIN_BYPASS)
 		master->ats_enabled = arm_smmu_ats_supported(master);
 
-	arm_smmu_install_ste_for_dev(master);
-
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
 	list_add(&master->domain_head, &smmu_domain->devices);
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
+	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
+		if (!master->cd_table.cdtab) {
+			ret = arm_smmu_alloc_cd_tables(master);
+			if (ret) {
+				master->domain = NULL;
+				goto out_list_del;
+			}
+		}
+
+		/*
+		 * Prevent SVA from concurrently modifying the CD or writing to
+		 * the CD entry
+		 */
+		mutex_lock(&arm_smmu_asid_lock);
+		ret = arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID, &smmu_domain->cd);
+		mutex_unlock(&arm_smmu_asid_lock);
+		if (ret) {
+			master->domain = NULL;
+			goto out_list_del;
+		}
+	}
+
+	arm_smmu_install_ste_for_dev(master);
+
 	arm_smmu_enable_ats(master);
+	return 0;
+
+out_list_del:
+	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+	list_del(&master->domain_head);
+	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
-out_unlock:
-	mutex_unlock(&smmu_domain->init_mutex);
 	return ret;
 }
 
@@ -2702,6 +2710,8 @@ static void arm_smmu_release_device(struct device *dev)
 	arm_smmu_detach_dev(master);
 	arm_smmu_disable_pasid(master);
 	arm_smmu_remove_master(master);
+	if (master->cd_table.cdtab)
+		arm_smmu_free_cd_tables(master);
 	kfree(master);
 }
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index d2fc0a9793e54..961205ba86d25 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -695,6 +695,8 @@ struct arm_smmu_master {
 	struct arm_smmu_domain		*domain;
 	struct list_head		domain_head;
 	struct arm_smmu_stream		*streams;
+	/* Locked by the iommu core using the group mutex */
+	struct arm_smmu_ctx_desc_cfg	cd_table;
 	unsigned int			num_streams;
 	bool				ats_enabled;
 	bool				stall_enabled;
@@ -721,11 +723,8 @@ struct arm_smmu_domain {
 
 	enum arm_smmu_domain_stage	stage;
 	union {
-		struct {
 		struct arm_smmu_ctx_desc	cd;
-		struct arm_smmu_ctx_desc_cfg	cd_table;
-		};
-		struct arm_smmu_s2_cfg	s2_cfg;
+		struct arm_smmu_s2_cfg		s2_cfg;
 	};
 
 	struct iommu_domain		domain;
-- 
2.42.0.459.ge4e396fd5e-goog

