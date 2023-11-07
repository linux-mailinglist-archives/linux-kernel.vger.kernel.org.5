Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9322E7E4A03
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 21:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235104AbjKGUqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 15:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbjKGUqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 15:46:20 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E390137
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 12:46:18 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6d30d9f4549so3923669a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 12:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699389978; x=1699994778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CI8E8ZkOUyQxsoOHsWIKkWEPfMjq/RkXlFb3jvVXrZI=;
        b=ZCfIKXD/gmWcZFNcWi81hDJVRyixrxNVm/BITu3cJ+YvEgTOyRtPzmygazh/3P9Pdx
         vlo0hVWl8Cbfh6v9s+TtnHgM7KYSxveHMuUqmgCXCvpBt7vdAVpRl9k6VUgDIrT0Vn9E
         0whaa6sCdXAm5y1L+T0V8pt2uSP33KgFNqMPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699389978; x=1699994778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CI8E8ZkOUyQxsoOHsWIKkWEPfMjq/RkXlFb3jvVXrZI=;
        b=vF6cQu27grC/M3aZrcsZuh1IQ5GoZv19xd6nnc0J39ujOsNZRgFCT1wxcwkhGkiQ2P
         +YNPotIkZI0JsOdBGlMpAF96nk3R909P6a5QJzX6muyNCUp7QW75cy/yNjwoSC/7SX21
         M+GtKaXz/Ra+UaPa8zv1lgv2CE58GFI9+62xiq1+rwB9ac0Ok7bp+tGjY/hPzHxUOCvT
         f7+R0oJ4HZ9lx8eR3lNnrWH8jZOi3dWOghvGennuztWMeSQ9+slnMGrDE1Mair0EyzDH
         tAq3CPZtvVVySMFvoY0K5YoRlv91UkP8ahnEAzXd0tRqYy1x82tlXH0Ik4U6LcKnPfkD
         lMiA==
X-Gm-Message-State: AOJu0YyE0cuu8sUHLxeSk0c3oNnhkg8LjWg6anIhPH/Z5dSsIt6MpgYF
        Ycz5orckZMB4oh+RJ00tPj1vqw==
X-Google-Smtp-Source: AGHT+IG4+WjPFmv9VQuDc3IYdvpiQQnqLiKzlENFNXYIcyp8lIWVCPZ8pWJUN350sbXi/kkpjcSeTQ==
X-Received: by 2002:a05:6871:7248:b0:1e9:d4fd:6554 with SMTP id ml8-20020a056871724800b001e9d4fd6554mr5120551oac.39.1699389977846;
        Tue, 07 Nov 2023 12:46:17 -0800 (PST)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:586c:80a1:e007:beb9])
        by smtp.gmail.com with ESMTPSA id e7-20020a630f07000000b005ab46970aaasm1750211pgl.17.2023.11.07.12.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 12:46:17 -0800 (PST)
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
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v6 0/5] Add a few panels and use correct modes
Date:   Tue,  7 Nov 2023 12:41:50 -0800
Message-ID: <20231107204611.3082200-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains following patches:
1-2. Fix 2 panel naming and timing.
3. Add a few new generic edp panels.
4. Support a new quirk to override the mode read from edid
5. Only add hard-coded mode if both edid and hard-coded modes presents.

v1: https://patchwork.kernel.org/project/dri-devel/cover/20231101212604.1636517-1-hsinyi@chromium.org/
v2: https://patchwork.kernel.org/project/dri-devel/cover/20231102221309.1971910-1-hsinyi@chromium.org/
v3: https://patchwork.kernel.org/project/dri-devel/cover/20231106202718.2770821-1-hsinyi@chromium.org/
v4: https://patchwork.kernel.org/project/dri-devel/cover/20231106210337.2900034-1-hsinyi@chromium.org/
v5: https://patchwork.kernel.org/project/dri-devel/cover/20231107000023.2928195-1-hsinyi@chromium.org/

Hsin-Yi Wang (5):
  drm/panel-edp: drm/panel-edp: Fix AUO B116XAK01 name and timing
  drm/panel-edp: drm/panel-edp: Fix AUO B116XTN02 name
  drm/panel-edp: drm/panel-edp: Add several generic edp panels
  drm/panel-edp: Add override_edid_mode quirk for generic edp
  drm/panel-edp: Avoid adding multiple preferred modes

 drivers/gpu/drm/panel/panel-edp.c | 134 +++++++++++++++++++++++++++---
 1 file changed, 122 insertions(+), 12 deletions(-)

-- 
2.42.0.869.gea05f2083d-goog

