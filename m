Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83877F8B4C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 15:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbjKYORj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 09:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjKYORh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 09:17:37 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42DE12B
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 06:17:42 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9fffa4c4f43so392241466b.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 06:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700921861; x=1701526661; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OPB29h8XgdVf8/Mj7J0oGuHQzVyt4cdj+mVXkBfm3j0=;
        b=gOKU8rtcPGTcm8iHKJmZ6+UTFyrVK5qxM9NZWxfCCG2iyXYvULv7LAuMFTonmBoG1+
         gAK8pwoJZ649bRMrOwwScVIWHwcDupah7phZnfZONgIstetal7dulChbemPcrUMWqGOy
         qoq8wb9l0N+KPVfp/x2jJsiFQuNQektPB92ZUiru0lZBUKarhUQJf6atqYUrI2Gq3zdt
         YYTDFdaaewllZY/CNADPel7rULRCZ/7R0Y++nvOkyFZtXfZByTlSJc4ipf70+eia9Kr7
         UmUUPLHBvkKrtqoiUrABgs5+6oDSll85emPBAHQI7EtKdkodwrknNZs969zbr35YQ2Sl
         eAVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700921861; x=1701526661;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OPB29h8XgdVf8/Mj7J0oGuHQzVyt4cdj+mVXkBfm3j0=;
        b=diTuR+DIu2dXgSWnGb3fC/qWVP2gQdWuFw+GDHujdfXWTjBvNuzLBH07pbo27SfF/0
         00DW2dakvu92PXEd9vflHKd1+vu9AHiObLTdH3ALGnNDn4jzV09wRnONiC/P6QDvqBfg
         Yiq8hHw7uiafwNu/QehQQdcVpXOx9yQQ3TwI8RYBiiieAFrMQ9FlNpmc/whZi2FwPsQS
         HgM5frq0RW/4Ysqb3umcLSKGF0DpiFsetXHd2vg93MKTJE7q1STVwnPPSnuErqpe1beK
         XH0TdIvy8NLZhqYevvH5fFgF5+Sow4U+PSUGVa37UCzdWSrGpCTiRhAscvS0RQR/LzBH
         bEpA==
X-Gm-Message-State: AOJu0Yw1lB4hE1okfX5WB7hBo/ahXfLeMRjes4ZbbblM/lw5KP2Ka/Vn
        +/pBtiOZdC6OeNSE/445q/JIwA==
X-Google-Smtp-Source: AGHT+IFshDaGZpoZ0UPNN73yo2NyaQpJ6p9P/hDNUi+51RGYJObtCtzb4JKAHb0PVhKI46jF5+kwvQ==
X-Received: by 2002:a17:907:2da9:b0:9fe:38b7:4278 with SMTP id gt41-20020a1709072da900b009fe38b74278mr5932250ejc.16.1700921861162;
        Sat, 25 Nov 2023 06:17:41 -0800 (PST)
Received: from [10.167.154.1] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id 19-20020a170906319300b00992b8d56f3asm3500345ejy.105.2023.11.25.06.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 06:17:40 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 00/12] RB1/QCM2290 features
Date:   Sat, 25 Nov 2023 15:17:28 +0100
Message-Id: <20231125-topic-rb1_feat-v1-0-11d71b12b058@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPgBYmUC/x2NywqDQAwAf0VybsBEtof+SillH7EGZJWsLQXx3
 w0eZ2CYHZqYSoNHt4PJT5su1YFuHeQp1o+gFmfgngciDrgtq2a0RO9R4oalBOrDwHemBB6l2AS
 TxZonz+p3nl2uJqP+r8vzdRwnnFqtGnUAAAA=
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700921858; l=1962;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=qqo1HkU087mhGcmOMVz6Ckg9V4Z4NTeii2LcjxJBNPM=;
 b=o1M6AdcRS2Gq88RD4ObPcOl1SXOsPSOZLeS6wO63F2KLCgkoaV13h/mDN9e0icg6ZaSnsLQtx
 31OcGhoRmcSBrN5eyR4Y9Mh5bTUkFIRHMYG7GFIXZPhZa5DwwDHyDfD
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series brings:
- interconnect plumbing
- display setup

for QCM2290/QRB2210 and

- CAN bus controller
- HDMI display
- wifi fw variant name

for QTI RB1

and the necessary bindings changes

Patch 1-4 is for Dmitry/freedreno
Patch 5 for Georgi/icc
Patch 7 for Will/iommu
the rest are for Bjorn/qcom

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Dmitry Baryshkov (1):
      arm64: dts: qcom: qrb2210-rb1: add wifi variant property

Konrad Dybcio (11):
      dt-bindings: display: msm: qcm2290-mdss: Use the non-deprecated DSI compat
      dt-bindings: display: msm: Add reg bus and rotator interconnects
      dt-bindings: display: msm: qcm2290-mdss: Allow 2 interconnects
      dt-bindings: display: msm: sm8450-mdss: Allow 3 interconnects
      dt-bindings: interconnect: qcom,msm8998-bwmon: Add QCM2290 bwmon instance
      dt-bindings: firmware: qcom,scm: Allow interconnect for everyone
      iommu/arm-smmu-qcom: Add QCM2290 DPU compatible
      arm64: dts: qcom: qcm2290: Add display nodes
      arm64: dts: qcom: qcm2290: Hook up interconnects
      arm64: dts: qcom: qrb2210-rb1: Set up HDMI
      arm64: dts: qcom: qrb2210-rb1: Enable CAN bus controller

 .../bindings/display/msm/mdss-common.yaml          |  18 +-
 .../bindings/display/msm/qcom,qcm2290-mdss.yaml    |   8 +-
 .../bindings/display/msm/qcom,sm8450-mdss.yaml     |   4 +-
 .../devicetree/bindings/firmware/qcom,scm.yaml     |  15 -
 .../bindings/interconnect/qcom,msm8998-bwmon.yaml  |   1 +
 arch/arm64/boot/dts/qcom/qcm2290.dtsi              | 462 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts           | 109 +++++
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |   1 +
 8 files changed, 594 insertions(+), 24 deletions(-)
---
base-commit: 8c9660f6515396aba78d1168d2e17951d653ebf2
change-id: 20231125-topic-rb1_feat-dd510532621b

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

