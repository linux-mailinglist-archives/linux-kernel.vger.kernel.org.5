Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E41B768926
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 00:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjG3Wgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 18:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjG3Wgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 18:36:44 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E272999
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 15:36:42 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-7878e573827so149465239f.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 15:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690756602; x=1691361402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lDvvnEzdFIrdUiG83WsNjbCP3bQWatbIJ8fJqr65Lvk=;
        b=brm40JYbJ8D9cKsi0SYHbq2R8Px7z2MxFgw30dbmSpPNYS4S7dSh3moFhzNGY72RcY
         L4Uf8QsVR0JCAlT111GdXnMFLtJNi3t2AwkHldFldXvu/JLn4+GPI1w51LBgLyJrqNRG
         5uRhuWpzcqAr2z114rsG/fVBGkMxPRCMayXEkomolOyojgg3G/t7eiuV88hIU1hbAZlg
         7r4hQhDCgRsSAkBZtT7KfX9+UfFmu2mAiX7VwfmLmOb+LBNYHdxEp0GHlaIf8lGzZAFa
         QzlOoQrEFk5JteZGI/W8FBPzb4epOYKiTaoOC8aMGPWkw1cOPcSZgiyqqorZgJijGLtK
         HsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690756602; x=1691361402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lDvvnEzdFIrdUiG83WsNjbCP3bQWatbIJ8fJqr65Lvk=;
        b=KtczhDVtqQkfP15rPOMe4EaGPok3sFmH+r+68ozJpid6uc1Uuc9d7T76AiLeFCDFHP
         FdKZvNq1GSjbAgfTEQnqLAxhW1A7tGP0QUs2+Py6N5LvIz9KWJDuQRY9tQI1MCw8Ioin
         37PX7oKO87F8ynwAMDtN+sNRMISe854MbbNKarSavry1bB/jO9Ebl3bL0HNxmxIhP7bl
         yODFsZybovu654cXkP7eZFdqCi1brr94eDzJ/q+zCIJtav9anR2C7whNJGNa9Kyxdh/s
         /R8UzBp1XPnV+9v2RzvihlcYk85hJPtdtICUuUSv/adCbuxdCpGC0AITWykTWWBfCQVs
         LsQw==
X-Gm-Message-State: ABy/qLbydqARoAPxbcGtc12diekiwM0hBClgZsFLVcncr0RaBwIeDbAi
        VFTY9JVo4td/tZxxXj3xrds=
X-Google-Smtp-Source: APBJJlFSeTxbJz+kawr36922RXoKnx+mSdsRkXymnAy8jdS+NwJwYa0mEuVdDNb01tly07EVueCYsQ==
X-Received: by 2002:a5d:8701:0:b0:777:8e86:7702 with SMTP id u1-20020a5d8701000000b007778e867702mr6405754iom.16.1690756602215;
        Sun, 30 Jul 2023 15:36:42 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id s5-20020a5ec645000000b0077e24ace3edsm2935405ioo.52.2023.07.30.15.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 15:36:41 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     daniel@ffwll.ch, linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 1/1] drm_dbg: add trailing newlines to remaining callsites
Date:   Sun, 30 Jul 2023 16:36:31 -0600
Message-ID: <20230730223631.55295-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All callers should uniformly include a trailing newline, the vast
majority already do: 207 DRM_DEV_DEBUG, 1288 drm_dbg.  Clean up the
remainders, in this and next commits (split for easy acks).

No functional changes.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/drm_connector.c                |  4 +++-
 drivers/gpu/drm/i915/display/intel_ddi.c       |  2 +-
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c |  4 ++--
 drivers/gpu/drm/kmb/kmb_crtc.c                 | 10 +++++-----
 drivers/gpu/drm/kmb/kmb_plane.c                |  6 +++---
 drivers/gpu/drm/msm/msm_fb.c                   |  6 +++---
 drivers/gpu/drm/vc4/vc4_crtc.c                 |  4 ++--
 7 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 48df7a5ea503..39eab45649c8 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -2868,7 +2868,9 @@ int drm_mode_getconnector(struct drm_device *dev, void *data,
 						     dev->mode_config.max_width,
 						     dev->mode_config.max_height);
 		else
-			drm_dbg_kms(dev, "User-space requested a forced probe on [CONNECTOR:%d:%s] but is not the DRM master, demoting to read-only probe",
+			drm_dbg_kms(dev,
+				    "User-space requested a forced probe on [CONNECTOR:%d:%s] "
+				    "but is not the DRM master, demoting to read-only probe\n",
 				    connector->base.id, connector->name);
 	}
 
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
diff --git a/drivers/gpu/drm/kmb/kmb_crtc.c b/drivers/gpu/drm/kmb/kmb_crtc.c
index 647872f65bff..a58baf25322d 100644
--- a/drivers/gpu/drm/kmb/kmb_crtc.c
+++ b/drivers/gpu/drm/kmb/kmb_crtc.c
@@ -94,7 +94,7 @@ static void kmb_crtc_set_mode(struct drm_crtc *crtc,
 	vm.hback_porch = 0;
 	vm.hsync_len = 28;
 
-	drm_dbg(dev, "%s : %dactive height= %d vbp=%d vfp=%d vsync-w=%d h-active=%d h-bp=%d h-fp=%d hsync-l=%d",
+	drm_dbg(dev, "%s : %dactive height= %d vbp=%d vfp=%d vsync-w=%d h-active=%d h-bp=%d h-fp=%d hsync-l=%d\n",
 		__func__, __LINE__,
 			m->crtc_vdisplay, vm.vback_porch, vm.vfront_porch,
 			vm.vsync_len, m->crtc_hdisplay, vm.hback_porch,
@@ -194,24 +194,24 @@ static enum drm_mode_status
 	int vfp = mode->vsync_start - mode->vdisplay;
 
 	if (mode->vdisplay < KMB_CRTC_MAX_HEIGHT) {
-		drm_dbg(dev, "height = %d less than %d",
+		drm_dbg(dev, "height = %d less than %d\n",
 			mode->vdisplay, KMB_CRTC_MAX_HEIGHT);
 		return MODE_BAD_VVALUE;
 	}
 	if (mode->hdisplay < KMB_CRTC_MAX_WIDTH) {
-		drm_dbg(dev, "width = %d less than %d",
+		drm_dbg(dev, "width = %d less than %d\n",
 			mode->hdisplay, KMB_CRTC_MAX_WIDTH);
 		return MODE_BAD_HVALUE;
 	}
 	refresh = drm_mode_vrefresh(mode);
 	if (refresh < KMB_MIN_VREFRESH || refresh > KMB_MAX_VREFRESH) {
-		drm_dbg(dev, "refresh = %d less than %d or greater than %d",
+		drm_dbg(dev, "refresh = %d less than %d or greater than %d\n",
 			refresh, KMB_MIN_VREFRESH, KMB_MAX_VREFRESH);
 		return MODE_BAD;
 	}
 
 	if (vfp < KMB_CRTC_MIN_VFP) {
-		drm_dbg(dev, "vfp = %d less than %d", vfp, KMB_CRTC_MIN_VFP);
+		drm_dbg(dev, "vfp = %d less than %d\n", vfp, KMB_CRTC_MIN_VFP);
 		return MODE_BAD;
 	}
 
diff --git a/drivers/gpu/drm/kmb/kmb_plane.c b/drivers/gpu/drm/kmb/kmb_plane.c
index 9e0562aa2bcb..308bd1cb50c8 100644
--- a/drivers/gpu/drm/kmb/kmb_plane.c
+++ b/drivers/gpu/drm/kmb/kmb_plane.c
@@ -78,7 +78,7 @@ static unsigned int check_pixel_format(struct drm_plane *plane, u32 format)
 	 * plane configuration is not supported.
 	 */
 	if (init_disp_cfg.format && init_disp_cfg.format != format) {
-		drm_dbg(&kmb->drm, "Cannot change format after initial plane configuration");
+		drm_dbg(&kmb->drm, "Cannot change format after initial plane configuration\n");
 		return -EINVAL;
 	}
 	for (i = 0; i < plane->format_count; i++) {
@@ -124,7 +124,7 @@ static int kmb_plane_atomic_check(struct drm_plane *plane,
 	if ((init_disp_cfg.width && init_disp_cfg.height) &&
 	    (init_disp_cfg.width != fb->width ||
 	    init_disp_cfg.height != fb->height)) {
-		drm_dbg(&kmb->drm, "Cannot change plane height or width after initial configuration");
+		drm_dbg(&kmb->drm, "Cannot change plane height or width after initial configuration\n");
 		return -EINVAL;
 	}
 	can_position = (plane->type == DRM_PLANE_TYPE_OVERLAY);
@@ -375,7 +375,7 @@ static void kmb_plane_atomic_update(struct drm_plane *plane,
 	spin_lock_irq(&kmb->irq_lock);
 	if (kmb->kmb_under_flow || kmb->kmb_flush_done) {
 		spin_unlock_irq(&kmb->irq_lock);
-		drm_dbg(&kmb->drm, "plane_update:underflow!!!! returning");
+		drm_dbg(&kmb->drm, "plane_update:underflow!!!! returning\n");
 		return;
 	}
 	spin_unlock_irq(&kmb->irq_lock);
diff --git a/drivers/gpu/drm/msm/msm_fb.c b/drivers/gpu/drm/msm/msm_fb.c
index e3f61c39df69..80166f702a0d 100644
--- a/drivers/gpu/drm/msm/msm_fb.c
+++ b/drivers/gpu/drm/msm/msm_fb.c
@@ -89,7 +89,7 @@ int msm_framebuffer_prepare(struct drm_framebuffer *fb,
 
 	for (i = 0; i < n; i++) {
 		ret = msm_gem_get_and_pin_iova(fb->obj[i], aspace, &msm_fb->iova[i]);
-		drm_dbg_state(fb->dev, "FB[%u]: iova[%d]: %08llx (%d)",
+		drm_dbg_state(fb->dev, "FB[%u]: iova[%d]: %08llx (%d)\n",
 			      fb->base.id, i, msm_fb->iova[i], ret);
 		if (ret)
 			return ret;
@@ -176,7 +176,7 @@ static struct drm_framebuffer *msm_framebuffer_init(struct drm_device *dev,
 	const struct msm_format *format;
 	int ret, i, n;
 
-	drm_dbg_state(dev, "create framebuffer: mode_cmd=%p (%dx%d@%4.4s)",
+	drm_dbg_state(dev, "create framebuffer: mode_cmd=%p (%dx%d@%4.4s)\n",
 			mode_cmd, mode_cmd->width, mode_cmd->height,
 			(char *)&mode_cmd->pixel_format);
 
@@ -232,7 +232,7 @@ static struct drm_framebuffer *msm_framebuffer_init(struct drm_device *dev,
 
 	refcount_set(&msm_fb->dirtyfb, 1);
 
-	drm_dbg_state(dev, "create: FB ID: %d (%p)", fb->base.id, fb);
+	drm_dbg_state(dev, "create: FB ID: %d (%p)\n", fb->base.id, fb);
 
 	return fb;
 
diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index bef9d45ef1df..959123759711 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -592,7 +592,7 @@ static void vc4_crtc_atomic_disable(struct drm_crtc *crtc,
 	struct drm_encoder *encoder = vc4_get_crtc_encoder(crtc, old_state);
 	struct drm_device *dev = crtc->dev;
 
-	drm_dbg(dev, "Disabling CRTC %s (%u) connected to Encoder %s (%u)",
+	drm_dbg(dev, "Disabling CRTC %s (%u) connected to Encoder %s (%u)\n",
 		crtc->name, crtc->base.id, encoder->name, encoder->base.id);
 
 	require_hvs_enabled(dev);
@@ -620,7 +620,7 @@ static void vc4_crtc_atomic_enable(struct drm_crtc *crtc,
 	struct vc4_encoder *vc4_encoder = to_vc4_encoder(encoder);
 	int idx;
 
-	drm_dbg(dev, "Enabling CRTC %s (%u) connected to Encoder %s (%u)",
+	drm_dbg(dev, "Enabling CRTC %s (%u) connected to Encoder %s (%u)\n",
 		crtc->name, crtc->base.id, encoder->name, encoder->base.id);
 
 	if (!drm_dev_enter(dev, &idx))
-- 
2.41.0

