Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03BF7B84CD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243288AbjJDQTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbjJDQTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:19:02 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112B0C4
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 09:18:58 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32483535e51so52529f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 09:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696436336; x=1697041136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uuhFTaij8CkxaSGCgau6p1wn4p1PnkPS9KDREkl6rjc=;
        b=ZayGJP+ZhmEiA3zNvK+8+ghjkd6PvkF3uHCimw6y8ryhAV3fnokNQGvbWRJc8633n9
         FBIrRPlfplC3tsjoH87sWBDnwSNW6SzCqH5WikRKJVsPkvRY1GGzeZz+5G53Z9Hf2hRX
         ctI8BiBmoaoHlcaBPler3iDy8H4v7sbIZBMbkD3ayhZyJLUawFDlo1UP0CJI6CockDT+
         jFreGaypcgHJD2AvbNpcy9kdrOZEXp9ldcleI5//9J4apXWYB6pogrfvLuDF1nfeNcbM
         W100JsbOQ5Yp6OtLb4J1QdnVqbVQoNRx8puc6cy8h+X3nlK6jAZLtvE1MJAQsuWKWXqZ
         IFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696436336; x=1697041136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uuhFTaij8CkxaSGCgau6p1wn4p1PnkPS9KDREkl6rjc=;
        b=aPpTvXGP/JlHfprYL/65t0Kcyj90nmTAE67VVx5rqiKwOC1bPCV9X8XiORm2rhSsWi
         TsxC5y/RJJRSijzk4eV1/JV2cJPeA4Rii9xvQGes//c2phcykecaItc1xR7jNbbhLJCW
         TU/mtpVAxcec3egUWJTp3yhzlo+pc/4XMlSSIMV6hpJ+5wU59+3MwstHpadzQYlWqH9S
         WTWiaz4UBnyZVUMNmCEjAWYklcaPwSpXbRhB0PVwg9qnt1c/ba8vlP+JcyQuMlSf+GP2
         E79wD6BaTFofagkFvMfZmDtK9r++xAAn1+5COcxHWy2nbq04Zb72iXosLT/VbwNWsYOb
         zwFw==
X-Gm-Message-State: AOJu0YwWKfB4DoRpSaPAGeZXr4Rf96n/gdniEbi0/WkAifObCJruF5pW
        a/dnGw1vqroqv7Y/dk40bqxWgw==
X-Google-Smtp-Source: AGHT+IFpplTkgGRp8rnQ4WsOfy9Dx9PpGwm+77I2uJ5Zk67hlVkVh4dJWT4ntcpviQe7xU/SEXHitA==
X-Received: by 2002:a5d:45c9:0:b0:323:1f49:de96 with SMTP id b9-20020a5d45c9000000b003231f49de96mr2419310wrs.49.1696436336364;
        Wed, 04 Oct 2023 09:18:56 -0700 (PDT)
Received: from x13s-linux.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id r5-20020adfe685000000b003177074f830sm4366940wrm.59.2023.10.04.09.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 09:18:55 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        dmitry.baryshkov@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jonathan@marek.ca, quic_tdas@quicinc.com,
        vladimir.zapolskiy@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bryan.odonoghue@linaro.org
Subject: [PATCH v3 0/4] Add sc8280xp CAMCC bindings and driver
Date:   Wed,  4 Oct 2023 17:18:49 +0100
Message-Id: <20231004161853.86382-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch depends-on:
https://lore.kernel.org/linux-arm-msm/20230923112105.18102-4-quic_luoj@quicinc.com

V3:
- Resolves CLK_CRITICAL camcc_gdsc_clk by making camcc_gdsc_clk
  always-on and dropping the CLK_CRITICAL flag.
  We want camcc_gdsc_clk for retention, however CLK_CRITICAL is not
  compatible with pm_runtime suspend and power collapse. - Konrad, Bod

- Uses gcc.yaml instead of camcc-common.yaml - Krzysztof

- Drops fix for 8550, TBH I didn't know use for socname-ip.yaml
  with compat strings for different drivers was OK, so long as the
  content of the yaml was compliant for both. - Krzysztof

- Drops clock-names, adds RB as indicated - Konrad

- Reworks "really_probe" to account for patch from Lou Jie which
  is RB from Stephen Boyd but not in any -next tree I can point to right
  now. - Konrad, Bod

- :g/CAM_CC/s//CAMCC/g - Bod

Link: https://git.codelinaro.org/bryan.odonoghue/kernel/-/commits/clk-for-6.7-camcc-sc8280xp-v3
 
V2:

I've expanded the scope of this series to include some fixups for the
camcc.yaml in general.

- Adds qcom,camcc-common.yaml
  There are a number of repeated patterns in the various camcc yaml
  files which we can contain in a common camcc .yaml instead.
  I used gcc.yaml as a base per Krzysztof's suggestion.

- Adding the common values file I noticed that sm8450 and sm8550 were
  both listed as compatible strings in qcom,sm8450-camcc.yaml.

  This appears to be in error though since sm8450 and sm8550 are
  not compat strings of the same driver but different drivers entirely.

- Switches to indexing, instead of fw_name for clocks - Konrad

- Adds the GCC AHB to the clock index - Bod/Konrad

- Changes reference "cam_cc" to "camcc" throughout camcc-sc8280xp.c

Link: https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/linux-next-26-10-23-sc8280xp-camcc-v2

V1:
This is a bog-standard series to add in the CAMCC for 8280xp.
As a precursor to adding in sc8280xp I thought a bit of tidy up on the
existing yaml for the camcc controllers in general would be worthwhile.

As a result there's a precursor patch which aggregates the various camcc
yaml files into one location.

The sc8280xp looks like sdm845 with more blocks. Similar to sc8280xp we
park GDSC to CXO. Thanks to Dmitry for the suggestion the GDSC parking.

Link: https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/linux-next-23-09-23-sc8280xp-camcc

Bryan O'Donoghue (4):
  dt-bindings: clock: Use gcc.yaml for common clock properties
  dt-bindings: clock: Add SC8280XP CAMCC
  clk: qcom: camcc-sc8280xp: Add sc8280xp CAMCC
  arm64: dts: qcom: sc8280xp: Add in CAMCC for sc8280xp

 .../bindings/clock/qcom,camcc-sm8250.yaml     |   18 +-
 .../bindings/clock/qcom,sc7180-camcc.yaml     |   18 +-
 .../bindings/clock/qcom,sc7280-camcc.yaml     |   18 +-
 .../bindings/clock/qcom,sdm845-camcc.yaml     |   18 +-
 .../bindings/clock/qcom,sm8450-camcc.yaml     |   20 +-
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        |   15 +
 drivers/clk/qcom/Kconfig                      |    9 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/camcc-sc8280xp.c             | 3048 +++++++++++++++++
 .../dt-bindings/clock/qcom,sc8280xp-camcc.h   |  179 +
 10 files changed, 3274 insertions(+), 70 deletions(-)
 create mode 100644 drivers/clk/qcom/camcc-sc8280xp.c
 create mode 100644 include/dt-bindings/clock/qcom,sc8280xp-camcc.h

-- 
2.40.1

