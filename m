Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC3F777F73
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 19:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbjHJRpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 13:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjHJRpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 13:45:12 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2AB2709
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 10:45:11 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fe934c4decso626621e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 10:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691689510; x=1692294310;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IprqHOCHDt9UgE2LWF7Iqap53+eHPhwxhxAzQePbb8Q=;
        b=y3F5cYkJZdt2elOTtoDxTgeZnjDMfApp6lgMiahEsU10ko7fnf25T3gFQZ1YNUBoc5
         5GNbWV1ysWyZKdh5jq1NQgOIX69oYHKQuarqo6CofnzKR011poS7nsmo4U+qam/6pIOb
         6nvkwThf9H1wFevZyLrOnOM1AxhqBt9b5u1gCM90y/Ou7L1hYHUdSL+IZJ7VX3YAYmDG
         UeH+shSzWBAsbuRr5J+CA7Ix/QdEDlfE2kdLJvxbSd5LFEjikcl/RwEzHi1rR/WEWPA0
         3IajwqPPTE041mMrMPopr0RCv6V5KhD280i2EjAJvrika9gyt+hQCiRhiuVS0zQ6XYH1
         BYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691689510; x=1692294310;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IprqHOCHDt9UgE2LWF7Iqap53+eHPhwxhxAzQePbb8Q=;
        b=Bus8cet6iVH89HDn7PrqN+PcgIgwKNEJqhAjP3nIrjOeEE6HpyImKWqr4lduyZ0Ye3
         EGdhx3Ho0sBD+vaPXtd7/exQHPOUwbRpSkvWJ7+zISf7wlZZ+mZ6+wnhbZ1GHk1fRHeR
         ZIZ1G7Hie9CDrmztHRQXBLbCnLT6ZIyx5mraeKDEAVaCdkF992C2fSMK03TUpNB6C/cH
         lYMk/kuJqH0DVF82+mmTEsk9gobmxNvLLPXA5mobijBE7JueNU2mMibBWByKxFFNURxl
         dtsmM0AMp6lg/U9zE5+bJmQ0g6yG/oir5FDQZPmYfeeN7YZnoLac/KssXJbzwE/W4yO/
         +MPw==
X-Gm-Message-State: AOJu0YwZTeqMiGPdRT0r2l8+PyQberBGRcih+0bcQC1GllJoLpc2Zoi9
        xRmFENcWzf3BG/b9ggbYvyYLMQ==
X-Google-Smtp-Source: AGHT+IGzIG+XOfPpgbnX8tq3J/2LeGOtIb4bcrFJI27g1m8Vl7vjceb5s5aeelHl2ynHw5RhdRE0Kg==
X-Received: by 2002:ac2:58d8:0:b0:4fb:8bcd:acd4 with SMTP id u24-20020ac258d8000000b004fb8bcdacd4mr2219875lfo.37.1691689509683;
        Thu, 10 Aug 2023 10:45:09 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id v13-20020ac2558d000000b004fdfefdf4acsm364173lfg.39.2023.08.10.10.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 10:45:09 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/4] arm-smmu: pick up lost qcom impl compatibles
Date:   Thu, 10 Aug 2023 19:45:03 +0200
Message-Id: <20230810-topic-lost_smmu_compats-v1-0-64a0d8749404@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB8i1WQC/x2NWwqDMBAAryL73UASodhepRRZ001dyItslIJ49
 wY/Z2CYA4Qqk8BzOKDSzsI5dTC3AdyK6UuKP53BajvqyWjVcmGnQpY2S4zb7HIs2EQZc/eWHt6
 OBqHXCwqppWJya+/TFkKXpZLn37V7vc/zDwU4or1+AAAA
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691689508; l=902;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=8aYgzmnUfjMZ2u3f2i9yQGK+3NqXmDs/UpCmbRyOvnE=;
 b=nXpy1jKPP+VdaQLBsIMXxMRnzjPY+hKYhSdsz8l3k0kTs/AJkgoH/hfMwjEEzQIH1I2JsMYJL
 rDJAH9VHcKXCqg1HVHrAf4RxUX5YDAqSdhaiW0wQBk6FYsnXbjUh0yc
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that some of the compatibles for either matching SMMU probe
or peripheral workarounds were lingering on my branch.

This series collects them in an effort to get them merged.

The bindings are all there.

I don't think it makes sense for me to look for the source series of
each patch.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (4):
      iommu/arm-smmu-qcom: Sort the compatible list alphabetically
      iommu/arm-smmu-qcom: Add SM6375 DPU compatible
      iommu/arm-smmu-qcom: Add SM6350 DPU compatible
      iommu/arm-smmu-qcom: Add SM6375 SMMUv2

 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)
---
base-commit: 21ef7b1e17d039053edaeaf41142423810572741
change-id: 20230810-topic-lost_smmu_compats-116f2e9f231a

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

