Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6F97F0587
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 11:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjKSK52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 05:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjKSK5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 05:57:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB0C12D
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 02:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700391440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vwKTxIgr09omGUBF1m9vDxqCyG9hQEMime1yIZzuygQ=;
        b=P7NcHxhQNDMz+CI2Pw8/UlvaUPb3Kj/rDX33ebkCHGBolJjVSiNvjJH6WnJhKbXdZeMyu1
        dAK/esyr4ZEMmoB6Fhz+/4sarUGeufApyLTUWk3voFywSK5vL+sveLsyiYXvYaGBRoIW3A
        XmVrRL4HMFXkjS5GZJbBrB5VYsxA2gQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-2Psi8spXN4iwDzE3kskNYg-1; Sun, 19 Nov 2023 05:57:18 -0500
X-MC-Unique: 2Psi8spXN4iwDzE3kskNYg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40a4c765d3bso5259665e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 02:57:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700391436; x=1700996236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vwKTxIgr09omGUBF1m9vDxqCyG9hQEMime1yIZzuygQ=;
        b=W/WextvEb1l+OmTxhsJXj7IeSPZmYtDB5PQOUHKgAbk4QEWRLgRsWxPr7KQHOuT7Vp
         gcu+AEA3GYUe1ug12XCOaqiA6TUTyxAO9vpU/Y1A1mLUOcl5pB4rFvvO5TA236W/ywke
         LU9OwAqgouSP3PFH+TtpzI+LaNMft1Dq++WyO6V8gImMBM2XsiEb3197Y8m1PLzXNNbz
         rBCMEy11GxaQdEbZMCZX4g3yL8B/06JX/U3xvT+x40n74M0l6Z1/r7EDkgh8rFgeU6FJ
         iSc9O4sHUvnQ3NabwoUAmAINTCezxPTkx0cDiwAtH8l+qkBte0HETe8quVuWfDafj80P
         aRZA==
X-Gm-Message-State: AOJu0Yx3SndItXBO13v4W8IyAOvIfQvRZh8bpC8igdOilxGUQXhCSotL
        BJ4zLNNFjUDg76XtlafZRHptM8RnbY2eqgoBBMGapnVglxiDEkc/KyKdRvQIEMX5+fr3sWGgY/1
        OT7bqNFwJ76du1EcdZLPj6HLVIICZBPYeOnhaUMuBYfRiQTwX2NgJZ0BixNCI7opk9vOVaOhtY8
        AEi2Jj79M=
X-Received: by 2002:a05:600c:a48:b0:401:b425:2414 with SMTP id c8-20020a05600c0a4800b00401b4252414mr8849702wmq.18.1700391436529;
        Sun, 19 Nov 2023 02:57:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTr3xemuWiX3MZFy4qGqbNac/hdlijHFi83h7o6vBK3ccLPETc7+WJcogKeoinWFEMLApjFA==
X-Received: by 2002:a05:600c:a48:b0:401:b425:2414 with SMTP id c8-20020a05600c0a4800b00401b4252414mr8849674wmq.18.1700391436164;
        Sun, 19 Nov 2023 02:57:16 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o2-20020a05600c510200b0040a4835d2b2sm14233407wms.37.2023.11.19.02.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 02:57:14 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Sima Vetter <daniel.vetter@ffwll.ch>,
        Erico Nunes <nunes.erico@gmail.com>,
        Simon Ser <contact@emersion.fr>,
        Bilal Elmoussaoui <belmouss@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        stable@vger.kernel.org,
        nerdopolis <bluescreen_avenger@verizon.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v3 1/5] drm: Allow drivers to indicate the damage helpers to ignore damage clips
Date:   Sun, 19 Nov 2023 11:56:57 +0100
Message-ID: <20231119105709.3143489-2-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231119105709.3143489-1-javierm@redhat.com>
References: <20231119105709.3143489-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It allows drivers to set a struct drm_plane_state .ignore_damage_clips in
their plane's .atomic_check callback, as an indication to damage helpers
such as drm_atomic_helper_damage_iter_init() that the damage clips should
be ignored.

To be used by drivers that do per-buffer (e.g: virtio-gpu) uploads (rather
than per-plane uploads), since these type of drivers need to handle buffer
damages instead of frame damages.

That way, these drivers could force a full plane update if the framebuffer
attached to a plane's state has changed since the last update (page-flip).

Fixes: 01f05940a9a7 ("drm/virtio: Enable fb damage clips property for the primary plane")
Cc: <stable@vger.kernel.org> # v6.4+
Reported-by: nerdopolis <bluescreen_avenger@verizon.net>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218115
Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
---

(no changes since v2)

Changes in v2:
- Add a struct drm_plane_state .ignore_damage_clips to set in the plane's
  .atomic_check, instead of having different helpers (Thomas Zimmermann).

 drivers/gpu/drm/drm_damage_helper.c | 3 ++-
 include/drm/drm_plane.h             | 8 ++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_damage_helper.c b/drivers/gpu/drm/drm_damage_helper.c
index d8b2955e88fd..afb02aae707b 100644
--- a/drivers/gpu/drm/drm_damage_helper.c
+++ b/drivers/gpu/drm/drm_damage_helper.c
@@ -241,7 +241,8 @@ drm_atomic_helper_damage_iter_init(struct drm_atomic_helper_damage_iter *iter,
 	iter->plane_src.x2 = (src.x2 >> 16) + !!(src.x2 & 0xFFFF);
 	iter->plane_src.y2 = (src.y2 >> 16) + !!(src.y2 & 0xFFFF);
 
-	if (!iter->clips || !drm_rect_equals(&state->src, &old_state->src)) {
+	if (!iter->clips || state->ignore_damage_clips ||
+	    !drm_rect_equals(&state->src, &old_state->src)) {
 		iter->clips = NULL;
 		iter->num_clips = 0;
 		iter->full_update = true;
diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
index 79d62856defb..cc2e8fc35fd2 100644
--- a/include/drm/drm_plane.h
+++ b/include/drm/drm_plane.h
@@ -190,6 +190,14 @@ struct drm_plane_state {
 	 */
 	struct drm_property_blob *fb_damage_clips;
 
+	/**
+	 * @ignore_damage_clips:
+	 *
+	 * Set by drivers to indicate the drm_atomic_helper_damage_iter_init()
+	 * helper that the @fb_damage_clips blob property should be ignored.
+	 */
+	bool ignore_damage_clips;
+
 	/**
 	 * @src:
 	 *
-- 
2.41.0

