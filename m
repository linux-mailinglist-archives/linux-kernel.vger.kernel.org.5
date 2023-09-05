Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820D1792B94
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344214AbjIEQzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354461AbjIELur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 07:50:47 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077FD1AB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 04:50:44 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7c676651c7so5553907276.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 04:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693914643; x=1694519443; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7YfE4KQ/9gmtzN9iZMl6VnrHqz0Jm4lc2KvR4R04sGA=;
        b=GrFH00B0l5EcluyHVGJKpUKKbXNMxATOMwr35BwQl6IIS5VRSS9Dgv8OEjFVHZKpq4
         RLzfwBcCU2OdKUgYHwgg4exbpy+sdvAAcAx33cZmKJbaBhrylssMv4YrTbLPD7Yrjv5p
         +LMwE+0B7g2wvBeAVZ3Uv9HkyYC8igZIQakZ4rnPzMQ6Tsf712wUSFU68H8TOpuJbqiZ
         CqMzIscWWLL+Nwn4xTmaD2WCzD5Feb3EXKaM82NPF80p3klaPy5v+Kk5EoJWRExcFsAj
         uuzlEzvdLpowLqhP1qvW4RbLvNwjXRZlV/r/cweUeQMXpAb/sqmgXB2/zShvyyvrBXLS
         pjaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693914643; x=1694519443;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7YfE4KQ/9gmtzN9iZMl6VnrHqz0Jm4lc2KvR4R04sGA=;
        b=cLf1+KosZKmOr150ekfCaMj1E5IbTNUsVZcgcly3+8yYppg6o+yY00seT98cDN1VfX
         KkdUpVmIZBXTHKm5vfpwUDktbs6zqct9fyT4j8QGqVgulJV5zluuNGUQTa9eQcfHa0gl
         XqTtIEunKik3QQh7AjPb4bnfowwssFeQxlcJ0Hpf3eN+Pi+R64Tmz1zkoE5RK5wmAOd/
         od874g08RLiuhGCHaV9Uq7hIMMi7jC5pGSw+MMfO/OqEdVVllQoCbmI6ZCSxHMy9RE6z
         LshlGJUZQDQK5Tl/blyyS+O2Akk/tZCzSG1kkMEI4S+I+GjmGp2+dFwI6n1YBpTqWNPX
         UfkA==
X-Gm-Message-State: AOJu0Yzs7JSg89UvaYxj0TI3rZT7EuiLGIBsbRS+NO/WELIKrcz5nbI7
        dnOIxELwKzqcSObYyVhWfYxXZgKaKWWV
X-Google-Smtp-Source: AGHT+IFMJMhyDh+Mk2ZERpecJKF5C6idpkbhpOKinywWmUZVBJ+h6wHJCjYqmxx/sEbPLpU9spECoGysuOhb
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:c4a8:fdce:d8d3:7b02])
 (user=mshavit job=sendgmr) by 2002:a25:ad03:0:b0:d7b:b648:f0da with SMTP id
 y3-20020a25ad03000000b00d7bb648f0damr403350ybi.6.1693914643302; Tue, 05 Sep
 2023 04:50:43 -0700 (PDT)
Date:   Tue,  5 Sep 2023 19:49:12 +0800
In-Reply-To: <20230905115013.1572240-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230905115013.1572240-1-mshavit@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230905194849.v1.1.Ib483f67c9e2ad90ea2254b4b5ac696e4b68aa638@changeid>
Subject: [PATCH v1 1/3] iommu/arm-smmu-v3-sva: Remove unused iommu_sva handle
From:   Michael Shavit <mshavit@google.com>
To:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     will@kernel.org, robin.murphy@arm.com, nicolinc@nvidia.com,
        jean-philippe@linaro.org, jgg@nvidia.com, tina.zhang@intel.com,
        Michael Shavit <mshavit@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Tomas Krcka <krckatom@amazon.de>,
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

The __arm_smmu_sva_bind function returned an unused iommu_sva handle
that can be removed.

Signed-off-by: Michael Shavit <mshavit@google.com>
---

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index a5a63b1c947eb..32784758ccce6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -25,7 +25,6 @@ struct arm_smmu_mmu_notifier {
 #define mn_to_smmu(mn) container_of(mn, struct arm_smmu_mmu_notifier, mn)
 
 struct arm_smmu_bond {
-	struct iommu_sva		sva;
 	struct mm_struct		*mm;
 	struct arm_smmu_mmu_notifier	*smmu_mn;
 	struct list_head		list;
@@ -320,8 +319,7 @@ static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
 	arm_smmu_free_shared_cd(cd);
 }
 
-static struct iommu_sva *
-__arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
+static int __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 {
 	int ret;
 	struct arm_smmu_bond *bond;
@@ -330,7 +328,7 @@ __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 
 	if (!master || !master->sva_enabled)
-		return ERR_PTR(-ENODEV);
+		return -ENODEV;
 
 	/* If bind() was already called for this {dev, mm} pair, reuse it. */
 	list_for_each_entry(bond, &master->bonds, list) {
@@ -342,10 +340,9 @@ __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 
 	bond = kzalloc(sizeof(*bond), GFP_KERNEL);
 	if (!bond)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
 	bond->mm = mm;
-	bond->sva.dev = dev;
 	refcount_set(&bond->refs, 1);
 
 	bond->smmu_mn = arm_smmu_mmu_notifier_get(smmu_domain, mm);
@@ -355,11 +352,11 @@ __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 	}
 
 	list_add(&bond->list, &master->bonds);
-	return &bond->sva;
+	return 0;
 
 err_free_bond:
 	kfree(bond);
-	return ERR_PTR(ret);
+	return ret;
 }
 
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
@@ -537,13 +534,10 @@ static int arm_smmu_sva_set_dev_pasid(struct iommu_domain *domain,
 				      struct device *dev, ioasid_t id)
 {
 	int ret = 0;
-	struct iommu_sva *handle;
 	struct mm_struct *mm = domain->mm;
 
 	mutex_lock(&sva_lock);
-	handle = __arm_smmu_sva_bind(dev, mm);
-	if (IS_ERR(handle))
-		ret = PTR_ERR(handle);
+	ret = __arm_smmu_sva_bind(dev, mm);
 	mutex_unlock(&sva_lock);
 
 	return ret;
-- 
2.42.0.283.g2d96d420d3-goog

