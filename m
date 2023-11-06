Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD0C7E31CA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 01:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbjKGAAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 19:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbjKGAAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 19:00:31 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E284BB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 16:00:29 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2802b744e52so4866010a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 16:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699315228; x=1699920028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=21e/wYlKKqV9mT9+9Mlh/xElPGx/iUs7TKMPyQ0Zc0U=;
        b=CXKuwOrE3FKtyojjQkC0IpD7P5JIySPfizZZdQZqAs/8TrvCEmXuwFV1NxwBX3gqNJ
         TXYxud4F4U3XzFJkkoUFgb75bd5Ufjo8h3xe7/NifwOo3DQ/hCkAbUq4kk54Ku+qE1ev
         ZW59c2VFTH5yTZhzpOd3XNHbmdu/B5lakEgIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699315228; x=1699920028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=21e/wYlKKqV9mT9+9Mlh/xElPGx/iUs7TKMPyQ0Zc0U=;
        b=Kj3I49EIySyiGx//d/0/5D0SUucrcF9oiEi/Ix6paTxQJ+t0beuX0AcsYDCtZYMtRX
         AESM6E7Wan/H6zSOfC8jjjh5LK6m9daIY08UqDwaNmrKPoY2N4zlxM+RKFEt4Q8a/8XR
         P7mKUflurHqzCwS55edVa6fVBtQGiOW3//nUTQfahEAC1VclG+E0YF23PkuT2DuKU3wd
         JYcuwbVNde8ySmD4qj/Qqz3M6tEUR1XFu/sHWt0hIdVrlegR6BuqFbA395zAZb/KnsfF
         moLM/ZvtKEZ5AxRSzN/0XjKNNjR5nPuKRoqqUgLSs/NFD6KUBdZuNwtkVoPZ9z9dxALH
         zBFw==
X-Gm-Message-State: AOJu0Ywk6ou/sr/kWUXxDxPyArH3Rs5CoLTuTH0W08Ui303YQlbsMAH1
        Dc58TZ/iNMHeHiju/uzFIPGXkA==
X-Google-Smtp-Source: AGHT+IGamsXcnSCA+MbJdg+vx6O6uxyacsDYNxLNHmivj5ndEOFKNmAzOAGJeTNVBtUZoJF3xVuSQg==
X-Received: by 2002:a17:90a:8988:b0:27d:8a04:f964 with SMTP id v8-20020a17090a898800b0027d8a04f964mr1202135pjn.24.1699315228619;
        Mon, 06 Nov 2023 16:00:28 -0800 (PST)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:586c:80a1:e007:beb9])
        by smtp.gmail.com with ESMTPSA id fw11-20020a17090b128b00b00268b439a0cbsm5852866pjb.23.2023.11.06.16.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 16:00:28 -0800 (PST)
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
Subject: [PATCH v5 0/4] Add a few panels and use correct modes
Date:   Mon,  6 Nov 2023 15:51:31 -0800
Message-ID: <20231107000023.2928195-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains 3 patches:
1. Add a few new generic edp panels.
2. Support a new quirk to override the mode read from edid
3. Only add hard-coded mode if both edid and hard-coded modes presents.

v1: https://patchwork.kernel.org/project/dri-devel/cover/20231101212604.1636517-1-hsinyi@chromium.org/
v2: https://patchwork.kernel.org/project/dri-devel/cover/20231102221309.1971910-1-hsinyi@chromium.org/
v3: https://patchwork.kernel.org/project/dri-devel/cover/20231106202718.2770821-1-hsinyi@chromium.org/
v4: https://patchwork.kernel.org/project/dri-devel/cover/20231106210337.2900034-1-hsinyi@chromium.org/

Hsin-Yi Wang (4):
  drm/panel-edp: drm/panel-edp: Fix AUO B116XTN02, B116XAK01 name and
    timing
  drm/panel-edp: drm/panel-edp: Add several generic edp panels
  drm/panel-edp: Add override_edid_mode quirk for generic edp
  drm/panel-edp: Avoid adding multiple preferred modes

 drivers/gpu/drm/panel/panel-edp.c | 134 +++++++++++++++++++++++++++---
 1 file changed, 122 insertions(+), 12 deletions(-)

-- 
2.42.0.869.gea05f2083d-goog

