Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17D5785367
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235139AbjHWJCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234960AbjHWI5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:57:07 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB04D10D1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:53:32 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50098cc8967so321302e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692780811; x=1693385611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6rtQaBEI7tcum+ap0HtQIWPfUh5EA2GW0hFh/JypvjU=;
        b=ousd/9SnCNrM7UrVLsSp0ud5aQ//23wl/uzIK+EDEqgxreLiEngAgHDxq0emhhQrk0
         l9+Hd+pKJayIcIJR8zpA1DEk2H+6eltlic8h+1OF56BKlB3x+UfMTQMR2VMFtIzKo9F7
         N7A8jdVQg+nSxYwl75ZANi4s+PFwWJuLfuCLHkHjiU5iPFuIUWqYsSXSgBvhE40TWM4E
         oyo6qu7FEw99Qq/i8nxXkqMCMjAwT+T6YG9WW8oz9zgA4+m6Ko24Unez/2Xbok1GlXIg
         lrky1QbVLf8Wa+/Dk/1OhQ8Gh5t/GGoHXgwy+cBjR/djwYvCUob4cmC23OdbhierDAT6
         P/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692780811; x=1693385611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6rtQaBEI7tcum+ap0HtQIWPfUh5EA2GW0hFh/JypvjU=;
        b=INgTPpGMPKofkjkR+B+MyjBiOQGzSMzi+cSCes4ntDqKXaHkhFrONDzlHvZuBX0YIV
         DW1C3gg2tcN+Gz8WZbu948k2rHD1Wl967DHpnJw93bsJxspbwKnuNuZGQwBdIvapUGl/
         Iau0YwmwTylSnEt8JDKSO+PyxQBLnF2SEEIeXZZLADKtnSrhyDt3ybSUBFaNuD5WrgnP
         ctroG/TEvBfFqCBNcoDa5bucNl1+d9sMyZB4yk1fDNFU/PT6IvfeI37DCkRVwmmyXOCx
         Ocot6Rm3YxckrOQMFUJDw6VFzAUmhRTfK2PuniWYvoYldw3TTT5pgyo/CaXRZwFAHEpM
         K5SA==
X-Gm-Message-State: AOJu0Yx6sWS1CItUYMh8WzNmceT6197upeOTsa0hpPQPOABxrlpchKZF
        Pj6ofHJgI3xOmr0hHSwHxOikYQ==
X-Google-Smtp-Source: AGHT+IHE3Y3ECLsbSn1t48rbWWmPSFBaDbfM70ZDZzl2s39mgCNO5GszDrC+GL+RkbUyVOXmaIhYzg==
X-Received: by 2002:a05:6512:689:b0:4fd:d64f:c0a6 with SMTP id t9-20020a056512068900b004fdd64fc0a6mr10560928lfe.48.1692780810728;
        Wed, 23 Aug 2023 01:53:30 -0700 (PDT)
Received: from krzk-bin.. ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id k9-20020a056402048900b0052540e85390sm8940966edv.43.2023.08.23.01.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 01:53:30 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] drm: use capital "OR" for multiple licenses in SPDX
Date:   Wed, 23 Aug 2023 10:53:11 +0200
Message-Id: <20230823085311.113751-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation/process/license-rules.rst and checkpatch expect the SPDX
identifier syntax for multiple licenses to use capital "OR".  Correct it
to keep consistent format and avoid copy-paste issues.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpu/drm/drm_client.c        | 2 +-
 drivers/gpu/drm/drm_format_helper.c | 2 +-
 include/drm/drm_client.h            | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_client.c b/drivers/gpu/drm/drm_client.c
index 037e36f2049c..a67db38cb4e5 100644
--- a/drivers/gpu/drm/drm_client.c
+++ b/drivers/gpu/drm/drm_client.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or MIT
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
  * Copyright 2018 Noralf Trønnes
  */
diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index f93a4efcee90..ffb09938b0f9 100644
--- a/drivers/gpu/drm/drm_format_helper.c
+++ b/drivers/gpu/drm/drm_format_helper.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or MIT
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
  * Copyright (C) 2016 Noralf Trønnes
  *
diff --git a/include/drm/drm_client.h b/include/drm/drm_client.h
index c0a14b40c039..3b396567691a 100644
--- a/include/drm/drm_client.h
+++ b/include/drm/drm_client.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or MIT */
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
 
 #ifndef _DRM_CLIENT_H_
 #define _DRM_CLIENT_H_
-- 
2.34.1

