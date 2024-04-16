Return-Path: <linux-kernel+bounces-147496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 505788A7539
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F39F1283DAC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABB6139CE7;
	Tue, 16 Apr 2024 20:08:35 +0000 (UTC)
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [5.144.164.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BEE13957B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 20:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.144.164.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713298115; cv=none; b=QvionxeW4KJvBS4rssQx/njoLa3BiFAJ9rcgtKr0ZASkpYtpjKbElUYzw4bOR/i+/uwr3iZiyycq3E5mIhWasr1ey6/4bJ1X5XAfLX6/PnswUhQZkuguc+xDXB5LB6Zwmkj1jBiCMCa9EpgvVleXgaVCuYT1zTWiBcUf38d1n7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713298115; c=relaxed/simple;
	bh=qRh7xRHbySZ3iKo5O1/YWoUY0sugFkQPKKtUC5ZjmcQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IbIPuLfNhU+s3cT6T1AR7BJmTP4+iYLrPoYx6GqtcqQu72Q7icPfitaIfpUskzfSHXvRGNDTqDtPtfRd1bkMzPjF8t5PiOGOjUvECQ3S6kWLTxBwQm6aP5UhIMl8b4SCD39rx8xTBcKLERT7ALMTtqPvaloPfoMvFf0SlRGElOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org; spf=pass smtp.mailfrom=somainline.org; arc=none smtp.client-ip=5.144.164.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=somainline.org
Received: from Marijn-Arch-PC.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 88D633F434;
	Tue, 16 Apr 2024 21:29:45 +0200 (CEST)
From: Marijn Suijten <marijn.suijten@somainline.org>
Date: Tue, 16 Apr 2024 21:29:39 +0200
Subject: [PATCH] drm: Fix no_vblank field references in documentation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-drm-no_vblank-kdoc-link-v1-1-a1d8d1e9ff34@somainline.org>
X-B4-Tracking: v=1; b=H4sIAKLRHmYC/x2MQQqAIBAAvxJ7bkHLIvpKRJhutVQaChJEf0+6z
 RxmHogUmCL0xQOBEkf2LossCzCbdish2+xQiUoJJVu04UTnpzQf2u24W2/w4EwLaTk3tRCdriH
 XV6CF7/88jO/7AQakzM5pAAAA
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>
X-Mailer: b4 0.13.0

Browsing the DRM documentation shows that drm_crtc_state.no_vblank
is not turned into a reference to the no_vblank field, but rather a
reference to `struct drm_crtc_state`.  The only difference with other
field references is that the struct name is prefixed by the literal
`struct` tag, despite also already having a `&` reference prefix in two
of the three cases.  Remove the `struct` prefix to turn these references
into proper links to the designated field.

Fixes: 7beb691f1e6f ("drm: Initialize struct drm_crtc_state.no_vblank from device settings")
Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---
Note that a simple regex like "&struct \w+\.\w+" shows that there are
only a handful of violators, most of them inside DRM files.  Let me know
if you'd like a v2 that addresses all of them in one go (in separate
patches or one combined change)?

Kind regards,
Marijn
---
 drivers/gpu/drm/drm_vblank.c        | 2 +-
 include/drm/drm_crtc.h              | 2 +-
 include/drm/drm_simple_kms_helper.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 702a12bc93bd..45504732f98e 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -140,7 +140,7 @@
  * must not call drm_vblank_init(). For such drivers, atomic helpers will
  * automatically generate fake vblank events as part of the display update.
  * This functionality also can be controlled by the driver by enabling and
- * disabling struct drm_crtc_state.no_vblank.
+ * disabling &drm_crtc_state.no_vblank.
  */
 
 /* Retry timestamp calculation up to 3 times to satisfy
diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index 8b48a1974da3..eb75d0aec170 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -342,7 +342,7 @@ struct drm_crtc_state {
 	 *    that case.
 	 *
 	 * For very simple hardware without VBLANK interrupt, enabling
-	 * &struct drm_crtc_state.no_vblank makes DRM's atomic commit helpers
+	 * &drm_crtc_state.no_vblank makes DRM's atomic commit helpers
 	 * send a fake VBLANK event at the end of the display update after all
 	 * hardware changes have been applied. See
 	 * drm_atomic_helper_fake_vblank().
diff --git a/include/drm/drm_simple_kms_helper.h b/include/drm/drm_simple_kms_helper.h
index b2486d073763..6e64d91819e7 100644
--- a/include/drm/drm_simple_kms_helper.h
+++ b/include/drm/drm_simple_kms_helper.h
@@ -102,7 +102,7 @@ struct drm_simple_display_pipe_funcs {
 	 * drm_crtc_arm_vblank_event(), when the driver supports vblank
 	 * interrupt handling, or drm_crtc_send_vblank_event() for more
 	 * complex case. In case the hardware lacks vblank support entirely,
-	 * drivers can set &struct drm_crtc_state.no_vblank in
+	 * drivers can set &drm_crtc_state.no_vblank in
 	 * &struct drm_simple_display_pipe_funcs.check and let DRM's
 	 * atomic helper fake a vblank event.
 	 */

---
base-commit: 6bd343537461b57f3efe5dfc5fc193a232dfef1e
change-id: 20240416-drm-no_vblank-kdoc-link-fea1b53008a3

Best regards,
-- 
Marijn Suijten <marijn.suijten@somainline.org>


