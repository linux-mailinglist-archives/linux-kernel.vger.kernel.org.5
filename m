Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2DD176BC9A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 20:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjHASjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 14:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjHASjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 14:39:10 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938B0268D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 11:39:07 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d3563cb3748so1769973276.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 11:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690915146; x=1691519946;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JdJVm/jEcegurWxMLywzO5qAAqQ1pj5h79mr3KehF7s=;
        b=7Pof5p/ruCK44RZ9XO2ZDH7mLpC+nNWDaepCVNuu4v6H5JAlestoM3MVfwPeyz7fZf
         xY9EaG14OzQ52SKikb3ay09ybDg1BFoZwMEqyiMoOKOKeLsCJq+l2sfgM47q1cAz/S8W
         gHTrhxHyg7pROOPUFPj6O5vXGaoikN6UCSbBgKJm6IirRnPb9bSWHpZHZN2KPc21FhNE
         6hrGEC9dN6jNwmGtnhM/g3S5MV+y7LV0DgsfyYbUm43P2lVELq/lBC0DdMfPQuPCPW/C
         HmE+dVGr7b4xAyHFz2rB72daFWuTW14VrHF9VUBGzlIDn7La4lGXxlKysjHVxZ/9y43m
         lShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690915146; x=1691519946;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JdJVm/jEcegurWxMLywzO5qAAqQ1pj5h79mr3KehF7s=;
        b=FYUrOZ6Hk+eexFp5/yeCYqNqYGwBX3m2xKXS0cAZNlWPbyP6r7HZWvJfRO3jsS5La4
         R8S8jA0FKPL2kxh7WEsoLuFBEH+SMK9GVu53y2/rMdFxI5RhfKQ2EDWfDAZZbnVq+Txc
         QDUwLREwLC87hphmbO+79fMmSWLOxs5GQSiDMR+vzrZcKwzRO/3RFCQ5MnlI5tzPKrjs
         dy2L2Tj/7nSbUncjlUXdi3ft6sD1NG3Zb8/W6zV4AXWJd9BPmb3CeofZlkF6ZGOc7rYz
         BM/TmHSN+wiGp4krb2iFqWUF2YhlXXQoWZt0QoeR7DQpI1JVnvzLCZUXCmNFyqs4Xatx
         P9Gg==
X-Gm-Message-State: ABy/qLbjPxsFJVXZZc192Oq3j965pVySrOSAsDWHyDAQxbcGoCIbrKEK
        HXSP0Q06aukLIOTxMB/A0hOQlhhzMGDV
X-Google-Smtp-Source: APBJJlHCy/eD1nfcypDGAcoiCb+YNa0Afat43VBJmS6hV3eCZMQEtRQ92r8y5gfPrjhq8h5mdGvrfXC8oJ22
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:a54:d53d:50e4:b5b8])
 (user=mshavit job=sendgmr) by 2002:a25:86cb:0:b0:d13:856b:c10a with SMTP id
 y11-20020a2586cb000000b00d13856bc10amr93266ybm.3.1690915146152; Tue, 01 Aug
 2023 11:39:06 -0700 (PDT)
Date:   Wed,  2 Aug 2023 02:35:20 +0800
In-Reply-To: <20230801183845.4026101-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230801183845.4026101-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230802023524.v3.3.I875254464d044a8ce8b3a2ad6beb655a4a006456@changeid>
Subject: [PATCH v3 3/8] iommu/arm-smmu-v3: Encapsulate ctx_desc_cfg init in alloc_cd_tables
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

This is slighlty cleaner: arm_smmu_ctx_desc_cfg is initialized in a
single function instead of having pieces set ahead-of time by its caller.

Signed-off-by: Michael Shavit <mshavit@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---

(no changes since v1)

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index ded613aedbb04..fe4b19c3b8dee 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1132,7 +1132,8 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 	return 0;
 }
 
-static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain)
+static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain,
+				    struct arm_smmu_master *master)
 {
 	int ret;
 	size_t l1size;
@@ -1140,6 +1141,7 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain)
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->cd_table;
 
+	cdcfg->max_cds_bits = master->ssid_bits;
 	max_contexts = 1 << cdcfg->max_cds_bits;
 
 	if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB) ||
@@ -2107,7 +2109,6 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	int ret;
 	u32 asid;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_ctx_desc_cfg *cd_table = &smmu_domain->cd_table;
 	struct arm_smmu_ctx_desc *cd = &smmu_domain->cd;
 	typeof(&pgtbl_cfg->arm_lpae_s1_cfg.tcr) tcr = &pgtbl_cfg->arm_lpae_s1_cfg.tcr;
 
@@ -2120,11 +2121,9 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	if (ret)
 		goto out_unlock;
 
-	cd_table->max_cds_bits = master->ssid_bits;
-
 	smmu_domain->stall_enabled = master->stall_enabled;
 
-	ret = arm_smmu_alloc_cd_tables(smmu_domain);
+	ret = arm_smmu_alloc_cd_tables(smmu_domain, master);
 	if (ret)
 		goto out_free_asid;
 
-- 
2.41.0.585.gd2178a4bd4-goog

