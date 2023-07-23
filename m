Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A378775E368
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 18:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjGWQKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 12:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjGWQKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 12:10:14 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A835199D;
        Sun, 23 Jul 2023 09:09:47 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-992ca792065so608324066b.2;
        Sun, 23 Jul 2023 09:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690128561; x=1690733361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=exRmzh7fmIrCoQgVUjB3SY98XR+bPu/NDuT71ASYlFo=;
        b=OrhI6cLh7Vs03GphtlK6DASOeoOMjk1uy08hjtgG+f+SJstHIlPy8GAUserVCFfM/b
         cKMdgjKO6BcBNGIgYLsRkb5sjAxkMVz65OYZGRCwsoI1hg2ZUxazmVlTrxl5qlvmZxwQ
         OAhkW/D4CHGxY7PO920lkccuMbAnbj1mfHU9hjPxqsRrdcKrEs8D76pN/McEg8PJq13H
         cLEgTA1UCVOcb8VT0D570/qy7p6ikxDfUT24vWM+xPJu7djd2rrRfR7S9eG4Hw8IWOaY
         34yK6Cti5Ok1hGGd155OIekehmMCO/Y4qu3JPQm1kH5S7mKJoniWorRIRuCErf9PjWmV
         6ruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690128561; x=1690733361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=exRmzh7fmIrCoQgVUjB3SY98XR+bPu/NDuT71ASYlFo=;
        b=X5HFz73ke0co27XBzl4EeDoBGwYSXCZ6SvL484AsLdF0UtSwmJzA1U2hKiJv3IkoQS
         /D+wjVYDv7O7I8bqf+6Mf59TwL27I3aaS022WarwjVRxvgYDLJafFuM/h2vVFYDmY1WT
         lD/I+g152rLhbOOhxrzs77+XVC/mJDdYbpBgwUG7uKRPLdZoEO1pHZjNhjP7SILrXosu
         sAp+vu2L+1F9q1042jpJPOlSphWQPL8rjBm0fhlG+ZILZL8T+a1BTOCUGT4GiadZf6hB
         p5yeZO2pM740iX4gPrqAYoKSQsPAOA9GOLJXKb2jfWWdJmKJS6B7Gv5Zz74ewI9o0DFi
         Dcmw==
X-Gm-Message-State: ABy/qLbXqfRvL42q949W27YdGwiLTcQrzpTFSkp5XYeepJCuprt+QjLW
        FeXOP7HtnjoL7AI+KYwlzWVFT+8e8Yg=
X-Google-Smtp-Source: APBJJlFkrbi6Fn8ThGpIcYGejDRuRxCSPM90pn7BgogQzFPOaoU8Df1MVeAQJJbzK7SIqijqvm+vdQ==
X-Received: by 2002:a17:906:116:b0:978:928:3b99 with SMTP id 22-20020a170906011600b0097809283b99mr8176810eje.46.1690128560501;
        Sun, 23 Jul 2023 09:09:20 -0700 (PDT)
Received: from localhost.localdomain (ccx116.neoplus.adsl.tpnet.pl. [83.30.147.116])
        by smtp.gmail.com with ESMTPSA id u16-20020a170906951000b0099b4d86fbccsm5425039ejx.141.2023.07.23.09.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 09:09:20 -0700 (PDT)
From:   Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] MSM8976 PLL,RPMPD and DTS changes
Date:   Sun, 23 Jul 2023 18:08:19 +0200
Message-Id: <20230723160827.22660-1-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series fixes introduce support for msm8976 pll,
also brings some adjustments and fixes domains setup and few dts nitpicks.

Changes since v1
================
1. Fixed few styling issues
2. Changed compatibles for plls
3. Added fixes: tag to first patch

Adam Skladowski (7):
  drivers: soc: qcom: rpmpd: Fix MSM8976 power domains setup
  clk: qcom: clk-hfpll: Configure l_val in init when required
  clk: qcom: hfpll: Allow matching pdata
  dt-bindings: clock: qcom,hfpll: Document MSM8976 compatibles
  clk: qcom: hfpll: Add MSM8976 PLL data
  arm64: dts: qcom: msm8976: Split lpass region
  arm64: dts: qcom: msm8976: Fix smsm ipc bit shifts

 .../devicetree/bindings/clock/qcom,hfpll.txt  |  3 +
 arch/arm64/boot/dts/qcom/msm8976.dtsi         | 11 +++-
 drivers/clk/qcom/clk-hfpll.c                  |  4 ++
 drivers/clk/qcom/clk-hfpll.h                  |  1 +
 drivers/clk/qcom/hfpll.c                      | 59 ++++++++++++++++++-
 drivers/soc/qcom/rpmpd.c                      | 27 ++++-----
 6 files changed, 83 insertions(+), 22 deletions(-)

-- 
2.25.1

