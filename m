Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2597ADA79
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 16:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbjIYOvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 10:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbjIYOu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 10:50:57 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BED10DD
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 07:50:37 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9ae75ece209so627094766b.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 07:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695653436; x=1696258236; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xVBQu+EOw1PmbAsM8MVxwLWNiPJx9g9J6r5rPkOJ17w=;
        b=mO8UVCwmONuxA6zOKOfH+pWMMk75emUgsJpV3SupRJLgmE7bBmR78yw0NSOVy+5BfW
         qlIDY/KFyCGCJUf28iTPokhiVRJr0C8ro2e6cdSC1dUxVwbuz/6FSX0wX+JFGEBrkjQx
         JiuW1TQ3se4VpPhOUgGYBky7DGAG6zj1UpSFwVdgNgQIt5/PeXjK6io2v8b4CU6tC5/I
         +kvYNKgWWsrkZUT6c5QpJPV6UfT3lzegQBQI3794dXD8dApf+ZwbLAZEVAJ95WkEO+5R
         9VrCqoOsKsBHCHKKCiowJerddsk6RMEWimJCEiowEXaHUZRgHfX3uaq51dxsCujz5HXl
         AWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695653436; x=1696258236;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xVBQu+EOw1PmbAsM8MVxwLWNiPJx9g9J6r5rPkOJ17w=;
        b=F6JU6rMTSbpF+AsivONvDHp2um/6Fo+nveb1b5TSdpyWo1VJkjv6MQYiKRW7vOqc8U
         zNk7A0BrM3ir4QkVPvE7NydK0Z0KW0/9E93fA3LfS7JXlRtu21ACKC5RAFpk5GWgbWCj
         Ul40m6FjVHKSFRHqb7B8NggZBLK4UGGcKiAsYFP6IPe6zrvEjh+U3W+ypr96xUQQT/KJ
         cjbMTzolytaproUbVtSmBgm8BuqpBqMZQPxxMMXodh+Co+J+yR60d3ftwVgZ2ixiA0JQ
         FQowsDe+nMagQxkZNpikqwqdsph5HbmE+FhKrmdYKjRmN0ehneSHX+HAdqj/PJQNjR8e
         fp6A==
X-Gm-Message-State: AOJu0YyPTs7YNnPbisZcTqVyxlio3tEVJKo3UUSY6wa2pqGQc0+NcdVy
        sLy/kgCANaBRepAuMbuKF92hww==
X-Google-Smtp-Source: AGHT+IE9443BXn2REe1XPTgU9v4rMrVtAhnLw6kYit08HxuWn5Ry3cZcTmUSKqXMy48JIHKYLqY/iw==
X-Received: by 2002:a17:906:1da1:b0:9ae:5367:fe90 with SMTP id u1-20020a1709061da100b009ae5367fe90mr6087091ejh.32.1695653435992;
        Mon, 25 Sep 2023 07:50:35 -0700 (PDT)
Received: from [10.167.154.1] (178235177023.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.23])
        by smtp.gmail.com with ESMTPSA id k8-20020a170906a38800b0099bc2d1429csm6426640ejz.72.2023.09.25.07.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 07:50:35 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v5 00/10] A7xx support
Date:   Mon, 25 Sep 2023 16:50:29 +0200
Message-Id: <20230628-topic-a7xx_drmmsm-v5-0-3dc527b472d7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADWeEWUC/4XNTQrCMBQE4KuUrI3kz8a68h4ikqYvbaBNSqKlI
 r27z+5EsMsZmG9eJEPykMmpeJEEk88+BgyHXUFsZ0IL1DeYiWBCslIc6T2O3lKj5/nWpGHIA+V
 COskaXVqnCe5qk4HWyQTb4TI8+h7LMYHz83p0uWLufL7H9Fx/J/5p/11MnDIsnFJVCcxyce59M
 CnuY2rJh5vkJiGRUACltrY2rmp+CLVJKCSOtQTFhK4Oln8Ry7K8AeNK3oZOAQAA
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695653434; l=4385;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=ibIEoOxfWVTx5P1fKNckEAMdts2RQ8B70gd0WPFTIjE=;
 b=UkDpg06Mc4h9t6H20rAAIW427Z8mCjVWLdqsqt/SHTUC5lEhBxFmMAhJvZtSb9eXFR9azByDu
 2VT5laa+lDHADiM5LIrcEpGmzWWbTp58SqUaBZrhamsofV7dwYCMpA+
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series attempts to introduce Adreno 700 support (with A730 and A740
found on SM8450 and SM8550 respectively), reusing much of the existing
A6xx code. This submission largely lays the groundwork for expansion and
more or less gives us feature parity (on the kernel side, that is) with
existing A6xx parts.

On top of introducing a very messy set of three (!) separate and
obfuscated deivce identifiers for each 7xx part, this generation
introduces very sophisticated hardware multi-threading and (on some SKUs)
hardware ray-tracing (not supported yet).

After this series, a long-overdue cleanup of drm/msm/adreno is planned
in preparation for adding more features and removing some hardcoding.

The last patch is a hack that may or may not be necessary depending
on your board's humour.. eh.. :/

Developed atop (and hence depends on) [1]

The corresponding devicetree patches are initially available at [2] and
will be posted after this series gets merged. To test it, you'll also need
firmware that you need to obtain from your board (there's none with a
redistributable license, sorry..). Most likely it will be in one of
these directories on your stock android installation:

* /vendor/firmware
* /vendor/firmware_mnt
* /system

..but some vendors make it hard and you have to do some grepping ;)

Requires [3] to work on the userspace side. You'll almost cerainly want
to test it alongside Zink with a lot of debug flags (early impl), like:

TU_DEBUG=sysmem,nolrz,flushall,noubwc MESA_LOADER_DRIVER_OVERRIDE=zink kmscube

[1] https://lore.kernel.org/linux-arm-msm/20230517-topic-a7xx_prep-v4-0-b16f273a91d4@linaro.org/
[2] https://github.com/SoMainline/linux/commits/topic/a7xx_dt
[3] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/23217

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes in v5:
- Rebase
- Link to v4: https://lore.kernel.org/all/20230628-topic-a7xx_drmmsm-v4-0-8b3e402795c1@linaro.org/

Changes in v4:
- Add missing bitops.h in patch 5 for arm32 compilation (Dmitry)
- Link to v3: https://lore.kernel.org/r/20230628-topic-a7xx_drmmsm-v3-0-4ee67ccbaf9d@linaro.org

Changes in v3:
- Pick up tags
- Drop "increase HFI timeout", will revisit another day
- Use family identifiers in "add skeleton a7xx support"
- Drop patches that Rob already picked up
- Retest on A730, didn't explode
- Link to v2: https://lore.kernel.org/linux-arm-msm/20230628-topic-a7xx_drmmsm-v2-0-1439e1b2343f@linaro.org/#t

Changes in v2:
- Rebase on chipid changes
- Reuse existing description for qcom,aoss in patch 2
- Pick up tags
- Link to v1: https://lore.kernel.org/r/20230628-topic-a7xx_drmmsm-v1-0-a7f4496e0c12@linaro.org

---
Konrad Dybcio (10):
      dt-bindings: display/msm/gmu: Add Adreno 7[34]0 GMU
      dt-bindings: display/msm/gmu: Allow passing QMP handle
      dt-bindings: display/msm/gpu: Allow A7xx SKUs
      drm/msm/a6xx: Add missing regs for A7XX
      drm/msm/a6xx: Add skeleton A7xx support
      drm/msm/a6xx: Send ACD state to QMP at GMU resume
      drm/msm/a6xx: Mostly implement A7xx gpu_state
      drm/msm/a6xx: Add A730 support
      drm/msm/a6xx: Add A740 support
      drm/msm/a6xx: Poll for GBIF unhalt status in hw_init

 .../devicetree/bindings/display/msm/gmu.yaml       |  47 +-
 .../devicetree/bindings/display/msm/gpu.yaml       |   4 +-
 drivers/gpu/drm/msm/adreno/a6xx.xml.h              |   9 +
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              | 199 +++++--
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h              |   3 +
 drivers/gpu/drm/msm/adreno/a6xx_gmu.xml.h          |   8 +
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              | 653 +++++++++++++++++++--
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c        |  52 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h        |  61 +-
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c              |  88 +++
 drivers/gpu/drm/msm/adreno/adreno_device.c         |  30 +
 drivers/gpu/drm/msm/adreno/adreno_gpu.c            |   7 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h            |  32 +-
 drivers/gpu/drm/msm/msm_ringbuffer.h               |   2 +
 14 files changed, 1073 insertions(+), 122 deletions(-)
---
base-commit: 8fff9184d1b5810dca5dd1a02726d4f844af88fc
change-id: 20230628-topic-a7xx_drmmsm-123f30d76cf7

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

