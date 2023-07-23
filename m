Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EDD75E256
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 16:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjGWOHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 10:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGWOHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 10:07:35 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2915E12B;
        Sun, 23 Jul 2023 07:07:33 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fdea55743eso1748951e87.2;
        Sun, 23 Jul 2023 07:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690121251; x=1690726051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8saTCef6llt0NJWQgsrUOZ7dUSg5iG3l03GS83Z6CnA=;
        b=UaKByqjPo3VFidyVswZ8WFT+tr9LLD4kNn/8xrvqPU+y8eipludLjFvQ10ODQ2z4PV
         XCKWydz4UaN8N2XiXkd44F5jC6dl0X+SiAD/VpooZzQ1r+1vENAFOJZmJ2yi1UMB9f3T
         N6D0vbgJW3etLLAwbiEd4YeJe6w9GxD6gRl8hG2tAGg7A28fM+Ok9/TzEsP/rx7Zh2j1
         VRUa4G6c/Jp3xfHjwms9GDvrxIEyArkhd2i/53zxxw6zVrzE16kXyGZuJ+6w6CejfMRR
         aZjQx1oaw3REfXQFmqRBR0TTJ/lrowB9CcJSJVXWbjuDZ+4ueUNpodbC6eXWMvS50Yf8
         K4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690121251; x=1690726051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8saTCef6llt0NJWQgsrUOZ7dUSg5iG3l03GS83Z6CnA=;
        b=lqO8NtxB2mz7QxvSC5ICawk9QSb7Zvfd7r4/D25/L1nEfCsWCD3TjvjcGHnt/2F2ol
         uF8x/+EAgSpmziCBBd9XVp92XF1SKKWe4nyh5FClFdEc8GAOrlEktK9EirVMFRXvOHGT
         jdMyxwJod02sraUuJokCxJfm+XmAXTGs0qWxFOtjY6RVgeR+HYBU8QafaOe2KhEank7Y
         CzHF0pvfchjH2K+ks3tG0hBhiiVVdSRfYxo8p0zXUgjhTrnt7bbFPuYevaK+NbMd7ZjJ
         YG9kA5ILYVrUSq3jd2DH8Zo4NUq1g0E7oCGXCY/CqSKE/mzzUldzjIGxupluu27OB2Wl
         bFRw==
X-Gm-Message-State: ABy/qLbrp/RGPd9yseYRsNoHJT0pPiUlcicT9fR2kiB/IefRT6yXwiys
        geAnzXfLwFr1WojTZpJB2E5jHLRKYXbDMA==
X-Google-Smtp-Source: APBJJlGOaH0cJAJ3QyZt+L2HmGI9HGiuRSAQIIJfOoUN7n1V3e1iAZdkNueUmuVooVKrB95xCsBLVA==
X-Received: by 2002:a05:6512:1284:b0:4f8:5e65:b61b with SMTP id u4-20020a056512128400b004f85e65b61bmr4100809lfs.65.1690121250910;
        Sun, 23 Jul 2023 07:07:30 -0700 (PDT)
Received: from localhost.localdomain (ccx116.neoplus.adsl.tpnet.pl. [83.30.147.116])
        by smtp.gmail.com with ESMTPSA id o2-20020a05651238a200b004fbcd542888sm1688366lft.60.2023.07.23.07.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 07:07:30 -0700 (PDT)
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
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] MSM8976 PLL,RPMPD and DTS changes.
Date:   Sun, 23 Jul 2023 16:06:47 +0200
Message-Id: <20230723140712.9438-1-a39.skl@gmail.com>
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
 drivers/soc/qcom/rpmpd.c                      | 25 +++-----
 6 files changed, 82 insertions(+), 21 deletions(-)

-- 
2.41.0

