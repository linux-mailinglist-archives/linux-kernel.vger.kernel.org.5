Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8280278F224
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 19:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346974AbjHaRrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 13:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346967AbjHaRrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 13:47:04 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DB710F0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 10:46:34 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58fb8933e18so14092417b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 10:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693503982; x=1694108782; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=97NbLwOzwX2yfBkjP3g3hHfcNULS8xoy6ngi79VwyiQ=;
        b=AE+smRv5i96FT04jYkeVnOVvzd5x5oaGXCtO66a8tPSS2t6vTo4ZNk0Ti75M8Hbfxn
         ECroSLtD1dlR++iM622BfTjCErm+7Gc68pVR7j5pL2PkYtwzwgvVM4utrv3PPDntGAlj
         v1+yzx8EQMD5Z/0TGZ2btpRORPQSCJMkGXdGs/s70I+MLVxm+bPvbyCfoH0t/Ghb45dK
         p94MAb/6zYjr/qOmWkJ+zXQb2eCke62bQWqQI/OogNNsUIeuRjBZ+uckmUSmk0FFXO0z
         +OfZET1fKWI5ERrUiqo6Nu0OUAv9ojv/zuQ5DgLVAM0hy4SzIVJsfHqPNoJUvRUXI6a8
         OcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693503982; x=1694108782;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=97NbLwOzwX2yfBkjP3g3hHfcNULS8xoy6ngi79VwyiQ=;
        b=gRfytKi9D/a8+71DxrmsAqLEEhyZ7Vezfbp/6+O2quMfuUL+Sbf7J1N4ALV4UnAmGH
         2KxbY/cNFo1rsoA4+vGk8uZPNeCV0LBOl2X+jTbqsOjHde6Z8f3zcTkPMiP6dO5UywXX
         pF+iQLfjSXtNrZ/Yi6wNsT46hQoGqML+tRBnIrFVYUKpbVdIVsgyKEYFwp2FBUdxOgG/
         I66vzeujCRuIshRby0WdbL1fUuN0UjwNYQVzM8rgN6l9/jvGCPpawiDRi8qGmOpdgP37
         TOvYRogj5MmDkeomKjjJCkhvfwvwgPD/2qmqdYX5007DyS6+2q2EPLSbflYB4a0DuJBB
         N0cA==
X-Gm-Message-State: AOJu0Yx/VEgDFIqwrDeZ385acnxWBa9tEoH+CeOb7d5Az8zMecZzgXvU
        LJTbEpeNzRhKE44JBqOZuzKw+GjvXWHQ
X-Google-Smtp-Source: AGHT+IFnAn3Jgebhh43eiBoBmSBDyph6RaR6op6wjUZNKsymtjXCclD9kKZcfRwzPgCeOQNDjo1qmsyY58LY
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:1a0a:7338:4a5a:5f83])
 (user=mshavit job=sendgmr) by 2002:a81:e40b:0:b0:592:8069:540a with SMTP id
 r11-20020a81e40b000000b005928069540amr2213ywl.8.1693503982384; Thu, 31 Aug
 2023 10:46:22 -0700 (PDT)
Date:   Fri,  1 Sep 2023 01:44:37 +0800
In-Reply-To: <20230831174536.103472-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230831174536.103472-1-mshavit@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230901014413.v7.8.I7a8beb615e2520ad395d96df94b9ab9708ee0d9c@changeid>
Subject: [PATCH v7 8/9] iommu/arm-smmu-v3: Update comment about STE liveness
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

Update the comment to reflect the fact that the STE is not always
installed. arm_smmu_domain_finalise_s1 intentionnaly calls
arm_smmu_write_ctx_desc while the STE is not installed.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Michael Shavit <mshavit@google.com>
---

(no changes since v6)

Changes in v6:
- New commit

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 8d177ed550054..adede66621163 100644
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
2.42.0.283.g2d96d420d3-goog

