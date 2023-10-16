Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0270D7CB6A2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 00:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjJPWi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 18:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbjJPWiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 18:38:25 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79AFE1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 15:38:23 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7ba10cb90so74074547b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 15:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697495903; x=1698100703; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rfGwHPiYseuIB04WY1jIM0LXVs+wtH1jXMPtU9N43zs=;
        b=J6b3TzD4+gcfJcD2ESwDrx1CSo3G3phEwPdaz22RHEmPLa251ViTgB+XNQnlzCVKSI
         D0+eUSBFrryylKoc1xtnKobuVxOkQUQMANjgreWwLUybOtmt1kP3xwpjifkCvinUPjVc
         +XYNcbyTaKxyR28t5NjvkOza/Gq+ne1LsVlklCcQFKEh2suRHRbpZB/wEQa5aEZCj3fh
         FzorxcmotQSk/2Y1OUuB7QvyqUefqJx7Lq/IbQR+VYwXckczESmQEqMZgjo13NHpKNT1
         QwApOwVTcgmyhnlUGGdkPhqgHoBTpWeopU/Ftv9X555iiKlF47GKH7mr2ZLZBHjwI+ie
         mo6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697495903; x=1698100703;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rfGwHPiYseuIB04WY1jIM0LXVs+wtH1jXMPtU9N43zs=;
        b=XalB7BUEwqJbZyFJF+q9b5EHaPhoZk9mhNQzOYK8z1GWI6Kum0TOV2PDFlG8TOYj7T
         7KBx1/qKiBMP2ReKAku9HNHQxf/Bu4ANtZDNtaScJZ3UqHn0767ysHyglwtYPLzEauZu
         d9x04UHeDf+9H7/VXmEhHgVzYWeAYeEddj2srRmXWQEQdhwH6YDJr9OueM1se6dFUMnE
         61OLXEp8rJOSPtn4kf0jW6pReP7k4CwYKbSb4bWK/uku12CoM8+VUwzgWoySJqGGakQg
         RESYwyVLz/zAanLBoM8aGgjIA3lBye1e/FpN1b/IOhpX7BigOFknHJEhJNczfxzBs9Vr
         /yiw==
X-Gm-Message-State: AOJu0Yyi6uhZHOqz8GgDQvz4xDoWoSlzfElqhT4IgGqN2DHRj6phJygj
        O5voJpOrF8nlcaMKoIdrXoKlApC3Kael7jBLDA==
X-Google-Smtp-Source: AGHT+IE7UKckRpGvTsEyas9ajW3OpcUNBDlz8M6iI1mSjq5sbYon/JJP4IFvS+a3lHmzLj+l3IZgZgtqQhvVSDAs7g==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:a214:0:b0:5a7:af9a:7530 with SMTP
 id w20-20020a81a214000000b005a7af9a7530mr13026ywg.1.1697495902914; Mon, 16
 Oct 2023 15:38:22 -0700 (PDT)
Date:   Mon, 16 Oct 2023 22:38:20 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFu7LWUC/5WNTQqDMBSEryJZ95X8NFi78h5FSpq8xgfVSGJDR
 bx7ozfoYmC+WXyzsoSRMLFbtbKImRKFsYA8Vcz2ZvQI5AozyaXijbhAmuNopwVcpIwxgZ8+pQ9
 7HkNwmMCCUdrVV2mN44IV0xTxRd/j5d4V7inNIS7HaRb7+p8/CxDA6+apldRaGdX6EPwbzzYMr Nu27QepuXgo1wAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697495902; l=2621;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=TJW5gbFFOQpXDfDl5XUoO1+aPZvb/beyqblsIzLDODQ=; b=Jr8r8/EvJkzNSU8MDRFRbOGBeDpanyMebo+SVS5CU/dprVV/kh/VtN1BGAtRJ27wIjeHTlzp1
 6/VI8g3xYjjDTFjHLJgbeHe+TZzGUb9EXm/g4j4Wiey/482jTTXVbq/
X-Mailer: b4 0.12.3
Message-ID: <20231016-strncpy-drivers-gpu-drm-drm_modes-c-v2-1-d0b60686e1c6@google.com>
Subject: [PATCH v2] drm/modes: replace deprecated strncpy with strscpy_pad
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
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We should NUL-pad as there are full struct copies happening in places:
|       struct drm_mode_modeinfo umode;
|
|       ...
|               struct drm_property_blob *blob;
|
|               drm_mode_convert_to_umode(&umode, mode);
|               blob = drm_property_create_blob(crtc->dev,
|                                               sizeof(umode), &umode);

A suitable replacement is `strscpy_pad` due to the fact that it
guarantees both NUL-termination and NUL-padding on the destination
buffer.

Additionally, replace size macro `DRM_DISPLAY_MODE_LEN` with sizeof() to
more directly tie the maximum buffer size to the destination buffer:
|       struct drm_display_mode {
|               ...
|       	char name[DRM_DISPLAY_MODE_LEN];

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Cc: Xu Panda <xu.panda@zte.com.cn>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- use strscpy_pad (thanks Kees)
- rebase onto mainline
- Link to v1: https://lore.kernel.org/r/20230914-strncpy-drivers-gpu-drm-drm_modes-c-v1-1-079b532553a3@google.com
---
Note: build-tested only.
---
 drivers/gpu/drm/drm_modes.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index ac9a406250c5..893f52ee4926 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -2617,8 +2617,7 @@ void drm_mode_convert_to_umode(struct drm_mode_modeinfo *out,
 		break;
 	}
 
-	strncpy(out->name, in->name, DRM_DISPLAY_MODE_LEN);
-	out->name[DRM_DISPLAY_MODE_LEN-1] = 0;
+	strscpy_pad(out->name, in->name, sizeof(out->name));
 }
 
 /**
@@ -2659,8 +2658,7 @@ int drm_mode_convert_umode(struct drm_device *dev,
 	 * useful for the kernel->userspace direction anyway.
 	 */
 	out->type = in->type & DRM_MODE_TYPE_ALL;
-	strncpy(out->name, in->name, DRM_DISPLAY_MODE_LEN);
-	out->name[DRM_DISPLAY_MODE_LEN-1] = 0;
+	strscpy_pad(out->name, in->name, sizeof(out->name));
 
 	/* Clearing picture aspect ratio bits from out flags,
 	 * as the aspect-ratio information is not stored in

---
base-commit: 58720809f52779dc0f08e53e54b014209d13eebb
change-id: 20230914-strncpy-drivers-gpu-drm-drm_modes-c-a35d782cad01

Best regards,
--
Justin Stitt <justinstitt@google.com>

