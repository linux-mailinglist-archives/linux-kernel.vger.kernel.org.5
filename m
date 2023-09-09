Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42B779978B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 13:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344809AbjIILE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 07:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237575AbjIILEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 07:04:54 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5F1CED
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 04:04:50 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c0ecb9a075so21878515ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 04:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694257490; x=1694862290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hhJX5VWHXXtciuS9BkKk5zfmvkcSaBWZ/aSQRFscuJA=;
        b=s11GDNinn8phXfcPhsh/p6j0iF7jan8biJtSs07PbHWtz6qZvNw+bjDAVsthGGedAC
         yiVm+9KyxTHwWbYFgGfGJzVX0GPMOALOeaFEFeKZ4O14viP7PmbsS1HzHBY+3kRC9SHp
         YV0gWFkHveVDmEnb+48nPL8VZDbujEXMI63Dthy2eWFL38uVwbCqWrFSVjP23kGCz9j3
         rx+rbtKn/gbxPG4DXnZJIKejr3B7+J5+3pDvExRm8fI4pQQCepmnk/xhxnetFydMwFvW
         jWhxpKLspMXiCi7uMqHQbNivOHX3pQfxzg5D09nx8u/V9ErktAlhQ0rJFsSxe4DDjuOb
         8Tcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694257490; x=1694862290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hhJX5VWHXXtciuS9BkKk5zfmvkcSaBWZ/aSQRFscuJA=;
        b=p4ZS+9ixKdLs2Xdi5S/y+9vG+tYENrlmmq6ZFjRKZOsnSkEcKl8U3uGmhhdtQOplNI
         vKWNc97/QPXbY/3e2PRinGD4vYsm+pj9UVtNX4pq14GU+qwJGpQBKC7VlU1mlravOrwn
         RazL4rAUMlm8zOA5IKsyELkbJH1MmNxdmHWDIpDM8Yb7gERrCJ6Ct+94sFagHwEWZsha
         NJqL5kkBHN6toPx7JMsbTrIFLOOy3bfT059woQvfWmWAEfEb3GlCzYplSV6F5E1cJ0Nu
         RqjwRnxasLFFOn7XL36aRFkTi2YZ2+0LIN38NCaV9It/gkrXjlLokG+G3Sv+kCvqXKeF
         RG9w==
X-Gm-Message-State: AOJu0YziKabWa8W1bN2DOnCZ/Cq3BOTtVAUsI/0XkVUdfDCUneqOvkEY
        3MTnsHZi0Gj+CUAJh5Rk1CA=
X-Google-Smtp-Source: AGHT+IGMiGpjKR5+4BJIqy4f/HlylX0MSMIi2+xFdaiFsk2sdaUrzTeLkVocsGY1gIjqCETBTBv8TQ==
X-Received: by 2002:a17:902:7489:b0:1bb:25bd:d09c with SMTP id h9-20020a170902748900b001bb25bdd09cmr4498991pll.1.1694257489858;
        Sat, 09 Sep 2023 04:04:49 -0700 (PDT)
Received: from brag-vm.localdomain ([27.4.106.123])
        by smtp.gmail.com with ESMTPSA id j9-20020a170902da8900b001bbbbda70ccsm3017206plx.158.2023.09.09.04.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Sep 2023 04:04:49 -0700 (PDT)
From:   Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch
Cc:     Bragatheswaran Manickavel <bragathemanick0908@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: fix doc warnings related to drm connector
Date:   Sat,  9 Sep 2023 16:33:43 +0530
Message-Id: <20230909110343.8103-1-bragathemanick0908@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Addressing drm dp/hdmi connector related kernel documentation
warning and add more information about these values.

Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
---
 drivers/gpu/drm/drm_connector.c | 2 ++
 include/drm/drm_connector.h     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index bf8371dc2a61..084c95785dda 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -2203,6 +2203,7 @@ static int drm_mode_create_colorspace_property(struct drm_connector *connector,
 /**
  * drm_mode_create_hdmi_colorspace_property - create hdmi colorspace property
  * @connector: connector to create the Colorspace property on.
+ * @supported_colorspaces: to get hdmi supported colorspaces.
  *
  * Called by a driver the first time it's needed, must be attached to desired
  * HDMI connectors.
@@ -2227,6 +2228,7 @@ EXPORT_SYMBOL(drm_mode_create_hdmi_colorspace_property);
 /**
  * drm_mode_create_dp_colorspace_property - create dp colorspace property
  * @connector: connector to create the Colorspace property on.
+ * @supported_colorspaces: to get dp supported colorspaces.
  *
  * Called by a driver the first time it's needed, must be attached to desired
  * DP connectors.
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index d300fde6c1a4..556d66dd122c 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -498,6 +498,8 @@ enum drm_privacy_screen_status {
  *   ITU-R BT.601 colorimetry format
  *   The DP spec does not say whether this is the 525 or the 625
  *   line version.
+ * @DRM_MODE_COLORIMETRY_COUNT:
+ *   Represents the count of colorspaces.
  */
 enum drm_colorspace {
 	/* For Default case, driver will set the colorspace */
-- 
2.34.1

