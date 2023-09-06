Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3BD7944B7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 22:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243540AbjIFUrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 16:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239264AbjIFUru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 16:47:50 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BC1E70
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 13:47:46 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31c73c21113so263646f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 13:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694033264; x=1694638064; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D4jlIvIDeaXZH3yZfiNk5m0ga1T9VUdf6C+njdswpE4=;
        b=bhgfXVmm/A1xrengzcnbLRB5iQfdkxlmlVUjmYNgOLmsmLTvhS+6+J2rN3bov46KxY
         H180kCnOseavNSph/IuZIUJqF2br3Xj82YADQJNgk9kPCxJ+bZtqbdm1qUXoBkbnqFrL
         i/nAJ/2HkzFmjh+Uaoka8Niwge+2s7PF8SuDotUiJk1VYVozje32lSM/9dVQ4faY3spD
         SxPbGU4QpAt7Q7O7ZD3gYu8xy2Ix7yp9Ik07/Il5txMn64pfguvPgQtxgoFxESswGr4L
         IuCn0N8LEmvCYOEDa3vp2XhYS1iPUwWVgZZPV8pxHB32S2u7FbXEXr/rgEoZ55IaULGu
         T3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694033264; x=1694638064;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D4jlIvIDeaXZH3yZfiNk5m0ga1T9VUdf6C+njdswpE4=;
        b=SdppxbQ30D8IDlLHiybFWb0iQbAZUmndZSHjHIl0hnDOLnbsnumTr37kaUVy+1igHL
         OksuHrqpQZ8A5XB6L0oxQZw1HyDD/YtwxIn6xBDsmy17TLEhS334rd+sAy02uVbpdU6I
         DXn9c80MAehlrx86gOL338BKThH0i1kvQe89ZxsnDfh4sQNHYijIIruA91OfGOi6NiWs
         172Tdd+TWd1l4XrYoY7VFcI00QqUvAOh3QELr7WvcVsnSYSNUL+CWfzx8c7Wlt78lPGM
         fFxjdbIDADiS6whzgYlrRwyuI8Gd3b3piluesrR0ZDlytdn2nJ7ZahA7C4WbAM6on40B
         UsMg==
X-Gm-Message-State: AOJu0YwB+QaqOYZOabFl6D2wwvpQ/pZxF1C9CFWb0Hem/Q70REX4rXLp
        495oL2r+T4B6muXDJrfdnpEKZ9+mTqBtdw==
X-Google-Smtp-Source: AGHT+IF7eUkudv66fqfLlLjtyNNiG6JQMgxBmO32E3vDLPepUMSE/q8koGt9Nl6iS3YTPaoj8kEAXw==
X-Received: by 2002:a5d:63c6:0:b0:317:cff4:7357 with SMTP id c6-20020a5d63c6000000b00317cff47357mr2946013wrw.20.1694033264117;
        Wed, 06 Sep 2023 13:47:44 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41b4-ce80-82c3-f600-375e-54bc.cable.dynamic.v6.surfer.at. [2a02:8389:41b4:ce80:82c3:f600:375e:54bc])
        by smtp.gmail.com with ESMTPSA id qx12-20020a170906fccc00b0099bd86f9248sm9436357ejb.63.2023.09.06.13.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 13:47:43 -0700 (PDT)
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date:   Wed, 06 Sep 2023 22:47:38 +0200
Subject: [PATCH v2] drm/connector: document DRM_MODE_COLORIMETRY_COUNT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230906-topic-drm_connector_doc-v2-1-1f2dcaa43269@gmail.com>
X-B4-Tracking: v=1; b=H4sIAGnl+GQC/4WOTQqDMBCFryJZNyWJ1tKuvEcRGSejDjSJJCIt4
 t0bvUCX33u8n00kikxJPItNRFo5cfAZzKUQOIEfSbLNLIwypXqoWi5hZpQ2ug6D94RLiJ0NKCt
 jgcoeqhJrkdM9JJJ9BI/TkXeQFoqHMUca+HNOvtrME6fc8T0frPpQ/4+tWmo5VEh3sErfFDajA
 35fMTjR7vv+A22rvM/XAAAA
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694033262; l=1646;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=o5qS1h6uUEp6//p2GmoMRuubQDfqtXUZ8Ml+N/bqDuM=;
 b=k9PO34nKBp4BwltnWawdEi4BfIAah1NuWMA5YaSxvnjgCPuh+ogfqzZtlxeuCEANF2t+ZZg8y
 377FvdZ3L9EDnBDweM0Kw97xs/YwtiNL1u+QBbmMpNAQpyePicJ29j2
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The drm_colorspace enum member DRM_MODE_COLORIMETRY_COUNT has been
properly documented by moving the description out of the enum to the
member description list to get rid of an additional warning and improve
documentation clarity.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
---
Changes in v2:
- Remove applied changes in linux-next (supported_colorspaces
  documentation)
- Link to v1: https://lore.kernel.org/r/20230906-topic-drm_connector_doc-v1-1-f4ce7ad0150c@gmail.com
---
 include/drm/drm_connector.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

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

