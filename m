Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B0D783E77
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 12:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbjHVK67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 06:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbjHVK65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:58:57 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090E8196
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 03:58:31 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-268476c3b2aso6561292a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 03:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692701906; x=1693306706;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gv8qs8tb5+ht3xEXCO2MlfdAXc51HHEhUztVM4QYf7k=;
        b=XxR0LNcd6ZMLLCXEsgVSgiM0m2dvGOpGJ0H2y2I3Ztbzt8plf5Zs/4VNYjeQOFpry+
         PH2HqrjjVyT6YxZ0ZowGRVgJRmlhAZziZAfr8pHS5GaUhXmpfF+xIN8sFcmU+VoQt6jf
         vg3KT/vuCq2HJIN/0b20FjE97XCf5ZOP7uVIA8O/OCVtNAP0HVbSntANTxWg/EcMcSxH
         R2UP3T6vuQvik0z9gG1HI/Zbn+2pPHPvZv+kPu+c7PlQhUh/60zo8gc/U/LQaRzF5NLz
         gJKIgjHkQfwHgvdR7MHN1Gw86BsVoxJ55knBkY5sEEGZdpPjIn/teqw7obJvPgVEFyXC
         Op7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692701906; x=1693306706;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gv8qs8tb5+ht3xEXCO2MlfdAXc51HHEhUztVM4QYf7k=;
        b=ak3rqvZW+xS4TDT+LO24DYP75rHZ7PVTymlF69c0/T6VWLqMPr0hxh+su0vzgkcphJ
         XWWfJzhaj7+b0Mctxx3hZ185HrJRb2k2dFCg7LYn+2f9RjbKfvY38FSLikIP/hVUDGvz
         kbsEC02kAauwS0tsZRipDhjFt2WEhc/qZaU3f3bTE4baahSRJw9/SymJtvCruB3ry19F
         LSfQTcyj90J5W9q5KJt/9rG59dIvxSBfMyyhC2PydxYnqoM6cqCkApp91DJFlOshUcL2
         HH5Trr1wz/6Fgm6t4khRuBmPfNqK3EUUeR0LDF/VnYYDTS/yOdw6wkuGxOEtBgcFenwQ
         Ln0g==
X-Gm-Message-State: AOJu0YyJeZq6tcjH0gM5wguGhkgzTOWISxUXit7/piy/Sak97XZLap0n
        dyLGOxWQr8eh7tyc8WCbupnDb6Ax+YLz
X-Google-Smtp-Source: AGHT+IHY7P3AGtuprqqUV/dDekDb2kOfyGnlyTzMrT8+CEylyDp3RWzdk6ztQiyu+b0tkcWobWMgKFfrKVgj
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:44ad:3968:8aaa:c4fe])
 (user=mshavit job=sendgmr) by 2002:a17:90a:a58f:b0:268:38e3:34f0 with SMTP id
 b15-20020a17090aa58f00b0026838e334f0mr1756657pjq.2.1692701906060; Tue, 22 Aug
 2023 03:58:26 -0700 (PDT)
Date:   Tue, 22 Aug 2023 18:57:05 +0800
In-Reply-To: <20230822105738.1607365-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230822105738.1607365-1-mshavit@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230822185632.RFC.v2.9.I5d374dbc818b209e911ef5fbf43de6df0d7ac40b@changeid>
Subject: [RFC PATCH v2 9/9] iommu/arm-smmu-v3: allow multi-SMMU domain installs.
From:   Michael Shavit <mshavit@google.com>
To:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     nicolinc@nvidia.com, tina.zhang@intel.com,
        jean-philippe@linaro.org, will@kernel.org, robin.murphy@arm.com,
        jgg@nvidia.com, Michael Shavit <mshavit@google.com>,
        Dawei Li <set_pte_at@outlook.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
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

Remove the arm_smmu_domain->smmu handle now that a domain may be
attached to devices with different upstream SMMUs.

Signed-off-by: Michael Shavit <mshavit@google.com>
---

(no changes since v1)

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 10 +++-------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  3 +--
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9f8b701771fc3..55c0b8aecfb0a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2564,13 +2564,9 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	mutex_lock(&smmu_domain->init_mutex);
 
-	if (!smmu_domain->smmu) {
-		smmu_domain->smmu = smmu;
-		ret = arm_smmu_domain_finalise(domain, smmu);
-		if (ret)
-			smmu_domain->smmu = NULL;
-	} else if (smmu_domain->smmu != smmu ||
-		   !arm_smmu_verify_domain_compatible(smmu, smmu_domain))
+	if (!smmu_domain->pgtbl_ops)
+		ret = arm_smmu_domain_finalise(&smmu_domain->domain, smmu);
+	else if (!arm_smmu_verify_domain_compatible(smmu, smmu_domain))
 		ret = -EINVAL;
 
 	mutex_unlock(&smmu_domain->init_mutex);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 1661d3252bac5..fcf3845f4659c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -716,8 +716,7 @@ enum arm_smmu_domain_stage {
 };
 
 struct arm_smmu_domain {
-	struct arm_smmu_device		*smmu;
-	struct mutex			init_mutex; /* Protects smmu pointer */
+	struct mutex			init_mutex; /* Protects pgtbl_ops pointer */
 
 	struct io_pgtable_ops		*pgtbl_ops;
 	atomic_t			nr_ats_masters;
-- 
2.42.0.rc1.204.g551eb34607-goog

