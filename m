Return-Path: <linux-kernel+bounces-14334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9746E821B8D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 045FD1F22710
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC01FBEA;
	Tue,  2 Jan 2024 12:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZYgqSlEA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E18FBE7
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 12:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704198137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5aXs8fUOsfgSo7g4FENf0GEgJl7/TE420KVs2VRDTFk=;
	b=ZYgqSlEAx91KUrF65ejZlCVF6MZozKckfYHiGvIouWpWzP0sEZAqkD6j+2Fkoulx6IWWHj
	rMQpIGpkhwmKkr47lp1y7e668BDr7BHYkMWXnw0nMbF+G9EYolmGTBaH0HO8WoaEv5MAjj
	1AJC8hLOF+butRAZbqp+tcWYslg012o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-Rg4wQkEKOSCpXSc9xsn4NQ-1; Tue, 02 Jan 2024 07:22:16 -0500
X-MC-Unique: Rg4wQkEKOSCpXSc9xsn4NQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-336937b3cf5so5917198f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 04:22:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704198134; x=1704802934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5aXs8fUOsfgSo7g4FENf0GEgJl7/TE420KVs2VRDTFk=;
        b=soDxyFNbnw7fffGPPhRmxsCRdP6FeZVYLt0pEd4Nzfr4k/jcCc1PY76zRF8v6kq5jj
         aHT2FZ1xCSOx5RmJzS/oJ28GHVcGl6GE67OY5mdkZcmWm5Zg/3C4NE6mP2yMItdSUll/
         261gv00siCsqeH1q3/f0MKqU/SFEIAp4+dTXwLL7i/A3RIX33XSVcG2Ihx6evqt0YOxV
         bVVv8N9EhRO8WO+kEAE+b7FzRgzeet07JXVE0M0i6A+9A+ibEOTrjUjARVahkCVIH3AS
         aTRW27e++Trw0uHFoBnvXJkzIgDZQlFoDZ731LErOn8AOx0Syn82RblXUQjFTtxipRd2
         y36w==
X-Gm-Message-State: AOJu0YxRAu5vxSNrLQo/WbkVU0mmjht/k3N2HpeQBh7ryy4XO7od2Bzw
	xxLspg5hz9ka1fiG4Pp1kSh39DkbO/DtByL+zuYBuT2erklHV2vJ7Ppa2McO5ldzr49oeggLnkN
	9KMKVX4Ix3HlCczSFvRz1xBU/D0zF8702Ht81tyIle6pJuYLk7kdcu28KK9WZO7NVdhd/DeCLxo
	xI3jWN0/lS9NAMuy/tCA==
X-Received: by 2002:adf:f58d:0:b0:336:ded0:a21e with SMTP id f13-20020adff58d000000b00336ded0a21emr3259647wro.21.1704198134216;
        Tue, 02 Jan 2024 04:22:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRzyq3ECGhE9uzQkndDD77jnVmiC48z9vPhud+jf0jfsJN08yinyqi/3Ri/Y5bqogVnlgMHA==
X-Received: by 2002:adf:f58d:0:b0:336:ded0:a21e with SMTP id f13-20020adff58d000000b00336ded0a21emr3259636wro.21.1704198133875;
        Tue, 02 Jan 2024 04:22:13 -0800 (PST)
Received: from localhost (red-hat-inc.vlan560.asr1.mad1.gblx.net. [159.63.51.90])
        by smtp.gmail.com with ESMTPSA id q5-20020a056000136500b003372c080acasm9421283wrz.2.2024.01.02.04.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 04:22:13 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2] drm: Move drm_set_preferred_mode() helper from drm_edid to drm_modes
Date: Tue,  2 Jan 2024 13:21:58 +0100
Message-ID: <20240102122208.3103597-1-javierm@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The helper is generic, it doesn't use the opaque EDID type struct drm_edid
and is also used by drivers that only support non-probeable displays such
as fixed panels.

These drivers add a list of modes using drm_mode_probed_add() and then set
a preferred mode using the drm_set_preferred_mode() helper.

It seems more logical to have the helper definition in drm_modes.o instead
of drm_edid.o, since the former contains modes helper while the latter has
helpers to manage the EDID information.

Since both drm_edid.o and drm_modes.o object files are built-in the drm.o
object, there are no functional changes. But besides being a more logical
place for this helper, it could also allow to eventually make drm_edid.o
optional and not included in drm.o if only fixed panels must be supported
in a given system.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
---

Changes in v2:
- Drop unnecessary drm_modes.h header include in drm_edid.c (Jani Nikula).
- Add Jani Nikula's Reviewed-by tag.

 drivers/gpu/drm/drm_edid.c  | 22 ----------------------
 drivers/gpu/drm/drm_modes.c | 22 ++++++++++++++++++++++
 include/drm/drm_edid.h      |  2 --
 include/drm/drm_modes.h     |  2 ++
 4 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index cb4031d5dcbb..e677dc8eb7a9 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -6989,28 +6989,6 @@ int drm_add_modes_noedid(struct drm_connector *connector,
 }
 EXPORT_SYMBOL(drm_add_modes_noedid);
 
-/**
- * drm_set_preferred_mode - Sets the preferred mode of a connector
- * @connector: connector whose mode list should be processed
- * @hpref: horizontal resolution of preferred mode
- * @vpref: vertical resolution of preferred mode
- *
- * Marks a mode as preferred if it matches the resolution specified by @hpref
- * and @vpref.
- */
-void drm_set_preferred_mode(struct drm_connector *connector,
-			   int hpref, int vpref)
-{
-	struct drm_display_mode *mode;
-
-	list_for_each_entry(mode, &connector->probed_modes, head) {
-		if (mode->hdisplay == hpref &&
-		    mode->vdisplay == vpref)
-			mode->type |= DRM_MODE_TYPE_PREFERRED;
-	}
-}
-EXPORT_SYMBOL(drm_set_preferred_mode);
-
 static bool is_hdmi2_sink(const struct drm_connector *connector)
 {
 	/*
diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index ac9a406250c5..01aa44e87534 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -2754,3 +2754,25 @@ bool drm_mode_is_420(const struct drm_display_info *display,
 		drm_mode_is_420_also(display, mode);
 }
 EXPORT_SYMBOL(drm_mode_is_420);
+
+/**
+ * drm_set_preferred_mode - Sets the preferred mode of a connector
+ * @connector: connector whose mode list should be processed
+ * @hpref: horizontal resolution of preferred mode
+ * @vpref: vertical resolution of preferred mode
+ *
+ * Marks a mode as preferred if it matches the resolution specified by @hpref
+ * and @vpref.
+ */
+void drm_set_preferred_mode(struct drm_connector *connector,
+			   int hpref, int vpref)
+{
+	struct drm_display_mode *mode;
+
+	list_for_each_entry(mode, &connector->probed_modes, head) {
+		if (mode->hdisplay == hpref &&
+		    mode->vdisplay == vpref)
+			mode->type |= DRM_MODE_TYPE_PREFERRED;
+	}
+}
+EXPORT_SYMBOL(drm_set_preferred_mode);
diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
index 54cc6f04a708..5bd6b6eb6c57 100644
--- a/include/drm/drm_edid.h
+++ b/include/drm/drm_edid.h
@@ -426,8 +426,6 @@ enum hdmi_quantization_range
 drm_default_rgb_quant_range(const struct drm_display_mode *mode);
 int drm_add_modes_noedid(struct drm_connector *connector,
 			 int hdisplay, int vdisplay);
-void drm_set_preferred_mode(struct drm_connector *connector,
-			    int hpref, int vpref);
 
 int drm_edid_header_is_valid(const void *edid);
 bool drm_edid_block_valid(u8 *raw_edid, int block, bool print_bad_edid,
diff --git a/include/drm/drm_modes.h b/include/drm/drm_modes.h
index c613f0abe9dc..b9bb92e4b029 100644
--- a/include/drm/drm_modes.h
+++ b/include/drm/drm_modes.h
@@ -467,6 +467,8 @@ bool drm_mode_is_420_also(const struct drm_display_info *display,
 			  const struct drm_display_mode *mode);
 bool drm_mode_is_420(const struct drm_display_info *display,
 		     const struct drm_display_mode *mode);
+void drm_set_preferred_mode(struct drm_connector *connector,
+			    int hpref, int vpref);
 
 struct drm_display_mode *drm_analog_tv_mode(struct drm_device *dev,
 					    enum drm_connector_tv_mode mode,
-- 
2.43.0


