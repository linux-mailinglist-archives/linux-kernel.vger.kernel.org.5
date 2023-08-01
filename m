Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F2A76BCA2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 20:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjHASkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 14:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjHASju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 14:39:50 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC7D30DD
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 11:39:30 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-583c49018c6so68043017b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 11:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690915169; x=1691519969;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F4Z9SBCgE40ttAK1rHrmRKU6D2Q6kRNaqcnUiFVuA6E=;
        b=qESZVEXtBgfMWPZtFaMnDa+sfp62iEaF1Awx0lzCFJTzIl4FVu5R1Ev71n7gJXnVqE
         z4s4wWwuwRRbGJI4cRq8NC0e4bnH0Ph5jTKbgK8ZciunR2D4VYTQPxL6p4HDNvrvq7H7
         JbG8VVCw0VFKwMWRrbZfWeFaFaLY3qoP+/itRTeFh0jw6cKQ2X3a9B4AjNARUOUFVlrS
         89fMYS6yGOU32o19b3annJ8aOK0jxtMDa1oLnx0FNg1k2INLK9t0h+cXUHwqgFBe8qdg
         lk/gTEW75uyZghOsqhT3Z3BVakrcWQRCvfsQRWuvKOwWFG+wnznq/+PPIePvTFN1WDyI
         hLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690915169; x=1691519969;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F4Z9SBCgE40ttAK1rHrmRKU6D2Q6kRNaqcnUiFVuA6E=;
        b=HaADFJQEyYnXU5ecq0CNxYey7uKk2J+qRlvoR9EThi8YXBoI/7a7BWaY4/gVQsxLP9
         AXcadfvIelaUbsn/DAwWR3fAs9+E2pgQ7WdNcPKR2Wwtw0BsZbEkcJMclNMnopUu/o/7
         OfjVGz6KQlpwXzRscZqx18jsi/aSxq7D12EOQ/i3gsb0TUoz0EBo9WS8ug3wREbMxwns
         nYOMzVgbVV88IperWE44ikjPf4u424YenxMBj/vqcHDM4AisglK37SIevwhlpP3lkUTS
         uLmIxo3IEI55plkSe+WsciUPgYPrYRsm+3f0TuGxmPccGMvwrxSN3S01LB6Y10GMTmhD
         E4Yw==
X-Gm-Message-State: ABy/qLZJxh4F92i2zke2b3Cd8jJ2hEwWxGwqZ1Q2qf2TJcoKIu+RuunS
        h44t5jBprf4acW1NGV2xHeJplmUZbynL
X-Google-Smtp-Source: APBJJlH+hB3HzyqFgyYlnbTt4uMwrP0Cs5cycyzhDtbrVVhb4LsO6lsQGYi9PYa4fLbIXxHGndpAqsZ8/xKs
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:a54:d53d:50e4:b5b8])
 (user=mshavit job=sendgmr) by 2002:a81:ac0e:0:b0:577:617b:f881 with SMTP id
 k14-20020a81ac0e000000b00577617bf881mr105464ywh.8.1690915169541; Tue, 01 Aug
 2023 11:39:29 -0700 (PDT)
Date:   Wed,  2 Aug 2023 02:35:25 +0800
In-Reply-To: <20230801183845.4026101-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230801183845.4026101-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230802023524.v3.8.I5ee79793b444ddb933e8bc1eb7b77e728d7f8350@changeid>
Subject: [PATCH v3 8/8] iommu/arm-smmu-v3: Rename cdcfg to cd_table
From:   Michael Shavit <mshavit@google.com>
To:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     robin.murphy@arm.com, will@kernel.org, jean-philippe@linaro.org,
        jgg@nvidia.com, nicolinc@nvidia.com,
        Michael Shavit <mshavit@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cdcfg is a confusing name, especially given other variables with the cfg
suffix in this driver. cd_table more clearly describes what is being
operated on.

Signed-off-by: Michael Shavit <mshavit@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---

Changes in v3:
- Commit message update

Changes in v2:
- New commit

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 66 ++++++++++-----------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 94922d4ff7be0..fc57155efb6b9 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1028,18 +1028,18 @@ static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_master *master, u32 ssid)
 	unsigned int idx;
 	struct arm_smmu_l1_ctx_desc *l1_desc;
 	struct arm_smmu_device *smmu = master->smmu;
-	struct arm_smmu_ctx_desc_cfg *cdcfg = &master->cd_table;
+	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
 
-	if (!cdcfg->l1_desc)
-		return cdcfg->cdtab + ssid * CTXDESC_CD_DWORDS;
+	if (!cd_table->l1_desc)
+		return cd_table->cdtab + ssid * CTXDESC_CD_DWORDS;
 
 	idx = ssid >> CTXDESC_SPLIT;
-	l1_desc = &cdcfg->l1_desc[idx];
+	l1_desc = &cd_table->l1_desc[idx];
 	if (!l1_desc->l2ptr) {
 		if (arm_smmu_alloc_cd_leaf_table(smmu, l1_desc))
 			return NULL;
 
-		l1ptr = cdcfg->cdtab + idx * CTXDESC_L1_DESC_DWORDS;
+		l1ptr = cd_table->cdtab + idx * CTXDESC_L1_DESC_DWORDS;
 		arm_smmu_write_cd_l1_desc(l1ptr, l1_desc);
 		/* An invalid L1CD can be cached */
 		arm_smmu_sync_cd(master, ssid, false);
@@ -1134,33 +1134,33 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master)
 	size_t l1size;
 	size_t max_contexts;
 	struct arm_smmu_device *smmu = master->smmu;
-	struct arm_smmu_ctx_desc_cfg *cdcfg = &master->cd_table;
+	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
 
-	cdcfg->stall_enabled = master->stall_enabled;
-	cdcfg->max_cds_bits = master->ssid_bits;
-	max_contexts = 1 << cdcfg->max_cds_bits;
+	cd_table->stall_enabled = master->stall_enabled;
+	cd_table->max_cds_bits = master->ssid_bits;
+	max_contexts = 1 << cd_table->max_cds_bits;
 
 	if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB) ||
 	    max_contexts <= CTXDESC_L2_ENTRIES) {
-		cdcfg->num_l1_ents = max_contexts;
+		cd_table->num_l1_ents = max_contexts;
 
 		l1size = max_contexts * (CTXDESC_CD_DWORDS << 3);
 	} else {
-		cdcfg->num_l1_ents = DIV_ROUND_UP(max_contexts,
+		cd_table->num_l1_ents = DIV_ROUND_UP(max_contexts,
 						  CTXDESC_L2_ENTRIES);
 
-		cdcfg->l1_desc = devm_kcalloc(smmu->dev, cdcfg->num_l1_ents,
-					      sizeof(*cdcfg->l1_desc),
+		cd_table->l1_desc = devm_kcalloc(smmu->dev, cd_table->num_l1_ents,
+					      sizeof(*cd_table->l1_desc),
 					      GFP_KERNEL);
-		if (!cdcfg->l1_desc)
+		if (!cd_table->l1_desc)
 			return -ENOMEM;
 
-		l1size = cdcfg->num_l1_ents * (CTXDESC_L1_DESC_DWORDS << 3);
+		l1size = cd_table->num_l1_ents * (CTXDESC_L1_DESC_DWORDS << 3);
 	}
 
-	cdcfg->cdtab = dmam_alloc_coherent(smmu->dev, l1size, &cdcfg->cdtab_dma,
+	cd_table->cdtab = dmam_alloc_coherent(smmu->dev, l1size, &cd_table->cdtab_dma,
 					   GFP_KERNEL);
-	if (!cdcfg->cdtab) {
+	if (!cd_table->cdtab) {
 		dev_warn(smmu->dev, "failed to allocate context descriptor\n");
 		ret = -ENOMEM;
 		goto err_free_l1;
@@ -1169,9 +1169,9 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master)
 	return 0;
 
 err_free_l1:
-	if (cdcfg->l1_desc) {
-		devm_kfree(smmu->dev, cdcfg->l1_desc);
-		cdcfg->l1_desc = NULL;
+	if (cd_table->l1_desc) {
+		devm_kfree(smmu->dev, cd_table->l1_desc);
+		cd_table->l1_desc = NULL;
 	}
 	return ret;
 }
@@ -1181,30 +1181,30 @@ static void arm_smmu_free_cd_tables(struct arm_smmu_master *master)
 	int i;
 	size_t size, l1size;
 	struct arm_smmu_device *smmu = master->smmu;
-	struct arm_smmu_ctx_desc_cfg *cdcfg = &master->cd_table;
+	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
 
-	if (cdcfg->l1_desc) {
+	if (cd_table->l1_desc) {
 		size = CTXDESC_L2_ENTRIES * (CTXDESC_CD_DWORDS << 3);
 
-		for (i = 0; i < cdcfg->num_l1_ents; i++) {
-			if (!cdcfg->l1_desc[i].l2ptr)
+		for (i = 0; i < cd_table->num_l1_ents; i++) {
+			if (!cd_table->l1_desc[i].l2ptr)
 				continue;
 
 			dmam_free_coherent(smmu->dev, size,
-					   cdcfg->l1_desc[i].l2ptr,
-					   cdcfg->l1_desc[i].l2ptr_dma);
+					   cd_table->l1_desc[i].l2ptr,
+					   cd_table->l1_desc[i].l2ptr_dma);
 		}
-		devm_kfree(smmu->dev, cdcfg->l1_desc);
-		cdcfg->l1_desc = NULL;
+		devm_kfree(smmu->dev, cd_table->l1_desc);
+		cd_table->l1_desc = NULL;
 
-		l1size = cdcfg->num_l1_ents * (CTXDESC_L1_DESC_DWORDS << 3);
+		l1size = cd_table->num_l1_ents * (CTXDESC_L1_DESC_DWORDS << 3);
 	} else {
-		l1size = cdcfg->num_l1_ents * (CTXDESC_CD_DWORDS << 3);
+		l1size = cd_table->num_l1_ents * (CTXDESC_CD_DWORDS << 3);
 	}
 
-	dmam_free_coherent(smmu->dev, l1size, cdcfg->cdtab, cdcfg->cdtab_dma);
-	cdcfg->cdtab_dma = 0;
-	cdcfg->cdtab = NULL;
+	dmam_free_coherent(smmu->dev, l1size, cd_table->cdtab, cd_table->cdtab_dma);
+	cd_table->cdtab_dma = 0;
+	cd_table->cdtab = NULL;
 }
 
 bool arm_smmu_free_asid(struct arm_smmu_ctx_desc *cd)
-- 
2.41.0.585.gd2178a4bd4-goog

