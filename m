Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE087DE763
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 22:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345140AbjKAV0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 17:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344769AbjKAV0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 17:26:14 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0755B111
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 14:26:09 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5b97ca78da8so186890a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 14:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698873968; x=1699478768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RaBR3pdZUAMcYqGQ5rjk3BKUdj96ofVF3tOiVxQkxxA=;
        b=CUJM+wvfEnVELybvQbArCSK6dMeueUxtpmfhGmxzqg9pMZiB72aJNzUsXjXPAYbZoF
         IWMc8JGDo24J18Yeg0HDG/KitLz8P65/DM+5LZqw4QvIhQU+0eMy/pQdd5okb9lJAURc
         m94+yI4gQ7IukRCr1BevBTA2Gx/gDRp7oAzYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698873968; x=1699478768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RaBR3pdZUAMcYqGQ5rjk3BKUdj96ofVF3tOiVxQkxxA=;
        b=j0F0xnX0ookDfFcoCJsM705+ah+ADx3FEkLae8u7fCUrTV7MO63njZyNeeykTCRTP7
         uv9ca6QxZuslnmQQtdkXGrZN1NbKy3h6kDanIEbuO8yZ2UycrU8JnjmfP/mWpP72fK8u
         sSIy9eY76vMw0cmXhNd3lp4tANc6qpG0hNlz8k2J/N3thvvm+NmUOWKT7rSGqPvTCYqD
         E07EF9LCTliW1+ePzsTHFLgtEbnuLgQFpWpr8tS4LNVIiBaheOprkYa4uRXbETBVaGHb
         nSL1TU0wFpHgQDK2kxEezpQB0XiLyK0z4tUCT1t0G1ieHZ+zhdkm8ngNZIVXgS2+Lj5T
         xcrw==
X-Gm-Message-State: AOJu0YybLEyloXEwpT7CMpjZ5YpMdKLhrQb7AAX7LiZbsbGD3zKtlkep
        m9eqeJ4Sz43L6e0knnB2XEGSvg==
X-Google-Smtp-Source: AGHT+IGgARV5iLsJRlXNajtZlYEyZPKvJyobhwMJcQbUtPb3iVyOs339FAejB7L/BwYZAqms9kTZZQ==
X-Received: by 2002:a17:90b:904:b0:280:2652:d4c with SMTP id bo4-20020a17090b090400b0028026520d4cmr10217498pjb.13.1698873968459;
        Wed, 01 Nov 2023 14:26:08 -0700 (PDT)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:b410:473c:2b92:2e2e])
        by smtp.gmail.com with ESMTPSA id ds21-20020a17090b08d500b00274262bcf8dsm1212976pjb.41.2023.11.01.14.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 14:26:08 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Add a few panels and use correct modes
Date:   Wed,  1 Nov 2023 14:20:08 -0700
Message-ID: <20231101212604.1636517-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains 3 patches:
1. Add a few new generic edp panels.
2. Support a new quirk to override the mode read from edid
3. Unset preferred mode from edid if hard-coded mode presents.

Hsin-Yi Wang (3):
  drm/panel-edp: Add several generic edp panels
  drm/panel-edp: Add override_edid_mode quirk for generic edp
  drm/panel-edp: Choose correct preferred mode

 drivers/gpu/drm/drm_modes.c       |  16 ++++
 drivers/gpu/drm/panel/panel-edp.c | 135 ++++++++++++++++++++++++++++--
 include/drm/drm_modes.h           |   1 +
 3 files changed, 144 insertions(+), 8 deletions(-)

-- 
2.42.0.869.gea05f2083d-goog

