Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A697A0E8E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 21:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbjINTxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 15:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjINTxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 15:53:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8425026B8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 12:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694721124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=q/dj/LCR0O5gsD/qpCJOxuH/Z8gNXnmeWxnQEV1TNGA=;
        b=bzWrrJdjf+2Cq3L+1YMc4b4ZSmw6WTLvrmpbhOFEET/GL73xjVcxF9dhL8UP/OhfR73+FA
        t4Paw8+yK0p3ngPCWLDgtpUIllfiK9+Fvw0NQhwUdyQdanYWM0r3W4iaSGZxi4I8/UboyB
        H+TGXLdWvsJD/PplXp/j8WN6ljzU0NA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-k2ubRpcONDOW3GRtwcoqMA-1; Thu, 14 Sep 2023 15:52:03 -0400
X-MC-Unique: k2ubRpcONDOW3GRtwcoqMA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f5df65fa35so10305245e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 12:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694721122; x=1695325922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q/dj/LCR0O5gsD/qpCJOxuH/Z8gNXnmeWxnQEV1TNGA=;
        b=PCSX77zp9cmFYfJeD11TFHrWK6XOI9eRnk9do4004AmpnQ2593Yp6U/QazUCCcFLVO
         ULpQO5bIWinYOJD0prUcGWofGeGNJjHlw9VEXPCpaAvOW5V3lUqffbTvlAzE6mP4ULQH
         +CnrPAZqzQpI8agmYydKgHHAXmfwLaI77Tk0VXyfQHc8mi1IeXCkoldF5reRjISXDJmS
         vjCf3+bM6svtx92fW2dMhjR1/+hoiDHFh0PPvB5PYlVbRaJp7cTviug6HjU301jUzPoM
         B6OhLXdUK6gn8jKX85AI08VswpO4L/BW1Hg4coHWJK5m+6Me/MlF0fxpQt7/YPTfJltY
         SZbg==
X-Gm-Message-State: AOJu0Yw7dBkkgOoXfvW3CTMSe5ZkEbEElymtSSjyGYC7XGoz+pd3KTg+
        G2zPDJJJ7E1Nf60i6cYQCo9aeFQsUSi1mKoDs9D7gBCOVsdjXT1p2Irdk3Qp2n1jg6HuLExu/m+
        NzsyFzxNYtXsVXRxdcK7/SpjO7Tq0fpZGclx7M9jxOXXFgLablPsPD8TChVHGQtENXjv2f7pcLw
        vE/47v0Hw=
X-Received: by 2002:a05:600c:2210:b0:401:bf56:8ba0 with SMTP id z16-20020a05600c221000b00401bf568ba0mr5485527wml.28.1694721121839;
        Thu, 14 Sep 2023 12:52:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQSOLQHLT5syA/mgJqXyvs7BJNeTPgNQRbQoKkAnj7HNnkkWxGFLTHIsAcaYufqvs9/KWSzw==
X-Received: by 2002:a05:600c:2210:b0:401:bf56:8ba0 with SMTP id z16-20020a05600c221000b00401bf568ba0mr5485511wml.28.1694721121444;
        Thu, 14 Sep 2023 12:52:01 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id s23-20020a7bc397000000b00403bbe69629sm2773069wmj.31.2023.09.14.12.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 12:52:01 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <mripard@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/ssd130x: Drop _helper prefix from struct drm_*_helper_funcs callbacks
Date:   Thu, 14 Sep 2023 21:51:24 +0200
Message-ID: <20230914195138.1518065-1-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver uses a naming convention where functions for struct drm_*_funcs
callbacks are named ssd130x_$object_$operation, while the callbacks for
struct drm_*_helper_funcs are named ssd130x_$object_helper_$operation.

The idea is that this helper_ prefix in the function names denote that are
for struct drm_*_helper_funcs callbacks. This convention was copied from
other drivers, when ssd130x was written but Maxime pointed out that is the
exception rather than the norm.

So let's get rid of the _helper prefixes from the function handlers names.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/solomon/ssd130x.c | 46 +++++++++++++++----------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 8ab02724f65f..245e4ba1c041 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -630,8 +630,8 @@ static int ssd130x_fb_blit_rect(struct drm_framebuffer *fb,
 	return ret;
 }
 
-static int ssd130x_primary_plane_helper_atomic_check(struct drm_plane *plane,
-						     struct drm_atomic_state *state)
+static int ssd130x_primary_plane_atomic_check(struct drm_plane *plane,
+					      struct drm_atomic_state *state)
 {
 	struct drm_device *drm = plane->dev;
 	struct ssd130x_device *ssd130x = drm_to_ssd130x(drm);
@@ -667,8 +667,8 @@ static int ssd130x_primary_plane_helper_atomic_check(struct drm_plane *plane,
 	return 0;
 }
 
-static void ssd130x_primary_plane_helper_atomic_update(struct drm_plane *plane,
-						       struct drm_atomic_state *state)
+static void ssd130x_primary_plane_atomic_update(struct drm_plane *plane,
+						struct drm_atomic_state *state)
 {
 	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
 	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state, plane);
@@ -701,8 +701,8 @@ static void ssd130x_primary_plane_helper_atomic_update(struct drm_plane *plane,
 	drm_dev_exit(idx);
 }
 
-static void ssd130x_primary_plane_helper_atomic_disable(struct drm_plane *plane,
-							struct drm_atomic_state *state)
+static void ssd130x_primary_plane_atomic_disable(struct drm_plane *plane,
+						 struct drm_atomic_state *state)
 {
 	struct drm_device *drm = plane->dev;
 	struct ssd130x_device *ssd130x = drm_to_ssd130x(drm);
@@ -777,9 +777,9 @@ static void ssd130x_primary_plane_destroy_state(struct drm_plane *plane,
 
 static const struct drm_plane_helper_funcs ssd130x_primary_plane_helper_funcs = {
 	DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
-	.atomic_check = ssd130x_primary_plane_helper_atomic_check,
-	.atomic_update = ssd130x_primary_plane_helper_atomic_update,
-	.atomic_disable = ssd130x_primary_plane_helper_atomic_disable,
+	.atomic_check = ssd130x_primary_plane_atomic_check,
+	.atomic_update = ssd130x_primary_plane_atomic_update,
+	.atomic_disable = ssd130x_primary_plane_atomic_disable,
 };
 
 static const struct drm_plane_funcs ssd130x_primary_plane_funcs = {
@@ -791,8 +791,8 @@ static const struct drm_plane_funcs ssd130x_primary_plane_funcs = {
 	.destroy = drm_plane_cleanup,
 };
 
-static enum drm_mode_status ssd130x_crtc_helper_mode_valid(struct drm_crtc *crtc,
-							   const struct drm_display_mode *mode)
+static enum drm_mode_status ssd130x_crtc_mode_valid(struct drm_crtc *crtc,
+						    const struct drm_display_mode *mode)
 {
 	struct ssd130x_device *ssd130x = drm_to_ssd130x(crtc->dev);
 
@@ -807,8 +807,8 @@ static enum drm_mode_status ssd130x_crtc_helper_mode_valid(struct drm_crtc *crtc
 	return MODE_OK;
 }
 
-static int ssd130x_crtc_helper_atomic_check(struct drm_crtc *crtc,
-					    struct drm_atomic_state *state)
+static int ssd130x_crtc_atomic_check(struct drm_crtc *crtc,
+				     struct drm_atomic_state *state)
 {
 	struct drm_device *drm = crtc->dev;
 	struct ssd130x_device *ssd130x = drm_to_ssd130x(drm);
@@ -882,8 +882,8 @@ static void ssd130x_crtc_destroy_state(struct drm_crtc *crtc,
  * the screen in the primary plane's atomic_disable function.
  */
 static const struct drm_crtc_helper_funcs ssd130x_crtc_helper_funcs = {
-	.mode_valid = ssd130x_crtc_helper_mode_valid,
-	.atomic_check = ssd130x_crtc_helper_atomic_check,
+	.mode_valid = ssd130x_crtc_mode_valid,
+	.atomic_check = ssd130x_crtc_atomic_check,
 };
 
 static const struct drm_crtc_funcs ssd130x_crtc_funcs = {
@@ -895,8 +895,8 @@ static const struct drm_crtc_funcs ssd130x_crtc_funcs = {
 	.atomic_destroy_state = ssd130x_crtc_destroy_state,
 };
 
-static void ssd130x_encoder_helper_atomic_enable(struct drm_encoder *encoder,
-						 struct drm_atomic_state *state)
+static void ssd130x_encoder_atomic_enable(struct drm_encoder *encoder,
+					  struct drm_atomic_state *state)
 {
 	struct drm_device *drm = encoder->dev;
 	struct ssd130x_device *ssd130x = drm_to_ssd130x(drm);
@@ -921,8 +921,8 @@ static void ssd130x_encoder_helper_atomic_enable(struct drm_encoder *encoder,
 	return;
 }
 
-static void ssd130x_encoder_helper_atomic_disable(struct drm_encoder *encoder,
-						  struct drm_atomic_state *state)
+static void ssd130x_encoder_atomic_disable(struct drm_encoder *encoder,
+					   struct drm_atomic_state *state)
 {
 	struct drm_device *drm = encoder->dev;
 	struct ssd130x_device *ssd130x = drm_to_ssd130x(drm);
@@ -935,15 +935,15 @@ static void ssd130x_encoder_helper_atomic_disable(struct drm_encoder *encoder,
 }
 
 static const struct drm_encoder_helper_funcs ssd130x_encoder_helper_funcs = {
-	.atomic_enable = ssd130x_encoder_helper_atomic_enable,
-	.atomic_disable = ssd130x_encoder_helper_atomic_disable,
+	.atomic_enable = ssd130x_encoder_atomic_enable,
+	.atomic_disable = ssd130x_encoder_atomic_disable,
 };
 
 static const struct drm_encoder_funcs ssd130x_encoder_funcs = {
 	.destroy = drm_encoder_cleanup,
 };
 
-static int ssd130x_connector_helper_get_modes(struct drm_connector *connector)
+static int ssd130x_connector_get_modes(struct drm_connector *connector)
 {
 	struct ssd130x_device *ssd130x = drm_to_ssd130x(connector->dev);
 	struct drm_display_mode *mode;
@@ -963,7 +963,7 @@ static int ssd130x_connector_helper_get_modes(struct drm_connector *connector)
 }
 
 static const struct drm_connector_helper_funcs ssd130x_connector_helper_funcs = {
-	.get_modes = ssd130x_connector_helper_get_modes,
+	.get_modes = ssd130x_connector_get_modes,
 };
 
 static const struct drm_connector_funcs ssd130x_connector_funcs = {
-- 
2.41.0

