Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1927A0C3E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237548AbjINSIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237421AbjINSIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:08:51 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E551FF9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 11:08:46 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5925fb6087bso16629467b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 11:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694714926; x=1695319726; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=643G47GETNhqNdCuDURH7WS6HlitohpBl/WopZi3siE=;
        b=Bxn5R+b1g8a0Kv4v/3SKs/7FFXxscduq0iIX7Dzlo0z4z7rBdjOjT4gbYnbmml8vTN
         w/V2CSL7dfvSYIk147DnulaRMg+rT9rL+isOFLTOSRhLYzKj/99zEpfGcjynpsoluoxD
         YiqDFQd6dICw1tIkm4rOLf5N2eLZ2LGQqOlKn/R+HuHuFkcywX43vATzf3TmCyynz5F6
         17B4PCjMy3s737/YDdvP4J+3kHPOdn8+LMupU1RP7aIzYG8MfD+NG+dBVvKUQpoQbczM
         yasecrIqIBpIWGgV+MsCWVSbgYglFveSoRRFJexgbaRGqXty790O5Adflv2qJpL5Su9H
         j74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694714926; x=1695319726;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=643G47GETNhqNdCuDURH7WS6HlitohpBl/WopZi3siE=;
        b=QTXRNaxzqHyInw/tvZmoPeCHsIJFg1btoS/LQjuHOB1kD9IrSUWmNJdHT2az4UNbxq
         FH5Oo5Tck+4Ch7rY7mJ5PDE2t9uJimOf57eTl0z+wA85Ura8ADIpRIxzF3JQMZJQGjIJ
         TbDRf38GmExKYXStJw4woswouJrqiekO36pDEmejRKS/QZvOmtxoQa2GUCNO4UWomjKo
         xntLKtLe8w5pTJA6kZIgdUd5bS8eHl9WqXBjBkm43nkwraZy0bDbP31q1z3C0mTU05yY
         455gjdzTZPRGLTTOhFPZEk6XPeM7597cFhC8V3Ce033o3L5ZPi0hHV8PsDYBDY/Q0W2Q
         N7pA==
X-Gm-Message-State: AOJu0YzyRMH4IIuBbqLijQTFqAG5ow3HP7rMlA8XngT43F6CLbPqNhif
        LR9fUX/xDZzMq8O2wqPX0OhO6rC7zxRue/DoNg==
X-Google-Smtp-Source: AGHT+IHNWB0qP5meAQB51iaCUK7XP1sqn9eMFG8FkOmWjyLp7Z/2qgzDTOAe33XQ2hHF6E3jXIVHS2ObMzFQCFbozQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:78d6:0:b0:59b:d33b:5ddc with SMTP
 id t205-20020a8178d6000000b0059bd33b5ddcmr133238ywc.4.1694714926173; Thu, 14
 Sep 2023 11:08:46 -0700 (PDT)
Date:   Thu, 14 Sep 2023 18:08:44 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIACtMA2UC/x2NSwrDMAwFrxK0rsB2Wvq5SinFWGqqRRwjpaYh5
 O5xuxh4s3mzgrEKG9y6FZSrmEy5iT90kN4xD4xCzSG40LurP6LNmlNZkFQqq+FQPm2PP57jRGy YMPYnOl9CiuQ8tKei/JLvv3J/bNsOrmjEmXUAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694714925; l=2160;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=/VCD7DX1eCwVY46g4u81ZzjWo56f8DBPp1HX5L6qls8=; b=MSSj1xqOuKPodBgV3hCbCUvST05NmhGqT2NoNhh2CgiIOwHCP9o4MvQZLtDioILfwHV7oAWOC
 NasnjoSdir4BVmDVA/kDQPWT/uy8cxs5U1km0orFGKX5eaHoO0od7O3
X-Mailer: b4 0.12.3
Message-ID: <20230914-strncpy-drivers-gpu-drm-drm_modes-c-v1-1-079b532553a3@google.com>
Subject: [PATCH] drm/modes: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Xu Panda <xu.panda@zte.com.cn>,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

We should prefer more robust and less ambiguous string interfaces.

A suitable replacement is `strscpy` [2] due to the fact that it guarantees
NUL-termination on the destination buffer and doesn't incur the
performance loss of unnecessarily NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Cc: Xu Panda <xu.panda@zte.com.cn>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
This patch is basically a resend of [1] by Xu but rebased onto mainline.

This patch is also similar to:
commit 0f9aa074c92dd ("drm/modes: Use strscpy() to copy command-line mode name")

[1]: https://lore.kernel.org/all/202212051935289159302@zte.com.cn/
---
 drivers/gpu/drm/drm_modes.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index ac9a406250c5..c702a8b866cf 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -2617,8 +2617,7 @@ void drm_mode_convert_to_umode(struct drm_mode_modeinfo *out,
 		break;
 	}
 
-	strncpy(out->name, in->name, DRM_DISPLAY_MODE_LEN);
-	out->name[DRM_DISPLAY_MODE_LEN-1] = 0;
+	strscpy(out->name, in->name, DRM_DISPLAY_MODE_LEN);
 }
 
 /**
@@ -2659,8 +2658,7 @@ int drm_mode_convert_umode(struct drm_device *dev,
 	 * useful for the kernel->userspace direction anyway.
 	 */
 	out->type = in->type & DRM_MODE_TYPE_ALL;
-	strncpy(out->name, in->name, DRM_DISPLAY_MODE_LEN);
-	out->name[DRM_DISPLAY_MODE_LEN-1] = 0;
+	strscpy(out->name, in->name, DRM_DISPLAY_MODE_LEN);
 
 	/* Clearing picture aspect ratio bits from out flags,
 	 * as the aspect-ratio information is not stored in

---
base-commit: 3669558bdf354cd352be955ef2764cde6a9bf5ec
change-id: 20230914-strncpy-drivers-gpu-drm-drm_modes-c-a35d782cad01

Best regards,
--
Justin Stitt <justinstitt@google.com>

