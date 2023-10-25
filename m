Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00A97D70D4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 17:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344555AbjJYP1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 11:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344795AbjJYP1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 11:27:18 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC301B6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 08:26:14 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9c603e235d1so893607466b.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 08:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1698247572; x=1698852372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N6kIXcR1VU3TM5nz+Od8WlpDMDBhPdIZjdnlTVp9UJg=;
        b=ISrtjaY1JTvN7+81n9yRw1qgEnccwmIX9L5gOS0S5U8+uVbNcy36UuSpZn1k2gzq64
         0KtaPfveXQZFPX1gJSWaBg3IcIlkvmBu0uE8DqaD5XBmxD/UNcGWHdhK9CFIrw+LvKCe
         6dpDwOyGVdG8fjJnpLxiaoaSCxG76gvtCXf4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698247572; x=1698852372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N6kIXcR1VU3TM5nz+Od8WlpDMDBhPdIZjdnlTVp9UJg=;
        b=mpdO99axGDBmM7TIiAaf/HrDu70sqfoXr8O/yXlwZiZ8AALtoiBtLX52luBfKvnddC
         ypwJZlHl/kKxr6IA8edIPLIfOiHYFC4hMYhRHzBo8knwmarzWQIm4lLaRTG8pUBH6ePx
         LiAMpjkf+flUUZQGP1W7s+Ef4mDQG/68v1u1uE6l51OtKoLU4OV3z14d/K1RzRLW4hAj
         yAsHN7mGQS9c6SlE8jnK+jxpFdpM8QrGbS6pA0W8mMOius18q5bAKcDcJ9l6loTQXo4V
         rZhKztF12EOBHwsu3ANIER3elJ0sbzrvRWyevv86AZcnKYXGCz5a2xDfNxyBCtTBLuPD
         U6Dw==
X-Gm-Message-State: AOJu0YxTCp7N8EiYAnSB8RDzT2Uhl5KfveMPpJ3IjH1LTME7cYHzYk3m
        sJ2EHjXS01SfFSiHncc0BIOx7XAx+nNMFNpgPIoeKg==
X-Google-Smtp-Source: AGHT+IFZHatwpLh7F13bXFgOd8oEvInM20j/qQ1kWD4VR3k0O98n3XUgnAuYWIfT5SXzA9vF7lpujw==
X-Received: by 2002:a17:907:c386:b0:9c7:fd91:4309 with SMTP id tm6-20020a170907c38600b009c7fd914309mr8380498ejc.0.1698247572476;
        Wed, 25 Oct 2023 08:26:12 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-50-51-252.retail.telecomitalia.it. [82.50.51.252])
        by smtp.gmail.com with ESMTPSA id u24-20020a170906409800b009bf94de8971sm10110156ejj.70.2023.10.25.08.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 08:26:12 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Reddy <vdumpa@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
        linux-tegra@vger.kernel.org
Subject: [PATCH v2] iommu/tegra-smmu: drop error checking for debugfs_create_dir()
Date:   Wed, 25 Oct 2023 17:25:58 +0200
Message-ID: <20231025152609.2042815-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of debugfs_create_dir() should be checked using the
IS_ERR() function. The patch, however, drops the check statement without
fixing it because the subsequent functions (i. e. debugfs_create_file())
can handle the case where `@parent` is an error pointer.

Suggested-by: Baolu Lu <baolu.lu@linux.intel.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
 - drop the error checking statement

 drivers/iommu/tegra-smmu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index e445f80d0226..3e573148d18c 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -1056,9 +1056,6 @@ DEFINE_SHOW_ATTRIBUTE(tegra_smmu_clients);
 static void tegra_smmu_debugfs_init(struct tegra_smmu *smmu)
 {
 	smmu->debugfs = debugfs_create_dir("smmu", NULL);
-	if (!smmu->debugfs)
-		return;
-
 	debugfs_create_file("swgroups", S_IRUGO, smmu->debugfs, smmu,
 			    &tegra_smmu_swgroups_fops);
 	debugfs_create_file("clients", S_IRUGO, smmu->debugfs, smmu,
-- 
2.42.0

