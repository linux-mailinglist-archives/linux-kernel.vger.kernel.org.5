Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83976803378
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjLDMze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:55:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbjLDMzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:55:31 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBB2FF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:55:36 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a00c200782dso608872566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 04:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701694535; x=1702299335; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L2hsBw2f4zAGauIZbOvreuYSNpIWy0p3UiF+fZb/E10=;
        b=Euj0vyih7AVGjpIBXcmmNBvr/29gFIjKjVXLujlB9qUcwFmIyAJabmbuoZki29QxLu
         gOW1zr+K4bBXjYunWrsS8rSmKhE24hka26hklm0VCI3UvuVKAiyu4JlLJQ42j/tcNDn3
         IrTsKm6xTRqM8rsaooQ9lltrIHL8Xu4ucl5UIslz8tw3LRpTy+UqpI5myaojzHiG753U
         BalnrZM1ldVLuquNqvqcfSHpRHPkDm5Cb66dQGm2019rLmNacwjs0oxBsurkLpQDcp38
         pGu+uofvUrmiZFbjX+GeXSu1EDwpXcWaqCK5xOEeDZvGn6bBZa5Z48BD6qeLUYfrzevJ
         yF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701694535; x=1702299335;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L2hsBw2f4zAGauIZbOvreuYSNpIWy0p3UiF+fZb/E10=;
        b=DQddNfEbFpfI5isSBoaqmjIYQx6ihbvzUxMsZt5x6roK5n2HSxNl94pX2KapyZtrY5
         coaYlHifu8i53eb07Di9e6zVugcBImTfsgRFFMLTuhASaF4xamX3Iua/UKefYFgsUmOG
         yh5AJzDNVxFak5ao8mtiFGlrioOKk38P9bLLDMgYBTNBsAAqKPjvQWl2oUB9dGIoVDH5
         r5oI4l9j6BDWqOzPLqNnivWN+OYbFIXURDY98tG32Ybz1rxib8JehmoRIwdFrWnohTtc
         yNaf93LAG7lBn/cU6i5ObR9spO8X+FBOPt8j9zeZFM2PRmJdUv0Ia7lfyFJdNMdEE66M
         Yguw==
X-Gm-Message-State: AOJu0Yxe98l9yp98PsuwW0YSp+JrhFL3yDS4ffaTmggr5/fMpVS9h9lq
        aqfEhF+SZaauCHezlSj1R39nQg==
X-Google-Smtp-Source: AGHT+IGrvcribSjcrW0uB3jSUhS+pnkpk+Fcqij3kL8dj7I1z74eqTqBVKOeNtEWtKSkDbuBhrI2dA==
X-Received: by 2002:a17:906:6015:b0:a19:d40a:d22a with SMTP id o21-20020a170906601500b00a19d40ad22amr1483993ejj.246.1701694535368;
        Mon, 04 Dec 2023 04:55:35 -0800 (PST)
Received: from [10.167.154.1] (178235179097.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.97])
        by smtp.gmail.com with ESMTPSA id ay22-20020a170906d29600b009efe6fdf615sm5241373ejb.150.2023.12.04.04.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 04:55:34 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2 0/6] SM8450 / SM8550 Adreno
Date:   Mon, 04 Dec 2023 13:55:19 +0100
Message-Id: <20231127-topic-a7xx_dt-v2-0-2a437588e563@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADfMbWUC/3WNQQqDMBBFryKz7hQzFZSueo8iJTGjDkgiEysW8
 e5N3Xf5Hvz/dkiswgnuxQ7KqySJIQNdCuhGGwZG8ZmBSroZQzUucZYObb1tL79gz8yVqYi9t5A
 3ziZGpzZ0Y16F9zRlOSv3sp2RZ5t5lLRE/ZzN1fzsv/vVYImWqHGNIWLXPyYJVuM16gDtcRxf+
 JmW98AAAAA=
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
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701694533; l=1382;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=G2AGr7+EfmpDgrZgtA9axRHuip8IvIHibzVfFKlzR2Q=;
 b=8v7uPUgPccph1d0xbsOc11lWkToE8gvXhqB3LqrVRQCp0HSjVz9i/VveJmoux/2n5cxHGrMMs
 s5uly2frnAaAdtE8+UBQUA3JLO5N7k9Skk9Fs2qW0LJ6mO+dcvZkAu4
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
Changes in v2:
- Sort nodes better in 8550dtsi
- Fix the 8550 GPU chip ID
- Pick up tags
- Link to v1: https://lore.kernel.org/r/20231127-topic-a7xx_dt-v1-0-a228b8122ebf@linaro.org

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
base-commit: 629a3b49f3f957e975253c54846090b8d5ed2e9b
change-id: 20231127-topic-a7xx_dt-feee4142edda

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

