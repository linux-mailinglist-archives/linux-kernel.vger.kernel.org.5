Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3571A78F223
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 19:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjHaRqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 13:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346970AbjHaRqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 13:46:49 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6709E6E
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 10:46:18 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58e4d2b7d16so14055127b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 10:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693503978; x=1694108778; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HUyVKDl0lhQ7W0ufBBYFd9SmCuZO/76W4U+SUNg412A=;
        b=2pC6UwRq3dLfYZLDtVd+m9INKixPp5qGsfYqrbyt3oIF57NuiRySvo3DcXVskB10U9
         p3Jjxqfjj2Ktxu+m0V0/hliCaAhF36oR4wK6Pr/VLcKyLr9tPuoY28jEquopRliByldh
         zz8jkREvP7q+3SsYRDuEmJnjQ6oNl7XHI41Wtw3h0/Un0dHu0lKUPYnSMcyq0Gsr2nBj
         5XGuXydcVdFzbpkLvQ+Ks/o+60bkJRluSNg40VB8zFOmJkBKvyoUMK8oCLKxw3NlVECa
         9E7mKEaf2dDEb0JFUbTLRk4CKXCRZqFRxQolGpdKNxNqv8g4R/Ih0ZmhxnTPPlhExOxa
         6Ukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693503978; x=1694108778;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HUyVKDl0lhQ7W0ufBBYFd9SmCuZO/76W4U+SUNg412A=;
        b=kiOuQ23QHMeuYQ/jztfrWV/7HvsqvfjhMy9iA2SCh4rl+sbCjKIb7ZHqd3WaXmg7r6
         W7JYoFy0upqO2NJPxSXgNNC0WynfP6tEB4r6pGoQ07KaI3ZNF39x+y6OqmAPv+hADegD
         r7nhSt3zm39lGS8irH5YbnOYgaCz41nXaY1HA3/Y8Vyke1wrMVf8ZNu5JDj2lawl45fX
         xnc6C6LHi1lCqPLV8O5ebVoWOWvWid/BaEFAmKc/zLfaa4zIiBn8Ctk3BpE2IfLhRBu8
         /UkAGug+XsMzY14t8V5ySY9ds3Pc32p+R++yjNIK+98h7iQO8VrLLkBQo2v4omqEx3+7
         lRyQ==
X-Gm-Message-State: AOJu0YyA4bmMynOcmrM0Fsrsh79RIJe6EJKpMOgUCDKI9CDSmECTAoLJ
        E7+yCYa8e1URZ01gvNqtqHn9LOCdAzDO
X-Google-Smtp-Source: AGHT+IEMJF3dc+25Kv4DjBVppSk/8Bx2EoVHGZaHW80P0+xgsookLYMJvqJ8CPuNFyU7AvC8AVo2BLS8XijP
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:1a0a:7338:4a5a:5f83])
 (user=mshavit job=sendgmr) by 2002:a81:ae1f:0:b0:592:7a39:e4b4 with SMTP id
 m31-20020a81ae1f000000b005927a39e4b4mr3028ywh.6.1693503977969; Thu, 31 Aug
 2023 10:46:17 -0700 (PDT)
Date:   Fri,  1 Sep 2023 01:44:36 +0800
In-Reply-To: <20230831174536.103472-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230831174536.103472-1-mshavit@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230901014413.v7.7.Iff18df41564b9df82bf40b3ec7af26b87f08ef6e@changeid>
Subject: [PATCH v7 7/9] iommu/arm-smmu-v3: Cleanup arm_smmu_domain_finalise
From:   Michael Shavit <mshavit@google.com>
To:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org,
        jgg@nvidia.com, nicolinc@nvidia.com,
        Michael Shavit <mshavit@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Yicong Yang <yangyicong@hisilicon.com>
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

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Michael Shavit <mshavit@google.com>
---

(no changes since v5)

Changes in v5:
- New commit

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index bcc94a67640d6..8d177ed550054 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2090,7 +2090,6 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 }
 
 static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
-				       struct arm_smmu_master *master,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
 	int ret;
@@ -2128,7 +2127,6 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 }
 
 static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
-				       struct arm_smmu_master *master,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
 	int vmid;
@@ -2153,8 +2151,7 @@ static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
 	return 0;
 }
 
-static int arm_smmu_domain_finalise(struct iommu_domain *domain,
-				    struct arm_smmu_master *master)
+static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 {
 	int ret;
 	unsigned long ias, oas;
@@ -2162,7 +2159,6 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
 	struct io_pgtable_cfg pgtbl_cfg;
 	struct io_pgtable_ops *pgtbl_ops;
 	int (*finalise_stage_fn)(struct arm_smmu_domain *,
-				 struct arm_smmu_master *,
 				 struct io_pgtable_cfg *);
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
@@ -2214,7 +2210,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
 	domain->geometry.aperture_end = (1UL << pgtbl_cfg.ias) - 1;
 	domain->geometry.force_aperture = true;
 
-	ret = finalise_stage_fn(smmu_domain, master, &pgtbl_cfg);
+	ret = finalise_stage_fn(smmu_domain, &pgtbl_cfg);
 	if (ret < 0) {
 		free_io_pgtable_ops(pgtbl_ops);
 		return ret;
@@ -2424,7 +2420,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	if (!smmu_domain->smmu) {
 		smmu_domain->smmu = smmu;
-		ret = arm_smmu_domain_finalise(domain, master);
+		ret = arm_smmu_domain_finalise(domain);
 		if (ret)
 			smmu_domain->smmu = NULL;
 	} else if (smmu_domain->smmu != smmu)
-- 
2.42.0.283.g2d96d420d3-goog

