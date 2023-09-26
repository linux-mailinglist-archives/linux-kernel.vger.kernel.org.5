Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2277AF2B5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 20:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235559AbjIZSZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 14:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235476AbjIZSZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 14:25:00 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEDB198
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 11:24:54 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50309daf971so15350916e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 11:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695752692; x=1696357492; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zKAfj40wX2rYb9qZjVM1hdFI0nJkjq0ie36nV/sob5U=;
        b=Qe5/b1ofC/vofZcK36EXk5QPOMtW/JBEzAXFbfK18E7QPeQhVx6Lv3zVD33NIHHbUN
         m8Ewh8+H3DVcMiaH6t+clsHujU0N13LCGiOWkCfKXwI4TgNnj1hjwehgpqyxa656S4YJ
         JQOAThU03SPlq4jZhNNMlLhxQJ1nR5EOG83SgtZkQ0M8WigsqXEKSHFuOQXTdGCP5q1b
         3bLxl8jBeO9emX0pl99wN0/Rjo7Po8ChLzLh+jK5m/yTUerVOFzjwe7dMtfIbbSuabFV
         77fe7FXJd91lCBVedDNRwyUjUn5QyQgvTj6AR7DCKAYb0FWxb9MMBFrJKKPMjQZG0V3T
         Qi2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695752692; x=1696357492;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKAfj40wX2rYb9qZjVM1hdFI0nJkjq0ie36nV/sob5U=;
        b=n2HA3ht8HkeCSbC0+hj6N0dx+XUt0GMKXUCKO6g55IXfPCgAPX9nB+jG0924qaJI4m
         OfItCrty8W3791EKC271QjQRGZprJuD5hsX2LIvuHGqR3dvEkgMTSi7H/JOB1TliA9Zt
         rtZoaYpY3MyoUfrNPaVVow9iO4NLuVqejrV+O3VdYdVwmKw5QfpX3Jr6aLMxPVyTfU98
         NS4RLCvbUEQSfu5XwuO/jcQqfNAtvoqRIGgzOChQqr5UugaZUGo0QPbSHkWamdMS5D/j
         CxF/EKie4VvmxU6veMr4wpGkawP+jefFCbFelKT3pO9EQu9giOc5OndtgayZJ76oAgu+
         vMvw==
X-Gm-Message-State: AOJu0YwNqT0Tw7QbExVJuEQceE6A0hKTK8s7U1TDvASrJcFJEj6cmXLw
        z3Fp/5Eydn0F5cAltyCHZKP/2Q==
X-Google-Smtp-Source: AGHT+IFEOjsJYPfc1unWH5iDo2ktLsd6gTLh2AKJS4VABLvGaC7NWjan6T+Fe2gwP9NdJvAjyY+giw==
X-Received: by 2002:a05:6512:318d:b0:4fd:f84f:83c1 with SMTP id i13-20020a056512318d00b004fdf84f83c1mr10394815lfe.64.1695752692402;
        Tue, 26 Sep 2023 11:24:52 -0700 (PDT)
Received: from [10.167.154.1] (178235177023.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.23])
        by smtp.gmail.com with ESMTPSA id f19-20020a056402151300b0053090e2afafsm7020643edw.22.2023.09.26.11.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 11:24:52 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 26 Sep 2023 20:24:41 +0200
Subject: [PATCH 6/7] arm64: dts: qcom: sc7280: Mark Adreno SMMU as DMA
 coherent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230926-topic-a643-v1-6-7af6937ac0a3@linaro.org>
References: <20230926-topic-a643-v1-0-7af6937ac0a3@linaro.org>
In-Reply-To: <20230926-topic-a643-v1-0-7af6937ac0a3@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695752677; l=676;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Hpz3dGOzkgvsLU7CVLEOv6AKepEoumYODOZQCFrh/Q4=;
 b=j5r+TqjW4AL2kSlLuLWqK7jEIUZkSCZmLEB7jrljedUKqzufTLJ82XEyKjXd1g+Xdn85ktzDP
 aNUnRkQeTI7Aooar0OseWXWM8mz1d5aWQL5knIH/Qmhu93CpmvmbPvp
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

The SMMUs on sc7280 are cache-coherent. APPS_SMMU is marked as such,
mark the GPU one as well.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 0d96d1454c49..edaca6c2cf8c 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2783,6 +2783,7 @@ adreno_smmu: iommu@3da0000 {
 					"gpu_cc_hub_aon_clk";
 
 			power-domains = <&gpucc GPU_CC_CX_GDSC>;
+			dma-coherent;
 		};
 
 		remoteproc_mpss: remoteproc@4080000 {

-- 
2.42.0

