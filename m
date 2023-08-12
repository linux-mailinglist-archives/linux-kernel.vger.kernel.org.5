Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE30779FAA
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 13:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237211AbjHLL1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 07:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237172AbjHLL1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 07:27:06 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195AD110;
        Sat, 12 Aug 2023 04:27:10 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9bee2d320so43213491fa.1;
        Sat, 12 Aug 2023 04:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691839628; x=1692444428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2FPYeGSM+ikrW2+6eEObHASzzNVFf8bno9y81D0RwTc=;
        b=KWE7bU/NXJYaOUFC2oPlr0cuQS/4m1pXxsmXzlDfDhwDmaYeO8U/t3X4no+pNpKdeY
         VBVKiAeA2aFdMP8b7/sqtk+In/KBV3S2Xd6d5A6jAIVIg/cOYhX4I+tqb/PqvBZBCk+o
         y8BLjpyEXyajnejD37zODFlHFaKZpgIUoDxIqWOw3BYx7T4TuPbM2WDXcsgQp2m3tY9z
         RJ5VrjFcBqi0rkOJyv0LGeLa3Z0A0uef7LitjaPft+adO457NFq1Bnx1jFt10ugXxhL2
         SY/UPGE5W7aDzThlLQO127ZeseJk5X8nUwMtpydKTNXP6bTtT0jfwrSSAOqfwE2s/YaP
         dNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691839628; x=1692444428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2FPYeGSM+ikrW2+6eEObHASzzNVFf8bno9y81D0RwTc=;
        b=UKZW2Q73K4ey0a96BrcNl2a6LZBq8bq9/TB8yucVdBbFCFXQOK7B64p9hlfIkpzZpF
         tyC7wARSfg8sj/pEJSFT486rbk40GsLz4+ybksVA2RF9hotEq5aKxYvcuJIXkXwwHtHT
         Jpy91mu6tFIvHhCWwdDkzHsOOOw6GEBobqoYL3p8El4Kr1KhSpyqyhXADs55vbBgehPh
         rmLBfy9t9fG6CxQlsLcfe5Qrcnjvoijx3elkFiYCm0ltqRFiFwkOHjidgDCUWbsfrgLn
         Y1+GoUPp5Ri1h3gMdyEwnll2fzQFitOUerYVPKpRLo/nVt2Y0uC1/f+gL7c+39jf1FBt
         BVpg==
X-Gm-Message-State: AOJu0Yx3h/PVJ87Y1XCqt5TiDR6whkkohs1jTK0/5MAwAEyfmiJoOLEa
        q0XAIhfZZvQIJHjKn8mcWt1WNveteyKvSQ==
X-Google-Smtp-Source: AGHT+IHolk6Tl6KgfTt+xx3RzGEEs3IaARjsaeVRkCXRdcBUFuKR/MN3rWN9Jx8cIQEVXjUEWNbKjw==
X-Received: by 2002:ac2:46ef:0:b0:4f8:680a:68f8 with SMTP id q15-20020ac246ef000000b004f8680a68f8mr2783052lfo.41.1691839628163;
        Sat, 12 Aug 2023 04:27:08 -0700 (PDT)
Received: from localhost.localdomain (bzd150.neoplus.adsl.tpnet.pl. [83.30.49.150])
        by smtp.gmail.com with ESMTPSA id w3-20020ac24423000000b004fe2f085d5csm1087289lfl.299.2023.08.12.04.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 04:27:07 -0700 (PDT)
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
Subject: [PATCH v3 2/7] clk: qcom: clk-hfpll: Configure l_val in init when required
Date:   Sat, 12 Aug 2023 13:24:45 +0200
Message-Id: <20230812112534.8610-3-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230812112534.8610-1-a39.skl@gmail.com>
References: <20230812112534.8610-1-a39.skl@gmail.com>
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

Add support for pre-configuring default frequency multiplier,
this appears to be required on some platforms like MSM8976.
Without configuring L_VAL device reboots when trying to bring PLL up.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/clk-hfpll.c | 4 ++++
 drivers/clk/qcom/clk-hfpll.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/clk/qcom/clk-hfpll.c b/drivers/clk/qcom/clk-hfpll.c
index 86f728dc69e5..705352aff067 100644
--- a/drivers/clk/qcom/clk-hfpll.c
+++ b/drivers/clk/qcom/clk-hfpll.c
@@ -44,6 +44,10 @@ static void __clk_hfpll_init_once(struct clk_hw *hw)
 		regmap_write(regmap, hd->user_reg, regval);
 	}
 
+	/* Write L_VAL from conf if it exist */
+	if (hd->l_val)
+		regmap_write(regmap, hd->l_reg, hd->l_val);
+
 	if (hd->droop_reg)
 		regmap_write(regmap, hd->droop_reg, hd->droop_val);
 
diff --git a/drivers/clk/qcom/clk-hfpll.h b/drivers/clk/qcom/clk-hfpll.h
index 2a57b2fb2f2f..27b9effcb3fd 100644
--- a/drivers/clk/qcom/clk-hfpll.h
+++ b/drivers/clk/qcom/clk-hfpll.h
@@ -18,6 +18,7 @@ struct hfpll_data {
 	u32 status_reg;
 	u8  lock_bit;
 
+	u32 l_val;
 	u32 droop_val;
 	u32 config_val;
 	u32 user_val;
-- 
2.41.0

