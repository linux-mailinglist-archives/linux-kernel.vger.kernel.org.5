Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D55275E44B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 21:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjGWTII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 15:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGWTIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 15:08:06 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326F41A7;
        Sun, 23 Jul 2023 12:08:03 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3143b72c5ffso3202272f8f.3;
        Sun, 23 Jul 2023 12:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690139281; x=1690744081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rshblnJhusW6XuI78vZ0f2OYejpIOjKqY/oNXeDBMRY=;
        b=TZsY262vvy8JNVZkIbcCbVWa3+p98kfflNYUZ/voRXh+w8axmWCZrXd1K+umweDSiG
         ffN2PFMqgbji1mtLZEft8mDODUz08oo9yacT2nWsAbuE5Jr7Lu95ahAR9xL6WcPMAwoC
         xoLqP24RZVz2fbWujdiMXRQC/E8nVPqem2H7Dwil/TBz9pROk1opToj8chQHVg/tmHNm
         JXLQqDmWWkK2xnu5dRnQiweEyQLZnb+2DisXMuTMncCuP2qWVVlhKKZePGpaD58wlbZg
         kW8zozwb6l04s34CiaTRCQRL9a+mTjbbv5pUhiGqp6bBiRVvb+k0KGt20dhGIytbL9PJ
         +OHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690139281; x=1690744081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rshblnJhusW6XuI78vZ0f2OYejpIOjKqY/oNXeDBMRY=;
        b=ENqxPlvkbit+qoMYN/iAYd1we+XVLvr0jvzT+g8bZNbtcELw5/yRatTZNY1wR3nzG4
         5tQjZzv+P7aXP0yCpHlidOiCnWfgWVmh94Egg0WoU0y07mEgA4PYHXtHLvxiEsgzHFYL
         VGQKZ7gBMr3MxDCh1qvvSz0MG6S+GEVGRsorAmQRa/cRvu0UxOV81ri84tplFI8hTVw4
         JWNBqFdFWZ2x1EW3Uj6q8uBV1hQ4LDzVMNvt3YdBHIA/OPRhKqmC7XXwN/JMTo/UM9pM
         YnbsFNw1fW0XklKEsOF4MXmXzzFOevSfXC1DLZ9rKNSlElq2PhSEwSUBHyCV0oSezjYP
         rJ6A==
X-Gm-Message-State: ABy/qLb1oj0LUl0GKdUHQKLjYTa6LYcatx16fraU1M8kEKPtipYDrWCW
        scQFpb+GC8QgBsn09XSK+O4=
X-Google-Smtp-Source: APBJJlFvl1tVqHXsmtMNT8nBEGsFjUiB25SaL4Qqr84lyPN17G20IgVJcf0dLGysGOqAOxO7Y1JErw==
X-Received: by 2002:adf:f703:0:b0:314:50d:4540 with SMTP id r3-20020adff703000000b00314050d4540mr5868711wrp.18.1690139281454;
        Sun, 23 Jul 2023 12:08:01 -0700 (PDT)
Received: from david-ryuzu.fritz.box ([188.195.170.196])
        by smtp.googlemail.com with ESMTPSA id h19-20020a1ccc13000000b003fbcdba1a63sm2843320wmb.12.2023.07.23.12.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 12:08:00 -0700 (PDT)
From:   David Wronek <davidwronek@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org,
        David Wronek <davidwronek@gmail.com>
Subject: [PATCH v4 0/7] Add initial support for SM7125 and Xiaomi SM7125 platform
Date:   Sun, 23 Jul 2023 21:05:01 +0200
Message-ID: <20230723190725.1619193-1-davidwronek@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces support for the Qualcomm SM7125 SoC and the
Xiaomi SM7125 platform.

Signed-off-by: David Wronek <davidwronek@gmail.com>
---
Changes in v2:
- Allow qcom,board-id and qcom,msm-id properties
- Use QCOM_SCM_VMID_MSS_MSA definition
- Change initial regulator modes from LPM to HPM
- Move status to the bottom of nodes
- Fix up PM6150 interrupts
- Move clk patch to beginning of series
- Fix up copyright
- Take ownership of all commits with permission
- Link to v1: https://lore.kernel.org/all/20230704163848.169853-2-davidwronek@gmail.com/

Changes in v3:
- Disable pm6150 rtc by default
- Fix wrong pm8150l PMIC in joyeuse dts
- Link to v2: https://lore.kernel.org/all/20230706124339.134272-1-davidwronek@gmail.com/

Changes in v4:
- Fix key-vol-down node name
- Link to v3: https://lore.kernel.org/all/20230715091932.161507-1-davidwronek@gmail.com/

---
David Wronek (7):
  clk: qcom: gcc-sc7180: Fix up gcc_sdcc2_apps_clk_src
  dt-bindings: arm: qcom,ids: Add SoC ID for SM7125
  dt-bindings: arm: qcom: Document SM7125 and xiaomi,joyeuse board
  soc: qcom: socinfo: Add SoC ID for SM7125
  arm64: dts: qcom: pm6150: Add resin and rtc nodes
  arm64: dts: qcom: Add SM7125 device tree
  arm64: dts: qcom: Add support for the Xiaomi SM7125 platform

 .../devicetree/bindings/arm/qcom.yaml         |   7 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 arch/arm64/boot/dts/qcom/pm6150.dtsi          |  16 +
 .../boot/dts/qcom/sm7125-xiaomi-joyeuse.dts   |  16 +
 .../boot/dts/qcom/sm7125-xiaomi-miatoll.dtsi  | 423 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm7125.dtsi          |  16 +
 drivers/clk/qcom/gcc-sc7180.c                 |   1 +
 drivers/soc/qcom/socinfo.c                    |   1 +
 include/dt-bindings/arm/qcom,ids.h            |   1 +
 9 files changed, 482 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm7125-xiaomi-joyeuse.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sm7125-xiaomi-miatoll.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sm7125.dtsi

-- 
2.41.0

