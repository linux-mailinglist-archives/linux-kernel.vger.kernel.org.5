Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A75776889F
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 23:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjG3V60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 17:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjG3V6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 17:58:24 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55839171F
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 14:58:20 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-34642952736so21639965ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 14:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690754299; x=1691359099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOewQfiuna8cVbGW5XrkGFy/hH53YPAnw6xDAt3LB98=;
        b=DKqR8ijCyupw8t6lZBwoDKFigkZROGJMEnXL0h+oDYIWwrL9txDkSZwkw8qDxS3soa
         c3XjOLuZrGWsm9OD3KHhrpaHR8GLxe/CB5Ro1EaU9VacZqveIVmsH8CsmTBO++Xaw043
         S9c6oT2auG+ybCgccn4OLLiMrn6/XVSvAF3xW6fHj3I96dLrXCCEGBqomm+i4JrtxKNP
         4IzSucxKUjtCeXcpYBmuwY5QKkQKoRM3oL5rXZFv2h34c6/mpHNp06uALNOSgH9FacqC
         9CA1m/gl3qLd2CeJGFNDiLv4DsucE5zaM45Bd6PL+T/8Hi3WkinQ5SEFRhcOE5+BRjef
         0hQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690754299; x=1691359099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nOewQfiuna8cVbGW5XrkGFy/hH53YPAnw6xDAt3LB98=;
        b=ebC8DQPrVK0kOy6HQkJd8D/+5FC0KdEd4zBws4sTOmUyOwpZSvw9IZteHUjSBhxyQz
         6O/Xr/cDspBhpFFGXCeNQJvhJoL6kg3TqKcDbxaRZdX3TocW223vFZJNSDTJ++YCs0Mz
         6GD2hDUQsW6z2Ti16IxKhGH1OQBl+qI2/6xO7Bnn7v5s9AJuFmzCzRrHSNm16GIQF9nv
         b5B5C/YJ2TmdMNG0qe71D6MWyF7lzycFRhPN4fle6UKyx417v4in49wR/S4hWdwuFCfd
         llajfgIMQyzR2SexPt483U+0FjdzvDOwMaeM5sTb4SWNZCb30ypHDMwfrwRLqYOiyC48
         NI4w==
X-Gm-Message-State: ABy/qLZhR/N5IQoqwnVpE2nZL/8JdhI3PENaq0w/Wa8MCvZX7TyA9D9S
        oCy+eCb/ucReXRZ9iLjRvM8=
X-Google-Smtp-Source: APBJJlE+/l1vuBJeosdUA7YLF9Qwd6Adbkqlh0UuNChyRu2idYwLmWELfaF8uOq6UyjwQhIZGytVZw==
X-Received: by 2002:a05:6e02:134e:b0:340:8cb1:aaa8 with SMTP id k14-20020a056e02134e00b003408cb1aaa8mr6815096ilr.21.1690754299458;
        Sun, 30 Jul 2023 14:58:19 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e18-20020a92de52000000b003424b3d6d37sm2747520ilr.24.2023.07.30.14.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 14:58:19 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     daniel@ffwll.ch, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Jim Cromie <jim.cromie@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Imre Deak <imre.deak@intel.com>,
        Mika Kahola <mika.kahola@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rob Clark <robdclark@chromium.org>,
        Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: [PATCH 2/5] drm_dbg: add trailing newlines
Date:   Sun, 30 Jul 2023 15:57:51 -0600
Message-ID: <20230730215758.54010-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230730215758.54010-1-jim.cromie@gmail.com>
References: <20230730215758.54010-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_ddi.c       | 2 +-
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index 3a7b98837516..993ba9f01018 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -3808,7 +3808,7 @@ static int intel_ddi_compute_config_late(struct intel_encoder *encoder,
 	struct drm_connector *connector = conn_state->connector;
 	u8 port_sync_transcoders = 0;
 
-	drm_dbg_kms(&i915->drm, "[ENCODER:%d:%s] [CRTC:%d:%s]",
+	drm_dbg_kms(&i915->drm, "[ENCODER:%d:%s] [CRTC:%d:%s]\n",
 		    encoder->base.base.id, encoder->base.name,
 		    crtc_state->uapi.crtc->base.id, crtc_state->uapi.crtc->name);
 
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
index 3aeede6aee4d..c7daae828792 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
@@ -1428,7 +1428,7 @@ eb_relocate_entry(struct i915_execbuffer *eb,
 	if (unlikely(reloc->write_domain & (reloc->write_domain - 1))) {
 		drm_dbg(&i915->drm, "reloc with multiple write domains: "
 			  "target %d offset %d "
-			  "read %08x write %08x",
+			  "read %08x write %08x\n",
 			  reloc->target_handle,
 			  (int) reloc->offset,
 			  reloc->read_domains,
@@ -1439,7 +1439,7 @@ eb_relocate_entry(struct i915_execbuffer *eb,
 		     & ~I915_GEM_GPU_DOMAINS)) {
 		drm_dbg(&i915->drm, "reloc with read/write non-GPU domains: "
 			  "target %d offset %d "
-			  "read %08x write %08x",
+			  "read %08x write %08x\n",
 			  reloc->target_handle,
 			  (int) reloc->offset,
 			  reloc->read_domains,
-- 
2.41.0

