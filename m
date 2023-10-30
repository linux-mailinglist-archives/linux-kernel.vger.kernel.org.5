Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89FE77DB700
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 10:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbjJ3J6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 05:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbjJ3J6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 05:58:25 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16ECFD54
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 02:58:10 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40790b0a224so31257005e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 02:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698659888; x=1699264688; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6RvNyX4Fz2m2NCW/vJbWFjQ+QnaBQUxKKhEUorJSJl0=;
        b=tIqk9XjgzNTQWXw6UpCu4NtGVE22fmRlOtS6gdwu6+Es4L8meM8WSJDI+JDr4mEa6T
         89RuLsaIbdtAGhmWuvKHcoyvcZWnOnHBBF9L3yWOI/DP3mo+rVUabD+UNBeTezH1XKLX
         qM1cS8vPzp9iAjmfqqG44qWJW0Xgg7bvoHe1R9fvOwELLKsFgd11gFS1YFOJ7nb4vs2v
         a3GEd1RAetCOAOC9lrL6NKMkxC2zDaG/zf5pV0TMJJ/rp6QvyNFQEmKKi5h6E/QPy6p3
         iMZAGBf6LvVFIwsy/hYXyUJPEJk8O1ZHQUQ5fVzkdAv7VzhBDjGsRVASk1Q/9gYdZXXG
         wkzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698659888; x=1699264688;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6RvNyX4Fz2m2NCW/vJbWFjQ+QnaBQUxKKhEUorJSJl0=;
        b=KesBR43m3NMl0/FW0wWl13WEkzV1w/pN/zMXz8v4OMz7rsF3rEce903QGAI02uVtyF
         yLRdGxsNtBBnQXBpnWv+BX8k8yw3v0SCdNteH7X20oECd+V6SvPjmu9qCERam+LrtZeE
         rJ1s/ZpDla6lb9OlF6kQjyKyGhq3NVz2CaMUTX/B/Pbsic6DK4LkcD2sv36pvfg+YsOR
         x38jBfdkPo6k/x3uqpekkSSndcuGnsrQGPr94FfVM1oa1aWe415NgZ2wA/Ew4ucuVi6H
         wbI2cTFcMs3sucRcXdIBTe+pNhaKSYKMP7P2Xz+e1Fr1+WueOSicIl9K8/dE0lIvApSc
         J1OQ==
X-Gm-Message-State: AOJu0Yxtpa7HqWl3KdRiBGxi0898XhjT9PqJc9lK5peaO0mtzEajBN0r
        yK9QM/1LR21C6Mby3G8fETeOLA==
X-Google-Smtp-Source: AGHT+IHVgnG31BIbXsxf77gF/KZY1dyMRVY6RzNjOREKSujAw8BcdvmiemRkVE543fNMk59etCHgOw==
X-Received: by 2002:a05:600c:3148:b0:405:1c19:b747 with SMTP id h8-20020a05600c314800b004051c19b747mr7855127wmo.15.1698659888512;
        Mon, 30 Oct 2023 02:58:08 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id a1-20020a05600c348100b00402ff8d6086sm8703714wmq.18.2023.10.30.02.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 02:58:08 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 30 Oct 2023 10:57:57 +0100
Subject: [PATCH v2 10/10] clk: qcom: rpmh: add clocks for SM8650
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231030-topic-sm8650-upstream-clocks-v2-10-144333e086a2@linaro.org>
References: <20231030-topic-sm8650-upstream-clocks-v2-0-144333e086a2@linaro.org>
In-Reply-To: <20231030-topic-sm8650-upstream-clocks-v2-0-144333e086a2@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2758;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=mzb8eXlPI1Gd54NRJWBblg1H1qJBOOIUS40Byd3Zn1s=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlP34jn3vc9RS2jfsrkL6krbML8K6U+FbGSVPDWfK+
 wdClqZCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZT9+IwAKCRB33NvayMhJ0ZsED/
 0Xc+ffUoMvOuHDJ6QYKHEXmuZrP8PlF4LlJ1KIgf4MXMpMhvNw3zl6ZITXx8wCw7PB5Ug3kcjVcoC4
 JOh6c7fWh4TsYPiNNyAYPr3/LWoSg/nNLSB66HwQtRBOrnHve/1cBp5TqRjUljx2jCptFKRm3XF9Fr
 hmOG4aVPpqNEFoy2KPRvNjDnj9vIBVtSCGcGMFhUapv9cKF4nNXj5BDlV8fzSQb6D0rQEtgf2qoOoQ
 TFewUyXhvBsCfnzGgvj6+i2txf/ippBYpd2E2Gb98j8JYrU527re1dijkoBvBXTx9LjjiZyp0jSg/f
 +p/fTbbxjnQUH4FamO99NYbblvwoD9KVvbtSXMOWZALgTWve/hjqt1C8Bj8hSMHMcJMy3uLs0tsTFM
 JkaBs4H48RMcmwjpXWu2AFyHon2A96NodLVZPsL7BidgGPV4wbRFgQMoUV5MwhaXpFpqUlGJrUrbnp
 eJHb5nyJl/wg7+DYsuj8VSRGlSWVmdUiYH+jOuuTu5YnQuEQ/JfxWoo+huzdH7viN36M1FT8Q58v5G
 7OJ1DJdDt4HR0FIYPQScXTENxeLmd6yC19DFN4NREg8c/7NCVXvsm+J01W7jwMocQZs3k0X20HdnHC
 xfCG3R++ymj1BYdk/6effKrKUbODJGXrizwkVI1UE7b5wjnaKXBcCPQ+iEhw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add RPMH Clocks for the SM8650 platform.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/clk/qcom/clk-rpmh.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
index 5d853fd43294..bb09170600ec 100644
--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -372,6 +372,8 @@ DEFINE_CLK_RPMH_VRM(clk3, _a1, "clka3", 1);
 DEFINE_CLK_RPMH_VRM(clk4, _a1, "clka4", 1);
 DEFINE_CLK_RPMH_VRM(clk5, _a1, "clka5", 1);
 
+DEFINE_CLK_RPMH_VRM(clk4, _a2, "clka4", 2);
+DEFINE_CLK_RPMH_VRM(clk5, _a2, "clka5", 2);
 DEFINE_CLK_RPMH_VRM(clk6, _a2, "clka6", 2);
 DEFINE_CLK_RPMH_VRM(clk7, _a2, "clka7", 2);
 DEFINE_CLK_RPMH_VRM(clk8, _a2, "clka8", 2);
@@ -630,6 +632,37 @@ static const struct clk_rpmh_desc clk_rpmh_sm8550 = {
 	.num_clks = ARRAY_SIZE(sm8550_rpmh_clocks),
 };
 
+static struct clk_hw *sm8650_rpmh_clocks[] = {
+	[RPMH_CXO_CLK]		= &clk_rpmh_bi_tcxo_div2.hw,
+	[RPMH_CXO_CLK_A]	= &clk_rpmh_bi_tcxo_div2_ao.hw,
+	[RPMH_LN_BB_CLK1]	= &clk_rpmh_clk6_a2.hw,
+	[RPMH_LN_BB_CLK1_A]	= &clk_rpmh_clk6_a2_ao.hw,
+	[RPMH_LN_BB_CLK2]	= &clk_rpmh_clk7_a2.hw,
+	[RPMH_LN_BB_CLK2_A]	= &clk_rpmh_clk7_a2_ao.hw,
+	[RPMH_LN_BB_CLK3]	= &clk_rpmh_clk8_a2.hw,
+	[RPMH_LN_BB_CLK3_A]	= &clk_rpmh_clk8_a2_ao.hw,
+	[RPMH_RF_CLK1]		= &clk_rpmh_clk1_a1.hw,
+	[RPMH_RF_CLK1_A]	= &clk_rpmh_clk1_a1_ao.hw,
+	[RPMH_RF_CLK2]		= &clk_rpmh_clk2_a1.hw,
+	[RPMH_RF_CLK2_A]	= &clk_rpmh_clk2_a1_ao.hw,
+	/*
+	 * The clka3 RPMh resource is missing in cmd-db
+	 * for current platforms, while the clka3 exists
+	 * on the PMK8550, the clock is unconnected and
+	 * unused.
+	 */
+	[RPMH_RF_CLK4]		= &clk_rpmh_clk4_a2.hw,
+	[RPMH_RF_CLK4_A]	= &clk_rpmh_clk4_a2_ao.hw,
+	[RPMH_RF_CLK5]		= &clk_rpmh_clk5_a2.hw,
+	[RPMH_RF_CLK5_A]	= &clk_rpmh_clk5_a2_ao.hw,
+	[RPMH_IPA_CLK]		= &clk_rpmh_ipa.hw,
+};
+
+static const struct clk_rpmh_desc clk_rpmh_sm8650 = {
+	.clks = sm8650_rpmh_clocks,
+	.num_clks = ARRAY_SIZE(sm8650_rpmh_clocks),
+};
+
 static struct clk_hw *sc7280_rpmh_clocks[] = {
 	[RPMH_CXO_CLK]      = &clk_rpmh_bi_tcxo_div4.hw,
 	[RPMH_CXO_CLK_A]    = &clk_rpmh_bi_tcxo_div4_ao.hw,
@@ -837,6 +870,7 @@ static const struct of_device_id clk_rpmh_match_table[] = {
 	{ .compatible = "qcom,sm8350-rpmh-clk", .data = &clk_rpmh_sm8350},
 	{ .compatible = "qcom,sm8450-rpmh-clk", .data = &clk_rpmh_sm8450},
 	{ .compatible = "qcom,sm8550-rpmh-clk", .data = &clk_rpmh_sm8550},
+	{ .compatible = "qcom,sm8650-rpmh-clk", .data = &clk_rpmh_sm8650},
 	{ .compatible = "qcom,sc7280-rpmh-clk", .data = &clk_rpmh_sc7280},
 	{ }
 };

-- 
2.34.1

