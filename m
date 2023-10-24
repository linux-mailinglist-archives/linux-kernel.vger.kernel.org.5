Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE697D5713
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 17:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344012AbjJXP56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 11:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343987AbjJXP5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 11:57:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40DF10CC
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 08:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698163071; x=1729699071;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sX1J1ySAF4MO+eRhktvw93+gXMSrlD5/6fA9bNgY1QY=;
  b=C3opeNF2seOgUTGsMEl2lEnuE9ga1Jh4Ew0aCaT6fbqrsOrBNy/chKF1
   RHWkY3LDsRR3Z83apl6kpiEP4SuvUSmvbqkf71Pu1Uu90/MsHDZ2psDnt
   et9q3BuKRunkNISPq2d49n4DsXes4sSCqxJT0zba6k11M1t7g6SFzLokH
   mImSwdapyiMDqI1b/jnVFhUAd3UNp61MQRP6WAjYWNXi+HDcaakKar53g
   LCJxrDXdvcttC/5WneDraopnxJW2aRvvjnu6CJh4lxSRhLMrql6qtndwk
   ASdbkGR7m/5W3hsl7ZjglOXa4S87J+tupmk0jS3i4HfFBp3y4GWqy6qqs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="8649808"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="8649808"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 08:57:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="902233873"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="902233873"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 24 Oct 2023 08:55:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 721B9C2E; Tue, 24 Oct 2023 18:57:42 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 7/7] drm/i915/iosf: Drop unused APIs
Date:   Tue, 24 Oct 2023 18:57:39 +0300
Message-Id: <20231024155739.3861342-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231024155739.3861342-1-andriy.shevchenko@linux.intel.com>
References: <20231024155739.3861342-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop unused vlv_iosf_sb_read() and vlv_iosf_sb_write().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

