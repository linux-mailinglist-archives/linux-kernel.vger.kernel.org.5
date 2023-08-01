Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1969476BCA1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 20:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjHASjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 14:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjHASjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 14:39:39 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4F92707
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 11:39:25 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58456435437so70156717b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 11:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690915164; x=1691519964;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zsOLF65GCnXc9xKNLgceJ3I7vQXpvGjuscvCrSUFmw0=;
        b=2lYCxVWeQ0XEbkaQCNlXmhkYY1Kddd521lbbTuATXI6HVCwfX4ZbVxfWE6VfMRva/L
         3Ct0jredgG+9aQzrxInlmujaq12uQZjp6ylQi9BXuqmb2qytUTybE7o0QTJw7nzoLnkM
         8s4H+06T5uZKGYi8wEcf1n/Tci3igvOBSxV4S+yZl79EGASbRc0CZ/togSNvBOcrnXvU
         Kg/VCSL1rl4AWel2PaVZZtLplRbQaYvRJQWmYLmfMfjqYZ3cAAna4hFrRFVB0ZK7tuUd
         Xy2SIOee1UdOvQU5vB3mTlPPU+4g8q8J/RMNVp+J+W4u5DJPKBzvgASjh1DefH2DaLKn
         X8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690915164; x=1691519964;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zsOLF65GCnXc9xKNLgceJ3I7vQXpvGjuscvCrSUFmw0=;
        b=K+g65lW1hvOMzfUMkMVSYMWGTGysVQbR8YgwEW1Xv+Ldp6MzQNTv33EhXa+fGsUKvN
         x2yVux9A9NTes0TGtPoyKYmijzp+tCnKU6L4+IkezvGJlcDCniL/3X3jzZ2TZITMX4V8
         u2ccRFuoeW3tmHk6F+wQC91cxFG3DQajonXiqQR87mTMOrdbloFZZODw5WI9nPggMhqj
         eiGs2OkMtMkzbz0lokeWr4aS1fjJEWekbcIqkjOV3XkixbdWPrng7L2hT2Pv8K4dd85z
         PMop05aacmkL7VkicNgtqFbt3Tor+bvWuu5CBusRCBa2fwKFsWqv1gxBL07NU7apXarT
         Mjyg==
X-Gm-Message-State: ABy/qLYlvWkaY9g1x1lBK7jtrjjujX9IwSi3nPGcpf/hGQ13qo/pFlxt
        JcT3O/sZ8BpueC8PL1H1wVqIYpTABHJ1
X-Google-Smtp-Source: APBJJlFC5DrFlCuMVG6r3RiWa+1GW1f0S3XPuNPTV23mWgKkgY/ZZvlGX5pSPQKSNgSnocZ0RmLFDH5A2Uve
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:a54:d53d:50e4:b5b8])
 (user=mshavit job=sendgmr) by 2002:a25:c712:0:b0:d0c:1f08:5fef with SMTP id
 w18-20020a25c712000000b00d0c1f085fefmr82652ybe.12.1690915164624; Tue, 01 Aug
 2023 11:39:24 -0700 (PDT)
Date:   Wed,  2 Aug 2023 02:35:24 +0800
In-Reply-To: <20230801183845.4026101-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230801183845.4026101-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230802023524.v3.7.Idedc0f496231e2faab3df057219c5e2d937bbfe4@changeid>
Subject: [PATCH v3 7/8] iommu/arm-smmu-v3: Skip cd sync if CD table isn't active
From:   Michael Shavit <mshavit@google.com>
To:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     robin.murphy@arm.com, will@kernel.org, jean-philippe@linaro.org,
        jgg@nvidia.com, nicolinc@nvidia.com,
        Michael Shavit <mshavit@google.com>
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

This commit explicitly keeps track of whether a CD table is installed in
an STE so that arm_smmu_sync_cd can skip the sync when unnecessary. This
was previously achieved through the domain->devices list, but we are
moving to a model where arm_smmu_sync_cd directly operates on a master
and the master's CD table instead of a domain.

Signed-off-by: Michael Shavit <mshavit@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---

Changes in v3:
- Flip the cd_table.installed bit back off when table is detached
- re-order the commit later in the series since flipping the installed
  bit to off isn't obvious when the cd_table is still shared by multiple
  masters.

Changes in v2:
- Store field as a bit instead of a bool. Fix comment about STE being
  live before the sync in write_ctx_desc().

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 8 +++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index b05963cd4e5b5..94922d4ff7be0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -985,6 +985,9 @@ static void arm_smmu_sync_cd(struct arm_smmu_master *master,
 		},
 	};
 
+	if (!master->cd_table.installed)
+		return;
+
 	cmds.num = 0;
 	for (i = 0; i < master->num_streams; i++) {
 		cmd.cfgi.sid = master->streams[i].id;
@@ -1091,7 +1094,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
 		cdptr[3] = cpu_to_le64(cd->mair);
 
 		/*
-		 * STE is live, and the SMMU might read dwords of this CD in any
+		 * STE may be live, and the SMMU might read dwords of this CD in any
 		 * order. Ensure that it observes valid values before reading
 		 * V=1.
 		 */
@@ -1360,6 +1363,9 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 				  cd_table->l1_desc ?
 					  STRTAB_STE_0_S1FMT_64K_L2 :
 					  STRTAB_STE_0_S1FMT_LINEAR);
+		cd_table->installed = true;
+	} else {
+		master->cd_table.installed = false;
 	}
 
 	if (s2_cfg) {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index f2acfcc1af925..0ee3dc7291a15 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -599,6 +599,8 @@ struct arm_smmu_ctx_desc_cfg {
 	u8				max_cds_bits;
 	/* Whether CD entries in this table have the stall bit set. */
 	u8				stall_enabled:1;
+	/* Whether this CD table is installed in any STE */
+	u8				installed:1;
 };
 
 struct arm_smmu_s2_cfg {
-- 
2.41.0.585.gd2178a4bd4-goog

