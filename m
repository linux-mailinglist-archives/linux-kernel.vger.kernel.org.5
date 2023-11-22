Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AD67F47FB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 14:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343901AbjKVNm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 08:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235103AbjKVNm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 08:42:27 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47743D50
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 05:42:20 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9fd0059a967so169449866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 05:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700660539; x=1701265339; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8fdn6CPD0LA3swDmQEp9eVXBCvDauP/1IlEvd50qAFY=;
        b=b8uEAIlMdTBB6fVXRRefzdUdEC+ESLJ34KqRdDx0eZ/pKKlo0StN5UdfFE/DIoFAxB
         zYis/CVNUEzxsaZ62CAytC8CTPOzgmhc1HPpRdTCCkhk/WGM37ltD2hLRZz7H2gMJvXL
         OPdqnI346Irm5OSnlfEKRckd1T0YiAczhlEPcIvwiCY/0hJp/swzG4DdQ6R/wxxY26Vi
         992O4uUp1jh8yGwX/SwcwD0OoA6NV/R3NmWZ3AD7+6BUgdLEJUldI8HqcJifU9bf5f8b
         HArFNWuzLhP4FFeXku1S0EY8FcaZjJ3SVMrp4iRUTEyi0Cr+Bwf58xFYfaardFwuNEHg
         7KBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700660539; x=1701265339;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8fdn6CPD0LA3swDmQEp9eVXBCvDauP/1IlEvd50qAFY=;
        b=qNuyAEMZs4F2uYBZ/P3qd4zWX2NICI2SIiMgtt470lNA2QRMF236IpMj+R53t+Q6KH
         0d+lG2vutVNSz/Ok5gGmf1grtnZ2OCPMtiLWHUswjOe2K6TDW2YOKXxUncDnPMy6dX9R
         p9BHseUGsh3bhR6zovlrih0RUyZ90zD2B7E3av6LazRACVpY14XDJKe118nttxCeRgFb
         spwVrm/jNncxGvKqcfq9M/lEMQnrt5FzwjsUIuilQpVbn4WTNoeGtcSqnbKVUn9jSrZv
         D9iLNb2Q262G/JvV3Xh1AzhVBC4atQO7OIexdl5375q8SmQBkE2tk2Wo3kT42YWVABUx
         PRoQ==
X-Gm-Message-State: AOJu0YyqJdWPoT8JF0iwBGREmstFLleNDQFVAWVHSPiXNKZKZdiOZYX8
        34A9wp6p7E5QWkJbtQzJXX6dRA==
X-Google-Smtp-Source: AGHT+IH/s3X/fn5j+aKFt/t/P56qouWZFUbacwaPrkXlao2VGK7sVg5Lr/4rxdaa+R/XOOHMJJyD/Q==
X-Received: by 2002:a17:906:d152:b0:a01:d701:2f1d with SMTP id br18-20020a170906d15200b00a01d7012f1dmr1696001ejb.14.1700660538742;
        Wed, 22 Nov 2023 05:42:18 -0800 (PST)
Received: from [127.0.1.1] ([86.123.99.122])
        by smtp.gmail.com with ESMTPSA id a1-20020a170906190100b009a19701e7b5sm6676797eje.96.2023.11.22.05.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 05:42:18 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH 0/2] clk: qcom: Add TCSR clock controller support for
 X1E80100
Date:   Wed, 22 Nov 2023 15:42:11 +0200
Message-Id: <20231122-x1e80100-clk-tcsrcc-v1-0-43078c6d6452@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADQFXmUC/x2N2wrCMAxAf2Xk2UBSB15+RXxos9QFS5V0ymDs3
 y0+ngOHs0FTN21wHTZw/VqzV+3AhwFkjvWhaFNnCBSOzCHgynomJkIpT1ykuQjmMaUTZeaLBOh
 lik0xeawy97Z+Suny7Zpt/a9u933/AWXhSGF6AAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=863; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=dL3+krPTgLJmS3n9AGxxmwpSLou+Rw2ZG0JZlwn4lSo=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlXgU119ErV5hpFTqR5JzG0OQYYflfEg/Am96Ru
 oibQ4en6ESJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZV4FNQAKCRAbX0TJAJUV
 VoVUD/9r6YJy685+ZQPZJtQdn5G4kshAGAtgy+pyeoIKoNVTKgbanGxxum60TEWYOy0Dcq99cE5
 q7GWPImAFgKW4H23AqP3j6Jl8aN2eQot0zQgyNtDoNfbW9g8iF7amK/yIyRrbZpEAcHOobcQmOM
 KkDZGjzU4HKqBOxxsocWcctbn3uXHQsn/NcHvKH0P3Pw+ZUMNkzFw1UlxWkFEkT9fR9E2quQOCr
 bBT0esfuGglRpz3a3aAIx2NTLGRJcdps77gmnpcDzkA9kivs3ht82Aj93EgNu4p0OiDGxBQGcnP
 prXv/V5o/spgSzICLepwHFNmYdKH0i/PacvUHYJ7RKvItdBSQhSwkJb9bw1mrAz5+Ox/y+JrbKg
 6xEr3usr3b2WAaKFYRG7vlVqRXHZ6QYL3Ubj86aAO+zd2W2sR8GLgf7hWQnuCXtJbzepRspFUIL
 QiataS3kdG0ci2X9SVH/8NY2B4RjqVAbcT3I+dZIV1VgVDaIffLPSIstgyWQ8sAAN9sFUJSmL1z
 vwC3598nZQUjLbfMR35G5eU2TIA3h74icXctu5pyaoqIoX00eLPhO9gWJ8+RdteOhugFF4xX7W+
 5FpJv6cgQ19UDUXzlOC07PDPtqTHeRZ9Or5xMuCJd6F58Cxrh3bwCrDQp4Id2ERZdZ8Gn0EQoEO
 BfCWjFF3lz4NJLQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for the TCSR clock controller for the new
Qualcomm X1E80100 platform along with the bindings.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Abel Vesa (2):
      dt-bindings: clock: qcom: Document the X1E80100 TCSR Clock Controller
      clk: qcom: Add TCSR clock driver for x1e80100

 .../bindings/clock/qcom,x1e80100-tcsr.yaml         |  55 ++++
 drivers/clk/qcom/Kconfig                           |   8 +
 drivers/clk/qcom/Makefile                          |   1 +
 drivers/clk/qcom/tcsrcc-x1e80100.c                 | 295 +++++++++++++++++++++
 include/dt-bindings/clock/qcom,x1e80100-tcsr.h     |  23 ++
 5 files changed, 382 insertions(+)
---
base-commit: 07b677953b9dca02928be323e2db853511305fa9
change-id: 20231122-x1e80100-clk-tcsrcc-f4bb70f119c2

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>

