Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FA07E0A35
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 21:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378307AbjKCUT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 16:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378213AbjKCUSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 16:18:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD911D66
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 13:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699042726; x=1730578726;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G27iSclFFumr76St5V1sfxdQObjKJmsJSwaDZg/d3AM=;
  b=gBkAMgYvbdO6u8qrzGTMhFoqMXlAtTKIRGLARbClRvWBAxln/ReKRZ+K
   QIQwhDYcfJwh0SUV9Fa0HILWXHz0hpQuaU9uFoxM5rtZve0W0iMadQ/wd
   2oTvIhO7Np7HhXqLLbQx5Q1jKoSEbBhMBEjwh6yMRfqbVqI0qp+Rqa5He
   hB34wnlYgPJSKvJZ0ixsWA0OgG7GG03dpeJ7Uudc+HpM/hDAL6hr8TQC2
   n9Ll0d/QSx/bm5wqEHn6H1Gbc6EZYxbj5nWmiSWMg2AZx8hYoIChebrHS
   poseMqOYdDt/MJOj6rrmniXzp7qXmbjJksiiqKtYaqISN3kLoU8VFxABA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="1896122"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="1896122"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 13:18:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="832131206"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="832131206"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 03 Nov 2023 13:18:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 607D97E7; Fri,  3 Nov 2023 22:18:34 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jani Nikula <jani.nikula@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v4 16/16] drm/i915/iosf: Drop unused APIs
Date:   Fri,  3 Nov 2023 22:18:31 +0200
Message-Id: <20231103201831.1037416-17-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231103201831.1037416-1-andriy.shevchenko@linux.intel.com>
References: <20231103201831.1037416-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop unused vlv_iosf_sb_read() and vlv_iosf_sb_write().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/vlv_sideband.c | 17 -----------------
 drivers/gpu/drm/i915/vlv_sideband.h |  3 ---
 2 files changed, 20 deletions(-)

diff --git a/drivers/gpu/drm/i915/vlv_sideband.c b/drivers/gpu/drm/i915/vlv_sideband.c
index b98dec3ad817..13b644958e38 100644
--- a/drivers/gpu/drm/i915/vlv_sideband.c
+++ b/drivers/gpu/drm/i915/vlv_sideband.c
@@ -166,23 +166,6 @@ u32 vlv_nc_read(struct drm_i915_private *i915, u8 addr)
 	return val;
 }
 
-u32 vlv_iosf_sb_read(struct drm_i915_private *i915, u8 port, u32 reg)
-{
-	u32 val = 0;
-
-	vlv_sideband_rw(i915, PCI_DEVFN(0, 0), port,
-			SB_CRRDDA_NP, reg, &val);
-
-	return val;
-}
-
-void vlv_iosf_sb_write(struct drm_i915_private *i915,
-		       u8 port, u32 reg, u32 val)
-{
-	vlv_sideband_rw(i915, PCI_DEVFN(0, 0), port,
-			SB_CRWRDA_NP, reg, &val);
-}
-
 u32 vlv_cck_read(struct drm_i915_private *i915, u32 reg)
 {
 	u32 val = 0;
diff --git a/drivers/gpu/drm/i915/vlv_sideband.h b/drivers/gpu/drm/i915/vlv_sideband.h
index 9ce283d96b80..8b4495e14bce 100644
--- a/drivers/gpu/drm/i915/vlv_sideband.h
+++ b/drivers/gpu/drm/i915/vlv_sideband.h
@@ -26,9 +26,6 @@ enum {
 };
 
 void vlv_iosf_sb_get(struct drm_i915_private *i915, unsigned long ports);
-u32 vlv_iosf_sb_read(struct drm_i915_private *i915, u8 port, u32 reg);
-void vlv_iosf_sb_write(struct drm_i915_private *i915,
-		       u8 port, u32 reg, u32 val);
 void vlv_iosf_sb_put(struct drm_i915_private *i915, unsigned long ports);
 
 static inline void vlv_bunit_get(struct drm_i915_private *i915)
-- 
2.40.0.1.gaa8946217a0b

