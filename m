Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507F7790D71
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 20:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345287AbjICSqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 14:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345063AbjICSqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 14:46:22 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D41E106
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 11:46:19 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-34e15f33a72so2712725ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 11:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693766778; x=1694371578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxH9YviFYJ/sVQ921jdxmjDcbIQzwn47fQGdVFEkDL8=;
        b=cq2HZh6b6GOnYbpYSHO1Dys1aYQihbKjqPAMpuzxFXKVDm/pdguK127Nq4DEJ5kens
         T0Z+zVXFtWI2oHobxBnkAo9UvFlq37hB4lVoqx0LIOIAlDXfg9Wt4vi5c0i+7keC+FvH
         AUv+ssSiLlSLmShjb5d7rn8V5jM56BooLPhSfIVfFxzk9JfDDk/0+HZAbbevd77S0Nej
         UJ1mKR7R4iC0/DF5JNnPyE6/h5D8Y9dZi9Iiu5gKRBQyet+jTvkjIvW4PKWrE36SHhMv
         038MijQHxUSv8e2/Eqqi9qY5/v9FK3uCuw12atSxnc3A5KMLwDysrTdnyNYdiJhw642o
         Bp6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693766778; x=1694371578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NxH9YviFYJ/sVQ921jdxmjDcbIQzwn47fQGdVFEkDL8=;
        b=PbkR5aEeZBt4XFBir9R8UNk7K2Mcm1lEMNJL56ws8khrJ0/finOTPl+Oz8FqgwIQWi
         2c+gePWOrp6Khb+5VG0kUAmRnBSW0tFdQY5beBWW/qd1u/hhQHuapZT2dZRh5OZrD1B0
         jWIOShKipYZssDx+Tm9jL/cpdRB3SNYE4tEaXremtBtVyvPshjMk/hTSapsVKK4p4WZO
         hvP6/49ab8Z3jg581/SHFddgDRZOfTsNxXir+Zf83cDQtlVNE7vfswq36kBra775URaG
         y+2RcqpSFXCezKfhmGnWgDIFYH0GdTWozi+3vXsniuBe439hDPsPVN4QMtDxjTTbNaIt
         EyaA==
X-Gm-Message-State: AOJu0Yzbp3Ba/jSq9qam6HG6CpMRoFaaoS2g686Yo8D0BP+Rkkb/E+3H
        FiVRf95eDY4ubhCcI1uQNxisGsiqvvdlQg==
X-Google-Smtp-Source: AGHT+IFaoNhYGsbvB6jznT4bSDBnIoFY2jvJJdHmVHBwkTi3nPyjBv03yWffGFhGkV6csSuj+h269g==
X-Received: by 2002:a92:dad2:0:b0:34d:e998:fb4f with SMTP id o18-20020a92dad2000000b0034de998fb4fmr7949087ilq.10.1693766778270;
        Sun, 03 Sep 2023 11:46:18 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id u9-20020a02cb89000000b0042b37dda71asm2519968jap.136.2023.09.03.11.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 11:46:17 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     daniel.vetter@ffwll.ch, daniel@ffwll.ch, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, Jim Cromie <jim.cromie@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Imre Deak <imre.deak@intel.com>,
        Radhakrishna Sripada <radhakrishna.sripada@intel.com>,
        Mika Kahola <mika.kahola@intel.com>,
        =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
        Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rob Clark <robdclark@chromium.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Fei Yang <fei.yang@intel.com>
Subject: [PATCH v2 3/6] drm_dbg: add trailing newlines to msgs
Date:   Sun,  3 Sep 2023 12:46:00 -0600
Message-ID: <20230903184607.272198-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230903184607.272198-1-jim.cromie@gmail.com>
References: <20230903184607.272198-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By at least strong convention, a print-buffer's trailing newline says
"message complete, send it".  The exception (no TNL, followed by a call
to pr_cont) proves the general rule.

Most DRM.debug calls already comport with this: 207 DRM_DEV_DEBUG,
1288 drm_dbg.  Clean up the remainders, in maintainer sized chunks.

No functional changes.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_ddi.c       | 2 +-
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index 090f242e610c..0a196348e2d1 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -4171,7 +4171,7 @@ static int intel_ddi_compute_config_late(struct intel_encoder *encoder,
 	struct drm_connector *connector = conn_state->connector;
 	u8 port_sync_transcoders = 0;
 
-	drm_dbg_kms(&i915->drm, "[ENCODER:%d:%s] [CRTC:%d:%s]",
+	drm_dbg_kms(&i915->drm, "[ENCODER:%d:%s] [CRTC:%d:%s]\n",
 		    encoder->base.base.id, encoder->base.name,
 		    crtc_state->uapi.crtc->base.id, crtc_state->uapi.crtc->name);
 
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
index cfd7929587d8..29c40e8a7183 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
@@ -1436,7 +1436,7 @@ eb_relocate_entry(struct i915_execbuffer *eb,
 	if (unlikely(reloc->write_domain & (reloc->write_domain - 1))) {
 		drm_dbg(&i915->drm, "reloc with multiple write domains: "
 			  "target %d offset %d "
-			  "read %08x write %08x",
+			  "read %08x write %08x\n",
 			  reloc->target_handle,
 			  (int) reloc->offset,
 			  reloc->read_domains,
@@ -1447,7 +1447,7 @@ eb_relocate_entry(struct i915_execbuffer *eb,
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

