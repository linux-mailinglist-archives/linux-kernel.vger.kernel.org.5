Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76EE57E2E27
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 21:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbjKFU11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 15:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjKFU10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 15:27:26 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE42ED71
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 12:27:23 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6b77ab73c6fso3885844b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 12:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699302443; x=1699907243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=80E3933pskVlE5UyIRV6Ob4lwrCmfSHIsxb+JaP6S0I=;
        b=Sp9MEwLO4ifu/D7BHUiv4t9ZGeKViCsSfhYCqlDmH+8yE4QVQlo0tFPMgLPFISRGQC
         TLNnc677HAEcLfEII6apLbVK0FarGfB0WyBZQxWndHWvB4mPrs1WFENRouaI+OHS3N6c
         Pts2m331z/LWIrQwJdPM5PlTlIpXdDcuki3aU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699302443; x=1699907243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=80E3933pskVlE5UyIRV6Ob4lwrCmfSHIsxb+JaP6S0I=;
        b=jZs846mWLGcrALmfiPdGBoz+S4SNOiKVNLn41zMbUK39qtuZKGqJzBBHzzU+pRXBmg
         lwe1OA2FSvO83yZjNunTyKUBXRmoRNEeCaVXWbBhAUl+cOfG2nu58lW9iGjj5iGw7jrP
         bc7bOBgyJCXa0HoqeP5tbCNbl7O98bcwhe1KoBDlkCFIdBkMpADO5nWatEeBoghjNwf4
         +nGqx/URgi9aD5TlY6246vKgkecYZemFv8ifUAscrKjfKAPKB+5yAXBpGFktz62as4Bi
         cnVAPhMrTCswtweomEGL9hzWcWXG5btei26Qwm00Y95Wn4CLb2FjcWQjSWWF4kvaJ7Gc
         kRyg==
X-Gm-Message-State: AOJu0Yxm9XOcXRA7RSBThaAg3FDI9t3SXJJ8HIgqhpyRNaxI2aH7bjTB
        jpvM3o6hLzIormUhnVeBG1xXGg==
X-Google-Smtp-Source: AGHT+IFt2a2rg2N35fU4YkotwbhqznStieELiLySmeft6wTdm0GPhFQxNEJH0xIcvECj7GXb4c3NJQ==
X-Received: by 2002:a05:6a00:14c5:b0:68e:351b:15b9 with SMTP id w5-20020a056a0014c500b0068e351b15b9mr817734pfu.4.1699302443259;
        Mon, 06 Nov 2023 12:27:23 -0800 (PST)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:3374:ff6c:474e:a78])
        by smtp.gmail.com with ESMTPSA id fj36-20020a056a003a2400b00689f5940061sm6144150pfb.17.2023.11.06.12.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 12:27:22 -0800 (PST)
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
Subject: [PATCH v3 0/3] Add a few panels and use correct modes
Date:   Mon,  6 Nov 2023 12:22:47 -0800
Message-ID: <20231106202718.2770821-1-hsinyi@chromium.org>
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

Hsin-Yi Wang (3):
  drm/panel-edp: drm/panel-edp: Add several generic edp panels
  drm/panel-edp: Add override_edid_mode quirk for generic edp
  drm/panel-edp: Avoid adding multiple preferred modes

 drivers/gpu/drm/panel/panel-edp.c | 148 ++++++++++++++++++++++++++----
 1 file changed, 132 insertions(+), 16 deletions(-)

-- 
2.42.0.869.gea05f2083d-goog

