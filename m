Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE137FA61A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbjK0QUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbjK0QUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:20:07 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BB0DE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 08:20:12 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50baa3e5c00so2866302e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 08:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701102010; x=1701706810; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o7VqPtYpwoj+TW7Y8BWDK43UozTyH/qVC7KhQCmuFRM=;
        b=Mky51Kq8MRdApT6aAUPok70hZRlAm3e9oKN1Gr2h9qM1EiVQhyUQF0wKjt0L4l3qfI
         9MA+G83hqcUW1H6BEvqTzVHUxcnfcCYLL+jwEzzAyb1PZfooI77sBnwrUW904VQvnyFt
         z+4wTVk+vKXxCZiEvLwHilXIl21j9IlRp6GbmLptFQ/H0lPqn8sWmLMbWoU4ALUrjz0v
         EcbmqsYPSq9zAMbeXEEq7Eia5F3zmdt3wwemaT1mL80kv3cY4WDMeZl9GZ8eenTgDenu
         1bCEL/CHmoWbL+Afgsi2onVxjUx8JuCqp0o/wmRNNPL8dmbeL0CxHaaOTGOlWF0DQrLx
         q5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701102010; x=1701706810;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o7VqPtYpwoj+TW7Y8BWDK43UozTyH/qVC7KhQCmuFRM=;
        b=uem+nJCUMLsgjw+431Wx7ZTz1I0Ncmj0HyajmaEozOIwebuu3OOm69kAK2PgXzSg+5
         zsnqK42BjpuqnNrpB/9ACxLmVVHoMayzRL3XcMI5dgLmgH8vN69TGlomXXkpbWoXpNoJ
         sNiKmLg0TlSWdToXJp4zcSev8dAz45X/26i0OCLi22ZzbB68apMFcGl6hXprT9rNs4X7
         IpzjHod/ZYAmMG6sBZI/agLC0294TDZFECCc7MadX3IStYSj58xh0h3Y33Cy4KK/zSa8
         wU1DjfQv2/ZhCwahdnMEaAw/P1QbXdJhMCAWYLLVSPfS4pLeAqbKmUPdLwi+Wcw5gl7y
         8M8g==
X-Gm-Message-State: AOJu0YziljkRtI88Z0KzLua0AO5nhLdj9FlyOA5gb9iJq42YkqtWJm6A
        XG9zZahy+RvfaseKo9E4vLzZ3CLLjUo3nc1axYQ=
X-Google-Smtp-Source: AGHT+IHmgRxGBQwnhbTyFCMdrlJjPEqWPP9SdrVlRVuS7yeIr7kA+AYZlSRHNy1rJX25Nv8IL8B7dg==
X-Received: by 2002:a05:6512:3196:b0:50b:aa13:a761 with SMTP id i22-20020a056512319600b0050baa13a761mr5779827lfe.46.1701102010662;
        Mon, 27 Nov 2023 08:20:10 -0800 (PST)
Received: from [10.167.154.1] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id m12-20020a1709062acc00b009c3828fec06sm5734760eje.81.2023.11.27.08.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 08:20:10 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/6] SM8450 / SM8550 Adreno
Date:   Mon, 27 Nov 2023 17:20:02 +0100
Message-Id: <20231127-topic-a7xx_dt-v1-0-a228b8122ebf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALLBZGUC/x2NUQqDMBAFryL77UKTCoJXKaWsyVMXJEqiJSDev
 Us/Z2CYiwqyotDQXJTx1aJbMnBtQ2GRNIM1GpN/+Kdzvudj2zWw9LV+4sETgM51HjEKWTNKAY9
 ZUlisSue6mtwzJq3/yet93z/OMxPedAAAAA==
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701102008; l=1189;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=/aCt/tpWduoy987CggdzKos+vz6oIxXcKvTXjXKLxJ8=;
 b=/fFdW2I4PegFvbTzHnoeeKoejhyDoNRfMyRHqa4iYNbe/GxP/qCjLCCo4xiLaXyEVTacKmf9c
 nJik6l90SFTAynj16yrttBu/TokmhuJ4L2xau17nJBJgUOOGLFeHYzE
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

Following the merging of related bindings, driver and mesa changes, enable
the GPU on both of these platforms.

P1 for Will/iommu, rest for qcom

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (6):
      dt-bindings: arm-smmu: Document SM8[45]50 GPU SMMU
      arm64: dts: qcom: sm8450: Add GPU nodes
      arm64: dts: qcom: sm8550: Add GPU nodes
      arm64: dts: qcom: sm8550-qrd: Enable the A740 GPU
      arm64: dts: qcom: sm8550-mtp: Enable the A740 GPU
      arm64: dts: qcom: sm8450-hdk: Enable the A730 GPU

 .../devicetree/bindings/iommu/arm,smmu.yaml        |  48 ++++-
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts            |   8 +
 arch/arm64/boot/dts/qcom/sm8450.dtsi               | 202 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts            |   8 +
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts            |   8 +
 arch/arm64/boot/dts/qcom/sm8550.dtsi               | 166 +++++++++++++++++
 6 files changed, 438 insertions(+), 2 deletions(-)
---
base-commit: 48bbaf8b793e0770798519f8ee1ea2908ff0943a
change-id: 20231127-topic-a7xx_dt-feee4142edda

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

