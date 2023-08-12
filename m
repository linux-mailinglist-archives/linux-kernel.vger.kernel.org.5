Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA95779F96
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 13:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237167AbjHLL1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 07:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjHLL1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 07:27:03 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536FC110;
        Sat, 12 Aug 2023 04:27:06 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fe426521adso4244232e87.0;
        Sat, 12 Aug 2023 04:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691839624; x=1692444424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LrLDm8EhYfUEnK4RhbnUNMHzrTklLh0zDri9OxXh0HM=;
        b=gva37Gk9U90pwSQWeKYkK8Au/OjnS+YOMBEoG8r6iYskk1vk2HPkK3U/EIA2xz0P8w
         ac2iYm3IsIlRcfEKdhK0B5dCvXmnkZFJ3eqam8/gyPYnKDRzkdxHqkd0UZfOQV6ypGRk
         k6pLk4LrxZ3NbfGg/6q1/j7ymWL5XnmBw2iWOOBF42uPsjnsdD9pq0rmB+zdncsncbiu
         A6hQxLxY4SgvhXZevCIuo8RAxkmNYIG1J2Z9UDUv24uFuA5yqzVd0x7YyvIeYmTe5Bk0
         laScfvHXZreX1zudT6cPAprizc7eLkdIm2pAbGp0u80rmSUeSovQw8mFqQuYoe90vkRU
         XbPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691839624; x=1692444424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LrLDm8EhYfUEnK4RhbnUNMHzrTklLh0zDri9OxXh0HM=;
        b=iyx0zY5TEON1rq4qj4XfiBZLhIowbG44IKFIVCg2SEOIx8QZEwJ2u2JjsYl6NHj1ph
         PXdVrF9gpwpD3JJUVVthvgnuG62b2FVc/HXvy2pFai9Wbm2noj2N2DGTwi0BwnV3NZ05
         3oXCMnfWO0ZGX5ma8pyuo7o1/Hm/yzTKJ58xanqXEtDGys2WYhko06+3YE7eyEMtQhDz
         IjXRY26qwMT6758us2PVNCpft3fmeUQhT7VE2W6PjfclVSO/QaM0A8MxAwaFoYc5tffT
         flpSbyX3TDeRZmI3lIy+fuGYS5vPXfDBxNjeKEgLQuUzxvK7gfPkoJDRRTAyOnEAAxRi
         4Xyw==
X-Gm-Message-State: AOJu0Yyab+dmVxcmDH6Pyqm6XB3ptHM40KdLVTQIL6l3yhu5BT25coix
        acsO3YYhcG1kdAAL9h3escUAEHHLqGvujw==
X-Google-Smtp-Source: AGHT+IF2/cJ7UE3CDLAFj8zZQGzwYdRrLLqmF2U7MPf9xjIQ/WYWZO72FV/pdnvPt37s7gmnZbtDeA==
X-Received: by 2002:a19:7511:0:b0:4f3:b708:f554 with SMTP id y17-20020a197511000000b004f3b708f554mr2786118lfe.47.1691839624225;
        Sat, 12 Aug 2023 04:27:04 -0700 (PDT)
Received: from localhost.localdomain (bzd150.neoplus.adsl.tpnet.pl. [83.30.49.150])
        by smtp.gmail.com with ESMTPSA id w3-20020ac24423000000b004fe2f085d5csm1087289lfl.299.2023.08.12.04.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 04:27:03 -0700 (PDT)
From:   Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
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
Subject: [PATCH v3 0/7] MSM8976 PLL,RPMPD and DTS changes
Date:   Sat, 12 Aug 2023 13:24:43 +0200
Message-Id: <20230812112534.8610-1-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

Changes since v2
================
1. Fixed lacking .data in pll match_data
2. Increased freq supported by A72PLL to include bin2
3. Fixed remaining IPC bits
4. Added R-b tags
5. Changed commit msg for lpass dts patch
6. Rebased patches on next-20230728

Adam Skladowski (7):
  drivers: genpd: qcom: rpmpd: Fix MSM8976 power domains setup
  clk: qcom: clk-hfpll: Configure l_val in init when required
  clk: qcom: hfpll: Allow matching pdata
  dt-bindings: clock: qcom,hfpll: Document MSM8976 compatibles
  clk: qcom: hfpll: Add MSM8976 PLL data
  arm64: dts: qcom: msm8976: Split lpass region
  arm64: dts: qcom: msm8976: Fix ipc bit shifts

 .../devicetree/bindings/clock/qcom,hfpll.txt  |  3 +
 arch/arm64/boot/dts/qcom/msm8976.dtsi         | 15 +++--
 drivers/clk/qcom/clk-hfpll.c                  |  4 ++
 drivers/clk/qcom/clk-hfpll.h                  |  1 +
 drivers/clk/qcom/hfpll.c                      | 59 ++++++++++++++++++-
 drivers/genpd/qcom/rpmpd.c                    | 27 ++++-----
 6 files changed, 85 insertions(+), 24 deletions(-)

-- 
2.41.0

