Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79197788E4D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 20:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjHYSOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 14:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbjHYSN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 14:13:57 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF2F2702
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 11:13:20 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4ff9b389677so1795465e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 11:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692987197; x=1693591997;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QHxt8L509EiDrZI2+w6ifk3vGfhc6nbxSWQw2eBwLSE=;
        b=v6kP1VAHwC+TwCN7cSb5AETiYe3E/uBxZxnC5xUfq03Ewe/BiYJpv0iTgdF9yuqhg1
         LNfMZpL6xnl0aYHyRe0Mhv2O3QI/RhRTuBgACQ0kebhZ57M6mgov2ZEufuE2RxbBE5Uo
         q++mwkQFjFyrPdAQmHwvDcVSI6308PVvV+iEXPJ5w7D+AyGcxDavUdFZgFjjwFp+iZPe
         rVD3roxlrGH6jpdWgls+SLtz8s6dhaY5qLGJ7UUzZzDJEba7EGA8DEhHURhe6lC7HLy9
         QrxNo6BK2U2tkuMdNHhBI1Oqvj19Yw0Vcpj2/z/IKEqq6zuYkvLJonjSLpF1G4zyFa+M
         yHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692987197; x=1693591997;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QHxt8L509EiDrZI2+w6ifk3vGfhc6nbxSWQw2eBwLSE=;
        b=YATmetMv1JzPfwkhTnCVCbHnYfmuQ112E0C4dtpR2AcGIhxxtN5SXRBks5XoZN3VUZ
         Y424qBxqeeOmuQ/3NpKGrC314dKJsJpwWas8N5H9sArpqtIeDk6/8rO9V64OAhLN+aeT
         wg/v8ZL4Jx4dj7/somFAUcPaay/sdIjFTpRmfxtDKzVvleeOVGdWCoV+r7F+bQbzPZX4
         p8ggxtP8tGLEGEXn7UTqPiQQGG2yNWEIS9/+/Ixm5yNIFJzIpDgXY4hIYQEqj0B9E5NC
         wWXal7vi70gyCSQEn9rSmkUUBYT70g/zri5Rm6OHgIbRcEiKSrmccJs32KUL+7aRCP3O
         l2Gg==
X-Gm-Message-State: AOJu0YzbLbPWMKvQWQlzCqYePo0TL3Xl6VSi2ZfLl3w9mhLJEHmUoRvH
        3s/iys+CckItf5qs7PILLw2Rqw==
X-Google-Smtp-Source: AGHT+IGYIanJ0Av2PWQRCoRxlcYDQT3sFvmZYoytEvvdIWf55/QpB+RK1uMhO4PDPMWO2zp3hHzyjw==
X-Received: by 2002:a05:6512:3196:b0:4f8:5d2f:902a with SMTP id i22-20020a056512319600b004f85d2f902amr17825503lfe.60.1692987196734;
        Fri, 25 Aug 2023 11:13:16 -0700 (PDT)
Received: from [192.168.1.101] (abxh59.neoplus.adsl.tpnet.pl. [83.9.1.59])
        by smtp.gmail.com with ESMTPSA id b2-20020ac247e2000000b005009920b6afsm374522lfp.9.2023.08.25.11.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 11:13:16 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/3] SM6115 LPASSCC
Date:   Fri, 25 Aug 2023 20:13:14 +0200
Message-Id: <20230825-topic-6115_lpasscc-v1-0-d4857be298e3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADrv6GQC/x2N7QrCMAwAX2Xkt4W2s369yhDJsswFSlcaFWHs3
 Q3+vIPjNlBuwgq3boPGH1FZi0E4dEALlic7mYwh+tj7S0zutVYhdwohPXJFVSLnIx7ndL72SBN
 YOKKyGxsWWiwt75xN1sazfP+n4b7vPyi1yGR5AAAA
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692987195; l=1043;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=tTslou3f/YiJFwL09fCXA3PM8wqi/JiyF8jZ/rp7K00=;
 b=CyNYNdZ7r/q0tRNcOBdQFXmthrVN5sfAGjy1i46wAsIVhsD6p0UFKBJ7jdHbNwdY/ri1/nTJU
 8xQK1EH+Im6BkfOt6jUghGzteT8qAmgAA9a9sh15BVXok2Uhv2tYn6W
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series brings support for the LPASS clock controllers on the SM6115
and similar. It provides resets that need to be toggled as part of
soundwire bringup routines.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (3):
      dt-bindings: clock: Add Qualcomm SM6115 LPASS clock controller
      clk: qcom: reset: Increase max reset delay
      clk: qcom: Add SM6115 LPASSCC

 .../bindings/clock/qcom,sm6115-lpasscc.yaml        | 53 ++++++++++++++
 drivers/clk/qcom/Kconfig                           |  9 +++
 drivers/clk/qcom/Makefile                          |  1 +
 drivers/clk/qcom/lpasscc-sm6115.c                  | 84 ++++++++++++++++++++++
 drivers/clk/qcom/reset.h                           |  2 +-
 include/dt-bindings/clock/qcom,sm6115-lpasscc.h    | 15 ++++
 6 files changed, 163 insertions(+), 1 deletion(-)
---
base-commit: 6269320850097903b30be8f07a5c61d9f7592393
change-id: 20230825-topic-6115_lpasscc-02a4f5793acd

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

