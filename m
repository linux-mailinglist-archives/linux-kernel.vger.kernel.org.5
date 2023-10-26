Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48AAD7D7BD3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 06:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbjJZEpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 00:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjJZEp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 00:45:26 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E8CD7A
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 21:45:18 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-694ed847889so415969b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 21:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698295517; x=1698900317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vu8QLeYUjZNbSnkixSTXmF2Y28p223rbJ5vKgFenCLg=;
        b=YsOtR5auba7dnsEL1azH4h3eaOTRnyMwayDz/orvRQqyIGXQ8vqKYd74OJvkuWwRVB
         ag+MKJOFXvp/Jd1zMEoxtuTaSyDJWxVCwXepkzWAxtSFg0LPSUpg6REe084JojtUtO4n
         OCBCoNxvn7yfw1f51lBEfm+rDHgFKvTnbSelXnHS2XCRCefwbqzVFlqYezPJk4HLJW5Y
         iDwa6wPTNh9fPbd+qU0ChxGve1jDea7JBervZfA7OUw9C4M56h38QOylT4xh0bHujKtW
         eIM154IEAwTLQX6KOgvKUE9u+Py/N1jfhMkzDPSySTJqHuBgSbQyFxZiBIS54K6J6fhI
         fiIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698295517; x=1698900317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vu8QLeYUjZNbSnkixSTXmF2Y28p223rbJ5vKgFenCLg=;
        b=excDijl6fXfY7gUy3GTBdSmfMjTnd72RpyUh12FsOOAvkjsR93RNJw6NaWKxSsEqAm
         sAcPswmhAaoqO+dQ0h17X8WBAM5SK7JWGVSIsq8k6Jr8i+TYTwtyGs4kIo6Yx314vp2d
         NGkO8v2kDS8/4pVP/QYr1RTOW35I6uCaIoFUwS+k8Kdk8/IFBMnq7oziGFQrrL0xG690
         4/nC5daQZ09jxJu7llUeMZuLORCpAaSriKfniDOylKPd3HAOfcA1SsmLAQ2jjpSn9GlO
         BjojylvmX+JmqftOzjxu9G+Bu7F8MxgiOhL0rbeMiBwCpjMFaqdOWK/Lbzr0GHXQi79V
         c3CA==
X-Gm-Message-State: AOJu0YwGgTKPFyFyi4KryZrIFYgagadsXdX2ztBoNfORvZO4Ik2dgbJd
        25waH/P900ChqJa1imwHlY60sb0EJNgCsw==
X-Google-Smtp-Source: AGHT+IHmLx1vjbCUmM6pGN0s+FyIMFfTEfVvUbiEiM3526beXxMOKxTQqToByDEvSkrLS32RNXfE8A==
X-Received: by 2002:a05:6a00:24cd:b0:6be:5367:2131 with SMTP id d13-20020a056a0024cd00b006be53672131mr18403694pfv.24.1698295517258;
        Wed, 25 Oct 2023 21:45:17 -0700 (PDT)
Received: from Negi (2603-8000-b93d-20a0-3476-69a5-23d3-7dbd.res6.spectrum.com. [2603:8000:b93d:20a0:3476:69a5:23d3:7dbd])
        by smtp.gmail.com with ESMTPSA id k6-20020a63f006000000b005b6c1972c99sm9680031pgh.7.2023.10.25.21.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 21:45:16 -0700 (PDT)
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Soumya Negi <soumya.negi97@gmail.com>,
        Andi Shyti <andi.shyti@intel.com>,
        Karolina Stolarek <karolina.stolarek@intel.com>,
        Prathap Kumar Valsan <prathap.kumar.valsan@intel.com>,
        Aravind Iddamsetty <aravind.iddamsetty@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915/gt: Remove {} from if-else
Date:   Wed, 25 Oct 2023 21:43:08 -0700
Message-ID: <20231026044309.17213-1-soumya.negi97@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In accordance to Linux coding style(Documentation/process/4.Coding.rst),
remove unneeded braces from if-else block as all arms of this block
contain single statements.

Suggested-by: Andi Shyti <andi.shyti@intel.com>
Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
---
 drivers/gpu/drm/i915/gt/intel_ggtt.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_ggtt.c b/drivers/gpu/drm/i915/gt/intel_ggtt.c
index 1c93e84278a0..9f6f9e138532 100644
--- a/drivers/gpu/drm/i915/gt/intel_ggtt.c
+++ b/drivers/gpu/drm/i915/gt/intel_ggtt.c
@@ -226,16 +226,15 @@ static void guc_ggtt_invalidate(struct i915_ggtt *ggtt)
 	gen8_ggtt_invalidate(ggtt);
 
 	list_for_each_entry(gt, &ggtt->gt_list, ggtt_link) {
-		if (intel_guc_tlb_invalidation_is_available(&gt->uc.guc)) {
+		if (intel_guc_tlb_invalidation_is_available(&gt->uc.guc))
 			guc_ggtt_ct_invalidate(gt);
-		} else if (GRAPHICS_VER(i915) >= 12) {
+		else if (GRAPHICS_VER(i915) >= 12)
 			intel_uncore_write_fw(gt->uncore,
 					      GEN12_GUC_TLB_INV_CR,
 					      GEN12_GUC_TLB_INV_CR_INVALIDATE);
-		} else {
+		else
 			intel_uncore_write_fw(gt->uncore,
 					      GEN8_GTCR, GEN8_GTCR_INVALIDATE);
-		}
 	}
 }
 
-- 
2.42.0

