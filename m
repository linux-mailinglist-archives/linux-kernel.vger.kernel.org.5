Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BF27AC2EA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 17:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbjIWPBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 11:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbjIWPA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 11:00:59 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582B1192
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 08:00:52 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4053cf48670so24416765e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 08:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695481251; x=1696086051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXU3ZtkSCJEfdFlxior15J5UEVDRM/lyGkU63khmY2M=;
        b=cwOX209SRvx7wMQjkBXxcedQ3YViGVIV2tMZlEVl6tVnwPb4hGiZQEnuUTVPUqDT7S
         E7mFpa71Ju78XfeGbr6ncCfnOgDUcUOEK4uh1sRKHUaNGekpsAba42nHwJOJlGlg3BTi
         FGUlrs6ICcc4bybdbSajcF3fQfJ/3QUTXxKIZkXzb27E47BbZlMY7Unpcl2Lo9elSMcj
         WkZxyoQT6xLr1yTC6DLAELHIMAIOxpSDnvnKRcK1q4XX6ArfTIBAYnj3RJKdDTnOtSdz
         ChwLFzfuXEzAi+CRlkILE9oLeorRlM0ApcHjwZNVPxXrF/LW042c982a8ocJuK+hb/lk
         8TWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695481251; x=1696086051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZXU3ZtkSCJEfdFlxior15J5UEVDRM/lyGkU63khmY2M=;
        b=aYAp2wNaK9PGCq+DMp46ngH4OOg5mSzDjw/MInc/xz8EhNXhZ3CuCA+l3AVo7wcfMr
         1qvSIJPPq8BB3C3FE2Lg91pDELhH1GIuvebbDP5N9mIfRsYymP76GsJieV8oQ8nIYK/k
         qTKPjeX3Nz/8fnfcIuljg0GJ2qXvJTcrGE3yt6+juYvC7YEDnKhOBGl9f9AKdLejBC3R
         CTPZculk1DLUELFGzoSnISEx7QpHPUUOLvLdG9aboiAqawLCKf75GXUNlauDxaoZoUHo
         CkXjnqk0a1iyXjOnYfAikxKFBbWseq4ycsrN71ZDSxyRC7HQoDz4fKDPkopqqAe2N/hY
         GGrw==
X-Gm-Message-State: AOJu0YzeHWNUJUx3h2LfJggTGPUCWU7XFGj8EqfJieociP1YRb+G4NYp
        39+DtIK3WbdEAO3OqPkhv/hJwg==
X-Google-Smtp-Source: AGHT+IHuzA4h02YX/vLmQKFS+jq1vPMxPRDUty950JyqIetGXlncOs9lod1Axd/xOLyY+4muR/Ldhg==
X-Received: by 2002:a05:600c:2187:b0:3fe:5053:1a0b with SMTP id e7-20020a05600c218700b003fe50531a0bmr1752925wme.11.1695481250639;
        Sat, 23 Sep 2023 08:00:50 -0700 (PDT)
Received: from x13s-linux.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id m28-20020a05600c3b1c00b004053a2138bfsm5787006wms.12.2023.09.23.08.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 08:00:50 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jonathan@marek.ca, quic_tdas@quicinc.com,
        vladimir.zapolskiy@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bryan.odonoghue@linaro.org
Subject: [PATCH 0/4] Add sc8280xp CAMCC bindings and driver
Date:   Sat, 23 Sep 2023 16:00:41 +0100
Message-Id: <20230923150045.1068556-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a bog-standard series to add in the CAMCC for 8280xp.
As a precursor to adding in sc8280xp I thought a bit of tidy up on the
existing yaml for the camcc controllers in general would be worthwhile.

As a result there's a precursor patch which aggregates the various camcc
yaml files into one location.

The sc8280xp looks like sdm845 with more blocks. Similar to sc8280xp we
park GDSC to CXO. Thanks to Dmitry for the suggestion the GDSC parking.

Link: https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/linux-next-23-09-23-sc8280xp-camcc

Bryan O'Donoghue (4):
  dt-bindings: clock: qcom,camcc.yaml: Convert qcom,camcc to a single
    yaml file
  dt-bindings: clock: qcom,camcc.yaml: Add sc8280xp CAMCC compatible
  clk: qcom: camcc-sc8280xp: Add sc8280xp CAMCC
  arm64: boot: dts: qcom: sc8280xp: Add in CAMCC for sc8280xp

 .../bindings/clock/qcom,camcc-sm8250.yaml     |   84 -
 .../devicetree/bindings/clock/qcom,camcc.yaml |  173 +
 .../bindings/clock/qcom,sc7180-camcc.yaml     |   72 -
 .../bindings/clock/qcom,sc7280-camcc.yaml     |   71 -
 .../bindings/clock/qcom,sdm845-camcc.yaml     |   65 -
 .../bindings/clock/qcom,sm6350-camcc.yaml     |   49 -
 .../bindings/clock/qcom,sm8450-camcc.yaml     |   85 -
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        |   15 +
 drivers/clk/qcom/Kconfig                      |    9 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/camcc-sc8280xp.c             | 3051 +++++++++++++++++
 .../dt-bindings/clock/qcom,camcc-sc8280xp.h   |  179 +
 12 files changed, 3428 insertions(+), 426 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,camcc-sm8250.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,camcc.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,sc7180-camcc.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,sc7280-camcc.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,sdm845-camcc.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,sm6350-camcc.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
 create mode 100644 drivers/clk/qcom/camcc-sc8280xp.c
 create mode 100644 include/dt-bindings/clock/qcom,camcc-sc8280xp.h

-- 
2.40.1

