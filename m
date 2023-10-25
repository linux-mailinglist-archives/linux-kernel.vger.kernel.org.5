Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0AC7D638B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbjJYHiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233935AbjJYHhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:37:31 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEEA3841
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:35:08 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507a3b8b113so7984817e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698219306; x=1698824106; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sSYQpLoxd/vTN3zIpzIjjE32x4L+dyHKf7hVMquCel8=;
        b=vLyyDrgFP4GokYrbS9EJOzeOrQ8aeaM3sorCn8xxa0EBXn4Br/Zn+brgFDJo3ltocC
         npaNU6sRg1+2Dujkf2G6vLHc/uaSTcTVr5BzXScGXswRRH9ArEhHDa9lEK/26F7Qq3bE
         5EO1PHEKRneI1aqOToQOYNf981AQ3G7XPqGfWnh7oNnmyyFYMA1A84tQlOeW6x3y+3Pn
         27c3dA4p+8m5HCMcyR1X9TDkCRVuK7beyu9M9nTkRBA1xKGGHYg6WxJ18+mvaseH2m8p
         qh2Fp3/2W0mNV0xbebfKvTMUgeIhxt4UCLZ7iyqkSfzEB0cieqbXr6NatUy7i4yRtBHY
         2UdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698219306; x=1698824106;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sSYQpLoxd/vTN3zIpzIjjE32x4L+dyHKf7hVMquCel8=;
        b=F5p1AuPyNDdHQTNr0hE9y/awTXnhbmkr2y+Wd9ih9tim2yOX8T9dougZW10SEBigkA
         8tNDUykJGZIm8HXeZ8cnF6LRtkdsEZKwcygjZhu0zurzk9TmGHjFNG3sPxa9YB2eVZ6g
         CnUnrs0BnzgR8UM58y8rsvf6ASsMv46wbyHcL8Dsph3rkqpRssnNVptxczv833yQsfMK
         JF0uZlwRC5GO+a9oT/pq2jCAkXL+23FnJXUaqNFz4MfBBwWHnc2fv0sv2A9rJDzvsrCH
         Ugjn3nTvFfUf+m7HDwxvPj0sp8GTEl+ZlomHTnTmcQYN0vnpzkBId4Yk9daCzS0UY2Yc
         Px1A==
X-Gm-Message-State: AOJu0Yy/+Ij6b23abWVWt/ZoSmO+n5LRaV9x75UZy3bj4sFYIhNiS2FP
        UED/A4MMmSRrSN6U0c0XgToUKg==
X-Google-Smtp-Source: AGHT+IGurdsk+zX+6QXgEz0gEKxO+y3oo0icVhPQGYAW6na1Lo1fkepVRaRDbwBsE8L8Xro8oCJLgw==
X-Received: by 2002:a2e:a404:0:b0:2c5:d10:248f with SMTP id p4-20020a2ea404000000b002c50d10248fmr11157029ljn.49.1698219306331;
        Wed, 25 Oct 2023 00:35:06 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id x18-20020a5d60d2000000b003248a490e3asm11449058wrt.39.2023.10.25.00.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 00:35:05 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/8] drm/msm: Introduce display support for SM8650
Date:   Wed, 25 Oct 2023 09:34:58 +0200
Message-Id: <20231025-topic-sm8650-upstream-mdss-v1-0-bb219b8c7a51@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACLFOGUC/x3MOwqAMAwA0KtIZgOt4vcq4qBt1AzV0qgIxbtbH
 N/yIggFJoE+ixDoZuFjT9B5Bmab9pWQbTIUqii10jWeh2eD4tq6Unh5OQNNDp0VQSptV5HqTDO
 3kAIfaOHnz4fxfT8k7ypmbAAAAA==
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2455;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=nlS7V9RDxDsW5lp+zO+/rnJBlfiyvlUNuUD8vMZXJtM=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlOMUlKghnMXY6BmgIYR9wKs5nCGd8a5RJCWR4WfKY
 oW8HPZaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZTjFJQAKCRB33NvayMhJ0X7/EA
 COSCAPZ2obB3+VHNndHNi5nCdsdO/aexNkdu5JwPUst7Mw0DTj1cpf7BHVkbP95tmKcLPacxv41O6U
 of/p/Rjsv33iYvldRQH6hIwII6rBh1tlpzlubNuGjskb99H7e1fDuEx38lmYoIiejGwW3EUO68WoBl
 FE5blcuBBGUGzRNEL8XJpucKcN6PbuU334OF5x5vssNtqxcinkMmDO+ifPUhmAonSYiuxWpqigswEz
 4KelqQjr9Ua/bNfj7xS8wHj97Sjqi28gn031Hm3KcyXkbDeL3SoNXNpbdvkkaJL/RoBySn7U+Gr93b
 3i2wYYde5rXtgwyGXEKtmOVSNmbxNdblLaR4Zh1MG2scpw5wwQgjmXsB3grE9vj7l8CnqIs2v5J4UF
 EfMUfiuvYqrjhU3pV0C5jVlYOueEXrw1el/zyDWrdHFyt6OCpSkpRa6EOPAW0xJnt/0LbdLj9wxLxE
 CSzIRAI1JIzubuTaLXI2kfVKlq7lI+roW7N1xHnViWtEng8duwswQMo8Q3Q7kjYJYY8jURVWKs+NAN
 2JDY5L11fFKn0kLveeN2e2IITKiEGG+rU4NiKbBSVUpxC9VXr8yGNUqO9RYta1LApEXHe4nTOU9ojD
 cAeTDYL8UOcfSDFyIyQ6CofjljrSaC89x7idlmzlQjkpTamL/4h7t+RzNdYQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SM8650 MDSS is very close from the MDSS 9.0.0 found
on the SM8550 SoC, with the following difference:
- DSI PHY 2.8.8, no significant differences
- DPU 10.0.0:
  - Enhanced max_linewidth to 8k
  - PINGPONG_8 & PINGPONG_9
  - MERGE_3D_4
  - DSC_4 & DSC_5, DSC_NATIVE_42x on DSC0/1

This patchset contains DSI PHY, DSI Controller, DPU & MDSS bindings
in addition to the driver changes.

Support for Display Port output is expected for later.

Dependencies: None

For convenience, a regularly refreshed linux-next based git tree containing
all the SM8650 related work is available at:
https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm85650/upstream/integ

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (8):
      dt-bindings: display: msm-dsi-phy-7nm: document the SM8650 DSI PHY
      dt-bindings: display: msm-dsi-controller-main: document the SM8650 DSI Controller
      dt-bindings: display: msm: document the SM8650 DPU
      dt-bindings: display: msm: document the SM8650 Mobile Display Subsystem
      drm/msm: dpu1: add support for SM8650 DPU
      drm/msm: mdss: add support for SM8650
      drm/msm: dsi: add support for DSI-PHY on SM8650
      drm/msm: dsi: add support for DSI 2.8.0

 .../bindings/display/msm/dsi-controller-main.yaml  |   2 +
 .../bindings/display/msm/dsi-phy-7nm.yaml          |   1 +
 .../bindings/display/msm/qcom,sm8650-dpu.yaml      | 127 ++++++
 .../bindings/display/msm/qcom,sm8650-mdss.yaml     | 322 +++++++++++++++
 .../drm/msm/disp/dpu1/catalog/dpu_10_0_sm8650.h    | 458 +++++++++++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |  23 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h        |   3 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   1 +
 drivers/gpu/drm/msm/dsi/dsi_cfg.c                  |  17 +
 drivers/gpu/drm/msm/dsi/dsi_cfg.h                  |   1 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c              |   2 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.h              |   1 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c          |  27 ++
 drivers/gpu/drm/msm/msm_mdss.c                     |   1 +
 15 files changed, 987 insertions(+)
---
base-commit: fe1998aa935b44ef873193c0772c43bce74f17dc
change-id: 20231016-topic-sm8650-upstream-mdss-e3d95e09c7b8

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

