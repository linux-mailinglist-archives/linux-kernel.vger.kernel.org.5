Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA4F7E2C4E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 19:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbjKFSug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 13:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbjKFSue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 13:50:34 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59206A2;
        Mon,  6 Nov 2023 10:50:32 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6c320a821c4so4305638b3a.2;
        Mon, 06 Nov 2023 10:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699296632; x=1699901432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6cU21C5fA+9HfxPv3J8m9Wghhy7CjkmSAa3XrNBXmko=;
        b=Ie/KIEDqymP0Gju2ZdFvwyIo5XD+M32NgariZ/2qo1NwxvS9C0k9jGkIEtrAn6hKLk
         LSmQWUizswlwJQJwg3gWLfTH2YQKvy7Bd+Evi2K7BHgEkpQB4ytwquJJApCfMp/RsNkH
         B4nArmz1g7DYtj5NteBv/WNZlTNNA13pE+/FiktY/mm8oNNr4h1cBwluctMxq4yqJO3A
         AZdu3sfbKFA2JDEQte2SDEj2j1CEe/JwNbizOGUkEAAeQxJ47nS8IKRB4TA8DYOH2oTX
         WFveUBYe8QR9VETiT/v18TY1gGAPA4612zXaL/jx7w184sW/OhCMnM4qYB95uK5eF5sw
         P/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699296632; x=1699901432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6cU21C5fA+9HfxPv3J8m9Wghhy7CjkmSAa3XrNBXmko=;
        b=RGnuYNs26jRsf4oJyxHhqKt0x/PnyV1eEeaLEnbCEU1OGnL5ZQbl0CYwE2jov0nu+K
         S8hr4X8tZFlO5oc+rwQbge+3xdAL+NEatGAUjiK1hvjKELGTXw3s6JHqDdn13DsbsySf
         joa/TmVUOf0ewjRrrF5JsKcS3a1fryRy4huNnLd47bPb8JP6Bg9g16wyqGYltOwvmEPN
         N9zpbtV0KmJh7uBY+A4cXwc+nDoNgKzebh76GRsi2X8YBL406Basy4Pe1vuWK5riQXxc
         uKaaJ3jFovfs4PLqEIjad6Ju4qq1TiwboApnAP7kQ2NWLd7IEDcu46r7dRD9CB9BT26J
         krbg==
X-Gm-Message-State: AOJu0YxMLw7p9RhmW2kf2BVhYhZ1RKiBNLlyI4YEbFoBzFPL2xzauo3r
        YW/Fe0HJsEo+zrc7INNDveg=
X-Google-Smtp-Source: AGHT+IErzhlvo3uGRZ8ikMypK9vCw5+kSuhekjr2LhVNm7lhbCURZcq8B5VN8mniHRSxNPPNfQAchw==
X-Received: by 2002:a05:6a00:330a:b0:6c3:3bf9:217e with SMTP id cq10-20020a056a00330a00b006c33bf9217emr11111970pfb.19.1699296631673;
        Mon, 06 Nov 2023 10:50:31 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:6c80:7c10:75a0:44f4])
        by smtp.gmail.com with ESMTPSA id n35-20020a056a000d6300b006b90f1706f1sm5941925pfv.134.2023.11.06.10.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 10:50:30 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniel Stone <daniels@collabora.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        linux-kernel@vger.kernel.org (open list),
        linux-pm@vger.kernel.org (open list:POWER MANAGEMENT CORE),
        Marijn Suijten <marijn.suijten@somainline.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sean Paul <sean@poorly.run>
Subject: [PATCH v3 0/2] drm/msm/gem: Add metadata uapi
Date:   Mon,  6 Nov 2023 10:50:24 -0800
Message-ID: <20231106185028.209462-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Add metadata mechanism to provide a back-channel to communicate image
layout information between vk and gl, because EXT_external_objects
doesn't support explicit modifiers and "OPTIMAL_TILING_EXT" is not
enough information for the importer to deduce the layout.

Rob Clark (2):
  drm/msm: Small uabi fixes
  drm/msm/gem: Add metadata

 drivers/gpu/drm/msm/msm_drv.c | 94 ++++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/msm/msm_gem.c |  1 +
 drivers/gpu/drm/msm/msm_gem.h |  4 ++
 include/uapi/drm/msm_drm.h    |  2 +
 4 files changed, 99 insertions(+), 2 deletions(-)

-- 
2.41.0

