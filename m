Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBC97A1FB8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 15:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235333AbjIONV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 09:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235281AbjIONVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 09:21:21 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE961BEB
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 06:21:16 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59b5a586da6so40496247b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 06:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694784075; x=1695388875; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rk7ktlAtF0nCHbLqPotJ0gZV9JuU0iwAIccoyoIY0ho=;
        b=ZqfIEoXYt3g2DlwYU/c8JMlhqkzOKqN0GKE2Z6NDkjwHgJwtLMpwqPRiUfx0LjJ0Ba
         4Rf5z9PBefcGD9v5FgMSAYhg8klz2/YNdKX7KblTrz/pnHnasQmhx6/Ie+NFFmPhyTKR
         UIusysQY/S+x0ThFqEdQQ5LvIjKtoTrQ59i4usC6xz/vpcUVqpxuZSPBi23l5D1ri1KB
         RrRkqDCIKBBJsIS09YPUOkI+cH5jumBU/smYx2/U/N5+BQDZi29qLvSij6LeOwG9pdcw
         KyuBVkYF3wgZiW/vJ7nSORpg7V76elF0T6foPIhS1pVW11XWEvwTKR7DNdfHnKD22mNp
         0uvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694784075; x=1695388875;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rk7ktlAtF0nCHbLqPotJ0gZV9JuU0iwAIccoyoIY0ho=;
        b=TRkezblnBFvWqi0aSx0W3m/QsakpgpzUpUnUtdUgqTjxW5+raEpOY9u3r/KMS5g8Vl
         fUTu29AxOHFNlvPLGMyhLfsluNvUF0Qn/wkQIdIu+Ct49oDYttK3+6xv/CTUj4YYSowc
         WLD3A6fgutbfbs6JC8aeqvTA75x1mNEDUSj99kw58Wfwhsd0GR8ZLIL7PC3m2njVdLxq
         2++KLRqqEDzQWlMkcFdcpTt6ghg/FcBADpEDqesrCmCF0yl6EOJZ3K6KZS0E0lE0WA7L
         IaHnOWlFc8ToCpOf8emChBqeKXJSCz8Nhjv6mDcyIC1fKZNfmNPtxJFc/II7g1eL5gLu
         vLRQ==
X-Gm-Message-State: AOJu0YyOPr9UMGRtPPpJ+dkCWIYV4B8xFFanGPKFdMOn7nTjUruK8Xyt
        i+uv+VSuJxityCa2xBL4+h7S4d5zn9ti
X-Google-Smtp-Source: AGHT+IEsuqKToSpy4ph0FwC6OFkGvqD7Y83L8+qnfS5gxUrdw7ksGLZPDiZXY/SFKnIwhMvxpamfdcWR4Dzk
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:47bc:d53f:1c50:a3f2])
 (user=mshavit job=sendgmr) by 2002:a05:690c:2c07:b0:595:7304:68e5 with SMTP
 id eo7-20020a05690c2c0700b00595730468e5mr131795ywb.0.1694784075473; Fri, 15
 Sep 2023 06:21:15 -0700 (PDT)
Date:   Fri, 15 Sep 2023 21:17:35 +0800
In-Reply-To: <20230915132051.2646055-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230915132051.2646055-1-mshavit@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230915211705.v8.4.I5aa89c849228794a64146cfe86df21fb71629384@changeid>
Subject: [PATCH v8 4/9] iommu/arm-smmu-v3: move stall_enabled to the cd table
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

A domain can be attached to multiple masters with different
master->stall_enabled values. The stall bit of a CD entry should follow
master->stall_enabled and has an inverse relationship with the
STE.S1STALLD bit.

The stall_enabled bit does not depend on any property of the domain, so
move it out of the arm_smmu_domain struct.  Move it to the CD table
struct so that it can fully describe how CD entries should be written to
it.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Michael Shavit <mshavit@google.com>
---

(no changes since v5)

Changes in v5:
- Reword commit

Changes in v2:
- Use a bitfield instead of a bool for stall_enabled

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 8 ++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 3 ++-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a9649eaeed8dc..0b06b58dce6ba 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1114,7 +1114,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 			FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid) |
 			CTXDESC_CD_0_V;
 
-		if (smmu_domain->stall_enabled)
+		if (smmu_domain->cd_table.stall_enabled)
 			val |= CTXDESC_CD_0_S;
 	}
 
@@ -1141,6 +1141,7 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain,
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->cd_table;
 
+	cdcfg->stall_enabled = master->stall_enabled;
 	cdcfg->s1cdmax = master->ssid_bits;
 	max_contexts = 1 << cdcfg->s1cdmax;
 
@@ -2101,8 +2102,6 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	if (ret)
 		goto out_unlock;
 
-	smmu_domain->stall_enabled = master->stall_enabled;
-
 	ret = arm_smmu_alloc_cd_tables(smmu_domain, master);
 	if (ret)
 		goto out_free_asid;
@@ -2443,7 +2442,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		ret = -EINVAL;
 		goto out_unlock;
 	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
-		   smmu_domain->stall_enabled != master->stall_enabled) {
+		   smmu_domain->cd_table.stall_enabled !=
+			   master->stall_enabled) {
 		ret = -EINVAL;
 		goto out_unlock;
 	}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index def1de62a59c6..287bef2d16aae 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -598,6 +598,8 @@ struct arm_smmu_ctx_desc_cfg {
 	u8				s1fmt;
 	/* log2 of the maximum number of CDs supported by this table */
 	u8				s1cdmax;
+	/* Whether CD entries in this table have the stall bit set. */
+	u8				stall_enabled:1;
 };
 
 struct arm_smmu_s2_cfg {
@@ -715,7 +717,6 @@ struct arm_smmu_domain {
 	struct mutex			init_mutex; /* Protects smmu pointer */
 
 	struct io_pgtable_ops		*pgtbl_ops;
-	bool				stall_enabled;
 	atomic_t			nr_ats_masters;
 
 	enum arm_smmu_domain_stage	stage;
-- 
2.42.0.459.ge4e396fd5e-goog

