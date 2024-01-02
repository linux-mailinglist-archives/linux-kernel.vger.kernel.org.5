Return-Path: <linux-kernel+bounces-14281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EEA821ACC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B195B20F8E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A652EEAD9;
	Tue,  2 Jan 2024 11:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a3Piu51Q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C10EACE
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 11:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704194369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qoJsvoq0DDDLxrsVvT9v5nXIRGXNDW8rEpKhzHpyXgI=;
	b=a3Piu51QeO0BIPdKXCazNR5Y5juuS/D5lV3Ifbhl71pm+HDks3ZMjBDRHhOCOVG9K1WfGL
	DeLhOs0iuXJhiyW1zaBJCAs3LrNYIbuw4qmFiyreLk/fsC/TdnuY2qbuwl7BL99rm45Snh
	oQosQhMi/V40O8zSsgH7Ja9L3cQCI+I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-5iwnMwtxMdewayKPopFyzA-1; Tue, 02 Jan 2024 06:19:28 -0500
X-MC-Unique: 5iwnMwtxMdewayKPopFyzA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40d86184891so14245585e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 03:19:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704194366; x=1704799166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qoJsvoq0DDDLxrsVvT9v5nXIRGXNDW8rEpKhzHpyXgI=;
        b=BcamKWDoFgujwS4hbgoBDf7qNWe2aEaHwrqNY49pSP6JjARTd7aTQW5fM8xCcCvK0t
         JpFp3WopjdIRyfycgGcrPcFaxlYOiNiQRfAfkLTq1Nhwx31vXfpdAYlF3TCbT8NK2zIj
         pkch89tm6x3/IdH4HbE3yLLfltkwCba3XuQTrhMZCaixGBGFEgJokmK3vCOy/EKrI3n1
         Tiy/S/Q+lZ7lQB9+ffWlxnFsbh1+0QdRD52kEzSY6rfw7Kf9T43zYGQ4/ffD6NOUPs3g
         lgBjel68wDRMbs1uzVs8I5SdwKmLV8tB+rGgYoPChzGuPjV2HmSKb85n3clwftJ8PWg/
         pufA==
X-Gm-Message-State: AOJu0YypGxoWg5jdxZxqN+R5Uo+SyjhqBUxgvzD8/nYsR9JsrNdRZNzw
	HxPBxBwLe2BvvknZ3nRNRYab/weOO0gArGr8xs4Kr7JwzxC8UGsK6AOt4WCFBqpajIZJVCXSv4f
	ZAOiRCMRRY5cAxkATI/5pmkQOnHOJmjqRn3QykYE8u1ruMYC8QUUSmRg2UjhRjL5/Dr3XjUyqak
	/INc+fh/mQIsjCDDYN2Q==
X-Received: by 2002:a05:600c:21c3:b0:40c:32bf:20f with SMTP id x3-20020a05600c21c300b0040c32bf020fmr8670404wmj.147.1704194366169;
        Tue, 02 Jan 2024 03:19:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdjCeS38gsGIEYkKTsmvgLDiYT1Gj00fEhKA72AEg+8H/QbXlRJtmItinsd+orroi24KHMnw==
X-Received: by 2002:a05:600c:21c3:b0:40c:32bf:20f with SMTP id x3-20020a05600c21c300b0040c32bf020fmr8670393wmj.147.1704194365857;
        Tue, 02 Jan 2024 03:19:25 -0800 (PST)
Received: from localhost (red-hat-inc.vlan560.asr1.mad1.gblx.net. [159.63.51.90])
        by smtp.gmail.com with ESMTPSA id w10-20020a05600c474a00b0040d725a9967sm16395607wmo.11.2024.01.02.03.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 03:19:25 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javierm@redhat.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] drm: Move drm_set_preferred_mode() helper from drm_edid to drm_modes
Date: Tue,  2 Jan 2024 12:18:59 +0100
Message-ID: <20240102111921.3057255-1-javierm@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The helper is generic and doesn't use the opaque EDID type struct drm_edid
and is also used by drivers that only support non-probeable displays, such
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
---

 drivers/gpu/drm/drm_edid.c  | 23 +----------------------
 drivers/gpu/drm/drm_modes.c | 22 ++++++++++++++++++++++
 include/drm/drm_edid.h      |  2 --
 include/drm/drm_modes.h     |  2 ++
 4 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index cb4031d5dcbb..48dd2a0a0395 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -43,6 +43,7 @@
 #include <drm/drm_edid.h>
 #include <drm/drm_eld.h>
 #include <drm/drm_encoder.h>
+#include <drm/drm_modes.h>
 #include <drm/drm_print.h>
 
 #include "drm_crtc_internal.h"
@@ -6989,28 +6990,6 @@ int drm_add_modes_noedid(struct drm_connector *connector,
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


