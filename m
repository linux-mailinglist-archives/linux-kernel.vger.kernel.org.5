Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A960777FDD2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 20:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354354AbjHQSXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 14:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354396AbjHQSXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 14:23:16 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872623AB2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:22:40 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d1c693a29a0so183989276.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692296492; x=1692901292;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZP10bOrqJHL85lu3Z2lUx2alTLUFh+2Q6vzg89i9Wk=;
        b=3SMQXfpShml6d9+BtmaqOK2GzQznRL6kyxmNNpDAk0CT1TqSZj14kVaCyjAuoY8Ax4
         pUoE56xlNXNLOnXa9v2+/+DYWOtsfnIr1hiKC74FNdVVnrb/NQyojV5sLfI+Ffxg4ETV
         vRSA3YuSgWM7b0p3cR9XpwMtJEcS8nvF/1VpsdGANQjIZqUBDhgQWlHzpa5J75wKpO6Y
         qdqiK+/eWkHNqYp5fC/ATsxKWHE1j8rC+FNhpi4zsemW9RbIgorSVC8P/o7+Ur7AF02N
         zRfO9DP/B96rozUkWWcJhzFNNMBQW9IcwC+Rw1SZXEmJsB/7TtigLri8zQzxJjqpHC+L
         PQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692296492; x=1692901292;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZP10bOrqJHL85lu3Z2lUx2alTLUFh+2Q6vzg89i9Wk=;
        b=W5d2GQkFadTTH4mH0fksDssqw6DpRRPkVH1OQcrPpiJ2r9P0LjbPdNCpY4P44amzB/
         vIs1dlmTeAQUulhHezjlrgTMSRxOiFPbBXg6DEwtX3QwRxKSqjoD2vI9LgH6ERysOzJp
         DfH4qwVUZ8HniM1p/XqqxkkgesT3GE42cLuMU0oGDPLbLycoFz84Ts7OnHECwzXW+Flq
         dNQGuFL2mjXwSkw4KOqHeyROJlIRgoO3BgNpZUUoKk7g/SK24CvwAGKcVPVtk/QVHIdt
         LyNoQXGHRaoBrW0f0hTjUG09T60YWbK8YUNngCov2bEjpjCKq3pifJq9bJLGSofs1Erw
         /WaA==
X-Gm-Message-State: AOJu0Yy0rpIRcO4NKb6dS/xNn0ilEINkWjXTvhGF01y/xO3RlTHMwkZe
        iEJb8CVTJ6rbPNHMlWM6hxLE0iyKWann
X-Google-Smtp-Source: AGHT+IGbdbNVPcRg1sbArh45fkt6h+fxSGJJucKE8ciso+2BfxjvcUKG1RiUX+bGIUHNJJUh65fH4VC/apu1
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:4a77:fd20:7069:bdf9])
 (user=mshavit job=sendgmr) by 2002:a05:6902:144e:b0:d44:585f:dfa8 with SMTP
 id a14-20020a056902144e00b00d44585fdfa8mr5677ybv.0.1692296492062; Thu, 17 Aug
 2023 11:21:32 -0700 (PDT)
Date:   Fri, 18 Aug 2023 02:16:27 +0800
In-Reply-To: <20230817182055.1770180-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230817182055.1770180-1-mshavit@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230818021629.RFC.v1.5.Ia591869e7a4b88af16a57e09c92df21599d3312c@changeid>
Subject: [RFC PATCH v1 5/8] iommu/arm-smmu-v3: Add arm_smmu_device as a
 parameter to domain_finalise
From:   Michael Shavit <mshavit@google.com>
To:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     will@kernel.org, jgg@nvidia.com, nicolinc@nvidia.com,
        tina.zhang@intel.com, jean-philippe@linaro.org,
        robin.murphy@arm.com, Michael Shavit <mshavit@google.com>
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

Remove the usage of arm_smmu_domain->smmu in arm_smmu_domain_finalise to
prepare for the commit where a domain can be attached to multiple
masters.

Signed-off-by: Michael Shavit <mshavit@google.com>
---

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index c0943cf3c09ca..208fec5fba462 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2132,11 +2132,11 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 }
 
 static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
+				       struct arm_smmu_device *smmu,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
 	int ret;
 	u32 asid;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_ctx_desc *cd = &smmu_domain->cd;
 	typeof(&pgtbl_cfg->arm_lpae_s1_cfg.tcr) tcr = &pgtbl_cfg->arm_lpae_s1_cfg.tcr;
 
@@ -2169,10 +2169,10 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 }
 
 static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
+				       struct arm_smmu_device *smmu,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
 	int vmid;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
 	typeof(&pgtbl_cfg->arm_lpae_s2_cfg.vtcr) vtcr;
 
@@ -2227,15 +2227,16 @@ static int arm_smmu_prepare_pgtbl_cfg(struct arm_smmu_device *smmu,
 	return 0;
 }
 
-static int arm_smmu_domain_finalise(struct iommu_domain *domain)
+static int arm_smmu_domain_finalise(struct iommu_domain *domain,
+				    struct arm_smmu_device *smmu)
 {
 	int ret;
 	enum io_pgtable_fmt fmt;
 	struct io_pgtable_ops *pgtbl_ops;
 	int (*finalise_stage_fn)(struct arm_smmu_domain *,
+				 struct arm_smmu_device *,
 				 struct io_pgtable_cfg *);
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct io_pgtable_cfg *pgtbl_cfg = &smmu_domain->pgtbl_cfg;
 
 	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
@@ -2275,7 +2276,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 	domain->geometry.aperture_end = (1UL << pgtbl_cfg->ias) - 1;
 	domain->geometry.force_aperture = true;
 
-	ret = finalise_stage_fn(smmu_domain, pgtbl_cfg);
+	ret = finalise_stage_fn(smmu_domain, smmu, pgtbl_cfg);
 	if (ret < 0) {
 		free_io_pgtable_ops(pgtbl_ops);
 		return ret;
@@ -2585,7 +2586,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	if (!smmu_domain->smmu) {
 		smmu_domain->smmu = smmu;
-		ret = arm_smmu_domain_finalise(domain);
+		ret = arm_smmu_domain_finalise(domain, smmu);
 		if (ret)
 			smmu_domain->smmu = NULL;
 	} else if (smmu_domain->smmu != smmu)
-- 
2.42.0.rc1.204.g551eb34607-goog

