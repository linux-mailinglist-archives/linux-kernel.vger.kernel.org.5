Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5C276E557
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 12:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbjHCKPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 06:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235329AbjHCKOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 06:14:45 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1A33C38
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 03:14:31 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5844a99c268so8276687b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 03:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691057670; x=1691662470;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DLa2HUSCTWFTI0X2o3f102hvfCfHBN0tK5dUlzxCyIc=;
        b=a6jeCmc4bN/A2ChgfTwyYgnoSOjzynwD0hKdab97fxFiQfSeGipLdBD8vrco7vSA/g
         QOt22+Zq6NX8xu96ciZpkKp4t5eOm+ZaDlxM6cwB96C4VYR8qRCGUhy2F8aLjmrZX7BK
         lgPFNpSbNKKYhMqQtdmKUOe2mtgb5tKgGOgDmq9z4UUNQSfYVDQitc/nmlYflTh8r71x
         WHXjiURsl1a7dnvRWS7u0ZIp9NkZQ7glmppXYAaIMaXGtS+Nd08ghmzEF5M9LzrJXJmc
         KqvH0cWbBfcQls+aRNNfkuVmAcdzik2ZO7MoKwsaPcJ6aKQIAFn69fAb4koX4ECdcQQ0
         esCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691057670; x=1691662470;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DLa2HUSCTWFTI0X2o3f102hvfCfHBN0tK5dUlzxCyIc=;
        b=Uor52Kf4esgcfSWHSLZuV0yL7N0wU5fhsALmCqOd/PItm/wh/eaXyigyW5qXMIzqbZ
         UU/lSckMBI3FW6fiiQx3oq3o0ZZaX3lZs8Oh/yF9js24QBjdor5pAST7d1+YKpUApDos
         HnhdoJK2HCJgxb36DtY6ReC3rc2j3o9eRWsJl7lq8fMC7FjAye6lyUSNpgE1+m34bjy+
         aP1DbRi/UvUv/r30sxKG2nJykDmTujoS5Ye+h3/NZm2wI1pA3COCxyoO90AcbpReC8q2
         o9c6ZdZmU6amhDsJniGyEzSvr7U+DjKStfkTDMsfJ9xuugP9AuE9lEQCh/oWI0M3H6GN
         cWMQ==
X-Gm-Message-State: ABy/qLZDcPHXNU4IhfcZzfZQLOS0Dnu1Y95dQiFF6WnzdUpDWxqMO7Kg
        28o9oYFoSMvsIc2jVLWtojlLF9EqGXt2
X-Google-Smtp-Source: APBJJlH6RK3TEtZXk1xM04qItMlyJrFzxnsOEH42ZDuBzo1V5QaUS9nSNVNbePa1fe9X8ZQRJ7o7+n5wLnH3
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:39d1:8774:b733:6210])
 (user=mshavit job=sendgmr) by 2002:a81:b625:0:b0:586:50cf:e13f with SMTP id
 u37-20020a81b625000000b0058650cfe13fmr100164ywh.1.1691057670282; Thu, 03 Aug
 2023 03:14:30 -0700 (PDT)
Date:   Thu,  3 Aug 2023 18:12:26 +0800
In-Reply-To: <20230803101351.1561031-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230803101351.1561031-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230803181225.v5.6.Iff18df41564b9df82bf40b3ec7af26b87f08ef6e@changeid>
Subject: [PATCH v5 6/6] iommu/arm-smmu-v3: Cleanup arm_smmu_domain_finalise
From:   Michael Shavit <mshavit@google.com>
To:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     baolu.lu@linux.intel.com, will@kernel.org, jgg@nvidia.com,
        jean-philippe@linaro.org, robin.murphy@arm.com,
        nicolinc@nvidia.com, Michael Shavit <mshavit@google.com>
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

Remove unused master parameter now that the CD table is allocated
elsewhere.

Signed-off-by: Michael Shavit <mshavit@google.com>
---

(no changes since v1)
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5fd6c4d4f0ae4..db8fd4b3591b5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2129,7 +2129,6 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 }
 
 static int arm_smmu_domain_finalise_cd(struct arm_smmu_domain *smmu_domain,
-				       struct arm_smmu_master *master,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
 	int ret;
@@ -2167,7 +2166,6 @@ static int arm_smmu_domain_finalise_cd(struct arm_smmu_domain *smmu_domain,
 }
 
 static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
-				       struct arm_smmu_master *master,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
 	int vmid;
@@ -2192,8 +2190,7 @@ static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
 	return 0;
 }
 
-static int arm_smmu_domain_finalise(struct iommu_domain *domain,
-				    struct arm_smmu_master *master)
+static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 {
 	int ret;
 	unsigned long ias, oas;
@@ -2201,7 +2198,6 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
 	struct io_pgtable_cfg pgtbl_cfg;
 	struct io_pgtable_ops *pgtbl_ops;
 	int (*finalise_stage_fn)(struct arm_smmu_domain *,
-				 struct arm_smmu_master *,
 				 struct io_pgtable_cfg *);
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
@@ -2253,7 +2249,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
 	domain->geometry.aperture_end = (1UL << pgtbl_cfg.ias) - 1;
 	domain->geometry.force_aperture = true;
 
-	ret = finalise_stage_fn(smmu_domain, master, &pgtbl_cfg);
+	ret = finalise_stage_fn(smmu_domain, &pgtbl_cfg);
 	if (ret < 0) {
 		free_io_pgtable_ops(pgtbl_ops);
 		return ret;
@@ -2429,15 +2425,14 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 }
 
 static int arm_smmu_prepare_domain_for_smmu(struct arm_smmu_device *smmu,
-					    struct arm_smmu_domain *smmu_domain,
-					    struct arm_smmu_master *master)
+					    struct arm_smmu_domain *smmu_domain)
 {
 	int ret = 0;
 
 	mutex_lock(&smmu_domain->init_mutex);
 	if (!smmu_domain->smmu) {
 		smmu_domain->smmu = smmu;
-		ret = arm_smmu_domain_finalise(&smmu_domain->domain, master);
+		ret = arm_smmu_domain_finalise(&smmu_domain->domain);
 		if (ret)
 			smmu_domain->smmu = NULL;
 	} else if (smmu_domain->smmu != smmu)
@@ -2462,7 +2457,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	master = dev_iommu_priv_get(dev);
 	smmu = master->smmu;
 
-	ret = arm_smmu_prepare_domain_for_smmu(smmu, smmu_domain, master);
+	ret = arm_smmu_prepare_domain_for_smmu(smmu, smmu_domain);
 	if (ret)
 		return ret;
 
@@ -2541,7 +2536,7 @@ static int arm_smmu_set_dev_pasid(struct iommu_domain *domain,
 	master = dev_iommu_priv_get(dev);
 	smmu = master->smmu;
 
-	ret = arm_smmu_prepare_domain_for_smmu(smmu, smmu_domain, master);
+	ret = arm_smmu_prepare_domain_for_smmu(smmu, smmu_domain);
 	if (ret)
 		return ret;
 
-- 
2.41.0.585.gd2178a4bd4-goog

