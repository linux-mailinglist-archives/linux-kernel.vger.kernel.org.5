Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C9079CCEC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbjILKE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbjILKEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:04:53 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2D610E4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 03:04:49 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99de884ad25so709783866b.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 03:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694513088; x=1695117888; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+FXwfnE1IauPupm8A637R7g09Mpy9nxtGCWUnLceXME=;
        b=AepuZSjARKNU5SNYFywRLawOWThKoV7ab0SCnQgIY8wk05xzZfNioINHgLKfdoUUHg
         70UeMdZlija1JiQ+20xBsvSPjnpM2YsnLRgebQ8AxhscBUbVBRWV/4a0RPjV0baCi7Qb
         aB1jFf1kJNPZoMNnzrRuOqiXXDFkFhb3hvAdsY+ASZ7CfjFFlPFOpOt/xVE8VBOme9BD
         b1eNalj/W9gOd0N4k0++9UXR/rpLDk9ZCz9clQZS40uYJ4Mb77j3ew+tn0FF09vCVeOm
         /5MRbvSY1bdzfqVNzm2GjWTlieKdyXSwcnr/sin95Irc/nCQNhlfjW5n90j0KYu6g+Zi
         H4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694513088; x=1695117888;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+FXwfnE1IauPupm8A637R7g09Mpy9nxtGCWUnLceXME=;
        b=jjyl9Ke1Jamzfj5FcIRAofD248luCa/TnhP8yrGO+Z1nJ/iFypBnQudKNoGUPBuan9
         qenGJu84LCzVm+adSCW10czrEqJRsQDFww9njqZdi4ZqR+F2HIwTcRX7izYfCQdiDlPj
         FGoqyHop6OoM24DqHgePFOvx6Cc6Dzf/UQje6sKetW8gs3odBjhUQnhF9FHcXwAqfgCC
         vkNA7iecBo8A5uAa8V5gtnlVjIiTFH9nHrFnSHhgBRRnuuXzdw4xuJ4pQt64RI10Hzoi
         2MEFZ2CN3V/w7Nk5nKsibwAydBzbEVN7NAz9jaKJdy6ylA1vu7d8y5I6njN7Le6ewU8Z
         cpKw==
X-Gm-Message-State: AOJu0YxfnBsMaDqiVzDDCNQZ06hZqGwHddYJhsH/EX830oUM6j+N93sS
        kDwZcfGiUUs2PlyiQfsxrT1siw==
X-Google-Smtp-Source: AGHT+IFzgbzl/uJDW7dtEb2254RLpIB27LBZCoeWRRGAxq284SAAcjUFpd5pUqDRGmvTffzcr4no+A==
X-Received: by 2002:a17:906:af65:b0:9a2:40e:2cad with SMTP id os5-20020a170906af6500b009a2040e2cadmr9532513ejb.48.1694513087854;
        Tue, 12 Sep 2023 03:04:47 -0700 (PDT)
Received: from [10.167.154.1] (178235177248.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.248])
        by smtp.gmail.com with ESMTPSA id s3-20020a170906060300b0099ce188be7fsm6592053ejb.3.2023.09.12.03.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 03:04:47 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v4 00/10] A7xx support
Date:   Tue, 12 Sep 2023 12:04:42 +0200
Message-Id: <20230628-topic-a7xx_drmmsm-v4-0-8b3e402795c1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALo3AGUC/4WNQQ6DIBQFr2JYlwaBQO2q92iaBuGjJAoGLLEx3
 r3orpt2OZO8eStKEB0kdK1WFCG75IIvwE8V0r3yHWBnCiNKKCOCXvAcJqexksvyNHEc04hryiw
 jRgptJSq7ViXAbVRe92XpX8NQ5BTBuuU4uj8K9y7NIb6P31zv9tdFrjEpwnLeCCC6prfBeRXDO
 cQO7bnM/iZYSXAAIbVulW3MV2Lbtg+o+2LKCwEAAA==
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694513085; l=4257;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=mnEzEN3kzO27Wu8x2zYyICU3fm4Imda0yizn/egK3F0=;
 b=y1YPlIPygVnicpEtAQyzeFxo2RDYfebJPKwp2jNAk/b9zQemsZLPxbqE5R+lDerY2y2qnqw1/
 FR5/IMvuD33CKoxVvw46ZCpZkSDPVKUHdkIIWdM4s73s3KV09BupPPg
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
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
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              | 205 +++++--
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
 14 files changed, 1079 insertions(+), 122 deletions(-)
---
base-commit: c26a0f88bc21bf52303b5a5fbf8edb0cc7723037
change-id: 20230628-topic-a7xx_drmmsm-123f30d76cf7

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

