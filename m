Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE7777FDC4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 20:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354334AbjHQSXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 14:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354382AbjHQSW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 14:22:57 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A823C06
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:22:15 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58cbf62bae8so1152267b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692296482; x=1692901282;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qDt4n1J4/1KupnwBe0I86Sz4ed5LQZ4WNLzvIfe1gZo=;
        b=TLU1cW+m7veBjvJCVt22MqfUzkVutvDZBMei+cpFgVTvlomXcC6SrvXybk0I8PFDeK
         J0s4B4BR5MhAx0GQUGPudOjwNxpTYqKRURJUtf+mjLa1UTz+eSTq5lK1zljK/NuuwfkH
         e5QmOA/bMgXZxTiVSikkw8IGuNL98jt8KCSBtwhvphYMhgo67S0AwI7lM6qb1NDIttpc
         waqux5KVRo2vm8pKtTECcBtr/GWET+XVZkWy0S+r14MK70nTma6HA4DciTZqYrnoxWzr
         KiXBqrTLTZm0KSp+x2hKqZtH7Lu3IXkqXxzb2JWh1+ZvZN6HHv4TakrZO3y6rzRNyK7u
         kK+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692296482; x=1692901282;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qDt4n1J4/1KupnwBe0I86Sz4ed5LQZ4WNLzvIfe1gZo=;
        b=IpduGqkxjSWDkX2rcGkqr6Fybwyq+ydUqfjoyN3GkNdt+g2oIjj+VdaCljR5XN+vg8
         x5c6MbRdbvyJNDjvcEfvV7ScKu/s/nXbz+eWCx9i3rOakwrPJmJsrh1uyAUTqzi5uhbK
         ZOvSwvlu/d3xwbhUiItZWIgRcT8ZcjZ9ceY8lOts6oLSdBd3tEqmwkCSvpcuTOBeSRjf
         Kk7hZxB0NbV11ZZ8I7kLARRiXf7BfSeQpbat6uppaaDrXGRFF/IHxk8L289tG5klhIPQ
         xQWBpRIeBXX87AqC1XPb7skdUuGao59fLfh4Nfd6A02Knw7YV85wKjKfS0/q4jmUL1Ma
         DPAw==
X-Gm-Message-State: AOJu0Yz4NIpPP5sA+u2WTXHYIL17mUo/VqMrx4TVRUr9l0bU7Hv8bL8q
        XAeynjOOKSfcTfbzOjEao44p00mZTR1F
X-Google-Smtp-Source: AGHT+IH5Zwh7r7Rz5gFgHqHiQdREEibNwM2GiX0YHx6D9zht+8wPq+Qu2t6iFL5s2PieMW+BQhbjjnaNen5u
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:4a77:fd20:7069:bdf9])
 (user=mshavit job=sendgmr) by 2002:a81:431e:0:b0:573:8316:8d04 with SMTP id
 q30-20020a81431e000000b0057383168d04mr2703ywa.4.1692296482399; Thu, 17 Aug
 2023 11:21:22 -0700 (PDT)
Date:   Fri, 18 Aug 2023 02:16:25 +0800
In-Reply-To: <20230817182055.1770180-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230817182055.1770180-1-mshavit@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230818021629.RFC.v1.3.I326c62dc062aed8d901d319aa665dbe983c7904c@changeid>
Subject: [RFC PATCH v1 3/8] iommu/arm-smmu-v3-sva: Allocate new ASID from installed_smmus
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

Pick an ASID that is within the supported range of all SMMUs that the
domain is installed to.

Signed-off-by: Michael Shavit <mshavit@google.com>
---

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 23 +++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 58def59c36004..ab941e394cae5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -82,6 +82,20 @@ static int arm_smmu_write_ctx_desc_devices(struct arm_smmu_domain *smmu_domain,
 	return ret;
 }
 
+static u32 arm_smmu_domain_max_asid_bits(struct arm_smmu_domain *smmu_domain)
+{
+	struct arm_smmu_installed_smmu *installed_smmu;
+	unsigned long flags;
+	u32 asid_bits = 16;
+
+	spin_lock_irqsave(&smmu_domain->installed_smmus_lock, flags);
+	list_for_each_entry(installed_smmu, &smmu_domain->installed_smmus,
+			    list)
+		asid_bits = min(asid_bits, installed_smmu->smmu->asid_bits);
+	spin_unlock_irqrestore(&smmu_domain->installed_smmus_lock, flags);
+	return asid_bits;
+}
+
 /*
  * Check if the CPU ASID is available on the SMMU side. If a private context
  * descriptor is using it, try to replace it.
@@ -92,7 +106,6 @@ arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
 	int ret;
 	u32 new_asid;
 	struct arm_smmu_ctx_desc *cd;
-	struct arm_smmu_device *smmu;
 	struct arm_smmu_domain *smmu_domain;
 
 	cd = xa_load(&arm_smmu_asid_xa, asid);
@@ -108,10 +121,12 @@ arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
 	}
 
 	smmu_domain = container_of(cd, struct arm_smmu_domain, cd);
-	smmu = smmu_domain->smmu;
 
-	ret = xa_alloc(&arm_smmu_asid_xa, &new_asid, cd,
-		       XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL);
+	ret = xa_alloc(
+		&arm_smmu_asid_xa, &new_asid, cd,
+		XA_LIMIT(1,
+			 (1 << arm_smmu_domain_max_asid_bits(smmu_domain)) - 1),
+		GFP_KERNEL);
 	if (ret)
 		return ERR_PTR(-ENOSPC);
 	/*
-- 
2.42.0.rc1.204.g551eb34607-goog

