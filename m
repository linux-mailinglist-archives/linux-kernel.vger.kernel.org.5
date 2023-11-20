Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AA77F12E6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 13:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbjKTMNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 07:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbjKTMNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 07:13:12 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E319F1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 04:13:08 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-548d4fc9579so864128a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 04:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700482385; x=1701087185; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9gzY9FqizGaQnSZZhxsA0vWZnsDs08MMlwZNySIk8xQ=;
        b=y/LV3iFe+7MjzLNneWb04NdfcRYsvSWDJFdFqQhL/qAzuWjbO15OZw2+/2hPj0SvGR
         O9Ih6dkn11kHGbBsGRWhpXUSQBh2KN9YejQtPQaTg21595QVaLxX2Gmo6RnV0UiS/hw7
         j04Bv2qG+xInMiccVc4cYX49KkeP266nEyLph/oeOuuvH8DWAf/znBPUWCNhzlgZ7kvW
         YTTmDU2pOtcPPIG98/8Q1kSRRABvX2h0+LtHxp7kT5ARTE8JamSuEKqWdq5S+6yojQ0J
         zmKTGKseAFuQvxERMmhfTPFSJUPCK+VTSu5/9jE/HvUz61qOvih1ox+vM1ogU9Snig7e
         +YRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700482385; x=1701087185;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9gzY9FqizGaQnSZZhxsA0vWZnsDs08MMlwZNySIk8xQ=;
        b=fV52kkXGXseN+FjTRrtWlcEEEG2RJfeZU0kZh0jt/f6PRyMLLi3LzNYRf4rkT+hLVJ
         PTSahsAwsCj3ReQw6lVM2Snnf6U0hmUcObBlsZbLZ7I+8U7w9R29KnM3c7V4C26PbhpR
         IRHsOZkZXaX8n0G/cr5ZYW2Tw8rM2S55GcuD5cf3Lnns/QAfcDytMHKy8abwaahdRBnj
         HNPf0c00hQ6sNxVeOVEqCBcpyi7k2mUYFhlTpXRvdtiIfdki5okVWbQ/sxTxJtQUBiWA
         ts5zvAFXHnVAII41dtnISs2W++G/lhdq3lk7RQL5o9U0l291SZj6yOQsvVyB9iB3wkEd
         GmRg==
X-Gm-Message-State: AOJu0YyHvkp8yu/qO3Hl6D8Uzq3bPnh93rCQrTbvTFCLjL/3xSCqff5+
        eitwgHx5fncuB1ncVrMlwf4nzA==
X-Google-Smtp-Source: AGHT+IFCcHlK6Uo5Dn5EOrxOYnCuxGsZot4TPy1ZycY8WEFLZMdX58P1HwLevCsuJ00GPYhXVUYKoQ==
X-Received: by 2002:a05:6402:1605:b0:548:786b:b46c with SMTP id f5-20020a056402160500b00548786bb46cmr1568764edv.8.1700482385623;
        Mon, 20 Nov 2023 04:13:05 -0800 (PST)
Received: from [10.167.154.1] (178235187204.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.204])
        by smtp.gmail.com with ESMTPSA id i22-20020aa7c716000000b00548ac80f90csm1324584edq.40.2023.11.20.04.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 04:13:05 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2 0/4] Adreno 643 + fixes
Date:   Mon, 20 Nov 2023 13:12:51 +0100
Message-Id: <20230926-topic-a643-v2-0-06fa3d899c0a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAENNW2UC/22NQQ6CMBBFr0Jm7ZjSGhBX3sOwGOoAk5CWTJFoC
 He3snb5XvL/2yCxCie4FRsor5Ikhgz2VIAfKQyM8swM1lhnGlvhEmfxSNXFIdXsGzJXclRCHnS
 UGDul4Mc8Ca9pynJW7uV9FB5t5lHSEvVzBNfyZ/9+ryUarKmvGleTN+TukwTSeI46QLvv+xeMw
 7jOugAAAA==
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Rob Clark <robdclark@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700482383; l=1189;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=lzZGsaV15spB0k9fqGINqbiPXsC0S/Y51YP+msYyDY8=;
 b=3uR6tatKteVbqY6ZWNDllqeKEl9etaE/psCLJlK0nI0YanFKwabwox0uOWwDwCRkXAa0Xp9UG
 M3iGEBQ7KyEDee9gS4dvWGhxAeubkU9droGBpdntQ+uOaU4H6j19A4+
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

as it says on the can

drm/msm patches for Rob
arm64 patches for linux-arm-msm

for use with https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/25408

tested on QCM6490 (SC7280-IOT) Fairphone FP5

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes in v2:
- Drop drm/msm patches (all applied)
- Make the commit message of "Fix up GPU SIDs" clearer (Abhinav)
- Drop unwanted firmware-name in "Add ZAP shader support" (self)
- Pick up tags
- Link to v1: https://lore.kernel.org/r/20230926-topic-a643-v1-0-7af6937ac0a3@linaro.org

---
Konrad Dybcio (4):
      arm64: dts: qcom: sc7280: Add ZAP shader support
      arm64: dts: qcom: sc7280: Fix up GPU SIDs
      arm64: dts: qcom: sc7280: Mark Adreno SMMU as DMA coherent
      arm64: dts: qcom: sc7280: Add 0xac Adreno speed bin

 arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi |  2 ++
 arch/arm64/boot/dts/qcom/sc7280.dtsi               | 25 ++++++++++++++++------
 2 files changed, 20 insertions(+), 7 deletions(-)
---
base-commit: 5a82d69d48c82e89aef44483d2a129f869f3506a
change-id: 20230926-topic-a643-a7ec9a08a3a1

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

