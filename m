Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16A17DFC3A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 23:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjKBWNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 18:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjKBWNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 18:13:20 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B077191
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 15:13:14 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-586f1db1a83so758660eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 15:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698963193; x=1699567993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uZpKHIQGQChjn03OiR6zvh7oQbUczJl1KxbRNlHYq3c=;
        b=cPivazfpuG1GcwvdqOBu2JUrLASk0SLHjlW0JHETTK69jRWEP+2QxmWof3hYlotP+L
         n1dU4CZQs3fzt20pXp2r1ohM3p8DAqJ0fzYgIynworWnJc3Rs5WicsO993i1LikMZiO5
         +D/+bx6CuX76T4dAc+RYvrXcdLylIQorPM4/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698963193; x=1699567993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uZpKHIQGQChjn03OiR6zvh7oQbUczJl1KxbRNlHYq3c=;
        b=Z4TgpZos3HU83bJWSSzCNOohQC+57cSpXTxo7MlJQOYw28cG6ZhcZwksdmjzWYI9eD
         9ejlB/htApyzILdmTDMOZPx2Wm/P3rt9JQ0oRMMSeK3Sk9d8QrwK/atRJdknvd6q9Zny
         6DX/tdJk5giScgXVgahKycw23UCovxLwxvDOdxkbLw8voTp6M3DPMIR7h4VK93cqclJ5
         OyJMhUlwnr3GGDW9a/ZcTsr6fQYbCC2JvIxCk5L1C5s0nI6cFeS18JfVpSIEHoVLvbu/
         f9fwE04wdMvjoD+gO9mtQU7+i/0PoH7x3LJbYRFjy31atHOxhX3wm/oUHkaPbrul+/7x
         9Xfg==
X-Gm-Message-State: AOJu0Yz+J7PVLpUkhddAqJN+RlxbmJJo1zgJ9WizE1pwklPsBFGptnxm
        SbpegHvSaSdfXLg5Ref7GgQI+8imSLVeGygndGg=
X-Google-Smtp-Source: AGHT+IFC/eSh0rDu/gw1lIy8MRPibeWao57KTEo2U8j772tz15QeQhOaa3mXupFJ9VCZitSdwvohfg==
X-Received: by 2002:a05:6358:3406:b0:168:d2b5:db9 with SMTP id h6-20020a056358340600b00168d2b50db9mr22988808rwd.6.1698963193581;
        Thu, 02 Nov 2023 15:13:13 -0700 (PDT)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:6ec1:79de:6e50:d6fa])
        by smtp.gmail.com with ESMTPSA id y6-20020a63ce06000000b00565e96d9874sm196057pgf.89.2023.11.02.15.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 15:13:13 -0700 (PDT)
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
Subject: [PATCH v2 0/4] Add a few panels and use correct modes
Date:   Thu,  2 Nov 2023 14:47:46 -0700
Message-ID: <20231102221309.1971910-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains 4 patches:
1. Add a few new generic edp panels.
2. Support a new quirk to override the mode read from edid
3-4. Unset preferred mode from edid if hard-coded mode presents.

v1: https://patchwork.kernel.org/project/dri-devel/cover/20231101212604.1636517-1-hsinyi@chromium.org/

Hsin-Yi Wang (4):
  drm/panel-edp: Add several AUO/BOE panels
  drm/panel-edp: Add override_edid_mode quirk for generic edp
  drm/modes: Add a function to clear preferred modes
  drm/panel-edp: Choose correct preferred mode

 drivers/gpu/drm/drm_modes.c       |  16 ++++
 drivers/gpu/drm/panel/panel-edp.c | 130 ++++++++++++++++++++++++++++--
 include/drm/drm_modes.h           |   1 +
 3 files changed, 139 insertions(+), 8 deletions(-)

-- 
2.42.0.869.gea05f2083d-goog

