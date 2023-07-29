Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F69767A2B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 02:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236128AbjG2Auv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 20:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbjG2Auf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 20:50:35 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B654C0B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 17:50:04 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fe0eb0ca75so4624426e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 17:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690591754; x=1691196554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HcpHajTaDbkiN1SmMKnkIjR4kEQTV0CiarudRewqC4M=;
        b=qup1r5mEULabDCd1ImqHW7xNa6N8vd07IyxUGSqzY9P8lVSNf1c3xfifZFu7E/M4aZ
         Tlf8v3YwBqpkkUx9ScZL7oLdOthcsrqZvmVEAUVPg0pbcduf5yqF3Frf7b/KEsUYLjdx
         nLUnundJU/GElBBhNhz484f/Ax2lAiYCbubUD50mJxFRrKO97NSKf2fj98Ry1wmAMySv
         BqQ+e/waVl0L2SLOHdq6G494CdYyRVvYJzgCYOPHf6rvGOnzmWHtzp67kUAY89ACbZPB
         Mv3h1fGB/LaypW7E+EPepd3i4gT9EEeo4fgdZ0vVqSsoMD3dKKvvguBF4j2724I+bOL9
         jxFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690591754; x=1691196554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HcpHajTaDbkiN1SmMKnkIjR4kEQTV0CiarudRewqC4M=;
        b=isg/Qw3/Z9fUQ8svUssA47tBDJv0+AtD3ApntLrCU96gileIN9hyn1Du3V42mHeVWc
         AK59VuasifTeHKZ0t92WSc7ap/yTTboDEADfNZwHquKJWTP6VY/OjMEQNcdcaqBs0nkY
         r+Srd7uLx6AnvxP9pu60zzY1THQ/b9muQY8dBHEP/RYncZF2qvIBZ9NiBHf8wqX/hrui
         qitAllBOofNq/Y2hVperYnyj3R/Ce5sbRwghdxOQuVTGcBs4akOzzvh43VH26if0c5HD
         rnoghSs46CToiI8tX6OelgZJhDa2hkvSCVoM86zUzddKmMCQtQ9w9KBqNF1pXswerABC
         eIJQ==
X-Gm-Message-State: ABy/qLbUYrveB9V4/GsqYUZBf21ngTGnPQyQfSY80tLRRlye1NoWp9Bh
        oftzdLljVPTrqbGEDsaafK5ERQ==
X-Google-Smtp-Source: APBJJlHHFFRedGkZ4zanjYhAuAchLEIUJIiyKrxAJi2F4NVKP+9VlNvY5pQAKk7npRBfrHlFd5ETVQ==
X-Received: by 2002:a05:6512:1116:b0:4fb:9712:a717 with SMTP id l22-20020a056512111600b004fb9712a717mr3341583lfg.13.1690591754194;
        Fri, 28 Jul 2023 17:49:14 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id a24-20020a19f818000000b004fe20d1b288sm500702lff.159.2023.07.28.17.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 17:49:13 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Simon Ser <contact@emersion.fr>, Janne Grunau <j@jannau.net>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: [PATCH 0/4] drm/bridge-connector: simplify handling of USB-C DP
Date:   Sat, 29 Jul 2023 03:49:09 +0300
Message-Id: <20230729004913.215872-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the discussion of DP connetors, it was pointed out that existing
DP drivers supporting USB-C altmode (AMDGPU, Intel) use
DRM_MODE_CONNECTOR_DisplayPort for such connectors rather than
DRM_MODE_CONNECTOR_USB.

This patchset attempts to solve this issue. It adds USB to the enum
drm_dp_subconnector and then provides a simple yet efficient way to
define DP-in-USB subconnector type for the drivers that use
drm_bridge_connector.

Dmitry Baryshkov (4):
  drm: allow specifying default subtype for the DP subconnector property
  drm/bridge-connector: handle subconnector types
  drm/uapi: document the USB subconnector type
  soc: qcom: pmic_glink: properly describe the DP connector

 .../gpu/drm/amd/amdgpu/amdgpu_connectors.c    |  3 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  3 +-
 drivers/gpu/drm/drm_bridge_connector.c        | 33 ++++++++++++++++++-
 drivers/gpu/drm/drm_connector.c               |  7 ++--
 drivers/gpu/drm/i915/display/intel_dp.c       |  3 +-
 drivers/soc/qcom/pmic_glink_altmode.c         |  3 +-
 include/drm/drm_bridge.h                      |  4 +++
 include/drm/drm_connector.h                   |  3 +-
 include/uapi/drm/drm_mode.h                   |  1 +
 9 files changed, 52 insertions(+), 8 deletions(-)

-- 
2.39.2

