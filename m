Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33500769376
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjGaKuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbjGaKtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:49:35 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4DD1BD2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 03:49:18 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58456435437so52986397b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 03:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690800557; x=1691405357;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YJP5V5vq+SKeEm3Hg6wbMxauuZX6cc204/bKb76wukw=;
        b=kq+q2jNzWK9y2fTrKQKudw+D1sNOrIVWQZ433hIGaziSm+xkYYQUEaHicxjLKL+vXr
         Y60Z/C+zPA1NJHn5J+uYrYdgYnnYXEB4MOc3VyvA80v8WCDt0hqYT8HqIX/lZIpHv0Fi
         knSZro52XgdVS+IX0sGzvA+FLf0XSvfxp6ZK0pE92iSym9jLJIIYYfNidymeo90TPfqq
         ZwtlEms+je4ryDy1fPVy5cfyoIHlN0JwAC89gVcQLE9WuTDTnuDKG1E3ebIjUGdZ2fAQ
         z39MYenrRrTEBHmmxEaeoMU9R1p9+TyXTkN35woawfCMlGfvdmpXnnSOnuM8B7lDrJIk
         Rbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690800557; x=1691405357;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YJP5V5vq+SKeEm3Hg6wbMxauuZX6cc204/bKb76wukw=;
        b=ZHVjmkkdV45VKrdBTAz2hdDzjXjG6w6txlwmeyhfIHsIOsVamj3EkiJkTm/7UqecXS
         6au7d89LYKYQLSoLb7Ad0pV0dU60E/68JzH5vTX2yBJ9E8QtYe6ooB7rydFR38P3o8TF
         18mZncWrPnaCDZ3OzNLoBOZQBUFoz55D9OYpDF7h/n7AGLWXeaCG1MvAwr+vFovoGqNQ
         WhykC8cjZfzN8etJEOannYMU02q++lXQ5GP+ZPhKZC64XHdsp6qSjBMGxVmhszXM0tLF
         Brhf+NfGHXZvl7hPK/000xe0KD2RAX7tw5CTmU7BUv1IJDJicc7AN3wDfGMztEIU+eU3
         7Veg==
X-Gm-Message-State: ABy/qLZ9rNn6KAHfX+fEo5U89FzknHmqM997oEuPXzDF5e7Rtq0C8AXr
        nejuguf+lz3R7El+NI0ZnooHulcFbonw
X-Google-Smtp-Source: APBJJlE1H3F2CeMuoWpIfLKKH+MnAhgEy99WDYutJ9HDJR3O7RsBEdQ8yywOP9MxdJcOAewdmqcg9DCpyeuz
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:affc:ad1d:5cbb:3c6a])
 (user=mshavit job=sendgmr) by 2002:a25:e743:0:b0:d10:5b67:843c with SMTP id
 e64-20020a25e743000000b00d105b67843cmr50706ybh.4.1690800557330; Mon, 31 Jul
 2023 03:49:17 -0700 (PDT)
Date:   Mon, 31 Jul 2023 18:48:18 +0800
In-Reply-To: <20230731104833.800114-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230731104833.800114-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230731184817.v2.8.I5ee79793b444ddb933e8bc1eb7b77e728d7f8350@changeid>
Subject: [PATCH v2 8/8] iommu/arm-smmu-v3: Rename cdcfg to cd_table
From:   Michael Shavit <mshavit@google.com>
To:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     will@kernel.org, robin.murphy@arm.com, nicolinc@nvidia.com,
        jgg@nvidia.com, jean-philippe@linaro.org,
        Michael Shavit <mshavit@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

since cdcfg sounds like it represents a CD entry when it's in fact a CD
table.

Signed-off-by: Michael Shavit <mshavit@google.com>
---

Changes in v2:
- New commit

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 66 ++++++++++-----------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 2949e1ad3914a..b8e6f056bf36d 100644
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

