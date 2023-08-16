Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A098577E26E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 15:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245473AbjHPNUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 09:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245465AbjHPNUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 09:20:10 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F711BFB
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 06:20:09 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-589cd098d24so63863587b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 06:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692192008; x=1692796808;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JVOpA/yt+XB5fUDF/Igz/1o39LmIyoO6uf2H6LfppQ0=;
        b=YHx69WaUgdUHez2bpSsN8VAxs+M9Lh0EQC30duWKtyrWoU5UQTBl3GKL0LegsdUQVV
         kx+B6cCwadRkWKJfekVHY8VUMOO8F1S3vlM9rjxOBbKChwmPib7a3m2k4KzhrAJxFYgw
         SB+aN7HVCG4MkJ8rHCdQ8ueQEX1bw9HsxGgrwc8fSyopYuNcpKF4I2RiKLh05MUuIfhJ
         fj4IjCHt43Kdzkb1Kgdjzqu4Ah1mVPOuvAMLjXb19UTBxtnDlgXy+fTZ5T5/1PXc1lUp
         PR8annuG6JxdZAe1nvGiISguAQby7BJc8Ifl/RWJkwV53HZ4hMbYWb0Yg5IMbtnHEV7t
         x7GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692192008; x=1692796808;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JVOpA/yt+XB5fUDF/Igz/1o39LmIyoO6uf2H6LfppQ0=;
        b=inokYY3tzIiYr2N0zOeNC5XvgRjM+cB3NoICQVEL5ERM28vonA2q+oC7boreFY8564
         bNx/n48NCGLaL3HQqYovepPFGroB4HqeVgmTFQhXnvGZn8uNj0ReKuXDMQjJ+5em/yhD
         M0PH3iB0ZPa5R2s5NyqvoUw+K4qX9j+RriC4DuEN3BwykJysKnuwCTr30N+iZestlKCd
         SKXSALgsT5ok0FopsYYD6vk5ymsn8vZ3RLw8HpGGD3usVmRpURS+sPlLJN2LaIB3gu8G
         Rflg5NhMd7QirMrP3EyxSnQ9TcwRc9u1vJ2kC3ib1A2RJySjHrFGTdbpJ36iiKVrdreA
         f6ig==
X-Gm-Message-State: AOJu0YyQ4LlKhuKT9wD7HLI5ww3eD8TSVWkZnPKt9bEykCMIsc2Vk7z4
        rzws0zxchiCvL0C2/mY23HxhFRu6T//X
X-Google-Smtp-Source: AGHT+IFpyLI55CA6xQKncSrPwnccVH+ac9drAor/x+DI/dKv5IqDhSwq+q3zlIdn3S0InwRjuxU5uhS9UAek
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:ae98:2006:2abd:3434])
 (user=mshavit job=sendgmr) by 2002:a81:4524:0:b0:57a:793:7fb0 with SMTP id
 s36-20020a814524000000b0057a07937fb0mr24462ywa.3.1692192008657; Wed, 16 Aug
 2023 06:20:08 -0700 (PDT)
Date:   Wed, 16 Aug 2023 21:18:48 +0800
In-Reply-To: <20230816131925.2521220-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230816131925.2521220-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230816211849.v6.8.I7a8beb615e2520ad395d96df94b9ab9708ee0d9c@changeid>
Subject: [PATCH v6 08/10] iommu/arm-smmu-v3: Update comment about STE liveness
From:   Michael Shavit <mshavit@google.com>
To:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     robin.murphy@arm.com, will@kernel.org, jean-philippe@linaro.org,
        jgg@nvidia.com, nicolinc@nvidia.com,
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

Update the comment to reflect the fact that the STE is not always
installed. arm_smmu_domain_finalise_s1 intentionnaly calls
arm_smmu_write_ctx_desc while the STE is not installed.

Signed-off-by: Michael Shavit <mshavit@google.com>
---

Changes in v6:
- New commit

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index de87150cd0242..3c8bfeca89d5c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1091,7 +1091,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
 		cdptr[3] = cpu_to_le64(cd->mair);
 
 		/*
-		 * STE is live, and the SMMU might read dwords of this CD in any
+		 * STE may be live, and the SMMU might read dwords of this CD in any
 		 * order. Ensure that it observes valid values before reading
 		 * V=1.
 		 */
-- 
2.41.0.694.ge786442a9b-goog

