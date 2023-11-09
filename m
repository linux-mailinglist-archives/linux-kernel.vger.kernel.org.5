Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B840C7E7026
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 18:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344626AbjKIR0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 12:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344553AbjKIR0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 12:26:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6015830FA
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 09:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699550715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3EBII1piFhjDdYePPF4sEFQnIWSSXfwKWEcUhw8jHaI=;
        b=AkaT3X+C70YZEDmRr1fQuX43C3XgcEcpKuh2fPki+Wonco1CQavsnFjR7S6aQz3qZXrDPs
        pG5p5rID5c3DKwke8OD8ASj+9adTCcXaYyYTfm8jnYm+QMTo763dQXYS1LxQV64GbBt1AI
        Ve5ryFHrhfKkMGDNtFPcyflnFOlearM=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-NUZBN8a4O5G8MitdLp5h2g-1; Thu, 09 Nov 2023 12:25:10 -0500
X-MC-Unique: NUZBN8a4O5G8MitdLp5h2g-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-507d2e150c2so1103324e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 09:25:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699550708; x=1700155508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3EBII1piFhjDdYePPF4sEFQnIWSSXfwKWEcUhw8jHaI=;
        b=MKFyGxZqkwEO1YeBW9qznMkZ4SEM6BDk7tEiwPH2wqjNxDQV6QcGEtowd9/8pCjz2/
         1JqJZ9gtI4uDwShwrvrEUF3rD8JL5eHh/4xnz9Y5M27fxvAqmIzIlffsd4JfO6F9Z3gR
         9eB7nM9fNOwovwyCstom040rnLoZr1cdnciZJpC0SixJiCkqrUhw8rq+4lHrEEFg/5XW
         nT+N3EnFI7QEjSG+jii/PX6K8TzdgxgwkoTiJBNFj0so1cEhUFICfcJeFZv+TAalI1Fo
         GyPYhtDOL7Ev+oQOg05b3U1OZPNk6u3iQLny11lO7YYf1oBuZNHNNYiOchqGmlR+zqnb
         buqQ==
X-Gm-Message-State: AOJu0YwuS2+GPTQebDrF+UE/Q/y4qF7kcLTcuO8leY8dZfyEDyWOcMEA
        OT8xvk6v0Ai3hIZjnexp8GaqHVO7RppiEM2sTlsxCVCA2c4dEK0OovXOj/S1DmB0R2VBjZYwC08
        jzkLGLn3nlqSJMc5SGeZ63lElRc0R55vfv+BxhXaUSEfDHlLTF8L/yv0UVPBHhs8kXi+2PexDq2
        Eoc8i8S50=
X-Received: by 2002:a19:e00d:0:b0:503:32bb:d5ca with SMTP id x13-20020a19e00d000000b0050332bbd5camr1864097lfg.31.1699550708448;
        Thu, 09 Nov 2023 09:25:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH47EfQ6rX+t1XL8dC+Is/tx0yp1WtqPF4aXtdXPWPqw3Pqau19ZWSC5+9vmC1RAuAaGC1wqw==
X-Received: by 2002:a19:e00d:0:b0:503:32bb:d5ca with SMTP id x13-20020a19e00d000000b0050332bbd5camr1864072lfg.31.1699550707984;
        Thu, 09 Nov 2023 09:25:07 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q14-20020a05600000ce00b003143c9beeaesm133795wrx.44.2023.11.09.09.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 09:25:07 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Simon Ser <contact@emersion.fr>,
        Sima Vetter <daniel.vetter@ffwll.ch>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Maxime Ripard <mripard@kernel.org>,
        Bilal Elmoussaoui <belmouss@redhat.com>,
        Erico Nunes <nunes.erico@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        stable@vger.kernel.org,
        nerdopolis <bluescreen_avenger@verizon.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 1/6] drm: Move drm_atomic_helper_damage_{iter_init,merged}() to helpers
Date:   Thu,  9 Nov 2023 18:24:35 +0100
Message-ID: <20231109172449.1599262-2-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231109172449.1599262-1-javierm@redhat.com>
References: <20231109172449.1599262-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need a similar drm_atomic_helper_buffer_damage_merged() helper function
that takes into account if a framebuffer attached to the plane has changed
since the last plane update (page-flip).

Since both damage helpers will share most of the current logic, move it to
an internal helper. The drm_atomic_helper_buffer_damage_merged() will have
to use a different drm_atomic_helper_buffer_damage_iter_init() function so
move that logic also to an internal helper.

Fixes: 01f05940a9a7 ("drm/virtio: Enable fb damage clips property for the primary plane")
Cc: <stable@vger.kernel.org> # v6.4+
Reported-by: nerdopolis <bluescreen_avenger@verizon.net>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218115
Suggested-by: Sima Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/drm_damage_helper.c | 95 +++++++++++++++++------------
 1 file changed, 55 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/drm_damage_helper.c b/drivers/gpu/drm/drm_damage_helper.c
index d8b2955e88fd..aa2325567918 100644
--- a/drivers/gpu/drm/drm_damage_helper.c
+++ b/drivers/gpu/drm/drm_damage_helper.c
@@ -201,28 +201,10 @@ int drm_atomic_helper_dirtyfb(struct drm_framebuffer *fb,
 }
 EXPORT_SYMBOL(drm_atomic_helper_dirtyfb);
 
-/**
- * drm_atomic_helper_damage_iter_init - Initialize the damage iterator.
- * @iter: The iterator to initialize.
- * @old_state: Old plane state for validation.
- * @state: Plane state from which to iterate the damage clips.
- *
- * Initialize an iterator, which clips plane damage
- * &drm_plane_state.fb_damage_clips to plane &drm_plane_state.src. This iterator
- * returns full plane src in case damage is not present because either
- * user-space didn't sent or driver discarded it (it want to do full plane
- * update). Currently this iterator returns full plane src in case plane src
- * changed but that can be changed in future to return damage.
- *
- * For the case when plane is not visible or plane update should not happen the
- * first call to iter_next will return false. Note that this helper use clipped
- * &drm_plane_state.src, so driver calling this helper should have called
- * drm_atomic_helper_check_plane_state() earlier.
- */
-void
-drm_atomic_helper_damage_iter_init(struct drm_atomic_helper_damage_iter *iter,
-				   const struct drm_plane_state *old_state,
-				   const struct drm_plane_state *state)
+static void
+__drm_atomic_helper_damage_iter_init(struct drm_atomic_helper_damage_iter *iter,
+				     const struct drm_plane_state *old_state,
+				     const struct drm_plane_state *state)
 {
 	struct drm_rect src;
 	memset(iter, 0, sizeof(*iter));
@@ -247,6 +229,32 @@ drm_atomic_helper_damage_iter_init(struct drm_atomic_helper_damage_iter *iter,
 		iter->full_update = true;
 	}
 }
+
+/**
+ * drm_atomic_helper_damage_iter_init - Initialize the damage iterator.
+ * @iter: The iterator to initialize.
+ * @old_state: Old plane state for validation.
+ * @state: Plane state from which to iterate the damage clips.
+ *
+ * Initialize an iterator, which clips plane damage
+ * &drm_plane_state.fb_damage_clips to plane &drm_plane_state.src. This iterator
+ * returns full plane src in case damage is not present because either
+ * user-space didn't sent or driver discarded it (it want to do full plane
+ * update). Currently this iterator returns full plane src in case plane src
+ * changed but that can be changed in future to return damage.
+ *
+ * For the case when plane is not visible or plane update should not happen the
+ * first call to iter_next will return false. Note that this helper use clipped
+ * &drm_plane_state.src, so driver calling this helper should have called
+ * drm_atomic_helper_check_plane_state() earlier.
+ */
+void
+drm_atomic_helper_damage_iter_init(struct drm_atomic_helper_damage_iter *iter,
+				   const struct drm_plane_state *old_state,
+				   const struct drm_plane_state *state)
+{
+	__drm_atomic_helper_damage_iter_init(iter, old_state, state);
+}
 EXPORT_SYMBOL(drm_atomic_helper_damage_iter_init);
 
 /**
@@ -291,24 +299,9 @@ drm_atomic_helper_damage_iter_next(struct drm_atomic_helper_damage_iter *iter,
 }
 EXPORT_SYMBOL(drm_atomic_helper_damage_iter_next);
 
-/**
- * drm_atomic_helper_damage_merged - Merged plane damage
- * @old_state: Old plane state for validation.
- * @state: Plane state from which to iterate the damage clips.
- * @rect: Returns the merged damage rectangle
- *
- * This function merges any valid plane damage clips into one rectangle and
- * returns it in @rect.
- *
- * For details see: drm_atomic_helper_damage_iter_init() and
- * drm_atomic_helper_damage_iter_next().
- *
- * Returns:
- * True if there is valid plane damage otherwise false.
- */
-bool drm_atomic_helper_damage_merged(const struct drm_plane_state *old_state,
-				     struct drm_plane_state *state,
-				     struct drm_rect *rect)
+static bool __drm_atomic_helper_damage_merged(const struct drm_plane_state *old_state,
+					      struct drm_plane_state *state,
+					      struct drm_rect *rect)
 {
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_rect clip;
@@ -330,4 +323,26 @@ bool drm_atomic_helper_damage_merged(const struct drm_plane_state *old_state,
 
 	return valid;
 }
+
+/**
+ * drm_atomic_helper_damage_merged - Merged plane damage
+ * @old_state: Old plane state for validation.
+ * @state: Plane state from which to iterate the damage clips.
+ * @rect: Returns the merged damage rectangle
+ *
+ * This function merges any valid plane damage clips into one rectangle and
+ * returns it in @rect.
+ *
+ * For details see: drm_atomic_helper_damage_iter_init() and
+ * drm_atomic_helper_damage_iter_next().
+ *
+ * Returns:
+ * True if there is valid plane damage otherwise false.
+ */
+bool drm_atomic_helper_damage_merged(const struct drm_plane_state *old_state,
+				     struct drm_plane_state *state,
+				     struct drm_rect *rect)
+{
+	return __drm_atomic_helper_damage_merged(old_state, state, rect);
+}
 EXPORT_SYMBOL(drm_atomic_helper_damage_merged);
-- 
2.41.0

