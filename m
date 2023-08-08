Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56146774678
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjHHS5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbjHHS4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:56:43 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA941CCE1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:15:28 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5867fe87d16so69388357b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 10:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691514927; x=1692119727;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DHC0KhIFpW5NTjYdIfQpCvuClzcsgZwi0HrA23/4P2Y=;
        b=JvC5MZkolQL3+jANntlSYMOylNcISlimU/y0d4N3dr5wEcjfYYgltrYjhiES7mOl2Y
         Ov/twqwpI1VT7nGpJ10HSecukMP7JjhRsaHzoTuSY1uHllGHq5QV8Dw8VcjFc88LHfCC
         yvqIHBD+L229K+5h3r44DhySpf/5xangjP4KGU7gIWLnEP6tyARGBxNLrJMIGnVEuNVD
         FCnzoPQw6nydn60CxXmNoDtrQ4g4D19DCMYPAeY/N+hStGbwQ6GR2qztXJI3fp3Gq5iA
         1URmWGqiUKNT6EzYQz+0P5dUXpiIABYzrYuZYvbAnw9bFLBRsz++gB5gDsabSg8x1Dg7
         wP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691514927; x=1692119727;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DHC0KhIFpW5NTjYdIfQpCvuClzcsgZwi0HrA23/4P2Y=;
        b=M1T/FbIU2LJuNrZ5D8CGIFctNkNSM2IxD09a38H2LUOZAG0F4ItJW08TmLURMMcYnj
         HezOZQHfq7XOh8CoJ1Sc1lLqZN4Yt+6XGNfYQyg8UkIFSchP66WCwY/0Hc5yHB7L/cu2
         2kz+4L7H+/63T0IcffqsWBQjEfr/ei2t6tE/WeOhhRJTsfBRWDL63RSHfGD3Zq3IIZ20
         OjQHSZ2xv7atsGH4Z1m9LDlaZrPetoDJ0sewBbYcnSuqn7UtjzGUxaENKBM7mb9j4rzy
         IxbOWFAPgA/GYk//UT9cTuxcYwaVNtkw8LfHKIRr3od6UlvCeuvdhIIDCR+3OR0fVYZ9
         jCSQ==
X-Gm-Message-State: AOJu0YxDnD2wVN7ukcorkpKaELJVRKrOPW1inhnOY97hJB8lRuZIGeO+
        lVtTJOXktlzNwTuXai7jJ5kgoxeE0Spv
X-Google-Smtp-Source: AGHT+IG7laxc61w6Ym0eBdUMWuNThcVfKU8hYxqNr7YAQlpUKSbawwC1KUfs2n737hePYJJZMC7AEV8t5FYY
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:986a:71d7:3b1e:ac1d])
 (user=mshavit job=sendgmr) by 2002:a25:e70a:0:b0:cb1:918b:d19b with SMTP id
 e10-20020a25e70a000000b00cb1918bd19bmr2934ybh.0.1691514927517; Tue, 08 Aug
 2023 10:15:27 -0700 (PDT)
Date:   Wed,  9 Aug 2023 01:12:03 +0800
In-Reply-To: <20230808171446.2187795-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230808171446.2187795-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230809011204.v5.7.Iff18df41564b9df82bf40b3ec7af26b87f08ef6e@changeid>
Subject: [PATCH v5 7/9] iommu/arm-smmu-v3: Cleanup arm_smmu_domain_finalise
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

Remove unused master parameter now that the CD table is allocated
elsewhere.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Michael Shavit <mshavit@google.com>
---

Changes in v5:
- New commit

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 3f32f9a191a5f..f5ad386cc8760 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2092,7 +2092,6 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 }
 
 static int arm_smmu_domain_finalise_cd(struct arm_smmu_domain *smmu_domain,
-				       struct arm_smmu_master *master,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
 	int ret;
@@ -2130,7 +2129,6 @@ static int arm_smmu_domain_finalise_cd(struct arm_smmu_domain *smmu_domain,
 }
 
 static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
-				       struct arm_smmu_master *master,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
 	int vmid;
@@ -2155,8 +2153,7 @@ static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
 	return 0;
 }
 
-static int arm_smmu_domain_finalise(struct iommu_domain *domain,
-				    struct arm_smmu_master *master)
+static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 {
 	int ret;
 	unsigned long ias, oas;
@@ -2164,7 +2161,6 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
 	struct io_pgtable_cfg pgtbl_cfg;
 	struct io_pgtable_ops *pgtbl_ops;
 	int (*finalise_stage_fn)(struct arm_smmu_domain *,
-				 struct arm_smmu_master *,
 				 struct io_pgtable_cfg *);
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
@@ -2216,7 +2212,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
 	domain->geometry.aperture_end = (1UL << pgtbl_cfg.ias) - 1;
 	domain->geometry.force_aperture = true;
 
-	ret = finalise_stage_fn(smmu_domain, master, &pgtbl_cfg);
+	ret = finalise_stage_fn(smmu_domain, &pgtbl_cfg);
 	if (ret < 0) {
 		free_io_pgtable_ops(pgtbl_ops);
 		return ret;
@@ -2428,7 +2424,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	if (!smmu_domain->smmu) {
 		smmu_domain->smmu = smmu;
-		ret = arm_smmu_domain_finalise(domain, master);
+		ret = arm_smmu_domain_finalise(domain);
 		if (ret)
 			smmu_domain->smmu = NULL;
 	} else if (smmu_domain->smmu != smmu)
-- 
2.41.0.640.ga95def55d0-goog

