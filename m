Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658A1774670
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbjHHS4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjHHS4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:56:22 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A0C1667A1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:15:10 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d47a02fc63fso4320990276.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 10:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691514910; x=1692119710;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8kAnQzEdZvwUszc/Yra8uu5YltC92ywc9EvJ8VT09LQ=;
        b=oI/dqHd30VJau7uUvo843Y9Abtz75Eci2/yr/d2MWGmRYaIF60x7Uo8BVsyA5UL+iv
         GvrSQZ+d3MFahwdi8bnSc7+Cqzxr8iZVBy9h3GD7ChJD4fZ9psjBnVnh8ZaD2d4JxO86
         x2QdqEYrZlm7bmKtB3dYzVaFtxnwPYQqpiREwDBE0j4CZ5Icp3P4hEdeYq+ZNurZstpC
         4LjRrQtNw09UPeWPtfpPMjMyKmATqeiI0IDLi61Iu8/xVs1eqr7TtVKOIICwnVElUlp1
         E7cCzyG/1JPWqrB1Rsnf61nL0pVh8Oajux04XTUcsEVJKFLrOxAD3BBXDRzWBxicH0AI
         kApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691514910; x=1692119710;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8kAnQzEdZvwUszc/Yra8uu5YltC92ywc9EvJ8VT09LQ=;
        b=Vtl7tOpEtM+Tgn5aYpdoHXW+0mej22EuANAyLPNYUqPFCCQxXLzfP+mK8Ejo4vzUZ0
         nuFcmcYobzZDAvvCnh/2RjY9zkeB/CdKaJHzIIKYQm9FK7wMuwdkYJrC+SkqF87DOGyh
         v+/SfY+fh9Td8NkjSQcYQ8Ig2NNxWtCJyIaRSjqDnRP+feYgXDCUzBDQ1TBzMMz3yznj
         7NQi9is1/haR2Hhy0dC7Wso2RzvKny/ClO58oYV/OzyYXi5HTncJTdimebHCVvT560tD
         WMGKIn7d6MBhxGJfBbQENt3q8HJsmS83PA3EjoQUbXFjmMAfpkp4ZhoGDQWvfMbXcIfi
         Detw==
X-Gm-Message-State: AOJu0YzehMSEMZKBchOBdMb0h1c21di7HS9pVPSwS2dyW/jq9N6U8wK/
        iPsRGLnO8WRzqkFckdX3m6keO8cW2/RO
X-Google-Smtp-Source: AGHT+IEMJeatprXvebM/DOZlLv0j3Dy4OuBMcAUr1GM1vtFLgnUQJaRUOVv2HdwNOFyJeYZpSyEmJg4bow4Z
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:986a:71d7:3b1e:ac1d])
 (user=mshavit job=sendgmr) by 2002:a05:6902:1345:b0:d5d:6bfe:76d6 with SMTP
 id g5-20020a056902134500b00d5d6bfe76d6mr3195ybu.8.1691514909886; Tue, 08 Aug
 2023 10:15:09 -0700 (PDT)
Date:   Wed,  9 Aug 2023 01:11:59 +0800
In-Reply-To: <20230808171446.2187795-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230808171446.2187795-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230809011204.v5.3.I875254464d044a8ce8b3a2ad6beb655a4a006456@changeid>
Subject: [PATCH v5 3/9] iommu/arm-smmu-v3: Encapsulate ctx_desc_cfg init in alloc_cd_tables
From:   Michael Shavit <mshavit@google.com>
To:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     will@kernel.org, robin.murphy@arm.com, nicolinc@nvidia.com,
        jgg@nvidia.com, jean-philippe@linaro.org,
        Michael Shavit <mshavit@google.com>
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

This is slighlty cleaner: arm_smmu_ctx_desc_cfg is initialized in a
single function instead of having pieces set ahead-of time by its caller.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Michael Shavit <mshavit@google.com>
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
2.41.0.640.ga95def55d0-goog

