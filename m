Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC817942F8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 20:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243780AbjIFSTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 14:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243782AbjIFSTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 14:19:37 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75721732
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 11:19:32 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99cce6f7de2so2675566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 11:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694024371; x=1694629171; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=brVuhGNSmL2KjjAtb0WsBUqLQf3d/P9cAPHdmHgOTbE=;
        b=l2WfBC1qd31I3NZmkG6VDJDWE/nRglLR69+sAFBvkpEipynVV3JUwpxbhujD7Bmto/
         xTGgx3Zv0E7hYt8kvRrKaVb/EHuPpmiIdX1r8nDkTrPnyDoCc8+VMPaCemPIkFAhhnyS
         6yixUlvbYVvunzSWWaaDnC6Fk/FsrdNgIR6waM6Lo+ZbRwpdX8A0Uo/IhlwljVgc0a/H
         DEcv4yEyVuJ0GMPfKJJFb+OiEvdX9huVTO2541LXsf/jFMy5TCfpYIMAHHM7wwIWIi9V
         meMcCiqQ/NYz/TsoEUpQU24BmVO2dFrk4SGiz4qlTaJeow9vRL/LA34cqa/q/dw3BwEl
         f4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694024371; x=1694629171;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=brVuhGNSmL2KjjAtb0WsBUqLQf3d/P9cAPHdmHgOTbE=;
        b=UnOQMcEJJ2TevLS7GOhfFOMWu8KGfKq2AQzuaGzA8xs/idyjXA9dKfmf4iJEYZ+dF5
         DskIugUQsbz+V7FviofS1krUVjTE/V8rAq/jf35k4CjtGTPsDWqxnPu4jgpfTxD6regL
         2uHOru5x4F1+GBzp6/6mHC9Y5pP7m8GDNoq++gxX5OzLEnxNLhJ/tpWhY2+i7VoXGnIe
         3RdAxkHv4FiO3/4mMjEpeyBzXc/6VHNznQJ3z1Z/A/wRis5Wm9t95l/drtQgemwBsbEF
         oXOcz2BQnMO1TzCnL1iO2TK5oZUCdJaNNms6oZ1a/s9+Y53umsGnGPgso3aivoCSXyD8
         M4qg==
X-Gm-Message-State: AOJu0YxaLKUXB379YvARMepnkvh885dDYHH0LHAqsJyaJAZLBWFkHGh6
        ftZcoqQuSjYEm2MgBMSYVNE=
X-Google-Smtp-Source: AGHT+IHAnI889hIsnFWWcWV/k5vE0fMUU6pVi/t1v65SUwHvOj7p3j1rAwq/pOhnoXkQ72cJ0bMboA==
X-Received: by 2002:a17:906:3d2a:b0:9a1:fc90:bdf2 with SMTP id l10-20020a1709063d2a00b009a1fc90bdf2mr3073093ejf.21.1694024371285;
        Wed, 06 Sep 2023 11:19:31 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41b4-ce80-82c3-f600-375e-54bc.cable.dynamic.v6.surfer.at. [2a02:8389:41b4:ce80:82c3:f600:375e:54bc])
        by smtp.gmail.com with ESMTPSA id x24-20020a170906299800b0099cadcf13cesm9350186eje.66.2023.09.06.11.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 11:19:30 -0700 (PDT)
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date:   Wed, 06 Sep 2023 20:19:29 +0200
Subject: [PATCH] drm/connector: document supported_colorspaces and
 DRM_MODE_COLORIMETRY_COUNT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230906-topic-drm_connector_doc-v1-1-f4ce7ad0150c@gmail.com>
X-B4-Tracking: v=1; b=H4sIALDC+GQC/x2N0QrCMAwAf2Xk2UJtx0B/RWSkaXR5WDuSIsLYv
 9v5eBzH7WCswgb3YQflj5jU0uF6GYAWLG92kjtD8CH6m59cq5uQy7rOVEthalXnXMmNISPHhGO
 kCXqd0NglxULL2a9ojfUUm/JLvv/l43kcP96JCt+CAAAA
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694024369; l=3375;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=XV2PA7cr0H7sW98GKzNL+aV/eA4RnJXKRgazWsFy6y4=;
 b=kR2YgUglN1L8b1w6Fo+0crgbap4wAZhb0h4VIkqL28FUiwXAMT8DjbcdCV74jDQ9/pErwCWNP
 BwFMTJ3p9bIBMxs/GAluoYOgbhINE7F2rjKIg3dFecNfJjW/JF8tl+Q
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The supported_colorspaces parameter was added to the following
functions without documenting it:

drm_mode_create_dp_colorspace_property
drm_mode_create_hdmi_colorspace_property

The missing descriptions generate warnings when compiling the
documentation. Add the descriptions to document the
supported_colorspaces parameter.

The drm_colorspace enum member DRM_MODE_COLORIMETRY_COUNT has been
properly documented by moving the description out of the enum to the
member description list to get rid of an additional warning and improve
documentation clarity.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
The supported_colorspaces parameter was added to the following
functions without documenting it:

drm_mode_create_dp_colorspace_property
drm_mode_create_hdmi_colorspace_property

The missing descriptions generate warnings when compiling the
documentation. Add the descriptions to document the
supported_colorspaces parameter.

The drm_colorspace enum member DRM_MODE_COLORIMETRY_COUNT has been
properly documented by moving the description out of the enum to the
member description list to get rid of an additional warning and improve
documentation clarity.
---
 drivers/gpu/drm/drm_connector.c | 2 ++
 include/drm/drm_connector.h     | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index bf8371dc2a61..77bfe17dcf98 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -2203,6 +2203,7 @@ static int drm_mode_create_colorspace_property(struct drm_connector *connector,
 /**
  * drm_mode_create_hdmi_colorspace_property - create hdmi colorspace property
  * @connector: connector to create the Colorspace property on.
+ * @supported_colorspaces: colorspaces supported by the driver.
  *
  * Called by a driver the first time it's needed, must be attached to desired
  * HDMI connectors.
@@ -2227,6 +2228,7 @@ EXPORT_SYMBOL(drm_mode_create_hdmi_colorspace_property);
 /**
  * drm_mode_create_dp_colorspace_property - create dp colorspace property
  * @connector: connector to create the Colorspace property on.
+ * @supported_colorspaces: colorspaces supported by the driver.
  *
  * Called by a driver the first time it's needed, must be attached to desired
  * DP connectors.
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index d300fde6c1a4..18cf46e3478b 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -498,6 +498,8 @@ enum drm_privacy_screen_status {
  *   ITU-R BT.601 colorimetry format
  *   The DP spec does not say whether this is the 525 or the 625
  *   line version.
+ * @DRM_MODE_COLORIMETRY_COUNT:
+ *   Not a valid value; merely used four counting
  */
 enum drm_colorspace {
 	/* For Default case, driver will set the colorspace */
@@ -522,7 +524,6 @@ enum drm_colorspace {
 	DRM_MODE_COLORIMETRY_RGB_WIDE_FIXED	= 13,
 	DRM_MODE_COLORIMETRY_RGB_WIDE_FLOAT	= 14,
 	DRM_MODE_COLORIMETRY_BT601_YCC		= 15,
-	/* not a valid value; merely used for counting */
 	DRM_MODE_COLORIMETRY_COUNT
 };
 

---
base-commit: 65d6e954e37872fd9afb5ef3fc0481bb3c2f20f4
change-id: 20230906-topic-drm_connector_doc-42dae3ba43c6

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>

