Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C77877FDCB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 20:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354410AbjHQSXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 14:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354437AbjHQSX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 14:23:27 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BE23C06
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:22:58 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d6b66b41232so186697276.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692296505; x=1692901305;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oBooMpaGlkQ+FKKABWmvIlNH9aUPRTcSS6CTCMQ9kRM=;
        b=IU2UOZ1QAkZfOcMGg5vcsJJHh9ZQj9hhxtEDAYymf3rWNhFaqWW+6INaMkoyKxt/oE
         Kaqvuj+X/pxgIK2TiTFUz0WzsHSgyKWS2ZHyj2Hj43tq7Hr69oibRlmjOv8YImpM7OIV
         9u3bHZgKiIQbgOPeaKpTQ+kaemWaVvBB3iWU+3PEWGmyQY6v+wO7PHV/kAo4zw+G1ugz
         mhFC+iuG27Yd3uMkvWXhaPZhcM8v7uoVO4GDfIWF9C6ZmyyycifTgv9BjPqaUlTr8GVS
         r6LVXt1zs+RHdu5RadGCtpslOLsMzFZd/mXaGR/d8Zfs3hVW2VKBl03OxCrI41Dupwpr
         gSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692296505; x=1692901305;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oBooMpaGlkQ+FKKABWmvIlNH9aUPRTcSS6CTCMQ9kRM=;
        b=fxxHlq2deRfQK8xWJNdk9InZaiwNF5l1Vo3LwCHT87lEzWR8VkZy4Nmczf01eh5Uqo
         HVxOjYSme8H8hYI9IZPYQ8vecHfy4ikEll1GyfvdD5XPqSSOXzNqAEg9sTOT+yWdTMy0
         pb6O8vcVhfQ6qMjLq04x03WZPOtTs/wlVPiJsa/59ufKpmBt9yQXIqC1W5AGdwhDwR0O
         OkbVUcMmgPAMzWS+M3lfFQJUhlqmnLtzWK152Hau51zsNvJ8EcL2C8dfrCgxpdIrqrkS
         uRQW4wO8n0m6shAloWdo36hHMVoTK3VSXVaKLYc2uQogoyWKhwMZE7nkdytsXOx2vcEh
         +VMQ==
X-Gm-Message-State: AOJu0YxCxCd5qZCnkV3VSmogwDqvq7xHgP1V/kbIK3rJ0hSf7s1Czuwr
        aecvFIFT9eZ4MpV5UAbd8sokFCXprD6S
X-Google-Smtp-Source: AGHT+IEqqWWy632gyVQWnMmINQsSMRfInztWWbMpGG+vOabJBtHCJeGHnGFeZG2cljxVwoXwgg50KcnBmYwN
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:4a77:fd20:7069:bdf9])
 (user=mshavit job=sendgmr) by 2002:a25:494:0:b0:d12:d6e4:a08d with SMTP id
 142-20020a250494000000b00d12d6e4a08dmr4183ybe.7.1692296505437; Thu, 17 Aug
 2023 11:21:45 -0700 (PDT)
Date:   Fri, 18 Aug 2023 02:16:30 +0800
In-Reply-To: <20230817182055.1770180-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230817182055.1770180-1-mshavit@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230818021629.RFC.v1.8.I5d374dbc818b209e911ef5fbf43de6df0d7ac40b@changeid>
Subject: [RFC PATCH v1 8/8] iommu/arm-smmu-v3: allow multi-SMMU domain installs
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

Remove the arm_smmu_domain->smmu handle now that a domain may be
attached to devices with different upstream SMMUs.

Signed-off-by: Michael Shavit <mshavit@google.com>
---

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 ++-------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 3 +--
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index c9f89f4f47721..08594612a81a8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2587,13 +2587,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	mutex_lock(&smmu_domain->init_mutex);
 
-	if (!smmu_domain->smmu) {
-		smmu_domain->smmu = smmu;
-		ret = arm_smmu_domain_finalise(domain, smmu);
-		if (ret)
-			smmu_domain->smmu = NULL;
-	} else if (smmu_domain->smmu != smmu)
-		ret = -EINVAL;
+	if (!smmu_domain->pgtbl_ops)
+		ret = arm_smmu_domain_finalise(&smmu_domain->domain, smmu);
 
 	mutex_unlock(&smmu_domain->init_mutex);
 	if (ret)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 143b287be2f8b..342fa6ef837ab 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -726,8 +726,7 @@ enum arm_smmu_domain_stage {
 };
 
 struct arm_smmu_domain {
-	struct arm_smmu_device		*smmu;
-	struct mutex			init_mutex; /* Protects smmu pointer */
+	struct mutex			init_mutex; /* Protects pgtbl_ops pointer */
 
 	struct io_pgtable_ops		*pgtbl_ops;
 	struct io_pgtable_cfg		pgtbl_cfg;
-- 
2.42.0.rc1.204.g551eb34607-goog

