Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6ED75E263
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 16:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjGWOHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 10:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjGWOHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 10:07:48 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68D91B8;
        Sun, 23 Jul 2023 07:07:41 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fddd4e942eso4753759e87.3;
        Sun, 23 Jul 2023 07:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690121260; x=1690726060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GnagQxwlD2BGmfp1Y+SwDf/PshNGhc6oxsdbzF1ORog=;
        b=nZuo0QmUECVkywcqjxDoSIprotwScO72FvSS7egFpQApX5HL4xU7FQMxGQoFW6C2ZJ
         H4+ErzP1Xq7+f00pZPHmSuAuJoHExElFgOAJI6uJ+Zo9LfRtkFOWzlFZkL3AX5EivqWb
         Jq8IgfnZ20x1iHCZA7ZGf6pdKGKECCpNvM9jM94jTlwGzoH8R2tEobFpcavnUZoph5DB
         yXGp62Z2D5DqoZidcxTal2sHgfnF1tNTPu3ALUnttBUpgDa60K1Q5FUaVhgHfrxK7FV7
         cXoQghU2TLk3M45TQ/K/H3q6+eV01Q8aW4/3Uok2BPdcd8Fvbu7juinHolw2TftJL3Qf
         2Iug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690121260; x=1690726060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GnagQxwlD2BGmfp1Y+SwDf/PshNGhc6oxsdbzF1ORog=;
        b=WPKwa3MczK+lfAgxUKmV64JUXIcTaStYoPBg9xWQl/czx2uuw7Abtqokg91v5BKGWZ
         CnuHqj/T149ob3T4sOB1sQRrq6JDQt1hhyA2uvmZje3iJwAnWEtHzUTo1I44jEE9fVeP
         vMtbIWnXE7gz8ucSncuvPotLM3HIvRZZ3BAXgr9RwnFVoYsfZgudbBEHGaT+019dL54m
         x7mBadQkHSQe8MnSX4RIJLgfea7o9215y0ZhXPPSGRhHKUqSFEW48r+lqj11iB9Uiyei
         VrKE8nPYKtHOMToFlCEhH1mJ2ueg344f4CjFvMECVNcoa8G+TNnpSvFfmiDXwE/Xtwym
         nZpA==
X-Gm-Message-State: ABy/qLZLSAEXHRV/PLNMcmDUYCLLi0U4+9J+eAkvq69YNaA1UUkd3P5T
        f9Ke4/LkfvAvxLVqEIy+r8eOjqhSqXKhxA==
X-Google-Smtp-Source: APBJJlFj+EYJEQ21PIOegYg0bGgHBZXNghyGxBKofLLed9bm3ysz2uLJPzAcS6QqDFCpXwgBx3QO4A==
X-Received: by 2002:a05:6512:3410:b0:4f8:4245:ed57 with SMTP id i16-20020a056512341000b004f84245ed57mr4399826lfr.35.1690121259947;
        Sun, 23 Jul 2023 07:07:39 -0700 (PDT)
Received: from localhost.localdomain (ccx116.neoplus.adsl.tpnet.pl. [83.30.147.116])
        by smtp.gmail.com with ESMTPSA id o2-20020a05651238a200b004fbcd542888sm1688366lft.60.2023.07.23.07.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 07:07:39 -0700 (PDT)
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
Subject: [PATCH 5/7] clk: qcom: hfpll: Add MSM8976 PLL data
Date:   Sun, 23 Jul 2023 16:06:52 +0200
Message-Id: <20230723140712.9438-6-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230723140712.9438-1-a39.skl@gmail.com>
References: <20230723140712.9438-1-a39.skl@gmail.com>
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

Add PLL configuration for MSM8976 SoC, this SoC offers 3 HFPLL.
Small cluster offers two presets for 652-902Mhz range and 902Mhz-1.47Ghz.
For simplicity only add second range as smaller frequencies can be obtained
via apcs divider or safe parent this also saves us
a hassle of reconfiguring VCO bit and config_val.
A72 and CCI cluster only use single frequency range with their
outputs/post_dividers/vco_bits being static.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 drivers/clk/qcom/hfpll.c | 54 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/clk/qcom/hfpll.c b/drivers/clk/qcom/hfpll.c
index ec18bc8f0089..a9c4c77e0f50 100644
--- a/drivers/clk/qcom/hfpll.c
+++ b/drivers/clk/qcom/hfpll.c
@@ -32,8 +32,62 @@ static const struct hfpll_data hdata = {
 	.max_rate = 2900000000UL,
 };
 
+static const struct hfpll_data msm8976_a53 = {
+	.mode_reg = 0x00,
+	.l_reg = 0x04,
+	.m_reg = 0x08,
+	.n_reg = 0x0c,
+	.user_reg = 0x10,
+	.config_reg = 0x14,
+	.config_val = 0x341600,
+	.status_reg = 0x1c,
+	.lock_bit = 16,
+
+	.l_val = 0x35,
+	.user_val = 0x109,
+	.min_rate = 902400000UL,
+	.max_rate = 1478400000UL,
+};
+
+static const struct hfpll_data msm8976_a72 = {
+	.mode_reg = 0x00,
+	.l_reg = 0x04,
+	.m_reg = 0x08,
+	.n_reg = 0x0c,
+	.user_reg = 0x10,
+	.config_reg = 0x14,
+	.config_val = 0x4e0405d,
+	.status_reg = 0x1c,
+	.lock_bit = 16,
+
+	.l_val = 0x3e,
+	.user_val = 0x100109,
+	.min_rate = 940800000UL,
+	.max_rate = 1843200000UL,
+};
+
+static const struct hfpll_data msm8976_cci = {
+	.mode_reg = 0x00,
+	.l_reg = 0x04,
+	.m_reg = 0x08,
+	.n_reg = 0x0c,
+	.user_reg = 0x10,
+	.config_reg = 0x14,
+	.config_val = 0x141400,
+	.status_reg = 0x1c,
+	.lock_bit = 16,
+
+	.l_val = 0x20,
+	.user_val = 0x100109,
+	.min_rate = 556800000UL,
+	.max_rate = 902400000UL,
+};
+
 static const struct of_device_id qcom_hfpll_match_table[] = {
 	{ .compatible = "qcom,hfpll", &hdata },
+	{ .compatible = "qcom,hfpll-msm8976-a53", &msm8976_a53 },
+	{ .compatible = "qcom,hfpll-msm8976-a72", &msm8976_a72 },
+	{ .compatible = "qcom,hfpll-msm8976-cci", &msm8976_cci },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, qcom_hfpll_match_table);
-- 
2.41.0

